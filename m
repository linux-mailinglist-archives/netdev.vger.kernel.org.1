Return-Path: <netdev+bounces-161452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9B7A21877
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 09:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB65C3A5281
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 08:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E5518C031;
	Wed, 29 Jan 2025 08:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="oKdQPV4I"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11022079.outbound.protection.outlook.com [52.101.66.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DD411713
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 08:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738137806; cv=fail; b=Q+qdQJC+dLwd0iZLDd3ZEMOrcdWaZwbvnoeJ+h6QUgxUuOsS4h3BVvAsQsOJA/4DLFYkpSrlIo1aZ/IOoBcjxjdwxaNpjbPeCTj5DkXR01lQFFjrJrhLL3hoqwRjyBXs4afG97U0qLbuYZ7jpTihdtl7R6ddcJa+zsXBiH5WwZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738137806; c=relaxed/simple;
	bh=XwvFPZjhkBMnBLy2xmiyLnhAyJEhxxbPMQDCjy7p5iI=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NsvMCuchmMMGYykNNGpvqDaiBMxEEap0Xqtwt0M7OO4iFt9gy82VFkEw2k7eXMiCRu2K7DktaBhgzyVIhWj0dZ6wo6l81LnLn+SvuJMZ9enMrotadFsZQw1jNoWRNaPcN1bodosJDDIMSIwMUU5fzFOh9bEgoJLvUvnB6J3WyzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=oKdQPV4I; arc=fail smtp.client-ip=52.101.66.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epSh4sootCBD3cBECecCBC3ZC9CYZwWQnDYoykglikFGWOyDdFV0vqZm2fhi9iUpw6Gk2d1G7XJ3pZ7YQ7AoOsVCcAgc/2JUCWWTtngw/LO5z6DAU8xMRM+2bZxZXbfyRcSOaSQ4oSEnTH+AQO6ue2zeJ3eUXPumwByLhXLc4DQ3UwIFraYW57jagupzxynFu7lZuPmAxNrfLmkZcbSvFocJFLeZvXeBqsRQZ6sNr5DrZG1RUmOeDLIhKFIAI7iXqaA9k9vITvJ8CL/kLdp6Mgxv9N9F0CCgT5sKakd77iHQ9Funt7d+unYEYc0v4yEuLQzgrOpxXLpCrkFXJMpKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+j7F8sVudTisFtFmt7prbGoZjoQbPKAkjabesDo0KDc=;
 b=oDrhgwjgQHb0D/W2LSZVVzlAV+KNQdUHfybgSxb0cP39UfeSN7S7g5CmUVjkVCmdAwfhlrzONcaGq4yFG2+5iTFxkFKhG+jJnjBh2ynTzo4DkEgipzAyTdvV6chiXlX2yb0ojCQRrMBnylyyg+Kq4FNw2q7QnVJPJUhyfxMFJ+zwQnXb0lXUy5/1B9yS7boqJjXrVnPtkMlGWg/HEiqxFiPBl7UhCdY4E42kZVB20uw1bJ1sP8d7E0dVt/Iq4ZukO2EeWYiU1+fmqekSsKr5xCkcMoI/9m8owCkBC/+r+hc6D7L+xQ6BvOhRBTqwvlcNRQOE3IcfqX+33PN+l8ZF+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+j7F8sVudTisFtFmt7prbGoZjoQbPKAkjabesDo0KDc=;
 b=oKdQPV4IUFScZ0HvnEyUZ9u31g77ZJARaT+C9mn12u8nH4lsBgRKyNSgYHtJ9q9Furvd6LvBVkzxauWcPW9EQ8DKOgGZDI4xrK8Vl4lyjwl2Dqd1F7pw8oUfKkWltXq7YHQINL2vvTOPUfyqi+TwdFaDmjnMv6pYPW5/dwOll7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f2::14)
 by PAXPR10MB5613.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.13; Wed, 29 Jan
 2025 08:03:18 +0000
Received: from AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::95c1:ff1e:275d:26aa]) by AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::95c1:ff1e:275d:26aa%4]) with mapi id 15.20.8398.013; Wed, 29 Jan 2025
 08:03:18 +0000
