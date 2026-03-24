Return-Path: <netdev+bounces-271288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iC8AG+v1wmkEngQAu9opvQ
	(envelope-from <netdev+bounces-271288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:36:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C3531C639
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14D933028365
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF94347FEA;
	Tue, 24 Mar 2026 20:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YecTlIi7"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011034.outbound.protection.outlook.com [52.101.62.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602DB3537FB
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 20:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774384615; cv=fail; b=Okq99/GtsOxUR6pruOuoNIoFzIZ7FK43C3+ZeHL2JEqRiMb/lmutvcWqoqGAtiEr5LQAjW19YVgY8ITSOiSH6LiYV8divI5nno5JFjEvw060wYHTZwknIr53b2iCGaFt+InNMPiAfZcCtbLOjZ1TngOzppzs572wMeKqDAicgwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774384615; c=relaxed/simple;
	bh=PFcXCNonN9OxMmpEqPpkdEfTykvXwMPab9Y9KMxRryk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dpNQ7pQInByHml3nYRv2oelcgHUJPKzrnCjgvPrCsozXHQwFP3Uf74i/OdkbhzmOtLfgc1gWteKPFGm+LaOx4D6bviiCIutnLhHHnxPlIu2CfeazdD1h3Xbr0Ned0jHePAC6gGYZGBHTETX8s6Es2agb2kI02NzZ02MwzFo6Fuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YecTlIi7; arc=fail smtp.client-ip=52.101.62.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8ML1sSUYJctHyrqsTxG8RgjIx9DvW2fyw4vEbTTnLXXcCUtkclxmBvn1lR7S8PpQ37iMvNTbBxyGKhYPN6Wl5PK0aNxfLsUWlcqiRK9vOOBaZNL4jc2gvNJ/Sq2Ze2qz72AXdszkA/z8Pt2mMW/UWDzB798/LEiReyokd+RWMEU+D89kHzd5SBu/V6VX9FM2x2ecA3D0HAhUQ9e8QaLSqlm+S6xLzE125IPOATziRhzO7VkmJOFAd9cLawATJjwOR4Yp7315k4/uLxpxVrmYjCmoxX0XOJ6nA3idYyLib7g3h7KXZInHDTbLUo1X2CPcbB5xRQJH9PbNUWdl85Z0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWjGFiuXUdnlnaM7XYDFlzxOV60B/r5WdLGBUzJmcfE=;
 b=GiYT5R+JjOErlVP+bPyzv3lvq8xxK6yQbI4cYXFzTcadZ2TTzPq4zpzknUh8i9RbkeYmn96vHJzcHW3dI9gf+QIb6jo6qGy7neHxNXLM0T1wxsMbb07gvBjlpm2GMylSy3H2VaKCdTx10lcfcUbHaDpEVn7ZHzIRO+XDyy3CphN/gGIl32VUIAyQZtiWboXc6gVAl4kFuIAs8KuW828rx/yMtyKy6Vqm29l+H7N1HbONVJ99lSaMbXfRcip8xQGwm7QZEl2lspV7M9PzoIwfW1NZltwW9Z6IoEEuwJAjCtMOxM+o+g85ev5D1Nd7BW3/eHgEn/R+UJ6umiHSS3ZeYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWjGFiuXUdnlnaM7XYDFlzxOV60B/r5WdLGBUzJmcfE=;
 b=YecTlIi7RpQgTHX0XrLxh82pdiKMyWuxzEVwkzyQd3gnmyK9PXcvzsHo8jtbjZndavT+aK5GwEndcKOHW66qA1UujZRW0Ohl3h6JLXsQoYMVkQ/06IJGFgHmOZbeeECVCRfiaEQjR9ygbdePAqcNKBY5sn/tIeCjTqYVAxvPZatBNJXX7t5P1WFLVae2dd7kUsW1o+VZe6c85B2bYtuDLbAFQnFWdpruV8RCFwffzL8z6BO13VwKJFhhe7c/JefHdtEJwIX9QIjt7mE8nv3D5rJ7qyiLf1mIr1l9wkJthRjDJdIWRNQRzkF1c97FiJ78UvtYOEA/ZcmfbSYooPyrAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CY5PR12MB9056.namprd12.prod.outlook.com (2603:10b6:930:34::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Tue, 24 Mar 2026 20:36:49 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be%4]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 20:36:48 +0000
Message-ID: <4a330570-0968-4b12-818f-bcb1db4ac818@nvidia.com>
Date: Tue, 24 Mar 2026 22:36:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 0/6] tls: Add TLS 1.3 hardware offload support
To: Rishikesh Jethwani <rjethwani@purestorage.com>, netdev@vger.kernel.org
Cc: saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
 sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org
