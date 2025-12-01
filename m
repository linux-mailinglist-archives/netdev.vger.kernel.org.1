Return-Path: <netdev+bounces-243110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E6EC999B1
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 00:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C4B04E0F10
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 23:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3522877E8;
	Mon,  1 Dec 2025 23:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZAi/Kie"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FB3192B75
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 23:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764632341; cv=none; b=LtqxsPCl9vsIoDoQ19rs0fuTLgQU23WiP0VHg8YXCMo/Qdr5JIsZeMy7PKdg+UnX39hgvXQwquM5PID55CgqV67jHGsNSoiASDU1ebcESw8wHKRB9jkprDPZl8F1kQxq08c94BPkWn+VXj9qV4J0XcrF25QzXIxvN66Ha9MEp98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764632341; c=relaxed/simple;
	bh=4ZIEfYHOi2hD96d4HhYvBUifSfLFFaUZQ52Ws4FVCKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B8DyfYpXmmrDuEmqrlfmKPqX7MT2dfxZlVqPAESLQ+Ov89jaWzYLlWO51PGxDAYcCtGVxB65gL4FErlPY9HLUKf4Fc2RMciG7eusBTB1cZsNLKcQBkebkPUAKCCecGi6xYPXq6b5ZYYxyCUhCr5tDVBlqOsOJlAZtOPEeyBoC18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZAi/Kie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80983C4CEF1;
	Mon,  1 Dec 2025 23:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764632341;
	bh=4ZIEfYHOi2hD96d4HhYvBUifSfLFFaUZQ52Ws4FVCKk=;
	h=From:To:Cc:Subject:Date:From;
	b=fZAi/KieWFZHV7oZ/NbH9+5N8Yt47vFE0gFPJvA8REqOltYmltJDIvRcJemLL8n1G
	 s7nr58iutLiaq6wWYVTXDVIBlIBTD0HEAJwC7px3yDLHPGsWAGMY+TUTBGt76pU6nl
	 SICua/KV2MkQX2DmPxUNJ49mP+CekdMOyEHuVKno8qQOYpXSERY+hYOj+pZJaJbpHw
	 OnuWbZ5PJL97AehBseHYExCOd9zdKPTlnkP6wZ49Nebm7ag/tkFnc5ueSTNrNzB2Og
	 PRkfrM/es0weH2bTSGoVv1jrWMthAyMZ+vRURdD93ifU8iEJB1IBHGcCQhNkB47Mnc
	 KGC1H9VPp4SXQ==
From: Jesse Brandeburg <jbrandeb@kernel.org>
To: netdev@vger.kernel.org
Cc: Jesse Brandeburg <jbrandeburg@cloudflare.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jake Keller <jacob.e.keller@intel.com>,
	IWL <intel-wired-lan@lists.osuosl.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Brett Creeley <brett.creeley@intel.com>
Subject: [PATCH net v1] ice: stop counting UDP csum mismatch as rx_errors
Date: Mon,  1 Dec 2025 15:38:52 -0800
Message-ID: <20251201233853.15579-1-jbrandeb@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jesse Brandeburg <jbrandeburg@cloudflare.com>

Since the beginning, the Intel ice driver has counted receive checksum
offload mismatches into the rx_errors member of the rtnl_link_stats64
struct. In ethtool -S these show up as rx_csum_bad.nic.

I believe counting these in rx_errors is fundamentally wrong, as it's
pretty clear from the comments in if_link.h and from every other statistic
the driver is summing into rx_errors, that all of them would cause a
"hardware drop" except for the UDP checksum mismatch, as well as the fact
that all the other causes for rx_errors are L2 reasons, and this L4 UDP
"mismatch" is an outlier.

A last nail in the coffin is that rx_errors is monitored in production and
can indicate a bad NIC/cable/Switch port, but instead some random series of
UDP packets with bad checksums will now trigger this alert. This false
positive makes the alert useless and affects us as well as other companies.

This packet with presumably a bad UDP checksum is *already* passed to the
stack, just not marked as offloaded by the hardware/driver. If it is
dropped by the stack it will show up as UDP_MIB_CSUMERRORS.

And one more thing, none of the other Intel drivers, and at least bnxt_en
and mlx5 both don't appear to count UDP offload mismatches as rx_errors.

Here is a related customer complaint:
https://community.intel.com/t5/Ethernet-Products/ice-rx-errros-is-too-sensitive-to-IP-TCP-attack-packets-Intel/td-p/1662125

Fixes: 4f1fe43c920b ("ice: Add more Rx errors to netdev's rx_error counter")
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jake Keller <jacob.e.keller@intel.com>
Cc: IWL <intel-wired-lan@lists.osuosl.org>
Signed-off-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
--
I am sending this to net as I consider it a bug, and it will backport
cleanly.
---
 drivers/net/ethernet/intel/ice/ice_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 86f5859e88ef..d004acfa0f36 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6995,7 +6995,6 @@ void ice_update_vsi_stats(struct ice_vsi *vsi)
 		cur_ns->rx_errors = pf->stats.crc_errors +
 				    pf->stats.illegal_bytes +
 				    pf->stats.rx_undersize +
-				    pf->hw_csum_rx_error +
 				    pf->stats.rx_jabber +
 				    pf->stats.rx_fragments +
 				    pf->stats.rx_oversize;
-- 
2.47.3


