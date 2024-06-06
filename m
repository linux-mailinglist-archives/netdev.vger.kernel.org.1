Return-Path: <netdev+bounces-101201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7378FDBC0
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6FC281B5F
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 00:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5543FDDBE;
	Thu,  6 Jun 2024 00:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHsQ/o1+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5378821;
	Thu,  6 Jun 2024 00:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717635511; cv=none; b=TUSUTEqXzs8uxqI7FMNBT4u1QiMjOBgWK30RpRTLBNPAAz0ZJQqBsJoZjEWW1FOKl2CHp2+N9YW63vf7UODOycvpK/l/s07K9id73RzZlgZ4Ve5Y4WpUy7z2mUjfMjUfYs0GiOT8XmcdPnfoLcv5j5YEOKdRDHNQN69FmuUIk8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717635511; c=relaxed/simple;
	bh=bcGRgEvEo62X/MLxlgNLFRIy+S5DmEwSGkybq/yerHo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NGKFxEGjSJs9f0E9mCX20Bmi5EjL8IWdwQMqMvkJ37AceTEyG0s8/HM5hida41UZ6uCCiYzsIxI80HC4uTRYTzgJuopyys6DeYiC71ecwzT53+7rEdPe4yu1lS3rzbXu8QnJCM1vTOjce8zhR/m9dHzraaViTPHndzzL57Wv+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHsQ/o1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C9BCC2BD11;
	Thu,  6 Jun 2024 00:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717635510;
	bh=bcGRgEvEo62X/MLxlgNLFRIy+S5DmEwSGkybq/yerHo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=NHsQ/o1+ZT6g0mEopCY5oecP7MNefvl7arpnfF3dR/Unpe21f7IZpakRHPYf6F5KK
	 AC+WxGuIkuFEa/c93C+N0nPC1krPm58ChwpwvBRL3iTXc0O17vve7CSJNskfLaSE9u
	 prNpl6raSszXqRpRqK+JJz9lKvlLfDpBNXHCGrVcKoXX/hN05tLdUPJ12pAS+RTU3Y
	 uHD4MJlGumc4CXsf1oh6yZTx8HY6d16VRH1qR9OT6cYGS9pfvGRXhdBYQQ1ByDm8/G
	 lqfZ/EOWShovIuyMSJDUqiP6Kh1UK5PoxVwuQvdknPQCEVyjS533kAkH3gb57HrB04
	 DNIWJHIXGMoYQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F630C25B76;
	Thu,  6 Jun 2024 00:58:30 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Subject: [PATCH net-next v3 0/6] net/tcp: TCP-AO and TCP-MD5 tracepoints
Date: Thu, 06 Jun 2024 01:58:17 +0100
Message-Id: <20240606-tcp_ao-tracepoints-v3-0-13621988c09f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKoJYWYC/22OwWrDMBBEfyXo3G21aztpesp/lFDW8ioWNJKRh
 EgI/vfKKqVQehyGeW8eKkl0ktTb7qGiFJdc8DV0TztlZvYXATfVrEhTr4cOIZvlgwPkyEaW4Hx
 OYJkEe0Grp0nV4RLFuluDvisvGbzcsjrXZuQkMEb2Zt6gP93LlZ3flrNLOcR7e1Ow7ZuYqN/E8
 EdcEDTgYDscD7bTfDhxrAR+NuHafIV+GXs9/He+UGXIEQX3SK8k9nSpbz6/Eeu6fgFqpbuNIgE
 AAA==
To: Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717635508; l=1866;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=bcGRgEvEo62X/MLxlgNLFRIy+S5DmEwSGkybq/yerHo=;
 b=sz9JlhZh10+BL8KGtQIEgSt9PbtbS3WiNVSbOjSb0K4eFnKvKIDkNpd74mFdySFe3vyCOqcsQE6w
 9htUSe5dCXdRKDh7tAmTS5t9vdh0K0mOARs2FqUy7YdGMr0bF8Mp
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
Changes in v3:
- Unexported tcp_inbound_ao_hash() and made static (Eric Dumazet)
- Link to v2: https://lore.kernel.org/r/20240605-tcp_ao-tracepoints-v2-0-e91e161282ef@gmail.com

Changes in v2:
- Fix the build with CONFIG_IPV6=m (Eric Dumazet)
- Move unused keyid/rnext/maclen later in the series to the patch
  that uses them (Simon Horman)
- Reworked tcp_ao selftest lib to allow async tracing non-tcp events
  (was working on a stress-test that needs trace_kfree_skb() event,
   not in this series).
- Separated selftest changes from kernel, as they now have a couple
  of unrelated to tracepoints changes
- Wrote a few lines of Documentation/
- Link to v1: https://lore.kernel.org/r/20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com

---
Dmitry Safonov (6):
      net/tcp: Use static_branch_tcp_{md5,ao} to drop ifdefs
      net/tcp: Add a helper tcp_ao_hdr_maclen()
      net/tcp: Move tcp_inbound_hash() from headers
      net/tcp: Add tcp-md5 and tcp-ao tracepoints
      net/tcp: Remove tcp_hash_fail()
      Documentation/tcp-ao: Add a few lines on tracepoints

 Documentation/networking/tcp_ao.rst |   9 +
 include/net/tcp.h                   |  92 +----------
 include/net/tcp_ao.h                |  42 +----
 include/trace/events/tcp.h          | 317 ++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp.c                      |  90 ++++++++--
 net/ipv4/tcp_ao.c                   |  24 +--
 net/ipv4/tcp_input.c                |   8 +-
 net/ipv4/tcp_ipv4.c                 |   8 +-
 net/ipv4/tcp_output.c               |   2 +
 9 files changed, 435 insertions(+), 157 deletions(-)
---
base-commit: d223d1947dadec37d2bb5efbda9fc34c03b9a784
change-id: 20240531-tcp_ao-tracepoints-fa2e14e1f0dd

Best regards,
-- 
Dmitry Safonov <0x7f454c46@gmail.com>



