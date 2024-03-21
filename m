Return-Path: <netdev+bounces-81142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE86E886337
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 23:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F387C1C225ED
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 22:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2DD135A50;
	Thu, 21 Mar 2024 22:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SDLMhVpW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDBC136662
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 22:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711059643; cv=none; b=k15GlOhgdegNvC75LfMY7NcPXoH1aXnBhluCzL3cuIwtaUdG4RG3PxUsIrUYzaJyBYQuOpSQYH7KY8bcadyH+ecGaLGSDYb8/ylx+xvXET6fB390buCEPnDCmlklR0Da9Tr0eQeC5TWEtL/Eg8rxCDrZQj6TubiB86FZpJbutis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711059643; c=relaxed/simple;
	bh=cxBLQcUnFjnG0EBatiMZwDr+PiAisOufnqISJvyd2fk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Z8FRjRFGaTwka+m9snrq76+6g+guj+7GMMxtATonuWRGInCsu/8IsmqsSgDQ3CVZZXAgZh5UUd/zKppZDTF93QQIaPXba8IxzyTATXINGjwmtj5r2iFyzsZnmvK7HH/8FZjNDvpu6k910GmYsozLX9uUGedn4xc5Wu+hfFzGss8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jfraker.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SDLMhVpW; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jfraker.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ea80a33cf6so217363b3a.1
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 15:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711059642; x=1711664442; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HIRVAKUCXrsW19Rfk9rX09ZKBuFyXSBcI1QnMauRAwM=;
        b=SDLMhVpWpklDU0gq0n7zXlzyUQH7RFRck7vof7Cy5+ZpzloHrwjs+HVAe04AoFQHgb
         zXtzkYtmEMyRnTkKCvFGmVegmIIaKoYrToYZu2wTjwklJnN99kuIGZj5Gl7ndTG7onRh
         wBL1rI3mIpMg9we6vVqR9vL7ArLAontQOMs0E+TAYjovNgsMAKPzzgwRhx+5qqDevldc
         LgXknb1mSSm/XB2gjcFpjGwwVZppWkgcsQLhxHFXXj7O7Dfb9G9CSzAt6jQH2vI+Awvo
         n4c8zkHGlHOuPQRoI/YyHvQDN/kvyElEPU7keDUaZUnvAE6mnJGumycW7LMnCohpdpvR
         92Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711059642; x=1711664442;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HIRVAKUCXrsW19Rfk9rX09ZKBuFyXSBcI1QnMauRAwM=;
        b=nAGM3Lqmism0I5CQRSvkfQGncVTuuEaxXWZu2u3rARhLTIwNFbcnPYs/aECqExASsH
         stYBKf8t2ZG4ZtuHnlwkRifWDiMxBAhtGcaBg91GbfK1o9pwOhhFmcb+rpC3WAi4SSWI
         MXmvHda40DIa2s2SkHveemsM8GXlpJk9vd5Eg2PIbkqa9sTGOAhG/1gqneW9Bb1C0us8
         7z4rf2aFfxCVMDZFNy0eg+RT/wWKM329NAU8qvf/iCEX1YU+OP2ywlJQ+F/BWs1QkNAp
         Ne3aCsJEze+A9PYDV6/F/2CHWT3cnRprtUCRgGf24zRDSN31eExk47mOC7l6h4vwwAGI
         KQKw==
X-Gm-Message-State: AOJu0YzqPhoJ+3jLtkRH7tMr8yOcAshTRSufu8m68dlDaxuaAn1sClS7
	2Ype39bEOOoeZVDG2fcOvJuufthcljeKPssCOsigOJNcXI+kT32BSxrFBTA+ZyoZUWV29cTsCGe
	SqXGUr6gUE0yRbG+SnOnLQejUYDl5XkcPR1YKEYRXFULqHLfgfekwK5QqtRTFgaavgL9tbWbJ7t
	iTy1kESEg/bmfSiZ4GnW/uP9E4ZW5tg0VIw231lg==
X-Google-Smtp-Source: AGHT+IGTKxrV07AWiIfuIZ3JrZZ+cFZusyGMNMZvswIYb6VwBbFfXPAahwqAKuasvimJ+K+6q8QqKIrmLqH+
X-Received: from jfraker202.plv.corp.google.com ([2620:15c:11c:202:8558:543c:cfee:9677])
 (user=jfraker job=sendgmr) by 2002:a05:6a00:938f:b0:6e8:3d58:fb22 with SMTP
 id ka15-20020a056a00938f00b006e83d58fb22mr72303pfb.3.1711059641617; Thu, 21
 Mar 2024 15:20:41 -0700 (PDT)
Date: Thu, 21 Mar 2024 15:20:20 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240321222020.31032-1-jfraker@google.com>
Subject: [PATCH net] gve: Add counter adminq_get_ptype_map_cnt to stats report
From: John Fraker <jfraker@google.com>
To: netdev@vger.kernel.org
Cc: John Fraker <jfraker@google.com>
Content-Type: text/plain; charset="UTF-8"

This counter counts the number of times get_ptype_map is executed on the
admin queue, and was previously missing from the stats report.

Fixes: c4b87ac87635 ("gve: Add support for DQO RX PTYPE map")
Signed-off-by: John Fraker <jfraker@google.com>
---
 drivers/net/ethernet/google/gve/gve_ethtool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 9aebfb843..dbe05402d 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -73,7 +73,7 @@ static const char gve_gstrings_adminq_stats[][ETH_GSTRING_LEN] = {
 	"adminq_create_tx_queue_cnt", "adminq_create_rx_queue_cnt",
 	"adminq_destroy_tx_queue_cnt", "adminq_destroy_rx_queue_cnt",
 	"adminq_dcfg_device_resources_cnt", "adminq_set_driver_parameter_cnt",
-	"adminq_report_stats_cnt", "adminq_report_link_speed_cnt"
+	"adminq_report_stats_cnt", "adminq_report_link_speed_cnt", "adminq_get_ptype_map_cnt"
 };
 
 static const char gve_gstrings_priv_flags[][ETH_GSTRING_LEN] = {
@@ -428,6 +428,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
 	data[i++] = priv->adminq_set_driver_parameter_cnt;
 	data[i++] = priv->adminq_report_stats_cnt;
 	data[i++] = priv->adminq_report_link_speed_cnt;
+	data[i++] = priv->adminq_get_ptype_map_cnt;
 }
 
 static void gve_get_channels(struct net_device *netdev,
-- 
2.44.0.291.gc1ea87d7ee-goog


