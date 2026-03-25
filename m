Return-Path: <netdev+bounces-271402-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FbghOQlzw2mxqwQAu9opvQ
	(envelope-from <netdev+bounces-271402-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 06:30:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3691B31FDC0
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 06:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 841353039820
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 05:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672CB20CCDC;
	Wed, 25 Mar 2026 05:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wR0WzDuz"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011010.outbound.protection.outlook.com [40.107.208.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21E413A86C;
	Wed, 25 Mar 2026 05:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774416646; cv=fail; b=BY1V+ImSOnNVVQSYJkLsjwsAePuNkplrE6KjdQoNEUilm6rq6bNL8SSmjEmFNjJ3gF5UiANtRfC0iPVRfGtE28AVLyx79cMYmamdEvNqmJ4ZS3o6C1L4R3aJBBheZXTbtnTyxxgwgTrMiiYAnds9Oxy2drVMH0Hx+9Qo660ElQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774416646; c=relaxed/simple;
	bh=dms10yoGzW+0g/m+JzHrQ5Bl+fYgYjAUVqy7OFhCkbQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lqdCHVDvVEpIaX0E7UVCgvcDS1/wYi/04xF8bDumDTRDNxmDzTcV4/OS7f5fMwnAd8pkCmrmyPuyBHB96GGXHXtV5Ss9mV/uFI8GFMViA/kZT8TlJWfkfsHAZrbw6y4/hkayjyQzClqTrRnm6rJrCVqgTTV1rGyoUEebqDZdAjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wR0WzDuz; arc=fail smtp.client-ip=40.107.208.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQABqJ0IUm+aH4tyikq15V7izwQCkhKYK7g2VSnmvTutnWGyrv2cWTcHzF+Bi1BGstwKggdoICg8AhTgrE8PbkFXAnl8iqSoLDusn5iQam0qP+Bbv1t+HGrmj2bzTzCCK3/hpKLIsKqOAFDOLUbXSPBO5QAPff5v3fgXusWQurbd+NzCtDBWx5csyq2DzYxwSUWf2lzgh7PuCbAg+qlGr9vFFfvfvJE9re1fmyX6TGXyPDwqABa18Gv2Id0yZHa0ISAPyVxK76ooScN44kxkHXwHyahsvstA3VLbo5j4JPeSCz+6xj2XqsJD58ehNfn3+BUzKFdQpejmeuCmlBzhpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dms10yoGzW+0g/m+JzHrQ5Bl+fYgYjAUVqy7OFhCkbQ=;
 b=nF/vybELyRzgZDZtVXftAxMyIw7goO/WRCL8KipkKKUBbJ5TrHCUj1Scc/Hl9ysXgmcsaKd4fa51pVA3sSCQP+2u+98kvyDw/Rtueg0BPhHD2m/RsFFY3FYdUIJP/63hJdLFJJOTWwRPPzhYXhMJ8Ua7hGQMla3V83SWO4N8Af/0i/PbKKeDQUmDEhbZY1goxcnpP7xLYnxo9+PBwk3Prm1ekZSJrrU2BDBSmnn97ZGEFXngWS0T6ibZfRKclsXCVCaB91xfDHaEbypJ5v4+AYw4gru6XOhr5WbT+elPooeBqHyMLWnC//bCMlqeAyjHWCaPU7EYPck6MK/yP9eNUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dms10yoGzW+0g/m+JzHrQ5Bl+fYgYjAUVqy7OFhCkbQ=;
 b=wR0WzDuzTPVrzR9rHAzB3U9G4gYWBYU8Mw/9rP0nZySmZg6QS6NnBeUef3Z6H/uQXBBoRA6poHeSBAsxo0z7hm+ZiazaY7ssINNwa+hYKjIc2vVQgz+FrpFz02snb8Tvfs1UwaYm46XiR/RQX8D1SFQRPG62EtLN5lf/JW24apo=
Received: from SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 by SJ1PR12MB6291.namprd12.prod.outlook.com (2603:10b6:a03:456::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 05:30:40 +0000
Received: from SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54]) by SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54%4]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 05:30:40 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Simek, Michal"
	<michal.simek@amd.com>, "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	"horms@kernel.org" <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Katakam, Harini" <harini.katakam@amd.com>
Subject: RE: [PATCH net 2/2] net: xilinx: axienet: Fix BQL accounting for
 multi-BD TX packets
Thread-Topic: [PATCH net 2/2] net: xilinx: axienet: Fix BQL accounting for
 multi-BD TX packets
