Return-Path: <netdev+bounces-130519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD9B98AB82
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB999B22EE6
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD07199FAB;
	Mon, 30 Sep 2024 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1bsAkkC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCD9199E9F;
	Mon, 30 Sep 2024 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719248; cv=none; b=PEwRKMQXHy2VThk9j6QZiXZAdAwdR4/ql8WlPX5sGnTC8PjQquhbxMznL3j9OQC1tLoiMKbMiizDxxtgAo6uazZcXITBnqGjrx0uz/nfQNCqp9E4ZOZV/holnfWzz/J/PH7ZeKOev6D0hp+wOtoOjncOazbYdtWRB8tzZaw1AvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719248; c=relaxed/simple;
	bh=k+hWWt4RJCuaq34feyjRdwmdzmEmgz88H7zHH0eqdeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ju5xTYLXdvi3xi3BO/yfTiCiejVLdApw+rYvlBe/KVUTUykYfEboc67quqQZvcmi+1pw4Edp8V8zXayLyuLAbIDvP7IWkO40Pi/62fEYcNVHp/qBnuZ0WcZ82DVcb95vIn7G5po72WWw6k0AnAaNTPhaYg+nrFmyl/G0Yn1iNrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1bsAkkC; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718d704704aso3904067b3a.3;
        Mon, 30 Sep 2024 11:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727719245; x=1728324045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFaFgc9POesph+LsrZhmZjoY7P5q5F3QfbVs+MT0fXs=;
        b=J1bsAkkC+5JrgFrXwanW8FSXiqqoVbR2yrk1oQF+2rgR0azzkqP6ADBtPCN1/JQ52f
         PqqNXpjeLUVl1v4vban8g8gRQhiCaYlW1sAIwxt8+jR22WJBX6B+1piUUP5RGZoc5x6T
         XVZklCNIYyHNpspzEzyjmrh9qXR0jHuPpPRxxAps9LaiQPs4qBIb5ySsHjDL3RJFKsIo
         ZuRDoXD1Gt9mMSExEOofKEDmYAi9aZXR+/MIcM3ZxkisrRLLidN22G+VTHJbPL2ceRSL
         1UM5DYW7P8/iArbztV7BM8PDQTVQ3gsFn834nT+e5hS6ScTaYnjSCy0lrrzopdr/FthC
         sHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727719245; x=1728324045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFaFgc9POesph+LsrZhmZjoY7P5q5F3QfbVs+MT0fXs=;
        b=lFLW8bVI0tWZKMizKCaznDnbEO1HH7iq1rpnoDblJSya43R2rW/CB+sLcLQTAuo8RP
         1HQzMPl5ijcpEpI+f80rWPrsN9X9BWmIiteEEV2rrQp6urP4yuOiV8BT8vWt1Xio53CB
         zAvKWlVutRvYFOwut+dqR/ZzM2VNaQEUN6M3WVEhhLMLBxrco4nlP0A7u3169bBJcDe+
         /UB1KorG9xLYJiyKdwQ/1QVJffaamXY4KKdFpVYStEaErKvlN/3JRh7TXF7Foth+XVID
         IB5TAX1ngBs88ws3JNS33SoFYRPKX5tJL3bpaqk58NV3UlhfJR+b7ozniIZoTtUuUZx6
         u6gA==
X-Forwarded-Encrypted: i=1; AJvYcCVYHRnQHL8R93Zf7FZqio9OSyUcpGipRtNT3ZJVoX754TijfVZgENuAjwY9JwWndzGX6L0V8TbsuPDv1Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMdBgF62E7T6O3PFBgo871BeXd6fJgM7CSo3+601zyJ+I8QoFh
	bqMKmJqyK358WUdxKZQIbvtHctDvLVBHokRV/armVtgq4nLJdqq7N30v2O0i
X-Google-Smtp-Source: AGHT+IFlZ4b9brqjXSgkEe61MDiRpCXUw0Ecmfc8TK1iHAw5gqS93PPIrmyKXi8eAH1RohgdfOo+uw==
X-Received: by 2002:a05:6a21:38d:b0:1c6:ecee:1850 with SMTP id adf61e73a8af0-1d4fa7bc317mr18750956637.49.1727719245355;
        Mon, 30 Sep 2024 11:00:45 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26524a56sm6740653b3a.149.2024.09.30.11.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:00:45 -0700 (PDT)
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
Subject: [PATCH net-next 04/13] net: ibm: emac: use platform_get_irq
Date: Mon, 30 Sep 2024 11:00:27 -0700
Message-ID: <20240930180036.87598-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930180036.87598-1-rosenp@gmail.com>
References: <20240930180036.87598-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No need for irq_of_parse_and_map since we have platform_device.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 205ba7aa02d4..a55e84eb1d4d 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3031,15 +3031,8 @@ static int emac_probe(struct platform_device *ofdev)
 	if (err)
 		goto err_gone;
 
-	/* Get interrupts. EMAC irq is mandatory */
-	dev->emac_irq = irq_of_parse_and_map(np, 0);
-	if (!dev->emac_irq) {
-		printk(KERN_ERR "%pOF: Can't map main interrupt\n", np);
-		err = -ENODEV;
-		goto err_gone;
-	}
-
 	/* Setup error IRQ handler */
+	dev->emac_irq = platform_get_irq(ofdev, 0);
 	err = devm_request_irq(&ofdev->dev, dev->emac_irq, emac_irq, 0, "EMAC",
 			       dev);
 	if (err) {
-- 
2.46.2


