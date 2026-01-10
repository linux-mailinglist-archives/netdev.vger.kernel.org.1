Return-Path: <netdev+bounces-248655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5A8D0CC9C
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 02:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C794A302956C
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 01:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC1523D2A3;
	Sat, 10 Jan 2026 01:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="cQ3OXerK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDBA23D7C2;
	Sat, 10 Jan 2026 01:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768010312; cv=fail; b=HEd0dFwojbQjttRiHa0a9gTwHjoMny0pmNOgswFmvcD935SGryY45/nJtHEMpP9lcYWvgLPEvOfQ+HCvgHxkk9cRY7RFMKim9LYpSoylBkV867uATPKCbVXL8QVxzPcWf8F+YuDIafbsVpiBmVZy617pW0aSnkYTzrKpk69JVkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768010312; c=relaxed/simple;
	bh=PeqH2pMEAZKBI02psv31m9j9HIzP/lf7OfpsRc2Rdf0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aeZ1U5dGIcAWWAbSjHLCcueWaJ+eYJ4e22fnMyn1habGgl69XDMhTez+OT8O6mcChvHx+n1gDZA6p66Lv2jRZ1V0RoDBI6eA8OptRHE5R0HqcLrrVQVLzXWpAQsnzTJMnyqyvBSj/DcrvoEDOah6CHeZjT4KmcmOYhn1MaPQe+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=cQ3OXerK; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 609MxefJ3258442;
	Fri, 9 Jan 2026 17:58:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=nydA7o81eiF6Dt5ySD6YNowRf8nboI3eXIGoJZR6zNI=; b=cQ3OXerKPldp
	Qoq1w3zMKQeSkXpY9chXsQPJv1tRTyjivdqBaU6QnrYZniy/pGQ1mhl/J+SVcrVN
	/xi8F/ie3EBoZfQFTSqmlkyHF6YEbC6LoMV8Ar4MZ8KaWFddroU61Sdykd+AP+Lz
	qdqPxWMwYzNrT+JWBB0cOixz/Jv8Tznu6G6VJhCTkbS9l1eNsyaTh4NmWvMble7m
	P/QbpdWcpdglEgynQUe/ZtYbZiGRgmUTds7xAJSwTMTRH/ofb54qPldgk/rt8heB
	oJK3UQy8xZn0wt1FTeGbKjNrDhxub83xdwLxY8Q9Bnz0aSAnjgHwVMBB4/7RFyQn
	QUg+cHJvyg==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	by m0001303.ppops.net (PPS) with ESMTPS id 4bkavxs04d-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 17:58:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CG8skhSSAVAfxZoZUQFosUhICbDJKulQIqPxUY0WgNgvTVXj9wdl+SooUDs6K6i6PLOvBETNAJ1UXSGdcIw6lW3r2s6nj/oeQju3mpc9I5fgeiAJPaMvU5jCrywIKAsZ6ZsyItY0J13REeXGSxCvYDn/3Aut5rXSF4e405CnPiNsOTyWcXyiTYub8EDBldr4SRYYCn7pBWj91h/WFCSnwJPdWXRZtC2mzAjykLAM+LLj7YUYMQ3buuN/as4vJDwp2GMMIpbjaWPcSuD6bj/5ZmVLjGKTWzi1YVBPvH0Ac8H3dd7Tu9CUv82fzHb39Tpkfg3+jUI/9LGosYnqqY8uhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nydA7o81eiF6Dt5ySD6YNowRf8nboI3eXIGoJZR6zNI=;
 b=TYrnX5ifXhSCzgr2OiKoaeRCrgsrYdy7LAnPM3c0R+LmeCXfI5Iip8PHlLh2Y4kw23FcKs8Su3JGSzqv34Qshqi9UHrCw0ZYHhmMHhJwIkGSDT0pNt6qUFGONosaxcRagYDbUGb+qJEfUm3ZLElIJ9VOp5tO3EyKf30WF1A8tDz8q5n7bGj+ytCCHzkqU4ihhgZ17nNMlG8Loh0P6lf2jvTkA36kKLk02CQV+1nR9TxOC98I6I2VAxsdK5BcvVZMVhbtop1Fa/XS0rCn+9aaACnty6QKw3moqto9SmSSZte4q7ODL5/cOOijvaVV2eL5VLIUECkLLS+0C/IL5lCWyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BLAPR15MB3889.namprd15.prod.outlook.com (2603:10b6:208:27a::11)
 by SJ0PR15MB5823.namprd15.prod.outlook.com (2603:10b6:a03:4e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Sat, 10 Jan
 2026 01:58:11 +0000
Received: from BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044]) by BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044%5]) with mapi id 15.20.9478.004; Sat, 10 Jan 2026
 01:58:11 +0000
