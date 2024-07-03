Return-Path: <netdev+bounces-108753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE8A925384
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 08:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C97D7B213AB
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 06:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8832212DDB3;
	Wed,  3 Jul 2024 06:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="ZM9TjA8n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A900B1C69A
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 06:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719987133; cv=none; b=qYAQXrlo/15sie/F8OOkRLwqzHft9zQARHhzKyrSCfgUl8MezaHmwROghNWbhg9pN+ZxRb9c00mYSs1AB2RQqk1JWqi80uswcgRQEHBcVYQk+95BfcfUIAdmoIZ7n30oJqn+SjevlYRNGPktP9EjpMLgru3aafaDK06XC1MBbj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719987133; c=relaxed/simple;
	bh=3J99y5+6OxbwcKwAHIcLAKi5CZ2ycbqsCw8ezkKjM80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rBiyNFltjJqX6y19wA0TcgbOFgdfVZIfCw1acmHY9GpgT44aJNpw8uiq40v3mn9y3WYnPLFL0ngH4XJdtM5GSEjbW4Q6KPaEsgWElDB7tzOJ0AvTKWRqOJDZQ7bUVZkIFRtvjAY7dMqZBW+ULWsxjTdHe5+3JdGrs9drkL0glvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=ZM9TjA8n; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e035ecb35ffso4917304276.2
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 23:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719987129; x=1720591929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1YgzDReIaUyz8u4XHHLiy/BwQZOZxxkCv3LtW0SkUnc=;
        b=ZM9TjA8nvdacXOC+i8jV18hP312AcUixvWRcDGa7PG288hGgq9BuqSACT7NHNFXAsx
         bPZiy9qykcnRjP3Q8VVlO4YiizNsWwOgbl/Yx8WTNvdCFd1d7dGRMA++8aMZHonB8mpK
         M4R01h7b3L1TBGLv1SAP5C+gjVtaRuOcZritfHoptPXih1SgVSnFT4H2Rju2QbSlcjFD
         BbDpw5woDX+PVrKSpeoW7pdmAfB7Cj97YNScln1KcqC7LXgQcA4JuJuEveiUTRhgi7Ut
         X6p6L3jvOc0St6SpkO6sQOYfOnvFB+SzGzudJH8GsuH9fmORQJqhZcTneeY4QnqMr/Kf
         kMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719987129; x=1720591929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1YgzDReIaUyz8u4XHHLiy/BwQZOZxxkCv3LtW0SkUnc=;
        b=bQyMWTkch8qLlYVJvlWIRTGuPKRvnqkZasT3HSBEaow1tHe+JEZL6uYV0bLWHgxf+l
         UaeewQIt5W17PjBx/R4pjCdxIQ5o50DDxT0OsM4laWK6cBdMRkxkA2cqu8Z57O1XbK9Y
         T5Z8BxzE1YcinilRvq8vYE4JQUy56PqAS5spqhLxF3/Ri7s7045QIqibB4CJ8pCJIsg0
         ZiHPi3uPNSj1kaXFH9L1p/xMY0sfyB0wZZrBP2Z7ZJEqScwx5ly3ZNQORU44htlup3CS
         T0qMepJMawpbF8HpkkXokARA6vGmPuztroTMPzesEMQOqFGPOlyv4RiqL3gml3jK6KRR
         n1WQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6mCyTZr5tnicws0NuiP6KA5S679MhL1YQBS3HkLsxvL0y1Ry8hd9KmCpwNAWeZFafWnYEKZL+mKewX2v+uxtly6YJl92z
X-Gm-Message-State: AOJu0YwIZuPW+MIqCVU8jHKWpN11gv5hqauA4SrMQ3iLU5u63Zc3ZxVb
	2WMlUiMIAwxxsDFX5JPJbGwZjxmwspAmuDgeVrAW6ZFKCwkp5846wXelBWH2eoo=
X-Google-Smtp-Source: AGHT+IEYwaFScpXSpfOjk0NDboyzDAX10kkBsDpozYzsFOW5+JJ9NVaivETucKRFmAX9S49/+mU4Bw==
X-Received: by 2002:a5b:9cf:0:b0:e02:b7d6:c97 with SMTP id 3f1490d57ef6-e036eaf633emr12008074276.8.1719987129659;
        Tue, 02 Jul 2024 23:12:09 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6a8dbdfdsm7531927a12.29.2024.07.02.23.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 23:12:09 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: samuel.thibault@ens-lyon.org,
	tparkin@katalix.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH net-next] l2tp: Remove duplicate included header file trace.h
Date: Wed,  3 Jul 2024 08:11:48 +0200
Message-ID: <20240703061147.691973-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate included header file trace.h and the following warning
reported by make includecheck:

  trace.h is included more than once

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 net/l2tp/l2tp_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 88a34db265d8..e45e38be1e7c 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -61,7 +61,6 @@
 #include <linux/atomic.h>
 
 #include "l2tp_core.h"
-#include "trace.h"
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
-- 
2.45.2


