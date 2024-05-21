Return-Path: <netdev+bounces-97408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC348CB624
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 00:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB8A41C21B19
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 22:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC925548F7;
	Tue, 21 May 2024 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faE2gfKh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D42168BD;
	Tue, 21 May 2024 22:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716331555; cv=none; b=JosxkVkezKlpKi3lNKlYY+XKZNbTsyNhjNKcF1DGpy35GEnebnZ46lB8VwlpJsrI6FBVreTyxTtAfaXnUEzi3F/R937BZcx/7X8d7ra8kRCTpigGKIezU+bgK1ozgJwxcKsiLfDp5znHqWaIrAaYQUpn2eRA/oKn0HYGb6HY5AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716331555; c=relaxed/simple;
	bh=1BzhDhIVxLRA0+ifPXNdd7o2JNabNbLm6gHUqOcjKTY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=ZpR00F7kjab20wtRodCnojjw/CkTBp9wwiYa1VtqswJF8zRPKfJBFMWXZmBRWaQDqZ2+zfxd1QXnCobZVSqpxk0NnWDsgljgDFSl0mh+8iUK4/wABGHZhLVYlqqbMYEbH41OAV2wZM7eMHzjicP6Bon5lzW+2C5Ui5bvAANzo6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faE2gfKh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4202cea9a2fso2270595e9.3;
        Tue, 21 May 2024 15:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716331552; x=1716936352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8q6Zk5NTdr845I1qY5dBK8ovLOqZ4cN2xf7WTsdZC0=;
        b=faE2gfKhEttn7wr/KcSyjnH/nAr/oCabjiMzoooaORzX02XqrNyAH5SLPZXTpAzBfw
         NKapsI4cZDJyt07xFKxxVcBHMJShZv4F0Zv4iGf/x9sS72nW6alI4Nv6sxv/g6/5XHq6
         XPD4hF7D1h2/hSyJKa5knUOMLsHggQ2l6p59hUJnC8QyfLXpFlQDh0qIdG9nenZra7/K
         4blxcT7OMMoC7SuN9yx4kaYYcfV16GSsUneLrPeaPUIv4wR1a6EdYaVza7ri4FUXzcOf
         J57DZbqGVH9nJQ4mhb/FnEGKMBHakO0vbATRRf3K1hPsMl38IZlmoJ0k71ZT1iP4WLtc
         xjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716331552; x=1716936352;
        h=content-transfer-encoding:cc:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E8q6Zk5NTdr845I1qY5dBK8ovLOqZ4cN2xf7WTsdZC0=;
        b=vF5YDMEwisOhfsc3GK6dfh0XEss+o+Fe6Qwvyu5KbYewGV4sl4jSOwPRUkWQzUpeIj
         v4x7Ur0e3SuNKxTtbbQ826uumJ0E9kdROV3AFj5IoxQ0oDPH4ZYuHuQcMsuNlFt7ymDz
         r3cdbpoTqqbzliknNpToxzx3WcQpgmlgYlIK/YpStHSyKJVCFnDnCurhitkXyKals+10
         hw+AtXc05BKo0do+Uf+5IXJ2xGO6FfTBqgG6FLURlicwf77rY9xKuchFwJByreHRQjIH
         j+/lIE7rcM3O9pEOkLmvoJEnQevTg8pcPCFEAVHP/zAK1LE1WfeXtyrSN1CYO5nH/Paz
         LCuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZWCXCZOSrGW7OUIGlkkSQMXlcAeFuI2hX828e0/+pQefWAIps1uMGwJkekvvWKhiZ3JuANjPvQs3nUSwRjPLyGQTpPzzZoRbxwZOm
X-Gm-Message-State: AOJu0YxYPdIhfAtDFWMHEuEa0GwSmWf3DsTcSWwzpzjPkVxf1ZvSMcis
	pVPdMkhN/+8WY16Zcw9S5aoRnQNip4fheTCgyYKXZDLS+is5S2PjwdF/aZ8f
X-Google-Smtp-Source: AGHT+IHrI6baNRqkBSMeWuIdQ+rBcQ/nG9hiMm9ZzQmkhOuWNhD5XnDXDrPu6zxVGoLvuH9JrbM6vg==
X-Received: by 2002:a05:600c:1c15:b0:418:5ed2:5aa6 with SMTP id 5b1f17b1804b1-420fd34d36bmr1639445e9.31.1716331552007;
        Tue, 21 May 2024 15:45:52 -0700 (PDT)
Received: from [192.168.1.227] (186.28.45.217.dyn.plus.net. [217.45.28.186])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41ff063d8cesm444085045e9.46.2024.05.21.15.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 15:45:51 -0700 (PDT)
Message-ID: <27ead18b-c23d-4f49-a020-1fc482c5ac95@gmail.com>
Date: Tue, 21 May 2024 23:45:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ken Milmore <ken.milmore@gmail.com>
Subject: [PATCH net v2] r8169: Fix possible ring buffer corruption on
 fragmented Tx packets.
Content-Language: en-GB
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
 "\"David S. Miller\",Eric Dumazet" <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
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
Cc: stable@vger.kernel.org
Signed-off-by: Ken Milmore <ken.milmore@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 86a6d4225bc..9b0ef00b99d 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4337,11 +4337,11 @@ static void rtl8169_doorbell(struct rtl8169_private *tp)
 static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 				      struct net_device *dev)
 {
-	unsigned int frags = skb_shinfo(skb)->nr_frags;
 	struct rtl8169_private *tp = netdev_priv(dev);
 	unsigned int entry = tp->cur_tx % NUM_TX_DESC;
 	struct TxDesc *txd_first, *txd_last;
 	bool stop_queue, door_bell;
+	unsigned int frags;
 	u32 opts[2];
 
 	if (unlikely(!rtl_tx_slots_avail(tp))) {
@@ -4364,6 +4364,7 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 
 	txd_first = tp->TxDescArray + entry;
 
+	frags = skb_shinfo(skb)->nr_frags;
 	if (frags) {
 		if (rtl8169_xmit_frags(tp, skb, opts, entry))
 			goto err_dma_1;
-- 
2.39.2


