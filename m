Return-Path: <netdev+bounces-110497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1B592CA16
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 07:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F30284B76
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 05:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8B237708;
	Wed, 10 Jul 2024 05:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endava.com header.i=@endava.com header.b="YLyI8M57"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2116.outbound.protection.outlook.com [40.107.21.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D00763A5;
	Wed, 10 Jul 2024 05:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720588532; cv=fail; b=ZXKigGV/YfdAjxGLjnR0CyghDfA3zuDAJyLakQTXPgSJDdKW4fexV4AlNYE1SwC8ufDt0NfRcDeVqLUBatNSqSoO8RRa7OlWIxX9/MmvFOtwT7LZ3i7c8r8pLBwtEVjl808LBghVE8OwwMCVciZuj9uPslQLROAdOheqfOdXNxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720588532; c=relaxed/simple;
	bh=RswslRF1+dnJlZDqQU0EtGXP/vsU4I2sS1mnjFNDvR0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tK6dqPaLjZt0OFWGGekXtzdWd1dU5GKO1chyja19OLoqi+kclNFgc4keDRNOsOVW20vVZEcXY86+PJwGvvKwR2/VjDRtgtGqiKeCznsOF2MpKX+nJMYft+PvM+gN3iPlp5obZhTS49Un+Cfuzl5njmneQVVaCUIqPb5RQHq05R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=endava.com; spf=pass smtp.mailfrom=endava.com; dkim=pass (2048-bit key) header.d=endava.com header.i=@endava.com header.b=YLyI8M57; arc=fail smtp.client-ip=40.107.21.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=endava.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endava.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFd3sIQp6rZGMWbw4Xnf5kg/nceGMehpwZe5DFeqayIk0gTD/RYg2ORUhLosSifZTHbmQNjslN0+nB0hcNnKPbptLE18nqb643ATKaFNawS8eSk+brXNDuDQelkaos7ouINQpWkegg4zYikJ0okED0s3oyxrWGUfS8JwTOTxIwn1eNuAHBpm2BCxWMtL9IgahgSQ9MsxFh7hI8Wjo+cRBXxM3BUgx51dpfa9eR7+Sh2GBCi4TZz0tL++t0gxw+gNG2oMO5Dtr206YtkMc4dH7+giuBsoYzvagxmvB/RfoyuO/MBFixvCrt5n2Zy92b8ZH3TH0fmWbXPhs71Oo6Srkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RswslRF1+dnJlZDqQU0EtGXP/vsU4I2sS1mnjFNDvR0=;
 b=l0gvEztbqUylBdtVzbkszgpYwQb/K2eg/wPacouJI3L+Lw/yMwNvMYdUHfO5aYIb8rsI2+mdvSV5XEY9HpwZXTqg/7hE2kYMfOASKwGh89A4piJ9dT7b1BL7B7bk7QjTDEPC+QX5VPO1LdBlh2S8aTT2BGTQDv861OGOqkeIWj5Z/aIKFqhqJMIeqrs2N7SPNQ97loPBj6HFrdU/jwAPXYo7o0UChYGg0phdA1huK+Jj1JTge/A5ygYIf4laSl2r59u3ryq9wbEduNnAmvPRNx+zBSAUhO4SC35hjuTxo/JlBUwQEAxulmwhc5fZhcVtOLerhBsSOWET+Eppxu+2fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=endava.com; dmarc=pass action=none header.from=endava.com;
 dkim=pass header.d=endava.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=endava.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RswslRF1+dnJlZDqQU0EtGXP/vsU4I2sS1mnjFNDvR0=;
 b=YLyI8M578zyCTfoBObEDjElKsQEmQzXaA+NAYq4mqq+2cgJJLzRBcLfepe9s/FvdDBTAtOITZ/f0E7vcKST6OL8V7PmTRUYN8/crvCilaiuFey0ZkYDo9SuF9sL7DDU3peSv6TR/BfAGtvAFktMk9wz2XKxRbq3jLamEFxRQekjhUtRk0GmGuHEUbbp89ne/KvRcsOts1T5fUGFuMWMhUc8YGfm05/5IO/U3FZJZ3CpsLi8oN4eVbVRLvuHc8VqN9jxTlygL7L7QpxhWOyRt5V0dWnVU2Ma5RmMb5DHBT66jClx5WOnU14K/NnD0uwo5+O6r9B1IJTC8B2RD3I1tWw==
Received: from AS5PR06MB8752.eurprd06.prod.outlook.com (2603:10a6:20b:67d::20)
 by AS8PR06MB7685.eurprd06.prod.outlook.com (2603:10a6:20b:318::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 05:15:27 +0000
Received: from AS5PR06MB8752.eurprd06.prod.outlook.com
 ([fe80::72f2:c654:1827:9c41]) by AS5PR06MB8752.eurprd06.prod.outlook.com
 ([fe80::72f2:c654:1827:9c41%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 05:15:26 +0000
From: Tung Nguyen <tung.q.nguyen@endava.com>
To: Shigeru Yoshida <syoshida@redhat.com>, "jmaloy@redhat.com"
	<jmaloy@redhat.com>, "ying.xue@windriver.com" <ying.xue@windriver.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] tipc: Remove unused struct declaration
Thread-Topic: [PATCH net-next] tipc: Remove unused struct declaration
Thread-Index: AQHa0g1uyKquZa80M0KdjmAA4is0ZLHva9Jw
Date: Wed, 10 Jul 2024 05:15:26 +0000
Message-ID:
 <AS5PR06MB8752CE5BF921CB9BC69A1C13DBA42@AS5PR06MB8752.eurprd06.prod.outlook.com>
References: <20240709143410.352006-1-syoshida@redhat.com>
In-Reply-To: <20240709143410.352006-1-syoshida@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=endava.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR06MB8752:EE_|AS8PR06MB7685:EE_
x-ms-office365-filtering-correlation-id: 43a5d40a-b324-4cc6-6de9-08dca09f4f3d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LIZDut+/E80c52wXb1+dbZcCzK0hL32oXQSeb9d1eigClUlALVefiyDU/S/j?=
 =?us-ascii?Q?3KtYrDX5bFfleQ6vsUEuFDlWZRRfx/AXDr1sbyYLTQRsQrZv9igTpPCdCYU5?=
 =?us-ascii?Q?D6MG9jVhw/UtRvDk+T/WOreArAkNOcgSTkPj2CyuDnI6y1yf5qQxuUYnN4Vk?=
 =?us-ascii?Q?xAR9Bls1eabOoT7hOd9xde2OviKfsDiYebB8y9VFUwpf+ENnGAVcmHldxR15?=
 =?us-ascii?Q?OtvNUCHEACZvY6w1Ht1xrkBvmHFkE7TOqvEtw7BHuYi1gHXhYDL90OU+K902?=
 =?us-ascii?Q?xhGBNHO10RK/ygS/5ZTlHHdiGE94h6XX9cPS8eMOiFO+8Rnb9gULBMZTyyqP?=
 =?us-ascii?Q?wyAWnknNe4VKliNVi9ZiYMKjwutHm1nuO3OP5wRtVb03JAD9ieLck3Y8cCvd?=
 =?us-ascii?Q?rbCIwUwTWV3A5bVKfZ1dIa8f8B0KfmF/dnpgqdI2IwEuH7d8St6yNGFlGsXD?=
 =?us-ascii?Q?QP5CIQsSOmyUokZmzEmjjr4KhXn7YFFcIRShWJShaFMF0druEtAjEZWRyjGs?=
 =?us-ascii?Q?c+KOiNKf6kSuBeinrmAjRrnmqxpexcgHD6whEM/mCiNYILqPlHYMhT60CRs6?=
 =?us-ascii?Q?Da6sDKDCBIiViRPYrNE9q3ONHFvOMzSJJ556vzantdSqhfPkCRvj+TRG9Kib?=
 =?us-ascii?Q?VXSeOwA80QG07j/W+et3MUSSnaGBfqUFL1ajXV2ycXpbWGDZtQ4pzWXLgKNK?=
 =?us-ascii?Q?ghFQcofyCJhmpWCOXGBXJnyziFUPTQTge/en5nv/sFl44u/T012k965v6hHG?=
 =?us-ascii?Q?fJsfuVBD+4H1OaLU6b+h5xdCSQhnzIPLoXVTsfhTCL5DL+mfGddNTja/Z/tI?=
 =?us-ascii?Q?pUTmXYGtmipuoGtqyOsV73ovQl1f18SvdgU2/n8xesBikiLpUA8ZcpN3q0lV?=
 =?us-ascii?Q?nQIye/gZGs1y93kpAdDRvNwL7uNPHqnMvjc1uH5Bua0K7awxTefNZg3Nr9po?=
 =?us-ascii?Q?haw58KVLohvG5kx9lronOTkHHHCe3AfgMAXrVTAhkvLTU8cqHf7vgQncgvZm?=
 =?us-ascii?Q?asF2XljeiB707sjPsfl1qQ2WwLwBHW6Dl4v8wSy4ICXmDEyO5QGPiy4puGS3?=
 =?us-ascii?Q?d8mbM1Qo7PzLUyT/xp2pAJ9+XYlGN9KNYASKgO5hUjpMLNNgXzYQiWLd11v9?=
 =?us-ascii?Q?6JdjySJ7RsSPPLN/sG1qhzzb1pe929VfalspBF8/ZJkDtGQURIpx0RHIMv3P?=
 =?us-ascii?Q?ayBDxaNDe2qclYw2rkesneAK3x36IwxBq24I4pKWDQpmgv6yRGsFPS3qSOwi?=
 =?us-ascii?Q?f/262ZuHcZG/pClgMPBWcrvYBUAWxOfHr7+bBAY0u/JrTS4fsoCaCZCPj700?=
 =?us-ascii?Q?4aXvyNGeUuzSbXAgk4HJALKg3zKTlxqBBE39VRUqc7dXuXNVtGEDsHANxJ1V?=
 =?us-ascii?Q?y8DwoZrFBZU/CpXYFAFhREF2ljxtT8EhkyAXIAollxxBbMF+nQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB8752.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dKvyBAeGV2WRoAnok9nVQ6olhz5q3Fa+H2u14E9fPxjxyqbWmDyf20dfxl1q?=
 =?us-ascii?Q?u1uN1N03c0LjKYpwT8Hj5s0Jh7S/ZDSnFJd6J9QtBHUG0yPhdb9dpxMn/xUX?=
 =?us-ascii?Q?vkv9sjxp3j1sRM56qk49awdabuiH8vwwRp1wJJArBumuqN6xeJrjBIdg+gvg?=
 =?us-ascii?Q?k8r1gYfRrJLaizWvD8c5XiTblB78N6MJCKgQr3EjXOYJOS9+SEVNtPgjIRAk?=
 =?us-ascii?Q?RMrIb3KqJVKDEk5h+CpnolmwpdYl4+odCxqlwuxypgcQTJIVhZuuR8qqoAov?=
 =?us-ascii?Q?vYby9WXY373wnF6qOZFaH44vT6siXFod+OQkyQLiXGd9DAeDB8ovWuOCFb+9?=
 =?us-ascii?Q?zlknto7bdIDIJsiMYxeQpA6GVPbLKFvhwGeDMAwI2NIz4oVE0c5F6l7tDosI?=
 =?us-ascii?Q?M7Lwoz6rFyFDwOQFwBewc1p4gC9SfmKIg8j9t6OsMLeWPIb7XfR00xcO67eZ?=
 =?us-ascii?Q?1uTuZToJ/hEIt04g4z3hwwNENi9Y0EH8KBEvQcIvLA6jORlhfikTXDsaorEw?=
 =?us-ascii?Q?6hH/UteMKer48ANseaNoVaiu9JpL5Y49RHdiJC4lxHDnoz28BJWvDGVZyHZT?=
 =?us-ascii?Q?qbcWIF1OildvWQIhBFjI28r2mDo4flCHxB9VegaIVRRKAO2vClW2GXrELvpk?=
 =?us-ascii?Q?C9QYbk7OoF0Xs2MEPXelvUSr2pXEQ1Bt+rXS0dO/+X6Oq0eFNmJGOywZdk9s?=
 =?us-ascii?Q?YiIKAH6ttIZM/7880NgQoqGi3DIiIL0P9T7Iqqt6Ud0VKOQomGdOi65BYL2X?=
 =?us-ascii?Q?inFf8J3/9yVGXsFavnkSIEEwbst+/ITfzfVkh8wlRvZqiuYiFv7lMbhkYn8M?=
 =?us-ascii?Q?er3BKWjp/aMUUThCnAUKGCIVSvy/Ot6eEuzD5eMdb1oWqtu1ScgzPfYBn3uP?=
 =?us-ascii?Q?Dc0h9ETbjicgZvoAvcotDrMadewOy1PHFKP6L/IluWOYOIG7mtEe3av0yWWQ?=
 =?us-ascii?Q?COyhJOxzG/XK8NJ0fgFLTeh849LaiL/SLVdiA+Fug1G7O2op+B9V6Zjxukzw?=
 =?us-ascii?Q?a85ClZtWxkJ5mY7eS3HyIWmLQAV69RBgDosSUMeLMVhUDJB9+dTgYE6htLRX?=
 =?us-ascii?Q?HFlVTelVyIn5cKB3m2CTEvpC913xVZgLRt/k+YpD1r+T2iYHrJi2te9vljNn?=
 =?us-ascii?Q?Z52oB6l7KcJGPWreX3jUahggpBVTqtTw9kybS9+NaVw5l5K28iszkzXcY1iM?=
 =?us-ascii?Q?OKdeDm/Qp9mOhl19BR5MYn4CbvWHEMtT+PZz7VERPsB2623CiKxLzTp+pnlK?=
 =?us-ascii?Q?N5+KRyOP3U++Tw8sliY6Xtd9hc+8t4N8QI5eRkDQpBcUQJwBxYNKIu1IWORg?=
 =?us-ascii?Q?2D74ipx7i609NPvXdm9qS11RAYG5jpMDZulMAHtoAYqgq1RkGD7f4aK9tYte?=
 =?us-ascii?Q?0qnYonhEBmVgA+xH3f4Ksdq0ewqfvPmzzZi7Hdk1C5yjdzXOEnvTPHKidCNa?=
 =?us-ascii?Q?hF2guFyxYCHgZMCqpV56FUBvD/iD4pEawozVCpYd+jNAsmmoHTAThJlr2h+x?=
 =?us-ascii?Q?lHMhiFBhoKyRFjaFx4SMMiz81Qg5ORrsFbO7SpwVTZOw8FcEjF6AlprExfyd?=
 =?us-ascii?Q?nMfJdIApcWAAp9Sr8I8EVIip69NudPLRO1PttsOd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: endava.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB8752.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a5d40a-b324-4cc6-6de9-08dca09f4f3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 05:15:26.9284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0b3fc178-b730-4e8b-9843-e81259237b77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tM5OBvcHHRoPNDsKMo22ZI9/HdjtyfQDfYmPRS5fc39GYtwAKTxPYtt7MJ1E2gHDqm5iRl3L6xSURUBIkZkGZF2fyDRiWsIPFg5uaJXs6oE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7685

>struct tipc_name_table in core.h is not used. Remove this declaration.
>
>Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
>---
> net/tipc/core.h | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/net/tipc/core.h b/net/tipc/core.h index 7eccd97e0609..7f3fe34=
01c45 100644
>--- a/net/tipc/core.h
>+++ b/net/tipc/core.h
>@@ -72,7 +72,6 @@ struct tipc_node;
> struct tipc_bearer;
> struct tipc_bc_base;
> struct tipc_link;
>-struct tipc_name_table;
> struct tipc_topsrv;
> struct tipc_monitor;
> #ifdef CONFIG_TIPC_CRYPTO
>--
>2.45.2
>
Reviewed-by: Tung Nguyen <tung.q.nguyen@endava.com>

The information in this email is confidential and may be legally privileged=
. It is intended solely for the addressee. Any opinions expressed are mine =
and do not necessarily represent the opinions of the Company. Emails are su=
sceptible to interference. If you are not the intended recipient, any discl=
osure, copying, distribution or any action taken or omitted to be taken in =
reliance on it, is strictly prohibited and may be unlawful. If you have rec=
eived this message in error, do not open any attachments but please notify =
the Endava Service Desk on (+44 (0)870 423 0187), and delete this message f=
rom your system. The sender accepts no responsibility for information, erro=
rs or omissions in this email, or for its use or misuse, or for any act com=
mitted or omitted in connection with this communication. If in doubt, pleas=
e verify the authenticity of the contents with the sender. Please rely on y=
our own virus checkers as no responsibility is taken by the sender for any =
damage rising out of any bug or virus infection.

Endava plc is a company registered in England under company number 5722669 =
whose registered office is at 125 Old Broad Street, London, EC2N 1AR, Unite=
d Kingdom. Endava plc is the Endava group holding company and does not prov=
ide any services to clients. Each of Endava plc and its subsidiaries is a s=
eparate legal entity and has no liability for another such entity's acts or=
 omissions.

