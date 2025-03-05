Return-Path: <netdev+bounces-172008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84392A4FDBD
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 12:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127EF18929A0
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 11:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F7F24633D;
	Wed,  5 Mar 2025 11:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JzHskBXo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D211B245018
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 11:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741174476; cv=none; b=FuylNsvWUtbyYuj71yznU6QAeQz4I3L+SyJFDQvyOVm5v/fYagZFC+hBir9uta7vv6PbO21FDMGpDyyl27ysxwIao64fPG7XqrKhzSBVHwp5PYYXGOHbHQwN4I/jyO2wYb6MQKkUvSw2xs/RScFolLdDwMz4mZhlKYmM1HSg1A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741174476; c=relaxed/simple;
	bh=kL66fAUxg8KDrRHVSUn/3JwrJc0S+PUcIDIXg0KHtrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgCgUvzNEZW8cqoStxfJPDq0YFXYuWOGDdK1gFGAEWJZaU1GNeRXS3ziec7Iapg8D7VtyhV59t3i1bpqDrSYHB0thA4pgeFhGOvagvGONQStbA+zLNEuQtvtB/QGlR4qysx7M6QwxKXs0252OGSmzwDCGFB7e+sN00Eb8kW0AUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=JzHskBXo; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-390edaee0cfso3966386f8f.2
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 03:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1741174472; x=1741779272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hpM2n8LqDCKtYCNjyQPHE8ZzTXVzmeW07FILl14R+lk=;
        b=JzHskBXolzJ6P/HG1IV9mbpJkmpIl1CoKd2IENNDS2XLLaK1QMKUSgIEPljYHdeXz2
         e+MbC9c+OvAERT5ZeT/iboJacB/a3YRij0Wp5CS5YFFeluxeEsT/56kvKKAU9KIMTFKP
         bAL6/99/Gns94LyaLQh1XIurEf8ftk3A9GQWq5Zs5exw72EhmvoJzJMFRdft9cVt/G2S
         ZPHufcQMDEAerK5u9sGwpPZgQl07YzXRZ8csPUEVx0alNspfPkVFuzxlCAmbSM2LzzQS
         8BlDI3GcQQuA748UHz1wXznQAz7WT3XzbGv+Zk++x+SyW04H4QKSMHQhI9c3/PV3JywQ
         E8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741174472; x=1741779272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpM2n8LqDCKtYCNjyQPHE8ZzTXVzmeW07FILl14R+lk=;
        b=nHn1eeL8IwpgoJnmb5KFs3ynkIHSQaZR6pEP0mf8DZi/9KGhGaEFDsu+MgDHOKVEUG
         LDpc+BN8oMo8wFHd8hJJ821gMGca+Y/3EMOC+Nm703xdKtAd9t2xYxVVxMm+KLFgf+OH
         kAz24w5VSudAjV/187BhZn0lMG8Mv8+asUWrGsFP5uoHe+p+cIPIH+geBzTLnp3OZcvd
         0FD0mX9f43AWOnZsMzsc951WkKSXReoNdPoUdXk83QW/jB+RxhNwJHiTVf8Md4PQwOo0
         QcSSfs/8nRJOJWr+1h4siMqxG2gcaSsAkU4mDkKx22ojczlwPZ77PpbsAezMo4Lh6VOn
         4H+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVA1tVckMKKrbLJF7ME8pWh2tFeoH6aYKU+LPI2GF0sl9HcAz63y1h26BGdgcIchQ3Z7R0YAMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN9cSnPZW50AtffEpT0YbYKIRNQihHbNSOS7KMmYiOLSYHlaVr
	zTzxy1il/vKY50Gk1aFpvtQAhPD6+RsOV8OB8mHjaTmrToaDBYD9rFEHTcKbz7Q=
X-Gm-Gg: ASbGncu387TnockX/tfgBVyQFfaH2/hmV3IXdMEZOiXJk+d3guNfHk/+I8Wrpmu+2Qm
	mmbHb6IqASP0CuTDsYRp8JCo16MiweIXoJdmO3Rw09jjzfb5mM58gJWaTplYAudPqoToDp6MNal
	ZHYvIuy/tJTSwsErnjgwj9OhaKgmjuCLYLThiU+km/RkhIkAhV/TJ2KSJSrZfILaUQf0zScyfvo
	f9KeRpzDRDYxExkYvi8Vp01id0bGr0fBUJZZdug/BtsKZahGMwodTJzqYsvWuq8RTjkZB5oEytA
	x3oABposYoABYy0i9jXUtMpvbbzS0diJ0VQho6Oflgzu2HK/YaozcH7H8FguNB6oMcLHjspJ
