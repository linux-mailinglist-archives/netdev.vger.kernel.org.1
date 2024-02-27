Return-Path: <netdev+bounces-75366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 815B18699D5
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4A91F24C2E
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62992152E14;
	Tue, 27 Feb 2024 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="elTRFBH1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646AA14EFE7
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046146; cv=none; b=XUP65AmnmNsX6E5a5T8X1j8gSG40vPa8get93Xc1gP/mgHlBDhFIRuuhIwfEJ9qnaZyH0jfLxDnjdEjb46jVHTILTQh/GuFrH0moyplOvUib0pTVkFGVBmihFuw7ir1ITptgQ0DvqTrecvvyM0gRo+D3EOc95yuQ07D3n8yDzjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046146; c=relaxed/simple;
	bh=cC59LniBoUJQumbb3AXRS4ePOyUh+YNm9VXZqyUvv4w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j+nGI48DM+klBDrci+j15UveAXy/hWiGxovqeuSzbTmRtIbO0aoALwUt7h5GBZsWZrYjO9t4/WP1NGf3xvdz5gspuhUqadM4Y+YpiEHyaismVVS/Q75gWjkBDVvWN+gAzbmHrO/WbrFFmXRbso2Rl0G+q4DLOB7LUZ2Hdmyycu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=elTRFBH1; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b5d1899eso5228436276.0
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709046143; x=1709650943; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0XtrOpavGxGT80iGnHG8Us6/OrnAVSKSSWk9mlKvQlk=;
        b=elTRFBH1MhcQHlSDYZEixgVO3AxfVwJFwZwxnflqclkXjeaILQb37+0wa9h/WhfTzp
         raKVmiB1UNQi8ulbCb7JXJfIW8+RQQP44DnW9VakTQGFoMBQ8/wXIMd26ZPAH0Hywkiq
         jjfiVTan4Ta5zWa1UMtlzRaWHS6Ra0wFjyjo5EiEuD4vKesmegTzh7yP1ziCznxPcjt1
         mEqk5dHYJr3v6mD549awvBNT+qD/+W+sD1dpjbd1DyVZa26bYT60rBzveRRy0gFShkWK
         UW28kRqqdHwaG0/tze4nS7Q4ahpiKldA+DnRJ+PlZQk3D5imi08RXngwd5SVO/JP5/0z
         /u2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046143; x=1709650943;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0XtrOpavGxGT80iGnHG8Us6/OrnAVSKSSWk9mlKvQlk=;
        b=dvsHFDbA5HBmtJiV5QzoyZowWJdZSatD8yoRcfqu5PF40y9hppNrm1cbSyQ/5ERGHN
         qnGB/fnY1nzqUqPo937j2jINtiaoz2Jw0qjIrxl0OBBG4r6eHa+aNT3agnewyQWeuE3S
         7Gd44XFb1fM2uTEf1Uiw6IBovuimd3o3pp///ZLREoNcaT4RdzbKrQTRieoU4mFJD9Wi
         9o4CBPpAzQAN4pQKVMPi7mbtsKdFTFuGzwv0kmJkD+wCqxhMvcm9GYssgR13zOoUB5Wq
         w2uNiyi6Yv2t3NpB9vZBjHrrgitrfiRZi5zzuxFpKAGoqGLkFuDmsQNYK4bPFIvnXwb+
         iYEw==
X-Forwarded-Encrypted: i=1; AJvYcCVLYrW8ZalC/yAX7IcM/VJtrpxgsniSUi3vSpUlgV4oX9G4F6lBFQ65wbaC3xNiVREnv3DdLW/rZbai7dQkgKyyDugD2071
X-Gm-Message-State: AOJu0Yzn5zWhoOYt1epL/kIgYP4R/9EfFxR16PtKCdracwD/Jb1/pdIR
	I7j2sNjtVirfzT+UG960Wresj9IAqYMn8mrWnatExWjyOqjcXTYUyGXxxVNkkalPC8LEQOoIy/H
	4NEMIqcebKg==
X-Google-Smtp-Source: AGHT+IHMSz5BfIF+jNROFg0F6pjXa2aZ2BjEZyipiyDsZAEYlp2gdm9pFMQC5DpH9XH1aYhh4ZnXJ1pvC9ZaQg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1004:b0:dc2:2e5c:a21d with SMTP
 id w4-20020a056902100400b00dc22e5ca21dmr694614ybt.6.1709046143648; Tue, 27
 Feb 2024 07:02:23 -0800 (PST)
