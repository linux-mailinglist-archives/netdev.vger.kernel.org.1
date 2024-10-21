Return-Path: <netdev+bounces-137479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6429A6A90
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 15:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCE141C25026
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 13:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74081F130A;
	Mon, 21 Oct 2024 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJKxisrY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C853B1E0B96;
	Mon, 21 Oct 2024 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517974; cv=none; b=O/4P4Isj006nLpOLel44w1kRwaTIVk2lU0BW30iIHVwKPweacfx+SnRxbzLOqydFMgo9B0w9fgbWdp6P4lQ+jDHJeMT/8wPzZCa9IlNgJgKMyoXIzllzLwIgcq7AANwPiTWAueC2QBxrPstfYLQpbi9VgojWNRkEfDM9EbaR0rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517974; c=relaxed/simple;
	bh=/uf3LOD2IKo2V1k+yHU+4rCBEzY3dlhJTjfG6TZcxR0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5T+ALvkK4nsJN+7anWsoNQkdJP6E5KQCA/euTZXMibCGXq8NyJ5tGm1AuFaJ8DvbhzyK//iOoX6zh/bidgoraGOE8EWDwnTeoL0poYVPVA4XWeFaqsYoQhS24/63Yvxihe9zQilty1/OF/MS6IG+pZgSZx9+x0z61KZNPor+8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJKxisrY; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d70df0b1aso3602941f8f.3;
        Mon, 21 Oct 2024 06:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729517971; x=1730122771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qW983cpZTtlZpg1IF4URdP/C7ezGJs7rx0iCFccBLDU=;
        b=bJKxisrY0IHF6Cr4+11aUezxyKuYub2bAKpi7e+vlQVD4Q7/7mq1z/9F0+is7+kUeK
         Yp7lPMAIBsnDYE7yhg8i1nad1gqZ9Rt5KQ4ONq3C504V3zrnPNQJKylTaw9LfMPlyGZr
         gtmLHRu/JKyBFJPtsMPufaKEOeUg0q+TNOisMBX2UWRha9jF06Vzl+owi/5QvJ4IBn2u
         h5kWSchkdLQqmHUih144Kz7hq4VtWuuAsHIOtTdbk8pv6l2d/GjWV22udvNNr/vs9EhW
         FaHFczHaVUaflXbSATchF0jkR5i8tFHAgk5Ee+jjQs4WaOKRIzYBSLCF0te/J4mAIFnw
         KMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729517971; x=1730122771;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qW983cpZTtlZpg1IF4URdP/C7ezGJs7rx0iCFccBLDU=;
        b=fxeut/UwuHkF/vJIi8EY55bxNi4j3Wak7NDeSuaEkYuA6SujNZpFYnELW6egH9XLn3
         XKUpE2Sv0x2z2k0k/2tRCCO3nnflFnmLE5Run42I7FULyM0/rzWb2mMok1/ZGV6yPwLT
         f5qFEtSIi88WsFySUdvCjX+ZNFrmSLoqc928uhZm9T96/k0XSPdfgzvEBW4mZKENhTVC
         XpahCHkeEEWV22d3Ixe89oE94DIGv7R9g4Al8QC0IoLV2K/hFOzXkGovKjDUOj6HdaAG
         Tk1hXzQyinsbYY9Rf0lu8ZwmVVZyz2J99oi/sahrV1PAhTVQ5eiJOgZIxHoCMCjWlQyF
         3wLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEwoidzYTsx+KLyk3vFClyi/Khi+UXA5asA63r1GV4RCq9czaDOzlleDMfsVl7DTTKBVMI9UqU@vger.kernel.org, AJvYcCXFAVQHO95jh0NLCCWW3LI3hCiqqs22FvXZUBRPhvrmBJ+7tMzzQSVFXjemjC9iZpnAxGlK/q1vmYOK@vger.kernel.org, AJvYcCXxr2jiZwhTn6Jt+SIti6o2/9zhP9MYJUYlZf880j+8A+t1Jt4YTNB5Kh0mqKz1gCVYhX1PnrxtZFfk7Mxb@vger.kernel.org
X-Gm-Message-State: AOJu0YyCUaDPRb4nF+d7Xis8ZH5uVyZ/82JE05Eoisw04L286CvIKgUz
	HL/L4O7yBBq5G0X62tXif9vA8zVJcO1NM2Wvv+NF4zzQhLbHGQ2t
X-Google-Smtp-Source: AGHT+IH3QllBtkXK0c4TbYUbZZNT5mP3kTYyg2B2b7gHrcHd/jXQrDGes7Nj/6Gy+PFB3NGzv8QQow==
X-Received: by 2002:adf:f8c7:0:b0:37c:d57d:71cd with SMTP id ffacd0b85a97d-37ebd3a30dcmr6846705f8f.52.1729517970676;
        Mon, 21 Oct 2024 06:39:30 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a365b9sm4387289f8f.11.2024.10.21.06.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:39:30 -0700 (PDT)
Message-ID: <67165992.df0a0220.170dc.b117@mx.google.com>
X-Google-Original-Message-ID: <ZxZZjvWdbk4wVfOl@Ansuel-XPS.>
Date: Mon, 21 Oct 2024 15:39:26 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
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
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH 0/4] net: dsa: Add Airoha AN8855 support
References: <20241021130209.15660-1-ansuelsmth@gmail.com>
 <20241021133605.yavvlsgp2yikeep4@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021133605.yavvlsgp2yikeep4@skbuf>

On Mon, Oct 21, 2024 at 04:36:05PM +0300, Vladimir Oltean wrote:
> On Mon, Oct 21, 2024 at 03:01:55PM +0200, Christian Marangi wrote:
> > It's conceptually similar to mediatek switch but register and bits
> > are different.
> 
> Is it impractical to use struct regmap_field to abstract those
> differences away and reuse the mt7530 driver's control flow? What is the
> relationship between the Airoha and Mediatek IP anyway? The mt7530
> maintainers should also be consulted w.r.t. whether code sharing is in
> the common interest (I copied them).

Some logic are similar for ATU or VLAN handling but then they added bits
in the middle of the register and moved some in other place.

Happy of being contradicted but from what I checked adapting the mtk
code would introduce lots of condition and wrapper and I feel it would
be actually worse than keeping the 2 codebase alone.

Would love some help by mt7530 to catch some very common case.

-- 
	Ansuel

