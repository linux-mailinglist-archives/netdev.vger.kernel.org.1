Return-Path: <netdev+bounces-244914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53020CC1F1F
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 11:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0264D300BBB9
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 10:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD2E315D32;
	Tue, 16 Dec 2025 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PbHP4YRp"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013083.outbound.protection.outlook.com [52.103.74.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1A52FDC3D;
	Tue, 16 Dec 2025 10:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765880414; cv=fail; b=R5l72jZrd6OH2JHW5etx87qSeivXD05b7d1FWhGnKBsY3Yfi4migsDTyxkfGeYOMxKTbCJFSC3HvYh99cawLUkG06mBfdvGAlS+hQbd54sanMBABpNYRZZ7HgHybfFgK2RXHelmmQlxmCTHgsshp9FTEZhiGVYmJu1GU1/wFsT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765880414; c=relaxed/simple;
	bh=QvS/y1KqNxd2do2RRIm7t5So0/sXaCiMevieMTPhRAI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=k2uRWI1/a8xdrToPfLnMA6CYDaPz2Yy49U4HHTE/+dhJyJ2Tt5JrIG+KPpGZX+dPd6FJlUWTQ4WLRlwx9ycBqnbEubo+ZrbVxaIvRw7fYt1CzF6Y5MLwOyXNp77yhWZUbZMPEhW1OUQBJO5yLUDRQe5MfBYiP6lnxiG2C2h9kq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PbHP4YRp; arc=fail smtp.client-ip=52.103.74.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ug6DDbwq857da40Eoo2/+kZIuimgWAZ27Z40Y9KmcNdtBVyfOCCWp3O/ylC/0CeUJw2LSIGH5o2RjYikcuH2xN6yNUAew4A5cYiK6xyc1kj/pLNmdnbF3PKSb+Rj+H6vRBW6aFI4U77qp/DZCnELuw1Y21S8QlNNmGC9YkFhvUt/gozLHr2FwrqDHmR5keK3MTrj9H/+xeA7VmM/qy69ywyr/bNAQedkY+ZBf95gNOK+CCQdGys8GpkKcwnRhdJHOM9xm2TU9znWj2HiXPtNXi7eaJMH3bLX1B2qaNC4YTu7bXD3CUIyAS81q5epCCpF6GT0/gNfkmsC0T0WJiVc5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvS/y1KqNxd2do2RRIm7t5So0/sXaCiMevieMTPhRAI=;
 b=Mg+V7rIIYvjgwopdjH6AwH7YSqDzHjZoJCSqcOYXO5t6qtWHUpyEtrDgySDtsGvDu79sTnDWz/Owl+s7PJBk9xQGctrAZZ71fY8qNe7zEj1D4C6T6jy7Mk3WCDXN4hZiHyZt6xVq+JX6yuZUlOqhsoDyabigtDOqL2zV/rnysZc/8sC5UiqlrZJSP1yCiUp3xNBIYil9Yn3++MYLnGhA5hl84tJFjugDP1E9dZ6lAqGn6INErc1Tnb4ThNmMDmgZVjj322E30nikbFLQiuvwUXHohA0XbAbWMIGzJeeaFSj2ngPO69AotYRKJsrQeVCoPuCexB80WZjItgR0LcUglQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvS/y1KqNxd2do2RRIm7t5So0/sXaCiMevieMTPhRAI=;
 b=PbHP4YRpCmd/dyrXuiNn+Ls7eG7KQZX2Pth4yWb8X7nHQsRjWVcqgJL/1hNkTuiqswGvaBwCo/QFFHbzUGKflPAv+TNt8RT5/zqX7AeNTuV4IRNiZ849ZGCaP1lpAaXyjK1lxGOWtjRwdKbqXB8H1HqAAiownwipTQxgFSwnacrADgOZ8d560Jv45sPISPoQDVvECWgm7FJf1HiYK704EJKW5kCAi+CBEO64Wj4KhxxFj3NzOhyRB0ZsAiP80hsEJAGgjTr97kVdLNbfN7oFTEX85W/juMP6WxcL9w/okvaGJr6jLNDESM+EebDilCjoI/q6iZTlrHAByoCOoIOlhQ==
