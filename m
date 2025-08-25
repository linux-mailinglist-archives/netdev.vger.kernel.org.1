Return-Path: <netdev+bounces-216605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDC1B34B13
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 21:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DA817BCB1
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 19:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DFB1F4C85;
	Mon, 25 Aug 2025 19:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="ZBG8UkYd"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBEF283124
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 19:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151117; cv=fail; b=bLexHD13mU1Xu3KTCkCQTh842FgPPZGMK0r/KQoBDuICsUsjaZlKBIcYOMSmA+5vkLh1Kr3xKaGVZniZauYmb9bUNSfjUIp6z776qyCEcs1NQoOs+WnwcTAfrhulsHzkSbd0nCz+dHv0f1CV53EsiObvakrIaUyhGma3r6eE3Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151117; c=relaxed/simple;
	bh=9tIpwX35RdcJiM1XXrzjJCyB1Ox3WTcHvIoGLWqx+Sk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RS3f6sLMQvBOPK4mB/Ry7P48PcIvfvqM9v4vCd0at4nvrcB/i5P41Wz6FyhVB4g5C9kiC+g5x1iMUHVBwWLuersABBJVUP9A6zOGnqXyoHLfrJ/sNfrBLaaVR4apQkR5qoznASWSSv1OAyi/O02C5vOB5zIzj9JBllB5xY398gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=ZBG8UkYd; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1756151115; x=1787687115;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9tIpwX35RdcJiM1XXrzjJCyB1Ox3WTcHvIoGLWqx+Sk=;
  b=ZBG8UkYdbFu1ia7o7dkc0waJu0bbmzAXrpDJFlCkd5Z0pdlP/vsaOs0m
   hPeFw04ARNFz7FT5dPjGDNw44FPnq8C6cREZ4ij4cVXJB24AkKDCagnFe
   Xr9MThItX9WbfU4JYeqS4leF2IDfNlyJhz0ON9yyLbCo/yZUMIfkcXxmv
   w=;
X-CSE-ConnectionGUID: l8DLHOkXQzmOAC2/efOyFg==
X-CSE-MsgGUID: Bq1GMqMYTRGQxzYrBK2mDA==
X-Talos-CUID: 9a23:/y30027TX4dTY9fgGNss8B44PuACcU3k3nL3CmTiTmtnb6y7RgrF
X-Talos-MUID: 9a23:TcJWkgoLqal2YlyH6skezxt7behN+oGfNHoiqIUUitOuFnZ1Fx7I2Q==
Received: from mail-canadacentralazon11022129.outbound.protection.outlook.com (HELO YT6PR01CU002.outbound.protection.outlook.com) ([40.107.193.129])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 15:45:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1pEncPyn/vNO1DwOEVclCClQsm0cD+YxRrgWuHTKmW+oILaWS/F83NHQVyUIjqeJoUloI7S1HKYDYqgwjVd/+7Y0xNDzGojA0h3JpLLFg8POO1Ef55m9JekYsHJooTzSh+pVg2tWRL5l5QAtgyijUqj2O5CMAGZKwozoD/8qTIkPoNLd1Z7Lu8EAHsWCmYTqJEZN8dFvLAAgG6if9wN0UScT/iTAiooMIhOOY4tRop8GGJfdZmEIWzf0ByeMPFH1RcyYtEPoud597YVUQwU0WUSsZbMfUXndigYhtXMz3pT8HjROHwqa8Tz2esakg7uyqMdkNwBKjkvOLFuzpSklw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jd7EMzNI0BnLfRPCSClJjEkA6PFP+juk5O/ngk6vHQ=;
 b=B4F8ozOuECXNakXtTIEvdcq6+W2WP7wL201AHXVSu0RLTabX91xtu7aoa9ED2kCpxqi930vdRsnK9mKhMJz/qV8zxG4hb/qrPoeeOXPNBoJiujdwDSjibhzZ+LSoGgfr/FWuASkXCxv0illM29FeBHuD4t1N3TNHDenwVIUK5kMN5R4RE9Vsi5Z4VYqA54YuAf3k654ALV1SEabj+lJ6ZN/vj5orMdgqVvYOyr4nhgxkJTrLZCZXd9amZ9Jh30LKvCBdo+wjkWqicuddZd4c3VlRqteej/uxz0GP4BrByw6oE5q3j2I7pB9Ah5GAVnBjo38DyEDLXi5iJuwtzh/M+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT3PR01MB6566.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:71::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 19:45:07 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%2]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 19:45:06 +0000
