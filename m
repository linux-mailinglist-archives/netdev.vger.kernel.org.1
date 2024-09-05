Return-Path: <netdev+bounces-125595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A9596DCF5
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 17:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33371F22ABD
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 15:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9921A08C5;
	Thu,  5 Sep 2024 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyumjQiv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAD22F870;
	Thu,  5 Sep 2024 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548288; cv=none; b=m5OrBDIg332yGTWUtchilV7utl4laIdK/crPpspwSSG0ns1wkuu6Rdwo0tI4veY3bubDcsVOKzBKGwZgqAWT+d9UHjmYTA3shNPEu5IJ6eQvNpeVjIg1JWVJuZRX8tmZyeNnjFpFfcAruY3hSSmWOM3Xr8RVZcgNaQAAhHqsl84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548288; c=relaxed/simple;
	bh=rdT4Nyna1y3UBgynAi/IlvVt+86j0FskLnanS5y+vd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFJkIjoXfUaHkS+B2EP3weBvY/5AzuIX+qgUVGz5iWcG5F6mMDBXWsVR3aUgENXO69B7Lgt1SHGJ3++Jgwaa89Ohdhk3tHLakUoe+3rQIG4tzJXI66W5WaSu1WhXixSr11uNwLVyNtnD/9N71gOEkKLKNh2vxMzK7SdvYnFhvk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyumjQiv; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8629ddffbaso6728366b.1;
        Thu, 05 Sep 2024 07:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725548285; x=1726153085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xylf9X58PdeAvnejc6uMarphR5HQ4AIAHZcsnVNJFQk=;
        b=DyumjQivsQKQrj7ZwIySzzI3td6K3ZyFTi8c0IKAtfjAPK8eN7pAHmRTAeVYqP565n
         rHqj3NCBOtFCYart5qJu4VAcCClHlZrATMXkvAcXVAxJKUGzURJwJspVjf0LKLv2Q2ME
         lUq/KJES/vCVAnLYCMF5LxMfzTr9Jg07Soer4oyLZp9geRayi9axQjs2/nPLhOh7Msdd
         ILJDymADzXpke7/QSDJ5pkZYkyEHakG6i5Cr/OOqi57IWN18WeqLKT1x+6pFeUXi5YeB
         y52OLl35vcs4lqrbz5sM9nIAFhil+YvV0rCOXLRwQWOJMljW1OODtDSG2D1DdQ0HRI4Z
         K5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725548285; x=1726153085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xylf9X58PdeAvnejc6uMarphR5HQ4AIAHZcsnVNJFQk=;
        b=ocgfWPSGeBzI356RxGvDwLFp3OepDNSZL3+qHC1Bo6OmYIhjOV3tGf57aZxC+bXbqd
         urnzMeqF7adneu02W/t4/P8Sh3pQyDlqPVh+2QyH+Ta0YaHtZuMKA1r8q61t8hPG0OKM
         4JxibhfbCGDj60FYs7GbUUK/oOJq0sXZ/hgBfFLxMttxxks58w/CbYs1GO5RRoNlrDez
         cr+DZEbE5wInXLXUpWtXcFUMglXYJq2hyS3Q5LHej3vpBMg/D/Ku+EdXzH5kDjgZrBVF
         Lc/CJM2ieSKbHM8RcN+6cCeQ5EbRTYLNJuc13fXoV06E1r8/emrUGcrIu6C7bC32AKe0
         5SzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPgXspgcEAp1GpCY/tdVQ63V/a2KpHCP1h5pt/drsZMyspQAB2sNMY8EPSFZp8x5+JfSEN8pQw@vger.kernel.org, AJvYcCXjKUR6M/fXIiklm9MzYp8NkyAA6IaUDoaalwh/7jJYnqm31sYXDcsereccIjbwqgB2PD9TWAD+gXHfxCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YygOncWrnPoDWClhXqrwqZDTBMaafM0Y5SZ0CA0M5dYShzoXcmb
	WhrWxmxv10RoAvAjXC7qFI1dvFImtpRnaUwoPPHdLxkRcbhwbUed
X-Google-Smtp-Source: AGHT+IFWgUHQjpPyF03ycuCrazcYNTIjo4bK7NC3jvKTTABsJhGvL/b4OqvEVAPSV5x1wPS7VF4ZTg==
X-Received: by 2002:a17:907:c21:b0:a7a:9d1e:3b28 with SMTP id a640c23a62f3a-a89a377d761mr914720066b.5.1725548285025;
        Thu, 05 Sep 2024 07:58:05 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623a464csm145762466b.150.2024.09.05.07.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 07:58:04 -0700 (PDT)
Date: Thu, 5 Sep 2024 17:58:01 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rmk+kernel@armlinux.org.uk, linux@armlinux.org.uk, xfr@outlook.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v8 3/7] net: stmmac: refactor FPE verification
 process
Message-ID: <20240905145801.hyhjalu3bjfh5gs5@skbuf>
References: <cover.1725518135.git.0x1207@gmail.com>
 <0b72fd0463b662796fd3eaa996211f1a5d0a4341.1725518135.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b72fd0463b662796fd3eaa996211f1a5d0a4341.1725518135.git.0x1207@gmail.com>

On Thu, Sep 05, 2024 at 03:02:24PM +0800, Furong Xu wrote:
>  struct stmmac_fpe_cfg {
> -	bool enable;				/* FPE enable */
> -	bool hs_enable;				/* FPE handshake enable */
> -	enum stmmac_fpe_state lp_fpe_state;	/* Link Partner FPE state */
> -	enum stmmac_fpe_state lo_fpe_state;	/* Local station FPE state */
> +	/* Serialize access to MAC Merge state between ethtool requests
> +	 * and link state updates.
> +	 */
> +	spinlock_t lock;
> +
>  	u32 fpe_csr;				/* MAC_FPE_CTRL_STS reg cache */
> +	struct timer_list verify_timer;
> +	struct ethtool_mm_state state;

I don't know what to say about keeping a full-blown struct
ethtool_mm_state copy in struct stmmac_fpe_cfg.

You don't populate two of its members: tx_active and tx_min_frag_size,
and thus they would be invalid if anyone tried to access them. And two
more of its member variables are populated with driver-constant values:
max_verify_time and rx_min_frag_size.

This leaves only verify_time, verify_status, pmac_enabled, tx_enabled,
verify_enabled. Maybe it would be better to just open-code these
variables directly in struct stmmac_fpe_cfg.

