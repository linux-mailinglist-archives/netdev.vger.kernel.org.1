Return-Path: <netdev+bounces-186543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3644FA9F8F7
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 20:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7271A80711
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9C0293B6A;
	Mon, 28 Apr 2025 18:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="z1ectgYm"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022112.outbound.protection.outlook.com [40.107.200.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BF2288B1;
	Mon, 28 Apr 2025 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745866651; cv=fail; b=tJIUMyn+lQZboiM2BmlYBLz2fEMQhoLyWTf2Q2NhzLNeBVfc6MVyWBQAtYqffovgzMtT8R2UJ3X3B7DTAiHWm3WJEmsROJX6ppaTCQG7eJvbcZDafW/Vh7cDH89suE67MihcwKBtOxKnXSITbvVqgddHn04s8wMWbrjP8f3Ll0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745866651; c=relaxed/simple;
	bh=Oi2sTPYJnBJlgPMpUZG/6dRdtjWnLo4Xskf9vcTFx10=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K2a/ZS6+NUq6PGT0ZHPj/wNKpstNdnBLxFbAHYo0uqMAJfrbu7jNO1KqW61uQhCE2kIsk83Ok3MKvf0k6fjcnwB5HVxR3i8wB+WBP6V+5JreF4LLGff7myfTJpDDI8k07eoaAUNY6+77rB5yE6lnEEo/BZOIhGmbE8yixVXKx5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=z1ectgYm reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.200.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEL8NAHWyS/XviHf+HETUloJQAvR8UHqN9BVJncY6X5wuu3oc4rf4alRJxDTbiJHYczU0bLW84KpzCjdyjwppj3pXYQLm+95nYehZJYvkd8wE6bimh512/9Wu7Y86AtXPynplL3wJ+NECNWQcfVqCAxLD+6ThvOTl9uITmA6yQkAigmi/7hMJyPSks5TJOnNLd46X4VcT9ugjNJ4q20jtQa6LE8HssVpQSq6z/2vilbbc26nIUajkjZhON3U0yi8vNK8mQ3iw+drMaXzyJLAoKOXjuImjJSdosmwPNAU+wUQXfmbDcFWqt75Zw2OBodmexzTJBerokyZAWA4sfJAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiVqu4MwHSOvFpQ30jPaUEdlr+x8ynbcC7vc+nTlJ8k=;
 b=Gpu3mbMYZd4tyOD5qgcT+E/5PGLrVNPdHqCzTIGVHfo5daeLfLF7Pa0JZ2BhssdQ4xh7GnVQXjv+y+cBNcAdxw8jm4jPeF+LD5n9U1qfmthGRMwC7K04JC397Xnbphi65U1ZKZ3AEpju3Cs/PhHka/AHRscTO+EPDaHRiB+F/5k8N3n86XvcnN9EdoMw0iFguGCpDs2on/TtruLkIFLNsh3U/NyghCIr2U/QyhlPy2/zqcJDMGiI5MjelvX8zabuhi8SS08emwv2c5wUR0RHkg/oRUgkLWKpEvgbBDPbcwkHuXHkdW+5oMpI++7lnFukhmH0B6f6b3c/IB7gQJWAcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiVqu4MwHSOvFpQ30jPaUEdlr+x8ynbcC7vc+nTlJ8k=;
 b=z1ectgYmPNAAwNUOqNNNfOJ+QmU4HdF2cR5poSI8f6Bsip6ajQFzeNqOvzRrokGWai71uu/CWzfAEkGr9gl3PQwSqlwn5RuhFQgKRlexmqGkmaFCTVhTBlKAQgfBNgmFl3rvwc3IPbDH4YbC8nIDEHtLPMerkenVr3R+J/3/ueE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CO6PR01MB7434.prod.exchangelabs.com (2603:10b6:303:135::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33; Mon, 28 Apr 2025 18:57:25 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 18:57:25 +0000
Message-ID: <a12dee5c-2d59-4941-84b5-ae8bffcedd6c@amperemail.onmicrosoft.com>
Date: Mon, 28 Apr 2025 14:57:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 1/1] mctp pcc: Implement MCTP over PCC
 Transport
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 admiyo@os.amperecomputing.com
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, Huisong Li <lihuisong@huawei.com>
References: <20250423220142.635223-1-admiyo@os.amperecomputing.com>
 <20250423220142.635223-2-admiyo@os.amperecomputing.com>
 <20250424105752.00007396@huawei.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20250424105752.00007396@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::20) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CO6PR01MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: 24699136-ae81-4b43-a675-08dd868683de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGNzZ0ZiOFdGMWxPOUk0NDQvVk1ScXRhd1BObnl1RWh0MTVkT01iSFlkSW5k?=
 =?utf-8?B?a0Z4eHpUMFBYY21CVWgyUTVMNEgwdFVaZHErS201RG85eHRQOU1hN3cyd1Rz?=
 =?utf-8?B?aDBSaENkdHgyaWdGeVBVcUVFRmNIQW1ySGZrNTRqTGxkNWFESDBXRWFON1RV?=
 =?utf-8?B?M244elZnY1ZvMkd3NnZUY1RJeWpyamRDUCtZcDhzaDdkWEVycGE3V3ZKQU9h?=
 =?utf-8?B?QzVjNzRwbGxMdmlnMUFwdENwZEU0TjZHN2NnSC94cFdKT3BBSllhNkVxN2ht?=
 =?utf-8?B?S3RPVW9QeTNPdXU0TVFiTStVQlg0U0pMM0JTZC9OVEhpMS96TVBNZjl6RW5T?=
 =?utf-8?B?Yk1uaUNRN1FWTU5lMVM4UUpZM1Q0NnhOSStVZUZjV2NBTFkrYlhrc05iaTlP?=
 =?utf-8?B?M2x5R2VWNWVZRGJlRXBBQUpoUnJwTlBwbUxyeFphVHBNdFlhZEIxd292Z3Q3?=
 =?utf-8?B?MUE5eHhncU12ZjhJVURNc3hyLzVVWFFUQWdoOURTTnF4d09SdzdOdjViMlFo?=
 =?utf-8?B?azNGN0kzS3hoTFVGUlZlSEtabkliTGNuamM1NHQvdVFLb2R1R0sybjMwZUIz?=
 =?utf-8?B?bU5JczdnOW92WTYxWW5ZYk1zYmRtSVBBZXQvRElaY0JxKzdLVmtnV3Z0RVJ6?=
 =?utf-8?B?dUo4WWM1NitEQy9NVFpheCtBOHZ4SU5GVkxocXZ0QStTc0U4Y0tPT1NGMTR1?=
 =?utf-8?B?UzFtYUNsR09RbmhXVWZpdjhpbUkrSkFrY3FsMU82NTRaRmNQUG1Ec2pKRnYv?=
 =?utf-8?B?dVVOTEtqS21HcnkzWWpYNzVScklNQXQ4azlaTlFpRW53ckNnNE9ja2EyNHFi?=
 =?utf-8?B?RFNZRzk4K0RSVjJXREEwZzNocWtkaVZXTHJabnJKTTRHZjllZDFRVHJBbWsv?=
 =?utf-8?B?SUNtTmc1dnUranZ2NXAwYTZJcVN2NUthMEllbDdpaDVydnF2TVprSTF3cGlO?=
 =?utf-8?B?eHhrOVN4TThWZ1dwSVJWREN5RXp6S1BVazd4Q1duU2VjdHIrR2tEZnhueGVl?=
 =?utf-8?B?QjhNYVR1cTVGVmszTWN6M2d3aVh0bkVpTFprVk5vZHJiQisvOHRxNCtWNzlv?=
 =?utf-8?B?SWFma1VpOU9nc1hsbEllVEN2a1ZHZ2lGU29jREJVSmRrWTJwWnlrTitkVkQ1?=
 =?utf-8?B?a1h1TGFXWWlvOWRyYzB0UWsvbC9KSDJxTzBMSkRZbTBxWU1SUzRYdmxidUkv?=
 =?utf-8?B?WEZteTFvVCt3cC94cnpyMWg4MDl0K2hvZmFzLzl0dG8wait0cmZsNmdaU0RJ?=
 =?utf-8?B?RHUrREVKZU9wYlRiUWRiZFZpTCthZkZSMDdLWjRtR1NDYit1cXFlMTlrOHhx?=
 =?utf-8?B?RmFucTJaaXRwR2QyVklXRFNqbE5yN24zTlFkS29UTzg2VHRiR2NPdlV3UWpj?=
 =?utf-8?B?Qk5XUFJJSG9BOXJOcTRBbTg1dUhRYjhGdkgvNndiZWpFT0lQaG81YzBNN3B2?=
 =?utf-8?B?RmkyUU0rOWw1N1Q1M1J2bXJQVklLTFo1dHFCaE9qOGlKYzVJcXJRZUtrZHBN?=
 =?utf-8?B?MXhRRXdGcG5pZ2pLSDIvSWhGN1JsZ2E4US95QVNyRERWYkR1QmFGcjlDd3N0?=
 =?utf-8?B?VmQzY2VacUpGRmFaRU5mMVVYaTZoVFNuVnN1M3liK1VKNSs4eW43aWZTNUxo?=
 =?utf-8?B?RkJsSVlrR3lCVkg2ck5iTVpabDJQUU9JbGZzeVNSVFV2YUJPVDBkVDR0QUJ6?=
 =?utf-8?B?VTdYSkduamdYUTVpVFdFdnlRZGpudTR4UzI5Q0J0eUxsQkJyT1AxaVdaZlJQ?=
 =?utf-8?B?RE5NMm82d1RWK0N4cGlEV2pVcmtEVk9jSHJOS3NZMGIrdlVJM2ppVVg5bnJm?=
 =?utf-8?B?REN2RVpubjVwVGYyYVB3cEZHRVNVUEJybUYvOWwrQndKMzBNdFFtRHBscWdn?=
 =?utf-8?B?UUVBTXpXUk1SdnVWaEZWejlsU0VOVWFZTys5Qi9PRURwUXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mm9hbC82Qzl6NFlObUxPd2oreE03am1jQ2VldUxlKzlzTkJoWEhiUE44MXpG?=
 =?utf-8?B?YkFNbVNRVGFJUFFxRDF3Qmladm1CUTh6TmQ2dFZrcityc2lTRy9Gc2tTY1gx?=
 =?utf-8?B?LzJ4RUE4L2ZoNGRQRnRzOGozVnVKbEdya1VzTHN2UDl0QnR1aCsxQ2N2ZlYr?=
 =?utf-8?B?SEJ1V3V2YXFZZGlaMVM0Nkx0RU5hd1dOdDZpN0ozNGdvRXVDRWg1OGhZempa?=
 =?utf-8?B?VzJRQUtraFdVUDQrNWdybTk0NkpSNGFuYWlqWjhKRjlLT29wVTVpYU9Ub2hp?=
 =?utf-8?B?OUFKZnlreGNYMmdRVTJJT29CZ1FjWTJPQkFkR0pIZVdaN1lEVjZ0R3J2SkZZ?=
 =?utf-8?B?Z1dFSEJJWWVJU3pnSzB5UlVrblh6ZkkxcVA1SHo3amV6eHpFQ2tyZGhERzYy?=
 =?utf-8?B?VE56QkRsZVNKNGFCbk4waU5lMkIyZ0hRaDl4Q0ppRWhVT0JqVDFNaTZUTldt?=
 =?utf-8?B?WjBka1pDV0JBY2EzQVMyTUd5ek9rWkdpZHEraTF4SDlWYTdMK1pBQitic0gy?=
 =?utf-8?B?eWNOSTBQY1A1MEFDWGtjbFpJUG5INDhBTm1QUDBOWkxkQkNnTHBQa25KRnNq?=
 =?utf-8?B?eGJpVmFGckdlK3VmVFgzNjl2anpoTkdyQUJObDdLQndNbXFVM1NBYlRjeUUz?=
 =?utf-8?B?Vmx1T04vVkxiTTNkZTFVLysvdm1SSGkvbmFZWTFRZzlBN3JJK0VoY2Yvd0Zt?=
 =?utf-8?B?N3F0YjdlNFVlL2hqTlVadXBuSzdvdWpMRGU2cDhTZlZEVnYraWZIRkw1QXNO?=
 =?utf-8?B?ZStFVE85L2VHNWp1VndjS055dTBDQVc5SzBQODlZQkZ4MytGcWtmanZwNFIv?=
 =?utf-8?B?RGRZTTBJcm44TkhUUCtuZGRudEJIdHNQOWxHUmQ0RWtDMnRZc1RZQXBYTElR?=
 =?utf-8?B?UFBaQXdwb3NGZ2lubERvTVNFZkRjcTdUVTZITkV1TUcrTm84QTVXek4rbitS?=
 =?utf-8?B?dVBaS2o5Ri92RHJTdnNraHIzZ1hhSnhhaFdvTGZlUXc3VktQc3FxdisrMEFE?=
 =?utf-8?B?NWhkUzJxdkYyeXRJd1FLNGxXWTYreFR3ZHZ6ektOV1ZlTlphck9saUVsZndq?=
 =?utf-8?B?em4wZXorTFpaUTh6bnJiakRpOEx5NTVUOUtTZFI0MDEwSEhNTXR4QmNPMGxN?=
 =?utf-8?B?ZmhkQWJzMzRkMEROVEJTL0I0TDBBNmtBREM2Yy9vQVZSVFFCR1Q1QmRMTEhq?=
 =?utf-8?B?STB4VXZNZkdyYUhtN1cvN21iQ1pMdEVLVFhNUUN5ME1lNnBucHBOa0tjNzFv?=
 =?utf-8?B?R2l5aVJRMk9KbTJ0SkZIZy9UMEdRN1ZoVFVXTE82OXdqaEFKdmQrdisxbDZC?=
 =?utf-8?B?RlJFK2dlNjVjMThaUUVqdFI3MkFydnYrWUEzeXZWYStjM29JRUhvbGNKS0tz?=
 =?utf-8?B?M1BScWdGR3l5b3NqSzFrd21FVlRnbkt4UjR0ejNTSWxYeE1zYTJWOFFNbjI4?=
 =?utf-8?B?MjBUZDd5UEw0NGIrelQrSkl3VXdyRE9DNWFJbFYxd2xXWEF3N3Z2QzROTEww?=
 =?utf-8?B?OGEreTI1Y0pwbGhMLzZVellBa2o5d3BIVHAwNjhHenNEbXp1REpkWXRpK2NE?=
 =?utf-8?B?cktpWUxhZTg4UWxuV1Byd0xvZTRvSXgvSUErYjY1TktCL1Q0NG1TL25vVVhz?=
 =?utf-8?B?amlnOTN3eVpzMWFQOXdsUXM4ckdZck13OWhEMG1oREEvOElWWlZxN2VkMmYz?=
 =?utf-8?B?dEtSR2J1bmMrd0VhS3lqcGZhbHBUMVRsY3NOUnE5QXd5Z0VMZ3h2T3ZjWWI4?=
 =?utf-8?B?UXBKOXZsb3FBZEd1U3M5Qk15TVZ0OWtSb3FhSlBkZVN2b3FsWHNET1V1bWlZ?=
 =?utf-8?B?c1VLTzNQdDRCeW42UXliMjA2YnVmdVJpbldJUUtIOUxxY2FXL1NFQkVtQi9v?=
 =?utf-8?B?TU01V3cwdGQreFhJTWU4S1JsSC9vN2duaGt1azI1NElwdS9Wa3h5T1hvbU56?=
 =?utf-8?B?R3V2MVRhZTNLRnlraWxwYllId2x0bml6dGdJSVNBNjBwSENUVGtKeVpsSnU5?=
 =?utf-8?B?R1dlV2g0ak9QU0UzV2xXajlaK2Q1Qmd0TFFlSVZGMnNxUit2dHJUeXBaZHFJ?=
 =?utf-8?B?ZUN3S3pLQW1mcDZ6amoxNDVVNW5rSHh0cDFhYzIxNFlEcjgxd1A5V084RDZQ?=
 =?utf-8?B?ZUphUXpDSzlDK001WStOcHdqcE5tS0xYVlRJWi9jZ0hLQTRZR0cvOWdZVVFw?=
 =?utf-8?B?QlJZU2VYVEkvbmMrTjZuQXhmRWdVSHdjYzE1RjBrK3VSNE5KSW1mYVF1QVFj?=
 =?utf-8?Q?mrlqK3Y2eJ1jqH4khEXKU55d60tBoGNsep4tyPcmN0=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24699136-ae81-4b43-a675-08dd868683de
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 18:57:25.4137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOC75kRuVBdBmlf52ki03Ev0qrBkxBtyBFH/gJ5csPQQZY5sIpFqZQ947XMvN5Xsr7YsPhNTRclrQP97u7obsik3SccmlSDm8LZMS2r9qc/7X+kwxBJx2C/tHkzxyNJp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR01MB7434


On 4/24/25 05:57, Jonathan Cameron wrote:
>> +
>> +	mctp_pcc_header = skb_push(skb, sizeof(struct mctp_pcc_hdr));
> I'd use sizeof(*mctp_pcc_header) for these to avoid the reader needing to check
> types. There are a bunch of these you could do the same with to slightly
> improve readability.


I get a compilation error when I try that:

drivers/net/mctp/mctp-pcc.c: In function ‘mctp_pcc_client_rx_callback’:
drivers/net/mctp/mctp-pcc.c:80:30: error: invalid type argument of unary 
‘*’ (have ‘struct mctp_pcc_hdr’)
    80 |                       sizeof(*mctp_pcc_hdr));


Maybe a compiler flag difference?


