Return-Path: <netdev+bounces-207432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BE0B07353
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 12:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216C21C2364A
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 10:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE042F3C02;
	Wed, 16 Jul 2025 10:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJjKu42/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB402F3655;
	Wed, 16 Jul 2025 10:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661699; cv=none; b=TyVIcwU9ZPo4nTWqpleFk3LwICtOx2LCPuaQ0kDvR4kk5nPq6sVv0BArlSPXOYKKig/2RPmklLkqP1tLmBZFp+jLM0Pjdm5uYrL5rf/WR0p6ZkP2zbFxCPH7A6a0rFP2QF0dxigDr9n1kjGvWK3SSpy2FO+BzizczTHbuDnEbi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661699; c=relaxed/simple;
	bh=oDfuvhrmXua+Hqf3Lf8EHO9qQZS5NUpc586xNfXqu9o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F5G2xm1X/GCCCtWd/ra3Yb+Kv0YiKUO8uaxoaGnLGeZrrfnJgo7MwXVRhEQ+ttdg98hN/J6uBxsBHkrRK8/hDlA+/szFwnWeVnxoq1AQOlJgVJ3aiI6+DkPxBANMpnRzStzlWh/HDV4ZVuLGfLu+ahHk7MT4gnHvVy35hY8v2SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJjKu42/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7620DC4CEF6;
	Wed, 16 Jul 2025 10:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752661699;
	bh=oDfuvhrmXua+Hqf3Lf8EHO9qQZS5NUpc586xNfXqu9o=;
	h=From:Subject:Date:To:Cc:From;
	b=GJjKu42/YUdAaWaaXN0wSgm8Ie7P1Afdw5nTlruwuY/KrQtyXtmKCLCod8gRF6tV9
	 wG9mvgd7aH4gSnxcijMkFtvms9X3yTu2SdMp2wZuLHu4x2Bnno/Ru6mFvFnxx53wem
	 lyaIS7by1dFLS8rWf0xjAl6iKAnE2MmF1wdcPYZr5RFnLrMhfKkHmzcqX/St0aIHup
	 KBL0yyDIoLyPl5EGaHBXxB/NdHh7BeSt2U+teK4BCwgkzbxWcQYF0ddlU45EP4G0Ka
	 GlRla4nStBZpUdGsir+M+MCtmY+M8BgYlNXJFTfxVpYAOOob3NCRz1JI55P2cDjCZm
	 fQAiawOaMBp8A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/4] mptcp: add TCP_MAXSEG sockopt support
Date: Wed, 16 Jul 2025 12:28:02 +0200
Message-Id: <20250716-net-next-mptcp-tcp_maxseg-v1-0-548d3a5666f6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALJ+d2gC/zWMQQqDMBAAvyJ7dmETqEn7lSJFdJvuwTQkQQLi3
 10ED3OYw8wOhbNwgVe3Q+ZNivyjiuk7mH9TDIyyqIMl+yBnBoxclVZxTXVOqHzWqRUOyM6R9U9
 DnhbQPmX+Srveb7gzGI/jBJdnTAp1AAAA
X-Change-ID: 20250716-net-next-mptcp-tcp_maxseg-e7702891080d
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 moyuanhao <moyuanhao3676@163.com>, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1327; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=oDfuvhrmXua+Hqf3Lf8EHO9qQZS5NUpc586xNfXqu9o=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLK6/bytpgtnFmeFnkm+siCoEid3/q2h8SX7P/mefnXh
 nMvfto6dJSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzkwEtGhp8S0ftDv4TIiCxr
 nBN/2uMc21n+f5veT++0z13NfyZx6gZGhol7WWannumuVq5gn/1ktsY8jtOuG6vC9q/J1Eo47KV
 mxwQA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The TCP_MAXSEG socket option was not supported by MPTCP, mainly because
it has never been requested before. But there are still valid use-cases,
e.g. with HAProxy.

- Patch 1 is a small cleanup patch in the MPTCP sockopt file.

- Patch 2 expose some code from TCP, to avoid duplicating it in MPTCP.

- Patch 3 adds TCP_MAXSEG sockopt support in MPTCP.

- Patch 4 is not related to the others, it fixes a typo in a comment.

Note that the new TCP_MAXSEG sockopt support has been validated by a new
packetdrill script on the MPTCP CI:

  https://github.com/multipath-tcp/packetdrill/pull/161

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (3):
      mptcp: sockopt: drop redundant tcp_getsockopt
      tcp: add tcp_sock_set_maxseg
      mptcp: add TCP_MAXSEG sockopt support

moyuanhao (1):
      mptcp: fix typo in a comment

 include/linux/tcp.h  |  1 +
 net/ipv4/tcp.c       | 23 ++++++++++++++---------
 net/mptcp/protocol.c |  2 +-
 net/mptcp/protocol.h |  1 +
 net/mptcp/sockopt.c  | 33 +++++++++++++++++++++++++++++----
 5 files changed, 46 insertions(+), 14 deletions(-)
---
base-commit: c3886ccaadf8fdc2c91bfbdcdca36ccdc6ef8f70
change-id: 20250716-net-next-mptcp-tcp_maxseg-e7702891080d

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


