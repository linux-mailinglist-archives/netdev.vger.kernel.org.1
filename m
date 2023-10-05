Return-Path: <netdev+bounces-38187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D05E7B9B57
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 09:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 0BB18B208B6
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 07:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BC7539E;
	Thu,  5 Oct 2023 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEW7mgEc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687E97F
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 07:24:00 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33307AA1;
	Thu,  5 Oct 2023 00:23:58 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3af5fd13004so467753b6e.0;
        Thu, 05 Oct 2023 00:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696490638; x=1697095438; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SpoM/4Lw1qX7rpq90xB1eHbXwAM5dafArV69o28vkw=;
        b=DEW7mgEckJHtCv2eqywyAkRvJp8xY/oqyB8XZ6LYVvoutK5smitjfGubQ05Ktte4fK
         vauwBBToJJvgnO7DbYEYI+39uEh3juooRIQVM8Z1pOn5JIixp4P4IG3NiDcD6o++vG99
         jxz57FHtteWRcwtPvRfCP0GgEEA8drXJiWJkeSwEO7jVeWwWoHZPLx2isPr5iF4529xr
         J1hvWszSNy1Yd34CydZrR/UeFbrtM/ZgAA7K/WYqPGVXglXHcqgXHx6POZiDj0wMDG1T
         ENp6vNdvECj7wAxfJpbidydyypqcQiLoVDnLOFhd0+6uDswDX67PXtRjh3pDnCB1yMYO
         gi2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696490638; x=1697095438;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SpoM/4Lw1qX7rpq90xB1eHbXwAM5dafArV69o28vkw=;
        b=EcG9yE/QdHVRuuy7CiqcCTJhLpittFapPQNn+d36a+sj8PDaXIZgqHtiTtgYdMOxGn
         TZynIk0v/QGWXKfooKgal2Wd7G/+LsVghQ8hBWurU6iOAo7+J867GFHVuzYbrZMnRiuF
         OAqK634crNpD7Yx/dQjVuDtpw+PB+MJ8CP+wqTXvXXQqJIwp3tyxanuJcXiUNWlIVLDr
         Ldgiayk+Bol1hIpPYvW4eITQ9qnWEhk9/rssibVquEPa58VSVy/ekw7OV0xSg8jABEZ/
         HTlbz17P5JOVj8yIkvV4AaYd+KTzSL49ku48XXFixH5th/x3+XH3aVGoJZOFetW2OPbz
         zoAw==
X-Gm-Message-State: AOJu0YxrHuVf1wCVeeuGzmetIAu+PFRdKHYXGpicEfUi83bpLEIaxKF2
	PURW1918T4F3q9BdNFhjmNo=
X-Google-Smtp-Source: AGHT+IGU6DTqrzxv4ZgtgQ+QjS2xKrEKNu/SzTA8HhxBtlXWXaA4RrEI9a6v6iwWleFijvzR0xUBoA==
X-Received: by 2002:a05:6808:1594:b0:3ae:1254:ea8a with SMTP id t20-20020a056808159400b003ae1254ea8amr5773030oiw.41.1696490637874;
        Thu, 05 Oct 2023 00:23:57 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id g2-20020a63ad02000000b00584d035c08asm763911pgf.24.2023.10.05.00.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 00:23:57 -0700 (PDT)
From: Chengfeng Ye <dg573847474@gmail.com>
To: jreuter@yaina.de,
	ralf@linux-mips.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-hams@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH V2] ax25: Fix potential deadlock on &ax25_list_lock
Date: Thu,  5 Oct 2023 07:23:49 +0000
Message-Id: <20231005072349.52602-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Timer interrupt ax25_ds_timeout() could introduce double locks on
&ax25_list_lock.

ax25_ioctl()
--> ax25_ctl_ioctl()
--> ax25_dama_off()
--> ax25_dev_dama_off()
--> ax25_check_dama_slave()
--> spin_lock(&ax25_list_lock)
<timer interrupt>
   --> ax25_ds_timeout()
   --> spin_lock(&ax25_list_lock)

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock.

To prevent the potential deadlock, the patch use spin_lock_bh()
on &ax25_list_lock inside ax25_check_dama_slave().

Fixes: c19c4b9c9acb ("[AX.25]: Optimize AX.25 socket list lock")
Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
V2: add fixes tag

 net/ax25/ax25_ds_subr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ax25/ax25_ds_subr.c b/net/ax25/ax25_ds_subr.c
index f00e27df3c76..010b11303d32 100644
--- a/net/ax25/ax25_ds_subr.c
+++ b/net/ax25/ax25_ds_subr.c
@@ -156,13 +156,13 @@ static int ax25_check_dama_slave(ax25_dev *ax25_dev)
 	ax25_cb *ax25;
 	int res = 0;
 
-	spin_lock(&ax25_list_lock);
+	spin_lock_bh(&ax25_list_lock);
 	ax25_for_each(ax25, &ax25_list)
 		if (ax25->ax25_dev == ax25_dev && (ax25->condition & AX25_COND_DAMA_MODE) && ax25->state > AX25_STATE_1) {
 			res = 1;
 			break;
 		}
-	spin_unlock(&ax25_list_lock);
+	spin_unlock_bh(&ax25_list_lock);
 
 	return res;
 }
-- 
2.17.1


