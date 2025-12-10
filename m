Return-Path: <netdev+bounces-244240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5C2CB2BEA
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 11:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0942B305D87F
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 10:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A608B320CA2;
	Wed, 10 Dec 2025 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="sYShPNOl";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="ZepwZIFv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A724F31DD97
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765364008; cv=none; b=U16ZeOnCP/6/auNZm1a1xm1lI/ngN3cOHol8SsobSyqSN5D6pY9GDeTIsAF66rk3x8bb67IKuxCcVwPRcNOCXcYiYle09Ml40M1enPME6L8HPFTO26+LqE1pQfrZYHST8YydlsHJiK/XOCCZQXkrTL4tP+sGHRayUE19NH1Z7jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765364008; c=relaxed/simple;
	bh=/XJn5jRvi2GE9ViiRgim+Rwk+2AG+eFvijAbnyxnceo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oYyeDLvHY6uFWFbKX0LAzKJC6Bmt84I6wJ9ZS6kCqR997w+NxR4MP5O60ZsdsrrNBrC0/BqgWe4JxT25jWpzoDvD2XLrCdVedN+wg/73HZHxIDH7qWXHq5TdSURx4ajT49Mq6ilUmInuZGth+L8tG99YVdjFaGVvp6lj79+iF5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=sYShPNOl; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=ZepwZIFv; arc=none smtp.client-ip=160.80.4.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 5BAAbpiI026440;
	Wed, 10 Dec 2025 11:37:56 +0100
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 0B3A91200C8;
	Wed, 10 Dec 2025 11:37:46 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1765363066; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UuNqIWykEr0Ni66ziW4FKonsmxsk71iUJtcVs/S/iB8=;
	b=sYShPNOlNFnIw43kW+42RpnwTrxx+9Tmk8bpmSPw9RhbmLFFyxrpcVB9GJRsuUK32E5Jqb
	8l/L9qYBL9Dyo7Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1765363066; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UuNqIWykEr0Ni66ziW4FKonsmxsk71iUJtcVs/S/iB8=;
	b=ZepwZIFvYI7oXpT2iWJORNoY7gk9HmOvI2Q57RzJe8zaZv0WMV09xri00wmdSt4nKtH5Ry
	eL5ye1mTjUxDgORwqmqabGfNirX4Paz9hl0QnniZROaiog9gvHK+5Nor9uXQdbHzjRnKMx
	kTd4kxFk5kOqyssaPXCx1r2sz2NNYvHEmNstv1T66slSlv8LEUU6E5gOwYICpMRUSianog
	k/lo07SGEJUxZyv09e2/avzVOeO+ZNXuD0Type7Rfr5a4sBGY5aXc9EXpgI2LzEu/I9Xk+
	rGT7QLhd7Hp1AnVhAVRry6ovZnTxyaNRHuyIqP8UAS8yaBQ2zUd/hVeyY0MBNA==
Date: Wed, 10 Dec 2025 11:37:45 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet
 <edumazet@google.com>,
        David Lebrun <david.lebrun@uclouvain.be>,
        Paolo
 Lungaroni <paolo.lungaroni@uniroma2.it>,
        David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        stefano.salsano@uniroma2.it, Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net] seg6: fix route leak for encap routes
Message-Id: <20251210113745.145c55825034b2fe98522860@uniroma2.it>
In-Reply-To: <20251208102434.3379379-1-nicolas.dichtel@6wind.com>
References: <20251208102434.3379379-1-nicolas.dichtel@6wind.com>
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

On Mon,  8 Dec 2025 11:24:34 +0100
Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:

> The goal is to take into account the device used to set up the route.
> Before this commit, it was mandatory but ignored. After encapsulation, a
> second route lookup is performed using the encapsulated IPv6 address.
> This route lookup is now done in the vrf where the route device is set.
> 

Hi Nicolas,

I've got your point. However, I'm still concerned about the implications of
using the *dev* field in the root lookup. This field has been ignored for this
purpose so far, so some existing configurations/scripts may need to be adapted
to work again. The adjustments made to the self-tests below show what might
happen.


