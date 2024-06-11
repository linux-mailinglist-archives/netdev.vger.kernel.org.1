Return-Path: <netdev+bounces-102595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71F3903E06
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781102822EF
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8E917D8A9;
	Tue, 11 Jun 2024 13:55:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB2217D88C;
	Tue, 11 Jun 2024 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718114105; cv=none; b=rJhEo42n3SBEDF0vLty1C/9E5w4oRWZgX8/JZJpHhJhra9KYafoR4oJYSUTerB83U1ne/CP4eYpd4Uqr+DaNNq79/5NLSooVD7rPjenqDepR4I3fLPh/3f5C22hfkdXcoDVfs6lvWS2sz3gLIWRsmS24m7xx6PUuK3EykKuP6aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718114105; c=relaxed/simple;
	bh=Av0dpoUzWyynrRVpAMK6vpVeWyX93XmNPwzW6KRvJXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WFJ8eltY4VDK1JUDmDu9v2YMzJl7qB4TSbOONJ3Pud07ir19oZrfBXK8DqAzzxUV2tUvVQJ7Ump3PCyI0ALiRTDhrMoFBbCL1zJXtNmCZ47WZ0730pFm0pO1H64jwiC45jz2+IXKcTANHbkfqs7AJsCrPIrr0jDHJjxPKe+8moY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9906f4c1d5=ms@dev.tdt.de>)
	id 1sH1xl-00ABDO-F4; Tue, 11 Jun 2024 15:55:01 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sH1xk-003Z33-SR; Tue, 11 Jun 2024 15:55:00 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 5E244240053;
	Tue, 11 Jun 2024 15:55:00 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id DA0B8240050;
	Tue, 11 Jun 2024 15:54:59 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 81C76376FA;
	Tue, 11 Jun 2024 15:54:59 +0200 (CEST)
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
Subject: [PATCH net-next v5 00/12] net: dsa: lantiq_gswip: code improvements
Date: Tue, 11 Jun 2024 15:54:22 +0200
Message-ID: <20240611135434.3180973-1-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1718114101-824B2642-E1F57A56/0/0
X-purgate: clean
X-purgate-type: clean

This patchset for the lantiq_gswip driver is a collection of minor fixes
and coding improvements by Martin Blumenstingl without any real changes
in the actual functionality.

=3D=3D=3D Changelog =3D=3D=3D
From v4:
- merge dt-bindings patches to satisfy 'make dt_bindings_check' and add
  some improvements suggested by Rob Herring

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

Martin Blumenstingl (8):
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

 .../bindings/net/dsa/lantiq,gswip.yaml        | 202 ++++++++++++++++++
 .../bindings/net/dsa/lantiq-gswip.txt         | 146 -------------
 MAINTAINERS                                   |   1 +
 drivers/net/dsa/lantiq_gswip.c                | 123 +++++------
 4 files changed, 258 insertions(+), 214 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/lantiq,gswi=
p.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/dsa/lantiq-gswi=
p.txt

--=20
2.39.2


