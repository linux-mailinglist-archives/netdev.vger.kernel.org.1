Return-Path: <netdev+bounces-284938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDFDOt9o+2miawMAu9opvQ
	(envelope-from <netdev+bounces-284938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:14:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 295474DDF03
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52A38300349F
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 16:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA44A49690B;
	Wed,  6 May 2026 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="G7CafN+4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f100.google.com (mail-ed1-f100.google.com [209.85.208.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165333FA5DC
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778083918; cv=none; b=LpNaufjHhRp+NsF/iYXsXD4wpg7jAdVra7fZO5MnKrG5J5VKY9nvPhx8JR8hAaFhTQtyP6+1uSvrL8K9BsCM5Mm+d+2VdDhPD08LJr9Nc1ZAS5CpAOG7PKRmAXAx7gz9iVKX039jygoMwAlqktGOZPegvOeHYpsB9SmCT4FRJVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778083918; c=relaxed/simple;
	bh=zUD+xGIWbxKz3S6EpWBtrBY4qWPYkgiV5RMrDmsD1wc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HyDo5hdB36jSg4WC7YKtwuq5C1l0VGnO7eiHAoseIH0WvOH44LHg2VQupeirPwJRODS2SNai3LAePjaP/tD4oULIkckEZ+hOstwN/HxiqD+s8VEF2Z3ffysNSC7ITsXmaZ5rY4xmUnDrmOxkwLW9fDM2LkV8z/Tt3nJTuyCBiEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=G7CafN+4; arc=none smtp.client-ip=209.85.208.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ed1-f100.google.com with SMTP id 4fb4d7f45d1cf-67cd93d8affso2541783a12.2
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 09:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1778083908; x=1778688708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbjK/JJAxub3TRj1SWBw4pfK7G8fSn4COFHIiUfsdoI=;
        b=G7CafN+4s5e6AOOiu4hPRPl9LAv9jN8aRYJsEDEpBXbR03bWVsuAGPWkIsTmHozNBy
         /cLz8u6usfkbrR3kajk2K+hpx4+XyOpTNBwj0oqI2kdDryl5TQ0WrpEklTxs/w5qRoV1
         QHXe1iUbrW/yLS6M6TBM8/GyXRxUgEEFV2kdqlz/AN8pw8iDWWXvUBTokuO9HNFFf7Al
         QWAX3qgczMHajqbBCk/4617apx5XFNBZCBsrwyyrTjHlYx4yZVSEjLupJYp9zM3xhT4v
         PkezL8VkO03axNZaCa3yXv6jTWuwpT38KsdmzvYWC3fc/KB9OUirVhvh+rnmgA8sAge2
         MloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778083908; x=1778688708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LbjK/JJAxub3TRj1SWBw4pfK7G8fSn4COFHIiUfsdoI=;
        b=s2rQJP7Y9JUnYEnVSRrbmbXnK1FcYVrwvZRBcnpuLkv2Jhxw8l+YOxg/b5Kbkx3g/u
         ZC0H2xQD/Eet3PdFRapJxo8dydsHyRcpXpQSKByngGscUWRLNswi0rn7gxFofbPKXFjQ
         KQLX4qyXQ76FgUZDScBWYVLOWBCJSk/mxYYBcTj6agkvHcK4q+m02X+naGUt8rrFG6/f
         PtsZnparuEFHfWEOpx/4fHnZnYzCRav65RRP9VbIH/sHpA6HauwT5UjyJkaG2EU5z3Gt
         xpxJLY1XfrtPH7d+7a/gotksEQ5WjeBmLMoxQbuEqvHCzSjXSOqGeExc11vvyi0FGDRd
         OyxA==
X-Gm-Message-State: AOJu0YxtN2xYB8wid0TiZ4B6yMx3tR/u2N9YQ/5Ugz9x2RQ/X6/uhV1q
	OOMQl5xaeUdocZBjPv57GbYjcwzAwTwQrbVisFo+WrKYecGv8T1Cz2QSJVykL6vz1EPEW3OUXtr
	gOZgimKjNv8uuQ+7/0NKxY2hAm9+SyUnJnuEo
X-Gm-Gg: AeBDievJAXMg+/UD3gW50ABNTvgL+YFrsmrDeFGLVHF1zjWdR7xBbCuFOy/9Ondml/M
	SH9+e5x5fv3OW6hwj70sdmgUl1Gp3TWOHnjaFH+upLwUXRZKnLgi39PL5ywbTekfoYnZrMeaCcM
	FKa5/zUivRqyvW6ibp81jRWwIBW32NjiF5NAhcgO1rE/9tXmSdcwM/6rV9s6l3EW29waG9OdJkZ
	peAbOJcjoT5g/lp+SWvgZ5xfwm0BiHiyjRcYCWZbRZMoozmHWSBeDN1RSg+nH8vqzbcRkxWFKQt
	8z+fSHvWhr0tbJV3ticDi/pX+txP3gopevgRc+3M6aC8yZqm3RcXDQj1oTjSQuUHO4cStwX1fO7
	dVksYvHCkvvoPLxNh2dBJjjCNU8GKGJkC3Y6cQDF27pgtJiB5tzmH2QL0hTZISs0=
X-Received: by 2002:a17:906:4795:b0:bc2:1dab:3ebb with SMTP id a640c23a62f3a-bc566d64084mr216161966b.0.1778083908341;
        Wed, 06 May 2026 09:11:48 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-bc55c08a6dcsm16500166b.25.2026.05.06.09.11.48;
        Wed, 06 May 2026 09:11:48 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 1EC271755E;
	Wed,  6 May 2026 18:11:48 +0200 (CEST)
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
Subject: [PATCH net v5 3/4] bonding: 3ad: fix mux port state on oper down
Date: Wed,  6 May 2026 18:11:43 +0200
Message-Id: <20260506161144.465485-4-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260506161144.465485-1-louis.scalbert@6wind.com>
References: <20260506161144.465485-1-louis.scalbert@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 295474DDF03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,jvosburgh.net,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com,6wind.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284938-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,6wind.com:email,6wind.com:dkim,6wind.com:mid]

