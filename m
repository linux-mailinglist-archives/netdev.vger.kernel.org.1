Return-Path: <netdev+bounces-230649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC16BEC54B
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 04:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4E784E2C17
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 02:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFC51F1518;
	Sat, 18 Oct 2025 02:31:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A120B134CB;
	Sat, 18 Oct 2025 02:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760754660; cv=none; b=NJUYGwLabcW7kgtvEwpyT09pmiUYn466xFj3J+Z3AwZwa80ql2XlgTKA9fhl7ykktVGYHkS+E6HxTOhvHmDzcEscZ7fxRVEbey4x7LVbZxh1t+ISOfXEmtaSa+NHULar7S2rh4yeZyFhxHuXmA9i6a357LhW9ByqvbhnFNaS6Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760754660; c=relaxed/simple;
	bh=NUuJDkq9VTgm83WPiJrnoxF74r2wklcTX3i9wtRw4rc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Eajz0DhO5XBQks9TFCBFxx2r48cYjUxaic3rucsjYWXtgiVix7uOV+iQVNjFI7nqql+YEW/98LegTB8/FYFqStuEpEnbvwsQc/Gy2fDubx3wT3DSLbjYx9PDwhuIRciKrnvopw/tuPuK/usFeEy1Sq93L3QJO+3cp++lTWEBIw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1v9wiJ-000000002D1-2hPE;
	Sat, 18 Oct 2025 02:30:35 +0000
Date: Sat, 18 Oct 2025 03:30:27 +0100
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
Subject: [PATCH net-net v2 0/7] net: dsa: lantiq_gswip: use regmap for
 register access
Message-ID: <cover.1760753833.git.daniel@makrotopia.org>
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

The series was previously posted as RFC[1], changes since the RFC/v1
version are documented in each changed patch.

[1]: https://patchwork.kernel.org/project/netdevbpf/list/?series=998183&state=*

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
 drivers/net/dsa/lantiq/lantiq_gswip.c | 458 +++++++++++++-------------
 drivers/net/dsa/lantiq/lantiq_gswip.h |   6 +-
 3 files changed, 239 insertions(+), 226 deletions(-)

-- 
2.51.1.dirty

