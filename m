Return-Path: <netdev+bounces-266170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLEtNZIysGl2hAIAu9opvQ
	(envelope-from <netdev+bounces-266170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:02:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 851BC252CC1
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74722330B5BD
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F25391E4D;
	Tue, 10 Mar 2026 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P1o5e2V+"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012070.outbound.protection.outlook.com [40.107.200.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3B3391E4E;
	Tue, 10 Mar 2026 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773151338; cv=fail; b=dBUv9VVPQMUGIWMzNeWuivl6d0uH2DQUu4czD6tRJYtKDeEd6oT4JxqBXvrjWBK+sYV8FACvXpx7IYNzlq9KGpwVltu8noMfschPmgq/b5OhOH3d56yb0WVKhGFnx7G7J7KKwGUWePuqVFTqCvPxgEQAaYtwz/3CdaCzCGa1Ebg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773151338; c=relaxed/simple;
	bh=2UZxsqP6vU0rLwx7dnQ09Lvs7EF/scr9RZg4jq2kzLc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rejMrz/uk8Vm3xNWX/DDefWJiLR48+LpkcEnCmyovRsfcpn10hrymKEwRrqFD5NnmxBOto9Sj29HRrkRlS4nqAXrMFZuFihGiIAWBP5HjqbdCszrLHnzfCETSpK6IQyKu6yMHu+FVq6MdbTBbi4lhP1PyP84TDlbjBd1F+okUu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P1o5e2V+; arc=fail smtp.client-ip=40.107.200.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llrGw36ELLVLhrhbCdkGWtFW4kxTZAP+MtiDFuwWQT35fVziYjlzSqP2HHVNcK3PAglY5tHMDm2GkmNE5i7btl+py+vt9deona7uxofk3EVUeAhDWj1OmYRJt8UgnAR4d4A5u08enuvHSmQ+YgxFI5uxpRG5Qo4gpNqxXp8YkxWfMKp/F+dYAXXt4zjo6VkuDvfaM4aa3ib9BFCxC/vxBO9MR+lPkm8f0KlS4rwyhPbwRXu03qiCoIllodQmH4H/fFn0v4eRQeWbF84LDkbMe2SFDZubtgvHBan2G+MOe9jGMdnUeFPlP8jVU08CJ2NtvY5yGo3jbqoogf7nLvCZsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDK8MRD8prgGiIN+N5sAHzEQ8mwF4ycC9ynTrVMLOCs=;
 b=E7m/Nd5FASF0/9+qlhJxK8P1LmOvlC7b/kVMxd6WR6ZPA9GZftLAT3Ewp6xtSYYLrP0w6muHQMDy1d9hq9H8Q3XLX3rO/nBmCHmZVCXlJSQ0DeRonmG/XPJEmFMvUxJpDGWrId6WWXieIP9nAJW/WTxwkip0JbUuXpYKu5av88GhPcYLmsW+8WOXAVKlSfQOfpftV3rTjkE+MbsjtRPfpl06tIyLRlrFOOaJuK+jAi4/zYIRESpTGZE9w0qS7r+8ZOZ435V+EmiVsWWCbrs8huYwRxWYxZF0t4V51YkoKsxb6x3+EGLTFzxO49eZxZIXkN2rFB/kDUi+eyoFl7gTOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDK8MRD8prgGiIN+N5sAHzEQ8mwF4ycC9ynTrVMLOCs=;
 b=P1o5e2V+MjtjvdelzhDc2Ztoct99y2ubkwrVGObE/Gi77BKir1sbNIww6Oa5s/oNBkqQXKO+Aiun0JGK7EuDMgPFjwey0RLrsEo2a2RqWjpqBClRhPOPjRoBAkkKvPyehPohJOtJA6NgMJRrBHyV0EZYOEW50A8uOxE/d5HtrjA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY8PR12MB7731.namprd12.prod.outlook.com (2603:10b6:930:86::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 14:02:12 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 14:02:12 +0000
Message-ID: <39624055-28cf-4def-b6ac-12256b1da681@amd.com>
Date: Tue, 10 Mar 2026 14:02:07 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 00/22] Type2 device basic support
Content-Language: en-US
To: PJ Waskiewicz <ppwaskie@kernel.org>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <1e617ee5e6003994d41a0a270ed1f6b17ac75f8d.camel@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <1e617ee5e6003994d41a0a270ed1f6b17ac75f8d.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0067.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::17) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY8PR12MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: b370991f-4c1a-43f3-c19e-08de7eada054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XstSvagLaU5I+cRiT7jELkvybqDlsje0nPN6x/HXFzWyOSNFowkbfH+YzK/Jv6k5pXcWLf7EMBdSRCwjdCovqh467bjoh54SQdtLjciKvAyya9w52yIx81n/8uFoiBhnQyuowOVNDRqfidCTCWlniQ7fgT43kqze/aJ6qcbTzAczfi4paA19zT4hwkrw/DG3yJn2iN9gRUOqs/lE8lj5wl//f6PP/xwQDE6WRZ1dM4IopldesqLAFpoGnLBQ9m0sJ7R1xtaKQn3KAnrCIqJgNvZGvksGOjFI7Usf08LNbVpg3xYxw0eA8X5WjG8KcfYfz+irWqAVnHAcMAdIeusKUMnRo0F9wbB3XZEOZqDQ/InBe4Mq8wEoPoUPmVIEIKBDAkSfSQ6lIKfqMsUcO9n5kr2T8UGFGwker2R38tCrStX0PZ8q+8wNy6NSeYQvqknK61yVF3jw49lMu/eLaXjSV8+fHiI26QCuZX8k+YoWXswQK6Ut8iz+NPZiHsi2hy4UHI1gyNIaJ7lA4ZDoA5uvE/7qEyajb1GPJs2E+8CmnZn4LgLOwtQn15jI9S2NMsGa3udg7MVhVKGJifgvgNbeD/w+Lz20Zox4UxvwL4/EwgsWqHgA7VTRJivj7HWzI7/ryer/AxxDPI0SrbYoZz0k8fPWOueBTMsDN1aBzyAEk9PUdcmOuSpyQH8/coGQUgvLAAi0xE9VriqFDnIPc24LidisPF9QNb0qotR+bTk0kDASOVaPppULvMwoKibUzxVTM5oaVUsCt4ip1AvOoXQjFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkxUbjIweHFwcGVUNUM4OU1lTnRSQkcxdWlFQVBBVlhMcVFoeWYxMjVXS1Vv?=
 =?utf-8?B?RnVVaUVCSk15Y0dmV3FoRE1DSkVXOC9uTU5GazJOMXVrVDhHbnJrNElSS0tM?=
 =?utf-8?B?RUN1UUN4Uk9vV2lyRmt4ZThGcERVSExBL3ptMjdmeVpvaUhOZTUzN09EWWtX?=
 =?utf-8?B?SCtvTnNqamtwTXRVSkZma0tYOFd1cFlQalNFeFJPd0tJZi9zZHlzVkFTaXJG?=
 =?utf-8?B?VXlNTllIbUUveWNRNHI4ZkFKMXN6QmgxWFZ2QVhNNDdwdjFETXZXQWRzVFZY?=
 =?utf-8?B?UElZZTUxT3lwQXhPV3ZMVkpxTmp0RzRKbW5nSE1Cd0dIMEFPVXNRaTc5QzJK?=
 =?utf-8?B?clEwOC95czZsekZMdlJiSXllOWo4MGN2YWMxU0tSOFpIVWVmVTNNTDZ5ZzBI?=
 =?utf-8?B?a2hpbDhOaHZhV3J6UmRGc1BqU3drNjZrV0N4aCtWVjNINys2L2ovOFN4d1ky?=
 =?utf-8?B?SzIxcHNxLzlkejB6U0hqQVoyK3N1ckFDdWtEd1dhMi9OSUxnbUpXRVptM1Rr?=
 =?utf-8?B?TklMVW9CRERxWHBKN29nS29wSSsvUWxNQ3pOUHVoRndiZ252QXZDbWF2bGZp?=
 =?utf-8?B?SUc1dWU0Rjdta0ZrWEVqaklXQkd3clRkMmlkcVpPS0ZMRUcrc0RzUjlkdStM?=
 =?utf-8?B?Q29OdlhOQ1NadzRTMzhId09GYUxQNVdlNEE2N1k2NjF3T21lK1A5VUY2bml0?=
 =?utf-8?B?OUJFc1ozN1Jwek9CWjhkcDFtUUdKQkFxYlZjUmlubXV4bXlqYk50RllUTFhV?=
 =?utf-8?B?ZHBobGtmVWZDdHNQY0Rvei9JNnVqbEIya0ZCUURpbERhdURVSHZ5SGh1UU9Q?=
 =?utf-8?B?MkpKdU1MaEw3ZTcvUzl5a1UwLy9JMUNOOTFvTC9XSmVVWEMrQkN0aWlKanNJ?=
 =?utf-8?B?R1BFemMvYUsvYzdTajJFZ2UyTVhvK1F1a3lKSXBMSDVpdExRaG5OcG4yMDcw?=
 =?utf-8?B?Y1lpZjdDR1hnb3JjNEtvRDdqQVpTVFQ0M1pVTzIwZzdKbUFPeWp3Y3BaQTlq?=
 =?utf-8?B?VjJxMDBtQW9wZXRtRUhQQ0ZXRzBuTTl1VWdkbXJtcTUrTldsUzVKMXFzZ3o0?=
 =?utf-8?B?azR1QWcxR21GWk4yM2JrRlhjUEhSeGRtU0lTYm4rbCtrVytMSEc4MHlRT2pj?=
 =?utf-8?B?M3hjSzZldWJPRmV2V1ZNL0s0VDhDeXo2Sm1iS0l5U2ZyRXVHV252elRzaXRL?=
 =?utf-8?B?b0VITC9FS3NsWFVRV2JyR0trdnY5UVoybjdXbDF3ckg2SVd5bzM4MDVGMUVx?=
 =?utf-8?B?M0x0aVRFeG1lZFpWVTBhREJxMFF5bHlhNU55VkF3enpCSzd6aXRmemhER0I5?=
 =?utf-8?B?Qk5SVzkvVGp6OTlkRmthQnZ6TWJxT0J5SmMrMTBuckUzZm1jQkhzOVJwb0Ja?=
 =?utf-8?B?SUowRHlzNDhxdVMzQ1RrSlBPdEFMaCtsMUNSeTg4eEg5VTBYY0RIMjhMdWpX?=
 =?utf-8?B?ejFZNlQxNFgzOU45S1JERURFTWpNODZFVjlYV0Rvbk9Da3UxQ3h0YjE2TTZ2?=
 =?utf-8?B?WUZVamR5dm9wRzNmSzZpcjhOVE5BZmoxSE1IVWZ0bFluYmtmL2JtOHQ3Unh5?=
 =?utf-8?B?TThYSi85SjRrS3NxU3BsV0ZIV3lRbjFJQmxqNHRaY2RDcXhvdFVZYWNyVStp?=
 =?utf-8?B?Y0pLa2ZMY3JaaW9IWjYyaU53dTBVRTE4N0xaYTFOS2F1VGJPTFRNRVR4ZjRM?=
 =?utf-8?B?U2pxZjFUVU1FZ0pyVzVoOUlWZE01M3NxSWhVQXZXUDJxSDNlN3k3bjN3K0gv?=
 =?utf-8?B?dlBYaWhWWE9Ma0dTL1Y2eVdzaU12c3g5UXh4SUlyRHFST281QUxqbnVoV2pD?=
 =?utf-8?B?T21NR0lYeFA1WkVRUm9QZXNhSjJabUd1ZjNlSlZrWk05MzdIU0kvZ25DRW5t?=
 =?utf-8?B?OGdudHhJNDJTRTJqaHUyR0htQnlqeDZOa0Y3Uml4bWVVTDZMOFZabXdrbTRh?=
 =?utf-8?B?QWlTSTR3ZnRLRkNvRndnbkhRenIvWGxPWW9RaVFhenFpTkJMNWlSZVpFblJN?=
 =?utf-8?B?TGZLUCtOeWs4R2JDSnZiS214RWlselJIdWgwRFBMeWVHRTFSRHFzdlVYNTYw?=
 =?utf-8?B?SDV0OWxhYWhYWFBNL3JWTU43eFcrek9WNVV5UGdMZUtyVnRuZEJTVEdaMTJN?=
 =?utf-8?B?M1V4Vk1jb1d3NHI3ME44dWZuaHVUTkhDcVhxbmFHKy9YQzRpS2JIUEYwdnhK?=
 =?utf-8?B?cDd6b01OWWJDNWhWTUdvTXdYOUhVVXFnWDJ5c2o4OVE4bjgrTDBhN1RMRk1l?=
 =?utf-8?B?RjBRZ0kyOUoxRVNxQ3lHRUJOaXdpS3ArSjRDOWR3ZDEyTEJNTzF1ak1ocGs0?=
 =?utf-8?B?VnZ2MVlwWHRYd3FkWVlTcWNyeDRybVdockR6clJqRkdpRGp3WWl5dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b370991f-4c1a-43f3-c19e-08de7eada054
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 14:02:12.0153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4mcPJ9nczKtVzmLYInKXFbPiXipv6IEYbaPNC1Sv0zLx9bcXfWXQTyOMIT7en2bEun0N6y8vRrPboyIe4uL+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7731
X-Rspamd-Queue-Id: 851BC252CC1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266170-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[amd.com:query timed out];
	DKIM_TRACE(0.00)[amd.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[alucerop.amd.com:query timed out];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid]
