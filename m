Return-Path: <netdev+bounces-231170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C62B8BF5F94
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D77A18C3A2A
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 11:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7891F37D4;
	Tue, 21 Oct 2025 11:16:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEDC244660;
	Tue, 21 Oct 2025 11:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761045399; cv=none; b=oVYps80mFeEWIRSF/hRCbPhx9RZaa0kSI2veRqo3cvAYAiXfk8/ZYCw7zeYYf2RQIEbviUZMyiNYdlne9i3g8X6b9J9GToowTjO0PHypGnN6wrPMCBFF1jNMtLXb4psZwalHIStYTCd20PM6cwmUFsZUoyQNbR8JpeF8GN0cdoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761045399; c=relaxed/simple;
	bh=f/y09RX8ktNxWDd867pIvScPZ1CCnj05ryDgms9+Zio=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Iy0Z4YRTryBWvjaeyLHRlkpw++2CC2yuKgMNDpAkUdOZHRHWKK102MiZxlkpxkrrpP458vghaP/ZGsw04Kiehk/5ebdvtQvAOH0rmwHbcJFTMUv89O1zXOewrtgip5EySajSijxNzHcaaS8CkUfvZQW/Zd07ZJ7qnqVMxS4yeow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vBALq-0000000017R-06Kc;
	Tue, 21 Oct 2025 11:16:26 +0000
Date: Tue, 21 Oct 2025 12:16:19 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v5 0/7] net: dsa: lantiq_gswip: use regmap for
 register access
Message-ID: <cover.1761045000.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This series refactors the lantiq_gswip driver to utilize the regmap API
for register access, replacing the previous approach of open-coding
register operations.

Using regmap paves the way for supporting different busses to access the
switch registers, for example it makes it easier to use an MDIO-based
method required to access the registers of the MaxLinear GSW1xx series
of dedicated switch ICs.

Apart from that, the use of regmap improves readability and
maintainability of the driver by standardizing register access.

When ever possible changes were made using Coccinelle semantic patches,
sometimes adjusting white space and adding line breaks when needed.
The remaining changes which were not done using semantic patches are
small and should be easy to review and verify.

The whole series has been
Tested-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changes since v4:
 * use REGMAP_UPSHIFT(2) macro instead of -2 value for reg_shift

Changes since v3:
 * unlock mutex in error path
 * simplify some of the manually converted register reads by changing
   the type to u32 instead of using a u32 tmp variable and then assigning
   the value to the previously used u16 variable.

Changes since v2:
 * correctly target net-next tree (fix typo in subject)

Changes since RFC:
 * drop error handling, it wasn't there before and it would anyway be
   removed again by a follow-up change
 * optimize more of the regmap_write_bits() calls


Daniel Golle (7):
  net: dsa: lantiq_gswip: clarify GSWIP 2.2 VLAN mode in comment
  net: dsa: lantiq_gswip: convert accessors to use regmap
  net: dsa: lantiq_gswip: convert trivial accessor uses to regmap
  net: dsa: lantiq_gswip: manually convert remaining uses of read
    accessors
  net: dsa: lantiq_gswip: replace *_mask() functions with regmap API
  net: dsa: lantiq_gswip: optimize regmap_write_bits() statements
  net: dsa: lantiq_gswip: harmonize gswip_mii_mask_*() parameters

 drivers/net/dsa/lantiq/Kconfig        |   1 +
 drivers/net/dsa/lantiq/lantiq_gswip.c | 471 +++++++++++++-------------
 drivers/net/dsa/lantiq/lantiq_gswip.h |   6 +-
 3 files changed, 243 insertions(+), 235 deletions(-)

-- 
2.51.1

