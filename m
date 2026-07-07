Return-Path: <netdev+bounces-305437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mIFfNAPzTGrdsQEAu9opvQ
	(envelope-from <netdev+bounces-305437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 14:37:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4730F71B6C3
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 14:37:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=honTjqf4;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305437-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305437-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DBAB304242E
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 12:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB05B3F7A98;
	Tue,  7 Jul 2026 12:37:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010059.outbound.protection.outlook.com [40.93.198.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5950B40A950
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 12:37:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427826; cv=fail; b=MqVpvWzLFp/u3/Pj58CMp32khcx086bA197dCjpLHrpuhTGu9aNpxD8rnp8KMdDhnuXLUwbtQA02WyxtUW7vj7O8RAiTDBeNtgDfXAGbBCMsGw7so6ReXtpzGGcFTIDHi4wmZEsC7oQCed3jCcGGn3DCK76ZLprX+U4Oa5adIyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427826; c=relaxed/simple;
	bh=D0/yLdTmDNy0bwZG9DrkwgpFlC9T40UAy4SPP7HHwv0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qrMntocZyOdFsYda1haUndWHqWKamtfX7DG/4VBPzC3mjXWGk/WNEeYVjFjNwvpreoLx1yMlk08uUcy+TUXf+69OwR6/RcdSYeaSG/MVUSzh29GO24e7vYoTA1d/pIz3SYOrxij0JrjOjcc3/NiA/I536J38WExg3o4MvoEwTR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=honTjqf4; arc=fail smtp.client-ip=40.93.198.59
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6LJKLon8j3S2NM7UzIaCrbB77F6prHL0AcSZ0PogXGj44UvFqongJQdCUhlVzWhQVM7OwUAfpuckF1TkYI8Np14Bh76rC+KsYwl27lWPURA+cPc7Ep6rHIb6eqNbv5FI0N53Z/urP/zUiBDweT0SF9Ydc4iKPrHFsvQd770EIHsvmvx7cjxRlqanTSjrGm7ee6KBYCmGevZojvPribKPY/eIcRRpazNdy1pi+h8GuckXRVktSWeIsl79PMcuGtSeAoHHYoQL83Iw03MBhdt/YwxpNP1ogHQayPfCPQ7TgJdb+9YaQGeOXGdEFmSE1ypGOWHWJW0hjfAD9fdz0Dugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0/yLdTmDNy0bwZG9DrkwgpFlC9T40UAy4SPP7HHwv0=;
 b=k3NruexhddAkt6n3vckDhJpkUuAQsun7y4EDSuf1aEvIHNsYkxIxJHPcylJibwCVVUB5AdnUA4m3yo5FotIfk+1Qd6ZwQwYDcB2ioMuV0pCssPueVmTPY6o/4scIPCvOiBiZuqYcDpIJDpu2HJjdVjgJe9wLe7pEEmfyW0lT3Ef01SW0RiivFoVtV6Ohz0vbIqTBAtPY+Pd1Nn9Jj2kFRApPicpS+kvxrx91lHMzKGS2Z25WPYo8TC0TFsSHsZqyKLGJwCHeKoynTsXC/FnzWDYyTS4dhf9bRPTBvFbrYEygFdUz7zbmeOdRJTUmQP0VNmZS5n95kBx56cLu+vbqeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0/yLdTmDNy0bwZG9DrkwgpFlC9T40UAy4SPP7HHwv0=;
 b=honTjqf4br5Kh2MKeimKe0Gvk6QAjjW7mQOI78lAkQ4B+P6n4R2JLhu7NTwvuG+lde+uZ7XnioHAeuF8zNira1EqL4JWIAgDXQPNLwBr/V97Z6SRz6zUAD44V71ufZ14OLBkm7BpPtgi3114lQ+uu/YbMGO1AtyuUUXss6zImYf6stKbp84HkQdhAfPmM4CFIaewHQdE0k4N4mtWHUQb/sPD3+hmrDTkdsoNHUS4teXNSkmJUHYU05oGyGJHalxryOxMo9u9KQuJrnhSCNxPKpyOXvW3mM9Lgv7+Ex/qZLv06LCzfinUJy3L7HTZk8jD3KqhsxKxBPBBxTMx6g1A/g==
Received: from SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19)
 by CH1PR12MB9695.namprd12.prod.outlook.com (2603:10b6:610:2af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 12:37:02 +0000
Received: from SJ2PR12MB9008.namprd12.prod.outlook.com
 ([fe80::e25c:9cce:637a:3dfd]) by SJ2PR12MB9008.namprd12.prod.outlook.com
 ([fe80::e25c:9cce:637a:3dfd%3]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 12:37:01 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Aleksander Jan Bajkowski <olek2@wp.pl>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>, "andrew@lunn.ch" <andrew@lunn.ch>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH ethtool-next 2/2] sfpid: print all compliance codes
Thread-Topic: [PATCH ethtool-next 2/2] sfpid: print all compliance codes
Thread-Index: AQHdDLnWJ+rubKwtVUmWV8N9flwHkbZh8Uug
Date: Tue, 7 Jul 2026 12:37:01 +0000
Message-ID:
 <SJ2PR12MB9008B28609B06530605BD6FBD8F02@SJ2PR12MB9008.namprd12.prod.outlook.com>
References: <20260705200637.2092534-1-olek2@wp.pl>
 <20260705200637.2092534-2-olek2@wp.pl>
In-Reply-To: <20260705200637.2092534-2-olek2@wp.pl>
Accept-Language: en-US, he-IL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB9008:EE_|CH1PR12MB9695:EE_
x-ms-office365-filtering-correlation-id: 78deb6c6-0a43-43c6-32c1-08dedc2471cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|23010399003|1800799024|38070700021|4143699003|22082099003|18002099003|11063799006|56012099006|3023799007|6133799003;
x-microsoft-antispam-message-info:
 EzkF4dBk9vQTfD40+JFT3ev8AS40aiwvFUWS+/QSRgUOSlrT5fsTVsTEinL2gLB2hmzgKI8oorXtP9+nRhjmr85U44juDAdqAY/HUYbsrNXyJzqXFsjABbuSBNznQRZhfk+0cI1ybzI31XZERfOwTg7/qilVLMlZuC3QUkf/f0BmIIOjGbMfse8gVLdtd9yb0/l+U5zV0PxnVyX5dSxsufVssaHq7sepmPDphJe6u9NzZc8aJrJKALJdnEXFT9zmzSQ8rNDE+FxR9Wpi6cr1AS8uUiTypSZ6+7WLHlVOPGA5sem1wztZPncrVttaCwhRqtSZ9XCZSSA8Iuy/cN5i6ACp4BScNnWi73IbDiSWkwQUPT5J1Qvy711Vy32/sKqGb0ikzLpPXLb9DLp4u8CgewqMRLInhbLlzbdBrNn1UcAjR9XaymUOdtGzJsYZln39P2HoKD6NefEN9Q1tncN7S1pSN1u/3CMzHBjeEMYoUQCzAwvzG0L2W9aq77mcmXp1nSY2LT2MJsd9Sz9AoJLxwY2+qfMaMAjk2Gi2aNl9rUUIRmml/9ye8UdNQ69zuoI4lrizsuxaZmS7XcorOZx9GkTk55cVGRcbR5h3RKTSsMbpRw4tklRfyQKI37im6zzgjx49HZCR8fIsGZcSRN3JA7vtJIq37fpgkCQQ3zOpXdNduuBWi7fJx4T/0tabuaP8vQmQLAZhEhYjoSgltAwKpN1flkwW9qw3dyovY6dqwm4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(23010399003)(1800799024)(38070700021)(4143699003)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YVEybFpvQy84RmxFSE5SZWdyandQemNKMHhOdTRMRjhTQVlXNFJ6MDNJME5K?=
 =?utf-8?B?MW9uRG9aVDZlZjRhczAwZ3Z0enQ4akZzTThDRE13ZHdOdEhnR2FRSDdjdFov?=
 =?utf-8?B?Sml2VHA3a0VmalVyS05EaXc3OWlYWGc4QUx5K2ttT3BPZFUzdS9CUjNrbkdl?=
 =?utf-8?B?NzVDRGYzRnNMK2hER2dwQzh2ckFCZ1VvZCtIT0wwQVUrTmo0dHVPamFBWWsv?=
 =?utf-8?B?UFoyRy9MNUlEdFdZSDBwLyt0U3JodVZRMTdaMUx6eHNaSnpha0E3SGhZb0w1?=
 =?utf-8?B?RVlpYXpzZFh3TUQ5bWUzZ21OaEQ4ZmtBU0tDWnNGQnpPU0VaV1V1VHFpR2ZP?=
 =?utf-8?B?SjRobTFEVlNsS0I3YjlkQnROQTZFaGV3Q2o2eEtFT3pmVkkyOFRqWnNCNmk4?=
 =?utf-8?B?L21PcVF1K3c4aWxVd2RLU1ZVMzZ3Q3RUS1o3RzlEQUJNblNvdEZuVFBNYU54?=
 =?utf-8?B?VzJZNlB5Rlg3M25mcUhaM3haSVB1NlZpeUwxUmhGZEo2K1oyR1NBR3ZsbUVK?=
 =?utf-8?B?MDljMzl5VGhkMWdCNDduRGRUS2ZxVVExcVQ1b0F0dk5rU1lzcHZ3cnhoT3Y2?=
 =?utf-8?B?bFNuZEczZEZpaXhBUFJGdzFySUhQTGhSOXMzZitBMmtWaXZwTzJqOWtWTVBu?=
 =?utf-8?B?OExHa053OE9CaXZrZE9XY2F5Nk84ZDlURGp5OEhkWkt5d3NmQ241UktQaDNw?=
 =?utf-8?B?MGhOQnJEbGZsSmJTeWxYYjkyWFBNN3prQ3pRVTBCL1hySy95OUhzcWtpRFZi?=
 =?utf-8?B?bUxTVnRLS09HM0tzZVVzbW1oT2RDbERmbkM3dDJFdnhRS0dGR051VytxOWs1?=
 =?utf-8?B?dHFmTVNaZHQ1elJBUUtaVS9xN0ltRDhvNWFjRFRac1VWSy81aFVnc21xbm9N?=
 =?utf-8?B?RzZwcm5YcC9YeEZPd2Y5TCtDZlpEa05NWjVkanBuNHkyL04rVGRVWjNWZ1JH?=
 =?utf-8?B?eWd0MkwwdjlVaFZPRkZNN1JMdS9zYkRLd01wbU92V3dmTEVaLzFKdjBHQ2J5?=
 =?utf-8?B?c3NSYnJkZ0gzWU1jUm5nRmxua2puWWw3RXZOd2RhWk9iMU4vS3piTHZQaXdE?=
 =?utf-8?B?ekxOd2I0YmxINmNiVTcxWnpWZG84dXpiQnJtRVc4TW9jSmQ2aS9GemRNZEVO?=
 =?utf-8?B?TjJRSFc3S3R2Ulg2eTB6U2o2YStqSDVMalJNd0JkcytudmsyeWt6ZzV6SHJo?=
 =?utf-8?B?ZVFhejh0aS9HVzVETUJQT1YxYll4SnZ1Nk5ocFk1WHM4cUs0NkFCaEZuSFZu?=
 =?utf-8?B?eWRYd081MDZWc2pneGlpZVZJZ3lPb2tkYTcvVGJaN1Rmc2ZaRi9lTjZuRlNi?=
 =?utf-8?B?U3QvT25qdVNIRnNYZmRON1BYUlllWDhRQ1ZZM3JPcVhCSEN0eG1FcTY1THFt?=
 =?utf-8?B?bE1zSlROZkVZWGV1dVRkRjhkNUsrcit0cHBNOGZqNzJ2SVI0ZElJMGU1b3Zr?=
 =?utf-8?B?MGVZdGh1amliTTlId3lpNkg1OFlLVGErdEFZSkJMVE5CS3VTc0ROY3pNTk9j?=
 =?utf-8?B?NDlEQytDT0tjdnNEOWJ0WDVFcmE0TnNXYUpLYmlRbmlFSjIvSjQwZ2NxemdO?=
 =?utf-8?B?WW1iaGlWbVpMTWdYMFdYUk9aNXR5Z08vY3RUd1ZtQVh6QitxdFlBa2lyUkxv?=
 =?utf-8?B?SEFZSWsyS0NHNTZGL09JN1ZuL01qSnRnaEEvdFkzcjljaWtncWxBMUZwOTdm?=
 =?utf-8?B?NVhYcEE0SnlMWDNWcmZiOFQzbTQrTUxTU2pxWUpmbFA5cFJuMC96anBCMXRi?=
 =?utf-8?B?cURXbCtmTzBJeWZrMHdJY0pNYjB3d1p6dEt3amtnZ0dSOElITmREei90V0Fv?=
 =?utf-8?B?OEJZbUlYQzJ2V1ZzVmR5MnNpbHhOUWlaT1Z3TDU0YUV5b3lyRk5BZlhvYUpm?=
 =?utf-8?B?b0xHc1Q1dmZ3N1NOaHVkc3JvSXpYK3pIUDJCTTJpVFcyUzZlU2g5Sm9YUmJQ?=
 =?utf-8?B?Ymgza2xObklCU0hiQXQ2RUhoSUxtZ0grMmE0WTE3cFlNYjhPNWlpcGNrRzhi?=
 =?utf-8?B?TVhmVTRnY3IwY2lqSnBlcWp6ZGVSM0srYXE5cXFsbzVUMDBqclVlSFBtc2Rt?=
 =?utf-8?B?eEJUVXQ4U3NFaVhNZ0N5TVg0SW1NcHRrZFR2Q21jWXhORTlRdmFSWkJBenZs?=
 =?utf-8?B?bXd6L1Jud2UyL1lUM1JSVjU2UjdRVHRvTkpBalVPR05aMXlvQUdVRWhTNk11?=
 =?utf-8?B?dnRMaXNkY3g3bElYaDE5d003bW5QTDVWcEZhSTN0T2RnWVlqZ1BBc093WHYv?=
 =?utf-8?B?TitrTDBWRWlTSUxNdG1MOUwwM2lzdVI1RStraEFYQ2k2Y1JtSnZpZGVQSnRP?=
 =?utf-8?B?MnpFaEtIc21SL1oySmZtRDR5TUx0WnN6VVk1dThCNFpxNXgyaVNGenVLYlhG?=
 =?utf-8?Q?N8EBvIWAZ4dLFt3tWuT9e5HqiWNFL8nF0MuuA?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78deb6c6-0a43-43c6-32c1-08dedc2471cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 12:37:01.8786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h182oT0bwE5jMMgk0yOWi/OPflKgaF7vVAqdgKmS7a/bhWIALYjAoNY/Ljt7KkeE4dIVwVZFutDmP4BFE2Hd+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9695
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.06 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305437-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:olek2@wp.pl,m:mkubecek@suse.cz,m:andrew@lunn.ch,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[wp.pl,suse.cz,lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_SENDER(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4730F71B6C3

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGVrc2FuZGVyIEphbiBCYWpr
b3dza2kgPG9sZWsyQHdwLnBsPg0KPiBTZW50OiBTdW5kYXksIDUgSnVseSAyMDI2IDIzOjA2DQo+
IFRvOiBta3ViZWNla0BzdXNlLmN6OyBhbmRyZXdAbHVubi5jaDsgRGFuaWVsbGUgUmF0c29uDQo+
IDxkYW5pZWxsZXJAbnZpZGlhLmNvbT47IGt1YmFAa2VybmVsLm9yZzsgZGF2ZW1AZGF2ZW1sb2Z0
Lm5ldDsNCj4gZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgcGFiZW5pQHJlZGhhdC5jb207IG5ldGRldkB2
Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEFsZWtzYW5kZXIgSmFuIEJhamtvd3NraSA8b2xlazJAd3Au
cGw+DQo+IFN1YmplY3Q6IFtQQVRDSCBldGh0b29sLW5leHQgMi8yXSBzZnBpZDogcHJpbnQgYWxs
IGNvbXBsaWFuY2UgY29kZXMNCj4gDQo+IFNGUCBtb2R1bGVzIGltcGxlbWVudCBtdWx0aXBsZSBj
b21wbGlhbmNlIGNvZGVzLiBUaGlzIGlzIGNvbW1vbiBmb3IgZHVhbC0NCj4gcmF0ZSBtb2R1bGVz
LiBCZWZvcmUgdGhlIGBqc29uYCBvcHRpb24gd2FzIGludHJvZHVjZWQsIGFsbCBjb21wbGlhbmNl
IGNvZGVzDQo+IHdlcmUgZGlzcGxheWVkLiBDdXJyZW50bHksIG9ubHkgdGhlIGxhc3QgY29kZSBp
cyBkaXNwbGF5ZWQuIFRoaXMgY29tbWl0IGZpeGVzDQo+IHRoYXQgYnVnLiBDb21wbGlhbmNlIGNv
ZGVzIGFyZSByZXByZXNlbnRlZCBhcyBhcnJheS4NCj4gDQo+IEJlZm9yZToNCj4gJCBldGh0b29s
IC1tIHNmcC1sYW4NCj4gLi4uDQo+IAlUcmFuc2NlaXZlciBjb2RlcyAgICAgICAgICAgICAgICAg
ICAgICAgICA6IDB4MDAgMHgwMCAweDAwIDB4MDEgMHgyMCAweDQwIDB4MGMNCj4gMHgxNSAweDAw
DQo+IAlUcmFuc2NlaXZlciB0eXBlICAgICAgICAgICAgICAgICAgICAgICAgICA6IEZDOiAxMDAg
TUJ5dGVzL3NlYzwvcHJlPg0KDQo8L3ByZT4/IEkgdGhpbmsgaXQgaXMgYSBsZWZ0b3ZlciBvciBz
b21ldGhpbmc/DQoNCj4gLi4uDQo+ICQgZXRodG9vbCAtLWpzb24gLW0gc2ZwLXdhbg0KPiBbIHsN
Cj4gLi4uDQo+ICAgICAgICAgInRyYW5zY2VpdmVyX2NvZGVzIjogWyAwLDAsMCwxLDMyLDY0LDEy
LDIxLDAgXSwNCj4gICAgICAgICAidHJhbnNjZWl2ZXJfdHlwZSI6ICJGQzogMTAwIE1CeXRlcy9z
ZWMiLCAuLi4NCj4gICAgIH0gXQ0KPiANCj4gQWZ0ZXI6DQo+ICQgZXRodG9vbCAtbSBzZnAtd2Fu
DQo+IC4uLg0KPiAJVHJhbnNjZWl2ZXIgY29kZXMgICAgICAgICAgICAgICAgICAgICAgICAgOiAw
eDAwIDB4MDAgMHgwMCAweDAxIDB4MjAgMHg0MCAweDBjDQo+IDB4MTUgMHgwMA0KPiAJVHJhbnNj
ZWl2ZXIgdHlwZSAgICAgICAgICAgICAgICAgICAgICAgICAgOiBFdGhlcm5ldDogMTAwMEJBU0Ut
U1gNCj4gCVRyYW5zY2VpdmVyIHR5cGUgICAgICAgICAgICAgICAgICAgICAgICAgIDogRkM6IGlu
dGVybWVkaWF0ZSBkaXN0YW5jZSAoSSkNCj4gCVRyYW5zY2VpdmVyIHR5cGUgICAgICAgICAgICAg
ICAgICAgICAgICAgIDogRkM6IFNob3J0d2F2ZSBsYXNlciB3L28gT0ZDIChTTikNCj4gCVRyYW5z
Y2VpdmVyIHR5cGUgICAgICAgICAgICAgICAgICAgICAgICAgIDogRkM6IE11bHRpbW9kZSwgNjIu
NXVtIChNNikNCj4gCVRyYW5zY2VpdmVyIHR5cGUgICAgICAgICAgICAgICAgICAgICAgICAgIDog
RkM6IE11bHRpbW9kZSwgNTB1bSAoTTUpDQo+IAlUcmFuc2NlaXZlciB0eXBlICAgICAgICAgICAg
ICAgICAgICAgICAgICA6IEZDOiA0MDAgTUJ5dGVzL3NlYw0KPiAJVHJhbnNjZWl2ZXIgdHlwZSAg
ICAgICAgICAgICAgICAgICAgICAgICAgOiBGQzogMjAwIE1CeXRlcy9zZWMNCj4gCVRyYW5zY2Vp
dmVyIHR5cGUgICAgICAgICAgICAgICAgICAgICAgICAgIDogRkM6IDEwMCBNQnl0ZXMvc2VjDQo+
IC4uLg0KPiAkIGV0aHRvb2wgLS1qc29uIC1tIHNmcC13YW4NCj4gWyB7DQoNCkkgYW0gYSBiaXQg
Y29uZnVzZWQgYnkgdGhlIHNmcC1sYW4vc2ZwLXdhbiBleGFtcGxlcyBuYW1pbmcuIEluIHRoZSBs
YXN0IHBhdGNoIHRoZSAiQmVmb3JlIiB1c2VkICJzZnAtd2FuIiBhbmQgdGhlICJBZnRlciIgdXNl
ZCAic2ZwLWxhbiIuIFRoaXMgcGF0Y2ggZG9lc27igJl0IGZvbGxvdyB0aGUgc2FtZSBjb252ZW50
aW9uLiBNYXliZSBpdCBpcyBiZXR0ZXIgdG8gdXNlIHRoZSBzYW1lIG1vZHVsZSBmb3IgYm90aCBi
ZWZvcmUgYW5kIGFmdGVyLg0KDQo+IC4uLg0KPiAgICAgICAgICJ0cmFuc2NlaXZlcl9jb2RlcyI6
IFsgMCwwLDAsMSwzMiw2NCwxMiwyMSwwIF0sDQo+ICAgICAgICAgInRyYW5zY2VpdmVyX3R5cGUi
OiBbICJFdGhlcm5ldDogMTAwMEJBU0UtU1giLCJGQzogaW50ZXJtZWRpYXRlIGRpc3RhbmNlDQo+
IChJKSIsIkZDOiBTaG9ydHdhdmUgbGFzZXIgdy9vIE9GQyAoU04pIiwiRkM6IE11bHRpbW9kZSwg
NjIuNXVtIChNNikiLCJGQzoNCj4gTXVsdGltb2RlLCA1MHVtIChNNSkiLCJGQzogNDAwIE1CeXRl
cy9zZWMiLCJGQzogMjAwIE1CeXRlcy9zZWMiLCJGQzoNCj4gMTAwIE1CeXRlcy9zZWMiIF0sIC4u
Lg0KPiAgICAgfSBdDQo+IA0KPiBGaXhlczogNDA3MTg2MmY1OGQ4ICgic2ZwaWQ6IEFkZCBKU09O
IG91dHB1dCBoYW5kbGluZyB0byAtLW1vZHVsZS1pbmZvIGluDQo+IFNGRjgwNzkgbW9kdWxlcyIp
DQo+IFNpZ25lZC1vZmYtYnk6IEFsZWtzYW5kZXIgSmFuIEJhamtvd3NraSA8b2xlazJAd3AucGw+
DQo+IC0tLQ0KDQpUaGFua3MgZm9yIHNlbmRpbmcgdGhpcyBmaXghIA0K

