Return-Path: <netdev+bounces-184815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF7AA974A1
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 20:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5355D175637
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A68D290097;
	Tue, 22 Apr 2025 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8in3aQZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B801F5402;
	Tue, 22 Apr 2025 18:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745347771; cv=none; b=Oz8ii4jxsqfXFX7C3JtwMgQxHGfA2eLnEmBqJUZi3U5oG0Ipy93HaWbNdROOpK60EbN2AhaM9okWQDmYIXpzUUiX0jhYKHCkWlfB+1+z6qEgNJdVK8bRhydwXKNiNoDfR1tzWpkOUDXnuUCWIhliBY3WzzDjzAhMwBV2n9lBGJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745347771; c=relaxed/simple;
	bh=gODZZTMpe+CjhAfxE4Q361fmYuKG0GKs6cPw9YWPx8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q5+2PvOQoe5ix3is+b0zH0SJXjnHyZbHnxyh5eb+QO8wW4KPLgYOgM/LzvE2+zFUWPo5H1GIgEzHq7f7sn2FImE+QsRLYAK3wI1rAWiOCHMsxPBcwDe6KMsMLoSlQoYfASFvJdOImGk5CluxmT7Fw+FA/8LPXx8XOrqVQD6kHtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8in3aQZ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso847101066b.1;
        Tue, 22 Apr 2025 11:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745347767; x=1745952567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=73kd/N276bY7XGUBKNfuyf9YMgLVM7foEmenVT0F9cY=;
        b=P8in3aQZ1XZ3S5mSttfYCXM8U+y8ntfghnK8h2qL7mFDPDD3POKy3H9Z65UA7Vq2Iw
         /tgPP15sOeJmepU1pDaWtt6GnMiEdoviFXCbqR+eM1EJMKmTksEJH/t9QBIjAY9FM69k
         vNXowGOqLT/sobNcqCJ7crD6yGBR+Xdqn1smOQIWJVjVcuCg7hjCL5OxFNmNYnq1Afix
         KKoFKuoQcdXkL70eqkabyr2xYtEKruNQOMVXkPrZ1wESi1o8YfA5h+lg9n9DWkJlyyEn
         lG4FRXuQPPIwgmW6gltsOb6ALXXPZ6tlF5SejBC4OqVtl07JPYC8z6L0zVsAKGpsNkji
         FzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745347767; x=1745952567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=73kd/N276bY7XGUBKNfuyf9YMgLVM7foEmenVT0F9cY=;
        b=KnOHOY0L836bV6CE4dNhKD27+f8F7F0ZkbYI+NEVJGM/+G0BN8G0ATFbpT7uNprw7M
         Swddj8GKIs8qY+7kdhrXsPnjlXtkbioO+7ZizEz0A0y0lHLIno4C+VTGkdGXlKTDqsQb
         L8PPSFztH8bcn6kNuPelozFVTOxM+HSNidL9Lmy6/uMQT9NB6l/SRLr6LGdmcdFk16nh
         Ux7vcs5rJ9Ea0L+Gzs4JP9jAQi358886YxavFiLVwsBcc7xdXy8A9B7rUtIkAcJa7iU7
         D3xCi2IhShAPaKX+EObAa3iTG4vxVd7Pa2m7W7H/Eul0NlzDRemIWX0i1AjswqUiMppm
         uJng==
X-Forwarded-Encrypted: i=1; AJvYcCU38RS5rml0SxN0e/J2Vuy6WLE4bd8h9spQVAR4f5WP+/7gulTl0udaAgkOY6fVH5FVyCoYDoeYiDxHDpo=@vger.kernel.org, AJvYcCV+i0YFgxzKnhr8EgcjgFnAwo2WzKzeUXOlq/gpypjTk5zMSAWNFwggxdkR3C2QP/WerEjvfAzP@vger.kernel.org
X-Gm-Message-State: AOJu0YxOpru/+lw3o0RW3+xgreE6A7v/7CI2dYPlWf8SppyUoxpenX5G
	X6CJGEOr1koqD2NYM+sg7HhHaZ1Ikx+bzedrnl+r/RtsoqjqC8zzOig60HFP
