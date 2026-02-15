Return-Path: <netdev+bounces-258766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /sRyEwGWkWmLkAEAu9opvQ
	(envelope-from <netdev+bounces-258766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 10:46:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A4213E69D
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 10:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E194E300DF44
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 09:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9A924E4C6;
	Sun, 15 Feb 2026 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oOnSSWqc"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012047.outbound.protection.outlook.com [40.107.200.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C83D1FE45A;
	Sun, 15 Feb 2026 09:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771148798; cv=fail; b=J/I/Desm55UbDgH29xRZdWTc44yAaYi+AAr5VBoykRKNzgM+BTNYDOdEpg7+jpWP7j4VXHtaT9gtGqzRBiJXQewi/IElA2UMAeUci03N5lyvlGyXZJLGv9sAOPuJEvem42P+9pBCXK1L7UYEdPmhoAsQVlK++Q8/yf5MHlt+Y8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771148798; c=relaxed/simple;
	bh=ig9bPp7hjjoV0LUbEdT7NyggMFS/Ud3Jfn0/cuSreXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rcnDKuETR2akHc4UL9rj0HO1iWS211lg9dW2vTJLVC/OgZFjbAEe48qO1Jel55bJ8JKUeTWpXkEQuMiMyGbw7rBfrMUVD3SkHFr7i4Vbm+/9/+VldGC7fSig+4AYakBahm5GUcsklVSYFV9qBpPuaHAmnTTugfk5zlUz1RRsIT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oOnSSWqc; arc=fail smtp.client-ip=40.107.200.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=klh8GTiTShIZ+AncgESmh+/qVb8dxxNN46ArU3nIdJsnw7oHrjP81TOea7nFajQajVIXi568QhpZTrgxAct9sJZ5gGVsJZAaU7Hryot5wQ9CcI0XoFTDegWWz6d7DrlyfRLuVYoa951v6FT7JLZMfUDCcrhxzo1Sle5qlqCE2JvSLwWxZxf9DlF1fQSb8TQTo/BczdxslBhDGmI+b5gQuQdwPOQlEyKbOLqmryWq8qXLNMk7qsRbBXTD/J+cu78P+rIBQJFoBFPSQN7giXu400PQvMYA4P2tdxDEMpdXVa/nRaU3Elo9zsOuVfuy6AokHjEgDG1cw6k4uY9yZjbsMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nx15KdRDe0pa7qr4Tw7UHnBmUu+TKyrO9ZojBi3JI68=;
 b=uVMmeTiuRyoY4swztM41rh3LCZLU+59GMUbejrBN19rpmJyUSLhjU6WBG7diRck1caMWm39HbiseEXas/Bfa0tQhaqPf6DqJYtaxWnKV+Iw5BSuahNkD9o1Ulfnnq4OdsbI+pzCvrwypb2iHMJLDVacwuwW507LUGXuHicLyBiMeCkjphqLT37THU9oRwj9Jk+kyuJQMxQX+ObE3Xc6V0NALEs7sM6hC+RJxwePOizMuge2PAi7rpIm87Bi1ZSVa8MWQaoIl56NbOG2wyqRKBWBt36v8tZY9CzsHEH1fUC1QRtYWHxUbrt47QnQSYIXDOgMZYq5bdt46R5HlOgBDIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nx15KdRDe0pa7qr4Tw7UHnBmUu+TKyrO9ZojBi3JI68=;
 b=oOnSSWqc1Yys71iV6dnmwI3WIrwJqcU32JaisKujeAxRJMllsF9aO/QVwBtS1WxvERAyt+xsTJaKb/t01VbhAlqNtiD+PA88tEx+LTmmj5wzRa8YsQPPiTJjWKwhLf1eG9YhMndycz9nxLsi1mm8r8iJydSsJ0OXe58EKwhyYirv1D5f/BpLHuycsFcM15VWMyfPcT3sMYCI+PQHLTKxi7joR/v/N7q+bdynRxXvilGIh4tP/qKfCwoAV+psSCadLhy4wwcW+NlQmBTa6R5MtNQ4+6Pu8Sd6wunCT3xB+bCddaJznbMcgPMGPFvQ+2oVQSWnYqDT5nndvrt8WA3mrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Sun, 15 Feb
 2026 09:46:33 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 09:46:33 +0000
Date: Sun, 15 Feb 2026 11:45:20 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/3] selftests: forwarding: fix pedit tests
 failure with br_netfilter enabled
