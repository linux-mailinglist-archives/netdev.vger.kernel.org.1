Return-Path: <netdev+bounces-243590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E4964CA4542
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 16:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F2F53000B6B
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 15:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F012EC094;
	Thu,  4 Dec 2025 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJ6zgkVr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932A3284894
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764863164; cv=none; b=V2rlApM/sHPuVvcoIZTtN0Bmdg0MZyRVVzFqnO1kEQTRgaOFy17cJJjXw6N/s+4gJnFug/eW95V9HBgT4FVm5//kzshY2N94JN4vIOg1KyKUf3YN+6KV/uyUtTBr+3mN4dBJ+I7m5AUnWtKimpUZMFK/h9DConSh3N7R7XmRFzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764863164; c=relaxed/simple;
	bh=OANeToixdo+mH7efYF1LjErkENQ4UgqJDGxaw9at5wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2NNrJA7Nnc5kbKFriBJLDpFyjY1QXN+ceq2G/ZoOJEJi3uzS5PE34jyHZMb5+tRkGBJcJm7Ih6AIzeEZnYRPiShGSwSTqNJ/KaPubcJ5CQCQX4FHOH1YAcIwDGFogfgWSj5vMVYLj6y+Q4fZ20JuCuIDbcjVSp/PPAAzM8+orY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJ6zgkVr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47798f4059fso1551245e9.2
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 07:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764863161; x=1765467961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UA/yY7fbsmAtbpdVmUxmHBhgln+Uq+ruk57Ak1wbz+s=;
        b=LJ6zgkVrJD+jxw3mylo8ta6vpGc4JZExBOLL+PJGd1ovSfdVAPgqZHcsxCOqyzeEoD
         t4zFvNgZivCw2gVB6crb29fHvlfgn/H8dj+NxZYEYHLHLwhRAftflAelVbTC0Y7gl7tp
         yrZ4iAzapesJuYV2XMP5RFoTTC1L4/H5nXRJHEcgQM83jiK/1LZUObZRFxqhWdccSi+k
         XBA8nhED2yiN9w8KpbRxMPLZb3sRV3UYmLCadgcHcPZ+AscPUiwWgo6aW47RRep2Im4Z
         grnfoC2WACkVBl0N+QqxuUGKVoR7uvC9mLC7IJYQjxTF/zWQMc9WkXn74ezTgkpaToT5
         xrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764863161; x=1765467961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UA/yY7fbsmAtbpdVmUxmHBhgln+Uq+ruk57Ak1wbz+s=;
        b=jgTPC8SZcFa986xr7LzA5wtpvOfoqguKJzHkPkxyR9NgrecOK68HNAUZXIVpr/JHl/
         eoKvZPcd43a1lqE4fWKbiYpxc/8stHYox4GpF1V9awVUgpajpo+UhKw7H8PNIa8JI/xa
         dK4dfpvUOyBLKM+XuOvS3gq9tEKoDz1pkJt/GZluHnkNTOdpcJvzWh/gfTbcogYbSoh9
         JqTta5dqoAaYs4OY/RcSz7Xn0vkSc5bsKjA2dBCAecA6dHX/3Gv94CT3uXxaRS8LF68r
         ErZ9dWX0aVk+b4ueHdrgkI9qBwcX777AgnGtHchEdolifttrdBYdvdK2uhXrk8MQ8jR0
         ZG/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUHQIcGKrSUSafhXoOcmEshozo031aQAAzaiQatSAb5p+aVaaqBv7g72B/1j466ZVpq0K/ExU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpOliKg3QXXlX5dIwelOFwafb9+qNTeyk1OdqCez6zq+lP0Gqv
	7+YwZIKzoytmLPSLMmrzU5cz0yQIR0dOEwWHSnULSb6bVxNX72YcfVjrSGksPw==
