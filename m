Return-Path: <netdev+bounces-55697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B949380C022
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 04:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63EA51F20EC3
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 03:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DB4168C3;
	Mon, 11 Dec 2023 03:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8aAtRtB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7697AED
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 19:53:09 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-35d67870032so28155805ab.2
        for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 19:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702266789; x=1702871589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U/BjbyQjJec8rLWkFIX9Q+pRox3mm5m7LDPhOp654os=;
        b=V8aAtRtBei67KuGigZQLuP5oMKDXjy8p1OJSVF7j5pufUIWrCf6Kogn1hPf/kgJfN+
         4kVCa1XItx5lwNyW7o5YR2fQzuYBOp7ohk9uqg3nZqt0MYAfjR5aPbzQH6byznZ80t62
         TesOQuDEHA+ngdkRl7E+2IS7SHb0AUPaM1X7ewIOfjvDf2aBP1MCdSKVJhc9bOjsFd4+
         9klI+Eu9lqOoEHwmvtx+2mCVeiCxvKWmPkj/4msdtn0wrJo19SH8ALrs98HFa9nZoPOa
         obLgX/PocmFYkPI9ouq332uYR2jxjN4fYSe6zd9VydQwLPD8goO0AT4YrcTmPes1ifM1
         1rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702266789; x=1702871589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/BjbyQjJec8rLWkFIX9Q+pRox3mm5m7LDPhOp654os=;
        b=k+xubrs78W1LuPLi+LFRf8F1EEVLUw7OYvE1MKqKUbQ4jS0J40XdVNmvfsyH5Ro8nz
         lskcvSfrOZv+R/1xnxRtFKzBrqEcK4KK386c2uo/dwm/kcJ+F9bFbA864rYKI8aZpGes
         9vyixOCTa0Fvr5P2q+MIZNfXNR+rzEINQik0CamU9mx5IGTYZ5mtP4tp8yfHr6HkS6wv
         Kx3D3WkbjZN2daBuwd57AWW1iuFrYLI4KBHotIRqw3n/5Tz4/fm3opJSpZpuimrYd26K
         yygc238ML4cZU5s13kPX9/nKD3PcwZQfPSvnJSpDWsJBhwzZIr8G7oDBZE7eMmfMIZGc
         qHOg==
X-Gm-Message-State: AOJu0YxSoTRj3sCdWRD0I3cY2dq7Ow3OD89koHgyoVwbCPGq68DrHZ4K
	ngpslIx9J1QinHzU1MocKBKyaWF2FG8=
X-Google-Smtp-Source: AGHT+IEfhLY9sdgn8OVOIgj4Wz20yRIZwgJ0sx3lwaM/MQur6utggZeRhvWq6YNlaD564IPzyY1OBA==
X-Received: by 2002:a05:6e02:219d:b0:35d:66dd:ca6b with SMTP id j29-20020a056e02219d00b0035d66ddca6bmr6883399ila.7.1702266788808;
        Sun, 10 Dec 2023 19:53:08 -0800 (PST)
Received: from localhost.localdomain ([89.187.161.180])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b001d052d1aaf2sm5411491plh.101.2023.12.10.19.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 19:53:07 -0800 (PST)
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
Subject: [PATCH net-next v8 0/4] skbuff: Optimize SKB coalescing for page pool
Date: Mon, 11 Dec 2023 11:52:39 +0800
Message-Id: <20231211035243.15774-1-liangchen.linux@gmail.com>
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

Changes from v7:
- move informative documentation for page_pool_fragment_page

Liang Chen (4):
  page_pool: transition to reference count management after page
    draining
  page_pool: halve BIAS_MAX for multiple user references of a fragment
  skbuff: Add a function to check if a page belongs to page_pool
  skbuff: Optimization of SKB coalescing for page pool

 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  4 +-
 include/linux/mm_types.h                      |  2 +-
 include/net/page_pool/helpers.h               | 65 +++++++++++--------
 include/net/page_pool/types.h                 |  6 +-
 net/core/page_pool.c                          | 14 ++--
 net/core/skbuff.c                             | 48 ++++++++++----
 6 files changed, 87 insertions(+), 52 deletions(-)

-- 
2.31.1


