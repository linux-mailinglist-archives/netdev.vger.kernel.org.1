Return-Path: <netdev+bounces-220232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F402B44D94
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 07:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29060164E9D
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 05:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDB422422E;
	Fri,  5 Sep 2025 05:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J6x49k3s"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F1E169AE6;
	Fri,  5 Sep 2025 05:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757050548; cv=fail; b=r0thp8+tysJ9NN1Hp9hpjFfoPnQBoWw1vMj4UwTzAUbBzrK5af2m+fKqZElXtQmUtN37OHWWnNoUixm1/HmtUCS/YR1WC6sAgTlUIzXdrdHsFzD7iqWnARPJvuH8vJzbyJXD1fWaASPflIGj6AW9pCiAOh/Pa2SbIA1N2gMGATw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757050548; c=relaxed/simple;
	bh=QAwrTZEy+abBzAKQXolX7i4dcZdzRylyOQqsnldzyDE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eXZ4IR72bi7kfxjF8ct8FQy4KHBB3zcTFEDfn4HjGEkyZx6AmbcyPeWa2AMdywM1Zxk0afO/kEskmyzKh1w8irBuKLoVs61l39xOLls3Et6AzMvmZ4D3wXTKLN/umiuoNXK/M0GHy2XwOAGp6NvusuI3RvNA/vG3VOQ/x0QWyks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J6x49k3s; arc=fail smtp.client-ip=40.107.101.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHVt5KYw38XBiQwlOKI08dhDQ+4A37ijwh+8+nV+zma/mybOZUS/s4N1D6oqGVUUmZn0hp94x9ptNHtY/CAZGTz8J8fedIrSgUqq3+FNI/XI2L+AOMZRorUF6IzuFkzgFAZhON/XyBDeX7ywLdfGioWGN8viAmJl1G3OnHdViqIsF45ZpPPXuGjpXdu2hlnZ7vNiFnXkme+c1/yZiU5DnQVCNTwyAKL0/nBKIgAo6jRpKk4niJAAwEcQ/eJQgyDwdjTpcjZvYoeKHvACMfqqRSpiGslr9rw/vir7A3lepE6iUL4BllFWYDJevhHDXz9WDHy9ThkDabrBxvy69P2eIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAwrTZEy+abBzAKQXolX7i4dcZdzRylyOQqsnldzyDE=;
 b=TU6tULQOWSbpwEIllusqUHPi60McwVmGx7B+7pwt8JBUUovgsKlLh3LJNoFJQ8cR4j4Hp9Y2HFmA+RqfyvVlTMWVmGuDXi8zMm/XiBbrVhgVQ+M38+i5m/MD7GaEkV0GkjNycqdGoZsg/PUhOmYVH5IDZ5YJ5xiIxxCpGjHVly3q+U708G+EndqCTxpn+pPajy82obudPoxDiLRtE7jFTOPhHICPeqs80TKunjO2HEZh5LbbLd2/89j9jSxy8Ls8PJ+Rh5ma80x2niuIyLyu9qvTqWGslWbXZojF7fyJQKWB0N4czXsOVXjzvJPbW5tBTgyNeCxCgK7P80mZGIz04g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAwrTZEy+abBzAKQXolX7i4dcZdzRylyOQqsnldzyDE=;
 b=J6x49k3sYjvmuMO9pI5jw260dwt+YkkEEOboUw+qWk9nmVuVMrvEJt/AESUWyupfjNQCA2/QjNX7nNFIFEp1gWUpLYnPYMRPiTyu3OhjPb+AC/BTMouUzzq+RpT562rGpegwa2Ga9uiDM6g1ucgnGZJW66datu9z7ujn8c648wkiRub7DxRtTtmWYged0VGQCPyKfW5c3DJlzVGCvbI9Gx9z4jdjYEmGkhnySOOEZqqQYWiU6XENTKv75CnDKpUeM6gDOswA1UANVHN7BpzR4btSJOr0Ku63E1RKy2XfxZlNCBWQgNfR9IwOwwWU/EldyF72LfUi+88Bt1xR4ThCuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 05:35:44 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%5]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 05:35:44 +0000
