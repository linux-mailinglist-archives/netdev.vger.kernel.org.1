Return-Path: <netdev+bounces-132315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 128E1991333
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 01:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD4E283A65
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A7B153820;
	Fri,  4 Oct 2024 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLAfK7us"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B451231C9A
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 23:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085246; cv=none; b=AwbSgM0hCZ6EVtP8vmTOjfsn0DwpcPkeECEbe8MTwAjGoWICyE6wkKM0/KuMvNWcosUsPIwoYtneDMBtbwfiNteRPTrrzREf8v2ZPjY9KZvPaxYYKGhZPJR37gkxiYXJCRxiRpSMpkTr2rvZt/V0+WxS2sHlXitO4PEJvyd9PeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085246; c=relaxed/simple;
	bh=yCYXKTPom/wExlMVbGTiRXc5FoQca2qO0AVt8ZQau9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aS4jQtTJhivDlGz9dN5nEeOq+W53Ks1NROVTAjn2lkz7wAtE7ZmiTAXFBuMmk8AXYZwPGeaNTo46J4FvVU5oW51xjEu7ojhWa9FZHN3VN8MEdxuRS6ltG7aK6l8vlRwVsBbCO/PvZeELd4S8GAEUULchttXEHSjU6Mju/AH+AgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLAfK7us; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5369f1c7cb8so2954310e87.1
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 16:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728085242; x=1728690042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wXB6FiMFGXfruSvEAC93ihWCz2mJmwl2xFZB57k5WVo=;
        b=LLAfK7usW4nyPbGM3nDdJHUWbSPlVgO1O5QZVrxQioWwsYKNgTal3k8Xv6FRFrubyv
         herzYGm8g95DONE2+PJBH9lM0y2n9lcR7HRBtOoTDbn7IPJKRcEFeOFd18n3qPTFfwB0
         l8r8c0lvWn+/rqUWauKQkvAtsoUuxZ6dTDCuLFqc/HlK4dlU0BaNDpJYECttQtjFpoZY
         H5v/S/0m1N9CM6kIaKn2o/hyMf9vKEwOxBFuEgIPr82CiJhTnQ3PjoRIDyqS5+4qDDEu
         8f+NSLZRx/y2RH2MlVw9TAFhRj3gawxvmzjkBwgTgqG+CxNtrdyvJRLV+oEeR74kE2+i
         UXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728085242; x=1728690042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXB6FiMFGXfruSvEAC93ihWCz2mJmwl2xFZB57k5WVo=;
        b=CzabSMwRnDKXe2Edrx0aDmbD+TGPx7rWAh0IfHXg9nDSTiHKnHd4PT3JnRbvRwm4+n
         uYFjAgKJbd8NxYC6ya8wWc1+4OwbIGfqHOWgSyms7UwyeZU+xJCXum5GtRMOjAY+ZeUj
         U1PdOpdEotibn5fzHMIPaX3J9FEFO1l2gapVKM+x9Pz8z/wjpdZDDRsnBQsZT/aHhYmS
         w6+SZdIwSVwh7GWVXIHAwMh6U86u8JpZUVo3eEqrukmrB+7dkLc8DWWrXFiG87+2XKTd
         z+HXeBB6H2MxeXeLN8yFzRTs8RXGE6pznt+uu9DZLfJYt1hQI01GXHUtRq9E6BXYS9e2
         KKwg==
X-Forwarded-Encrypted: i=1; AJvYcCUrYdrDMBaKdwfBE0Ggrtbovuu8t+JAvzDDybqQja/vGDvjQDZB26v84arl9nwAIDGBKppGv1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPmDUo3m6P4BHHC+6IR/rI1OTgJNz+FlHwSiLLdbAnXhSalzsF
	hVJTgpm5ot4gacUoO9TyNQVBGmXDgWecvaVqtI1gPMTC1L8YAOnq79nnZg==
X-Google-Smtp-Source: AGHT+IE+zyxdE0SKKsLU2/zehxEygp6owIm1RLZc1ZCDM7Z5sL1pDTqegPs2EOPFXWC+TeLZdoIqng==
X-Received: by 2002:a05:6512:1193:b0:536:55cf:3148 with SMTP id 2adb3069b0e04-539ab88ae61mr2847065e87.31.1728085242332;
        Fri, 04 Oct 2024 16:40:42 -0700 (PDT)
Received: from mobilestation ([95.79.225.241])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff1d277sm83263e87.155.2024.10.04.16.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 16:40:41 -0700 (PDT)
Date: Sat, 5 Oct 2024 02:40:38 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Jose Abreu <joabreu@synopsys.com>, 
	Jose Abreu <Jose.Abreu@synopsys.com>, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net-next 00/13] net: pcs: xpcs: cleanups batch 2
Message-ID: <vjmounqvfxzqpdsvzs5tzlqv7dfb4z2nect3vmuaohtfm6cn3t@qynqp6zqcd3s>
References: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>

Hi

On Fri, Oct 04, 2024 at 11:19:57AM GMT, Russell King (Oracle) wrote:
> This is the second cleanup series for XPCS.
> 
> Patch 1 removes the enum indexing the dw_xpcs_compat array. The index is
> never used except to place entries in the array and to size the array.
> 
> Patch 2 removes the interface arrays - each of which only contain one
> interface.
> 
> Patch 3 makes xpcs_find_compat() take the xpcs structure rather than the
> ID - the previous series removed the reason for xpcs_find_compat needing
> to take the ID.
> 
> Patch 4 provides a helper to convert xpcs structure to a regular
> phylink_pcs structure, which leads to patch 5.
> 
> Patch 5 moves the definition of struct dw_xpcs to the private xpcs
> header - with patch 4 in place, nothing outside of the xpcs driver
> accesses the contents of the dw_xpcs structure.
> 
> Patch 6 renames xpcs_get_id() to xpcs_read_id() since it's reading the
> ID, rather than doing anything further with it. (Prior versions of this
> series renamed it to xpcs_read_phys_id() since that more accurately
> described that it was reading the physical ID registers.)
> 
> Patch 7 moves the searching of the ID list out of line as this is a
> separate functional block.
> 
> Patch 8 converts xpcs to use the bitmap macros, which eliminates the
> need for _SHIFT definitions.
> 
> Patch 9 adds and uses _modify() accessors as there are a large amount
> of read-modify-write operations in this driver. This conversion found
> a bug in xpcs-wx code that has been reported and already fixed.
> 
> Patch 10 converts xpcs to use read_poll_timeout() rather than open
> coding that.
> 
> Patch 11 converts all printed messages to use the dev_*() functions so
> the driver and devie name are always printed.
> 
> Patch 12 moves DW_VR_MII_DIG_CTRL1_2G5_EN to the correct place in the
> header file, rather than amongst another register's definitions.
> 
> Patch 13 moves the Wangxun workaround to a common location rather than
> duplicating it in two places. We also reformat this to fit within
> 80 columns.

If you don't mind I'll test the series out on Monday or Tuesday on the
next week after my local-tree changes concerning the DW XPCS driver
are rebased onto it.

-Serge(y)

> 
>  drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c |   2 +-
>  drivers/net/pcs/pcs-xpcs-nxp.c                    |  24 +-
>  drivers/net/pcs/pcs-xpcs-wx.c                     |  56 ++-
>  drivers/net/pcs/pcs-xpcs.c                        | 445 +++++++++-------------
>  drivers/net/pcs/pcs-xpcs.h                        |  26 +-
>  include/linux/pcs/pcs-xpcs.h                      |  19 +-
>  6 files changed, 237 insertions(+), 335 deletions(-)
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 

