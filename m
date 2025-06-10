Return-Path: <netdev+bounces-196354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FDAAD459A
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 00:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 873267A5559
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 22:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E93292933;
	Tue, 10 Jun 2025 22:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7xGmH8G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6A6289816;
	Tue, 10 Jun 2025 22:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749593065; cv=none; b=fLxEyIzG5fTQpqvtB/WnPU9cXcQ09zOv0XjLHKWSRS0EGRgoJEzuYc0gn5GKqIaweXdDLN3lj7/MJ+AxOOOmqh1IlnpTuLvtNsAdtX+pI5PaRlYh8NmahFkhLXiJtLyxSce3t136rO4x6M+FQVp4KrFytiBRLGtW7cid46uruu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749593065; c=relaxed/simple;
	bh=8l3gnyPviqEixxQXV/zpdsSxwWRqbfKzljaeqY3h2u8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TnOCsxe6M7nDJxpTkWsnkk59zJWNzZnN5wJV+vAc/fBV8dNWw+Sp4GKP4efYNHkMxicnk8Hi1A6PEk49AanDBrKLTL+9cZgGxqznWbVfNFx6bSVhPavD6TiiKUXWx1AhBaCOSGhqqyuO/jtBipik83DI5tBNv++8OhzdNSLlFUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7xGmH8G; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-604f26055c6so540408a12.1;
        Tue, 10 Jun 2025 15:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749593062; x=1750197862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMYUWW0bclCVcOggJxO+oiOmU0BmWw0jDNiUTlmTzwg=;
        b=B7xGmH8GYcIfF+F5VFOFYeJk3/dCx8n6VUFvY7r2zSYMpMkSyjRM2VXJsIAzCgXXrk
         MwyRghTuXxDVJofrFXP4n9Em+MlemIeZ8kDYX3rJ8UErUpHefiJE8D/vJz4B9Fe8X4pL
         G+A9uVVWhw/hOmzx/hq+EcXOUPHCZZ9Stptc88Slh1sp2Yvkfw6y7+GQ87eXx+ppitIX
         PSm0AGksVzbHk7hZ5TKoT6hi7jkLdIt2iEPb0LceGWYjSIE/fcT7j8mmBmdr7aX4dUQC
         89ytfCcg7nJgzZ5hc4fsB+hAjw8rtM7bh1zaZYbrmW4d1raw1y5EoRnJVItwVLv9wstZ
         oYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749593062; x=1750197862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMYUWW0bclCVcOggJxO+oiOmU0BmWw0jDNiUTlmTzwg=;
        b=Ccn+MGxbLeDnjKAbXqDi/0zRC1Zggf1HZLXKJ+ixpODVqaVRokMu6zBA4ZshEtNFut
         oes2EtKczP30QNQTTR6uOqzVj5wSDpAsUm5Ck73icuLOLBbTvqPVxsJr/XQiavBC4jSN
         dpjanDUxNHFAoaTq1UEIBbGgHbKhZk9GT9sj2v94Isd4HtqSopMZijDcNp1Lud5+RfgH
         z0PT+IDUqaA5GB9ch7dqK65foLd9CinC1H4FJmt9O12EMAe1ojqSkqTqVdGWTOOAie1D
         worYpfpooONkufLYJ6uty3FCmkwv3defQtxQXot9iMRH7AILzqjjiQ5cwtKJRdwaSnmW
         fkOg==
X-Forwarded-Encrypted: i=1; AJvYcCU0G8U/Qr1Dt5PbOIkp1bInMm30qQ2/7g0uUc9/LK1QAfbxIkUtVTvL1PhZr7h4j+YFN8zLUifO@vger.kernel.org, AJvYcCUu+JOnthqQlNZe2nFTfjuT3DabRh7ZfOBDY8snQgi+ZqDHe8rij1c3P4i792ru8PjXyUAIo5tc7KdnM10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0d5D+Hc4zFwmCiVYvOyw++EnVqltZjJQ4vPaqKAOFSN+z5ezp
	BtFgaU2lTFbiVQXvnYrkglBz8Q6GR2FE2ZnoSGChJK0XBcwMQoZQceDn
X-Gm-Gg: ASbGncvHY8M/YMnNd0hnorGRFdigCUsGnJTuuyeFpfsPlDQeBsc9G7Z3RZXsOSAvkdb
	clb6oH5Qjr8pGfX6F8WMGWgdjGyeGFCLXL8E7PVucYmpCmEzHmkEgXAqrSjRcmEZsEH7naP2QvR
	gojjKKTUGCbLRUck8FSnM0wsqrr3+r/ObaOl22WSe8WlQI2bT3H90s399baNqmOaSc8es/q3IZo
	LuPrYXg1uROschaRfgYSg/pIQqRatVKYleMgVIwfqQ2BnQdzBt2a++JkL2HTt4lVi78F7FSOZ2f
	64ghPtW/b0kwnr7NikDoQUZBv18XZ3DR9ABpvetWCrpQcTbE67BInGEg3DrLMMUfeDm9HlcL
X-Google-Smtp-Source: AGHT+IEKuHa6Mer66oqnLzcK1LcKiXGx7Yk5tG0ntauQVUFFXcIGuj49M1xUBYEPZxta7s7+vqPsiQ==
X-Received: by 2002:a17:907:70c:b0:ad2:e08:e9e2 with SMTP id a640c23a62f3a-ade89a7899amr78262066b.27.1749593061748;
        Tue, 10 Jun 2025 15:04:21 -0700 (PDT)
Received: from debian-vm.localnet ([2a01:4b00:d20c:cddd:20c:29ff:fe56:c86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc7c92esm785605466b.168.2025.06.10.15.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 15:04:21 -0700 (PDT)
From: Zak Kemble <zakkemble@gmail.com>
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Zak Kemble <zakkemble@gmail.com>
Subject: [PATCH net-next 2/2] net: bcmgenet: enable GRO software interrupt coalescing by default
Date: Tue, 10 Jun 2025 23:04:03 +0100
Message-Id: <20250610220403.935-3-zakkemble@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250610220403.935-1-zakkemble@gmail.com>
References: <20250610220403.935-1-zakkemble@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apply conservative defaults.

Signed-off-by: Zak Kemble <zakkemble@gmail.com>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index cc9bdd244..4f40f6afe 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3986,6 +3986,8 @@ static int bcmgenet_probe(struct platform_device *pdev)
 	dev->hw_features |= dev->features;
 	dev->vlan_features |= dev->features;
 
+	netdev_sw_irq_coalesce_default_on(dev);
+
 	/* Request the WOL interrupt and advertise suspend if available */
 	priv->wol_irq_disabled = true;
 	if (priv->wol_irq > 0) {
-- 
2.39.5


