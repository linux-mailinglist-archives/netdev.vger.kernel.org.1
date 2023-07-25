Return-Path: <netdev+bounces-20987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A176776215D
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24A01C20F99
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CD321D52;
	Tue, 25 Jul 2023 18:31:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB188263B8
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 18:31:47 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEF21FC2
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 11:31:46 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-583da2ac09fso35472407b3.1
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 11:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690309905; x=1690914705;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oqjuz18ttcGjx9b8kLwYZrivz3h0DnibGT47CdB0Dgw=;
        b=7BshrsM89yYT+PekZXK2TuX5o0YaxhTwNAgQn+dcPKBHcc/GniJ7KYHExZg8m5DYU2
         SM1oSnNCsYxrB6WK1O7yJe5njpEnDGYqE2r3S8wHdmVHxvCFe3pXR6y9zIWsfQ6hBFcB
         jzIb88//lvViJ9tS3K7I4dozfm7+WazYyvvxjvrNCDa/VJD39vRJNX092dOv2orbz6Fo
         FH+v/87JyzjdYzuratqv65uVlSmLNuvU/1kOma524WXh0zef5hpNQkG2Fd3cuxGfggeC
         7GShEDPkifLlhyJTS5bKaOhV6xFvcZvEk1nkY1NfsTVvYVc7qDhiUIvxVcx8ixup8rhi
         TTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690309905; x=1690914705;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqjuz18ttcGjx9b8kLwYZrivz3h0DnibGT47CdB0Dgw=;
        b=k0bM5H7hx4e99WvcvWYtylH6cS54qd9+uIA+RG7OAh7hohU3WnOLpLntvOzD0kBxWr
         RaLArEwdv7o3u4OdqX/k6l2MwoDeVP4RFl0NqFi2GqchNFmtUntnrKl40LbMKrT3+MaF
         9aLutkbe8zq8jkXglCkyvuzv8/EYubFNfPdW6vNc9JSQzqhYn1YN87libu1GEObledXq
         q7ogpFi7x7WMZj4jMoEggiaqE7j5kSFgr2rZp3MsqSlyVi5t0OPAOFwJCIjucXzZnJdz
         GWnqg6eouQpnKdYvmCZUYrNW7RDDtvhZOV7taRaO76K3x3cYjeFfgjPxQytDWWo7EkEa
         7C4g==
X-Gm-Message-State: ABy/qLavlrAm7jJCPMzv9/Yxsqx80Scm28PlTJR220Ccm4ADD0Cubv2N
	lulPfs2z+FNKJwU3mRFxIXRgg5QGbA==
X-Google-Smtp-Source: APBJJlH2TKLAObow5jnKL5pYmnfEcV+RmXKFiwlYgPgxCwjwoJaPDVEAEjnMz0o7yH5LJMb7F2M4or7+Rw==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:12d9:d7b:133f:2bfa])
 (user=prohr job=sendgmr) by 2002:a81:ca08:0:b0:577:3712:125d with SMTP id
 p8-20020a81ca08000000b005773712125dmr646ywi.4.1690309905261; Tue, 25 Jul 2023
 11:31:45 -0700 (PDT)
Date: Tue, 25 Jul 2023 11:31:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725183122.4137963-1-prohr@google.com>
Subject: [net-next] net: change accept_ra_min_rtr_lft to affect all RA lifetimes
From: Patrick Rohr <prohr@google.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, Patrick Rohr <prohr@google.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

accept_ra_min_rtr_lft only considered the lifetime of the default route
and discarded entire RAs accordingly.

This change renames accept_ra_min_rtr_lft to accept_ra_min_lft, and
applies the value to individual RA sections; in particular, router
lifetime, PIO preferred lifetime, and RIO lifetime. If any of those
lifetimes are lower than the configured value, the specific RA section
is ignored.

Fixes: 1671bcfd76fd ("net: add sysctl accept_ra_min_rtr_lft")
Signed-off-by: Patrick Rohr <prohr@google.com>
Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
---
 Documentation/networking/ip-sysctl.rst |  7 ++++---
 include/linux/ipv6.h                   |  2 +-
 include/uapi/linux/ipv6.h              |  2 +-
 net/ipv6/addrconf.c                    | 15 +++++++++-----
 net/ipv6/ndisc.c                       | 27 +++++++++++---------------
 5 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/network=