References: <20260320235706.636531-1-rjethwani@purestorage.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260320235706.636531-1-rjethwani@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::10) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CY5PR12MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d8388b-0d41-412f-d93f-08de89e5125f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SESVxmEy4iT2tf2f8N7JCJ8mXdJ1flABnaHT3RxjRowGnLgh7c5BaW+aCQPo0EnrdhyAtFnDAnkgkeHXiDvg8dcsR+hcbJs/lc2IWweUdL/sVYZ05za8OJU/pJWR2oPE3pfBdXkklDxfpU6sP9nDUrn79FAHYbdoMVPIyiiuQip6B+AwsyM48igBEU0GMWQvfPxyrW7dC1hHX8gEB0vmculSTQRDBtIN2qxJHQAmlUv4g54TWoCDqadQ90cAK3Sk6WXr/0YiwT7x56n/hUiYcWsFaVUkcBIG3ZWpyzCZpAxSARr8bXoS64HIwBf40hG9KTbcmIdn6N6AisUkIk/V+guUQkvQNsLksu4oyahIXQN1sWvwV1ogYBIvjx4/JKCxYAJWhMABdg+GQWf5emrzwR5mu+Pgq/LOcwe4iHMDuEBKEIlJ6cWWTBka2YaXpHG+z9urHEIkyVL4ld7ryY9Vamn/qyPqwytNlMnHdX/iGEsugj+id7Bik5yzM8peozrpg6hnsBO5gEzjMn7YxU8a9EMaZxmbbMXdX19XqaPN88K5z61SR5af+vAw2v1U04G23CRJhtQ/Y/G0qe4U9YnvHB9aC+p+G7hsEbzTZ4Knw4xfBD5U3fEIFVLVcZjg1iknh89Vqhoxvr5sh4aP4lqCtvanEhjeMwKFoZ9FqBRQHeP7x6hYmF2neZJ3r0omZAaKBsDzyZNj+cC7gO98NzkBeNOUJV40fZNDMDfPG36dyLM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0wwb1hVdUlPWG9rdE5jeERxTzVITzhwMy81Q0h0aGNZNEdKbUZxTnFWa2Rt?=
 =?utf-8?B?ZVpQeXNScWNDK2h4dTRKQitkUWk0YkVYWENoZTJodUNGQVpwQVpaVTJVK0p0?=
 =?utf-8?B?WmQ3bFJIRUM1b3JQTDZUTHE4ckJRdzdVNDFOV2lieWJPMGUydStabGV1a2U0?=
 =?utf-8?B?OGJTYW5TYXQxYjEyeUtWZUFXZnhVTStVaG9uSlpoM1YzWUx2ZTRnTDEwZjJQ?=
 =?utf-8?B?aHlmbmxMbHdvOHltb1RVQ3ZhTnczY3NheUIxeGk3aFRtOW5CelEvS0lUMVB4?=
 =?utf-8?B?b1l4Ry85OVk5bitOVW5RbWVrMzU3VmF1eklXbU5LNnU2UktDQkpLY0VQQndZ?=
 =?utf-8?B?Zm14L1FLMktCdjJaUTU3dmlmYlEwNXJyblpiQmdBUHRRYjFmQnRvaXp5ODRB?=
 =?utf-8?B?VFpNSUwreE9xMUNPTUo4Mm9JSEo0KzRHTjJSQTVWakRKRGJ6VHlPNUdwQkpw?=
 =?utf-8?B?d0prYmxVY2JkL0R2dGg3K2VLTDR2MjcwS0lZb25qazA2eHV6MUdIVkx0aGQr?=
 =?utf-8?B?cGc2NTYzRnJyQitETllZdjlKZU9oZWNGSHMwZ2RRUndyWHBPVWNBTzRiOGMw?=
 =?utf-8?B?ZnFWY3VOOVAvOEdOTjB5UDl2NVMzMlhGVGtiWjI2ZTAzdmU4dXdtNXpoekFP?=
 =?utf-8?B?K2F1cU84NVU5M0dCbVhacm1ZZnduVVp2ZGZIVGJJcXpLaWQweENTcE5pTUVL?=
 =?utf-8?B?U0pTZlFCaytWblNpMnhuKzI4ekxFaWVUZm1FRWJ6bDZGSnJpYVllT3BzWVFh?=
 =?utf-8?B?Z3k3eVV0a203K0JqWXpRUWRBYXY0d01vR2RZYXhhYytQTXJ2SHBDczJQcVZs?=
 =?utf-8?B?dzVleVpOM3lyczQ0TUZ4alJuZU1BTm55bTFUUFl3c1VyWW96NWRKekdvdnRs?=
 =?utf-8?B?YWFVY2hscFdmTlB0SmtXNzVVc0hYZU80b0ZpbnBTKzJ1UVh2c1IvbHpjNktM?=
 =?utf-8?B?cWs3SWFTbmFScS9QTkMyUTEwWWtTWkI5QUhiVUtzSktIUTBzMTRNdG12Qnhq?=
 =?utf-8?B?RzdQd1RGa3JXRjJqVFVmSlFjVUpVSjkxb0t2a0JhSi80YnF3eUJ0TUVwOHNZ?=
 =?utf-8?B?UnIxM2RXL3hXa2lmL2ppbVV5SGVTVHpIZytXYWRWWCtyMlg3cXQrTzNiYjN5?=
 =?utf-8?B?dm5jN015dEJuQkdHS0RmbXJiMmtUemxUWGNFRmlrYndWcVk3T1BlYU1IZWNa?=
 =?utf-8?B?RzYxcjR3U0UzQ1pPSkdnSFoya2VzQjl3cmNINm0yTC9TeUliZzRaMHNlcDJ5?=
 =?utf-8?B?dURYczEyamt4ci9GQk9Pak96RkFTdFM4SlVXNjE1WWljQks2NVYxSTkzS21E?=
 =?utf-8?B?d2NnWmZGWk9uZ2Z6dTVjUWNzVzQ1cEJ2VU8veVhRczJjbkZxUjlQSjdWdkhZ?=
 =?utf-8?B?SVJBM01uUDdhMitwUDB6TFFqOUF1WjQveXF0K0tvQ2g1YzdwemZqRC9jQmFo?=
 =?utf-8?B?Kzg4aks0T0lSeHNvZDdMa2MraTRiTlRWbUYvTll0aFF3SkNxeWQ2eHBNWi96?=
 =?utf-8?B?UmsxVC9LSWVCV25Qb3N4dnQ5bjU3RitkRytLVjQxR1ZycktRak5uK1N1U244?=
 =?utf-8?B?WlB2ZklKOXBRNGFZS1VpTWxTR2VLR3dwNlY4ejB0NnZuSEJ2ak90QjNXVTdT?=
 =?utf-8?B?aUVUTTNiOWhhV1pNclhUbEJsbEpISzNLcWNrbzE5Q3pISWhxaURHWlkxQmxv?=
 =?utf-8?B?Tm9Sak14YytqN2k2QTJsYTRtcXpjRWJyMWFlcVBpaXdpbE1kRUZVY2lkRGVJ?=
 =?utf-8?B?QmtBNGdFdGxBS1NzNit4WnJvU1k5TXJLKzhtN2lSa0QxZmlzREQ3dlpCellL?=
 =?utf-8?B?aEhweUh3MEpUckhOODE1aHM5ZldTcVlza2R6SWx2aW02NHNxL29ZZkp2WEZ4?=
 =?utf-8?B?N0pWc3ZYM082VlRodU1zajJucE5pbVNXT3FHT2N4cTZpNUUwSFZLK0w4bU5U?=
 =?utf-8?B?bzRSeHFmcng0aVdIV0JuL3dVNVVrZ3dDRHNTUmUwdUw2QU8zK3dMTzJkT09v?=
 =?utf-8?B?YmZVY3lWWWpUTkhzckRyM0pRZkxzN0pYMDBuNUxHRkJaVGJZRGtPTGUvUnZt?=
 =?utf-8?B?TTVEcDNZS29uTGJ0bnZJd1FyVjlCTnROWGNML2JsaDV2MUgvd0pnQzJnY3pq?=
 =?utf-8?B?anhhOUpTNnlmSlpyakRLQ3hSNWVmb2EzM2FQMDdwZHR1S3Q5UG5XVHVFcVBp?=
 =?utf-8?B?Q09tZjJMK0dGa1VwS3VqQ1FsOU83QWRUUGdNZXEwL3QzUWdJTkZVY2JnYld5?=
 =?utf-8?B?OVNYZUJEMldDVDgrUHYzTHJTQXJGUzNqY0kvRXBQcjhvekpDaDE4Ym5PN0o3?=
 =?utf-8?B?cWJiN3dVYUJUV2ZGanI2WG0xaHRSNk5JS2J0OWZvZ20wRjVkbnNjUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d8388b-0d41-412f-d93f-08de89e5125f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 20:36:48.5613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EhjtaFEUDrFhJPNSfDDNPYhbXFfMaUFns9gewOIeFzjYwYCUGZhNLZtsJLTDAPPt8b4HYDFpjT2vogrCQK4+nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9056
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271288-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13C3531C639
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 21/03/2026 1:57, Rishikesh Jethwani wrote:
> Hi all,
> 
> This series adds TLS 1.3 hardware offload support including KeyUpdate
> (rekey) and a selftest for validation.
> 
> Patch 1: Reject TLS 1.3 offload in chcr_ktls and nfp drivers
>    These drivers only support TLS 1.2; add explicit version check.
> 
> Patch 2: mlx5e TLS 1.3 hardware offload
>    Add TLS 1.3 TX/RX offload on ConnectX-6 Dx and newer.
>    Handle 12-byte IV format and TLS_1_3 context type.
> 
> Patch 3: Core TLS 1.3 hardware offload support
>    Extend tls_device.c for TLS 1.3 record format (content type
>    appended before tag). Handle TLS 1.3 IV construction in fallback.
> 
> Patch 4: Split tls_set_sw_offload into init/finalize
>    Allows HW RX path to init SW context, attempt HW setup, then
>    finalize. Required for proper rekey error handling.
> 
> Patch 5: Hardware offload key update (rekey) support
>    Delete old HW context and add new one with updated key.
>    Graceful SW fallback if HW rekey fails.
>    Track ACKs to ensure old-key data is flushed before HW switch.
> 
> Patch 6: Selftest for hardware offload
>    Python wrapper + C binary using NetDrvEpEnv framework.
>    Tests TLS 1.2/1.3, AES-GCM-128/256, rekey, various buffer sizes.
> 
> Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with TLS 1.3 AES-GCM-128/256
> and multiple rekey cycles.
> 
> Rishikesh
> 

