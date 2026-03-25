Return-Path: <netdev+bounces-271566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP41NZjow2lvugQAu9opvQ
	(envelope-from <netdev+bounces-271566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:52:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7575532629F
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1630309975B
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85463081D6;
	Wed, 25 Mar 2026 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="IBXVDEOZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f99.google.com (mail-ej1-f99.google.com [209.85.218.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556B924728F
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774446285; cv=none; b=edyl3MDAq40/NtHBP4eOO5WuScO6BBlvmnF8uIv/9dtNLd2eT4aJKA7CncGdK32zTLvfq+HvhIp/qcn+UL822onePIQcIjvwOqoD6zQHX4jmh1+ZfzIRBgcBmFPaWN20H3Ml8A6+lBTlMS06aZCpnNkXXdTSEF5+toWYeMFiJyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774446285; c=relaxed/simple;
	bh=Vn/C/y3fn0J44PEQ8tV+x8eQxQTSKd8u8V3OFxpUI78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nZWiArVyPHGVk32/syVcQXaZgtbzqokd8o0w+MPpya9bqJ6YKFveGHkyxK+aIe8sfh4XiRuc6lASjvXqNaKFfL0c4A0hZJP6IM7vYyHmuDFR6DDVrmkJ8yTHwYKZulaRUi7QNVVBvvPEqmlDOFo0fYlZO64srD3YB+vqzL5Jp00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=IBXVDEOZ; arc=none smtp.client-ip=209.85.218.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f99.google.com with SMTP id a640c23a62f3a-b9358bc9c50so370940166b.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 06:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774446283; x=1775051083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3M8gSJcZpDyyVzHbLbG5c13dSIMrRCpl7D5jKFO/6rk=;
        b=IBXVDEOZ9jfhTrWLFP4JVSeLVnpmnyFIL2qPRwYK74AUaAZAkUQz/zVvAHcA7jbcxR
         crG4iIiaGJ+r8E/kl4gF+FU6RtBHWA6vr4O0QK4TKAO0fXj7YOnB43Xa2fjtjUlbipSA
         XBRoi8DngMSfPiSkEGSBHQqC11CFw4WnQq3wLToznJd9Q1AUAvB/dn5MjXnb3WCKQUcD
         NEHHaz033zcLMOxJ/9ZxHOMAUaE9dHLPWDr+l9vzwo19oFs4wZIdPrT4vcNc04gzMzqk
         vnaPl7izWDG52+hh8zkXURVDKaX4zkrN+Fednzub1OjELlT4IU2creWsJ82BX6UD0FsM
         kgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774446283; x=1775051083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3M8gSJcZpDyyVzHbLbG5c13dSIMrRCpl7D5jKFO/6rk=;
        b=egLSLvSgDolXYAn3DWs6Xo4pYwbkfjrfw7oGlfHAgZHO0jJ315nJUixO2qeE1uN3Mh
         uzLZ8WFgn5RrHJRXf4Oh/aGDI705coCmJUCmR3KvCwhoZtG7aO+TfkB/41TCv3IdjnBm
         9D/IcTgcdkixU3rJUf7rQI3wiviUBjtre5IeZ3s5jDs0UjXTiY5impVNg34zsEWFAvXq
         6GOdvuuGMPcI3WGHJVM2eaPZOPHSOj2QgQsIlmVzxKbiNNjTgcMA0j1+ElTPmkA2Ff0J
         hFHN8JHRgx/aYoSlp14XM+GEYvzcZb1ojXDdy/Ht9tlVccno5LthyqcbXY5GynTFE6m1
         vKIQ==
X-Gm-Message-State: AOJu0YypKF1vF6geWInGdsIcp+d0QtkqnOBm+VRcio8I0WsIy6qDyYWS
	Dg5kYvxwK7OJfCw8YjTU1rREoSC3HdZLkgn5P2mV5FJ8+t6LN8edrToYcv4HVrHScmfthn+DUD3
	FdFN3KBEGaSTYoDjE9lHdXa2EyA22GF5HoXfM
X-Gm-Gg: ATEYQzxJOTM2vWeaaVOaI6I7Q3lBVqw5L2wqF5fREGTna9tOe1AuD1N7Z/duOA4yop2
	M48OqN1VleK3lhgLRhNtegwdh4r8zL46VBi/hrC6vQRvvMyuKsBbcMC4VdSCJu+llMbACG6SU62
	jVV71sddYf+FPv1JzCe/O9jbPHl0NmkMUF7WtM03e6Ow4+NRpytoZ4ZG2xRqh6eghCktUhybPc1
	3Paz+F0hDa980TZtJKSqnu6luW53NK7CsiDV57/teLi+PYDA2RGRIpb8cBmzoeLVvflqLFbJL09
	h6MzS3hJF+GnaU9y+i1tRx/x7Np1KnNvGioFZYm5ylu3HeEUivXd4e2qmfc6d0MjhxU3EjXuGiu
	EhriKDuOnpkie0UsYZChghLiyKjHqJ/OtYa2rID+qQyxDAb2wcayY
X-Received: by 2002:a17:907:d385:b0:b9b:1cad:fea4 with SMTP id a640c23a62f3a-b9b1cae00b5mr56258366b.18.1774446282601;
        Wed, 25 Mar 2026 06:44:42 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-b9973edf32asm21369866b.46.2026.03.25.06.44.42;
        Wed, 25 Mar 2026 06:44:42 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 6C0381EF6F;
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
Subject: [PATCH net v2 2/3] bonding: 3ad: fix mux port state on oper down
Date: Wed, 25 Mar 2026 14:44:38 +0100
Message-Id: <20260325134439.3048615-3-louis.scalbert@6wind.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271566-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,6wind.com:dkim,6wind.com:email,6wind.com:mid]
X-Rspamd-Queue-Id: 7575532629F
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
which clears the actor collecting and distributing flags. Do not
attempt to set the SELECTED flag if the port is still disabled.

Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
---
 drivers/net/bonding/bond_3ad.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 6d3613755d45..1771e406224c 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -1570,6 +1570,12 @@ static void ad_port_selection_logic(struct port *port, bool *update_slave_arr)
 	struct slave *slave;
 	int found = 0;
 
+	/* Disabled ports cannot be SELECTED.
+	 * Do not attempt to set the SELECTED flag if the port is still disabled.
+	 */
+	if (!port->is_enabled)
+		return;
+
 	/* if the port is already Selected, do nothing */
 	if (port->sm_vars & AD_PORT_SELECTED)
 		return;
@@ -2794,6 +2800,7 @@ void bond_3ad_handle_link_change(struct slave *slave, char link)
 		/* link has failed */
 		port->is_enabled = false;
 		ad_update_actor_keys(port, true);
+		port->sm_vars &= ~AD_PORT_SELECTED;
 	}
 	agg = __get_first_agg(port);
 	ad_agg_selection_logic(agg, &dummy);
-- 
2.39.2


