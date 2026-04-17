Return-Path: <netdev+bounces-279325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHcMBSA+4mmB3wAAu9opvQ
	(envelope-from <netdev+bounces-279325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:05:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BE341BD9D
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1E293033851
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748B63AC0EE;
	Fri, 17 Apr 2026 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="fdvZqWUC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f100.google.com (mail-ej1-f100.google.com [209.85.218.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2124432AADE
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776434711; cv=none; b=HRENe2gf2Fl6CdiKwuKzevPMt0YS8fgBC2/NSaRChZwyHAs7PMcbIMKableR1rY3Zw1w6wketTqFmy1RO122+7+KUsFTHJ5TOLiy2P6+LY2ksR7+gcTcO0oPFfZjVjF3Oyytsyhk0ThCAt7QkvYolEf9WJoEqmVu4Qa4LwTkynA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776434711; c=relaxed/simple;
	bh=yh0OrZzWAlIPWv5o3va9W/qhxUusMuFRFsSEW7wKPNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qFxeb8XiQROzjqaBlCLj6P24nFVYQDHv1HkNYLMJLxUYrLMP4+75unypgTLfTV+VP+jKTWNqYMCokpjsfMJoyjJvjzwsONWQz6KqCTyGjNGxRzq3HioQqMH17lT+abE6r/YyD5th8I/qrV6xlrWLGLf7twDbYhzrVd4amEaU4zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=fdvZqWUC; arc=none smtp.client-ip=209.85.218.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f100.google.com with SMTP id a640c23a62f3a-b9c603ec2dfso103588066b.1
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 07:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1776434707; x=1777039507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmyeYZnaYawcjxcGUJxFoiDCk62gW76hdmXLKmPV6bM=;
        b=fdvZqWUCyCmHikTC75Mw8szid30PfgwrOobhKA1j81bVYsp97nRW+IkhFAatbiT84j
         4dcyB4cm1SGD/XZ3/L5OeXqJyh0SYVa8rGqS9or8MocqmOxw2D7VUHZWWLoR4G9RRjoA
         Oqcs4mdyBGh/T0GBssu7BXfE0ecgOyCfpnCwZj3i8agvvwy56zbcQ65STmUioKbRuZJu
         hLV4TStNCAO4RPtw3Kr9Fr6R2mqU/BR9S1det6uH5oYkX4hvbkfkWEj84+mgZuetrxAT
         6vrV31og0oLJblbIjX28F4zkPB3JRHt5fA7yDj5Alf3Mm6lyNK8ndQEERkrvQKxVj1xI
         kEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776434707; x=1777039507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QmyeYZnaYawcjxcGUJxFoiDCk62gW76hdmXLKmPV6bM=;
        b=lmERAv+q9VQi16Sbzv8ShKzkO7jDCt0xBD+wFdzW1gKAk4aenXbDQ3jRnKBR2EYgUB
         jbfuziDhKCx+I7I5IBOqCQ1w9qOMQOjYWIawN0CE7xVKaN2FfqYbf++fe7K1jPNBhqyj
         /F9wwwNzLIZdCpiIfTaOgPN/g4WfaUNW2sZltbZeQ4j7pOIRQoYzKCt4sKGWbDDgPjGz
         XPqm+KR8gSUgLwiLDDWHGtkKH4YPxG83NUcop0TGYJ/Ki85L5q59kPpQlpLfDzZJwmB9
         gIa6uPtYViVaNMB6It8HjISVSeO2bcVA0+AzSRcMaKT7inCHTqlNwkAtcCws2ZL+LQGG
         Xh3A==
X-Gm-Message-State: AOJu0YwahyFuOJRayggct8Jtjm6Lvy2mlcc4L2UEcWoENPX9bY5e3DJ1
	TwK9N2KNSI5tqmXpIObqZyz9FCxMKS8NLJ0T1s+Q3TNRgQWK6YSed56WhoDqneqjR6yw49MlD9y
	nNz/eCwxq6Wgk+IJcgWSteDGGbrlt1oU0s/1R
X-Gm-Gg: AeBDievF9adtPdGxE83QYTeZHod2EfO92whZpUACk8tsF419EO69UBek+vlR55eKruk
	3TuCJ41CdmNftV98aHEs2/7peVgAE4kFbWMhbu8hbOf29wvGjbZ/LR3phYxAHptP42eSYpjCKUA
	c/P9RU4aM1OIjDj8nynPY2GBMuZjawUzXXKcz4Qy0qUwbCWUbaIqZkRj/wQ8WasezxwlXCI5A65
	cOsLoeoZZPtyxFZyHyN9MnhzbSP06fA8M1vNENIFgB2hcEWFVjRjP9lk3q+HlUQNykisspVtioi
	CfeSqnKSo/v8T2lOhIXFy00w5eHnXAM1lcXq3nIuYF6hWhAqUz6h9ry9uSBhdCyjt81rz+48Yq6
	bEPNCmRbfNmZL3tLzFPnfhBbpJqmXdGo2UXoi/cudNghXmuEszBZ+3vi33bfIYTQ=
X-Received: by 2002:a17:907:934c:b0:b99:d2d9:da47 with SMTP id a640c23a62f3a-ba41828cb23mr158535466b.2.1776434707339;
        Fri, 17 Apr 2026 07:05:07 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-ba454e2813fsm13434266b.76.2026.04.17.07.05.07;
        Fri, 17 Apr 2026 07:05:07 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 2B5841364F;
	Fri, 17 Apr 2026 16:05:07 +0200 (CEST)
From: Louis Scalbert <louis.scalbert@6wind.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	andrew+netdev@lunn.ch,
	jv@jvosburgh.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fbl@redhat.com,
	andy@greyhouse.net,
	shemminger@vyatta.com,
	maheshb@google.com,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net v4 2/4] bonding: 3ad: fix carrier when no usable slaves
