Return-Path: <netdev+bounces-150837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7289EBB41
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463691889400
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 20:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF63822B5A7;
	Tue, 10 Dec 2024 20:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/A5cgp9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FE422ACEB;
	Tue, 10 Dec 2024 20:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864197; cv=none; b=Z/CzGTK3emGLd2i7NPsY/J3SMvsnIFJhvMiMwqHFFzJ3NVRODYKAC4T+3r3ft0trVFNX5FWktrTCkxwm2kJR4Qt0NdUuCctr0du0c3Kzp5JDZZXS//YN46eU0tGKDcWibEp3013KtjZC+WlERTozRLyw66CspSav0u+iWBp4QfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864197; c=relaxed/simple;
	bh=tPvcnCxzks7PcExkMvBzhiHrl0pQoDRJidYEOXPc57M=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9dXSN+RgfpjmxQK5UebjrqYNYV4UbJC+qNJNB5kyUwxe1ARNWtj2Q/CJ/kZ+cbkVYqDjT8KwQI5rdafxzBTEcFYJ68euBlryavAm0hMwzTdThqY8FtalQpUab9kDwGdFiIIBKyxExWLDcO6kf9mUsz6Ke1prztFBFjFq6FD778=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/A5cgp9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a736518eso67288555e9.1;
        Tue, 10 Dec 2024 12:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733864194; x=1734468994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wa1C0CK2LUPWgoQl8J3ltgkkEcHnA6/0miJrX+XQgJM=;
        b=Q/A5cgp9CThNeBT+GyycdKtkRyNIWygP70V2WesA/n6Crcx8n7KnMr2ImKG+RSdne2
         gY58aa95VWr6FTaG2RYHRhsWdhU1YvmibD7Baj77frisVhCZLuUc3vkxFyEaZjaQts2B
         e5MLoqrL6yI3HnPt/A/oLFQgFpguu7IDtRejYtiPaYuD/QjhKZ6QEXnvDc24JK7yEkQj
         KjgnfGiJCq8w00IwVK9M81XCf0QwDI45iL+HpReL0VUEpH0m9OQkNreSXwxFXvseOTyx
         eLLulq6GxwPRLBdCyx1cf2UjHdat9Lkz3llJ961szlPl+oEkS6BLUumMGP6nSrqutVra
         bJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733864194; x=1734468994;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wa1C0CK2LUPWgoQl8J3ltgkkEcHnA6/0miJrX+XQgJM=;
        b=HALZt4DYr3CAGR4pb+XwmqJ5VB0YcvATZDzSLuogB/suZr5kk2yfhfPwXb7esbCTB5
         fyQRCfGO85gGnouaU7uuzgtHhJHxk6quxTl56kE692o1iD8H7aDQizU25a3UtXcjuZkg
         W9QXTm6sp/c3E7KU7huhqsLnEbWpzpuYMUW9+w52es3uz637g2kSv8igfzvJtt/xOgg8
         ok+cdIQK46usScKDvy1R2KiuUCxU5zDyCzRxa3L+9PecoI2bCtEBOqX2GBFiQ9p2MjX9
         RDn4vIqnetJ2O5+Q6GztBgA/gw3pgxSJIq8rvN0zwgw+50D7M2f+2mc4Ny7hsPuObGP8
         rO4g==
X-Forwarded-Encrypted: i=1; AJvYcCU7Mg5crVMpM+sxhlqgBX1Sb2hp5p3mBGM4+EQIVxc40ZJKxKRxmSer9ZTTSeFLhXYo0eq9zYwLMsrw@vger.kernel.org, AJvYcCVhbEJYCTuyQkJkDYvw26Vl2KfOj773CkWeZQ2OVoPtODNu0Aw2wrZwjpGuBmgHNtux1XKhSSPW@vger.kernel.org, AJvYcCVmOgeQw/saEom2tq43q4sWkiECzgzvj2IYjj+5EN5mAaG8VbN7NluI8R/fsvkPvl9i0hCSSHGrt12tXDhU@vger.kernel.org
X-Gm-Message-State: AOJu0YykyZXCK483I1ViXxuhpLeCBFZ5oZ+XZ5eMSsjKQAYFGvQiCnPW
	XSqLbX4gQDMsSafiWtX+l6eSsKMuNDNKmB/G56AcM9Hy+XhH96Xa
