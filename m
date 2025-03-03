Return-Path: <netdev+bounces-171204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2751A4BF0A
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 12:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17B8188406A
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 11:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4498F202C36;
	Mon,  3 Mar 2025 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="p3bK6d8D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E35201110
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002022; cv=none; b=T4wMMJ3xpLE8sjkKEIyt61U5B6WCWLEWzyQTi/ApGXqViUzIeqAw3z1GSNww+I1S+EWRa5+bejnl2O1TdkoZLrlee0xth7AkXzSLAdrC7yoYA9OLLUy0jpuEqvpSvMfD+NHz+95/AynAkPXhApPas/vskIgigiOruqpRJxF4PHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002022; c=relaxed/simple;
	bh=32Qik+C6Gy82VbaZ+W9H7pBMHl/CZaXxobg9NI2Xga4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLeH4FP40gWR7Lh3PJvgMsQMcjw0GZtP+tcfdGwQ6r2cq8jY8Tqt+SOJViZRF8MO+rto0EmJq3t3SpfTquArEopybFdXRpfn1ZgV7cymfgDl/bVyIZWrzLCZ6OeDXVkUbRyMAsSzhOv5HbKSSu+l5caRXrDjP2FcC0MR55eOVHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=p3bK6d8D; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-390f69f8083so1879833f8f.0
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 03:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1741002017; x=1741606817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4NtAA2UHYocmR2KbGMJPhzPhzOIPXF5Y+cD7gkzWW/A=;
        b=p3bK6d8DrjrhK0/qO2+o0XXclKbDdJbPyaEJqebJFnj6UftGu/Wlp0g0z460UuK8eQ
         jqP5dZiDvaf13EWZxYf429fumpQf+BuKXNtjjUA1NBj79GysscTVo0cg0j48fqmhX5NV
         9efVLZPrgc0Lj4xKJGCHbJmoh8/VB/GderaMZxkIzlOfM8yT/xfitEr/NJBqrSttwzsv
         D2S8SLnciUvPRACHbdtcIkpSchM5xwppp3eKPT9K2p2QOLfBtVwD7D66BHHzvMMQDhR3
         p5TyUVouF6jIyBsh7KwZIVWxs5mF+hJOLYmeHoxXDNdBYVQ5ilopY0Vx1AvSDV4gvTVv
         9zZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002017; x=1741606817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NtAA2UHYocmR2KbGMJPhzPhzOIPXF5Y+cD7gkzWW/A=;
        b=fQ5rM0lzO6Z1Ip60g4iV9b+Y/cMeJZa/FwQMnhvSF2wo7yeUbMup5vv13M8txBAoMf
         3BtMd5vgmVbWudsM7CEpR6mVl59ImKLbp8mqEqw+rHyklNHOAyXOA8VV4npr/Z5NYMIk
         Gm38UyN6DEf8QSnpu6XKWaFECe2x7LGy6xcK9i15LwxPzmmE6ueRMH0xgb7Iezvqhsks
         scDvJThCrLcytti0TacwEaLMPL/FE3iUG9uSUwGoHo2kkgDqXsn+ZzzgKGowewTLcmlH
         IKQsNeMGXP4hvvUgHW4MX3OQ136V7oapOMby3+jM3LPQDR01uRHiaQJSIBKIg+AgjkWc
         jaAw==
X-Forwarded-Encrypted: i=1; AJvYcCVSSDwKZr2kYP7qbyevbuZPlrH3Ww0InVCDVia+vHCzLEuv9taKdf1hjpdUEbeBZEB1V3Ev7QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRrlEBdtWtfH+P0zDmZcmwqO+ejvQkZu+6WJoB9grVe9Ufab9Z
	mp2BsNxPcuwAIn2AWjxFD/ocXnPh1ximQOVsd+2fMLYmIcNDkp4j97migHpedgw=
