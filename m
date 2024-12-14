Return-Path: <netdev+bounces-151940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5670D9F1C01
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 02:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C29F16AC1B
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 01:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8424510940;
	Sat, 14 Dec 2024 01:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="W5J6QLtF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E920101DE
	for <netdev@vger.kernel.org>; Sat, 14 Dec 2024 01:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734140962; cv=none; b=NPXUfIh/HiuyHwliyZZdi7Qa/1Gf1RS2mLFjf8nKnFIkH2MlnbwznUDDEAvwLU+AcjmvQVtSI46wP26rJ9Lp3uzB2rVQnO1Hf23ZGEXf1ay8P0m+XaCpyjjAPH6mFWyzswY2u/CGR83C7Z/zF8vKxUSGuSkQ4FHKfC+k1Z85IjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734140962; c=relaxed/simple;
	bh=d3+Gq+rXyD9MGbWcbS/XxoWhOm+gynzGGiHeCzoX3Gk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YGgMgU/n2VqjV90GXfljp8aMpkn/SRkZczdKbyTEcKhB+v9wYUrUNLVfgLAP25G8R8/7k4rc6Ypnyec/eD+GsPi7OuWWuzAxqaGc34hi7ZFaUZC88kPBlqjDFlch1gLnyU5rn10edk64ljL7vsvoTPyRKTYFqFlxH/Fp7kt/0Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=W5J6QLtF; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fd5248d663so1783729a12.0
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 17:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734140959; x=1734745759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IJXmhk7Lt2VH2XcCON8G6L/UpmbZGbd/fezqy7ofwg8=;
        b=W5J6QLtF9YxMSUSvQ+qLd4AOIAVz7p4ErkUqDZAFP4DczxfnsgzsukWAGotcc3ACyU
         MPqfWmXiZjY90WAddFJvDIMJejGs8Sh3Cp1grurhUaTnWTK9YtNvSnvWQfUg5x9mF9OC
         osLOGq036grY0hDJrjCpNn3WDhKlbgsUnRS1LB28xuv+0xPJc/RFRpNu+K7o2uoJOi5i
         U1p7B9+64d0ZQD6gq772vUiT5trBundY3AmWZGb5FnRp7RTKp0297ej1pADMPLtEnPiw
         7NN4p0Obl7YtNgYIxUtpJyb6tEWJLmV+xmTEzTIO/MUWFrEA8Kf5aUTnNhrsD+cbYiWX
         jJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734140959; x=1734745759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IJXmhk7Lt2VH2XcCON8G6L/UpmbZGbd/fezqy7ofwg8=;
        b=uDw0z26+r9047NMLNbqcb/RKpXh8GaYLTTALpJqkUKQdKgftqw0bf5We+QrhSskhWM
         +ONyrv9Q6LnShrBsSFTCv3IV6oNFFP4ehHi9ff+pGuOeXpDELKAXIbyY+ud5hpqoVjbA
         o6XQPnPjFNgjLpsAkLRX92D4gNNLd9Yqtc5D9PLDSDEJsb2f51rL4MT68qC6IrXdRhuC
         H6AdUERdUrxuTNs3AKS8OQgUsk/aruNxyzJ8rCCeYturoGvrUFvM+LhWSK/mMi4AZ0OE
         8rZVt9jr1JdiwJo1o3jo+/TCjD7Ya+JcmqTV2Luy74V9my+ng4lDN1TTwBn6fXWgvqqm
         vgzw==
X-Gm-Message-State: AOJu0YxLRdVm5XVUJ1abxZrICdPr0vWjFBxTtdPyh57Qwd81jJ9pWjO7
	Oj0SDiRSrrG/g7h1R0MMb7yNG5Xqv2i4GYUvOg5sXhNlD4N9EUp7mzY0Z/Ew3w0I0SL8NN0wOxR
	5iJfNvQ==
X-Gm-Gg: ASbGncuQZV9UvoxPdBPCtOl/LBQYzV1/kJRXtuwpd9/rIhz+NXt7nPyovyAzFhkAuDY
	3xfTYDpla2m1M9hecDyqLUu5Nz3Q6d4Qbte2+5d8a1gRvmpSyWmqhtO20j6qukjYSxCHc2V8DPh
	V8QL1vfSGkwxZtNsc0qGtyzxtZ9nrc7W2y6JZ6RNzoL++nUoNgZkdSpF+lKyGnZ0BdgyxMInLB4
	Isj365VFebzECNnc+y1vDQ0nqMEljlqckkNv/Cy2GTKZJWW+2Un3kfhWi9+i82Gf+F06CGEBR1i
	FEbaGnz7X83JSG06CrMf0UIlbQdvl3UUOqJKTz8IWh0=
X-Google-Smtp-Source: AGHT+IHD8HpmWVDlmbgv0dx3vfQ3O6BmN3vv3iD1vTQQVOAvU8GR29GsHle6U21P+RqCyCuHcsfEBQ==
X-Received: by 2002:a17:90b:548f:b0:2ee:b875:6d30 with SMTP id 98e67ed59e1d1-2f28fb63b92mr7414807a91.9.1734140958891;
        Fri, 13 Dec 2024 17:49:18 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142de78acsm3836110a91.30.2024.12.13.17.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 17:49:18 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: rafal@milecki.pl,
	bcm-kernel-feedback-list@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH v2] net: ethernet: bgmac-platform: fix an OF node reference leak
Date: Sat, 14 Dec 2024 10:49:12 +0900
Message-Id: <20241214014912.2810315-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OF node obtained by of_parse_phandle() is not freed. Call
of_node_put() to balance the refcount.

This bug was found by an experimental static analysis tool that I am
developing.

Fixes: 1676aba5ef7e ("net: ethernet: bgmac: device tree phy enablement")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
Changes in V2:
- Avoid using the __free() construct.
---
 drivers/net/ethernet/broadcom/bgmac-platform.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac-platform.c b/drivers/net/ethernet/broadcom/bgmac-platform.c
index ecce23cecbea..4e266ce41180 100644
--- a/drivers/net/ethernet/broadcom/bgmac-platform.c
+++ b/drivers/net/ethernet/broadcom/bgmac-platform.c
@@ -171,6 +171,7 @@ static int platform_phy_connect(struct bgmac *bgmac)
 static int bgmac_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct device_node *phy_node;
 	struct bgmac *bgmac;
 	struct resource *regs;
 	int ret;
@@ -236,7 +237,9 @@ static int bgmac_probe(struct platform_device *pdev)
 	bgmac->cco_ctl_maskset = platform_bgmac_cco_ctl_maskset;
 	bgmac->get_bus_clock = platform_bgmac_get_bus_clock;
 	bgmac->cmn_maskset32 = platform_bgmac_cmn_maskset32;
-	if (of_parse_phandle(np, "phy-handle", 0)) {
+	phy_node = of_parse_phandle(np, "phy-handle", 0);
+	if (phy_node) {
+		of_node_put(phy_node);
 		bgmac->phy_connect = platform_phy_connect;
 	} else {
 		bgmac->phy_connect = bgmac_phy_connect_direct;
-- 
2.34.1


