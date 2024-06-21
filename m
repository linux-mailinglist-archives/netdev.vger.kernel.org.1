Return-Path: <netdev+bounces-105739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E533B9128AD
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 16:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4591C204BF
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 14:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB1E38F91;
	Fri, 21 Jun 2024 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeqD4ejw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7B03AC0C;
	Fri, 21 Jun 2024 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981967; cv=none; b=Aup65P47y97wJnCduA4EBUpU+FBA9fCPQAGAx3hwlv9LYTFmTQWWf3Bn4gAPiP9INCsfyw0AvT6oOyTSx7oSLBwNLKT4txfwamPq/6adRPY+p40B6DWHCFyFAOb2ecBN1/eJ1Q/v2TYJJkUpEXCElqltaOaox38ZY1Dlwp74mIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981967; c=relaxed/simple;
	bh=VpDEK87b38fPZ3PZqbgyHl+35gCyPtgppEsBJx3OwgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbLKLH5ybHAArOIHMq42neds47yciw/zW0GOm9/pLlB6kS0cdJqQ59vZ5XdAJ1ykUWIaaBzGkeCy2DBAtaGGWhVnT6QRivX3byXvHNOvEl9DHKQYrQ4jlKZ0dgx2SFlablyzVajMmQ4rwEoczS3chK3LLJiQz4wXlfLeq5jLOKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeqD4ejw; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ec50d4e46aso5509091fa.1;
        Fri, 21 Jun 2024 07:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718981964; x=1719586764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=foOONDBeqod03rMUAw0v5FgWc8biDDiaV6EHyL5skuI=;
        b=EeqD4ejwZI9/uvhswUnoENeR1A27zjcIWhJim5uwDT7aSU/hTXe/QWhUFFmqJhsyLW
         +p6ojUonPlHj4WwRlkMgkCqI5Y/+HsexEND3rRowNKwGhypx82rGa8e4Bf8AXTrcUfHc
         a6lUAtzH4KoSmC1K2rwaOxktnPFKRmSOGPctVDiHMLsoke0syHlar31xO3ism64OK3WF
         x/CJQk+/VsR3JQcto4YqVMEqqDjbFuZ2E/vw2CfAHwL+xSWXLutEMvqjKvwOYbjANlUI
         h3KliE/hTxpSl1mO78I6He4B1d/G55Mmm51AkKOLuar5d/IyVgUf6VI7UpBs/9xzg+DB
         ZjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718981964; x=1719586764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foOONDBeqod03rMUAw0v5FgWc8biDDiaV6EHyL5skuI=;
        b=q024yZM4Qiz11QTsuJOUadpNpGfm2B4+7RNYJnqIKyAfZr96gBtyeXaQiKzqLqatmW
         Es4V3791fTjPk8m6VRA9QUm7N7zEd+DQH3J9AjC03CETnN2ZNsos4mkwQqOX0NxI2E6k
         jzBNADveGxVkAgWtVHChmpvP7QHY2WhXGijGTBLYkugbbW7eyo0HoT6Ofjf0YknDt9St
         +XBJsXP7qKFTqYhMPWbor/zHFA5qZQ7WDxsucpgzZzLqFsE92aX1eOWTHQ+66W3nl6gB
         qe6RLdJr0USnGQqnt4eVVMro6LsAD74A+AMijMWwJJwOp9iLf9JWtY8Ta5j3+uyQmv8G
         q64g==
X-Forwarded-Encrypted: i=1; AJvYcCVBEf3Mtb2RsnjDdwldcG5G+L/xmQNIpyMd+tN1c99k9lgmVndGrSNHqv1I9WsC4g424DoOBS8Wec+odDPhNlazv/r2EMg3TuEXoVA5
X-Gm-Message-State: AOJu0YwA5bO1GFdhfwxSZ3gwiYxtV4FSMxNNEDtQ54h51ZThEpGGjAKx
	1YNF85r251mNHNWaSxSKA6bPh7hCScQzyIytvaw+abOaH6jI9u6T
X-Google-Smtp-Source: AGHT+IGgs59FV4mxK1VdTr2gscSJslhT9zBr+hgcaXPTWUtxhgfNoycxTUdA14PvOiPrsIPlYa4nMg==
X-Received: by 2002:a2e:3504:0:b0:2ec:4e59:a3de with SMTP id 38308e7fff4ca-2ec4e59a4a5mr13785371fa.10.1718981963498;
        Fri, 21 Jun 2024 07:59:23 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d305353f1sm1032853a12.76.2024.06.21.07.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 07:59:22 -0700 (PDT)
Date: Fri, 21 Jun 2024 17:59:20 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 02/12] net: dsa: vsc73xx: Add vlan filtering
Message-ID: <20240621145920.646wyxdwn6z443kv@skbuf>
References: <20240619205220.965844-1-paweldembicki@gmail.com>
 <20240619205220.965844-3-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619205220.965844-3-paweldembicki@gmail.com>

On Wed, Jun 19, 2024 at 10:52:08PM +0200, Pawel Dembicki wrote:
> +	vsc73xx_vlan = vsc73xx_bridge_vlan_find(vsc, vlan->vid);
> +
> +	if (!vsc73xx_vlan) {
> +		vsc73xx_vlan = kzalloc(sizeof(*vsc73xx_vlan), GFP_KERNEL);
> +		if (!vsc73xx_vlan)
> +			return -ENOMEM;
> +
> +		vsc73xx_vlan->vid = vlan->vid;
> +		vsc73xx_vlan->portmask = 0;
> +		vsc73xx_vlan->untagged = 0;
> +
> +		list_add_tail(&vsc73xx_vlan->list, &vsc->vlans);
> +	}
> +
> +	/* CPU port must be always tagged because port separation is based on
> +	 * tag_8021q.
> +	 */
> +	if (port == CPU_PORT)
> +		goto update_vlan_table;
> +
> +	vsc73xx_vlan->portmask |= BIT(port);

This does not look correctly handled.

The CPU port is not recorded in the portmask of the newly created VLAN,
because of the early goto.

So the VLAN structure will be freed from memory earlier than expected
when it is deleted from a user port. Then the reference to the
corresponding VLAN on the CPU port from the hardware VLAN table is lost.

