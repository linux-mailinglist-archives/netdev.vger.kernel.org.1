Return-Path: <netdev+bounces-133654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE159969C4
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C221EB22574
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCC21922F2;
	Wed,  9 Oct 2024 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A33ELTOz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C0418C024
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476249; cv=none; b=QIXKwosBgXpTVoAFO8/63TpMZc6LxtmTgbrBGu+2Ckbxmi0N00e9VP1x7gveO8UX2PIlYmy78QnZXe77khBJaLc7H4dNnQqL+dPBCTKdGoid4bp/nt3zZaLffWekHU8Ifze9Q/aEB7XYz4WOg+M3H7qjXAVSH7Tc0AQwkCuIVIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476249; c=relaxed/simple;
	bh=JfIzDYGFDTnHvQxGUy3rCox328LHJOzjRRSWg0iem9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRLEEcnChGA5QKzBCxg2lmL64cn58Wrp/vRNGMyaG8QwtzJo4G7MKmmfLofU8tyLp8qe4TkuGaXYw78xil0NgGABnILwn8raEfI5f3+QDDZRPfKMqzDwqFgLbMXC8Bloss5LJhojVR6qkSPiQp/drBWlLEQfhrPiKt6LOnLHWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A33ELTOz; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9952a6020fso37301666b.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 05:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728476246; x=1729081046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wThhtfPUrHZAn4fE1IUoD5BwwnG5VY9T+V5Lx5JDStw=;
        b=A33ELTOz7jD5x/McreNWi5XY7G50tUTV9PfdCwDT71fnhrAvMKsg3PAWgz2LE9hcfS
         34IEmlqgZgcEyfxg1E+oGyGBeRDB43SKL/Dt/19EAjhc+4+N9VSmpP8/z/pH7/fzb2g9
         9s1RcAQh9K6KpfprRpu1FY1+3xk35FDZayXk1vyZdEnZX4noU9Rk9noaK8fUmOYRERkB
         ZA3CRz0V5xV1F0e3d7ZuaBoeGfdd4RARuMwvu41udKcDrlxeWZ7/IMZIC8vid2ZSBkuY
         eWq/+RTHI/+hV8Zv5ld63Y50XkY7nwj9aMCGMZGL96B2P8ZosD3mocjB9xyyIa2U0Fku
         tEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728476246; x=1729081046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wThhtfPUrHZAn4fE1IUoD5BwwnG5VY9T+V5Lx5JDStw=;
        b=hKJ7LcovTNS6Q1FOX0qkfuRlWRSK8S5w+a/LjntFYPXOxAClvZvNdSpTh7a6gVcul7
         LKEntzfRy3ipvr/xxJRfLd0cp00E9e9lK3YC3ZhpiVZYdYGwN5uKu1LVC7uurFzDPn4a
         BvkOrAtS06Gb7yQK/BhPVpoAgPKsvTiDEBIqDhfFnIwb8Ee5B1Ywjuf4WfuNCl/bFLVH
         jt6yZ+fG34cfBpvS/qoZzFAYUjIwNAr58bKs1DIS9saanAqTTZop8uEzoRJMeQAlortn
         CfBpFM7yC/06WKDydyZIa8lQ2SOKFtq8kKL0RzESq1JDTCTu1MAN594K+7dszkJxS5hQ
         I7Jw==
X-Forwarded-Encrypted: i=1; AJvYcCX794NmPt7DNs4Su6GHQLz8gpHo/7LRRODEGvB1MKjyfSkmjsqy8okTDXn0JiwbpumBVdvmTDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGplh5tM0+y0Igk9W23AJJRESIs6u0djCnazIGRLKaHKjvfs58
	683i0YQ8lds+eGKcJOS+RpxqMrSaG9zQcz0agK/j0xe8uo9fWwrX
X-Google-Smtp-Source: AGHT+IFLzG9i8ADfD0HOhuu3i+fGcKp+OUI0upODPVW9TOw9lEVmwcQv37wmGVE9+BeGqt+ymGDDIg==
X-Received: by 2002:a17:907:7f87:b0:a80:a23e:fbf9 with SMTP id a640c23a62f3a-a998d19eaccmr84945166b.6.1728476245553;
        Wed, 09 Oct 2024 05:17:25 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a995babdbe0sm358804166b.172.2024.10.09.05.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 05:17:24 -0700 (PDT)
Date: Wed, 9 Oct 2024 15:17:22 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/3] net: dsa: remove
 dsa_port_phylink_mac_select_pcs()
Message-ID: <20241009121722.2bvkc2iykbqspwex@skbuf>
References: <ZwVEjCFsrxYuaJGz@shell.armlinux.org.uk>
 <E1syBP4-006UnV-Lk@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1syBP4-006UnV-Lk@rmk-PC.armlinux.org.uk>

On Tue, Oct 08, 2024 at 03:41:34PM +0100, Russell King (Oracle) wrote:
> There is no longer any reason to implement the mac_select_pcs()
> callback in DSA. Returning ERR_PTR(-EOPNOTSUPP) is functionally
> equivalent to not providing the function.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Tested-by: Vladimir Oltean <olteanv@gmail.com> # dsa_loop

