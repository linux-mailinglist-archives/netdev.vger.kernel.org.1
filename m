Return-Path: <netdev+bounces-117703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE0794ED85
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63F61F23795
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFCA17CA12;
	Mon, 12 Aug 2024 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Ec759tHm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F2217D340
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723467472; cv=none; b=AW51Tj4GJynnKRd8GZn6ZRAF+4m685A+Hi6x196w6KDMW6rIC4WhBKAavyysphoClHd2dnMQfJ791HtAymonpHk3rBi2LJmVHxjp6ZZ0PyQoRh0uiqid00DDQDjbFaz/mw00mQKjV0Al5S3mnKmkk6hhUkpkFWl9HrAF2Qp9P0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723467472; c=relaxed/simple;
	bh=uGO5dEJrzAGpkDGXLrC8ztAywM3dRMCy6F4elADygWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XMr8BHsOvi7F8RsMGx/CXew7H+FoVF51vxOScT27Q2KDc34vGpZUEvQe5LemUU2VXmSHs3dcPy3FWgDj7Xyu4u9PsPuzi/GyWoO8sRnhDiiHOF+otoNYaleNJ/5keh998qpvFvcegHPHvb4h8AehiQVixr8Q3ggbL9et8uZ5YSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Ec759tHm; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2cb4b7fef4aso3380544a91.0
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 05:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723467469; x=1724072269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58S4qbuyYKoKQjyHpzs28ekwRvFYt2yreo1eLG7u1fM=;
        b=Ec759tHmiiGhgXoUEENfBjcubXA0apvXqhwmY2HjIeK4pU4mXeTqHHRpIzpRCmZydv
         ZEUTnBcD/A6jnVUa2hdCfp0Wsxdetqt8g/7KVs4/H9bV1MeKqWEQFvbwtPI2P/HKRYLH
         B2I3+X/BFppZjTgk5y7WYuZWqm8ilH+/sg7w4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723467469; x=1724072269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58S4qbuyYKoKQjyHpzs28ekwRvFYt2yreo1eLG7u1fM=;
        b=gOB0zDuzzfk4oU+D3ELGpNV5OhYC1M1Sp0Z0p9LgPPFyg6WznWVkAR54+UB8Rjv4q7
         mfEoB8sQiX9g+YR0lomVbS8tzzazZ0LgW1S6XdYiHC0ea4Rz3Jbdlylu4+JxNKELK5ua
         +vSJ6W6fT0mx5AE/KC/aZmtmfKtjwYaPA3uoJXxBcHxyjjLGB4e8e5IG7lZmUAESFY2t
         YwIV8Ha0Rccyju5TYuL0E/lbTDoWK5dmnLrcvQVXxrHf9QfTddL5aRBLZOb9iOnnsfEP
         Rpv+J4qMJbJ8qxFCEvbrgeVxHUHeslmzG8RU3LQ7tUEvYnQjBDzBWhPkcrK+81Z0C8qJ
         FyRQ==
X-Gm-Message-State: AOJu0Yyh6OvMPKSM+sAGorUkHwXdimoOweROJWvnvo/u+gyhp3BOINnm
	AW+ayOQGllwrDbTLEtre8ATjshWP2u6NoNxt737XMvDpJ4GX5bSpH/xywu0DPGIlaisEQ468y9Q
	7yfSDV/ebwlHTJTvBZiFwuqkjK4da78VFTF+vA87zYMBB35kBAKrb54RUGyTgl94sejgt9Ri8OR
	OSVXyNj31Ehn4UFPgESvZ1pXKbFoifOCfVF/T7iw==
X-Google-Smtp-Source: AGHT+IGFlBi1X8/Y7i5u30ax6RMbfkRifnWc7b7YQe3Aid69JjvZ1u0IpdtiYAyCV6l+7Dbup8PUIQ==
X-Received: by 2002:a17:90a:53e1:b0:2cd:40ef:4764 with SMTP id 98e67ed59e1d1-2d392510ccamr117032a91.17.1723467469481;
        Mon, 12 Aug 2024 05:57:49 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9ca6fafsm8183368a91.34.2024.08.12.05.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 05:57:49 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next 4/5] eventpoll: Trigger napi_busy_loop, if prefer_busy_poll is set
Date: Mon, 12 Aug 2024 12:57:07 +0000
Message-Id: <20240812125717.413108-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240812125717.413108-1-jdamato@fastly.com>
References: <20240812125717.413108-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Karsten <mkarsten@uwaterloo.ca>

Setting prefer_busy_poll now leads to an effectively nonblocking
iteration though napi_busy_loop, even when busy_poll_usecs is 0.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 fs/eventpoll.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f53ca4f7fced..cc47f72005ed 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -420,7 +420,9 @@ static bool busy_loop_ep_timeout(unsigned long start_time,
 
 static bool ep_busy_loop_on(struct eventpoll *ep)
 {
-	return !!ep->busy_poll_usecs || net_busy_loop_on();
+	return !!READ_ONCE(ep->busy_poll_usecs) ||
+	       READ_ONCE(ep->prefer_busy_poll) ||
+	       net_busy_loop_on();
 }
 
 static bool ep_busy_loop_end(void *p, unsigned long start_time)
-- 
2.25.1


