Return-Path: <netdev+bounces-247198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D2ECF5AC0
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 22:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44B9B301F251
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 21:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8192D7DD3;
	Mon,  5 Jan 2026 21:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7QP59S3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1C72D0610
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767648616; cv=none; b=Qn34XIRRnUOkIjzvLY1j1RuUQS1in++IR5Vx3T79pqjM1rC1nML40a7rX14nu954fXBFvv90PTAlLZPdg81mKWhYmJ3HQTZZNd60VWBEnvxcX+AP1o+74tqR4C/zLia9rRG656ghpv2IfofhlUQCYWqG1Z3DB5GUWvqXGVBOQZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767648616; c=relaxed/simple;
	bh=BHiL+KXoHcbysNOY6KLyrbE8PDnFpcFn2m13IohvTIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tQS+bbUdycsg64UMGjQHMYNtf/R9g6/KTb4V61hJWjJHKwfh0McH+NKJZXVhAunZN5YyTUEa0ZB+FCVfP1XNux4xHsYwGK5Y4TnxtYjwM63NsafAQicoL7wpuHf+oXq0nxM/ckt1+eVRkhKjeBwgv4JF56bc3bPVgxfhF11KVjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7QP59S3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47798f4059fso521235e9.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 13:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767648613; x=1768253413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GA4+IXe/WrVRqttt3cX2Kp/8yqzKmexXegFMx0tjcA8=;
        b=C7QP59S3eNahtF36XzamO7bAoZQvYKlq+gIhLPA5/r6oM4WBjaR80XXI0i77paRzXo
         Pe3eV9ErUpoWZ6BTBacbRfnC0cbsopASsAV/Eo9XR9bCaZtS+zCuXcDm5snIxZTFDZe7
         xTU91iJ603nuZ7EJbHltf20e93HlAtJpcNK8kL0teDLRMbSyt9QTh3z9vPIQ1yzNq/hO
         fdz+i5JLsy2yDmXA7lZ8DA0FBKibmP9mxdZi99flVUfiYAAXmhtNYdTgWb/OMBU99HwP
         vrsrg3FQMH1aamZBQFedlUdW8zVclg7OCZeZKZ/VBfXAlhaH0Z0Scs1mqAdCfbgw6A9g
         Q0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767648613; x=1768253413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GA4+IXe/WrVRqttt3cX2Kp/8yqzKmexXegFMx0tjcA8=;
        b=M0s0x9I4Q0PUZ4sDN8RbhsCBJkXmgFl1G5De/t4XBkVwgITcQZtsKtnk2R9mdXk1eC
         c9MNLRkEICNb9qMD4YvVh/4/d5LTyvLGu5xWzCtlOUJSinCFyOGtTLNtA3MIllnQ59Ju
         GfbCEWU7DmfMeUHgQ1gt0UpqCI0uUpr2IIabknaxBjAuRYBRRmZ4bVsD6iW91nPXtmrl
         oPEfoxSGcDtQai6i1cqK3er5JXf+2+6BUmZOBS4xRVjYGYV9cEvp2WAA/fbL7racwD+e
         QZSo/v4/YfaGbniJ8xf4QxVKJ+o4nMjd7CFtm8+XQkijWaTFNzb0l6iFPijtASaQj5Rm
         AoPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkEsN+SQS938CC8tCdhmoEvHjp4sk7UJQO5W42SfYXgOJ80NcnhFvzDMy+a79sygIahp4ePLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLO7peXiHbo23Hw/2ZEEt1EE6TZq5r3JmUT7VM1IJnhfJQfLss
	E809XTqKnBUxBkiSauIEhZCLp7O3A9h2raIMFGHeuAhM5gBFU+FveAqh
X-Gm-Gg: AY/fxX4SMeE8w1CIKIvAFmQ68n8mSr2BTFJM5oo7MBhhppBV2axO/CT3D9EVTmPiKTP
	94BP8rOvDzAg2Hd4G3Q96RllKPigbl+brbPaKMzoFrWPjSIlNnTpcmJMndAdBCl4aJeIBLGM0uR
	fkxkM7eDysAHjycIU01k2xihZee8BVei8x8TQSkRDfq7MOA+r0YXDPYJJ8TO/4nc1VJmwnX4i15
	BKQs8BKQBn4T+38HHQXsraR8xPKXDWMVzKIYRFmVZULqaB/rm4EvrXuPtuezUih9krHXEhPy7QJ
	bSoRbINObpsmPDQa15bx57zGxiYyMTL7Lxp+ZsC0BJN2CHKULc4+9ceiOOhJuZwXz/5uBkznnGc
	lA8Zzr2+PRjX61bLrep+xnvFYxGv/OWknN6ifi/cGAL5gaGjmDgDT0NGOBCQl/XrY24kYLf2jlX
	ScEYP1b0qcKGXfCPnAVrm+5InSoN5XTQxEbqA=
X-Google-Smtp-Source: AGHT+IGM83/oM7smR0fad6oyFH2XZEQ5E1KkArDYeP/yHJIxVcqKFv4FNTFUBSOObnE/c5IRL1c8Jg==
X-Received: by 2002:a05:6000:2511:b0:429:b697:1fa with SMTP id ffacd0b85a97d-432bc9cc89amr886924f8f.2.1767648613270;
        Mon, 05 Jan 2026 13:30:13 -0800 (PST)
Received: from thomas-precision3591.. ([2a0d:e487:144e:5eef:4e0a:3841:cee5:ead8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-432bd5df90dsm583536f8f.20.2026.01.05.13.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:30:13 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Chas Williams <3chas3@gmail.com>,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next,v2] atm: idt77252: Use sb_pool_remove()
Date: Mon,  5 Jan 2026 22:29:15 +0100
Message-ID: <20260105212916.26678-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing the manual pool remove with the dedicated function.  This is
safer and more consistent with the rest of the code[1].

[1]; https://lore.kernel.org/all/20250625094013.GL1562@horms.kernel.org/

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


