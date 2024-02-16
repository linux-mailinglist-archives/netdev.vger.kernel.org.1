Return-Path: <netdev+bounces-72294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8434885778A
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 09:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BAE1C210FE
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 08:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDC21C6AE;
	Fri, 16 Feb 2024 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="awv4M20e"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DD31C695
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 08:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071582; cv=none; b=p2MOoIr4EJx6w9k1PaS9JdjrJLdpjjhi4C7HBq+yPNh1Eq1TcP+SJ5UxrgRJHH02Z34nT22fE1HDi045j4H80ZevWaK/jZ1dzkBrMiZB5Gykd138g4kapSGr/dIH8K8dMVYCFM3gcRlw9uOmqQVu7O41EGxCQ8ibE5GteK9nPfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071582; c=relaxed/simple;
	bh=STrb4clpKyUVleBIdDMYnZz1cjGAJfYxNNndHHSW6sQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SFj4AOGP3nT9zgeesFjqTNFiJSA1fDLRku+9hsG31ZzqFAZ6I3XErDnO34ZHuW8EL15nXrLBz0Tr7YIexCWCQg4bXB3byORlLcs2TC8mHGtAiUicc9v/cNmFAolzbxciLaO5C4ngkSHKi5AzBFpLU014rMmSjNhAvVqYBvWUUMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=awv4M20e; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id E751A203BF; Fri, 16 Feb 2024 16:19:32 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708071572;
	bh=L3zdzD40L8KYsQfay4ouHSREAYN/y5dVWQ1U3BjSl34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=awv4M20eXJOo7qhQYVvrt1CVaBLmip/kFADERmn6pLUWSwKbe0AxsGB9GkA28+Ikq
	 QKJCjjjzj+SwgTrr3JCNJEUIlkcKfjdEXrEM8tcksWTvgn50rE3m5ASVJKtiiSHysH
	 w2Mne5y2elqYwiuC4DbxA4z6mdbHlwz9G4QOBXG0OuGBoWWT8doapCAX5hDvMTnTUK
	 pen8iyIZwbIzS0YOHikanfJYn+HpeVyQtQAsHf2yUF/bACft3khvirUuaVGRvWR+Us
	 g5fIRlFGPu4Lpt2xIfxlKGtwO2Q24yHH3IVQ9YtQJJWR68mLu22cJjxNw07e8W38cV
	 cYQ0xLwFVBp9w==
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: netdev@vger.kernel.org
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Liang Chen <liangchen.linux@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH net-next 03/11] net: mctp: make key lookups match the ANY address on either local or peer
Date: Fri, 16 Feb 2024 16:19:13 +0800
Message-Id: <b0bc81c41916f47a4a61cf028a57e0c4a45c2dfc.1708071380.git.jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708071380.git.jk@codeconstruct.com.au>
References: <cover.1708071380.git.jk@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We may have an ANY address in either the local or peer address of a
sk_key, and may want to match on an incoming daddr or saddr being ANY.

Do this by altering the conflicting-tag lookup to also accept ANY as
the local/peer address.

We don't want mctp_address_matches to match on the requested EID being
ANY, as that is a specific lookup case on packet input.

Reported-by: Eric Chuang <echuang@google.com>
Reported-by: Anthony <anthonyhkf@google.com>
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/route.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index 95f59508543b..b7ec64cd8b40 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -113,7 +113,7 @@ static bool mctp_key_match(struct mctp_sk_key *key, mctp_eid_t local,
 	if (!mctp_address_matches(key->local_addr, local))
 		return false;
 
-	if (key->peer_addr != peer)
+	if (!mctp_address_matches(key->peer_addr, peer))
 		return false;
 
 	if (key->tag != tag)
@@ -672,8 +672,16 @@ struct mctp_sk_key *mctp_alloc_local_tag(struct mctp_sock *msk,
 		if (tmp->tag & MCTP_HDR_FLAG_TO)
 			continue;
 
-		if (!(mctp_address_matches(tmp->peer_addr, peer) &&
-		      mctp_address_matches(tmp->local_addr, local)))
+		/* Since we're avoiding conflicting entries, match peer and
+		 * local addresses, including with a wildcard on ANY. See
+		 * 'A note on key allocations' for background.
+		 */
+		if (peer != MCTP_ADDR_ANY &&
+		    !mctp_address_matches(tmp->peer_addr, peer))
+			continue;
+
+		if (local != MCTP_ADDR_ANY &&
+		    !mctp_address_matches(tmp->local_addr, local))
 			continue;
 
 		spin_lock(&tmp->lock);
-- 
2.39.2


