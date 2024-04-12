Return-Path: <netdev+bounces-87458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAEC8A329F
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 17:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD71B1C22129
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC8C1487E4;
	Fri, 12 Apr 2024 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O1xMdSjQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E481487CC
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712936332; cv=none; b=SQyRO5YDtEHEgLHpq6QuP6M3sBIlqID4TtwtvK8IRuEpfHoYr6S3N3+FscMtj5VJiyYbJUETib8rRHEodd7iPWGU3TEQpdvTqR1GR2Bi58itltLpkD2dAG5MhDFv23VeslbF+8C0ICwWpTjoLdEIljKw7GrdDh/Z8clSIhGghOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712936332; c=relaxed/simple;
	bh=FKKMgqvHByKA4tvc3eA5ffKwH9FrWfmfSY8lLNIiWog=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fiNFO57HS+3NotAAcTXUq5Wd/SLfovqvmacI7yIab4XCni66xTPsCLrxKmWndx3H8wK4iJPnRmUoD2l5w0qU0f0zljw0Gk3ea8crpu4c/5Wghm5HIxHXmf4aODOKRWsY2iNEnEYwq27VRUUadL19Fd2jzNX+5zzUpaDOJLKCVMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=O1xMdSjQ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-343eb6cc46bso669430f8f.2
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 08:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712936327; x=1713541127; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6PZpErhXoFLSgcwKLydiKCIqyrzv/osbJWkwgwT5Ay0=;
        b=O1xMdSjQwoUHvRW1ydPKWZqHpGO7AFro/nxnv0Ztanz5XcHzWmzb3KujO+CO7KcfEE
         2fqQAh2pdC/PYCWUVjjMNeguYH33VAJYArT3MGR3/+6D3m8EtalFyrJlg7rdx0HY2TT8
         Y4suxBITFQHxYbXucrfrmcnnFLOabNsSTU3RtSjZoZJiMgjRJneXc0bTnQ46d3k1yt4a
         f74wU3mqFXz/aQUKvEe39hl8wtbRz687KjrWsFN2nIIvb3gQNdv1AHSIDrJ7JVplbA0B
         aG539MzeCL/fMcwxqcrinI3hNGFTrLLjyiJTGb+G3b5VE5cFzqpGGjMVspO82NTkINF0
         TNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712936327; x=1713541127;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6PZpErhXoFLSgcwKLydiKCIqyrzv/osbJWkwgwT5Ay0=;
        b=K/vy5sMl2nTjyjW2uZQoBvg8tLfPjA4e5/NCmUo2+2R0rUDEeCheLZtpx5qpIv/Wu9
         a2EzIEhXMjHGHio94QYoMa3CyPI7Hwt42/Fa0DrmHFaNAmiuQGCdJvaXCQ/gEtpOlSS+
         bVVBGQ6FonAh5mdlA79FzcOJGC5IjrxwRcJ1P73zDD6iovN/Qi7raPKkIFgiH/l26U7U
         zd5C7Q/taRdH/ym1NVF5ayzJ1HmG1lzqwB5RfG2yJHQPCR9Gx1pCO4PaUiIOzHT9yp07
         +XXyhbdE40imijpx4geiqAO+0Mq+ocBdzA0GiG414lTxY9Q090EEWD5cty5NpSGWhbFg
         A2OA==
X-Forwarded-Encrypted: i=1; AJvYcCVdYI0XRsm159Py7Kg5rOdKIS7YjsXKZ9l9YlUFMVOPH4J8EkNIiXw35uZRI2Tj6HQ+xyhN4n/PK820RfPmdHRJsjP0G2nn
X-Gm-Message-State: AOJu0YxWMid21FH441f3S35JwdCgtIgecs881fN6rEsp3pfrPq14eagg
	Qi6m1Y7FuUEofhiiq6AP5aEb7As92cEVIYY+61mbJ9D2f/nt1rJcKEuDC7XQNR8=
X-Google-Smtp-Source: AGHT+IFvHJ+ngcqc9RhfIXSS90heNPGSCkUVEJnwKOCeh0icy2zvFyQwZwEFve7IGLGy1/ZjqkhBHw==
X-Received: by 2002:a5d:6082:0:b0:341:c589:8aea with SMTP id w2-20020a5d6082000000b00341c5898aeamr1589834wrt.63.1712936326779;
        Fri, 12 Apr 2024 08:38:46 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.74])
        by smtp.gmail.com with ESMTPSA id k9-20020adff289000000b0033e45930f35sm4545791wro.6.2024.04.12.08.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:38:46 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Subject: [PATCH net-next v9 0/3] Add minimal XDP support to TI AM65 CPSW
 Ethernet driver
