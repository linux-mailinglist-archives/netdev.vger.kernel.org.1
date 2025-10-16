Return-Path: <netdev+bounces-229973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1D0BE2C5E
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04DDE19C78A9
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6205B29CE1;
	Thu, 16 Oct 2025 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHciSve+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376B3328607;
	Thu, 16 Oct 2025 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610518; cv=none; b=dJ5hb6685ebx+qveYx9Tnw4JrQbAUw01ffq007yAT9dC7SEoJjbeXYq188giSMbbQIFdMUxt3Uy3vO49Pphx3DbILBWKJQ81t18LdifE/MDE7FrPKBxfAH19bQQ+MUpGvGDuSY+SECTRDMXJd/tyRNoLYXOL+dGAq/5ry8TIAqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610518; c=relaxed/simple;
	bh=7ACd7nRHcRazteVxLXW9lw48ww6CyQ/yAb+kOxQueDY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mMopkm33a4iKey0QMKAlJ2FYWO0EtgQ55Or5wnAoZC8ZymauPecIq9jn+z80WdIFQyFQiFTm09VDf8AoUHMXuCQwj4DbLvSD8nPWa5jjz3a91CoIMqugNrnyki99D45Bk6PgLvyo+pg1ciLWfEFZexErf5mOyZpG4xg+C+jwcYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHciSve+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD6DC4CEF1;
	Thu, 16 Oct 2025 10:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760610517;
	bh=7ACd7nRHcRazteVxLXW9lw48ww6CyQ/yAb+kOxQueDY=;
	h=From:Subject:Date:To:Cc:From;
	b=jHciSve+YgrR5ZPP1cvzv1c1Q88lR62qr0SQy/FtXLTg+bkyqTv6sUdBsnsACQHLG
	 dhYAG2tbPPpYnYZ3VbcIJyjzuumV3JzucaMSCOIJw3lbiZNkWFavZy3HjhN+BiEtZA
	 GbTOuDz+gvwsNFnNF7oYk/ppu2Tdg6vASLls6O/No58CV6Yq6zle9CgYiCVVVkU2Rd
	 yA+E7wi5cA8qCWrJkiXLxE2hY/ubTKjiaSUs4VnQDt3Imqlp6pg9laoYoX/GrsIKs/
	 Kv8uz7K4Z8ICsk9LkIPLhy5edltXTol8yMZnmoApliKDGN4v1U7GI3rVIjdb5ID4FM
	 3FUnz2UZgXkGQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v2 00/13] net: airoha: Add AN7583 ethernet
 controller support
Date: Thu, 16 Oct 2025 12:28:14 +0200
Message-Id: <20251016-an7583-eth-support-v2-0-ea6e7e9acbdb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL7I8GgC/22NQQ6CMBBFr0Jm7ZhpoQiuvIdhQWSARtM2U2w0h
 LtbiUuX7yX//RUii+UI52IF4WSj9S6DPhRwm3s3MdohM2jSRhFV2LuTaUrkZcb4DMHLgqrXox7
 qqi0bgjwMwqN97dFrl3m2cfHy3j+S+tpfTpl/uaSQkOqqMWYk0+rycmdx/Dh6maDbtu0DZDhTG
 LUAAAA=
X-Change-ID: 20251004-an7583-eth-support-1a2f2d649380
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, Simon Horman <horms@kernel.org>, 
 Christian Marangi <ansuelsmth@gmail.com>
X-Mailer: b4 0.14.2

Introduce support for AN7583 ethernet controller to airoha-eth dirver.
The main differences between EN7581 and AN7583 is the latter runs a
single PPE module while EN7581 runs two of them. Moreover PPE SRAM in
AN7583 SoC is reduced to 8K (while SRAM is 16K on EN7581).

---
Changes in v2:
- rely on IS_ENABLED(CONFIG_NET_AIROHA_FLOW_STATS) instead of ifedef
  CONFIG_NET_AIROHA_FLOW_STATS in airoha_ppe_get_num_stats_entries
  routine
- return number of stats_entries from airoha_ppe_get_num_stats_entries()
  and airoha_ppe_get_total_num_stats_entries()
- remove magic number in airoha_ppe_foe_commit_sram_entry routine
- improve code readability in airhoha_set_gdm2_loopback routine adding
  some macros
- improve commit logs
- remove magic numbers in airoha_ppe_foe_get_entry_locked()
- Link to v1: https://lore.kernel.org/r/20251015-an7583-eth-support-v1-0-064855f05923@kernel.org

---
Lorenzo Bianconi (13):
      dt-bindings: net: airoha: Add AN7583 support
      net: airoha: ppe: Dynamically allocate foe_check_time array in airoha_ppe struct
      net: airoha: Add airoha_ppe_get_num_stats_entries() and airoha_ppe_get_num_total_stats_entries()
      net: airoha: Add airoha_eth_soc_data struct
      net: airoha: Generalize airoha_ppe2_is_enabled routine
      net: airoha: ppe: Move PPE memory info in airoha_eth_soc_data struct
      net: airoha: ppe: Remove airoha_ppe_is_enabled() where not necessary
      net: airoha: ppe: Configure SRAM PPE entries via the cpu
      net: airoha: ppe: Flush PPE SRAM table during PPE setup
      net: airoha: Select default ppe cpu port in airoha_dev_init()
      net: airoha: Refactor src port configuration in airhoha_set_gdm2_loopback
      net: airoha: ppe: Do not use magic numbers in airoha_ppe_foe_get_entry_locked()
      net: airoha: Add AN7583 SoC support

 .../devicetree/bindings/net/airoha,en7581-eth.yaml |  60 ++++-
 drivers/net/ethernet/airoha/airoha_eth.c           | 254 ++++++++++++++------
 drivers/net/ethernet/airoha/airoha_eth.h           |  65 ++++--
 drivers/net/ethernet/airoha/airoha_ppe.c           | 259 ++++++++++++++-------
 drivers/net/ethernet/airoha/airoha_ppe_debugfs.c   |   3 +-
 drivers/net/ethernet/airoha/airoha_regs.h          |   6 +-
 6 files changed, 456 insertions(+), 191 deletions(-)
---
base-commit: 00922eeaca3c5c2001781bcad40e0bd54d0fdbb6
change-id: 20251004-an7583-eth-support-1a2f2d649380

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


