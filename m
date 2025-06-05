Return-Path: <netdev+bounces-195200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AA8ACED03
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 11:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8893AB247
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 09:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B12D20A5D6;
	Thu,  5 Jun 2025 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ItMYIPsA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5BA40855
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 09:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749116598; cv=fail; b=TRyamGVhZu2RXgAZNH2gooJ9tYtVfb6YJ5RMilsl+E7IuilJLVwKRXUpsEcMXxBL8baj8Lh7mtSyjCIzNP6Xo9bSj/jl8iOtbfnhNOH+MSyT5euZdbLYylG1DOyVDXigkdv5lg+8XdFFn5B2X2B9RvqFFD0r5/mdCJ8ca0BsxD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749116598; c=relaxed/simple;
	bh=57VTO7vllrkPQBp16Ze72t20BiqQpgPW1ONt+R+AK/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hreAKbnSshhemdojRsbVoQQEdER7CwN+F4OsXFPeQr5n16QDRL1b/MCE8w8KBdI0WRCoDGk39MsXTQlqitPwHVh0r1urjFMoxmFIjsrmVm1qkw1PKqMeQXY2GWV6lWCD2ZEn/wJMRatLcwcxi8rwVbxRkD6HHbKLtyAs9QC3fZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ItMYIPsA; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHo1kDoupIyMWZIitaZaPtb/5gd0n3phP3vwRAQ7LzEr8AewvY65WMrjbGV5mfbLG120R7cs8m8UkSKG79jQbkNXsrAyQlGKs/o9Ilf6nXNQ9Fmms4b+pnZW7WR85YoEwmp7v7d/O+YS6vehcCe4C1RzL7hS6OIDk2H9xois+gDd+d+JYCDK3PAkDVqCW90S5oWoNGNhHb6KkV24Aw0w2wP9zZacQe74eop5O2y2vjIEK7/om97ZOLC3BjEER4X+yM8OZMpmfDJeLQHVBJE0NFh38aW2V7cb98KW9eUNt84JMO4ePwtECUIDDapzDhFRaPxzfvlkkciUGMrWOkTMiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjIgFaxoStE2E+pjUMpKRaqu7eGQG4rFLogBX9cFXgc=;
 b=ZDDIry859ytO6gTqrJKkAJpgGmT0k0CPOGdGSMuFlZtc01yVlJE1MdiBGjAxkRVz7U3k6/co4yhfMerEcnOjCl8l8lOrGNKjDEf8FAVzxr1H0JrWkixzE1qY082I5+TWW7YWv+PRAQH2m9kZpRB5b9zWwb6e1opIbGLm51XMz93fJ0DSin3OO7z2N4LXus79JDgJOcFRbIK6pemfaru72DIMN6LtRkQn5n+cdEvyYand9bokJA3IN1/CKKxRUN4t8nZX5HaruRAjPLiKJ0qFeQfbYJX0QgL5ukbVIVa6AqKbUqo20XhMkcJDx+1rBbF3az+lyByOMdoSwdSbQvnhhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjIgFaxoStE2E+pjUMpKRaqu7eGQG4rFLogBX9cFXgc=;
 b=ItMYIPsA3BhAlDs7pTv9f9ozo4ALL1z8U9xKp959doosTYtd4bTWKJYZzs4ndbkU11aVC4WIk9SdLiHrVXoPS7voYOK17qQoAv1i2N1W0//i77ZgQ0ZFUFo4h4UjdFebncOvN2eIDSK+ot59jXtxGb+hvHUku8otz5LnR/OB3QJOovyv9mKoaYAcbLAcng6cUdDQk0OuqZsjJIF1Wv5jEmWIPwff16fFczQR77/I02ndgcrSr0KjCbhgY+6TgAPWTPvW4zolGaGvP1VVQqJcxwmfgAbv7J/trSXzHeqsyLw+XyLd4Sb2cUApAhKxJuvPJajDT1TjoU8HJSfkcJWpwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA3PR12MB9226.namprd12.prod.outlook.com (2603:10b6:806:396::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Thu, 5 Jun
 2025 09:43:11 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 09:43:11 +0000
