Return-Path: <netdev+bounces-218400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98210B3C4BD
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 00:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CFC2189963D
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 22:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3EA2BD5A1;
	Fri, 29 Aug 2025 22:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="ikoN7c4/"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463D01D61BB
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 22:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756505964; cv=fail; b=l6TYYjd3765ehY4ggXI8Y9W77A3NYmbr0Pmasj/Yhxck7PkrEKy5daBvMiX3Zq/HfTyMuZ0okbavKwnsfacp3Nqxu1qHIMBGeUmzvWh1/qKH0g4CbH0knSdeGPfNa/PyvGcb1a1AS9GKmbA5nY6TsNalpuwq2i4XWT7S1NKN3i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756505964; c=relaxed/simple;
	bh=gRtPyC3iw2YJYhanCt8MgwCtv84T2fxECKMnfYC/ziM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lwgvqa6DUWJbG8KxgZBdKZsDB9IIS69u8oCPcxasKEKAvvJyS41mG/qO82BMN1FNopL/Xy3rMGAdaArtSymJSVBf76wQrxUMNCXLzAS+NrPjzjJFWwipVIIV5rSHu3LsuFk5ABGVP2ikc4pO+3kTICRmT649wixknEcSNagQcTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=ikoN7c4/; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1756505962; x=1788041962;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gRtPyC3iw2YJYhanCt8MgwCtv84T2fxECKMnfYC/ziM=;
  b=ikoN7c4/CyV87R33YNn9PDcqP947Ko1VUbbz+vS60bjmgTs4HCZAhquQ
   pTfddXaweqyI9b4SxxGgzVcFk3GK6lRPJDI+dRpQp1XydQDeXGOJfeBip
   8ncDuIXccpce64IXJgKKa3Ey6rUwUxPIuN/fWvl/LgG5iSEEQU3jihxPX
   I=;
X-CSE-ConnectionGUID: p2krvg7fSdKmQun9gDHJGw==
X-CSE-MsgGUID: Ysd89lujQCKQqy3yTghV4A==
X-Talos-CUID: =?us-ascii?q?9a23=3AqeY5Rmum0OYNKsJxOHioVRqp6Is9KH7H0niPLXS?=
 =?us-ascii?q?0KmNQVbvERnOw2ox7xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Ah3fc3A21fwALtUtHDS/jXP1xZDUj0r+iWBEJjJc?=
 =?us-ascii?q?/kOq9LD0rKguSjArra9py?=
Received: from mail-yqbcan01on2090.outbound.protection.outlook.com (HELO CAN01-YQB-obe.outbound.protection.outlook.com) ([40.107.116.90])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 18:19:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJ27Hf/Wn6yQ7rEhHcIwSEl6BXHyE6J5TaBuPjN1sHD5hHAhSan9SG0Vz1w0pp+XqVGPc31yd3h1wLUe7cUdS5oC0YhjmwTr0Y0dCU6JGYXZpvs6c5F18q2mTFDASozZ7Efnqs0yiorhW1YrdXJGx8Nnst5/eFjtFoWAXE8yp5piANeil7tKU1zsgHjMX/bMj6NepOfLhgizUQqK6B0/++AFtnY78/sPXij9elIhOyGGBiTvg/w94RgZMhZG4BC431ueIGK11CsIFT6Jo6GwUzkqeXr1BazoZhuJgAU+AY8WF52ZGSTar0sRYF8dsaFhyLd4j0wSGDPvK7lgoWDBcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zd/Rr+NjLonptdMUY+4dlQHf8JuyGhv49hqEQfP0TMI=;
 b=QDQ3ihciPCBdqrTVNYI64Y5IkyN46q4HG/B2pEeQrs6zfbjsC03jHJFOBT8WUnVpe3gR1cKgePj6dRM7e1dDOU7UVvUbHY+NQgnITLipkpIC4JCMbWZPJOBwCiF0XT0O/eiQtE24gZkCDimdew0E5eQwN8Q2Kby6/dXbcGzZai4K6HnpIdqOcMdsxo5mpkLw5YztetUqH2VGDdeafBjEpK5FxokHtxcT/i8MzCk70f0ZTeciQYsFRqnRISZ9yVT2G6fKGgQvDa6dlswTv8TwE0LuGtgWDggOAYBSYSe4Oebk9SkfpHPpW6v/Q7dgZQU8fRNMp8eidpb5dGZLLGs/EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT3PR01MB8241.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:9a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 22:19:16 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%2]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 22:19:16 +0000