Message-ID: <6400e73a-b165-41a8-9fc9-e2226060a68c@kontron.de>
Date: Wed, 29 Jan 2025 09:03:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: KSZ9477 HSR Offloading
From: Frieder Schrempf <frieder.schrempf@kontron.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Lukasz Majewski <lukma@denx.de>
References: <05a6e63e-96c1-4d78-91b9-b00deed044b5@kontron.de>
 <6d0e1f47-874e-42bf-9bc7-34856c1168d1@lunn.ch>
 <1c140c92-3be6-4917-b600-fa5d1ef96404@kontron.de>
Content-Language: en-US, de-DE
In-Reply-To: <1c140c92-3be6-4917-b600-fa5d1ef96404@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::20) To AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:4f2::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB5671:EE_|PAXPR10MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: 09cec129-76c2-4930-77e2-08dd403b63f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anMrQ2o0N2xDNVVJL1pPbWxXZ1FoTW93TTNMMEdNTzA3SEJFSTdFdHZBdGlh?=
 =?utf-8?B?SUE4bVN0OHZabEQza2NIQWVITmN0T3dsQ2QwU2FBUXV4ZXY0TlF3VU5SZTlz?=
 =?utf-8?B?Q2RjbzdkTVRScGZlM0diakMyTnhhb2h5VmNjcDIrZEdiMFR5T3MvaXR0NmJX?=
 =?utf-8?B?VEZ0a0t3cUphNlFVVmlWRFdSY0s4UnlPZVRQOTVmbGJCYjF6ZWVFaHBEcTR3?=
 =?utf-8?B?QkJWWXFUZmZ4MmgvTVNFaVJYQVdmS0RhSmNNRVdPVWJLWDZ2cnY2MURXalBt?=
 =?utf-8?B?RUNLdWVwbmdDL01TQzAza0c2LzYzSXA0ZnhFdElvZjZwaWZJZGJWQ3JOMmg2?=
 =?utf-8?B?ekltczZpcGdqeXVWZlN5UW1aZEIvalU2ZStSRW9HWDB5T0p3V0hFRll5cE55?=
 =?utf-8?B?VDQ4Y3FPVnc4RTNSa2pUbklLUWRnT3lkcnhVVEUzZ0ZHTUNybmN4TzNTOXNn?=
 =?utf-8?B?MjlhREdTbW45QTJGeVp6N20xQnNNbDdRRVBEQk0xKzhSbFduRUJabFZ4V1ZL?=
 =?utf-8?B?QXlFZGtUNjlObi9PbHY0ei9FSm1Ha25iNmhnWk5rcjhHaWJLVWFFenVLckRi?=
 =?utf-8?B?NFVkZ2xxSUo0MDJSVHlvUkF2emVSWmVMSEtvV0JnMzVkL0VRQXZ1dTZVWXNV?=
 =?utf-8?B?cDlCWmZZS1lmZ0hCTkJzUjFVZVZkeHRnMjdhN0R1NzN0WHVIRGdpU2xMcEJF?=
 =?utf-8?B?ZC9lOWxWM2kvVkdQVEp0ODN5V1ZCQlB5ZnZhTEorRUZqV1BpWWlPRCtMT3dx?=
 =?utf-8?B?WXVJNG03NDRuQmY3dFBQaUk4OXdzU0hiLzh4RzhhOGVXWU5tK01JMGZYUHpZ?=
 =?utf-8?B?eWpYNWJpbEI3K3RHTlBHNEZtc052YlFNY0RVN1BFWG9JcThKbzFZS3ZRQ2Vv?=
 =?utf-8?B?RUtFWkFDSkJqUVlFb09PWWpLOENzNHZ6UUN2anZPdDNmSmRDNCtlUjV2QzRS?=
 =?utf-8?B?ckNuOFcwTG5QLzZPNFBHQzZJNGRDQkVvRXdpVU01VWRVbEdjWHRSbmw2MndH?=
 =?utf-8?B?M2ZJVGJBbUVHS1JOYVp4NUgyZnF3T211RnlIb3psaXVTMmdManFFWnBYb1hJ?=
 =?utf-8?B?eXNHV3NteTdTM09TMCtmZXRnTHlpTTBiSkk0MVFWblFiNVZxazc4YUdFak8v?=
 =?utf-8?B?L01FaDhOMW1HY3VXcnMyOGJyOXNFbkJBeVVDYnRPYkUwSWtlTzc2R3FrNG1y?=
 =?utf-8?B?S0VKbVRuS1JxaHB1ZzAzbkc4L2lrL1FSekRWQzkxRXlnZngwNEtIWmh6alVj?=
 =?utf-8?B?ckoxWEhrZ1luSm4yaDIzVVJjNHNsQVpqYnhFTFI1OFdDNUczQUh1aFpoMFVi?=
 =?utf-8?B?Vlp2eldTamFOMEg4NnhlWEhiY0MrSDBYSDJPODdhREl3Ui9HamNoQlFBcWtV?=
 =?utf-8?B?K3hBSGx1T0lKNXFNZENvV2E5K3ZkYVNxWUFXZ1pEd3NOTlZWZUpraS9lMzQx?=
 =?utf-8?B?ZjdmcjlDUVdEVGdSL2lISVBJVkZVRlFLdHBQdmJ3RUVVdmIxa0tjQ2VMeWR6?=
 =?utf-8?B?UWU5ZllVcGRoYmowVVIrT0F5d2psemJFTGhJZDZDczR5K1RlMWFFMlBuQktS?=
 =?utf-8?B?VC9JOVZLeC9lS0hpaTZBZ2JZODBFRGNYcDdJMTFObGYrakg2cUhpKzZONmY1?=
 =?utf-8?B?bkxDTTY5WGRPVXhKNjVFcXYyVGNCaXVOemdLRkhIdzBtN2dpNldIQ3dLRkl0?=
 =?utf-8?B?SU5RamNWek1yb3hZSktqUXhST3haU3FyK1lkYkpGUFh2eFYzL2ZINlNaaGFR?=
 =?utf-8?B?a2FPRGhsV3g2VjlxY0dETitmMTQ3dXR5djNFVVY1Ymp2aG9jUnVoajRLcElz?=
 =?utf-8?B?UjQ0RFM0WDBnV0Vhc3FqNzcxMHBYOHJQTm9IcGFoY2FZWUZzOS9sSVNBaGpm?=
 =?utf-8?Q?rrO+e+bY3rOYL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1RuOFd0WmUrMmljQW1yeEZxbUphQjdDK0I5dlc4ZGpIclFZMmN3WktwdnVI?=
 =?utf-8?B?SzNnMXFBc1RiNTdmQXJpNm0wOHIrcGkyY1lNcG5oRnF0STNVNEcrNjlHU28v?=
 =?utf-8?B?RktPQzY1U0I5bzc0MDhOZ1QxbFJJUzV4a2w3OE1sbSsxSmN6b3NCaGtKOWFQ?=
 =?utf-8?B?enAvSU1kVFZ4UDY3cHJNUkpTNFhxay84cFJOK0wzMS9SVXBMWEdtWWE4cWxF?=
 =?utf-8?B?RXV6dnFKVWgxODF1ejdJV0tMbVlMUi9sYmN4YU9vQnNoVTdzR3JaaWVxMkps?=
 =?utf-8?B?YmlxaytqOW85Tm1wamt2eThkWkYzVHBkN1NlWHBrYnRXWVRSWTB5Szl3LzdQ?=
 =?utf-8?B?TjVaNm5tM09oSGFGZEtMYmQrSjBKemY5ZzZ3Qnp3M3NtcGwwTW9tamI1ajlw?=
 =?utf-8?B?NTUyOFBMMWJFRjVJYU5yWVNiK0JEck1HU01RaWZQYkZUSU5HK1ZQWXFWWlFz?=
 =?utf-8?B?U0gwMUJtbzMyWW1RQTZleVRYelUwZDZnYlVUTCs4RzBNVFlaSUhHNkpTWXR6?=
 =?utf-8?B?MXJWMXdrNzY0L1lsdmJER1hub3dnUkRHSjVHSWxaVlNTOWM5bERTRzJsMVlw?=
 =?utf-8?B?a2k0RDVrM3ZsQi85N1MwdndHZHl5K01oMWJ4Q0NQc2RkY1FQWXUxb0FKWE5n?=
 =?utf-8?B?bXg0Z3ZKV212dmRTWFJXR2F3eGdJMnlXV2pvTDFzL1BpZ1EvSnBVNWVyMTR3?=
 =?utf-8?B?WVBodDVUOFRUK1dDa2pQRm5PUno4bG4xNi90ODZabkU5VXAvZmwzY1VRNjQ5?=
 =?utf-8?B?QkZMak8vK0N0OUVIL0N4S3pTNVFSTkZkdUg4aklUaDRkVkFYOXhzNU5iUWc1?=
 =?utf-8?B?eGI3S1N1VytFUFBNcU9BWG9CbmhaZDgvMjYraVVnRG5yem1FNnJxT2xQOHRJ?=
 =?utf-8?B?WFBMU1NTT1dzaHVvZU52MzVTVEtQQStheWNIVE0zZjlFNEFaMTBEdmZHUjVi?=
 =?utf-8?B?T3JIN1VHYVM0Zjd6WUNncVZxQUVEZ0I4UG9qaDNWWFJyYjA4OWdnRGpTR1Nt?=
 =?utf-8?B?TUxZUTQwZTVjbjRlUzZzZmFuMDBBS3lQMnhEZWdZd2psVlY1YmhXNEtNVSt0?=
 =?utf-8?B?NXJBTmxEV3ZleWJKQzA2MjEzUXhEOEpvZ1F4a3NmRE8vamtqenhrdVdFdjVF?=
 =?utf-8?B?TkRHVlB4MHVlcUZINWNwekpqMTNmazBsTVUwbHQ4T2ErZGZyWjJTenArd0dt?=
 =?utf-8?B?dWR4cHU4dUlPZkFRMktWbXp1c3lWL0xHR05PZmw0SzlIVmRuZEdxc1dFeHdQ?=
 =?utf-8?B?UndsdkIwRGJRbmp4Y1I4UHlIcFhkQlZ0Mk9MMHdITGlWMnFUTVJXK1BRNU54?=
 =?utf-8?B?WFVUK29LSG9vRnZEVXVWSzFBbk1DeVhpTFoxbDNrbnhqYU5nMTBMeGYyMGxa?=
 =?utf-8?B?WHdGOWRmcWRqM1JTTjhKck5YTzZyQmtBWnlQd1Q1czZiNHphcFZVSWVKalBi?=
 =?utf-8?B?U2ZKZkdTbXhyVUMzbS92RVMyLzUzYTVVMkN6RkthaUpQOXZoeWE0WENXbjhK?=
 =?utf-8?B?Rm5MbjF3MmVGdFBaMlZHODVGdUx6Q21zL1NHMlZaVWxsL2pLOWtmdUx1U2Ev?=
 =?utf-8?B?SXp1NTEwVFV1M0o3NjFIREtMMTRYeFhYRmNKdGZ2cmYzQ3RQbWRzdFBMaVZU?=
 =?utf-8?B?MGxxdjd2TEdvUEFaY2sva1FDUGk3MFh6KzZYL3YwSHM1NCs5c0VLM2tRNUNQ?=
 =?utf-8?B?VnR1SmhBQW80MHNHcXUzSjlFb1NEYkliM3BqcklMTlR5bjFKdDB3bXJiSVVs?=
 =?utf-8?B?SE9xaVM5a0Y1eGZ5T2NERWlZK09SS0hmQ3VoZ3ZRNUdSTCt1c0RkL0JmYUtW?=
 =?utf-8?B?SFFvL0lya3h4L2NLRmIxYXYyQUdwRTlkOGo1dlJNQUpWcWl1UjRYZmVuN09F?=
 =?utf-8?B?RGhSbHQyR2xlSTBidFdoSVpZYkt3eTlXdzZmY1RaRUJFQnlVRXN5eDM0Qk9w?=
 =?utf-8?B?TEQxOWEzdU5BS2ZuNUFCWUdLaU1vL1I0TUExN3JIOVFjLzN2WkpQL2NZL2FI?=
 =?utf-8?B?YXFSUjZ4RThvRTVEbUgxaTdRS2dCRjBTejVZQU1aYWFXbzEwYnJvZis5YWY2?=
 =?utf-8?B?L2FES2hYWm5Jbk9hMHBNVFNtd0pMR1FiWjJucWtlc1d6UWFwS3J0QTRsa2h6?=
 =?utf-8?B?OVB3STdYV3pjSWlETmg3T0JrSlc2Z1l6YThZTm5ZcGU5ODkzWkdhSFpGQlAy?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cec129-76c2-4930-77e2-08dd403b63f8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 08:03:18.1980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZyOKsUWNpUeuZFh76Skrv/R5S43GWLO7H5cZIVbOeqxAVKDeI16nl8VdCjCjSxqONdBIANMTGOc20qZnZ4IRkbvm07s1CSanLi3ilDRru0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5613

