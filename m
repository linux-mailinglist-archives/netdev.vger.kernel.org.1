Return-Path: <netdev+bounces-88149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A64058A6057
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 03:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BAAC1F21A3A
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 01:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21605240;
	Tue, 16 Apr 2024 01:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyCFOW0I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139E8523D
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 01:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713231175; cv=none; b=IVdg35umSzS5EorW5ERxZpOuo7OA5+KYt/CYtMdbxh+US/qUbVwhNvdDkLwhU0IwbQut20lEki645H1yKTEdA1/xYEifwP0HkbOZ6n16U/l64NgnxkKyOz5zzo1drvILM4uJ4JNXHnBIVgHMgN/bxUHknlN+CpO96NcDbwPwNsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713231175; c=relaxed/simple;
	bh=PZcZkgO/y6rDtSzGZ/DtlGZfrw3B5AFK9P4aOdyhO98=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sJUTGR79W7sBCAHNbCEy/tfnFqz50ZISWUlOgmx0zMbU0jTsK1rDaOZYm+eqTv1alDZV0zOnsuoXT5rlgUi+y9D6vI+vNfQ9GpPVURtlWn5r8XK6E2uz3coed5Un+YBiNWURKwwwcLuMppVh6PMn5H7+kF70exIzEJ1zyrwVZ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyCFOW0I; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c71c7e2d40so446063b6e.3
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 18:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713231173; x=1713835973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ceOTDmOL3/4c3hpiPQlqFU9LQ3hSotPDbA4J5nguoCo=;
        b=EyCFOW0IXIq2c+mMeMxWNJLZwuoQkYVVyNhkkQTztdTwvcBBBQFPusYm/svSw+aVg3
         pEKKjM83OInXE0hR7kZLihyYAUj5wcJzW6mzBCfDpPBGOBqsVdIaW4nQailfVHCGpQ/c
         5l/LWFiCOu9i9sJwu4IgH/pdwQzC6f6QjdS8Q8wupvgVxA86bNI14T8SzksureP59T08
         k/hkYYUZYNhRJi/x9DcY+K4iBLcBl6EcYU04f/l6fc2FWQmnfNuTdUSygikJuVhdSj/d
         dUeJc4v1mC5Hl5nk1SZtEosd37SMoiUFWs9hcOJpcn25MGzb5P/V0rcX2FsSDrKLf253
         Xvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713231173; x=1713835973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ceOTDmOL3/4c3hpiPQlqFU9LQ3hSotPDbA4J5nguoCo=;
        b=fs+GSTMQxM8QooczDqhJpTjN5FVKqwg4tPr0bKaqsdkiOoTNH50OJ1c6+XJEyMQtC5
         qP9tzE+idXkqFcFQWwMft2QSvdMEeyP0n96TXWDUhOLm903DpEbJS/rrJY8rfOvernP4
         TiRiGy3ovwt+Lg26G7AY9cHqn6H/qAFaXuBNmpe18eKT2f5j6vhbkwrf4XeQfFJhHnPl
         5YUkbjcycaq9C+wEmkFy6ArHigCaSM9lC1IDu/TYhqHk0v5Ejz8fHUOJfIWUbbb6hbnY
         xJEtgIfMgv64M+oJ8Fdd4zyaNkFnwJYjcPYJilLM02Txm/wtLQ5xqdXn7JhAHp1cVxfI
         kddg==
X-Gm-Message-State: AOJu0Yz4KHxjpjjPeCqQsHnZBu4FGDtUupw4rcRCvllN6eiJcgV6W+Qb
	qaEhBq9+0s0Yb0V96BPhLpTKksT0gIjttCFyJS3FRBfNKgrbGrxqfQya3x98YO7S9g==
X-Google-Smtp-Source: AGHT+IFq0v9oDYiZ2KlLIenBFet91cIwdnvS2i2js8tqqI3UUTFSSjEzOI/4MDVJDusZGTwqmQf0Vg==
X-Received: by 2002:a05:6808:20a3:b0:3c5:f495:b8df with SMTP id s35-20020a05680820a300b003c5f495b8dfmr14901341oiw.11.1713231173014;
        Mon, 15 Apr 2024 18:32:53 -0700 (PDT)
Received: from VM-4-8-ubuntu.. ([124.222.65.152])
        by smtp.gmail.com with ESMTPSA id o7-20020a056a001b4700b006ecdb55db60sm7892515pfv.195.2024.04.15.18.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 18:32:52 -0700 (PDT)
From: Jiayun Chen <chenjiayunju@gmail.com>
To: netdev@vger.kernel.org
Cc: shemminger@osdl.org,
	Jiayun Chen <jiayunchen@smail.nju.edu.cn>
Subject: [PATCH] man: fix doc, ip link does support "change"
Date: Tue, 16 Apr 2024 09:32:15 +0800
Message-Id: <20240416013214.3131696-1-chenjiayunju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiayun Chen <jiayunchen@smail.nju.edu.cn>

ip link does support "change".

if (matches(*argv, "set") == 0 ||
    matches(*argv, "change") == 0)
    return iplink_modify(RTM_NEWLINK, 0,
                 argc-1, argv+1);

The attached patch documents this.

Signed-off-by: Jiayun Chen <jiayunchen@smail.nju.edu.cn>
---
 ip/iplink.c           | 2 +-
 man/man8/ip-link.8.in | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ip/iplink.c b/ip/iplink.c
index 95314af5..d5cb9a04 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -64,7 +64,7 @@ void iplink_usage(void)
 		"\n"
 		"	ip link delete { DEVICE | dev DEVICE | group DEVGROUP } type TYPE [ ARGS ]\n"
 		"\n"
-		"	ip link set { DEVICE | dev DEVICE | group DEVGROUP }\n"
+		"	ip link { set | change } { DEVICE | dev DEVICE | group DEVGROUP }\n"
 		"			[ { up | down } ]\n"
 		"			[ type TYPE ARGS ]\n");
 
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index 31e2d7f0..1e4dfcdd 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -63,7 +63,7 @@ ip-link \- network device configuration
 .RI "[ " ARGS " ]"
 
 .ti -8
-.BR "ip link set " {
+.BR "ip link" " { " set " | " change " } " {
 .IR DEVICE " | "
 .BI "group " GROUP
 }
-- 
2.34.1


