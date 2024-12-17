Return-Path: <netdev+bounces-152635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 308BC9F4F17
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3244118827E8
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41691F707B;
	Tue, 17 Dec 2024 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBN6AfSG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1681F4E3D;
	Tue, 17 Dec 2024 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448426; cv=none; b=t010ImU6xdUZfEGORUzyJ3VjsuyiRc2LYPVdqMkwgjO361clHEF0v/Mbc1I2Af6tWgydAYBoInD5PWaU0oRO0MCWNW48eJrSaz0AoUU8PluqjmC3d0C/Q3UQAgppWi+fIkBrFdNWYFJAmvs3b71AsCeCEyZE8MLz0b8GrN4EgC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448426; c=relaxed/simple;
	bh=0EZ4VCczDE3WfjSCWhXUWIXqdTVVn0SQjmi5vL1q8h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvB9QNqmkXRfvIdBclIETjGRUdvzr+TpqjMB6bgpI4bHtSMAg1R9XyiywTWMJySg/k81to+h/VXtV1ZMPxEfuoBrkhFb7xIsT0j4dSXCc04ZLiLwLnQZ1RvCdKRwKVzB6i9opz7aUtmVJHHSHKQlCznaWhj9TK6HqRuq1H0Kzao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBN6AfSG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436246b1f9bso7343805e9.1;
        Tue, 17 Dec 2024 07:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734448423; x=1735053223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mIbodpRWxqrrqRRUsCSmxdoYxLL2MHEZUJwlmjhZJMc=;
        b=BBN6AfSG8np+rdUXskjIv93ES7XVGZ4Oc+KoLtWXZ7aIhpRC0xwjCSq0fwqqo5i+6U
         frTA2hid7OWkXvVDG5jtaPfoMw+u2dwp290p9h+KtKM6iw3v0cAk1uqSKguYqrJnowli
         hu4+XsI0LLDvfJCzAPoDvlXWSqPE0C7Fh7La8OetT5EA4YxhR9MBFOS7/1Jm3Q+f+Bux
         pcgu/8X3DwgYRQqYncT0mwowMhnTxmSLfZWkuNVqFAJVBG3zm+xp2+dsrHZ6unY/cA/T
         jJr/780z6EZClF/SiKPz+gkqPzETJCMCDyd+5S539oOJsO+g17Il7mHzvCX2bZqjMo+y
         1TFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734448423; x=1735053223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIbodpRWxqrrqRRUsCSmxdoYxLL2MHEZUJwlmjhZJMc=;
        b=eW9NRgB6YPNTN90i6YnkEzK78jn/Lb3H0Tf7D66npQ8hQJ/d05PPR8iCOPlRBs50bK
         1k++HhhNflr3dPgxR4ss6zbAlsf3E1Z2KJ9YG4f+mqCUCx++gdBAhYNiKJ/tps2YAEXw
         Jud2P2DrYv8anyB/iKEL0JKr0F8fMh6Gj2aIrWegNQi9Z++5524Ima09CUfjMhIXBT4i
         9GQ7CaJ8sjxcEyjVthySjb9ZQ7ypPGakk43QXFUUJIJkH/td+7qvNx4HdDdodCAXNmb/
         6E0AmZOeNaOy5Z8ew4f7iihtWC42W/Hlms+OS0DMEyFdzDDeYNGcDa6kciYKWDKZWB3B
         Xdgg==
X-Forwarded-Encrypted: i=1; AJvYcCV7Zj/MkAs3gZU5gNobcy0P/9jg7Jl5PLAmfzJ2/DGg/AYQ2KvUP23yD1fTvzjgkry9E39j5S4muAiEkWb0@vger.kernel.org, AJvYcCWKFHl6mQKnRV/PY+0PqdYYpMvBkq5jYA5ixgWsa5RJgkiwFWkNJgLPAMrn37LemmimxyXtnpj9@vger.kernel.org, AJvYcCXw94WwEknV5LEmHsqOxUtFLOh0VXLwCCGjiC1xPl+HPcGujHZ5tcPsf6KkRsXGcROPDRvSd/G6/I3q@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh0q/AmweQ0MgrE0anOIsWGJ3MorGOMwlT7iGm5jg13elZrutc
	MTv59MXNnH5nFRtQ88qHCOwm63nnCLguwF5PyYdDfZj5Rv0yVMLO
X-Gm-Gg: ASbGnctWeOogu21l1Ts6MHOzAZa1DXHYxuDwACpyKTDNdxjEUuHJFLEpL43C7801/Oy
	5AX2c3eZW1ycMK9ajRK3prC8WPrYRtBtZwIrK+oFsisvbYEYyixZ3StaU34ug2hSmXZmYwTy/8z
	Imk/AMbM5YxXiI+zBEssJhcpfHjlgDygsiuo1DnwcQwVIhXl+uL0gAI2ifmwc5YMyhnSNpPiK/W
	XmGCZ5+S6nqWfFCsoisT0+54WkDFEfKK4Pp0+jWBD4L
X-Google-Smtp-Source: AGHT+IHLcu6qj3H5z8Rh0t1dPSXaYp5zGOT8WvycKhg3dUOqzNjj52VHTli51/q2/uIIlYifEe4k4Q==
X-Received: by 2002:a05:600c:4fc5:b0:434:ff85:dd77 with SMTP id 5b1f17b1804b1-4362aa3a62dmr56863795e9.3.1734448423285;
        Tue, 17 Dec 2024 07:13:43 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436362c7d59sm119484895e9.43.2024.12.17.07.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 07:13:42 -0800 (PST)
Date: Tue, 17 Dec 2024 17:13:39 +0200
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
Message-ID: <20241217151339.gjpdkfbechdjohza@skbuf>
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-6-ansuelsmth@gmail.com>
 <20241209134459.27110-6-ansuelsmth@gmail.com>
 <20241210211529.osgzd54flq646bcr@skbuf>
 <6758c174.050a0220.52a35.06bc@mx.google.com>
 <20241210234803.pzm7fxrve4dastth@skbuf>
 <675da041.050a0220.a8e65.af0e@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <675da041.050a0220.a8e65.af0e@mx.google.com>

On Sat, Dec 14, 2024 at 04:11:54PM +0100, Christian Marangi wrote:
> We can see that:
> - as suggested regmap doesn't cause any performance penality. It does
>   even produce better result.
> - the read/set/restore implementation gives worse performance.
> 
> So I guess I will follow the path of regmap + cache page. What do you
> think?

I'm not seeing results with the "times" variable changed, but in
general, I guess the "switch regmap + page" and "switch regmap + phy
regmap" will remain neck and neck in terms of performance, surpassing
the "switch regmap restore" techniques more and more as "times"
increases. So going with a PHY regmap probably sounds good.

