Return-Path: <netdev+bounces-109904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5C092A3B5
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 15:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE494B21937
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 13:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C316A022;
	Mon,  8 Jul 2024 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWR5sSIr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E4D28E3;
	Mon,  8 Jul 2024 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445646; cv=none; b=mWIuQYslx5xY7apvrYzgVlh8FJoo8yjP39dR3vK4n/hEnkvLCR46Fydef7OyIY9g//s3ykIzFx1zLRyba+W8KJLjerE0B05ybaax+zDqatXCPbUMCIKcwWvG0V6Zxyu9yaxGkobTlGFdsLJQ9cCfoKTJKyS8mnoPuxYhfRLjycA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445646; c=relaxed/simple;
	bh=v8OHFlk7ICswpQ3iB+blCtY7cm91+7G5/yFt+R4dKFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lypOqbwQltwLUbnz5yQuNd7XsL8LHKLmMIu3p5Z6j+RMeva5LTsxEmNqglGe259M6tBhHFsaxFx3u+Q9b/m+poN8gQJKaF/peiHEgqdcqOgu+AWJVo8A8pdd+rv5xKZDgBXpsJY5Oj33SHzS15ACV3w5agpWSO4w5yCGV8rIopc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWR5sSIr; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec61eeed8eso48437781fa.0;
        Mon, 08 Jul 2024 06:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720445643; x=1721050443; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a9KZem+hR+Ssu5sLJZQFJef/Bm0HGi/lC7YM1maoGyM=;
        b=XWR5sSIrDofgLBs0wuaeWemGMoaPMeh8vGVjoVBc0BFAHwyL5BjD/cqHYypp6T/LTG
         knNKrosEKoixL5vyCo9itItAUQKEk+IoQAPcohA8yMH9sZ4ucfNWt0jDmvIP8LjFys7H
         BnNBIcQFT2PG4ALT9EU/bnWJAscYp6fCrRIp4Maf5/hRH7Fv9CVnK9/68a+LawCWlaUA
         8346eDwNmmX6ZYCVoV1Zyhc3Z84MId5q+sRrgjSZLDLahvoYfsTpoyONyzIzA3oJwfXb
         RkJjdwavjHfrN/8CWJuv6mz8eyC1xMV9RKNI7+iqsa50JLnMbWdx769F5C9DX/v5BwU6
         BQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720445643; x=1721050443;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9KZem+hR+Ssu5sLJZQFJef/Bm0HGi/lC7YM1maoGyM=;
        b=AxatTtu2a72kiAVuPpfJSKC06DwYOmS6TLdEijznAan66vCaLiNnOvJm+FTRGsi+kj
         EyEEM5dGdgo2garklAZ7iCaLwRyrQYPMeO6D2nwSFP/zN32E3cDYhjuurxyR61fQXgee
         TaXOVdO4ZEOfJZWXfLVpKI/WfiKlCyQC3nPoGoOgOjN9ucjYHSYAI1EtvmaZZUmhC3Gn
         q5TGLB8PzUVyXZ+2kP4JpcOfof8Dmuja59mEdSCSgYIW3GcwoWe5wPC9vpEKWxJ9dmNQ
         w/zYYiGpbj+/KYHmK6pURft7wuClLpLjiky7T05CAfGwM8L2Z/NbITXtcVRqaPRAK1PY
         LZSg==
X-Forwarded-Encrypted: i=1; AJvYcCUcMShdE7CGGeTRD5KQGpGgZgV/DSIzPHC69+cDfJUwHUv9HsVeCGu5ffqwXEg+Kx+g9LweVmMGwYrQqC/cST+S8PpOnyyb5oPQj7jRqBaFSvJ4mjp+5lBoVHNS6NfUWHvxNKun
X-Gm-Message-State: AOJu0Ywhq9ThG4LH7Dz1jGYoBPCu4mLqWvi6cHcDGhKrXR9GImF0b2mB
	MbUP4WP5CjqdqvoAOvD7r1BBtp8cwuUdQiqMrvnZgRcpgwUNx/LE
X-Google-Smtp-Source: AGHT+IEQu9zjQlULh2lm47m/DaCiSvsXwcsjLuaAMCjs8rdt+0vOxB36+NT7Ah6gIEaprzFcZ7Qu+Q==
X-Received: by 2002:a2e:bc0c:0:b0:2ee:7bcd:a3f with SMTP id 38308e7fff4ca-2ee8ed5edfamr103234371fa.22.1720445642560;
        Mon, 08 Jul 2024 06:34:02 -0700 (PDT)
Received: from skbuf ([188.25.110.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36784e3e0f5sm16538327f8f.11.2024.07.08.06.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 06:34:02 -0700 (PDT)
Date: Mon, 8 Jul 2024 16:33:59 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Landen Chao <Landen.Chao@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v5] net: dsa: mt7530: fix impossible MDIO address and
 issue warning
Message-ID: <20240708133359.rylvvmpcwlsxtrs5@skbuf>
References: <f485d1d4f7b34cc2ebf3d60030d1c67b4016af3c.1720107535.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f485d1d4f7b34cc2ebf3d60030d1c67b4016af3c.1720107535.git.daniel@makrotopia.org>

On Fri, Jul 05, 2024 at 11:48:40AM +0100, Daniel Golle wrote:
> The MDIO address of the MT7530 and MT7531 switch ICs can be configured
> using bootstrap pins. However, there are only 4 possible options for the
> switch itself: 7, 15, 23 and 31. As in MediaTek's SDK the address of the
> switch is wrongly stated in the device tree as 0 (while in reality it is
> 31), warn the user about such broken device tree and make a good guess
> what was actually intended.
> 
> This is necessary to not break compatibility with existing Device Trees
> wrongly declaring the switch to be present at address 0 or 1, as with
> commit 868ff5f4944a ("net: dsa: mt7530-mdio: read PHY address of switch
> from device tree") the address in device tree will be taken into
> account, while before it was hard-coded in the driver to 0x1f
> independently of the value in Device Tree.
> 
> Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

Despite having commented on v3, I am not going to leave a review tag on
this patch. Its contents has nothing to do with DSA, so I have no
technical objections of my own, plus little authority for an ack.
It basically boils down to whether the phylib maintainers are okay with
this use of mdio_device_remove() API from mdio_device drivers
themselves.

I did have a technical concern in v3 about a race between the finishing
of probe() and the call to mdio_device_remove(), which Daniel did not
respond to, but I suspect that __device_driver_lock() from
drivers/base/dd.c will serialize those.

