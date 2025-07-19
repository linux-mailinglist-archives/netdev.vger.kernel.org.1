Return-Path: <netdev+bounces-208324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE0CB0AF60
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 12:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7293F7B1DF8
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 10:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE35D236453;
	Sat, 19 Jul 2025 10:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTWFWFuK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D17227B94
	for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752921741; cv=none; b=My71gPvAdVS/y6039NkedE/nEBdaRTq243361JWRBKwrj6i6XqxUnBQD26BeKUzK58cegzyG55K7bl7vaL83+FqqaQTr5GTsa8/adKkPm9dZ1go9Dc4f8OfLGzPy4EbEZ4W1ffK90qSlUePqMt54NVjXFFHa1Pjjg4W+cEO2WnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752921741; c=relaxed/simple;
	bh=zHEHznvKfLdijnrMIqa1qeP1Kjf5Ai5IRGhfcJ/0vtk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MfESTI0cb71kywKPU4bCswh7zrW9zkgwvYWOF+j7cCUdaNr2Yq6oSMIpUOW8+e6mz0ZQZD4vHLP+ztD/xD+UF+tdoiKjaZ12Ldycf1OF5dzdzW2jHRiYQ7eM7W+gMOgH35R/Yh3zOhPXrMTPDgBlBOOGjmAY0so/QV8LUA4AloU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTWFWFuK; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55622414cf4so2528524e87.3
        for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 03:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752921738; x=1753526538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=15tZw47VGFsgK8pchiD4COVMGT6khU7yeV0jyFAD4uM=;
        b=XTWFWFuKWPEb39VBVZdWCQMjRHBEfpGC9xxUxVfH/BrCi97EVtgj4olu4ZHhBbkq18
         p4Nr9bynrrFF3Ofoi34KH8US55JeoZVHbA9CrHCZU5Sdx/FCrBN2zPbmgf9K0OLXS9av
         zMdqXg0b8sUu4lriA+s0An9xdY3Z9BdjUzSirKnyQJyY6d2jDUeGRl6AQwQ9PgAP1NRi
         7MsTf04FjaQTgC99Bg7z7yHcUqxEfSpjCrSRWuKGMnzhppujXue8wF/QO35P0BqQ6Pq6
         DI589bwbfEJtfk+tOG6y5XTGKLT3gpImnB75t3YwrY8hLeK80uGUvdMQCRvvB+e4q3FK
         VRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752921738; x=1753526538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15tZw47VGFsgK8pchiD4COVMGT6khU7yeV0jyFAD4uM=;
        b=Zw0OTlxXrdC6kus2mSGKRlvFTHJBq/byk03hIK6IgCqvf2UT9Z3Pivo8dVwX3HDnJp
         74EgDVxMWhJYWnUS2RXese7mDGy1VcHyGS2UwzP+HBUiVBCeJ6zf5fbogs9KQZ53e6Qk
         CX5ojE75WjmiH5ro8f5Sdj/ghYPd6nFozCo3sIBbHc+a/e6Ts2nvPnU/cfCbpeYKBnnd
         zK/mcj5maNDQUyHow2a0qDHn44H8Y4pxq2YjOzaSGd5gjCGTN2gCSdz5E3ZLwnt9fc5L
         HGZ9AYlo1b8Lq+CRdmhn5F1kQZcRSl+hw/ZaKHGu2oHMfJrfwyqrne9ovtjjiC+Rmrxv
         SV6w==
X-Gm-Message-State: AOJu0YxTvRoTXPOXzM1qiypw4kOb/TDls/7xsAsuTaVjUH44RNVyPYn0
	U11srNyx3bLEzXy0O+NsPqJY0iSEtzciOmeI6WGWEfzr2D693/hELuDmfxkO1ccQ6Vs=
X-Gm-Gg: ASbGncvtVDOPfyuwhtM2Pl2ptyNFuBtI2pxz5CcBbqvP9FOc4jnah58/OYChX/anIJc
	kRGNyY+FkEbGiQwmHIxa/bWT+YXyCDoR44i7ByjVcLSE+mUFOn+H57sVqi3WBW/A4sovFRj77Y/
	r3kJg3obm0yxzqCuqNgnSMtZdtAUgIoptZh2Us3fod1kiGWYaK8OfxRPqUhvW/JmNvdY46sUOSR
	mzFsy8xbL+mmzcTb5TtTwpqNjLhXuJEh6XwF3+ayCJ6OqgiVH8UkH7N5jgF1Q4Rqvdb6wOMjk3B
	RAKN3ygvJNkYkpL7jrJz6T2+nLUSGvE6fJ2IAE9ixw5SjpLoBF14UCVQA2/B8Bjbx3PP0pq9GU+
	svfkUkA1U+pF1lBz/SyE+ObtuIxymHXdEQ+Wq2FBHfR4+5KS0jFy0PQr0WL9d+TAnU6MXxwY0
X-Google-Smtp-Source: AGHT+IGEVVlRNuvkOiZAs74S8h4/DvzHjaMg5IeVlQiI4k2FohkwPo9EnnL/CNUnu/pQmB9/EJtZGA==
X-Received: by 2002:ac2:42cf:0:b0:553:d7f1:6297 with SMTP id 2adb3069b0e04-55a3188e89bmr1280789e87.34.1752921737520;
        Sat, 19 Jul 2025 03:42:17 -0700 (PDT)
Received: from lnb0tqzjk.rasu.local (109-252-120-31.nat.spd-mgts.ru. [109.252.120.31])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31db0098sm669728e87.225.2025.07.19.03.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 03:42:16 -0700 (PDT)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: netdev@vger.kernel.org
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH V2 iproute2-next] misc: fix memory leak in ifstat.c
Date: Sat, 19 Jul 2025 13:42:12 +0300
Message-Id: <20250719104212.34058-1-ant.v.moryakov@gmail.com>
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
index 4ce5ca8a..3de20c63 100644
--- a/misc/ifstat.c
+++ b/misc/ifstat.c
@@ -138,6 +138,7 @@ static int get_nlmsg_extended(struct nlmsghdr *m, void *arg)
 
 		attr = parse_rtattr_one_nested(sub_type, tb[filter_type]);
 		if (attr == NULL) {
+			free(n->name);
 			free(n);
 			return 0;
 		}
-- 
2.39.2


