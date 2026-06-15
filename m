Return-Path: <netdev+bounces-299351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ihm7JC+sL2p2EQUAu9opvQ
	(envelope-from <netdev+bounces-299351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 09:39:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1F4684422
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 09:39:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ou9FZkhX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299351-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299351-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02E50300EC9E
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 07:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEEC3BE17C;
	Mon, 15 Jun 2026 07:39:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57C6145B3F
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 07:39:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509165; cv=none; b=srB81SUTq3J0MQcFhxKqLvnngNW6nQDH8QBLE5vVf7pOC2NEC8oAhUb8S7bRgEc6RjufKT/rEuvbrFSZxlhQNrPhfYUJOtTAjl4j0F7Np1p1fccGs15pOX/UiYkrVRxgiqmjt2kw/fgBfJ7SDsRgirqE/ehX6Tt0X9pDGtlPIVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509165; c=relaxed/simple;
	bh=XsOF+ksD2Ssq1KVAnWleC9rUm1HJ7I7wyrO6hTFxv5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QIwwtAupYonG9d75CqBwV71Qh1+L6xO32uu6I9UyLEa4Blpo5ef8k8cy5RR6U7ktraU47u/nEVHVSJO366s7GZIxH0ELbHrR8xOgmfxpT8U1jrUaexfOpWUBftksFKj02g0NS2j67WA/Szjku6z7jmnhG5T6tMpWyGGVUg6Kgk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ou9FZkhX; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c40397e3caso28517655ad.2
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 00:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781509163; x=1782113963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ErjRsxDLnQwk8o4LMq0j/er9sDOr3c+Mh91+omcleio=;
        b=ou9FZkhXdwrQMtKlDdLl9weyextM3HShTTbiHKCXsuft3hhnu4GBhe5alVx812AhvQ
         0q/pjNMqys+8jc64h2ltQCKGjq4iiVaHm1g1Xeoxmv6ur9B4MHwFfvIuatx9GJFeVc9j
         pak9EAcsb1PLNLefxHUFrrh7yMPfb8O4+uaXUBenvkC7HMfdwjlZeWwJDZJE6D84jlZ7
         kPfN6wvos9OkfDIAAALboecmEIQ79DanrYmCTgRstIvVR+ownQ9m5bvbrfisQLoSsVLl
         zHSmkiRj4g/avnnDTAnE35B08VdtibFSnVFqaMB58eAiRbjnYygH0zDlf51GiDWxAnW2
         lLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781509163; x=1782113963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErjRsxDLnQwk8o4LMq0j/er9sDOr3c+Mh91+omcleio=;
        b=R4Lx4T4HAE+lsuuWoFnpHFoGlT8RbFgUDJjSJHkW6qPJWQawPVabWON17wX8L7Lmgh
         XprC27Jsd92ri4RBKwlL6jd9G4/8PxgErryF87LxWAUw0e4OxIO3xU2PdCk8xqo5hZHn
         Q+QH4qFE8zaV6QlOgxx2XZ7B+CpXmQcijl0f+xuieiud6ybgK5u1VIsD0K4Swz/dAiPr
         9M5gq3gOjXDI6HhYB5Iwyac8yHalts5rdOsZYoLh3r41W06p4Sa47dmC2RksUHg8co/Z
         XXkbfQQI/L7Y9XVesX7bXmW2aYAhrZxRUNMDlz9k4+bkSBkGSIDSHLrtbEN0VKq4Md4e
         Uapw==
X-Gm-Message-State: AOJu0YxfEJzY1dR+QmTnPW+CVAP2mLY3+X1WUe5ifL4dNb5+tGnXaa5N
	COhvBq3lwSNOavbaDHg5gsfhMGAOLO2BVYBve16sg9e/Losjv4FqL9f2
X-Gm-Gg: Acq92OFFu348kKhE9H5HkmntiFTqTGkP1+qjWZvfpbZBPuUEHg8oTq8ZubKiVhoaVB7
	ezuHxfdUx/InRvzclkSIekiXB2MNxRZkbnYY5v22dtJK6oyUSMgI2t6iH30xzyDaIiOqPb0wqQ6
	RbVxwkIU0p8+p5gs/GzBPbLhVo1OMNOA7QUDQVW/AFWGMg2l9GKiiQewktuB95i7LLdygO+6RSX
	hF19dpp7r3X2ix1kaUu5Ok/Xf3DmCR++HuqPwtzTwpJmxyfGlH3MFA8fZdzVpqor41uU3TvWfS2
	41IMd4XaggNPMYpRkyoB7DlkjSYGPSkBbfcxocTOUgIg2+cuAdfIgnJiyGN3h4RuafxOjyYRZZ0
	8hJjEu/1H3XZTAVQeK65exkCE6Z9M12vC2YSgeXsQQPyn7W7Jb1H40J7WC6D3SmlubR7FWUOJux
	7q1X6XGd6VfC5cR3IA9dQgXZHn6GL6ue/oR1S5JNUpycT0BGambr8fMmCM1YiY0wg=
X-Received: by 2002:a17:902:c401:b0:2c2:27be:39aa with SMTP id d9443c01a7336-2c411d7b1efmr139013815ad.17.1781509163251;
        Mon, 15 Jun 2026 00:39:23 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a304:100::209f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c43307a259sm91271345ad.68.2026.06.15.00.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 00:39:22 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	paul.chaignon@gmail.com,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf 0/2] Fix partial copy of non-linear skb test_run output
Date: Mon, 15 Jun 2026 15:38:54 +0800
Message-ID: <20260615073856.152479-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299351-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:paul.chaignon@gmail.com,m:sun.jian.kdev@gmail.com,m:paulchaignon@gmail.com,m:sunjiankdev@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB1F4684422

This series fixes BPF_PROG_TEST_RUN copy-out handling for non-linear skbs
when userspace provides a short data_out buffer.

Patch 1 fixes bpf_test_finish() to compute the skb linear head copy length
from the skb layout instead of deriving it from the clamped copy size.

Patch 2 adds a selftest covering a non-linear skb with a short data_out
buffer. The test checks that test_run returns -ENOSPC, reports the full
packet length through data_size_out, and copies the packet prefix into
data_out.

Tested with:

./test_progs -t skb_load_bytes
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

./test_progs -t skb_load_bytes -v
test_nonlinear_data_out_partial:PASS:nonlinear_partial_err
test_nonlinear_data_out_partial:PASS:nonlinear_partial_data_size_out
test_nonlinear_data_out_partial:PASS:nonlinear_partial_data_out
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

./test_progs -t skb
Summary: 14/92 PASSED, 0 SKIPPED, 0 FAILED

Sun Jian (2):
  bpf: Fix partial copy of non-linear skb test_run output
  selftests/bpf: Cover partial copy of non-linear skb test_run output

 net/bpf/test_run.c                            | 11 +++---
 .../selftests/bpf/prog_tests/skb_load_bytes.c | 35 +++++++++++++++++++
 2 files changed, 39 insertions(+), 7 deletions(-)

-- 
2.43.0


