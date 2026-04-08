Return-Path: <netdev+bounces-276593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNdSALZz1mkWFggAu9opvQ
	(envelope-from <netdev+bounces-276593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:26:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD973BE2B3
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CE0930801B6
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 15:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B293A3D566F;
	Wed,  8 Apr 2026 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="dwXvOGpJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f228.google.com (mail-lj1-f228.google.com [209.85.208.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0259F3D3CF6
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661840; cv=none; b=AsM0zCPI0Lq1WTJSxfEO1uQftNv1kY6tXr+b0Guif8RsQO4v4HAV0jllIE4hXyFIubwKrjvUSEdEL+OQLCpVV5nsmnrOHjDzydGePb9iUDBkS52erSGHuzEteRTBM+B7GO1GCKrxj6Sx2ncTc8l+yo05mGR7+xxFVZyKwAyZgYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661840; c=relaxed/simple;
	bh=97AUclMQLtRzFwFoOxnQsLuecfk1+SrlI3T+bK+uXm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FaWLkGbFNq6TLYxRrRRkDmbmqur/a8oomaMKYgUQ/BHa9RsG4u+tgS2D2s09vYV/5e2+5yLWkh58y5IEzkuzYEYKToRrhRYV1I/eIM7Vn5frYOdlP7uhjLTewqS5LDi02nfwNHDUhHsAdtsnZv7o6i4wfKXGmoqAVGfgQI7zEtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=dwXvOGpJ; arc=none smtp.client-ip=209.85.208.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f228.google.com with SMTP id 38308e7fff4ca-38df27b25e3so352991fa.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 08:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1775661837; x=1776266637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KD5D8brxCmuzBKqAnv0UgR0asFaOJvhZvK86/nmy4G0=;
        b=dwXvOGpJLCy6hZqqGQbtkqT779fVRluRYV+vhLfclsSHE/OtoqfjHCxf4nfhRByatM
         NBNPn2V0M7m/NDd8bkvMyliSpdb2sCQBRuP0Ps9YDWFH3YSz4RHz7VufhJlwQBypP0Rd
         xQTgUs/SlMGhnZ5P5QeuzxP1Wsw1mCyL+8+OcAzGkTMHNcqnwO7ZdlhjRYrA9E+JHZtJ
         hBjPXS+dJs9/5Kp0VEr7Gs+BLF4ugOVZgRV9HiEiPGphHCUPEKVchQ/yPN6Z44gDq5L9
         lxLrSGpU7i1uYsAysu2RYtsJzqRPG56B/pvb4/fi6oZlgC2fypx0ifzNnIg/3MoSwnl+
         YlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661837; x=1776266637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KD5D8brxCmuzBKqAnv0UgR0asFaOJvhZvK86/nmy4G0=;
        b=iiXXJTM15aRoXgkce7dVE0yCaYl3FwE+/C7IMGQVOjFPVOGBZEhfm3dub7fiOgFCgz
         dYZFUm6BGDkUU+n6EaDWPiEl+y2TKLqB6yuB6kFPciDk7zRN0xclzm+HuvPFrb3iI3aq
         s998OlUptJimdzUf8bJ50ndcpzmy1Iyxxs6ZgQvZsux6rYVyEL9FQbEq1sE95R4xe1wW
         GSlNhHOBKPTEivGlz3sOSVHY+qZZpovqjx0UXQB7XVQWprhpYr4EnabeBSq4pRYiA+6S
         fNRlzsYI8oBGdYVlagVXcTT2wk30ov6mK+vHzapMwHi1nX4EcHH7KtjTOseO58GnFPpH
         D9jg==
X-Gm-Message-State: AOJu0Yz5hJj7/sIirfsSmFds1SL8KFwjQEgnW5B7XLk0L+Jr3C5rdadH
	K4FUUmw4D8moHmX8DFm1kQJ2k1VlgpJKfXyjLUIu9dXnu+d6dK9p8p6sG+r3yeE4rmgpwOqc5jo
	dmO6JpZPTr0nIGfBwqKoymwQXRupFSylBm6gD
X-Gm-Gg: AeBDiesYWW5gk4yX/YiObg2+3x8peC6fDXhkWvkBIJ41X9EBUSLue70F+TH7XHLNPlD
	NKuqE8nx53oYWzE5qOqe1P6gKdLQjOqJSYuYBUYKbcPmURS8buRF5i0An7G2byI/J/Bncxgdc2i
	lTjYI7KRE0X3Kvd93gMo10lxS7zvQp6sIwykiAiAsSI6+jmQA0vPcfWsXf2F0yhJQy9IsIfUOes
	RhB9g6Nm1RQfV/VXDDaf9J85uU/rEbzSjqybMeSXVvG4FMrYLoOKBndzCKcVHCAuaKgEilqcZpu
	YsQ8mOREdzUzdMGlzLnGp+D3Ci4uUcjcTeAl6yUScaphI5Sk4/4XPSvRaS0YcPcoqNQJbBzTDjU
	dipdgNN7Ymuj0trlAOtjFakOMyx10FDuyq/yDXGOR3evOMQ7+pYS7
X-Received: by 2002:a2e:bc14:0:b0:38e:1304:d2bb with SMTP id 38308e7fff4ca-38e337675bamr298251fa.35.1775661837006;
        Wed, 08 Apr 2026 08:23:57 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 38308e7fff4ca-38cd212d1b3sm17315841fa.13.2026.04.08.08.23.56;
        Wed, 08 Apr 2026 08:23:57 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id A8D2327053;
	Wed,  8 Apr 2026 17:23:56 +0200 (CEST)
From: Louis Scalbert <louis.scalbert@6wind.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	jv@jvosburgh.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fbl@redhat.com,
	andy@greyhouse.net,
	shemminger@vyatta.com,
	maheshb@google.com,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net v3 2/5] bonding: 3ad: fix carrier when no valid slaves
