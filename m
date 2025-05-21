Return-Path: <netdev+bounces-192148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1030ABEAB9
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 06:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F681BA28E7
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 04:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F1122FDE2;
	Wed, 21 May 2025 04:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zenlayer.onmicrosoft.com header.i=@zenlayer.onmicrosoft.com header.b="elyV6ADr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2096.outbound.protection.outlook.com [40.107.100.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8A2230BC3;
	Wed, 21 May 2025 04:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747800639; cv=fail; b=FeTmBgbbcWFBIJ9RuQrvM8m40U3IQ+JxQCzTY96yZApmRqU7DHblTOSYnOmPPR/Xnuin7AJy4uRYei6mzo1PHVhIhp01hkFold7anXNNd+84CKUwpA+KEH7CXvfTp2nqJI0OsAjlM1MKdlpiVJT0pTyKMTkiLAJGZFAnYKN3NhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747800639; c=relaxed/simple;
	bh=mhaJx5QZxFQOuWmFSXw5k65EOuzLLfZUi8RplgxWJwk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a7YWTVI458B3V/c5IrsiYDm/myFIrW7uEYD9HCv1ocLXnQZ5oR8jGPC+yybYZa3NZqicqHtEQNN+qNrhsGd24t+AgP6CP7PwBV47cOu+/UmsQKM8uSZtk5hKBb+z/fGGsnlnr9aVkGdsWL81VSh6wirwDRgo+QaeHDmrLjd/wU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zenlayer.com; spf=pass smtp.mailfrom=zenlayer.com; dkim=pass (1024-bit key) header.d=zenlayer.onmicrosoft.com header.i=@zenlayer.onmicrosoft.com header.b=elyV6ADr; arc=fail smtp.client-ip=40.107.100.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zenlayer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zenlayer.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNtRLw+lwfUQdJ0YSiWgrfCxClW+8FcQV7r4JKEZni2u6U7Du8ztdPl2A2RY0uwAv+wHFNb31Puon+ba1xhghKU1E6iWlGsNfkyAh9l6h+39dg1HoGGl934QfSLATXz5XAGi1L+d+SQhtba2PwpxH72UfveeoUYfDuE7SyRDUjsgpKRJQ6gf7fKkFJ/zUW3RlILoAjU4rZH4JyIuvYbThGgYixlQvP5Im3+yE9tkbJE0z1q1uwo8IzlSImE0m2/PfJyTDxMcjKrq9Z86uSgI+uYV7q5F/HupQeIecaqpHhvekXRHhkxt7MwTvUVbIGiOqQ85yahOD2W8PGzYSaMsOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhaJx5QZxFQOuWmFSXw5k65EOuzLLfZUi8RplgxWJwk=;
 b=g1coq0eyU4w+hzHgF326hHg3UHJm1SJUXmdn/DQkTN/cQKN/ghZYmkE1OIYpTK6TZX5U4ubmsd5NRXHQAJZArPpchWfxUeADFNl08erwu8yJ9r+wxENnP4+OhcvP3qqBjic1W8L672qq57JlgEUQrQ3L/5lRaJ+qieQ7LYR8W4JpisLQQRGNhWK0JTYP0IHrXkgMVVvHH7TXNbgXAVEglbIojGXpfJfOULARKQZ8unPY8vqGXswG6/dpTyqKLQHPJWuwiD4fwokANiL3NDvVcl03CYv8cb0iW83KKPH8a6/r2m7h39bwpIko+SYKhbqU053ZTIKhdE3tAR5AoZgFTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenlayer.com; dmarc=pass action=none header.from=zenlayer.com;
 dkim=pass header.d=zenlayer.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=zenlayer.onmicrosoft.com; s=selector2-zenlayer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhaJx5QZxFQOuWmFSXw5k65EOuzLLfZUi8RplgxWJwk=;
 b=elyV6ADrKJIgtJNgPhb6q4rIL2jeswEMHyx/0NHsFGHkbS7mSdQ1x24bGA1OVjUgU/QxPBaWCf88VtdbfF6WzfTa2HElDihk79YLQY3Lnjbbf8Q8Fe2opBVqrrAfQ7sT6OqNX1Vw+e73wHdeCd9vEzv4bZJmLXq/iebuSz0masI=
