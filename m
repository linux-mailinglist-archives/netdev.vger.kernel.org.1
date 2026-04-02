Return-Path: <netdev+bounces-274717-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDGDEyLvzmktsAYAu9opvQ
	(envelope-from <netdev+bounces-274717-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:35:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B81B038ED2E
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0ABD13042D59
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 22:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5168A3644CC;
	Thu,  2 Apr 2026 22:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAFlTRjh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ACE361DD5
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 22:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775169300; cv=none; b=Aawj5RGGwPRXc/MUnjPjQWQyWcYb/f8b1LkhhYRURE1kJl7P61Co+q7CMYA2Kg9qcTwl1IRgwLOxS0NbBsYoZ8gv9B8acZCCCZRjKc/2qjRI9g3damlrTatpHqg8FoceTJw0FEO761M5HRj/FPUILptCiux8iKhMuwKjq/ANwV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775169300; c=relaxed/simple;
	bh=KPexC333eb34zS3PfEVcKAKyFzm53MCuqOBlOePmQX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKxBsLfu5tUgUcl4TchIxRdiKzie1/843Y1Dwrv5mfdTuCbdhujqeiRPKViVJQcyKvuPJ7r/KTLGAwPE+okuq3bRH3g10XJky1i9+WLi1KPcQImgDXEerVvuluLsOD3gauiZC7VWH3CFJtc/tyW35szmieO/MWGAlg9+oe0yLCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAFlTRjh; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82cf976ecacso590606b3a.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 15:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775169298; x=1775774098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lW/VlXUdeFCkUi3iqS6PQC/Ta0LMb5eS11dnPAhYywc=;
        b=RAFlTRjhUqTPXpEo9lHke3NAdnI5sTFXsAlZzttBr92mdv4CUmM1AkZKFgk8Dwxxvk
         J7+yFS7IAa09j8tZQW6bUE6rWkai/HJ2T0AXcaZG5YM9NoHJuCB8vKL3jV0M2R4l4cgT
         Vfi4iJ2xA4ZoySQWrjhe3gKw8LxsnlAeONllnYgU/Eoa6q6s0QuAuB11mfrdA98OGMH0
         zaI1uDp3nWLom1H6jQKY6WBTeS/zbX/hUFldl84pb1RgymcHPH2pde7dpKj2jNHhfnhw
         UCHpA0f2U2DIrc2pwTAFOgLtvaVpJkO8gFDdGxlhzNjTHP0iDyE5fDyepHttxXQ3fitA
         ubEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775169298; x=1775774098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lW/VlXUdeFCkUi3iqS6PQC/Ta0LMb5eS11dnPAhYywc=;
        b=pWnJwqwMy78NEifrCLfXsi6wbU/XUJ6ECtpTFuZ+4eJ22nnBFwVBWmr+eEGXU3uazd
         m6m1C1gEy460V5DSMtUZcLJCED6gdIgOgvmvDblWr4D9meSHgwaj8Pz8VGTuoCqihCjB
         mJie/sRSsohANiaqahY9qNbqRSWi9kvVWiVqwVLOLszORWXg85205+qKFQ7dpPigYmQA
         DrsF7h8L+kp7eOphS/vb4rGnA3ycNXOqk0y6hJAQQpT8SnwQTgXj5ZBBn4pnOAGbD5od
         A5fazZ4cyLN5JOT8n0qhjthsc2QQsHIBK+A9YHWWno0t9h0j+zgz6AssagVF0wQulJKF
         /SFQ==
X-Gm-Message-State: AOJu0Yx3KUKF0eVlBeHGBp+SfXxyT29VFIRCSUlzEbsDE3ONL7ZJT7N5
	IEkOL6wiH9yz6Qg5Hoi7if4LNgEnJqjlsElS7f51ty9dtf34CsXCG4xhZ6V1sw==
X-Gm-Gg: ATEYQzztHm+KmKyTJbPkZwVZIWAyr981WMjZ9mew2FRzU5SOlFOUbEqEmMDa3kG2bYw
	+JhCUk+hROsfT4aLwla8adW91M+AXcm0Yr5ZXv12cxOc6X6yhVc2bK4VxyusMFwNbEVQUA/jV94
	Yz+Wz8xtGM6I7qYGQuWXZl6O02eh2tjDC1odEShDXNDdVuRM0AFFnbtAwwyH0pjZsSAzaN75eUV
	W5iu8RIdboJ8G+4ljfPgXOfRj+v9cEnkVjjqMHgUDwpZZtxBT56rkwTyvI4ydDf/60u4YMsumDH
	ofEcqIaZiah05xgBOO95qahINvPx7Ttthp+iOdiyDv3ZkhGl/BeGP4K4Gj4C8f5EW3ypZ3gmk3m
	0LSK9oGcpu1XYA66cQsvLQuv2l40XNQ0c5fmpSc7YsY9AyP0qXUSlPscmxPxR9kAEOVLBAt7K8O
	OsWc4nLsPc2DPTmOemIAucMNeynFUfTI86pa8CRh1oubpQ2x1Jmg==
X-Received: by 2002:a05:6a00:3902:b0:81e:ef16:b288 with SMTP id d2e1a72fcca58-82d0da53a40mr721497b3a.22.1775169298313;
        Thu, 02 Apr 2026 15:34:58 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661f:3046::4cf:90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca1f28sm4294291b3a.57.2026.04.02.15.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 15:34:58 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next v2 1/4] net: dsa: pass extack to user tc policers
