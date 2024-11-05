Return-Path: <netdev+bounces-141869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B269BC928
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761BB1C21609
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667981CC159;
	Tue,  5 Nov 2024 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apAa7dD7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44C118132A;
	Tue,  5 Nov 2024 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799089; cv=none; b=k1QnV0EzDIaHgo715l9Co1/LS8eXCU9+e2sjwy5CRcaRsyEjvOP6AP8/t7sIJnVsAhy1nRlt3dJbhMOw8bmx9p0HyUSI7+eXHvDmCGDP/Nf8+kKIlCDL/jmOQxiBFEomM8ty0lgASGxIisQNy1cpOs7p5ZopZe2hgtmUOoJWLvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799089; c=relaxed/simple;
	bh=E8Wrg5ayvZa1X7I9VwxQLW/VIUYRWfbletUtBdxrlJU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=QaIWKeSFDFUkESsbEdMi1mUxfKQhdDH9zATP+1Lwyl+IRxA9MNjA6WX2Q6puLLoQs2KKj6w+mnoaQ3MAsG+77o304GMSyG0AQ0avayLPETJiiXrK9+g++mr8zejdbYeG/6oxPVf0p7teYc7KAgcqvTyf1VSXzdyHjRrRVR1pd10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apAa7dD7; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3807dd08cfcso4411275f8f.1;
        Tue, 05 Nov 2024 01:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730799086; x=1731403886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yFdwTboQaaHQXvZmov57W+9Fn/ofMcP+vE6kpCz8Qe8=;
        b=apAa7dD7NtcBluk5pWK70Zwo42ZM0JnxuZOZvgpx4nZnhJ/g8WBxr+mTyx4p6iK9UZ
         DoDZo7gGyO96+f7RQ5HvCIlVoEOZ5ucoJAAm3WLyrDvGXJktqo6JRs0QeoWP+I+rg+CW
         +H+TGKvNz4wuqFLxee1h+20xVHm+k+kv+DsceAjjCQ41Fc6OqeqcH0L64CYCTFoPe7zZ
         psUeCzh7PN0oz+1Ah9kVOwdxxlcj4FgnfJK8ZfvpmpmW7inVO1/b1a3rZwXUfbjCfsIh
         P7srsK3wd6HBgqETnliz4UYUGDK/gdSoyQFivnzMAtKhakCpiZGC/dKRv4THiF9TI2Cf
         P7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730799086; x=1731403886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFdwTboQaaHQXvZmov57W+9Fn/ofMcP+vE6kpCz8Qe8=;
        b=HGFnkFf3NtpUAQpW3owqli2OtC1/c7nRRshHSlyBfyPlBmNDONZMivQUYcFe6+Vkwm
         4GAiTL6L7z2VS4SQTLJ8tss6d3gzQiNFcfMTMshm0hRMsRTlMbdSvbeOShtWRJuuIKiz
         D9v7Cbwn4bFsgBpdr37LimTOH6xBLiWPSVqdBIpM4b4kSVoLTKB0yQ+K5+ZBz4gaCAyS
         t1RsBFQDXhJ2xaOJNmBAxCUbtrqdBSgci4FKt6AGgpkZ610+J+XCI1ykOzwQ4Ae5nFzW
         tBufmFLv2wShgz04cTYJCiJh4Ndmx0Bg2wldTGFMxm1SzT8VNUuIf3z6f6jdztyF3GcD
         VPOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP6UBiLpyJNcnRzhVX1Qli4XpUzWDjtLFAqv28h4WyBr+OQbB+7JLgizK68HhF/9i84h7P88yfNroGrtI=@vger.kernel.org, AJvYcCXYe15NW96xvmFpQumPNsU928QMzGAUuaQSeAoIeUlUtiVo+xss7FpVwjHy0UEavobOzZdthxip@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6A/FZ8N93MTHVfVAHs39eL6HPP9nMVJZ2HKlOAivpErD7p6tk
	vBhiVEDSmpI9FY7Reb7Zt1f5o96QkBE5eu2QvCLPeR/feADLo7wD
X-Google-Smtp-Source: AGHT+IH6je/LDrue/yuovRF9FeVPclDA2R/0NSV0hMzJV0D9BP4i35BRYIEX4yarF0FD4RamSioAGw==
X-Received: by 2002:a5d:6c69:0:b0:37d:7e71:67a0 with SMTP id ffacd0b85a97d-381c7a46788mr17773422f8f.9.1730799085944;
        Tue, 05 Nov 2024 01:31:25 -0800 (PST)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d42adsm15458080f8f.40.2024.11.05.01.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 01:31:25 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] net: enetc: Fix spelling mistake "referencce" -> "reference"
Date: Tue,  5 Nov 2024 09:31:25 +0000
Message-Id: <20241105093125.1087202-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 31dbe89dd3a9..fc41078c4f5d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -632,7 +632,7 @@ static int enetc4_pf_netdev_create(struct enetc_si *si)
 	priv = netdev_priv(ndev);
 	priv->ref_clk = devm_clk_get_optional(dev, "ref");
 	if (IS_ERR(priv->ref_clk)) {
-		dev_err(dev, "Get referencce clock failed\n");
+		dev_err(dev, "Get reference clock failed\n");
 		err = PTR_ERR(priv->ref_clk);
 		goto err_clk_get;
 	}
-- 
2.39.5


