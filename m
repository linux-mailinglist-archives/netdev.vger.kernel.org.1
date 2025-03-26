Return-Path: <netdev+bounces-177763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44B9A71A49
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 16:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D44E81894031
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 15:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB141EA7D9;
	Wed, 26 Mar 2025 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BbMHRHA9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DDE1F30D1
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002649; cv=fail; b=MY62w6aRiJ1no4/kpbalYo3Flg5n0f1VRxJCDMN9Ac8V589OdXvkRWqe5K5Sckju0DCWGZE7lX0y/qw9le/knAaHRdbjTFcqXGcc2dakAInlu3Es0WBUdAbCclXU9O9l8K3NhfewFoelLuS8yfzDDkCLFzHxx4lyPKPtv1UnlFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002649; c=relaxed/simple;
	bh=pwDrDjdE0vInqaLjkR3jUozPmQui49th2eQghimOaDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Eb2yAlpO7sAHH+9qmsLxknQ6/m/C5G+cQyBw3d4epAPpSOHBiUXKkD3X6LEgwVfemHFUJU4SBAv/Fpttpvb1M7m0vRi9n7Wt1YuS3KWFVIX3BaGn+QRGef5tww52u4pvtacsEitMgVVRryfHeYb1Qf5sb0zSL/tlZ5odU9V6rZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BbMHRHA9; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mh69VcLrF8Tj0EvIoWyfPfNIlCiQt2IybhMVaFMkpMjLoyIbJ38A8DltZuuq7w3YPqrxAp9H3IDNXL/GKdO5KsmfGzmG1XLdpxv1o758V6u9Q7v/WlRDzzFZv02HcI9thzTOaq7AWL24bJwO8SxrHDwX9Kn373RN1CuM2w1uvaVdHywt+YhyjQEZx36FOAC6q0leMVYxMXmhliDa+EyXHHTAWgmcQCSxJDsQGdajJJy1UjBJIoNLjaYEzcDm+EwGvoUe8N2l1yEC9gVSkDiq8i+wrwTVluEcHnRKK45aGzusQqdLUHwg2iK5BEaXrSocXf5Ge1PWyzIXmWVQO/nmWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwDrDjdE0vInqaLjkR3jUozPmQui49th2eQghimOaDg=;
 b=J7PgHmzox9YWUvRJ/wlYjYlrn+c3Hx7bijmVwIZMxWVjXDQ911WPvMHsqZYytv7ltZrUV8uj5gzHvYmcrrppEfAFTzNmpTT9g/gvF9KRPipyNCYQhAAs03zl6FIVJQ7K+Hagg0SeQB3ucajlBWbFBnXfLL8fnqVXxZEDn96kcBQP98VdmFECd1BfAmZ/68ImiTJtj96lUye36Wz6r+DuQbchMCh48R5+5xjjnIE/SaTzzzmkelicFXAoCi2hlfoSfrmW60tFPi4uYU6cnU8AHWPE9DJ6GSBdznlRJiC7HRaYJxXHynAfY4/oZf9+0m+/RRBLDQnymEts3cpgsuhcLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwDrDjdE0vInqaLjkR3jUozPmQui49th2eQghimOaDg=;
 b=BbMHRHA9AqYnLiZhmozYircvQkuGQiaXzKwPMDxm0tKfxWU8+lnPbGeipwmfvRUVy9s36WLYPK9Q9zlALPO/q4v3bhCt0v5vricSAUj+gagWS5kPW9bvqY8wngvFlcJz5+nP6yTYAxGtoOcEDnuRsSNpWSCv/kDZg+xc8rOSMwZDQiI8vrBk8pPBsGPA2RIvlEGZKZYCyixWo2vWQ03s96gAUrDuiSpf/9AF3LCXlbFI66qu2q8YVQMaJWuFAss3tLnZvsckfS4dSB9gvh6vG6rNuk6hQCKPM+GqX5ROIqKCdfOwe/9T+FbhJJ6vbIvL0VEycgmtJ1P4pFyiCCcwOQ==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 SA1PR12MB8741.namprd12.prod.outlook.com (2603:10b6:806:378::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 15:24:03 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%2]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 15:24:03 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "sdf@fomichev.me"
	<sdf@fomichev.me>
CC: "edumazet@google.com" <edumazet@google.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/9] net: hold instance lock during
 NETDEV_REGISTER/UP/UNREGISTER
Thread-Topic: [PATCH net-next 2/9] net: hold instance lock during
 NETDEV_REGISTER/UP/UNREGISTER
