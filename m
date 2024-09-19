Return-Path: <netdev+bounces-128965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 985DB97CA25
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 15:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E32EB214E8
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 13:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C7B19E7FC;
	Thu, 19 Sep 2024 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mGHQQm/8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD72819DF76
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726752303; cv=none; b=eYgwYxqskc4pvSPz2awfWM1efqubM+acvw49nLXJVmu2pOogoo4CGuc30srqwVzCAfGmdC9VIwCP7BWi8H+rWWSyduGGKCAiCsufNh529En/sZH6wZweT2qMv16aXhXDEo7FEYLWr4RGVfL0Cm3FudZ8zjIBrOMMXG10Nn2xBLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726752303; c=relaxed/simple;
	bh=obEzbUOat49mFiVOMQjV10vHS3lZgl54eTMgB/iiSJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s4fNxvl6wOXuhUm3+LJUfhvGfNoFmyvaB86YytiIRyqRs0PooGLu+NPSPCpARFIf/QEVY/mgDTskGUcdZ+pLn1+w602gYXSVuEqmvqIYQ+t6B8940IdN6UmdQNdH2Ts9SBngmAqZwVTZ5k81AwpnFPPL15YfqKEz1Rk1Dm998i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=mGHQQm/8; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c26815e174so1239823a12.0
        for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 06:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1726752300; x=1727357100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YPYlfu2VkH5W38C/INzwLlNXJPhMZKljvgdLTCWrM5w=;
        b=mGHQQm/8RtQDirylGdSOchDgQwUZ4OYTAlRULNyRnh599kNQkVvDhrEBS4BQrxMtlw
         WLoiXobmKQf0eZsy8rFFOPBAbCvWU7jveE/k4mTIBLmBZvtZqJu+puzFikf4QyKfra/K
         EuPa64LJrKwNn3QUivPaczHBJRw7/VGSQVHVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726752300; x=1727357100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPYlfu2VkH5W38C/INzwLlNXJPhMZKljvgdLTCWrM5w=;
        b=BSv9+N3OHhm3HShrmUQo9xBcoaVQlA1QPD8IdpZp3x9p+blwwYFa1sIyv63Bf0nPVL
         yXG4xS7FbRvJtiYJdq5C0tq4jeLxrUhslvZ5UFird547t5UgduvmuwT5JAaL+GGwJxeV
         bsqF/Rse+iAcycXVGjowKKMYnDkAZjP1JH3gAUykFqBYB9ShtXTgnWc85VqLXRjP5PqW
         KaBKgXrTvR8NWP02xepyF0FdDGnv1ZsQtyoKa39UFtBio/fg2ltmFJ7ye+61a7iHnR7M
         H8kUvs6PC6bRCOVEEq8WK/xkJ7QqA/TtKjlmd8bzVuxCnjB59PeiBQRLBVj1AQI3RcDs
         6Aig==
X-Gm-Message-State: AOJu0YybhrK/+RwgLb/gbKeAYDjiS/gT/Dk4ZdN0j1dlJ+jIXGorehSI
	Odf0YzEzZ9UJ8kzi+K7ATpNSorjY47M/IiEmKz7Nx/w7gVlYS3+ZQACxPGcGby+adWVqOMkxrp9
	MY5mCVw==
X-Google-Smtp-Source: AGHT+IFY+4uXfwE2UtfJYEg2ZJaLY1mX+kpN3b2zjd+E0m1tJXbyyQBUSo+8xtwCl/dzfEFLfGnSNg==
X-Received: by 2002:a05:6402:3511:b0:5c4:2efe:c9e3 with SMTP id 4fb4d7f45d1cf-5c42efeccffmr14648207a12.17.1726752299806;
        Thu, 19 Sep 2024 06:24:59 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it ([79.20.102.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb89c4esm5971812a12.61.2024.09.19.06.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 06:24:58 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: [PATCH 1/2] arpd: use designated initializers for msghdr structure
Date: Thu, 19 Sep 2024 15:24:53 +0200
Message-ID: <20240919132454.7394-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes the following error:

arpd.c:442:17: error: initialization of 'int' from 'void *' makes integer from pointer without a cast [-Wint-conversion]
  442 |                 NULL,   0,

raised by Buildroot autobuilder [1].

In the case in question, the analysis of socket.h [2] containing the
msghdr structure shows that it has been modified with the addition of
padding fields, which cause the compilation error. The use of designated
initializers allows the issue to be fixed.

struct msghdr {
	void *msg_name;
	socklen_t msg_namelen;
	struct iovec *msg_iov;
#if __LONG_MAX > 0x7fffffff && __BYTE_ORDER == __BIG_ENDIAN
	int __pad1;
#endif
	int msg_iovlen;
#if __LONG_MAX > 0x7fffffff && __BYTE_ORDER == __LITTLE_ENDIAN
	int __pad1;
#endif
	void *msg_control;
#if __LONG_MAX > 0x7fffffff && __BYTE_ORDER == __BIG_ENDIAN
	int __pad2;
#endif
	socklen_t msg_controllen;
#if __LONG_MAX > 0x7fffffff && __BYTE_ORDER == __LITTLE_ENDIAN
	int __pad2;
#endif
	int msg_flags;
};

[1] http://autobuild.buildroot.org/results/e4cdfa38ae9578992f1c0ff5c4edae3cc0836e3c/
[2] iproute2/host/mips64-buildroot-linux-musl/sysroot/usr/include/sys/socket.h

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---
 misc/arpd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/misc/arpd.c b/misc/arpd.c
index e77ef53928a2..b4935c23eebb 100644
--- a/misc/arpd.c
+++ b/misc/arpd.c
@@ -437,10 +437,10 @@ static void get_kern_msg(void)
 	struct iovec iov;
 	char   buf[8192];
 	struct msghdr msg = {
-		(void *)&nladdr, sizeof(nladdr),
-		&iov,	1,
-		NULL,	0,
-		0
+		.msg_name = &nladdr, .msg_namelen = sizeof(nladdr),
+		.msg_iov = &iov, .msg_iovlen = 1,
+		.msg_control = (void *)NULL, .msg_controllen = 0,
+		.msg_flags = 0
 	};
 
 	iov.iov_base = buf;
-- 
2.43.0


