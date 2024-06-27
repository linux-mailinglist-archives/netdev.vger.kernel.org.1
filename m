Return-Path: <netdev+bounces-107403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4443B91AD58
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 19:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E8A281A9C
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E7F1C286;
	Thu, 27 Jun 2024 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="tCjMWJZ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2CE18040
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719507642; cv=none; b=aQKYLpZGKqX5pY3DEbAcGYyyM4q99S6cD+5d/rrpNfRy4Tc22d2L4ffKI+TZeNLz2X6KlfKFTI3vwCt44FliYeLWMOcV1b6Ag4Gw5CZAmijRJb9UWr8yKv8wN4wRwg3TmZGrCCWDY+aK37hiuMB39Ez9AqpJl05RWrq+NxHNx/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719507642; c=relaxed/simple;
	bh=WUb9GiQcJxfH7poKqijf4DYVCN8bbB7aafYm0Vvvw9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ttLy6hZ2ukqzyb4lLymkDqqz49Hxkt9olYALSw5BXvLxniKegobWyICKs12umEIEFYqBdfJmTD3LIWP3Za3riGxzU4l20laJWkkqtxhK4fSM7XSj0ANTqgZ5ObVMIr3E98Dt4fl4DFG030n7VoomdS+1DWSPdo2QIivf4HZutn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=tCjMWJZ3; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-71816f36d4dso4369334a12.2
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 10:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1719507640; x=1720112440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2yZwgeVccfOxs9DOUSd3uJWzfiVfRYd1munx8G5UXKE=;
        b=tCjMWJZ30EV6TxSURNiWay0Lqp+qmQi6PWEMNq5kEvDG4Vo1tQ0lXaO3aY5/xYz2nw
         y//1Re/ntOUD6qWY2UWNAz9hB/pecKF2OrcOy2pSmRfs6WlG3XNA7iGUgsw249HmBXWX
         JvF4f+o36089AEkTM69BCt3/kDrFsZ8YijPTzODNbI0bUs0M3VMTbP7LKfnCfwUxf6G7
         mYsTNiUaxn8AjVS5HR+P/Axk8fy8aq6shlcSGLPI1uI3mVOuITCiCagtWb7QsdaWgneV
         VzsE+aPRvFd1oc5llQD8cRKeTpaNpLgbnOL4J/CZ+30aJahPwqnIjNTesTJ66L/+YhOG
         z6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719507640; x=1720112440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2yZwgeVccfOxs9DOUSd3uJWzfiVfRYd1munx8G5UXKE=;
        b=ZmSqUjCUVz0uqzanjk2apEXwdhhxI9FXmMKP79BH+VZPgM5zRKSpnVUIzk+UPRoQLA
         a7cfXmG7lAnQdtai2j2ZJAI1Ud1foLgNjZrJ4gbV0pKJstzYWTSDDwnZG4mQEEVr2YYi
         w722sSQ6k1kUdFHvGPHXuy4ZMTbFWoMnLTV/imNexwK/tQKZh3hOe0f3taBxnAhzpYA9
         CLS9r98fK8QoCH9ccaNfGL1BXgRUzF2qaYfFiX5KoSAIRh+4chUtkbPGQl/ZmkMnUubv
         kUUO3SwnicT9zFffG9lb4sqj2C+bIjoJ1KhiTmmE2YWPqUYfKEzcy+f7dtLP5ZH86jRr
         2Srw==
X-Gm-Message-State: AOJu0YyggsAYPs2tJa24QdAl2ynyEoqobWETYbPdclA7RyEEr6+Kj6Vd
	1AoTvWWXZbCDTNejt68gEfXjdnY1O7pD9twOwECYp4wIB0E4xfo6MDtZGSqwvFszBG9GTRAOHYb
	R
X-Google-Smtp-Source: AGHT+IE+Vxk0TBqSvyiSNisUw172Igi88X8o1rj8U4z7gjDiA1h9ZVSmnbnwuoOe20MKYTuWWzyi7A==
X-Received: by 2002:a05:6a20:3514:b0:1bd:24f9:1124 with SMTP id adf61e73a8af0-1bd24f9124fmr7869100637.27.1719507639609;
        Thu, 27 Jun 2024 10:00:39 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b4a3571esm1651219b3a.179.2024.06.27.10.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:00:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute] ss: fix format string warnings
Date: Thu, 27 Jun 2024 10:00:18 -0700
Message-ID: <20240627170029.7346-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang complains that format string is not a string literal
unless the functions are annotated.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/ss.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/misc/ss.c b/misc/ss.c
index 8ff6e100..eb68e506 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -1043,6 +1043,7 @@ static int buf_update(int len)
 }
 
 /* Append content to buffer as part of the current field */
+__attribute__((format(printf, 1, 0)))
 static void vout(const char *fmt, va_list args)
 {
 	struct column *f = current_field;
@@ -3460,6 +3461,7 @@ static int bpf_maps_opts_load_btf(struct bpf_map_info *info, struct btf **btf)
 	return 0;
 }
 
+__attribute__((format(printf, 2, 0)))
 static void out_bpf_sk_storage_print_fn(void *ctx, const char *fmt, va_list args)
 {
 	vout(fmt, args);
-- 
2.43.0


