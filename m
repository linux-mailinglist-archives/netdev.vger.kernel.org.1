Return-Path: <netdev+bounces-189119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33797AB07AC
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 03:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E585E3BA709
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 01:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEE321D3F4;
	Fri,  9 May 2025 01:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uKC3jb2J"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A1121CA17;
	Fri,  9 May 2025 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746755817; cv=fail; b=BRkSC6ZoRul/X8Z3Rjx04qs9JIoCYNrDPONuiCfZtbS0Y751moXEG/sAAEZJSIOkZFIgM0wb5RPOIaZnGAzZpTiQwLH+mBLjyQ8DNrrwRxlM/spMrbrhhajNO/rfcAXnML4b0cIH54WUy8KldGswqbYptbWOWjxi3xWv7n+TINk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746755817; c=relaxed/simple;
	bh=XUvQVmDh8Sf4eSewbs8CTP+v0P6069iwKCjqBRDruAQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o4oxt5KzbkW0Ws++55bJp/4RF+jbEhOQDntZfvglWfpT+kROQttPl5Wyx+GUfes49xhjAp4btMn9UAwWGoZQGbc5gM/q3DLcvYRGRmh9UmVHVIaJWxjnJQMUOcZhZHeJcZjH90mPKpciMuZQMrtktTLlFhksnqa5MazeHmwWrvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uKC3jb2J; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IA7UF3RImryNa3bXa/LJ5ONYcq3QoAqxggyDIDwCZNmKApwj7V20Ad/ZeRbe5pVCHGxVxRd8cvv8OA1pbBbX0SEl+l9JxSEs/Opg06j+QPweLCheDYzzemOu2HB45Jq15qJHxaE8nx6wbz1qsjdZVBGBPeZHrEYwqP921UPFeRDX91Q0MWUuJE7AKvx861ndmwN8jmmadZmRrNgQ1Td1nghZv4mGIaIxmhIXrMUzoENyS/Kq9JCRdY+VrwGT4zH6V7jjiJtxpj2IdcnaBzwK/ZlVoj6PL1J+w66XMWbHmjvKwIPElVbgW4/HVNFSMTqMFiVxQyWJtCJbrvujSvu4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pg4IpDyFoBtPWzlByMEntcnLVXrRPNS/2I0BXNnFk5I=;
 b=VtHjcpGDQrDx8Lx18oRoKcijuiL/KNJslUadOKA3FRBT3oMC7RIrimwdN7WF9eLmLUsJGl77u/F90gArbEGQf2HpLjiYsttyxKU0sIMXvU9r/NM88JCkct9bcDqPTEGyWpgg3yq9Z7raKjYqABVdi7riAnr5ZGfG4snyjDMs5PA2dA+u1v+OsGasnTAv/DpVkSPFoXkbaKQ9Kfh6XShY4+T0ltQcVZnF38oyub8orzcAY49HvWmkDSzrm/tRKj4SZVtC/ciA79A79AlMHUqJucNVchPU3nWBLdoST7xhde8dguv0Y8fWhcIZxUUDReWi/4nLGEV0np7Ygzs6tcW6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pg4IpDyFoBtPWzlByMEntcnLVXrRPNS/2I0BXNnFk5I=;
 b=uKC3jb2J35PcuOfKyAeMreIwYTXR41CtOEiBZUqXcpoFCDfdMEK+5iARyYHhdtba02roG05+YlTeOSX1kn9VuhP401OVOfKnNsX0qLHYO6fpjb/WcEvAx+Tz03Vla+SsMA1E2MFVieeOiTcBFeibtD3NFDJkM3mmS2t29J9icWLSgGd2XwTq+M8V/g6QaIDZ+nD+i6FiWpnpQjFevzjO/2L8DoDPZy5DDJF6Kyf4niy1fA3lsjXIAe4jSCR1r/Mb7Xlf2JQJxIEabLfPM/Nyyen46IhkgwvqOeCZWwapXXQREsFxtIX2+pAvyIyzi8HTTdlwRyDI1UcdHB3my8h68g==
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by LV3PR11MB8741.namprd11.prod.outlook.com (2603:10b6:408:21d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Fri, 9 May
 2025 01:56:47 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739%7]) with mapi id 15.20.8699.022; Fri, 9 May 2025
 01:56:47 +0000
