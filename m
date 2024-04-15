Return-Path: <netdev+bounces-87895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 923FC8A4E25
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78ABB1C20363
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 11:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BA862147;
	Mon, 15 Apr 2024 11:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNPr0a64"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BFC5A0E3
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 11:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713182082; cv=none; b=CQRQC1Sz1W/6y9TT7zUndlmQvYtv1MDbLR57WfIGQ7Q1bcMhnI50RVDSw1IgADHe2VNmlQU56h03ekwG5ShJ3ghZzkhaJUw6ykiczsr6cbEJf1dtM5M9/tsLTEl4ItWQaOQRJHUWWKl0NZROVa3SjHGIuvP6OU3pn7dEedc61/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713182082; c=relaxed/simple;
	bh=/Z02AgANFDohz8mDrVOYzvmjkxC00SQUD3x5OYbF/qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RP6dY9qrSIqW+4gpV0KOWH8X+nFTWD+Wi7jEIt0oH2RHqD+C1pHcnhDq5o9mvj7XjN9AmKln09uziOzolWHHHvECYhDi+6Rn1fiWp0c+v57bpZItSlQv6whGaxmZUl6eooMT2/r7uzZxvqe5oPvamirIblF4EcLfHErUCRJCjdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNPr0a64; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57020ad438fso1786055a12.0
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 04:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713182079; x=1713786879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H4NMafbmS9XRzkgS7ukH8dmsczZ2ZVwhRYwJTAIl3VM=;
        b=TNPr0a64xLEtxIOuFrzbh07Py5ld5mip0sJrm0T1WlWG6E3EW5B1iwwisIj90/J0O8
         F7HWAuRMI4cfZano2IPW8UjSIh4H4GmnxrDtyWO4kwpa5zSC2TQsHIcM0yzg1Gaqo1ih
         dWd0jflSGRbcX3/fHQq8F8Odi9KMbn2+FDYZqW02wTtmdKiu2UXCiSHv365bY8L/2FZw
         qD/WVXfX7UVPlrMjvc9l+9ZAhkI/mn5VcRUd9EIzhqxrSKSxUMgsP13MPfOWk8TLq8kd
         t4JKvZqjC+LJBFmPWeBO7T23icdpIzsvZYxLkupv4fSOeTCH5kFahhM9dz5BEC5P/1Ah
         ICew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713182079; x=1713786879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4NMafbmS9XRzkgS7ukH8dmsczZ2ZVwhRYwJTAIl3VM=;
        b=eS881X/rXZUW2S0Q5WzAMxG1E43izitlg3Q8JynnUymIo2IF1KOX1JETqZ72BKnbsJ
         XDit02xxYf4+5jNgeWNzL+Yz1M5yF7G/huapQpxXrotbpDJBWOIcjLToAiPY8wULavPM
         WF6effnmXI729Y3OHPi/pizqTK70CUJS50yAFYmnI3pbbBmZAJbrMAImYyaPXYvJsyKN
         8d9O62VZ2p/YwGC7dpM6n7k7JLqQjTmafODXV9IvrHmTX+uF2XK0MVjZTClKiewMSRmc
         hv2oU9RJxkuhmClaUl1UGsT/Rzpt4rCLZhaotASPML0Dcg4Nlv3sIJ8/MMu/T0qAVzUO
         GJdA==
X-Forwarded-Encrypted: i=1; AJvYcCUrWzOOp10k9jrKZHQh+Hk+GVyFUEc3dpmukQC0DVlPC5PvDiOz8K84qJuJ4uraI5oaLWArjHQ7727l9MHW+EXrgSlTR3VN
X-Gm-Message-State: AOJu0YzP5kXbSLWjroh6yunAXQ74TY6gsnV/AdRMQm4ihHG+OBmGu0Dz
	sRoNDMtiSRYZHGGdzmIa4vwvrLJgUGSkyaUI7kzzDTWJfjmvFhMC
X-Google-Smtp-Source: AGHT+IGB+wtDmvHWo9tBgVxM56KsoV795bHQGbTYLqZc+sTd8lWpr4H+Pd4EKXjp1ySpcw6a/Zihsg==
X-Received: by 2002:a05:6402:360e:b0:570:3490:c9d0 with SMTP id el14-20020a056402360e00b005703490c9d0mr603075edb.12.1713182078517;
        Mon, 15 Apr 2024 04:54:38 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d108:9b00:f547:f722:ecdd:8689])
        by smtp.gmail.com with ESMTPSA id c11-20020a056402100b00b005700024ca57sm3593404edu.4.2024.04.15.04.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 04:54:38 -0700 (PDT)
Date: Mon, 15 Apr 2024 14:54:35 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: qca8k: provide own phylink MAC
 operations
Message-ID: <20240415115435.prmwrsuamlhk5tze@skbuf>
References: <E1rvIce-006bQi-58@rmk-PC.armlinux.org.uk>
 <E1rvIce-006bQi-58@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rvIce-006bQi-58@rmk-PC.armlinux.org.uk>
 <E1rvIce-006bQi-58@rmk-PC.armlinux.org.uk>

On Fri, Apr 12, 2024 at 04:15:24PM +0100, Russell King (Oracle) wrote:
> Convert qca8k to provide its own phylink MAC operations, thus
> avoiding the shim layer in DSA's port.c.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  static void
> -qca8k_phylink_mac_link_up(struct dsa_switch *ds, int port, unsigned int mode,
> -			  phy_interface_t interface, struct phy_device *phydev,
> -			  int speed, int duplex, bool tx_pause, bool rx_pause)
> +qca8k_phylink_mac_link_up(struct phylink_config *config,
> +			  struct phy_device *phydev, unsigned int mode,
> +			  phy_interface_t interface, int speed, int duplex,
> +			  bool tx_pause, bool rx_pause)
>  {
> -	struct qca8k_priv *priv = ds->priv;
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct qca8k_priv *priv = dp->ds->priv;
> +	int port = dp->index;
>  	u32 reg;
>  
>  	if (phylink_autoneg_inband(mode)) {
> @@ -1463,10 +1474,10 @@ qca8k_phylink_mac_link_up(struct dsa_switch *ds, int port, unsigned int mode,
>  		if (duplex == DUPLEX_FULL)
>  			reg |= QCA8K_PORT_STATUS_DUPLEX;
>  
> -		if (rx_pause || dsa_is_cpu_port(ds, port))
> +		if (rx_pause || dsa_port_is_cpu(dp))
>  			reg |= QCA8K_PORT_STATUS_RXFLOW;
>  
> -		if (tx_pause || dsa_is_cpu_port(ds, port))
> +		if (tx_pause || dsa_port_is_cpu(dp))
>  			reg |= QCA8K_PORT_STATUS_TXFLOW;

Thanks for changing these from dsa_is_*_port() to dsa_port_is_*(), the
latter operation is cheaper.

>  	}
>  
> @@ -1991,6 +2002,13 @@ qca8k_setup(struct dsa_switch *ds)
>  	return 0;
>  }

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

