Return-Path: <netdev+bounces-194595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB2DACACDB
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 12:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FEB3BF716
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 10:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB440205E26;
	Mon,  2 Jun 2025 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kl2e5rlK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79D5205E16
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748861764; cv=none; b=kiYXj5zlqWOeFGcFw+larp9nF96B+rEaIsAUbVpoCJ/go4yrdeGQOvYoyG9C0U8DbGwf+o1F2sykKWHsnca0VWGDzKqolTtpusGAUBK7mAwLFlNRvS9LzB6hiJJsbMm+qxr2xzSZzm5ZYnqazrhV1rr8dpa2cqEry6sMFiYy+so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748861764; c=relaxed/simple;
	bh=bir4tUxt7/G2lXTS4/G8XHslHlPXIFMwBBqhZnV0PaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FlQgZyFpedlRUpGSgptvqS70o7AR2+ZQsDgODQTs9UN7t7OJPDqkbzngaOKvfgY87Lomg/AEiNu4ZN08VgarocVVTme/I60EVHat+h2KPMdbZhjD401iZ63Fq7WZkBEVcEoOXzkA+O/Pnjt/gnXMy4Qr4m8GGXgMG79Of3jrAiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kl2e5rlK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE787C4CEEB;
	Mon,  2 Jun 2025 10:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748861764;
	bh=bir4tUxt7/G2lXTS4/G8XHslHlPXIFMwBBqhZnV0PaY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Kl2e5rlKCiNvhxnj0/N3KDau5K/WRaoMLPftTELQcULdgyJOpDJ+TWtu87d2glNCn
	 D0kYOUIzpYIM7Ci9SFvaqdym0qGZaDBD7AcEIL8CirD+LUjy/hQDxatMDiM1L09j4x
	 hcLmKcMSp0a82lViH8a9OjXfopPq2GnqOkiJlmhdv5papPqvwVgDpqgQqgkdzgt3An
	 ZfORauwWGO1S6nzT132NPXNrJAubD2TlmqJr6HHlZA8eLnKngFSV6u5UQBZomEWF3u
	 9RsQ5N/clnID10TDh8bt01O5QUXhcEzhdtDEqcHA1kwCcGHiLveHmLW6Xt54kdI7jD
	 5SIoIPcE6AI0g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 02 Jun 2025 12:55:39 +0200
Subject: [PATCH net v2 3/3] net: airoha: Fix smac_id configuration in
 bridge mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-airoha-flowtable-ipv6-fix-v2-3-3287f8b55214@kernel.org>
References: <20250602-airoha-flowtable-ipv6-fix-v2-0-3287f8b55214@kernel.org>
In-Reply-To: <20250602-airoha-flowtable-ipv6-fix-v2-0-3287f8b55214@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Set PPE entry smac_id field to 0xf in airoha_ppe_foe_commit_subflow_entry
routine for IPv6 traffic in order to instruct the hw to keep original
source mac address for IPv6 hw accelerated traffic in bridge mode.

Fixes: cd53f622611f ("net: airoha: Add L2 hw acceleration support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 557779093a79a4b42a1dc49b8ba0dacbdc219385..9067d2fc7706ecf489bee9fc9b6425de18acb634 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -660,6 +660,11 @@ airoha_ppe_foe_commit_subflow_entry(struct airoha_ppe *ppe,
 	if (type >= PPE_PKT_TYPE_IPV6_ROUTE_3T) {
 		memcpy(&hwe.ipv6.l2, &e->data.bridge.l2, sizeof(hwe.ipv6.l2));
 		hwe.ipv6.ib2 = e->data.bridge.ib2;
+		/* setting smac_id to 0xf instruct the hw to keep original
+		 * source mac address
+		 */
+		hwe.ipv6.l2.src_mac_hi = FIELD_PREP(AIROHA_FOE_MAC_SMAC_ID,
+						    0xf);
 	} else {
 		memcpy(&hwe.bridge.l2, &e->data.bridge.l2,
 		       sizeof(hwe.bridge.l2));

-- 
2.49.0


