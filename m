Return-Path: <netdev+bounces-250671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FF9D38AB7
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 01:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BABE6306DBEE
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 00:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F673BB40;
	Sat, 17 Jan 2026 00:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3ZIEpKn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FBF2AD32
	for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768609826; cv=none; b=mj9vsPooEyhJrrwjVE0TqdNBW0GyT5d+oDjzEtlWSUz4peOfgwTjZRsMS9o8w0TqCo1Hro5AFQWl2nMmJAlFwRncGiyBbyrILaoQ9+bwZkIK/EvQXePqckC8tHCmDakh5LEeGhHI9YyenCdYMidT9K50mMaKvo6HvHuzWrtiJ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768609826; c=relaxed/simple;
	bh=luDJ/W67j2gZ4jPrGcVobjYQ4folzdqjBsuUm3FaRPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iINwJbw8EHvjvIaMXCMnmrmSYZ6rlnzu2lEex1jIFKQhIK0rHDrDU8uUR4swwP2O4BgJitz0H93FJvsoNv8GSNDxScb70NG5jpl9RVRB0oH0m51LcTbqzPTfeEsGDdV6O7XNnzt3QEsDtBhJ7ngvlqFcphz2hTKvaW6FshUAWR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3ZIEpKn; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1233c155a42so3472042c88.1
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 16:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768609824; x=1769214624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yp1sONmI1EVSxxcQrVc8RcvF+u7mjGF7KxmFk1Nh69s=;
        b=l3ZIEpKnWLSSseycrj6crW/YWGRH1JxLQ4tR6AB0HyxnYh+HDuN+Ze1CGWz2DbzNRS
         0HQrgHUUiFIlFFiE4GtVfu0ZHxUcJLtPAS7w7aR82gfE5/bPnIYpSwE7Ax7QyAYENPT5
         gKL9tfmn4nj88Vcvq1994xsCFE1nsdBlSywfEsZ37HMuY/+n2I2TxRRVTYeEcBj1hrrO
         S9JBuBtcCnEXrpka0atxRp2jDY3OIxS16W+dyOqLRBUsHF0fmnqEYDAlKfbGhjHuSOj6
         N6Fj60nTOkAKr/PNZfgR7kIzM9uVwOD13Z4YtTpQxYuvXL1aBrlAojhsOh9wiyIA3dfF
         Fafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768609824; x=1769214624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yp1sONmI1EVSxxcQrVc8RcvF+u7mjGF7KxmFk1Nh69s=;
        b=KuhcYIWs5qO7UsL/oG9GIDtXLssKKpgXTolaf3ErqjSb2T6NvdHHVnfoTn378+Tcv1
         tyIpceSbSAitnx3bJmJk+7/k8BjyFLbv4/FA6G+M1H774VcFWEQ904nzTpU0VpC/rRIa
         stpkVfX+MoBMVbZlLWOEXHJTGlPf0JpVf7IwarwWhEslv7xUlzFS+7cp+ONDdW2zncgF
         tVfJvyZHIiMib38EH2umIkcXzRn+Bupge1p/pbdguJTwFL1P2eaRWUgB6NC/CFFLb25U
         kOr5pgwzGUJ6U/QtLGjsWUOmVhTQOcfRoVbcPC4MIVgu9K0lh9GMGOKf/6ld3dDs7Rk8
         OvSw==
X-Forwarded-Encrypted: i=1; AJvYcCX8OAg381WnXO+4gHE2ntXLrin8U/3LPvReFScjnZgJmGRxSBaBQSsgxKxYFqpCYnU72BEf25k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgDYPc5gLba+Q4AXa4bsT/sZk1Jk86tsX9bQNhVHqQnsEw3fuR
	KU3cDHwYk5ehbH0qSieO3hQZg7/7TrbZ3Y5niUoX8BUZ1TKduDqrzewg
X-Gm-Gg: AY/fxX6ZFOTcHb8CXoO7hTH+OfQkZasOBcXuV3wRe6FzeVM5i3wGpZ0IoNzYk23FONV
	ahrgb6gW2kT/baSDzv7WAbhymW08tleaFqfk8TeU+qzcPe8shU8mbZ50ZxIX/JBl7N0b497raGK
	V60FVCBp5TFTz2LuEBgPL4BmEExfRDUKo06CV56i11NLLsQskenB95f0nc3A798PbWpxNYZpxTY
	jF7b4rX2gQlPkRtAndi7lyX0mRs4vrCz/XWksG3DXHlX3HMZyCCZHoSnhOGnPSRUERcCsodCwon
	9/kM1sSxur60aSJxjYnBcCIVY+8aqDLiWW43gaaZZxRVMbagSGKjVEEAGtS3rI1yZXOFfh4/IHZ
	Q+Yhoajs16IOWUepHOcKGvWV/d0OKibOyyy4P/dvryZvjvaWJ8PnBkG8oIvloXe5b2dl+nA8FUp
	Js/OR0166Zw+Zqf8cVQLtt
X-Received: by 2002:a05:7022:4181:b0:11b:2138:4758 with SMTP id a92af1059eb24-1244a6f4633mr4977023c88.21.1768609824098;
        Fri, 16 Jan 2026 16:30:24 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244af10e21sm4814313c88.16.2026.01.16.16.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 16:30:23 -0800 (PST)
Date: Sat, 17 Jan 2026 08:30:18 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Karol Gugala <kgugala@antmicro.com>, Mateusz Holenko <mholenko@antmicro.com>, 
	Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next] net: ethernet: litex: use
 devm_register_netdev() to register netdev
Message-ID: <aWrX3KKsOke4Z-3c@inochi.infowork>
References: <20260116003150.183070-1-inochiama@gmail.com>
 <3e326797-b4c1-424f-8cf1-f0095e33e0bc@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e326797-b4c1-424f-8cf1-f0095e33e0bc@lunn.ch>

On Fri, Jan 16, 2026 at 06:20:05PM +0100, Andrew Lunn wrote:
> On Fri, Jan 16, 2026 at 08:31:50AM +0800, Inochi Amaoto wrote:
> > Use devm_register_netdev to avoid unnecessary remove() callback in
> > platform_driver structure.
> 
> > -	netdev = devm_alloc_etherdev(&pdev->dev, sizeof(*priv));
> > +	netdev = devm_alloc_etherdev(dev, sizeof(*priv));
> >  	if (!netdev)
> >  		return -ENOMEM;
> 
> The commit message does not fit the actual change.
> 
> You probably want to split this into multiple patches. Ideally you
> want lots of small patches with good commit messages which are
> obviously correct.
> 

In fact, I just change them by the way and it is not a obvious change,
OK, I will split it and send a new version.

Regards,
Inochi

