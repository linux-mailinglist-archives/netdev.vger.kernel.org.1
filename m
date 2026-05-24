Return-Path: <netdev+bounces-291151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uC+sDMepEmr92QYAu9opvQ
	(envelope-from <netdev+bounces-291151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 09:33:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB845C19BE
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 09:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A2293008A70
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 07:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FA32DC76A;
	Sun, 24 May 2026 07:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s6Irly8r"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012044.outbound.protection.outlook.com [52.101.53.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6981022E3E9
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779607987; cv=fail; b=dk6uokdXSbiujZC/dGqPoB7q/m+ZXUchndVmVKQ3Iiaj1FghC2fkJ+/s+4Zkf9OFUkpmqoY0WvIOM6jhNUN5wZ4IddjCsbwQVSgsY+uGRKP6dLxQHg0GoAc+DA4NnV5sj/JCNx77FVcmYndwg1v9uGVE2VtviRPeclxylV0TVbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779607987; c=relaxed/simple;
	bh=x68Do9VIMG7C7mNfWjvNx/E8CKaP/pukTm8Sn/591Nc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LgNs0t5YxlT8J8Ip3hhRiAHmHXd99o5iFDsj7/tBmnQ0pozufuZ6+m/WtKCKvzJGHQbGZ9xlUZqq8WAyDi1SNep9YFEPUri33kZ9TtPM+Wf5UVDk6Sji4rCOf/2VTjx1dNCXxWWTBW8PTpw/tBX3pfJEGeJ7HQR2+NzFCOvyVRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s6Irly8r; arc=fail smtp.client-ip=52.101.53.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Js+/8FrbYpokGqJ0Ex0zmVaL8CePj/0YLzEc/hzvVXW/QiM7labYrL2s4Gf0bD8acqtpJiPvyXIyEvPgPeFcZdPtt42hKAoODIp1xnRwSq3J8uoUupDI2miIgmChKyJbG2I5kd7Yb/200OHjO9vuE1lLtRF2yh8woNa/T0DudDDbNarI9FSaaMoys3b2uHYbF7FkGA8tFtwDyP7NTNIE84bO/LhxqtHVquJNs6ykpE85E6+lSJx+npBbyv74Wcr0SpX/TR5KW7iLIMwcck1sl/Er0vbbPLSpMOCTVGQEKbGLL0GKWnSUG54XHsMwWWU/Gwe9Ak4z8mhQqOXE8hnUPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x68Do9VIMG7C7mNfWjvNx/E8CKaP/pukTm8Sn/591Nc=;
 b=hFUZhhX9sDIo0f2b/fP0DYLP2bpKa1X9XvvuJgxDkRvECXxqgHThrdBVgM3ZTqtmxQo3urd1B5m4VkGuDZg6tw7fKs7HcpFD2vCWp3UC0YMtFDhlcJZaNMtI170+5U4wgP2SXCyrF1uaqT3dj6NWAQR6yTovWBp6bEGNEdg7zCxop0PvJpn5TW3LDWwsunp6DkJy+fCL4AiUgxu76bSd6QooRRvDNtJsaCbK2MiFzgVFZx5UmM7ZsGkAxKUvWM29rwwRln9Bn6u6xN0tS1LEwokEr/0J2GBeMiSNVBrGQq/0lks7+I4aXNRvjwF1UN0Zzft2m7fgdIH5E6Jf1m6e2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x68Do9VIMG7C7mNfWjvNx/E8CKaP/pukTm8Sn/591Nc=;
 b=s6Irly8r1wNiF12/8lTggl7E66MdjWci2O2JImQnmB9nMiKdhHiNTr5N7quqEUR6F0fLvSSSjaSp6u86I8w32sr8R0+ooEbBUaUhn90mPpBagoYtFasqVy3NWUuNXnZWb8ituNY3iyrNDU2+p2a7r9yb1VQxF8euF4EJ5KmJGYQ9iE1L9YiphFpaFHlYPDLoeFd3ahaSIzIavvhssjDDBF6hgCcvkCm6IwmonnZn+yLerozreRb9dwFYrxMqCVL+xODaQGWB4r1jp21lsuaUglP8AVUkmLmQ9/tpwSENTBZg53NDpNS/SqdbteUm54ZGTPisuapnNuoTQse2bBu+TA==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 07:33:02 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699%3]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 07:33:02 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "horms@kernel.org"
	<horms@kernel.org>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, Petr Machata <petrm@nvidia.com>,
	"o.rempel@pengutronix.de" <o.rempel@pengutronix.de>, Ido Schimmel
	<idosch@nvidia.com>, "andrew@lunn.ch" <andrew@lunn.ch>
