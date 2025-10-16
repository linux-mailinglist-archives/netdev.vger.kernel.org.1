Return-Path: <netdev+bounces-229854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA3CBE1610
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 05:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9E619C5856
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 03:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62DE1F4701;
	Thu, 16 Oct 2025 03:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgEN+16k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F431DA55
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 03:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760585952; cv=none; b=SFac+jIuu6n38QC+OIOCs9O7r/L2VFfIG9eKUeF3/5hCwtjhqstSczgnV+fakTYaRWWiffg+AiR8mSe/Jq8FiihFwzi7w2doecoBUfVqkQse69/b4czTcVYDeTbgl4+C20T6cles4Pc/rlFbdnvWihq7lozT7ob+z7TG5tFyzh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760585952; c=relaxed/simple;
	bh=wo1CsYkCWbyeO4hgQ/K47IoOTbuwdmMdH8TM1+uW2KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAs8E6JRVcT1ZGI46qfcbpgYtpwMlc8d3aCKMJGT9Yi1kIljTnry4nFlK4F+F1wrxqH3uaWDPzmtiPuPQKEWTPdSPA3CoPXLItcjVNIVb/Z38dk80zdtgrFwf+648GNksTlEOASxRQSsUCBwHFlmTBDebxP4a8dkRyL3HwA0VCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgEN+16k; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27c369f898fso4133585ad.3
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 20:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760585948; x=1761190748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5qn0NKgdBQyC0oF4Dkj2L47WgHW7PlWvIyIP1l643A=;
        b=KgEN+16k2ShoyaSvU1n3h84pKnGdoOU6VovNYbV0xSf67OyGOHFePZDL2cUbuQsTz0
         WzAQr2BgesEMn28sfX3LGS8HUyeE/pR0i4SYeM1SbMQLwHv7obyQiec8nRoGHjAWmQyj
         9OQa5piL1DsE5gVuy2WA93n/zyE2686xOZKe22h+HG3ZIvL8qURXVaPT3sWsik1UM3m6
         pGIApnvvEDDF5AyPrcQPiJ3RcxkNsjaj84SicQI0DoBSifMqxEtdInUC2/K8iF3tGbjU
         5vcR0zZvhOP5Ff4dPX6lmYbQg6/IxSu5haKM9BP93/8O7mXZQX58Cz9lHpeNZRmky2h4
         XfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760585948; x=1761190748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5qn0NKgdBQyC0oF4Dkj2L47WgHW7PlWvIyIP1l643A=;
        b=UY9v1VobkmTw33lJPVv8E5cYbYpZmZYZofTaxUwKTR6qHRty8YVzFeGW+wp0TOTQve
         Ohw3DTcXUCi6EXJVosy96gcYFhwPPz10iNAhjRpf8hNT7caVCQOWqDKLK8CIhI7b4wpz
         zLaJDABO6WaGqZFRaROUAmEPXi483Bvpo7TWHsB8S9F42R/550jp5XVTrlxvf27GKvAJ
         0WHedDcixKDSS4M9ADJYN/9r0iy+NkJe5ASOdQ0VORir1uag/zraIt6IoLoZphD+Fj8z
         qIxXKlPKnLzntPgFipi3hAmfs5lfKyIHM50LXglcTuEO2fCQnmJXO/4vIZnGsWMtSsCh
         ixoQ==
X-Gm-Message-State: AOJu0YwBpoyf7g/Xy5lBbSuSVt2AnQvaNrOSJ85NuP8MG0NcU7rfRGLr
	/0ICUiMf53dm6itxt34fkWbWLyCP8xaSxEeB5Z8G8gn9PU0Xjm/JLwh6a4SB9eaD9Hk=
