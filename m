Return-Path: <netdev+bounces-72872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1405885A045
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 10:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E232824F5
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205CE25569;
	Mon, 19 Feb 2024 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="cQoaWQIb"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C83C28DA4
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336438; cv=none; b=hpFFoSRH0N0cHKCK6/2ll9WxGwYwzr7EhWvNBXL7rtS7vOMQcdtSAync/I3dFXC9sEM7z1n4Y/hD1GlqkZjB0DsJiyaiKn9kJknNyWSJEkOtEakw30sl8wxohdCfEf1RVKUpYM7SRXDC7P1S9N86Ct/V4KHas8BNIjd+Fnr3aQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336438; c=relaxed/simple;
	bh=STrb4clpKyUVleBIdDMYnZz1cjGAJfYxNNndHHSW6sQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mAg5TslAEgTJIObhUyE4Hb+7IgREVxWOk1dJDaG1XrTK058XSTEyBe3Pedx8zAcbRPvpMo4HVXPW3rzY95WiZ3XUu0r0a3MQNu0Cfw3mEwxmxi8h6Q+mE7gKasszVkR7Mzw3wyRsBdg6GrjRIkpMzATOl+FICahNoFGMez+1hL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=cQoaWQIb; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 89B5D203C3; Mon, 19 Feb 2024 17:53:54 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708336434;
	bh=L3zdzD40L8KYsQfay4ouHSREAYN/y5dVWQ1U3BjSl34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cQoaWQIbx+tiUWznb5OY4rhhuA+9/oTIb82P4LmUNz3CbbKY7fZuS8juwQ0Nnm9sK
	 BfKiIou15adh567fJnd7/IzhbykFKG/R2uSGIAtB/wcmeO0Z5s/W2gK+22RZZKrIg4
	 yf1omOhwHCHXCkvQ1+Odi5+kOzCVY5A7CcOIjkq2XPqmBvseJ2Jw8UiztM7CDy4Mex
	 Vz58Dqh8CrzbOInVXx4/9try8sybKL/6KYw8pic00lbGB2UCD2t3KIZmeato9ODIXf
	 udi28QmO1T+zGkpP4q7OrsRNtZuQ1U7JrwETsFYxNuQ4TC6JR1AtLlTC1TIyBmOdYT
	 IG59ENRduQgSA==
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
	Johannes Berg <johannes.berg@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH net-next v2 03/11] net: mctp: make key lookups match the ANY address on either local or peer
Date: Mon, 19 Feb 2024 17:51:48 +0800
Message-Id: <b0bc81c41916f47a4a61cf028a57e0c4a45c2dfc.1708335994.git.jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708335994.git.jk@codeconstruct.com.au>
References: <cover.1708335994.git.jk@codeconstruct.com.au>
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