Date: Fri, 12 Apr 2024 17:38:31 +0200
Message-Id: <20240223-am65-cpsw-xdp-basic-v9-0-2c194217e325@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHdVGWYC/43QzW7CMAwH8FdBOZMt30057T2mCdmJOzJBqBrUg
 RDvvtDbpmrK0bH9y1++s0JTosJ2mzubaE4lnXMt+u2GhQPkT+Ip1popoYxQSnM4OcvDWL75NY4
 coaTATUSvvBUejWd1s74SxwlyODx3v0bIqbzW+f0JUj6mTPtZPAfHiYZ0Xb5/Z5kuPNP1wj5q5
 5DK5TzdllyzXPr/Rpgll7wfBLqAEbQUbwi3Y8KJXsL5tJCzamAUF1zI4AJAAES3wugGRlfGxt4
 Y6KM3sJbGNDCmMtprJ8FpMB5/M9tNw7oiY8lGCsL4lRS2IYWtDAbZ6V52AsPaTVwD455ppCIaB
 ovRDitM18B0lQna2y54FSHiCuMbGF+ZQRsl0foIov/DPB6PH37djukcAwAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Ratheesh Kannoth <rkannoth@marvell.com>, 
 Naveen Mamindlapalli <naveenm@marvell.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
Cc: danishanwar@ti.com, yuehaibing@huawei.com, rogerq@kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712936324; l=3692;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=FKKMgqvHByKA4tvc3eA5ffKwH9FrWfmfSY8lLNIiWog=;
 b=kwII0V9/2FbZDaTT8w+6oNfTEwAwUdOycaJSWRYmzp5yES3hHPlZUB8rpnxgLZj6mscBbWIPZ
 z+FRe6YDvzgDTx5m8F8cVA6A+X+ILKW6dCkIu4bWnfCN8UUKFssa5lV
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

This patch adds XDP support to TI AM65 CPSW Ethernet driver.

The following features are implemented: NETDEV_XDP_ACT_BASIC,
NETDEV_XDP_ACT_REDIRECT, and NETDEV_XDP_ACT_NDO_XMIT.

Zero-copy and non-linear XDP buffer supports are NOT implemented.

Besides, the page pool memory model is used to get better performance.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
Changes in v9:
- In k3_cppi_desc_pool_destroy(), free memory allocated for pool.
- In k3_cppi_desc_pool_create_name() function, remove unnecessary
error messages on mem alloc failures.
- In k3_cppi_desc_pool_create_name() function, move desc_infos alloc
forward to leverage pool_name freeing in gen_pool_destroy().
- In k3_cppi_desc_pool_create_name() function, remove unnecessary
'ret = -ENOMEM' since ret is already initialized with -ENOMEM value.
- For rx, do not build the skb upfront any more, Instead, give the page
to the HW then build the skb once HW sends a completion.
- Link to v8: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v8-0-f3421b58da09@baylibre.com

Changes in v8:
- Fix some warnings reported by patchwork.
- Link to v7: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v7-0-c3857c82dadb@baylibre.com

Changes in v7:
- Move xdp_do_flush() function call in am65_cpsw_nuss_rx_poll().
- Link to v6: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v6-0-212eeff5bd5f@baylibre.com

Changes in v6:
- In k3_cppi_*() functions, use const qualifier when the content of
pool is not modified.
- Add allow_direct bool parameter to am65_cpsw_alloc_skb() function
for direct use by page_pool_put_full_page().
- Link to v5: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v5-0-bc1739170bc6@baylibre.com

Changes in v5:
- In k3_cppi_desc_pool_destroy(), free memory allocated for desc_infos.
- Link to v4: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v4-0-2e45e5dec048@baylibre.com

Changes in v4:
- Add skb_mark_for_recycle() in am65_cpsw_nuss_rx_packets() function.
- Specify napi page pool parameter in am65_cpsw_create_xdp_rxqs() function.
- Add benchmark numbers (with VS without page pool) in the commit description.
- Add xdp_do_flush() in am65_cpsw_run_xdp() function for XDP_REDIRECT case.
- Link to v3: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v3-0-5d944a9d84a0@baylibre.com

Changes in v3:
- Fix a potential issue with TX buffer type, which is now set for each buffer.
- Link to v2: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v2-0-01c6caacabb6@baylibre.com

Changes in v2:
- Use page pool memory model instead of MEM_TYPE_PAGE_ORDER0.
- In am65_cpsw_alloc_skb(), release reference on the page pool page
in case of error returned by build_skb().
- [nit] Cleanup am65_cpsw_nuss_common_open/stop() functions.
- [nit] Arrange local variables in reverse xmas tree order.
- Link to v1: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v1-1-9f0b6cbda310@baylibre.com

---
Julien Panis (3):
      net: ethernet: ti: Add accessors for struct k3_cppi_desc_pool members
      net: ethernet: ti: Add desc_infos member to struct k3_cppi_desc_pool
      net: ethernet: ti: am65-cpsw: Add minimal XDP support

 drivers/net/ethernet/ti/am65-cpsw-nuss.c    | 659 ++++++++++++++++++++++++----
 drivers/net/ethernet/ti/am65-cpsw-nuss.h    |  13 +
 drivers/net/ethernet/ti/k3-cppi-desc-pool.c |  46 +-
 drivers/net/ethernet/ti/k3-cppi-desc-pool.h |   6 +
 4 files changed, 623 insertions(+), 101 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240223-am65-cpsw-xdp-basic-4db828508b48

Best regards,
-- 
Julien Panis <jpanis@baylibre.com>


