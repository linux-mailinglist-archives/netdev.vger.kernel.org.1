Return-Path: <netdev+bounces-268159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGp6J+gEuGlpYAEAu9opvQ
	(envelope-from <netdev+bounces-268159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 14:26:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AEA29A4E9
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 14:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B67930158A5
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 13:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A64397691;
	Mon, 16 Mar 2026 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="IV+kSOZO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f98.google.com (mail-ej1-f98.google.com [209.85.218.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CA428314E
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667126; cv=none; b=nnKGqf0v9g157F+fVPq9jaGHELbeHAkih7t8y8+Q/MAhqt7ACwfusdFRSuIUkZ0pOyJhJaXi/WGSHtAIbgV8WD9wL5Z7shuVMuA2qNSdC8oC5QJHrvsP5K2H2Y3ierXswhimmJlPU7iwQGbkISdW6+mJLNHVddE7G/okSyahzuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667126; c=relaxed/simple;
	bh=WRdxJMsDH+PFC7GdycD57qH9rMkeTxLbmspJJGqcoXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ucnpUZFE3hR8SQ0DRI/wRQ1c2Qu7akudZulysaU4BND+ZeeJRkOaoO2qsEHEAnqrNzJ7oMaknWN7qJzjwVmLkhff//F8uCFKJpejYue7p7p3ZgXO1Uqdgow39Ha+ipP+ZnudGTFNfkt8qZhY6tOVlE+1TDy6fu8kvGKedv4oBo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=IV+kSOZO; arc=none smtp.client-ip=209.85.218.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f98.google.com with SMTP id a640c23a62f3a-b886fc047d5so754340466b.3
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 06:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1773667123; x=1774271923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1aPZCOtrIdI3UizLMjYzihvEhZ74+ZOCgESXvFBhvc=;
        b=IV+kSOZOaNpionpn+htBG0IKEbHroELj4ipsGz3FxNMEKUtb/KPJoI9ui/zvW1gBDQ
         47Ineoar37SErQSdMo1l7eTX1SiPszkSU2tQnY5Clr99VKifabDTOWQyc8nsM+DeeXtG
         AY5RsLumBjZo9/jDcGJSTFOKjFbYvka868X6YFZGLNns4FV3jIPoPUoghVNlJ8V1wj+9
         LJiF6CyUwPPH0ULPLvxQGcDr5MSZIA7/cOB+RcVFMpOCOZ9ctCKy32oQ7PfcUBS6bLhh
         p+hKTuxyw6fILNHDeboPwepW2/srFEROrNU/GNLgLa0WL2bYdUcVqy/oy4bfkttmK58v
         rZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773667123; x=1774271923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I1aPZCOtrIdI3UizLMjYzihvEhZ74+ZOCgESXvFBhvc=;
        b=c11kCjQOgoOR1Q0c7uAyveoNau3WGuHG09VhkcigsODgSvj6ojfTXrq/Qyu+EuzsVg
         Y4CcXBWkO6reu6KowzijP+BWABLEY3H5LPzTr1KMQ5Rnw/NU1mf43eesdn5nJsJsvKLA
         8c8qiba232JevZ5xPiJbI9hs95FyxljQpb5EyO9d1CjVpICoYZRdwA6bhYfj4y4/+voV
         yLECYb/e8zDE4LvdbscNQi/Vkq1QiYyr0+g5zuO0dire1m4Tp13olE6VuoAegjGnNxTQ
         eUsIaeHjKrOdeJlY/LLSaU804XFnGLJkLHyH8PNwJ1JOLJklpi9RB4Z5sWaFFjZPjbAW
         teOw==
X-Gm-Message-State: AOJu0YxRlZqGppgQA8KmimWL7wlP7juWWMZUC/vF8GzffrCXN/GMalF9
	EM4XDK5B/LCYkc0JOkTUPVHH3q02HjvhE43KUmEX8MhKql+40qebdhG305iU0FVqmTFmXRaUXr0
	W+QobGJ3FxrRjMusRAUxBZn44Nx0mIhED38s8
X-Gm-Gg: ATEYQzzxxlGjmI3tOXVQCaB+nKGcJv6vrr4WB4mKtIdbhSzK1NWuH2NRFijEFuyNbUY
	S+iXBMzpCLUiZZu9a7R2LyVO/AL4CuSVIYj6du9NM5kybPdKTvfH3VYPlrBq1Py/e5y9RrgsTvW
	F2TxlCKKeG8qqsRR4sQPt7b9Jcou+OBWcmhScXKuBhrlLwGCuObSoywUQSB0+0ARsV4w+9IQakv
	pM7/1ySgJ/CG3R9lhlzB0tNU1uy6T7aB7c1NA7NLE92NegO2Qn9RbqjAUREH1tAgdzjB7irmwZR
	XGHg0azQs2EjlwkoeuAzUpr1qca2riRHwMUGcfjqAqMpQTokoQHl0IPPgZK1N3VWzKXRUFKw/Ob
	OvB0s0HnVl68WT1D/RduykTXxWCyK9cbOUaVVm5aYfGEaoHmtqWwE
X-Received: by 2002:a17:907:7253:b0:b97:554:f100 with SMTP id a640c23a62f3a-b97650f31c6mr807613266b.20.1773667123149;
        Mon, 16 Mar 2026 06:18:43 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-b97851ae9bcsm64659366b.40.2026.03.16.06.18.43;
        Mon, 16 Mar 2026 06:18:43 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 07C7119C5A;
	Mon, 16 Mar 2026 14:18:43 +0100 (CET)
From: Louis Scalbert <louis.scalbert@6wind.com>
To: netdev@vger.kernel.org
Cc: jandrew+netdev@lunn.ch,
	jv@jvosburgh.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fbl@redhat.com,
	andy@greyhouse.net,
	shemminger@vyatta.com,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net 1/2] bonding: 3ad: fix carrier when no valid slaves
Date: Mon, 16 Mar 2026 14:18:37 +0100
Message-Id: <20260316131838.3257889-2-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260316131838.3257889-1-louis.scalbert@6wind.com>
References: <20260316131838.3257889-1-louis.scalbert@6wind.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268159-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[6wind.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 17AEA29A4E9
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
 drivers/net/bonding/bond_3ad.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index af7f74cfdc08..7d7661972c5e 100644
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
@@ -2819,8 +2837,8 @@ int bond_3ad_set_carrier(struct bonding *bond)
 	}
 	active = __get_active_agg(&(SLAVE_AD_INFO(first_slave)->aggregator));
 	if (active) {
-		/* are enough slaves available to consider link up? */
-		if (__agg_active_ports(active) < bond->params.min_links) {
+		/* are enough slaves in collecting (and distributing) state to consider link up? */
+		if (__agg_valid_ports(active) < bond->params.min_links) {
 			if (netif_carrier_ok(bond->dev)) {
 				netif_carrier_off(bond->dev);
 				goto out;
-- 
2.39.2


