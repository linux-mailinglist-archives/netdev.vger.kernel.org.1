Return-Path: <netdev+bounces-297075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DMYzI9okKGoN/AIAu9opvQ
	(envelope-from <netdev+bounces-297075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:36:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C85C86612F8
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:36:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297075-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297075-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F1E63008D00
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 14:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB8533EAEC;
	Tue,  9 Jun 2026 14:22:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2758417C203;
	Tue,  9 Jun 2026 14:22:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014978; cv=none; b=QKrUoXwCvAO1ro4DWm4OWBNZDPXfsIsB2KRuCQn+QBOLY6AoDiCvhA2GQq5knoZ20SIP8HxBhVgKf+3hunf0LI9L4nxNRRuT86+L1igK79UuatNqQd3McBFFHrYVY7d+piVMMHQVhxx7w0DQqmmBCOM9b8iE7+Bxa0tyHrAqkAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014978; c=relaxed/simple;
	bh=ZdtjYX4wfRWZXxGEZqRCuuekydDW0lAcjZbHDbFsSjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fDTfip8xUawGvAgUn8vGG1KojWP7JD/Pp2W0z2ClGrqHqrlQHojvNBm/RKRA7RXPqYY0VFFhcvzjmG5Izw08TJbauzR4Vq5KzYXrH4a56Ra0m+jdty5cKH8z+nSoxs30SYVkrjfjkXXkg8fT3E4x60h/Qtld9DqfurpZaB+r2q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3721F00893;
	Tue,  9 Jun 2026 14:22:53 +0000 (UTC)
From: Greg Ungerer <gerg@linux-m68k.org>
To: linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org,
	arnd@kernel.org,
	wei.fang@nxp.com,
	frank.li@nxp.com,
	shenwei.wang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	nico@fluxnic.net,
	adureghello@baylibre.com,
	ulfh@kernel.org,
	linux-mmc@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-spi@vger.kernel.org,
	olteanv@gmail.com,
	Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCHv2 0/4] m68k: coldfire: fix non-standard readX()/writeX() functions
Date: Wed, 10 Jun 2026 00:12:56 +1000
Message-ID: <20260609142139.1563360-1-gerg@linux-m68k.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297075-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_RECIPIENTS(0.00)[m:linux-m68k@lists.linux-m68k.org,m:linux-kernel@vger.kernel.org,m:arnd@kernel.org,m:wei.fang@nxp.com,m:frank.li@nxp.com,m:shenwei.wang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:nico@fluxnic.net,m:adureghello@baylibre.com,m:ulfh@kernel.org,m:linux-mmc@vger.kernel.org,m:linux-can@vger.kernel.org,m:linux-spi@vger.kernel.org,m:olteanv@gmail.com,m:gerg@linux-m68k.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gerg@linux-m68k.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,nxp.com,lists.linux.dev,fluxnic.net,baylibre.com,gmail.com,linux-m68k.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gerg@linux-m68k.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,linux-m68k.org:mid,linux-m68k.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C85C86612F8

This odd collection of patches is aimed at fixing the non-standard ColdFire
set of readX()/writeX() IO access functions. Instead switching to using the
asm-generic definitions in include/asm-generic/io.h. The difficulty comes
in trying not to break any drivers with this change.

The implementation of the readX()/writeX() family of IO access functions
is non-standard on ColdFire platforms. They either return big-endian (that
is native endian) data, or on platforms with PCI bus support check the
supplied address and return either big or little endian data based on that
check. This is non-standard, they are expected to always return
little-endian byte ordered data. Unfortunately this behavior also means
that ioreadX()/iowroteX() and their big-endian counter parts
ioreadXbe()/iowriteXbe() are currently broken because they are implemented
using the readX()/writeX() functions.

Patches 1, 2 and 3 in this series are specific driver changes that can be
made independently of the final ColdFire readX()/writeX() change.

Patch 4 is the actual switch to ColdFire building using asm-generic
readX()/writeX(), but also contains three driver fixes that are not easily
handled independently.

Note that I don't have access to all supported hardware needed to fully
test all these changes. I have tested what I have, a bunch of the standard
Freescale ColdFire eval boards, and inspected generated code for differences.

Note also that patch 3 relies on changes that are currently only in
linux-next, and are scheduled to hit mainline during the next v7.2
merge window. Those changes are also available in an immutable git tree
at git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git
cf-internal-io branch.

This v2 series moves from an RFC to a patch series. There is only minor
changes overall to address comments. Changes include formatting, separating
out the mcf5441x regmap in spi-fsl-dspi.c (patch 4) and reordering the
quirks in flexcan-core.c (patch 4).

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 arch/m68k/include/asm/io_no.h             |   68 -------
 drivers/dma/mcf-edma-main.c               |   14 -
 drivers/mmc/host/sdhci-esdhc-mcf.c        |   24 +-
 drivers/net/can/flexcan/flexcan-core.c    |    1 
 drivers/net/ethernet/freescale/fec.h      |   15 +
 drivers/net/ethernet/freescale/fec_main.c |  257 +++++++++++++++---------------
 drivers/net/ethernet/freescale/fec_ptp.c  |   78 ++++-----
 drivers/net/ethernet/smsc/smc91x.h        |   12 -
 drivers/spi/spi-fsl-dspi.c                |   14 +
 9 files changed, 230 insertions(+), 253 deletions(-)


