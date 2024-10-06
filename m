Return-Path: <netdev+bounces-132443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E73EF991BFF
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 04:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BAD8B2135D
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 02:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E419F175D57;
	Sun,  6 Oct 2024 02:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUaG/ju8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756A9173345;
	Sun,  6 Oct 2024 02:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728180391; cv=none; b=TnGHQ1LgoVOR9g2e+76JdlzJrnLlyLMn4uYepXdJzt/ds4gvqzGfAMGGvUxzMXimsP053IiIRfO1NYRs/tC1LlQLGOxImC2ii7qJPj2i7XZIpAubspjmCL7N4zcOc1k+ouwYURXZ8swxAqmmR7dRT2BYjROEk4EZABmPWmRUaxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728180391; c=relaxed/simple;
	bh=mPCw//3/NkAquXj1e7ytaC+VRmOxrlfvhfwk36WqbMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVuhDQipxThbPES3mQFdLY7BE9xE5z4N2R9cVPWOd576Ex+2Vs8HBn1XrmWnKjjwBKxMett35FnCKSYT3k35P1kkPj+iVmPWTwbGMmInBGWZJaMd1yPzDp/l87ojZVUnCT3qal0e/FQfNIIZgxyxorArShA6CorCpOiQHfG3rS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUaG/ju8; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so2739242a12.2;
        Sat, 05 Oct 2024 19:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728180390; x=1728785190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rzW8YzuDHWe4n9H/n3l2GQc4YFTMP1PFG9vBHpmUnY=;
        b=mUaG/ju8vDITmEw6duyXO9TFxIm8Vy1ZlLFgGL+3gEwqwTu2FRphBgewj7P65HWFKc
         mfXHNKUPuuAXw+wCxP4jfnnhhBmk8CLS6/7glg0Eg6p6DmcWZke7vdyVBEQOXihFNNNK
         o3XqCoGJ82LOI4Nj1imCRwHsujFhtWt6XeemtVvB/kb2uqLFOe8ssfWvL9hRvVPHOS4v
         xFfsqGaPI3PSPlfknyhMnriD+DohWXaTFrQGeeLOUK0+xEogXEBbnl4YIt2F0wF9FRz3
         e2H3Q3xM6VGWotuFPPmkfdegQ1A64/9S5pnzf7QMUpfmUjo9ICv8Gwnp1lOuagCbg/dm
         BE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728180390; x=1728785190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rzW8YzuDHWe4n9H/n3l2GQc4YFTMP1PFG9vBHpmUnY=;
        b=j3y48CpvCGqaLRfdXNfHORevZvceX0rP38KS869kCvUykJN4qTmpClRY+34E8fmi4E
         jw4yX54yu9GBfEsEbTZOmvDhLMYl6jRSBgbOnP4rAXu+eeTkhDN4F2Tgn3wMnitwLilc
         OI4sX4pXUzu/ICwBQaXEadnGTCVUFMtIuPzlaaxIHpGuVFVYDMU+kWOocqGiRsds8buA
         cPtsZ1DBxdH3yNQSR2TGC21pcqjYVoBpy080PI7C4uYxBQ3EEuCps76XKaoMvJf+fSPf
         NDJ0JeaqQTFQiZhZFM/Cctia+OTstsHEwPAuYjrsF/JiuZ9zGcqT4R9M9z6D2Il0E5HC
         eppw==
X-Forwarded-Encrypted: i=1; AJvYcCX48k3AObujWMgCAHMjf88q7Gex34f44C6oVXBaCVjT4LToVc9dXyTx5+tm8T85I5eCl88OSsp8SQmEkG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5nb853CoFQQ62RelEVoOuZHvMqgF4jHLrFa1nUePGpGpUZS37
	bVLCMMLmWYTmmJpqV8/7ZUmqoTCfGQjtuGBu00l+ES4kN2U+NY7qFKYNZQ==
X-Google-Smtp-Source: AGHT+IHDkkBIJf1J8vkmIr/p9z6Akv6WM8QHdk2+PS+bcH042beHONthlCna/BCZpGNNFsERlLjlOg==
X-Received: by 2002:a05:6a20:2d13:b0:1cc:ef11:f2bf with SMTP id adf61e73a8af0-1d6dfadd03emr10918608637.31.1728180389627;
        Sat, 05 Oct 2024 19:06:29 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f683153asm2034212a12.50.2024.10.05.19.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 19:06:29 -0700 (PDT)
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
Subject: [PATCHv4 net-next 7/8] net: ibm: emac: generate random MAC if not found
Date: Sat,  5 Oct 2024 19:06:15 -0700
Message-ID: <20241006020616.951543-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241006020616.951543-1-rosenp@gmail.com>
References: <20241006020616.951543-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On this Cisco MX60W, u-boot sets the local-mac-address property.
Unfortunately by default, the MAC is wrong and is actually located on a
UBI partition. Which means nvmem needs to be used to grab it.

In the case where that fails, EMAC fails to initialize instead of
generating a random MAC as many other drivers do.

Match behavior with other drivers to have a working ethernet interface.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 872cdd88bc61..4b21bf2d3267 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -2937,9 +2937,12 @@ static int emac_init_config(struct emac_instance *dev)
 
 	/* Read MAC-address */
 	err = of_get_ethdev_address(np, dev->ndev);
-	if (err)
-		return dev_err_probe(&dev->ofdev->dev, err,
-				     "Can't get valid [local-]mac-address from OF !\n");
+	if (err == -EPROBE_DEFER)
+		return err;
+	if (err) {
+		dev_warn(&dev->ofdev->dev, "Can't get valid mac-address. Generating random.");
+		eth_hw_addr_random(dev->ndev);
+	}
 
 	/* IAHT and GAHT filter parameterization */
 	if (emac_has_feature(dev, EMAC_FTR_EMAC4SYNC)) {
-- 
2.46.2


