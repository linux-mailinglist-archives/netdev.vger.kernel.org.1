Return-Path: <netdev+bounces-299486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EK+IMUMNMGozMgUAu9opvQ
	(envelope-from <netdev+bounces-299486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:33:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B44687362
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:33:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OYrCoZfL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299486-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299486-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54CB730CCB46
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD5F3F99E9;
	Mon, 15 Jun 2026 14:29:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0052B3F8233
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 14:29:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533780; cv=none; b=abbrFi8Gm6EuPuvEB3moC/ZSyD1w6xgQ9NsSzn+9eltQRb2qDHFiDkHD+dFdm6vQO38E+LKUzqNC1KOnSjk+UX1yd/XIvAvBtH/Y4A8iIHkexflLDQgm2L7e7XevjXVKlIcemtgQj4jmqI25qkREN2PRxeBh8ls6caG+g+L/OPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533780; c=relaxed/simple;
	bh=w1gkQSp4bLEvE9Zf2i9IIj5vxR/a0ua+nkuiv7Rq3SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuC2JjpqajD4MDZrBTmxyEAYhZoVvfVEvNVFwOUm4n2mXZzSroVRR/L71smmNz/Nsdyj+A9/U+MgaLT4677uk/xXVSamCJ2wcjmcCaMlkopVxUv1Kpw76GumFd5+FL6nkqGrb6fm8Tga0hmhxWBtNlQMNXg6Tu8KvJ9lAgYTcAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYrCoZfL; arc=none smtp.client-ip=209.85.221.41
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45fd45e596cso1926594f8f.1
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 07:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781533777; x=1782138577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MJZyZBn4jeHODrkETJFaLR/dMj4QyJJb1BWtqT5cdaY=;
        b=OYrCoZfLH9lqs80B+oFqVpaQJkjc+NA5rWiQJzK4JsbhLSAx+So5E6ujuywJd4S7at
         8ZDKbKsPYsYhFQLWWrIm9AelyIo9r6mOiyBCI1N2Dn9EvT3+hjzpzhINay18pHh9lt/f
         uWG+TNz3thYQhT6PQSMxURqAQG3SmGmnT5gaWuzUWHK5YRUeVpE8ddA6DhRx+8RVRqoV
         MD+NUHWmmucf+EnDuOTOEdS3XwiMiS9T9M/qAxsU7kae3lynsRbAkehoUDoAkUiDSvAR
         SOBbfcCl+6cEnAHlB7TUdGEtubyjSdxLuC8HRJ+LhVocApuIgZ9MlMNuufdZtsaPKnbs
         VALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781533777; x=1782138577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJZyZBn4jeHODrkETJFaLR/dMj4QyJJb1BWtqT5cdaY=;
        b=mL6Hvs9ZP+H0Gsug9HmAMDnhSFuab1oFFxgrtiBx/HMez9FLJ5RXigABgifqEwOI6V
         WItsK/uFe4/Wm1PgCElD3hyuLBWDAxgMM16qHkPCyFHsiruCCxMsztnoDMfQtXbRmced
         /iEjmdywmTaCwsucRIRpBWafSo3O1deggPeQ3ZGxO1G5Qww4dZMaCQlwFiW7fL3D+lPW
         IobwYrHyddpJZuO+r3PQge+8EawkO2k0nEcDNo50mSqAGiYkd/cPC6/X7twfJHc9jJlI
         JykRx5aRrTiZXhUQ39b8nvp4NhBodTy/6trUZ2n66BGhRvzQ8+F+NDxG+D/ySc+FlzaZ
         CQuA==
X-Forwarded-Encrypted: i=1; AFNElJ8HCvs30pbD99afWCPvx+fl++F0CTOic+ELxDpl31sQeki4dwR6ZQOeewRDa+ROGr55fxkQVmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIgmViKRc6SXNSjBk97RRtUUenxlyhJtmuqVDh3wtFspp/FZ9Q
	tYyRcXPbG07j/OBBctg1GkYdHJFnB9V/kO2bFXbqmGpMqW34T7CJcPSZ
X-Gm-Gg: Acq92OG0/AcyxJaf2po4SPSN5tPNLgA5EbfifmiCl7Jlw3u4wP2DlP7QSfBkmve7LYC
	UmX4oYBI/4v/OAHs7wMJybdLeI4iU0rsDHdxDJMJYrqTgpsRjoxXdS3dC8PWeT4Igvi3wFcpIuR
	vb0bpQTkQVrbw9PqCbAV/BXw0pRz9oHl5kz5Sf/ZvH8TVotT2vYWZVWFFmfGjQATJj4ych/whg7
	eQOIDtimUzpPZic6eFfiQi6immZRONXJhnju7xzhCaZxu5J14Y43Zyz95l4vu1+vNzkyisunD0M
	KCPQCjQeyVZ/6jCIuPj5Uvdl4ReL9LUfs8rZpMq4Srk7QDIaKgwCP2we0EyAtXI0SxsPCNqp3Vh
	M8vRFxGnTNhDigsxXwbnD6BBK2KpqOrbuzFd2GqvFVJqQcVbl/pXf1iejvo0YqRrP+gcOgUORNg
	RygBSqP6yHnRKOQN5hY1Z5w2nBw5DQ67Ky
X-Received: by 2002:a05:6000:26c4:b0:460:64b6:522d with SMTP id ffacd0b85a97d-4606db96e0fmr19951528f8f.28.1781533777000;
        Mon, 15 Jun 2026 07:29:37 -0700 (PDT)
Received: from cedric-laptop ([195.225.166.186])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2ce361sm33973271f8f.31.2026.06.15.07.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:29:36 -0700 (PDT)
Date: Mon, 15 Jun 2026 16:29:34 +0200
From: Cedric Jehasse <cedric.jehasse@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: 
	Cedric Jehasse via B4 Relay <devnull+cedric.jehasse.luminex.be@kernel.org>, cedric.jehasse@luminex.be, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luke Howard <lukeh@padl.com>, Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [PATCH net-next v7 2/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
Message-ID: <4dvydmir7hw4zhfrxonjuu4l7as6hma5yg4iuv3vgoqed7zai6@knkmyvh4sa54>
References: <20260609-net-next-mv88e6xxx-cbs-v7-0-7d5d732df545@luminex.be>
 <20260609-net-next-mv88e6xxx-cbs-v7-2-7d5d732df545@luminex.be>
 <20260612153656.4c5b8c62@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612153656.4c5b8c62@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299486-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[cedricjehasse@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:devnull+cedric.jehasse.luminex.be@kernel.org,m:cedric.jehasse@luminex.be,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:kabel@kernel.org,m:devnull@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,vger.kernel.org,padl.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedricjehasse@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,cedric.jehasse.luminex.be];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,knkmyvh4sa54:mid,luminex.be:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25B44687362

O Fri, Jun 12, 2026 at 03:36:56PM -0700, Jakub Kicinski wrote:
> On Tue, 09 Jun 2026 14:10:51 +0200 Cedric Jehasse via B4 Relay wrote:
> > From: Cedric Jehasse <cedric.jehasse@luminex.be>
> > 
> > Some of the chips supported by this driver have credit based shaper
> > support. Support is added for the 6341, 6352, 6390 and 6393 families.
> > This is configured using the Qav registers in the AVB register block.
> > There are small differences in the Qav registers between the chip
> > families (eg. the unit used for the rate and number of bits in the
> > registers). mv88e6xxx_qav_info is introduced to configure this per chip.
> > 
> > Eg. setting up 20mbps credit based shaper on a 1GBit link:
> > tc qdisc add dev p8 parent root handle 100: mqprio \
> >                 num_tc 8 \
> >                 map 0 0 6 7 0 5 0 0 0 0 0 0 0 0 0 0 \
> >                 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
> >                 hw 0
> > 
> > tc qdisc replace dev p8 parent 100:8 cbs locredit -1470 hicredit 30 \
> >     sendslope -980000 idleslope 20000 offload 1
> 
> Are DSA ports multi-queue? I would have expected a DSA driver to
> offload PRIO not MQPRIO.
> 
> I seem to recall other discussion on the ML on the topic.
> It'd be great to get some review tags from folks familiar with 
> the device.

As mentioned by Luke, this patch adds offloading for CBS, not MQPIO. Other dsa
driver already do this (eg. microchip ksz driver).

> 
> > Note: only idleslope and hicredit can be programmed in the switch
> > registers, other parameters won't affect settings.
> 
> > +static int mv88e6xxx_setup_tc_cbs(struct dsa_switch *ds, int port,
> > +				  struct tc_cbs_qopt_offload *cbs)
> 
> please stick an extack into struct tc_cbs_qopt_offload and use it to
> report the reason for rejection back to the user
> 

Do you mean modifying cbs_enable_offload to report a driver specified reason isof
reportig the generic "Specified device failed to setup cbs hardware offload"?
What should be done for other drivers who handle TC_SETUP_QDISC_CBS, but don't
fill in extack? Should cbs_enable_offload fill in extack with "Specified device
failed to setup cbs hardware offload"?

Cedric

