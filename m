Return-Path: <netdev+bounces-26705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A8B778A00
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 11:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149101C21764
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B549C6FAE;
	Fri, 11 Aug 2023 09:32:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B776AA9
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 09:32:08 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEA130E6
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 02:32:07 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-9923833737eso241230266b.3
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 02:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691746325; x=1692351125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=azW4yG0MdEIBUfoLx++Bfi2Dd3adbmUKrEXV+hxBmLY=;
        b=P6pnbwkI8cQ+769K0QYeQW9pSHkX/8uw+2cetnCbl+dTZoNdaYcb29UnobJ+uyjDfr
         k1EkcL1A0zGJ35fJnHaAv3lgxpReJt6Z29o8KyEVZ2YDlvMJOiy5dJvftoJfe+M+cTCu
         tKL/1hLeuTNy4FgnS4fdNFHiwH+ZD7i2hFEpg7MINaDYRvidFCuGGwuDyLcGgoXUuYjU
         gxuZwrFOEV5xRu4Ie6Jr2O3z2O81j0e5KdlRW/8iZzHQl2KhLTZnqbIrY6fbhEvPoe2K
         8kRRzNeGhAhFKa8krlfIQTcG3DzpBv5cxPxN9y+3bBNw8VIN4GAluMW/yBRWTLfKGWQS
         Bk/Q==
X-Gm-Message-State: AOJu0YyhraMbBlwwBIjVNcdlMkeqJQZpVaHwnwazu7mJzMlRgoQti0E1
	7RkdgXkKiDd4y2IC0NeS4pQ=
X-Google-Smtp-Source: AGHT+IHKHxzSg5vkjjAUIWRCiqa8z5iioVSMtBmWSLL1HU7DANHkyva6CNbtQm5Ne532uDm9qOyHqg==
X-Received: by 2002:a17:906:114:b0:987:5761:2868 with SMTP id 20-20020a170906011400b0098757612868mr1218105eje.11.1691746325144;
        Fri, 11 Aug 2023 02:32:05 -0700 (PDT)
Received: from localhost (fwdproxy-cln-006.fbsv.net. [2a03:2880:31ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id l27-20020a170906415b00b009886aaeb722sm1998615ejk.137.2023.08.11.02.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 02:32:04 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: rdunlap@infradead.org,
	benjamin.poirier@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Subject: [PATCH net-next v6 0/2] netconsole: Enable compile time configuration
Date: Fri, 11 Aug 2023 02:31:56 -0700
Message-Id: <20230811093158.1678322-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Enable netconsole features to be set at compilation time. Create two
Kconfig options that allow users to set extended logs and release
prepending features at compilation time.

The first patch de-duplicates the initialization code, and the second
patch adds the support in the de-duplicated code, avoiding touching two
different functions with the same change.

  v1 -> v2:
	* Improvements in the Kconfig help section.

  v2 -> v3:
	* Honour the Kconfig settings when creating sysfs targets
	* Add "by default" in a Kconfig help.

  v3 -> v4:
	* Create an additional patch, de-duplicating the initialization
	  code for netconsole_target, and just patching it.

  v4 -> v5:
	* Remove complex code in the variable initialization.

  v5 -> v6:
	* Return -EINVAL for invalid configuration during
	  initialization.

Breno Leitao (2):
  netconsole: Create a allocation helper
  netconsole: Enable compile time configuration

 drivers/net/Kconfig      | 22 ++++++++++++++++++
 drivers/net/netconsole.c | 48 +++++++++++++++++++++++-----------------
 2 files changed, 50 insertions(+), 20 deletions(-)

-- 
2.34.1


