Return-Path: <netdev+bounces-50703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7735F7F6CEF
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 08:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F20D1C20D68
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 07:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCBB4C8C;
	Fri, 24 Nov 2023 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FR4RM+MJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C52D4E
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 23:35:15 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cf8c462766so9891715ad.1
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 23:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700811315; x=1701416115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+jlwNiD5+k6JtqRm4NuTxUsQI8cVUfE9sKvwgru76XA=;
        b=FR4RM+MJ/9spR8CozLC4Y0zrRD8mXJc0SttnXlLO+tIChDiGW8pxPzCMa8otRROhTG
         xFDHtQQWakzaA12QvvBTfGftSGAiwsirhakZN2SWkQtzD1TNe0CMUqd5b9wgtB1gTmk+
         K2Xvi7sl7RFMZvOTQqkASObT9KhQuB8ZevoSJZZWsxAvAVq4j7rIIp5VKkqv+vMj7SOJ
         1r0+T4gMNNzc5yndPpeuuqhS3Z/3/uNfTEto7VBz0ag9oRVjqOfI2PkBspoy9U7e6Ko2
         /rBUt/6VlHSb4h8UPi7WO9APs4ftWRytk7l0Ut4gCHdq1w+TSO+FXGLcdLbmAcVr/+Oy
         tGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700811315; x=1701416115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jlwNiD5+k6JtqRm4NuTxUsQI8cVUfE9sKvwgru76XA=;
        b=MBlp0NlM94hPOsfJRUrqm64SFb2IYV2wjbEkTNk/3kYu/PCl4kwqoAs8YKHOtGnlrI
         gbokCPQKUOU1XarGRkEon2KahCBXO3e8BzFIeKcqvEyvDmqaKKzFsIbnEVKMcz6NzzSg
         7Aludp2EKT7vwpFtCmsLnbxnWWcUC/8NcWb1nd0pqAak8iiihotOw7oauV0v8ojcAkc+
         bl1CxA6avJKz8I2qMooqaryKhyw2cr6qmTEIc9iJAAAeEoPm6hDGA1rjBc6hHPxU4VeO
         JWzkGx/prTjDs7cWC62n8hKaRPDxKbDDXoIg/oK5hV9mac5EtUyilq4mDxZ2sbP8FQkM
         euAw==
X-Gm-Message-State: AOJu0Yz70YbqIYqKJocTaqs4nD+yuBSnVvsV0C36ydYSt6+UjmkJVa62
	1oRFpFbPk0+JqsUgV83nEok=
X-Google-Smtp-Source: AGHT+IGMX5SbhmsUS3/IcWWi3CIukpy0RDB9FHPcO3EhyuIowBYeTXuCwImY4Kj0y7HqIoVEZz4xGQ==
X-Received: by 2002:a17:902:ee82:b0:1cf:96a0:e4eb with SMTP id a2-20020a170902ee8200b001cf96a0e4ebmr1825220pld.37.1700811315296;
        Thu, 23 Nov 2023 23:35:15 -0800 (PST)
Received: from localhost.localdomain ([89.187.161.180])
        by smtp.gmail.com with ESMTPSA id t15-20020a170902e84f00b001b9d7c8f44dsm2499329plg.182.2023.11.23.23.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 23:35:14 -0800 (PST)
From: Liang Chen <liangchen.linux@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	linyunsheng@huawei.com
Cc: netdev@vger.kernel.org,
	linux-mm@kvack.org,
	liangchen.linux@gmail.com
Subject: [PATCH net-next v3 0/3] skbuff: Optimize SKB coalescing for page pool
Date: Fri, 24 Nov 2023 15:34:36 +0800
Message-Id: <20231124073439.52626-1-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The combination of the following condition was excluded from skb coalescing:

from->pp_recycle = 1
from->cloned = 1
to->pp_recycle = 1

With page pool in use, this combination can be quite common(ex.
NetworkMananger may lead to the additional packet_type being registered,
thus the cloning). In scenarios with a higher number of small packets, it
can significantly affect the success rate of coalescing.

This patchset aims to optimize this scenario and enable coalescing of this
particular combination. That also involves supporting multiple users
referencing the same fragment of a pp page to accomondate the need to
increment the "from" SKB page's pp page reference count.


Changes from v2:
- rename a few other functions leaning more towards pp_ref_count managing

Liang Chen (3):
  page_pool: Rename pp_frag_count to pp_ref_count
  page_pool: halve BIAS_MAX for fragment multiple user references
  skbuff: Optimization of SKB coalescing for page pool

 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  4 +-
 include/linux/mm_types.h                      |  2 +-
 include/net/page_pool/helpers.h               | 67 +++++++++++++------
 include/net/page_pool/types.h                 |  2 +-
 net/core/page_pool.c                          | 14 ++--
 net/core/skbuff.c                             | 23 +++----
 6 files changed, 69 insertions(+), 43 deletions(-)

-- 
2.31.1


