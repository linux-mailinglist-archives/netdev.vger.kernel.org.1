Return-Path: <netdev+bounces-261031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mI+4GlMwn2lXZQQAu9opvQ
	(envelope-from <netdev+bounces-261031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:24:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B32019B80E
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5404300A670
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 17:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EF23D4101;
	Wed, 25 Feb 2026 17:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F4RVrgVQ"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011061.outbound.protection.outlook.com [52.101.52.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AC91F5437
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772040263; cv=fail; b=AeaXz1oPoI3AQumDkzbKlI5GbpkQ3ot0BiugRN7EMxHBvjh5NSRnR/79SAIkddZFePeYu12oIV2O+sSgQcntoq2AZy3J+5d0FTgHvxGwBXZiieewUp/hzfpJ5wl8KPf+BKrMM+JxJs09gzbaNaMkaKwfOpd69WAvvS9jT7NHcfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772040263; c=relaxed/simple;
	bh=+62yAf0B2h/tYLdzZ8BGv7Uwq/AGl34bz0feAUnDkcM=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=nUv+1ikwGEM5v9Oo5Ej/BiAZhnsAng3RSt8pYMSb+uaKrykZMSgEi3409o/qLRHYyHXX3/QGnXkjTvuyvtUVGA31o1DstTER9nYKJuQ/GLaQTxqC6491T4MI0QiRZtlyLOoxWumKx9N+sShAkXghpX3rE7pSyrVWfnzMgsHtH3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F4RVrgVQ; arc=fail smtp.client-ip=52.101.52.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjBWW2P+3Bj8mEbgx4f28JBFGqKTb3DM9CryBurAmFVnwGloE6kqWVD01uzbiimp6eqULynoO33chrBaYfk95v18zFDX6DKYEbciGn3/Jeh1D/KuxZs/WHh7b6p5a3xePuBxlpEYRUebgUC4OfCWjWMWtLqb7mS1hD+15MIaN5EgpdG4n9hhomnl5PQfSDpKzPNWiEQF8fUaNnF6uZTsVFh7MPU8hHMh2LpsxR+NqygO9HajQmSBoKbXtfTz3v05a62czfEeD1nSrWY77uCh+BZHvRSev54aa/kLHHqVgU26yTGGcCZe3F3sOLsgtH8J4MDHxhRYkvzolPcDs5migg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+62yAf0B2h/tYLdzZ8BGv7Uwq/AGl34bz0feAUnDkcM=;
 b=CFk00Y5qJHE4sm8TuVb1oAMvkgKfzxxbFRG4/p3BC7JP79FpDMQYHacyoa4IYtvG7as5FJ8Fs6qmDMhhiktB8/OnIj65iry64H6oxqhPoJD3lCWhZv2rv/HlSmAvfP76IGDds9oXg6oc7vxLCI7s/kK36fsBeWsg9ezlTwSJDfF2KxFPgQgk1q68IHysjQ2k77hY+16939eabTuedC4LZxMLAtp9oOta9kunbByGB/tu3mFdO3CMAEZ741bzxpT5FdA7tS/n5MpVW0TpoNnROgZOCMu2cmlX4JRZvaKKz/qcaH5qChQusw9V703FZuRa+jJPcjG+r8hvlRf8SanI1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+62yAf0B2h/tYLdzZ8BGv7Uwq/AGl34bz0feAUnDkcM=;
 b=F4RVrgVQL3jvrg75QFTJFSyGj6OO97k98jhE+pha9tVXp+Gvy/1SPsLXJRArvYBnwwk7Cp/Q9ryUFn77ijmK+/NxzRnu8ygXkP3WXKrQk2P9nGZpFD6XOiCsj1g8Z4xRp/aynL9/wFpJdFRb+qNOQMhdcNmODrFOLpkv0ZaDbcGEdMED2WBj2RX68Av+0nISptGzSOMfPtpUvb5V/ixhAohmuAL5/NQHMaeMQKVRT8o8RIs8MdRashHm43LHkv7P3oKtlQ8UnxFy6CRcg0HA8f3dVPQznuUqIWIkuDAXwcAjbQZB09OB5RM3xqRFD43rJKRuVpwxJYLC2GmSP7/f0w==
Received: from SJ0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:a03:33e::31)
 by DS0PR12MB7725.namprd12.prod.outlook.com (2603:10b6:8:136::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 17:24:15 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:33e:cafe::18) by SJ0PR03CA0056.outlook.office365.com
 (2603:10b6:a03:33e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Wed,
 25 Feb 2026 17:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 17:24:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 09:23:50 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 09:23:46 -0800
References: <28504887df314588c7255e9911769c36f751edee.1771964872.git.dcaratti@redhat.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Davide Caratti <dcaratti@redhat.com>
CC: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Petr Machata
	<petrm@mellanox.com>, Ido Schimmel <idosch@mellanox.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net] net/sched: ets: fix divide by zero in the offload path
