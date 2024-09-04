Return-Path: <netdev+bounces-125158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D91EC96C1CF
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8371F25F44
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BFC1DC1B6;
	Wed,  4 Sep 2024 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dakaRBIT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA002441D;
	Wed,  4 Sep 2024 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462635; cv=none; b=sWiaudbUubXwYGagdBH9juyO8punVnqBd9kpxKBtGgQSH7bRU8nywdkQPgQ7+w68fjjAniKHljCVrhR1jzxYyyDWHcIiD2GMZbX7pNcG6RMW5G9AlKsY3yIU3H9eGHqZqul6IZqhTuv7fCfQ5AJQI4bLQZm8G5CYa3bZdZaHlVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462635; c=relaxed/simple;
	bh=Bodkg5Fr8TFDFU2UA6h0YFraCTY1/LfVnUmGhyQGXzA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lvw+J3kLWh2a6nHqlAd4SS/7WfeJ3b9+PibKWWD8zOxZnpazkoVx64raGl139dpiOMDRl4nlDt9aVYl0tYeLLXzng83BRL33bCe7nbbhajQCB1ng4OEWE70fddXmjnbh9KWHbEVwHD8OegA8hgpNA1//twd5TrKQWbxUWLXOYOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dakaRBIT; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c3c30e6649so918513a12.2;
        Wed, 04 Sep 2024 08:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725462632; x=1726067432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NF4NL+Dk9p8p6J40pbHs1P6J1ZrVcQfq8BNfmr59piA=;
        b=dakaRBITmHodC9A3Q+ClhunrMhPbSe+ADdT2lZ9dOCE1ruhoAfzKtGiyuP/wjnBUZ1
         OHXNSajILdTr3iCovmpF/YH2APszoqBMOhM4piyspuooFFvRJqoYvwz7Xik99bITnUHQ
         zgqqq7+HXu0QeCpT5qEtrd0BIidel9NfsDEcpOL4/WQwSVfnGbtL09Af1riLxqpu/Z1Z
         UCQRD0yWB91TsK8EVFpd6GM17sjgIoLnJK/lRWnf1NjHkgeXYHmyQTdPWmuxF82ivPbS
         BmQML1EPpoV0AXSpOOqtJui0c4pdf2hZ3LjXJUBOZeaXEKvIbcLy5dUpMDdi90myRBVS
         5d/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725462632; x=1726067432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NF4NL+Dk9p8p6J40pbHs1P6J1ZrVcQfq8BNfmr59piA=;
        b=QwOSNWOO+cAj8bwWh+j0J2tQvD78A+LOz+vyDejRQs32zbQIafcWCLzLA91+S2W4YG
         Mw+X9WFyz7orQT5Q8Sz6NWc6HobVFzbPfN5QjWIQMCCBGGl5U6BUX0WQ52bSbAlwTS2Z
         srzRdu9hFJxP+nyA3VUKnXbNm6dGJCXqh1DcSPdqc+AdnDI+r/IkLitFuNQ8vg5W2i62
         hFb7gUtoY+w4KtG2tzVMt83h8KPz5Dw+CDu+9Dm5Jq3SLqZNvWITXQO180uMCJpYkVZE
         PvR4MHLdjrTbNW+/XzkfMHXZNNzAybcY40FH8RAt0pZfRqy6BdCIXgM3nLYPNYfy3jIG
         oXBA==
X-Forwarded-Encrypted: i=1; AJvYcCU1r4M2NCdFbLIcC6ypl3R3GZb68jO1SAD585EcSOuxQyFUUSWxKghITyQbo9Nj8YE5GHBVTdRb01+5ioM=@vger.kernel.org, AJvYcCVy5YMv69OmGU4hr2VmFC94JPlfaezwVuV5xlcaiJhLD1llsnSoxoA8B128csvtPa3sVj9Growr@vger.kernel.org
X-Gm-Message-State: AOJu0YzSuiO4ivbBuSBQmIHsNkaga4LwBR1nmY4C5LT74/eNJierzzgS
	zLowoWqdZQn4wfOk8KFp1OD5umLMhRz5DPVXfs6LsxMODmBFIVfB
X-Google-Smtp-Source: AGHT+IGLwgkKMYiVxnnDIHuoIje7TvQQT0rw3tCn6aaqS3Do8aK6ygxG1+gzfzAIj+Ibby3M16mPDg==
X-Received: by 2002:a17:907:29d3:b0:a8a:51de:a7c6 with SMTP id a640c23a62f3a-a8a51dea8a5mr98579466b.36.1725462631289;
        Wed, 04 Sep 2024 08:10:31 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:2f85:317:e13:c18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623a6c8bsm2956666b.146.2024.09.04.08.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:10:30 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	nico@fluxnic.net
Cc: leitao@debian.org,
	u.kleine-koenig@pengutronix.de,
	thorsten.blum@toblux.com,
	vassilisamir@gmail.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 0/3] Use functionality of irq_get_trigger_type()
Date: Wed,  4 Sep 2024 17:10:15 +0200
Message-Id: <20240904151018.71967-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v2:
	- Split the patches into subsystems.

v1: https://lore.kernel.org/netdev/20240902225534.130383-1-vassilisamir@gmail.com/

Vasileios Amoiridis (3):
  net: dsa: realtek: rtl8365mb: Make use of irq_get_trigger_type()
  net: dsa: realtek: rtl8366rb: Make use of irq_get_trigger_type()
  net: smc91x: Make use of irq_get_trigger_type()

 drivers/net/dsa/realtek/rtl8365mb.c | 2 +-
 drivers/net/dsa/realtek/rtl8366rb.c | 2 +-
 drivers/net/ethernet/smsc/smc91x.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)


base-commit: 7808012003004b5b31e24795af33480d5eed20f1
-- 
2.25.1