Date: Fri,  3 Apr 2026 06:34:29 +0800
Message-ID: <20260402223437.109097-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402223437.109097-1-mmyangfl@gmail.com>
References: <20260402223437.109097-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-274717-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B81B038ED2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Users may use extack for a friendly error message instead of dumping
everything into dmesg.

Make the according transformations to the two users (sja1105 and
felix).

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/ocelot/felix.c         | 3 ++-
 drivers/net/dsa/sja1105/sja1105_main.c | 3 ++-
 include/net/dsa.h                      | 3 ++-
 net/dsa/user.c                         | 2 +-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 84cf8e7fb17a..4272ea6e9ca8 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -2001,7 +2001,8 @@ static int felix_cls_flower_stats(struct dsa_switch *ds, int port,
 }
 
 static int felix_port_policer_add(struct dsa_switch *ds, int port,
-				  const struct flow_action_police *policer)
+				  const struct flow_action_police *policer,
+				  struct netlink_ext_ack *extack)
 {
 	struct ocelot *ocelot = ds->priv;
 	struct ocelot_policer pol = {
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index c72c2bfdcffb..dbfa45064747 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2847,7 +2847,8 @@ static void sja1105_mirror_del(struct dsa_switch *ds, int port,
 }
 
 static int sja1105_port_policer_add(struct dsa_switch *ds, int port,
-				    const struct flow_action_police *policer)
+				    const struct flow_action_police *policer,
+				    struct netlink_ext_ack *extack)
 {
 	struct sja1105_l2_policing_entry *policing;
 	struct sja1105_private *priv = ds->priv;
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 6c17446f3dcc..1cc627e23c07 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1106,7 +1106,8 @@ struct dsa_switch_ops {
 	void	(*port_mirror_del)(struct dsa_switch *ds, int port,
 				   struct dsa_mall_mirror_tc_entry *mirror);
 	int	(*port_policer_add)(struct dsa_switch *ds, int port,
-				    const struct flow_action_police *policer);
+				    const struct flow_action_police *policer,
+				    struct netlink_ext_ack *extack);
 	void	(*port_policer_del)(struct dsa_switch *ds, int port);
 	int	(*port_setup_tc)(struct dsa_switch *ds, int port,
 				 enum tc_setup_type type, void *type_data);
diff --git a/net/dsa/user.c b/net/dsa/user.c
index c4bd6fe90b45..8704c1a3a5b7 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1499,7 +1499,7 @@ dsa_user_add_cls_matchall_police(struct net_device *dev,
 	policer = &mall_tc_entry->policer;
 	*policer = act->police;
 
-	err = ds->ops->port_policer_add(ds, dp->index, policer);
+	err = ds->ops->port_policer_add(ds, dp->index, policer, extack);
 	if (err) {
 		kfree(mall_tc_entry);
 		return err;
-- 
2.53.0


