Return-Path: <netdev+bounces-130613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B497B98AE8B
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A98D282EF3
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC11A199FAF;
	Mon, 30 Sep 2024 20:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaPya4Fr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421DC15DBB3;
	Mon, 30 Sep 2024 20:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727728718; cv=none; b=KedbSfEDvMbkTjMsHfYRnhFpEqFw8m9eOt3bglisCyEWx3vb2vEK3NDVLOD6IBmrnw69X/5PsJMQp5rmLbp0FrhtZSwGfKlSDlNlooJF1Gdr82jVyX5KeykobrBhmfMCzo33j9YdK3Ytj+YgRUsFXdBsZqSQkdAcspokG/UuD3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727728718; c=relaxed/simple;
	bh=POQpNhU4/oDxEdB/nOtrC/gDSaQtFuJdS8J19VrEI+c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RzXRlqCEwHFpUEoyvQx8ODogdNJMd+yIYnme0JTWaJrGMAr2VWs5hvtbFlFmBya9X3soJfU5rHABqqzaEyqHE6P6CBfYor+IAtvkMe+qfGpyrcOlRAs6YvwH0T4xzv64TMnxsvVeXkwpe3IgtsKxiPPZIcXmxim385OAVSBVZQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaPya4Fr; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a86e9db75b9so906235266b.1;
        Mon, 30 Sep 2024 13:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727728715; x=1728333515; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RdVXsy7CY05Eox+5vtD1XhtKGCKw4Pn46XT8SlfYxTM=;
        b=AaPya4FrG58sotY4Pv87PGBEI2oaWYkVCU9/aLLfCgRwQlaCQcavAvvwJlN6AE3O5l
         VKVdq/n6T8iNVSzTHs1vtlpk1eP6hEmNzSspSoTp0816igVqbugrs97T8p31RJsJU9Se
         9qeTtwaOpoMC+ZKxtqPQTjHA8o9niPSaOlsL1sGvgmUgdSOMbR97tUjrn3B/tTs+dZQM
         WXKRwBuexqRnYDUDxozIRF9GdniKBccGZwxdDRIMq3Uc2gkyc9nuArM+9imxMhkN2vOd
         V4ylbJaihcaEBIqtiib0u3R/5OqBNsyUKDHkoK0JFGmMwz+Qk8XI+mX4+5AakyLXfTQv
         KRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727728715; x=1728333515;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdVXsy7CY05Eox+5vtD1XhtKGCKw4Pn46XT8SlfYxTM=;
        b=TTTxlUgnbW16mvD7a54MQdE6JZ3BGSaj37BAJii5e3nS9QT9cr+0W/AUeKGf8fz+Bq
         fMmDoaDa9tj5lSQ/c5bHFDIa3DddKDSxYTZc0yZa9SoI6S83OzcnFFoGNjtwRK3iGvjw
         aXhqfRX1iaOZmRc2+Xmh6ZmsYSmlnLiIKThGOMZoPnOmj5oW4vkMqo7rqtAiBXiMDRov
         3Mehw5sJgmVI9hvjAG+Xzkcw9YOk5nYVB7PaP/1WMsowPncfsouG55Ekeg64lgX/2CYc
         gOiWOS51y3g95LUGcZwwZy+dPnGipxMzTzBF+6bMiEeLqaN72oKaN3q9r+X8sM21rRYZ
         pmXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvutusum1kINmNr/nT97zz1TJUNtBq6M29zcXdrBAG93Dovx6Ojy/LHY/8QwsEce+TkGk+V0nqi2asNmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPPTyjBF1OiW7CaoxnGwyHtaEYOpRLEgdzO+QZLSwwBnuMNSPG
	fXDlhicbLjaKU9q28VJOQcJklVthHBVfVhUCCSAJPQ2DqsXXzCP0
X-Google-Smtp-Source: AGHT+IE5ATk1ll1mp8SR/D6n7QKnEKAmitZqrs4uP2pEz2ng2rIRiBrKXV6FMeS1kux53hhRTzRo1Q==
X-Received: by 2002:a17:906:730f:b0:a86:aa57:57b8 with SMTP id a640c23a62f3a-a93c4ab17b0mr1574969466b.63.1727728715247;
        Mon, 30 Sep 2024 13:38:35 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-91b0-e3db-0523-0d17.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:91b0:e3db:523:d17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c7184sm581377566b.83.2024.09.30.13.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 13:38:34 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH net-next v2 0/2] net: switch to scoped
 device_for_each_child_node()
Date: Mon, 30 Sep 2024 22:38:24 +0200
Message-Id: <20240930-net-device_for_each_child_node_scoped-v2-0-35f09333c1d7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEAM+2YC/5WOUQqDMBBEr1L2uykxFa396j2KBM1uzIImkohYx
 Ls39Qb9fMwwb3ZIFJkSPC87RFo5cfAZ1PUCxnV+IMGYGZRUpWzuUnhaBOaiIW1D1NQZp43jEbU
 PSDqZMBMK6qlSti7Vo6whb82RLG+n5w2/CU/bAm1OHKclxM95YC3O/E/XWggp+h6xto3Fqmxew
 9TxeDNhgvY4ji8vhFMx5AAAAA==
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727728713; l=1728;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=POQpNhU4/oDxEdB/nOtrC/gDSaQtFuJdS8J19VrEI+c=;
 b=PVJfsK/TyvY21Xk31eI8g1AtKX3+sYqWSVVxSvWLK8aUriyk+zO80749qyKLd2xcAUGNTDdXo
 81EaTiqVZMQBZ2imsHl/oRwzJC1CmZ9igapzdhgRHm3Dpex1rkjjXxU
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series switches from the device_for_each_child_node() macro to its
scoped variant. This makes the code more robust if new early exits are
added to the loops, because there is no need for explicit calls to
fwnode_handle_put(), which also simplifies existing code.

The non-scoped macros to walk over nodes turn error-prone as soon as
the loop contains early exits (break, goto, return), and patches to
fix them show up regularly, sometimes due to new error paths in an
existing loop [1].

Note that the child node is now declared in the macro, and therefore the
explicit declaration is no longer required.

The general functionality should not be affected by this modification.
If functional changes are found, please report them back as errors.

Link:
https://lore.kernel.org/all/20240901160829.709296395@linuxfoundation.org/
[1]

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- Rebase onto net-next.
- Fix commit messages (incomplete path, missing net-next prefix).
- Link to v1: https://lore.kernel.org/r/20240930-net-device_for_each_child_node_scoped-v1-0-bbdd7f9fd649@gmail.com

---
Javier Carrasco (2):
      net: mdio: thunder: switch to scoped device_for_each_child_node()
      net: hns: hisilicon: hns_dsaf_mac: switch to scoped device_for_each_child_node()

 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 10 +++-------
 drivers/net/mdio/mdio-thunder.c                   |  4 +---
 2 files changed, 4 insertions(+), 10 deletions(-)
---
base-commit: c824deb1a89755f70156b5cdaf569fca80698719
change-id: 20240930-net-device_for_each_child_node_scoped-ebe62f742847

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


