Return-Path: <netdev+bounces-219427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C4DB41368
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 06:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A3AD7AE263
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 04:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F5F2D0C73;
	Wed,  3 Sep 2025 04:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="qQCXmKby"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B179223DFD;
	Wed,  3 Sep 2025 04:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756872471; cv=fail; b=MLrlL/sO06AtCpM5Mrfa43GhyIQ2GHIYlfsWAo7Nl/lu78pyF7cO1ENvvZQqaddiyNOPpRe+wPlPJ0FLEKyrtQSqSq1x2hMJ3CzDKrmxTIeggRqopD9l8GRis2g+rlroeu7jJzrLNJScFTAhnfFe9rhW3Xaxb8wpCPK9o3b5vVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756872471; c=relaxed/simple;
	bh=nzpAOh9YKT+/EHD4tu0+WguwdO9gWGyvYmGrtjc/H6w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f9kYBZxPlRIg2peX9hBB60V8P+1TjOEFn1cYKQ6Grik4yCz+L0Y2K6JHJ9X1ulgEJ1uxBFwlJRtE30sd8ObUhUl+tLUrBPjIjzzb3CxZAGsCryBzaKnhUhkidcplRjkkrBXGDCKBwxUr4IdwCVA4fDHRTxMcy01KFmKsHpamoz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=qQCXmKby; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFCUN8zv5cMaBiqlwcCcXjxUa5pha/jHn9naA/1mdzQE669SpdJb0dtHq6a2gdl0FVTwER+fRGUbQPixeqlVerk1T64CyrqijYkX97EbEvwzAyAlYEPxOIx9RU/yQxahCie36sEfhg4VUfOn+jXBT+RNfNNI5n2ZrMN1SGIhFzPLYXBnCV9LB4M7u6oDqHnzZQWZ8iAQ9EreDfWJ16qXp95YzeOa98XmqG8Pia5i/eMyjVrVtZbWVvQOfoAAwLenUmd+CoE+leVJFrYBOSA8hs0U2mUeG3v2xGF69dYKDvpRjCwFA50SbgiPBgxjrg7mhF8Q8zAitNi9EvuMXmrW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmA1g7y1Z7WCPAd3FYVpTpwBADSAneHfP6EwlDyAlz4=;
 b=JGbriXRjxzSuszH7IXjPDmc7M3SW/hyCW8KVrwAFkeXQ4l9ldMwF27TwxboP58G4gTLgP3sY+EFEswR71IAK4HmiBnYvGkQz1hYyB6jLBRXoB5iez6FwniKtEezIr1aSY2RwZD4XSdBzuAM8OYDAFwXVqz0qjF7L34EChadLKdnK9PUubI14uv90pbVYpyX1fXdpKTsfA0xkRrke+db5RNI+r0TwfdZHbd1kWUvfzcDTIc0ct/SCESCrNneH+ICBa7nRjIVvsXzBMfGdcwsNJzwZZKnEP/Y3O+aIeFVmj522kbIqW84wL3gSK3PhsllHTjZUwf5+Y0fmmxgPNBfqyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmA1g7y1Z7WCPAd3FYVpTpwBADSAneHfP6EwlDyAlz4=;
 b=qQCXmKbywGqsw6F0K54XCOWpktaLqgpY9YYT0pr+lFxbaJjCc+BkIeJsa8SZpa3Svqt/BgANG8DYlag3qKiZX1er2j16qX/cLRbb+eEq1/1AlpWQWMAuu6RSUplhKy816PcTkF5Zom79BZgAwPf/jxULIUNQx42CUT8B+aO10dmktf2wplRmxDVLFfxkxQhlq3AM/7UNRn9NA4iUMtv1i5Mo6WkCis8XGhmcaF9T5YC7mGso63I+23D+sZRckp2ypYfbbsZ5Q4i/bGJo7INROI7PLH5YJe7Zlv3BHgRujvbVbuB0WvqmBCKCBCjoxpXhQkECXN4uq76M4bv9AFuKcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by SJ0PR03MB5790.namprd03.prod.outlook.com (2603:10b6:a03:2dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 04:07:46 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%3]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 04:07:46 +0000
