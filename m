Return-Path: <netdev+bounces-289907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGUqAqqhDWq10QUAu9opvQ
	(envelope-from <netdev+bounces-289907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:57:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD0C58D17D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3580532A2F82
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA5E3E929C;
	Wed, 20 May 2026 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="BbSqnLlZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com [209.85.128.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A328F37D133
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 11:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779276347; cv=none; b=Jy9c7WKEx9kMDEnYSELTLJyrHJkXwDgSEM5BA7pDw6ok8rYdEFyFlmfjxLAGjQ2sdKowHZizeV1IDliw+Z3PiRgy9iI8/FwWVVx8aw4gkLn6eSHhhDoR1wt0K32EwltaqNwEyZijDtZKTumE2H7ctfKxMFQ96yZcvunHUiMrDJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779276347; c=relaxed/simple;
	bh=5D0WxI713FBvDeddEujw4c9zetJUmOcKk9K5e8cSEJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tmN6pfhp+EjSCk561EqHcQ24hpHhLAs5RdEWnE7ObodtHJ/7SnRrY741JUC+DADErOsmfkg+GGJ9Zhnx4ZoLdIjnSjLhVi4IP6G2IsizEkHAuscWMcnxpJO55llJXLyVoLgsh+ymJPbep+WDIXeKOTNO3j1OpvxnjM7SJFJ1XoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=BbSqnLlZ; arc=none smtp.client-ip=209.85.128.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f98.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so30635205e9.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 04:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1779276341; x=1779881141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyEs4dLj8iehL7vjvTrWPcDCPVxX9KcCGdrInqBS79o=;
        b=BbSqnLlZC6DNcy9pRyou/ORWPmM7XVcySY/hsDh4W0vmILfJ0S7AU8Gw6TkFBf4NVD
         z+gnRcSNS8uYHSgYa/f3qStVXhNCnp9lRL9tXQZYvUT5OWEYWslB268maS0Zya9B9wm3
         /tK8QzzrUlU7panTpu4KH/g/HWBUOFdKQX/0OXop/zLEgJ2kJff+SM45JGAtVNPfAiPn
         yl6cib/QWyW7u1Ly/6UENbmKoFiiLSLk3PKQGQrVA0yEMUsTOXiBspMvnXzSHQ9xQqH3
         rENfT37xK9Bm3LC1OTJotlXVA+8os25xQvQdS+YTyuSezIBKPyLZMEq91JdN7wpHbE1r
         dzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779276341; x=1779881141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zyEs4dLj8iehL7vjvTrWPcDCPVxX9KcCGdrInqBS79o=;
        b=KcQJX3n/yuTL3RUOAhMsEtK+WiRO6nNsHWksjaTrHU6dK01e+vXG+wLzsOxS3fGbph
         DXt3Y7gC7psa/NM0CNhY0BGsDp3TKkD6Yl+cWlCV9rvdCnB7XSUKCDL0p+NFlWZD6951
         ExcLxbpHIXQvFbYkhkaNsWu/AFN4auxs7ljlvaL2zmP1jixtSCvz3OXPE+s6U6za/xAh
         3hxEDS+xnbnqGuPXgDP7SggVM2V+anPHyNYoXR7+WhwacJ2tq7TKKj1Q2k8NaMIubwy6
         6BbPSg9oNua8Y/pwGoWKWE0wg1csjZDA0EYp14qdq56LCg01JY9LHQTrnysJM9yYHdLM
         Xc1w==
X-Gm-Message-State: AOJu0YyYcdbd+5TxqlRsq9pXoBZ3ItRc7cn1FxV5LF3wx6mda13H9RB/
	3MUMoAjWV8ioAMFwvgslLukSUxACUn5ktoV0Fyo6OjkG/h+gfVjGYjuzUKCUOQHX1GiZO/n/dlT
	pOzJ3G/N+SF/L+H8sTU8HjQfSOazLz+t2huPz
X-Gm-Gg: Acq92OFJtR2r+/6EvUqqq4QwuwlQmqlOI3br1e5BbglRZv8tXdHqOUM1DXh5bfcs7KW
	4K5O0ZmbaSM+aTYTqwpXzNGa0iRxTEeyMFFxnJsP2uZBw8BWFaXCJtz1Vg132GDJ+zDdcPTtRSI
	dwd+EJmrfMVxyx10txN/elP7WkNxQlOV9ifUhXwDayAQM/MVulawets2oM+0q5aIv1I6dnLeuc8
	S10Lcg+/zRpfiAxBBGysK2Y+oiFotJsm9wqUa1cIXkqmN3nJgzZZe/bELzxWRVar9rXUvzXqmbR
	Ey0M++K0gTa/4AO2/cE0ZLD/Ud2wdlCAIoyeEVPMq25jzx5t+j6VizIuteQ6ujiopaFNKKbZ+8Z
	h+H3lvD8BJionMSHGPPcR8Ip8+krn/AJ4mw5jJZjo19AXet272uVH
X-Received: by 2002:a05:600c:5010:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-48fe5388407mr336486395e9.12.1779276341457;
        Wed, 20 May 2026 04:25:41 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 5b1f17b1804b1-48fe537c3f6sm5376485e9.15.2026.05.20.04.25.41;
        Wed, 20 May 2026 04:25:41 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 536571153F;
	Wed, 20 May 2026 13:25:41 +0200 (CEST)
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
	jonas.gorski@gmail.com,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net v6 2/4] bonding: 3ad: fix carrier when no usable slaves
Date: Wed, 20 May 2026 13:25:37 +0200
Message-Id: <20260520112539.798275-3-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260520112539.798275-1-louis.scalbert@6wind.com>
References: <20260520112539.798275-1-louis.scalbert@6wind.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,jvosburgh.net,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com,6wind.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289907-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,6wind.com:email,6wind.com:mid,6wind.com:dkim]
X-Rspamd-Queue-Id: 9DD0C58D17D
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
index f0aa7d2f2171..1247a1e048df 100644
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
@@ -2128,6 +2143,7 @@ static void ad_enable_collecting_distributing(struct port *port,
 			  port->actor_port_number,
 			  aggregator->aggregator_identifier);
 		__enable_port(port);
+		bond_3ad_set_carrier(port->slave->bond);
 		/* Slave array needs update */
 		*update_slave_arr = true;
 		/* Should notify peers if possible */
@@ -2151,6 +2167,7 @@ static void ad_disable_collecting_distributing(struct port *port,
 			  port->actor_port_number,
 			  aggregator->aggregator_identifier);
 		__disable_port(port);
+		bond_3ad_set_carrier(port->slave->bond);
 		/* Slave array needs an update */
 		*update_slave_arr = true;
 	}
@@ -2830,7 +2847,9 @@ int bond_3ad_set_carrier(struct bonding *bond)
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


