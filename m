Return-Path: <netdev+bounces-124268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD4D968C13
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 18:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11B31F231A1
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49373185B4C;
	Mon,  2 Sep 2024 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EKS243Nz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E061428E8
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725294979; cv=none; b=YEWg3WgqSHgWvG2wY45o0homsokVZk7srsAbApv071EP9YE8VHpjcxhsSUs7mHMdH4T6gga7Ca2yxHoK8wXhfctSf21gN2Y4Y1SALlDtCKsC+KJYqce+OMrmE9963p/E7lb4qPK2RCLMpMF2ZyGEZy8hEJkUDAs7rotz9z6Euoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725294979; c=relaxed/simple;
	bh=qvvHFJ8lnK9KIhCzGUcKDmUOEyLurGVGCl31PNkTf9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lO/5Ghq8qCq8FPG8rNCc/7q6EuQVPK4geH8PnA+EAar3UrXTWFBtfqKqKGu2jarAOegur4VfBxAc6zRoSZa6NFW6nac+0BGqTwM3/TFEhBxDq1n1dvG43tbadqEDEwnlDggWKrdIubtotg4zUIixVHLdSXRAgcQagAGGSi/Pi4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EKS243Nz; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f4f24b4d7fso9511871fa.2
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 09:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725294975; x=1725899775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TU2LEHLCwrpWezZ3IZxZU62qAYvX2zDAyjqmiugfN/g=;
        b=EKS243Nz4l6XhAdDmhWjpn0ICOtRXX7xA4FjDJM3VBdfsXAHrKU/TinMcPe2VV3Uja
         jR+n6KAMUnHLbMmiAYyQpawCKqHo6m4jhmVj82+ipS+1cL2oPOGfg9G+YwTltkimylHN
         7EM8DUolhQ8fD/T2Kty/MMgRQTTqFhTySXgzO533Ti85tP61zxCtxPlslOaWCXeu6V6P
         +6zMxf5+bZ4tZnOA1lK33/du0lUCxh87Hgv2R0+wSXICXIK89fbHn8cY4fto9aNFmf9J
         ty5vTy5TPg9ps+DtsM9NLfWYCEvyK9mYa3F8IQAtGa3HLURUq/YSv/7szd8MrJmU0qxe
         9kYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725294975; x=1725899775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TU2LEHLCwrpWezZ3IZxZU62qAYvX2zDAyjqmiugfN/g=;
        b=hgfdLX8h3oQFGdpsk659vc2WZRoxm6JdOMOwVm4xkNHYe3BgKRy3zzGRvoqwTtuOuq
         8vSfwOfBMtw4cJiqluesjJfKs6CXz1eG3urCarTPRjdU58fmisDd+Q2DksbuvWu4NIiI
         gDZVVlOgDOq8lhyzvbHlxrtKXerMG4Mk9xmJQlXlXf7z2iLmpRKRWDnOjrnaXn+PMpia
         tyedQh7JTsvHQ6RjHkYOZYmTntQM06AvlgHSpakoG1CSEAlmYZ845biLUqBBC2VtARw2
         Eo8Jb/qBk5UZok3RZkM3g+yOEN2/tyRXLfU5P2aRhllr/FmKl9csWu5TICxDUE79aJIU
         zRaw==
X-Forwarded-Encrypted: i=1; AJvYcCVBNRHVPM3iASoRgGn0hA6/GukfAxsbdULdMT/WVzCXRY2/hdGF1gpT5mb8c/eBZ5gjVcvHlPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWyas9TOziSRaA4vmDorCA8EEHOCjvHnegEpoUbwjgPpL1zsWG
	ZbM9amBylHXg7dkoI2Hh4C+0pmZmt3XUaSkQ/vwF0oC5Lq1U22qlfkv0/q7xyr8=
X-Google-Smtp-Source: AGHT+IGB1Go1LRTI0V901GHfqjQpvoLp+uw+N/JoNB7ELAzWZkx1eKEQJ+RwMMGT/z6IHlEfqA02UQ==
X-Received: by 2002:a05:6512:2387:b0:52e:ccf5:7c40 with SMTP id 2adb3069b0e04-53546ba477bmr3812796e87.9.1725294975103;
        Mon, 02 Sep 2024 09:36:15 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d7a2dsm586146866b.176.2024.09.02.09.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 09:36:14 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yang Ruibin <11162571@vivo.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] net: alacritech: Partially revert "net: alacritech: Switch to use dev_err_probe()"
Date: Mon,  2 Sep 2024 18:36:10 +0200
Message-ID: <20240902163610.17028-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit bf4d87f884fe8a4b6b61fe4d0e05f293d08df61c because it
introduced dev_err_probe() in non-probe path, which is not desired.

In general, calling dev_err_probe() after successful probe in case of
handling -EPROBE_DEFER error, will set deferred status on the device
already probed.  This is however not a problem here now, because
dev_err_probe() in affected places is used for handling errors from
request_firmware(), which does not return -EPROBE_DEFER.  Still usage of
dev_err_probe() in such case is not correct, because request_firmware()
could once return -EPROBE_DEFER.

Fixes: bf4d87f884fe ("net: alacritech: Switch to use dev_err_probe()")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Update commit msg (Simon).
---
 drivers/net/ethernet/alacritech/slicoss.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/alacritech/slicoss.c b/drivers/net/ethernet/alacritech/slicoss.c
index 7f0c07c20be3..f62851708d4f 100644
--- a/drivers/net/ethernet/alacritech/slicoss.c
+++ b/drivers/net/ethernet/alacritech/slicoss.c
@@ -1051,9 +1051,11 @@ static int slic_load_rcvseq_firmware(struct slic_device *sdev)
 	file = (sdev->model == SLIC_MODEL_OASIS) ?  SLIC_RCV_FIRMWARE_OASIS :
 						    SLIC_RCV_FIRMWARE_MOJAVE;
 	err = request_firmware(&fw, file, &sdev->pdev->dev);
-	if (err)
-		return dev_err_probe(&sdev->pdev->dev, err,
+	if (err) {
+		dev_err(&sdev->pdev->dev,
 			"failed to load receive sequencer firmware %s\n", file);
+		return err;
+	}
 	/* Do an initial sanity check concerning firmware size now. A further
 	 * check follows below.
 	 */
@@ -1124,9 +1126,10 @@ static int slic_load_firmware(struct slic_device *sdev)
 	file = (sdev->model == SLIC_MODEL_OASIS) ?  SLIC_FIRMWARE_OASIS :
 						    SLIC_FIRMWARE_MOJAVE;
 	err = request_firmware(&fw, file, &sdev->pdev->dev);
-	if (err)
-		return dev_err_probe(&sdev->pdev->dev, err,
-				"failed to load firmware %s\n", file);
+	if (err) {
+		dev_err(&sdev->pdev->dev, "failed to load firmware %s\n", file);
+		return err;
+	}
 	/* Do an initial sanity check concerning firmware size now. A further
 	 * check follows below.
 	 */
-- 
2.43.0


