Return-Path: <netdev+bounces-126682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42EC972349
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 22:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68B11C234BB
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 20:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B86189916;
	Mon,  9 Sep 2024 20:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaidQYDS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4F7188CAF;
	Mon,  9 Sep 2024 20:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725912597; cv=none; b=OQjKENHrRowx8yVyG0SzdhaJehz9X+DWduBDO+8QKXjQPL8oOa37MNfJ4EI/y6bX/uupZpNyp2zk1jKp0Cm2B7MwZJ2+LbI8gOC6CmDrTOVAsrrZC2nEH68fOjmNmrj6soEUCWWj08t++FYPvUhG70Qnm/eA3inS/wWqL8Q/SOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725912597; c=relaxed/simple;
	bh=dgEMI3wGf4QoZWLUf+u2E3CCQEsBsqk1dmls2e6pdGk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A/hpemzCuHZV64FIhhhOjkM6KOUQKPL8rx7AGlX3TKZ4ZeblRkjstflxEM6H7Y4n7VUTnazHY1SsvPVv6lLuvrXhD9pmBlY/YYQZJTxRvT+60ap0pYKoa2bCF9n7mD6bACaxk6FA+fcdCTT4Kknx32TQPlXWSQbOGEviBut/d5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaidQYDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6148AC4CEC5;
	Mon,  9 Sep 2024 20:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725912597;
	bh=dgEMI3wGf4QoZWLUf+u2E3CCQEsBsqk1dmls2e6pdGk=;
	h=From:Subject:Date:To:Cc:From;
	b=QaidQYDStABvEz91IKdOY4uT1baJ83j/AI5oe763X/6ZdiiweP/Zn9zu5sO6+RRFb
	 8GPRZlyITkpHupRBD51GTJBf+NzZfLSDmxpWAMtevT5yl/nnEy56/RqFhOcwpKj5Ef
	 HTUQ7xaw/AqARU2BI2JoSYObtDqgFgKHHFhyX9rrcvpO38B8KjmiIl7hLtviWCo3uX
	 CAJUZSGX7+48VXRfszLGZ7prQyK9BzXP+FyGLdBGoc41yT4QujFf7V5ePNdEWIcf16
	 t4FAI1f3s1h1Uuu8WSi4YPDrCzSvKukC+Y9fZTGKUvDGRXyTsUfm/t/6qGQxeKyhe4
	 9OyWJ4p6Msj1Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/3] mptcp: fallback to TCP after 3 MPC drop +
 cache
Date: Mon, 09 Sep 2024 22:09:20 +0200
Message-Id: <20240909-net-next-mptcp-fallback-x-mpc-v1-0-da7ebb4cd2a3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPBV32YC/zWMQQqDMBBFryKz7sA0FTS9SukippM6qGlIQgmId
 +8gdPEX78N7OxTOwgXu3Q6Zv1LkExWulw787OKbUV7KYMj0ZMli5KprFbdUfcLg1nVyfsGmh0c
 aaDBhNLdgJ9BGyhyknf0H/FV4HscPltUUt3kAAAA=
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1708; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=dgEMI3wGf4QoZWLUf+u2E3CCQEsBsqk1dmls2e6pdGk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm31YP5itjq7vsuUpGMUuDXA8grh7Q9pjSGINKJ
 YCw5pbFHkqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZt9WDwAKCRD2t4JPQmmg
 cxjQD/45Tw02DE47iFEG6myAKi/Xbw6SPrvZwxmvX4BEzQVEPCAsxjfkoCRgjn1Ahlv7NYyxhNW
 wn2ELdrjbFeY/7o6FkuMfJnXiXfA+5E8TrwWxWGSl6rCZoYPcRPQPZjsVp3G33QS74AvrVFSu7F
 nQaYGfSz0PejkF3HRE+HuoMGdCHMz7zB+uHt5dD/gkQ40dMHVOPGYcd35bCAx2DP6aL3iro/ZvZ
 DYcoA8UDd6pNcx3MSM2+WIB/p7SkvNQcgsRatz43QpNA0DYkpqQXDAZzmJG4kBBDYcCB5ixc//u
 KXy+TJgQ0xoJuekpx4mLA7y0lhYeaaXA3qOm4td682jtAsDjgkOQGHP4w3avrBKcpop7lUjgIJP
 Qn1S5x8MwaGULkD/PBroDiognbNePeoqOOVRihQnBCG3U0jLzt69HZl/h/g3H4RqPBQNS5prjDq
 nn6Dt6wPCs+BaeeF/B3I5ndya4k8Lpqg+ir7Cc6+ZiPkiGkrU6bdaZ6bvPdavNTRYPtSUI1jy4m
 bmJ65hIWqWxoYh3cFcgA5tWok1yxzoFVLrbPfWVP9OdlMqvMR81hU1/lFY4Q3+xaYkyB5li7yBO
 A5ldWxTzuVLQ/BiXDps1m5trVEuvLJu+HEN9sB+DsaSD0mxFysMceVCFMv/NuWzfghmb5ttGBA6
 8shW2AAL49FsOdA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The SYN + MPTCP_CAPABLE packets could be explicitly dropped by firewalls
somewhere in the network, e.g. if they decide to drop packets based on
the TCP options, instead of stripping them off.

The idea of this series is to fallback to TCP after 3 SYN+MPC drop
(patch 2). If the connection succeeds after the fallback, it very likely
means a blackhole has been detected. In this case (patch 3), MPTCP can
be disabled for a certain period of time, 1h by default. If after this
period, MPTCP is still blocked, the period is doubled. This technique is
inspired by the one used by TCP FastOpen.

This should help applications which want to use MPTCP by default on the
client side if available.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (3):
      mptcp: export mptcp_subflow_early_fallback()
      mptcp: fallback to TCP after SYN+MPC drops
      mptcp: disable active MPTCP in case of blackhole

 Documentation/networking/mptcp-sysctl.rst |  11 +++
 include/net/mptcp.h                       |   4 +
 net/ipv4/tcp_timer.c                      |   1 +
 net/mptcp/ctrl.c                          | 133 ++++++++++++++++++++++++++++++
 net/mptcp/mib.c                           |   3 +
 net/mptcp/mib.h                           |   3 +
 net/mptcp/protocol.c                      |  18 ++--
 net/mptcp/protocol.h                      |  16 +++-
 net/mptcp/subflow.c                       |   4 +
 9 files changed, 182 insertions(+), 11 deletions(-)
---
base-commit: bfba7bc8b7c2c100b76edb3a646fdce256392129
change-id: 20240909-net-next-mptcp-fallback-x-mpc-07072f823f9b

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


