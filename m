Return-Path: <netdev+bounces-69472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8471084B65B
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E611C21124
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 13:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B11130E2B;
	Tue,  6 Feb 2024 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUWbUDj/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016CD130AD4
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 13:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226170; cv=none; b=qCGwMk628H10gr/jBEzfSuB/eHcy+KeC6nUIO1I7HXai94wgc40FewW7s8FV7q5IwhLj0HeQUdFxtmwSDnB75rwEYLHBk0+c8kuNtZtHBkBLgbw2F+uZgY84YHcvn6gn3xetRoQQ5DF0qUWrHKbkEQtTSWEVonoftAnIP4CICfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226170; c=relaxed/simple;
	bh=nwvEGcgiwQhQF9OEUFrrtJKyA3WCqpHSpAv6LHGajGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PV9KPHpb22pht9BoVU/m+38wWLWl0dDZGi7twFZpo9yvIQKi+vAF5DvWLlfB8rkYoyBrXuikrryYpuA1wC84h54Mp3bvVoWikprgAsqHlemo+SJfyQwgzYd7VTSUZkcXMDWkyCkp+znzN2tS/K/nesLQMyLCRzQHIfuvRD6sWY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUWbUDj/; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55ad2a47b7aso7167465a12.3
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 05:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707226167; x=1707830967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T3K8mbqYkN2pkZybDOCl4vjMSCHUwiGmdLNrVAvodoY=;
        b=UUWbUDj/1WBK9m7147jrOmpyScVl/GfHBUpcCqmJngAQYHF9JavRXxORGVzWv90tu+
         gzkZB84wiKkUebjyhwWezLUrl1Z237FSrGZwQ+ZKnoJYS1DFn/BXOFnwg2d2YOKHJ4W3
         4ukaFet1d+5RaWfn+Irg1himQbeaLWIrCfDTKMvgGaEA0awtbnBrbyGELw/f8biisBqI
         I4jvw9fX88vkR1oZ3Du8FR2nzWiDg5Yrl20fWkYpyqUT1CmQEPm3SoGbX3gnBKPA7tq4
         SF4iBLs03GofLXZENaRo82WsjTi/+eEgaRRthKTeTbPnVv6DgF/tyO3N/V3czz+veboW
         /zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707226167; x=1707830967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3K8mbqYkN2pkZybDOCl4vjMSCHUwiGmdLNrVAvodoY=;
        b=xOGvq426oWocz8KhIoNlNr/XP9kzJlCWJJQ+iZv4DFQkaMbCiUD4B+wrMGIBP/1O7Y
         ZwvDl7XrEFN3bIkFXfJw7M7gKhyOYGsxSNJCHf/gsMdCEYmlP6cZ0ptdM81ps3pr7xRy
         qqJY9oqZMKCVgvGDoFrn4ndzJLyyj0NVXHojJAb4RbzPipkMnTyfR2Z7NfkLcrcKJ2eP
         9Wq5u06vlGqy4W/1icJJ/vZM0Qs6fiPwNGCkaybijoECPA6fWXWvME+3ZIcarcJcyOHf
         cnvnyNFlBG5HfgD3LtfyKlv7ZpAbeU5b/hWS3XyHQWtq2J1s0O80fXxsufqYi09+/q+W
         1Ecw==
X-Gm-Message-State: AOJu0YwxxlREJ3GF4AgKomliEGRGPWNBM+hwCbLRUV6dyR29/Znno3R2
	TxyMxBhdGkIbheaVWnga6iVSqxK4Uzkvm5+FpceV6A+o0fna5JTR
