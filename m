Return-Path: <netdev+bounces-291591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL81I/9dFWp7UgcAu9opvQ
	(envelope-from <netdev+bounces-291591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:46:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E44FA5D29EF
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D79B43082E54
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA7B3CDBC8;
	Tue, 26 May 2026 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Kx+9S8dQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f228.google.com (mail-lj1-f228.google.com [209.85.208.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0A42C181
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779784869; cv=none; b=DzxyKsRsfFadJlX7KRgTpumHGtlyvaCa4nCnE33O47j49eP0hUiumDUokrt0IzQEeVFDCRTcpqgDQqTNHEwqDkQUzGYyoZ4JBwVbG+0SqK9IIEDQfMoj/6LazVNmCtl2gkCx69trYTBoGP3HnqO5Y/7VS54cE8bKQOT3+nQNxKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779784869; c=relaxed/simple;
	bh=5D0WxI713FBvDeddEujw4c9zetJUmOcKk9K5e8cSEJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=If22pxWa2NhtcsDV2LoChnFY0SLQxNpIDr0z+hnn7bZ13858H7QtBDjKGGrvs5l1YTFKaMe0/LkUea+nDQIa8qJIu5aHlNshh6ClLw0wlwthehSJ/uuEfFPNu7BzmeewcsUNmAVYBwv41exn55ofLkH8/JAA8l1a4+qgvXw7Fps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Kx+9S8dQ; arc=none smtp.client-ip=209.85.208.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f228.google.com with SMTP id 38308e7fff4ca-39393ec4ed0so93201431fa.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 01:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1779784865; x=1780389665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyEs4dLj8iehL7vjvTrWPcDCPVxX9KcCGdrInqBS79o=;
        b=Kx+9S8dQSOCo17UPJ+NOQG9NdyvyX0oAtu8XpdoCfgCaDzH3X358AmOw9ciMZKtuT6
         8PXvHBCkwZirGX4BaX9h7zRcTR4zNpGu5TBEpgyq1hrED2d88B53Dsq6GBYmkXflnHvC
         /lFgzNSyMdI1TITcb5iReBdu6nY9BMuMDpZBK7IB4bFrxddUedDgmhjLyQh1rE6fduk8
         hTIuX1L0AhlUxBHOPY31oSMMcYGNQoB8vK5uXK4XpEPCSAm2SAI5YdnXvzJjOxXQ+pHP
         pMfhuOdpBtYFOhHRo37qPCwORm+DThWM6H03qK9b2WO4WakoTZ+W+L/J9cOICTsNvYB6
         OtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779784865; x=1780389665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zyEs4dLj8iehL7vjvTrWPcDCPVxX9KcCGdrInqBS79o=;
        b=qWanJyX0ghxwi7Jvr3kps3dqYb80IZ4q9V7BG88MMYw5io6MNKsAmJQtF9BfFrsSwX
         mGWXbg7oQvdFYqvJ4pZiU3zI5LIQwBnNsLyikHjEmk9kvi2J1aDIZM2S37niquxazARz
         oQnrCwSORSiEpbD/ASoBuMn7qHf/aTsyGJt9/TiR1bsaTgV7UlG6btSw4caPk8OE1EPO
         9mLJtvmShjXCsF02pk/ZRZJTE/zQd09tRIwTyhytwR3oI/+uNOXSokzXRPngTpJMKYMQ
         v+e/pexKkIsknNAuB4agMV377naUCHvj56Oei41vkyXT0mfIf70Xlg4K8Yf7WsL+af9l
         iexA==
X-Gm-Message-State: AOJu0Yy6h8PCw6gC0Zi6T6IkxG3BU0yokJwtWXaDi+Fd7p4oNMEejrLn
	wj35W49ua292H7sL1jILPc5FAUCj+BZs1Vq22GPoUhyx01olrQCZ/GTeUtsS7CLFxti8LpHosvf
	pG42yVaoDWxF8HG04fbGJqmskcUQ/CISmwF0Y
X-Gm-Gg: Acq92OGpK1Wgnk2k5DIuKogEug+jQyF6/uWDygZecfrB7S2quRNqXWKlR2Bk6ps6azU
	FTEo6pNunexuCzIJAPNKX9Z6ZrxoRLdvHaEp78KusKog51dtEC8Jk5HWmCxLVESLU1t9LGK4t2L
	o6eCdFjjDerk4np75+sarOQcJCaHVFjfnA/iIXBKvaUCXKVeA5xlweJMkCNMgcLc2KH4tTAh1ZO
	MUIIwVvNS6+AnEURgaNI3rsIRQ47BL//TUQ+/QjJOOMNeYoQ9Z7ceAenr3aHp7qkQvnLLhv+S1C
	L3K4cfUUckGXwQ4u7xKdvqFJRfbfNvP2PjhyafWJuP24W5bACIIB/lj1Mkp4hCmWi5P0u9ZYSiY
	M7kBkX25TyJuzSkYTli892Drj0cD0uARpC73+tmEUGVngUcSmzfq2
X-Received: by 2002:a05:6512:33c9:b0:5a2:c0ab:b57f with SMTP id 2adb3069b0e04-5aa323ab5demr4859286e87.14.1779784865575;
        Tue, 26 May 2026 01:41:05 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-5aa462fc22fsm148210e87.7.2026.05.26.01.41.05;
        Tue, 26 May 2026 01:41:05 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 36753124B1;
	Tue, 26 May 2026 10:41:05 +0200 (CEST)
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
Subject: [PATCH net v7 4/6] bonding: 3ad: fix carrier when no usable slaves
Date: Tue, 26 May 2026 10:40:46 +0200
Message-Id: <20260526084048.1696544-5-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260526084048.1696544-1-louis.scalbert@6wind.com>
References: <20260526084048.1696544-1-louis.scalbert@6wind.com>
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
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,jvosburgh.net,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com,6wind.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-291591-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E44FA5D29EF
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


