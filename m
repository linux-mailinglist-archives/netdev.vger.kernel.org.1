Return-Path: <netdev+bounces-266253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP6gIXhSsGmBiAIAu9opvQ
	(envelope-from <netdev+bounces-266253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:18:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CFF255632
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0E80303CA6C
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8205A3C9EF2;
	Tue, 10 Mar 2026 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uM77GE58"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1493AC0E3;
	Tue, 10 Mar 2026 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163125; cv=none; b=aJjOVCi7jQvPaU+FlFGrdhmbAmR1CVbaR1qh/BD1co+zmDMZfSBoXCfLsUigpNAz1L8Uaj3CYij6TBfIaCzybQ1CMnbUcF3895lu8dQIMuHlJRzH4+0MMPAzQQDuyr/2lxqkK5Ztb0D8dHDz1ACzGf6aBIME/d1xiWFhYNZlUyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163125; c=relaxed/simple;
	bh=ssOac3bxyWtS0tltR+pILLaG3NN0ZgI0HUcEtKF5uRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MGcI/7OTc8CUFxWdEhhjmOEgURb3+iX9b4JbHd8tzPMXLGO7PfgmbsL+82OSc+RK+57oDS+uNb6WAd9D+6Woe+fO6xWaXHgb69BdV+wibR2F0YL2br6vUdifaDtFz6NdK7/UpShZ18K9DQjP5AHmMH5P6NSUF6ZKuPahuMahJSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uM77GE58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFADAC19423;
	Tue, 10 Mar 2026 17:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773163125;
	bh=ssOac3bxyWtS0tltR+pILLaG3NN0ZgI0HUcEtKF5uRg=;
	h=From:To:Cc:Subject:Date:From;
	b=uM77GE58J6M5lK2RRmBrfQA1Djxa+7Vra9kK54/+wt1K9oRFu9Qbei6KgDivjziIX
	 qotoROcjjoFYuc2MWvX7alS6iRdeYbIahjM3gx+Qgj30jvdPnnMv0rrFJMu2k3dawD
	 N6/9fOfnQtXvv06UNpEF+1zLSZ0zQRL5EH/AhHHG6pc4N05n0/khsrCkGEvAWrGoF/
	 PV+41GjX7zhFj0dkQ4YPST4FiSSuXG4aWkW5zl9eWwBA/IaxGngHHaGEveO2YE36xK
	 tJLdavbbIaup6QiJpLumkwDWJr81tZ5QybfOe7ac4QvFQ8NMLtDbFMTDIblVciBQJK
	 dEoKQfutb0Mnw==
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
Subject: [PATCH net-next v3 00/10] macb usrio/tsu patches
Date: Tue, 10 Mar 2026 17:17:07 +0000
Message-ID: <20260310-moneyless-dispense-7bce14b16388@spud>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4269; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=QrQ6yekBVGBayH1oG22woO0zUs3eFYGTHF3VO06A6ns=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJkbgpRmG69Rc+n+PSe0OqY+ddVpZ7UMPpcv23TTPjdW6 BrqTNTtKGVhEONikBVTZEm83dcitf6Pyw7nnrcwc1iZQIYwcHEKwES4Uhn+p6cyedeaFs34wviF 12L74WupLGUeXlP/P8nZf0IzgPFYA8N/D8tyxoU9LXd9VDYYbfapWX9K79oGGQV9+er1nLGO7Pf 4AA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E5CFF255632
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266253-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,davemloft.net,google.com,redhat.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,tuxon.dev,gmail.com,sifive.com,vger.kernel.org,lists.infradead.org,raspberrypi.com,linux.dev,amd.com,bootlin.com];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Conor Dooley <conor.dooley@microchip.com>

Hey folks,

At the very least, it'd be good of the soc vendor folks could check
their platforms and see if their usrio stuff actually lines up with what
the driver currently calls "macb_default_usrio". Ours didn't and it was
a nasty surprise.

Theo, you added eyeq5 recently. Does it genuinely have the same usrio
bits as the at91 devices?

Ryan and I figured out that the sama7g5 stuff is not actually using the
same usrio bits as earlier devices, so there's now more patches in this
series to split them apart. I've not tested the split or the new
property due to lack of hardware, but Ryan has.

Cheers,
Conor.

v3:
- reorder patches
- fix smatch issue reported by Simon
- add patches reworking usrio handling of clken/refclk (and remove the
  issue the llm reported in the process)
- add a new devicetree property for refclk selection, replacing the
  existing one.
- drop the dts patch

CC: Valentina.FernandezAlanis@microchip.com
CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: David S. Miller <davem@davemloft.net>
CC: Eric Dumazet <edumazet@google.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Paul Walmsley <pjw@kernel.org>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Albert Ou <aou@eecs.berkeley.edu>
CC: Alexandre Ghiti <alex@ghiti.fr>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>
CC: Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: Richard Cochran <richardcochran@gmail.com>
CC: Samuel Holland <samuel.holland@sifive.com>
CC: netdev@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-riscv@lists.infradead.org
CC: Dave Stevenson <dave.stevenson@raspberrypi.com>
CC: Sean Anderson <sean.anderson@linux.dev>
CC: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
CC: Abin Joseph <abin.joseph@amd.com>
CC: Théo Lebrun <theo.lebrun@bootlin.com>
CC: Ryan.Wanner@microchip.com

Conor Dooley (10):
  net: macb: rename macb_default_usrio to at91_default_usrio as not all
    platforms have mii mode control in usrio
  net: macb: split USRIO_HAS_CLKEN capability in two
  dt-bindings: net: cdns,macb: replace cdns,refclk-ext with
    cdns,refclk-source
  net: macb: rework usrio refclk selection code
  net: macb: np4 doesn't need a usrio pointer
  net: macb: add mpfs specific usrio configuration
  net: macb: warn on pclk use as a tsu_clk fallback
  net: macb: clean up tsu clk rate acquisition
  dt-bindings: net: macb: add property indicating timer adjust mode
  net: macb: timer adjust mode is not supported

 .../devicetree/bindings/net/cdns,macb.yaml    |  54 ++++-
 drivers/net/ethernet/cadence/macb.h           |   6 +
 drivers/net/ethernet/cadence/macb_main.c      | 197 ++++++++++++------
 3 files changed, 186 insertions(+), 71 deletions(-)

-- 
2.51.0


