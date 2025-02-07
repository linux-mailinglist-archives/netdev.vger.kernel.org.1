Return-Path: <netdev+bounces-164095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D377A2C94D
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 17:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA03162447
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4EA18DB2D;
	Fri,  7 Feb 2025 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gT4WN2Jg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BE81802DD;
	Fri,  7 Feb 2025 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738947149; cv=none; b=W3NVF7MTiVtSe5De21hZS3z5XF59MUGTJlmK3+j9CEhRtdGiiozXqlsFC4ZZcFui/zhidTHfDheIZy+TJLuh/vJdVWfENrsb26QZFpBHzk6+gJUwN85Mnv+YzQpWQc2M7LdzsRAVfaAMeGEXw8u5waRgy2mDH6XPAX+rfD08gYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738947149; c=relaxed/simple;
	bh=/tjjjBDO+DMbPB6McTkahkGDk7y241MsMLyJaV/vRGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8HqXIt0Nw02ePy5BBJy/BtoiaQ7MRTs/CXZ8naOAr1/QNu0GU4bhXUb/DzkqZRGaSKppqpw2PE+S2nxiad4X1PtgmEkLsw17zB76tUW/pIt/CXi60rXhDtTtFEbTUaTp9868ts3cercwQ/nlJ4LtAzTTVNq2X+XLIhmqBr7YOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gT4WN2Jg; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-436230de7a3so3144495e9.0;
        Fri, 07 Feb 2025 08:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738947146; x=1739551946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6fOfdH151WnKpN+REXxAu1LCpEvM2kXJ90YardoDssA=;
        b=gT4WN2Jg+a5oxdxMmcEhBiGxHSlfEVkw5pgoQzs84g/KxXN3PwYGCL8I0wyMUJukrr
         zlfEIBw4CKElzSiBIqAEGZsCjnTKBpLnLX+KvV2BgZGhMDuIiIhSpVZWuMJLzGqQisvz
         zb6FB+rcNVIkGPHOkf/UQOKBog5gu8PQL1k3lhGGgFHsGuhpOS2W8Zvcdq8cmP/22eJg
         JJCc6AlHCRuBOAZ85J8r4BpXD4rM8eQApeaKRPYmTP07DSGJyOdmLmWLWS0X+TFfQrGl
         C0OxO7mOc01/FpkBTwoJZwi0w7r793ZXvamqK2Cz3lin9qHMKOSpKFoDjuqTR0X8x1Uq
         B0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738947146; x=1739551946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fOfdH151WnKpN+REXxAu1LCpEvM2kXJ90YardoDssA=;
        b=m667LQPOZgRFL3wwO71tGk+vbe46B6nAYbbWQMc4BtZcM4H3greKnKzAu9+M7+KLpC
         3j39GJPXDSWTrszFrAB/57M2cCAMGEbM08vtNDvP20qgeLDKWaOshpZpmN/Ki+paRXPh
         iLDlwtdj4gUKzGEhNXxfapYNlqWm4nJR9mF2qJGweatxeKqbZqLgCdFTjzrGvWA3aJOm
         AfI/+BvRGTHzR7ikqJ0L2Bp3JW77Z8wDvPMPeBfNuArP7tsYVnDsSgl3IXw1CFAc0k2V
         UDBQcW+C1ow4egsjH9UyDt8hRqLlUz+1NGXyxhSsL7OPXpAnUui4w6J9YfnVNxIuYu7L
         ARBg==
X-Forwarded-Encrypted: i=1; AJvYcCVMhSum0LqVDrtSDdMxlpirdu0gwBMmHA79U/fwXN7z2zkZdgj1nNEqwAA8PUUs73lQCZFtCsqnBFM5V1w=@vger.kernel.org, AJvYcCXkWYIQnWDTU3f91jMwvHT9MOAJTeLHVODIYbMOaXz9Zj+/nkciu/vbq+i7fNsxaQGN5TBwf8qq@vger.kernel.org
X-Gm-Message-State: AOJu0YykxE7U+faSEhd+gt0GC2mNyN+J+Se6vsYioDABnS/kE35lvxGP
	B/WyKCg+XqYA4Zzo5ecMz6rtU3tKx0AIr+TvOwLvKGI869G6TzPCNw2kcg==
X-Gm-Gg: ASbGncsvEmseeD5Q6cYMQVXOGubaVmeZpDtYPjQbsOCGPyNst3twGDTe/XguptsgHpE
	DX4r/Et0jaiXbvcAUVll683K5OUoCmQ/q54t3YNWMZUDoyJLl5GNKDPCCCiI5gBfe2E37cmzkb8
	brjX9DMoxjq4BM+Lx3Jy/kzMA2S6hYc4z0Fx9CDb8Ybt2DYQirZSYxlRxtcIuz/gvnO9A6k9YUZ
	BGS+5KZ1WtC+EuBGvP8zuzYBMV682VjMkV/9Iak9N4oqAVhFS+/5L5ugS8zBbx8cYMsjdXitbM5
	CPA=
X-Google-Smtp-Source: AGHT+IHhzPJanFDdZPZtJjGh227FhFbvHX5eKAmBRk8eu0rotNDNw1Tz5jSVaoJOTo7y+c7BBJ4VEg==
X-Received: by 2002:a05:600c:4f87:b0:436:17f4:9b3d with SMTP id 5b1f17b1804b1-43924b3cea6mr13129695e9.4.1738947145796;
        Fri, 07 Feb 2025 08:52:25 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcb55b7a5sm2116730f8f.14.2025.02.07.08.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 08:52:25 -0800 (PST)
Date: Fri, 7 Feb 2025 18:52:22 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tristram.Ha@microchip.com
Cc: Russell King <linux@armlinux.org.uk>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 2/3] net: dsa: microchip: Add SGMII port
 support to KSZ9477 switch
Message-ID: <20250207165222.hrbylkoafpvtfsjy@skbuf>
References: <20250207024316.25334-1-Tristram.Ha@microchip.com>
 <20250207024316.25334-3-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207024316.25334-3-Tristram.Ha@microchip.com>

On Thu, Feb 06, 2025 at 06:43:15PM -0800, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The KSZ9477 DSA driver uses XPCS driver to operate its SGMII port.
> 
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> ---
> v2
>  - update Kconfig to pass compilation test
> 
>  drivers/net/dsa/microchip/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/dsa/microchip/Kconfig b/drivers/net/dsa/microchip/Kconfig
> index 12a86585a77f..c71d3fd5dfeb 100644
> --- a/drivers/net/dsa/microchip/Kconfig
> +++ b/drivers/net/dsa/microchip/Kconfig
> @@ -6,6 +6,7 @@ menuconfig NET_DSA_MICROCHIP_KSZ_COMMON
>  	select NET_DSA_TAG_NONE
>  	select NET_IEEE8021Q_HELPERS
>  	select DCB
> +	select PCS_XPCS
>  	help
>  	  This driver adds support for Microchip KSZ8, KSZ9 and
>  	  LAN937X series switch chips, being KSZ8863/8873,
> -- 
> 2.34.1
> 

I'm not sure if you split this change intentionally or by mistake, but
either way, you need to squash this patch into 3/3.

