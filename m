Return-Path: <netdev+bounces-131061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA02098C736
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C79C285993
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BF71D0B9E;
	Tue,  1 Oct 2024 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZ3cp3mp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68E11CEAD7;
	Tue,  1 Oct 2024 20:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816353; cv=none; b=BooIfOYGL0q1Dbxk0gaEcDtUbu12NAcIDISLnO9A/urVDouj8ACIo1yiMeDuR05P7INn+fqLgdOB/44mHk3KZC0/kc+/t3dDCyajmNso9esICwVbsPjXXg3gpPgAaK1qWnHebMEnee8XmZPvTMtJDJLBfXZFz/uKTDW6XADrQ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816353; c=relaxed/simple;
	bh=+sGyQCcZnRYWNT483wXFzGA+PmhOO4e5FirWiWJ02f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usxuGzN7s5zKBxFu9YX3ePCmHU0olqMlbJSFfX5r3IQuipXj850CEhZe6b7tS+HtEfTnJ7yu5DrNcvg96TcH9cuThcgPepI4DO0VGUwzoRY4vohcqGJqyAFR9+sbv1FNoq705blcNrrdpyJMOnQK++nXWfgSMgTfiiYrKVYzxZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZ3cp3mp; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71788bfe60eso4458917b3a.1;
        Tue, 01 Oct 2024 13:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727816351; x=1728421151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdRjniAk0MF9qWVuayHAMYrBOU6R++71cqj//gbyZcE=;
        b=aZ3cp3mpbRpoDSRMCQqNdeJ9MqGBHJFPtmZdoPBASs3HWQjerNCQ+iXmwFtR35AQhp
         CaNX+2yAVgPsfVch6o9ww4JyqwH7OVsTrtyxywFwvnCvkX/i2PLuoUBfypJ9GGkgYqxc
         jFWN4EpWgCJY1p2EVhcqeHEfyVDEHAsH1HckHkrN4lkvE3ypSYK4I8IGLh45Q6y3X5RO
         kVaA/XGC4ka8c1VneVecWwwWwv7Qh5UuppbH9+AYEcgDrXRmsWhglBkwKhxHEpdwnGby
         ANs0N0+DMdqGpY2LsPoS4O2EczQnQL5Rtw0MPQ3UKHveWwLWFjC6gaUPNgOAfjKqsrSu
         fTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816351; x=1728421151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdRjniAk0MF9qWVuayHAMYrBOU6R++71cqj//gbyZcE=;
        b=Y9VgnEOxhbC9Qi5D0idJtV1deCOw/Xw2gJ7Brqd46r5X6SQKiy4WKlnSrHH6FNvqzY
         x04aGwf4b5lZkgE2XO4oKXFHXL0UKD1KCDW8irwlH9n6eD4FZlu0ZTjRQy1uZYzmzz/X
         CJU0RZW6IaxqW0qhVqOPvzB326cs35MUsw9NVos0M9ksoPQOqXhQFv7JUulZMjWfUNii
         i7BVhBhUJ0p5s6Yhrt9W7gahjFmEquhb5iZDNeee/5wN01JyjfxAgHgRUTp5mFG5IU66
         /NleFMbLHwOtT8SxIIJEH8+TiqQ1dvHlJm22UMb0P241Xt8T9EfaY5LKLwTRykTP5X5V
         kNng==
X-Forwarded-Encrypted: i=1; AJvYcCXTuGz/NAcFYnCbW/BE7ogL0ukgwEuWJDJf54jdxvevRgXL9f0/bi9ojoJjGvObnMd9+n+HOVDR3mmk1Kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYiovRV14lzQY1ZqxjcwtPWRiVkqeUlfgDZJ/TIV8SvEwUftzB
	D2Nju3MDBYDjBvvJDGDvLOMjGX8bC5qR0DOhWp1C4+iae9SvyGqnMrpOsMAb
X-Google-Smtp-Source: AGHT+IF5QjAvrG7j9FN1GlkO7iGTCNvYhrHo2nykJNVcqiQvb2Cn2FumPaa66/zYQkYRcMmVYP9VHw==
X-Received: by 2002:a05:6a20:d045:b0:1d3:298a:7bd3 with SMTP id adf61e73a8af0-1d5e2ddc16emr1305187637.47.1727816351099;
        Tue, 01 Oct 2024 13:59:11 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26518a2asm8545765b3a.107.2024.10.01.13.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:59:10 -0700 (PDT)
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
Subject: [PATCHv2 net-next 17/18] net: ibm: emac: add dcr_unmap to _remove
Date: Tue,  1 Oct 2024 13:58:43 -0700
Message-ID: <20241001205844.306821-18-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001205844.306821-1-rosenp@gmail.com>
References: <20241001205844.306821-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's done in probe so it should be done here.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/mal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index 71781c7f6dcf..2434673ed00b 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -712,6 +712,8 @@ static void mal_remove(struct platform_device *ofdev)
 
 	free_netdev(mal->dummy_dev);
 
+	dcr_unmap(mal->dcr_host, 0x100);
+
 	dma_free_coherent(&ofdev->dev,
 			  sizeof(struct mal_descriptor) *
 				  (NUM_TX_BUFF * mal->num_tx_chans +
-- 
2.46.2


