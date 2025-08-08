Return-Path: <netdev+bounces-212194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69419B1EABC
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D64189B727
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F1128135D;
	Fri,  8 Aug 2025 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdHwFY7R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50832E36E0;
	Fri,  8 Aug 2025 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664815; cv=none; b=CeoCmNhlrmShzIGTdrRaZCexORaXk4qTogVU+AbpK4ZVRVbdamgkJVKePzwlCACDRq/RJpF4++uJxmFGutWbxRnWlf3BD0LzXC5zYa/T2sxZm/CJ42tOTTNAMWBZ9ucEpKjhNiCXp6h+vGxDkrMAlTUd6NefglFhG3q+ZXlb0Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664815; c=relaxed/simple;
	bh=1+wUor/D2lqqFvCOhRNyGAsT/G8fQkZ5gTKa4MaWBF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jmcnOddghqfc8HtkNItlECJYYRbh+8MmnJxxDOOQ5mtQTAVEinVgaCQMb2hw3Yzh1VLYuj4EMC2NLt4l6VpuhkeCkBHGgnLbcqaiPcdEbRSYNpLil9RPmD+RNrh7X8UDzmh38CMU6HNdSoBnIMQsCpmOuhaAiBS7YmBbCBDKdQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdHwFY7R; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b79bddd604so1278372f8f.0;
        Fri, 08 Aug 2025 07:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754664812; x=1755269612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXdUrvXZggtBih99tqlkb3hpG+7zX+VGvFiDFejRdWs=;
        b=YdHwFY7RZ0lEvg6yU6zLahXxjY5qJF3+hc07Y/+tsjYt3O3NbB5GZytaAJx5EEUbae
         7brUOTEELbHbvcPqVhHIWm6OoeNpQlZJBMVOpZvL0BK/msemESeMupt0v1lpOuOKhrVI
         QRoZO/wDntJCafJ2WQqxCX6GUQh9WJ1df5S4TKUOxAcNvSo5x6KZzgYrdjzdQBgQyBid
         OrRxzLnKvFp/0DPoVN7WkfHepmvPSV69E2KlccuMpgAz/bPnF2w6RcloCbzbGFQ+jF2C
         PjvuzdUmhpgM5DGl2DKaUmhba+VL4S+xjryJGO1aYuQaBX9TB0aJ7Jb//wfmuFqHfy+S
         ISTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664812; x=1755269612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXdUrvXZggtBih99tqlkb3hpG+7zX+VGvFiDFejRdWs=;
        b=VvgJNfBbSuehYYozJq8CS/lOh6rc/psR7m8/sb18YbuNNT+WBQ35QNhE5TnY/FRJuI
         rBHhBLlf4kt3iXgpxbEnAALnRn9VPkw34glyUWNKQYTCw4n8tuFpyVfrFSpxrkNvrhBX
         c4B9o/rGQXDD6Lb+IHSC2mbiXXp/GS1NNqn4idf6PAeaA5nLIkRKuxJxoKdkZQD6EaWI
         UgrvsxaY8lYyKHBXjMRxtB7iN/pCBsM/oJZwQmgsiBht5P0zOWFXaEVHvrbwlFnJS1gW
         fZNOuILXFCkvag6MpvQdAkVFbD9YqPNhP4/8W38f588zo3lTZLYRjZXCt/ZpJm1NDgYF
         S+7g==
X-Forwarded-Encrypted: i=1; AJvYcCUCMjnmBDc494UPUwlstbP9QdslOiXrKGO0eq0LFG1gwWja3qQDorDZBBCBbDJ5i8tMXCApe8Qn@vger.kernel.org, AJvYcCUrXRDxcw+Pd9BXcR9U3DnQBBLmf6GfyVfYIvBB7xTqXWjHuajpLwwBqMFeI0QlGC2ozH9ti+QLYyzI61o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDboemFPkWV5yUyeBXn3HylyB9vMt25cran/H1TEcdEBAtfZ6h
	qU38Xy12RKFBnCmDRcWSdmk6H4/FDN9BsZls0GsV+8DV1bj9QvKN3dD2
X-Gm-Gg: ASbGncuLyogaS4efzKuxMjKbezJwyRsOHktJRJSN6enbMvaHvKklf4wlvaLP2x935j7
	HBsFwZ2fjQjQuiqq8CScKiO3XMS2+SsPWroXLuEjy5hk46v70l87JYBIgMq3knTW65JnYlSQ3fz
	pnclASXnk8XFaWtPtA7FhPaEEkCPZyENS9PFeLYtPYy5QI/eJUFrv1udPihJqwu7FUtCsAYgqqN
	H7rxgI/Rr29ZdmcdvMir1aUMs7rBpaEJD0aEL6z1umSXCc+P2BDu84Kh7A67yTS6K8G4tZVetpM
	riT4It8raWOfr1GRBpi2j6SaBL3ZvWOLQUpIoHb4DoHVnjcSsJAguIJgg+9CkXiq2lIbS62G9j8
	pOKLZyA==
X-Google-Smtp-Source: AGHT+IHjNhm6CAJvoHANi2GA7LUqSh9cFgFEyjqu6XVvcvHx4RaxKEOJr1vds09WkEXu3I3l7RBixg==
X-Received: by 2002:a05:6000:25c7:b0:3b7:970d:a565 with SMTP id ffacd0b85a97d-3b900b551c7mr2907354f8f.46.1754664811758;
        Fri, 08 Aug 2025 07:53:31 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:a360])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm135106725e9.2.2025.08.08.07.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:53:30 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: asml.silence@gmail.com,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	davem@davemloft.net,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	michael.chan@broadcom.com,
	dtatulea@nvidia.com,
	ap420073@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [RFC v2 01/24] net: page_pool: sanitise allocation order
Date: Fri,  8 Aug 2025 15:54:24 +0100
Message-ID: <89ae559c57b8b8bc061c5942fd46a5bdd1f2989f.1754657711.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754657711.git.asml.silence@gmail.com>
References: <cover.1754657711.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're going to give more control over rx buffer sizes to user space, and
since we can't always rely on driver validation, let's sanitise it in
page_pool_init() as well. Note that we only need to reject over
MAX_PAGE_ORDER allocations for normal page pools, as current memory
providers don't need to use the buddy allocator and must check the order
on init.

Suggested-by: Stanislav Fomichev <stfomichev@gmail.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/core/page_pool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 05e2e22a8f7c..f1373756cd0f 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -303,6 +303,9 @@ static int page_pool_init(struct page_pool *pool,
 		}
 
 		static_branch_inc(&page_pool_mem_providers);
+	} else if (pool->p.order > MAX_PAGE_ORDER) {
+		err = -EINVAL;
+		goto free_ptr_ring;
 	}
 
 	return 0;
-- 
2.49.0


