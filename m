Return-Path: <netdev+bounces-203552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0288FAF65C1
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA1F482FBA
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164762652B6;
	Wed,  2 Jul 2025 23:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BO/kWIKe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3923B247298
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 23:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497340; cv=none; b=IOvi4jvR7unWCwCGuLlcVcT9bScBOHJbg9WUkr+duSCMvFQvD5S+eEkBcsv9YlqsZYyDvDZx1gaQyEiIe+bHLF6AOXCplYWlGNHxcDwufVPZwd/MTmbjjYl6Rjmqg0wvqNNPVYyfkLPjXDRYOtC0hdoj8+z3PWOQzR5zCp7EZ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497340; c=relaxed/simple;
	bh=HgCa4+Ufz6GWWH3Q0HrK31t6CggWnibOj3mfOWyE2LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwdXoWrqjLcB9YM8zdu/tjJGBHc8kuHXp1F4lZ5dY3p3bUzeCGnHgKfRPV21QjHI+9+07brTDKKxTpH7aylG4FMm1omXzSz+YmO5yIgUFB3mWmQoRSaClE0eSz2OcmvMA3hkSBG7UN/jmE+KRJihLVbBMwu3JpzNHd84Kgb9sus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BO/kWIKe; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3141b84bf65so7146949a91.1
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 16:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497337; x=1752102137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90c6e6gbua2OJyy0zMFwOjiCznFt+/dmu+zJS47O8VY=;
        b=BO/kWIKeS6+QWTXXyWxmb1B6HYzal0YFzC99geLu2Fok/hJXqEMnJGAk6a+INUFSOi
         lYdT2w0nq7nZL4Gc9EquFFkXREvY6FBwtO7S40ZL2XAwfpY2hJvYRlZk3nodWyJDOLgB
         ULQec75L5xyxhJrYino59gU36fqL2BNDHN7y7bjpkP0Bqzy5l4IwrpiA6Xry0J0XnUPm
         Hl01dxEF0F6gdMnCi3QPyyl9cWyi3IEFaWqfA4Hr0BnYwTGyeY++DU8uBng9zsTBPNQ8
         5i6PA/CxFZTewu6Wu0GZXR75KzOb5/jRKNdkTtuNQYcJ1pIC5tV9e1dnPdxhxv8hXJ16
         Ywiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497337; x=1752102137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90c6e6gbua2OJyy0zMFwOjiCznFt+/dmu+zJS47O8VY=;
        b=trHWWIPX0zBN53OEh7WlWCOMjUSTSoy4E2qTc9/jKvU6RHzjgsI93HGBrYfQ1WFAcf
         bx9E6LzWHPOOPobXGNtXqx8ai4UsdupFNXGNopt83a3A3T4dX2+RsC9xzXPRxikhZRwg
         OjGiGiQx03I+6P1U4FtXCRJ/nEvEuUxf785sTqFj92oHmNSsjJDsgqQxML7LvPsmjVl1
         0G3im3yoWZlDGKjiGXm3Y09y2kK2AFtYmkgZfa1AK9oTUSJGzMmb4UpkyqxE0kBcCrWI
         sr6jtvnMrQL+/aP+HfTc9l/MpfBrWSV/dzksgyEwfQDmArZNB4ByMjwCgU22Pjsk/z9y
         Ud6A==
X-Forwarded-Encrypted: i=1; AJvYcCVwm2hGfaZhRAZa4y6oDS/HOaIlKBXaIHPAIk5H8En2jtH45PIzyWp+Qji4XCl21f8H/CXoxUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC1gPdHJMt1OGivvTWce0E7EyRD4FNpuhdfaweX3yyhQCqqCfu
	sfcoNf8FL9as4eual+UH7xf078EVGXV7iF+Ql+5j7kOPPDaqV4JHln4=
X-Gm-Gg: ASbGncvET8fAuFrkN4FGMaQdSbe2Tupdkp+/RaHEJTO1+QH5TIAzSf3bMeW69hmJf25
	rwFxvlrGGtsDMa3X5NXbi8wtfZ7832KfqPYRX7N6nyhmpLby7RsHBfH/vznPKjd0NAIf2ohlhhQ
	SZ5rPujoMN0qZulNaXNyUTtYClxitYgOeFVeNen4p1+mvnQ7TZ5pbvPWrF51WrmB/97b2Fj4wzb
	RXgG74eRD4Qi3LznZTSyVA+lAFxltSxMLnqKx+b7tl0YHHs3RVMEbY6jmVtBACrcmGGT+Y5Q+U3
	1HsHOdH71Tzw0eWI7BGm456JaRM14dz4bljVP7k=
X-Google-Smtp-Source: AGHT+IFBejVHdOIA51KaXtBjFaju4Trk3VwJi4s3C4XY98Cm1AEBL4MnRe6c1qUggBHusjvK8roO/w==
X-Received: by 2002:a17:90b:1b50:b0:312:db8f:9a09 with SMTP id 98e67ed59e1d1-31a90b483f8mr7473435a91.14.1751497337318;
        Wed, 02 Jul 2025 16:02:17 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc70a17sm727071a91.26.2025.07.02.16.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:02:16 -0700 (PDT)
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
Subject: [PATCH v3 net-next 02/15] ipv6: mcast: Replace locking comments with lockdep annotations.
Date: Wed,  2 Jul 2025 16:01:19 -0700
Message-ID: <20250702230210.3115355-3-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702230210.3115355-1-kuni1840@gmail.com>
References: <20250702230210.3115355-1-kuni1840@gmail.com>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
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


