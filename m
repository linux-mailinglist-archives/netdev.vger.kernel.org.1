Return-Path: <netdev+bounces-257903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEOjBp2NiWnP+gQAu9opvQ
	(envelope-from <netdev+bounces-257903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 08:32:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 699C510C796
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 08:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E50330125DC
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 07:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF41320CA3;
	Mon,  9 Feb 2026 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="AL7P0Sau"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A123331B810
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770622071; cv=none; b=Y0QEFnsQI2ESa/7JWWQmzHcmCLkzeG/dKwhp1Fv3wC7l8mEEc1eGiIGQCvIjYypIeLkJN9qQbIR6o/lxUejEM6VNOLPph4U1hD+PUnop6KdxbRRpI4jwx0TxQxlpvwnQJgKjz6L4QGsUqJPseimK+NDE07B1QgmHBuL3ki4ahSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770622071; c=relaxed/simple;
	bh=in9azl6Nx+9FIXOJKA+uXsjCBlm0Wuzh9Qhh2rUCaI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kCcwti9YN79dE1CS/pCKNeU3OSu74du345mSlON2TL5WkN1JPpsi8411ag7GKHUa2NtyWXhHOwFwWgwQ3RDAbp3PgySqdP0oXUgu1nOajXH7xMOXOQtlF0xHDWrCw5GojIldyWmOlkzXFdKyOa47kctBjHnLGdcFk7NEfte0GkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=AL7P0Sau; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1770622069;
	bh=Ns8BiNaKiLFpCZvy2dBDxuKBZWhsv3zwnXdTwYI3TlQ=;
	h=From:Date:Subject:To:Cc;
	b=AL7P0SaupPmrBE42kuN0cdFVBaf8E95yv/RC2W0d/Vg7bqxjifwcN2xyEN5Zei/Tc
	 FSuRdJbcnexUuYYO62FVloGviWiFQbJ8bYiz1yc6SOeXRGhWEbN159b/Y3SwBAPAWo
	 VGUfQs7ZdcZyxaoc/qPIe/Bs54m2379hPh5t4EYrtUI/Q8IW+QCDKdb8SR+4gd5h33
	 GDWkcshdz6VtZjaBkTI7YuOUpz96COwqIh10qKMX7RXbTpxLsYsChxbYV+DIOWkgfk
	 mQg7Yw4QsLUjJnHLY246txq1zqRG58smTkNEKEIVQoUNTF9oQi0d41uprwOhxtYSwy
	 BasJ18WLHSpHg==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 8356A6031D; Mon,  9 Feb 2026 15:27:49 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 09 Feb 2026 15:27:33 +0800
Subject: [PATCH net] net: mctp: ensure our nlmsg responses are initialised
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-dev-mctp-nlmsg-v1-1-f1e30c346a43@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAGSMiWkC/x3MQQqAIBBA0avErBswwaKuEi0qRxsoE5UIxLsnL
 d/i/wyRAlOEqckQ6OHIt6vo2gb2Y3WWkHU1SCFVJ4VCTQ9ee/Lozita7Ee9kVmVNoOBGvlAht9
 /OIOjBEspHyGDJ7ZlAAAA
X-Change-ID: 20251205-dev-mctp-nlmsg-69dbefa5df7f
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Matt Johnston <matt@codeconstruct.com.au>, netdev@vger.kernel.org
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257903-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[codeconstruct.com.au:email,codeconstruct.com.au:dkim,codeconstruct.com.au:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 699C510C796
X-Rspamd-Action: no action

Syed Faraz Abrar (@farazsth98) from Zellic, and Pumpkin (@u1f383) from
DEVCORE Research Team working with Trend Micro Zero Day Initiative
report that a RTM_GETNEIGH will return uninitalised data in the pad
bytes of the ndmsg data.

Ensure we're initialising the netlink data to zero, in the link, addr
and neigh response messages.

Fixes: 831119f88781 ("mctp: Add neighbour netlink interface")
Fixes: 06d2f4c583a7 ("mctp: Add netlink route management")
Fixes: 583be982d934 ("mctp: Add device handling and netlink interface")
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/device.c | 1 +
 net/mctp/neigh.c  | 1 +
 net/mctp/route.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/net/mctp/device.c b/net/mctp/device.c
index 4d404edd7446e187dd3aa18ee2086c4e2e3da3ee..04c5570bacff69690456d73490a9e4bdebf49d8d 100644
--- a/net/mctp/device.c
+++ b/net/mctp/device.c
@@ -70,6 +70,7 @@ static int mctp_fill_addrinfo(struct sk_buff *skb,
 		return -EMSGSIZE;
 
 	hdr = nlmsg_data(nlh);
+	memset(hdr, 0, sizeof(*hdr));
 	hdr->ifa_family = AF_MCTP;
 	hdr->ifa_prefixlen = 0;
 	hdr->ifa_flags = 0;
diff --git a/net/mctp/neigh.c b/net/mctp/neigh.c
index 05b899f22d902b275ca1e300542a8d546d59ea15..fc85f0e693014309da9c60e46485466cb5bb6dda 100644
--- a/net/mctp/neigh.c
+++ b/net/mctp/neigh.c
@@ -218,6 +218,7 @@ static int mctp_fill_neigh(struct sk_buff *skb, u32 portid, u32 seq, int event,
 		return -EMSGSIZE;
 
 	hdr = nlmsg_data(nlh);
+	memset(hdr, 0, sizeof(*hdr));
 	hdr->ndm_family = AF_MCTP;
 	hdr->ndm_ifindex = dev->ifindex;
 	hdr->ndm_state = 0; // TODO other state bits?
diff --git a/net/mctp/route.c b/net/mctp/route.c
index 2ac4011a953fffe9e01f3bfe0f571b3727b3e903..ecbbe4beb2133b90d2a02031baaa058644f0e8fe 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -1643,6 +1643,7 @@ static int mctp_fill_rtinfo(struct sk_buff *skb, struct mctp_route *rt,
 		return -EMSGSIZE;
 
 	hdr = nlmsg_data(nlh);
+	memset(hdr, 0, sizeof(*hdr));
 	hdr->rtm_family = AF_MCTP;
 
 	/* we use the _len fields as a number of EIDs, rather than

---
base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
change-id: 20251205-dev-mctp-nlmsg-69dbefa5df7f

Best regards,
-- 
Jeremy Kerr <jk@codeconstruct.com.au>


