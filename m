Return-Path: <netdev+bounces-279322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJMFAxg+4mmB3wAAu9opvQ
	(envelope-from <netdev+bounces-279322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:05:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B193A41BD96
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B3653025431
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89A139C635;
	Fri, 17 Apr 2026 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="btQVWdR8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f99.google.com (mail-wr1-f99.google.com [209.85.221.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3033C38A72D
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776434710; cv=none; b=fNu/n9W0UEp9afG8v/5dldSvDgHwxDS47XWp/B4bj4CoSgqJoxvP9PBap54LO5JJz4Q/LdJSgAJ8Glv2fL1xhlfdrGLNEkvDhM23Dldj6ZnCDQe7vmx5kAZzMDU9vaNQl0Ou5oscd+dQLNXuNN3UoXBnv77uVkLxTcyMX3/kqCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776434710; c=relaxed/simple;
	bh=RV0F0cGg/B4Hla+4EDxuIbKtjxvm1rpRGuTsEG/qnkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RQO3ELblTZnPusrqIlpCudQ+qnpth+PabKdnVGrrFXlPxJ8VJ8yzVabO196V3hft+rVahzFGhyZWobu90CQr3u76KfAfXoT94cmbtiyTY14Gfi0bumzLUoEtZuHbvTc2CVhcXydN0riWbq2XMGxeW+lfwVVG5vis94yUETxK8Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=btQVWdR8; arc=none smtp.client-ip=209.85.221.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f99.google.com with SMTP id ffacd0b85a97d-43d6fbd0954so527616f8f.1
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 07:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1776434707; x=1777039507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5pzb1ZFVU9ItBjaAuOHRKvmdpU0SycV8WumuKv9ROQ=;
        b=btQVWdR80XMcO/y8cdDG31gKFAxKrWIGu7LSbY3l13BBaVmkwf6KoQGs6Ajn2X/MvM
         khjDnh/+l/DOlIu5km5904LXWKe2VZ+Sq08x1XJMT2UX2TNMqsiNuFT10plIxAYmxyzK
         4PrHEfcXnO+5soG93mD7SvAlhi2kiMXvLyQhHhw1rt+ZTzff0jVoU+uha57mAM87aqcM
         6GVUniEUXl5WTXNS5wCKI3/gEgNn4OuF3WxNA40cWEr6YKDqTSl/PgN4+qNLpUkZaD6f
         PUieMzu/Awdy18oXSaysAWjQq7CK0Sw8wI7XQqjgOkh6hw/eeUQMmLIbQ0ldwtr1xsdy
         d3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776434707; x=1777039507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j5pzb1ZFVU9ItBjaAuOHRKvmdpU0SycV8WumuKv9ROQ=;
        b=EHhgikS+4rCPl9OzZqJNoZL2NMU99Icad/Ys/n82WqZutnIT7KG2jGxUe0RtbNiTpq
         cLSCJOZg0jzD7Sflcbj5ILc0C4NLSResmc5sQzDN7iI2fwZouEJbpW7y46cz8/3xW7eA
         t4c4NR6+Z2exoyDqpvm9eZsQRTt6ooKjHot2UzcooFIY7Z5UlO1qlWLp0jNkP+j9DwBV
         xPkQS93vy9mNSJIbV+p6OvMyMJ+FEojs5aX0LOTKnmVDuxbcYrHMUchKspyucjcrXma4
         jRGxva1S/GZoK77fxauDH7kdtQKQuXDDofTZF/3Dd5FR0lbZNDNHY/KU8DAUBzF1FOv7
         vGZg==
X-Gm-Message-State: AOJu0YwPsxR2X9XUHDi8WdDblkKBSKkSgWQa7NNQX3cEIm2NQrVdy+mw
	8Tub7UgRS56wafla56QUHqhs0QIfhCGb+hu3IwbC2ruRiD342PKAgbiYi545T8VJdzBTrCU5wT1
	ioZXiGiCuqXRdk8g4SoJCgoeE+NihkUNmnW18
X-Gm-Gg: AeBDiesg7Kr4Rvd+sPPQwOZMR1Akb97R/mg5X83BhRFeSyj1B7fe/pc6j1hhZnoq25V
	kaXiNMhEG9mUV6Ns9q7q32B60pBl/bM3IQpvR35lpXb0WMNjMWacDQnK+jVUgMHPOydui6Zl6vR
	eZERYnUYMdxEbiQMVSUbGyvIFC3H5jwXUV19CaS1jnyCNpPtJUB3djHWtob8SHCQN3xmbP2k/rU
	Ee+nccMakpz5TgXG4eAl5bLPJ4QDNT3nNjGSt+S5PYWvLV0yCq22wXxY8z3PazhwEIeBXtnDfSg
	o0f5KY7Yta0WlU5gHkicCYooXycmfZtZ9fkTFJNCNI6vW9Xu8xb0mUmSp1g6MByUrLCWpZjPLft
	VpOeAfKmJyHpBnbI3kZ/z1wPyRKWF2tk85GnszmT3fGnBqGZsdVIhm5Q1sy5DxBY=
X-Received: by 2002:a05:6000:25c4:b0:43b:8f56:1e1d with SMTP id ffacd0b85a97d-43fe3dc10demr4425381f8f.13.1776434707332;
        Fri, 17 Apr 2026 07:05:07 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id ffacd0b85a97d-43fe4cb343asm107054f8f.12.2026.04.17.07.05.07;
        Fri, 17 Apr 2026 07:05:07 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 3389313650;
	Fri, 17 Apr 2026 16:05:07 +0200 (CEST)
From: Louis Scalbert <louis.scalbert@6wind.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	andrew+netdev@lunn.ch,
	jv@jvosburgh.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fbl@redhat.com,
	andy@greyhouse.net,
	shemminger@vyatta.com,
	maheshb@google.com,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net v4 3/4] bonding: 3ad: fix mux port state on oper down
Date: Fri, 17 Apr 2026 16:05:04 +0200
Message-Id: <20260417140505.3860237-4-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260417140505.3860237-1-louis.scalbert@6wind.com>
References: <20260417140505.3860237-1-louis.scalbert@6wind.com>
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
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279322-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,6wind.com:email,6wind.com:dkim,6wind.com:mid]
X-Rspamd-Queue-Id: B193A41BD96
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

Move an operationally down port to the Mux WAITING state and clear the
Synchronization, Collecting, and Distributing states, in accordance with
the 802.1AX Mux state machine diagram.

Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
---
 drivers/net/bonding/bond_3ad.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 9cf064243d58..bc2964ea11f5 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -1053,6 +1053,8 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 
 	if (port->sm_vars & AD_PORT_BEGIN) {
 		port->sm_mux_state = AD_MUX_DETACHED;
+	} else if (!port->is_enabled && port->sm_mux_state != AD_MUX_DETACHED) {
+		port->sm_mux_state = AD_MUX_WAITING;
 	} else {
 		switch (port->sm_mux_state) {
 		case AD_MUX_DETACHED:
@@ -1200,6 +1202,11 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
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
 			if (port->aggregator->is_active)
-- 
2.39.2


