Return-Path: <netdev+bounces-233318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6A0C11DC4
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 23:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97CED188763E
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 22:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D8E32D0E6;
	Mon, 27 Oct 2025 22:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEjkpzYh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3325032D0E2
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 22:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604772; cv=none; b=FDSP58GsxYNeDs8m3cXRtMqnufSFOLTlLpv42y4PWjB8tCxM0cWqNMXI8w2iCQpheUk+9DjPI0ifuE4J5qYVPghenD4aOUMOyaa07vknaZPEzpJucfkActnKrMsajar7AZJaa+xKk4kPQTA3gUlDVecZYpNQeRJuXDsz7QTQ6aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604772; c=relaxed/simple;
	bh=juewRQi/lhSosLtQ759S+HHeS+N8yoLqb0zkYyjR288=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTOBmnouB8xuhTkYAPU3Zo9+rjENevmbli+x0RbewIZUAfHEM/VnS3ZyfF5x3rgODMT0nyqOr2VbuvzqU5xKSwHfzkEkdbO6vp2bTtqbAV/Xt7DUkG+LLOYXvi3OEhr7/aTLDnm6tQ/4RghfNVWAt+wbggWMIpF5J9AsLQiOPVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEjkpzYh; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42992e68ea3so230955f8f.1
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 15:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761604768; x=1762209568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YvpDbsrlJIOTaMRaOid9yTZf9U4Ng8ymNsEuTR6O/hY=;
        b=EEjkpzYhx8G+Z0RYuPSs3ZCuQ1t6DAOViXTimpjx5NVwPKwEUr9+TD19UTjoD+UIXF
         XQFOh93qZHUbSeBiG7F8BYe8kOX1zbezUzqYUEsKL/Iyx9wsRU0atq6U2NLUoXOm+6rD
         Wq5cnL784duZlVdXnkReRkJ4e0orZK5QXYcBISX8Yd0lYSeRv0bjx7nTRHCMMB3o5EIZ
         FFiZgSYgK9rXaRMtzo4V7nqtNusgZWz3EJ5ZaHu5r9drDPRmC49xDxZmpAigKCtl/TEV
         5xyOpwcU/VZ6i3aXoR1r/7gW3F3rnw20s0bMVLdFjdnF/GVWjL+cX2SrQ1BZ5uU8RKaf
         7YDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761604768; x=1762209568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvpDbsrlJIOTaMRaOid9yTZf9U4Ng8ymNsEuTR6O/hY=;
        b=qLKxJBSPVW52DSopFiHPVEObGBN3sk2IYLb5EgJ6keWcgwcBtWFnjwmxObYxgSfOvK
         B7pUfEWZ3Qzyb5hW8zSAYasQ+j8Q/x4OVKk3KjyVtGe8Wyi7VXQJTtmopWvsnCAUUENS
         bu5DCBCkP1oDXPhlvks25xr/VZe778eiIhpNsRnwkoYEQYdN1G3buCpcs11r4bQvbAFR
         51YnGUeb82IY+wI+/sxEhWWb6/FcShsFjNieJJLgq1umJR7R2BwLoMuAm/W2/xF4/p3S
         pP81II5c1IW9sNfhv/k+GxpudQmdN9IvIfcK8oDqy6e+QtnDNXF3j0wZIVX4E23bQ5rM
         +LNg==
X-Forwarded-Encrypted: i=1; AJvYcCUOMPsgQm7FMK/1B1bMWeTFufIPiAz4qWh0V1cOrVCI3TLTs4BAR/Vx5uS+oFK/3QzyM14TXb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YywZBoEwzjQvdrfPHjosZQwIbTzUK7xpOLV+dqPkmRjV76T4AWZ
	l6PQgjkxzph6qt82UPLopXE7PuiZsNcMowQ8n1op51TR2LiHnXmwn7tu
