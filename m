Return-Path: <netdev+bounces-84172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8DB895E02
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 22:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD0B61C220AD
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 20:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A5D15D5CB;
	Tue,  2 Apr 2024 20:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TV4MGWBS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0EB1E4AE
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 20:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091087; cv=none; b=J4Fen4qdsp6Qe06vY1ufs+EWsWBoNcBcScjDFK1ronbbKWpFUxf8m6CBpCSx1t/FF8vdeJlWplCnbLvUUgdfZb/55PzpU/Z51K+OjaJFmpkRC9yvvpRC8ZAaZpaHIuGMFtWK0CBSQtGq6iJ5n05Xaj/ldo33od0LhjheudKWBjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091087; c=relaxed/simple;
	bh=zXehSwlqpiwAe3Pru6PmnYdpDJFi8QhfUb3v6gOHMuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVp6jq7bREVEJazGtAJa7TM6JPFt49rR+50cbKHoa0/dm8VP3jIIefEknIepVnXli8UExXSqg4oYZt+rkELO7fFLjxCtjlk15a+oJiCmqSyaYO/KtrIOVgWCOzv7VPWYnxoi+958I28YzdwpyaOxxYtJBZeCLAjMNt1Oi70xbiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TV4MGWBS; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56bf6591865so8256867a12.0
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 13:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712091084; x=1712695884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=boiIrhgyVhlBIrLh8NBdbxaAvEKjJB/at/zpmIdgS9I=;
        b=TV4MGWBScOEklErXqqzwlnYR5O7wt49akJgeDZR/UzufJirdTZkfGzvjs2VZyryNy2
         yZ7rvtcbK3vuVS7C6n16T9UnrLP5pqxB+hTlAvDJ6egjFbomGyHNSkA7yULfJRVxjN++
         9IPtEFkiU3f2p8DYKwtxIXYnqBwCrFbfXa7GiBMwzofd38N+fAP7plof3qohql6gs50O
         mFLpKYt8M5YIL7CDzpfRn4DehJdmSH6Sd1FzmXMnf4O/iVWBkW65v8aeN4AGBlmBzFOo
         VX9icPyPVdaAirLizWqHAIwNj3mjdzCzIlFnMzJwLBvVh5xy/T6CzYafYJXpOeiBrt8S
         4k6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712091084; x=1712695884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boiIrhgyVhlBIrLh8NBdbxaAvEKjJB/at/zpmIdgS9I=;
        b=efTg4Md9lOulQ/DrRW/U5V1Nnl31hNsLhciPEZxQex+OJ88NiRkIhehaMAgUJ3BDKw
         iiTOF2UwuJIq8vhi5+wc6PWbsKqgdRPxRnbi6tY8iDxtOVb/xhlRJWdDJLATu3SGSpb5
         u4Q8zJooYE+nGUi0E3nzCpOjwY4SDvBLnv+RLDE31WfYqV0V389JaHUinZB1L9JKghQQ
         3yqKj6fCOKyNbsUfVoV5KD0ltvtbQtaFuij0G4mNehc1ZYniUK1Ljj8TwVI8Q6NbpbLD
         hnvOVa3PZL6Tp4TQ5sOgKXkbnhwqxMIft0draiE7oYjXKH0lfw/xid0UYBz1jQHeF8s6
         joCw==
X-Forwarded-Encrypted: i=1; AJvYcCU4ljiDHzZmo0MYPgWmGSRmRxqOrs3MAuPC+GGs7D5g0sGEIR89vZVESccKZf4VzxDKcSDw7G82T97ttImNWupOAyeQxH01
X-Gm-Message-State: AOJu0Yzd48yNdRGRkeKzdgqZN817J37yp1FTDEHwrHDmYvEkz0s0W+Yd
	MWZ2/jbVDq/09OOrARC9326AR5OvZfCoLf2tT+ZCHSTzm459JAmA
X-Google-Smtp-Source: AGHT+IH0sOVSdW1za8nzuxY8q8dSVCv/PoXTB0G3JGXQOaH4PTcrgzJz5Nc3904Mmd0puGK958ip0Q==
X-Received: by 2002:a17:906:a81:b0:a4e:6580:eec5 with SMTP id y1-20020a1709060a8100b00a4e6580eec5mr538181ejf.27.1712091084073;
        Tue, 02 Apr 2024 13:51:24 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id gl20-20020a170906e0d400b00a46c39e6a47sm6978845ejb.148.2024.04.02.13.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 13:51:23 -0700 (PDT)
Date: Tue, 2 Apr 2024 23:51:21 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/7] net: dsa: Add helpers to convert netdev
 to ds or port index
Message-ID: <20240402205121.yvgen4gokzjjn6jl@skbuf>
References: <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-0-221b3fa55f78@lunn.ch>
 <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-5-221b3fa55f78@lunn.ch>
 <20240402105652.mrweu2rnend3n3tf@skbuf>
 <ZgwItu4gETdLbHWi@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgwItu4gETdLbHWi@shell.armlinux.org.uk>

On Tue, Apr 02, 2024 at 02:31:34PM +0100, Russell King (Oracle) wrote:
> Yes, I would tend to agree having done this for my experimental phylink
> changes. struct dsa_port seems to make the most sense:
> 
> static inline struct dsa_port *
> dsa_phylink_to_port(struct phylink_config *config)
> {
>         return container_of(config, struct dsa_port, pl_config);
> }
> 
> which then means e.g.:
> 
> static void mv88e6xxx_mac_config(struct phylink_config *config,
>                                  unsigned int mode,
>                                  const struct phylink_link_state *state)
> {
>         struct dsa_port *dp = dsa_phylink_to_port(config);
>         struct mv88e6xxx_chip *chip = dp->ds->priv;
>         int port = dp->index;
>         int err = 0;
> 
>         mv88e6xxx_reg_lock(chip);
> 
>         if (mode != MLO_AN_PHY || !mv88e6xxx_phy_is_internal(chip, port)) {
>                 err = mv88e6xxx_port_config_interface(chip, port,
>                                                       state->interface);
>                 if (err && err != -EOPNOTSUPP)
>                         goto err_unlock;
>         }
> 
> err_unlock:
>         mv88e6xxx_reg_unlock(chip);
> 
>         if (err && err != -EOPNOTSUPP)
>                 dev_err(dp->ds->dev, "p%d: failed to configure MAC/PCS\n",
>                         port);
> }

Looks ok, looking forward to seeing more of it. Maybe a slight
preference to keeping "struct dsa_switch *ds" as a local variable of its
own, even if this means declaring and initializing "chip" on separate
lines.

