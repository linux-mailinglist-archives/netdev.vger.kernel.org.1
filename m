Return-Path: <netdev+bounces-109410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF60928684
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 12:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A528CB24E38
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 10:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3798145B21;
	Fri,  5 Jul 2024 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyT8SkZd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420DE13D276
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720174580; cv=none; b=fCh6/U3aQNVSjg/pCShIfiNxNS+FbxUgrmgsEaWPFSrNVO8RNArGrpVj/Yy8N1jLoYi9lU7KYU5dnKwsPCpslPknYpe3Dwwcuj2vhfhQdDKfOkXS7XEURlfy58jczj+2zJjdeCCimJN28yq44e9Yz23RE4mXP8siMY3/9MarEDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720174580; c=relaxed/simple;
	bh=U1C/HicrtnpyfZxiSdjIauLSpADNs2zlVlPZBc1fztc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9luae1y4oJYqzoYDFs+M+gd8Ez9g9JLuvq+YlZWRJHgw5VLA0ukDThzh2zWa7gzUx+SQXM65L07cr9r34ddGCgintyYkkROC+KpZzNWQrwIj+i/7jeq6eEqxtfGh9kUirnO2kJIGO609MGJUW5pQC74674MmyOTNO3yeQuzaSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyT8SkZd; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52ea7d2a039so272588e87.3
        for <netdev@vger.kernel.org>; Fri, 05 Jul 2024 03:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720174577; x=1720779377; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wTFEF1DZP6etdPUq+b/3MSxOf02/J35+6VlBSeCRoI0=;
        b=JyT8SkZdvfqA1k1jpVHxm2UTKZ5uN4wt2v8xjgt0R/ziraeVRe7AEWEjuHHZAEQ9mN
         BctZDW8H6YOklC3aqD3Tqomu4U32onBqVzYtcmgHPFeqj13Aox3TB8uYnZaeO2dH3JLV
         DGVNDtnW3osSNyp9rTx09MrmnAtRVvSy8BXA67ep3OBQ2MCFpE9ZnTafht4qrzNSjfQw
         dv5hPVG2quqRt8mWO/QYe54LHA/JQiIu0u60xBreQoINSG3FCnO7xO+vuaGMvAWZuYWf
         0Kf1yEj4XZSy/XHqevebe2THjEOUYH9C82Vy6si/W+PjTQQWxrt2z2k16hHXBeOFB4QH
         0gFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720174577; x=1720779377;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wTFEF1DZP6etdPUq+b/3MSxOf02/J35+6VlBSeCRoI0=;
        b=hTS5V1Pfh5UZ5KOiUBlLF+T4goEtLEPGLiQlP1RTiuYGGIJjhcdYOjKXCZEy9hJ0gT
         IMbCijLxJJmFN9kWp4Fbp9abwRH4IP7NadaEzSnqGOsu4atpSeuU5zHdPZHXXq2le4lL
         bhGfQKlqD/ncEXxkeqtuUhMvxfzfKuj+oahIuPj+h5lZfz+BaX4+S0f/bPKnTx3E9999
         c+IXlkYulirXFXRbWhtYqNuQQkE+LLI5S5RfYywVJ/KlxwEewfyv6rCy+1JnwGgvfa15
         tsBr08izROBZDArhRd+NBuZD48qtbJQ5MJb/d2FfMZwK5ucimmdVJ1Iov4IAfzSxWrwh
         2Qgw==
X-Forwarded-Encrypted: i=1; AJvYcCUl9ahwuXSvDCA1DhDvazV08rhHl6xUS2A5I3PrI0phh6AEZUT368GU60FJtveXGkFUUpwql3g209Y9Iue12/DCye7psZBV
X-Gm-Message-State: AOJu0Yx7c1THLIITtqXsVrxObr5sh/5kO+Ar3MdNXGQ7AjeddUTfYmbX
	cqnGRs0mpp/3kAveV331Fb/dTk3CyIWdBOEyTmLb3eZFpj2rfoaW
X-Google-Smtp-Source: AGHT+IGrzXeuhz0MY7ZX4J0w4JWmbg+VnuprxI12xKpkfOxhQoWOpOCa2EqFsT1aKp8rLiRRtpQkvA==
X-Received: by 2002:a05:6512:3b6:b0:52c:8aa6:4e9d with SMTP id 2adb3069b0e04-52ea0641608mr2793729e87.29.1720174577084;
        Fri, 05 Jul 2024 03:16:17 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab3b104sm2791208e87.246.2024.07.05.03.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:16:16 -0700 (PDT)
Date: Fri, 5 Jul 2024 13:16:13 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v13 06/15] net: stmmac: dwmac-loongson: Detach
 GMAC-specific platform data init
Message-ID: <y7uzja4j5jscllaq52fdlcibww7pp5yds4juvdtgob275eek5c@hlqljyd7nlor>
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <b987281834a734777ad02acf96e968f05024c031.1716973237.git.siyanteng@loongson.cn>
 <io5eoyp7eq656fzrrd5htq3d7rc22tm7b5zpi6ynaoawhdb7sp@b5ydxzhtqg6x>
 <475878c7-f386-4dd3-acb8-9f5a5f1b9102@loongson.cn>
 <7creyrbprodoh2p2wvdx52mijqyu53ypf3dzjgx3tuawpoz4xm@cfls65sqlwq7>
 <d9e684c5-52b3-4da3-8119-d2e3b7422db6@loongson.cn>
 <vss2wuq5ivfnpdfgkjsp23yaed5ve2c73loeybddhbwdx2ynt2@yfk2nmj5lmod>
 <648058f6-7e0f-4e6e-9e27-cecf48ef1e2c@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <648058f6-7e0f-4e6e-9e27-cecf48ef1e2c@loongson.cn>

On Thu, Jul 04, 2024 at 04:56:41PM +0800, Yanteng Si wrote:
> 
> 在 2024/7/4 00:19, Serge Semin 写道:
> ...
> > ...
> > 
> > Seeing the discussion has started anyway, could you please find out
> > whether the multi-channel controller will still work if the MSI IRQs
> > allocation failed? Will the multi-channel-ness still work in that
> > case?
> 
> Based on my test results:
> 
> In this case, multi-channel controller don't work. If the MSI IRQs
> allocation
> 
> failed, NIC will work in single channel.

What does "NIC will work in single channel" mean? Do the driver
(network traffic flow with a normal performance) still work even with
the plat->tx_queues_to_use and plat->rx_queues_to_use fields set to
eight? If it's then the multi-channel-ness still seems to be working
but the IRQs are delivered via the common MAC IRQ. If you get to
experience the data loss, or poor performance, or no traffic flowing
at all, then indeed the non-zero channels IRQs aren't delivered.

So the main question how did you find out that the controller work in
single channel?

> 
> 
> I will prepare v14 according to your comments,

Ok. Thanks.

> 
> 
> Over the past year, with everyone's help, the drive has become better and
> better.
> 
> Thank you everyone. Thank you very much!

Always welcome. I am glad we are finally advancing the series further.

-Serge(y)

> 
> 
> Thanks,
> 
> Yanteng
> 
> 

