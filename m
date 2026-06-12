Return-Path: <netdev+bounces-298627-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zVVNBwb+K2qgJAQAu9opvQ
	(envelope-from <netdev+bounces-298627-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:39:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8687567966B
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:39:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=S7J2Cpmx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298627-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298627-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B8713056FFB
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BAC3DB652;
	Fri, 12 Jun 2026 12:37:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF55384CC8
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 12:37:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267849; cv=none; b=V5civJEo/eyWQcY7puVTZP0p2I68rmAHxFEp1JB0bYh1zvoUdP53wae916IObyvfGM4sZ/+66FAFMYXxbDiRvUKTvxqG5SDdEB/vIHAIthbetsuspE4RrYJJrrf7dB61PYGCWntRQW3LPuZVj6VWgqHdnk0vJjp/Ac5Y5uwnzxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267849; c=relaxed/simple;
	bh=9BiD/pNZG1w1cpdsMn9s0h2RHLqN9zijEXESHAV0+I4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqza2vWK5iTjZtW91IafrYCT18g+e+ehAAY+Uhn3CCLsEYPL7g66GeRjcruDjrxLHr9M5vbug56KnnmgwQqkGr2kp0cWpNsSiyakAIOY3klrzKvvO+g0B37tAy6RTESoMJapvvVPsCYf+7cYUB2XaYWXWh/hnnY6WLj4Jc4FJAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S7J2Cpmx; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b211ee6aso6396225e9.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 05:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781267846; x=1781872646; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MrjsT2w1j1qo9MwDPHviku0Dqn2a94LfN9cpJdJZDKs=;
        b=S7J2CpmxTelu6/D2S8mmF8NeGQzA/C9UYx9OVPvAbNwwlcjcKhNjpSxn8DMJI8cuMG
         0sZ2cTdzxEGQDClGFUUIJBdP/2o/cyNeDl+kBIE7AS8LGq5nz61PRB7eVGrG1FYsSqjV
         jTh77xSN+Fdukmf17oLQE0vCgh/8QFRqH21N8i2XPRd5N5uonwR+RX3QMQU1FQ7qWw52
         Zty/Ql7HfswoSxDFrQgAZt9Vtyiu/IqIvaaF9ocAg1dqw4+egIK8M8jxFClzEOQ/pafE
         nxuHqx5zT9mBMy/WJOTH2manPEi0QR1FEibC/RSUxOxuz9oakePYx+yjsGhm818Zg/Dl
         Jpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781267846; x=1781872646;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MrjsT2w1j1qo9MwDPHviku0Dqn2a94LfN9cpJdJZDKs=;
        b=FTR5WjwSJzIJ2xY5DkH8pNAO/U0z9w+AlSG2I1MOCwn6g7+nZ9zz+ivSFQZF4bELuC
         wsli3ZtZjfQLrX9SngL5GApVI8i/gcmyVplrmyCW6tubQbMiEenqlsZGpYzKJfaqj0PF
         lgTN/Yf/xfq2WAvj/7WPH3V7dNAqwow7LJoaWSNZl5AAwB9p0CuioabejWGJMzE8EcLS
         DJpsx8/VrxbJPy4+VuXmsMraryaBXJq4Ra/R9S78gZMCM7JeNtebTiA3vnFgTIoJcP1p
         9EKib8vg/kfCpUhgjgQRSzitihM15QwPREsaxoEi256e5LcVl161MvzCgDGLbyrdJ3FH
         9ZMA==
X-Forwarded-Encrypted: i=1; AFNElJ/AVwcSiK1N4jF8zUoqSAYZxhLVrfgUBXNU2m208mjtSz7NNbfE7Kyl/yhyXcC0OyQdY/yQWts=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIlRteKLZa3izw3KPAq6BDivYEmm8PGqqOJvVgmmjiAt8r6sWv
	bY6ScJTT6eB8D1Fgab0a3WMJjcknkkxf4roTZdnIi6dm3rhBBli1jpK7zWe8CuhLt7s=
X-Gm-Gg: Acq92OHWrd7DVr548zwco40Liy80pj79dkjBRfIjdZAoyVdXBP8TMSIOUHeV4pohQSy
	GQz9ez2jc8qZ4bKSDCoaM3oWKgPHVJC9qYi/EtBvXnruB/yvyY+VgmTrgNZeCGSqt6v4j9b1de/
	so72U98ZdMH5VjAOabpcm7RQrBqSLE1eS3KH94fZaynZdQP9de/g5vrPGtJPiOZ8GNLVY4pifZ9
	CmS0Niw3ZR08S2Z0YNk3YIn7CFAEr4DezR63rzVvgQARMeg+azN4GoIDPHqD/1dWBoH0i0U1gc8
	7Zpox9473HiMJQF8i6oahe36SqHhhihNriKEvD8IaDJHikyR4hBl8omGqvnLy1rTuVtT+AqbX3S
	TCaZl4kAXi4q/RD/uenwaLWJI7aFcArmfmv9htz2V9dKEIbeVotm+ovipYR3QyGKE7JpvWeMWCw
	J1j8OthmIx78AqigVBoXCc
X-Received: by 2002:a05:600c:5296:b0:492:1e7f:d426 with SMTP id 5b1f17b1804b1-4921e7fd54bmr110925e9.2.1781267846081;
        Fri, 12 Jun 2026 05:37:26 -0700 (PDT)
Received: from localhost ([195.94.146.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea843d63sm64794375e9.12.2026.06.12.05.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 05:37:25 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 12 Jun 2026 14:40:47 +0200
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Andrea della Porta <andrea.porta@suse.com>, netdev@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Lukasz Raczylo <lukasz@raczylo.com>,
	Steffen Jaeckel <sjaeckel@suse.de>
Subject: Re: [PATCH] net: macb: add TX stall timeout callback to recover from
 lost TSTART write
Message-ID: <aiv-T7thh8wj2d7n@apocalypse>
References: <771b8faeaee1fce4a84a5ba2661d60b35a65a6d5.1781253818.git.andrea.porta@suse.com>
 <DJ6Z39C906LE.1F3XKDDM41UJ8@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DJ6Z39C906LE.1F3XKDDM41UJ8@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298627-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:theo.lebrun@bootlin.com,m:andrea.porta@suse.com,m:netdev@vger.kernel.org,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rpi-kernel@lists.infradead.org,m:lukasz@raczylo.com,m:sjaeckel@suse.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrea.porta@suse.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.porta@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,raczylo.com:email,vger.kernel.org:from_smtp,suse.de:email,apocalypse:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8687567966B

Hi Theo,

On 11:45 Fri 12 Jun     , Théo Lebrun wrote:
> Hello Andrea,
> 
> On Fri Jun 12, 2026 at 11:01 AM CEST, Andrea della Porta wrote:
> > From: Lukasz Raczylo <lukasz@raczylo.com>
> >
> > The MACB found in the Raspberry Pi RP1 suffers from sporadic stalls on
> > the TX queue.
> > While the exact root cause is not yet fully understood, it is likely
> > related to a hardware issue where a TSTART write to the NCR register
> > is missed, preventing the transmission from being kicked off.
> >
> > Implement a timeout callback to handle TX queue stalls, triggering the
> > existing restart mechanism to recover.
> >
> > Link: https://lore.kernel.org/all/20260514215459.36109-1-lukasz@raczylo.com/
> > Fixes: dc110d1b23564 ("net: cadence: macb: Add support for Raspberry Pi RP1 ethernet controller")
> > Signed-off-by: Lukasz Raczylo <lukasz@raczylo.com>
> > Co-developed-by: Steffen Jaeckel <sjaeckel@suse.de>
> > Signed-off-by: Steffen Jaeckel <sjaeckel@suse.de>
> > Co-developed-by: Andrea della Porta <andrea.porta@suse.com>
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >  drivers/net/ethernet/cadence/macb_main.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> > index a12aa21244e83..615da65d5d68d 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > @@ -4522,6 +4522,16 @@ static int macb_setup_tc(struct net_device *dev, enum tc_setup_type type,
> >  	}
> >  }
> >  
> > +static void macb_tx_timeout(struct net_device *dev, unsigned int q)
> > +{
> > +	struct macb *bp = netdev_priv(dev);
> > +
> > +	if (net_ratelimit())
> > +		netdev_err(dev, "TX stall detected, re-kicking TSTART\n");
> 
> Is this standard? It looks odd.

I've found it used in other drivers, it's the closest I had found that
limit the rate for net related output. As Nicolai suggested, on timeout
a message is already printed by the core, so I will drop those two lines.

> 
> > +	dev->stats.tx_errors++;
> 
> I am surprised by this. `tx_errors` would ideally be one per packet that
> didn't get sent. Here we increment it once per queue that stalled.
> 
> I have a series to address stats issue (and use netdev_stat_ops API).
> It is a follow-up to this:
> https://lore.kernel.org/netdev/20260428-macb-drop-tx-v2-0-647f5199d8df@bootlin.com/
> 
> Also this is per-device shared data and we access it without
> synchronisation.
> 
> Let's drop this increment.

Agreed.

Thanks,
Andrea

> 
> > +	macb_tx_restart(&bp->queues[q]);
> > +}
> 
> Regards,
> 
> --
> Théo Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

