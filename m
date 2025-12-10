Return-Path: <netdev+bounces-244198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5571CCB252C
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 08:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A822303AE8E
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 07:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF47D2652BD;
	Wed, 10 Dec 2025 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="VEDtIx/P"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012032.outbound.protection.outlook.com [52.101.66.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038C523D7E6;
	Wed, 10 Dec 2025 07:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765353064; cv=fail; b=sacVl1kqxp2wP70xyExcMxWkGwYC2VN93e56RaPrlGpwO7/kQb5MiqJPlV7s+u/LanlW5tzSQFxH5Xcj4oSNOl4F9gn5dSRgJGEDnZLPIF+HTbVGRT+a/YrocRawScSDfYuSrI0+FdZikQfceORiIoGvj0jNZgooc7TZEzvDDU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765353064; c=relaxed/simple;
	bh=W+x6rqsDeDlib2QY0SrZ6a4LimArhsJLT+IN59G4XPI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EveTeZBc0VHQlbbMoi3ghz8ZOJkzgw7FExR4UFmWMGdkfwso8d2IS/Pp+lvVkiwglm7USjIwjyd3lYsohIkxcZkeQcKbQaQB4utAO0PfboV3IBO5Cwkx8f3ZYI7SqpPCM4DO65CgvRCB35XGAkcP7h3cpJ38sj17eo5uhLzrLY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=VEDtIx/P; arc=fail smtp.client-ip=52.101.66.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2mOlEUi5MiIv/ZJLc95Kz9kzi4Y64pWDg/m7OnrZv0I1fNUha/dSXJMV/bGN6j/5safO5QmVu9oxhnHZ/mFQcNs/t+8KrtrDOfWJoGtJ4sXWLsem1J3kKrmD4D1KhgRYV8XumGHoDbew9lMdhzijYeiMhkNgtm/wYWXum3aBDedGrRdYhtw7I5K92CpbYvKDQVwLfzh7g1Qcnrm+B6GpL7arYoZk/nZQMstUk2xfCbFES2r32exe/jGvp991wcohDGlEBI4h6mEK0atRv2UqKuUjhR61PYsBNWCqtGfdsoZ7xTnbGNUPjZutavbGQfWBelDwoAYZP3dGJbJXg+oeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+x6rqsDeDlib2QY0SrZ6a4LimArhsJLT+IN59G4XPI=;
 b=dWr2BWkjK3H92lDFjnJcQSFohHf0A5JidtTAP7ESVKRzbU8ny2fBfzaI1Y6Fs0arp65CGX3I+oL/eH9hHhF9eW0ivD7yA31nlUBCw23oX2PwFJKSHjIXW61cmpj2pZYOhHYPkbuZ+/c8ibdHM0XCINrb+7Cw+78v3al78Fz8fsQpz0S3x6N/bvAIZngKR/fxlUfjCkQnYG6mjlcQvH8Q1nRngxjT2PrKCx0u5JwUTJWrshKjduLQ01OSfXYXdQUo15y6wvA1rz9H5jZ9b+c8IJiPdp9iHi80MUSUjwmdkmBtzdWM7+N+DWQn6BXG6nMr17hm8xqU+DWXQ5nH7P+KAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+x6rqsDeDlib2QY0SrZ6a4LimArhsJLT+IN59G4XPI=;
 b=VEDtIx/P5hNWv1nUzY0w703JmZZhAzVQ2dU+hrD/JvAyeuxumuzZesaLuDqgCv0n8zMIuAZ8xaozg4uA8LlprwSI7sI7Q4gNawBBTY+LmAYtBv+HSwNRlghWg30sacJrPddvWZYtYx0NTV2yu9Lv4Kf3OGaadVRHKBk2OD39Kke25zxTsQHYpAelUkC3IP04IFlMcK0prEduM/Bj5HKwYalqS4pJaDfsJaXYqbDrQjjTcXLFfgHHFmhqa5GB1xkaxf5vFcjWBTtaqmvUIW5Neqb4r3MGrE9O8bYAvdK3Yh9WmT6Z91xKIKb6qO9QWPIrmnfYZw727VfmauNRz+nBGQ==
Received: from AS1PR10MB5392.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:48d::20)
 by DU0PR10MB6560.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:403::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Wed, 10 Dec
 2025 07:50:55 +0000
