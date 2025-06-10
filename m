Return-Path: <netdev+bounces-196155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2207BAD3BC2
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 16:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC6DA3A9D1E
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C3120DD6B;
	Tue, 10 Jun 2025 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXJ/9ujQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABDE20C463
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567111; cv=none; b=Mk7dyT+Bs9y9pJI8JZdzYfiv8TTo2U89QxjBxXZKNoxijpX2z5BgRLkkIWYgevPeoW3KtW619tInQHmyZjFqua5j0Sbcxhyyz3ndAwwCHF46lsPayXqgxbq6CkuvFn2ZMrCUjYBLSVM/ZCUlttJLYv5QYiqd7blki7aFhW5JXT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567111; c=relaxed/simple;
	bh=3j6tzJosMYQee88NhxakGZD+aUV6ZBggWTvISxAJKWE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C15c+mYtiBz0AVTbWdJXqz6kMy564hpFXIX/Z3cfAYE8Q3Nx2smOwgPRzMZTIe+tCCG8aCziPAQr2oLAG414HsxdV51qXwjTEK2m63sQ8Agp+nVAmGO4UCtgd1pppfr97/NarhKgoH/pAR9VD7WW2NwkuHzvc43oNXkMk4c1EhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXJ/9ujQ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22c33677183so45153515ad.2
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 07:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749567109; x=1750171909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hpVfTudXWLObLx8Nq6BTcql2Prdttx25JYiLdnKUQ4g=;
        b=kXJ/9ujQv6xKp0P+D4V6Aa+G/woWDkPAXM3LbfV8xMeFDHtYL3M7J3xFlIB/pLu6/e
         VaMIjVTTL3zyPBCTWwMu9zsKdwVh+EvUyLI067y29y3Vzc4S2MDY/YxLhT2wZt4+oumf
         QK6nfprneC8wou73eJWw3frmWGjXjmSw0WtEbt7lDQ0DTjqQYiU21WgmmLigIF0jTLdj
         N8/NgsuynXDgATt21WPXB+iLSnXAMWQltUD1A7f/TGzpg+aMOJ/c28UOgFcuoWc54OZX
         /Dc/giwjEazWa3UKc/pLkaL1o4wrD2vCcMBBvjFizMa+zE9uqBR/TZq5GMznhg3L2kA+
         Dj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749567109; x=1750171909;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hpVfTudXWLObLx8Nq6BTcql2Prdttx25JYiLdnKUQ4g=;
        b=cJYvChzwGIlwi3vWReJeYNlrHpPbOMDVoT43Njr/AHg9IToohT1MHyR+JtLAYPL3YF
         Td8Wkc+EXyaVBDjVhIyJEiVlQgFfKqOfAn+25XVc4wBIVYq6UXztiVkBoAVQuIdOgpcj
         WisubWN1CtqDlcQuEvf5JC1dzfUndG2WD1PytTi1OZK/LPXeZZC/CdlkmLouLzAydiEQ
         BWa/WuX9Zc+Wk0kOzujU47JSItbXlzGSmH9E5vGEpwGFmPNLMiD2mZf6f+JMcb8G/Xx4
         t3sZbwJDY+4v9qN3vkVDln58iyoOfIHziFf5D9jaA6ot9Png5On660M6Bo5vw9G0abGa
         JeVg==
X-Gm-Message-State: AOJu0YxZKZh46dz5OzOWAVxj9+YXTZLjolSf3H9mIIv5au5uUs2dGbXJ
	/9IBC27O6pNhBsgkn0/0ZmuQLruLsOVIiqPeFWIBZz0WxXgpWIpb7zpFsQ8h6A==
