Return-Path: <netdev+bounces-102280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6902902369
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD741F25067
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86478527D;
	Mon, 10 Jun 2024 14:02:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAEE78B4C;
	Mon, 10 Jun 2024 14:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028156; cv=none; b=Hmmo91wb9q0br3tLMQvG+CJGdize8CuYqrHityOhe0XoNK79HmlTgmXQfvneTnbuV5+bS7+NybEg+q+gw0gjUZw3Xdq7lV2xt5TyfZO8GeX5cmkSUlKcz3uYx9QEnRwCHnTjPbrlHVnsWyAddVjth+KNZlXu4Rl+r96F9YBEwV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028156; c=relaxed/simple;
	bh=8ogpqPg5B9gzD1GjH3xhnCf8GsTsdcFwCOJjrYZ4NgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U8mhfOmyRZv2seprXnmaEGad1GmkwPruonbQXVcIsOkEHf9+VyZd4+OtmiyCyGCl1hYun/GH20HDHKZNPrwgdKSzePVTfYDbXQlqwr2AxIv9H9wU5IZYa8wP+AwNM2RnpiET2wLEdvwZfH7vR5XqXBm0Oh2aoyWTwEYXrVUiex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9905c7c8d6=ms@dev.tdt.de>)
	id 1sGfbT-00C8Ke-RZ; Mon, 10 Jun 2024 16:02:31 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGfbT-00CRgN-9o; Mon, 10 Jun 2024 16:02:31 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 06CE3240053;
	Mon, 10 Jun 2024 16:02:31 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 85E4F240050;
	Mon, 10 Jun 2024 16:02:30 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id F06A236F2E;
	Mon, 10 Jun 2024 16:02:29 +0200 (CEST)
From: Martin Schiller <ms@dev.tdt.de>
To: martin.blumenstingl@googlemail.com,
	hauke@hauke-m.de,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ms@dev.tdt.de
Subject: [PATCH net-next v3 00/12] net: dsa: lantiq_gswip: code improvements
Date: Mon, 10 Jun 2024 16:02:07 +0200
Message-ID: <20240610140219.2795167-1-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1718028151-92C5D34D-2800A53D/0/0
X-purgate-type: clean
X-purgate: clean

This patchset for the lantiq_gswip driver is a collection of minor fixes
and coding improvements by Martin Blumenstingl without any real changes
in the actual functionality.

=3D=3D=3D Changelog =3D=3D=3D
From v2:
- removed unused variable max_ports in gswip_add_single_port_br()

From v1:
- signal that we only update example code in dt-bindings
- don't use the word 'fix' if not appropriate
- new patch: add terminating '\n' where missing
- renamed MAC_BRIDGE macros to make it obvious which register field is
  used
- new patch: remove dead code from gswip_add_single_port_br()
- updated error message if FID not found in gswip_port_fdb()

Martin Blumenstingl (9):
  dt-bindings: net: dsa: lantiq_gswip: Add missing CPU port phy-mode and
    fixed-link to example
  net: dsa: lantiq_gswip: Only allow phy-mode =3D "internal" on the CPU
    port
  net: dsa: lantiq_gswip: Use dev_err_probe where appropriate
  net: dsa: lantiq_gswip: Don't manually call gswip_port_enable()
  net: dsa: lantiq_gswip: Use dsa_is_cpu_port() in
    gswip_port_change_mtu()
  net: dsa: lantiq_gswip: Change literal 6 to ETH_ALEN
  net: dsa: lantiq_gswip: Consistently use macros for the mac bridge
    table
  net: dsa: lantiq_gswip: Update comments in gswip_port_vlan_filtering()
  net: dsa: lantiq_gswip: Improve error message in gswip_port_fdb()

Martin Schiller (3):
  net: dsa: lantiq_gswip: add terminating \n where missing
  net: dsa: lantiq_gswip: do also enable or disable cpu port
  net: dsa: lantiq_gswip: Remove dead code from
    gswip_add_single_port_br()

 .../bindings/net/dsa/lantiq-gswip.txt         |   6 +
 drivers/net/dsa/lantiq_gswip.c                | 123 ++++++++----------
 2 files changed, 61 insertions(+), 68 deletions(-)

--=20
2.39.2


