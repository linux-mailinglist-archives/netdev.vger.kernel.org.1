Return-Path: <netdev+bounces-277076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEN6C6/e12klTwgAu9opvQ
	(envelope-from <netdev+bounces-277076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 19:15:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8427B3CDFCE
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 19:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31D6D3032074
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 17:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F53D381B1C;
	Thu,  9 Apr 2026 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHSVoSHD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A960F3E1D1B
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775754746; cv=none; b=f6IZWGQuDHAkxk15zkjFrDAXPZ8XbhqURnUint20CdmEBQHyVSscsgJlnuAtrGT1NLhNvTH1n6jHiDRERsqfRVpOefnNyjMY72T7fR940Ec1zC2hoCfzdHWfXKtw0zd2wvx4ldxsEgvGY1y8Sm7Dojm3+KO68I3hNo27dTrhzBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775754746; c=relaxed/simple;
	bh=v+E1MO93EOHLyDkpX6IzNEHlsvKdg/1FgUS+hyR8of4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDh99X6dfOi5DICVYBOi2R2Zg4NVSlBVtW9lOYpA2CG5bGAW0E0L5F1qbq+Dyaz9Tb0TSbfWupDvh/g+Mr02lj3KYPjzMNfsr6car/khpDDU1EBMZK0jyN8jlUOC95fp424XxLsnva9tILman99IH0l85SxID8lrlHCUBgkzsOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHSVoSHD; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b258576d8cso7383785ad.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 10:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775754744; x=1776359544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vm1sew/8xxotCRJE85MOTIviBnsMsznbuVyL8JjP6fo=;
        b=aHSVoSHDH4CIuZL5YI2Zv7fxmn3Tq+Vt52wH8IY2WZDLIhRWCOCS8i4Zq4qy/pmcdY
         M24UI+t2qnRtIXFvPRgGwjSvb4HmKSVKMrEqrwPPo+KqdPBWkiPi+X0D4cCpGND2+UcA
         3yZUXYeBm/u+U7p85iifLIHhHeHiEBkJyjYfjJNsr6fjRQALLKbDU0lOP5qGkJI2pBUX
         vIxr+/vZNO4CwLg2uPbh77meRsmWGRMZNq5e6JS8nflGeUM3PrPvJDje4NYdjX4tdk69
         mHb/TZLwqbKkaTsWkoerRmPlStDVNFeX3KyGG4zJIaafWq57QbtPyWnHwHVsQWOnDOPw
         C1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775754744; x=1776359544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vm1sew/8xxotCRJE85MOTIviBnsMsznbuVyL8JjP6fo=;
        b=MdIrGpCHcqy3/+ZH9ffNKtp36YNmRng0OLKu3jfngklOCNuPVeLB216rz3buSPXBC6
         FnaPtuAl2+AWwUG6MikDE2DlfMHRvHHEZLhk/bGPXV+8TG8J/QdAVY9wWtWJOdpUwlnM
         UvGvvnfwgYLGTICholn4gTN1Xui5IH6YxFHlb2d4e8yOdSSxHHJyePkvF5o6pUpqqCpa
         Spfk/5u1qJbgINzFX9EMjEEarTJot4GS8j+Wwz9eaquVooeNcrkJsyBnOdTo9EOOirP4
         2exZj6wsLn1Q5prASO5ah53zRMrHbtgT4hf85995dydnNmtuHNtccKJK1htbNMJQchWl
         qDjg==
X-Gm-Message-State: AOJu0Yw8erL3VYOXSJZ6CDwvSM6U2NOrLkGL6Kr62U1oArLgrWD19Boy
	Tn3KLzadkcaBRVqG55PsqFuT6DYY+4yCWE4mDTg5MwLcxGMc2F6MPiXwsfVRkLh8
X-Gm-Gg: AeBDievBN322GV1+uf2c3NEo10qpkdUbxdUJPDhCyzPHRXChPh8FJ02OP1uaCPWgYjB
	W+6zKuKsQW/OYPVXXvvsChABrFOSofZp0Rb51OpmYAWwkHqGBYFdvQqzpWG9Vmz6MKSLQTJHzSE
	7urj6Mw/FHnYwBaLJgEeYdeG24j0HaPFiZicPMFqdIzClBJyGrwGihXXdR8ayZrWt+2AyvZWa3/
	MvIG5ZGrZF8X9jEwiJl91P9glpM3+gF89mt/BZAqfUwQ1gudyqPGvS6/q2JwsToqevW6KDT/Rk+
	/wbpImmdFHgvAwiT6EGMJO0UadWioOoSeWY6qrtI8X6xrIy4fCKdV5zprZPhkQ+yWpwhhiDcq9q
	jZflU0Py38UlBh9YfpnPF7BNj1rmfa6pOsNaFZZQzQP0qewbNmYBqWZ51xdo1iQVZ52xfqC9n+0
	x49Ey9us0ZP6SfCg4nLXNODrm3XkLmaipvP3aPnqm8kAP8zDr4grtXSxSktfU=
X-Received: by 2002:a17:903:1ac3:b0:2b0:673a:7c85 with SMTP id d9443c01a7336-2b2818ee1f6mr267644805ad.37.1775754743809;
        Thu, 09 Apr 2026 10:12:23 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:d30::4cf:90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f08d1bsm752395ad.54.2026.04.09.10.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 10:12:23 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 1/4] net: dsa: pass extack to user tc policers
Date: Fri, 10 Apr 2026 01:12:01 +0800
Message-ID: <20260409171209.2575583-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409171209.2575583-1-mmyangfl@gmail.com>
References: <20260409171209.2575583-1-mmyangfl@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,nxp.com,microchip.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277076-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: 8427B3CDFCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Users may use extack for a friendly error message instead of dumping
everything into dmesg.

Make the according transformations to the two users (sja1105 and
felix).

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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
index 8b6d34e8a6f0..4cc67469cf2e 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1122,7 +1122,8 @@ struct dsa_switch_ops {
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


