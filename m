Return-Path: <netdev+bounces-237356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 810CEC4971E
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 22:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F49E188A86B
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 21:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D48338936;
	Mon, 10 Nov 2025 21:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erDTu0KC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F93F3314C8
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 21:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762811121; cv=none; b=m5MLW7Jqy1fiShi6yVdGLNrN54JC1f0m+Ju1uAg+B51PuhiUqcQQvkTcc1qkwzgIf4kxMWWGfoyFVpkjatRQ3SR7gSIZ+HFdIRH6uGLbQB2+/v5n/O9HoXAiRo4WocmYccVjJEiO3b7HFVtVXrTYnplPai6pWs9cwSa7LZNl+fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762811121; c=relaxed/simple;
	bh=4JXbHE4jomV2cfwYF80hI5yre6LwFMYOFIy0n9rH/fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gl9kZdrMOs/ubrtANc86Q6wVwE65dqhjjFNlE7oO5A1W23EoIZVgNrlPYEptR1j+XadUtsgBmGBGs+VwQaNnu/PrzyeWcOFJDMqdPp46w7pG4lYBg2XdoPLO5Z1Fuipvuf0DTneucjshgLc7mHyWj0FdB+zcPVhqs29jPRKq+l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erDTu0KC; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b64cdbb949cso602646866b.1
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 13:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762811118; x=1763415918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=840dLR3TffmVB9X6YIETKfX5Uiq2NyaIKt8jaa7Xq4E=;
        b=erDTu0KCqQLNZOBANn5of3UYM692MKqExlk4BCFGlcwVQfcUBevJtj6pp8kVAQSTfk
         2YHQ3wSoy1B5AeoAyzlz3AkDjLdxYamZ21Gx2zM29Kr56PIWMQXYDvi63igbdzVhhzCw
         PB83p9H/idov9/DMOvNcZzgnM83co1LxU+IbA0iGHkcxxS87x4VHj5xjo4yvxT/6xC2R
         9IxbeCyOmSldhBXKDvSvLGbA5pQgvrAnsukiIhOV+eAr40KEAaT4F6aCDI/DowG6BIza
         F6eClCObqPDVtmfMrfmfrLcHaWKgFmOee9gDqq6P11fKhfMtc2M1xBuqrqcLL3Z/tjyn
         Dn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762811118; x=1763415918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=840dLR3TffmVB9X6YIETKfX5Uiq2NyaIKt8jaa7Xq4E=;
        b=anqd3B4tZJuuEbpTmfpohdGNdG5QeEI4owFHOmHmTK4/B/v6nlfGWPqo69Y/x0HYg9
         bHBN3ACpKv9+tOMUySqjOuGlciGCN9OgqL+t4EZRPCZh/oIt0ZTLoGG4Hu4QI51EFMoS
         Yb/lOv8uP6XT5plo2rYNzBiY9Y0LripioyrpS4WEfRj+6J7X6/eiDhBkzIvfvYRTOtJ8
         Y7Oeo4iGCP27Y+Hss8A/FFsE5xbUGIVZiWPyM44nVguHM0gFP22cCadwfRCVtgkhyPPz
         2TAIOu7PTfEQIT8eNmAv49iK7vIOjUOoPA+U7DcDpGQZbEu5hXxLfn8wgEpUxNuwGHE9
         22Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVf7n/zVcFdix2bWYS1v6eeB8MJ9K4UYoFINrDxyOSPd6dAHdBiedzc7aoQNXH029IgJatZdG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuF33OdUDiz9dtlQyW00hJjQ1h2N2G+T5Hth65xI/h1GGb7QWA
	eu0wUnU3u5zwUwyFjs/PxaKYCQxflWXRxkrFw3yw+jbqpWI1zMV/4vNz
X-Gm-Gg: ASbGnct709VYEhptkUk66gZ/X6VhOU4GYYgh9Nl4ULWfRS+eEnA0JhXnBuH/HsZ3VxQ
	j9c3ghMOjhaVWFILAPSMSueiPn4sHs2lQDwO/eS6TEUriVJhVYTdIM1GN2b/C0AHI/5OLMLZN3y
	H08AGriJkT4RC6yOTy90EolL8kok52RUL34kSNiWDSczEE7bpskjNofRlmbtWB+LefnUN02k1gH
	7W1jvxaaa4DLp+2wIVnLQOQzi7Xr80XLFo0P4pSB+xKyp9O+zFpD6GF+3v31XFj7qOH88690fe1
	q0X9x8hicfBPSl1bVHQeaaQi+CvcBki34eN1CCSxQ8Kl+UNObAAVE7soKQiymEzs06olrX5yt+h
	XiQCujP2DaGt5xdZUO3UHUMKCz5NLHt2QyPX9p7BLVQZOm66BOZgqqRfJa5MDcVMbTkiw/ba7wa
	/TWCaXBlyU/prwVg5K0q7qCcbY+tGBE+X29NLd309nLw0rg4/rEL6W6c2pd4XVlV8QMug=
