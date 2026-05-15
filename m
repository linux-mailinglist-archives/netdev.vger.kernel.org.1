Return-Path: <netdev+bounces-288440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBSWNVN7B2rG5AIAu9opvQ
	(envelope-from <netdev+bounces-288440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:00:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE91557327
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DCE43028837
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFA13812CD;
	Fri, 15 May 2026 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t2E8Qxad"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8937D372B3C
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 19:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778875153; cv=fail; b=iylDVtZaMH/cF551SXI64f7Fl3/+IBeng3XdLKCz9LnpnytChXcaIMuPRRlZN7drsygO086T/aqS4WrOP7oqByH9bDuMVYFci7ifCj0j4zjLI7c97vxJUy9ZW1a2rVgekAOHQdfFrg4d2go+KYzUwOdAU4YodCtxjhT4i7hKnk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778875153; c=relaxed/simple;
	bh=PSB9lCAoyPDSQMiuy5JxeIDF+w0GwudH2LYCXJpmEds=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LkrAzJBw/4MZFUIZ32ZptKNS88M2upMpAa9KekIWs2cJGso+apqDwyR4Q5l/7LEkhwfhgndKC7XitNXecPmxOOjFWKQNpOwOBFM1soNd2mwevJnIg4iSl5YiH8GzL7eTa1oOchbwWZan77yrDN6Vl/17x9ULecyX521htyE5BLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t2E8Qxad; arc=fail smtp.client-ip=52.101.52.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KS9xjLMca5SDTDH+Hms40I7oNz5Wdc35HmnJ2tedxOU1dbpwD/ytnahuu33NSHcXCGl9SJIposB61FGul0hw+B26XX9fJa4y+ymITAiQ5wvdjjhg0bdGHBwI6qU7ky7ihBu2AqpKMqjqowj5toeTMYjhUCt7D8hN8apfn5K/ASDJ7iZujEeTKc7QeOLQCNUEQJly/fmUJfAP8/jmDk8LXGSF6wi7c+D5YljhvHixxeAphPkzUtfyx2nO94ieth2vH0zC2cCZhWt3kWXrA4z45DvU4Wdvr6mODLG984PcG9X+yw9YC9lM3XZylQa5BnCFVugCAYYLyW8zIUrI3Un9fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hz4ja+4CZCgOdbKkfCuyRNfD3nTFNwPgl4plKeIKkx4=;
 b=cs+vVpviLk16qlWrj8vc9+L2gtTkT/B7BpWJhyf31FMO4ISXgpybqjrLIOa1/znHVzDOd0k+TwkCKENJ55ABW9PpApqbtqmFNHd/M+tIn8jEWHZ8OBd7Ig85s8JZLbEqBvp8dw2rpIdjWKdoJCl9PktNKxZ7TRj5yNm9bKHQaPdCnIBGZ4FqihYJK7BcoZLUFv/wMIKWWZxWGm3qnHu4C0gupe75ypyc14rs7MEu29c0vkiKCzWhAqr9WnHSHaD2MQb5t/y17WtlEt1zClzmAPO/9rbKT8nCjBD/4JhXQUQWSImZwv7OSdjKGY+qpdlwSVPSKGMHe9hWPLetAl+HJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hz4ja+4CZCgOdbKkfCuyRNfD3nTFNwPgl4plKeIKkx4=;
 b=t2E8QxadphrR8nJ9qR+aP3MrzyI3946QmiPugMMq+LlTAMX7YJLUCFyuJ0xAe976lsUsv1traMGt5OJkkecU6yTgxsnzZ3SzdQbb76lWvtQrgu7YLhYIIKzv0GrXebLtHzODP8Cu5pcFVaQpeDGp+CV+jbcPSHsgdWIVCALuvgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY3PR12MB9701.namprd12.prod.outlook.com (2603:10b6:930:103::18)
 by MN0PR12MB6320.namprd12.prod.outlook.com (2603:10b6:208:3d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 19:59:07 +0000
Received: from CY3PR12MB9701.namprd12.prod.outlook.com
 ([fe80::ac7a:9f2f:acfd:9ed9]) by CY3PR12MB9701.namprd12.prod.outlook.com
 ([fe80::ac7a:9f2f:acfd:9ed9%5]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 19:59:07 +0000
Message-ID: <8fb773c1-411a-4b61-915f-5111210abe1f@amd.com>
Date: Fri, 15 May 2026 12:59:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/5] ionic: Add .get_fec_stats ethtool handler
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20260512224421.25236-1-eric.joyner@amd.com>
 <20260512224421.25236-6-eric.joyner@amd.com>
 <20260514183209.48fa771a@kernel.org>
Content-Language: en-US
From: Eric Joyner <eric.joyner@amd.com>
In-Reply-To: <20260514183209.48fa771a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0333.namprd04.prod.outlook.com
 (2603:10b6:303:8a::8) To CY3PR12MB9701.namprd12.prod.outlook.com
 (2603:10b6:930:103::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9701:EE_|MN0PR12MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: 592cb853-2949-4400-3baf-08deb2bc6c25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|4143699003|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bQvokS6qbrjMl1w3jQ2b8xebITxzvH2k/TqYVepdMSbPXwG1rQaphpFJoD+wWraYxvhoxcWjpn5DHu6tl5vREpuz80MwU/r9ZmfE7Ah5+DxQvsoiwGfjl9grs90lnXy2S+HZyklK0YB0ZeRuxb4O2FuKU5nVdfM19X2Er8Cyi8XitVbPAlbVOuA8jtnSWU0bAesChA0jFQMEQ/EvEYj7pxZkJ0/A84xA4qXRZxht8gbyiyYVsM7mRJeKEzDLzbXp63ardaPqxb/jpxjegTEQG7zLrCkpI+7akXs4ncJ+72uRC2O2ec6+ZZ8LF1sWT2Rvi//AdHrODWIm6W/geApmxDwKzBCdcKehlQShCpNW7Q22TFzcE9kQ+PsQ7PFb6eeylsL9xa623Q6PDsjabCU/e3PFXtu9ifM2iUwhnY8JLBqgAMvx4FG2JaO7pgCAd4tdcOkYwetH3DSZi1m4ltkbzERNzPS974qo40repY7XqMyu1f04myYhyGsVjY7mwDLlWYQiUoWo7rQRLrqXOtVd6zMMoT3Jzd+Wc3d3XYOecvwW/GtRwcWKUE8LMXYcgqjIA/BSrECO7uLhaJ+9PakhH1yEyq96/m0N6AUSKVEbUv30fYHONFhtCWuGZ77Gscc67SBKTu41/0zNZKA253vyRiRcV2YuIFUnQ1nqCf/jXmouWj4c+6DHoTHLbz53MQMh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY3PR12MB9701.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4143699003)(11063799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWljd2VlS1M5d1puYit3T0F0dVEzbFppUGpwREpndTdiMll2RUxGM2RBU05z?=
 =?utf-8?B?VitPRVdFSXc5Z1ArWTlGcFJjMnc3ZUhxWmhyeTVZMnAxN1kvUzM5SHVubEhF?=
 =?utf-8?B?L2l3bnZuNUdkL1N3Q04xSEk4Wld6bjVBWElqT0VFZ29yREVyblpZb3RMZlJl?=
 =?utf-8?B?UFkrWVk1VzhtOU16YU5aNTVIb3ZieDdmMXZyZDV3ZzdTb1BiK3lhQnRjYzNJ?=
 =?utf-8?B?bWs1ZmIwZzN2V1l5dVIzR3l6UWcwOGxNSVA4V2NUbXhIL0JyNEFaWksxOCs4?=
 =?utf-8?B?YUczWHpHMUlTNlhCQkhXQ0lnWWNIK3VBUDB4eVk0S0dUeWlqYm5Wb2hZcEkw?=
 =?utf-8?B?TWxmOFlrWklzMXV0eldsK0EvUHBSN3dlV25idHo1Unc2ZkpUeGY2ckh3QjJ2?=
 =?utf-8?B?ckx6SVFpSmkrUExCVktZNTVhRlN1NkZyVUwrK25sQk9LVDVJRWJUVUIxL1hQ?=
 =?utf-8?B?ZnVZajgrZkxnaWhKanpDcXptR1I5b0hYZUtmU0MzZVhBemwvVXZTbXBjdFBM?=
 =?utf-8?B?bVhFWlB5MkM3aEJHUTBvRTBlZEs4d3BSSnZaL3lZQ3hnaW52cGwyMm1PRE1K?=
 =?utf-8?B?YlM5cE16MXM1ekttdDMwaG1nSFBGTDl0Qzd2b3ljR2hIRXAzUTJOajFwZmhl?=
 =?utf-8?B?ZDZaS2taZmMwSmxtQmp3STZEWmVvNkdTMEdyYjI3U1ptcFQ5b3VuOHRib1Z6?=
 =?utf-8?B?Q3FUNjV0VUZvYUN5bmxET0psYnZ4eHUzUyswZ1F3MG1rcTJlVVR0aDhaNENH?=
 =?utf-8?B?Y3laODU0YkNsVEFoOG5IYS94a0xsUWs3bW9lU2JHTm54SlVYZHhZcFJsZFNs?=
 =?utf-8?B?aUJXdUdDZzZjZlJ1azNZdVRuN0dJcVhXNXRTNmVWQjVWcVBxRGg4YytEZjB0?=
 =?utf-8?B?KzhLZHVzdUNEczlveUpKL1hibVYyYitTb3FCam1YQ3lhLzFYVzg0TlVGcmk4?=
 =?utf-8?B?S3A1Nkt5M2l2Y29RUVFWallTSUhwSzBzb1FXbGpUcnVPL0FhTmVOMEFKbFZG?=
 =?utf-8?B?NmFyYWh2d3NDTDJYVmtUUHM1ZUVsdWM2V25zSGJiczQwTkF3dHB0aExJNjUr?=
 =?utf-8?B?Mjd0Y0RoUlpsbE4zZkhWQ0gvQ2pRQlFFQ2dGd2NPQXB3UjdrQmIwMU9BZy9H?=
 =?utf-8?B?ckh2NSt5WTI1WTk3Z2lGQmFQNWgrV005eHBPWEJ0SEtkcllRbDBpTHI2R2Nw?=
 =?utf-8?B?bzlOV29relQxcWVnUWkzRGNXRE5FU3Y0NTBCWkNucmdLSG5jRWVqSnA1UFJW?=
 =?utf-8?B?SVp1Ym9maXEvcVpnT0Fya0YvNlN4NHBrYVZTYnBiaHZYZUFjVFplUENKV1BX?=
 =?utf-8?B?NXNzTlhRL2hBdWhZTmlRZmNYaXd5SklKZWJ6T2hvUHJ0ejB2L0g0VklUVFFq?=
 =?utf-8?B?VkpWWHpxRTc5N0hiK25ieUNoMDVwVEhDOUhqOVBLQXY4RWwvczY5ZTZQc2g1?=
 =?utf-8?B?L09XMzAwMm94cGpXdTdrZzRocjEzZlkrTXVOTzF5WjF6MEpPOWI4REs1MWFm?=
 =?utf-8?B?T2ZUVEFaTldsZi9yaDEwaVMyWHFvRzFvdHJrYkV1ZGhuVzkzUlFvUGx6S05M?=
 =?utf-8?B?RnB3WGF4ZTVKZFBlc1Y0L3gwb1NNWDg0Y1VMWlRsaUVEN0lnME95SUdDeUdt?=
 =?utf-8?B?Umdpa0FTcCsvQnVoOHRvNFg1QkJrS3p3SDJDYlRtVENWN3E1SnJzU2drd29O?=
 =?utf-8?B?SWdCN0RxbnY3Tzc1d1E4d1B5TWlrSENhUm5FSzZ1Y2FpZFBhSFdITE1XUksr?=
 =?utf-8?B?emFsYVhwTHVjRlM2aFpmb0V4Z3ZTWTkzZWtOSXNzRWZVUUhkZkJiQ0lwZXli?=
 =?utf-8?B?b0ZzZWRKSmJOdEhUS0NBZEp5NGFPVHNIUUcvbXp0TkM3ckRtdTl0QTloOGNr?=
 =?utf-8?B?NWxrTmNJUnJsS3hTdHFLT0JiSDVDYTEzdTducmVzQkZuWjV2ZnRCcmptTmZa?=
 =?utf-8?B?KzJvMmdyWDI4NzF5MzZNdHlyTTVkanFaT3N4akhJZTArcXR5V2RxbjkxTjln?=
 =?utf-8?B?alVQSFhHUmsvY0QvcURIN1JLVEV6MzROWS9UeDBBRjlwN0RYSVF0SkFFajZz?=
 =?utf-8?B?VzV0dXNRdlJOS1ovN3V2L0xWeG1xbWIxNVRqQ0RaSDFtZm5SZFN6OFNDcU9h?=
 =?utf-8?B?bjZYaUdyWXlOMkJDMnZKcmhOdmFSck5sVFVIOHh3SnVKdUtRQzZia1gwNGxl?=
 =?utf-8?B?TWdqUm1VS1JkQkFES2pOWnpZaWpxWGFXamhpK08vZFQ5TjNMczZoY0M2djFz?=
 =?utf-8?B?MHNFV25DaTEvUXV5V0RwYXhaZUZCRmlzNnNMMmJtV3l2Y091WXBFa2tJTVhL?=
 =?utf-8?B?akh4UWhQQXFnNWxTbDErVlRtdkg4ek9FRmV6dk9VS3h6Z1pkd3ZHdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592cb853-2949-4400-3baf-08deb2bc6c25
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9701.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 19:59:07.2264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNz1H2SJiAEotQ6WWpTBvPhbEFFJMZky1skjVdoFWwKt/t9oAnkU3RZj86JqDWX2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6320
X-Rspamd-Queue-Id: 4FE91557327
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288440-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/14/2026 6:32 PM, Jakub Kicinski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Tue, 12 May 2026 15:44:21 -0700 Eric Joyner wrote:
>> This includes 802.3ck FEC histogram data that some newer
>> hardware collects.
> 
> Ah. "Some newer hardware"? As Sashiko points out the standard stats
> are designed trying to avoid "does 0 mean unsupported or 0" ambiguity.
> You need to figure out if the device reports them and if not - don't
> set ranges.

Unfortunately, there's no proper/good way to do this. A stopgap measure
would be to use a rough proxy measure like checking the ASIC generation; and
then we can implement a better way in the firmware/driver following that.

- Eric