X-Gm-Gg: ASbGncvQk5h6JdtFqMHedbAYaMZYG78RhuN38a+CiPJ2Ot434KKDgVv575+NFoxKyZQ
	h+RnpxcSfEXUoFxVdk518RHJtkUBarFooyXRAbipLZm5RTfyFp6jYtSbH0yvgN8i5BYoiSyGQ7J
	H0VKtNO/bheEw/zWaN7t1JvPJL0EVtHjW6fsME5xt8m94WzBDySlZhzYxZ9mWQfnQ1FiyFcSy0q
	XVQ+HPLKKa0btqFw5AVw0C+ZiYld3yWe5a7tgyVr5VOfa53mBSh8+gcKnVfC9lFYYlMoSUsphcF
	yr7w98R+Qw==
X-Google-Smtp-Source: AGHT+IFO9JdRbxTE32/Wvk1uVcdsvnlU93WdY8tnjY1ZWyo8G3dYd8QPxRdPIKttUVaFIptDS6Wn3w==
X-Received: by 2002:a05:600c:3109:b0:434:a04d:1670 with SMTP id 5b1f17b1804b1-4361c2b7e29mr2708705e9.0.1733864193989;
        Tue, 10 Dec 2024 12:56:33 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434fb066874sm69945475e9.32.2024.12.10.12.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 12:56:33 -0800 (PST)
Message-ID: <6758ab01.7b0a0220.b8716.380c@mx.google.com>
X-Google-Original-Message-ID: <Z1iq_jC0bK47OJ-a@Ansuel-XPS.>
Date: Tue, 10 Dec 2024 21:56:30 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v9 3/4] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
References: <20241205162759.pm3iz42bhdsvukfm@skbuf>
 <6751e023.5d0a0220.394b90.7bc9@mx.google.com>
 <6751e023.5d0a0220.394b90.7bc9@mx.google.com>
 <20241205180539.6t5iz2m3wjjwyxp3@skbuf>
 <6751f125.5d0a0220.255b79.7be0@mx.google.com>
 <20241205185037.g6cqejgad5jamj7r@skbuf>
 <675200c3.7b0a0220.236ac3.9edf@mx.google.com>
 <20241205235709.pa5shi7mh26cnjhn@skbuf>
 <67543b6f.df0a0220.3bd32.6d5d@mx.google.com>
 <20241210203148.2lw5zwldazmwr2rn@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210203148.2lw5zwldazmwr2rn@skbuf>

On Tue, Dec 10, 2024 at 10:31:48PM +0200, Vladimir Oltean wrote:
> On Sat, Dec 07, 2024 at 01:11:23PM +0100, Christian Marangi wrote:
> > I finished testing and this works, I'm not using mdio-parent-bus tho as
> > the mdio-mux driver seems overkill for the task and problematic for PAGE
> > handling. (mdio-mux doesn't provide a way to give the current addr that
> > is being accessed)
> 
> The use of mdio-parent-bus doesn't necessarily imply an mdio-mux. For
> example, you'll also see it used in net/dsa/microchip,ksz.yaml.
> 
> You say this switch is also accessible over I2C. How are the internal
> PHYs accessed in that case? Still over MDIO? If so, it would be nice to
> have a unified scheme for both I2C-controlled switch and MDIO-controlled
> switch, which is something that mdio-parent-bus would permit.

What is not clear to me is where that property should be used in the
code or it's just for reference in DT to describe what is the parent?

Given MFD implementation, I pass the bus by accessing the MFD priv
struct so having the parent property is redundant.

-- 
	Ansuel

