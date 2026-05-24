Return-Path: <netdev+bounces-291176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4G1dDt3zEmpq5gYAu9opvQ
	(envelope-from <netdev+bounces-291176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:49:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 214695C2690
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0214300250A
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 12:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D611F3932EA;
	Sun, 24 May 2026 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CTCO444m"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010056.outbound.protection.outlook.com [40.93.198.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A76A1519B4
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779626967; cv=fail; b=JWfBd4bntmSKw6i8hy9eWBInSKr/rzVkYzrDorXtb5LnyFEa/0gCSDq45Ibik7jzOjG9gBIw4q9Gu6Tk/CQKNUpocQRIoxQyXRrSoSLLG8gjp/Z+mBsFwOKGMW3imfDvWP13ro392V+uLH5EUzU7amm8GDHS1uOZfIeHqApM3qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779626967; c=relaxed/simple;
	bh=wx3+p6QD7DMWIE9mv6jmmoLEKd3W3ZXImVh3STWY2KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LlJG11TC4SLfow5oyR4KTKVc4+OoK3ian9wvzsTrxMYYXFnk9FEP1xB1ZqyAitC9/2sRYEwbosZL4CNNRGaPoDcBOwn4rMOJgOOgIhtTuSqwrFDaVkT1dpJ1EzFQfxsC2BKndcI5/jXKtp2+SzioxeOWGRW78JxvucpmGohoYLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CTCO444m; arc=fail smtp.client-ip=40.93.198.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnlmlXB2ugmYZGFJSD6cwKjR5zQmwpSvXrlkt5hwsuCpQ8ohGd9x9Y9mDRNABFziPEclf4MjhtOoIIuRo+hIm2bxouVudMYr+M+skiNQFQBF6DGYZBNH9PoOOqABfOr/rkaL9k9K0FeyFf0Nu1Ducva3q16kVkwnyTW/6ZJyDdgq52Wav2ayXoHXjYpy4E8byMTk8cPC6Qr299o2HYVBDO87uK+QQeogzNxBRY4+4JFKKvW26pxLM57BT3lPjJcsLoiRDat4ORfYOvp41vw7HMGO4RxWdnYI7HjGQaNgrPCgMQ+f512gSDz9H0RrGw3lnxhrFOYiWG45CZLoJLxc2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDQ38+hfYyob3CJPd9G9aJRfeHo8CQzC3dBWZb54DtU=;
 b=LqLEzs25p4ulAIkXMIIO/R3IIwZIHa2JBtmIZr98yLoiCV3Pj1XgpQWXK18K2FkAxzV6I/9E5/cQPiMKtoUF+6mXS9ldRCbKEsXFjUKlJ0jKV8e+nY7hIoNLy8WKtf+ed4WSl1uUQpoTbqKthv6n47YY4ikkB7Fv1Xka/etkdoOXms/em7hr2ZSY/q+O6gRdAtC58EUsxTlTtZUVmUHdiqvCwZuwYhc1lKpqJRnRNMEj4YsGEGx0/XY9XWXAUcObxEeFOX9RupiRuLaI0qnDu+FqUslTxviZPUUMAQTxjRBIr3kAXOW8vvZI9FzlFdmc4m7VS7tIPRjJ7JkE707uTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDQ38+hfYyob3CJPd9G9aJRfeHo8CQzC3dBWZb54DtU=;
 b=CTCO444mWzoDkydaKbRgksp2dGkxSY3kfPf81YtHP0K9/FNXu2zw4LLCVIkwf85UfFdC25lG9Qll8JnS3agygpWlmkVFGmiHoB3V1VVBtye0ChZZiwjc5S+0B48ByeJaJa3K/eTY2vGSjJgstabyAd9KPeNlAMBiizBYjfdi4i0+5TS2qyUaXByFHmDQQmoRJuiFRAEERyAQBF/XaRfNQkPJKwjkVqCGu69GQmY6uVqco3BkZdPcRslpdOPwVUsgSgdPhU6XqiU32ZmjGmpshq+PDjEhclhU2XRYxEfpO5WL86LjOix/EcYAoAhwT2j5dgkgW7V4jsRLyGqoV6YVmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 12:48:53 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 12:48:53 +0000
Date: Sun, 24 May 2026 15:48:42 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 07/11] bridge: provide lockless access to
 p->designated_port