X-Gm-Gg: ASbGncu3yQaoPyhFB9Fbg2yzi+M+2SO55868Sk8nGKVtuRKHabYrcZgGzqom+U5Hduk
	0ojtgguP3d8j9/DoYIZ0iqAQSOY6el7CJ40ZmE55U42zFbJdYnqtOUornI9JSKkxVakboQn3foS
	2mP4CrJfXWRo2soXjzAMK1XVHPRQJDGcEcxTx4WAiTSxAa44/iLGefmHbqy5KoUCneBBCl+aKpt
	KfVXmkVg28RjoeV0lyecWO+aWnf7d6nERytHzvPrYTF7zAZt673BCW17/4/hO1rbshG2nuQ3saQ
	wl3bvKeZwlkhfGQQH4gSGIhlQH6/izsGaUAW4kxF/znObK3B0DhUwSbUZY+V0HYLFw97EYClVNT
	CpeQAX91pT5rq8BNMmpgwhL9IVl87A9+V5TYx0b9BxK1fsmmtMK5y9XDDx6mbFLcziNeX
X-Google-Smtp-Source: AGHT+IG7ZwAR08agDx1ivDH/sVshrwRmm2QAMO06s/6waDyxXo1zMnSEnxrvbvB/FBUt4P7KDlQEnQ==
X-Received: by 2002:a05:600c:4511:b0:475:d7fe:87a5 with SMTP id 5b1f17b1804b1-47717e6d26amr5828055e9.6.1761604768464;
        Mon, 27 Oct 2025 15:39:28 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d406:ee00:3eb9:f316:6516:8b90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd489e6dsm157269015e9.6.2025.10.27.15.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 15:39:26 -0700 (PDT)
Date: Tue, 28 Oct 2025 00:39:23 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v3 04/12] net: dsa: lantiq_gswip: set link
 parameters also for CPU port
Message-ID: <20251027223923.trrwei3gkl7yozqe@skbuf>
References: <cover.1761521845.git.daniel@makrotopia.org>
 <cover.1761521845.git.daniel@makrotopia.org>
 <833c9a9a0cc8fca70e764f13035da4d1444a0805.1761521845.git.daniel@makrotopia.org>
 <833c9a9a0cc8fca70e764f13035da4d1444a0805.1761521845.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <833c9a9a0cc8fca70e764f13035da4d1444a0805.1761521845.git.daniel@makrotopia.org>
 <833c9a9a0cc8fca70e764f13035da4d1444a0805.1761521845.git.daniel@makrotopia.org>

On Sun, Oct 26, 2025 at 11:44:24PM +0000, Daniel Golle wrote:
> On standalone switch ICs the link parameters of the CPU port need to
> be setup just like user ports. The destinction in the driver to not
> carry out link parameter setup for the CPU port does make sense for
> in-SoC switches on which the CPU port is internally connected to the
> SoC's Ethernet MAC.
> Set link parameters also for the CPU port unless it is an internal
> interface.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/dsa/lantiq/lantiq_gswip_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> index 092187603dea..0ac87eb23bb5 100644
> --- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> +++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> @@ -1459,7 +1459,7 @@ static void gswip_phylink_mac_link_up(struct phylink_config *config,
>  	struct gswip_priv *priv = dp->ds->priv;
>  	int port = dp->index;
>  
> -	if (!dsa_port_is_cpu(dp)) {
> +	if (!dsa_port_is_cpu(dp) || interface != PHY_INTERFACE_MODE_INTERNAL) {
>  		gswip_port_set_link(priv, port, true);
>  		gswip_port_set_speed(priv, port, speed, interface);
>  		gswip_port_set_duplex(priv, port, duplex);
> -- 
> 2.51.1

PHY_INTERFACE_MODE_INTERNAL has two meanings: an internal MAC-to-MAC
connection or an internal PHY. In principle, your check excludes the
link parameter setup for CPU ports with internal PHYs. I had to check
that these don't exist, by looking at allowed_cpu_ports and seeing that
only the MII ports can be CPU ports. So this is OK, although being a bit
more explicit in the commit message would help, if you need to resend.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

