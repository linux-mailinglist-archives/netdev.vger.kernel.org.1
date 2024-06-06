Return-Path: <netdev+bounces-101323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A120C8FE1EF
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320F4289042
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 09:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69F813E021;
	Thu,  6 Jun 2024 08:55:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C3313DDCD;
	Thu,  6 Jun 2024 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664138; cv=none; b=gmsE+P09YRTQeHWn04tCbSrQiYxNh7mpFusndILwpbKw4B5sPq3k5ws95iwQ+XhNWSQAGcqo4tjU2DsgoxCiqaDfCjkPjgy1/mHzqzd+lp56t1i29FdFb05SwhyVG0EkvFNf0j04PDFtn/Nf0c+qhpK+FXKjceXF1nc3dRKlp7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664138; c=relaxed/simple;
	bh=rmjW7OWlsamNsWX40yuYQ7RkYTxrX7ZFjAhAythmNKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AM/fS6npGSuW2L9vG04DaUKk0TlrO9gOvYCEEKlZ/UFouFd5Fu14EDyX4mEd4ofCsyGTUxkOKTv6JbIIWtLgdklY/Efewq/ZY12WrArox0pPZHZ5Kgas6qEUcMKcGrqBaPJCozQv8KkikTGIRDGcc+S5Jsby5Ix/81XGOikt4hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9901b58ca3=ms@dev.tdt.de>)
	id 1sF8sF-00CzOj-BI; Thu, 06 Jun 2024 10:53:31 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sF8sE-008wV1-NB; Thu, 06 Jun 2024 10:53:30 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 57B35240053;
	Thu,  6 Jun 2024 10:53:30 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id D868C240050;
	Thu,  6 Jun 2024 10:53:29 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 3B078379F6;
	Thu,  6 Jun 2024 10:53:29 +0200 (CEST)
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
	Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH net-next 00/13] net: dsa: lantiq_gswip: code improvements
Date: Thu,  6 Jun 2024 10:52:21 +0200
Message-ID: <20240606085234.565551-1-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate-ID: 151534::1717664011-23CC843F-CECD1A28/0/0
X-purgate: clean

This patchset for the lantiq_gswip driver is a collection of minor fixes
and coding improvements by Martin Blumenstingl without any real changes
in the actual functionality.

Martin Blumenstingl (12):
  dt-bindings: net: dsa: lantiq_gswip: Add missing phy-mode and
    fixed-link
  net: dsa: lantiq_gswip: Only allow phy-mode =3D "internal" on the CPU
    port
  net: dsa: lantiq_gswip: Use dev_err_probe where appropriate
  net: dsa: lantiq_gswip: Don't manually call gswip_port_enable()
  net: dsa: lantiq_gswip: Use dsa_is_cpu_port() in
    gswip_port_change_mtu()
  net: dsa: lantiq_gswip: Change literal 6 to ETH_ALEN
  net: dsa: lantiq_gswip: Consistently use macros for the mac bridge
    table
  net: dsa: lantiq_gswip: Forbid gswip_add_single_port_br on the CPU
    port
  net: dsa: lantiq_gswip: Fix error message in
    gswip_add_single_port_br()
  net: dsa: lantiq_gswip: Fix comments in gswip_port_vlan_filtering()
  net: dsa: lantiq_gswip: Add and use a GSWIP_TABLE_MAC_BRIDGE_FID macro
  net: dsa: lantiq_gswip: Improve error message in gswip_port_fdb()

Martin Schiller (1):
  net: dsa: lantiq_gswip: do also enable or disable cpu port

 .../bindings/net/dsa/lantiq-gswip.txt         |   6 +
 drivers/net/dsa/lantiq_gswip.c                | 110 +++++++++---------
 2 files changed, 58 insertions(+), 58 deletions(-)

--=20
2.39.2


