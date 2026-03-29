Return-Path: <netdev+bounces-272976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKnbGKZ2yWngyAUAu9opvQ
	(envelope-from <netdev+bounces-272976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:59:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E300353B35
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FDB53003ED0
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D8436EA8D;
	Sun, 29 Mar 2026 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="KMsRwFkB";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="iinsFRmM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCD0386C28
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774810785; cv=none; b=SmV/lGeaHUIo1m4+gttrvNdeYgj2yYIzozawjpfjQ6Us/l5ZMzBOeYDKpcAp0WENQDj2wrViGya5pGuEADJBMHTM/Cl7q2fK2I57Y7xgpxSqcFJl/4PMSyMwHu714sQ5cTsSpRKn5HpqWwsNscD7QkBTOF/PFGp5L6qZlPA5naI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774810785; c=relaxed/simple;
	bh=sd/61Inc973xL7kYJ6HmgKLWDrZiXngJj4Ng/oM4AA4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mvhOU9USwjmwFSYOafUHiJ/H2K5KzdGtzSai3oBDZTSjtC3UpWmEftokkRPcs87/TP324xJsUCuQ7txH0Ir2KGd8tMiOOFGzGlG5MEluxaEFw0J2cP6ErdboKXtxiqHllkRi0rHzocFLIHiBmOzynli8novYYO5+DJhzRO7op6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=KMsRwFkB; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=iinsFRmM; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 62TIwp1o020885;
	Sun, 29 Mar 2026 20:58:56 +0200
Received: from lubuntu-18.04 (host-82-51-149-179.retail.telecomitalia.it [82.51.149.179])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 235DF1227F3;
	Sun, 29 Mar 2026 20:58:47 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1774810727; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/AqOzHb6g5PGQtnf7a5NglJTLR1TUYS7+0Tr7E4qyo=;
	b=KMsRwFkBQUkEm7TjKVgTEGxtzf4l8vkZ4cR6Kkkih/eghl/01aq+JRvg3XTO6YhnOTjwbM
	eHCxkIhpqvrLQJDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1774810727; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/AqOzHb6g5PGQtnf7a5NglJTLR1TUYS7+0Tr7E4qyo=;
	b=iinsFRmMEeYt8ve1+C3hSo9SMwf1HGizEf1SrYy+0wVoi33qVeSDAEhtfrIswnHZInJysD
	vt08Xr4rOmWPgls3dIxlRg/6+nBWPMS5O44WOlIN6wY6Y/VEsQgt7g66CL9HTtuJESKlyr
	e6lD6lEzVeAxHfqW28Lbp3pbgasBEeNe6eXbVyW5g+8ahGFe066eF74SR024k+kiBzM78j
	wavNJr+rISeCXlbFaw9CaN7dmixhan82aDigdUNk9GOKt33LgafWD6DPOyz/PDIsW0TlnE
	w2vooqKTWNwHmYAV137sKGAcnKGrnjXXheDittDqa+eDg3AyfwyOwqxzmO8fJA==
Date: Sun, 29 Mar 2026 20:58:46 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet
 <edumazet@google.com>,
        David Lebrun <david.lebrun@uclouvain.be>,
        David
 Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        stefano.salsano@uniroma2.it,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>, ahabdels@cisco.com,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net-next v2] seg6: enable route leak for encap routes
Message-Id: <20260329205846.801e8096bb8cde3eda5ed0c1@uniroma2.it>
In-Reply-To: <20260327140709.959636-1-nicolas.dichtel@6wind.com>
References: <20260327140709.959636-1-nicolas.dichtel@6wind.com>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniroma2.it,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniroma2.it:s=ed201904,uniroma2.it:s=rsa201904];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272976-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[uniroma2.it:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,6wind.com:email]
X-Rspamd-Queue-Id: 9E300353B35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 27 Mar 2026 15:06:24 +0100
Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:

> The goal is to support x-vrf route. To avoid breaking existing setup, a new
> flag is introduced: nh-vrf.
> 
> The dev parameter is mandatory when a seg6 encap route is configured, but
> before this commit, it is ignored/not used. After the srv6 encapsulation, a
> second route lookup in the same vrf is performed.
> 
> The new nh-vrf flag specifies to use the vrf associated with the dev
> parameter to perform this second route lookup.
> 

Hi Nicolas,
 
thanks for looking into this. The use case is valid and limiting the
effect of nh-vrf to routes that explicitly carry the attribute avoids
regressions, which is good.


I have a few thoughts on the nh-vrf semantics though. The attribute
says "use the VRF of dev", but in your use case dev is not in any
VRF, so the lookup ends up in the main table as a side effect of
the loopback fallback, which is not obvious from the attribute
name. Today dev is used for source address selection in
set_tun_src() and has no routing role; nh-vrf would give it one
that does not match what actually happens.


