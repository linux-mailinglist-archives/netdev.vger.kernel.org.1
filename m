Return-Path: <netdev+bounces-111691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D41932146
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 09:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E1DDB21A71
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 07:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15B62C19E;
	Tue, 16 Jul 2024 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endava.com header.i=@endava.com header.b="KUAOGRHV"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2133.outbound.protection.outlook.com [40.107.20.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38D028389;
	Tue, 16 Jul 2024 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721115357; cv=fail; b=Q2MGi3+vSJU9l2fY0aKS2IpJiBv0hg+It3jQG7A6SryjrG106Dn0walCBb0TUrLaoPWXeA/B7FLyI6s0RXRbcEZjmBaq904SVV/QLgA7R/WkRj4fZ9Fy01GrtEgSXuyBBKaHiQ2i7HV+41g2FdIu3WM1ETlcudB6nToRItnGCX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721115357; c=relaxed/simple;
	bh=5Qm0MWFrXxeOApuzLz7KeBu/EEquE9TMb/z91qKR4pE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QUSg3893O1Z2pIEiVeppqgANgcwhvjyLMRrjDkJq7bAXHebcVC6uOlCdWki5oCLTxKJbMgUgZmfU6DnSLcax1ZjF6h9wt3PlcrUT4BqyzWANQ8iBx6v82dz5MnEA8jVCdcnliq+lZdASg3pwhp2TSLghxLBS0OJLQEV66X2awa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=endava.com; spf=pass smtp.mailfrom=endava.com; dkim=pass (2048-bit key) header.d=endava.com header.i=@endava.com header.b=KUAOGRHV; arc=fail smtp.client-ip=40.107.20.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=endava.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endava.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYK6QZiCVBewjngfJMoitlmstQn8tjN/q7eZgheAkCLe2crvoAXKZ+sZ3ajywkDn2lAsYyEsSfd51p46Bg1Eb6W0k2d4AI3xR3p8H18VPmpK6U4uBlFQM5+G8neNjA7e+vEfAZa/xP4rw9MgPv6l3lwQS0fvq+0uXHQyd7esMU40GMHLBz5fhjFQoft11NGqiG0v8qSw0kJM4qghef0+/v0YzwB1/wZ2rX51jSl6LfNezI+i8IEti/RAtb5A+Zfpy1OfWzT7bl4CsTpYHbEABqtTTfUOk8wUkCbQqEe3PQISm9CqSOZmH/pfPQueud4lABxM7W5s8WXDfOoJBTFRVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gv4V0QZpoCclzR3CfOWhKuAc7R7JYuElGRB5njtqnzQ=;
 b=OjV9kmAGCwxbPrOnFvyJSgU1DXnJGJXCse1xELzoBZVIwtkQ+7EN9gMe1EwxWHLTF1fY1n40fl49q3YJ90aOCaP3Hypv5f2auz0eOjmg92J3eQmA2cNr/n5PfoZ1g56NlG0krCAQGC3AO7/7f9NYNV7UBV1j1fnDzUhUS7kUFCFEpDoPEVH7TQy1BHcHh4XoQKm/SOxGJjGmn1O7qis2Fr8XDCSt9ZAiksNnGkqM0YSLznCw5eLkDX7Trv3xtouEecsaL1nH36z+dzhl1/hgs7TB9VEfqIi72rwvRLSh7JIQqauYciCzRw7ghSmOaHYw9s+nuBEdalA1yj2gal6RzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=endava.com; dmarc=pass action=none header.from=endava.com;
 dkim=pass header.d=endava.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=endava.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gv4V0QZpoCclzR3CfOWhKuAc7R7JYuElGRB5njtqnzQ=;
 b=KUAOGRHVUoGw00bb1ubHORwKc0MQMhtBvm95rYOKtoG+wrhqk+uPfpUeCczkHYWOtjpH4F6FslBOGGdTQl3Y6bOJ6YP1XxrGX7xHUgTS1scW/fGBx6vomgCYgk5upnGf/wTPpE6jO9YT2AjI1qJepsQuQQf8FEIvycF6jcn4DzZLUfW0RI/N75GVcc9snpxd9KNmnM1fgv1Nbg/9vaGc5EWpBOs4ZZtCr6JiWfPH8qoFKyF/5aRST3hh/bm8HarODESWDRScjR797wN2FfW7EoKJW+T1dKsA1YHfIa5pDSvsF1PcliU9UjmfYqzQOGMXah7SwztiXV/Ahxlps022iw==
Received: from AS5PR06MB8752.eurprd06.prod.outlook.com (2603:10a6:20b:67d::20)
 by VI2PR06MB9255.eurprd06.prod.outlook.com (2603:10a6:800:22b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 07:35:50 +0000
Received: from AS5PR06MB8752.eurprd06.prod.outlook.com
 ([fe80::72f2:c654:1827:9c41]) by AS5PR06MB8752.eurprd06.prod.outlook.com
 ([fe80::72f2:c654:1827:9c41%3]) with mapi id 15.20.7784.013; Tue, 16 Jul 2024
 07:35:50 +0000
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
Subject: RE: [PATCH net] tipc: Return non-zero value from tipc_udp_addr2str()
 on error
Thread-Topic: [PATCH net] tipc: Return non-zero value from tipc_udp_addr2str()
 on error
Thread-Index: AQHa1yUvQPqLAGQ2A0GB9aoYG5W6f7H49WZw
Date: Tue, 16 Jul 2024 07:35:50 +0000
Message-ID:
 <AS5PR06MB8752BF82AFB1C174C074547DDBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
References: <20240716020905.291388-1-syoshida@redhat.com>
In-Reply-To: <20240716020905.291388-1-syoshida@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=endava.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR06MB8752:EE_|VI2PR06MB9255:EE_
x-ms-office365-filtering-correlation-id: 86fdad13-a54c-4ac7-ebf2-08dca569ea87
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yi/RtCl+VPbL+zttjR6ux2WTBEWduVAXckpYwjgJawfF0YH9wm7hOyStvd9Z?=
 =?us-ascii?Q?+OI1aPg+yRr5g/FjnHdernumsoPLS3t79MPg8ZvUMbtwyRwMcJh2Uhs6FZtB?=
 =?us-ascii?Q?+6L0dcslOGZHeHJmMVGaq+Y2dpF1yj8QlO8jrqHlAFwPSr8W42bRqqm8lI4D?=
 =?us-ascii?Q?sQphwgbRUWtopvR3jbzaw7KCcDSBm6RMPi+evM9h/N81ZwkAGsp3+LFHjXei?=
 =?us-ascii?Q?ti11uEpFk24c1xO6xJYflZTQvjk6bBGfbh2eD3snMTO3tgBzGhv4ka3HZOps?=
 =?us-ascii?Q?PX+/GqAnSINhIITLrIDvqIrvXHF/y1FiWVhJUu9RoR6ja5xqxcf/k+UYIdeg?=
 =?us-ascii?Q?HIxXnj7Or95hNRE0HF3hT7jTZifnCoqRxee8m8etDKOGdGZCK/YgRy+IDH/q?=
 =?us-ascii?Q?tRxyhrjKuR6DNGJbbPHcDfijbBLAiOv31Kz/xX4Raep0rgI1nkWGwotEw7oC?=
 =?us-ascii?Q?/aiDNfmb+KYkF1iKPtoB3D7mY76Ma+ZXCviK6C43k7SCG+gdmAPsinL92jMp?=
 =?us-ascii?Q?ULzpQcmF3q8GkiF/iQvMorf4aRvTcXf7mjPQbzDpli2VMtLDatFIpwCyRQzj?=
 =?us-ascii?Q?1tHXR+rt3jN3DOgfymJErcEeNrks/Tf0HAKBHmIYCl1so7uCj4DjFkZiWFVD?=
 =?us-ascii?Q?QVsrm4NkWd2+m1cfJl2ZWaj9gVYwOrmYr3FHJB6eaaxUf+bsOTIyaTdy2glT?=
 =?us-ascii?Q?3lPIBnf2KTJrQxLZrtRRgZWbJAMyTlpqG3HsILmFHeck/AzbDviA6W+XeCOl?=
 =?us-ascii?Q?kvpthEkg6j+bfKSij7HdO/UW8Vl9oaNParRduYF52sE6uV3xlu+ZW3YuU75e?=
 =?us-ascii?Q?Sy0THXR+JRwj0oRbezAnzA4shr/MM/9A4pG3Sm/SzGHWtooGr73D3qdck443?=
 =?us-ascii?Q?eD7inZPX63DeZPFTjhFl3hzUJez8PmzszWMmuso8bhBihUeY0by3+cIYPdEi?=
 =?us-ascii?Q?6do4gp2pSys6F6Yd1kPiBPawVbO0+QFL0JWp2gOmO5Dl4rVx8uKvvsSJaWzX?=
 =?us-ascii?Q?qctrSrJTIIKrTH4fQDn8JKL6pMbAKiIdkWx3jfTTVA5e4ukASCXncvLrwHSh?=
 =?us-ascii?Q?EuB8E0l3ZJZLFS0aJM7edoA/XYrStiRa4XrmvaQbaovO5aDJZ1bbGtj0Byeb?=
 =?us-ascii?Q?otDDcrSQWsjLNcl6c/yQ8prPFNhYQj6NpuS7CrTXfNTJBbCo+HRJXr1Kr8vv?=
 =?us-ascii?Q?QTGiL9fq5FiIbupt8HvgpkbvfLcWz5EaN+XjyI802iqndygtjKgc+7MbCLu3?=
 =?us-ascii?Q?HKAy9BC/zcEtfY0oehVvDuOkLTqIslPATkc26FzzSG2dXhKaAA0Lvk48qTWG?=
 =?us-ascii?Q?kt5SLVe+jXFSl9ZReHv8E9USoiMjCemYn1LBOECjci6RrqMXK9bTsYP8Z84g?=
 =?us-ascii?Q?4R6S8/HRb57twmXX4fF4LueujYX3rOe1AEzzd0QQm2J3dUDPAQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB8752.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xLbqUumsDr4Pw20aC0LtS12PtPXB7w4dpiRZXg1bKlNZKfrezWsa7CpBN0om?=
 =?us-ascii?Q?0vT7ATUBSHU49xyKSdRXlUvb+1qrSuaC57f9g5wRzbHc2/RUxFngIPALbC0S?=
 =?us-ascii?Q?TBi+mNreGmPdC+eKnQ1T7a9YbBn6B2zNgkxdLVcs6HCewj4mkO2+2Nj7Telg?=
 =?us-ascii?Q?vXoR9GaK5Y1LPW7n5CZI50r6m/bUnpK4T8NggS7Yu6HXmx6R+YXQ0Hq2tYqs?=
 =?us-ascii?Q?oXlLSjWGEourxzba2keyxnJFJ5hl1Zpw2sT0HhclnBR+2RNSan5gslgUOJux?=
 =?us-ascii?Q?0pNs06QkEsftpJoUV2ebhtPtlbZtO0fa4zJSA5dTa56ieMbMYxURu4ZBUr+s?=
 =?us-ascii?Q?mA9xHNMSqYUXZuvPwWue0UZLMsy0NrSKOhPdbn0qY3jhz/NchiLYdXj9nQEb?=
 =?us-ascii?Q?NMm6x//pv2RQnYhpGG4TlZq4uypzLcIgN40z1J0YSI3PCavGBxT2QaXe4+W4?=
 =?us-ascii?Q?VMmCDANFkdYbuPMzmp7+rZwRqWelTXyycjFHZvr9vpp9tbveNg7rxZD1KHDj?=
 =?us-ascii?Q?iv0NHuvCIFsS2THeCUz2iRgUH8vSAdA/CIcQ9bFvqtJ6iuOIenAMHkbyMnVt?=
 =?us-ascii?Q?x6wu2FtJfKXJQx/tRLByimMQlHLV/rtEn44Chubgt0uYibAvVpuckXj19q9D?=
 =?us-ascii?Q?Bug+lL2kZF78Gi3rM1UUxd+E5v8aKtEwGkLA3LDHk8xmBudcAPiBZo7y4zBj?=
 =?us-ascii?Q?IF/UVxt20p1QJLogB1FfAF9BHOCzSeJ2iKYmCbueFmiMg/9SQz4xPoKa+vD9?=
 =?us-ascii?Q?U/+TS3WUMlTQ2bOKjzavfPZmgirK2/mya8A4rjGYH+lGV5zQKipjaCZM2KIY?=
 =?us-ascii?Q?7vsItHV0er95XHHValkBrzwEnC/I49L1MQfTuijTG6LDSQPGwG2KS9uTR5Sz?=
 =?us-ascii?Q?k41KATXB+Vy9ExRHbQX+I9yE6erL9z2516vsz0RDQ/hprYzK9QNh1zrsIWPm?=
 =?us-ascii?Q?srXaGcrPwEQcQ9k8/hhFAkkqq2B3ucbWEOxTdVZaOomIlUAJqd53Jn4qY1/I?=
 =?us-ascii?Q?gwtli8ARyfyIZ3gSAAX7VtbKo6aV48ay7Qgk9vjw6FMlp02lCy0vRMm5ReIg?=
 =?us-ascii?Q?YXNxPCB0/w03VSThuSa5UsxHIp2qMVw7JosaN/j+kMzaHwU8OQJpm/unslFe?=
 =?us-ascii?Q?gvLCxVcP8orZMOHUnoD5gIXtnHmZ3h1Rq7vFxl3ElZD35Y+dCRF2J/FBeBdV?=
 =?us-ascii?Q?Q0xR2ChfCkr8ZwNOl4tP9Hou00QINiOz4RQ4af9eYedW/lELiCRvDFsrd+Tv?=
 =?us-ascii?Q?nG5x+K7Iw1hdmvmOoQFwT/Dn1d9vmwP74G3rx81NhyViK5pv/uK+R6YZ1GCT?=
 =?us-ascii?Q?2hv3eP4czzc9mn52gC6SMiCOSLSjB9itPw9eNBc3yqHzvC6Z3Q0ER1DC19Ej?=
 =?us-ascii?Q?xA69wCzD8CwHTmwLbGENV8m6pPj1rFV+J9yRvWKA/nUWXh6jJvUaPfwaBlqo?=
 =?us-ascii?Q?GRVM74Gaf8yHbn33VMuxb8SBwIlwOPOKt1t8eTZ3dTIxq+ukXu5bN/iIO4kg?=
 =?us-ascii?Q?6LTJgOPVomrXY8Yghpde+A7pke7DZTkm/87MkZV2y1nDUramSsqQcp8vGHwf?=
 =?us-ascii?Q?wXtm4ZdWYuzGMsx76c7bSbxr5DODDf+1PFuXf7t1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fdad13-a54c-4ac7-ebf2-08dca569ea87
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 07:35:50.4500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0b3fc178-b730-4e8b-9843-e81259237b77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 63oZYU3k+GhdBlMszThyRxVPboOaMIgw5t2MVs1ZLxhxKDPuzIIHcwAAuN4l7Kk2LR2BMPQmDmfGI6FGjaQ7ylwjflwOm5CZd4WEZgbGgSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR06MB9255

>tipc_udp_addr2str() should return non-zero value if the UDP media address =
is invalid. Otherwise, a buffer overflow access can occur in
>tipc_media_addr_printf(). Fix this by returning 1 on an invalid UDP media =
address.
>
>Fixes: d0f91938bede ("tipc: add ip/udp media type")
>Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
>---
> net/tipc/udp_media.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c index b849a3d133a=
0..439f75539977 100644
>--- a/net/tipc/udp_media.c
>+++ b/net/tipc/udp_media.c
>@@ -135,8 +135,11 @@ static int tipc_udp_addr2str(struct tipc_media_addr *=
a, char *buf, int size)
>                snprintf(buf, size, "%pI4:%u", &ua->ipv4, ntohs(ua->port))=
;
>        else if (ntohs(ua->proto) =3D=3D ETH_P_IPV6)
>                snprintf(buf, size, "%pI6:%u", &ua->ipv6, ntohs(ua->port))=
;
>-       else
>+       else {
>                pr_err("Invalid UDP media address\n");
>+               return 1;
Please use -EINVAL instead.
>+       }
>+
>        return 0;
> }
>
>--
>2.45.2
>


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

