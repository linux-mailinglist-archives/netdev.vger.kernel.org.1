Return-Path: <netdev+bounces-145517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD059CFB6B
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 01:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF66D2857D4
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 00:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1BB184;
	Sat, 16 Nov 2024 00:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b="HYJgxsGI";
	dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b="ClanXLeq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-000e8d01.pphosted.com (mx0b-000e8d01.pphosted.com [148.163.143.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35170EAC7;
	Sat, 16 Nov 2024 00:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731715301; cv=fail; b=cTBU4AUhZS9i637l/zEqkVm7m5gYzZvEXNEIon446rPazWB2ZpB1y+3GMx2pumLEWIvPdk6I+UOopXeZVQUp94qN9JY5isTgPP/sc7TjcTfcVTXRVyf4eaT+fyHkL+9RT3MN3i5VQ4vKsktCzXA44rN6/C8IxIJC1WQRXlMd9fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731715301; c=relaxed/simple;
	bh=jLP9dtQAB3rJW0VQ9GC2yzNgl3qY6PBhDgugrA0vPZg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s4875E55nEr/Ffw92TUFMquBAhyatZ8XaRE2b6FTdK9WisqyVoekenvlIzvENJP3UcCkr0+10xpcI5UcEtJcI3+HLMc5EVDtSCAMfn6tXwALfdEx8T6rkqljSZf9niXmiW9uqtI3FqdJxuiWO+OG/g3dj32ubIXnIIcOVL04Yf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=selinc.com; spf=pass smtp.mailfrom=selinc.com; dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b=HYJgxsGI; dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b=ClanXLeq; arc=fail smtp.client-ip=148.163.143.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=selinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=selinc.com
Received: from pps.filterd (m0136174.ppops.net [127.0.0.1])
	by mx0b-000e8d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFMbWAF014476;
	Fri, 15 Nov 2024 15:51:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=sel1; bh=jLP9d
	tQAB3rJW0VQ9GC2yzNgl3qY6PBhDgugrA0vPZg=; b=HYJgxsGIm2KiE5BhrXors
	lFq4tlCj4gXF3Wtni5BS441XgZrLNvLYxNbzItVYALhVK4iX1JY8lwCHDmJfgBs4
	X0joxHbVTo3k6+kAEmC+48TgpQU3H8NCcsIUMW+xn2AjF8yjbtClD2lRG8J937Oj
	Zm03cdF1RBPHZD1DbIjGXFhDTHkcKg6kMUVOfZx5mljoltAqZmoX/uNrZMOn+ev/
	CIhHpyCb8Ht3AYxuwicyg+sWTM/ONjQYTlXT5pqOXmxngWEoyDIxQvrXHK8seW0x
	OEzB2g/1lElb3/ERfchQ5SJwtRm3ZV2Mo9JyodH+eBeOIdXWaL/Hl8qXutqjJ77g
	A==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 42wnf212fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 15:51:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdSQyYDL5RwqaKKD7q+5M+xa0XI0syayqy9bDAi5Vj2pxuIL1XWTBcE/RA5VxhM05jlhYHg+P3QRf3Nj4M0shwXN2+P1y8GKExQiHNZY2tQri08PqLMF+SLwmYv5xLUvsF3XDbF5XwnihIvWu2q2nVLQ2nc1PnVysCiJiHQ15LZV65GQMNPGUh+nS/X8eFSh2TL+kzTNuX/3eagLuMQ4hOQxW5N/3TVrgHfmIkpkttjRtw7kotTrDMStNibMLkaEuUSNopRWRoLasEZ6g+jl7rHEBSVzNI+OQt6wpDH4B884kUDPvkz56MCPbu4kw1qO0ViH0NdTDUXQVZMoXxgNNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLP9dtQAB3rJW0VQ9GC2yzNgl3qY6PBhDgugrA0vPZg=;
 b=eqeTgj1rxA6VM6gyOkH3iVGxwuenIWaJk+JFfYjJrsPfmBD3VtvxVasnuuTbqUARtDZ9Zdr/3VB68cBR42b9qSxjxPHVEqnYH2luqVI4jANny2sMGPFryiIAvaKU80RXewH3AFV8hJERoSz7LoHGvRNGtwoWOYOsfhe8l1wDv4GL0WapKlslI22aJJUkOGY8J6n4R8zROdXccnqYddHkbSUgTb8m9buPJGgeHnBVlsDNw1fkT9nzoo0hvR3/jYiZCXGtEHMV6MtvDXVrxuFU3a103B1w2B7uNvuD80Zvfybr48c9l/sr6rQzFyTELqijC2r3naJbIVIXNdcoSWWJRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=selinc.com; dmarc=pass action=none header.from=selinc.com;
 dkim=pass header.d=selinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLP9dtQAB3rJW0VQ9GC2yzNgl3qY6PBhDgugrA0vPZg=;
 b=ClanXLeqvIQrkbNkT1IHF8KeL26V2BCt9BRO4BmbFUMxEYz7XkLo+a5B3gpGKmaFQfkCY1nDMJyIqf+l5ICbN07Sunp1O1sulx5tPdk60UjRAK9QkBgKrE3axuiHFHDjnohg+rw94O2TG5gly45PDiv9nl/pXffkkaJCViILzMkjxMt+ZtIuXAN0lysDEj35BqRU8dctMOGdgKBu1f/Qib/YZ+KleM5ifunU0q5DYwndu/HPTjNg7L0A1dFT9YQ6h0xlx/6bAYkNO6K7B4DX+OgViaDYYVGVcrBkNk9topv9b2qxyOEfFjo/XZM9Usp9cwf7uTwECuSghuEj0Jbt3w==
