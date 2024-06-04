Return-Path: <netdev+bounces-100606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DAB8FB4DC
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959EF1F22C09
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2188A1B809;
	Tue,  4 Jun 2024 14:11:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5ED12B145
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510296; cv=none; b=MjJ6HYq43FonFMEHhJZlcBy9s+uWruA4G/e8NA4a+u8NGHgzQ5h73mHdlv5B7gMs75zjUUCABQwrPwPFoMjW+/+WbAoBZtUBGqHvCBC8PAOL5kqBC54k3lLlikdYLNajSgeGqRf+pg9/+LvpiEvER8Vs/Jer1WVni2SHKZ2b9ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510296; c=relaxed/simple;
	bh=h/4fJyYXCqx+w4llPxEdETxkyuvd+gvDFlmspVTMNGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fAH4Ntdn/Q/wxpgdI88C7LSYdc9q3N/c3Gx8RHTlaEc0uv/70pFxxVse9ZyFQvbsoUHo3KzDuJgpkmMrzYISd31b4o5ChHh/RUmqvnIHJaTNuF1gTZaOLXr2yqG9pfCC9k8VfAGOI2AvY2jEis00OZ8mMAjzna7TXc//X+6YHWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1sEUsp-0002HM-N9; Tue, 04 Jun 2024 16:11:27 +0200
From: Florian Westphal <fw@strlen.de>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	vschneid@redhat.com,
	tglozar@redhat.com,
	bigeasy@linutronix.de,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net-next v7 0/3] net: tcp: un-pin tw timer
Date: Tue,  4 Jun 2024 16:08:46 +0200
Message-ID: <20240604140903.31939-1-fw@strlen.de>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v7 of the series where the tw_timer is un-pinned to get rid of
interferences in isolated CPUs setups.

First patch makes necessary preparations, existing code relies on
TIMER_PINNED to avoid races.

Second patch un-pins the TW timer. Could be folded into the first one,
but it might help wrt. bisection.

Third patch is a minor cleanup to move a helper from .h to the only
remaining compilation unit.

Tested with iperf3 and stress-ng socket mode.

Changes since previous iteration:
 - use timer_shutdown_sync, ehash lock can be released before
 - fix 'ddcp' typo in patch subject

Florian Westphal (2):
  net: tcp: un-pin the tw_timer
  tcp: move inet_twsk_schedule helper out of header

Valentin Schneider (1):
  net: tcp/dccp: prepare for tw_timer un-pinning

 include/net/inet_timewait_sock.h | 11 +++---
 net/dccp/minisocks.c             |  3 +-
 net/ipv4/inet_timewait_sock.c    | 59 +++++++++++++++++++++++++++-----
 net/ipv4/tcp_minisocks.c         |  3 +-
 4 files changed, 57 insertions(+), 19 deletions(-)

-- 
2.44.2


