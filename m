Return-Path: <netdev+bounces-41693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64637CBB56
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A510B21226
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 06:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDDC8F5C;
	Tue, 17 Oct 2023 06:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="MGrem7r7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03775674
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 06:34:22 +0000 (UTC)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D13B0
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 23:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1697524461; x=1729060461;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h7mCZ2hRsd4KkJvEkhloZmGjlZeltzdUK8Q1dhgu2P4=;
  b=MGrem7r7xbXmMyoA6hDIaX86sw2sUZwvn6KyaYbiBd4hrGs7S0Scw6aM
   zJC1NiF+VKzEytbJCjJSuUl52/buQKE3xhJ20IlfCdVCe2M/uLjRgvcVk
   i3Ye3eKPfq1CTOsFZw0PKS/XggjEn9tnUiyb34ZnI9m4VyfbVLEI3kMBv
   Vo6HXiIkE3w5tiam/UWkqyXt7c5xvhZrIMqenxMtQKHEreFOOc1dl9uYI
   xN+900Wnf2qbPhhBWQMyLNKlFWB9j3i+liVw+hzJbKP161nBRDxFpa/pu
   bqnKWXwSRsXrYxOUMDwPi47zJopr86iQYanLIrnB/xLj/8wGA+bNOVoGt
   Q==;
X-IronPort-AV: E=Sophos;i="6.03,231,1694728800"; 
   d="scan'208";a="33494788"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 17 Oct 2023 08:34:19 +0200
Received: from steina-w.tq-net.de (steina-w.tq-net.de [10.123.53.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 20857280082;
	Tue, 17 Oct 2023 08:34:19 +0200 (CEST)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	netdev@vger.kernel.org
Subject: [PATCH v2 0/2] net: fec: Fix device_get_match_data usage
Date: Tue, 17 Oct 2023 08:34:17 +0200
Message-Id: <20231017063419.925266-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

this is v2 adressing the regression introduced by commit b0377116decd
("net: ethernet: Use device_get_match_data()").

Changes in v2:
* Update the OF device data pointers to the actual device specific struct
  fec_devinfo.
* Add Patch 2 (unrelated to regression) to remove platform IDs for
  non-Coldfire

You could also remove the (!dev_info) case for Coldfire as this platform
has no quirks. But IMHO this should be kept as long as Coldfire platform
data is supported.

Best regards,
Alexander

Alexander Stein (2):
  net: fec: Fix device_get_match_data usage
  net: fec: Remove non-Coldfire platform IDs

 drivers/net/ethernet/freescale/fec_main.c | 63 ++++-------------------
 1 file changed, 10 insertions(+), 53 deletions(-)

-- 
2.34.1


