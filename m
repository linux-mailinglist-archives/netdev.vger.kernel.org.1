Return-Path: <netdev+bounces-299447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lYSDAqr0L2qmJwUAu9opvQ
	(envelope-from <netdev+bounces-299447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:48:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F2068662D
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:48:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TX2eiWkr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299447-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299447-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 819D4301DC0C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE4C3E51EF;
	Mon, 15 Jun 2026 12:48:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190B722538F
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 12:48:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527701; cv=none; b=dStsH5nhcAxCgyUCoEZ1xmdngRvN0/SiUqI66XuJWq2kdBj5kkuK01orzlRLX2esGlM8G5Zi+bbOpek6KVrJHwwyG3dHf7evVZbNsWV8/mBqN0d6OtLp9j9ltvZpBIYDy+8IxRq1+Ek8Lb/nEvjLBVjwmMzVuFI1YDBqp14mCc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527701; c=relaxed/simple;
	bh=Yh7JYanZGhEylZQvuUoONACqmN43f60ihANZS5knGfA=;
	h=Message-ID:Content-Type:MIME-Version:From:To:Cc:Date:Subject; b=lFaH6VgfF/TrHq01EdGl2Fguo+E5ysN0RKIFNC6Z73YFaZWYoUyRxroXN4pcipfuC9miwHLcBZS2t3OVomU4oEppugaTnnpVR6lW07bC6CRJJiqjmJNEolHVDJOHMHKDodV3Sxhi47R3PlEOpGtTvhqDR580pJJ4mUaaBX/QLR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TX2eiWkr; arc=none smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8423f1d8902so1512646b3a.1
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 05:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781527699; x=1782132499; darn=vger.kernel.org;
        h=subject:date:cc:to:from:content-transfer-encoding:mime-version
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=an+NyJhpdAxSbgwZ0j7wPX1XyTG7T96Feh4LnwHfKms=;
        b=TX2eiWkrOFVIPFBLxxGT/7SnCymSzhYujomjsf0lMSifTpsSfxufoghqfY1zRUHZqz
         f1TYNF8VGeN2RAeCBLJLjZJgRv+bPCU7huq8wj5DhdHXBmRni2RcUkM2ReAn+NkWoLqz
         nl0KE6YiNjGGANDsM5l3NWHQBo69XmY4C+j7LAPAlkAeoVnml7sUz0LyV9r+1MGqOwJZ
         2O9Ej+CMTL27YuOUegV5QjoiZkZyTlpQ1FnVvCjQVbnuSd3sn6FyTLz0U8C+xRHp8h7+
         20noZod/+bTPjRsW/swRJ7Ki9mmFeQ1cGf+EYAqyNShqS5PQ2cYPYv74um6IxYQQzRXi
         VMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781527699; x=1782132499;
        h=subject:date:cc:to:from:content-transfer-encoding:mime-version
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=an+NyJhpdAxSbgwZ0j7wPX1XyTG7T96Feh4LnwHfKms=;
        b=iOmCgFZZMul/GBT/FgC8Lp7KVAdGSPcIzAaM7f/2KMWhmo5KdrvEyUCY8yzDU1chin
         DpIT4udSAtgTObSNPLlQzJZRz5/5ZakD03qxsAyyzBXfR2wzx6FVZBjnO3BzfQXDBK5s
         RZ6vW2SCmzT2FnLw5I9v5/2ARz0n16dvyTNutMOhv9iLZ41XpynOyKtpwLcrmQPl3/ec
         uydpuPR82qPKdb6xI/q/ULaQ9aM5cy/PUdiUjvJ3o7SQTCVPDG1nWxwEkMQHy69YRpzu
         FGdp9XKmsfn9GmeolDIm3J1/OiqnxMy7ao2PxiCeBOOY1bK1SZfNPFy6amAwPyqTfGKg
         seHQ==
X-Gm-Message-State: AOJu0Yy3g+jXwdUJw0+6z+FHxxFzAVttFHsta5jpXsHevo6Gr8saiRZq
	uVzwSwpdq7OqMEvfAE2C+affxux1PQ53WtM2h0m8lxuijmGr2Ga8kacPuPIZIcXXsGE=
X-Gm-Gg: Acq92OFSmcqRlOI5BcJM5kMqAh1UM35H8VWg9BgLE40l1Dy3QngTfuTIvQDqmhnzci3
	XsVKU1Ml+/Ph7s1xm4SaqDYqmU6Asr9YVGdnw4BdHSs3Cidi1m8lv2KewSFU0iTk/PDkXIHsGf0
	oBDGGrQXkDwzx1qH61AN7FDdjA/uS7Jc4muyeUzeXVuwDpxMsSB4VFl8mgWQpMy9MIZeIuJqaSU
	O/a8PXWPQYsCEh+iE1aM3eQMYMXCyCYs4yVNk6CrM32qhe8Z7MFepw1LFw9JJ8SqJ3I+WUaEAN2
	QVSzqnzt2oR/Bh2vbDVAeQPQEsgeU0L5xK6JPmw2yv5mBrgE5yGcnHcCS4j5xPwO+GHK17jDYmB
	pGZm7uHH5k6U7PmvYLIv+H9iACPu5NH+4rxzAREh7GBkjZQ7NBQcQ3kfFmnH3pchz5EMqxN5SeK
	7yHDA0WlkiW/RenfcqVzI=
X-Received: by 2002:a05:6a00:23d4:b0:842:2419:6bfe with SMTP id d2e1a72fcca58-844e193a3aamr10771235b3a.7.1781527699379;
        Mon, 15 Jun 2026 05:48:19 -0700 (PDT)
Received: from [127.0.1.1] ([58.240.122.156])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434acffd04sm9949954b3a.26.2026.06.15.05.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 05:48:19 -0700 (PDT)
Message-ID: <6a2ff493.5934d26d.389ef4.d16d@mx.google.com>
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Wayen Yan <win847@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Date: Mon, 15 Jun 2026 20:48:13 +0800
Subject: [PATCH net v2] net: airoha: Fix skb->priority underflow in
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299447-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:horms@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mx.google.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77F2068662D

From b894fc031e307f1b6756ea9fcac98e82e23815e1 Mon Sep 17 00:00:00 2001
From: "Wayen.Yan" <win847@gmail.com>
Date: Sun, 14 Jun 2026 07:30:54 +0800
Subject: [PATCH net v2] net: airoha: Fix skb->priority underflow in
 airoha_dev_select_queue()

In airoha_dev_select_queue(), the expression:

  queue = (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES;

implicitly converts to unsigned arithmetic: when skb->priority is 0
(the default for unclassified traffic), (0u - 1u) wraps to UINT_MAX,
and UINT_MAX % 8 = 7, routing default best-effort packets to the
highest-priority QoS queue. This causes QoS inversion where the
majority of traffic on a PON gateway starves actual high-priority
flows (VoIP, gaming, etc.).

Fix by guarding the subtraction: when priority is 0, map to queue 0
(lowest priority), otherwise apply the original (priority - 1) % 8
mapping.

Fixes: 2b288b81560b ("net: airoha: Introduce ndo_select_queue callback")
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Wayen <win847@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 31cdb11cd7..d476ef83c3 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1933,7 +1933,7 @@ static u16 airoha_dev_select_queue(struct net_device *dev, struct sk_buff *skb,
 	 */
 	channel = netdev_uses_dsa(dev) ? skb_get_queue_mapping(skb) : port->id;
 	channel = channel % AIROHA_NUM_QOS_CHANNELS;
-	queue = (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES; /* QoS queue */
+	queue = skb->priority ? (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES : 0;
 	queue = channel * AIROHA_NUM_QOS_QUEUES + queue;
 
 	return queue < dev->num_tx_queues ? queue : 0;
-- 
2.51.0


