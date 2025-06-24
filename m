Return-Path: <netdev+bounces-200819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A889BAE70A4
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 22:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C117D1BC47C1
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF272ED844;
	Tue, 24 Jun 2025 20:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUVs4Tbc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C72C2ED14F
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 20:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750796789; cv=none; b=A2rU+ZDE3b8jirzoivTksy7EybiiOkVu9CcDSQFNDyuUJIlMUTN0nua7Jr0U+b2lJOXQFP52uhKOeI3BIiNSgYef19cr+9bE9azZWhHpBWu/IkGrANldhBZqYiu8qvAVfl8abe4oAPZffkVcVj4Bq4b6JcBIplM44mAWWdTRciU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750796789; c=relaxed/simple;
	bh=CLSVZ9MSyAMTc8fGaycpbT/XLGL0Dd7FwFv7n+zFY0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XcZ7qGhgV63daXTUJbWmJxsCHfAdx2RYlWxl9juyc61onQJPxqwHEOvMGR46D2A4qVqzOf8khaVuttG0AWGL82/pqBmcmRZH2DgjqmGr61A6WKkpC+lupI6HYEoCBowqgcj1D1GD+xapRsXv9R3qtfXhQHjmQkGD5+4bE8jkPZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUVs4Tbc; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso4450473b3a.2
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 13:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750796786; x=1751401586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tty/tflgjwMsaZqaI67Q/4Rf7p76ep/ONnsbJJQcWC4=;
        b=GUVs4TbcGRMajIirUJ3hc2JVYZ9sTy6mmSI/U+1o4+OH+xGq8Jn6YzrQOGQyuHpisQ
         YtT1AURt/uLfEqZAdg2MIVMbgjfr6yzf34TTzL4F7/Oafkfzw+w/vJSQkI8THBRfmRqi
         DJYutgZKmsnEzsjLD8ZCWu97SSutjVwh5qNqXJnIYXZGkvDVaR9FNi8Ad1WR0aJxF4ja
         u7cgSaeC72nhsQGU5J4yWLVT37V2NoehBfJ0cUjVuGXB6WdLNonbAFL8vUVly/u/EYNk
         BmGFQMJ3CbDQrEvDoyodzjCIHd1wn7jkvVxzosWyKbziQvVmbJetwLCsekpqMAZF0uYp
         Vg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750796786; x=1751401586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tty/tflgjwMsaZqaI67Q/4Rf7p76ep/ONnsbJJQcWC4=;
        b=mWERuzplS9+48g8PIyBa2yUCGs8CAO0D2o/yQkLjREfeGgbG8AOmTEoqLI0dmC4RDs
         1WdYfR5FzJfHeWDVl9Gk2heyq/3QpO84Wuvps/XW/1oQ1qe7tQsUOvMN4O+lsBxDNcg/
         rDsjLWcY9zkoc9gMxwYgT3XTd3Uos3aviBaAD/3xUu+MED4StPedFFA57ri7RqbIpCgh
         qwdd1zOJiitlpO2/4DWKMjidHqjeAsszuUzsNeJ62eMaUeAugYXwAxjgtiViB78vPzs4
         QI8colPGyp7FogmiHGgVsxKVZ1er7U/WNKr8UscKHlx0zEcCDmq6ASxTTSlz4pSmNPYU
         /oVw==
X-Forwarded-Encrypted: i=1; AJvYcCWYBvhtPtNUyHnSeokCEk8lXe3w1yUqvpCiT1kHaBxvVcJZxhs1w9KUSgHP7t6yIqd4aw3fdzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTh2PKWmsFgBa5i03uZDR1wIt1fRyuk1RYvT1LFDQOYFVc5p3G
	RSZFuCN9CbWto0jIByvz6LuC+vrCot3ykSXsXYvZc/cRNzkpwPE1Y1Q=