X-Google-Smtp-Source: AGHT+IGTLVlI+eqWQ1ZQHpgJ55q3BV6R5mXCQxRL1l7fryYx1ZyrC2J6wB/lmr+IJkT8F+ppYUfZzA==
X-Received: by 2002:a17:907:7f17:b0:a37:7fb9:ea27 with SMTP id qf23-20020a1709077f1700b00a377fb9ea27mr2353193ejc.48.1707226166913;
        Tue, 06 Feb 2024 05:29:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXk8hbCICCWddyCzOnK4U/3MlJvCaV6Wpr8b1jGhhgqCOBdc8qhnubiPfFoS0MAPd/0dffFuFzHlR9IAyVo398lMI/r6ANV7fOIjpmQyicICoI6lbsqnHDAdu6wzUV4zswDsBD1Za/4BBdWU4s6nnP1ldHTrMw/gzlp+VIC9Fdj4AvAn6kWbRhr8lwv+QYH8qyDUdGhwHeKd1TjOEXRY0Yjaly+wKTINW1KyHG8D3XnSj6ztr1HvyDI3AdBhkt7kR3hcXuOtZsF7uriIqp3AYgU8TBlbMPMYjwQpGUj2F226OMakQwNyLODHhsFqCXKsDCYAhEm91M0VbxioWFRyH3UPGZrkcjov+nH85+ySQjCsFsULQBXJYjc2gK0Ph0VjuxbUrgAUG5NkLhcmV+O77qsehH4hWbk3ygPoU7POkNjuApBE1RRK+ManeeTi56VNVD0pnbMlg6XINvE4H2GEv5EUNjceNNiY6yJmPtPbB1PBZV9UFMYK0cGHqFLJMCk2D4LofN3JIjl2c5TgrzyVaNywp1/1aiK1+ZbpTBect2MRkezoWJOrzt0frBaBHAMnuXVJ2dUbXVPS0vuD4BOwS4hO77KB9rH69OjjO/2t8I0BgI39komLmZQ1EjULK9kow0dFApOOv6+27h6iT7EXGbdwKbRfWqvIDDSXFtnhIIdRgvQSzsf77IUz/BmUv/xrgjEtuDG
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id cb6-20020a170906a44600b00a35a11fd795sm1137050ejb.129.2024.02.06.05.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 05:29:26 -0800 (PST)
Date: Tue, 6 Feb 2024 15:29:23 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Byungho An <bh74.an@samsung.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Justin Chen <justin.chen@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP Linux Team <linux-imx@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Shenwei Wang <shenwei.wang@nxp.com>, Wei Fang <wei.fang@nxp.com>
Subject: Re: [PATCH net-next v2 6/6] net: dsa: b53: remove
 eee_enabled/eee_active in b53_get_mac_eee()
Message-ID: <20240206132923.eypnqvqwe3cga5tp@skbuf>
References: <Zb9/O81fVAZw4ANr@shell.armlinux.org.uk>
 <E1rWbNI-002cCz-4x@rmk-PC.armlinux.org.uk>
 <20240206112024.3jxtcru3dupeirnj@skbuf>
 <ZcIwQcn3qlk0UjS4@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcIwQcn3qlk0UjS4@shell.armlinux.org.uk>

On Tue, Feb 06, 2024 at 01:12:33PM +0000, Russell King (Oracle) wrote:
> > I know next to nothing about EEE and especially the implementation on
> > Broadcom switches. But is the information brought by B53_EEE_LPI_INDICATE
> > completely redundant? Is it actually in the system's best interest to
> > ignore it?
> 
> That's a review comment that should have been made when the original
> change to phylib was done, because it's already ignored in kernels
> today since the commit changing phylib that I've referenced in this
> series - since e->eee_enabled and e->eee_active will be overwritten by
> phylib.

That's fair, but commit d1420bb99515 ("net: phy: improve generic EEE
ethtool functions") is dated November 2018, and my involvement with the
kernel started in March 2019. So it would have been a bit difficult for
me to make this observation back then.

> If we need B53_EEE_LPI_INDICATE to do something, then we need to have
> a discussion about it, and decide how that fits in with the EEE
> interface, and how to work around phylib's implementation.

Hopefully Florian or Doug can quickly clarify whether this is the case
or not.

