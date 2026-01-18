Return-Path: <netdev+bounces-250756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71261D391D3
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 01:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C9BC300EDD4
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 00:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7521550097E;
	Sun, 18 Jan 2026 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="TPgFXRHK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A663E500958;
	Sun, 18 Jan 2026 00:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768695055; cv=fail; b=L5UkQ+ZejGIq3E5sGbyJOBwDlZL1++WTS/uhbq/fdhFUPiH2Mhr9N+qXlUpKPxtzTqRLfc4nNGjiXqLvPumf0c8argpsZVT0S5MHL7nBKzY3l5erh2Gxxm4dqNpG8V9BZIP5jj8131NIkfzvZu8ozKO7qvB6UaFDoo8TCRQ2bgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768695055; c=relaxed/simple;
	bh=SvA18r7XS4OPhY1G9NB4/5lmEh4jSyx1Ja0SC0KbvyQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=upQObEDXWuFLRPEXDdaevibEtacn1Kk0JfHuR9cznVrA8c6AgxNNo+HgNS0EO0t810uyfpsEVSlPQNeaSpbSh5oIXjYUa6pT5bxoGUARUI0aTXZvNb8IuH27sryDJD8DqTZqCwgn7LAWlMkanz3lOGGK/mBUdypa/Yne+pBdpuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=TPgFXRHK; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60HAoYhB294393;
	Sat, 17 Jan 2026 16:10:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=tNzjkCUmp+kuaeGtnsRBuw2Bg5tV/ezC7L5CBBls7Vo=; b=TPgFXRHKv6cL
	YyoppUZwrUKGj4B8a8sTswewDvtkYuH5uat5f9tXmmjdNYwTDm/8hRttnEPtA8mr
	VnXe10eelHE4SqaL7f5bbRUyXfY3ouUypdagw8z7DHkoR7ahSW2fBNBqmca56c88
	5jY1KEpo2qnipKMv8KNlZVyhEk7uPtSupaKuUxIrA5Ssvi43R4M528qJYKbdaMnz
	vYV8gCE5CQu1WOVJhHaWkYH0TG7nLTnqr8QbEnAkT+cSBar56vIAzr0eX91GdStG
	bGT68w0alrY8CegKRUIxemR8H9/YvZ6hF/8+vazh1ZIkpM8n1gwH8Oz9HXp48XhG
	t2UwvE1RUw==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010048.outbound.protection.outlook.com [40.93.198.48])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4br91dtcte-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 17 Jan 2026 16:10:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaHYBWBl3jn4xXpUfCzp2r3JJh5Exrf+Fl1eBISl3axzCwLJs/9VEDeOYZrvm+QTO10mmlAQhwjVHuL4pg76eBogLM86zhEa6B6K8g1YtOAaBwpQtk50IwoTgTx2HXNGghvUkmzIlGyBMIiYS+aXql7RDNPmnitI4Lqch5IsVfv9le72QqRwjsT0yb1fk4LSc9BDTUem41qYEB1vXDyqoGOBba7CVrpKI8Vbm0aHNWOzcpeIs493AkTp8k6ooBKcPJE5epMRASU5+F8MGcf/6xQiy+ggep9YFTDCAjl20nWyQq1yQ+FN9hepFc/CGHnVkgMYXDJ7owevKFAwKr8tmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNzjkCUmp+kuaeGtnsRBuw2Bg5tV/ezC7L5CBBls7Vo=;
 b=ZKmse57oXc+hhjiFFn+80NDR5VjtVNT4FrPOhD55VOYw9OcAsqhJ19w269JSARwXxthmI0Reo1XJRIkPfUUk6I57Idbj411w1eA5ex/VjTVDYay47gVR/9ajEDzwWPXkxXkbe18dDJ6+0kbu0zHB01q8v/xkKaGAvpEeU3WpyqnqVScHaqrVRBoaoW9+LuXy28EQ7iaZZvLvSNKpZ4QKOR5J/WJMKI4UF2iW9p31B6qdL0JbIqeNuDR13WX53FGYg/X+UFa3jVzgABzWt0WBdfAqm1T52J/bn0mz3Ei265vL62NjdTKivjOykdk9l2tuWdF06Zb/voaXrpu+NhVnsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by PH7PR15MB5806.namprd15.prod.outlook.com (2603:10b6:510:2b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Sun, 18 Jan
 2026 00:10:29 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::444a:f42c:1d70:40b5]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::444a:f42c:1d70:40b5%4]) with mapi id 15.20.9520.006; Sun, 18 Jan 2026
 00:10:28 +0000
