Return-Path: <netdev+bounces-269120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAOlCKDkummdcwIAu9opvQ
	(envelope-from <netdev+bounces-269120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 18:45:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3B92C0850
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 18:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E2043156700
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B893B47F4;
	Wed, 18 Mar 2026 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcNp68uN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4A73A874F;
	Wed, 18 Mar 2026 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851871; cv=none; b=YRGyTPHk83C0p0Rq4Gv6ZRfEr5zSwCmMul7EbVvSvXTezch1iwV67Io2GJMXF7lU9WS8Ch8oxgJPWMr1tBFQUuitYLJAjPOKzveXH0WkpAUN7KyRshcutQqUXMVZI0CKhvjGx4+Sk6zQpAAHH/iEXKv3PmwnUhjrkDJdS8+OekE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851871; c=relaxed/simple;
	bh=iqmtwLEcnL6mFlvnn9juJ9ChTC04q0eJq3YD9qrNJTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EL3yNQpnCSaINA6Wv5Ods6f6ykNJdyPCF0YFk/kryvz0cr8oKrKfHFMv8H8rUqoo3b5FDfzoajbhINvx7pL+zEn0+3UUcdYx0ZXJHFi12MGmYaZD+vC0BxFTyV8ppUNCeJivscgikcSjBob1aLzFRNbLsgu0MTPkBEV07agvrZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcNp68uN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1C8C19421;
	Wed, 18 Mar 2026 16:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773851870;
	bh=iqmtwLEcnL6mFlvnn9juJ9ChTC04q0eJq3YD9qrNJTI=;
	h=From:To:Cc:Subject:Date:From;
	b=PcNp68uNOBv5fLixIjnHiniTlT7nbV1vida+HWufRivcjOEemg/cdnlQZ3S28LjPi
	 j+Xclfj0fxIG1UpkeaBCnCo6UaO3E3amhxQ0ljAmkY0FRBeo/1eejhlIg0s6ML2FYk
	 j176lFp0kwIqRk5ppGbJPIIIsgG3KdHbfeTYvW/jsKkGjJxT/x3Gg6QtQlRfCRZpNT
	 XdeszBOq+uAYHkdzzUrLODEADMMj+YEJi6+GVLHejPAu4Va5m8rkI51zxutddRnfmG
	 rZMQokXJVXxrUynwFEGUBbog4r2FnXJu/834cMVrfnTJ2zROdK96aZdce098xnwnVX
	 yw3vTEIdZ6XrA==
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
Subject: [PATCH net-next v4 00/13] macb usrio/tsu patches
Date: Wed, 18 Mar 2026 16:37:31 +0000
Message-ID: <20260318-surpass-puzzle-f94b46aa8808@spud>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3354; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=ixRxbL+6ajZ8OQT5v+uLquAllGh8dKxfO7p3wZv97z8=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJm7rpxJPpK842A178372bLM1VvsRZhFMv/9DGrwumC4e Rv7wyChjlIWBjEuBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEzk0nNGhm+NrfcPtEx5qbjw 28GNZs4SZe8mhaqKx37at3bLIl2Oy8sY/kdIOprVt5/ulWOIfSe1o/PBh79mp+KZXq1T5+DZ/+z GdEYA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269120-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,davemloft.net,google.com,redhat.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,tuxon.dev,gmail.com,sifive.com,vger.kernel.org,lists.infradead.org,raspberrypi.com,linux.dev,amd.com,bootlin.com];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E3B92C0850
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Conor Dooley <conor.dooley@microchip.com>

Hey folks,

At the very least, it'd be good of the soc vendor folks could check
their platforms and see if their usrio stuff actually lines up with what
the driver currently calls "macb_default_usrio". Ours didn't and it was
a nasty surprise.

Ryan and I figured out that the sama7g5 stuff is not actually using the
same usrio bits as earlier devices, so there's now more patches in this
series to split them apart. I've not tested the split or the new
property due to lack of hardware, but Ryan has.

Marking this stuff net-next, because although they're fixes I don't see
any particular urgency, and it avoids creating some dependencies between
cleanup items and the fixes.

Cheers,
Conor.

v4:
- deprecate instead of remove existing devicetree property
- pick up Theo's patches

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

Théo Lebrun (3):
  net: macb: runtime detect MACB_CAPS_USRIO_DISABLED
  net: macb: set MACB_CAPS_USRIO_DISABLED if no usrio config is provided
  net: macb: drop usrio pointer on EyeQ5 config

 .../devicetree/bindings/net/cdns,macb.yaml    |  71 +++++-
 drivers/net/ethernet/cadence/macb.h           |   8 +
 drivers/net/ethernet/cadence/macb_main.c      | 202 ++++++++++++------
 3 files changed, 211 insertions(+), 70 deletions(-)

-- 
2.51.0


