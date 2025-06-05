Return-Path: <netdev+bounces-195205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BFEACED7E
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 12:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D55170866
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 10:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFF520B7FC;
	Thu,  5 Jun 2025 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bvg+6+IB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532781A2C25
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749119103; cv=none; b=KtZTkJ83TCOwRC0wqIo4ZXLeWqKPOsRu2ky5vMymUfpLC85dR/MFr/e7hGd5wnW0AN2JpT4ZJB/omwa4p7myOAoodM0YslqP2CECmjslE0gZMzsGwO1fpGBh7bY/ATNIVnbUF8tnhUGn4yxHZKeuXf0jIOQlCMBlV+eMXdFhyiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749119103; c=relaxed/simple;
	bh=015oBGMB3YXrG897FkQBa+RLeqYZAPDXjdd6A32n7dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJsaHGEZzomAJ6TmuK9blk/Puw+8XigiYTpTsaqHwXzFiClVXiQQcHm3fnmbYoOm9B0CtiYSlKwEf0YJRJEm70ahhPtLOsB/WNMGalVJNOpv+8ryROCzII5Xx3erwC7iEUgkhVFbzCkMBjvb97Nv+0q0rh9NNneg0qsqTUX4Cqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bvg+6+IB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749119100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+/I6BadOUjI/02G0YPnq9xgrPHjXcmZakozl0E4TDSo=;
	b=Bvg+6+IB77bbCXKQ9QKMIe09Cxj2onu9iZOFiZZZ7ob5FmB8kBxSE0QiPwpxQ+dGyw92wR
	J3YHX8gqvOOsE3mINVAzPONp0vMp/J7v+bppMi/r++QLDeZSvjNEY4mes2p74bdBa5i54+
	V77VBvQoWuz1X07F9thNzDaxz1CXlu4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-sZa07UzOMum0iz-0gAbwtA-1; Thu, 05 Jun 2025 06:24:58 -0400
X-MC-Unique: sZa07UzOMum0iz-0gAbwtA-1
X-Mimecast-MFC-AGG-ID: sZa07UzOMum0iz-0gAbwtA_1749119097
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f8fd1856so384338f8f.2
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 03:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749119097; x=1749723897;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+/I6BadOUjI/02G0YPnq9xgrPHjXcmZakozl0E4TDSo=;
        b=S4LuQRTjgmfin+xV9DGaZGswTceM18QGpjSn96/86bNNruFMmprYOBeDi1lUNt24eb
         hW/rkOVP/uQsOUBVomacOWNBvIGMQlhPme+PqtzlyG/19Gi61jP36k2bQlzCYE6iLWtz
         3pSTsibYU0RySOB1+JDlYeXxJ7hFkblo1rdDDA0+bQx/iBTPH1TI7+wa32rFkGDwWYol
         g8f9JHR+NRl1PaDnqPo4Scch4Yj3JHbwJrrOOlE97TGAskTLpuCQ1lTBzGNCBWVTRPjp
         fpdSZLcgl6Pp0/6vGFo4QfTylChb/62PBHxtMAUNp58CRLpnBpuUCEL4KmPIU3pPg6uo
         EsiQ==
X-Gm-Message-State: AOJu0YwgyLkYdH1fA8kFNtgn68CfhSHkuKwuhZ87ste3KpcEfSPQ1Gzv
	N+WTRJfu29BELXmHZ9yvV5Rwh3u67UO6+eLuwhyYMisbBxcUTSQ9FJ+kuLyAQaUp+BPR/vHXsTx
	mVub9xgPILGv0VWexOguObxUaYVM6I54ZYmkD1Id6Om2tLYHPRdmWAfQv1A==