X-Gm-Gg: ASbGncvq8n+tajn/RJdaYuvkC58sKx2F4EkMQtx259LSfDn6HG7sSs9eHndiilUKv61
	G+Sf78y7AJHG6u0rVeyes4+bFdnvJqI8NWQ9HiFfvArvL/tVy3Tlrj0BTo4iveap1BxTFRLDGyF
	5rIdt1rydcWq2KufEykik4Z/LnGzVN0VZZPs0xbNhrBCRS9SmnbsgF9l4jNg9Z3OmhgCOSb2WPJ
	ecWlOgaNQzIYVB4FlsBCzazoz1otAbsUU7e1pKs9gPvzda1Ich6WNV1B2DYFFE+4r4ty4wAhFnc
	EPsGpdJl/x4uafv3su3vnViXJKnX75NSpTltEYU=
X-Google-Smtp-Source: AGHT+IHXOdPEVwvYN/gq1TMV+j199NU6hzoDcqDiG1veS//UetmXgEIB6kfyWcGMvYcrTpdGbBS+5Q==
X-Received: by 2002:a05:6a00:2441:b0:749:14b5:921f with SMTP id d2e1a72fcca58-74ad45adbd8mr690733b3a.18.1750796786253;
        Tue, 24 Jun 2025 13:26:26 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74a9697817esm2252994b3a.124.2025.06.24.13.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 13:26:25 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v2 net-next 02/15] ipv6: mcast: Replace locking comments with lockdep annotations.
Date: Tue, 24 Jun 2025 13:24:08 -0700
Message-ID: <20250624202616.526600-3-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624202616.526600-1-kuni1840@gmail.com>
References: <20250624202616.526600-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

