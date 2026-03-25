Return-Path: <netdev+bounces-271568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEcVI8/ow2lvugQAu9opvQ
	(envelope-from <netdev+bounces-271568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:53:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 505953262CB
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7FC4310A887
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB78F31D75E;
	Wed, 25 Mar 2026 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="jGYHcgF+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f98.google.com (mail-ej1-f98.google.com [209.85.218.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CC5258EDE
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774446285; cv=none; b=efocOgRNf+9r3iNvdMEC7UCXgxhNi6E8w1qnEbkhRZnIJ17vGU2Cl1pRNlyvhfOwZbMFFjkuxRj3B0AkQq1zfgONCFMYXEbbRXIhP4dp2niTk6YxIaXKDaGo5iFWcy41Qpu/03MMvyUlJ86xRC6eeIJBENEMrWjSbSpzEhJ2brM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774446285; c=relaxed/simple;
	bh=a4d5VEfcZaBUlv5wSQLVwDrF1j7hoMVD0q3eVf6XgDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bu7eVPwftsLdWnqgTIDv5OQTf/X4W9bzbZI49RmLAE5TR0Z7ej7C0AyzE/z3FXOV0uk5Hoex44VWJRjQkP/grNxE/c8zH5S6nFlWda6n+cCFJl/056E/1v3OMSB59MSVMA0p15xd+JVbXjrvvLTUBEceoDqDiOU7SsiccXVteEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=jGYHcgF+; arc=none smtp.client-ip=209.85.218.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f98.google.com with SMTP id a640c23a62f3a-b9a0762ed5fso135276266b.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 06:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774446283; x=1775051083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYLAScOzVTPW96Q/e/ORxGkIfqDqePakPeJElsTBptk=;
        b=jGYHcgF+wyOr09T9D5A12Yf4N56IddFI100Q6gxmccVEwZZvDwCib5wBv9SdbWYsTZ
         zVJzmxWL7WZjrwRNRQr2IWElnVRz2CNNuwmffb8fuA4TWRiZAZBd0gFYFNyDRKkBFS4d
         XcW5UWGdbnGyFAjmN8FfLVkG17mY0o+7O9BKLz8/eEyu0hNqHs1M8jx1D5vfiNQEfw97
         tlCzzeN1IX+KtHKrQ1Ie9uDDkFkEM6RCHjkUUsmV4pbVPWkkvCrNyLFq5vhMy9GZSGTK
         Fg0/3AkXs2b8Ph9b98Vw+LeYEMGIKq+G42M/Yh6lXd6rYyNKqx3pOb2t4KFOxCCqc91H
         qfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774446283; x=1775051083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yYLAScOzVTPW96Q/e/ORxGkIfqDqePakPeJElsTBptk=;
        b=Bi1SaU9uel2G6xeA+8eonwDMgZWj2eREi/VMoi8ybGmMEAfDUxdxCLUpsSjvxr9RFc
         ezDFa4z3xEp3Y+UhdfXHQPp+s15By+kLlLN+T79IDQA6JEmJoqdZtBPSac75dt1SiYyc
         DigvDU5kA+aQhs1WwGkLaoR3GQOhObpjFZgOquybcY4rcDB3pD27Ja0qr5IOu+TI0thO
         WK7+GOsrP003M1JHyxQ3nvC7P3hlwLpeLPy+2wOeqv0umjVecD94AiI2phly1PxbKPu1
         rOgLygl1NFzBpqZMQZvemndBjq+NQG+kmXyxNVz5Zk7B4ZA4akJ7rOPMAYniwqft9qzq
         lSVA==
X-Gm-Message-State: AOJu0Yw5at69RzU3gkOfdIS1LNWFL9k4iEw5W7WjOXrf4pF/cOTu50f9
	+Kyw5xOZIeboinVdC2RqkS0TlBVsEY7Ro4SBrjdtdblIMGuAoxAuQhaHKAQEc1Ac+Q12keVySQb
	eiEvz5G+jpNVO1si12rsXJStDiY9PYfG13+YM
X-Gm-Gg: ATEYQzxl1ZKuJOeAUwXhDIrBsw5oQXlpTYbaBYKDWtiVJxSpgKKyqcYQN3vHK6MdE2d
	+4pImlS82/cPZAc4OB3SV59+Hpc2KWUH4cOWwOXzI148f+zRC99H7KA3fqlkTC8yPzrEYvI9ckH
	aF713tB42M7CZT7Hae85bnN5zRszHIYql+zsRK5DCWA5BJHJOOBdWJydOndS4SSX5urxLgBT15D
	Chly8jIpfslwO6tDrOhGlS4qtRPSOhrgqENy9bQbLirH1pNI3IPZGKh5oF2m49SPK+NQtFrzaFt
	JNB0MmJHTpvOPNM+Hzk4QHSYU6VyNo7PT24JKr0lApegV7EM4nmA+9qshqEOsIHhgixiW6Lmb/N
	dfEPD3vuKJ1+Jrg5J61rmBoY1S/o+SixjR/aiDHUEogzLpVLks7Fz
X-Received: by 2002:a17:907:e981:b0:b98:49ae:b722 with SMTP id a640c23a62f3a-b99c478a278mr290020666b.23.1774446282569;
        Wed, 25 Mar 2026 06:44:42 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-b9973f3fa74sm21157766b.72.2026.03.25.06.44.42;
        Wed, 25 Mar 2026 06:44:42 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 63B6D1EF6E;
	Wed, 25 Mar 2026 14:44:42 +0100 (CET)
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
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net v2 1/3] bonding: 3ad: fix carrier when no valid slaves
Date: Wed, 25 Mar 2026 14:44:37 +0100
Message-Id: <20260325134439.3048615-2-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260325134439.3048615-1-louis.scalbert@6wind.com>
References: <20260325134439.3048615-1-louis.scalbert@6wind.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271568-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,6wind.com:dkim,6wind.com:email,6wind.com:mid]
X-Rspamd-Queue-Id: 505953262CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When an 802.3ad (LACP) bonding interface has no slaves in the
collecting/distributing state, the bonding master may still report
carrier as up. In this situation, no slave is actually able to transmit
or receive traffic.

As a result, upper-layer daemons consider the interface operational
while traffic is effectively blackholed.

Fix this by asserting carrier only when at least 'min_links' slaves are
in the collecting/distributing state (or collecting only if the
coupled_control default behavior is disabled).

Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
---
 drivers/net/bonding/bond_3ad.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index af7f74cfdc08..6d3613755d45 100644
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
@@ -2819,8 +2837,10 @@ int bond_3ad_set_carrier(struct bonding *bond)
 	}
 	active = __get_active_agg(&(SLAVE_AD_INFO(first_slave)->aggregator));
 	if (active) {
-		/* are enough slaves available to consider link up? */
-		if (__agg_active_ports(active) < bond->params.min_links) {
+		/* are enough slaves in collecting (and distributing) state to consider
+		 * link up?
+		 */
+		if (__agg_valid_ports(active) < bond->params.min_links) {
 			if (netif_carrier_ok(bond->dev)) {
 				netif_carrier_off(bond->dev);
 				goto out;
-- 
2.39.2


