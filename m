Return-Path: <netdev+bounces-232686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7EFC0817F
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 22:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A2E4012FC
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A58D2F7AA0;
	Fri, 24 Oct 2025 20:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3kobo6X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DE12F7446
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338479; cv=none; b=njoAK91+iM/rvzQ8jw17GSJhoq+kVjqTjjF+wl5M84STDFxfh9vbQCXd0OhE9meeKWILjfVRCKrDYQwdjajDmZqRlFgpJ15fXMBcu09u/P797NpSjIzap1WhRSsDm6PFUIKW6tws/yJ4b2OGukxvD4t/LFedKubgQYNaYk7ojBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338479; c=relaxed/simple;
	bh=X0w1cIMAZcQi7ltO7JfUlYHFNDfIDT3NGYK3uHW9CNk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMgdO6L1K9JJzibjFP2imH1yE6RfyiLOVCXQEtCqoUs9kHo2mc2YO6dGzbmXumuv/Vux3jLb1z9DS+ZG9rMi6w0ddeOxnXurWvhGMyFmYJuoARdWTW5gewsY/ol1fCJCSF69+Q/2BK0A1ZmwyT1Nblvxvxioagduxhem2/SFN+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3kobo6X; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a265a02477so1964010b3a.2
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 13:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761338476; x=1761943276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qz19u9VLO4ecSOtohWSRaai9nAzhjzqQlmz6TRFbV6U=;
        b=K3kobo6XIEDQCiAzyP+M0YMeDEwirU7SYepKE69vr2rj2RA0OsMjax0RmOF9mKC7zu
         ie31NNmH/Deb3lYs1TSYbF5LYONYT71n9hCIWVeoNW3fwBQ0hUfyB3/uqZW++Y/sML8A
         WzIszEm48nGPzfA/ZXv0DyN0f6FBf5c+bQZ23dBhmssq598UxLz1UzzX2tBZEyHNpyeY
         Az57PPLMxwZ/EYIMqP2EMOvxEVYgdQS20ImSgIzXzbWX7HEyF0g2iOkbL5O/kMc9XFeT
         6bq/d8TTw90J/ApVhftq/oGiQDvs+Gc0qS3doKeD6RAIECBOcryHB3fBxewoty2pAOwO
         6x9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761338476; x=1761943276;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qz19u9VLO4ecSOtohWSRaai9nAzhjzqQlmz6TRFbV6U=;
        b=kX7fVMks0ktqP22f/6ME3WR4YSbyj90m0K/7rJSrVY1v2kmXGmKojQDs94TbQu0it6
         XGodv+Ak7fg9H06mnvpYwhkfQyyJbaM6TwuY80BtwuWPS9jiOf/R856hmEvFlzIldfv7
         q3RjafK0qzuVUx30x0ni/jEXNmJXO0RSEKd1+LDdunLES4TQF5lL4FJf10YcaZ/QUtlG
         X5U1467ADvyeta6ysY54AukznE66vjn19vGxrh5r77GrBps2Zvb+2OuKAJx8KTnzHXGH
         6YN5SbPjB/BETfcVpqv3+qgntzF4jyP/DG65bhDpEB0STeFITjUymwJhKtexV5CreN0u
         6U4g==
X-Gm-Message-State: AOJu0YwU7J4VnKi5jpl/1KxXC1HBS2g/muSDfYMDFbtQ92huYF7RWUum
	pmNofvTW80UkfWt4QVXw1pD0ByVJbTMHI5DSZHbwdU4lodh4iu5jH1M6
X-Gm-Gg: ASbGncv7yMRnYnRliZnJ/AEVVnijxWhrlDyQF7XDlPcM+2+nrMc8p/EXR8YpEI2ee02
	DE4JwlHmKtkm0d4owGq6oJhxiULtHfhpsUGL4ZV02BN34pe3/wrge68qLSOa8ce8B9TAx4ocmTU
	jOY/XsJKsSbO0TE3bn41TyPf8kMu53mVtI0XJ+MwjQhTBh3+t/wVxYrXEt1V9nzzWcowCqzUQM+
	0enMlVvSQQP3RceWG8MyL2JMi8uaaqMOuIoxYL8QWsaV7C3remGkzasKyJ1PQgXrHV7mAC6KNxr
	xiOpouZK/1m1kEpMP82RNM6x6y9fvtzMeJAIlAduun/ST7Jzb0OW35H3ywCglqz1a1wQv9CKUQf
	JadIRSTZiCIFVQrjozJxbml3VTkaa0Dn3z3mgKJTRXaOzLHw8KUui0Lr6f0dVUJxp65JW3tVE3d
	zCtx2Y5IQJw/eCijYhEScLT2vMd4PBVXOJ/tjFHtq2uoKB
X-Google-Smtp-Source: AGHT+IHbervUu5GbtMcM0miWf+iTuFrSdnMLQ/CyFR7fuEYt3bBPEOloVFnZ1iAoaFtQpvat7bdJzg==
X-Received: by 2002:a05:6a20:a125:b0:334:a022:d79c with SMTP id adf61e73a8af0-33de967f327mr4808088637.13.1761338476166;
        Fri, 24 Oct 2025 13:41:16 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41409f714sm109227b3a.72.2025.10.24.13.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:41:15 -0700 (PDT)
Subject: [net-next PATCH 6/8] fbnic: Cleanup handling for link down event
 statistics
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Fri, 24 Oct 2025 13:41:14 -0700
Message-ID: 
 <176133847467.2245037.3907469791993421679.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
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
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c |    2 --
 3 files changed, 18 insertions(+), 3 deletions(-)

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
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
index 8d32a12c8efa..a9b2fc8108b7 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -203,8 +203,6 @@ fbnic_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
 	struct fbnic_dev *fbd = fbn->fbd;
 
 	fbd->mac->link_down(fbd);
-
-	fbn->link_down_events++;
 }
 
 static void



