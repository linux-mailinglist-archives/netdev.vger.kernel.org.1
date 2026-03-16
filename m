Return-Path: <netdev+bounces-268161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA0tNfsEuGlpYAEAu9opvQ
	(envelope-from <netdev+bounces-268161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 14:26:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6F629A4F8
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 14:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 364C93065173
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 13:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C2A3976AA;
	Mon, 16 Mar 2026 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Y15JGa46"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f225.google.com (mail-lj1-f225.google.com [209.85.208.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E431396D25
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667126; cv=none; b=RFB/mDU7jdKPL++MwES9DfJyVa0TniCjRRMVexiDzTxI6TE7XOk02ULjIsWvMcfs8b249ttYvl6TvEyWGHizbQ7rI6WFqPdHN7z18ZQnCMq5NeZENDZeGTHEfxiWkJZccXbCvz+G1SyGUqJFPKuWKYBiZgnPvm6ztKfIVydw7+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667126; c=relaxed/simple;
	bh=DjTCLZI8F/jqd50eyasuQplPFJ8zL7ocF39jZpcywGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YS/Tse/21KhTAdcmvLyJqB4Jx5EOS5CjkPOiaWml2i0pllqnpVGBRSEMiKmDI2rVOotmpVxQyiEnBdvU2WIqMDzTcFOleLpAco1k4TYmV/kBBhqzTBEpSMhZ9iaWh4cpCIZegKFdOUY3i/Nv4ShSzHZXijY/ncFptn2icwUEK8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Y15JGa46; arc=none smtp.client-ip=209.85.208.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f225.google.com with SMTP id 38308e7fff4ca-38a4234f91dso37953071fa.2
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 06:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1773667123; x=1774271923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvMejH3fb7PBx1UWrZPSCvrzsXIJKNkNnjTQanKKFnI=;
        b=Y15JGa46sfR07eQMpkXwgXSFYQ0Ptc5CBI6abbKqMBQAvQrLGH+DxxziklDyBdaRdI
         BnYNU7pMh3njjXh1fuVgM7ReeZnE8QqrFMMTaNrksiRh1KyK4LOmTeXqmU0OA7ke2507
         Xswy6J6Ekx7JEYdzyJhcR0dWyN8QBKTzVy8fgx16OoEW7BwmY/76Yk66cuTGDQlBjZz+
         OgiGhQKaxaDD7cRrfxdFAzMvp/KNvR2IUIAHGCbKd3SI4akV69WcAhSckAKIY/lRJUFv
         EPxBZImjuxDhlBk1D7OjRKXov0I94ZRKwypxKUAaxlQFS4zdfefXWg8TiPhYRtsIF4at
         qtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773667123; x=1774271923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PvMejH3fb7PBx1UWrZPSCvrzsXIJKNkNnjTQanKKFnI=;
        b=fXJT/sg08Ee7Gb/UZr7RMrEHgRU0MMueJguyYZI5dQ3TmnWe74uFbn0YKtWt/oqRO3
         JMHTbf6Fq6fwaYzwAAbsZbKlkrvFUgMLzllyonAW1CLj6Wrjl8zwHqDrdLcLXaFSvJYC
         +iWyMbx/qCJOpQ9NWgI4HHG4YnTjYhlDFuu73tiTbg4px61Qkru526gCVqLJfDZju+Gm
         K+AAI76Y4EFcGwheNTcFAUbWUqie5PqcBfc0a+vDS7LmxaK36YXe0FhpnrpEZOT4zzS/
         Rq3uzvvfbtJXiVohoXFhNpUszDNlnHccywMl0dnzJ+9n5DFViae+vMXuH3fp91gmMqZ/
         vuYA==
X-Gm-Message-State: AOJu0YxBY93cSP+um16JbNt2IwByF6jEFf7RBdUKjBF4XqA0qnaxuC3J
	qBVVGP52NxpY+JLEUenireT1JKfETa6Bcknc2YUTm/aEqrYbo3lBdJ1WezKfj3PZCsFXIo99Ul0
	+KAtPeYSBuljsVcPeKlFS+z7tX7kIs0xYC9xz
X-Gm-Gg: ATEYQzxtdT7i/w65oyRBdhdl7GmOfgb4OjpzHpNlOhxcV67zOrDBLomLhzCn743Nlfg
	oAw8Vn0r9UKBprDujHJ9wnoiI3Va3TZ46Oef2nl/WV4FZnOVGDifLIez+Gc3TIz3zuKwwdMS8vu
	crmhAo7Ng1anLAWNJ5HE+mrPivEMREs3lkDnvapg+n6aY08QejOwQAqTMmcQya8Rmg7oJjd/pEI
	WkPgLjicdWV4WYcjhfSuWF7s1dTXS0F4DDE1ICecJlbdl1JDSA0FEZFKPgMm+1oTnnpgFnmO0SF
	qtlsZiEDsctpWmNdjJIwX0emfU7AJY+f+dih25Cfq1XenQUZfb7/fPwJ1zEK/XpNDnviQaicud8
	wnz5ALo4l8vhj7RS2I4yAI0YcmtKTFzdb1i3rd+1ewYBQqWDKzqOu
X-Received: by 2002:a2e:be86:0:b0:37b:96e5:dc40 with SMTP id 38308e7fff4ca-38a8966606emr40193821fa.8.1773667123377;
        Mon, 16 Mar 2026 06:18:43 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 38308e7fff4ca-38a87a5b2afsm6109331fa.10.2026.03.16.06.18.43;
        Mon, 16 Mar 2026 06:18:43 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 0A9FD19C5B;
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
Subject: [PATCH net 2/2] bonding: 3ad: fix mux port state on oper down
Date: Mon, 16 Mar 2026 14:18:38 +0100
Message-Id: <20260316131838.3257889-3-louis.scalbert@6wind.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268161-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[6wind.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4E6F629A4F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the bonding interface has carrier down due to the absence of
valid slaves and a slave transitions from down to up, the bonding
interface briefly goes carrier up, then down again, and finally up
once LACP negotiates collecting and distributing on the port.

The interface should not transition to carrier up until LACP
negotiation is complete.

This happens because the actor and partner port states remain in
collecting (and distributing) when the port goes down. When the port
comes back up, it temporarily remains in this state until LACP
renegotiation occurs.

Previously this was mostly cosmetic, but since the bonding carrier
state now depends on the LACP negotiation state, it causes the
interface to flap.

Fix this by unsetting the SELECTED flag when a port goes down so that
the mux state machine transitions through ATTACHED and DETACHED,
which clears the actor collecting and distributing flags.

Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
---
 drivers/net/bonding/bond_3ad.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 7d7661972c5e..367d89977000 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -716,6 +716,8 @@ static int __agg_ports_are_ready(struct aggregator *aggregator)
 		for (port = aggregator->lag_ports;
 		     port;
 		     port = port->next_port_in_aggregator) {
+			if (!port->is_enabled)
+				continue;
 			if (!(port->sm_vars & AD_PORT_READY_N)) {
 				retval = 0;
 				break;
@@ -1570,6 +1572,9 @@ static void ad_port_selection_logic(struct port *port, bool *update_slave_arr)
 	struct slave *slave;
 	int found = 0;
 
+	if (!port->is_enabled)
+		return;
+
 	/* if the port is already Selected, do nothing */
 	if (port->sm_vars & AD_PORT_SELECTED)
 		return;
@@ -2794,6 +2799,7 @@ void bond_3ad_handle_link_change(struct slave *slave, char link)
 		/* link has failed */
 		port->is_enabled = false;
 		ad_update_actor_keys(port, true);
+		port->sm_vars &= ~AD_PORT_SELECTED;
 	}
 	agg = __get_first_agg(port);
 	ad_agg_selection_logic(agg, &dummy);
-- 
2.39.2


