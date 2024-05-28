Return-Path: <netdev+bounces-98614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3942B8D1DE1
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72452839E0
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F45A16F829;
	Tue, 28 May 2024 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjovwpFH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF76013A868
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905231; cv=none; b=owgAF6sEs42CdxsK14319+OQXrD6I4FzzUl/x/CG5gFV6qkvsYnNrMrJaN4MFzHsZZVloFg+0NVqAZ6kRiiLP7zcd7h57pHvUiqLx9ZNvMvlqxNfmWtCFi31Mxl0C/KxwRliYQUyW+9KctYb4NEarVBhMoLxDYAPtJyUfEuDsMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905231; c=relaxed/simple;
	bh=MQ69LtO8M9cLzn0g2HkeRYi0wMGIyWZAesPUuWLZEuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khBA+tgn7MasbOGPVykKMK9KubBJyWnUdpEhLYPvdVAN1BNRVgs3jALvkIhlHM1KUGovJ4jzlAPXWUvosyvDR4EjQqvB6Vy49gcpZM3Ewm236eDSRCHWeWqScyJTIKn2zlI2joABhNO3I+ApjDeUIHXZylmfwm4X6zi7jtAM54s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjovwpFH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4210c9d1df6so6814245e9.2
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 07:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716905227; x=1717510027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJYiy2bAj2FaSa/bOXOAtiypNP4pZBgAgYRKiJ5X6fA=;
        b=IjovwpFHFb5jIGRdebaMXFfmZYWqZsg1Rr93xvEMq3r5yaNPzI+7XhEY2eHILxFlaL
         S1a0/V6ZPu3M7QVttcfVeCsvlVFoUy95/w5X8RQvc2eW2qs+xIhGYCBzqqDVM5GBsOCC
         HvdUYPUtYVSJIsn0q5zUbRELHLaQPhBvMhmmOErJb/2YJ7undJC3xlw9T7OZgSI/OyED
         r6kH32oe7IStOmDjYZvR3ApgRYhMFUAhXDx90vg/MEMLg8v8XFwWzK2xh3i9lcEyY7Wo
         buMoCa0rNny8/CbEaGpYyOmLx7CmI5/S1SWC/i5RwFtQYIDMiWPkyZvgPc8YPODLvl22
         upZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716905227; x=1717510027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJYiy2bAj2FaSa/bOXOAtiypNP4pZBgAgYRKiJ5X6fA=;
        b=rGUxLReE6DYbzNB7/JDn5Vn0FbJ/3VGN5ZLgRYSRv13h+zxgow/9Y8GcXqF4YL4tj8
         tXYZ+0UfQU5qXBrYpI/LipGzJA4GfqWyPRVTrNg3Aupyzibyq3pSbAnvsGrX06iGWcsE
         KJByZi4+Q1aMPugDCWlS+pZYvTsA8bp8TI7dO0WJfXJCkrthHI5Lx9cheuX2r+1gZaPu
         1ivAqh5UfrCmhxt+ZToepy7+1CVNATeWkkT+0HcCVgNvNX2bY0WQCnBvW3IlOLCkUr0C
         SKjBd8ZkjfNiOVRJr0knsTcxbJEWb/xkXWwlbdQ6NkUQbOYLzr2bY3bS9pU6ouqA32JZ
         qNAQ==
X-Gm-Message-State: AOJu0YzlEKkKG0TngHwUMdH48M1UnwrISAzTVLppt/s5CQ3g4hBDNsW0
	z603PiiLAmXdUAq3yAuSrfz6ZKK4LnVaW/7qX2vpr9DD8JQA5t4ut1Duo5+W
X-Google-Smtp-Source: AGHT+IHD8zd3830z60+a3DaVlpCND8JnPsxF70jXBuF3KgUBGyBVdy2+jwHoi9wftibRjz7ONYNOeg==
X-Received: by 2002:a05:600c:19ce:b0:421:1206:2645 with SMTP id 5b1f17b1804b1-421120627f6mr54036325e9.5.1716905227094;
        Tue, 28 May 2024 07:07:07 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:68e9:662a:6a81:de0a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-359efaf5402sm4534599f8f.78.2024.05.28.07.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:07:04 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Breno Leitao <leitao@debian.org>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 1/4] doc: netlink: Fix generated .rst for multi-line docs
Date: Tue, 28 May 2024 15:06:49 +0100
Message-ID: <20240528140652.9445-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240528140652.9445-1-donald.hunter@gmail.com>
References: <20240528140652.9445-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the newline replacement in ynl-gen-rst.py to put spaces between
concatenated lines. This fixes the broken doc string formatting.

See the dpll docs for an example of broken concatenation:

https://docs.kernel.org/6.9/networking/netlink_spec/dpll.html#lock-status

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/ynl-gen-rst.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
index 657e881d2ea4..5c7465d6befa 100755
--- a/tools/net/ynl/ynl-gen-rst.py
+++ b/tools/net/ynl/ynl-gen-rst.py
@@ -49,7 +49,7 @@ def inline(text: str) -> str:
 def sanitize(text: str) -> str:
     """Remove newlines and multiple spaces"""
     # This is useful for some fields that are spread across multiple lines
-    return str(text).replace("\n", "").strip()
+    return str(text).replace("\n", " ").strip()
 
 
 def rst_fields(key: str, value: str, level: int = 0) -> str:
-- 
2.44.0


