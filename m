Return-Path: <netdev+bounces-173467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0CFA591C9
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 11:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E81616C958
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 10:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C449228CBF;
	Mon, 10 Mar 2025 10:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fUwfjXp9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8989E22EE4
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 10:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603715; cv=none; b=TlSuqkepPpvNk3PqEgZs7+Q3AVRR4tfxu0vJyuVEQ7phOVtCO7vcD4fQYP8ktDaZChDoCitXo2inIq17tZP7Dv4xYtwewrwOmiUG6gw8iwW1H7ShMy1d3cfniqSCx86r104TtnDGD9PazVTkBbfxWxvDvVXL31Vk7FremSON+tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603715; c=relaxed/simple;
	bh=j4PdO1nu/lOtJhos8w8kwuTN7slIzAII22YRob34W3M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xi8zNlJLdn3bjr0SEZ7TTc1QVmOZcHFWzr51BBBtBS38buCruwRccxtU6wqNbtnBhhllZcQnVxtwKGAOp1g0f6kBcOvPoW6/r8nVV9S0q0FWx2MKs0jTcxqlGXAQ5C9wVYMdwld7QbYC0l3tzyvSTdQ7nfMKGbq7+vMxgNzZJi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fUwfjXp9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so1991305e9.2
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 03:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741603711; x=1742208511; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RcnXFhBJsspPY81aHKEpyHgRpt8kbK5A2y07Uh+g33g=;
        b=fUwfjXp9rTFdMI/2jYh2Pa4duCMDN49sgIGYlm0TwNFFy9a2ZRTS1uw6F7bbhYyEkC
         pJuLv97Ai/ibsz6KBsSfEs1Lj8NBHFuNj26D9ZQortapRgDfYqUulw9Dwd8Ow2KC8Kv+
         MVRhXW97OTq31uq3smzJpBlNW6UYZXcfifMl+eQsDrItmIFsYp36ykLVMsit6d8QJliy
         T9upNRfJYVkUTkpkuu++VOD6xK8AFFVhsCwfcAVZq676v/8S2UTS/QgfqkZMl2iqA5/1
         OsvjAjBK2YVa2t90rOnyIrPoFig+tTS6NVMsYSVb1IbPJFbf5J+R4gm2eCvS1mGXhw6g
         FGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741603711; x=1742208511;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RcnXFhBJsspPY81aHKEpyHgRpt8kbK5A2y07Uh+g33g=;
        b=Cow9muCO6noEE6q1rHyYZSYD0qFVdk2myp+3G/V0I+SI27V8VoAVmdatvHeXDQoN9C
         snVrIgNtKJ6UavfG2UziEYxTQfCY7SY0McDfCrsXd3gV7f+/d6qM6jRQ+OIeiepajy0w
         xnwiCDTOBh6uPo3eo954qj6K0bNYIxUbsk7L9BHrW2oRxGjCLpS4Mjsmue8cMUnhJpPL
         ioqdBhXm9Ru/bCp82MI1jkflixEJdO7Up6YIZuz3wxEs+2PA+N7aF3yyF/0EH9JmD2iL
         Lte0QTdmbJVJ0wlSA6F6KLCgV7eW5SVR85hM5Uzo15VyambfgCUF2chkt+yTi00gZUtZ
         JPpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyO64z0b8Ln144kexTiTr0Se5cgU5sgs1hEFt7/sZgq75t8UHkbcwOvTAtHmsKF+QZFDWMI/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3P7Be2r7BXQUltGD0/TfFonQB1zDur8pnSfpcHbAHqm939RYw
	YDuzZrpQpRs5YbUpcCRC0pqx1OI/Z0b44cb8wLzM7IiolnTD/GZ84mARvy/pBDY=
X-Gm-Gg: ASbGncuN4cA0qcnTW3c5iLcq5Gj//NpngPVwDZILTCgHnijUiQOHxUZRTnfgo9LHUbN
	1OKXUNTgRHJ+lfEQhQqbYJgesqi/eOkPE3hr26HBO5oXmUGf51wJ6X7fc8goHqF95F5DivBWy4p
	zv/TqTRZumHl9apoIxbTFtk+ZOuBfa69kkAZgr55zxnEROsq3z2u4iP7pzOyflfZsK+D17ClPSJ
	9AxTMmARRsAK2pQSdmr24dD4P5l0IQCFlWGwcGBYlQquWDxjdU5dPQBliLKmdrKLCKX1fzHvZJR
	82IdQXKNtfGDvngqgn7K1xY3PzDFaXhRQniuDC9hKM7bIeF9Wg==
X-Google-Smtp-Source: AGHT+IEvyQMgaUHnCuYCt+OpJiqkHIstn9Ui2odq4PjFQ9lNSszLbzPKWSr7S0YVwsCBZMsm/36JQg==
X-Received: by 2002:a05:600c:470d:b0:43c:fab3:4fad with SMTP id 5b1f17b1804b1-43cfab351c6mr15054385e9.16.1741603710881;
        Mon, 10 Mar 2025 03:48:30 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43cf27f8ef3sm45737585e9.11.2025.03.10.03.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 03:48:30 -0700 (PDT)
Date: Mon, 10 Mar 2025 13:48:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Felix Fietkau <nbd@nbd.name>
Cc: Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] net: ethernet: mediatek: Fix bit field in
 mtk_set_queue_speed()
Message-ID: <eaab1b7b-b33b-458b-a89a-81391bd2e6e8@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This was supposed to set "FIELD_PREP(MTK_QTX_SCH_MAX_RATE_WEIGHT, 1)"
but there was typo and the | operation was missing and which turned
it into a no-op.

Fixes: f63959c7eec3 ("net: ethernet: mtk_eth_soc: implement multi-queue support for per-port queues")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From static analysis, not tested.

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 922330b3f4d7..9efef0e860da 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -757,7 +757,7 @@ static void mtk_set_queue_speed(struct mtk_eth *eth, unsigned int idx,
 		case SPEED_100:
 			val |= MTK_QTX_SCH_MAX_RATE_EN |
 			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_MAN, 1) |
-			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_EXP, 5);
+			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_EXP, 5) |
 			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_WEIGHT, 1);
 			break;
 		case SPEED_1000:
-- 
2.47.2


