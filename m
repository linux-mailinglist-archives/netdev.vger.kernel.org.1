Return-Path: <netdev+bounces-191734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663F5ABD00A
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 09:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119044A29E4
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 07:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3474125A34B;
	Tue, 20 May 2025 07:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="hvYf0b/p"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FBB20E6
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 07:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747724575; cv=none; b=upXch+gQhXZIZvpFQfJvhHCnLI+CID6xEeOAH44OvGNMONYDwGkoJD0mBy3L2oYo+JQPXgRBrPaIg+wMnTizds93oSKErlNvDRsVbqWgTNe/3yveg80MBlzMWHeYGUqZaEnqFy1ojasUtUahdqCtOrsvGDxjfEdPjEaHuig5pTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747724575; c=relaxed/simple;
	bh=afEco2fpskzHxl1d+4ROtj5GpR+gwTjTP0dk5aA1gyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q2Emh1iUQgXLDwjaU5jG5ocVFIzMnzm5e8JW252Eqi7pvy8YAf8m0HwI6A+Fh1jyL/TGc73ElTjVDxbdBJcN6zOUwvUkUIuF5E3x5zAGzKYc8uSdNG5t2zYJp4vQ1a4y4mNpgbm5BLEQ7PRdiJiWyN4Zb1jlLmlIRr1W5vTGEc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=hvYf0b/p; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1747724565;
	bh=AHz/A0USFq9WiZcRPB1PhLvpfp/IncHV3F5dohmD1lg=;
	h=From:Date:Subject:To:Cc;
	b=hvYf0b/p8RFOjiS86p2OVJT3PLdFqeGXXRPdxxLQBO2PknhTpSP21ZIMS8UovYC5V
	 s1h/Y7QZdWy6X0Caf2LHL3SF0r2gM//W4r7dYsrrSFAWLq4mT6TlCOrwqxEmFuszVC
	 kF37k8FvOcCt8gckC+uHW9PLridsbSwH/4fPD/Wn9i4sBnwoM07RGqhRZldK465BMH
	 Gs9rNj2zylgD6RhRsMk+EaDZ8J6MPsQp0R2J4tA8fueIk0CXJnNFN2cbcn8rbkR+in
	 0eEuWA5ZqnzbZuxV3MbiT9MwIekqsYstICtSWGLYx5LMFtTaBFZDlIvbHS8OelAlBv
	 DuTIJ1kP85xjg==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 1307082044; Tue, 20 May 2025 15:02:45 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Tue, 20 May 2025 15:02:10 +0800
Subject: [PATCH net-next] net: mctp: use nlmsg_payload() for netlink
 message data extraction
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-mctp-nlmsg-payload-v1-1-93dd0fed0548@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAPEoLGgC/x3MQQqDMBBA0avIrDswiUpor1K6SHW0AzqGJIgle
 HeDy7f4v0DiKJzg1RSIvEuSTSvMo4Hh53VmlLEaLNmeeku4DjmgLmuaMfj/svkRyRnzdG3n6Dt
 BDUPkSY57+gbljMpHhs95XnIcC/ZuAAAA
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

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
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