From: <Ronnie.Kunin@microchip.com>
To: <kuba@kernel.org>, <Thangaraj.S@microchip.com>
CC: <Bryan.Whitehead@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <andrew@lunn.ch>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v1 net-next] net: lan743x: configure interrupt moderation
 timers based on speed
Thread-Topic: [PATCH v1 net-next] net: lan743x: configure interrupt moderation
 timers based on speed
Thread-Index: AQHbvjuxaKkyg3pfLE2qFbKkImSEr7PFgyeAgADVnICAAb97gIAArK2AgAAVG8A=
Date: Fri, 9 May 2025 01:56:47 +0000
Message-ID:
 <PH8PR11MB796577DE9F07CFE627B1DE4C958BA@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20250505072943.123943-1-thangaraj.s@microchip.com>
	<e2d7079b-f2d3-443d-a0e5-cb4f7a85b1e6@lunn.ch>
	<42768d74fc73cd3409f9cdd5c5c872747c2d7216.camel@microchip.com>
	<e489b483-26bb-4e63-aa6d-39315818b455@lunn.ch>
	<20250506175441.695f97fd@kernel.org>
	<32159cd4a320a492fd47b6c38cebdb9a994c8bf5.camel@microchip.com>
 <20250508065419.2a089eba@kernel.org>
