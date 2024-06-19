Return-Path: <netdev+bounces-104733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF35F90E351
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 08:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25F11C20B28
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 06:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3315B69E;
	Wed, 19 Jun 2024 06:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWl1oe7G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4531E495
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 06:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718778106; cv=none; b=isn2GOAEsLLGvuzkZg5iHjZeLeErCrF3bBngLOaxloRipJL6CDf9vNTu1PiuFTYe3+TdLaywCUI6qXXZIt021FewtwyYD2SIErO8W5Geahxkbs2XAZwgrshL45CdcxYMAimME4sk38BCa00m7tj8MTRc0RT9qYi5z8czFZBdEXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718778106; c=relaxed/simple;
	bh=vl6hlkv1VGFg6/OMqMcDenlwxAZj3aCId20BjS7dXxM=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=B1HDVttZ6LED/aRPVGb+odQLKPhGMIiLFqz+g6TrTQ7H/d7NVXD6QIk8i0C/Kcbv8esVZ5s85qoGHL0ZDsPW9lPOYHROy/Oy6mFdvbK8pp1U1RVkYoWnfZYfoWLNJfwKQoMxpgwkcBH+X0Xc2Y0c9JAdQFP/OEo3PxhMow3vCtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWl1oe7G; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6fe0e23d8a6so551916a12.1
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 23:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718778104; x=1719382904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9G1dKP8Vgp0TOm+lIsQjy/PD3aAyXJkLrAUMw0g1BQM=;
        b=TWl1oe7GoZmwGqY+iQcEvXUBEUrafYviNAlQ1MAq6A/VJG5WPS1hmF322taAiWy6La
         hdktdNTocRbtiHn6cgbwPRtN4jFBSF9tW87q07z6hB0mSLHTUNd+IQ0VAJUEmpCeTAd0
         wLnFRLGSexpZBw3tE/MKwQErjflutW24XYJwyYg0o8Yel8Pj1DPbA4VEs6REdkhUpDw0
         Gtbm4XRFdkN1qHmWf3IwklzaRiYNaY5U5/I4KnBfJgnK6PRop/G7G3DtrmrgE0d2VN7S
         lp+Iur4r59iJ3Ybw/Y5HozGSLeQlDXBw+qPl3lE8QcdrG6D2lsWkBwQWP2+UKPdHCjTt
         yQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718778104; x=1719382904;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9G1dKP8Vgp0TOm+lIsQjy/PD3aAyXJkLrAUMw0g1BQM=;
        b=Amfasqfu5p9w26/46qjpR5QysjVAfCrutWQz+NBZehED68jTHtGsQP5DhnTyvoU7wC
         5PpaIfae3bphwlQQ/kDEzt4TGecArnhL2EtJGIaDrEyE0rwHb1uZc4C53B06jz61Dk42
         MfD+urH7U+jkC0jdtNjRCQuFvu6K7s7idX7IQMwau0wmKTGpnrROq2bwM5YH3w+rx7mk
         yxtV6+XXEtwJjn8/bdAaueFE0I3zs5gS0hHizjrwxofMp28VOybEUgAmmwiZGcKu6mQP
         lqivphPaCA2lsQWbayeukrHGZvj5peKKxT2QDRSZJGc3Bi1kldDvrpV0ZNe6xhJeBDkn
         0JMg==
X-Forwarded-Encrypted: i=1; AJvYcCVEgzYqC01tbp9hT6nh9yCp7ZxNNsr09QojmlDKbWhAVxRQz2fhgPF27tX0E+uBxbDDS53LAo3NL1Y8EkEAPpXICywrX3dx
X-Gm-Message-State: AOJu0Yy7UDXjUfVypjByVIArLh+6uP4QwN2U9USWylBZ1ETJ/hQAzpSd
	RX1RXWGuoMi2/iObpOEWdh54653gclxucuU4bT9OgnaYjIPawUNt
X-Google-Smtp-Source: AGHT+IEgCpEGlqBCMeOTLfvfQIiHbvXLPvXb9MkOyUy+Rf9IYPXHqIi3wRNMME+b5DhEat3UE23cGQ==
X-Received: by 2002:a17:902:fb4c:b0:1f9:b35f:65dc with SMTP id d9443c01a7336-1f9b35f66f0mr5060975ad.6.1718778104058;
        Tue, 18 Jun 2024 23:21:44 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855ee8004sm108234315ad.121.2024.06.18.23.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 23:21:43 -0700 (PDT)
Date: Wed, 19 Jun 2024 15:21:30 +0900 (JST)
Message-Id: <20240619.152130.1121856489909363651.fujita.tomonori@gmail.com>
To: kuba@kernel.org
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 horms@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
 linux@armlinux.org.uk, hfdevel@gmx.net, naveenm@marvell.com,
 jdamato@fastly.com
Subject: Re: [PATCH net-next v11 5/7] net: tn40xx: add basic Rx handling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20240618185247.060c183a@kernel.org>
References: <20240618051608.95208-1-fujita.tomonori@gmail.com>
	<20240618051608.95208-6-fujita.tomonori@gmail.com>
	<20240618185247.060c183a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 18:52:47 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 18 Jun 2024 14:16:06 +0900 FUJITA Tomonori wrote:
>> +	netif_tx_lock(priv->ndev);
>> +	while (f->m.wptr != f->m.rptr) {
>> +		f->m.rptr += TN40_TXF_DESC_SZ;
>> +		f->m.rptr &= f->m.size_mask;
>> +		/* Unmap all fragments */
>> +		/* First has to come tx_maps containing DMA */
>> +		do {
>> +			dma_unmap_page(&priv->pdev->dev, db->rptr->addr.dma,
>> +				       db->rptr->len, DMA_TO_DEVICE);
>> +			tn40_tx_db_inc_rptr(db);
>> +		} while (db->rptr->len > 0);
>> +		tx_level -= db->rptr->len; /* '-' Because the len is negative */
>> +
>> +		/* Now should come skb pointer - free it */
>> +		dev_kfree_skb_any(db->rptr->addr.skb);
>> +		netdev_dbg(priv->ndev, "dev_kfree_skb_any %p %d\n",
>> +			   db->rptr->addr.skb, -db->rptr->len);
>> +		tn40_tx_db_inc_rptr(db);
>> +	}
> 
> Do you have to hold the Tx lock while unmapping the previous skbs?
> That's the most expensive part of the function, would be good to let
> other CPUs queue new packets at the same time.

I suppose that we can release the lock, unmap the dma address, then
acquire again like the following:

@@ -830,8 +828,13 @@ static void tn40_tx_cleanup(struct tn40_priv *priv)
 		/* Unmap all fragments */
 		/* First has to come tx_maps containing DMA */
 		do {
-			dma_unmap_page(&priv->pdev->dev, db->rptr->addr.dma,
-				       db->rptr->len, DMA_TO_DEVICE);
+			dma_addr_t addr = db->rptr->addr.dma;
+			size_t size =  db->rptr->len;
+
+			netif_tx_unlock(priv->ndev);
+			dma_unmap_page(&priv->pdev->dev, addr,
+				       size, DMA_TO_DEVICE);
+			netif_tx_lock(priv->ndev);
 			tn40_tx_db_inc_rptr(db);
 		} while (db->rptr->len > 0);
 		tx_level -= db->rptr->len; /* '-' Because the len is negative */

