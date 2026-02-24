Return-Path: <netdev+bounces-260398-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IrPB55fnWkDPAQAu9opvQ
	(envelope-from <netdev+bounces-260398-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:21:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 639EB183918
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A449830CF020
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 08:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D77336681C;
	Tue, 24 Feb 2026 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K579pUTO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D94366809;
	Tue, 24 Feb 2026 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771921225; cv=none; b=KkEtf/3lOnMkII3qL7qMQS2ZxKXDbgheBlwi0DRwvaHt3XYLLLYTQYQIZ7w3tTCME+QiiXZa3DBfYfKHbohw3n4BvgtJ8qX49Swc4gJT0GJMo0DBbJh38cFj21Rcpq2pZq7OUve0COc2DVnE/itFcrpTXWtkX+b7D4VhfXuAaQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771921225; c=relaxed/simple;
	bh=iQjPg2LXKrMXc3WCOF+ndy+MkCA4NlMl9SonN6terl0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z8TiuNiCVqOss7rODjxBJRzPzP19Q/pwtzOrb7egc5yXNJSBwm6FHe6u40HQM8avUziQK/CEb9Jevh5nQM+NO3IiADBKR1WJ0Fo2bI3nnr+TwuvjI+du8PlK85asWUScpc/uhClVPCu+NVLkuUEeD4QxDVuv+ieCLOQbBCSdwXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K579pUTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80E1BC19423;
	Tue, 24 Feb 2026 08:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771921225;
	bh=iQjPg2LXKrMXc3WCOF+ndy+MkCA4NlMl9SonN6terl0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=K579pUTO4w95yrmEg1Y/mCmdrwgdRzLg0Z5FeR+eRydrHGmR7AjnFQ2J0z6ya5xjg
	 nPQmWwiSafwQ9mdntWPpxy+9QG6iHTZGr6aWi+myYYWx3iLEIOrm8OP+3bvecd4d7+
	 Yn4zYcPMlzuioIbsoUsyT36qr/rkJqcJL86vrKgpVXNEQP0RI4k4tTJzmpNNYxH1uU
	 7S8dPNd948Snq5szoyrmnC/kPxgG/2OGN7PAIh9FPSBiGf9UE13YV958PGQWst9emk
	 1Klcs0gABDPLR22znBKy7vBF1MTJ1QrAl700JsifUfVuQ06UcKzIIk0U1SxHOzzjKj
	 sSRoT//051Nkw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5FDEFB801;
	Tue, 24 Feb 2026 08:20:25 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Subject: [PATCH net v2 0/2] tcp: re-enable acceptance of FIN packets when
 RWIN is 0
Date: Tue, 24 Feb 2026 09:20:11 +0100
Message-Id: <20260224-fix_zero_wnd_fin-v2-0-a16677ea7cea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNyw6CMBBFf4XM2pp2AI2u/A9DCLRTmERa0hJ8k
 P67DXHn8r7O3SBSYIpwLTYItHJk77LAQwF67NxAgk3WgBJPElEJy6/2Q8G3T2day04Y1XdKaVP
 28gx5NgfKnR15B0cLNNkcOS4+vPebVe3Rj4j/xFUJKWpbybK61GhLfRumjh9H7SdoUkpfUlVIX
 rUAAAA=
X-Change-ID: 20260221-fix_zero_wnd_fin-d1ba11cd3b07
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Simon Baatz <gmbnomis@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771921224; l=983;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=iQjPg2LXKrMXc3WCOF+ndy+MkCA4NlMl9SonN6terl0=;
 b=d2tKmYZIkxzmfzTEaX20IA/Rl77jjUafMxejHMQM6gR1Cu7IFRtm4uyA+V5hpawd/43oiOUzg
 ZpYRClF6pTqC/734SUwhOJg+HzaIhMepKGrD+7M4LKP5ypxCmFY/ctB
X-Developer-Key: i=gmbnomis@gmail.com; a=ed25519;
 pk=T/JIz/6F5bf1uQJr69lmyi7czVG+F9TVZ/8x5z9Wtqw=
X-Endpoint-Received: by B4 Relay for gmbnomis@gmail.com/20260220 with
 auth_id=641
X-Original-From: Simon Baatz <gmbnomis@gmail.com>
Reply-To: gmbnomis@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260398-lists,netdev=lfdr.de,gmbnomis.gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[gmbnomis@gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 639EB183918
X-Rspamd-Action: no action

Hi,

this series restores the ability to accept in‑sequence FIN packets 
even when the advertised receive window is zero, and adds a 
packetdrill test to guard the behavior.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
Changes in v2:
- Move the FIN handling out of the default execution path as suggested by Eric Dumazet
- Link to v1: https://lore.kernel.org/r/20260222-fix_zero_wnd_fin-v1-0-5f4034952f3c@gmail.com

---
Simon Baatz (2):
      tcp: re-enable acceptance of FIN packets when RWIN is 0
      selftests/net: packetdrill: Verify acceptance of FIN packets when RWIN is 0

 net/ipv4/tcp_input.c                               | 18 +++++++++++----
 .../net/packetdrill/tcp_rcv_zero_wnd_fin.pkt       | 27 ++++++++++++++++++++++
 2 files changed, 41 insertions(+), 4 deletions(-)
---
base-commit: d4f687fbbce45b5e88438e89b5e26c0c15847992
change-id: 20260221-fix_zero_wnd_fin-d1ba11cd3b07

Best regards,
-- 
Simon Baatz <gmbnomis@gmail.com>