In-Reply-To: <20250508065419.2a089eba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|LV3PR11MB8741:EE_
x-ms-office365-filtering-correlation-id: bdef7e82-23b6-4432-2090-08dd8e9cc1ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?oCBYbE9Km+WPRAdwNtwSqZl574yqWbUQM42Ap773rFYcjJOfwWAWGPFuU4?=
 =?iso-8859-1?Q?NY6jaL2arbk9lTRr/cyxXd+S2e3KSImnrbGC1V2zuL173OpEFp5SXiZVPK?=
 =?iso-8859-1?Q?Mz08cUg21Qlx5Hg+Fpuqy30z4nTLsvLTNC28LzkmfbeHcMj79SM+efptPd?=
 =?iso-8859-1?Q?4jCkLzJIW7Pw7BUyssU5djUMWdW8rd+vNNlc4/54IdN5xC6cjNilGlcXaT?=
 =?iso-8859-1?Q?nPcjbTTcQjRCmm4j5POn/ZAXoxWe/UXL1fivQcQ+lL5yHto2cI2Y2WUgI9?=
 =?iso-8859-1?Q?83cA1b8YSjWy7ZuN/D4qhDYJafYZtWpYE6enpPQYSK3qbkc3SFEI2wKDuI?=
 =?iso-8859-1?Q?UtIS4Wj9xmjg8jSh/L9jdSm4ph3kR/ESlMiJNhJSri4BqZvMbQtODQb0K5?=
 =?iso-8859-1?Q?VUY5/30pNlPsQAHp/TN+zzQIT2wX1PZTbv1yEbfll1+QzC2lnlNxpdroiV?=
 =?iso-8859-1?Q?LfVmndZuvMLYLCcwXOeidu9LZrbSB84JfrHtYjbGsvqe2cXggxCbr4FzP6?=
 =?iso-8859-1?Q?ZgDNJornaHRqThgwCp+tih+0GMPw0uRqsTuyLO5EY8VC9Qt06KvzZMKXyK?=
 =?iso-8859-1?Q?j6m0zilhI4lXv23OMgcOCwFo1yOH+VO/367lToyCqbhWgZWUPz/iNWud8O?=
 =?iso-8859-1?Q?CsLFsru+45kdvWHsbmb1v6fe6q7uGgE/ae2X+078Irpj4XnGe0SY7VuQJ6?=
 =?iso-8859-1?Q?EkYs7YlX8Kq0qsL6enqAs/hSdNzRz7vYMdTIc1emvnx7JEjQ6fK0h82/Tq?=
 =?iso-8859-1?Q?TTTkTPhg3RNQJq0xqKRodkGnrja8pj+RByIYt7aPlDcgbljsSPIA0GkWk6?=
 =?iso-8859-1?Q?9URRXTj081ZwGv4xPjjN2/pmfm/XjZ7S1PcJT7jwRIzghL692hbS6dYfOv?=
 =?iso-8859-1?Q?RhzGAvxAYZ9YRUiG0Wu4AQFdYCUNVhW4bQeRgtY5ihkHvPXNgnf3RI8iBS?=
 =?iso-8859-1?Q?cifHm9NcAU2hzbjhP9zdo6ES8fu07jxt1cF/rG9bWKqRiGLKEWzcpAJ3ue?=
 =?iso-8859-1?Q?pAbCpCz11ySsBWwlFyjjo4deRYTuQbr+8PnJ2ZnKyBUH+sTkeqlR0Y/9bR?=
 =?iso-8859-1?Q?DEpRDY4JdJnNqx5K+tLE+Obufq4NeDxqnFITkqFQqf6Ue49jNpYECLjmYJ?=
 =?iso-8859-1?Q?WmbZBK+ZnSOLLIaLEnKFA1xMyBuCfNx3jE2fhWTGNeJG14rKFvUEId4OW9?=
 =?iso-8859-1?Q?hQnFmzOrAedzOK4jQs10k/HlT2U+kfr4YAwWuZVt4Llr0CdpQzSh1sf02Y?=
 =?iso-8859-1?Q?1FguY1gw9ZoUBprtnUYEDKypmqOKJLlk5cGLbFrJtXc8z8HZcPRZEdLxQ/?=
 =?iso-8859-1?Q?ZLkyvWdsYt4xLaeUZ0/+dKaxuu9+XDVqaYKqqIT/tU7FT3a+x5hCFnJxUa?=
 =?iso-8859-1?Q?owexbvHlSuV6m/4VfPJaNEw0z8F5LsVSJhiU7WcsRjZmPH7vKUuagcY1nW?=
 =?iso-8859-1?Q?+XcsSzMw0fyhlH6SyV49/EnMVSecRGLdtE6YQX8aiXT7tBl0c7d06FTqT/?=
 =?iso-8859-1?Q?92Feq0+BItD1ePSzeySjwc60MDUXfnBVx7UPIfmsCuDQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?elQHzUz9aMnZ88z6KsdSFQJGmhxbXSXpGTKyCmL22vrd8rczYwYHsbUcKJ?=
 =?iso-8859-1?Q?4YtdZgM8q175JAjYqpmervIJ9L13DbVOC+ygWhIYwmzVoMYfkg61HN9QVp?=
 =?iso-8859-1?Q?NUzUfn4MS+weLfEwnuYq+fkP6ep5+TZq5WHKKQ1Quqmgmhr121S5Ht/+0c?=
 =?iso-8859-1?Q?mTHab2kZWL8gwPnQc/GD3BSUu7dIgXoPgjD1lfr/2iv/0ILVzYaiX2+e0e?=
 =?iso-8859-1?Q?D6i/2/QegxxP0Uxue4TXi9kFH/nyqVR+tABmnDU1mZ6xmXq8mnNsY0N7jo?=
 =?iso-8859-1?Q?2VxCf1BU8JVT6ZhkXNSQQGWe7G/QbDb+nIOFb0yOEx7KQYgzik9M0CATqu?=
 =?iso-8859-1?Q?D7uqHVtAH7SAGRJwpnInM4r53tvXnpWvz6/gBWtXDmwdAg2A1MioOnII4E?=
 =?iso-8859-1?Q?lW9Yth5j9lpJwFz0YRYriHpbMljZVUKdEjRcJavjzsdTGYvEZNLGXUKjmH?=
 =?iso-8859-1?Q?C0GovOHrOS0IvkaJnBYozJyN9Cw/QxCYwxpGjlaB2slMCPJfEGulhMIHIr?=
 =?iso-8859-1?Q?ZvujTb8PG1Hab2vYtXrSnFCz2BmWZbLSOMcbRbEBKxqkRt++Q9iSAm0R+P?=
 =?iso-8859-1?Q?tmSclRZWedX0/XLsvOULL6VAOm8wvFjEcwClXln5oE4mHV6wo8LFn3OV9L?=
 =?iso-8859-1?Q?ADrzRQoodK5ifm/uGRCazijYLeI8O1gRndxFI4QwI8Z/VUS8/Gy4FAEySm?=
 =?iso-8859-1?Q?vcjvqm1ilwn+TC6JHs08BdJRvr1kI3Kp45UD389rD8uJqN5z1hnlw1hXQ6?=
 =?iso-8859-1?Q?Zplgv3Mjd367qCJljha99hAcfspmAURd4VETXgBrCcofEs9e6kd/wm9eQ/?=
 =?iso-8859-1?Q?g6z7y+0dwdefyv7CIyh4ucJa1NMTjb4qOHwnGxljDIlzl+LAO79P/wjg88?=
 =?iso-8859-1?Q?NB3KcEc7drxUBUstG2jWPJ2hEkdCZ52dAY0lI72LqEb4R0bFc/vECXffpc?=
 =?iso-8859-1?Q?nnRLbtj5+h1HRM0Ssj3cOgHZbuOT2ZjVTVvYuKf1/KFxBy/Dn02LkZHoJ3?=
 =?iso-8859-1?Q?A5AwKvCiNmSuOsFc4Ql1wH/ZJpxRtIeyLbSRbSzEe1N0MH+tP+vU3ZiDx0?=
 =?iso-8859-1?Q?ZRxnVrbIpOnnh6X9W4YL9LAsNDEjFhGYuVWuM7UidQ/ZnyK5M4d5MjtvjX?=
 =?iso-8859-1?Q?fkH+qFjFucUbRCQ1k6l5rHMTSBQ9b84Uzuwvz32zyOI7jW1nEn+BeEbitq?=
 =?iso-8859-1?Q?RZOSjZORGd4PO5FizWPf29zM2gsEbhVKpNXmZYCORfj2kJNs+iy9E/dED9?=
 =?iso-8859-1?Q?/U8JNV4nQNHa8MOvY+oGU25SuMNLWvsdzpyvQoIrfRMNhsT87dp7t/N1AQ?=
 =?iso-8859-1?Q?2HGiQR9wvK496HLpUoAlQQMA10gIYsY2tbWiX6WH7/ZPuchI19qkoYR8q/?=
 =?iso-8859-1?Q?tHWmW3G6OfZoJzUCIA+X0UoQSWUOknk+03dQBFkm/vdHB+Fld1vzdPK0WF?=
 =?iso-8859-1?Q?DOG2v221rJ0/N/8Nlf+XNHKIUfLbK4Qn7RLmcJsJAoZQZu5HhdiogedhBL?=
 =?iso-8859-1?Q?Fa/ZYIofPUgt5/0rJefjrm8vGj35we+crhV19cRshP1Ox4jztcAOaQM9rL?=
 =?iso-8859-1?Q?3FML5TNSnZMIxzhZtqqM9SMM+SEvJK4OIWQ2fwerxxoK2WIuQgO7L3ZuRi?=
 =?iso-8859-1?Q?vilrS7zYcHkEKb8un64+QhR2e85K0ZAfeu?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdef7e82-23b6-4432-2090-08dd8e9cc1ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 01:56:47.3672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yDUViDM+kHavd+SCYsQidruTei03yEbgMPZkPofCK8G5x1OAcUMG1kKgnhV4xRnxxfrfKLo/n8vRZ/tbGvO7kJxdVzq4q9FIOtyHfpMUjg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8741

