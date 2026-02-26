Return-Path: <netdev+bounces-261294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PwYGfEooGlIfwQAu9opvQ
	(envelope-from <netdev+bounces-261294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:05:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE711A4CA1
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 41BAD3041B5F
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5477335575;
	Thu, 26 Feb 2026 11:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puaJ6vN5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA0F2E2679;
	Thu, 26 Feb 2026 11:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772103860; cv=none; b=P+XmxxWF+iXjGU4WoAtSd1MtLkYIBpKC+jzhlUqBzP67GVin3XJBZ0QphaiPLfGDagUWhxkYfHiBKV0EFtffHYgBG8wWRIYC8ZKHpp+WJt7qch0GhnR7Xk412Vh1LTatduLcpV6PMo2FkZ0GjQrZ2SR+mkMF/bHVE8tXVHDR4kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772103860; c=relaxed/simple;
	bh=AZyqWxB8IUDeUfwf7KTkklB/ywiMAc2oAo1jnQG57wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQat3yw64NakCUu8HSsJfEk22b7TFrfVmQE2zYuMOexXpNUIp3rdzfVYZdXTZ1gNQTOcWQWUEhU6hPInyH1rtBA68D36QNQ8PPqnUS5w3Xa9duWoZSd/3QXT9HCeLye8Tjasy8yJ7WDvuNKehlHwzi6lzh19I6vLcB2Srrxlqlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puaJ6vN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2965EC2BC87;
	Thu, 26 Feb 2026 11:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772103860;
	bh=AZyqWxB8IUDeUfwf7KTkklB/ywiMAc2oAo1jnQG57wQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=puaJ6vN5bb0wkvN2tH14Dl/RZZbEeYLSDSck7yfnYwUIZDwI5HN6UvYp44EUnl5BJ
	 gwysPDUb45yKtO0TUtXQyxVJ7xdls3yQwkkInLWrBx4tikklo8BgYkLPxxNjg1yfIa
	 BslI9zaX4K4V05Z4Xt40jbthmhZsas89XSnyqkUFrqsmgDjfA85bS4D/BlSvD82BxZ
	 mmBisrDM2MtWsJCmBvGKjMEMwaFnUyO7GG/EpFTjSIbY0a0q0vx2djiYdO7Vmsh36Z
	 sEyFOiEbeigLCsv4UYiyMorw7lZ4mnNEdiooLVjIQiTP+Gs+ouvzv2gURmpI5s3y0M
	 1KTfTqT0B62ag==
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
	Neil Armstrong <narmstrong@baylibre.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Abin Joseph <abin.joseph@amd.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next v2 7/8] net: macb: warn on pclk use as a tsu_clk fallback
Date: Thu, 26 Feb 2026 11:03:22 +0000
Message-ID: <20260226-crouton-gratitude-4bdbe2aa98dc@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260226-snowshoe-amusable-6716d4ddea11@spud>
References: <20260226-snowshoe-amusable-6716d4ddea11@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2993; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=ItmiQ5vlNC1QS/7ZhO15GpA5CWwDTt/eS2Bem3qx+yc=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJkLNCpi4nWvLmkzCD+0YN2f45pMnEyf9aZ/fnxy6bajJ goZy4xMO0pZGMS4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjARywSGf4rWy2unnLRs/dPw 5bTcz58O1kUfAl5b7Pi2VXhW5/WFC04x/M9mNp/dck1n9+7p5U1vlx0WcDn1RFX96JzV5yS+fjV QvcELAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-261294-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,davemloft.net,google.com,redhat.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,tuxon.dev,gmail.com,sifive.com,vger.kernel.org,lists.infradead.org,baylibre.com,raspberrypi.com,linux.dev,amd.com,bootlin.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.981];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CE711A4CA1
X-Rspamd-Action: no action

From: Conor Dooley <conor.dooley@microchip.com>

The Candence GEM IP has a configuration parameter which determines the
source of the clock used for the timestamp unit (if it is enabled),
switching it between using the pclk and a dedicated input.

When ptp support was added to the macb driver, a new tsu_clk was added
to represent the dedicated input. While this is understanble, I think
it is bug prone and that the tsu_clk should represent whatever clock is
used for the timerstamper and not just that specific input.

>From a devicetree point of view, it doesn't really matter if the tsu_clk
represents a physical clock or a conceptual clock, because the clock
configuration is determined when the IP is instantiated not at runtime.
>From a driver point of view, the benefit of taking the conceptual
approach is avoiding misconfiguring the driver when the hardware
supports ptp (and it is set as a capability in the relevant per-device
structure) but no tsu_clk is provided in devicetree. At the moment, the
timestamper will be registered and programmed with an increment that
reflects the pclk in these cases, but will malfunction if the pclk and
tsu_clk frequencies do not match.

Out of the devices that claim MACB_CAPS_GEM_HAS_PTP the fu540, mpfs,
sama5d2 and sama7g5-emac (but not sama7g5-gem) are at risk of having
this problem with the in-kernel devicetrees. It may be that these
platforms actually do use the pclk for the timestamper (either by
supplying pclk to the tsu_clk input of the IP, or by having the IP
block configured to use pclk instead of the tsu_clk input), but
at least mpfs is wrong though, it does not use pclk for the
tsu_clk, so the driver is registering the ptp clock incorrectly.

Add a warning if no tsu_clk is provided on a platform that uses the
timerstamper, to encourage people to specifically provide a tsu_clk and
avoid silently registering the timerstamper with the wrong clock

While this changes the meaning of the devicetree property, it is
backwards compatible as there's no functional change for platforms that
didn't provide a tsu_clk and the changed meaning of providing a tsu_clk
in the devicetree does not impact platforms that already provided one as
the decision about the tsu clock source is at IP instantiation time
rather than at runtime.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ca141f8935d48..5c24ea146d63d 100644
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