X-Google-Smtp-Source: AGHT+IFhtB35qNO40KIb+McYDI8DuYUDh30HMzmkWInvkJciIVeFC/FNvZaoK/NXqRGDmTtF5HjxIw==
X-Received: by 2002:a17:907:3f99:b0:b72:58b6:b26f with SMTP id a640c23a62f3a-b72e04e368bmr815459966b.42.1762811118270;
        Mon, 10 Nov 2025 13:45:18 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e447sm1260901666b.42.2025.11.10.13.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 13:45:17 -0800 (PST)
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
Subject: [PATCH RFC net-next 2/3] net: dsa: deny multiple 8021q uppers on bridged ports for the same VLAN
Date: Mon, 10 Nov 2025 22:44:42 +0100
Message-ID: <20251110214443.342103-3-jonas.gorski@gmail.com>
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

When creating 8021q uppers on bridged ports on a vlan filtering bridge,
we will configure the VLAN on the ports. For the dsa driver, there is no
difference between a 8021q upper on bridged port and a port vlan
configured within the bridge.

For that reason, if we configure a second 8021q upper for the same VLAN
on a different port of the bridge, we implicitly enable forwarding
between these ports on that VLAN.

This breaks the requirement for 8021q uppers for the VLAN to be
consumed, so we need to reject these configurations. Reuse
dsa_user_vlan_check_for_8021q_uppers() and change its argument to just
the vlan id.

Before:

$ ip link add br0 type bridge vlan_filtering 1
$ ip link set swp1 master br0
$ ip link set swp2 master br0
$ ip link add swp1.100 link GbE1 type vlan id 100
$ ip link add swp2.100 link GbE2 type vlan id 100
$

After:

$ ip link add br0 type bridge vlan_filtering 1
$ ip link set swp1 master br0
$ ip link set swp2 master br0
$ ip link add swp1.100 link GbE1 type vlan id 100
$ ip link add swp2.100 link GbE2 type vlan id 100
RTNETLINK answers: Resource busy

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 net/dsa/user.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index fa1fe0f1493a..e8c6452780b0 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -653,8 +653,7 @@ static int dsa_user_port_attr_set(struct net_device *dev, const void *ctx,
 
 /* Must be called under rcu_read_lock() */
 static int
-dsa_user_vlan_check_for_8021q_uppers(struct dsa_port *dp,
-				     const struct switchdev_obj_port_vlan *vlan)
+dsa_user_vlan_check_for_8021q_uppers(struct dsa_port *dp, u16 other_vid)
 {
 	struct dsa_switch *ds = dp->ds;
 	struct dsa_port *other_dp;
@@ -674,7 +673,7 @@ dsa_user_vlan_check_for_8021q_uppers(struct dsa_port *dp,
 				continue;
 
 			vid = vlan_dev_vlan_id(upper_dev);
-			if (vid == vlan->vid)
+			if (vid == other_vid)
 				return -EBUSY;
 		}
 	}
@@ -702,7 +701,7 @@ static int dsa_user_vlan_add(struct net_device *dev,
 	 */
 	if (br_vlan_enabled(dsa_port_bridge_dev_get(dp))) {
 		rcu_read_lock();
-		err = dsa_user_vlan_check_for_8021q_uppers(dp, vlan);
+		err = dsa_user_vlan_check_for_8021q_uppers(dp, vlan->vid);
 		rcu_read_unlock();
 		if (err) {
 			NL_SET_ERR_MSG_MOD(extack,
@@ -3185,6 +3184,16 @@ dsa_user_check_8021q_upper(struct net_device *dev,
 		return notifier_from_errno(-EBUSY);
 	}
 
+	rcu_read_lock();
+	err = dsa_user_vlan_check_for_8021q_uppers(dp, vid);
+	rcu_read_unlock();
+
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "This VLAN already has an upper configured on a bridge port");
+		return notifier_from_errno(err);
+	}
+
 	return NOTIFY_DONE;
 }
 
-- 
2.43.0