Thread-Index: AQHcu58UbbcaxfGMuUanrd7daxY6S7W92dMAgADeDAA=
Date: Wed, 25 Mar 2026 05:30:40 +0000
Message-ID:
 <SA1PR12MB6798E4EB242D58AEB86661B9C949A@SA1PR12MB6798.namprd12.prod.outlook.com>
References: <20260324145353.1899248-1-suraj.gupta2@amd.com>
 <20260324145353.1899248-3-suraj.gupta2@amd.com>
 <cfaf4077-144a-4876-b6b0-8d4388362217@linux.dev>
In-Reply-To: <cfaf4077-144a-4876-b6b0-8d4388362217@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-25T05:23:58.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6798:EE_|SJ1PR12MB6291:EE_
x-ms-office365-filtering-correlation-id: f71dded6-4b7d-419a-1550-08de8a2fa6f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 imZ0GFJIiiSKnG9VY2OTG+Sbb9VU2wyTzEX8GzORp+mfLQD6iN7HKp4RlCeum6A3qaCvCcq12u7ytASwSFOwqpZulGo719FYCVX9g4DjUki2UicscGhgIxCBf10yrwNoqpYYQtocgwC7J0mWkzanH2UAFHBcoPS7TbMs+owH05+XENvm0N8yXq7GHkyjPBXnHokwjBkF0Q3W5vgt5hPTtPaG4Jeo9bdL4VmC6R5M0OfGtAOjyAyAb3rdaieu0qgmC6YSTAjIJSpdS4b7ui1YzzhWS1t5HUPZ01B0iFC/PzirwNptPEzUyVxA1e8QUyJL1K8ZJivbML5p/zcCyQa0etSkiQ4EBsnnGcTPJMonp6rmqckfBb1QQdHwaev4OJe0oUzCOTlp+vrH3L7ThGuZO/V9ZwKYGnjhIwHIkglLhdNF0fKaEygZZ7dUG8XKnDkVStNzjaiOtgcb8KckF/Yb7P8mDPk2exi4fBpnVlD7PAiNBrMi2vOwsvJtKapAwLSUc/7wfZeHkLjOL1qZ2L5m+crWT7zV7WsxZunLQBcfW5kdD3L7DSKKu0huEAr0EQILcmH3+bnVYa+YzKfypEeZLf5ao+RlGk1ZwgCXn1VJ4cD39ynYmVzdzw3rrM4TLoi0B3IS9jOmnjgvewrZIlnCMaqBiLJwIjjWeDMTBXlrMIA/fmSfareX3U3Y+nkfObU5nFEIPBUHZXg4o02XhGUhBhgHBNBC6+I8kFqHYSLCmKtXTi3wETtZPRSfJTvXEU//oOKdzwUx4i7zXrfuP23gZnX/F0km3KpyYLalb10oL4e7/7WxGTkHmj5W8eKJueCk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6798.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yzl6ZnNaMlVVdHZ1dDZ2cDJ6WFBaMVFEcjEvY1ZjTXVlUC9nSHRlZlFld2dh?=
 =?utf-8?B?V1loOWREQWNmYytITU56cWZxYkNadXlwUEpOamFpZW1vSG9jRU1uSFdpTXRw?=
 =?utf-8?B?U04wdmNZaTdoTUMzS1BZL1d4NEdQQXB6cCtuNEw3UEIwM2x0R1pwZU5maWQy?=
 =?utf-8?B?K1NwYXpJRFhlMXRncndIQmozU2syUkF5MWJZdGFJYlUwTjllQUhkVzhUNVdr?=
 =?utf-8?B?enRaZzVybXNjbEllTG9RcG4xNHRDTFJLajJPSmRGd3pFSFhzeDJmMkpUaVhv?=
 =?utf-8?B?V0U2em5aeFZydnV3WWNyVEdmTVNMa1V3RUc0MWhOcWhMWmtFL29laU9JeE8r?=
 =?utf-8?B?ZlFFc3pac2JwWjNSTXpoRFJYa0NSQk1QdERHUGtuRllMZEt5V3RRT1hsZWhq?=
 =?utf-8?B?YXdMNWdDS0N2aVgxN1RFRU5kRmpNNWZOR0xZNUVySUQ4SnZ3R2FhYlIzeGl2?=
 =?utf-8?B?VW1rRmpMa2VwcEJtUktUR2xsUGx4eFBZU3d3anFqdENnRllrQnQ1K21hYWI1?=
 =?utf-8?B?djRsaUVEb0VNellOYm4zTVBpZVlKQTN4Mkw2N3BBelpGWVN4b2xDSDl3K0pS?=
 =?utf-8?B?MmszUFQ5M1krcEJTTjRGQ2l2VkcvMzc1cW1kcVlZdHRZZXVNRlpiOVhLUG1k?=
 =?utf-8?B?ZksvZ2d6LzdMbnYvY2NqVllLUzBjSXROWkx2bUs4YUQ0MENxNVZoRVh5MkM5?=
 =?utf-8?B?NFpzaDRwYVoxNUU4UU1kdzVtWEp6UzhiMTR6SHdaUjlYZnp5eDcwQ2JnRTI5?=
 =?utf-8?B?VmpLbS9aZHpZZ3ltZlc0YmV1OTFJUWU2a0hBS3BWNXBPL0lsVGp5TG9iSmtt?=
 =?utf-8?B?NlZDVlZHbE5hU20wY2JCa05TZlk0RHFPaFFkSXVHS1U4V1pOZkRWWDRqdGxL?=
 =?utf-8?B?WmZ1K2pxRzV6ZGlvT0hId1oyaWV5bDJJcEY3ZDExNEhmSnBVN2sxdERuTW5r?=
 =?utf-8?B?NnErZEZpOTJCbEpGNWJlYWV5SWRTSFI5K0hXQ0ZmY0k3ZXpqWGZ2RVpHNkFK?=
 =?utf-8?B?TU4wVVlubzBrWmU3aVRWTHBRWG5nUVkyWGVpMCtpdFFMY0lZbmw5b3JUb2RG?=
 =?utf-8?B?YnQxdXJEMWJFMGFrakZRS2FXeW5WL3RvTHMra252YWtscmZmSnhyNkdyYi9Z?=
 =?utf-8?B?K080dXJldHRJZW11TG5xVWd2MlFwUzRQcWJLaWxXdDhqVWRaelM5N0VkK0VZ?=
 =?utf-8?B?c0k0Y1RUc1BNVXltck5XUWpYWlJtU01wRlgzdS9RYWhOcXhoS1p4TjRxTlN4?=
 =?utf-8?B?SXVkODZyU3ZwajFoZmUzY0ZxT0FHM094KzhkVStWaWozWUs4aXE1eUVRWXcz?=
 =?utf-8?B?clR6ckYxZHZjYjB5WnpTMWJVdzVKT3hTMnJNZWZEcC9va1dSQ1NmQ1JZSmwy?=
 =?utf-8?B?VkJhR1ZWNmhIdTZ6cUJMSzV4RC9sYTNYbzM3ZEV1eHp2eEVxeGEyaTkxN0Fz?=
 =?utf-8?B?Ri9lMHBWendVbnlMUTRwV2JORU5jZUp4M2VhOVM5NWdBN0x3aE1uUWlxZkRL?=
 =?utf-8?B?RGFHQ2IvQ21hQVRVaDd1N3lzc1pGZSsxcmhQUHd6dmZQNi9VazVvWXlGQVJG?=
 =?utf-8?B?YmphYitNUStkYUkzVkpWM3dkMXdWcXQ3ck91Ukc3aWFvNEVvSnd0c0tZTzZl?=
 =?utf-8?B?K0N6aUlCaFowSGdKOURWcFR5eUJLRXE1RzBwNjN3elVrNGdGYThCbkgyeGtv?=
 =?utf-8?B?OXMwMHU1MmJPcDdyUUFoMURXYmdFS0NHUHZkMkVVeS9GMmM1c1lqdmtlQWFp?=
 =?utf-8?B?VnFKU0w0TnFGZzFYZE1iY0hlWWxIUG1LNVZ3M3RQcUR0djdhNTFSQ3R4Rkds?=
 =?utf-8?B?elJVNm4yQ1RWWDY1UnFmZjI5eVBwYTIveHQ4YzJ1WlpHZURDK3pETGQ5ZDAx?=
 =?utf-8?B?dXF3YTh1RzV0M2E2NTgrQ0FzdmU3SHhYWTZlU0g4Z2hlOG9XRGpFcWc1dkZx?=
 =?utf-8?B?bjBSOFhhS3g0VDBaTllJaWVsb3c4Mkp5a1VyVEl6aVNTR3c5cWpMTVh6Lzls?=
 =?utf-8?B?NC9ybWdhTmkxQmZrZ1VHelMwVi8wY09QaDBXV21FMGs0dEc2Tm1UMUh6NVJI?=
 =?utf-8?B?WFdRb2UrUDZNeHIrSm9ZSTRXYjNrenVER1VkdE9FazlGSGNZV3dZNUlSaCtL?=
 =?utf-8?B?SkltQUpXdXhkN1dsQXlhZmpRSUNYWXlwdllSb0lBNlhzcEV0Rmw4SU9RcGtk?=
 =?utf-8?B?eVZiYkovQkpLNlNIUVBMRnd0S3o4TlVPVFlnY29qN0lxdFE1NjNLSldXbVhX?=
 =?utf-8?B?Tk9RY3R5K2xpNXE1VFU3MmRCWWx1OUp5TnZ5ZGdnVk9lTnlLeER5VkxJUVdU?=
 =?utf-8?Q?ds6jenEQkEK3mhuZFi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6798.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71dded6-4b7d-419a-1550-08de8a2fa6f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 05:30:40.2532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: unL5MifyeP8gBXh/waIkc8zHOM9knZYZz/r7F0pkYKtnzitWQGASfGxP4rbo3nGimOA4Sh0BmM7qd8Lo4PyG9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6291
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271402-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Suraj.Gupta2@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3691B31FDC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTZWFuIEFu
ZGVyc29uIDxzZWFuLmFuZGVyc29uQGxpbnV4LmRldj4NCj4gU2VudDogVHVlc2RheSwgTWFyY2gg
MjQsIDIwMjYgOTozOSBQTQ0KPiBUbzogR3VwdGEsIFN1cmFqIDxTdXJhai5HdXB0YTJAYW1kLmNv
bT47IGFuZHJldytuZXRkZXZAbHVubi5jaDsNCj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6
ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgU2lt
ZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBQYW5kZXksDQo+IFJhZGhleSBTaHlh
bSA8cmFkaGV5LnNoeWFtLnBhbmRleUBhbWQuY29tPjsgaG9ybXNAa2VybmVsLm9yZw0KPiBDYzog
bmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgS2F0YWthbSwgSGFyaW5pIDxo
YXJpbmkua2F0YWthbUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldCAyLzJdIG5l
dDogeGlsaW54OiBheGllbmV0OiBGaXggQlFMIGFjY291bnRpbmcgZm9yIG11bHRpLUJEDQo+IFRY
IHBhY2tldHMNCj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBF
eHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNo
bWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiAzLzI0LzI2
IDEwOjUzLCBTdXJhaiBHdXB0YSB3cm90ZToNCj4gPiBXaGVuIGEgVFggcGFja2V0IHNwYW5zIG11
bHRpcGxlIGJ1ZmZlciBkZXNjcmlwdG9ycyAoc2NhdHRlci1nYXRoZXIpLA0KPiA+IHRoZSBwZXIt
QkQgYnl0ZSBjb3VudCBpcyBhY2N1bXVsYXRlZCBpbnRvIGEgbG9jYWwgdmFyaWFibGUgdGhhdCBy
ZXNldHMNCj4gPiBvbiBlYWNoIE5BUEkgcG9sbC4gSWYgdGhlIEJEcyBmb3IgYSBzaW5nbGUgcGFj
a2V0IGNvbXBsZXRlIGFjcm9zcw0KPiA+IGRpZmZlcmVudCBwb2xscywgdGhlIGVhcmxpZXIgYnl0
ZXMgYXJlIGxvc3QgYW5kIG5ldmVyIGNyZWRpdGVkIHRvIEJRTC4NCj4gPiBUaGlzIGNhdXNlcyBC
UUwgdG8gdGhpbmsgYnl0ZXMgYXJlIHBlcm1hbmVudGx5IGluLWZsaWdodCwgZXZlbnR1YWxseQ0K
PiA+IHN0YWxsaW5nIHRoZSBUWCBxdWV1ZS4NCj4gPg0KPiA+IEZpeCB0aGlzIGJ5IHJlcGxhY2lu
ZyB0aGUgbG9jYWwgYWNjdW11bGF0b3Igd2l0aCBhIHBlcnNpc3RlbnQgY291bnRlcg0KPiA+ICh0
eF9jb21wbF9ieXRlcykgdGhhdCBzdXJ2aXZlcyBhY3Jvc3MgcG9sbHMgYW5kIGlzIHJlc2V0IG9u
bHkgYWZ0ZXINCj4gPiB1cGRhdGluZyBCUUwgYW5kIHN0YXRzLg0KPg0KPiBEbyB3ZSBuZWVkIHRo
aXM/IENhbid0IHdlIGp1c3QgZG8gc29tZXRoaW5nIGxpa2UNCj4NCg0KTm9wZSwgdGhlICdzaXpl
JyB2YXJpYWJsZSBwYXNzZWQgdG8gYXhpZW5ldF9mcmVlX3R4X2NoYWluKCkgaXMgbG9jYWwgdG8g
YXhpZW5ldF90eF9wb2xsKCkgYW5kIGdvZXMgb3V0IG9mIHNjb3BlIGJldHdlZW4gZGlmZmVyZW50
IHBvbGxzLiBUaGlzIG1lYW5zIGl0IGNhbid0IHRyYWNrIGNvbXBsZXRpb24gYnl0ZXMgYWNyb3Nz
IG11bHRpcGxlIE5BUEkgcG9sbHMuDQoNClJlZ2FyZHMsDQpTdXJhag0KDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC9ldGhlcm5ldC94aWxpbngveGlsaW54X2F4aWVuZXRfbWFpbi5jDQo+IGIv
ZHJpdmVycy9uZXQvZXRoZXJuZXQveGlsaW54L3hpbGlueF9heGllbmV0X21haW4uYw0KPiBpbmRl
eCA0MTVlOWJjMjUyNTI3Li4xZWE4YTY1OTJiY2UxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25l
dC9ldGhlcm5ldC94aWxpbngveGlsaW54X2F4aWVuZXRfbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L3hpbGlueC94aWxpbnhfYXhpZW5ldF9tYWluLmMNCj4gQEAgLTc2OCw2ICs3
NjgsNyBAQCBzdGF0aWMgaW50IGF4aWVuZXRfZnJlZV90eF9jaGFpbihzdHJ1Y3QgYXhpZW5ldF9s
b2NhbA0KPiAqbHAsIHUzMiAqc2l6ZXAsIGludCBidWRnZQ0KPiAgICAgICAgICAgICAgICAgaWYg
KGN1cl9wLT5za2IpIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGF4aWVuZXRf
Y2IgKmNiID0gKHZvaWQgKiljdXJfcC0+c2tiLT5jYjsNCj4NCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgKnNpemVwICs9IHNrYi0+bGVuOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBkbWFf
dW5tYXBfc2d0YWJsZShscC0+ZGV2LCAmY2ItPnNndCwgRE1BX1RPX0RFVklDRSwgMCk7DQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIHNnX2ZyZWVfdGFibGVfY2hhaW5lZCgmY2ItPnNndCwgWEFF
X0lOTElORV9TR19DTlQpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBuYXBpX2NvbnN1bWVf
c2tiKGN1cl9wLT5za2IsIGJ1ZGdldCk7IEBAIC03ODMsOCArNzg0LDYgQEANCj4gc3RhdGljIGlu
dCBheGllbmV0X2ZyZWVfdHhfY2hhaW4oc3RydWN0IGF4aWVuZXRfbG9jYWwgKmxwLCB1MzIgKnNp
emVwLCBpbnQgYnVkZ2UNCj4gICAgICAgICAgICAgICAgIHdtYigpOw0KPiAgICAgICAgICAgICAg
ICAgY3VyX3AtPmNudHJsID0gMDsNCj4gICAgICAgICAgICAgICAgIGN1cl9wLT5zdGF0dXMgPSAw
Ow0KPiAtDQo+IC0gICAgICAgICAgICAgICAqc2l6ZXAgKz0gc3RhdHVzICYgWEFYSURNQV9CRF9T
VFNfQUNUVUFMX0xFTl9NQVNLOw0KPiAgICAgICAgIH0NCj4NCj4gICAgICAgICBzbXBfc3RvcmVf
cmVsZWFzZSgmbHAtPnR4X2JkX2NpLCAoY2kgKyBpKSAmIChscC0+dHhfYmRfbnVtIC0gMSkpOw0K
Pg0KPiA+IEZpeGVzOiBjOTAwZTQ5ZDU4ZWIgKCJuZXQ6IHhpbGlueDogYXhpZW5ldDogSW1wbGVt
ZW50IEJRTCIpDQo+ID4gU2lnbmVkLW9mZi1ieTogU3VyYWogR3VwdGEgPHN1cmFqLmd1cHRhMkBh
bWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC94aWxpbngveGlsaW54
X2F4aWVuZXQuaCAgfCAgMyArKysNCj4gPiAuLi4vbmV0L2V0aGVybmV0L3hpbGlueC94aWxpbnhf
YXhpZW5ldF9tYWluLmMgfCAyMCArKysrKysrKystLS0tLS0tLS0tDQo+ID4gIDIgZmlsZXMgY2hh
bmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQveGlsaW54L3hpbGlueF9heGllbmV0LmgNCj4gPiBi
L2RyaXZlcnMvbmV0L2V0aGVybmV0L3hpbGlueC94aWxpbnhfYXhpZW5ldC5oDQo+ID4gaW5kZXgg
NjAyMzg5ODQzMzQyLi5hNDQ0NGM5Mzk0NTEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQveGlsaW54L3hpbGlueF9heGllbmV0LmgNCj4gPiArKysgYi9kcml2ZXJzL25ldC9l
dGhlcm5ldC94aWxpbngveGlsaW54X2F4aWVuZXQuaA0KPiA+IEBAIC01MDksNiArNTA5LDggQEAg
c3RydWN0IHNrYnVmX2RtYV9kZXNjcmlwdG9yIHsNCj4gPiAgICogICAgICAgICAgIGNvbXBsZXRl
LiBPbmx5IHVwZGF0ZWQgYXQgcnVudGltZSBieSBUWCBOQVBJIHBvbGwuDQo+ID4gICAqIEB0eF9i
ZF90YWlsOiAgICAgIFN0b3JlcyB0aGUgaW5kZXggb2YgdGhlIG5leHQgVHggYnVmZmVyIGRlc2Ny
aXB0b3IgaW4gdGhlIHJpbmcNCj4gPiAgICogICAgICAgICAgICAgIHRvIGJlIHBvcHVsYXRlZC4N
Cj4gPiArICogQHR4X2NvbXBsX2J5dGVzOiBBY2N1bXVsYXRlcyBUWCBjb21wbGV0aW9uIGxlbmd0
aCB1bnRpbCBhIGZ1bGwgcGFja2V0IGlzDQo+ID4gKyAqICAgICAgICAgICAgICByZXBvcnRlZCB0
byB0aGUgc3RhY2suDQo+ID4gICAqIEB0eF9wYWNrZXRzOiBUWCBwYWNrZXQgY291bnQgZm9yIHN0
YXRpc3RpY3MNCj4gPiAgICogQHR4X2J5dGVzOiAgICAgICAgVFggYnl0ZSBjb3VudCBmb3Igc3Rh
dGlzdGljcw0KPiA+ICAgKiBAdHhfc3RhdF9zeW5jOiBTeW5jaHJvbml6YXRpb24gb2JqZWN0IGZv
ciBUWCBzdGF0cyBAQCAtNTkyLDYNCj4gPiArNTk0LDcgQEAgc3RydWN0IGF4aWVuZXRfbG9jYWwg
ew0KPiA+ICAgICAgIHUzMiB0eF9iZF9udW07DQo+ID4gICAgICAgdTMyIHR4X2JkX2NpOw0KPiA+
ICAgICAgIHUzMiB0eF9iZF90YWlsOw0KPiA+ICsgICAgIHUzMiB0eF9jb21wbF9ieXRlczsNCj4g
PiAgICAgICB1NjRfc3RhdHNfdCB0eF9wYWNrZXRzOw0KPiA+ICAgICAgIHU2NF9zdGF0c190IHR4
X2J5dGVzOw0KPiA+ICAgICAgIHN0cnVjdCB1NjRfc3RhdHNfc3luYyB0eF9zdGF0X3N5bmM7IGRp
ZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3hpbGlueC94aWxpbnhfYXhpZW5l
dF9tYWluLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3hpbGlueC94aWxpbnhfYXhpZW5l
dF9tYWluLmMNCj4gPiBpbmRleCBiMDZlNGMzN2ZmNjEuLjk1YmY2MTk4NmNiNyAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC94aWxpbngveGlsaW54X2F4aWVuZXRfbWFpbi5j
DQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQveGlsaW54L3hpbGlueF9heGllbmV0X21h
aW4uYw0KPiA+IEBAIC02OTIsNiArNjkyLDggQEAgc3RhdGljIHZvaWQgYXhpZW5ldF9kbWFfc3Rv
cChzdHJ1Y3QgYXhpZW5ldF9sb2NhbA0KPiAqbHApDQo+ID4gICAgICAgYXhpZW5ldF9sb2NrX21p
aShscCk7DQo+ID4gICAgICAgX19heGllbmV0X2RldmljZV9yZXNldChscCk7DQo+ID4gICAgICAg
YXhpZW5ldF91bmxvY2tfbWlpKGxwKTsNCj4gPiArDQo+ID4gKyAgICAgbHAtPnR4X2NvbXBsX2J5
dGVzID0gMDsNCj4gPiAgfQ0KPiA+DQo+ID4gIC8qKg0KPiA+IEBAIC03NzAsOCArNzcyLDYgQEAg
c3RhdGljIGludCBheGllbmV0X2RldmljZV9yZXNldChzdHJ1Y3QgbmV0X2RldmljZQ0KPiAqbmRl
dikNCj4gPiAgICogQGZpcnN0X2JkOiAgICAgICAgSW5kZXggb2YgZmlyc3QgZGVzY3JpcHRvciB0
byBjbGVhbiB1cA0KPiA+ICAgKiBAbnJfYmRzOiAgTWF4IG51bWJlciBvZiBkZXNjcmlwdG9ycyB0
byBjbGVhbiB1cA0KPiA+ICAgKiBAZm9yY2U6ICAgV2hldGhlciB0byBjbGVhbiBkZXNjcmlwdG9y
cyBldmVuIGlmIG5vdCBjb21wbGV0ZQ0KPiA+IC0gKiBAc2l6ZXA6ICAgUG9pbnRlciB0byBhIHUz
MiBmaWxsZWQgd2l0aCB0aGUgdG90YWwgc3VtIG9mIGFsbCBieXRlcw0KPiA+IC0gKiAgICAgICAg
ICAgaW4gYWxsIGNsZWFuZWQtdXAgZGVzY3JpcHRvcnMuIElnbm9yZWQgaWYgTlVMTC4NCj4gPiAg
ICogQGJ1ZGdldDogIE5BUEkgYnVkZ2V0ICh1c2UgMCB3aGVuIG5vdCBjYWxsZWQgZnJvbSBOQVBJ
IHBvbGwpDQo+ID4gICAqDQo+ID4gICAqIFdvdWxkIGVpdGhlciBiZSBjYWxsZWQgYWZ0ZXIgYSBz
dWNjZXNzZnVsIHRyYW5zbWl0IG9wZXJhdGlvbiwgb3INCj4gPiBhZnRlciBAQCAtNzgwLDcgKzc4
MCw3IEBAIHN0YXRpYyBpbnQgYXhpZW5ldF9kZXZpY2VfcmVzZXQoc3RydWN0IG5ldF9kZXZpY2UN
Cj4gKm5kZXYpDQo+ID4gICAqIFJldHVybjogVGhlIG51bWJlciBvZiBwYWNrZXRzIGhhbmRsZWQu
DQo+ID4gICAqLw0KPiA+ICBzdGF0aWMgaW50IGF4aWVuZXRfZnJlZV90eF9jaGFpbihzdHJ1Y3Qg
YXhpZW5ldF9sb2NhbCAqbHAsIHUzMiBmaXJzdF9iZCwNCj4gPiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgaW50IG5yX2JkcywgYm9vbCBmb3JjZSwgdTMyICpzaXplcCwgaW50IGJ1ZGdl
dCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IG5yX2JkcywgYm9vbCBm
b3JjZSwgaW50IGJ1ZGdldCkNCj4gPiAgew0KPiA+ICAgICAgIHN0cnVjdCBheGlkbWFfYmQgKmN1
cl9wOw0KPiA+ICAgICAgIHVuc2lnbmVkIGludCBzdGF0dXM7DQo+ID4gQEAgLTgxOSw4ICs4MTks
OCBAQCBzdGF0aWMgaW50IGF4aWVuZXRfZnJlZV90eF9jaGFpbihzdHJ1Y3QgYXhpZW5ldF9sb2Nh
bA0KPiAqbHAsIHUzMiBmaXJzdF9iZCwNCj4gPiAgICAgICAgICAgICAgIGN1cl9wLT5jbnRybCA9
IDA7DQo+ID4gICAgICAgICAgICAgICBjdXJfcC0+c3RhdHVzID0gMDsNCj4gPg0KPiA+IC0gICAg
ICAgICAgICAgaWYgKHNpemVwKQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAqc2l6ZXAgKz0g
c3RhdHVzICYgWEFYSURNQV9CRF9TVFNfQUNUVUFMX0xFTl9NQVNLOw0KPiA+ICsgICAgICAgICAg
ICAgaWYgKCFmb3JjZSkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgbHAtPnR4X2NvbXBsX2J5
dGVzICs9IHN0YXR1cyAmDQo+ID4gKyBYQVhJRE1BX0JEX1NUU19BQ1RVQUxfTEVOX01BU0s7DQo+
ID4gICAgICAgfQ0KPiA+DQo+ID4gICAgICAgaWYgKCFmb3JjZSkgew0KPiA+IEBAIC05OTksMTgg
Kzk5OSwxOCBAQCBzdGF0aWMgaW50IGF4aWVuZXRfdHhfcG9sbChzdHJ1Y3QgbmFwaV9zdHJ1Y3QN
Cj4gPiAqbmFwaSwgaW50IGJ1ZGdldCkgIHsNCj4gPiAgICAgICBzdHJ1Y3QgYXhpZW5ldF9sb2Nh
bCAqbHAgPSBjb250YWluZXJfb2YobmFwaSwgc3RydWN0IGF4aWVuZXRfbG9jYWwsIG5hcGlfdHgp
Ow0KPiA+ICAgICAgIHN0cnVjdCBuZXRfZGV2aWNlICpuZGV2ID0gbHAtPm5kZXY7DQo+ID4gLSAg
ICAgdTMyIHNpemUgPSAwOw0KPiA+ICAgICAgIGludCBwYWNrZXRzOw0KPiA+DQo+ID4gICAgICAg
cGFja2V0cyA9IGF4aWVuZXRfZnJlZV90eF9jaGFpbihscCwgbHAtPnR4X2JkX2NpLCBscC0+dHhf
YmRfbnVtLCBmYWxzZSwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICZzaXplLCBidWRnZXQpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgYnVkZ2V0KTsNCj4gPg0KPiA+ICAgICAgIGlmIChwYWNrZXRzKSB7DQo+ID4gLSAgICAgICAg
ICAgICBuZXRkZXZfY29tcGxldGVkX3F1ZXVlKG5kZXYsIHBhY2tldHMsIHNpemUpOw0KPiA+ICsg
ICAgICAgICAgICAgbmV0ZGV2X2NvbXBsZXRlZF9xdWV1ZShuZGV2LCBwYWNrZXRzLA0KPiA+ICsg
bHAtPnR4X2NvbXBsX2J5dGVzKTsNCj4gPiAgICAgICAgICAgICAgIHU2NF9zdGF0c191cGRhdGVf
YmVnaW4oJmxwLT50eF9zdGF0X3N5bmMpOw0KPiA+ICAgICAgICAgICAgICAgdTY0X3N0YXRzX2Fk
ZCgmbHAtPnR4X3BhY2tldHMsIHBhY2tldHMpOw0KPiA+IC0gICAgICAgICAgICAgdTY0X3N0YXRz
X2FkZCgmbHAtPnR4X2J5dGVzLCBzaXplKTsNCj4gPiArICAgICAgICAgICAgIHU2NF9zdGF0c19h
ZGQoJmxwLT50eF9ieXRlcywgbHAtPnR4X2NvbXBsX2J5dGVzKTsNCj4gPiAgICAgICAgICAgICAg
IHU2NF9zdGF0c191cGRhdGVfZW5kKCZscC0+dHhfc3RhdF9zeW5jKTsNCj4gPiArICAgICAgICAg
ICAgIGxwLT50eF9jb21wbF9ieXRlcyA9IDA7DQo+ID4NCj4gPiAgICAgICAgICAgICAgIC8qIE1h
dGNoZXMgYmFycmllciBpbiBheGllbmV0X3N0YXJ0X3htaXQgKi8NCj4gPiAgICAgICAgICAgICAg
IHNtcF9tYigpOw0KPiA+IEBAIC0xMTE1LDcgKzExMTUsNyBAQCBheGllbmV0X3N0YXJ0X3htaXQo
c3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0DQo+IG5ldF9kZXZpY2UgKm5kZXYpDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgbmV0ZGV2X2VycihuZGV2LCAiVFggRE1BIG1hcHBp
bmcgZXJyb3JcbiIpOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBuZGV2LT5zdGF0cy50eF9k
cm9wcGVkKys7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIGF4aWVuZXRfZnJlZV90eF9jaGFp
bihscCwgb3JpZ190YWlsX3B0ciwgaWkgKyAxLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdHJ1ZSwgTlVMTCwgMCk7DQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0cnVlLCAwKTsNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgZGV2X2tmcmVlX3NrYl9hbnkoc2tiKTsNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIE5FVERFVl9UWF9PSzsNCj4gPiAgICAgICAgICAgICAgIH0NCg==

