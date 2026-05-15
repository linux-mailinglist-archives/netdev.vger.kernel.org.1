Return-Path: <netdev+bounces-288425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMgTI+xrB2rY2gIAu9opvQ
	(envelope-from <netdev+bounces-288425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:54:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCD2556854
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65FF9300F532
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E947335E1BF;
	Fri, 15 May 2026 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jo0Mkj7K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9600F3E2AB5
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778871264; cv=none; b=IjTRQ/Ex3NcMnb79cJxSvYGrkPmr4AODW4MQLodnSwA4JiOR4s0Yjb3gcGJRwJlNz1WO9VDohDdh43kjn5yr4Sc5mT6evpA9/5swFtcIvoYShLRUJDHS5TCr8zpCApk5GYMMkj3JJadmeUodzaVlnbYfaDDTbsqDrKx+YEqSyrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778871264; c=relaxed/simple;
	bh=nTcZX/DWGU1CpcE+FjZGPqCuDNvpnbdaHyvbqNur18Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R5hdH9KGeSwgz1UM7nZjLgp6SxnrACLDktSSM0ISqFUl72N1534bXVBwyhmHlj/qgAdBwv3pUdFvANp9OEAsaAdSOLF1e9ZWHmWKSJTWcfttPIQDhDMA3AR1hws8udfAMFdaMzByBFQSCU4PAhRL30Lu5uXOF3cTubUeJjy1/4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jo0Mkj7K; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so2585e9.1
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 11:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778871261; x=1779476061; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KiBl3jpGU5FWBix5rYt2GNJNkBPFFyXVwut06neuXAY=;
        b=jo0Mkj7KkFhvaRKJZsQ/2qv3namBH+FycN0TSk7T5xo36peYIfSN6doPhGFmgBjhZ7
         q8fuqO1x40AyKyfqyoLNUnaK0dh1ZVGPelqc16qnuLZAwNtMD9wrjv3M9rccuQoM8IOG
         W0m0rGdci0xq2iiC+f+F/GlqwneUsgSFXrBDsn3Kh7UpJtHeXSePIP/HY2GNJWZLScxL
         iYE2I6k0qAvR2MX4xbBY4Pf8vNXdZYfPfjXEAeeYRDnzMxrhWsrRVu1T6RaruyMVtbVF
         z0NEDEq49fFLPoQtejnOvTBpalicUwI4G11Rq/PQiQQqaE1JiCefkrOsVXOW0WQMqTQE
         7HgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778871261; x=1779476061;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiBl3jpGU5FWBix5rYt2GNJNkBPFFyXVwut06neuXAY=;
        b=K10JfJNnYEfp87og63saSyPcjJB7Bs03/t6DFXOasQvRIoJ2xn5Bgv0WlAfIBM+hKz
         Et/ShgHZOc/db1jiFCYnWLQjrhu0+LDBpfCBLqFUb4YprmQ0OuN/nF4MC4c0+/c6JvYq
         qVBnDN0H9ZXFymxTLsnddsSh4R5+xIcijXlL+RZP/rTNjc74T2vyPeZhQ9EngFqW0sVI
         1ATAHwyixjJnObX++jPvpBiC0eWEq1go3+HFx9sArdJx1lR9YHG7ul5rOQwfngLSqLKz
         SU6inysraGkg+mFQahkpiVXcxXrH/BVJRLB5AHp9Aj81DC2i0PpiLhk5j3JDFl0Wf2jz
         iqXw==
X-Forwarded-Encrypted: i=1; AFNElJ/AijgS//QLBaCDOLx2Ej4y+qWcUm+mh8oWhkp4HMZr1vTuteMG2VfUUATQ8i7z2d0LzHP9r44=@vger.kernel.org
X-Gm-Message-State: AOJu0YysuEALEdD90KEP9h4NWwTz8a9t3ogSs+TuLE7+z7xef3iziUsD
	E4gpV48YqFa2h+O40msax3n9VOBSw/wBEqax3cY4CjRX5AMyfJvNv8Jkbe7nsZDG/A==
X-Gm-Gg: Acq92OGMII6FzxaHxe8CFxtEjy/kPw5jS7fZIYdkwcVADwz+GCJZuR12xpsOE/8p51j
	+48VBkdQ1KzAIEz2WaPdCG4vkhUrnOV03nNcjgxYa/CObDORHHPxWxvt9pqBBSKu7zve9CGGC05
	Vt4/HJ7LPupRR2dkqpyC29Bj2Cg/bFWHZZvfrq/oksD4o7lVys1XlADUjzKhE7b+CQp/NE8qABB
	RaqwmGxnY8OZEJC7pW9dyvS23WxUuQ4elTAVRaTf0W8ZvculLMAP3WykkSXr7BVeSawfNDiOLPc
	Erwu5toCJGBhDGxpm/mF0pBE+WBUzP66DklyYMZ7THaoOfMfBrVQipLv+a5GoxbYFrhbRqdcbh5
	bDRYcldNy8tFzUoWC5RNtMDrzT3HJiQHiirgKqbK3fAKf+X1e8NmgHio+j22lMnq3iEedkTw7FL
	rr3qKaRwNOKRuVcPdaQys7XEM/U0Wr3iJErlMADGn2Qzz0ylcXqnHr2a65S7sKHA==
X-Received: by 2002:a7b:c04a:0:b0:475:d905:9f12 with SMTP id 5b1f17b1804b1-48ff45eae11mr102345e9.4.1778871260631;
        Fri, 15 May 2026 11:54:20 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:7481:4dac:8e80:6e9b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8344asm129308605e9.1.2026.05.15.11.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 11:54:19 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Subject: [PATCH 0/3] af_unix: unix_stream_data_wait() fix and improvements
Date: Fri, 15 May 2026 20:54:07 +0200
Message-Id: <20260515-unix-recv-wait-v1-0-76adb5f063d5@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM9rB2oC/x3MPQqAMAxA4atIZgOtf6BXEYcao2ap0motFO9uc
 fyG9xJ4dsIehiKB4yBeDpuhywJoN3ZjlCUbKlV1qtUt3lYiOqaAj5ELlZ5r09NsiBrI0el4lfg
 Px+l9Px4OcH1gAAAA
X-Change-ID: 20260515-unix-recv-wait-01b3a9cbacc4
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778871255; l=1034;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=nTcZX/DWGU1CpcE+FjZGPqCuDNvpnbdaHyvbqNur18Y=;
 b=UsLE2KYnnrdM7SxVwkNi2ZDes5jTJ8hfwmzSuFDCf54yFtoKJo/06pcoJXES5NiN1y6cVF0zA
 ujNAtJfgTh5A4K86sU70s5RMfNjarjTs8I5KOnWGxHkgYEv26P4nrK0
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=
X-Rspamd-Queue-Id: 2FCD2556854
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_FROM(0.00)[bounces-288425-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Patch 1 fixes a race condition that can lead to a UAF read in
unix_stream_data_wait(). This is a read-only UAF that doesn't have
particularly interesting security consequences, but should still be
fixed. This is a minimal fix, intended to be easy to backport.

Patch 2 cleans up and simplifies this code a bit more (at the cost of
taking the iolock during false wakeups).

Since patch 2 probably increases the impact of false wakeups,
patch 3 is a performance optimization to reduce false wakeups.

Signed-off-by: Jann Horn <jannh@google.com>
---
Jann Horn (3):
      af_unix: Fix UAF read of tail->len in unix_stream_data_wait()
      af_unix: Simplify unix_stream_data_wait()
      af_unix: prevent spurious reader wakeups by writer

 net/unix/af_unix.c | 66 +++++++++++++++++++-----------------------------------
 1 file changed, 23 insertions(+), 43 deletions(-)
---
base-commit: 70eda68668d1476b459b64e69b8f36659fa9dfa8
change-id: 20260515-unix-recv-wait-01b3a9cbacc4

--  
Jann Horn <jannh@google.com>


