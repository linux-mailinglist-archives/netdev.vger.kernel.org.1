Return-Path: <netdev+bounces-223602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F098B59AD1
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E9C3A5ACE
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC801345745;
	Tue, 16 Sep 2025 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqQCcOZF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B451A315C
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034133; cv=none; b=Erhd9Kfnwq4wDPas5cl1y/mKlXUNgn3m/zp9uYD/Ik2rv330Uoujkjn66eo9/TO16qPRKqDK7495/ZCKDypV3ibtttSZMob78OSQl9ZzrF01VVvAfGX0Sg+mhWoFMO5sq3BYcr+IxjIs/ppdh6HqQduZ9LiefYZK5Ovfjmx9N8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034133; c=relaxed/simple;
	bh=rNXTzd8y/wZluRg6Jvfxzqflk4W6xg+4K6b4ed4H3eU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lpgd159yesBXq3I9vo9SmOiKStjPbZEEWcFmbaaVrcL0RBWnyPJEjyvHsP6nFVki9IPiFnij/M5jhAgdNH0nAG4uwliEpQS6WC84ZYHrjQQwl5Qn/H5IcuZTPKxDvZZVnXAkkKCpznWlw9MSPk/bGUI6JDSdtMijnn7yvYzZ7gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqQCcOZF; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-460e01ee031so1135625e9.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758034129; x=1758638929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gi8igtDXG6yISj4lOwkgI+AubBkRaNNUbNn455YRy4w=;
        b=lqQCcOZFyikD3mCy8LKGK/u4u51SYo67+ASJ4Kb7Az2xrYM2egccgTodONIHrWQ98E
         ZkeedAfBr0k7IRaQ6eIS2rLRiyZNPtUop6x9GSSCwqdN11dPg0hMVa7ComELoEr5yyik
         u7Gu56BmqqdhyfDoHdULH1tB07Kw6k0Gq7bbvKkxiDhjNdVPdmsGgfg5fiNPwsF4Ycxa
         8NRlZ+v5LFk9PEk6pJl+i/9ivQusziOT+SuAQEDZY4aUqN8NhevJRDZ+9nzTulnzJoaw
         /NMEq9JproZ9iMFmSUWB+4cFa6wuWAnN+BbdTiYDjTp9Xn/sOrf+IDgh/C+lJA3fPzw5
         HUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034129; x=1758638929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gi8igtDXG6yISj4lOwkgI+AubBkRaNNUbNn455YRy4w=;
        b=Df/mvlV2SViCnO8JNkoME6yajJO1CUBDN/batioqOuBMLhg03RDU1vaeyWA8Zf8vcq
         Rhl+WlYi6FJw0M70AvQE8YlvyzKGbtY5xx4vbHPA1q/KTquiOPrqNqdlHvimbqaQBvgf
         2/RSeAhf6a2UQ+h/EA+aiJsXZj0wvuytoUc5PeCqDcOSwGFZbbJv/IZzg2bPTVFAkeZV
         mb5phdpVxYISG/XZikYmf7ayTBqwO98gSADRX4GCgCW+BT7Oc+cgwtbLactNFYhR/IRm
         sMxWpIG1NOoQuZA+5QAO82EP1GXlxz3jjp2LmDrdpRZduyBnpc5qSrDiUSMmP2hIrn8a
         +aWQ==
X-Gm-Message-State: AOJu0YzIARUc4PZ905knBQ0MzcIkjtwiHrkehMJgtTxNbF5kBkno6s96
	1Fp/g5eitSpy13towEKDdyhomQSUHVTo998JV/zap+iOvuZQqL5lO8MqL0nRsg==
X-Gm-Gg: ASbGncts34jccmvAdwPWeDxqZbO5XYjLd8vfZMJUxnFS//nN1TcARJC9DyASuJc9eOs
	+4waZ5ukLVTP1O4my1DHkNh1HI+VYodjlAEcfmhnJ+oqSmDIKzmEkmKO+G/jMcBxHVlyVJbA6ji
	35ywPL7n0g9V17PrfKg7RLC9M2PylrjTZGUMvdPcINQxL8SlTjlRLGCJvITXRNkSfMRi6Zb/YTw
	B7ExbGXfwkwqwsgEqFiRhjJaqHKyrCu7U+GqhITstJ+yMglxEWp6hbQo8VYVvFn1bnvoUepd761
	tUtp9nd6ytEq0DzdtjaIMtn9IYpgmmjyE/XfAkCy1SfGv8x/DHvjFwcQF+TksunAMAiQpOfI9mX
	r+EwP7dMk2LKFiKahAaY5KnaK3aFWpWyvzfcLoh/WJpQK
