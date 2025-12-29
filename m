Return-Path: <netdev+bounces-246228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0314ECE697B
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 12:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC1D1303AEB7
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 11:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EE730BB83;
	Mon, 29 Dec 2025 11:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQbdZzUY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528C330DED8
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 11:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767008734; cv=none; b=pVyCGl6dhuqC9xGawcRAK2Quqxa1A9n2g0xl0ADHtwCp/8tngH9MJFK0aZvB1llV4I9KvPhpBt4vqnu0+XhIcTwP6+1kJva6d1cD0AOvAm5YrdWtuD/DXBGKLjqyFmmsnQ7OrSGvBjTditRV7BgPCECML5dgczauUhlUcO4MaEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767008734; c=relaxed/simple;
	bh=FnqrHBDnkXYFDp1T4K5G7I3G/5qKZlHts3NFEuwPA4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tfdw1loQzwlPcrG2VW9HgTUNSqxtotuVX9I1m8rWyP7wPI33UONIq/oYD7suq5Hf0sJCq/pFoP7WbTr89epnmLcfFVzYMCS4Uo2QVC+6vzdWizcwca9Y1YmqzvSOOrz/z91gkZ4zz+TCVgT9t9a5x5UMJtdAlA3CShMTPx+Pn00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQbdZzUY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47798089d30so5334025e9.1
        for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 03:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767008727; x=1767613527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pd6bT6wJQiLnyABIdP4QbPF8bfvDog3aiJF+bv347cs=;
        b=JQbdZzUYzaOtkIxClCmzUVmBsMggVRdIA+zXF+7w+rK46IF/CsPA4S8vvXqlmlDYFN
         PvNL4HF5e8BYp+tmvmUmuLyT9dtli6Yzxejo/Tkn7TzEzniOoNF7fWS+758n2ysgLU59
         HfzNT50zy94cvtcEciXzUhhAwVNt/gp0P2tgnY/VbwP32XhGhvZ/3BVJf6Zh5HHfpwCm
         MH0zA8D4RNoY+UUfXXvB5m3KDNAcHQgEdMPrOUgIbVwxIfuITVGJAK+ko4FhYD5VKuU0
         WHgt8hYzBMQgDb934znZg7G7TQhWhVpvWTZmAmrIeiPbZgbQpfPekOlGf0QvXBjiwX5D
         kndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767008727; x=1767613527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pd6bT6wJQiLnyABIdP4QbPF8bfvDog3aiJF+bv347cs=;
        b=EbwjAcY8AZvB1q4wlfgzxESQBnnz48W2bmcBnGhYi4zu59mpe5FcwaFN0EEeSeY2uD
         kEYYUlX2LNC2p9UyNFSAlVlsR/AFVGbnk9e/WjF//nBkdM+4VPDJyagvyjd43EQD3Abg
         KqT9GbiE5Z+V4ZahtYLvpzh46R+R/44j0Ho1IFHTLTVs1Sul3odPWS2L23dgX4ZdhW6R
         q5VxcK0Eq2Dzj0U9F7/6EnL0HgHgYlc4gCSAOoTArjfopzfA4oPNVWPUsKTNTRxlFsie
         d39+iRfrX3tg0RA7Ie0pwMWue4MuWy4kYBDfY4ekQ524zt/kfHq63J8YZpBHfIU4STnK
         wYuQ==
X-Forwarded-Encrypted: i=1; AJvYcCViS8ZNc+Qs/LinJL+N521GtlR3rMyqBRuzBrpleVdX1ujo4rCZrwMYZGYygoh1hNcvYoWAo5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1dZxDPuBwOuPsIEWdS7Q72zizQM/DxV71K7Mkw9LxQ9g5o9UV
	QL8ApA+A0i/ZwcIx+ji5930sT88JzomCrzDUnnu4C/ekVfBV9EHHTvJG
X-Gm-Gg: AY/fxX5EdJwUkEAKXHmaZBGpIENxcOQhlXL3mSghWMJNvXouNK1KSOH2qfOYaQbT6YQ
	6wyHrJTPzTcLd/xXJRA1XCCnxVEu1avXxItwhfB0jHlu39aChTSLbG1Hw9cF0Uz0+6UGagyp4tP
	HzGVYr/lKVDYW51YeGui/+KjCeMiWn1p8SMpZ4ZyfCiOb/dRnawXMPw9B+gWL0LUEmKYzEJp/11
	1oISh2co/msymcbsnpc+A4vMOXbPgszB4RXnhreiID6/sVLXHgdlJwuLLZTJgVRSgKs32Df/cS/
	2i/VDfc3/6EBIVfAYEb8FnTIfGkutcVpy+8oH8Lt67fzBiMG8vEwTTsmeMRKEbEktZDqsxepR3f
	Oynl28s1N5QnuSe/aq8KoHIDnZCFE8eqWiBGDlheQuIX/oRMIGZ70TUj6NBC6wOZ0I/yoB2vKxu
	qnHPI0cyh4YgogEROtnz8OobBRH+7gsVgdCwgr6srz16cWq9jI3ridI1CWuqhfZT21OhFmNQK/4
	NHJQnA=
X-Google-Smtp-Source: AGHT+IE4Eqr532WMTP2bycwTtVuomjgtN8fZjVnKc91ifmCm3XzCySyUy/SDSX2M7whbZT2bmdncog==
X-Received: by 2002:a05:600c:3b85:b0:477:a478:3f94 with SMTP id 5b1f17b1804b1-47d1957f7dcmr250652945e9.5.1767008727208;
        Mon, 29 Dec 2025 03:45:27 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-215.paris.inria.fr. [128.93.83.215])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4324eab257asm62738107f8f.38.2025.12.29.03.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 03:45:26 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Chas Williams <3chas3@gmail.com>,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] atm: idt77252: Use sb_pool_remove()
Date: Mon, 29 Dec 2025 12:42:01 +0100
Message-ID: <20251229114208.20653-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing the manual pool remove with the dedicated function.

Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/atm/idt77252.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index f2e91b7d79f0..888695ccc2a7 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -1844,7 +1844,6 @@ add_rx_skb(struct idt77252_dev *card, int queue,
 {
 	struct sk_buff *skb;
 	dma_addr_t paddr;
-	u32 handle;
 
 	while (count--) {
 		skb = dev_alloc_skb(size);
@@ -1876,8 +1875,7 @@ add_rx_skb(struct idt77252_dev *card, int queue,
 			 skb_end_pointer(skb) - skb->data, DMA_FROM_DEVICE);
 
 outpoolrm:
-	handle = IDT77252_PRV_POOL(skb);
-	card->sbpool[POOL_QUEUE(handle)].skb[POOL_INDEX(handle)] = NULL;
+	sb_pool_remove(card, skb);
 
 outfree:
 	dev_kfree_skb(skb);
-- 
2.43.0