X-Gm-Gg: ASbGncsEzwX6IDt4jeQS+FxWiXwFadnWeMlRxOQ72VEHUyyJGKmy67XJXkQNsp5AisU
	M65OWKEeIqOXzkeYBInwPCOaYy5ykUntzlgvNxVfy6ku1xZsYdRO1VpM3+rQ6umAf9rxoIBNBoM
	uK/mOLwX67x5Osd4YAgF09+iWUASASPA2vMwf53f7rDPjjkMOREGuMygB81kap99p/JGENUrjFk
	VgfPh/wVpkIidtp2bXOt96bHOniPlzX4RAUgF6mxe2DbKjKe5Imgt2RT2db1SuGeCKXqKvYiXtu
	2gMLTH/QUio7FdVwFw02U1NEkISidQXt/EylTS8cDTUtAociW6K6k6IW1i7hPg6d5aV65APaxbt
	Z64xUrCkBVIW4fRALC8zzQHzbO4bs4l0s4Wl1HgwZ2ZnWlG0cbUS+NbSch8zlJ1Iu2EH+lT9cQH
	LRKoM=
X-Google-Smtp-Source: AGHT+IHDhvMR+KTLaJIj8x4ZJCrP7vfLKbK4kH2ayI19QzVBsuMMnG5taOmZS+QplfMCnJIxB2E8tw==
X-Received: by 2002:a05:600c:3b90:b0:477:9c9e:ec6c with SMTP id 5b1f17b1804b1-4792c8f2462mr33160085e9.8.1764863160680;
        Thu, 04 Dec 2025 07:46:00 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:dbb2:245d:2cf5:21d3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d331a4fsm4069295f8f.33.2025.12.04.07.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 07:45:59 -0800 (PST)
Date: Thu, 4 Dec 2025 17:45:57 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Frank Wunderlich <frankwu@gmx.de>,
	Krzysztof Kozlowski <krzk@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
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
Message-ID: <20251204154557.b7asnuxq7hiy5zlq@skbuf>
References: <20251129234603.2544-1-ptpt52@gmail.com>
 <20251129234603.2544-2-ptpt52@gmail.com>
 <0675b35f-217d-4261-9e3f-2eb24753d43c@lunn.ch>
 <20251130080731.ty2dlxaypxvodxiw@skbuf>
 <3fbc4e67-b931-421c-9d83-2214aaa2f6ed@lunn.ch>
 <0d85e1e6-ea75-4f20-aef1-90d446b4bfa1@kernel.org>
 <00f308a1-a4b1-4f20-8d8e-459ddf4c39b1@gmx.de>
 <aS7Zj3AFsSp2CTNv@makrotopia.org>
 <20251204131626.upw77jncqfwxydww@skbuf>
 <aTGRvADkT-1kAQgA@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTGRvADkT-1kAQgA@makrotopia.org>

On Thu, Dec 04, 2025 at 01:50:52PM +0000, Daniel Golle wrote:
> On Thu, Dec 04, 2025 at 03:16:26PM +0200, Vladimir Oltean wrote:
> > If this is blocking progress for new device trees, can we just construct,
> > using of_machine_is_compatible(), a list of all boards where the device
> > tree defines incorrect reset polarity that shouldn't be trusted by the
> > driver when driving the reset GPIO? If we do this, we can also leave
> > those existing device trees alone.
> 
> From OpenWrt's point of view this would be kind of ugly as we would either
> have to extend the list of affected boards downstream, or fix the polarity
> in some but not all of our downstream DTS files.

Including the downstream-only boards, how many compatibles are we
talking about? If we patched mainline to cover all, are you confident
that it would be an exhaustive solution?

> I'd prefer to rather have the option to force the "wrong" GPIO
> polarity for theoretical future boards with that (very unlikely to
> ever exist) NOT gate between the SoC GPIO and switch reset line. That
> would allow to gradually update boards to reflect the physical reality
> and yet the driver would not break if the GPIO polarity is stated
> wrongly.

I didn't get that from this thread - how would you prefer having this
option implemented exactly?

