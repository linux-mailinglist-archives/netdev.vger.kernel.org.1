Return-Path: <netdev+bounces-277451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHXxBKoU2Wm7lwgAu9opvQ
	(envelope-from <netdev+bounces-277451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:18:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 454863D9153
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D60930C315F
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AA53D75D4;
	Fri, 10 Apr 2026 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="NcUpW2cK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W77vvWFa"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F95C3D9045
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833830; cv=none; b=dKElE3LtsrMyY0E3NFj09sbdzmtNDJ1Zwo0MRg0DEcITChR7gbZkiUhU8nukJk4wCEKzwX+XBzv/RRw0N3U3WgsvWpvBNnuFxp1WMj+O5+hYyn6NlryLu8MNMGZNSuzv8nWX1evwUd8wRHbpGzEJAsI6LZEHY7Gxuxw0/m4fOS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833830; c=relaxed/simple;
	bh=yyogxbT3uqjIPJpgPrATyaEUWuKvPKtOJtRblUwskWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orhJrMRf2+T2xEQJFsRc4+VeE4awJOub7Tqvgz70yYMtJoZ2hhSXOubioc+vR53pqlLccaeMPt/nxq0zbMmiDgnJowDrIP2+xUtN8MXsNstcxG3iRF2saKOa4WAPMb0+1SVEHhc3YtPY9Ik7nVo/ngXwWSmiLM/a27QahcgtiL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=NcUpW2cK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W77vvWFa; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6DD60EC03FF;
	Fri, 10 Apr 2026 11:10:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 10 Apr 2026 11:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1775833828; x=
	1775920228; bh=xBnWklu2CitrGSblqUuOa2vd6K+9ZC5Ncr6eMpirYFg=; b=N
	cUpW2cKRJE8Krq3YfeQu042j2pP2eyxrWhUch7CKrj/BHqbqpP2xfbcjSaTvjF8i
	h1ds1yfrko5a1oMTXP97FSVWuLjGGqr1ivyPsyw+vXm1L8KQlOHvi9PKN6aVvLkc
	lllgk6D2F1wPO1ime1Qet75/Pfg0E7jqCsFCwRQZ/djjg1mQKM/c1p6hy8dYQJLP
	u5Mwux23TjUubxoVWlizMNfzGUx0bYDNlh6u5xIxRb86xiFdH7jD64qRpmTS4auN
	716jIkg1FIhBSvFQMdcDISFxlU3gYkflqKmeFVl74Vp1QT3ZI1R8+1nkxoN1KvIK
	hsporgPvn/O3LuXbM5iMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1775833828; x=1775920228; bh=x
	BnWklu2CitrGSblqUuOa2vd6K+9ZC5Ncr6eMpirYFg=; b=W77vvWFapWD7+Bn5X
	D4hB4YIqqhNFZhtTKe0vS8lAErOxNSEdm+UTPvGxsd6hGh37xu3FXmaF1HBCTijW
	qs16orgDZcacm5D1L4jJDkFSJXgwV6aC0yNTuv5uM+S5cItVPn5zKD6cInU1sWTf
	XpiANuWmtBm23VySUy5VOjkK6mTqAdIfU/7DJGzyz8ow+2fH0ipcnEvQW0JR/It/
	erhE2UDQlJvJA9bX9lkblyA1a+VCaiF5OLTi3jrDHA2IyHEUOVvVdomU6jTrFyq9
	5x7ixNFH7k/OqeSojmE9g2u0ogleZRFTzAossr6SVedZzv4a8g1wKViaPDN199XH
	yXKHg==
X-ME-Sender: <xms:5BLZaRGckN1bRXQKY0JGAsO-RFNhcbleLZPdbsHoYu74Qwbwf0iPVA>
    <xme:5BLZaWwsIBRR5TOfhiS5vYgzKRw_z0hw1vvD-z-9DY9jRsbBN_KsA2rVK6X_Fitka
    FUPZUMfRJdIpvpICtmKeQtpArnbBQVQNYkyVyqbLXyN742BQhixBZWy>
X-ME-Received: <xmr:5BLZaS5iD3a6wjZp5LLsYYtMo0Qn3FO3cthb59Md__X0DenhmLPY2VHgz72O0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhhitggvucfo
    ihhkihhthigrnhhskhgruceorghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrih
    hmqeenucggtffrrghtthgvrhhnpeetffeljeefvdfhheeijeelgfekleejveeugeegveet
    hffguefhudffgeekvddttdenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrdhimhdpnhgs
    pghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghnih
    gvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehluhgtihgvnhdrgihinhesghhmrg
    hilhdrtghomhdprhgtphhtthhopeifihhllhgvmhguvggsrhhuihhjnhdrkhgvrhhnvghl
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdrohhrgh
X-ME-Proxy: <xmx:5BLZaTfxu9M1QsNG_r47YuNUmKYQxiIJmEej4rArjT761WoMrIeX1A>
    <xmx:5BLZaREpHC1fM7LCTtQHXKpFwL0Yl9dxfdctYhKC0Kka-3yWZu7dRQ>
    <xmx:5BLZab4hQs9lDlyE-HmSNQGwkgXHGBQQrUtI_f3A-KTK6YApvFDEjw>
    <xmx:5BLZacuZ8pyOiWIei01SHOZ_RyNtgg1BUQp7ufxyLVhDb8DlcR-Q2g>
    <xmx:5BLZaQz-KHBbZCd6BhJUPUda_DtSsT1RJPP6v0JR8mTrJleAZADbPThw>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 11:10:27 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v3 09/12] udp: Set length in UDP header to 0 for big GSO packets
Date: Fri, 10 Apr 2026 18:09:40 +0300
Message-ID: <20260410150943.993350-10-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410150943.993350-1-alice.kernel@fastmail.im>
References: <20260410150943.993350-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-277451-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,isovalent.com:email,fastmail.im:dkim,fastmail.im:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 454863D9153
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alice Mikityanska <alice@isovalent.com>

skb->len may be bigger than 65535 in UDP-based tunnels that have BIG TCP
enabled. If GSO aggregates packets that large, set the length in the UDP
header to 0, so that tcpdump can print such packets properly (treating
them as RFC 2675 jumbograms). Later in the pipeline, __udp_gso_segment
will set uh->len to the size of individual packets.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
---
 net/ipv4/udp_tunnel_core.c | 2 +-
 net/ipv6/ip6_udp_tunnel.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 18f789d9383e..8c586dc08f3b 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -184,7 +184,7 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 
 	uh->dest = dst_port;
 	uh->source = src_port;
-	udp_set_len_short(uh, skb->len);
+	udp_set_len(uh, skb->len);
 
 	memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
 
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index 43e94a3efb26..03c9e55f575e 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -93,7 +93,7 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 	uh->dest = dst_port;
 	uh->source = src_port;
 
-	udp_set_len_short(uh, skb->len);
+	udp_set_len(uh, skb->len);
 
 	skb_dst_set(skb, dst);
 
-- 
2.53.0


