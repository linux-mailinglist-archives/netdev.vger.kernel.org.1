Return-Path: <netdev+bounces-282712-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJm/ImgX82llxAEAu9opvQ
	(envelope-from <netdev+bounces-282712-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:48:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA9649F67C
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DCC1A30066A4
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DE43FE66F;
	Thu, 30 Apr 2026 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVCREku1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D836A3FE653
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777538915; cv=none; b=NluuuCNj8y3BSeCe1w+dav8hfQMO7jYDmR0tti+XqTuIRy5tAfXLkSdV33Z0IPl3B7tEElKpXak12rQL0fWCV75zkn9f52TV5ZFr3FBxzKlvpgvnOO7bCJWPAH3uHerNoA46Fp5TWRU5VyyIg8G/tyekJadaQAPEja/sR5LOsns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777538915; c=relaxed/simple;
	bh=7OeD59OdzKyKkLN3zxmRWfWtI2Bv5S/MdGDTrvAu31Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=j1V5sHh2hbwDPSfhHXyg9ZE8ZT0dacXWPG83chhnv+80ixo8Rsj284eyuuNztLBYW1f59ZxzJ7PmdTyNxjVDzyfXHvBMEZoJZ1zHS+8U2PVAxrboy18ywZogHzuR4ZSihUV18OMsf8DmA2/BKUmTS7Zbmjge58Z5vYFVb54fLxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVCREku1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFB7C2BCB3;
	Thu, 30 Apr 2026 08:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777538915;
	bh=7OeD59OdzKyKkLN3zxmRWfWtI2Bv5S/MdGDTrvAu31Q=;
	h=From:Date:Subject:To:Cc:From;
	b=GVCREku1ukvqt8N4RNykuP6nr7zNsC+U7+PuTyxYZNhud0V8sgFcovXw6dj2lUhwc
	 GNkByp91U3Owlpj9NOoS2F624lnVah/y+melenx1Z17luy5UqiTxoFOwt/I7wljMFY
	 taGsWCibUc1BB2s0W5tNCHTkg8utiq3C1Oqtd976KRAHHY62My8pqaexSjTCRIGOCj
	 QO2eAPJ+F9K0z668gBrpNGK/VSaBaLueH9zdVu7FtnveAGF3zDol2Er8diVYTI2s+4
	 4F1sNmjPRR/pUCqzPeP2YIXvZN3y4UoF7JLgYNLbLLkIZbRGp+Fo2nVVcZIuEwgV2i
	 /lbrMvrBYtSzQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 30 Apr 2026 10:47:38 +0200
Subject: [PATCH net-next] net: airoha: configure QoS channel for HW
 accelerated flowtable traffic
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-airoha-ppe-qos-channel-v1-1-5ef9221e85c1@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MwQqDMBAFf0X23IWYSCn9FfGw6LMulE2aSBHEf
 zd6HJiZnQqyotC72Snjr0WjVWgfDY2L2AesU2Xyzj9dFxyL5rgIpwT+xcKXZPiyD9K1wcvLiVC
 NU8as2z3uybCyYVtpOI4T0svhNXIAAAA=
X-Change-ID: 20260430-airoha-ppe-qos-channel-23a4132a80aa
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 2EA9649F67C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282712-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

As done for the SW path, configure the QoS channel for HW accelerated
traffic according to the user port index when forwarding to a DSA port,
or rely on the GDM port identifier otherwise. This allows HTB shaping
to be applied to HW accelerated traffic.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 5c9dff6bccd1..e833c50ac35f 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -334,7 +334,7 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
 						info.wcid);
 		} else {
 			struct airoha_gdm_port *port = netdev_priv(dev);
-			u8 pse_port;
+			u8 pse_port, channel;
 
 			if (!airoha_is_valid_gdm_port(eth, port))
 				return -EINVAL;
@@ -347,6 +347,14 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
 					       * loopback
 					       */
 
+			/* For traffic forwarded to DSA devices select QoS
+			 * channel according to the DSA user port index, rely
+			 * on port id otherwise.
+			 */
+			channel = dsa_port >= 0 ? dsa_port : port->id;
+			channel = channel % AIROHA_NUM_QOS_CHANNELS;
+			qdata |= FIELD_PREP(AIROHA_FOE_CHANNEL, channel);
+
 			val |= FIELD_PREP(AIROHA_FOE_IB2_PSE_PORT, pse_port) |
 			       AIROHA_FOE_IB2_PSE_QOS;
 			/* For downlink traffic consume SRAM memory for hw

---
base-commit: 28df22acc2751abf6e6316a9f1f9cd422741bd03
change-id: 20260430-airoha-ppe-qos-channel-23a4132a80aa

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


