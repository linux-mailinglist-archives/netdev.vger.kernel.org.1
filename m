Return-Path: <netdev+bounces-304902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5izaMblpS2oCRAEAu9opvQ
	(envelope-from <netdev+bounces-304902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 10:39:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3393870E31E
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 10:39:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=d3dKXIfv;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304902-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304902-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8ECFD300F7A9
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 08:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2973B3F8892;
	Mon,  6 Jul 2026 08:39:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA3E3998BE
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 08:39:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327156; cv=none; b=N67x2FbuefOfft8H0WBKeHh6ac9svPo2FALQCG+w5ieaKMjzb09d7jhPQy3ZvRfYBtxemRxUumM9Xjz+yzSffufYQqxQyt9rvyOv9TKfxQJMYcfeIIYKpyvXv9e3IRoC3JdqkAJgb0EgHKN9eHCyxzXhRiC3VXW2nkn7nRMHlQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327156; c=relaxed/simple;
	bh=e2Ji+pe/FvZXwpV4Xt5uOSRoeNT40g8FWm4dC+6dB9Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nb+hz5ML8efm/oOkCWqTbjtDtznSUVeighL9g95laD8soReP0tJAnKSYOdPrV5S9+S4kTIcmeWVHUmaBSjvo1zSDUynblwlJKPfHX3qfmhHWP6HCIO3CNWKaD0nKA6DndMshI4FOBKwdlStDbvoDwAlU+kCNZ+ZQdfLh1yZ6A00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3dKXIfv; arc=none smtp.client-ip=209.85.221.51
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47c2ae992beso123462f8f.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 01:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783327150; x=1783931950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x+ukvC8SX33SlI+h6grSEYjzYvRK1lDbsR7HDAAu2tk=;
        b=d3dKXIfvkea7NezY3YlOfTaz+lMDkmxLHzP4mK1dPgyy4sKiQQEaXhhTl0y5UWCBcd
         aoosfzGwim4CNra0f/dVKuL53w3SbBIS13F3FIhMEKOljlAXwPLZ3FMbxLOmTmfySMl5
         do0+KtMVSL/b7IyRfup98chNsPLJWT/ehFfNYRk3IN+MNfoLpPBXWcNyCc45NwwzvF1O
         EdPupmrqm1Om+w9iNJ+kritu6WfyeBItiRYelyFGMtKp371HhGhEEosJR3FdTkfu0nyb
         7g85BC7Ii+UavUv5t7L53nVBB0IEJ40yhxqk/wt4F1UxupBP5hGdxjUgOkhldOyJs8OZ
         6HVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783327150; x=1783931950;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x+ukvC8SX33SlI+h6grSEYjzYvRK1lDbsR7HDAAu2tk=;
        b=qYqlO8aiR049WDscVAjHFx4JGcQVIcrsSKTnIpnFESV8C6q84v/zbNKPvYdKURhMWS
         IXy90S2KiC7TBEjQH6N+P8JlFrxcs8S//oizjm+aZwHotMruerGF3TAclMlZx5aT3dqk
         n2HG4bdLx/MsBUbPUVtspVlTTGT09YMGkLuMrEvU54rTK3ntUNrQh8nqlvDMlZrcOPRU
         kZMmRb4gIRk3xU224xKRVXN9CXnE4B6+MBhh/p3mzdV7uZ8LKMcawL3wyokjQF2HjIAJ
         Yw1eRgWc7RX7LsyIhIqXrL5HdFZcK0gcoEVadPX9MoqpOCWfOpmJ/2plUeWAHh5kEjix
         lzNg==
X-Gm-Message-State: AOJu0Yybax2j1NpPMwXYGzyJwrLm5ugbAc3TRcRwb9q9qwZChUcmVLF2
	5UznK/NfzpDj9SICkxCUS8H6Y8/g2e8CAxUglRwkQ6LEGQo//Gv44eAF
X-Gm-Gg: AfdE7cmtmq2EXY2U6Ta53KFoaEhYkQ0cPxaQvu2DckwU0vWXTxyEsJqsf4J+Dj7yJLQ
	9xwkrokw1d84XhDDyYO0BZPn8sOOGqknimx3sS9ChimZQpoOJQLc59u0jMCQqTsQZxDgxFpk4GT
	6NFuczM89xPF/BbSuYdH+KlODApVXdKPy0gBCepNNCtbV+wk6OUhcmoGCIXastZHtW1WSvNhvoC
	AnYgVhszJY4/o/XH2Tfxo2q1xSgk9+4Z7bqelwNmirLJi5PwaTf7W2l3UlunHHDpGRLIp0EBTD4
	a2SPMRqbdA1Veq2Wmz3qs0OZXy11xXbf6MwKf0v6dh7q+ZE85/V75CnT5OwqaLFVzqDDtYC3VGA
	sV2n7paLYrJofYW0WXqwTz3MovH27DJgKysxdBuL0ZLgQOalCmvadXmye+4CiNr+T2m7WuU274i
	0NUXdqVOMIAEzE
X-Received: by 2002:a5d:5c89:0:b0:475:13e5:c878 with SMTP id ffacd0b85a97d-47aabd39c53mr5976764f8f.4.1783327149731;
        Mon, 06 Jul 2026 01:39:09 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d40e:d500:e1d4:332e:7c24:7e83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ad69519c2sm23892716f8f.37.2026.07.06.01.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 01:39:08 -0700 (PDT)
From: Vladimir Oltean <olteanv@gmail.com>
X-Google-Original-From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 6 Jul 2026 11:39:06 +0300
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Madalin Bucur <madalin.bucur@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dpaa_eth: convert to napi_gro_receive
Message-ID: <20260706083906.5oxmr47vbnaztfu2@skbuf>
References: <20260706030632.1826810-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706030632.1826810-1-rosenp@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304902-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:madalin.bucur@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,skbuf:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3393870E31E

Hi Rosen,

On Sun, Jul 05, 2026 at 08:06:32PM -0700, Rosen Penev wrote:
> Replace netif_receive_skb() with napi_gro_receive() to improve receive
> performance for this driver. It has rx checksum support so routing speed
> shouldn't suffer.
> 
> Tested on a WatchGuard Firebox M300.
> 
> iperf3 bidir speed test:
> 
> [ ID][Role]   Interval         Transfer      Bitrate        Retr
> [  5][TX-C]   0.00-60.01  sec  5.35 GBytes   766 Mbits/sec  184    sender
> [  5][TX-C]   0.00-60.02  sec  5.35 GBytes   766 Mbits/sec         receiver
> [  7][RX-C]   0.00-60.01  sec  5.50 GBytes   787 Mbits/sec  124    sender
> [  7][RX-C]   0.00-60.02  sec  5.49 GBytes   786 Mbits/sec         receiver
> 
> After:
> 
> [ ID][Role]   Interval         Transfer      Bitrate        Retr
> [  5][TX-C]   0.00-60.01  sec  6.49 GBytes   929 Mbits/sec    0    sender
> [  5][TX-C]   0.00-60.02  sec  6.49 GBytes   928 Mbits/sec         receiver
> [  7][RX-C]   0.00-60.01  sec  6.55 GBytes   938 Mbits/sec    0    sender
> [  7][RX-C]   0.00-60.02  sec  6.55 GBytes   937 Mbits/sec         receiver
> 
> Assisted-by: Opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> index ad2d8256eb8d..83191f636ec7 100644
> --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> @@ -2824,10 +2824,7 @@ static enum qman_cb_dqrr_result rx_default_dqrr(struct qman_portal *portal,
>  
>  	skb_len = skb->len;
>  
> -	if (unlikely(netif_receive_skb(skb) == NET_RX_DROP)) {
> -		percpu_stats->rx_dropped++;
> -		return qman_cb_dqrr_consume;
> -	}
> +	napi_gro_receive(&np->napi, skb);
>  
>  	percpu_stats->rx_packets++;
>  	percpu_stats->rx_bytes += skb_len;
> -- 
> 2.55.0
> 
> 

(thanks to Madalin for pointing out this change to me)

I do not have time this week to test this patch, but in premise, you are
creating exactly the conditions for this bug to occur:
https://github.com/nxp-qoriq/linux/commit/d0ebec2092d6c5fe327513cb66e02d8c2c1a8f87

In sdk_dpaa we already do GRO for TCP flows and it has the problems
pointed out in the above commit. With your change to use GRO for all
capable flows, I currently have no reason to believe that without
similar countermeasures as those taken by sdk_dpaa (napi_gro_receive()
global to the entire QMan portal) the outcome would be different.

Have you tested traffic in mixed scenarios, where flows from multiple
interfaces land on the same CPU?

Until further evidence comes in:

pw-bot: cr

