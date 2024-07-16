Return-Path: <netdev+bounces-111770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AEA93281A
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 16:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D2E11F231E7
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 14:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F2413CA99;
	Tue, 16 Jul 2024 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axY1boJq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEF819923E
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139487; cv=none; b=jLNWRkrzJztl3EDec+aV9Jj3yM5+2+r87zVNzgr0VBa6JHRAHnNZNGj7iviV9RBKTaIv6tILA9uvPBTjLVkTWxT9cG2DkhA8489S5VEYGFJy6SY+Nmd2VgxTLbRAwNPgEi+ohJ2JLY/Zigatidz4tPYgeF0cjArz9VJ0o+yXEyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139487; c=relaxed/simple;
	bh=oC7QAunkHiyz2ejVepmiAnUgkJ9Q/ilwbupaT7J5jJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTkFHjqC9cBsAIIHPZnZDkNrPgAVxNvHjsVn2AyU/nmmW1IKnWJ0cDNkArA74SeNM+RcMnh55tFfEQ0bOMM153ws0DTrBvDPqcTKjv6EIC31ZCaVCb9Jotf9dtgCZSV2jPF7vfXiHLmBc1kQjfHjcH5qUIAkRVry5a2W8KSaSs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axY1boJq; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-367a464e200so3425698f8f.2
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721139484; x=1721744284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vycRxd7Dd1VKnH5vcGVJFyLiS49+mJeajKSNTunM5tw=;
        b=axY1boJqqD4NSjOfPB80CuJrFX9nMv7iYMF3TrBE39kgDSTErVrOYF4FC7j1Rj06kM
         KAxMf6Bd0F1Sezh3YXS0N7KLT3R5hmQDJOwWXF16+d7qkJWR2//wbXs1BHZUeT0vuJtF
         pnoVCA5zgbp3NKDv/MYXV/g9tK64pAnBI++2nFJSEC4oQKuFuN7eJDAUYdGyum/mLKLf
         MtiUZYVn9W5fcf8Ts1yH6SdcKcgSG1RHEb9AM/w0CBcKJVbRM4TGAS0s/+Y6sH4swSTm
         3sJO/2XsGHxjcqT/Q9YQVJl8K1VN7FjQUHLTVivNbBPMYx0n6z/DAJWfxqSzHQfFiHCS
         oiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721139484; x=1721744284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vycRxd7Dd1VKnH5vcGVJFyLiS49+mJeajKSNTunM5tw=;
        b=DRlE6sbix0bPsDqEZjKhNVKIAZuKZ0Z2BAIO59fa3E/zoT+W+ixoG3H6S63m2XPskz
         9SeJEXwrDp1I2L87Z6JsGhnUbIgd91IeXLkT1QmDR9m69TNx/QjzdIoo9XzRhaanCYyu
         a3/ZLt9AUW3WkBt9kfqpbjZG3cCaAnw5s/uCoPDYqZ/PckZ0Wy0N7oG9U6sl3dWZI0hJ
         loSgnTWQEDO3tPU//Z7lWLamzw8FK4npy46jCu16fVRRx81MetsRiCj426mZfP83ycBj
         CcAWCn9GFU2eu9YnfaCWRD2dfbwM59mkts6d4h91Vi+MtDXUOXDWXfIaqmCC2yp9iaKX
         xSMA==
X-Forwarded-Encrypted: i=1; AJvYcCWpyoHPBhDcm7xBVViGcLvf50qVAI2/t3Na0bUuBtbUmDJl+OyipfX6/4xG2d/ASFX/P+z96AqzlPuqSgMk1Rc+NZpiWv/p
X-Gm-Message-State: AOJu0Ywd6znIdTO3FGAEcwrTJ4SADyRnrJFeWFHRdFP8EhZ7lRLc3llU
	Krg+87ct4c+YvhSVnOFshh89kxvQtKjfu6lLUYjAcHW6ixnm7yI6
X-Google-Smtp-Source: AGHT+IFfzbg2+GhM11L7EcZwXp2TYuH0P2hQZ0oCRw4xbkXvxxbdJfdD+PVZeR60A/vOZF/UhSaC0w==
X-Received: by 2002:a5d:4447:0:b0:368:5e2:9f0 with SMTP id ffacd0b85a97d-3682614ed99mr1498921f8f.36.1721139483462;
        Tue, 16 Jul 2024 07:18:03 -0700 (PDT)
Received: from skbuf ([188.25.49.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db03e41sm9154948f8f.98.2024.07.16.07.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 07:18:02 -0700 (PDT)
Date: Tue, 16 Jul 2024 17:17:55 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Willi <martin@strongswan.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Respect other ports when
 setting chip-wide MTU
Message-ID: <20240716141755.5dq32slyd5agum7z@skbuf>
References: <20240716120808.396514-1-martin@strongswan.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716120808.396514-1-martin@strongswan.org>

Hi Martin,

On Tue, Jul 16, 2024 at 02:08:08PM +0200, Martin Willi wrote:
> DSA chips not supporting per-port jumbo frame size configurations use a
> chip-wide setting. In the commit referenced with the Fixes tag, the
> setting is applied just for the last port changing its MTU. This may
> result in two issues:
> 
>   * Starting with commit b9c587fed61c ("dsa: mv88e6xxx: Include tagger
>     overhead when setting MTU for DSA and CPU ports"), the CPU port
>     accounts for tagger overhead. If a user port is configured after
>     the CPU port, the chip-wide setting may be reduced again, as the
>     user port does not account for tagger overhead.
>   * If different user ports use different MTUs (say within different
>     L2 domains), setting the lower MTU after the higher MTU may result
>     in a chip-wide setting for the lower MTU, only.
> 
> Any of the above may result in clearing MV88E6185_G1_CTL1_MAX_FRAME_1632
> while it is actually required for the current configuration on some (CPU)
> ports. Specifically, on a MV88E6097 this results in dropped frames when
> setting the MTU to 1500 and sending local full-sized frames over a user
> port.
> 
> To respect the MTU requirements of all CPU and user ports, get the maximum
> frame size requirements over all ports when updating the chip-wide
> setting.
> 
> Fixes: 1baf0fac10fb ("net: dsa: mv88e6xxx: Use chip-wide max frame size for MTU")
> Signed-off-by: Martin Willi <martin@strongswan.org>
> ---

There is actually a much simpler solution which I advise you to take.

We already know, by construction, that the MTU applied to the CPU port
is the largest among the MTUs of all user ports.

So you can program to hardware a chip-wide value which corresponds only
to the MTU of the CPU port.

You can see that rtl8365mb_port_change_mtu(), qca8k_port_change_mtu(),
mt7530_port_change_mtu(), ksz8_change_mtu(), ksz9477_change_mtu()
already do this. And we also have rtl8366rb_change_mtu() which takes the
long route, as you do, and which could be simplified.

This fix should work, I believe:

-	else if (chip->info->ops->set_max_frame_size)
+	else if (chip->info->ops->set_max_frame_size && dsa_is_cpu_port(ds, port))
 		ret = chip->info->ops->set_max_frame_size(chip, new_mtu);

BTW, I now realize b53_change_mtu() suffers from the same problem.
It would be great if you could also send a patch fixing that driver in
the same way.