Date: Tue, 27 Feb 2024 15:01:58 +0000
In-Reply-To: <20240227150200.2814664-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227150200.2814664-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227150200.2814664-14-edumazet@google.com>
Subject: [PATCH v2 net-next 13/15] ipv6/addrconf: annotate data-races around
 devconf fields (I)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Annotate lockless reads and writes on following devconf fields:

- regen_min_advance
- regen_max_retry
- dad_transmits
- use_tempaddr
- max_addresses
- max_desync_factor
- temp_valid_lft
- rtr_solicits
- rtr_solicit_max_interval
- rtr_solicit_interval
- rtr_solicit_delay
- enhanced_dad
- accept_redirects

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/addrconf.c | 67 +++++++++++++++++++++++++--------------------
 net/ipv6/route.c    |  3 +-
 2 files changed, 39 insertions(+), 31 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index d198365b1ac669a1158c44c1c9d050ede276d638..15bb3001e2bed6df9f869264dcc71aa812f597ec 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1359,11 +1359,12 @@ static void ipv6_del_addr(struct inet6_ifaddr *ifp)
 	in6_ifa_put(ifp);
 }
 
-static unsigned long ipv6_get_regen_advance(struct inet6_dev *idev)
+static unsigned long ipv6_get_regen_advance(const struct inet6_dev *idev)
 {
-	return idev->cnf.regen_min_advance + idev->cnf.regen_max_retry *
-			idev->cnf.dad_transmits *
-			max(NEIGH_VAR(idev->nd_parms, RETRANS_TIME), HZ/100) / HZ;
+	return READ_ONCE(idev->cnf.regen_min_advance) +
+		READ_ONCE(idev->cnf.regen_max_retry) *
+		READ_ONCE(idev->cnf.dad_transmits) *
+		max(NEIGH_VAR(idev->nd_parms, RETRANS_TIME), HZ/100) / HZ;
 }
 
 static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
@@ -1384,7 +1385,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 
 retry:
 	in6_dev_hold(idev);