When the bonding interface has carrier down due to the absence of
usable slaves and a slave transitions from down to up, the bonding
interface briefly goes carrier up, then down again, and finally up
once LACP negotiates collecting and distributing on the port.

When lacp_strict mode is on, the interface should not transition to
carrier up until LACP negotiation is complete.

This happens because the actor and partner port states remain in
Collecting_Distributing when the port goes down. When the port
comes back up, it temporarily remains in this state until LACP
renegotiation occurs.

Previously this was mostly cosmetic, but since the bonding carrier
state may depend on the LACP negotiation state, it causes the
interface to flap.

Move an operationally down port to the Mux WAITING state and clear the
Synchronization, Collecting, and Distributing states, in accordance with
the 802.1AX Mux state machine diagram.

Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
---
 drivers/net/bonding/bond_3ad.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 1247a1e048df..b531f68a24b0 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -1055,6 +1055,8 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 	aggregator = rcu_dereference(port->aggregator);
 	if (port->sm_vars & AD_PORT_BEGIN) {
 		port->sm_mux_state = AD_MUX_DETACHED;
+	} else if (!port->is_enabled && port->sm_mux_state != AD_MUX_DETACHED) {
+		port->sm_mux_state = AD_MUX_WAITING;
 	} else {
 		switch (port->sm_mux_state) {
 		case AD_MUX_DETACHED:
@@ -1202,6 +1204,11 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 			break;
 		case AD_MUX_WAITING:
 			port->sm_mux_timer_counter = __ad_timer_to_ticks(AD_WAIT_WHILE_TIMER, 0);
+			port->actor_oper_port_state &= ~LACP_STATE_SYNCHRONIZATION;
+			ad_disable_collecting_distributing(port,
+							   update_slave_arr);
+			port->actor_oper_port_state &= ~LACP_STATE_COLLECTING;
+			port->actor_oper_port_state &= ~LACP_STATE_DISTRIBUTING;
 			break;
 		case AD_MUX_ATTACHED:
 			if (aggregator->is_active)
-- 
2.39.2


