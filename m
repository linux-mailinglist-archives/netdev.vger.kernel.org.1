Return-Path: <netdev+bounces-235199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B42A5C2D5A2
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 18:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED842189CF3B
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 17:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2393191C0;
	Mon,  3 Nov 2025 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjF2rKN7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7059031E0EC
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 17:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189258; cv=none; b=YzWiBTY4qqslZmIa6/wacyE5O45+tt0jMclqX2WNh06NtexSSGbVWHEbQgRa7W1ka91Y2OH93oYmy1YNd5AEt/VVhvgoflEs75PxOssZ4MCAicqaUdtu5WRdouN8CR65eYwnM/VRU2jNtRMhZExCoi+3L2hPCr/5KZyfBgEeRdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189258; c=relaxed/simple;
	bh=6fru2cOSTwONogCvVpTSmxig3C/5JsZWzSD5xPUc9K0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XYWWlAPonQlx3MpoyTuwr7Rl4xVlTS3KmwTvsHXVebAprIJ+MKPDQtodNI0WFzlIHnNgTl3a+Gn7xHFISUb7VX2PF17eFTAq5xt1oRtM95P4gGL9irZouyh0f23Zdlf/phEdGbvDi+0DUXYSVNj9VnCOQQf0FNai5az7ILIvuZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjF2rKN7; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27d3540a43fso45369535ad.3
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 09:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762189256; x=1762794056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BShhtXHCNUHcu5+CiCUxPfXKjZZExdznr7pMiH2EDSU=;
        b=gjF2rKN7bVD0KJJCuSQJZjkKZfJ3xkiudtxN2yzOXNHfY8851V+xY2VVh1GR0UuwN2
         9FplRsZos0XjySdjSYtxyEhGCgW7HvRgmTbkLscISswLPgWmKO+5ZFljfeAd4nQk0jMp
         r+wwFz4oMUTCXQ7JPtDgV0sLo/NirxerFhvacaKblk3odQ1TgDFFmj71ju8j38xPQQoJ
         vn+m3ueatFUcRKgWZk5jHi8kFATcdhyrdGqYiEH+sJuem6D1WUAFM9BN7iMHqX+QbOJO
         0nt4uC7JORNUXJpP1QsQqW7uzHQkEJqkfiVKmzNdUiOHi6wgXsKHJvECz72Ffxe+qkdk
         8r7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762189256; x=1762794056;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BShhtXHCNUHcu5+CiCUxPfXKjZZExdznr7pMiH2EDSU=;
        b=W8HaIdA3BkKiMFcfu/jU0CQmoNI+tqQaG5ud5XC+IYX0T1MBdiPhfOL5kDLas7NEYk
         5O+fanFeX0Wqm8CQX17C2thwy7fctzSNPF24/8VnNsTrtMqu4lQm0kO6Bmme+1Y0Gpf2
         0N1XV3LI+nFhQIh6UnzJ8fnZYaqicEhEXFjiY4KkpOJkE0P4XbsFwureQYgypzj0dhNm
         nMOQHZIuF1sBJM8g95b563fLdJ7t7faxf6xdbiRB2MyAgFGea70m92eyAwT9NCjT1z2n
         jcTs+FqGW72xH/MzEvTsu1+EjlnHBH3r5Ug+l755aaPjbnWlW0M5NSnoWvpS3qPFqrnb
         jc4w==
X-Gm-Message-State: AOJu0YxqSeGDjQw5EYxaglDImse85hodJY3kAdRtja469sKJ2mGDDG6F
	ft0l/wW0fcv9DGOIgDXSsv309aQLyMJZNIRGWTTBpJ6qPs+2fQZRBbnORn4jjA==
X-Gm-Gg: ASbGnctwJaflUyixdkJu52baAI3e328KuGbZZkX3/daX5uIjxu6cJ8IZHjUfVRnDbFG
	QOuYiniHRlsR2xDVCkMs3VWlQM5lBm2vLik+mmQo07ng/MVE+JKq6U/QnymP4aaxQPaUtVeHDyS
	EIcvN18OljSDuyb4P65JuO4n/HM+CmqOnrZPKk/3rFiMSiTBev+vNEsS6WhREJwi03boMtlAckx
	GLf9lSwAmLz2pRhvemh5F0kDaVV/TY9nn140TfRrP3QipDXwCyWVou7SXNw3qrJZOnNdaRC5PQT
	uDtYFJ68RvK9+mUaiS1swD7uexVeiveb4PzZ0pGVmx5rgGeDrOBlwezyJ4tIhMxK59/WtfdiGZe
	7um57bRlJzJaB4PDEwo2hdIf9UAMfBapXxxii8ZzjSu2sx+rCZWbAc9N/0qWHg1V0jAoZpx/xhT
	SmUNh80pcHPeLmI0SzRC+Sr/99nbuEp/a5nFKZFiiUb+Gp
