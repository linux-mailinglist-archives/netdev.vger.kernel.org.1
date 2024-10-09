Return-Path: <netdev+bounces-133825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982279972BD
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532591C22293
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E28F1E00BD;
	Wed,  9 Oct 2024 17:12:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2331DFD80
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493979; cv=none; b=Dl7OTh50rl6Vej8n5W4IAGu0BdfgIZB4ACetabLyNt0Dk0r8vFXao/gQNtFsFLh1HOfUmKadACJYbCLWf6ONPDRvF2RRxx2O8lOeLRstvBLnWw9eXDJkL0Aat+wpXeD57iP0FD7JN1AlRhJF4+v9euRAtwyIZbtxLjreCeoVO5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493979; c=relaxed/simple;
	bh=IqvhzaUkJpjWKA7GF9EqRtKyUon0BB+Qggq6D7pfr0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwwFiXGvTo4MzWGGEGCY5NIirx/f+7ZZ90N8SPkt8uw8lWMy73b6Tru7EduBangfL55g3DxiLeL2fTXwbqEPQX98NdC30SdoZM962509YTxeddk1gjuerpNc6UzX/kX19w03H6ooIS+K/TqRJB45xTNc6yNL0aZs7gf2Tw+Kn2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71def8abc2fso35244b3a.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 10:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728493977; x=1729098777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEB65DWGffO3kOcCBYySHyRKPvvEVxSFR9JywrzAoT8=;
        b=ZYo8gsxmooLw+PWY8AOZq5/qKlwxDFF5VzxKY3NpD5Odx8J8sPP/wulfKUDU4Nz/Mo
         62qe3QZImLynbAvoxXrb0/OuTJ+9BiuKRQuguvc53FWv0Zgozo60lTBNHInX5RIqNSdU
         L/JkwMxEM972mHtR8ZfWdOnQ830vcq3VTyEM4nMYo9ulBFnlGmz3B3WjzybVXDL5ichM
         oqzbHmsuzr3xQy+Ayv6QIu+QvsyNXRxQ10qL1wxeHXKUQQehKZxEJAD+aGqYL4ABAAF/
         vpI4KThfyKePYeeBgyFoLsYFnecQ9vA318yafqyEf/kHs8xBPZkWMZxkfSq2pqucC56F
         FbMA==
X-Gm-Message-State: AOJu0YxT6Najtj7YR402rHZzCEtDsr3zvT0Vsbc0ryk0ZodITJWMNYK4
	LPD0x0nTc8ZHbPzNzK+wOxtANq5jDA9OheQJq/KcPj0BI83ip4MAzb/l
X-Google-Smtp-Source: AGHT+IGaaqFQBcMTGpCJGFCUQ23/bCaUMM1U7TXm0CDwu3JGCKMi031VWVXM4EjUyHdSYTZtwobdFg==
X-Received: by 2002:a05:6a20:bca6:b0:1d8:a899:8896 with SMTP id adf61e73a8af0-1d8a8998977mr2180318637.29.1728493977065;
        Wed, 09 Oct 2024 10:12:57 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d69246sm7982851b3a.182.2024.10.09.10.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:12:56 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v3 03/12] selftests: ncdevmem: Unify error handling
Date: Wed,  9 Oct 2024 10:12:43 -0700
Message-ID: <20241009171252.2328284-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241009171252.2328284-1-sdf@fomichev.me>
References: <20241009171252.2328284-1-sdf@fomichev.me>
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