Message-ID: <fe42bbef-047c-49da-b9ff-a7806820ae0e@uwaterloo.ca>
Date: Mon, 25 Aug 2025 15:45:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 0/2] Add support to do threaded napi busy poll
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com,
 Joe Damato <joe@dama.to>, netdev@vger.kernel.org
References: <20250824215418.257588-1-skhawaja@google.com>
 <8407a1e5-c6ad-47da-9b41-978730cd5420@uwaterloo.ca>
 <CAAywjhT-CEvHUSpjyXQkpkGRN0iX7qMc1p=QOn-iCNQxdycr2A@mail.gmail.com>
 <d2b52ee5-d7a7-4a97-ba9a-6c99e1470d9b@uwaterloo.ca>
 <CAAywjhStweQXMcc5LoDssLaXYpHRp7Pend2R-h_N16Q_Xa++yQ@mail.gmail.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <CAAywjhStweQXMcc5LoDssLaXYpHRp7Pend2R-h_N16Q_Xa++yQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0092.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::26) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT3PR01MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f2f6ca-bb1d-440c-0a2e-08dde40fe480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlYxaDZ4QWxQS1QrdEFZSDlJS3haemJtNmMwRGZoZzk3YXRyRFhoZC9qb29H?=
 =?utf-8?B?YTFabEFPVVllUWFNOTB0S29CelpybzJrS2VrRWc0N29LYStUa2lDRlg4cDNZ?=
 =?utf-8?B?Z0pEcFdYeGZFMWs2YjYzeTNOT3ZLRTdCQmsyeVlxT05LOGh6R2ZTYUJ1amxJ?=
 =?utf-8?B?R0k0a21pL2pHUzBIOXFMTnpINU1mcDlHcEFWZWhZSmVrVk54aytiK3JRQ3JT?=
 =?utf-8?B?TEFxNTNkUUFIYTRUOWlENkhzM24rNWkzMUEzN2JuUWt2TVlnWEFHaDNVa1pi?=
 =?utf-8?B?NktzdEIxdFZDVDlkVnVVU2UwQ2pLMDNtdWNrQVZaSC9NcG5XRFJ4ajViVWdB?=
 =?utf-8?B?VDg2WW9lNTgvc1lWbFBtWmFyeEQvZjNRUW5tTkhiSUxmbDZVVjlIQk50RVBy?=
 =?utf-8?B?R3dsdTdINXRSaE5WOUhQRlZRL3B5QTV6cXVXTndobEZORTdOdDh6YTZXaVp5?=
 =?utf-8?B?TDlqOVBCVGViaVUrMVc5UndqempPV0MrYURNbE9rMmxhNld3cEMzcGw0dlNw?=
 =?utf-8?B?K0ZLb0cxeW5pakFCRkhtRDdHb25TbDhENklOMk03UFJ6aVZXUEFxMFRiVFJ5?=
 =?utf-8?B?Z3hZUlFhRGxEMEdGWHVRdlVrNFc4YjZEZ3F6NXA2TnZBZnBMM2labEpKMmRl?=
 =?utf-8?B?SWsvTTRZdTJrTkRDUzUrM0pSR05rNjRRZVpZOU1BWVpxaWRueTl4M0E3cndv?=
 =?utf-8?B?cVE5MCtGWGVBVXc3SFFBTklJWFpDMHpVYmpWYWhkOEVWZnVyY1VKR3pQWE10?=
 =?utf-8?B?VHNadTVLalhjRmFMaWdVbjUrTlpHSlNLaUp2MExZUloxTEcxSjRpNDM4LytU?=
 =?utf-8?B?Tmo0UEVDV2lZS0N6MHM0ZkZCb2RMOHU2a1Y0ZnpwaUhXaExGWm5pTDNYN0Rl?=
 =?utf-8?B?ejZCVUdEam11UDhsWFlrVDNHT1ZmRFVyU2dRRXRUVkhtUnBRMk5YYXBsYi90?=
 =?utf-8?B?ZWVuK1dTVDlzV3M1cGFaRklCTnBYMTd5Y3QxMGtHY2tWTUVLNFFXR3RBd3pz?=
 =?utf-8?B?Ynl3Y09jMDFUMzRrNUE5NHVuNHJ4OUFmOEh6bFdkTFMydk11M2NYZjJ6V0NO?=
 =?utf-8?B?ejFab1NFWEpMblZOaU5IUmVZMWc0K3ZRZ3JobmdtbEdmTmhSOG9zVTVaa2w4?=
 =?utf-8?B?Qi8xb2FGY0dYekFHSEZwaTZXVy9Fa1NhMzNHc0pkS3IyaDVuZXA3RTdzR2lQ?=
 =?utf-8?B?VGNEdHcxbjB2OWUrcm1FOHkySm5RZTVvdXlhMTJZb1M5MWxZaFIrZWhBajlM?=
 =?utf-8?B?Q1BleDFjZlMvUUoyZ0xUZXJaWTQxNzh2UlBJd29zb1RhWkthRWRUVDNXRmJ3?=
 =?utf-8?B?UlhTb1NBY1BHRzBITGJvTEN4dndJS2wrVjQ1Ui81NFVCSzRmRk9CN1NYNG92?=
 =?utf-8?B?eVV1cGhOL0JGNTd1a1RYZ0NwQ3k2ckxBWkt5MGZpMVVFOWZ4RDhWRVJuNkRV?=
 =?utf-8?B?V3l5c0R1NVV1dC9PekM0SHIxSDl1ZTdUaUc5VWQ2YXVlZGNtd05vSkhaU2hl?=
 =?utf-8?B?Q0pVTHBlRGpmbkpxVGx0cWd6QTN4WTV6VUtORG1JVTlyOUFlWVhCN3JCYnJv?=
 =?utf-8?B?UitHcXIyMDMvbmtqeEJpbENKL3RwdEZlS2V6N0pMOTdFQ2htc1dWeXg4S0Rr?=
 =?utf-8?B?bis2WlRneG9DUDdBdkFOWU1Rc2s3U1lIV1pCTmE5dmFzV0FLKzhTY0pSSG1h?=
 =?utf-8?B?ZUk4OSsyOGNLVGxYa3hrM2JlYm10b3hveWVGby9iTU9yU1BQZ2RUSkJLa0V1?=
 =?utf-8?B?Z2wwejY1bVdhcWhlRUlaMlE2c0FaRE1GWWlRVVBBd2NLemt4TUlPQVZ5bU44?=
 =?utf-8?B?ajU5VWorWCtxa3A2K3p1N1JjcUlGVEVXMGx4Y21EbmViZGlHZlBIR0E5RWN5?=
 =?utf-8?B?WU8yOENVYzZpZ2tieGFtcGNFSWo3ODNORkptOXFDWXJuNjJ4cmk3VTFuUFA2?=
 =?utf-8?Q?4EuRpkoMMmQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkduZTFEK2NWc1FKMDZCS3c5V1lKdmxjWEdONFZYZlVickFnL01DOHFwVGNN?=
 =?utf-8?B?d3BrWEN1dWdjeDdRNk9OL0pwS3dZaGVmNzJVd2Y0RmwvOUFkRUI2TUJhbjhE?=
 =?utf-8?B?YlRseE1LSUJGSW1aeGt5SjZFNytwMStya3ZaRlR0b1pITkpDUGpvWmpObWhL?=
 =?utf-8?B?RnFGaFEwaEdFdEdjYUxPWE51OFdDYUpyRzJPM0dnd1JlalZuT1NkUU9meEJQ?=
 =?utf-8?B?MUVLWTExcERkbzV0aHBYMTdnVUo5OGtNNWpOb1AzS0YvSURXSmVBMXlpNkhW?=
 =?utf-8?B?YXArS2JjRXlmUDRpZFZicjRibGFLb056dVB1SDNzK2NJenkzcEN2SU5TMGhC?=
 =?utf-8?B?WlZ2R3g4Ukl5UkVJS2N6dmRFUy9ocktTNGMwRzRhNHBMVWR1OWx5dG9aN0Uy?=
 =?utf-8?B?ZmxYQ0Y4ZmFWNWxIb3JnK3VYS3dNZjY0Sy9KVmxheVRwWWlmbWphcGFkWG90?=
 =?utf-8?B?eGZ1TmhWclk0QTJ6Tyt6YTFEQThraW9WQmpqOUI2VjhuSENZVFZibEJGRk9S?=
 =?utf-8?B?NkFvZXBiYTVlQklPenVHK01JRzNDdHJwR2lsekJyUWpQZlVqMkZtN3VqZVNv?=
 =?utf-8?B?amdaMTJiUHN5K2cxbXZ2SXdoR3c0L2hlOXRwLzJycFJVRlV3cEtFM08vNmc2?=
 =?utf-8?B?RHMwYkJuT3MxVzNOQ1VnM2toK1oxU0tWcC84bDh2Zm1SWUFjUWhpQ2wybzNK?=
 =?utf-8?B?T3RROTFiNm55ZGRDVUZXQnhhL0IrODZyWWVLdC9vQ3h1U3AzRjRHVmlMYnRm?=
 =?utf-8?B?VWwvd2V1SVdmaWp6QzdEbE9VRlRLUnZvTk55LytBa0NsK2hJbENsS3JzVi9Q?=
 =?utf-8?B?a0w5bSt4QVhUY3d0a0F4YXdXOUxRZnE3blFGQkF2MzFTeUlVaE5SMm9RYzhT?=
 =?utf-8?B?VzhjK3RqVnY4S2JxM2FNejNMcERKVVdPZmxrd1NrSHJwcWFqaG1nckJPSW9R?=
 =?utf-8?B?cXowZVFiK0U4Zkg4S09Jdlp1R1BsY0E1Ukl6am1FUHV5ZnZqSnRqVi8xSnpM?=
 =?utf-8?B?VmJDNE53R2F4S3ZNdkRYYXFqVTByRXFidFNQcDJ0bmg5Y1F5YmpKWU9RbFlj?=
 =?utf-8?B?SnVvYTJJbjFYT2Nzc1kyMUNiSDlRL1U1djY1dFNOdk1vOWpBdEg1ZlgzTmVl?=
 =?utf-8?B?Y0NmM0J5VGFyT3Q0dFdmVTJUVDYwaFFVeFZQUG5lbE1GaDRFT1NGVEFFcEhG?=
 =?utf-8?B?WkM4dDBSK3RzK3RobG9ScEVwSzRwTVBsdEIvQVdUeWVlbWF6OWtkbjBSSGFt?=
 =?utf-8?B?RkF1TGh1dVhqOUNTaXRqRGdrb3lpWmVUR2lLVkFVT3hsMUZEb0o3R2dVc1Q3?=
 =?utf-8?B?SWRvWkMxZ2tKZUFhc0c4bTdkZU1jbGZpMUpaTzl4QnlCSE5HUVV1cS9RNFdh?=
 =?utf-8?B?K1NZTGMrWVdmVndDVW1jd1p6VUJjcm41dytLdlBQN1FYamthSEcyTHpPd3Zw?=
 =?utf-8?B?cisyaThnR0t1amxSTjJOeXVHVWZkTzVDS0RXMStKT3RaSVRDdXIrNGE4T2ZZ?=
 =?utf-8?B?L3BobkY0Q1JtL2JxQ3JsNXlYemxUY0xmQlExbVFETkJDNFZZRDV1eVRyMmVo?=
 =?utf-8?B?cmNNeEJHVEg3dHBlb2ZzcnlQdU9CYnpnSThGWVZCdm1DTkh1VnlZZHRscW9i?=
 =?utf-8?B?amlQcnFJdDQ2Ry9lRXBKM3RtNTlzYmZBZnpRc21UQW82S1ZWcmJVT3hiaFdI?=
 =?utf-8?B?dmxGN1FFQ0k0MmZPMUtaQ1kzNFlmdlplRGQ4VTlQOXhPUTk0ZFowWGNWeEp1?=
 =?utf-8?B?SSs3N3RFRFVvbGxCWE84aE82SkVWUkdsNms4NktseE1yTTB5dVJ1U2JqeXBo?=
 =?utf-8?B?SFdIWFZUZWRzNm05UGcxY3V4SnNnUmR2R2F2b21vaTArL1ZVV3NXL3UvSVF1?=
 =?utf-8?B?TTBXbGcvdnVGSVRoTEkrU0hsQjJYcDNUVjhuZ1FkS3lwdHBVR2R0SWR1djht?=
 =?utf-8?B?QTYycjZZcGJHdFovdjRBdW9RZFozampFM0VLN2JSbis3OTRycDF2Mkpyd3hJ?=
 =?utf-8?B?Vis0RzhwaElxeHZmc2VwL0kxZ04rMWR6NXpUUmZiMWFWeDRoU1JXcGNHeGU2?=
 =?utf-8?B?NFlFUlh2d29jbVdCMWhHdmRtbWVzUmhaVHM4VUptMFRKMVhBQWxLWnJoWFJE?=
 =?utf-8?Q?yXg74xo/M8qT6eVRWdMH1jL/v?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CZGlWg2zxjip8h5OcokWLI7cBTXwNx3ShakuLLWD0yjCVWGv+fI1viMZQYG435B37GKOB+WuQdc7aP9W6fpbPQPKKfc0YXvpH/1Z0vgwx5nCfLfd2lq1Y3OJ3s+mCdt0q20Gdlywh2J9D61HksRiaSHzUtDu3f/kEferIYIfrXTk0IqDK0a11OyGloTIljwEsbXnEV3QLqyEZscyvBXb1SgC1/xNZJNdVKAMXnRexfQ/gfrNVvtuUN+l4kL3GHiQYQnhko7OBqEXIjXaVAn9GOdumjEhoCKQhCU8CzdrClwCG+dv0tuBOcBBSuD5YR3gmbj5FDr1Aq4AyGKyt03k1q2byhJioic79ra+IEBiud3vj41BBmDMpJE2Yq1t4D5UAiXNh7vev0a41E6JKuey39nv1SaubS5ZYfShojXGGOGcPYmmmFMpU8ssecPFYIevvrcAwrBijRrhQah72W0+/wg6wjSD9EwgRlrYk/Z+BDAeG7gOLf6Mhkv2zgvfzcDCw0WMOj/SkEddgqlbt6Npg5+xebtT0/tpslKtfriBNUWo/f3ACzig4DTSXRuNuNHW3U6iM6FJfsiwSg51SZkNX4zh+484ZOGop2L73ui/gU0LelF9YIQoVLRfPjDNwT5d
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f2f6ca-bb1d-440c-0a2e-08dde40fe480
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 19:45:06.7318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zxvhFWu6GrTGq8NfosYo4OYRdgs9V36phZp0VWZPTSKfOoUSslFLpna5B1Y9FRxEbCIQGULP2VGlyIWw5Ux2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6566

