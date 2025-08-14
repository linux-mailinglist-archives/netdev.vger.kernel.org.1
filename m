Return-Path: <netdev+bounces-213683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA3CB2647A
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 13:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17EC9188C0DE
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 11:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4C02F39D8;
	Thu, 14 Aug 2025 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMTAPdRV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADDF224AE0;
	Thu, 14 Aug 2025 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171662; cv=none; b=GGYYqYTQQ5xlFDq9QGxtc81AAwePUUgk5flLTxJ4rWce2A5pXP3HrryRqd41WPcL7oHjw2facNf0d29j3r6nJ3bCFwy8Lh10G5qHbcNGOaqpK9etHxt8xre982rHIqCXvKDq6mO2iw6jlA90RWrzB3yJW+qgSMmXiYSBnnrv0YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171662; c=relaxed/simple;
	bh=A8C5gazqmJ48JzfqoGJIA+vgNh6qCUzVgHXBKsB//IA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fPjgUTcQC0Hhdn5Kt/0puczensThAqiAEdJpPJwC0bvKnorQsQfHGRBJ7zxm5WbNg4zP55MJe4lBYIm76LwaLuGq7zjYco6XPhq8SbCfxJgTYh6thwp/+N3x/F7n7YPY6M2A82/zYrvARRp6aI3bXZXcWUDeEdYBUvPfMbVhR14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMTAPdRV; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b9d41c1964so464822f8f.0;
        Thu, 14 Aug 2025 04:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755171659; x=1755776459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i0/6PDRwmoxMB2zkQRHnauyWUyaH3X5Esl0n3IYS+bw=;
        b=UMTAPdRVWkDQHQxVgfaOLJWz6FVSGpVupsnOQSky5mcSXMG3jahSvRaoGrDCU53hVK
         7Prc5cZ4Krm5u+emfabcTG+BCtFQMu5K4FKI7wPJwZNirzHxZQVI6k58AwfPSRd6RZZJ
         nUTsgegbCCsYRFjEJr0TJzjzpnuT36fW7Fr4J+WP/OhGOCZfv1xO2tflVCmfHvB5acSk
         wmC0LNGCP2SuDvuJM99goW/clF0pxbwWgT4xyUFj/YO0A0kpLQdzUHYkeWAUnvpd5wow
         NXIV2cmmoVg/GlWO8i/WJzGIO1nd/OVC00H3U8wcZ7wMot1Gmnld+ofcxhhdRHTnOFjv
         lLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755171659; x=1755776459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0/6PDRwmoxMB2zkQRHnauyWUyaH3X5Esl0n3IYS+bw=;
        b=u3UeYal93WeKTwrIMyxjVvedyuKmz1LDHLnnmk28m3ygFiZM8YAl101KKWhhqgqbNs
         B4e0/sRdWC0ax1JhAGFXFVnzFMl5UbbZIWHXLahNgIpoWRQVqU/Xv3zaLP8zCecduVRj
         IBiwsCI9WR7tIrfZLP94fjlsK5md10aOMw4di19vCD4+jWj18tvyttrxz3T5QuISML6L
         GFPBtG9dqap6RcN2bO3vMruz2m7VU8xyhlSumBx4V0Mwx5UB6vEgitenNHlvraHB5Eqs
         i4bPmZpWmndgy9vB0Cpr2Bsf5shi7JpG2p5rUTdxw13nnvcCPmQqXWtmjEL1DgM7nMT4
         lRNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgkKPikvNop9jTycar7ng1i8/KyB7+rSFPPn+/lai8if/jUpoyzBinCi5yiH013VrSbhlQEWDvsJZUcis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc4eKp4GTng5AKmdMR2SWL3ivpUgJkwLQe4+wBBBLPRXE+cgaY
	WskdqENRIvWNojacvC9lcUY5qsdeEpulEd2jLadPHOLgOYwCaovYhzwp4JR08hGvEHA=
