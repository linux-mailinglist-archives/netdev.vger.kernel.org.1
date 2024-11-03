Return-Path: <netdev+bounces-141291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D03EC9BA5EB
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 15:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB2B2817F5
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 14:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3945916F0EB;
	Sun,  3 Nov 2024 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AkKxIqUW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF51A31
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730643877; cv=fail; b=tzwhS+SgAGRrhNSfnx+DXjQSc3fKrfSlaFekyMunOOv8+9XhAPCHBzkU2I1Mn0nNjkwTzQjAjKGc5RCozTu79HPb7hKDFXnNblEPLQmcnakjZbHedIa/F8JwrwGU7JC8gRJGdPKs/hcZV9cxPtGyovr3LwvU8rpsKlm7qOd2ojs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730643877; c=relaxed/simple;
	bh=z7huJztrelyAbtQEdvqx/2r6t1Wmm+lBPDayyRm6CDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fTk3wZrG4bM4f2MJ0W3j5F9aW7UU8G7mSS9NYjvmNOfJP7+gKgg/txp/0IwVee4ttYdbEgejkI+8NLS58h9gNptSEfAqoxDtzb3ZhS46VUDMNdXtO59nw79JpARLzwQqyas5Q48pUOnLC9+gLPiPkWsc5xe1LUt+vUjXS5KJ4KI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AkKxIqUW; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/SVewJeJJfY/pq+ZPND/TO70sE7WYk0IUJAua6HpP/DUPf3/BDiltvHQiMEQahuIQgf69MsKw9Ku9c4vKP/QcR+8+cOqWACDVpjKRZkmTm61mqVbMgag0FEcBYSIZ9Ez8ByG0T1u7tzo6R4z2MGJdq7WNJdtcztZNHvvb6l5aVzpACzLqKgKaoSGNMhkdOZ/G6PUEVUpTUZEFcerP3ZM9/uvLDh67WpxmeDVmyLO/ys5GAxKFfpNIFPBrTkS6wqCDNQMu34a5df3MwGIXW4xHhAGIu3GRWt3S1KZITzC19XirVBKrs9LfiFoSMPsTP4QyxVch6Vb6O5E4VAWL1Egw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLOKfSc2pRPfRnRsyrPyM7bKzgTDNl8isweEX09EIWg=;
 b=MYm90TTq5OXIc2PBbj7GxQaYLfqlJ6uHZHiNX0xSRoZNaXXlutwi1/9oq6u2zRS1Y/zu7hsISNO4t+xex/ud8SjfWkfjl323LKaDk3726BZbsCmLa6NFBuVP4oFWJqLtlrXHloEOU9SD7honZXWimmccQVNi/DnlYOr1sarnC22CDHcNkWpmNiuPrf66VR89DuIOU5vwqaNu11htrqViDZ7lUseXAgdSsByzMyTEr+2VZyAy0edo57QzuFg5hgpJyuAoJwE/TpthwchILnibXhlrfB6lWVi8cGRtHEFzNPA7ADhb+jC/ry/la7M6Y+jsTk7k26LgXUvUdhXV6codLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLOKfSc2pRPfRnRsyrPyM7bKzgTDNl8isweEX09EIWg=;
 b=AkKxIqUW7mbDfFSq1fHWuZf4laVoBb+dnFyDOOHOPdVOz5umO237CshFUFiDUCgHqo8JF0PKiLtaJKEPYr0BZ55qsU/Y2pU118CJehcFg7lEAvgLEG5Ww04sMqfuq3tC+TZjtokSuuScpnD+jzA82pw/bg3UJM0Y8HkyKPTcqFyXZxZh5lDTiVK3eb3ZVaSE1lc7Vthy8UJUjmzVt6DrLtMI8G+OsfKnwn0/Fh0icZiddY47+jBciQV70BAZFoPqhH+UFY0f7yeKBYKuHLgh4dpIOBGxzjidJxI4K3mmMMpS7E33DWjc+jkj8FoFn8gM9p1Ff4pmGJFhC6+UIDdSPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by CH2PR12MB4263.namprd12.prod.outlook.com (2603:10b6:610:a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Sun, 3 Nov
 2024 14:24:32 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3a32:fdf9:cf10:e695]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3a32:fdf9:cf10:e695%4]) with mapi id 15.20.8093.027; Sun, 3 Nov 2024
 14:24:32 +0000
Date: Sun, 3 Nov 2024 16:24:15 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>
Subject: Re: [PATCH ipsec-next v2 2/4] xfrm: Convert xfrm_bundle_create() to
 dscp_t.
Message-ID: <ZyeHj2M9-MjekZIa@shredder>
References: <cover.1730387416.git.gnault@redhat.com>
 <4d3f3d32274bb4a652bd718f50f489aceb0c0405.1730387416.git.gnault@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d3f3d32274bb4a652bd718f50f489aceb0c0405.1730387416.git.gnault@redhat.com>
