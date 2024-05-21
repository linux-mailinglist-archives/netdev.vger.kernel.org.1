Return-Path: <netdev+bounces-97405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C02E8CB556
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 23:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E1D28221F
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 21:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FE946521;
	Tue, 21 May 2024 21:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhfyLM+R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AC51EB2F
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 21:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716326442; cv=none; b=Hm+8SQh2pA3WLIHjEPI647OiQqXu4NhD7n+0r8pwwdiJmOFqmmtpNMzb78A6rrbZq/eQxCtGa87+Feoe33b3UzASZs8ON/Fln4bOHQeo/8sEaxYrW2OviVJOVfTs/0K4TmJTTUFf2Zgi9Jidb+VdtV4vcq4R3W3vU0+isNa1yIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716326442; c=relaxed/simple;
	bh=JLNLprh5cykJ3U4HN9N55z6GEVCh4fdKEWy18ItRWR8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=eUnrgkhP350NmRXpgLkq4dg3NyWiF9svUBW+6AaGTLMn+QUVSCQRKQ+ZAeb7LmGAFqTUz1ppCV2lVB8vS2iisT0jWkwAyb4WrQyO/mndRjoeVax0ETQKBcax5m/BG+rAcpUM1IXwWUWEOOnwL17+t7iIl6R7LbG9rJWy6pAbbg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhfyLM+R; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a5d67064885so461322566b.1
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 14:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716326438; x=1716931238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2MOHmWw+DkoHGl4YZk+NKrSWX9tZSM70f4oQbBpjpI=;
        b=nhfyLM+RWUVICPgkEhaLl1xFf2ROFXogUhxPG8yTnfPsvMXlFru/Wd5xi8RNPW/q+F
         J6FkuQekX1Pb01hQCYAWY8o8InCRCzeka2ydMshMcFRwcaR85ebp0XIUXMvYGrogjPln
         FFWNDadEdV2NLLN+JJXsvMtjJbq3y+TqDc8b5sNRPfwSwF1+dBszGhIQBlMSc11E6Sbh
         iHQkgInzsKCaCAxLVSE+UGz0tPhq5WS43u7Xe+iXhiLd8xlCLymBGvMQzn+iLC8plHrK
         P6eOtjSGpW60gKYj49EAmxgbRnngS6eW3zFSkvsvI50AXNH6PwaKVmexhof2jY+wDVIp
         nXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716326438; x=1716931238;
        h=content-transfer-encoding:cc:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D2MOHmWw+DkoHGl4YZk+NKrSWX9tZSM70f4oQbBpjpI=;
        b=vYfzzKxVJ37pm2aKIHmsd5JZeydtorlxCeDtPj9hk8t5NYg9+jQhJuZDEqVZVvfAEV
         UGEyYHYhu8RbL36X5Fovm5Xd9+nk7ryudRcEP8aYYWiZNYMpCaQyK2B7vrFjCcj1HFtG
         xuFyNUuT674ol6cztscpuRNNZoG5YUwZHuM+EpBHQlvgBHEIoBOIjPs2151+rzGcF7OO
         dZnXaD9F50f539nbt+iLLiddI48EFK0qeRdxvYcBGdqFpQ1TYDg0wAd7psR3zUc6qFtx
         8UzSKt2VqodHrdhL3I9lTqoJJV0nz7PDfZoEEwNX/48NbrUcXQUEpKjMEb9I90kfjTRb
         5/+A==
X-Gm-Message-State: AOJu0YyJjzYXo8bDUudFXEoPnaesS5AgvXWan4meoPVGVg1K7icEIwas
	S3vyScQZqWskft6jcgb1+lNgybZ3TII/jSzUheSEqyuisMi3VU6ZkHx9aR1m
X-Google-Smtp-Source: AGHT+IF1o4585YManG8RzlXeC/DKxU+1Zuw0/HdHgaqxxf6RSUd6H+aysFbC13J+0dlzdNpj52sBQA==
X-Received: by 2002:a17:907:7604:b0:a59:a48e:34 with SMTP id a640c23a62f3a-a6228129972mr1891266b.32.1716326438317;
        Tue, 21 May 2024 14:20:38 -0700 (PDT)
Received: from [192.168.1.227] (186.28.45.217.dyn.plus.net. [217.45.28.186])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b177f0sm1656002966b.209.2024.05.21.14.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 14:20:37 -0700 (PDT)
Message-ID: <574049c5-70a0-4dd3-85c3-40e396d00b2f@gmail.com>
Date: Tue, 21 May 2024 22:20:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ken Milmore <ken.milmore@gmail.com>
Subject: [PATCH net] r8169: Fix possible ring buffer corruption on fragmented
 Tx packets
Content-Language: en-GB
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

An issue was found on the RTL8125b when transmitting small fragmented
packets, whereby invalid entries were inserted into the transmit ring
buffer, subsequently leading to calls to dma_unmap_single() with a null
address.

This was caused by rtl8169_start_xmit() not noticing changes to nr_frags
which may occur when small packets are padded (to work around hardware
quirks) in rtl8169_tso_csum_v2().

To fix this, postpone inspecting nr_frags until after any padding has been
applied.

Fixes: 9020845fb5d6 ("r8169: improve rtl8169_start_xmit")
Signed-off-by: Ken Milmore <ken.milmore@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 86a6d4225bc..86ed9189d5f 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4337,12 +4337,12 @@ static void rtl8169_doorbell(struct rtl8169_private *tp)
 static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 				      struct net_device *dev)
 {
-	unsigned int frags = skb_shinfo(skb)->nr_frags;
 	struct rtl8169_private *tp = netdev_priv(dev);
 	unsigned int entry = tp->cur_tx % NUM_TX_DESC;
 	struct TxDesc *txd_first, *txd_last;
 	bool stop_queue, door_bell;
 	u32 opts[2];
+	unsigned int frags;
 
 	if (unlikely(!rtl_tx_slots_avail(tp))) {
 		if (net_ratelimit())
@@ -4364,6 +4364,7 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 
 	txd_first = tp->TxDescArray + entry;
 
+	frags = skb_shinfo(skb)->nr_frags;
 	if (frags) {
 		if (rtl8169_xmit_frags(tp, skb, opts, entry))
 			goto err_dma_1;
-- 
2.39.2


