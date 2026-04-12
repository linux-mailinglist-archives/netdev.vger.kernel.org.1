Return-Path: <netdev+bounces-277820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kF1xHqa922lDGAkAu9opvQ
	(envelope-from <netdev+bounces-277820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 17:43:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 166823E491E
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 17:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 522823003809
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 15:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC05220F49;
	Sun, 12 Apr 2026 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbQe/VVV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C3420E334
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776008610; cv=none; b=GPrJ6goIEEiVbk/jvySNgFfZOxHmf6wMNKFBF4wIsqquXYYXXqFtafOP++6sZnfsdeO+tM0jNs1sy8dyHWsvhvqLKd8vrur9JpRuNoCVmMsafIPCwSZLNjbOhT5FqnDmKgFylQ1YPJQVVS9g6t4yLnxI4bz6+XsH8v4b8MxJyn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776008610; c=relaxed/simple;
	bh=Ml0JyuMBLC+eyXqJkZvu3G+jsr/3bxbqYbZe6hnoVnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tuRZFFmEgqmA2vAs0pspg4ysZNDUsS028zZ3Ip+HTIAKLigOMGjusHq07Y/an+lVX0IAoJlrPVFLAb4lDLTWZgJ/Ql8dAAYQiTkiYOLokc/zV/L1TrZBwEU0iIGN+P9MktSc+P/n7fiB04BzeSCmh8BTBZzPZDpEL49FwWa+Njw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbQe/VVV; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c444dbe8eso2080428c88.0
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 08:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776008608; x=1776613408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3CwnngdmGpodhTWfZpNj1gsF3WLOembYZRN7eGMCAdU=;
        b=RbQe/VVV4daYGZ+Q4UAYOUnm89WNzCjsDSZgvkvIOC60NZ8QpcYHovwRPSq8A5L4ut
         qg5mnQtX05NFoZuZYp6OAjjcNebqbx+WJ5yHTzPoWZhiLOs1LWy+nnaHiURxPh4jAL+q
         YWgtAJB5bPAUhzAg4dM26RORXAJwPUc9IWEOLnfH3Rr8zMO2p8UqzP2QFdeVcMUnQfBz
         m6owj3jlu+k/ATUqsrUv591x/fk7zSZTDox7pJ/LJjAt3ng0p1OtVlJ5pOwVuHzuUV5K
         FPXzO+haS5qKz3LWIz/lianwgmJJah/crzllmHiYniReansXeWjjz3rW6diYWHrE/75w
         sCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776008608; x=1776613408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CwnngdmGpodhTWfZpNj1gsF3WLOembYZRN7eGMCAdU=;
        b=T3e213ux+f9uvHLsowY2r40OkVBKtcb31Um5rONXMOP/b8AOdZrSyiRBnAdtOv5fvZ
         +csRkyQG54MZiTdxHiveAPR4TgDjOXkotCg6JXzAWWG8zlCNLlZVPuJibfmg9VxUMokg
         tZ1qoILpvO/UOfiSuBZQ5D4M9uNjYaFCp8cfiwF5IZCGKSZ55fAc6ZqYW+umB5wbgVpd
         j7biE+bcHvmzhth+9rDA2vvHAQOFDC3XITT5sxX1OcJw5gNpYxwYXIhdLiVjf6UJx7+V
         SeYEiN8c3nElcPJF/M2CmoIF6Z8SMTBAo/D1+T/E+G8lb8YZ5up00mA1KBkFbc47O3Qv
         o49Q==
X-Forwarded-Encrypted: i=1; AJvYcCWH93hn7hSCJe03lx3r84d2UdG1lk7wa+VQt1kVJ6MtaSxtZpPkF/cW4f1Cxxfy35oA5kXDVlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTPeJytHMK/wLTTVACXqNxpFdRj7CZRpu/BIOJVzisutfgbidD
	9CU9DqBumAbUskSrluu5sv5lSA845yaAi5QNx1S1j8mLSJ0ly07gGiJR
X-Gm-Gg: AeBDiesux77FZNRzXu2SHVXikMJCvNcN/dm2h9dF0D9q6dSs+GZ9aJA8fqWDqTwKr2b
	5vjtl+SD8Qd8ebrFLXiNvPLU4iveKCKlAiO+jooMr+ehu+ylm7yVfa93Pykiu1F437sA+nboQk+
	x2Tvgv1NzJq2JqqYdzBzjuJKqBHk2BGbsN8G63+CsqR35YiAF06ve2pW3hbJRLXFyEyj+SwnmTH
	ag05/bhQrC1rlUqUbrAwFzitGhDs5gCa1kl72/pRCUj0IatFg5bHpQhkOyNZEfgB+IBHyD1E6cZ
	T1n7/glfYFyPQT9YGYUo+iULPiVq4RcKD6fk6czBMHd/yO8GvG3aCkMkNn9KJ70Fnnv97eJuN4K
	vSucP+eqXHQ0lQft7EVqfClMLM62fBaV2+YpvRpSnptjmO2USL+isElKE2S5DZ6Ox12E8W4IdzY
	E9YZoOkJNF3nbQk9PcdeDjsKVirt5wTL4mrAOCzt19r8ozoztL1+BZmMWqIeKt/0Mzi8kXqF6yo
	hD/kyMLwg==
X-Received: by 2002:a05:7022:eac2:b0:122:153:d161 with SMTP id a92af1059eb24-12c34edbf87mr6885360c88.17.1776008608096;
        Sun, 12 Apr 2026 08:43:28 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c34acb077sm10085853c88.6.2026.04.12.08.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 08:43:27 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Kees Cook <kees@kernel.org>,
	netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] slip: reject VJ frames when no receive slots are allocated
