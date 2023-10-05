Return-Path: <netdev+bounces-38419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B48F7BABA2
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 22:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 87B451C208A3
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 20:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F4C3CCE7;
	Thu,  5 Oct 2023 20:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xG+CTsJT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6C737165
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 20:51:45 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9004895
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 13:51:43 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c0dd156e5so21166747b3.3
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 13:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696539103; x=1697143903; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pWpal7Doqq48f7+hvv3YlQfRBTUj+OxMigJ6y40qk1g=;
        b=xG+CTsJTTp+oaimkbFjqus/BKGf8TqNesqXt/WXK02iGj+0jNuNqx68rDw+nVpaPS1
         V9PZmIScV5m4mDEa72dLtZYhZsTC1wuSQIojR5uteUiZyR31B8okSDRgRY3cSarlM8I5
         u+ef1NxW6CA1qId1ztismbL+bUHCuAuwaTB4ZLpzT0ntY0fcoG68PdkAAkeyim9hzC8m
         /3gj4/jqGTgXepQLdC+pVYdVdRDphoBel7HxVciyCBKyXV6zsg1WwRoUWZiRA/b+fcvZ
         tHM3uA9Oq5D9irU5YdzgE5Nj+lXXPvIG0OH32Zr98y5XyNjI2/RfJWYvYm8mdxkL8t/H
         kRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696539103; x=1697143903;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pWpal7Doqq48f7+hvv3YlQfRBTUj+OxMigJ6y40qk1g=;
        b=VnWzFozq2h1dNOT8uKWBbDvKmMLvXUxosZGfrQt8bOXfoQqbTRh6HSD3awO5BmXPCC
         5r3xzcvqjYsySqChXXgcuMY3hugLwhMa50H1TsqvI2lHBL8/W3mrap485eN7xp/hY7nv
         k1eY/L8hiCcF7eF4RwH/pHCsfHq2rXmPaN2Qpx+gG0n9kI14fXpsjqSrnN+0QeCassdl
         EhNMh9eWjbKjr+vimnG6gQCXat0XOsmMqjJTeGt97REvQ21G911HEwoJ7ZymQ3ZDzkwW
         5lZXGLQD0HHnP3XDvsKY+VxFSdYS3DKg2iW1sBawnIKM9WPpF8xQhoHBZSQZKx3Ld4MN
         0xXA==
X-Gm-Message-State: AOJu0YxMRUPBQfFHIucPENcxTRf/y/Je+8q3RnmFnAyF9NVXdLoKHTXN
	U/+aDNhDAdWWSOB1cDxD3K5GhY45mCvw2+EMgA==
X-Google-Smtp-Source: AGHT+IGqcipxr9mLYWAXnLc/UolSpoC3KLcNCHXG3TB8SdXjwnoEzD0TUipTTDv2sPCy+uHcy/NIrlZhpW1v7T7Rdg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:8d46:0:b0:59b:ec33:ec6d with SMTP
 id w6-20020a818d46000000b0059bec33ec6dmr120908ywj.5.1696539102785; Thu, 05
 Oct 2023 13:51:42 -0700 (PDT)
Date: Thu, 05 Oct 2023 20:51:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANshH2UC/x2NQQqDMBBFryKz7kBiqtBepZQSJ9M6CxOZBEkR7
 97Y3Xtv8f8OmVU4w73bQXmTLCk2sZcOaPbxwyihOfSmd9aYAXPRSOsXg8rGmjFyQS4z6wmTJh8 oLTjRMrpaX3xWQuNvAwXn7HU00KZX5bfU/+3jeRw/mVzKc4YAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696539101; l=2256;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=HxayhA1aIuyooSvwu5FkzbNfRLctZ8S9IVA9YM7wlQ4=; b=cNbM0i4jK1A3lEG+pC81fjLHqpJikLXzKR/UUwfLOkhbplaGtwiOVGPOSKdIomtH14tQ9TAvl
 +Iyswe7yIH0DdajsI7UZ9M2Jp/MQSYuZlg9bAaeb5E2g3FXhQMaWt5V
X-Mailer: b4 0.12.3
Message-ID: <20231005-strncpy-drivers-net-ethernet-broadcom-bcm63xx_enet-c-v1-1-6823b3c3c443@google.com>
Subject: [PATCH] bcm63xx_enet: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

A suitable replacement is strscpy() [2] due to the fact that it
guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

bcm_enet_get_drvinfo() already uses strscpy(), let's match it's
implementation:
|       static void bcm_enet_get_drvinfo(struct net_device *netdev,
|       				 struct ethtool_drvinfo *drvinfo)
|       {
|       	strscpy(drvinfo->driver, bcm_enet_driver_name, sizeof(drvinfo->driver));
|       	strscpy(drvinfo->bus_info, "bcm63xx", sizeof(drvinfo->bus_info));
|       }

Note that now bcm_enet_get_drvinfo() and bcm_enetsw_get_drvinfo() do the
exact same thing.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/net/ethernet/broadcom/bcm63xx_enet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index a741070f1f9a..8b18493759bf 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -2531,8 +2531,8 @@ static int bcm_enetsw_get_sset_count(struct net_device *netdev,
 static void bcm_enetsw_get_drvinfo(struct net_device *netdev,
 				   struct ethtool_drvinfo *drvinfo)
 {
-	strncpy(drvinfo->driver, bcm_enet_driver_name, sizeof(drvinfo->driver));
-	strncpy(drvinfo->bus_info, "bcm63xx", sizeof(drvinfo->bus_info));
+	strscpy(drvinfo->driver, bcm_enet_driver_name, sizeof(drvinfo->driver));
+	strscpy(drvinfo->bus_info, "bcm63xx", sizeof(drvinfo->bus_info));
 }
 
 static void bcm_enetsw_get_ethtool_stats(struct net_device *netdev,

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231005-strncpy-drivers-net-ethernet-broadcom-bcm63xx_enet-c-0a95cd331460

Best regards,
--
Justin Stitt <justinstitt@google.com>


