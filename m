Return-Path: <netdev+bounces-244062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 321FFCAF130
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 07:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D2343012950
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 06:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3488E280037;
	Tue,  9 Dec 2025 06:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PtwxwBAq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C8F27FB28
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 06:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765263406; cv=none; b=hCoKujxeDD+4gwU2GllAw879t2T0bk6K/GGZQ620Wb9wY90wjXZXQBPQC+qPWYOs2iNWD2GIEzPncLgWcgUIYh3Nq2FYYQ/2AbDhJoGPpfSWyKzPc/JYnZGoesUFlEuRbkwyJN0AmpAzTqfmJCB88lVlmT+Rno1gxewC3ne6Ig8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765263406; c=relaxed/simple;
	bh=BkTB8790tHyQvmqq4IjYxjq69PW1c+RO81orB7i99pM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rzRU+hmeKGx9+ZpZc6yLcrgXP3YU66PnOSypT1mdH/Z15HFqP6xwovvaoVrpWvw22vri/2saZVsHT3Z2QQDVmYoytsqWhd5wEpwBbYTtZ4cSqOvMXWTqYDf4UC140T5d4jlF/rYjOcDWGy1Nh1Tb2CCUN2R7J2l9zr5D4mwAIWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PtwxwBAq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so53285195e9.1
        for <netdev@vger.kernel.org>; Mon, 08 Dec 2025 22:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765263403; x=1765868203; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GjNG6xVzRAmntQfwOjlrSFL+esIKWya6rAztReNCRwE=;
        b=PtwxwBAqGRSaLpJ4Urakr+AViDWm8Bnve1Kk4yGi2yc/msbE19A+FxRMLSsJFSDMXm
         QocIRmON9mfGAoaLNjj1jfhmpU+JqFkiXSqH/OvMib7mm90m3roC0Lg3rqG5m3M0xlcK
         mrm5qJ88Y0DL0iHqR3F0FlIKIr2sc/5FOKmg82IOVvB12eSsww4upvkt6uXxcSRGFADq
         K/Ah/EGjb101MG5PCqaJXXv8mlCKfRJUXuZnvJbJrPScsaALMRjc7gpUMgZLHBZFZm6H
         DIbDeO8vwJOMY1z0qqf/wOOiLdrjwNQthc2myMpMPhZqrtCEDEGXUCksDx+m+Fgzn2rv
         LhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765263403; x=1765868203;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjNG6xVzRAmntQfwOjlrSFL+esIKWya6rAztReNCRwE=;
        b=pDxynot5Y2d1RzzM2Opf2WdM+WwYJZ9PO/eYMJy48ij9bnwoMVskkWOEyE1rGrdcJc
         R2ZIvKOINfaDKf+4E4bHUOHtBmHY6dl0e6upTVald4J9Wym/vo4rUXEuGHHE4HQNlY1U
         DomSLk7uzWqYQX2CoaddxZl9Bu3gWU7YCExQTQK1gzXlBnwBV5i/Vv4SadEPK+bHwrje
         UmZQ76TXMXl5uo5PQiqsTzbgYOJtqAyv9RcJMiArddXJc4ezkUch5+BtFExv47BA/UO3
         iJWRq1QpN3f+78KZkoly0QV9cWlDZMLrEFjO+tYL3Rv+g8TemKp3/URIjBnS/sGXwSEq
         PqkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMqZOaCZ79BP/5Zxr4KdbT3ukrqoj3IwucuIpkGVwAaYIXRIRCx9WnOFoS+nPTBFWdNJ/Y6nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFex5XLU4hKe+NrUen+EoCTYXuADw27uZ+AGDdo8kCKSrgVX65
	FKI+I8ItVK3ENEtW2Q3hWA1gBQlViFwfLvGgURDWEsLiBcpt/CdObh8+RXKVSV+NZLA=
X-Gm-Gg: ASbGncsQPN6n5fOCrBAD00EWi/YOCQNybBQp4L5RKEF9Xg9oVF072wzd7UzWz61gJpK
	iwtnYMmYYJxkLbGHB60pi8GOiKpSQzmHAMu2H5wf0SDdV8UlMmX0//STlobq9T4s/4JDdx8U82i
	ashfLlAf2XVGgF1Pp3z1alaCerCqlNQtyq+mDm2IU268U2bJ6oNEoYJ7E2D/9Tyfj9T+AkNRd5e
	uJ8MylBd2gyNv2cZ/hevk3JL4AONcQjjlhN32wZeEx0/bfsZzz3uhkWdX2Xot7higXlfvNk5mQa
	8X37NLKejVt8OMRGWs2VUsnY6bz6CQQsXVsNTiJdnP2Mwph15gn+ZvExwPK/S9oNqBFwf9fV2iM
	g1jUgfGmGf9ILeQaLq5rRwalVHnt7qsXnTsg+NF1PiyD6HFnWwjpgudRB3gG9DvgUf8wb7D8i0T
	VotMlG9g78st454NYo
X-Google-Smtp-Source: AGHT+IEncnB1FaGNSKPHTzhN7ebiCnWQF3J9Qs/HjMyOnTYCImY9uSlSJG1pNfOpXJedioGuLMApqg==
X-Received: by 2002:a05:600c:4e02:b0:476:84e9:b571 with SMTP id 5b1f17b1804b1-47939e02db1mr117597215e9.14.1765263402635;
        Mon, 08 Dec 2025 22:56:42 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d682f10sm24836475e9.0.2025.12.08.22.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 22:56:42 -0800 (PST)
Date: Tue, 9 Dec 2025 09:56:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Johan Hovold <johan@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] nfc: pn533: Fix error code in pn533_acr122_poweron_rdr()
Message-ID: <aTfIJ9tZPmeUF4W1@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Set the error code if "transferred != sizeof(cmd)" instead of
returning success.

Fixes: dbafc28955fa ("NFC: pn533: don't send USB data off of the stack")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/nfc/pn533/usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/pn533/usb.c b/drivers/nfc/pn533/usb.c
index ffd7367ce119..018a80674f06 100644
--- a/drivers/nfc/pn533/usb.c
+++ b/drivers/nfc/pn533/usb.c
@@ -406,7 +406,7 @@ static int pn533_acr122_poweron_rdr(struct pn533_usb_phy *phy)
 	if (rc || (transferred != sizeof(cmd))) {
 		nfc_err(&phy->udev->dev,
 			"Reader power on cmd error %d\n", rc);
-		return rc;
+		return rc ?: -EINVAL;
 	}
 
 	rc =  usb_submit_urb(phy->in_urb, GFP_KERNEL);
-- 
2.51.0


