Return-Path: <netdev+bounces-291171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AQvFTrzEmpq5gYAu9opvQ
	(envelope-from <netdev+bounces-291171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:46:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B145C266A
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D7993009B2A
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 12:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB732DAFCB;
	Sun, 24 May 2026 12:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tchmB99b"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013070.outbound.protection.outlook.com [40.107.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1D3204F93
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 12:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779626806; cv=fail; b=r6K63T9jTtdMRdeemPcbboihQgLN+Iafwf0ImBTQYJRghFiE84tafsM8/KUKBtzxGxL0R0Q2rumLB5oAggmoI/F/5qi6SXNGRVmqAGHeN72zvZVVY17MTR5XMgugumDokTGLNAFzYSoAWRtGxHlq9pecTOhUyNF1T3tyKlAB/l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779626806; c=relaxed/simple;
	bh=EpiLTS6EiY/gxcDoqZj4FjqDIncQuzUU9kVQ5Rtdaj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n2OhJi3KXEvTGW+hZJT3+Hhsbjn7ArabOtHUgYQkDfrGFd+7XGhUJDxGC5uHs64priGlcE1f2oPNjBGLd63D6RFS9vca9nVols7UPftfe0kV98coikcrgBSN8TYNu94hgiqx/plI8h2UB4OzNylKTMCJX31S70/BsCQN3mNT7eA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tchmB99b; arc=fail smtp.client-ip=40.107.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARetriYrSXH9rWRAuD8esa2z89Y/T+xmguyUH6m8PMqQ864lOP4cy0DrKCUtAZDRQiERGgaT+aDZwA8WrXglhjPFzJWcE0hm2yc6JmonPwSbNWkfh27uYeLddseAQW0+GznEnJosEJy0YjPodzI5Pl+Me7PdyBPAz1OBaQqeAyawoFrlhSoWbeeLzQ6eKnIJqVPOqFYcIBsotbx55uSxQhkote7ZTOOC6TsMPB2UaLrG9Wy0KX2OZStEieJdCoEs4YI5CBMexbEUeIGFvxb0LEhPQaX6E4liMVNlk+RavWjjkcSjPuZXY69DbheCCJzffADUEVOlLdlBBP9i2dMiJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOMJZQI27nYPbcitR+k8rpOyu8TN/KCmdPnBFDyYzjM=;
 b=XZp2gvTstwxHCRVeOhKk1TWh+++P7bxYvuxk3edb2KcocuFZwh0DqDV5BwY2vqJXtq0M3LXSDuyahglud/BdUY6hyoSYxTMXSezOpZgrNZ2bEb0pJbUnC1ZI2tKpXW/6qVuMRjeQ4t7PgtOvdLpOrYgwO1dXwfFCLc1c45W7UD4RQVeYbSEEV0Z18WXqfoaWqsWifoAw9Y1KpC1T1seZUWCIsxyuMYM2f6DBV9JyITfLyMAp0iQDprEla/iWJO5WZ7vMIdZrkT1SqctQGJkgS8Lmc6WOv7Djc2vn9QYBKkaDYGbeEtry3bkveY9pnb4UFa6pKcOMwOMwp5daQICg9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOMJZQI27nYPbcitR+k8rpOyu8TN/KCmdPnBFDyYzjM=;
 b=tchmB99bQmDTzWZ9gbuG/WRYwyWz05f9UxybtxCcfFL2UmyUOHewog0QWOPkNhDUFYyOZ4s73FqvuJy4bn7bY514fM+kepbPkwx4szbUX2WOPzsmD21P4zxzx979vf3uGh0uKzV3/NNuP1bbC/AorwZogVZa5if5ATk9mKh6zQk3xeUqNYf2rXFgvXtn2TdLcCBrdCViwBxMuOPuMZxXPsItaC3J5eWPIfi5rwOOOWp4dB6Bn203hTTFhPx6aQJ8a/FijSNmDiXGInfEG3VcY5XzlgUqwq+ou0MgpFW4SuXX1x9MTXvbl7xM7mdkJyeDKlOb/J8xFTvnIPocl/C0Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 12:46:42 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 12:46:42 +0000
Date: Sun, 24 May 2026 15:46:33 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 01/11] bridge: add a READ_ONCE() in
 br_timer_value()
