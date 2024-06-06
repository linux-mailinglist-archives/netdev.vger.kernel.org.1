Return-Path: <netdev+bounces-101313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B928FE1C0
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A3A1C247F6
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3871494B6;
	Thu,  6 Jun 2024 08:54:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5287E13F443;
	Thu,  6 Jun 2024 08:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664070; cv=none; b=scou0LJ4tHgXcU97pyC4cu/WWIHFSMkeNzHKOm6KIwoolYpokZXvwsW5fYN6A2Jmjtz9FANv6Mlxoa7nFaLLGF6FIR1aXy1r88DOwUj3lvboUsPK0G0LOsiu1EIwCc4oMPPreUPbcWiIpja/QXAug+pII8KNyvTW2UzDUC7iGlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664070; c=relaxed/simple;
	bh=r3iuti7lDwZ0oPfpVeo+fnC7tvxPcC58p6W6V9840pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjLotNIv5kzWSDpJcUSkRD6Xgf9vMnqa8k+vcfyIk6fhv5KhjScLpKFVQv1Tawi5kYkVi3V7neTtoWDI9Ap/zptH9aA2xqK3BjOC4P5V11HX4o6QiKxWLrUtOv3wExgx/u3H3RipazSwAWq/1Me1Slq7lbrrADflwQjPfmYeQNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9901b58ca3=ms@dev.tdt.de>)
	id 1sF8t6-002kyj-NB; Thu, 06 Jun 2024 10:54:24 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sF8t6-00C3xA-5b; Thu, 06 Jun 2024 10:54:24 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id D9E0B240053;
	Thu,  6 Jun 2024 10:54:23 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 6F4E2240050;
	Thu,  6 Jun 2024 10:54:23 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 362A7379F6;
	Thu,  6 Jun 2024 10:54:23 +0200 (CEST)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 04/13] net: dsa: lantiq_gswip: Don't manually call gswip_port_enable()
Date: Thu,  6 Jun 2024 10:52:25 +0200
Message-ID: <20240606085234.565551-5-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606085234.565551-1-ms@dev.tdt.de>
References: <20240606085234.565551-1-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1717664064-7CEF3356-FB453595/0/0
X-purgate-type: clean
X-purgate: clean

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

We don't need to manually call gswip_port_enable() from within
gswip_setup() for the CPU port. DSA does this automatically for us.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/net/dsa/lantiq_gswip.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswi=
p.c
index fcb5929c9c88..3fd5599fca52 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -898,8 +898,6 @@ static int gswip_setup(struct dsa_switch *ds)
=20
 	ds->mtu_enforcement_ingress =3D true;
=20
-	gswip_port_enable(ds, cpu_port, NULL);
-
 	ds->configure_vlan_while_not_filtering =3D false;
=20
 	return 0;
--=20
2.39.2


