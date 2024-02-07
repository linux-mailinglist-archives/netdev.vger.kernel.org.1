Return-Path: <netdev+bounces-70002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5B184D36E
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 22:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE081F260C6
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 21:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03E485624;
	Wed,  7 Feb 2024 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYsbT1Vq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20872127B50
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 21:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707339947; cv=none; b=eSAraO6LD4sO+UIHe39/d2Fgics4LvduEkWTr0Rr/PzhJNQ+5DJozgmJzzJJGTsA/DrMybEKlo81VukfjJDttYFj+w2vmSXDxlhi1+DED1ITdOMh5wCaKEpLkho1ZPANwXxYa+1uL7McCzItTQF00E2yRKuVucN0zRX7ofwApXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707339947; c=relaxed/simple;
	bh=5GBIdx7QOforEfWSX9f7GXOz8XaoAmfxYVi1+B5cpoE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fZP5kpuIBtPMI7p/fMN2BbRU+K5U6dBiFMjmkIHaXo0UNTjBhtkOqXcNA9EwEljUuZ+ImFPGyOZDIZBsU3QxzR8w1kdqwfetUYTO+YH8YHYu5H29Y0In76hu4P1p689MaixiUGjnwxttco/PZP6NWMFRNX/S4Ne5TtWgrfyXEis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYsbT1Vq; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51167496943so1836966e87.2
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 13:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707339944; x=1707944744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z/ytDIX54Nb7rPsFznPXw/fkWlpC9/8epxoXFGn4yoc=;
        b=gYsbT1Vqj9uIZ21rM2r6ABbgyD8bVsLMtpn84AC1UwclN0eRFUxG+0VmbNigBhNG/U
         5iha+/J8fcYIlv1Dy4uDrKk5DfnfcJqEVqJgrqwXzZmrLtOCmTvjPKoySgNq79AyO9qb
         AiwYIID1Llvjy0GuXjFhrZDqumnlXINUMivQ20EhVxBdYyWBYqtzsyiqop0KP8BnCQmA
         OnKgdW5P958P9veRdn0YSW4/+QJyNkp+Q/Q4nsNkIrosBZhDXJhVVFczqR3fB/qeOHJD
         AvTnOoHzi7Lv+tAkkOB4g+cCIQ/CAxyN2ycCJ79tFjrxIVXaUdpbpLvU9BrP31Bpz9yG
         FFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707339944; x=1707944744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/ytDIX54Nb7rPsFznPXw/fkWlpC9/8epxoXFGn4yoc=;
        b=ey4Z4E9AK9MJdqx5GLCXaujdyLlUbKa5oM2gpdTmBfK805A2GbvrW0F3FVg3326SYl
         3BQXvUh/NETZSZV0dnrZA1Ww85w1EfSKJNOYKON8jiQdgkj4C4jaPgmQDvU++QBCQseI
         zPb7fr7b/2KY7+u1efdWJTLk+A3jKKzXw73ry5nmZeP/Ha5gGVm9nV1XT9Sdsy68OHOa
         zJDl9kXQlK3zK+S4AzoqXpVkUPw3qduRohARBUmSk3bNHVVHuaRnBN8xYRii26mOrFlg
         72HSS1vezaYYsBvKxavuLYNOFi+jPAdx82kK8t4ReIIjFaZ+AzfRey0KGnvnXrHlYWx5
         tG2g==
X-Gm-Message-State: AOJu0Yxi9c5W86bM+cYqvX2ZB32+40hLGsxJUr56Y79MBg0enj7Y4jNR
	yob/TBGDtt58aXfk5lUrJiXGd5fJtUj5xtt4fVKRihV2mQzXx6Cm
X-Google-Smtp-Source: AGHT+IFiL/EnX42oq0UWKaYm7lEMYbIY3VZQqGNpMmsCcNVNgs0pNyfs/6KhK1VGK3Qe/WXZXhRIww==
X-Received: by 2002:ac2:530a:0:b0:511:5936:c874 with SMTP id c10-20020ac2530a000000b005115936c874mr4561291lfh.6.1707339943802;
        Wed, 07 Feb 2024 13:05:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVF6GbFJvRS1QPw+2RzJucDBzsReDLqbtAVDAN6W16EqSf4g5xnSSoDmc7AjLrSZmkcnfVIi13IOVKQLqt9e7LyIxC/Eqdx
Received: from mishin.sarov.local (95-37-3-243.dynamic.mts-nn.ru. [95.37.3.243])
        by smtp.gmail.com with ESMTPSA id a17-20020a056512201100b005116578916dsm316918lfb.164.2024.02.07.13.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:05:43 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH] iplink: Fix descriptor leak in get_link_kind()
Date: Thu,  8 Feb 2024 00:04:50 +0300
Message-Id: <20240207210450.14652-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found by RASU JSC

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 ip/iplink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ip/iplink.c b/ip/iplink.c
index 95314af5..7e31b95c 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -168,6 +168,9 @@ struct link_util *get_link_kind(const char *id)
 
 	snprintf(buf, sizeof(buf), "%s_link_util", id);
 	l = dlsym(dlh, buf);
+	if (dlh != NULL)
+		dlclose(dlh);
+
 	if (l == NULL)
 		return NULL;
 
-- 
2.30.2


