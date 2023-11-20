Return-Path: <netdev+bounces-49386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F1E7F1DE6
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 21:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F03D28140D
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 20:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A6D358A5;
	Mon, 20 Nov 2023 20:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b="dO+sxLR4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2097.outbound.protection.outlook.com [40.107.243.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C5DC7
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 12:17:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJVyXOiVN2yw626k/2gIawjN2XnPPnu9cQVqXOZ/KP3Hj3OumCcHafzo7vyPLGgH0RXUEadAOizIJL/0aHqUZ5rq5my4fxlbXhGII1Fybk+Z116wf/SnBfNQIEOg5B7OFXqd3iNkPPnini5Vx5iZlxaP5ITYhmUg8lVieoYDL0ovHogDEr5fILulXAgPFBR7pa6MI21Sj5uD3ImQCH5qESQClG9fgSOwZAlP2EPn9Anczon/ZCT3ri9dL31+vAP++lCHSMSmGCpiXANOjwKhWp033ztV5EZJRGgokSqrD/uKT8o8j3BdgmQM2v3z0zeZHx6ldDiTIMLm20ylE5ELSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liJ7fAgq+fb2l83zFWsvwVTgXP0fpUo/Vpg2/jOYRl4=;
 b=dBF6h+8cb0/CCUWiVM+Wl9uXxxnZxQaeUXBCzhHvwo9RwmeN7Kgb2jqvYnDJoRo7LiiZCAUQH2hWam5LKSS6OEFXLX6T0L5TS8BpQXI6bu21Xgxvlq0xiThcKNOuxxYeodb36QyzOrXw7xLn3dMkFlDapysp+8lzmil4e3bTjEQQO1reD7b2jZ8l9P3NrGdda0t4NV0GzNqJP+W8zHth51T6nV3AHxsKS9FmAM3A1FArgwSI/pmkiF1eFrkqdmr7CsRy3Kc3O5sJUpAZ0eMVxHsibsYr6KdxT2+tZ65DWvZRsCzwg0hAIKcrY2/BhYv9hCtTeRZ38setP60jOycqMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labn.net; dmarc=pass action=none header.from=labn.net;
 dkim=pass header.d=labn.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=labn.onmicrosoft.com;
 s=selector2-labn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liJ7fAgq+fb2l83zFWsvwVTgXP0fpUo/Vpg2/jOYRl4=;
 b=dO+sxLR4bAhqllVjKmCtMWLAJKJ/KqVHMYbOthdmEC3jy6zvpaoHwMjLmaHMHOSESebIawLFD8kR7wtC+wr4tqUEXWSzahjx86R+Id6a6T+ZT4zQT8rW2e2JuQ9xKq19HG7wJ/4qJlnAXB1/C9NC5+KAhL+1sE+3rojANPLv5hI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labn.net;