> The l3vpn tests show the inconsistency; they are updated to reflect the
> fix. Before the commit, the route to 'fc00:21:100::6046' was put in the
> vrf-100 table while the encap route was pointing to veth0, which is not
> associated with a vrf.
> 
> Before:
> > $ ip -n rt_2-Rh5GP7 -6 r list vrf vrf-100 | grep fc00:21:100::6046
> > cafe::1  encap seg6 mode encap segs 1 [ fc00:21:100::6046 ] dev veth0 metric 1024 pref medium
> > fc00:21:100::6046 via fd00::1 dev veth0 metric 1024 pref medium
> 
> After:
> > $ ip -n rt_2-Rh5GP7 -6 r list vrf vrf-100 | grep fc00:21:100::6046
> > cafe::1  encap seg6 mode encap segs 1 [ fc00:21:100::6046 ] dev veth0 metric 1024 pref medium
> > $ ip -n rt_2-Rh5GP7 -6 r list | grep fc00:21:100::6046
> > fc00:21:100::6046 via fd00::1 dev veth0 metric 1024 pref medium
> 
> Fixes: 6c8702c60b88 ("ipv6: sr: add support for SRH encapsulation and injection with lwtunnels")
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
>  net/ipv6/seg6_iptunnel.c                                | 6 ++++++
>  tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh | 2 +-
>  tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh  | 2 +-
>  tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh  | 2 +-
>  4 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> index 3e1b9991131a..9535aea28357 100644
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c
> @@ -484,6 +484,12 @@ static int seg6_input_core(struct net *net, struct sock *sk,
>  	 * now and use it later as a comparison.
>  	 */
>  	lwtst = orig_dst->lwtstate;
> +	if (orig_dst->dev) {

When can 'orig_dst->dev' be NULL in this context?


> +		rcu_read_lock();
> +		skb->dev = l3mdev_master_dev_rcu(orig_dst->dev) ?:
> +			dev_net(skb->dev)->loopback_dev;
> +		rcu_read_unlock();
> +	}
>  
>  	slwt = seg6_lwt_lwtunnel(lwtst);
>  
> diff --git a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
> index a5e959a080bb..682fb5b4509d 100755
> --- a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
> +++ b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
> @@ -333,7 +333,7 @@ setup_vpn_config()
>  		encap seg6 mode encap segs ${vpn_sid} dev veth0
>  	ip -netns ${rtsrc_name} -4 route add ${IPv4_HS_NETWORK}.${hsdst}/32 vrf vrf-${tid} \
>  		encap seg6 mode encap segs ${vpn_sid} dev veth0
> -	ip -netns ${rtsrc_name} -6 route add ${vpn_sid}/128 vrf vrf-${tid} \
> +	ip -netns ${rtsrc_name} -6 route add ${vpn_sid}/128 \
>  		via fd00::${rtdst} dev veth0
>  
>  	# set the decap route for decapsulating packets which arrive from
> diff --git a/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh
> index a649dba3cb77..11f693c65169 100755
> --- a/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh
> +++ b/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh
> @@ -287,7 +287,7 @@ setup_vpn_config()
>  	# host hssrc and destined to the access router rtsrc.
>  	ip -netns ${rtsrc_name} -4 route add ${IPv4_HS_NETWORK}.${hsdst}/32 vrf vrf-${tid} \
>  		encap seg6 mode encap segs ${vpn_sid} dev veth0
> -	ip -netns ${rtsrc_name} -6 route add ${vpn_sid}/128 vrf vrf-${tid} \
> +	ip -netns ${rtsrc_name} -6 route add ${vpn_sid}/128 \
>  		via fd00::${rtdst} dev veth0
>  
>  	# set the decap route for decapsulating packets which arrive from
> diff --git a/tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh
> index e408406d8489..7d7e056c645c 100755
> --- a/tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh
> +++ b/tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh
> @@ -297,7 +297,7 @@ setup_vpn_config()
>  	# host hssrc and destined to the access router rtsrc.
>  	ip -netns ${rtsrc_name} -6 route add ${IPv6_HS_NETWORK}::${hsdst}/128 vrf vrf-${tid} \
>  		encap seg6 mode encap segs ${vpn_sid} dev veth0
> -	ip -netns ${rtsrc_name} -6 route add ${vpn_sid}/128 vrf vrf-${tid} \
> +	ip -netns ${rtsrc_name} -6 route add ${vpn_sid}/128 \
>  		via fd00::${rtdst} dev veth0
>  
>  	# set the decap route for decapsulating packets which arrive from
> -- 
> 2.47.1
> 

Thanks,
Andrea

