Return-Path: <netdev+bounces-292836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PCLGzuhGGqblggAu9opvQ
	(envelope-from <netdev+bounces-292836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 22:10:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E65F75F7FC1
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 22:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0742630FAC96
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 20:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DEB40961F;
	Thu, 28 May 2026 20:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvY4jkyb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CDB42188B
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998707; cv=none; b=FJZ1M8rBdgmwiE/733zcR6g8z5gROiCKU/ey0JToQkCScm8HeZtZO4kuTnDqLnzWrdBjoj+Alasf8MzqMMlVBg/EJSLWZvXv9LPXYl9+H020sgsyeW81SXHcTDIK/XFqrmF70mJ90uKJVmO04qwTZQBbFEDIYFe+rX2r47x6P/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998707; c=relaxed/simple;
	bh=xUeRD4UGilASN7aGNfZrP521YTBbheDyCQmP3FSgDRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7DpNjpPMMpP65fRGyIns/NBS+dqnts4OnRNzb0B5AVDhJ57zM7VzbnAJ+NKRsKl3DGe28d8KLMQp4BxDoLorInHPHyqFSBa+VGAL18wZ7XdM7ZVAp+N+P1SraKismoHegy61m0dQRsdYMnJ0zR/MKPlKBy3Bisz7lX+gblam1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvY4jkyb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666F21F000E9;
	Thu, 28 May 2026 20:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779998705;
	bh=DubbH4uJH9g+7V8V+QOTeyItqg7+pY+vWDmn2+fhis8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KvY4jkybRVLEmsCURitYF+E2Bi3SCn8ZNMBMV7XWq1yro3y66Vs0HqunvZUcYLbPZ
	 ITtJ091xymPTSB0O/aF2B6aYG1y8KAzLGSEK33tqbuCjg0Y/HOgnCvkzK6UbWuX+Vs
	 Hd8aLVhDpr8hP/IirYpRtAtnQFo8B3L8hh+MHtnm706V9OrbTj6EMpO2+fbLziutBU
	 BFRLyJocKayOOF6i1eWfH/7VIwrDjIE8xj8Itoc5TjKwBo+PF3zWhgkzSIj8veHm42
	 khdRDLt9S6RsYUJZSHlPy1qLoZZIRArjsw+GNxY7FutCXHK6BJYsyWayjvjla069r1
	 ArbrJEHzYo69A==
From: Simon Horman <horms@kernel.org>
To: kipreyyy@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	netdev@vger.kernel.org
Subject: Re: [PATCH xfrm] xfrm: vti: hold device reference for tunnel pointer stored in skb cb
Date: Thu, 28 May 2026 21:04:40 +0100
Message-ID: <20260528200438.2724831-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526101724.69508-1-kipreyyy@gmail.com>
References: <20260526101724.69508-1-kipreyyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292836-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Queue-Id: E65F75F7FC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
xfrm: vti: hold device reference for tunnel pointer stored in skb cb

This patch adds dev_hold() in vti_input() and vti6_input_proto() when
stashing the tunnel device pointer into XFRM_TUNNEL_SKB_CB(skb), with
matching dev_put() calls on every return path of vti_rcv_cb() and
vti6_rcv_cb() to balance the new reference.

> diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
> index 95b6bb78fcd2..3be298c5a80c 100644
> --- a/net/ipv4/ip_vti.c
> +++ b/net/ipv4/ip_vti.c
> @@ -62,6 +62,7 @@ static int vti_input(struct sk_buff *skb, int nexthdr, __be32 spi,
>  			goto drop;
>  
>  		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 = tunnel;
> +		dev_hold(tunnel->dev);
>  
>  		if (update_skb_dev)
>  			skb->dev = tunnel->dev;

[High]
Is the new dev_hold() balanced on the async-resume drop path?
xfrm_input() with encap_type == -1 does:

    if (encap_type < 0 || ...) {
        x = xfrm_input_state(skb);

        if (unlikely(x->km.state != XFRM_STATE_VALID)) {
            ...
            if (encap_type == -1)
                dev_put(skb->dev);
            goto drop;
        }

        family = x->props.family;

so when the state has been invalidated between submission and async
completion, the function jumps to drop with family still at its
function-local default of AF_UNSPEC.

The drop path then calls xfrm_rcv_cb(skb, family, ..., -1).  Since
xfrm_input_afinfo only has slots populated for AF_INET and AF_INET6,
xfrm_rcv_cb returns -EAFNOSUPPORT before invoking vti_rcv_cb at all.

Does that mean the dev_hold(tunnel->dev) added in vti_input() is never
released on this path, leaving the vti netdev unable to be unregistered
("unregister_netdevice: waiting for vtiN to become free")?

This is the hardware-crypto / pcrypt async path the commit message
calls out, so does the fix actually cover it?

> @@ -112,6 +113,7 @@ static int vti_rcv_cb(struct sk_buff *skb, int err)
>  	if (err) {
>  		DEV_STATS_INC(dev, rx_errors);
>  		DEV_STATS_INC(dev, rx_dropped);
> +		dev_put(dev);
>  
>  		return 0;
>  	}
> @@ -125,6 +127,7 @@ static int vti_rcv_cb(struct sk_buff *skb, int err)
>  		if (inner_mode == NULL) {
>  			XFRM_INC_STATS(dev_net(skb->dev),
>  				       LINUX_MIB_XFRMINSTATEMODEERROR);
> +			dev_put(dev);
>  			return -EINVAL;
>  		}
>  	}
> @@ -135,12 +138,15 @@ static int vti_rcv_cb(struct sk_buff *skb, int err)
>  	ret = xfrm_policy_check(NULL, XFRM_POLICY_IN, skb, family);
>  	skb->mark = orig_mark;
>  
> -	if (!ret)
> +	if (!ret) {
> +		dev_put(dev);
>  		return -EPERM;
> +	}
>  
>  	skb_scrub_packet(skb, !net_eq(tunnel->net, dev_net(skb->dev)));
>  	skb->dev = dev;
>  	dev_sw_netstats_rx_add(dev, skb->len);
> +	dev_put(dev);
>  
>  	return 0;
>  }

[Critical]
Can the err == 0 paths that return a non-zero value cause a double
dev_put()?

xfrm_input() invokes the cb chain twice when the first call returns an
error:

    err = xfrm_rcv_cb(skb, family, x->type->proto, 0);
    if (err)
        goto drop;
    ...
drop:
    ...
    xfrm_rcv_cb(skb, family, x->type->proto, -1);

In vti_rcv_cb the inner_mode == NULL branch and the !ret branch both
return a negative value after performing dev_put(dev):

    if (inner_mode == NULL) {
        ...
        dev_put(dev);
        return -EINVAL;
    }
    ...
    if (!ret) {
        dev_put(dev);
        return -EPERM;
    }

Since XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 is not cleared, the second
invocation enters with err == -1 and reaches:

    dev = tunnel->dev;
    if (err) {
        ...
        dev_put(dev);
        return 0;
    }

so the same tunnel->dev is dev_put() twice for a single dev_hold() taken
in vti_input(), giving a netdev refcount underflow.

Should XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 be cleared after dev_put(),
or the error-return paths take the dev_put() only once?

> diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
> index df793c8bfffb..ab5f8480eed7 100644
> --- a/net/ipv6/ip6_vti.c
> +++ b/net/ipv6/ip6_vti.c
> @@ -317,9 +317,10 @@ static int vti6_input_proto(struct sk_buff *skb, int nexthdr, __be32 spi,
>  			goto discard;
>  		}
>  
> +		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip6 = t;
> +		dev_hold(t->dev);
>  		rcu_read_unlock();
>  
> -		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip6 = t;
>  		XFRM_SPI_SKB_CB(skb)->family = AF_INET6;
>  		XFRM_SPI_SKB_CB(skb)->daddroff = offsetof(struct ipv6hdr, daddr);
>  		return xfrm_input(skb, nexthdr, spi, encap_type);

[High]
Same async-resume question as for vti_input(): if x->km.state becomes
invalid between submission and the resume call, xfrm_input() goes to
drop with family still at AF_UNSPEC, xfrm_rcv_cb() bails out via
xfrm_input_get_afinfo() returning NULL, and vti6_rcv_cb() is never
called.  Is the dev_hold(t->dev) added here ever released on that path?

> @@ -356,6 +357,7 @@ static int vti6_rcv_cb(struct sk_buff *skb, int err)
>  	if (err) {
>  		DEV_STATS_INC(dev, rx_errors);
>  		DEV_STATS_INC(dev, rx_dropped);
> +		dev_put(dev);
>  
>  		return 0;
>  	}
> @@ -369,6 +371,7 @@ static int vti6_rcv_cb(struct sk_buff *skb, int err)
>  		if (inner_mode == NULL) {
>  			XFRM_INC_STATS(dev_net(skb->dev),
>  				       LINUX_MIB_XFRMINSTATEMODEERROR);
> +			dev_put(dev);
>  			return -EINVAL;
>  		}
>  	}
> @@ -379,12 +382,15 @@ static int vti6_rcv_cb(struct sk_buff *skb, int err)
>  	ret = xfrm_policy_check(NULL, XFRM_POLICY_IN, skb, family);
>  	skb->mark = orig_mark;
>  
> -	if (!ret)
> +	if (!ret) {
> +		dev_put(dev);
>  		return -EPERM;
> +	}
>  
>  	skb_scrub_packet(skb, !net_eq(t->net, dev_net(skb->dev)));
>  	skb->dev = dev;
>  	dev_sw_netstats_rx_add(dev, skb->len);
> +	dev_put(dev);
>  
>  	return 0;
>  }

[Critical]
The same double-put concern applies here.  When inner_mode == NULL the
function does dev_put(dev) and returns -EINVAL, and when xfrm_policy_check
fails it does dev_put(dev) and returns -EPERM.  xfrm_input() then re-runs
the cb chain with err == -1:

    if (err) {
        ...
        dev_put(dev);
        return 0;
    }

XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip6 still holds t, so this second
invocation does not exit at the !t check and performs another dev_put on
the same tunnel device.  Should the cb pointer be cleared or the put be
done once?