Received: from SEYPR06MB6523.apcprd06.prod.outlook.com (2603:1096:101:172::5)
 by TYZPR06MB5930.apcprd06.prod.outlook.com (2603:1096:400:336::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 10:20:08 +0000
Received: from SEYPR06MB6523.apcprd06.prod.outlook.com
 ([fe80::4f9d:bbfb:647d:e75f]) by SEYPR06MB6523.apcprd06.prod.outlook.com
 ([fe80::4f9d:bbfb:647d:e75f%3]) with mapi id 15.20.9412.005; Tue, 16 Dec 2025
 10:20:08 +0000
From: Abdullah Alomani <the.omania@outlook.com>
To: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: docs: fix grammar in CAIF stack description
Thread-Topic: [PATCH] net: docs: fix grammar in CAIF stack description
Thread-Index: AQHcbnUW/uU0ndLqa06O2qf98g64SQ==
Date: Tue, 16 Dec 2025 10:20:07 +0000
Message-ID:
 <SEYPR06MB6523AA8FFC17D23FD3539A658EAAA@SEYPR06MB6523.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB6523:EE_|TYZPR06MB5930:EE_
x-ms-office365-filtering-correlation-id: ec01f3fc-8c99-47fe-c9ae-08de3c8cafe7
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|51005399006|31061999003|19110799012|8060799015|8062599012|15030799006|15080799012|3412199025|440099028|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?uISeJB04VJhteYieDRX37EaOli8O7pMosqoy5K5zkzeWiCO23TNd5xetlj?=
 =?iso-8859-1?Q?gmzsnaLQzyEmyFRx2opPtJfSrtSDbcbTAj/WDhd1QzuaQAunlUQKrAAPEL?=
 =?iso-8859-1?Q?+ZFHCzVREYWoQ7AVEl50sNE+QAj/oZZ46z2InyRqxRTxtMBd20kxlg51je?=
 =?iso-8859-1?Q?l9ZUk/FrTE+ueoYV+zOL1dFkewH03nYawxbZiQh+k8kwcgoXUnIUkIKqkN?=
 =?iso-8859-1?Q?X99zuXwdUZhweDd8KLZENtM7386UFDun0GfHafoU34Hhwm3Fq6ULhy6ywE?=
 =?iso-8859-1?Q?nYlnptPWGwIantPcls3poVSRi54yT1vbnTDNy2LrIzK2Wv368jG//6qitQ?=
 =?iso-8859-1?Q?ODw0nN+okqprz/XEtFzTiyshBzr4dvVzhtSc6j1hj3GZduz+SvP0ehzOh4?=
 =?iso-8859-1?Q?CPG/JsYIjfIFA8nSES9ibbXZJoddGek8EGb6LuNat32/U+8AA4VxBhC59+?=
 =?iso-8859-1?Q?MbmoEEmQcf3uj0Gd3G2OhirWh2Z3Cc/MrLxMJsL3NYQ7V3kTAK5cm1noQG?=
 =?iso-8859-1?Q?s8cDsU4NX450Viix9mpNaN9LbOoszzU+13FyZtLrrTol8W0CzkFb39vPq8?=
 =?iso-8859-1?Q?BioNV/UWdTrDaC6AzAhi1dNKmG7ennk3bgnVp5LJK1GhwR1yilzmmcy1P9?=
 =?iso-8859-1?Q?F3yUdqNPbbbbpjAnMnaqnyXqoQevsCXewhouC9RQrr1HNUoUc+Mg4kjkJv?=
 =?iso-8859-1?Q?KM5gWDGljD9kpOqEelwpRZVkOl8SZmqpmlWpE0a+PFMChd8m8BqsjsatrZ?=
 =?iso-8859-1?Q?fpzntBnX0b+9D0JysNEBtP1+558OENlVXHXC2KE3FT1d3z2HIayecCjqxN?=
 =?iso-8859-1?Q?9F4Dp0Pu8ZTGcZlVzG/lzmuLLXYdHHR+rc0ulZYgmUCzjt4WTh+iVHEc7Z?=
 =?iso-8859-1?Q?CwNUP5su2tsg/tpib7OvgOq19dOFQls/p7ZWMABFOOx+DpTxCM1DQiwTLe?=
 =?iso-8859-1?Q?lPzAjfrvY2038ZctRsNfH0qaGUgH2PmCb8Kkt4lmINPcWdoSJ6JP9S9YQ5?=
 =?iso-8859-1?Q?RDrMfg7HAXRjPBvUdzl0+wIiYMPtC8AACit+jqcQcAd2SqMmVxmf8PJEZK?=
 =?iso-8859-1?Q?UVj0/Hj4hui7EkWd94YkwRgX+3iMTPT9firs3L6OkCC+H4kAvAJmnv9z2n?=
 =?iso-8859-1?Q?XJvpaCKixdRuckraFubPc9u4DuCAkZbxijRckxYsFBdUv8mSd66sadD8Ko?=
 =?iso-8859-1?Q?eO2yq3Vi3nGDcQ29nuDm0A81Imn0qpRq+XNS2YUSYBEUMmjZ2C1FyFEuax?=
 =?iso-8859-1?Q?Rp0IwNeLglkHGAxnoWqg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?l8W6G4grDdwAolcr34rtJYRF5NjKOeG5/BjQeE72EFUmsQg5DY4uH9D2U5?=
 =?iso-8859-1?Q?0SdzmnzjM7sbbEjyIIAk2ql3U9vG8TJwCaHMT5KyAEyKt9E+dp0c9Mp2Uz?=
 =?iso-8859-1?Q?DbDhfbjdZxA1P29Yum7dB4zq//5Xr266s/YdGP03ODyw43zLp0IAfdzPOq?=
 =?iso-8859-1?Q?UX1I8M0cikOorQiIlaI7gSY0dGJ/osRimoiDD40nj/k2jTJPk4xLsFi/UJ?=
 =?iso-8859-1?Q?g/e7pxz5tHAN27sotMgPgCxKcs/iqnSe3R0ljRWODX9V+QGE8FXPFyaVJm?=
 =?iso-8859-1?Q?YEb0f4iw4D9xwcR8lNOij/z4fyfhvpdtRKZnSPqDaWjlKg4DFkQuKhFIpG?=
 =?iso-8859-1?Q?g3y2uiFnXANxfMv4PGEPUoFz0dImBh4Xto/xSvoeH4gOm23ny1hPnk5hEJ?=
 =?iso-8859-1?Q?eMJV/Yg+JA+ND50UzVWvXsDw9c29Z3PvTBP+/eU4gfB2g+2EfgAU2t/TQY?=
 =?iso-8859-1?Q?SgMGAtdnKavLqeXJ6nENPiasa7hj++me3EL9ZdhzFFpnnKP5/nKMlz7pum?=
 =?iso-8859-1?Q?YnIc0cydC9DdfIHHpteitHjsk8qFXHQvV74u0HtLA1GOyoInnpFYA1/JSB?=
 =?iso-8859-1?Q?5YT8izbdQxJi9JoeBj1r+YlKxvc92H2UUGAKgTmXGpA7GGnmgrngKy+n4Z?=
 =?iso-8859-1?Q?j3L8oUKlOQJGOQDpTIcVNBimcUfcmW1RflFmF6Tkl7iBeenXcg0wdH06Nk?=
 =?iso-8859-1?Q?fq/UZgP0fojp1LoAlMLUjb/4xnjIidbULmTV2KUUTZlydNOzDinFEel0Yb?=
 =?iso-8859-1?Q?zGcnEdjxqT63tfrAatGxxAGda4rFmGZUaWUpwBEdGN0UBGn2FY7TfdBDx4?=
 =?iso-8859-1?Q?zC25+pQBTfSZdgeKXy/hSaWbyWDxthJqSLIPI8SQknHnbNU7es1JAkQsnw?=
 =?iso-8859-1?Q?EdP3G5R38B/CIIwkhK3KWpByJOI/GvGCqsGpZ99wBCHjfdSSNaaW/l7fM1?=
 =?iso-8859-1?Q?FJqRmq+4e0LV+/jVIPoFMq5OSDW0YXOGcQ6kGjLb4et+GHm6Ty3XytMB44?=
 =?iso-8859-1?Q?z0EjWWYR9h78CVJ0gs3M/w+vimORzXnyyUHmGg6Ls5VevSuEZ96UZPbXyy?=
 =?iso-8859-1?Q?BZ/RRF2TSs9/aUKEYrmJokbx1DSrM2yLp9ZlvPNtR8f/dOlzhK5HL0l6kD?=
 =?iso-8859-1?Q?fN+WVE9k1GHpLwatg7cmJdyzSOpWVuWUmfMbBbDt9oOVDEN+/0xETGiDEX?=
 =?iso-8859-1?Q?lp0ZS6PPEAbSUHtkhOMCOmrYgm6/MMMkPM3yxBroV0NzQ4qXOZxEgR44MN?=
 =?iso-8859-1?Q?wXCF5M45bkjRSZYvye0vBaUAYLgEC7K3E2mzxKpO4psvVTm0avd1/aWUlP?=
 =?iso-8859-1?Q?Cztb2S7UtM2Rw0RzXuMBOqRFulroLlxwXUn+f/NN6g2qf/E=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6523.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ec01f3fc-8c99-47fe-c9ae-08de3c8cafe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2025 10:20:07.7081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5930

From dca59dfe5e73f39885d1c65b01d8da115a7a2c22 Mon Sep 17 00:00:00 2001=0A=
From: Abdullah Alomani <the.omania@outlook.com>=0A=
Date: Tue, 16 Dec 2025 12:20:36 +0300=0A=
Subject: [PATCH] net: docs: fix grammar in CAIF stack description=0A=
=0A=
Corrected "handled as by the rest of the layers" to "handled like the rest =
of the layers"=0A=
to clearly indicate that the transmit and receive behavior of this layer=0A=
follows the same pattern as other layers in the CAIF stack.=0A=
=0A=
This makes it explicit that no additional layer-specific handling occurs,=
=0A=
improving clarity for readers and developers implementing or maintaining=0A=
CAIF layers.=0A=
=0A=
Signed-off-by: Abdullah Alomani <the.omania@outlook.com>=0A=
---=0A=
 Documentation/networking/caif/linux_caif.rst | 4 ++--=0A=
 1 file changed, 2 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/Documentation/networking/caif/linux_caif.rst b/Documentation/n=
etworking/caif/linux_caif.rst=0A=
index a0480862ab8c..969e4a2af98f 100644=0A=
--- a/Documentation/networking/caif/linux_caif.rst=0A=
+++ b/Documentation/networking/caif/linux_caif.rst=0A=
@@ -181,8 +181,8 @@ CAIF Core protocol. The IP Interface and CAIF socket ha=
ve an instance of=0A=
 'struct cflayer', just like the CAIF Core protocol stack.=0A=
 Net device and Socket implement the 'receive()' function defined by=0A=
 'struct cflayer', just like the rest of the CAIF stack. In this way, trans=
mit and=0A=
-receive of packets is handled as by the rest of the layers: the 'dn->trans=
mit()'=0A=
-function is called in order to transmit data.=0A=
+receive of packets is handled like the rest of the layers: the 'dn->transm=
it()'=0A=
+function is called to transmit data.=0A=
=0A=
 Configuration of Link Layer=0A=
 ---------------------------=0A=
--=0A=
2.52.0=0A=