Received: from SJ0PR20MB6079.namprd20.prod.outlook.com (2603:10b6:a03:4d7::19)
 by SJ2PR20MB6973.namprd20.prod.outlook.com (2603:10b6:a03:569::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 04:10:33 +0000
Received: from SJ0PR20MB6079.namprd20.prod.outlook.com
 ([fe80::2c78:c02d:92:3811]) by SJ0PR20MB6079.namprd20.prod.outlook.com
 ([fe80::2c78:c02d:92:3811%4]) with mapi id 15.20.8699.019; Wed, 21 May 2025
 04:10:33 +0000
From: Faicker Mo <faicker.mo@zenlayer.com>
To: Ilya Maximets <i.maximets@ovn.org>, Eelco Chaudron <echaudro@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"ovs-dev@openvswitch.org" <ovs-dev@openvswitch.org>, "aconole@redhat.com"
	<aconole@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dev@openvswitch.org" <dev@openvswitch.org>
Subject: Re: Re: [PATCH] net: openvswitch: Fix the dead loop of MPLS parse
Thread-Topic: Re: [PATCH] net: openvswitch: Fix the dead loop of MPLS parse
Thread-Index: AQHbygZLA6KJjI8lJ0CrpaQiWARQNw==
Date: Wed, 21 May 2025 04:10:32 +0000
Message-ID: <FA285FD8-1F28-4682-A717-570E2B528EFB@zenlayer.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenlayer.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR20MB6079:EE_|SJ2PR20MB6973:EE_
x-ms-office365-filtering-correlation-id: 05c1eaee-9fdd-4f31-7ad8-08dd981d6eb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SHM3aURKMVNaTGthYVIzZ2tFMG04TExDcU9uSEtkNGMrT1BrL25mRk4vK1dD?=
 =?utf-8?B?NTdzNGFsS2VWOVA4aXNDcGtIWjFrcDBXM2FUcm1qMmRDaVdGNzA2R0NkdmNR?=
 =?utf-8?B?bkx5MWtKZWFkcU5hbjh2ZGJsVDA4NWlxV0lkQmlTY1dDdDMrZGpDZ2JGbUtp?=
 =?utf-8?B?MjhhTnNqdUhvK3k2UFFmVStuaWhMNWpyNmNvVmcxQkNsWDV0YWVEdXNJMDIw?=
 =?utf-8?B?MkVKMEwrOXdJUTV4b08rNXMrZGh2NjMwby9iOFJKcUZYc1Bmdllab0owenR6?=
 =?utf-8?B?Wi84YWhzYUJBWmorMDdjZkRjdGFGQjBFRjJ5Y3pCUmI4c2FmVHhjM0lISnU1?=
 =?utf-8?B?ODRYODBiTHN2eTYwS0NvRFNEVFA3QXJGZ2Q1ejZyaW9oTS9pcWJCZmt2bFlW?=
 =?utf-8?B?SUhlNmhXaWVKV1VINDc4bVNzeWliR0dlS3RMQ1lLUXdjdGJEU2lOSXd1bzdl?=
 =?utf-8?B?SFdUc09vMDh5VUZJYUlDRlZTbWl4Vk9vRUZIWXlGZ2t4ZXdOdk9LY2FmNXk4?=
 =?utf-8?B?R0ltY3BtclFydWVNNTBDMnFQTVdlaGxwM0JtaFM2ZC81UHVNMnBLK2MwZkpD?=
 =?utf-8?B?b3JQYjZkTEtJVGFTWjdjdWtBTUhuTGVlNm80TFJmWjV5TVdvMmxJTmREWTVH?=
 =?utf-8?B?SW1oU1RJQ0h4ZWR4NVptZlNJS2tlTW9zMFlyWXo3elI4eUEvZEFFQnliUWJI?=
 =?utf-8?B?YUYzQ3ZNV0NnMU5qdzhLU2wwWEhnbmxOTnhLUEJkSlBIcmViZWlXTFpyL1lT?=
 =?utf-8?B?QXZMb2tzNVE2dTE0TmhubXhka0hrYmJNdHIvaC9LV3RlRStZTDdWcXRVVUlo?=
 =?utf-8?B?Z0V4QVZZT1hJS08yU2xjQkcvUGV2WnlwR1B0cXlhS0VuVm9NSFVkcnZKWTY1?=
 =?utf-8?B?UmNJVDljMmEwYzlXMkU1b1hSdVVuWWZLZXFYTEVvWW5zRk05dkJvdWdaVDRN?=
 =?utf-8?B?SEhLcDFnK1BLZmtaeXU5VER0bFR0M2Fod3BmVXo3b1lBMGVDcGJnNGNEM0E0?=
 =?utf-8?B?WitqMm1Pak9ZOCtpTS9kV09wMXh4NGhoaHpWSG5WTmIwSVFGTC9lRHo3a3Mw?=
 =?utf-8?B?dzNNTkVtZUJGbjBXRktSd2F1YzhxY2JRY0lGRnZ4dmZubG0yb3NoMjkxYUNR?=
 =?utf-8?B?SmF3T041MGl2Y012TlEvSW5BWHJDZ2l5b2xoTjBsNlRHdUovdzhzUXk3OEVG?=
 =?utf-8?B?VGQ2RGUwbmJKM25GdUtiSm5JU2tFOE8yemRSVElrdURUS0NpWjMrc1dNVTFI?=
 =?utf-8?B?bVRSMTMyUGJsV2RBQ1VIQ1JqdjdFL3hzVnJLa3RhYXM5TWd2Z25zNGtRb2kw?=
 =?utf-8?B?VDNnUThOa3E4T3RrM3Zmb2tGbmtnanI2M2luREpQN280eFJ1ZVZJckk3MzVB?=
 =?utf-8?B?VTR3RGNHWXJTWjhLK0U1eCsxTGFOVlRQd2xzK1ZPc1VxRTdsVEFVcGRmVjBx?=
 =?utf-8?B?VlBLZ2hLVm1WaEdXcDBraXFVVUxuTFk5dEJ6MVppVC91RlZmenMyazZ0Y3Rn?=
 =?utf-8?B?WDByc2wvVTlKaEFWdlloNkZJc1V4OVpLb21wUGdTNTMyYjNLOWt1OHVGcS9u?=
 =?utf-8?B?TVVwSVJSZElZRSs1Rk95YmZha3YxTlJBRTYrUFErcDNFaEx3K3hsUlBMSk8v?=
 =?utf-8?B?RXord0MwU1dVL0pLcEZxT2pXYThyNWZjZEZIU294b0pwbW96YTFnNll1emp1?=
 =?utf-8?B?aG16SWxvaGpTWWpwRDJhdnRocUlTaWFIY0szZFc4TU1tNlpwN245a3V1bXlQ?=
 =?utf-8?B?QzVhSWwxd0JubEdISlNIbFA1UWxLbDh6ZmY5OURKWmR0T3c2Nzh0UHJVclFL?=
 =?utf-8?B?bjlmNlpOSGg0Z2dTM3Z3Wnl4bGN3RzBQTGFWekVuK05zUXZTMHAzM3IxdVhw?=
 =?utf-8?B?bVVaWU5qSDVydUNrRXRGaHVjL2w1enlaeEtCdUhSWFpMQnFla1Q5NnBySFFu?=
 =?utf-8?Q?2v8paDLPVuM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR20MB6079.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUFnelF0Y1RGR1pEbWRJdmF4SXcyU1UvVnNnbk5jT2NiVHVEdVNPVm9SNXVG?=
 =?utf-8?B?N0E3ejVpOVl1SlQ0QlJaVVRKMzhKSzJyQkVCN1EwRFhGNXdsa3hzVE9oSEc2?=
 =?utf-8?B?dHJ1Qk1rbDZVL3VUNVZrdHhYNTI1QkJYOHR4d01ibk5JbHdoZVhVMFJxUWtO?=
 =?utf-8?B?RGNYR0VSK2lEYkNPOHFNL1BHOCtqUW1jaGdQeVdJdWl0a1BKOThpYzdxb3JF?=
 =?utf-8?B?eHVHMkF1cTdlSEMrV3Z4Q2RkRmNXa21hOWI0MjVjZ3hITmhOUElmR2NjaHpK?=
 =?utf-8?B?MnVRcllqdWFBQjU0SWNVYy9vWEw4RGFxTkNtUWhpSmQxVU83bVZGRk40bmZt?=
 =?utf-8?B?dUszY2w2MGVJWk1LVDlRQWYrZFBFSC9xbitFY3hEbys4T3VQN0NhY3Bob1Yy?=
 =?utf-8?B?dmYwaTM0SVY5Nmh1QUpjbUdkbG1maENmKzVPTzl1bXBmS2RMM3gyU1U0cjAz?=
 =?utf-8?B?SmFkRVFSSm5XVFBLUjU1MEN2TWhJckZRV2ZTWGROQ05lZjduRGdnR25nUkU4?=
 =?utf-8?B?a3FXVC93emxSb3M0RnR1UzhUMEtCN2JvSWxTanc4K0lGZ0d3K2VMcURWU0Zy?=
 =?utf-8?B?MExhWklxd0NEdTVRS3NUTklPTHRVU1RvSml1Ly9nV0h4TUhJUHhYeVRhU1kv?=
 =?utf-8?B?YzV3V3lVcHdRWXZyNlJudXUyUCtCVTQ5emNKdGlYVUsrVlNqQ1RSb09BcDRx?=
 =?utf-8?B?Um4zQy9mUEtYSXMxeklKdDlVUUJFRGIzb0xvVy9sVFJkeEkxTTE2ZU1ZZW0z?=
 =?utf-8?B?bi9GbFg4TTlwM21BUjBueFJoN2ZGRnVnUjBGRFBBM0x0T1VrelNjVHNaYkcx?=
 =?utf-8?B?bDNTK0ZsTG1VeHVjZjdVNlhIUUIzMG5RRHF4UldUQjgyZnkrZUtlLzZPL1l0?=
 =?utf-8?B?S1NxZ0NOdG1Bc2ROd3lnOTJmeWUzb2JGTkk2dnQ4L3ovV0dVOEhncEhLd3Bv?=
 =?utf-8?B?blhBSlpGSktuaklOU0Y3S3NTRGhIeDhvWmFnQllkb0ZiamJ3aDNkcThtRGs4?=
 =?utf-8?B?Wm53MGVYeTE2VTFielRXc0pOSEhrSDZYWUYvM1hyTXM1SWlqOGkxN2FhMEMw?=
 =?utf-8?B?UUUxMGtTSXBqL1pwVEErUTNtbTlQY1dnU2V4MENaNkRjUFVBUFp2TlhUcGor?=
 =?utf-8?B?TEdqMkdVQkhiTWoyTUcxcnpURHNJUDYzZmJjTDZMV3o5RmNrbk5LNHFhRTRt?=
 =?utf-8?B?SnpreVlIeDBuRE5qZVVNK2l5bk9mRDJPcm9TOWNNS3pVMHplVkNjd0NUbWFY?=
 =?utf-8?B?YTRqbUtaSUdjdjVQMVgzVXBMaVVGSlU5bTFYTHVLTHFhcmZYMEZweFFyVnlt?=
 =?utf-8?B?b0JSTU85VVBCSDcycklyRml3TSs5SFRqb1BXMnJ0cklFWDdvR1o1T0RydE5K?=
 =?utf-8?B?L1dpMHFUVDdwbFdTNFdlY1RxV3diUll0T1dFSmlvRzR3RzdHWEYyNkJZa2xX?=
 =?utf-8?B?Nm5OUW1ueEpDcmRGd2VYbEJ5Q0F0SHNNdnJjMG4vOXNTblQzenpOQ21ZaytH?=
 =?utf-8?B?eVRQTUJMeXF2TWdteGc4WUJNZ3VBaUpwU1ZsLzN4R2F2ZDJiSGdQN3FFamhQ?=
 =?utf-8?B?Y0R0NnJZUW0rTXllUjZaeFJLajAwT24vRllYNmw0cEVMdGF5SkgvZUsrZnJm?=
 =?utf-8?B?aytoalR5QTBYbTlnMEJud1JYOEd5QnB3OGtXTXhkU0lWa1RKcEVEKzhRUlFi?=
 =?utf-8?B?Q0Rmd2t1SUNGQjNocDZZaGdNVWR4c1Y0Y2lOa0plU0ZtZDFvTk5qcFlHcmlv?=
 =?utf-8?B?b2JHeE5HZEh0Tk5hUjFDTE9ISjljeEEyeTRMRjJSZk9JYkQwcitLNXQ0VHVW?=
 =?utf-8?B?U2Y1VmMwakhqYkdnaldjWTBQdExxN2VmOEtvYVV6UzlnVHlvcDM4cTNOcWJt?=
 =?utf-8?B?cHJiWExtTy9wdC9sRkgzbFQxUDUyWk1uRUplZGxPRUpCVTFsYm0vT2Y1Y3ox?=
 =?utf-8?B?bnA3NzFiVkJLTVZ6NXJIR0ZoOEl4Yk5VdE9SMExPYnBzZHFOdERhU2R0eE9u?=
 =?utf-8?B?OUhBRXlzYWgwUTRCRnE0S1RScnAraUhENUQ4WDZjeGxUWGZRK0VKb01xK3BB?=
 =?utf-8?B?alpyN2ZVNG11c1VGOEdXUkJZcGxZL21nSGxzckNONHpGOTIzQ09OM0FsZXAw?=
 =?utf-8?B?R3lZcTFjWExXVzA0eU1CYVdHYnF1VjBydnVHTHhaRUtlZUp1MkhMT1VJaHRL?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04A63F607458BD44A32E8AC910F86DAF@namprd20.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: zenlayer.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR20MB6079.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c1eaee-9fdd-4f31-7ad8-08dd981d6eb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 04:10:33.4878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d27725c-b11d-49f0-b479-a26ae758f26d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yWnKIbIP/IyfkdDwc1Us4t7yXw+GhVVDu+VETYMuGejsKjjFO8NOOU9s66Q6JLNgAGeVXr6BipzCr+4hRtA/Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR20MB6973

DQrvu79PbiAyMDI1LzUvMjAsIDE4OjM4LCAiSWx5YSBNYXhpbWV0cyIgPGkubWF4aW1ldHNAb3Zu
Lm9yZyA8bWFpbHRvOmkubWF4aW1ldHNAb3ZuLm9yZz4+IHdyb3RlOg0KPiBUaGUgaWRlYSBvZiBu
b3QgZmFpbGluZyB0aGUgcGFyc2luZyBpcyB0byBhbGxvdyBmb3J3YXJkaW5nIHRoZSBwYWNrZXQN
Cj4gYmFzZWQgb24gcGFyc2VkIGV0aGVybmV0IGhlYWRlci4gIFNvLCB3ZSBzaG91bGRuJ3QgZmFp
bCBoZXJlLg0KPiBXZSdyZSBhbHNvIGtlZXBpbmcgbnVtX2xhYmVsc19tYXNrIGF0IHplcm8gaW4g
dGhpcyBjYXNlLCBzbyBpdCdsbCBiZQ0KPiBhbiBNUExTIHBhY2tldCB3aXRoIHplcm8gbGFiZWxz
IGFuZCBpdCBzaG91bGQgbm90IGJlIHBhcnNlZCBmdXJ0aGVyLA0KPiBidXQgY2FuIHN0aWxsIGJl
IGZvcndhcmRlZC4NCg0KbnVtX2xhYmVsc19tYXNrIHNob3VsZCBrZWVwIHRoZSBmaXJzdCBtYXgg
TVBMU19MQUJFTF9ERVBUSCBsYWJlbHMuDQpUaGlzIGlzIGEgTVBMUyBwYWNrZXQgd2l0aCBtYXgg
TVBMU19MQUJFTF9ERVBUSCBsYWJlbHMgdG8gY29udGludWUgZm9yd2FyZGluZy4NCg0KPiBCdXQg
YWxzbywgdGhlcmUgaXMgYW5vdGhlciBvdmVyZmxvdyBoZXJlIHRoYXQgaXMgYWN0dWFsbHkgY2F1
c2luZyBhbg0KPiBpbmZpbml0ZSBsb29wIC0gdGhlIGxhYmVsX2NvdW50ICogTVBMU19ITEVOIGVh
c2lseSBvdmVyZmxvd3MgdTgsIHNvDQo+IHRoZSBjaGVja19oZWFkZXIoKSBhIGZldyBsaW5lcyBh
Ym92ZSBkb2Vzbid0IHdvcmsgcHJvcGVybHkgc3RhcnRpbmcNCj4gYXQgMzIgbGFiZWxzIGFuZCBk
b2Vzbid0IGJyZWFrIHRoZSBsb29wLiBXZSBuZWVkIHRvIHN3aXRjaCB0aGUNCj4gbGFiZWxfY291
bnQgYmFjayB0byBzaXplX3Qgb3Igb3RoZXIgc3VmZmljaWVudGx5IGxhcmdlIHR5cGUgdG8gYXZv
aWQNCj4gdGhpcyBvdmVyZmxvdyBhbmQgbWFrZSB0aGUgcGFyc2luZyBlbmQgbmF0dXJhbGx5IHdo
ZW4gd2UgaGl0IHRoZSBlbmQNCj4gb2YgdGhlIHBhY2tldC4NCg0KTm8gb3ZlcmZsb3cgd2l0aCBj
aGVja19oZWFkZXIoKT8NCg0KPiBXaXRoIHRoZSB0eXBlIGNoYW5nZSB3ZSBtYXkgc3RpbGwgY29u
c2lkZXIgcmV0dXJuaW5nIGVhcmx5LCB0aG91Z2ggaXQncw0KPiBub3QgY2xlYXIgd2hhdCB0aGUg
dmFsdWUgd2Ugc2hvdWxkIGFpbSBmb3IgaW4gdGhpcyBjYXNlLiBBbmQgd2UgbmVlZCB0bw0KPiBm
aWd1cmUgb3V0IHdoYXQgdGhlIHNrYl9pbm5lcl9uZXR3b3JrX2hlYWRlcigpIHNob3VsZCBiZSBp
biB0aGlzIGNhc2UuDQoNCldlIG1heSBwYXJzZSB1bnRpbCB0aGUgcGFja2V0IGVuZCB0byBzZXQg
dGhlIGlubmVyIG5ldHdvcmsgaGVhZGVyP3NldCB0byAwIGlmIGZhaWwuDQoNCj4gT25lIG90aGVy
IHRoaW5nLA0KDQo+IEZvciBzb21lIHJlYXNvbiB0aGUgcGF0Y2ggd2FzIG5vdCBkZWxpdmVyZWQg
dG8gbG9yZS5rZXJuZWwub3JnDQo+IGFuZCBpcyBub3QgYXZhaWxhYmxlIGluIG5ldGRlditicGYg
cGF0Y2h3b3JrIGFuZCBub3QgaW4gbGttbC5vcmcuDQo+IEJvdGggb2Ygb3VyIHJlcGxpZXMgYXJl
IGF2YWlsYWJsZSBpbiBsaXN0IGFyY2hpdmVzLiAgVGhlIG9yaWdpbmFsDQo+IGVtYWlsIGlzIGF2
YWlsYWJsZSBvbmx5IHZpYSBtYWlsLWFyY2hpdmUsIGJ1dCBpdCBpcyBvdnMtZGV2IGFuZA0KPiBu
b3QgdGhlIG5ldGRldiBsaXN0Og0KPiAgaHR0cHM6Ly93d3cubWFpbC1hcmNoaXZlLmNvbS9vdnMt
ZGV2QG9wZW52c3dpdGNoLm9yZy9tc2c5NDg5NS5odG1sPjdDMGQyNzcyNWNiMTFkNDlmMGI0Nzlh
MjZhZTc1OGYyNmQlN0MxJTdDMCU3QzYzODgzMzQ1MDg4NzQ1Mjk3MiU3Q1Vua25vd24lN0NUV0Zw
Ykdac2IzZDhleUpGYlhCMGVVMWhjR2tpT25SeWRXVXNJbFlpT2lJd0xqQXVNREF3TUNJc0lsQWlP
aUpYYVc0ek1pSXNJa0ZPSWpvaVRXRnBiQ0lzSWxkVUlqb3lmUSUzRCUzRCU3QzAlN0MlN0MlN0Mm
c2RhdGE9MURYa0dYcXlBWVZVZjlCeEg0NU1HeTRCR1NOb3p1VVF3clUwSVA4dCUyRkxJJTNEJnJl
c2VydmVkPTANCj4gU2FtZSBmb3IgdjIuDQoNCj4gSXMga2VybmVsLm9yZyBibG9ja2luZyB0aGUg
c2VuZGVyIHNvbWVob3c/ICBEb2VzIGFueW9uZSBrbm93Pw0KDQpTb3JyeS4gVGhpcyBpcyBteSBv
dXRsb29rIHdlYiBwcm9ibGVtIHdpdGggaHRtbCBhZnRlciB0aGUgcGxhaW4gdGV4dCBib2R5Lg0K
DQoNCg==

