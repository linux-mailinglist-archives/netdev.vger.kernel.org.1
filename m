Return-Path: <netdev+bounces-215048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 405BFB2CE57
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 22:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954DC1C2794B
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 20:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D745343213;
	Tue, 19 Aug 2025 20:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="YW4zyqyS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1360D2882C5
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 20:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755637021; cv=none; b=mYXDH2RgY+/CVO7ISvqRsemKchZuCvhnuBc2F4dTU5emJgMhR3VtCIlfdW5hI7EZjp3oPwLgd3xhL6DiF0IYS7kqVNAa7dHq5ReRdw9a6jSWhoXsoymgpXJ7g6tR1vWt1gCbeljn/AypkzF1n5pzE0hQeOfcq2hmRHJZvg4VCmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755637021; c=relaxed/simple;
	bh=YsA7DUJcZKEQf5Xl7eSjFn+uHqWI2wHHMChWxIOAkx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RENctjyeOO3nejk3tJaod+qWDaw5gobEd0ERDBaR/jMg/lOkYfvBukXiAZ4pX/qJVSm9XfteMk8n6MuzrL9DnfkYNVaaTxAAeUH2ww+jt6S4fYRsajj6XzsEd8HUpwuBQA1NCp5zntXjwS0j9BBQEBOIqH35mFqyGDMXPldzMb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=YW4zyqyS; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-30cce8ec298so4761706fac.1
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 13:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1755637018; x=1756241818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sUqP75lVUd7LsTAiO8CQTfTmIRNFM+zAUBmTVmoGb4o=;
        b=YW4zyqySGL4uTxaef8NnOAGheJk/+GPcEtvpSeBe3tRDbZgeMprVNt8b7C7LNCqYIX
         axKYfJGRNlULBwZ/dN+lYzrp6xm9tElyjKP5ONOXIJUIFw4R0mAv4aUmOcW7QUuPI+LW
         oJ3XwKIJe4KDrE0CzOzIWzJ6Hd+sJ5ZhNeB34oyfVZXKrlLY6XxIr5tSuunkAnatrkrK
         XUPs+4vrXvBq0RNEcnBxuxaH6nbOxP9LrpDWRPm4tkZlLfjRsGKX6dHLfkk+7LUBZxwM
         06yP5Q8RvAK8Zfuqxd6WLKSS92SzPYbrpdafPTGVIA/l7hD+jiDrU6eM3bkmYK6NX8zV
         7GSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755637018; x=1756241818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUqP75lVUd7LsTAiO8CQTfTmIRNFM+zAUBmTVmoGb4o=;
        b=pUz9oVQwXooEcYiGh6Dabi70kyEEfMG31soZ1O+D3njbZxK6wTGDjrGqaZ3+2kkwWh
         kvhVe4JqmkM83PQkGYyY4VwSQ3BkZO/qQ07L5fIklJLyKyUjYzuX2GPPYB0nA8LFMII7
         n8z+n/VultjeYAlIOYWFeN+3/STaAAVJOHsKPju9Cibf38xgCLXwX1ljERthUs/mDHB8
         XY55EN6LkRcXbw4Gl/Mcyd2QParyLx4FLDKDvejjNw5M7dxInyfirB45gSdsiuTzyey7
         mg0XCePQT8LrwiBz6TYmVUQCVf812eoE9Yn5sOhYuLQmufRiRx3mbfJ7dmScYg2XeUFu
         dfMA==
X-Gm-Message-State: AOJu0Yw802ndVfNo5B4yUit1RQHQMO65mbJhYAF5tatLnHp4pZNZca31
	0GOH6tpr1JBHahf9ZBTHV05LjEzuHctw12sa4pxXYtapTHl7o4+5uZyUFZeHeW0LdsM0PO2zcT5
	0ca5o
X-Gm-Gg: ASbGncsv4nrAuwNK2yI+O6VDKjixNgqq0qF3G/WBQ0Xck+gLh0n4YbvJoxwBJzgZBj7
	ERtn7qnVBXfF2axX+IwJcwHt240MMx2pCdeXtW1gVe5uVcvZBfNLT7RUkzGlo2QnQvPvPowkhgf
	4qmFyvfZrJkcK6Ut7ju0PrXLhPJXojD0KvAj/ecgysAUzVrI3P+J9JaOidZ48wxqMq2OE2MoBFR
	orR6P74/myddZ4719jNjVAc0WnXhhN+7fP2cltRoRkpsoVF0IRc+3gUkxJrikWXQG2suvENhyKG
	KjVzKjuT7PoLGLqFh+vXyuoVijN8rfYI3cpGcHlHI+8tlsMRQSkMnYQgkVNDEeS/Kyt1TbhdbuG
	roXKI6HwOjcnNYvfcCGQC7Qiy6g==
X-Google-Smtp-Source: AGHT+IEkIPlfiJeLrSWexZwnqCFod91yXyaBZUwqC2lIgDCo/DIWvP7gVDw6mlAoVu1IDEUgOHhRcQ==
X-Received: by 2002:a05:6871:580c:b0:306:9e57:9749 with SMTP id 586e51a60fabf-31122a33102mr291844fac.37.1755637017786;
        Tue, 19 Aug 2025 13:56:57 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:70::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-310abb343d4sm3703235fac.17.2025.08.19.13.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 13:56:57 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v1] iou-zcrx: update documentation
Date: Tue, 19 Aug 2025 13:56:32 -0700
Message-ID: <20250819205632.1368993-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update io_uring zc rx documentation with:

* Current supported NICs with minimum FW reqs
* Mellanox needs HW GRO explicitly enabled

Signed-off-by: David Wei <dw@davidwei.uk>
---
 Documentation/networking/iou-zcrx.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/networking/iou-zcrx.rst b/Documentation/networking/iou-zcrx.rst
index 0127319b30bb..bfc08154e697 100644
--- a/Documentation/networking/iou-zcrx.rst
+++ b/Documentation/networking/iou-zcrx.rst
@@ -41,6 +41,16 @@ RSS
 In addition to flow steering above, RSS is required to steer all other non-zero
 copy flows away from queues that are configured for io_uring ZC Rx.
 
+Supported NICs
+==============
+
+Zero copy Rx currently support two NIC families:
+
+* Broadcom Thor (BCM95750x) family
+  * Minimum FW is 232
+* Mellanox ConnectX-7 (MT2910) family
+  * Minimum FW is 28.42
+
 Usage
 =====
 
@@ -57,6 +67,10 @@ Enable header/data split::
 
   ethtool -G eth0 tcp-data-split on
 
+Enable HW GRO (for Mellanox NICs)::
+
+  ethtool -K eth0 rx-gro-hw on
+
 Carve out half of the HW Rx queues for zero copy using RSS::
 
   ethtool -X eth0 equal 1
-- 
2.47.3


