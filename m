Return-Path: <netdev+bounces-69193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A15C84A04E
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 18:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E909B25AD8
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 17:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7E93FE5F;
	Mon,  5 Feb 2024 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="CsT6uVuB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8D53B19D
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153082; cv=none; b=fVfoGGzPMQGWXxHxf9l15QmZg7K96mtoPjEG/egO16f9N4rQxp3OBdKhluklmfSe23A2/pyX5gipni/kdABahCP+QmbP2gnSLa6FUP/93LWkX3JgXs4nexmkc9rxmjCoAxT57NFs3rdIzHQRyfNAB+Vs1v9MsfXZ9D9EMiKiA8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153082; c=relaxed/simple;
	bh=Q3mfnmo3KVoljIvD3pXHoNaBNR14lS/w/SIJfKHoM5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HLBmjemPUnzE9cMdVpss7ByDqCNboKq7r94RHdVbADScEW8rA4bE4TSrIO34Yw7/G1MWuPXi2uwm3awbSl9uacZBySGunhTO8+4TycJPKh3om7V5YfdkVFHFh9lETiWueG+T70PEaCF34xdGLo+03LMFNG62EBWSk9bbqd7OUS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=CsT6uVuB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40fdffc3831so1556015e9.1
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 09:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707153077; x=1707757877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dh1uHvpKtYfCIyb2sWjljAxqv7IXOzMPTVAI3w9EyB0=;
        b=CsT6uVuBkbYTxlnpQHy5OwHvTZeldq7TOPuMKvXFRcu9OEs3Z2F6lJoDNR/ANU7ezm
         Md932nu40HMqLITmOToHrnyXwpDCMWh/JNSbh8vZyxGrgPR5IwiRTZS2OL7e8Zqhc177
         zouzcM0Gn5Zrq93wPMi3UwTJE8cUcm7RDaX8gVroynTcQQkxsUC+y66kChLsxM640v5y
         /6GLVL6uZ/vhsIpzm6OgS+mzTz9nLYMnRRtOC5XYG2UKRYVpez0R+gtjW5UVHnjWRwMj
         ewTr9M9ripFyzM7NdUzYLs1XtdbwZkpq+gL/Jl7p9KSAayZeAfunfM3Io5PCn1oxnCUw
         A2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707153077; x=1707757877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dh1uHvpKtYfCIyb2sWjljAxqv7IXOzMPTVAI3w9EyB0=;
        b=vY8ERuMajIzu5ALPxYVRMbKt6zp1JLc4QbTFJCb7MQY4uY9WzmlTzHJF1wT/jDHgeL
         fHbzj232/gqyE9Bd1Bt7sUCdbx4L0qqfPtMg9sxQuv8wtHYu6stY+Ap2Tpf4sj+NCyTh
         AXf3fkdoL+wOluWy15cMh5mE4unKGqs9K/yJqG3F2QdAIuShN25u3mYfysVtLElde2JP
         Jfj3P+twNj2p54HjYjsPAo36PS5dNeImxtbgZSWpe6jFHVp12OrksHdC4mdr5SUfBxvW
         QMeYUpzq5WPrwyAslc1CgoWXyT1VcKdIDkxaLwclLQdYj8g8uJadWMYdcbV7BbP1Mv0o
         MEIA==
X-Gm-Message-State: AOJu0YzbPeMjNAr36Y0RdMXx5yeKSaw40xlduGMr4kEK1kqzRO9sByGe
	ooaG6XXaedyatNMi5iObhCI+K5Yr5QBtfE0wgTtWyACV541HYSdBqAMdBm27F3XSig3xLn3p0lg
	HpZ0=
X-Google-Smtp-Source: AGHT+IE4DkfHGYfbRJDwx9sfe8UgnqEl5b/oT1J6DucCm0sXO1BMyI2PN995QAzFbgZ1ppX1+4LPNA==
X-Received: by 2002:adf:e40f:0:b0:33a:fdc3:a61c with SMTP id g15-20020adfe40f000000b0033afdc3a61cmr103119wrm.31.1707153077567;
        Mon, 05 Feb 2024 09:11:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWk2UlGMsAfspwH/SUTmJqTzdXQ7Xmfivol8uVD0oyX0SkdPKPohpHpPT+NAjtIzoj1lCMuhksC/BT8YCaj894FUP14aeo/Zp5rF3DXQIkz+ttoCCKE8ScyB85GigtCZfgWcemXsV5ti4qfhIh2pPs2LogMoGQK0Ms+xNvOkg==
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c358400b0040fb7c87c73sm9212974wmq.45.2024.02.05.09.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:11:17 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com
Subject: [patch net] devlink: avoid potential loop in devlink_rel_nested_in_notify_work()
Date: Mon,  5 Feb 2024 18:11:14 +0100
Message-ID: <20240205171114.338679-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

In case devlink_rel_nested_in_notify_work() can not take the devlink
lock mutex. Convert the work to delayed work and in case of reschedule
do it jiffie later and avoid potential looping.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Fixes: c137743bce02 ("devlink: introduce object and nested devlink relationship infra")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index 4275a2bc6d8e..6a58342752b4 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -46,7 +46,7 @@ struct devlink_rel {
 		u32 obj_index;
 		devlink_rel_notify_cb_t *notify_cb;
 		devlink_rel_cleanup_cb_t *cleanup_cb;
-		struct work_struct notify_work;
+		struct delayed_work notify_work;
 	} nested_in;
 };
 
@@ -70,7 +70,7 @@ static void __devlink_rel_put(struct devlink_rel *rel)
 static void devlink_rel_nested_in_notify_work(struct work_struct *work)
 {
 	struct devlink_rel *rel = container_of(work, struct devlink_rel,
-					       nested_in.notify_work);
+					       nested_in.notify_work.work);
 	struct devlink *devlink;
 
 	devlink = devlinks_xa_get(rel->nested_in.devlink_index);
@@ -96,13 +96,13 @@ static void devlink_rel_nested_in_notify_work(struct work_struct *work)
 	return;
 
 reschedule_work:
-	schedule_work(&rel->nested_in.notify_work);
+	schedule_delayed_work(&rel->nested_in.notify_work, 1);
 }
 
 static void devlink_rel_nested_in_notify_work_schedule(struct devlink_rel *rel)
 {
 	__devlink_rel_get(rel);
-	schedule_work(&rel->nested_in.notify_work);
+	schedule_delayed_work(&rel->nested_in.notify_work, 0);
 }
 
 static struct devlink_rel *devlink_rel_alloc(void)
@@ -123,8 +123,8 @@ static struct devlink_rel *devlink_rel_alloc(void)
 	}
 
 	refcount_set(&rel->refcount, 1);
-	INIT_WORK(&rel->nested_in.notify_work,
-		  &devlink_rel_nested_in_notify_work);
+	INIT_DELAYED_WORK(&rel->nested_in.notify_work,
+			  &devlink_rel_nested_in_notify_work);
 	return rel;
 }
 
-- 
2.43.0


