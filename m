Return-Path: <netdev+bounces-153495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB879F8476
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 20:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7A616B192
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 19:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5950E1AAA0D;
	Thu, 19 Dec 2024 19:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxLelSx6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DF119884C
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 19:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734636990; cv=none; b=NaAh3Aey+UoEuQj+j3auaej0YERrlQOtJrPd6iobjhL4jac/SuMg3M7kvRssO1xoiym0wCvK1GbtH4tDTJeLuaRrraNaMGCn84765SlomL6qO+RPcA8B/N8lqQfstcSMmmd7FEiTxAOK0NUHOlUm14T0zidhPGF6SYE1o/TZ5DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734636990; c=relaxed/simple;
	bh=lveubj0VEL4ck9qgYNmTpWbqyGevjKSYJ40UHQnXyMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tst+kjVw1/r56vmhKxPBHJiQ2GxCXkgIfoA5wudRGfEB59Ns/aU+Tyt5VuyPOKQw7YrJC0WnbjVqxkj3iBD7RHdhwmh0rxaIWo2jnuPQsy9Y+rJYm48LeDravgNaNDPM9eTHCdZkowj8UqcdAVGhK0gHnWl5c2pfL8U7JShYnzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxLelSx6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-436230de7a3so1506765e9.0
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 11:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734636987; x=1735241787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hZPDSqvcitYz9r/m0zc2M5jBBE3ytBJsMJxXi1MHzsE=;
        b=FxLelSx682ihSEdUF2tGSZUXp+7Zje6p8t8rkTSIgejsBWU8roeeZJhTZMzr74XC+G
         e7zFN2lqIP2VNoATwmH7rFVWp0OgpvUfa4K4RM+9zCWkjgqcrcFzOhs6d3ND3iezqLpp
         2xpqyuf3saOcYMEBmJbX1zpzDPgK9hvpH5ctdXUVhCwR+rVWOgrvHYXf1VwT8sn3fA3j
         Z4sFvUqTlO/A/DoFG7JkniljyVfkuzyOaYMgrqHo9LjCJlHfXyuIhScxXluWBzth0igx
         Hn8IhwWn6AT9lbgtnTABmmzXwQ9650anrEQ0SiAUcg0mo1MXEmsKwKHGpneyqLqGwJQf
         X4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734636987; x=1735241787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZPDSqvcitYz9r/m0zc2M5jBBE3ytBJsMJxXi1MHzsE=;
        b=bEku4P1YOty11ApeGd4IgbWcGFv74ZNdxZajApfi+ZN9DFJ3miSo7WnwBRyjZDNw25
         52pHwJpPasB/EJwLJYHN2jmbCH68O65tRFmw1KcayywSHkpkbz6bnkgso7QQRVH5cZts
         sb/M6COnZy7uocYnf+NG3CgDyBN3YPYuECpu0WN6osRw4bmqIKDHe3T7+bLvN3R+LZwB
         rOxYn9khVQXQNhvR5SIdgt0erna3tJML9CgeVUz7CxCp6NQM+Ur4LwnVG+bkIGH1Gm7t
         qLBt9liX3jqld3kKi/tfrlaoOFgOLU+vyAZ+PQHW0YR07YMgtOvFQCOTsviw73/xPPKZ
         yOlw==
X-Forwarded-Encrypted: i=1; AJvYcCUuZ/LmKQ58LT8bCJe/kuk9u9HGEiWUllHP7X85TgsXLv3yPzQJjoMSOi+G9nsXyLYSLQasI2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/IMshwJrw02tARBl5iF4FKs9pjZyZUXFcoLJ7/q6bUGaXWAID
	fAqDeFSVFheXNOl3wyJtWKjFzxLqtoYVDDCcBn0KYxZq12DBWumN
X-Gm-Gg: ASbGnctEsZ7eOVZD/oNOHf+jTEE6+t5CY1jxoVjTNEMtqcu3tOJ6XgTqMOFXNmdn9cp
	C4/ti5Cp6W1qu963hXOya65fRVieaCYVNCIYrxmiRkxIzQlf4VzpVkluJVlJvTQxKv2hpbt4XwB
	HhU9n+Z0BocuKWzNBRSSk56giQmQ704H4RIGKeG5wdW2VZm9IR6VZty4n5vXMce9IbKgFl4PKnP
	/215qTung7xx8OmVNneRUiHfVDILYdC2xwMH6fI2Udn
X-Google-Smtp-Source: AGHT+IG/TN8gfeuSQNwiVRIy3liqumUPLgcX8Zc69HlVjR6hgFx7WAEU+SoLcjPI0C96/VFWP2BIUA==
X-Received: by 2002:a5d:5f56:0:b0:385:f3d8:66b9 with SMTP id ffacd0b85a97d-38a222083aemr88330f8f.11.1734636986772;
        Thu, 19 Dec 2024 11:36:26 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8287adsm2209103f8f.16.2024.12.19.11.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 11:36:26 -0800 (PST)
Date: Thu, 19 Dec 2024 21:36:23 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: honor "max-speed" for implicit PHYs
 on user ports
Message-ID: <20241219193623.vanwiab3k7hz5tb5@skbuf>
References: <20241219173805.503900-1-alexander.sverdlin@siemens.com>
 <20241219174626.6ga354quln36v4de@skbuf>
 <eb62f85a050e47c3d8d9114b33f94f97822df06b.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb62f85a050e47c3d8d9114b33f94f97822df06b.camel@siemens.com>

On Thu, Dec 19, 2024 at 06:50:18PM +0000, Sverdlin, Alexander wrote:
> There are still switch drivers in tree, which only implement .phy_read/.phy_write
> callbacks (which means, they rely on .user_mii_bus ?), even gigabit-capable,
> such as vsc73xx, rtl8365mb, rtl8366rb... But I'm actually interested in an
> out of tree driver for a new generation of lantiq_gsw hardware, under
> Maxlinear branch, which is planned to be submitted upstream at some point.
> 
> The relevant question is then, is it acceptable API (.phy_read/.phy_write),
> or any new gigabit-capable driver must use some form of mdiobus_register
> to populate the MDIO bus explicitly itself?

See the documentation patches which I never managed to finish for general
future directions:
https://patchwork.kernel.org/project/netdevbpf/patch/20231208193518.2018114-4-vladimir.oltean@nxp.com/

Not explicitly having a phy-handle should be seen a legacy feature,
which we are forced to keep for compatibility with existing drivers.

