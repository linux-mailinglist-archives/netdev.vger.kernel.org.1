Return-Path: <netdev+bounces-288011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIb8LKriBWqNdAIAu9opvQ
	(envelope-from <netdev+bounces-288011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:56:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C72E543941
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D75330EFF41
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1C4423A9C;
	Thu, 14 May 2026 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="S3+sx5hZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBF042188D
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770096; cv=none; b=rtTdir3IrapWRylWmbjf2h+UUZ5eH13jPO3QlNB16GARlF9sr7iL2rGYrjDTaSpTmLiSjeJ2zS1qpOb6/b4Aq4BeCLaAr7mqjWYlihWLBogUgLinr3U+KyUx5n2SOEvRITfe1F2HpZgcYvuyCKUIA/Zy4g+P/1BvmW882nCQl2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770096; c=relaxed/simple;
	bh=G6KsF6e6/cCfjz3g8002ReHidoPrKCQVPSP7L4un7es=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JNoYWMoNwaUJT7OKkkblPvoxbmhZINjocGQRVyy+Zy8Hfm07nbXYtG8vcsZAD7ityJMwKeHeZk0r8ffc/50SiBxw2jY9Qq2QW8TOOBt6yqkN7Z9bkwHlijwPCLRcn/3ih+pCgMSIHIYKQZnIw3ev8KP1xctVlg17OtOHRjyYSnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=S3+sx5hZ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50d87610513so78022201cf.3
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 07:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1778770091; x=1779374891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S79gcdO9hYpeHoum1cPirgRnDPlPBt5fu+NSUYv0Tvs=;
        b=S3+sx5hZur0YNZVgy4jRyb4hyVSi5SjklyrnqJPPtF+ZXPHc8GDJNcg1NJTV3LL4at
         Zc3bGnjPXlJezA0tRy2QjCnB7WnVTaxXzXGq8zJh60uzqqT6YnrWQHqBZ6RXJvvoodLR
         qqcMroCz3q1pOKEoJwSz5aDPHLMIu0H1hgGnaOeeCX0W0KYUGfAB9/kEJ2bYI5PFCO8H
         +3IcsQUDPrIYKygfajHYIuwwgTySoR6AS94XLla8cEG6exs07t6tBC4YobzL3/DOcwpV
         yfxFtXqxhwVfch00u3LdyWLskbUchxDmEsoCtkb07Y4HDjdOBDHIktU+hFi0BoFAGvpG
         maLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778770091; x=1779374891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S79gcdO9hYpeHoum1cPirgRnDPlPBt5fu+NSUYv0Tvs=;
        b=VFbhZ8kWpkl1lMpmy9gjLMM1hlUQWxalAOXgJkEy9p9Vh03v9w/SQ8ArlDXYjS+A3T
         oGwYYaLkDJVYTpppIHBq7QfxqxcCLjv0noEKayirPoOIHS/1nY4Gp06f8paC+rrueXst
         0aDNqFQLEkO9Sv9NP3yE3v+Z08eD/c9+dX1pCmHulhavSwnh6eLfkNK0CbdLo6stObco
         D5E0p1ahpjq96lECmFBThm10tjE11ZuWGz10E24GsYPGsC1NoejvFYb++7/XhOoTQNxN
         RlJUSIsPO4CkazEO2i8oJLhsU6eqcnv9EpisjxYG96Pw54CTFRQ1qFSb0Eo+zYVFRJyS
         62RA==
X-Gm-Message-State: AOJu0YwkuoCFhwnlgKV6e5GLIjpn473vpnusJtbwOWHtQ60t2Xozv1KW
	1/9bWx8SwNZ7Hmj+c5PHnH7Gw7NXOm5QBkLiqSXqOLYa169fusEv8wfanYtFsScWOv1kFho9y7T
	max8xKA==
X-Gm-Gg: Acq92OGl1JeglN0vXLn/P2JH9vgRwWsklfl0PaJQm8mBtqLHZNsIar4+5ONoak2xk8I
	ykb/M2kUCNu+bdf6UpGRtyaUF6J+hFJcyJvGpD9ZVETviyfxM/r5IFp1N5OwrhxqVi1fLRD88Rx
	j6ieLSWZ6QerVrOoBEgn/EU8x13Wx6kJbVZ2rvX1x7TMJVr4yb3JWnToULSOtrqN6n1/+cA+OKf
	tfs8NfIge2/nS1CXRdweg8+cGj34YzBVtZbsFHoFAXv1Nf+fMzKCKC0R4GZbkXV061HoXKitcqo
	ng+EDc+QWnkcFyk5UmQxgPIPqzACkS48OlHWHCYMP6F/nlXYKlbY4iHyDmyycbK+342ylUf7Z1X
	QUpn92lTm5aix/FM35PoVNV2xVO9B+IGpuvlCucVMSi5QziFx51krTIBzVnBg8qSGFUb1bRb8jh
	DqmD2OgueQ9Ibljp/cFBwsJQJZ4n4O+RGybC3whA==
X-Received: by 2002:ac8:5703:0:b0:50f:135e:d5d with SMTP id d75a77b69052e-516514e9218mr17566341cf.8.1778770090584;
        Thu, 14 May 2026 07:48:10 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456c0a42sm19125461cf.10.2026.05.14.07.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:48:10 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	stephen@networkplumber.org,
	victor@mojatatu.com,
	savy@syst3mfailure.io,
	will@willsroot.io,
	xmei5@asu.edu,
	pctammela@mojatatu.com,
	kuniyu@google.com,
	toke@toke.dk,
	willemdebruijnkernel@gmail.com,
	hxzene@gmail.com
Subject: [PATCH net v5 6/9] net/sched: act_mirred: Fix blockcast recursion bypass leading to stack overflow
Date: Thu, 14 May 2026 10:47:44 -0400
Message-Id: <20260514144747.527175-7-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514144747.527175-1-jhs@mojatatu.com>
References: <20260514144747.527175-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3C72E543941
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288011-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,mojatatu.com,syst3mfailure.io,willsroot.io,asu.edu,toke.dk,gmail.com];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:mid,mojatatu-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

