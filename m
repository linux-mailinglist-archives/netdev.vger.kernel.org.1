Return-Path: <netdev+bounces-213187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80111B240A5
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 07:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2D868871B
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 05:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1492B2BEC57;
	Wed, 13 Aug 2025 05:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GiDz8xCV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C4E2BE7BA
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 05:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755064290; cv=none; b=g15pr+rfin1Uaobt4gfGubJHuvwSHM/HKfawA3eIp3wZ6IBS2DJLJV4xXoixRTwqrCftaUpihXRP8eCc65HDgEFPkD41sRTUkIxDaP6ZjLQCy65ejccErEnoxBsIai485bGbUkY4HYJEOKLAmNJrvF+T/SRmjtTlvMHcVskSteI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755064290; c=relaxed/simple;
	bh=lRxuv0qt4ISYZ4d5L7KaHZ2U9/6/GI12h89YfeucWLo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=urHh4ZHs4avAN7SYl4L7UqY22ec4/IUorVOo7PhyZD2foKwu2RavSzjTCzSThx3iQnj1cxadwboNJN0hTi1SeaNnQooCV8gpH2scBZS0wWAdAyJ3OQyjfMU+qE6VVMRDdEH0ryd4sOcwDHm/9IPQ4E/miK90Wxnf91U26ZG+orw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GiDz8xCV; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b79bd3b1f7so2952010f8f.1
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 22:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755064286; x=1755669086; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DrOyWBFP21dohGWxqS5PR6ISwURTsFLfxT85phMfX+M=;
        b=GiDz8xCVMi8EzbvXUojwrgp6kG6UCDdTvwMHFpQSsLJz/56aL0JGV0SVL5+89HndKb
         Z+TISc/MK81S0vzzd23LBvIvnvss5KtFOb5CrG/C2KvfRQn7vHDXScw9SItB5n009SEI
         s7/8hTNvvjhu59BM1+U8d2YbxJDIai6fPcReKFBtLeSR0Lt3sHrffDciq2PeMlqDXLIO
         kKW4stgiBU1YO2jxAs3EzXmHj9kO381dJotJOMz7zwYlyrYbTFlbS+W/n/B8dVUWhlRI
         iZZC/BFtGtEe+gpdLF7/+b34NaQK+2U5/YmzF0wSFYMNF/E51YsnrKiPOxIg7G/tOsld
         fmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755064286; x=1755669086;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DrOyWBFP21dohGWxqS5PR6ISwURTsFLfxT85phMfX+M=;
        b=qqBAZuKnNLlWOwZiVIIlv7ZKh6yXco+3hycRPHXe+TJQGnANNZxXsfQi67Be/oHrTv
         tvHayPofLAK8IX3FfMEIP54CVlXODHtBL8IgjZVG+MGJGwmgzCF0ug6/OkILJmpZ1TLc
         hB0gi8Qo91j8SPwVQ9Yj2LkG+rTFObk73PwfQn/FQq7rw30miSMR9XX8TF4ltnvwXXKl
         5ucz+7rqtU5YI4LoOH1uzryHUL2lbPJmxHLzUo+TchkvZVKjbgMfKrIZOhu4NLqcwC1E
         3uYd2nHI5p6XfZjiV8XGtDMUs82CheQL+CISSXdLH8QvhqnBcDhVllNXQ32yJ0b/GhXH
         tbBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGDioDzeYt8k7o5gYnRRnA+Qh0WWfwUBTQ7o8nrNavoV151KefTSP8edg4SSoH6YCnjWtebE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmJC6GEb7t4IBz0M13p8hK3cU13TqrfTg+OyTex6Ugd0CsSPJb
	KKaUm4qqke7X+dpcN2JCceoTuVgeK5f6OUZENmo5hIMZAM9b64Zd+mtfIUJKCv2726U=
X-Gm-Gg: ASbGnct4I9oBZ/OcIKReTLV4tRYTMhATEkLGsPTdXAKRx0Lq5RDeS+mg2+CGW0BapFG
	o73ZWLl6ZgtQtMZb9gxMxA/rnVkG3zVRDvEKXdTBC5C4eJcqUuZspcdcyroRY/zSpRZa7elR9kq
	wvEcqPG2YoAbUCrqHAKNIA18bfH1JgtW8kz/iUmtSe9/dmx1Gtoa7gfyEiAU13pTprZL/+eUC23
	GvgNF4fJ1n1OInYUl3Ep02XD3eW4i0F4fzTbIhcEYDmDE+uj8BPwY5F6OYU2a9qb7kzSZIXP6y1
	RP0prCSgdSooQj79xqOdX+39msYBDc24QGYPJBH/Kl4Ur67eHt2fcD0iilgEvbq6zaz9xIyZGG6
	UPt+fO4yhPLYCsjTPveome5yyywU=
X-Google-Smtp-Source: AGHT+IFcKTFkpLXaLpQ8IyxiEG4h8H2fKINbMz/aPudLtlvebYChChfIWNlq56NuIvASiyNpkDoFVA==
X-Received: by 2002:a05:6000:4282:b0:3b9:15d7:8fd3 with SMTP id ffacd0b85a97d-3b917e37cf7mr963552f8f.16.1755064286473;
        Tue, 12 Aug 2025 22:51:26 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b8e0bfc79fsm35965508f8f.56.2025.08.12.22.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 22:51:26 -0700 (PDT)
Date: Wed, 13 Aug 2025 08:51:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lars Poeschel <poeschel@lemonage.de>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Aleksandr Mishin <amishin@t-argos.ru>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] nfc: pn533: Delete an unnecessary check
Message-ID: <aJwn2ox5g9WsD2Vx@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "rc" variable is set like this:

	if (IS_ERR(resp)) {
		rc = PTR_ERR(resp);

We know that "rc" is negative so there is no need to check.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/nfc/pn533/pn533.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
index 14661249c690..2b043a9f9533 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -1412,11 +1412,9 @@ static int pn533_autopoll_complete(struct pn533 *dev, void *arg,
 			if (dev->poll_mod_count != 0)
 				return rc;
 			goto stop_poll;
-		} else if (rc < 0) {
-			nfc_err(dev->dev,
-				"Error %d when running autopoll\n", rc);
-			goto stop_poll;
 		}
+		nfc_err(dev->dev, "Error %d when running autopoll\n", rc);
+		goto stop_poll;
 	}
 
 	nbtg = resp->data[0];
@@ -1505,11 +1503,9 @@ static int pn533_poll_complete(struct pn533 *dev, void *arg,
 			if (dev->poll_mod_count != 0)
 				return rc;
 			goto stop_poll;
-		} else if (rc < 0) {
-			nfc_err(dev->dev,
-				"Error %d when running poll\n", rc);
-			goto stop_poll;
 		}
+		nfc_err(dev->dev, "Error %d when running poll\n", rc);
+		goto stop_poll;
 	}
 
 	cur_mod = dev->poll_mod_active[dev->poll_mod_curr];
-- 
2.47.2


