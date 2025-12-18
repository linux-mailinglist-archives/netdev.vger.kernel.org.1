Return-Path: <netdev+bounces-245291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BADCCB0A7
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 10:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF70C3014D88
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 08:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EED2E8E16;
	Thu, 18 Dec 2025 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lV9hhaQl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF13725A354
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766048383; cv=none; b=iMquQdGECIB4dnGHUIJAWDhvtrAQqZhfbY84Gv9X9/OezSnaq7TEMKwX13s73lHqU6tAsFcKxRmaH4PIfqpZ0+zwWxE4Qf40PccF5sd/nVpe+uFS/QkNz1zduajfHJzOvJJMx3HhCY+dDN6IBGgYbmHxo3IplGr//1rJgV4vQZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766048383; c=relaxed/simple;
	bh=7ZE8YPQl7QsEhuKovaLGrW39lp3Jy3s9vIV+4Kv2ZBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M28MEgNJrez0ErBWGYrZmuxhTeMsZmY9YcXp4XfkzgTDyZ6tcilrLyCwB/klvtBhrUYwEd+sWLvgYwTA9rO3VqViqQ5QXpHDHgDIJUjZGvUEeQIs783M4Y20oYjEmc+acY/AMqaW46g9EuUz/sVNecE1ZkfSJOm+mV4peBu9Fxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lV9hhaQl; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42f9ece6387so103729f8f.0
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 00:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766048380; x=1766653180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=om2rKE1N70JJX4v2/KTDKJc7zTx25w0NNYinUpFagbI=;
        b=lV9hhaQlmT9xH5Qk1aelHxDmRnbcj2JNUm0zvUXX6BTIzYzDgFvgSooARdvnhDOfnn
         x3diu8N8W8b+BzAiVU+EsdbPG1RoQlCOLcw5bXJhia/AJm2cJG1NVE3XZgnRyF8gLmQk
         KsILHfi3ko/P/tlnOj6t/+6QwGSRs5YAHP2usPRIM0SiOJO0/P8L8X7flNsUidmk/an9
         x+0gF2bOMqauME+ktt/8k/zyGshC+p1gW4A0Wts7hHLUQ/3gyk2ptUoo2CTV4L1Hexlq
         2zdHJek6DhFL17GtwjB3GKzebndVVvq+MFd/ZjrhKd+M8dg+58otg7GIxrqyI3X6T2hK
         GH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766048380; x=1766653180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=om2rKE1N70JJX4v2/KTDKJc7zTx25w0NNYinUpFagbI=;
        b=h+5BQNlaS7/a5x5S+LfQsAX/1/yncFQJWKdKDeyzsoecBjDka+UcP1PAzbgBzZwZVn
         eT9cjvVy0huceHMJJX9vS2L79sdT9zIsBBRWGvsVskaJkIjli0gNQTUPNEaO5pnsP7lH
         5pLJDyE2hC4KpP86q2EcbkrdgeNx/IsF3oUklYnbZ1gzKHl6+WpJaLPAT64unWWmYegb
         VNVO1XSyFpfyX1Xm38SPSibWsqvaHhRV3qmg04h5kPnhmuRC8DIEnWKNAoaWN/oMAjy2
         DCzm3bTCw7Lf9068WrPLSszs6xfrEj51fRSnrzppjNjNBjO1sWHo4PthmIBsFwQdW3lA
         MxcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtrTmNdT4P1Gr5u8jvx6MpdMzolDqakL0rJLUGjGFLV4ZwYd9ByhqqFYe0Uray8wX91Ky8/Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOAiRVa+ryxbSxq6TDk+MkMaweulhw1usOgl6MoUklzqL2Vd0F
	im1QF4RreI98vUE3Mi/QDEa3NOCRiG7KFa6UxdaBeqM7RA5kLpXDtCWD
X-Gm-Gg: AY/fxX5cGRcJ0/qL68S85Bo0wmlLODRUwYN7Zxz8BxmwtaGSIuNq0IlkR9sThfzyL0V
	+gUFt5ygUwCU9aVGewahY64yownqCt3v61csRlLoc9dookg8xmdOt+Ddf9SN3+hYq66N7vuwXC4
	b7XfhAkZ+5Sp60/Tc/nbA/m2MWeMB6klJNBZsL/gKMYzvVle9oQqnhzIg3dUWx9CsXTl0n6sdE7
	pXBXJPNwZONpBKU6PQz9ILwnrcIxk8bOzzmv6X7zanFLfv7bEvPxBGpeawFs9mTIvsYOX5cnQca
	7NRbueir8PW1c+PYSY0e0GZDyA5cpMx93uWu4skO1xZgdZmO3hbKqqB2AoQgJrgdlKaj0ShYVCR
	vn+5n45Va9q4F9WCKI1/i5XxMc8FNfy5XOHb863nTPElmumf0+9vB1UR0a8/gPuoyHUkawjPEkr
	/T6xW0un+AuQ==
X-Google-Smtp-Source: AGHT+IHxOQV0spgMiB52IXhgfbDdjuVcdRSJjF49j8AXe42emIt9cYPpNASAPSENE72KVOdCKF+RWQ==
X-Received: by 2002:a05:6000:310c:b0:431:9b2:61bf with SMTP id ffacd0b85a97d-43109b26377mr8616701f8f.12.1766048379911;
        Thu, 18 Dec 2025 00:59:39 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:12b2:a0ec:fe74:248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244998ca0sm3716959f8f.32.2025.12.18.00.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 00:59:39 -0800 (PST)
Date: Thu, 18 Dec 2025 09:59:37 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	hkallweit1@gmail.com, linux@armlinux.org.uk,
	geert+renesas@glider.be, ben.dooks@codethink.co.uk,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, francesco.dolcini@toradex.com,
	rafael.beims@toradex.com,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH net-next v1 2/3] dt-bindings: net: micrel: Add
 keep-preamble-before-sfd
Message-ID: <aUPCeeRkLwUBBlax@eichest-laptop>
References: <20251212084657.29239-1-eichest@gmail.com>
 <20251212084657.29239-3-eichest@gmail.com>
 <20251215140330.GA2360845-robh@kernel.org>
 <aUJ-3v-OO0YYbEtu@eichest-laptop>
 <aUKgP4Hi-8tP9eaK@eichest-laptop>
 <20251217135519.GA767145-robh@kernel.org>
 <aUK-h6jDsng0Awjm@eichest-laptop>
 <49385cb4-6ce9-4120-9dd6-c08d763f0564@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49385cb4-6ce9-4120-9dd6-c08d763f0564@lunn.ch>

Hi Andrew,

On Wed, Dec 17, 2025 at 06:04:56PM +0100, Andrew Lunn wrote:
> > > I think the ideal implementation would be the MAC driver calling some 
> > > phy API to apply the quirk, and then that gets passed on to the phy 
> > > driver. Surely this isn't the first case of a MAC-PHY combination 
> > > needing to go fiddle with some special setting.
> > 
> > I was also hoping to find something like that, but I couldn't really
> > find it. However, I will try looking in that direction. At least we can
> > identify the broken MAC via the compatible string of the MAC driver, as
> > they use two different compatibles: 'fsl,imx8mp-fec' (fine) and
> > 'nxp,imx8mp-dwmac-eqos' (affected by the errata).
> 
> Maybe see if you can use phy_register_fixup_for_id().

That sounds really promising. Thanks a lot for the tip! I'll try to
address our problem by registering a fixup.

Regards,
Stefan