Message-ID: <63ff1034-4fd0-46ee-ae6e-1ca2efc18b1c@uwaterloo.ca>
Date: Fri, 29 Aug 2025 18:19:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 0/2] Add support to do threaded napi busy poll
From: Martin Karsten <mkarsten@uwaterloo.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com,
 Joe Damato <joe@dama.to>, netdev@vger.kernel.org
References: <20250829011607.396650-1-skhawaja@google.com>
 <9cc83ec9-2c71-4269-86ec-8a7063af354f@uwaterloo.ca>
 <CAAywjhTx7v8fNiimqU7OiBv-8F23k2efXMTsRbXCi0iF3SDQKQ@mail.gmail.com>
 <d2d02181-9299-4554-b641-1a74386b211b@uwaterloo.ca>
Content-Language: en-CA, de-DE
In-Reply-To: <d2d02181-9299-4554-b641-1a74386b211b@uwaterloo.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::25) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT3PR01MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 8997ea3c-03ab-40ca-4f4b-08dde74a1722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEpzQnFMSmdpUDlvamVlWUFucVZIU2xabDZ2eVpHYlFjMjkyV2xONUpyancr?=
 =?utf-8?B?Z1FIc0pBNEk5TXpReEQydkNWRW9GYlpSMjFDQ2FhRjhBTnI1eHU2NGdwbmVO?=
 =?utf-8?B?K2ozOEhYbEdoQWx6UDFxY2xIaEo0Y0NlM2pPbFp6MEZDd3B5VGMrbWV2NVNU?=
 =?utf-8?B?ODV2SERTYXorU3ZPSnVzYXppcDRzZHRRa0xLRjEzQ3hZQXdUcTZtMEhzY1Bm?=
 =?utf-8?B?eDc4QU9ab1dnSFJNWDYyUXlVQXZDRnRGeTZydjhwVDlwcGxpVzRGZlFYRUJu?=
 =?utf-8?B?YmQvL3l4MmI3Y3RiRngwa3FYL1lBYldCUUpVN2VVSFN1UGFLa2xweFFIRGU5?=
 =?utf-8?B?Ym5odmlFODhhMmNvaXVnMWRqL29JUXpzNUpFbGVqT3M4V3dFdU4yeXEvOGdz?=
 =?utf-8?B?ZnZrVVlEdjR0R2Q4YmhDTHlRMnp5MXJlWVdOTUJRMVBnNG92MXFQVUN5bzBX?=
 =?utf-8?B?bmJvSGdDalB2TU16Zk9hMjkraFpSditKUEZDM2QyMFFwZmZPMWZLaGRlNGoz?=
 =?utf-8?B?RG5FWHNlcnBnRFNwaWVSYXl4MGw4YldYZzhPUEJJb1dxbTk5TGNXc0QvTzlo?=
 =?utf-8?B?T2kwVVg4VzJyMElkVVdObERPWGREOUFhSXZlWkdMZUxCc0ExU1FOV3o1SVhw?=
 =?utf-8?B?M3pLMVI1MGFvVVlqR0krbnlMeSswMEtIZGg3OWpEcXFQcUQ0YnNYbzJXMVhG?=
 =?utf-8?B?ZllqZlJJbG5Ta0xLcVdEVStJRjlqUk81L2tkbGtheUppUFE0azFFbUt0V1d3?=
 =?utf-8?B?WnQvVXdwSDJ2dGFrMjJqY3pYS21hNktnZDY5ZFUrMFU4SHF1amxyM2NUZ0RT?=
 =?utf-8?B?RjlETGVFU1cxQTJCUVJLUGlORnhQOCtVMEVNZFlnamNTQXE0cTg5MzhFQjRh?=
 =?utf-8?B?VjdBMkwzMitLWXkxZ2V5SW1wUnhEWVBKYzJuL3gveDhBdXcxZ0xvYVNNZ0xI?=
 =?utf-8?B?bHBmQ29pT3VSRjhmK2VNbm1DU0VkSnN2bnlvRXRjWktTVFRWempGczM2Um83?=
 =?utf-8?B?bHlOTzJzcXBXTXdyQnBJMDBYWGI4SVhHd1RudVJIQTluVU85Q1VRVHhTWUZO?=
 =?utf-8?B?ZmVpNHhjdHNXRE1uVGZycFMxT010WnNSNnlGbzFzTHNXd2VqSG9KM2FOMGNR?=
 =?utf-8?B?MG1DZVhHSU0xT1Z3dUhFclcwY3BhcnV4cjR5SkJ0eHJ5YkdmR0toWFM0SVEw?=
 =?utf-8?B?aERhcWp3UkZVaHRGeHZDR0xidkVtdU9BUnBkUEJqR1JTaXNmRldTdVR3bkdC?=
 =?utf-8?B?cjl1R2Q3ekN0d255S0pnbVlxVXJhNmpPTUxmRnlPeldZd0hnU0lPcE5OQWVQ?=
 =?utf-8?B?L1gxZ3hHRHd0STQxNmJDR3JteWdHMmtSNmdiMDlrY25maVVhbHQwUnJRUDN3?=
 =?utf-8?B?ck1hREdTeElsV29iWnZlcTBtSHVQblUydDNRUjRQdjhrWmVTbXZKTE9vWVpB?=
 =?utf-8?B?aUtUdDlGQW1XL1RJMTEvTUtlWXYwQ280V0pYKzludWNIMFFVNDJDUDB3bkJt?=
 =?utf-8?B?VEJqNnorZ1dHNnBtdWdZK1FTbG45MVQxWTJDN3ZkK2lJZHVhb1NYekFwUGpw?=
 =?utf-8?B?YlRrRVJJUlNOdGw4c1h1NjZYcVptMnpBZVpiMTFWSGFEUC9tMUxGTkdvb3NN?=
 =?utf-8?B?ZGE5QmZRTitndDkxcERtdHhLZjhQMlQzNjJHcmQwNmlGeUZ2L3JtMXpmL2pE?=
 =?utf-8?B?eDZOWFhjZkFQSFBuSWN0SlBuM3A5QmFlZFNMbVVvRjNCSlVCdVFpZElkdzVR?=
 =?utf-8?B?LzZnNUM1b3ZVc1Z1NkRnZ3Nab3pXd1p3akwzb3BneXdLVTdsL2tWczVnOU1w?=
 =?utf-8?B?Y2VJbmlhcmc1bmRRSDcvczNWZ2tpdVFyWFMrK0dMR1YzUmlGZmNOOUdNY0NR?=
 =?utf-8?B?ZTFrVk5aaEQrKzB4enMvVkRJNlJvTXJwSzZ4SzdJL0kzR0dRWjltbmNFNWZN?=
 =?utf-8?Q?yR9/amMboys=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q091T0s3eEZMRnFZSDJkdVh5L2RPQ2VVUzFWelpOaG1DNXUvS0VxMnlqQU5j?=
 =?utf-8?B?ZFd2WlUrWXBLTnJERkQ3K1JoemlPSjJHY2FFS0k4aHJSejAvTjM2K1RvQjIy?=
 =?utf-8?B?bXAvT2lzNzg1aWtwaW45enpRQzFEejZ4MkZyWGZqOWZkN09oL3Yrc0JBV2Jo?=
 =?utf-8?B?b044eFc0RWNpYjNFQlA4NGJuVzVkQkpWZ3UwZXdyMDZ6QmR0WWpIY2FncFk3?=
 =?utf-8?B?U1FDNzl5dW1GTTB1QnJTS3Z0b1VBMG9hZ3pFZE5oemJXQTR2b2NnczlmbnhZ?=
 =?utf-8?B?ZG5hYlZFMFNSZ2JRY0p0VTBGRFZiMkZzaHpIWHNVb0tidGkwd2ZxdVlFVkJR?=
 =?utf-8?B?YWxJS2hwVDlhQmxURERDbzNHY3dlbFhFMS9jaHVNdmROTmJzbFIyOC9mRDFW?=
 =?utf-8?B?alMwRWNyZmhsK1oxV3pjMytFbnBCaXFKdXJTT1BiRDlCT1JGN1RCYUwzZGRp?=
 =?utf-8?B?bDBCRXl1Q1M1NEpLbzJFSHQ4TjEzK1RIUy93b0c2SlBiTlU4U0RJWFZZUW8x?=
 =?utf-8?B?WURzclNsQXNobVhvM1puVmZDaGZVRm01YW9wMmRFYk9FNytqOFZ1M2cxclBo?=
 =?utf-8?B?QnEzM3duOUVXSXIraE5sK2JFcmI5MWdvRC9XYXV4ZmxJS0pVV1VrS2puUWJi?=
 =?utf-8?B?clZ4MXE3YmtVL3ZXQm55ZzlyMlRlaGdLVklhUnR1dUNJYkFHaDdHK3FOaVA5?=
 =?utf-8?B?bHVnekV3TnFzbjJ1UUFYYXV2UWFsWVRnQkNXZHVLbFZRcmFFUzJDcWNLS3Ja?=
 =?utf-8?B?enU2VWNvaTZYWFBZN3dObVJiZGlhcHVBY3FXcGJ3RDNSZTZ3V1BnVlYvejFa?=
 =?utf-8?B?NWtqYVpXQWJwUU5mM0VqNU1BZWxyZzNIRUJpUG5oVGRvMGFyU1Y5UlNIM0ZL?=
 =?utf-8?B?RlIxQkNIRnFGcElwczYrYzhtcVQ5Y3IxVGJRSDVtRk9LUXpsNHg5RDBuclVF?=
 =?utf-8?B?N2NlZWhNT2RXeTZmck55Um9naWVrSEFGcEtHQ29LcEtQV0Y4YkN1b3Y3aUo3?=
 =?utf-8?B?U3pwRXMyY1JPZXF0YUxPMHNPclQ0UERwVVl2SW82YnplNzl4czcvQm1FVWMr?=
 =?utf-8?B?ZzJ4YmxyVWlRVys4NkxVVFZndDBwMFY5dnFVZ3hIMktPcUVuM0Zka05Yd3lJ?=
 =?utf-8?B?d1J3RXRnbTYyclcwYTVBRGpzdHJ1dURnWDBQdmpUTjd5YStpWGFCZGtEaXFJ?=
 =?utf-8?B?Zm9IMlUvTDYwdjlpUGRkaCsxcHNwYVMyQXpXeEpxRmRNU0lLQ0F1Sys2SkJs?=
 =?utf-8?B?clVPTGFiYUpvMUN4YTArYVgrai9XZkt5SXM4SEh1bnRnODF4SHNYUVN6ZitF?=
 =?utf-8?B?Uk4zcUVodDYvT0RYY2pSdTV3KzA3M3l1eTk4clRTclk1dmZxRDgycHBDeVFJ?=
 =?utf-8?B?b2N4VkxMMjlzSEZjdUJNMHdZK1JYVjhjbjZuZEdZeGJZYVJIeFUyWHo5SSt6?=
 =?utf-8?B?SHhleUZLRXJHWEUydVViOFZlUUpPdXV0R1NmZThpNmUvSWloaythTyt2Smg0?=
 =?utf-8?B?ZUFlUFRrejQwVDBFSFhkVTNnKzBXZDUzaWdMeXhpME9PeHQzUzBoejZMbjdW?=
 =?utf-8?B?NGhDTy9ZVUkvRzh2WGx2ZllsMGRRRTV5dFM2NVI5Y3hGVEpIaEl5aWEwVUQr?=
 =?utf-8?B?RVRoS1g5aXlQQzBnbHplNVl1NXUxRTBXdzdIeC9tN3JzSGs5UmkvelpDY3RE?=
 =?utf-8?B?NmQwOFcwWHV3WVRrS28yNlFkZzZiYlQyZ2dVRjk5WWNKLzM1dkpseEpZb3FK?=
 =?utf-8?B?TFNHaml5WUE5SGtMblQ4MG9zUjhaYnJka1RwQ1BKeFNRVnpDTkNNajZUWS9R?=
 =?utf-8?B?T3VzczE2YkhNSmJBbVZNN0d6eCsvUW5TWkpIc1JocUw1WWpDNXdMSFFJTDRQ?=
 =?utf-8?B?aGwvMU9Pb0NmS3hEeHFNWEJVY3ZFM20xekpWYTZ6dnFGNW9NbWw2WFZia2NB?=
 =?utf-8?B?NkpIT2VpOThXbGVVUG1jd29ZWDRDT1BWSSt4SEhTUk44c0hsQUZwdFlpNjlv?=
 =?utf-8?B?NjQwbGEraTRQdTVOV0cyQVBCVHFHV0tGQng5NVlLVWI2Z1ROT1pMdUZ1aDBS?=
 =?utf-8?B?SDQ3eE52RWJSbkdrSVk4ODhDWjIxUVpHRTkvR3hVOHZ3Zis2djRBbFlCNEZ1?=
 =?utf-8?Q?2KmPXaIMQSRszG8omWcdl2SA/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VTPpMWf/W5ZUPo4IDxpsUoq6LfsQEurkAqMf3RVZ2aZrkr+y2I2SDIh7hX5+LVF4HGgRVmuk+y479Tkj3JqWU9ldRBNBvXqXeXfIaLcfepbJALmYTnDqjd9RfS3JQwF7ZGts+WxYuxL96rQvGC/JcAWvXK0sm/24yvTekgqTi9d63u0WiENSl/0fYBAzYK+dQ4rWVwAgE5kC6iHIdyiUdFGWZ5GX+eHcA0XfOP45vJRrA+c1FTwnPEoTF1szfe2FoXPKz2wHRa5wqfC/gsmhlqUo+lCNkhMbo9kSkWs9BJt+BmeKRWs2E0eVBNoefLSazIP9opdcYBMc1t/+UOeOKUHRlYUAh4f6SBM2OmXzHMgj+H9l4rohda87GX6/B/ohPbOSMAihPy0gJft9U7WQDZwIPCyrVs1xtsWSN0yHRfz1hsAknOo1meRQwW42386YQwLQM6DhxG6Bvcg+ptJ6XkawI0Ye+hiQ59Aj7UNpFNgbvcjRYbiBQ2uhdLu4IlYM0YDxX5MEKlok1jODAxacfBQZ/8QMKeZ/MlRmqqLJlp4pXjYcGoB9NY+FVXk/1WeWV7rdhYwfdh0oxcjDTkXlyvkvWFntFPwrdTlA5RjlpU2lsgi0MS6xwaYRWtlVT5uO
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 8997ea3c-03ab-40ca-4f4b-08dde74a1722
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 22:19:15.9984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCrDFuZOkR6plS0vztArhT1kVstB8bOJMhz6mjGFmbrX07S9Hn6Lq6wycx+j3hsps6w568UwC6q0nPoIvFBLew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8241