Message-ID: <20260215094520.GC114305@shredder>
References: <20260213131907.43351-1-aleksey.oladko@virtuozzo.com>
 <20260213131907.43351-4-aleksey.oladko@virtuozzo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213131907.43351-4-aleksey.oladko@virtuozzo.com>
X-ClientProxiedBy: FR0P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::16) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: 56fbe85a-b75d-4439-d295-08de6c771a68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qZB8Wq6TiOaR4ZK4k8Knf779/DxsDbAN9cFUojl/w4efxTz+RsS6TK2sBd4n?=
 =?us-ascii?Q?d5uYAjITOD5Rq+JPOvCBL2i7sXsdNnDmerZfDN9NTCitmVXXNbgaS/EEKLv9?=
 =?us-ascii?Q?4uVFp+kvz0EDCm680XEY7gN1RfkFjPV5h9a2YBRH/7h5HkZHjOuGOhxM+o5x?=
 =?us-ascii?Q?ISlDhW33sO4z+5kOjzG63VmZc9EhyLZnbH0TN5PcU0vv5THC+XE5uAREafoj?=
 =?us-ascii?Q?fbsZ17GoqwTnd4d6Xi295ZXfMNts8+F6aOIKEUk2zzHC8wtUJovzrJx+PHzb?=
 =?us-ascii?Q?IQYZI7MzJYnI1i88XW0hxsUgmHZXCIY2N9PaJrSKNVi7GjdJCBVjwyGycW5l?=
 =?us-ascii?Q?QncHYq8nn0MjkNuwVsO2dL2dZfiBu7rDEZpiver5H/8GCJqaWi8Nx5SFli/B?=
 =?us-ascii?Q?AIEDBqV0Pqt7mX0jeCSpZp8IaBrHj/+D1ZdUbynPL9NHOtVu6Z+zsIWqeq+s?=
 =?us-ascii?Q?ileJabbxGt5r1xfblFTrfKoCGCJWpbiTSgLLZREIBvEvFywZ4ePt8yPLUooU?=
 =?us-ascii?Q?pPgjd6RNWJGW2hSBMhHMLX/fWgm6L4CBDLid8Zm3v9eGb1oorWxXWV7b60xc?=
 =?us-ascii?Q?rReIWdS1a1gqvOghzzdIOgtY7dEwIWrUfqj3V1/f9ty0/5+TknqOyswKCKdM?=
 =?us-ascii?Q?WtQyWUKjMNCS2aEzbDWHoja8EAZf1JJPG5kwUbVkXtQNNKAaoyt8yW46Vzae?=
 =?us-ascii?Q?sqqwFeEXZMywLugyGWx8QvxtyiLkUJs+iEqN3PWoYrGnqw+uYNPJOdHgCe5n?=
 =?us-ascii?Q?FRSB08PtsePXAnm24zkIM9Re7PkaIPpudKaGoUPrd5UCv4Z4ioc4tWtt8ude?=
 =?us-ascii?Q?9VwkO0eGXyjMWjCPd3gIKqZTySnzItGlX4f/woezE/4M0G0EuL3mhOksWT2t?=
 =?us-ascii?Q?pVfEOmPk9hHSjbR1X40su39xj2pTA6DI7OPLbxIygQc+BHlbvwSbrQ/UkO7c?=
 =?us-ascii?Q?CER5M6aixI+av9rhPMpy64xylwSTPiTugByvSWoT70AXWeO5SnmExZaeWQMA?=
 =?us-ascii?Q?JzyLk9YSLWQ5S4bcLhyUnqL4doGGczO7rQtLwQqW20yYCLvDLY50YX3BQ6NB?=
 =?us-ascii?Q?aFCSYU+mqHDLKcV9faGnTZhn0LdeVvwbwwfn5EzYJmhdvkLkcOmn0Y3BZ3ob?=
 =?us-ascii?Q?I0Hpy9zlS/lpyUHAjWP2iB/WDSoiX+qYZTD5aWCSvQyIpYh0bMxPNEPbfGx7?=
 =?us-ascii?Q?EmLjIPNIGGiTwZG2Snxvslrx4izchaCusn2uR+9Xm+b+6PyqJbrQL0IWKuMI?=
 =?us-ascii?Q?lHCCzYcOliKMrIPDM41XPGiPL8LWMyteqAGb+R2BLf53I+pYACtmqtjnJEki?=
 =?us-ascii?Q?k3eimsyH0DNNcnqJfSIDbaBUGSwhv8bvjgbmP425hcszdmCZEO1VaJSBxgHh?=
 =?us-ascii?Q?5FDonkgwQ/kMNPwOPuQjUhTM+UdxUZFlK5oLtgDbIToemKQAIKiefPgZY+vK?=
 =?us-ascii?Q?9VjEv1UZlbudVEjz8LIb/msN/OWrPadGqixWsT3vOPFDP2gHsm+qiEd0VxGk?=
 =?us-ascii?Q?c6erDb884/mwt8j4Qd91zgL/ErvzhNB/YIkBjxw2Dc7XagO+7nh4fV3Hz14I?=
 =?us-ascii?Q?yzTeJ+m6sgVHBevfNs0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LiJStBZfU1gaHdo4GNfhKdKdEID8cVu1iSgiw8UbnFsAuWXutPKND266sX3E?=
 =?us-ascii?Q?IG57pHFTJiRZWt2HXSKNHLn1T6uJApYnH+ELz7hvV3VwM+8Hy2STrbIj+Etw?=
 =?us-ascii?Q?iItmX3sG74qcuBSrDKCdSY8ZC7hg27N8Jtp3uq81XTbOZMpPz7jWI3i59dSM?=
 =?us-ascii?Q?O6xjTKt3RRWstVZiSW9I128ohYd04ucrz8g0AgqqRnKcgjXHU4tuvf0A1XpI?=
 =?us-ascii?Q?k838MQyt4v6hZxR+he4x4m3exgFw3LPZG/qw9CO0/mUXPxcUBTQ9eGaVSLbu?=
 =?us-ascii?Q?9KvWrMLZRI9VGewrCqsjwdSCwFyvL80DrH0aNTX3YtyXTnWfVDVvq+WRBKpj?=
 =?us-ascii?Q?wQm+o7gNInmPUheuag21rc+LeVZfT8ndYqxCF2OWCq9DyQ/o9T2G3gFQcRk9?=
 =?us-ascii?Q?K8lvVS5TeU0DNJYAQmtxpYVub+KomTaD1+gbcXBQFJMTjAz4ilrNn0DcOtu2?=
 =?us-ascii?Q?nNeis+J+jb2mrwNXGCOBeqDa4vEdh2cjlJkKCr0qVGUWvUOiSA8Mfpu//6K7?=
 =?us-ascii?Q?Exhnj5FB4MwcxHjha2xkmxTiq0ZhcxVFxMayOMM/oPebjCMqStYu48tFUibx?=
 =?us-ascii?Q?rI8iCXMnGXzSmZ9QElbOCOIO397Qlv8lMuN/1q1Y/oG5vSCiW3N1RpvVZKTU?=
 =?us-ascii?Q?NjbIl5aQwzOLHCZQFTiq6udXVFnX0E56nILzubq/ZlYSjJq74MO64hsQ2P50?=
 =?us-ascii?Q?hQoj1jpA9AqbRHpID18cX+lLKezGSuNSDLF2EeRI+4lzuZ/Gm56z8oez+mRo?=
 =?us-ascii?Q?8d3dMYYeu0RBRLXb9kE0DYagvC2zWUA4TvyknyRRIfUL3hYAgJmz15eOl87b?=
 =?us-ascii?Q?BSBZi4adocI5Z9dlac5xEk7s2bGUiyd2OYL31nn34HrodCQPB4htx9D3cHG8?=
 =?us-ascii?Q?siCwiRlSECcKSgTx8uXsxz8CsizcwaCHsKtZl8KPCrTpyXwsUQkPQU9gG16T?=
 =?us-ascii?Q?cisL4SkHTD5kwlM36EWFrq0LczEzDZcIq5uTo/nooYwd1KXCjN4GZIaqK0is?=
 =?us-ascii?Q?dij1j4gSlYh1oOEBAStM2s81RIcl2mioGZJ9dmscMtzhn0oWPeyD86jRhRCN?=
 =?us-ascii?Q?G8YvQ73ToFo+8uPsDBJkxrI4OT4cfmNlOqx+gspgeVb7udmne/P5b4dyKGnq?=
 =?us-ascii?Q?zO8rbEfEKjEVlD7a5u8EnqOaoq8V/BYtRxS0iKRP+Vjdy2YRSYkPMLDaOKGU?=
 =?us-ascii?Q?XTq72G1MBAUaCCr7WrqYSo4oBuKayGAWW22Zg6m5UzVHltqCdIyVG78kjYeL?=
 =?us-ascii?Q?HBK7M2RszG96OBHPDg9nGqXPtDP3ce29zETRS2nMDCf7m33CO+omdop6gCJw?=
 =?us-ascii?Q?d9GGZVW2UtI+tCfmdqxlx3trnWv0aEhnMVTTBkxMe2XmI7qFlsnfLHSCjMqq?=
 =?us-ascii?Q?OMETGLNVq297SBv1u5zuS1UkoGS181i4hjNzwWsoG+QIriHC9ft5eoei6b6X?=
 =?us-ascii?Q?ed+OgdmMF7vHTPndi0/a7qYKZUXfvkdbLkluu3FlT/cNkuj3Hge1p0rS6E3N?=
 =?us-ascii?Q?QtGcVjaiI74JQf1w+65Nk4P62yQfC9oriD3oI6OqjSQ6d2MzxYe6Vx6bvokc?=
 =?us-ascii?Q?ow5mWb+FfAfufvKGF6LwkfFGz4fBQrkffEEF5A+XSzBZDC/spgQVOpbaYaqO?=
 =?us-ascii?Q?lz47/D1wBzHQF1F1S6mXBtW5otJzC+1CPsepcJtNgEzy7W2sdhwtjIR5xS09?=
 =?us-ascii?Q?YxcyuoCXFlqVsC9uyfv3qRavl7/N2Zs+rC7GzGMyqdIzfmXq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56fbe85a-b75d-4439-d295-08de6c771a68
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 09:46:33.7773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: So1LvuAxxlM0rGZq+7A1T23AVjpN8baKmlcEDk21mRUnSElYzPDr+B2iq9SeeD5LuVEsSmmVWwO9Htd3p9aASw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258766-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95A4213E69D
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 01:19:07PM +0000, Aleksei Oladko wrote:
> The tests use the tc pedit action to modify the IPv4 source address
> ("pedit ex munge ip src set"), but the IP header checksum is not
> recalculated after the modification. As a result, the modified packet
> fails sanity checks in br_netfilter after bridging and is dropped,
> which causes the test to fail.
> 
> Fix this by ensuring net.bridge.bridge-nf-call-iptables is set to 0
> during the test execution. This prevents the bridge from passing
> L2 traffic to netfilter, bypasing the checksum validation that

s/bypasing/bypassing/

> causes the test failure.
> 
> Fixes: 92ad3828944e ("selftests: forwarding: Add a test for pedit munge SIP and DIP")
> Fixes: 226657ba2389 ("selftests: forwarding: Add a forwarding test for pedit munge dsfield")
> Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

