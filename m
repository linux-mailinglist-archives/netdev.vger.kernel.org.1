Return-Path: <netdev+bounces-292748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMwoFJRuGGoSkAgAu9opvQ
	(envelope-from <netdev+bounces-292748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:34:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E585F50B4
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F24F832BACE8
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227523F9F26;
	Thu, 28 May 2026 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pj4Oc23X"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F612E738E;
	Thu, 28 May 2026 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779983326; cv=fail; b=sCNEsq2adarcgaSbUncD1ZusUvQRof+OZOJYr3H2KkoS7NDa131ta6O2nJpsOeia+LoenIt6Ad2Gpz75IULFFxVRGN3RYG6QyQCvw+OkFBZ/JQc3jmavXx/QL4Ng0WpsBM6ghHf9Tyag4K67963WeEOeN/lQnCcVR17Zq3jekso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779983326; c=relaxed/simple;
	bh=UEmfQmAjpqyssEBCTEpLWWkP9D/gbQXhMIOxnCZxpr8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gatOu3VJ3QgMgiHqy7blurwi6u4CH6/xPprNfTXpZ5nPVWO8MP7B7eZLO/fykzHKaLgBg+A2QF5ouQ/fgPxsMSohyjLzgLnMDaPJ6soZnHv6fqjOivf0aBewyBcZOWdNvT002LWNw6mTzDqlrrqSa7byh23saijvy1OPWH2U/6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Pj4Oc23X; arc=fail smtp.client-ip=52.101.56.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eaP6jerhiH784q0LxNb2Dd9P5uRZAjrg4A3u4EEkhwylz6bVZpFc6Oyx2QAp/8KDNjAuM6/+DEfE5Xe0ZW5N07Dtr0XNuO7eJqnc9FA3ggCk8uMWDQBr7BAZpCpNsg+Nf6cSzIS6rUoRyThZt42RPF/PPQqiedRStEfRX5FBB5IGBmnSsOz0VzAYnHwS9oXLJ6FwTWCrZTgeIlDTo61TNeh3uBnVDGaGSw2KXS3+gpKpC8WwQqKlMhTZM0nUUxWQWzY29/SbF6Fci7nlyY58hvUJh/K4hs5TvfMKCqZUJd8YQ1hKKi53zWNKGHR/xquUtg8BkJ9oCHN8B/AfiOlLeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEmfQmAjpqyssEBCTEpLWWkP9D/gbQXhMIOxnCZxpr8=;
 b=vm6y9iq1sEENWzEwkfZ1/3ZevMYT6BTv4A76eK3Tvb+joJE9/wvzewWrCQe/VP8IVDduPjwvzLx2LVqihYJAFprn6RtQtVO12U67dCRCJEAlgEL9lY2WXQTBdjPSLbaK9DacyThD7kN+7ABZlIHhaW7j9wI1+8+dDsjIMLxS+tGdwd72QT6G5jg5sIbpTKEg3cmDdy2bM9HoVSxBf9Qb2dn54vY8/juENHtNLQWLsgPsC4r3JcST/MF6AHf0cZbv+Bb/eYF8QPtg7t8cBVIlG+nWpFYWMihksx20NlrOZo93O31dZfa9BV8Q0xurUDPY/BQIq4RLcGzDimMWH1UqjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEmfQmAjpqyssEBCTEpLWWkP9D/gbQXhMIOxnCZxpr8=;
 b=Pj4Oc23XJWI/8D/vSTpXCuLXjTjTM8wanYzVCCtf8ABAjTogWe2sBPqWNi74wx+TFNTb5yuKZ+JS8vnk08pmfd3F5OgbffbAzbpnJb05dxLwWlhJ0zc45q6BM0v/oMLBlxxX9Uhsc80iG+DfIMduH0TnHjfhyzZrJmktvvsbsT+wnRQfBR7yxWqua6sVEXyF0jD0Xn7VP9AEJTpTrl9W1S9FA/hff9Y63z8dl/wmETwDxTorW2g5AiqM0mFupSurBy+G563B+UY/C1hYs0cTBUNlPHJapv4Gw6TujJW85arLa65ywVT5RlYjHEyPCL5qJnXZpSQkDgeLvAHYnOsusA==
Received: from SJ0PR12MB8113.namprd12.prod.outlook.com (2603:10b6:a03:4e0::20)
 by CH3PR12MB8306.namprd12.prod.outlook.com (2603:10b6:610:12c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 15:48:36 +0000
Received: from SJ0PR12MB8113.namprd12.prod.outlook.com
 ([fe80::fe5b:a71d:fca1:fadb]) by SJ0PR12MB8113.namprd12.prod.outlook.com
 ([fe80::fe5b:a71d:fca1:fadb%4]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 15:48:35 +0000
From: David Thompson <davthompson@nvidia.com>
To: Jacob Keller <jacob.e.keller@intel.com>, "bryan.whitehead@microchip.com"
	<bryan.whitehead@microchip.com>, "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 2/2] net: lan743x: avoid netdev-based logging
 before netdev registration
Thread-Topic: [PATCH net-next v2 2/2] net: lan743x: avoid netdev-based logging
 before netdev registration
Thread-Index: AQHc7gVeOk4v2XbPA0OOSJuMH/uSO7YiU9CAgAFCo1A=
Date: Thu, 28 May 2026 15:48:35 +0000
Message-ID:
 <SJ0PR12MB8113A180BD6127BFB11A612FC7092@SJ0PR12MB8113.namprd12.prod.outlook.com>
References: <cover.1779903597.git.davthompson@nvidia.com>
 <8909217245395f6418cdc2699147511c443085e4.1779903597.git.davthompson@nvidia.com>
 <a0bc4a6b-612a-426f-aced-205c6db6602c@intel.com>
In-Reply-To: <a0bc4a6b-612a-426f-aced-205c6db6602c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8113:EE_|CH3PR12MB8306:EE_
x-ms-office365-filtering-correlation-id: 0b97f8c7-d7b5-403d-47eb-08debcd09425
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|38070700021|6133799003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 ZzsBDkTf5Yd554CByBB9NRbcfPVjrO+a+Q0lWN+gr3sc6HyGOhbLnDS4Bg42Pe8FpGkYwt3Y0GWK8+UpTvaCe/S535Xt9A2INufC79cqjsuq8YLYcRO5LMBish2kRFbR/pyTHepCxanqzAdAzLJGiG4JTBpce0oAfIC90L9HC9Jnx9BcRf9iN3m2hz+60jVRDDjaRT0XlwldVxHCcHC6WuaWScgo4XnmUHwf5XSdQLJnF5RAu61620jTzwQH8NIhEqrgur7pmrhx6l7+43gLbSPLdEO55qv06h9Nlx4I2wcHLKynw1dJ0JAB5HjG8dH40DVT/9X+UFa7a3Mvao71aSr5usQoMch1NrR5CuiYV5gdE3Z5lDkNlOaSv2sq+1H/1Ids1pQZqUHxYu8e8jHknJ2ntUav4Ffr8jzoHSYh79Zm+peWG1eCQVZ+Ex+mxHzRC55i42e5YJoE98m01ms/e8Hheeg0ezAsvYOomqM4wqY0SOFU8uwLD+Fl0HlpOIU5Xf8Rr40GhSMwtV2zaaCcVd8T+qOtfYa/FpAMg+HEwfdZVpxIIoDv4DD99euWtTB6CJGlnIET07ToGILngq2KXepCCaA9vgicH+6coq2IWYQgZbAtTOPKqbGU0BLrk9K14aQBmrUMnvIv41SgjDgtJjooPFoU9UX6YRpcBUwVAyTOSPCSQ4ib+GbSl1rkf1Oq+HjCAD3ja7lxie5LsbQRJsdrrURIhSq0rrPXGImToEiBUE5ig0AzOa8pqBSqqw3z
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB8113.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(38070700021)(6133799003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ni9KSU1GMmprdjY0cTJGZ0lCVlkxZUI2RGF1anlDamVVdkZLR3l6QmxFY1BH?=
 =?utf-8?B?RHhEbmV1MlYzc2NkbW1LbVFLOGY4eng0VG5hTWg3a3hqOFAxOE5PU2dHV2g2?=
 =?utf-8?B?VEVCSEFhUXhJbVREUzVuUVRGMWNEQ1RqeEZ5THRQR0ZJV0xURzlSZHdwbC9h?=
 =?utf-8?B?NnppdnFIb013ODVrbXROM3ltZkRYWnRaQStKNnMwU2F6T0NVY2VmSWRnQjhs?=
 =?utf-8?B?dDMxUU1pTDVWNWdlY2tOTUhjaUN4Mm5HR3VqZCs1R3NNYUFSbldyeEpNMC9s?=
 =?utf-8?B?Y1NjdHJNdWdycGNuaGp4OExYUndzbXBJMUhUdG5hdThYNnIwSDI2VU9ISXZY?=
 =?utf-8?B?MTBndkJuNDBrcVhKRU5tSEZoMnBVczJCOHRXMnNPMlhmdU4vZ3AzV1dIQ25m?=
 =?utf-8?B?bW9ld2ZSMFZxcjdxRmhIV2F4WWwwbk5nOWttTGxDM2JEYmhJUXJEb0Voa3Np?=
 =?utf-8?B?bUZmcldzRUwyT1Q5Rmo3NzJ2U3BOVmRVb1lDeHNJK290UW5sRmVDTWcwOWQ3?=
 =?utf-8?B?UGhKWk03Q0dJb1lWSEZERG1JL0J6akpQd2V1SjZGWXA0a1pTMEhsclpVdTVy?=
 =?utf-8?B?R3RzK3JaejVRVHo2MHQ0OGdIRWt4UHRDb0J3Mmt1T1hJSFZkOFRjZXNtTWRa?=
 =?utf-8?B?enc0ejkvTVc0eU93d0xoL1ZXZG1ESXhNTmFEb0lVaGlnMS9DdEx3MXNwbmZx?=
 =?utf-8?B?bk5pVThyd3ErcjJkcnhVeHR2ejNxaStmWnpWUmxOV2F3eklsWWRsSllRUDJH?=
 =?utf-8?B?dDhrWEd0MXdtWFFZTWQyMGRDbUx5QVdwa0RhTk9kaVBDV3JkRUtwV2NHcG92?=
 =?utf-8?B?L2FYUVNzQThUVTZ3cGZVNHRpbVEvV2xkSXdjZVRaRlF5YmFpOGk0cFg1VUow?=
 =?utf-8?B?V1hwaXZ3dVRGMmVHbTYzaEFZMnIyK0NvNGdPZEVodjFiM2pGTDd5d0VkekZU?=
 =?utf-8?B?d3pFQVZCSStURTk5RlVDbW92L1pLS3JHWGZ5MjRoU1F5aFpPemwrZ0pKb3A0?=
 =?utf-8?B?VFZvR3JVUWVjUjd5RWt2K0dQdDAzdEprVTlUNUppSmFZK1hvRDVxNmtPSTFm?=
 =?utf-8?B?YkxNS2MzdHRVSzZ3NGtJc3cyMk9jZi9iM1hpbGFwSUlBWEFBSGhJRDdNZUpy?=
 =?utf-8?B?V2hGdnVLRVB4S1hndmpUakJWTHlKYktiZnBOcTVuSFZYMmcrL0o3SXhSTGlw?=
 =?utf-8?B?VXlzM0FIRTB1aFVPS2p6aWlZQUk4bUc4K0xoeFBuY2JzK1Z4RVJDWWgyaGVR?=
 =?utf-8?B?YWpxanc2V1B0U3RBbmc5UVFxQVhVK2xwMUtXWDJsaG1wWUplaHY0dFh4UW5Q?=
 =?utf-8?B?enBENE5ycm1VWkFzSXQzZW5jM0VGaVJtV0VDTTdZbHVlNDlWU0hITW1WN2o3?=
 =?utf-8?B?M3BzRmRBYWI4dDBxZUE3RUxWWmZVR21rQy9Rano5ZmpTRHhwNWlCTTYzb293?=
 =?utf-8?B?N2h0T2FDRmRWSy8rTEFpOG1EV2dWQ0hFcG1nT3lIZ0RRMHBzTUVXbzlqUUN0?=
 =?utf-8?B?V3FRNHQ4NC9VWUxHVUhCVnBSRFNmTFFrNWo5d2hsSzZ2aEZpMHl5VkNjSi9D?=
 =?utf-8?B?K200N295elE4RXh3SllOaXE3dGdGTjhmME9FOWtNTGlXb1BHVWo4L1kvUXBF?=
 =?utf-8?B?aUR2YzFFbk9TVE90MnVoYjFtY3d0RTF6dmJ6NmZBRkNyM3dHZVV3OVR0V3lQ?=
 =?utf-8?B?bFVoQzlDRFZ0V1ZHd1lnekdyOVJ0SWpOTXM3ZmZJZnFRbFRFQVgxRGU0Unk3?=
 =?utf-8?B?Vllqc3pFcEZnUit4S0JRM1FQaHRTbUg1SHRKWk91LzNlcyt6U0ZuUWF0dzB2?=
 =?utf-8?B?K0RnbXZLMU1yVFlFOWNMMFRoeFc0MWF3M0N6c3ZDSjdrZU1yNlZDU2IwdjFv?=
 =?utf-8?B?UDFLdXk5L0NOVmovbUpaV0oxOU5HR0ZFZnBtR0NqMjdDUlJHRzAvMWZtc0w3?=
 =?utf-8?B?RHYyWXgxcXVjQ0hqYW5iRzV4cFdmaElHbDJ3SFNWY0hRb0pyNjhRQ3lWTzNF?=
 =?utf-8?B?bVl2TnVuNFREVkRUS3YwYVE1cnlMS09jM2d5VUVRMUppWFp2Qlp4c1praWFS?=
 =?utf-8?B?MEh4UEdlbjJhcmt1ZW9FRWROOWJDRjBmakpQZWEvU1lPamlqekQvZWs4THll?=
 =?utf-8?B?VGlnWlRVVVVYRXBmQ2xYZG9FeW9rdTlYYXNUV2R5VVRtcTAzaHpQOU5vcUFl?=
 =?utf-8?B?N1pZSjhSOEl0ZE1qL2REdGxDQm1vK2J2YUxicDlkMEYwUm9KYWEycGJsY0NE?=
 =?utf-8?B?WXVHU0RMNm4rempEeFRhNWVMcC9oVGpaVkFSRUtYckZtaG90RXllSjZ5TllZ?=
 =?utf-8?B?aTY2TFZnRjZaRVh2MlkzVmlVTjN0dUNBVlhWRFcvQ0p2Mnp0MEpTZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8113.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b97f8c7-d7b5-403d-47eb-08debcd09425
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 15:48:35.7555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q0karmLu3f4im8q3DrIVetDwTvyxRdwnjdzOlNlCP6I9YeYfFcinL6LwCV6UPlNZxs579gQOy/FvAzC1e967bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8306
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-292748-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davthompson@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,Nvidia.com:dkim,intel.com:email,davemloft.net:email,SJ0PR12MB8113.namprd12.prod.outlook.com:mid]
X-Rspamd-Queue-Id: E5E585F50B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFjb2IgS2VsbGVyIDxq
YWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDI3LCAyMDI2
IDQ6MzIgUE0NCj4gVG86IERhdmlkIFRob21wc29uIDxkYXZ0aG9tcHNvbkBudmlkaWEuY29tPjsN
Cj4gYnJ5YW4ud2hpdGVoZWFkQG1pY3JvY2hpcC5jb207IFVOR0xpbnV4RHJpdmVyQG1pY3JvY2hp
cC5jb207DQo+IGFuZHJldytuZXRkZXZAbHVubi5jaDsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1
bWF6ZXRAZ29vZ2xlLmNvbTsNCj4ga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbQ0K
PiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0IHYyIDIvMl0gbmV0OiBsYW43NDN4OiBh
dm9pZCBuZXRkZXYtYmFzZWQgbG9nZ2luZw0KPiBiZWZvcmUgbmV0ZGV2IHJlZ2lzdHJhdGlvbg0K
PiANCj4gT24gNS8yNy8yMDI2IDExOjE4IEFNLCBEYXZpZCBUaG9tcHNvbiB3cm90ZToNCj4gPiBU
aGlzIHBhdGNoIHVwZGF0ZXMgdGhlIGxhbjc0M3ggZHJpdmVyIHRvIHByZXZlbnQgdGhlIHVzZSBv
Zg0KPiA+IG5ldGRldi1iYXNlZCBsb2dnaW5nIEFQSXMgKHN1Y2ggYXMgbmV0ZGV2X2RiZykgYmVm
b3JlIHRoZSBuZXR3b3JrDQo+ID4gZGV2aWNlIGhhcyBiZWVuIHN1Y2Nlc3NmdWxseSByZWdpc3Rl
cmVkLiBVc2luZyBuZXRkZXYtYmFzZWQgbG9nZ2luZw0KPiA+IHByaW9yIHRvIHJlZ2lzdHJhdGlv
biByZXN1bHRzIGluIGxvZyBtZXNzYWdlcyByZWZlcmVuY2luZyAiKHVubmFtZWQNCj4gPiBuZXRf
ZGV2aWNlKSAodW5pbml0aWFsaXplZCkiLCB3aGljaCBjYW4gYmUgY29uZnVzaW5nIGFuZCBsZXNz
IGluZm9ybWF0aXZlLg0KPiA+DQo+ID4gVGhlIGRyaXZlciBtdXN0IHVzZSBuZXRpZl9tc2dfIEFQ
SXMgYW5kIGRldmljZS1iYXNlZCBsb2dnaW5nIChlLmcuDQo+ID4gZGV2X2RiZykgdW50aWwgbmV0
ZGV2IHJlZ2lzdHJhdGlvbiBpcyBjb21wbGV0ZS4gVGhpcyBlbnN1cmVzIGxvZw0KPiA+IGVudHJp
ZXMgYXJlIGFzc29jaWF0ZWQgd2l0aCB0aGUgY29ycmVjdCBkZXZpY2UgY29udGV4dCBhbmQgaW1w
cm92ZXMNCj4gPiBsb2cgY2xhcml0eS4gQWZ0ZXIgcmVnaXN0cmF0aW9uLCBuZXRkZXYtYmFzZWQg
bG9nZ2luZyBBUElzIGNhbiBiZSB1c2VkIHNhZmVseS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IERhdmlkIFRob21wc29uIDxkYXZ0aG9tcHNvbkBudmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+IHYy
Og0KPiA+IC0gQ2hhbmdlZCB0YXJnZXQgcmVwbyBmcm9tICJuZXQiIHRvICJuZXQtbmV4dCINCj4g
PiAtIFJlbW92ZWQgIkZpeGVzIiB0YWcNCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9uZXQvZXRoZXJu
ZXQvbWljcm9jaGlwL2xhbjc0M3hfbWFpbi5jIHwgNzINCj4gPiArKysrKysrKysrKystLS0tLS0t
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0NSBpbnNlcnRpb25zKCspLCAyNyBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb2NoaXAvbGFu
NzQzeF9tYWluLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21pY3JvY2hpcC9sYW43NDN4
X21haW4uYw0KPiA+IGluZGV4IDc5MzYzM2NjZWQxOS4uYmNhMmYzZDFhZDQxIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21pY3JvY2hpcC9sYW43NDN4X21haW4uYw0KPiA+
ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21pY3JvY2hpcC9sYW43NDN4X21haW4uYw0KPiA+
IEBAIC0xMTksOSArMTE5LDEwIEBAIHN0YXRpYyBpbnQgbGFuNzQzeF9wY2lfaW5pdChzdHJ1Y3Qg
bGFuNzQzeF9hZGFwdGVyDQo+ICphZGFwdGVyLA0KPiA+ICAJaWYgKHJldCkNCj4gPiAgCQlnb3Rv
IHJldHVybl9lcnJvcjsNCj4gPg0KPiA+IC0JbmV0aWZfaW5mbyhhZGFwdGVyLCBwcm9iZSwgYWRh
cHRlci0+bmV0ZGV2LA0KPiA+IC0JCSAgICJQQ0k6IFZlbmRvciBJRCA9IDB4JTA0WCwgRGV2aWNl
IElEID0gMHglMDRYXG4iLA0KPiA+IC0JCSAgIHBkZXYtPnZlbmRvciwgcGRldi0+ZGV2aWNlKTsN
Cj4gPiArCWlmIChuZXRpZl9tc2dfcHJvYmUoYWRhcHRlcikpDQo+ID4gKwkJcGNpX2luZm8ocGRl
diwNCj4gPiArCQkJICJQQ0k6IFZlbmRvciBJRCA9IDB4JTA0WCwgRGV2aWNlIElEID0gMHglMDRY
XG4iLA0KPiA+ICsJCQkgcGRldi0+dmVuZG9yLCBwZGV2LT5kZXZpY2UpOw0KPiANCj4gRG8geW91
IHJlYWxseSBuZWVkIHRvIGNoZWNrIG5ldGlmX21zZyBoZXJlPyBJIGd1ZXNzIGl0IGtlZXBzIHRo
ZSBsb2cgZnJvbSBiZWluZw0KPiBjbHV0dGVyZWQgYmFzZWQgb24gdGhlIG1lc3NhZ2UgbGV2ZWxz
IGVuYWJsZWQuIEkgd291bGQgcHJvYmFibHkganVzdCBkbw0KPiBkZXZfZGJnKCkgZm9yIGFsbCBv
ZiB0aGVzZSBhbmQgbGV0IHVzZXJzIHVzZSBkeW5hbWljIGRlYnVnZ2luZyB0bw0KPiBlbmFibGUv
ZGlzYWJsZSBwcmVjaXNlbHkgd2hpY2ggbWVzc2FnZXMgdGhleSB3YW50IGluc3RlYWQgb2YgdGhl
DQo+IG1lc3NhZ2VfZW5hYmxlIGJpdHMuDQo+IA0KPiBBbHNvLCBzb21ldGltZXMgeW91IHVzZSBw
Y2lfaW5mbyBhbmQgb3RoZXIgdGltZXMgeW91IHVzZSBkZXZfaW5mby4gV2h5IG5vdA0KPiBiZSBj
b25zaXN0ZW50Pw0KDQpUaGFua3MgZm9yIHRoZSByZXBseSBKYWNvYi4gDQoNCkkgd2lsbCB1cGRh
dGUgdGhlIGNvZGUgdG8gdXNlIGRldl9kYmcoKSwgd2hpY2ggY2FuIGJlIGNvbnRyb2xsZWQgdmlh
IGR5bmFtaWMgZGVidWdnaW5nLg0KDQotIERhdmUNCg==

