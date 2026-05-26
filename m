Return-Path: <netdev+bounces-291811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IcHNQTIFWpNbQcAu9opvQ
	(envelope-from <netdev+bounces-291811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:19:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8123A5D98AA
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A75B304DAA0
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDCE3AFAE0;
	Tue, 26 May 2026 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="hx6g9JPI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XIi6dPOT"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1EB3AF66D
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812010; cv=none; b=YzfYleXgpcyEVYn0IjJzb0eaW8S5XS4XUcXx/lHba4SS8grUbZC7SMnxfgZmi4NOG/0BzMX75Uu5AUKapCH4raDmbb0YP6Vgb+0O4hUShaooV7VITNm8zRi/VLQbgvUEIjq7VgzJs0mgL3cvLXvr1eb8yiSX75NKdcCfe31LRfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812010; c=relaxed/simple;
	bh=c1uI3/hJh4++FyVIgYxPClG1QwzJQ/KCKW2GXPfYBxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=peBaaCmt0/iZppopwMhf+6yn8ji9NzjnRi1RHyD9T8hWTnJXKgfUzW3eSLISyySMsN4tWDEm69E/XYJK1r/sFWDS9MxE0ulr7VG/+3aQ/yF4+XWld3/Y6xAbjpql55VjP7QzvFQbXmhGOdZz/wvmKrUBbWM0j9Om6YyZlgcLTnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=hx6g9JPI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XIi6dPOT; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2699A7A00B0;
	Tue, 26 May 2026 12:13:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 26 May 2026 12:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1779812008; x=
	1779898408; bh=2rF5Na5rgiBkDiR351mPeaPE+SomprcW8q+BWbNvlX8=; b=h
	x6g9JPINEbX6ccKNnPh+M1fpU+0QAeJtjc/V21GGNXlZeKYNHFm+NKXVq+DMov4I
	ZoKCkMoZCz/3+U52FMQWbmXNiOc1PFy8IhwPi5aO9V4JJNLt4Zz7JGin+Uv3x0Nu
	9EwlBEN20OdS6RX3BdRXSdQmmS5HtSveqPsmxWjF3Hsh97JvKpafE2e6g5nGYo/s
	XDEcI7Ky7/eit34DHTsIFBH1kWFenydG3QGHpKIES4iloWgDtOHR6KmTXdMiQ+yy
	jZqjGTbkyH7dAVxGWzWHu+Pe579PJ0pPec1q8ez36R7zx8NqRHiLOJOzWc/JSj7B
	+/QohnJWLoloka22msQ2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779812008; x=1779898408; bh=2
	rF5Na5rgiBkDiR351mPeaPE+SomprcW8q+BWbNvlX8=; b=XIi6dPOTfvCCHt3iP
	zCG/cyMaGPDMVONhhlXGoEYeU+yBxVq5uUTLmNjgoUea6Hnd+EQZTPqN59/nzFs0
	s2ziGPkk7fyRGdLqfdHWTeYpInBj47mkbyXE3Azsbye5flQSoWRL/g/uIs+1RNkP
	SVpCbgcEOle2FEeJ0xd18aWmZga0TVSKhUwrMZGm/QEbQJCcNkpkWlFYWf+t834F
	Fl8ks35yXev4KO/UMFYR/z3VTtuq/FQ4SJSC4dsK5vJPyzxvPCYQde3GtvCRcfYH
	OMOZhWqffNNcFbUwnvLbyG8OTATR2Cx3xHxB94iEpfEhn3sBqbt5Kh36Pv3pesnT
	IGnLQ==
X-ME-Sender: <xms:p8YVakCa3RpLXmkeYKU8ReQ4TBNVxjSJPdTWLlsHgySCJQcpe-_CQw>
    <xme:p8YValBrdhvNhp94qCFRPlflo18ggGAxwca62ecocC5qKf5_-a33Om16oc0ZtwkuQ
    QucQRcvxj0Er3xZqGB9m2qAO_kxSwXEzEvZgh-cx-dlQ8lHQQuXupU>
X-ME-Received: <xmr:p8YVauaskdn7bP6MYgkMACuHCLndAXbSRy2fxy-yBQw3ekCuFxiPXcM8QgpBQ3Cqi1X6r5CpnnmVoft0DTDTVoGv8XcVSOL8GVT3UQ>
X-ME-Proxy-Cause: dmFkZTFnubMirKk9b4RGiHINJSMkuDl5fdQMcSQrbjTnrEtnGRMO7NVlHgNvLrqEHtJaN8
    zpme+woGZxyKdNU3k7TnRxVQwEyBx89uwS84rOHfufneeMmb8fdcUI2cZ94NrKEcO2l1Ev
    HGrlmYmgeo6wr1A/KvJn0aSPKAaKFYZM+3+ZUS7Tu2EvZqdW3lsl0cdGaP4XgQhsThVuL4
    KbDr7a72qraJQV2+AdF/NUhvZF/7S5BtzFYI4JH/Pa4gofZUZmcBbcRdxJ0P7hUg8tJ5CV
    07j4MHl4GAr08BQR6utb+RZkIK0dSIaHfOIubO27bhpgov0tN2bww3ysIkLzfrH9GzbeoK
    bd+ctBGO1XDgUC4DpzmuyHYyn8AOrJiuyc26CUOLB+NxtXlaGRCXF2UV1bDU0vY4PUPyDG
    +7daqmGrIENX9ARg3/c0AtLfq9Vhr2QwPydlLM0U7SSNAO197NFd66joWrpAoEQFURmbqJ
    ybrBDPEzW6TQVVEXYH6KCeGoKZexnE+oU/cKTzVq8Y39K+55EKphLuDTcsOtJkdELeN1Ji
    Ku6jTgXylUZXxKjjic0jXmluha/DUQIVW82E1H4JT2NaySBiZNsdoYTfDLafyf9jS9E2LU
    dzXp3m6tV+Yzy+OIMjaNiAIKKvKkluJ4xtkeRgffYBYkJ5XD4r5gscKDrjqw
X-ME-Proxy: <xmx:p8YVaqyNyy3byd4mb93wzQB-V2SNyy5v4qWi3aThjA1lIFWH6H7F0w>
    <xmx:p8YVahcYg_MWNsnYy_JV-lrW5cqqAAubq0PSl20thlJ4OD4mgxn42w>
    <xmx:p8YVagJq4tluUhlzsU163g05kX01eGkpAKDP9JA2EdQF7cByo2s10Q>
    <xmx:p8YVaq30KYVsArLsV68KV_wZDtweCyZnONvur-aU-JiSb-tMyBmcNg>
    <xmx:qMYVar_evXZ9ToC7fzugqNLDMnu2cIXzCFwd-qzUotlpHCm_TCqtNplS>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 12:13:27 -0400 (EDT)
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
Subject: [PATCH net-next v5 07/11] udp: Validate UDP length in udp_gro_receive
Date: Tue, 26 May 2026 18:11:56 +0200
Message-ID: <20260526161200.1135899-8-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526161200.1135899-1-alice.kernel@fastmail.im>
References: <20260526161200.1135899-1-alice.kernel@fastmail.im>
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
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-291811-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	NEURAL_HAM(-0.00)[-0.987];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fastmail.im:mid,fastmail.im:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,messagingengine.com:dkim,isovalent.com:email]
X-Rspamd-Queue-Id: 8123A5D98AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


