Return-Path: <netdev+bounces-114911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 709CB944A9A
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7C11F25759
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 11:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90154184557;
	Thu,  1 Aug 2024 11:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAeOkRNk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EDA158A2C
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 11:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722512909; cv=none; b=S/+wtk7sW5SuUor0kfQK3CgDeSTXT2P5hacn2u9GSKAWGkpovqvyvN0VdwYjthvQykVaSHzd6jl8TAHaKnchuXucBUz+0SVRFGbEe3u9jBW+IFW60QJPnQeutinYyxwGCYEsbfZg6MjnBbqANlTHYB5znpRM0gVVbX69yItqpz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722512909; c=relaxed/simple;
	bh=jjpCS6aSDcHuKnK77g8cc0yF6CnJozBYU7xCv1NANl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqQwBe/9oci8IkrIfSsydHo2ii/jfEfpNj8aN9ZCs/2hfY/J2h3e4KTCcmwVPzLv/qb4iWKd0nz4aTM74YBAcW4PWeV9MHLx2WSzDFEBkLr5sBm+qRbd6P8rtcIf23VvdDOwwFsFFxOQmGdLCMkLKNSFSn73CFybmYRMfFNlJMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAeOkRNk; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52efabf5d7bso8130758e87.1
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 04:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722512906; x=1723117706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bOxa2QyoGKL3fyeu8EvJ+iBbxOKEL9lUgVxh4jS+U/o=;
        b=GAeOkRNknuf2Gmxx5HDk+H+GQ7f871bpaKnzLl0gZUvTRSAWsDhCYJotFCOMjsgZKt
         nJSkDsauVtxv1alJcPZ7UWGBdEdJeBnC2hoRL6ypLdTnAN8DaedF+tsk1Uuhedn+RUiU
         fOXvTLGoK8MlQ5bURwxHwTzMvBxbxYu+AwkQE3cDEKd17wnesptdnCzudyS/xGsuZt65
         IToaojnbYnAKil3H7tRfSnyc3NUMZdSDHs4g0jeJ7r0Ip5eP/szvIHwm9ek3A0ACl4/6
         /DiL4TArO9SbwLYCm388iCvoV9oFh+JPOIl3KCfrc36GNyjh3q9jGKRc/yLroKx5bBlK
         7+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722512906; x=1723117706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOxa2QyoGKL3fyeu8EvJ+iBbxOKEL9lUgVxh4jS+U/o=;
        b=ZIJHUJGzwg7BHYpX5MLSrCPyYnHH07bCktSWgnDrAQKwARmtGSSSpDiKqTB7QFs1D8
         H8+xNa1T64tKtRsFBijzNjmEcTAlCN9jBWJgbuC87NZtnUNPdwCRmRNDARR7fmIZPxmj
         YMun20NowDGwTKoAzmv6QGSsRbQuR/a7I29tJD7YIUVBrClRcHcTvPvHmkMs8z4Y8V+F
         qCa5BxSgCQEHpA9gcQvhpkesNC/zvj9L6a/P2Dmy/+QKWdBv6pnM0b1EvIxJItu2odxo
         KOFz4Jo+VhN3ANJ1Y+6ENinTW+i99xRKBRv0ILfD6+ji2lrpERfrhDW/+47rG0Et6n1F
         iLaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGN1K1eCO0GpaE7N4jx3HoICH0wyu0EVoYLRMjuIqOLWm1rlB9F9x9d5cHKZGQfJgahrKsHGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnw75P2df9KU5k/lqTe0mjVspe7fDv5w3kfXekZPIZW9+wY9kI
	nheqQE8DSG5sOmIiyTA4zbFV7RGS/IE/3yT+ZbCkIsL7TNoSiOoW
X-Google-Smtp-Source: AGHT+IGlBW3Zt/fWtUuXfQmxpAZIUi3zChYgsWnHvnvUQ7h9kvnNj+eMd9aSqWS9A/59b3oU+ZQ/XQ==
X-Received: by 2002:a05:6512:2c08:b0:52f:cbce:b9b7 with SMTP id 2adb3069b0e04-530b6152954mr1340297e87.0.1722512905475;
        Thu, 01 Aug 2024 04:48:25 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c1eec2sm2522060e87.233.2024.08.01.04.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 04:48:24 -0700 (PDT)
Date: Thu, 1 Aug 2024 14:48:17 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Yanteng Si <siyanteng@loongson.cn>, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev, 
	Huacai Chen <chenhuacai@loongson.cn>, peppe.cavallaro@st.com, andrew@lunn.ch, hkallweit1@gmail.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, diasyzhang@tencent.com
Subject: Re: [PATCH net-next v15 11/14] net: stmmac: dwmac-loongson: Add
 DT-less GMAC PCI-device support
Message-ID: <3d67tp6notufq7c35fdlel74xjqdiwlviiadwcfmfveg5smkgr@cvoosjros3bz>
References: <cover.1722253726.git.siyanteng@loongson.cn>
 <359b2c226e7b18d4af8bb827ca26a2e7869d5f85.1722253726.git.siyanteng@loongson.cn>
 <eb3ad0da-9ed3-42e3-9a96-7be81841fc93@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb3ad0da-9ed3-42e3-9a96-7be81841fc93@redhat.com>

Hi Paolo

On Thu, Aug 01, 2024 at 01:32:56PM +0200, Paolo Abeni wrote:
> On 7/29/24 14:23, Yanteng Si wrote:
> > The Loongson GMAC driver currently supports the network controllers
> > installed on the LS2K1000 SoC and LS7A1000 chipset, for which the GMAC
> > devices are required to be defined in the platform device tree source.
> > But Loongson machines may have UEFI (implies ACPI) or PMON/UBOOT
> > (implies FDT) as the system bootloaders. In order to have both system
> > configurations support let's extend the driver functionality with the
> > case of having the Loongson GMAC probed on the PCI bus with no device
> > tree node defined for it. That requires to make the device DT-node
> > optional, to rely on the IRQ line detected by the PCI core and to
> > have the MDIO bus ID calculated using the PCIe Domain+BDF numbers.
> > 
> > In order to have the device probe() and remove() methods less
> > complicated let's move the DT- and ACPI-specific code to the
> > respective sub-functions.
> > 
> > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> > Acked-by: Huacai Chen <chenhuacai@loongson.cn>
> > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> 
> @Serge: I think this addresses your comment on the previous iteration, but
> it would be great if you could have a look!

Thanks for reaching me out. I'll have a look at the series later
today.

-Serge(y)

> 
> Thanks,
> 
> Paolo
> 

