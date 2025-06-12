Return-Path: <netdev+bounces-197012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAC0AD754F
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D493B149D
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CA027C17F;
	Thu, 12 Jun 2025 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJKtzE22"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AF628A1DC
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740937; cv=none; b=CktH4vaR3mPF2InQ/bAhosU3GYEizPxjysuv28QamR9LgWHRRj8Mh1sQTun9GRe9za7Dlv8/BdM6DMqd56u/QeuBUTySBE1gNdJ8yLEGMzzxMLmY9lVD5Fg2fa0Gyq0h/2r9qkzoVXKAdGkb53YEfFwNu7hiUp2S1dLB0W2xiGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740937; c=relaxed/simple;
	bh=BShgPMP4b9KJMEbu9cOa4fQfUpTl5czUWSCGAmRX9wo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bKbG39jWhFWAONldNjpm5fXin7gWY3aHbYi2fFY4PsmiWXjN08aIc6mdJG5Pnzcr4Dy/ylMqluDtq9kQNJ7X4P0YPZcUJ+0Acg6uPxNcPRdmJ1mDAVcaPoQyMXPMKqe9WaHb4iBhxOR+eL1tItYiKPgkun5RYRhOq39NLSmSYKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJKtzE22; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2350b1b9129so8353655ad.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749740935; x=1750345735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WhzlD+sDd14K9GeCSWV88wxU415odYZU9J3Pf3QH7MM=;
        b=hJKtzE22ITULsJTuxZzk7hJTbqUU34Rc6yHMBjbHPCOe9Hbeaos/nG489Wzqt0QWbS
         bRIQwnV0EkyxzrYh3Ge+PHSyAkMx5R2ytszq0/n8tcuqwadDDvDwzYZOg9HVhKs3hgu+
         jojLhLAtf5TiMX8notMNEM+5M9odK3oUGVFUy9ltyc0MqzqHT9LOK16aJo8t6X4jBZtj
         qWqvqHMHn7VYqyMUToQlUTKrCO76m2i/vquavb0KoHAcB0/eWuK7L7xFSN725kCI3Bed
         P1jYbp+K8wKUsL5lxlBsfdPTaSk/dwEzFvkuriOo9FNa3Bp6bcga+eH00ApFXw273Po4
         NSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749740935; x=1750345735;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WhzlD+sDd14K9GeCSWV88wxU415odYZU9J3Pf3QH7MM=;
        b=ZpyR+YGirIXncy6ZH7yfTRotqWP6mPCRorIdPVYjStrcjORy5gG0rjDALDOzKBA3TC
         8PksobtK2sYemxeFxd0yBLzgMXPAoJiE5+nObDhEIida57VRpeFuqYDionMwY7NIROSO
         23gmamzYFn4GYgZriOqqEUMSB+qJfiKsSTJFS+uvXV1ChKHURuOAT9JitzVHR1W4BXq0
         oblrxbIWXgNVcsz5Q49VrG7Wh4sQFVcuUtbb55GilJm7ROKI99XPtiVv4tdppvbqT+e+
         I2T5/g7szIoDLfgCA5AI/kfBE4omSHsthQudkMLJfQISF3wwRMz2tKK+3m+tPEQQbN97
         XW2Q==
X-Gm-Message-State: AOJu0YzJdBitRQU2Dyv6EC1Y2XakK/J+EXGJksZStW3qGhjvpTiWuf5P
	klryIpe70R69Iuc9z/OFV43NuBHqVHzmVDh+V4AyijkAqG81aHMKeRyU
X-Gm-Gg: ASbGncsaYOjj9JDfLisVTB0tfqlfFSKoGRcaeq6I/cR1h/TgwDamyaZ4Z5LjTxs+3iD
	L9OabnWdAHFEJZGek8afB03GhzSI95DMbXvuvOchXGnDVob8+GXsIvW2tHAlPd6ci4qSDkft6iG
	5y9o7mhmxi/vzkcCWTfTABbdilF0NJ1M5k0yZ5uRW04v8gRwIJ0k7FnQrIwcOT2FKDSZR6cNY2O
	t/vX9NZdo4Idr+gTYC6ZPGKzdPr5AzRXSFwYqk3M+tFXrdIcGWH8T+IewVrK8P1GgqUh6bpcLZw
	JxpWXkt5xokR+8xJiqJbZi32ogaELPN1nGhzLQQK+b8HdZ7/K4sjqsPXaD7HQGQ/sbRPkSrgwgs
	1hxht6IDHcXWUvTg=
X-Google-Smtp-Source: AGHT+IH4MPvquIzyPsFYU7RAq+cy7Dg9xGTlZcsEJorjAJDorFEENb1Sw4slkKYORezJM93N23cSRw==
X-Received: by 2002:a17:902:d58b:b0:234:d292:be8f with SMTP id d9443c01a7336-2364c8b9ed6mr56687395ad.1.1749740935458;
        Thu, 12 Jun 2025 08:08:55 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.39.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1bd9aecsm1567666a91.15.2025.06.12.08.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 08:08:55 -0700 (PDT)
Subject: [net-next PATCH v2 5/6] fbnic: Add support for reporting link config
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org,
 kernel-team@meta.com, edumazet@google.com
