Return-Path: <netdev+bounces-263373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFu7KwAvp2mbfgAAu9opvQ
	(envelope-from <netdev+bounces-263373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:57:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7C11F58A0
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 833C230F9E54
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 18:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BFC37F00D;
	Tue,  3 Mar 2026 18:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QjNRA/mR"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011034.outbound.protection.outlook.com [52.101.57.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0713EB81C;
	Tue,  3 Mar 2026 18:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772564125; cv=fail; b=JLLH0CXhltH0RKBueCVoT24JLhYqFR3/mP6EOPCMSdy7uj1Z2KPdspguP9EloXEU8uucPDjv4CG448lc6cyYJoTQhKWiZl+0pAXm8cOswFJjPBs2ZT1ysrujtFoFjSd4ovlB3qlbMiaGbzA6VlH0M7NYKPGtLN7LQ2e01lGubxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772564125; c=relaxed/simple;
	bh=4PcVOaAds1NrJ679ZSPnoamAYPFF7isyZiPr91EffDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vh5n2T0aorTEntgagufc4gEK35157YBEgPDRJYO1B9hvP99MWx8iCNVuraFlVqRrsqELlmdyKqZqw5NMPM/w2dnh7GvvMogTt//vPX0FGZ5OoVW19zrirM790QdXCNWr442uqBSLJd0iCi3zpClzKewo5hflTSeLE6VGIkiYSPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QjNRA/mR; arc=fail smtp.client-ip=52.101.57.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3GNti7V3EckT1arL9LOTW1y/A2ZGJa3L7UXU11vXoqbAhNj0FmDuKR4LTMKUiyspf+62wVVzulWCJPLWSqSthVaSClemPmwm6pavKX66C4EJyqCCML1pkFanSeDcTMHm3KIkwQWUF0vUtwIj4AtGvymCiBExcnub4rijje6X6DJ+U+WJDUDTCIUxfQxII6HjM1R/WZlpqMM5bjVr0tjej1KZ7JBg98PwDITObE1zqCJY5zx9yCKwTWOJedJ9JSRhNw1p1NTHiN+LQVmKzfbY7iSfAmRLU7HoiSC+aiXoquX6fcOJPsR/2I6BY8vsCg7Cc7bwyhOp8Ie38Rc3bi45w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8fXnsjwygAlMbJcQyaUss7mtWAEeZs/AWWUGXSaezY=;
 b=d3UY6IWlgVvatX0w0YUjej3HVD48Zj8gIGA3569hIiobi/CG2EVDDygChod1ObACEEIXHKMO1NBvgCAyFxPMqHciIKzXioFJ4xYToSe7NKIrhFI/WpUfQT7L/e6vFmLIsSl/el7Ys0rE+CYVwVnCCq8tnOfBEEMu+fzOorJvTELZ8yqrmi9avNL+hNv5wpVJBFn2DKEqFBI7jwYhTBCdcpW/tLowDEJsfnHytcpNlr3L+qBeWEWqpjZmZVnDwJqMwdU4E02dosNOGML/2mrG+YkzASl0AD2AXGsW0rtaW+aHE1UUqGuI9JbkXtdNTdHEpgSzXtHFd1h//mmFzi2I6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8fXnsjwygAlMbJcQyaUss7mtWAEeZs/AWWUGXSaezY=;
 b=QjNRA/mRHcc7CZM+/3gyfCjnFoShEP6fnuSwaeSXaVB6P1j45m3siXQzj2ObBlkcCDoCt2jtmkLqFF8uY2z/MU6qdTwcaFh5ydvcg/19e5LKb4pK/xNXLCUnlF+P6RbkNMLPMKUkuBXUrUXp2CQ8f7C6w49KADqU2KXpVauaemmB2Eqe+oa316MabQoRbnFexaaMHi4VZ8YnCMorCeaEWCsYxyPbfNQVyqZYOAwL0Cp3rQH+Hks5496RfTZu8nwLkrcGwTL6SQ06akqu9XqY5ZPP1JVlggjk3sq8ix4/GiEw+g4C1FyPe5FhD89YErptvIAHpQ7ID2r9gQWuTcay2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by SN7PR12MB8026.namprd12.prod.outlook.com (2603:10b6:806:34b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 18:55:15 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 18:55:15 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Yajun Deng <yajun.deng@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 2/2] net-sysfs: switch xps_queue_show() to sysfs_emit()
Date: Tue,  3 Mar 2026 13:55:06 -0500
Message-ID: <20260303185507.111841-3-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303185507.111841-1-ynorov@nvidia.com>
References: <20260303185507.111841-1-ynorov@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0695.namprd03.prod.outlook.com
 (2603:10b6:408:ef::10) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|SN7PR12MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c05024-280e-4c29-5dd6-08de795667e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	4DZHgSGJhxfLoj2HSPQ2GjOx4tVNov6G5kIxq9GRQBdvCoF+eKq72W0Zf6FQ6wdo1cu3LQOgfaDp7ZtIrPsn+PbnPyFDtBUM4fNMS7yqv7JSEjS35GV9lyKXr0ktIXBujUBr4sr0MA0/2mSuxS0Le2oH+GlCYwHDRIAEFG3tlARU1JQYSTxpftTyiPIXi7FWC9tcTuDti29PJWqz0hy0OlLHw1dy0fAJltrga6By9Xm3Mw3xnlQiS8auS0Nx8/d/b93qYwqatPw70PYVI4NfKiVLzUXiBmCznuq5A+EDVUT8SLgNm2+k+8mFK6cM/ziKf7eTMp6ahmY5bpf2iYTEhTE7CZ73kOiapHbGISvvQFJXqInkEto+bBAxdqrkn1Ui835twNX6Pj7jcvrWxd/SUAbh85XOtWanZrk8UMq/uSLSyA3GJCKacj6ScfvYUVYiwXGYF5fOXp9Ss8OyuMstn+2hw9pe9Et87Z4jXZd3+5YYvXBpBH3KewKeFPVZ5Hdux6ZAIqI/aWQRS8W8Kff6+0BVoRTnW1r1pmzyj+g8DhpztR8DudRdFMGBhR9N8kZ99fLbQE9GhTkuj0GsoFL/lJvB6YFA1cF0JcbB1jlwWIQM4V+RbQLJwcnhLnCYusqxVt3mKJoAJDOMaCvTNPT6SqsOLTMkLZT+oZ3EXPlNFNW2L3VXjzPav7ueOhHR7D7+Of92K1p5lONGI/rfd1fpDLAnTDKs9gw7cRMlHJQB1coWGcxwXEFwqUBV1wvZOzDVphgvIm6U11N/U7XiVaXmsQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVRTR25sNmdaVFRTZ0pkMmtyZHR2R21iUGtGQWFRS1BXdkRBa05NMG9nLzR3?=
 =?utf-8?B?U2s2U2V6SWdsODd0MzFSYTZ4bzc1VTlwbElLbHp0Sm94ZW1EUXZDaUE2S0NI?=
 =?utf-8?B?K1ExbDlSR1A4UVZBYUtweW1ON2VLcnp0Zk9NdmhtS0RISXFSYlNJbDltR0ta?=
 =?utf-8?B?UXFvbFlCYUM2UUwxNnpCVTRSS1U2Y2p1UldNNjZ2eHpnSVgyWUVYZGw2akFW?=
 =?utf-8?B?UFpNMi9lY3hDSytyeHp4RVpRSFJ1SUkvdjNXcEFkT01wQWlTMjBYZG10ai9v?=
 =?utf-8?B?RGxESEFPMENtSkNsWENtRnNqSkdaTGRJeW82am5lQm40cWNyQWQ2dklud3Ns?=
 =?utf-8?B?YmNzN201MzFSZmh6Nm0waElxNmJzZkZlZ2l1TXM4c3JTMVRYYXBjaTBNaDI0?=
 =?utf-8?B?Z1FCdW9YdmsyNVpxaGN1SE9nYmduQTVUcUZOcTh1UDFPTm1aZXM1K09QL08y?=
 =?utf-8?B?cHQvRHRKbEdHTmtEc0RhYzF2YWhIdWNCMlVKZ3BReVYySzFUaUZSTlg1anJX?=
 =?utf-8?B?eEtFcjE1cGIyUThiRUIrSHhOd0VtaHJvY0ZCOUVCbnYwY0ZhK3ZiUTA4M0NK?=
 =?utf-8?B?TkpiWUlldEhkVTZHRk42cTIxeUtnUUtTazhGN1dNUWxrTElMVmEvMkR0QzZB?=
 =?utf-8?B?Ni9lMWhUVXBodTcwdkdqZE5vRG1GVW8zZDQwTElMalFEU1AwQm83TXFKem1D?=
 =?utf-8?B?MFRkQTgxRGErU3hxakd5aGxXWVZtMEF1SXFSeXd0VlpacENzYzVrMk1Zc2xE?=
 =?utf-8?B?cloyQjhIK0tYaURHT1pTNyt4Y1RoZVluY25lZHpvSmpVaE9XVWY5SDFPN25l?=
 =?utf-8?B?WkZ1V09xajBpTzdHTmRjZnZLdnE3b2gwcjlPZnE2d3hCODVUQ2dQOTBTU3E5?=
 =?utf-8?B?NkwydzFUT0tGdmlub0lsN3luaVplSmoxZVZhcnJHTVFtcHl1cTVGdi8rQVVI?=
 =?utf-8?B?K2VBeGJFaHNkTDcvNVN4citPU1JuVm1HTTYvOWVOQisyV0RVanhIeW1CZ29N?=
 =?utf-8?B?TnRock9jbTM2VnU4WmdMdWZ0TlVGTXAvdDczenNLNVA5VzZ5ZVd1MlNNdjVT?=
 =?utf-8?B?NFdsRkVHMFdyZDFSRzZuNzdYVyt4eTFZMFBRR1Z5VWpaQUdGVHkxTWZDTUVI?=
 =?utf-8?B?TzZPcUo5c1ZITkYzR2dSN1FNMGtQTG5NMmdGeDNiVU1Mdi9uME9PcnIxek1Z?=
 =?utf-8?B?YTdRTzJrdFFzcUdJc25WVWNPSEpHZm1JTFpobDZuV2l0WDhMNC9iZHpRTnVC?=
 =?utf-8?B?ZDVDUGNlVnpGc083bkF1bi9xTmMwRGZGcHJ3bjJmZmxXMk5lWkFnM2ZBL2Jk?=
 =?utf-8?B?bzZVaGxsbFZ5Q0RmUmtIc2JjdzhoeWh5VjJGQVFTY3VBTkJJaGdrQVo1Unor?=
 =?utf-8?B?QWE1M1g1dVRmVnNpaWt0WTJKUUpPbDBibXdsdCszUTkyYlFHQ3BTQ3NHcmEv?=
 =?utf-8?B?NzRzdmJ2VlJPN09WNDVUWmZzN0x0UHdwdlRwWnZVb0lNdkVyVVBtSHl1RTJJ?=
 =?utf-8?B?aUxVZVI2U0xacHNOSlZ6c0U5RFR6MngzZ2dXdGlYY2lSMnRXK24xeE9UZ3Iv?=
 =?utf-8?B?Mkt1ZGpDRmJtNGx1L1M5Zm1XWThSek5lMEo1YVZqa1RJbVV0cDBya2YxWlVu?=
 =?utf-8?B?SC9KU2Vxa2lyQUxZMkRtU3dDNjA4dmN2MU5IMGZuS1hLN0N0UWVZV3B6K1hF?=
 =?utf-8?B?QUdvdWxTcEVmVGZkZUYzOXc3cUN4VmMveFBDd2dJYU5Ra2tlSU0xNStib3N5?=
 =?utf-8?B?OXR4SnVOdHFGbVZLb0FVNDQ0UnQ4cmJodGpRRkI0Mk9JcTdGM0REWUhra0RM?=
 =?utf-8?B?bjl6Wkl3NCtrWVhSY3FOekZ4YW8vQVJieFFCZ3JUeVNUUE9HY3dBbVhkeUw4?=
 =?utf-8?B?RlBMUmphSzhuVndsMmZSaVc0ekZXekNZNVo5WGhwdFYzdDQwcUp2dU9pRy9O?=
 =?utf-8?B?c1FrVGFmWUxLTENWV25pYXRYSTliWk5NUk9Hdy9QWGNqRlBKT2ttNkdqN3pB?=
 =?utf-8?B?bFJvZXowd2tjVWtiWEszL1hNc3pQSnFJL1RlNWhxd2kyRnZDVE9pMW8zUVZV?=
 =?utf-8?B?VSs4R0JhTHhvRFEvOWFrSG95V3JVNzFhSXhtMy9JQzdJM0RZNEExYkFHK2tY?=
 =?utf-8?B?ZVUyc3MvYTJaL1Rybkk3QnZ1Q3hNN1pEU0J2ZlZhSXVjejIxMHBTRWdRMTZ1?=
 =?utf-8?B?MGNMSGJDQ3RadXRRaXd3cTUvbE9oOU92cThTU1JkQWdTWkErbFQzc1ZrT3Uz?=
 =?utf-8?B?b1NOcWRMZ1pBNzhZYVJjQnN3VCtzQmoyT243L2ZlQkI4bzJMK0Q1b2lXcEt4?=
 =?utf-8?B?THdtL2ZKNGl3WXFLcUNOQmNtcW5wTVRnNWdLaTJTaENJdUhwYVFpdFZkOW1G?=
 =?utf-8?Q?BzeLQ+f07nLnXTwNhu9UOLpmjxpB6wh5a5BB4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c05024-280e-4c29-5dd6-08de795667e4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 18:55:15.1553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76fEfPkvxsFkUAyKIMy+0qQVipn60jVfPn6nTwSn/aKgecdoocaU07bSLFCYvAdO39COAoSBxAlJHn8t1Yxu2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8026
X-Rspamd-Queue-Id: 1C7C11F58A0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263373-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,weissschuh.net,gmail.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,weissschuh.net:email]
X-Rspamd-Action: no action

Switch the function to use the proper sysfs_emit("%pb").

Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 net/core/net-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 07624b682b08..a260f8b4d5c6 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1754,7 +1754,7 @@ static ssize_t xps_queue_show(struct net_device *dev, unsigned int index,
 out_no_maps:
 	rcu_read_unlock();
 
-	len = bitmap_print_to_pagebuf(false, buf, mask, nr_ids);
+	len = sysfs_emit(buf, "%*pb\n", nr_ids, mask);
 	bitmap_free(mask);
 
 	return len < PAGE_SIZE ? len : -EINVAL;
-- 
2.43.0


