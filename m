Return-Path: <netdev+bounces-245165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F31CC858D
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 16:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E560730A7E8C
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 15:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CDF398B6D;
	Wed, 17 Dec 2025 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLKVEgDx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EDF397D17
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981837; cv=none; b=EbIVEZd8L1W8hgdduZjE0zrxZ64crSBsNU2O4i5EkMjXgNHdOntlVZQxnI3vPzW9dsmFRwi5tIoZw86yy+Df5/Na7vVIqoqaAsliDOuLCLJngtOdP9ITxcL9q0cG5UwwCf66hF9H0MblyYHeSTS5FLRtcNf9ynSf+jyrb+W6Kck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981837; c=relaxed/simple;
	bh=SMAij2UriwHSdZLlFoHovgIELbFQzZS3+HoFJQ54rKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0j2tvVQz3UJTPMaQFxTaQkVdmoET5FY/o8Zaf3FX+uqZjWirVIOMhye2W5eApAGAZk3kSRwGWFraVx3j122Tb7mOOT/HE1W3bf7wuVKqtfqupXFuUqA81f3TwZFhToY6mrOPmKzWr3zSVtbxg5ZQ7uaNsqCxrO7i/J4D50W0aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLKVEgDx; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47bdbc90dcaso8445985e9.1
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 06:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765981834; x=1766586634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AuiYIGooRr6N9cCaAXemrVf0K1T1Vy32gUakY0SX5AE=;
        b=FLKVEgDxNxRuqwKEVD1tB3gpUnAbbwiF3h7imkunf6LBhqc6cVjNo52AZ/sSYZtmTl
         7DAEU90XbnFlBwAXkrun4z6ssxzXy4CVcyiIFtjPp2ZBSELRuRfrjxA7bXux777SzRfP
         /MB6/2XuPO6q0jcW6+oDAcmuB+nlJSGNrbcjkRJMgsA7PiEX25jyHJoJmo33HCr7ymTY
         QW+o4XGqVrtsEOsQdjLSxj06O++FGDgf+Pqk3iY4VB/6N5GjZV1+QEM28i+mZJMob4TA
         7BGqQubhwHmrH9/i72rZg2AMW4mNHTiLJPy6NNRqbkWpRwBeoFernLq1lDhH8Zd18GI7
         +4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765981834; x=1766586634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuiYIGooRr6N9cCaAXemrVf0K1T1Vy32gUakY0SX5AE=;
        b=WPqr5V1+eenT4wVlUIGTY02yEgMhu4L+D/L2b9YQWMCS4wGOds4Qsh4KCExb1pvwrZ
         nrkTa91OAzmVzwpXva/MXG96sYaw3XbwzYkeuJfJwCwJouUQY3s+J5bdHMCdIi6knTXW
         aZGpEoF825Lc4JZvKVXLfx4XA9a/AyeHzLI3gkuFlFQr2wdmFGXLZVcKqKD2et+a5xfP
         xIgtkK8MX5D41G6Gtva413kLG9XQWwzLKkfvmxnyNLPmOAlqhgANOMWKvPq52nVkp7Pp
         RsdCm8x5Xh4lMFml4cYWosWj388U/Jo5gtFBHuaUeNtoi0iLh97tXa3bWm/kt6piPBUT
         C9FQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9WQvANacNHDFEJ0D/qlWtespl8yWugzUNkwqkrTSHHtpWvVdGslsKUA4RFYIIWlA6Ep3/GBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCzu05bCq6RGmB1dUzTpCF3SOzApXNyHaGnFnTM0YOhY2D/gal
	TIYSpMz5Eo63vQ7XFpC3nN5SFlSAtnQd1Gb52EFyUfDwsHVlFh+0lAUC
X-Gm-Gg: AY/fxX54sxOnkzbIJr3lZWQUkGi/IYGU68ndes15PEOJ7sFHhaMCs5xtD2Xr1BYaMy4
	j3R0GXIuFgrL2vBZOBDNEJm9V8ib5zASs6vDYZOisDANp5JRisWMCQZrKGMoCQpixPcR9jDpEFi
	5ntP3vCZ9q/MpQMPU5huAQw40I5VIJ1zjlwi3Hng76mTOfebXt7rl7oCdwHlMMc2SZTpsMTqesX
	iMpj+l9Y4e8XZYAZMl7EKZwBK8X2+JaNFCnymcUCbE++RRD1EnQiMBB8VR1pSoLgwd36z1QsWDA
	0dFyO4Bn5nuHIl0D1vXVDiaN/xggxccNhVtKYaPAavlN7w6l5wDpdtp7UkHQ0PkSF0/suz4q3d7
	QJMdt513gVb7GZ8/F5Q3k1rMsz+lBrXy2IWPLA5BAS7fHigh0mEAELOlqW385UFK2IajNSwuuNZ
	xvWjb6+Hf4Nnw=