X-Rspamd-Action: no action


On 3/9/26 22:43, PJ Waskiewicz wrote:
> Hi Alejandrom
>
> On Sun, 2026-02-01 at 15:54 +0000, alejandro.lucero-palau@amd.com
> wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> This patchset should be applied on the cxl next branch using the base
>> specified at the end of this cover letter.
>>
>> Dependencies on Dan's work has gone and also on Terry's as the only
>> patch required is now in next. The other dependency is on Smita
>> patchset
>> but it does not exist such a dependency as that work will not avoid
>> the
>> problem with Type2 and DAX/hmem if soft reserved memory. This needs
>> to
>> be solved by the BIOS and Type2 UEFI driver for populating the
>> CXL.mem
>> range as EFI_RESERVED_TYPE instead of default EFI_CONVENTIONAL_MEMORY
>> with the EFI_MEMORY_SP attribute. There exists though a dependency on
>> one Smita's patches:
>>
>> [PATCH v5 3/7] cxl/region: Skip decoder reset on detach for
>> autodiscovered regions
>>
>> This is needed for the default behaviour with current BIOS
>> configuration
>> where the HDM Type2 decoders will be kept unreset when driver
>> unloads.
>> This is the main change introduced in v23: committed decoders will
>> not
>> be reset. Previous v22 functionality supported first driver load
>> finding
>> committed decoders but resetting them at unload and supporting
>> uncommitted decoders in next driver loads. This will be suported in
>> follow-up works.
>>
>> v23 changes:
>>
>>    patch 11: fixing minor issues and droping change in
>> 	    should_emulate_decoders (Jonathan Cameron)
>>
>>    patch13: refactoring unregister_region for safety type in Type2 API
>>
>>    sfc changes: slight modifications to error path
>>
> I've been able to mostly get these to work on a very boiled down
> driver.  I still need to port these into my full driver stack, but
> moving that whole stack (multiple drivers) each time a new API is
> proposed was becoming a blocker.  So I have a very basic driver that is
> testing the interface against our HW for now.
>
> I have a slight issue that I'll address in Patch 8, or at least ask.
>
> In the meantime, I'll start moving things over to our full stack to try
> and get the same level of replication.
>
> I'm hopeful I can start adding Tested-by:'s to the patches very soon.


Hi PJ,


I'm afraid it will not be useful ... as a new approach is being followed 
now, with some of the patches sent independently. I have already sent 5 
in two patchsets, which I hope will be applied soon after getting 
reviews and minor fixes. Working now on sending at least two other 
patchsets ahead. The idea is to keep all the sfc changes to a last 
patchset with only minor changes to the cxl core then.


Anyway, thank you for testing this last full patchset and the feedback 
given.


>
> -PJ

