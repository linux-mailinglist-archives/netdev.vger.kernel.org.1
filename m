Return-Path: <netdev+bounces-142302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68299BE275
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062221C23457
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E111D90DF;
	Wed,  6 Nov 2024 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLx0wJSv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC001D54F2
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885137; cv=none; b=VKLAnVL9qoI0JtBmT6IvfsdgiEX4VlDEs0CaADCW4Dtvtg52A1QC1wvSWT8UcXfZtogV5dZwPUMa2QZYtNjhAno02MQVBxkQS+gPNFwPYq9l7DlseOtpoNzK5MEq0q7cFP+/JUQCdQHGGPwwGsLLSWrrecvUmdm3WYbxQtMuQFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885137; c=relaxed/simple;
	bh=Vg3irSEbuhmpXQovVj2ihzBCFndIs1U0sMSPT2KP6oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uArFprIB6Kc4saac0bJPDWHY4D9Orrgx7oWfHqSJeOvXerFrFi5dUOARpg92MoeOOsXjMe660GjHUm5u3FpWElYD4fv+FGoZo60i1AoW0E5lD1AucMZObbmZje+AJI8wKc6jSrroMTjp5G4ElMdXYxSuYbtU9I9pk/ZFWgb4q+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLx0wJSv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c714cd9c8so66132455ad.0
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 01:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730885136; x=1731489936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bHWQude9/8/s2DU++7CNla/VfF5xLcV0pRxg+VwWGE8=;
        b=hLx0wJSvJKT/h5yZ9x6iYA8GcBsZ3ITF7mlHwv9cnEa6kfjBCMMZqGpj3JcstKyf82
         dZ7JWxSEor6AeDS85vmrnTIezNYq7CENPOHsQbrBExYz8ru2sqaKa/FYYQ2Iz+oJALHD
         IDlf0mcVRRooCIzU/QEkBKHhKRnaJU3c4PiSXKU9zygrMdZzAOZas8i/qXCmmYQzj55G
         9zadpzfeihnnBesAMpByUrHq0/NVjcnHc5aJ876GrgG/Fc2JT9mz9jEE2Jbt3nP2sP00
         SVNAMg29l9cT3v/qpK2bhNuWp5m/zfBtqySwnuReL795BCda7n0Cd9g1XI//zS9/vJdu
         gZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730885136; x=1731489936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHWQude9/8/s2DU++7CNla/VfF5xLcV0pRxg+VwWGE8=;
        b=TeOLiTapnVaSLA8sIuaIZTX32EU2/l2qHBrUBnXcRBvB+iI2TFEoy98pfrB9SSIZY+
         SYAd67o3ox4t+DhYxj/Kr2EL9tK53Kgss5xtCr3PtwC7pkmr2v4DddwdotvPi0n+gX5u
         oXlaweguchRFDLL9EIIFEqbVcPyWIsIFfgD/bWIcaTWGu3AWi4Bw6bH3YFBKk/wxKRxl
         GXXhA++Qtmye44LSjDJxtqadXZqjc7tVSaDWWnBcyCk9zew5Tj6OU2Yd5CYr6245faDi
         jVCApDGrf3SMWIawtXZE+inHfPiwcxRjPM0RFOdhgxe6w+SiVWiYAylyXIAbfhKyjvAO
         Qy7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQZnJWfejJ1zfzE/mU9ZXh1sH2FLCqW/SEF01jBgCz6eylpz2f7FmDaFg0LnERJ1dgrKk1xlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6rVtqdaWROzvGCc8jsOHOvYu6odXdMaEb6eDiMsRaJF2VfCjp
	iBM+z6b/9rMitGhhNx+Q7Tc3Jq4lsrDTDBVm1zfk6ieFGtQlzQL9C06/eAqFP9Q=
X-Google-Smtp-Source: AGHT+IH47Kwtk22jfkwVIdu4nwSs0lKgC4kXCaEPUvYzZxLxKsck08Fj5syGPZRCF6arI2FyZbKrRQ==
X-Received: by 2002:a17:903:8c8:b0:211:6b25:d824 with SMTP id d9443c01a7336-2116b25e37bmr32883155ad.35.1730885135498;
        Wed, 06 Nov 2024 01:25:35 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2110570891esm91339525ad.104.2024.11.06.01.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:25:34 -0800 (PST)
Date: Wed, 6 Nov 2024 09:25:30 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jay Vosburgh <jv@jvosburgh.net>, netdev@vger.kernel.org
Subject: Re: [Question]: should we consider arp missed max during
 bond_ab_arp_probe()?
Message-ID: <Zys2Clf0NGeVGl3D@fedora>
References: <ZysdRHul2pWy44Rh@fedora>
 <ZysqM_T8f5qDetmk@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZysqM_T8f5qDetmk@nanopsycho.orion>

On Wed, Nov 06, 2024 at 09:34:59AM +0100, Jiri Pirko wrote:
> Wed, Nov 06, 2024 at 08:39:48AM CET, liuhangbin@gmail.com wrote:
> >Hi Jay,
> >
> >Our QE reported that, when there is no active slave during
> >bond_ab_arp_probe(), the slaves send the arp probe message one by one. This
> >will flap the switch's mac table quickly, sometimes even make the switch stop
> >learning mac address. So should we consider the arp missed max during
> >bond_ab_arp_probe()? i.e. each slave has more chances to send probe messages
> >before switch to another slave. What do you think?
> 
> Out of curiosity, is anyone still using AB mode in real life? And if

Based on our analyse, in year 2024, there are 53.8% users using 802.3ad mode,
41.6% users using active-backup mode. 2.5% users using round-robin mode.

> yes, any idea why exacly?

I think they just want to make sure there is a backup for the link.

Thanks
Hangbin

