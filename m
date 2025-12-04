Return-Path: <netdev+bounces-243589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E2DCA449D
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 16:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9068B3006728
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 15:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4514D2DEA8C;
	Thu,  4 Dec 2025 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3Zx2I80"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921312DEA86
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764862649; cv=none; b=lOk6iQU9vo4K1XCgiSUas1EXLhLmqsI4zErzDbv8edFAA62opeG787KFBMctutfC8ZTX1U3bDzDmiUoK2rnz1sELE+iYMyu+Q6VNgW4EjVn3YWmd271bauMhcwpcpHsRVOvbe+sDPhRlXwueoy7VZcARmTD4RNC9jYj1pp4yVYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764862649; c=relaxed/simple;
	bh=TVgnuxlKysk08eelnnKo8pjKu6ntkrgHXUnRDuP7mjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSbU0Ibx04vWZCOPOul2lzU84lRgiFhDmTgU0aljEodVU32Dt6F5cEXcFdOMyaAOmCN1EaH0reFDDyd5qGSEj8im13ZKZYRFO1+81G70a2SDotkhgD1DuZAPF/64YTZ+aZGUflbQpaEAuwcbqzE5uXp6oCPnHHvP/NkzNHQ0y54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3Zx2I80; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4790f0347bfso1213635e9.1
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 07:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764862646; x=1765467446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iasODFwnrpej5ihKsaAUgxOzvlJy+tRXrHwJOSqIP0Q=;
        b=m3Zx2I80ecf02U53jnpG+oG3M2bVYlJzUIwsiIgxj5/ZI6dDNC8B2B2NGvxNiUG+jK
         f/SHoGiEe2WuiR5zEiZP/LmM1INIGdZd4RGAHPqLtSm+6wuP+RIDAhCAwm6nZu0mi77h
         N1BaVHNMHoB5SjBjdufUVwwrRk+YhfEBohR7vSiTVnfYR9iybONeGrRIWEf13AsZHlqO
         FqRp8yj88K12hGkAnjJe5Bo1n+VdKX9V5TBzd39L0NhEFsWdNsF5Gp2HvHAQh7Txj11k
         Lkd/9rCrSHTh/35bLVGjOEAve6bF4NRFZTArUW9nmue0Ie2E2/8I8Nka8HK3UIpVXphS
         ZUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764862646; x=1765467446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iasODFwnrpej5ihKsaAUgxOzvlJy+tRXrHwJOSqIP0Q=;
        b=HCA6EPQ/POnosZs1Be/csqWGVPU+Uy720+7RrVWjUWgJ1nsFeD+Z3ubxvmjjiqV4R2
         JZqRUHrj0dxjF+gnXdL+JBHT4696k5zDNsWZZCh5WSuUdoBInrSQewQco1J/vbFBBiEz
         kFvY+wncbvzj/5fwW0Aql04/O6TDYg4gLUOxoyMCHoV9Id2N+GMaO+RroksX6xJZobn6
         x/LfHsDwX4urriYyW+UMR8pRrcLrT1LY8QY8J9texN1d17xraHsMS2Ld+kdH9kYUKhJB
         RUY/rYSCrNaEZIFwnINjio9V2FrHDFNRAPgv8+xiLpFbx4Tl79SHVmj27PfkoKl2KEoh
         0Hrw==
X-Forwarded-Encrypted: i=1; AJvYcCX3Z+EbyOZEkP5YEh555uVbRL58HxCG+3M0uIl8I1uqmCZbKQvbGF0lraXnjTtLWDfCogRAM2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxagbjZ9V4nkdPkiuSRsHNUoPGD18IE/mPDGMdupvyxf48xWH0B
	m6Q0uPnKxS4QNCAAbBwkAd3zLjysplShyvB37F2pQP872wmpu/Z8Uhd2
X-Gm-Gg: ASbGncvZTxqTzWPvUyYYvOK4wNKA5yeR3n8uWR3sGRsBRAf8l9oG21GKUFZE9orojTi
	HTDX5V8w4T74TzpyGhXxOwBfIwril0wDUQQeSPlM9KiGIxp5GEKlAB7Fl5EvmtIaIefQXgkqTN8
	RVv6bx+/6iDYdzFOIkPxUV1Jzd4YyP2K97S4YnCeHomu3C4bJ6cys3o1WyjX1jKxLwDJOWwTemc
	nG5y4Jy8v4rYMN5AUw+bv8NQKq/ksXQ6Q+pzILzxNOxeIejTBuh3cje00IftFBonL0mHImEDb/l
	ew1ztMvWWWhSaaggoM4F63Rirut5uHHC5CC+ocmBeeNLIB+daCFucfV82eMADgkUehq42PaUuDv
	1Q1bK16PFOHWO9loX/4/QeE56MzhLkJu+3oTswRXkpQud9uBsxiIaggr3+S18ggGD4DO0K5P9gx
	vXHoo=
X-Google-Smtp-Source: AGHT+IG0YF6qmFx9hfyT69cJ/NJuiahXcMZFrcwdfYs4/eTXFVZRKEz/Y6SPeFs3HRVMeBHdDKXaRQ==
X-Received: by 2002:a05:6000:186c:b0:42b:4219:268 with SMTP id ffacd0b85a97d-42f7568973cmr3423808f8f.4.1764862645565;
        Thu, 04 Dec 2025 07:37:25 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:dbb2:245d:2cf5:21d3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d353f75sm3948069f8f.42.2025.12.04.07.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 07:37:24 -0800 (PST)
Date: Thu, 4 Dec 2025 17:37:21 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Daniel Golle <daniel@makrotopia.org>, Frank Wunderlich <frankwu@gmx.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Chen Minqiang <ptpt52@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/2] net: dsa: mt7530: Use GPIO polarity to generate
 correct reset sequence
Message-ID: <20251204153721.ubmxifrev4cre6ab@skbuf>
References: <20251129234603.2544-1-ptpt52@gmail.com>
 <20251129234603.2544-2-ptpt52@gmail.com>
 <0675b35f-217d-4261-9e3f-2eb24753d43c@lunn.ch>
 <20251130080731.ty2dlxaypxvodxiw@skbuf>
 <3fbc4e67-b931-421c-9d83-2214aaa2f6ed@lunn.ch>
 <0d85e1e6-ea75-4f20-aef1-90d446b4bfa1@kernel.org>
 <00f308a1-a4b1-4f20-8d8e-459ddf4c39b1@gmx.de>
 <aS7Zj3AFsSp2CTNv@makrotopia.org>
 <20251204131626.upw77jncqfwxydww@skbuf>
 <7aacc2c2-50d0-4a08-9800-dc4a572dffcb@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aacc2c2-50d0-4a08-9800-dc4a572dffcb@lunn.ch>

On Thu, Dec 04, 2025 at 04:22:10PM +0100, Andrew Lunn wrote:
> > If this is blocking progress for new device trees, can we just construct,
> > using of_machine_is_compatible(), a list of all boards where the device
> > tree defines incorrect reset polarity that shouldn't be trusted by the
> > driver when driving the reset GPIO? If we do this, we can also leave
> > those existing device trees alone.
> 
> I've still not seen a good answer to my question, why not just leave
> it 'broken', and document the fact.
> 
> Does the fact it is inverted in both DT and the driver prevent us from
> making some board work?
> 
> Why do we need to fix this?
> 
> Sometimes it is better to just leave it alone, if it is not hurting
> anybody.
> 
> 	Andrew

Frank said that the fact the driver expecting a wrong device tree is
forcing him to keep introducing even more wrong device trees for new
boards.

