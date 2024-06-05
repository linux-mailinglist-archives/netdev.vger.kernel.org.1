Return-Path: <netdev+bounces-100954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555E98FCA4C
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B833BB21E71
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84B019149D;
	Wed,  5 Jun 2024 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b="FCFAKVEK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2124.outbound.protection.outlook.com [40.107.93.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9A861FCF
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717586521; cv=fail; b=QOOW09wPiCsXdMSev3JmPD0NRaVmUxPpX2WHPOWJhFOYE27R+c2jxFSqCsGLbcmv1D5fhBMMCZyslY8JAEGtRwS9Rv4BzliNgzWXfItwc0VDv5vjCSVJDQW8wQnnP2HWkfN9Rx0EF0TJhTEpfOEuG9oeg37TWHAfEsAYDMT2goU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717586521; c=relaxed/simple;
	bh=gyXfjHcTA3N9A1wU/k+hUbTv56fJY1IcGpZM8wEJwIU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UdhE7C6qVESY7AsdT4lXBTNexlSh//4bLOFsUoGeY9FpaISVnSlZ1V5xaVWQjMZGQx+oSvMxukFsJoZvEybMhmEit6/oU/CXcf1hEsOB0FtBy9fLGGGOwy8XNVRNYONTPcPrChTAsg7Z8Ra78+lG9Hln/u+tvwphdpJiBVW5S4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net; spf=pass smtp.mailfrom=labn.net; dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b=FCFAKVEK; arc=fail smtp.client-ip=40.107.93.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labn.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKElvXSWxb4NnxKVaJu/9UF7C3wurOJ34iKvLAyOhWnixTP509hmZxJ1hCxSPFZTuXG21D6In+e8Dffv/GyOq/3xqpRrgZ6/hBiAEq7+kQaSl4hoy4AenqPXz/qAO6yZ8LL023DmWui5fQq5xuwtNLbYN69rqWpMtftGUkRF/mW3EuUs1SPwSUgA5mqmHYQDNhqYU6W/hdtU/sTQKx5v4y51CmNyS+DNta5Neg70mO+49eEQOL/fvfYlZRetFVa3pxaVzM4uuP8Iv2JQM23Uh3DjjkVvA8A0T4jD5CWevu4dv34HHgGarDpYRqir9CdxOmpt+dc9nPTP4W6a1v01+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OL/S40MWVlRStooC8J3xLQMUCjoa3vE/X2Ry/js/xy0=;
 b=TxDiqBJ0rtdJCcobwcMwOoe9U8Kea2Vgze5Uq6zqec29otbxABcLnYwKr8h4fGhjIraMUTzpn/yLR7++4G/8HuRQh3QeloU0F8uf8YxaQ8q5ZDCNHLAfuHAfUE7U45FUeniMv0JZYcNRdVBr2E3XTDFKq126p19/i6BrTzlXeoufrOauUydT5xgWAtfpVW6zowrmK8pzgj/obG/o3ZvqSZF5rdI0ZS0DVyoYcyHp79vDRyYSf04XSP39H7K9LZOYKymZGSI34/R8nV+wsqXdzDUGOQ/xWqRgpjqtptBkdQLxnaEeZ/CbQvA2tozHg8HHVLhoWG+32OOJoRzHrvY6OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labn.net; dmarc=pass action=none header.from=labn.net;
 dkim=pass header.d=labn.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=labn.onmicrosoft.com;
 s=selector2-labn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OL/S40MWVlRStooC8J3xLQMUCjoa3vE/X2Ry/js/xy0=;
 b=FCFAKVEKNXEPtmdAg0kGGdzxh7G3GxbNLDkxmUtwPZW1aeXI9zdb+lQ0ahb8qjjGUSawNyIeOow1riqW9mJJgDwjyBg71oMCklQYHxrq/fgJF6MgL8KX2W1QlefD4VXLuKspLor2nXSzv0XTuC0M7u5Lg6tw6FvKbN9l7HfwMZo=
