Return-Path: <netdev+bounces-100609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DF88FB504
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16DF1B2306D
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D4384DE2;
	Tue,  4 Jun 2024 14:11:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C5312BE81
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510304; cv=none; b=ECmaquiaQzpeN3PL43FkWtCN6x1YeyINX/8WuDD/eHWX/z/m4j5Opdub/MUbZ8ZbXffpmjSDX27/J4enogkfavwPDcPGBpQRWL0hIVYqX5+FsbQMOcjF2RlyLZJ1kQC8YuNgl0EQ1gSkPklYyZy+JL3Hbgok3OESmWdTxdUH7YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510304; c=relaxed/simple;
	bh=Qh4LK2nCBtAtVu/R3Oe/PnJOwdp6utQ9IsGP3nAUwUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ku8aPJssSQGe/ckFjCq05Xr2MQfTkOPPx4XV1PT7n4Di+UMbk4vHXfWrxQUPWSQSIZWUCauOEJP1oAVaMZ5g+DAugxC/9HNsA6s1IKiQ3xaJugyFMZVAD05y/14QOcfCTRu4hz2Nm1jQTFxZ7QovKSkrc7AruNSJyWv7Z2k/kQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1sEUt1-0002I6-Um; Tue, 04 Jun 2024 16:11:39 +0200
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
Subject: [PATCH net-next v7 3/3] tcp: move inet_twsk_schedule helper out of header
Date: Tue,  4 Jun 2024 16:08:49 +0200
Message-ID: <20240604140903.31939-4-fw@strlen.de>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240604140903.31939-1-fw@strlen.de>
References: <20240604140903.31939-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Its no longer used outside inet_timewait_sock.c, so move it there.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 no changes.

 include/net/inet_timewait_sock.h | 5 -----
 net/ipv4/inet_timewait_sock.c    | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index 5b43d220243d..f88b68269012 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -101,11 +101,6 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
 void __inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo,
 			  bool rearm);
 
-static inline void inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo)
-{
-	__inet_twsk_schedule(tw, timeo, false);
-}
-
 static inline void inet_twsk_reschedule(struct inet_timewait_sock *tw, int timeo)
 {
 	__inet_twsk_schedule(tw, timeo, true);
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 3e89b927ee61..a70a3a16eea0 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -92,6 +92,11 @@ static void inet_twsk_add_node_rcu(struct inet_timewait_sock *tw,
 	hlist_nulls_add_head_rcu(&tw->tw_node, list);
 }
 
+static void inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo)
+{
+	__inet_twsk_schedule(tw, timeo, false);
+}
+
 /*
  * Enter the time wait state. This is called with locally disabled BH.
  * Essentially we whip up a timewait bucket, copy the relevant info into it
-- 
2.44.2


