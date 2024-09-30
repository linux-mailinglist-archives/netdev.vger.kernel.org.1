Return-Path: <netdev+bounces-130599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2EB98AE41
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88DC81F20F88
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881411A38FB;
	Mon, 30 Sep 2024 20:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4aBf3jo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F991A3045;
	Mon, 30 Sep 2024 20:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727885; cv=none; b=eyoJJ6w6b+vGTPSCX9Tpb/erwkgg4GNtVbORrFUGR5nDhyycHaqUm9MH9D+J/fiZAXKQNjGn3Em9p3SdjnzwXby0MMRR/6SXMhTY26MhqA5L5kWUSaUOamsaNYC2lIw8qBEBPsLVQ1tvvhcTIsqM5sW1wkiyWdh9K6XCxq3NHFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727885; c=relaxed/simple;
	bh=mFqtJiDL5sflOI5u3O6MAOrGomeTiBW3Y2yalRuDuoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0+GTOA6E42LtyZ55NvryE2KFJGJMxdZ6L2sdCXsc3ElZ0QJ8GfGN/SW+nb0MnIdRHBpjmBBLE6OAzF22gfQ9qRQgktn8jCATy3gVa0nnRdxCPKm3eB+oPa7sXq2WAUpJxQdU0EFRnLrltdH2eBuj05nqFcs4h/9uEAN3zt5w8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4aBf3jo; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71db62281aeso477435b3a.0;
        Mon, 30 Sep 2024 13:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727727883; x=1728332683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kx7nkLzY6745YLFrKvN4/52jVdfvHDox57Xox+B513I=;
        b=f4aBf3joqAGoNxT7lJDUmtXzvC3Z3gadCs2Ws/Dqo60rhH+6yEohInFe2Jp/8WwJFS
         wYR0z0tGkvYC1FX5f6XDxGoxZA0BIpWa03RCsHL2xsOdjxba+vlxOXODB6idurXmQ1QN
         WmUe9RW0y0yo4SAgfMg2CzRpsKo3oT2QlfULdqFstp140FIdITm4LTaTfBAtDvI6VZYc
         WlJYZxWUwZYGESzMh1chb/ktM/eYeIoBbO933gjpE4wOsKbDArde+ecC5CPAyfnPvaMt
         qtDSmur55+pC65iK3SS8YJlBRQ1XBr5D9rQSZW7m+UnDWxWDzucaHr41d0mvJW0z3vXM
         yyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727727883; x=1728332683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kx7nkLzY6745YLFrKvN4/52jVdfvHDox57Xox+B513I=;
        b=oalUDWb7Ro7+bWTMSB/egCmCBl6He47i57eJNdeD38IxZPQafQG4wBPSQLif9Uraz7
         kA56fU3NoDkKcuZFMr+qHb30K0Xaoq3UCipfXLBYbOVBiWtoMB3BTYkBz3xS1R1mDCWD
         HPcZ7XI756CWWqAvvM3SD74M5/ABgqtEGjKUiG7clfJmIPCOKKnuJVgstlAgBdXhrHVP
         cugKAsnujhHZXoN9Sa8rp8cMtvRlnaOO+RccrzV026+28ff+HnAr1wyqW8r5sNsJVBeh
         HyhwaXn0Sp/esvxAK2gQuu6JVKntUL5l5osFG82qn2ImD0++2XeUQVeHjCKWdI2Yj2Qu
         yFjg==
X-Forwarded-Encrypted: i=1; AJvYcCXo5VoI6zkUpmq1Mkkn1lmfkciDeOt1NCK68C1RZcp3yzPeWv7PaTXYGrTDSy5QQnYf/+1X24GilSRNVO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgsazVtiXXCU4WJnrWBHMoY3j93gCVvMRkzZ3ppwPZUan7DO0F
	wLJ6L+DxkobG83qxiULcziPV5k6J2vGutWSIUvt+uk1g7jDtNXNfAm9a1oq+
X-Google-Smtp-Source: AGHT+IE/vkE3lBiwPHlw+VZis24UGcCR4ug1sPrb0XzLqQd9oMC9cdPkcZwhI+NCcjfS3WAvx+a1jw==
X-Received: by 2002:a05:6a00:8b04:b0:717:92d8:ca5c with SMTP id d2e1a72fcca58-71db79bb1dfmr1065667b3a.3.1727727883035;
        Mon, 30 Sep 2024 13:24:43 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b265160a5sm6670623b3a.103.2024.09.30.13.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 13:24:42 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	olek2@wp.pl,
	shannon.nelson@amd.com
Subject: [PATCH net-next 5/9] net: lantiq_etop: move phy_disconnect to stop
Date: Mon, 30 Sep 2024 13:24:30 -0700
Message-ID: <20240930202434.296960-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930202434.296960-1-rosenp@gmail.com>
References: <20240930202434.296960-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

phy is initialized in start, not in probe. Move to stop instead of
remove to disconnect it earlier.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/lantiq_etop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index d1fcbfd3e255..9ca8f01585f6 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -447,6 +447,7 @@ ltq_etop_stop(struct net_device *dev)
 
 	netif_tx_stop_all_queues(dev);
 	phy_stop(dev->phydev);
+	phy_disconnect(dev->phydev);
 	for (i = 0; i < MAX_DMA_CHAN; i++) {
 		struct ltq_etop_chan *ch = &priv->ch[i];
 
@@ -711,7 +712,6 @@ static void ltq_etop_remove(struct platform_device *pdev)
 	if (dev) {
 		netif_tx_stop_all_queues(dev);
 		ltq_etop_hw_exit(dev);
-		phy_disconnect(dev->phydev);
 	}
 }
 
-- 
2.46.2


