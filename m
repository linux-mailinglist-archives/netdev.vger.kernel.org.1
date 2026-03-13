Return-Path: <netdev+bounces-267274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cD3+Ia11s2mwWgAAu9opvQ
	(envelope-from <netdev+bounces-267274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:25:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD89D27CB5D
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 942B8306B0A8
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E7830CDAB;
	Fri, 13 Mar 2026 02:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="b7zXVCzS";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="KY/QLe+i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7074133F5AA
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 02:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773368746; cv=none; b=LzkAVab2gAOEIBlTLlpxYNsf0bGTWzbBDJ8t52mSv3lNGD0Zjw4zlOCfPiJq6OHkRtBveovoJN2HFTP7WH5Qg9G+iX0ut06jkB/HGWH/QSACAKpUSa1dckXcNqBMwOKQk8L/GVf+FTMUe91vREGC1jz973IJkyQ+zYwFEz6jByY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773368746; c=relaxed/simple;
	bh=iybkShq+eeB/N9hIgL2g8uGPpw4Y1noKr/R8WNX75N4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oqxElxy7wOD/KErqD+tKJyeJaqrBsqjChB01wxmGY75zbED2g3Y7OrCxyhS4/tkogrQ+BICLEPzr792OOUhljqy9VkZABqw+XeKy5Lj++0u4kPvzZ/B8EDVos78/GvoNPqcS+WzevSTPzxl5jJ+5vwmyj3N9DuOSWuRG+RVkm3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=b7zXVCzS; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=KY/QLe+i; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 62D22Pmv031505;
	Fri, 13 Mar 2026 03:02:30 +0100
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id AB7CE1203FB;
	Fri, 13 Mar 2026 03:02:20 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1773367340; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WTicygdLzl3PdcjoOTqIU/VjPmdT+LHMw1+56XhDDRs=;
	b=b7zXVCzS2Ao+2YGYHZok2C5S0VXnQHM5jHLr6dlQ6Mp0Wt0gOan59Ub1ItELQwurIB/aLd
	Oz018Bvs36SFBuDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1773367340; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WTicygdLzl3PdcjoOTqIU/VjPmdT+LHMw1+56XhDDRs=;
	b=KY/QLe+iS0+/bo2BPX41fKqKgy/ij1eZlxOfMU2uI5FuV69Rb4xo33YsWEdF2KgKeeFrJP
	WIQk5YXoWqJtpsMuR6U3RJSKZZDkHQAJNxUCPgJRsTcdt/wszO6QpaN+GAU3AALCedOgEZ
	Qew96RhpXSa/Posl2Sf4KZCNetx+HZwPvYCwM3xmJJDm5RfAW2OEW0WYTzo5WF0/c5Dnd0
	EFaJGeoUInWG6P5EJAvpjIQw0CXjkDcIVnfZJzIr8++5lNqsWOyXXmQLD8Y7Eh4aBbSg+e
	pbu+oLNTm3N0OKPDmEfOXOo6WZilLmruFzS9VTz3CLJWEimdgmx6eQJ5Gu7IpQ==
Date: Fri, 13 Mar 2026 03:02:20 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Justin Iurman <justin.iurman@6wind.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, justin.iurman@gmail.com, nicolas.dichtel@6wind.com,
        stefano.salsano@uniroma2.it, Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net-next v2] seg6: add per-route tunnel source address
Message-Id: <20260313030220.af70f3b5f2c5d2cb7b4a840e@uniroma2.it>
In-Reply-To: <20260311152845.278354-1-justin.iurman@6wind.com>
References: <20260311152845.278354-1-justin.iurman@6wind.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniroma2.it,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[uniroma2.it:s=ed201904,uniroma2.it:s=rsa201904];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com,6wind.com,uniroma2.it];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267274-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[uniroma2.it:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,6wind.com:email,uniroma2.it:dkim,uniroma2.it:mid]
X-Rspamd-Queue-Id: DD89D27CB5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026 16:28:45 +0100
Justin Iurman <justin.iurman@6wind.com> wrote:

