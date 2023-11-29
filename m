Return-Path: <netdev+bounces-51979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E4A7FCD46
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 04:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231FE1C209D3
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 03:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEF3523D;
	Wed, 29 Nov 2023 03:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJfUcy6p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6E719A4
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 19:12:27 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cfb30ce241so34579715ad.0
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 19:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701227547; x=1701832347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=65Jgi4CDY1XEBO1YptBXXFf0Pz0m19bN0RDTr7BSLyo=;
        b=VJfUcy6pKqI4qiJI2d+xQ9HgD6JslaYzp4soZwS1oPXo6DgcXH8WBTPWe3Sa36jQSk
         KBKDbOHd4UWpwB+Wnq1mMsd2Dict6zTWBFzZ9UjRoHJ29ygCFUK6fWnkfc7+JRTiy1Cw
         RPny0699tikxcXbDLTshi8hzMTVJ+LXAqVgvI7ds98jWjz8pvzx2w1cGZpmA8C3yrEGt
         ucDm+qGzZcGWujN4O1yYErGaGjgSgN0eS3if0nlxSclF6LBKODsuadEYgjHln5/F9zvi
         S6q4SBMtuSnAmCLWcsYpmLy/jY/ch1Dma1I4pehsGp3cuhYP/7jPjQWp6vg0j7CERDfC
         GgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701227547; x=1701832347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65Jgi4CDY1XEBO1YptBXXFf0Pz0m19bN0RDTr7BSLyo=;
        b=CyP1mUZBDPD/MUWkabsYYrAWppOhRkKjp3rn1rIA4zuo+jnuOwruRcAS/ceL8SJosR
         ZoATWFG0fxxlfTP4AJN1Kv/2SZSAeDT75pcvfLXi9GfcfeicrrfXO+jTNPmrOWOYRYGs
         hvKUpzvXWjGXVVgjoQ0ELd7yhMzQw6ZZmKFP2Yk/QLPumeRQvfx4QCI+i4HKHT+5RGFb
         eKK9Je+lDCJjh7U/Vs9eWXMvr1xA2+hA3V0WefZUObnUkLutYEN9PR7+8xP1TVSyGwoJ
         IjtoMlIOYyK2Jv4T0l+U1JnsG9tZ2RpH+XPgiUHXN755mWoarC7oYggBIim5NuY3EDLS
         o2Cw==
X-Gm-Message-State: AOJu0Yw9x7/f+JJuf7yP/t2vIonzyAUGwPfLWiPNv9B5ZDxM0OqOUCaD
	5V0PS3LbCYUU7y75zpQeD8Q=
X-Google-Smtp-Source: AGHT+IG8TVO94vIzmzInu+2SxeAFE0aFO7BNafN3c1T9cbb2crF3muTw9JyVidwFJwpdgMb6FDIORg==
X-Received: by 2002:a17:902:b409:b0:1cf:fa6c:7321 with SMTP id x9-20020a170902b40900b001cffa6c7321mr3405458plr.60.1701227547364;
        Tue, 28 Nov 2023 19:12:27 -0800 (PST)
Received: from localhost.localdomain ([89.187.161.180])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902daca00b001cfc46baa40sm5669287plx.158.2023.11.28.19.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 19:12:26 -0800 (PST)
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
Subject: [PATCH net-next v4 0/4] skbuff: Optimize SKB coalescing for page pool
Date: Wed, 29 Nov 2023 11:11:57 +0800
Message-Id: <20231129031201.32014-1-liangchen.linux@gmail.com>
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
- use page_pool_unref_page instead of page_pool_deref_page
- leave pp page checking logic in skbuff.c

Liang Chen (4):
  page_pool: Rename pp_frag_count to pp_ref_count
  page_pool: halve BIAS_MAX for multiple user references of a fragment
  skbuff: Add a function to check if a page belongs to page_pool
  skbuff: Optimization of SKB coalescing for page pool

 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  4 +-
 include/linux/mm_types.h                      |  2 +-
 include/net/page_pool/helpers.h               | 45 +++++++++--------
 include/net/page_pool/types.h                 |  2 +-
 net/core/page_pool.c                          | 14 +++---
 net/core/skbuff.c                             | 48 ++++++++++++++-----
 6 files changed, 71 insertions(+), 44 deletions(-)

-- 
2.31.1