Received: from PH0PR22MB3809.namprd22.prod.outlook.com (2603:10b6:510:297::9)
 by LV8PR22MB5506.namprd22.prod.outlook.com (2603:10b6:408:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 23:51:03 +0000
Received: from PH0PR22MB3809.namprd22.prod.outlook.com
 ([fe80::dc78:5b2b:2e12:8731]) by PH0PR22MB3809.namprd22.prod.outlook.com
 ([fe80::dc78:5b2b:2e12:8731%5]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 23:51:03 +0000
From: Robert Joslyn <robert_joslyn@selinc.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "lee@kernel.org"
	<lee@kernel.org>,
        Romain Gantois <romain.gantois@bootlin.com>,
        Herve Codina
	<herve.codina@bootlin.com>
Subject: RE: [RFC PATCH 2/2] net: selpcimac: Add driver for SEL PCIe network
 adapter
Thread-Topic: [RFC PATCH 2/2] net: selpcimac: Add driver for SEL PCIe network
 adapter
Thread-Index: AQHbKYm0/z4P1lQS/k6ewHCARnYgRLKd8gKAgBmHGcCAALKigIAA19uQ
Date: Fri, 15 Nov 2024 23:51:03 +0000
Message-ID:
 <PH0PR22MB3809373A2119097A3D2484DFE5242@PH0PR22MB3809.namprd22.prod.outlook.com>
References: <20241028223509.935-1-robert_joslyn@selinc.com>
	<20241028223509.935-3-robert_joslyn@selinc.com>
	<20241029174939.1f7306df@fedora.home>
	<PH0PR22MB3809C7D39B332F0A9FECB11AE5242@PH0PR22MB3809.namprd22.prod.outlook.com>
 <20241115101901.4369e0da@fedora.home>
In-Reply-To: <20241115101901.4369e0da@fedora.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR22MB3809:EE_|LV8PR22MB5506:EE_
x-ms-office365-filtering-correlation-id: 22430c7d-3796-4f41-e661-08dd05d05d45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ePM0Dmw/oDKn39QhL4mIJaCvyNmyiAh0l5CFXfmn7lLPrgDJMKIonBWBEKFp?=
 =?us-ascii?Q?vRJHJrnUvl1UAPt49be4dvzmNEW0m9jry+tCGJwP3ZPK5KkO0blglgeWABH7?=
 =?us-ascii?Q?iwb2Lzregg8Po2eUSTORzFbyWgVjx8IzaZDRKVwE0BpPHdZFNzot51HMKGS2?=
 =?us-ascii?Q?GYgz1AsJKNx6muDf+tx8HiRKngfQBW5vYhu7ZUM6Z22EBU8c6VfVqWeTO6Y9?=
 =?us-ascii?Q?hGIVohxQbDr6ZVa8AHQehO/aAxrj71MbfcrYiSokXsYpQjdKNrU/8ORwELKu?=
 =?us-ascii?Q?DmXWrQVsE8/nxjxwkj8jXa/6RZq96IZNuEvNmjvrRV4bbntAU+e692qHuIcD?=
 =?us-ascii?Q?7/wrGSpPsSCRxxOrX0EUzz8Bok1onWqoUtfzq4YJLibCL4x/+GUW7YWyE4Ud?=
 =?us-ascii?Q?DgpCIsqBLQZRd/IkH9sQShNzPgV66XC2Zx3dzpbIUO1o/Zmq/xbHtY6F+ZcL?=
 =?us-ascii?Q?QM0donnSJ13qSnCR2AiVc44EKhO2H3436ob1yfJoM8rjKpQ9SGum7O+PlY5M?=
 =?us-ascii?Q?TiNYBnYi50m+LYABwZbfiLmj9tjX/nZJTj8iKNpnntc+gBk4BelPF48pRUSs?=
 =?us-ascii?Q?dT7qMebuxX1PCIAoaTEgVN2wW1EcYE1eZBgsW6y4IjGyvK543DYMAdVW4V+g?=
 =?us-ascii?Q?12hfpSq/LN1j0vqIkMGaywpuChZMHf3NQPEgm9R7LrBSLpRYxY3HHpAToR64?=
 =?us-ascii?Q?Ka2ZLGO/hmmNeHOIgpT9JDjD6zwkTE3UNWQkU879d+6/vFMx/muuKrk8FZl9?=
 =?us-ascii?Q?JXjSCoEfqJLfTPUOQhTUEeWL+YwA8ztiz25T5JBmG/Ji8eFVv4hQlyUA5sed?=
 =?us-ascii?Q?x8NcdFtOx9I9tFYQrsTHgWn5V+SQ97+z/gtok20hZM3J6NrZGgI/G/WcVYnt?=
 =?us-ascii?Q?nXIfPLTtkRZrszP07mnk2AXpr81bq2HzucKiZnV8X2wliPqUsWmxx9LHmrlj?=
 =?us-ascii?Q?S0YgNaWNPqTh5rYlSyJTW3u1xfkdEGaseuB0xX6HOvaewDzlW2U6v0pj5S2E?=
 =?us-ascii?Q?qln83eLkNUw/geEMY7yHIGwct7Uo9w6ztu4sVT4zfkHsJXqs0Iz4qGx6tbqL?=
 =?us-ascii?Q?AOkiWzg4ALD4rlXgL8ERdE0IfFGZYkfj2kWnI07yZVW6fENbpAwmM0W3o+48?=
 =?us-ascii?Q?rXUee8pBQM955Cu+eftqwE2HKuBjk3hDCjj4MasmWEcfgIvzuZ/SY/AIB/cP?=
 =?us-ascii?Q?IJZmSk0BDTg3PjcYLpJf6fR85Aa1ryfbm90v55GViIDkYGwU4DeM/Uowa596?=
 =?us-ascii?Q?HhMTe5Whkes26gzE5zKc7MqvqY7T5iN47iRgjJUv9RLQA4jqNhvmxKFqaRRN?=
 =?us-ascii?Q?NvNmXrMu/dfkKKnp191nCLWL?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR22MB3809.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0N8vFXyb0/XZHs5fV088QLe+7yMZooshUI94ELQQPtV/JI684VQ99sEYPK5B?=
 =?us-ascii?Q?y8O0KM3CGHQZ7zdawSAC8qevJsprHkIs/DRWXITxLoel++kmsuMJFsCRIYjB?=
 =?us-ascii?Q?690B9dAVWycvgOlZ0tCDaK/1Gq4vO4pChJuwAU2afrOfJJ/r7Oi2TVemTYD3?=
 =?us-ascii?Q?1lQiRiVWF2W7QSYgGTLsCtFhQ7s/ysWeMlgLyuxYAI6Y4RKcIIwwRgR0kF9q?=
 =?us-ascii?Q?+WM6CLp+piDmCvZSPNwmvLCRstWSid7po5sESQj21Zex5la+Obx0W6LTCeoY?=
 =?us-ascii?Q?vk5w5ND6IJULyc0bN2K4+kppBYTvGrZL2cnVYmn0CqPRw4dL/YUEb7EKb0bu?=
 =?us-ascii?Q?Ru+xswOBOCC+V6JBfsg3sf+g3wu3dEpGvfEdo8G7pqlP2t/VKMx/MEnenucG?=
 =?us-ascii?Q?/YynlWVbme8zWO0PDfrbST1tCti/h9w+xLn704emGYT7+8p364E2eWdtjvDe?=
 =?us-ascii?Q?pI08btcIjpZSsmodPndWYZ8Dv8gj4QHYGEHWaUXuIq28jl2uJl/s2ll/6ogy?=
 =?us-ascii?Q?vI6uV1e3cZbWDmQ5SYKKvTOYT62roNknN6fKtbK0rBwZGDobPlBCM80giXTo?=
 =?us-ascii?Q?V1dqLFwoz4XmjjLG2WgbZE0ya3tNXvnIpiUuqEVXD/Qc8L7AYxmwIoymlEZk?=
 =?us-ascii?Q?1SaffRpLB2DIXSflgySzpPyZ4Ob3tBPSUivEntqrvbRmh5Z3yKtiosuJojTf?=
 =?us-ascii?Q?+EwdFA1PYctjK0E/1e6ivkClddpbsvMylNfeLlm5o0Ile3g5ryZpdEGfi2sR?=
 =?us-ascii?Q?baWZ2eyOE/TlST6e+pr9XurccRaZHE/SHvEb2k5SuCSQMHqaHl2papxclQLf?=
 =?us-ascii?Q?5Mi3Ki7I+dV7tU37lusBceDhtaf8cPFhQ0m9LRN1W/he7HCqqmEoM0RD7q39?=
 =?us-ascii?Q?Ahv+RKYiSQXvaBVQUfJ2G36LAbK6e3581bUO3HSKompATMvxRWTe2o+xSW79?=
 =?us-ascii?Q?Rzamde5069fmY0JA/2NFYtIJdY+A+iUajs/1nyhVxeLrS9WiqArFmkodZrbg?=
 =?us-ascii?Q?bVAJtUJGYobGwwtKd2dNWYe+asoOCAr/aZGnGFEQe1m9OC6EALeMkote8+L+?=
 =?us-ascii?Q?rP/o9uSuJ2itMtU81gttBE3aewrsifWgvl0fRDGbXnZoLYxfTdaqb1U1PE/9?=
 =?us-ascii?Q?rjZzkf7ks2eMXtwbr/KJ62swtwjIPnWBboAjJobXc4kzMQhfdiGwa7WkU0jF?=
 =?us-ascii?Q?U3bbrOakQjL1pUlE1pVUlKQQZ08uGBR0ElrgfyP9PX400v6ho3uKla4R5WAy?=
 =?us-ascii?Q?SfCLUTq1BFfZvlJL9zsUrkjKe46D5g0mTCM17CMScs7KUR2/E7YUF8IYm8Wk?=
 =?us-ascii?Q?RC7VLeTlixDhFBCb+XARtHHvtXU3kfDV9bUs646NagDepwDfyn/WuoQ2AKnd?=
 =?us-ascii?Q?oK0G0ABeo6aBZDNcgOdAfizzHats6QLmwFDBMmEGnbw1oRe+/dTEc+yIPgQ1?=
 =?us-ascii?Q?H8CBZY9utJh360kr7kGDzCSVk810MqYP4JbMZ3jkWBNvquw1dngesGpP7Gyd?=
 =?us-ascii?Q?YH37qLgY67+FzqUXCX1He4PGXZ0+q0QhfuMTvt8IKjDclm31PY7wW1he9mg1?=
 =?us-ascii?Q?D1mutN1tANds+5unfp81/x0BqnqA9qC2v6JgJHYd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR22MB3809.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22430c7d-3796-4f41-e661-08dd05d05d45
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 23:51:03.2118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W3NogB0crKl2aBqkQ6Z8L6w3qStNxAwLUL7ZcF6z3FMdkUv9FWTy9SYpeERU/Lmtd7KLgG3j/D9CQbIJ74PhRg8wo7MtxXhe1yGmyPxphPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR22MB5506
X-Proofpoint-ORIG-GUID: k1dhareUUEs3oWFEPA1fyMmPrihu7dvC
X-Proofpoint-GUID: k1dhareUUEs3oWFEPA1fyMmPrihu7dvC
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150193

> > > I haven't reviewed the code itself as this is a biiiiig patch, I
> > > suggest you try to split it into more digestable patches, focusing
> > > on individual aspects of the driver.
> > >
> > > One thing is the PHY support as you mention in the cover-letter, in
> > > the current state this driver re-implements PHY drivers from what I
> > > understand. You definitely need to use the kernel infra for PHY handl=
ing.
> > >
> > > As it seems this driver also re-implements SFP entirely, I suggest
> > > you look into phylink [1]. This will help you supporting the PHYs and=
 SFPs.
> > > You can take a look at the mvneta.c and mvpp2 drivers for examples.
> >
> > I've been working through migrating to phylib and phylink, and I have t=
he
> simple case of copper ports working. Where I've gotten stuck is in trying=
 to
> handle SFPs due to how the hardware is implemented.
> >
> > This hardware is a PCIe card, either as a typical add-on card or embedd=
ed on
> the mainboard of an x86 computer. The card is setup as follows:
> >
> > PCIe Bus <--> FPGA MAC <--> PHY <--> Copper or SFP cage
> >
> > The phy can be one of three different phys, a BCM5482, Marvell M88E1510=
,
> or a TI DP83869. The interface between MAC and PHY is always RGMII. The
> MAC doesn't know if the port is copper or SFP until an SFP is plugged in.=
 The
> RFC patch, which has fully internal PHY/SFP handling, assumes the port is
> copper until an SFP is detected via an interrupt. When that interrupt is
> received, it probes the SFP over the I2C bus through the FPGA to determin=
e
> the SFP type, then reconfigures the PHY as needed for that type of SFP.
>=20
> So do you have 2 different layouts possible, or are you in a situation wh=
ere the
> RJ45 copper port AND the SFP are always wired to the PHY, and you perform
> media detection to chose the interface to use ?

Mostly the second. The PCIe card can be configured as 4 RJ45 copper ports, =
4 SFP
ports, or a combination of 2 RJ45 and 2 SFP ports. The PCB is the same betw=
een
them and has pads/holes for both an RJ45 and SFP cage for each port, but on=
ly
one of them is actually populated, so the only physical difference is wheth=
er the
RJ45 port is soldered to the board or an SFP cage for a given port. The out=
put of
the PHY is connected to both sets of pads/holes.

Because of this layout, the driver/MAC can't tell the difference between a =
port
that has an RJ45 soldered and one that has an empty SFP cage. If the port i=
s RJ45
copper, the FPGA never senses an SFP so we always treat that case as copper=
. If
the port is an SFP cage, we only know it once an SFP is inserted and causes=
 a
module presence pin to change state, which fires the interrupt the driver s=
ees.
That interrupt is the driver's signal to probe the SFP and reconfigure the =
PHY for
whatever mode is needed.

> > After porting to phylink, in the copper case, the PHY gets configured c=
orrectly
> and it works. In the SFP case, I don't know how to reconfigure the PHY to=
 act
> as a media converter with the correct interface for whatever kind of SFP =
is
> attached. The M88E1510 driver, for example, seems to have support for thi=
s in
> the form of struct sfp_upstream_ops callbacks
> (https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v6.12-
> rc7/source/drivers/net/phy/marvell.c*L3611__;Iw!!O7uE89YCNVw!MvrH2lYi
> 3aIcC63u48SePatqavaBlTe1zVqB121oIdmn7YXJzbaw8ZN0yXQs6cNhlaIJWdA
> mwTzgypDVWjTZdtA5o7LUnoLY$ ). It looks like phylink_create will make use
> of that by looking at the fwnode passed in, but I don't know how to use t=
hat
> to define the layout of my hardware. I assume this is mainly used with de=
vice
> tree and that would define the topology, but I'm using a PCI device on x8=
6.
> The Broadcom and TI phys don't have the sfp_upstream_ops support as far a=
s
> I can see, so I've focused on the Marvell phy for the time being.
>=20
> There's ongoing work to get the DP83869 to support SFP downstream
> interfaces done by Romain Gantois (in CC) :
> https://urldefense.com/v3/__https://lore.kernel.org/netdev/20240701-b4-
> dp83869-sfp-v1-0-
> a71d6d0ad5f8@bootlin.com/__;!!O7uE89YCNVw!MvrH2lYi3aIcC63u48SePa
> tqavaBlTe1zVqB121oIdmn7YXJzbaw8ZN0yXQs6cNhlaIJWdAmwTzgypDVWjTZ
> dtA5oxeQAG6H$
>=20
> > How do I describe my hardware layout such that phylink can see that the=
re is
> an SFP attached and communicate with it? Is there a way to manually creat=
e
> the fwnodes that phylink_create and other functions use? I think this wou=
ld
> need to show the topology of the MAC -> PHY -> SFP interface, as well as =
the
> I2C bus to use to talk to the SFP (I would have to expose the I2C bus, it=
's
> presently internal to this driver).
>=20
> There are a few other devices in this case.
>=20
> One approach is to describe the SFP cage in your driver using the swnode =
API,
> such an approach was considered for the LAN743x in PCI mode :
>=20
> https://urldefense.com/v3/__https://lore.kernel.org/netdev/202409111610
> 54.4494-3-
> Raju.Lakkaraju@microchip.com/__;!!O7uE89YCNVw!MvrH2lYi3aIcC63u48Se
> PatqavaBlTe1zVqB121oIdmn7YXJzbaw8ZN0yXQs6cNhlaIJWdAmwTzgypDVWj
> TZdtA5o-Bs6l4K$
>=20
> Another approach that is considered is to load a DT overlay that describe=
s the
> hardware including mdio busses, i2c busses, PHYs, SFPs, etc. when the PCI
> driver is used. See this patchset here :
>=20
> https://urldefense.com/v3/__https://lore.kernel.org/netdev/202410141246
> 36.24221-1-
> herve.codina@bootlin.com/__;!!O7uE89YCNVw!MvrH2lYi3aIcC63u48SePatq
> avaBlTe1zVqB121oIdmn7YXJzbaw8ZN0yXQs6cNhlaIJWdAmwTzgypDVWjTZdt
> A5o5hG-_OR$
>=20
> Hopefully this will help you a bit in the process of figuring this out, a=
greed
> that's not an easy task :)
>=20
> Best regards,
>=20
> Maxime

I'll read through these links and see what I can do, looks like there's som=
e options I
can explore.

Thanks!
Robert

