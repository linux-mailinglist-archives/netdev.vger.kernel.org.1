Return-Path: <netdev+bounces-237357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A750AC49727
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 22:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E158A3A61DA
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 21:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E93331A4F;
	Mon, 10 Nov 2025 21:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyVPY69Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3693B33FE34
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 21:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762811126; cv=none; b=r76Vhwchu7QA2mNgCZBz7vuulFrAokDBjcqyP3RFGE7LspqDm/0QDC0zYbrCQXpd1Oldr28SeyjFs97Pl9xm8rNUbSAO/g31Jsb2SiAG6KPtwlNMMCX7O+9jszFXIMZqMw/69TuYKYDcnzfjOxbFoGMRo4ZCEYmVwZCH/aC5TLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762811126; c=relaxed/simple;
	bh=w8tUjMrod+NxWocX37Ssa+027kG45dXf54w7jwYksSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQsA5AsPkbfQhUOfdwqAaH5H05d0lEVULKloXkXtRfg2523z5kG1iN81hL52/1SaW/M4SZannKMf5o3EA1fUeneQEAyh+u++VukECC8vFo4QdHRTapURS2Z+jUj3E7riGPe/YbCK7j+bPHjkv+7yaYaGWRZWxo5yNG2BW5UkhE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyVPY69Z; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b729f239b39so45863966b.0
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 13:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762811120; x=1763415920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ysp/qagZkvMXUd9HzXpEknh2ZcUQT5LP/QY/YxZSToE=;
        b=PyVPY69ZCuCnF4lBmuVQ1bkQWitC+2ZPoABvfxoAYyyd3x3HJe9D2pyl7tAWUz5wFH
         f8gQ7FDM7hxvg5Zi8qwUo4rYrRQNOHvQIghL0GmYuFNuovoWVucC0Ml9JUkghBlGwD5I
         YHkRkbFhKIY7yjb1Y5Sj8ryVFcz502i34WT+5v6vKI14Wj2mNI5Y2g3lALsfJPMWJCOy
         GE325tZJPylNc6WvYZ+f56L+uehCtQRJ/q8cgELsCqNx8X5TdtYtxm3Iy/2gjXH83X3H
         RV7au06JdFwzJg4ONQWKgsrvSMocTQ9O4No2gVZf6jQgKpFzzzXMSys15p0J6zyk57gr
         Oc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762811120; x=1763415920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ysp/qagZkvMXUd9HzXpEknh2ZcUQT5LP/QY/YxZSToE=;
        b=oUB3T3mDsIAuS8z38QiECbxiF7TIv7bdC+gD+S7T7KggdfDD1UWM/OppAawiOkYo5f
         vQHksPOuNWvVwP6FeZzapOwdSeLtIJDRJPZ5KmiDG7nAHnw3P/hRydXph9UmqZuIphRc
         F2jb4GTvYyd6pSKRHAf3EOFmzCBo/33rysePNC461f6+BfhLoBG/2wWq3CEPxNQOcnai
         4C1dXIOqlBucKToekj1GcIRr/MYv5N2HaHeJQSd0MeQZgAxUmFUq8cN04yGdmvcZRulm
         +UW/1i6xQqpzYrLAsEW6yOUUwfKoW7XgeWTvt8i5bKX38P21dtrcUcl/oTHcGwzLqyaY
         tA8g==
X-Forwarded-Encrypted: i=1; AJvYcCVndtG53etptLWE3yS7DxLnPg9d93vpovP+AY9U06iJXmM3A/efEHr7bqMG+JkvY+3ltNFytYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqKjb1XemHMCaOR9b9h4SMrXpwZoef9k/y7Y+N0Qx8huxA35i0
	NQNAmipl/DcwIX3fCy+f1/Vz57aVEvF4YrsVO9sbM6IVfF8KljySefnm
X-Gm-Gg: ASbGncu/dLxMVzPB4gCVH61uEIWCTdi0XSRG/6iMr7zypzSc2O0VWalJjxuiyLdebkG
	wYfRTPJ1Zl5LV+tMRLWOQRuPq2BQe6ogwFkh8bYIhoK/ZOnR387YobI3zZgINt3npMhRwAK0ws7
	lmmF1w8kU51iIFQBjRowYAWljD89RAumuknkf2iCv/a2A5Yh94eaUi6IKlPCYHMp8bt3wmVtsrK
	vVTt6CTM1sqrBEI50UX9CyKJeHiWmHxyNTOrK4ca2ZFaJgeaRIu0/OnXVoad8z9UWbZBlAQdES5
	O3CVXooXPrOJr/+9d9Qrt9QmZaAilE0iZu9BFd1X6J+X7mxAwwvzTCuuRcRybupu/V1f1Sdu07q
	G0qu0mC6St8wv2BdFNt+1HQ0I/Dijdil6Esx1/nhhyDFASmreQgIY2O4L2VMMgAuhSGpYTIsV6C
	sKEU6Rx8/a/SBEToKppaw3cvf+ewt0CDjW0RwxO7v5goFu9+dOusvnCUkc