ing/ip-sysctl.rst
index 37603ad6126b..4ac892fa64da 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2288,11 +2288,12 @@ accept_ra_min_hop_limit - INTEGER
=20
 	Default: 1
=20
-accept_ra_min_rtr_lft - INTEGER
+accept_ra_min_lft - INTEGER
 	Minimum acceptable router lifetime in Router Advertisement.
=20
-	RAs with a router lifetime less than this value shall be
-	ignored. RAs with a router lifetime of 0 are unaffected.
+	RAs sections with a router lifetime, PIO preferred lifetime,
+	or RIO lifetime less than this value shall be ignored. Zero
+	lifetimes stay unaffected.
=20
 	Default: 0
=20
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 0295b47c10a3..5883551b1ee8 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -33,7 +33,7 @@ struct ipv6_devconf {
 	__s32		accept_ra_defrtr;
 	__u32		ra_defrtr_metric;
 	__s32		accept_ra_min_hop_limit;
-	__s32		accept_ra_min_rtr_lft;
+	__s32		accept_ra_min_lft;
 	__s32		accept_ra_pinfo;
 	__s32		ignore_routes_with_linkdown;
 #ifdef CONFIG_IPV6_ROUTER_PREF
diff --git a/include/uapi/linux/ipv6.h b/include/uapi/linux/ipv6.h
index 8b6bcbf6ed4a..cf592d7b630f 100644
--- a/include/uapi/linux/ipv6.h
+++ b/include/uapi/linux/ipv6.h
@@ -198,7 +198,7 @@ enum {
 	DEVCONF_IOAM6_ID_WIDE,
 	DEVCONF_NDISC_EVICT_NOCARRIER,
 	DEVCONF_ACCEPT_UNTRACKED_NA,
-	DEVCONF_ACCEPT_RA_MIN_RTR_LFT,
+	DEVCONF_ACCEPT_RA_MIN_LFT,
 	DEVCONF_MAX
 };
=20
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 19eb4b3d26ea..c7549bd9f1b7 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -202,7 +202,7 @@ static struct ipv6_devconf ipv6_devconf __read_mostly =
=3D {
 	.ra_defrtr_metric	=3D IP6_RT_PRIO_USER,
 	.accept_ra_from_local	=3D 0,
 	.accept_ra_min_hop_limit=3D 1,
-	.accept_ra_min_rtr_lft	=3D 0,
+	.accept_ra_min_lft	=3D 0,
 	.accept_ra_pinfo	=3D 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	=3D 1,
@@ -263,7 +263,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_mos=
tly =3D {
 	.ra_defrtr_metric	=3D IP6_RT_PRIO_USER,
 	.accept_ra_from_local	=3D 0,
 	.accept_ra_min_hop_limit=3D 1,
-	.accept_ra_min_rtr_lft	=3D 0,
+	.accept_ra_min_lft	=3D 0,
 	.accept_ra_pinfo	=3D 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	=3D 1,
@@ -2727,6 +2727,11 @@ void addrconf_prefix_rcv(struct net_device *dev, u8 =
*opt, int len, bool sllao)
 		return;
 	}
=20
+	if (valid_lft !=3D 0 && valid_lft < in6_dev->cnf.accept_ra_min_lft) {
+		net_info_ratelimited("addrconf: prefix option lifetime too short\n");
+		return;
+	}
+
 	/*
 	 *	Two things going on here:
 	 *	1) Add routes for on-link prefixes
@@ -5598,7 +5603,7 @@ static inline void ipv6_store_devconf(struct ipv6_dev=
conf *cnf,
 	array[DEVCONF_IOAM6_ID_WIDE] =3D cnf->ioam6_id_wide;
 	array[DEVCONF_NDISC_EVICT_NOCARRIER] =3D cnf->ndisc_evict_nocarrier;
 	array[DEVCONF_ACCEPT_UNTRACKED_NA] =3D cnf->accept_untracked_na;
-	array[DEVCONF_ACCEPT_RA_MIN_RTR_LFT] =3D cnf->accept_ra_min_rtr_lft;
+	array[DEVCONF_ACCEPT_RA_MIN_LFT] =3D cnf->accept_ra_min_lft;
 }
=20
 static inline size_t inet6_ifla6_size(void)
@@ -6793,8 +6798,8 @@ static const struct ctl_table addrconf_sysctl[] =3D {
 		.proc_handler	=3D proc_dointvec,
 	},
 	{
-		.procname	=3D "accept_ra_min_rtr_lft",
-		.data		=3D &ipv6_devconf.accept_ra_min_rtr_lft,
+		.procname	=3D "accept_ra_min_lft",
+		.data		=3D &ipv6_devconf.accept_ra_min_lft,
 		.maxlen		=3D sizeof(int),
 		.mode		=3D 0644,
 		.proc_handler	=3D proc_dointvec,
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 29ddad1c1a2f..eeb60888187f 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1280,8 +1280,6 @@ static enum skb_drop_reason ndisc_router_discovery(st=
ruct sk_buff *skb)
 	if (!ndisc_parse_options(skb->dev, opt, optlen, &ndopts))
 		return SKB_DROP_REASON_IPV6_NDISC_BAD_OPTIONS;
=20
-	lifetime =3D ntohs(ra_msg->icmph.icmp6_rt_lifetime);
-
 	if (!ipv6_accept_ra(in6_dev)) {
 		ND_PRINTK(2, info,
 			  "RA: %s, did not accept ra for dev: %s\n",
@@ -1289,13 +1287,6 @@ static enum skb_drop_reason ndisc_router_discovery(s=
truct sk_buff *skb)
 		goto skip_linkparms;
 	}
=20
-	if (lifetime !=3D 0 && lifetime < in6_dev->cnf.accept_ra_min_rtr_lft) {
-		ND_PRINTK(2, info,
-			  "RA: router lifetime (%ds) is too short: %s\n",
-			  lifetime, skb->dev->name);
-		goto skip_linkparms;
-	}
-
 #ifdef CONFIG_IPV6_NDISC_NODETYPE
 	/* skip link-specific parameters from interior routers */
 	if (skb->ndisc_nodetype =3D=3D NDISC_NODETYPE_NODEFAULT) {
@@ -1336,6 +1327,14 @@ static enum skb_drop_reason ndisc_router_discovery(s=
truct sk_buff *skb)
 		goto skip_defrtr;
 	}
=20
+	lifetime =3D ntohs(ra_msg->icmph.icmp6_rt_lifetime);
+	if (lifetime !=3D 0 && lifetime < in6_dev->cnf.accept_ra_min_lft) {
+		ND_PRINTK(2, info,
+			  "RA: router lifetime (%ds) is too short: %s\n",
+			  lifetime, skb->dev->name);
+		goto skip_defrtr;
+	}
+
 	/* Do not accept RA with source-addr found on local machine unless
 	 * accept_ra_from_local is set to true.
 	 */
@@ -1499,13 +1498,6 @@ static enum skb_drop_reason ndisc_router_discovery(s=
truct sk_buff *skb)
 		goto out;
 	}
=20
-	if (lifetime !=3D 0 && lifetime < in6_dev->cnf.accept_ra_min_rtr_lft) {
-		ND_PRINTK(2, info,
-			  "RA: router lifetime (%ds) is too short: %s\n",
-			  lifetime, skb->dev->name);
-		goto out;
-	}
-
 #ifdef CONFIG_IPV6_ROUTE_INFO
 	if (!in6_dev->cnf.accept_ra_from_local &&
 	    ipv6_chk_addr(dev_net(in6_dev->dev), &ipv6_hdr(skb)->saddr,
@@ -1530,6 +1522,9 @@ static enum skb_drop_reason ndisc_router_discovery(st=
ruct sk_buff *skb)
 			if (ri->prefix_len =3D=3D 0 &&
 			    !in6_dev->cnf.accept_ra_defrtr)
 				continue;
+			if (ri->lifetime !=3D 0 &&
+			    ntohl(ri->lifetime) < in6_dev->cnf.accept_ra_min_lft)
+				continue;
 			if (ri->prefix_len < in6_dev->cnf.accept_ra_rt_info_min_plen)
 				continue;
 			if (ri->prefix_len > in6_dev->cnf.accept_ra_rt_info_max_plen)
--=20
2.41.0.487.g6d72f3e995-goog


