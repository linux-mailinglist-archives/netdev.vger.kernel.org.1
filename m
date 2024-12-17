Return-Path: <netdev+bounces-152640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BD49F4F37
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9DF164E54
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617271F7558;
	Tue, 17 Dec 2024 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeIS362+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A262C1F4E3D;
	Tue, 17 Dec 2024 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448739; cv=none; b=jQLjY5Ioq/5AiOSAfMqayYqmfY0D+lPiDEtUJZRHi8y1lUlXocQbWLAr3SIcGRW6ex3e4dhOcmcww4VasND0LApPoqI0mcJKrGIWV0pW2EegJ2V3RElFLAhgE6Y40ZSLn5uMKCXDP08l9B62jiEGAVCFBsbnhA9BQGSAQq3d50Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448739; c=relaxed/simple;
	bh=zGrE3zw+h1wd2Cu4imowYMw1hV5cdp+anjHFkaMD6dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phyZ2UuWcNBCGedpqEKERrdGPflZ+FsFN1bfTWgLYWW8x1CXo5guL+Snd4fFPTNhdU0yBonn+xyzvSf+vujcf+pnXDKok74OCGSRn31lhDE6cqRqGkjOWgHpajsxR8JDOvZxxKmfB/GP7wgRVXszpV33voU4mGyMYSrtAd9fMJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeIS362+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361f09be37so6232745e9.1;
        Tue, 17 Dec 2024 07:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734448736; x=1735053536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RPR0mR7aHib3t7qCGRZcUALodb3tIV3uQt3h3CFnSp8=;
        b=eeIS362++uu5/T/MtKD0Y1xo5Zer+GVLVQ2I9BEYXpRAV/8AImezaIt57jBvghcp7q
         Y6eDeUa3LVByJoaBKvz4QcwplGkqVeFa6z7ruOzZDLxyDgb5DZEqHx4m09fZNWJXszPS
         SgAO32laERb9Ysp5Dcqj11cBe+xHt2CItMPOheTj9vHPk/m7KdNlHP3rZAhMTwl9MOD3
         RBpsuCAaY6LoZ/OxVGMVilUBB11/KMQiEsk1duCjYu8uVhb4e/IMhQa64X+Wse9gt9tI
         9JFN44eKharSGOFGX3TKXfd0EuQ10WoR9hSTv9CLm3cTEf+UT98Hv7updqkiIxASPXo5
         rFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734448736; x=1735053536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPR0mR7aHib3t7qCGRZcUALodb3tIV3uQt3h3CFnSp8=;
        b=suOqcM0kdsh69a08cjdDGi3T7CAe1KBNN/Yg+xYv2m4VeFu4mzCJGKBD9z0aQSL1F8
         5D/Levrjbo1GwEJb7pHzkZUY0zk0M6u2bKHGGSYm6BoYzmpJgXhBDNMUBmkKiLSICqbG
         WHy7nqTkrYgn1XLrleB1emIOKpwFBpApYkw5iEaC8VTfpTpguiqUP/hTpbkcRBvyIczL
         Z4rVFcfz6ZhE5jve+yjNbd9zmi272xPMmtgJadwU25bC64dcRLtzYJlqwfUjJqhhpX+j
         6+XxS97najrMzW/NJXAmNLKYZW1qV9ZehbSM6hmcH66omQLxrGhQ/eMZ55QCuQVapqHx
         TbkA==
X-Forwarded-Encrypted: i=1; AJvYcCUHJdNlCsjqrJRmsa8q9C1HrIa2mnwKCM4TvKZ9NkztatxUY9GY8MhtIKEVwnBzCEaIzAIdX+0O9OsV@vger.kernel.org, AJvYcCUkXzsHDfMMN/TUjtP8AKXJMQuSJO+GmAdTh9SxlnTN7Rxna1zDIiu5Ap9122T5vAC9OxyLM8JCrRC7c/JN@vger.kernel.org, AJvYcCWSLDD8lV3qDtzIM3Bq170xgBmq6fM9MLVGHqGgjUJ8bjIUCwZKIcdCFBde0Aklo+MDsdplpGv/@vger.kernel.org
X-Gm-Message-State: AOJu0YyIPE8Z5gKwa3YHlm83W9RT9m4laY+trtYep/bvbDnTMHZgAT6e
	7q4VX4X7+a4GReQagVUwt6G2AaGB9KvmntUTs4WsTCGGoAN/jktj
X-Gm-Gg: ASbGncvpSzbDiy37Fdp7rf/MF+t+yz1S0mFebsj5qg+tQqYdEreIhNU8fx4xaT7jfJe
	ctiuWcWzAKaPArsJIosH6uQHCVmhhOgAGti86191TTemjSy41DEWiymD4YfOyZ7twvA5obLzEIs
	xES7X0Vb9lVo/JYLnlBqqHmfOIJZFoQMOxeE02hgRI0ts8AJjoHYtYGY/i63yOj3ZyTAfAJSOu1
	Lxa+QasPuXqSqCf5P/7ZMPpMTm5EApvdCOaldrbTM1p
X-Google-Smtp-Source: AGHT+IFXeyI9vAcAH6rAgJBjbYUandXoU43FysAiQnCTh92fN6p46Oyvs6lJ8SZSBx0Mc3K8abX/NQ==
X-Received: by 2002:a05:600c:1c82:b0:434:f537:f9c1 with SMTP id 5b1f17b1804b1-4362aab668emr57089055e9.9.1734448735652;
        Tue, 17 Dec 2024 07:18:55 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4363601569csm120060805e9.4.2024.12.17.07.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 07:18:55 -0800 (PST)
Date: Tue, 17 Dec 2024 17:18:52 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v11 5/9] mfd: an8855: Add support for Airoha
 AN8855 Switch MFD
Message-ID: <20241217151852.wj2cbrisv6v4sdl6@skbuf>
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-6-ansuelsmth@gmail.com>
 <20241209134459.27110-6-ansuelsmth@gmail.com>
 <20241210211529.osgzd54flq646bcr@skbuf>
 <6758c174.050a0220.52a35.06bc@mx.google.com>
 <20241210234803.pzm7fxrve4dastth@skbuf>
 <675da041.050a0220.a8e65.af0e@mx.google.com>
 <20241217151339.gjpdkfbechdjohza@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217151339.gjpdkfbechdjohza@skbuf>

On Tue, Dec 17, 2024 at 05:13:39PM +0200, Vladimir Oltean wrote:
> On Sat, Dec 14, 2024 at 04:11:54PM +0100, Christian Marangi wrote:
> > We can see that:
> > - as suggested regmap doesn't cause any performance penality. It does
> >   even produce better result.
> > - the read/set/restore implementation gives worse performance.
> > 
> > So I guess I will follow the path of regmap + cache page. What do you
> > think?
> 
> I'm not seeing results with the "times" variable changed, but in
> general, I guess the "switch regmap + page" and "switch regmap + phy
> regmap" will remain neck and neck in terms of performance, surpassing
> the "switch regmap restore" techniques more and more as "times"
> increases. So going with a PHY regmap probably sounds good.

Could you find a way to reuse Maxime's mdio-regmap.c driver? Either
create separate regmaps for each PHY address, or make that driver
accept a configuration which isn't limited to a single ctx->valid_addr?

