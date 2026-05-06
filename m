Return-Path: <netdev+bounces-284943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNWDGIVr+2miawMAu9opvQ
	(envelope-from <netdev+bounces-284943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:25:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD744DE139
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58E32306A2BA
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 16:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BB848122C;
	Wed,  6 May 2026 16:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s4diYnpu"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010051.outbound.protection.outlook.com [52.101.61.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79744248F72
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 16:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778084239; cv=fail; b=qzcS49EWb0/evG26+3c5M7TxlxZSbUMXJ4sgc1GCs7yOJGrXIe9T2cBjgeeE57gJCHT+pfiYPZKFPnfTt0Kkk4sT0PKw1K4QlIxNZYcNuiyXR4lvl3PGUJDhAS1714ucUtwQoVRtEr5cgN72P58YxjdcYVK0NqLewsd3kK2j4Cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778084239; c=relaxed/simple;
	bh=YHVGHpKllli8sG5rq8BrqahYboBCPVyxw/zNCAtjXZ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uTD4ev+n605wkSQwrs4wV2pVhxR9PIoT0H4IRydcEHJ+nWIerqbXkIFI233beGI2fP65y/4rDXp9N/NlvJX9/g13otDJ2cepVCW3Jbk5YmgWblnW+5LEVIMEPNhyiZMNCojtKifm44H2o7vXe+s4DuI7azq33y4LnaaPOHNGLzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s4diYnpu; arc=fail smtp.client-ip=52.101.61.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAywPH9veZJFX7qcO76ufXhBSyiQRcJW2FOHMyMEmlzkkpci0yy2CJOgJ/UthJR/qQ0aPdKyv6cen0VGihJVFc0mArxqazvdC0VmVABZ7SEfL+NzJ2LVjKT48NGjt2wOhYLwyPtyTiMYv9Kmy70HETTzJ0gq6OL/rZir25xEI4AYdanFQWhri82GXcEOZs4p8VJ5Ej3UFNem7spMsrCftmKiFH8cT7e76F/ox9jCbRX2NOWUSfDLWvUu9hzV5CXSIZZcyBLh+fWTAQR2LaQi2Y0ED4Ft+d9RyJFLutnznBxXprF6gXQWiUjbzhyYVi/lO+8W1GvKAi1CpbOSTDa79A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBfrZmwOpnL7BL9RS6soBewAoYMKO8NKux43U8DdWFg=;
 b=IOsEgdkWnwI9F4TGC2cB0cjnfnSk3BGmGgafMdphNfRDFWmyjoHZRDWxQjZF8pHg9VUP8rgCgeCgRgNwmXhJNBeEMvXM4DkV3MSRyCOVsq4tv9PjBMx4H9oW6wWVbpHA1Z8zl0jCJI2t6/h7eOhDePkitpdgRAGIe6+CNrXKSSvS4IFqXprdZE8fh3mYFoGaej/4xFdzK7uEfUx0KQcsRVXJgVPkXnJnO6KTfeGhS0bGIIHibbULoGWrIMbVIxmF+NXOavhbwWzUZAbyn/ZKvf5lr2bm2KQHTKqU9FLYR3Ck1yrrXfB1Ub8hpGxqnSHNMuEFM4QxZoBS5yDBp0HJYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBfrZmwOpnL7BL9RS6soBewAoYMKO8NKux43U8DdWFg=;
 b=s4diYnpu25mi+g7HutvDny9Kc8uyKbYKUlSpXHa45xOwi9AZLSQE0a6RAFnsO3HENKg6VtvC4XOorXWHIpOxyJAgUsbCHY3SuxHRMOCbjXp3vtGMCRRmQ+kPDfNkJ5fxyfhRyYGvsrw/PunMVuOAlYniAHmxExwPKbgPw/t4odI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) by
 DSWPR12MB999127.namprd12.prod.outlook.com (2603:10b6:8:36c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.15; Wed, 6 May 2026 16:17:13 +0000
Received: from DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a]) by DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 16:17:13 +0000
Message-ID: <88195eaf-a767-4107-86db-24fe46962f3a@amd.com>
Date: Wed, 6 May 2026 09:17:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] ionic: Add .get_fec_stats ethtool handler
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org
Cc: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20260501031555.43259-1-eric.joyner@amd.com>
 <20260501031555.43259-6-eric.joyner@amd.com>
 <6eabe3df-08b2-4237-a989-a8e3a9bdf37f@linux.dev>
 <e5d3c314-e6b0-4f18-b17e-752fea4dcb16@amd.com>
 <45677056-ff03-442f-a7dd-19d34c7b612d@linux.dev>
