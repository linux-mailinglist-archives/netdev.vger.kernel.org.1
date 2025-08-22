Return-Path: <netdev+bounces-215914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF06B30DC2
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 06:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675B61CE3559
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 04:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC18275AFF;
	Fri, 22 Aug 2025 04:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjjyKMv4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FD3266B67;
	Fri, 22 Aug 2025 04:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755838568; cv=none; b=cBnZszQiEWFcHGcl1UgtmnuvrdCgIfkYwZvAHbFtzdn5i0pKjSWWeC5S6faz23M6CFRyz8J0qayRlFqzK6fQzoPwNY9AR1TlGuewxtJA1Aq1QbIlKeEOEO/JqQK3cFTDY0D2dxrJGW4aA53p1tWYQ9VAkUWNQrhrYD1Ijyc1470=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755838568; c=relaxed/simple;
	bh=eoIgmp6rOubH/7RKU/oUjCoxUtaCvNYc3/qZX5mbECY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P3qGQ1bU+fYEmcwD+FVAd86KkbEiJcZN88MlMlbwXmDNZBurUC6vGIDakcWaAH6zdeSFPGoA7N9Slqyhkw6+kSc+u0vkXwZO3aEQK6BkHSSH3n5m3NpX2WvQwxN+juM1IVZofg2sE2vq2yq5DuAJUq4nFycmhD/ROAVxhwK81WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjjyKMv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39489C4CEF1;
	Fri, 22 Aug 2025 04:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755838568;
	bh=eoIgmp6rOubH/7RKU/oUjCoxUtaCvNYc3/qZX5mbECY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=TjjyKMv4MhaYVSiw/o7fdidoYZsXN8e3xDjjp2+ifc5beIYfOz8HKaexnQYxKOgua
	 X6zZ8cJ9QQyBXAsNBFfyjY8UlReCPGvgtGG2ynMAIed6sg8icjD7YkiZ8Vd2wRVsSS
	 iQnKefP8i67a3ra9OploTPc3c03saJ61OPMlTUQmJeSAZnOtcEZIJWt08sqLVRlp44
	 HIMTYW9u00W6Eu+QyDnAbyG9r2wOQBBMX+iyfsen8X4CEOJkpZfsrkr1R2UjKWW7Ry
	 RIa644vTYBtrQAqigiEtsgvWEOziaMykoeNLlGBfp1Ph1kBjKWChUKqFQDZpICCkFd
	 NlENJXQFZFL6Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0D4CA0EFC;
	Fri, 22 Aug 2025 04:56:08 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>
Subject: [PATCH net-next 0/2] tcp: Destroy TCP-AO, TCP-MD5 keys in
 .sk_destruct()
Date: Fri, 22 Aug 2025 05:55:35 +0100
Message-Id: <20250822-b4-tcp-ao-md5-rst-finwait2-v1-0-25825d085dcb@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEf4p2gC/zXMTQrCMBBA4auUWTtYx0aCVxEX+ZnYWXRaklALp
 Xc3Ci4fD74dCmfhAvduh8yrFJm1xeXUQRidvhgltgbqyfSWCP2ANSzoZpyiwVwqJtG3k0rItyv
 5IdpkbIQGLJmTbD/8AcoVlbcKz3a8K4w+Ow3jF/+/8+RE4Tg+x1DtpZYAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755838557; l=1080;
 i=dima@arista.com; s=20250521; h=from:subject:message-id;
 bh=eoIgmp6rOubH/7RKU/oUjCoxUtaCvNYc3/qZX5mbECY=;
 b=LN8PbXzzYXo4S4BAjItS0hsDu4M1iUFgtaq0ivYwRq/KQGMfYxcckMoR/8bQSr5ja/dWExc7j
 LrLWHLh1eBqD1dpwSAMoDnbBo4SBtVO76wXXTOt9AAOPu21rqKIvVrl
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
Dmitry Safonov (2):
      tcp: Destroy TCP-AO, TCP-MD5 keys in .sk_destruct()
      tcp: Free TCP-AO/TCP-MD5 info/keys without RCU

 net/ipv4/tcp.c           | 18 ++++++++++++++++++
 net/ipv4/tcp_ao.c        |  5 ++---
 net/ipv4/tcp_ipv4.c      | 29 ++---------------------------
 net/ipv4/tcp_minisocks.c | 19 +++++--------------
 4 files changed, 27 insertions(+), 44 deletions(-)
---
base-commit: a7bd72158063740212344fad5d99dcef45bc70d6
change-id: 20250822-b4-tcp-ao-md5-rst-finwait2-e632b4d8f58d

Best regards,
-- 
Dmitry Safonov <dima@arista.com>



