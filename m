Return-Path: <netdev+bounces-192224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4B9ABEFF8
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD1C3A4298
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 09:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DB623C505;
	Wed, 21 May 2025 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="dyz32leS"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3232E239E7F
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747820043; cv=none; b=Q4AsgDHL3ha+OHlbtsUKGl0GTOdKr0dKEoleUH+3+m9ENj8vf8hfl3efF2/Te/mb1powWwiYCDS1rt8L2teYYYDWXoD/yAjWAWxtQNnUVJ2ASOLYra1CP8wUb8CMs/OBFiKtZgA2YvaGvPHQ1PC5YtNiTRUEzgxkIfRPvpviTsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747820043; c=relaxed/simple;
	bh=IKEN6eoaaFoXA45QUfAvlKdKH1mBr7yEW/lnwgXQ1fI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kjSkgxSbvozr9IHjXfgjC42b5PCitn9xwNSp0gZFuRP9U0nQVLERDHMAbuKAW7BYSjxJKmudAHubWB49Nc4S6b4mmeVmHjwtX+tQDofD9ehxa8f8+RKfmaj8biAGhFGEwWdq9KcHy3qAf4Wa8w3o9gQhYq0qJrTCxNpOcwh1d8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=dyz32leS; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1747820033;
	bh=AgDqUSd0T8INEnCYQPRXsdf6PeA9ww/8Gan4pEx8Ykw=;
	h=From:Date:Subject:To:Cc;
	b=dyz32leSSc4Kr8JuhNm5fX+xLd//MNWDFHOmls6CmiEoMaF64YKL9XKEkqeCcRXGy
	 Qm7+efJcEsooWPfL2c2McIqG1wWKtLwqBJSLwkU9hR4M1CwPyZnDdOttvyKw4s6VDK
	 qxcKm9nmdtjBn4FvXia+KHxlCDN1B7gwOVQr5vW6d/jyETzVpxOcGvl+f/Zn95HfDp
	 P/uHWLZL6L2e6J3HtqepN1+g5NNI1FdPgevywrnaCjOM6awjPrZcIMV7ZYB6QD3yEF
	 ICGrnGTNA4oG5WSylny7oB48Q6Chg9h0vcylyvz1m/A7B0aSFgEJC9Znq91rjToqw0
	 ZhxEXhQpA9UUw==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 5CCB28265A; Wed, 21 May 2025 17:33:53 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 21 May 2025 17:33:36 +0800
Subject: [PATCH net-next v2] net: mctp: use nlmsg_payload() for netlink
 message data extraction
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250521-mctp-nlmsg-payload-v2-1-e85df160c405@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAO+dLWgC/32NQQ6DIBBFr2Jm3TGAGmtXvUfjgsKoJAoE0GiMd
 y/xAF2+vPz3T4gUDEV4FScE2kw0zmYQjwLUJO1IaHRmEEw0rBEMF5U82nmJI3p5zE5qZC3nXVv
 VLfsOkIc+0GD2O/oBSwkt7Qn6bCYTkwvH/bbx2/8Lbxw5dpXWbCDNmvr5Vk6TcjamsKpUKreUc
 oX+uq4fL20oaskAAAA=
X-Change-ID: 20250520-mctp-nlmsg-payload-0711973470bf
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Jakub suggests:

> I have a different request :) Matt, once this ends up in net-next
> (end of this week) could you refactor it to use nlmsg_payload() ?
> It doesn't exist in net but this is exactly why it was added.

This refactors the additions to both mctp_dump_addrinfo(), and
mctp_rtm_getneigh() - two cases where we're calling nlh_data() on an
an incoming netlink message, without a prior nlmsg_parse().

For the neigh.c case, we cannot hit the failure where the nlh does not
contain a full ndmsg at present, as the core handler
(net/core/neighbour.c, neigh_get()) has already validated the size
through neigh_valid_req_get(), and would have failed the get operation
before the MCTP hander is called.

However, relying on that is a bit fragile, so apply the nlmsg_payload
refector here too.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
Changes in v2:
- clarify neigh.c addition in relation to neigh core checks
- Link to v1: https://lore.kernel.org/r/20250520-mctp-nlmsg-payload-v1-1-93dd0fed0548@codeconstruct.com.au
---
 net/mctp/device.c | 4 ++--
 net/mctp/neigh.c  | 5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mctp/device.c b/net/mctp/device.c
index 7c0dcf3df3196207af6e1a1c002f388265c49fa1..4d404edd7446e187dd3aa18ee2086c4e2e3da3ee 100644
--- a/net/mctp/device.c
+++ b/net/mctp/device.c
@@ -120,8 +120,8 @@ static int mctp_dump_addrinfo(struct sk_buff *skb, struct netlink_callback *cb)
 	int ifindex = 0, rc;
 
 	/* Filter by ifindex if a header is provided */
-	if (cb->nlh->nlmsg_len >= nlmsg_msg_size(sizeof(*hdr))) {
-		hdr = nlmsg_data(cb->nlh);
+	hdr = nlmsg_payload(cb->nlh, sizeof(*hdr));
+	if (hdr) {
 		ifindex = hdr->ifa_index;
 	} else {
 		if (cb->strict_check) {
diff --git a/net/mctp/neigh.c b/net/mctp/neigh.c
index 590f642413e4ef113a1a9fa96cb548b98cb55621..05b899f22d902b275ca1e300542a8d546d59ea15 100644
--- a/net/mctp/neigh.c
+++ b/net/mctp/neigh.c
@@ -250,7 +250,10 @@ static int mctp_rtm_getneigh(struct sk_buff *skb, struct netlink_callback *cb)
 		int idx;
 	} *cbctx = (void *)cb->ctx;
 
-	ndmsg = nlmsg_data(cb->nlh);
+	ndmsg = nlmsg_payload(cb->nlh, sizeof(*ndmsg));
+	if (!ndmsg)
+		return -EINVAL;
+
 	req_ifindex = ndmsg->ndm_ifindex;
 
 	idx = 0;

---
base-commit: f685204c57e87d2a88b159c7525426d70ee745c9
change-id: 20250520-mctp-nlmsg-payload-0711973470bf

Best regards,
-- 
Jeremy Kerr <jk@codeconstruct.com.au>


