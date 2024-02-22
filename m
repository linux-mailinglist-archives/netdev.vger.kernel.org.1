Return-Path: <netdev+bounces-73933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9A685F613
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CDFA1F25E25
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 10:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33643C480;
	Thu, 22 Feb 2024 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LvlUcLR7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A948E42078
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599029; cv=none; b=h8n0VN01dgmLerM2GWhxRUy26OgH86SINTATNDyU0fS6ecHahaznGmGe3GE3VBjrq9MA/gGNzpXXVaQss8tiS/zeSpK7B03JA7fsZdU3zIXQEDV8r3yB09MM/gcx5Rm021GZimuO/qZ9znxmzUcTn9OxhDGwcbo6b0sLtqitfls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599029; c=relaxed/simple;
	bh=fcmBwIN58IJiOTUEkR60uxcVdVJsSDOo5yd3gkSEC7I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fBHW32ig48EmxylHId91I0aCcHA7r8qU3+0RrVp7qw85ixjk1849N4R+NqOqfcBeUWdOj0WWnbdZAsKiITyTVn9hAeMsaRawg9Ol9fwHZWKcAW8eZHWKcIvERu6rD+yf8D76El/QfYHaUx1aEpsSI5rb35bh0KXSk7MzBigUYeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LvlUcLR7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5efe82b835fso171540257b3.0
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 02:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708599026; x=1709203826; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gObX+menG7WcbaSJNBmjWE+0+fNG0eboaHUR8hglJLs=;
        b=LvlUcLR7MDX7xsBTOrwEceTtSsi6bi3v4NJbD2TLENfGPkf5r2Y5hAvq4TVm++9FuM
         6+iwOoAesTvj3lhbDWDOwbGApmh9YTCr45/fNRSdQyq2YDcJdvSrzuLjCzLOrAfz2C9u
         74gaIF8JfSWAd7NocvThiBimvotFfPrQrZz1ndOmHxldfVMDJmH7UlT98/UiP016YjSG
         WCnAsY3CqWjplsA926yiXdI2GoA/vW878SmH3MqQP7rs3Ph9IZXvPuJX6ygQPeRQB1YM
         2z5lY4khL59xk0xhyPSagWO2J7nOFnU9Dqx+RFdIF+IdEv2BSMPZFawTJRhNFDEinIhm
         TmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599026; x=1709203826;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gObX+menG7WcbaSJNBmjWE+0+fNG0eboaHUR8hglJLs=;
        b=L4E7hIXTCBSgqQ6Pt0tAKCbdtr1hzOkggqAhYI5GuH6gOl/s6q8GvtwaCLBECRtxSb
         vpx4SXOHaAF6lFm5dxL3bi4pnyrDYlW5GBXLXRv/Cd5iC5FTzsNGMU3AuBuX1E6YYYfL
         5QfSGl8ri2s1T1IQJy/zfGCwpy3o3QbdYKqYUvHEzGjjOW04j7tsn44qr68jGqilzW35
         Vj/URsZx68MId/W8S+WVOPAoSB+xaUvWgNkgG8IyEI7UisV/d2IoZh3nk1sysLTD+wWb
         U4RE1YpUZT3BVLk7TaOY/wO/eq2zWYK24k8RG7h4x5wB1BGE7QekRNJKTaMN24/2BxJ7
         qDPA==
X-Gm-Message-State: AOJu0Yx7KU9o2CsZ+7xLKizJLl/H6pI7zT3vAB5IY7505YWDCj1Cp/ca
	MWIHoKkZ2JFzuNJtbWY2KmdqSMS56MV+HBe2yevWkiqoM/GrbLFuDw+vK//9nOGhdOSlo/OhZEy
	90sxgJEhryg==
X-Google-Smtp-Source: AGHT+IElmZKaA0bbKvqMp8wWvSvYVvRh/4tCOCbPXsQFcPIPMjc97w8DdFI1Wnvmv7vxKQeqD+FL9UOhggwzrQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:9009:0:b0:dc7:9218:df47 with SMTP id
 s9-20020a259009000000b00dc79218df47mr545652ybl.5.1708599026561; Thu, 22 Feb
 2024 02:50:26 -0800 (PST)
