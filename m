Return-Path: <netdev+bounces-162342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E1AA26936
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 02:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD491655DF
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 01:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C16C46434;
	Tue,  4 Feb 2025 01:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJNomNok"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458594414
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 01:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630843; cv=none; b=BmC604214JI+/NqiK8ZlcAw/KCuI60o2vnAqFOIYckmX3vZXPrzBMq17TX5E4nXxtEtzw+8ZXooExC9WoG1VIqk9Eha76mJUhgcZEStlCE4WWBmkxJyn802BkR0+P+uYW8TXX7s8Vr5u9UUwiPexLYH8XHjbJ2aVrb6AfaSSkQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630843; c=relaxed/simple;
	bh=/LT7a7JbVtF0LJ6nsBbcPKTZwSCqkIHuFdN5EjnSXeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2cdeO7pq08alFp1SZppeoSmmBnmMcnbiP/x2q7KPdXKINlnwsUSuxgleTZbRNL7PNm+vyWzVACyJgmaMJAjDJ+ubJuRBxQkWgYtWkepKtIbh2MA9vpK2CwfYsbwsKyupWlAQ+/3LoxcxXMkb012LwyVfH9r/PpAYaV1XRUGLZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJNomNok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83D6C4CEE6;
	Tue,  4 Feb 2025 01:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738630843;
	bh=/LT7a7JbVtF0LJ6nsBbcPKTZwSCqkIHuFdN5EjnSXeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SJNomNokouhokZH51LzO9YoBm1Vgnda6A1EflMsLxZvvjqIjknf8qlOOZSid7AlnV
	 DuIQKgcmhYmxxNH/fsqJFI4ei9Spz/ALnRLfvjjNaoFstOKE1GJnKWDyWphGWADVc7
	 qDmfe8FH2d8aHdQ0zpC19tOZDWKiO59q4nbquFSkX/vvouIjo4+qsaesXGcZ41kA9X
	 MJwwoF0r1YPOd25v4eRWltLyQP8ote9YWka/k65KeJD/r2NSkU+Bv7DWMHxBT177UF
	 GV8yT7t/HXmPeccW6NW3K7+R5JrblP84V4rKNyU/CQsjkVmHQmc5kgskz+N9SlRBr3
	 PKOkQ20woDzSw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Alexander Duyck <alexanderduyck@meta.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/2] eth: fbnic: set IFF_UNICAST_FLT to avoid enabling promiscuous mode when adding unicast addrs
Date: Mon,  3 Feb 2025 17:00:38 -0800
Message-ID: <20250204010038.1404268-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204010038.1404268-1-kuba@kernel.org>
References: <20250204010038.1404268-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Duyck <alexanderduyck@meta.com>

I realized when we were adding unicast addresses we were enabling
promiscous mode. I did a bit of digging and realized we had overlooked
setting the driver private flag to indicate we supported unicast filtering.

Example below shows the table with 00deadbeef01 as the main NIC address,
and 5 additional addresses in the 00deadbeefX0 format.

  # cat $dbgfs/mac_addr
  Idx S TCAM Bitmap       Addr/Mask
  ----------------------------------
  00  0 00000000,00000000 000000000000
                          000000000000
  01  0 00000000,00000000 000000000000
                          000000000000
  02  0 00000000,00000000 000000000000
                          000000000000
  ...
  24  0 00000000,00000000 000000000000
                          000000000000
  25  1 00100000,00000000 00deadbeef50
                          000000000000
  26  1 00100000,00000000 00deadbeef40
                          000000000000
  27  1 00100000,00000000 00deadbeef30
                          000000000000
  28  1 00100000,00000000 00deadbeef20
                          000000000000
  29  1 00100000,00000000 00deadbeef10
                          000000000000
  30  1 00100000,00000000 00deadbeef01
                          000000000000
  31  0 00000000,00000000 000000000000
                          000000000000

Before rule 31 would be active. With this change it correctly sticks
to just the unicast filters.

Signed-off-by: Alexander Duyck <alexanderduyck@meta.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 7a96b6ee773f..1db57c42333e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -628,6 +628,8 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	fbnic_rss_key_fill(fbn->rss_key);
 	fbnic_rss_init_en_mask(fbn);
 
+	netdev->priv_flags |= IFF_UNICAST_FLT;
+
 	netdev->features |=
 		NETIF_F_RXHASH |
 		NETIF_F_SG |
-- 
2.48.1


