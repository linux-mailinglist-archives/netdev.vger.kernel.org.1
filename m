Return-Path: <netdev+bounces-59148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D9B8197CB
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 05:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BEB7B23714
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 04:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC4BBE67;
	Wed, 20 Dec 2023 04:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1zIN2rv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5773BFBE0
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 04:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6d3954833a5so3650765b3a.3
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 20:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703046441; x=1703651241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ns3U1k2Kf5WNNFQJw8Us2ohwM1XZy5f/61UY7y/kKs=;
        b=C1zIN2rvqeHsGkgumPl3unB2/drB+mqxv10dGJZQYBC1bA1wQKJsWmfDrK2FqoW0An
         7p0ZDoK8itIpH0O5Nz3DejEzheLa6yxCMdZOtbNgOzcWUCv7+nwE2JRB+/Jmm5UlMMNq
         WhUjOxsjX/oL9jzHvd1Urp0Rw7m3pgCUxCtWgy1I8Bv4DvMJRXuFSsoigY96iWBTfR9h
         cHD88WkJc37AZRi6emMYySNqHP7W31Ps2m5QSneaGmrJX7P2eL0vAkdrQ/JTPBoxBVjm
         xTgOS0B+21yF2tHkPC/RVXst6XJTqubm7KdkoJItJSnd3vCW9+UTXXQE9/uOmAxfwnXr
         RfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703046441; x=1703651241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ns3U1k2Kf5WNNFQJw8Us2ohwM1XZy5f/61UY7y/kKs=;
        b=vpCVXxeJEqQZydhPjHmlY270J4SFybdQ3FN891Ad+ENOn0pfvJmf4GZZenjzFcV4gA
         r+8tDqUJ/r55RJymQNA2iH+bONJr0XQyembXIPBVW9kNEPI5j6T/epKx9Y/epDoqAVNz
         A8Z4JNSyPO4K5CIQNwbBHSYv+Xs/AmbZ7Zg5Inp1oIojR8rdcfejQnF3X9QS3oGD4/1b
         Q1kU6270zln2sb40yfRSd6yH00DMi3MvcNjts6dK/wtJpW2Hj1Z3Ou5315vTPOezVMxd
         s8gOjew3D/y4GVHoRrV97KvTOGabA8QJHkR5gwIIhfZYRf92q1zxsTD1VgU/z1ubhxOI
         QFng==
X-Gm-Message-State: AOJu0YzQFKOZjwef8KLeX51HtrDHa8rNYxkEyhgeAfWHWQ9ftETBI23I
	YDuytgudCQWkdm2U3YEqNGL2lKEThJTSgDsy
X-Google-Smtp-Source: AGHT+IHCV7xNl2UEFPF4YUvchnU50miAdZAqEwBqPQPy0T/ghuPGss3HN3XN3f8BXqDUVWIMaHxu7A==
X-Received: by 2002:a62:bd0d:0:b0:6d2:65ba:cf49 with SMTP id a13-20020a62bd0d000000b006d265bacf49mr9273150pff.60.1703046440695;
        Tue, 19 Dec 2023 20:27:20 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id ei3-20020a056a0080c300b006d46af912a7sm6325554pfb.23.2023.12.19.20.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 20:27:19 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	arinc.unal@arinc9.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH net-next v2 7/7] Revert "net: dsa: OF-ware slave_mii_bus"
Date: Wed, 20 Dec 2023 01:24:30 -0300
Message-ID: <20231220042632.26825-8-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220042632.26825-1-luizluca@gmail.com>
References: <20231220042632.26825-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit fe7324b932222574a0721b80e72c6c5fe57960d1.

The use of user_mii_bus is inappropriate when the hardware is described
with a device-tree [1].

Since all drivers currently implementing ds_switch_ops.phy_{read,write}
were not updated to utilize the MDIO information from OF with the
generic "dsa user mii", they might not be affected by this change.

[1] https://lkml.kernel.org/netdev/20231213120656.x46fyad6ls7sqyzv@skbuf/T/#u

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 net/dsa/dsa.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index ac7be864e80d..cea364c81b70 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -15,7 +15,6 @@
 #include <linux/slab.h>
 #include <linux/rtnetlink.h>
 #include <linux/of.h>
-#include <linux/of_mdio.h>
 #include <linux/of_net.h>
 #include <net/dsa_stubs.h>
 #include <net/sch_generic.h>
@@ -626,7 +625,6 @@ static void dsa_switch_teardown_tag_protocol(struct dsa_switch *ds)
 
 static int dsa_switch_setup(struct dsa_switch *ds)
 {
-	struct device_node *dn;
 	int err;
 
 	if (ds->setup)
@@ -666,10 +664,7 @@ static int dsa_switch_setup(struct dsa_switch *ds)
 
 		dsa_user_mii_bus_init(ds);
 
-		dn = of_get_child_by_name(ds->dev->of_node, "mdio");
-
-		err = of_mdiobus_register(ds->user_mii_bus, dn);
-		of_node_put(dn);
+		err = mdiobus_register(ds->user_mii_bus, dn);
 		if (err < 0)
 			goto free_user_mii_bus;
 	}
-- 
2.43.0


