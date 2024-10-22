Return-Path: <netdev+bounces-137684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA2B9A94E9
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 02:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B584528114F
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 00:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4757020265F;
	Tue, 22 Oct 2024 00:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgWA+mLZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C582F201029;
	Tue, 22 Oct 2024 00:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556577; cv=none; b=EutpC2rSrh0pr1Y5m7OlbmVLZz5dHWHZw+DDGnCHMH1PpRW83COh1F2fAPTdQ6ryNoC7066Oz8kjr2ggzGQQt4ZiM2gKBnPdwBt7+SrC/FBdsPgKo//2qMvIceblQSbbTHBDmoUaVsSHa/fN41pnWw4acbsDjMdXULHWjEngxb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556577; c=relaxed/simple;
	bh=7W1VylbnPy+6uViF1/ARBUmxtkB4fxKiP/VOXcbtY1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RY0cpj+QUGkpUarLzMazywi4bu1yGQKodfRbZD7UnyQab3GcBMFtwDnz5Hg+3zS8of+41F0zZTF/kp+lIF45JBnAIvDwqfyA64vIEM15BExeth1woOTENATnKXCJfSrQTMTKAiXftp88jL0tR4llKsQqxRkq8hRCOrF505jX7Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgWA+mLZ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso3878074b3a.2;
        Mon, 21 Oct 2024 17:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729556575; x=1730161375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5WOHJ1q4XRyHeFfhL9R7ir/ceoH2LAuvd+/PdnVpoM=;
        b=hgWA+mLZdmaU0kzv+acUh8n9cZmzCY0vi4KBFIBA5g5+agL4AuqkIqoUCWBdr3xyJy
         Py9Luo1mcHgZUTUDK1bJ+zrjgxxDg4cf3yDRfelhTrX7/Ou4kovEgkUtFgryAUXoTlNc
         k3mhqqrUuLynHM9w14n3XMtA568/Z23OIhj8nkb5+o9Q/a9j37yLU3hDWaE0//VddXet
         XTZkpRnoqvOwqQA5qV3/XCEwm1izucZiOpQovf064ZNyXtyIyYVaC8XNV/M2VWF2+3KG
         Cae0S7CXANujFlHHgkuzd1NHRhaqzpGgah+70oi1PmHvMPmRFq6xV2WiNwVm8nC7+meO
         goow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729556575; x=1730161375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5WOHJ1q4XRyHeFfhL9R7ir/ceoH2LAuvd+/PdnVpoM=;
        b=C4Yywj+CA1EGTrndJqoNOePOcHp9Ffn5maF8bnPFcN8H/wdDp0vBtl+avsb+VyfEc0
         hPuZOFa8JvAnp8DFjo8S4GetJ0KU8YuKHoYuJPT2iFOaezF1MkmxuEKs6Y9xke9h3dSw
         pYMc+ILUIiBFp623zYDUz+07D4nU01ccAUw3q2FtB37YcLSzU7CHAjT0nhWawxyJ6ofx
         WaWboIdnB/3ZhlKrPTI3NyjIZXKccgEeiopZaF08qnTucpZEm+p4NK3QWMtrezwTjU2n
         NkM/rFB4oAX4Qpv59ZU2EI1jqclBeBZAD0UUlDRbHKaQQjbx0BrmI8G3+kvTOogIu+2i
         E7sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEXoVnLTg+LzwR2fx4qqEuDzRKL6MvbUNdBoy3/3xnI5P8KqEGaWsGP1Fk68Gsr4DzghoAhEzkSr6VlDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxdsHIw835cndekt7aE8mvIU194o0HOspTmHk+c6nkVkWENPRq
	4uIka3MAeDXZwckdH4hVCKiagGF6aIPi7Ou3gfZeDRe3l9G+IFqI4Xj2SmNK
X-Google-Smtp-Source: AGHT+IFTEYkZcE3f+h4Dj2pDLuhSLooDOpCqH47mOjVjYRKhzlOwJey41HqY4mot3jdMeJdVdx5kFA==
X-Received: by 2002:a05:6a00:17a9:b0:71e:5033:c5 with SMTP id d2e1a72fcca58-71ea315a906mr20595588b3a.14.1729556574950;
        Mon, 21 Oct 2024 17:22:54 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132ffdcsm3515828b3a.46.2024.10.21.17.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 17:22:54 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Shannon Nelson <shannon.nelson@amd.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv8 net-next 5/5] net: ibm: emac: generate random MAC if not found
Date: Mon, 21 Oct 2024 17:22:45 -0700
Message-ID: <20241022002245.843242-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022002245.843242-1-rosenp@gmail.com>
References: <20241022002245.843242-1-rosenp@gmail.com>
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
index 1f45f2a78829..25b8a3556004 100644
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
2.47.0


