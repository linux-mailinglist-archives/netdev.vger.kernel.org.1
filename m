Return-Path: <netdev+bounces-240865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74205C7B909
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 20:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 892B94E37B4
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 19:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78937302759;
	Fri, 21 Nov 2025 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPnUvd+g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F00239E7D
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 19:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753992; cv=none; b=jCfgsdAWVJNuBrLFIsY1+nkdxsZQeX/5GCfQeqPLUuKqoJOZlSuUlXesOjbDTV1vhBiahF3MqKfHCB7jQ9Ue+o2++pIuOabzVvbhaoXWZkSyGCsGTsd//j5+CGMviSdERK/iMj769Zl5eK081BcugMyj6SLQsU25WcXHLIvaUog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753992; c=relaxed/simple;
	bh=/ORdsN9to51TeOs1BjW1wgj0a85OPhpdeTHQwv/1q2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZxszfcnmgoPWX3PBlWBZW38B/OVthNhgIAL9vIpvtZvlpyFIAOAIzda8eSqq/y8pYwgP4lX8Ka7uXCrfz6Mj/aKlJiaSli/GHFDxI5bUSEnU9fBJiVRfHBIjOzZKQENhbY6E8U0OLGK3BIgbu6Qe6vazux6RU9iVX4M0wUCE80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPnUvd+g; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47798089d30so809925e9.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 11:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763753987; x=1764358787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DGqbZP8+hvf7xeF3jbLslaQnJSoADTEWG1GIF5MUBRo=;
        b=MPnUvd+gTqEHKRS5dVAbX3j6bnHM7VXaeHq+8QzaGG8uWtQaKaF5o/qiQo8NjI59Q1
         3+wzKNW12jOdEUYDY55duhTp4GCT3F+bO4JpE4fIDt16JU/Z1wpsBlJWwIXSADHUzRYD
         HQls7BQC8ebXgEy+xq8Bcxnt8HKrV5TL1lgPSiSDIBSoqmc1OA+u4hJhlGV3diUvZ9JM
         kZq6RqVuQo1UyDtNYS3dai/j4Bpq0UyJZ3MhXlE3sIsQO5nHPYEcukhnHVakiTqbKiww
         wzxQl5yQkZa83S8MFkts5uYB0+hm2FxyyAXs8BwbEMGdnVPlmFH3VVq9sNymBY29xII1
         2vEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763753987; x=1764358787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGqbZP8+hvf7xeF3jbLslaQnJSoADTEWG1GIF5MUBRo=;
        b=JZ8LC2sn9fsY/BV0gLO/NrQJuA4NA0z+jVrE/A2n5P89uoBiQXioCINdP2CDFRpzuZ
         MqLRxvucLTAvm05vUjSc36KUkPPNmg57sTa2zk04v5dgZdCpFV25BuiyChpcaya5R1d3
         VbnHQMjxQoNuHx/SzoCIAGo5TCl5epv24gnALs7Dy0615WXHbHPy1nQwMnTwenqmtDmw
         ZEuJX2LZaTS10wgVn/NZXLT1YX5T7SKNyy0eHo97h2rkIcFTG5RsYMTd7J+95/5x4JDS
         EGNDEkUHQlQtoVK6AAmBHf7VEWhUZqqPnnCnhaN15rP4QySYORYSkHDsTixMEjZENY3P
         a/cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn1r+RRs8ffYlldl1We6uCymnNBpIRFiu/yoRiybBad4wpUvq+lLzYEK5/yhDaNBh34V4ze2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsJdhRneFCgEQNeUoMRKMZXd9HU2aFMZnE0+ojObViFgwD36H0
	vrirzjXW4Vcy1XKfiGHjW2hT8mGZvH1gYDnABuYcmx0kc+UhIRLCZLRV
X-Gm-Gg: ASbGncv3d26pFB0HhW4PZKfV57wARFOZueOuw6vMHHL2fxmQ+nfgmCvzbcZpO2qvxrU
	7LUFdsK58hJp4g9MMyBUbTpVO16qDsjguTKM2rqTxAWpDmxp+2XQ9ykLA+C6om+jv5xuRtz4/K2
	c7OcM8WNK6KPIhKz9iqNQro6B3VcFmjNFOIAecPS9zYwYn3STtCrvFRfXM9pnTdIJx1JNMH3I8v
	MiqTcVFqV8DbFh0vRN1oWvvo7UuRf+SCVENx5P5JdV7t5yv/6JOdNTsv0+AzVED03TstoHQFONa
	MiAhOu+o7KoaAnDimDw7x3rnyeJ5O4FwI0n/vOZZkrJ35R81sPskHtMjThaqS5SNMjktGeueqHO
	M6emkuT/4vtpL3AEAVnrhAe+dIxJ0OKcxDzw3jWk9FbGOV3KfCO5GS8GAgNl4jJRP/WSox4Cejh
	G+FWU=
X-Google-Smtp-Source: AGHT+IENFs6ZeqSSU+KjG9QyVSgBwvU+cDVIGAR8OjDvX7BWestdMZ6UnPS0+COQ/ad/NdSX8SYyYw==
X-Received: by 2002:a05:600c:3b96:b0:477:a6f1:499d with SMTP id 5b1f17b1804b1-477c315f86bmr17005775e9.3.1763753986770;
        Fri, 21 Nov 2025 11:39:46 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:b19f:2efa:e88a:a382])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf1df3d5sm59104335e9.2.2025.11.21.11.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 11:39:46 -0800 (PST)
Date: Fri, 21 Nov 2025 21:39:42 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH net-next 06/11] net: dsa: rzn1-a5psw: Add support for
 optional timestamp clock
Message-ID: <20251121193942.gsogugfoa6nafwzf@skbuf>
References: <20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251121113553.2955854-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251121113553.2955854-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121113553.2955854-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251121113553.2955854-7-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Fri, Nov 21, 2025 at 11:35:32AM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Add support for an optional "ts" (timestamp) clock to the RZN1 A5PSW
> driver. Some SoC variants provide a dedicated clock source for
> timestamping or time synchronization features within the Ethernet
> switch IP.
> 
> Request and enable this clock during probe if defined in the device tree.
> If the clock is not present, the driver continues to operate normally.
> 
> This change prepares the driver for Renesas RZ/T2H and RZ/N2H SoCs, where
> the Ethernet switch includes a timestamp clock input.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---

What is the impact to the current driver if you get the clock and
disable it? I'm trying to understand if it's possible to only enable it
when using a feature that requires it.

