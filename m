Return-Path: <netdev+bounces-130614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F0298AE8D
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 274951C21E0E
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AC41A2541;
	Mon, 30 Sep 2024 20:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgMRwd6n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE4417332B;
	Mon, 30 Sep 2024 20:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727728720; cv=none; b=bqH+4XokN8Qcq4Zr5b0LK0QryqQbhzrKDzQ4i1OypUamly850BNrK1TRDKA4OAphBgzhWb6VlCh5CF28VqsxPob2MV5lgawwthK6VSiVbT3oXlOSe6RBudP93atk8Ge/AROSNLFoWiIyscvr7P2RE2IWjTIRlApKRxyuoq+r8j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727728720; c=relaxed/simple;
	bh=SdWNxiW1a33gv3dEjg3cIUhOf0p4uT9vq1QQloiGxG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OWTqOZoqYBo4L3eDmcY6X+N+X4qwQfc5+9y6piREU1h+7p4wu4MrGl1Fsnb94PMyQZJz/kNFzwcEwyH4wU5X/1/KuU5x/wOyCJfbPRMLe+EM4oToxSiO6SKVkuNBxpkDCXGMr/U2CHeh9sq6IKHzjjrJQ9vkyodG2DU31x8hWsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgMRwd6n; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7aa086b077so708930866b.0;
        Mon, 30 Sep 2024 13:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727728717; x=1728333517; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9sqtZ/31Yy7RoVK60NTWtW6OUtzrXK53h8wt43cKuCI=;
        b=fgMRwd6nqyr21nIKVjgZw7TgI2LKTIsvp1SUWTL2uRa+i5wVJChOx8DA4dE6xvV2qa
         C8oiEqLTkJkXEbP9yiniXz1aKNnYIJ8HvBu6qBgQ2qxWI7RgZss3cjdpXSLMgwfJ+CN1
         l4jT234ttJs4iefhOGhUuu3Xe8oRWhSOU+3vZm/FTiD95qc+iYHgHPqTWU1mwXzJHwFq
         H1kcdl/9itApDjqRqQui9T+Wk3lwE5wBPRAzwAVr9AKfa02G9brJSQ0/GJ6FfN8lWoy+
         znSD8GP4IOHgHYCUyR57CtSJwHQDvyahv3E5cEbKaQLw/XbrFGxbGMYUzHqRc93K29wc
         Kh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727728717; x=1728333517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sqtZ/31Yy7RoVK60NTWtW6OUtzrXK53h8wt43cKuCI=;
        b=s2YTRWH+g8NOZ88fsc32PePXxF7COwIrJoZwrXCRb0VXF2bpFcQI+sxAPJIYpGf9nq
         uVUfCApJjKEjfRaXGUzNsxN7c5piEss8NWjmKdzqNUG9HVrbNR3eoXHx8QgH5O+5g1et
         u6WkT+3t/6UCTkie3j8xdgf90AxH9DviktdjArXrF2NRz3J00F2Ouq0NagAW2d4FhBHL
         IvpLsDqddU8pwq46YK234j4yAEOwE3aW3FHdNgaysEt+xAQOCjOmAnY1ey/BfmjCJ1/3
         6RpMHbAnwnpd41WLzagfIEsW3jOBDjtJp7tlcdkR7xmGALRpSr6s721qQZd0h2Kdai1/
         A1vA==
X-Forwarded-Encrypted: i=1; AJvYcCXte43i4VQy0MpHMzvr4N5pjdpL+77rntmkY87sd8o4zNqPWHWL8bitWT+AcNKDaBUeOK8ur/FX1Q/Lf84=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjqBmEBU7P7LrKzT9NeAKmYamuEnnLMZJqXfY5SedVCWlau4x6
	Vo26SEHaABWT8+Yf4758cbbDpLRx3NZwPVUNzP7I0gNw7jM55EWj
X-Google-Smtp-Source: AGHT+IEquB9BgPn6UkBLsFnpdYfXV0HugFG/eBiP5JqRfWauAgzX5a+NF1CFFpH6b/LoBa2HU1++nQ==
X-Received: by 2002:a17:907:1b20:b0:a91:15ba:7a66 with SMTP id a640c23a62f3a-a93c4a8509emr1610620566b.44.1727728716891;
        Mon, 30 Sep 2024 13:38:36 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-91b0-e3db-0523-0d17.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:91b0:e3db:523:d17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c7184sm581377566b.83.2024.09.30.13.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 13:38:36 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 30 Sep 2024 22:38:25 +0200
Subject: [PATCH net-next v2 1/2] net: mdio: thunder: switch to scoped
 device_for_each_child_node()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-net-device_for_each_child_node_scoped-v2-1-35f09333c1d7@gmail.com>
References: <20240930-net-device_for_each_child_node_scoped-v2-0-35f09333c1d7@gmail.com>
In-Reply-To: <20240930-net-device_for_each_child_node_scoped-v2-0-35f09333c1d7@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727728713; l=1729;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=SdWNxiW1a33gv3dEjg3cIUhOf0p4uT9vq1QQloiGxG8=;
 b=45LeRA8UfOrDXpe+wp+NdkpEjwZlKJ86yPRj0AEvP0w/PAKOtmgz3UD6Vt/vYL7ycCKjMMoHU
 Ciu4jOhlSrnCw2EYytKpnuq7NQvaRmcGU57xCu8HfhhZYQBZSNdppT1
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

There has already been an issue with the handling of early exits from
device_for_each_child() in this driver, and it was solved with commit
b1de5c78ebe9 ("net: mdio: thunder: Add missing fwnode_handle_put()") by
adding a call to fwnode_handle_put() right after the loop.

That solution is valid indeed, but if a new error path with a 'return'
is added to the loop, this solution will fail. A more secure approach
is using the scoped variant of the macro, which automatically
decrements the refcount of the child node when it goes out of scope,
removing the need for explicit calls to fwnode_handle_put().

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/net/mdio/mdio-thunder.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/mdio/mdio-thunder.c b/drivers/net/mdio/mdio-thunder.c
index 6067d96b2b7b..1e1aa72b1eff 100644
--- a/drivers/net/mdio/mdio-thunder.c
+++ b/drivers/net/mdio/mdio-thunder.c
@@ -23,7 +23,6 @@ static int thunder_mdiobus_pci_probe(struct pci_dev *pdev,
 				     const struct pci_device_id *ent)
 {
 	struct device_node *node;
-	struct fwnode_handle *fwn;
 	struct thunder_mdiobus_nexus *nexus;
 	int err;
 	int i;
@@ -54,7 +53,7 @@ static int thunder_mdiobus_pci_probe(struct pci_dev *pdev,
 	}
 
 	i = 0;
-	device_for_each_child_node(&pdev->dev, fwn) {
+	device_for_each_child_node_scoped(&pdev->dev, fwn) {
 		struct resource r;
 		struct mii_bus *mii_bus;
 		struct cavium_mdiobus *bus;
@@ -106,7 +105,6 @@ static int thunder_mdiobus_pci_probe(struct pci_dev *pdev,
 		if (i >= ARRAY_SIZE(nexus->buses))
 			break;
 	}
-	fwnode_handle_put(fwn);
 	return 0;
 
 err_release_regions:

-- 
2.43.0