Content-Language: en-US
From: Eric Joyner <eric.joyner@amd.com>
In-Reply-To: <45677056-ff03-442f-a7dd-19d34c7b612d@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:a03:333::16) To DS4PR12MB9708.namprd12.prod.outlook.com
 (2603:10b6:8:278::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9708:EE_|DSWPR12MB999127:EE_
X-MS-Office365-Filtering-Correlation-Id: 70255a1e-7ac7-406e-e3a6-08deab8aee78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|13003099007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7WRHDotYqzVvhBHZLzQtR3muP11qIeEH7BSJheIbaiFrPDtYSRmFKFXLEUoQwSjjcostd2eHiNwAOw73u1XjIgsPG3r96yY6txHWUOPx1DW5xs8ltIWCUYLORc8ADgqnGQhUeKugLEYFIMyerF90m32/hJQNhp97v2iBcM280RZJjUPxCIDhvkNJdIH70ugCr/l0C2c6ER0Slql9IRhMwWJBQDQTD0AfpjVY1B7Xp+TXoSWACPoVAVhWGXJZpMIN1By31b901UkvoU22Y8ndFBkVMhkCOMwCk576k7hInv3v0wq3g2vE4eXtRi4JM+vM+yOWPFPQZM80Ex4QfABHcstNNJT0NqHJrjzm2C8UdfQ6I0ibpd8mQAOCVz/2bbksm6OQn28CbhWTGydeFHqZeOQNpLunRDVjgkqa2+FdPonak19XQtJ0x+v5o0BEv06cokrFLOvxedPWFN63FAZ/HfHmRDKO8BlpfF8hdgLnVGY2nkgbn04YwXphg7MqSVHagGagvxOCbMAL2x6fY/1FqZMvO1gapIxoOSbnSpvsL7mKzBtl50Igt+oQxNlhbMUG6cTX/fDhcQs0oPGUI6Jsd6M4DwQtf/jbH21eRIpiEaFNmB2Qk2pnMTEKr82hruxONu22/YHBeDLwT8OLJE0mlWBYQei+MPOez8mym955KokP3NGR68rYMojoqcNXWtWN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9708.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVhaQzFONlRKcmdjaDRyWE8xZWhBdzVTdW9zd1hESEdqRGk0TW9SRmN4MWVJ?=
 =?utf-8?B?eVN4ZlhnQ1dGSXVjbllibkZWU2tVZmFUMmZvZTQycURWaXJiYUZ5ajFUSTZJ?=
 =?utf-8?B?SGdLa0l1cjI0UmltWHdVR0RzcDBkTTkya1dzWW0zOHM3Wmp2dzFvN25teDBT?=
 =?utf-8?B?THJaMTJzRnhzRkVwTVhDTTZkVnF0eXBoeVZOSHNuK2hYRVliNXZJWkd0Rmpr?=
 =?utf-8?B?RTlodVhMdXZGelN5dlQ3VEdKb3V2Vkl0NWxORHM5bjRaT1dwckdSb05vcjdE?=
 =?utf-8?B?dExTY1JoRUR2d01sazdZR2FGVWxBbENhb1hoT2tQMStHTkMzWjBIYjR3L2o0?=
 =?utf-8?B?SWMwZ2NxTW5MRFRPTm40Z01OdmdqaWMvT1JJMzJkZ3NFMmRRemhXcU9Xb3pQ?=
 =?utf-8?B?VWZ0RFNZVUV5Q21ZN0pZcGpGanRqenZjTjgrQWY0Q0k1c0dPRGd5TVlQelJs?=
 =?utf-8?B?V0lFTjdiUDhHbE9RYi9Ja21PNTJBcTVNa01oMzNMd2l2Smt5ZGh3SHk4eUhE?=
 =?utf-8?B?L3JFRVZVbmpHRHZqTFZaYzRPbFJ4eFhlc295UER0QmtaMHcxbzA2dXhtczJE?=
 =?utf-8?B?UGpFTEs1R01zUW16eG9jd0ZhcUoyWDl6YjFJOEpOcEFrTi93V3RBLzJDVWV4?=
 =?utf-8?B?YVdua0FkZjVUcjMrRkUrZFZDTHBRRDNydVJjcHhMcUk1cjF6WWE4ckx3YWVB?=
 =?utf-8?B?RjBmRDJ1Z0xQeWNZOTRYTko5UzhEdjJYdUtDczd1OTFVZnRiL1BuUXh0RFJK?=
 =?utf-8?B?bVhrUTQxMXZ0YzNmRVlqR1VyK1dDQUdydkl0TWdmcmNIdjlBR3FPamFhYnRi?=
 =?utf-8?B?ZzZacGxBdHJONUxmSUN0SDVZRGVmanFkbTMzNjNjbHFiamh5Nmx2UHlJL0tY?=
 =?utf-8?B?TUU0TlVEb05hRFFTQ3pCWFpubHpwcWZud1JkVThDMTlqRjJvbFUybUFQWGdG?=
 =?utf-8?B?WHhjUWhWaExWWEt4QmRsQmgycytkbENjQzZGTDdLMVdpZGlGc00vNEtkMkQ5?=
 =?utf-8?B?QzBXblJxbkVYSkdub1RNeldvWVhYTmg2cENmUkNWZm8rdEpRWC9TNDN5MWd2?=
 =?utf-8?B?ZDFBT3krTGZBSnA5NWdaSGw0emhYSHR4dGRpMC9URTRjQUEzc0NNeklwQXdS?=
 =?utf-8?B?U0VYeDFEOU9wdUQzdFhtOTZtVGNoeHBOSklSMXNxQ0FGUDNPdjFjRTE4ZjNG?=
 =?utf-8?B?aGVGTjhGRXh6RFVwQm9WYmhxbjZCZmlWVXoxVEV0TkpLZjVBaFFBMUdMYVVv?=
 =?utf-8?B?aW9wRHNWVlp5NVdpQTE5YlRCbllwbzNRemY1MDl2Y0tRK05GS0pHekRPbzZS?=
 =?utf-8?B?K01BR3pmU3RWbkxDQ0N1VHJ2V1Q3V01JVnkyUENaSzFHTGp2YnZMTEVUMmdh?=
 =?utf-8?B?UGFabjRtNkR0ZnVuZXZqV0R0UFBKcU56a0VEK0ZhTUpJZkRBamxCRVN1RWc5?=
 =?utf-8?B?b0NGam9oM1lBMi9VTnFqR1NKVEFPa0FpbE5ROUt2dDg2cTN0WlNlaWZjNWVF?=
 =?utf-8?B?VkFrNU5hdTYzdFRFMWtwQWR3akI0bEUzbVZPeXZoN3dhVlhPT1dpQTVCemJI?=
 =?utf-8?B?d1ZMOWNER1BqUEtaYkRtUXlROFJ0SnEyb1RBNGxtRkR1UnlyNVVLTC9rclAr?=
 =?utf-8?B?ZUJuZnpkQ0NDTkpiVUdDRjdNbjMxZnBmbVhJMkVwZ0VaNjhXK2t1LzRGTS9I?=
 =?utf-8?B?VzFidk4xVUVYOUoreXFmMDQzdm14T3UxWFVoQ2JldDVPamp0dFJ0Q3NOcUJt?=
 =?utf-8?B?T2dvSzFsWG84alRLdTJpR2VpN3N5UytYY3lsci9wblN5cUhSZW5wZGZNMTE2?=
 =?utf-8?B?S0h0MmhZU1o2aWhuNXlhbWxTQnIvSjRtNEJiQmZ1VVh5WVJYVUZGQ3JaUkVw?=
 =?utf-8?B?K25HbjZMc3NwR3I1L0NXY0JWTi9xeTAxMHo0OVUrL3QycXZ4RHc0ek1rL3Qw?=
 =?utf-8?B?dnpTYVVSTmF5OGFVRVhBazU4dzZZNkF5TFVmU3BxajNPK2RpVFFPVlc4Wlpz?=
 =?utf-8?B?bFhCa2xmanYzVEd1RjgrVTNkNGdyVFA0c2tpcm1YUTFWNWpYeG1ZS1ZrZE5h?=
 =?utf-8?B?a0I2aXFNQzRVUUdIUGV6S1Z0SFgxdWp0ZVZDNk9oWjZ0ZEdxUStKeE5za3NF?=
 =?utf-8?B?NGJiUGpvb3d1ZzFEY1JOSHIxQlUyWm9CMDhJTmEvUTNKVUtWb3ErQngyTzFK?=
 =?utf-8?B?dHNPMXJzT2xMNzJhQmlnVXNXMW1RbFUyb1VvbmJ5Wko4UitHQ3h1UDlUZVJr?=
 =?utf-8?B?YWVmdlUxV21STC90akZ1aFI2TUZBbUEvNEhiUjM1VFdQVlJtMWVqOGthdWNH?=
 =?utf-8?Q?73DiGh71YZcfkuWAC9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70255a1e-7ac7-406e-e3a6-08deab8aee78
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 16:17:12.9417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwIwNtGcCki5qIZDO0m7dhxH8x6oL7O0NICRIB2oLjBEl6JxX+LAnAw8zuaNSAGF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999127
X-Rspamd-Queue-Id: 5FD744DE139
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284943-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[aka.ms];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,aka.ms:url,amd.com:email,amd.com:dkim,amd.com:mid]