Date: Thu, 5 Jun 2025 12:42:57 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>, razor@blackwall.org
Cc: netdev@vger.kernel.org, dsahern@gmail.com,
	bridge@lists.linux-foundation.org, entwicklung@pengutronix.de
Subject: Re: [PATCH] bridge: dump mcast querier state per vlan
Message-ID: <aEFmoU9_ci0rqQTQ@shredder>
References: <20250604105322.1185872-1-f.pfitzner@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604105322.1185872-1-f.pfitzner@pengutronix.de>
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA3PR12MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: a5084382-4b1c-4bd3-789c-08dda4156257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UotdH1e/ap6M6le112ppjnmmupAV59JPr+VcKMl/oO6+4FFX1VYxb/GeugZ7?=
 =?us-ascii?Q?VM7Pb7Zlti+Scg3XxcO88chmjzIJde597uvCixI7u9vO9oorwazTb2RmF6Ht?=
 =?us-ascii?Q?xVECpz6v2Zu2qCppG2q5/5C0Kkc92prwRsSc9QXnnjOtrlo+AXtTsiq+bIjI?=
 =?us-ascii?Q?47oOO/sCtlJhQ8XakPBCJSbypzRXXZ6jDfpIyVbokxof7o1zn1rWX97DSCwm?=
 =?us-ascii?Q?1NIsTMeLPKmoj1mjz9kT5Sca1IsgqzhsldU7C+J/GSumCd53eSv36+hU/UQ+?=
 =?us-ascii?Q?xsF/IlwB1addVeN1jd84vpRogMJL9jmCTquj/6QGor1EH6Ux8PlCn6H3niwW?=
 =?us-ascii?Q?1+ZEnc5zU268RBCQRZIKlZ7fNRA10vtwGQmVnmGe0br55pG2zb/wvCex7r5V?=
 =?us-ascii?Q?cglrMDI9BiCcSmy4vD9w8jjjLZjhul6Lzg9b9ovxLo7nzisj33sS5pcJ4b0U?=
 =?us-ascii?Q?qi0SmJ6cwyyFnjp2J5wdJ8tLvtqmpqfXwrkt5LZgSaxiE4yK2npYkVB3HnCL?=
 =?us-ascii?Q?C2HElNwHxwYJp17Q6hyN3f0a3Q0yAWBA5r8P67PUt1DZOp27Vo2ySo1ELGjk?=
 =?us-ascii?Q?nrMjHjfqZZAKfGh3BVghTipeRvziQE+oL9LRxrs+hxqLRLO92U7tYwkCP5jB?=
 =?us-ascii?Q?5l1hIUthqulU4IIoJr0qVR1lJMt6+p9QqSYVJwYaMUS0EylxC8lxpStaDWFq?=
 =?us-ascii?Q?ZEmaIFDy+f7WDA15ahi5RIO9fTtBB+gAlGUOLQ9qe+QIs44gv3i3S60Yw8cS?=
 =?us-ascii?Q?/CR//RvIXa/QdbY0h83nw7Xl4vxH7lHqX+R6SYeKj66mTlixlS3tanboKqEa?=
 =?us-ascii?Q?QcHFD9lG8+83pe8yIeFwGxHRUJqhF3n+yChYbSbShuSSi1mS/2EMHbZOAvjf?=
 =?us-ascii?Q?XYJAO97IsXhUwEU+OYkCSQRDldetvffooeZolXXU7VWRdzFWxM9Ed8LoAz7c?=
 =?us-ascii?Q?2xpGKTQ7WD4REl35IylyjTHAfjnyUVB+sgS+JKeZ/CWzMQ0tkQAo5KmgHuX/?=
 =?us-ascii?Q?Nu2gbQCKMK05+eMxGQOosfdhVbNchlNPeq8zOswe2dsuykQDTNfjEgTPTaUw?=
 =?us-ascii?Q?ROVw4HnF/zvjkSXZiLCKOovWdRMpt/3OCKBNfAMXrzMGDiM96t9Aq/tnF/gT?=
 =?us-ascii?Q?u6Dvruo8ba4M8UFSn5FR+IiAo4/296FZ3lwBlVBg8qqEeG7mpuCh4rJ5T4Tc?=
 =?us-ascii?Q?AYCGa/SS95SbdV8uf/7mdUNPeJSoGNg1RgqG6e4cMNXqQ3z7vRgT1VNyu7YQ?=
 =?us-ascii?Q?tBKZsuJzC4nto4ldhNqsCZ4n7pHuxu4TXuiw99sy1FKpi7FfNVcMRPV8yB8o?=
 =?us-ascii?Q?UuZMTO5zGnJVW53VMLTWDXN+yGnnGIQ1k82BmPvPsIvWuFJyRvNL66LlU+mo?=
 =?us-ascii?Q?oTIm4Zk9ZeXqThRfYhT+IE23yLqjBSQJ9mM1EOXjRyXNXm5g6R2NUyeVFpIZ?=
 =?us-ascii?Q?eeYbGBUH0TA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kMG+0wXHi6pmsNw+UhgQeonld7OBK0oMtgrbUMkg7EC+pJ0JYVQ48Y3H7EFd?=
 =?us-ascii?Q?z9uFeiHlDNGiOXMVoJJChUd+dpGxdEykIU2St5zfS7Ejs/Z50EofHwnkK4j2?=
 =?us-ascii?Q?0iuFajT2dP0qjhYY3YGMOpqBZj1LWv5wi262PNzdM13qkqrPLixVwbGlcTxe?=
 =?us-ascii?Q?mG9jq+YLj7wLLC6jjh321/SstxnQFvovWNVfS5b/cA/GGk1ge9tdUH0Ie06B?=
 =?us-ascii?Q?t9ovSYlB835F977vbWNn5sym6LkOgyNe3L2xDYldAFIJYPQBUazKc8Wcm5ya?=
 =?us-ascii?Q?uM16JSANcOhvcryWFvc+brrVg93gH6za7UFh0tZnNsb/CxT/x7RhhRuRBApF?=
 =?us-ascii?Q?gekG+M0b87A4cnZPqesvoazMt7Vqfk5I5Idth7epMUdSKb4KxCVMZ6Q9RmB+?=
 =?us-ascii?Q?dy7F6lUmF85MrQIQ8bbFQIjfekQ2ceCJfJU2sRlm7QHRxJYr8Ic2bvCBFWSd?=
 =?us-ascii?Q?Nj6EEv/cjX8+0CCFJuhvuI5XJRDKgFgktDbJUNVid69VGghw3iQCw8l7YwoF?=
 =?us-ascii?Q?vGGnRqoj35UmUq256VTQoam9VKFXZ3gLtM3ri8Er0qD/5GjqljLdryecjZa7?=
 =?us-ascii?Q?ul7ZHwX5GaNGA3xWyJqoio/gDxB4ye+tAN0Q529fxVAHiS5R4o9IbnysrwWn?=
 =?us-ascii?Q?z0b5ZNGBkxlQFntLTzOjyGWPnAuU1m3rqi85gpZQV1siNGSXMzWakvFpCUwi?=
 =?us-ascii?Q?2ihV354U1AXtPgePXi9T93wjXkGlidO/8vbbg6WQcz4hVEAiV7oHqOcUO/0L?=
 =?us-ascii?Q?BA8Pie+63qabesLkPHOCk4TWRkYdADWbazoRUSZTj+4Puec05EKv2edV4sra?=
 =?us-ascii?Q?li6Og6M+82b5T7TWPEQClhGUrRILmWfPw2wlaxmRUCWqBoOpK5/cmdYwY/tA?=
 =?us-ascii?Q?Kl8PZcH3gsIbokAcvMgbcKFDcdyFpDS3xP61OfV3Zy582XIDVcyuPzPEycnU?=
 =?us-ascii?Q?87ljZZhzCXy3vglsf2owDLsTU8rE72rC1FkcEFxBDk3nsqCC7750kHr3rz5O?=
 =?us-ascii?Q?eUFPY+ZXDqhfrEnlm6jOjppeqfqXzQodM+J15k5Fc9bR2dxOLtRYDR5imv/G?=
 =?us-ascii?Q?UtLCiwoWoskIjY3ol/ZLZ1/wilVPawyR2G+yoTe+n7PCnXIZZ5Cx/iBgJwFp?=
 =?us-ascii?Q?TMNfDnp+VKBwM1JFhQS4Hi+o/JhClSov5na6J3jFfk35zqmrlFRJAQIN8Esi?=
 =?us-ascii?Q?qKiL0vIuSfbjOFfSI44W16puekw5ePMHHJF9iY5BVLWS9/kEC3UvYEcqhPm7?=
 =?us-ascii?Q?voJLzm7K4T2PO8OuqavKP1qG38oy0JcM2/112dI0ZPqa7wYTmBbyCAH0+nU1?=
 =?us-ascii?Q?arNRWqueZ+sKSX/0RNUvd20+i+Yf473xW6UICREu4FIEajKYtJRy4JHB5pQ3?=
 =?us-ascii?Q?J7NCMSyoG5FhRyKyDpNJJLpoRF3gZlRCaGGtLDk8vZDdgCznuDlbGRbVf2Im?=
 =?us-ascii?Q?eT8MDGLKfmo9gCNfAsUSBGKq/myBeDfuKU+wUO22KyjVBgxydOgxEyUx250S?=
 =?us-ascii?Q?X9swqakZeGSov9IduXRgagkeYYEO/A8IqQtxo3c5KLJsvAWBu7ybrC+8cZu1?=
 =?us-ascii?Q?H9ZOnd7NAioPXbfT/18B/ysKL1h0hsPUc8riuxz0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5084382-4b1c-4bd3-789c-08dda4156257
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 09:43:11.0428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IyokUMDDlfEwpsrgSGOG2fDPgGGpXaRxwtBmrEfQkezhuCBACx1/0odGzzwiww8ZsnId6APfNf948urM1BYoSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9226

