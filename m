Return-Path: <netdev+bounces-197346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EC3AD8325
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 08:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7830B3B628F
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 06:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D14257449;
	Fri, 13 Jun 2025 06:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mPaTwfQ0"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011032.outbound.protection.outlook.com [40.107.130.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B867024C076;
	Fri, 13 Jun 2025 06:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749795578; cv=fail; b=oc39SzkgGiB71J3NnK8onur2uo6y28PhiDzwC3GWeoZ44l5sFtSmKEiyA44MfJoea9WrznjhdzjO17IbGtaW9KKI0l40rYZW0XWqwMgX3RXuZS4uDWRFmaaqoMVXX/go/nXw7yRdIr6KnDg+XlUb049cpNUQjNkT8GJBhgykjPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749795578; c=relaxed/simple;
	bh=L7eFe/vkTCihrnEBB0ryO/9IweNsE5yGn1DP0KOXSuE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BryMix4WxKw0haASmxOStAPprTC/g2JMMEx/Xav2qxsVjw9+0weUIGy607MMAx3EEF0bXgmaaKPKdDUZh3Z56Xjw9Pavr/d95PAINuH4UUXNCxJRJ/8FfsgOY3N9Od/L1LGuE0XUETOy8g1aOZ15ctIeLEfDyFhoLE0id9jN6Oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mPaTwfQ0; arc=fail smtp.client-ip=40.107.130.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCrPMmL2IWhV7b9yOskoICoNGkJjE28lCC3wdssNSXBxHcTp3JfvO0rVUlA0VLX+ztCTnhD6V07hDcFyA+hK94IOJDs8pAnXi+iBHrUuNk+E1PDB7q+TqxsR9lHXD+h/pJ7HSLZCPWQe6r+4kpjGuZ8AXVR6UKYqsCx9Et314a/AbiUKd4gqOX0HCsrru4X1J8l/BRdH+w6uAOHup9DmcUCJ6GMkp3Src06XKogEcWE3CXh2dVRCLmBqfapd74SXZHPLPM1y+FR9K4xIvvuSOoUpUUInjxaOAyqujdvp4o6MScDMw06DICd0oSKR3fymBfoPy1WxHkSvbwQ4LlZypA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7eFe/vkTCihrnEBB0ryO/9IweNsE5yGn1DP0KOXSuE=;
 b=E7mujCYtwpSCGiPF/8wggY1FeuGAe2DGZJcdSyRiokpkMXBsCasv5RT71KDCqd7XE290Nsp6UxmFd8E2ZF98QNMzbtBzel2pj4BYysemqZ0MHpL7APzSlpwtEOMi/0C7J7cdELLC1OAPRj3sG0xT9TJLxv5XwI5UaZXhXzZgu54z/uz7gjrkNgFy/xa7u1MGZZ6njwYWorAOuM5DSGiyyLnATMP6HUpj0Mk+NldOw1jBsTRTBINTXjN3bsWWZ81ALjX2D0olGKZFdmb65T4mMLkojfAFqorfIywtKA94tATKFz6C3SW+t4xNmSjrZY4WEkoepxfAc/pTm8KmTtVa/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7eFe/vkTCihrnEBB0ryO/9IweNsE5yGn1DP0KOXSuE=;
 b=mPaTwfQ03dW1MX9gMltmjBvJD5GgEDtj32zSzPYg9ROIcxMPSZfSnVcIdo65CAyqpcdVVXc8WZwHO+Z+U3nKYif/ByOMhBBNJnXl/MXiPu8WgFWlTjSd1uoyTBSHUktKq+whDspnM1XoUL2Wv7++JCHOkqyBthmwLPSVbIN5g6YxJ+PEfbxRCyrpDfvKf9hB8LtkfqrdKWsl4s6m6Br4ha6RTkHariRVGvb2amrlSJ1GdaJpBQREIiE1Lwy7t7OcP5ncpWnBl5LgpgLJwhnkozNW6gJZIm8DbuVeypODBwMTmP3vguf2shseqV1N3UG34wp4gRwfr62Sp/oo7QVb+A==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8919.eurprd04.prod.outlook.com (2603:10a6:10:2e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Fri, 13 Jun
 2025 06:19:32 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 06:19:32 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, Frank Li <frank.li@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Subject: RE: [PATCH net-next v2 00/10] net: fec: cleanups, update quirk,
 update IRQ naming
Thread-Topic: [PATCH net-next v2 00/10] net: fec: cleanups, update quirk,
 update IRQ naming
Thread-Index: AQHb26TivZOeKKspFk6yDO45rmPXWrQAnl/Q
Date: Fri, 13 Jun 2025 06:19:32 +0000
Message-ID:
 <PAXPR04MB8510C523E90B33C2CD15DAEF8877A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250612-fec-cleanups-v2-0-ae7c36df185e@pengutronix.de>
 <20250612-nostalgic-elk-of-vigor-fc7df7-mkl@pengutronix.de>
In-Reply-To: <20250612-nostalgic-elk-of-vigor-fc7df7-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU2PR04MB8919:EE_
x-ms-office365-filtering-correlation-id: eb8161b0-ad8e-41ab-0c9d-08ddaa4242fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MlFQUi8rWTZlcWFJbWFOQW9aMmVSSE9FMkw0ejgxMWhyYktuM2tpZGN1NHp3?=
 =?utf-8?B?LzEvZ1liU3dJM3kyc28waHRCVjZsbE5Selg2Q0N0VEoxeTRETXMraE52OW9U?=
 =?utf-8?B?N0FXTitLakVRNzE5QjJQTU9WeEdXaW0xR2lDZmxBMHNrazN4KzYyMGFPRk9z?=
 =?utf-8?B?V1ExdHRDMVp3clZjRFdGR3hoaEtNV29xelJQaDBIcHE4akZVS3JrVE9zU1VS?=
 =?utf-8?B?a3owZmJXWnJ0K3Iyb0hBWmxmK1ZPVzZobWlGUWhHckF6d1lNOGFkdURaREZT?=
 =?utf-8?B?cTM4Zm5qbk54NG8rZnJ6anQ5VEIrUGpYb1EvOVY1eXo0M3NLSkd6MVVNczMx?=
 =?utf-8?B?Slg4QnVSZUZuazRmbmo3OHg1TnltMnJZTnQ5b2lreXpaUDJJeTBGcExJZWRW?=
 =?utf-8?B?WnhqTjJHWDdYaEZvN2RkeGhYOXh6eDNjRHZDZjVOQ291YWhiRXBnb0ZwQWMy?=
 =?utf-8?B?ZjVZREtPc2N5azZmNU5ON1R3RXM0Q0xYdHFkY3hJZEJ6WlVpRHJWNDlpYTZm?=
 =?utf-8?B?MVc3eVJQbFg2c1hTaVk5c1Q4Z0JuT01MSnF3N1QydFRoN01RUWUzT0RYckp4?=
 =?utf-8?B?VVR4S3JhdzMva3dZSEg0VnVnanlBWlhzb0lzeURPSXNESU4vMXZPbTVNemln?=
 =?utf-8?B?NXJXMHhydzM1Y0F6RnEyTlBrMk0zL201bDR4L3VmcE5oRjNuRXVRV2MwdTBK?=
 =?utf-8?B?MjlWRk8zbjl4S1owWEdIOGJCcUpkdFJIU2dCV04rNmZIUUdoZ3oxa3U3VGgw?=
 =?utf-8?B?OG5obVdlQ3JHOHVTRHYxa0wwYnpNNU1XQXdYS0dkLzlqL1FBWXk4WEo2M2tN?=
 =?utf-8?B?c1BlMkkwUzIrcGVCellpVFVCalhwQURaWWIxZnNCVFp5TkRhMmtyVEtWWk10?=
 =?utf-8?B?c25OZEVqakVDOGRMc3daanpybkR1ZHNwa21NQS9RVE9YNS9uZFNCMTdGZnY1?=
 =?utf-8?B?dnB3U0xrSHpXMGV0TWxmOS9rcjVlLzdrM2s3eFBDd05jTFFNM1ZhY3Z4eTBH?=
 =?utf-8?B?d29GUGlWSUJwNVlzWklHSTdrbGxjSTR1a0lhUUIzWERxc3JzbVB6V2ZNYm10?=
 =?utf-8?B?SW9rZTQxMnBNTlJRMkp0TFd2emthdVZnWGhNd2ZCSGlMZzlMT3k5c1ZBMHZi?=
 =?utf-8?B?UGNnNDF6TkFXRWNXNjVPR3gwTGRpSVpKSjNPMHNwY3ZJOGtxZnc0d3RTS01p?=
 =?utf-8?B?aGpoSis3ZnYxZ3RjdkhKSS9LUVlCS2RJeUpXa3BCbHRBSmJNeVRKbGY1dFBW?=
 =?utf-8?B?dzZwQWJ5N2cvUEg0UkQvY3pLVnBkVFZGUmtDSVQ1bTNYUE05cFkyMUd5VHl2?=
 =?utf-8?B?VElkWm56bFB2VGY3L0hYQkJGMGRaN3g4ckV5WmovSlQ0eXdRbFZqaWE5Wkt1?=
 =?utf-8?B?Y2xwK1F6eUMvL2FneTBsTTZvS1l5RmlQcFZwTVlSY2IxVThzOVhldjE3dE1E?=
 =?utf-8?B?WUVONUFtTk9wY3k5cmJBMkZZYVBqcVpMaGhmbVU2OXZuUW9uQzR4YVdBb1JW?=
 =?utf-8?B?K3poWmswOGhpMW00MDZtSXhjRGhFTEVVampybko5U0JZd2xodkRVMTZnSXdv?=
 =?utf-8?B?OUMzWnMzeEoxWnBZYi8vY3d5WW5ETzhXcWs1cmxuZERLbEVXRTNWM2NVSkVM?=
 =?utf-8?B?SHZBWWd5V0RXNlFiZXUzUWJFR2x3dDM0Nm1BSy9JemhXV1dFd21MZmkzK1Yx?=
 =?utf-8?B?dE1oV0xBbUdOWFZkQ0pjTlU4SWw4ejd5cTFEMVZRK3F1aHFqbTd2a3R2Umk4?=
 =?utf-8?B?aWltMHcyM0RSWmFsdnB2MUk2bWtPK01XUXhPbWJLaTNkSG4vTGxycmZYT0ZU?=
 =?utf-8?B?bUJkZ29FNzMycUVHc01XSDVlcWJDNlA2NU9idXc3UVNJTnZDTk1telZyMDJ6?=
 =?utf-8?B?L0JLWnhkemtWVGJ5NlMwa2FRWGVmSWp4NEFKNTc4SWZvMVpyWll2SWFEbmpa?=
 =?utf-8?B?alZVRkVJSnpHUnR3aFlYc2lRYzF4cHpNdCtuSVFSYTVaYjJNR2p1SGY5djlC?=
 =?utf-8?B?ckhrUW5WODNnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFVYbHlsN3R4S1BvSkxIUVhId3BzSFIzeDhaMWJhVXpINXBCRXJoNTdVMFZ0?=
 =?utf-8?B?MjdCOVlvdW5XaWt4YStYaFp1U1ZGQmdlVGRpcEJCRzlJTnpFRTNyU2l6ZWZn?=
 =?utf-8?B?VUZORFhWbVZCaEE3cERhZ0d1N3R0anFzVzJUSHhVNFVEcnYwaFRiVXcrb1Vn?=
 =?utf-8?B?bDNlTFcwZnEySHc0c3Z0d1lCU0haekpsRUVDMjFhZzdLOWx4WGd4WXJzZis4?=
 =?utf-8?B?c1JzeTJSQXZGaXFDRDdjMGRqUGpSeUN3UUQ3dExuQ1FWKzVOUk1UbkYzYU1I?=
 =?utf-8?B?VFFwUGt1bGtET24waTVvS1AxSndXT3BHNnIra0pXRXQxNDFuK2pJTkNndi96?=
 =?utf-8?B?eWk0Q3cyYitWS0x5TmEvb1A1TVRkTC8vdm5LVXVnYXBjVXFGM3VyZGJoWUM4?=
 =?utf-8?B?V25XSWcxdFBLcndqOUFRN20xU0l0L1lhK1hkbWFNcHVQcjBxZTRIaWZlbVRs?=
 =?utf-8?B?dmZmSW9GN0V6QVVoMWllQ3RrcVgxUVZvZktVbnZNNnMyUlZuTVF0aG1HbGcz?=
 =?utf-8?B?cXNSenFCYVdkZldiZFdFQm5rT3V3UGx3ejNjYzEzS3RhZmZ0ckpTS2NzWWdl?=
 =?utf-8?B?bWpleis2TEJnOHk0c2JyZmJyUC9jaVFxWkV6RnVSOFVESVdPK0QweE1iZEpt?=
 =?utf-8?B?V3Y3OGM5OXVaVjUyY2JKWGM4MnBnVGVKbzdDN1dnbHMrOVNGaENaOHE3aGtG?=
 =?utf-8?B?eEM5c2JJOFc4SjFOWGJNOUhLUExhVzY3SmhoMjRuY01DQ01LaDdlMDNjelJi?=
 =?utf-8?B?dkxwZ0Z2Nk5iTW9rQmFhenJnTFpIcUZrVGtWR2xMSXVDRHVjSncyR3FOMFBW?=
 =?utf-8?B?Ulk5UTZHRjRUTWhZMnlobEFWZGxqYk4wR0hMR2ZrK1FpdlkzVDdRaEVjd0lB?=
 =?utf-8?B?WDg0NkZVSkU3SHFmNTE1T1RrK0JGVWZpa2NpYVJHeHBmSVMyNHBZWnNuMFY1?=
 =?utf-8?B?VjZSVHFzTFZKK0JoeGo4eTZqWHpreWdLUUFTT1JIVjVidDZ1eTU3Z3M4K3g5?=
 =?utf-8?B?N1ppUzdIcEcxVFMyZ1F0MEpvYXRlY2hpNGtOMVFqUG5FcE1QaVdwTUdaWTNS?=
 =?utf-8?B?SndQbGV0UnRBbFhncVdJMnY2SjZLcGxpVWYvVUZPVVJsV2pSdlh5N2hYZDF5?=
 =?utf-8?B?c0hZejdIMzJwQ3BTUFMvVnJDdDZCNUpJbmNlL2l0Q2dFOG0vbFlRRmtudnMy?=
 =?utf-8?B?a24zVXM3L1lpZ0cyK1o4eDV6MWRsMy9nazNkMWs4VTFPd1Vqbmt0blJsb05S?=
 =?utf-8?B?K3lacTlnaVdkR2JqREdBOEtua2NPVzBSYTVUQms3NVhqdk0yMHVZR3UxNWk4?=
 =?utf-8?B?cWdXSlhVSzh1aVRYb0FrdWJHN3dGeWk2N05lR1diZi95aVA3U2xPOGd4bi95?=
 =?utf-8?B?NUpSODVPUmhsNDE2U3pLeWtDY3FlY3dQSW5TYmZLcDFQWTlROWgvdDYxeW0w?=
 =?utf-8?B?NzMwbHZkYllmOXZ0M2dXQkRKbVFpOHllZG9IN3liaU1aN0REb2tRbTZyQUlY?=
 =?utf-8?B?bERKSzRGcGpDS0Y2Ynlua3NQUHVLVDlCWXh3N0ova3JkR21pRk11dFpQWmd5?=
 =?utf-8?B?eG1vQ29pbTJzYVVzWjhUTlVpQ2l0a0ZxNjZWaGtZRDhqY240em5ZbWR6U2tO?=
 =?utf-8?B?UWxpZVJOeG8yc0dZT3R1c01lYkNnVHNHaEJXRWFKOHE3QTZYT0ZyUXNkUU5F?=
 =?utf-8?B?OTgvdWJrdU0yblhyMmdpQlFoYm14NXc1d3lVbHVxSDVNVHAvSmFnN0gvNnQr?=
 =?utf-8?B?ZVo5SHNqUm9DNU8vR2JJUkZ6TFhBd0tRSFpwUnNjcHBTNlVxMW9kZlhaaDBG?=
 =?utf-8?B?akdmR0JNZlZGdkRvYTV6NEE4Q1JSZVlxNVNSZXNhL1RBWUZ4UzIzSm5NR3Nr?=
 =?utf-8?B?VldpWFpoRTEvcUxPMmVxcU8zVnJqYjFBNk1KMGNLeHVFNEVIRmhwNnZmbDU4?=
 =?utf-8?B?Mk9VSDZFb2JYZ0JUQ25KRmlqSUhuMldZelRlaStZdENicGppMGhiUVI2bjF6?=
 =?utf-8?B?UjBEYmlMeDY4aHZ3enN6M3JoNTNUd01OWVRRSUNFbnlGdWNtYnE3Tm5GWmJN?=
 =?utf-8?B?UGVJcEhXRGM4L0hGQy8vY3BzUWRiZlZMRXBDZTVFM2J6ckF3N2FkRXdSbTMr?=
 =?utf-8?Q?wDWw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8161b0-ad8e-41ab-0c9d-08ddaa4242fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 06:19:32.4231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n6GjpvvQRruH/iB6mKwLOLFgEBfWaGedRjZ312F6c/unVsCv4wiPGIW6Aj89PTf/Qiv88RPt7ec6NZsGBnvU/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8919

PiBPbiAxMi4wNi4yMDI1IDE2OjE1OjUzLCBNYXJjIEtsZWluZS1CdWRkZSB3cm90ZToNCj4gPiBU
aGlzIHNlcmllcyBmaXJzdCBjbGVhbnMgdXAgdGhlIGZlYyBkcml2ZXIgYSBiaXQgKHR5cG9zLCBv
YnNvbGV0ZQ0KPiA+IGNvbW1lbnRzLCBhZGQgbWlzc2luZyBoZWFkZXIgZmlsZXMsIHJlbmFtZSBz
dHJ1Y3QsIHJlcGxhY2UgbWFnaWMNCj4gPiBudW1iZXIgYnkgZGVmaW5lcykuDQo+ID4NCj4gPiBU
aGUgbmV4dCAyIHBhdGNoZXMgdXBkYXRlIHRoZSBvcmRlciBvZiBJUlFzIGluIHRoZSBkcml2ZXIg
YW5kIGdpdmVzDQo+ID4gdGhlbSBuYW1lcyB0aGF0IHJlZmxlY3QgdGhlaXIgZnVuY3Rpb24uDQo+
IA0KPiBEb2ghIFRoZXNlIDIgcGF0Y2hlcyBoYXZlIGJlZW4gcmVtb3ZlZCwgSSdsbCBzZW5kIGFu
IHVwZGF0ZWQgc2VyaWVzIHRvbW9ycm93Lg0KPiANCg0KInVwZGF0ZSBJUlEgbmFtaW5nIiBuZWVk
cyB0byBiZSByZW1vdmVkIGZyb20gdGhlIHN1YmplY3QgYXMgd2VsbC4NCg0K

