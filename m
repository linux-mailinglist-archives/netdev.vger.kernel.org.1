Return-Path: <netdev+bounces-197013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEF9AD754E
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7EE177339
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4993927A924;
	Thu, 12 Jun 2025 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYTKalhZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2147258CC0
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740944; cv=none; b=sESsNyLUrTpEtifSdB82HDzZog8Io86L9rW61FuG1JUZoQ6YBasX9Vq5K0ou4Py2mTlSwYqmqklKoYvNsXeRlds4vqWe2xqQUwDcsJSLMJSEGD2t05dpizljK9erAiumXErc9+0Im7gQdkmDXU4wYYp4b6Isc3s2m5HslGnO2vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740944; c=relaxed/simple;
	bh=3j6tzJosMYQee88NhxakGZD+aUV6ZBggWTvISxAJKWE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jSQ+NHgqDqs3yfiBC/mmSYFuJlDb1JB+EwBJidKdK8F9cWP2LHApYFUrJ0xW0habzlw05iVBWrbyUMYQoTKY+Vuk0FB/UvSaFj35YR7PMR8U9bplegEAcZ7Hs0976cLoxw0QwtT4JySvXeQlqY1VP0NUOPSAs9JNc7zJfMJHVyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYTKalhZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23602481460so10985405ad.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 08:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749740942; x=1750345742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hpVfTudXWLObLx8Nq6BTcql2Prdttx25JYiLdnKUQ4g=;
        b=cYTKalhZd668INmlr9WrbECa5EtIYTpYGk1BDvcSZ6JClfwGoHH8Bi9uwZKdM+eby4
         XsbHAZVE7bqlh6d2pU8lFNYaoh+o4XXlgumoDSUe1kcXV/4eLniXSKUILtyHCYstaYGJ
         RKtilKf/5Ghv7eJ89HDIljEm+rdp6M4Cs7MZHchJsjnUtvYYgH+JkDX2MeQS2+KVqkJQ
         Bzc2ADPc71IdqT0VcjgSl3x5WNP2/p4bptStzC+2MNRV2lK5bCamzycz542KJWa9jvxz
         qqQpjWdzk8akjgE0RfPxOGDGO0w7dFfBLQSDqbZXViRsBKwfParv3AqSqnkB2sn4qaYy
         gRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749740942; x=1750345742;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hpVfTudXWLObLx8Nq6BTcql2Prdttx25JYiLdnKUQ4g=;
        b=m+qxq1bC+dinsFi/+881gt48LRplnvf7eqa2sXXjPkuPKttdgHMYraYSP7nlrd7qJc
         +ElEoGF9sGQqrII/i3VuIc/9dCwhSfler+Lj2jYGPFhg/d6gTXWFJqlr4KKWYDIgZKxX
         NKxGgKF/uMN4/PZtdP2s1lQd+Z51waBzioK3Ih32JTOzMI0mVNoKyXMkOnSeLpgYy3Ar
         YXlZYohazgZyGU7ydg3+YvhmuGDdQyXJcrQw+EwZsKJF6eEvc77v7vEl0nAOvv+KMCrH
         xxWbBNRK9k2tdf7TuL1/OmIsS7v/UkTee14560u2jkQWdqdTmocKMAq1lrbTqfQkwkln
         Xrew==
X-Gm-Message-State: AOJu0Yy7v9SNTZCYrMBnN39U3gRTHimUA9wFPq2Y20VtnhRQ6dWmvCFe
	eIKeHzpK0hxQIrhvrUo3TeHdiJG0aKEcPYNJnUT3wB37DD7lEBrrDMdP
X-Gm-Gg: ASbGncvo2Zn/SosVGnaCquSZ0OnvP7v1+Bs2xyW0vRT9GHF5tqFrgnN8povSTs+BjkG
	ntnlF6msOhDIRoG8Vdua2SHFzDjXdiaqG3f85iTu3B6FNqcrLXopa3zvkERCcdDDvqWny9FMJMJ
	3J92/1G1T4epAs6uN9KJI29t2E0wyGB6q8Yqia4wBIS2+rArIhw4CEOLQHfQ8WIpXIT4PpywJEO
	CraWshnCefR2BDXL4OYMHoDXEBdaJO4xsB2TC0+eFU3rP9Y/yDKtE3yeAaismMq6Pg9RO88lX4v
	l1lp5x0a+tylKyjhpRy1vVu1x6FgIuN6fTqwCKbAnVnzsoBiA4SJcnR0965Xu1/eFgOFPR6Polp
	2qfKO0NX6UsJdWLo=
X-Google-Smtp-Source: AGHT+IF9n9PctOfZoA0ZUxLyvOjRVwsoJWRxwr1FyAMrkfoYzrG3W0gRO0/95Ajf0rwjItNcu0HGPw==
X-Received: by 2002:a17:902:d591:b0:233:fbb3:c5bc with SMTP id d9443c01a7336-23641abc67emr110887715ad.19.1749740942026;
        Thu, 12 Jun 2025 08:09:02 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.39.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9bf4sm15156285ad.104.2025.06.12.08.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 08:09:01 -0700 (PDT)
Subject: [net-next PATCH v2 6/6] fbnic: Add support for setting/getting pause
 configuration
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org,
 kernel-team@meta.com, edumazet@google.com
Date: Thu, 12 Jun 2025 08:09:00 -0700
Message-ID: 
 <174974094061.3327565.12270122195433259632.stgit@ahduyck-xeon-server.home.arpa>
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



