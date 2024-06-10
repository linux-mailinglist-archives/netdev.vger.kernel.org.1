Return-Path: <netdev+bounces-102146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE321901958
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 04:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D05B1281A72
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 02:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15462A38;
	Mon, 10 Jun 2024 02:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GcHietsF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C152599
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 02:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717986005; cv=none; b=UxLz4HAqnycVlOmjOwkhT/FiLa+2NDFDC+x14nrOwLPw9NMVOBq8NI0Sjyym0nLYruLpkCGIU7wUkLg+e8+9bbEhaEh/SRiJatuPC1DKJr7SO3Q7GwiQvYmb/0wdfwMr+OQD+HSJygNcJVX7cddoYNlnlwr1H9m6lQ4mKobGsi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717986005; c=relaxed/simple;
	bh=Vg2RO7ZAY9cAGSih6zNj6XYLqmvAyY+BKq5xE7Uds2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RS+usvakksvH+r6asx6qGfKkJAP5TU3hv+VEUc+xM5ZY/NwAjzx5zV/ycAvOhUxq3ge4SWUkfiV4//XEugDl096EA1MmIXgBS9RS7EB06QWb1bjZClT7i+MKvq7bzXbn1l79xArqYMSB8kXraGpub5B1izkjvvKxkFgFBNq51XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GcHietsF; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717986004; x=1749522004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vg2RO7ZAY9cAGSih6zNj6XYLqmvAyY+BKq5xE7Uds2c=;
  b=GcHietsFqEIAcvZkCVRVCCNV9GHk1N/oxyQ1urMbKS2rxgxrd4PLWcO+
   1/3CcLQehBL8KOovTLOC9/HxKtPxMmtNlo1MZ80MT0xqHzW6dJhMFWzOV
   WCyu9DjPKq1YKYag5ej1+QATBUvu170ykeklN1Ks8166SSYSrbDRtBnRM
   JJY/MSghZM7Ov6ubwKj5Oawhec+EdfsXmNDIQbaGANUALGSQwErjbIGke
   5lXBHcniCcmEBLgtpCXJM0Sm/JZm5xFuLL1fAiM9i7HcWRRnnD2fDY98B
   K8JerT8xrZzbaSQA0mmJjW6PlzGG9KeVuQz68k9AAVzUQfWIxjTN15cxH
   Q==;
X-CSE-ConnectionGUID: NsaUtr1HR/SRvVxPtHOt+Q==
X-CSE-MsgGUID: 6xX/ShU8SI+Spr8UaXnZGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="14786935"
X-IronPort-AV: E=Sophos;i="6.08,226,1712646000"; 
   d="scan'208";a="14786935"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 19:20:02 -0700
X-CSE-ConnectionGUID: +tK796aTTnqi+BE4Y9xmHg==
X-CSE-MsgGUID: p04QtYtVRVGZwLV5zMZ18Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,226,1712646000"; 
   d="scan'208";a="39581865"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 09 Jun 2024 19:19:59 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGUdY-0001ld-1M;
	Mon, 10 Jun 2024 02:19:56 +0000
Date: Mon, 10 Jun 2024 10:19:37 +0800
From: kernel test robot <lkp@intel.com>
To: Guillaume Nault <gnault@redhat.com>, David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	stephen hemminger <shemminger@vyatta.com>
Subject: Re: [PATCH net v2] vxlan: Pull inner IP header in vxlan_xmit_one().
Message-ID: <202406100922.x6iXjoXS-lkp@intel.com>
References: <a5a118807f06bded3feea4ba35168e9240c31a3b.1717690115.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5a118807f06bded3feea4ba35168e9240c31a3b.1717690115.git.gnault@redhat.com>

Hi Guillaume,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Guillaume-Nault/vxlan-Pull-inner-IP-header-in-vxlan_xmit_one/20240607-002253
base:   net/main
patch link:    https://lore.kernel.org/r/a5a118807f06bded3feea4ba35168e9240c31a3b.1717690115.git.gnault%40redhat.com
patch subject: [PATCH net v2] vxlan: Pull inner IP header in vxlan_xmit_one().
config: i386-randconfig-062-20240610 (https://download.01.org/0day-ci/archive/20240610/202406100922.x6iXjoXS-lkp@intel.com/config)
compiler: gcc-8 (Ubuntu 8.4.0-3ubuntu2) 8.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240610/202406100922.x6iXjoXS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406100922.x6iXjoXS-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/vxlan/vxlan_core.c:393:34: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] b @@     got restricted __be32 [usertype] vni @@
   drivers/net/vxlan/vxlan_core.c:393:34: sparse:     expected unsigned int [usertype] b
   drivers/net/vxlan/vxlan_core.c:393:34: sparse:     got restricted __be32 [usertype] vni
