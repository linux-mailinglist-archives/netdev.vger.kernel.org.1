Return-Path: <netdev+bounces-208322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07463B0AF4E
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 12:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B673B9E8D
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 10:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B931F8725;
	Sat, 19 Jul 2025 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeG4TdXa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B433AC8EB
	for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752920340; cv=none; b=HXvT8A8tA0DtpWagbsmO0mQ4s0DSJEyFvXzazn60UY4HPR1WkzGNlpnosOEfHJouRnrdxgLwqt2oWGYP2+UpPwX6whr1qXIUO6jRwc7qkt+eQbc4l0sC+0CoxFclX10IijFpXoW7WiOdMV5XyP+XoefNsPCQH4Zm+AQ+yEy1FBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752920340; c=relaxed/simple;
	bh=MhpEgvgj6Vg1T/xy5dxQYSQnZ2t3W6+e35aAoVn1YI0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M2DGSUMnOFLJnmVTk/E9ybymReeOXa+qz+VZQQvSwrWar7l2UemSpkNf7F9bWCrg9C0RM8zqRC1vSu+xUyD7pYCFQWMnhka8PS6sKKiHCd7T5SA5gv47a0X65wWIvv0SKghS44DMTeITOiulFrV5qCDqoVRyC5H2m/ZE9nugP3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeG4TdXa; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55a33eecc35so1459945e87.2
        for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 03:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752920336; x=1753525136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TO+NdEZN/z6Y3MR7TZVDzCn04AtXiokspHTpyURVY/s=;
        b=TeG4TdXaZmQfVbkTmcOPG+qzevvE3uDoXpEo5cEanaFN4bFjPsGtsjvwLg3RJgh+qP
         Pq6uN/yzoH2hit8CYGHVuJmNyfHqvThdo9IXc9FVl021SyzuRE2li4BZSFx3OJ/W505e
         fTvLOL9yG6rZpIXp+ks45PZV2+DqQ58TpMuL3fTfsSl/n99zVT8eGzZQx6Vuf94hlcga
         4toyGvHOrB9PbF/gOJ0OdNzmGvC7KRBOUL6e4MO+NYSRQyBnLxL7rA0OaqL8a2lROb4h
         A8puJBS4VkqcmIiQAE6zB6SEKK1AhpWniZwPr+QhZPiW25KaCYmQhWeHS824iCLtaoND
         OYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752920336; x=1753525136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TO+NdEZN/z6Y3MR7TZVDzCn04AtXiokspHTpyURVY/s=;
        b=fiU2vWBtb7gbSQwrnG3ypkKPYjsIM9Yst/Gvtrpem24lts3edi4JlAesBhL4cChWTH
         2QnAurOW/FGI9MOjhQHInPq/mpV9uPYZN3JeO9sw919pAM2BGqX0SrnmTjZHRpPJMVsm
         2PMXKpUe/aFR/OBoBhUj1BC8vlA3BKcJ7+aHtgvXA7qGC5jHMTh6OPIssVx4zti7XSjX
         Kg8CQQTPkdDE22FKyRYf/+LUKFYBHoyn3adzA0Qt4zZIb2qn3vaS64NCh6Cq2AxKWCKC
         hAIFNmzbeTgyx43IwU49YY3bP19LlIVopiApJbU0LfQ4oKJu/jr3Sg7fDPxzXb/+ENe8
         exwA==
X-Gm-Message-State: AOJu0Yxuxuu3DTtLajVhHGYUtIFSoj0Eu9HgQNrzWwo5DEW+G17E/Z7X
	KY/T9a0AQkCZflDGOomX5ciSPhwF5qOJEdcKn3ZjtVGIZZzbOQUU9XDTL6YEjOJQVYY=
X-Gm-Gg: ASbGnctGl1a5SMNsv1PeYoUvoUcEb9w6+2az5e7DxS7k4EJNiVgx82YcM3/3vXg3l1q
	aO+HU7puXww3UevQMTpGFUYMR3GClqBwXieYWpUFy2K9tjCLOtI82UuMYhmtXIL/oUYdViW+z5Y
	2GfhEEe/vUg7dUtIA1U4vtRX7G/ivqBNBGBuwDWht65sJZe208065SzuirxT7oikRKATWDH6Ks0
	HCqR/N49Wyq/c/PE0Hubnlp9XerhSieTeMXpeeyMzy37OnfDZrAh56R+7Ro8iYNf5580/XWnk4r
	ZQKegvK2FQH9Nvu6wOL0dkmfaA+ixG5LJOseVq1xpjfcnF7ya6Q3IVZzTEnONFwjyzsWxS9UyOO
	xC7OuJeVeHzL/WEp1QQ9sVsF7PaZ7qAFJt5c15QD85u3yQtKtTCE27+nMPEifWXZQjwRg2HW9
X-Google-Smtp-Source: AGHT+IHAIy4+2Rrm9dygiaMuuShux6GApMm8u03Yt6s4G+n9HFNfWoDBKKwarARZZJnLCzOQ28cs7g==
X-Received: by 2002:a05:6512:1310:b0:54e:81ec:2c83 with SMTP id 2adb3069b0e04-55a295a0943mr2995226e87.18.1752920336094;
        Sat, 19 Jul 2025 03:18:56 -0700 (PDT)
Received: from lnb0tqzjk.rasu.local (109-252-120-31.nat.spd-mgts.ru. [109.252.120.31])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31dab938sm660221e87.203.2025.07.19.03.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 03:18:55 -0700 (PDT)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: netdev@vger.kernel.org
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH iproute2-next] misc: fix memory leak in ifstat.c
Date: Sat, 19 Jul 2025 13:18:52 +0300
Message-Id: <20250719101852.31514-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A memory leak was detected by the static analyzer SVACE in the function
get_nlmsg_extended(). The issue occurred when parsing extended interface
statistics failed due to a missing nested attribute. In this case,
memory allocated for 'n->name' via strdup() was not freed before returning,
resulting in a leak.

The fix adds an explicit 'free(n->name)' call before freeing the containing
structure in the error path.

Reported-by: SVACE static analyzer
Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 misc/ifstat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/misc/ifstat.c b/misc/ifstat.c
index 4ce5ca8a..5b59fd8f 100644
--- a/misc/ifstat.c
+++ b/misc/ifstat.c
@@ -139,6 +139,7 @@ static int get_nlmsg_extended(struct nlmsghdr *m, void *arg)
 		attr = parse_rtattr_one_nested(sub_type, tb[filter_type]);
 		if (attr == NULL) {
 			free(n);
+			free(n->name);
 			return 0;
 		}
 		memcpy(&n->val, RTA_DATA(attr), sizeof(n->val));
-- 
2.39.2


