Return-Path: <netdev+bounces-223012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792C8B578A1
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 13:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DBE53A89F9
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 11:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702D42FD7D7;
	Mon, 15 Sep 2025 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3syTQ+Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FE827FD7C
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 11:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936437; cv=none; b=TMeGr/fi53C6+dJSdYGhwL2q/urVr9Y6H+jyDCoMI1UiU1wUrFGTGLWdi8fKDh/iXJ6G2KSKGhgksL6kn1RXuS9HWqR8F+B+q0yI0MogQmUEK8+q6DK0q541yGIT/sTEOPBinMWjMyetsQZrwheevXx+3eWYd7pUW3qpDBUHa4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936437; c=relaxed/simple;
	bh=/L5pK6At8TaftbFwB3g4823q/dFzbzHKMONbQ3wFx5s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W4h8Ss7yIgYTCHq9l/YkbCBD+X0zKNF2XaWnAnn0i5ErMITBEHXB0IG5ZWjxtMlwqYz75n9TTCEw1MlwQLRbsAozZT6Kmp5WmagHkhHkuyBI2361nsVvuQhcFVaUBpU/9AL4hCMWjmn/Cpkrrk2efvNyNlPVy5W+kOAXtYm6cPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3syTQ+Z; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45f29e5e89bso17689385e9.2
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 04:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757936434; x=1758541234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vrG2SO6pmAXHbgkFVtjT3CbucUptg/RlTro+DaNuLtw=;
        b=Y3syTQ+ZMiW1ESYRY2YZQYqpqRoQWp964NlX4VwBb6DVNV3O7M375FIvAbDVvxOfQz
         GEAZWrwDbFa5FELFeXVkwSqtrxLc9FCa/aPCYHDmv9SHc0Che4lpMrRFmWRIad6j2s9h
         j7UWz8QU02e50yXC8HWK+icpxp/j5sHlMAutxUoeWIjj5bZOgy1UvO3pWAG25t7xeesb
         Ly/O+swAh9Hd0yS1hkXq0fUS80rD7jhwEa+eyjQesoP+Msk9FmLM5fSXNCX32akI560b
         9nMXXN1tY5zX28jFH8eUQwuBKMcJNMND2MzfWi19Hr/MU9MRtJ3gDe10os7s5rpdVqCR
         aJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757936434; x=1758541234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vrG2SO6pmAXHbgkFVtjT3CbucUptg/RlTro+DaNuLtw=;
        b=K+fj3/FN4corQ3Kva9QPA31olYXvLlyIY1U8SUHq8o/Cj89tKvlIvaKs0WSVGOopND
         2yM1zQVfbdpThkB9V9QWRK9CYwq4S9+PfbaMFNCHx3YXLYxT/PTh4//utJ0SFsJp6Gzm
         LUnYVENUS1cS0zxrtmJHdal9HaQI0uSfJmnKzXYgejMgs+Ptcp80WRcVsclKSGMWQAi5
         zyxUdXD4vpnRsiBIA7XlUQhhXquFSOuopcJA8jzrHfZuCVujPAY/DYqZ/c5wdspH22pE
         6cIhMuxNSgH7CC2GfssX+N75W124bP7auFkqYc0ju1lv+pfPF1Fa5CqV5tDS8dJQtFVS
         qiYg==
X-Gm-Message-State: AOJu0Yz246o/6LU8uv6xobkqhzNEv/B9TmKlO/idT7sAcD//aKXgmFek
	F8wvCp6mazh8agsWwk1V55IOH36EqVrPiOQ4YfiM/q32bauCsbBgu1/OBwqTzw==
X-Gm-Gg: ASbGncsoXIjoDIlsOESxUCmfdCCU0ofiYP0JoNFuQWEzgkcj12yLSymVmY1cmfwOMk9
	Xxsz5ihH3lvZSzWoIwvHc+lXVce8rw2uJe5OynkPmJpDJ1Fkt0huuAXqzCByKpt6ZcedNpyBgXF
	NSQEfTm3dNBbJ7JpXwVz/eME6t75uaqNmi2plM7KSdf1CG9ZGaJFDYvsZG+iRQ7TpHB1ECxwY1C
	QeimkTb7xd9KiOkIBSS3iUEBg7gO0aG8D2U4+5O3J/sBFybiykk9tm0Lc9g591xY1wVfm40cjaP
	O3PzHw5jHbQ/WGqmi3+8OBrr31B+E1qtmKP+3gxcnHVQczJHzk3nuyPkPzeD8qa5JVUMqaOX+DG
	/jSgnC4f9QdO5AwpJ9/HvjJbYJNbB0W8KaQ==
X-Google-Smtp-Source: AGHT+IHqhRVmb9rUlNe+hbUT+gBfrb4voHkQ0nYPxh/42JY+Y65ULBdzDmr0KGWe3Va52LI5AQbA2w==
X-Received: by 2002:a05:600c:4ed2:b0:45d:e285:c4ec with SMTP id 5b1f17b1804b1-45f2c410b5emr37850645e9.4.1757936433527;
        Mon, 15 Sep 2025 04:40:33 -0700 (PDT)
Received: from localhost ([45.10.155.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e01578272sm187063335e9.9.2025.09.15.04.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 04:40:33 -0700 (PDT)
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
Subject: [PATCH net-next v5 0/5] net: gso: restore outer ip ids correctly
Date: Mon, 15 Sep 2025 13:39:28 +0200
Message-Id: <20250915113933.3293-1-richardbgobert@gmail.com>
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
 include/linux/skbuff.h                        |  9 ++-
 include/net/gro.h                             | 33 +++++------
 net/core/dev.c                                |  5 +-
 net/ipv4/af_inet.c                            | 10 +---
 net/ipv4/fou_core.c                           | 32 +++++-----
 net/ipv4/udp_offload.c                        |  2 -
 net/ipv6/udp_offload.c                        |  2 -
 tools/testing/selftests/net/gro.c             | 58 ++++++++++++++-----
 tools/testing/selftests/net/gro.sh            |  2 +-
 13 files changed, 126 insertions(+), 83 deletions(-)

-- 
2.36.1