X-Gm-Gg: ASbGnctrsA/2d9F2CVBO6DJbQ18+WVStnY2BpICDRYFsvs3DtuKXWhg5q6Q+CyNx3nV
	ke4o3cdX68+bWD3fV8Izp4wgRcjs8j6B3FeeOl0nwv3fbAAn1wReBpFbdFjWKEhk7EUBKDvLg7I
	2ct27iWxbPVnCSVa7jlhKec3o0+x5UiX27TNKPFfYFNAATDu7dNdMlYn9XpAZ9RHhtscoQlUSye
	Z61icV+z87lcxm0tdztmjVqXTXuDSmf/IYe565hZup94zyg5lAVTQ072tiiV4zVK+Eo/6vs7Re2
	0Db9MDbT5xGVYi4sUfR1BTSn4utM8ERV+WXZ3M5XeeMSp8fXrgrdEJdZq12ZBEbsBn5HPS27Mak
	A7mG3wbvZx91A91/H46FTBuCLq93ctMKKo3Lvs9/MNYyI
X-Google-Smtp-Source: AGHT+IHhcTEqj71klh7+8dnZHQYivAgxoS2fXZPlLZ6syT/Yg1zX98DC/spkHxNhlJhyc+0DM28MJw==
X-Received: by 2002:a05:6000:240b:b0:3b7:fbe3:66bb with SMTP id ffacd0b85a97d-3b9fc3701f4mr2371959f8f.50.1755171658596;
        Thu, 14 Aug 2025 04:40:58 -0700 (PDT)
Received: from localhost ([45.10.155.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e04c7407sm41231921f8f.13.2025.08.14.04.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 04:40:57 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	shenjian15@huawei.com,
	salil.mehta@huawei.com,
	shaojijie@huawei.com,
	andrew+netdev@lunn.ch,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	ecree.xilinx@gmail.com,
	dsahern@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next 0/5] net: gso: restore outer ip ids correctly
Date: Thu, 14 Aug 2025 13:40:25 +0200
Message-Id: <20250814114030.7683-1-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GRO currently ignores outer IPv4 header IDs for encapsulated packets
that have their don't-fragment flag set. GSO, however, always assumes
that outer IP IDs are incrementing. This results in GSO mangling the
outer IDs when they aren't incrementing. For example, GSO mangles the
outer IDs of IPv6 packets that were converted to IPv4, which must
have an ID of 0 according to RFC 6145, sect. 5.1.

GRO+GSO is supposed to be entirely transparent by default. GSO already
correctly restores inner IDs and IDs of non-encapsulated packets. The
tx-tcp-mangleid-segmentation feature can be enabled to allow the
mangling of such IDs so that TSO can be used.

This series fixes outer ID restoration for encapsulated packets when
tx-tcp-mangleid-segmentation is disabled. It also allows GRO to merge
packets with fixed IDs that don't have their don't-fragment flag set.

Richard Gobert (5):
  net: gro: remove is_ipv6 from napi_gro_cb
  net: gro: only merge packets with incrementing or fixed outer ids
  net: gso: restore ids of outer ip headers correctly
  net: gro: remove unnecessary df checks
  selftests/net: test ipip packets in gro.sh

 .../networking/segmentation-offloads.rst      |  4 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  8 +++-
 drivers/net/ethernet/sfc/ef100_tx.c           | 14 +++---
 include/linux/netdevice.h                     |  9 +++-
 include/linux/skbuff.h                        |  6 ++-
 include/net/gro.h                             | 32 +++++--------
 net/core/dev.c                                |  7 ++-
 net/ipv4/af_inet.c                            | 10 ++--
 net/ipv4/fou_core.c                           |  8 ++--
 net/ipv4/tcp_offload.c                        |  2 +-
 net/ipv4/udp_offload.c                        |  2 -
 net/ipv6/udp_offload.c                        |  2 -
 tools/testing/selftests/net/gro.c             | 47 ++++++++++++++-----
 tools/testing/selftests/net/gro.sh            |  5 +-
 15 files changed, 89 insertions(+), 69 deletions(-)

-- 
2.36.1


