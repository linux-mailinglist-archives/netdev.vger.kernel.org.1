Return-Path: <netdev+bounces-287986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DFDBtnXBWqacAIAu9opvQ
	(envelope-from <netdev+bounces-287986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:10:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A150542CE2
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5D0630796D7
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4C43E3165;
	Thu, 14 May 2026 14:05:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E354333FE09;
	Thu, 14 May 2026 14:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767522; cv=none; b=dM+0SyqAlghrChKcfYnbWaQlzUOl5zXRZKdsI4/EJVLtgpjk80cvo129c3BplXnNlAa27udG8gbMM68qkZW9hYC7neW2HbrpeYV62ruRBRri8AOm/MGcqvvPqhdNGdhtfiV2SUHbJHNTE9ncCWSyZBJi4wEQq1nk9ZdEJnQaJQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767522; c=relaxed/simple;
	bh=f0Qb6OMYjQafyzQKWq3wTLfusai2IL6WetDwE4ZoWaU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flebc+dIOAp0JpRMedrEmA6+A4dW+2F1vFWd9/E7D3US/kM5qVUmpB9e1IwKQG4m/aMA+I9lDIZ1lM6hGul7tszOlQl3/uJiRzUzTuv4SbcYpHYq6bka2bbf4KOPhAkI5WoK+075wvopsjDpNIGLazkO1Wag1xVsiGocg8/Lx6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wNWgd-0000000046j-3TZS;
	Thu, 14 May 2026 14:05:15 +0000
Date: Thu, 14 May 2026 15:05:12 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Sean Wang <sean.wang@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net v2 5/5] net: dsa: mt7530: untag VLAN-aware bridge PVID
Message-ID: <85d25ea1b26d3c907f815649f2e0bde6560282a3.1778766629.git.daniel@makrotopia.org>
References: <cover.1778766629.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778766629.git.daniel@makrotopia.org>
X-Rspamd-Queue-Id: 6A150542CE2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287986-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	FREEMAIL_TO(0.00)[arinc9.com,makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,mediatek.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:email,makrotopia.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,topnotchit.com:email]
X-Rspamd-Action: no action

From: Edward Parker <edward@topnotchit.com>

With bridge VLAN filtering enabled on a port configured as untagged
member of the bridge PVID, ingress untagged frames do not reach the
corresponding bridge VLAN upper interface (br-lan.<vid>). ARP and
similar traffic is visible on the physical port but not delivered
to the VLAN sub-interface.

The MT7530/MT7531 forwards frames to the CPU port with the user
port's PVID tag applied even when the frame ingressed untagged on
the wire, because the CPU port is set to MT7530_VLAN_EG_CONSISTENT
and is a tagged member of the VLAN entry created for the bridge
VLAN. The DSA core then sees a hwaccel-tagged frame whose VID
matches the port's PVID, which the bridge does not treat as the
untagged-on-the-wire frame that the user expects.

Set ds->untag_vlan_aware_bridge_pvid in the mt7530 and mt7531
setup paths so the DSA core strips that hwaccel tag in software
when the parsed VID matches the bridge port's PVID, restoring the
on-the-wire frame as the bridge expects to see it.

Link: https://github.com/openwrt/openwrt/issues/18576
Fixes: 83163f7dca56 ("net: dsa: mediatek: add VLAN support for MT7530")
Signed-off-by: Edward Parker <edward@topnotchit.com>
[daniel@makrotopia.org: improve commit message]
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: no changes

 drivers/net/dsa/mt7530.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 5b58e42bfda9..d114922e10e3 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2452,6 +2452,7 @@ mt7530_setup(struct dsa_switch *ds)
 	}
 
 	ds->assisted_learning_on_cpu_port = true;
+	ds->untag_vlan_aware_bridge_pvid = true;
 	ds->mtu_enforcement_ingress = true;
 	ds->ageing_time_min = 2 * 1000;
 	ds->ageing_time_max = (AGE_CNT_MAX + 1) * (AGE_UNIT_MAX + 1) * 1000;
@@ -2643,6 +2644,7 @@ mt7531_setup_common(struct dsa_switch *ds)
 	int ret, i;
 
 	ds->assisted_learning_on_cpu_port = true;
+	ds->untag_vlan_aware_bridge_pvid = true;
 	ds->mtu_enforcement_ingress = true;
 	ds->ageing_time_min = 2 * 1000;
 	ds->ageing_time_max = (AGE_CNT_MAX + 1) * (AGE_UNIT_MAX + 1) * 1000;
-- 
2.54.0

