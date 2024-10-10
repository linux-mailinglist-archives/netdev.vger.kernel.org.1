Return-Path: <netdev+bounces-134358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3389998EA9
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 19:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B5F5B2703B
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8291D04BF;
	Thu, 10 Oct 2024 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcSXwSZa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09061CEADC;
	Thu, 10 Oct 2024 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582278; cv=none; b=jez117xgIn+aUPGi6Au8G9Xu5PUjOaBMXj0cVWObptW9Qa49JceGtMWzJvetL/RFpuu6cNQw5HvfxNfuGLUPSqKsVAO8mpVCMzIIMA7z3tUzEEvbq3THs2czCGga5BTqN6xzdIPIY9Y8mSJkKIqpd2mXiidpkrszCa4F31WaxK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582278; c=relaxed/simple;
	bh=J8aO3wzaOWSK9zLJo0TwDlDRlAzhsMjbW+BlKYWpN44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfCTN2LDVEORN4h9HPrlAavpOp43GzlbXqZw0/7HZ2g4v/EvM4lXvwyXmX0zoMNuouh7+ye3fQOj3hNlBoslzeeg21l1hVgivTraTaEu3YYwRnnsATwdlCEDHZyJzTGax+PDuSIl3pHfAFKlcVzIFxHyukRbEj44xC6ggFkkHvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcSXwSZa; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c8c50fdd9so5698315ad.0;
        Thu, 10 Oct 2024 10:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728582276; x=1729187076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/2/UNZRyK+UetM6hDhtPP8oB0m6JLdOgOrPpMpO8bM=;
        b=AcSXwSZajEYv0iAi+Nyikw3YymWXwIB/Cy/HQKhdeJeXcQ8R5vyQgBIhtzsT5QMiiM
         2+of+w+qivsWLJt9YrQZ3Y0BmUlCgZzvCp9kG3PDus959/XrDnj8UAq3cmtkQ8W2/dnI
         +KYAgwajyVo/1VerQsGu22Sz48pagjydmWOlMmvyWdD/whMZHHhAzEg2vyKplD4geE1/
         FJBY/QnzzKJK3e/3GQFd2TeYqnt+xGIw7mk3k1ziWFHJcXU7SBvf0tm4X9SbFkKwMbDa
         Wuktok1yfKEW4kgYasNnLj/TgwI2kbAP9eJuNRuKAsWzKyXMeddGzejmAV5ExaqVv1/g
         uLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728582276; x=1729187076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/2/UNZRyK+UetM6hDhtPP8oB0m6JLdOgOrPpMpO8bM=;
        b=nxbqTndwlme3iypuWhy/jUPqw8JivVeFYUP8CM0rSSXRNWGNfLY70XxIK/qWC1L8Gf
         GuSmdn6ZmbL7opDZDzYJ4At7uy2AV+g90cr4viBlgcKwsw+hbHtjmJeDGRLaJqhQXb+V
         k9NvI4JC91mXHIhTASfL88mhy/NZitrne2c0+QUOxLIto5SS1WLVixfNoHgzhgG7O+SJ
         Rb9mq7fcXAiNU1mGP0Wi5JKIVBtf4lsuqBFvB959EkWipOuxA8JG+UjCRi99QtvXz/OK
         2839HHD27+bZn1XxF7SoO02pB6fBmSNMi3lK5T3SMoQlg905Fzl+MLTMZ2E8Di1gor23
         tQuA==
X-Forwarded-Encrypted: i=1; AJvYcCXdqApcQ09PYWlaRa3i1j0+5QQhcLYaeDRgKK1qygcjVBdhj+q6vAUgsk5ecOG4fT9aNQcSNEI6dCLWarU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy//gXjZkx71mJ1jr26cwpg8cr7ksguP6iGvwpdb92p2wc8pyIo
	p7sT/uAUUl32vz+joS0mpVfPtaqzqV/IfXaYg/d4X8MbkXRoLBKmhDOzEI33
X-Google-Smtp-Source: AGHT+IFC0+KRrQ1otME3XOPyDBpWqGVPD2MvtN4lmastUZR5lMAm+qeuU02fG4QWSzWa+h71Drz0Ww==
X-Received: by 2002:a17:903:120e:b0:20b:c043:3873 with SMTP id d9443c01a7336-20c805023a9mr70043265ad.21.1728582275944;
        Thu, 10 Oct 2024 10:44:35 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0eb470sm11826495ad.126.2024.10.10.10.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:44:35 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Breno Leitao <leitao@debian.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv5 net-next 6/7] net: ibm: emac: generate random MAC if not found
Date: Thu, 10 Oct 2024 10:44:23 -0700
Message-ID: <20241010174424.7310-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010174424.7310-1-rosenp@gmail.com>
References: <20241010174424.7310-1-rosenp@gmail.com>
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
index b9ccaae61c48..faa483790b29 100644
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