On 29.01.25 8:24 AM, Frieder Schrempf wrote:
> Hi Andrew,
> 
> On 28.01.25 6:51 PM, Andrew Lunn wrote:
>> On Tue, Jan 28, 2025 at 05:14:46PM +0100, Frieder Schrempf wrote:
>>> Hi,
>>>
>>> I'm trying out HSR support on KSZ9477 with v6.12. My setup looks like this:
>>>
>>> +-------------+         +-------------+
>>> |             |         |             |
>>> |   Node A    |         |   Node D    |
>>> |             |         |             |
>>> |             |         |             |
>>> | LAN1   LAN2 |         | LAN1   LAN2 |
>>> +--+-------+--+         +--+------+---+
>>>    |       |               |      |
>>>    |       +---------------+      |
>>>    |                              |
>>>    |       +---------------+      |
>>>    |       |               |      |
>>> +--+-------+--+         +--+------+---+
>>> | LAN1   LAN2 |         | LAN1   LAN2 |
>>> |             |         |             |
>>> |             |         |             |
>>> |   Node B    |         |   Node C    |
>>> |             |         |             |
>>> +-------------+         +-------------+
>>>
>>> On each device the LAN1 and LAN2 are added as HSR slaves. Then I try to
>>> do ping tests between each of the HSR interfaces.
>>>
>>> The result is that I can reach the neighboring nodes just fine, but I
>>> can't reach the remote node that needs packages to be forwarded through
>>> the other nodes. For example I can't ping from node A to C.
>>>
>>> I've tried to disable HW offloading in the driver and then everything
>>> starts working.
>>>
>>> Is this a problem with HW offloading in the KSZ driver, or am I missing
>>> something essential?
>>
>> How are IP addresses configured? I assume you have a bridge, LAN1 and
>> LAN2 are members of the bridge, and the IP address is on the bridge
>> interface?
> 
> I have a HSR interface on each node that covers LAN1 and LAN2 as slaves
> and the IP addresses are on those HSR interfaces. For node A:
> 
> ip link add name hsr type hsr slave1 lan1 slave2 lan2 supervision 45
> version 1
> ip addr add 172.20.1.1/24 dev hsr
> 
> The other nodes have the addresses 172.20.1.2/24, 172.20.1.3/24 and
> 172.20.1.4/24 respectively.
> 
> Then on node A, I'm doing:
> 
> ping 172.20.1.2 # neighboring node B works
> ping 172.20.1.4 # neighboring node D works
> ping 172.20.1.3 # remote node C works only if I disable offloading

