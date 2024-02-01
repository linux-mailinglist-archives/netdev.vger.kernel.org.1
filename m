Return-Path: <netdev+bounces-67883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADD58452DC
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 09:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DE73B22A0A
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 08:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A4F15A48D;
	Thu,  1 Feb 2024 08:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cupDJHKg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C10615957F
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706776701; cv=none; b=VCoQh4+Sgn59nwolTFfJax3uJNaZlSSEreFdi0t8RNl36IFyvZXr/XduH8NmUSXWZZZXbWsYDtBP5GF78yI1NDS47SRy6YH2PUWAJrWhzVC8hhN075wphXfBjhv5hL0nPAn6hQEeEg6txU2Qh9RvQjzkvSABztCVBlYwwrNl+6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706776701; c=relaxed/simple;
	bh=UeDEbBS4ZCI5n4U/aoXtMkSEMN9vEAaDGmiMdoWBGEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ThqkIIOsQFkNLMiIVTCS4pbGbFtrlu/Dw+GAPCCrX5xsRBHM0OftL3CrkgzwDY+jI8NIWTK1Vrqyf/zO9BU9f2vsRALwpajEy6wkN6j+CEenHjJtokU70Fnuw79H7VWclBlOl7P0dvulmKQuU0UfWTFvcgAjPQk9TDKSGuzJbMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cupDJHKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E884C433F1;
	Thu,  1 Feb 2024 08:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706776700;
	bh=UeDEbBS4ZCI5n4U/aoXtMkSEMN9vEAaDGmiMdoWBGEw=;
	h=From:To:Cc:Subject:Date:From;
	b=cupDJHKgjzXOxEfkzQBOgEf5QZWbZOC7nIDPf2U4oAuu9pvwdHKv9AVuegv+fUaZ0
	 Yj+qDbeSsgChuwxJ2/MipiEteowsTFCh7FsLiV1+elgjANNP5c256QiW/rQ+MNxeFE
	 Bo+vpjBkbjqNQpNnd2Xq0NULGa7U5HfOIwIoC0h+Hx8eyK8eo2Oa4pC5oFDpQ1BM/Q
	 jpmKCZ8XU+uEDSz7NDSxPFi1JjCSLvwsSv+59ENK8bA+U+VPneTQ8dV3rQHkSPMT//
	 QZnD2V3PV+RaNphgl1xrD/LDa3Z4KHcQHtHVOrHRI6ra7/qpsxfq6zzP29gJZurDi3
	 XsJxF/E4aW/mg==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net] tunnels: fix out of bounds access when building IPv6 PMTU error
Date: Thu,  1 Feb 2024 09:38:15 +0100
Message-ID: <20240201083817.12774-1-atenart@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the ICMPv6 error is built from a non-linear skb we get the following
splat,

  BUG: KASAN: slab-out-of-bounds in do_csum+0x220/0x240
  Read of size 4 at addr ffff88811d402c80 by task netperf/820
  CPU: 0 PID: 820 Comm: netperf Not tainted 6.8.0-rc1+ #543
  ...
   kasan_report+0xd8/0x110
   do_csum+0x220/0x240
   csum_partial+0xc/0x20
   skb_tunnel_check_pmtu+0xeb9/0x3280
   vxlan_xmit_one+0x14c2/0x4080
   vxlan_xmit+0xf61/0x5c00
   dev_hard_start_xmit+0xfb/0x510
   __dev_queue_xmit+0x7cd/0x32a0
   br_dev_queue_push_xmit+0x39d/0x6a0

Use skb_checksum instead of csum_partial who cannot deal with non-linear
SKBs.

Fixes: 4cb47a8644cc ("tunnels: PMTU discovery support for directly bridged IP packets")
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 net/ipv4/ip_tunnel_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 586b1b3e35b8..80ccd6661aa3 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -332,7 +332,7 @@ static int iptunnel_pmtud_build_icmpv6(struct sk_buff *skb, int mtu)
 	};
 	skb_reset_network_header(skb);
 
-	csum = csum_partial(icmp6h, len, 0);
+	csum = skb_checksum(skb, skb_transport_offset(skb), len, 0);
 	icmp6h->icmp6_cksum = csum_ipv6_magic(&nip6h->saddr, &nip6h->daddr, len,
 					      IPPROTO_ICMPV6, csum);
 
-- 
2.43.0


