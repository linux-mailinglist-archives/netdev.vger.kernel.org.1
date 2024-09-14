Return-Path: <netdev+bounces-128330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E6A978FC5
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 11:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437021C21F5D
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 09:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0101CEAC3;
	Sat, 14 Sep 2024 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eUdgDJ+j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E44013A27D
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726307949; cv=none; b=NaHiwp2mfSnjGoaZ3huvMUr6Jc9wnE+ic050q+6aWsHJXLf6V+yetywWW/n+AgjpSWLNVg3oGXAKDhl+MASBd23AbFtEkNV5I/IJncjj9NsQUbnBf9w4yHXdjaI83NMt7bGzBEhQyKNcOCYbZIdMlaM828KgjXFHGvFtcJMVTtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726307949; c=relaxed/simple;
	bh=H+3JuBd9mljp5tywseAzvY42o3nzP65j7tN8PSllVis=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i9GC+nvhiSIBYIoaqW/uDFQ9qUoxCq4w/d/MCflA9TtXdFmN8kW/WHGi02CKZzbrXoL1HnpSldvScdhqj4Jzjay827v91m171uZL3R8UQ8FLzMxmm2Ql95+nmF5x+O5D5Xd+Yv5OgZN1r9I/A1oBFePiJkOPKr7OVxY6Mcd2bcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eUdgDJ+j; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c26815e174so2059902a12.0
        for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 02:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726307946; x=1726912746; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sLR1LdrdWoek5k6vcLJ4wJbjv1o0UlgVrCVA4EoYNzA=;
        b=eUdgDJ+jjHs0JwobXKXxKC167YOwJHo9MiORf13/GB2yHaJrawFu+jon7eb/Jaw3OM
         8BLQn2aSym2tFiEotYsgyP089kaZy1glZQfy8WKo2gfUxWt+Vty1Qa1S/MAOa1xFRd+7
         S1YZ/yf2e4W5dRss25LEjN2GirPupbT2tPcZdE/kC6ySKz5eeqByC3ZS2cFo0fiB1UAn
         R4eDqRtp2YCsUV1vuRmpoWY4he6YUlQ3PDEchnAzkK6WzTnTfptFQe5+BCv2QbQyET4T
         UOXyJHyAaB15cs3s378yrRC6ky1VhKZOSr8DM6qWUMeem9C8HmR2qcAy1mIYmykHo8/O
         734A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726307946; x=1726912746;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLR1LdrdWoek5k6vcLJ4wJbjv1o0UlgVrCVA4EoYNzA=;
        b=J9rXoysokVqYCVPrwoha9oaWxE5HykEprQ2Zx3jl/yRPLrmNDNEC44S4g0NGLxcUJY
         qcUcZXBBTW09V+EeCIJ6z1AGs93A9V/gr9EL4gJAuclN8tGH8cbvGYXMRapFOqigfoxi
         d7+osM0jYSSHPOgyoaMuXqLcSdLGWj7sPv3aT4e2hRcEBPiz8/mS+rcaPmdgA3uOLpl0
         bgpcK3Tl2fnJZVVM60gVUGFRe5/devbWAG/IUY/s1ia6D27ihZpfIC4Oye7FZrFiYwQd
         cAGpTPgRMrmEgpJbsTZNsY2agyyiYB1hhXTJ9cyJUALec9PDu8/+gTLettgM7oXw+AT4
         Q0EA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ3OH0LHy5erqXTK35uRUwaIv1UmtZ+m7qnzWsPCTTL8pDD7L2oi+VN1CfX+OTItuuBdDh2Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIREanAiVV0tMAUdHoJ3kjOYvJ3jlcPFmON5hd4lAkrur8RjSt
	Tho+n9SuVaBN4AsLTp7Qg/Mb9ia6T5HJijwecvi3O1DETkEubC9+gBsVc58PZWg=
X-Google-Smtp-Source: AGHT+IEmamaFtiQks6EQA/58DDUZK1tAOjmtLmuXTiDcTiIt0u2Q9COe7kNjD2a0VxyS3xWdA0xvRg==
X-Received: by 2002:a05:6402:1d53:b0:5c2:6e51:9d11 with SMTP id 4fb4d7f45d1cf-5c41e1ace3bmr4559018a12.27.1726307945688;
        Sat, 14 Sep 2024 02:59:05 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb53620sm506170a12.27.2024.09.14.02.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 02:59:05 -0700 (PDT)
Date: Sat, 14 Sep 2024 12:59:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bryan Whitehead <bryan.whitehead@microchip.com>,
	Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: UNGLinuxDriver@microchip.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net: lan743x: clean up a check in
 lan743x_netdev_open()
Message-ID: <f2483839-687f-4f30-b5fa-20eac90c1885@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "adapter->netdev->phydev" and "netdev->phydev" pointers are different
names for the same thing.  Use them consistently.  It makes the code more
clear to humans and static checkers alike.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
I noticed a different static checker warning that I never reported because it
was too old.  However, I think it's a valid issue.
drivers/net/ethernet/microchip/lan743x_main.c:109 lan743x_pci_init() warn: missing error code 'ret'
I think we should set an error code on that path.  It disables the PCI device
and then we continue to do PCI stuff even though the device is disabled.

 drivers/net/ethernet/microchip/lan743x_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 4dc5adcda6a3..0b8c82ff5e8e 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -3262,7 +3262,7 @@ static int lan743x_netdev_open(struct net_device *netdev)
 		phy_support_eee(netdev->phydev);
 
 #ifdef CONFIG_PM
-	if (adapter->netdev->phydev) {
+	if (netdev->phydev) {
 		struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
 
 		phy_ethtool_get_wol(netdev->phydev, &wol);
-- 
2.45.2