BTW, it's enough to disable the offloading of the forwarding for HSR
frames to make it work.

--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1267,7 +1267,7 @@ int ksz9477_tc_cbs_set_cinc(struct ksz_device
*dev, int port, u32 val)
  * Moreover, the NETIF_F_HW_HSR_FWD feature is also enabled, as HSR frames
  * can be forwarded in the switch fabric between HSR ports.
  */
-#define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP |
NETIF_F_HW_HSR_FWD)
+#define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP)

 void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct
net_device *hsr)
 {
@@ -1279,16 +1279,6 @@ void ksz9477_hsr_join(struct dsa_switch *ds, int
port, struct net_device *hsr)
        /* Program which port(s) shall support HSR */
        ksz_rmw32(dev, REG_HSR_PORT_MAP__4, BIT(port), BIT(port));

-       /* Forward frames between HSR ports (i.e. bridge together HSR
ports) */
-       if (dev->hsr_ports) {
-               dsa_hsr_foreach_port(hsr_dp, ds, hsr)
-                       hsr_ports |= BIT(hsr_dp->index);
-
-               hsr_ports |= BIT(dsa_upstream_port(ds, port));
-               dsa_hsr_foreach_port(hsr_dp, ds, hsr)
-                       ksz9477_cfg_port_member(dev, hsr_dp->index,
hsr_ports);
-       }
-
        if (!dev->hsr_ports) {
                /* Enable discarding of received HSR frames */
                ksz_read8(dev, REG_HSR_ALU_CTRL_0__1, &data);

