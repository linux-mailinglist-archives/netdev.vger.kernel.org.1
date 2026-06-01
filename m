Return-Path: <netdev+bounces-293794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHTvCtKaHWpYcgkAu9opvQ
	(envelope-from <netdev+bounces-293794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 16:44:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9FF621157
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 16:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7EF933002F7E
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 14:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874A33B9DBF;
	Mon,  1 Jun 2026 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Nyo2Mb5F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22CB1FE471
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324726; cv=none; b=B5cbZY+2ONipMxaK+MyFqPa6ClGg/HdrOaPT/WMKvM3fZlvX/f05dSYEQacK6nLz2CPQPMkx+lzXJ6IPhyZIWnkdRYfUkEaZPBhVDYs3SU843gqapPwVAd/8aJMDGlVFf3dDNn+/Dc3TNYTPcxqJk6xv6BalcArr33NsZQguN4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324726; c=relaxed/simple;
	bh=2svKO/n8lSKObAZEdZpuP0+u0BUTVWxe8KTiK5xGa2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CitkbvSVYXEd6beOsKfY2Ewk5gLKAGdW/dLD5M+qI/y00JKn0mHk6WUceEt1lLn2h7y/a5bDvr11KoHdPJxc4/yVR6m/G5Vv8Wvb88hmWhEm1d4U0BIYpjphcjriJ4fQalDkaJ9tZYmu/MZbHyiWs8pklPjJoWI/nEunIxjVJ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=Nyo2Mb5F; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7ddd3d67084so40503207b3.3
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 07:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1780324722; x=1780929522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rR3ZuXzPkSTA9ZGASwTjW6xQ4sxM8XBfxw1QZIl00kQ=;
        b=Nyo2Mb5FR7abNM6ir8Qhh7dJCGxX4sbW+t+vP51tBPcMs5Nn7o5qwXJlEtB8UurIrd
         quS+FljWcCrChxadfozogt+sptgJuZrjE9DHFm0fWAxlel3zqaKFC6st1IQY4pzQ5NUN
         RdaguFOL5DJkXB17xjmMqIyETfz13yxdGbxoGEhRqOSa4mm+mybttYOaYexwKCAU1PaJ
         BXbeNc6jwTFbkn3QsbneCxE542pn36bAMd9NyewMrzeJowI+f0zjs/jHMozKV6yfr/44
         wJ+SfmKlDf0gknqXL+mQG2wxANYlzlt9EuZLb/T5VcToUfTH4I923biQPyacLTvT1bvq
         bupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780324722; x=1780929522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rR3ZuXzPkSTA9ZGASwTjW6xQ4sxM8XBfxw1QZIl00kQ=;
        b=H6SAu1XG4kkehUID9I/5j/HvfcVMQ4ZEQJEnuJYyZrNuG2LJ9SMYE4b5lb0q8uhG5P
         QXv6KsE5v/8Pp+VkizxeJFL3yfaxuzgT2ADTKWt7ArzCahuZJ5X5TJDVqvOfLcqMX8PN
         K3SSjUk825JwIEVdEZgjvkzuhFdw9T3Tm1Y0tqYuCfVCR7bhglp8lFw7Am3aHddfKL00
         tLQDxiv6+8SzZgtQTju8lGViBt3OYpTHcRs5LDjEwgyrmTWU+Z3lALa249mdn2IJdScs
         25iXj4ZtF/Djm06SBUywT3c1FJBbkqEKuyUplpgssgGqReBZ7epqTSfqfJc6qsvd5KRk
         j1Zg==
X-Forwarded-Encrypted: i=1; AFNElJ8UePtCVcuD5Mga9PE60/eORLGEL0357o3N2PH217WPfAz8DOh7TwUMagFeSFH/UboX/5z2ylA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKR4GSaYkDgOOrLJ3DDliHE8PyVrylb+RI8HR4J5cjobRHEuB9
	+1W3r8SXy3CVuvAPu0RBHy73XcsUvBIhgEmr9fdh+jJC7NZwjBPYihyI4APtxqHmZqA=
X-Gm-Gg: Acq92OGhDjrGVUbJihWMtz2At3Vqjqvqb02+3MghHkgysC7dy2RJOoYseNkwpAw538Y
	kNh+EVWCa91qDPESGGye8+00aFgrLW60OoF1fdTy8hfbjuR54xwKkRAaYQII/jb3ecVRyPxdCPk
	MZrlDi5VccbJVlfMj68+RyUmSXgUMH6wraETcqGxrNQ01X5NTwulv3a40e++9dR2oIpmdkIDBXD
	c3NTBe7Mmu5G62r/SF51MfmRokFLVU03tLMbRU0GrFNrxE3Zu8SQ4QkeLH2RzESMifhGVBSHKFK
	//ZoaytFCFjVCxtO5N0vhVRl2MUYEcg4gd2pYaqgdw0FFJBviVuNzlWw7o7NikrttCjVH2xNUVT
	poeMogQb6tvOU5dzUmIIhS3/9YfqiGSQLaM+sswyp4oR4ioZE0x09c/UfpIhvHMzkyi84y6HpQt
	Lxf1MZg0cnYD5K8eD+o+3SsW5zzPM2wdlX9P4P3WYCCS0oY0nXOWVk
X-Received: by 2002:a05:690c:7306:b0:7bd:6114:4002 with SMTP id 00721157ae682-7e05f4f9864mr87093217b3.40.1780324721529;
        Mon, 01 Jun 2026 07:38:41 -0700 (PDT)
Received: from eileen ([38.10.152.8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7e17ae7e1c2sm41220427b3.31.2026.06.01.07.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 07:38:40 -0700 (PDT)
From: Caio Morais <caiomorais@usp.br>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: Caio Morais <caiomorais@usp.br>,
	netdev@vger.kernel.org
Subject: [PATCH] mpls: refactor mpls_dev_notify() to use guard(mutex)
Date: Mon,  1 Jun 2026 11:38:23 -0300
Message-ID: <20260601143827.3087733-1-caiomorais@usp.br>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[usp.br,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[usp.br:s=usp-google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[usp.br:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293794-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[caiomorais@usp.br,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,usp.br:email,usp.br:mid,usp.br:dkim]
X-Rspamd-Queue-Id: 2D9FF621157
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace explicit mutex_lock() and mutex_unlock() calls with the
guard(mutex) auto-cleanup helper from <linux/cleanup.h>. This
eliminates the need for the 'out' and 'err' labels, removes the
temporary 'err' variable, and simplifies error paths by allowing
direct returns.

The change reduces boilerplate code, lowers the risk of future
modifications forgetting to unlock the mutex, and improves overall
readability. Functionality remains identical.

As documented in include/linux/cleanup.h, guard() must not be mixed
with goto-based cleanup in the same function, because jumping past
the guard variable initialization can lead to double unlocks or
undefined behavior. Hence, the error labels and explicit
mutex_unlock() are removed in favor of direct returns.

Signed-off-by: Caio Morais <caiomorais@usp.br>
---
 net/mpls/af_mpls.c | 128 +++++++++++++++++++--------------------------
 1 file changed, 55 insertions(+), 73 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 26340a730..160ffd962 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -12,6 +12,7 @@
 #include <linux/nospec.h>
 #include <linux/vmalloc.h>
 #include <linux/percpu.h>
+#include <linux/cleanup.h>
 #include <net/gso.h>
 #include <net/ip.h>
 #include <net/dst.h>
@@ -1641,28 +1642,25 @@ static int mpls_dev_notify(struct notifier_block *this, unsigned long event,
 	unsigned int flags;
 	int err;
 
-	mutex_lock(&net->mpls.platform_mutex);
+	guard(mutex)(&net->mpls.platform_mutex);
 
 	if (event == NETDEV_REGISTER) {
 		mdev = mpls_add_dev(dev);
-		if (IS_ERR(mdev)) {
-			err = PTR_ERR(mdev);
-			goto err;
-		}
-
-		goto out;
+		if (IS_ERR(mdev))
+			return notifier_from_errno(PTR_ERR(mdev));
+		return NOTIFY_OK;
 	}
 
 	mdev = mpls_dev_get(net, dev);
 	if (!mdev)
-		goto out;
+		return NOTIFY_OK;
 
 	switch (event) {
 
 	case NETDEV_DOWN:
 		err = mpls_ifdown(dev, event);
 		if (err)
-			goto err;
+			return notifier_from_errno(err);
 		break;
 	case NETDEV_UP:
 		flags = netif_get_flags(dev);
@@ -1678,13 +1676,13 @@ static int mpls_dev_notify(struct notifier_block *this, unsigned long event,
 		} else {
 			err = mpls_ifdown(dev, event);
 			if (err)
-				goto err;
+				return notifier_from_errno(err);
 		}
 		break;
 	case NETDEV_UNREGISTER:
 		err = mpls_ifdown(dev, event);
 		if (err)
-			goto err;
+			return notifier_from_errno(err);
 
 		mdev = mpls_dev_get(net, dev);
 		if (mdev) {
@@ -1699,18 +1697,12 @@ static int mpls_dev_notify(struct notifier_block *this, unsigned long event,
 			mpls_dev_sysctl_unregister(dev, mdev);
 			err = mpls_dev_sysctl_register(dev, mdev);
 			if (err)
-				goto err;
+				return notifier_from_errno(err);
 		}
 		break;
 	}
 
-out:
-	mutex_unlock(&net->mpls.platform_mutex);
 	return NOTIFY_OK;
-
-err:
-	mutex_unlock(&net->mpls.platform_mutex);
-	return notifier_from_errno(err);
 }
 
 static struct notifier_block mpls_dev_notifier = {
@@ -2424,11 +2416,11 @@ static int mpls_getroute(struct sk_buff *in_skb, struct nlmsghdr *in_nlh,
 	u8 n_labels;
 	int err;
 
-	mutex_lock(&net->mpls.platform_mutex);
+	guard(mutex)(&net->mpls.platform_mutex);
 
 	err = mpls_valid_getroute_req(in_skb, in_nlh, tb, extack);
 	if (err < 0)
-		goto errout;
+		return err;
 
 	rtm = nlmsg_data(in_nlh);
 
@@ -2436,58 +2428,46 @@ static int mpls_getroute(struct sk_buff *in_skb, struct nlmsghdr *in_nlh,
 		u8 label_count;
 
 		if (nla_get_labels(tb[RTA_DST], 1, &label_count,
-				   &in_label, extack)) {
-			err = -EINVAL;
-			goto errout;
-		}
+				   &in_label, extack))
+			return -EINVAL;
 
-		if (!mpls_label_ok(net, &in_label, extack)) {
-			err = -EINVAL;
-			goto errout;
-		}
+		if (!mpls_label_ok(net, &in_label, extack))
+			return -EINVAL;
 	}
 
 	if (in_label < net->mpls.platform_labels)
 		rt = mpls_route_input(net, in_label);
-	if (!rt) {
-		err = -ENETUNREACH;
-		goto errout;
-	}
+	if (!rt)
+		return -ENETUNREACH;
 
 	if (rtm->rtm_flags & RTM_F_FIB_MATCH) {
 		skb = nlmsg_new(lfib_nlmsg_size(rt), GFP_KERNEL);
-		if (!skb) {
-			err = -ENOBUFS;
-			goto errout;
-		}
+		if (!skb)
+			return -ENOBUFS;
 
 		err = mpls_dump_route(skb, portid, in_nlh->nlmsg_seq,
 				      RTM_NEWROUTE, in_label, rt, 0);
 		if (err < 0) {
 			/* -EMSGSIZE implies BUG in lfib_nlmsg_size */
 			WARN_ON(err == -EMSGSIZE);
-			goto errout_free;
+			kfree_skb(skb);
+			return err;
 		}
 
-		err = rtnl_unicast(skb, net, portid);
-		goto errout;
+		return rtnl_unicast(skb, net, portid);
 	}
 
 	if (tb[RTA_NEWDST]) {
 		if (nla_get_labels(tb[RTA_NEWDST], MAX_NEW_LABELS, &n_labels,
-				   labels, extack) != 0) {
-			err = -EINVAL;
-			goto errout;
-		}
+				   labels, extack) != 0)
+			return -EINVAL;
 
 		hdr_size = n_labels * sizeof(struct mpls_shim_hdr);
 	}
 
 	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
-	if (!skb) {
-		err = -ENOBUFS;
-		goto errout;
-	}
+	if (!skb)
+		return -ENOBUFS;
 
 	skb->protocol = htons(ETH_P_MPLS_UC);
 
@@ -2496,8 +2476,8 @@ static int mpls_getroute(struct sk_buff *in_skb, struct nlmsghdr *in_nlh,
 		int i;
 
 		if (skb_cow(skb, hdr_size)) {
-			err = -ENOBUFS;
-			goto errout_free;
+			kfree_skb(skb);
+			return -ENOBUFS;
 		}
 
 		skb_reserve(skb, hdr_size);
@@ -2516,8 +2496,8 @@ static int mpls_getroute(struct sk_buff *in_skb, struct nlmsghdr *in_nlh,
 
 	nh = mpls_select_multipath(rt, skb);
 	if (!nh) {
-		err = -ENETUNREACH;
-		goto errout_free;
+		kfree_skb(skb);
+		return -ENETUNREACH;
 	}
 
 	if (hdr_size) {
@@ -2528,8 +2508,8 @@ static int mpls_getroute(struct sk_buff *in_skb, struct nlmsghdr *in_nlh,
 	nlh = nlmsg_put(skb, portid, in_nlh->nlmsg_seq,
 			RTM_NEWROUTE, sizeof(*r), 0);
 	if (!nlh) {
-		err = -EMSGSIZE;
-		goto errout_free;
+		kfree_skb(skb);
+		return -EMSGSIZE;
 	}
 
 	r = nlmsg_data(nlh);
@@ -2542,36 +2522,38 @@ static int mpls_getroute(struct sk_buff *in_skb, struct nlmsghdr *in_nlh,
 	r->rtm_protocol = rt->rt_protocol;
 	r->rtm_flags	= 0;
 
-	if (nla_put_labels(skb, RTA_DST, 1, &in_label))
-		goto nla_put_failure;
+	if (nla_put_labels(skb, RTA_DST, 1, &in_label)) {
+		nlmsg_cancel(skb, nlh);
+		kfree_skb(skb);
+		return -EMSGSIZE;
+	}
 
 	if (nh->nh_labels &&
 	    nla_put_labels(skb, RTA_NEWDST, nh->nh_labels,
-			   nh->nh_label))
-		goto nla_put_failure;
+			   nh->nh_label)) {
+		nlmsg_cancel(skb, nlh);
+		kfree_skb(skb);
+		return -EMSGSIZE;
+	}
 
 	if (nh->nh_via_table != MPLS_NEIGH_TABLE_UNSPEC &&
 	    nla_put_via(skb, nh->nh_via_table, mpls_nh_via(rt, nh),
-			nh->nh_via_alen))
-		goto nla_put_failure;
+			nh->nh_via_alen)) {
+		nlmsg_cancel(skb, nlh);
+		kfree_skb(skb);
+		return -EMSGSIZE;
+	}
+
 	dev = nh->nh_dev;
-	if (dev && nla_put_u32(skb, RTA_OIF, dev->ifindex))
-		goto nla_put_failure;
+	if (dev && nla_put_u32(skb, RTA_OIF, dev->ifindex)) {
+		nlmsg_cancel(skb, nlh);
+		kfree_skb(skb);
+		return -EMSGSIZE;
+	}
 
 	nlmsg_end(skb, nlh);
 
-	err = rtnl_unicast(skb, net, portid);
-errout:
-	mutex_unlock(&net->mpls.platform_mutex);
-	return err;
-
-nla_put_failure:
-	nlmsg_cancel(skb, nlh);
-	err = -EMSGSIZE;
-errout_free:
-	mutex_unlock(&net->mpls.platform_mutex);
-	kfree_skb(skb);
-	return err;
+	return rtnl_unicast(skb, net, portid);
 }
 
 static int resize_platform_label_table(struct net *net, size_t limit)
-- 
2.54.0


