Return-Path: <netdev+bounces-203054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC6DAF06CB
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 01:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C69E4443FC2
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 23:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBAB30204C;
	Tue,  1 Jul 2025 23:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SycobtZl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53BE271456
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751411606; cv=none; b=IMJYAhVe4xve8JKOCy4zG+N80iI2vDHzTbLntxaIjk8a5imWDVLCDdLz5ugvfCgBindd70kKiz+5eR2H04vf0Wi6g61erk14EfcHCEHGVVGlaPIdnfkSrc9FS0x1bxvN6IFLfNwPS5TfIn3BlV+IkVO53WvOUCqpiLhKw9dRsV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751411606; c=relaxed/simple;
	bh=J1VBEISZFBDRBG7LydElCYgNKyqnSOSlZ5ugRxP6VtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PlvJUN4wgZsHNe53rwof3UKZQFCs/qYJrLbIKgSqDJfaGxhDH35V+5LcS4hoAum/5fKf643mODfFK6vFnJYpwp/llFueSn/v0dUyvU0Z8FvV62R+r9KArp78Zs0+EbuKdj5asf6bHzuX26cqcbLH841+4q95CD1NIGaqF+07pYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SycobtZl; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b170c99aa49so4911233a12.1
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 16:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751411604; x=1752016404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSBrXXxmLrhcrsObMMdcfiQWvKMKYTTmY7FWijVvxYA=;
        b=SycobtZl6qiZsVgmLkDfbi7e0R8Ufg/fHHOBm5KgtGLsWhrQaX7kVN6NNFrh4k0rlN
         ioS2v/lCPS8XRB32mjnfY2U0PNqOo4EIOft6Km4RCA/jCSx7wVm7nUMuCDi8o8Hjg2hD
         h4MHZahuADt3U+/tVZW1/5PuY5rcN1XnUnuGBuIGz9beQ/ZPuEzuyTheF7Qmn3ngsrPw
         STNOIzqCxSvM+Hm+4ly4E1MYqsMaFG8GHUfvZzCxkVkrWcZUqIaRagBCn0vFvK0jFEaV
         B2VTuzzxTWnQ7CnJjbOpex5o+aaNljs1XumU4Cp6Yit+uUWoRb+otGV+ZxELCR7nafBE
         U5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751411604; x=1752016404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSBrXXxmLrhcrsObMMdcfiQWvKMKYTTmY7FWijVvxYA=;
        b=Ye2ogZlM/E3oqz+G6/IpgBmLZI9cfT1pT9JT2l6pv/J0bTrTD2/vH3/5ekYeGfIzDJ
         E1mOOht/vgXDAplqiPigSDfMxbRmHkVfuj8ph0B3Pd8IGaU8Dhc253Hml3gLMc/YOttq
         aQMZ1XNAwm3ukBEayTpgeq6/lWib93PcYSF5ubytUo65l/KmaXSfsdBenIGjyco3oNaa
         Dtfn0oUPkaV3H4U4yMYvY91revNfCgOQ0TsTKEZL4Go07a79SPJzkP9ETYn077m15Yts
         abde14rSssTgdW+k+DkzO1S4/grjfHEVDQw+piysPF9AHArDus4dmYxSiGStd6qsH/Q4
         hRPQ==
X-Gm-Message-State: AOJu0YxLAUp/a2PJ6RXPw6/nOImJHmaiUGyRpeS/ovzpYOEsUJenCnga
	CYaQuyK+st8CZFdwWkqqggvyaoizdUfeo+ecS8/7p0VCBfXeGtDIeFfp3Eck+g==
X-Gm-Gg: ASbGnctIl7xLKPK+tZtC1s77njZy/cJNSg4QpBtl4BS+uw+Zb5YXSDWn8jPZE83VMCo
	qirIFg/vx5NDsew9mEWHQMIqS9Hb466VhUc1+Z+rkqRfsOjtGwM3cH5bQF+rIbS9PaQhBeuA5+u
	SQh3Q1SYrK/2Yn2syuNb2Y/WlPdD31CQPkYRiO9jFOS49WbjiuJU6urtbVy/hnPB9G1LFwp0Knh
	h3ia9e3A7ZxCWKBdnHC83likGyV7qetgKtuwt/hBjAPdjnR/9OIHy+aZX08miXdKNINvC1po5K8
	K3XgBw2Sm+bvFKeZTqbo7suAKQkJwlOiPdwG2AMGhE1n1g4FbChd0zc/pEjEHpUBVVLxaHdG
X-Google-Smtp-Source: AGHT+IF6Euomf3W2sRMVMPVTkTyGghFg8/iDXMshlSGle/0mMDHs7mjmTAkpJJPBQABKgq8z+JQNnw==
X-Received: by 2002:a17:90b:38d0:b0:311:b0d3:85d with SMTP id 98e67ed59e1d1-31a90b68262mr1081057a91.2.1751411603505;
        Tue, 01 Jul 2025 16:13:23 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f542661asm16685564a91.26.2025.07.01.16.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 16:13:23 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	will@willsroot.io,
	stephen@networkplumber.org,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Savino Dicanosa <savy@syst3mfailure.io>
Subject: [Patch net 1/2] netem: Fix skb duplication logic to prevent infinite loops
Date: Tue,  1 Jul 2025 16:13:05 -0700
Message-Id: <20250701231306.376762-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250701231306.376762-1-xiyou.wangcong@gmail.com>
References: <20250701231306.376762-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch refines the packet duplication handling in netem_enqueue() to ensure
that only newly cloned skbs are marked as duplicates. This prevents scenarios
where nested netem qdiscs with 100% duplication could cause infinite loops of
skb duplication.

By ensuring the duplicate flag is properly managed, this patch maintains skb
integrity and avoids excessive packet duplication in complex qdisc setups.

Now we could also get rid of the ugly temporary overwrite of
q->duplicate.

Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
Reported-by: William Liu <will@willsroot.io>
Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 include/net/sch_generic.h | 1 +
 net/sched/sch_netem.c     | 7 +++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 638948be4c50..595b24180d62 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1067,6 +1067,7 @@ struct tc_skb_cb {
 	u8 post_ct:1;
 	u8 post_ct_snat:1;
 	u8 post_ct_dnat:1;
+	u8 duplicate:1;
 };
 
 static inline struct tc_skb_cb *tc_skb_cb(const struct sk_buff *skb)
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index fdd79d3ccd8c..33de9c3e4d1b 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -460,7 +460,8 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	skb->prev = NULL;
 
 	/* Random duplication */
-	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
+	if (tc_skb_cb(skb)->duplicate &&
+	    q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
 		++count;
 
 	/* Drop packet? */
@@ -538,11 +539,9 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	 */
 	if (skb2) {
 		struct Qdisc *rootq = qdisc_root_bh(sch);
-		u32 dupsave = q->duplicate; /* prevent duplicating a dup... */
 
-		q->duplicate = 0;
+		tc_skb_cb(skb2)->duplicate = 1;
 		rootq->enqueue(skb2, rootq, to_free);
-		q->duplicate = dupsave;
 		skb2 = NULL;
 	}
 
-- 
2.34.1


