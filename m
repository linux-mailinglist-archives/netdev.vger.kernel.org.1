Return-Path: <netdev+bounces-212903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36287B22770
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 14:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07FC27B62A1
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37349279347;
	Tue, 12 Aug 2025 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LegAkMtk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4EF275AF9;
	Tue, 12 Aug 2025 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003150; cv=none; b=b7gWGU7KbrIuBT14INvKvYua/BDqNC24PYCnI8cdUPcujVKcXNNimIHgfvsJCah66Ue3f+I/FQDqDaBvAhFhHFTBWJhq4dZwj8s1qOAHqsB1NyMFbQL/oNeA+f+/9a4uzsy3ZF50X3Oga6YkWsKWrLbpG1sxWu7M4XWIq7otL2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003150; c=relaxed/simple;
	bh=KVBK6hFvK1FY7u2Ma5CCjrgqrBhs+p6LJR/g3yxritY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=czA8PqzY7zMFQkLWCUoUCMRAS2cvMkvsCglGl72ccY2+Psr1TZ0nZup2jdP0l/Qkk++TVZfF3EthchqmIgZYrEa+6lq905/l8e65DpJxHSAZr/DSQnWqZvsgy3bQT3CUavkusRacfPtz/p8Nni4laqwYctQVs4c0bX0rVTb8lQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LegAkMtk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a11f20e03so5222065e9.2;
        Tue, 12 Aug 2025 05:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755003147; x=1755607947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XOysFTmDeKPqaIvm8qxt1S6RVmsmgHTr+dtBSiMbDRw=;
        b=LegAkMtkE0mxOxugbwBzou2i751MQMM2Nf9IVXmPs9vCilqGs9RzkP4uhOnIdaT5Ih
         jKaEM207jn6/s0956puPsBe3HHyoA6xAUKdEAgyEojQ8q/X/iWU3Kq3ExENazmqqqUK5
         exh4mrrmYzkOdn5SIJKZzlasey48VSg2i49WkVdybYO4slrFrXBbwFlvTCTNmXF0hOTK
         F4jcmpZqFE3tATvqI+QWhRNhRneZou+T/tbYkvZRSxiDZV0041JUJvKKuM6Tm+l6hF7l
         qGVQO0O+w8qNF5PzHcC4DxkejwsMBQ30ypSsYBGxAJl3WjVxV5sTJ1m86XOZDFL2WjGF
         D3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755003147; x=1755607947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOysFTmDeKPqaIvm8qxt1S6RVmsmgHTr+dtBSiMbDRw=;
        b=OPd93zazGw78XQ1srlVTVA35yr4PJiwlrkk462x79EaOnmYeyRrC7AxQYNicmCX5JD
         3UWRUtsgbfTAeDyk3ju+2CG5ekLGM5nyadCkHoXR7uPB4Rx1b2/8GS9sOq59bQ0MJMPj
         E1llOKEtfYbky2XcH4HlbLnfXD2SBUz/r4I2ke90OxTA/u7B7VH6gAvRzPUZXOjVQoQZ
         nXRK0/zqLiILGjgHqNRaUkDp+8fmVCQa9HY65EkdASPMzEFOF+rVykoU4/z/F12GAdkY
         iDq+jEKJGuPx/CR30u3Lvav1QFosxrisXfXmoXANys21ODD+FsTP6KWn+LvzFU1ECLIx
         DM5g==
X-Forwarded-Encrypted: i=1; AJvYcCUIa4W7NbXSPNPssQB0ruONK871gueZWP8uFT2UGdjEm4/44V58ykqAl+mivKen760/HyXxiFlrP+YflLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD+7B38Jexm18/wKYyV4vzjlv2TXyXUvZh3RQLu+8AP2ZQl4m2
	viD3pbJKgA8aWAgqtKn0TY7gXt3G97FFW4N8nKxbBO4fBRfr1mnPXuuvHYJWeCPcaDnW2Q==
