Return-Path: <netdev+bounces-14713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F35BF743487
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 07:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83DF280FBA
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 05:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126F720F1;
	Fri, 30 Jun 2023 05:45:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F6E1FDD
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 05:45:12 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8246D210B;
	Thu, 29 Jun 2023 22:45:10 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b5d7e60015so1237213a34.0;
        Thu, 29 Jun 2023 22:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688103910; x=1690695910;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rxE6+xTz2tqqBsWHSgiwN60HDBL08f/KA1Z7sQobPE=;
        b=ZvWt3sDFjaKbdCi6UFjX3GsXxUURS6wF6iQvXB3cj8ma4aNiO3IfRXcas+dgHd90La
         Z5gQ/vp5HEbHhmRkLE2RO1zTY08SyHwIO78zKW0YArZJPFvCapypftpWGEHY80vKFfrR
         uGrwSrHB7pq9ehY5G6la1yHvYToBCJqbzA2KAt1Bxm9DxEG0VY23u3/83J6JfUKE6Z2C
         nXt5cnF4EiyzxfZSJoTsc2LVwa1qMUHXE//TurGN4YLpg2bHRtkPyc7uB8uZtHFtMJFs
         HJc/pDEm/MDu6cAknZerGc/IUUsSvK6TLoE2tkLHM1C9vgt4GIGNDIs2z2BEq7OLFB8W
         kjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688103910; x=1690695910;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rxE6+xTz2tqqBsWHSgiwN60HDBL08f/KA1Z7sQobPE=;
        b=IQyBTv9k/mEV5Rh2VXNH/S3ej2yxebNgC2gJc649E6dab2EpHkAXHKGF1KcJFHzzLe
         57eUfCxiyeqXJ/6ZMmK0PlrUThZ7zaG9LDPMXnpT9Li6tDNhWiWHi5pva6X10YiG/bIa
         6lkdECDqXPEdQLjBEies9eeBzMNTzlmBc0kgTiECOz2N7DMdboCtWm3gcgPNBTgl5jlx
         hpGDLpHf0qlIjRxlWWqfiX47nE0yFeAU5gx4eN97RjU5Q4GOgXGPGoV2YS3eRK82i5d5
         CV4T5KOYp6qoXBn1ssLTsRm8NNE+8yHlDiIQXQaUS5JQoquSs5n6R8Gkr5fwduohIB8o
         5RRw==
X-Gm-Message-State: ABy/qLZDCkoYs4nnSuzOUX/AknqcXaMAHDni7a9yFI5AVt0pKcyFfG4G
	cqRy+RqLuk/lJHbf//p+EMU=
X-Google-Smtp-Source: APBJJlGixCnoM8Teh3XpTq2NIL4AyjncvpdG4H9/Or9vgbgMjiYwcDgt6QoJTfyhpInAdyaRFZtY2g==
X-Received: by 2002:a05:6358:e822:b0:134:e631:fd2b with SMTP id gi34-20020a056358e82200b00134e631fd2bmr1755482rwb.0.1688103909709;
        Thu, 29 Jun 2023 22:45:09 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([183.242.39.186])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902b08c00b001ab061e352bsm9917647plr.195.2023.06.29.22.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 22:45:09 -0700 (PDT)
From: Zqiang <qiang.zhang1211@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	qiang.zhang1211@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: Destroy previously created kthreads after failing to set napi threaded mode
Date: Fri, 30 Jun 2023 13:43:53 +0800
Message-Id: <20230630054353.28934-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

When setting 1 to enable napi threaded mode, will traverse dev->napi_list
and create kthread for napi->thread, if creation fails, the dev->threaded
will be set to false and we will clear NAPI_STATE_THREADED bit for all
napi->state in dev->napi_list, even if some napi that has successfully
created the kthread before. as a result, for successfully created napi
kthread, they will never be used.

This commit therefore destroy previously created napi->thread if setting
napi threaded mode fails.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 v1->v2:
 Set napi->thread pointer is NULL.

 net/core/dev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 69a3e544676c..6125a1b1e019 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6317,10 +6317,15 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
 	 * This should not cause hiccups/stalls to the live traffic.
 	 */
 	list_for_each_entry(napi, &dev->napi_list, dev_list) {
-		if (threaded)
+		if (threaded) {
 			set_bit(NAPI_STATE_THREADED, &napi->state);
-		else
+		} else {
 			clear_bit(NAPI_STATE_THREADED, &napi->state);
+			if (napi->thread) {
+				kthread_stop(napi->thread);
+				napi->thread = NULL;
+			}
+		}
 	}
 
 	return err;
-- 
2.17.1


