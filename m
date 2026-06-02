Return-Path: <netdev+bounces-294119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKRML2WlHmq3IwAAu9opvQ
	(envelope-from <netdev+bounces-294119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:41:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C4B62BBE9
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6EF26301474E
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B36A3D16F5;
	Tue,  2 Jun 2026 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="cuw2ozGe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QSdqY9Ih"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0EC3D170E
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 09:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393263; cv=none; b=qKyIJayNAmvb4KiHttnlzpYnYD1hNRf0B+/SxBMJZHAq3s6W5LJZOWm5gBsOtrPFr0V6fUOKxzsxORJD5vtOfRTBWQGg+eAvtbtX8by84jjNnWONyQodSrKvTMLqEDUPieA7/+cgll1Y9Du3yXIGnYIZrsKHi53HrP4/0HXkW10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393263; c=relaxed/simple;
	bh=c1uI3/hJh4++FyVIgYxPClG1QwzJQ/KCKW2GXPfYBxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVItJdub8wAiGuESlZ4S7t6iu5RWIgQ6IOkYRI7YO5PfEnaXL0YTMgiQS5HH9E4JxRjRm3euIU4Xnha+nr1iwa5cI8uDuwI6KyP26Ahsrh4uNdUE353KRoj4QeHdeFWiROTuqb6fEXlI8FvQvss+42UgrKph9tMy2n4QwH9M3uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=cuw2ozGe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QSdqY9Ih; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 594847A00FE;
	Tue,  2 Jun 2026 05:41:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 02 Jun 2026 05:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1780393261; x=
	1780479661; bh=2rF5Na5rgiBkDiR351mPeaPE+SomprcW8q+BWbNvlX8=; b=c
	uw2ozGe/8DDn4xTOgFRtqOktpGmo4T4R+GDaNTzo0uK2v5AHdjDnwKkPxaLMaf19
	eipOw70CEGyFOzRunNZhyq826yqzu1hclA2NciECgrHUZ6er/O/VAgOxCKMvkbYi
	HqR2PQaTM/pntDb0qf06UTZeiJhFYJ7f2phyVpp5ADdJHQG70QYKy+ODQ8hchlfk
	iI11dUbhIJWax5v0OABNxJtMC/AjYkM2Vd1hyDNR2DlIN0LKcDbI6UvnHRRlWLpe
	DLFce53+qEFWP7dpf5am+W+iZFpuBEd+ZtRERm1pkWf7Zk6DNT45l5StupVqPmKZ
	NQb7JNpwtT/YtWB4vVZNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780393261; x=1780479661; bh=2
	rF5Na5rgiBkDiR351mPeaPE+SomprcW8q+BWbNvlX8=; b=QSdqY9IhzM/+JZZKl
	anEv0qRDVXRCz0kcj1qvfUEaycj9nN6N6T6nn96OMd+AUUNfy0A8cTbwDq9BS33J
	kINj4QYCRjQw31EF65kfypEHcGhGzO2rUMpisd4/bQ7JXusdCv2Y4s4NzZs07Cpl
	Xc3+KOznI3IRyDBfe0HXmaI94A2Hx1ShhwTlTgP+OMRZnIxluR/lYZsBNt4yHUao
	nOv05Cb29gMn4kXk4sViI1olOj98vzZdt8QEYGH5HUIgeXBO1XqbMcY3EChyjArP
	N1OG6jr/bjBNNGf0tkKz20j5ruJHjGRMBtmXnt5j372DjnPZzxz4CWNrPP/3Hips
	4vCFw==
X-ME-Sender: <xms:LaUeao-d5q9Edmtg1ZmqWpQfCMHCkzuSnFkYVi6vj7NqTm36PmLPkw>
    <xme:LaUeavPNGTihTuccZuUJ7FTwehtTqtWe6yMyfagTOVJ_4USYuIjvUZhRbfj116PTj
    __doLyxBuCzuWsC6wDM3Ie4TaEOvc7GJN-q9wg-v0XTKph9LynR0ac>
X-ME-Received: <xmr:LaUeak0eBR6SU1GOxUQoU3NbImW1qRcZ5bJH11I6dW3n-QevJHKDyjpOwN6nzZjY23eKdhFtMOIYXyl0lMs>
X-ME-Proxy-Cause: dmFkZTFgAK2lNFE13JYOxROxNJ5P/fi7cYLxelEVfjkG3iSnONOF5qVyJrNOPz+7IpRkN0
    qrGkzPljyKRYisptRcnnEYq5nOsZx5iGxG5ZE5tKIWX5gWNzxN8dfd/WVtjkx5fV419Oqx
    UhTG2pdtjXc4NYxt2PwgqpSQFzqCqxgSwFgLvFvji9IEG2hgdEy0jhhnH+31+wRWIALWh/
    9CTBAQn5f5R0jLPkoNDVpuCJ8xUODDlSfCwP0+IdcKnb4ucCYxergBhFS3f8+fZrC57Cpj
    ElQldIoBK/9V44DAEoLWc71SHZST78fkGBOv5Z2cpMx3dtY462lAwCL+f7+qaizht/KLlW
    2FLMeLks/ToQVoBIw+f5bRxggg1aAJXrqc6oGczuoMr7wGqqXAzHILtt0Nzc9F9Atuae7/
    MHrhVZJFU2uSj3Vj9+fka2QxqjHv2wKF6nQve3a/rdkcvMTmKwoBPqTPrF04irEJtrH1dp
    6Odj4z9gqiwi18bS2qzTxO5TNNdlScKBB8QVghiviQR4e5LOpWXnCVvVahuyGcjDRaXjW9
    fj4YgQjsTgPHPJr9CVGaw5Wm83ezk7aNvQp+vYhGHMctX2HdOLnf5S7IuNBNW4cUmXyKft
    L9ew5NaAZAtXfZkY6U8VYVThU5OHYfQe9bZ+agsnfskNJHAGo1aI+BrZX6NQ
X-ME-Proxy: <xmx:LaUeaodgyeelf8mEStlQfwXFpIfNK02of02Ur0BOhb4dO6E2dp7HmA>
    <xmx:LaUealah6nsMrU97C2JMBfUzCtnCLasxuhu5xkrWaHdaZypcjrRcSw>
    <xmx:LaUeatVzWhurJJlhBw8avNjJkMjH3oWDKbUrMPcxwu1gYus2y0dFzw>
    <xmx:LaUeaoS1nUYjCHc4tedsB97Q77hi1eGDYPvANk2Hm3qTEO_x0XvSBg>
    <xmx:LaUeajrWEogauLkJEuy0Gkz4o6b372wyUwj1QgXQl6vDG8PlKItXx91F>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 05:41:00 -0400 (EDT)
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
Subject: [PATCH net-next v6 07/11] udp: Validate UDP length in udp_gro_receive
Date: Tue,  2 Jun 2026 11:39:27 +0200
Message-ID: <20260602093931.516281-8-alice.kernel@fastmail.im>
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
X-Rspamd-Queue-Id: 89C4B62BBE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294119-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isovalent.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,messagingengine.com:dkim,fastmail.im:dkim,fastmail.im:mid]
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

