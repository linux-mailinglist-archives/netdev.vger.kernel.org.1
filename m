Return-Path: <netdev+bounces-172407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 362C2A547B4
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BA34188C3F4
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF1C200100;
	Thu,  6 Mar 2025 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="dCBy8gCr"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907FC204879
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256663; cv=none; b=SfGzJUFGQaY2MR8Pmc1t9S1dUPM8DcAzL6Y2WOKu4DCKjlH+ijxbSwoIg4obc71M1i+UvYULCNdts3oZ30nB7oIs/jg+yd3uitu/xA6VhftCTmrr37VZ9AdoytqjHHOUgxM9Ir2IFflXUDJ9uOHuf58dATwBkm9y7ao4LzDYrT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256663; c=relaxed/simple;
	bh=TLILMbpW9cuWipE31cSngedfJJWTQsmSQHNHRS4mdZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uFzq9EjjCznu5ei1Tgz6BWyJIq3DbUSEi9q+twncp4wZAPpzuDXEJi15B2NE+oCJcdVCltmB7Tl+QFqkl7QYFlJFM7YRmaF2P07cMv1FmDUcPOJ6vqkO2Sto4+WBoAlU/dxh+E/jGRzckkwCAuqqhKtxfFDGK22qShoxyKXAXaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=dCBy8gCr; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1741256659;
	bh=dkUBE335YDVLCItzeLFhkN1AuiDIZKC/1OwAdtAB6jo=;
	h=From:Date:Subject:To:Cc;
	b=dCBy8gCrgfRzQzAEN9Z5f6p6PlTRZ0IwivzaamY3nZEdyamiG3ZAOni8AOtJQytPr
	 KLqe6eD4Ga15h3WyFsPjzzRd8xh3A5LHD+GsXKFDROQ0AXQenthRylHaR1O1FqNLKv
	 pGsgXmdBhIv60qx48FGQl0UmFtABaiIlL83JNPXt759b8AP7mDc+V1DBJYTDDBykU7
	 8bH2oYqbL5ifmU1KRkGVfideMo19INQwvvWwcRbb2VQEiUuR4hP3O4lGPfCK9v3VgR
	 wH9LC+DVPibyam/kbJEa8QtEj0zCham2BSuxgt1EQUwzbDydWAQBOWcwAwIKrCmcNL
	 kJSpyj6n+UJVg==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 1478978BC9; Thu,  6 Mar 2025 18:24:19 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Thu, 06 Mar 2025 18:24:18 +0800
Subject: [PATCH net] net: mctp i3c: Copy headers if cloned
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-matt-i3c-cow-head-v1-1-d5e6a5495227@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIANF3yWcC/x3MQQqDMBBG4avIrB2IBm3xKsXFkPzRWTSWJFRBc
 veGLr/FezdlJEWmpbsp4atZj9gw9B25XeIGVt9MoxknY83MbymF1Tp2x8k7xPMs1oenwIcHqHW
 fhKDX//miiEJrrT+Tsq2IaAAAAA==
X-Change-ID: 20250306-matt-i3c-cow-head-6a3df8aedf7e
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741256658; l=1219;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=TLILMbpW9cuWipE31cSngedfJJWTQsmSQHNHRS4mdZw=;
 b=XuxOWMUB6pd40KIW81YVscK5AsO7mRBON2v4YqccTebdxEvdn7wyD3sEsOM/7x7oNP0bx0/e5
 809C22E0cMYBkJwd7L5vA1gfs5eZEYpL4RUnyX+jU8u2e8Dwx6aJqzJ
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

Use skb_cow_head() prior to modifying the tx skb. This is necessary
when the skb has been cloned, to avoid modifying other shared clones.

Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
Fixes: c8755b29b58e ("mctp i3c: MCTP I3C driver")
---
 drivers/net/mctp/mctp-i3c.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/mctp/mctp-i3c.c b/drivers/net/mctp/mctp-i3c.c
index c1e72253063b54a9c2ff9e45e6202347b8c962a7..c678f79aa35611272a4a410c14dcaeea290d265c 100644
--- a/drivers/net/mctp/mctp-i3c.c
+++ b/drivers/net/mctp/mctp-i3c.c
@@ -506,10 +506,15 @@ static int mctp_i3c_header_create(struct sk_buff *skb, struct net_device *dev,
 	   const void *saddr, unsigned int len)
 {
 	struct mctp_i3c_internal_hdr *ihdr;
+	int rc;
 
 	if (!daddr || !saddr)
 		return -EINVAL;
 
+	rc = skb_cow_head(skb, sizeof(struct mctp_i3c_internal_hdr));
+	if (rc)
+		return rc;
+
 	skb_push(skb, sizeof(struct mctp_i3c_internal_hdr));
 	skb_reset_mac_header(skb);
 	ihdr = (void *)skb_mac_header(skb);

---
base-commit: 0e7633d7b95b67f1758aea19f8e85621c5f506a3
change-id: 20250306-matt-i3c-cow-head-6a3df8aedf7e

Best regards,
-- 
Matt Johnston <matt@codeconstruct.com.au>


