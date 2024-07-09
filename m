Return-Path: <netdev+bounces-110378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C71892C22D
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D94E1C2321F
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4D219247D;
	Tue,  9 Jul 2024 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjirLhMX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BED192477;
	Tue,  9 Jul 2024 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720545025; cv=none; b=CFaFhcby5Mm6LDu2jIDixqoVN2yyh8cmr9l53xELenPxTDC3dlBU8vgR6QPOuhujJ91W4tmX+ZbD4EotrDsYZNilLPHgH4ovsa2oqDSUDoyxseJWcuBRRtowJ1XrnPhQS9BNvETnDwQvqcAMlgUx/n2qqbW8ONaTALXszOXEPKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720545025; c=relaxed/simple;
	bh=XZ1fl2SO/+a6xEKiWo6qTLVg9pIeprfWVXnkj5uDsQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r84hzsfqG6nqLV1rOKDNqR9vsH4fJlaHdDI61C3K0gEMora2tS8eY+OCxNiC5S/imFVdK8Zvw27NYuONHfRgfmghIoD+RGEortEtzzaiFWI4Y0L62tqHpBInqXwvr7ZG8JwN+fPGPkkWyto4a2tf1WDZJXGF3Xh3698lE0FWzYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjirLhMX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4266fd39527so9817635e9.1;
        Tue, 09 Jul 2024 10:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720545022; x=1721149822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B7UZKmcE2rW2GXX3bgYnLtnkQIb55kJXHNrapjoEJ90=;
        b=FjirLhMX8GfOi3qc1Q2c6wPgWQppa82o4vwOnbRbvtrZtXGJTYURHBrJrFsCOUFjlB
         YlZpgRXFXKb5cFgtfPDm7hvV4b21jp2Q0RhaB5j2HEyMteyad9q/nbxRkM+Bc6r2MGRm
         TQ7QtYKqNeJTFvSm4h6AjfqJ6+ixMqLTkedSVZFJh3506jKd5/xDibdZxQK9WRfxV6XF
         fDeCAxhxLJwt0PHVXdlHNqLGp8s4xcTFPdYQek4kXfMnCIKepr/1++7V4S2SKDlMm/pi
         4kHbXtParj0F9euGbHtzPEF3vcdSsdVSHLAAkpr3YOA9IzZ6OcHiqL6tTtKygrsFJn/x
         /woQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720545022; x=1721149822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7UZKmcE2rW2GXX3bgYnLtnkQIb55kJXHNrapjoEJ90=;
        b=aqHucvkIBfMdu7MHmoclT8PMzGhBnbBKXqVuO5Hauo/dLX/xohj9aqgXXc6scCqeZb
         VfKu603CP+q5ES1y/ild4w7pmIiOmgBdZUxgyDVC/X/qOSpFeI8SdLyrPg1+0AagOsrT
         UFEcxCxrMA7jcBN5t4ufG2fH0zpWAVeoh9qy/yzYHj4jG4Z6DK0pgTzNkjGheW+TX+LA
         gx7yMw+nu7KLzjlgM07XGAkj/VrN2CA+f1UxtrgiVbaXtU7waqA37q//eAi2fFArTBQo
         aWoqyvf/1O21N/pS1VofFewe8uwuO/k7W0KOst09kNn01HV4RKpQWUtkzpScHLoSd8h3
         M+8g==
X-Forwarded-Encrypted: i=1; AJvYcCWrEk4nzieddj/VUKiYWhPRwOHBnB0YVfZrjts14j7KkDtAg+m1NuLwa9R+DoZ1rf+zLR+VyiEzEX54Ltsxh+bhs74XCCutk+zH/JAPB96Td/eCUJ/yc0MBZ50B6IvpbuKgJ9ES
X-Gm-Message-State: AOJu0Yz4Wb17YPku0A2vErIaA7Z11eCMel872SpBBHay357WdQvlAxg5
	4Z1RerQXd6a3TeF65Jrx379M6AJDJcCi89LIXhyi42jIE09z9lo0
X-Google-Smtp-Source: AGHT+IHkO0uXExOBNSEEs8y3mlUuaeJd107eAQ+DLn8Jeer/KspdrN5GrCY5LpSsAWLOkTnLqQJIcQ==
X-Received: by 2002:a05:6000:ac9:b0:367:8a6f:8c0e with SMTP id ffacd0b85a97d-367cea67f4dmr2130410f8f.21.1720545021824;
        Tue, 09 Jul 2024 10:10:21 -0700 (PDT)
Received: from skbuf ([81.196.28.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab080sm3041923f8f.104.2024.07.09.10.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:10:21 -0700 (PDT)
Date: Tue, 9 Jul 2024 20:10:18 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Furong Xu <0x1207@gmail.com>
Cc: Jianheng Zhang <Jianheng.Zhang@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v1 1/7] net: stmmac: xgmac: drop incomplete FPE
 implementation
Message-ID: <20240709171018.7tifdirqjhq6cohy@skbuf>
References: <cover.1720512888.git.0x1207@gmail.com>
 <d142b909d0600b67b9ceadc767c4177be216f5bd.1720512888.git.0x1207@gmail.com>
 <b313d570-e3f3-479f-a469-ba2759313ea4@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b313d570-e3f3-479f-a469-ba2759313ea4@lunn.ch>

Hi Andrew, Furong,

On Tue, Jul 09, 2024 at 03:16:35PM +0200, Andrew Lunn wrote:
> On Tue, Jul 09, 2024 at 04:21:19PM +0800, Furong Xu wrote:
> > The FPE support for xgmac is incomplete, drop it temporarily.
> > Once FPE implementation is refactored, xgmac support will be added.
> 
> This is a pretty unusual thing to do. What does the current
> implementation do? Is there enough for it to actually work? If i was
> doing a git bisect and landed on this patch, could i find my
> networking is broken?
> 
> More normal is to build a new implementation by the side, and then
> swap to it.
> 
> 	Andrew
> 

There were 2 earlier attempts from Jianheng Zhang @ Synopsys to add FPE
support to new hardware.

I told him that the #1 priority should be to move the stmmac driver over
to the new standard API which uses ethtool + tc.
https://lore.kernel.org/netdev/CY5PR12MB63726FED738099761A9B81E7BF8FA@CY5PR12MB6372.namprd12.prod.outlook.com/
https://lore.kernel.org/netdev/CY5PR12MB63727C24923AE855CFF0D425BF8EA@CY5PR12MB6372.namprd12.prod.outlook.com/

I'm not sure what happened in the meantime. Jianheng must have faced
some issue, because he never came back.

I did comment this at the time:

| Even this very patch is slightly strange - it is not brand new hardware
| support, but it fills in some more FPE ops in dwxlgmac2_ops - when
| dwxgmac3_fpe_configure() was already there. So this suggests the
| existing support was incomplete. How complete is it now? No way to tell.
| There is a selftest to tell, but we can't run it because the driver
| doesn't integrate with those kernel APIs.

So it is relatively known that the support is incomplete. But I still
think we should push for more reviewer insight into this driver by
having access to a selftest to get a clearer picture of how it behaves.
For that, we need the compliance to the common API.

Otherwise, I completely agree to the idea that any development should be
done incrementally on top of whatever already exists, instead of putting
a curtain on and then taking it back off.

