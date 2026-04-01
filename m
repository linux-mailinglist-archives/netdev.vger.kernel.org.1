Return-Path: <netdev+bounces-273912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMvlJtvCzGkWWgYAu9opvQ
	(envelope-from <netdev+bounces-273912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:01:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FBE37583A
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01E92304651B
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E5D346E7F;
	Wed,  1 Apr 2026 07:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2DVLH+m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BE11A5B8A;
	Wed,  1 Apr 2026 07:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775026807; cv=none; b=deH+2u0R1tMInAbjWWAdUheh4yJyEzM03vfEkHDJf0hl6iQ4PkaNFxkArBvH2O86xN6clBpxgaA+J2y/Jl4dH5a/kCpCyqLDcAI7EKYDrwq8aEYthmCma4Vqf8QL1TTORvTGi2gu4sphwYw4u9nU/UKKxJKbXfIxesAyKF3tA24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775026807; c=relaxed/simple;
	bh=LoKILA/pw4fFDtdnNkPqQt1xHR87BfHMh1ltAx29UpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f77zV6sGqCe82dhliYBCM35+hcw/puCpG/x9R4i1K1VuF/aW8rWTCTveUF6Y1YSDRStC1BX7U6oOBMTwd0rmIKj2lZJRzdIHhRjEB4ck9nFPLdkCbm9HP1YVKl5QQ/DBK6Lyk/O31BvyQqVHckWghgv0Daoq2+eocjM7kIu6B8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2DVLH+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E36FC2BCB2;
	Wed,  1 Apr 2026 07:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775026806;
	bh=LoKILA/pw4fFDtdnNkPqQt1xHR87BfHMh1ltAx29UpA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l2DVLH+m2w+jJIBfF9rERoSA2bH2lYnGH+BRnaawtv6O+HvhlFFTepw3wsd6YY2Dj
	 Qqt/oDz98nHlPQ3TUJXTRFBC2upB9L0Emr7/hIPy+4CtMOtvqxIAwlPMdasj4dsBdH
	 p0S70Fnhy/hmq78FpsWt/RK+7hFn+QXzsAKMvuAUHBWEBaEi8oGo6nx0e++nHOpPAx
	 fiU4jnqqLYQAexT2Emh/9/aU9HjBrhb2jxhY0KU+ZRMCPUWEKl2P944VQf4TjXAStm
	 kn6qIVGDqf2Jk5omMHeDByFfrxtAioy6R/HTSCjKztYCIfYOH0VOIgsqa8Ts5latyX
	 q1O7svsE1c7ag==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 01 Apr 2026 08:59:20 +0200
Subject: [PATCH net-next v2 02/11] net: airoha: Set PPE cpu port for GDM2
 if loopback is enabled
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-airoha-eth-multi-serdes-v2-2-ac427ae4beeb@kernel.org>
References: <20260401-airoha-eth-multi-serdes-v2-0-ac427ae4beeb@kernel.org>
In-Reply-To: <20260401-airoha-eth-multi-serdes-v2-0-ac427ae4beeb@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273912-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4FBE37583A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add missing PPE cpu port configuration for GDM2 if QoS loopback is enabled
for GDM3 or GDM4 ports. Similar to commit 'f44218cd5e6a ("net: airoha:
Reset PPE cpu port configuration in airoha_ppe_hw_init()"), this patch is
fixing an issue not visible to the user (so we do not need to backport it)
since airoha_eth driver currently supports just the internal phy available
via the MT7530 DSA switch and there are no WAN interfaces officially
supported since PCS/external phy is not merged mainline yet (it will be
posted with following patches).

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 8 ++++++--
 drivers/net/ethernet/airoha/airoha_eth.h | 3 ++-
 drivers/net/ethernet/airoha/airoha_ppe.c | 6 +++---
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 2beba017e791d20f142e754edafcd402d8cc496f..ff5fc852d7dc3960fdcf6ae7465896340c3f43a0 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1713,7 +1713,7 @@ static int airoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 {
 	struct airoha_eth *eth = port->qdma->eth;
 	u32 val, pse_port, chan, nbq;
-	int src_port;
+	int i, src_port;
 
 	/* Forward the traffic to the proper GDM port */
 	pse_port = port->id == AIROHA_GDM3_IDX ? FE_PSE_PORT_GDM3
@@ -1757,6 +1757,9 @@ static int airoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 		      SP_CPORT_MASK(val),
 		      __field_prep(SP_CPORT_MASK(val), FE_PSE_PORT_CDM2));
 
+	for (i = 0; i < eth->soc->num_ppe; i++)
+		airoha_ppe_set_cpu_port(port, i, AIROHA_GDM2_IDX);
+
 	if (port->id == AIROHA_GDM4_IDX && airoha_is_7581(eth)) {
 		u32 mask = FC_ID_OF_SRC_PORT_MASK(nbq);
 
@@ -1795,7 +1798,8 @@ static int airoha_dev_init(struct net_device *dev)
 	}
 
 	for (i = 0; i < eth->soc->num_ppe; i++)
-		airoha_ppe_set_cpu_port(port, i);
+		airoha_ppe_set_cpu_port(port, i,
+					airoha_get_fe_port(port));
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 7df4dbcd8861856c54c2a38bc89c69180ac2f6dc..f04b8d8cfc09f74f288c347d03e18b4f4f3aa893 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -650,7 +650,8 @@ int airoha_get_fe_port(struct airoha_gdm_port *port);
 bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
 			      struct airoha_gdm_port *port);
 
-void airoha_ppe_set_cpu_port(struct airoha_gdm_port *port, u8 ppe_id);
+void airoha_ppe_set_cpu_port(struct airoha_gdm_port *port, u8 ppe_id,
+			     u8 fport);
 bool airoha_ppe_is_enabled(struct airoha_eth *eth, int index);
 void airoha_ppe_check_skb(struct airoha_ppe_dev *dev, struct sk_buff *skb,
 			  u16 hash, bool rx_wlan);
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 58b14aea7c2f33ebce11c51d892eefff692378ca..0f42247a2ef3d67b7dadb6201079ff2c2defbf0d 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -85,10 +85,9 @@ static u32 airoha_ppe_get_timestamp(struct airoha_ppe *ppe)
 	return FIELD_GET(AIROHA_FOE_IB1_BIND_TIMESTAMP, timestamp);
 }
 
-void airoha_ppe_set_cpu_port(struct airoha_gdm_port *port, u8 ppe_id)
+void airoha_ppe_set_cpu_port(struct airoha_gdm_port *port, u8 ppe_id, u8 fport)
 {
 	struct airoha_qdma *qdma = port->qdma;
-	u8 fport = airoha_get_fe_port(port);
 	struct airoha_eth *eth = qdma->eth;
 	u8 qdma_id = qdma - &eth->qdma[0];
 	u32 fe_cpu_port;
@@ -174,7 +173,8 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 			if (!port)
 				continue;
 
-			airoha_ppe_set_cpu_port(port, i);
+			airoha_ppe_set_cpu_port(port, i,
+						airoha_get_fe_port(port));
 		}
 	}
 }

-- 
2.53.0


