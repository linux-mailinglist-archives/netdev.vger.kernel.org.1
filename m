Return-Path: <netdev+bounces-263751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFN8K4gPqGk8ngAAu9opvQ
	(envelope-from <netdev+bounces-263751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:55:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 546EF1FE982
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3FDC301135E
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 10:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE11C3A8734;
	Wed,  4 Mar 2026 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="uaPvPuCp"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B063A451F
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 10:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772621701; cv=none; b=e9dS5hB3QWZmhmDVFIgvrPdc3k9D+pWoKtypFa3vLSiCcFzRSx9CoO7w1QwrhQCQQuXFM0rn1zGeqOjS948dZG1fq6jkpmE/AQVlePXKtk1Jb07aMfbhreOZld21SdOmYRZ3iC2OTo0hhPMYGcL0S22G+conQLeLpNSLExLlrgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772621701; c=relaxed/simple;
	bh=wDy7lwFKEmxDMoxtDsk2M2wdV9BvNz6hH7XPQGFhta4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZTw2vmpuNFX+8NZavqPoSFSNVdGThEbjZzr03/3mwTJpQOTzV2c0LrOUNkwIB93PUfMiuG5T0/MXNbC4AVkvKU7KsDfpyyG1mo3zzgHw6E/7j2l5bA6qSeM5ngjn1Nt/JZv+xB5dWCro25zwBriyTYQ7x9dxJty5YbzV9xqCsTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=uaPvPuCp; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7A166A0042;
	Wed,  4 Mar 2026 11:54:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1772621695; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=4b9fzcnuJ5ddgbvup+eksWHf93kQSgMRpetZAz6W3xs=;
	b=uaPvPuCpSA272XD6nS9FebqZROU28DFkJhfLu+5ISNguZ/yW0F5o0DJkiOk1QPjlUOFAez
	dH957J95U9+cVPD4To2vHMzRaGqPbX/7D+yLxlKl30tCByIs6vgYtkfKU1ZP7hITkM4uf0
	up1d2/6y+Nw7NwQXvebVKFNXy4WRWPURwZuJM0hmmLHghBUAjfcvfJ2D8MmDncVOYJb0vN
	7RGqwqYfs+wIAE5xzi21z2GhgjVsFTCqfxyKoAmAwMkxU7RgY/phYq0eHekBnythkt0CyP
	F5nDcJKQ4Xnb/jDtFGO6vbLQHWOzPgayt47Yu2Fg2FGtrIJs1uLRvc0q1GzTww==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	phil@raspberrypi.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v6 0/5] net: cadence: macb: add IEEE 802.3az EEE support
Date: Wed,  4 Mar 2026 11:54:27 +0100
Message-ID: <20260304105432.631186-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 546EF1FE982
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263751-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,tuxon.dev:email,tipi-net.de:dkim,tipi-net.de:mid]
X-Rspamd-Action: no action

Add Energy Efficient Ethernet (IEEE 802.3az) support to the Cadence GEM
(macb) driver using phylink's managed EEE framework. The GEM MAC has
hardware LPI registers but no built-in idle timer, so the driver
implements software-managed TX LPI using a delayed_work timer while
delegating EEE negotiation and ethtool state to phylink.

Changes from v5:
  - macb_tx_lpi_set() no longer manages its own spinlock; it now
    requires bp->lock to be held by the caller and asserts this with
    lockdep_assert_held(). All callers (macb_tx_lpi_work_fn,
    macb_mac_enable_tx_lpi, macb_mac_disable_tx_lpi) take bp->lock
    explicitly. Based on feedback from Jakub Kicinski.
  - macb_tx_lpi_wake() is now called under the existing bp->lock in
    macb_start_xmit(), eliminating the redundant lock acquire/release.
    An eee_active check at the top of macb_tx_lpi_wake() short-circuits
    the register read on the common (EEE-disabled) path. Based on
    feedback from Jakub Kicinski.
  - macb_tx_all_queues_idle() uses READ_ONCE for tx_head/tx_tail
    (called under bp->lock; taking tx_ptr_lock here would invert the
    established lock order). Loop rewritten to match the driver
    convention: for (q = 0, queue = bp->queues; ...; ++q, ++queue).
    Based on feedback from Jakub Kicinski and Claudiu Beznea.
  - Added Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev> to
    patches 1-4.

