Return-Path: <netdev+bounces-123452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BBE964EB7
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 21:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D02285C5E
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 19:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6341B9B3A;
	Thu, 29 Aug 2024 19:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p2t5myCD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5361614B94F
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 19:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959374; cv=none; b=Loy1Y+nRd8GDSIGF2Pftp4yNBoEhNOEilELAra1QRtKJ+XhNNLiXxPhoVy5Lp1085PlsY62ZBmxpRyexw8A1aYB+5GlZvDPVRTnqTlMVQOba/DQ6qOuLbJcRZSZyjbIeH8SRyTS3R1TimlchmENSlrG76T7sfUbdhT35wWSjN58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959374; c=relaxed/simple;
	bh=Rw3/jwjSMxQMbf9n8gdI432rmGXkKg9i02Q3u0710Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=clRtCaxs8hI49u84JJ2v+QLipVewoNOJRZaSOSmc2QjDBmZwyZGUYQ3WCtk0Fn2dD0iaOP4I/jkSuvgVn1oprFwRfz7vUEJww5CNoCPsPceE53Uec5u61467flTSmbr27JwGngQUeRXrG4ONJaF7Uw4i6gYEglHBezcRocupo/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p2t5myCD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4280bca3960so9019325e9.3
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 12:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724959370; x=1725564170; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bMkm+29lh1erc5fAAFWmKKqMqM4uFrG7ZmX40+JvEqI=;
        b=p2t5myCDmLikM0u0IAPYYIlYwsTm2gEsoi14z470Vlf+1KU9iNMxHA5Yj3tmHyHzm8
         HiT599LvPXnZykalIt4q83iJW99ZvLBNMWAnIpipRrOr7N4u/EZM53xtBwUgtgay5G4y
         1Zxs2cR2/2ZAvqqQSfPHBtECbi/WBvO4JkdpkoJHuRt6q5NB1guRtNL0VpR0n6q2WiOw
         2kr5FmtmO9qUeU/5YDYag2/HohuCi0rH4k5b5QdiKlSJbv+NVqE+uWs2rk6y33PU0tdj
         ZWssi59PaYBLgc3EEKwluewDVHbilW0SC4wHbW2ttKGdykd7tDiKvj+lwy525WMnn6B6
         7RHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724959370; x=1725564170;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bMkm+29lh1erc5fAAFWmKKqMqM4uFrG7ZmX40+JvEqI=;
        b=WE+Uy+z1Od/k7KsBEKsDu2ieHfa74l5kfAXl5hI+NDKoorqrjWkbVOSovhrJ0uQWFq
         WwUvDPUFQ9ijCxRGayA/mSHo/TGbEUWdsTg6AgOdgeoT1br79ha8+DtIw7SobTMBxujG
         VxNAG13/3lUl2b7mX1YWZgykhmR/AY/FzIUmyCudEqfnCnC85CdEYIhfm2ZAGxpsA3FS
         cKh/Dwy2gF6oBJc5iWlwX2ni3pRuR+qpxYixjzgIIYVPCu0/vwZBsQ8X4n6gEcUInXlI
         gu1bcb5FqeYA32YLF/J5cXeEK+kd+yI7A5CjZzDduQPnvF7nULuhAbHi54J0ggONaatX
         0knA==
X-Forwarded-Encrypted: i=1; AJvYcCWf5vZ/0W41f+PM4ViReUFQrn8qHwgrpv7bWQDirR35xxZulx12kAs3FOdw+xd4SrnLAqbOzuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM6lpP7GnMx3b1y5LNYh89fBtE9j7DK1Mufzq3f3p++HCJPPMt
	y7jiCulFO11+P2iGIyyovliiI94QLqUrxN3EdVfL8UAkfy+k8TW3tSrw1d+s/TM=
X-Google-Smtp-Source: AGHT+IFLYl4gny5GWtr+JnUznytxaTDe9bdDxbaWEeIcz0+3LIEKDrXH219LvTPhwALagT9PKwLE3g==
X-Received: by 2002:a05:600c:310b:b0:429:a0d:b710 with SMTP id 5b1f17b1804b1-42bb024db40mr31712775e9.12.1724959369673;
        Thu, 29 Aug 2024 12:22:49 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749efafd65sm2124567f8f.93.2024.08.29.12.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 12:22:49 -0700 (PDT)
Date: Thu, 29 Aug 2024 22:22:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sasha Neftin <sasha.neftin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] igc: Unlock on error in igc_io_resume()
Message-ID: <64a982d3-a2f5-4ef7-ad75-61f6bb1fae24@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Call rtnl_unlock() on this error path, before returning.

Fixes: bc23aa949aeb ("igc: Add pcie error handler support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index dfd6c00b4205..0a095cdea4fb 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7413,6 +7413,7 @@ static void igc_io_resume(struct pci_dev *pdev)
 	rtnl_lock();
 	if (netif_running(netdev)) {
 		if (igc_open(netdev)) {
+			rtnl_unlock();
 			netdev_err(netdev, "igc_open failed after reset\n");
 			return;
 		}
-- 
2.45.2


