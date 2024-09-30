Return-Path: <netdev+bounces-130358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D5198A294
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 14:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E311F23893
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 12:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2761D18E023;
	Mon, 30 Sep 2024 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVGcVkSz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E8B18BBBC
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699658; cv=none; b=cwzRFhaF6acZACwYg7j/hh+tMyVyHlS05juOIk/Vem9+u9ZWy4ND0WBcC9GtVnV3INLqlVbDM8lIAMJjdheBOzIfclR+cEtTcQdNZ2q0L3fCBoLaORVZMl1Zx2Iwn1FW+g6r7Vl1iU9P+ioKudMoZ+n0nsfF215lB6kCE3jDlKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699658; c=relaxed/simple;
	bh=y6Yu/b1i8P5MR2s9bFPePt7VXpAuUQKY8kcEweB7Z5g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XDFzto1K2CSuR9KgbOUm6mn/sozx9wGz/KVS833Zv3OHK6X15fgEFcUcWE9QSU6rUB7+JIxfDBrAI3kPNFTlr1c2SeHyPxSzzj/8gg8TfT1ISWY71TQ1USll0MRN18bo3aLZuV4dby3D4tYPFGMwSS8q+3HemRWUi1KWdfwVo+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVGcVkSz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B452FC4CEC7;
	Mon, 30 Sep 2024 12:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727699657;
	bh=y6Yu/b1i8P5MR2s9bFPePt7VXpAuUQKY8kcEweB7Z5g=;
	h=From:Subject:Date:To:Cc:From;
	b=oVGcVkSzsbsFzodXo62dQvrktyuvCrI6Y2ywz/FJlsa+0WpvkcHf8UODRQ4pwogse
	 1r76HP4ZhPRi8riMpJntmI+sUQ3PI1Jc2u8Kl3qLZM0PSWmpMv0ZJQMniEJ6kNww3h
	 ifaKqWQ1/+nEk/S+o1sDF3oBqGOf5v81uVPtbGmwtcOaQOehnwvwtasidFNiYodQxi
	 u01keMnq4JIbujFuHXYfNJfByQzVkFw4bNXJerj6mXlqseP+72hFcqE4H8kHZwj0hT
	 fIv8WuGZpFkAnVQQjsSIwyEYrsAppzzqtFcoX5PklDPBB/lkruFm5fsmNWPxABIKxQ
	 G6qDwaJU5eNVw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next 0/2] net: airoha: Fix PSE memory configuration
Date: Mon, 30 Sep 2024 14:33:47 +0200
Message-Id: <20240930-airoha-eth-pse-fix-v1-0-f41f2f35abb9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKua+mYC/x2MywqAIBAAf0X23IKvS/1KdBBbcy8qGhGI/550n
 IGZDo0qU4NNdKj0cOOcJqhFgI8uXYR8TgYttZWrNui45uiQ7oilEQZ+MRhplLEkvQ8ww1Jp6n+
 6H2N87jzY3GQAAAA=
To: Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
 Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, upstream@airoha.com
X-Mailer: b4 0.14.1

Align PSE memory configuration to vendor SDK.
Increase initial value of PSE reserved memory in
airoha_fe_pse_ports_init() by the value used for the second Packet
Processor Engine (PPE2).
Do not overwrite the default value for the number of PSE reserved pages
in airoha_fe_set_pse_oq_rsv().
Post this series to net-next since these are not issues visible to the
user.

---
Lorenzo Bianconi (2):
      net: airoha: read default PSE reserved pages value before updating
      net: airoha: fix PSE memory configuration in airoha_fe_pse_ports_init()

 drivers/net/ethernet/mediatek/airoha_eth.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)
---
base-commit: c824deb1a89755f70156b5cdaf569fca80698719
change-id: 20240923-airoha-eth-pse-fix-f303134e0ccf

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


