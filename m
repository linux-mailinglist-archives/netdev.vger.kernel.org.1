Return-Path: <netdev+bounces-167459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A132A3A5B7
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBFBC7A3D47
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77BF17A2F0;
	Tue, 18 Feb 2025 18:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDQZOGmN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EF01684A4;
	Tue, 18 Feb 2025 18:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903787; cv=none; b=Hoc9uN7r3DSfYz9JCnw6K4Yc4RWjjuoSU8FxZInDuBUhBIF68k9tBElZR7CLpy+CcvWKLHzL2K8OMVqKSoKoawf2VVrtE1muxMJl5Tmuhd8wT2ar3wVAY/92HDq71b1dZNwxkM7gWmpDU6KZDp/dV+0E6fjn7Tl0+PRDhKj6YM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903787; c=relaxed/simple;
	bh=GE6oI67VXFkZsPgGGiC9UTylZX6O+/VfCD5aB8oXFXo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s20B3uHVK6BOuIiolnL59FKcrGiaHo1jRS1y26fza30xKJZ1mcXm/JYxvD5b0upsDYOgFySzwCSgk0O2DPWFI+fvwINhBzBm7hj8pz3DX1ywHpUQLmII8dd7kxHXjs3UJf/B/jZNINfVc37dVHKPYcwaIu5jGIGYD8AM/LibZy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDQZOGmN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B163C4CEE2;
	Tue, 18 Feb 2025 18:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739903787;
	bh=GE6oI67VXFkZsPgGGiC9UTylZX6O+/VfCD5aB8oXFXo=;
	h=From:Subject:Date:To:Cc:From;
	b=vDQZOGmN4Fbf2DCVY5i2x31z/hFHw2Nir1ezKuqASGG7DxuZHoSur7DMHApy9nmUt
	 KHZQKOsaVA+vwH5k/M5uPciq44XYosmP5ljULnomlsRH25g/Ru/vcp6sHbxTP8bqWX
	 cWiQu91yyjLZu1LhDEGZn80bubyXNKROXFyaL69d1ipDIWkdyw34fhyrYqh5ZM0BSW
	 7OTP+fChLCjj4q0snYzDolx1hPRVbqtCE2VwWvyVfoyANlobVXbR/RxpFEDFoupCmu
	 5+eKn9WhCvmFRp5mCqY6ay7BVWSOCzsbebucx5dJI92mhbxBRxUVNGx0/Ibal7SB9t
	 lirMU2D+M3i3A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/7] mptcp: rx path refactor
Date: Tue, 18 Feb 2025 19:36:11 +0100
Message-Id: <20250218-net-next-mptcp-rx-path-refactor-v1-0-4a47d90d7998@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABvTtGcC/zWNQQrDMAwEvxJ0rsAJdkP7ldKD48qNDnWMLIIh5
 O8VhR72MCyze0AjYWpwHw4Q2rnxVgzGywBpjeVNyC9jmNwU3OiuWEgtXfFTNVWUjjXqikI5Jt0
 Es/dhvlFewpzAVqo13H8PD/jL8DzPL2KGdch7AAAA
X-Change-ID: 20250106-net-next-mptcp-rx-path-refactor-f44579efb57c
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1961; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=GE6oI67VXFkZsPgGGiC9UTylZX6O+/VfCD5aB8oXFXo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBntNMnH0DZY0jM1/4TsV+MUzw/cq/ipu6B6+9nx
 l5B+oURvGiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7TTJwAKCRD2t4JPQmmg
 cyZ7D/909Jxixulms6H84naz2V1Tch3AEmLMk/Z6pgv7xKaPzTKjdXaYkM1ph39YgFTaGqhQ+eA
 qQyeF6G9qeWO4v+cxIwVTa9vbYIHiI2gzCndlp6xrHJVdH4xLFd1Zh9/9YSpa+6I2c04k184+da
 2Lg9Jz4vyZf7xxysnobQYR3lLKgq7Wff/9QUnN/O26MW9EdfGlJ26UUK71qdRCC++TZ78wpM52B
 sr1WWeEQPvGoUrpr8+yDNDeEx9MRrxXtjznfSVq2fJSDJ9WOo7RxmF3KdFKU9IiBM1XsCYPVx09
 Fbf35UJH5N0ElPt4pUNGPDMlAA8lZ3Wb1tZcxI6SiN66f8EGKR0R1HE2Th6cZctMDI1I3dO1yrH
 auHxUEzrRjs66xTI/896ho1coynHAT9ufjI/qH7fVXbThnia9yyCn7jvMT1xRtN1e78bE/1I8w/
 7M1EcqflsQBU+MjS2mMJyuJZZS5JXyKUIEZIDyT1xq0BPJC/L0VqA+yHntxgCLLf3TpdmPiwxN0
 lu70XBUs8xh4KeIXY/h/tkdVbe3Kis1Y4XTEGDBHuCYzMYqTY4v9qLIqSrfCk2iMY8kBKH8mCVq
 9XE0zfGM5wNXkpl+iqZXrPJKgFfK8X1vGiKEJ/EeLL6mRah+rse2wsIyURjWztWOyTRlxevS98v
 lAq+Z8doWyqq+fA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Paolo worked on this RX path refactor for these two main reasons:

- Currently, the MPTCP RX path introduces quite a bit of 'exceptional'
  accounting/locking processing WRT to plain TCP, adding up to the
  implementation complexity in a miserable way.

- The performance gap WRT plain TCP for single subflow connections is
  quite measurable.

The present refactor addresses both the above items: most of the
additional complexity is dropped, and single stream performances
increase measurably, from 55Gbps to 71Gbps in Paolo's loopback test. As
a reference, plain TCP was around 84Gbps on the same host.

The above comes to a price: the patch are invasive, even in subtle ways.

Note: patch 5/7 removes the sk_forward_alloc_get() helper, which caused
some trivial modifications in different places in the net tree: sockets,
IPv4, sched. That's why a few more people have been Cc here. Feel free
to only look at this patch 5/7.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Paolo Abeni (7):
      mptcp: consolidate subflow cleanup
      mptcp: drop __mptcp_fastopen_gen_msk_ackseq()
      mptcp: move the whole rx path under msk socket lock protection
      mptcp: cleanup mem accounting
      net: dismiss sk_forward_alloc_get()
      mptcp: dismiss __mptcp_rmem()
      mptcp: micro-optimize __mptcp_move_skb()

 include/net/sock.h   |  13 ---
 net/core/sock.c      |   2 +-
 net/ipv4/af_inet.c   |   2 +-
 net/ipv4/inet_diag.c |   2 +-
 net/mptcp/fastopen.c |  27 +----
 net/mptcp/protocol.c | 317 ++++++++++++++++-----------------------------------
 net/mptcp/protocol.h |  22 ++--
 net/mptcp/subflow.c  |  36 +++---
 net/sched/em_meta.c  |   2 +-
 9 files changed, 134 insertions(+), 289 deletions(-)
---
base-commit: b4cb730862cf4f59ac3dcb83b9ac4eeb29dbfb0e
change-id: 20250106-net-next-mptcp-rx-path-refactor-f44579efb57c

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