> On Thu, 8 May 2025 03:36:17 +0000 Thangaraj.S@microchip.com wrote:=0A=
> > I agree with your comments and will implement the ethtool option to=0A=
> > provide flexibility, while keeping the default behavior as defined in=
=0A=
> > this patch based on speed.=0A=
> =0A=
> Why the speed based defaults? Do other vendors do that?=0A=
> 330usec is a very high latency, and if the link is running at 10M we prob=
ably don't need IRQ moderation=0A=
> at all?=0A=
> =0A=
> For Tx deferring the completion based on link speed makes sense.=0A=
> We want an IRQ for a fixed amount of data, doesn't matter how fast its go=
ing out. =0A=
IRQ for a fixed amount of data is not (at least not directly, may indirectl=
y) be any of our criteria. From the use case perspective, I do enumerate ou=
r requirements later in this mail. From the functional perspective of the d=
evice, we need to free up DMA descriptors at least fast enough after the DM=
A operation completed that we do not delay initiating new DMA Tx operations=
 due to lack descriptors since this could end up causing undesired transmis=
sion gaps on the wire.=0A=
=0A=
> But for Rx the more aggressive the moderation the higher the latency. In =
my experience the Rx moderation should not=0A=
> depend on link speed.=0A=
=0A=
In my experience you cannot make such an absolute statements. It really dep=
ends on the use case and what is most important to prioritize for that use =
case. Use cases will drive requirements, and different requirements can hav=
e conflicting moderation values. Different products or even use cases withi=
n the same product may therefore end up having to use different moderation =
values. So how do you pick what the default behavior should be? =0A=
What our customers (aggregate requirements) have told us FOR THIS PRODUCT i=
s that the order of priority (1 being the highest) is:=0A=
1. Line rate throughput (or as closest as possible to it) using iPerf3 TCP =
test with defaults as a benchmark=0A=
2. Lowest possible CPU utilization (but not in detriment of throughput) =0A=
3. Lowest possible power consumption (but not to detriment of throughput or=
 CPU util)=0A=
