Return-Path: <netdev+bounces-204685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2605AFBBE7
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 21:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136CE1AA8145
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 19:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2B42676C2;
	Mon,  7 Jul 2025 19:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxqYag5+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3265233133
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751917839; cv=none; b=Iyte9SLJ0xikB3kxsT5Dr8zZ/io8E7ij6Wjsb0xUNY0h1edOFg6hhWxxM0ELcWWjWxv1dnrDt3EGPbrqG61anbDvb3Goh6HrVFrMBa9BHBZiGSOVylKUB1nQaRMxqlLPFY9EpbvymiKnJ97mnNBOx3zLKxkg6QTkXkrexBFHVOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751917839; c=relaxed/simple;
	bh=n+8ygRUvxuPXgQI6FhxNazLbxzKwxoIUriSO+/zykr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UxeCKkHl0PUU0pOfqTXmxTdVqjul9EjOoiqwEyRnnevy1tyUo60im6QPzKr34qzBKkdJ85+QUpWvgAhVzvVMbnCN0A7Tte71lUT/odPExFuJMgvseDEdtodiY3ykiOgP0YpwRNNeoAI1vBxiFwOFzSzrBSupsbBQmc6q5sW7quQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxqYag5+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so3678955b3a.0
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 12:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751917835; x=1752522635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9eCODgmJwCsGd4snoMPFlN2SFUrB4swM7trdxaNN0s=;
        b=FxqYag5+F/Y1eLF01D3yKDznRjPLVxXtnGqU2dSeZPfwgBtO4kBMyvKr4rAL1LiXLs
         jqWgwW1Hd4C0g3D9inEA2KFZg216/tv+APLKylsGdMlmOhQe7VzQP8mlH60/uOBFy6Rm
         UA6yomXrbBLgD6REEAO1pYuok9iiI4pkaEjuvfX5O5+tA+jHUBzs8Z8zCcEDDezZDT5V
         jj1M6nFmUqNMI3dX1lyqh9+TWmWRcU/9xLLOR1SY5jVEtIp+rpuj4MIFF0T4uSI/Q7ga
         +QKQtLC9uwTQUvJRcbhcaki/2eycyJunbxtTFAvyW1/YzLF5pe5pkCOO+Doux0y1TYYB
         n1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751917835; x=1752522635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9eCODgmJwCsGd4snoMPFlN2SFUrB4swM7trdxaNN0s=;
        b=PzlTDJQCU4x5CtRwemeEV81SWQ9Xwq0+kfdwnsTEOQhoZUPfVXD7LBCsGkDiSV60b5
         aYZSCiD7Zijh4seZ3cfi7RXjjLNO+jzyho/AT3Powl4xAKEZ3Pm2fhuKTx0cwGV2ctrT
         T5PewOyRy8pgQYpwUfyyxF8SYjnCOxUbFdYtJwIw3pxSOCiBI2Mg1h+o3idQIpYZuo8v
         BU45d3dIzF16lUlyt4HIJ5YPAvkTdwI50JrhrFkC7R5z+oK84iKCkSNE7jLRpJ55TSWL
         poEHJl3LXYau+7sgn49U9Qtwj3TEgNR/J99ha8eh3I1nYS6xS+HtVNqAHP54G/yQOyg0
         mgLw==
X-Gm-Message-State: AOJu0YxKovASjtdZdyoOgMCKVuDlfmvdolCjQsNL0D2ZlyXDCau9+HZq
	GgO2tQAHUWqAVSaRxrOs7fgSunb4JjsaMrUkMBlD+acFYEcpLEf7RS1+jAojHA==
X-Gm-Gg: ASbGncs6q5ws+Gu0vr9Ydz/5Bx6luAW7/vCLBeD3JjwWvCgOw2CjpZlgqXq8iv4ky3z
	l17h1RUICHQqugH4OVlhITSKwLJrr41/nJtH29rBpUE3vhvm5LshJdYpLa13JZpwOfKdtyfoJSI
	GLr0QI8l75BOT+0ms5APJIBETQ+oiFCF/Z2RUc493XDXhnBX/ysxzPJY4q8YDLs/PHAkbfdJzLW
	3KhHYcKQn69W/Jtc//H2ONr8cz6fKanKEYjttSPCAhKKaeanZlwxUrHmvMm3wd8vvJza81TRZ28
	bjaMQWTf40n9i+A5TjZir38TL9EFPkXl5pjSI8wP6jgTKuYPjAondwcISRhZVPLH+997ubZw
X-Google-Smtp-Source: AGHT+IFpfcB1KZ2qWISxArPH1q2+IF4ozmFbTfVmN2rTOd+PNzyKXvh92FC8KqyBKzHVyTmfKkW5Dw==
X-Received: by 2002:a05:6a00:b96:b0:736:4e14:8ec5 with SMTP id d2e1a72fcca58-74d23c3526dmr880199b3a.11.1751917834730;
        Mon, 07 Jul 2025 12:50:34 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42a2c10sm9648931b3a.136.2025.07.07.12.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 12:50:34 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	will@willsroot.io,
	stephen@networkplumber.org,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Savino Dicanosa <savy@syst3mfailure.io>
Subject: [Patch v2 net 1/2] netem: Fix skb duplication logic to prevent infinite loops
Date: Mon,  7 Jul 2025 12:50:14 -0700
Message-Id: <20250707195015.823492-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250707195015.823492-1-xiyou.wangcong@gmail.com>
References: <20250707195015.823492-1-xiyou.wangcong@gmail.com>
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
index fdd79d3ccd8c..249095ba7f98 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -460,7 +460,8 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	skb->prev = NULL;
 
 	/* Random duplication */
-	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
+	if (!tc_skb_cb(skb)->duplicate &&
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