Received: from AS1PR10MB5392.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::456e:d0d0:15:f4e]) by AS1PR10MB5392.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::456e:d0d0:15:f4e%6]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 07:50:55 +0000
From: "Behera, VIVEK" <vivek.behera@siemens.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: [PATCH v5 iwl-net] igc: Fix trigger of incorrect irq in
 igc_xsk_wakeup function
Thread-Topic: [PATCH v5 iwl-net] igc: Fix trigger of incorrect irq in
 igc_xsk_wakeup function
Thread-Index: AQHcaam3MPdOSehKtkaI1PtAy/5GiA==
Date: Wed, 10 Dec 2025 07:50:55 +0000
Message-ID:
 <AS1PR10MB5392FCA415A38B9DD7BB5F218FA0A@AS1PR10MB5392.EURPRD10.PROD.OUTLOOK.COM>
References:
 <AS1PR10MB5392B7268416DB8A1624FDB88FA7A@AS1PR10MB5392.EURPRD10.PROD.OUTLOOK.COM>
 <4c90ed4e-307c-429a-9f8c-29032cc146ee@intel.com>
 <AS1PR10MB5392C71EED7AB2446036FB9F8FA3A@AS1PR10MB5392.EURPRD10.PROD.OUTLOOK.COM>
 <AS1PR10MB539202E6B3C43BE259831AD88FA3A@AS1PR10MB5392.EURPRD10.PROD.OUTLOOK.COM>
 <IA3PR11MB89863C74B0554055470B9EE0E5A3A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <IA3PR11MB8986E4ACB7F264CF2DD1D750E5A0A@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To:
 <IA3PR11MB8986E4ACB7F264CF2DD1D750E5A0A@IA3PR11MB8986.namprd11.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=d3ac5aa8-3a96-4e14-95c7-b25deb848df8;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-12-09T05:54:50Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5392:EE_|DU0PR10MB6560:EE_
