Return-Path: <netdev+bounces-297915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ha0fM6M6KmoOkwMAu9opvQ
	(envelope-from <netdev+bounces-297915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 06:33:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B8166E320
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 06:33:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KvPrFEqj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297915-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297915-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB4B7301F48C
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A42348C71;
	Thu, 11 Jun 2026 04:33:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B505F331EBB
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 04:33:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781152415; cv=none; b=JI/0kxEAJbU0lPbM4JYacq+B0N2ccJnS3/3StkZDIWJrQHud2rr9KfV45Ek+PqogSYhn54cbYiPH21Una0Q/mgvzhxc/XiKcuGfZgaHmxqJwdfki9aiMP/3pl/XK9V+2WwsTkz1w26II4Sb733zP+yyk0qTc6yslDK7pk8+Jifg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781152415; c=relaxed/simple;
	bh=/W0U/udYLncDv9LsEfSV4QGDZWt1TafOfr/YSKBgyfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IfDOjxId1T2zlg/8qdu7YrdHiMPD8g39Hh1awjHT1oNMb+UC5Y38pJsRmoDRon1glPH5WWiipmtadlnRY6KFi5O26Sbn6dsTePyYANrM9Kmm8twXkCpnx7SmGQ5soZGJ7cjV6sRhkPNKaCLe0Lx6rSbjL/wbqpp5DD+YSxt91vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvPrFEqj; arc=none smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c0c3546924so50235225ad.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 21:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781152414; x=1781757214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HGo2CfD8GEYYcXOuR9CaVUNmMurmqTJup52Dqz8uepE=;
        b=KvPrFEqjj+TPQabGu8WNhyIlKLuMKw/GRmjnCWxlNMLCTAUPH+GmA5l4u/rKAco7rM
         00zRwDV3YDn5Pq+8oVfL5I4E7O/IQi4DZORcCEJ3x0OomQDH0AQLhBirjDP+suOhusJu
         bRJV8BtWSLFKtOIJ2k2zM8qs9sOgv+TADOBgOBigHNMPgf30zEMHa2gxRGAuL/iq504m
         r02qk/6EWaTKCw9X7QbvjNbnwCYMhO/9xwZpkxAJeTaswStr0w103t5+4fHcz9atlIcZ
         tSuR25wwKNprP2cBkkSasaBv0SJOqeyqSQK0v7qVXn6mJPikDViwvhnMcuxhpUn+ZjvZ
         1DoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781152414; x=1781757214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGo2CfD8GEYYcXOuR9CaVUNmMurmqTJup52Dqz8uepE=;
        b=ggVGcvy6TN8vSulLlqGZyjOGopWUseU/Ov9al8sbTQ5HdVQE6GsmvnAFIF4MSvhNfb
         ljRbkL5CwUjn7qhofjKCNE8jv+dH5kduHkx7koHovL4oMBzy8ZPv8bF39Zk0rgZjmqpj
         JfhXfatRJvMuJf2JHqD8pfe5hLoXq2DtUbx0R1pHdjbCNqEkM84Jz7d4FRMZt/iph4pq
         DvFtJ8gGymSKlv6qFnVKhSmAXH3aXW7Yl+o+SekLVr8n5DNu3W18KvJi3VmzTuZnWXd0
         cDtDuPVqQjoE+cfybZjxgVOJ3/wWzmTvU8UgD/aofjIP9oU9XWHQnaygOoi6nr9lM7ba
         rS1Q==
X-Gm-Message-State: AOJu0YzHk4zHewSWL6CgZcvmXYoPQPBjTymhdQBlt6XULmfsL345wva5
	LxjuRV3yPWJRMQfREsP2/maz7hVlN9819KxUzEkeWAnPzWjXSDEv9aLawfQzvEVk/HA=
X-Gm-Gg: Acq92OEfDMu+yJM5rRl+Kxq6dKFUJC2AJmrFEa+2t+pWkkNMom029Ja/25Rl1dZEqlg
	PzeEa49K5FN1PbT76lxt9iVtnhfDCGSZC5IZWZMp3NqpbMbVFcXYGfNqFNuKYYmxmTmQhmtMcoa
	D7s4dvejyqLYJcGRNeRe96WeQeAmN1LEd6btMSpAK5GnZMY9IsIpcf4vzaAuNY5smPw9TlTDbab
	dCtmYvEIkqfQCDo0e48In9KGZgPgWg+LiXCaw9MSBFYFKjPXD0N0v8JF0Z6DgQsrnzaBp3hnOAj
	kar961Y2+ofji79GSUqnCz3ClN6GeGqo/XzdgOqxDUiDkttbidJsKmuYRaeKx4Q18e+Es2hab9F
	3sktBXdGv5Yff3p2E9nj34+qBz5lduKDV/IWLLK42nZQyIqAuh280RvEk/LZtopkKEJHL3wv2hc
	bFT1wiXlA7ZZHOGhfDT5t8ddbQiojWv+KNQ/6qEmYFX3oOOiqiUe4jsIR6GNgwSYqyEI3H6/8E8
	HIFGubfnpoGkAlmqAnGR1Hft3Jv
X-Received: by 2002:a17:903:acd:b0:2c1:f29a:b554 with SMTP id d9443c01a7336-2c2f21a11f5mr12091875ad.21.1781152414032;
        Wed, 10 Jun 2026 21:33:34 -0700 (PDT)
Received: from u2404-VMware-Virtual-Platform.localdomain ([2a12:a304:100::109f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e05fsm270794455ad.54.2026.06.10.21.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 21:33:33 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	jiayuan.chen@linux.dev,
	toke@redhat.com,
	menglong.dong@linux.dev,
	emil@etsalapatis.com,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v3 0/2] bpf: Fix generic devmap egress skb sharing
Date: Thu, 11 Jun 2026 12:33:15 +0800
Message-ID: <20260611043317.512843-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297915-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:jiayuan.chen@linux.dev,m:toke@redhat.com,m:menglong.dong@linux.dev,m:emil@etsalapatis.com,m:sun.jian.kdev@gmail.com,m:johnfastabend@gmail.com,m:sunjiankdev@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,davemloft.net,gmail.com,fomichev.me,redhat.com,etsalapatis.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40B8166E320

Generic XDP devmap multi redirect can leave cloned skbs sharing packet
data. When a devmap egress program mutates packet data, another
destination sharing the same data may observe that mutation.

Fix this by making cloned skbs private before running the generic devmap
egress program. Add selftest coverage for the last-destination case,
where the final destination runs on the original skb while earlier
destinations use cloned skbs.

---
v3:
- Split the kernel fix and selftest into separate patches.
- Move the private-copy logic into dev_map_bpf_prog_run_skb().
- Use deterministic DEVMAP_HASH keys in the last-destination selftest.
- Fix the Fixes tag.

v2: https://lore.kernel.org/bpf/08c35c70-a59e-4e0e-91db-22b5ec30b611@linux.dev/T/#m613671b243e8651c47f84bb329f0ea668974c549
- Move the private-copy step into dev_map_generic_redirect() so the
  last-destination path is covered as well.
- Use skb_copy() instead of skb_unshare() to keep caller ownership
  unchanged on allocation failure.
- Add a generic XDP last-destination selftest case.

v1: https://lore.kernel.org/bpf/CABFUUZFimdrZdq=NWi+N-0sJZWvMwY=f4iF6-3TVMS8=m07Zmw@mail.gmail.com/

Sun Jian (2):
  bpf: Run generic devmap egress prog on private skb
  selftests/bpf: Cover generic devmap egress last-dst rewrite

 kernel/bpf/devmap.c                           |  21 ++-
 .../selftests/bpf/prog_tests/test_xdp_veth.c  | 152 +++++++++++++++++-
 2 files changed, 168 insertions(+), 5 deletions(-)


base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
-- 
2.43.0


