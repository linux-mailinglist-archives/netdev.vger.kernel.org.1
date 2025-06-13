Return-Path: <netdev+bounces-197333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92298AD8220
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 06:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09A53A2177
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 04:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCD92550D7;
	Fri, 13 Jun 2025 04:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ybzfkIUU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A55253950
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 04:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749788908; cv=none; b=kd50FvD+wzjFKBA1Or4esfqJiC+sZe5yVch09dd3WpZgkRaDWNkLRj1dMoPQsXNPt4ehaNmEuYPrBRjizz8PO6y73cZYhc7sTAgxd5mCFDf/1YH6LsPEZpIMZwseUbRg7PVoTDQv8cEzoMA1Rj5PW5HZYRPZW5KEAmXL8pntyXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749788908; c=relaxed/simple;
	bh=tL1PLzIyUqJpZNsRBF7JRfwA8Ed51h34XsLMqxuM5k8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hiATOLpgQHDgeZ3z0U0XMbRMKzURBLRfYu8aJ2nHzkpBsssarbFnoyAc2LgewcT18YLQwFeSz+3PjKREGa4kG10FU2U2KquUVfPe/AcESfuHre8VbgdexP4F8HCgfmUTSoOc5tugj3gqpxoiDrTkENhZ2RCF3S+EHxn7TbCsi88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ybzfkIUU; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2e42bf99e78so1581552fac.2
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 21:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749788906; x=1750393706; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYBZvfyHdUGl/wklBqtBO8YvE+0ucQlCTvcKf6Jv4wE=;
        b=ybzfkIUUFvxNbQLLohhlN9wgUJjkUcDYvoYskmX5arnn1rs4SdlQLvpOAfVe3Cfreo
         F4Mq+TLcq4VJ/3rSWmxc8+/4L+ce8NUPSwN3zCmcY1ayKJX57CfLlOLEPKXq5Pkv9dXu
         gnb0OAqsh0dNyRvYtkkNMIZzZhLtd+ipw13SLxTa2qVubDVHBSznyHQMAC5n/4IIy7aY
         IIjwqrj/UXixl32juXYGaDe0a8X//idNcN+kfYuGcP1Kzk4jVAz5aolPCy82ET64wKGZ
         2UK4w6kDUMnmYSPLMjRlVmQOuuHFuH4NvtEDyCOk/vrvPx2eJUn72AO3tCTF6LsInhKY
         nYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749788906; x=1750393706;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYBZvfyHdUGl/wklBqtBO8YvE+0ucQlCTvcKf6Jv4wE=;
        b=xKcUrPnSNQeB403eo0uR+lpic765tjzuvxiovfOscyNdYp7XYT2fjc2yuZHU7aFwdU
         LVZTQtEmAyixouo2mw0sgF4EQMKBM2RgT3Rp+B+SUEHdruCS4SksSTEUIJVzfDyEmHex
         JMSZL06kq3tU/yIqb22z6h7VnATwEfv4TETxw+gvkvhpCV34BPZblpj3pTBOnHe/lu6T
         BxdQL3CxYqosEH/fMpGCB+jw1MT/aAwK4bo/cMaix6773C9NB1HHdk5Z3eonYyJD55RE
         74dHjLpeSf/V28tzlVHFTPJEScyeQkBDMxRj/5CmV0QFKp+ErprNT73psxh22rq2+Y2h
         1xUQ==
X-Gm-Message-State: AOJu0YwP1j6TnRX75Wqpw9TM5jRedEJfqpskpILUF9EPHtWuHWSBrLEr
	lUdFvMH3j4674Ssu43HOMDflO9Hwe20bioDi1GkgiQFE2E5FrX9jeVE2p/vTD3ogdlP1k1gG815
	7o1qooUnvO9LuyfPPtUDVHfNR5XgqQNHKL/9CKG1mSsOPfRJqAhi/G9bTl/ZySVioJEGrpC2fBf
	93k9pEzFMgJGbvXiaaPE7emQBrhThdqfq0VomSbYRljMJtuOTFfceGQSHxKdJIJTQ=
X-Google-Smtp-Source: AGHT+IGE43XcqhBFW+fQotJi4fyRgEkRR+8OmumQVou8oP2GURUevvi+LmO0+PoZqsrLru+kQ4PW7qlbTdI+8ngBXg==
X-Received: from oabgh10.prod.google.com ([2002:a05:6870:3b0a:b0:2c1:6d20:7b92])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:de13:b0:2ea:6ec5:f182 with SMTP id 586e51a60fabf-2ead51d3976mr1007327fac.38.1749788906187;
 Thu, 12 Jun 2025 21:28:26 -0700 (PDT)
Date: Fri, 13 Jun 2025 04:28:03 +0000
In-Reply-To: <20250613042804.3259045-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613042804.3259045-1-almasrymina@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250613042804.3259045-3-almasrymina@google.com>
Subject: [PATCH net-next v1 3/4] selftests: devmem: remove unused variable
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Trivial fix to unused variable.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 02e4d3d7ded2..cc9b40d9c5d5 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -852,7 +852,6 @@ static int do_client(struct memory_buffer *mem)
 	ssize_t line_size = 0;
 	struct cmsghdr *cmsg;
 	char *line = NULL;
-	unsigned long mid;
 	size_t len = 0;
 	int socket_fd;
 	__u32 ddmabuf;
-- 
2.50.0.rc1.591.g9c95f17f64-goog