X-Gm-Gg: ASbGncvSRKJPHtP0Df6OMHa1j4Bxl73UQF8vJU4JCHCEFWZjqopAW0CPXSeXh3vuLaB
	z92H1sfnpmCEQdCNNMEHkdgkhq2yadP0T/XsHa8OprQSnSYNR872d816gxt9mFYt0JpUcy1BMVY
	pqC8/iZuZ9mZSsJ0bE4DwUZjnM8erZte8r4z/cb7/MrEMKMrYc6O9CcN4lMv2fdNvx2Dkggxhnv
	Uy0WqjSVe+lq0lRP2FIO4wSjp1kCRr7s24BRCrtkBkcEv1MOZTzde7DkZXqwbVNsaCWGE2lvSLi
	mvJXBHmx4lFUF9ac/+9n/JxEbp017hP44CN5Hazm5GIHJ4aUY+etFWUAlHv4Uc16eMbbu+iR
X-Google-Smtp-Source: AGHT+IFz1lKrp8HJjVJu85QHKOfDHRDkxYAgfR/PMWyeJaGKL7qzodzH7XjGqSVE9eCdgx8AE4rhHQ==
X-Received: by 2002:a05:6000:144c:b0:391:c3a:b8ae with SMTP id ffacd0b85a97d-3910c3aba7emr2411994f8f.23.1741002017110;
        Mon, 03 Mar 2025 03:40:17 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e479596dsm14212516f8f.7.2025.03.03.03.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:40:16 -0800 (PST)
Date: Mon, 3 Mar 2025 12:40:13 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: longli@linuxonhyperv.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shradha Gupta <shradhagupta@linux.microsoft.com>, Simon Horman <horms@kernel.org>, 
	Konstantin Taranov <kotaranov@microsoft.com>, Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, 
	Erick Archer <erick.archer@outlook.com>, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: Re: [PATCH] hv_netvsc: set device master/slave flags on bonding
Message-ID: <52aig2mkbfggjyar6euotbihowm6erv3wxxg5crimveg3gfjr2@pmlx6omwx2n2>
References: <1740781513-10090-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1740781513-10090-1-git-send-email-longli@linuxonhyperv.com>

Fri, Feb 28, 2025 at 11:25:13PM +0100, longli@linuxonhyperv.com wrote:
>From: Long Li <longli@microsoft.com>
>
>Currently netvsc only sets the SLAVE flag on VF netdev when it's bonded. It
>should also set the MASTER flag on itself and clear all those flags when
>the VF is unbonded.

I don't understand why you need this. Who looks at these flags?


>
>Signed-off-by: Long Li <longli@microsoft.com>
>---
> drivers/net/hyperv/netvsc_drv.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
>index d6c4abfc3a28..7ac18fede2f3 100644
>--- a/drivers/net/hyperv/netvsc_drv.c
>+++ b/drivers/net/hyperv/netvsc_drv.c
>@@ -2204,6 +2204,7 @@ static int netvsc_vf_join(struct net_device *vf_netdev,
> 		goto rx_handler_failed;
> 	}
> 
>+	ndev->flags |= IFF_MASTER;
> 	ret = netdev_master_upper_dev_link(vf_netdev, ndev,
> 					   NULL, NULL, NULL);
> 	if (ret != 0) {
>@@ -2484,7 +2485,12 @@ static int netvsc_unregister_vf(struct net_device *vf_netdev)
> 
> 	reinit_completion(&net_device_ctx->vf_add);
> 	netdev_rx_handler_unregister(vf_netdev);
>+
>+	/* Unlink the slave device and clear flag */
>+	vf_netdev->flags &= ~IFF_SLAVE;
>+	ndev->flags &= ~IFF_MASTER;
> 	netdev_upper_dev_unlink(vf_netdev, ndev);
>+
> 	RCU_INIT_POINTER(net_device_ctx->vf_netdev, NULL);
> 	dev_put(vf_netdev);
> 
>-- 
>2.34.1
>
>

