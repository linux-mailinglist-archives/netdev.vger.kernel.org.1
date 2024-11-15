Return-Path: <netdev+bounces-145235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD509CDD3F
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 12:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D652832F6
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 11:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB0B1B3938;
	Fri, 15 Nov 2024 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1IVOKUc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4EF18FC92;
	Fri, 15 Nov 2024 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731668862; cv=none; b=PtRBxBdBbQQj0yBKglwOEnkkwfSjAiYHZr0C8dfVXYNuhiPVYaGCT3Y8eRazHTMiQBPICzWOcNo5XPwpcqaeJ1dgtMPYv30Dd1gaeEq/h18XwNGHNbMbo/z3KNIFmTDFDadBzpyNxJYfy5ZbAWlG9x9ThmAL2bxuipA20mUYaIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731668862; c=relaxed/simple;
	bh=F9IcBAH98/nD2miuExOgtqzna16ZxOdtVAV/XT4hAns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oF/Xp3cvthFmMcs2vJzr0L6hUbAv/V6JkXHXbQJdXqdToHNqHqSQSPh8dntzzeNxX46P7KRQYqHwkgja7yhAH37gToEIEkOrpjoCRUUxbgtSKzdsp7DzU2xlV87cQ3C2ZRfSkdvI6yu/cJrXOXWUFjRuS05kHsifnYq0t8nE/6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1IVOKUc; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7f12ba78072so1245275a12.2;
        Fri, 15 Nov 2024 03:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731668860; x=1732273660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+s7uyzZf8In4uLin49oKAReXMClKRobUSg+yMBzWuAs=;
        b=X1IVOKUc8AtUqsF8efkQgjU942UU7rt5DZ3KF0HZ5DirnaANqREfYCXWkYOhcAB6Uc
         4Z2EbjrI94U5zVS7nXP0O5YOtaz95auqTqvPKS9dXfRnyL7I0/4f2/NMbzOFDvUHKRaB
         8ESaRb9hHHDJLHjsDWvN1pUSRFlZy6iQhF3f5hGZLy/aFTdyzPLYfob4TLo7hQy6djgI
         xxDY6HlnMDJtgvG0XCRBsT05QZcC+r0jDFnNYqJ6SNirylf+m2Fpn/y0l42V3FKRH1CC
         pbmGf/zTnFJkj+d6qVWc3HO2PDX7vaIJAkD0O8NOYnUlxsQ6G+wSqg3bWwDKa4/hd0pl
         72bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731668860; x=1732273660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+s7uyzZf8In4uLin49oKAReXMClKRobUSg+yMBzWuAs=;
        b=fG22sgrq2+W6Q14pKChkuthgLqwuwVvJE4f7lL2VABdmVxV/YW5XxXn++QKph+Udnm
         Qg5zqG1fcFn7hIMtpOjHf63undDTSPdCgssTo30DG+pcCNYwl2j7KPIKvLeDqP2MyQlW
         G5DSOQ1YIxtnh0hu5NbAYqbFfgPjh3Hgnke9Shgy+3Twcx9Ss3h+7ddb3/yyeqfTPwT4
         /RrIrRJswYlBxls70E85pAHFTKU7H+cXAbE+82qC4dPpepGlyMf3ujmhiujX9+nCbsCU
         xYQnRmGd85KU6lcW7vOARCtEFpMQP2jFUVRQTfrHgM5IppQeooal0xtjlPEY2c8XK9Do
         0CRA==
X-Forwarded-Encrypted: i=1; AJvYcCV3m71SVnfUX8+tLzXW2im6hpC+p6xIazmHdCGKwYKrv3lIiA64DTRWS1txC1np/dax4bYuUtfRO/qoR6g=@vger.kernel.org, AJvYcCVFOBPVyBn4Xq+85fTAoOnP3rm235NFsYcd+uDYDvXlkOOtNWT158wLsFx4tOUXNka2kca67k9s@vger.kernel.org
X-Gm-Message-State: AOJu0YxAJmbsPo5ZcWXGHJAoMaAQVobuDGRqAyptCZi3/zNU9KUy4T/M
	9rVKR0d52jp/+bnijUcyCdyVcIfcRCROapPMIKKSaqEk64ty2yo4
X-Google-Smtp-Source: AGHT+IE0jUvjlIv9ahz4VOxkviACSEPPm9XERK0CMbvsThmxdZ/es+hFfDJJtHURfB0yuoqlI2BAuQ==
X-Received: by 2002:a05:6a20:7f9a:b0:1d9:8275:cd70 with SMTP id adf61e73a8af0-1dc90bee4e9mr3125851637.40.1731668859858;
        Fri, 15 Nov 2024 03:07:39 -0800 (PST)
Received: from HOME-PC ([223.185.134.27])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72477120bbdsm1100341b3a.78.2024.11.15.03.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 03:07:39 -0800 (PST)
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: Jason@zx2c4.com,
	wireguard@lists.zx2c4.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dheeraj.linuxdev@gmail.com
Subject: [PATCH net-next] wireguard: allowedips: Fix useless call issue
Date: Fri, 15 Nov 2024 16:37:21 +0530
Message-Id: <20241115110721.22932-1-dheeraj.linuxdev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit fixes a useless call issue detected
by Coverity (CID 1508092). The call to
horrible_allowedips_lookup_v4 is unnecessary as
its return value is never checked.

Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
---
 drivers/net/wireguard/selftest/allowedips.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireguard/selftest/allowedips.c b/drivers/net/wireguard/selftest/allowedips.c
index 3d1f64ff2e12..25de7058701a 100644
--- a/drivers/net/wireguard/selftest/allowedips.c
+++ b/drivers/net/wireguard/selftest/allowedips.c
@@ -383,7 +383,6 @@ static __init bool randomized_test(void)
 		for (i = 0; i < NUM_QUERIES; ++i) {
 			get_random_bytes(ip, 4);
 			if (lookup(t.root4, 32, ip) != horrible_allowedips_lookup_v4(&h, (struct in_addr *)ip)) {
-				horrible_allowedips_lookup_v4(&h, (struct in_addr *)ip);
 				pr_err("allowedips random v4 self-test: FAIL\n");
 				goto free;
 			}
-- 
2.34.1


