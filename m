Return-Path: <netdev+bounces-228781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C55FBD3D03
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC3218A0593
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C1B30B513;
	Mon, 13 Oct 2025 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UctH4wmB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D0630AD0D
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367206; cv=none; b=TdDxEwaXWvTL6H/pfLJMEgUNl7DuXWChfE1mrl+SQzkouTpuhV3E/wQpYDqJLwCjBuqueFBEI4/kiYR0/XYkg0Jg8abOVJILY1qJdUmhiVaEL5jI2GIKfFmCn50gXvzGIIX8WkufADb4CCdYhjDOhx+PxHfZFkFKqSmXVNrlBdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367206; c=relaxed/simple;
	bh=7sj1EbpAJnpeoVxMcwuWL5zaTTOuVyXNUSbxilQjCno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HP8ujELh8jTAGxGpk5Kqfwj9tdU5MTNDmK3vMTevq2h0sKb2ZSOpqieSyxseqU6YqPR0fXQdKeySRcLKbpCacNoHNsuzTVuMbcv4J3jF0WcgCJS1P6ACEo4TPTGtvXNhlMlLJMl/V3ioY7XeVGCE/afR0SDIM8G5ZHV6/rJ6F+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UctH4wmB; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-41174604d88so1951339f8f.2
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 07:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367202; x=1760972002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqDy67Vpwu3GYg1tc86jhK5pz5tDZBEzHj59MW+Ighs=;
        b=UctH4wmBAKbnO0vP3yMu2v49mDyJRbxIaYIwLePGAWHxopZjFpXBsZIeBl+qR3GAl1
         XpmCRJRlhsfcLHZmc3k9CgUSAa9gtvnyWcGJu6jZ2ZLUWj1R/bu6plny8LaRw0X6BI7I
         BXdh0FzvmnLxzuB9BFw5QiYieUpnqK0jia1HZKqqcYRxGlBUZhqCqUBIBCiICNxJSMI7
         cLU/ixvgI53rY8lGbXKwkquaf+9ZcVLUfXjoBbz8cEPSv+PBOyQJJemBtp9HKFetixpt
         l7hC7IQFgNjXFv37bAp99VmdJtOJjh5FvHTyuZmfdlFQS5d9lAzhQNbTyQ0iEZcWplfn
         syDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367202; x=1760972002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqDy67Vpwu3GYg1tc86jhK5pz5tDZBEzHj59MW+Ighs=;
        b=ignx32dAqwHjaHo87RFArEFpyGjfhjPdsjQNNlkIA0a+W0bchnOw9FMl+wj374J6HE
         AuAKn+APy2L9xtGTApNvrLpcc/Hs1C2rHmgwaok25OR9lu1x7/n04yPFX6pZTdlW/lZ3
         60RBMsKhsynQU9/+/aXSfs9dSS/Omjh8qWp+r6W1+BjmrwBjf09xyt+PkPGJ8PqKatxO
         Co/S1yDAm0fWDDK71eIZdU7l6M70d8sY77eEmLFnl40cuYITCO9VAGNQ6zg4eugAh61+
         OGHT/FUGBZQE05zDLrucobOyCNfCAIAbP5HQPR8C4Xu5YByiL2s5NiS0425VmH+i4sY9
         PNew==
X-Gm-Message-State: AOJu0Yw19BKhSVCFHImEcBUgkBRD7qFEIckdhB7uD9RXRNr2wi1yzWtI
	5FgT9FKe7Q/YqdmbC6+ZFSjEHfYZJN8G906Rgz1VvQY+vT0UVq8sx0Ib5NI1EuMM
X-Gm-Gg: ASbGncterfGZ3stbZkQ3B416CmSWgJBS4aLkwfhB4rdA6Vqsy3lrlUcyA4C96ACKXaL
	P2D1eMXoBKCor7LDuUsXgpGJOBCJu989ybVJhBxoUJfseScnEeXm4gnHp7HLK3GH3JrleKUSqG4
	oyle7+i++yT+4l13YiQzzqSZFZlyC4gZ5DdaUCoHBoYvyLCUVKvQGJN9SNpG7AY7TNDemTzdpvl
	Kxf5byD/ArSHfsglDhOrK/3r7DCx7R3xJGe2oNp12Av1rDGmFSVogRmW/qfudMlmITXtisZ/BFw
	mhnTI2LwlueF37bZ38nlCdHz440NqcdN8kJ1J2IPNGLgnrga2I8R/FzzXO8IlXKc90iVf/KjlvC
	Fwy06Rjc2rjn/I76xXM+Ldnpi
X-Google-Smtp-Source: AGHT+IGuhS3kQZ1R1xe6ZB/ZEr0fg6Xs5SvekWOSlXtM50KBa0/ETxk5cO3wUCuWkLLaVPOmY7sV0A==
X-Received: by 2002:a5d:5d03:0:b0:3ec:e0d0:60e5 with SMTP id ffacd0b85a97d-42667177bd4mr13708475f8f.15.1760367202162;
        Mon, 13 Oct 2025 07:53:22 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:21 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	kernel-team@meta.com,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Joe Damato <joe@dama.to>,
	David Wei <dw@davidwei.uk>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next v4 01/24] net: page_pool: sanitise allocation order
Date: Mon, 13 Oct 2025 15:54:03 +0100
Message-ID: <96099d1c7af73b1086ec1c7de1488b50147d07bf.1760364551.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1760364551.git.asml.silence@gmail.com>
References: <cover.1760364551.git.asml.silence@gmail.com>
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
on init.i

Suggested-by: Stanislav Fomichev <stfomichev@gmail.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/core/page_pool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 1a5edec485f1..635c77e8050b 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -301,6 +301,9 @@ static int page_pool_init(struct page_pool *pool,
 		}
 
 		static_branch_inc(&page_pool_mem_providers);
+	} else if (pool->p.order > MAX_PAGE_ORDER) {
+		err = -EINVAL;
+		goto free_ptr_ring;
 	}
 
 	return 0;
-- 
2.49.0


