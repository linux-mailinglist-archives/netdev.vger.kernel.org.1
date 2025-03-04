Return-Path: <netdev+bounces-171498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C14A4D334
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 07:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A081891F3F
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 06:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F851EEA2A;
	Tue,  4 Mar 2025 06:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="AYdk7cxr"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123F6152E02
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 06:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741068010; cv=none; b=RMf50rxmKysR7tVxF3/jaSMDoEFFMC6/TMb+xwigEzN6G8kPJzI/h82pSmkY8foRiQdp7b7NbUiX1vgZ3OKjq+z+BOKbVCFr2fih8TuwW7cId3loKPWMyzyAjEFJYCUfNPR05qVHv1Yl6OjILPzYmfWJrT7cTTJL+t+/6JUp8qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741068010; c=relaxed/simple;
	bh=0lSZcaqAymyTvpIRmHyn/3fJctfboRQNXpaUDipXxEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QYVqAoaQiYoxcQDMtUjEEpzA3RgXboIGssmixxcZnEjSo7pTQr29k2GtdPo3WtHDZYJMqTXZyBUcbp41H4gWWXLxVJgj2liS25g5n5yk6zgsWZsleAtYDp4/WAvmNgYaAsMjYhWh3Aj8cGGWc0Xdk6QnA7HweMEUCfDrGTIrQgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=AYdk7cxr; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1741068000;
	bh=kLfrUUpsWJK5zzf923w/o5tEIsrmWJ9IBb2BIM4b6yY=;
	h=From:Date:Subject:To:Cc;
	b=AYdk7cxrFSbmiJPyTYRMJwn16sQZyoLcufNLsLg45dukiHCPINjO7qq4YDSGWxQ5u
	 kRwjxQvyTV5mH+GoJi+iNo8Dhk1ryq+CcILdDamvzRwPgnhPrjdYF4TgbLhBn+l2FL
	 WOwvvvw2I/e1azpvt4UGEFBMmt3nhpIj+fWzZxZ7EpeTOMSacq6XBxLZ+HlLKCcsza
	 JbZmGTUBzGxxm5IumNMRoHaPXtm8Fs7TgnZJdePTYTqIk24F+RZQpj8eOYSFvpfWuo
	 JeoYiDwP5+SErEg5eedPgAWUBUKY20J+rxA2gNb3fyXQQFir51r4UfCOyuZXGV/sur
	 7cqQpt+nJgb+g==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 3CE55784E3; Tue,  4 Mar 2025 14:00:00 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Tue, 04 Mar 2025 13:59:51 +0800
Subject: [PATCH net] mctp i3c: handle NULL header address
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-mctp-i3c-null-v1-1-4416bbd56540@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIANaWxmcC/x3MQQ5AMBBA0as0szZJVQmuIha0g0koaUsk4u4ay
 7f4/4FAnilAKx7wdHHg3SXkmQCzDG4mZJsMSqpSFlLjZuKBXBh057rioEdZl9qqpiJIzeFp4vv
 /deAoQv++H3UHBsFkAAAA
X-Change-ID: 20250304-mctp-i3c-null-a4b0854d296e
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741067999; l=1155;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=0lSZcaqAymyTvpIRmHyn/3fJctfboRQNXpaUDipXxEU=;
 b=MvIwqQIfIb4EGsNvCWj7QKgwsXYrtE4Z3tcqdF0X0P6mGxHFjuPDla0dDNDeOSqsYAzvnbk0N
 Ntm8SIhHuu4BxnvEDCG/KbKjggjHUCzo7RjCRn5TASwbomYYZ5x0D5z
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

daddr can be NULL if there is no neighbour table entry present,
in that case the tx packet should be dropped.

saddr will usually be set by MCTP core, but check for NULL in case a
packet is transmitted by a different protocol.

Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
Fixes: c8755b29b58e ("mctp i3c: MCTP I3C driver")
---
 drivers/net/mctp/mctp-i3c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/mctp/mctp-i3c.c b/drivers/net/mctp/mctp-i3c.c
index d247fe483c588594c0dc92aa8e9c3c798d910d6b..c1e72253063b54a9c2ff9e45e6202347b8c962a7 100644
--- a/drivers/net/mctp/mctp-i3c.c
+++ b/drivers/net/mctp/mctp-i3c.c
@@ -507,6 +507,9 @@ static int mctp_i3c_header_create(struct sk_buff *skb, struct net_device *dev,
 {
 	struct mctp_i3c_internal_hdr *ihdr;
 
+	if (!daddr || !saddr)
+		return -EINVAL;
+
 	skb_push(skb, sizeof(struct mctp_i3c_internal_hdr));
 	skb_reset_mac_header(skb);
 	ihdr = (void *)skb_mac_header(skb);

---
base-commit: 64e6a754d33d31aa844b3ee66fb93ac84ca1565e
change-id: 20250304-mctp-i3c-null-a4b0854d296e

Best regards,
-- 
Matt Johnston <matt@codeconstruct.com.au>


