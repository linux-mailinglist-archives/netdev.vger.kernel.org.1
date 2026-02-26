Return-Path: <netdev+bounces-261403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNG2G2psoGk3jgQAu9opvQ
	(envelope-from <netdev+bounces-261403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:53:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA301A925D
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BC2F31D9C28
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2196640F8FC;
	Thu, 26 Feb 2026 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WfwAyKKp"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9903407585;
	Thu, 26 Feb 2026 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772120304; cv=fail; b=sUUGf6yBmcYffJqhEuU88h6wfvHljaXzU4LMYNRH4Own3EOYvW8k6zngEIGmQg9c4kQPlp6P4mRb8U+DN6UV75w74VJmi5Laa3163LHgpNmBFV9qZp9mSzoJoIKpU9Kj4bj5aSjkeA0PVB8DInhf623C3e/NvGAcDy/5jp8mxQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772120304; c=relaxed/simple;
	bh=lJURjSibL+y4AtPtf8dH/4USQslmXFPehs2VcGY3ra4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gJDKCscl7bsCJ9rxNGb+9JT+I+AGuyvfLqNGjxeCHeeGKvYsI9P3M1iDbDTDbTfSEEWkWPXMz3pcE+u+qcQ9weQladSJv2hHhWt1Mdyy75ibFQOiN+SSkLYMPQLYe0JMYc5/7U45ebdLXh/WeG3ZgvxGasXw1uRJ9lToIh4a+rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WfwAyKKp; arc=fail smtp.client-ip=52.101.43.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6WEDcPom92r1GTBrSsjEAXxy4UP6C5XvSOC0qbCM3E4A9Yc9rhF3+to30yNOJPxX/SIiXZc6opSD8Heb2xXBwpeAJegvZaFgp12Mc2olVmbg5nzSXoqk5YiTH0zgJaX/HYcuUw824huPHFZu7ZocDHhOo/G8BhJzBarCofhNjbyfPFEJhr2HVdzXnrhn9+hIVOV4bxTdc2eMyRmNOm/NjB6Z7M5th3fmkNkojlAp+IRQap/7jCK8nxGjCEuNFHhMx5jVOxhVqonFj7rahBSx21W4rWA9gBxAUZ1Bd32WP7Go5V98nJ3LAu3w0Neg7G4KfeUz8XDISoV6R+NJ1XfRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByyG42ZDTZc9zeI/9UMbG3hLw6HVByjDKHng5mlXpJY=;
 b=Eidxc7PzmXaE7d4LDpDaVfQhsP2xZdLkiEDN/8atV75oilbYSG6Mq94+lvbAkVHgyIVrqEogkVFD+OQDiVETl0OTYT3FFaqLnIgJCGJbwcDoX//hBraYExeY7q3aftDZCQHUVRPxANEGtWIWWKBVQnC/OAcXBIj8NTPhOSVlgpNGTYoYbvlJEM3Wv/ZvT+SHFdGMQLRr5kYPJHD+en7L5UtuwPCnKiobr7PnveLtEGj/bL4rSM/5mwjP2M4FQ8EnfSN0FXKy4da7ukjpuQw01Bz+ZyKUeehWUQSR1+t5hBFe4A2VJ2dy7Qz6NuhfwcMq6O3zA0NzP3nMT6BhWN2+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByyG42ZDTZc9zeI/9UMbG3hLw6HVByjDKHng5mlXpJY=;
 b=WfwAyKKpH0Hl6KaXYrbzGKl+OJedDei3aC463OirdokBZnaaHm/HXRDo4swtxVJvDCssq0hZCy/xi/gYRLeEhWiFnDH6yNnROZ8NpoTv3phyeFpqstJ3GD+FE1h3oq+wo68cHBZmoV2Sn02vGrD59mhQuOU0oHMQppEKWKJixb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 by CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 15:38:20 +0000
Received: from BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::5a2c:3b6:82df:208c]) by BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::5a2c:3b6:82df:208c%6]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 15:38:19 +0000
Message-ID: <c3aee4a6-9c8d-414a-a5cc-bf7beb9dc5da@amd.com>
Date: Thu, 26 Feb 2026 21:07:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] amd-xgbe: fix sleep while atomic on
 suspend/resume
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, Thomas.Lendacky@amd.com
References: <20260225110001.1000014-1-Raju.Rangoju@amd.com>
 <20260225110001.1000014-2-Raju.Rangoju@amd.com>
 <aaA-efqBThRji-Cz@horms.kernel.org>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <aaA-efqBThRji-Cz@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::20) To BY5PR12MB5544.namprd12.prod.outlook.com
 (2603:10b6:a03:1d9::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB5544:EE_|CH2PR12MB4181:EE_
X-MS-Office365-Filtering-Correlation-Id: 3423c3e1-48cd-40dc-08e7-08de754d10f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	CkRJ/GvWxBCCbrNegmwsvDP0yS2ueg/bU1Iy3rDarWJ97c6sj+WzkT5lvuH/UN3AflmUpfGf00ERT5tVZGEVEILfJ0AYZ7jJ/na4tUkRy/1BxtjvtOVt3Iwt8EbT5gDtrx5NyFJ1DOJUmk4p4cf1eBdSp8FCYGbTppoUXxM1bUz09ynrKcwpOcqvOYKDyWV0/XIox3rwdyUuapQEk6PkyiOkE2v9HtEFtT/8zhQG9CSPhUqpisiWbn3j4I5Q2fTwK8dG5XeJCJs3PEzCCokz95QRwiwEAjrl65ESS8WUelZKSnZEhudERVjAORV3U31Rqy0zPRt6mM4dKGSYEL4sWmaPSVNFCo5eFKbwYq2WIA0LbExNDq9nklGePrlWpsO8xgS8UmARG1ouM7Sl9vSdCD8ocrxNT+/RtzYTEwo+L/d2h8XbT+JifmrcKCyECjFR9/WkBgWGsNmYDqkhiF5ns2PZTIHUNgPhw9OubX8eSeTa8pm8VTsKyxwrK9WolvLVBMVJGjVlZnyT7/EKalq9LJo0hkqUSWIXcbVxJluhpVDNcRB3xpt/h3hAJJKyqbvFeLVx1KlFzaAKp9cnB5TUr6JMiLnjtBa0x41JofSi85vM7L2zjsRKi5+4/XIWhhEB0wmTW0zdUvNaQW8UnBy4ar2SKCWSCS3rLktk7uKkVyFRfpOYggCa+PNuwoC+gtdxRp5ztRFOyuDEwNhM2JttpJdLdUYDiDMjUxMvnB+vciY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB5544.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGxSWW9rN1NGU05waVlxL2w1VHRHTnhybll2aHcxdlFpUEdoL0krbEozc05r?=
 =?utf-8?B?VWVndEFHdnhnbm9NZ2VuMzd4aDF5cFR6cDFvR1lGVnlTM3IyRDRJWURBWGF2?=
 =?utf-8?B?clNwb1F3STFtWXBuSWVtbXVZdVRONjN2b2s5NkJ1ajFhZS9YSjRpM1RFM2Mr?=
 =?utf-8?B?RS91RVZYVmZIWnZHMkgzOWlJRXlmMDB5R21lLzBIaU1xd3RlcmEyN0ZaUlNH?=
 =?utf-8?B?bENkNlBwd1MxSVp5THl2QmtrQ0Q1eVZ6aG85NWN5RW1iR3hlS3B5QWIvdHFB?=
 =?utf-8?B?SmYwVUVhSVJBZWJoWHY0MjlYZFNxbDBoWkNyVSs4WHRZbmpUb1ZCYm5FTFZC?=
 =?utf-8?B?bjFkc1hkU2U2Q3hpdzlUVmVOS1phTkduek1ab3ZOQ2NOdElFVjZhbWVQL3hH?=
 =?utf-8?B?QnFZbjRsRlVlQVI5THdTSURvbkRad2lOZnU4VE9GNWR0c3hxM1Jheld3RWpX?=
 =?utf-8?B?Qld3NnBFMCt1Umd0bUt4RnlsanFzb252bFhCMlVzcGVSem1vaXlYbjEybEps?=
 =?utf-8?B?dDJXanhCa0F4a1ZvWDlEOFZ6M0NCTTFweHhnY1lha2VReEJrMGRkSUk5NXBS?=
 =?utf-8?B?UUZ0dUY3WmYwcXdmalp2QnBaNWx4ZWovRnZaN2pLRDBxRFo3TWtDZTBKWmRs?=
 =?utf-8?B?RlpaYXRNRzFkK2lLUUtKakEySWlNaldwZm5keFg5ZC8rSmdhZWNJdnJLeTRN?=
 =?utf-8?B?ZDZDTFNjWnppV3JrN0I4QVhlbitSK2lYTkx0emNvU0UvVUUxOWpYUUlncHRZ?=
 =?utf-8?B?blhsK2Nld1RNUGZMdWxYMXZwMlFXSFdEQ2FPVm5VVWQ5bmJhSlR5ZnR3UU5p?=
 =?utf-8?B?QmpxMzQ0TGRNWWZEdHd2elVrbUtIemNMM0FYS202d1N6TENBRXRqUmJ6L1VE?=
 =?utf-8?B?dG10WjR3V2FtbmZuYVdzZEhFVGNTZ3ltRnkwWkJ0eS94TVBLT0p3M1BHTEJ3?=
 =?utf-8?B?QTFOZ0tydEpmMGFaR3NRNVlTa3lLdFMxVEluREV6V3dHRnBKTmVvR0R3U1ZX?=
 =?utf-8?B?L0xaRE1NQjhObUd4eFVRcGRHQ2JFMlRiVzczaUNZdGVHeGw4WnBOeVN1NGZL?=
 =?utf-8?B?dk5tK1ZmU2Q1azE2VFF6S2tMaVFYcjlUY0o2UUQzTXMxWmRvV2p1czdTVU1B?=
 =?utf-8?B?M3hUZkEzbzNUOGZSd0JHYThmNkUrZEZKZUc1K2s0MWw5R282MmpTVHdKb3J2?=
 =?utf-8?B?V3pxNzU5YjBxZlRSeTREN0hNQ0NjdE42Ri9HSTV2ZmgrdXBFM3VaV25XR2FE?=
 =?utf-8?B?cGI1WWxlaXVuRkhLOWI1Sk8yV09lSUhmMFYvVVNGdFRIYkFNTzhjdlAwamdU?=
 =?utf-8?B?ZHFIRlYrWElvUWdHcTVKTzlLdVVOQk83OUpxaG5tcWpTb1kvSTJCWlhxZzRX?=
 =?utf-8?B?QWNtQnVBS1Q2Mk4zbElYNWhidDYvT2UyMHJUSDF2UXo1NVlpRmlUL1J3cnFM?=
 =?utf-8?B?U0I4OHQrbFk3OXJ2MFlrS1R2MU9YT0l2RHYrZk5jbXJFT0k3Zlk4bkdIL0NG?=
 =?utf-8?B?MzdWbzJqRnFmRUJMeHJTSDVnMkVGMnR2QmdqZWl1ZGE3MDlORjRhQmtGL0Vu?=
 =?utf-8?B?U1cwZWhFaWlTTW5wYWw5QU1JMEVhNys2SmZjR1padkd6YjhORjQxaWw1MUw3?=
 =?utf-8?B?Y3NXMHlSdTJrNEFmdVd1VHRTcDN3TTRvdGRURlJnbzJ2OFBPNkxSL1o3aXhC?=
 =?utf-8?B?M00rSWNneDVYUmgvd2E3bldUbDZMeTJkMWdRcTRaTGhFSXVQN2tlaHJrM3dk?=
 =?utf-8?B?T1V2R3dYZ09NZFRCMDBpK3NmOWdET0M2c0h3V2FFRG9JaWhuUFA5cmR5aWhv?=
 =?utf-8?B?eUpMSGdIT1RTak53QkwwdkNmSG8rVStFaEZhVWdRTEdpa2NibUNadEd4dFFO?=
 =?utf-8?B?cEFVOThGais4YXlJUGRJb1g2dHhGRjlsRkljakZLYUZTZUtINE9raW9QMDZj?=
 =?utf-8?B?akx1SWlBUTBrc205QVlMWHU5MTlVVk0rK0R6azBCamZXVFdNYmovNytKMENn?=
 =?utf-8?B?RXFoYm1LSDBPOUxRRTlIa0NGaERSL0ZBQUxlVDFHUDMwTWZLNGFvSjZJUURj?=
 =?utf-8?B?ZnllVTJYZEhoenZ0TFJna0Ftek00N1FqVjBWclpHNnJWOUdpd1QwRTdJK0dB?=
 =?utf-8?B?TXc0VHdwRWdhUEYvQ1c5dHNTbkhza3IwSjYyN1MxL1VWUTJBUlBQQnRJbW8z?=
 =?utf-8?B?R3ZjVzFiSFE4ZHUybTBzWlduWFNWS0VXQ1dFa2ZBdGZISmRjTEwyNUdMV0NG?=
 =?utf-8?B?a3NOTGRDNGpvVk4yeFVmelh1bzZRUmMyZlRWeGw2bDc0SDV0VEpOTThjTkI1?=
 =?utf-8?B?YVhNajBTcS9kbVAyY2ZHZXRoRFB4dG44RXh2NDJsUzdBcEo1bUVPdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3423c3e1-48cd-40dc-08e7-08de754d10f8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5544.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 15:38:19.4896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4jwAoJEzlluXV0lQZKvz2tukxSiy5J+Im/FW9oepvPoMSHVFugg3TMOzTSbC1lMKaj4/N3y6UArxj5om+cUvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261403-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raju.rangoju@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ECA301A925D
X-Rspamd-Action: no action



On 2/26/2026 6:07 PM, Simon Horman wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Wed, Feb 25, 2026 at 04:30:00PM +0530, Raju Rangoju wrote:
>> The xgbe_powerdown() and xgbe_powerup() functions use spinlocks
>> (spin_lock_irqsave) while calling functions that may sleep:
>> - napi_disable() can sleep waiting for NAPI polling to complete
>> - flush_workqueue() can sleep waiting for pending work items
>>
>> This causes a "BUG: scheduling while atomic" error during suspend/resume
>> cycles on systems using the AMD XGBE Ethernet controller.
>>
>> The spinlock protection in these functions is unnecessary because:
>> 1. The functions are called from suspend/resume paths which are already
>>     serialized by the PM core
>> 2. The caller parameter was used to differentiate contexts, but the
>>     only current usage is from the driver context (suspend/resume)
>> 3. The power_down flag provides sufficient synchronization
>>
>> Fix this by:
>> - Removing the spinlock from xgbe_powerdown() and xgbe_powerup()
>> - Simplifying the function signatures by removing the unused caller
>>    parameter
>> - Removing the unused XGMAC_DRIVER_CONTEXT and XGMAC_IOCTL_CONTEXT macros
>> - Reordering operations in xgbe_powerdown() to disable NAPI before
>>    stopping TX/RX (matching the order used in xgbe_stop())
> 
> I don't think that all of these changes are necessary to fix the issue at hand.
> If so, please separate the fix(es) from other changes. And submit only
> the fixes to net - ideally one patch per fix if there is more than one
> discrete fix.
> 
> OTOH, enhancements and clean-ups should be submitted to net-next.

Sure, I'll separate the fixes from cleanup and submit.
Since the clean-ups have some dependency on fixes, will let the fixes go 
first.

> If there are dependencies on or conflicts with the fixes, then let
> them go into net first. net is merged into net-next each Thursday or Friday.
> 
>>
>> Fixes: c5aa9e3b8156 ("amd-xgbe: Initial AMD 10GbE platform driver")
>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> 
> ...
> 
> --
> pw-bot: changes-requested


