Return-Path: <netdev+bounces-167057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3322EA38A1D
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 17:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42FC53AF4E1
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 16:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2EC226176;
	Mon, 17 Feb 2025 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltGJKeGg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC40225A2B;
	Mon, 17 Feb 2025 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739811257; cv=none; b=T89vF0+D3BDbl6M+iCViGje/WqiuYiGg9Kkcb7Xf1FNNDwtoOK6mgJUY6ZhvHsMNIz8BsID3NavbZ8Zu/mdqq8AzdRceMK2xFzDQjl8v9VAOd9jUNVM6Fj8WGGLt5VtZZbN0WA/n2sB8493oRGMMiwPEbHX/9C2RZtkJ/82HCjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739811257; c=relaxed/simple;
	bh=5D/fG4ZjzKd3+HWvMQKBTbyUXZfiHa7kNagq5sB0SaA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pLIIBLsrMCvye543w4IO/j7pZUtK90hPWbkUsVVfb8+/mmg57JdLr2QTis4IJUhjX7A2CYVwsERfWmXCLX3Zh5MvBY0sUqSCkKM3lrgkZA0F87b/E/p1IaN5WfzfMM9kQP+O2uTJrpy3jCjgyCXfCJydQ08H+cnVAFyqcr/Ew4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltGJKeGg; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f3f8906c45so556658b6e.2;
        Mon, 17 Feb 2025 08:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739811254; x=1740416054; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XfkHaioxJkT7EUDNRCAMw8vIe1lKe4biHbzBWeQ03dE=;
        b=ltGJKeGgyqN5Kz5Q4GzxDNzni8cbRoQv7BmJSl/Di3ZvLFxcEHEOzjNffhsgdB4KQ0
         gy3ObEVodZL/XBtWADCR2aoeiT4PvHioT196/C12R/Wuee/OWhefMxPwYohppeNP1SUy
         FvwYDqkjR5W+K5ibugJJJHMd1aSqDE7J9QJglqFpHhnPxkRCbxts2FkA45sp991DWSJr
         xs+XI9q41mQApKm68eIioeVvVbQVaoxIcCIiJa84w4H6oJB+3IJCYRaSmSHQ1kBoxk3n
         5FR8/KxX+18yjdbyORD2X/G7NUgQaYpmvPCIH1ugoq+WGdLE2xfd4X9bqcTdWJpel1DR
         2v4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739811254; x=1740416054;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XfkHaioxJkT7EUDNRCAMw8vIe1lKe4biHbzBWeQ03dE=;
        b=OpUqPKn40ORvHkbD7xGpsAo+11TZgHgs2b9QfTzn/HUoVWyzaRrEwuMskT5sZX3C6B
         hbGTEpHNPSuLTUiBV7VXf0o15WFIwavhg4KyTlQW/DC863pj6x7tTtFca17Br+olgu60
         N6pHwTTDe8URgeJCkDf0JYtrH/xoQ2mgil/sWlmIQoiurY0jv22phOHFzFFuKvdiJ8H0
         HPMHP/MAXQFW06A1zJ49xKLmcr2YUA8QP4/jIDDpBbUoUhadPP9OYErqdzZAZag0eN75
         1KC2mSTVmZKWbBe53zhQeNyaZkSpNpOrfG0OZpbIuGNS60M2gAe+qdm5khQPSTt+v7IU
         gWsg==
X-Forwarded-Encrypted: i=1; AJvYcCV6ippo0nSiELgva+AfPgJPLB/Jg1qgL3jNEe0J1FcOyGKjpOPfz4W3lzwIl6n2DNU8zH94UAkAqAcbnAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjG+1LnX967HM0K1OdgPzpQFadx6bKQoai2cJziLXK0IpiWXDF
	TiSTZUHPRnM1csUGVsMWX5XwtgJ3InCh3udcuFyZrCbVyWCUAOZPxBRul4fPyDV1d9vFs8j5Ddw
	Bw4+HeA/ErPb45dWFVX9ITQbBQ6XgSnVxXD4qAw==
X-Gm-Gg: ASbGncuzyg5KMd14alTlWk6ZwcKn5EKKc94KrCIA/cESSu13kYwGg/TajXvbXaiijYZ
	oIt5FhaGRtScxfIqqH+QXmNgtx6CFrZWzOqUn6SJ8RW+rvrWOd/YULbbULKy/4NcShhuG+X0=
X-Google-Smtp-Source: AGHT+IFjuJOL5PoNWhsga7Pb5rKsRqndy3lYvUnfhP6yMunEXDlb4VnolyLJdIOIy+/tKfm6SZy19JOq/XYQ/TENPgA=
X-Received: by 2002:a05:6808:3195:b0:3ea:f809:44d0 with SMTP id
 5614622812f47-3f3eb158d93mr7508443b6e.35.1739811254077; Mon, 17 Feb 2025
 08:54:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Mon, 17 Feb 2025 22:24:03 +0530
X-Gm-Features: AWEUYZn6JKqZSJ7ECKNJ35xDHo17HDqJBr83XFL6hIs-ZrQ4R901HdJ44r7L4z0
Message-ID: <CAO9wTFgtDGMxgE0QFu7CjhsMzqOm0ydV548j4ZjYz+SCgcRY3Q@mail.gmail.com>
Subject: [PATCH] net: dev_addr_list: add address length validation in
 __hw_addr_insert function
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, Suchit K <suchitkarunakaran@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Add validation checks for hardware address length in
__hw_addr_insert() to prevent problems with invalid lengths.

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 net/core/dev_addr_lists.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index 90716bd73..b6b906b2a 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -21,6 +21,9 @@
 static int __hw_addr_insert(struct netdev_hw_addr_list *list,
      struct netdev_hw_addr *new, int addr_len)
 {
+ if (!list || !new || addr_len <= 0 || addr_len > MAX_ADDR_LEN)
+ return -EINVAL;
+
  struct rb_node **ins_point = &list->tree.rb_node, *parent = NULL;
  struct netdev_hw_addr *ha;

-- 
2.48.1

