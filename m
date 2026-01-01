Return-Path: <netdev+bounces-246487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFF0CED0FB
	for <lists+netdev@lfdr.de>; Thu, 01 Jan 2026 14:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA0453006F70
	for <lists+netdev@lfdr.de>; Thu,  1 Jan 2026 13:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDE825EF87;
	Thu,  1 Jan 2026 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="U02lUXEm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962FA4D8CE
	for <netdev@vger.kernel.org>; Thu,  1 Jan 2026 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767275788; cv=none; b=uD5XrfqahrqPK/koDhsuE1bMPYKLUry+6C22ERIdFDdiKUYXGLAhtQeSAmxplkDNvTgruXfH2x8a91VfeI/h4tc2burOWhzpNLeE2LchdRLJXGBHRgkUp6pVelNxdUBq3iAyBcwyE0h7rzkaoDlYgG4WI6Rm6zdonBHvfwlUte0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767275788; c=relaxed/simple;
	bh=jtnxcAPKtq8edvpsdNZHeInUcs6fhbUz2Suw/7MjB9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ThjlJWkIiy/jCajkYidNbfTN5MnS3NbO3x/vSKDh3+74l85bVmRQ+1ThjTjHahSlo9aXpx7nueOwgF9ZulAvx2oUQV6e8+6wXt7jK+GVMaru5jUO+4eiRbuXeWTkucHQWDeifLY//8N4goaZTTX3SfN39fbcfoG4t/8oW++K4bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=U02lUXEm; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-890228ed342so39422626d6.2
        for <netdev@vger.kernel.org>; Thu, 01 Jan 2026 05:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1767275785; x=1767880585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4F98ib4ryR/EnSK+yzZlP/PUXMJNC/ir0nvPz4WeiE=;
        b=U02lUXEmrBPYkyQkTmqlezyy9p7d/Luw3/ggy+uBdvsCADcU35FxcS1/DXBGDmovo2
         bUxsBmLp48Pg902orxPyJ6UR2xVONUCfH8pLetQub18ebLMjmMu+4kG+SuQenMYHUB6V
         iLG8UG8HSw54JoeYC3anR23HEJMNbrkZ1MrUuzAteJWdRxFnQ6rebNwo2mBh6l4j5Syz
         1vZktfe/Xm5Ifh2zpIiTFdF9UYefjeGK6AzKLL8DpWuVfDuCFwSLOhkfRLdXQBD/2qUd
         4mUxaQNN4QeYesLQhuHJCByfGsIPSrxkUGF5RWLxQM82InZv1e9HuJZ8QxbBNOcufrl9
         YL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767275785; x=1767880585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O4F98ib4ryR/EnSK+yzZlP/PUXMJNC/ir0nvPz4WeiE=;
        b=EyTx1L5Rc+fInGt2xBLC9Y2c2Ipkwhz2LmEag16rN+YPwMYhFTbTQW74c81c5zdTYI
         3OWkCF1qMSNVuu7hPorFpvlw7OQ6JgNlwZwlJZAubuadDEDP5Wx5nf2e/WLobUtpRPn/
         x7Kj9d4XxndNvZe1//o7jvV3CAnUCVITPeYO3YQQeka6w8AKrW91U1BCF2uyGfVQP0oQ
         0lZIAJHyU94xqXYeqRtpnE+lqJbxmNC0999aCdS5K+PEAwUdJAeEQN1cwrBjWEaqwrFU
         iyxAMyW2UYLIVx+Nyi08fEY8A89w6rGvIabr9vFwCSdpNzzTLieBHD48a/BsrPK3ifom
         D3cg==
X-Gm-Message-State: AOJu0YycOdn2bBhaojS+mYVp3ACcus6PSnkCve+5FT+TtPDq/LIhUAmw
	WPS/bqhBSf1Lnsf2sUWUGkQiedFiJX+GWUFtlSV0jjkxxTq1khGCCJEZgO8KgBh7cg==
