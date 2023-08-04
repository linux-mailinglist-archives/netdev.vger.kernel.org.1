Return-Path: <netdev+bounces-24389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C0F77007E
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 14:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE7F1C2187B
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 12:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3C4BA4E;
	Fri,  4 Aug 2023 12:48:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB09BE4D
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 12:48:14 +0000 (UTC)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08ACF4EDB
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 05:47:39 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b9b5ee9c5aso32689281fa.1
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 05:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691153214; x=1691758014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j6bo7YAIJDA7TBCCdgRaQ0LwEZt1vJ23UYJuiriXq9k=;
        b=RdvLxuJ1vUOsIoNqIho+GvZOGBqBHsNyriP6U16yJKIgIh1efjek92p0X3dhDSVlgL
         W75jCxH3Clx/MlN2h4eQzj0/M+1x8DceKwjbwOqPkJwsEqIBaalL86VLkYiTRUYCMV0R
         bVkHc7Qs43E+gNZsP5WA2cvIu6z+kg/rVd4YC90U0T8JmsUvHTBEAaprLJ1/RNLIZVFK
         NLNowGMeja383hbtjB0iLAC9DdVcNEpdpTIb73Zttx75A0dTrZwDocFKHPr2kXWsreLO
         F0xr/+zODvukRFw2oFBp2/Yc+wTb3EVVeF54urxU/10/ctZT+ENx7RkkpUjG9+4TXvdu
         qkrA==
X-Gm-Message-State: AOJu0Yw4CN8cPFsYUh1WBoBBwZUz28LU73jcAde02WiytlLMxRuKmmIA
	76VxqZl8snvO8hHeDRWqZrc=
X-Google-Smtp-Source: AGHT+IFZ3SiMSn+66SCToEbI3wWd32kld6l/f7G+uDsqkG0PwAqW5T7dDFZmpnqodMnP/9xroXSLug==
X-Received: by 2002:a2e:b714:0:b0:2b9:e304:5f81 with SMTP id j20-20020a2eb714000000b002b9e3045f81mr1419708ljo.23.1691153214395;
        Fri, 04 Aug 2023 05:46:54 -0700 (PDT)
Received: from localhost (fwdproxy-cln-021.fbsv.net. [2a03:2880:31ff:15::face:b00c])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906504300b0099329b3ab67sm1268269ejk.71.2023.08.04.05.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 05:46:53 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: rdunlap@infradead.org,
	benjamin.poirier@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v4 0/2] netconsole: Enable compile time configuration
Date: Fri,  4 Aug 2023 05:43:19 -0700
Message-Id: <20230804124322.113506-1-leitao@debian.org>
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
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
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

Breno Leitao (2):
  netconsole: Create a allocation helper
  netconsole: Enable compile time configuration

 drivers/net/Kconfig      | 22 +++++++++++++++++++
 drivers/net/netconsole.c | 46 +++++++++++++++++++++-------------------
 2 files changed, 46 insertions(+), 22 deletions(-)

-- 
2.34.1


