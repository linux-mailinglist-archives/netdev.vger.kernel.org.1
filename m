Return-Path: <netdev+bounces-271649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HdbOn0QxGl8vwQAu9opvQ
	(envelope-from <netdev+bounces-271649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:42:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E76AB32939E
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8CA430B48FC
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E493FE346;
	Wed, 25 Mar 2026 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MS6uB1MX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A553F9F59;
	Wed, 25 Mar 2026 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456177; cv=none; b=oc55xkZpzz8WlKAa9XE9Dew8u6mrZdDMOTF/pX1HDh/OiX2m9uiUN/rU0Y9uyitPDw+GnSyhDV+vSXf/dWn6Z9eIyGEJc6aKDQDVFdhzY4Ctbccef5MlhxyrE52Nd8VqUGVpBwr1ux/0r7r6zfnQfCo8NteSvbgdaxHpYKiaGyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456177; c=relaxed/simple;
	bh=sDKThMtcyv96eXzde374X1AAM94GvTAWHU4orvZhEwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBt5aXiysX3n3JEBkTqN0gcwcqIy12d6KNtQHzLTdiO1mQ6YbpxTarUcpsk8eLlak0x+Nrvjp//gCZ1Kbh+8WJ8GoL9G2UVEmZ13bSl9s34MKw+UsyP64ebLHwwXkaNTKZfBe7bQH/18DFwWJMttsu0wN0+yV80Q9aWYEaI/Gag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MS6uB1MX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98A2C4CEF7;
	Wed, 25 Mar 2026 16:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774456177;
	bh=sDKThMtcyv96eXzde374X1AAM94GvTAWHU4orvZhEwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MS6uB1MX2q9Paw6Kikz5NNoqJupOFaj5jDJWZhAgnnC81BSka69lhSE4A1UbpFONM
	 BGGgoYiWk7oUX7Xj2M5MvPh+2RWetfUBE2uhxvIRIQStdj+XePpoiThICHLB3TYp4M
	 WZ2ifKnyqqQiZ7Xwt616WmuqRBwOrTe/Ia0LRZsC6QClIMGGr5OnqS69SwgOblf52/
	 JDDRKL6ioCWBkY/PPkZvsx2oQDvLgG8kFOyy+bgylY4g8FKg2XyUjTvLRJpdqj/eiA
	 848IuWYQCxe+Yp0GzFnViHeUHuS77Tssx+OTY0yQAXaIrZMyZE+uzoAzbiLTLZGVJF
	 ukiwetmSFy+SQ==
From: Conor Dooley <conor@kernel.org>
To: netdev@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Abin Joseph <abin.joseph@amd.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Ryan.Wanner@microchip.com,
	Kevin Hao <haokexin@gmail.com>
Subject: [PATCH net-next v5 08/14] net: macb: warn on pclk use as a tsu_clk fallback
Date: Wed, 25 Mar 2026 16:28:12 +0000
Message-ID: <20260325-dust-revision-368053e82d0e@spud>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325-unsterile-flail-4c7729750dc4@spud>
References: <20260325-unsterile-flail-4c7729750dc4@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3276; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=4hRMpr9HKqtdLE/ntrih5qOpiY9u0EHTozFQCcK6pdI=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJlHeM2aCr9v1wvVbpZf+I7/849DjGvFm1KeHi6tbHtfZ jT12vo/HaUsDGJcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZhI2R6G/15cZoGH1m1pf9TW uOqN1rxbv+MqdjxPqmFaVNCgMe9f9U5GhjNum4O894qYGuzLO7z21/QjwXaif0MYtoipB1mfzIy 4yAAA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-271649-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,davemloft.net,google.com,redhat.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,tuxon.dev,gmail.com,sifive.com,vger.kernel.org,lists.infradead.org,raspberrypi.com,linux.dev,amd.com,bootlin.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E76AB32939E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Conor Dooley <conor.dooley@microchip.com>

The Candence GEM IP has a configuration parameter which determines the
source of the clock used for the timestamp unit (if it is enabled),
switching it between using the pclk and a dedicated input.

When ptp support was added to the macb driver, a new tsu_clk was added
to represent the dedicated input. While this is understandable, I think
it is bug prone and that the tsu_clk should represent whatever clock is
used for the timestamper and not just that specific input.

>From a driver point of view, the benefit of taking the conceptual
approach is avoiding misconfiguring the driver when the hardware
supports ptp (and it is set as a capability in the relevant per-device
structure) but no tsu_clk is provided in devicetree. At the moment, the
timestamper will be registered and programmed with an increment that
reflects the pclk in these cases, but will malfunction if the pclk and
tsu_clk frequencies do not match. Obviously, this means the devicetree
incorrectly represents the hardware, but this change in approach would
make the driver more resilient without meaningfully impacting correctly
described users.

Out of the devices that claim MACB_CAPS_GEM_HAS_PTP the fu540, mpfs,
sama5d2 and sama7g5-emac (but not sama7g5-gem) are at risk of having
this problem with the in-kernel devicetrees. mpfs and sama7g5-emac
have been confirmed to be incorrect, and sama5d2 is correct. It may be
that the other platforms actually do use the pclk for the timestamper
(either by supplying pclk to the tsu_clk input of the IP, or by having
the IP block configured to use pclk instead of the tsu_clk input), but
at least two are wrong, as they do not use pclk for the tsu_clk, so the
driver is registering the ptp clock incorrectly.

Add a warning if no tsu_clk is provided on a platform that uses the
timerstamper, to encourage people to specifically provide a tsu_clk and
avoid silently registering the timerstamper with the wrong clock. If the
pclk is actually used, it can be provided as a tsu_clk for improved
clarity in devicetrees.

While this changes the meaning of the devicetree property, it is
backwards compatible as there's no functional change for platforms that
didn't provide a tsu_clk and the changed meaning of providing a tsu_clk
in the devicetree does not impact platforms that already provided one as
the decision about the tsu clock source is at IP instantiation time
rather than at runtime, so there's no driver behaviour that needs to
change based on the input to the IP used for the timestamping unit.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 4e5967e6ffbe5..492abe1e33b3a 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3772,6 +3772,7 @@ static unsigned int gem_get_tsu_rate(struct macb *bp)
 	else if (!IS_ERR(bp->pclk)) {
 		tsu_clk = bp->pclk;
 		tsu_rate = clk_get_rate(tsu_clk);
+		dev_warn(&bp->pdev->dev, "devicetree missing tsu_clk, using pclk as fallback\n");
 	} else
 		return -ENOTSUPP;
 	return tsu_rate;
-- 
2.53.0


