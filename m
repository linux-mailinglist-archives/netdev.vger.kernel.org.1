Return-Path: <netdev+bounces-52498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5DE7FEE63
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 12:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B6A7B20CB2
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 11:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D083D3B2;
	Thu, 30 Nov 2023 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btH//wSu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675BC84
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 03:59:13 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cff3a03dfaso7757135ad.3
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 03:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701345553; x=1701950353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TgQzV2hMqysydijjOBBVYAfd7c5Y+94qieNr1NTOzhw=;
        b=btH//wSu53BDGX3/EVB70QenB/KSSWOPXRjpgT+3U2PfvOhyQy4G8vX1zeuwysrRBm
         0uqd4Op+3gqZw+QYkbC4tPlJWms4RsQMP7/yCl8dHAlW4LPJSjaYu0p7TGQ5VX1xV8x7
         Ys52iGFMuUQ0mZYGiyXbMWMWwk9CeNA1odVvNoqbYffwDFnUUKeD9gwH5j8XL9+8sU/s
         /F1de+NpqwYjB8tNoY1nBBUR52dRnSrmNT0R34XNmJ3M0BGmGp6WqOhfFkwaQtKNEn8N
         3JzZhtPgsXV4yn9T2JA7RmBC/XvjEfiaELCLEnGrkq/L7no0mFVZfgCBcRFBRNPMKkej
         xHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701345553; x=1701950353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TgQzV2hMqysydijjOBBVYAfd7c5Y+94qieNr1NTOzhw=;
        b=XPXixL5q0YEmRYYqhpHAHq/IgIQfnf2FWWyUzf1YQmyYJNgA9/pKcsIh5SJomxV/pX
         vCSRKt0FsjNTZaZkIFQ3/wp726k1pDGRlygUg6zwnGroGAa0fY3Fs/w6bsHYZfP9Ufqx
         1XlEqv9DoAHkXAipv4CYggb8UsmRD7gJlLq0KSMJbeYAdLIEuvl42QzxDaGLdmQrNIz9
         8oljGt14jL+hkhvFC+KnIW+/HUgPL4MYfC+KIM0kKx6saeVV53AFSg0f3Jm+td6eyjQV
         smjdR6cS3OpCDW1mt8QW0aVKDg0E0QoSk/jTy/ZhDBhuDcSeMxmiXceCahq0YpnkssgG
         dSug==
X-Gm-Message-State: AOJu0YzsOzeFDVTyDWxbl3UlTc4EFHSIXaAy/bQI4qzhxWSVhBKZKYiG
	BkxVxrVxQRRPbHUjhFd8gtk=
X-Google-Smtp-Source: AGHT+IHU533khUVPT7MjRqJYmno6ktd21A3+gDUpoDKKVA6r6F5dc4QixCtBLnyKX57wRygZya4qhw==
X-Received: by 2002:a17:902:e744:b0:1cf:bd98:633b with SMTP id p4-20020a170902e74400b001cfbd98633bmr17541902plf.64.1701345552764;
        Thu, 30 Nov 2023 03:59:12 -0800 (PST)
Received: from localhost.localdomain ([89.187.161.180])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902b78a00b001cfa718039bsm472530pls.216.2023.11.30.03.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 03:59:11 -0800 (PST)
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
Subject: [PATCH net-next v6 0/4] skbuff: Optimize SKB coalescing for page pool
Date: Thu, 30 Nov 2023 19:56:07 +0800
Message-Id: <20231130115611.6632-1-liangchen.linux@gmail.com>
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

Changes from v5:
- fix a style issue


Liang Chen (4):
  page_pool: Rename pp_frag_count to pp_ref_count
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