x-ms-office365-filtering-correlation-id: fb041383-780e-4dea-ac97-08de37c0d99f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?YVI2SktZaUFOQm1UQlVIcy8rL2l1aXZRb1BJenN1ZkEwTVhpbEUrWGh5aEVP?=
 =?utf-8?B?R21YcUtsSTFwYUM2dGNDV3hQTnVzNHBKVFdZL21UNFJmUC9IdHovVUdVTy9T?=
 =?utf-8?B?WnJjNDBVWkg2R24yQVNpWUtCeVNoQ3gxKzdHQTNqTnZDZmEyYUlqL2h2dE9j?=
 =?utf-8?B?NitPeEpzNjk3TWk2YXhLVTkvL1RrQnFLdXVvQWltWDEzUnBNQ3I0YUd4a0lj?=
 =?utf-8?B?U1Q5YXlxVVhZdVNaN1g2ZXFhcGF4TUswcWZNL0FCSmdMZitxbDR3eGJqWmor?=
 =?utf-8?B?TW8wOEtoeGNTNkIrcEZpelAyRmdkcWNaSUc0V0E1cG16ZGVSYmZmc1B5TTli?=
 =?utf-8?B?d0xXS1ZCbkhRWmorVXB5NG1lSEQ3cWxWaHc0MG01VzJnYWxjR1k5b1ZML0JT?=
 =?utf-8?B?ZWllcGVTbVlZZVVrOVVZVkpia0J1RElmZExVUGM3cnFKdndzZXMweVhFUWIv?=
 =?utf-8?B?KzFVc0pvMHU1NXNpcXNTUFJkWHdrK1ZzM0kxNWJtYVRUb2ZjOHFna0V0aXZK?=
 =?utf-8?B?cTh0OVJwWndjUFdpV1J4S3hYNnJONFVtbEY5eUdFMW9nbEd6ZHY0QmFhNEJ4?=
 =?utf-8?B?V0U2alVVREFCWUF5bjJPOU1BeUtLVVk2azVrb0xWdFdOR1I2VGRkL0diLytN?=
 =?utf-8?B?QldQVjdLcDVGYmlwc0xHSmZ2dk02Tm5XVXhTbU5mb0V4czEvRDVaTWkxYzVu?=
 =?utf-8?B?QVhkYTFhc2ZYcHg3ZzBxV2pzRi9nSmZWdUZmMlVGRHB4NFlxVXQxYXNXOUxT?=
 =?utf-8?B?WGJDU3hLa2JJakcyZVg3Uk5sVUhjMVhrZ3dxZmVzeVdoVUJTSDBhY0dmNGJy?=
 =?utf-8?B?Z05rS1ArNnJ2SGJLTXZ5cFFkYW5EMEpYa3Vqc1J2R0FobHFQMTYzNjJ5NXI4?=
 =?utf-8?B?ODZhdkY3Y3FVTUx5OG9uZElHdFBCVjhHRndYbCswcEc3QWY3VDBydlREVTR2?=
 =?utf-8?B?eUF0OGtpcEpCSnMrTEkvdEVOU1BrNmFPWTVPT25PU0hhT3NNSDlqQU9qY0ZF?=
 =?utf-8?B?YjlKR21yZ0M1bjJNellXSXFLQ040N0Q1bk1KdTUwaThEOWJLRkRMdHczdW9Z?=
 =?utf-8?B?RHIyaCthME5yN0pPMVRvOWdhVlhWOUlvMkpwaVp3d25sSVFYZGt4eUtESzU5?=
 =?utf-8?B?d3VSV3ZUUlBuZlFydGlKTVh0ZU93cnREVnhoTE9yM20vSzJYVXVEOVc3bjBL?=
 =?utf-8?B?SDhEUEhlcXpGd001R1dJTlN4VVA4TTFteTBOSkZQeC9abTlwVk51VHVmRjMy?=
 =?utf-8?B?K3h4L29YUWt1SGpMWlhmWWZpa0ZlNS9vUHRZVjBTcTBZbVVXbys2blNXamxy?=
 =?utf-8?B?WmVVYVF0V0J3VmhaUFhOSE11ajdGTkkraEo4VVRiem1XVE12QlZxU1FiOGd5?=
 =?utf-8?B?emZ3dzR3T1ExS0J6SVp1cUlUQ2dQcTF6dVY0blF6UnNaSUxaSUNhN3pYaFpJ?=
 =?utf-8?B?S2ZqSzFRdjlXOURoVmJoM1NqVmpYcFVLa2dQamZqd1VIc3VXRERzV3VnT2hD?=
 =?utf-8?B?U2dqTytkZzMzTzZLU3ZNb1ozbUJOT3pxVDZLM0p4WlpwNlRmakRJZmNraHBK?=
 =?utf-8?B?L2lXckJhczJtL1E5VzVFWEtSL1MxbEwxcUJ5MU92ZHpVNlRPNEpJdFowbFVN?=
 =?utf-8?B?SEc2SFdNUGZ6cEtEbm1zWGdLREtKMlhNNDBBL25Qd1FrcG1ZR0JNMG9ZY1JY?=
 =?utf-8?B?aEhSVWpiOHFIMXE3eU9Rbk1BUlhNQnhZM3dTa3hlcnVqZjdkY2xNYU13Mi9Y?=
 =?utf-8?B?dUhDczh2R3pPVWc2eEFCVDlEUUlWdHc3WWw4di9rMXhvZ0JIemxoWUNwRGdR?=
 =?utf-8?B?SUxEVjRwNTEvQmY5TmxpcXQzbVhHdW9YSTFQWVZVTWxrU3hvTTA4MVloVGNN?=
 =?utf-8?B?NHNQb1lPQnJDbnoyT0thcnBoRndXM3RDRFdYYk8rZFVqTWlZUEZRZGtBOXpa?=
 =?utf-8?B?MHkxNlVNcU05bWJjWER2dlBybGs4VS9PTlgrNTNEYzZ6L3ZSUUtDNllxLzVq?=
 =?utf-8?B?cnJJNEVhbnRhM3NYVlhLLzZwZER2VkZNQkdUVXk0UGJlQTgwM3NzWFpQb0Ju?=
 =?utf-8?B?M29tMGJlSWYvdkJEWloycGNCNVU1U1M0NG9IZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5392.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OXU2LytKZ0dGWi9yK0RSeWc1aEg1M1RuZWs3dDk2dml3K1FVbXVSMzhqbnBR?=
 =?utf-8?B?cUxWMDdlQ1paQXM1akRmdEthZGhmdnp6VHFvanVabXNHS0hCcmdKck8xQUM3?=
 =?utf-8?B?YmZZelNpdzVMVmJ0SXNmUjU3WTlSZ3NYMTF6RTZVNkdxTTBGcnNWdTFCYjV3?=
 =?utf-8?B?cFB5Z1lwS3VMRXNaNVhhZUZXVTk0dXZBMi9jNTJaV0NKbEJha1l2K01ETm1k?=
 =?utf-8?B?MG1YT2cvMjdRZmxiN0owNFBRSlkrUWtMQllUV2Z6eEV5VUxsQzdnbnVicTJM?=
 =?utf-8?B?WHdzcURjL0ZxbnhjT0JoVDh6a1ExZVdGM0lyRlRpVkV3TS9BcmFNc1NTTzA5?=
 =?utf-8?B?OG10UENmWnU5WHRMai92YXI3TW56QzB0cFpPd29kTTNHN3RQd2NmbmprQzRG?=
 =?utf-8?B?eEgrcTk5ZGtwRHY4ckw0WFFFZjNFYWZpV3NkdGRCcUF0N250Z1Q1dXFaRVN1?=
 =?utf-8?B?eXpGdEdkWkpIZ2loaW9ta3NMTVMyQnJ4Mm8xOWNrT3RzK3MzQVIzQmJVaHBC?=
 =?utf-8?B?bCtlWER0TFFLZE9ES3V5dnVmYlhuT2ZNcW1adDhITklSY3NCZWNDTFRWU09Q?=
 =?utf-8?B?NTM3YTUzUDJrRE9sYmRtbXhOb2FBSktEMldmRGJxSFYzNFpUSks2SU1aWHlE?=
 =?utf-8?B?Uys5cGRjaTNWdVNsbm9GdzlTTStKVXppNkJWcEl0MkZtTGtHSjZIZ0lTWVJU?=
 =?utf-8?B?aklPalZjMnJlR091cjBLZFZSNmRoUFh3VDI1WnZIdG4zZCtsMGN3d21XSEVD?=
 =?utf-8?B?TXl0MDB5YVJqNzJ1Y09NcGhnYVRob0pDUzJlZFBhSFUzdE81bWxTck8vZGZG?=
 =?utf-8?B?RWVpUG1NQ2dsaUpVSDZ2VEpQMTlrWXI5U052Slo4YndYaktIemNuSTl5ZWpM?=
 =?utf-8?B?U2R0bWE4amYxMnNKd2xERmVWd2Q5am43b0g5SWZFeEZOdGZUbjNNNHhUQWxG?=
 =?utf-8?B?eDh5a1M1UUJnNjQ0Z0prN3MzNVZXVml3STR5UE5NNUFIK2dTYTRwL3dtZVAv?=
 =?utf-8?B?MnEzUlRjNXhraU1XUHo1WFVreHI2N3lOSVdrdlJrYjhtN01OSDB3L08vd1ZI?=
 =?utf-8?B?ZWlUMlVlYjFKMU9TVmxacFBSQjNjeVpkK3NrV1N2Mzc3UVU5SDhVa0ovUlpj?=
 =?utf-8?B?QnhqaktzTTRZNlVWQkFIT1BNR2Z6M1ppWG1pTzl5eGRTTjVQdVUwZmxuU01M?=
 =?utf-8?B?blF4VmprTDRHS2lKTHBYcHM1RmVrM2FDS21taTBkalYvYkl3RzhiZEk4N3RW?=
 =?utf-8?B?QjJxNWdoWFZYZ2ZGbm9RcGpVa2FaUjd4NUtVeDNJL25BenltRE0xVFFwa0Vr?=
 =?utf-8?B?M0RRZTRZcndXSVg4a0czQWZHb3RLbEVoUk9qWkNLOGg1cVNaY1VrbUFPRTlY?=
 =?utf-8?B?L2V1bWx1SjNHWUtCTlUvNGtlMWRHM0JRL25zMzFIb2JXVmRIZ1VoRHJVeGVK?=
 =?utf-8?B?WVBPdnJJZXg3YTFpdG5FNkJtWHBkL2pqSnVYMDJHUXljanMyclJHRTR6cnEz?=
 =?utf-8?B?Q0t0dVd4UldhR29KcFRHcVY3TGJqVVp2N3hKeHVoVmlrQ1BLVlg2Q21xRWds?=
 =?utf-8?B?YWtlbTFWZmZTNXlxUmhmOTNqRmN2VkRRUkZTWldVQkdkSHNLVTZ5VmJtTUwy?=
 =?utf-8?B?M3FYa1ZPTVlFT1lKR3NUU0o4Q2RjbEpXWnFDbXJrUEtoamNkYXEvclBzTFpK?=
 =?utf-8?B?V2JEMk8zNW5uTno0aC82MFI5NU1RNllPRTQ1UlFMb1FITWcvalFLTnhOb29i?=
 =?utf-8?B?dGV0bVRsRzRTMElITlovR3dIYUNuUDBidHFVcVl6REh1d29QWThMMU0zb3Vq?=
 =?utf-8?B?em10RVgzM0NYTEo2bWcza0tkMmRwOStJa0Y0bzR5OFVQU0VhNWhPZGR3WXA4?=
 =?utf-8?B?eGZDVFJNUGcxMTB6SmtQTG1kQXJ3bjVjYkNJZ2x4eEdWK2lMUnlHbzdIbEhh?=
 =?utf-8?B?N1ZUSWIzQmlYelFTaU0wajZRcHg4ZlNHQ2EybkZvWC9IQjgvM0xhSUVxQ0Jr?=
 =?utf-8?B?M3JRR1p5TWxuWXI2c0hMWEFtRnpyd21PY2JQN1ArMzNDaVBoNjdxRFhBRHQ0?=
 =?utf-8?B?Nlh0U2g0MEprU2lqcnJSdjJ0TkptR3pZNGQraGR0eStkRGdZb3hZSjJyK0tI?=
 =?utf-8?Q?gKj/r84dvf2WvDwcKwKMJc9ky?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5392.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fb041383-780e-4dea-ac97-08de37c0d99f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 07:50:55.7518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LNcrEe73QKwEH2sdDwWkyAiADd2Ipu5NmKpfY4iNlM7VvWZ47cwwpZjPH0I2FSyQx/UYOEK0wuICOgJRlwGpNKsDpwmDQnsDClvXtYmRjD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6560

