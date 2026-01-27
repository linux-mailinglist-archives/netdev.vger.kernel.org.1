Return-Path: <netdev+bounces-253658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNBfNpAeeGkKoQEAu9opvQ
	(envelope-from <netdev+bounces-253658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:10:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7B38EE76
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B1023048130
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 02:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183962D73B5;
	Tue, 27 Jan 2026 02:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPgzfR7e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C782D5922
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 02:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769479754; cv=none; b=SX6i0Iu9Cn4+8NWaYIYLImqXjVDb6TpPitwIIKp2ueYFVf+shzC5wdjstG4qqymmUwxP9NXfTEErgiEMePaBl9lng2AMMOQ7lXd+Np7XXWACH1VHXSuyh3x6zyW34CTvnY4ijt6rYtD0z50yJfu/+7P9WzRxdB9ZwyQxHy0Rays=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769479754; c=relaxed/simple;
	bh=iZJach6s8qYLr3vpM42GbXz2jpGMsX7usKV8PgWY/7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RveDIJCQqp6QGSw4ylCH62qpErp+lH0oYKBpPH/5oiG0Q5ksmSvLZ7ZFAYs007U7jndcmM8ca8C2MUWYhE4a7yBIZtyL/eEH30Gis7dqdj875Dk0yqWg8EiI6Sl5MnODTEoGyXtT0VRsgpmay3dnXc3On14XXIGqyh9SAwz3+KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPgzfR7e; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c2af7d09533so3198373a12.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 18:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769479752; x=1770084552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLHzhuxm7a5X2Q49ADNkLZ5qYk8a4yH9AKsfa8IpJ8M=;
        b=aPgzfR7etoqO6siifkL6SREkmrVLaou22/8GOv2L2agU19xWCC/tyS3e6nsLN7rDWI
         ZDGM/sP8qIg5J3OT3dPYucGRtZXZKhBFneGpRAezp8KkVABThCybqWv/GBzmD2Gex3zb
         EOSOHD3ECaScqZwFO2dIG8TYq8EJaHAeTiyssHdfFCroz53zjjBMksbPUeDT8HJUCEd1
         N9RywXRAa5vxT0YMv1c2gasd5G+Vm++OceCkOcMVwd16+7Vta5Lt6EWLCHAn0ykuJ5PL
         jc4yZbKXs9VynAkD+MvYB7kYHbUJQEOSWIRsnMzzrQy74xP5HLmiShn/8zaOJsSN/r2f
         rBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769479752; x=1770084552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hLHzhuxm7a5X2Q49ADNkLZ5qYk8a4yH9AKsfa8IpJ8M=;
        b=HoQkI7vpDRrvUqXj6Aea83aGbHZaRpTlPeu7Dq6KZhfHvtr3lyGkvAq9muxbD+o9BU
         Pl3tYz+8NJBbe+fOjpzO9CQ4duMiIphXmyzKh38sRVQaMuNQ4HjZoGWsnUks+llnifAJ
         BpCJdVyeTmwKW29Am00GdHVmplPL3Shdv+5EySDxCiJzoE+eJ9P7uoOJDjXZnjTP0YnN
         7o7RtlXPRE5VwrlKXdM9b1qc8OGk6HUCbqba00S8N5dhNn3RVVxtrjYFn1l1TbP90sqB
         X8iq5nMixEX8EO4ptx84hn/ECOGuUBGly0WjtZB7qsQP7rhZoxnb7BrVoeBOMMrClq/9
         QwWw==
X-Gm-Message-State: AOJu0YyQ0Jxc7vXyJf61RirfkYeP+bBTKAZko3w+ag5NTxCF1TbJQLT0
	GL+cjsFPVimSqgdEpBDQyFBzNMP068dQ7mQBPTkzsBokcErhM9A/xhC81zB/Pw==
X-Gm-Gg: AZuq6aJF96OJWDUuSeYgLxj/CrlNoYDtI8CaY1zWrEUkHsKKZOUKBVCLpbK/8FxtSop
	EOF/b7uaX2mHDmpAXr30CZGBHK3DtZJN9VCJ7XU8rag/nWvdmFKbRi6EJWoTEEBcGhAzyx1y+g8
	sR1AHuGlHxgB51/Ys+XNqVvElN8qPfA+XFMhqO80LZLfJjemOJ7YoblS9XdgNp+11IbXDFNK1CD
	GIOFRi3Mu7it16rGjeQ7ie78v4R9sSTsbjuVLvGWsQ/LW5JdZ9PqbjL+cT7RwjWhl+8zh5HXcbD
	g9VVdaceTOFahnJ4vdkREOZ8QHIkylVhCwXedqu/iJZqmAys/P84TsgSWdokc0Fkadou6HGsSu9
	bgIMNMmO6mz6MUB1zcfRDXFZk4PNSg67v0hmPTR8zKlIux+rRT5oM/lSW3FrWhLzjwjtvYjwb7l
	BjwtHgG2VeLCYd3oqCFaDcsOppgoGjbm/y6oq8rpA2RO7zrYxCfavTsuOhiydjDdwE
X-Received: by 2002:a17:90a:c2cb:b0:352:e796:bb65 with SMTP id 98e67ed59e1d1-353fedae2efmr251228a91.31.1769479751674;
        Mon, 26 Jan 2026 18:09:11 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f613fc36sm693540a91.10.2026.01.26.18.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 18:09:11 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 2/4] net: dsa: yt921x: Refactor VLAN awareness setting
