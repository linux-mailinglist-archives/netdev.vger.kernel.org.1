Return-Path: <netdev+bounces-260426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ABPJ4xunWk9QAQAu9opvQ
	(envelope-from <netdev+bounces-260426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:25:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1574D184880
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A50131B1BEC
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACF236B07A;
	Tue, 24 Feb 2026 09:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="TSpXXJVC"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA5B36A012
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924748; cv=none; b=t/2iywn2qREgAdJFMrmmWTFvPsLia2TXMqKwYoM1VSvmP9D+EQWmV8b+W5IxkjmwkeDQNGxSG8FEl/kXnzu/HgEW9zXm/X5whb1UebotRfdq6FGzue9c4wzBY/kXXScHKb/achzJOCZzZ2MeQzOCqYXTh7YnH5QsQ+qh9PMl4FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924748; c=relaxed/simple;
	bh=sjgtJVbl1abi1dUSmOrmfiiGhQZ78HhiunRrGwIi6sA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wv6OdiScou745zQAk19RJ/9Po+zJQAsWcBGrp87ceZpoTFNFsiyiSVI1emC2LHCNbwYfP5N6BYH9XgM4G6PtddR399ljGItxa7GKRsEt85QcDppdoqX3xH0IxOiE1gKxgb4liT+6UpqHR/rZpza5xYv1e+oa3Mu8klI7h2m/F3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=TSpXXJVC; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A422FA02E5;
	Tue, 24 Feb 2026 10:18:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1771924736; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=xKiYHilBDkFw9vY6ln5kVKe3paKaWzG6iDqMI1Iglsg=;
	b=TSpXXJVCEAxDlubcIreQ/ZNgLRXfhu/f1zEuL1Wbp6/8ZcOSbWv6BL6wYWmrxyVEQtQAIy
	A5Aj6RPouzjJi0YvMzPqI9UOiV5LaHnd8VqRyELRStWaZv2EygwZZ4NxxO/WU0dgbwo0Sl
	5RWTjGQDZS4kxcQpDUBNHyMh09O3a/n8ULrqhJiC2K9+anIv8YWJMv/ecCTbVXZVYSfTl8
	LVV23HjSo0+RkU1oGNZzGG8cdAts1XD2BDF7SCU37FQ0SK22z6O5eTKES98wGczFskhg8N
	6rqDEux1/Yorn5u979QoDjLsRtDO/bd9CQlKbqvdVfXerWlXSnIzyeOViDl1WA==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	claudiu.beznea@tuxon.dev,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	nicolas.ferre@microchip.com,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	phil@raspberrypi.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v2 0/5] net: cadence: macb: add IEEE 802.3az EEE support
Date: Tue, 24 Feb 2026 10:18:16 +0100
Message-Id: <20260224091821.47671-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[tipi-net.de];
	TAGGED_FROM(0.00)[bounces-260426-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:mid,tipi-net.de:dkim]
X-Rspamd-Queue-Id: 1574D184880
X-Rspamd-Action: no action

Add Energy Efficient Ethernet (IEEE 802.3az) support to the Cadence GEM
(macb) driver using phylink's managed EEE framework. The GEM MAC has
hardware LPI registers but no built-in idle timer, so the driver
implements software-managed TX LPI using a delayed_work timer while
delegating EEE negotiation and ethtool state to phylink.

Changes from v1:
  - Rewrote to use phylink managed EEE (mac_enable_tx_lpi /
    mac_disable_tx_lpi callbacks) instead of the obsolete
    phy_init_eee() approach, as recommended by Russell King.
  - ethtool get_eee/set_eee are now pure phylink passthroughs.
  - Removed all manual EEE state tracking from mac_link_up/down;
    phylink handles the lifecycle.

The series is structured as follows:

  1. Register definitions: LPI counter offsets (0x270-0x27c), TXLPIEN
     bitfield (NCR bit 19), and MACB_CAPS_EEE capability flag.

  2. LPI statistics: Expose the four hardware EEE counters (RX/TX LPI
     transitions and time) through ethtool -S, accumulated in software
     since they are clear-on-read.

  3. TX LPI engine: phylink mac_enable_tx_lpi / mac_disable_tx_lpi
     callbacks with a delayed_work-based idle timer. LPI entry is
     deferred 1 second after link-up per IEEE 802.3az. Wake before
     transmit with a conservative 50us PHY wake delay.

  4. ethtool EEE ops: get_eee/set_eee delegating to phylink for PHY
     negotiation and timer management.

  5. RP1 enablement: Set MACB_CAPS_EEE for the Raspberry Pi 5's RP1
     southbridge (Cadence GEM_GXL rev 0x00070109 + BCM54213PE PHY).

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
  net: cadence: macb: add EEE register definitions and capability flag
  net: cadence: macb: add EEE LPI statistics counters
  net: cadence: macb: implement EEE TX LPI support
  net: cadence: macb: add ethtool EEE support
  net: cadence: macb: enable EEE for Raspberry Pi RP1

 drivers/net/ethernet/cadence/macb.h      |  21 ++++
 drivers/net/ethernet/cadence/macb_main.c | 135 ++++++++++++++++++++++-
 2 files changed, 155 insertions(+), 1 deletion(-)

-- 
2.51.0


