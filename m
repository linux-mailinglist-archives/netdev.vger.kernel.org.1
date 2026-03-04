Return-Path: <netdev+bounces-263757-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLZ2JUAQqGk8ngAAu9opvQ
	(envelope-from <netdev+bounces-263757-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:58:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 001031FE9F8
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB6E230D57D4
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 10:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC8C3A5E94;
	Wed,  4 Mar 2026 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8s2eZLu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B7C3A4529
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772621823; cv=none; b=km96f7SP9swrIlfPHTrmjNhTPmv4/zPee6BQkzTkTg9FqkcMOeNt5izI47n27r7W1S654wDsopAlBFce1P5i/IogL93V/gjnTKHwNQbaEjTkOd9yfntdFtqJZsvl6BqDdzFWkr5bhe8qBoCr898wVyPSh6zQiobwmARHGQAJCXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772621823; c=relaxed/simple;
	bh=z6mlT/VdSmy3w+18qyHEGpPhQGLQO3j1yCyXX/Y2eZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a1uMBsHnERe9fI38hYgN/gNll9plzohyZ6wBvZV5xAu2Q5n0DJN/MoX9PXdg2kEFTZJ/ctSuuQVBLja/wieRprtrjXu8JlQWTHlP97i+kLVrLwUZWmosTdnGLoXKri7rCzS+1zbH+zF99RonRnNda6Liq++oT7JdZd2dg3k07n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8s2eZLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77182C2BCAF;
	Wed,  4 Mar 2026 10:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772621822;
	bh=z6mlT/VdSmy3w+18qyHEGpPhQGLQO3j1yCyXX/Y2eZ8=;
	h=From:Date:Subject:To:Cc:From;
	b=k8s2eZLuB8Bi/WwIKoUVlSSbxaGR1HjVmKVaf8cSv+gYS8hub+ZckPZyRRuLl4yeU
	 987rkykVdsoLKX3D4mF/YBvQJ/Xg4WIAWrMrIgdLsufvrTkIPM8XV8xHKD5OhLLwfd
	 xqrQDuNH1RdpYcK9bDRkg6xK0MFaVwJ4j77UepEhEyx7TgJQn1WTKnKIrt3KRC5pdg
	 UkOUikktLorJAt2mwfohWGMT7jrG6Or2/dWdNEHE/6LLOgpbK3R6QAuVPpQ7ogEhY6
	 ebsFD8EU8RjJOib2TsNg/Jc9XWWnleTSWCq9a82M8QqNgeGAvY129ftm8305r3aqrM
	 ua7rn5x00/vxw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 04 Mar 2026 11:56:47 +0100
Subject: [PATCH net-next] net: airoha: Rely __field_prep for non-constant
 masks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-airoha-__field_prep-v1-1-b185facc4e2f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSQqAMAwAvyI5G+jiAn5FpJQaNSBtSUEE8e8Wj
 zMw80AhYSowNQ8IXVw4xQq6bSAcPu6EvFYGo8ygrOrQs6TDo3Mb07m6LJSxp74b9aiDtQFqWeX
 G93+dl/f9AMLy3DNlAAAA
X-Change-ID: 20260304-airoha-__field_prep-5e547171c33c
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: 001031FE9F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263757-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Rely on __field_prep macros for non-constant masks preparing the values
for register updates instead of open-coding.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 3779f93b47bc13ae21d4ae088dece4712dc214e5..09acbe6695368132ddd92c3501f8711476db73f6 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1727,7 +1727,7 @@ static int airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 	airoha_fe_rmw(eth,
 		      REG_SP_DFT_CPORT(src_port >> fls(SP_CPORT_DFT_MASK)),
 		      SP_CPORT_MASK(val),
-		      FE_PSE_PORT_CDM2 << __ffs(SP_CPORT_MASK(val)));
+		      __field_prep(SP_CPORT_MASK(val), FE_PSE_PORT_CDM2));
 
 	if (port->id != AIROHA_GDM3_IDX && airoha_is_7581(eth))
 		airoha_fe_rmw(eth, REG_SRC_PORT_FC_MAP6,
@@ -1781,7 +1781,7 @@ static int airoha_dev_init(struct net_device *dev)
 	ppe_id = pse_port == FE_PSE_PORT_PPE2 ? 1 : 0;
 	airoha_fe_rmw(eth, REG_PPE_DFT_CPORT0(ppe_id),
 		      DFT_CPORT_MASK(port->id),
-		      fe_cpu_port << __ffs(DFT_CPORT_MASK(port->id)));
+		      __field_prep(DFT_CPORT_MASK(port->id), fe_cpu_port));
 
 	return 0;
 }
@@ -2138,7 +2138,7 @@ static int airoha_qdma_set_chan_tx_sched(struct airoha_gdm_port *port,
 
 	airoha_qdma_rmw(port->qdma, REG_CHAN_QOS_MODE(channel >> 3),
 			CHAN_QOS_MODE_MASK(channel),
-			mode << __ffs(CHAN_QOS_MODE_MASK(channel)));
+			__field_prep(CHAN_QOS_MODE_MASK(channel), mode));
 
 	return 0;
 }

---
base-commit: 4ad96a7c9e2cebbbdc68369438a736a133539f1d
change-id: 20260304-airoha-__field_prep-5e547171c33c

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


