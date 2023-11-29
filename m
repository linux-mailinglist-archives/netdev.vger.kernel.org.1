Return-Path: <netdev+bounces-52114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 286717FD58E
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 12:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9E31F20F17
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 11:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CF01B279;
	Wed, 29 Nov 2023 11:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsKM1MmO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EF51BCA
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 03:24:27 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cfc34b6890so6142255ad.1
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 03:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701257067; x=1701861867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EJmCJbg2unIrLNyB6mMQhrpmPKGl/tPs30r44BnRYC8=;
        b=TsKM1MmO8e898JXtd3j4n5050rsRiZaF1hosxfZJ0AHuclSuFor63915OKHT6wyolb
         U0L4tcQtgsjhussjiZiiWwMplBPx20Ls172MZAtwi/p8CZWAfrHlvq4dwQHH+4RL6kYo
         EDQPZYHjcjOdT4bzkCbb+a7Zkbk96UsoNq8QxZQT+mhcv22auEQ0OOK8wCPKZG2PsDNu
         3eoMa7U2yCl17KIZw08MzJ7p4KU8JPbujKMhs9PVeNKPFCbKYFi7I3covXZAZ2T5scYJ
         FNZ4gPbSNWL+/AlG+q4UxUEGi3rxl95bdrem8zbgzAYqp6UQKqHZckTAacKKn59KCggu
         MJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701257067; x=1701861867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJmCJbg2unIrLNyB6mMQhrpmPKGl/tPs30r44BnRYC8=;
        b=g9IEqXQANsVjSZhxgZ2dE2YPp3McJBoNTy629xFwsxgvVskL4RGSSrdMKER2XLfDJy
         NTVa3Ryk9qqj7VJlHEAcAkD2LO99rwL+H/MLDgB+UXKA5hewehXEpdSHhcl0vO6QJiCM
         bcBOwbg4wpmwcEatv6L1ATqRy4ZC/84eovOeE+lIg4V+WsOVd50RHfS8ZsGVTJtxYlZR
         somQJ5n+u+ozQkGBNT3qgle9ZbZ14hVek3pCS2uRAp5xXgP7ZVtfSQxfpt3axYapo7xJ
         VIvrT+cavfiKc9LPq+RdjgGoghkFQaLsAWZNw5CWPQQfAhTeSPezCglCclwSEugsvJGZ
         Zx6Q==
X-Gm-Message-State: AOJu0Yxy9ozZPbmFN5R9vKsm4schQ1qSdJAUoEQHJbPvVoyU+r5dovB0
	o6kLlgAX36eZ7+S3MLR7JOQ=
X-Google-Smtp-Source: AGHT+IHPtrhNJElGFoSlRRa9htkiJw1G/4qkpCx/tap9I0jADSqFFRW2wIC64qNCuihA28nOdgoLXg==
X-Received: by 2002:a17:902:f68e:b0:1cf:a0b7:c68b with SMTP id l14-20020a170902f68e00b001cfa0b7c68bmr26693689plg.8.1701257067202;
        Wed, 29 Nov 2023 03:24:27 -0800 (PST)
Received: from localhost.localdomain ([89.187.161.180])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b001cfd0ed1604sm5460710plc.87.2023.11.29.03.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 03:24:26 -0800 (PST)
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
Subject: [PATCH net-next v5 0/4] skbuff: Optimize SKB coalescing for page pool
Date: Wed, 29 Nov 2023 19:23:00 +0800
Message-Id: <20231129112304.67836-1-liangchen.linux@gmail.com>
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

Changes from v4:
- remove 'inline'
- rename skb_pp_get_frag_ref to skb_pp_frag_ref
- use page_ref_inc instead of get_page
- add helper to increase pp_ref_count in page_pool/helpers.h


Liang Chen (4):
  page_pool: Rename pp_frag_count to pp_ref_count
  page_pool: halve BIAS_MAX for multiple user references of a fragment
  skbuff: Add a function to check if a page belongs to page_pool
  skbuff: Optimization of SKB coalescing for page pool

 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  4 +-
 include/linux/mm_types.h                      |  2 +-
 include/net/page_pool/helpers.h               | 50 +++++++++++--------
 include/net/page_pool/types.h                 |  2 +-
 net/core/page_pool.c                          | 14 +++---
 net/core/skbuff.c                             | 48 +++++++++++++-----
 6 files changed, 76 insertions(+), 44 deletions(-)

-- 
2.31.1