X-Gm-Gg: ASbGnctodDitdZvEZR3PXE0UAoOVgTlIss3aikmkeQUr9lXCDlVoooK5xflnUgldOMF
	H4O54PjV5g3h4oitm+vqoLnkah5AjuyzPEHmSXJegu4NBUAKKY0905iJiVUDi76uqRHb7VjY3wH
	JhN+hdhxdrefXWq4yCqSVtiKUWuAT2ixgChJL2ukOhsJMUQWuxHhg1p+0HGU3f/zeTa/xLPA8il
	vtVu3BSagJNFjBhzNh00tcIB0r6RPhdnD6eKBxvPpSFomMrpHOH/5kI9v/O0vy45apSqCJosqcC
	c6WOSXL0bQ0Sjst8DET5v7q8/TYcH+bSrdl5hh6V4FF+cR01JMOyGPZYA7FuhUM499/wZ8L8CZ8
	wQhFs/5ZNr9frbg==
X-Google-Smtp-Source: AGHT+IHkL265vu5BudkTFbDYxA6i+TUFZgzWhGmAW5tR79LEsQwEMS7d5XrIqXy0sHUHL+dEvftsxg==
X-Received: by 2002:a17:90b:4b86:b0:313:31ca:a74 with SMTP id 98e67ed59e1d1-3134730a07bmr27293286a91.16.1749567109054;
        Tue, 10 Jun 2025 07:51:49 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.33.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032ff2f7sm72222435ad.92.2025.06.10.07.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 07:51:48 -0700 (PDT)
Subject: [net-next PATCH 6/6] fbnic: Add support for setting/getting pause
 configuration
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, andrew@lunn.ch,
 davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org
Date: Tue, 10 Jun 2025 07:51:47 -0700
Message-ID: 
 <174956710774.2686723.17733858231886607526.stgit@ahduyck-xeon-server.home.arpa>
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

Phylink already handles most of the pieces necessary for configuring
autonegotation. With that being the case we can add support for
getting/setting pause now by just passing through the ethtool call to the
phylink code.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c |    2 ++
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h  |    4 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c |   16 ++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 1b70e63e7ada..12e6f2483419 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1625,6 +1625,8 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.set_coalesce		= fbnic_set_coalesce,
 	.get_ringparam		= fbnic_get_ringparam,
 	.set_ringparam		= fbnic_set_ringparam,
+	.get_pauseparam		= fbnic_phylink_get_pauseparam,
+	.set_pauseparam		= fbnic_phylink_set_pauseparam,
 	.get_strings		= fbnic_get_strings,
 	.get_ethtool_stats	= fbnic_get_ethtool_stats,
 	.get_sset_count		= fbnic_get_sset_count,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index 943a52c77ed3..a3dc85d3838b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -92,6 +92,10 @@ void fbnic_time_stop(struct fbnic_net *fbn);
 void __fbnic_set_rx_mode(struct net_device *netdev);
 void fbnic_clear_rx_mode(struct net_device *netdev);
 
+void fbnic_phylink_get_pauseparam(struct net_device *netdev,
+				  struct ethtool_pauseparam *pause);
+int fbnic_phylink_set_pauseparam(struct net_device *netdev,
+				 struct ethtool_pauseparam *pause);
 int fbnic_phylink_ethtool_ksettings_get(struct net_device *netdev,
 					struct ethtool_link_ksettings *cmd);
 int fbnic_phylink_get_fecparam(struct net_device *netdev,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
index be6e8db328b3..9da6d5e2ea40 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -24,6 +24,22 @@ static phy_interface_t fbnic_phylink_select_interface(u8 aui)
 	return PHY_INTERFACE_MODE_NA;
 }
 
+void fbnic_phylink_get_pauseparam(struct net_device *netdev,
+				  struct ethtool_pauseparam *pause)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	phylink_ethtool_get_pauseparam(fbn->phylink, pause);
+}
+
+int fbnic_phylink_set_pauseparam(struct net_device *netdev,
+				 struct ethtool_pauseparam *pause)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	return phylink_ethtool_set_pauseparam(fbn->phylink, pause);
+}
+
 static void
 fbnic_phylink_set_supported_fec_modes(unsigned long *supported)
 {