Thread-Index: AQHbnc04GLropLE/UEietC5IV/U+Q7OFhLuAgAAF3QA=
Date: Wed, 26 Mar 2025 15:24:03 +0000
Message-ID: <cc1597b12b617cbb62d325285c3a50bfb2b1ce1a.camel@nvidia.com>
References: <20250325213056.332902-1-sdf@fomichev.me>
	 <20250325213056.332902-3-sdf@fomichev.me>
	 <86b753c439badc25968a01d03ed59b734886ad9b.camel@nvidia.com>
In-Reply-To: <86b753c439badc25968a01d03ed59b734886ad9b.camel@nvidia.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|SA1PR12MB8741:EE_
x-ms-office365-filtering-correlation-id: ec0bc214-5528-4d14-f926-08dd6c7a3dc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eC9tSzJ5NVVhSGdWblpzVk1UK0RqaTRNNEh3Njc2c0ROdmhEaDZzUlpRSCtu?=
 =?utf-8?B?aHFRSGdPMW1paDRPWktqdU50eFpIbTlrUEJJMS9NOTJESTRsNVZNUk8yVS9j?=
 =?utf-8?B?UWFML2lVSUszUm92MXF2Y3hGVjg0NHk3Yk8xOFEwRTdhcE1idFhKZFkzMHY0?=
 =?utf-8?B?MzhNeXNKVm80ZDNZenE2MWhZZUlrNFNTQ0Y1Yk41RkZGVzN4R2ZERlJrcEE3?=
 =?utf-8?B?MlMyOS9SMEZUZkg1ZGxPdEIwL2EvbGJHWjEzc3lZYlo0MGV1aHppVHc2U3BT?=
 =?utf-8?B?a3F4UUNRT3Q2NFE2N1VUNXkrYnlGMVVXUG9yMTg2MWhvWDFwcm9kUjNYMC9k?=
 =?utf-8?B?aEVSaTBJd1p6aENDRDlLWGFTeS80VEtqYmFKWTBQUkduOTBwZzNWL05zVkNt?=
 =?utf-8?B?cHNjcTJVS2tkb3FIU3lpRWlyazVJUlBsK21jVlRKZkZGQ0Z2eE1rWXd4bEhR?=
 =?utf-8?B?aE9YNlQ3T1gzNEx2N2N0K3N5dHNST0RrcTVuM3BHbVdVdUlEc1Y2dHFKcWlH?=
 =?utf-8?B?MGFDNFFlcHI1N1owM3J5UHNxT1RMd3F1V3NDbk1jK3BNWWRndFdzOU1hMXFC?=
 =?utf-8?B?TUxnTVFZckcvbTR6NjJTbVhrZTNMMGpTVjlIeXhRVjkxalpYZEM0dDIrbitE?=
 =?utf-8?B?eUR5cmpHVVU0L0R0bStJUUhoUFZORjUxemxiN3Y5RjlsclRicUpLUEFkSnFv?=
 =?utf-8?B?THNxL2s0MGJqSjduZjVzakhGSTdLM0Z4RHU2UFE3SGhWTzcvSllhdmYvbk5s?=
 =?utf-8?B?T2EyWldsWVlGM1daMm1yL0FzeWhleUhEOHNpZ0dJY2o3V2FDWnBzdCt4SHdU?=
 =?utf-8?B?ODUxUit5eGViMUJHS20xSjVZNVRKcGF5Zm4zZzFYeHp3UFZWL2tNMG91Tk9j?=
 =?utf-8?B?Wng4aDU1VWNTdkQxL3JWNW9HczdMa2JmOUpYcWZZS0doTUhRN1dSVWFubmxy?=
 =?utf-8?B?Yk1UN1pGeGpFK2hEdGJWWGVFcXc5VkgrYUJkckQvbEkxVW9NUEc5Z0RFaGgw?=
 =?utf-8?B?YUZlS2JUZ3B0RjdDZ0xhM0JXRnhvQ1ZnallTb1ZlVm41L3cyaVZTTzRQRU9N?=
 =?utf-8?B?ckRrM09RcTl1MEpBQ1A5dmZZQWI5LzZoS0lpQWRIV20wQStNMVlxZ053cGZF?=
 =?utf-8?B?SFFjUTkxb3dpZUU4NUNHdFBBRElNTTJpblpjR2EyN2daNXJnbmlWOGtQR2Er?=
 =?utf-8?B?Yk41UVVFeHppUzcxaVVYaUkyNU94Uk05T1ZJZTZJMXBWUjQ4ZUZoT0FTVml6?=
 =?utf-8?B?R0RnRm1EOTFUNzBPVGhQeUpCclN3a05ySEFQd1dKOUNBMjBOUi9DaVdOZzVJ?=
 =?utf-8?B?dDNsN0dVSXptZU42NDd4RFNNMVg3b3NNVnZlTVFLaXk5RXcyZXJMYkliWnJM?=
 =?utf-8?B?MlVZenBNb25OQnNuNDlIdjMxdXl4LzVNNUhCZUpqejF1LzAzb0xubVJjOFEv?=
 =?utf-8?B?N2NDZXBDbm9VM3ZSY05UWEV0alR2UFUrTElReUhlVk5uUHRCcGV6Ui9KK3lE?=
 =?utf-8?B?Q0R2b3FvVEJRV3NUSTMyL2hDTURjMCtIbWVlcGd0RlJWQkczWTRSRG83YU1E?=
 =?utf-8?B?dEMrMkx1bXN4cXBuK3ZFeGVLbGhpRytod0hkbXZtNWlXVFpZVm1WVmE0ZmVp?=
 =?utf-8?B?Rkc4c3gvMjZrR3p0ai9keEpIRmtOZ3ZaNGdWWW5HVEVRdVpHZWo5SUJuREpV?=
 =?utf-8?B?SVArSlBDaUt0OGQrS1J5bG5uUjZ2QU5yc09LTEliTEdUa2hVUGNGMTBYOXh5?=
 =?utf-8?B?KzV1SjdQcWF6SENUR0lSRlFQN0FZMyt6MG5UZHkvVWZxU0tZUkRIRGJ5NHpN?=
 =?utf-8?B?Ti9HOGdvYTg1SW5Cc25WeUNESzVZZ3lwdWZidnh3VUhaaWtQVjJBaThFaW9H?=
 =?utf-8?B?eWo3QVJwVUJmOElTQzlZR1I2VmdzcmJlcmZXY3pVSVF5V0pNc09XcFYrenVq?=
 =?utf-8?Q?Qma3rw6BVOoglos6hiaY7CkxcHgq1hI0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S1h5dWl4V1N3aDVxZnBwS2RFdi85SzVlbnk0dHc3RXU1WVFYQnA0QlNEdTRC?=
 =?utf-8?B?QXM5Wk9BRFdTMmFvQWhFZnBsNEN2OGRCamQ3TjhNLzltS0JtTGFKRU5FVDlU?=
 =?utf-8?B?RDMrU3FDUzQrS3VUUGF5RHBxVmVIM005Y1hvenBIcHNzM3FUd1FGVW40Nmkv?=
 =?utf-8?B?QmhjZlB5MlJtbklNUldXZUJWSjZpSE4rZXk4a3lTR0l4Sjk4a2tNT1drbjhj?=
 =?utf-8?B?djJGWHBHOHhmM2FBN1BPTzdXZ3lKZFMxOGlrV3JkT1pPRGdoaFlUak1LYjdk?=
 =?utf-8?B?ZmliMU4zMEFMM2crSTd3TmVsanJ0RE1mRGFmVEhESEJXVWliNGhsUDFjNWNo?=
 =?utf-8?B?a0dXRlRIaVdCK25jeHV0cjQ2cmpJaktvNlR3eDE3R0RBTlFEdkFpbCtWVC9w?=
 =?utf-8?B?b0svQWVaN2VjVXFTK3lOQWpYTFppeFRqY1ZXaWhuNmljM1lmeVhVVTQydUpV?=
 =?utf-8?B?R1A3LzFiOS9YSWtaSEpkL012SHZ1OFoyTnBtNGFTdzVrK1h5azdqSlRHbGtZ?=
 =?utf-8?B?TVQ2bEdSdy9GZDJhbDFuT3NUV0V1eThuTlMyN2RmZ294aDN0U2Rod1VuTWlK?=
 =?utf-8?B?NGw4eGs3dHE1WEN1YmhJWkZtd1pwTE1ibmV5MUhxK3pKcUVWcWVKRENoaHVh?=
 =?utf-8?B?ekg3MGlpS050enhuSEw5MjZ2ZlhBVXYzNFhxMGlGb2U2cld2ckpGUUpGVWRp?=
 =?utf-8?B?UEl4bVNvZHByblErL1Zvc3hjVE9HYTZtemY4bEMwK2VDMDRRK0hFSldocWFl?=
 =?utf-8?B?dUhtOTlzcWg3QlFldEhvZFJ0WmNrSnZFT2NyM1N3bzJLSUtoT1JyWkpTR2k1?=
 =?utf-8?B?MW52YzFZcE5hZ1JIMUtLaWJwak82b282bDhMQVprbXNObTlxTjFubTY2U3hB?=
 =?utf-8?B?eHh4QzlNOEx0OUpyOUpOL1JjN1Z3c2l3cjliMjR0SlJBVCsxZTNTbU1ZSldC?=
 =?utf-8?B?MGlxMm9aUWUwckN5b1JQNmlKSzdHdXIxSVlhbzFyZG1Ha2EyZjY3aGlsdUk2?=
 =?utf-8?B?OHcrcW1CTHZHc1puNTVjbzNaVUxiRHgwVlV2UzN3eDBEaUVlaWNWL2VkMUc0?=
 =?utf-8?B?ZkNsRVlYTFoyMW1HSG1LWmVScDFjZ2U1TG5yUU9PQW1WRFFHZi9CakdwUVlS?=
 =?utf-8?B?VGNQYVAxbkpJRG5mT2R4c2FYTnpTeUhvRG5USng0UGUrNWJtUUVNTFV6aEpy?=
 =?utf-8?B?am54SkFwdXdOSDl2eHgxZXBMVHJtTVdOUVlNT2U1d1RmbkpId1VvU1BuR0ha?=
 =?utf-8?B?ZnozcUlKaWQ1c1NhaUNJS0N4NVc3ZS9uTktvYWZGTXBsRndIMnZZN0dLSVU3?=
 =?utf-8?B?UHppRVVBVUs2VWozNmMyMVJya0lMUjYrTm5wNDRpWk9xTnBVemtvbHpsSEVF?=
 =?utf-8?B?TjVsNW1Tc1FaaE45Rjd1amJvT0R6N2plTFVHNlE0bVhrdUxaZXM2MHlMZXBV?=
 =?utf-8?B?Z2l4MzhjNVpOR0tQdHZpSXhtS2t2cHVxalZIS0NOVDVlZUIxaU5BNnNqUjFt?=
 =?utf-8?B?eHN3amlVbnpQTms1c0NpY21kV2xlWS9KdjIrQW9LRHFYcXliK1U1NnZVRTVK?=
 =?utf-8?B?NEhFZlg3UzQwODY1aFZmZ29IM1diaEFpZnVmdmpOSGwxQUNlQXB3VzU2RUtq?=
 =?utf-8?B?TkpNdVVOSDA0NnlmRk82SUl3UGVuUlpnQk51WlkzbzZzY0liVkpNeUF0Wk9m?=
 =?utf-8?B?bzRTK2VwZVJQTkR0UGxnQlZ4M2NUMFlNalhkenN0Vk50cGE2RXhSRk1zTUFj?=
 =?utf-8?B?UU84RXduVlQxeDJ3R3E2M2drUXluQjZiS1daZDFIcitlU1RzZVZCV0NaZmk2?=
 =?utf-8?B?b3VVNjNhbEV2UExSVXo5eUxLdng0cllzTU5NTERyTTZXa0x6bnlCQWlycU1D?=
 =?utf-8?B?VlZmYmI2SzR0REUzYS93YjhmbVNtZG1QdDZtZTJFRmVhcjBBdmphbTJUUVFu?=
 =?utf-8?B?RHJLeUo1K2R0SVdsODFZUkVRaXVvMHlmR1RyUmFvRGc4dWtPRmVBVlRpeitX?=
 =?utf-8?B?cjJwRE44MGRYTUZBdVluUUtOaU5uMzZkelVuSE1MU1Naemd2Y3VXSHlIWSth?=
 =?utf-8?B?eFNpcGNBbXdlZlA4Yzdyb0tVVnFLdkgvOHhvZDYzbXJDd21GbTVjVFV1b2NK?=
 =?utf-8?Q?aQvKN6Pvsbi+NTQmAPd0iXj2f?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B8C7F5C05B66A4D87C3F743A69C41CD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0bc214-5528-4d14-f926-08dd6c7a3dc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 15:24:03.4830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vchUwPJd2lFUNPcoclBEEyS9CXSfDuUJBq7CMJ6z5s4TGHaWzjq5MOs11syisqblV4TazKg462I2mVp3UPuCNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8741

