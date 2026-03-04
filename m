Return-Path: <netdev+bounces-263883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJA+FotWqGlutQAAu9opvQ
	(envelope-from <netdev+bounces-263883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:58:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1D3203794
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70A3B3154BA8
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 15:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B40234AB19;
	Wed,  4 Mar 2026 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIErtYoc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A468434AB14
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 15:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639288; cv=none; b=u9A6rPjel9Lqkb4WXo0Ea8AX6hIRnpY7fAQ9aVHBYKNCjHhZPt4XBWXRs5qJ2P83RrM9pHZZWiCAp6EgA1PPyzbf35TCbjGSxzjAfYn1KdmMRqNQuQYUoVwPbKpH1wP+2eFmfUwEjKw9lhdarbU9mMf6+Q9mXAgdUd6MJpu1A7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639288; c=relaxed/simple;
	bh=It7vqTDWM+9LohjxWOX5uUhFMzhxAbyFv2dhoIakMhc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=kMAFV5450hnGnbfntTQgOy8B3+RQwYfKcO6rPzYd+FxPcn05/jPf0C6CQVbSBHswW+Zjn6PgnW5CrOlXhVAEKEsYCNK9ZIM2FLUxHvaCJogSYvpG5eFxb1ivzngLHq25Pao/7Xyk9ENaK5r8wTcEeA1Z7vjkGeDFdopvlpSfo+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIErtYoc; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-798527f822cso70768957b3.3
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 07:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772639285; x=1773244085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrXiubzGRG3KppsR+/lOlS92Klb6+yCus+Zo1KUOVb8=;
        b=IIErtYocFUmZmW3fUdOcyNY/6xZl2dFwkat648/OnZ3NB3MyqAoZ6TT4JQlVednIQA
         SS4aPBdLKiWauK/9pBA2zJE6hQQvJLsBz+S5D6MOW99Fq0zahELrMhHs1tGg8A3ufGjG
         VzcJbW0LQyIpm7gLrpUP8lWSELkD9Y2Um7jV4Naz3PzP+HC5q5gySxK3woo/18EPUirY
         nnYXtwtNI38yNEjThE5tA3eu5xpKGfZQDrmxKzhuwPM9X7hk3zgvNmu0d8aCL8cdxabg
         TJAGLNjpT6gSL3LzpIqeFuP41tYa9C9fyfdKiiSRgXDfGG3f4nlXyJWsAPkkEH0rtKaa
         pbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772639285; x=1773244085;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XrXiubzGRG3KppsR+/lOlS92Klb6+yCus+Zo1KUOVb8=;
        b=oPVUAOJLCkyrpkiTLN/VZWUbU2ESaYcRsYj5q+AfYHcTPkL8tBfHMWM1xBxSLcH3g2
         YHlY/69iVrSbXz68PbCtwVMrHgIn3cD820/jhcy3PHy6zCd9LYHO3GtzrWOlKoVK2V28
         a6coJTaBFy468F6T2+chza18eNEemxMY2gozsnp5mAA7ZUe+uvRKAro4R9OO/ZCB334G
         nmMm8kURImSelKA0v1RXNZCNjXD5oQ9qsTPWRkGnPal4fpVv0bU0gGuGtt1tp+2C2u6v
         20Uvu7yrdcqVfdQXr0r/cYoxD5tBEWMT8k4OA0U4n8qXoT931Piz8Oqbe3VXmSIQ3V24
         CCAg==
X-Forwarded-Encrypted: i=1; AJvYcCUUEaKSGJirBBxg4cZcH5awKYZewF8ITqAyEHvcPBxEsCzlZNWzqC1IjBWwd1bxkndrKV0g+O4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFCi4W8Q0wt3I9z8FGnkO4SBIrfGH2gXetDHaBj0PibQGszC11
	rsEGhA/gJtXolELhayw/JbkWOxtTPOVhYr7RInVtcNBR9/xMm2mU7g9dF9JnhA==
X-Gm-Gg: ATEYQzykQu3hCAqDLuw3pGdtYT/p7IUCZRxrxLRLYI9NJL/IHd1p7OMtSzAcXsyZe++
	ADX2HBDthrz3TW2r9UpS0VbfMKFNAhHbAcH2hqKhdZim5kICUAAcnq9nV9J7nLzfX8P8QontOVQ
	3OfiBBaaIU0FSjJ0mXFtawce1PWEecKxQ6IBsoQjp6w0UsdS/t9PMk/BheKdvRpS0JWuoV6tbHU
	lgX+kY5pgbU82G1MjOBYjTCW+5zGgXXekt3Z72SS5IZgPqZMR3ADSLw5OYDakOlG4BZP9uePyFT
	YUSGDz7sz8uSQdiuoKJp9o7Jg3udVekV65Dv0Y053pFzZbEmeKTMUB2VzraDOUEC4FQBw77hIMA
	SRQOlvxuboaOe7PbeodiEYPdlX8d/p9GRyTvBGjVjhA6lTFFEoYwVqOqFla6paGapJw9z/9yNmK
	dUo6RSp8tkqFQ8Je7VI3ytZ0NOU5y0eZ2a9z6lvlS1NLQ/Rh7wdQKBs97+flmcmMAWoq93hZg=
X-Received: by 2002:a05:690c:398:b0:795:510:92db with SMTP id 00721157ae682-798c6c88094mr20178177b3.39.1772639285591;
        Wed, 04 Mar 2026 07:48:05 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79876aea3b4sm75018347b3.21.2026.03.04.07.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 07:48:05 -0800 (PST)
Date: Wed, 04 Mar 2026 10:48:04 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Maciek Machnikowski <maciek@machnikowski.net>, 
 netdev@vger.kernel.org
Cc: kuba@kernel.org, 
 maciek@machnikowski.net, 
 richardcochran@gmail.com, 
 milena.olech@intel.com, 
 willemdebruijn.kernel@gmail.com, 
 andrew@lunn.ch, 
 vadim.fedorenko@linux.dev, 
 horms@kernel.org
Message-ID: <willemdebruijn.kernel.288cce8279af0@gmail.com>
In-Reply-To: <willemdebruijn.kernel.211108b8ab49@gmail.com>
References: <20260225153858.29486-1-maciek@machnikowski.net>
 <20260225153858.29486-3-maciek@machnikowski.net>
 <willemdebruijn.kernel.211108b8ab49@gmail.com>
Subject: Re: [PATCH v3 net-next 2/3] netdevsim: Implement basic ptp support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CE1D3203794
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263883-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,machnikowski.net,gmail.com,intel.com,lunn.ch,linux.dev];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,machnikowski.net,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.995];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,machnikowski.net:email]
X-Rspamd-Action: no action

