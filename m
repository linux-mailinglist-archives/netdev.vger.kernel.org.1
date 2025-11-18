Return-Path: <netdev+bounces-239509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB96C68FEB
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 12:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A9D2346454
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 11:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B0334EF0E;
	Tue, 18 Nov 2025 11:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RavKYT+x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A772B34E761
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 11:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763464089; cv=none; b=H09iwy80UagzVHmO5/HUrMfL+YFqq0klgyFZgl1Sdd6nCiN7BXpk99v8k3Xams6aOZ+RfBt0t/2zuHR3GvyC2PGV5Br4drq5dXF7jB/Xzc8Iir+NN4lCNfbxXfdTcCVMgnepUxnK610t+umjYey/zOLG0mUFNpuZIdtgSBR3kto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763464089; c=relaxed/simple;
	bh=GV8FQ3eNIT/+xB7w7ijUUdGhF1aGprfG1JgLRmP4eE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saoPcYQFXei5Eeu2+gqqDeQ0mbmffgloHYRcpop6ZBQKvRu86pOyVvOyTeQRXZUoXeaNn7rUbhUI1nJLooXxcMvSnOBhfO3sj+cd1Jxp5biJhQSe4GZv++P1L6KcpU9kBcC/VGmLppjZWIPeebyTCQTVjDzDikAYUdcw2RFRmzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RavKYT+x; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso21111975e9.3
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 03:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763464086; x=1764068886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N98Pe1e5VEGFDBS/VZ7pBrHXW51O5Y7q6gPyvhlhdfY=;
        b=RavKYT+x78zFH9F20sLRYLxqaVUMNL8vKLO6ZwNrVDbVfbwaOawvyZnUD4S5cnzwKp
         fbYyWcxo928bADoUfvStVXrdvTb5cvKRyEO9bLoV6m419oYpfjYkqs1+V26hc1ccKR26
         XgjA2lgZ0wa5JatmWM3V16t9khLMsnr4Ea1cOmCLzW2s78ofeTLMKye+vlBOOsXYht5l
         Bnuzx02moCj5s3aithrgZMUiuuV0EAZhFNkNIwL4rDC0J1sFTeZA2mfPFJ9zZb26I8mw
         i6OcApI0oZvbNYzaH7FFMTbqmjKiFksDXbvy06WyXK+9yyfxLPyunk66HAOaUnONcIzT
         ex1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763464086; x=1764068886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N98Pe1e5VEGFDBS/VZ7pBrHXW51O5Y7q6gPyvhlhdfY=;
        b=cgR785GOqP9/fBSIvZX9YwV4lXne3m7yqkD5pl4UxMSFgYeqWX1G8HqxM3x0Ty8DEQ
         Gm1wUh02UtbrTXyIDGu97y7SvjEIxNxmsWC0Xol2c8/ZPN9yR9i6kih5mJx2iTBXPt4A
         d/AaYS+tftZiaR7yl4AaTlK8/PI9/XVOKad/dFY2ZOnxm6vjo7NjNAF5sMlipUOIPQh9
         kfsTuyXWUKLeXdOHPZ4XvLD9UoIVrEvVeo+Judwsg3Sbw2+5SD1UWc74lcrEH8YSIJts
         6u+fP9kCtU07IlJu1/gAAURsefxEZmZ5mD9l5mkdmx8SZW4TlW4PyRznUVA0XWgAdqRw
         FJQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGykAO74IIQVGTIyGO5As5TWN3HcGoOher/muRSbvnvKLU5CwX7qlKLymIu8I0WmfwaVLs5g4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuzWkYt4eZ351JT9E9YgIMNvqoRA/P/I2dia5mC353rhprNNzi
	xwXJvJXBxAF60fxZag4wqUV7eDuWe76UOPvhApr8qV4njImlKAPBs1noihcHQ8bX
X-Gm-Gg: ASbGnct8rWA4VfAHO6AMEJB1bkW+6vp7hDLJsLs5D2TqiVRr3isvmNL5mLS9dpTU0fs
	ck+3MzDHQUFSUeDxyhsm7jCohLxGAMb2TC+PA0j2KoesQz7TsC1odPAtH5TGw5h5V1xugAyjtXj
	IfXZ4qN6DDHdxRDi6mXgAw4/EgLxVhlG1Nzfa0fgOsVZGAKS7b0zeJMlH1zImMbDuR4iZNiMsER
	4s3d7mtbwCb++zQRsrabWlqmDhZ05zOU9Vt9oJ4zvfArqozIMWGWzvOI4Xgv15n8LeWMwffqaxZ
	ntfXZGXFC7cg481FByNHSR2dohu2e0oRqP7316nahx6TqWm9nP3Ije/0v8p57nNAVq1AjLSgnnO
	2kDGio3NNqNjFZrzzJpQW7NuhUEquBl+A9Kg/ZvtIbn/GJZt3+7LRCe1jzkjssZWkotq/uSDsYJ
	JLYwBQ6IYNqiCduokZjUEIJxzL0A==
X-Google-Smtp-Source: AGHT+IHhBQ+SOW9FB+mUYjIqlnhQ8s3Igj2q1Qsqq1WrBjrlDkH+ap8ORZ1KcYn1dggyWC/R4J+11g==
X-Received: by 2002:a05:600c:1d19:b0:45d:f83b:96aa with SMTP id 5b1f17b1804b1-4778fe51e63mr136760215e9.7.1763464085764;
        Tue, 18 Nov 2025 03:08:05 -0800 (PST)
Received: from google.com ([37.228.206.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b62dsm31625842f8f.24.2025.11.18.03.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 03:08:05 -0800 (PST)
Date: Tue, 18 Nov 2025 11:08:03 +0000
From: Fabio Baltieri <fabio.baltieri@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] r8169: add support for RTL8127ATF
Message-ID: <aRxTk9wuRiH-9X6l@google.com>
References: <20251117191657.4106-1-fabio.baltieri@gmail.com>
 <c6beb0d4-f65e-4181-80e6-212b0a938a15@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6beb0d4-f65e-4181-80e6-212b0a938a15@lunn.ch>

On Mon, Nov 17, 2025 at 08:37:41PM +0100, Andrew Lunn wrote:
> > +	if (tp->fiber_mode) {
> > +		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
> > +		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_10baseT_Full_BIT);
> > +		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
> > +		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_100baseT_Full_BIT);
> > +		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_2500baseT_Full_BIT);
> > +		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_5000baseT_Full_BIT);
> 
> An SFP module can support baseT modes, if the SFP module has a PHY
> inside it. But it could also be it is a fibre module with a laser and
> so uses 100baseFX, 1000baseX, 2500BaseX, etc.

Right, so for an SFP NIC would you expect ethtool to report only the
modes supported by the module? It'd make sense, like right now I'm
testing with a 10GBASE-SR module but as it stands ethtool will always
only show 1000baseT and 10000baseT.

> To do this properly, you need to be able to read the SFP EERPOMs
> content, to know what sort of SFP module you have plugged in. Then you
> can list the correct modes.

I see, unfortunately all I have for this NIC is the out of tree Realtek
driver and it does not seem to implement the API for reading the module
EEPROM data, and there's no datasheet available, so I'm afraid that
either the Realtek folks pick this up or it's not going to happen.

In the current state the driver matches the behavior of the out of tree
one, which is to only report 1000baseT and 10000baseT as supported,
which I guess is a good hint that that's what the user can set the card
manually at. Are you suggesting that I should change this to do
something different?

-- 
Fabio

