Return-Path: <netdev+bounces-265801-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IA01NC1fr2nsWQIAu9opvQ
	(envelope-from <netdev+bounces-265801-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:00:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7516B242CB4
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7883301C6F4
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AD61CD2C;
	Tue, 10 Mar 2026 00:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhEZVGju"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8494C97
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773100840; cv=none; b=aUPW9Iw/LXyKjEpwYFUQhHHsOVvpOXE8OFzaZtiBRFclZVRbhy62o0Npj3RlUa6u6x/ZrdrHrrj9HACAig2c5UI5bn7BzZoEVDXEIA2CQFCs4/Bnqhj5PaLVQaD3+6z7xieItRr2k/CK7knC8fRKR4SR0EYhjznDONIxWpYZJvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773100840; c=relaxed/simple;
	bh=zqGCUHDNKaaInbNIceds5soxbCDX+Zv/hdXElnUWUEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOudBamW4E6iercoq40Zujw3ku8MImiQdWR0WJakkp3SGuM9PRkOMnFAZ4ziC7MvR3yb3zUgUFzLm7XVrj+HMGmi4tApQ623fuopy1nAcvTeIrOGlUZfnKX3ba+BCtwei+Rpm/ZUpBu7+t15Zr34hc1mxGWfYtRMeG99VxGueqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhEZVGju; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48533a598fcso271185e9.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 17:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773100837; x=1773705637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qfyFhbiwKWBc/U44rcjHHugcqpfm6yBMuIx9Ifg+nvo=;
        b=RhEZVGju02C1/ZKkd/jRRxSPHEmTIu1gR6tAFdnFa5qpbYQ6jP5zs8hlpvxpAHxTPr
         ce8FDF8d9Nx2eUUHQVtJCl319d4WqwvTLwQTjR2XVRkgCnn5/RyEYuLzEWHtwSD6cFsD
         yZohXQJirc4dsjHJt9gfbhy+ZUCOANwbea+3DyVFMUKuN977iTXwWwZvcc06jEc7FLlS
         yupGm0C/JtMhFCG9VWqPvhifON+Q6syh27U2Ba1VP8sKRVQDGirHTR10j5RhL9EPmVyL
         YrhPgtK97m4Zu/p4CclKOtF5elUEj4VGhdsWY5a8M4RZIsD8+QdNssHTX4e44eomIgZM
         GapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773100837; x=1773705637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfyFhbiwKWBc/U44rcjHHugcqpfm6yBMuIx9Ifg+nvo=;
        b=SLHq+rVg/atan0QDMDK69HBJyZqR/SshzIanzuixVGI2AH/I5Rsf/S0kHajxeF8O50
         om37jJWjRTbZyhzKMr7Ti14KSClV61K6jfalNi6329Obeo6OH/EQW17fr3WQUo34A9uD
         FASEUsa1Zca10qpckMxsU+U0z365Zik2w0JI4j5vn3IaV84bJEGBXfzMx6NPiAbtEQA+
         SpAT2tQZ3fudGK4ZVqodUloDjG3BDZw6mhcM/5E7u+uyj7ugPwlLhLM1MD1D3Qdu/iaZ
         AyZZijkiEw/oDHTxV6N/kgMkTa4W/yDEpr28z+SXf1sWGthf5LMnDd2kllZzQmpENFA1
         Hqww==
X-Forwarded-Encrypted: i=1; AJvYcCX44E4Z3QWRS7KxKPeeoJfbyN1Cek3uWw/3ciXS66E/t6hW8aPxOkJnFO2KiS+xBIkJyS4Tzx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSh2rPJdFQ2lhLc1OfAA627lFYFCq5NYC/OZf6lUAaCc/vfZMB
	Drtk3cqno1ZjgXegRXChjJ23s6NUe/lrzhM8nW4ediSJTPy4YEPfCD1u
X-Gm-Gg: ATEYQzz0Nu5L2bDxcRJAOhA3iIAg9+ukHvZjLt/5CqM49njcTzmp7CegJhxxDtubEmt
	MiiD4WvvMI38Q/fZNdAi4FdUTJ+v/4FXJdUKT012nQOSwMEO620pNMI667Ci0CGJjy8bZ2w4qzo
	pRO7TqRej6CcZvbDkU3gtYLS0QntqQ9l1D9y7LCMR7V66K5aAhEEfooVjpct0E6f1ewEKDzBiLL
	nxW2CRANQzlRmKwbzID0+Lz7vmP+uMq93KD7nAGY686lLi9T1txqK1msvQvPtcKAwHbHnFTM+Oo
	diuHpZ2Qcwf5kOX4TiOiv6FOsevOZBOaVtF6JYWSr0mAnSE4UkkPlkg2N9usl9B67nOOMDOzxcO
	xTxBLJk9fTV/eWbSUN9H0UqGXqMufHK32Wtz8bddKjW08hqdiguCMG38kjCidNax7jQrhRAqk3C
	anlPvDTFP59Um9ZA==
X-Received: by 2002:a05:600c:3588:b0:485:385f:674f with SMTP id 5b1f17b1804b1-485385f693dmr70680995e9.6.1773100837086;
        Mon, 09 Mar 2026 17:00:37 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d00a:e00:8799:3a7d:3c86:3200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485244b6e9esm177773195e9.5.2026.03.09.17.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:00:36 -0700 (PDT)
Date: Tue, 10 Mar 2026 02:00:33 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: skip user_mii_bus fallback if phy-handle
 is set
Message-ID: <20260310000033.oj64hv7dhe4vaawk@skbuf>
References: <b25e764be31bcbb130d057c0f6bf25261ce605c0.1772766796.git.daniel@makrotopia.org>
 <b25e764be31bcbb130d057c0f6bf25261ce605c0.1772766796.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b25e764be31bcbb130d057c0f6bf25261ce605c0.1772766796.git.daniel@makrotopia.org>
 <b25e764be31bcbb130d057c0f6bf25261ce605c0.1772766796.git.daniel@makrotopia.org>
X-Rspamd-Queue-Id: 7516B242CB4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265801-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 03:16:32AM +0000, Daniel Golle wrote:
> When phylink_of_phy_connect() returns -ENODEV, dsa_user_phy_setup()
> falls back to connecting the port to the PHY at dp->index on the
> switch's internal MDIO bus. This fallback was introduced to handle
> switches where no explicit phy-handle is given in DT. However, if a
> phy-handle property is present but the referenced PHY device is not
> yet available at registration time, phylink_of_phy_connect() also
> returns -ENODEV, causing the fallback to potentially attach the wrong
> PHY device instead of propagating the error.
> 
> This becomes a very weird bug on switches on which the PHY address
> isn't equal to the corresponding DSA port's index, as failure to
> attach the PHY with -ENOENT then just attaches another PHY, typically
> rendering two ports unusable instead of just one (and until you read
> and understand the code it looks like an alarming memory corruption
> rather than just PHY not being ready on time).

I think you've just discovered an undocumented requirement than actually
fixing a bug with this patch. If anything, the bug is in mxl862xx.

When making the comments that led to commit aefa52a28a36 ("net: dsa:
mxl862xx: rename MDIO op arguments"), I missed the fact that
mxl862xx_setup_mdio() is also setting ds->user_mii_bus.
Please remove that.

The only case when you can share the same function pointers between a
normal MDIO bus ops and ds->user_mii_bus ops is when the MDIO addresses
are equal to the port. Because otherwise, you need to translate the
"port" given to the ds->user_mii_bus into an MDIO address. If you don't,
you'll always connect to the wrong port using the ds->user_mii_bus, if
the internal PHY is not described in OF.

> Fix this by calling fwnode_get_phy_node() before falling back:
> If a phy-handle fwnode exists, skip the internal bus fallback and let
> the -ENODEV propagate to the caller. The fallback is only taken when
> no phy-handle is present in DT, which was the original intent.
> 
> Fixes: aab9c4067d238 ("net: dsa: Plug in PHYLINK support")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  net/dsa/user.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/net/dsa/user.c b/net/dsa/user.c
> index c4bd6fe90b455..90e540f490bb3 100644
> --- a/net/dsa/user.c
> +++ b/net/dsa/user.c
> @@ -2656,6 +2656,7 @@ static int dsa_user_phy_setup(struct net_device *user_dev)
>  {
>  	struct dsa_port *dp = dsa_user_to_port(user_dev);
>  	struct device_node *port_dn = dp->dn;
> +	struct fwnode_handle *phy_fwnode;
>  	struct dsa_switch *ds = dp->ds;
>  	u32 phy_flags = 0;
>  	int ret;
> @@ -2682,9 +2683,18 @@ static int dsa_user_phy_setup(struct net_device *user_dev)
>  	ret = phylink_of_phy_connect(dp->pl, port_dn, phy_flags);
>  	if (ret == -ENODEV && ds->user_mii_bus) {
>  		/* We could not connect to a designated PHY or SFP, so try to
> -		 * use the switch internal MDIO bus instead
> +		 * use the switch internal MDIO bus instead. Only fall back if
> +		 * no phy-handle was specified in DT. If a phy-handle exists
> +		 * but the PHY device is missing (e.g. not yet ready at
> +		 * registration time), connecting to a PHY at dp->index would
> +		 * attach the wrong PHY device.
>  		 */
> -		ret = dsa_user_phy_connect(user_dev, dp->index, phy_flags);
> +		phy_fwnode = fwnode_get_phy_node(of_fwnode_handle(port_dn));
> +		if (IS_ERR(phy_fwnode))
> +			ret = dsa_user_phy_connect(user_dev, dp->index,
> +						   phy_flags);
> +		else
> +			fwnode_handle_put(phy_fwnode);

Yeah, phylib seems incapable of deferring probing of a MAC driver that
connects to the PHY at probe time and doesn't find it. This is because
the code is shared with drivers that connect to the PHY at ndo_open()
time, and returning -EPROBE_DEFER to them wouldn't make any sense. So
phylib doesn't return -EPROBE_DEFER to anyone.

Actually this is one of the reasons why I was looking to upstream a
change that moves the DSA PHY connection to ndo_open(). It allows the
PHY probing to settle. I would appreciate not complicating this logic if
we don't have to.

>  	}
>  	if (ret) {
>  		netdev_err(user_dev, "failed to connect to PHY: %pe\n",
> -- 
> 2.53.0