Date: Tue, 27 Jan 2026 10:07:59 +0800
Message-ID: <20260127020847.1482724-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127020847.1482724-1-mmyangfl@gmail.com>
References: <20260127020847.1482724-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253658-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E7B38EE76
X-Rspamd-Action: no action

Create a helper function to centralize the logic for enabling and
disabling VLAN awareness on a port.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index a4b346ddf8dd..880e3b5966f8 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -1768,6 +1768,18 @@ yt921x_dsa_port_mdb_add(struct dsa_switch *ds, int port,
 	return res;
 }
 
+static int
+yt921x_port_set_vlan_aware(struct yt921x_priv *priv, int port, bool vlan_aware)
+{
+	u32 ctrl;
+
+	if (!vlan_aware)
+		ctrl = 0;
+	else
+		ctrl = YT921X_PORT_IGR_TPIDn_CTAG(0);
+	return yt921x_reg_write(priv, YT921X_PORTn_IGR_TPID(port), ctrl);
+}
+
 static int
 yt921x_port_set_pvid(struct yt921x_priv *priv, int port, u16 vid)
 {
@@ -1818,13 +1830,7 @@ yt921x_vlan_filtering(struct yt921x_priv *priv, int port, bool vlan_filtering)
 		return res;
 
 	/* Turn on / off VLAN awareness */
-	mask = YT921X_PORT_IGR_TPIDn_CTAG_M;
-	if (!vlan_filtering)
-		ctrl = 0;
-	else
-		ctrl = YT921X_PORT_IGR_TPIDn_CTAG(0);
-	res = yt921x_reg_update_bits(priv, YT921X_PORTn_IGR_TPID(port),
-				     mask, ctrl);
+	res = yt921x_port_set_vlan_aware(priv, port, vlan_filtering);
 	if (res)
 		return res;
 
@@ -2021,8 +2027,7 @@ static int yt921x_userport_standalone(struct yt921x_priv *priv, int port)
 		return res;
 
 	/* Turn off VLAN awareness */
-	mask = YT921X_PORT_IGR_TPIDn_CTAG_M;
-	res = yt921x_reg_clear_bits(priv, YT921X_PORTn_IGR_TPID(port), mask);
+	res = yt921x_port_set_vlan_aware(priv, port, false);
 	if (res)
 		return res;
 
-- 
2.51.0


