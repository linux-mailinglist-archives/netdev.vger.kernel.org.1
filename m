Return-Path: <netdev+bounces-229804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49115BE0EF8
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 00:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521811891692
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9973081D1;
	Wed, 15 Oct 2025 22:32:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEFE307491;
	Wed, 15 Oct 2025 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567530; cv=none; b=GRafKLyV6Q2ANvuqs3dysPWr8qpJbaNcpkAgR0ncbSerr/qGgFIR/PHbJrTbS0qLwYG1EATNNyhY/0WCTDGt7Vo+7hpbn8NYvwmvi4YrxtRRaRXHv0ma7zateu4KXkMWWjSvtr/3pZ76ylVR+//YidElsP55+/1KZkHsIantXw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567530; c=relaxed/simple;
	bh=Fk/NUdr0xb3/gpiLV3dXIsZqBbYeopnPG3AceI+haqo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sgzN2k4WRbgON8cAtSgB6lFlV1xhMxgkUXB4n3NScMhrdjAEfUXBOAU8xo8RvCRT9B4TnbruXJRdRUyv2JJ9gvNZCvi2aGdrqyyZGbh4GYa2F+tdk9/UZvxbE8e5tjbv4ozlS5sE/lFw/kNw2yIL3e7lNoa2puDSnVmYUudd17w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1v9A2I-000000006Tv-2P8a;
	Wed, 15 Oct 2025 22:31:58 +0000
Date: Wed, 15 Oct 2025 23:31:51 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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
Subject: [PATCH net-next 00/11] net: dsa: lantiq_gswip: clean up and improve
 VLAN handling
Message-ID: <cover.1760566491.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

This series was developed by Vladimir Oltean to improve and clean up the
VLAN handling logic in the Lantiq GSWIP DSA driver.

As Vladimir currently doesn't have the availability to take care of the
submission process, we agreed that I would send the patches on his
behalf.

The series focuses on consolidating the VLAN management paths for both
VLAN-unaware and VLAN-aware bridges, simplifying internal logic, and
removing legacy or redundant code. It also fixes a number of subtle
inconsistencies regarding VLAN ID 0 handling, bridge FDB entries, and
brings the driver into shape to permit dynamic changes to the VLAN
filtering state.

Notable changes include:

 - Support for bridge FDB entries on the CPU port

 - Consolidation of gswip_vlan_add_unaware() and gswip_vlan_add_aware()
   into a unified implementation

 - Removal of legacy VLAN configuration options and redundant
   assignments

 - Improved handling of VLAN ID 0 and PVID behavior

 - Better validation and error reporting in VLAN removal paths

 - Support for dynamic VLAN filtering configuration changes

Overall, this refactor improves readability and maintainability of the
Lantiq GSWIP DSA driver. It also results in all local-termination.sh
tests now passing, and slightly improves the results of
bridge-vlan-{un,}aware.sh.

All patches have been authored by Vladimir Oltean; a small unintended
functional change in patch "net: dsa: lantiq_gswip: merge
gswip_vlan_add_unaware() and gswip_vlan_add_aware()" has been ironed out
and some of the commit descriptions were improved by me, apart from that
I'm only handling the submission and will help with follow-up
discussions or review feedback as needed.

Despite the fact that some changes here do actually fix things (in the
sense that selftests which would previously FAIL now PASS) we decided
that it would be the best for this series of patches to go via net-next.
If requested some of it can still be ported to stable kernels later on.

Vladimir Oltean (11):
  net: dsa: lantiq_gswip: support bridge FDB entries on the CPU port
  net: dsa: lantiq_gswip: define VLAN ID 0 constant
  net: dsa: lantiq_gswip: remove duplicate assignment to
    vlan_mapping.val[0]
  net: dsa: lantiq_gswip: merge gswip_vlan_add_unaware() and
    gswip_vlan_add_aware()
  net: dsa: lantiq_gswip: remove legacy
    configure_vlan_while_not_filtering option
  net: dsa: lantiq_gswip: permit dynamic changes to VLAN filtering state
  net: dsa: lantiq_gswip: disallow changes to privately set up VID 0
  net: dsa: lantiq_gswip: remove vlan_aware and pvid arguments from
    gswip_vlan_remove()
  net: dsa: lantiq_gswip: put a more descriptive error print in
    gswip_vlan_remove()
  net: dsa: lantiq_gswip: drop untagged on VLAN-aware bridge ports with
    no PVID
  net: dsa: lantiq_gswip: treat VID 0 like the PVID

 drivers/net/dsa/lantiq/lantiq_gswip.c | 224 ++++++++++++--------------
 drivers/net/dsa/lantiq/lantiq_gswip.h |   7 +-
 2 files changed, 107 insertions(+), 124 deletions(-)

-- 
2.51.0