Received: from CH2PR14MB4152.namprd14.prod.outlook.com (2603:10b6:610:a9::10)
 by CY8PR14MB6123.namprd14.prod.outlook.com (2603:10b6:930:54::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 20:17:35 +0000
Received: from CH2PR14MB4152.namprd14.prod.outlook.com
 ([fe80::72bc:7cd2:adb5:be40]) by CH2PR14MB4152.namprd14.prod.outlook.com
 ([fe80::72bc:7cd2:adb5:be40%7]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 20:17:35 +0000
References: <20231113035219.920136-1-chopps@chopps.org>
 <ZVHNI7NaK/KtABIL@gauss3.secunet.de>
 <CAJeAr6t_k32cqnzxqeuF8Kca6Q4w1FrDbKYABptKGz+HYAkyCw@mail.gmail.com>
 <m21qck1cxz.fsf@ja.int.chopps.org> <ZVu668MJ2iEr4fRG@Antony2201.local>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@labn.net>
To: Antony Antony <antony@phenome.org>
Cc: Christian Hopps <chopps@labn.net>, Andrew Cagney
 <andrew.cagney@gmail.com>, devel@linux-ipsec.org, netdev@vger.kernel.org,
 Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [DKIM] Re: [devel-ipsec] [RFC ipsec-next v2 0/8] Add IP-TFS
 mode to xfrm
Date: Mon, 20 Nov 2023 15:14:15 -0500
In-reply-to: <ZVu668MJ2iEr4fRG@Antony2201.local>
Message-ID: <m2wmucyyap.fsf@ja.int.chopps.org>
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: CH2PR11CA0019.namprd11.prod.outlook.com
 (2603:10b6:610:54::29) To CH2PR14MB4152.namprd14.prod.outlook.com
 (2603:10b6:610:a9::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR14MB4152:EE_|CY8PR14MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: 887db901-d1cd-4f6e-8d77-08dbea05bbfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x8lnEAEn6eeI1X+tH+1oqsQik2j2mHsXlcOTrac0V0jRFenq5SJQxhyLiHK8bS9Q6AQAssESM9BTWYHyvFzHmixqZeyeXi3qnGEgQXX92DoDas3TNlyB26eqNYvnkkjB9PnPyPl3CI5sbD5LmnNqNg9BD+GPLYb3Gu3a/suOUkXOkQBZwJMOif+0cZssspWBUCCdJRCXn3wEhgwXFpUBl2tmT5BfK7iLg7M/DhtK/03WweCJwyXhoyVe1nfbznsyfkHGI5yarVJRUfwYW2WSdvFACUOnf1r/9jTlj2CTP+nklTDLZtEl7FIN5Sycj+CcOeAA5pmv14c7H6d7KE3XAGwcbIvbA6fHNpBcoapOxC57HGNs4M6b7+RryyC7wAemzM/aboYa6G8OF/YOWL5xlbvPR175lNmtHbffpxiWPDwdIsxF7Zjh4QZvj1Rw3jt7k9KMgpdDV6YS8lcCtQ027pCzxo0G7E+gdt2f+cpo1bduHf9lGpgVv07qz+ZnIROyvOfsjBH6y2J/0mzQkPMhl8PAfOC/rLLLFlIyohn1KDXlWIyCWjJRQwNuc5o1YfbIE1ZvP+wJ/AuCbFS/KkHnw15HtC9kWJ8p5sc1ulLug4Ud6mf4N5dO82zDy/dJJ4dq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR14MB4152.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39830400003)(366004)(136003)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2906002)(8936002)(4326008)(8676002)(5660300002)(38100700002)(86362001)(38350700005)(41300700001)(66899024)(9686003)(26005)(6512007)(6666004)(52116002)(6506007)(83380400001)(21480400003)(478600001)(66556008)(66946007)(66476007)(54906003)(6916009)(316002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DCYH+jlet6motOkyUrBda2RAP2UFI4v1wF2L4rg9H8gRGHV7u7VTTWCDd6r1?=
 =?us-ascii?Q?/DtBgfr4L0sHXNSVJjYjrPwW8ZC66rsmHey2fMb4jv54n0u/HfpRnhgBWKPQ?=
 =?us-ascii?Q?0PW+T0c9Zz27vHgtSRkEZs54pz53sFqndXQ/C4nq0XRuS8I85ntZevkXAzFM?=
 =?us-ascii?Q?h4eYs1AhWUNCdkggC0iMzwsMu9A7SFMw8Ycg2fHr6wLuA8mZ4wdwuGQ5U/F1?=
 =?us-ascii?Q?J0x5SWzLmBZEtWH8eohGDPkmASQnJJcYImpYdklADxHVROPknc2hcYkGvUhc?=
 =?us-ascii?Q?OHLzii89T3SJR70hTgWGfBaYABqG0Lip2bNURAg9ByCIZJ2g7pF0zDDyZlGm?=
 =?us-ascii?Q?RajyEw1ftAWGo3gx887YO/FgcBiTkgrZwD9fIcrNc0aC8g+84+nCfYK/G5D2?=
 =?us-ascii?Q?AcIw0JAHPY2x9VBwCMfuY9cQduSaIHx8sTGdIcwTsxpxrTnV/ksM0oT4HWja?=
 =?us-ascii?Q?YNYfWV3hp1kJPdtfvtezJxtv/bcjaRfhlNZeZk46Yy5KG8pxnIJE9PcxHR96?=
 =?us-ascii?Q?/cssIfBL8Oc5lB0q7CTIoFkNIaWxVLRWFDGpo/oAwrEmdhGRpWicabQRIMvH?=
 =?us-ascii?Q?b7ijFQeUid4D6jSB53sv7UdT61wJfTvC65vES/VFk+9tY/LmiP7Scb6ghnPK?=
 =?us-ascii?Q?orINQilztTWTm2CRiCTgJdqoyoQoqjALN61SE4Y9+dys/ilU1KrP1188Qm9+?=
 =?us-ascii?Q?+U5yRHtV1JSqyMa3+s72cyFwYDTydLCld8csyJUcW/OSKXJu56rKN5dsFxE9?=
 =?us-ascii?Q?LKgjLNarYcoObt+FxNlQM/euIl9hf8UZ7WOls2FDjDlLMrMAlXxQ2k1FU6Tm?=
 =?us-ascii?Q?QCIqhN25xMHkufplRSfsB8CN2zC0zN8WjHkYsz3C5GpHjaw/EDyt/qeJFpeH?=
 =?us-ascii?Q?AzF2Nqb7oWLzJDpyeSpWHWHuxtrfX+lDz5GruMYysvfd87bybmD9MV3Ks5JQ?=
 =?us-ascii?Q?7XZ74o998efMAmpDNe9tNatRMMr9u8gG/GGX5xHtwEIAb3iZ0oTvfnYkb0tT?=
 =?us-ascii?Q?vngV3VR3xtgUuHqnTa5674tcGYpWvG2LR43qsbWjXwhdVH3yy0QZmk9dnywA?=
 =?us-ascii?Q?hMJZR5FoH2xaOcrae8O723IV2zU83TOWk7rS2SaK/9cJhjSxQab+WYUwzm2V?=
 =?us-ascii?Q?45yoS50bgqHXpfMmgMvyz9NIE4xkSlrXU2BQjtELx9hJ7EhleJpCX5ijToja?=
 =?us-ascii?Q?XGra/90tXdYbIME5EEd3aezwlawNR1fdqE1q6vzafDI2IYoqsKyUUm0EZ3/A?=
 =?us-ascii?Q?lc6+3Lv6vSs1J16/hMnfaDzxgKqIffD5dDHGREoTumusxDliS3ON6fv/wZHy?=
 =?us-ascii?Q?r6qgQm+HwWsd4BpFU7Wm1Az51GjyLspVDBa3ZWpaLmHjBH0UN6dRfbJMST2c?=
 =?us-ascii?Q?QFagP9R+fs4O1yAu7DcBHcXXKxundy9Oz5NvT4g8JrYiWGhz7eRFvb3FngQE?=
 =?us-ascii?Q?85lCE7BJWrd7kgRC4UC5G6PKNLOxLFkL1DBoIE7GWrAfszGlw58hsYh/pojp?=
 =?us-ascii?Q?j0/yklIQpkrYjTPlQ0teJH4biWiW2tJAjQe/5Q6V+DsgTHMJKRhl/pUYsLZu?=
 =?us-ascii?Q?iPZE9LgFs9xyAPO6kzAuYGbSOkJxZE6uvVmuPJU1?=
X-OriginatorOrg: labn.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 887db901-d1cd-4f6e-8d77-08dbea05bbfb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR14MB4152.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 20:17:35.4245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eb60ac54-2184-4344-9b60-40c8b2b72561
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TWvp0p+M5Z7vaLZzBQHJ3+hWFGPedGlfXNqV6T4e9qjGmRF5vQien0/ncZuA9eU1hYgyAWs37Q2+OvA1HEjTGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR14MB6123

--=-=-=
Content-Type: text/plain; format=flowed


Antony Antony <antony@phenome.org> writes:

> On Mon, Nov 20, 2023 at 01:39:50PM -0500, Christian Hopps via Devel wrote:
>>
>> Andrew Cagney <andrew.cagney@gmail.com> writes:
>>
>> > > I did a multiple days peer review with Chris on this pachset. So my
>> > > concerns are already addressed.
>> > >
>> > > Further reviews are welcome! This is a bigger change and it would
>> > > be nice if more people could look at it.
>> >
>> > I have a usability question.  What name should appear when a user
>> > interacts with and sees log messages from this feature?
>> >     ip-tfs, IP-TFS, IP_TFS
>> > or:
>> >    iptfs, IPTFS, ...
>>
>> I think no `-` or `_` in the code/api. For documentation it is probably better to hew closer to the RFC and use `IP-TFS`.
>
> That sounds good. However,
> iproute2 output, ip xfrm state, or "ip xfrm policy" is that documentation or code?
>
> current unsubmitted patch shows: "iptfs"

That's code/api. I was thinking ui/api when I said api.

Documentation would be something ending in a .rst or within a comment as that might be referring to the RFC too.

I will go through and make sure things are consistent in the next version.

Thanks,
Chris.

>
> src 192.1.2.23 dst 192.1.2.45
> 	proto esp spi 0x76ee6b87(1995336583) reqid 16389(0x00004005) mode iptfs
>
> root@west:/testing/pluto/ikev2-74-iptfs-01 (iptfs-aa-20231120)# ip  x p
> src 192.0.1.0/24 dst 192.0.2.0/24
> 	dir out priority 1757393 ptype main
> 	tmpl src 192.1.2.45 dst 192.1.2.23
> 		proto esp reqid 16389 mode iptfs
>
> -antony


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJEBAEBCgAuFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmVbvt4QHGNob3Bwc0Bs
YWJuLm5ldAAKCRAuHYMO17gwJbDwD/9GYG9opBpfL7hkOV3puin6AZ9QzTgyp8Pr
hAniqV4lTH4nmRAZh5qFLcVaiOmNr3WUOP7qwASKSkjB/pzN2NYsKVwfe0/UnKMl
FfcLCXbi+JtBgbRDEPEP2R3mVFGufwdcNYcQlg2qWWWeNCQ3ih0FIdwM6ls7a/Qs
Ql2HpCcEEp6kwRXF+NhUirSlurXRmwPelFBeK0DvYh2WVCmhYBeoLbJ1Vv2rz2Wx
ZF9paziQRjRsI1sCVOywv3G5D2FWOGNz1JsM+Ju7iDcO6qH38DB4ByoJfwqy5lrQ
M0q2r/UOMRfeB/cEjRUbgOWcSSaeObWwG/WrbDiycDzOfd+51+JXZiNwSj+qNU0b
IO/PFLIG2x7ZN0zQZaSchAYWqglp9cj0AT5NBL294UQDNXUpAHFHZIeCdqN9bxE9
iEukaEWOqiai2fDuAUGjBNPGpgXkqbRAanfWZWNxBQxyMO2Pjd5d3nENdJl3ebAr
XMLEd3cKJ8rsCmCoRTZxairUjc4uFHxotyU3QswiEtgbpWjJxoYk6XyE6PnSKfVN
W4xcVBhJBdlaaRsqcA/4rkYf6Q3/j1pwMg9s9GpyQspUy5+PTSWZIYD7bScDqUF/
ZcaxmQYPRwYNT7yvW49+/xU5XjjaVUWueD1K8JhLomAT7P2ssJjTmqOFSMxQhEmv
RnMzCJdnAw==
=8Hgx
-----END PGP SIGNATURE-----

--=-=-=--

