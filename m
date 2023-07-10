Return-Path: <netdev+bounces-16299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D8E74C95B
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 02:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6816B281071
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 00:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7206215A5;
	Mon, 10 Jul 2023 00:57:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B1D10E6
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 00:57:42 +0000 (UTC)
Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E026B1
	for <netdev@vger.kernel.org>; Sun,  9 Jul 2023 17:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1688950661; x=1720486661;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CfcO7Q8FTml/EPGaN7PkFNGOFbP2iGYa0hUM6yvnJCA=;
  b=acivH9XrnrZ2H3+s55FsTy+WigL7r1HEhH1cpRRvKpbKlEbulFKXZDra
   tub5mUzQ6R7PUQlJmxL7Msxbkwgd/N6zzRpDg5muJo9NLLfLp3v6kI6NG
   2XKE0cGBR6eABt3yPcuBRc/C7RTCjUJy7j5s1ytI1oSe9+Nj98VgKRRfl
   QDn4rUq6ok3PW7GifatePkaWxk0yKwDKTqzlZZ0V/MuYnw3G47LRpGC7U
   rh9dulz6MS5VyZsepcbHJSLtJqwfOuFf7VUxd0nxFnEySPE2FrLL1mEai
   g4vrWv4KNSqdXQ9N81PLSCo/O0d7Y6ns0x28Uuv9smLq1S1aKl5dnkuEW
   w==;
Received: from mail-il1-f198.google.com ([209.85.166.198])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jul 2023 17:57:40 -0700
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-34596ad61b2so13210345ab.1
        for <netdev@vger.kernel.org>; Sun, 09 Jul 2023 17:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1688950660; x=1691542660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/wAseA0ncrRwgDlHK9AT72liWPmh1dR/ULxlrBgaw0E=;
        b=PCZ7tOhGGzN4Lh+QOYtBmRv4JUg9lSnrPJtC8zPsnQl8lx0mMRkBcvC0YBa8hYyvR9
         hCEhGG5qUvP883GIXfCH+81V3jLlSWdkYpcKJCi07FnCqOwv/bcz+e9No9pBf3dcQiy3
         3kAo2ooYvVu5S/XQXUNgj7fMzENSl5aPK3Us8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688950660; x=1691542660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wAseA0ncrRwgDlHK9AT72liWPmh1dR/ULxlrBgaw0E=;
        b=PHQBGjQCcsB99pGzo7qCiIF/EYHcIYba+Ib473EdSTc7rHD4n2xW3zC7/1VLYSGbXQ
         QlXnmW7DBK/jFLqk1Fib3CphRj010r2L4riAFyBzxMnBJZQYe2E6fpZdZGUFYRXY/8en
         qu7EvlMZMVwsi9kotLaqTo4qD+ExbgkB3XQT+PSemIDAk/jUxF4xVDqIQJX6Ze6eBnUO
         XOULO+qkWHLDsQL9809M1PcZ7hgBWFeWnb6MDN666ndI48/5z6Lj+hSl4wfZ8yQITkG9
         mh1XgyOYHBfAfWqB6vc02uDwMcVvKld8VAufJv14yNaxfjSmDKzDsWRJ0WJSXaM0DBPh
         7POg==
X-Gm-Message-State: ABy/qLbyiFS9Bwc3BycbLXDDxOBatXg4uS94ekVnbu4sACj3TEU8kHMR
	5NKpzeXvaecVv40dyZ1v+SRxzQsDJ584WH3U7W121PlcolIDcU/U91CUK9Y3WVKZoUdwXPiH6L4
	vEW4Nt5zNMqR6b5dyGg==
X-Received: by 2002:a92:cc44:0:b0:346:3554:4d68 with SMTP id t4-20020a92cc44000000b0034635544d68mr9878853ilq.17.1688950659903;
        Sun, 09 Jul 2023 17:57:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFCflDL0AvD7yBlFIGgUph6Hoi9nSjWAOdNgwDcpPpYLlABzmbu4jcmo4yCsnaE5mK6ijEVOw==
X-Received: by 2002:a92:cc44:0:b0:346:3554:4d68 with SMTP id t4-20020a92cc44000000b0034635544d68mr9878849ilq.17.1688950659634;
        Sun, 09 Jul 2023 17:57:39 -0700 (PDT)
Received: from yuhao-ms.. ([2600:6c51:4700:3f7c:3e6a:a7ff:fe52:5148])
        by smtp.gmail.com with ESMTPSA id d17-20020a92d791000000b0034587c5533fsm3155651iln.51.2023.07.09.17.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 17:57:39 -0700 (PDT)
From: Yu Hao <yhao016@ucr.edu>
To: 
Cc: Yu Hao <yhao016@ucr.edu>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ethernet: e1000e: Fix possible uninit bug
Date: Sun,  9 Jul 2023 17:57:35 -0700
Message-Id: <20230710005736.3273464-1-yhao016@ucr.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The variable phy_data should be initialized in function e1e_rphy.
However, there is not return value check, which means there is a
possible uninit read later for the variable.

Signed-off-by: Yu Hao <yhao016@ucr.edu>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 771a3c909c45..a807358a8174 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6909,7 +6909,7 @@ static int __e1000_resume(struct pci_dev *pdev)
 
 	/* report the system wakeup cause from S3/S4 */
 	if (adapter->flags2 & FLAG2_HAS_PHY_WAKEUP) {
-		u16 phy_data;
+		u16 phy_data = 0;
 
 		e1e_rphy(&adapter->hw, BM_WUS, &phy_data);
 		if (phy_data) {
-- 
2.34.1