X-Gm-Gg: ASbGncs0x+hUmabUMf3OkAtATmPm/4RPORXB9UCVLGweQMUl83g/55qi6fcfzw3UNL+
	MINGcGx1tVAZBVNOMlb8dHop2vc1U4WVwmK/zUb5OoIMmtrgDc8JUJFVQHoHrBWKs+1cWvFLITc
	bBx7jKdov/ToU3gTVVZJw3Fkb7DJEmJsiWrKnRyTlPZkcknmTwzhVgGdTUD16uhteUNREFrDR57
	7Rqq44VF1DiaSIqSevGuqqyiKFijyj8fvbYVzitowVwHN3cY++uIwOR2XfKpD9f3PCrOP0xSBEj
	SVmd1RIdHtimMXIsSE19dwukhLoc6Wwp2uI8W3hKTKyr6eFtBJISUNzj5jv76ut4lSBWkECijB/
	aO6vYq8OsNTINNA6VNyAdXUuiCA724CisgwJpZnGGHCbUck+lozbORIZaDU4agGn54nQuGA8KKV
	fmd/ZqgoW18z/AMdE=
X-Google-Smtp-Source: AGHT+IFKwnVYCQ5pyoFx/pbr/4gDxtu2w11uLKogeVEWfYNG0tYvyVVkDAvxXSpbzkW7Ox2gRIOwlw==
X-Received: by 2002:a17:903:2345:b0:24c:da3b:7376 with SMTP id d9443c01a7336-2902726438amr437036485ad.26.1760585948104;
        Wed, 15 Oct 2025 20:39:08 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099343065sm12507925ad.26.2025.10.15.20.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 20:39:07 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv5 net-next 4/4] net: bridge: use common function to compute the features
Date: Thu, 16 Oct 2025 03:38:28 +0000
Message-ID: <20251016033828.59324-5-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016033828.59324-1-liuhangbin@gmail.com>
References: <20251016033828.59324-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, bridge ignored all features propagation and DST retention,
only handling explicitly the GSO limits.

By switching to the new helper netdev_compute_upper_features(), the bridge
now expose additional features, depending on the lowers capabilities.

Since br_set_gso_limits() is already covered by the helper, it can be
removed safely.

Bridge has it's own way to update needed_headroom. So we don't need to
update it in the helper.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/bridge/br_if.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 98c5b9c3145f..0742bd0eaf53 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -525,20 +525,6 @@ void br_mtu_auto_adjust(struct net_bridge *br)
 	br_opt_toggle(br, BROPT_MTU_SET_BY_USER, false);
 }
 
-static void br_set_gso_limits(struct net_bridge *br)
-{
-	unsigned int tso_max_size = TSO_MAX_SIZE;
-	const struct net_bridge_port *p;
-	u16 tso_max_segs = TSO_MAX_SEGS;
-
-	list_for_each_entry(p, &br->port_list, list) {
-		tso_max_size = min(tso_max_size, p->dev->tso_max_size);
-		tso_max_segs = min(tso_max_segs, p->dev->tso_max_segs);
-	}
-	netif_set_tso_max_size(br->dev, tso_max_size);
-	netif_set_tso_max_segs(br->dev, tso_max_segs);
-}
-
 /*
  * Recomputes features using slave's features
  */
@@ -652,8 +638,6 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
 			netdev_err(dev, "failed to sync bridge static fdb addresses to this port\n");
 	}
 
-	netdev_update_features(br->dev);
-
 	br_hr = br->dev->needed_headroom;
 	dev_hr = netdev_get_fwd_headroom(dev);
 	if (br_hr < dev_hr)
@@ -694,7 +678,8 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
 		call_netdevice_notifiers(NETDEV_CHANGEADDR, br->dev);
 
 	br_mtu_auto_adjust(br);
-	br_set_gso_limits(br);
+
+	netdev_compute_upper_features(br->dev, false);
 
 	kobject_uevent(&p->kobj, KOBJ_ADD);
 
@@ -740,7 +725,6 @@ int br_del_if(struct net_bridge *br, struct net_device *dev)
 	del_nbp(p);
 
 	br_mtu_auto_adjust(br);
-	br_set_gso_limits(br);
 
 	spin_lock_bh(&br->lock);
 	changed_addr = br_stp_recalculate_bridge_id(br);
@@ -749,7 +733,7 @@ int br_del_if(struct net_bridge *br, struct net_device *dev)
 	if (changed_addr)
 		call_netdevice_notifiers(NETDEV_CHANGEADDR, br->dev);
 
-	netdev_update_features(br->dev);
+	netdev_compute_upper_features(br->dev, false);
 
 	return 0;
 }
-- 
2.50.1


