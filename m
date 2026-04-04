Return-Path: <netdev+bounces-275309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gN5KC+pa0Gnd6wYAu9opvQ
	(envelope-from <netdev+bounces-275309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:27:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1BA39952A
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A49D300F79E
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 00:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C7F23BCE3;
	Sat,  4 Apr 2026 00:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VHZh8exw"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011062.outbound.protection.outlook.com [52.103.14.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38E724DCF6
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 00:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775262422; cv=fail; b=fpPKaOG9Dc/+CiIPxYh1JHusdyN2hpCJJwpa+Y8QJym1mIQ8crNxjfFbaw2XYrKjaCiRF25GPhTDsXl5pHsJbPeQiPScGDSsFPVOCLcL48NYrjgxL1k/ny91rn7vODLqY1+zNEF5WzH5N/F+EecGEffBmjOrMEu8t6r/LtqRggE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775262422; c=relaxed/simple;
	bh=8oHxui/f5hkQePsGKyhncKIGVbhpdtEcPmSs6/0RSvE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=k/+/CQaS8LQMrM43h5vbm+VdaImNX3NS52bcryaZLBOZi9L4edzx69Z4s9bJ8mrlWsQOmzFEss8jjOgmTOeYRYVXk1A0j2oWjRbLtj4o3cez/cx1yUFaKD2xMEJSBuUHgT5fbJaNJOk2z/5p9M6wQWge8X7izQQp8gylmqbvENc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VHZh8exw; arc=fail smtp.client-ip=52.103.14.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJyRw6vFVTfJ5vRHcALkdarPnrTwAEdwU53ldfLE40vloOBTibjJDpp+U+et31NfU6wfdzxnknTHttnDcUaj+ZnU4wRGlsl0e6Api5tIL2C4xoKYsZd8SsCeo9BrRkC7AJLe2SpEGnZWUCyq9Rev+1bnhFcqcp8ozgHUihLvLNdQYjNwPk+zxEg5Wqo7ecZaJeBTyoVRYfQWZ1tmifOMuXSZ+MR8L1ifh4r/lVActxzKhcrKPPb/tMQeCd1y46wkv+aWF6zmo/Ln+3Wt7iBlrSl7g0l7yHY7/XKTroMQ3sWOvP5SYKpimsWJE82kaeLBJpeUbjDXk7mxhePOpdZMFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oHxui/f5hkQePsGKyhncKIGVbhpdtEcPmSs6/0RSvE=;
 b=IitmJ+CblHOH9gf/FjknE6tWU1UFsUpUukvunWbB2+1Dbf/XD5+bNjIex2J7AvjW2J5GJJMg60awLDChJIUKc6pb62YzK+VYDz/Etzuj5nvoIB0UsuYfLSpdlguU5rNmp8Cjgex2CDPTzxM35An5qyJhd1jNnF7iBjEUaCuJQGSQPRGqazinoFUzsSLMiYjZL9ukfFlQf8MpPoLAvaYU7Pv6VKAI5xzwbvVG1i/cb7AW4jZxy2hUdh7tiMoDOzxTuKmLBY0nXEoh9LhywALX8/jvPTnB1SXKYTS1eG+Vqmz/VuU+CMXSuehDvgPW6iHKAxDXYPR0Gp1ibPcyusTGig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oHxui/f5hkQePsGKyhncKIGVbhpdtEcPmSs6/0RSvE=;
 b=VHZh8exwFS7grQZ6H9VRxKE7JtKvoGiIP/HbWRe673qKKuh2Td03lM/aD2pLsRnn0VufN3awsrgbTewNBTph713ux79xw78ov4qxyJ7uKZdBPygw5aUeVjRVsrRviwgw1BSdlukf/tl04jZLpGoN/Cb5lJSM3qUOqU9SlF1HbR9kHYVys/PHeegkieGrJpFD+uOhUconWNA7tI7OjZKwQvWfdNyx/MEtGX6Uv3vv9Y3XIYRaeCEd2m13bPgig33jtNeUh3T/yQse5zwyztxBn4YsgdQeCGmOGNtiqhvHzcr93DWndYeRiDabWtb4m/g9wsKSqu2Mc5CQpDKkXP/gLQ==
Received: from SJ5PPF8C7834C85.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7b6) by IA3PR10MB8369.namprd10.prod.outlook.com
 (2603:10b6:208:582::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Sat, 4 Apr
 2026 00:26:58 +0000
Received: from SJ5PPF8C7834C85.namprd10.prod.outlook.com
 ([fe80::381d:ee2b:4859:fdff]) by SJ5PPF8C7834C85.namprd10.prod.outlook.com
 ([fe80::381d:ee2b:4859:fdff%7]) with mapi id 15.20.9745.034; Sat, 4 Apr 2026
 00:26:57 +0000
From: Main Frame <framemain@outlook.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>
Subject: nfc: nci: fix OOB heap read in nci_core_init_rsp_packet_v1()
Thread-Topic: nfc: nci: fix OOB heap read in nci_core_init_rsp_packet_v1()
Thread-Index: AQHcw8musGqBqndNJEKRnQLKPZe5Tg==
Date: Sat, 4 Apr 2026 00:26:57 +0000
Message-ID:
 <SJ5PPF8C7834C8532643B67AAD74B657ED1AA5FA@SJ5PPF8C7834C85.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ5PPF8C7834C85:EE_|IA3PR10MB8369:EE_
x-ms-office365-filtering-correlation-id: f962ddfa-a2a8-424e-57de-08de91e0e177
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrPy8Gg0T1tV+ubdyTLMpos/DH9WFDGryFZD5e/OkFz4LnNAvZm1YbLTQlri8vp4JZvfh+3/+5kCcqh94MrdDmT+i2K5hU4FnTVjea2ClwB5XjZmCNQpunO8N1u5ik08B6YHfVdwLicFpG2G7GgAYdbQtKEymsm5IMJ9j79tbkpVV6NNB1QoYHrFLIYVLzoG35/0uEOm6jYkZIMrVYehIXbbN0RbB8xoT5B14gwL035bkl2iYnUEfhCLkAWJ43KrT+MF+T2K29P8a7G72f0oxyJcVlXQzLI8sC13T6PZZLpGMjTGU33aygQxMx2Y88Zi7wb7yBQec2DBkGnvIFFD/PtYU7V2YzD3NhZBqlN486W43WWiCpBCgMgHwELcJJZG6y07odecm2tIL3ypamE06Frurwu9refxGj9hO5kH0m5GC5o3jS6tuABCkONpm1IJIkpsj83FD8cOGGgtGm+y45k5MRRPcKifXWPymRigQPo5+tqCIfqG5Izr4qcH0dUmxJS7dipYAFEL6Hj0y32NLmWf0KWrbhqyD8U1QvHtKGb7wiqDxuulPGzspouWAPyv49AAVohsl8/PIwh+38rzZWFsXpuDPhp1jnl1EQFpazaHLiV0CVV3FnqIOnHauBbIWtDvPNR1pXsX7184VjUCWWBjgiWbBUcM3PrJswJpce/RUvZL4dTn81Mybwt77Y0+91VPd6P3zdsCnMqjtGJJqAfcH7v8z6bDRDwnMPMr+AdSSZjxEMDpH5mhXbOE9HnG2p8=
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|51005399006|15080799012|15030799006|461199028|31061999003|8062599012|8060799015|19110799012|7042599007|12121999013|26121999003|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?SiHOkwFNNM3wEIAD1JWdRTY7Bp9AdzQsBZFOV35neAsdvud8qnCnZ/wKMH?=
 =?iso-8859-1?Q?ixeMYDwW2nzYrCjT7em5GwAYuH1KSGUkUW8xP/W7SAxpmRjHlalIn9Lj1i?=
 =?iso-8859-1?Q?BxvGGNUA2E9jgLcIALZXigZJoVB5T4jlcRfawDvqwqvlqUzLvChYEkOHIE?=
 =?iso-8859-1?Q?VpmYuWIPwvvmL4XP3ZIZ+VG/SSWwcRM3cmLTgwqbCq2aMkLDMEN97ybFcb?=
 =?iso-8859-1?Q?rnGiGGU82MAzqBPB9XGCYmjMY4armX1kjuF2RNXDUxhHwnTqxwf6KTvzQ9?=
 =?iso-8859-1?Q?ocS3OhiutxxE0MB6ahSJ7ZK82nNCMac3sNKeBEXVaqiL2XLkQzdWcHaHFy?=
 =?iso-8859-1?Q?iPp9SGDAe55OrrugNMnHJ85qeh9SmKP1Ekenl+jnRX1X2kUWS/Q3QIZJe4?=
 =?iso-8859-1?Q?uHNfpiiYh8DclaPfZro7m+nFq9b0DH4yDN6wUIGbw32kPwu24TfjMQRYFx?=
 =?iso-8859-1?Q?EEYTbAfUA4WSG4lVfdHAjhDWTVAGSk6/nyLAv9+jnaPx99CAdX4rEHNckM?=
 =?iso-8859-1?Q?tde91yuYliVZyRvQKyAoGtQ2zlHgyC8ivIMe/kNhqnVGc4hz+jdVtHiLoT?=
 =?iso-8859-1?Q?7X7OKQxVjib9v32BGqAsj50Gz7B3l1MGzRNGp0Zm4ykSVTz1cHDppty6o2?=
 =?iso-8859-1?Q?+dBGFxFBDG7LrtgBR+ARhSreo1gneejA9qBlMnTqx2SR2UvQ2rmFm0anpI?=
 =?iso-8859-1?Q?2bvR9xmRkn8DbQ6kRMVgq2EImfypdYxNInyFSc/CGSf4TuyegHzqpM68iR?=
 =?iso-8859-1?Q?BcBpOW2SbeGE8ze4RbEdlWWahjWI9ZDHzJHyff8EwJVkqbnYDKhO7fZagL?=
 =?iso-8859-1?Q?2aekaFK8Dc+VY6s6B9tfWxxxcA9JheX9F311mw/DSOqN61HAR8xBDzmm8w?=
 =?iso-8859-1?Q?ao86jAAMi8yHQ6uQ+4T//6A4Y1GqxOiBQkgAsMUprXfmKSRdG7XeRRcYPb?=
 =?iso-8859-1?Q?g02UC4+3/k7Yg0RVYMj0kRgZu5kmdFEuJw8xcolFWqTQ+elAPTKDkzUpwO?=
 =?iso-8859-1?Q?u1Q0bOlHe/mn+R2KVlAyCs61Yji9v6JIyasUJ3rHdea7RyQc+yh5LcDfT7?=
 =?iso-8859-1?Q?Ty1dPrJEaEZ8XUbMzgPkkkL7PldPJIcBbciCA++o1DcH?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Ik3QWl0qxCY8CjLaaxlTcFhBxO4y6Lo7banwpRhaCZ2ZkKG9igyh3aM+l/?=
 =?iso-8859-1?Q?NtoabmVpod8J9giRtjT1jSRHDhRZ9YwoMdKukGXyJoTlILGsaUsCSEWT7Y?=
 =?iso-8859-1?Q?Bcg/ZPUsdhrXpl80ltu8VBCHlrz8NCXAMdxq6bUgr6pX3gOsUkqb3nGQEh?=
 =?iso-8859-1?Q?0nlCkp2emjzLJQFKKLdpS0pPJUdDD5rkR29cjCJ5tr3dVsMD/U0k2E6nW+?=
 =?iso-8859-1?Q?L8YARZiwTxiD8FfzwHVYAIC1EOen2hxvClSYfWr9Y4attJVZNOIZk0kBDv?=
 =?iso-8859-1?Q?vF58CNjEbWRkok3UpXGvMGd7USD3C7AGGHp14Zy3/qCJ4gCvnNrG31IUPa?=
 =?iso-8859-1?Q?4vs74MKmhTlUxrP5OMbyGxVY3voLfHsrjWVFH8ElBfvWvW/35O5p2C9Uyh?=
 =?iso-8859-1?Q?3qawstBS5oIluCwY/LwmsYPpZieo8GFWEjjwob8L42YDZMCYgJaX4xhVL1?=
 =?iso-8859-1?Q?fKS5RfLkAhgJnbKu8hHX90dJEX5Crq5+OBxrph9U3bAlLKq48hy6iD9UvY?=
 =?iso-8859-1?Q?jMp3R1gGS2n2wJ0l9ha6hXWXmKXaEGcPUG1+kuaH4sxP6gH6SffU3j/fPb?=
 =?iso-8859-1?Q?GuCnUx/B7d4uYoJWTtTTfMkdkznDnVIqiOO8LTQiv64E8ZIK29xeHim6AJ?=
 =?iso-8859-1?Q?E4R/Hl21WclLaNuwciPEYcPNQrlalzqTOfjIdimaTxx63XfNa2PJILspSc?=
 =?iso-8859-1?Q?+pbq+DOs1B2MF+xzjou52osg1TWxCAcvQRMfxPaK0I/ODTSPjZeawftZGz?=
 =?iso-8859-1?Q?9O+WrXv36V+swv3vcaax9A7/Do7BBiMbC0J3cVYV33jS/g7NT6tpBWjccw?=
 =?iso-8859-1?Q?VLz+r1Z4vj8T/3aRm2CAEBCmflsajOMhsitdKoluLTKBlZMOirg2qdQ9hs?=
 =?iso-8859-1?Q?N3kw0NNmVHasP2aEI85cDbOhbCis/iJs/qk4LGhsP3Fs0jakR1jsk21ipt?=
 =?iso-8859-1?Q?zupdHOcbwi1zWQLGlonJrc8VzvF3E4F/+oOjxQ8IBRPQ17tLVHxaSCTpy0?=
 =?iso-8859-1?Q?lXm82YEkevImFkYOcY7wJId1TGb9W1EdSPWwTI5F4BRZ+gEUGtWEoT708H?=
 =?iso-8859-1?Q?6JVz5DhFZhXIZuozAAQH5H30gPWVDd9ZTwsObl3hYUzdyt47ShW64V1G4i?=
 =?iso-8859-1?Q?rFVoTL7jmmryC9TIUsmdK3sASbiuUczbxw7DEGObr7476FYhTl6Dey/0Xt?=
 =?iso-8859-1?Q?CRzzcE1doZOz7s2C/AvHV3l/YmZVSdpKAW3qNZXfxo+nAf8IpsTFrCOWc/?=
 =?iso-8859-1?Q?h1NbBVL9bgYgH6EP5d6r7z3nwSXgY3VjKoS2+NXA4IBgzR+6wJnzffrjNA?=
 =?iso-8859-1?Q?7K4NdIR5IJP09NcJ4BJeqYDx/oIfP0mPL978pjd2n5m7T2Xy8XkcSB+xEJ?=
 =?iso-8859-1?Q?yk2Rb8RtXPsAS2rtBdkJKSL2jtEpmItzBJk0tRChA3OGc3gnb80Jc=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF8C7834C85.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f962ddfa-a2a8-424e-57de-08de91e0e177
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2026 00:26:57.4525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8369
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-275309-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[framemain@outlook.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 2D1BA39952A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

=0A=
=0A=
=A0nci_core_init_rsp_packet_v1() uses the raw chip-supplied=0A=
=A0 num_supported_rf_interfaces byte to compute the rsp_2 pointer, but=0A=
=A0 the preceding min() already stores the capped value in=0A=
=A0 ndev->num_supported_rf_interfaces. =A0When a hostile chip returns=0A=
=A0 num_supported_rf_interfaces > 4 the memcpy is safe (capped) but rsp_2=
=0A=
=A0 lands past the end of the skb, and the fields copied out of it corrupt=
=0A=
=A0 nci_dev with data from adjacent kernel heap.=0A=
=0A=
=A0 Use the already-capped ndev->num_supported_rf_interfaces for both the=
=0A=
=A0 length check and the pointer, making the relationship between the two=
=0A=
=A0 explicit.=0A=
=0A=
v2: drop intermediate offset variable, check skb->len directly against=0A=
=A0 =A0 =A0 ndev->num_supported_rf_interfaces + sizeof(*rsp_2) (@Kuba)=0A=
=0A=
=A0 Fixes: e8c0dacd9836 ("NFC: Update names and structs to NCI spec 1.0 d18=
")=0A=
=A0 Signed-off-by: Lek=EB Hap=E7iu <framemain@outlook.com>=0A=
=A0 ---=0A=
=A0 =A0net/nfc/nci/rsp.c | 11 ++++++++++-=0A=
=A0 =A01 file changed, 10 insertions(+), 1 deletion(-)=0A=
=0A=
=A0 diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c=0A=
=A0 index 9eeb86282..4aaf362b9 100644=0A=
=A0 --- a/net/nfc/nci/rsp.c=0A=
=A0 +++ b/net/nfc/nci/rsp.c=0A=
=A0 @@ -66,7 +66,16 @@ static u8 nci_core_init_rsp_packet_v1(struct nci_dev=
 *ndev,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rsp_1->supported_rf_interfaces,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ndev->num_supported_rf_interfaces);=0A=
=0A=
=A0 - =A0 =A0 rsp_2 =3D (void *) (skb->data + 6 + rsp_1->num_supported_rf_i=
nterfaces);=0A=
=A0 + =A0 =A0 if (skb->len < sizeof(*rsp_1) + ndev->num_supported_rf_interf=
aces +=0A=
=A0 + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(*rsp_2)) {=0A=
=A0 + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("CORE_INIT_RSP too short: len=3D%u nee=
d=3D%zu\n",=0A=
=A0 + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0skb->len,=0A=
=A0 + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(*rsp_1) + ndev->num_sup=
ported_rf_interfaces +=0A=
=A0 + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(*rsp_2));=0A=
=A0 + =A0 =A0 =A0 =A0 =A0 =A0 return NCI_STATUS_SYNTAX_ERROR;=0A=
=A0 + =A0 =A0 }=0A=
=A0 + =A0 =A0 rsp_2 =3D (void *)(skb->data + sizeof(*rsp_1) +=0A=
=A0=A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ndev->num_supported_rf_i=
nterfaces);=0A=
=0A=
=A0 =A0 =A0=A0=A0 ndev->max_logical_connections =3D rsp_2->max_logical_conn=
ections;=0A=
=A0 =A0 =A0 =A0=A0ndev->max_routing_table_size =3D=0A=
=A0 --=0A=
=A0 2.51.0=0A=

