Return-Path: <netdev+bounces-143940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B56D9C4CC4
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 03:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE541F2368A
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 02:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FFF205AD6;
	Tue, 12 Nov 2024 02:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YnG7uPWC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854B320493F;
	Tue, 12 Nov 2024 02:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731379438; cv=fail; b=rMLUHydynCndIn2BdGlWra1bFc6R9+S7eIdSFhW/kYt8wCk388NQajF4OP60AxZEWYbuswZDUgRy+EFe0Y/oJ2bZB95cmo6g1B/p1Nf6O0iV9WC2PbtgHKscx96JPPkZw9wF6pL+BYfjkJXEoixxrHApwVAeFpf7GJMQiNuCvBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731379438; c=relaxed/simple;
	bh=iw0NUDQnvmZ5pqHgQBHKr/mXguq2/Ee520GP/JrWEak=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VhROGt9CU8DYYw1WkKYPKZ9rXTV72Hi91G0+LvNaYzWhprRAZbWytwb0wBSRHP88y6LneDWN2/scg+fDLDBcTEj3ewlwTHv2BUfF6Ge1uYhCJ0T75C7hQTG01OJLagBH1JewFIVeeXL4j+BP0B+h4SoE+Tb1Ag17vqTZwX7VD00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YnG7uPWC; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqX/9P+0UgFZX9etBvGcHirLt+oQtDh4raY5nSWEA0mJSiUTaa+Q13L3BEXs6sV5ggtUiWyshja6ZIRp7FPr//gIr3xkbHEW0k2uVOENPZjW0OSrauWu2srEWbbzpIvOuYAwcGDPDWR+0NWhxWg14jvhO5yUHrhipFnEEAQPCxk4ECpGqZqmLT+W1LlSdHf/kSUbqB816x//Sq8GBZgogj7mD96/LFHqMGYdygA7mOhlcsPpIu1wx2GlNkCKNgFHSI/hA049DG/BYTOLzqBT92FB+8OWQILPcQNTqg2p4DuUW8SGNoQM0p7Bgsq+t5JLmobsIY9oSVy/DWRtmByutA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iw0NUDQnvmZ5pqHgQBHKr/mXguq2/Ee520GP/JrWEak=;
 b=n6fRx97H6K5OFP0hyRV6w0AaJ/BAvLn/ByvlWR5h+bwLUNXiZtekGzJr2UitzEfLStV9X+6WwLzGyDtZIJvtOyoZCZ/UIMJXZD0onvVip/YGDxyhCbe9UffumEzfLYcn65M1wj7hpTto78EvC0wHLfv+nzXZL9PxrBzHNqflISKXrT0NulG+p7PZotvfzMGJIqvritvJ5wSqMngtPgQq2Kj6w+L6nIVRY9kKqhNC/I+ColErawvt8hPjWPWVUL8kDnF4jOh+HYYsK97RMEubi9kBoQ/erle64as+uRRJoK+2ks/W+4dqQjwS5B4t9DFZNOV81nZmPSMogwDTdY/QQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iw0NUDQnvmZ5pqHgQBHKr/mXguq2/Ee520GP/JrWEak=;
 b=YnG7uPWCy0Lys5y8dWwOChjauymfOCB7ijnibOe8CJR8Hul2c+vog6ZBzKfc4XyvsfL3cmXfsYDJyKey7Ry3AakOAphguyul0kfMRaFYZbpYAHR7bno9ArDcMPo99wQgiTlKHoXU2iPh67FCXgH2MD6KQnQjKNheKSauOlfnxMiAxc2djAw8MVNNA846NeOguO2Kg0Zu/SE07DDQ5M8/gbZ4IYgiAGUnJ18JZWfSoqNKvlgHeZaBgfTb9F+All5Hb9qYj0+TkoeFxpw4mP2Qf02Biz/f0Lgi0ZOMyOFulI0KwOjaxRx+jNLs0RzZJDnMbwOhm7wWl18C8vxHT38gug==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 DS0PR11MB8719.namprd11.prod.outlook.com (2603:10b6:8:1a8::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.28; Tue, 12 Nov 2024 02:43:51 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8114.028; Tue, 12 Nov 2024
 02:43:51 +0000
From: <Tristram.Ha@microchip.com>
To: <olteanv@gmail.com>
CC: <Woojung.Huh@microchip.com>, <andrew@lunn.ch>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<marex@denx.de>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 2/2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Topic: [PATCH net-next 2/2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Index: AQHbMkqiYUyxAMrEtEGHh8l2mClPuLKwq9IAgAJIvRA=
Date: Tue, 12 Nov 2024 02:43:51 +0000
Message-ID:
 <DM3PR11MB8736CC54CC0674DE06B4E11AEC592@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20241109015633.82638-1-Tristram.Ha@microchip.com>
 <20241109015633.82638-3-Tristram.Ha@microchip.com>
 <CA+h21hqWPHHqMQONY2bKZ2uA2pUzm2Rqwo7LTX+guj7CHo4skQ@mail.gmail.com>
In-Reply-To:
 <CA+h21hqWPHHqMQONY2bKZ2uA2pUzm2Rqwo7LTX+guj7CHo4skQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|DS0PR11MB8719:EE_
x-ms-office365-filtering-correlation-id: c44b4e3c-8730-43ce-cad2-08dd02c3d74e
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?enphTW45ZjJ5Q2tSNTl1SUJWc0NQOGRtaHltOWNFSFd1QWhKUmRndWY3UE50?=
 =?utf-8?B?c3NoWVdVNHpaKzhVL0toeU9peXVkSG42UndDb1lNbG5JY0Z0NEt5cEgwekFm?=
 =?utf-8?B?emVYR3RnYmR0a0JuSjJLOFNLVFVBUWN6bDNrZW1LQXVhaEMxbGc0Q3dOQmxZ?=
 =?utf-8?B?MUczS29mU2dNUlZhWENrNk8rOWV3YkpIUEJtSWg1TEpiTm5YQUpaeFBTQklS?=
 =?utf-8?B?QU5KRUJPaCsvanpZQjArZ0xkTjA0bXNQR0NGNGQzL0hEemhTMko1UUNaNnB1?=
 =?utf-8?B?enJIemMvTUF2RytUcm5rUFg4c0VSb1hEWXhVN3pEY0o3ZHNtMUpMTlF5Nkxy?=
 =?utf-8?B?K2s3ZHN6am13Y0pXRHNESWkyYWNPQ0ZnWmNHZlp2YmJGT0lKc1VHMEZNbStC?=
 =?utf-8?B?LzNGRVNHTkNqU3lQQzZWWEpyb2RHOU9PWHBVSHVsVkx4RG84ME9zUEp2cnVW?=
 =?utf-8?B?OVgvU2l3UW9kc1IrNDNMMkJmWHZydkZUUHpaNDhzN3N3QlB3RGQwZDV2dHVV?=
 =?utf-8?B?d3d1eWlzUEZmMDdRUCtvK2R5ajRQMEZ3M0tXeUFUQm11aGxIS0wvMlpyT0t3?=
 =?utf-8?B?MGNTdUhmbFlqV0NwejgxTFQ3dkEzMTR2NXNEbm42alprcitJTmlya0Y5Tno4?=
 =?utf-8?B?UU9pOXdaTnZ3QmJNOVRORmRUR1hjUnR3Vlk5OTROOFEyRkY4dVlvbjRCVm54?=
 =?utf-8?B?M3Ftb0Zqc2VtZ1gya1cvLzFrY2VEZ2lCNFNBVEdac2YwS0FzblZkYVNtUUdZ?=
 =?utf-8?B?clJwZGFaWWF5QkdWM050TCttQUcvdi9PVDlsK3NNNjFOdlRyUUVTLzZJd3FZ?=
 =?utf-8?B?WFJBUENKVlFrZkF2cUZXZjlrYktiTlF0TjVxVVREU1p1endHTjFwYWdRWFAv?=
 =?utf-8?B?dlNuV1pmZzd3dlRyYzc3L2dISGs0T052WWs0RVN3N211U1BIVW05dWRnWkd1?=
 =?utf-8?B?Z2VYSTdkY0Z6cGxTd1FVdVZRbnMzQ2k4Qm9PdTBKZ1lVbS95Ym03YUcyVDRw?=
 =?utf-8?B?RFhQRytseTNHR3llUVJVeC9EZHVkM2lVelZqd1NuRGxPRnZPR3l1bGM1dWZs?=
 =?utf-8?B?YmFWTno0ME1pdlZXSmlTa2FFaEZxREJ3MTJPMFFydjJXdWM1dU5sVVozT0xM?=
 =?utf-8?B?RmkybDJnOHpqUGV0c1VPU3NSRXA1NFJWTU41cEl6OHRYdkplZjVOQ2V2c3Vu?=
 =?utf-8?B?YUJIY3ZCS1VhM0VBRUpLTUYwdFlPWk5DbVB1WlVkZTNObUtLa0hSOTdUdXZO?=
 =?utf-8?B?d09veCtjM0tlOWUzenVhQ08wUkRUb1JleUVOaUY0THo3c0I4S1Q5a2UvaGI0?=
 =?utf-8?B?UWRQajExdW9KM3UvaFlwMjR6VHE1RUVyWGtVeHBvaDNRQlBtYVFDQTdLa3FX?=
 =?utf-8?B?Q3NFTWtpcVA5MDNvcWQzKzI4SVM1ZDR2OWpPQTVXOTFwSmxCM0NnSFU2WEZJ?=
 =?utf-8?B?WitWdFo5ZXIxdzJxWWdUWG1wS0xtaDZaZXl3b2FPUUUybTZ3Q3V5Tko3N3VI?=
 =?utf-8?B?TUZkcGxYeUxIQ0lGdm1uZjR6bUxQQ3lETlhUQWEzL0ozZmhLbHEwWUR2TWtI?=
 =?utf-8?B?ek5KYXBoa3FIYVVDVXYvRGV5aTRkYTJXYnpZMCs0Y3FsdFVhc0NOM05uUlFa?=
 =?utf-8?B?bVZENW9xTVBscUcxTzdldDJSc25PNGpKb3lVRmdHejBZdFRVb0hFNnpMZmw3?=
 =?utf-8?B?bUNSR0Q4U1hYcWc2VzBXSk9ZZktFcGhEQ1VKOFlpZ0RPa2xiN01tVXJ1S29W?=
 =?utf-8?B?OWFJU2xJbFU1TEt4QXFYTFkwcXpNVTN6SGcwZ2k5U0pUejVaQ2VtRmdEcVR3?=
 =?utf-8?Q?ntl22OknLF6cytamYsfFpRmLwd0DJX63hEnYE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y1JCa2hxcFJiTTFLNjVUVERnaVhweHJzN1FKUHFtRmZ4RnIyam4rUkhLOE1n?=
 =?utf-8?B?SllnbzhsZHBBKzIra21LdzJGdnhHNnE3eDNmWU4waXFPZkU4V3l2dkFRMWw1?=
 =?utf-8?B?RWlacXc0dzl5Y2x4bU5KdUJ6NHA3VkxRS1E1eFhud1FBM1ozLzBXUkFlL1di?=
 =?utf-8?B?RktyV1NnNkZaRm1iaHZacWN4b0NnSFRQZ2FnTFhiTjZJcDVDNXM4T09iWWdU?=
 =?utf-8?B?aUkzZ0o0Tk9RY1pZMHJ0RzZBQkVtRnFpNDFPUUZmZkhLeWlmbU5CMGdrNDhB?=
 =?utf-8?B?cFVaaFJxbnM0eFhlVk5IbnYrL3ZCQzcxODVsZmszZTNyYllrTjFrM3N1S3VH?=
 =?utf-8?B?THIrdzBpcEg1NnhLdWsxYUZaMC82RDFsMXR0WEFYaFNFd1c1elhLTXpQc28r?=
 =?utf-8?B?SmNqYzdwdnRob0lLZVJkRFZJSnF0MDZ0U2Z0akFJdjhacWJTZFViOFlJRnky?=
 =?utf-8?B?cW9jSXQzUEVrMlhQUTNvc1dyRTRUbnVpQkRpeHVpY1RIMjBYSUF4VGE5Y1Nw?=
 =?utf-8?B?RUJZcCszbFNNanVZdE14S0FOalo3c3YvbkRrU2tJSFdWRjNwb29HeUZwQkpZ?=
 =?utf-8?B?YVg4TEFMdEI2ajJqWHRSSVFORCtvb3NIbGluMUFFdk9pQ1RUcHA4Y1QrQWpN?=
 =?utf-8?B?cXQvdUR0Z01UNXpaNTlRWnpXRHk3MzZkUC9DNExtb2ZGSGlrRHB5dllSc2x0?=
 =?utf-8?B?SW12eFM1YVEwM3RRODE3SEFUQ081ZmZIditMVXBrM0ZUQ254YnluK3ZCOVRk?=
 =?utf-8?B?VW9RNkNJRExZTFJPeGcxWnNzUVRFK1l4NldhSDNWNUhsN0RGY1pPSnBzaDI3?=
 =?utf-8?B?a0pQUW5LMktaN0FCZUgzU1NFdW9FLzI1YlQxU2NMMU55RFlLVWNVU2NFd1Qv?=
 =?utf-8?B?MnZMRDlLMDMzNGpKaVhCZFZnc01EZ3Y5cHVxWmg2VDZxTUtIVnpHWXc4NXhB?=
 =?utf-8?B?QnVGcGo3SExUd21pZW9nSkdTTXNJUmJiMnMxYS9LQldUUCt4VCtUMjVKWEdI?=
 =?utf-8?B?cGRmbVR3Z1JqOUptRHhvN0x6UXNQQ3lHa3gwVFBSTmVrbEFRdHJIUTBGeTBp?=
 =?utf-8?B?R1B1dWZscSsyZUxlekhzNlp3TDFiOUVIQnozSXJMaFNvcWJKTHpWbTlxRS9w?=
 =?utf-8?B?ays4dE85NUlHVEt6T3Ywck1taGpJTnlYNzlOc2hWUklqR3hHZWZlenpxNUdk?=
 =?utf-8?B?ZThoVlR1WHFwbzQxT3hnNWVVakNodVQrdERoUTlkbW1idVZzNGZ2YktIeVpQ?=
 =?utf-8?B?Y1MzTHYzN2dYbFJkanF2bTN3T3ZaaGQyKzR5SjRPVkdVQkwybkJmdXh3Z0F1?=
 =?utf-8?B?dXhGaS9DMFNEOGR4cVhGN2p1STI1Q2FEOE81V1Jjd3hZZ29obXV5SlgzYmdn?=
 =?utf-8?B?WjNmbmlLTERoano2NnRIdTF5M3RwZXVZbGlBc29hdlMzN0xzRUdpQlBZSllF?=
 =?utf-8?B?bjNNUU95ZE1DUm5FUmxkc25RSXdnRkNkQkdONmI2MGtjaGU1Z2YxajROS01y?=
 =?utf-8?B?a1NLYm93eGIrK1QrbHNxK3JYWUg3RVVSOXVyVnZib0x4bDI5SEZQejVKOGd5?=
 =?utf-8?B?ejF4azd6MlkzY0EzS2RWNmErR2JiU295ZVN1RjBDQzUyZjQveTNRS0NHOTNC?=
 =?utf-8?B?NUF0NmtsOUZ6alVBR21WMUVJMG55emFMK2NmWUFtMjQ5MUtVcTVLckNlTnhT?=
 =?utf-8?B?REp5RVNuUWhnRGFZMmN0NlRpck9CeE1EeWRDbzVsYmhRVHArODk1czFZRDlK?=
 =?utf-8?B?dC9DWkhOZVRUWjQwb1JHMi9UdGcyeXNmZGNnZWYvbTBDV1BoUXNZQ1dVVCtH?=
 =?utf-8?B?aitNV3BySnhlS2JkT0tnVjZjTmRlMTk3cHAvOFZGclRmaFdadFdhZzZDQXhP?=
 =?utf-8?B?OFFOVXJGMXpIZXQ2NGIvY1g3a2FNTzh3ZUFpcEQyeDRlZWQ3WGxhSDlBckEv?=
 =?utf-8?B?dlZhYmR0cmV4Q2wzU3U1dlY2UmtrcTFYWk5IVExlZThzemR6akw0cnh2VU1S?=
 =?utf-8?B?eFZ4SXFFQWlaTjhtdkgzMDhnWUVFSkRFR1o4S25HdmpGUEpiTnUvNWtMWVk4?=
 =?utf-8?B?dmxOcTY0bkdNSFFyUDI1UFBXL1BqT3FLejVtVFZYNitxTzdNVk9wQUFTcjNO?=
 =?utf-8?Q?T2aVcIiaXr+K1E/0F12KPJSV2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44b4e3c-8730-43ce-cad2-08dd02c3d74e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 02:43:51.0352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KNfGnWZs4j6FYyWLLPS4/l9lwWhrOHhI5OtBX/S5NBmkaRsQAbfNXJLZeEKzySYEuszyVEGsSe2VWjOf6P+nfpvDIDnnTU5wYCmEm0HklTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8719

PiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0IDIvMl0gbmV0OiBkc2E6IG1pY3JvY2hpcDog
QWRkIFNHTUlJIHBvcnQgc3VwcG9ydCB0bw0KPiBLU1o5NDc3IHN3aXRjaA0KPiANCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudA0KPiBpcyBzYWZlDQo+IA0KPiBPbiBTYXQsIDkgTm92IDIwMjQg
YXQgMDM6NTYsIDxUcmlzdHJhbS5IYUBtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3pfY29tbW9uLmMNCj4gYi9kcml2ZXJz
L25ldC9kc2EvbWljcm9jaGlwL2tzel9jb21tb24uYw0KPiA+IGluZGV4IGY3MzgzM2UyNDYyMi4u
ODE2MzM0MmQ3NzhhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAv
a3N6X2NvbW1vbi5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3pfY29t
bW9uLmMNCj4gPiBAQCAtMzU0LDEwICszNTQsMzAgQEAgc3RhdGljIHZvaWQga3N6OTQ3N19waHls
aW5rX21hY19saW5rX3VwKHN0cnVjdA0KPiBwaHlsaW5rX2NvbmZpZyAqY29uZmlnLA0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgc3BlZWQsIGludCBkdXBs
ZXgsIGJvb2wgdHhfcGF1c2UsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGJvb2wgcnhfcGF1c2UpOw0KPiA+DQo+ID4gK3N0YXRpYyBzdHJ1Y3QgcGh5bGlua19w
Y3MgKg0KPiA+ICtrc3pfcGh5bGlua19tYWNfc2VsZWN0X3BjcyhzdHJ1Y3QgcGh5bGlua19jb25m
aWcgKmNvbmZpZywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICBwaHlfaW50ZXJmYWNl
X3QgaW50ZXJmYWNlKQ0KPiA+ICt7DQo+ID4gKyAgICAgICBzdHJ1Y3QgZHNhX3BvcnQgKmRwID0g
ZHNhX3BoeWxpbmtfdG9fcG9ydChjb25maWcpOw0KPiA+ICsgICAgICAgc3RydWN0IGtzel9kZXZp
Y2UgKmRldiA9IGRwLT5kcy0+cHJpdjsNCj4gPiArICAgICAgIHN0cnVjdCBrc3pfcG9ydCAqcCA9
ICZkZXYtPnBvcnRzW2RwLT5pbmRleF07DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKCFwLT5zZ21p
aSkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVPUE5PVFNVUFApOw0KPiAN
Cj4gU2luY2UgY29tbWl0IDc1MzBlYTI2YzgxMCAoIm5ldDogcGh5bGluazogcmVtb3ZlICJ1c2lu
Z19tYWNfc2VsZWN0X3BjcyIiKSwNCj4gcmV0dXJuaW5nIEVSUl9QVFIoLUVPUE5PVFNVUFApIGhl
cmUgd291bGQgYWN0dWFsbHkgYmUgZmF0YWwuIFRoaXMgZXJyb3INCj4gY29kZSBubyBsb25nZXIg
Y2FycmllcyBhbnkgc3BlY2lhbCBtZWFuaW5nLg0KPiANCj4gSXQgd291bGQgYmUgYSBnb29kIGlk
ZWEgdG8gQ2MgUnVzc2VsbCBLaW5nIGZvciBwaHlsaW5rIGNoYW5nZXMuDQoNClRoYW5rcy4gIFdp
bGwgdXBkYXRlIHRoZSBjb2RlLg0KDQo=