> Add SEG6_IPTUNNEL_SRC in the uapi for users to configure a specific
> tunnel source address. Make seg6_iptunnel handle the new attribute
> correctly. It has priority over the configured per-netns tunnel
> source address, if any.
> 
> Signed-off-by: Justin Iurman <justin.iurman@6wind.com>
> ---
> v2:
>  - AI review: fix seg6_encap_nlsize() and seg6_encap_cmp() to include tunsrc
>  - AI review: make set_tun_src() agnostic of seg6_lwt because it is called from
>               two contexts other than seg6_iptunnel
> 
> v1: https://lore.kernel.org/netdev/CAOY2BqxUswHYoisKjABPunMUC5QJ-B-O9aXu=wKrhTZaqSqedQ@mail.gmail.com/T/
> ---
>  include/uapi/linux/seg6_iptunnel.h |   1 +
>  net/ipv6/seg6_iptunnel.c           | 115 +++++++++++++++++++++--------
>  2 files changed, 85 insertions(+), 31 deletions(-)
> 

Hi Justin,
thanks for the fixes in v2.


IMHO, two things that would be really valuable to have alongside this patch:
 
1) I couldn't find the matching iproute2 patch for the new
   SEG6_IPTUNNEL_SRC attribute; did I miss it, or is it still in the
   works? In the second case, having it available would be great to
   fully test the new feature;
2) Since this introduces a new UAPI attribute, we definitely need
   selftest coverage for it. Perhaps extending one of the
   existing seg6 selftests (e.g. srv6_hencap_red_l3vpn_test.sh?) might
   be a good option rather than writing a new one from scratch.


