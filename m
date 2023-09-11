Return-Path: <netdev+bounces-32921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C741D79AB24
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 22:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88F31C20961
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 20:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F9A15AE4;
	Mon, 11 Sep 2023 20:01:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E8EC2E9
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 20:01:13 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEFF9F
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 13:01:11 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-414b3da2494so29915511cf.3
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 13:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1694462470; x=1695067270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/FpMmKl0bse3BMDgaQ2W2l2B7MkeGt45cjIQaol/41k=;
        b=DX9zfjjItB2OgggGfugQ9crDxu2DSXD0SPVU4PNzH+vBMvDcj8xbApFt9NKEAawxz1
         bTtQUhD2Hsqct4916Ua3TM4yBBHFSZqlovA02bRawFmMIlUPMzzIPWc7L5Pj6GtrLQe3
         FGX51R5aiRGp1nL3QXLs5UWxlDQVW1tXH0ejE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694462470; x=1695067270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/FpMmKl0bse3BMDgaQ2W2l2B7MkeGt45cjIQaol/41k=;
        b=jHNjtyX0u6NAgBglhzTv7WBK8wnmrOdrot2Fw9SgQZKO3rMb34EA1QunNcdNgOMFoU
         VFPpkIMnaYgLmP/sfEcueuwq5h9RCgU+qlInkxohS3GoLJltS6CO2UYqXWlRQ9HoTeAd
         7CP6X3QeT382KOvujNlpXNZ7cS8Qq1syetIiAANIHPMEjHAIAXKvwziT2uVA2Zj2qzGb
         c898hzAK7vizNy9bbkzhKB4mHIHCbstsxpRmjnaUfv/vMh6PToWpGL0Qh5ZV+HFx78d5
         k/4MPOlVc0J8oBd/Q0E7/hupl8Pm0UvitG1MIyFlKuHrgdy4UL6z1wWCMdT/AWuAkTTa
         Zlzg==
X-Gm-Message-State: AOJu0Yy4KqFwUWjHrTKxZ38aGGPbYZFsaoQUiqH06yXrdDTgCgCLowUs
	EtIRYWYhTEggsbpOWtxzGtGhVXB0yZ42FcPB+G9ysyQ/yTSbHmTRdHDB1MX17IQcFnY0RMvnfz9
	hpTeLxQL0A8x/w25xwV/gOMKx8yQsQZhjrI73xa492pC1hDHIWJZ2/92GH5PykCKJUxztvXI9Tb
	3Tzf6xxOR3rHw=
X-Google-Smtp-Source: AGHT+IGMuKpzVNcdHOp7QnJviKsxjhfzJKsrEda/K0F+Y7aKZacSYzyAS++cG9/oGorj1kJUqnzWIw==
X-Received: by 2002:ac8:7e82:0:b0:403:b9c4:b5de with SMTP id w2-20020ac87e82000000b00403b9c4b5demr12473934qtj.21.1694462470217;
        Mon, 11 Sep 2023 13:01:10 -0700 (PDT)
Received: from mail-ash-it-01.broadcom.com ([136.54.24.230])
        by smtp.gmail.com with ESMTPSA id jk10-20020a05622a748a00b004109b0f06c3sm959952qtb.36.2023.09.11.13.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 13:01:09 -0700 (PDT)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
To: netdev@vger.kernel.org
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Andy Gospodarek <gospo@broadcom.com>,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Prashant Sreedharan <prashant.sreedharan@broadcom.com>,
	Michael Chan <mchan@broadcom.com>
Subject: [PATCH net-next] MAINTAINERS: update tg3 maintainer list
Date: Mon, 11 Sep 2023 16:00:59 -0400
Message-ID: <20230911200059.7246-1-gospo@broadcom.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Andy Gospodarek <andrew.gospodarek@broadcom.com>

Signed-off-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Pavan Chebbi pavan.chebbi@broadcom.com
Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Signed-off-by: Prashant Sreedharan <prashant.sreedharan@broadcom.com>
Reviewed-by: Michael Chan <mchan@broadcom.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 612d6d1dbf36..5f52b2c47615 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4320,8 +4320,7 @@ F:	drivers/net/ethernet/broadcom/bcmsysport.*
 F:	drivers/net/ethernet/broadcom/unimac.h
 
 BROADCOM TG3 GIGABIT ETHERNET DRIVER
-M:	Siva Reddy Kallam <siva.kallam@broadcom.com>
-M:	Prashant Sreedharan <prashant@broadcom.com>
+M:	Pavan Chebbi <pavan.chebbi@broadcom.com>
 M:	Michael Chan <mchan@broadcom.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-- 
2.41.0