From: "Kito Xu (veritas501)" <hxzene@gmail.com>

tcf_mirred_act() checks sched_mirred_nest against MIRRED_NEST_LIMIT (4)
to prevent deep recursion.  However, when the action uses blockcast
(tcfm_blockid != 0), the function returns at the tcf_blockcast() call
BEFORE reaching the counter increment.  As a result, the recursion
counter never advances and the limit check is entirely bypassed.

When two devices share a TC egress block with a mirred blockcast rule,
a packet egressing on device A is mirrored to device B via blockcast;
device B's egress TC re-enters tcf_mirred_act() via blockcast and
mirrors back to A, creating an unbounded recursion loop:

  tcf_mirred_act -> tcf_blockcast -> tcf_mirred_to_dev -> dev_queue_xmit
  -> sch_handle_egress -> tcf_classify -> tcf_mirred_act -> (repeat)

This recursion continues until the kernel stack overflows.

The bug is reachable from an unprivileged user via
unshare(CLONE_NEWUSER | CLONE_NEWNET): user namespaces grant
CAP_NET_ADMIN in the new network namespace, which is sufficient to
create dummy devices, attach clsact qdiscs with shared blocks, and
install mirred blockcast filters.

 BUG: TASK stack guard page was hit at ffffc90000b7fff8
 Oops: stack guard page: 0000 [#1] SMP KASAN NOPTI
 CPU: 2 UID: 1000 PID: 169 Comm: poc Not tainted 7.0.0-rc7-next-20260410
 RIP: 0010:xas_find+0x17/0x480
 Call Trace:
  xa_find+0x17b/0x1d0
  tcf_mirred_act+0x640/0x1060
  tcf_action_exec+0x400/0x530
  basic_classify+0x128/0x1d0
  tcf_classify+0xd83/0x1150
  tc_run+0x328/0x620
  __dev_queue_xmit+0x797/0x3100
  tcf_mirred_to_dev+0x7b1/0xf70
  tcf_mirred_act+0x68a/0x1060
  [repeating ~30+ times until stack overflow]
 Kernel panic - not syncing: Fatal exception in interrupt

Fix this by incrementing sched_mirred_nest before calling
tcf_blockcast() and decrementing it on return, mirroring the
non-blockcast path.  This ensures subsequent recursive entries see the
updated counter and are correctly limited by MIRRED_NEST_LIMIT.

Fixes: fe946a751d9b ("net/sched: act_mirred: add loop detection")
Signed-off-by: Kito Xu (veritas501) <hxzene@gmail.com>
---
 net/sched/act_mirred.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index dd5e7ea7ef26..2ce7ca6b5cc7 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -453,8 +453,16 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 	tcf_action_update_bstats(&m->common, skb);
 
 	blockid = READ_ONCE(m->tcfm_blockid);
-	if (blockid)
-		return tcf_blockcast(skb, m, blockid, res, retval);
+	m_eaction = READ_ONCE(m->tcfm_eaction);
+	want_ingress = tcf_mirred_act_wants_ingress(m_eaction);
+	if (blockid) {
+		if (!want_ingress)
+			xmit->sched_mirred_dev[xmit->sched_mirred_nest++] = NULL;
+		retval = tcf_blockcast(skb, m, blockid, res, retval);
+		if (!want_ingress)
+			xmit->sched_mirred_nest--;
+		return retval;
+	}
 
 	dev = rcu_dereference_bh(m->tcfm_dev);
 	if (unlikely(!dev)) {
@@ -463,8 +471,6 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 		return retval;
 	}
 
-	m_eaction = READ_ONCE(m->tcfm_eaction);
-	want_ingress = tcf_mirred_act_wants_ingress(m_eaction);
 	if (!want_ingress) {
 		for (i = 0; i < xmit->sched_mirred_nest; i++) {
 			if (xmit->sched_mirred_dev[i] != dev)
-- 
2.34.1