X-Gm-Gg: ASbGnctg/rrJ+HwTJT2girqktJUKl9u935DmTp/G/IWB/fwukAMk9CyqigfvFQAXAp9
	BWB19Dgra8PVeSU2I1UlOp7K7ZOZb+33c0lhgA3WnBtaZEY8Oh4bnN1nKU79f05gPRDnlxNVy4Y
	rorzccFdiHWlQNOXuiLUWYer2XNkUK4cYPrQZZmVhXcdx0KXk5ea+zBH+8tm63crO2ko+gkqtvA
	erC4xR+7D/LDhOcFbUexW/kSE3wp2KULk2qIZWSEpIJgQwGz8MYp22dTkuNHhGjN3iWoFmPJ9V9
	w4c+rTwthdvqSORe7mE=
X-Received: by 2002:a05:6000:1a85:b0:3a4:d0ed:257b with SMTP id ffacd0b85a97d-3a51d923b56mr5438394f8f.22.1749119097320;
        Thu, 05 Jun 2025 03:24:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9rhdrXoBB2l0aQ9oW8se1WPPDQ7OCJdLmo7Mz8TqllVZz9mFe8kK46lg4hrRM9Z/HNjs9tg==
X-Received: by 2002:a05:6000:1a85:b0:3a4:d0ed:257b with SMTP id ffacd0b85a97d-3a51d923b56mr5438361f8f.22.1749119096926;
        Thu, 05 Jun 2025 03:24:56 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cced:ed10::f39? ([2a0d:3341:cced:ed10::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5253a7aeesm2687387f8f.1.2025.06.05.03.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 03:24:56 -0700 (PDT)
Message-ID: <ef3efb3c-3b5a-4176-a512-011e80c52a06@redhat.com>
Date: Thu, 5 Jun 2025 12:24:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: phy_caps: Don't skip better duplex macth on
 non-exact match
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Simon Horman <horms@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Jijie Shao <shaojijie@huawei.com>
References: <20250603083541.248315-1-maxime.chevallier@bootlin.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250603083541.248315-1-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/25 10:35 AM, Maxime Chevallier wrote:
> When performing a non-exact phy_caps lookup, we are looking for a
> supported mode that matches as closely as possible the passed speed/duplex.
> 
> Blamed patch broke that logic by returning a match too early in case
> the caller asks for half-duplex, as a full-duplex linkmode may match
> first, and returned as a non-exact match without even trying to mach on
> half-duplex modes.
> 
> Reported-by: Jijie Shao <shaojijie@huawei.com>
> Closes: https://lore.kernel.org/netdev/20250603102500.4ec743cf@fedora/T/#m22ed60ca635c67dc7d9cbb47e8995b2beb5c1576
> Fixes: fc81e257d19f ("net: phy: phy_caps: Allow looking-up link caps based on speed and duplex")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/net/phy/phy_caps.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
> index 703321689726..d80f6a37edf1 100644
> --- a/drivers/net/phy/phy_caps.c
> +++ b/drivers/net/phy/phy_caps.c
> @@ -195,7 +195,7 @@ const struct link_capabilities *
>  phy_caps_lookup(int speed, unsigned int duplex, const unsigned long *supported,
>  		bool exact)
>  {
	> -	const struct link_capabilities *lcap, *last = NULL;
> +	const struct link_capabilities *lcap, *match = NULL, *last = NULL;
>  
>  	for_each_link_caps_desc_speed(lcap) {
>  		if (linkmode_intersects(lcap->linkmodes, supported)) {
> @@ -204,16 +204,19 @@ phy_caps_lookup(int speed, unsigned int duplex, const unsigned long *supported,
>  			if (lcap->speed == speed && lcap->duplex == duplex) {
>  				return lcap;
>  			} else if (!exact) {
> -				if (lcap->speed <= speed)
> -					return lcap;
> +				if (!match && lcap->speed <= speed)
> +					match = lcap;
> +
> +				if (lcap->speed < speed)
> +					break;
>  			}
>  		}
>  	}
>  
> -	if (!exact)
> -		return last;
> +	if (!match && !exact)
> +		match = last;

If I read correctly, when user asks for half-duplex, this can still
return a non exact matching full duplex cap, even when there is non
exact matching half-duplex cap available.

I'm wondering if the latter would be preferable, or at least if the
current behaviour should be explicitly called out in the function
documentation.

/P


