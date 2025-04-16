Return-Path: <netdev+bounces-183246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8874A8B738
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6E01904A42
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6C0236440;
	Wed, 16 Apr 2025 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="NVEFSfYY"
X-Original-To: netdev@vger.kernel.org
Received: from mail.crpt.ru (mail1.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC28207643;
	Wed, 16 Apr 2025 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744801081; cv=none; b=cT+cwt398KbWfezlBWQTZqRiaLDTtmme/ssdUhtxQLrGiDXs6sq0ftR0hqFsu3jQKNPOX8/TK9QjyKapLMK39yCWkSAnaM7dWXg2EPoJk5iobvIBhTeNyNNWDPqo0zsGqiF854I55FnxSm8wtiXPz9xAyCRPCfZt51t17Rz71Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744801081; c=relaxed/simple;
	bh=HznOvf2q9H/C46tfchJ/aD5F5paEir7+2Bx1MbpEdgI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Zg2CJWbMOt+8/cQ1/Ixgs3k/VpCrPO+VGsMIiK84LMBm0f0R3APKheT/AaEeXcwwHs7J/emDKvruoLdj20g6dLLPkwPuxpO2yTtSo3OghYICrS0qB65eIed062aDz1n9cUWqXg417e2jLPWh5GtNjTQ/e0B37iqjVs5YdiBbjTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=NVEFSfYY; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.4])
	by mail.crpt.ru  with ESMTP id 53GAtloh003741-53GAtloj003741
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Wed, 16 Apr 2025 13:55:47 +0300
Received: from EX2.crpt.local (192.168.60.4) by ex2.crpt.local (192.168.60.4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 16 Apr
 2025 13:55:47 +0300
Received: from EX2.crpt.local ([192.168.60.4]) by EX2.crpt.local
 ([192.168.60.4]) with mapi id 15.01.2507.044; Wed, 16 Apr 2025 13:55:47 +0300
From: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>
To: Ajit Khaparde <ajit.khaparde@broadcom.com>
CC: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>, "Sriharsha
 Basavapatna" <sriharsha.basavapatna@broadcom.com>, Somnath Kotur
	<somnath.kotur@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Padmanabh
 Ratnakar" <padmanabh.ratnakar@emulex.com>, Mammatha Edhala
	<mammatha.edhala@emulex.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: [PATCH] be2net: Remove potential access to the zero address
Thread-Topic: [PATCH] be2net: Remove potential access to the zero address
Thread-Index: AQHbrr4bomvL6pb+ekyghxTxcqhCrw==
Date: Wed, 16 Apr 2025 10:55:47 +0000
Message-ID: <20250416105542.118371-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX2.crpt.local, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 4/15/2025 10:00:00 PM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 192.168.60.4
X-FE-Policy-ID: 2:4:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=LVTDQyH7Qyb01X8CRX4auq695ATpkQuo7XLe5Vt7aQ8=;
 b=NVEFSfYYWNrpEPwYTySZyWzg5qUA0VmnWQ9yJfMhTv9pCgV31jmzu0a99dBM0FlJ4JYO7fVmrJ11
	Dmh+iS3Ew+BCXbzPmXGnR01DCOjSLBj6kAZu46e1iGmryIHT3TlRld3qVw1Y+vKdqmK1B5VjMW2s
	UqDvf31ONW5k+TJHj1ACGft3vv1ujgVuyRjtnzh0XvWXRFhtRazls7BRD7YjmaqXfAGAvSTYEl7v
	xqSLxGPp26xLY+US/H95YVCbpZQ+y1CaRHYNcqhPkxAPPUUz/yucDuUY8ah5gACEfbrTG+Bo+boG
	fvZD/ZMTtfv+aD77NxrP5HZnSTAyl8epyBow4Q==

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

At the moment of calling the function be_cmd_get_mac_from_list() with the
following parameters:
be_cmd_get_mac_from_list(adapter, mac, &pmac_valid, NULL,=20
					adapter->if_handle, 0);

The parameter "pmac_id" equals NULL.

Then, if "mac_addr_size" equals four bytes, there is a possibility of
accessing the zero address via the pointer "pmac_id".

Add an extra check for the pointer "pmac_id" to avoid accessing the zero
address.

Found by Linux Verification Center (linuxtesting.org) with SVACE.
      =20
Fixes: e5e1ee894615 ("be2net: Use new implementation of get mac list comman=
d")
Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
---
 drivers/net/ethernet/emulex/benet/be_cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethe=
rnet/emulex/benet/be_cmds.c
index 51b8377edd1d..be5bbf6881b8 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.c
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
@@ -3757,7 +3757,7 @@ int be_cmd_get_mac_from_list(struct be_adapter *adapt=
er, u8 *mac,
 			/* mac_id is a 32 bit value and mac_addr size
 			 * is 6 bytes
 			 */
-			if (mac_addr_size =3D=3D sizeof(u32)) {
+			if (pmac_id && mac_addr_size =3D=3D sizeof(u32)) {
 				*pmac_id_valid =3D true;
 				mac_id =3D mac_entry->mac_addr_id.s_mac_id.mac_id;
 				*pmac_id =3D le32_to_cpu(mac_id);
--=20
2.43.0

