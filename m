Return-Path: <netdev+bounces-284433-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOYxFj3++WkqFwMAu9opvQ
	(envelope-from <netdev+bounces-284433-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:27:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE07A4CF5E3
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E3093147350
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 14:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41C7361662;
	Tue,  5 May 2026 14:17:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C25A480355;
	Tue,  5 May 2026 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777990625; cv=none; b=tcqrrXGqyRzU1X6vO1AsHFNWWoxZah0SFGBP9+ziyYRqmBJgWV/iDFVaxcD/qBrbFHBfIdXk85fMdSxMVT3Yj8RcYIid6beMJ7dA/zn0GZ1aprdcLPxqg9ePP+4VjCuveFbOQbWl2g6RD6REA6nK1Ncsg00sxP1x73A+V3GqCuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777990625; c=relaxed/simple;
	bh=4h7T+gYLbRSieuhnWr0d7eaW1cNMbGPRyC9H1b/xvnQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLCBJZ3wrgMDh5w54DbUqCIVzW/QSyhsaPESqDCOxR013j70JI7lKyLcdBhlB6uhuHFYqTQVNtUDMn3DJJ3RTEL72gJXwVxEv/4Yh5QuBv0bbaNgdfE+u1EpHuUUEsjSPMmR9mNUpPpPx2xCaLn+dEu59Yk9ccy47sj1k4+8SGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wKGa3-000000008T3-1K8F;
	Tue, 05 May 2026 14:16:59 +0000
Date: Tue, 5 May 2026 15:16:56 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Edward Parker <edward@topnotchit.com>, Andrew Lunn <andrew@lunn.ch>,
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
Subject: [PATCH net 5/5] net: dsa: mt7530: untag VLAN-aware bridge PVID
Message-ID: <79d4032a475ad94569669a330bc1a731b85db962.1777986341.git.daniel@makrotopia.org>
References: <cover.1777986341.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1777986341.git.daniel@makrotopia.org>
X-Rspamd-Queue-Id: DE07A4CF5E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284433-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	FREEMAIL_TO(0.00)[arinc9.com,makrotopia.org,topnotchit.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,mediatek.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,makrotopia.org:mid,makrotopia.org:email,topnotchit.com:email]

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
 drivers/net/dsa/mt7530.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 2e5337186800..4b7e5398b211 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2452,6 +2452,7 @@ mt7530_setup(struct dsa_switch *ds)
 	}
 
 	ds->assisted_learning_on_cpu_port = true;
+	ds->untag_vlan_aware_bridge_pvid = true;
 	ds->mtu_enforcement_ingress = true;
 
 	if (priv->id == ID_MT7530) {
@@ -2641,6 +2642,7 @@ mt7531_setup_common(struct dsa_switch *ds)
 	int ret, i;
 
 	ds->assisted_learning_on_cpu_port = true;
+	ds->untag_vlan_aware_bridge_pvid = true;
 	ds->mtu_enforcement_ingress = true;
 
 	mt753x_trap_frames(priv);
-- 
2.54.0