In the previous commit we started using uh->len = 0 as a marker of a GRO
packet bigger than 65536 bytes. To prevent abuse by maliciously crafted
packets, check the length in the UDP header in udp_gro_receive.

Note that a similar check was present in udp_gro_receive_segment, but
not in the UDP socket gro_receive flow. By adding an early check to
udp_gro_receive, the check in udp_gro_receive_segment can be dropped.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/udp_offload.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index f7da760f046f..d5d1dc8d0bb9 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -707,12 +707,8 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 		return NULL;
 	}
 
-	/* Do not deal with padded or malicious packets, sorry ! */
 	ulen = udp_get_len_short(uh);
-	if (ulen <= sizeof(*uh) || ulen != skb_gro_len(skb)) {
-		NAPI_GRO_CB(skb)->flush = 1;
-		return NULL;
-	}
+
 	/* pull encapsulating udp header */
 	skb_gro_pull(skb, sizeof(struct udphdr));
 
@@ -782,8 +778,14 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 	struct sk_buff *p;
 	struct udphdr *uh2;
 	unsigned int off = skb_gro_offset(skb);
+	unsigned int ulen;
 	int flush = 1;
 
+	/* Do not deal with padded or malicious packets, sorry! */
+	ulen = udp_get_len_short(uh);
+	if (ulen <= sizeof(*uh) || ulen != skb_gro_len(skb))
+		goto out;
+
 	/* We can do L4 aggregation only if the packet can't land in a tunnel
 	 * otherwise we could corrupt the inner stream. Detecting such packets
 	 * cannot be foolproof and the aggregation might still happen in some
-- 
2.54.0


