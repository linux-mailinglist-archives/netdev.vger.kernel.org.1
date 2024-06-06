Return-Path: <netdev+bounces-101584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E09938FF81C
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 01:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66CAE1F26372
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 23:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76B013E3FD;
	Thu,  6 Jun 2024 23:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRxD75ps"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1AC6D1B9;
	Thu,  6 Jun 2024 23:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717716374; cv=none; b=otfXpgfSGxnTQTnde839n6HgiWkpjKcWiHVNaA89PWIlMkROaLf9m9zNdt61XeQ0PXm5poyyNd7m2/ZBSgWx4CeSiJcdcVz02fSqaCfU6ijXR1T7m67QIXLWF8B1Dz35f47pJGLT8LQ11TiNqIraNRPasFkMIHSoNCrQwCK54dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717716374; c=relaxed/simple;
	bh=llottDhQKaURlXE/wW1YxOb8Cyb6//i4SbVQqw7++1g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JYxvqCeLZYVlb9xBrgjeVWSLGGj82M0HmRsb6egZsqp5kv73lF4Ih4MtwVckY4BOp0yU+rKrxgqXHH03ZjmS5VPd4M5mQ95nqCvLdlMmfdS95KW8KXdB3SZ68yYIjFm0RZKbgZ5XhS5t63zVLEFtVnpHO4thIhCgrAOPmjaSnus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRxD75ps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09D25C2BD10;
	Thu,  6 Jun 2024 23:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717716374;
	bh=llottDhQKaURlXE/wW1YxOb8Cyb6//i4SbVQqw7++1g=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=NRxD75pswYoXVg3psi9+MR1RoqgqOHd9STzMomK4/4zDQ1ID6k2f3Lu1sY+WkNSSw
	 WBkIAv9pdccohacKZRq114jaQ/UdaXoJGDtIcteajfV5fyc+TsQhS2Xx0Y2J8ls/HN
	 W2PsmVFfp08w+6WAtz6nym7CBbadN18C5XtMThscq7dfPEJRppXwVlVTfch5pDMQzg
	 AjCJcxXeJXOtSRYSC46JDkxfCvH+maXDZAoDoS8V0xdvHXeS0yzTEuo4po5f7OBW/z
	 8HO5LiSr78R/4m0h+4AkPH4I/utrxl7r+P6uQNsM7PtrOBkIxr8gxj0NmmT0W9Nqv3
	 LCSc3TYjnlm5A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31E4C27C52;
	Thu,  6 Jun 2024 23:26:13 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Subject: [PATCH net-next v4 0/6] net/tcp: TCP-AO and TCP-MD5 tracepoints
Date: Fri, 07 Jun 2024 00:25:54 +0100
Message-Id: <20240607-tcp_ao-tracepoints-v4-0-88dc245c1f39@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAINFYmYC/23OQWrDMBAF0KsEratWM7Idu6vco5QylkexoJGMJ
 ERK8N0rG0rakuUw/Pf/TSSOjpN4PdxE5OKSC74ezdNBmJn8maWb6i1QYaNaDTKb5YOCzJEML8H
 5nKQlZGgYrJomUYNLZOuuO/omPGfp+ZrFe/2MlFiOkbyZN/Tn93Ih57fk7FIO8WtfU2DP78WIz
 VYs/xUXkEpCazWMR6sVHU8Uq0DPJlz2voJ3o1Pto/EFq8EDMHSAPbI9neuazzuhfxPdQ0JvM3S
 HMPS9UcMfYl3Xb1NMPTRlAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717716372; l=2059;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=llottDhQKaURlXE/wW1YxOb8Cyb6//i4SbVQqw7++1g=;
 b=+Z3xNAjQb4voEBX4c6KwxL7PqDNBav+hy3mtePPR/DpLG4FW629l6x10sW8ZwP7VLFGCDpVoHUpE
 Kc4YOLubCW5wcsAOYEzrV3PFrNP5Z/DrYNeGMAOd0G+PeBIpnPJV
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
Changes in v4:
- Fix the build for CONFIG_TCP_MD5SIG=n (Matthieu Baerts, netdev dashboard)
- Link to v3: https://lore.kernel.org/r/20240606-tcp_ao-tracepoints-v3-0-13621988c09f@gmail.com

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
 net/ipv4/tcp.c                      |  98 +++++++++--
 net/ipv4/tcp_ao.c                   |  24 +--
 net/ipv4/tcp_input.c                |   8 +-
 net/ipv4/tcp_ipv4.c                 |   8 +-
 net/ipv4/tcp_output.c               |   2 +
 9 files changed, 443 insertions(+), 157 deletions(-)
---
base-commit: 62b5bf58b928f0f4fcc8bb633b63795517825d31
change-id: 20240531-tcp_ao-tracepoints-fa2e14e1f0dd

Best regards,
-- 
Dmitry Safonov <0x7f454c46@gmail.com>



