Return-Path: <netdev+bounces-111830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AC293354F
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 04:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347641F232B0
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 02:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8DD1C36;
	Wed, 17 Jul 2024 02:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endava.com header.i=@endava.com header.b="HXbn3+bh"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2138.outbound.protection.outlook.com [40.107.241.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F484ED8;
	Wed, 17 Jul 2024 02:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721182239; cv=fail; b=UmUYngmXfzARpCk10Jd+I58hvMH+R4+UlfCEtu6B4ik2el1588EOk6MHT4ykSyyRsOu290eBzHDT6p6l2ZYzQWypS6LC/IMDmpwLSfaUjrcPZJZL3kPoOtVlxGCSKFLuwZyNtfjLx2G1re298Pno8CEFKONKpghOtLX/vQ5SRUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721182239; c=relaxed/simple;
	bh=rRmDwF/zI+1ss47axvkHR07UJEB6bwNzihI6KZ/Shh0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nUCxI/DbbhJyli3t77ehgxo8cqU4Khc3IVH9nSWsi45FpVzD8AFK3/+IL/6+aSk98onJUBQyw57j6vNmI/37uZlQBNmh0atuYJ479xJUwXka+K/acLn5bCPJccAU5oVmp15pPyfkGlRSU2AHiDB5QVw7wUdEIQ13eJeV0i+q+Vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=endava.com; spf=pass smtp.mailfrom=endava.com; dkim=pass (2048-bit key) header.d=endava.com header.i=@endava.com header.b=HXbn3+bh; arc=fail smtp.client-ip=40.107.241.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=endava.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endava.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rg8xNkJEQNJa4SzCaQ9TkFCKQVONvUelEZ3zwW1wFSPETIn7JwjJycIuuoMe5f0L01ZdNajohIeS8XOfa9o6d5ikDPB0xVdLqsGjXXPj8EVd11d2xcPRHGWQuJnQqe86Icmlynzpu9aGhIhYXABdyJZCJWkj2wV3xCFsMUBI2Lx7zTUztwa98aaaBd3fmztxqtuOki7yXdaiS1Oq4uWP9LvbKsw1PTTSwufVO4f9S4neW9BThHEbGifneWQB1UbLaQXdnDFS3tIuWiUoQ27zQXEoXrTQtuDEDz1jbP99Vc/FBSjsrSq27zdH1VN8Dhj3sEsS9YtskvCTWvW2dWehcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRmDwF/zI+1ss47axvkHR07UJEB6bwNzihI6KZ/Shh0=;
 b=Oswr9pOTYcVP3xaylGEbR+Y8kkPrRtsSm4FNK9p0fLXn8pSCTmSmIL0nNkgBRbsuLPf3FwF7AkexY7yFhXxGSea9A5txcb5+ro14Qg+8nBLkTgdAzWo7ktRzdg7tIzljU2FvxcfIaGljPEuU7Dj4hYnx0WJy1rv0e1OAZEQGXKIbSf7TJiPRuHjTvj8q8j0oAky2gfknni23KniZfEM/kA42djDteo0iflWZjchE+Ggle8jRDgXIG8OVPfvZqW93GC7bbtFZbseP3G/bp5pFcl3F+WWf23HbBVXFil6YR7tltsitYPfOmalRYQqEjvE7qMejeczvJ28DV1sY2iFcDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=endava.com; dmarc=pass action=none header.from=endava.com;
 dkim=pass header.d=endava.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=endava.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRmDwF/zI+1ss47axvkHR07UJEB6bwNzihI6KZ/Shh0=;
 b=HXbn3+bhHtn2JMDjFnt0bJucNyvFDbhExIvTZahj2aBAA9P8CpKvd9d3Wxe7QmJ38TRhvGk31/dWsh01/ythB0r3Qxv0eiy6jPTRCF3XQBEsb0ygUsqdXjrlu7OEVEwK2HbxNZLmiaEX500sTmVMjJSoN6SelReEkOtmyfPTkxzja2LdLUNm3pLBcIUe3/DkZJtOtmilYSgNjbhF7cUHsf5PRFlmHki73JPMaSi83grC/9FZ8BJnZ+jrfvflW0QdvdnmrK8CAqTSmiSsPKkJnG00nml6lKRz8UzI5VJO0ERcLSoqhTaxoaIv7BH075wYzXV48mGT+7UhGx1IE7O3aA==
Received: from AS5PR06MB8752.eurprd06.prod.outlook.com (2603:10a6:20b:67d::20)
 by PR3PR06MB6636.eurprd06.prod.outlook.com (2603:10a6:102:69::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 02:10:33 +0000
Received: from AS5PR06MB8752.eurprd06.prod.outlook.com
 ([fe80::72f2:c654:1827:9c41]) by AS5PR06MB8752.eurprd06.prod.outlook.com
 ([fe80::72f2:c654:1827:9c41%3]) with mapi id 15.20.7784.013; Wed, 17 Jul 2024
 02:10:33 +0000
From: Tung Nguyen <tung.q.nguyen@endava.com>
To: Shigeru Yoshida <syoshida@redhat.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>
CC: "jmaloy@redhat.com" <jmaloy@redhat.com>, "ying.xue@windriver.com"
	<ying.xue@windriver.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] tipc: Return non-zero value from tipc_udp_addr2str()
 on error
Thread-Topic: [PATCH net] tipc: Return non-zero value from tipc_udp_addr2str()
 on error
Thread-Index:
 AQHa1yUvQPqLAGQ2A0GB9aoYG5W6f7H49WZwgAAEmICAAD0xAIAAA3+wgAAaDgCAAAO9YIAA1GKAgAABTLA=
Date: Wed, 17 Jul 2024 02:10:33 +0000
Message-ID:
 <AS5PR06MB8752F1B379BB6B90262C741CDBA32@AS5PR06MB8752.eurprd06.prod.outlook.com>
References:
 <AS5PR06MB875264DC53F4C10ACA87D227DBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
	<c87f411c-ad0e-4c14-b437-8191db438531@redhat.com>
	<AS5PR06MB8752EA2E98654061F6A24073DBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
 <20240717.110353.1959442391771656779.syoshida@redhat.com>
In-Reply-To: <20240717.110353.1959442391771656779.syoshida@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=endava.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR06MB8752:EE_|PR3PR06MB6636:EE_
x-ms-office365-filtering-correlation-id: 2f27d304-0c04-4cb2-a95e-08dca605a3f9
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?MlnpLcEFdvBsis2AJFto/tzi24aUSN+OpKyB1Xa8zn8V/8Vq89jhjbKJ+cPj?=
 =?us-ascii?Q?JyznvlRI1b14zWIlxdjjuYyv2ykFWgNTkNdbyCRWB0c7EbpskaVNmIWLFIno?=
 =?us-ascii?Q?YcDLSbj7WsMFwE4vqCA0iKJXgbHBHz+78Q20DSvMeuJya9dzwE8WX0yWUsFb?=
 =?us-ascii?Q?hYe9sFlUy8izE0MLko7K6ks2GhkSU+X3mE9VL/nv1zknQXWyC1Ve2KqkvJzE?=
 =?us-ascii?Q?teXsoYzFtUuNz4xdvz7GdiQO+KWjxmKGsShxY8z6VJUiQbXsBug279xkvs8N?=
 =?us-ascii?Q?PjVXxkVeTLXGSwL2p/uYgyczd6pYCksEwgeg7akD242GjjYt3AyOvbuW86xG?=
 =?us-ascii?Q?KDYGsHjqyAsT07D/qacDH+3gWyxg1h16kTAcE2P0hL7vMuvooQUIj0aZM3ql?=
 =?us-ascii?Q?WC/7orw84AZaixA9rTfo0DjybjlJlzvPSrKu4L0MqhUs0qk56qFhwn/iX+I2?=
 =?us-ascii?Q?ajA8lj+1sR88cnTYiKhkQg761lCjSWnk0V6cg7wMsnk/AELoSxHpAcGbUIbM?=
 =?us-ascii?Q?ANRE/TQPx9gHBAHuNREDgYoCIzOt38qwL2ZUhIU53W2EFri2gxNlsfPzv/xm?=
 =?us-ascii?Q?764Ynst6u5tuSbQkRLuDBi2O2H6V9RLMFkqz0diIKlyxs1aQmcMnWhHIZIP4?=
 =?us-ascii?Q?+/bXf74qumVUftvSh+TmMskETfJCiOxiilPWlFkWFaxOqeFPBfa5TdOzqo8d?=
 =?us-ascii?Q?wauaa2+SGOZf3ni6grUg1KtPpuGGrVvFyUEf/h33C9ztv0BlTEZAxiQ5G12J?=
 =?us-ascii?Q?+a5h0oSMMRJ/Wd+mw95rK8FTYHHtbvzQwb0gosV7TkXQFOZnAJy799QFcmz3?=
 =?us-ascii?Q?ynJkoyzN0MVil8QoVgybaWW1nVjKGReAk9salD41+H/dHeVoHL3IAiSW8v20?=
 =?us-ascii?Q?n981KMGHGzjqkyKEBc3hrjgl1V+Q5AoQw4LnSFXmPrXCkePZVnQ46B8Us5zN?=
 =?us-ascii?Q?yeNblv/EBT00GCwEHjy+XN+42ZZmIHot0IaqLDSE1yq+O3lcMUJrEpN8yM8P?=
 =?us-ascii?Q?ybgdc1Xn7vP1ziEzRHonRTUKf4yrJQYWuNW2K1a7N2rDyDdhOP54YK/7z+5M?=
 =?us-ascii?Q?vRZNvQDjOaqskM0wPN/30xpMWIvJ88zif8VZbL1/eK590U3pLni4TcOV4owT?=
 =?us-ascii?Q?UtZpTxNNV/jRhnMhrpKtC63b8FBfeTjv2RFaA/Yq2JgL1w6b0L7ZYwTUZzGo?=
 =?us-ascii?Q?TujPF4dtOazklXPLuwhztO9zvxY3cxAcG7iV3iNfoDxMY9+U5BFMp5sGxmtf?=
 =?us-ascii?Q?ZeUVFN/WiI5i6KofaBmTV59sX7pSIVNTtxMIlcwZ21oYJt1ON1/hZ+vnanYI?=
 =?us-ascii?Q?3+wN6JcwAMRyfSjHBnnDjbt6ZVkFudFkbB3WWusRMPRTod8vkJryqNaG4Iu7?=
 =?us-ascii?Q?qJ7QElL5MFZACVG+MPKnRWDcGvJqiPjTDCK1SrbILlvZsxpqDQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB8752.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2/ZojhXFgyBQeo0er7VRLHzFgX9s1idUq31cmHYBZxis1Eucs9S5zU9jHA99?=
 =?us-ascii?Q?K/l8776QObemy3gDzwl8HdjIAveXuVdpRB4MuxzS84fTpWaR52fBnmz0I5fK?=
 =?us-ascii?Q?xh/iinQKEQ0ruMYYfo7GDHcQIEYxVv1zNvILQ7Oi104YimUUHcY5bZY6oRoW?=
 =?us-ascii?Q?PzfUKKaPW871f34hx8A2+fpqdx5yRkBtKrQL8DQPmvPWie3MlZegHr+xp1PO?=
 =?us-ascii?Q?f0ft+8FPwRiebNjdgfbTaaUApm6P64l6t2hoyGNx2FIJ7VxJVMPjgG42OyJB?=
 =?us-ascii?Q?y+/gCuqQd+xLHyf/+wQVGw4d6SVPKJDfV2ah0co+Qj4ekmWWZRfGq6ReRNzL?=
 =?us-ascii?Q?DLnJdqusjJG+Au8c6oG73wPuHyY3L/7tKM8jva6HxhZYMgpWypu1LQRi9uDp?=
 =?us-ascii?Q?8Ge8fkoGTWhZwtUNNJwBQsKUCIV89Zw3AbpK+joDknwheC5nAaB8AiumRSvj?=
 =?us-ascii?Q?BVfNKSzXdHLJxjMZ136VnhWNOqRqFR47BjPZ1GaKoeKMnou/ymVwFhcLAofH?=
 =?us-ascii?Q?ZNPVoVt6B1sC2OSXWaYxVerlZlWHu2CXla3SsytXY1J5EmtMm319zXtPFx+e?=
 =?us-ascii?Q?Ex/zsVWM5BceeNNmifrCTYTqdAj105sUJ2Ln495CFw394bo7V9DHBfCtELtu?=
 =?us-ascii?Q?e7UbIVjrwH0J9U9ZEC7I6X3rotmU20AjzzESw8W6Nqbar+aMxYdV8m13CVSx?=
 =?us-ascii?Q?UNK8rKbl3T7dU4UGUDoxaTDeyeKavI5LSIctUsDp4+KYb1vH6XthNceGQCi5?=
 =?us-ascii?Q?Z8/BaFtx37AzIwjvE853FzUTP8Ny8E9HmPlZZi5AMy7vQoqnmGzwtvNHo3ZH?=
 =?us-ascii?Q?d7q1MJm/9Bt8iFeixz7jlQEyy6dYHMSjLQYnB+ZORvCPE2OLw5AsaSy6/BOT?=
 =?us-ascii?Q?N5fWZJ+3kT3Zm7C+QybN6qZ0MKh4H0NCuywXy65H0VKfHuJbp3HtY8jsR7z/?=
 =?us-ascii?Q?iCWiuTaBSMpDWwQJEC4u5qxUYgqzGPyJM15kZSx9D2+9PnsKcVi5Rklq1ugf?=
 =?us-ascii?Q?78Ff16pHZgbcTssKYKek1TAKHIQYOD5UW0qHYqnfBQiKPxzJhJAj2yyyypQY?=
 =?us-ascii?Q?wfo0+NpDm6KMEX2fqoSroetLAsYRe/On+n6NNwG6LxYXIm186nytOuXqA1vC?=
 =?us-ascii?Q?Jx8mIq3hfbkptPVyUKSpgYWDtEm9GZQ2e7wfsMtQ05ulKI8qiiZHviT446iY?=
 =?us-ascii?Q?2/Oi6NxgyDtHnsxREK6jCQxnanjn3V/RJP5uFuq62lP3j2P1VSZ5p9D92edS?=
 =?us-ascii?Q?LzUZhmE1dZBpK7U+1Z8MO8aqVIouKvPSTQkpK9KJ4PNuBqSeHKpgIZYTS934?=
 =?us-ascii?Q?kyLPkR2OeWZ9i6ZWL5KWtzpYMbYNynjpeSVGls+c3AKBdKl8J+OzubGdlFZO?=
 =?us-ascii?Q?TrYe0bktQusVvp4sIYr1yfg2jcTQriqWqyccSL88yFMZId8I4mf0UqgdTkey?=
 =?us-ascii?Q?u3OBwea18YYX1s4TvaSvIPvPpmPFY6tUV7dfQwLIVuzESCpMSYM7UvBRjG3Q?=
 =?us-ascii?Q?b3VvgBIKCJ1DlSXGUPoLatd5RMyu1+kvKR73dQJeA6pEwcT7eKEmCWkh7plt?=
 =?us-ascii?Q?D4HNaDcuhZLvwUA/ZnfIt/m16Wa9VlJwPRirZjoU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f27d304-0c04-4cb2-a95e-08dca605a3f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 02:10:33.5589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0b3fc178-b730-4e8b-9843-e81259237b77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oq5tWbZZ+y+EiRwFt+0uL5YbRXinp8A3l9NxSdV/e3fKsF46f7CnfQTnM2Ozave+v6uYTksjRV37aWPLA+vjkpXqbAhwOaGxkkHbHMLPNCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB6636

>How about merging this patch for bug fix and consistency, and then submitt=
ing a cleanup patch for returning -EINVAL on all addr2str()
>functions?
>
I agree with this proposal.

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

