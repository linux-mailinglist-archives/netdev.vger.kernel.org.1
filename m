Return-Path: <netdev+bounces-116349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5715B94A176
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 09:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E901C25262
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 07:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E0A1C57B9;
	Wed,  7 Aug 2024 07:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Nv2bdrY4"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DE51C57B5
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 07:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723014951; cv=none; b=tbJSwQ3uyFQpUSEJI7dfiPfUaKXBxE5UrOh4Pzhx/QnRAA177lJ3C5pLtOI/2YqLsmT1WETMzPQ4HaV9I0+2M7lK1AH/fcI/LgRR33/dYqip/oCR4YO7uYUqAMoUXySU6gAHb6ItPUQoIGBQ/t1wg5cdzPsotrz5FA8Mvw9VPno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723014951; c=relaxed/simple;
	bh=T5AV4a11rtMSAytmCylivYC3pIAGCVfX8OV2QuOrQ5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P2BtjqP9glj9W75WRmVdNjSP58jOUH34LRA+mouTLZnDZlhc0QbBcOfr5rRAFIVzLvDH1UjmcnXPpZ94FdLFgjCFgsAxG5ZRdQVVsdQeWHHFgbVVr1/8XKboAIXuiFOPvFjStGVv+WYPt5ykmnCigGXrNE4dY9Xo8kG4fne6EXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Nv2bdrY4; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723014939; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=evbp18FP6Oo1Q+h+lmD8I1erPWYjO2m522HZcbeIH2w=;
	b=Nv2bdrY4Av53QV2lW6SwRrxwQvLHnhe4QBxkF7u01Jbu7HaX/DFv974AvptUmC89/LczKstXzP++hDvw9C/i6gYIaEEejR0uFMqWbWV2qPKpc1it3pObwIFsi1P2wlhDWJrQIUu7pRtOFqFT2jJgVsK0U4RQntqlNL0bjK9C+4w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WCHxngA_1723014938;
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0WCHxngA_1723014938)
          by smtp.aliyun-inc.com;
          Wed, 07 Aug 2024 15:15:39 +0800
From: 'Guanjun' <guanjun@linux.alibaba.com>
To: kyle.swenson@est.tech,
	o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	thomas.petazzoni@bootlin.com,
	netdev@vger.kernel.org,
	guanjun@linux.alibaba.com
Subject: [PATCH net-next 1/1] =?UTF-8?q?net:=20pse-pd:=20tps23881:=20Fix?= =?UTF-8?q?=20the=20compiler=20error=20about=20implicit=20declaration=20of?= =?UTF-8?q?=20function=20=E2=80=98FIELD=5FGET=E2=80=99?=
Date: Wed,  7 Aug 2024 15:15:38 +0800
Message-ID: <20240807071538.569784-1-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Guanjun <guanjun@linux.alibaba.com>

bitfield.h is not explicitly included but it is required for FIELD_GET.
There will be a compiler error:
  drivers/net/pse-pd/tps23881.c: In function ‘tps23881_i2c_probe’:
  drivers/net/pse-pd/tps23881.c:755:6: error: implicit declaration of function ‘FIELD_GET’ [-Werror=implicit-function-declaration]
    755 |  if (FIELD_GET(TPS23881_REG_DEVID_MASK, ret) != TPS23881_DEVICE_ID) {
        |      ^~~~~~~~~
  cc1: some warnings being treated as errors

Fixes: 89108cb5c285 (net: pse-pd: tps23881: Fix the device ID check)
Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
---
 drivers/net/pse-pd/tps23881.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index f90db758554b..fa947e30e2ba 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -10,6 +10,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/bitfield.h>
 #include <linux/platform_device.h>
 #include <linux/pse-pd/pse.h>
 
-- 
2.43.5