Date: Thu, 22 Feb 2024 10:50:09 +0000
In-Reply-To: <20240222105021.1943116-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240222105021.1943116-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240222105021.1943116-3-edumazet@google.com>
Subject: [PATCH v2 net-next 02/14] ipv6: prepare inet6_fill_ifla6_attrs() for RCU
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We want to no longer hold RTNL while calling inet6_fill_ifla6_attrs()
in the future. Add needed READ_ONCE()/WRITE_ONCE() annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/addrconf.c | 163 ++++++++++++++++++++++++--------------------
 net/ipv6/ndisc.c    |   2 +-
 2 files changed, 90 insertions(+), 75 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index d3f4b7b9cf1fe380757225a110153fbad51bf763..3c8bdad0105dc9542489b612890ba86de9c44bdc 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3477,7 +3477,8 @@ static void addrconf_dev_config(struct net_device *dev)
 	/* this device type has no EUI support */
 	if (dev->type == ARPHRD_NONE &&
 	    idev->cnf.addr_gen_mode == IN6_ADDR_GEN_MODE_EUI64)
-		idev->cnf.addr_gen_mode = IN6_ADDR_GEN_MODE_RANDOM;
+		WRITE_ONCE(idev->cnf.addr_gen_mode,
+			   IN6_ADDR_GEN_MODE_RANDOM);
 
 	addrconf_addr_gen(idev, false);
 }
@@ -3749,7 +3750,7 @@ static int addrconf_notify(struct notifier_block *this, unsigned long event,
 				rt6_mtu_change(dev, dev->mtu);
 				idev->cnf.mtu6 = dev->mtu;
 			}
-			idev->tstamp = jiffies;
+			WRITE_ONCE(idev->tstamp, jiffies);
 			inet6_ifinfo_notify(RTM_NEWLINK, idev);
 
 			/*
@@ -3991,7 +3992,7 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
 		ipv6_mc_down(idev);
 	}
 
-	idev->tstamp = jiffies;
+	WRITE_ONCE(idev->tstamp, jiffies);
 	idev->ra_mtu = 0;
 
 	/* Last: Shot the device (if unregistered) */
@@ -5619,87 +5620,97 @@ static void inet6_ifa_notify(int event, struct inet6_ifaddr *ifa)
 		rtnl_set_sk_err(net, RTNLGRP_IPV6_IFADDR, err);
 }
 
