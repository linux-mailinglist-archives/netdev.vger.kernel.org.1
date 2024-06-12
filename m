Return-Path: <netdev+bounces-102769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D179047F9
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 02:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C61B21C61
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 00:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C50B186A;
	Wed, 12 Jun 2024 00:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LeMTLkLr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE81631
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 00:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718151432; cv=none; b=dXY8hbw6bsSIiVGcBRTQO6o1INRf/Hc0Ie1OSBnI8GBZbNsgfqQTwKPw57vc3IH6wUC0OyIgW25/s81VkFSQsbfAcAPwzeoYWfWJy3WZCWt6LmBXpzg9ieRXDjzpALtD1fRV5kkI3wLXM+G3ggjkn6eDQ7YKmQeRAjFnsceCP00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718151432; c=relaxed/simple;
	bh=/5CStUD3+h5vLHrk8rbpKIF6eAbRF4CgImyTE/vqojM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uk0bD4dQj7TqSz1z/sv1gMQWUa5DIAI9nOZcD9TmWOSBoicAEBjwP/RBTgoP2P+Xcuv3Uw6S9QsSiW8enOhNYfhuo0YBpvpHhdP/zH79lXst473tiONfeOF83CfavKeAolm+xLMBMWiZtwQAJfI+q/+Djo7cTCAXej1rclvRAuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LeMTLkLr; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62a0827391aso115853827b3.1
        for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 17:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718151430; x=1718756230; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NOJsof7BEpZN8Hpp/vHtOuty3r3bM9rd+pyvN7nHOJo=;
        b=LeMTLkLrlS2BGJ6fDSGvuE0i4N/ryIBgdERTBqXuULoMGFVJMVs8dnEA9fqSRoMdT3
         ONutiEOYP1oOk6H7Wjooe6DXB9U971D6dG5uie5dKISL313DqKnjrWlqyGBB5ten1bX+
         VK7YSScu7NKB81ev63jg0ZITKSE4mp01UIeoUDLKSPrNeAaEdPhIcLQvC9IcVOLqeGEG
         2u78JjqNsSSZ5FBop56ESrkgoRlHYkmwPXW5RFu3kps1RTiNL5IBR2hwp2kBOaNO+BGh
         Ozy7tDFBokJpSTeVEIZ84vNjuvLqXeDR+n/2IkdyFhLaC7pP+z4EMXnZraQi+nFKGQr2
         EuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718151430; x=1718756230;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NOJsof7BEpZN8Hpp/vHtOuty3r3bM9rd+pyvN7nHOJo=;
        b=jS2H502QyRnz/xYbODWaycL8ft4or74smoQY76gQKwbkXDQLos6PHCmpNFgEQps5e7
         VNIad3TJ7WW2uDrhSrzobWUJL4amwClaFtEtgWUAb2OD5PmryxDZZrOdy9Sq55cfYMUX
         z6o+stBWwu14KZuKwh5N0DdIimojbUynkX8SbrX7yU69UFIwPOKcdDdsaoH/oRGmiuQB
         6tzY4LGrdIpus/gGmbDQHPH9VxI0IyDJ4RiAvWZVTsxfMG8tq9A0YWc03MqNEf5g4r5M
         WMk936enGmDyb/bWFjIwQIrW2+3pikIxvg0mrTQ6r932Z+DUXJgj1dC26oeOKtltZMV1
         llnQ==
X-Gm-Message-State: AOJu0YzM6G59GeI53mWzgXCQ8rL+NM/23DJQchrSf6smZBA1DFwJKqYM
	9PyY0Me1F+FZlJIOGCypHVk0uPXmQ7wYQPj8xoLBYd+j2JoodYq7DS6Vfbc3SXPCIhbcR3yBzRi
	9/GaR4fvVOodkPprevUpBkmkNHVSxBqJAvORsdQzoS9BRTzMYrIH3OMCJB5ADWYe+pc0tz4oiuD
	jJOMqXT13NdU2LvGqm79BDLMMMMjDScmeHF6CCn+0UniUZUOUY
X-Google-Smtp-Source: AGHT+IFj5q7Yo4YsIJsQrLQYOROHj6YJ7et7llRDI8ZMXDiH4h4WLHCf4vHI/re4F+qzmcJAh1iw3DYuY1CbWUQ=
X-Received: from ziwei-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:9b0])
 (user=ziweixiao job=sendgmr) by 2002:a25:8702:0:b0:dfa:b352:824c with SMTP id
 3f1490d57ef6-dfe66b65314mr59562276.7.1718151428817; Tue, 11 Jun 2024 17:17:08
 -0700 (PDT)
Date: Wed, 12 Jun 2024 00:16:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240612001654.923887-1-ziweixiao@google.com>
Subject: [PATCH net] gve: Clear napi->skb before dev_kfree_skb_any()
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jeroendb@google.com, pkaligineedi@google.com, 
	shailend@google.com, hramamurthy@google.com, willemb@google.com, 
	rushilg@google.com, bcf@google.com, csully@google.com, 
	linux-kernel@vger.kernel.org, stable@kernel.org, 
	Ziwei Xiao <ziweixiao@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

gve_rx_free_skb incorrectly leaves napi->skb referencing an skb after it
is freed with dev_kfree_skb_any(). This can result in a subsequent call
to napi_get_frags returning a dangling pointer.

Fix this by clearing napi->skb before the skb is freed.

Fixes: 9b8dd5e5ea48 ("gve: DQO: Add RX path")
Cc: stable@vger.kernel.org
Reported-by: Shailend Chand <shailend@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Shailend Chand <shailend@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index c1c912de59c7..1154c1d8f66f 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -647,11 +647,13 @@ static void gve_rx_skb_hash(struct sk_buff *skb,
 	skb_set_hash(skb, le32_to_cpu(compl_desc->hash), hash_type);
 }
 
-static void gve_rx_free_skb(struct gve_rx_ring *rx)
+static void gve_rx_free_skb(struct napi_struct *napi, struct gve_rx_ring *rx)
 {
 	if (!rx->ctx.skb_head)
 		return;
 
+	if (rx->ctx.skb_head == napi->skb)
+		napi->skb = NULL;
 	dev_kfree_skb_any(rx->ctx.skb_head);
 	rx->ctx.skb_head = NULL;
 	rx->ctx.skb_tail = NULL;
@@ -950,7 +952,7 @@ int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
 
 		err = gve_rx_dqo(napi, rx, compl_desc, complq->head, rx->q_num);
 		if (err < 0) {
-			gve_rx_free_skb(rx);
+			gve_rx_free_skb(napi, rx);
 			u64_stats_update_begin(&rx->statss);
 			if (err == -ENOMEM)
 				rx->rx_skb_alloc_fail++;
@@ -993,7 +995,7 @@ int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
 
 		/* gve_rx_complete_skb() will consume skb if successful */
 		if (gve_rx_complete_skb(rx, napi, compl_desc, feat) != 0) {
-			gve_rx_free_skb(rx);
+			gve_rx_free_skb(napi, rx);
 			u64_stats_update_begin(&rx->statss);
 			rx->rx_desc_err_dropped_pkt++;
 			u64_stats_update_end(&rx->statss);
-- 
2.45.2.505.gda0bf45e8d-goog