Received: from CH2PR14MB4152.namprd14.prod.outlook.com (2603:10b6:610:a9::10)
 by SA3PR14MB6485.namprd14.prod.outlook.com (2603:10b6:806:318::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Wed, 5 Jun
 2024 11:21:56 +0000
Received: from CH2PR14MB4152.namprd14.prod.outlook.com
 ([fe80::4d6:49d3:b8a4:1f67]) by CH2PR14MB4152.namprd14.prod.outlook.com
 ([fe80::4d6:49d3:b8a4:1f67%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 11:21:55 +0000
From: Christian Hopps <chopps@labn.net>
To: David Ahern <dsahern@gmail.com>
CC: Christian Hopps <chopps@labn.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devel@linux-ipsec.org" <devel@linux-ipsec.org>,
	Antony Antony <antony.antony@secunet.com>
Subject: Re: [PATCH iproute-next v1 1/2] xfrm: add SA direction attribute
Thread-Topic: [PATCH iproute-next v1 1/2] xfrm: add SA direction attribute
Thread-Index: AQHarSRcXa9/YFbUIEGh43/zr6W8DLG4SliAgADQdgA=
Date: Wed, 5 Jun 2024 11:21:55 +0000
Message-ID: <34024442-5DCF-4DDD-8627-E45072503E45@labn.net>
References: <20240523151707.972161-1-chopps@labn.net>
 <20240523151707.972161-2-chopps@labn.net>
 <3aaecfe0-b677-4160-9cf8-fe9920c307ac@gmail.com>
In-Reply-To: <3aaecfe0-b677-4160-9cf8-fe9920c307ac@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labn.net;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR14MB4152:EE_|SA3PR14MB6485:EE_
x-ms-office365-filtering-correlation-id: 587a645c-fc6c-47d3-ec5b-08dc8551b4fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VTDAZ3V6FpT74qMHO7gfS63dLID96cOgoSrwRLx7uNh7WdAn9Za9QQCmcKc7?=
 =?us-ascii?Q?c3UZ7Ruy4uX9+mtvitKn4428xVk/EWiObXTPW2lwrYBVtQ9ZrplpIARS6pQA?=
 =?us-ascii?Q?ZcauL7iTBqWmMmNz3Y4ewt0tsi2QJt4n9807l4yETdA0pQ2yoL+xxAUgoLju?=
 =?us-ascii?Q?/2apyqXa0J45DGaK/UfcIxIXMPFV6Q0raTjMOfM5Jei4XBL08fcWg6Lty5Ha?=
 =?us-ascii?Q?TCIuGJg8W+TXmFVSDn435itC5mrb6Cswc6cz6vYBjCh+M0SRmww6XtT8QKIq?=
 =?us-ascii?Q?aaUFIBgNs7P/Oy5KbSe9qkAG5w2O1JbI9REWRmOx5hCT3i20q+SFszP7/SCP?=
 =?us-ascii?Q?hLGIMo4+lGDbCqlf8XuHlxCwuGzWWCzKzax6yH3TXNSYS37TNKwXn6gs31fg?=
 =?us-ascii?Q?MelhQRmrOiIsvYzIlugtlxMmmAg5yWuQH2YRemRX5KfyOc7rrGQ04IHC0qRi?=
 =?us-ascii?Q?bbtlXgvWMktnw52O15iYHNpwagRp0QtmiRqkhsmEljDqBgP9i+q7F8Jq0OL7?=
 =?us-ascii?Q?fVz02nFZMccyHiNr01+V5LU6F0NxcEjpuCBUZ/mfg4EM8k4HMT0PXanPa4UM?=
 =?us-ascii?Q?eFe99+7m1V3WcZlQ5517VO6w6xSajA4sq8VuwtJhu5XlkcrUgtZd4mUZ2SbL?=
 =?us-ascii?Q?5a6tvcnAXRcYGbPkpL4I7ICRGGT+q+9Q40mZrgjUPyHfN5GHKpr9QJrNvzlO?=
 =?us-ascii?Q?OTm0tls7jBd8oTQJDVPOjS8wzQgXXxftkHyie3eGiMiKeYzAurMOze3deqVA?=
 =?us-ascii?Q?aItiJu5eJtQY7+V5Oy/Srrpa5V+ntzC93R4K5WWhZvrkzJO5XIYRZOgr7Ni9?=
 =?us-ascii?Q?v2lDN+l3JbruZMSBvov4L0oDmwDQKOiXc+dyzFDgvef/BX46xktndSLOTZPS?=
 =?us-ascii?Q?o+I4pe8z5pjCVjm58JNyk+j2SDks8PxF3nIDCr1DJoUTnTk1qng6TBGwW5YI?=
 =?us-ascii?Q?8reI6qVyQIgu/VfxtD+4kUALBNaRkNi2ZoFa/iuWbuOApdEM+gsuoF60zY6s?=
 =?us-ascii?Q?ezI+3QlR8UfVpnQIwPEjKZzFD0mUKICZeEhxq+N/s9fKPb3p1AQ05kwWY+0x?=
 =?us-ascii?Q?komwvkFdElZynSamxUhUsXcYAtx3NGSaQQpgf410uamNDTGz2t/jtcTXhbeF?=
 =?us-ascii?Q?SxLkAqEWsb5SicxdCw/sCJS5YVa7Ubaf1W5DIdMr0oUnN1o1TXXn/UVaW02m?=
 =?us-ascii?Q?9EHmiuLLUMFUumRGo0pcbcKnyWqcn8QT7r9YrX4QNqBibaEB7CPvOWEb14TU?=
 =?us-ascii?Q?KxMheVCoIH1kyYN6FkMdCA2bIYeGp8dXzLD+WkY/G9wxDB7qwUU2Nq8piV+h?=
 =?us-ascii?Q?/JYD+uBNrzoMSnKi7tspoKca9BezFBl1jk0wk/7FDZD+1OwgG5VoulRfXhZb?=
 =?us-ascii?Q?JnH6j+s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR14MB4152.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?L6n9QeU1jcM1BKxRVCMZb9taqCduNj0gXsDIl8lnPhTOnkh46gGLpAQPCQkR?=
 =?us-ascii?Q?/3lOoxBqni1pZ9WQPzmM9Jl/iJQQ6GzoECMwqF20N4V3PrIkiPZbvAIAgUqE?=
 =?us-ascii?Q?+YchbLlGu2OT0r3x8h3wQlZKiypC3m31ZLuaBBDfr1W5/ISSeljGe7X4rZ5Y?=
 =?us-ascii?Q?1GngRyubKhpOrPP4PDJEMdAiDKPXdoplBiALdmT9tPrINIBhgPpGiv4jGtRI?=
 =?us-ascii?Q?PmR2+DOzspjFN8Bl1RhNY1Qj5Fn/hyn1Sj+xFZhv1cOHnu5pskd2KAcuQDHB?=
 =?us-ascii?Q?PxYNXpEPsU6OkoJhaRPR8Xz0/OvkN5QVmpxE4G26yyxDzh/IFODkvDlqOiXd?=
 =?us-ascii?Q?wr8dj1HL1fMw0VnB+aGAFMASqZex2kblqNMiRGo9hfqGBcSq+yyzRCVL6M+h?=
 =?us-ascii?Q?LDUhkRLleV/2qDdHJJ8gMjRKfPt1ReNtCxiaLHwWRPbBMZ/NSlTpRqcGRBm6?=
 =?us-ascii?Q?O7GdUPN0V7c2scn7Zuk5z5OIKyAgBlsMO+FKBGGG18vStrE/ovvg8dEP8dMd?=
 =?us-ascii?Q?oAOz/0pzCsQFoDYfcExqVURCXeR8qYAzbCmN+zpCKrScv3iSibM3Cljo6p0O?=
 =?us-ascii?Q?rpLqMbLjVcQcE7SuDzPGU1zCFR3JQ66NOHd/8ZN6mjIXQ5Degqwy2rzaa+2g?=
 =?us-ascii?Q?NsgnnjZRRYhhA1kIj6EOm9Tkv/f+8Mz+iI9DZ5GgA7J6Afq4hMg/6Cdp1YBR?=
 =?us-ascii?Q?lcwonntzK/j/vIcdT6BPOAnQTWz8QreUSi0qM6hxpTy2dhOWNLePHP7nyWWU?=
 =?us-ascii?Q?RySi2IBTkw9hA+1F1bk4So6/tW47D8RIlzBX5cEBeGC33MQckyG8X9TAevUH?=
 =?us-ascii?Q?JgRVM90m6/p8nXqBwIkhmuMahfFrzGGo9Hkj6T9hZjOLmD7UzguPFHELWCnM?=
 =?us-ascii?Q?g6urjm3plgBQ89PV0Qaq932nJzgy3iSNahWSnI1FNAOFqEWr/NWZ01Vm4UCr?=
 =?us-ascii?Q?HUfspy9cLyUtoRWNoGbCLUwXqZHS2tdTEfwXPMj+zJcuXoQVrx6Hl9ojOy1I?=
 =?us-ascii?Q?sKFXZeR3+NOMW6kjnZH9ZXx0ry+YL5YEx03kv8iZ93ckKML350+upkvAegeJ?=
 =?us-ascii?Q?t4oX1XJcwuf1ejAbsbZ4BuW4ml48NBLFSd+FS1qnTOEH6bHCpMlPRDBeTohZ?=
 =?us-ascii?Q?HieTO8QGgluu2zZ9cq0bzbq6JohQuq7+8cImrrtxohflfCaIATSeAoTJWmch?=
 =?us-ascii?Q?f9k5CcnepQp4BpZIDCH/JhS9/eTdZNNimdQukFvNz9NXxqLJzWU3DB7tbqAL?=
 =?us-ascii?Q?oSaWgKI+8wM9Vy8/v4KKMpqK0oAuogDSsSMl6Ef98CHSYeRCFMnDG7CHfwNB?=
 =?us-ascii?Q?sLSSJAZyFwQ7FPt6565HNupSyY5pHr0cgoSRZzuAL72O0HtvwD/mrannA/KE?=
 =?us-ascii?Q?+BFpPKt332oQt8QiAJMV+x8xxzdhQaWrr5BlRxTM0R3PvjexbLfus8V+CosH?=
 =?us-ascii?Q?H6h36AH3YKNy5U7YpEHgqf8+ZC6DWJpLH9AvcvrIBBeNN8FW2PGDgaF50Y6G?=
 =?us-ascii?Q?FBYkTXODu1tDHihqj590sv2wrDDH5iXo/aDTNXanyPQg9eecSAR1xBsBsaHY?=
 =?us-ascii?Q?x+JAXNwzGikT6t1AB8EV/BuMUpnhQP6GjaWgI9F8FOJA/v6ttZ/RHZoUmA7N?=
 =?us-ascii?Q?2w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C896F12F51AB664E81B717D99843EF37@namprd14.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: labn.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR14MB4152.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 587a645c-fc6c-47d3-ec5b-08dc8551b4fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 11:21:55.5054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eb60ac54-2184-4344-9b60-40c8b2b72561
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VAyqo9e235wncvMPX2UPx5tFHaXgc2O88yZ6V6J/cj+N8yoxgf1NCsU4dcEFxLO53Hwb4cOTTVAqAL2hZQ/2wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR14MB6485

Thanks!

I'm new to this process so I'd certainly like to do this the right way next=
 time. Should I have labeled the patch as "refactoring" as well? Without th=
e addition of the new attribute value though there was nothing to refactor =
(be shared) so not sure how I would have split the patch up into 2 patches =
if that is what you were asking for.

Thanks for your patience and time,
Chris.

> On Jun 4, 2024, at 18:55, David Ahern <dsahern@gmail.com> wrote:
>=20
> On 5/23/24 9:17 AM, Christian Hopps wrote:
>> Add support for new SA direction netlink attribute.
>>=20
>> Co-developed-by: Antony Antony <antony.antony@secunet.com>
>> Co-developed-by: Christian Hopps <chopps@labn.net>
>> Signed-off-by: Christian Hopps <chopps@labn.net>
>> ---
>> include/uapi/linux/xfrm.h |  6 +++++
>> ip/ipxfrm.c               | 12 ++++++++++
>> ip/xfrm_state.c           | 49 ++++++++++++++++++++++++++-------------
>> 3 files changed, 51 insertions(+), 16 deletions(-)
>>=20
>=20
>=20
>> @@ -251,22 +251,20 @@ static int xfrm_state_extra_flag_parse(__u32 *extr=
a_flags, int *argcp, char ***a
>> return 0;
>> }
>>=20
>> -static bool xfrm_offload_dir_parse(__u8 *dir, int *argcp, char ***argvp=
)
>> +static void xfrm_dir_parse(__u8 *dir, int *argcp, char ***argvp)
>> {
>> int argc =3D *argcp;
>> char **argv =3D *argvp;
>>=20
>> if (strcmp(*argv, "in") =3D=3D 0)
>> - *dir =3D XFRM_OFFLOAD_INBOUND;
>> + *dir =3D XFRM_SA_DIR_IN;
>> else if (strcmp(*argv, "out") =3D=3D 0)
>> - *dir =3D 0;
>> + *dir =3D XFRM_SA_DIR_OUT;
>> else
>> - return false;
>> + invarg("DIR value is not \"in\" or \"out\"", *argv);
>>=20
>> *argcp =3D argc;
>> *argvp =3D argv;
>> -
>> - return true;
>> }
>>=20
>> static int xfrm_state_modify(int cmd, unsigned int flags, int argc, char=
 **argv)
>=20
>=20
> next time send a refactoring patch when changing existing code like
> this. I wasted a lot of time trying to figure out if you are changing
> ABI with the move from XFRM_OFFLOAD_INBOUND to XFRM_SA_DIR_IN/OUT here.
>=20
> applied to iproute2-next



