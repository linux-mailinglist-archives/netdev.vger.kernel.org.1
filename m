Return-Path: <netdev+bounces-173917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C74A5C382
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9739189912D
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8867F25D1F2;
	Tue, 11 Mar 2025 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="D9YylamX"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117DA25CC9A
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702418; cv=none; b=Xvhoi6LZ+TPtzwaNnGbVqPbediO3kaOcdDtzjdi4V3f9JUjGoYY+90wvphXWv1vgRcqxHiu25pHN+wuzcVCbDR0LZ8BGmkkmPtndGX2aaKBtkn+/NzJpNuC4FskNB0Oa3m933CgVzggUa+GMHal8CHwdl9mDmpSlDu02PlVP/60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702418; c=relaxed/simple;
	bh=TZhNZUSgh0SiGhDNFT1D+CrgyCwwVbzAHIDSFhkLcpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HCzpbqsDnz1AYpW49LPePgZ1oyR0oa59biKL01uKrv1nqUrirSkEtUCLEADM5vsJY52jLL9CzEMz3VBNEpNc7ttelCrBmlWbJTm4YMkwYKbJ3SUMAh/V/Ziu0k/VK2vktAlUPrEbKvI49ojn7b2wS6z62NS/tPVrv3luDhCStDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=D9YylamX; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (unknown [195.29.54.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id E4CF8200E1C2;
	Tue, 11 Mar 2025 15:13:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be E4CF8200E1C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1741702415;
	bh=nYkGOHYV1F6z3g1saJxEyc+n0CrtFAN174knUMssbPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D9YylamX06F796SrtQEC4f+W1HpK2sPOhsZdziHPoUPji8mFBtDVtOlryWxDPpTUm
	 1NGESUTQzmPWJ5HtIqKUqTBH1yVy5u6lrP0sKrBIpID811Db8Vth8/pqPdGOPzUKTi
	 nOWGksWfNclh4CBmfeUfbDZtqQZf5vX3WYiBv74UgdMR1aBB1BRC7KoesbYJPp5WYr
	 S3MZsqM7xEGK5ut4VX6imMGE4uv5ke1B0m/c1Md5JL8zcI+gcJWl7yugR82Du+rfAJ
	 C1vm4wiHQ4m+zqKDxGG6A3YPHBVGrdb37vinbnCtYD3C+mRVnlvRpO1+/nYEoHup8I
	 /tZIjUnXCb9Wg==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be,
	Tom Herbert <tom@herbertland.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 5/7] net: ipv6: ila: fix lwtunnel_output() loop
Date: Tue, 11 Mar 2025 15:12:36 +0100
Message-Id: <20250311141238.19862-6-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311141238.19862-1-justin.iurman@uliege.be>
References: <20250311141238.19862-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the lwtunnel_output() reentry loop in ila_lwt when the destination
is the same after transformation. Some configurations leading to this
may be considered pathological, but we don't want the kernel to crash
even for these ones.

Fixes: 79ff2fc31e0f ("ila: Cache a route to translated address")
Cc: Tom Herbert <tom@herbertland.com>
Cc: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 net/ipv6/ila/ila_lwt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv6/ila/ila_lwt.c b/net/ipv6/ila/ila_lwt.c
index 7d574f5132e2..67f7c7015693 100644
--- a/net/ipv6/ila/ila_lwt.c
+++ b/net/ipv6/ila/ila_lwt.c
@@ -96,6 +96,14 @@ static int ila_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		}
 	}
 
+	/* avoid lwtunnel_output() reentry loop when destination is the same
+	 * after transformation
+	 */
+	if (orig_dst->lwtstate == dst->lwtstate) {
+		dst_release(dst);
+		return orig_dst->lwtstate->orig_output(net, sk, skb);
+	}
+
 	skb_dst_drop(skb);
 	skb_dst_set(skb, dst);
 	return dst_output(net, sk, skb);
-- 
2.34.1


