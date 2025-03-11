Return-Path: <netdev+bounces-173913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C8DA5C36B
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84DDE167C32
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841C125BAA6;
	Tue, 11 Mar 2025 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="DYSnrtWD"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6F825B669
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702393; cv=none; b=CRCs01fRbw5s1ZHr7MLqtYQ5pDWPETWR3INuPSVdu1ddWL74p996NpBFb+sEfNWwvDo+bP3np2klEaDJaX2U71Kss4+rvflS04njnyZt/8GcaDhwLtA8Sk8RQIkUWL8CGyLbnqg3ykiUfmxf9St09o9AtdPoftQ8I6Q3M6pV6Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702393; c=relaxed/simple;
	bh=7lGqBClSSjyfxt8qcHmSGKs2y62wqql2e+bX2Acp64k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m6qJj3VSMLMTh9QfR0HILoEML9iMSkQrFzF9mWo5JCtTu3N64cF82PIx3OzngR6qdN5CtUwtlZfnUIQY1q7a5bUfUxLkrBP0TfrrTHVKQBOEstExEj01Y8Ip2PkvHaP8VAia56gYFY5WpKb6rTJmRS+CmNA45NfGVPIA1bbcHYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=DYSnrtWD; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (unknown [195.29.54.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id C1FE6200E1C5;
	Tue, 11 Mar 2025 15:13:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be C1FE6200E1C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1741702389;
	bh=fhPTJcnJhGaIdlNdiWlJmdxebAZMfi41h3DDJqCYoTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DYSnrtWD9XIGdwpBI2Lj77UObuCdacsDtQaagpCAaWLihpv0CEpYTN1xh5G1Mtucl
	 2PFxfp2Uo1bim3ivoR9VekQ9Tb9ypY+g/4XbIUc2o9QT5snFPpbr53hdv16ntJmybS
	 ldM3Y+JSYAfmmov7HQel90mhhSmrCamlWSZidGTRKMi8gywNCE8TpwxtrMsjKO6PBR
	 yTBGp/GQx2GXx1hiO2DYWJS4txPdMWn7OVJhA3F5LtuMKosqXzD38XqrLKsPRHVjHX
	 67UPKngw+5axHzxxbmWB9fqGqjquStjUCpuSf8GABpyOz23vdVVrhNSHmDgfVIy55B
	 1ufOFhVZDk8Qg==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 1/7] net: ipv6: ioam6: fix lwtunnel_output() loop
Date: Tue, 11 Mar 2025 15:12:32 +0100
Message-Id: <20250311141238.19862-2-justin.iurman@uliege.be>
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

Fix the lwtunnel_output() reentry loop in ioam6_iptunnel when the
destination is the same after transformation. Note that a check on the
destination address was already performed, but it was not enough.

Fixes: 8cb3bf8bff3c ("ipv6: ioam: Add support for the ip6ip6 encapsulation")
Cc: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 net/ipv6/ioam6_iptunnel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index 2c383c12a431..9d7a9be9a4d0 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -337,7 +337,6 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct dst_entry *dst = skb_dst(skb), *cache_dst = NULL;
-	struct in6_addr orig_daddr;
 	struct ioam6_lwt *ilwt;
 	int err = -EINVAL;
 	u32 pkt_cnt;
@@ -352,8 +351,6 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	if (pkt_cnt % ilwt->freq.n >= ilwt->freq.k)
 		goto out;
 
-	orig_daddr = ipv6_hdr(skb)->daddr;
-
 	local_bh_disable();
 	cache_dst = dst_cache_get(&ilwt->cache);
 	local_bh_enable();
@@ -422,7 +419,10 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			goto drop;
 	}
 
-	if (!ipv6_addr_equal(&orig_daddr, &ipv6_hdr(skb)->daddr)) {
+	/* avoid lwtunnel_output() reentry loop when destination is the same
+	 * after transformation
+	 */
+	if (dst->lwtstate != cache_dst->lwtstate) {
 		skb_dst_drop(skb);
 		skb_dst_set(skb, cache_dst);
 		return dst_output(net, sk, skb);
-- 
2.34.1


