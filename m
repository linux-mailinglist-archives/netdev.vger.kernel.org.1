Return-Path: <netdev+bounces-264411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHj6NL2VqWnYAQEAu9opvQ
	(envelope-from <netdev+bounces-264411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:39:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 744642139F5
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97430312CBB4
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 14:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7153A7F49;
	Thu,  5 Mar 2026 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCEKvxLA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D533395261
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720645; cv=none; b=EYHxsTLgxz25QwY6j7me3NtIh0TKFYFBPMgdARuHceOQDsauy1wypRTcYmvbUlAHpYpNGuhG/VwaAVFtf/6gg1V2G6meBy/C5y0sEkQl4pj5P4iNUkcNY8dltNsZrIuT2AdsU8iCGIF4/lqLm1oDoRadPz4gZga2+dfzW+mdmxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720645; c=relaxed/simple;
	bh=FEf4yd3C7bmrwgds3i3LiIUniHqhwKFe+EX/oUuDxw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9uS5A2PO0pOajEJosyDVUrqy4/mGjR4Nev4nxkubu/kO3Ok2zZVVU/N1uOnxjzWGK9fk5yD7769SFxmNe+n/AXKyaPgTN106yOzO8pLPbLOqEw8HWhmPHl+xjMla1Lxf0AaA84c1R3eEZdTcTm9ftaDlunbTbV1rwnD6Vkqj5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XCEKvxLA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772720643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C0Sl3m5ZVIWUkragul6SBNHFFYEJebGQqFRs6P/anAE=;
	b=XCEKvxLAdpfXEJuxdDwyn3XL7kbtj+1sgQmR8B6D9/4iojnLcFxv7dH0xoGgcgDIb/X9Kx
	czTiZ3JoumFWukMkKqHRvEZzBTtLkXyX16Tw/hiW495EJjKaluwKbwXRzSuaaNKLcSGNmA
	v2RubLILRH3ffFnTt+OHySa5zuV6T1w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-8lJmm8axNe2M1JA6zPyocg-1; Thu,
 05 Mar 2026 09:23:58 -0500
X-MC-Unique: 8lJmm8axNe2M1JA6zPyocg-1
X-Mimecast-MFC-AGG-ID: 8lJmm8axNe2M1JA6zPyocg_1772720636
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DE7E1800627;
	Thu,  5 Mar 2026 14:23:56 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.173])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 62F03195419E;
	Thu,  5 Mar 2026 14:23:53 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: bestswngs@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xmei5@asu.edu,
	kuba@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	security@kernel.org
Subject: Re: [net,v2] net: add xmit recursion limit to tunnel drivers
Date: Thu,  5 Mar 2026 15:23:38 +0100
Message-ID: <20260305142338.369328-1-pabeni@redhat.com>
In-Reply-To: <20260303164326.1803916-2-bestswngs@gmail.com>
References: <20260303164326.1803916-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 744642139F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264411-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: add xmit recursion limit to tunnel drivers

This commit adds recursion protection to tunnel drivers to prevent stack
exhaustion from routing loops. It moves dev_xmit_recursion helpers to a
public header and adds recursion checks in ip_tunnel_xmit() and
ip6_tnl_xmit().

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index d4e6e00bb90a..1a4d2542dbab 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h

[ ... ]

> diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> index 4021e6a73e32..80662f812080 100644
> --- a/include/net/ip_tunnels.h
> +++ b/include/net/ip_tunnels.h

[ ... ]

> diff --git a/net/core/dev.h b/net/core/dev.h
> index 98793a738f43..ec974b3c42d9 100644
> --- a/net/core/dev.h
> +++ b/net/core/dev.h

[ ... ]

> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index 50d0f5fe4e4c..39822e845a06 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c

[ ... ]

> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index 4c29aa94e86e..55bedd5cd656 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -1101,6 +1101,14 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
>  	u8 hop_limit;
>  	int err = -1;
>
> +	if (dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT) {
> +		net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
> +				     dev->name);
> +		DEV_STATS_INC(dev, tx_errors);
> +		kfree_skb(skb);
> +		return -1;
> +	}
> +

Does this create a double-free of skb in ip6_tnl_xmit()?

The new recursion check frees the skb and returns -1. But all callers of
ip6_tnl_xmit() also free the skb when they receive a non-zero error return:

ip6erspan_tunnel_xmit() at net/ipv6/ip6_gre.c calls kfree_skb(skb) in its
tx_err path after ip6_tnl_xmit returns -1:

net/ipv6/ip6_gre.c:ip6erspan_tunnel_xmit() {
    ...
    if (ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
                     NEXTHDR_GRE))
        goto tx_err;
    ...
tx_err:
    if (!IS_ERR(tun_dst))
        dst_cache_set_ip6(&t->dst_cache, &tun_dst->u.tun_info.key.u.ipv6.dst,
                          &fl6.saddr);
    DEV_STATS_INC(dev, tx_errors);
    kfree_skb(skb);
    return NETDEV_TX_OK;
}

Similarly, ip6_tnl_start_xmit() at net/ipv6/ip6_tunnel.c calls kfree_skb(skb)
after ipxip6_tnl_xmit propagates the -1:

net/ipv6/ip6_tunnel.c:ip6_tnl_start_xmit() {
    ...
    ret = ipxip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
                          protocol);
    if (ret < 0)
        goto tx_err;
    ...
tx_err:
    DEV_STATS_INC(dev, tx_errors);
    kfree_skb(skb);
    return NETDEV_TX_OK;
}

The existing error-return contract of ip6_tnl_xmit() is that the caller
retains skb ownership on error. All pre-existing error paths
(tx_err_link_failure, tx_err_dst_release, ip6_tnl_encap failure) return
negative without freeing skb.

The new recursion check breaks this contract by freeing skb AND returning -1,
causing the caller to kfree_skb() an already-freed skb. This double-free will
cause slab corruption or a crash exactly when the recursion protection
triggers.

Note the IPv4 counterpart ip_tunnel_xmit() is not affected because it returns
void and always owns the skb (its existing error paths also kfree_skb
internally).


