Return-Path: <netdev+bounces-133656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D239969CC
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E48DB21932
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DF6195381;
	Wed,  9 Oct 2024 12:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaiT8ND5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A43194C7A
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476291; cv=none; b=DWsdD0ibF1Mf967z/6LJXse7NPp/DEWgWvYz+UyMCfLJZJLXjp40SGTRVknL+VNmSjiFPV/JJcDCMebh+ko3NtN1lVVS7/5//5I5GiCKYoA+py/S8Rui3nFc7Bw6gNWHRGzTIb2pWyZDr5uXv0MSgK7FnnNPyJ4V30XObhJb9wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476291; c=relaxed/simple;
	bh=xEz1OfEnxrL+qbF1Y27VCeUquw8OpPybm908zmU/CW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJ842deaV6m8lESw+RI6IEkeMzKyZA27RdsTm0a46hPJPtdlErqt/4M78PwSHVNJBZGKpyPlqJoU1iY+TfObeHKUW0GAoWjAPnT4CufJ37y5aoUotkGm5wYPM2d61y1bNauU/3j0jcoufAhJapW4N+i/4vzEpWHBC4XJBXFX9Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaiT8ND5; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a995d3cc619so41816366b.0
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 05:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728476288; x=1729081088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KYC9u8Oe5HOxMREdFLOL05/EhHd6SmEFTKb0yIrt9p0=;
        b=gaiT8ND59vREEUNtGKg/Q2T0PMcc9h6Dj/2vXaDIBux6Wwi7rktxQbS02wFctiLAbc
         GGwZrgOMlG36r3T9Tlhe8VzvmIJ/CcWcuYr5eUjsMY0Z06GEdtCzyj+vxhrNBH0Vn3EB
         z53Am3WzMwpnE867lvPybOTas8FtJUrHmEWWuYX8FstAdUy9lPi21hNpPH5wrz1WK5tt
         CyU7pgFet+biyzfp8MPjMLCgdFoGGK9QY+7Rkt3ho9HpRJGI8GuND6QZJebE9uF/5dNa
         mclm+dm7+PJdHxNLUje2DgUWeUAJZlolgF8oQVTV64IRG/jAG1mh/rmcjcJdhfMSdY5j
         lE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728476288; x=1729081088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYC9u8Oe5HOxMREdFLOL05/EhHd6SmEFTKb0yIrt9p0=;
        b=NkVh8G+exSyuiN86eH8AJRG74Wflfc2w6tsZeVWanqqiQ8oxhlsD7ia6+iU6oQUdOH
         IbmvFAZc74xJ+1OuDapb23ZAl53zViF6pVLFKBlDCJCkSKEX7Oqum1Hw1HMNDmu5VheV
         jcKEdQEg13iOzupNAsu7pGLqlGzWBbJ6gjZa5ijykpAyQL3ARY94Ogk7k/GuyeC+pt6D
         jBsLX5HIKVQ23pvW8fzVNSoLrU8p4kLS/n9ZktdS0Mi4gl1EsQgccLsNbb8Coughlte/
         56rvLQtZArT2UJDqh3Hp/JGBUixLnmOOObx8EylyWfidXB1hlsHXGHLU2oSo12RQCdkg
         bsBA==
X-Forwarded-Encrypted: i=1; AJvYcCVO/ng3y9zepHOYwybgMOm3kUBhdN7q4O+qTVDZsW96dS7PRjtLfgM6aqbOpPe/82T0AxyzX1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7L11N/GnAmzrXusSepWCTL8YJ1LwGpsAogVGqkkEpW9mz5xJ9
	J26uCc+JljEPFq9fAkLgFZ4kcFv4utYXWj6zfRuPXTEZOByy2mWd
X-Google-Smtp-Source: AGHT+IE5Jtkz+6OGkYPPuUxjI4EL4hyt9zkUmNmGkkSD/CNdvKoRvebh+gAT9hSVo7FVCPVyCVUS4g==
X-Received: by 2002:a17:906:d552:b0:a99:8475:c3c1 with SMTP id a640c23a62f3a-a998d117d01mr80164566b.2.1728476287405;
        Wed, 09 Oct 2024 05:18:07 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e664ed8sm653318866b.95.2024.10.09.05.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 05:18:06 -0700 (PDT)
Date: Wed, 9 Oct 2024 15:18:04 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/3] net: dsa: mv88e6xxx: return NULL when no
 PCS is present
Message-ID: <20241009121804.4rqz6ocqmn7pwkbh@skbuf>
References: <ZwVEjCFsrxYuaJGz@shell.armlinux.org.uk>
 <E1syBP9-006Unb-Q3@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1syBP9-006Unb-Q3@rmk-PC.armlinux.org.uk>

On Tue, Oct 08, 2024 at 03:41:39PM +0100, Russell King (Oracle) wrote:
> Rather than returning an EOPNOTSUPP error pointer when the switch
> has no support for PCS, return NULL to indicate that no PCS is
> required.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

