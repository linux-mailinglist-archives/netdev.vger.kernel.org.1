Return-Path: <netdev+bounces-166857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF404A3794D
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 01:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE68B16D2FF
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 00:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8146C8CE;
	Mon, 17 Feb 2025 00:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwYk/B2J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300207483;
	Mon, 17 Feb 2025 00:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739753740; cv=none; b=H2g/f5MILBCZ/7Y0lv8aNOV7hNT5Z/yYS1ugFVSwWdL5jK6Zvp0Wyz7h/o2aQq1bl/SCBQGDWxXpXU8h6xjR7Sp4pyepTbJ8zmWzWZgKA5Z2U3DDojukpGVodUO5+B5fDWRX9k+bnAOSRw7PUa4d2+QAPnAMv72iJQvUZXuLx6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739753740; c=relaxed/simple;
	bh=hvLHtuNhaUgf1KW3YGZBQYohwM00krLReOySkvONkd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwftmo0V3ILqwotYn/eNriZsVXtwVEPhBJ3lC1EaeSWsrXbg4uspFzIO9/HTvqbzXVW0pgIefIsxqvDprPwWIR2x7qVcsvrQZCMHkiJq0NZqlDzCL6v402jDY6v2LVb4yLUoNxV9tipaKuh0ahAq9yL1MjnfA923IQTeCZSDPRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwYk/B2J; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c0a159ded2so16054685a.0;
        Sun, 16 Feb 2025 16:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739753738; x=1740358538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3miERDX1Xv3RedAiXlRskPLUBkRSYFDtnSlJTeyyWT0=;
        b=WwYk/B2JJ4uEn/VVg1so6Pexpl51qpNHl219WVI/1R7jJBhZHo7ENO7f2tDfRS5bsQ
         KI2z2AP/mqjPRt/52bB7XKjJ4M0TGeC8JCiIrKdTmV5hs5/xUuCKmYhZAgN4Q7s23AiT
         a/05n8DzEogweY8vmhIjVXAad5wnjcjo1ZKoRxfedQdQWSzG7q3JcP7YdY/ZfNK3Hb/4
         ApUzvGQpsZRvUPhCi1GbDG1khv2CRAWxtqg3W56WBVgmdK9UpNROel/gv/jDzQCGhYZn
         FlAIokwOUh0IjVeheRSMn7Cz+ProRLztUtR6iQ4ntJ0LN+8sZ9YQmtcR9/SOYIMf32/1
         Gbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739753738; x=1740358538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3miERDX1Xv3RedAiXlRskPLUBkRSYFDtnSlJTeyyWT0=;
        b=ZjNyM4+d+fgTWKrJ69h0hb5bB+mMl1r3U5XLiX1gJx5rHMVSrOvds6/7XgZkFIht7T
         frxOEcqg8g9HvMw6B46aAGGVZ7TZdHeY6gpDmsFlD4X05edSIZzInySXMTYa/z/fXW+9
         3Rt5gk63O4xLO2BAdenxndzYjAVS0TK/NoTMaEqdhqJqXxdO14db5VZskPS3NqsiD+F9
         F2e7oRdsEJUBkxchmhmM6ca/do3uda1tLk9A+fg5A8GwLJ48NFtJkMBQPSZe0Ua8d+2A
         bsreLbmVA4ckLbymH8FGMqzSEH91j4J/udcWA6T9fO7VQKhEn6/phRdFXETkZcMlruXt
         A1kA==
X-Forwarded-Encrypted: i=1; AJvYcCUzbXrMkLBqqPIM2Vu35GBSW2NmLn79DQEnYHYLfb7E1hVzP7RLTBLtsbRHtT+1hXEDia3KleJ5URtY@vger.kernel.org, AJvYcCVgmKMB4sdZHOtkQ8m+V2KoMn2WOwnRZ67MbHX+cj5rFrQu2CTcqI0732vrjek/WrMcNR9ReFcB0ScN2itG@vger.kernel.org, AJvYcCX5MVKp/JWeRcRaEoDx+YG7BxmDvSWIiiYyP443vRqaUxAJJf8/UlYzn5ZYNGLKz5Z+l6bSzFde@vger.kernel.org
X-Gm-Message-State: AOJu0YyN9clEhHvEd18SQOv2S2KzR5a7wOV4HrUo5VMcW8oakv6lKiLV
	APC1+ilpvCu9uG8Jv7gatziluhjHY2MIQa/HSx/Z1aA2iwViUol+
X-Gm-Gg: ASbGnctl2Lu5WhP+V+26ZhaV4/ep/1kwQVh31lzbQ2bpeT3/PAFPIKGW0R03zUQI3jB
	/v7xed2cq/hoC4eLUo73LYktLSBrb/v0hxw4Ac3fmFdEwmo440HYTsPKhEF817mKJQ9cKyKpwCP
	6kN638M9R+jmj9P9vWsKhN1qr+hPPBR555QP0mw+qTHvC/IcJ/BGgx0GEuOcXeLmVipRrlB1GlL
	QGiFQhwVuiSYr3oYhRZhwgLjeoS47lYx68yR0CnAMOHX4Z1M2jjNQohHfjd6S1mF18=
X-Google-Smtp-Source: AGHT+IHgsgnwFBgfmCk8QhqZ6tipeWPXEoq+VknthPTSmFHcxqBFyFKlKkuCSkeq1Ol3omy/oe0Xgg==
X-Received: by 2002:a05:620a:8904:b0:7c0:7e88:79c2 with SMTP id af79cd13be357-7c08a9c8a13mr1123805585a.22.1739753737957;
        Sun, 16 Feb 2025 16:55:37 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c09a302b3bsm85445485a.35.2025.02.16.16.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 16:55:37 -0800 (PST)
Date: Mon, 17 Feb 2025 08:55:25 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Richard Cochran <richardcochran@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>, 
	Hariprasad Kelam <hkelam@marvell.com>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	Drew Fustini <dfustini@tenstorrent.com>, Furong Xu <0x1207@gmail.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, 
	Serge Semin <fancer.lancer@gmail.com>, Lothar Rubusch <l.rubusch@gmail.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, 
	Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v5 2/3] net: stmmac: platform: Add
 snps,dwmac-5.30a IP compatible string
Message-ID: <o4wyk6rrctm3f36s6gzg3stxyplziwtpdorbfcch434ns5iwso@7f6jikrnxumi>
References: <20250216123953.1252523-1-inochiama@gmail.com>
 <20250216123953.1252523-3-inochiama@gmail.com>
 <9dcab9aa-6d1e-4804-82ff-fb8dfa434df7@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dcab9aa-6d1e-4804-82ff-fb8dfa434df7@lunn.ch>

On Sun, Feb 16, 2025 at 05:59:31PM +0100, Andrew Lunn wrote:
> On Sun, Feb 16, 2025 at 08:39:50PM +0800, Inochi Amaoto wrote:
> > Add "snps,dwmac-5.30a" compatible string for 5.30a version that can avoid
> > to define some platform data in the glue layer.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>
> 
> Ideally, this would be two patches, one adding the
> stmmac_gmac4_compats[] with the existing compatibles, and then a patch
> adding snps,dwmac-5.30a. Logically, these are different, so two
> patches.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
>     Andrew
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
>     Andrew

I will separate them and apply the tag, thanks for reviewing.

Regards,
Inochi