Message-ID: <20260524124633.GA74116@shredder>
References: <20260521131916.3627204-1-edumazet@google.com>
 <20260521131916.3627204-2-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521131916.3627204-2-edumazet@google.com>
X-ClientProxiedBy: FR4P281CA0245.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::9) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 517563fa-4e9a-42b5-7af3-08deb9928177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	pY3zbHz2kg4E6XW6cTIJhybiLF1h4/uA13fGlgcIZlpxIrD4VJ+5pfuGfv3c53fVUjKVfXxwqheI0ljTOGMZTs1FpD2cArmhdehjKDZCRGAxYjeYCIDTahzdcXoeZoWgmArV1dT06j9fxNVzb9rQh6uRkgTvIgGvmnfjX42XwhqdK568hZ/plLYekO9+x20hCTAtlNxK/0aW787uH3q8mXKU9Pzuko9jpABeyZfMm0E3bVHwpfy3MGEr8wHR/JUmFGrAq+x/x4/6Av5KYFM3BTXatp63oRcra8cyTWlbVufd786ch9lN5XPZFH+j6xK4iUvPq4Nl1vX3BdDY9TXsAruU42ZAYvW2kBFn8UmUeX3Ewg2VuW75FUr4eoeQTcIlaIQXTZvJGa3yRHPPUapaW8CIn9CzCaLbmNimvVYl7yLS+s5xbkvPmTQtFelp17qGyQNu9DwXpldadLav8EhTBWoRlZ0LjyVGTdeTl6AfR5ieJ4c7JeP9BOXVIz/32eM+y5CRbkZIfXqWVO0uuAak+XZbUdMktHX0BkRL39OVhF4WsRHirC41X3/J8P4obm/9PB7aJhxbgfqF3VqNG9yIg+1ath8Il8VDklTAEYydvPwaFxQgNYZS7Qyhp/HCNBCRBcX2EcNeRTGy3iVl+FCntLbYHh/V0K2ADjB2bRELDGJbuguhViRsCNF/qoI1jw/u
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?en29uRyyaUdKXNRsNSN3gPbtXDg/35mzeJPQ6uEVLcwzQaH+XdepZG/adoOU?=
 =?us-ascii?Q?YZsG9t16Ta3LGDrBTkabq6oHvQGRDUS/omMK08FiheX7PhxEnd0xA8s9f6Tz?=
 =?us-ascii?Q?8eO+9JW5OruYmx30u1zwVCNUrU7U5ClRiVd4jLnRSXym5Zx2RiI5gTUebtSb?=
 =?us-ascii?Q?obIyrRxxDYF2UQedq99XIhb/cy7SorINUT87hMSk3AplXEVnU/PN82ikmyaj?=
 =?us-ascii?Q?DOxwSBOrHxklxmqsVMUguI3VA6dXDf7ra0amtAzOFdYfUyIzAFsdn2OTEoCy?=
 =?us-ascii?Q?X593NBAUNxtceG47n7gfBApvfuRdVryp8qQh1YciBGJsPZ3CT1+M0+XfIRe2?=
 =?us-ascii?Q?v13WgSMLPxB6+/259ZQvngUZJwA9XS4ydnSTtSBSu2nIxKoYJVVr6EU/3Ay+?=
 =?us-ascii?Q?U0v8Am/cKgqG7lET+7iWXoeldZ4j+GRMrkH2quNgjqBiR4u4hPsF3DYcOL3C?=
 =?us-ascii?Q?AppgUQhxBC1XszTAu7nt6RW9CQctuS+EZyu7S1RBs43R0dvGmK6pd7G9iHy5?=
 =?us-ascii?Q?AiMhFtvGsa7zIJK5YwrOO0pJvnsrMWGtoxO7AI4hwOdi89SMhGtYrjALkugk?=
 =?us-ascii?Q?w/6PoDzaxNG61l7pHx+LubU8+h8eBsRhh8H2ndtMSH2l0GlY4ux3mZxvjXDZ?=
 =?us-ascii?Q?lGkzfjx3lohpCUNtArxJHUrRV/oBPQANtj1Rwy09ypu9jWgl9LHzghpV7xnI?=
 =?us-ascii?Q?jauXb0mXkIqB22JBX3+RYb0louv0bDlp3+39SU3Hv53BWbtJQpLH8/YHehoy?=
 =?us-ascii?Q?f7mKJ5bzHPNt3xQ68G77pJRa63kzJr21MlWZ0Ke2sso+SKAgGM0fKScQFRFv?=
 =?us-ascii?Q?FfKPiPJ/PtPAz4mZNx71AnHZ6Y76yl9Os4wcyXbWO1gDrq3br+bB63OADJy8?=
 =?us-ascii?Q?NAUlpG5pLjoVj6oY+sE9P66Ze40xqNouIim3FJ+3EV7pyBbVEik7aQe9JAfM?=
 =?us-ascii?Q?OpJE0Y8Zhg3uWlb47tvJQk4YoZ09nOUsBOF8pkwB0goN38bQ4ocKBh4ZGkWv?=
 =?us-ascii?Q?RAu1epDhckfBBkgzwTlA74ftKyue7ztm1xT1LyMFj8pS0ru9qmfdavu/D9Xy?=
 =?us-ascii?Q?HP4kNCghc+cs/1HoM/thmadQElOJcmyqXQWj1xo1Nr9XPDo1QbSm5/z/YKDq?=
 =?us-ascii?Q?2rhXaGDD5LKqtoIJKhfjCOdCwvU6OafEd35JQNyCdWEEW+9NiSZ8DbszKh3m?=
 =?us-ascii?Q?e4PxNn/lluFG3beNgW5AygYbMVynMqjZBq/x6jDlYacPqEtYr3smBHsp/51w?=
 =?us-ascii?Q?yRzGA2lSaz50N1dwbU2oFs3Ke9ngEcldFZybw0uK9T0y77eM+dOHasRkFdyy?=
 =?us-ascii?Q?1Xo1V87hlaaJ3ZAVrrRa0U1kO9nNqATX9v06F7oM/a9r+RKNV2PA3y6M9FzH?=
 =?us-ascii?Q?SoEN/Vxx3qsAsZXpqQjEXqgTy4oCW9rB3McUOj8UwSJNigag1BKnEMcHDQTe?=
 =?us-ascii?Q?oLiNQjW/v1NCDJBaChLP/mss8ggYfNmBwGaDDpLqMxBixvbJt4/4tOkA4vDh?=
 =?us-ascii?Q?JpkIJySThfAcshOPq7TPqyLqQkQZaHKYumI8ma/c5kB0Kd1krkdIRKc7+8iu?=
 =?us-ascii?Q?/2AuoHRsfx/zXD05l50BlgB//op0S6oboGgLQ6jXWpEoD2w2HvzhsUWvO66J?=
 =?us-ascii?Q?FCBAPUJOzN5fwCSGyt6U76wwGbh2vsbYtm4vh1wfJtTJJdXK9RIyNOdIoUl0?=
 =?us-ascii?Q?c6PdjPNKUjlJC1GSGoc+ka9IFEM7FpOE1vHSfQtst/hm0kFr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517563fa-4e9a-42b5-7af3-08deb9928177
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 12:46:42.3147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdXoonipP57zPd5DgtocN5Qt70+p/EiuyPOTjZpnXLtF0zJEVi9haUClcxwsQeUWS1hqdioGjDuIdA3wM2NN0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291171-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,blackwall.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B7B145C266A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 01:19:06PM +0000, Eric Dumazet wrote:
> br_timer_value() can be called locklessly, the expires field
> could be changed concurrently.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

