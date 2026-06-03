Return-Path: <netdev+bounces-294799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 18wNAxZGIGp0zwAAu9opvQ
	(envelope-from <netdev+bounces-294799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:19:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B90E563917D
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:19:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=6wind.com header.s=google header.b=aSeLhMib;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294799-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294799-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=6wind.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5484830E244D
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 15:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C9C3A3E96;
	Wed,  3 Jun 2026 15:03:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f99.google.com (mail-ej1-f99.google.com [209.85.218.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016BD384CF7
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 15:03:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499016; cv=none; b=cs3ET1zYt9HtujryPoE/5NKfoU4VUGPxL4qG6T9eLsHTcF8BrWF7O9p+V7I3IpEvIZaSShl6Np5NI7lwLDi/dsOehrjUki+pUxI+lwZysDW1LcddTaTb68lESkPetIWObkbFiljwYj0lnOBGBGzymZoSdElKFSt5GJk7s8uzhc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499016; c=relaxed/simple;
	bh=FHmhFntMj/tK4ZN+OV7rbeyvzvuBRGRmI9u2G5h/KhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NrLSt41ScdnzzuOtPt2h3esTPY+XBZTxZtuy4I41lnsbeEz5Ip8VbIwyDF3oGucEcOXSucP0AmkXoVPu+cTboHsg/h9/Go+C91u20k/VD5VZGspxyIiGrWf253eJa23eJaANkEfr9RfozlX1X7897bj7cL7fgUxNlY0dqsHyaWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=aSeLhMib; arc=none smtp.client-ip=209.85.218.99
Received: by mail-ej1-f99.google.com with SMTP id a640c23a62f3a-becfa735b9aso531255766b.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1780499013; x=1781103813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02JMPGZKVWx1vQdBy740XViOLIkd3niDYziQ8fLNiB8=;
        b=aSeLhMibR+9zGnkvuMkYMBTykjuSPV4OvjyCP+DkL2DqONITq7bHws2lUoVO0TVr6M
         YeNOWtayOSwlaOlD/rYntDLtdH4utf7r1iTL6Z5dMa1tlUbTZ87saxpLTKJnm4XKeK1e
         rQTSnmhBKb0mpUiZmieUpSlOXSgy8YnS2pLPTmw4a23DHtknXNEtp+DsqCitDlu4OMOl
         8mDdsIThc0sj7Kc/7m5k7xLjLhPFMloOU+MFP/+l1WfwrzHS4uxx27hWMYE7V8LnEzm0
         CTUokz4t6m3mc/2GQy4FlZMNTIWwnDvOG66Q31ZuZrGZP450capen+OItM46K+nORxmL
         Vqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499013; x=1781103813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=02JMPGZKVWx1vQdBy740XViOLIkd3niDYziQ8fLNiB8=;
        b=E2z6PTqjTxC9zdZsMJB0g1UfyCvpUAxUVbUojjBOH560n7WgOGdDpY4uG96tc37t5h
         EzctgWbMTFymlQhvY9WwYpey3grvxKIEwxAWRwALRJQ9oPRgwFFCZYPowW0y3y9r7NyH
         m3N+tGt7xHUMGm4qtT3i8BLIoDKs+gsmq9TSXzca2rDuB1pWFiSiaAzsH8f15iCv3sf9
         hPBnIbxOgLahWgLA9T4UocNfnIdyDD6pDOckt9HxGjuTFBvHHB3hGy13FUI0HZJRITQb
         wmL1ENY8ByVtpl8ir0lFL4frxF/FM2kPans4zPyNLkSpQ2UQr+PXLXsLKtQ7qTqeKJNk
         7Pxg==
X-Gm-Message-State: AOJu0YyfQ4CvC/XJgBjmLTlTFpZr6i/uUEbbrH2/pS3ltjspzryeb5nH
	kZGQkRiKtAQQb9nDXYOSU59Ad0I7i433GOvYqTSZgBWZNTZy0UajEt76jpsAgRg+RYASnNSzeHA
	ZqxtSLFq3z6sSgoe8F1ffxMfcOTJf638oqmhf
X-Gm-Gg: Acq92OGqidvPYKrKG6/n4bjI6wageVPXLk+iZngxuZnpCLwVLBvluMGj+HFNdJqvVID
	oXqne4gdwdOlwIb8JPkvjEuCpyVTeRXDIVvPpi3xTVtyqkoSIJZjS2+tlDJj6Os3vdIrX5R+4+R
	kGVGrVZ/TtjBlqgePnE9qpnKrpaT+tYpAZ2oRhCUBDwrB+f+aUX0EvM/dTKiV0DwDfOK/oEpFM1
	ydeoMlKRd6w7GZEZEGnbXUpljeTIFpvrrAe5sMZWkB9BBqmy5h3pu6/SdyRIP8uBcQFTGTjMl09
	3r5rnStwxZNnMDJwr+ExNB47to/H/drPQ/DHVbNegdLc/nPK5g+igoqpbLmjrOrVprmvA3Uww0u
	sccbjOSP99A7gvZ3bYOLsc2KA//eqXpmU6KTAuvWC1Kg/7Tp7psmuOiCi/eTVGQ4=
X-Received: by 2002:a17:907:3f07:b0:bd3:32ce:8902 with SMTP id a640c23a62f3a-bf0af2039b9mr236308966b.39.1780499013367;
        Wed, 03 Jun 2026 08:03:33 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-bf051580cabsm19732966b.2.2026.06.03.08.03.33;
        Wed, 03 Jun 2026 08:03:33 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 0698714714;
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
Subject: [PATCH net v8 5/6] bonding: 3ad: fix mux port state on oper down
Date: Wed,  3 Jun 2026 17:03:30 +0200
Message-Id: <20260603150331.1919611-6-louis.scalbert@6wind.com>
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
	TAGGED_FROM(0.00)[bounces-294799-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: B90E563917D

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

According to IEEE 802.3ad-2000 and IEEE 802.1ax-2014, Collecting and
Distributing should be reset when a port goes down:
- In the Receive state machine, port_enabled == FALSE causes a
  transition to the PORT_DISABLED state, which is expected to clear
  Partner_Oper_Port_State.Synchronization.
- In the Mux state machine, Partner_Oper_Port_State.Synchronization ==
  FALSE causes a transition to the ATTACHED state, which disables
  Collecting and Distributing.

However, Partner_Oper_Port_State.Synchronization is not cleared in the
PORT_DISABLED state.

Clear Partner_Oper_Port_State.Synchronization in the Receive
PORT_DISABLED state.

Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
---
 drivers/net/bonding/bond_3ad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 98abb2fdd7a6..ab7ce9eecbf5 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -1337,6 +1337,7 @@ static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port)
 			fallthrough;
 		case AD_RX_PORT_DISABLED:
 			port->sm_vars &= ~AD_PORT_MATCHED;
+			port->partner_oper.port_state &= ~LACP_STATE_SYNCHRONIZATION;
 			break;
 		case AD_RX_LACP_DISABLED:
 			port->sm_vars &= ~AD_PORT_SELECTED;
-- 
2.39.2


