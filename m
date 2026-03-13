Return-Path: <netdev+bounces-267291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCrhKM1+s2kDXQAAu9opvQ
	(envelope-from <netdev+bounces-267291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 04:04:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E716227CF8A
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 04:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E39D30259A7
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83A332143D;
	Fri, 13 Mar 2026 03:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTj7pkH0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FBB2FE07D
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 03:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773371079; cv=none; b=XJ3JOblGyFGaeHboRhqpV37Omc3xoJx75cm5bNKJINk5WjMNngc4YZrRn4KowDZ3qc3wPgyMWEiaVdsyBBdhoHPKr6CKSXKw7gT4OF2MUk7z1OMkWy/m9hwVmzAlksPbJ//VTVOEJsMIGZ/1/HWqZ8el5gVnmTpRcIrNg7nPI54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773371079; c=relaxed/simple;
	bh=I4tJr0wcN2egmg+HlHDIhE18HXzqUjm9zwXxnCfbyB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LbvPSkOB4NTxYepzj1RzEBvb95R3CTgXEp5woZKWIM2hY7nth0879Sj+87NY9pmovnmuK7MvUpBIhbhSQ56pyv+T53zHBRboF4ILtKIzOLiHYrVV9tpGGGSrJy//Ft0cZhxx6/XZKPAKy0p44lwnkKqbMAQDYiaZ4oAeqPQ6w34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTj7pkH0; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35a1f3f07ebso445535a91.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 20:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773371078; x=1773975878; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjhGrfJof2HReSiAWd8q2bv7fT33KudQzX2odTz69Us=;
        b=bTj7pkH0d6HU46LwWbkTr1ufLYqwv7giB0nypH9hGMYUS4s71aQ7e2wisHdXlsNB+J
         y2sG2zbjmz5qUFQpvhuFT0GZ19NLLKmuWOXbAC5ebhHBQXbwqRG7yfDEUzSZwMkRgKhN
         r866WSu8Biy0OBpM39gavG4HPXrLl3ZVpoDsDZ02gueWb0Z3+yHWD2Idy1t0uQTw0hTx
         fGnZDL71g7zggAiiYa/mpd9xaxHdURuQZcp9WVAAWJQyCMxykVbdVIc7NohWFdU+Vvva
         +fdyTdjm7dporK2U8FI8ZJqX7Tpc0wRZee14hWlZzhn/50Y2gJMW7Fszlr2h6R6NGUFT
         KT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773371078; x=1773975878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sjhGrfJof2HReSiAWd8q2bv7fT33KudQzX2odTz69Us=;
        b=LUQ7HCUOSbWUTh37mICoJ0fp4qNd3qijUBmjHtBjljyrC1AUQrlyV0+7eR0O6CnXZf
         K4JKMoIZuB7zZYL91yXtdR295vXGlpCzAwe+hBaWIyo8mPrbILOc/WEk5geY6fWKmwlz
         8f6mZ9/uIc1C6PLB4PX2t+s25zEeZgGv/Zu/fqrvbbVHTEYt+E7waBOl+nXqGf1CNEnD
         3/hMreAp6CAzTkhxvijaI+7IaCSXnQG+I4BfsOVZkt++3RSnZPY3hrBWarIbLqpmIaH2
         dMEPl/ld1LptcGIp39f7wxRTXC87NGTIHb5DF0JEwge4H1+MJxuzQytBzdknJBYl91pe
         EDrA==
X-Gm-Message-State: AOJu0YyOLXAqmx6QXLvlnZvfcu7pUoJQ8hpdAAMzDL3pGsB2AFQc0i6K
	ZsKuGflxbI6yCxfCOcCrhbiVMj8r/JPTvEuuxCCn73ZcT7DtDqDNOXO2
X-Gm-Gg: ATEYQzyRZtv/DE2Jk22d7nTFmbxJRCJM4yhko+LrSEGml2DPWjyt8JXAaAl09wX5HTu
	+knGXIApvrlkYcb2EGZQhfbwdR4dt+2xIzxeLDZTuz8hUZeghzzyrkxV7umPgCoKMg8zFBY0X78
	HDnwgyLiTpZbrC4K/mukhlF4iNmiGjWBs9KDw7GdHb3Wir8dOcpCAoczUdky7T8Z2TXNzoUYUyK
	Sa+uxCt/gQNPaIRRb13DhtlkRpczq+tNoruyaDF3JyqekLtdNWverNVK3aAOmvmD7z9ca/bZcKp
	2BJ/CurKGlkweGqLZpjnjhFzBZp2NMt5BcQmIbDMDlIeHzKfw4hBb5C7+EGRK1cXPSRA34jF+TA
	FjhTdeSkth3NXBNBNAyS5xkz+/exuzf5krTGg2ScVIaQsQy0bY88cRZ+OFwOssy16mrNeG7QRiI
	l+lBUuADi3rdSjgdg1lCZmXAvTczN2ghCpjaHmc4qWeSNpeiJ9B2AenF7e5Tjk3hF8TzCBGgzW/
	rbhpFl/+LD+i6811q2oIsUhNSaKyouwbLvtF+aDjRJvsp8xa+Nq
X-Received: by 2002:a17:90b:5291:b0:352:ccae:fe62 with SMTP id 98e67ed59e1d1-35a21ebac06mr1377246a91.10.1773371078075;
        Thu, 12 Mar 2026 20:04:38 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([240e:34c:5765:adb0:54b3:92b9:a11b:1cae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a24a7dc1csm293967a91.1.2026.03.12.20.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 20:04:36 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Fri, 13 Mar 2026 11:03:12 +0800
Subject: [PATCH net-next v2 4/4] net: no need to disable LRO specifically
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-offload_compute-v2-4-ffbc8ce5d50c@gmail.com>
References: <20260313-offload_compute-v2-0-ffbc8ce5d50c@gmail.com>
In-Reply-To: <20260313-offload_compute-v2-0-ffbc8ce5d50c@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
 Sabrina Dubroca <sd@queasysnail.net>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bridge@lists.linux.dev, Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267291-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E716227CF8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In commit "net: use ndo_set_features to set offload features for
bonding/bridge/team" we called netdev_change_features() in
__netdev_upper_dev_link(), which will disable LRO automatically on lower
device if upper device doesn't have LRO enabled. So we don't need to
dev_disable_lro() again after netdev_upper_dev_link().

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 3 ---
 drivers/net/team/team_core.c    | 3 ---
 net/8021q/vlan.c                | 2 --
 net/bridge/br_if.c              | 2 --
 net/hsr/hsr_slave.c             | 1 -
 5 files changed, 11 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 2c84d3ce3b04..57620e93cc37 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2222,9 +2222,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	}
 #endif
 
-	if (!(bond_dev->features & NETIF_F_LRO))
-		dev_disable_lro(slave_dev);
-
 	res = netdev_rx_handler_register(slave_dev, bond_handle_frame,
 					 new_slave);
 	if (res) {
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 4906ea3717b1..73d4f68a7ccd 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1191,9 +1191,6 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		goto err_enable_netpoll;
 	}
 
-	if (!(dev->features & NETIF_F_LRO))
-		dev_disable_lro(port_dev);
-
 	err = netdev_rx_handler_register(port_dev, team_handle_frame,
 					 port);
 	if (err) {
diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index 2b74ed56eb16..fda3a80e9340 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -193,8 +193,6 @@ int register_vlan_dev(struct net_device *dev, struct netlink_ext_ack *extack)
 	vlan_group_set_device(grp, vlan->vlan_proto, vlan_id, dev);
 	grp->nr_vlan_devs++;
 
-	netdev_update_features(dev);
-
 	return 0;
 
 out_unregister_netdev:
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 030248bc94c5..0aa653a1e651 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -620,8 +620,6 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
 	if (err)
 		goto err5;
 
-	dev_disable_lro(dev);
-
 	list_add_rcu(&p->list, &br->port_list);
 
 	nbp_update_port_count(br);
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index 44f83c8c56a7..4b6ab185392b 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -169,7 +169,6 @@ static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
 	res = netdev_rx_handler_register(dev, hsr_handle_frame, port);
 	if (res)
 		goto fail_rx_handler;
-	dev_disable_lro(dev);
 
 	return 0;
 

-- 
Git-155)


