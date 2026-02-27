Return-Path: <netdev+bounces-261875-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2I2/OTa0oWmMvgQAu9opvQ
	(envelope-from <netdev+bounces-261875-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:11:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 492361B97C4
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A4A930A053B
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CA5436344;
	Fri, 27 Feb 2026 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="sa8TUGGk"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E8442EEB0;
	Fri, 27 Feb 2026 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204929; cv=none; b=e4+t+0US8/Qo44wxcbUjWVdTdzBFYOK2xELedXIy520efQbHVd5K+tk+9ZsJrkSbHGEUzPNzLky1qEfjoS6LSuUI4ct09k3gWw9HwCLcdrvF29Xv0ClgcHE1Xbek9YOfaAE4IALFJ84FxErm8bBfTykQic9S7FjiU9TvaeUlJdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204929; c=relaxed/simple;
	bh=f2kfGH116KzX79wZr+txjpVvF2HZyCV+Oj53yvAZHxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cetfvnCr7L3w/ybxnMbiXacSk7KTcvNBqCPd/DVYiyzwq4D2/iRUjXb4ZGGU40AwYWA711h1pTC8kLOvIWtCmvTHLtUi61Upm0vtzMB2kI/fuxI1dvuFg8k1MUIBOrIf4P2Ql4pnyOMcrdJzIArzVcRG5JsA6XBLhScTf0vM2Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=sa8TUGGk; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DAFC7A4FB6;
	Fri, 27 Feb 2026 16:08:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1772204923; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MI/AUX7s9MIyRYPCeAlGjNBvlJqOiHqYeew4KPUYIWE=;
	b=sa8TUGGkDWZM1Q6kUBTwKY7h3GtGstYySJ8pW8MCJ48wScleMBsFabSH9i1XWQmlNjyugp
	KkvVi7tOnklqoo7M7kYrbmi93Z+fb2vC1zzW606h3/9e+DJaM6B4v1Zm1BjnvGuYFt660W
	dCIsXvOsVwLc4+jWUo+Bw8y1CoA3WiFOMLNoLyUfFblqjCLPp2YDIlw2j99sJBdjS6Uu1X
	Nk5dJOwx8NhDbQKUkuDcwEO8ttfdHzVpCy/su/D73OLkpf6B2ABXxJqTrwHbieZHeiUSPo
	2YvAhH+zf8Y3Hk3sAadY84LCZ69KyY4HZ2DvoPdHJYx+DHTp4MJTPOjdGxqx6w==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	claudiu.beznea@tuxon.dev,
	nicolas.ferre@microchip.com,
	linux-kernel@vger.kernel.org,
	theo.lebrun@bootlin.com,
	phil@raspberrypi.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v5 1/5] net: cadence: macb: add EEE LPI statistics counters
Date: Fri, 27 Feb 2026 16:06:06 +0100
Message-ID: <20260227150610.242215-2-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260227150610.242215-1-nb@tipi-net.de>
References: <20260227150610.242215-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261875-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:mid,tipi-net.de:dkim,tipi-net.de:email,bootlin.com:email]
X-Rspamd-Queue-Id: 492361B97C4
X-Rspamd-Action: no action

The GEM MAC provides four read-only, clear-on-read LPI statistics
registers at offsets 0x270-0x27c:

  GEM_RXLPI     (0x270): RX LPI transition count (16-bit)
  GEM_RXLPITIME (0x274): cumulative RX LPI time (24-bit)
  GEM_TXLPI     (0x278): TX LPI transition count (16-bit)
  GEM_TXLPITIME (0x27c): cumulative TX LPI time (24-bit)

Add register offset definitions, extend struct gem_stats with
corresponding u64 software accumulators, and register the four
counters in gem_statistics[] so they appear in ethtool -S output.
Because the hardware counters clear on read, the existing
macb_update_stats() path accumulates them into the u64 fields on
every stats poll, preventing loss between userspace reads.

These registers are present on SAMA5D2, SAME70, PIC32CZ, and RP1
variants of the Cadence GEM IP and have been confirmed on RP1 via
devmem reads.

Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 87414a2ddf6e..19aa98d01c8c 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -170,6 +170,10 @@
 #define GEM_PCSANNPTX		0x021c /* PCS AN Next Page TX */
 #define GEM_PCSANNPLP		0x0220 /* PCS AN Next Page LP */
 #define GEM_PCSANEXTSTS		0x023c /* PCS AN Extended Status */
+#define GEM_RXLPI		0x0270 /* RX LPI Transitions */
+#define GEM_RXLPITIME		0x0274 /* RX LPI Time */
+#define GEM_TXLPI		0x0278 /* TX LPI Transitions */
+#define GEM_TXLPITIME		0x027c /* TX LPI Time */
 #define GEM_DCFG1		0x0280 /* Design Config 1 */
 #define GEM_DCFG2		0x0284 /* Design Config 2 */
 #define GEM_DCFG3		0x0288 /* Design Config 3 */
@@ -1043,6 +1047,10 @@ struct gem_stats {
 	u64	rx_ip_header_checksum_errors;
 	u64	rx_tcp_checksum_errors;
 	u64	rx_udp_checksum_errors;
+	u64	rx_lpi_transitions;
+	u64	rx_lpi_time;
+	u64	tx_lpi_transitions;
+	u64	tx_lpi_time;
 };
 
 /* Describes the name and offset of an individual statistic register, as
@@ -1142,6 +1150,10 @@ static const struct gem_statistic gem_statistics[] = {
 			    GEM_BIT(NDS_RXERR)),
 	GEM_STAT_TITLE_BITS(RXUDPCCNT, "rx_udp_checksum_errors",
 			    GEM_BIT(NDS_RXERR)),
+	GEM_STAT_TITLE(RXLPI, "rx_lpi_transitions"),
+	GEM_STAT_TITLE(RXLPITIME, "rx_lpi_time"),
+	GEM_STAT_TITLE(TXLPI, "tx_lpi_transitions"),
+	GEM_STAT_TITLE(TXLPITIME, "tx_lpi_time"),
 };
 
 #define GEM_STATS_LEN ARRAY_SIZE(gem_statistics)
-- 
2.51.0