+ Nik

On Wed, Jun 04, 2025 at 12:53:23PM +0200, Fabian Pfitzner wrote:
> Dump the multicast querier state per vlan.
> This commit is almost identical to [1].
> 
> The querier state can be seen with:
> 
> bridge -d vlan global
> 
> The options for vlan filtering and vlan mcast snooping have to be enabled
> in order to see the output:
> 
> ip link set [dev] type bridge mcast_vlan_snooping 1 vlan_filtering 1
> 
> The querier state shows the following information for IPv4 and IPv6
> respectively:
> 
> 1) The ip address of the current querier in the network. This could be
>    ourselves or an external querier.
> 2) The port on which the querier was seen
> 3) Querier timeout in seconds
> 
> [1] https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=16aa4494d7fc6543e5e92beb2ce01648b79f8fa2
> 
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
> ---
> 
> This patch is a bit redundant compared to [1]. It makes sense to put it
> into a helper function, but i am not sure where to place this function.
> Maybe somewhere under /lib?

Not sure it's appropriate to put this in lib. Given this duplication is
not new (see ip/iplink_bridge_slave.c and bridge/link.c, for example)
and that the code isn't complex, I would keep it as-is.

> 
>  bridge/vlan.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/bridge/vlan.c b/bridge/vlan.c
> index ea4aff93..b928c653 100644
> --- a/bridge/vlan.c
> +++ b/bridge/vlan.c
> @@ -892,6 +892,64 @@ static void print_vlan_global_opts(struct rtattr *a, int ifindex)
>  		print_uint(PRINT_ANY, "mcast_querier", "mcast_querier %u ",
>  			   rta_getattr_u8(vattr));
>  	}
> +	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]) {
> +		struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
> +		SPRINT_BUF(other_time);
> +
> +		parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]);
> +		memset(other_time, 0, sizeof(other_time));
> +
> +		open_json_object("mcast_querier_state_ipv4");
> +		if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
> +			print_string(PRINT_FP,
> +				NULL,
> +				"%s ",
> +				"mcast_querier_ipv4_addr");

