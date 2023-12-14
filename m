Return-Path: <netdev+bounces-57225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DE6812689
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 05:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321B41C214B9
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 04:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE21613D;
	Thu, 14 Dec 2023 04:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAfdOeew"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AAFF5
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 20:29:53 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-58d08497aa1so4958842eaf.0
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 20:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702528192; x=1703132992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/P4O4U+4wwAViywlkF3MrzqbKZwnRskxbSLZcAXpF5Q=;
        b=IAfdOeewOju1UiIGNlNVcNANHiJmhVoxSWECktQX8zMmn4DTAl4QVHoR0m9rL3ayNZ
         NKuSI+OkeOWYFk9nY/yTEft+nWxdrnVeM3TcPxoQoP93GmRac1T8l+5oq+ACT2qQmXiY
         8/3fP1pWQ+5d1ssVjhVqE53RZixMKAY9PT0yDrGZ3ry6jvGVBcOFkWH4b9L3A572XeAM
         XKQcPrm9Y+cdzwQilyBY2kzxKAYNfTH+zezFmM5mQofEibmZv42WYZawUQNy3bL22HZN
         RJSE7K9DoYDhIZvZt50e4mSKPx3DKowNMq2IyJyKgwOr6Ffg4cJL1ICUhFJHxJjRmPf9
         gFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702528192; x=1703132992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/P4O4U+4wwAViywlkF3MrzqbKZwnRskxbSLZcAXpF5Q=;
        b=L457qLDeG9dBAvGZJLzVarb/9esC9puLlPhpbuwGhUwpMzI6qj+BxlYTNHJA3EZqnA
         8t9Vfmb68OQGM9tFN9Yz838E1MeucKvmOJdFfn7/psZGpVGSW/a4UBK6+B9Qqo03DKmo
         2Pg5hMn6kkytUOdKwHeL7SKkTJC8EXFeDAEwwCaq2YVnlQfIfXiYW0Fwk+89O2tVqqAp
         Ch4DWTSyGpAr+EXSpXBSeZgw9PdOdXV+wzx3V+vs+xDK2C/Q7PmUIfluQh0Gy5Yn2N/x
         SJ6VggLLrsrTNrTBrVSDE5oio5raAA6XbQ27OUhNMNhJ2xXwT5R2p+9jApdqX+oo2xeU
         crAw==
X-Gm-Message-State: AOJu0YxSdyNN369McpCQyyjSoiQxn195Ksomic9fd9cvjHySMuTkv8fJ
	8QKsPwwZraatMKlSyFnVt7U=
X-Google-Smtp-Source: AGHT+IEur+yWhjU6Vv6HWv6uXSEGkSw86rCi6FXG9xvOI6PEPZLg++Pg7KxpwlZfPt7M4jZUitoIGQ==
X-Received: by 2002:a05:6358:2c93:b0:170:c991:d419 with SMTP id l19-20020a0563582c9300b00170c991d419mr10167940rwm.48.1702528192081;
        Wed, 13 Dec 2023 20:29:52 -0800 (PST)
Received: from localhost.localdomain ([23.104.213.5])
        by smtp.gmail.com with ESMTPSA id jg13-20020a17090326cd00b001cc8cf4ad16sm374412plb.246.2023.12.13.20.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 20:29:50 -0800 (PST)
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
Subject: [PATCH net-next v10 0/4] skbuff: Optimize SKB coalescing for page pool
Date: Thu, 14 Dec 2023 12:28:30 +0800
Message-Id: <20231214042833.21316-1-liangchen.linux@gmail.com>
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

Changes from v9:
- patch 1 was already applied
- imporve description for patch 2
- make sure skb_pp_frag_ref only work for pp aware skbs

Liang Chen (4):
  page_pool: transition to reference count management after page
    draining (already applied)
  page_pool: halve BIAS_MAX for multiple user references of a fragment
  skbuff: Add a function to check if a page belongs to page_pool
  skbuff: Optimization of SKB coalescing for page pool

 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  4 +-
 include/linux/mm_types.h                      |  2 +-
 include/net/page_pool/helpers.h               | 65 +++++++++++--------
 include/net/page_pool/types.h                 |  6 +-
 net/core/page_pool.c                          | 14 ++--
 net/core/skbuff.c                             | 59 +++++++++++++----
 6 files changed, 98 insertions(+), 52 deletions(-)

-- 
2.31.1