X-Gm-Gg: ASbGncvKqxlL1inReBthX+fU9zGgFVC/EbxdbeJGuNuZWu7V0W/wnuZrE7c24wIET7h
	kToijvkJepF55XimJ0jA2v2UHxDCqxsq5QcrA1AuWiCHPjC4Jo+XK5CntCRn58Px7BofErC/w/Z
	TDmCOgjXDBTlFUNs08Y6szNRHWiJg1AT9T9CefTU7D4i2xDOvUxteK5CEyFH9hlYGR2cH3ftqZu
	93BAGpstWMjqOy3iCYxjd7d3MnyZ989bT9v6LuKB8lrt72cxEy1m/oR4Wx2g/NhCn3Mfp7jn74C
	XP5WL6+bg8ooLb3blCK7Pbr3sK2oIaQ1F3qhSl8K4SWVZROW7SfYdnOqiOxZddQYlfw9tdrfs7Z
	dfSfZiihH/hFo2D+/xfg=
X-Google-Smtp-Source: AGHT+IGJpwyG/KngNjSJgxbIuc/GT7ionsA5lBkqPCrJKG9MQVxIW/2t5/FvQMp2SRlUtvo5QcdNjg==
X-Received: by 2002:a17:907:2d1f:b0:ac3:26ff:11a0 with SMTP id a640c23a62f3a-acb74dd05c6mr1576901266b.38.1745347767266;
        Tue, 22 Apr 2025 11:49:27 -0700 (PDT)
Received: from localhost (dslb-002-205-023-067.002.205.pools.vodafone-ip.de. [2.205.23.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec0bfd9sm679807566b.29.2025.04.22.11.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 11:49:26 -0700 (PDT)
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
Subject: [PATCH net] net: dsa: fix VLAN 0 filter imbalance when toggling filtering
Date: Tue, 22 Apr 2025 20:49:13 +0200
Message-ID: <20250422184913.20155-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a net device has NETIF_F_HW_VLAN_CTAG_FILTER set, the 8021q code
will add VLAN 0 when enabling the device, and remove it on disabling it
again.

But since we are changing NETIF_F_HW_VLAN_CTAG_FILTER during runtime in
dsa_user_manage_vlan_filtering(), user ports that are already enabled
may end up with no VLAN 0 configured, or VLAN 0 left configured.

E.g.the following sequence would leave sw1p1 without VLAN 0 configured:

$ ip link add br0 type bridge vlan_filtering 1
$ ip link set br0 up
$ ip link set sw1p1 up (filtering is 0, so no HW filter added)
$ ip link set sw1p1 master br0 (filtering gets set to 1, but already up)

while the following sequence would work:

$ ip link add br0 type bridge vlan_filtering 1
$ ip link set br0 up
$ ip link set sw1p1 master br0 (filtering gets set to 1)
$ ip link set sw1p1 up (filtering is 1, HW filter is added)

Likewise, the following sequence would leave sw1p2 with a VLAN 0 filter
enabled on a vlan_filtering_is_global dsa switch:

$ ip link add br0 type bridge vlan_filtering 1
$ ip link set br0 up
$ ip link set sw1p1 master br0 (filtering set to 1 for all devices)
$ ip link set sw1p2 up (filtering is 1, so VLAN 0 filter is added)
$ ip link set sw1p1 nomaster (filtering is reset to 0 again)
$ ip link set sw1p2 down (VLAN 0 filter is left configured)

This even causes untagged traffic to break on b53 after undoing the
bridge (though this is partially caused by b53's own doing).

Fix this by emulating 8021q's vlan_device_event() behavior when changing
the NETIF_F_HW_VLAN_CTAG_FILTER flag, including the printk, so that the
absence of it doesn't become a red herring.

While vlan_vid_add() has a return value, vlan_device_event() does not
check its return value, so let us do the same.

Fixes: 06cfb2df7eb0 ("net: dsa: don't advertise 'rx-vlan-filter' when not needed")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 net/dsa/user.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 804dc7dac4f2..f7d62523da93 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1993,7 +1993,16 @@ int dsa_user_manage_vlan_filtering(struct net_device *user,
 			user->features &= ~NETIF_F_HW_VLAN_CTAG_FILTER;
 			return err;
 		}
+
+		if (user->flags & IFF_UP) {
+			pr_info("dsa: adding VLAN 0 to HW filter on device %s\n",
+				user->name);
+			vlan_vid_add(user, htons(ETH_P_8021Q), 0);
+		}
 	} else {
+		if (user->flags & IFF_UP)
+			vlan_vid_del(user, htons(ETH_P_8021Q), 0);
+
 		err = vlan_for_each(user, dsa_user_clear_vlan, user);
 		if (err)
 			return err;
-- 
2.43.0


