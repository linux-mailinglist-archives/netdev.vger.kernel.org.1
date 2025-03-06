Return-Path: <netdev+bounces-172430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01008A54940
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 12:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF6A3A8EAD
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B052063D7;
	Thu,  6 Mar 2025 11:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLlrPblq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ECF1FC0F9;
	Thu,  6 Mar 2025 11:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260632; cv=none; b=RspTpGqS+Dy8oF4Xjqsyl1ngDYXznkd+ac0JCuy7V0O86j2bd5s2GbgEV4/v9nh2/055mfXOqfMcB4/PEtFUvhDtKMkcddWPzWcJn3pUDjcG9ucprjgTFMwxju5y6XIFzaVZ6RScM7CaZwvseeKhPkuDA9DO9Ur4zSmGylo7574=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260632; c=relaxed/simple;
	bh=Qr0sGyrLmQ6es4CO43+zm0fmuYxQlueRct9R+BrDTHM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Owmq1aN9xBm3Sw8OIcssyxL8+SAgBKGyX9AyErczHex8fzbowWVyZrNwqv++gWVuw3JRSmaymEygw5cM3UOvJMuXOC7xnqotTHDh1wYg+dQh4x/oF+9EWw+Jzr2mH8cDNKjzc+Q1hlsq7l98/6UUP1tHeQpzB7f52hveJC8PY3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLlrPblq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF0DC4CEE0;
	Thu,  6 Mar 2025 11:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741260632;
	bh=Qr0sGyrLmQ6es4CO43+zm0fmuYxQlueRct9R+BrDTHM=;
	h=From:Subject:Date:To:Cc:From;
	b=VLlrPblqXk0hvw/yfgsRaMg7o5ZGImnJKiCuHLCBcG5Mqphl/n2sah0y7Oz2WmTYw
	 6/1RtIoHcJivpGewzX0z9TKosnc5fW25xB0mDnYpDKeRLVUjCCGqm+pR6IyDs1YL/N
	 Z4kn00rF4QlKmvRkMsrxzIJmD5+T67Z8W9ZhqhAoBPMGKEuxEt+UdE7ZmQNvyFejTQ
	 59EY6aHMlyies9499Fm0HLbomJASWb/sZJ27jvEQWfxFNfJc1VXTS3kTWQGLBCjX7e
	 SJLvNhDegscin37BW5i6u3Uf7vR83/eXwRLmQHvBWmnisqrydCoWU7w220NNbXN7CB
	 /lNvr+4cjWNdg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/2] tcp: ulp: diag: expose more to non net admin
 users
Date: Thu, 06 Mar 2025 12:29:26 +0100
Message-Id: <20250306-net-next-tcp-ulp-diag-net-admin-v1-0-06afdd860fc9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABaHyWcC/zWNQQqEMBAEvyJz3oFEUXG/InuIzqgDbgxJFCH4d
 4PgoQ/VUN0JAnvhAN8igedDgmw2g/4UMC7GzoxCmaFUZa0q1aDlmHNGjKPDfXVIYuanNfQXi0Z
 TQ+3UdVoNkFec50nO56GHV4bfdd3TPyaMewAAAA==
X-Change-ID: 20250306-net-next-tcp-ulp-diag-net-admin-a1d6d7f9910b
To: mptcp@lists.linux.dev, Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Davide Caratti <dcaratti@redhat.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Qr0sGyrLmQ6es4CO43+zm0fmuYxQlueRct9R+BrDTHM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnyYdUFD9xJyEeInj0DwaLM9fl53Png/7uclYVV
 UZl0Quc64mJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8mHVAAKCRD2t4JPQmmg
 c14cD/9YQKASsBE+hbG+LjxHAejiXxM0uvZgu3sb+9gffexHJ7p4nYpx4zkaBVJoMsTocGGgRQB
 zwOeW0nF82mw6c7EHS2jzr+tsVPNxEaZsRCY6rBauhqvHBeeMO6sNUmTJXlzECOYLu1/cHCeZmO
 2wBPIKc0uJ8/cELc9pssBdlW3R16CCOetIGZautRkYaGugXlw4Ogt1qQUNYuZVdLwdA5O5eI9B8
 w7ERjpp3SYeSAG0tLJI4uEaStAUhcwUsDVt0CmdYPuujNoVfm5KocNboYs9bx9n9KnfVWloZgaY
 4KmWfxgdLIRkpYAA/P078JW79z0WgJZLZWUfySC1P2wzzKIln6OoTVCnpAgjATXJ4pCgV6i8Hdb
 OSitbgYSL+3SXAl+bc1CgQr62CpLgjVOqAqfCUOKhQ4zMmg/hk5bKi8xDvWy3Y6YOG3Lykjrjc7
 wUzkFD1Ni4bWrm/k2x1AyFWy9TfquEYhv86roMwHeuLhJayR/cGc+d0JcpareggUhZUbME6uN9E
 5jrKKcsncpjR9QV0YDyNfZua4MfxyrmHoRBQo8meSc6qUhO/acVfDdQbzZGvmxPb4CLWp1tP0jI
 M77US5hS592ptolW65hESWOFRw26LJ+rFMfwpKpzSSpN4d6vXAHcLw58v8r1w5RDTC0lYiFBa15
 vNToL/Qv38ZRcmQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Since its introduction in commit 61723b393292 ("tcp: ulp: add functions
to dump ulp-specific information"), the ULP diag info have been exported
only to users with CAP_NET_ADMIN capability.

Not everything is sensitive, and some info can be exported to all users
in order to ease the debugging from the userspace side without requiring
additional capabilities.

First, the ULP name can be easily exported. Then more depending on each
layer:

 - On kTLS side, it looks like everything can be exported to all users:
   version, cipher type, tx/rx user config type, plus some flags.

 - On MPTCP side, everything but the sequence numbers are exported to
   all non net admin users, similar to TCP.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (2):
      tcp: ulp: diag: always print the name if any
      tcp: ulp: diag: more info without CAP_NET_ADMIN

 include/net/tcp.h   |  4 ++--
 net/ipv4/tcp_diag.c | 21 ++++++++++-----------
 net/mptcp/diag.c    | 42 ++++++++++++++++++++++++++----------------
 net/tls/tls_main.c  |  4 ++--
 4 files changed, 40 insertions(+), 31 deletions(-)
---
base-commit: f130a0cc1b4ff1ef28a307428d40436032e2b66e
change-id: 20250306-net-next-tcp-ulp-diag-net-admin-a1d6d7f9910b

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


