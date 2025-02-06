Return-Path: <netdev+bounces-163406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B23A2A2EC
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E3E18890DF
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785C521CFE8;
	Thu,  6 Feb 2025 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/mGnT0K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD971F1537
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738829299; cv=none; b=rnSXcGv/8GhxiRkVziLtOpTlo1j5eF82AaINulJKUeilY3mJw+j4AeYFkTTqf1L4pz8tcpeZLGtFixM4xrtW5lOewyMrJqdndYTArn7QfHI4JTASShnOlvC77k89jaxingdjXM7ofLpI4/cQ23aiDguRWLSg0th4U6B31pZzMNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738829299; c=relaxed/simple;
	bh=tqVHY7j7PZJ7OlvdePt/v1iw00l6PSdIJp/fvbLbav0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mb70MrvOYDUQl/fRsyRWOf5Zn9b4AIhg46vzYqEeWrWl3a4izOVREnWikew9lkFeChhRm6DK9QVWD57JNQOumTmt8Ku+v280g3h+QBMQKCHuKDe1OX0y9+f5AL9TTBDc16TtnANUmAI+A6e/DdMhvHsA3gijjpjIcbUbNeGbcPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C/mGnT0K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738829296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NJj9rkDTFOQk+bEPSTqUhazzXgNIa2C9a7aAoT7fQaI=;
	b=C/mGnT0KdU1ssg5TrRJ838EXDYskum2CcDO9jhDAgbiRdWGTkjGd0Au6hOEUwG6cc6t0Jt
	d0iT8cg80wWNpZ5D6srvyFr7nJGyRJvN4OwDZETfVRdbCnvlwY6fmMp/tTm6JA61FAVx8N
	N24vy7JTSoPYZymZTXQYVTa0UrfxSIg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-1sLzLIa2Pr6E_4-GqRY7CQ-1; Thu, 06 Feb 2025 03:08:14 -0500
X-MC-Unique: 1sLzLIa2Pr6E_4-GqRY7CQ-1
X-Mimecast-MFC-AGG-ID: 1sLzLIa2Pr6E_4-GqRY7CQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38c24ac3415so358318f8f.2
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 00:08:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738829293; x=1739434093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NJj9rkDTFOQk+bEPSTqUhazzXgNIa2C9a7aAoT7fQaI=;
        b=vtpq6sl0swDEgOT1vVxDCJ8O7fUXqrF9VAcdVSEfS2nIuePG1SpqCM44QY8reJbiOq
         mtK87zqBhjQcxY+iNzTEKu+n2rWqOcZs+DKlo/xr9Pg19+1oLLUOa7G2Fm0bEYU4GXyi
         la+CLNizcIm/SaJvgPwZ53v/16Pzihsv+nKQ0IbqqzrjwaCsw76CcA6Fm6Jm3i5jomjz
         jZ+/f8BzSYyysn6oJOS1CiYT3gGEdHH6EjqxHBlWDsEDziF5qYumJkIqOkDQISYSY7m9
         bJCBzI4MVGSyc91yThNz0KTTeygJmAZwkNXBtVeABXv04mX4QBUgLsaNuQMrei8A1p8B
         NhMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWluSbiXtPtBhhiLgoJS5n4M4fYgs+VQCqmX63NCYq6kV2HtrPWgbLH4djnHiA8/0uplInwpuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu9LUmyold9QKKnVAwM2e9gskQEzJITLOqBsb9Y4mYRBG//OrO
	YOBzqtkikN0rgWz0wG5n2bFYDTH5tWNKJYEfloLmTUpalVi6TAWb7cbQc3OepxssrMjlhEHO7GY
	7atI6EyIaFPAaP5oe2Erig4X7geOiXcsngYx8//bkEQGT4r4qUqqSoQ==
X-Gm-Gg: ASbGnct7JWc9c3ExnscldeCAysjU3D31hZjVwCtJnfF3YCGGGJYzkGKM/JgENMuFwQR
	DwnKZeHzO38L9QVJeIzbA5SkjbwFiKc9TXpXHMAtX1Qnku3TC3xuZbP/n84+aP8R3nPT4+RxrJW
	qs1HHgoGBkoajeAGCex6ZQ3Rx6KiEk6q+wN3HoHLuETm0QXjoQ8rQ2lanwD1l0wBDzK6cP2N4ft
	lJWxotJcv1loivq0EG1JsrsacuX+DWlMtm3OcjBKF31esrud+E5n+fzEn8RoX7CkphWXHc0Coo4
	R5jviVHc7gMWJPFn+6WF2ukBNc9IvwAGjgk=
X-Received: by 2002:a5d:64e6:0:b0:38a:9fdb:7307 with SMTP id ffacd0b85a97d-38db490067dmr4768115f8f.43.1738829293322;
        Thu, 06 Feb 2025 00:08:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPyrYegeID52tdxqQD7ciYyg2T0dKVG6S8SKrlSjQtzEXfxI41hNRfpZNFy4Gru5MLr+ZP/A==
X-Received: by 2002:a5d:64e6:0:b0:38a:9fdb:7307 with SMTP id ffacd0b85a97d-38db490067dmr4768079f8f.43.1738829292956;
        Thu, 06 Feb 2025 00:08:12 -0800 (PST)
Received: from [192.168.88.253] (146-241-41-201.dyn.eolo.it. [146.241.41.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbf6e4a4bsm668008f8f.92.2025.02.06.00.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 00:08:12 -0800 (PST)
Message-ID: <2cff81d8-9bda-4aa0-80b6-2ef92cd960a6@redhat.com>
Date: Thu, 6 Feb 2025 09:08:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Revert "net: stmmac: Specify hardware capability
 value when FIFO size isn't specified"
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <E1tfeyR-003YGJ-Gb@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <E1tfeyR-003YGJ-Gb@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/25 1:57 PM, Russell King (Oracle) wrote:
> This reverts commit 8865d22656b4, which caused breakage for platforms
> which are not using xgmac2 or gmac4. Only these two cores have the
> capability of providing the FIFO sizes from hardware capability fields
> (which are provided in priv->dma_cap.[tr]x_fifo_size.)
> 
> All other cores can not, which results in these two fields containing
> zero. We also have platforms that do not provide a value in
> priv->plat->[tr]x_fifo_size, resulting in these also being zero.
> 
> This causes the new tests introduced by the reverted commit to fail,
> and produce e.g.:
> 
> 	stmmaceth f0804000.eth: Can't specify Rx FIFO size
> 
> An example of such a platform which fails is QEMU's npcm750-evb.
> This uses dwmac1000 which, as noted above, does not have the capability
> to provide the FIFO sizes from hardware.
> 
> Therefore, revert the commit to maintain compatibility with the way
> the driver used to work.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/r/4e98f967-f636-46fb-9eca-d383b9495b86@roeck-us.net
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Given the fallout caused by the blamed commit, the imminent net PR, and
the substantial agreement about the patch already shared by many persons
on the ML, unless someone raises very serious concerns very soon, I'm
going to apply this patch (a little) earlier than the 24h grace period,
to fit the mentioned PR.

Cheers,

Paolo