Message-ID: <2542f908-0390-4f22-b2b2-293136087eee@meta.com>
Date: Fri, 9 Jan 2026 17:57:15 -0800
User-Agent: Mozilla Thunderbird
From: Vishwanath Seshagiri <vishs@meta.com>
Subject: Re: [PATCH 1/2] virtio_net: add page pool support for buffer
 allocation
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>,
        netdev@vger.kernel.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20260106221924.123856-1-vishs@meta.com>
 <20260106221924.123856-2-vishs@meta.com>
 <CACGkMEsfvG5NHd0ShC3DoQEfGH8FeUXDD7FFdb64wK_CkbgQ=g@mail.gmail.com>
 <bba34d18-6b90-4454-ab61-6769342d9114@meta.com>
 <CACGkMEuChs5WHg5916e=odvLU09r8ER-1+VXi5rp+LLo0s6UUg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CACGkMEuChs5WHg5916e=odvLU09r8ER-1+VXi5rp+LLo0s6UUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::14) To BLAPR15MB3889.namprd15.prod.outlook.com
 (2603:10b6:208:27a::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR15MB3889:EE_|SJ0PR15MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b8cbcc-37ce-43f6-52aa-08de4febb4f5
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NjVBSDFUNVAxVEk1RU1NbkdNbWVZWjJQMGdvZXR3ZG9xbVdVMXZ6aDRldHcx?=
 =?utf-8?B?OXkxRk5BdnRvbFhYSEhYbmZCNnp3VzVSSHJjMXNNdjcvMUk0NkRwakFTRTEx?=
 =?utf-8?B?L2ZlTitTNUdYTlJLMTIzaGtKTVlkekFFdFBya2pjZlBBdFZXbGFSL1BoOVZN?=
 =?utf-8?B?RDU0ZS9FRGoyQ1lwUlZvQVQyR2EyV21FVTkvKzJ0Z0pYa282OWxSNm9DTk5H?=
 =?utf-8?B?Z1gvRElDaGlRZlovdm1XYmNpVU5iVkFGRmRDa1JvMFFsZ1pWa1RKeDExb25K?=
 =?utf-8?B?MTB6d2Q0T3I2YkFRdWNzeEtYNXRWeGh2Unk2V1VOY1plblNUYnExa2lmWDJE?=
 =?utf-8?B?ZjlnZjV2UFpzYTkvaEhYclMzTHhVdWlrbG5vV1NBSk14c0NncjQ1TG9leHpy?=
 =?utf-8?B?WlRtVFdlcThBRXFTamNZakY1d2hhN1VmajRCMVU2a3RBS09IT05tRU1walR6?=
 =?utf-8?B?KzV4ektwTkQxTW54dGJvU1VxNklKNmpmRCtuTG5MQjZNVWlYRTFJcGlMRnNF?=
 =?utf-8?B?UWZvT2tFT01kdzIyYTlFemQzUVdXTHZJSXZoUWdneFA4dGZSZ1B3alRVZkcr?=
 =?utf-8?B?L2xpU09iYzB6eDhyd0RHU0l2TmVUTkw0bjBLcHNVeS9TRTkrQ2FMTkxLVjY2?=
 =?utf-8?B?eUUrbUJES1ltc1lrbGd3amUzREZ0UjdVQ3dBSU5CdnhDajJkbUM2SDJOaXA2?=
 =?utf-8?B?dXZrdUNBMlpoSDErTDJHS2oyZitJQTdDcEJBQkV3aXBCTGRLbUpKRkVRL21V?=
 =?utf-8?B?ZkU5L1V2VFcvUnhaRDhqTGh0SjZhRWIxMjFNQjBFTTBrdUVqYldOek5wVGFX?=
 =?utf-8?B?K2NLSlFtYWpyUDJiemNlVzJPNGtsQm5zNUJNckw3UDc2ZnltV0FZUGE0RnBF?=
 =?utf-8?B?MFhHY2dDSGxtaldNMzFNR3kzblcvUTVHbFNhck03OWF2eXpCWWViV1VUVVQ2?=
 =?utf-8?B?WjVGWjUrdml2UVUraEpicmZjb2M1RWx0WUZIU29YUXhtbC9FeEpUM3NIWk9n?=
 =?utf-8?B?bDRGU2VjUTNFd2cwZWhLYkZiZTRaNHM2a3hxMmlTcjR5bEk3RjltUnhIdjZZ?=
 =?utf-8?B?ZlpEMlViWU0yVjArQklSalBmbFlaMTNoTW4yMUt2VVhCa0E1V0xISUdnREN4?=
 =?utf-8?B?UzlaWkIvaHNJYjdIWU9BeWhPRWF2cGx3cE9oZVcrV0NtejlvdG9XaXIvdFF4?=
 =?utf-8?B?Ym5YZGdaTEhydHNJcnJjdmdGYitKaDc0QkRCSWtmSld5VmJDSWNndmZHZ05j?=
 =?utf-8?B?Q0ZMUXpRaHZBZTB4MVR5b2xRQjQvR1g4UDNEYXdjdWovVjZ0R0daK1lzaDc3?=
 =?utf-8?B?cWQ0T0sva2ZkWmRham5jV0h0M3M1K1dVcUYvbnNzRFlMZnFRV2MrM1hPN1FS?=
 =?utf-8?B?UVFBL25ERVIxMjZ3bGhzRzdjdEhjNE55ZXVzTkJmL3BZTFo1M0gvK3QwSzI3?=
 =?utf-8?B?TTdGSmU2V0M5L1RPZm11Y2Jmbjc5dDNiYVVOazd3UUZEL0pVUWpzYWY4S1gw?=
 =?utf-8?B?VFJLWDg5SVNiMzFjVEU4ZlE1aWROeEFpKzZvRFlMS3A3VW1wME5FY25qVnE3?=
 =?utf-8?B?VjZ2OHFhamVHTUhXb3p3UHdyTXYyTHBkMG9PSFRKZWpqTE5DbTArdng0WHdS?=
 =?utf-8?B?cFZTeUlXbHhCclZBbks5a1gvMlVoUFdTbDV5UUFxYnFmaXF2MFBnd1EzMkNq?=
 =?utf-8?B?REwxRTZlY0xZQlFtSi80dXZncUQwVko4czdlekFwdlBBdWhNYkQrVFVpZGJx?=
 =?utf-8?B?bnF6N3hxaVB6U0VSemNrUVlXN2pPaHp0am9KQ0w5Mkw0Z1BFUzFaQnRZM2pq?=
 =?utf-8?B?WHBuclJsQmtlelpobTduZWVWVWlJRktiVFl4Z3M5dlR3ZXQ0eEFOdTZFY1pl?=
 =?utf-8?B?TnZCWW1BRU9SMXJzajVYS3c3eHo2RGxzNUphejc1WDVlSzJoSWF5d0FTMGp0?=
 =?utf-8?Q?xHF4kcb9vUVJW90QxDV4/PSYc2S0ZXo1?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR15MB3889.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VWVQMlJGV3NBNFphaEZvRnVQcStqZ0I3Nk9GYTk4T3NZbFVQVStsQVAxR3lC?=
 =?utf-8?B?YmphbEg0Ukp0VC85eE0yc2lzVkN2WlFzQWpRUHBCLyszS1JtaDE5YmRYUTFm?=
 =?utf-8?B?WjJIbU9qTGJ0YVAxWWc2ZDVwcVhnQ2U5OXZ6TUhQcHhRcUh5WjJqNnkxd01T?=
 =?utf-8?B?NkU1NjRWTG1ka2ZQWC84MFFJSUZWQzNLVFlIdXA4dUZZKzYwc0VGNTR2MFEv?=
 =?utf-8?B?T2RoSlF3L1NnamtrWHc4VW15N0FTZy9jNVpvQXpjN3Bnc093VldZdytaWUQw?=
 =?utf-8?B?ZXZQWVNldExaY3dDN3JBcFVZek84NzA3Y2FFOEFRY2l1cG9KR05ock50SHpP?=
 =?utf-8?B?dGdsdlYvUlFPaXNwT0dEOWNmNERnMzJJcGxuV3hZQkZkK1pJcDZvRHc5aWY2?=
 =?utf-8?B?NnQ5bmxyQ0U3azdmYTBuTUM2bFdSMFN2bURYUVZCcUt1bElCWTB3NjdwOFRB?=
 =?utf-8?B?THZ3TTRTNVpVTStWNmN5T0xpQkxRWXNXeVJveGF3aHkxVGlpSW9scDU5VWV6?=
 =?utf-8?B?by81UGdlUFJ3UGdhcUJCeFVmbnlHNjF5bER0VmZzSE9CMGdQWm1ORnIzeTZ3?=
 =?utf-8?B?VWJIVnZ4ZlJ4M2IrRm9jMkhEKzg0b1NkZHRVclBPWERYajg0YUNrclE3aW9W?=
 =?utf-8?B?bFhqRDQ2Nk4wZlF3U2pqa0k1NXBCcklBWWcveWZYZUJuaTIzOUxGSHVwZVJw?=
 =?utf-8?B?dFVhSXVBRjF2bEk4WXVNVTg5bDZNWVY4ZFVRVDJ5WU1KZlhkcXFMcWRYeFRk?=
 =?utf-8?B?VFk4dm9aMHpxUk1yYldWd0plWVdkTjdwVWhROXVlV21KdU9EUjdKY0FVL0hG?=
 =?utf-8?B?cSthOTFJZkI5VWh3UjZzWEd3OVlTcmozdnkrczhSTS9ZdC9Gd0FPZTYwN2Zp?=
 =?utf-8?B?Q2x2ZjFoR01vVFBUUzZyNUhRWVRtaTBLL0kycWhWWGR1ZmVUU09VTi9GcXZ5?=
 =?utf-8?B?NFVsSlBVSXk5RDlsUTJjcUtESG9zK3dTWmRBYy94OGpKV1ZCZkdTVk5aZTdK?=
 =?utf-8?B?Y2IrcEtvNyt2NTAzbVpvaDZqb01SMmxCNlBxNlJYT3dad2Nwai9QQnF3YjNI?=
 =?utf-8?B?VjJ6blBTaU5kM1gzY0ZPSmF4QkxydVpnV1lKZGl4T2hJNzJSSHlBQ21zck9N?=
 =?utf-8?B?bnBiK2lDL2xjaFVhMjdHNjZhZkdyUTdxYlR2emFHbk1WNGVRMFNHL1Mxai9z?=
 =?utf-8?B?SzdFSWkyVXFDeW1EVWdoYVlEc0VLUVRFaDk3aHZxRzVzRDc1bHhPTHZsUldm?=
 =?utf-8?B?a2lva1F5cE1MM0l0cTVxWml2U1dMZitYdFdnczNGUDdsL0tzWjFmY1BOdytG?=
 =?utf-8?B?RFk2dkp4Ym1Cc2hBNTB6Sms0OGcwUGtBME15RGxnRm5nMnZOOHhBZDlBZ2ht?=
 =?utf-8?B?SFlnYWxzcVhxSkRXWHkvd29PcVpyYm54WHZ1M3BOVjBva0RqZWxPVmF4RkQw?=
 =?utf-8?B?MjNmN2V2NjFUaUEzbDR6c2hBU0gvbk9YcjIrSXArMjRSTlB0ZjFWSjRwNFAv?=
 =?utf-8?B?VkdER3BUVUNuQ011RzRvZEs1R3JoNC9VaFBDSkFmVkxSNWV6RVlMeGpIbHBl?=
 =?utf-8?B?bkxza01YdE1vL0I5c0VNV3B2Q1dWamZZUzN4aW1MTXFmVTNWZ2gxcS8vNmh5?=
 =?utf-8?B?dGgwTFpnYUtyZlYrVXhTQTExSlR5a1NuNGFOSGp2Q05WcmxVOEVvaS93UnAv?=
 =?utf-8?B?SGUzendVTUt3QWtDQmZ4ZDdOQjlsYmkrVmh2dFhRNVlKQnBoR2tKZVZvUCtD?=
 =?utf-8?B?dFEzcGlRa0wveDBPR3pZWjNGUlZWRG91Wk9remFPdEhRVzdEWERvN0k0RjRN?=
 =?utf-8?B?aWZjdGFZcjF1NTF3Ump4OXRNS0VKTThlRnB0OWVRYktMV0o4VW1jcGc0QS96?=
 =?utf-8?B?Rm5YaTlHcTlqeGJaRGEwVEpaMy85c3RlcHBETHc4K0xiRG9KMmJrdG1HK202?=
 =?utf-8?B?UE1QeUdJeE5TT3J1SXFKN05qTW93V1RjbktqRS82YVo5SzVUMUlla2NQVSsw?=
 =?utf-8?B?REtnL0ZMK0RibTVzUDVBUU81T1pqb1NueFE1c3dGcmIycGpMeEwwSjBBWStF?=
 =?utf-8?B?ZkJDUzhQbWtrSVFpeVd6ZEx0VVNNZzJKTWxubUdmRVNnb3l6aERwaWp6emtq?=
 =?utf-8?B?Mnh1R3V5c3N6UTdaVjdEN0NUanRKTjNYTEIxM24yUS9YOVEzbWU3ekl3TWV0?=
 =?utf-8?B?ZEhLTHB0UEd2SHJtWjVzc1pLcytMWkZKMEpwa2NxOHhnTWdDWmRiNCthZndq?=
 =?utf-8?B?a2YrSE1QeDZmNTJmM2NZS3FkUThjcG9yK3Uzd09OQmNkenliUlhtbXZJaUVi?=
 =?utf-8?B?ZTRFd2pYMFM3VGV2OVJBUkVneGp3WUpFM2w1V2VpLy9GUGR0WnZZSVdFbGtB?=
 =?utf-8?Q?Buck+SGdzb/i/o7A=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b8cbcc-37ce-43f6-52aa-08de4febb4f5
X-MS-Exchange-CrossTenant-AuthSource: BLAPR15MB3889.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2026 01:58:11.0437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxjzymxUcKspcnettpub+PseUmr57+30Lio0drIqULCG0RQw3M2tUdmyPHtEK3Gs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5823
X-Authority-Analysis: v=2.4 cv=eqzSD4pX c=1 sm=1 tr=0 ts=6961b236 cx=c_pps
 a=WfYMUjdTTdEkkNza/pHfSQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8 a=idD9JtHqdfSR5gppuJIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEwMDAxNCBTYWx0ZWRfXxmRjb2T1wb3T
 VpN8TGYPg3cgSrfd4JqWEB1IvwYrGXUOBYSqVIT9RA1k/uOWoR1KJL470We5YGrgO2jl//WkbmL
 ZFwqyLYCXOe+IXQGqVwUmSQg9RAfoud7YsOKGqorsF91MZJvQWzeAIQ0dRJUi1vgBgmISPOlX2X
 oiZ2UU8EfIykU9xxUEH0vHGtnxlGRZnrQY1tWgGoJvO59mcacIuBlfYZMFhhNq8Vf6chQxQy26B
 TBtfqdmIHbc8y1sVMVjoYpVA164uytUS5Y7NTjl+9qpn6R5kxhn9doyHAwIzPDmYGvbJt9RbO1f
 WAtrJkVxfPMdYWGAzHoTwEwolkYotu4Xro6Ako3jyfScV+RNQGNqHdOqBdOTRM4Kaf6KEut6060
 J3M1u907cDtLKxQKhZ5+iNHz30Tzp//uzaV1LIn+kaSnocnycNRFc2JIZiZAZ5Thi91AHG2QFDm
 WILlJHvqO5wCYxWFNjQ==
X-Proofpoint-GUID: U6QP6zo42rnm8STLALUKWzCyVYEBvOLT
X-Proofpoint-ORIG-GUID: U6QP6zo42rnm8STLALUKWzCyVYEBvOLT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_07,2026-01-09_02,2025-10-01_01



On 1/8/26 7:16 PM, Jason Wang wrote:
> On Thu, Jan 8, 2026 at 2:24 PM Vishwanath Seshagiri <vishs@meta.com> wrote:
>>
>> On 1/7/26 7:16 PM, Jason Wang wrote:
>>> On Wed, Jan 7, 2026 at 6:19 AM Vishwanath Seshagiri <vishs@meta.com> wrote:
>>>>
>>>> Use page_pool for RX buffer allocation in mergeable and small buffer
>>>> modes. skb_mark_for_recycle() enables page reuse.
>>>>
>>>> Big packets mode is unchanged because it uses page->private for linked
>>>> list chaining of multiple pages per buffer, which conflicts with
>>>> page_pool's internal use of page->private.
>>>>
>>>> Page pools are created in ndo_open and destroyed in remove (not
>>>> ndo_close). This follows existing driver behavior where RX buffers
>>>> remain in the virtqueue across open/close cycles and are only freed
>>>> on device removal.
>>>>
>>>> The rx_mode_work_enabled flag prevents virtnet_rx_mode_work() from
>>>> sending control virtqueue commands while ndo_close is tearing down
>>>> device state. With MEM_TYPE_PAGE_POOL, xdp_rxq_info_unreg() calls
>>>> page_pool_destroy() during close, and concurrent rx_mode_work can
>>>> cause virtqueue corruption. The check is after rtnl_lock() to
>>>> synchronize with ndo_close(), which sets the flag under the same lock.
>>>>
>>>> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
>>>> ---
>>>>    drivers/net/virtio_net.c | 246 ++++++++++++++++++++++++++++++++-------
>>>>    1 file changed, 205 insertions(+), 41 deletions(-)
>>>>
>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>> index 22d894101c01..c36663525c17 100644
>>>> --- a/drivers/net/virtio_net.c
>>>> +++ b/drivers/net/virtio_net.c
>>>> @@ -26,6 +26,7 @@
>>>>    #include <net/netdev_rx_queue.h>
>>>>    #include <net/netdev_queues.h>
>>>>    #include <net/xdp_sock_drv.h>
>>>> +#include <net/page_pool/helpers.h>
>>>>
>>>>    static int napi_weight = NAPI_POLL_WEIGHT;
>>>>    module_param(napi_weight, int, 0444);
>>>> @@ -359,6 +360,8 @@ struct receive_queue {
>>>>           /* Page frag for packet buffer allocation. */
>>>>           struct page_frag alloc_frag;
>>>>
>>>> +       struct page_pool *page_pool;
>>>> +
>>>>           /* RX: fragments + linear part + virtio header */
>>>>           struct scatterlist sg[MAX_SKB_FRAGS + 2];
>>>>
>>>> @@ -524,11 +527,13 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
>>>>                                  struct virtnet_rq_stats *stats);
>>>>    static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
>>>>                                    struct sk_buff *skb, u8 flags);
>>>> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>>>> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
>>>> +                                              struct sk_buff *head_skb,
>>>>                                                  struct sk_buff *curr_skb,
>>>>                                                  struct page *page, void *buf,
>>>>                                                  int len, int truesize);
>>>>    static void virtnet_xsk_completed(struct send_queue *sq, int num);
>>>> +static void free_unused_bufs(struct virtnet_info *vi);
>>>>
>>>>    enum virtnet_xmit_type {
>>>>           VIRTNET_XMIT_TYPE_SKB,
>>>> @@ -709,15 +714,24 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
>>>>           return p;
>>>>    }
>>>>
>>>> +static void virtnet_put_page(struct receive_queue *rq, struct page *page,
>>>> +                            bool allow_direct)
>>>> +{
>>>> +       if (rq->page_pool)
>>>> +               page_pool_put_page(rq->page_pool, page, -1, allow_direct);
>>>> +       else
>>>> +               put_page(page);
>>>> +}
>>>> +
>>>>    static void virtnet_rq_free_buf(struct virtnet_info *vi,
>>>>                                   struct receive_queue *rq, void *buf)
>>>>    {
>>>>           if (vi->mergeable_rx_bufs)
>>>> -               put_page(virt_to_head_page(buf));
>>>> +               virtnet_put_page(rq, virt_to_head_page(buf), false);
>>>>           else if (vi->big_packets)
>>>>                   give_pages(rq, buf);
>>>>           else
>>>> -               put_page(virt_to_head_page(buf));
>>>> +               virtnet_put_page(rq, virt_to_head_page(buf), false);
>>>>    }
>>>>
>>>>    static void enable_delayed_refill(struct virtnet_info *vi)
>>>> @@ -894,9 +908,11 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>>>                   if (unlikely(!skb))
>>>>                           return NULL;
>>>>
>>>> -               page = (struct page *)page->private;
>>>> -               if (page)
>>>> -                       give_pages(rq, page);
>>>> +               if (!rq->page_pool) {
>>>> +                       page = (struct page *)page->private;
>>>> +                       if (page)
>>>> +                               give_pages(rq, page);
>>>> +               }
>>>>                   goto ok;
>>>>           }
>>>>
>>>> @@ -931,7 +947,10 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>>>                   skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
>>>>                                   frag_size, truesize);
>>>>                   len -= frag_size;
>>>> -               page = (struct page *)page->private;
>>>> +               if (!rq->page_pool)
>>>> +                       page = (struct page *)page->private;
>>>> +               else
>>>> +                       page = NULL;
>>>>                   offset = 0;
>>>>           }
>>>>
>>>> @@ -942,7 +961,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>>>           hdr = skb_vnet_common_hdr(skb);
>>>>           memcpy(hdr, hdr_p, hdr_len);
>>>>           if (page_to_free)
>>>> -               put_page(page_to_free);
>>>> +               virtnet_put_page(rq, page_to_free, true);
>>>>
>>>>           return skb;
>>>>    }
>>>> @@ -982,15 +1001,10 @@ static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
>>>>    static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
>>>>    {
>>>>           struct virtnet_info *vi = rq->vq->vdev->priv;
>>>> -       void *buf;
>>>>
>>>>           BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>>>>
>>>> -       buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
>>>> -       if (buf)
>>>> -               virtnet_rq_unmap(rq, buf, *len);
>>>> -
>>>> -       return buf;
>>>> +       return virtqueue_get_buf_ctx(rq->vq, len, ctx);
>>>>    }
>>>>
>>>>    static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
>>>> @@ -1084,9 +1098,6 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>>>>                   return;
>>>>           }
>>>>
>>>> -       if (!vi->big_packets || vi->mergeable_rx_bufs)
>>>> -               virtnet_rq_unmap(rq, buf, 0);
>>>> -
>>>>           virtnet_rq_free_buf(vi, rq, buf);
>>>>    }
>>>>
>>>> @@ -1352,7 +1363,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
>>>>
>>>>                   truesize = len;
>>>>
>>>> -               curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
>>>> +               curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
>>>>                                                       buf, len, truesize);
>>>>                   if (!curr_skb) {
>>>>                           put_page(page);
>>>> @@ -1788,7 +1799,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>>>>           return ret;
>>>>    }
>>>>
>>>> -static void put_xdp_frags(struct xdp_buff *xdp)
>>>> +static void put_xdp_frags(struct xdp_buff *xdp, struct receive_queue *rq)
>>>>    {
>>>>           struct skb_shared_info *shinfo;
>>>>           struct page *xdp_page;
>>>> @@ -1798,7 +1809,7 @@ static void put_xdp_frags(struct xdp_buff *xdp)
>>>>                   shinfo = xdp_get_shared_info_from_buff(xdp);
>>>>                   for (i = 0; i < shinfo->nr_frags; i++) {
>>>>                           xdp_page = skb_frag_page(&shinfo->frags[i]);
>>>> -                       put_page(xdp_page);
>>>> +                       virtnet_put_page(rq, xdp_page, true);
>>>>                   }
>>>>           }
>>>>    }
>>>> @@ -1914,7 +1925,7 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>>>>                   off = buf - page_address(p);
>>>>
>>>>                   if (check_mergeable_len(dev, ctx, buflen)) {
>>>> -                       put_page(p);
>>>> +                       virtnet_put_page(rq, p, true);
>>>>                           goto err_buf;
>>>>                   }
>>>>
>>>> @@ -1922,14 +1933,14 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>>>>                    * is sending packet larger than the MTU.
>>>>                    */
>>>>                   if ((page_off + buflen + tailroom) > PAGE_SIZE) {
>>>> -                       put_page(p);
>>>> +                       virtnet_put_page(rq, p, true);
>>>>                           goto err_buf;
>>>>                   }
>>>>
>>>>                   memcpy(page_address(page) + page_off,
>>>>                          page_address(p) + off, buflen);
>>>>                   page_off += buflen;
>>>> -               put_page(p);
>>>> +               virtnet_put_page(rq, p, true);
>>>>           }
>>>>
>>>>           /* Headroom does not contribute to packet length */
>>>> @@ -1979,7 +1990,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>>>>           unsigned int headroom = vi->hdr_len + header_offset;
>>>>           struct virtio_net_hdr_mrg_rxbuf *hdr = buf + header_offset;
>>>>           struct page *page = virt_to_head_page(buf);
>>>> -       struct page *xdp_page;
>>>> +       struct page *xdp_page = NULL;
>>>>           unsigned int buflen;
>>>>           struct xdp_buff xdp;
>>>>           struct sk_buff *skb;
>>>> @@ -2013,7 +2024,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>>>>                           goto err_xdp;
>>>>
>>>>                   buf = page_address(xdp_page);
>>>> -               put_page(page);
>>>> +               virtnet_put_page(rq, page, true);
>>>>                   page = xdp_page;
>>>>           }
>>>>
>>>> @@ -2045,13 +2056,19 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>>>>           if (metasize)
>>>>                   skb_metadata_set(skb, metasize);
>>>>
>>>> +       if (rq->page_pool && !xdp_page)
>>>> +               skb_mark_for_recycle(skb);
>>>> +
>>>>           return skb;
>>>>
>>>>    err_xdp:
>>>>           u64_stats_inc(&stats->xdp_drops);
>>>>    err:
>>>>           u64_stats_inc(&stats->drops);
>>>> -       put_page(page);
>>>> +       if (xdp_page)
>>>> +               put_page(page);
>>>> +       else
>>>> +               virtnet_put_page(rq, page, true);
>>>>    xdp_xmit:
>>>>           return NULL;
>>>>    }
>>>> @@ -2099,12 +2116,15 @@ static struct sk_buff *receive_small(struct net_device *dev,
>>>>           }
>>>>
>>>>           skb = receive_small_build_skb(vi, xdp_headroom, buf, len);
>>>> -       if (likely(skb))
>>>> +       if (likely(skb)) {
>>>> +               if (rq->page_pool)
>>>> +                       skb_mark_for_recycle(skb);
>>>>                   return skb;
>>>> +       }
>>>>
>>>>    err:
>>>>           u64_stats_inc(&stats->drops);
>>>> -       put_page(page);
>>>> +       virtnet_put_page(rq, page, true);
>>>>           return NULL;
>>>>    }
>>>>
>>>> @@ -2159,7 +2179,7 @@ static void mergeable_buf_free(struct receive_queue *rq, int num_buf,
>>>>                   }
>>>>                   u64_stats_add(&stats->bytes, len);
>>>>                   page = virt_to_head_page(buf);
>>>> -               put_page(page);
>>>> +               virtnet_put_page(rq, page, true);
>>>>           }
>>>>    }
>>>>
>>>> @@ -2270,7 +2290,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>>>>                   offset = buf - page_address(page);
>>>>
>>>>                   if (check_mergeable_len(dev, ctx, len)) {
>>>> -                       put_page(page);
>>>> +                       virtnet_put_page(rq, page, true);
>>>>                           goto err;
>>>>                   }
>>>>
>>>> @@ -2289,7 +2309,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>>>>           return 0;
>>>>
>>>>    err:
>>>> -       put_xdp_frags(xdp);
>>>> +       put_xdp_frags(xdp, rq);
>>>>           return -EINVAL;
>>>>    }
>>>>
>>>> @@ -2364,7 +2384,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>>>>
>>>>           *frame_sz = PAGE_SIZE;
>>>>
>>>> -       put_page(*page);
>>>> +       virtnet_put_page(rq, *page, true);
>>>>
>>>>           *page = xdp_page;
>>>>
>>>> @@ -2386,6 +2406,7 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>>>>           struct page *page = virt_to_head_page(buf);
>>>>           int offset = buf - page_address(page);
>>>>           unsigned int xdp_frags_truesz = 0;
>>>> +       struct page *org_page = page;
>>>>           struct sk_buff *head_skb;
>>>>           unsigned int frame_sz;
>>>>           struct xdp_buff xdp;
>>>> @@ -2410,6 +2431,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>>>>                   head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
>>>>                   if (unlikely(!head_skb))
>>>>                           break;
>>>> +               if (rq->page_pool && page == org_page)
>>>> +                       skb_mark_for_recycle(head_skb);
>>>>                   return head_skb;
>>>>
>>>>           case XDP_TX:
>>>> @@ -2420,10 +2443,13 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>>>>                   break;
>>>>           }
>>>>
>>>> -       put_xdp_frags(&xdp);
>>>> +       put_xdp_frags(&xdp, rq);
>>>>
>>>>    err_xdp:
>>>> -       put_page(page);
>>>> +       if (page != org_page)
>>>> +               put_page(page);
>>>> +       else
>>>> +               virtnet_put_page(rq, page, true);
>>>>           mergeable_buf_free(rq, num_buf, dev, stats);
>>>>
>>>>           u64_stats_inc(&stats->xdp_drops);
>>>> @@ -2431,7 +2457,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>>>>           return NULL;
>>>>    }
>>>>
>>>> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>>>> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
>>>> +                                              struct sk_buff *head_skb,
>>>>                                                  struct sk_buff *curr_skb,
>>>>                                                  struct page *page, void *buf,
>>>>                                                  int len, int truesize)
>>>> @@ -2463,7 +2490,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>>>>
>>>>           offset = buf - page_address(page);
>>>>           if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) {
>>>> -               put_page(page);
>>>> +               virtnet_put_page(rq, page, true);
>>>>                   skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
>>>>                                        len, truesize);
>>>>           } else {
>>>> @@ -2512,10 +2539,13 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>>>           }
>>>>
>>>>           head_skb = page_to_skb(vi, rq, page, offset, len, truesize, headroom);
>>>> +       if (unlikely(!head_skb))
>>>> +               goto err_skb;
>>>> +
>>>>           curr_skb = head_skb;
>>>>
>>>> -       if (unlikely(!curr_skb))
>>>> -               goto err_skb;
>>>> +       if (rq->page_pool)
>>>> +               skb_mark_for_recycle(head_skb);
>>>>           while (--num_buf) {
>>>>                   buf = virtnet_rq_get_buf(rq, &len, &ctx);
>>>>                   if (unlikely(!buf)) {
>>>> @@ -2534,7 +2564,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>>>                           goto err_skb;
>>>>
>>>>                   truesize = mergeable_ctx_to_truesize(ctx);
>>>> -               curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
>>>> +               curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
>>>>                                                       buf, len, truesize);
>>>>                   if (!curr_skb)
>>>>                           goto err_skb;
>>>> @@ -2544,7 +2574,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>>>           return head_skb;
>>>>
>>>>    err_skb:
>>>> -       put_page(page);
>>>> +       virtnet_put_page(rq, page, true);
>>>>           mergeable_buf_free(rq, num_buf, dev, stats);
>>>>
>>>>    err_buf:
>>>> @@ -2683,6 +2713,8 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>>>>    static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>>>>                                gfp_t gfp)
>>>>    {
>>>> +       unsigned int offset;
>>>> +       struct page *page;
>>>>           char *buf;
>>>>           unsigned int xdp_headroom = virtnet_get_headroom(vi);
>>>>           void *ctx = (void *)(unsigned long)xdp_headroom;
>>>> @@ -2692,6 +2724,24 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>>>>           len = SKB_DATA_ALIGN(len) +
>>>>                 SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>>>>
>>>> +       if (rq->page_pool) {
>>>
>>> I think it would be a burden if we maintain two different data paths.
>>
>> I will move it to probe in v2.
>>
>>> And what's more, I see this patch doesn't require DMA mapping for the
>>> page pool. This basically defeats the pre mapping logic introduced in
>>> 31f3cd4e5756b("virtio-net: rq submits premapped per-buffer"). Lastly,
>>> it seems we should make VIRTIO_NET select PAGE_POOL.
>>
>> I intentionally used flags=0 and virtqueue_add_inbuf_ctx() to keep the
>> initial patch simple, following the pattern of xen-netfront which also
>> used flags=0 due to its custom DMA mechanism (grant tables).
>>
>> My concern was that virtio has its own DMA abstraction
>> vdev->map->map_page() (used by VDUSE), and I wasn't sure if page_pool's
>> standard dma_map_page() would be compatible with all virtio backends.
> 
> You are right, DMA is unware about virtio mappings, so we can't use that.
> 
>>
>> To preserve the premapping optimization, I see two options:
>> 1. Use PP_FLAG_DMA_MAP with virtqueue_dma_dev() as the DMA device. This
>> is simpler but uses the standard DMA API, which may not work corerctly
>> with VDUSE.
>> 2. Integrate page_pool allocation with virtio's existing DMA infra -
>> allocate pages from page_pool, but DMA map using
>> virtqueue_map_single_attrs(), then use virtqueue_add_inbuf_premapped().
>> This preserves the compatibility but requires tracking DMA mapping per
>> page.
>>
>> Which would be better? Or, is there anything simpler that I'm missing?
>>
> 
> 2 would be better.

Thanks for confirming. For v2, I'll check virtqueue_dma_dev() at probe
time to select the DMA strategy:
1. When virtqueue_dma_dev() != NULL i.e. standard virtio backends:
- Create page_pool with PP_FLAG_DMA_MAP, dev = virtqueue_dma_dev()
- Page pool handles the DMA mapping, and pages stay mapped across
recycling
- Submit it using virtqueue_add_inbuf_premapped()

2. When it is NULL i.e. VDUSE, direct physical:
- Create page_pool with flags = 0
- Manually map using vitqueue_map_single_attrs()
- Submit using virtqueue_add_inbuf_premapped()
- Unmap on recycle via virtqueue_unmap_single_attrs()

Does this sound good?


> 
>> Will add PAGE_POOL in kConfig for VIRTIO_NET in v2.
>>
>>>
>>>> +               page = page_pool_alloc_frag(rq->page_pool, &offset, len, gfp);
>>>> +               if (unlikely(!page))
>>>> +                       return -ENOMEM;
>>>> +
>>>> +               buf = page_address(page) + offset;
>>>> +               buf += VIRTNET_RX_PAD + xdp_headroom;
>>>> +
>>>> +               sg_init_table(rq->sg, 1);
>>>> +               sg_set_buf(&rq->sg[0], buf, vi->hdr_len + GOOD_PACKET_LEN);
>>>> +
>>>> +               err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
>>>> +               if (err < 0)
>>>> +                       page_pool_put_page(rq->page_pool,
>>>> +                                          virt_to_head_page(buf), -1, false);
>>>> +               return err;
>>>> +       }
>>>> +
>>>>           if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
>>>>                   return -ENOMEM;
>>>>
>>>> @@ -2786,6 +2836,8 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>>>>           unsigned int tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
>>>>           unsigned int room = SKB_DATA_ALIGN(headroom + tailroom);
>>>>           unsigned int len, hole;
>>>> +       unsigned int offset;
>>>> +       struct page *page;
>>>>           void *ctx;
>>>>           char *buf;
>>>>           int err;
>>>> @@ -2796,6 +2848,39 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>>>>            */
>>>>           len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>>>>
>>>> +       if (rq->page_pool) {
>>>> +               page = page_pool_alloc_frag(rq->page_pool, &offset,
>>>> +                                           len + room, gfp);
>>>> +               if (unlikely(!page))
>>>> +                       return -ENOMEM;
>>>> +
>>>> +               buf = page_address(page) + offset;
>>>> +               buf += headroom; /* advance address leaving hole at front of pkt */
>>>> +
>>>> +               hole = PAGE_SIZE - (offset + len + room);
>>>> +               if (hole < len + room) {
>>>> +                       /* To avoid internal fragmentation, if there is very likely not
>>>> +                        * enough space for another buffer, add the remaining space to
>>>> +                        * the current buffer.
>>>> +                        * XDP core assumes that frame_size of xdp_buff and the length
>>>> +                        * of the frag are PAGE_SIZE, so we disable the hole mechanism.
>>>> +                        */
>>>> +                       if (!headroom)
>>>> +                               len += hole;
>>>> +               }
>>>> +
>>>> +               ctx = mergeable_len_to_ctx(len + room, headroom);
>>>> +
>>>> +               sg_init_table(rq->sg, 1);
>>>> +               sg_set_buf(&rq->sg[0], buf, len);
>>>> +
>>>> +               err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
>>>> +               if (err < 0)
>>>> +                       page_pool_put_page(rq->page_pool,
>>>> +                                          virt_to_head_page(buf), -1, false);
>>>> +               return err;
>>>> +       }
>>>> +
>>>>           if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
>>>>                   return -ENOMEM;
>>>>
>>>> @@ -3181,7 +3266,10 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
>>>>                   return err;
>>>>
>>>>           err = xdp_rxq_info_reg_mem_model(&vi->rq[qp_index].xdp_rxq,
>>>> -                                        MEM_TYPE_PAGE_SHARED, NULL);
>>>> +                                        vi->rq[qp_index].page_pool ?
>>>> +                                               MEM_TYPE_PAGE_POOL :
>>>> +                                               MEM_TYPE_PAGE_SHARED,
>>>> +                                        vi->rq[qp_index].page_pool);
>>>>           if (err < 0)
>>>>                   goto err_xdp_reg_mem_model;
>>>>
>>>> @@ -3221,11 +3309,77 @@ static void virtnet_update_settings(struct virtnet_info *vi)
>>>>                   vi->duplex = duplex;
>>>>    }
>>>>
>>>> +static int virtnet_create_page_pools(struct virtnet_info *vi)
>>>> +{
>>>> +       int i, err;
>>>> +
>>>> +       for (i = 0; i < vi->curr_queue_pairs; i++) {
>>>> +               struct receive_queue *rq = &vi->rq[i];
>>>> +               struct page_pool_params pp_params = { 0 };
>>>> +
>>>> +               if (rq->page_pool)
>>>> +                       continue;
>>>> +
>>>> +               if (rq->xsk_pool)
>>>> +                       continue;
>>>> +
>>>> +               if (!vi->mergeable_rx_bufs && vi->big_packets)
>>>> +                       continue;
>>>> +
>>>> +               pp_params.order = 0;
>>>> +               pp_params.pool_size = virtqueue_get_vring_size(rq->vq);
>>>> +               pp_params.nid = dev_to_node(vi->vdev->dev.parent);
>>>> +               pp_params.dev = vi->vdev->dev.parent;
>>>> +               pp_params.netdev = vi->dev;
>>>> +               pp_params.napi = &rq->napi;
>>>> +               pp_params.flags = 0;
>>>> +
>>>> +               rq->page_pool = page_pool_create(&pp_params);
>>>> +               if (IS_ERR(rq->page_pool)) {
>>>> +                       err = PTR_ERR(rq->page_pool);
>>>> +                       rq->page_pool = NULL;
>>>> +                       goto err_cleanup;
>>>> +               }
>>>> +       }
>>>> +       return 0;
>>>> +
>>>> +err_cleanup:
>>>> +       while (--i >= 0) {
>>>> +               struct receive_queue *rq = &vi->rq[i];
>>>> +
>>>> +               if (rq->page_pool) {
>>>> +                       page_pool_destroy(rq->page_pool);
>>>> +                       rq->page_pool = NULL;
>>>> +               }
>>>> +       }
>>>> +       return err;
>>>> +}
>>>> +
>>>> +static void virtnet_destroy_page_pools(struct virtnet_info *vi)
>>>> +{
>>>> +       int i;
>>>> +
>>>> +       for (i = 0; i < vi->max_queue_pairs; i++) {
>>>> +               struct receive_queue *rq = &vi->rq[i];
>>>> +
>>>> +               if (rq->page_pool) {
>>>> +                       page_pool_destroy(rq->page_pool);
>>>> +                       rq->page_pool = NULL;
>>>> +               }
>>>> +       }
>>>> +}
>>>> +
>>>>    static int virtnet_open(struct net_device *dev)
>>>>    {
>>>>           struct virtnet_info *vi = netdev_priv(dev);
>>>>           int i, err;
>>>>
>>>> +       err = virtnet_create_page_pools(vi);
>>>
>>> Any reason those page pools were not created during the probe?
>>
>> No good reason. I will add it in v2.
>>
> 
> Thanks
> 


