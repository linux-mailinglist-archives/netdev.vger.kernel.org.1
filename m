Return-Path: <netdev+bounces-126243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCF697039F
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 20:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A3428355C
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 18:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6429345014;
	Sat,  7 Sep 2024 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAxwG6/z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06700AD23;
	Sat,  7 Sep 2024 18:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725734733; cv=none; b=K+kCIIMdR64ztlirIukB3ch7y2hgfw4+rTMjSYrI3jc2ja6rDknvm77IHOJ4sfZ5w7HKg3+LdI9tvtXq8/Mo8JWWJ+V0phoMdlbOaXXtQCeOKeWA9S3hUZCSLdC5qt+iVHxhWIwZ8AsGlgbrzYtVU8yC6XmRtDorHWX/0n/zxXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725734733; c=relaxed/simple;
	bh=Oqy81pMPN+gStw/HcuF5mQpXhq51p+bocutfIOnIhMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tq5S3hvgil/YjDkdf4hwzW+z9yGjI3X9EB52vlB5qVE95u/5UaKbgH75FGXidIkJpkQ7LDfDmt75m1w7LSJfvtSOL4AGkpx2HnkfnlVCSqRqeNMc/vqhcW6BG2dii9rnnq7uv8V9V1Miq8TSWgNGiDGkPwvTebnoSy9yXc450jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAxwG6/z; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718d962ad64so1584862b3a.0;
        Sat, 07 Sep 2024 11:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725734731; x=1726339531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GRLJvfR961MoOfbEQFqaDlozlRfqexTdhpUp3E230/E=;
        b=HAxwG6/zcxe1UFMosTIH8Hzvsai6/85vIGxPzhfuoCAutZGRKJZNh0nW5I6sRnFOJR
         mXY4I5oOe/XJ63eBftdQxL2mONN9hUfjytWeT0O7s9odUQJVzJOUuq8PY88NqAXW43Gr
         q3h++hWoQK7qyuxN9kCyx2LXmRp0zptdndOGxhWUi59PjokFv7BDkueNYyNTZ64rt9lg
         yKQw0lVfLTJUBfbGi+rhDgGl45ACChNyGz6cMVBFl8GqF3HrcoYRo6uXRtffl3DWs+sa
         0Yqqrd4//n/AAKpiXHUYKf+6T5/NXCZAufF0oQqzcOe0Ltbo72iaCj1qZCOgiCqZRcgG
         MXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725734731; x=1726339531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRLJvfR961MoOfbEQFqaDlozlRfqexTdhpUp3E230/E=;
        b=mS8ThihNbti5Q/t2/6q3fI19X6rmhX5TgHzTAZ1V8onrJXZaE1Uu+X2t/QYfO35mhf
         KVdD0yjonhxAtI9exhprv/xKQsUfhbycJiQNGYnJmG9yFPQNgZpPCc7QtFlGUQlPVaHd
         jDMKOdaSmVNa5BocWRGSv2/0x00YyeWku8ABx5HMFR3mtMI8vabqfoc7griQghZzp/3L
         TKtHbxCrhPf4ZfSMQI0gY+0Kgh2EHZw12g9c8pq5Wum8WkKrwtBSTUpxywff/eqx/Chx
         rCbgaVL3MRkS4FUtFWz+IOwibPBbrXFx0GCQDpc1UlJRQ54JsnfB44XFs+mPhAZ/Dubr
         m22g==
X-Forwarded-Encrypted: i=1; AJvYcCU71dN8aSGdpVk4rG8yODou5NPvvl20puQOToCz68m3ngWpxm+zZyCSh9efQ9QhqB/8Jx60v811Y8SiUqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpfa/4WWb8FQS/kUqLAmJXV1ggpTl79Gm8apqygq6HgbLzOD1+
	gb2Q8wjTkBZcnTmHL+S19Kqq+DyYuRsgzmJ1CpPY9JfVZU8G7uXFSjdPXifk
X-Google-Smtp-Source: AGHT+IFDbPPc19KrPy9XponqrV27F3GsapEW5O7hHUfIVBfOWLlnUGmaOFfPyxFdbaQkZ0eyLdgEwQ==
X-Received: by 2002:a05:6a20:72a2:b0:1cc:d4a0:2675 with SMTP id adf61e73a8af0-1cf1d140636mr9197883637.3.1725734731073;
        Sat, 07 Sep 2024 11:45:31 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d825ab18bfsm1111239a12.88.2024.09.07.11.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 11:45:30 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv4 net-next 0/8] net: ibm: emac: modernize a bit
Date: Sat,  7 Sep 2024 11:45:20 -0700
Message-ID: <20240907184528.8399-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's a very old driver with a lot of potential for cleaning up code to
modern standards. This was a simple one dealing with mostly the probe
function and adding some devm to it.

v2: removed the waiting code in favor of EPROBE_DEFER.
v3: reverse xmas order fix, unnecessary assignment fix, wrong usage of
EPROBE_DEFER fix.
v4: fixed line length warnings and unused goto.

Rosen Penev (8):
  net: ibm: emac: manage emac_irq with devm
  net: ibm: emac: use devm for of_iomap
  net: ibm: emac: remove mii_bus with devm
  net: ibm: emac: use devm for register_netdev
  net: ibm: emac: use netdev's phydev directly
  net: ibm: emac: replace of_get_property
  net: ibm: emac: remove all waiting code
  net: ibm: emac: get rid of wol_irq

 drivers/net/ethernet/ibm/emac/core.c | 210 +++++++++------------------
 drivers/net/ethernet/ibm/emac/core.h |   4 -
 2 files changed, 68 insertions(+), 146 deletions(-)

-- 
2.46.0


