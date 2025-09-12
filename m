Return-Path: <netdev+bounces-222691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98165B55722
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F5B56810D
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 19:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835392C21F0;
	Fri, 12 Sep 2025 19:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhl3lePw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C722728314B
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 19:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706841; cv=none; b=rYD9tsWoz4nShcgdBf0evQKdQs0WeuosuEluXEuHU1YNYP6SThRxUVm+Cz/6xoHzGFVwxDxk+GOSAaU+Kn50bTsu5EpSzGXUs2Tz/HR0ks/VqnAbaMwW6M+/KrGD+ZqE5ZSSVs0d8fnv2eYfiXEiwe57TWj1Z8f6nnLnEAmou8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706841; c=relaxed/simple;
	bh=S++nbLXYGUNn+kPv+4a4KLGbhT3HHy1Lef48AXgBcmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SA3TXz+1DXFY7pIpDzdnEtMjcVon2P4OafKZR0h1riue5lLdnt4RxMt5qZAAgUqaVFfK1euaeqXojcNBVAV++325m2z6cdVJO0g64x/vlXEFc5n/UwNzHDzepbAx1XoMI6IGqmw8peY7LrFofXd+ifZq13Jky0jHG4ZonD37pvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhl3lePw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so20911915e9.0
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 12:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757706838; x=1758311638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cM2EwFi4Xi2FPT3nNBJPMpu3J3wjRZsJQ3rXDogFCog=;
        b=hhl3lePwwlUtA7VcbLZcOvxhs54vf2r20WY5booo9eAhAnD/DirKdGvC1dWXvv7Z9r
         L9KoiyN/zFdw/0TilDcPPe37QaSi8QRnYpQ9opj/WNed8Y3qPs9JK6s83GIlXROwC7Ws
         xBGuTQGApgu/Dq9ahhe0QokBI0x92zBr5JchQUMffNC+a91+CjtReDQi638HYQtxLfk0
         qSTdIn1FFLJdKaLvOI7pUaPw/2akA8qcT5qgDQndAepUOTugHOIiW7hbkeJN6RPHCoD8
         ARuS2z6E0lTn1ArDoKZ0G6se39sP3xQOp88VMzBaiEUNc2G8gMqDwVoDpLBdgNFvNLcC
         Qd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757706838; x=1758311638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cM2EwFi4Xi2FPT3nNBJPMpu3J3wjRZsJQ3rXDogFCog=;
        b=HOQLngAvRrqnoULXuUHlHVzaCvXJSrdMzEJy+5dw1mTkfjh0mJ3gtMYYKxVWVDimjb
         qkMPt06qxgiMSwqGiruGOQ34OZr18ah/9eW6LA0p+Wwg1OnqHa9pUanDsaejBS+ns1zB
         gS/j4WHygP0S2MYCPRhBa4tVwz0t3oCVYMagW0Zt3PjRwu0G8Dc7yjdyuN3zZ13XeJ1/
         b5zFOMwZMm89k2alSu/wtC1CBYWpW0jeFxIjMSUgklqOVQkRPmjSE2nvdafk3VDr5kyd
         Kq02bJHh+kLzgpkw7rDTwkmtZf4A4/OUyDQa6rRhBLSqIRzCOrCbZ33IGjfB6dOd1wzt
         BMSw==
X-Forwarded-Encrypted: i=1; AJvYcCXGO5llTN4VyiWZfNRHLsDiOY4ivqL7YdIjbugTI/oeXhDZuELNss+dXuZO6Tkr9COVjQYhFfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdvTGcieZkfHu7MiS33kg113zLcov9jjZy4kyAo80tMxv+SUW1
	5TUEXUO2mOUk5JlMbb8oopAWhKCDnxaWf9rz5iolJo96TGmiX97TfgWx
