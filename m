Return-Path: <netdev+bounces-305191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 30tlCuIETGqJewEAu9opvQ
	(envelope-from <netdev+bounces-305191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:41:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB9E715190
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:41:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm2 header.b="m XQWa+x";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=aZoUvG60;
	dmarc=pass (policy=none) header.from=fastmail.im;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305191-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305191-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C85FA316680F
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 18:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7626436BEE;
	Mon,  6 Jul 2026 18:21:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E37437846
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 18:21:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362070; cv=none; b=ffy215RcnTjbZD0D+vJPv+PKcT7rmDkOmMZln5dlL5F2HfHESBLx1WANhLp6/XKljgbBAu9a6TCDkNFBJyDOe9EzWuPQcPgvdreJ4ruZE7CXaPC+DZ1nZM97lM5YLDh9k6gdGXx1jXT+WtNhYiZpFF5Oeg3CkTFDK5RPIzsnOfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362070; c=relaxed/simple;
	bh=NfyjXcXPVZPF7w6Bcme5G+ASurpWWQTb1BYBNJKEMuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEVhkkNLOJTi02OR/yeMr9JqFPumLmxAiC8iIEUeBqNuN0Jfo0Jz0B+2QRzcQ6Abj2V0Jw/NC7ux5F+UJWXAQhRADc2YfvGBkze1RQqAtc0gKU6TTtrX5xKaTE1U8sUCzqFIfsjS+actGZ5xTrpdWN2rzFbjjy5M5qQCzgxRk88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=mXQWa+xy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aZoUvG60; arc=none smtp.client-ip=103.168.172.152
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D71AA140013E;
	Mon,  6 Jul 2026 14:21:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 06 Jul 2026 14:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1783362067; x=
	1783448467; bh=q45lDLMJsqLmY/ucK1IYEGTdKCA/4/17rWNxl6f9Ca0=; b=m
	XQWa+xy3zRE1am0EHMq+Hi1A5oXjJ2ZRDpXnHB1j3QeLL2Zq0931OTyaZteXx9F5
	R/ECkk7wWVL5Wv3cGv5tKAO50gY66Q05/2RgKzH2J5n+kFV+aiX1eVONj7dl0Fvc
	jQD9dUCd/yNA7RuhcWD6xHm3g5yGAVawMbLBS1zvzCZ63uEFmvGbwB2WiJcA+5Jx
	4aEAPPyrOQzDZNqW3Dz04z/QRonX/2d/u0GN4Wo21u5Qy5ff94eL9xzsBHbzMyeo
	WmzjXVyEnHwPZTpW1Kx0QVUpO/9K33YIWA6GrJ87XmPrPNQ4NnFo97h6NKkJI7+E
	E3i3LRdoEASSAVuD4Ut8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783362067; x=1783448467; bh=q
	45lDLMJsqLmY/ucK1IYEGTdKCA/4/17rWNxl6f9Ca0=; b=aZoUvG60ofygxdfK6
	xfXw8lRXvWxKvuWXL9KESBqy+WFz7I1BOWMV9k8TdH+wMJgHw+QXwqHhAOvVC5b8
	twtaREfhJrlbVInhTLxcy2Eh85hzssxqUnXYXU5fNnoxurixxdIqsY+zUE9wy6FK
	2KehoApuQrJ1yV1fs+N2HJNoseoy7UxviEY5ysf27GO/BXP2XsnQn/C+AlgskpPr
	5Oes+FNDWdRw8lKgvWv7TTcA/SSBK3POIZLN4vXlmoyagjXZRNm89MUzHy9QYhKU
	t9PHf6wZ2Rr8j73J22bQBS8pIdighWSckxnLwQdX4YYhQ8U14bwhVTa/HEg6Qsc1
	VVWpQ==
X-ME-Sender: <xms:E_JLavDg_0MZKYO0hL-6XoeMoAQJi1t6NvRU8OwxVOJu4_38tXf9sw>
    <xme:E_JLakCk0DSWVTsN9G-Kh8jHsshqIYQMz3OakRGPQ7HIKCDoWu_c04NvIgiGS4t18
    SMds33qj69EsJsjKzoCZli_UkDFfQoxgQEafBFNgd6cUjliljhuzQbi>
X-ME-Received: <xmr:E_JLahaLY1GUmVpD5pv79Y4D11n5MHIW6jGweXZxU2uP3gUeBURhsj2NXGY>
X-ME-Proxy-Cause: dmFkZTGUsUpJpDFa5ndE4N6eTKB/j2d4JsSbrhMs8kmEW2L9QK3N/6TXxA5y7ulUoXm7BP
    89asODAMfT3OBvY/M09D0GqR/9f8fV5gBQIGHO+HJK2v+bCFZ6PfrlSqdRObcl1ifowHpG
    tdD7vyUPEgwFuODXXuYyDriQ176ee08aLqbCrephkwOmUEbVwxNtxJmLaLFJpQP96s58mK
    npPwdvdZvXzqtDhxT3KN6NVuVc++tCiI8YGn0XKi84DG+Ojy+uujNScslpd1sVLQiZ4Ias
    tnSVjmdR3/qyqDiPkegvX2kZQRuflV0jlrEpRX03LLhuj7//XS63UPEDz3jVugM+iYgwS2
    D4BtJl5w1f3M5GPbO3xu1jxbL27dOS6pnVc739h8KcgrdSut4vRfN4xAQ8OQE+Jvy+lKVB
    6UJuoexv0xdnP8CvwxfzK5+biBXB2gq6ygYHqabaA6EvGNDNANh22+Sw9ydrTj78vwzNcj
    oRVKxvsrtqzEw1TRWVfTfNUIeSBLN1khJfQXGoZpfHNMlXGRagAsYI5z/Tpth1I11zZPS6
    BeGLfMPpLcr9YILj3cs+fBGg5bbZy6aPErWD4kLB/aIvFRUtvdi1MVdOBiEr1kusyBuxMv
    G1NCzgm0aBZU9heIh8ghVsoeISyToedWz86UWxS6CLjpttQNWZiS0rxkYSgg
X-ME-Proxy: <xmx:E_JLahxIBjQM8hiHUl0qR6SLynU-Z9VlVvoFBVbilc5COY4xbY7INg>
    <xmx:E_JLascZRV2rfnhVXAjoRaF4k6Z8WicH4KMJU_CtpHLX1ewNc-GIQA>
    <xmx:E_JLavJBQV3O9-yXrfpuNEZ2rtvDzoW09tgxLdg0PifgYU9zHFLmKg>
    <xmx:E_JLat2FzdtYPsk2MvtE1DtCMEjk6qSXRVLtTx3yxhyEdsqkp4GK0A>
    <xmx:E_JLahI6aG8JHFSYeLJUGfAZwml36ddeVrOlMA6IzYFMAxORVgHyrO4_>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 14:21:06 -0400 (EDT)
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
Subject: [PATCH net-next v8 6/9] udp: Set length in UDP header to 0 for big GSO packets
Date: Mon,  6 Jul 2026 21:19:38 +0300
Message-ID: <20260706181941.385672-7-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706181941.385672-1-alice.kernel@fastmail.im>
References: <20260706181941.385672-1-alice.kernel@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305191-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,messagingengine.com:dkim,isovalent.com:email,fastmail.im:from_mime,fastmail.im:dkim,fastmail.im:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2DB9E715190

From: Alice Mikityanska <alice@isovalent.com>

skb->len may be bigger than 65535 in UDP-based tunnels that have BIG TCP
enabled. If GSO aggregates packets that large, set the length in the UDP
header to 0, so that tcpdump can print such packets properly (treating
them as RFC 2675 jumbograms). Later in the pipeline, __udp_gso_segment
will set uh->len to the size of individual packets.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/udp_tunnel_core.c | 2 +-
 net/ipv6/ip6_udp_tunnel.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 0fccb38f074d..a128fe85620d 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -178,7 +178,7 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 
 	uh->dest = dst_port;
 	uh->source = src_port;
-	udp_set_len_short(uh, skb->len);
+	udp_set_len(uh, skb->len);
 
 	memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
 
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index dcff7fb16ff6..32525a051a6f 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -93,7 +93,7 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 	uh->dest = dst_port;
 	uh->source = src_port;
 
-	udp_set_len_short(uh, skb->len);
+	udp_set_len(uh, skb->len);
 
 	skb_dst_set(skb, dst);
 
-- 
2.54.0


