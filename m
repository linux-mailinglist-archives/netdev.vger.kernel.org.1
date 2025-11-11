Return-Path: <netdev+bounces-237761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E36C50047
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 23:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F0C8134773D
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 22:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C102BEFF8;
	Tue, 11 Nov 2025 22:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eikVF3te"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6804299AB5
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 22:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762901605; cv=none; b=ganMfj7ok3DSL5RyifbTD9mD5nGtAsT+KvI9aQA+LhtR6ksDxnavzpRV0jeR+17Jw/dyyT3ShfEwHGzmw+YKIB0xNDWL/9Th5k1OcdJmzDwV+R5bTy+VYhiwwNRW6eZZibyPvmkSNe3w14bgvEQWXQnCX19TPCtQDoppaPDzmjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762901605; c=relaxed/simple;
	bh=xWVKE2kQH5gsvkZHck6taG3ZWIzlXPJgdba3rVaKBPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ny/eijJ6j+7vQIUOHEoiT8uK410tfGIknGvqvUN2WvapdoZYDpN6+h38Nr5VeF4gXxUFLsTuOUBM8oLa+RSMnqgmdGnlOXcL7M+ZwYJVt/VNqha6TA5SJj+WrGzkUcgVqfbG+hH7d+rMFNEXSgFUOwVELNrMC9fWQtDjnWnAcrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eikVF3te; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3e3dac349easo137728fac.2
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 14:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762901602; x=1763506402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p+RAtlj7mU7seUknyOhJCo8SgLeA1PRBLG8vJYju+xo=;
        b=eikVF3teWCkc6A+JHmlE/65gPHqpNrEjnnPnil+wQbh3sbgYHFV0ffDlTZZ8ZIZdIX
         WZXO68eOqgSD3NLOt/rkoo9ulSoPL5lRSQP1r41XhiPTJKLP/NQXf0asmzcRJzv8NLyK
         AE9ZICeCArLAmgnihT/Vqi0eaUkLnW6VnyQI7Er13O1ysN1tvVPtWL24K/O0YdRKFNnf
         MI2x9+0vLfbjSdMBfR5Vqpbs1UNm2+0BQD2GsSOvHL1AZgXoqpYjLA7xAe2m+DC93Q0V
         NVLHaAXKEYytu4ccJBD7diKw9OfHJa4J9i4SOvYq0l6LX1AooE+8HUpNL+ZjGtpOxbuX
         /Q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762901602; x=1763506402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+RAtlj7mU7seUknyOhJCo8SgLeA1PRBLG8vJYju+xo=;
        b=kyX4X5V9Z/D+Imj1RV0ycXjp++AL7CnYXt0QDBYo67Opp045atIgHZ7QEgQtsPL8dv
         Ky4zsLY9vJIApA5X88nlpd6Csf5hldTyUTr0qMO6aoIYaj0FKdg6sd6P6/Aw8LfZ0ecZ
         JBriqWudaRT+WpDr+ICxWmxLgIwX2AZ+Ng7jQ62wisDD1BCg0AdC8JDr1y06P4wKnpUp
         ekjw/cPwjsKi3OSD0D1AKZKXgaJ4B+7Rzfv+iEFbzKVZkJFD/vpc7uIJ21tjATEwZNIx
         JPZwBPkHM+Zc7Ayn5Wv/d4e9tAWx5SBYsefvtZdZSpwTUMSOY/YD2NEZMTiJvAwEx5qy
         EzrQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5pBnOuqWE3VPy967BHoArx0XsjqyRXiS0XnHNMzW17bcQtBLwimmApLXheKjjcI7sWUVhejw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK/LcFc/ZgAqOYR9jrmN5lebCZ0iIs1UQKqmK1oejYEVG3xeqP
	6XXvUgrjpTYcQy4QHV4UGNKScvqMH2q4wqmLd3xFELYNlxIl07HZtz0I
X-Gm-Gg: ASbGncuFMIrwA3tljPmw4mYWFyR5kK2T8zt26RhSsqRNdqeNMiPyCrkcL4RiUFVcv/5
	L5Jwlg608HSbj9nwc9mNcn08RerN/iKSzX1pxDo9q6+UJwa06HdaWU1gz5GrLhabmSO1CwiL0f0
	BI3QqZR6zrW3ok6YY2iYYm/t0uKEtLIjtFY5lerto035z26Yx2TZsz5POvyZDqD8rQfOaoXXD/t
	FT29YoXgNQ9/Q8dVUwUwRwmv45VB0OGG/c3TRYFkxKAP36VBw3jrVg5vsAGrPYgJGN6HCVeA54k
	Aas2N9zZqjLx7TbFRoWhGr5yjrywbh7eLpPugLNZrowY6uHATCQVkIYb4zNjG2sMXJ/E28bLO6D
	YG/X1S+VH+r90JKSpYSKr3yC9Rt9Mo6NTrenCqZKGBdveA+fciWcn2AbhOZ0bxdmV0JEKOR34/h
	St8NwpTBD1+LL6pK/iSEUqNay6BUOecWSfqNLsneqT
X-Google-Smtp-Source: AGHT+IFsJBdWFv5w7mQ5dJvJ/06B58OP4tVR8mzMi46SHWEvTtWfctGslGNc+IYz7hfFWbXrkkmchw==
X-Received: by 2002:a05:6871:3a12:b0:3e0:a1fa:e883 with SMTP id 586e51a60fabf-3e83429f4f2mr415728fac.40.1762901601743;
        Tue, 11 Nov 2025 14:53:21 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:72::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3e41f1d0326sm8741886fac.19.2025.11.11.14.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 14:53:21 -0800 (PST)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: Limit the max number of queues in procfs_downup_hammer
Date: Tue, 11 Nov 2025 14:53:19 -0800
Message-ID: <20251111225319.3019542-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For NICs with a large (1024+) number of queues, this test can cause
excessive memory fragmentation. This results in OOM errors, and in the
worst case driver/kernel crashes. We don't need to test with the max number
of queues, just enough to create a high likelihood of races between
reconfiguration and stats getting read.

Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/stats.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/stats.py b/tools/testing/selftests/drivers/net/stats.py
index 04d0a2a13e73..b08e4d48b15c 100755
--- a/tools/testing/selftests/drivers/net/stats.py
+++ b/tools/testing/selftests/drivers/net/stats.py
@@ -263,14 +263,15 @@ def procfs_downup_hammer(cfg) -> None:
     Reading stats via procfs only holds the RCU lock, drivers often try
     to sleep when reading the stats, or don't protect against races.
     """
-    # Max out the queues, we'll flip between max and 1
+    # Set a large number of queues,
+    # we'll flip between min(max_queues, 64) and 1
     channels = ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
     if channels['combined-count'] == 0:
         rx_type = 'rx'
     else:
         rx_type = 'combined'
     cur_queue_cnt = channels[f'{rx_type}-count']
-    max_queue_cnt = channels[f'{rx_type}-max']
+    max_queue_cnt = min(channels[f'{rx_type}-max'], 64)
 
     cmd(f"ethtool -L {cfg.ifname} {rx_type} {max_queue_cnt}")
     defer(cmd, f"ethtool -L {cfg.ifname} {rx_type} {cur_queue_cnt}")
-- 
2.47.3


