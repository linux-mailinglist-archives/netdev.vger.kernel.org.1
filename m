Return-Path: <netdev+bounces-197209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA26AD7C6B
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495933A379B
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 20:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5E22D876C;
	Thu, 12 Jun 2025 20:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="GXmIa6Sj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F9C27C179
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 20:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749760402; cv=none; b=ppNlHZ37v9LwqgCJLfNudxtdt/FDZvOsyFUdogYsT0uZNn4pX8MFFMyopz7LY23ssYa6GgN5htEz1XnmrBAVjSc5JgVFLgGbCQoN4ysxss1e/sWDPNuALk8sLkbQkLZ56J5Fst+yZxj3aAr2QB3smh1M+CAAZlCBsfF4u/Y5e2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749760402; c=relaxed/simple;
	bh=EwOrQTkZkutxu162q/l63LznHvOwnjtJHI7xWRukVcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEaheL7OEi7N1gADNPukxmRS8hijo7Wbnlu45T9yQvvUc9U1Oe3GDhoa3vzuTWgyQF6nYyjIxAQgfAwmQgeo2ZY4C50Lrjzx1B2aEGigEe0H2bXd0nvuooGOrRfbHqYzHwZ+J9Te+4uk3TSPH3uIQj1GFs0hXjfP5EkDinCKsAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=GXmIa6Sj; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4f78ebec8so1032567f8f.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 13:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1749760398; x=1750365198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8opH5cOcXkpOAfmUTo78hPrgHI3ldSmhpGD4e6tYOg=;
        b=GXmIa6SjwyDkDTOeHf/Eyl6x+Xl3e8HpfpsqIvwwSf4dxlz9NRNbzsav3MWSLypcH8
         YBc5YIEbUY7OXzwCMIn6qtSATh+bCXyNFa8uIXWb7BD4UgOqmj5bxsz78Ga4TJ+AYMPE
         DynolVR3bpgpMTewOd1tBqTVlY8KndK9oit7I3c1F2y7e2QudL8KveW+LLnO1zgPaQHR
         m4d9pRH3a0lU9nFGkueVy16wpEAgLpveY7MK2hJPvB9jTu9Q/haQrXCqrUU4WG6VXLla
         fLbE/ECeI08d7eFaqm++liv0pmdbodwRV1EUMQzhgLG2ovfsNoaYGmgFlMZ9r/y3XKzh
         o+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749760398; x=1750365198;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V8opH5cOcXkpOAfmUTo78hPrgHI3ldSmhpGD4e6tYOg=;
        b=ae+5KfG98KsPwwnfTgwD4nsyaY6d3m2hd808l1q9UQPsNZ/MRC05BrLjMMftRcYeIU
         K52SrKLIaMVJr5PrniE1eVbOgLu9Yq+1ZybMxheJrp5ZSe7pfKtSh4y9dHcjE19CLPtL
         i8ZE8cslRhN5iGEUnMG44qSwlXbFB2LfWK+a7HXlhXjP9nDRfVGb6v6bFFb1hQNovhfx
         Mc2GmvgqcKVLOdVwoKqUcwHlH7BF2oTMT8hzQyU4PhwAqarJtQK/VrCDNimlVufl07Sq
         hZ8sXFbrkmLqEnz8tKl+ou/+9l6uuMX5UUwyfPXIp4MrqDL9UXqpeHQFMyWtEsBboWqf
         MEAw==
X-Gm-Message-State: AOJu0YyGyD55G2Z44m+tFDJ12+tSGrOvjeMPl8endlQlGZel8qvNmhiM
	ZDQvKy+nuE+4QXuKjlZe/3F2xj6fkai5M9O0r/O4TyB4Sc1QbtAx0jC3xCfBauRx0yE=
X-Gm-Gg: ASbGncuyz4VmHbA+wv4Y/Yc92EZUqANkCU0/fRUXlZdvyLsu7QuGtk9ZbCtkcLEejuc
	9ddjelCuByffmyK4Hzfrztm39juRtHCBQWK4nNEHjWS+i2CZvWbh7qKd0mHF6GTdlsDKQ0d5MAd
	rzM/uFb+M5tspARlda+zV97RkNZjfORxIsDY9ZDYnSYYlcbARKCJhpEQvnQVJOMpspjXxs4Hzf1
	qQoZR01cY+8jroaDqr/kgdPxqjuxMV860O+CzrhArp88KJVbdnu5l7tDN6MH6vvbez1n6LB0xgW
	v2//XUHEToOEF/Ac2FQFBnu+DPoVRre7cf/dtq6bGojZSUVxM33y6xK9b7NdyHTxOFI=
X-Google-Smtp-Source: AGHT+IGsBa+y+ILrsog9vLowcZ17BT4rMJvtC6HfDifefC4iKPz18rUtm3egumGH94wSHRTUbX+W5w==
X-Received: by 2002:a05:6000:144e:b0:3a4:f6b7:8b07 with SMTP id ffacd0b85a97d-3a568717984mr544578f8f.48.1749760398129;
        Thu, 12 Jun 2025 13:33:18 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a7cb65sm329695f8f.38.2025.06.12.13.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 13:33:17 -0700 (PDT)
Date: Thu, 12 Jun 2025 23:33:14 +0300
From: Joe Damato <joe@dama.to>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Justin Chen <justin.chen@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:BROADCOM ASP 2.0 ETHERNET DRIVER" <bcm-kernel-feedback-list@broadcom.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/2] net: bcmasp: enable GRO software
 interrupt coalescing by default
Message-ID: <aEs5isPs68JAyjZq@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org, Justin Chen <justin.chen@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:BROADCOM ASP 2.0 ETHERNET DRIVER" <bcm-kernel-feedback-list@broadcom.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20250611212730.252342-1-florian.fainelli@broadcom.com>
 <20250611212730.252342-3-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611212730.252342-3-florian.fainelli@broadcom.com>

On Wed, Jun 11, 2025 at 02:27:30PM -0700, Florian Fainelli wrote:
> Utilize netdev_sw_irq_coalesce_default_on() to provide conservative
> default settings for GRO software interrupt coalescing.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Reviewed-by: Justin Chen <justin.chen@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> index 7dc28166d337..a6ea477bce3c 100644
> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> @@ -1279,6 +1279,8 @@ struct bcmasp_intf *bcmasp_interface_create(struct bcmasp_priv *priv,
>  	ndev->hw_features |= ndev->features;
>  	ndev->needed_headroom += sizeof(struct bcmasp_pkt_offload);
>  
> +	netdev_sw_irq_coalesce_default_on(ndev);
> +
>  	return intf;

Just to make it explicit to other readers: netdev_sw_irq_coalesce_default_on
appears to be called before register_netdev, as the documentation for
netdev_sw_irq_coalesce_default_on describes.

Reviewed-by: Joe Damato <joe@dama.to>