4. Lowest possible latency (but not to detriment of any of the above)=0A=
Therefore this is what we use to guide our moderation criteria. =0A=
=0A=
When this Linux driver was initially submitted, #1 throughput referred to u=
nidirectional line rate, and the value of 400us still currently used for mo=
deration was achieving those requirements for our 1G LAN743x devices. Even =
if the latency might seem high, since it has not been changed at all since =
its introduction in 2018 it is clear that has not been a concern for anybod=
y using this device with this driver. During the last year or two the #1 re=
quirement has become more stringent as our customers need to achieve concur=
rent bidirectional line rate throughput with either iPerf3 TCP or UDP defau=
lts, while still maintaining 2-4 as secondary goals. We also released new d=
evices (PCI11x1x) serviced by this driver that support 2.5G. 400us is not s=
uitable for these higher/bidir data rates. Even if we reduced the moderatio=
n value to meet the new highest throughput demands, using a fixed value doe=
s not let you achieve these goals for all speeds (i.e. if we set a fixed lo=
w moderation value for the highest possible throughput of 2.5G, our CPU uti=
lization is blown up for lower speeds). This is what lead to our decision t=
o now adjust moderation based on current link speed, and we came up with th=
ose values by empirically tunning them. Eventually, rather than only use th=
e current link speed, we will likely continue to evolve to an approach wher=
e we will measure throughput periodically and adjust moderation dynamically=
 to the measured throughput value, which will be much better. The latter wi=
ll take some time to be designed properly (or may even require some hardwar=
e mods to implement it best), so this is an initial low-cost step in the ri=
ght direction that satisfies our current product requirements. We understan=
d that there may be a smaller portion of the users of this device whose use=
 cases might drive different order of priorities and would therefore need a=
 different moderation value (that might include those that see a regression=
 after the change because 400us is no longer used). That's where your/Andre=
w's recommendation to implement ethtool -C (thanks!) becomes very useful, a=
llowing those users to set whatever static value they want (speed adaptive =
mode will be turned off when they do).  But going back to the beginning, fo=
r the default configuration, we do need the moderation to be link speed ada=
ptive. This is what we have already been using very successfully for some t=
ime in our drivers for this device for other OSs and is what satisfies the =
requirements of the lion share of our customers.=0A=
=0A=
=0A=
=0A=
=0A=

