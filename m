Return-Path: <netdev+bounces-84711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 620A4898218
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 09:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5D8286EEF
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 07:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56ADF1CFB9;
	Thu,  4 Apr 2024 07:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPNyEkri"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E472457308;
	Thu,  4 Apr 2024 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215265; cv=none; b=ffkFnzIcO6mOj6+ewGPI8mIEMgHRGcbuIhHZxiIJyxzpoutxIHkCONLDDjI1RZAXVwpBoIA3vYVPvvSGcJnSSq0khmn42XcCLMXh8GBItCkg2osVVOxRCoK/lVtqqcBE09zErkTRACP3XLuJNLiqhJq2hbmiAcLjYO25MhTn1SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215265; c=relaxed/simple;
	bh=bS2zUaRfTRngCpa6lT7u2GS1mxMYCc/jRy3dQP9i9QY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kNABBAkIi3hQfWGR+mJECv2X5xB9ADH1322k1eovcD/4/sn8fuhZ0Sisdi+1WfF/oWsO96JIw/b+ZdijXBllVWrRSVnE33LU/tZSNRHRv2O37NmlRHZ+tUsX/4yn5Upkwye4U65OIKqy8iOA3LVzvu2v8gwpxuhUnB1ijAvPRvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPNyEkri; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e0fa980d55so4821295ad.3;
        Thu, 04 Apr 2024 00:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712215263; x=1712820063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P23QQ7cM+n1GuwzWV0zi1THXETPvgkpLzdRS02BkbFM=;
        b=DPNyEkri4Xt/MT/WWxlPkD4j7YDrvWPHqDDXcyQQowrbdIYmS/HTN361dGqKupmqxJ
         VgxtKCXS8P8qz3YPbtnJB6hw+WrFNzjUU5n4PrjPEMgRaYSaYlQ6WPqxIcPOz1WWb4eN
         3RJg0vofDTuX2yWVOydl3FxZFeuYs4KUiDCJU4N8WecSuRtu1WKt2THMx0DJ4CD/5SH0
         IvvkKU8hh2AD+YI8ihjs4rJvmBDNP48YIFcucUcAqwE1I1qOzuePoSKS7zxVb894pl4Q
         lLp8hgHEfvmCc8NXq6OHMYvWifCxvCSWAWAHpx8o7uB6hUIPTyhtql5aABOXAtB1p450
         nq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712215263; x=1712820063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P23QQ7cM+n1GuwzWV0zi1THXETPvgkpLzdRS02BkbFM=;
        b=rqR7jOBBWEUNQ4QHRCCgdAUIQnKVOXXebfO0AoefSpuX3QAGm+f3KYrGhxLZBlT5V6
         BuCUkBqCPt3CYQVtUJV1oUHtzY6BLXZVp/92fwlpaV3kNMeXIXIAy4k7z1V2MBc2y49u
         0l0WTaP354NgC0aC26ZzpBX76UZwKDCYUOtHwR9UIrjQDFCkYc+HsOZMktGV/Fr4R8I/
         x2P4fLKSMJ+HcE/bE/tENDOFtMBA3EbMVRqap7ynATwpTYk/WXJsqhiT/na1uRl9Cs8J
         d3Xl7ZfC8wNXTtEDEJ2aeDSeJzWKmpkiLYf0lS8BEYRYz9tpQIVwKy6eka058C16R4tc
         cZaA==
X-Forwarded-Encrypted: i=1; AJvYcCXNc813lrrMFhM8gIjXQswbowO5nwQyGB95m3AztNs5jdkh/i4a+BdD0ku5xIAZ+Vwbff7Y+JmgS9aofpnxcHelDMC1UUVXSbmd2Au3Yq/CWmw7mPgqvFf4PW12HGTh4paBgoQZ1FSxrfAa
X-Gm-Message-State: AOJu0Yx8cIl9hPql7XGG6dw53bC1rnGTrmsfGn2zl29GY5aVQny3abRf
	Dx3EyRDK9sRKpmWUZEef6nvP+yDttQEAJaDHOpUDYVJnDvyWjTjd
X-Google-Smtp-Source: AGHT+IE1ue1dKzRgFAhN0ulqPUkC+kC5R4oawWdu+topbNZgL9btF7YGFh21dE6Fm/01R9LURLAINA==
X-Received: by 2002:a17:903:22c4:b0:1e2:9d65:2534 with SMTP id y4-20020a17090322c400b001e29d652534mr1523352plg.42.1712215263038;
        Thu, 04 Apr 2024 00:21:03 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.7])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709029a8200b001db5b39635dsm14606399plp.277.2024.04.04.00.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 00:21:02 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	rostedt@goodmis.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/6] Implement reset reason mechanism to detect
Date: Thu,  4 Apr 2024 15:20:41 +0800
Message-Id: <20240404072047.11490-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In production, there are so many cases about why the RST skb is sent but
we don't have a very convenient/fast method to detect the exact underlying
reasons.

RST is implemented in two kinds: passive kind (like tcp_v4_send_reset())
and active kind (like tcp_send_active_reset()). The former can be traced
carefully 1) in TCP, with the help of drop reasons, which is based on
Eric's idea[1], 2) in MPTCP, with the help of reset options defined in
RFC 8684. The latter is relatively independent, which should be
implemented on our own.

In this series, I focus on the fundamental implement mostly about how
the rstreason mechnism and the detailed passive part works as an
example, not including the active reset part. In future, we can go
further and refine those NOT_SPECIFIED reasons.

Here are some examples when tracing:
<idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=x
        skaddr=x src=x dest=x state=x reason=NOT_SPECIFIED
<idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=x
        skaddr=x src=x dest=x state=x reason=NO_SOCKET

[1]
Link: https://lore.kernel.org/all/CANn89iJw8x-LqgsWOeJQQvgVg6DnL5aBRLi10QN2WBdr+X4k=w@mail.gmail.com/

v2
Link: https://lore.kernel.org/all/20240403185033.47ebc6a9@kernel.org/
1. rebase against the latest net-next tree

Jason Xing (6):
  net: introduce rstreason to detect why the RST is sent
  rstreason: prepare for passive reset
  rstreason: prepare for active reset
  tcp: support rstreason for passive reset
  mptcp: support rstreason for passive reset
  rstreason: make it work in trace world

 include/net/request_sock.h |  3 +-
 include/net/rstreason.h    | 93 ++++++++++++++++++++++++++++++++++++++
 include/net/tcp.h          |  2 +-
 include/trace/events/tcp.h | 37 +++++++++++++--
 net/dccp/ipv4.c            | 10 ++--
 net/dccp/ipv6.c            | 10 ++--
 net/dccp/minisocks.c       |  3 +-
 net/ipv4/tcp.c             | 15 ++++--
 net/ipv4/tcp_ipv4.c        | 14 +++---
 net/ipv4/tcp_minisocks.c   |  3 +-
 net/ipv4/tcp_output.c      |  4 +-
 net/ipv4/tcp_timer.c       |  9 ++--
 net/ipv6/tcp_ipv6.c        | 17 ++++---
 net/mptcp/protocol.c       |  4 +-
 net/mptcp/subflow.c        | 33 ++++++++++----
 15 files changed, 209 insertions(+), 48 deletions(-)
 create mode 100644 include/net/rstreason.h

-- 
2.37.3


