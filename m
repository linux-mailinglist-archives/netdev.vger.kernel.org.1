Return-Path: <netdev+bounces-276113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMdlJI8/1Wk73gcAu9opvQ
	(envelope-from <netdev+bounces-276113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:31:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE443B25EF
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0681930557CE
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 17:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6693433ADB5;
	Tue,  7 Apr 2026 17:30:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C08C30FF20;
	Tue,  7 Apr 2026 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583043; cv=none; b=dAtI+JAsK768O9It4J16dM4GxpjkZw+K17GnipPbBDTPcdKLU2PfM6cyAvL1uNMrsLlRuDscB356QlGtn8Mf26q8xoY9sauBx38DHwDkNPNbw5Qeje6HRctOalJR2s5ddQEw3lEy4/JMhreN5Upo8A5RdxEPNa96jz60CUKTfl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583043; c=relaxed/simple;
	bh=Bx71B91bExZVi8hwTVvN/Q1tQ4CJ9ow2kReJr6TCmRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6ES4kjNVKyOrAJ9us7mizTlPH0yXeVpC1Xyv8KV4RotVXxtK0DPkuexoUHes+Z9wmpPVU+3SGXHcZ+x2riQHsqUOBOEbA7I2GhXfA9g8Z1CXVuaKxTDJtieEMgDSy2fzB58jPuWhjHHMX2zBOkFVPxCUaofJcLzMuGHTfg8RaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wAAG6-000000000ob-29PF;
	Tue, 07 Apr 2026 17:30:38 +0000
Date: Tue, 7 Apr 2026 18:30:35 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next 2/3] net: dsa: mxl862xx: don't skip early bridge
 port configuration
Message-ID: <15962aac29ebe0a6eb77565451acff880c41ef33.1775581804.git.daniel@makrotopia.org>
References: <cover.1775581804.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775581804.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[makrotopia.org];
	TAGGED_FROM(0.00)[bounces-276113-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FREEMAIL_CC(0.00)[gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,makrotopia.org:email,makrotopia.org:mid]
X-Rspamd-Queue-Id: 8FE443B25EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mxl862xx_bridge_port_set() is currently guarded by the
mxl8622_port->setup_done flag, as the early call to
mxl862xx_bridge_port_set() from mxl862xx_port_stp_state_set() would
otherwise cause a NULL-pointer dereference on unused ports which don't
have dp->cpu_dp despite not being a CPU port.

Using the setup_done flag (which is never set for unused ports),
however, also prevents mxl862xx_bridge_port_set() from configuring
user ports' single-port bridges early, which was unintended.

Fix this by returning early from mxl862xx_bridge_port_set() in case
dsa_port_is_unused().

Fixes: 340bdf984613c ("net: dsa: mxl862xx: implement bridge offloading")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mxl862xx/mxl862xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index 9a9714c4859b1..f65525aff5e52 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -278,7 +278,7 @@ static int mxl862xx_set_bridge_port(struct dsa_switch *ds, int port)
 	bool enable;
 	int i, idx;
 
-	if (!p->setup_done)
+	if (dsa_port_is_unused(dp))
 		return 0;
 
 	if (dsa_port_is_cpu(dp)) {
-- 
2.53.0

