Return-Path: <netdev+bounces-131013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BE398C61A
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B441C23A35
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 19:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9206C1CCEFD;
	Tue,  1 Oct 2024 19:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LujJekaG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167071CB30F;
	Tue,  1 Oct 2024 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727811247; cv=none; b=uHEjAOJ4FF3NggqVkFKEN24ScZA28OtRerk+1XrydPRd0cGhq1rOd6fOHxitL/A4E2yeZog8/v2aA/sBkL/F2oJO2q9UxI1Vhj4gVn49qsqmmK06sCx+qH4SffCvFidKb7ideB9FYCDPjumka13pUtxybmK/CJcR7Mn1VPISTWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727811247; c=relaxed/simple;
	bh=0uw9FYsEW60piYVepJps6DlGixYkTxjq3bzeGZMmJOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WaxMV3/jtPlz1EIDKjFwLKft0rtzNliSL4g+jDHFuME4O7JEFkgKYP1Q24K+5INvTaSLND1s+0eFQBP9pXTlL7Cj5BUSiNUzJvAELuW1XZJRB2Scr1Wzl4/MrDOlzCALSyhLHxuOd2eqg2ThHhgdk622Vn/4J8WVpCBMCORLdfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LujJekaG; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so5056244a12.2;
        Tue, 01 Oct 2024 12:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727811245; x=1728416045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7eijFBIczXssAvMKHKfugN8TkFnB4cNonrVqNg72BY=;
        b=LujJekaGBVS1eyyAyiM+hgZvxO4rU9hVCeSnFweDUUvV6E14AFZOl7CzpPoFEPEPSO
         ccN9YNMNLuM070BBD2wW+qkspkHLBkTJ/7bjyEuViPs1aARBBkNVsj91qX4kipVIAe6g
         ib66uiH8DEAEZywIY4Wkz+9rUXUf6iKCdbaSvpqFIEgNcn1RB+9bfRbC0Ku0db4x8B/G
         MtdOjx1gifD7NDTsynVucPnCKmhEEUMaf8WcrazcWb5dSD9h8+oYhOUI5aGtyKFuX1gl
         Q0VsnxmuKsm++4O08nZaEyqNJWP+t65iBunth6n/O+neqNjkgnWtD+5sqdQtwu0Id1jb
         OXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727811245; x=1728416045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7eijFBIczXssAvMKHKfugN8TkFnB4cNonrVqNg72BY=;
        b=sJt30OZItlhXBhWEG+8vJ7LmQ8Q81B0zIpFwXu0K6LXpKlDizZ0JpdFquiUp2jGw6/
         MKdO2LqkuDmhWmNOEfbF58qSTTlkMh/NE7SobiJGAjV/niRvVPfpUmHa/jqFazTtrrq+
         LEhQKN3sDcNBJxGmcPnFP1rAYTFNWYX7xcpEMzNYTC2Jgf28QnZ9FUoVV9Yk6fDc07N3
         nlUJZEGeSsYalUAVHHn5hZeIJurtDWwJy9soA7AT11RFba81Xq+YLTsPxTOoftAa7jn8
         xaLICS+KhK/IHYHa0/0jGuuaX2817R3e+Fwl1ArJdgTi6yxDV5+DkhH6L4OvdE5nDwj6
         aQKg==
X-Forwarded-Encrypted: i=1; AJvYcCXWweCB6mmaJFXzMwQ3RsT/dKQR6jhB2b7CH6/LE4//aPRY/gj1B+LwvLQ3+SJXFgfx/Fs/gXQfR2QcV6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfaGol9aGvsh0Rr+7i/YkONN2cC00iG+pPasZZGYs+ysLeSEjp
	QUPVtEHOqetlbNc1RuTKU8+U+56SeBgdDdez++h8z40kXW/XfEaT
X-Google-Smtp-Source: AGHT+IFB3s+WqtB2CcaQF80MzkJeXy/gMvEXx4lmIlesMcsF/dUzKjwqDDr3a+tmHuHjOK0G+6fnPw==
X-Received: by 2002:a05:6a21:174b:b0:1cf:6953:2872 with SMTP id adf61e73a8af0-1d5e2d2a89fmr1111951637.48.1727811245026;
        Tue, 01 Oct 2024 12:34:05 -0700 (PDT)
Received: from mythos-cloud.. ([121.185.170.145])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2b391bsm8688976a12.22.2024.10.01.12.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 12:34:04 -0700 (PDT)
From: Moon Yeounsu <yyyynoom@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@weissschuh.net,
	j.granados@samsung.com,
	judyhsiao@chromium.org,
	James.Z.Li@Dell.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Moon Yeounsu <yyyynoom@gmail.com>
Subject: [PATCH net] net: add inline annotation to fix the build warning
Date: Wed,  2 Oct 2024 04:33:52 +0900
Message-ID: <20241001193352.151102-1-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes two `sparse` warnings:
net/core/neighbour.c:453:9: warning: context imbalance in '__neigh_ifdown' - wrong count at exit
net/core/neighbour.c:871:9: warning: context imbalance in 'pneigh_ifdown_and_unlock' - unexpected unlock

You can check it by running:
`make C=1 net/core/neighbour.o`

Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
---
 net/core/neighbour.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 77b819cd995b..6b5ec9a44556 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -441,6 +441,7 @@ EXPORT_SYMBOL(neigh_changeaddr);
 
 static int __neigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
 			  bool skip_perm)
+	__acquires(&tbl->lock)
 {
 	write_lock_bh(&tbl->lock);
 	neigh_flush_dev(tbl, dev, skip_perm);
@@ -453,6 +454,7 @@ static int __neigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
 }
 
 int neigh_carrier_down(struct neigh_table *tbl, struct net_device *dev)
+	__acquires(&tbl->lock)
 {
 	__neigh_ifdown(tbl, dev, true);
 	return 0;
@@ -460,6 +462,7 @@ int neigh_carrier_down(struct neigh_table *tbl, struct net_device *dev)
 EXPORT_SYMBOL(neigh_carrier_down);
 
 int neigh_ifdown(struct neigh_table *tbl, struct net_device *dev)
+	__acquires(&tbl->lock)
 {
 	__neigh_ifdown(tbl, dev, false);
 	return 0;
@@ -848,6 +851,7 @@ int pneigh_delete(struct neigh_table *tbl, struct net *net, const void *pkey,
 
 static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
 				    struct net_device *dev)
+	__releases(&tbl->lock)
 {
 	struct pneigh_entry *n, **np, *freelist = NULL;
 	u32 h;
-- 
2.46.1