Date: Thu, 12 Jun 2025 08:08:53 -0700
Message-ID: 
 <174974093397.3327565.18236629132584929783.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <174974059576.3327565.11541374883434516600.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <174974059576.3327565.11541374883434516600.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

This change adds some basic support for reporting the current link config
to the user via ethtool. Currently the main components reported are the
carrier status, link speed, and FEC.

For now we are handling the FEC directly as phylink doesn't have support
for it. The plan is to work on incorporating FEC support into phylink and
eventually adding the ability for us to set the FEC configuration through
phylink itself.

In addition as we don't yet have SFP or PHY support the listed modes
supported are including ones not supported by the media we are attached to.
That will hopefully be addressed once we can get the QSFP modules
supported.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c |    3 +
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h  |    4 ++
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c |   61 +++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 5c7556c8c4c5..1b70e63e7ada 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1620,6 +1620,7 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.get_drvinfo		= fbnic_get_drvinfo,
 	.get_regs_len		= fbnic_get_regs_len,
 	.get_regs		= fbnic_get_regs,
+	.get_link		= ethtool_op_get_link,
 	.get_coalesce		= fbnic_get_coalesce,
 	.set_coalesce		= fbnic_set_coalesce,
 	.get_ringparam		= fbnic_get_ringparam,
@@ -1640,6 +1641,8 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.set_channels		= fbnic_set_channels,
 	.get_ts_info		= fbnic_get_ts_info,
 	.get_ts_stats		= fbnic_get_ts_stats,
+	.get_link_ksettings	= fbnic_phylink_ethtool_ksettings_get,
+	.get_fecparam		= fbnic_phylink_get_fecparam,
 	.get_eth_mac_stats	= fbnic_get_eth_mac_stats,
 };
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index c30c060b72e0..943a52c77ed3 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -92,5 +92,9 @@ void fbnic_time_stop(struct fbnic_net *fbn);
 void __fbnic_set_rx_mode(struct net_device *netdev);
 void fbnic_clear_rx_mode(struct net_device *netdev);
 
+int fbnic_phylink_ethtool_ksettings_get(struct net_device *netdev,
+					struct ethtool_link_ksettings *cmd);
+int fbnic_phylink_get_fecparam(struct net_device *netdev,
+			       struct ethtool_fecparam *fecparam);
 int fbnic_phylink_init(struct net_device *netdev);
 #endif /* _FBNIC_NETDEV_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
index a693a9f4d5fd..be6e8db328b3 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -24,6 +24,67 @@ static phy_interface_t fbnic_phylink_select_interface(u8 aui)
 	return PHY_INTERFACE_MODE_NA;
 }
 
+static void
+fbnic_phylink_set_supported_fec_modes(unsigned long *supported)
+{
+	/* The NIC can support up to 8 possible combinations.
+	 * Either 50G-CR, or 100G-CR2
+	 *   This is with RS FEC mode only
+	 * Either 25G-CR, or 50G-CR2
+	 *   This is with No FEC, RS, or Base-R
+	 */
+	if (phylink_test(supported, 100000baseCR2_Full) ||
+	    phylink_test(supported, 50000baseCR_Full))
+		phylink_set(supported, FEC_RS);
+	if (phylink_test(supported, 50000baseCR2_Full) ||
+	    phylink_test(supported, 25000baseCR_Full)) {
+		phylink_set(supported, FEC_BASER);
+		phylink_set(supported, FEC_NONE);
+		phylink_set(supported, FEC_RS);
+	}
+}
+
+int fbnic_phylink_ethtool_ksettings_get(struct net_device *netdev,
+					struct ethtool_link_ksettings *cmd)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	int err;
+
+	err = phylink_ethtool_ksettings_get(fbn->phylink, cmd);
+	if (!err) {
+		unsigned long *supp = cmd->link_modes.supported;
+
+		cmd->base.port = PORT_DA;
+		cmd->lanes = (fbn->aui & FBNIC_AUI_MODE_R2) ? 2 : 1;
+
+		fbnic_phylink_set_supported_fec_modes(supp);
+	}
+
+	return err;
+}
+
+int fbnic_phylink_get_fecparam(struct net_device *netdev,
+			       struct ethtool_fecparam *fecparam)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	if (fbn->fec & FBNIC_FEC_RS) {
+		fecparam->active_fec = ETHTOOL_FEC_RS;
+		fecparam->fec = ETHTOOL_FEC_RS;
+	} else if (fbn->fec & FBNIC_FEC_BASER) {
+		fecparam->active_fec = ETHTOOL_FEC_BASER;
+		fecparam->fec = ETHTOOL_FEC_BASER;
+	} else {
+		fecparam->active_fec = ETHTOOL_FEC_OFF;
+		fecparam->fec = ETHTOOL_FEC_OFF;
+	}
+
+	if (fbn->fec & FBNIC_FEC_AUTO || (fbn->aui & FBNIC_AUI_MODE_PAM4))
+		fecparam->fec |= ETHTOOL_FEC_AUTO;
+
+	return 0;
+}
+
 static struct fbnic_net *
 fbnic_pcs_to_net(struct phylink_pcs *pcs)
 {



