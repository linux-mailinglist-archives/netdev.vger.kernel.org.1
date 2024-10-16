Return-Path: <netdev+bounces-136294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3DB9A1417
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57F571F22E44
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DCC2170A6;
	Wed, 16 Oct 2024 20:34:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF32216A0F
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 20:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110869; cv=none; b=BaJQXnhDmjEoWHF6kgHQoYqm8jzJADQYuAugdAuJYMacX03Z+ib/l2zJLvC5eJBsbVfgCeFFZpiUoQmbw2q9pq3//PKl9Kemwv3lljugHNY3MSfGnt3Sbh2KkwzxhUUiPghoBQI/L3eHVB4VgRQHAGFYs2QS3wJ70ujFOQ14Q90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110869; c=relaxed/simple;
	bh=IqvhzaUkJpjWKA7GF9EqRtKyUon0BB+Qggq6D7pfr0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J62fuPKTbss36PiHdapNhryCzFcMeCufl5WcPT3oB9fGBc7g/SKLsI6PX1KUYM+dcUkqncHJg2vKkg8Qk+jcZOiBrkYtz34V22mOWvOatAs1w6pKdgiTXW/IaK7sIsLNW8NQKENylZbkG0/y3AddvKwDuYVmAH+jejAwytt4Dzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20ca96a155cso1718545ad.2
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 13:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110867; x=1729715667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEB65DWGffO3kOcCBYySHyRKPvvEVxSFR9JywrzAoT8=;
        b=SyM6WTiKKjyGqAIc/bEMMsunrLOThMVtsglwJiNafHcq5p1Bf1uHj9W7xrt34JplXo
         mDjg6+VxIyvu1tRDtudMJ2VfWeEpBNYotRudKHLVKIfewjlBuw3HImmSmJhmswlFQVGT
         oUyn5wQgJW1FgqvrmRLYbloy9POaOTsHi+4nSNe3WdAF8XHmgecizYj7EP2vMF+to8/t
         nSdpAnmqAHyeNYlrk+Hi7YzrZhjOU3LWbm/NEda9n90gLbk7YJqTSPbU8IYJSG1NZBgb
         2HmyfgCo4igddQ+QIe0WGKbG4onRgfZvBCK7H7wRryTrtul7i6diAmmsm20MggOKrMDj
         v0Bw==
X-Gm-Message-State: AOJu0Yy+/tujT9dO9EDQdf5XtEJkQ9I1syAB2MEriektMQ55maklnOGF
	hTuekVBfdkqz9h+ynztezslrXuRZX8aMUMmbbb7v+VwtERl9UZjxNwH8Yt8=
X-Google-Smtp-Source: AGHT+IGcKSn//Mt1cPRXTEuR7zOSKl9YXxZPnZokTXuljL0mfBVvnTQGN+3IgRqRAkoQShP+Rskffw==
X-Received: by 2002:a17:902:d50e:b0:20c:8907:90a with SMTP id d9443c01a7336-20ca13f732amr252350615ad.5.1729110866785;
        Wed, 16 Oct 2024 13:34:26 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1804b706sm32587175ad.217.2024.10.16.13.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:34:26 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v4 03/12] selftests: ncdevmem: Unify error handling
Date: Wed, 16 Oct 2024 13:34:13 -0700
Message-ID: <20241016203422.1071021-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016203422.1071021-1-sdf@fomichev.me>
References: <20241016203422.1071021-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a bunch of places where error() calls look out of place.
Use the same error(1, errno, ...) pattern everywhere.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 9b3ca6398a9d..57437c34fdd2 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -340,32 +340,32 @@ int do_server(struct memory_buffer *mem)
 
 	ret = inet_pton(server_sin.sin_family, server_ip, &server_sin.sin_addr);
 	if (socket < 0)
-		error(79, 0, "%s: [FAIL, create socket]\n", TEST_PREFIX);
+		error(1, 0, "%s: [FAIL, create socket]\n", TEST_PREFIX);
 
 	socket_fd = socket(server_sin.sin_family, SOCK_STREAM, 0);
 	if (socket < 0)
-		error(errno, errno, "%s: [FAIL, create socket]\n", TEST_PREFIX);
+		error(1, errno, "%s: [FAIL, create socket]\n", TEST_PREFIX);
 
 	ret = setsockopt(socket_fd, SOL_SOCKET, SO_REUSEPORT, &opt,
 			 sizeof(opt));
 	if (ret)
-		error(errno, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
+		error(1, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
 
 	ret = setsockopt(socket_fd, SOL_SOCKET, SO_REUSEADDR, &opt,
 			 sizeof(opt));
 	if (ret)
-		error(errno, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
+		error(1, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
 
 	fprintf(stderr, "binding to address %s:%d\n", server_ip,
 		ntohs(server_sin.sin_port));
 
 	ret = bind(socket_fd, &server_sin, sizeof(server_sin));
 	if (ret)
-		error(errno, errno, "%s: [FAIL, bind]\n", TEST_PREFIX);
+		error(1, errno, "%s: [FAIL, bind]\n", TEST_PREFIX);
 
 	ret = listen(socket_fd, 1);
 	if (ret)
-		error(errno, errno, "%s: [FAIL, listen]\n", TEST_PREFIX);
+		error(1, errno, "%s: [FAIL, listen]\n", TEST_PREFIX);
 
 	client_addr_len = sizeof(client_addr);
 
-- 
2.47.0