X-Gm-Gg: ASbGncszw6VKDhapLoefKgFB9OJRlDf3WIKoRajK9uZ1Zf9OhCtEgZPXDfGtbgPqfag
	6BPMQqbyzw0cllgI86iwJ0ACJTL/czbIwYzy1XX2zLCuMcwvy8/pJPaNVdbJdC0k+U92VBGpbdy
	9y6W/z9yCc3m9IaWUtLwCb5G304LodScQ0i7CQvv8lkaA5aKL0tNIHl561+z5JjpEm2rbLKUEsb
	qtbFL4Wz/KA3RoLbl54wWWXkJkxHP4kDTijA4byDda2WJmbanV3VvGfEJIZcDCc2YfekyGKmdg5
	oK3sif015zEqBwycdUFmT2e5qwCiTZatbokK1/8zIApLRLkW4eor0vgd+asOQxtrLEWUcS2MGfT
	bh34vWgcnX621WpDbm/5HjeD23acJ1+5+bq7dfcw6KRg7YjOjeDNyPrQiZwkafwvzpl+8WzK1
X-Google-Smtp-Source: AGHT+IHhUSN1KRgjO7FW8UWVga5t6VY0VlIT576vaao13oDQslNXzdFjIiW1xn/xILoGBvdikE/Pcw==
X-Received: by 2002:a05:600c:3b19:b0:45c:b61a:b1bd with SMTP id 5b1f17b1804b1-45f2129bd63mr41142815e9.18.1757706838188;
        Fri, 12 Sep 2025 12:53:58 -0700 (PDT)
Received: from yanesskka.. (node-188-187-35-212.domolink.tula.net. [212.35.187.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017bfd14sm74650375e9.21.2025.09.12.12.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:53:57 -0700 (PDT)
From: Yana Bashlykova <yana2bsh@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Yana Bashlykova <yana2bsh@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 04/15] genetlink: add test case for duplicate genl family registration
Date: Fri, 12 Sep 2025 22:53:27 +0300
Message-Id: <20250912195339.20635-5-yana2bsh@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912195339.20635-1-yana2bsh@gmail.com>
References: <20250912195339.20635-1-yana2bsh@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add incorrect_genl_family struct with duplicate name to test
error handling when registering families with conflicting names.

Signed-off-by: Yana Bashlykova <yana2bsh@gmail.com>
---
 .../net-pf-16-proto-16-family-PARALLEL_GENL.c | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c b/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
index 17f869ece2d6..1db5d15a6f2c 100644
--- a/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
+++ b/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
@@ -1077,6 +1077,18 @@ static struct genl_family my_genl_family_parallel = {
 	.n_mcgrps = ARRAY_SIZE(genl_many_mcgrps_two),
 };
 
+// genl_family struct with incorrect name
+static struct genl_family incorrect_genl_family = {
+	.hdrsize = 0,
+	.name = MY_GENL_FAMILY_NAME,   // such family already exists
+	.version = MY_GENL_VERSION,
+	.maxattr = MY_GENL_ATTR_MAX,
+	.netnsok = true,
+	.ops = my_genl_ops,
+	.n_ops = ARRAY_SIZE(my_genl_ops),
+	.policy = my_genl_policy,
+};
+
 static int __init init_netlink(void)
 {
 	int rc;
@@ -1104,6 +1116,25 @@ static int __init init_netlink(void)
 	return rc;
 }
 
+static int __init incorrect_init_netlink(void)
+{
+	int rc;
+
+	pr_info("%s: My module. Initializing incorrect Netlink\n", __func__);
+
+	rc = genl_register_family(&incorrect_genl_family);
+	if (rc) {
+		pr_err("%s: Failed to register incorrect Generic Netlink family\n", __func__);
+		goto failure;
+	}
+
+	return 0;
+
+failure:
+	pr_info("%s: Error was handled correctly\n", __func__);
+	return -EINVAL;
+}
+
 static int __init init_sysfs_third_genl(void)
 {
 	int ret;
@@ -1215,6 +1246,10 @@ static int __init module_netlink_init(void)
 		goto err_sysfs;
 	pr_info("%s: New families are registered\n", __func__);
 
+	ret = incorrect_init_netlink();
+	if (ret)
+		pr_err("%s: Incorrect Generic Netlink family wasn't registered\n", __func__);
+
 	return 0;
 
 err_sysfs:
-- 
2.34.1


