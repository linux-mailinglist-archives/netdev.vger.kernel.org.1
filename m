Return-Path: <netdev+bounces-259936-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIGBFssNnGly/QMAu9opvQ
	(envelope-from <netdev+bounces-259936-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 09:20:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F47172FC9
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 09:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 712F23007E20
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 08:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F433348440;
	Mon, 23 Feb 2026 08:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uByV67d6"
X-Original-To: netdev@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010000.outbound.protection.outlook.com [52.103.73.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CC92BE03B;
	Mon, 23 Feb 2026 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771834807; cv=fail; b=G/4hFpTnGHkph52EX4ubH4IzcgkJ82ZubGOMgRh34zQigX94y+k8hdbKbP4DVAEuquwuxO+Tn8CtLiKbauaU8n3HkWho1l8oCPhh6w36Wxot4YcqI+iojF5TI5dirpPsc12jEZGvpKuUF95QGlYQYbVoIn+h4f254b6tsWkbeJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771834807; c=relaxed/simple;
	bh=F5E/fRlt5uKVynWIcLMrUhPRDFvJaUnf35v8XPoQTIQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SlUXgqO93vk9ICwabOQhlJY8ZkL9RKxkES/LAPOsVqCezggnXW9URQbzdOizKpEI0W4AjuECam6mDVL1XpGkzdTRMGXhzs8keBjJ5fKmJDdvu5ESeNw98IF+xAzb4DdMcFxKDjv5jFsDbBBXP8cqDIyV+bhREul+6AnBJhQEc5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uByV67d6; arc=fail smtp.client-ip=52.103.73.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hENWdQJc3xZZVI42UzfqB/sJz2Na+g+cYU+Rxsp6jitp7tmkB30Z+du55kYdvQX5kalL1NFhaBzwLMP75u8l7n0xs3DmYo8jcLb2tsZLAQ/OmeCUHZAtzGEnx3EYfNGMa9YiVx5bP6pnnXvdO8c5H9zJL6aTScimsVKKfGoeSW1mtxedOAfmU7zbMZS50qMdN1Kcy3RlVTYW0viW2fOZG5KWKJycIwpjXy6kdUu6c2PLUvA0PMlGhD78NQ51/c+KlMz1du1EjXXDa5Sfed611VpWHiD5CCfZUthCiSZkMtZCZJX+aByWPbzgNY6pzCJt36+xmU/L2gqt2aMSPTcmNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFBdknx/i46GhR7pNJc4IdwPfOmRJRbNMSFK6setJ/Y=;
 b=TjH+ecou0F95Tkt7CfzFEkzOcw+JkJ4L/MrBw4QR2HKzxM1NB6j8jysR0vVagc6cWgtdFh7N8uVAJs1WVDAhOfxzbyToU4aKQ8OEzOVHi4hG2G1MGLaGlH1ct7Xlk2uJEOrm+BVpNozI8YE6kpMF2kHIkglDtekfXdUAwXEeXNeCDWsIwyCvnf/IxQhfnVP6WoVAiR+J4cu8ICg1mo17Ov6TOMWVsn1AieIxtYwNrUe8dXlagHJHpoYphAE5XZn7lUGd/uPaJdPHWD054XhxFJXI5Kl6qmlSfJA3Q0B6iYWultskcjaFDSmTigbjAyhoQe1aBkjOkVBsr9S9Udlkxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFBdknx/i46GhR7pNJc4IdwPfOmRJRbNMSFK6setJ/Y=;
 b=uByV67d6fsE4lnA+fc3wXLa5I/8UAEt8jFqrOmtckP1CHHaioA7sFwxlHlKq3/Hn+W6FjrHRHj4NSldTNulEFltNKpGc0/YukI49CTcWz+1+Y9ojxUtBnGGCRnbLJ7rRutP8lkisxPqg2uIW6knZDeXSosyQ6zjuFQPgJgbxNyJo/y6/cidGHumYuxZGzhr8gQGx0sSkz5GL1wWr7d2sc77KFvQ8cW6N9UZfT3+gs5Dva2bjKFPwEWz6zzlM0RTG7VemzNCh7EiVYR5Yo0fE7PbFCIRVvSIQ026jnOTbgfNkT/XGSi7VMuU9jubIEy+3KeNlT+dydkFmmnVSdAxehQ==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SYBPR01MB7836.ausprd01.prod.outlook.com (2603:10c6:10:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 08:20:01 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 08:20:01 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Junrui Luo <moonafterrain@outlook.com>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Yuhao Jiang <danisjiang@gmail.com>
Subject: Re: [PATCH net] dpaa2-switch: validate num_ifs to prevent
 out-of-bounds write
Thread-Topic: [PATCH net] dpaa2-switch: validate num_ifs to prevent
 out-of-bounds write
Thread-Index: AQHcpJkqjUpnrKDqJ0SMPk6OlAycGQ==
Date: Mon, 23 Feb 2026 08:20:01 +0000
Message-ID:
 <SYBPR01MB7881DE7EB6C664763CAFE851AF77A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|SYBPR01MB7836:EE_
x-ms-office365-filtering-correlation-id: 6d401eaf-686a-4306-04d1-08de72b456fd
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwXZ5XHxNrJCjRnjimRBgM6S31bMiv4b12i5wt+OnSTG2oJZIDl6ZSXFbchJx5nQe3hVfDDg1weW9xTdoKW5s0cV6Vk+MGjVqCtjsNVeHrt2NYwTvXTeYEi9DkfV613rzIqrPOO9GAp/N8hWq0WUIADbj+SfrACU8lZtlTJMYWtpUPjBgfG4x3gmK7HiWM+2Khf4qmniNW2bmGIsjrTPwVGdDOkndpfHUlHP2ULco5FVqS1z5J01GTQsW/lRKDc1gvFvZ+bByM7Jx4VlgGRdfqDVKxviL7tWzyXgbbHxllQeD7uHyApJC8hh3p8BmCSMCYqSgO5D9O2yia9CAsBFtsThLvlXs0dEQPxwtS7iIpqwWv2ApwPkzYeu+hxoq0CCzGeD/HWhEeuTsOb3p7Jo72iV8ZqAeWr19EJUzP009/xhU4vDqY6JGpessuFIfg0u7KO2VLLiKp+990pcTQI29ukrxLwRdg5AnRPxNbihTKrJXZkybSa/3IazRznvBu1WfIwjO68wbVGUNKB3gYF6bsafdGDiVYcUV6DCxURDnaz0BL4KoUCHQ6SfPr7pitZ8fAqFrzp28b0IgLORk7dDKHX8Ol+X2+FIMsu5PPVLvVm6U0UimU+F2opznuLZu7dZ/spt8YylDo2FY97tARQ+IcLeMEPKTCo5G5IoDw/QEmNqqWIjB7X3wxOOA18qhLWl/u3xPGhVcmbVn2mwsAhYNDoV8tNenhnp3x9A5rJlEzKUBKzcUXNw894Bgrzf+a2riqw=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|31061999003|51005399006|8062599012|8060799015|15030799006|15080799012|19110799012|4295299021|40105399003|440099028|3412199025|10035399007|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ugJYF/muZFeXZlxA4YQKUXBP5HYR2aiA6im9FkS1RuVfBRU9MXbQe6XYcw?=
 =?iso-8859-1?Q?SQFpPo981r1pdkJaJoWTAlK7ijYAMbuj6SiIUBMugrrFLdsbvsmnvWCw/o?=
 =?iso-8859-1?Q?+rp79cqIbVCzDcbArGjJlFGlSdNptscs0tHd52YNzZ5Zp23c9+W+elIEgK?=
 =?iso-8859-1?Q?feE4xL6fZOmWuhKI82gnKasC4o2hBp555NX1RnWYE8bgsyLejZXcMrcMFd?=
 =?iso-8859-1?Q?YU3b3RmHXBtSxGn0D7sidP01r7eXfsjw2YbQgHkjZkvZbZayCR44wynOzB?=
 =?iso-8859-1?Q?Ybpo8nOQrxed59exMP/N5kIqSQKvHYXtUrh4lOJoXsTDbsZTcXu0XnyJe7?=
 =?iso-8859-1?Q?Cceqx6pk0ck15ZufW9Wz664aUmlQgL2Whxb0j1zw9HDoUVTyIsz+5I3gDw?=
 =?iso-8859-1?Q?7rBz+Eqq7hDmKLyF0SQ3PNmkubax5Y9ZM//0MuHVE+6mFPBVLvAgCO0+ll?=
 =?iso-8859-1?Q?4ZLw5vQqJw5Y0MmHRUarI1pVHiWYVNbSCD3KyE1W+dvP+YNkD4684uYzGa?=
 =?iso-8859-1?Q?+t7pkASB/Uc9gioXwe3F2croNmj0pUm8KuE8zTuflGPrc8+0V/QMga1a9j?=
 =?iso-8859-1?Q?nof7h/OYetOBQn5+1mouvBrej4KqcB2l/Ql96OOdy6cWArGZoqIjsNAXPx?=
 =?iso-8859-1?Q?D6EoiHyELD1a9bJNbPu1jHPMgVyELJXFQQKdf4aiJK+UTcdYvcM550V6hK?=
 =?iso-8859-1?Q?K1y7KzsEToFfQb6Vekpk4Q+Ypa3cKOtQ8s4Imodv/sWfwPP1H/ZJ5Uy03u?=
 =?iso-8859-1?Q?xx2bDFsYT1phFqq967Z3Q1b5XJ/3E9BB5dF7CrDj5Xshoq+zcAq/+gVCE9?=
 =?iso-8859-1?Q?/MhqR1MfKL7af+RLnBqUyuJaMVFT0Nq/ZoO/WeRS6PuJmXVbR6CaX8Fprh?=
 =?iso-8859-1?Q?POEugwcfGUg24lAqWvRSaucIwq10z1gZ0wmSOn1Hn9BQItMjphuRwIlf85?=
 =?iso-8859-1?Q?26eFNj7BrNBk1wZxlwS8m4wCOghcUfmzMz2AP0+kQF1vnaXrY0IgxFwJqB?=
 =?iso-8859-1?Q?8ibg861JjvpIhLoAkPFsruRXEoiYa0v78260krXjBQTHDMJO+5iD9SchEm?=
 =?iso-8859-1?Q?66JzZ0U9jMrZEILDto758oarc61WzOtQVXoAczFoYaqzClh+O97esBMcub?=
 =?iso-8859-1?Q?NQVpvrZKE0wZZHrZKSqJrUsrVs5xaUo9HDvM5Ex3KsWPnLgqaqtZudpa5Z?=
 =?iso-8859-1?Q?3QFqm0PK0lWXV3aKXtji7AhO4+cF4b9QQhqxMTb5UEu+dmN95O+Sn+NCKD?=
 =?iso-8859-1?Q?y9KPm2flCL7W3p2J8SY8b/ILjnepoTYituo0jrQqmSDIhKB8lu9U2pVmDm?=
 =?iso-8859-1?Q?HL1vceUk9K0SrvlCPahwb3ZtvLHQULXu0pOt7V7vKiEjAlG57iqox/eFDX?=
 =?iso-8859-1?Q?uW+iFoyYU9?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?YCU7qKefVIoBbqBOV1OBCuwPu58jUjbgtlCvYlr0jBhx4nC4M2c+3PueQd?=
 =?iso-8859-1?Q?nmT3H9uNbT1RT/EsPd2K9UTMm1Nr922O78oqYOgIizFZ1ni0t4ySxIFYLc?=
 =?iso-8859-1?Q?SyFmDXWFMfvuYpbb6mtzSUkMTYLPcJGjLDTAFRY+Wg1osXepaRBH2KQeOK?=
 =?iso-8859-1?Q?SDCILlH29MU/parXh+XFhsJSZOBX+axFa5WzJQyIIjoLEA0rWR+8Mx/Xru?=
 =?iso-8859-1?Q?OVnYcZLcd4z/sIMl0nH6HD47kvZQo1ON4dekcdN5kj9a8ODdT/NycuSjHg?=
 =?iso-8859-1?Q?aQmQ2Lt06DjerS1BNUaUtzGGuhwWRJT4+c+O6AqWO5x5LA2lxK42xM/rul?=
 =?iso-8859-1?Q?RKnOnzOaZgveYEyVd4LPtd4Gch/mxKM3ns/sq5tjAT1S1ZKNqufCQ1n7ap?=
 =?iso-8859-1?Q?rtic/Erfu1HQ3AUdOp3uKboERsHZkjjZ36dsUKCrNFTmERNNSwyO7LahPF?=
 =?iso-8859-1?Q?ygQ/4cRyONg/2IrbdWIn2Hd/JJxy1+0fKy15JJIzDKt2jlNOKR+Dyb7iVD?=
 =?iso-8859-1?Q?Gewv/2lIBJlwc7cWkrNpjnKsK2Yh1bMdQJSCgyRjJcoi90E7GSG+LK6BEg?=
 =?iso-8859-1?Q?S504GJ4J/DvHJhWCbrLieK+FbGTfEH/Ndkpjz4g9V/w33FQYGCCiWUFGia?=
 =?iso-8859-1?Q?XmQKehfR/bWDa+YqxDpbDQmtq/d+gWNhEdFKOsdVNcY4VMBAGXcSOBzGAN?=
 =?iso-8859-1?Q?YM2uc3V1TyfHeN9lS3cOLrzqcQ6Is2iedmS0K2JMOX6YE6jC68zHmc1UqR?=
 =?iso-8859-1?Q?K3CQSOrH0Xzo69xAqoHJwtJfuYZzxcVELaxMaU2crHjBWSXFoIHqLDVg4R?=
 =?iso-8859-1?Q?PSk3akD5mp3U+x5MOyxc+s92EWxjbp2azgL7K/2YqAiF/BqgSdB6dU64Ng?=
 =?iso-8859-1?Q?swxF3OHIYpquulM1b0mFz5w9aB3u8coLKKMPOHeyfplN2UsPs5i4YzA/5p?=
 =?iso-8859-1?Q?q2LmQK+2jp8EyJVavLedDmhA+2cdw8ND3GXFOg/Ow6lFuqNqP0Mrsdtlmf?=
 =?iso-8859-1?Q?hLrSJKphvG36zq8SxOGw/cb1nsIL4EtWEyYIgdP4cwk3BxvHcmZFjwk8ki?=
 =?iso-8859-1?Q?Aa4ZrO/Pwt2GMD3J3OHo4wvYN0LUORB9FeRVOO73c3/wm8pGHibXesAnAO?=
 =?iso-8859-1?Q?cvuPBKV58E2T5xquRolpXRehI3hC7WOhTwCOklNmORmcwHIb0fODCHJyzQ?=
 =?iso-8859-1?Q?NewTDwNjoE4I7iOYBCqkMMK+TOXQkwe5b1dFuc8wYa/+AfDe6LNq9oIs4T?=
 =?iso-8859-1?Q?j8Qm7oZBtO/t/nvpy1JoShF3lHUbvgxVpBA2EW43jK4VgXoZw2ljc5ohSI?=
 =?iso-8859-1?Q?iIj5kF5DCcGKZAmMo17azox/vnjtshet20kyLnKZ3UwIrPNvoZp+6mtJKR?=
 =?iso-8859-1?Q?SEToVeHHYTf5FE0tunRA24BYwHkHp1yHIkrChrOYG9rdL1tZ9b3h9iF/a4?=
 =?iso-8859-1?Q?Q8WJIztcAvliUuvn?=
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
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d401eaf-686a-4306-04d1-08de72b456fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 08:20:01.1871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB7836
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FAKE_REPLY(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259936-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[outlook.com,nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,outlook.com:dkim]
X-Rspamd-Queue-Id: A6F47172FC9
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 02:14:07PM -0800, Jakub Kicinski wrote:=0A=
> > Reported-by: Yuhao Jiang <danisjiang@gmail.com>=0A=
> > Reported-by: Junrui Luo <moonafterrain@outlook.com>=0A=
> =0A=
> Please remove the self-referential reported-by tags. FWIW:=0A=
> https://github.com/google/security-research/pull/334=0A=
=0A=
Will drop in v2.=0A=
=0A=
> =0A=
> > Fixes: f054e3e217e4 ("dpaa2-switch: refactor the egress flooding domain=
 setup")=0A=
> =0A=
> This commit looks like refactoring.=0A=
> Please dig a bit deeper to find the real commit in which the bug was=0A=
> added.=0A=
=0A=
I found the actual vulnerable pattern was introduced in:=0A=
=0A=
539dda3c5d19 ("staging: dpaa2-switch: properly setup switching domains")=0A=
=0A=
Will fix in v2.=0A=
=0A=
> > +	if (ethsw->sw_attr.num_ifs >=3D DPSW_MAX_IF) {=0A=
> =0A=
> Unclear to me from a quick look at the code and the commit message why=0A=
> we reject num_ifs =3D=3D DPSW_MAX_IF. I see there are some references to =
a=0A=
> control interface in egress flooding, is that why?=0A=
> =0A=
> Please explain clearly.=0A=
=0A=
dpaa2_switch_fdb_get_flood_cfg() appends the control=0A=
interface entry after all matched ports:=0A=
=0A=
      for (j =3D 0; j < ethsw->sw_attr.num_ifs; j++)=0A=
          if (port matches)=0A=
              cfg->if_id[i++] =3D ethsw->ports[j]->idx;=0A=
=0A=
      cfg->if_id[i++] =3D ethsw->sw_attr.num_ifs;=0A=
=0A=
When num_ifs =3D=3D 64 and all ports match the flood filter, the loop=0A=
fills all 64 slots (indices 0-63), then the control interface write=0A=
goes to cfg->if_id[64].=0A=
=0A=
Beyond the array overflow, num_ifs =3D=3D 64 is also functionally broken:=
=0A=
build_if_id_bitmap() silently drops any ID >=3D 64:=0A=
=0A=
      if (id[i] < DPSW_MAX_IF)=0A=
          bmap[id[i] / 64] |=3D ...=0A=
=0A=
Will clarify this in the v2 commit message.=0A=
=0A=
Thanks,=0A=
Junrui Luo=0A=

