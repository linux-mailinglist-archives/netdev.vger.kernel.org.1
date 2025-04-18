Return-Path: <netdev+bounces-184018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71FCA92F55
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 03:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2583A3C8D
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 01:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2A51DB124;
	Fri, 18 Apr 2025 01:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="KBwZwn04"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A2D1C3BE0
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 01:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744940265; cv=none; b=FCLRT1pusjF7P/73ytJPX+yUnOilsBESkBD7e2atQjZfvf74oqENIeSsFqHTZwG0uhVbsSQzmXnm90YG0xP9yPJSPz7xnQYH3sdVLcrYSTDb4wk65abjUurc0p3SG5D92jFL+Gns/TyZlr7VbNmxBvUBJn3dW1cSEcTPWx6gkGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744940265; c=relaxed/simple;
	bh=83ine0mrSdz+4LSvDN5s7gcTAppP0Ss3rM2gY/WezSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dJ8ed4XQPg6ONv9OU9/ND4KugoqaB8JlmSBxO2SG79x9LeHa2yNwmcENP3/zuEYV6phDO4sETHJq1ZO8xF0H/Da8s5RXXN8LDy6ArCnKRdzk3xcTcvWSUElnYRER6utuROa5zOzrdfaIR/kpy5i3nDAMkQUKmwkmqxcukcEaGVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=KBwZwn04; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-af19b9f4c8cso908392a12.2
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 18:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744940262; x=1745545062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7I8NgF9RlR8FwCsr9V1VCpYsrKioxWgjmoDan09dvi8=;
        b=KBwZwn04q/Az4CTzRDbtKoSU00TO9Z/xrWcUsw7FM+2ozNDJiRe3Ps777sLenVxfv0
         Hs+fzwD/qoGgS/vO0s0GfFXJqE/JEl3pNsiPxu0NViu5v6gqgmhkb+VfggCFol6FVNDP
         np2CMOiGNp+thzOhK4wZrb/c+aflqjbvFCrWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744940262; x=1745545062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7I8NgF9RlR8FwCsr9V1VCpYsrKioxWgjmoDan09dvi8=;
        b=uBQUNdJlPaPtOLoIDGiGXX3XHo+y5uZD6ZGN9vfp55nKqWc6KkdmKZJK6NZFh75ohH
         +LgEk1wOhDt8kqiOMKm9/rZo7nEdGrR2cIf0Zv4J/dRKVnSKEKuhd7zrL4GAJ/fEFx0u
         U/JtS381kbot68d7ykwzqhZnkjEK2G/KXMuA93m/rqMt4GMEFGoewfvyiI+GhxzxPHhx
         jmA/8Vp3QqvH2mgba9yVhsZpbv7JXFPfFjKQXY/xaQk/bKalMOqC5rF2nJfvPb7IpQ5G
         oZGeOv/WgbwzmTBg+AXgwYOSqKTm49Kl7YWTgncQH7v0jLOeacVeOdAv/ouwv+K/psgh
         Pnsw==
X-Gm-Message-State: AOJu0YzDOcf9eX69XMFvnPCfH1gYQH6uG7GW5NyO95udhGY6Cf3lnR9b
	V+NngFnJHbyrVYSCx4kEZjnb8sZbyjSGb00ZHtgzJhRuhVlO4cGsFdHMkOaUYiWq0BFhkhpNhPL
	Tu8hu6d+RIYn4nH+qroUZ5kfdWMWvOts0liWGDuBiz8fuomoXpkFNxz9Q5EXCsC2novOSGTRrwo
	s7QOWMuJpyijc5yuAsGekNa/xFu/WiO4nxV7g=
X-Gm-Gg: ASbGnctebYk+fTovbK+AIfwo688CsnlF0o1CEYTikoNvrxp8nf26oWPriopIy3Gjqjz
	gbuWzFTlU8yc/3TuQMbMgnGbZkAreFHuK80EnHItE7bXn1q2Bxqt5ZiUvETCYevqhhZ20Vfv9+p
	gCaZNvYMrDUTAzbVEbXaj+h9OHBYwqCe6rKL6WZwvbi39CxSnZqZVBBxbtD8Q3WFk7zfnR3+OK8
	cNWFm1GlfXvlf+H9QYLxFV4nqb5vOaGYkN6Wv7WyrrSwF5P1hicUzIYrTwlytVUjYoUrr2LlOHb
	E69lhJjEsSsUh0tCbejIGux3guQDanuNPY7b06iQ+DxoSDYE
X-Google-Smtp-Source: AGHT+IE6KmDOqTadvPBOoP6NCbep8sj/+WD00V+zMFXa6ok1PnWjm2kVgaHVjOv1izpghACtKB8Bjw==
X-Received: by 2002:a17:90b:568b:b0:2ef:67c2:4030 with SMTP id 98e67ed59e1d1-3087bbc4d52mr1273243a91.27.1744940261993;
        Thu, 17 Apr 2025 18:37:41 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087df21278sm131772a91.29.2025.04.17.18.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 18:37:41 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	shaw.leon@gmail.com,
	Joe Damato <jdamato@fastly.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net-next v3 0/3] Fix netdevim to correctly mark NAPI IDs
Date: Fri, 18 Apr 2025 01:37:02 +0000
Message-ID: <20250418013719.12094-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v3.

This series fixes netdevsim to correctly set the NAPI ID on the skb.
This is helpful for writing tests around features that use
SO_INCOMING_NAPI_ID.

In addition to the netdevsim fix in patch 1, patches 2 & 3 do some self
test refactoring and add a test for NAPI IDs. The test itself (patch 4)
introduces a C helper because apparently python doesn't have
socket.SO_INCOMING_NAPI_ID.

Thanks,
Joe

v3:
  - Dropped patch 3 from v2 as it is no longer necessary.
  - Patch 3 from this series (which was patch 4 in the v2)
    - Sorted .gitignore alphabetically
    - added cfg.remote_deploy so the test supports real remote machines
    - Dropped the NetNSEnter as it is unnecessary
    - Fixed a string interpolation issue that Paolo hit with his Python
      version

v2: https://lore.kernel.org/netdev/20250417013301.39228-1-jdamato@fastly.com/
  - No longer an RFC
  - Minor whitespace change in patch 1 (no functional change).
  - Patches 2-4 new in v2

rfcv1: https://lore.kernel.org/netdev/20250329000030.39543-1-jdamato@fastly.com/

Joe Damato (3):
  netdevsim: Mark NAPI ID on skb in nsim_rcv
  selftests: drv-net: Factor out ksft C helpers
  selftests: drv-net: Test that NAPI ID is non-zero

 drivers/net/netdevsim/netdev.c                |  2 +
 .../testing/selftests/drivers/net/.gitignore  |  1 +
 tools/testing/selftests/drivers/net/Makefile  |  6 +-
 tools/testing/selftests/drivers/net/ksft.h    | 56 +++++++++++++
 .../testing/selftests/drivers/net/napi_id.py  | 24 ++++++
 .../selftests/drivers/net/napi_id_helper.c    | 83 +++++++++++++++++++
 .../selftests/drivers/net/xdp_helper.c        | 49 +----------
 7 files changed, 173 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/ksft.h
 create mode 100755 tools/testing/selftests/drivers/net/napi_id.py
 create mode 100644 tools/testing/selftests/drivers/net/napi_id_helper.c


base-commit: 22ab6b9467c1822291a1175a0eb825b7ec057ef9
-- 
2.43.0


