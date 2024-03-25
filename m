Return-Path: <netdev+bounces-81844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D07C88B439
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 23:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4051C61420
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 22:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2A11272DC;
	Mon, 25 Mar 2024 22:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eHWCTPxW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9E480C00
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 22:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711406034; cv=none; b=AxkC76nzR2B4lEIOrsmiAx728CsXxwDN7IkbZ6ir/fD0aLRW/gADDr0WxFkYsx14FZidsq/pYiMzz0/TUjPAg3ii4V0ALryLsghtyOJlj0f8zzgR1WlQxXsZ3so8neT099YM3OIrvQzKWWVQWNzh1wRbWSncyJld9kiGkZ9qldY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711406034; c=relaxed/simple;
	bh=YAwr12Pp2O0fRce/SvinYrPrRFd4LKtv/Fa7JsuY9Tw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=okD/rzzbSpqGP8wWCefgm407fjUFRtU5fX14lkeXuymnBN9zzoCr957blrMn9eACL53efT0bnsv8J7dz6Qps/O2HH9wA3oLGmbXHf/Z/O5KCSqi9iDe5wg0KwN5Gzi9M0MopXUJftgYw8rljjwOiNd8CAU9qGXpo7Ttyh26dbrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jfraker.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eHWCTPxW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jfraker.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609fb151752so88057367b3.2
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 15:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711406032; x=1712010832; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3rg3ln9iHNo6T6jSs9z4j85QjgUED+D63VdkISPIXqU=;
        b=eHWCTPxWO1I3mZpZ2+7YnBbW5G0vdCihT5JYVSq1Jegc5F58Z7EYErtDn4pG+St0ul
         Wjrj6szhrGpu6YSxMRAlpwyqDKJt9R06KjOWUhbhrspcbElkIDjijJYME61DJvAi1zMT
         nYHsCjHw4OSyjqOZ8sbsML/q3YdOCAoJLrjzJetrkY2JSHfUQwdMn2T0Vos9rNtv33T7
         uH+QfV4jPmTJNKsGFqR2TI9b4dIdXumSJTt3kmVMUVBo3efGwq/TpETQ9HNWAQ7PVz2w
         4tvX3jvGwnIoYUT6LEsswakJS2JB6YTy6+1LpSjOPy8joOaGDBbA0OsM4brGo8WVmt8q
         ikHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711406032; x=1712010832;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3rg3ln9iHNo6T6jSs9z4j85QjgUED+D63VdkISPIXqU=;
        b=I2Q9+0U5+l01/GQaDkTtIDMHqQXa2AyB2n5zDdfDWg/Qq/RqQ663w1F3tqGbePkNpt
         9y+YeL6uMoByN/KfjjclZtzbjLj02tf9oExpw47HhsGONpyHJK2moKLMtHwwyJyX0bUs
         zhD1uBential5eibhuuRULIufjvBxFVOTqONUOYy+gYVCEZLTb44tZ9si0IG/G2wOGvV
         0zfzi+vnz9e0NNIs23CuY8eb2SsMTefSylOsRE0Poo99Z7+LTfzO4FpHXKCp4OGxEmBF
         isxpbHnCFGgau8SiuPXKXcrHsDiy07cLXRFbPThONJ1DLcca5m24lRtyMxh/F61mGI5O
         kOUA==
X-Gm-Message-State: AOJu0YxgQoPYKMG9h4zi2IFFb4ia60A3SwlKPciIwrIjfGfSSn8zy0rB
	AX0VvTTdwalzGdyCKABdKp5XysA2P76B7FQTenVPw+V8IFXk7KL9ZtTu2MYUC7pjdDwti4xNdtR
	boVeIj3zbjTebVsZIrAn16opyIwZWwCmAdUCPCS0RTjOIWLUAVnw8k3dj9P0LV49lMzNkH02abP
	eQM0xg3MxyrJ8w9T3sq1gi6G4UZuVXz1L+h7PeKw==
X-Google-Smtp-Source: AGHT+IFySWPKbgqndk4LEmT9QalTHpgOGbN//3ETh80Lrtu7JdkxzemMu5BMSEqpkpwi+tEh+RLK8tgmt1Ua
X-Received: from jfraker202.plv.corp.google.com ([2620:15c:11c:202:1ee9:1947:3da0:ccf0])
 (user=jfraker job=sendgmr) by 2002:a0d:d844:0:b0:610:f447:159b with SMTP id
 a65-20020a0dd844000000b00610f447159bmr2165530ywe.5.1711406031725; Mon, 25 Mar
 2024 15:33:51 -0700 (PDT)
Date: Mon, 25 Mar 2024 15:33:08 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325223308.618671-1-jfraker@google.com>
Subject: [PATCH net-next] gve: Add counter adminq_get_ptype_map_cnt to stats report
From: John Fraker <jfraker@google.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, John Fraker <jfraker@google.com>
Content-Type: text/plain; charset="UTF-8"

This counter counts the number of times get_ptype_map is executed on the
admin queue, and was previously missing from the stats report.

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