X-Google-Smtp-Source: AGHT+IGT7w/chOq0xQ5oMWhmAwb9pTJAk7OU7dgxbXf0jDuUrdTnKUuAju0yoQhH6wGHRH+wmsMvRA==
X-Received: by 2002:a05:6000:250f:b0:3e7:64c8:2dba with SMTP id ffacd0b85a97d-3e765a051e9mr16033982f8f.38.1758034129317;
        Tue, 16 Sep 2025 07:48:49 -0700 (PDT)
Received: from localhost ([45.10.155.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017b3137sm232324935e9.19.2025.09.16.07.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:48:49 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	corbet@lwn.net,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	dsahern@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com,
	florian.fainelli@broadcom.com,
	alexander.duyck@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v6 0/5] net: gso: restore outer ip ids correctly
Date: Tue, 16 Sep 2025 16:48:36 +0200
Message-Id: <20250916144841.4884-1-richardbgobert@gmail.com>
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

v5 -> v6:
 - Fix typo
 - Fix formatting
 - Update comment and commit message

v4 -> v5:
 - Updated documentation and comments
 - Remove explicit inline keyword in fou_core.c
 - Fix reverse xmas tree formatting in ef100_tx.c
 - Remove added KSFT_MACHINE_SLOW check in selftest

v3 -> v4:
 - Specify that mangleid for outer ids cannot turn incrementing ids to fixed if DF is unset
 - Update segmentation-offload documentation
 - Fix setting fixed ids in ef100 TSO
 - Reformat gro_receive_network_flush again

v2 -> v3:
 - Make argument const in fou_gro_ops helper
 - Rename SKB_GSO_TCP_FIXEDID_OUTER to SKB_GSO_TCP_FIXEDID
 - Fix formatting in selftest, gro_receive_network_flush and tcp4_gro_complete

v1 -> v2:
 - Add fou_gro_ops helper
 - Clarify why sk_family check works
 - Fix ipip packet generation in selftest

Links:
 - v1: https://lore.kernel.org/netdev/20250814114030.7683-1-richardbgobert@gmail.com/
 - v2: https://lore.kernel.org/netdev/20250819063223.5239-1-richardbgobert@gmail.com/
 - v3: https://lore.kernel.org/netdev/20250821073047.2091-1-richardbgobert@gmail.com/
 - v4: https://lore.kernel.org/netdev/20250901113826.6508-1-richardbgobert@gmail.com/
 - v5: https://lore.kernel.org/netdev/20250915113933.3293-1-richardbgobert@gmail.com/

Richard Gobert (5):
  net: gro: remove is_ipv6 from napi_gro_cb
  net: gro: only merge packets with incrementing or fixed outer ids
  net: gso: restore ids of outer ip headers correctly
  net: gro: remove unnecessary df checks
  selftests/net: test ipip packets in gro.sh

 .../networking/segmentation-offloads.rst      | 22 ++++---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  8 ++-
 drivers/net/ethernet/sfc/ef100_tx.c           | 17 ++++--
 include/linux/netdevice.h                     |  9 ++-
 include/linux/skbuff.h                        |  8 ++-
 include/net/gro.h                             | 32 ++++------
 net/core/dev.c                                |  8 ++-
 net/ipv4/af_inet.c                            | 10 +---
 net/ipv4/fou_core.c                           | 32 +++++-----
 net/ipv4/udp_offload.c                        |  2 -
 net/ipv6/udp_offload.c                        |  2 -
 tools/testing/selftests/net/gro.c             | 58 ++++++++++++++-----
 tools/testing/selftests/net/gro.sh            |  2 +-
 13 files changed, 126 insertions(+), 84 deletions(-)

-- 
2.36.1