Q2hhbmdlcyBpbiB2NToNCi0gVXBkYXRlZCBjb21tZW50IHN0eWxlIGZyb20gbXVsdGktc3RhciB0
byBzdGFuZGFyZCAvKiAqLyBhcyBzdWdnZXN0ZWQgYnkgIEFsZWtzYW5kci4NCg0KRnJvbSBhYjI1
ODNmZjhhMTc0MDVkM2FhNmNhZjRkZjFjNGZkZmIyMWY1ZTk4IE1vbiBTZXAgMTcgMDA6MDA6MDAg
MjAwMQ0KRnJvbTogVml2ZWsgQmVoZXJhIDx2aXZlay5iZWhlcmFAc2llbWVucy5jb20+DQpEYXRl
OiBGcmksIDUgRGVjIDIwMjUgMTA6MjY6MDUgKzAxMDANClN1YmplY3Q6IFtQQVRDSCB2NV0gW2l3
bC1uZXRdIGlnYzogRml4IHRyaWdnZXIgb2YgaW5jb3JyZWN0IGlycSBpbg0KIGlnY194c2tfd2Fr
ZXVwIGZ1bmN0aW9uDQoNClRoaXMgcGF0Y2ggYWRkcmVzc2VzIHRoZSBpc3N1ZSB3aGVyZSB0aGUg
aWdjX3hza193YWtldXAgZnVuY3Rpb24NCndhcyB0cmlnZ2VyaW5nIGFuIGluY29ycmVjdCBJUlEg
Zm9yIHR4LTAgd2hlbiB0aGUgaTIyNiBpcyBjb25maWd1cmVkDQp3aXRoIG9ubHkgMiBjb21iaW5l
ZCBxdWV1ZXMgb3IgaW4gYW4gZW52aXJvbm1lbnQgd2l0aCAyIGFjdGl2ZSBDUFUgY29yZXMuDQpU
aGlzIHByZXZlbnRlZCBYRFAgWmVyby1jb3B5IHNlbmQgZnVuY3Rpb25hbGl0eSBpbiBzdWNoIHNw
bGl0IElSUQ0KY29uZmlndXJhdGlvbnMuDQoNClRoZSBmaXggaW1wbGVtZW50cyB0aGUgY29ycmVj
dCBsb2dpYyBmb3IgZXh0cmFjdGluZyBxX3ZlY3RvcnMgc2F2ZWQNCmR1cmluZyByeCBhbmQgdHgg
cmluZyBhbGxvY2F0aW9uIGFuZCB1dGlsaXplcyBmbGFncyBwcm92aWRlZCBieSB0aGUNCm5kb194
c2tfd2FrZXVwIEFQSSB0byB0cmlnZ2VyIHRoZSBhcHByb3ByaWF0ZSBJUlEuDQoNCkNoYW5nZWQg
Y29tbWVudCBibG9ja3MgdG8gYWxpZ24gd2l0aCBzdGFuZGFyZCBMaW51eCBjb21tZW50cw0KDQpG
aXhlczogZmM5ZGYyYTBiNTIwZDdkNDM5ZWNmNDY0Nzk0ZDUzZTkxYmU3NGI5MyAoImlnYzogRW5h
YmxlIFJYIHZpYSBBRl9YRFAgemVyby1jb3B5IikNCkZpeGVzOiAxNWZkMDIxYmM0MjcwMjczZDhm
NGI3ZjU4ZmRkYThhMTYyMTRhMzc3ICgiaWdjOiBBZGQgVHggaGFyZHdhcmUgdGltZXN0YW1wIHJl
cXVlc3QgZm9yIEFGX1hEUCB6ZXJvLWNvcHkgcGFja2V0IikNClNpZ25lZC1vZmYtYnk6IFZpdmVr
IEJlaGVyYSA8dml2ZWsuYmVoZXJhQHNpZW1lbnMuY29tPg0KUmV2aWV3ZWQtYnk6IEphY29iIEtl
bGxlciA8amFjb2Iua2VsbGVyQGludGVsLmNvbT4NClJldmlld2VkLWJ5OiBBbGVrc2FuZHIgbG9r
dGlub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0KLS0tDQogZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmMgfCA4MSArKysrKysrKysrKysrKysrKystLS0t
LQ0KIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2NfcHRwLmMgIHwgIDIgKy0NCiAy
IGZpbGVzIGNoYW5nZWQsIDY0IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmMgYi9kcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjX21haW4uYw0KaW5kZXggN2FhZmE2MGJhMGM4
Li5jN2JmNWE0Yjg5ZTkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9p
Z2MvaWdjX21haW4uYw0KKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19t
YWluLmMNCkBAIC02OTA4LDIxICs2OTA4LDEzIEBAIHN0YXRpYyBpbnQgaWdjX3hkcF94bWl0KHN0
cnVjdCBuZXRfZGV2aWNlICpkZXYsIGludCBudW1fZnJhbWVzLA0KIAlyZXR1cm4gbnhtaXQ7DQog
fQ0KIA0KLXN0YXRpYyB2b2lkIGlnY190cmlnZ2VyX3J4dHhxX2ludGVycnVwdChzdHJ1Y3QgaWdj
X2FkYXB0ZXIgKmFkYXB0ZXIsDQotCQkJCQlzdHJ1Y3QgaWdjX3FfdmVjdG9yICpxX3ZlY3RvcikN
Ci17DQotCXN0cnVjdCBpZ2NfaHcgKmh3ID0gJmFkYXB0ZXItPmh3Ow0KLQl1MzIgZWljcyA9IDA7
DQotDQotCWVpY3MgfD0gcV92ZWN0b3ItPmVpbXNfdmFsdWU7DQotCXdyMzIoSUdDX0VJQ1MsIGVp
Y3MpOw0KLX0NCi0NCiBpbnQgaWdjX3hza193YWtldXAoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwg
dTMyIHF1ZXVlX2lkLCB1MzIgZmxhZ3MpDQogew0KIAlzdHJ1Y3QgaWdjX2FkYXB0ZXIgKmFkYXB0
ZXIgPSBuZXRkZXZfcHJpdihkZXYpOw0KKwlzdHJ1Y3QgaWdjX2h3ICpodyA9ICZhZGFwdGVyLT5o
dzsNCiAJc3RydWN0IGlnY19xX3ZlY3RvciAqcV92ZWN0b3I7DQogCXN0cnVjdCBpZ2NfcmluZyAq
cmluZzsNCisJdTMyIGVpY3MgPSAwOw0KIA0KIAlpZiAodGVzdF9iaXQoX19JR0NfRE9XTiwgJmFk
YXB0ZXItPnN0YXRlKSkNCiAJCXJldHVybiAtRU5FVERPV047DQpAQCAtNjkzMCwxOCArNjkyMiw3
MSBAQCBpbnQgaWdjX3hza193YWtldXAoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgdTMyIHF1ZXVl
X2lkLCB1MzIgZmxhZ3MpDQogCWlmICghaWdjX3hkcF9pc19lbmFibGVkKGFkYXB0ZXIpKQ0KIAkJ
cmV0dXJuIC1FTlhJTzsNCiANCi0JaWYgKHF1ZXVlX2lkID49IGFkYXB0ZXItPm51bV9yeF9xdWV1
ZXMpDQotCQlyZXR1cm4gLUVJTlZBTDsNCisJaWYgKChmbGFncyAmIFhEUF9XQUtFVVBfUlgpICYm
IChmbGFncyAmIFhEUF9XQUtFVVBfVFgpKSB7DQorCQkvKiBJZiBib3RoIFRYIGFuZCBSWCBuZWVk
IHRvIGJlIHdva2VuIHVwICovDQorCQkvKiBjaGVjayBpZiBxdWV1ZSBwYWlycyBhcmUgYWN0aXZl
LiAqLw0KKwkJaWYgKChhZGFwdGVyLT5mbGFncyAmIElHQ19GTEFHX1FVRVVFX1BBSVJTKSkgew0K
KwkJCS8qIEp1c3QgZ2V0IHRoZSByaW5nIHBhcmFtcyBmcm9tIFJ4ICovDQorCQkJaWYgKHF1ZXVl
X2lkID49IGFkYXB0ZXItPm51bV9yeF9xdWV1ZXMpDQorCQkJCXJldHVybiAtRUlOVkFMOw0KKwkJ
CXJpbmcgPSBhZGFwdGVyLT5yeF9yaW5nW3F1ZXVlX2lkXTsNCisJCX0gZWxzZSB7DQorCQkJLyog
VHdvIGlycXMgZm9yIFJ4IEFORCBUeCBuZWVkIHRvIGJlIHRyaWdnZXJlZCAqLw0KKwkJCWlmIChx
dWV1ZV9pZCA+PSBhZGFwdGVyLT5udW1fcnhfcXVldWVzKQ0KKwkJCQlyZXR1cm4gLUVJTlZBTDsg
LypxdWV1ZV9pZCBpcyBpbnZhbGlkKi8NCiANCi0JcmluZyA9IGFkYXB0ZXItPnJ4X3JpbmdbcXVl
dWVfaWRdOw0KKwkJCWlmIChxdWV1ZV9pZCA+PSBhZGFwdGVyLT5udW1fdHhfcXVldWVzKQ0KKwkJ
CQlyZXR1cm4gLUVJTlZBTDsgLyogcXVldWVfaWQgaW52YWxpZCAqLw0KIA0KLQlpZiAoIXJpbmct
Pnhza19wb29sKQ0KLQkJcmV0dXJuIC1FTlhJTzsNCisJCQkvKiBJUlEgdHJpZ2dlciBwcmVwYXJh
dGlvbiBmb3IgUnggKi8NCisJCQlyaW5nID0gYWRhcHRlci0+cnhfcmluZ1txdWV1ZV9pZF07DQor
CQkJaWYgKCFyaW5nLT54c2tfcG9vbCkNCisJCQkJcmV0dXJuIC1FTlhJTzsNCiANCi0JcV92ZWN0
b3IgPSBhZGFwdGVyLT5xX3ZlY3RvcltxdWV1ZV9pZF07DQotCWlmICghbmFwaV9pZl9zY2hlZHVs
ZWRfbWFya19taXNzZWQoJnFfdmVjdG9yLT5uYXBpKSkNCi0JCWlnY190cmlnZ2VyX3J4dHhxX2lu
dGVycnVwdChhZGFwdGVyLCBxX3ZlY3Rvcik7DQorCQkJLyogUmV0cmlldmUgdGhlIHFfdmVjdG9y
IHNhdmVkIGluIHRoZSByaW5nICovDQorCQkJcV92ZWN0b3IgPSByaW5nLT5xX3ZlY3RvcjsNCisJ
CQlpZiAoIW5hcGlfaWZfc2NoZWR1bGVkX21hcmtfbWlzc2VkKCZxX3ZlY3Rvci0+bmFwaSkpDQor
CQkJCWVpY3MgfD0gcV92ZWN0b3ItPmVpbXNfdmFsdWU7DQorCQkJLyogSVJRIHRyaWdnZXIgcHJl
cGFyYXRpb24gZm9yIFR4ICovDQorCQkJcmluZyA9IGFkYXB0ZXItPnR4X3JpbmdbcXVldWVfaWRd
Ow0KIA0KKwkJCWlmICghcmluZy0+eHNrX3Bvb2wpDQorCQkJCXJldHVybiAtRU5YSU87DQorDQor
CQkJLyogUmV0cmlldmUgdGhlIHFfdmVjdG9yIHNhdmVkIGluIHRoZSByaW5nICovDQorCQkJcV92
ZWN0b3IgPSByaW5nLT5xX3ZlY3RvcjsNCisJCQlpZiAoIW5hcGlfaWZfc2NoZWR1bGVkX21hcmtf
bWlzc2VkKCZxX3ZlY3Rvci0+bmFwaSkpDQorCQkJCWVpY3MgfD0gcV92ZWN0b3ItPmVpbXNfdmFs
dWU7IC8qIEV4dGVuZCB0aGUgQklUIG1hc2sgZm9yIGVpY3MgKi8NCisNCisJCQkvKiBOb3cgd2Ug
dHJpZ2dlciB0aGUgc3BsaXQgaXJxcyBmb3IgUnggYW5kIFR4IG92ZXIgZWljcyAqLw0KKwkJCWlm
IChlaWNzICE9IDApDQorCQkJCXdyMzIoSUdDX0VJQ1MsIGVpY3MpOw0KKw0KKwkJCXJldHVybiAw
Ow0KKwkJfQ0KKwl9IGVsc2UgaWYgKGZsYWdzICYgWERQX1dBS0VVUF9UWCkgew0KKwkJaWYgKHF1
ZXVlX2lkID49IGFkYXB0ZXItPm51bV90eF9xdWV1ZXMpDQorCQkJcmV0dXJuIC1FSU5WQUw7DQor
CQkvKiBHZXQgdGhlIHJpbmcgcGFyYW1zIGZyb20gVHggKi8NCisJCXJpbmcgPSBhZGFwdGVyLT50
eF9yaW5nW3F1ZXVlX2lkXTsNCisJfSBlbHNlIGlmIChmbGFncyAmIFhEUF9XQUtFVVBfUlgpIHsN
CisJCWlmIChxdWV1ZV9pZCA+PSBhZGFwdGVyLT5udW1fcnhfcXVldWVzKQ0KKwkJCXJldHVybiAt
RUlOVkFMOw0KKwkJLyogR2V0IHRoZSByaW5nIHBhcmFtcyBmcm9tIFJ4ICovDQorCQlyaW5nID0g
YWRhcHRlci0+cnhfcmluZ1txdWV1ZV9pZF07DQorCX0gZWxzZSB7DQorCQkvKiBJbnZhbGlkIEZs
YWdzICovDQorCQlyZXR1cm4gLUVJTlZBTDsNCisJfQ0KKwkvKiBQcmVwYXJlIHRvIHRyaWdnZXIg
c2luZ2xlIGlycSAqLw0KKwlpZiAoIXJpbmctPnhza19wb29sKQ0KKwkJcmV0dXJuIC1FTlhJTzsN
CisJLyogUmV0cmlldmUgdGhlIHFfdmVjdG9yIHNhdmVkIGluIHRoZSByaW5nICovDQorCXFfdmVj
dG9yID0gcmluZy0+cV92ZWN0b3I7DQorCWlmICghbmFwaV9pZl9zY2hlZHVsZWRfbWFya19taXNz
ZWQoJnFfdmVjdG9yLT5uYXBpKSkgew0KKwkJZWljcyB8PSBxX3ZlY3Rvci0+ZWltc192YWx1ZTsN
CisJCXdyMzIoSUdDX0VJQ1MsIGVpY3MpOw0KKwl9DQogCXJldHVybiAwOw0KIH0NCiANCmRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjX3B0cC5jIGIvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19wdHAuYw0KaW5kZXggYjdiNDZkODYzYmVlLi42
ZDhjMmQ2MzljZDcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2Mv
aWdjX3B0cC5jDQorKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjX3B0cC5j
DQpAQCAtNTUwLDcgKzU1MCw3IEBAIHN0YXRpYyB2b2lkIGlnY19wdHBfZnJlZV90eF9idWZmZXIo
c3RydWN0IGlnY19hZGFwdGVyICphZGFwdGVyLA0KIAkJdHN0YW1wLT5idWZmZXJfdHlwZSA9IDA7
DQogDQogCQkvKiBUcmlnZ2VyIHR4cnggaW50ZXJydXB0IGZvciB0cmFuc21pdCBjb21wbGV0aW9u
ICovDQotCQlpZ2NfeHNrX3dha2V1cChhZGFwdGVyLT5uZXRkZXYsIHRzdGFtcC0+eHNrX3F1ZXVl
X2luZGV4LCAwKTsNCisJCWlnY194c2tfd2FrZXVwKGFkYXB0ZXItPm5ldGRldiwgdHN0YW1wLT54
c2tfcXVldWVfaW5kZXgsIFhEUF9XQUtFVVBfVFgpOw0KIA0KIAkJcmV0dXJuOw0KIAl9DQotLSAN
CjIuMzQuMQ0K

