Return-Path: <netdev+bounces-196154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3206FAD3BBD
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 16:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B79C93A8FC4
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6990A21770B;
	Tue, 10 Jun 2025 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lO2SQOkD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB16820E034
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567105; cv=none; b=gLmfQxlCfUrB4ulxnXO7d7OfZiDu9rS/A5FbNp7VBEKS9mqIl3bsJUlQk8mOMKdkquge+LkF0oTxSoNBXRETBwDt8TqTMu+TFXjSLnKAJ3wJpr+Hv1j1LzNa3GAJHgH2t2MzA7bV4U1LKyBZ0Wtr29Ap0M+Z6dbUiaoNWPtl3jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567105; c=relaxed/simple;
	bh=BShgPMP4b9KJMEbu9cOa4fQfUpTl5czUWSCGAmRX9wo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CZ+1+gNFlUSKqCdqdXPow13GLAeVilE9XgupMtqwQSau/sbGzXg82bt6r9bmRTG6DwmgmTl52cr8ScQ6cgbTsRDVPHcu6IBW/qNkJjdN8uA2YrgISSPOPKjYoqEHu1rZ2w+tH9foC2+g+pkJWKRkDqZyz+h+qdOCFl8LR7GTv0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lO2SQOkD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-236377f00a1so8932915ad.3
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 07:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749567103; x=1750171903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WhzlD+sDd14K9GeCSWV88wxU415odYZU9J3Pf3QH7MM=;
        b=lO2SQOkD8GRENQlUsZtdQGUgD9/svRbj3PMBPjIQyHvzhdjssZBuAmjuHgN7ZnLJih
         MCk/zNa0Bpwuo0kAY34QSQMwwswNRhR17HlK1nL5EUKM7WmBuKimJkzM/WSr7TCrZ8RF
         2PUffuvxgYQQJTeOvPhE7fgWYPWAY/wI0H25pocj8Zmvjjp34jpB6jdeQv9HKcbLoIBc
         DBk9JxeJ815Fk1l83ApVKSiMyVvm7nHuXu9eaAgzgwN6beCR7VGSTCvtvznvbltT0iAg
         GHtflKL61PKkqxJm/XoymhXfGBfLp8/B5ubsCne4VLD5s+MY2n0ssc1T0BZZVYnk6JJr
         uEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749567103; x=1750171903;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WhzlD+sDd14K9GeCSWV88wxU415odYZU9J3Pf3QH7MM=;
        b=kOCiLdbzjPpC+yKmcu/ZGhEgMRJqbPa2chccAJgIGsJwvU61Sn4FJm98ais3nklGvO
         lMXNV3sWP1d0UAEr+7dnSS8iJuDYTeuowlCH8xIwW9GfZe6XvB8bZ8ibX+k1NJrprNww
         rM9b6/R4xVOCVcMdV/OJwaKvWIDGFt8oiWjNJyJewk8fSu7iM5csBBcAVYwXIbedRYGJ
         oezviwWRyorGi4Figk4K+pDOq9oYQBt1ZfO4WmX/26N0PlIRe3V0PshBBHpqsItL8dFR
         2Jq8KVBDfzgtu1K1fNSkqH+jOl17lWnIC+hUCAktRck+wkN1U2ZIqPzs3LoE9Cw9PYoK
         wkIA==
X-Gm-Message-State: AOJu0Yx1uBOOo8jxQA0fj21jYmbqkFRG9a1GOQDLyZlBXNrgRYT8ucQM
	gjuolGbeQCL0+/LP6lHRQRjAIBY7FVIXa20uPLSlgBBPbpCuY9NPDNnNFVAu5A==
X-Gm-Gg: ASbGncuTZJWHdJXZKatj/iRBu4hmA/m6fq/5jek3/Y6czzz0yjvItxWgV2XRy3hIDKt
	mHSZTSaaUao77Bwxm4Q90AygE1rpfT+lOTFQzxBHYbnuXONAvpucRFpe6x5toVjgxMAMin8KEIt
	SDzMN2LjdhpXYB19dvBW4zJKZnY+C5dOfI54Sbfi1XM2Dl45KSR9Y2CC7FPfjA4RTUYGNbcLFW2
	nHlhii62YpTtpW/JnWmYMSxaCRyN1CVwTwFTZdmazHhF95hdE5bEkQ9/4d+e4vOxaNOnw4dNUpo
	auDGINCsKWR+hHv7+RTP9uIsEmEVpgM7qHWqRulmpetauZdDg3J0k9Ir1LffMW2SihvgGl3VVMS
	SNQFyKEPe52ivzg==
X-Google-Smtp-Source: AGHT+IGMJHnKam2iXqJN2fTNiNbzTXVseBn2vtVdXHrUz2IwwudgLQvJILKX3l/tyfNthsaPSMsX0g==
X-Received: by 2002:a17:902:da85:b0:234:d292:be7f with SMTP id d9443c01a7336-23640cce194mr2311505ad.31.1749567102536;
        Tue, 10 Jun 2025 07:51:42 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.33.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236034065edsm71481825ad.185.2025.06.10.07.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 07:51:42 -0700 (PDT)
Subject: [net-next PATCH 5/6] fbnic: Add support for reporting link config
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, andrew@lunn.ch,
 davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org
Date: Tue, 10 Jun 2025 07:51:41 -0700
Message-ID: 
 <174956710120.2686723.12011391778616232783.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <174956639588.2686723.10994827055234129182.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <174956639588.2686723.10994827055234129182.stgit@ahduyck-xeon-server.home.arpa>
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