Is there a reason for this misalignment and the overly long lines? 
How about something like [1] instead (compile tested only)?

> +			print_color_string(PRINT_ANY,
> +				COLOR_INET,
> +				"mcast_querier_ipv4_addr",
> +				"%s ",
> +				format_host_rta(AF_INET, bqtb[BRIDGE_QUERIER_IP_ADDRESS]));
> +		}
> +		if (bqtb[BRIDGE_QUERIER_IP_PORT])
> +			print_uint(PRINT_ANY,
> +				"mcast_querier_ipv4_port",
> +				"mcast_querier_ipv4_port %u ",
> +				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
> +		if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER])
> +			print_string(PRINT_ANY,
> +				"mcast_querier_ipv4_other_timer",
> +				"mcast_querier_ipv4_other_timer %s ",
> +				sprint_time64(
> +					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]),
> +									other_time));
> +		close_json_object();
> +		open_json_object("mcast_querier_state_ipv6");
> +		if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
> +			print_string(PRINT_FP,
> +				NULL,
> +				"%s ",
> +				"mcast_querier_ipv6_addr");
> +			print_color_string(PRINT_ANY,
> +				COLOR_INET6,
> +				"mcast_querier_ipv6_addr",
> +				"%s ",
> +				format_host_rta(AF_INET6, bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]));
> +		}
> +		if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
> +			print_uint(PRINT_ANY,
> +				"mcast_querier_ipv6_port",
> +				"mcast_querier_ipv6_port %u ",
> +				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
> +		if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER])
> +			print_string(PRINT_ANY,
> +				"mcast_querier_ipv6_other_timer",
> +				"mcast_querier_ipv6_other_timer %s ",
> +				sprint_time64(
> +					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]),
> +									other_time));
> +		close_json_object();
> +	}
>  	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]) {
>  		vattr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION];
>  		print_uint(PRINT_ANY, "mcast_igmp_version",

[1]
diff --git a/bridge/vlan.c b/bridge/vlan.c
index ea4aff931a22..2afdc7c72890 100644
--- a/bridge/vlan.c
+++ b/bridge/vlan.c
@@ -892,6 +892,61 @@ static void print_vlan_global_opts(struct rtattr *a, int ifindex)
 		print_uint(PRINT_ANY, "mcast_querier", "mcast_querier %u ",
 			   rta_getattr_u8(vattr));
 	}