X-Google-Smtp-Source: AGHT+IGA939LDs5bel/MHUVhqmVVYkWEB9HCE2LIzFvNEdXc2q1NmuhACUmHgPpSNxzfYkqpethSOQ==
X-Received: by 2002:a05:600c:1c92:b0:477:333a:f71f with SMTP id 5b1f17b1804b1-47a8f905306mr243968655e9.17.1765981833713;
        Wed, 17 Dec 2025 06:30:33 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:b288:1a0e:e6f7:d63a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be011ccfasm6964805e9.7.2025.12.17.06.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:30:33 -0800 (PST)
Date: Wed, 17 Dec 2025 15:30:31 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	geert+renesas@glider.be, ben.dooks@codethink.co.uk,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, francesco.dolcini@toradex.com,
	rafael.beims@toradex.com,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH net-next v1 2/3] dt-bindings: net: micrel: Add
 keep-preamble-before-sfd
Message-ID: <aUK-h6jDsng0Awjm@eichest-laptop>
References: <20251212084657.29239-1-eichest@gmail.com>
 <20251212084657.29239-3-eichest@gmail.com>
 <20251215140330.GA2360845-robh@kernel.org>
 <aUJ-3v-OO0YYbEtu@eichest-laptop>
 <aUKgP4Hi-8tP9eaK@eichest-laptop>
 <20251217135519.GA767145-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217135519.GA767145-robh@kernel.org>

On Wed, Dec 17, 2025 at 07:55:19AM -0600, Rob Herring wrote:
> On Wed, Dec 17, 2025 at 01:21:19PM +0100, Stefan Eichenberger wrote:
> > On Wed, Dec 17, 2025 at 10:58:54AM +0100, Stefan Eichenberger wrote:
> > > On Mon, Dec 15, 2025 at 08:03:30AM -0600, Rob Herring wrote:
> > > > On Fri, Dec 12, 2025 at 09:46:17AM +0100, Stefan Eichenberger wrote:
> > > > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > > > 
> > > > > Add a property to activate a Micrel PHY feature that keeps the preamble
> > > > > enabled before the SFD (Start Frame Delimiter) is transmitted.
> > > > > 
> > > > > This allows to workaround broken Ethernet controllers as found on the
> > > > > NXP i.MX8MP. Specifically, errata ERR050694 that states:
> > > > > ENET_QOS: MAC incorrectly discards the received packets when Preamble
> > > > > Byte does not precede SFD or SMD.
> > > > 
> > > > It doesn't really work right if you have to change the DT to work-around 
> > > > a quirk in the kernel. You should have all the information needed 
> > > > already in the DT. The compatible string for the i.MX8MP ethernet 
> > > > controller is not sufficient? 
> > > 
> > > Is doing something like this acceptable in a phy driver?
> > > if (of_machine_is_compatible("fsl,imx8mp")) {
> > > ...
> > > }
> > > 
> > > That would be a different option, rather than having to add a new DT
> > > property. Unfortunately, the workaround affects the PHY rather than the
> > > MAC driver. This is why we considered adding a DT property.
> > 
> > Francesco made a good point about this. The i.MX8MP has two MACs, but
> > only one of them is affected. Therefore, checking the machine's
> > compatible string would not be correct. As far as I know, checking the
> > MAC's compatible string from within the PHY driver is also not good
> > practice, is it?
> 
> It's not great, but probably what you need to do. The 2 MACs are the 
> same (compatible) or different? As that only works if they are 
> different. I suppose you need to only check the MAC the PHY is connected 
> to.
> 
> I think the ideal implementation would be the MAC driver calling some 
> phy API to apply the quirk, and then that gets passed on to the phy 
> driver. Surely this isn't the first case of a MAC-PHY combination 
> needing to go fiddle with some special setting.

I was also hoping to find something like that, but I couldn't really
find it. However, I will try looking in that direction. At least we can
identify the broken MAC via the compatible string of the MAC driver, as
they use two different compatibles: 'fsl,imx8mp-fec' (fine) and
'nxp,imx8mp-dwmac-eqos' (affected by the errata).

Regards,
Stefan

