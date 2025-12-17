Return-Path: <netdev+bounces-245111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D909ECC6F5B
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 11:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D709130CC950
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 09:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BC7341071;
	Wed, 17 Dec 2025 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfTTo32t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6A833B6F8
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765965543; cv=none; b=p5ExgRQeCeqAk+aRAtgLf+zusxpzYO4z0wjR8GGP/ibTDN45XTWVqDPoTF6CpKe0gjVOwqUY3v+H0SQxTrgTn6O3ujyBXqV62Ga13cxSBdBXe7JPU7BmnKM1fUMLpayOl/CjdQMSH8Hi09+2ZgV1xhn/wot6CGqNM2ONFMmaNDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765965543; c=relaxed/simple;
	bh=jXr4jE9q0RPJ5l9ZO2welI2KAwlOwkq/FLEItP4YTZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xr1/1C+tSsxdWoGon9FTAyXY7AbRO/SRrUypctqC6iBCRyOJ1bxhc9NZ9hxyTv9VfncfFqxwPwxZmmTDuicqhQ+eKNscjo0m7BAxJRgBPFUY4kBUYbUO9U+P6tqeiY1zpg8gO6AsqqRGmk+FkGp/JoDRHvhoISgqsvconsq/AxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfTTo32t; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so2749983f8f.0
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 01:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765965540; x=1766570340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3jc3whUaBr7zlktBSv49rtqSYWkEekv2gEydX/NzBm8=;
        b=cfTTo32tqwbRgmAxi7T6/K3Q0c2L4yDgNHxrt5P/I5nvdxD4YQsnTov+mvS2vRmlJn
         hzO0/frP+SDa2cZFpeFQl39Mw0kqWpJbafSVqHDiwspTu44IY1HkMboBq5vrPoWJ/57s
         5yXIWcKC3M8aMQRnfuV9O0LyZwAydJo1m6AZELd2XCEe6Q/gwYCmGCHdgNjJYAM7u0y5
         V921zvnW/ak6oY8k6TZfNaOSTWDfWACZxd+3xKr1rRMOMa6wsHfp+0Rax/EJ0bFRbmbO
         2KvtstlL6D2QJ52HKyPIjZ945oJZkXEZFuWntJacmmQW9WMYSV0YSAZFDtzq7vP86+iJ
         yNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765965540; x=1766570340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jc3whUaBr7zlktBSv49rtqSYWkEekv2gEydX/NzBm8=;
        b=W/haegXFfq7xSNAQbxq6dBp7m+kyIWutFJJh4Uc6Yj2s1T4TuE75u6gvmbckLu/GrT
         lo/5UObRdN35FQ/6akyShVYcZopxd+E7trdmcgfv7FdZI+f2/sP4EONzhu6PzIOWlaKl
         FtgpaIWGbsfDmidpFNcyXG7c7nqZWg7AttfON2H1n9q2h0+z79dUhw3bVJh5y+lxfL5f
         kP2SsJhC7a/qwgqPFf5uhOGjPFxQp6st1gOBeKN/jyrTnSO4FRiEUEwM0aaJrQ5ijyGe
         ll1OhuMp9lOeGd0eGqcxpazJIv8BTo5Nlk5N4GJ8h1lj1wZUE6SCCnJ17YzOaf/qRGRW
         QiBA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ9UbnqsTBdOpfdjjib6k/gpiP1Ppk9txqCm1zAy7Mu6WuhEVrjttsAwc8NS+kgDA21Iy9w8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9b4uW3/a4mhF4qSSCbvwYtpiqxuZsnNtuVCULPFfzGQQc0B2T
	2mDC0LAcfZBrN9j0Y5x7B2wx5F/96hTktG7H2r3VotbFy5OEbvGchd+T
