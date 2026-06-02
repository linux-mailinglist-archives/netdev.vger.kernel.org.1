Return-Path: <netdev+bounces-294116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNeuI0alHmq3IwAAu9opvQ
	(envelope-from <netdev+bounces-294116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:41:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCBB62BBB4
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C553E3021EC9
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD083D1707;
	Tue,  2 Jun 2026 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="PBpOKY3z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cpsy+oqk"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A653D170B
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393253; cv=none; b=X2TAKJWITIemmcW1N+YFIaZj3bEf8MvMuclF0aW8izESg9r9qUdSlrKCT4Twt1K426/KIYKmUbsAGQb88gjIyD/ix04v3044p/Cwp5dbCWzLQeyzV0n/ChjIWzKFSYHXXLQ6mdBXK+6CM5a5QvDRxHuaGPRxKJH8tWnwDKF05GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393253; c=relaxed/simple;
	bh=xR+lpHEYhtSalS7ICtySUfJ89tlJPbulv8NkQMSaVTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C97gzxmC45Fog0GEgdQFMDWRkMwg0tgleXRringIgfnHF8t2CJzGrBwI8u4sGfCrUixJJ12PADI8xaXr0GjenZk03xwDAyd6myvtHmfj2OKBrNjfAIhl6j40P0f7IWbK8DUGxH1kxvCZiWJFcTHM/ZE/D6zKriE/1/vw5ogWRDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=PBpOKY3z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cpsy+oqk; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 53E617A0066;
	Tue,  2 Jun 2026 05:40:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 02 Jun 2026 05:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1780393251; x=
	1780479651; bh=FLnLn176gGjNiUkZRbkuZMuKaZ1ayJMKeizMGBpsEyY=; b=P
	BpOKY3zl5C720LgSOvSqalAwTKn2RO40LWuM90x7bCnquJNiURPV0PPOiXWtdI/c
	ITR3X+w/vd+aqVl3YikRImcS84xjgprK/FSVlgi+ZGfSThBhA9WgEq5mV6FyEPuH
	tUg0eWfoQNPGzjNM9C2FdWlbnQsgpR6lA2GkyushXZAt30evAbqIZZLZsuSDKZ/o
	BARTF7JzJ9HYUbml7cm3JwYiql5DiHGuXqJ3KUje76UH5pkST1JbW0W43EGGWykJ
	uvWaewLSPz1IFOUPdRG78rcgKO1B65lDJ0ROi/LvGl+QDuydZe1qEynE03g+zzOO
	hIpGchoMD3ZZXXFM3HdNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780393251; x=1780479651; bh=F
	LnLn176gGjNiUkZRbkuZMuKaZ1ayJMKeizMGBpsEyY=; b=Cpsy+oqkw9Mj8v2Ub
	oLpON+09bZH5R+Wj9HKTcdaiU2FIhO5P/GnpyiMv1Ri5gwulBUPDlp85Tg9O+Imi
	TZTweYA0AhQfg+E2W/EbXQmAoCt4n+GgrGY44dArgw2cg8jlmP0Dt+jh5LPHM+bo
	eLKRfYmvhSsMfr/lPvKEq3N2yro1jY1T9nPn5M8QtHj7tgoSLaTJ3pmsgF71zAei
	mpLi6dYPoQ+Fvc5kPseg/ayx2JbO0YKj2z6sIu71sG3t3gnqldkQYmAFxkcYolGL
	A8vUt0W71hntbxgb2q+ofU9SVLts1UCKFWgZq6iaiKuaeJWld5Rkdlp1XqhELWH6
	cRPvg==
X-ME-Sender: <xms:IqUeaoSsRCYqSkZncZxhQmFo_HePXElJb4R7B57JIYIzTNzlv-zOvQ>
    <xme:IqUeakRKcl-6lxWbKxi4Pghq83X4rYuCW0fxDyb-ACJNihkAZLH1qogKTR3pqkRkr
    MjiFkQWBKZ_EVCVkU43boB22nmxHm9aBIB7OacF3RTGdjKuBbNW8wo>
X-ME-Received: <xmr:IqUeasrSDjfVtw_-AlTy-FnNjPPdf-SByLzkwtSHOlYNi8V7hK73YaZv_e8y_vF6991Ss8IfhXTRdchdJoo>
X-ME-Proxy-Cause: dmFkZTE9tBEANdqxv95NqhdHHdXhj1o4AkdIVzwb8jjM1HqleHqSgAphWGPVWdofWa5NaJ
    ER1+bdTKu4iuMySGow/dR0s0eFoVOC/6dTzun6tkdzaeOOWbtEG06zBndcZtwjRhyaEqpS
    LIdhK0NEaayYQ6YzxQmC4sX50yKzwArmaEuiPOivokZV1AkyAlAc9SSPgZ1GnEgo3o6dDk
    bEn0w3Mqi9k2vnkZorhnXwd9uFf0d2PQPwaZiDxl+oi2Y7rHQyMVhjEWYHKl6/Ux+ouroe
    m5aDk5b3HiFHY/885fmPi0ztz+42JdSIp35bNIg/uJarg5ZvUClTXutfFP+vZJrYnhYFNS
    XyAxYLhoPk785Y/lXBU6cj8EhjMLfCrNHAgX7CaRb1DeZS8Z2cr+NZGUOFxun4CyUYyntF
    r0zcvFgN47J4OTe3BYkcoz/5hDMrdLLX+il2gBieV15JDsSjKDIz6COEBsOobTSq7JtLp5
    bftuod8HBOFMO2hq5Dn8oQyaVEd/BaAf0IF+hDGJRD0WGHGJC9FM5SjDEBGWbV1pkdtWeD
    Xrem7VzUkiorMULm73irPxf7awyfayqr8TeYg084ByLlGrcm3GL/AA+yRqk5mEazxrDSss
    7W32e3eAG9bqMiMBwBwm4U9/rWd0dHAALUTp/ZRnFcswpWBRj/7T5RacHeTw
X-ME-Proxy: <xmx:IqUeasCHTxISm5MK29NRsEB35MzrNRcfppDtggVONAkwUMV0088DVg>
    <xmx:IqUeapuK0rS7uEGuMYJSEl3LUWLEof5CKHIOFsex5DKIDJsCrHI41Q>
    <xmx:IqUeajbESJNq-k8e7izNRjzLB7L_7FWcXkfIMBfg-5mHXBc9Bjl8rA>
    <xmx:IqUeatEUuaogmu1z0doQH07ZrgRN-xmiB8LzAW2eF6cdp0crSk0wHQ>
    <xmx:I6UealOWPANdBk0DyJTtiLKv_r9-RGYuF95Y1rTyU_QP_NftoTAvKwK8>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 05:40:50 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v6 04/11] net: Enable BIG TCP with partial GSO
