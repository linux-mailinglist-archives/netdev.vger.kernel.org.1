Return-Path: <netdev+bounces-38163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 946207B995A
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 02:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3836A281C7E
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 00:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2FDEA6;
	Thu,  5 Oct 2023 00:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BaQ9d6uj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AA7182
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 00:56:17 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B17C1
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 17:56:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-594e1154756so5535537b3.2
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 17:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696467375; x=1697072175; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yS8Bb8q8kdoQqLbaTlLJ5dI+ywfic8t8uh1+wVPOGm4=;
        b=BaQ9d6ujiNiMxT8SflsFkzt0tk622nWZWBfE2j3no5QrHCY4OZlo4JWJhObUBPbqP5
         j0xhx8bBNpYlna0YTjgyk2zpqtqnAStGK3JdJpba95sUKzKkj6BT2mMYlhYIp9EoDxWY
         rtAZg3CaGsv0W/tuNPohQ/q5wThF8YEpsgzr0qUveWyq3QYuIzqOOoKyrBDa84VQ4CX3
         rqkw3u3QdqY0SF7lH+iIqQY11pw7janjRA9xvvrm3YEfUqO538kJK/gw9aoxZVhze92X
         QZigAZ/H27Xv4aNEuGvbyedZwwRhFgu/aC9Xh3z6QocdJ3IoYk9Inn0fG1O1QN40JmQj
         wkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696467375; x=1697072175;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yS8Bb8q8kdoQqLbaTlLJ5dI+ywfic8t8uh1+wVPOGm4=;
        b=dUSJQqCxA4HRA4GY47wrsg4Ved1zUhEED7YJFnphjuNzPQY7hgCdHW0yXzgHhQNGdH
         8Q8qKZVIXqJFEekH55exx3UhNe+zCsuNcpCSyNI0Cjcs+id2jum9JhQ76YNGBUTk8CHG
         D+WYgDDeiIaExD9z8bQJtLAw2kzyYKW2uMxDhsQ8XdjDuk0tSSmpAhDJBorbCBr+ibMh
         4J6RwjM999vTNvb3DezilhusAYi1HYf1ZCDgQdPB3d+ZOlb10LWuKfdPWuPAHNne/QdA
         kR3G9CZe9WVZAJwmMQQ7zmgdCGI+eCzadYehQ08dBOUVOFH8rOJDBiraxXorSFNmLNun
         Wzzg==
X-Gm-Message-State: AOJu0YyAX7c27fe5EjFFr+jC6hgq2OBvzUGZddy0LLtbWyIrQpMOD9/3
	lzByvLwKyXylr5Y3u6Y1Gb4ncJN//7SXRXcIug==
X-Google-Smtp-Source: AGHT+IEVa7B+vWdKYnaqa/ml6FmWGTTkWZOqn2AoIBcgUldlABHSkzBAkPS1IM01PDsKog9sABYRUJq5TjmKm/4TCA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:4d45:0:b0:c78:c530:6345 with SMTP
 id a66-20020a254d45000000b00c78c5306345mr51482ybb.7.1696467375122; Wed, 04
 Oct 2023 17:56:15 -0700 (PDT)
Date: Thu, 05 Oct 2023 00:56:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKcJHmUC/x2NwQrCMBBEf6Xs2YW0xij+ihRZktXuwW3ZhKCW/
 ruph4F57zCzQmYTznDtVjCukmXWBv2hgziRPhklNYbBDcfeuRPmYhqXDyaTypZRuSCXiW0v9KL vrMhKe+5NJa4YMUR/cd6HQHSGNr0YP+T9v72N2/YDecqbyIYAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696467374; l=1950;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=KCtAufgjQfpYF459amayClzlw1GlaQTMZbPkAkOzZV8=; b=kGMw+9Ze9IpgvGvYiqL18X42iKGg/7yLSWlDsNgalIPMRHTQZhWkM6xDbrRLpbd27XWyB08c0
 UeYN1Xxszo2BuMDzYK5TY23IPaGRM1+AeM2bdSL6SLiQenwlAvlN5lF
X-Mailer: b4 0.12.3
Message-ID: <20231005-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v1-1-ba4879974160@google.com>
Subject: [PATCH] net: ena: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Shay Agroskin <shayagr@amazon.com>, Arthur Kiyanovski <akiyano@amazon.com>, 
	David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>, 
	Saeed Bishara <saeedb@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

NUL-padding is not necessary as host_info is initialized to
`ena_dev->host_attr.host_info` which is ultimately zero-initialized via
alloc_etherdev_mq().

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index f955bde10cf9..3118a617c9b6 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3276,8 +3276,8 @@ static void ena_config_host_info(struct ena_com_dev *ena_dev, struct pci_dev *pd
 	strscpy(host_info->kernel_ver_str, utsname()->version,
 		sizeof(host_info->kernel_ver_str) - 1);
 	host_info->os_dist = 0;
-	strncpy(host_info->os_dist_str, utsname()->release,
-		sizeof(host_info->os_dist_str) - 1);
+	strscpy(host_info->os_dist_str, utsname()->release,
+		sizeof(host_info->os_dist_str));
 	host_info->driver_version =
 		(DRV_MODULE_GEN_MAJOR) |
 		(DRV_MODULE_GEN_MINOR << ENA_ADMIN_HOST_INFO_MINOR_SHIFT) |

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231005-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-6c4804466aa7

Best regards,
--
Justin Stitt <justinstitt@google.com>


