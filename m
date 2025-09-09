Return-Path: <netdev+bounces-221026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CEBB49E94
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 03:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B8D1BC52FC
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 01:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A13219A8A;
	Tue,  9 Sep 2025 01:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Um1wu7hD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0B072634;
	Tue,  9 Sep 2025 01:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757380737; cv=none; b=Aa5W/mGc3sPTNF8ZR7R2LHRM2dyDRi2DncKKlkzto5yCK/6dH4WJENv7kdgI9ssQJOxyu6pxQVgKlD7pSMPOhlvGFbM1NkHyccixgwLacxQ9D+gCyry9LXqfwOE/65NHtjQKZD2AwRFYeRjfGijxLDPSJapIhe4XVccelH8JGoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757380737; c=relaxed/simple;
	bh=NLOeQjxGPHH5ZNeF2UrBn+JdoQWtZuLs3UGlctvi6TE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JmKG10CdvX9PWjb3jDNh9yArJ1xbdkxjRYry24Bh5eZMKwh4NcV6taAncV8n+Wv6iUJlFDsf/B3hEay0XrCpI/kh/adwNtPQ9+1LCR4T9nSVCkkl9aMVmOBHiwswtQGZT3AKfUoYKWKsxRM7e9M7RMOYjRFGih3dnAgdsj0bluM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Um1wu7hD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 828B1C4CEF1;
	Tue,  9 Sep 2025 01:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757380736;
	bh=NLOeQjxGPHH5ZNeF2UrBn+JdoQWtZuLs3UGlctvi6TE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Um1wu7hDIOEyxfMYdFA9kIvrMnG8d6N6IiKATI6werV6YfJpbqtTQszdzOMCyuU/y
	 g2kXbtcAmYIjAEYkHM1RIZBSSAlqP6qks7KNbbkPILZjHxAW+6l/guWhGMUT77zgzL
	 oPydpzlJ4E98lQgvGLIv5w4o8R6CrUlQmptFs+0b4dDkdj15uYJykCmPI1dc6QvqCN
	 y2fTHaCswmUS3GFNZkhqRy/ZOynlw3rJSp+h7SxSxiJnhWlHRM4X8UMoWYmY0hHiVW
	 taHPNAHAoRcQG2qRYbYkJPovqkUUqUYzWm2rAcltwUD/odE/Qd3Nx/y+3qEcLtyhjc
	 yNO39QgVMspWw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA64CAC581;
	Tue,  9 Sep 2025 01:18:56 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>
Subject: [PATCH net-next v5 0/2] tcp: Destroy TCP-AO, TCP-MD5 keys in
 .sk_destruct()
Date: Tue, 09 Sep 2025 02:18:49 +0100
Message-Id: <20250909-b4-tcp-ao-md5-rst-finwait2-v5-0-9ffaaaf8b236@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHmAv2gC/43OTU7DMBAF4KtUXjPgjO1is+IeiIV/xsSLOJVth
 aIqd8eNhCiqFLGb0dN88y6sUklU2cvhwgotqaY590U9HJgfbf4gSKHvDDkqrhHBSWj+BHaGKSg
 otUFM+dOmhkBHgU4GHZUOrAOnQjGdN/yNZWqQ6dzYe0+crQSu2OzHK/6TPU025evlmGqby9fWa
 hm2+/8UWAbggEqjClyr4N2rLV2yj36etr8L3lp618JuHZXgxjiyyg93lrixBN+1RLcM5xjJi2c
 p5Z0lfy3Dxa4lu0VRWEMd68Mfa13Xb6NfrzDTAQAA
X-Change-ID: 20250822-b4-tcp-ao-md5-rst-finwait2-e632b4d8f58d
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Bob Gilligan <gilligan@arista.com>, 
 Salam Noureddine <noureddine@arista.com>, 
 Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757380735; l=2207;
 i=dima@arista.com; s=20250521; h=from:subject:message-id;
 bh=NLOeQjxGPHH5ZNeF2UrBn+JdoQWtZuLs3UGlctvi6TE=;
 b=sEBgYb6o5PRmHxL0XQY6soj/z5HK+FLUgHUwj5maddX7iE/M5Yf4mI6ReLfqqVfxg1ZPQyn3N
 oBn4unGdpC5A+Shz3bWRiWpNL2zN1DauyZFmW7qelKGedqjMxzg9Bpg
X-Developer-Key: i=dima@arista.com; a=ed25519;
 pk=/z94x2T59rICwjRqYvDsBe0MkpbkkdYrSW2J1G2gIcU=
X-Endpoint-Received: by B4 Relay for dima@arista.com/20250521 with
 auth_id=405
X-Original-From: Dmitry Safonov <dima@arista.com>
Reply-To: dima@arista.com

On one side a minor/cosmetic issue, especially nowadays when
TCP-AO/TCP-MD5 signature verification failures aren't logged to dmesg.

Yet, I think worth addressing for two reasons:
- unsigned RST gets ignored by the peer and the connection is alive for
  longer (keep-alive interval)
- netstat counters increase and trace events report that trusted BGP peer
  is sending unsigned/incorrectly signed segments, which can ring alarm
  on monitoring.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
Changes in v5:
- Use EXPORT_IPV6_MOD_GPL() instead of EXPORT_SYMBOL_GPL()
  for tcp_md5_destruct_sock (thanks to Kuniyuki Iwashima)
- Re-worded the destructor conditions, the socket is in TCP_CLOSE
  in both cases (Kuniyuki Iwashima)
- Link to v4: https://lore.kernel.org/r/20250903-b4-tcp-ao-md5-rst-finwait2-v4-0-ef3a9eec3ef3@arista.com

Changes in v4:
- Remove struct tcp_ao_info::rcu as it's no longer used (Jakub)
- Link to v3: https://lore.kernel.org/r/20250830-b4-tcp-ao-md5-rst-finwait2-v3-0-9002fec37444@arista.com

Changes in v3:
- Assign NULL to md5sig_info before call_rcu() (catched by Eric Dumazet)
- Link to v2: https://lore.kernel.org/r/20250828-b4-tcp-ao-md5-rst-finwait2-v2-0-653099bea5c1@arista.com

Changes in v2:
- Fixed TCP-MD5 ifdeffery (Reported-by: Victor Nogueira)
- Call proper destructor for inet_ipv6 (Reported-by: syzbot@syzkaller.appspotmail.com)
- Link to v1: https://lore.kernel.org/r/20250822-b4-tcp-ao-md5-rst-finwait2-v1-0-25825d085dcb@arista.com

---
Dmitry Safonov (2):
      tcp: Destroy TCP-AO, TCP-MD5 keys in .sk_destruct()
      tcp: Free TCP-AO/TCP-MD5 info/keys without RCU

 include/net/tcp.h        |  4 ++++
 include/net/tcp_ao.h     |  1 -
 net/ipv4/tcp.c           | 16 ++++++++++++++++
 net/ipv4/tcp_ao.c        |  5 ++---
 net/ipv4/tcp_ipv4.c      | 37 ++++++++++---------------------------
 net/ipv4/tcp_minisocks.c | 19 +++++--------------
 net/ipv6/tcp_ipv6.c      |  8 ++++++++
 7 files changed, 45 insertions(+), 45 deletions(-)
---
base-commit: abcf9f662bc7ec72b3591d785eccd7dd8c239365
change-id: 20250822-b4-tcp-ao-md5-rst-finwait2-e632b4d8f58d

Best regards,
-- 
Dmitry Safonov <dima@arista.com>