Message-ID: <566608c6-2816-4110-bdd3-cea384bb6e5b@altera.com>
Date: Wed, 3 Sep 2025 09:37:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: marvell: Fix 88e1510 downshift counter
 errata
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20250902-marvell_fix-v1-1-9fba7a6147dd@altera.com>
 <aLbyju1nKm5LXDDX@shell.armlinux.org.uk>
 <7b799cb3-ba9f-464e-a0a6-cad151742aab@altera.com>
 <4b3e4339-93d5-4d14-b53f-43c5d379d2fa@lunn.ch>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <4b3e4339-93d5-4d14-b53f-43c5d379d2fa@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::13) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|SJ0PR03MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: c0188eb0-108a-4208-832d-08ddea9f6ffe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blNZSDdaRnJrTkNFTHhMQVZGcDlFaUl0aWU0cW9ZZjVySmlNR2JZTmxDWnZR?=
 =?utf-8?B?Y3FySEFHNGM1UkhTWnV2SStxbGlLRjJkVmQ2U24yeFBHcmJzQloxWHFPR3FP?=
 =?utf-8?B?ZFVBemlNNUtMK2lvZFVMa2pBajZxVzFxQS9MSWhONUlLTlZjWEl3b0ROdVJD?=
 =?utf-8?B?aGlmV3FSUk9TMjBlTzZjSm4wWEt0ajFrNnF5cFdDVkU5N2s3U3dYQWM1NVZJ?=
 =?utf-8?B?dGhNNWlJeVNBOWpuaEh3R0dFNWFQejFFaDZ1VWdCQnJRUUtJeW9vcGVPcHA1?=
 =?utf-8?B?WEFFNWowaEtDNGlZY1ZjUWN2V0RXYVJkdGxTT08ySkprL2lzamFwQnlPcGI5?=
 =?utf-8?B?S0kyUHkweG1Gd2JoWlBRbWR6a045eHJESzJUdXZIVXIzdi91Qkl4aVRnOWR5?=
 =?utf-8?B?aUplNm85aUpMZEZ6TU9aaEowbUthdmFMaHNpWVVLQzZNNlNyMlJ5OW9zVnZY?=
 =?utf-8?B?N2pNWWQ3Zjd4NXZ6Y2lDL2xreGJaWVBYSGJkQ0wwNEIzMVY5OWhMT0hES2k0?=
 =?utf-8?B?RnZQUzdhSHdNek52Q3I1Q1VaNG45c3puQlJIRTh3U0h3eUNqUUpsY2YrTHNK?=
 =?utf-8?B?dXdBMU03SllxS2wzc1RZYzZxMm1WTzFRa1JCb1YzWUh5Q0MyWU5HTlI4ZHNG?=
 =?utf-8?B?U09WTjJwSnBxNENJMDl3ZTNaZXVuY3FoMTBVaUM0eTdTZ0dRcWIvTXFoY0JU?=
 =?utf-8?B?aHMvTmVRSXo3QXkyUitjd2hhc1lXN252RG9jRVAyNE9CeTlPVWhmblY3MHVn?=
 =?utf-8?B?QnQveGt2YmZ5RG1oRC8rM1hkeWhUbzlMU2JSaVNsR0FEaEY0RC9Qd1F3L3Yx?=
 =?utf-8?B?VEQzUkpKUFFYc1dRYVJoTzc1c1Fia2pEeDR5eFBoS1pibStxSUNNRnNvUEtO?=
 =?utf-8?B?d3RpaEkzV2xlOVdWb29qMEV2b0JiUmU4aGJYNlVsTi9RMHd2UVdhUG16S3do?=
 =?utf-8?B?U1YrRUE5aE1iZ2FGZjVBck9zSVhZbDR4WmtXWE93T0lLVUw5eGJNdlNWQW5D?=
 =?utf-8?B?cEpnMndENW10QXY3bjZsU2U0UUx1clJ3d0NrVXlUdlZDUXp1c1BGTDk4c2pj?=
 =?utf-8?B?SmVIZUtrVHRJN2dTRFQzT1FyY0Urb2FOa3p4dlB0a1JMVlJvaWtOQW5ydXl0?=
 =?utf-8?B?VXdEb2RvZDJ2U0ZRdmtSRC9Bd21ZYjZ1SDZhYkdFK21CMnF3ZU0zN0ltWFIv?=
 =?utf-8?B?QzFQTDZadXBhQmprQll3STllQXlGc1RSQUxqdkxkUURPUXc1MDBnYlZ4YmVi?=
 =?utf-8?B?QllwK25kdVo1V012Wm40bFJPVHFIT2NXQmNPOGtlcjZaaEFIdXIwYzJCL1No?=
 =?utf-8?B?TW5lb2ZoRWZBVWthdVpvTnVOWXBRVEQzUzhWM2JHblVWNmlqM0pMOU80VVQ4?=
 =?utf-8?B?MVZEdjkvZ1YyNE42WFpWRlpvV2o1ajRqcFpRNzRic2d1NGM3Tlk0Ymp0ZDdJ?=
 =?utf-8?B?cGx6OWRCd2Rqd2VUL3FCL2dLeGtFcmI5VDNSazl4UFZ1Qmh0NUM2K3dkd1Jv?=
 =?utf-8?B?eU8xWmZOVTk3cXVqdDAzaUdVVFhEL2pZbE9td1AzU1ZHaEc1QWNaZGVFZWY4?=
 =?utf-8?B?YWpZcDVpYkRHYklQcU1sQ3RhREJZKy9meS91T0hRdlQxQ2RnNDdpVlFrZlNT?=
 =?utf-8?B?TFpZeU5Tbkl2SnNwQUoxNnE4UGtINFNLbmJLQ1dibHZ5MGEyNEtBVXNJYTdG?=
 =?utf-8?B?ekZBdms4N3NVM1pyQnZ6VHNoVlVhcndwRjFoemJob3JvcmIyd25manFNVUZx?=
 =?utf-8?B?c0g0aW4yUVdFQ3BvOXFyWDNzVFhmdVNhSUxBaGlJVkczSFc5aFo4clMzc1di?=
 =?utf-8?B?YWlBelhaMjZiUGN0VmVNSWR2c1M2NTNINXhLL1dsNUc0aWxTb3dZRE5oNlNN?=
 =?utf-8?B?MzZFWXdKa211RnY1cEw0emdkVXZNWk81RVFEcHhqL2ZkbnF5ZWhCZlVsdm8x?=
 =?utf-8?Q?7k1SOrDtfss=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEVvbjIxOEJsQ1JuUmZmV01HZVdrQzNFZE9pRlh5Z3BLbFArSEZEdUdQcUVz?=
 =?utf-8?B?b2tZWGtHNjl0UEFkWU1BdTVvMklkKzBjSlVLTm1Tc01rVDlDNGdKbkJjNlhS?=
 =?utf-8?B?VEZvV1d1Q1dBcHNhT0FYaUdNNWF2UjZ1eDFHS0lPZXFLVzBzb0NCcWxNdHFZ?=
 =?utf-8?B?T1BSLzFiKzlzTFlveWNXU21wZ1VCM3RaZWlxTjJpMWFIdFI1SmdXSFFEQVBS?=
 =?utf-8?B?aGM4SVE4YmYxdW9ReFB5TjdCaEhlT0hWQ2Y5bGl3V2NoTzJnV1pXaVpPb0Z3?=
 =?utf-8?B?M1pNU2w4dmg1cjlncHFFWWV1RFMwSkJsWVdaL0tKcllycjdRS0tGN1hNTWg4?=
 =?utf-8?B?YVhJTTIrbUlqdTRVNGJqLzhFYkt2aFlzb2tOL05kU3pMV1d5V0hhMjhJMzY0?=
 =?utf-8?B?WnR1dndiSXdDUHJtZWdxNWpSa04yTkxWK1Y5MTJVLzIyVDV0QWw3YWFscXRZ?=
 =?utf-8?B?bWZza2pTS0NrZEEwanl0NGZqZUtqbFVaYytXdVJCZ2krejFmUWo3ZklOWWh5?=
 =?utf-8?B?WTlHK2ZKZWVINkMwTjcySlREOVV1alE1Y3lIb3k1QWdZR3pteldFN3EzRnNi?=
 =?utf-8?B?M0JVek9NSWR3YWFYZ08ydXNzYXQ2aG1zT1BQNDlVNDVjWHV2dytXWS9uS1dt?=
 =?utf-8?B?eWREM3VvdzdNbXVUOFZMQzNPRUx1MmZtUFJEZUFDbFVMYklKOG9WYUpMWmYx?=
 =?utf-8?B?VUY2ZnJhTFJ5a2h3UEhEai9tTE1VK1dnUnpYcEhxakZIVW9SWWVYTXFrUkpT?=
 =?utf-8?B?TG9sZng0NlU1V3p6VHhVdURReW1hU0Z4RWhubnRSaXMwYmgrTk9GMFl0WXhy?=
 =?utf-8?B?M0NlK1ZHL0VtMUIxK2JNcnFaUDFmMXphUk1VRXJsbElLQnFFbHFrUG82WDFi?=
 =?utf-8?B?eGlNbUFVZmRUTjJhVWlWOFQzNEhtSWVtQ3BNNnk5c2pMRFI5bkc4bmtRL2hN?=
 =?utf-8?B?UllhL3VxU2Z1VW1tTk1iRGcyMWRNTnp3VUJMUWVzdURaT0RsNi9HWkRTeW9m?=
 =?utf-8?B?cmg0K0RYRUVCQzhzdWR1M2t0UFdqRlFyeUR1T3N3a1N3dURBdzhOdnFPai9m?=
 =?utf-8?B?dkhNNXM2amQ3ZTRxNkdFOU9TZk9SYjVqb2JPZHVKMEpVRURyTmZUelFPbHN3?=
 =?utf-8?B?dmdvZnlKRzZLQ0xjdURnU2FncG5vL0hiMEs0R0Z5aXpjZElWZHBHS1QwM3NJ?=
 =?utf-8?B?a2tpTGNCbnlPYlptajMzVG9WSTlkZEpNOFM1b1FuN09kNkhHU25oRWk2NEg0?=
 =?utf-8?B?UWg4SGFWYWZBQUs2UnVacFQzMWZzTWZzdDVwVTNtUmhiT0VFTlY5YmdNbVdG?=
 =?utf-8?B?REUwbUtPeTA0ajQ5aUk5cjQva0tocWgwSEpyeHZYZndZcTZlbkdMUHhPWGFk?=
 =?utf-8?B?cmI3SUtkUS8zOER4VkJHWW9SNzdqVkpEVkUvUWg1YkZLQTBYL2ZYclFUVnpw?=
 =?utf-8?B?MXVSZ00zOUhTUjVZVXhtS2xuRDBPcjd5NFgxUEorRVR1SysxdFhROHVDVVVz?=
 =?utf-8?B?Mkk3MU54QjMrcE1mUDh0Yk1OV2JmcGs4V0ZzZjJwRS9kVGZNTFd0ZnE5Z3ZC?=
 =?utf-8?B?aHJOK0pzSUl1VGFwcjR6bWI5Y2U4WVZXZ2FZb1NtRGNsMFRNYWpCWnhad204?=
 =?utf-8?B?bEtWOXdmdjVKYnRBZ3hvSHI5MVRUZHFQMmFMNUJmellhTTBTK09Sc0h3SDlE?=
 =?utf-8?B?THZLamI3SGR3YlpJZHNDYlh2TmhZTlN1b0tJZUMxTXhqNWFadlh2c05RR0JB?=
 =?utf-8?B?QUZJVlBieTV3QlFzOEc3ZDRXbEdRVkVhU0tqaFJSQWkwajA4MnV2eUpFY1RJ?=
 =?utf-8?B?Qnp3KzQwU2x6L3Z6Zlk2YnltS3A0Q3VyU0QrVkRBZGQ0UHdheEZsKzRSZ0pO?=
 =?utf-8?B?LzBxZTVKSDZXQTdvRlZ5SkZPN0g2UDNZTGpSekxCWHM3WG1jNmllb1cwT0pV?=
 =?utf-8?B?QTFFSkdtSTBZZVV2L1BNaEZDQUw1Sk1wc2FPeC8vZU9LNkxCb2wyQWNWeklE?=
 =?utf-8?B?dkZjSkkxMVNHOW5qcUNWN1VtaitUUnBxZGpNYVhycDBBYnArNTdDcVhPbkJP?=
 =?utf-8?B?M2RjRFpvNllaYXVING9hZ3l2UEdXMndtMlAybnIxMXdSVXpDbG5heThjelNR?=
 =?utf-8?B?UVE1RWlIZ1VWVi9tSGdkYmF0QytqL0EzVGV6MThvSHE0dzkzY2x1MERLZmpm?=
 =?utf-8?B?Wnc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0188eb0-108a-4208-832d-08ddea9f6ffe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 04:07:46.2468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBvTlnrI0sLoQxuBTEoWHOKf3iC2cP2p2cyl+MdlKclRD9H1NTS5weUa7DzHQZIjZ9otLBMuOAo8S4866cQiRcVvv+/ng9Sjp7BJgCBgHgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5790

Hi Andrew,

Thanks for the review comments.

On 9/2/2025 8:38 PM, Andrew Lunn wrote:
>>> Also, what is a "link power down/up" ? Are you referring to setting
>>> BMCR_PDOWN and then clearing it? (please update the commit description
>>> and repost after 24 hours, thanks.)
>>>
>>
>> Yes, I'm referring to setting and the clearing BMCR_PDOWN. Will update
>> the commit description in the next version.
> 
> So it could be the bootloader left the PHY in powered down state, when
> booting.
> 

It is not just during initial boot, but whenever the PHY is resumed by
clearing BMCR_PDOWN and goes for autoneg it is recommended to clear the
downshift counter by disabling and re-enabling the downshift feature.

> There is some not so nice logic in phy_attach_direct() which calls
> phy_resume() when the MAC attaches to the PHY. So this case is covered
> by that. But it would be good to comment in the commit message, and
> maybe the resume function, that you are relying on this behaviour.
> 

For m88e1510_resume(), description is added. Will update the commit
message and function description in the next version.

> I do wounder if it should be more explicit, m88e1510_config_init()
> also calls the workaround? You would then not need the comment.
> 
> 	Andrew

Best Regards,
Rohan

