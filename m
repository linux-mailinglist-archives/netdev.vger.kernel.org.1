Return-Path: <netdev+bounces-199262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B1AADF936
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 00:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF6D4A2951
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9DC27E062;
	Wed, 18 Jun 2025 22:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HF/41mzu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1931E27E05C
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 22:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750284494; cv=none; b=gLzgPG8CmWTlcLh8hr1sZL/+Jvg8cGxf0FI6FmkRBqRk0J4iifYY/+Um26qSTLd80449L3q038G/DDtVq5+oIBvRBHn5VxVS7YQpvM9jxRTFPZIVMVkW3kajEhKNE6Lau3+TVhTFnk3eHR4AAFiSKeZnv/dj74fG/7zgx8oZSgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750284494; c=relaxed/simple;
	bh=8rSZBM+2G3JxDo0bDT95Mi9KPzEaeGKNAtynlSjiwW0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pX78aXV9zGnMUyYRx2LEC3iDy/xYBP7XsbQuT3JOVTMUgZ+CvCYWjvcNScMXVGfeETFhuXd/6xvzighb/v9EusWE0e40hFyi0D5MNzSFOONsu1/YR7jsvDb2lZdrwLOWDL3ueYCCZ8lyJnSVQVWEPMbJ8jexYpHoSeJKtJVnJNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HF/41mzu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235a3dd4f0dso1200905ad.0
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 15:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750284491; x=1750889291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9zLeKsLC54GrWgQTvH5KRC9Xx2XhH1v9eQbOgi1AN6g=;
        b=HF/41mzuOsyz6opjYU98a+pHpWmknF7fq9rLIV0UIk1mcmxGRWju5qHsrXR4Y4mIY6
         qItd+4yd5cpPu3jQ+8kMZxj8KHVbMdARsOqFhlFjLG4RMHP6pJdcDxg6jtxIdvjziLQN
         lV6swcflGauGrigH1kJcOZLGppVsG6M95QgyNdsTpAI65MXvtUIcXNPT8jqEoMEcU5u0
         S2aLenvcKT5wE1YFPXshY6/uUglq73cQFOhpoENrDrHM4MlVZ3X5h/UhSIxMzeCblvpA
         bWG4kk02dHVKNySxXAl7/1P+oK7l2eOa2mZgoaO40Oahas4McrMGugaoTadB1ARryrSV
         OzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750284491; x=1750889291;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9zLeKsLC54GrWgQTvH5KRC9Xx2XhH1v9eQbOgi1AN6g=;
        b=Z1nO38q9c80bnoWeyk0d4KnP0u/0haRqwjzKvfe0Yd9Nae05aIDMmqqHycFhP2JgKP
         64zmsTzV5TGmJ3gNhLz0aduO8Dlrs/ZxGJUzK/yb6A81G2NkOZvTn/PH8I9KoIQA7oBr
         ROyYG/NgQ41Yebai898WNeZzhSnDeqNSYB1NtWy3cAzOnDyQEdaGtxw5e3qQ9NNPKsX5
         pzaiCKX1kbb3AbPQJzUSQWNlqozespM/uOWZqjVjmv+coLU6uHy+Vr4uY7GjoWjNKmPf
         xG69PL0lGrBJv6Tv5lldZWBDX+51zdRev5/Ecp2XNMPZnSgPDnS0Ok9dh9OanyCAXXDW
         KqKg==
X-Gm-Message-State: AOJu0Yy7StwM5hRBaarYv7pi2jXdMP2iMQKykaA12DHeSsE8NgOld4Oe
	HbektYVnz37Sz8uKdiuqMstGjgf4BolUvjUQZdd6y5W8Gp+JvL+JFe37
X-Gm-Gg: ASbGncuCP3fo1P5pACoeNzpxwm7/aUbm+3EkrQqwOt+LMNFMXGkA5nYrCt5r+e8Vf3L
	SdOu1+SnUMlgUqB9YU9IIJxQuFYJuKKDNPrxNEnAuS8DauLxgmRi/89eItPXp3IScKK7fjc2Jjl
	4IWnE5Rn5OsEQ5VTmhwRVa6++v91CkLG7JbyMgE7ZteQxf+IfTwYFzqrzV7H7nvAILsxLyHC4Oq
	JLRiNwEtU5p/uaRx5yo4UAhSFSvIgxV4FhDEQ7iwLWN48hRSRsa5IaMmGSvKZK9IwXzW/lXDHcM
	eYPY8iLGWGykOnTCMZ0YKPPyZ9MkXJgk7PSrFwxREKh5ukIRdYqHkjAHeam/6EzRQCWP7YhDVdZ
	39zcpmbOXiqizaQ==
X-Google-Smtp-Source: AGHT+IGY2v3GWBubFJaujt9AdKDSFgg//CRJ9SOg3x0axm0ajUkoJPrviC8NlnYJTTBOTdCgQsu4Cg==
X-Received: by 2002:a17:903:1b64:b0:226:38ff:1d6a with SMTP id d9443c01a7336-2366afbd7ffmr241061865ad.7.1750284491326;
        Wed, 18 Jun 2025 15:08:11 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.35.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88eb54sm105901275ad.2.2025.06.18.15.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 15:08:10 -0700 (PDT)
Subject: [net-next PATCH v3 8/8] fbnic: Add support for setting/getting pause
 configuration
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org,
 kernel-team@meta.com, edumazet@google.com
Date: Wed, 18 Jun 2025 15:08:09 -0700
Message-ID: 
 <175028448974.625704.14427543910503058114.stgit@ahduyck-xeon-server.home.arpa>
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

Phylink already handles most of the pieces necessary for configuring
autonegotation. With that being the case we can add support for
getting/setting pause now by just passing through the ethtool call to the
phylink code.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c |    2 ++
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h  |    4 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c |   16 ++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 7cb191155d79..7fe9983d3c0e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1688,6 +1688,8 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
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
index 3a11d2a27de9..7ce3fdd25282 100644
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
 fbnic_phylink_get_supported_fec_modes(unsigned long *supported)
 {