X-Gm-Gg: ASbGncu2H2qwCZE+XCW2rtH+8fDsiDMCHnaUiFYbfb69v8/8lt7n7ANzvzLGv5UQWME
	ih9sFSiroQ+CmA972nkQs7aJ75xWT7C/U5pbek1sGrvSdgYsO95B/zlBkR2cowkfPnSvaTciWJt
	+eLWdyc28Y0NizEl/i/kw30IK/e5EOHvnIeXYvMF07cd8ZhR2HC1jy63Jc442GvSGjJsVCw+e7Z
	c6FkXctwzt9TgrYk4DfUE2mB/C0ZFR+d7LwKoXRufTw2Si15nFXktSU9yDpTeON8z4LnHC/opIj
	fIDknTmXBzRFhZ+KVa7a1X1p5CphTyACNtthxWOBh7tZ7hBK23+dOPR3CUZp/c0fgnindUPQW7d
	ff5Wv/jm2Xv75WyLeZQW/2pkUFV0XgNhfy1QgV4GlM33w
X-Google-Smtp-Source: AGHT+IHambSLcIwjd4Pof98E6EGZfRkNzEIbNQj+mxtntYAQiGMw/fG734bFYM0l5/M/qMtlNQOl4Q==
X-Received: by 2002:a05:600c:1d16:b0:459:e025:8c40 with SMTP id 5b1f17b1804b1-45a10ba05bbmr37664535e9.10.1755003146299;
        Tue, 12 Aug 2025 05:52:26 -0700 (PDT)
Received: from localhost ([45.10.155.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c485444sm44730050f8f.66.2025.08.12.05.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:52:25 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	andrew+netdev@lunn.ch,
	dsahern@kernel.org,
	shuah@kernel.org,
	daniel@iogearbox.net,
	jacob.e.keller@intel.com,
	razor@blackwall.org,
	idosch@nvidia.com,
	petrm@nvidia.com,
	menglong8.dong@gmail.com,
	martin.lau@kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v5 0/5] net: add local address bind support to vxlan and geneve
Date: Tue, 12 Aug 2025 14:51:50 +0200
Message-Id: <20250812125155.3808-1-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, vxlan sockets are always bound to 0.0.0.0. For security, it is
better to bind to the specific interface on which traffic is expected.

This series adds a netlink option that makes vxlan sockets bind to their
local addresses. The option is disabled by default as it can potentially
break existing network.

This series also adds a local address option to geneve, similar to vxlan.
The geneve socket is bound to the local address by default.

v4 -> v5:
  - Fix whitespace issues
  - Fix IPv6 compilation errors
  - Add missing documentation
  - Add selftest to test localbind functionality
  - Change localbind option in VXLAN to be non-default
  - v4: https://lore.kernel.org/netdev/20250717115412.11424-1-richardbgobert@gmail.com/

v3 -> v4:
  - Fix a problem where vxlan socket is bound before its outgoing interface is up
  - v3: https://lore.kernel.org/netdev/20240711131411.10439-1-richardbgobert@gmail.com/

v2 -> v3:
  - Fix typo and nit problem (Simon)
  - v2: https://lore.kernel.org/netdev/20240708111103.9742-1-richardbgobert@gmail.com/

v1 -> v2:
  - Change runtime checking of CONFIG_IPV6 to compile time in geneve
  - Change {geneve,vxlan}_find_sock to check listening address
  - Fix incorrect usage of IFLA_VXLAN_LOCAL6 in geneve
  - Use NLA_POLICY_EXACT_LEN instead of changing strict_start_type in geneve
  - v1: https://lore.kernel.org/netdev/df300a49-7811-4126-a56a-a77100c8841b@gmail.com/

Richard Gobert (5):
  net: udp: add freebind option to udp_sock_create
  net: vxlan: add netlink option to bind vxlan sockets to local
    addresses
  net: vxlan: bind vxlan sockets to their local address if configured
  net: geneve: enable binding geneve sockets to local addresses
  selftests/net: add vxlan localbind selftest

 Documentation/netlink/specs/rt-link.yaml      |   8 +
 drivers/net/geneve.c                          |  80 ++++-
 drivers/net/vxlan/vxlan_core.c                | 102 +++++-
 include/net/geneve.h                          |   6 +
 include/net/udp_tunnel.h                      |   3 +-
 include/net/vxlan.h                           |   1 +
 include/uapi/linux/if_link.h                  |   3 +
 net/ipv4/udp_tunnel_core.c                    |   1 +
 net/ipv6/ip6_udp_tunnel.c                     |   1 +
 tools/include/uapi/linux/if_link.h            |   3 +
 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/test_vxlan_localbind.sh     | 306 ++++++++++++++++++
 12 files changed, 490 insertions(+), 25 deletions(-)
 create mode 100755 tools/testing/selftests/net/test_vxlan_localbind.sh

-- 
2.36.1