Message-ID: <20260524124842.GG74116@shredder>
References: <20260521131916.3627204-1-edumazet@google.com>
 <20260521131916.3627204-8-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521131916.3627204-8-edumazet@google.com>
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 87256326-9348-4a27-1b6f-08deb992cfbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|6133799003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	CBKlkLgJLWV2N8TDlmKvCOJlMNQNOKij+SCKM+edVQKL7gRd9yDK8qAqsvfgw9ZRWTspPs9GA5MTSayvybvqykLk5/luuIPQwke7kQYib/t7JlEOz2fu/9hhFTkGPzZVPvICFgyu0G77rh5ZFZdFtbGxlvtCMYNWkgtXNaxpMsUGER2GioMSahDB8TYPPRRkIY+CWG8Swl+DECzj7AsGf55o4py1ou1iqGk8PdIuLWiY4YkqWpyOlOcDBcSTLy30GnD7lGumxSdQ6mn2V2WKAqYp+tFSuzx6UMokElOtZgkT7hcoz9yXeI7d+ZS4pljIEslacf9GfE1Y9f2rqRWTQ/KFMgfOJ8h6Ggh6UzeZqyA++zmVqKgnUGAKG4/KqDzA1dvMyCiUjI5X9f3JTOGMTlxPGnXEYwrhpHHruhPixcmgyq9YBsQUPX818Lvka9ImRtB8pfZvEbBFfNhgomVHghAMwP26TK8igqLkiHs56UzYsPp3jis+Lb/OyFUrI50gS+zQiF4Hq1zW5I8rafjs3ONVGhJI3Spvv88YJIepEBK+WESAyrjD22oaMR97wLDevfFncRNYD1WRL0fIhq/9dK0Wnl6R9lEKiCwiRyRVW3Ppbl+Y/RwdwpYRdnWpJS0EBPvZ8wVZaTLYkm2Pd5znCNMLUW7kC9LcZR7PqRiAeiaclS0VaYL60bVtgCq2XwpK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(6133799003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EH6629TfS6E4zNEj+flwxGMT/LrZ8mCVUnXixmCh1GiTmCRQ+ldradd6GhZd?=
 =?us-ascii?Q?Aaa40hNAKpO5WK2jZNWzYzap7VFqr0qdvlcoUjiGTWGUBwu+bzZzEga1zbaJ?=
 =?us-ascii?Q?Qrnn5Qj8/kyNkMgsp2mRMhj4/Hyfj7uDFsZkthfrxxuCPY599OyaPukayHLz?=
 =?us-ascii?Q?4bbeknFNB/e0QuUWiQ7IoFqpHbX8TqXjlOGiu3/Jb7Drmg4PedatKAIB8oGV?=
 =?us-ascii?Q?z2j0pRsN97POsIB/f3YFlgTnL2tJsAOZ1pDz7IHFkFHveAGhvOy7c9uivxrd?=
 =?us-ascii?Q?eZ8SC96+31cCcigqXeb9EBOb00ZPQKAzfxI4g5rtXrplccqEpAmSCFMmWEFb?=
 =?us-ascii?Q?NsNboOh4YqSbYALL5kbBOFJYuCeprHTR2Wp4dl/14nIRfK6Y7E3PEhiuuvPD?=
 =?us-ascii?Q?L0MCF9wxnysc7L6LTBDNN1VbDbCoXjIlSqnpMjqshmeX7UKh2663pr9/2TUO?=
 =?us-ascii?Q?K54l1XmsMcdYFu0ZAjW+Y023jXjrpw/zmiJZsEPp7S9OVIi+lhUn3vo03rNs?=
 =?us-ascii?Q?cq5kHdBwdVSSwWbbiCuZNxxJwhxw+h91fYg7/8E68c6LOyd1AwjgCDMqcupX?=
 =?us-ascii?Q?5Z0NqaB3XaV87OsqZCse2N1vosHAooi4Aomh9KOI2BJxzlJmAqCUGqn0bv4B?=
 =?us-ascii?Q?PqB7f/6wK9Gws1e9M0cpE2oxS5vCAKF6Ns+T+L/vvufkN+w87lWPUuauGKol?=
 =?us-ascii?Q?nb3/932vgOKmn1pRVNdTrcBIF4TQQ05B5dKVjBTpfmjRNYULoH+N0oA7Hs5G?=
 =?us-ascii?Q?iqRscE+N8qtcgKBZKaIpf0KrZiI1XrHYz0+9rXgvpBDXrwDnIcxb+cBN2Hm0?=
 =?us-ascii?Q?FVMyl4yV04GkirWbdbQ1euJGdiWE5RWLuxgeLrOxoMz4W9XmLHPYzLctpoo8?=
 =?us-ascii?Q?t3vvqypQ/WgX2pLzS0rMa3eSQfhY0HaYzgznl+ZSNy1LiihFHyL9ZsUqt/Fa?=
 =?us-ascii?Q?rW8fxmdFD8Z+7UD5WywehPQ25L1j+uU1uuGxVZfiD8Hsh+nVkd0BI/dWCDvg?=
 =?us-ascii?Q?oBH4fIkp3fmRp35oTUELmpvlkAXHzh3H/RL1pXylsZantby64TbJZ9G35AyX?=
 =?us-ascii?Q?liLQ32SY0HOKcbq4ky4mhfKB3XCOd2s+/kXfKdJh4sKwiqiYo8K3EAJRUKjP?=
 =?us-ascii?Q?201sJmJy44i+XDq6/fbH9jRudTLaWwC6STHrpdf9DGkzQ+K3+j+yQ9mPSOgz?=
 =?us-ascii?Q?j3cRVljP0xjCDPWTApnPiibqF5bqBTDcnnubylsy5uk4gcrqVh5P8XAZaw7J?=
 =?us-ascii?Q?mxpfLb2mknPVNk1J2zr8++2Phu4uRjaIM1BZ+oxBR02fUxSIaY7leEzNJIdT?=
 =?us-ascii?Q?Gxf/DKhxucR1e3VrwdmEig7p2fGr2KMygShSdakrXGb+cKWPDLyFFxX8qLWp?=
 =?us-ascii?Q?6nBcjxTqEmsv67cojpigMOoN5lV9RqzHU7B0fasvvaCd7x968f1/KYPH4BnL?=
 =?us-ascii?Q?hiryiMto24pQ8u/b+QKKsDy+o7N6B278XqQfzisxijcwnjFG/LIG0na6Ul8F?=
 =?us-ascii?Q?8WpiAvcjniXGsFlboaKbUt5sZlVthSDH87JACJ3JYKJN/1cXDxKZW6dsIyaW?=
 =?us-ascii?Q?lnGYanqWls4HFfoEjujtm8T0mnOYN4WGb+Q4ObdVQ76OaA1oe+4zUDSO1DN6?=
 =?us-ascii?Q?EHOr8VDU7T0kr9Z0o+D1u8M7xnudMH6dszwTgbLtQ25lItrtTFqsxlyetc7S?=
 =?us-ascii?Q?LeJS1ZVg2MCij3bsC9MVABRzXZI5qoUsf2ODYlLu9C4/P69H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87256326-9348-4a27-1b6f-08deb992cfbf
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 12:48:53.5991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hkv8LX1iDkEZiP4+9in3nVFIuy+VdifPHX8GKhIwQRKF1YC6wwQmU77Op4KfwxqpI4EKC9tm69IhNWbbtAKTvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291176-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,blackwall.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: 214695C2690
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 01:19:12PM +0000, Eric Dumazet wrote:
> Add READ_ONCE()/WRITE_ONCE() annotations around p->designated_cost

s/designated_cost/designated_port/

> 
> This is needed at least for sysfs show_designated_port(), BRCTL_GET_PORT_INFO
> and upcoming RTNL avoidance in "ip link" dumps (cf br_port_fill_attrs()).
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