X-Google-Smtp-Source: AGHT+IHFPnA3XVaef3XP2mZ8bau4v1IkC6fEJhsD+WO2oszqoRf6FlUHb+DstL4DobbQHgQm4zr3Eg==
X-Received: by 2002:a17:902:d2c6:b0:267:99bf:6724 with SMTP id d9443c01a7336-2951a55d218mr168631155ad.31.1762189255917;
        Mon, 03 Nov 2025 09:00:55 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952699cd48sm128431995ad.83.2025.11.03.09.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 09:00:55 -0800 (PST)
Subject: [net-next PATCH v2 08/11] fbnic: Cleanup handling for link down event
 statistics
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Mon, 03 Nov 2025 09:00:54 -0800
Message-ID: 
 <176218925451.2759873.6130399808139758934.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176218882404.2759873.8174527156326754449.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176218882404.2759873.8174527156326754449.stgit@ahduyck-xeon-server.home.arpa>
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

The code for handling link down event tracking wasn't working in the
existing code. Specifically we should be tracking unexpected link down
events, not expected ones.

To do this tracking we can use the pmd_state variable and track cases where
we transition from send_data to initialize in the interrupt. These should
be the cases where we would be seeing unexpected link down events.

In addition in order for the stat to have any value we have to display it
so this change adds logic to display it as a part of the ethtool stats.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c |    9 +++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c     |   10 +++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c  |    2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c |    2 --
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 95fac020eb93..693ebdf38705 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1863,6 +1863,14 @@ fbnic_get_rmon_stats(struct net_device *netdev,
 	*ranges = fbnic_rmon_ranges;
 }
 
+static void fbnic_get_link_ext_stats(struct net_device *netdev,
+				     struct ethtool_link_ext_stats *stats)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	stats->link_down_events = fbn->link_down_events;
+}
+
 static const struct ethtool_ops fbnic_ethtool_ops = {
 	.cap_link_lanes_supported	= true,
 	.supported_coalesce_params	= ETHTOOL_COALESCE_USECS |
@@ -1874,6 +1882,7 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.get_regs_len			= fbnic_get_regs_len,
 	.get_regs			= fbnic_get_regs,
 	.get_link			= ethtool_op_get_link,
+	.get_link_ext_stats		= fbnic_get_link_ext_stats,
 	.get_coalesce			= fbnic_get_coalesce,
 	.set_coalesce			= fbnic_set_coalesce,
 	.get_ringparam			= fbnic_get_ringparam,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
index cd874dde41a2..45af6c1331fb 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
@@ -122,6 +122,7 @@ static irqreturn_t fbnic_mac_msix_intr(int __always_unused irq, void *data)
 {
 	struct fbnic_dev *fbd = data;
 	struct fbnic_net *fbn;
+	u64 link_down_events;
 
 	if (fbd->mac->get_link_event(fbd) == FBNIC_LINK_EVENT_NONE) {
 		fbnic_wr32(fbd, FBNIC_INTR_MASK_CLEAR(0),
@@ -130,10 +131,17 @@ static irqreturn_t fbnic_mac_msix_intr(int __always_unused irq, void *data)
 	}
 
 	fbn = netdev_priv(fbd->netdev);
+	link_down_events = fbn->link_down_events;
+
+	/* If the link is up this would be a loss event */
+	if (fbd->pmd_state == FBNIC_PMD_SEND_DATA)
+		link_down_events++;
 
 	/* Record link down events */
-	if (!fbd->mac->get_link(fbd, fbn->aui, fbn->fec))
+	if (!fbd->mac->get_link(fbd, fbn->aui, fbn->fec)) {
+		fbn->link_down_events = link_down_events;
 		phylink_mac_change(fbn->phylink, false);
+	}
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 2d5ae89b4a15..65318a5b466e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -86,10 +86,10 @@ static int fbnic_stop(struct net_device *netdev)
 {
 	struct fbnic_net *fbn = netdev_priv(netdev);
 
+	fbnic_mac_free_irq(fbn->fbd);
 	phylink_suspend(fbn->phylink, fbnic_bmc_present(fbn->fbd));
 
 	fbnic_down(fbn);
-	fbnic_mac_free_irq(fbn->fbd);
 
 	fbnic_time_stop(fbn);
 	fbnic_fw_xmit_ownership_msg(fbn->fbd, false);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
index 66c4f8b3a917..e10fc08f22f2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -203,8 +203,6 @@ fbnic_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
 	struct fbnic_dev *fbd = fbn->fbd;
 
 	fbd->mac->link_down(fbd);
-
-	fbn->link_down_events++;
 }
 
 static void



