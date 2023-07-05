Return-Path: <netdev+bounces-15456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC971747AA4
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 02:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188C7280EE4
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 00:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB5739D;
	Wed,  5 Jul 2023 00:12:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E370371
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 00:12:12 +0000 (UTC)
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Jul 2023 17:12:05 PDT
Received: from mx5.ucr.edu (unknown [138.23.62.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8718C1B6
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 17:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1688515925; x=1720051925;
  h=mime-version:from:date:message-id:subject:to;
  bh=qJGV4Ihn5aLv2rzCYISjNoN3t4WUUgPb+u7XyG6brjg=;
  b=D2zBdo1zYz28YzMggv0mX8bI1W4djJq5r+A0cZnssXKAXFr6R+/4PHkW
   x+JOtFtwTvxWB+rzRq4vTlPGGwYRBk3xnFz64T5Kp8N7TgLdgMYmIvU6y
   SWsOv5tFRneXwIvFEx9DI1jXpJzPttfjNgjro076+Og7K0MoKvnCwn/gy
   jb5aYavR81IwXWEN+t1Y2FOuU+lyJ+hRx56wxsD5mAT2rTK2aKZJDcq06
   wy/XZuDdEWFL2+L20GaVIVKtBJXRoG0boPBRMEFtsgxr5P6FKcLvx/V5P
   p4fFrJrgbAxtl3GVG7lXvhloLdjFPhjLB2rokUlB2uYPilB+94CYOziOf
   A==;
Received: from mail-wr1-f72.google.com ([209.85.221.72])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2023 17:11:02 -0700
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30932d15a30so4057457f8f.1
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 17:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1688515861; x=1691107861;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3Cx88c8TooVAgvxbbV7gir3Kl8V3dsEGMmFOU/R0Gkc=;
        b=eqOVJ+ZIOAlOzUY3CyGT14tTXLweY+Fl2hm4x/JqtOQOq58R88a+ORK0eiYgletc2t
         iiw4xghVq4+6/tZGjuCUGm1so6PDuoYsGBVAKNDw3EXuZnHBTSklAJx5ZsJGC4m07/+E
         pfelACY5IEEN71veledD0Z3U17h3Oh6KbgpXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688515861; x=1691107861;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Cx88c8TooVAgvxbbV7gir3Kl8V3dsEGMmFOU/R0Gkc=;
        b=ac/jiY/WvHd1WQH9BIX01LzHK1kTqxQlp83moHZoKCoiFXmpEYn9pc/Kjm6JKdPiJl
         GTwqryVG8HWcTJPZInPnKRBKOoGOg5lpKUxNwUNQPXwSeMySM8O56STcyrXcjTSYxsB8
         1Kic0TVT4oEnPtbdUQ50PrZAFLbszAnjE44xiRqxn3ld4e4f8pgaBunJUE9izCJ9vBKv
         DPvDNB38M5konT9irs0vH2+/Nv/BDxluvmPu4bwq2lQ9wzJ0VCaDCl6ORARry72rOkVi
         Cfo3utYESK4ymMxMuKdksvFye0qYaXX8gdeN7nJVgbN0oXAWpDH1VS0SEy9SQ4HKCTQ/
         1r4g==
X-Gm-Message-State: ABy/qLa3GrLR1S5uqlZ2cKEqj2eLuBl8lO3o5rTNh8Men7Mws008xMc7
	ALdHzhbRw9L5R/LhVnfAQFBd+M1BLySTE4RRPmwvy5ZQ6E3rNFJikW81qdsQ7VZFgLJ5jSwWxwJ
	ciaNtn9sKmgeXeWHIf4w6mN92Ipz8AVkMDg==
X-Received: by 2002:adf:f504:0:b0:314:f18:bc58 with SMTP id q4-20020adff504000000b003140f18bc58mr13506727wro.58.1688515860984;
        Tue, 04 Jul 2023 17:11:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFqjXkpHddsxxifSXjJ5i+5FdCHTLPsSKeVVQZ6XLfHIVa778JXLVbCsBJ2trBYzxWgtJBg0GkROtqXVmUc5wA=
X-Received: by 2002:adf:f504:0:b0:314:f18:bc58 with SMTP id
 q4-20020adff504000000b003140f18bc58mr13506718wro.58.1688515860688; Tue, 04
 Jul 2023 17:11:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yu Hao <yhao016@ucr.edu>
Date: Tue, 4 Jul 2023 17:10:48 -0700
Message-ID: <CA+UBctC57Lx=8Eh6P51cVz+cyb02GE_B-dWnYhffWoc-nm7v6Q@mail.gmail.com>
Subject: [PATCH] ethernet: e1000e: Fix possible uninit bug
To: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The variable phy_data should be initialized in function e1e_rphy.
However, there is not return value check, which means there is a
possible uninit read later for the variable.

Signed-off-by: Yu Hao <yhao016@ucr.edu>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
b/drivers/net/ethernet/intel/e1000e/netdev.c
index 771a3c909c45..455af5e55cc6 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6910,8 +6910,11 @@ static int __e1000_resume(struct pci_dev *pdev)
    /* report the system wakeup cause from S3/S4 */
    if (adapter->flags2 & FLAG2_HAS_PHY_WAKEUP) {
        u16 phy_data;
+       s32 ret_val;

-       e1e_rphy(&adapter->hw, BM_WUS, &phy_data);
+       ret_val = e1e_rphy(&adapter->hw, BM_WUS, &phy_data);
+       if (ret_val)
+           return ret_val;
        if (phy_data) {
            e_info("PHY Wakeup cause - %s\n",
                   phy_data & E1000_WUS_EX ? "Unicast Packet" :
-- 
2.34.1

