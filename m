Return-Path: <netdev+bounces-143498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6D49C2A37
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 06:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41BF82849E9
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 05:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB9F146A9F;
	Sat,  9 Nov 2024 05:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="IFnhriQn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3474145B3E
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 05:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731128592; cv=none; b=Jb5Yx9CHHLhEYyLa4McrObvarQzI1bJM7GioKBk4amCQGsW3DWNGTBJrfb2gYI2D/pmqxHvaZesmiE3hpvb92jpdPeVS8K5gjQPmYUlRGdVC2e9m1qxelOTqZ3bOQ5oMjogRUKvqMeVrjqY5imDML/2B3sA/G5hPwqLhFHS2Xa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731128592; c=relaxed/simple;
	bh=QMGh9V+fCN/j+D0uLjcnIHw3s7shm5dxlUbsYTeYPOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h4yYB6S963a3hlsLoJoWXc2h8cLcIQuUKCS9M6DNZ48n3GUc1eHVYcLXzxygR/pN4nvSJO0uEdFwguKpDt5QEw6ewht4nLW2iL9Dl0Q6YZq7URpVQiyDbKXZ/utUm15DBPagblglgnOA/+puF8AOISgGXgAAnndGxBn5kxo08sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=IFnhriQn; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cb7139d9dso27821625ad.1
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 21:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731128590; x=1731733390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCBpeWwUMYPpQhLDdrb3cMWwRM83RuSfCI6YlvdtYdM=;
        b=IFnhriQnBCTn70E//Jl2nn7JfCbUV9ayUVk6rayOUdaQstJCVSb2cqiOAMssJK2NPa
         DCAMemM5+bnH0DPL0jtuZuuqiMjFrHQM2ZnruRJB8ow80ExTJOp9Vgkdd/HEjB7MTGHr
         adYFlcPQZBNC2QOXdKNB9d4Y8GKI4D6CYaaAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731128590; x=1731733390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCBpeWwUMYPpQhLDdrb3cMWwRM83RuSfCI6YlvdtYdM=;
        b=ZfsjJQpP5d373wwHVvgM8Rk/Z+0Ezl0T6ZusvhA1tfpX2PJbateCVmR98OfLdzo7Uj
         712tnMxmheJ9b0XPnE+roQljhD9a6CHgtcITAWIEh/lPNpRe7c7s2CFMcIPT1UWYLaK9
         0kUnp2PiGaVtWwPFFfRb2x+ap0TMZsSlYI/oxTKy5npoSxQVOxW7XGlfxcoauEey+1mN
         r/FBSau4RrXew9XhE/DD5npLFKq/aMU6qjgp+X8Jw9wGwrh3N5B1EVFOKijDVyZSmEl5
         Xv0Zao4u+tNp/q0d1GVDKwG2dwLi4hgPqDmbk0MlzbyGZiK9y9ReQYFsAhi9xqB7wYAs
         RUdQ==
X-Gm-Message-State: AOJu0YzQ3E3YuDDS/k5ZVC06TBN7zTqSRYsZruQXGwuKJZHl+GIGidiu
	Qo/peZvM41sy0T/a8i4qxAYbW9SebTQKVsl0yEiZ/HL/EhgA2buXhBvF3MowK0IjJSktSrsiNEt
	2rwM2UtE9DVf+R3eNyAZMaJ+QrfvSjMRsgnhNm4DqgzhpLGdURpNXf9B9lIDfBsK3lW94V4bvVa
	XaHf5kXH11y7PQziGR+bgwsu0+H44rMHAyo70=
X-Google-Smtp-Source: AGHT+IGzmRuVCERnRF29spRVxccerJag0s3xixY3WGrpRZL96j0U/eDHAABtUMvfvWyq5b9qA5cGxA==
X-Received: by 2002:a17:903:41c3:b0:20c:e65c:8c6c with SMTP id d9443c01a7336-21183d34368mr57616805ad.19.1731128589606;
        Fri, 08 Nov 2024 21:03:09 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e5853csm39182305ad.186.2024.11.08.21.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 21:03:09 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: corbet@lwn.net,
	hdanton@sina.com,
	bagasdotme@gmail.com,
	pabeni@redhat.com,
	namangulati@google.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	peter@typeblog.net,
	m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com,
	hch@infradead.org,
	willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v9 3/6] eventpoll: Trigger napi_busy_loop, if prefer_busy_poll is set
Date: Sat,  9 Nov 2024 05:02:33 +0000
Message-Id: <20241109050245.191288-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241109050245.191288-1-jdamato@fastly.com>
References: <20241109050245.191288-1-jdamato@fastly.com>
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
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 v1 -> v2:
   - Rebased to apply now that commit b9ca079dd6b0 ("eventpoll: Annotate
     data-race of busy_poll_usecs") has been picked up from VFS.

 fs/eventpoll.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1ae4542f0bd8..f9e0d9307dad 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -420,7 +420,9 @@ static bool busy_loop_ep_timeout(unsigned long start_time,
 
 static bool ep_busy_loop_on(struct eventpoll *ep)
 {
-	return !!READ_ONCE(ep->busy_poll_usecs) || net_busy_loop_on();
+	return !!READ_ONCE(ep->busy_poll_usecs) ||
+	       READ_ONCE(ep->prefer_busy_poll) ||
+	       net_busy_loop_on();
 }
 
 static bool ep_busy_loop_end(void *p, unsigned long start_time)
-- 
2.25.1


