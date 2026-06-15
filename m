Return-Path: <netdev+bounces-299438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F8fBKLjyL2pGJgUAu9opvQ
	(envelope-from <netdev+bounces-299438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:40:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 185926864C3
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:40:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=YrRw9AGS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299438-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299438-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2629330173B4
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B8E3E7BBB;
	Mon, 15 Jun 2026 12:38:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012066.outbound.protection.outlook.com [40.107.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633183E4C98
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 12:38:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527112; cv=fail; b=Ycb2A9rbio6tvknp4KzUU4QeUVjyeBBRgp9iFCYYMSNG+T/oD49f1hAhw8bd/PianguOGyDzhzdmPgDK+hxyt8Yy19mwjZmcpZ37MSOkFo/YRR7zTvuDXK0c3l57Tf/vsH3oBdRwio646AXrWTULeh2qssSeOz00UVbGrMamGZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527112; c=relaxed/simple;
	bh=769lEhN8C7GuUgmOG99HBcmis0C2aIkBgK4LXi3F4LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=obhaJmCejP9KAqLLeeV0TR9n4p19HoLSUKsDj4Kb6j8VpEMyPw9mfh5g/IekLS0ZzP4+zNfiuN/Vs55MiO53keoBOR/F+5jqj7Wd+bE9N3+NK3l6sGv8tYn+1T3zbBIgBFLy04IlK136HXqTxPdu3zalgGboZsTmf/lQh/z7Wh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YrRw9AGS; arc=fail smtp.client-ip=40.107.200.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egiFTNPEPtTimOEsJ8iaK/KYY0frPWUSl33RYWD9evTZbm6ZNmuYTYEVMgG75kEPhi+GzMTGLCIfKRh7evi9Q2Q8JbiuN5ltBbo62ntNuwKBWPwlAyMgIN1PFSDl+RzgFqcTUhvmvizRVsYI5oc5tugzmUI7OewvDGzdltqnFMNCLmeEmzhoeqHzW6qF1O954ZDJtk7VMnW8utjA3hiCgUaADzmFLZ057lh9kvrS6IxfAoKb9pHeaz8IUBCvZ/Ela0008GTX6BKUR9H9hKB83G7ZZBxs3txvVqOG5+NEgz9CO+9VRg2rASpRB0GCXTlQyOaft4HzE8df1q4Q0vAqug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMBKgBeWdJ7w5UzOu8JWI2KwdlXTC+l77labX1WEWe8=;
 b=ZXx/fH9gQsuij0UU5l+JfdzjmGeJjTSwdZD+/6oq0gxV9JEdIwqJ67+Om23cyhx+o80oF4UT2j/ShHoi3yhDKiTyfWZlH/TcU2bO8jIkZTlRlRSYjLVZV2wxJB+s+s5Y8Z98+V0fEQFXjarllnWg778/8ah9z9gHBKAdqn0DnxFamHjFwYD4IAQEMQjSIBD2jcsSrkz4aoIjFD6kPoQ6kJynRX1u/OzJs8RMqIceMgjz8ZRfbJoWqPzpVd27Chq3zFY6Bz9RWPjEBGasJTNNDwQnqfsix8cHp+i4F9uQZJh1UaU1oUVY1g8sfXq5S9oiO82zO9cmoGrVUR5VTpIFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMBKgBeWdJ7w5UzOu8JWI2KwdlXTC+l77labX1WEWe8=;
 b=YrRw9AGSBuZLxFjWvqFfX/eFaQCUQSPlPCtbOBRqbMFCbpEZLhVBFOnsJRR6PP+su4dsLKUA0I6UiJuG5bW48tMiEkx88dX9h/cpL9taAjj9RSKk1qppeirMPCwO5P3AHRpeBaIIbHLJFU/Gljqoap8UOWD8eLeVQ79ZsXI3cVMSr2Pv6x9e3kmkseXPVTMl7OhQoBIiny1vSj/niXfd5yC4CWnqocFkQz3GREra32muWu0S/9cJsWwnfhEN9DnQLug+NCxI61qDoUI7WAj4f/5K/xcVsgRzzvjb6dE1hMSUCD0qi6GSe9KB8GT9vck1hLrJcaOwLoPF5wsNi02wbg==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 12:38:26 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0113.014; Mon, 15 Jun 2026
 12:38:26 +0000
Date: Mon, 15 Jun 2026 15:38:15 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 1/5] ipv4: fib: Flush all fib_info in
 fib_table_flush() during netns dismantle.
Message-ID: <20260615123815.GA485439@shredder>
References: <20260612063225.455191-1-kuniyu@google.com>
 <20260612063225.455191-2-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612063225.455191-2-kuniyu@google.com>
X-ClientProxiedBy: FR4P281CA0380.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::8) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: 34bb3eb3-2035-4abd-5af4-08decadafe56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ulcvfmPocTj2CToH+htySW9t6e/nybreANAyIfUlIimNdWaPCEc6yeCEUmZtZlAk0rFr851pY7O5oVTJ/AyoGJ6xjHbmiT60WDKq3fXsJyIeD3dL69odk0v44AyqEa0ClIdBtISlhd0PBnoALCTiAmPKo9t3ogozeKaUWqflhrRRhZo4rbx7KvHs3FSVOfGqexL78N1cGb/y7vFnpYYK8RSp8tphnNrNNEUa1x1gTUAdF4fFB3M/rxXC3p+h1uvn2lBJ55+1VIVUU4nilPaz59YOHxJKV8Z0dTy7w8l/y4YgzKpmQ9uMBNfMTrWlyS4aZRUI2wmx1/C+SlPZOUJN+sDL2RKczai4uCleIxoEL/+fKTXCGFMVf/AO6LK4CynfG5RMn65KYqzzNdyw1dDIUQiceifL+aAZshe33GPAG7N2EFIQ0B/jEIeQ/oJWUMxx138nB85SZoNlb1pLzP9rqowAICHnHrj9kOD0O3mQiHfBrVMXcBRZ8InRQNJCJU7uVuFRYwSEdzOqHaOJNKIEw2LX8EfJG+SAXAu7cbaEYhI/ChzwfpUY+PPPPyYb9Fu79e6cKkFPtaPQCdwZY+j5LuQjbf7+/LAzG4WEJbLb+lZU37gIumkyze80yMn1VGaTx3qlVBQnkDbYym3byaxwp+nrIHBWE/DW1TaaNf7HulnJ+cTWJiOq3Jta6I+ArJyE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N57lgrxHjYhXSRvVDVMv8Co8hyBubj0ZjmsNLiYzgbvFqL5Tq7kXFDGxdHBK?=
 =?us-ascii?Q?cyYpuxsQeP1/Wt8g0mf6AJsiIh/2P6b20DTSGcGdn8kkiAEDHosd7QuCMbsJ?=
 =?us-ascii?Q?c5mYIi8QNy+bELb+B6ryANWsyHyz+vWUptzOZEPmN3uZbm6MCaQb+Quow0F8?=
 =?us-ascii?Q?uB9vhFqSbZsD+3719E5KPSNmqIsx1AA78RtLBUKY5YHFySSsQ/41gb49N/rI?=
 =?us-ascii?Q?aHhH/uSOKHTrN5QKCesGpgPfypN97VC+sHm5hpdXI+MXJdcUpv/tLbpgssVM?=
 =?us-ascii?Q?5xL3Tzv/yQQkFJDCecQLbbe0PnLexJhdPqGb+xpTXH2gQ5Yx6fhdXOkwtgEG?=
 =?us-ascii?Q?+8NW2fsJ27DlTu/lQteCkuULxKksU1RlDbjbu8TsSgSs4G21Rszli1YcDvjp?=
 =?us-ascii?Q?3kDyqHipSCUlEGhfLu74/r3/xGCOXQFzCsT5gvmeQXbPQsjl8ZYpCzloekA7?=
 =?us-ascii?Q?GH/al0vUGE9NBhyfzDUyTg1bVyhR2gyAF40OWV95I5jlhl4DG3Khc9mkTv54?=
 =?us-ascii?Q?fQzVCyxD/cBBm/BN6apG5usCMC+VHEdsrruq+IAhApp2b8WWvIzF/6cls7TE?=
 =?us-ascii?Q?cOUxHPG50PdaJnqopVn4zQoTjHkzW9oih+1VU/hawGZN1tz88OydfYnA+LAi?=
 =?us-ascii?Q?YaTzEoopjB67aP46FIIylP0b6ZsWlrIR3KZ/uvh7P1eTa3l8E2V232VsvRPt?=
 =?us-ascii?Q?bUGa39xQ1VkMWnXi4wCWXewMFHORdADQhnIGR0AiM7JgucjifCbalQcu74HV?=
 =?us-ascii?Q?0o2GwjaBPtEAaxxyK8Q+INEsvgRpAgqgpuuvBwW+opN91SH8EOT9QJAoj/pS?=
 =?us-ascii?Q?wtu1M9YKp7Q77vjC2KrbiCnp8GO2YRPj2zMqlfgnoaCwfH2wvDQK4Zr3PxWZ?=
 =?us-ascii?Q?VqS68Zd1cZivloc2uoJXTPVOv/VjjjOktWrv6Akti4/GXVdBEX44aBcQgt9U?=
 =?us-ascii?Q?40fxj8uGg02x0lbZFFhsC48cxipOzN2TrbvJtG5QMaggzKQl6UZD0YX8Vdaf?=
 =?us-ascii?Q?OT+2HttkVr7NC868vi9RBHmrBjnOLiBa+w3H9H+Bl9hUd99RHZeb2Joq7Ad5?=
 =?us-ascii?Q?2eYFg8PSOwEmDwNhdL4TDQwAAMGwJvDOBFOU9wsRkll07cf+pgdx4obYjcNY?=
 =?us-ascii?Q?RJb788eLrEyDpED78RZX0rnv5oaNXjlPIAK82vxdDfthdZTxPNd1mfHVc2N8?=
 =?us-ascii?Q?Dsu7BDzqgdhzFJfIfE4iSIqGhfxlpLn+jvjNLQM4fWbBpWhNRAW7tG5Dlmql?=
 =?us-ascii?Q?y+43MPPoqWnlwi275cgGJ7qM9UdLvQgWmA3IQz0IRQzQaNfWzmHWog1Ywty0?=
 =?us-ascii?Q?x4L9cZAxPSRqK2sHi3cAcgP1Xu+sg1b7Bsvjbh6zXuoSoRcVJJmhGEaeaw31?=
 =?us-ascii?Q?z/OFzC7ZsXFuTffXbbfLzV+9I59csGGrKmJPliNnuuIGPz1ZjTpbAe4aq2EJ?=
 =?us-ascii?Q?tgc1A+pbAj/SIU7wP8i58UwXH2rGHz6Jc6KSXzoNUsmXebIyzt4YeXfDp+gp?=
 =?us-ascii?Q?mKXvQh/QlcdHg5v/xaVUCnE0yaAckGlmt3meHE64JbYHm4KDK7x5avdPnGRC?=
 =?us-ascii?Q?27AXtLz3FcrJLUDsoJv+G5LRXx/HLYl1Y9QT6/8+eWtIGS3NRmnVr4pBMRhT?=
 =?us-ascii?Q?fnzvl4lrHNy9JrKbr1v9jzDHJAWLXpwb5eWH2xI71B0FPUzx52c6ag0dpeMy?=
 =?us-ascii?Q?FYZpWcStW8APeBmNg7uiezmj0XmDki/7SNt7rNCO//Zr6NNX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bb3eb3-2035-4abd-5af4-08decadafe56
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 12:38:26.1034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBc0MS++CcUk2hdhK6QtFxEbWUGgEnrTuF6n7RPxpb+6hU5bWVvZr0DGhcNgBRKxOFVWm6ZHoge1uS7XryTYZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299438-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 185926864C3

On Fri, Jun 12, 2026 at 06:32:04AM +0000, Kuniyuki Iwashima wrote:
> Even when fib_table_flush() is called with flush_all true, it does
> not flush all fib_info due to this condition:
> 
>   !(fi->fib_flags & RTNH_F_DEAD) && !fib_props[fa->fa_type].error)
> 
> This creates an implicit ordering between default_device_exit_batch()
> and fib_net_exit_batch().
> 
> fib_table_flush(flush_all=true) must be called after all devices
> are NETDEV_UNREGISTERed, which is after nexthop_flush_dev() marks
> RTNH_F_DEAD.

Nit: That's for nexthop objects. For the legacy API, the flag is set by
fib_sync_down_dev().

> 
> This would cause memory leak if the order were reversed.
> 
> fib_table_flush() does not skip non-dead error routes when flush_all
> is true:
> 
>   !flush_all &&
>   !(fi->fib_flags & RTNH_F_DEAD) && fib_props[fa->fa_type].error
> 
> Let's merge the two conditions not to skip all non-dead fib_info
> during netns dismantle.
> 
> Note that we could further apply !flush_all to the basic table
> id check and the rtmsg_fib() call in the loop.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

