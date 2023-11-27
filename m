Return-Path: <netdev+bounces-51221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E87F67F9BF3
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 09:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263E71C208CD
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 08:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F185ED281;
	Mon, 27 Nov 2023 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKEHT8lC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FBF182
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 00:41:20 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cfc2bcffc7so6013685ad.1
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 00:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701074480; x=1701679280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uA+NyLywCHNJM2L1yigaSz+qISoqnMqQkC+s56gSPmI=;
        b=RKEHT8lC6ze3ySaNAvNoZDjhRYS4MgyevXvICElQWcQ3MfgFqVglyeeHYktJ26denR
         km3c1K1cLYTZpkeubv5FiqWmI2xp0GvNNZaqXQVJ2T8Uvd7XVp/yEeBZdFGGxEaVVe5W
         EkFSVhu/AlQzlZhlodUtpFAf7//nCOHhjsCsbW8UZ6pNH/L3pESoyXDc5MJOsdGLhO/s
         8/SNk7T6Tsjvp9zMg7w093+LU79voHa+gayz1/2ZDT9zQziGZEOsIlUUMhRdD4wFHMyC
         QXndyWcZzCr6kkNsQ9N9BZa3+i7GE5LcnuYfRH2me13fk75u781d1QcHicgWBz8DCUl0
         /jgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701074480; x=1701679280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uA+NyLywCHNJM2L1yigaSz+qISoqnMqQkC+s56gSPmI=;
        b=MFSjXHj2LdJY8c5VGxdSIRRoH2KlLLP1VMxHprQsT696JcP12MA+YMiJp6wckQMCs5
         1Uu3mHp0/oR7MAScB0jpvN+MyWIg9nspkmgbCDKAY0139WJxq+rZTnv9GlcYjKs+4l6q
         UGyVlaaLLhkOIBVwDWXbmKsd1FrCzbKZoSyTKsX7zCHwkPLIBRI+q0XDGu1FHuzDmpow
         87lPEGrJa5//j3j0yCjyIf54Iw1xZLhTr5OijPpktCBBke/KIkY2v8Ip5pb76dGiyMu9
         8lgQt81y7bv10Kf/Bn3D+u1joO55SmSl0mNhGu1luBSj9bxjnlElFUeRNiZ4iKcTLTrx
         lX5g==
X-Gm-Message-State: AOJu0Yz+YHb5GsKKd/Cs3CeaiYrBW8q30Xg9LEVNWOj5Js5EMjKID29Y
	SwltO4PppUfQYSgZ6t4XliE=
X-Google-Smtp-Source: AGHT+IEspSRKCEQlT9C6CVArofq5q13nH7/QMAh7OXabeyyYAFL0r9PEbfDsw5J/kiEVt0XVCC9eFA==
X-Received: by 2002:a17:902:968f:b0:1cc:446c:770c with SMTP id n15-20020a170902968f00b001cc446c770cmr7401754plp.33.1701074480005;
        Mon, 27 Nov 2023 00:41:20 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id iy15-20020a170903130f00b001b896686c78sm7675722plb.66.2023.11.27.00.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 00:41:19 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH iwl-next] i40e: remove fake support of rx-frames-irq
Date: Mon, 27 Nov 2023 16:41:09 +0800
Message-Id: <20231127084109.44235-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Since we never support this feature for I40E driver, we don't have to
display the value when using 'ethtool -c eth0'.

Before this patch applied, the rx-frames-irq is 256 which is consistent
with tx-frames-irq. Apparently it could mislead users.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index eb9a7b32af73..2a0a12a79aa3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2895,7 +2895,6 @@ static int __i40e_get_coalesce(struct net_device *netdev,
 	struct i40e_vsi *vsi = np->vsi;
 
 	ec->tx_max_coalesced_frames_irq = vsi->work_limit;
-	ec->rx_max_coalesced_frames_irq = vsi->work_limit;
 
 	/* rx and tx usecs has per queue value. If user doesn't specify the
 	 * queue, return queue 0's value to represent.
@@ -3029,7 +3028,7 @@ static int __i40e_set_coalesce(struct net_device *netdev,
 	struct i40e_pf *pf = vsi->back;
 	int i;
 
-	if (ec->tx_max_coalesced_frames_irq || ec->rx_max_coalesced_frames_irq)
+	if (ec->tx_max_coalesced_frames_irq)
 		vsi->work_limit = ec->tx_max_coalesced_frames_irq;
 
 	if (queue < 0) {
-- 
2.37.3


