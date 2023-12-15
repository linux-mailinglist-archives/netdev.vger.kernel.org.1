Return-Path: <netdev+bounces-57766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5155E8140A4
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 04:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E130BB22021
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C5D20F9;
	Fri, 15 Dec 2023 03:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIGDLEam"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124FE53B8
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5c21e185df5so234913a12.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 19:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702611035; x=1703215835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ncj5uTnuRgdnCzl7Emd8jgGhrWmYxy85If64tkSyQQg=;
        b=NIGDLEami8JiWlDml6K2MzpHbOxqDNuEByN5dFzipcZszTs9P4tk6SS1O/dZF7ebeG
         b7/yTs4FFVAPWq/Xuuozf4VSvX0X6xxhdna2ID8pGMjWAQeZ9lelZE4j6cWrr9SxLqNC
         ES1fpCi8fEVAiyRyMfeacSY7oS9tStL2jOyOBkQpFn5Mb8HcI0xf6FGrhIIdINbouNDa
         0Gl9c9+daFcNPCfZu3nD4B28tV4q77mNF8Rx9XNbgAczpS8BdSl3ffrwtbRU9i2AfEcV
         il6x/ixUZKDt9ymX6BcXd02YzjWcm7yapbCx/+3/Icxv1ftIHTrF4T9Zz7kvXnj36Hsq
         S1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702611035; x=1703215835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ncj5uTnuRgdnCzl7Emd8jgGhrWmYxy85If64tkSyQQg=;
        b=ZJScROUiS7BOw0EhXUzkojuvHQU8rqyvNd9g1xTbCNDhmQ9c7QAeKHtw1jYd5r6Zla
         n97SjZSRGg3EvjHLtLQQPGs+DOKnWuFpvfWZir44VbcQBaz1AFJdnQaW+NfcFAnUkLbS
         OMwtqpwejaF5JqcXGJZs3YSVrD/yA3tO+J6q0hxyZGqeAhzNDHcoAl8CKELVbCBGBmwB
         aAWkQcaFxAUTtEVPOWHEo+hIgyxcTMu2Zrc1FYSbtNct1xU9yD8O9oJacIgC+DrtdbLc
         A0j2lXVA2LZ6UHuj36Ob/OUkkNFQvSmnKf1J5QINvLVv5/Q58Iamqo5at6ucxLyNOSDt
         7CZw==
X-Gm-Message-State: AOJu0Yy2C311cAw8GflsxJ5jQlicvpO8i/LQg49rJoc7Q54eptKAi/Wl
	KTVbjk+mMpVtRYtXPWeYBvFYf2uaKdH9jjH1
X-Google-Smtp-Source: AGHT+IHawRCaWwaBKTcTAxMfDlS8AoPi6CMHLZFNhQdFjaq/yPKGxy1sj9t+lcx1lgq8YVHbO4fQ/w==
X-Received: by 2002:a05:6a20:5648:b0:190:3f60:ee09 with SMTP id is8-20020a056a20564800b001903f60ee09mr10823563pzc.36.1702611035249;
        Thu, 14 Dec 2023 19:30:35 -0800 (PST)
Received: from localhost.localdomain ([23.104.209.6])
        by smtp.gmail.com with ESMTPSA id v15-20020aa7850f000000b006ce467a2475sm3702775pfn.181.2023.12.14.19.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 19:30:34 -0800 (PST)
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
	jasowang@redhat.com,
	almasrymina@google.com,
	liangchen.linux@gmail.com
Subject: [PATCH net-next v11 0/3] skbuff: Optimize SKB coalescing for page pool
Date: Fri, 15 Dec 2023 11:30:08 +0800
Message-Id: <20231215033011.12107-1-liangchen.linux@gmail.com>
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


Changes from v10:
- re-number patches to 1/3, 2/3, 3/3

Changes from v9:
- patch 1 was already applied
- imporve description for patch 2
- make sure skb_pp_frag_ref only work for pp aware skbs



Liang Chen (3):
  page_pool: halve BIAS_MAX for multiple user references of a fragment
  skbuff: Add a function to check if a page belongs to page_pool
  skbuff: Optimization of SKB coalescing for page pool

 include/net/page_pool/helpers.h |  5 +++
 net/core/page_pool.c            |  2 +-
 net/core/skbuff.c               | 59 +++++++++++++++++++++++++--------
 3 files changed, 52 insertions(+), 14 deletions(-)

-- 
2.31.1