-static inline void ipv6_store_devconf(struct ipv6_devconf *cnf,
-				__s32 *array, int bytes)
+static void ipv6_store_devconf(const struct ipv6_devconf *cnf,
+			       __s32 *array, int bytes)
 {
 	BUG_ON(bytes < (DEVCONF_MAX * 4));
 
 	memset(array, 0, bytes);
-	array[DEVCONF_FORWARDING] = cnf->forwarding;
-	array[DEVCONF_HOPLIMIT] = cnf->hop_limit;
-	array[DEVCONF_MTU6] = cnf->mtu6;
-	array[DEVCONF_ACCEPT_RA] = cnf->accept_ra;
-	array[DEVCONF_ACCEPT_REDIRECTS] = cnf->accept_redirects;
-	array[DEVCONF_AUTOCONF] = cnf->autoconf;
-	array[DEVCONF_DAD_TRANSMITS] = cnf->dad_transmits;
-	array[DEVCONF_RTR_SOLICITS] = cnf->rtr_solicits;
+	array[DEVCONF_FORWARDING] = READ_ONCE(cnf->forwarding);
+	array[DEVCONF_HOPLIMIT] = READ_ONCE(cnf->hop_limit);
+	array[DEVCONF_MTU6] = READ_ONCE(cnf->mtu6);
+	array[DEVCONF_ACCEPT_RA] = READ_ONCE(cnf->accept_ra);
+	array[DEVCONF_ACCEPT_REDIRECTS] = READ_ONCE(cnf->accept_redirects);
+	array[DEVCONF_AUTOCONF] = READ_ONCE(cnf->autoconf);
+	array[DEVCONF_DAD_TRANSMITS] = READ_ONCE(cnf->dad_transmits);
+	array[DEVCONF_RTR_SOLICITS] = READ_ONCE(cnf->rtr_solicits);
 	array[DEVCONF_RTR_SOLICIT_INTERVAL] =
-		jiffies_to_msecs(cnf->rtr_solicit_interval);
+		jiffies_to_msecs(READ_ONCE(cnf->rtr_solicit_interval));
 	array[DEVCONF_RTR_SOLICIT_MAX_INTERVAL] =
-		jiffies_to_msecs(cnf->rtr_solicit_max_interval);
+		jiffies_to_msecs(READ_ONCE(cnf->rtr_solicit_max_interval));
 	array[DEVCONF_RTR_SOLICIT_DELAY] =
-		jiffies_to_msecs(cnf->rtr_solicit_delay);
-	array[DEVCONF_FORCE_MLD_VERSION] = cnf->force_mld_version;
+		jiffies_to_msecs(READ_ONCE(cnf->rtr_solicit_delay));
+	array[DEVCONF_FORCE_MLD_VERSION] = READ_ONCE(cnf->force_mld_version);
 	array[DEVCONF_MLDV1_UNSOLICITED_REPORT_INTERVAL] =
-		jiffies_to_msecs(cnf->mldv1_unsolicited_report_interval);
+		jiffies_to_msecs(READ_ONCE(cnf->mldv1_unsolicited_report_interval));
 	array[DEVCONF_MLDV2_UNSOLICITED_REPORT_INTERVAL] =
-		jiffies_to_msecs(cnf->mldv2_unsolicited_report_interval);
-	array[DEVCONF_USE_TEMPADDR] = cnf->use_tempaddr;
-	array[DEVCONF_TEMP_VALID_LFT] = cnf->temp_valid_lft;
-	array[DEVCONF_TEMP_PREFERED_LFT] = cnf->temp_prefered_lft;
-	array[DEVCONF_REGEN_MAX_RETRY] = cnf->regen_max_retry;
-	array[DEVCONF_MAX_DESYNC_FACTOR] = cnf->max_desync_factor;
-	array[DEVCONF_MAX_ADDRESSES] = cnf->max_addresses;
-	array[DEVCONF_ACCEPT_RA_DEFRTR] = cnf->accept_ra_defrtr;
-	array[DEVCONF_RA_DEFRTR_METRIC] = cnf->ra_defrtr_metric;
-	array[DEVCONF_ACCEPT_RA_MIN_HOP_LIMIT] = cnf->accept_ra_min_hop_limit;
-	array[DEVCONF_ACCEPT_RA_PINFO] = cnf->accept_ra_pinfo;
+		jiffies_to_msecs(READ_ONCE(cnf->mldv2_unsolicited_report_interval));
+	array[DEVCONF_USE_TEMPADDR] = READ_ONCE(cnf->use_tempaddr);
+	array[DEVCONF_TEMP_VALID_LFT] = READ_ONCE(cnf->temp_valid_lft);
+	array[DEVCONF_TEMP_PREFERED_LFT] = READ_ONCE(cnf->temp_prefered_lft);
+	array[DEVCONF_REGEN_MAX_RETRY] = READ_ONCE(cnf->regen_max_retry);
+	array[DEVCONF_MAX_DESYNC_FACTOR] = READ_ONCE(cnf->max_desync_factor);
+	array[DEVCONF_MAX_ADDRESSES] = READ_ONCE(cnf->max_addresses);
+	array[DEVCONF_ACCEPT_RA_DEFRTR] = READ_ONCE(cnf->accept_ra_defrtr);
+	array[DEVCONF_RA_DEFRTR_METRIC] = READ_ONCE(cnf->ra_defrtr_metric);
+	array[DEVCONF_ACCEPT_RA_MIN_HOP_LIMIT] =
+		READ_ONCE(cnf->accept_ra_min_hop_limit);
+	array[DEVCONF_ACCEPT_RA_PINFO] = READ_ONCE(cnf->accept_ra_pinfo);
 #ifdef CONFIG_IPV6_ROUTER_PREF
-	array[DEVCONF_ACCEPT_RA_RTR_PREF] = cnf->accept_ra_rtr_pref;
+	array[DEVCONF_ACCEPT_RA_RTR_PREF] = READ_ONCE(cnf->accept_ra_rtr_pref);
 	array[DEVCONF_RTR_PROBE_INTERVAL] =
-		jiffies_to_msecs(cnf->rtr_probe_interval);
+		jiffies_to_msecs(READ_ONCE(cnf->rtr_probe_interval));
 #ifdef CONFIG_IPV6_ROUTE_INFO
-	array[DEVCONF_ACCEPT_RA_RT_INFO_MIN_PLEN] = cnf->accept_ra_rt_info_min_plen;
-	array[DEVCONF_ACCEPT_RA_RT_INFO_MAX_PLEN] = cnf->accept_ra_rt_info_max_plen;
+	array[DEVCONF_ACCEPT_RA_RT_INFO_MIN_PLEN] =
+		READ_ONCE(cnf->accept_ra_rt_info_min_plen);
+	array[DEVCONF_ACCEPT_RA_RT_INFO_MAX_PLEN] =
+		READ_ONCE(cnf->accept_ra_rt_info_max_plen);
 #endif
 #endif
-	array[DEVCONF_PROXY_NDP] = cnf->proxy_ndp;
-	array[DEVCONF_ACCEPT_SOURCE_ROUTE] = cnf->accept_source_route;
+	array[DEVCONF_PROXY_NDP] = READ_ONCE(cnf->proxy_ndp);
+	array[DEVCONF_ACCEPT_SOURCE_ROUTE] =
+		READ_ONCE(cnf->accept_source_route);
 #ifdef CONFIG_IPV6_OPTIMISTIC_DAD
-	array[DEVCONF_OPTIMISTIC_DAD] = cnf->optimistic_dad;
-	array[DEVCONF_USE_OPTIMISTIC] = cnf->use_optimistic;
+	array[DEVCONF_OPTIMISTIC_DAD] = READ_ONCE(cnf->optimistic_dad);
+	array[DEVCONF_USE_OPTIMISTIC] = READ_ONCE(cnf->use_optimistic);
 #endif
 #ifdef CONFIG_IPV6_MROUTE
 	array[DEVCONF_MC_FORWARDING] = atomic_read(&cnf->mc_forwarding);
 #endif
-	array[DEVCONF_DISABLE_IPV6] = cnf->disable_ipv6;
-	array[DEVCONF_ACCEPT_DAD] = cnf->accept_dad;
-	array[DEVCONF_FORCE_TLLAO] = cnf->force_tllao;
-	array[DEVCONF_NDISC_NOTIFY] = cnf->ndisc_notify;
-	array[DEVCONF_SUPPRESS_FRAG_NDISC] = cnf->suppress_frag_ndisc;
-	array[DEVCONF_ACCEPT_RA_FROM_LOCAL] = cnf->accept_ra_from_local;
-	array[DEVCONF_ACCEPT_RA_MTU] = cnf->accept_ra_mtu;
-	array[DEVCONF_IGNORE_ROUTES_WITH_LINKDOWN] = cnf->ignore_routes_with_linkdown;
+	array[DEVCONF_DISABLE_IPV6] = READ_ONCE(cnf->disable_ipv6);
+	array[DEVCONF_ACCEPT_DAD] = READ_ONCE(cnf->accept_dad);
+	array[DEVCONF_FORCE_TLLAO] = READ_ONCE(cnf->force_tllao);
+	array[DEVCONF_NDISC_NOTIFY] = READ_ONCE(cnf->ndisc_notify);
+	array[DEVCONF_SUPPRESS_FRAG_NDISC] =
+		READ_ONCE(cnf->suppress_frag_ndisc);
+	array[DEVCONF_ACCEPT_RA_FROM_LOCAL] =
+		READ_ONCE(cnf->accept_ra_from_local);
+	array[DEVCONF_ACCEPT_RA_MTU] = READ_ONCE(cnf->accept_ra_mtu);
+	array[DEVCONF_IGNORE_ROUTES_WITH_LINKDOWN] =
+		READ_ONCE(cnf->ignore_routes_with_linkdown);
 	/* we omit DEVCONF_STABLE_SECRET for now */
-	array[DEVCONF_USE_OIF_ADDRS_ONLY] = cnf->use_oif_addrs_only;
-	array[DEVCONF_DROP_UNICAST_IN_L2_MULTICAST] = cnf->drop_unicast_in_l2_multicast;
-	array[DEVCONF_DROP_UNSOLICITED_NA] = cnf->drop_unsolicited_na;
-	array[DEVCONF_KEEP_ADDR_ON_DOWN] = cnf->keep_addr_on_down;
-	array[DEVCONF_SEG6_ENABLED] = cnf->seg6_enabled;
+	array[DEVCONF_USE_OIF_ADDRS_ONLY] = READ_ONCE(cnf->use_oif_addrs_only);
+	array[DEVCONF_DROP_UNICAST_IN_L2_MULTICAST] =
+		READ_ONCE(cnf->drop_unicast_in_l2_multicast);
+	array[DEVCONF_DROP_UNSOLICITED_NA] = READ_ONCE(cnf->drop_unsolicited_na);
+	array[DEVCONF_KEEP_ADDR_ON_DOWN] = READ_ONCE(cnf->keep_addr_on_down);
+	array[DEVCONF_SEG6_ENABLED] = READ_ONCE(cnf->seg6_enabled);
 #ifdef CONFIG_IPV6_SEG6_HMAC
-	array[DEVCONF_SEG6_REQUIRE_HMAC] = cnf->seg6_require_hmac;
+	array[DEVCONF_SEG6_REQUIRE_HMAC] = READ_ONCE(cnf->seg6_require_hmac);
 #endif
-	array[DEVCONF_ENHANCED_DAD] = cnf->enhanced_dad;
-	array[DEVCONF_ADDR_GEN_MODE] = cnf->addr_gen_mode;
-	array[DEVCONF_DISABLE_POLICY] = cnf->disable_policy;
-	array[DEVCONF_NDISC_TCLASS] = cnf->ndisc_tclass;
-	array[DEVCONF_RPL_SEG_ENABLED] = cnf->rpl_seg_enabled;
-	array[DEVCONF_IOAM6_ENABLED] = cnf->ioam6_enabled;
-	array[DEVCONF_IOAM6_ID] = cnf->ioam6_id;
-	array[DEVCONF_IOAM6_ID_WIDE] = cnf->ioam6_id_wide;
-	array[DEVCONF_NDISC_EVICT_NOCARRIER] = cnf->ndisc_evict_nocarrier;
-	array[DEVCONF_ACCEPT_UNTRACKED_NA] = cnf->accept_untracked_na;
-	array[DEVCONF_ACCEPT_RA_MIN_LFT] = cnf->accept_ra_min_lft;
+	array[DEVCONF_ENHANCED_DAD] = READ_ONCE(cnf->enhanced_dad);
+	array[DEVCONF_ADDR_GEN_MODE] = READ_ONCE(cnf->addr_gen_mode);
+	array[DEVCONF_DISABLE_POLICY] = READ_ONCE(cnf->disable_policy);
+	array[DEVCONF_NDISC_TCLASS] = READ_ONCE(cnf->ndisc_tclass);
+	array[DEVCONF_RPL_SEG_ENABLED] = READ_ONCE(cnf->rpl_seg_enabled);
+	array[DEVCONF_IOAM6_ENABLED] = READ_ONCE(cnf->ioam6_enabled);
+	array[DEVCONF_IOAM6_ID] = READ_ONCE(cnf->ioam6_id);
+	array[DEVCONF_IOAM6_ID_WIDE] = READ_ONCE(cnf->ioam6_id_wide);
+	array[DEVCONF_NDISC_EVICT_NOCARRIER] =
+		READ_ONCE(cnf->ndisc_evict_nocarrier);
+	array[DEVCONF_ACCEPT_UNTRACKED_NA] =
+		READ_ONCE(cnf->accept_untracked_na);
+	array[DEVCONF_ACCEPT_RA_MIN_LFT] = READ_ONCE(cnf->accept_ra_min_lft);
 }
 
 static inline size_t inet6_ifla6_size(void)
