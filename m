Return-Path: <netdev+bounces-223927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AC9B7D438
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4A51797FB
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 09:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50693451AE;
	Wed, 17 Sep 2025 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mcwilliam.dev header.i=@mcwilliam.dev header.b="JB2xRmtJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2705B30AD19
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102972; cv=none; b=E/HbZg8D21Slf59rQvU67mdjGWP1QTS78kPfI5CEcODprjbGj2zW/VKiy7kH3wbmugw9WF6XPKu2yNdFnCLKCep5lfpG1zYoaL1CP0VGAcHT8Cu2+GokmDQWlFvbhMFHmrggRePxI3ZmcN9Z0KgGUq8OrSEaeYjxyMpaiXQDhkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102972; c=relaxed/simple;
	bh=SK905hAb5JjDXpc5gVDZYn4NPFca/OTkncTq8mCLhEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kIRJAerQs9HNdiuz79pcTYzDU5DSy7P/3X8mpi0b19oKJ/9u3TtU9P++FvmmCyHjmUzN8Z209RpaTTwfdEWBFY21VQStoctETvvAgXcTXKJk0A2m4sSw2/C7A1qowKZoLJgTVBR1nqw5/jadhxwvcPbkUEEGCvmjDlLDPumxH1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mcwilliam.dev; spf=none smtp.mailfrom=mcwilliam.dev; dkim=fail (0-bit key) header.d=mcwilliam.dev header.i=@mcwilliam.dev header.b=JB2xRmtJ reason="key not found in DNS"; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mcwilliam.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mcwilliam.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45f2c5ef00fso30492125e9.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 02:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mcwilliam.dev; s=google; t=1758102969; x=1758707769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/t9yn0KxD0nwPhFydgfXLZIUrsVvjMBq7JtnctSwmQ=;
        b=JB2xRmtJcDr8uGiy0ggvx6BSmiMDktFLXN2J902ZsEAI9xs1SWUyBi+leRPDVGuGUO
         UYx+3KdDVMGui4xwZx+wOJSiLlXnwG1tjkvvj7Bq8e68Hg2Kt+p2TFzJ5QCsIxmWzCXE
         aOG4osB9cRqobW0Mxd/ahgJxZFq81GTmxXS3PO6rtu1ph+fnGF437KJLg3Z9L9X5SyDE
         9/JDCXj39DL+bK1cF1zl3ZC/J7xRZY+ixxVBgVsLe3+cefq+o2SQUj6GVDcIQZoHOO5Q
         puPSwWGOcyAyle7u9idPxApx8prDgtFsQZ8TDtAz1UqdPxy6wq/NDkj+dP0YpgO/18vD
         fmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758102969; x=1758707769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/t9yn0KxD0nwPhFydgfXLZIUrsVvjMBq7JtnctSwmQ=;
        b=VjjS+VGRX2xSYwAXzAqu60MWgZM8T95NwV85uk2NGC4ekzZORV6m+q9cV5wpgzSgBe
         xFsSagfmZxosSBx1YaKiWTYozVA5xZmGBDSVlNvLdjkKYggbSD3EbVRGUA/dapWeLQ/C
         fXQhMS7BO9VaZ2HBxRohmfgNIT+rQDDtcLztmUkQ6hEUnSrAouWMGUeoVl/R8N347NdM
         dY/5Rw+fwq4FbTEHOnj8cGBuHwpz01QrONUy8GCuBJinLOgFLvwQLArxNhfsk30s97xq
         AMmmMA9Vuv8BCbV4fuiOZR7SGFfSaOotHGVvLCJnbWhkaYdUSu/h4EaLZHJJwC6cvRx/
         aBsA==
X-Gm-Message-State: AOJu0Yz3LV4iIwwMQXM0xyj2zmDa2x78zCw0pk3681C4XAkYNLrE2PIr
	WNL3N8uRG50n7JSznVTjAAZYGYIjEKrcKDwpHuN4CORPuV4sNIYbmIJ6UjdyCEjeRQ8=
X-Gm-Gg: ASbGncu5wjJk8tOo63+LTVEAa5V9tOIIuPB/hRA6hsk4UWj8835+eKuUp7vuO6UHBs6
	dzBrZC53ke+yNCRinjOitpBb1L+FVpAQvE33L9UyC6OvBEpCaxrtMkbBf+ZIOxhJZMtQ+Se2uyZ
	vSwQYil4JqXS7mhlxr8OaPyLZ7xmeRN6IZ/Gp7GvzOzzDo9CQE9MjbhWPmrJMRsz1Tyt02HQJkC
	WhMIdpo8IXud4xaSEZk27tsM/ZmNgBfWm9YEjwmYyWvs3k5km65/kElbt110ru8nc2+5WT1NPWZ
	/BF6Kg9+Ad0TNHAVuiS2kz8Imsc+xlBnhJnuB64WeDw6FwUcBC+0HABHBDTTu/wF3HxnTZiSlnT
	GYTBBWrHjtGFfDz8RwttPfKHqo2Ou
X-Google-Smtp-Source: AGHT+IGroLywQ+LB7c0cKXFoLgumEqakLi/xj82QZyXH7MRZQMiUyvC9M3K1pi43D0MHuxPYYJXj/Q==
X-Received: by 2002:a05:600c:45c6:b0:45d:da45:50c8 with SMTP id 5b1f17b1804b1-4620683e8a1mr12929355e9.29.1758102969279;
        Wed, 17 Sep 2025 02:56:09 -0700 (PDT)
Received: from el9-dev.local ([146.255.105.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e91b2519d9sm15951140f8f.22.2025.09.17.02.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:56:09 -0700 (PDT)
From: Alasdair McWilliam <alasdair@mcwilliam.dev>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Alasdair McWilliam <alasdair@mcwilliam.dev>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net-next v2 2/2] rtnetlink: specs: Add {head,tail}room to rt-link.yaml
Date: Wed, 17 Sep 2025 10:55:43 +0100
Message-ID: <20250917095543.14039-2-alasdair@mcwilliam.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250917095543.14039-1-alasdair@mcwilliam.dev>
References: <20250917095543.14039-1-alasdair@mcwilliam.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add {head,tail}room attributes to rt-link.yaml spec file.

Example:

$ tools/net/ynl/pyynl/cli.py \
  --spec Documentation/netlink/specs/rt-link.yaml \
  --do getlink --json '{"ifname":"enp0s1"}' --output-json \
  | jq -r '{ifname,mtu,headroom,tailroom}'
{
  "ifname": "enp0s1",
  "mtu": 1500,
  "headroom": 12,
  "tailroom": 0
}

Signed-off-by: Alasdair McWilliam <alasdair@mcwilliam.dev>
Reviewed-by: Daniel Borkmann <daniel@iogearbox.net>
---
 Documentation/netlink/specs/rt-link.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 6ab31f86854d..2a23e9699c0b 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -1057,6 +1057,12 @@ attribute-sets:
       -
         name: netns-immutable
         type: u8
+      -
+        name: headroom
+        type: u16
+      -
+        name: tailroom
+        type: u16
   -
     name: prop-list-link-attrs
     subset-of: link-attrs
-- 
2.47.3


