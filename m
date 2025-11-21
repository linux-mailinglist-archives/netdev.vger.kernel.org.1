Return-Path: <netdev+bounces-240881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C921C7BB93
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 22:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C02DA4EC409
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 21:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AEC305068;
	Fri, 21 Nov 2025 21:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2KFO6Gb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B652E8B81
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 21:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763759382; cv=none; b=gJZIoWfBPtgAN41byLGnCYcMMmbHRVFtD9Iema9UxmFJgVOlNuAN5Uzd8jyL8omWiC3YKAw6yl7HnLkfQ37Mo1D6g8UVs4uo2VGdImd6qXD9HslyfYRcRysXS/57iSP6/Z+iRZo0pWy8ln3p5DJdB2RGSKsO1F+HE3C9YM40rZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763759382; c=relaxed/simple;
	bh=pjRy1SEsLZJxI4LOty61Ye27Ei0/ipx3J1nq0iJzaHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFgSPfKMb7vGtDYWxAyxsf2NOkf09kh2o0MWBbMQJpABjFT1Id39z97ogw4O7ipRqX2TsbkklrcDoLi/f60EoIzfp+kzYw1MZ7IemSbempvRNuF9b3zx5G9JlIxwYtbOGkopFaCLh3qiFaKzx6yNSZXhM7Om9Q4umj9V+Xdx4lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2KFO6Gb; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b30bf0feaso195727f8f.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 13:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763759377; x=1764364177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m+St0oOO00YFrE/oeCGGrHEKEP9gDUq45OgfSWgKSac=;
        b=i2KFO6Gb7yw1w1MvIijYtVd5OFiZbgeKuoUZnNWteVRpTuAMixE4xzdzFaCNZt8EjX
         fl7rRtY+BddEdTq0ZC+LRkshZVJ0Ra85+1pSERORqV4qIitGHn6bfynbH5UMIDmQxXJh
         SASYMadhMjpAu7edxU2W5QvETYLiwxrrqLfjdhcfU370HHMtX0eOsS9G/uKT0MkMlkpd
         ishgKndlYCne7B9vR/113ViRmQzBgn75gy37vlGANJAm7axxzbLTSeocEtsC47Lqhtbd
         YYgdswem4TFp1k5W1VUBYn9SjUYI0WBALMjPQjXBsdE6Iv/EfbezX2+LlBIeljms8jke
         iaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763759377; x=1764364177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+St0oOO00YFrE/oeCGGrHEKEP9gDUq45OgfSWgKSac=;
        b=Zyy51+nQg/vMOczuSwttzPfPyq/sLHYFO+ohxA7JeBMgWqynMKgn3YqvM18W5+vLVm
         id/SZ8xwS39p5C2xFAYXomY85tGhrkdnZX1h1mTewyatLlB+hYMgpd2mFGNIT4bTgl0l
         NTB9LdXGKBSba0uWrXixt9lPywu7pfVhSRxlvUm3lkH2GY+L3ETxniMDfEWlGwiZr0Ig
         KC6ciRBoQ63BC4vvkLdmNd6q/oxsVMtyxTn3seW49ppdjUCyN2PtsN29og8qMgG+j1hx
         /Kb4aLZoTwMdEGQmtNjmL4yUGYELb70KzmVmDl9EcaNb/1D/QiprNUlFP/r9v/SVEq4A
         f4ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUat2b7ncLAXNv5L4VZ75m1QFclKC5WPUoWkq7K+iIu6enxT1Y14fdndtLiabstzmznqAbSH5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYHUbVnCwOBXyNEwImDpSJzFb5o0GaQ+73AyeeypZhX7QvCTjP
	fMsf/5yngxDr0ErSDkp2+67FspGb71v+ovvKMpsw+WdmYP+YJ6YlgFU4
X-Gm-Gg: ASbGncvBCxNdGpkv2Y+MSnw1JTlJjg2Koq1VLDjTZE5ywNwN5fY7V8Du2uC4tjWqllu
	FAXRIEmQZJT3k/ekyCuMnI7p3v1vV3XjvThhgQ0ZR4kofMtRrLvrLQGg0u5kLBs2xdH4Gys33O5
	RZ+hhRnUFK7ThGmvCq5mFzPRozIykLCV0pvkINJNnk+A2r9TTvC+7I+6vB21qUzpjGcFu2pKf4X
	Hq3UBetAL54Nd/EJX2JzJjSr9RQkFvm0FJbCaGTB5fmQvDASZIY6XAekYhgiB67yv+k/bDMdrfG
	dvkinSu51+GbRHqPsUFXE0QFEmqfGMrHpLrN5cfuxIr74Fym6hD2BvtANoeE2IgkV5aZxJseXWg
	NalrZP/VtX12z00vYYzdwbON56Wu3ONugGhwjIIXQBuzg/7W9wez+gHTPT/sEaxHGtLR1U8Xi0X
	U6Ei4=
X-Google-Smtp-Source: AGHT+IFiaD4mpHrFN+tAaNq2FgvMpg4adybRd4aJ7oo2sEmIOOuFXgl3U576DxtLAMuPvA+rfainNg==
X-Received: by 2002:a05:600c:1c23:b0:477:5c70:e14e with SMTP id 5b1f17b1804b1-477c01d92cdmr25458805e9.5.1763759377158;
        Fri, 21 Nov 2025 13:09:37 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:b19f:2efa:e88a:a382])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a96aed1esm95730045e9.0.2025.11.21.13.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 13:09:36 -0800 (PST)
Date: Fri, 21 Nov 2025 23:09:32 +0200
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
Subject: Re: [PATCH net-next 11/11] net: dsa: Kconfig: Enable support for
 RZ/T2H and RZ/N2H SoCs
Message-ID: <20251121210932.hcte74sz6efa4vym@skbuf>
References: <20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251121113553.2955854-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121113553.2955854-12-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Fri, Nov 21, 2025 at 11:35:37AM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Update the Kconfig entry for the Renesas RZ/N1 A5PSW Ethernet switch
> driver to depend on ARCH_RENESAS instead of ARCH_RZN1. This allows
> the driver to be built for other Renesas SoCs that integrate a similar
> Ethernet switch IP, such as RZ/T2H and RZ/N2H.
> 
> Also update the help text and prompt to reflect support for the ETHSW
> variant used on these SoCs.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

