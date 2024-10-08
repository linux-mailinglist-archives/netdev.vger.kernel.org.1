Return-Path: <netdev+bounces-133003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9CE99439B
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750B41F24D90
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 09:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7783F54907;
	Tue,  8 Oct 2024 09:03:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C49DF58
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.92.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378204; cv=none; b=mvXT7uifk8OCtdTzzIkN/77zo5n4vq6/rvfupuH9ey3TkcW7iKpICJWmk4dzAJErzNqnA/b7gtaWaIb8FZOqUjaQoM5wR49PNbXCy5dGEDPnl6T0bAwqSw4Y0E3fCvojUw1bsx3lbtnokKjdSkxgi0czwjPB5vA+2o9Hj/tSznQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378204; c=relaxed/simple;
	bh=9cEFyPt9DJqBL7ENXIJBN+KHSq1lU5DBdxAincLgK1U=;
	h=From:To:Cc:Subject:Date:Message-Id; b=iJ45T9NBuNOZHStnFwrieY3sBOP08wEkqTqJnAivY+0fxLEAlcmVGLHb/wq5VzEuTgOOW5n441Cu8GvwFvvATdhrgWArkgFFfuS/YkBwdoP9bkXW+hbZ9HiqUOBFohdAGRQ5dJVJA1Sl/IyuWzSFag6Cr5De0tEsZFDtct5KCAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch; spf=none smtp.mailfrom=sym.noone.org; arc=none smtp.client-ip=178.63.92.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sym.noone.org
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 4XN8wb065Pz3j19w; Tue,  8 Oct 2024 10:54:54 +0200 (CEST)
From: Tobias Klauser <tklauser@distanz.ch>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] ipv6: Remove redundant unlikely()
Date: Tue,  8 Oct 2024 10:54:54 +0200
Message-Id: <20241008085454.8087-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

IS_ERR_OR_NULL() already implies unlikely().

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 net/ipv6/ip6_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 205673179b3c..f7b4608bb316 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -127,7 +127,7 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 	nexthop = rt6_nexthop(dst_rt6_info(dst), daddr);
 	neigh = __ipv6_neigh_lookup_noref(dev, nexthop);
 
-	if (unlikely(IS_ERR_OR_NULL(neigh))) {
+	if (IS_ERR_OR_NULL(neigh)) {
 		if (unlikely(!neigh))
 			neigh = __neigh_create(&nd_tbl, nexthop, dev, false);
 		if (IS_ERR(neigh)) {
-- 
2.43.0