On 5/6/2026 3:00 AM, Vadim Fedorenko wrote:
> [You don't often get email from vadim.fedorenko@linux.dev. Learn why this is
> important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Caution: This message originated from an External Source. Use proper caution
> when opening attachments, clicking links, or responding.
> 
> 
> On 05/05/2026 20:43, Eric Joyner wrote:
>> On 5/5/2026 6:54 AM, Vadim Fedorenko wrote:
>>> [You don't often get email from vadim.fedorenko@linux.dev. Learn why this is
>>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> Caution: This message originated from an External Source. Use proper caution
>>> when opening attachments, clicking links, or responding.
>>>
>>>
>>> On 01/05/2026 04:15, Eric Joyner wrote:
>>>> Several FEC error statistics being collected can be reported in a
>>>> dedicated ethtool callback for FEC errors, so implement the handler that
>>>> does so. This includes 802.3ck FEC histogram data that some newer
>>>> hardware collects.
>>>>
>>>> Assisted-by: Claude:claude-4.6-sonnet
>>>> Signed-off-by: Eric Joyner <eric.joyner@amd.com>
>>>> ---
>>>>    .../ethernet/pensando/ionic/ionic_ethtool.c   | 51 +++++++++++++++++++
>>>>    1 file changed, 51 insertions(+)
>>>>
>>>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/
>>>> net/ethernet/pensando/ionic/ionic_ethtool.c
>>>> index 78a802eb159f..fe1f753b6115 100644
>>>> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
>>>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
>>>> @@ -418,6 +418,56 @@ static int ionic_get_fecparam(struct net_device *netdev,
>>>>        return 0;
>>>>    }
>>>>
>>>> +static const struct ethtool_fec_hist_range ionic_fec_ranges[] = {
>>>> +     { 0, 0},
>>>> +     { 1, 1},
>>>> +     { 2, 2},
>>>> +     { 3, 3},
>>>> +     { 4, 4},
>>>> +     { 5, 5},
>>>> +     { 6, 6},
>>>> +     { 7, 7},
>>>> +     { 8, 8},
>>>> +     { 9, 9},
>>>> +     { 10, 10},
>>>> +     { 11, 11},
>>>> +     { 12, 12},
>>>> +     { 13, 13},
>>>> +     { 14, 14},
>>>> +     { 15, 15},
>>>> +     { 0, 0},
>>>> +};
>>>> +
>>>> +static void
>>>> +ionic_fill_fec_hist(const struct ionic_port_extra_stats *extra_stats,
>>>> +                 struct ethtool_fec_hist *hist)
>>>> +{
>>>> +     int i;
>>>> +
>>>> +     hist->ranges = ionic_fec_ranges;
>>>> +     for (i = 0; i < ETHTOOL_FEC_HIST_MAX - 1; i++)
>>>> +             hist->values[i].sum = extra_stats->fec_codeword_error_bin[i];
>>>> +}
>>>
>>> ETHTOOL_FEC_HIST_MAX = 17, you defined 16 bins, but iterating over 15 of
>>> them. Looks like bin {15, 15} will be lost in stats.
>>>
>>>
>>
>> This looks correct to me -- (ETHTOOL_FEC_HIST_MAX - 1) = 16, so starting with
>> i=0, it'll iterate through the 16 bins and ignore the 17th end marker bin. Bin
>> 15 does get included and gets its sum set.
> 
> Ahh, yeah, you're right, smth was wrong with my math yesterday. btw, how
> does it work for different FEC? RS(528, 514) will not give you 16 bins..
> 
> 

According to the datasheet for the device that does support reporting these
histogram bins, there's no support for "Clause 91 RS(528,514) "KR4" FEC for
100GbE". I only see support for PAM4 and not NRZ.

- Eric

