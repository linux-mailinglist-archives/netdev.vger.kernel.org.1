Return-Path: <netdev+bounces-229225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F0BBD980B
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5627B3B8869
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3E12045AD;
	Tue, 14 Oct 2025 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAAgGKpo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28471AA7A6
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446834; cv=none; b=qJlYcgRmT8cLCEYX1eiBdrAPtVSgJ54+X87PqUsOAQMH8isG7zPUF4ce8m5R48l10pddJ5uX6YA5JX21AWaY2C3I0N2s1q+exnhpKikh8lK/H1OVFSIl1hWA3XbeAtQTHIx8+DtnbOWW02mP2waFMZfdjYvF5kRGzmRTvoXGJvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446834; c=relaxed/simple;
	bh=7sj1EbpAJnpeoVxMcwuWL5zaTTOuVyXNUSbxilQjCno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jBqTkMjk0I5LS6xdhQbCQfkFi4LwQ+Z3kQhN1m5s1UR05xeLmcCsPC9YXWqvb+bw8pzIB9t/PDxEskSxixNEUe+RZffvAD1ZJ6uyjvZAc70ApGz2DD/TuNWV9NPdI0Zod/nzePIOrves1dKi8SOx/j8H1ujwgi7YjU/PsQ7xdd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAAgGKpo; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3f42b54d1b9so4647089f8f.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 06:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760446830; x=1761051630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqDy67Vpwu3GYg1tc86jhK5pz5tDZBEzHj59MW+Ighs=;
        b=XAAgGKpoEgj/U5AdQKo0nzsmw8IYBo658CaYLwoGfkNgCZzjjdycvVcD55tC0JTrVj
         LG1DFmK9zmin51PRJJl/bNAfauPBRLIRoO3DAUxR7sYe4yfwDAjuXwga8El6FdQ3ZUaO
         I+FZzN+kYVUB02quRHpEp2V9tS8Jd6MctUTWQbK2qkL8yo/k4BzbEBhTr/B0IdJtBwfs
         LaFVDiYYaDNA/+4LfdKvED7YwWBkDlaQc4S2OBAmqLlb7sW+eM/l+XA7fmsAB49x1RCH
         a069ABviL0kqY94pQNgCNJmm9U9MoaDs6NR2vS9VmygnINJ+BAFKFDi/KccdzLMXb3R+
         kI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760446830; x=1761051630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqDy67Vpwu3GYg1tc86jhK5pz5tDZBEzHj59MW+Ighs=;
        b=cIiuLfjL5Tp8L/smMuyWPtvgK/Qaz6IKIb9gbeEFsIWDHPNaWVN85b2igIgvoeYRze
         iIYNhwInoc6nj7CyTllo0DVwh8fo4zXMWgu5p5goe2lXrhvkDhcWtCCNh81qYCIIym7f
         4u8l5oySih/bijDT2/6DVIOJjb/2n9jZEKyJlgDI9cGvKO6e8x74WQXJ9Vouqlsbu6WZ
         3LmYlRD6ohrCJCnb1m6dWDCQTc9cq9Syub+dHmUYtR+WMxCfMb4XFyGv5hF71pu8odEg
         QYwsiVmH2+/BeXnUtaytzzfZPlXLNyXQX9840+zKUupe1A9y5knjysUOw3Vi+vfL4k1V
         V3xA==
X-Gm-Message-State: AOJu0Yx3QjOUH15lNBbHo4durY/fY2ylSUtPPsEIhnEPKMvcENwjPp1R
	h7cwKEyNPlPIpA/aUHvxwuP8WMCTSpsa89KSD6cRBc+6XY0R2fA4wDgxJYCpyw14
X-Gm-Gg: ASbGncu7AE+796NAdAPmP4iW96X1NqL9dhire5+0AuxQiSZSUePdBgCaDBSKNOXD10m
	3IWZePdz3V9nv3VAUXZ/xCqNjjxgd2khzUmd5ydTjn4qvHcp4S88/rom8xUYqYaH4ZksXOW3kJf
	+eIdPsbxms5g1JMZuSKMfgiq9G3zz0mdUm4MORzQ6k3F0YFveLzUXu4nCdsoslbHou5r0FIVCF0
	Pvxlu9aKYQaXmjCKgzh9lyoE5LcYG5EyD87+J04CCJKnXx45peMlYqol8WzdY69x7FgHKqfS2ze
	m7oHmXrGP8TBIKZHQSojJF3i517vNSeYW5nf0krkvEEu28BExmq/Npcw63WO16rvF5RhfdoDfUq
	4l7rcJdL0zugW47YYVQnBO93BNIWWoiczMFI=
X-Google-Smtp-Source: AGHT+IEU0HIsqzFENU6qye7d3i2PLdW3lTydX5soY1R/d6XQCyDdPxuPIE/paJs9wGzyPRz9zSdyOA==
X-Received: by 2002:a05:6000:2485:b0:3e9:ee54:af71 with SMTP id ffacd0b85a97d-42666ac48afmr16043000f8f.12.1760446830036;
        Tue, 14 Oct 2025 06:00:30 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:7ec0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce582b39sm23296494f8f.15.2025.10.14.06.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 06:00:29 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	David Wei <dw@davidwei.uk>,
	linux-kernel@vger.kernel.org,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH net-next v5 1/6] net: page_pool: sanitise allocation order
Date: Tue, 14 Oct 2025 14:01:21 +0100
Message-ID: <126a5fbb2bfdfb1c3aa9421c0a8e22d8cc0af602.1760440268.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1760440268.git.asml.silence@gmail.com>
References: <cover.1760440268.git.asml.silence@gmail.com>
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