>
> [snip]
> 
> Fixes: 6c8702c60b88 ("ipv6: sr: add support for SRH encapsulation and injection with lwtunnels")

This looks like a leftover from v1; since this is new UAPI on
net-next, the Fixes tag should not be here.


> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
> 
> v1 -> v2:
>  - target net-next instead of net
>  - add a new attribute to avoid breaking the legacy behavior
>  - use dst_dev_rcu()
> 
>  include/uapi/linux/seg6_iptunnel.h            |  1 +
>  net/ipv6/seg6_iptunnel.c                      | 23 ++++++++++--
>  .../selftests/net/srv6_end_dt46_l3vpn_test.sh | 35 +++++++++++++++++--
>  .../selftests/net/srv6_end_dt4_l3vpn_test.sh  | 33 +++++++++++++++--
>  .../selftests/net/srv6_end_dt6_l3vpn_test.sh  | 33 +++++++++++++++--
>  5 files changed, 116 insertions(+), 9 deletions(-)
> 
> diff --git a/include/uapi/linux/seg6_iptunnel.h b/include/uapi/linux/seg6_iptunnel.h
> index 485889b19900..d7d6aa2f72c5 100644
> --- a/include/uapi/linux/seg6_iptunnel.h
> +++ b/include/uapi/linux/seg6_iptunnel.h
> @@ -21,6 +21,7 @@ enum {
>  	SEG6_IPTUNNEL_UNSPEC,
>  	SEG6_IPTUNNEL_SRH,
>  	SEG6_IPTUNNEL_SRC,	/* struct in6_addr */
> +	SEG6_IPTUNNEL_NH_VRF,
>  	__SEG6_IPTUNNEL_MAX,
>  };
>  #define SEG6_IPTUNNEL_MAX (__SEG6_IPTUNNEL_MAX - 1)
> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> index e76cc0cc481e..f8c6f0d719be 100644
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c
> @@ -50,6 +50,7 @@ static size_t seg6_lwt_headroom(struct seg6_iptunnel_encap *tuninfo)
>  struct seg6_lwt {
>  	struct dst_cache cache;
>  	struct in6_addr tunsrc;
> +	bool nh_vrf;
>  	struct seg6_iptunnel_encap tuninfo[];
>  };
>  
> @@ -67,6 +68,7 @@ seg6_encap_lwtunnel(struct lwtunnel_state *lwt)
>  static const struct nla_policy seg6_iptunnel_policy[SEG6_IPTUNNEL_MAX + 1] = {
>  	[SEG6_IPTUNNEL_SRH]	= { .type = NLA_BINARY },
>  	[SEG6_IPTUNNEL_SRC]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
> +	[SEG6_IPTUNNEL_NH_VRF]	= { .type = NLA_FLAG },
>  };
>  
>  static int nla_put_srh(struct sk_buff *skb, int attrtype,
> @@ -499,9 +501,15 @@ static int seg6_input_core(struct net *net, struct sock *sk,
>  	 * now and use it later as a comparison.
>  	 */
>  	lwtst = orig_dst->lwtstate;
> -
>  	slwt = seg6_lwt_lwtunnel(lwtst);
>  
> +	if (slwt->nh_vrf) {
> +		rcu_read_lock();
> +		skb->dev = l3mdev_master_dev_rcu(dst_dev_rcu(orig_dst)) ?:
> +			dev_net(skb->dev)->loopback_dev;
> +		rcu_read_unlock();
> +	}
> +
> [snip]
>

Overwriting skb->dev alters flowi6_iif, which affects ip rule matching
on the ingress interface and changes what netfilter FORWARD sees as "in"
device. Also, seg6_output_core() never checks nh_vrf and its fl6 is
built without involving skb->dev, so this only works for forwarded
traffic. These aspects would need to be addressed in any case.


Looking at this from a different angle, specifying the FIB table ID
directly could be a more natural fit here. Something like
SEG6_IPTUNNEL_TABLE (u32) with fib6_get_table() + ip6_pol_route(),
similar to seg6_lookup_any_nexthop() in seg6_local.c.
It would work for both input and output with no need to touch skb->dev.
For example:
 
  ip -6 route add cafe::1/128 vrf vrf-100 \
      encap seg6 mode encap segs fc00::1 lookup 254 dev veth0

 
Beyond the semantics, a table ID is also more general: it covers
the main table, tables associated with VRFs, and custom tables with
the same mechanism, and keeps dev consistent with its current role
across behaviors. I think we should explore this direction before
moving forward. I am happy to help if you want.
 
Thanks,
Andrea