On 2025-08-25 14:53, Samiullah Khawaja wrote:
> On Mon, Aug 25, 2025 at 10:41 AM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
>>
>> On 2025-08-25 13:20, Samiullah Khawaja wrote:
>>> On Sun, Aug 24, 2025 at 5:03 PM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
>>>>
>>>> On 2025-08-24 17:54, Samiullah Khawaja wrote:
>>>>> Extend the already existing support of threaded napi poll to do continuous
>>>>> busy polling.
>>>>>
>>>>> This is used for doing continuous polling of napi to fetch descriptors
>>>>> from backing RX/TX queues for low latency applications. Allow enabling
>>>>> of threaded busypoll using netlink so this can be enabled on a set of
>>>>> dedicated napis for low latency applications.
>>>>>
>>>>> Once enabled user can fetch the PID of the kthread doing NAPI polling
>>>>> and set affinity, priority and scheduler for it depending on the
>>>>> low-latency requirements.
>>>>>
>>>>> Currently threaded napi is only enabled at device level using sysfs. Add
>>>>> support to enable/disable threaded mode for a napi individually. This
>>>>> can be done using the netlink interface. Extend `napi-set` op in netlink
>>>>> spec that allows setting the `threaded` attribute of a napi.
>>>>>
>>>>> Extend the threaded attribute in napi struct to add an option to enable
>>>>> continuous busy polling. Extend the netlink and sysfs interface to allow
>>>>> enabling/disabling threaded busypolling at device or individual napi
>>>>> level.
>>>>>
>>>>> We use this for our AF_XDP based hard low-latency usecase with usecs
>>>>> level latency requirement. For our usecase we want low jitter and stable
>>>>> latency at P99.
>>>>>
>>>>> Following is an analysis and comparison of available (and compatible)
>>>>> busy poll interfaces for a low latency usecase with stable P99. Please
>>>>> note that the throughput and cpu efficiency is a non-goal.
>>>>>
>>>>> For analysis we use an AF_XDP based benchmarking tool `xdp_rr`. The
>>>>> description of the tool and how it tries to simulate the real workload
>>>>> is following,
>>>>>
>>>>> - It sends UDP packets between 2 machines.
>>>>> - The client machine sends packets at a fixed frequency. To maintain the
>>>>>      frequency of the packet being sent, we use open-loop sampling. That is
>>>>>      the packets are sent in a separate thread.
>>>>> - The server replies to the packet inline by reading the pkt from the
>>>>>      recv ring and replies using the tx ring.
>>>>> - To simulate the application processing time, we use a configurable
>>>>>      delay in usecs on the client side after a reply is received from the
>>>>>      server.
>>>>>
>>>>> The xdp_rr tool is posted separately as an RFC for tools/testing/selftest.
>>>>>
>>>>> We use this tool with following napi polling configurations,
>>>>>
>>>>> - Interrupts only
>>>>> - SO_BUSYPOLL (inline in the same thread where the client receives the
>>>>>      packet).
>>>>> - SO_BUSYPOLL (separate thread and separate core)
>>> This one uses separate thread and core for polling the napi.
>>
>> That's not what I am referring to below.
>>
>> [snip]
>>
>>>>> | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) | NAPI threaded |
>>>>> |---|---|---|---|---|
>>>>> | 12 Kpkt/s + 0us delay | | | | |
>>>>> |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
>>>>> |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
>>>>> |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
>>>>> |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
>>>>> | 32 Kpkt/s + 30us delay | | | | |
>>>>> |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
>>>>> |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
>>>>> |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
>>>>> |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
>>>>> | 125 Kpkt/s + 6us delay | | | | |
>>>>> |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
>>>>> |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
>>>>> |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
>>>>> |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
>>>>> | 12 Kpkt/s + 78us delay | | | | |
>>>>> |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
>>>>> |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
>>>>> |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
>>>>> |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
>>>>> | 25 Kpkt/s + 38us delay | | | | |
>>>>> |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
>>>>> |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
>>>>> |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
>>>>> |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
>>>>>
>>>>>     ## Observations
>>>>
>>>> Hi Samiullah,
>>>>
>>> Thanks for the review
>>>> I believe you are comparing apples and oranges with these experiments.
>>>> Because threaded busy poll uses two cores at each end (at 100%), you
>>> The SO_BUSYPOLL(separate) column is actually running in a separate
>>> thread and using two cores. So this is actually comparing apples to
>>> apples.
>>
>> I am not referring to SO_BUSYPOLL, but to the column labelled
>> "interrupts". This is single-core, yes?
>>
>>>> should compare with 2 pairs of xsk_rr processes using interrupt mode,
>>>> but each running at half the rate. I am quite certain you would then see
>>>> the same latency as in the baseline experiment - at much reduced cpu
>>>> utilization.
>>>>
>>>> Threaded busy poll reduces p99 latency by just 100 nsec, while
>>> The table in the experiments show much larger differences in latency.
>>
>> Yes, because all but the first experiment add processing delay to
>> simulate 100% load and thus most likely show queuing effects.
>>
>> Since "interrupts" uses just one core and "NAPI threaded" uses two, a
>> fair comparison would be for "interrupts" to run two pairs of xsk_rr at
>> half the rate each. Then the load would be well below 100%, no queueing,
>> and latency would probably go back to the values measured in the "0us
>> delay" experiments. At least that's what I would expect.
> Two set of xsk_rr will go to two different NIC queues with two
> different interrupts (I think). That would be comparing apples to
> oranges, as all the other columns use a single NIC queue. Having
> (Forcing user to have) two xsk sockets to deliver packets at a certain
> rate is a completely different use case.

