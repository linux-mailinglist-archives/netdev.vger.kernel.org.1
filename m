Return-Path: <netdev+bounces-105230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1467991034F
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AACA41F22CBA
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC8A1A00C2;
	Thu, 20 Jun 2024 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TmtMOZ2f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B331AC241
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884041; cv=none; b=b3TrGxk/jMUYGZIXP64Ni+5KYDa1KsYLTdEIeU7Zv3PPKC6IB9Dg/mjXrkmRCLoD0VVWbHa7Ad9nUUNOleLTTZabIGxCULRJfN86TeYsYAd1t6FH6xFxU8PIVTFm9JWXTcXk9M+mS0Mg3rqnYb0/UW6KsVLUNm5LMjENL5mcLGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884041; c=relaxed/simple;
	bh=jXv1mhCP5jaX9+OWPN3NNX9k6EYeKPYnn+twk5/eQB4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ge60KL478VnwVf+QME6uqLF2iWXD57dOvmUxtRCHJShoVjb4WIj9AsusGMyOJ7nrZUBZIQqRzmxkwZWEFjuGU+00+p5VPLiKQlno8O4+FlbEQ8ulkjCZnF3vDtfawE9+Vi7vSwF1NyQQQiL9WHwYl1giv6iUvODlco0eBqtgxiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TmtMOZ2f; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfeff072f65so1358444276.3
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 04:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718884039; x=1719488839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iVUU9/gt+Bb7CTynVPH1yn7xrC+qX9qd8pqIfpL1N8U=;
        b=TmtMOZ2fiYwaE+izbGoynjWmOpvU5E4pWJn0iUUzjkHo6HtNxUsEH05LoHkkVBVNaQ
         6X6lwHGFIy2HzlRurdGukuSRRUPOasZrqTvaNKA5W3GqcL04odnNOYEONkBZUF1Qemud
         /cxLEcfrR5FPfMhKIUlB1BnjPRgLPu7TBymjSH1iWXoLJxmrslH5mS7eDJ5okaZdYtnt
         rh0W+/VyT/QKOzqm/MxO8jrV9rILMgjYYNi0vyP3WOv6rcSCTKMjGPmfb6ZVrH0dacaA
         r11+WReMLePeIEAzEk0k3t064xZsio2sJMv10bNUICiBry5k11qXFxYaap3yAyPujHW/
         yLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718884039; x=1719488839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVUU9/gt+Bb7CTynVPH1yn7xrC+qX9qd8pqIfpL1N8U=;
        b=sU+aM/8nVaHCISeKHdOkeFwZJcUmmY+E0EhW8u8luTPZvXh10oKtg1whkgmLXI0+Ak
         Pd4wcdeJ4gbIvwYNuQsWpLthqRDBan4tj9+6II2J59HvzcHFbqHkkT1lWQxXQkFpYVp3
         r406RkIpVEKpz5INQz4ud0u1mG0U8AnjbCVzhiiKmKPdrDhHRAla7vZhy2FDR8JqPQub
         INgVu2WLtTjqWBFq4GRFiRiLTgO61QmZ+Kg7P4wDFpoZaQg7nIMexnMjZ3C/qXPdRXch
         5/lPu0ODlqcLTOhE1OMho5MVNeq+JCRVYxMa1MEAwRmKsOXcfAogwz25gWx2iPJW85xK
         SufQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq2S2+tO8z/YkrTRQX8sYhzV1OTyYuoK83i4hZqWMPJIwfbjEXJw8Zmnxv+r8xUEBgIcgljpIysFE+Yg53h60QXk9r8WC3
X-Gm-Message-State: AOJu0Yz6FQcwdkr38mXWcCWUOUn8IC6IE+YIdXw94sDtmn2q1cdvc8M0
	CzoJSBNHLvB17DEty9tqWj3wyhshfgjtMt5Clsa0nfziinTeGJ4bo8NQrMlb6NlUn6DIO+/g0hR
	tT7fCLBy7eg==
X-Google-Smtp-Source: AGHT+IH/wMEnI5lKIPL5RyTqW8+iMV3Qst6TygS7WixRd1oHtBL+ChD2KSsPhNmtHENDPN6nEQfrEedfk/kWAA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1202:b0:dfb:168d:c02e with SMTP
 id 3f1490d57ef6-e02be0f4c01mr526817276.3.1718884038592; Thu, 20 Jun 2024
 04:47:18 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:47:08 +0000
In-Reply-To: <20240620114711.777046-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240620114711.777046-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240620114711.777046-4-edumazet@google.com>
Subject: [PATCH net-next 3/6] net: ethtool: perform pm duties outside of rtnl lock
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Ziwei Xiao <ziweixiao@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Willem de Bruijn <willemb@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Move pm_runtime_get_sync() and pm_runtime_put() out of __dev_ethtool
to dev_ethtool() while RTNL is not yet held.

These helpers do not depend on RTNL.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ethtool/ioctl.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 45e7497839389bad9c6a6b238429b7534bfd6085..70bb0d2fa2ed416fdff3de71a4f752e4a1bba67a 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -2906,14 +2906,6 @@ __dev_ethtool(struct net_device *dev, struct ifreq *ifr,
 	netdev_features_t old_features;
 	int rc;
 
-	if (dev->dev.parent)
-		pm_runtime_get_sync(dev->dev.parent);
-
-	if (!netif_device_present(dev)) {
-		rc = -ENODEV;
-		goto out;
-	}
-
 	if (dev->ethtool_ops->begin) {
 		rc = dev->ethtool_ops->begin(dev);
 		if (rc < 0)
@@ -3137,9 +3129,6 @@ __dev_ethtool(struct net_device *dev, struct ifreq *ifr,
 	if (old_features != dev->features)
 		netdev_features_change(dev);
 out:
-	if (dev->dev.parent)
-		pm_runtime_put(dev->dev.parent);
-
 	return rc;
 }
 
@@ -3183,9 +3172,19 @@ int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr)
 	if (!dev)
 		goto exit_free;
 
+	if (dev->dev.parent)
+		pm_runtime_get_sync(dev->dev.parent);
+
+	if (!netif_device_present(dev))
+		goto out_pm;
+
 	rtnl_lock();
 	rc = __dev_ethtool(dev, ifr, useraddr, ethcmd, sub_cmd, state);
 	rtnl_unlock();
+
+out_pm:
+	if (dev->dev.parent)
+		pm_runtime_put(dev->dev.parent);
 	netdev_put(dev, &dev_tracker);
 
 	if (rc)
-- 
2.45.2.627.g7a2c4fd464-goog


