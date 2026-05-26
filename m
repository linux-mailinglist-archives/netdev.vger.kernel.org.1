Return-Path: <netdev+bounces-291589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cG3xDeldFWp7UgcAu9opvQ
	(envelope-from <netdev+bounces-291589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:46:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B37F45D29CF
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3AA33036D77
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9803CDBC4;
	Tue, 26 May 2026 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="SvU0/VWP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f98.google.com (mail-ej1-f98.google.com [209.85.218.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D623CCA13
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779784869; cv=none; b=BtcbExyw9uKHsY6aTitkcWIsXpIvbxg5w5jGxeZq5uyJSpNTZ69WCTMrYGXEihSbn+9s4VXix7qsRgK33C10mtLCJZEgqPYD6ZmrVMhr0htcFIoCaPp/3Y9/yQYg9kWgkKQfOU41hb9AmESs0F2q+5HuqhPO5s5S5uw0N8XmSpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779784869; c=relaxed/simple;
	bh=zA2ROzHWZXkUOWk9lmM2u7MxyVOBZU/AcvxJvbk7oU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l+MtbKjjaH1VK6w8hgH+9ir4M/LwU3PVeQBTrxzQFK50yt2w+fvgyoDOTU/ABWSVgXeV1kMp6znrDiVkTtw11VtuN+KEHqtIcqDPMuMf1haY02Ih6ErQo4fRJkwJmJIROOSBo2I7uV6lUEbdd9rP1WtDHwNV0OvYGxahoIIpGL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=SvU0/VWP; arc=none smtp.client-ip=209.85.218.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f98.google.com with SMTP id a640c23a62f3a-bd6460b0d11so1809785566b.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 01:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1779784865; x=1780389665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYzyHkZAVrqxYKtVMiV2R8T9XxtfxO9mbM5nkUbPmcI=;
        b=SvU0/VWP+sClZw369AeGE8S/gOcx/Cp5rrzpLDmoo/1jfOhtlQCOrGpxMR2viI5XaV
         GM2KR4eAsQLLKpr+BJBSIPI4kDK/1vmxMhQVoV7e3OoRixcOJfNASvloXcbU/nE2711P
         nZ1Mi7TnC4BFaSCkTv8BHqA28DvwOOn1voKksssMpXTrQfX2wvP/fkr1JHz2ATzFMSHq
         md48YAWbvexl9qso/E7nStVU7ubxXT9/DDo527jxLUKnRP86uWe4iq3qr5HsO84hWkS7
         cQ2DhfRP0+izmi/pvgC/BjBTVMAfzVEsTXDZwmm0qRERSlCf/9jr55MX25LWxNY4eTNy
         S14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779784865; x=1780389665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vYzyHkZAVrqxYKtVMiV2R8T9XxtfxO9mbM5nkUbPmcI=;
        b=jZRbmM2k+5WujhItYag5uLkqndHSyfTWrKKr9DJF1X7nNJQz8e0pl3uuqXZYT0kakZ
         SrqgSITdvFzt/w2DGc5TK7rx5SL5EmDFuoDWkseHRenxQwVU4+amZcYK6McYugofh+eY
         aLb6XqGMtkDccCoCglmPa33ov5PP2ubq/WMZjMpiVQLABc7JCUEDqIYaX9gbwzvsLUwZ
         nE436Zz1cUMaGom4RwrNizrSHbjf8mzNn+m7q6abI30KfTF352cWldohrc9BmDFOs+lI
         AkuivB/8m7EDnzLRp9/o8X8e2b07f/pVoOeo0YokWgBNrUXTsMEDdErRbAFT+giY9UI1
         ph+Q==
X-Gm-Message-State: AOJu0YyPF28HH+k2B5VBp0qr7t/WGkdUEif3HtUxTxS+RWL2hgBY+gKj
	Uj8zczqGNQehBcAcb1z8LIaqKPny+ucGK61hFz/jUHhVUrRPJ51kJsa4tfpXwyy8FW4f76G5rUs
	31OAU/smcgqBgACPl7esW8pKaJsGom6OMPWGb
X-Gm-Gg: Acq92OEoYrVzkYqOfDKX3+h0Y/J+Wulo4Jdb7uyrWvX+i5Gl+HqQ+w/Gc3S2LJezYGR
	7GX08kiwXQZAv7EMzsOES7fmrwrg+cOp3MX0VB3WswKkkNcPRBUCKrz+4CETIgq3/uGdsSBBGF1
	rkJjh0/KLRBTbrl56nYObq9nThmCQbMQk+lkZKz2Hfr0Z6CCM1nPPVWeG9ErVnWlJ26qN7wdnt2
	0qD7+FWvs8SOAhlVKTFXa/cE7UarQVjH1bQLHlBWJJUiEi7AEykTiJd0xWqcJ+1VwRBfZS/UFPo
	2E1tNMCLRCC2VuZ4gBI8UUTx15HFpWO8QZ6Bnq+ZdyCR5sWJeX8wFl4EtxbXooUUlF7fuJlY0rc
	FFNuxezpsRfYTccKD5Z6u+LdPdbBtanDFhJqJ7QHKq1vN7IDyR5fo
X-Received: by 2002:a17:906:31c8:b0:be2:3679:1b49 with SMTP id a640c23a62f3a-be236885e97mr193424466b.40.1779784865448;
        Tue, 26 May 2026 01:41:05 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-bddc59d3e36sm69859966b.45.2026.05.26.01.41.05;
        Tue, 26 May 2026 01:41:05 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 3DBB5124B2;
	Tue, 26 May 2026 10:41:05 +0200 (CEST)
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
Subject: [PATCH net v7 5/6] bonding: 3ad: fix mux port state on oper down
Date: Tue, 26 May 2026 10:40:47 +0200
Message-Id: <20260526084048.1696544-6-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260526084048.1696544-1-louis.scalbert@6wind.com>
References: <20260526084048.1696544-1-louis.scalbert@6wind.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,jvosburgh.net,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com,6wind.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-291589-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B37F45D29CF
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