X-ClientProxiedBy: LO2P265CA0442.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::22) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|CH2PR12MB4263:EE_
X-MS-Office365-Filtering-Correlation-Id: ddfcc6e4-67fb-4a47-0b60-08dcfc133c45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KF88G2wOtXjBQS0b7t2U0UJ3PKlyIQ4XpUYOjkzgCfd9Zr9x+IQ0WRaSVtFo?=
 =?us-ascii?Q?8RGHzQJyG65J1Do+1eHatYuGholw1WIRxWyrgtfaCWtPXXXhbegAb9+G7LJI?=
 =?us-ascii?Q?RY17WqEe/1XleqdTe6PTzCvNAeh29oTITIqbNktmI7NmW7ZxAbWwqkEtei28?=
 =?us-ascii?Q?z1wvUgQi5LUJZXzIg1qCXiBTUq4Pbv5FSSmX7ClK7X0TUrUaBG6COOdU+g7M?=
 =?us-ascii?Q?pHsACoyQ9TYIoaMD18UwDUiDW/ab2bCF8SMBZTO72zIYSsm2oYwwTYUbnBmr?=
 =?us-ascii?Q?ORlkjTsSj5G/na9OJKumZP60wIlngjT8rgzR3XXnXEi5ithvVuDoI3TDbwD8?=
 =?us-ascii?Q?chkchPEF8ApuezdDKScmmjxsqwWk86mjTFMtG4XqRRwtgcmuleL9xVZmNiSr?=
 =?us-ascii?Q?A3wHjzMlcuQ8eeVg6iZlg20bQ13LBHjmDixK2KzPLrkscHH+L0iQ2yOTJoJK?=
 =?us-ascii?Q?ZtQnJ5uFfRdTyOZHbHpj44YhJxEwCv3RImIwru3ikndNWOJ2rTkQb5xBgoJn?=
 =?us-ascii?Q?gkJ7TyW5I1Up9/EudrsIgOvjiXvZIUwoiKyezZNxwK96EAONi8E3/SqUtLux?=
 =?us-ascii?Q?UNKDCp5hYkNCggJ6utkgiUZvfr5cdSOL2Lx/CkU0x0E0AfIvKdw7E77aX4P4?=
 =?us-ascii?Q?d/DxEf0f8U3bJLhdYLvfyR5aFc4vb0MxktF8h5vO94GNItg/tuTBpMPbsJ4n?=
 =?us-ascii?Q?8h/lo51pf3ygjWCS4ywuAvGACBKvhqmA8EdUorThEsl+aVELIKXvuhrPVjrw?=
 =?us-ascii?Q?nzKLVAs9ARFa5lIUimxkK3B/BuZZpJMjpXF2gdd6yV6CXLlPmAuIBMuZx5Bq?=
 =?us-ascii?Q?bg+zQyrU52O7DpxuDIHM5cwl6mkro91+fuDBPhr4agzC4lYJ6e3pVQEvURox?=
 =?us-ascii?Q?jiPNJtdTFF1GWhb9mNmwhms5PeRoe02AXi2Kc3RsQJnND4xZEwQm22Tpp2XQ?=
 =?us-ascii?Q?7z0AQJi9qLdLNPgDURYB94vL32Cwe2/Ut2bTxuNiwqvPtP46Zbc/+9k/bA1n?=
 =?us-ascii?Q?/fNDtcE/h10blEqQprPPzQhFBfasS6klTdWjxr0sHyILN3UAKeiNbo2Ymbcl?=
 =?us-ascii?Q?xm3KNsAZGCvEun358BbluoYfyiOjt2o7wH7cgsC4v6ObTftv0qc9LtSVvrXF?=
 =?us-ascii?Q?CrgyvwFYir1cl+z7qWUNOC3sP8teeylGE4wNeQTB6Ig8s9T+yjkRoMuAAVFP?=
 =?us-ascii?Q?DfsGE5yv0iSmtn2xv3ltnkrMPC+GAw+N3VWpAuUwG5Be5tQSH6HOUr4Mu/8x?=
 =?us-ascii?Q?o2CJMoFIAN4/xuHw8hxtsR0OFkscd8cIb7KdozpJYGesHZf2yRFt+WXRmdHL?=
 =?us-ascii?Q?pP0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AUL5PmvPkdZunjIG1P8Db0dvekzLHQiakUFskTSO8PgFcsavRPCK5W7A48Nk?=
 =?us-ascii?Q?9/8oPg2Ex0aaxm3J1mLDkKar3rPg0Yl9EjDP6QZLDfmTtYeN3lxP9goWBX7q?=
 =?us-ascii?Q?AmKQ3uisru58o3RR9FQguCfgIuYRaD4Y4w/h0scEOEecxxHZpSFFBjvTURHn?=
 =?us-ascii?Q?Ii+aswR3W3Ya6WO1vSMh+OVYSIynOUFvwtTXNAyOo5AvVI6KCel+c3ZNOOaI?=
 =?us-ascii?Q?Y3MTFC3QauwClaMBQLay/FHBPH7XnVkETRJDEht9VWQP28hVE7iGBOR5qDCR?=
 =?us-ascii?Q?0KSTG9L78Xts1oQbxpQ1hgloPFOP8rz1jGOJT+k/CeHS43k0XGFDGsb0uyOv?=
 =?us-ascii?Q?nfES0toJnKZwSmOjxF/1PpUK8dXoBkh6AHrPwFcinzWrOIpki7PnvYBL6W7T?=
 =?us-ascii?Q?YEiC0ka2zpKIlvOrCAwR2VNmF4D7zo2pO+LkTLRZLqeljU3Lyoh8UCUvNJQM?=
 =?us-ascii?Q?amQYInlK2pAjT0ZNoGaN2O041aF8tqn72CpOPvZeFnPlBre5yZi99p0cOcOu?=
 =?us-ascii?Q?kn8Wf5nKUYxPHtb866m8jva8Blef8QimoMAybhH44//9N73jnvnF0QZpWnt/?=
 =?us-ascii?Q?diKYPpLlbx9pkd+HY4cMeqhPxQiqQs1u/3S99rJRybCSm5yq5a0NnmfcjwMP?=
 =?us-ascii?Q?nc8CSjswbQ+CVFjsIxMiu2khaxuJtPjfn4eoRRPwF+COvTmn+1vqoSDjPajx?=
 =?us-ascii?Q?T5lOVVDVSNljIZOlm/Th56o5t2cjk1kMu8amr6RcgR9BIaWUdoxL5k5+/pkS?=
 =?us-ascii?Q?aobYRLZW6po3axQiuL3Z4sEvzXej1H/M2hZCgu6uXJnRayEJPtpdr9JMHHoe?=
 =?us-ascii?Q?uNrYDlxJiRo+zJcdQz3ft9/cr5/LGxgiLeRnvKirzH8SjJgrhAqIuHiHVV2o?=
 =?us-ascii?Q?9Tkg4Pla9NIh9TWpISpa5ktT8Wo1XDDV0U5sYw4yqdmcgDrRUkZFyrhfiCMo?=
 =?us-ascii?Q?Q6+zhIzV/vzhSMV+qX7TEAoMSLkl26WJziLvFJDErgHApnhvM3BeCWmLWsr9?=
 =?us-ascii?Q?G7erlCo/L+7iowm+/ScCrTST/gxZPincmif3ooCEBR0v5BLXSmz8nUv1d73N?=
 =?us-ascii?Q?q542F2rUhXplP0+ME2F6eACAYms+RSvh858Szlj9Dbyc3IplarMCiNsmyQd4?=
 =?us-ascii?Q?XBvbjLjIkSCSIpsi33fRPol2AI5/EOHqRju6mFTjNyKmnyzRQItJLd4jscWL?=
 =?us-ascii?Q?ndZEhJsdux6WioQljMg4axeH5xUzdDVpYcnw1UCYtU3nC+gqqHcbu02MMUeo?=
 =?us-ascii?Q?1GnTNQ21SwA1K8q4A+uUc514rXGA/slCOuyncYhHFoc4/5ZoYDeOda0IYzoS?=
 =?us-ascii?Q?OvQUYfnGwuIu+cWJdialxphJABTEfhuppimDBCoRVuUE6nPa30UpnZgs1XIA?=
 =?us-ascii?Q?eN0mDlv8ygNaMhfwtxKKz1HgfFP6eJNxLQ5hFJpMoUxOkQ+IE3Lg9JDNRIdo?=
 =?us-ascii?Q?sQ1OEH05y3yA5foFE/MSXZDp5D9XM6qOoiBtkUQDpwpu3POfOIkq7i2VYSWR?=
 =?us-ascii?Q?wJFydksey2b1u/RlX4yoNJgN/4LW8LYD0bNlZSLG7ycEfG5buFENtHin8Uxo?=
 =?us-ascii?Q?Ca0fGsKoHV7RUxxNKeetTx6wh5v79g2gNUpI536/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddfcc6e4-67fb-4a47-0b60-08dcfc133c45
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2024 14:24:32.7185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4rZQcuQWzzQIZuUX8YUu+IQ9N1VM4tQpvMJ5Mr8tekQ6upber3/tpsXJSRsv1AnUOIwX+DAcS0N9Je7NtWO7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4263

On Thu, Oct 31, 2024 at 04:52:43PM +0100, Guillaume Nault wrote:
> Use a dscp_t variable to store the result of xfrm_get_dscp().
> This prepares for the future conversion of xfrm_dst_lookup().
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

