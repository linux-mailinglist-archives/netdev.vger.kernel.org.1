Return-Path: <netdev+bounces-289904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DUmKaShDWq10QUAu9opvQ
	(envelope-from <netdev+bounces-289904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:57:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0601E58D165
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE3D3329FAEF
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BA73DB306;
	Wed, 20 May 2026 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="L4pYBzoE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f227.google.com (mail-lj1-f227.google.com [209.85.208.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4992C39B483
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779276346; cv=none; b=tvOIms1bxrotDtyJY7ixBkeKMuMGAISZCz5x4aIzkvF7WIdT5gssZAd5XtJiG4N6dyV+FTPhROnOscV83WUZAl8nynQfxR0nY5JUDM7ngzlcEsQitWOOKLy7sGMk2M/9zVuzqvtJ5o0V35qvacfu3Pxnd5d0EiUJKhRHdtWWFjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779276346; c=relaxed/simple;
	bh=zA2ROzHWZXkUOWk9lmM2u7MxyVOBZU/AcvxJvbk7oU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dfZzG8A5Rkqent57ClZWFpY/EDTki9JP/iR8OP+modw2nYa60Fh6YBXZHwUM4XiYrV635M7dLQgzlW2NRlSrxum5UE5w2OWsruI0akOc6eddgYtD+JJzrePoyXtC02H+MsG35aU62hRsydLsBzlVkNIoNx1DitsFuWwJ0ne4iqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=L4pYBzoE; arc=none smtp.client-ip=209.85.208.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f227.google.com with SMTP id 38308e7fff4ca-38e7c3a2deaso44557661fa.2
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 04:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1779276342; x=1779881142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYzyHkZAVrqxYKtVMiV2R8T9XxtfxO9mbM5nkUbPmcI=;
        b=L4pYBzoEtaDV+j/8A/PVYx2AKo1DpBkrlkHq85Bct+b0SOnlqlpIgml1ToMf2nwOWf
         8G81cLzEzVwP4QLJotQbSg1MjO4JhsF81e4UX5XRox6kbilJ7Z4ypDUWyLKm8P7q6cDb
         znZ5DieqPen/z2fLIaHf3Rlsh2GlYpA90XilSkeZBCcjG5B7ru72/TAKEmz9DjfIViUw
         zKdq5GgevaeupPgDk/FmarzrmPGF/4NrWyp3X2CQZIv8yyjqiZhSeYTstm90nibP7K4d
         CIDZXcsVAu7rV/M27CxFA95EnlzstXTIp1Qr/BAONtoGTq6iPJMBJ7UHFrpm7681C75N
         t3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779276342; x=1779881142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vYzyHkZAVrqxYKtVMiV2R8T9XxtfxO9mbM5nkUbPmcI=;
        b=G5XUvQRUyKg912/XGpGmNlhypJ2M4VnJyYToVkNzu8eJEY46aZfuGafMaWI9ijA7uL
         YHrm25/5VBDwM4x68SQ9/TwjCSUKy0CW3J99DoxH2Tl9YKofTSZhLMqmIJ08ydGPFeHU
         7lR5pKathUvjXl+hNnxTCRL46MZ5e+SIt9MndWYCyoOGcbGHj9Rl5KUPhZ29QVLKIqVF
         xYGY+z9R3ATAcZ5eyfcQdiFBY8XrrQwwni5LR0ofEthnUSxYSOeXK7ffx1cnrqIABmx/
         SLcCWgjo6RARDgBYSh8mMoBKqICSHA9ffhG3b9BunGrWBomAo2ej7B6MPKTdlNT4hiit
         vhgA==
X-Gm-Message-State: AOJu0YxhsBf6BKif75wC7OuVLojDqMwTSNSIIkY7wOcFSn6UC30z7FvX
	lIThiln6AVFbGlmNnNySQHfXzhqlUXnceCqJgo4V3TUl+hJn39lW2aDtL7nYwuXkW7X4+Xy4WGb
	sqc5QUHa12rzxyep0gZuJfi7WMsc35/qTZ20H
X-Gm-Gg: Acq92OGo7A5PxG54cBC8Ig2iRFMa9eshCJPjGjjZVNUXa6l5NPUlc5QNOGbTgmUvnfe
	VdDr7Q5sWkRjrhJ6IYrS7rjpzJh6C7KXmRuGV6PKidIu/AkEqPR9VR/3ijU7EyxVVUji9PVE4mT
	G7FNmM+9t1HuUdVyC/XpLQWmxu5x6rcXTIZBUFbPcY2Xhcphy9C1T53hh6DNnisH3Q1KnSKiAPX
	7XqE7Y4oTMkf9R7CYvA8U8TG6fjt5y6Cm8x2Su+e92CEVSWzCY+3mgv+uFS8HryTx9yFBYl4Z8u
	SiuvMlVW0VMBrbNAaXQYf1rovfSAYTIrWKGELXFxos/uM3hzf/sUHPpZfs2hOFyfRgm/5sp1OTn
	JzJ1ljcPky47ldvUaW44bzei4mtcajsR9sYR5B4/LJcXUboVudxxD
X-Received: by 2002:a05:6512:2384:b0:5a2:c4f1:2635 with SMTP id 2adb3069b0e04-5aa0e74e119mr6833680e87.41.1779276341680;
        Wed, 20 May 2026 04:25:41 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-5a9bdb5307fsm1458022e87.39.2026.05.20.04.25.41;
        Wed, 20 May 2026 04:25:41 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 586A911540;
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
Subject: [PATCH net v6 3/4] bonding: 3ad: fix mux port state on oper down
Date: Wed, 20 May 2026 13:25:38 +0200
Message-Id: <20260520112539.798275-4-louis.scalbert@6wind.com>
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
	TAGGED_FROM(0.00)[bounces-289904-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 0601E58D165
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 1247a1e048df..45a793d45d33 100644
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


