Return-Path: <netdev+bounces-54368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDFF806CB5
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 11:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF71E1C20937
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 10:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA64230344;
	Wed,  6 Dec 2023 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZUj/A3/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D924D9C
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 02:54:33 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1f060e059a3so3730571fac.1
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 02:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701860072; x=1702464872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2qSQoXhaZIkSox5U4y8/LH5pk6N5f+xtot1Ew+ZDWQM=;
        b=ZZUj/A3/dqwixetG/U67Z++J1pXa8ugYXPoROHyUZoW07vjWpLTSi3N5TkDvVIFBN3
         MZaNeOfdTVOejfinR/RzgrhsfNUx8vbYYo7T2Um1KYn8x3BRA+dd42Px6Ow4LkmZLVQH
         dGpYZx6UyYXILyG2AukZVYXcfMruskVIJkF6F2QljALiJhkbU9QEnyEGlpc1hhZZaR34
         qv0jibCE4Wv22y+H0stawFNiAsHSNjuZ8QIvTQq/BFNkOjEvrnczZX30m0EMXOmC8baa
         4fR7nfnw90m3JoTEPh4lqhpwmYHsK2bgyXbi9cFybG6794+fp2M9gnQbb+svB6yPRzm/
         Pxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701860072; x=1702464872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2qSQoXhaZIkSox5U4y8/LH5pk6N5f+xtot1Ew+ZDWQM=;
        b=ZLx92q+7qyEtzgtF1Uk80bISBDIFpNAlNGdTz1rPp0XuXcbxFu5G/PC7IyxNRJBXO6
         tZuHZRkN5U/lCc/q26FL93oV3ZTeTDRBCjuUV0avBCBtWdvxjF/gS7glaRg0edLLcv7e
         /yhAJMVbAzYzMMixx/BrzEsrJREB0OzkmCRVG7FvDjsdhWfsM9msYytt7DNe7u3Q6ld3
         owYl5KItx70UMnDmwmll642IOLezu1rlH6K1hHc7Nf543VK4YnfXlER1p2/BnvldUp2G
         tz7yJAINQEP2EhRM/Nre3yC1qOvU+OKhG3ayyyPz69KEqLDwCLxDcJeySrHCQIn7Rknh
         UxDg==
X-Gm-Message-State: AOJu0YxBiAwsvPm4s+OGR8nYs8n6dhWiIWLenpl82FfO3jvuGxpAFvph
	LGAbk8gEt3h5Ok3UVxOzHzs=
X-Google-Smtp-Source: AGHT+IG6Q6CwXDOVK1QrybKOfwa9jQm+Yy2c7KW0m9JQ9gPTTFusxHRJxArUpmVKE2k1Pzd7pOTruA==
X-Received: by 2002:a05:6871:330a:b0:1fb:205d:756b with SMTP id nf10-20020a056871330a00b001fb205d756bmr800031oac.19.1701860072268;
        Wed, 06 Dec 2023 02:54:32 -0800 (PST)
Received: from localhost.localdomain ([89.187.161.180])
        by smtp.gmail.com with ESMTPSA id n15-20020a638f0f000000b005c6801efa0fsm5388796pgd.28.2023.12.06.02.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 02:54:31 -0800 (PST)
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
	liangchen.linux@gmail.com
Subject: [PATCH net-next v7 0/4] skbuff: Optimize SKB coalescing for page pool
Date: Wed,  6 Dec 2023 18:54:15 +0800
Message-Id: <20231206105419.27952-1-liangchen.linux@gmail.com>
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

Changes from v6:
- provide sufficient description for the first patch
- rename the utility function for checking pp page


Liang Chen (4):
  page_pool: transition to reference count management after page
    draining
  page_pool: halve BIAS_MAX for multiple user references of a fragment
  skbuff: Add a function to check if a page belongs to page_pool
  skbuff: Optimization of SKB coalescing for page pool

 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  4 +-
 include/linux/mm_types.h                      |  2 +-
 include/net/page_pool/helpers.h               | 50 +++++++++++--------
 include/net/page_pool/types.h                 |  6 +--
 net/core/page_pool.c                          | 14 +++---
 net/core/skbuff.c                             | 48 +++++++++++++-----
 6 files changed, 78 insertions(+), 46 deletions(-)

-- 
2.31.1