Changes from v4:
  - Removed redundant MACB_CAPS_EEE guards from macb_get_eee/set_eee;
    phylink already returns -EOPNOTSUPP when lpi_capabilities and
    lpi_interfaces are not populated. Based on feedback from Russell King.
  - Added patch 5 enabling EEE for Mobileye EyeQ5, tested by Théo Lebrun
    using a hardware loopback.

Changes from v3:
  - Dropped the register-definitions-only patch; LPI counter offsets
    (GEM_RXLPI/RXLPITIME/TXLPI/TXLPITIME) now land in the statistics
    patch, and TXLPIEN + MACB_CAPS_EEE are introduced alongside the TX
    LPI implementation where they are first used. Series is now 4 patches.
  - Add Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com> to all patches.
  - Split chained assignment in macb_tx_lpi_set() (suggested by
    checkpatch).

Changes from v2:
  - macb_tx_lpi_set() now returns bool indicating whether the register
    value actually changed, avoiding redundant writes.
  - Removed tx_lpi_enabled field from struct macb; LPI state is tracked
    entirely within the spinlock-protected register read/modify/write.
  - macb_tx_lpi_wake() uses the return value of macb_tx_lpi_set() to
    skip the cancel/udelay when TXLPIEN was already clear.
  All changes based on feedback from Russell King.

Changes from v1:
  - Rewrote to use phylink managed EEE (mac_enable_tx_lpi /
    mac_disable_tx_lpi callbacks) instead of the obsolete
    phy_init_eee() approach, as recommended by Russell King.
  - ethtool get_eee/set_eee are now pure phylink passthroughs.
  - Removed all manual EEE state tracking from mac_link_up/down;
    phylink handles the lifecycle.

The series is structured as follows:

  1. LPI statistics: Expose the four hardware EEE counters (RX/TX LPI
     transitions and time) through ethtool -S, accumulated in software
     since they are clear-on-read. Adds register offset definitions
     GEM_RXLPI/RXLPITIME/TXLPI/TXLPITIME (0x270-0x27c).

  2. TX LPI engine: Introduces GEM_TXLPIEN (NCR bit 19) and
     MACB_CAPS_EEE alongside the implementation that uses them.
     phylink mac_enable_tx_lpi / mac_disable_tx_lpi callbacks with a
     delayed_work-based idle timer. LPI entry is deferred 1 second
     after link-up per IEEE 802.3az. Wake before transmit with a
     conservative 50us PHY wake delay (IEEE 802.3az Tw_sys_tx).

  3. ethtool EEE ops: get_eee/set_eee delegating to phylink for PHY
     negotiation and timer management.

  4. RP1 enablement: Set MACB_CAPS_EEE for the Raspberry Pi 5's RP1
     southbridge (Cadence GEM_GXL rev 0x00070109 + BCM54213PE PHY).

  5. EyeQ5 enablement: Set MACB_CAPS_EEE for the Mobileye EyeQ5 GEM
     instance, verified with a hardware loopback by Théo Lebrun.

Tested on Raspberry Pi 5 (1000BASE-T, BCM54213PE PHY, 250ms LPI timer):

  iperf3 throughput (no regression):
    TCP TX: 937.8 Mbit/s (EEE on) vs 937.0 Mbit/s (EEE off)
    TCP RX: 936.5 Mbit/s both

  Latency (ping RTT, small expected increase from LPI wake):
    1s interval:  0.273 ms (EEE on) vs 0.181 ms (EEE off)
    10ms interval: 0.206 ms (EEE on) vs 0.168 ms (EEE off)
    flood ping:   0.200 ms (EEE on) vs 0.156 ms (EEE off)

  LPI counters (ethtool -S, 1s-interval ping, EEE on):
    tx_lpi_transitions: 112
    tx_lpi_time: 15574651

  Zero packet loss across all tests. Also verified with
  ethtool --show-eee / --set-eee and cable unplug/replug cycling.

Nicolai Buchwitz (5):
  net: cadence: macb: add EEE LPI statistics counters
  net: cadence: macb: implement EEE TX LPI support
  net: cadence: macb: add ethtool EEE support
  net: cadence: macb: enable EEE for Raspberry Pi RP1
  net: cadence: macb: enable EEE for Mobileye EyeQ5

 drivers/net/ethernet/cadence/macb.h      |  20 +++++
 drivers/net/ethernet/cadence/macb_main.c | 145 ++++++++++++++++++++++++++++++-
 2 files changed, 163 insertions(+), 2 deletions(-)

--
2.51.0