On 2025-08-29 14:08, Martin Karsten wrote:
> On 2025-08-29 13:50, Samiullah Khawaja wrote:
>> On Thu, Aug 28, 2025 at 8:15 PM Martin Karsten <mkarsten@uwaterloo.ca> 
>> wrote:
>>>
>>> On 2025-08-28 21:16, Samiullah Khawaja wrote:
>>>> Extend the already existing support of threaded napi poll to do 
>>>> continuous
>>>> busy polling.
>>>>
>>>> This is used for doing continuous polling of napi to fetch descriptors
>>>> from backing RX/TX queues for low latency applications. Allow enabling
>>>> of threaded busypoll using netlink so this can be enabled on a set of
>>>> dedicated napis for low latency applications.
>>>>
>>>> Once enabled user can fetch the PID of the kthread doing NAPI polling
>>>> and set affinity, priority and scheduler for it depending on the
>>>> low-latency requirements.
>>>>
>>>> Extend the netlink interface to allow enabling/disabling threaded
>>>> busypolling at individual napi level.
>>>>
>>>> We use this for our AF_XDP based hard low-latency usecase with usecs
>>>> level latency requirement. For our usecase we want low jitter and 
>>>> stable
>>>> latency at P99.
>>>>
>>>> Following is an analysis and comparison of available (and compatible)
>>>> busy poll interfaces for a low latency usecase with stable P99. This 
>>>> can
>>>> be suitable for applications that want very low latency at the expense
>>>> of cpu usage and efficiency.
>>>>
>>>> Already existing APIs (SO_BUSYPOLL and epoll) allow busy polling a NAPI
>>>> backing a socket, but the missing piece is a mechanism to busy poll a
>>>> NAPI instance in a dedicated thread while ignoring available events or
>>>> packets, regardless of the userspace API. Most existing mechanisms are
>>>> designed to work in a pattern where you poll until new packets or 
>>>> events
>>>> are received, after which userspace is expected to handle them.
>>>>
>>>> As a result, one has to hack together a solution using a mechanism
>>>> intended to receive packets or events, not to simply NAPI poll. NAPI
>>>> threaded busy polling, on the other hand, provides this capability
>>>> natively, independent of any userspace API. This makes it really 
>>>> easy to
>>>> setup and manage.
>>>>
>>>> For analysis we use an AF_XDP based benchmarking tool `xsk_rr`. The
>>>> description of the tool and how it tries to simulate the real workload
>>>> is following,
>>>>
>>>> - It sends UDP packets between 2 machines.
>>>> - The client machine sends packets at a fixed frequency. To maintain 
>>>> the
>>>>     frequency of the packet being sent, we use open-loop sampling. 
>>>> That is
>>>>     the packets are sent in a separate thread.
>>>> - The server replies to the packet inline by reading the pkt from the
>>>>     recv ring and replies using the tx ring.
>>>> - To simulate the application processing time, we use a configurable
>>>>     delay in usecs on the client side after a reply is received from 
>>>> the
>>>>     server.
>>>>
>>>> The xsk_rr tool is posted separately as an RFC for tools/testing/ 
>>>> selftest.
>>>>
>>>> We use this tool with following napi polling configurations,
>>>>
>>>> - Interrupts only
>>>> - SO_BUSYPOLL (inline in the same thread where the client receives the
>>>>     packet).
>>>> - SO_BUSYPOLL (separate thread and separate core)
>>>> - Threaded NAPI busypoll
>>>>
>>>> System is configured using following script in all 4 cases,
>>>>
>>>> ```
>>>> echo 0 | sudo tee /sys/class/net/eth0/threaded
>>>> echo 0 | sudo tee /proc/sys/kernel/timer_migration
>>>> echo off | sudo tee  /sys/devices/system/cpu/smt/control
>>>>
>>>> sudo ethtool -L eth0 rx 1 tx 1
>>>> sudo ethtool -G eth0 rx 1024
>>>>
>>>> echo 0 | sudo tee /proc/sys/net/core/rps_sock_flow_entries
>>>> echo 0 | sudo tee /sys/class/net/eth0/queues/rx-0/rps_cpus
>>>>
>>>>    # pin IRQs on CPU 2
>>>> IRQS="$(gawk '/eth0-(TxRx-)?1/ {match($1, /([0-9]+)/, arr); \
>>>>                                print arr[0]}' < /proc/interrupts)"
>>>> for irq in "${IRQS}"; \
>>>>        do echo 2 | sudo tee /proc/irq/$irq/smp_affinity_list; done
>>>>
>>>> echo -1 | sudo tee /proc/sys/kernel/sched_rt_runtime_us
>>>>
>>>> for i in /sys/devices/virtual/workqueue/*/cpumask; \
>>>>                        do echo $i; echo 1,2,3,4,5,6 > $i; done
>>>>
>>>> if [[ -z "$1" ]]; then
>>>>     echo 400 | sudo tee /proc/sys/net/core/busy_read
>>>>     echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>>>>     echo 15000   | sudo tee /sys/class/net/eth0/gro_flush_timeout
>>>> fi
>>>>
>>>> sudo ethtool -C eth0 adaptive-rx off adaptive-tx off rx-usecs 0 tx- 
>>>> usecs 0
>>>>
>>>> if [[ "$1" == "enable_threaded" ]]; then
>>>>     echo 0 | sudo tee /proc/sys/net/core/busy_poll
>>>>     echo 0 | sudo tee /proc/sys/net/core/busy_read
>>>>     echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>>>>     echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
>>>>     echo 2 | sudo tee /sys/class/net/eth0/threaded
>>>>     NAPI_T=$(ps -ef | grep napi | grep -v grep | awk '{ print $2 }')
>>>>     sudo chrt -f  -p 50 $NAPI_T
>>>>
>>>>     # pin threaded poll thread to CPU 2
>>>>     sudo taskset -pc 2 $NAPI_T
>>>> fi
>>>>
>>>> if [[ "$1" == "enable_interrupt" ]]; then
>>>>     echo 0 | sudo tee /proc/sys/net/core/busy_read
>>>>     echo 0 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>>>>     echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
>>>> fi
>>>> ```
>>>
>>> The experiment script above does not work, because the sysfs parameter
>>> does not exist anymore in this version.
>>>
>>>> To enable various configurations, script can be run as following,
>>>>
>>>> - Interrupt Only
>>>>     ```
>>>>     <script> enable_interrupt
>>>>     ```
>>>>
>>>> - SO_BUSYPOLL (no arguments to script)
>>>>     ```
>>>>     <script>
>>>>     ```
>>>>
>>>> - NAPI threaded busypoll
>>>>     ```
>>>>     <script> enable_threaded
>>>>     ```
>>>>
>>>> If using idpf, the script needs to be run again after launching the
>>>> workload just to make sure that the configurations are not reverted. As
>>>> idpf reverts some configurations on software reset when AF_XDP program
>>>> is attached.
>>>>
>>>> Once configured, the workload is run with various configurations using
>>>> following commands. Set period (1/frequency) and delay in usecs to
>>>> produce results for packet frequency and application processing delay.
>>>>
>>>>    ## Interrupt Only and SO_BUSYPOLL (inline)
>>>>
>>>> - Server
>>>> ```
>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>        -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 - 
>>>> h -v
>>>> ```
>>>>
>>>> - Client
>>>> ```
>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>        -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
>>>>        -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v
>>>> ```
>>>>
>>>>    ## SO_BUSYPOLL(done in separate core using recvfrom)
>>>>
>>>> Argument -t spawns a seprate thread and continuously calls recvfrom.
>>>>
>>>> - Server
>>>> ```
>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>        -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
>>>>        -h -v -t
>>>> ```
>>>>
>>>> - Client
>>>> ```
>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>        -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
>>>>        -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -t
>>>> ```
>>>>
>>>>    ## NAPI Threaded Busy Poll
>>>>
>>>> Argument -n skips the recvfrom call as there is no recv kick needed.
>>>>
>>>> - Server
>>>> ```
>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>        -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
>>>>        -h -v -n
>>>> ```
>>>>
>>>> - Client
>>>> ```
>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>        -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
>>>>        -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -n
>>>> ```
>>>
>>> I believe there's a bug when disabling busy-polled napi threading after
>>> an experiment. My system hangs and needs a hard reset.
>>>
>>>> | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) | 
>>>> NAPI threaded |
>>>> |---|---|---|---|---|
>>>> | 12 Kpkt/s + 0us delay | | | | |
>>>> |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
>>>> |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
>>>> |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
>>>> |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
>>>> | 32 Kpkt/s + 30us delay | | | | |
>>>> |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
>>>> |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
>>>> |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
>>>> |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
>>>> | 125 Kpkt/s + 6us delay | | | | |
>>>> |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
>>>> |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
>>>> |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
>>>> |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
>>>> | 12 Kpkt/s + 78us delay | | | | |
>>>> |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
>>>> |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
>>>> |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
>>>> |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
>>>> | 25 Kpkt/s + 38us delay | | | | |
>>>> |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
>>>> |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
>>>> |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
>>>> |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
>>>
>>> On my system, routing the irq to same core where xsk_rr runs results in
>>> lower latency than routing the irq to a different core. To me that makes
>>> sense in a low-rate latency-sensitive scenario where interrupts are not
>>> causing much trouble, but the resulting locality might be beneficial. I
>>> think you should test this as well.
>>>
>>> The experiments reported above (except for the first one) are
>>> cherry-picking parameter combinations that result in a near-100% load
>>> and ignore anything else. Near-100% load is a highly unlikely scenario
>>> for a latency-sensitive workload.
>>>
>>> When combining the above two paragraphs, I believe other interesting
>>> setups are missing from the experiments, such as comparing to two pairs
>>> of xsk_rr under high load (as mentioned in my previous emails).
>> This is to support an existing real workload. We cannot easily modify
>> its threading model. The two xsk_rr model would be a different
>> workload.
> 
> That's fine, but:
> 
> - In principle I don't think it's a good justification for a kernel 
> change that an application cannot be rewritten.
> 
> - I believe it is your responsibility to more comprehensively document 
> the impact of your proposed changes beyond your one particular workload.> 
A few more observations from my tests for the "SO_BUSYPOLL(separate)" case:

- Using -t for the client reduces latency compared to -T.

- Using poll instead of recvfrom in xsk_rr in rx_polling_run() also 
reduces latency.

Best,
Martin


