Return-Path: <netdev+bounces-199261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E27ADF935
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 00:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B7D17AF59
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0525527E05C;
	Wed, 18 Jun 2025 22:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DK6GWnRq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6069727E04A
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 22:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750284486; cv=none; b=Ad5yhJn/AIFVkNhUQ2dAEEqlgCDKavjA1+de7ie0d7hZtelHZ/nsE3cbKviR9KxWlhXxJ2pwFj9TIOTIOHuv3VW+zzg4EcDuK6reM5OfZqDeQm96ah/8GtEgrN32D+lk3C+q0J6DLQqFTUkVgyDUNMtRQgtQ3XMHOXe3QfG6VfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750284486; c=relaxed/simple;
	bh=r/MWRKglJPrUdvlirAeyFpOz7VQ01oUQaniVJ/Pl7CY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcf6Fvf9neDR5hToM+UEM1TN8AgLcmlhZkUf2/9V7FVmnvbARv7JZC1n2kES+Vlm+RSCLnpYB8iSdzVpRwVrjDcVRcrDGOj3saffI/c6nJkNrqkrEDqOp8nD0bSznP9IbS5tHpXzk2YIgaRZTDLrN6HclpG5gZZxQthLceWKjJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DK6GWnRq; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso83515b3a.2
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 15:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750284484; x=1750889284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7WDPOF1v6u06FnqyqD9SX1flvZuTqN6z9TS+jy+wb1M=;
        b=DK6GWnRqxd/zTWyJjOpA/J81xYQLypU6n+P3eJd7ELi70Sv2+aBRDuRXbChUu2XIWz
         z7zm8hRsa7lONsy858znBUXP3w4qJMKQoi53lmBnYf5EyWzKKrPq6ffBGoPhqGNZYVBz
         vMyWiR/OyJCe/7mYtNGDbU+IJcX7g8Si3dsgTcJrXZ1VtnyRSXSY5BD7pRKtVRT2qPdJ
         cZ8kzraDzIwfUICiDgcrUdKDv3DacWD+rmzLHPjLfGzxdAoDBtK1Z1aAOn6JlmcZKQ+Z
         5I5Dp7PIqc64dCTTKsE4uCR6Di6zLgPQU5lGaW8i9YLDxNNmUE+rgxW29CglZ2kTpV5c
         LAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750284484; x=1750889284;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7WDPOF1v6u06FnqyqD9SX1flvZuTqN6z9TS+jy+wb1M=;
        b=VkwB4BdeHznEQq6GQoqLtHqrq5yAPoQDnuloeFY44jXfZyC8vzO/7o51afGSmpc6+T
         z94c0OsvlIMIVBeOsn9qCs0n3N0J4z2rcJVN5r7XVYn0bgsNn4qFyKjarx/sdbzy/FkY
         n8dcoGyU4ArulmnJjJlwCJD8c97xfmbFikvXVq2ij6RcIv93BcAOgV7OxSwoDk+GKjIG
         unfSup/2ll+KeFfAO+LSizYF+JQCSkCxAU4dhvLqhlp9gGvRhkiVgg2dBYK4jmJU/Oh1
         oZAEJnKxESAKiAEZupht/JbMGQlRTu9Eoyzf1b31YufGHVlPeQmHNoswmsUUagpEBFS6
         nm+A==
X-Gm-Message-State: AOJu0Yyf6JX+9G8ABM6vt6ckmqEJDqiJkpXOl7hbgaa5+2qVLqrXx0CS
	wrPWRLj+6SuzA4i+AnUoUkHk6LCYSNovOjGvZpOQZhAAexW7vWEASVNo
X-Gm-Gg: ASbGncuaN00ZgpChCFAgDWtmbuuBZFder8Bah8WwvzTA4L4tZIv30CS2H6auPqJg/ca
	WQjFIU4nSXFwpS4LSOYXuOuzl8soe8+lPByXRH+CJRCj0uKpjZpnD82R4dHhuFFYrLKOKwTSo1e
	/E1IFTRfPr1yRo/XjaZ8pKoDSHtYn2OXVXY/Js9wm4LZt1IRxsv4O++mSdyrfessZKJG2RjeCf3
	+JWhGwi3uOMBwJB6F+RSEKkuumqew/F+OntyQSFbdbttOGgbwAW+MFezRp+9fW68UV6hMIoSnYi
	SDPEgkKPKpTYubp68N7LdN91uO2ab9nLFZiCKp8vKBANueqSbsmtnRxywpbqNDBTu2Z7WOf/jK0
	Enn4IRgIJtJLcdA==
X-Google-Smtp-Source: AGHT+IF/oc/leYdDRi6ayMRQw9pyyIUov/mdJxXjcruqCQGiLqYEWP70IrKw1hABgO3QY3KDapVohA==
X-Received: by 2002:a05:6a00:21c3:b0:742:a334:466a with SMTP id d2e1a72fcca58-7489cf97ddbmr27178844b3a.12.1750284484566;
        Wed, 18 Jun 2025 15:08:04 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.35.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d2897sm12104681b3a.173.2025.06.18.15.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 15:08:03 -0700 (PDT)
Subject: [net-next PATCH v3 7/8] fbnic: Add support for reporting link config
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org,
 kernel-team@meta.com, edumazet@google.com
Date: Wed, 18 Jun 2025 15:08:02 -0700
Message-ID: 
 <175028448275.625704.60592644122010798.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <175028434031.625704.17964815932031774402.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <175028434031.625704.17964815932031774402.stgit@ahduyck-xeon-server.home.arpa>
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
index 4646e80c3462..7cb191155d79 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1683,6 +1683,7 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.get_drvinfo		= fbnic_get_drvinfo,
 	.get_regs_len		= fbnic_get_regs_len,
 	.get_regs		= fbnic_get_regs,
+	.get_link		= ethtool_op_get_link,
 	.get_coalesce		= fbnic_get_coalesce,
 	.set_coalesce		= fbnic_set_coalesce,
 	.get_ringparam		= fbnic_get_ringparam,
@@ -1705,6 +1706,8 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.set_channels		= fbnic_set_channels,
 	.get_ts_info		= fbnic_get_ts_info,
 	.get_ts_stats		= fbnic_get_ts_stats,
+	.get_link_ksettings	= fbnic_phylink_ethtool_ksettings_get,
+	.get_fecparam		= fbnic_phylink_get_fecparam,
 	.get_eth_mac_stats	= fbnic_get_eth_mac_stats,
 	.get_eth_ctrl_stats	= fbnic_get_eth_ctrl_stats,
 	.get_rmon_stats		= fbnic_get_rmon_stats,
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
index a693a9f4d5fd..3a11d2a27de9 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -24,6 +24,67 @@ static phy_interface_t fbnic_phylink_select_interface(u8 aui)
 	return PHY_INTERFACE_MODE_NA;
 }
 
+static void
+fbnic_phylink_get_supported_fec_modes(unsigned long *supported)
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
+		fbnic_phylink_get_supported_fec_modes(supp);
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
+	if (fbn->aui & FBNIC_AUI_MODE_PAM4)
+		fecparam->fec |= ETHTOOL_FEC_AUTO;
+
+	return 0;
+}
+
 static struct fbnic_net *
 fbnic_pcs_to_net(struct phylink_pcs *pcs)
 {



