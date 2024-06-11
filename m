Return-Path: <netdev+bounces-102539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CE8903A94
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF629B229F8
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 11:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7887117B4FA;
	Tue, 11 Jun 2024 11:40:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE59176222;
	Tue, 11 Jun 2024 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106049; cv=none; b=uktYCnz65evCEUlBFVkrxvpS6myvDNZj01JTwA6wmrWaXJRoyj0AgVQpn1sJ2mkjn0ucPDPVoiT7YZWe+Igc1EiXzY3beyuF6W02/FacoGcx7lTPts87lkk99KgSpYgop9kKopt7ZRBzwO1zPfmBOKz40+45RTJCL9sIfqTcBrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106049; c=relaxed/simple;
	bh=F6aNZ82jzGo7qYFC7MrfPogbayEkCaiexBmsAELEUC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OY0RyJ/jKb9HbDZ+b7TU+/2HaR7Wzivx7aOtIHd9nu4dVGa58bboV8jFhVftQ4Rj/RYxU/2oVtNeWgbub40Yjnelznk49tNMooTe2+hlaxhHd3TFik0AeQsMAhCWDA0GU3o4PiE8GG9tCWvQUWdEilMOCgsVk6eaGtMHAd43nkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9906f4c1d5=ms@dev.tdt.de>)
	id 1sGzrp-00EEyR-2L; Tue, 11 Jun 2024 13:40:45 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGzro-0026E0-HT; Tue, 11 Jun 2024 13:40:44 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 3F6CB240053;
	Tue, 11 Jun 2024 13:40:44 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id C2EE7240050;
	Tue, 11 Jun 2024 13:40:43 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 823DA29768;
	Tue, 11 Jun 2024 13:40:43 +0200 (CEST)
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
Subject: [PATCH net-next v4 00/13] net: dsa: lantiq_gswip: code improvements
Date: Tue, 11 Jun 2024 13:40:14 +0200
Message-ID: <20240611114027.3136405-1-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1718106045-2DD88746-4E7E3647/0/0
X-purgate: clean
X-purgate-type: clean


This patchset for the lantiq_gswip driver is a collection of minor fixes
and coding improvements by Martin Blumenstingl without any real changes
in the actual functionality.

=3D=3D=3D Changelog =3D=3D=3D
From v3:
- convert lantiq,gswip bindings to YAML schema
- Add Hauke's acked-by as mentioned in the cover letter in v1

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
  dt-bindings: net: dsa: lantiq,gswip: Add missing CPU port phy-mode and
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

Martin Schiller (4):
  dt-bindings: net: dsa: lantiq,gswip: convert to YAML schema
  net: dsa: lantiq_gswip: add terminating \n where missing
  net: dsa: lantiq_gswip: do also enable or disable cpu port
  net: dsa: lantiq_gswip: Remove dead code from
    gswip_add_single_port_br()

 .../bindings/net/dsa/lantiq,gswip.yaml        | 201 ++++++++++++++++++
 .../bindings/net/dsa/lantiq-gswip.txt         | 146 -------------
 MAINTAINERS                                   |   1 +
 drivers/net/dsa/lantiq_gswip.c                | 123 +++++------
 4 files changed, 257 insertions(+), 214 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/lantiq,gswi=
p.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/dsa/lantiq-gswi=
p.txt

--=20
2.39.2


