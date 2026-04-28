Return-Path: <netdev+bounces-281676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLV5LVBa8Gn/SAEAu9opvQ
	(envelope-from <netdev+bounces-281676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:57:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 273E047E582
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FE3F3003633
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 06:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF2635AC31;
	Tue, 28 Apr 2026 06:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEFyPsVG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDF634F24E
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 06:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777359221; cv=none; b=scz418BH+lEvIJC3di/ohjtikXb0ehkGJZ7wtVRMm+wOUQRppaZBy5qMervlUidpJt7wi8KB59OeIDCI5sfMdaXHPOF5KdV1L5H0pk4SgC4f3q4FUdzhw3nBPjIxJkHvpHMg6RNv35ZLqI4na52OZ6bweTKbx0U4hg9xManaU2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777359221; c=relaxed/simple;
	bh=PcMY8rNtk+alf5ERoe5UCqYOPg+SjVnTOq5lid6Morc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gtwYJjTR2ywV65NI8MzgXUT94P8rqqWmlvkOisv+OF+OCSQO5VfTjCWyw7Nm+aruB3ZgIJo8fIa+8XfyKytS0F2+Lwm8zl0Nh+p78byodTAyuh5zmBRBsLf+5sAlPCLLMOJa5swgtEjxtIreIQ17d9MTHQFixasivKWZq4xlwc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEFyPsVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E74C2BCAF;
	Tue, 28 Apr 2026 06:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777359221;
	bh=PcMY8rNtk+alf5ERoe5UCqYOPg+SjVnTOq5lid6Morc=;
	h=From:Date:Subject:To:Cc:From;
	b=CEFyPsVGr+7/LKa3Rq5imoYzwrjQKMUGio1kkxw2EmP/ynlOFMfyFt78g+XZDlkoF
	 CGTaPvu9Shf3OKYSy2j6eCRTWi9ydgVv76LInuNK69Z1IEnPnWrAPcPABHHKSsvS3s
	 DC+09hFOWxDpHGDfuY3sm2TuivkqqUJKRdqEaVWuKwEKfUT39TUlfp17wnAxTRpvNi
	 z1rJeCHWASPJM21YXNkSRtdwY4U2JKzMgzeNW7V1ok/QuCyGIu/f+KQgab8+cZsbxJ
	 T3hDk4jjy2jeJx7M2ONVg0agSdCuj/prjDfQLLeWC7oZXvPqVmlp6cI4prOPUmxX6K
	 DRDBVJZOArY9g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 28 Apr 2026 08:53:16 +0200
Subject: [PATCH net] net: airoha: Do not return err in ndo_stop() callback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-airoha-ndo-stop-not-err-v1-1-674506d29a91@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqDQAxA4atI1g04YfpDryJdxBprNolkBhHEu
 zt0+S3eO6BIqBR4dweEbFrUrSHdOvgubD9BnZqBenr0mV7IGr4w2uRYqq9oXlEikNM9c5qfNGa
 CVq8hs+7/8wAmFT7neQGmoir4bgAAAA==
X-Change-ID: 20260428-airoha-ndo-stop-not-err-a154a1f72b42
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 273E047E582
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281676-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Always complete the airoha_dev_stop() routine regardless of the
airoha_set_vip_for_gdm_port() return value, since errors from
ndo_stop() are ignored by the networking stack and the interface is
always considered down after the call.

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 5effb4a4ae84..f8b3d53bccad 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1747,13 +1747,10 @@ static int airoha_dev_stop(struct net_device *dev)
 {
 	struct airoha_gdm_port *port = netdev_priv(dev);
 	struct airoha_qdma *qdma = port->qdma;
-	int i, err;
+	int i;
 
 	netif_tx_disable(dev);
-	err = airoha_set_vip_for_gdm_port(port, false);
-	if (err)
-		return err;
-
+	airoha_set_vip_for_gdm_port(port, false);
 	for (i = 0; i < dev->num_tx_queues; i++)
 		netdev_tx_reset_subqueue(dev, i);
 

---
base-commit: 3bc179bc7146c26c9dff75d2943d10528274e301
change-id: 20260428-airoha-ndo-stop-not-err-a154a1f72b42

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