Commit 63ed8de4be81 ("mld: add mc_lock for protecting per-interface
mld data") added the same comments regarding locking to many functions.

Let's replace the comments with lockdep annotation, which is more helpful.

Note that we just remove the comment for mld_clear_zeros() and
mld_send_cr(), where mc_dereference() is used in the entry of the
function.

While at it, a comment for __ipv6_sock_mc_join() is moved back to the
correct place.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/mcast.c | 125 +++++++++++++++++++++++++++--------------------
 1 file changed, 71 insertions(+), 54 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 65831b4fee1f..5cd94effbc92 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -108,9 +108,9 @@ static int __ipv6_dev_mc_inc(struct net_device *dev,
 int sysctl_mld_max_msf __read_mostly = IPV6_MLD_MAX_MSF;
 int sysctl_mld_qrv __read_mostly = MLD_QRV_DEFAULT;
 
-/*
- *	socket join on multicast group
- */
+#define mc_assert_locked(idev)			\
+	lockdep_assert_held(&(idev)->mc_lock)
+
 #define mc_dereference(e, idev) \
 	rcu_dereference_protected(e, lockdep_is_held(&(idev)->mc_lock))
 
@@ -169,6 +169,9 @@ static int unsolicited_report_interval(struct inet6_dev *idev)
 	return iv > 0 ? iv : 1;
 }
 
+/*
+ *	socket join on multicast group
+ */
 static int __ipv6_sock_mc_join(struct sock *sk, int ifindex,
 			       const struct in6_addr *addr, unsigned int mode)
 {
@@ -668,12 +671,13 @@ bool inet6_mc_check(const struct sock *sk, const struct in6_addr *mc_addr,
 	return rv;
 }
 
-/* called with mc_lock */
 static void igmp6_group_added(struct ifmcaddr6 *mc)
 {
 	struct net_device *dev = mc->idev->dev;
 	char buf[MAX_ADDR_LEN];
 
+	mc_assert_locked(mc->idev);
+
 	if (IPV6_ADDR_MC_SCOPE(&mc->mca_addr) <
 	    IPV6_ADDR_SCOPE_LINKLOCAL)
 		return;
@@ -703,12 +707,13 @@ static void igmp6_group_added(struct ifmcaddr6 *mc)
 	mld_ifc_event(mc->idev);
 }
 
-/* called with mc_lock */
 static void igmp6_group_dropped(struct ifmcaddr6 *mc)
 {
 	struct net_device *dev = mc->idev->dev;
 	char buf[MAX_ADDR_LEN];
 
+	mc_assert_locked(mc->idev);
+
 	if (IPV6_ADDR_MC_SCOPE(&mc->mca_addr) <
 	    IPV6_ADDR_SCOPE_LINKLOCAL)
 		return;
@@ -729,14 +734,13 @@ static void igmp6_group_dropped(struct ifmcaddr6 *mc)
 		refcount_dec(&mc->mca_refcnt);
 }
 
-/*
- * deleted ifmcaddr6 manipulation
- * called with mc_lock
- */
+/* deleted ifmcaddr6 manipulation */
 static void mld_add_delrec(struct inet6_dev *idev, struct ifmcaddr6 *im)
 {
 	struct ifmcaddr6 *pmc;
 
+	mc_assert_locked(idev);
+
 	/* this is an "ifmcaddr6" for convenience; only the fields below
 	 * are actually used. In particular, the refcnt and users are not
 	 * used for management of the delete list. Using the same structure
@@ -770,13 +774,14 @@ static void mld_add_delrec(struct inet6_dev *idev, struct ifmcaddr6 *im)
 	rcu_assign_pointer(idev->mc_tomb, pmc);
 }
 
-/* called with mc_lock */
 static void mld_del_delrec(struct inet6_dev *idev, struct ifmcaddr6 *im)
 {
 	struct ip6_sf_list *psf, *sources, *tomb;
 	struct in6_addr *pmca = &im->mca_addr;
 	struct ifmcaddr6 *pmc, *pmc_prev;
 
+	mc_assert_locked(idev);
+
 	pmc_prev = NULL;
 	for_each_mc_tomb(idev, pmc) {
 		if (ipv6_addr_equal(&pmc->mca_addr, pmca))
@@ -813,11 +818,12 @@ static void mld_del_delrec(struct inet6_dev *idev, struct ifmcaddr6 *im)
 	}
 }
 
-/* called with mc_lock */
 static void mld_clear_delrec(struct inet6_dev *idev)
 {
 	struct ifmcaddr6 *pmc, *nextpmc;
 
+	mc_assert_locked(idev);
+
 	pmc = mc_dereference(idev->mc_tomb, idev);
 	RCU_INIT_POINTER(idev->mc_tomb, NULL);
 
@@ -874,13 +880,14 @@ static void ma_put(struct ifmcaddr6 *mc)
 	}
 }
 
-/* called with mc_lock */
 static struct ifmcaddr6 *mca_alloc(struct inet6_dev *idev,
 				   const struct in6_addr *addr,
 				   unsigned int mode)
 {
 	struct ifmcaddr6 *mc;
 
+	mc_assert_locked(idev);
+
 	mc = kzalloc(sizeof(*mc), GFP_KERNEL);
 	if (!mc)
 		return NULL;
@@ -1091,46 +1098,51 @@ bool ipv6_chk_mcast_addr(struct net_device *dev, const struct in6_addr *group,
 	return rv;
 }
 
-/* called with mc_lock */
 static void mld_gq_start_work(struct inet6_dev *idev)
 {
 	unsigned long tv = get_random_u32_below(idev->mc_maxdelay);
 
+	mc_assert_locked(idev);
+
 	idev->mc_gq_running = 1;
 	if (!mod_delayed_work(mld_wq, &idev->mc_gq_work, tv + 2))
 		in6_dev_hold(idev);
 }
 
-/* called with mc_lock */
 static void mld_gq_stop_work(struct inet6_dev *idev)
 {
+	mc_assert_locked(idev);
+
 	idev->mc_gq_running = 0;
 	if (cancel_delayed_work(&idev->mc_gq_work))
 		__in6_dev_put(idev);
 }
 
-/* called with mc_lock */
 static void mld_ifc_start_work(struct inet6_dev *idev, unsigned long delay)
 {
 	unsigned long tv = get_random_u32_below(delay);
 
+	mc_assert_locked(idev);
+
 	if (!mod_delayed_work(mld_wq, &idev->mc_ifc_work, tv + 2))
 		in6_dev_hold(idev);
 }
 
-/* called with mc_lock */
 static void mld_ifc_stop_work(struct inet6_dev *idev)
 {
+	mc_assert_locked(idev);
+
 	idev->mc_ifc_count = 0;
 	if (cancel_delayed_work(&idev->mc_ifc_work))
 		__in6_dev_put(idev);
 }
 
-/* called with mc_lock */
 static void mld_dad_start_work(struct inet6_dev *idev, unsigned long delay)
 {
 	unsigned long tv = get_random_u32_below(delay);
 
+	mc_assert_locked(idev);
+
 	if (!mod_delayed_work(mld_wq, &idev->mc_dad_work, tv + 2))
 		in6_dev_hold(idev);
 }
@@ -1155,14 +1167,13 @@ static void mld_report_stop_work(struct inet6_dev *idev)
 		__in6_dev_put(idev);
 }
 
-/*
- * IGMP handling (alias multicast ICMPv6 messages)
- * called with mc_lock
- */
+/* IGMP handling (alias multicast ICMPv6 messages) */
 static void igmp6_group_queried(struct ifmcaddr6 *ma, unsigned long resptime)
 {
 	unsigned long delay = resptime;
 
+	mc_assert_locked(ma->idev);
+
 	/* Do not start work for these addresses */
 	if (ipv6_addr_is_ll_all_nodes(&ma->mca_addr) ||
 	    IPV6_ADDR_MC_SCOPE(&ma->mca_addr) < IPV6_ADDR_SCOPE_LINKLOCAL)
@@ -1181,15 +1192,15 @@ static void igmp6_group_queried(struct ifmcaddr6 *ma, unsigned long resptime)
 	ma->mca_flags |= MAF_TIMER_RUNNING;
 }
 
-/* mark EXCLUDE-mode sources
- * called with mc_lock
- */
+/* mark EXCLUDE-mode sources */
 static bool mld_xmarksources(struct ifmcaddr6 *pmc, int nsrcs,
 			     const struct in6_addr *srcs)
 {
 	struct ip6_sf_list *psf;
 	int i, scount;
 
+	mc_assert_locked(pmc->idev);
+
 	scount = 0;
 	for_each_psf_mclock(pmc, psf) {
 		if (scount == nsrcs)
@@ -1212,13 +1223,14 @@ static bool mld_xmarksources(struct ifmcaddr6 *pmc, int nsrcs,
 	return true;
 }
 
-/* called with mc_lock */
 static bool mld_marksources(struct ifmcaddr6 *pmc, int nsrcs,
 			    const struct in6_addr *srcs)
 {
 	struct ip6_sf_list *psf;
 	int i, scount;
 
+	mc_assert_locked(pmc->idev);
+
 	if (pmc->mca_sfmode == MCAST_EXCLUDE)
 		return mld_xmarksources(pmc, nsrcs, srcs);
 
@@ -1913,7 +1925,6 @@ static struct sk_buff *add_grhead(struct sk_buff *skb, struct ifmcaddr6 *pmc,
 
 #define AVAILABLE(skb)	((skb) ? skb_availroom(skb) : 0)
 
-/* called with mc_lock */
 static struct sk_buff *add_grec(struct sk_buff *skb, struct ifmcaddr6 *pmc,
 				int type, int gdeleted, int sdeleted,
 				int crsend)
@@ -1927,6 +1938,8 @@ static struct sk_buff *add_grec(struct sk_buff *skb, struct ifmcaddr6 *pmc,
 	struct mld2_report *pmr;
 	unsigned int mtu;
 
+	mc_assert_locked(idev);
+
 	if (pmc->mca_flags & MAF_NOREPORT)
 		return skb;
 
@@ -2045,12 +2058,13 @@ static struct sk_buff *add_grec(struct sk_buff *skb, struct ifmcaddr6 *pmc,
 	return skb;
 }
 
-/* called with mc_lock */
 static void mld_send_report(struct inet6_dev *idev, struct ifmcaddr6 *pmc)
 {
 	struct sk_buff *skb = NULL;
 	int type;
 
+	mc_assert_locked(idev);
+
 	if (!pmc) {
 		for_each_mc_mclock(idev, pmc) {
 			if (pmc->mca_flags & MAF_NOREPORT)
@@ -2072,10 +2086,7 @@ static void mld_send_report(struct inet6_dev *idev, struct ifmcaddr6 *pmc)
 		mld_sendpack(skb);
 }
 
-/*
- * remove zero-count source records from a source filter list
- * called with mc_lock
- */
+/* remove zero-count source records from a source filter list */
 static void mld_clear_zeros(struct ip6_sf_list __rcu **ppsf, struct inet6_dev *idev)
 {
 	struct ip6_sf_list *psf_prev, *psf_next, *psf;
@@ -2099,7 +2110,6 @@ static void mld_clear_zeros(struct ip6_sf_list __rcu **ppsf, struct inet6_dev *i
 	}
 }
 
-/* called with mc_lock */
 static void mld_send_cr(struct inet6_dev *idev)
 {
 	struct ifmcaddr6 *pmc, *pmc_prev, *pmc_next;
@@ -2263,13 +2273,14 @@ static void igmp6_send(struct in6_addr *addr, struct net_device *dev, int type)
 	goto out;
 }
 
-/* called with mc_lock */
 static void mld_send_initial_cr(struct inet6_dev *idev)
 {
-	struct sk_buff *skb;
 	struct ifmcaddr6 *pmc;
+	struct sk_buff *skb;
 	int type;
 
+	mc_assert_locked(idev);
+
 	if (mld_in_v1_mode(idev))
 		return;
 
@@ -2316,13 +2327,14 @@ static void mld_dad_work(struct work_struct *work)
 	in6_dev_put(idev);
 }
 
-/* called with mc_lock */
 static int ip6_mc_del1_src(struct ifmcaddr6 *pmc, int sfmode,
-	const struct in6_addr *psfsrc)
+			   const struct in6_addr *psfsrc)
 {
 	struct ip6_sf_list *psf, *psf_prev;
 	int rv = 0;
 
+	mc_assert_locked(pmc->idev);
+
 	psf_prev = NULL;
 	for_each_psf_mclock(pmc, psf) {
 		if (ipv6_addr_equal(&psf->sf_addr, psfsrc))
@@ -2359,7 +2371,6 @@ static int ip6_mc_del1_src(struct ifmcaddr6 *pmc, int sfmode,
 	return rv;
 }
 
-/* called with mc_lock */
 static int ip6_mc_del_src(struct inet6_dev *idev, const struct in6_addr *pmca,
 			  int sfmode, int sfcount, const struct in6_addr *psfsrc,
 			  int delta)
@@ -2371,6 +2382,8 @@ static int ip6_mc_del_src(struct inet6_dev *idev, const struct in6_addr *pmca,
 	if (!idev)
 		return -ENODEV;
 
+	mc_assert_locked(idev);
+
 	for_each_mc_mclock(idev, pmc) {
 		if (ipv6_addr_equal(pmca, &pmc->mca_addr))
 			break;
@@ -2412,15 +2425,14 @@ static int ip6_mc_del_src(struct inet6_dev *idev, const struct in6_addr *pmca,
 	return err;
 }
 
-/*
- * Add multicast single-source filter to the interface list
- * called with mc_lock
- */
+/* Add multicast single-source filter to the interface list */
 static int ip6_mc_add1_src(struct ifmcaddr6 *pmc, int sfmode,
-	const struct in6_addr *psfsrc)
+			   const struct in6_addr *psfsrc)
 {
 	struct ip6_sf_list *psf, *psf_prev;
 
+	mc_assert_locked(pmc->idev);
+
 	psf_prev = NULL;
 	for_each_psf_mclock(pmc, psf) {
 		if (ipv6_addr_equal(&psf->sf_addr, psfsrc))
@@ -2443,11 +2455,12 @@ static int ip6_mc_add1_src(struct ifmcaddr6 *pmc, int sfmode,
 	return 0;
 }
 
-/* called with mc_lock */
 static void sf_markstate(struct ifmcaddr6 *pmc)
 {
-	struct ip6_sf_list *psf;
 	int mca_xcount = pmc->mca_sfcount[MCAST_EXCLUDE];
+	struct ip6_sf_list *psf;
+
+	mc_assert_locked(pmc->idev);
 
 	for_each_psf_mclock(pmc, psf) {
 		if (pmc->mca_sfcount[MCAST_EXCLUDE]) {
@@ -2460,14 +2473,15 @@ static void sf_markstate(struct ifmcaddr6 *pmc)
 	}
 }
 
-/* called with mc_lock */
 static int sf_setstate(struct ifmcaddr6 *pmc)
 {
-	struct ip6_sf_list *psf, *dpsf;
 	int mca_xcount = pmc->mca_sfcount[MCAST_EXCLUDE];
+	struct ip6_sf_list *psf, *dpsf;
 	int qrv = pmc->idev->mc_qrv;
 	int new_in, rv;
 
+	mc_assert_locked(pmc->idev);
+
 	rv = 0;
 	for_each_psf_mclock(pmc, psf) {
 		if (pmc->mca_sfcount[MCAST_EXCLUDE]) {
@@ -2526,10 +2540,7 @@ static int sf_setstate(struct ifmcaddr6 *pmc)
 	return rv;
 }
 
-/*
- * Add multicast source filter list to the interface list
- * called with mc_lock
- */
+/* Add multicast source filter list to the interface list */
 static int ip6_mc_add_src(struct inet6_dev *idev, const struct in6_addr *pmca,
 			  int sfmode, int sfcount, const struct in6_addr *psfsrc,
 			  int delta)
@@ -2541,6 +2552,8 @@ static int ip6_mc_add_src(struct inet6_dev *idev, const struct in6_addr *pmca,
 	if (!idev)
 		return -ENODEV;
 
+	mc_assert_locked(idev);
+
 	for_each_mc_mclock(idev, pmc) {
 		if (ipv6_addr_equal(pmca, &pmc->mca_addr))
 			break;
@@ -2588,11 +2601,12 @@ static int ip6_mc_add_src(struct inet6_dev *idev, const struct in6_addr *pmca,
 	return err;
 }
 
-/* called with mc_lock */
 static void ip6_mc_clear_src(struct ifmcaddr6 *pmc)
 {
 	struct ip6_sf_list *psf, *nextpsf;
 
+	mc_assert_locked(pmc->idev);
+
 	for (psf = mc_dereference(pmc->mca_tomb, pmc->idev);
 	     psf;
 	     psf = nextpsf) {
@@ -2613,11 +2627,12 @@ static void ip6_mc_clear_src(struct ifmcaddr6 *pmc)
 	WRITE_ONCE(pmc->mca_sfcount[MCAST_EXCLUDE], 1);
 }
 
-/* called with mc_lock */
 static void igmp6_join_group(struct ifmcaddr6 *ma)
 {
 	unsigned long delay;
 
+	mc_assert_locked(ma->idev);
+
 	if (ma->mca_flags & MAF_NOREPORT)
 		return;
 
@@ -2664,9 +2679,10 @@ static int ip6_mc_leave_src(struct sock *sk, struct ipv6_mc_socklist *iml,
 	return err;
 }
 
-/* called with mc_lock */
 static void igmp6_leave_group(struct ifmcaddr6 *ma)
 {
+	mc_assert_locked(ma->idev);
+
 	if (mld_in_v1_mode(ma->idev)) {
 		if (ma->mca_flags & MAF_LAST_REPORTER) {
 			igmp6_send(&ma->mca_addr, ma->idev->dev,
@@ -2711,9 +2727,10 @@ static void mld_ifc_work(struct work_struct *work)
 	in6_dev_put(idev);
 }
 
-/* called with mc_lock */
 static void mld_ifc_event(struct inet6_dev *idev)
 {
+	mc_assert_locked(idev);
+
 	if (mld_in_v1_mode(idev))
 		return;
 
-- 
2.49.0


