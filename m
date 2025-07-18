Return-Path: <netdev+bounces-208259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E283AB0ABEB
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 00:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B5D5876C4
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 22:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F72021FF36;
	Fri, 18 Jul 2025 22:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldlIWOtE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C716FB9;
	Fri, 18 Jul 2025 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752876442; cv=none; b=Kie36Wxju0hRlBEZ5jBNNv11Xgujf52lgEHzkqfHvMnT97OLm4Jvu1FL3jMdTpUoz49IwvVuDZ9/5lGp+j2FtYA6WLHwnviOP42030FQ52ofKKZRbjECj14KUmZ/WOxKg9JFRJkrdHaln/diEqmxrFRxHPlkHREW9zjn/+2dnno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752876442; c=relaxed/simple;
	bh=ec+W7xqJqZSbhJG174LRHGwWW3J3F87spV8EAcrx7+Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=InbhxqHNOfyFJpV+cnKGg0pO4PlojwGGm4oDWZFdYMps0QbdSzRTGh3jcV/AYn1pmzkFFYzLAOfN6QNZCGycd7f+lqdUAaz0dFTbXceGrgO/Go/CcuCEgTPS0cV2HWtTMoVYOZLiwaA+EHCKh4vfaWCvwwTtnU2bcM4PLP899BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldlIWOtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB860C4CEEB;
	Fri, 18 Jul 2025 22:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752876441;
	bh=ec+W7xqJqZSbhJG174LRHGwWW3J3F87spV8EAcrx7+Y=;
	h=From:Subject:Date:To:Cc:From;
	b=ldlIWOtE9egt7Hvt2THC2jgK67r3CMbWiH/CDkdMMKyfwpdDsP6PMXczznz2z5WvF
	 nvuXJH9nK6UisnBj0ZBDWIUod3ARQ8LJASysGyJytHHfdMxXmhzTNgtp33aiYAZg58
	 k/TGaE2KGDGA0e+xaYhwodjwfwDXOICNqinUmhgnjWnNXs1iWIBznfSm/wiLrzc/an
	 BkXMeSLlxMIbmFHgHgBoqTC4zSVB5QIq1RVcMCDow8WzbYsADQNY+mFDQdSzs4WcoB
	 EcfsrYgb29JCTrDOn4ORz6CmgnozJpsl18OU3ia/C6VA5cd4BgdkCmo54hheogKCim
	 yr5ASqcfmWpbQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next v2 0/4] mptcp: add TCP_MAXSEG sockopt support
Date: Sat, 19 Jul 2025 00:06:55 +0200
Message-Id: <20250719-net-next-mptcp-tcp_maxseg-v2-0-8c910fbc5307@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH/FemgC/42NQQqDMBREryJ/3V+StEbrqvcoUoJ+NbTGkARJk
 dy9IdB9F28xDPPmAE9Ok4euOsDRrr3eTA7iVMGwKDMT6jFnEEzUrOESDYVMDLjaMFjMPFcVPc1
 ITcNEe+OsZSPkvXU06VjcD/jNoM/Non3Y3Kec7rz0f/h3jgzrazteVC2lnOT9Rc7Q+7y5GfqU0
 heTlKTlzQAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1583; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ec+W7xqJqZSbhJG174LRHGwWW3J3F87spV8EAcrx7+Y=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGh6xY6hlcRVfqh9WIGCRI1XuKg3MLokEBd/iPo7ZyCVuBKhb
 4h1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmh6xY4ACgkQfCLwwvNHCpcA8wEAgE7U
 QptxGjF1xjuRHZIJpJ1Z5gbr+rcEfKuQvqYWQRcA/0HUbQuHDRucaVHVhie5RekuU0nKy5X0uta
 fgGvdS+UA
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
Changes in v2:
- Patch 2: Set the return value of tcp_sock_set_maxseg() to err.
- Patch 3: make mptcp_setsockopt_all_sf() returns only once.
- Link to v1: https://lore.kernel.org/r/20250716-net-next-mptcp-tcp_maxseg-v1-0-548d3a5666f6@kernel.org

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
base-commit: d61f6cb6f6ef3c70d2ccc0d9c85c508cb8017da9
change-id: 20250716-net-next-mptcp-tcp_maxseg-e7702891080d

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