X-Gm-Gg: AY/fxX7BCuNvC0Cr20qnuMAFJiFIBzYqNyhUBskDZrR29UNrwM68Kw2CCpO66vjFwiJ
	e9bWNKrhT0UQVu3D876ITW+FZPIbq0WORo82Ryyabqth18VOpCZsm2CZ7KkK6IYHoP5yAdkBasl
	NSVz0gAzGAn9BJiUU1f3/y0+QiFiicJr1xlJOAtAo2wOHWhnxybc84sSPdmOogDNT+B2B1t1BTS
	UugV766E0qJ7UMSj+lee8bE/EO7AUtEjJgqbATBCc7/Yy6/PZU9g7yGFfENYIPKrZfwvz0abFCD
	P3ooFiUPVUm0DukYZDBV1nh/FTk1QsD3w5VWjiAVwdtFzTKvI7rzrYnsCGc4fpAcfRCT8SH3iKL
	I1n8fFzg/FYckoAsDsME1fILRMDo5WQkyE8FuAfsLhpuYxhknFKIQFIxI/KSKQxNEmwFG6JkU7u
	YqnHcNuxJMCkfXddTGL7E1ng==
X-Google-Smtp-Source: AGHT+IE0TpHDZKDDpv8f/WTGsH3kkUcjmw8BbJKHsuXuqCvvog6Xf4zlav8LM2abYWjss5eG+OPWMg==
X-Received: by 2002:a05:6000:a:b0:431:488:b9a8 with SMTP id ffacd0b85a97d-4310488ba7fmr4767326f8f.33.1765965539531;
        Wed, 17 Dec 2025 01:58:59 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:b288:1a0e:e6f7:d63a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adeeef6sm3845307f8f.32.2025.12.17.01.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 01:58:57 -0800 (PST)
Date: Wed, 17 Dec 2025 10:58:54 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	geert+renesas@glider.be, ben.dooks@codethink.co.uk,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, francesco.dolcini@toradex.com,
	rafael.beims@toradex.com,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH net-next v1 2/3] dt-bindings: net: micrel: Add
 keep-preamble-before-sfd
Message-ID: <aUJ-3v-OO0YYbEtu@eichest-laptop>
References: <20251212084657.29239-1-eichest@gmail.com>
 <20251212084657.29239-3-eichest@gmail.com>
 <20251215140330.GA2360845-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215140330.GA2360845-robh@kernel.org>

On Mon, Dec 15, 2025 at 08:03:30AM -0600, Rob Herring wrote:
> On Fri, Dec 12, 2025 at 09:46:17AM +0100, Stefan Eichenberger wrote:
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > 
> > Add a property to activate a Micrel PHY feature that keeps the preamble
> > enabled before the SFD (Start Frame Delimiter) is transmitted.
> > 
> > This allows to workaround broken Ethernet controllers as found on the
> > NXP i.MX8MP. Specifically, errata ERR050694 that states:
> > ENET_QOS: MAC incorrectly discards the received packets when Preamble
> > Byte does not precede SFD or SMD.
> 
> It doesn't really work right if you have to change the DT to work-around 
> a quirk in the kernel. You should have all the information needed 
> already in the DT. The compatible string for the i.MX8MP ethernet 
> controller is not sufficient? 

Is doing something like this acceptable in a phy driver?
if (of_machine_is_compatible("fsl,imx8mp")) {
...
}

That would be a different option, rather than having to add a new DT
property. Unfortunately, the workaround affects the PHY rather than the
MAC driver. This is why we considered adding a DT property.

> > 
> > The bit which disables this feature is not documented in the datasheet
> > from Micrel, but has been found by NXP and Micrel following this
> > discussion:
> > https://community.nxp.com/t5/i-MX-Processors/iMX8MP-eqos-not-working-for-10base-t/m-p/2151032
> > 
> > It has been tested on Verdin iMX8MP from Toradex by forcing the PHY to
> > 10MBit. Withouth this property set, no packets are received. With this
> > property set, reception works fine.
> 
> What's the impact of just unconditionally setting this bit? Seems like 
> any impact would be minimal given 10MBit is probably pretty rare now.

In theory it shouldn't have any negative impact. According to the
Errata:
  The IEEE 802.3 standard states that, in MII/GMII modes, the byte
  preceding the SFD (0xD5), SMD-S (0xE6,0x4C, 0x7F, or 0xB3), or SMD-C
  (0x61, 0x52, 0x9E, or 0x2A) byte can be a non-PREAMBLE byte or there
  can be no preceding preamble byte. The MAC receiver must successfully
  receive a packet without any preamble(0x55) byte preceding the SFD,
  SMD-S, or SMD-C byte.

However, since Micrel didn't document this bit and because the driver is
already older, we are afraid to break something for other users if we
enable it unconditionally.

Regards,
Stefan


