Return-Path: <netdev+bounces-100133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0C68D7F12
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9404285BC7
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECFA84D0D;
	Mon,  3 Jun 2024 09:37:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D71484A4C
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407446; cv=none; b=BOIqYSe6IriXFGRwLOdTt5MiPxTQkq+JPnE+8xyDXsd1fAFZlPC5lLEiEXHvpUEXAb9VVulu5ubkyXCSE9KOpWIBDqr0zuvt86Nc3snpQbIwL1iAoT9ejsYRyu6xc5YBrZqp/JpBtEkK72hWfhHgbkhVfD156HCl33pQuT9M/wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407446; c=relaxed/simple;
	bh=jLXL6yoOAXB9948xB5BgPgh9JjDORCujSpegEBlbC6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YBXT+QCeVhbD3gNqfDPqnMOh9ZBHtI+i8+A7KkymM3JKBUWSSGCCjUyq5DysAnpLgiBFzAM5KrCTgkSCd8edtLrJJfwucBqp0ITf2KKaUffuCvm7dHnB2JCpZmRtxmVGLa/Oo+/r+B7AEPhYoiYRh/wWxW1MW1J6uz/+gm3oFqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1sE480-00012Z-6l; Mon, 03 Jun 2024 11:37:20 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	mleitner@redhat.com,
	juri.lelli@redhat.com,
	vschneid@redhat.com,
	tglozar@redhat.com,
	dsahern@kernel.org,
	bigeasy@linutronix.de,
	tglx@linutronix.de
Subject: [PATCH net-next v6 0/3] net: tcp: un-pin tw timer
Date: Mon,  3 Jun 2024 11:36:09 +0200
Message-ID: <20240603093625.4055-1-fw@strlen.de>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v6 of the series where the tw_timer is un-pinned to get rid of
interferences in isolated CPUs setups.

First patch makes necessary preparations, existing code relies on
TIMER_PINNED to avoid races.

Second patch un-pins the TW timer. Could be folded into the first one,
but it might help wrt. bisection.

Third patch is a minor cleanup to move a helper from .h to the only
remaining compilation unit.

Tested with iperf3 and stress-ng socket mode.

Changes since previous iteration:
 - do not use work queues, keep timers as-is
 - use timer_shutdown (can't wait for timer with spinlock held)
 - keep existing tw sk refcount (3)

Florian Westphal (2):
  net: tcp: un-pin the tw_timer
  tcp: move inet_twsk_schedule helper out of header

Valentin Schneider (1):
  net: tcp/dcpp: prepare for tw_timer un-pinning

 include/net/inet_timewait_sock.h | 11 ++---
 net/dccp/minisocks.c             |  3 +-
 net/ipv4/inet_timewait_sock.c    | 81 +++++++++++++++++++++++++++-----
 net/ipv4/tcp_minisocks.c         |  3 +-
 4 files changed, 74 insertions(+), 24 deletions(-)

-- 
2.44.2