Date: Tue,  2 Jun 2026 11:39:24 +0200
Message-ID: <20260602093931.516281-5-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602093931.516281-1-alice.kernel@fastmail.im>
References: <20260602093931.516281-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2DCBB62BBB4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294116-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.im];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isovalent.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,messagingengine.com:dkim,fastmail.im:dkim,fastmail.im:mid]
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

skb_segment is called for partial GSO, when netif_needs_gso returns true
in validate_xmit_skb. Partial GSO is needed, for example, when
segmentation of tunneled traffic is offloaded to a NIC that only
supports inner checksum offload.

Currently, skb_segment clamps the segment length to 65534 bytes, because
gso_size == 65535 is a special value GSO_BY_FRAGS, and we don't want
to accidentally assign mss = 65535, as it would fall into the
GSO_BY_FRAGS check further in the function.

This implementation, however, artificially blocks len > 65534, which is
possible since the introduction of BIG TCP. To allow bigger lengths and
avoid resegmentation of BIG TCP packets, store the gso_by_frags flag in
the beginning and don't use a special value of mss for this purpose
after mss was modified.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/core/skbuff.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index c64693fcb2d1..5dcee79df8cf 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4773,6 +4773,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	struct sk_buff *tail = NULL;
 	struct sk_buff *list_skb = skb_shinfo(head_skb)->frag_list;
 	unsigned int mss = skb_shinfo(head_skb)->gso_size;
+	bool gso_by_frags = mss == GSO_BY_FRAGS;
 	unsigned int doffset = head_skb->data - skb_mac_header(head_skb);
 	unsigned int offset = doffset;
 	unsigned int tnl_hlen = skb_tnl_header_len(head_skb);
@@ -4788,7 +4789,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	int nfrags, pos;
 
 	if ((skb_shinfo(head_skb)->gso_type & SKB_GSO_DODGY) &&
-	    mss != GSO_BY_FRAGS && mss != skb_headlen(head_skb)) {
+	    !gso_by_frags && mss != skb_headlen(head_skb)) {
 		struct sk_buff *check_skb;
 
 		for (check_skb = list_skb; check_skb; check_skb = check_skb->next) {
@@ -4816,7 +4817,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	sg = !!(features & NETIF_F_SG);
 	csum = !!can_checksum_protocol(features, proto);
 
-	if (sg && csum && (mss != GSO_BY_FRAGS))  {
+	if (sg && csum && !gso_by_frags)  {
 		if (!(features & NETIF_F_GSO_PARTIAL)) {
 			struct sk_buff *iter;
 			unsigned int frag_len;
@@ -4850,9 +4851,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		/* GSO partial only requires that we trim off any excess that
 		 * doesn't fit into an MSS sized block, so take care of that
 		 * now.
-		 * Cap len to not accidentally hit GSO_BY_FRAGS.
 		 */
-		partial_segs = min(len, GSO_BY_FRAGS - 1) / mss;
+		partial_segs = len / mss;
 		if (partial_segs > 1)
 			mss *= partial_segs;
 		else
@@ -4876,7 +4876,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		int hsize;
 		int size;
 
-		if (unlikely(mss == GSO_BY_FRAGS)) {
+		if (unlikely(gso_by_frags)) {
 			len = list_skb->len;
 		} else {
 			len = head_skb->len - offset;
-- 
2.54.0