X-Gm-Gg: AY/fxX4XTClBS3lcy+5/o/i2+WV73dOmZbsAOLezzwbm8d5YQeduFgI12WW5hpdVTNZ
	TuYUTjU97C9zOop9QPzyYx2vblT0j5mMvc4dYlWyrB2IKGuk/ZMVmaCqswWIn2b76pE/4nMox8x
	oC4IdkEWT1YeLyOKADpHwSLcVRNTipl0dGMz/9bOObgCbH+KD8hBbE/ZhoY2YaFEilkbVIOqG9g
	BIIvysCq5Ge3/jWJOrxPmLEoRhDdfRRageWaSUjnLVmmdPLYSdumbC8t6OcQCClOZBZUJsWx3S5
	6YS41lVP02P7zxE82KsoxhCCrma4YT0KDoMFu7SMQd9HYa8/hT/uTLJfhbhg0Yce3T5THs0KLcX
	GH7bGCRz10AAKGU1Lywa5EsFP4metDLgeaTcgssTc+k9whVu/VLnYbQd9ZNzHtPhp8iCKqv+zxB
	9JY7B59HTPMkk=
X-Google-Smtp-Source: AGHT+IGvBY5Nf0g+Tjj90l4nbzasoPfwaQAiSLbQoKWc11z1NmnbOwEqvwByBod5TcI4wRyNxGR10A==
X-Received: by 2002:a05:620a:31a8:b0:8b1:adfd:f850 with SMTP id af79cd13be357-8c08f657bddmr6436241185a.18.1767275785516;
        Thu, 01 Jan 2026 05:56:25 -0800 (PST)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0970f5fcdsm2964577985a.29.2026.01.01.05.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 05:56:24 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v2 1/2] net/sched: act_mirred: Fix leak when redirecting to self on egress
Date: Thu,  1 Jan 2026 08:56:07 -0500
Message-Id: <20260101135608.253079-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260101135608.253079-1-jhs@mojatatu.com>
References: <20260101135608.253079-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whenever a mirred redirect to self on egress happens, mirred allocates a
new skb (skb_to_send). The loop to self check was done after that
allocation, but was not freeing the newly allocated skb, causing a leak.

Fix this by moving the if-statement to before the allocation of the new
skb.

The issue was found by running the accompanying tdc test in 2/2
with config kmemleak enabled.
After a few minutes the kmemleak thread ran and reported the leak coming from
mirred.

Fixes: 1d856251a009 ("net/sched: act_mirred: fix loop detection")
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_mirred.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 4a945ea00197..5ae2f01704ae 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -266,11 +266,22 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
 		goto err_cant_do;
 	}
 
+	want_ingress = tcf_mirred_act_wants_ingress(m_eaction);
+
+	at_ingress = skb_at_tc_ingress(skb);
+	if (dev == skb->dev && want_ingress == at_ingress) {
+		pr_notice_once("tc mirred: Loop (%s:%s --> %s:%s)\n",
+			       netdev_name(skb->dev),
+			       at_ingress ? "ingress" : "egress",
+			       netdev_name(dev),
+			       want_ingress ? "ingress" : "egress");
+		goto err_cant_do;
+	}
+
 	/* we could easily avoid the clone only if called by ingress and clsact;
 	 * since we can't easily detect the clsact caller, skip clone only for
 	 * ingress - that covers the TC S/W datapath.
 	 */
-	at_ingress = skb_at_tc_ingress(skb);
 	dont_clone = skb_at_tc_ingress(skb) && is_redirect &&
 		tcf_mirred_can_reinsert(retval);
 	if (!dont_clone) {
@@ -279,17 +290,6 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
 			goto err_cant_do;
 	}
 
-	want_ingress = tcf_mirred_act_wants_ingress(m_eaction);
-
-	if (dev == skb->dev && want_ingress == at_ingress) {
-		pr_notice_once("tc mirred: Loop (%s:%s --> %s:%s)\n",
-			       netdev_name(skb->dev),
-			       at_ingress ? "ingress" : "egress",
-			       netdev_name(dev),
-			       want_ingress ? "ingress" : "egress");
-		goto err_cant_do;
-	}
-
 	/* All mirred/redirected skbs should clear previous ct info */
 	nf_reset_ct(skb_to_send);
 	if (want_ingress && !at_ingress) /* drop dst for egress -> ingress */
-- 
2.34.1


