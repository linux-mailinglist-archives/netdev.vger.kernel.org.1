Return-Path: <netdev+bounces-223435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 050D4B59207
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78090177ED5
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3F7296BB4;
	Tue, 16 Sep 2025 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fX4Ie3R9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7921928467B
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014563; cv=none; b=nrjS6RwQyL3XrZ4Ccqw8bJaf374IEpRyNbADwkC39yAT2wpsxHLWY7D801oo1y4wBEBAf8sZksDFSwJcaelEwjBT7Pj8J/EKbl4UbkVihzV9SXKdc04D+cL3Wx/wmu1+0SGrFu8RCBomIwpgS6G5Tfa/MNNN6Lm/wWnwlV+R1rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014563; c=relaxed/simple;
	bh=Zdz5N5PCQo5el0paCRO5ZbfYt6/ZUdg6bzTxBva6VrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTSNqNLJirXvYDkGm1Y5+bPhkShZzHg9MWCQsJnW4EgJ0JEN7BojWTByVZhgPY+0Ab1cTRNicF91/xh34kNm89zaBLOU2MwDnniAtBog6UMdQK+tG8MuoRJ0qqHTGkMJ5R2OBiEOzCljywN2e5FBWBUDCM/1taYoRDVrJFGUF+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fX4Ie3R9; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b00f6705945so72248966b.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 02:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758014560; x=1758619360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KGCvPfLrGKdNRgmVzLiDbD0YiPIIBW/1XCfpjvCQ0ZA=;
        b=fX4Ie3R9TWfT7kjSSFvyZCx49iAhA9vash2EXKx79tdlLuWeZEJVyrseo9HclT+2pI
         JjR/SavFlojyURb8/iAlaYbMGbpI7Lt6pExnSom8FiC3u/vycjEtzxYTAq+4KeKAEMWC
         dMuvP9sSDhLcTYkeUj2M/suBh3nEW7EiiBaMREuLhqctmvjGlHecXAoC5D8wHeSvN4lo
         jGs4VGN5+dWB32jb7WbvyhxXY3qssjixTZGZEL41V2+w1uZLLVmZYKsB8tR9fLrMPoVU
         MVIbYfFDiGpslDGXRAQ2bvre9y5V3IPJPSzaYea1ktCWY5Kl5jYaJjdpduyXcJBVxyz3
         Km7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758014560; x=1758619360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGCvPfLrGKdNRgmVzLiDbD0YiPIIBW/1XCfpjvCQ0ZA=;
        b=olSyLu8ylH5DF9VTjr3QD5w29+eTDYA1LGegTHpQoyZEAJcDPJHUl2EDsWDCIRp758
         5Vc90l/GfG3vTtV0EvzGAyftubcN0BzmtZJW8MTlTvBH1nTOp6YSPEKkGNUhjY8j16q/
         6/kt52IG4IE4jB1er8aVlnHP4CiN+lPOxDwpNJEfDKM56IyeQerDczJ1HW+9fheXUwT2
         nll99t1Zey+bY208xjMZVVg35wz5z/bn0q975GCRYA2uqNTI64iYreRW5HstEObHnCId
         MjsbWGwGPpcrVTrtg8Y4CZ/ET2biL6s3BjOyF3NN/6qRoHWxMDf2KXm4VTWWSRfW1VGw
         R/Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVRxUGwMG8v2mm5kEnjjMdu+mbO+7TkaxPH9A5QBvHSA6j8uV7Yf0xMwwyaKYe7/V60MlqnlvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgHFj38IAQwgPja30E6WOpIBHds95b/VOA/6wsFprQG9RLjJOE
	TfhuH2sZ8xFIfTrivZIpSavEol2xtTXYI5Zg8CYAyMhJ9Kkcq3lPBK5Q
X-Gm-Gg: ASbGncsABuXgXypkceTXzwUmf9L26CjaClkBbcSNID5LHDyJW5Vg74V55LJOGTz9+Hs
	IAYr5juC1+kWBMZpPEB/D9F/qkfdP+2KDy7B9d4sowGqr8AyIBPVCfCZvWDDlfsSc+5hdPlh/+g
	gyQXNHduKi1EnbNmI6/z+awezIbXZo3w8/Ne0fRfO22wDQZ+XqzabYsnpUO9dw/Vm1kF2hg8AT9
	iFJMxCipkAI8S9adzCLsXi+cVRf3wRpREyvmf0Q2dK/zWTU9lpeDsYdnPJG782v0iwfN5d0LR1W
	syVbshe7cqPOoxMCjwMI6EV4aRjtIKmMU2e2erHpMesnBDBFG9EkUoc8q9izTcmrH91foODBAjp
	8OJG1t2BRl700/Eg=
X-Google-Smtp-Source: AGHT+IHi2Ls4PyAUhTmWb7Y4llv6Gc/XZ6sXf9RhMVWzGjZ56A3Oc44bEclDZrgXbLXBxF4VdqS1jw==
X-Received: by 2002:a17:907:2d0d:b0:afe:b131:1820 with SMTP id a640c23a62f3a-b07c37cb861mr861285666b.6.1758014559508;
        Tue, 16 Sep 2025 02:22:39 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:2310:283e:a4d5:639c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b3347a2dsm1109479266b.98.2025.09.16.02.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:22:38 -0700 (PDT)
Date: Tue, 16 Sep 2025 12:22:35 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next 3/5] net: dsa: mv88e6xxx: remove duplicated
 register definition
Message-ID: <20250916092235.ctbdjhjepwdtxuqr@skbuf>
References: <aMgPN6W5Js5ZrL5n@shell.armlinux.org.uk>
 <aMgPN6W5Js5ZrL5n@shell.armlinux.org.uk>
 <E1uy8uX-00000005cFH-33oY@rmk-PC.armlinux.org.uk>
 <E1uy8uX-00000005cFH-33oY@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uy8uX-00000005cFH-33oY@rmk-PC.armlinux.org.uk>
 <E1uy8uX-00000005cFH-33oY@rmk-PC.armlinux.org.uk>

On Mon, Sep 15, 2025 at 02:06:25PM +0100, Russell King (Oracle) wrote:
> There are two identical MV88E6XXX_PTP_GC_ETYPE definitions in ptp.h,
> and MV88E6XXX_PTP_ETHERTYPE in hwtstamp.h which all refer to the
> exact same register. As the code that accesses this register is in
> hwtstamp.c, use the hwtstamp.h definition, and remove the
> unnecessary duplicated definition in ptp.h
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

