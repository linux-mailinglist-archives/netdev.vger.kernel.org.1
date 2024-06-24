Return-Path: <netdev+bounces-106138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF48914F0F
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 15:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 190E5B2193F
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C57713E023;
	Mon, 24 Jun 2024 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVACljHw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4D413B2B0
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719236800; cv=none; b=rsDKI5l/WtqKN9BNKkwrl/xM4tsH6w+2U6CxGkCWq3iFWBQK1l8Gn7eac6eA4NP/NQEmEUfVUfo06UB1Uto57MQZuHXH+C1wBw3D7mdqP85I3T6OUYsNQ2jRkWcBH3q0cpD7T6lLGNv3cCfUKS6PpH/pPe9BA+WrbTasOHJDaoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719236800; c=relaxed/simple;
	bh=10zVMReeijeJInWzRRT8nqqWyMXSXGFzqUo13eRCS9U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nkc0aeWm8GSivE+Lpy6BE0/cT+JKIeCPlXmxFBaWarOzXupD8EpmJeB3Q22m9xO7iZG0ZQY4lrCSLmgRKWH2W1y333V7beRXMCXXsM4ZLyiyOQYcrgkFHl1sDkHubvtdNnsRs0U47PJSnX3F8xpl3s2qTzlMrKn2n+6CaH9A4vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVACljHw; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52cdf4e33c7so194068e87.3
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 06:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719236796; x=1719841596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MbhYbSgy0sHcSHozTLgsR/hK8dOyD461MjQLSBDHJJI=;
        b=BVACljHwyKM4aJoNonE3grB1PiZnLKGY8BLqdIPnk3wSIrumVKRRYBAWzq3d7br/9y
         MA5/MmtA9YUF+CcdgGr0wa4gwKDQdg9gyMnvYAotVB6+wTAveGUxl3eydv/cLvutkPhk
         lmTLB5/gWdCzNsDSGIl4E0be+1CRPuwNvbPy4g0OapSOoras1LDRZmJ3F6YVy5lhbO5p
         FuXZbcmUJCm4dRIPgfADTBEpHiYwUGIyOZP1npsUDNcblfU4Jc5E4tvYwDqCoIsytCvr
         bf62TF/yGiBGJ3EUCv615UEAPgn8Jc/zodVCC0FSv3Gc3nXB539gyoEwHz64ANKhEZd2
         NLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719236796; x=1719841596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MbhYbSgy0sHcSHozTLgsR/hK8dOyD461MjQLSBDHJJI=;
        b=RYhkhhq7YpzFN9gf63EXYYSIMOy82ZvGxdRqvkCwbMCcBd6aqyOTEJhOQphnWqCu14
         On9embHN+rIWhxa3w5LoAWZ2WQI9Ca3Aj3B8CmfPUt+t0ze2MinDZFE0Rdb+3JFtmWR0
         Bs/J66xYqsY60oy3yKyWL82oegYkHjtQDGhyjyEZB5rNo+/BZ0lp8M1IdCFPeiwCbcrM
         7TcbUiuFvx6z8mcyE2q2lxYNytEr1oTBPChhOrtXZ0GzRjcku+FJLEfQbXwfZ5ZtaT3u
         GqqXwyidMFnClbJr86dAUa/vd85YdW2I7sDIqgIgmt7iw8XvBPkyAc4Akw3PKNgJJk/h
         KJYw==
X-Gm-Message-State: AOJu0Yw3Lh2WncjswOaDyi1+DYFpPqSOxF9UEoTgc1YSPns12/uIH4D5
	HR7sa61+uIFPD4bSYDn50s4UKl46mp89kFhko8xN//agDok+3Wd+ztwdI4+M
X-Google-Smtp-Source: AGHT+IGlTzGlq8ZrkAX0mHoizVrFPotB+gIPUWjrTO6oZSmptxh9IDJzRinqwZIIExCKDp5HFO01Pw==
X-Received: by 2002:a05:6512:4018:b0:52c:af45:ed99 with SMTP id 2adb3069b0e04-52cdea4c7d0mr4845598e87.0.1719236796115;
        Mon, 24 Jun 2024 06:46:36 -0700 (PDT)
Received: from localhost.localdomain ([83.217.200.104])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ce12a789dsm504650e87.271.2024.06.24.06.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:46:35 -0700 (PDT)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: netdev@vger.kernel.org
Cc: Denis Kirjanov <dkirjanov@suse.de>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] net/dcb: check for detached device before executing callbacks
Date: Mon, 24 Jun 2024 09:46:07 -0400
Message-Id: <20240624134607.1701-1-dkirjanov@suse.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a netdevice is detached there is no point in trying to execute
the dcb callbacks; at best they will return stale information, and
at worst crash the machine.

Fixes: 2f90b8657ec94 ("ixgbe: this patch adds support for DCB to the kernel and ixgbe driver")
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 net/dcb/dcbnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dcb/dcbnl.c b/net/dcb/dcbnl.c
index 2e6b8c8fd2de..80b3b6ba5d3c 100644
--- a/net/dcb/dcbnl.c
+++ b/net/dcb/dcbnl.c
@@ -1943,7 +1943,7 @@ static int dcb_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -EINVAL;
 
 	netdev = __dev_get_by_name(net, nla_data(tb[DCB_ATTR_IFNAME]));
-	if (!netdev)
+	if (!netdev || !netif_device_present(netdev))
 		return -ENODEV;
 
 	if (!netdev->dcbnl_ops)
-- 
2.30.2


