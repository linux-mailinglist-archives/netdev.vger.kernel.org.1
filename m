Return-Path: <netdev+bounces-170481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FB5A48DDE
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367D01682AD
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 01:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982E4208CA;
	Fri, 28 Feb 2025 01:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cm31Vgus"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7420B182D0
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 01:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740705937; cv=none; b=ar3CKiXV34NClAM83gHkR3Hkn8Q+ZPdeBQOuimNkytfO3eLRFjpr1zMWqvNbI5tG5lPTmRVxsb6kPDoYLq44Z9phF2weDZ50stQBr99hSPiKeVob9vf7YilqcpjdN2BnxLg+Tw5d/u/gS4MQ6+EBm0EBJLLht24keUIMX1BHFCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740705937; c=relaxed/simple;
	bh=DPe9GwnhcGH5vKOGJuuU+1RUFo4AFMT02ZdRiOO7D+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mUKKmFU7FBGI2/fsPmKUtRKjewr26pLhhx3HIIkuPG2ie5DBKCEcS1ZEP9GQLvcv5XJvU/BMQsqw33lEm7Tvts6NUKzFtN4QhNjBBoE9nLm+eqbNHbmtooCiBW4irN/tbPnK/3dBbrnjnFI6evXwRIaFXZC1ksCM32BwelUD3ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cm31Vgus; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D4CC4CEDD;
	Fri, 28 Feb 2025 01:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740705936;
	bh=DPe9GwnhcGH5vKOGJuuU+1RUFo4AFMT02ZdRiOO7D+A=;
	h=From:To:Cc:Subject:Date:From;
	b=cm31Vguss4U3mTG1RZnpJepZGNVmYFdJxscnNKff+TgRI2Mn0rVXyvgAkt8ezTAJS
	 80ZSiW6cX8wE+VGxej0/uZ19zE6R2WIovbp0RLigYSAkLeELE8LqwUfkNWMH3N/8/b
	 3rbNSzxPiHgNQO47DQbHlE1j+0K1BzG78GPiSx+XhLc+uWkcad0U8SBEJkGA/wUMqD
	 i4uwg4n61n/EZ4MNMLOCBif1q1/v40iVhn7N2/XnBduhg9quKYnCJzfA9PtcpUcP/j
	 Dt8DLnu4HuZZR83EaTPRw/sGcu5x3zV+uS+ljHP+Hki405cF95i6tu/pSnfF3GSm+w
	 VYSPDxODwB5sQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/9] eth: bnxt: maintain basic pkt/byte counters in SW
Date: Thu, 27 Feb 2025 17:25:25 -0800
Message-ID: <20250228012534.3460918-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some workloads want to be able to track bandwidth utilization on
the scale of 10s of msecs. bnxt uses HW stats and async stats
updates, with update frequency controlled via ethtool -C.
Updating all HW stats more often than 100 msec is both hard for
the device and consumes PCIe bandwidth. Switch to maintaining
basic Rx / Tx packet and byte counters in SW.

Tested with drivers/net/stats.py:
  # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0

Manually tested by comparing the ethtool -S stats (which continues
to show HW stats) with qstats, and total interface stats.
With and without HW-GRO, and with XDP on / off.
Stopping and starting the interface also doesn't corrupt the values.

v2:
 - fix skipping XDP vs the XDP Tx ring handling (Michael)
 - rename the defines as well as the structs (Przemek)
 - fix counding frag'ed packets in XDP Tx
v1: https://lore.kernel.org/20250226211003.2790916-1-kuba@kernel.org

Jakub Kicinski (9):
  eth: bnxt: use napi_consume_skb()
  eth: bnxt: don't run xdp programs on fallback traffic
  eth: bnxt: rename ring_err_stats -> ring_drv_stats
  eth: bnxt: snapshot driver stats
  eth: bnxt: don't use ifdef to check for CONFIG_INET in GRO
  eth: bnxt: consolidate the GRO-but-not-really paths in bnxt_gro_skb()
  eth: bnxt: maintain rx pkt/byte stats in SW
  eth: bnxt: maintain tx pkt/byte stats in SW
  eth: bnxt: count xdp xmit packets

 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  49 +++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |   3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 213 +++++++++++-------
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  20 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  43 +++-
 5 files changed, 228 insertions(+), 100 deletions(-)

-- 
2.48.1