Subject: RE: [PATCH net 2/9] ethtool: module: avoid leaking a netdev ref on
 module flash errors
Thread-Topic: [PATCH net 2/9] ethtool: module: avoid leaking a netdev ref on
 module flash errors
Thread-Index: AQHc6kCbitIGnOkiWkO+lHYKDLeCDLYcxI8w
Date: Sun, 24 May 2026 07:33:02 +0000
Message-ID:
 <DM6PR12MB45162D18EB59E1B1B47C0983D80D2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20260522231312.1710836-1-kuba@kernel.org>
 <20260522231312.1710836-3-kuba@kernel.org>
In-Reply-To: <20260522231312.1710836-3-kuba@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|CH3PR12MB7641:EE_
x-ms-office365-filtering-correlation-id: 1a6823a2-2987-49a3-fa83-08deb966aff7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|22082099003|56012099003|18002099003|11063799006|4143699003;
x-microsoft-antispam-message-info:
 TtNCh/WCrd1nS0cFmOCnnjN6IHhG1d5BiYpmfFQqqCEDyQF2SXJEu/j5DCBzlrp1tQ0OVgXV1P4Kv4m4lN3HxzARTIg9bUVUW2YOPpHCZS+e7JIkuqh85YPIiN3AFfK9wnjjuG7rCGjb17kiGkNQVRZMIY2HmoVRq4oPxUBMjIiH+XWg8Y6KkjRGGHWH5yF96WUKxeyJ0HBnVjjGACn232tn5nn0N6P37qJE0Q5r6sVcx6GKGMzMLMJSPDPjV3wo4PMOM9wbuzXMDFzkoq+kNHVfDw8ZRprI2Z7RYnZBNSRwIy/vzG6w17ED8/vlSMMeAKIJ9nl2x4L3xx3Z1UXfj9SlGgfbElIK3Zipoh+RPkwEmKnX4OjaTT6AyVXE0uEKUmISIEtGV7z4vw3hjx7qSTo6hXd62Y4IK9dOffxJ+JFRfJy7aYoapzgGCPtbUUv1KZu1a5sgNVrZINiMeZLiSsrXZQSuqiRAV1vEqkd9UkDEyidmNBNiiSU/faVb42xq7IsUbjLjbjT/uhEHC1eunehH77zd3WcgBB1m3VoIZOaiRIY7cUxSvzjuuohi5OAidP0/z1fyutM7RPWmBlblezacZC52tXSNSV/P5/zsLuIW4W5SE2EbphgKNQZLPmqyTJ9ZC+3oKI6jaNBl/mVg8jj3Us4V3UNpQQA2SLGLzfPsPG5Mx0AfNQ7Y8Acd/+ha9aymFllDO0FmJsM0KP+s+Z8L8y3IHtsS497L9Ltr5CISAwi+0uAS1QNxZu21c3d2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MjVFb21aUDdlODNtZ3Jkck1sTm5uaTVSalpISXFDRmpXODZHN2NoUC9Sc25o?=
 =?utf-8?B?dnB0cjNFejBVd1JaYmtIZURpSUs0dVZScFAzL1JWZFE0dUZyZEVHTmhPRTls?=
 =?utf-8?B?RGpzdnRaY1VRcjMvbGxJWEJ3dy80ajlUYkUyR1lpSmxkRVlhL09ocENIajlk?=
 =?utf-8?B?VlArekV3UlhzRzZqT2twVUxHM2xtS1A1b1RUYU01THRWRytualZmNmhuR0FR?=
 =?utf-8?B?aVloak9DZXUydlpnak1DRkIwUTNNUXhSTzNFVTVnR2VRMmt2cnAzSlZ4Nmlw?=
 =?utf-8?B?cjJobGJWeU54MXVBWnV1LzBaWkJXYWNRNUdRME1qTTJndkwwYVhZZXJCcWNz?=
 =?utf-8?B?T0E0VjN0eCtHQzFaZVBWOEUyaTVWeHUveTVmZkNscmJHakdUQ3FYRVJoRGJK?=
 =?utf-8?B?VlZ2K1VRSzQxZlhFNXFCeFIzMXBRZWdBVFRiU2lHcXRoNVJBOU1iU2VZLzNJ?=
 =?utf-8?B?T2Jqci9yY29IeEZhVWFQRVJTRzdHTTNDUGtOTU4xaG05akZQTGtuWlIxT05P?=
 =?utf-8?B?eDUveEdJdTdPSFB6eTVLcmZGKzJRUUdQaXRhTXN5bmRlL05rVDF2aExrMnhn?=
 =?utf-8?B?TmRJYW9GamdBWVAwMnRhZitrTjhOWTNIQlV5VElpU3BHeG9lVklmQWI3anBj?=
 =?utf-8?B?dzR3ZUNJM2RMQ1ZnZngwd24xNmluUFFMUkF0ek5SQXdWc2lEeVlkaldXbzds?=
 =?utf-8?B?UTEvVkE1eEdEdnFSMGdhSE9yWnRqSHEwMFllM1QvRmY5Q0s2Y0dtYVUvbXNJ?=
 =?utf-8?B?cUN0Q1NhbXdKUUtXN0ViYjhieS9TZFk2QVQ2Mit1WmZDNVRiK1h0NlRNVlB3?=
 =?utf-8?B?bzgvRlRqZ1RqUmF0STJieHBoazE0bXJHdTgyTDN4MjNTa2Z2eHliMTJabFhp?=
 =?utf-8?B?YS9vRWZRTGdyK1NvekMrMjdXQTcrRjlqK09WY2RVNCtlYXRxMDQyZmY5MVcy?=
 =?utf-8?B?VFhKMFB4bDgyc29vV3EvY2Jrb21CTWZXNGw5UktFcjdwL1BSN0doMm5IeGMr?=
 =?utf-8?B?QmpITzRFL2VNQXRqb2ZOMENBMXp1UTBjZlFVYXMrRldOM21jZllla2JMczVz?=
 =?utf-8?B?UEV4WUxZdWNHQ3c2elQ0THV2RW91RTBlNjI4RVdsTWxKQk1XZUhmL1doamdS?=
 =?utf-8?B?akFUYmZkYWx5WThHeUwwaGpzTzMrMHpRVlN0S0lRcFhFUmxPR2IxamxrR2xY?=
 =?utf-8?B?MElxTzhyR0JNQWJhK1oxYXR0cVFRcGtDaDZLckZVc3FmdkJzbXcreGl1ejR0?=
 =?utf-8?B?dE9MKy9hSE0zbmMyb3lCUXNtTzR3ejVVcWh0TmVtczNLdlFXUnNNeittV1Nj?=
 =?utf-8?B?WjNTaisvN1Q3aHNid3NmM2NOaFdOV2NYdWIxQVhudjhneHdLMm44WTVBbFZk?=
 =?utf-8?B?N0NYc2hpN3ZHeXRBMUdtbDdpdzNNUzN3T1FiNFpXYW00K0xTTjNBUS90em9h?=
 =?utf-8?B?OUM0YXZPTzRNWTI3anFJN0Z4NnF5SGxNNVFzMmVCWkJHbDlGYThGb2Z3NHo5?=
 =?utf-8?B?dzFlVlBld2hzMCtlUUxMTVpXQVl6WEw5SGFFUTh6YmNiRnZTZDNHbU5SUzFQ?=
 =?utf-8?B?NGJRQUJ1ZjlyZXY5b01tSnhHRDhVbmhmQU1jeXBEeG5nLzNjcTZSc0FvSkRV?=
 =?utf-8?B?UVRZUCswOXdhL1Vocy93d0RhNjF4WWhyY05HbjNNejl2b2NhZnBmU09wczJF?=
 =?utf-8?B?MkYwRjBRait2N1h6N2lwUnZzTlJyWUFOQ0NheDFUTjFpK2xrdjIxTm10ZndS?=
 =?utf-8?B?Q0o3NG1KZDZ6bE5hWnJyNHpUbFdiMU5NTk1ncXJaU0hLelZBVmRMWENCb3dN?=
 =?utf-8?B?Y2d6RjZrY1ovbXFaMTFBWmpLNEtvMUJnNTZpaXNvbk0xazFwTmM2ekxyRVVw?=
 =?utf-8?B?NzZJRzc2dENjc0hwM3h2S3lhTkczaDZDcGhrYjAwYm1rMWswbmVpTlBVME95?=
 =?utf-8?B?VERJQ0NnblE5VG5UWUh3NDMvWldNTHM2THRKZnljUG5PSDVtcTA4RzdwOVdw?=
 =?utf-8?B?dytsYURxaGRjN0lURU0zUmw0Qy93czdrK0F3U2J3L2haZ1FYMytKMjFFeFU5?=
 =?utf-8?B?QWlWa1p6WEQya0o5K2c0Mk16WGtGQ2NhVDREUkxEL0hkdGRVdnZ5NVpXemFz?=
 =?utf-8?B?dW9majAxNXE1Sk95dEUrVXRKZ2RLVjFLN3dZTXN2aVBQd2dtK04rUVYyMktv?=
 =?utf-8?B?djZyb3gxcmJTSjg4Z2l0QjlUaWc0SkZ5WU9JVGhkVW0xOUhMbHgzTUhRejc5?=
 =?utf-8?B?Y0xtT3ppNUhHd3BPWlhHUjNTY055akFwblYyWWM4TnpQUEg1M1RsbUtvQWhh?=
 =?utf-8?Q?GIqU9Ja2o5WX3an+8h?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6823a2-2987-49a3-fa83-08deb966aff7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2026 07:33:02.2674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MpxRt/9Dq2M4JhJJoBGeNBdwmTLBgRfWM1vZcO2acJ1pM/vb3SFzQ91WC1pujRj6Ixr3d97DEp0o91YH4ARheA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291151-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.024];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[DM6PR12MB4516.namprd12.prod.outlook.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pengutronix.de:email,davemloft.net:email]