T24gV2VkLCAyMDI1LTAzLTI2IGF0IDE1OjAzICswMDAwLCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+
IE9uIFR1ZSwgMjAyNS0wMy0yNSBhdCAxNDozMCAtMDcwMCwgU3RhbmlzbGF2IEZvbWljaGV2IHdy
b3RlOg0KPiA+IEBAIC0yMDcyLDggKzIwODcsOCBAQCBzdGF0aWMgdm9pZA0KPiA+IF9fbW92ZV9u
ZXRkZXZpY2Vfbm90aWZpZXJfbmV0KHN0cnVjdCBuZXQgKnNyY19uZXQsDQo+ID4gwqAJCQkJCcKg
IHN0cnVjdCBuZXQgKmRzdF9uZXQsDQo+ID4gwqAJCQkJCcKgIHN0cnVjdCBub3RpZmllcl9ibG9j
aw0KPiA+ICpuYikNCj4gPiDCoHsNCj4gPiAtCV9fdW5yZWdpc3Rlcl9uZXRkZXZpY2Vfbm90aWZp
ZXJfbmV0KHNyY19uZXQsIG5iKTsNCj4gPiAtCV9fcmVnaXN0ZXJfbmV0ZGV2aWNlX25vdGlmaWVy
X25ldChkc3RfbmV0LCBuYiwgdHJ1ZSk7DQo+ID4gKwlfX3VucmVnaXN0ZXJfbmV0ZGV2aWNlX25v
dGlmaWVyX25ldChzcmNfbmV0LCBuYiwgZmFsc2UpOw0KPiA+ICsJX19yZWdpc3Rlcl9uZXRkZXZp
Y2Vfbm90aWZpZXJfbmV0KGRzdF9uZXQsIG5iLCB0cnVlLA0KPiA+IGZhbHNlKTsNCj4gPiDCoH0N
Cj4gDQo+IEkgdGVzdGVkIHdpdGggeW91ciAoYW5kIHRoZSByZXN0IG9mIEpha3ViJ3MpIHBhdGNo
ZXMuDQo+IFRoZSBwcm9ibGVtIHdpdGggdGhpcyBhcHByb2FjaCBpcyB0aGF0IHdoZW4gYSBuZXRk
ZXYncyBuZXQgaXMNCj4gY2hhbmdlZCwNCj4gaXRzIGxvY2sgd2lsbCBiZSBhY3F1aXJlZCwgYnV0
IHRoZSBub3RpZmllcnMgZm9yIEFMTCBuZXRkZXZzIGluIHRoZQ0KPiBvbGQNCj4gYW5kIHRoZSBu
ZXcgbmFtZXNwYWNlIHdpbGwgYmUgY2FsbGVkLCB3aGljaCB3aWxsIHJlc3VsdCBpbiBjb3JyZWN0
DQo+IGJlaGF2aW9yIGZvciB0aGF0IGRldmljZSBhbmQgbG9ja2RlcF9hc3NlcnRfaGVsZCBmYWls
dXJlIGZvciBhbGwNCj4gb3RoZXJzLg0KDQpCdXQgYSB0aGluZyBJJ3ZlIGxlYXJuZWQgbWFueSB5
ZWFycyBhZ28gYWJvdXQgbG9ja2luZyBpcyB0aGF0IGxvY2tzDQpzaG91bGQgcHJvdGVjdCBkYXRh
LCBub3QgY29kZS4gU2hvdWxkbid0IHdlIGF2b2lkIGxvY2tpbmcgZGVlcCBjYWxsDQpoaWVyYXJj
aGllcyAobGlrZSBub3RpZmllcnMpIHdpdGggdGhlIGluc3RhbmNlIGxvY2sgYW5kIGluc3RlYWQg
Zm9jdXMNCm9uIDEpIHdoYXQgZmllbGRzIG5lZWQgdG8gYmUgcHJvdGVjdGVkIGJ5IHRoZSBsb2Nr
IGFuZCAyKSByZWR1Y2UNCmNyaXRpY2FsIHNlY3Rpb24gbGVuZ3RoIGZvciB0aG9zZSBmaWVsZHMu
DQoNClRoYXQgcGx1cyByZWZlcmVuY2UgY291bnRpbmcgdXN1YWxseSBkb2VzIHRoZSB0cmljayBh
bmQgc2hvdWxkIGF2b2lkDQp0aGVzZSB1Z2x5IGRlYWRsb2Nrcy4NCg0KQ29zbWluLg0K

