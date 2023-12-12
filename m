Return-Path: <netdev+bounces-56614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3113380F9FB
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 23:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3531F21484
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 22:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D78764CE1;
	Tue, 12 Dec 2023 22:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GPB73mA3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BEBB3
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 14:13:15 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ce972ac39dso4103127b3a.3
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 14:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702419195; x=1703023995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zz+Y7OFi5O5xALvZiSlWGcTk94UQ+2tG5uPBEil1mKc=;
        b=GPB73mA3KLi4f9uNLtezlYvZ8bMAJ9GNgzvIGJjvSHR3t5bv/uh4JktQXcEwHLYIXk
         y177Hs4uMQQg2Y3iJ6UnOhmF2p1qAw9A0ZgTEOYk7nap0QsS5N/aBGJ7Q2THHNVBwcAD
         waO+FYSd2lyrG8hF4LTFiRsWlIfJJwPLT/K6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702419195; x=1703023995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zz+Y7OFi5O5xALvZiSlWGcTk94UQ+2tG5uPBEil1mKc=;
        b=uatz+YaekMYu2GWdOAvdR3u+HRF5GbVAahcLOyiFx3VCDHc77SjWRvfTRunZddbGv1
         ALvMj9rWGeZuWQk732EhhvHwkO4L4kQXdMObwklR2Cznm+6yW07FFm29ztxrUME60Sh6
         q7CC0c6R7liuF3R1Tai2RQF6ZhfVinajsj6NzvDVk2RePA0NhY7JXftUSTFNKKSWrJU3
         B3u6EDzfYyqABfuzAEvi9Hrxt852hsQdPWsNZDyO74k6EqZEfZD9FwMVbscq7XfkcH0U
         1VbbVxdKt2zW8aQELEuqE4zVGUDt7vWQZQPbePvddqZMXOAT2vTawiMDS4ZbmtLG89qy
         WrUw==
X-Gm-Message-State: AOJu0YyRFQ8LQwbbO1GcBsp46W7kp5f822GVv9DZBKm6sDkGXWZQu0NK
	16WoSlbMeSaUiZLhR9ULcQBRyg==
X-Google-Smtp-Source: AGHT+IEWBKRXGUYKGQlw/ie1e8izpaxG2e22iJf+rKDEmrtEqp67ZIhooSrIcuGmEgZ+sAjKFUS5Uw==
X-Received: by 2002:a05:6a00:398c:b0:6d0:99da:3d35 with SMTP id fi12-20020a056a00398c00b006d099da3d35mr2585995pfb.42.1702419195217;
        Tue, 12 Dec 2023 14:13:15 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t27-20020a056a00139b00b006cd08377a13sm8588242pfg.190.2023.12.12.14.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:13:14 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: Kees Cook <keescook@chromium.org>,
	kernel test robot <lkp@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] amd-xgbe: Avoid potential string truncation in name
Date: Tue, 12 Dec 2023 14:13:12 -0800
Message-Id: <20231212221312.work.830-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2121; i=keescook@chromium.org;
 h=from:subject:message-id; bh=0SDaP7ngg2pX0pwKb/HXuBG4QGzcvWu5mlfJ4RHu8Zk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBleNr4UaAfdD0Y2y5yQf7Jeyn1JWreRU2mq7NQo
 QbLQgl8hTmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZXja+AAKCRCJcvTf3G3A
 JghBD/4uiMgovzu3/1hYGRlACubDv9q2+Kux+qaJ3L5hFEg9NnCi4mRKBDkQ6Bn+/NIwUV+xhUy
 0fx2ZmBMdIp6hclimldAs8Jiw0QnsFR4J4/4LMalltpdilZvi8Rwjz0/H66WbE8/Ny2Qz9EUZsg
 xChbel3UWk/FB4EVyXZe1mGSeY4ZaNr/LF5JMKm5x34+7VOzDq7N2SxixbkG+HNm8VexdHhCNrV
 6XZmUB4YKCO4DIZMGHo/wn3RVlAfTjmJghAqLvNyePo+mt5SYaH6xmxBfvme39P0l3l1it+EGI6
 ieWT3a/jpcr6laME+sdkAGhX85Hn4aw79ke7KcS/v2fvuLsrQDM/XwWjATeuDIMVYIxSFYDWoZN
 tgUgxO6a2RwtcmC9JB35mAIheKAtHL8KZmffQc6fHORc0xQpdacJfM94B6/JP6r9VFU/MKMbd2J
 CUwUSb1Kka684PSvO1BhDA7+Jnztn3Vf0czVDI11LqtiBl5W76AaRenfpL584xGlTyaA3TzA3Wf
 JpCQdoFmhtK95c4AHPTOU4yFKi7/PXJSmqUOT9ahKsYoRuyH2/wS+8FhENxqHP1q4kI1nF2+k1g
 e51oAMUeMr5X+CHKYekW6k2Rw2bt/zbTviYO0pgr7W2iDuK9r4tRVMJ0iApYeozQQ41+JmAUGrB
 U+jyEDr hdGGCquw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Build with W=1 were warning about a potential string truncation:

drivers/net/ethernet/amd/xgbe/xgbe-drv.c: In function 'xgbe_alloc_channels':
drivers/net/ethernet/amd/xgbe/xgbe-drv.c:211:73: warning: '%u' directive output may be truncated writing between 1 and 10 bytes into a region of size 8 [-Wformat-truncation=]
  211 |                 snprintf(channel->name, sizeof(channel->name), "channel-%u", i);
      |                                                                         ^~
drivers/net/ethernet/amd/xgbe/xgbe-drv.c:211:64: note: directive argument in the range [0, 4294967294]
  211 |                 snprintf(channel->name, sizeof(channel->name), "channel-%u", i);
      |                                                                ^~~~~~~~~~~~
drivers/net/ethernet/amd/xgbe/xgbe-drv.c:211:17: note: 'snprintf' output between 10 and 19 bytes into a destination of size 16
  211 |                 snprintf(channel->name, sizeof(channel->name), "channel-%u", i);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Increase the size of the "name" buffer to handle the full format range.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312100937.ZPZCARhB-lkp@intel.com/
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/amd/xgbe/xgbe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index ad136ed493ed..f01a1e566da6 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -495,7 +495,7 @@ struct xgbe_ring {
  * a DMA channel.
  */
 struct xgbe_channel {
-	char name[16];
+	char name[20];
 
 	/* Address of private data area for device */
 	struct xgbe_prv_data *pdata;
-- 
2.34.1