> diff --git a/include/uapi/linux/seg6_iptunnel.h b/include/uapi/linux/seg6_iptunnel.h
> index ae78791372b8..485889b19900 100644
> --- a/include/uapi/linux/seg6_iptunnel.h
> +++ b/include/uapi/linux/seg6_iptunnel.h
> @@ -20,6 +20,7 @@
>  enum {
>  	SEG6_IPTUNNEL_UNSPEC,
>  	SEG6_IPTUNNEL_SRH,
> +	SEG6_IPTUNNEL_SRC,	/* struct in6_addr */
>  	__SEG6_IPTUNNEL_MAX,
>  };
>  #define SEG6_IPTUNNEL_MAX (__SEG6_IPTUNNEL_MAX - 1)
> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> index 3e1b9991131a..d45b6b49dd48 100644
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c
> @@ -49,6 +49,7 @@ static size_t seg6_lwt_headroom(struct seg6_iptunnel_encap *tuninfo)
>  
>  struct seg6_lwt {
>  	struct dst_cache cache;
> +	struct in6_addr tunsrc;
>  	struct seg6_iptunnel_encap tuninfo[];
>  };
>  
> @@ -65,6 +66,7 @@ seg6_encap_lwtunnel(struct lwtunnel_state *lwt)
>  
>  static const struct nla_policy seg6_iptunnel_policy[SEG6_IPTUNNEL_MAX + 1] = {
>  	[SEG6_IPTUNNEL_SRH]	= { .type = NLA_BINARY },
> +	[SEG6_IPTUNNEL_SRC]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
>  };
>  
>  static int nla_put_srh(struct sk_buff *skb, int attrtype,
> @@ -87,23 +89,32 @@ static int nla_put_srh(struct sk_buff *skb, int attrtype,
>  }
>  
>  static void set_tun_src(struct net *net, struct net_device *dev,
> -			struct in6_addr *daddr, struct in6_addr *saddr)
> +			struct in6_addr *daddr, struct in6_addr *saddr,
> +			struct in6_addr *route_tunsrc)
>  {
>  	struct seg6_pernet_data *sdata = seg6_pernet(net);
>  	struct in6_addr *tun_src;
>  
> -	rcu_read_lock();
> -
> -	tun_src = rcu_dereference(sdata->tun_src);
> -
> -	if (!ipv6_addr_any(tun_src)) {
> -		memcpy(saddr, tun_src, sizeof(struct in6_addr));
> +	/* Priority order to select tunnel source address:
> +	 *  1. per route source address (if configured)
> +	 *  2. per network namespace source address (if configured)
> +	 *  3. dynamic resolution
> +	 */
> +	if (route_tunsrc && !ipv6_addr_any(route_tunsrc)) {
> +		memcpy(saddr, route_tunsrc, sizeof(struct in6_addr));
>  	} else {
> -		ipv6_dev_get_saddr(net, dev, daddr, IPV6_PREFER_SRC_PUBLIC,
> -				   saddr);
> -	}
> +		rcu_read_lock();
> +		tun_src = rcu_dereference(sdata->tun_src);
> +
> +		if (!ipv6_addr_any(tun_src)) {
> +			memcpy(saddr, tun_src, sizeof(struct in6_addr));
> +		} else {
> +			ipv6_dev_get_saddr(net, dev, daddr,
> +					   IPV6_PREFER_SRC_PUBLIC, saddr);
> +		}
>  
> -	rcu_read_unlock();
> +		rcu_read_unlock();
> +	}
>  }
>  
>  /* Compute flowlabel for outer IPv6 header */
> @@ -125,7 +136,8 @@ static __be32 seg6_make_flowlabel(struct net *net, struct sk_buff *skb,
>  }
>  
>  static int __seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
> -			       int proto, struct dst_entry *cache_dst)
> +			       int proto, struct dst_entry *cache_dst,
> +			       struct in6_addr *route_tunsrc)
>  {
>  	struct dst_entry *dst = skb_dst(skb);
>  	struct net_device *dev = dst_dev(dst);
> @@ -182,7 +194,7 @@ static int __seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
>  	isrh->nexthdr = proto;
>  
>  	hdr->daddr = isrh->segments[isrh->first_segment];
> -	set_tun_src(net, dev, &hdr->daddr, &hdr->saddr);
> +	set_tun_src(net, dev, &hdr->daddr, &hdr->saddr, route_tunsrc);
>  
>  #ifdef CONFIG_IPV6_SEG6_HMAC
>  	if (sr_has_hmac(isrh)) {
> @@ -202,14 +214,15 @@ static int __seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
>  /* encapsulate an IPv6 packet within an outer IPv6 header with a given SRH */
>  int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
>  {
> -	return __seg6_do_srh_encap(skb, osrh, proto, NULL);
> +	return __seg6_do_srh_encap(skb, osrh, proto, NULL, NULL);
>  }
>  EXPORT_SYMBOL_GPL(seg6_do_srh_encap);
>  
>  /* encapsulate an IPv6 packet within an outer IPv6 header with reduced SRH */
>  static int seg6_do_srh_encap_red(struct sk_buff *skb,
>  				 struct ipv6_sr_hdr *osrh, int proto,
> -				 struct dst_entry *cache_dst)
> +				 struct dst_entry *cache_dst,
> +				 struct in6_addr *route_tunsrc)
>  {
>  	__u8 first_seg = osrh->first_segment;
>  	struct dst_entry *dst = skb_dst(skb);
> @@ -272,7 +285,7 @@ static int seg6_do_srh_encap_red(struct sk_buff *skb,
>  	if (skip_srh) {
>  		hdr->nexthdr = proto;
>  
> -		set_tun_src(net, dev, &hdr->daddr, &hdr->saddr);
> +		set_tun_src(net, dev, &hdr->daddr, &hdr->saddr, route_tunsrc);
>  		goto out;
>  	}
>  
> @@ -308,7 +321,7 @@ static int seg6_do_srh_encap_red(struct sk_buff *skb,
>  
>  srcaddr:
>  	isrh->nexthdr = proto;
> -	set_tun_src(net, dev, &hdr->daddr, &hdr->saddr);
> +	set_tun_src(net, dev, &hdr->daddr, &hdr->saddr, route_tunsrc);
>  
>  #ifdef CONFIG_IPV6_SEG6_HMAC
>  	if (unlikely(!skip_srh && sr_has_hmac(isrh))) {
> @@ -383,9 +396,11 @@ static int seg6_do_srh(struct sk_buff *skb, struct dst_entry *cache_dst)
>  {
>  	struct dst_entry *dst = skb_dst(skb);
>  	struct seg6_iptunnel_encap *tinfo;
> +	struct seg6_lwt *slwt;
>  	int proto, err = 0;
>  
> -	tinfo = seg6_encap_lwtunnel(dst->lwtstate);
> +	slwt = seg6_lwt_lwtunnel(dst->lwtstate);
> +	tinfo = slwt->tuninfo;
>  
>  	switch (tinfo->mode) {
>  	case SEG6_IPTUN_MODE_INLINE:
> @@ -410,11 +425,11 @@ static int seg6_do_srh(struct sk_buff *skb, struct dst_entry *cache_dst)
>  			return -EINVAL;
>  
>  		if (tinfo->mode == SEG6_IPTUN_MODE_ENCAP)
> -			err = __seg6_do_srh_encap(skb, tinfo->srh,
> -						  proto, cache_dst);
> +			err = __seg6_do_srh_encap(skb, tinfo->srh, proto,
> +						  cache_dst, &slwt->tunsrc);
>  		else
> -			err = seg6_do_srh_encap_red(skb, tinfo->srh,
> -						    proto, cache_dst);
> +			err = seg6_do_srh_encap_red(skb, tinfo->srh, proto,
> +						    cache_dst, &slwt->tunsrc);
>  
>  		if (err)
>  			return err;
> @@ -436,12 +451,12 @@ static int seg6_do_srh(struct sk_buff *skb, struct dst_entry *cache_dst)
>  
>  		if (tinfo->mode == SEG6_IPTUN_MODE_L2ENCAP)
>  			err = __seg6_do_srh_encap(skb, tinfo->srh,
> -						  IPPROTO_ETHERNET,
> -						  cache_dst);
> +						  IPPROTO_ETHERNET, cache_dst,
> +						  &slwt->tunsrc);
>  		else
>  			err = seg6_do_srh_encap_red(skb, tinfo->srh,
> -						    IPPROTO_ETHERNET,
> -						    cache_dst);
> +						    IPPROTO_ETHERNET, cache_dst,
> +						    &slwt->tunsrc);
>  
>  		if (err)
>  			return err;
> @@ -678,6 +693,10 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
>  		if (family != AF_INET6)
>  			return -EINVAL;
>  
> +		if (tb[SEG6_IPTUNNEL_SRC]) {
> +			NL_SET_ERR_MSG(extack, "incompatible mode for tunsrc");
> +			return -EINVAL;
> +		}
>  		break;
>  	case SEG6_IPTUN_MODE_ENCAP:
>  		break;
> @@ -702,13 +721,21 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
>  	slwt = seg6_lwt_lwtunnel(newts);
>  
>  	err = dst_cache_init(&slwt->cache, GFP_ATOMIC);
> -	if (err) {
> -		kfree(newts);
> -		return err;
> -	}
> +	if (err)
> +		goto free_lwt_state;
>  
>  	memcpy(&slwt->tuninfo, tuninfo, tuninfo_len);
>  
> +	if (tb[SEG6_IPTUNNEL_SRC]) {
> +		slwt->tunsrc = nla_get_in6_addr(tb[SEG6_IPTUNNEL_SRC]);
> +
> +		if (ipv6_addr_any(&slwt->tunsrc)) {
> +			err = -EINVAL;
> +			NL_SET_ERR_MSG(extack, "tunsrc cannot be ::");
> +			goto free_dst_cache;
> +		}
> +	}
> +

build_state() only rejects ::. Multicast or loopback will be silently
accepted, leading to an asymmetric black hole:
 
 - seg6_input() path: encapsulated packet enters ip6_forward()
   which has the "security critical" saddr check; drop on the same
   node, packet never leaves;
 - seg6_output() path: goes through ip6_output() which has no saddr
   check; packet leaves, first transit drops it in ip6_rcv_core()
   or ip6_forward().
 
Either way, silent black hole.
 
I think we could reject these at build_state time, matching a similar
logic already present in ip6_forward(), e.g.:
 
	if (ipv6_addr_any(&slwt->tunsrc) ||
	    ipv6_addr_is_multicast(&slwt->tunsrc) ||
	    ipv6_addr_loopback(&slwt->tunsrc)) {
		NL_SET_ERR_MSG(extack, "invalid tunsrc address");
		err = -EINVAL;
		goto free_dst_cache;
	}


Whether to also reject link-local is debatable: ip6_forward() does
drop it, but is there a legitimate use case where a link-local tunnel
source would actually be needed?!
I'd argue we should reject link-local addresses as well.
For instance, using them as a tunnel source violates scope boundaries and
breaks ICMPv6 error reporting.


Side note: seg6_genl_set_tunsrc() in seg6.c has the same gap; likely worth a
separate fix targeting net. If we agree this is an issue, I'll try to send a
follow-up patch later on, so that we can have a similar validation logic for
both per-route and per-netns tunsrc.


>  	newts->type = LWTUNNEL_ENCAP_SEG6;
>  	newts->flags |= LWTUNNEL_STATE_INPUT_REDIRECT;
>  
> @@ -720,6 +747,12 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
>  	*ts = newts;
>  
>  	return 0;
> +
> +free_dst_cache:
> +	dst_cache_destroy(&slwt->cache);
> +free_lwt_state:
> +	kfree(newts);
> +	return err;
>  }
>  
>  static void seg6_destroy_state(struct lwtunnel_state *lwt)
> @@ -731,29 +764,49 @@ static int seg6_fill_encap_info(struct sk_buff *skb,
>  				struct lwtunnel_state *lwtstate)
>  {
>  	struct seg6_iptunnel_encap *tuninfo = seg6_encap_lwtunnel(lwtstate);
> +	struct seg6_lwt *slwt = seg6_lwt_lwtunnel(lwtstate);
> +	int err;
>  
>  	if (nla_put_srh(skb, SEG6_IPTUNNEL_SRH, tuninfo))
>  		return -EMSGSIZE;
>  
> +	if (!ipv6_addr_any(&slwt->tunsrc)) {
> +		err = nla_put_in6_addr(skb, SEG6_IPTUNNEL_SRC, &slwt->tunsrc);
> +		if (err)
> +			return err;
> +	}
> +

Minor nit: seg6_fill_encap_info() could drop the local `err` in favour
of something like:
 
	if (!ipv6_addr_any(&slwt->tunsrc) &&
	    nla_put_in6_addr(skb, SEG6_IPTUNNEL_SRC, &slwt->tunsrc))
		return -EMSGSIZE;
 
nla_put_in6_addr() can only return 0 or -EMSGSIZE, so this stays
consistent with the nla_put_srh() pattern above.


>  	return 0;
>  }
>  
>  static int seg6_encap_nlsize(struct lwtunnel_state *lwtstate)
>  {
>  	struct seg6_iptunnel_encap *tuninfo = seg6_encap_lwtunnel(lwtstate);
> +	struct seg6_lwt *slwt = seg6_lwt_lwtunnel(lwtstate);
> +	int nlsize;
> +
> +	nlsize = nla_total_size(SEG6_IPTUN_ENCAP_SIZE(tuninfo));
>  
> -	return nla_total_size(SEG6_IPTUN_ENCAP_SIZE(tuninfo));
> +	if (!ipv6_addr_any(&slwt->tunsrc))
> +		nlsize += nla_total_size(sizeof(slwt->tunsrc));
> +
> +	return nlsize;
>  }
>  
>  static int seg6_encap_cmp(struct lwtunnel_state *a, struct lwtunnel_state *b)
>  {
>  	struct seg6_iptunnel_encap *a_hdr = seg6_encap_lwtunnel(a);
>  	struct seg6_iptunnel_encap *b_hdr = seg6_encap_lwtunnel(b);
> +	struct seg6_lwt *a_slwt = seg6_lwt_lwtunnel(a);
> +	struct seg6_lwt *b_slwt = seg6_lwt_lwtunnel(b);
>  	int len = SEG6_IPTUN_ENCAP_SIZE(a_hdr);
>  
>  	if (len != SEG6_IPTUN_ENCAP_SIZE(b_hdr))
>  		return 1;
>  
> +	if (!ipv6_addr_equal(&a_slwt->tunsrc, &b_slwt->tunsrc))
> +		return 1;
> +
>  	return memcmp(a_hdr, b_hdr, len);
>  }
>  
> -- 
> 2.39.2
> 

No other comments from my side for now.
Thanks!

Ciao,
Andrea

