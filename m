Return-Path: <netdev+bounces-276596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFetCeNz1mkWFggAu9opvQ
	(envelope-from <netdev+bounces-276596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:27:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 737FA3BE2D0
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC1D230903C4
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 15:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9315F3D6CB1;
	Wed,  8 Apr 2026 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="V+ZsL1Yl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f99.google.com (mail-lf1-f99.google.com [209.85.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EF63D1CA7
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661841; cv=none; b=dgQX3VTld5ps/caJL6zsxYStWCTHkzHYqFRD2n/vE0cnd6R5ZRVJQcAkvAst/WhvqdCA2yANsNb0W7x0tJmTf1I+o2zrXTbi7Gc8sEPy/FQb2ogDhKCrusvBFtApLIiuRkCdHUUs38uXh8kXHU9VPE5S8JuDUpRj5hTwtNe/cO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661841; c=relaxed/simple;
	bh=ug9SkTwdmJIGwXBOudO4MGLkwAXB1GxtwYmjzlHY0LA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VDm4mC39j42qKPyNAzYSl2aXdH0G44F7tuVtczkXGhj46nuCfJeE/RY5RfZFCmePDcPSXiNiFRPNsxT/ReVnd9nqaAUxmt2oYfg/VsKjkHbtn19ZenLB2BYDRs6JKcGK1g8G2YtUtZHPR0H3853HMBOR01hVIlm4zyI0mUBejlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=V+ZsL1Yl; arc=none smtp.client-ip=209.85.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f99.google.com with SMTP id 2adb3069b0e04-5a3d42263e4so4068809e87.2
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 08:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1775661837; x=1776266637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6kxlTr6EjrNQ4AAJ4E/hmiBtgz1iziJqa4twM/hv4A=;
        b=V+ZsL1YltQRR+YEiyN/cSS64or4+j2lu/MwVeqlDkB1vUvhzYloUDV9njs1DwZez5o
         Moum8Wase/2yPydCy6coimxS+aJF2lkOdB0sl+IOqEdLFcgWSSRHDqqi3Ke2gJpLfTs1
         MtLeidbSYMn+quD78ZMBPhEOcm0BmfXKYcdZiU2x0nP77PhTp96XjsPtlgn7NHYy1r18
         LacJyrRv6eOSBg42dQfY6VriG1qAjR8pANkVDnX14nlr2EKninQhywYjmirAgCcZOKyr
         AXiNwiHNX68cmuFdq2F8gGF2+7yhaDMuEsZlhBRxGOXC2p3tCaIefGutvLVVAFq/cxVB
         ZO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661837; x=1776266637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n6kxlTr6EjrNQ4AAJ4E/hmiBtgz1iziJqa4twM/hv4A=;
        b=MWiuvXIPeMH2V/frAfIDTXSEcVrqkjk1qgX5rr/SGUR3dhAYXoOhuAVx1z+89g9hT3
         K3bX5qG3G3chPpyeTelB1ni390CuV8pH79amei+EpwZ5Z/FUerlFDyeo+ytxj7EgWYOZ
         N0fLbuXUKEMEh2SDQGO/SvSZhOusaUyubRLzfhkOaYBEMxJDw8CEvtXn2o2REEomwpy7
         7vnV0DY/vZW0B5Axo/q8zpyEq0Jx3w+f2wOT0EOlO7+8vt/PTwtH6wqxc1ML41TKj6nO
         PRen2VpmafrWwwZI8y4woJqWnknTJqhcLJfA6edLRI4LVrmtZ0RcB2vwxHJ8gLwbOUaa
         Vc0g==
X-Gm-Message-State: AOJu0YyumHJdRIwy15zHObzivlX0HR9K/AFIvreVvHv9auqAUx//Pc03
	12s0u4OoRd8SM32Sg+1pbBS5aGnjoWv0tgQWeHmqMjk9pWphF+Mh6RqxCBF33aEp86HDKr8Zmu5
	qGuGDqgDM13x6tO0E9zV+5bv1x9edWoRtbE2o
X-Gm-Gg: AeBDievL1//fgdt3bQtcgGkSnmVoNjg0VmAr7BAY0w7KEstoIyjlCQJLpdVzg1SHjXA
	HN++++uD/Z6MulJ3OcO0xes7IKaWSlfmUXGWoGq1OZ9CzsOrXMmQdsxAEiTG7W5cGVJ3u1umS1e
	BwiFzuvaDD5NQBSVcVJ8IdL/SwSVLd1P2rVduTyC8dmXDSdCMPrJWzpCaT8LKYqfFzh583XnuUD
	07E9+eLi0OxHRuWUR+GGyTlCZsm1ggttZ4As+KFTsOBixg4RQuQ0zX9Oii448V8OTI3kQ91Zlqg
	Jo3yTCRaRrt+SozQ1/3CI8pz+/BA29sC2OR2dN9GvuhpeFteJHIEu0GbKkGdZ22fnQj3LT1sR7H
	bEZTr3ECM3a1oSpyHJfEwS+k8poZ8tP7LF5BcRFkxizRHkQt6Xa4i
X-Received: by 2002:a19:520e:0:b0:5a3:7528:6da1 with SMTP id 2adb3069b0e04-5a375286e2emr4416373e87.0.1775661837116;
        Wed, 08 Apr 2026 08:23:57 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-5a2c6c9e93fsm1914794e87.19.2026.04.08.08.23.57;
        Wed, 08 Apr 2026 08:23:57 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id B023D27054;
	Wed,  8 Apr 2026 17:23:56 +0200 (CEST)
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
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net v3 3/5] bonding: 3ad: fix mux port state on oper down
Date: Wed,  8 Apr 2026 17:23:51 +0200
Message-Id: <20260408152353.276204-4-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260408152353.276204-1-louis.scalbert@6wind.com>
References: <20260408152353.276204-1-louis.scalbert@6wind.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276596-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,6wind.com:dkim,6wind.com:email,6wind.com:mid]
X-Rspamd-Queue-Id: 737FA3BE2D0
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
index b79a76296966..3a94fbcbf721 100644
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