-	if (idev->cnf.use_tempaddr <= 0) {
+	if (READ_ONCE(idev->cnf.use_tempaddr) <= 0) {
 		write_unlock_bh(&idev->lock);
 		pr_info("%s: use_tempaddr is disabled\n", __func__);
 		in6_dev_put(idev);
@@ -1392,8 +1393,8 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 		goto out;
 	}
 	spin_lock_bh(&ifp->lock);
-	if (ifp->regen_count++ >= idev->cnf.regen_max_retry) {
-		idev->cnf.use_tempaddr = -1;	/*XXX*/
+	if (ifp->regen_count++ >= READ_ONCE(idev->cnf.regen_max_retry)) {
+		WRITE_ONCE(idev->cnf.use_tempaddr, -1);	/*XXX*/
 		spin_unlock_bh(&ifp->lock);
 		write_unlock_bh(&idev->lock);
 		pr_warn("%s: regeneration time exceeded - disabled temporary address support\n",
@@ -1415,7 +1416,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 	 */
 	cnf_temp_preferred_lft = READ_ONCE(idev->cnf.temp_prefered_lft);
 	max_desync_factor = min_t(long,
-				  idev->cnf.max_desync_factor,
+				  READ_ONCE(idev->cnf.max_desync_factor),
 				  cnf_temp_preferred_lft - regen_advance);
 
 	if (unlikely(idev->desync_factor > max_desync_factor)) {
@@ -1432,7 +1433,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 
 	memset(&cfg, 0, sizeof(cfg));
 	cfg.valid_lft = min_t(__u32, ifp->valid_lft,
-			      idev->cnf.temp_valid_lft + age);
+			      READ_ONCE(idev->cnf.temp_valid_lft) + age);
 	cfg.preferred_lft = cnf_temp_preferred_lft + age - idev->desync_factor;
 	cfg.preferred_lft = min_t(__u32, if_public_preferred_lft, cfg.preferred_lft);
 	cfg.preferred_lft = min_t(__u32, cfg.valid_lft, cfg.preferred_lft);
@@ -1685,7 +1686,7 @@ static int ipv6_get_saddr_eval(struct net *net,
 		 */
 		int preftmp = dst->prefs & (IPV6_PREFER_SRC_PUBLIC|IPV6_PREFER_SRC_TMP) ?
 				!!(dst->prefs & IPV6_PREFER_SRC_TMP) :
-				score->ifa->idev->cnf.use_tempaddr >= 2;
+				READ_ONCE(score->ifa->idev->cnf.use_tempaddr) >= 2;
 		ret = (!(score->ifa->flags & IFA_F_TEMPORARY)) ^ preftmp;
 		break;
 	    }
@@ -2168,6 +2169,7 @@ void addrconf_dad_failure(struct sk_buff *skb, struct inet6_ifaddr *ifp)
 {
 	struct inet6_dev *idev = ifp->idev;
 	struct net *net = dev_net(idev->dev);
+	int max_addresses;
 
 	if (addrconf_dad_end(ifp)) {
 		in6_ifa_put(ifp);
@@ -2205,9 +2207,9 @@ void addrconf_dad_failure(struct sk_buff *skb, struct inet6_ifaddr *ifp)
 
 		spin_unlock_bh(&ifp->lock);
 
-		if (idev->cnf.max_addresses &&
-		    ipv6_count_addresses(idev) >=
-		    idev->cnf.max_addresses)
+		max_addresses = READ_ONCE(idev->cnf.max_addresses);
+		if (max_addresses &&
+		    ipv6_count_addresses(idev) >= max_addresses)
 			goto lock_errdad;
 
 		net_info_ratelimited("%s: generating new stable privacy address because of DAD conflict\n",
@@ -2604,11 +2606,11 @@ static void manage_tempaddrs(struct inet6_dev *idev,
 		 * (TEMP_PREFERRED_LIFETIME - DESYNC_FACTOR), respectively.
 		 */
 		age = (now - ift->cstamp) / HZ;
-		max_valid = idev->cnf.temp_valid_lft - age;
+		max_valid = READ_ONCE(idev->cnf.temp_valid_lft) - age;
 		if (max_valid < 0)
 			max_valid = 0;
 
-		max_prefered = idev->cnf.temp_prefered_lft -
+		max_prefered = READ_ONCE(idev->cnf.temp_prefered_lft) -
 			       idev->desync_factor - age;
 		if (max_prefered < 0)
 			max_prefered = 0;
@@ -2641,7 +2643,7 @@ static void manage_tempaddrs(struct inet6_dev *idev,
 	if (list_empty(&idev->tempaddr_list) && (valid_lft || prefered_lft))
 		create = true;
 
-	if (create && idev->cnf.use_tempaddr > 0) {
+	if (create && READ_ONCE(idev->cnf.use_tempaddr) > 0) {
 		/* When a new public address is created as described
 		 * in [ADDRCONF], also create a new temporary address.
 		 */
@@ -2669,7 +2671,7 @@ int addrconf_prefix_rcv_add_addr(struct net *net, struct net_device *dev,
 	int create = 0, update_lft = 0;
 
 	if (!ifp && valid_lft) {
-		int max_addresses = in6_dev->cnf.max_addresses;
+		int max_addresses = READ_ONCE(in6_dev->cnf.max_addresses);
 		struct ifa6_config cfg = {
 			.pfx = addr,
 			.plen = pinfo->prefix_len,
@@ -4028,6 +4030,7 @@ static void addrconf_rs_timer(struct timer_list *t)
 	struct inet6_dev *idev = from_timer(idev, t, rs_timer);
 	struct net_device *dev = idev->dev;
 	struct in6_addr lladdr;
+	int rtr_solicits;
 
 	write_lock(&idev->lock);
 	if (idev->dead || !(idev->if_flags & IF_READY))
@@ -4040,7 +4043,9 @@ static void addrconf_rs_timer(struct timer_list *t)
 	if (idev->if_flags & IF_RA_RCVD)
 		goto out;
 
-	if (idev->rs_probes++ < idev->cnf.rtr_solicits || idev->cnf.rtr_solicits < 0) {
+	rtr_solicits = READ_ONCE(idev->cnf.rtr_solicits);
+
+	if (idev->rs_probes++ < rtr_solicits || rtr_solicits < 0) {
 		write_unlock(&idev->lock);
 		if (!ipv6_get_lladdr(dev, &lladdr, IFA_F_TENTATIVE))
 			ndisc_send_rs(dev, &lladdr,
@@ -4050,11 +4055,12 @@ static void addrconf_rs_timer(struct timer_list *t)
 
 		write_lock(&idev->lock);
 		idev->rs_interval = rfc3315_s14_backoff_update(
-			idev->rs_interval, idev->cnf.rtr_solicit_max_interval);
+				idev->rs_interval,
+				READ_ONCE(idev->cnf.rtr_solicit_max_interval));
 		/* The wait after the last probe can be shorter */
 		addrconf_mod_rs_timer(idev, (idev->rs_probes ==
-					     idev->cnf.rtr_solicits) ?
-				      idev->cnf.rtr_solicit_delay :
+					     READ_ONCE(idev->cnf.rtr_solicits)) ?
+				      READ_ONCE(idev->cnf.rtr_solicit_delay) :
 				      idev->rs_interval);
 	} else {
 		/*
@@ -4075,24 +4081,25 @@ static void addrconf_rs_timer(struct timer_list *t)
  */
 static void addrconf_dad_kick(struct inet6_ifaddr *ifp)
 {
-	unsigned long rand_num;
 	struct inet6_dev *idev = ifp->idev;
+	unsigned long rand_num;
 	u64 nonce;
 
 	if (ifp->flags & IFA_F_OPTIMISTIC)
 		rand_num = 0;
 	else
-		rand_num = get_random_u32_below(idev->cnf.rtr_solicit_delay ? : 1);
+		rand_num = get_random_u32_below(
+				READ_ONCE(idev->cnf.rtr_solicit_delay) ? : 1);
 
 	nonce = 0;
-	if (idev->cnf.enhanced_dad ||
-	    dev_net(idev->dev)->ipv6.devconf_all->enhanced_dad) {
+	if (READ_ONCE(idev->cnf.enhanced_dad) ||
+	    READ_ONCE(dev_net(idev->dev)->ipv6.devconf_all->enhanced_dad)) {
 		do
 			get_random_bytes(&nonce, 6);
 		while (nonce == 0);
 	}
 	ifp->dad_nonce = nonce;
-	ifp->dad_probes = idev->cnf.dad_transmits;
+	ifp->dad_probes = READ_ONCE(idev->cnf.dad_transmits);
 	addrconf_mod_dad_work(ifp, rand_num);
 }
 
@@ -4331,7 +4338,7 @@ static void addrconf_dad_completed(struct inet6_ifaddr *ifp, bool bump_id,
 	send_mld = ifp->scope == IFA_LINK && ipv6_lonely_lladdr(ifp);
 	send_rs = send_mld &&
 		  ipv6_accept_ra(ifp->idev) &&
-		  ifp->idev->cnf.rtr_solicits != 0 &&
+		  READ_ONCE(ifp->idev->cnf.rtr_solicits) != 0 &&
 		  (dev->flags & IFF_LOOPBACK) == 0 &&
 		  (dev->type != ARPHRD_TUNNEL) &&
 		  !netif_is_team_port(dev);
@@ -4366,7 +4373,7 @@ static void addrconf_dad_completed(struct inet6_ifaddr *ifp, bool bump_id,
 		write_lock_bh(&ifp->idev->lock);
 		spin_lock(&ifp->lock);
 		ifp->idev->rs_interval = rfc3315_s14_backoff_init(
-			ifp->idev->cnf.rtr_solicit_interval);
+			READ_ONCE(ifp->idev->cnf.rtr_solicit_interval));
 		ifp->idev->rs_probes = 1;
 		ifp->idev->if_flags |= IF_RS_SENT;
 		addrconf_mod_rs_timer(ifp->idev, ifp->idev->rs_interval);
@@ -5914,7 +5921,7 @@ static int inet6_set_iftoken(struct inet6_dev *idev, struct in6_addr *token,
 		return -EINVAL;
 	}
 
-	if (idev->cnf.rtr_solicits == 0) {
+	if (READ_ONCE(idev->cnf.rtr_solicits) == 0) {
 		NL_SET_ERR_MSG(extack,
 			       "Router solicitation is disabled on device");
 		return -EINVAL;
@@ -5947,7 +5954,7 @@ static int inet6_set_iftoken(struct inet6_dev *idev, struct in6_addr *token,
 	if (update_rs) {
 		idev->if_flags |= IF_RS_SENT;
 		idev->rs_interval = rfc3315_s14_backoff_init(
-			idev->cnf.rtr_solicit_interval);
+			READ_ONCE(idev->cnf.rtr_solicit_interval));
 		idev->rs_probes = 1;
 		addrconf_mod_rs_timer(idev, idev->rs_interval);
 	}
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index a92fcac902aea9307e0c83d150e9d1c41435887f..2cecb1c5a58f679abcb368a62ed914a78f2f4b5f 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4150,7 +4150,8 @@ static void rt6_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_bu
 	in6_dev = __in6_dev_get(skb->dev);
 	if (!in6_dev)
 		return;
-	if (READ_ONCE(in6_dev->cnf.forwarding) || !in6_dev->cnf.accept_redirects)
+	if (READ_ONCE(in6_dev->cnf.forwarding) ||
+	    !READ_ONCE(in6_dev->cnf.accept_redirects))
 		return;
 
 	/* RFC2461 8.1:
-- 
2.44.0.rc1.240.g4c46232300-goog


