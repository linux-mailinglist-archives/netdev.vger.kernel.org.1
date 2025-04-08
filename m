Return-Path: <netdev+bounces-180513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862FBA8195E
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07FED3B1EAC
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 23:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9582566F9;
	Tue,  8 Apr 2025 23:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwOIq5zi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99962561B9
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 23:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744155083; cv=none; b=bLElIUp8tUqEgOYMJV8NswlNWcbZNekxc8BU+TN1aZlecc6fotdjC3gLQo+rAjEfnNWNEKN7dyOks3gcEbDl+IQEk/iJAyZg29xSABSqrjsgL3vxCQQnWNd9wViCjBGek2ArUQMsDV6PNAPL8B67MQg7XeKYiBLK/SHBZuELZlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744155083; c=relaxed/simple;
	bh=i2FEvLHXwmiztanEvIz1Nz7I4fbAuHkpg5qR/KqL1so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7iBObYAR5qkuhN90dpkpgvQnYg4uk6hK9JgaVo9aQ2bYLJ5yo7bLYoA/q1sriblWm0IIYtP3XksKInJX5PGHBCyyLf89rXCNmZd6TX0+F0iZ8FZYeJh6EB1oX8yml0y3IJ8/8qg5DzyYEtuaB8lfTQUSe+Azbc30pDZLh9MMr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwOIq5zi; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39c31e4c3e5so3777071f8f.0
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 16:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744155080; x=1744759880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofhUCdpu9Ci28c3zBFO/slGFSkGPE9Lw2VA1zPlri+4=;
        b=JwOIq5zi4NGabQo2psLHa9+pTy5iS+vS6RtS4nw21tG139WfLpL5u/2tKp7ScUE67j
         9t/bEJiojE8mMiLfNtAC7h0DIXLnBqDY0tYd79U43oN7VNaTUrlTvIi4CH2mC5gZ3rFm
         ThuJhwCSzaHmr7j/Y76RJe/QYrwW6ucHKGtkfxGtHFdnvkceoAPTz8xazIAo8hgRmvlK
         YXW92iQBaqNdJCUw8/nonDx5rCFEdtarDcE8eCy4OX/G5a4CzGFV+U+QwO6L936fmz1P
         9NFSecbsoyI7HWZhVPcF4h95fZSkZ1pgFRGCk7tcAmps/hGI3/5y3xziYGUSXx2nROjv
         yh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744155080; x=1744759880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofhUCdpu9Ci28c3zBFO/slGFSkGPE9Lw2VA1zPlri+4=;
        b=DvsHPSn4dxQICuFEHUNjgzhj+J+PUzVJfDI5GatCRVqX7DbxV9SYkzrcP2EhVALBNb
         3Ug+6XHVujBAKmfhjj1wzNa8zivPRgBdEXJ1cgPhSRQwcK5zs1ZDBKDUaPLGff43N3uh
         o2jXp2mqjxzHV5J01zfausS4MVv8NbO5v1X3soA3N/UL1FFmxu8ZTxf/KxmYL2bVND2F
         /Dwr98eziSxcxKOHqwTgMmwpOGUaQmNqBcCTKL2zKa+8TPr3PMpUsIXB4om5euotJQSK
         q09zKS6nc5g6kkrZjZgfpDei3sT5bTrzygOlP5tjxhXoVKXUc948URpZ7Y+m0wm7PvE/
         R9+g==
X-Forwarded-Encrypted: i=1; AJvYcCVg/nCQCqA3oxMyTeZ4iIfBZXTuBRAy9majzjPar0I/F8aVKmGI08rjsIXXSAoGU3tVaEZLU3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwraMyu84FSHVjXxDndNDepWNTZz5jI8iJT5o83p4Aazp/sDckX
	XA6+wZ8LPm2pLhHc0Gh2XGqaLYS9ztgJQF9D2oR/N27CvRUecDPV
X-Gm-Gg: ASbGncujSVqWY45cEf2czN6eJIxgM1iR0E99t02v0F5yWfyTQm7Akp2c5TEHydsfu71
	o8v+pSusIBUs1Bld57lG7JVNgFe54YwhyXys2Ahbs1hlI/NQ7LJjqrjVxd6PKNRsnEog/rEBOxM
	M9OBsDpkkqOqvChpuxh6fnCS7w8eoVmKnhHrvgnnQ/7MZMXkbj977sGkBch+HOtwmIWm8mabVmy
	RfphsgKB9umwaoxvwDvrED1JRQ+NtNKWhdQaHCRLFLRQVy2j26y1o/EJ/LTVrBKFt+mdFYMM0hx
	narnlS/hApoDn/cZD+LtttZns5sz0sfjAeEVv+V7lje/63r7GsqvHQxX+dk=
X-Google-Smtp-Source: AGHT+IGwU9gfub8I5n8wEVKElfXxZDa6HkqlYms6bOPEUB2gd+Z3hPB3mUujaH56GwpZLOhwXVL5PQ==
X-Received: by 2002:a05:6000:4308:b0:39d:6f2b:e74d with SMTP id ffacd0b85a97d-39d88564b64mr296692f8f.39.1744155079826;
        Tue, 08 Apr 2025 16:31:19 -0700 (PDT)
Received: from localhost.localdomain ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d75ac6d66sm9934565f8f.14.2025.04.08.16.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 16:31:18 -0700 (PDT)
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [RFC PATCH 1/6] net: wwan: core: remove unused port_id field
Date: Wed,  9 Apr 2025 02:31:13 +0300
Message-ID: <20250408233118.21452-2-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250408233118.21452-1-ryazanov.s.a@gmail.com>
References: <20250408233118.21452-1-ryazanov.s.a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was used initially for a port id allocation, then removed, and then
accidently introduced again, but it is still unused. Drop it again to
keep code clean.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 drivers/net/wwan/wwan_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 63a47d420bc5..ade8bbffc93e 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -43,7 +43,6 @@ static struct dentry *wwan_debugfs_dir;
  *
  * @id: WWAN device unique ID.
  * @dev: Underlying device.
- * @port_id: Current available port ID to pick.
  * @ops: wwan device ops
  * @ops_ctxt: context to pass to ops
  * @debugfs_dir:  WWAN device debugfs dir
@@ -51,7 +50,6 @@ static struct dentry *wwan_debugfs_dir;
 struct wwan_device {
 	unsigned int id;
 	struct device dev;
-	atomic_t port_id;
 	const struct wwan_ops *ops;
 	void *ops_ctxt;
 #ifdef CONFIG_WWAN_DEBUGFS
-- 
2.45.3


