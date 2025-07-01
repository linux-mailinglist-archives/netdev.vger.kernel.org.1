Return-Path: <netdev+bounces-202742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 173B6AEECD8
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 05:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3533E1BC454C
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 03:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AD31F237A;
	Tue,  1 Jul 2025 03:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edUN4Jpq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AA51E2858;
	Tue,  1 Jul 2025 03:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751339592; cv=none; b=hYWnoBcFyDnaTYwQ/n9eRmwXH7pUSmuJft55LNGYzNz+nWHVEJV7m3jI5xlWFJSPQBBBkbSYpb5z6/BgTbid3PxEX4c8wSovEu4upK9fRSYSf4J+efFRf1SXiahjr+YWQ6g8/nNgFSr/8tN8wZZEqT9gJbVkWToxYNjGLgroQls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751339592; c=relaxed/simple;
	bh=g6OtNn+6pJ2FX9r7LD6uzhKimbI7CNQILNu9JtJxROU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3CYPw1OvcInJg5rfs/iIe/zIYxxY/c8sTDnXLXesmEfUQyTPRCKddZ37AiZDD2Qi0ChWcRn5AxAwsbu7kcftq/asL3Hn2wViz89hpQhl8mDriXulnp1950shqwjKYz/QKLEav0nmG8PHuGDf4RFzrntLCY6lC7rtQb/2NAmhPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edUN4Jpq; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2350b1b9129so16914305ad.0;
        Mon, 30 Jun 2025 20:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751339589; x=1751944389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pKagI/uKZavpnPXWd2IRAUrbnxZhCEi2zh5SWU92oI=;
        b=edUN4Jpq6RQ3LQ2U93m83bI39Ixtx0Y47nFMGAYeP7RtWzWGfDwAUgryh97cD5Z/2L
         2IOsmRzITiTA03W6xZNxeMfqQuZtYbCYP3LPrni45qgGEZgpSH1v2K9A5A2wgxzNE/Y5
         fPo/uYIfpBq/57/Ep2MWj232P3x3hrrmLJYcPn3ymK9nq3/m24SHNOC3ZhBbtfh45Fg8
         jbhdWe1YKgS5yDKaVfXvHwQNhtE3mpB4fVBhtT8+9JusHitxFPWnPX4tX6UPpUtRcMZz
         EF2KDPcPgN4GhbTDcwjU+Rx5PdcW+es72jM0HpddzvJ4V/cIBxuZhSm39CY/KSrZuNtQ
         y+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751339589; x=1751944389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pKagI/uKZavpnPXWd2IRAUrbnxZhCEi2zh5SWU92oI=;
        b=DfKjQ/X2VCOVYnRqnfYMHnHdCHEnIIyPgKjPL2+0YA57CmRHY5LYSHARLciw/HkHQI
         PGx+07RhVOmMQPK28Y6FiOsLVPe5P52eSH6ZjlPVA9PNtvDPupydcWAPnt29UWwWQtYp
         sIa+RaZQD1mchseowd1w4ZJ2QudMzwSsjUY3ZttQmBZyZMK720ChSx+e81NAmQKytcxN
         cXCWc4THvWOn68mTyQbowvEU2ijh5gb6QI4hgonKZb1a4i/yNTNIkwWvIR0rkmDdSE+u
         yRlyQcrcZ1tZm1Kqlc0B/hS+ZlCX+/sB6IRjsFnlzwLTmg5Q5y2nhex4o6iaNGSHOLgh
         bQQw==
X-Forwarded-Encrypted: i=1; AJvYcCXTf1/gnNLCwkM10zWSr3jBE01mTYvCMo0Rl/e7+25wzd+KTSl592lXDHFJraukMTokoxtXezTShvA=@vger.kernel.org, AJvYcCXpAHNf9Vl/UQu6h86nWqkJSiEU1OFoi0CmBCZjJ/Eg44nY/wwGJEC7CRwuQFcae01FmW3MjX9o@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd0HOiSrz21hZEtCehp53n+BBro1zib8IadCZDAdXk4qZSOnbq
	OBejcv33xepRGiNQPee74+Z9J81W/NKsb9X5HAfqhJPww8HrWsksq64J
X-Gm-Gg: ASbGncvofIQAtjA5xgsQJfeXBJNAJXtzvBFTttaPK1cDRh6f92Hm7DfOA09bSTPv9ve
	Z7wuTpHWX3019kQmQ1UMvWDGmlM9DiV7xyugI9kS5L4dLukOdxJpOmdTJrIWt2sjqnKK1gjvPy0
	8x8r1P66iw4Ql6Lu4fZaxP4Qlq5l3h2QYX8pxzoAHzY7aHMT88fPzpkPKDeDLqwv2U4twvY94Ok
	FVBKC98vgiV/goA6cKOLZ5TZAhQskQVXQq543mS3INKcZNs0KDV7xPEamZ8u3ylFg2FwxlmeFEn
	R2WkH4fT6/IK40Z0My4v/g02RRWP0tae8KGFhsPp8mRpdlE97hfoAlMpgn9Ulw==
X-Google-Smtp-Source: AGHT+IE51ppPcroswjHABdlBimIQsQRA2unHSkCGUpJFHQtLABYZ4n5ohDxrQKpSXU1+D2sLV/Cxng==
X-Received: by 2002:a17:903:1aaf:b0:234:d292:be72 with SMTP id d9443c01a7336-23ac4605c3fmr240392495ad.26.1751339589153;
        Mon, 30 Jun 2025 20:13:09 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3d27dbsm91597985ad.256.2025.06.30.20.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 20:13:08 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 658E3420A823; Tue, 01 Jul 2025 10:13:03 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next 2/5] net: ip-sysctl: Format possible value range of ioam6_id{,_wide} as bullet list
Date: Tue,  1 Jul 2025 10:12:57 +0700
Message-ID: <20250701031300.19088-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701031300.19088-1-bagasdotme@gmail.com>
References: <20250701031300.19088-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1257; i=bagasdotme@gmail.com; h=from:subject; bh=g6OtNn+6pJ2FX9r7LD6uzhKimbI7CNQILNu9JtJxROU=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBnJ/sdu+drPvXRakPvjoQDXF74SnBL8h5aL19l2bDvl1 bXn+PmbHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZiIiSzDX2kZcct3xXdSZ2/a tPdW7PGo93Jb5VTrD7Y3zTmgPG+mCBcjw7+gxG9Kv1kkfeO+C7zf8OjDzvL79/7yzbyZn6lfMmf DHR4A
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Format possible value range bounds of ioam6_id and ioam6_id_wide as
bullet list instead of running paragraph.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/ip-sysctl.rst | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index a736035216f9b7..6c2bb3347885c3 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2487,8 +2487,10 @@ fib_notify_on_flag_change - INTEGER
 ioam6_id - INTEGER
         Define the IOAM id of this node. Uses only 24 bits out of 32 in total.
 
-        Min: 0
-        Max: 0xFFFFFF
+        Possible value range:
+
+        - Min: 0
+        - Max: 0xFFFFFF
 
         Default: 0xFFFFFF
 
@@ -2496,8 +2498,10 @@ ioam6_id_wide - LONG INTEGER
         Define the wide IOAM id of this node. Uses only 56 bits out of 64 in
         total. Can be different from ioam6_id.
 
-        Min: 0
-        Max: 0xFFFFFFFFFFFFFF
+        Possible value range:
+
+        - Min: 0
+        - Max: 0xFFFFFFFFFFFFFF
 
         Default: 0xFFFFFFFFFFFFFF
 
-- 
An old man doll... just what I always wanted! - Clara


