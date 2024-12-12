Return-Path: <netdev+bounces-151502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BE29EFC99
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 20:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F408F168F6B
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 19:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A8A192B9A;
	Thu, 12 Dec 2024 19:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DT7Whrlc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C501B18FDB9
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 19:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734032333; cv=none; b=aorNcGOEReCJfj+Dfdw0F8bL8ZlbBwDpvNyoBGGlkA058cuJQ8llvXtKie64wedqMpo5UWZu5Y3Znh+9lrQ402VsobzTvarl1ow5vr3+D/HA+OA0PvGaeVIgJRTrfilWKvWp/JSQkevkJSPPIwZjs7lHjksln5xW4lZ3b11MxSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734032333; c=relaxed/simple;
	bh=B069AJ99yMLbiaxEMFlwsbpViIKqiXF2IyBppmS/V1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGqQBUqixdCn98goptyZfoHomsIXAZoraEIbv9s0Hmw7apwP6G9r7BPMpfYpoNV8EIwJbL+9HWQNQzc6STp88jtZ51eO5AplIb197Djw/jVgOCbCyL+VJZJXso2B7g6pcGguw1jKTIeASb9hrPFyz01V6R1Cy10E4Vw+EI7UgO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DT7Whrlc; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3862de51d38so55389f8f.1
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 11:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734032330; x=1734637130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B069AJ99yMLbiaxEMFlwsbpViIKqiXF2IyBppmS/V1g=;
        b=DT7Whrlc+tNVptwCMYPcUQ7Xzq8djlSRr9HDBcTW6piEtxlPDjAmYck4i+XXsGLSdE
         PgTRRQB7w24K1vvVHnqHyOQ04fTq7kMPF9FhBIQQrbAR6wPW3g+e4EzXaxOvNQ1qgPAk
         j+alLDbtsp1UPQ090+Y5DY8StRLI6lCYTXC8MY6yaigDQXAXZjXmHSYT7dXLjn6qDrkR
         Kcx4kVqogvKsrvzKgm7sPWBq+s6K1buYXq6jPhWZPdiHvhzSECf7rxuIJopvRRPDFJkw
         zzlofFk7iaVA2YVfZBrtD50quUFEESw7f1WCm99m/mXHEvVXwqIM8Ksc/SRu+vSgzeJ3
         4X6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734032330; x=1734637130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B069AJ99yMLbiaxEMFlwsbpViIKqiXF2IyBppmS/V1g=;
        b=t41nmVOqagE0mdk2yKJa9+OKGBkkZwdYPMDNWxiXE9RhXet+Y4iAR4h64Y7belKUPU
         1UEGmgSzbXTKexqmmZtZu3fIeFJkx9tmgqCPqlBgrkMelbUC2HYHYRWBfyzGuOTsOiy7
         1T2DXOhX9RIWZxqxdAEaECVQeNra1jvm0b7hsp7e6bldFnEVoQplP8Pbu/mOG+K0I776
         A2JZWNA1jU/4uJbGNXrKRmOuyKWsVBok3OBuR0JzArrqabr670rQP7GCi5vzVu6RbZJc
         ozoMhLps0oIgFo9iTa6rveOhvpa37Nmkzy94JTOaoRPIiuMrbOZF9cdGD2NAgbdhxUW9
         C4fw==
X-Forwarded-Encrypted: i=1; AJvYcCWh68tRrr5wZ0PjihHBvlW4CwDH1v3mCWvqmgrDNGKb/gZ4OfElVPUGU99QTJz0FZ9CWm29xyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzxHBCaEnqD9N5krfeu24Gb5Ee1KMQL+t6uev0UDXHKCKhGxCy
	hFIO8ELRkGfU/XrDMtDmHxWMipCcpauPvEfI85EjwopCh6TCY18X
X-Gm-Gg: ASbGncugWBgBvpkfUjB3WslrQoRDMT8t1dPokZJKnZKd01a8h1+W6KyxyLzvJAHucDh
	aCaETHmEU4FUuy/S6gF1blI1sxXiv4bMPkzx8lpiwIHrql6gKDLDwGsQSQnGTATSayPwBrGWRSI
	d28kqaFiYuY5CIrlQDFv3LaN1c38+b2h2/dQJPDLney0cfKktfrBNvOV0L6Tovv4iNRMsGX2OyD
	EktRZp62bqiJb2g77+QIBrJXk8zwzqTWIdngLrs6IAw
X-Google-Smtp-Source: AGHT+IE4G1PjDDwENlz2Lyv74KagRT5Yifxh/lMIeV3kJcj+rAK9HcqLLiw82iZvaVorQTc5hOGSzw==
X-Received: by 2002:a5d:5f8d:0:b0:382:41ad:d8e1 with SMTP id ffacd0b85a97d-3864cea57b2mr2521448f8f.14.1734032329830;
        Thu, 12 Dec 2024 11:38:49 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878251dbbfsm4798063f8f.97.2024.12.12.11.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 11:38:49 -0800 (PST)
Date: Thu, 12 Dec 2024 21:38:46 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Woojung Huh <woojung.huh@microchip.com>
Subject: Re: [PATCH RFC net-next 1/7] net: dsa: ksz: remove setting of tx_lpi
 parameters
Message-ID: <20241212193846.33qouvlhxspzqnbl@skbuf>
References: <Z1hPaLFlR4TW_YCr@shell.armlinux.org.uk>
 <E1tL1Bm-006cn4-Gr@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tL1Bm-006cn4-Gr@rmk-PC.armlinux.org.uk>

On Tue, Dec 10, 2024 at 02:26:14PM +0000, Russell King (Oracle) wrote:
> dsa_user_get_eee() calls the DSA switch get_mac_eee() method followed
> by phylink_ethtool_get_eee(), which goes on to call
> phy_ethtool_get_eee(). This overwrites all members of the passed
> ethtool_keee, which means anything written by the DSA switch
> get_mac_eee() method will discarded.

nitpick: will _be_ discarded.

