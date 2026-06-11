Return-Path: <netdev+bounces-298067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iJz3BPiKKmpesAMAu9opvQ
	(envelope-from <netdev+bounces-298067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:16:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6050B670C5E
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:16:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sartura.hr header.s=sartura header.b=mTbPqiC7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298067-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298067-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=sartura.hr;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8BF230097EC
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE063CAA49;
	Thu, 11 Jun 2026 10:12:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43E63C988D
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 10:12:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172722; cv=none; b=nktCms4orYgOijxhNzcmy1f4mONl4putciKAD2CN2DHc75KafBS2T9hDSWthVitOuG7sEvloWjXCkdCM/LlYkk52M33i5wIsSDnwS99+dviwhiLye089k95YlzAAO1/dkJh6zqBo2d/TTQryInfYnTPUjJmDoud8HZj8mRidNvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172722; c=relaxed/simple;
	bh=rpGykN4vLFdl3CQ9iBYqMFry3BEQGspmI3jAl7cAsEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hZNWqVBT3C+hV+3BJaSn72s5dHy69m5f0n4dj6Id2fBI4hLR1HtBJbiBjHv/J634rwdC/B0NmR3hOBB5zemiRDsD3gPbMX4Vm5x9TJdPXgXgXs2SZWhEbpVmlDTPfCbDpnFKIU14pyQi/JgPLvShhrQfGMS11RyFTBp2uhwgJJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=mTbPqiC7; arc=none smtp.client-ip=209.85.221.44
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-46066e640easo367787f8f.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 03:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1781172719; x=1781777519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=89WdVHtEcEjrTXfXmO5KLfdPm+uKXRpF6kTT1kAcq9w=;
        b=mTbPqiC7Bz09opM20+7+z3nHBm153iGrYZyli7UEzfXIEybsonzyqkY7sIPRnDN1nQ
         pquWhbIlSCciiIaMAKa8oYyBxmH0/cM4AmETBz/f9nOTrRzksSwymhcHEyw6VT+f/V/d
         U5J1g+5PNRjAqtk1Pw4YaDM/RG68daKX8tEGX+/YjoN7iBWu1bQG4xxlwm27Qfq5HYTv
         qJfVVinD0sQ8fV3Ua9p7mCtY/EMvnsg70XzLuFjN/g4AluXsnGy8hcO3J3tahxsGUPVM
         kl1CAZnS/hhE5EArJhq/iT/NMbXln6Tem5Vb1nAuAMjspHzkyVrwoJkPfXen0fsabXJg
         l7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781172719; x=1781777519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89WdVHtEcEjrTXfXmO5KLfdPm+uKXRpF6kTT1kAcq9w=;
        b=QItp0oTnGob1adqq+5h1WlKTSTVXXRGJWELz1kTDvI8CdVIZCN22viqt/vHpXbV6tp
         uW1g3T9ENjei4/0ol926rpGOdfoYwvCnNE5eHunSOXOAaJMjag50/PWfdJp7lHD/alyY
         jdIJB+EEcYKbDlJvwyjHKCCs13bjsE7ms1fbPLST2OETAgMd5j+mXObrUYOdBqko0YCd
         /QwI825SyampTQpxCtNLxSU0O7cWqHKXBpL92bwiz9Vd95EkQiRh28X4LWtbzw0dYGYQ
         9UJFddiajV1NNUj+dlXPEcJrN6JcWrGmORPGhmax0I06VWQGiW83+vfbnzZ//1nM7yl8
         e7iA==
X-Forwarded-Encrypted: i=1; AFNElJ9UU6Ln83+kT0UwrcMC3ATPaiVeOn3Mo4dW5s39fPrGjUvBoGocHcaqXnUQ7vcd25KVoHDfuug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAeaXazt67yUsy1hXDCUbQ3seYoBfnxQfKSAoc3Vdzo65P0OJt
	sIKfwAqzaKfeUuV0kTxW8eFbUGHYJIfewf4LyIBMiHIvO0DkI8hrlMGtvWo6hLLeGEk=
X-Gm-Gg: Acq92OE4fTVB3Z9IBB4QZ3r3H5FjsoRpnKFuTxgeWx1w8DakShnn1Sgow1bdVT5wgS0
	ZantP5m05GKXOnJo7xsrZFu3lhOT7t1HFrlCgYNFeY42OUplit7/9qzdSPPp//5w5OdOnOs6Mig
	P35B/xr5IzbocrbuhWgVfsSARJjhik7fb1EB+AD5+D3QJtPr58tyhUZdf1UyT10N9BpS59DPNJe
	69eu4DaUI9StALcjyfsvrrZUqiT6KT+Ftmq7IER7SNLLaVlZTI01lvwx5voRSUQgmH5qXzB4qqe
	Kj3+IetHOZuXZI1rKd5Tn/gSeNXyCK8kf/qfBuKes/IX0vrqlipe1s5WYPyZnIPOKS6KJGevzXJ
	3XPaaHncscDMLcULX8mO7ViLjwau/v4SMyWTlzbXXRHxYq6TCM997M/gkHYcuxfeoU2JVLEbT2F
	9Trnq5hjWeAIskPKvtHVrOvBaWxWunwdatW1yPpPV1d4Wxk76NBVl5etrI5wCv7iw+jV2ZvpIY9
	sIuIuZyHtjwsTfiMN81rpP4lPSCC3Q/VtykN0IM1zsqe5bFE8PHeg2yGH4Xx0R0r1Vo/DARivok
	V4KVa3pZZbvu
X-Received: by 2002:a05:6000:4706:b0:45e:e44b:313e with SMTP id ffacd0b85a97d-460675b7081mr3135334f8f.19.1781172719195;
        Thu, 11 Jun 2026 03:11:59 -0700 (PDT)
Received: from threadripper-fedora-workstation (cpe-94-253-164-203.zg.cable.xnet.hr. [94.253.164.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm78592966f8f.0.2026.06.11.03.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:11:58 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	sdf.kernel@gmail.com,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH net-next] net: sparx5: change ndo_set_rx_mode_async return type to int
Date: Thu, 11 Jun 2026 12:11:13 +0200
Message-ID: <20260611101151.426050-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.54.0
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sartura.hr,reject];
	R_DKIM_ALLOW(-0.20)[sartura.hr:s=sartura];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298067-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,gmail.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:Steen.Hegelund@microchip.com,m:daniel.machon@microchip.com,m:UNGLinuxDriver@microchip.com,m:sdf.kernel@gmail.com,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:luka.perkov@sartura.hr,m:robert.marko@sartura.hr,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[robert.marko@sartura.hr,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robert.marko@sartura.hr,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sartura.hr:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sartura.hr:dkim,sartura.hr:email,sartura.hr:mid,sartura.hr:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6050B670C5E

Commit ("net: add retry mechanism to ndo_set_rx_mode_async") changed the
ndo_set_rx_mode_async return type to int, however it did not update the
SparX-5 driver.

So, simply update the sparx5_set_rx_mode return type to int, propagate
return from __hw_addr_sync_dev or simply return 0.

Fixes: d90b85c23b3d ("net: add retry mechanism to ndo_set_rx_mode_async")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
index 2eef643f355a..d08f5a0a33ef 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
@@ -162,15 +162,17 @@ static int sparx5_port_stop(struct net_device *ndev)
 	return 0;
 }
 
-static void sparx5_set_rx_mode(struct net_device *dev,
-			       struct netdev_hw_addr_list *uc,
-			       struct netdev_hw_addr_list *mc)
+static int sparx5_set_rx_mode(struct net_device *dev,
+			      struct netdev_hw_addr_list *uc,
+			      struct netdev_hw_addr_list *mc)
 {
 	struct sparx5_port *port = netdev_priv(dev);
 	struct sparx5 *sparx5 = port->sparx5;
 
 	if (!test_bit(port->portno, sparx5->bridge_mask))
-		__hw_addr_sync_dev(mc, dev, sparx5_mc_sync, sparx5_mc_unsync);
+		return __hw_addr_sync_dev(mc, dev, sparx5_mc_sync, sparx5_mc_unsync);
+
+	return 0;
 }
 
 static int sparx5_port_get_phys_port_name(struct net_device *dev,
-- 
2.54.0


