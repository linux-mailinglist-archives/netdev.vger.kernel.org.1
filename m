Return-Path: <netdev+bounces-266260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEkWAsNSsGmBiAIAu9opvQ
	(envelope-from <netdev+bounces-266260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:20:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A482556C0
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88EF7302ECB6
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C4E3D1719;
	Tue, 10 Mar 2026 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNQGP8aw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558733D16E4;
	Tue, 10 Mar 2026 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163165; cv=none; b=fkHeum7LcTJCRK/BWgxpXmhtYQipQu+Uws8Gx0qa0WTj67yK2aqubEdbpX7iszZp1qreYcFvd4Z/Z/ntnKuVJPYtIt0RTod7AZpIBujdxl/Ai2WDoVube+zCgab/nTrBBdmJwTwjPGIKJeVh2ZftqPN0+yg/a23is2Cw5SVJREA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163165; c=relaxed/simple;
	bh=XKo6oEcfxrAO5a6uL1jOlJ673A3wAiggYrYhD1OOv/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWt+b4eKQwJVaYaDHnus1XCF+cBoiWgu5sdSSPCgPF4KLpK4YZILjZFITZ7319L7GdcSthHwUgd4JSmAtPAJ6Zhv4gJBMVaaejU9ao845nZePXwm3KpRgxM7XeG+GKkvtx7n5rlzapV7J5ENOQKA5ROuVNt94UuAEEVC6j92pYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNQGP8aw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBCAC19425;
	Tue, 10 Mar 2026 17:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773163165;
	bh=XKo6oEcfxrAO5a6uL1jOlJ673A3wAiggYrYhD1OOv/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sNQGP8awIFmI2BSob6KCi/mtqeHWypqZQig0okBXP8w8ZiDMRwXbUXpJXJpYRh/+5
	 NMhyb4ut+zCHRctYZMaZqnmwsTFJjSSh6VX0Z9JLnXf9ZFJF9Jit7W89qmyBCy6h2F
	 OlT0BcBKhQZnCAlYTHkzW+iLoMGy/EaRZBy+krRUCxSkC6539O1//86z8DX1BC4kSx
	 QNpa6vkoK3XlY5fCiiCGZ4ClUl15Y94LYMExbZIVNoYMcr6IJFSvXaYlXDqKfFTx47
	 Zvq871TL0AxKknXARgdeQAuy1/BnZQoMOpE1V7IAblLB7DV2KIbk7HJ5MC/vi5VOzj
	 OM/fo7QTgYMKw==
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
	Ryan.Wanner@microchip.com
Subject: [PATCH net-next v3 07/10] net: macb: warn on pclk use as a tsu_clk fallback
Date: Tue, 10 Mar 2026 17:17:14 +0000
Message-ID: <20260310-unsubtle-velvet-4bb458cc06ba@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310-moneyless-dispense-7bce14b16388@spud>
References: <20260310-moneyless-dispense-7bce14b16388@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3276; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=NwKelKp1tigxckCA+KrqnMxOmrCbE/r2GTIcp/cWLQA=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJkbgvS2BG/8Wp10pvJn4NknK19+fvX1b+aea4FLi7305 qx3WK34vKOUhUGMi0FWTJEl8XZfi9T6Py47nHvewsxhZQIZwsDFKQATebCNkWH3niuXnzXe67Q3 e1adLzT7lGTwHamyCV8LH8zYNIGRVaiE4X+sy+zda+L7unUWqK+KrZeW3WFg6CbPLPGq5dfhv1I 7PdgA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E5A482556C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-266260-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,microchip.com:email]
X-Rspamd-Action: no action

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
index b476bc9663ecd..6b37598ac57cd 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3534,6 +3534,7 @@ static unsigned int gem_get_tsu_rate(struct macb *bp)
 	else if (!IS_ERR(bp->pclk)) {
 		tsu_clk = bp->pclk;
 		tsu_rate = clk_get_rate(tsu_clk);
+		dev_warn(&bp->pdev->dev, "devicetree missing tsu_clk, using pclk as fallback\n");
 	} else
 		return -ENOTSUPP;
 	return tsu_rate;
-- 
2.51.0