Date: Fri, 17 Apr 2026 16:05:03 +0200
Message-Id: <20260417140505.3860237-3-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260417140505.3860237-1-louis.scalbert@6wind.com>
References: <20260417140505.3860237-1-louis.scalbert@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279325-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[6wind.com:email,6wind.com:dkim,6wind.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9BE341BD9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Apply the "lacp_strict" configuration from the previous commit.

"lacp_strict" mode "on" asserts that the bonding master carrier is up
only when at least 'min_links' slaves are in the Collecting_Distributing
state.

Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
---
 drivers/net/bonding/bond_3ad.c     | 21 ++++++++++++++++++++-
 drivers/net/bonding/bond_options.c |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index af7f74cfdc08..9cf064243d58 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -745,6 +745,21 @@ static void __set_agg_ports_ready(struct aggregator *aggregator, int val)
 	}
 }
 
+static int __agg_usable_ports(struct aggregator *agg)
+{
+	struct port *port;
+	int valid = 0;
+
+	for (port = agg->lag_ports; port;
+	     port = port->next_port_in_aggregator) {
+		if (port->actor_oper_port_state & LACP_STATE_COLLECTING &&
+		    port->actor_oper_port_state & LACP_STATE_DISTRIBUTING)
+			valid++;
+	}
+
+	return valid;
+}
+
 static int __agg_active_ports(struct aggregator *agg)
 {
 	struct port *port;
@@ -2120,6 +2135,7 @@ static void ad_enable_collecting_distributing(struct port *port,
 			  port->actor_port_number,
 			  port->aggregator->aggregator_identifier);
 		__enable_port(port);
+		bond_3ad_set_carrier(port->slave->bond);
 		/* Slave array needs update */
 		*update_slave_arr = true;
 		/* Should notify peers if possible */
@@ -2141,6 +2157,7 @@ static void ad_disable_collecting_distributing(struct port *port,
 			  port->actor_port_number,
 			  port->aggregator->aggregator_identifier);
 		__disable_port(port);
+		bond_3ad_set_carrier(port->slave->bond);
 		/* Slave array needs an update */
 		*update_slave_arr = true;
 	}
@@ -2820,7 +2837,9 @@ int bond_3ad_set_carrier(struct bonding *bond)
 	active = __get_active_agg(&(SLAVE_AD_INFO(first_slave)->aggregator));
 	if (active) {
 		/* are enough slaves available to consider link up? */
-		if (__agg_active_ports(active) < bond->params.min_links) {
+		if ((bond->params.lacp_strict ? __agg_usable_ports(active)
+					: __agg_active_ports(active)) <
+		    bond->params.min_links) {
 			if (netif_carrier_ok(bond->dev)) {
 				netif_carrier_off(bond->dev);
 				goto out;
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index d358b831df77..94b7b0851f16 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1706,6 +1706,7 @@ static int bond_option_lacp_strict_set(struct bonding *bond,
 	netdev_dbg(bond->dev, "Setting LACP fallback to %s (%llu)\n",
 		   newval->string, newval->value);
 	bond->params.lacp_strict = newval->value;
+	bond_3ad_set_carrier(bond);
 
 	return 0;
 }
-- 
2.39.2


