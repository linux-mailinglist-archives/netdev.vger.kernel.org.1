Return-Path: <netdev+bounces-270279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGqHIn01v2njywMAu9opvQ
	(envelope-from <netdev+bounces-270279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 01:19:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF382E7BA4
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 01:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0B46300C9AC
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 00:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECDB1A6803;
	Sun, 22 Mar 2026 00:19:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7372313A258;
	Sun, 22 Mar 2026 00:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774138746; cv=none; b=pso//OgrgWhJ2w364pPWj7EMWUW9pF20PsqCootdFkFKz6UiRmXhj6jGPWj3SxSRL1WSTgCIUeZMyFgCt7rLWe8WsMnkVsRIDit9csMKr0U876q0ZC/WrIM5F3WJfRlOboxQap23DZ8LHFdV9IjkFk0YJFPz6CrqXSOmTTyiRQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774138746; c=relaxed/simple;
	bh=kHUh4DMK4hSNQjOELR5Ln745QI5cflC4Va03ziUL0Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNrqMISvH8Gw4vrWW6Zmv8p8h4YTnYYWHMNxzZVBtby28++HP7DytcXkJiWekGDpjQbe2734xXG8QkLxgZCn5O5f+GIAOwzKzPkAINfOVUy92CyEALAd/W4VSSZzgXruVd224MQ4rrnMGsHgp2jjyQpDSCL8dildz8H98YBGucg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w46Wz-000000001MM-2iNr;
	Sun, 22 Mar 2026 00:19:01 +0000
Date: Sun, 22 Mar 2026 00:18:58 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v6 1/4] net: dsa: add driver-private pointer to
 struct dsa_bridge
Message-ID: <4ff5b936b1f4ad31ffe132aaef798d247a8ac812.1774136876.git.daniel@makrotopia.org>
References: <cover.1774136876.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1774136876.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[makrotopia.org];
	TAGGED_FROM(0.00)[bounces-270279-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FREEMAIL_CC(0.00)[gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0CF382E7BA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a DSA driver offloads a bridge to firmware, it typically receives a
firmware-assigned bridge identifier (e.g. a FID) that must be stored and
retrieved by subsequent operations. Without a place to store this in the
DSA core's bridge structure, drivers must maintain a parallel list of
bridge objects and search it on every join, leave, and FDB operation.

Add a void *priv field to struct dsa_bridge so drivers can store their
firmware bridge identifier directly, eliminating the need for driver-side
bridge tracking structures.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v6: new patch

 include/net/dsa.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 6c17446f3dcc2..1c6f6c3b88e86 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -234,6 +234,7 @@ struct dsa_bridge {
 	unsigned int num;
 	bool tx_fwd_offload;
 	refcount_t refcount;
+	void *priv;
 };
 
 struct dsa_port {
-- 
2.53.0