Date: Wed,  8 Apr 2026 17:23:50 +0200
Message-Id: <20260408152353.276204-3-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260408152353.276204-1-louis.scalbert@6wind.com>
References: <20260408152353.276204-1-louis.scalbert@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276593-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,6wind.com:dkim,6wind.com:email,6wind.com:mid]
X-Rspamd-Queue-Id: 9CD973BE2B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Apply the "lacp_fallback" configuration from the previous commit.

"lacp_fallback" mode "strict" asserts that the bonding master carrier
only when at least 'min_links' slaves are in the collecting/distributing
state (or collecting only if the coupled_control default behavior is
disabled).

Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
---
 drivers/net/bonding/bond_3ad.c     | 26 ++++++++++++++++++++++++--
 drivers/net/bonding/bond_options.c |  1 +
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index af7f74cfdc08..b79a76296966 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -745,6 +745,22 @@ static void __set_agg_ports_ready(struct aggregator *aggregator, int val)
 	}
 }
 
+static int __agg_valid_ports(struct aggregator *agg)
+{
+	struct port *port;
+	int valid = 0;
+
+	for (port = agg->lag_ports; port;
+	     port = port->next_port_in_aggregator) {
+		if (port->actor_oper_port_state & LACP_STATE_COLLECTING &&
+		    (!port->slave->bond->params.coupled_control ||
+		     port->actor_oper_port_state & LACP_STATE_DISTRIBUTING))
+			valid++;
+	}
+
+	return valid;
+}
+
 static int __agg_active_ports(struct aggregator *agg)
 {
 	struct port *port;
@@ -2120,6 +2136,7 @@ static void ad_enable_collecting_distributing(struct port *port,
 			  port->actor_port_number,
 			  port->aggregator->aggregator_identifier);
 		__enable_port(port);
+		bond_3ad_set_carrier(port->slave->bond);
 		/* Slave array needs update */
 		*update_slave_arr = true;
 		/* Should notify peers if possible */
@@ -2141,6 +2158,7 @@ static void ad_disable_collecting_distributing(struct port *port,
 			  port->actor_port_number,
 			  port->aggregator->aggregator_identifier);
 		__disable_port(port);
+		bond_3ad_set_carrier(port->slave->bond);
 		/* Slave array needs an update */
 		*update_slave_arr = true;
 	}
@@ -2819,8 +2837,12 @@ int bond_3ad_set_carrier(struct bonding *bond)
 	}
 	active = __get_active_agg(&(SLAVE_AD_INFO(first_slave)->aggregator));
 	if (active) {
-		/* are enough slaves available to consider link up? */
-		if (__agg_active_ports(active) < bond->params.min_links) {
+		/* are enough slaves in collecting (and distributing) state to consider
+		 * link up?
+		 */
+		if ((bond->params.lacp_fallback ? __agg_valid_ports(active)
+					: __agg_active_ports(active)) <
+		    bond->params.min_links) {
 			if (netif_carrier_ok(bond->dev)) {
 				netif_carrier_off(bond->dev);
 				goto out;
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index b672b8a881bb..d64a5d2f80b6 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1706,6 +1706,7 @@ static int bond_option_lacp_fallback_set(struct bonding *bond,
 	netdev_dbg(bond->dev, "Setting LACP fallback to %s (%llu)\n",
 		   newval->string, newval->value);
 	bond->params.lacp_fallback = newval->value;
+	bond_3ad_set_carrier(bond);
 
 	return 0;
 }
-- 
2.39.2


