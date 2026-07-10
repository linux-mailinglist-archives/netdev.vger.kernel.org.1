Return-Path: <netdev+bounces-306569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /XweH+j3UGrC9AIAu9opvQ
	(envelope-from <netdev+bounces-306569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:47:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D061873B649
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:47:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm2 header.b="s KAuGd4";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=Q9YdPoFY;
	dmarc=pass (policy=none) header.from=fastmail.im;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306569-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306569-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B1B43012321
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFD0426D0C;
	Fri, 10 Jul 2026 13:43:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFD542314A
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 13:43:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690998; cv=none; b=lJ7WYbHCn+8FG67rcc1gSFQ37WM/RtxTpaqQvyATliLasudAcYoaUBT4n+vZuX3dJtiSshVp5RqQi/eK3rhWCoC5g+KKoEX6+ujORsWmDoTpFFcm12ZVRNkYPTNMH6rnNuGzH5MsCqt+wPRWWifOEaeUCaFUYaIDsCn3h9GR7sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690998; c=relaxed/simple;
	bh=ZWXbgafIGTz8xu/L99Wf9gJbdEsf4Q7FwDvYQks5ALo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ro5WIMpoxOSG9Ga6wVWjEgoPt3l23n7Qgg21el+2Jk/h31gVMzKIxYC3F6M8jpgrDJQM1tIJPXFp//G1pO6Lr4OPEWXHg9cbcUvdfvkf9rS97+bM84immF7aUkSoJ9b9P9dfzWuxjFBmkgtghTp3gzzzstQn6g+n1nhiX7cX9XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=sKAuGd4s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q9YdPoFY; arc=none smtp.client-ip=103.168.172.148
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B82FEC01CF;
	Fri, 10 Jul 2026 09:43:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 10 Jul 2026 09:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1783690995; x=
	1783777395; bh=NBxc7NjrXRB/RPnGvxFt2oPvmnXmDKIQnsk0vpD0Uls=; b=s
	KAuGd4sUaz0INHHQfOSAW8f/VF/uVFU69BN0xdKk7xt/3mNPLXRsuRepEmfBxLTW
	0NgBeYIHo7Yw7RipPyz+QHDjM/YXzE55WhvK1g5oPBAtB+cfa5dtu0No3HLBNQB/
	V8wD1aOOwTsd6seZc8vN0aAyFUrxwtY/2LA9kv2dg19Ho6gophfmfJJIuV/14lKi
	edxnRVpL9j4g3w6YMwPZhu2KaO/W2mJivUa5t/SAEbXhDDZ0kgE01pQ5GOEY5Xgg
	cI7l5Xsnh5A3Wx6CibhcQ9HgjJ62rQhyMYa8EHqzG6W0yDhJ0BKeEef0NB5z4Vds
	uFu5SAsesuacFeaCySCoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783690995; x=1783777395; bh=N
	Bxc7NjrXRB/RPnGvxFt2oPvmnXmDKIQnsk0vpD0Uls=; b=Q9YdPoFYbfyIjvX85
	nqOz5DBTIh+6XCpAtZInuG9QTO9tY7PkTkyHtHgKrLhcOuD3aKsfVAAteQUCFTFf
	ewYIBSxMjx+Gb0KOiHB6Wdz3vst0hq7QwaPmVOsSfaMoop8QK+hcpqCSzDR7M8Cs
	3ticLRDTaOTh8dxGNx6ECGkJmFk70GgITPM6VcBhkl2saPviRzRTvvOU0uF6Qbue
	0kkVIS8cCA4+XD7hujfp6FA9J5BS44ZH8+FVxx+001aktYBvOAiKngaUSSndqezl
	f4/vTzyg+eTgT9AeNoik0nbIXt67bOdmcrbS+PbjLclnHzUw3yzNgnMYYnTE5wC3
	gJmUQ==
X-ME-Sender: <xms:8_ZQapdngcTwjHWivphnhw5823e0eQGtLGcM_DFFsuUlgcY8XC6QPA>
    <xme:8_ZQaiHhWtV45NwG98L6ycGbRK2axIx0aKAoHxtR00XFfjSZHtHyUbYzZztMHbk_v
    VheUWEmx3_UcXDrYvmthwuBz41z6oVkN-eork3fSpmZPShl0ESZsw>
X-ME-Received: <xmr:8_ZQasvMx3ct7mifBkrAKFNPBbEeSaXlurE0CGowgUP5C0DcJGxdsrWr1LmPo-8I9Ydfq8b-Or7oAhWtwFGFHQwjzcg-YC3dssOJEA>
X-ME-Proxy-Cause: dmFkZTEVFm+PuK8xnTILKnn5BF1WxaOh1NU1c4AWOm+trf7xjxbQVV4Wu/mS84/kbRtIXv
    7rHAtBm8CHEeyrv3AsvyWdvto1dUnam/9BY2K8TY5q7X5K2DLmOFYOafye9ypBbvvbsE/Y
    815j+wouQNbeSKb3fj6Pco6dtynN3Wvj9n+G+FKepS7CNrrV2iLZ0WRdH5ag3dhpPbRrb2
    td8lEMoy9cSYyuzqoACjgQGsVGYmmaE3Vmtt8eTDN6qfQBKrMdgGRpw/x85PmzwpyRyFOg
    fIowvgp/DdcSXxlmG59lbYPsvBRkbElKhM4RsIaBQr5y9owK5Q+nJxV04NvIuJZ6UxdcYV
    xHF09XiyBc/t35M3vf0pvi5DYn/UQnnn1mmzg2siY7jxcaXxGJ4d8PZuGRTddbfmfPx7Kj
    vCA3z1IsDKhYMmQaiZf5Vi7DUagXZc5CMR19vUNgGjRKJkvwcXpvQ5CTj/IJ3zdPYrAwvu
    GJfYzWBf/8gmFp9I48DDsBeOFKS/kKJFntLzG/84haCqn2oQ4PHa4hzklzjER3F/uQRJ2E
    Hl+D+CEHokomq9UowM8kCfZr9sdj9zBfDCU5iXourjh9SWgYHuqKQdhgpldwXDSRd2wvTX
    x7hk3JjmlGN4neFkQ2iJgF586wLKEb7/YPfQOt5c8SWT4IwdSoPSSMRBtsqQ
X-ME-Proxy: <xmx:8_ZQakrSMycSHKe6TAJXbw8lXs5U1hZDKyX4-keai-zxLzmSPlQZsQ>
    <xmx:8_ZQarmDb4SdovTld5Oz6oBWHV9Mr4MvfswZl-JnEMIYYa6T34jVVA>
    <xmx:8_ZQaphRDE9_Kk7y7w56luRRoQK2y0xO9hnpwNpU2XUdwx74oeQaBw>
    <xmx:8_ZQaqUXL299o2nM1AddVhiuFeHdc3t5mxsJZqZKOz17jAiCyCDgdg>
    <xmx:8_ZQajViRf55WfmV7ov-JDYKLXZ9Ec0dcrQWoHIqRnu1Vx1WlUu9bGOI>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 09:43:14 -0400 (EDT)
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
Subject: [PATCH net-next v9 2/9] net: Enable BIG TCP with partial GSO
Date: Fri, 10 Jul 2026 16:42:35 +0300
Message-ID: <20260710134242.216538-3-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710134242.216538-1-alice.kernel@fastmail.im>
References: <20260710134242.216538-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306569-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_SENDER(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[fastmail.im];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lucien.xin@gmail.com,m:willemdebruijn.kernel@gmail.com,m:willemb@google.com,m:dsahern@kernel.org,m:razor@blackwall.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:alice@isovalent.com,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,messagingengine.com:dkim,isovalent.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fastmail.im:from_mime,fastmail.im:dkim,fastmail.im:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D061873B649

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
index 18dabb4e9cfa..6ae4c2b205f2 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4775,6 +4775,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	struct sk_buff *tail = NULL;
 	struct sk_buff *list_skb = skb_shinfo(head_skb)->frag_list;
 	unsigned int mss = skb_shinfo(head_skb)->gso_size;
+	bool gso_by_frags = mss == GSO_BY_FRAGS;
 	unsigned int doffset = head_skb->data - skb_mac_header(head_skb);
 	unsigned int offset = doffset;
 	unsigned int tnl_hlen = skb_tnl_header_len(head_skb);
@@ -4790,7 +4791,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	int nfrags, pos;
 
 	if ((skb_shinfo(head_skb)->gso_type & SKB_GSO_DODGY) &&
-	    mss != GSO_BY_FRAGS && mss != skb_headlen(head_skb)) {
+	    !gso_by_frags && mss != skb_headlen(head_skb)) {
 		struct sk_buff *check_skb;
 
 		for (check_skb = list_skb; check_skb; check_skb = check_skb->next) {
@@ -4818,7 +4819,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	sg = !!(features & NETIF_F_SG);
 	csum = !!can_checksum_protocol(features, proto);
 
-	if (sg && csum && (mss != GSO_BY_FRAGS))  {
+	if (sg && csum && !gso_by_frags)  {
 		if (!(features & NETIF_F_GSO_PARTIAL)) {
 			struct sk_buff *iter;
 			unsigned int frag_len;
@@ -4852,9 +4853,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
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
@@ -4878,7 +4878,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		int hsize;
 		int size;
 
-		if (unlikely(mss == GSO_BY_FRAGS)) {
+		if (unlikely(gso_by_frags)) {
 			len = list_skb->len;
 		} else {
 			len = head_skb->len - offset;
-- 
2.54.0


