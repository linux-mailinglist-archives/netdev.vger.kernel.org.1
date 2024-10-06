Return-Path: <netdev+bounces-132447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13904991C0A
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 04:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CA9EB21CB4
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 02:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD67116B38B;
	Sun,  6 Oct 2024 02:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm0cC6z7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620651422DD;
	Sun,  6 Oct 2024 02:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728181731; cv=none; b=tlP6fzt+BqzyDUUbmWF4OFxGCNaFKvNsktDP+GC14dYkr1TAlQ22bTldW87SUbP3dsL3vNiTHZg8fk+hE9S5CK6wnEpnq5W9/wadVZDJXrnztBtEWa8YBDXBIsOih6wjapKyNuDGLVcz0y+7DAghqDkqlKt5K/SkQ/edRnF2xeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728181731; c=relaxed/simple;
	bh=b50qnG6pMys52eOHwKFSgjZIQ4k9O1nAgimjm8DeqOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftzAA2WEnIz8TJlYP4xJ6QF0DboukmlAsiIxxQPw7jhygNChCCV562/t1xbY7z6187wXnE5dQNfvzuQf7qzFFYzzDO3j9rkhi35pvSsMhm3T/jsfJ/hO+UbpVbAHZGZw/dmueoAC3S8fp5WuhbqPUVMcGbCjiPEolm5/BIBuUX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hm0cC6z7; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71df04d3cd1so1185792b3a.2;
        Sat, 05 Oct 2024 19:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728181729; x=1728786529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlgYmcfxyeSEbv5swLRH5EW6gIaT0idCEkPjoDiudE8=;
        b=hm0cC6z7HA7ht32wH8yXHsCuiNPQ0ZpGMTbVfimkuzIk5FhoIvjxKle5TonsQiQsfH
         HtTaCoe7FYbsrtZ2rYpK52xlkp1WK9dGxz7mH8LcVm7tEgUOa2Calb42ybAPc0jLMkDB
         e/rXW4mv0Esj7ff/ZMO7GC2mDUA5AynPbgOuMKgNz+MTwMMNuKIZwnEl2PW/ZvIkxZ7a
         telEj5JpHFOJUoGYTQVkEAxAKMN3huCcGsRUrfW6z+sR4lNFLLfJ01S8WCyUyWa4kIP4
         OYpcGgMoll/IVkjNfj5bOWMKIA0q9aY934/pqG8FkF8mTkT4KdqGK8xqNAKTUAJB/iPl
         vtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728181729; x=1728786529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlgYmcfxyeSEbv5swLRH5EW6gIaT0idCEkPjoDiudE8=;
        b=I0KJogaKUwhd8DdOb/x/H9hFFXA3xbyhx78c2SWelJ6KQP1sOPunfjRVOuXJmuBjfQ
         1U4g0OPzQJS/gZIzjW4RXAutnuPwG/2sOBjxqkKD3g8kEpbffpQRCgdRWFZSAGoU4Nm5
         tguh7ifaJDVig+v5e2IHuI7IFzlU3x6evumN9V/5NNq6OSKdj6pTouDZkaH89ftgIefW
         Bix5swORR3AqLz3HOLP92sKse5mrOHw0thL7VJoYyENlhXwrm1B7+fl1Mtdw2uuOfkXo
         Bbvx8n06ngFzkbXIND9jG870t04NtWUy5XjXi1hZtV4OaDsTWr/mFz2g23rU11FNGKN0
         62Ug==
X-Forwarded-Encrypted: i=1; AJvYcCX8HPnFoEbaXZ06tbLHmGmaAL2GqRtAzdgEs3Ob8SjOdFqht2JyX+MtIOH5m2srjluZGPNkOemc7rl65VI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjoFrLFLcCP1nu+gx12JVmS3BDkhBZq2X1xCxrVruy2LI4ITHW
	GvC0jp9AldZccIFq+sP6UeWlkrtjFCqgS4zr/0rKLUvgZ/JBJ1CA34/9GQ==
X-Google-Smtp-Source: AGHT+IHYy5xcGzIXbac+/al9t6Cbds6LST3+hqLeK+HpHNYGTnRYzMsg/pKLnmciDRuPsHJ7CGhwjQ==
X-Received: by 2002:a05:6a00:8c5:b0:71d:fe19:83ee with SMTP id d2e1a72fcca58-71dfe198709mr1680031b3a.10.1728181729456;
        Sat, 05 Oct 2024 19:28:49 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbb9bcsm2103550b3a.6.2024.10.05.19.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 19:28:49 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCH net-next 02/14] net: ibm: emac: tah: use devm for mutex_init
Date: Sat,  5 Oct 2024 19:28:32 -0700
Message-ID: <20241006022844.1041039-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241006022844.1041039-1-rosenp@gmail.com>
References: <20241006022844.1041039-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems that since inception, this driver never called mutex_destroy in
_remove. Use devm to handle this automatically.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/tah.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/emac/tah.c b/drivers/net/ethernet/ibm/emac/tah.c
index 03e0a4445569..61f70066acb0 100644
--- a/drivers/net/ethernet/ibm/emac/tah.c
+++ b/drivers/net/ethernet/ibm/emac/tah.c
@@ -90,13 +90,17 @@ static int tah_probe(struct platform_device *ofdev)
 	struct device_node *np = ofdev->dev.of_node;
 	struct tah_instance *dev;
 	struct resource regs;
+	int err;
 
 	dev = devm_kzalloc(&ofdev->dev, sizeof(struct tah_instance),
 			   GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
 
-	mutex_init(&dev->lock);
+	err = devm_mutex_init(&ofdev->dev, &dev->lock);
+	if (err)
+		return err;
+
 	dev->ofdev = ofdev;
 
 	if (of_address_to_resource(np, 0, &regs)) {
-- 
2.46.2


