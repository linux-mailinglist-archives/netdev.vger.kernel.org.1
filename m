Return-Path: <netdev+bounces-211333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32881B1809E
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 13:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633395A0657
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 11:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200B137160;
	Fri,  1 Aug 2025 11:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHbEyIcx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6472B2036FA;
	Fri,  1 Aug 2025 11:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754046074; cv=none; b=s7pLFBidUDjE3x8x6uT13LrpcDrSD1l078roHKtKHRuJtbDX5YGbf1bU0buuM79m5d3b7Gab1t/D2n1sRAjKt/uDIcL8Vcc/E9vhRoXe4EB/0N/uLkhT3k0LVMWzyP1ATHbO2Xs4karmADMQ50IGCfejFi3amh0pJxdsgZl0/60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754046074; c=relaxed/simple;
	bh=KlYIWZ4TALxBfRB6CYtCxh63NNLJKyjPIcd3nY6Hy5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XknbuCi6MwFqXWZMdEeiky9DxPlnN1wmgltOlcOUvpIi5uvhb0W72sReE7LEV4Be6PAG36mmzVcMCO8lN853CHXQx3Gunwhq1sEopXcQYdTCDDbPfB+fZhCoVHIp2Pz+yTLHIKAgpYyzb0CcT1euqTnQI6R+UYVupzJC6jf2o14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHbEyIcx; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-456107181f8so2302905e9.2;
        Fri, 01 Aug 2025 04:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754046071; x=1754650871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KlYIWZ4TALxBfRB6CYtCxh63NNLJKyjPIcd3nY6Hy5g=;
        b=JHbEyIcxGuFjnNk9FGcdgAcq1sMo1Zw42dy7QdKCrghnFXWRt73b7R98cs2j4l/8jb
         tov7+ijCe/HRSyFuE4+dLGiWBstUPgoYc5yk6m4q1rtpR3zxoLaKCspm7lC7iMJrpZKF
         asYwGisyDC/mKpmfgT+AqiCtTXXK/KJROmMwTpLaz/HlSHzbBPM5tPxtRL10ZCTIJ4zN
         hoSTTYnYzunVcZRFL4OmryN90IqfFu0D/4rMzS7DzJ1FFxsIjBQu45OzF5y4ws0RjbS+
         YQBFnWYgfsf/G1KVq953fM0kf6FB+Mf6qUubM4yTGVEXM4TK8Fn4w7CzsYPqEmacLZ7t
         mZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754046071; x=1754650871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlYIWZ4TALxBfRB6CYtCxh63NNLJKyjPIcd3nY6Hy5g=;
        b=K1/hvYcU20nDsR5w0eNOYznS9EnT7juQ2rY1TfGqCkRPr1p/JgJTF/VbaQWb7+MH5I
         r6D8T3dJA4vy47lwbYyw+2GYdci73tGGY0rKE097PuoXCPGftBAsSbXWyt43xFeEaP83
         rpKlU/qHemmWhZ+eBvnKAqgq/Qnjkl6jPzngwFToeGdijlSFK83QRebHPqyUPCwiU/II
         o74668VkAOhl1HdXzcFXIlu+M4L9aRWs9X9h+a0F8gY57yCqIN8mF8cW+eY3mVDxl5++
         ORXdDkk1Zn/+ZdcThaiZUfYFV9i2s29Ojsu/upoit4muGmFOYnttnhy4rwjVEfQTawDN
         9dCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVui3mxc7gbw1ERpn6ZptGidKOnRivMv4ZT9hzWaZTXswkz70ywpO3n+TMW/5uJQOWaUIqdKfD@vger.kernel.org, AJvYcCXnsVZij+T2r1uNDCPuVkQh3CsqeS6X6UXTjZr03dmW75Rg52q80gIktSv3GRLl/pUaEdJP+Pn2XlO6i7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBoG+kngzHxXv5BJoum2WNf0h0jzujPyNDmCYqqrnE8ii4Jfb5
	1VvxDEXDZQaV+Gq5fIEmaSVJ4f3ycnNOtWt5l0e75JODid+HXc99jdQ1
X-Gm-Gg: ASbGncs30seIR4vNClT2tTt0jZ7pin3USn6KdJqcOI6MeMHWwuMjoXUoZS+zkrGH/b0
	2mgLpdPRTVA/yHHOtktmcSffT5P3BmOQNE31fJl1DWWPZpo5aR0Y22O04SG4fpjhLPPx/DyLBBB
	hk2dvbihUl8wPs7i32Lk7St/lQmbMs7gWms693Ls5vPSg6V1TZVAcC6PqexyVlLtFmfjEdHlu4i
	3/qPZZD8L7lQbrxlkPqo5DqN7T/oOoZxpZPIbImIzcqa9Av5yJNVPGhW1HVLD03lyjTR34n6eiH
	xrnR2oI8dPaFrLaxtXgQkCD0i8C+o3YRmHr9yIux7inZDuiWahiQtFG4o3PBt9MqoV9TtPmVnJM
	NahTbN6dXlv/AhL/N+jDjvgzVVMViN5g+lUPZ
X-Google-Smtp-Source: AGHT+IEaCM/TfoH4SCYb4TiCJTryf3gaT8s+N7/oc77tXeelfi/kjnxwmcJjbykOxxyeu8vhugcS2A==
X-Received: by 2002:a05:600c:4f50:b0:456:285b:db25 with SMTP id 5b1f17b1804b1-4589ef53d2amr25904085e9.6.1754046070412;
        Fri, 01 Aug 2025 04:01:10 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d30d:7300:b5a7:e112:cd90:eb82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953eaeeesm108107395e9.25.2025.08.01.04.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 04:01:09 -0700 (PDT)
Date: Fri, 1 Aug 2025 14:01:06 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <20250801110106.ig5n2t5wvzqrsoyj@skbuf>
References: <aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX>
 <20250731171642.2jxmhvrlb554mejz@skbuf>
 <aIvDcxeBPhHADDik@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIvDcxeBPhHADDik@shell.armlinux.org.uk>

On Thu, Jul 31, 2025 at 08:26:43PM +0100, Russell King (Oracle) wrote:
> and this works. So... we could actually reconfigure the PHY independent
> of what was programmed into the firmware.

It does work indeed, the trouble will be adding this code to the common
mainline kernel driver and then watching various boards break after their
known-good firmware provisioning was overwritten, from a source of unknown
applicability to their system.

Also, there are some registers which cannot be modified over MDIO, like
those involved in reconfiguring the AQR412C from 4x single-port USXGMII
lanes to 1x quad-port 10G-QXGMII lane (or "MUSX", as Aquantia call this).
I am actually investigating this currently - trying to find a way for
Linux to distinguish "MUSX" from USXGMII, in order to upstream a first
user of PHY_INTERFACE_MODE_10G_QXGMII.