I don't think a NIC queue is a more critical resource than a CPU core?

And the rest depends on the actual application that would be using the 
service. The restriction to xsk_rr and its particulars is because that's 
the benchmark you provided.
>> Reproduction is getting a bit difficult, because you haven't updated the
>> xsk_rr RFC and judging from the compilation error, maybe not built/run
>> these experiments for a while now? It would be nice to have a working
>> reproducible setup.
> Oh. Let me check the xsk_rr and see whether it is outdated. I will
> send out another RFC for it if it's outdated.
>>
>>>> busy-spinning two cores, at each end - not more not less. I continue to
>>>> believe that this trade-off and these limited benefits need to be
>>>> clearly and explicitly spelled out in the cover letter.
>>> Yes, if you just look at the first row of the table then there is
>>> virtually no difference.
>> I'm not sure what you mean by this. I compare "interrupts" with "NAPI
>> threaded" for the case "12 Kpkt/s + 0us delay" and I have explained why
>> I believe the other experiments are not meaningful.
> Yes that is exactly what I am disagreeing with. I don't think other
> rows are "not meaningful". The xsk_rr is trying to "simulate the
> application processing" by adding a cpu delay and the table clearly
> shows the comparison between various mechanisms and how they perform
> with in load.

But these experiments only look at cases with almost exactly 100% load. 
As I mentioned in a previous round, this is highly unlikely for a 
latency-critical service and thus it seems contrived. Once you go to 
100% load and see queueing effects, you also need to look left and right 
to investigate other load and system settings.

Maybe this means the xsk_rr tool is not a good enough benchmark?

Thanks,
Martin