X-Google-Smtp-Source: AGHT+IH8183W3yRA3AVXbVExZKH9s5MO4/1/56KjZdmHqYG52tHaQAanioLg7jwkN+w4uh1I1H509g==
X-Received: by 2002:a17:906:f586:b0:b72:f82c:a628 with SMTP id a640c23a62f3a-b731d37484dmr81219866b.27.1762811119675;
        Mon, 10 Nov 2025 13:45:19 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b73108b0937sm266556666b.3.2025.11.10.13.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 13:45:18 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next 3/3] net: dsa: deny 8021q uppers on vlan unaware bridged ports
Date: Mon, 10 Nov 2025 22:44:43 +0100
Message-ID: <20251110214443.342103-4-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110214443.342103-1-jonas.gorski@gmail.com>
References: <20251110214443.342103-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/networking/switchdev.rst says:

- with VLAN filtering turned off, the bridge will process all ingress
  traffic for the port, except for the traffic tagged with a VLAN ID
  destined for a VLAN upper.

But there is currently no way to configure this in dsa. The vlan upper
will trigger a vlan add to the driver, but it is the same message as a
newly configured bridge VLAN.

Therefore traffic tagged with the VID will continue to be forwarded to
other ports, and therefore we cannot support VLAN uppers on ports of a
VLAN unaware bridges.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 net/dsa/port.c | 23 ++++-------------------
 net/dsa/user.c | 38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/net/dsa/port.c b/net/dsa/port.c
index 082573ae6864..d7746885f7e0 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -728,35 +728,20 @@ static bool dsa_port_can_apply_vlan_filtering(struct dsa_port *dp,
 {
 	struct dsa_switch *ds = dp->ds;
 	struct dsa_port *other_dp;
-	int err;
 
-	/* VLAN awareness was off, so the question is "can we turn it on".
+	/* VLAN awareness was on, so the question is "can we turn it off".
 	 * We may have had 8021q uppers, those need to go. Make sure we don't
 	 * enter an inconsistent state: deny changing the VLAN awareness state
 	 * as long as we have 8021q uppers.
 	 */
-	if (vlan_filtering && dsa_port_is_user(dp)) {
-		struct net_device *br = dsa_port_bridge_dev_get(dp);
+	if (!vlan_filtering && dsa_port_is_user(dp)) {
 		struct net_device *upper_dev, *user = dp->user;
 		struct list_head *iter;
 
 		netdev_for_each_upper_dev_rcu(user, upper_dev, iter) {
-			struct bridge_vlan_info br_info;
-			u16 vid;
-
-			if (!is_vlan_dev(upper_dev))
-				continue;
-
-			vid = vlan_dev_vlan_id(upper_dev);
-
-			/* br_vlan_get_info() returns -EINVAL or -ENOENT if the
-			 * device, respectively the VID is not found, returning
-			 * 0 means success, which is a failure for us here.
-			 */
-			err = br_vlan_get_info(br, vid, &br_info);
-			if (err == 0) {
+			if (is_vlan_dev(upper_dev)) {
 				NL_SET_ERR_MSG_MOD(extack,
-						   "Must first remove VLAN uppers having VIDs also present in bridge");
+						   "Must first remove VLAN uppers from bridged ports");
 				return false;
 			}
 		}
diff --git a/net/dsa/user.c b/net/dsa/user.c
index e8c6452780b0..35265829aa90 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -3156,6 +3156,30 @@ dsa_prevent_bridging_8021q_upper(struct net_device *dev,
 	return NOTIFY_DONE;
 }
 
+/* Must be called under rcu_read_lock() */
+static int
+dsa_user_vlan_check_for_any_8021q_uppers(struct dsa_port *dp)
+{
+	struct dsa_switch *ds = dp->ds;
+	struct dsa_port *other_dp;
+
+	dsa_switch_for_each_user_port(other_dp, ds) {
+		struct net_device *user = other_dp->user;
+		struct net_device *upper_dev;
+		struct list_head *iter;
+
+		if (!dsa_port_bridge_same(dp, other_dp))
+			continue;
+
+		netdev_for_each_upper_dev_rcu(user, upper_dev, iter) {
+			if (is_vlan_dev(upper_dev))
+				return -EBUSY;
+		}
+	}
+
+	return 0;
+}
+
 static int
 dsa_user_check_8021q_upper(struct net_device *dev,
 			   struct netdev_notifier_changeupper_info *info)
@@ -3167,10 +3191,22 @@ dsa_user_check_8021q_upper(struct net_device *dev,
 	int err = NOTIFY_DONE;
 	u16 vid;
 
-	if (!br || !br_vlan_enabled(br))
+	if (!br)
 		return NOTIFY_DONE;
 
 	extack = netdev_notifier_info_to_extack(&info->info);
+
+	if (!br_vlan_enabled(br)) {
+		rcu_read_lock();
+		err = dsa_user_vlan_check_for_any_8021q_uppers(dp);
+		rcu_read_unlock();
+		if (err) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "VLAN uppers not supported with non filtering bridges");
+			return notifier_from_errno(err);
+		}
+	}
+
 	vid = vlan_dev_vlan_id(info->upper_dev);
 
 	/* br_vlan_get_info() returns -EINVAL or -ENOENT if the
-- 
2.43.0