Message-ID: <2279fd03-6261-44fb-b4c5-df2786a17aa0@meta.com>
Date: Sat, 17 Jan 2026 19:10:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [v2,2/5] net: phy: realtek: simplify C22 reg access via
 MDIO_MMD_VEND2
To: Jakub Kicinski <kuba@kernel.org>, Daniel Golle <daniel@makrotopia.org>
Cc: hkallweit1@gmail.com, linux-kernel@vger.kernel.org, michael@fossekall.de,
        linux@armlinux.org.uk, edumazet@google.com, andrew@lunn.ch,
        olek2@wp.pl, davem@davemloft.net, vladimir.oltean@nxp.com,
        netdev@vger.kernel.org, pabeni@redhat.com
References: <fd49d86bd0445b76269fd3ea456c709c2066683f.1768275364.git.daniel@makrotopia.org>
 <20260117232006.1000673-1-kuba@kernel.org> <aWwd9LoVI6j8JBTc@makrotopia.org>
 <20260117155515.5e8a5dba@kernel.org>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <20260117155515.5e8a5dba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0399.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::14) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|PH7PR15MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: ec723b73-9f44-4c40-ae3f-08de5625fcac
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?N05udDArT1RMZEpUM1k2QWd5S0lhblE1WXF2Q3ZCVENBQ3Vqc0EvSjVhdFNr?=
 =?utf-8?B?RlBseUlxd0FrRnNUT0FtdjU4aFVDaGp3aFZTWml2MmlQZmpldHVud3AvTm12?=
 =?utf-8?B?T0xDSXNPaWdBUE9tZjJuU2FEQXgwNG9YcVhydmJwdXBkTGRLTmFVWXIzcVhQ?=
 =?utf-8?B?ci9FWkl0TDJ2QlV5K3RYZnd5WkdycUNNdjBLd3gwV1g0OFJQVVBTVDhNaUZD?=
 =?utf-8?B?cUtQak40QW5EcTRyRnl5Ri9pckU5OVQySmVlSEhic3daUDFOWFYvRFVKVHhv?=
 =?utf-8?B?MVFOZWlTVEdPRmhLSmlQQ0xRMTFYYWlaMU5EVlgvSGl2ODF0RXVkanpSLzY0?=
 =?utf-8?B?WmRTd2RuMkxoemNlUEJUcU5pdHpydUhVREhlQ2grc2NYQnBkdlhPUDNnV2R1?=
 =?utf-8?B?ZmR3WWt5dUhHUEFWaHllQjhnY2RsSUt4cXE2RU1wYjU3eE53UFBpVFEySE84?=
 =?utf-8?B?Z2liKytkdExkdm5FcmRYRkZYMldyWUtHYnM3V0EwdkJVb1Bxa2tWS3BETFQz?=
 =?utf-8?B?ait4RjdQUHQ1K3NySnE4SWtoOTRRdXZ0U3FhcDJZZ2lkdzJQY2RQVk1JaFRr?=
 =?utf-8?B?OFBpL2hocDNzNkwzV0s1b0xvOXZHd0Mxd2drRCtocFNtdm5UUkJQNjEzMkIv?=
 =?utf-8?B?YTdRTXk0Z2VGSnpYL2oxVjl1ajFvbktxaFNqWEpGRHhvRFJ1aFNtamh0QjhQ?=
 =?utf-8?B?S2V3VUxXWDlkU0Vsakt5aUpQVWJubkpobkl0ODFlQUdFamI1RzJRRDJoc2dJ?=
 =?utf-8?B?YUZLTGVrVUdMUURHa0FZNmpxS0dKbTFvYllOWEE3TWxJSXM3T2pmc3FXUFFj?=
 =?utf-8?B?LzdGK05JaVV6SnZsUkFTakZXcGhzNFhTVjZoSGl6empNSjRNYVZsSVZlTkF4?=
 =?utf-8?B?U1Q0NDVQRmxMbUZqdkRCTms0SUFEYU5xcmdEdkg5V29aK2dBK2U5K296ZXQz?=
 =?utf-8?B?T0pvbTBCWEQ1b3NNbW9MQzA2bU8vY0twMlpnZTFPUE56M2dHSUdCMHQrbHlZ?=
 =?utf-8?B?eW5jSjNGazk3WCtJYUdUcjdOTkE4MlB1cjFCWU50aXdTKzlrWmJocXI2VElJ?=
 =?utf-8?B?U0p4aHNoSUthbjhNVjdLZ3M0QVRCZWVFK0EvYkxrZEkxa3BRSkFtdnB1SVRw?=
 =?utf-8?B?MTlRemRUcFFGc3ZOMkxmNURiOHVSTStqVEpoVGl6Vm91QW55VEtLKzkrL0Fv?=
 =?utf-8?B?aWFtR0lON3BLazQ0WW41S1FzaTFwaHFDbW10N0FsZmVhdjB3R2prNCt4eHhi?=
 =?utf-8?B?Vkl0Z01HbjNTeTNSdmpjWmpxdUtOV2dFUUsyOU94S01kTW0raHpnRDFRNVQ5?=
 =?utf-8?B?YTBxUHdMQk5WMUt3K2RUODdpcGZWZWRCMHJWb1c0eEtyMGVNSTZuQ0l2Mlps?=
 =?utf-8?B?azQwSDhrNy9KdjdMZlJSSVVneWlyZDFjVE5Od3JjN2tXVGg0akEyZlpTODlT?=
 =?utf-8?B?MDE1M2t0VnpOdWtGOEdTdVVsVS91Z0F3aFE1cVpacGpJeTNXOVVKWWppS2l5?=
 =?utf-8?B?dElmenM2bjF5bStwMnJqM1lJNnVoYm9HNk1qelJ2aTdjOVpwWmhmU2g2YkJY?=
 =?utf-8?B?U0h4U0JWSTJBdTRvV2s3UlptU2N2TkpsTU9qMDlBMU03VDIvUVlJSHBxVDJX?=
 =?utf-8?B?LytFOVB6VlVUVDZtZGRQM3l4eEhlb0hCRFNtTk1HSVlYV3puL0xzNkhWUyty?=
 =?utf-8?B?S3I2TjJjSFRRRTBQdmlBcEIrT1puQmhkWkZETE9XY2wxQ1hJWnhyZThuS0x4?=
 =?utf-8?B?d1lYQUt4ZDN1ek1pSnMzVCtUUUl5eSt0VFl6ak9ONFErQ1B0ejZzL1JWTmIw?=
 =?utf-8?B?RzRMOWpZMmlMQXRubWp2S25mRU5NRUE2dFphUGpyS1Y5TzNLUGRZZ3BpVzl0?=
 =?utf-8?B?VTk4Wk9jSjJLdGFCRE5oN0VOSE9LaE1Ea00wV1FtOFhUMitLbjRidG0rb0xt?=
 =?utf-8?B?QTNVTmVsRUdML1ZCaWd2ZGpXenF5ZTcvU2NORG9iaVltMC8zWXdtQmVzTmNv?=
 =?utf-8?B?ZFkrTkQvRWFRQTJKTXA5cHZEcDlYSXc2T25ndmhqV3l5YkYxNW1nRDVjcWhz?=
 =?utf-8?B?NDEyc1hwMVl4TTJibCtmdE1yeHdxWUdvTisvRGZTellDNTJFZUhWSzZBYzhZ?=
 =?utf-8?Q?bwro=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eTU4V05KdUhhMEExZ1lJTCtmNFM4STdpOE1yTUZWclVObWlvTUNJd3lhVFdN?=
 =?utf-8?B?Qi9KZTIzTzI3Q2w0dGdpaGNXaVFEc3pDcTVDcG1IK1ZmamZaUjBPTmJ2STM1?=
 =?utf-8?B?T3FMSEJRa1h1RlB6b3NQVjJvWVg2YldjYnp2SzNzM09rbFdHUEgzWU9rbysv?=
 =?utf-8?B?UmRsRDNIaGkzMTJSUm9WdUpja2NvaVhibTRyR1ZwdDJtaWlWbWxiekVFaUx0?=
 =?utf-8?B?WlpjZHprbjAwOHRvRi9JWGRLdWlacGVMcHREaUh2L0JFdGJVVjJCb0wvMzQ4?=
 =?utf-8?B?VzB0U3EzeDgvTjdnOUxNMHNPWnZkOXVTaUpCYjA2QVBjSEJrSE50ZnhPT0l0?=
 =?utf-8?B?TkhvazdDU1Q2NE5lcUU2YjBJWnY1a0lwa2h0YzV1ZG9HczJHK280Mkp2NWxF?=
 =?utf-8?B?REhJK0I1anlRZmVkTzA5T0podGtjeThyL09BZ1FwR3hkSGpNK2NuTDdVKzlB?=
 =?utf-8?B?bTFIZ1o4SWlsdmphbERCUDlQcjBJb2x3UUJtSXkrYWNYTEVJcDQ3ZlE4OHB2?=
 =?utf-8?B?bzBSMk1Xb3RzYWQ5akxrazhkb0VadFRDb3dBeERKb0JsYmswdnRMck56dFkz?=
 =?utf-8?B?RDM3RE9OK1Ewb1Nsd25scWlGYnVxc2pESDUybm9EdU55a0k4SHkzZTNxSDl0?=
 =?utf-8?B?ZUhoMUE1MW1VaU4wbFJyakdVS3dMZHZRZWI3a0FXcDl3cnBRRXVFS2l6MmdH?=
 =?utf-8?B?WkNURlRodURrTzZkdzltcDd3ajE3ZlpSeHl4dnhqUHpXNEIveUxvR2JZcFRW?=
 =?utf-8?B?L2tlLzFZeFZNV1JoK2FDQTB4cmlCL0xEUkNVbERDQTNZaXI0aXdyREt3RVJx?=
 =?utf-8?B?Um5TdHg2L0svZU04SzBBZ0FBVEFwWkhJbG1xaUNQclhSaXV1MFVQZ3d3NHZ4?=
 =?utf-8?B?MzBQaXk1a0pRUzU3SW9aUmdpVytlVDlURHZ0MVpMNXlIcUhycmd0c0hZazB3?=
 =?utf-8?B?VHQ5azZjV2UzMVhjS1JMTzl0cWxOZ0dud2RkaGY3b0M5MzI0YXBnRk9GSGc2?=
 =?utf-8?B?Ykt3cTk0dlNCVlFjM3V2VmVaV1BJZm5xRGpvdlIrOWlOVk5vK3huRGRvN0p5?=
 =?utf-8?B?SlJvbXhIVURSMkRoWEord3RmbU5VQ3JLNXBsLy9yMkM2NWxrNDJVanhCcVFZ?=
 =?utf-8?B?Q2ZNdlZMSHhiUjVUWU5rbFZJdytncmNFVTdyV0lwMFkvY0Ntd2oxaG1jU3du?=
 =?utf-8?B?UlBzcU96QU1Xdk5pNlo4Y2VTQzdVcjVwZWl5THBBaE5GVDhFM2hXSDJtSmlW?=
 =?utf-8?B?TXZNRXI4ZjA4SkdYUzFVR1JzN3dzOUJLNThEZXk0cmVJZlBOTjE5N2J4U3lC?=
 =?utf-8?B?TnVOUlZXVnFpN3oyN3dkZ1laV2kzUkRSSWV2Y3lxYUZ1d042NWFDdkVCSVNJ?=
 =?utf-8?B?TEhtamNFL1hxWHJXODJ4QTMxbDR5MXRkbFNQSG1ub1NSb0tyVUNKaGhOTmtI?=
 =?utf-8?B?amFFRWN0MFdXekIzaFZmS3UxUi9DMUozTU5tTm9xMzNIUXFTTDEwRE4wQ2RX?=
 =?utf-8?B?akphc3lQcTdVVUxYR1g3WGdrZ0pyMGllZnVZNU80YkV0U2hWWXZ6dEhLRGJn?=
 =?utf-8?B?djAyMTRaUkJCcTRkeFRBMzRRb0VXRGpHY1FldTJEKy9XSHVaN3RycHdJMnZl?=
 =?utf-8?B?TWhIcEtvQWFGL29xdDVpLy9Lb0xFRG03cVhDejcrRUVyY2VQNkpXbDY5cEJo?=
 =?utf-8?B?QVlEeXd3enVJYVFjQXpqemhvZCs3VlhtSktNTVQzZWMyQnpxc1lVRnlLbkk4?=
 =?utf-8?B?QTQyMjZ6RStld3htTjd6Ti9RaUJSTWt6RGhJWjQ2QVRJMGxtRUdzVEE0a1hS?=
 =?utf-8?B?d3Z1RVRWTVlTaC9TYjVQK2JTNDExRDdMOHZIUzBuYVRaLzdoOWVuNHh3cGhl?=
 =?utf-8?B?M3ZQaDF6ZkZMZ3NYeWdac29US1BOcm40R1VycWMwQ1pLTHpCS3ZlWHZQTkRh?=
 =?utf-8?B?NmRGeEpIY25TRE1ZYTBkZ0pndGxUb3JkVFoyc2RUNGxoWlBsU2xlc2VCRXZ3?=
 =?utf-8?B?N3pHRkR6L200dFBQK09sRTd3cDFwQlFHemNrRkdKQ0pDdXRNcWhWV2JTbGVH?=
 =?utf-8?B?TTFOYmc3VVo4L0tKRFZRc0FmNm1QYURoVUUxWE05eHI0eDNGc25EVW5JeXFR?=
 =?utf-8?B?RkIvVlhLZUZxdy8xbTk4ZGVyWlpWRGo2bURoRGVPK1hralhIV3JqNUZXbHhr?=
 =?utf-8?B?dWhEelBScGk4UkYyYUNCWk9xdGJuc1JWV0NacmVlL2FIY09FalhUY3ovY29a?=
 =?utf-8?B?bURhSzA4STdnMEtvVjRISGorcy9YVjZpeVp4bXNlTlV6Tkw0MkJkQmVGM2Zs?=
 =?utf-8?Q?7+EEEwPhhiPLMB3K1+?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec723b73-9f44-4c40-ae3f-08de5625fcac
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 00:10:28.7607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXh0c2EU+W4tIAcu01jn/jhGz/Td1hD/guSxQtiq2TskpT5G2NxeKIDVnFgeZB/Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5806
X-Proofpoint-GUID: ebDL0omM0CEUIk5F8pjOdORXf2I9PpX8
X-Proofpoint-ORIG-GUID: ebDL0omM0CEUIk5F8pjOdORXf2I9PpX8
X-Authority-Analysis: v=2.4 cv=Q/nfIo2a c=1 sm=1 tr=0 ts=696c24f8 cx=c_pps
 a=2TFapuF8m4VBt/+2R/0yYQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=ljm4Z7J5pLfY5P32fV8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE4MDAwMCBTYWx0ZWRfXxNco3oKBEkJ+
 3fojfGzHjdWUC2FfQ+/0EWDF//18JcEQ/KTi8HumhJIb/OqtYP7+Clvh/OPh6ULeGKxagNohIal
 tlrgrLfq2jzXblhxlqoeMF2g/wa/IPqLhW1esih1VpttCmRLKK6WlaemhPoHuQSCfh77PV1Ff0F
 rVxdPuW2aSKL+oOtASVhycdzOHJ+743qKM896pLT2Z1TJbjBqW2PeZ4ozMkebihn9gHzPsT1vcK
 RPNH3qpHqHPPxBTmQHQQ4NMPsV0fG3jnYSaS7BsAx/z8Gwl7D5hemD2vXUSd1lEHcVmBPx4XmAC
 Ttj0fuU/P+uuzOuu6WXBlMQS3R0YlvxNb5E99aJ4gECt4wd5DrfPn9ddUGLEatvSaho7A0Kv/Cu
 iDHKx44lPcJ0Xl8mOSy11V3wTT8AFgmrlxI5lnNXCutv7FH8CbHAArKaPR7jZaqDvdMF7UkBBL4
 YOS829Wtdq8Nan8KDdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-15_02,2025-10-01_01