+	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]) {
+		struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
+		const char *querier_ip;
+		SPRINT_BUF(other_time);
+		__u64 tval;
+
+		parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX,
+				    vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]);
+		memset(other_time, 0, sizeof(other_time));
+
+		open_json_object("mcast_querier_state_ipv4");
+		if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
+			querier_ip = format_host_rta(AF_INET,
+						     bqtb[BRIDGE_QUERIER_IP_ADDRESS]);
+			print_string(PRINT_FP, NULL, "%s ",
+				     "mcast_querier_ipv4_addr");
+			print_color_string(PRINT_ANY, COLOR_INET,
+					   "mcast_querier_ipv4_addr", "%s ",
+					   querier_ip);
+		}
+		if (bqtb[BRIDGE_QUERIER_IP_PORT])
+			print_uint(PRINT_ANY, "mcast_querier_ipv4_port",
+				   "mcast_querier_ipv4_port %u ",
+				   rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
+		if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]) {
+			tval = rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]);
+			print_string(PRINT_ANY,
+				     "mcast_querier_ipv4_other_timer",
+				     "mcast_querier_ipv4_other_timer %s ",
+				     sprint_time64(tval, other_time));
+		}
+		close_json_object();
+		open_json_object("mcast_querier_state_ipv6");
+		if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
+			querier_ip = format_host_rta(AF_INET6,
+						     bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]);
+			print_string(PRINT_FP, NULL, "%s ",
+				     "mcast_querier_ipv6_addr");
+			print_color_string(PRINT_ANY, COLOR_INET6,
+					   "mcast_querier_ipv6_addr", "%s ",
+					   querier_ip);
+		}
+		if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
+			print_uint(PRINT_ANY, "mcast_querier_ipv6_port",
+				   "mcast_querier_ipv6_port %u ",
+				   rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
+		if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]) {
+			tval = rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]);
+			print_string(PRINT_ANY,
+				     "mcast_querier_ipv6_other_timer",
+				     "mcast_querier_ipv6_other_timer %s ",
+				     sprint_time64(tval, other_time));
+		}
+		close_json_object();
+	}
 	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]) {
 		vattr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION];
 		print_uint(PRINT_ANY, "mcast_igmp_version",