Willem de Bruijn wrote:
> Maciek Machnikowski wrote:
> > Add support for virtual timestamping inside the netdevsim driver.
> > The implementation uses two attached ptp_mock clocks, reads the timestamps
> > of the ones attached either to the netdevsim or its peer and returns
> > timestamps using standard timestamps APIs.
> > 
> > This implementation enables running ptp4l on netdevsim adapters and
> > introduces a new ptp selftest.
> > 
> > Co-developed-by: Milena Olech <milena.olech@intel.com>
> > Signed-off-by: Milena Olech <milena.olech@intel.com>
> > Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
> > ---
> >  drivers/net/netdevsim/ethtool.c   | 11 ++++
> >  drivers/net/netdevsim/netdev.c    | 90 +++++++++++++++++++++++++++++++
> >  drivers/net/netdevsim/netdevsim.h |  1 +
> >  3 files changed, 102 insertions(+)
> > 
> > diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
> > index 36a201533..5b709033c 100644
> > --- a/drivers/net/netdevsim/ethtool.c
> > +++ b/drivers/net/netdevsim/ethtool.c
> > @@ -200,7 +200,18 @@ static int nsim_get_ts_info(struct net_device *dev,
> >  {
> >  	struct netdevsim *ns = netdev_priv(dev);
> >  
> > +	ethtool_op_get_ts_info(dev, info);
> > +
> >  	info->phc_index = mock_phc_index(ns->phc);
> > +	if (info->phc_index < 0)
> > +		return 0;
> > +
> > +	info->so_timestamping |= SOF_TIMESTAMPING_TX_HARDWARE |
> > +				 SOF_TIMESTAMPING_RX_HARDWARE |
> > +				 SOF_TIMESTAMPING_RAW_HARDWARE;
> > +
> > +	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
> > +	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) | BIT(HWTSTAMP_FILTER_ALL);
> >  
> >  	return 0;
> >  }
> > diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> > index 6285fbefe..b1161c1ca 100644
> > --- a/drivers/net/netdevsim/netdev.c
> > +++ b/drivers/net/netdevsim/netdev.c
> > @@ -30,6 +30,8 @@
> >  #include <net/rtnetlink.h>
> >  #include <net/udp_tunnel.h>
> >  #include <net/busy_poll.h>
> > +#include <linux/ptp_clock_kernel.h>
> > +#include <linux/timecounter.h>
> >  
> >  #include "netdevsim.h"
> >  
> > @@ -119,12 +121,17 @@ static int nsim_forward_skb(struct net_device *tx_dev,
> >  
> >  static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
> >  {
> > +	struct skb_shared_hwtstamps shhwtstamps = {};
> >  	struct netdevsim *ns = netdev_priv(dev);
> > +	struct ptp_clock_info *ptp_info;
> > +	struct timespec64 tx_ts, rx_ts;
> > +	struct sk_buff *skb_orig = skb;
> >  	struct skb_ext *psp_ext = NULL;
> >  	struct net_device *peer_dev;
> >  	unsigned int len = skb->len;
> >  	struct netdevsim *peer_ns;
> >  	struct netdev_config *cfg;
> > +	bool gen_tx_tstamp = false;
> >  	struct nsim_rq *rq;
> >  	int rxq;
> >  	int dr;
> > @@ -161,6 +168,27 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
> >  		skb_linearize(skb);
> >  
> >  	skb_tx_timestamp(skb);
> > +	gen_tx_tstamp = skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP;
> > +	if (gen_tx_tstamp) {
> > +		ptp_info = mock_phc_get_ptp_info(ns->phc);
> > +
> > +		/* Create a copy of tx skb to keep the tx reference */
> > +		skb_orig = skb;
> > +		skb = skb_copy(skb_orig, GFP_ATOMIC);
> > +		skb_shinfo(skb_orig)->tx_flags |= SKBTX_IN_PROGRESS;
> > +
> > +		/* Timestamp as late as possible */
> > +		if (ptp_info)
> > +			ptp_info->gettime64(ptp_info, &tx_ts);
> > +	}
> > +
> > +	/* Generate Rx tstamp based on the peer clock */
> > +	ptp_info = mock_phc_get_ptp_info(peer_ns->phc);
> > +	if (ptp_info) {
> > +		ptp_info->gettime64(ptp_info, &rx_ts);
> > +		skb_hwtstamps(skb)->hwtstamp = timespec64_to_ktime(rx_ts);
> > +	}
> > +
> >  	if (unlikely(nsim_forward_skb(dev, peer_dev,
> >  				      skb, rq, psp_ext) == NET_RX_DROP))
> >  		goto out_drop_cnt;
> > @@ -168,6 +196,13 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
> >  	if (!hrtimer_active(&rq->napi_timer))
> >  		hrtimer_start(&rq->napi_timer, us_to_ktime(5), HRTIMER_MODE_REL);
> >  
> > +	/* only timestamp the outbound packet if user requested it */
> > +	if (gen_tx_tstamp) {
> > +		shhwtstamps.hwtstamp = timespec64_to_ktime(tx_ts);
> > +		skb_tstamp_tx(skb_orig, &shhwtstamps);
> > +		dev_kfree_skb_any(skb_orig);
> > +	}
> > +
> 
> I still don't understand this tx timestamp path, which is
> non-standard.
> 
> The comment says timestamp as late as possible, which would be calling
> gettime64 in the second branch, rather than the first. That would mean
> that the tx timestamp is taken after the rx timestamp at the peer.
> Confusing, but something that may actually happen on real NICs too in
> some cases (e.g., PCI backpressure).
> 
> If goal is to maintain ordering between the two, remove the comment
> about as late as possible.
> 
> More importantly, since skb_tstamp_tx internally will call alloc_skb
> or skb_clone, why is this skb_copy here needed?
> 
> I probably should have replied to your previous response:
> 
> > If I queue the tx timestamp before forwarding - the same skb would
> > be freed when the timestamp is delivered.
> 
> That is not the case since it is a clone or separate skb that is
> queued to the error queue?

Let me ask differently: why not queue the tx timestamp directly in
that first branch?