X-Google-Smtp-Source: AGHT+IFhcRjxC3RYssOw9YiOI4i2fR0hgc5YoCn+lwsc2UV78sEfmb324dUC+Cr+juAHyeRCzFmMBg==
X-Received: by 2002:a5d:64a1:0:b0:38f:6287:6474 with SMTP id ffacd0b85a97d-3911f735a79mr2149235f8f.15.1741174471766;
        Wed, 05 Mar 2025 03:34:31 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd42e53e0sm14790365e9.27.2025.03.05.03.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 03:34:31 -0800 (PST)
Date: Wed, 5 Mar 2025 12:34:27 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Long Li <longli@microsoft.com>
Cc: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, 
	KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shradha Gupta <shradhagupta@linux.microsoft.com>, Simon Horman <horms@kernel.org>, 
	Konstantin Taranov <kotaranov@microsoft.com>, Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, 
	Erick Archer <erick.archer@outlook.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH] hv_netvsc: set device master/slave flags
 on bonding
Message-ID: <7z2vlhnu2seaujnuvtpjllbj4pnc5aqn5pwfujvzsrzc7emllb@ce2v22r3ombt>
References: <1740781513-10090-1-git-send-email-longli@linuxonhyperv.com>
 <52aig2mkbfggjyar6euotbihowm6erv3wxxg5crimveg3gfjr2@pmlx6omwx2n2>
 <SA6PR21MB4231D93C746A70C24B79F806CEC92@SA6PR21MB4231.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA6PR21MB4231D93C746A70C24B79F806CEC92@SA6PR21MB4231.namprd21.prod.outlook.com>

Mon, Mar 03, 2025 at 07:47:37PM +0100, longli@microsoft.com wrote:
>> Subject: [EXTERNAL] Re: [PATCH] hv_netvsc: set device master/slave flags on
>> bonding
>> 
>> Fri, Feb 28, 2025 at 11:25:13PM +0100, longli@linuxonhyperv.com wrote:
>> >From: Long Li <longli@microsoft.com>
>> >
>> >Currently netvsc only sets the SLAVE flag on VF netdev when it's
>> >bonded. It should also set the MASTER flag on itself and clear all
>> >those flags when the VF is unbonded.
>> 
>> I don't understand why you need this. Who looks at these flags?
>
>The SLAVE flag is checked here:
>https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/microsoft/mana/mana_en.c?h=v6.14-rc5#n3144

In kernel. We have other means. The check is incorrect. The code should
use netif_is_*_port() herlper. Does not exist, add it.


> and is also checked in some user-mode programs.

As currently it is not exposed, it can't be checked. Don't add it.

>
>There is no code checking for MASTER currently. It is added for completeness. SLAVE doesn't make sense without a MASTER.

Does not make sense. Either you need it or not. If not, don't add it.


NAK. Please let IFF_MASTER and IFF_SLAVE rot.


>
>> 
>> 
>> >
>> >Signed-off-by: Long Li <longli@microsoft.com>
>> >---
>> > drivers/net/hyperv/netvsc_drv.c | 6 ++++++
>> > 1 file changed, 6 insertions(+)
>> >
>> >diff --git a/drivers/net/hyperv/netvsc_drv.c
>> >b/drivers/net/hyperv/netvsc_drv.c index d6c4abfc3a28..7ac18fede2f3
>> >100644
>> >--- a/drivers/net/hyperv/netvsc_drv.c
>> >+++ b/drivers/net/hyperv/netvsc_drv.c
>> >@@ -2204,6 +2204,7 @@ static int netvsc_vf_join(struct net_device
>> *vf_netdev,
>> > 		goto rx_handler_failed;
>> > 	}
>> >
>> >+	ndev->flags |= IFF_MASTER;
>> > 	ret = netdev_master_upper_dev_link(vf_netdev, ndev,
>> > 					   NULL, NULL, NULL);
>> > 	if (ret != 0) {
>> >@@ -2484,7 +2485,12 @@ static int netvsc_unregister_vf(struct
>> >net_device *vf_netdev)
>> >
>> > 	reinit_completion(&net_device_ctx->vf_add);
>> > 	netdev_rx_handler_unregister(vf_netdev);
>> >+
>> >+	/* Unlink the slave device and clear flag */
>> >+	vf_netdev->flags &= ~IFF_SLAVE;
>> >+	ndev->flags &= ~IFF_MASTER;
>> > 	netdev_upper_dev_unlink(vf_netdev, ndev);
>> >+
>> > 	RCU_INIT_POINTER(net_device_ctx->vf_netdev, NULL);
>> > 	dev_put(vf_netdev);
>> >
>> >--
>> >2.34.1
>> >
>> >