X-Rspamd-Queue-Id: 8DB845C19BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiBTYXR1cmRheSwgMjMgTWF5IDIwMjYgMjoxMw0KPiBUbzog
ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldA0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZWR1bWF6
ZXRAZ29vZ2xlLmNvbTsgcGFiZW5pQHJlZGhhdC5jb207DQo+IGFuZHJldytuZXRkZXZAbHVubi5j
aDsgaG9ybXNAa2VybmVsLm9yZzsNCj4gbWF4aW1lLmNoZXZhbGxpZXJAYm9vdGxpbi5jb207IERh
bmllbGxlIFJhdHNvbiA8ZGFuaWVsbGVyQG52aWRpYS5jb20+Ow0KPiBQZXRyIE1hY2hhdGEgPHBl
dHJtQG52aWRpYS5jb20+OyBvLnJlbXBlbEBwZW5ndXRyb25peC5kZTsgSWRvIFNjaGltbWVsDQo+
IDxpZG9zY2hAbnZpZGlhLmNvbT47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBh
bmRyZXdAbHVubi5jaA0KPiBTdWJqZWN0OiBbUEFUQ0ggbmV0IDIvOV0gZXRodG9vbDogbW9kdWxl
OiBhdm9pZCBsZWFraW5nIGEgbmV0ZGV2IHJlZiBvbg0KPiBtb2R1bGUgZmxhc2ggZXJyb3JzDQo+
IA0KPiBtb2R1bGVfZmxhc2hfZndfc2NoZWR1bGUoKSBpcyBtaXNzaW5nIHVuZG8gZm9yIHNldHRp
bmcgdGhlICJpbl9wcm9ncmVzcyIgZmxhZw0KPiBhbmQgdGFraW5nIHRoZSBuZXRkZXYgcmVmZXJl
bmNlLg0KPiBEZWxheSB0YWtpbmcgdGhlc2UsIHRoZSBkZXZpY2UgY2FuJ3QgZGlzYXBwZWFyIHdo
aWxlIHdlIGFyZSBob2xkaW5nIHJ0bmxfbG9jay4NCj4gDQo+IEZpeGVzOiAzMmI0YzhiNTNlZTcg
KCJldGh0b29sOiBBZGQgYWJpbGl0eSB0byBmbGFzaCB0cmFuc2NlaXZlciBtb2R1bGVzJw0KPiBm
aXJtd2FyZSIpDQo+IFNpZ25lZC1vZmYtYnk6IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5v
cmc+DQo+IC0tLQ0KPiBDQzogYW5kcmV3QGx1bm4uY2gNCj4gQ0M6IG1heGltZS5jaGV2YWxsaWVy
QGJvb3RsaW4uY29tDQo+IENDOiBkYW5pZWxsZXJAbnZpZGlhLmNvbQ0KPiBDQzogcGV0cm1AbnZp
ZGlhLmNvbQ0KPiAtLS0NCg0KUmV2aWV3ZWQtYnk6IERhbmllbGxlIFJhdHNvbiA8ZGFuaWVsbGVy
QG52aWRpYS5jb20+DQo=