>> drivers/net/vxlan/vxlan_core.c:2358:42: sparse: sparse: restricted __be16 degrades to integer
   drivers/net/vxlan/vxlan_core.c: note: in included file (through include/net/net_namespace.h, include/linux/netdevice.h, include/net/inet_sock.h, ...):
   include/linux/skbuff.h:2743:13: sparse: sparse: self-comparison always evaluates to false

vim +2358 drivers/net/vxlan/vxlan_core.c

  2333	
  2334	void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
  2335			    __be32 default_vni, struct vxlan_rdst *rdst, bool did_rsc)
  2336	{
  2337		struct dst_cache *dst_cache;
  2338		struct ip_tunnel_info *info;
  2339		struct ip_tunnel_key *pkey;
  2340		struct ip_tunnel_key key;
  2341		struct vxlan_dev *vxlan = netdev_priv(dev);
  2342		const struct iphdr *old_iph;
  2343		struct vxlan_metadata _md;
  2344		struct vxlan_metadata *md = &_md;
  2345		unsigned int pkt_len = skb->len;
  2346		__be16 src_port = 0, dst_port;
  2347		struct dst_entry *ndst = NULL;
  2348		int addr_family;
  2349		__u8 tos, ttl;
  2350		int ifindex;
  2351		int err;
  2352		u32 flags = vxlan->cfg.flags;
  2353		bool use_cache;
  2354		bool udp_sum = false;
  2355		bool xnet = !net_eq(vxlan->net, dev_net(vxlan->dev));
  2356		__be32 vni = 0;
  2357	
> 2358		if (!(flags & VXLAN_F_GPE) || skb->protocol == ETH_P_TEB) {
  2359			if (!skb_vlan_inet_prepare(skb))
  2360				goto drop;
  2361		} else {
  2362			if (!pskb_inet_may_pull(skb))
  2363				goto drop;
  2364		}
  2365	
  2366		old_iph = ip_hdr(skb);
  2367	
  2368		info = skb_tunnel_info(skb);
  2369		use_cache = ip_tunnel_dst_cache_usable(skb, info);
  2370	
  2371		if (rdst) {
  2372			memset(&key, 0, sizeof(key));
  2373			pkey = &key;
  2374	
  2375			if (vxlan_addr_any(&rdst->remote_ip)) {
  2376				if (did_rsc) {
  2377					/* short-circuited back to local bridge */
  2378					vxlan_encap_bypass(skb, vxlan, vxlan,
  2379							   default_vni, true);
  2380					return;
  2381				}
  2382				goto drop;
  2383			}
  2384	
  2385			addr_family = vxlan->cfg.saddr.sa.sa_family;
  2386			dst_port = rdst->remote_port ? rdst->remote_port : vxlan->cfg.dst_port;
  2387			vni = (rdst->remote_vni) ? : default_vni;
  2388			ifindex = rdst->remote_ifindex;
  2389	
  2390			if (addr_family == AF_INET) {
  2391				key.u.ipv4.src = vxlan->cfg.saddr.sin.sin_addr.s_addr;
  2392				key.u.ipv4.dst = rdst->remote_ip.sin.sin_addr.s_addr;
  2393			} else {
  2394				key.u.ipv6.src = vxlan->cfg.saddr.sin6.sin6_addr;
  2395				key.u.ipv6.dst = rdst->remote_ip.sin6.sin6_addr;
  2396			}
  2397	
  2398			dst_cache = &rdst->dst_cache;
  2399			md->gbp = skb->mark;
  2400			if (flags & VXLAN_F_TTL_INHERIT) {
  2401				ttl = ip_tunnel_get_ttl(old_iph, skb);
  2402			} else {
  2403				ttl = vxlan->cfg.ttl;
  2404				if (!ttl && vxlan_addr_multicast(&rdst->remote_ip))
  2405					ttl = 1;
  2406			}
  2407			tos = vxlan->cfg.tos;
  2408			if (tos == 1)
  2409				tos = ip_tunnel_get_dsfield(old_iph, skb);
  2410			if (tos && !info)
  2411				use_cache = false;
  2412	
  2413			if (addr_family == AF_INET)
  2414				udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM_TX);
  2415			else
  2416				udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM6_TX);
  2417	#if IS_ENABLED(CONFIG_IPV6)
  2418			switch (vxlan->cfg.label_policy) {
  2419			case VXLAN_LABEL_FIXED:
  2420				key.label = vxlan->cfg.label;
  2421				break;
  2422			case VXLAN_LABEL_INHERIT:
  2423				key.label = ip_tunnel_get_flowlabel(old_iph, skb);
  2424				break;
  2425			default:
  2426				DEBUG_NET_WARN_ON_ONCE(1);
  2427				goto drop;
  2428			}
  2429	#endif
  2430		} else {
  2431			if (!info) {
  2432				WARN_ONCE(1, "%s: Missing encapsulation instructions\n",
  2433					  dev->name);
  2434				goto drop;
  2435			}
  2436			pkey = &info->key;
  2437			addr_family = ip_tunnel_info_af(info);
  2438			dst_port = info->key.tp_dst ? : vxlan->cfg.dst_port;
  2439			vni = tunnel_id_to_key32(info->key.tun_id);
  2440			ifindex = 0;
  2441			dst_cache = &info->dst_cache;
  2442			if (test_bit(IP_TUNNEL_VXLAN_OPT_BIT, info->key.tun_flags)) {
  2443				if (info->options_len < sizeof(*md))
  2444					goto drop;
  2445				md = ip_tunnel_info_opts(info);
  2446			}
  2447			ttl = info->key.ttl;
  2448			tos = info->key.tos;
  2449			udp_sum = test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags);
  2450		}
  2451		src_port = udp_flow_src_port(dev_net(dev), skb, vxlan->cfg.port_min,
  2452					     vxlan->cfg.port_max, true);
  2453	
  2454		rcu_read_lock();
  2455		if (addr_family == AF_INET) {
  2456			struct vxlan_sock *sock4 = rcu_dereference(vxlan->vn4_sock);
  2457			struct rtable *rt;
  2458			__be16 df = 0;
  2459			__be32 saddr;
  2460	
  2461			if (!ifindex)
  2462				ifindex = sock4->sock->sk->sk_bound_dev_if;
  2463	
  2464			rt = udp_tunnel_dst_lookup(skb, dev, vxlan->net, ifindex,
  2465						   &saddr, pkey, src_port, dst_port,
  2466						   tos, use_cache ? dst_cache : NULL);
  2467			if (IS_ERR(rt)) {
  2468				err = PTR_ERR(rt);
  2469				goto tx_error;
  2470			}
  2471	
  2472			if (!info) {
  2473				/* Bypass encapsulation if the destination is local */
  2474				err = encap_bypass_if_local(skb, dev, vxlan, AF_INET,
  2475							    dst_port, ifindex, vni,
  2476							    &rt->dst, rt->rt_flags);
  2477				if (err)
  2478					goto out_unlock;
  2479	
  2480				if (vxlan->cfg.df == VXLAN_DF_SET) {
  2481					df = htons(IP_DF);
  2482				} else if (vxlan->cfg.df == VXLAN_DF_INHERIT) {
  2483					struct ethhdr *eth = eth_hdr(skb);
  2484	
  2485					if (ntohs(eth->h_proto) == ETH_P_IPV6 ||
  2486					    (ntohs(eth->h_proto) == ETH_P_IP &&
  2487					     old_iph->frag_off & htons(IP_DF)))
  2488						df = htons(IP_DF);
  2489				}
  2490			} else if (test_bit(IP_TUNNEL_DONT_FRAGMENT_BIT,
  2491					    info->key.tun_flags)) {
  2492				df = htons(IP_DF);
  2493			}
  2494	
  2495			ndst = &rt->dst;
  2496			err = skb_tunnel_check_pmtu(skb, ndst, vxlan_headroom(flags & VXLAN_F_GPE),
  2497						    netif_is_any_bridge_port(dev));
  2498			if (err < 0) {
  2499				goto tx_error;
  2500			} else if (err) {
  2501				if (info) {
  2502					struct ip_tunnel_info *unclone;
  2503	
  2504					unclone = skb_tunnel_info_unclone(skb);
  2505					if (unlikely(!unclone))
  2506						goto tx_error;
  2507	
  2508					unclone->key.u.ipv4.src = pkey->u.ipv4.dst;
  2509					unclone->key.u.ipv4.dst = saddr;
  2510				}
  2511				vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
  2512				dst_release(ndst);
  2513				goto out_unlock;
  2514			}
  2515	
  2516			tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
  2517			ttl = ttl ? : ip4_dst_hoplimit(&rt->dst);
  2518			err = vxlan_build_skb(skb, ndst, sizeof(struct iphdr),
  2519					      vni, md, flags, udp_sum);
  2520			if (err < 0)
  2521				goto tx_error;
  2522	
  2523			udp_tunnel_xmit_skb(rt, sock4->sock->sk, skb, saddr,
  2524					    pkey->u.ipv4.dst, tos, ttl, df,
  2525					    src_port, dst_port, xnet, !udp_sum);
  2526	#if IS_ENABLED(CONFIG_IPV6)
  2527		} else {
  2528			struct vxlan_sock *sock6 = rcu_dereference(vxlan->vn6_sock);
  2529			struct in6_addr saddr;
  2530	
  2531			if (!ifindex)
  2532				ifindex = sock6->sock->sk->sk_bound_dev_if;
  2533	
  2534			ndst = udp_tunnel6_dst_lookup(skb, dev, vxlan->net, sock6->sock,
  2535						      ifindex, &saddr, pkey,
  2536						      src_port, dst_port, tos,
  2537						      use_cache ? dst_cache : NULL);
  2538			if (IS_ERR(ndst)) {
  2539				err = PTR_ERR(ndst);
  2540				ndst = NULL;
  2541				goto tx_error;
  2542			}
  2543	
  2544			if (!info) {
  2545				u32 rt6i_flags = dst_rt6_info(ndst)->rt6i_flags;
  2546	
  2547				err = encap_bypass_if_local(skb, dev, vxlan, AF_INET6,
  2548							    dst_port, ifindex, vni,
  2549							    ndst, rt6i_flags);
  2550				if (err)
  2551					goto out_unlock;
  2552			}
  2553	
  2554			err = skb_tunnel_check_pmtu(skb, ndst,
  2555						    vxlan_headroom((flags & VXLAN_F_GPE) | VXLAN_F_IPV6),
  2556						    netif_is_any_bridge_port(dev));
  2557			if (err < 0) {
  2558				goto tx_error;
  2559			} else if (err) {
  2560				if (info) {
  2561					struct ip_tunnel_info *unclone;
  2562	
  2563					unclone = skb_tunnel_info_unclone(skb);
  2564					if (unlikely(!unclone))
  2565						goto tx_error;
  2566	
  2567					unclone->key.u.ipv6.src = pkey->u.ipv6.dst;
  2568					unclone->key.u.ipv6.dst = saddr;
  2569				}
  2570	
  2571				vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
  2572				dst_release(ndst);
  2573				goto out_unlock;
  2574			}
  2575	
  2576			tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
  2577			ttl = ttl ? : ip6_dst_hoplimit(ndst);
  2578			skb_scrub_packet(skb, xnet);
  2579			err = vxlan_build_skb(skb, ndst, sizeof(struct ipv6hdr),
  2580					      vni, md, flags, udp_sum);
  2581			if (err < 0)
  2582				goto tx_error;
  2583	
  2584			udp_tunnel6_xmit_skb(ndst, sock6->sock->sk, skb, dev,
  2585					     &saddr, &pkey->u.ipv6.dst, tos, ttl,
  2586					     pkey->label, src_port, dst_port, !udp_sum);
  2587	#endif
  2588		}
  2589		vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX, pkt_len);
  2590	out_unlock:
  2591		rcu_read_unlock();
  2592		return;
  2593	
  2594	drop:
  2595		dev_core_stats_tx_dropped_inc(dev);
  2596		vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_DROPS, 0);
  2597		dev_kfree_skb(skb);
  2598		return;
  2599	
  2600	tx_error:
  2601		rcu_read_unlock();
  2602		if (err == -ELOOP)
  2603			DEV_STATS_INC(dev, collisions);
  2604		else if (err == -ENETUNREACH)
  2605			DEV_STATS_INC(dev, tx_carrier_errors);
  2606		dst_release(ndst);
  2607		DEV_STATS_INC(dev, tx_errors);
  2608		vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_ERRORS, 0);
  2609		kfree_skb(skb);
  2610	}
  2611	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

