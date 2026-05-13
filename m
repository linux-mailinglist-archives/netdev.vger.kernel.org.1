Return-Path: <netdev+bounces-287546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJ46IjNhBGq6HgIAu9opvQ
	(envelope-from <netdev+bounces-287546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:32:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA883532523
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6129E301EB76
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB543A5E64;
	Wed, 13 May 2026 11:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OnrmCfGB"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011054.outbound.protection.outlook.com [40.93.194.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404523921F1
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671743; cv=fail; b=bJhDGveasbepOQoISejS3cFlsTBfVQqSTEjrFwmuklmFN8+L7gA3oQMqoqd1QGhhSSKcIsp8VdS5/ByhY8qKEDHn760ASL3NWCtxUYvtwWIja3POSBZ5yXA8X3i4sjiqjkXlg0jcNlpmyMJc64GXulMpSKNqgeKii+wgLSei7cI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671743; c=relaxed/simple;
	bh=6G6x7F5mXPF/5TeSV9jMawNZKX4dYjPJa7Hb/mWyV5k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RndGX//CDQw7K1t8U++p+gXx9DFLc7zsqdH6hXNPDh5+qbDn/D6bmXjNxNFV8y9rTKBg130GF9amc1bDpG1fyDm0DagL3a+sjLHW1LG0nL1wl1yHEr1QgZboGe2p9fHZ+NLIjcWpgTQ+4Wu160PLMvcT0+njEgCvCm8DCcxEEwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OnrmCfGB; arc=fail smtp.client-ip=40.93.194.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKyn3ICQZZOarhDjmk6aISnBEFvUQVEILBQTXR07B5bP2Uz/32IhhlMxRDolKEGd3T7cOvo4lgRkZgef2Q6JvUuBcqlTR9mF6fqFk6b/RCt3b6XYO8ttRmUfu1YEA7wsSw75e0Y5c92St4+1fHaeOiJxRjDhHhzaX+SRLDomP+Ouixnu30D9tUdH1fcxWtnbb43eLSxOtUAJtTCanf9Px94Nymg4uKDIQDGtfbtJehfFDN1YlCE51jH2fJE3DLH434aWEICuQBbahGbCHK8DvRD3LZDYdPWtrNmY3AQj5wA/qK1V9vEq/EAl1T1pOe/f0RtMnFFIACZ38hHK7hMfBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBGPwxuhnB0TD1SrkfImPH12R5ayXbA5Ws8DvIE9d5k=;
 b=iwOE8CalNyupdrjE5JN5Y6t0x5dXf2ZniyC0H+fGgTKMdluWTKA+fc83hZT5v6rqy1gB7GGaxxYLEdI8FeyAtFIvR+yc+uy9A6rfp3aYnfyBJOWvgbaLtmq1iuilCZR3lie0PVUBB2E2FENlQlPvVWKDoYb5IZxPkr+vojHcLfboFrnEQWz2MohOytUW5lmhrkbo6lv4bMvRqjkGBRIe2vfsdq9gNmvGdpsHvgmu4xQq0x7dDqSkq+GJ5K1ZesgGGLhzu6sk6jr7mPeRbX1uAqk+uipGxkgGhUSL2hA8q9NhS3bbcRLAd38eRhfDf258OjecSvBgVAMkBt85Crdv9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBGPwxuhnB0TD1SrkfImPH12R5ayXbA5Ws8DvIE9d5k=;
 b=OnrmCfGBqNd2sd3cVxrEyAmGs/hjCr/5zp00Z223+UvalLEOkSuQWG3BWxOAbHaRrQaLFj4L9YPhyHM3o+CLC4p+H9xG1b3zF0nH8Nl8pM7lYOy+MO652yrKYf2wEMloWpD18j7+Eva2QJ4cKPuqgrfLaahUYjHGlW4N/Wi1z1WRqTagvbenm8zH7yhOM2S3sS9Bf4Zh4K9SY3K+/FS0GphlScKBPn9oGWblDnvLP4URgIZ6JMMZvNupYuABxjkAuba06z9tyxSvcPWLfJaWFB5EllXzkgXdSyiyDWPbZoaTWENOKeg0dAF+eMteoSlQotQgwa5HW+ZJeKU+ZKIU+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15)
 by SJ0PR12MB6877.namprd12.prod.outlook.com (2603:10b6:a03:47f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 11:28:58 +0000
Received: from DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385]) by DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 11:28:57 +0000
Message-ID: <c129979f-7494-433c-92c4-6d4290add4d9@nvidia.com>
Date: Wed, 13 May 2026 14:28:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] udp: Fix UDP length on last GSO_PARTIAL segment
To: Alice Mikityanska <alice.kernel@fastmail.im>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>,
 Willem de Bruijn <willemb@google.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20260513074349.2152146-1-gal@nvidia.com>
 <f75c1cf5-b5ad-47db-952f-faad9f0a33ed@app.fastmail.com>
 <f356add6-e173-4020-a8af-8cc70aec955d@nvidia.com>
 <ea0d0e1c-bfc2-4271-94d7-3bec2f2e85a3@app.fastmail.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <ea0d0e1c-bfc2-4271-94d7-3bec2f2e85a3@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To DM4PR12MB5248.namprd12.prod.outlook.com
 (2603:10b6:5:39c::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5248:EE_|SJ0PR12MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4e4af9-7cbe-4845-2f8a-08deb0e2d26d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	Af+xajqZQV+JvyvSkzUdM02jyjp+qy2+WsiPx0Tknauk0pnNS6bYeMryXXd+lcOxfWQ0lr2eLn0wHj8jkNxC1y+LIkkf/O/eGB8qEm5UN8aVuU/NinS0KQSAeLkFtV3CRHuz04v1MdNpedGCjkQzUp61uk6ga3LXUgRdqPtYgLyINEhGFOcPQ5oEgFNgDQBR2pnhGnjlqwz2/UvlzOQ7e5EJL2+ihbP4jCFmfrxNmxPa1HogZNza/LlxwnlidR+9NLGDrLmyZkE2qXEBUhJ7eLr94dNx0Gnv/StDNeslT+O/QfJhVuby7Y03xokKLM8k+akwcugYHyxoc36KPkjasYJImhUrqZwic5qE+KWz5wZmQFsj53KmJDo1IQTHBXwqHMr1/AAqJIWl6luyjimeK86qQoMise/Jj1abxtsKFjA3utNBhdjePfpOnxBu1VlxLzq3eScUdgWvRkiNEKePd4f7Kr8qoQMoGjXhCXkuLAxrR0DvjJrT5sIyRDTCc+SXihgnfpVkiQLY/I3auODoQhGW6ViFm2DAJvcdLY0s9Bemug9TN55TwNayPGWobVdH0pmFdxFK+lk2bY8CVx9ncD0fC+USaiiV1Ods4sRWK20qrnUsWu3QjPqquZZxKAhGTgd9nPMqRdGZYRLinLAnkxqUPdwFVxKnTonzzrD7CEowiVfPpi5eALx1Qu2ao+Dr2HbsZ/ayJk33hXM9tJhlUA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(56012099003)(18002099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGZtUmlscDFFZmo2UVRjanJseWhLMEMyOFRoSG8xNjFjeDhMeTVGTGp6ZlpM?=
 =?utf-8?B?NU16NDJOTE11OXczbTNHT3YwQnlQOGhmTk14OHJaTGo0MVNmK1RHU2cwR1p4?=
 =?utf-8?B?ek5xdmdZd01RenVIbmxPMEFtVEtPSlR3cTg4a0lBMVdMMEJoRUhWYVFpUHFK?=
 =?utf-8?B?OTZOa0I3TjVxTFphNjIvejlHMS9hQWhEbGNMWXZSK212VmVYNUs1cEhIbVB5?=
 =?utf-8?B?ZnZPSFlrcGpKM0JjeHdUU21hQTNEb005YWJBMUE5ZFV2b2ZCU29zSDdKWUtL?=
 =?utf-8?B?bkF6NmFzQituZlBVcnpOc2d1aHdmaWNsMmZ2R2xjdmJwVkdVUkFRQlIrSGl6?=
 =?utf-8?B?Nkg1enNsQXNmaE05eUJqVjB0VjNLVWFvQnhwSStyZlJTMVMxTk1WZ2hDSFN4?=
 =?utf-8?B?K0VkcVMyUkZORWkxQVJDL2hNQ01JSlJhaEVCblU1cmY4SW5xU3hqZEpjWEZs?=
 =?utf-8?B?d0tDVUlsci9tbTZYRkxDeHB6bFFOU2RGMGhFODRJdngvRDRnc0dwTWdmU1JJ?=
 =?utf-8?B?OHdTRUdxUW1ZS3UwU1JVTnJZanB6SVRFU2FicmVqT3hwTVlHeVVOUEVHTFRx?=
 =?utf-8?B?SWxaa2MzbXhGdTJBS0tPZlVGUDNiL2xOL0duZ3dBZXFZcnVWQ1M3SCsxL3Ar?=
 =?utf-8?B?UDdZM0dJTVMrMXFVZDJUMnFPWW5UUFZSc0s2d3NKZFNNMHJscForaVNTd3Nl?=
 =?utf-8?B?SzFSTnI5eEJHYlZ5SllBazg1ZzUyRURFd3FmVkhJcDB0alhmN1ZqUjlLUS9x?=
 =?utf-8?B?QW9tTUdKbTJPRDF1d0d2VXYrZWdWeFRxQjh0TjM3c2NOSHBjVEt2OTVLbHFi?=
 =?utf-8?B?VnRqQndZSjJRTk9Pbno2Mng1SlFldEdUcVRld3pjSHIrdVp2ekNmZUpSdHhI?=
 =?utf-8?B?blZuVStXdVR5M3FPSmNUeFJrTDJ2c2hlVWlEMXBxMDlCZ3VmT1BFYmJyYnAy?=
 =?utf-8?B?VEtCR1BVUGh2SStmYWlBQ2ZLVGJWbEVZNE54WFF3U3NzUm05cVdYdzRVUGZL?=
 =?utf-8?B?ZGVNT0w3R1pwS3pNR3RnbTBqR1JWaWhuS1ljS2xxeDE5Si8wYzJkUkRZM0lu?=
 =?utf-8?B?WDZscHZVQVZNNGs5RW5qR0Vxd1dtc2IyMmlVeHJ3WWgrTFFndEROYkx1dVEw?=
 =?utf-8?B?Nko5TE9UeTZ5cEJFb0U0QzRNYklpdnJNVGlhanpGU2hiekFycGV2NEhxMUJm?=
 =?utf-8?B?L3MzWVhIOXRQS0w5aFRVN29IbnpDNXdwa3pYQ250VEszK2ZEdFRHT2FKd01N?=
 =?utf-8?B?RHk0WnkyM1JxV1lLNFFKNVVPWWJlellUaFNSN1JHeksvL0Y4ZVUrNFgrcHVP?=
 =?utf-8?B?QXoyaFRZVWNGemRSc0RVTnBhNmFmVmcrd2RDenJpbDVKWk9xUG5aR3M0Z1lT?=
 =?utf-8?B?WVM5dXNCLy8rbFZDMWdWQUtmR2FBdkdoMTVicms0R1JuQWtadENaM3NjYzl2?=
 =?utf-8?B?QkIrQ0NHOVRZOXdnR04vZG9jL2pDVi91alR0ZXR6S0dHRXh6Z2R2SVZtbUVR?=
 =?utf-8?B?TmlxMTZobW1oSnhONWRKSWpERzNTdThPb2V5bjV3MEx1dkpYMXVINUFTMjQ5?=
 =?utf-8?B?NXNIQW45K0VnM0JOa1NhSXpYVERFL0k3MWlqb3BpN2FxWks2eXdxSkNiOTln?=
 =?utf-8?B?WFlMdUtHaGtTMnNGWjhHNnE4MXBVVlc5L0V3Tm9IN21JZ1FQZWFDeGM5Smg5?=
 =?utf-8?B?L1lYdStVQ2p1Y0pqSDl2bWNFNlVPQmNORXFOOUNGNFA1Z05wYWVWTUJLazdx?=
 =?utf-8?B?V25pdS9rTE0xWnRiUUJyZDl2V2c1aEdJZk02aEh5L3Q4ZmltUXB3ajVMbGNM?=
 =?utf-8?B?aGNvMVArb2R2RE82MStSRlAxL0FaZ285N0tzZWhNZlFTdEtYVFR5eFFQVlFU?=
 =?utf-8?B?eUJBWjFXNCtWSHl5OG9mYzBtdUZWYmFOcXhmbzk1aFRpaGhZSlJNemhiSVd6?=
 =?utf-8?B?Q1Z3bnQrWUNJSVlQVFZyam0wK0JaZUpMdDUxcGpzMVYzbDIvRzBIOUwrd1ZO?=
 =?utf-8?B?NGtORzhHSWFhNy9ra0hnWG9CaDBsekFnc0tyOWhuMXJaQnhuWFFFNHduWUdq?=
 =?utf-8?B?ZWYwb095Y2I3MHp6WUxTdjhKUXVHWGJEOTJJcDZtWVRiVWxQNjlyTlNpWXk3?=
 =?utf-8?B?ZU5Db1BHYktyK2s4TCs0OGozWEI4T29nTERkQ3JZSkRSdGViMGZtN0ZaZnFG?=
 =?utf-8?B?SXhrM3hkVEgyT2VlVmlSVm5LK3RGKzdWZE1JcVZ5cTBVZ3dHMmZZQWN6UlVS?=
 =?utf-8?B?TmZyV0tGalQ0V2JaeWJISWFqQytPaGxsMnFTdElKMXFqVExWbWJVc0VsaUhk?=
 =?utf-8?Q?CPDmHfOukFR8+pKK6d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4e4af9-7cbe-4845-2f8a-08deb0e2d26d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 11:28:57.5465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMS2qla9WRy6QIBh9EvidgHvl4tN6wspVn+AO68DK7L2NK9D6WB49zlU7ACe2LAB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6877
X-Rspamd-Queue-Id: DA883532523
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287546-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[fastmail.im,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,linux.dev:email]
X-Rspamd-Action: no action

On 13/05/2026 13:08, Alice Mikityanska wrote:
> On Wed, May 13, 2026, at 11:43, Gal Pressman wrote:
>> On 13/05/2026 12:17, Alice Mikityanska wrote:
>>> On Wed, May 13, 2026, at 09:43, Gal Pressman wrote:
>>>> Following the cited commit, __udp_gso_segment() writes single MSS length
>>>> in the UDP header.
>>>> The cited patch doesn't account for the fact that the last segment could
>>>> be a GSO skb by itself. This could happen when the size of the packet is
>>>> a multiple of MSS, hence the first segment is also the last one (there
>>>> is no need for a remainder skb).
>>>>
>>>> When the post-loop segment is a GSO skb, assign the single MSS length in
>>>> the UDP header.
>>>>
>>>> Fixes: b10b446ce7ad ("udp: gso: Use single MSS length in UDP header for 
>>>> GSO_PARTIAL")
>>>> Reported-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>>> Closes: 
>>>> https://lore.kernel.org/all/6c3fb15e-711d-4b8d-b152-e03d9b05293f@linux.dev/
>>>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>>>> Signed-off-by: Gal Pressman <gal@nvidia.com>
>>>> ---
>>>>  net/ipv4/udp_offload.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
>>>> index a0813d425b71..71df45f9488a 100644
>>>> --- a/net/ipv4/udp_offload.c
>>>> +++ b/net/ipv4/udp_offload.c
>>>> @@ -604,7 +604,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>>>>  		       seg->data_len);
>>>>  	check = csum16_add(csum16_sub(uh->check, uh->len), newlen);
>>>>
>>>> -	uh->len = newlen;
>>>> +	uh->len = skb_is_gso(seg) ? msslen : newlen;
>>>>  	uh->check = check;
>>>
>>> This is going to have the same checksum bug as your first commit, which
>>> I'm fixing in [1]. You should use the right value of either msslen or
>>> newlen when modifying check a couple of lines above.
>>
>> I tend to agree that the checksum seems to have the wrong value, the
>> reason I chose not to change it is because my work only moved the UDP
>> length assignment from the drivers to the stack.
>>
>> The "wrong" checksum value was used regardless of my change,
> 
> The wrong checksum was visible only inside the driver, and since the
> hardware didn't care (due to the offload), it worked well. It was the
> driver business to make sure the corresponding hardware likes the
> packet. After commit b10b446ce7ad ("udp: gso: Use single MSS length in
> UDP header for GSO_PARTIAL"), however, the wrong checksum moved one
> abstraction layer higher - to the networking stack, which attempts to
> keep the checksum correct for a more generic case. It's not the same,
> and while I'm trying to fix one occurrence, I'd prefer not to
> introduce more.
> 
>> and I
>> prefer not to change it as part of this work.
>>
>>>
>>> That said, maybe you can base your patch on top of my checksum fix? For
>>> the last packet, it will then be:
>>>
>>> if (!skb_is_gso(seg))
>>>         newlen = /* the new value */;
>>> /* keep newlen as is otherwise: my newlen is your msslen */
>>> check = csum16_add(csum16_sub(uh->check, uh->len), newlen);
>>> uh->len = newlen;
>>> uh->check = check;
>>>
>>> [1]: https://lore.kernel.org/netdev/20260512165648.386518-3-alice.kernel@fastmail.im/
>>
>> As I mentioned in the other thread, this fix goes to net, I can't take
>> your patch.
> 
> Ah, that's right. Still, I guess you can take mine to net for the
> checksum fix.

Do you think it is suitable for net? Would you like to rephrase the
commit message accordingly?

If you can send me an updated version I will take it and submit both (or
you can submit mine if you prefer).