On 1/17/26 6:55 PM, Jakub Kicinski wrote:
> On Sat, 17 Jan 2026 23:40:36 +0000 Daniel Golle wrote:
>>>> @@ -1156,7 +1156,8 @@ static int rtlgen_read_status(struct phy_device *phydev)
>>>>  	if (!phydev->link)
>>>>  		return 0;
>>>>
>>>> -	val = phy_read(phydev, RTL_PHYSR);
>>>> +	val = phy_read_paged(phydev, RTL822X_VND2_TO_PAGE(RTL_VND2_PHYSR),
>>>> +			     RTL822X_VND2_TO_PAGE_REG(RTL_VND2_PHYSR));  
>>>
>>> This changes rtlgen_read_status() from reading C22 register MII_RESV2
>>> (0x1a) directly to using paged access at page 0xa43, register 18.  
>>
>> Yeah. Just that this is not part of the series submitted.
>> It's rather a (halucinated) partial revert of
>> [v2,4/5] net: phy: realtek: demystify PHYSR register location
> 
> Oh wow, that's a first. No idea how this happened. Is the chunk if
> hallucinated from another WIP patch set?
> 
> Chris, FWIW this is before we added lore indexing so I don't think 
> it got it from the list. Is it possible that semcode index is polluted
> by previous submissions? Still, even if, it's weird that it'd
> hallucinate a chunk of a patch.

We've definitely had it mix up hunks from other commits, but not since I
changed the prompts to make it re-read the files before writing
review-inline.txt.

But, it absolutely does ignore parts of the prompt sometimes.  I'll give
the logs a read and see if there are any clues, thanks for flagging it.

-chris