Date: Wed, 25 Feb 2026 18:23:13 +0100
In-Reply-To: <28504887df314588c7255e9911769c36f751edee.1771964872.git.dcaratti@redhat.com>
Message-ID: <87tsv4g2jk.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|DS0PR12MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: dc8d25e3-1044-4d3e-28d1-08de7492b32b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	Y6Pmzj57fpNkmN/zFzpWb7MMZgazy1JXk29pgru1XtkmsiDjzbSF4OlAmx5tRfDKV2mxKF1kYV/4vXNqHJsFCXtw8RGxdHAMgmM4914yrUZNTP/jiPfIgjwoV1b+XDv20+4XKpnVQCnZ61Jp4BBn6RU/ZWPY/b9PJ/jUltZWKnsueyBLK1LMCBZIpdc5UgZul7R1CR48aBmc/3dggv+u5ZmqgwnaMydr/AZhXSjbS2ZlNskFtsT8qERWdbuTR+vnPfo2k6c2rUmvY9PvkTj6jnJomIlLOQBBWn0/V0K9M/sDfpHNVto+z+fMy7owuA5ufxXIIvFIhj/JLYL2i4KdcxjNBQTaIHtJgrNuV73kj7I9bUAWws9kAKKcL/UQG9vRuqeD+lCHT71JcSEv8Eql3aXcvIwi9IeYJjjwwSiI7mySDKIT76sQdzvGCAk7RTTO7YronIYhsvzWQ9ThdSivoV7ashpqNp3azK5iMQnp4GZpx2Z9J5FbHGekSFa1yMW7iXM+M0/MY96LejlY1mD7Sp+8z41Zy2lIzICtsw/Qy8JEObsrU3J7/QuTNOk5fFiEqzo+YglqV8ZWUqU2weOkwmTie7wGhyuUYlm2IPKsh06r5b3oez6Krs5WLTH0rDlMAfjsMC7kwDaFf8x3BrL4AbZdBbLmZ+4NulrFSe4KQpe0dHD0029mqn+ywYKMvilWpil8UfH3nsF0wsuqvEYLmlki7d8fLmVGXP9YJXA3s4kHjnDmuqL94qEVu4cgHL4uSkUrnn+RBiqOMSKzCz1eMEfkoAzz179di8/8MOT20ijz7XldKj48m9v92wXXDrflqCV76/Qz79xGlzSqdkfpVA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+l4vu9saEzPAwPcT6y4ViOUVV5zxbb66xqLdmHuypE6OYRBvPRuTzCRXk+t3Gc5yL8uUdZYfodMNlUqlC6L4QO8VwLzQltBavTjSrrIbduuzDcyQMS/W7zzOvqUArye080CE/vqDtgR4wLswl7qWoMkitM0GBpfEoZJNQHpfeFyYB+poj/imBiQK6NK4Y5gPqApO76YexIoTVZsGvIM/wxWeqU6faPXou23E4Fhthyp0iQFGtEauERke417Crw3BqXgdZnnqxjEaUfM5JRdvYuOvEO4dS44dXj8dgjZsF7iM/1Lf8AULvzNSG5uZ8oUzmR3/CIeje1PDO9DS/uG4LUwz5W9h3hrrzFD830glUxhT+d9XybSviFxG62+s0GyCwbUV8bFRZd1Vg8U+smIkJKUwQMBOLKPFXj3qr/l5ooHe9mKoTB6AsgGikqpKwN2Y
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 17:24:15.2201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8d25e3-1044-4d3e-28d1-08de7492b32b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7725
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,mellanox.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261031-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.975];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 8B32019B80E
X-Rspamd-Action: no action


Davide Caratti <dcaratti@redhat.com> writes:

> Offloading ETS requires computing each class' WRR weight: this is done by
> averaging over the sums of quanta as 'q_sum' and 'q_psum'. Using unsigned
> int, the same integer size as the individual DRR quanta, can overflow and
> even cause division by zero, like it happened in the following splat:

...

> Fix this using 64-bit integers for 'q_sum' and 'q_psum'.
>
> Cc: stable@vger.kernel.org
> Fixes: d35eb52bd2ac ("net: sch_ets: Make the ETS qdisc offloadable")
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>

Thanks for the fix!

Reviewed-by: Petr Machata <petrm@nvidia.com>