@@ -5779,13 +5790,14 @@ static void snmp6_fill_stats(u64 *stats, struct inet6_dev *idev, int attrtype,
 static int inet6_fill_ifla6_attrs(struct sk_buff *skb, struct inet6_dev *idev,
 				  u32 ext_filter_mask)
 {
-	struct nlattr *nla;
 	struct ifla_cacheinfo ci;
+	struct nlattr *nla;
+	u32 ra_mtu;
 
-	if (nla_put_u32(skb, IFLA_INET6_FLAGS, idev->if_flags))
+	if (nla_put_u32(skb, IFLA_INET6_FLAGS, READ_ONCE(idev->if_flags)))
 		goto nla_put_failure;
 	ci.max_reasm_len = IPV6_MAXPLEN;
-	ci.tstamp = cstamp_delta(idev->tstamp);
+	ci.tstamp = cstamp_delta(READ_ONCE(idev->tstamp));
 	ci.reachable_time = jiffies_to_msecs(idev->nd_parms->reachable_time);
 	ci.retrans_time = jiffies_to_msecs(NEIGH_VAR(idev->nd_parms, RETRANS_TIME));
 	if (nla_put(skb, IFLA_INET6_CACHEINFO, sizeof(ci), &ci))
@@ -5817,11 +5829,12 @@ static int inet6_fill_ifla6_attrs(struct sk_buff *skb, struct inet6_dev *idev,
 	memcpy(nla_data(nla), idev->token.s6_addr, nla_len(nla));
 	read_unlock_bh(&idev->lock);
 
-	if (nla_put_u8(skb, IFLA_INET6_ADDR_GEN_MODE, idev->cnf.addr_gen_mode))
+	if (nla_put_u8(skb, IFLA_INET6_ADDR_GEN_MODE,
+		       READ_ONCE(idev->cnf.addr_gen_mode)))
 		goto nla_put_failure;
 
-	if (idev->ra_mtu &&
-	    nla_put_u32(skb, IFLA_INET6_RA_MTU, idev->ra_mtu))
+	ra_mtu = READ_ONCE(idev->ra_mtu);
+	if (ra_mtu && nla_put_u32(skb, IFLA_INET6_RA_MTU, ra_mtu))
 		goto nla_put_failure;
 
 	return 0;
@@ -6022,7 +6035,7 @@ static int inet6_set_link_af(struct net_device *dev, const struct nlattr *nla,
 	if (tb[IFLA_INET6_ADDR_GEN_MODE]) {
 		u8 mode = nla_get_u8(tb[IFLA_INET6_ADDR_GEN_MODE]);
 
-		idev->cnf.addr_gen_mode = mode;
+		WRITE_ONCE(idev->cnf.addr_gen_mode, mode);
 	}
 
 	return 0;
@@ -6501,7 +6514,7 @@ static int addrconf_sysctl_addr_gen_mode(struct ctl_table *ctl, int write,
 			}
 
 			if (idev->cnf.addr_gen_mode != new_val) {
-				idev->cnf.addr_gen_mode = new_val;
+				WRITE_ONCE(idev->cnf.addr_gen_mode, new_val);
 				addrconf_init_auto_addrs(idev->dev);
 			}
 		} else if (&net->ipv6.devconf_all->addr_gen_mode == ctl->data) {
@@ -6512,7 +6525,8 @@ static int addrconf_sysctl_addr_gen_mode(struct ctl_table *ctl, int write,
 				idev = __in6_dev_get(dev);
 				if (idev &&
 				    idev->cnf.addr_gen_mode != new_val) {
-					idev->cnf.addr_gen_mode = new_val;
+					WRITE_ONCE(idev->cnf.addr_gen_mode,
+						  new_val);
 					addrconf_init_auto_addrs(idev->dev);
 				}
 			}
@@ -6577,14 +6591,15 @@ static int addrconf_sysctl_stable_secret(struct ctl_table *ctl, int write,
 			struct inet6_dev *idev = __in6_dev_get(dev);
 
 			if (idev) {
-				idev->cnf.addr_gen_mode =
-					IN6_ADDR_GEN_MODE_STABLE_PRIVACY;
+				WRITE_ONCE(idev->cnf.addr_gen_mode,
+					   IN6_ADDR_GEN_MODE_STABLE_PRIVACY);
 			}
 		}
 	} else {
 		struct inet6_dev *idev = ctl->extra1;
 
-		idev->cnf.addr_gen_mode = IN6_ADDR_GEN_MODE_STABLE_PRIVACY;
+		WRITE_ONCE(idev->cnf.addr_gen_mode,
+			   IN6_ADDR_GEN_MODE_STABLE_PRIVACY);
 	}
 
 out:
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 73cb31afe93542285e3f11b7140d2cc1619006e7..8523f0595b01899a9f6cf82809c1b4bcfc233202 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1975,7 +1975,7 @@ int ndisc_ifinfo_sysctl_change(struct ctl_table *ctl, int write, void *buffer,
 		if (ctl->data == &NEIGH_VAR(idev->nd_parms, BASE_REACHABLE_TIME))
 			idev->nd_parms->reachable_time =
 					neigh_rand_reach_time(NEIGH_VAR(idev->nd_parms, BASE_REACHABLE_TIME));
-		idev->tstamp = jiffies;
+		WRITE_ONCE(idev->tstamp, jiffies);
 		inet6_ifinfo_notify(RTM_NEWLINK, idev);
 		in6_dev_put(idev);
 	}
-- 
2.44.0.rc1.240.g4c46232300-goog