We were able to verify one of your previous patchsets on our systems.
It looks good.

Tested-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

> Rishikesh Jethwani (6):
>    net: tls: reject TLS 1.3 offload in chcr_ktls and nfp drivers
>    net/mlx5e: add TLS 1.3 hardware offload support
>    tls: add TLS 1.3 hardware offload support
>    tls: split tls_set_sw_offload into init and finalize stages
>    tls: add hardware offload key update support
>    selftests: net: add TLS hardware offload test
> 
>   .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c |   3 +
>   .../mellanox/mlx5/core/en_accel/ktls.h        |   8 +-
>   .../mellanox/mlx5/core/en_accel/ktls_txrx.c   |  14 +-
>   .../net/ethernet/netronome/nfp/crypto/tls.c   |   3 +
>   include/net/tls.h                             |  79 +-
>   include/uapi/linux/snmp.h                     |   2 +
>   net/tls/tls.h                                 |  18 +-
>   net/tls/tls_device.c                          | 554 +++++++++--
>   net/tls/tls_device_fallback.c                 |  82 +-
>   net/tls/tls_main.c                            |  33 +-
>   net/tls/tls_proc.c                            |   2 +
>   net/tls/tls_sw.c                              | 105 +-
>   .../selftests/drivers/net/hw/.gitignore       |   1 +
>   .../testing/selftests/drivers/net/hw/Makefile |   2 +
>   .../selftests/drivers/net/hw/tls_hw_offload.c | 902 ++++++++++++++++++
>   .../drivers/net/hw/tls_hw_offload.py          | 281 ++++++
>   16 files changed, 1911 insertions(+), 178 deletions(-)
>   create mode 100644 tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
>   create mode 100755 tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> 


