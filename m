Return-Path: <netdev+bounces-147789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30359DBCE0
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 21:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1355BB2192D
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 20:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4894A1C302B;
	Thu, 28 Nov 2024 20:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKvLsRpz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5761B3933
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 20:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732825677; cv=none; b=lIWCh5WLOKUxXoFlxjdnQ+FdsVlHNF88FO1d8FQr7v0laS87TfiiaeIrkaywhPNPoqXSW6j8GXmbS0D/E3+ZYWw0Cl2S3UmA/+fVXNEDBN6xndV+WgVQ4IZtLl76nAQX7XOAohw0C8v7WpBVVLI0dezfgv2UTPSVKNE3CHfISNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732825677; c=relaxed/simple;
	bh=anpGhFH1NdArbWrj7Yvc9daLlhDSfr3Wj9ecMSsmPwg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PS2sSkrM8NjjZVyUxLTCui+I7qeiBgiHbwgwd/iZi1/8RS3ZkqOVsgiHAOXofXpvCh93rG0Okk2mQDB0/06gW9K/SAEowzqq1jxbM17qQQlQcMH4jENZTQys9Ni0PL8jeNs+u/aL7+XXfy6DjJOda8NNFQZG3qfbYOdcrGEtM74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKvLsRpz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a1fe2b43so10662975e9.2
        for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 12:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732825672; x=1733430472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VyGJcOUL4RWiU3AIrG5CvRh+phEgBhZ3OEB8JPUvRck=;
        b=kKvLsRpzx4lF8LL/FmXADnFJmlENTz4TCH1OVYUbKrkw/pwB4b7KxwamP2oayp0ZXk
         l17YN0Tc+R+0hQiwHANLDbAEjcXktHab0XG9Fp+qOIpVuWQS8+s8szbroGTEFUCkZ1Lh
         ao9nXf41k0bQ/p2H7cBXTzd9olUAg1jbN4RQxLtBd5z4ZmRT6Xvkk9bJEX6J/1mfOaKQ
         NPm5YIN6oos4cJKMYgVixBynSCuh03548Q0hktIyYDSJlCUeq9RIUc6XtzKNmcVdu/hi
         MvixGDdszJYLtb4NnZqsU7s3HqRawOq7euadqHn2zdjZrYvMiGGm7Vps0L6JjcwgSL38
         Qqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732825672; x=1733430472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VyGJcOUL4RWiU3AIrG5CvRh+phEgBhZ3OEB8JPUvRck=;
        b=eyeOGTGSez/NOg+MiG0W0wDKB8TnpiNrvrS7XEogAGaPMtSqqSiwRwaciahV5iz2TP
         a+TD+PslE2hFB9riUu3mL2bDU/1Zi98P1gfCmrQ8K586FQ41NlAYnFD4sO3f0aO3UmpT
         wpkqhpVowEZ3MhAPqJR7FSLOiLtqheELaqaV4pJY7CIqVZdg2FybB7QbQNKBR2t2xZGk
         ynxJ9ABzXuvgeeRh3/vVIxTRoGFrilqrp/O7qsLhUEDv2QJswB2KOiGSJFqa8hsI6M3U
         D4SY6ZgjmCLxk9JxJsEHp7RSLQDb3YLGMeCETVlvjx48pdY86IaxRW5+h0eCqV/2xIrS
         iVfg==
X-Gm-Message-State: AOJu0YzaEy2vnXYI5Zgy9ov+VdtLx6L7vje37wmoxt/BDx1PiWTBPLjC
	JaUdrb+h0MsQrd8iS4nRG3Vc/bWmcc51JSQtQ2ERt7xB8+RmGPvKtB3ZJtPz
X-Gm-Gg: ASbGncsBfK0txhP8LaMTXd/q0QeC/4t/NyLg049BfmPnjH6ZBCFKNLOuzk9YxUaI+38
	u4GJ6IaICTiJydgRFzaP4th4dFrRNYSGfjNikoDaBbHDmTSZ2E54Sz19E78pEHdisddXPrn3Cjl
	Hqe85wsHg7SapCZspeq8TX3IYuUe1Q1sNH784VVEmRGyQvLf/6ZfSscl7poFMTpFuQZQmUO6T+U
	ab0gzsCEdTGqnnSNe7gO2C/VKKHYbddshdbAGUgwjzByXJ1tjnEfi2e8qSkvW2lZnwGLf/TUaRI
	giPpoI6+6dsKY5t3+D2NCsOcz5OV3l+sQ3JLKPUEpVRyLQ==
X-Google-Smtp-Source: AGHT+IExTfQ0fAmjLbWDpLM+u1VPi1IqAtPAcPtZrpCSM+Y6laoCBODRSFkuTLvf/2rFeZkyV1NN1A==
X-Received: by 2002:a05:600c:510c:b0:434:a902:97d0 with SMTP id 5b1f17b1804b1-434a9df21f4mr73908205e9.29.1732825671760;
        Thu, 28 Nov 2024 12:27:51 -0800 (PST)
Received: from KJKCLT3928.esterline.net (192.234-180-91.adsl-dyn.isp.belgacom.be. [91.180.234.192])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd801e9sm2457560f8f.103.2024.11.28.12.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 12:27:51 -0800 (PST)
From: Jesse Van Gavere <jesseevg@gmail.com>
X-Google-Original-From: Jesse Van Gavere <jesse.vangavere@scioteq.com>
To: netdev@vger.kernel.org,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Jesse Van Gavere <jesse.vangavere@scioteq.com>
Subject: [PATCH net] net: dsa: microchip: Make MDIO bus name unique
Date: Thu, 28 Nov 2024 21:27:43 +0100
Message-Id: <20241128202743.15248-1-jesse.vangavere@scioteq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In configurations with 2 or more DSA clusters it will fail to allocate
unique MDIO bus names as only the switch ID is used, fix this by using
a combination of the tree ID and switch ID

Signed-off-by: Jesse Van Gavere <jesse.vangavere@scioteq.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 920443ee8ffd..0d5dbbdd41f8 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2550,7 +2550,7 @@ static int ksz_mdio_register(struct ksz_device *dev)
 		bus->read = ksz_sw_mdio_read;
 		bus->write = ksz_sw_mdio_write;
 		bus->name = "ksz user smi";
-		snprintf(bus->id, MII_BUS_ID_SIZE, "SMI-%d", ds->index);
+		snprintf(bus->id, MII_BUS_ID_SIZE, "SMI-%d-%d", ds->dst->index, ds->index);
 	}
 
 	ret = ksz_parse_dt_phy_config(dev, bus, mdio_np);
-- 
2.34.1


