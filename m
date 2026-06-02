Return-Path: <netdev+bounces-294175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MOODJcnHHmopVAAAu9opvQ
	(envelope-from <netdev+bounces-294175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:08:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DAB62DDA0
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:08:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="A/uImSdm";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294175-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294175-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C31230CA17A
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 12:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C7A3DD536;
	Tue,  2 Jun 2026 12:01:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884EE3DD508
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 12:01:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401669; cv=none; b=Fn+nmVkurjSSiBLDt0v2jEcJaJMTpUEIuk67b8KKjleznFq+VtKamUWb9rLdgO5cQrkF1TN8fSiNSV3C1p5tsomDS9cEPCptso7qiuqmS0ugElB0BNQ9+D0WpF0ejTGpgLDGG5BT7F7YMWIimrLS+djvrDB4EyeKnPLxTB7+AaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401669; c=relaxed/simple;
	bh=5vvYoMF+qfsljw9HoOnQexBYxvBiVq1OjsZS0Xfmuzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8HiUDZ92RGppisax+24kK7vO6WC3CNIxOiH6PVpJRMYyu0BGP0Nvt50GEaqYy6dTS31qop5K1WxiZo+OSMIMosHVGExj8lHlH+4YvjsVgkPM8Bo1BuC63vsKS9hBim24SVK1PRcKKei1yjo5OnvuBYy9nadIbdYqtUuchzBQls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/uImSdm; arc=none smtp.client-ip=209.85.221.49
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45ee6d32402so2836678f8f.1
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 05:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780401664; x=1781006464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QbmaePIzUDbGyOJEyAqfLgC05MeRGYdaKnUjikSR2fc=;
        b=A/uImSdmsyyDa++KGAM8XzzVnYR8FlPRB2UD+nzqWLrx8mKgyeZqLvhOyH33Bbz1ie
         5VR5twjmT54WfskdKur5LFX8KOzBz6A8lZmfCuEzifOmp/H8bQP8Cp8hv70qogQXAN0n
         lcqRUGy9dijzCGRq5yMB3aHDd49rHic3v93agoaMZXY02UT48cKwJ9FlaqIP4+6hevyS
         ZeOfXeGzE2wPfCawxy36d/MJluSskTw7YUVQOeQttukkG3y4Dl5ylIyPMoWrb9f5xBTi
         JjkELo4Mox1gWtbyqvqRecf3eyUS6q7Oa35tJawZMg/oGFFUE9BtU28wwcVQ9qWY1sVf
         uUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780401664; x=1781006464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbmaePIzUDbGyOJEyAqfLgC05MeRGYdaKnUjikSR2fc=;
        b=sOcAP08P9/IyCY4NFgKaUlng9aUzD7i2lykiOz7H4+wEBXqZOvbmJ/JyT7MpW6g34A
         s7up/HiN4INoks1MhCqB5zdetuAx3bPyjhetOllu960JSjVDUrqYxHZ3aB73M37aR6+Q
         tO5e67n6V33/wwfb8r8XoGAM4gLpFR6MuTVgL1kSokHN/Di5V3CnTusQgCUf2cTcF2KS
         O3EWs4Elzjg2G8ZGbWyE/K+Xwer4Nfmptj5jk3jMZDXw5PwG9EdZI+PG0loaVlYQtOJB
         eT4e2gfESw3WipzQIxrEP948lscD9mN/UX9lTC7Vv/Y0C6YLY1T6NJq99pLwJxPgRbHt
         MpRQ==
X-Forwarded-Encrypted: i=1; AFNElJ88kdrt3Aq1JmFkU/0SH/dfOQhAgA7s/IBN+R5d1OR1gHHuTRCUosCkIF2C3aF9mJtrZJNDN5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ60tOBKCiv8BYC1Xqf/4uGFsULeYuTad0pQTe1U4jns3v4LUK
	bfEGPIaW1vnal2KlqczDdtxvrV/f1MbAVvpMZOKB1UigSgUA+Vy/np9J
X-Gm-Gg: Acq92OGMc73sxAK4ZBxnsYOhWH1zOJc8DaQmm4bYxf6TWPD9VE26pu6KnUohyPF83YK
	0HsMg7NLacEPvRRYg4FRycG3K/tJbMZfoGRI7sxAZ0p3aWDU3EIguuYmdHmLnuLbse2Jh6hujgX
	zU2Dti8NpJaKS8pdFO4pARqcHmuHrFLJUBevP2Av2FzRbcWPJP7Ueo61y5EaiMyRk1sYO8tC7q8
	zFN2JvkrEnomKyHgqXb9JF1N4x3/5tUfE/Ud9UJMlsoxZ+mmaxDxoxXmdk5z90/CB2rAsL1VKh7
	mWeEyiqGZmaoNFA53Y7woDqZpygn/87iSFNLYmxbjlI3/6ZLKuH4zAT7XMe07uLXN9cAhAM1KBE
	ZrvAKotbsA/TTN0Or0Q6axqGTLEyqtPqY5z7bXpsuvPS6q72Uq5418YnPmUw6AXd3lqFXlsYBs3
	0vBB9hNWnUPhIWJubsN7HgGdsQkLYDhZ5vNzyNAvouVBFQZCeF5+qAWDRS52ODvfYRR9fhszJFt
	ujjFwsw5QuINLGy/oC+Cb8G9wpcFChN6ZPnf1cQNqcTDc0=
X-Received: by 2002:adf:e510:0:b0:45e:f271:5019 with SMTP id ffacd0b85a97d-45ef6b1f0d2mr24998882f8f.14.1780401663495;
        Tue, 02 Jun 2026 05:01:03 -0700 (PDT)
Received: from cedric-laptop (2a02-1810-cd14-9200-ca7b-4123-f99d-3775.ip6.access.telenet.be. [2a02:1810:cd14:9200:ca7b:4123:f99d:3775])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef356b129sm42075516f8f.32.2026.06.02.05.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 05:01:02 -0700 (PDT)
Date: Tue, 2 Jun 2026 14:00:53 +0200
From: Cedric Jehasse <cedric.jehasse@gmail.com>
To: Luke Howard <lukeh@padl.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Max Hunter <max@huntershome.org>, Kieran Tyrrell <kieran@sienda.com>
Subject: Re: [PATCH net-next v2 5/6] net: dsa: mv88e6xxx: MQPRIO support
Message-ID: <t44kmhk6gqxnwhdvo7svouexwelwsya7zgukpbv3cxpfsmutqa@y3rjoj3tvqce>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-5-72be14522e7c@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-mv88e6xxx-8021qat-mqprio-v2-5-72be14522e7c@padl.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294175-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[cedricjehasse@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:lukeh@padl.com,m:jiri@resnulli.us,m:ivecera@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:shuah@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bridge@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:max@huntershome.org,m:kieran@sienda.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[resnulli.us,redhat.com,davemloft.net,google.com,kernel.org,blackwall.org,nvidia.com,lunn.ch,gmail.com,vger.kernel.org,lists.linux.dev,huntershome.org,sienda.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedricjehasse@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F3DAB62DDA0

On Tue, Jun 02, 2026 at 10:43:50AM +1000, Luke Howard wrote:
> +static int mv88e6xxx_setup_tc_mqprio(struct dsa_switch *ds, int port,
> +				     struct tc_mqprio_qopt_offload *mqprio)
> +{
> +	struct netlink_ext_ack *extack = mqprio->extack;
> +	u8 ieee_pri_map[IEEE_8021Q_MAX_PRIORITIES];
> +	struct mv88e6xxx_chip *chip = ds->priv;
> +	struct mv88e6xxx_tc_policy *pol;
> +	enum mv88e6xxx_tc_mode tc_mode;
> +	struct net_device *user;
> +	bool can_update_pol;
> +	bool per_port_pol;
> +	int num_tc, err;
> +
> +	if (!dsa_is_user_port(ds, port))
> +		return -EINVAL;
> +
> +	num_tc = mv88e6xxx_validate_tc_mqprio(chip, mqprio, &tc_mode, ieee_pri_map);
> +	if (num_tc < 0)
> +		return num_tc;
> +
> +	user = dsa_to_port(ds, port)->user;
> +
> +	per_port_pol = (tc_mode == MV88E6XXX_TC_MODE_QPRI &&
> +			chip->info->ops->port_ieee_pri_map);
> +
> +	mv88e6xxx_reg_lock(chip);
> +
> +	pol = &chip->tc_policy;
> +
> +	if (num_tc && pol->tc_mode && pol->tc_mode != tc_mode) {
> +		NL_SET_ERR_MSG_MOD(extack, "all switch ports must use the same MQPRIO mode");
> +		err = -EOPNOTSUPP;
> +		goto err_unlock;
> +	}
> +
> +	can_update_pol = per_port_pol ||
> +			 !pol->tc_port_mask || pol->tc_port_mask == BIT(port);
> +	if (!can_update_pol && num_tc &&
> +	    !mv88e6xxx_tc_mode_map_equal(chip, tc_mode, ieee_pri_map)) {
> +		NL_SET_ERR_MSG_MOD(extack, "only a single priority mapping supported per switch");
> +		err = -EOPNOTSUPP;
> +		goto err_unlock;
> +	}
> +
> +	err = mv88e6xxx_mqprio_netdev_set_tc(user, &mqprio->qopt, num_tc);
> +	if (err)
> +		goto err_reset_tc;
> +
> +	if (can_update_pol) {
> +		const u8 *map = num_tc ? ieee_pri_map : NULL;
> +
> +		if (per_port_pol)
> +			err = mv88e6xxx_set_port_ieee_pri_map(chip, port, map);
> +		else
> +			err = mv88e6xxx_set_ieee_pri_map(chip, map);

In case of per port priority mapping, i don't know if this is working as
expected, as the IEEE priority mapping is done at ingress.
Eg. i think if MQPRIO channel mode is used to configure a pcp to queue mapping
on port 1 and a different mapping on port 2. Traffic received on port 1 that
gets forwarded to port 2 and egresses port 2 will end up in the queue
configured by the mapping on port 1. As mqprio is an egress qdisc, i don't
think that's expected.

I have a patch that hasn't been submitted to the mailing list yet which
implements support for the dcb app pcp-prio command. This is also done by
configuring the IEEE priority mapping table.

Cedric


