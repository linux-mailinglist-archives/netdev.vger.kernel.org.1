Return-Path: <netdev+bounces-306572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nA9MGSP3UGqf9AIAu9opvQ
	(envelope-from <netdev+bounces-306572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:44:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AB473B5EE
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:44:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm2 header.b="e /NFxyt";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=G4H71bbm;
	dmarc=pass (policy=none) header.from=fastmail.im;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306572-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306572-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 926A53029B35
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0845411668;
	Fri, 10 Jul 2026 13:43:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F0A425CFC
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 13:43:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691007; cv=none; b=OOGsTM/tbJeANfQKY7TJJIQGT83ZHFp2S3qOACpGTKlQYc6j8mqxdnZQMEQ6DnfooH7KMj03h7T3Y9oEF8WDra8XlSLnnl+4r5kQ1+a0iWU8uq3w8o2sRAul/hqPXhF7KUkAbJuDwNXHKm6SuaTLKYnBYUemoY1YiNRvOibCiOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691007; c=relaxed/simple;
	bh=j6RT/OCnC/DPUdMPpCvN5GGj86YCUCrkN6fjx+3ZR2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcjahmRtmNjeDssqAjvJoYBODB8c2H08xZmHtfv59xTrSc+BFrWzBmJDrURxhkUGY6Sb8b354vegkXcIaukNUGQK0XLs4Hy9EbyTrFPVsUYlWs3gDd9b3y8gLp1Fpc0UBsV620l3yBKeRZ+LxznziZvofeEMzIug9irnnjzqI4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=e/NFxyt7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G4H71bbm; arc=none smtp.client-ip=103.168.172.153
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 738B814000F9;
	Fri, 10 Jul 2026 09:43:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 10 Jul 2026 09:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1783691005; x=
	1783777405; bh=c6K0kq2EZDxHltqO02vxX+5vTu4CdfVr+BNdXqjuxCs=; b=e
	/NFxyt7gtCbI57iqSY6DSrKqvvOV/YLNucNrmfRGnBb3hkBKJAjTki0ZKKFVPxlB
	O4GdgzV0FhUxGW/dMyPK+e9EuGrlI6j1b7arS64esz8i5JiXPjP8KLBHwLsndQ6E
	dVbIyAPinV+VRTnnddM3mrYMXw56GYzwBZWL9GgReEBljUwJWyyMYZtewoJDqbJs
	SyAgw7ZPjst0RRxC/JYM11e0w4kGBObiU43drDxyJZR/irDjJV/Fp7nusyBiW9w4
	LbqVTPtxzrKBTjEJ/r3DzjD6lMXLyV8iq6YXutQlc8KUhoUhkcqIcMhP2PYZlvFK
	pkNT6g95TAlMqOI2koArw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783691005; x=1783777405; bh=c
	6K0kq2EZDxHltqO02vxX+5vTu4CdfVr+BNdXqjuxCs=; b=G4H71bbmnPU4EkMWa
	//7HChvd/Zj2HvbazjKXav7nOKQAJJojkh+0hiDUQcp3exazfHvSD9ptNwEJ7eQm
	2g7f/z0wca76HyvuHM+LiTwijzwW0JCYkB21ocCoFJYL4codErJFjhhWr/moytzl
	vWl3gR9x1+2DHjXX2EBYq2XDd9KO58goypDCBVaOYt4YFyfLkNOrg4Fp7FqLVdY8
	WGC+OUAWxkkZb6xRNqkiGXO2sF074T4Mmzs8yz4O6Cl5XtRzlpqCC81HLgFjk2Hj
	fn0Nrh4PSHDiKK5Ma8FX/aDzDOcnEAXm6qCvs08yUPK78O6ShvVxMD7QQNM81uUZ
	6dOGQ==
X-ME-Sender: <xms:_fZQavr_EOeDWTFlvkGb1J6xp13Pr1LLerVGqr79dolnwxl9FlbOlg>
    <xme:_fZQaki1q-QUOwlucguFVmoIQKDszbSb6QRMvI9R7S3WOQkI0ZuwccE17k8qqPEUm
    JUlr5n5hmIokB0RT18qcScooY0_sbrL9h43ZgycrHwRxpvDr--dlA>
X-ME-Received: <xmr:_fZQamYrwQGBDS4gi1UBZwyfeQSo5wFoJuSs4M2NaC8e4kcPDuZGjRu7hD_vHUfIUuv8YpJLnMx_GEz_0kYbOWxIbeKpnm6oVgRlPg>
X-ME-Proxy-Cause: dmFkZTEalHbXeXQ4gMKgDOTqUvoI5XrWkniatliD6pKUEnZKv7P9ZRAGKvAOXyyPK4B3t5
    JgNAuq1gMNWM3F379bjKhQ0kUBfbMQ8moVW/Kn5k1GSeCtL9SmiX/pLFWLF/zBDVs5L500
    21jX/OY8u2eE5HpL+qEZS4uZ6bDFPlRGISx5ovMCW2SJhRd6NWCQ/d3V/iCp/7qK4rBVm/
    7LD5Jn5dncpM1xb8bWzPni8dEuzsWNxMx7Yek06NWQh3v2BfajT0qECUn0HkHvJGbHMFTV
    nsCZ6KoMuiQRTTD++HtzSQ/RCSQVRTML6DOgGPQ04EOeF9Nb73ctUn264opVBKQ2XvLNIT
    nwl7gsboAwTDQHzuEiVv1IZhKZe7ybGn9TT4/bfDN1HZrYOvuZdA9j9EM1lmao7PW52+6T
    04cV9Cj1m3TOplnR2aKrYiHqkuAODUkOSkOmH8dyXJwqQpQUYU4AS3vX6QS1ThCyeJPzU+
    +neWlhrnTp6cJcAKqVhZNrW95kHbSEEbWiDqVEzi3DuCJLTN5v/mELnu9TsapnwzqFPI2o
    ypH6fCzD9wruRZI/kxXSsH0QnKHQgHermGtJbZ3pZHBmkTEMIrqXmwvJZOb6t/WCU9QbTy
    t5w7yvtP1edkkW/A9WZNpyj7kjyMtvZkRWNeNfGBafq166KF0ANsYNiucLGA
X-ME-Proxy: <xmx:_fZQaklcRJII28sPoFtlovC5THP-WGxw2A5aRW9IvZ9T6AicYmSUQg>
    <xmx:_fZQakxfiU-VVoXNIXBCDOp6mZuuhytNOfwSBCwWbbvIRmDxj3P_RA>
    <xmx:_fZQai_h2Olxxdv-9Ij0qYUYLL-_m3AL-scI-ZlrU08rI0yFNaeKWA>
    <xmx:_fZQavDkfXJ2lB89n5AqIfvC6O-huGxBm-yecfQzoJvGgBThtacfgQ>
    <xmx:_fZQalQsGLT_WIeUif0J5Ee5HKZbwqYJeeh7GaYrczcfupccs9Neti1y>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 09:43:24 -0400 (EDT)
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
Subject: [PATCH net-next v9 5/9] udp: Validate UDP length in udp_gro_receive
Date: Fri, 10 Jul 2026 16:42:38 +0300
Message-ID: <20260710134242.216538-6-alice.kernel@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306572-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4AB473B5EE

From: Alice Mikityanska <alice@isovalent.com>

In the previous commit we started using uh->len = 0 as a marker of a GRO
packet bigger than 65536 bytes. Filter out malformed packets coming from
the wire with len=0 at udp_gro_receive to exclude them from GRO.

Note that a similar check was present in udp_gro_receive_segment, but
not in the UDP socket gro_receive flow. By adding an early check to
udp_gro_receive, the check in udp_gro_receive_segment can be dropped.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/udp_offload.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 4f9a3922937c..8f77c8788f6d 100644
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


