Return-Path: <netdev+bounces-294798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K7V7KRJGIGpxzwAAu9opvQ
	(envelope-from <netdev+bounces-294798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:19:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B49E639175
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:19:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=6wind.com header.s=google header.b=OqIWR1a7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294798-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294798-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=6wind.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58D9830D8A9D
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 15:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7691E39A4DF;
	Wed,  3 Jun 2026 15:03:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f98.google.com (mail-ed1-f98.google.com [209.85.208.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E7A3955D4
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 15:03:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499016; cv=none; b=iM9YobY4zgYLGljTmSY1U0zLIu107+Kb7nTt2Cqw0G01PomqpAeuqB51fduk9nFIMi+wYilBCRRFKEvtDy7LQUc74eVJl8zSSCxDdPkxtwVQAm+fWx16mIi30aGLNZ5zuzGKkU8AybM9VQrJPvsz57shoA/lMcp59kuqBmH14FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499016; c=relaxed/simple;
	bh=Gy9qg58vggdxk44h8XgCLq+MO3qBQ2hPoOlO3qleE/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d5F13lhwkHIAlufR7xIDEg6uq6Qrfyl24Gz6wBAD14EX/38b9iVz1z4scjFuDVO4zNHZmKmFp8PiN3+7dfH6SYQPc/QYQ0z84sn5rkNfXqLOBJvXsaLP+im6pzfIEX1MYPjch54wreh4rIZFm+C4dxkmoSjrPjSX8l6yCScV5xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=OqIWR1a7; arc=none smtp.client-ip=209.85.208.98
Received: by mail-ed1-f98.google.com with SMTP id 4fb4d7f45d1cf-68c3421b009so1331110a12.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1780499013; x=1781103813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gv5+1r1armjndx3NqTxWVROfN58tPv0t9fyfNxmNLA=;
        b=OqIWR1a7jS0Gn+ddX8JnC2JknI+ss4sC+4AZm/wVhzSNbz4tNM1JUxcKyYNi8tvoR5
         6+p+VLjUAVGQ9kT5XVfA+2frpzgI5EC8Ox1OY3L+0wLL0PhfOe1ab02HlsY0buSeNAaG
         6NGOV8YPMt5cV+fTKGfsG6imSemgUANZhBTt6MUfxmM9Bj2DatVvfwNo8fuR+IqxE391
         sDaS4MRhM8Z72OiRKfaZOE5hECIsh91BJuL+vjWiGc+arnxvtaovrGs4uKmHRRRBjr33
         9Ujla6r5tkyyKhqd7UOEnGESSm5hUl0p9wVvXWlDEEzRObovGTPFITD6IV6De00gO5iT
         dB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499013; x=1781103813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4gv5+1r1armjndx3NqTxWVROfN58tPv0t9fyfNxmNLA=;
        b=QuKoVjnWjlffmxg6Wrt+aLLxt8FWv9849lU4ajsP2PxZYF0NvJAx22Y0XbtPPXgHLu
         dQDfLSHE4eMT4yohGpZ62ILXIarRT9mhmZ0zT8PC2VlzEhXVrllUTw/2L4hEbVYZ+9Or
         DVmvf8H8KBKe/XoFCAbk1yYoKkmALdgJQhk0/YHoeElJdk6XY3Ev4S61LqsirAJCj7nS
         gfJtp206kH72Ir0nFGcwiQc0+JBORCtCFLXbnIxSpIaxJm5qGgR6TLTekER4WHmNbB0c
         btP0L3tzejvUGX6K7eN5rQ60Iod8FTATNGv4u7rQ65Uww4VirAp2EMUEiLnRO/9reVNm
         GH9g==
X-Gm-Message-State: AOJu0YxEwfnBKyoJ6jpzDvBGKXD8nVn5tEsU92PkTGaOv1TaL9VY/bQp
	RmfBdkTS9bcs5nRXbPy7/n9eJuJV5o6uFhLUGb9ou2Q8GNmTEodf1W0g0TYTVN3Ji4zrxXotDBr
	r9S2e4/hVAk9ViQgn8F+3IN0bQrlPfbGAcw+L
X-Gm-Gg: Acq92OG6KmSIGQtENo3+A80oztuOCOrlGCzTYTCD/u0QLvQ+D6O1gIRKqiw8zkJCCQ4
	xPeZcip8q8dFxz7aHxKfX270Fcm0wnXAEU/X/3GUtOVCQwOVdAHaZiwX6H9Yi1gQ4b/A22a/WkW
	jgXqVpadMOiZxNxhXFSbXXw55qJnVPkon3FbGqXYAsug9CSE0lTMk1mx6AhqS1ViB7S4FiymBBX
	3C/JrmQSoI5T4jQ1b8aaYB68RkOV1zLNvOXsx9118boJG+zL1rrKEbznumnYx9KHYwsTNeZeuMM
	vYE5vcN0Qoox1/QefZwpnxdAhUU75zyXzyn522364C9vKJ3lpl2WsJnzBZQ9YuOS0+Fwd/tzlHn
	s6WPX0anLpA4tequp7B2I6khtZjJtBAUp1o/IhaIKHwzbeKxETpOZFAavR2oEn3U=
X-Received: by 2002:a17:906:6a13:b0:bc1:d3d2:9348 with SMTP id a640c23a62f3a-bf09ea6587emr184765866b.20.1780499013189;
        Wed, 03 Jun 2026 08:03:33 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-bf0516757c5sm19475766b.7.2026.06.03.08.03.33;
        Wed, 03 Jun 2026 08:03:33 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 0390B14713;
	Wed,  3 Jun 2026 17:03:33 +0200 (CEST)
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
	horms@kernel.org,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net v8 4/6] bonding: 3ad: fix carrier when no usable slaves
Date: Wed,  3 Jun 2026 17:03:29 +0200
Message-Id: <20260603150331.1919611-5-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260603150331.1919611-1-louis.scalbert@6wind.com>
References: <20260603150331.1919611-1-louis.scalbert@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-294798-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[lunn.ch,jvosburgh.net,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com,6wind.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:jv@jvosburgh.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:fbl@redhat.com,m:andy@greyhouse.net,m:shemminger@vyatta.com,m:maheshb@google.com,m:jonas.gorski@gmail.com,m:horms@kernel.org,m:louis.scalbert@6wind.com,m:andrew@lunn.ch,m:jonasgorski@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[6wind.com:mid,6wind.com:dkim,6wind.com:from_mime,6wind.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B49E639175

Apply the "lacp_strict" configuration from the previous commit.

"lacp_strict" mode "on" asserts that the bonding master carrier is up
only when at least 'min_links' slaves are in the Collecting_Distributing
state.

Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
---
 drivers/net/bonding/bond_3ad.c     | 26 +++++++++++++++++++++++---
 drivers/net/bonding/bond_options.c |  1 +
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index f0aa7d2f2171..98abb2fdd7a6 100644
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
@@ -1179,10 +1194,10 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 		switch (port->sm_mux_state) {
 		case AD_MUX_DETACHED:
 			port->actor_oper_port_state &= ~LACP_STATE_SYNCHRONIZATION;
-			ad_disable_collecting_distributing(port,
-							   update_slave_arr);
 			port->actor_oper_port_state &= ~LACP_STATE_COLLECTING;
 			port->actor_oper_port_state &= ~LACP_STATE_DISTRIBUTING;
+			ad_disable_collecting_distributing(port,
+							   update_slave_arr);
 			port->ntt = true;
 			break;
 		case AD_MUX_WAITING:
@@ -2105,6 +2120,7 @@ static void ad_disable_distributing(struct port *port, bool *update_slave_arr)
 			  port->actor_port_number,
 			  aggregator->aggregator_identifier);
 		__disable_distributing_port(port);
+		bond_3ad_set_carrier(port->slave->bond);
 		/* Slave array needs an update */
 		*update_slave_arr = true;
 	}
@@ -2128,6 +2144,7 @@ static void ad_enable_collecting_distributing(struct port *port,
 			  port->actor_port_number,
 			  aggregator->aggregator_identifier);
 		__enable_port(port);
+		bond_3ad_set_carrier(port->slave->bond);
 		/* Slave array needs update */
 		*update_slave_arr = true;
 		/* Should notify peers if possible */
@@ -2151,6 +2168,7 @@ static void ad_disable_collecting_distributing(struct port *port,
 			  port->actor_port_number,
 			  aggregator->aggregator_identifier);
 		__disable_port(port);
+		bond_3ad_set_carrier(port->slave->bond);
 		/* Slave array needs an update */
 		*update_slave_arr = true;
 	}
@@ -2830,7 +2848,9 @@ int bond_3ad_set_carrier(struct bonding *bond)
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


