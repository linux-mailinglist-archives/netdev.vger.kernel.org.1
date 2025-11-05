Return-Path: <netdev+bounces-235706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA67AC33EE8
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 05:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60277422CC9
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 04:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E2A21322F;
	Wed,  5 Nov 2025 04:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eM3NFZCD"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010062.outbound.protection.outlook.com [52.101.46.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B03C2FB;
	Wed,  5 Nov 2025 04:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762317474; cv=fail; b=t4pJ/gGcq5UcGkzSV3qVPTgyJ2ghSLGdqOgTGjeAQKlATuQtCDDCIZD7n7KyrhCsxS9lTCdOSbwn0k9dewfH3rVClJct+bXjdG6OgohxNY38H4yL6hrNO9Oyybx0Obxi0D0CyDsQWkYqMLGvT2IQD25qD1s08IzfCJZZGcGX6mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762317474; c=relaxed/simple;
	bh=ouMwwnEqNvrspLrHtc7H4r8K6mCHmEOMTlOpwSxkX2g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jedRTcVt++h15E1a+90VuWKdzDbo/37jZOusFJ+6MXr+S/4FOaoMf7zkk51MoNOD2OLqxUCpFuK377SHnPxXppRrn4Y4z61YXPUOXTtFZP6IRQ0wNrNSJKS1z8vlQc93HDhuJTfMVecjJpB2aPDX5B9kPQl+J/HflDVu9rdpQI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=eM3NFZCD; arc=fail smtp.client-ip=52.101.46.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9G7gN5DGmE1OrUxVssL7e3/rH9Ib/rz5TopWezXXABcViz0mHALPrFPJPhpfKLh7HzcFego65Stg3x3KZXAsflbg14Sikrk3E+RcmSK+PlixaB41nIUYTM4+nyTFH9jMnpJPZT2oPfOO308QddN0MJLsTxqUJ7moWIJdNh6sFqVnIucFmm6bFw3LGhNWQWBMTfpeNeYEbuZrORupXQb3MaxAI71KHypQIPXWDt/K/yr8CfMxqsc+0vucu8lH9ZTdFt7wJeTAipxWnHTFYJuB1QIJJzXa7peBLjsqsfSPFVUmfYFeaVGlzrq7ZsnWJWBrOrGLy4UgGikhhaADXUqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouMwwnEqNvrspLrHtc7H4r8K6mCHmEOMTlOpwSxkX2g=;
 b=upLEDHEMp/F59l9JVQI46j2mBlzFU/eoApdyh4vcGwXB/IwKP9lh1llJVyNOTFYsLozYV9NFxitPGsQsOgRuUCcf/XjU8xz3Xp9mmfOx2tWOk8lB350ew5/X9nuaZAKnB5p9EPz5iIS9v2DagDvqUtilZMi42Nb/W5vXMOUmrGf1tMiO2OOmD6bBu7DM5t9g3imJ9X4lXlNfXEs+/fAqo+3O/XRPuQf0b27tchURyqff6tBYK8/OqFzDhQ2UOMXOoA5ctNUYV7eCbIUgeo01CGEtr2+VHyJ34QtqzaeBd1O5V2Vbz9nE07JhMC1QtThc62BJ5rieLVBsNPe6QV7wjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouMwwnEqNvrspLrHtc7H4r8K6mCHmEOMTlOpwSxkX2g=;
 b=eM3NFZCDSHPCgeeCAewjRVWqo0chchoYnWaD44lc4s5eMb65kUbG1FuXqiHf59FtT65FoT7aKGgLQKbkrwJeahKuYJzZhFx6l5NkaZIgv7UbbMogtuGa72uMIwCSHGmlgZ0udARJ4R5/7uvNnkhujA6phyzv2F+G0fRHWRRoWdllomzCCxKNnme3/80eteYIQc0HeWv2s9M2uSXm9H5X/8q3rydC1M3xK8+DgvSbAftvMANymkxkjbCnnASN3+B0rYtjOKb0LGpjkJk20P4cLIqhrKEx7idvF2zT/HcRzP0RC31tT3qXCJ2KIKMgP4DENjgT+3vpWh+xJ2ZcWeZd+g==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by IA3PR11MB8967.namprd11.prod.outlook.com (2603:10b6:208:574::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 5 Nov
 2025 04:37:49 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 04:37:43 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <piergiorgio.beruto@gmail.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net: phy: phy-c45: add OATC14 10BASE-T1S PHY
 cable diagnostic support
Thread-Topic: [PATCH net-next 1/2] net: phy: phy-c45: add OATC14 10BASE-T1S
 PHY cable diagnostic support
Thread-Index: AQHcTXS+19gdjoaUJkOXUYwUQBzbBrTiqY4AgADXYQA=
Date: Wed, 5 Nov 2025 04:37:43 +0000
Message-ID: <62244da1-c644-4f89-b803-1a0c80d4bad8@microchip.com>
References: <20251104102013.63967-1-parthiban.veerasooran@microchip.com>
 <20251104102013.63967-2-parthiban.veerasooran@microchip.com>
 <a202e0d0-4ece-4697-89b3-28bd9e3d07b1@lunn.ch>
In-Reply-To: <a202e0d0-4ece-4697-89b3-28bd9e3d07b1@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|IA3PR11MB8967:EE_
x-ms-office365-filtering-correlation-id: 843abce3-6f37-4a03-ba30-08de1c250f99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?U3ZHYWdSUS9jMDhTQjVlS0R6cEttR045Q3lJcXBwbUpybmJzTmw0Z2krc1NL?=
 =?utf-8?B?QlBiQnVnbHBxNFFSejArQ1IxQVNuLzk5bTlwbHVhSkIxcFFXczdrc01yT2p3?=
 =?utf-8?B?VHg4Zk1rOEhIdjd5aGxmZ0d5TG5UdGpVb1ZYeE1GTkNlZ2xaSGcvTTJ3WENv?=
 =?utf-8?B?c0gyUDVwVVZNS1lzZlBoOW5XT1RRS1RNVk92VndEbDJrR3NvRDk5YWRGbVBO?=
 =?utf-8?B?T0RnMzBrQUVYZDlkRHBxQU1PSU5OUzdNSjAwYUFZRklnQVNqa0hFYVY3Q1RD?=
 =?utf-8?B?ZjM3Vms5QWZoT0gzOWh6LzFnQTM0S3U4ckRaMG15bTlGOWVmNUN0SG02cFJl?=
 =?utf-8?B?UVUwOElYWVNlWkVOcFN5ZGlQT2dOcE14eWtubUR3cHhqQzFpSXQ4SThOVDg3?=
 =?utf-8?B?bFIyeEZEQm1HRnFCWXErQVZtakV5OXIrc0JpaG14NEdBVVhLanpZeUlaYVZV?=
 =?utf-8?B?NDR1aUwxbEx6c1lHTlFVNTlIMHFORm1TRjlaTkh0U3RXbCtRNDl4V2RpUjZo?=
 =?utf-8?B?TnA4MmxmYkp5ZVBaVU0vdWpCczFjd255R2R3Qm5VTTAxM1Fzc2ZnRk1yL0hP?=
 =?utf-8?B?ai9FRHRyZmtHQVVUNFhpK2haLzhFUUNnTDdIeU8rZzRDN0M2bndVL2FOczdR?=
 =?utf-8?B?dnlQVXprTEpaQ096NEc5WjZvZi9RUTU0dVRqdGVJQ3lKNTZiRE01R0V3M0RL?=
 =?utf-8?B?SGNtbFJsL0lGemZCdTZPdTFNRzRNb1VrWTNlSXdlcElkK2RGY3N0Mk9ZRFJ6?=
 =?utf-8?B?T1RqaVlmVmFkZzNlQnRDZk5zcStSM0NuSnFHNldGdm82YnQveko2ZzRmMDVu?=
 =?utf-8?B?TzNRWnBtdHBsaHNCVHhjdkxPeDI4UWNsVVQvZXNSTzBuTWFWVzMxT05JNS9W?=
 =?utf-8?B?OUhWcWsxSjBnWkZFaEhaMzkwZXJzSFArWUJuN2laQTJ5bjhEMmpLM1dCUUcy?=
 =?utf-8?B?UTNoTGZCZ2JUOTJ1MU9HcXYrNFVsTXFhMGprcWFTVXU1anZ2K2xPN0Foc0I0?=
 =?utf-8?B?ZDVVK1pYRHhWWkt1UERvOVBoRjkvV0NWOU5Pd1ZlVTFMQ05acnVHQnZacHhZ?=
 =?utf-8?B?bWxaR2laODBYTjU5dkIzUkdCNlplVHE5UXVtZ1ZjQTdhcDZKdlZ5d21xeFdN?=
 =?utf-8?B?QTNsSDVVcVhBWVNKZEdwRDFLVVhYZm1FMjlGc2lPczhCc0hiK2YrYUtxY2Vh?=
 =?utf-8?B?YmlzL1ZFdVhaYVJSZHF5MmtlQnRYMWRXVzczSitUN3JLWkNFaWU1WWxuUTlV?=
 =?utf-8?B?bHkxNnc0Zm95UXppTlErYjFIZ1NtcWJ2U2V3TkFoUUFSYlhLN2xGS0U3N0o5?=
 =?utf-8?B?K0x4QXpJWnBMMnVmMmlUQXdjWitMVXYvSkd6ZlZlYytpc0pOTC94QzlmR2tr?=
 =?utf-8?B?M2hlRU0vQ1c2Ni8wdEt1ZzN0MTA0bmRTTXlSYnZVcXRabkgvd1lTeGFJV1dL?=
 =?utf-8?B?elA5b2ppNHg3M1k4R1ZjeW91dlRrWmE2WFd6cU9DYkRMMnkxVGNldFB2anBY?=
 =?utf-8?B?Ykc4WkpjaC8vaUd5VEJRV0w1NVpLSUZRdFN1akxrZmRSMytqaDBBVTB0U00v?=
 =?utf-8?B?NDQ4Q2ZKb05wQzlGeXdYOHFUNk5ySFgxT05uKzJXSzU5SnZxSTJjZENMbE84?=
 =?utf-8?B?Y3Z1cWg1TU1rNE1DUEN6Vk1KNXl5blFWaEowSE1LNWtPSXR1TFNveUZnbk1n?=
 =?utf-8?B?NTJqcEQzQjk5aHRXRmkvaXd1TjdqY0JiRlFvTGE0RmU2UTJMVERrRGl6ZHRy?=
 =?utf-8?B?VWZTWVhWMXBrVzMxWnZiWUMwdW9pVXJZVStXRzU3MFROTFNKRVRqcHovZ2tn?=
 =?utf-8?B?ZEo2OTdCblhtM0FDUHg2NU5KeGVlYlZUUFZENHI3TTh1cGhqZTkzNW1oQUg0?=
 =?utf-8?B?S3pnS2ZvRmN2dmlRMmt1M2F3aTlNdnpDeFVjUnBGNHQrTzhpem93L1JEdUNB?=
 =?utf-8?B?VkpkUHlKS1Z3WVVPWjRHYUdxVExqMXhaeW9BTzl0cVBzNlJSeEpveElENm5D?=
 =?utf-8?B?WVczZkxySTFiRmRRTmFlalpzQ2N3dUc0cnRqSmxSTHFHejc2ZW5aNFRDOW1J?=
 =?utf-8?Q?Uw9Nko?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TkRyTnMzc3piaFpLblZQNUp2WWI2VUlURzZYNmhadW5BVkVLVTNtUkh4ZkZj?=
 =?utf-8?B?V1BNbE1kbUI3WG9LNDl5QzlLUml3VnErVGYrNGU1TGxHT0c4MkdWQUtxc0lE?=
 =?utf-8?B?QkQ1Q3ZQaTZrS20xTmFUckdFRkxuT0JXTG9wRXR0TC9ZRGJySUIxVjFwK1Jm?=
 =?utf-8?B?Qi9Sd1cyNDR2ZGJaY29oSkRHU0lNVFI3UENOOVVmcndMbkpxWDR5NTFUandw?=
 =?utf-8?B?VnlVUFdGTUhkb0tWOWZ0bjB4ejR6T2FsQTF0MEVSS0FoZzBYS21JLyt5bW0x?=
 =?utf-8?B?VVNiY2oyVUF5MW80bk9GRExDd0hXVXpaeEo1R1JrR0E1dGpOOTNWMHFWMkE4?=
 =?utf-8?B?d3R6OWJOaTZOQWE5N3lMM1VnMVp3eGNleUlMb2FYTnlENG1rUkIxSTBNVFN2?=
 =?utf-8?B?aHRQcHV3Qy9xbUJTYTM3WjdDNTZiQ1FhNDN1bzVqUGRybC9sdE4wMEVZdUZr?=
 =?utf-8?B?UmZkZlVZSVF5LzFyeVMralFnNzdWZHdvZk5RK0pKOC9rN2l0cUV0eGhSM0xl?=
 =?utf-8?B?VDUvWHNsZHI5U1VRa0d2TkpvanhTWGVqQ1lWY0tHZFZ6TW4rWnE1ZnA2Uk1V?=
 =?utf-8?B?VU9XRWxuMVR5Y21JYm9DaGN5UURDSVBRa0U3OXFiZFJ6ODFIZUdMSWx2MkN0?=
 =?utf-8?B?U1VkUzFmaTlTbjQxeTYzQkpKWGtmTThVTmF0Z2RqcWxkL3Y0Szdid0JWWFQz?=
 =?utf-8?B?clRrZlQwbUtyZ0d5djM1YjlHZXh0MW5JNWdvQWpPekllUU1EMTZ5K3pCbDlh?=
 =?utf-8?B?N250a3p4Rmw2cGdlVXRxV3Q1SHVhb0NmRDludEI0a0lKZXUxMGtzcTBkam9T?=
 =?utf-8?B?RldiWGtLR2xTcUlKdlI1dVhtTEZwK1pPejJ1bG8rdnlYV1M5Z0JTMzdYNnV2?=
 =?utf-8?B?WmJBd0o0MlFjVURKT3N4bnowOVBKL3dmSmg2bWpmODQzdE9wazlOWnkzbllT?=
 =?utf-8?B?Mk4vVThmSm1TdHdXT0ZDYS9GeklFN2o1YUNtVlFzdEJ0NjNDd1RrTFdVeFQ3?=
 =?utf-8?B?QytmcUs2b2FqbHBkRmZKUmFqaUVvb1QrVWhFU0FTTG4zb2NIZTFmQmNUL1lQ?=
 =?utf-8?B?dXYwWVdhdFdQQjBFZGZVZW51T1Qwd1FOZWtIdmZpSVJiNHR0ekFKeXVLZEdO?=
 =?utf-8?B?UFR1a3VZd2REcU11UTZGYXNXUzI3SFRGWjZaNjVJc2FJMXN5bktsaGlNMHNq?=
 =?utf-8?B?aTRVeVZLenRDWW50R0hYTW1Jb0V1cU5PbXlNS0JEZkRJOGY3Wmw1cWJLWkxR?=
 =?utf-8?B?SVFmUlcxOXlEU3RHWkpJcjJTWTVUUEZ4NmF3dExpNitRMzh4ZlBYYjUxeENB?=
 =?utf-8?B?MXRaeUg5dWk2dGluV0ZLZWdBTDNIUDEvK1d2UFNxSUlZN2g4Q1B6V2JMVkFw?=
 =?utf-8?B?UlpkT3Z0LzY5Z0RjV1VQZ1BQdGpOUzFDcDMrU016V0wrRGZLVHR5OUh5aUhL?=
 =?utf-8?B?SG9zZ05YaFd2VDNxRHBYYlgzZ09YMDMzeEpzcEVJdlN4NWd6VEZBeDFpTm02?=
 =?utf-8?B?b05qa3hYZXliL09FZkVMOEhBT01uMVY4SmNZV0pEa3dmSkN5YkFwRER1YVhq?=
 =?utf-8?B?Q1A3L3ZUK3N6RktRSHV2WUdnTzR5Q3VnZFd6Vi8vZnExeFZKSTVWOTQwVEt3?=
 =?utf-8?B?MTFhMFJKU2tQazdlY0F1VTg5TUxtMkRWc2FibTlubk5nQyt4QXZyeHRGM24y?=
 =?utf-8?B?WEZnL2oxN01nNUFUYzJyUzJUcUhWT2lLUFhQRmMxNm9kL2N5N05oMVBMQmN0?=
 =?utf-8?B?eFB1R2JFdjJ5WUtpQXBwSU1Xa0lNMlV2amJPSXdMSVNZYmhFd2hqait3bFEy?=
 =?utf-8?B?NXV4OWdKT2VzOHBSK1hzTUJHU1V3empybjdWQ1BDdjhqY21tUWpSQmM4ZUV4?=
 =?utf-8?B?ZlZiU0Q3N2d6ZUVwb0QzM0JGNTg4MGdhRm5ndmhoSnpVN05meUgwd3BMeE1M?=
 =?utf-8?B?a1BVQkFCazFjRnFaVXBBSTd2MkdUcFIxZDRiQW1ZWEZUaU0xbm9aNHp4NmZB?=
 =?utf-8?B?UlNHblI5WHYwRTkyY29sUTMxbU04US9uNHBLUG5XMWRhNktOSGMzRnQwVGpG?=
 =?utf-8?B?azA5TGwvRlM1aXNhREtXSG9TeFVMR3FqYUhQTWFkbUljb3JyZzVLNXNiVElO?=
 =?utf-8?B?SmprcXc0Z3o2cU1GQXE3bXE4ZWpndWtmdHJRVHpzbHBHUTgyNzcyWWlOK0hn?=
 =?utf-8?B?L3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93E27EC9DC4CF64AB4AE1D4122A211D4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843abce3-6f37-4a03-ba30-08de1c250f99
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 04:37:43.4163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0fBTQrEcMCF8n8Y7X+lHLu1KN3FXYQroDKCc4aIoDoxWYyuc73MRLoLBCXFF66stPGsxlv9gnmelznEkthWh3rNHldoOWilhWiJ2+5ur8uwzivVTFNEAtONBl6rrjGHx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8967

SGkgQW5kcmV3LA0KDQpUaGFua3MgZm9yIHJldmlld2luZyB0aGUgcGF0Y2hlcy4NCg0KT24gMDQv
MTEvMjUgOToxNiBwbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBu
b3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNv
bnRlbnQgaXMgc2FmZQ0KPiANCj4+ICsvKiBCdXMgU2hvcnQvT3BlbiBTdGF0dXM6DQo+PiArICog
MCAwIC0gbm8gZmF1bHQ7IGV2ZXJ5dGhpbmcgaXMgb2suIChEZWZhdWx0KQ0KPj4gKyAqIDAgMSAt
IGRldGVjdGVkIGFzIGFuIG9wZW4gb3IgbWlzc2luZyB0ZXJtaW5hdGlvbihzKQ0KPj4gKyAqIDEg
MCAtIGRldGVjdGVkIGFzIGEgc2hvcnQgb3IgZXh0cmEgdGVybWluYXRpb24ocykNCj4+ICsgKiAx
IDEgLSBmYXVsdCBidXQgZmF1bHQgdHlwZSBub3QgZGV0ZWN0YWJsZS4gTW9yZSBkZXRhaWxzIGNh
biBiZSBhdmFpbGFibGUgYnkNCj4+ICsgKiAgICAgICB2ZW5kZXIgc3BlY2lmaWMgcmVnaXN0ZXIg
aWYgc3VwcG9ydGVkLg0KPj4gKyAqLw0KPj4gK2VudW0gb2F0YzE0X2hkZF9zdGF0dXMgew0KPj4g
KyAgICAgT0FUQzE0X0hERF9TVEFUVVNfQ0FCTEVfT0ssDQo+PiArICAgICBPQVRDMTRfSEREX1NU
QVRVU19PUEVOLA0KPj4gKyAgICAgT0FUQzE0X0hERF9TVEFUVVNfU0hPUlQsDQo+PiArICAgICBP
QVRDMTRfSEREX1NUQVRVU19OT1RfREVURUNUQUJMRSwNCj4gDQo+IFlvdSBmcmVxdWVudGx5IHNl
ZSB0aGUgZmlyc3QgZW51bSBoYXMgYW4gPSAwIGF0IHRoZSBlbmQuIEkgZG9uJ3Qga25vdw0KPiB3
aGF0IHRoZSBDIHN0YW5kYXJkIGFsbG93cyB0aGUgY29tcGlsZXIgdG8gZG8sIGluIHRlcm1zIG9m
IGFzc2lnbmluZw0KPiB2YWx1ZXMgdG8gdGhlc2UgZW51bXMsIGJ1dCBpdCB3b24ndCB3b3JrIGlm
IGl0IHVzZXMgNDIsIDQzLCA0NCwgNDUuDQo+IGV0Yy4NCj4gDQo+IE90aGVyd2lzZSwgdGhpcyBs
b29rcyBPLksuDQpPaywgSeKAmWxsIHVwZGF0ZSBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLiBJIG1p
c3Rha2VubHkgYWRkZWQgdGhlIHdyb25nIA0KY292ZXIgbGV0dGVyIHN1YmplY3QgbGluZSwgc28g
SeKAmXZlIGFscmVhZHkgc2VudCB2MiB0byBjb3JyZWN0IHRoYXQuIEnigJlsbCANCmluY2x1ZGUg
dGhpcyB1cGRhdGUgaW4gdjMuDQoNCkJlc3QgcmVnYXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPiAg
ICAgICAgICBBbmRyZXcNCg0K

