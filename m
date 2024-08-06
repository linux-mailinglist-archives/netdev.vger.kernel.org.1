Return-Path: <netdev+bounces-116061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AFB948E08
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862ED1C212B7
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 11:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BEC1C2324;
	Tue,  6 Aug 2024 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="iH4jPrWv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C511C379E
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944638; cv=none; b=GzKKp6tgp+YJ6y3YHxoGngt1CVr4V8R6YTy8+WjtpuIhf5nEc7VC0qVMjRfdQAZjm0LXPhutev37pO7xhw2OIVFYybEa8pQd38siMRa753/5PPQ+i/S5OpI5a8YH96rxUrFjXJ5RKZYQTe6NWUvRVs0RVw/ai+GdUt0yGRv589c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944638; c=relaxed/simple;
	bh=zfPClkm01/oSWtofXJXJCAT43RwB0GsG7Dp8IdmrzRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cauix6i6GIfQmN/t1c77mAVNoaZoI7rLHgynmdv158j+3PMI0Z6fb26gW+zHy7RxSTEjtFBogA+PAHzKa1TEynIS4FPwrgkHpDvkRbbcuJSMfmnrkbjn0Bi+QGXFp+09iq7aWWpFZi8NjpH6jMpODko+f2+xBx0CE0C9ro16RKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=iH4jPrWv; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52efc60a6e6so852679e87.1
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 04:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722944634; x=1723549434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eA8DeVmCnWPBAlZaSQ1sffKJPQl9pwVimsWJipMzbLY=;
        b=iH4jPrWvR4FQljJr2HBPb8ODoEvgPLr5Nx4Nni1kxq5Mn8GypqWxNB/LHK9nkdY18t
         VwjYW3OrN46frKvwMuvHzffLtVb4fYaxJEdDIVOsB0Mh6WGojRCAVoPe6eR4FBoSUbdy
         RbcdYAd+gulvD0ClJmRW/tCf7oxvTeHXotNfsvAORr3osQ1TIH9HxwuJm3w+IuZPIBEW
         ZJgPkHBLdF7/EsBGUoUxf0e7cW4k1d2KYNoonD2rgoPxeVOYaxlc7SJyWntmEOM/EkVN
         /FOghYJ+JHFaj0upLUtUDx60xsxVI3XV43l+gmTBqPRpaLZHF2ZfaA8ozDaOQU5CpMHM
         DOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944634; x=1723549434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eA8DeVmCnWPBAlZaSQ1sffKJPQl9pwVimsWJipMzbLY=;
        b=I3vSzRY+H6bpcLiIr6IHyzQKsz5bS7vdjCoKAjimAL+sriH6ewBq9xnUPXnMQxWAOt
         txUldKPPgoy3fQwlfij5Eey1SKeTbJMMInu3zLR315himcbyy6sokazEkMgs1DrhuiHZ
         kOwm/2YRvFE/TY5Nq73gENQ9/tnFe2wczLJdk3Xptfw2aO+EyPEvlxAEsZ5D8+WHxovT
         3JSQNF6/9XqlTzA8PhY45a4i/RKelYr2ozGCVPXL25JLQhmw5kEAApf4u76h+n7Oxet8
         DENjvM0tbSKI36vinUfRE9fC/iP2goG+jtTphz5WXCIkWf06vvtKa4oYmAxsxJYTRREo
         brGg==
X-Gm-Message-State: AOJu0YxauEzVcZCeI8qKMQksKIi3CU/NnHY2HyVyHT02dv0UTJlRlXma
	To3OiOGyHy6OwzvvIZR4sZR6M54SXrlrSTMY6TYuwhhAWCKVXZA8EtilJ4cNTI4=
X-Google-Smtp-Source: AGHT+IHyX/ltOw2LPArpiNNIWH3KLqdp1pPX9WHrIxyl1sUg9tdBCpnPeU1xUrD47OGCWArWl2TyBw==
X-Received: by 2002:ac2:46d7:0:b0:530:bcaf:3fbc with SMTP id 2adb3069b0e04-530bcaf4323mr7023741e87.54.1722944633931;
        Tue, 06 Aug 2024 04:43:53 -0700 (PDT)
Received: from localhost (78-80-9-176.customers.tmcz.cz. [78.80.9.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec7173sm537275266b.204.2024.08.06.04.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:43:53 -0700 (PDT)
Date: Tue, 6 Aug 2024 13:43:52 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 10/10] net: ngbe: add devlink and devlink
 port created
Message-ID: <ZrIMeOdfRVUvtcVd@nanopsycho.orion>
References: <20240804124841.71177-1-mengyuanlou@net-swift.com>
 <C6023F033917F553+20240804124841.71177-11-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C6023F033917F553+20240804124841.71177-11-mengyuanlou@net-swift.com>

Sun, Aug 04, 2024 at 02:48:41PM CEST, mengyuanlou@net-swift.com wrote:
>Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
>---
> drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>
>diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
>index a03a4b5f2766..784819f8fcd5 100644
>--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
>+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
>@@ -16,6 +16,7 @@
> #include "../libwx/wx_lib.h"
> #include "../libwx/wx_mbx.h"
> #include "../libwx/wx_sriov.h"
>+#include "../libwx/wx_devlink.h"
> #include "ngbe_type.h"
> #include "ngbe_mdio.h"
> #include "ngbe_hw.h"
>@@ -616,6 +617,13 @@ static int ngbe_probe(struct pci_dev *pdev,
> 	wx = netdev_priv(netdev);

WX should not be netdev priv anymore. It should be devlink priv. Please
split.


> 	wx->netdev = netdev;
> 	wx->pdev = pdev;
>+
>+	wx->dl_priv = wx_create_devlink(&pdev->dev);
>+	if (!wx->dl_priv) {
>+		err = -ENOMEM;
>+		goto err_pci_release_regions;
>+	}
>+	wx->dl_priv->priv_wx = wx;
> 	wx->msg_enable = BIT(3) - 1;
> 
> 	wx->hw_addr = devm_ioremap(&pdev->dev,
>@@ -735,6 +743,10 @@ static int ngbe_probe(struct pci_dev *pdev,
> 	if (err)
> 		goto err_clear_interrupt_scheme;
> 
>+	err = wx_devlink_create_pf_port(wx);
>+	if (err)
>+		goto err_devlink_create_pf_port;
>+
> 	err = register_netdev(netdev);
> 	if (err)
> 		goto err_register;
>@@ -744,6 +756,8 @@ static int ngbe_probe(struct pci_dev *pdev,
> 	return 0;
> 
> err_register:
>+	devl_port_unregister(&wx->devlink_port);
>+err_devlink_create_pf_port:
> 	phylink_destroy(wx->phylink);
> 	wx_control_hw(wx, false);
> err_clear_interrupt_scheme:
>@@ -775,6 +789,7 @@ static void ngbe_remove(struct pci_dev *pdev)
> 	netdev = wx->netdev;
> 	wx_disable_sriov(wx);
> 	unregister_netdev(netdev);
>+	devl_port_unregister(&wx->devlink_port);
> 	phylink_destroy(wx->phylink);
> 	pci_release_selected_regions(pdev,
> 				     pci_select_bars(pdev, IORESOURCE_MEM));
>-- 
>2.45.2
>
>

