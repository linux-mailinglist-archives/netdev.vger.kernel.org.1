Return-Path: <netdev+bounces-101477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 804128FF07C
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34EF31F23253
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DBB196DAA;
	Thu,  6 Jun 2024 15:18:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94031195B3F
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717687089; cv=none; b=BKqedOrzeQvIm9cYaHaotTEODEkhEplZmZAHJDOTzo06P9LFWnGXsHFh3vQZqY/Kirnv5pRycpzKUij00Uuc+oWNMlpuR6NoFkn8jBZnA/3fYGpO1D6PQN1EZRQJQiD/1MFjni3xpfDXhQLUeNprmYoIDV0mkxf6TpID0Dl8+k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717687089; c=relaxed/simple;
	bh=rG9HzYiiz/OcYPeDBVk/sumkvmK49G0ZUDzKIs0EJ+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gtH3b0L3rvvMpEBQcRUL9syQvBhUEfCRa4LbBPTwvZTC8gZDMDvTfwKSupQvDfSNIb1LejPJ+CvY569qRGBh7s+uE+EFD2IFU3pjajNRGKaCRBNWmGXAxcn/lga1j/wKlTZ2ZfOjHMohC9e2fg0/Rh/7Y0Yf9agekEFA6jNMJ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1sFEsL-0004Bu-86; Thu, 06 Jun 2024 17:18:01 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	bigeasy@linutronix.de,
	vschneid@redhat.com
Subject: [PATCH net-next v8 0/3] net: tcp: un-pin tw timer
Date: Thu,  6 Jun 2024 17:11:36 +0200
Message-ID: <20240606151332.21384-1-fw@strlen.de>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since previous iteration:
 - Patch 1: update a comment, I copied Erics v7 RvB tag.
 - Patch 2: move bh off/on into hashdance_schedule and get rid of
   comment mentioning pinned tw timer.
   I did not copy Erics RvB tag over from v7 because of the change.
 - Patch 3 is unchanged, so I kept Erics RvB tag.

This is v8 of the series where the tw_timer is un-pinned to get rid of
interferences in isolated CPUs setups.

First patch makes necessary preparations, existing code relies on
TIMER_PINNED to avoid races.

Second patch un-pins the TW timer. Could be folded into the first one,
but it might help wrt. bisection.

Third patch is a minor cleanup to move a helper from .h to the only
remaining compilation unit.

Tested with iperf3 and stress-ng socket mode.

Florian Westphal (2):
  net: tcp: un-pin the tw_timer
  tcp: move inet_twsk_schedule helper out of header

Valentin Schneider (1):
  net: tcp/dccp: prepare for tw_timer un-pinning

 include/net/inet_timewait_sock.h | 11 ++----
 net/dccp/minisocks.c             |  9 +----
 net/ipv4/inet_timewait_sock.c    | 63 +++++++++++++++++++++++++++-----
 net/ipv4/tcp_ipv4.c              |  2 +-
 net/ipv4/tcp_minisocks.c         |  9 +----
 5 files changed, 61 insertions(+), 33 deletions(-)

-- 
2.44.2


