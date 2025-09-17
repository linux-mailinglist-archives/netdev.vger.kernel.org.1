Return-Path: <netdev+bounces-223939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 581B0B7DA13
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524F318982D7
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 10:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B5C343D92;
	Wed, 17 Sep 2025 10:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NruRNwfp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E00302770
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 10:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103441; cv=none; b=DnHtHzonANXjg+dntLZ2DQrGDbr2PaSPwvA6iwMsjGZZyRcJat7jPkNX52L4fcbNno7+7En/+y8oRYTWxPP2Nw+wa81Dr9XpM+PUUn5T+LLKRTMXB73cSQnuXC2lPFz7tJbfmj0UHOYjVnMKuSl4Un8tOsCLIdIldquJF/fUum0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103441; c=relaxed/simple;
	bh=5ile7pgqPwBmGy9ty2MAkiU16i/ko03ARvZkVY1tBxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVNVecKcgzzwTtf7cu3It51hHJXvII+UfT7n3HRxOcfTU++QhxvEZBlpdKjxuZnWjTdXwQh6F/p3pWXf4+sze5g4vT3UnTFeGYnJE0AgMJc2uzUSPzPkre+ya+Pa3+HeCPNSDgdWltkGNYPSU+e4ImF3M7gj8tcSWcfplI72mTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NruRNwfp; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b9bc2df29so6403645e9.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 03:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758103438; x=1758708238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gRrOX+lH79lbk3CMWLiPCWajedhgVBao1TTFuyFRYcw=;
        b=NruRNwfp8G5PddFWtMxn4HCVX58AOfwbGqCS8xwZeIBkv3/s557HOncDlIZ5xAjw+S
         W+MXT2isv1uExwyATSJGrKw9jBU/hLWQ9JsT8wfrDaZJVhu7CEej6HN1NoYDHbZZG9fQ
         hww4s5v2Au+dtbjdHKEiJjc6H5r9C6KBuwzMCHn02cKak2EyLZiH6dbpsQEv2YVo8mst
         /Nc9KBPcWgl8sVNa7fuhN7b5m0BVOLo20uqx46GRgc7KJnLuASy04FFiaQorKI3QC9mo
         hJaqbGUy/y+v9nIdkabh3LF6bY+GnHQmeVg6fYcp66k+mf0S9YVb0unb/KZJa5BPuLPd
         XZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103438; x=1758708238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRrOX+lH79lbk3CMWLiPCWajedhgVBao1TTFuyFRYcw=;
        b=KJ0LZIdzy9+0+MEmukLg1gesaW+1iySEfmGaBXVaJdsUhf19QvGetPjjkvfIotMnFj
         2Z3NxVd/nPAP+Lb/nWvLXIQX4SNitFKZk2qHn1ZWl9vxyCdH86wT7EIf6uPwebqLOrwm
         fMttMj6ACfr8aPeIjMboicEHfNv/lwBR+5nTtJs0SJU21kndDmp/DqMAsiwT6Gur9PMz
         +Gs1gCPMzhGVB6EK5QVuRJuhOsCW0e+wMjG/shEtT2tlzDN0kvUOgehju96jl0st9dZK
         52KqfzP9Th8MgkwBvkf7bo+90q9BUv1Etq+oMY450roHy4XlvlPHA1cuZ9NdRX46c9pI
         UU3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMvI0MfzwV9rTdYO9dPKFzpRz45LPtPIQbGKr1cOF1meijWdESgm7QfqnKKCJcF245UDI381E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZxzLI90Iq3KQX8hb1HoPMRfP6QcIeUh1vpXjzpvRBnO7/dlZJ
	rBNR+B8WN8C1RFACKRkyHcs0NzgC3s4xcEXgI0id/T2xU3w88gp7Yb6S
X-Gm-Gg: ASbGncvN4GoZZpSDLi4ZurWzWkl5HAMP/pU9ZBQbMSNEY2Gzk0fgg+qGEzu+/iZhFGU
	06jpP5mYgrg8Lxo0xk9ITvl37DHWTl1krO4Fp1noTomcuuDSN6WZ6ne4WWWviEbxjIM41ZA0isK
	b3KTna8PVsHeZ0E/LtLt2adr2RQNLqVDjaEmWJcEYUCbjRNJPGQMc39dQqZ8L7HyTViclWeOWSz
	LyOv4UCVAj4I2pqlHeleYJvCQ0TpXsWUdWFAmhkQ+UO8KcMpoz0dv8XsoJY8Q9wrTeIKae9ntL2
	VgfFNZVpPD8HCWyH+iC/GZsaJtMbm7b4Fp3MQDucghiVrp1ockCUcLBPf1UEyzQzy0MWQPzyAXh
	x2MohhwuxYz4Rdog=
X-Google-Smtp-Source: AGHT+IHLOG5YdNiWrI2g4iNSNygtK8lUMOKb4aBkIX2ORgpQKWdmRgP7R0dl64oEM0ngNwVEe1oh8Q==
X-Received: by 2002:a05:600c:648a:b0:45f:27f4:47bc with SMTP id 5b1f17b1804b1-462074c52f0mr6761615e9.7.1758103437696;
        Wed, 17 Sep 2025 03:03:57 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:8bcc:b603:fee7:a273])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46139e87614sm31032865e9.23.2025.09.17.03.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 03:03:57 -0700 (PDT)
Date: Wed, 17 Sep 2025 13:03:53 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v18 4/8] net: dsa: tag_mtk: add Airoha variant
 usage of this TAG
Message-ID: <20250917100353.dbjeh5eibkqdpz75@skbuf>
References: <20250915104545.1742-1-ansuelsmth@gmail.com>
 <20250915104545.1742-1-ansuelsmth@gmail.com>
 <20250915104545.1742-5-ansuelsmth@gmail.com>
 <20250915104545.1742-5-ansuelsmth@gmail.com>
 <20250917093541.laeswsgzunu3avzp@skbuf>
 <68ca827c.050a0220.11f9b4.a3f0@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68ca827c.050a0220.11f9b4.a3f0@mx.google.com>

On Wed, Sep 17, 2025 at 11:42:13AM +0200, Christian Marangi wrote:
> On Wed, Sep 17, 2025 at 12:35:41PM +0300, Vladimir Oltean wrote:
> > Unless the few tens of bytes saved matter on OpenWRT, I think this is
> > overkill (and you went too far with my previous suggestion).
> > Two Kconfig options are unnecessary from a maintainance point of view
> > (and config NET_DSA_AN8855 isn't even selecting the correct one!).
> > I suggest you register both tag drivers as part of CONFIG_NET_DSA_TAG_MTK,
> > at least until the differences increase to justify a new option.
> >
> 
> Ok, was following the pattern done by the other. Will drop the
> additional kconfig.

tag_ocelot.c is another example which registers 2 taggers under the same
Kconfig option.

