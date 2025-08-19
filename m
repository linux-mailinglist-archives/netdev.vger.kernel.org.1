Return-Path: <netdev+bounces-214872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F214B2B979
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 08:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0DE31734D4
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 06:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA35F2690D5;
	Tue, 19 Aug 2025 06:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBCHn/ny"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37601AF0C8;
	Tue, 19 Aug 2025 06:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585166; cv=none; b=azw5Ml/ZjadZ7CTT+6wpvTvSugL3zU9XxXITzEAheyox/mjx4qHowtsK4ehzFZdWaHR5urDkSgjDvOi/jgkYafjq9ReKox5X0YSQ9lGkyPpFQkJNuI3l7gQbppohU7lhp5r1tRUixZxiCt8y8ECvKwwOyuOa8FGzpcxt6sZhUHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585166; c=relaxed/simple;
	bh=Jof04T+/mttylZx7yuLntizGnCO0cY9QCIhmVBxRIYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CDJFIQbS9765i6g1DqgOQlYFj9EZ0Hl8IBBHBGTSWz7j4bqRNFh7niAdDjfUMHek7UzGEqE8ZQ+aPyn0dNismSjQ0Y6jAJ9jRTWqWeM+pmQRe02aBA6qvxVLlx+4dldTCermejdPaOZw0Ygnos+faLvMKOkF3m/u6L9N/fUgJEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBCHn/ny; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b9d41baedeso2590849f8f.0;
        Mon, 18 Aug 2025 23:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755585163; x=1756189963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uSAzqVQc6JyL5nIPW5HIQmKZFDjkdHuqGlO57odkRuk=;
        b=jBCHn/ny7Y9OBMt1hw8c4aJI0a/Z1dN/vGPU2FusUea0rzi0epLHuwEJiVprYQc1xA
         6jC4gpjgzHjYCEDJr2QgEUNdKbXPxLEYgxOX86prNM6Q3U+XMzFPYzYgOCUjQrPioom1
         w2dVTNEfV8W2r8fSRnzKjENRepygi5Rb7D9lMbpCV174LFSLgBxh9fdJeubzoVh/vUe4
         l6lh46rR1JUOVue9CeovyALcNti76ogg19U/of1O/aui+K/GEXJhTfJ8G1gBCrFuqWp7
         qe28DmDN5Jsi1H5/W7N/3TMigXasmvxCd3rYRzhe7NUQJQbZCx8a/5qPboIcwsrly4dz
         sFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755585163; x=1756189963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uSAzqVQc6JyL5nIPW5HIQmKZFDjkdHuqGlO57odkRuk=;
        b=gvwJrUNKGGnRxDHfpkie16XdL6QjqYUEsIvz9w01cuyHuBN7ahUOpO2TAKlWQHDrDK
         YWMDsXwAc0Ho7qLkS8sLVyJzereBAIH31+fcK+3ciOfqeywnfGhchyNttgOZP8IrhREk
         HeRpXKxH4E592S7sxd9JRaFl5wGiYu01zoIFCfnPfOwrWmvkAL3TwH9tBL8hfh7jpuqB
         XuT8BAbCD/K7dwK3v5AGhjxD7rvhlrQG/7QfSJQmPgyIMo2735j+34PXpGrOIapc4Ebk
         +d78rrSAdmIO5I5FhNTdROJmuzyujQAVtJkCquXiydsqEf04qnOXi7f5MHn8grcqWMC8
         y7+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOjxz3EqKaCt6gQ3PQPjRmF+NhIASkLMuBhKiXYQTEFZlT4S99ZMjNzmzOtg+BWb7QdOEX9PwZUM+VhRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVOjHLrNF/wD4eBzfBR1nqPfQywgYsLR2ggo5g6xaEDx3jwTCp
	6EMM8X+Ujx+Ju2R3ynQkCBP1CLsMG6inPyge/+DiCblVCb5qVMvPqCPpWblDccSD4JY=
X-Gm-Gg: ASbGncs8z57VzB7C0zFfZhTPWLvAbuxLzULUZ+07L4JIQ2Sjpr3m/Gx8V7ulvYiMw9C
	R0F9OiRd9uucqRQpY1x1KXjyNVLViF4cSF8Ewy3w0Mu4H5qIU/VrDncRqUvm3wWW7buSu/FE6NO
	tUdaGmq9wBzgfyi6Kdy/EWF5XEujzgwm2Gh2juIM8bw6gMgIS5ychzTBbfR3zcHdal6tRCA+rTe
	v68GBaIrOWrf5Tqss6aHBtusTTJ5u/8+m2NpIVlrzaoQ0j2ko04TUwZRaK5Ub+RJmRUUHPsneYJ
	yNSi4K1YGwaRGQg9ZyXlJFHVMpsuXIuzSoNKCwvaRAaUNgVmMitPlYNv/Bdj1dg0Xk+rtWT1GcS
	NUNEZmGVLQR6hWGX3lowPIrKXOMdMRloSTw==
X-Google-Smtp-Source: AGHT+IHKu9+zp/0eKGFvQYqn0r4wTzn/xrd4ePUW9hhXKVKntaJJ+jo7UpZf7MfT/Eq3RXC78RgNoQ==
X-Received: by 2002:a5d:5d0c:0:b0:3b8:d15d:933e with SMTP id ffacd0b85a97d-3c0ed6c32e8mr883634f8f.56.1755585163039;
        Mon, 18 Aug 2025 23:32:43 -0700 (PDT)
Received: from localhost ([45.10.155.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b42a0e8dcsm27206895e9.0.2025.08.18.23.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 23:32:42 -0700 (PDT)
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
	florian.fainelli@broadcom.com,
	willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v2 0/5] net: gso: restore outer ip ids correctly
Date: Tue, 19 Aug 2025 08:32:18 +0200
Message-Id: <20250819063223.5239-1-richardbgobert@gmail.com>
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

v1 -> v2:
 - Add fou_gro_ops helper
 - Clarify why sk_family check works
 - Fix ipip packet generation in selftest

Links:
 - v1: https://lore.kernel.org/netdev/20250814114030.7683-1-richardbgobert@gmail.com/

Richard Gobert (5):
  net: gro: remove is_ipv6 from napi_gro_cb
  net: gro: only merge packets with incrementing or fixed outer ids
  net: gso: restore ids of outer ip headers correctly
  net: gro: remove unnecessary df checks
  selftests/net: test ipip packets in gro.sh

 .../networking/segmentation-offloads.rst      |  4 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  8 ++-
 drivers/net/ethernet/sfc/ef100_tx.c           | 14 +++--
 include/linux/netdevice.h                     |  9 ++-
 include/linux/skbuff.h                        |  6 +-
 include/net/gro.h                             | 32 ++++------
 net/core/dev.c                                |  7 +--
 net/ipv4/af_inet.c                            | 10 +---
 net/ipv4/fou_core.c                           | 31 +++++-----
 net/ipv4/tcp_offload.c                        |  2 +-
 net/ipv4/udp_offload.c                        |  2 -
 net/ipv6/udp_offload.c                        |  2 -
 tools/testing/selftests/net/gro.c             | 58 ++++++++++++++-----
 tools/testing/selftests/net/gro.sh            |  5 +-
 15 files changed, 107 insertions(+), 85 deletions(-)

-- 
2.36.1


