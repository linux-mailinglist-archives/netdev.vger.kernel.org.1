Return-Path: <netdev+bounces-75630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3071186ABA4
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 10:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619FA1C20D50
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 09:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1F136129;
	Wed, 28 Feb 2024 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="0RSKe4Sk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6208360AE
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113879; cv=none; b=mEXxh/VzHGIqrm+5t/qRGXPuPzBQGZWpQLx1h+jkWyU6VYBHEYCiDPjRJr1JS5YKAGumM0Y95sLUGS8FWHKRMK5PVNQtU4HkfzfXY0MmDCgcK47LSdrRLcDsfjCCxGRDDM0Evvdusj9OZB/QV0Fz1zoT48KnPrPLqWdN29AfH9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113879; c=relaxed/simple;
	bh=s8RRMzYpwsgS7/6fo5fbyQvyzCSLLaKP69VHlB8a1iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRhXKlk8PYRSt9VjmydZOGHJenklqy1VsBgOveubOXqN1+LmLF3JXmtuzhcf/my9pVcPVMfCwnaLEhWaX2pd9jWoAMP1ML1pyW1sOPp5rHe491CA0JoTyjGDl175+3tgwzQpKZYDvQiiSrHDz8wsy4CJYiF9YEqL23Z8K/yOSUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=0RSKe4Sk; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5131316693cso1985786e87.0
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 01:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709113876; x=1709718676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4im3iLarn+fVDeLiii7X0Q81Iw4mK1e/JWWrlhbYVWI=;
        b=0RSKe4SkpsKXa8tVldOIlomFXyLrEg3cD1vQcrbauNAX421WmTJn4f7U0c3P5jckdT
         tpyWpXy6/FpX7hclSdo8QkcvW/8iKtxhFH75NWZaCm7wQOzdiCsx6DhqsaKkZ2kzAjNR
         ov7uPDKmlnb8SjgZvATlbIMDuoVBeRRzVOO9drThnmmKZ6uOkmU1AwP9TCef1JeR4eOd
         xGHDVpGYP027yX6+oN1KCCuAPYYMohUnS1GXkk2WzPi3Ym/45PutjjfmqhOtfyQ/vP/y
         BsKSFNDlYj4eEjZ28XiuKRukKOj1x+tmZCWi2OrLLVuNhInYawaB7ELNxP/KAT2o2qD/
         eKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709113876; x=1709718676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4im3iLarn+fVDeLiii7X0Q81Iw4mK1e/JWWrlhbYVWI=;
        b=xRgvMu0pXPKwjrW8D0A1kCPqbq6JH8dhIs4CLa80/H3l4sUXc9iXHisXyVzXR2mE9d
         44BvrYCUAb9Rk9SwOPkRa8LeP0xyV7TZM4OPjISaPGVaEZTA9TozSXAe+UUC9AvmgdFr
         g2LCQ7OdmGSOgBkHpeVmAXGC9aNFlOfHlOmOB40Ov63WFNAvzh+4L2wPazUXFkhklFw4
         j1YavX1kYehktIgNpApxQVwhjeONaQ7YiiHQDYNPl6sR39CCAVxofiX0qbFHnM0F53RT
         f19Zd8Yrc5L9fM8PdonOGl9plEryT5X4vCoHIw44fW6TrB0B9jQufO1oAAc8KF83PFav
         DH6A==
X-Forwarded-Encrypted: i=1; AJvYcCUAM5pe3tEe/W0Egv4Y1a9CUPG6peBNJBmDkhRkGNUDPnC0PHzGuwJ/Jmwd53zZWdZ1mux5//AsgoYXc3W9uZG8+0tsv3OD
X-Gm-Message-State: AOJu0YxFTAMh3bhawA6oNrJfPOZZhu6HVep8BTJUI+2ZDOWHBW8xEgvP
	jKAMpAswb+thYrnSmXOSYb0YhIeR+uSawZkjbg3wXw5aEKSaYn+/gMBQDBXZdqc=
X-Google-Smtp-Source: AGHT+IE9Cgc15gAcIviadOB2K14AmCJF6uxTTVrM3FL0KsxJOhVvLqJW+cMJNBaeOSwbkx20kticDQ==
X-Received: by 2002:a05:6512:b1b:b0:513:c2:95a9 with SMTP id w27-20020a0565120b1b00b0051300c295a9mr5686175lfu.54.1709113875720;
        Wed, 28 Feb 2024 01:51:15 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id k3-20020adff5c3000000b0033d8ce120f2sm13910002wrp.95.2024.02.28.01.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 01:51:15 -0800 (PST)
Date: Wed, 28 Feb 2024 10:51:12 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: andy@greyhouse.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: tehuti: Fix a missing pci_disable_msi() in
 the error handling path of bdx_probe()
Message-ID: <Zd8CEAng7emsvaxg@nanopsycho>
References: <cover.1709066709.git.christophe.jaillet@wanadoo.fr>
 <011588ecfd6689e27237f96213acdb7a3543f981.1709066709.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <011588ecfd6689e27237f96213acdb7a3543f981.1709066709.git.christophe.jaillet@wanadoo.fr>

Tue, Feb 27, 2024 at 09:50:55PM CET, christophe.jaillet@wanadoo.fr wrote:
>If an error occurs after a successful call to pci_enable_msi(),
>pci_disable_msi() should be called as already done in the remove function.
>
>Add a new label and the missing pci_disable_msi() call.
>
>Fixes: 1a348ccc1047 ("[NET]: Add Tehuti network driver.")
>Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>---
>Compile tested only.
>---
> drivers/net/ethernet/tehuti/tehuti.c | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/ethernet/tehuti/tehuti.c b/drivers/net/ethernet/tehuti/tehuti.c
>index ca409515ead5..938a5caf5a3b 100644
>--- a/drivers/net/ethernet/tehuti/tehuti.c
>+++ b/drivers/net/ethernet/tehuti/tehuti.c
>@@ -1965,7 +1965,7 @@ bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> 		ndev = alloc_etherdev(sizeof(struct bdx_priv));
> 		if (!ndev) {
> 			err = -ENOMEM;
>-			goto err_out_iomap;
>+			goto err_out_disable_msi;
> 		}
> 
> 		ndev->netdev_ops = &bdx_netdev_ops;
>@@ -2031,7 +2031,7 @@ bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> 		if (bdx_read_mac(priv)) {
> 			pr_err("load MAC address failed\n");
> 			err = -EFAULT;
>-			goto err_out_iomap;
>+			goto err_out_disable_msi;
> 		}
> 		SET_NETDEV_DEV(ndev, &pdev->dev);
> 		err = register_netdev(ndev);
>@@ -2048,6 +2048,11 @@ bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> 
> err_out_free:
> 	free_netdev(ndev);
>+err_out_disable_msi:
>+#ifdef BDX_MSI

ifdef does not seem to be necessary here. The irq_type check should be
enough.

pw-bot: cr


>+	if (nic->irq_type == IRQ_MSI)
>+		pci_disable_msi(pdev);
>+#endif
> err_out_iomap:
> 	iounmap(nic->regs);
> err_out_res:
>-- 
>2.43.2
>
>