Date: Sun, 12 Apr 2026 08:42:53 -0700
Message-ID: <20260412154252.2060940-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,asu.edu,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277820-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 166823E491E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

slhc_init() allows rslots == 0 and in that case skips the allocation
of comp->rstate, leaving it NULL. Because the struct is zero-initialized
by kzalloc, comp->rslot_limit is also 0.

The receive-side entry points slhc_uncompress() and slhc_remember()
only compare a packet's slot index against rslot_limit, so slot 0
passes the bounds check even though no receive state array exists.
Any VJ-compressed or VJ-uncompressed packet that selects slot 0 then
dereferences the NULL rstate pointer.

This can be reached through PPP by issuing PPPIOCSMAXCID with a value
whose upper 16 bits, after arithmetic right shift, yield -1, making
val2 + 1 == 0 and thus rslots == 0.

 Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
 KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
 RIP: 0010:slhc_uncompress (drivers/net/slip/slhc.c:519)
 Call Trace:
  <TASK>
  ppp_receive_nonmp_frame (drivers/net/ppp/ppp_generic.c:2466)
  ppp_input (drivers/net/ppp/ppp_generic.c:2359)
  ppp_async_process (drivers/net/ppp/ppp_async.c:492)
  tasklet_action_common (kernel/softirq.c:926)
  handle_softirqs (kernel/softirq.c:623)
  run_ksoftirqd (kernel/softirq.c:1055)
  smpboot_thread_fn (kernel/smpboot.c:160)
  kthread (kernel/kthread.c:436)
  ret_from_fork (arch/x86/kernel/process.c:164)
  </TASK>

Add a NULL check on comp->rstate at the entry of slhc_uncompress() and
slhc_remember() so that frames are rejected when no receive slots exist.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/net/slip/slhc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/slip/slhc.c b/drivers/net/slip/slhc.c
index e3c785da3eef..e67052bcab57 100644
--- a/drivers/net/slip/slhc.c
+++ b/drivers/net/slip/slhc.c
@@ -502,6 +502,10 @@ slhc_uncompress(struct slcompress *comp, unsigned char *icp, int isize)
 
 	/* We've got a compressed packet; read the change byte */
 	comp->sls_i_compressed++;
+	if (!comp->rstate) {
+		comp->sls_i_error++;
+		return 0;
+	}
 	if(isize < 3){
 		comp->sls_i_error++;
 		return 0;
@@ -651,8 +655,9 @@ slhc_remember(struct slcompress *comp, unsigned char *icp, int isize)
 
 	/* The packet is shorter than a legal IP header.
 	 * Also make sure isize is positive.
+	 * Reject if no receive slots are configured (rstate is NULL).
 	 */
-	if (isize < (int)sizeof(struct iphdr)) {
+	if (!comp->rstate || isize < (int)sizeof(struct iphdr)) {
 runt:
 		comp->sls_i_runt++;
 		return slhc_toss(comp);
-- 
2.43.0