Message-ID: <154e30fa-9465-4e4e-a1f4-410ef73c04cf@nvidia.com>
Date: Fri, 5 Sep 2025 08:35:37 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dev_ioctl: take ops lock in hwtstamp lower paths
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>,
 Kees Cook <kees@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Cosmin Ratiu <cratiu@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <20250904182806.2329996-1-cjubran@nvidia.com>
 <20250904235155.7b2b3379@kmaincent-XPS-13-7390>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <20250904235155.7b2b3379@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|DS0PR12MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: 78bdaf2a-c6a9-4f92-6239-08ddec3e0eff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1BzZXhCVG84aDZ2QTJpbGw1N0U5WDNHQ29ob1l5emlzNUV0NFRtRUc0QXJK?=
 =?utf-8?B?QnZ3Qmk3VmtWNk5kSEtXRnZzMWNxekZyOEFwVFJydFdtRVU0ME9nR3ZYRExQ?=
 =?utf-8?B?Zm8rclQyTGVaSEh5bDFKYVNiQ3pjeERJK0JHQXR0cjJ3RnhINkxiQnRFNVFw?=
 =?utf-8?B?UzNGc01OUE9uUFNPYnJaK3VuMDk3aVRURjJmMjlNMzViVTVkdXlBSzhZb0M0?=
 =?utf-8?B?ZmRESmw0L2R0SDRJV3BNa2EzRFFzRkN3dm9BL1g0OEJIQkVwMmN5Vk9jZVVn?=
 =?utf-8?B?enBVODRxOUdqUWNza2RUZ09xbkpIMHhDbUExNENteE1HOFJEbWd2QjZBL1Rk?=
 =?utf-8?B?ZlJMd3ArL20ycVJqNGJNYVkzS1kvQWMxVnpnMFhwQW4zQU5OVWo5QXBQTVN5?=
 =?utf-8?B?STQzYmpaRzRKT2V1V2ZKeGlldGFnQlZLSlV5M0grQlVrVEUxVlJxdE5kM250?=
 =?utf-8?B?a2IzQjVNNE5lRUhBWWlGSGlTbVlvK3oyaWEvWHdCampnQXlTUWlTdGkwWjlm?=
 =?utf-8?B?SFFGS21ORXVscVRKMHRyRXJ4V252OWFybTZscFJVVjk0c2V3SW1Oclc0TE1Y?=
 =?utf-8?B?WmtWL0g3ZS9jU0VTa2FTay9DZHFXT0tMSU5xSlVlRFRWdXFqVUx2RXVPV0k2?=
 =?utf-8?B?RHRPV0lnZS9MaEhnRHZhRExzb091RDVYcUxOOWNUMExSN1NzV0lGVXR2bjhw?=
 =?utf-8?B?UHJRSG9TNDZZV1VIYVNYbGR0K25hQ3NYZFJkSjhZVWNIcjljSXVxQjNGVkF2?=
 =?utf-8?B?Y21CSVRnM3hEc1B6YVp4MmE0TEVuMTQ4NmJaamdYdUZIVmFNaGowY3Z3c0RQ?=
 =?utf-8?B?MzJWY2V3K09EajMrRGlmaWQ0R2pwWllBS0VtcnNqWm1LOGZTMFRkSEFnVUpU?=
 =?utf-8?B?Zk4rbXh5ZEF1QVpMSFdaY1Mrc1hJV3JISFp2YTNHckVmWGpEYXd6UU9IZ0pP?=
 =?utf-8?B?QmJNczU2Y0xTT21qMStzbytxRVY4c05kNjJ1NnRzbktZZXZvYlM0dzlTYzNy?=
 =?utf-8?B?bzB6elM3TURsUXBkYWJqK0N5OHcxMzFKbEdzSlZuM3dzU2tRcWlySXBhalA1?=
 =?utf-8?B?bks1ZGtxQldzRzdLb3RqYldQWmluMkprNm03TUovbm1mTDBybk8wOTF2dG00?=
 =?utf-8?B?Zm9zU3RpQnplQ3FobFQ3WVljMjJRMTdsRHpSbVBiTTB5ZTNCc3d1RHJ2UGho?=
 =?utf-8?B?NkFQWW9EMXZPUDRXajNYVVRSYXVUZVhqMUNVcmQ2TTNSOE9kVTFxRTVMWDVa?=
 =?utf-8?B?Sng3UG9ndUplb3NoUmRZUmVGaXkzNytlN1p5bmJaRHRLTE5vby92WUtSNnhI?=
 =?utf-8?B?Y05MZWhQWWJNZVpNeXVnSUgxY1BzMi9ObzlYajc0Q0YvQnNBeHczZFVERDh0?=
 =?utf-8?B?Uy84YmtKYTdUblRUVXpZU0ZIZXRybUJrZFZvNjE4eDJ0MXgrZjRrREIvM2Js?=
 =?utf-8?B?TUx2OGtLUE4xcHRXUGNzYTRTbHQzM2t2emcxQ0dDMWRPbFd6L01ranZQSzdM?=
 =?utf-8?B?eTBYY3l4eEVXZjc1NzQ1cmMrM3JDMEtvc0s5cFFUZkxiL0doRnZOaGJONXd4?=
 =?utf-8?B?ajlFTG1RajdqK0FURDRGakM5WlBCMTRmUlNpL0RDbm1zczRZNlRWS28vSDN4?=
 =?utf-8?B?aGJlMGFFdFZYL3BPWW8ya1EyWjdmZXBlYy9mUm9vM2t1bkYxY3RzNzk3K0Y5?=
 =?utf-8?B?OEd3WmtrRDJlTEViUnJjY3RZeFVqaWhmeG02S0Iycmp2QW1HVzhnQ3NBRHJT?=
 =?utf-8?B?RVJPK0tLOTNSMktockFwc3UxWEgySnNqUGVaNnZiTDYzaXdIZlNxb1lQS2tC?=
 =?utf-8?B?VEl6QXVZT1c1UkNmanJxL3dnSmM4K1ZnM2lhbmdEMjVBNzZzRlU1MlIvMkNL?=
 =?utf-8?B?Zk1aMFZKUmhrVGdzL1d0QzJSRkR3UUNubmtCVFRVRVQ0Z1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVorcHA0VXpKK0lVUisxMGRMTCtNOWh4eGVSVXYvQ2xCWHdWa0dOL1FBQnJN?=
 =?utf-8?B?QXRvOXoxbG5JZG8rVjNTWVF6NUFxTXRiT1pQcUNtelNHTGlEeG5mWVdrdUU4?=
 =?utf-8?B?czRhdjZpQzNGWVRvU2RJTHduQyt4aElIL2FKbUJBaVhlSE9jaTJFWkUwY3hw?=
 =?utf-8?B?ZEk2SWxReW5veG5TdjQyeHQzdFRtM2x3QnluT2ZTZEJZRlBaaVZHRnBJdDh1?=
 =?utf-8?B?amFZT2FBNTRET3pabFlSQURuV082M2xEUVZDV2RUbVZSTDBCUTd6MGExdzZl?=
 =?utf-8?B?SHh3M3FOT0ZyT3pEVlhUU2JINjkzYzRpWWlyZTRUNDQ3SW40WGJhcXE0cUg1?=
 =?utf-8?B?U1RjS3RJcFFVTUtMV1ZHYmJtK3R3L2dObXpNak41UmxpdGdaTHR1NnU0U3Ru?=
 =?utf-8?B?Y1pLL3Y5Y3l1RzZtZlRiV0Q4Qnl1aTd3QkMzaGZ3Q29lY2oxcTMrTEVOazJ6?=
 =?utf-8?B?RVhXZXMvQ3VQQ1E1clBPSTRSM2FUd0JUbzEvdFlZOWVTeE8rcFlwV05ZajB1?=
 =?utf-8?B?WWV1bGdCZ2ZEOG0wVlpzRDd4MHZud2lRK3dxSmRhTTJoSTdFVnN5cjZLNWVv?=
 =?utf-8?B?bFQ2VThkYXJEdTdRejRMbVBHVUk1dFdjMUdPdWRwWkVHSEdYc0xRUHE0SjhW?=
 =?utf-8?B?a0JYZ0duSlRyclVsUVFicTl4b1Z0THcvc2NaM3lFVlZrOFE4dUlheXNFU2dl?=
 =?utf-8?B?YjdZSVhoZVF0R3NKUzdLZ2pqaEpPTnJqNTlBb0RFMUxObFhZZUpFZzhST3cw?=
 =?utf-8?B?aWl0YWdTUlpCSkxiNHU5ZTNHS3BUd3lXVUN4TS8yWXdMb2VwdmxzNmhlckdz?=
 =?utf-8?B?VFptQnNNTDBNTW5WZCtjMDRUT2R6eEZYZkR3dHIwNjlHTFZVRUxVOHNzcnFI?=
 =?utf-8?B?d3dDaUNZWnpGc25vMFA0NU56VWNta2ZGT2NkNlhvVGUzSlRjRGNwVHVnRU8z?=
 =?utf-8?B?alladGxLMmRnbjhNaU4wTEZ1SEhRMEdLeHZHZkhENWJWQWdXNHhqRDU2NllJ?=
 =?utf-8?B?QzhvaGExREU2WUNmMmd4U3crSUZVQUIwUURPalNRVDQ0WUFKbkwzbzBTK1BS?=
 =?utf-8?B?WVVRekN0S3hiamkzbnhXM1ZjejhsZDZEcmJHYUFjdzFFMTREcHpHa1owTFdk?=
 =?utf-8?B?TlBCb2p4MlM3NFF4RXlVS0dwWDlSa0ljOFA4SHFyVy9mNHpTUWhVMVAxcC9W?=
 =?utf-8?B?YXd3Rkp5em1sV2QvWTcxRFNWditDOW9nNHpnRkE5T2JKNzBROG9ITlNYeUpK?=
 =?utf-8?B?eURQdVNmeHJoZUVkWEQzWCtUZHFmVWtiQjN3R01sSHlQWFJnUmtFcFJCU0da?=
 =?utf-8?B?MzdhckdvQllyNWgwcXpGRllBcUdUaVFSUVlHRkN5UENEMGlyTGFtN3pLRTVW?=
 =?utf-8?B?ZlhiYmxUc3AxWHFHQ2FldUszQ3lnT3lBSlRHRVd2UXo1alNDQ3dsVis2V1lO?=
 =?utf-8?B?U2NWUmdBUk1lb3ZFZklQQXFyejZ6a05rRy83TENOWTNnVmJ1RThFMkJRRHlK?=
 =?utf-8?B?WHVpMEtQNUJkUXFNU2RQN0IyejQxc2xYSjFWczlrMThhY1UrNmhEOGdRS1hE?=
 =?utf-8?B?dkhqZ0lBQ1NSSXFRSHdsZW5pMWgvRGNYaVNUM3NDYlBaYXQxTHhGbGxyRUIv?=
 =?utf-8?B?d0ZvckM3ZjUxODlVNW5Ub08yWHhiTGk4azErNlA5ckNpMVVqcVBsRU1VK0Fr?=
 =?utf-8?B?MW43QXd0dnFFK3NRZnUxZW5ZUlJKaml1T0xUS2QyUFkrRVBMVERCQW1HY2E0?=
 =?utf-8?B?NU9GVWZyTU1FcWkwRzQrbUlaajNKckxoT1pJK0RqRW9zSlViQ0k0OGxvSE1I?=
 =?utf-8?B?UEZQUnFDOEVBTUlwM25DN3kwSS9UaFlTelRma1czUDNRSnFDQTRaOEVTZG0r?=
 =?utf-8?B?YldCV2xoSlJZQkZMZ1NMWUl6VzVTV3dhLzk3M0NFamVhWnVONDY5R2h1UVlS?=
 =?utf-8?B?cGpYMXprb0QreW5sTzBOTlppYVpxbzU5RCt1RzMxS3lmanYydGdGY29INUJK?=
 =?utf-8?B?dzFQTjlGZE95aVRtV29UaGZBWExGVlNGMmZHTFYrR1Z1VkdOek5IdGZOV3Zs?=
 =?utf-8?B?K2VmdG44b3RjZEt2aGUyRFpDSWJpQ3NqMkNYd2NaMkVHWHlibVdOcWFzWnEw?=
 =?utf-8?Q?3CcCjivisRbW6Q2340/UnY7/0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78bdaf2a-c6a9-4f92-6239-08ddec3e0eff
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 05:35:44.3561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRITLr0ArcJKmbpDoWWqmLh+9PNiKOeXIy0OyxuRpc/ewnR9hq8DeGRMzJQuKcVh98cSOMHvr3LpbL11UBWyxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630


On 05/09/2025 0:52, Kory Maincent wrote:
> On Thu, 4 Sep 2025 21:28:06 +0300
> Carolina Jubran <cjubran@nvidia.com> wrote:
>
>> ndo hwtstamp callbacks are expected to run under the per-device ops
>> lock. Make the lower get/set paths consistent with the rest of ndo
>> invocations.
>>
>> Kernel log:
>> WARNING: CPU: 13 PID: 51364 at ./include/net/netdev_lock.h:70
>> __netdev_update_features+0x4bd/0xe60 ...
>> RIP: 0010:__netdev_update_features+0x4bd/0xe60
>> ...
>> Call Trace:
>> <TASK>
>> netdev_update_features+0x1f/0x60
>> mlx5_hwtstamp_set+0x181/0x290 [mlx5_core]
>> mlx5e_hwtstamp_set+0x19/0x30 [mlx5_core]
> Where does these two functions come from? They are not mainline.
> Else LGTM.

You are right, I hit this when I was working on another patch to
convert the legacy ndo. I thought it would be nice to have the
kernel log in the commit message.

Thanks,
Carolina


