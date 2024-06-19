Return-Path: <netdev+bounces-105083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4B790F9DA
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 01:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1541F2231B
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 23:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73ABC139578;
	Wed, 19 Jun 2024 23:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CorWdJop"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9D51E515
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 23:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718840993; cv=none; b=VL50jUE2rOMM1HJDjUZ23Yc8vzZRdjg0t5CnN48oG05cJpnF5uWIlVH/wAZe+H/J1SnrJUxXAJineP3Ju2ZtJjCTr2epexTOrdBXv1A8AN9am7CfCLouB4FAbPPijXwA8ASorN2qA9de0kBDUUge0fJPyC2SeDSpovOBNPmJ1qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718840993; c=relaxed/simple;
	bh=j9jm8vCXLmrF0udmhyLULm3stowYz6bjBWXye1oHUcY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iExQ2pUGMelS+JO7Aoi7q7kxEdFJ8j6jQZpylghxP08C0Hh/Bi586Q0BwkGxGqH4QRQIo9d+yg8IbKQrZE5cf7zweRz/qHGk9isUhFFBt1f9yVnReZN43SSvdg715GZi/LVzbEARE0z16DWCdi+SRuyThXO7PQidA4KZJ2QDxr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CorWdJop; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c7a480c146so65722a91.2
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 16:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718840991; x=1719445791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vuqr9gOUqkHUtOGt+8n30f12MeQcDV5d7zcCiU4Jsks=;
        b=CorWdJopHeGSuUmYg4HXsxvg5lJSH7PFYJG1FQB4FbABzfVpV09T/46ma68SbEkAnS
         3rHTKLVTtZLgQyVjEGVX5Pw1qOphV3dqJ6hTXcxQfJU76fBKs1VBHpCcvWlb+XSvQN/u
         SpKzCw2Ops5bhW/q1PYiqaeGBvVtfWl241NwP632j7hGi/llzcClizr4AnJ2opBdg/Xs
         7oT/MBK1PMwpl3qUgDby65SznmXFMAxqmvVbprFi+LpmVT/BLp5sHxhBer9iqRKdSApp
         7aUz51uKD4sL4OdmTMJMq8aUMiuO1vHKDF9Ys1NmZWZrH7C+HEStQvkW+SB2XzpoiKFd
         TMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718840991; x=1719445791;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vuqr9gOUqkHUtOGt+8n30f12MeQcDV5d7zcCiU4Jsks=;
        b=es/A4ESd4TXYvW8ZeoeEWkQJ4jmIaVpuyphfd2L8F+ZGAp3T/QOFjHH02nCaqMZIDC
         T9oqLLZfVhVRLy7364l7Ps1I6i49XujeUkhBPGv2xh4ScelCo39dDIVdn1R2izdeuFXM
         kPy6+LEJW1Dt9TYC2altSup1TJyB5wu+HVWot71wCDXmmPeiJWALMpkrZwm8GawOoBow
         lOqDI4obxrqxKr0tCRg1rBC+ZTqyasGV2e85NhWuLpcynvqbLfyJvAHoBcQqGdAuA/19
         beks9vGFhd+z8TiNjPVYyt/ybEZogPHKdhbKdQktcMiCPf7j4GKQ7BLdwefIJc/Db8MO
         j+sA==
X-Forwarded-Encrypted: i=1; AJvYcCXSKYSxJCfbuVhWUJNzdTXiUa6oeI05C8xZnbNw0Za2Vcr5zZuOf3KZC4LamL07uiDoT6mIF0q8g+3Ku016bRAoo1bOpDNq
X-Gm-Message-State: AOJu0Ywf8Bz8JiwN9deSTdyrg9f05BmeWQH19AzvbFI1fyxpxTqwFsDd
	RpDFSD8ei2W+9823D6ZocqRsQ6xIIu6ovR7H76OJw35PUpwKj1pt
X-Google-Smtp-Source: AGHT+IHKjoue2Bge93zgfZ3jua+ld78aUVSj9AhfBfkc6rI62P2z8C2F/rRqnDZm0niPGcNTdfSDCA==
X-Received: by 2002:a17:90b:3015:b0:2c7:8a07:bc5d with SMTP id 98e67ed59e1d1-2c7b4e46ca0mr3811683a91.0.1718840987214;
        Wed, 19 Jun 2024 16:49:47 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e58c55bdsm259162a91.35.2024.06.19.16.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 16:49:46 -0700 (PDT)
Date: Thu, 20 Jun 2024 08:49:34 +0900 (JST)
Message-Id: <20240620.084934.417539153784726407.fujita.tomonori@gmail.com>
To: kuba@kernel.org
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 horms@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
 linux@armlinux.org.uk, hfdevel@gmx.net, naveenm@marvell.com,
 jdamato@fastly.com
Subject: Re: [PATCH net-next v11 4/7] net: tn40xx: add basic Tx handling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20240619075507.1f88d395@kernel.org>
References: <20240618185000.1ecc561f@kernel.org>
	<20240619.124422.478553760916754787.fujita.tomonori@gmail.com>
	<20240619075507.1f88d395@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 19 Jun 2024 07:55:07 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Wed, 19 Jun 2024 12:44:22 +0900 (JST) FUJITA Tomonori wrote:
>> >> +static void tn40_link_changed(struct tn40_priv *priv)
>> >> +{
>> >> +	u32 link = tn40_read_reg(priv,
>> >> +				 TN40_REG_MAC_LNK_STAT) & TN40_MAC_LINK_STAT;
>> >> +
>> >> +	netdev_dbg(priv->ndev, "link changed %u\n", link);  
>> > 
>> > shouldn't this call netif_carrier_on / off?  
>> 
>> According to phylink doc, a driver shouldn't call them?
> 
> My bad, forgot you're using phylink!
> Purely out of my own curiosity - do you know what this link change
> detects, then? In my mental model PHY detects the link, sends some 
> form of a notification, then MAC gets configured.

It seems that this link change detects what the PHY detects. The
original driver doesn't use PHY registers for that purpose.

