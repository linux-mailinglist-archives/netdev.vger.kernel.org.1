Return-Path: <netdev+bounces-173354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20109A58669
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 18:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFCC17A3421
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 17:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C751DE88B;
	Sun,  9 Mar 2025 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HB9QplTG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23123F4F1;
	Sun,  9 Mar 2025 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741542351; cv=none; b=PhyHle9YucD2x8BdM0DIVbE/e/YjKakL+QAnwlHPKNIIZ98O7jgkC2HF3FjnWHdpEELG83mjrnSO8EBQi9bc1e4f0XiFB60yd5oZV7gnClWmjOK70okTR7nH2VP05c3T8/CmdJo4IuMgDQDqOCHiRBEU13O+f1jfkJmSblBSjHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741542351; c=relaxed/simple;
	bh=Ts4nRRhjYyME+pC7r6xMDOAjdA6nK3OzbkGfMevUYTw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVZO8P1b1yU5/Yf3n7zMAgRmi5i/fO02xD39GmGiLJWNZlkJU++lkvibWfJaG3JkxB6TyOlOPw8Z0gbQ2dcw9y/vV5YWCSRLFftSLpvvHZO43IO00ZyG33SDwr7bnEjGnwVCcxypd1EgxRyG2Gbf0itrpJTBM991md+jx3KD9D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HB9QplTG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-438a39e659cso19444745e9.2;
        Sun, 09 Mar 2025 10:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741542348; x=1742147148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mYVeDPxjhFeZxy0KwWJDY/eKgxnMZAxnPE/IYVsYVHI=;
        b=HB9QplTGsXH27nqPQ8Y5IY1YVylqDo24WCnOWLL6CF61OwAge7VCx5eHJa9o2R0XNf
         K2D0ip4rlJCyOok39f+De/KlTNpBQ2c1MMOEuQpQRulxIGMzjkTEmRfHP1ups+lqA3xN
         p+hJi3yOgRPPYIRziU7D08N7+IFRcmjqMGnnPPLSskQnZed9KfIwmmpAC1ZfBXrkJzHt
         i7GoeV9uPq5aSYckQgCMcw0kTbS7vptCRjHhrz04SP0Olb638PmZKa7twPMZoXOnFRX2
         kylaFSWfFh9rSi2g4/nZiXvzoe+SNwFEI2OK0qmEIFhx8S7P4L/jhgi72HnGf22dsNjZ
         Oa6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741542348; x=1742147148;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYVeDPxjhFeZxy0KwWJDY/eKgxnMZAxnPE/IYVsYVHI=;
        b=jW42SiZvW0InLg0oklmsmotbFyWe60Qu2ThZVso1w/OvqfrnldLyVeC6M55W5Y29R5
         /YCFXIvRHXjX6pe03eLOaokz72Xpa2sn4YogvhiJjV0OHCpvI8EWAau6gL1gdrzhXsZ8
         mgtL7+nO1Q8VThnE2L/vGaXsscpObUmgCZ8wzQuXfcmlT7xzLy8isJI9PXYOgnbEWX41
         nDskVf5YhnCwV2h10m4EO74kTsFh/H5INucRG36viUJA5cPIuW5DQ+MbA3CL+oc3jLjl
         4FYnhxHDfhcAnwTSZRhqmFTpfkAhRfAxhWMs1BE4van6fbgcZwa10zb8P4zcSmPwKefH
         SKmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU58qDcWrPK2+uieHm3XlEtvTOEbhkgoPM9du7sZ5Yc36bRU1J6Pg/kZXtNc2sKRL6LcRDkTifuvOLs@vger.kernel.org, AJvYcCVxcUaLujUf8qStb84mXBM9Y1DMZu6ATWR1Krz5DHLq5qJ3C6qqgoJ8SHDng8m2weEfcItjcC/D@vger.kernel.org, AJvYcCWGQIkfeo4UCJ4puEGb5j5fIwdJx1kMKUZbaFvR0IyheH+3/G7roWfsQ9aaLLUE+gMnEbxKYHFowk9ap5fz@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6xlS0h70L9kL1edJajXjSr/t870M+wFttlU11aw1bHboZlOzf
	WgPsgMcxstZOtUsaWHTK8KLOlq2K5wXlRlpqTd2y9UFe7DKt5ik9
X-Gm-Gg: ASbGncsjP/cPyvD1V9svx0gRQZ5hZ2EFHj6igfNWV1ee3GILxX4i+Nz9kKNnCbw2i7A
	JhmQ61LKOVQ7Unci0jIXo3peMiB2KxieZPVM0oBMez6LclR/5KC/8LlZa5swknktHE2bCi4zlpG
	pipynWD2R6EmWAx2PayXtRlfU0WBG+dGwEZKlucYWfWdNaMFlpzy1aSg3YVoD4J+IFeIf4PY39K
	UIUydt5xk48xLiARsBfemdqjgcsi6SJukulDF4CiWiMTfz6lB5mXFVcDVvUpmHOufuGFncw0P9f
	eLkiDmEBQ8i5JSIyU0k0VY8jxKt2QF+onAdwG0UkUe6zdwtEGyUOxzMd3C3OvfYExJObZ0181xt
	Z
X-Google-Smtp-Source: AGHT+IGp7jEKMgtsCA2TGbrvYbtqFa4WUNvO5evZDxVuTRVZ2MCZ3kALyJRYRl99L7jGJPY9VOa7nA==
X-Received: by 2002:a5d:64ce:0:b0:391:3bba:7f18 with SMTP id ffacd0b85a97d-3913bba8128mr2360645f8f.12.1741542346719;
        Sun, 09 Mar 2025 10:45:46 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c102e01sm12708957f8f.93.2025.03.09.10.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 10:45:45 -0700 (PDT)
Message-ID: <67cdd3c9.df0a0220.1c827e.b244@mx.google.com>
X-Google-Original-Message-ID: <Z83TxxTXxVGMYZzu@Ansuel-XPS.>
Date: Sun, 9 Mar 2025 18:45:43 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v12 07/13] net: mdio: regmap: add support for
 multiple valid addr
References: <20250309172717.9067-1-ansuelsmth@gmail.com>
 <20250309172717.9067-8-ansuelsmth@gmail.com>
 <Z83RsW1_bzoEWheo@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z83RsW1_bzoEWheo@shell.armlinux.org.uk>

On Sun, Mar 09, 2025 at 05:36:49PM +0000, Russell King (Oracle) wrote:
> On Sun, Mar 09, 2025 at 06:26:52PM +0100, Christian Marangi wrote:
> > +/* If a non empty valid_addr_mask is passed, PHY address and
> > + * read/write register are encoded in the regmap register
> > + * by placing the register in the first 16 bits and the PHY address
> > + * right after.
> > + */
> > +#define MDIO_REGMAP_PHY_ADDR		GENMASK(20, 16)
> > +#define MDIO_REGMAP_PHY_REG		GENMASK(15, 0)
> 
> Clause 45 PHYs have 5 bits of PHY address, then 5 bits of mmd address,
> and then 16 bits of register address - significant in that order. Can
> we adjust the mask for the PHY address later to add the MMD between
> the PHY address and register number?
>

Honestly to future proof this, I think a good idea might be to add
helper to encode these info and use Clause 45 format even for C22.
Maybe we can use an extra bit to signal if the format is C22 or C45.

BIT(26) 0: C22 1:C45
GENMASK(25, 21) PHY ADDR
GENMASK(20, 16) MMD ADDR
GENMASK(15, 0) REG

What do you think?

-- 
	Ansuel

