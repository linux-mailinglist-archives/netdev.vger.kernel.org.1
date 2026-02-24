Return-Path: <netdev+bounces-260518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJMfKECgnWlrQwQAu9opvQ
	(envelope-from <netdev+bounces-260518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:57:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE4D1874F2
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1425630082BA
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604EC39A802;
	Tue, 24 Feb 2026 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KuofsrUL"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E863137D113
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771937854; cv=fail; b=el5qFlzVqQmAKe/vJ3OaCxIFNEWf84LIRb4nxS+rUQbNM5OlUNvgR717rvsrLhC/iYGXpqMB4Z3wKtibg/LcXM5RVXRd033UmfJPoA3pz8w1HltTE3VkadKvwIEFvjHBpm2qcrrjSiR1Ct5/FomXPCAQ2SvOWFljyBjDHWu+zKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771937854; c=relaxed/simple;
	bh=wcZe2BkZtxnQpMjMWcg73aGLqCmpgCIha3aNNNJbhHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sroAkeJ74ac0LF2pFVkcI8kX1VOhaTgSGYLzp4adDImLrT6L1KmTvCGA5aHB3ZdotD9PaOpd1iw0O2iB82e/mtDtlkYYbAcKEnoDnN98Z1aWtL7h8RmNFa4jh/cu8IxQRvdCgWotbisPbaypLac66jZJVAjVLvtOTEfNYLpzVTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KuofsrUL; arc=fail smtp.client-ip=52.101.43.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7oHt4Zs+3ytllYa9bNjYh9e2kMDQ9R4+I7sCmuCHhu09mMSX/AwIrhlAILbpmUs5mvx4i/FE9ss847jveaEHmiSZEGlJ7Vh6fPS7+A3YVXk1PF8TA2cU00+InyRrAPBtRxpOckd3AOSDUvhPAenLoA703gD45X4nAKEp+n6YpUeL7r4e1MAZ373Z6IA+CihZY5DfRZxY6492dq2QkJanoGOUwS1PmqACxcnjFQzfCE3TnmuAG19qf1GHTuA9mAntSQeJDT3nLrCc2XXA3KrpGjAPCyayJilOap4ZmcdjxkTaIDC32yM+dEEmKH3L/DiCZG8p4dFrNip6tAsLR6M3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JY/I0pbpNttynEtmr9QYT4Efy+SJHNqUyoZ2Z2CSxck=;
 b=ZHD+lIzWh/YtGC5RFVnX1zDLjCGNCDeuVRFJmXYU4dx/1Jdz6JzYNM46jb2aPRxapUxg6iFLP79GHyYQu40hpXJvxI53mGn+gcfBccwU0/sELyg7JJxMr12IAoNJTRm1HFnp44rlX3QHyTOXDCzTXxlcjvVD82DVmLVDzHXhMMhYLysAxy2GnvPpfXraYFHBr+cF2QxLPx4jMUetpwCrKy5y86JPgUBx9XVRlm1UXSrXn+sg6KjbeGtjz0XmWHjJas/SuNrLHF29nRCvaKIqmpyzfXPwsZMuA/vEgdONFITJPmWKAzfWAWGyGlzmCKdSPeCT58kzxH9bdjaTTwTv7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JY/I0pbpNttynEtmr9QYT4Efy+SJHNqUyoZ2Z2CSxck=;
 b=KuofsrULAcnO9gglMpFzRX/Xqm+pFg2FQdDOklCOtcQl0sWAUrN0dRbk2qs0wSSNDeTMUvcRX2XWv5UaZxLni6nk+hZnAsSlbucL58xixBhlvzac+Aq2ORwmzYceW9PXiT0DuO0URfcVThc1gEqYKLMt+mcxJV2dlLC/GHQ5a2L/HYN8UQMYScCOiMpbx3yY3O1SlsdIrQFo+jiqOACykY8AjT0Rp57E8oz9eSzEutijl4OlPm4RlDL57fDHlwwfZK16nCgffNFzwPYwhePI9nz2K2+0VNcAnZLW6v3G6Amda5My0Q4rFcoVmpcfUp6+vfZ9qaNWlUt7fkXxcqOA5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 12:57:29 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9632.010; Tue, 24 Feb 2026
 12:57:29 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	jiri@resnulli.us,
	andrew+netdev@lunn.ch,
	penguin-kernel@I-love.SAKURA.ne.jp,
	stfomichev@gmail.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net v3 0/2] team: Fix reference count leak when changing port netns
Date: Tue, 24 Feb 2026 14:57:07 +0200
Message-ID: <20260224125709.317574-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::20) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: dcb6a9db-7015-4a42-ca2c-08de73a44451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xz6p0wm7jKngwCfcPY3Iezr9wne3wrqml1uSGIimm0KE+oCHg7YjTowjkkU5?=
 =?us-ascii?Q?ncaGLMCmlfuFzFz7LMAmAEvj3itgwrMpYvsB/A+6taRREVyt4oTshJJE48+a?=
 =?us-ascii?Q?WUtD654PFzi//WsLUzBK/mJ5WULINx7ZaGzBBy+VNmpE7S7nUJUdy/B4iERm?=
 =?us-ascii?Q?7hGzNso/gdcOxkxUUiGIICZCH8J+PLr/u9CjXuTbpjhEGn86dB/pECkztM6W?=
 =?us-ascii?Q?Yts1EAUpUi3IQAl4or8IquorpreeW+d6I72tQF57lSr1bBs/KkwOH47cWbBs?=
 =?us-ascii?Q?P20wmAFZh9zEHlbh6o8SXttMwaddAkvL23qpJeSxh94T98AwEvG25CCC6MsQ?=
 =?us-ascii?Q?qwtRK4MW97I90aARr3qhmj/AXQtc33VdbfqDc7yZzOdh9jd9pcS5am1FgWuW?=
 =?us-ascii?Q?1fkhRIIEJ9BH3nOwS4mVPIFaIVglA7NUnYL+5FH8Yoj4WUmMfr24iChfxB7W?=
 =?us-ascii?Q?yVnf/f6MVLcgQKrlHDPHXCjQEwGlAcyyMPfUC/9u5FkdvZhYnQXGnypQPDRL?=
 =?us-ascii?Q?Qk9fbGmhDI/YvTuYu17XmO2Pnf31cIEsWYGq0GMQ4XZo59JYHjOxqZ7jhgFP?=
 =?us-ascii?Q?hu+Ldn4pMAY7PFDKkqvpaxlD+RxD2XiBZQecYWDjxiN/caJgEWWy1SsfkI2P?=
 =?us-ascii?Q?qXw43HuCGtCTjaHcX/58My/3P6UZqZtgfx4KJqqShekYe0Or686Tu1QsDh5b?=
 =?us-ascii?Q?Ak8kpUF9R3cm+VRA2vncsjK1d4WT/kAcvUHfOiGs4XGcADU8SipHV1Q+XGpe?=
 =?us-ascii?Q?GKc6Fw9bn+INTMLG1moH9sfdkWJsVCnJoqR0QQfQpXUXtUl1UKZlwLs72j+m?=
 =?us-ascii?Q?Kg/k0wnVCpaJP/Fpdfwk3h2/i/1O3Lnzve4N+PKagCQfq2WRgwSxUZSDIRRi?=
 =?us-ascii?Q?FX1Lnsyfd1jH5rqz9bv1xuc86iglLa6LmMFKMP9shKcV9be50+uA22dYwm92?=
 =?us-ascii?Q?+yiOoE2OAuE9V5E5UZ7k4hpFfcZjifbw+wTMoWamHZLXauXN50UbwJffl9ie?=
 =?us-ascii?Q?5rYBuHI37xou3xIfA+HhiXyhy+KkM3BjCuzTXoEQvn6FdGfguDCP6kuveNGT?=
 =?us-ascii?Q?VkH9xz9yMDIi6ypy0WSvyS37trNKs6qg8wnpWvNRxrQZtL3eMKmw/4k9Yeoh?=
 =?us-ascii?Q?AlAt/4Zy2JrfIrN9ZfMBgr38mGmAe/5bXxi0SbH9Qee9bKseek7Vl0Lvev3n?=
 =?us-ascii?Q?pLBknEY88yX9t9/buriLD1PyNwuk3Me2366OWkpo6bEM10sHRur8Hw6rEaWe?=
 =?us-ascii?Q?tArTX+8LzeLk56CVxoouj/Sk2okGFFMmZOqGCTuQRi/zRPxraM5mO8NAA36N?=
 =?us-ascii?Q?/ibXGeylJLQdL5PW/aqQYuQ02XjMsWfCsxLVhzZasYI+4OI2kE504QcLZPdy?=
 =?us-ascii?Q?HO+vsBj4/62BMN0i+RTLe4Czdj4K+NjtReCPu4HLjWfwPYjzYdfWbaLcT/RU?=
 =?us-ascii?Q?PD9krSuB1rLk/sKQHpzmnnvd8zBfC1rZD/qOZHutp/iJluCZ099yXUW6psJ6?=
 =?us-ascii?Q?F6IZjuQruRjWjvSvaCnIOJuDWrXb0rLyCwlSK5PitkwQnri0em9MLdTNSfzZ?=
 =?us-ascii?Q?ZTnen/X5fFGkIN3/HoU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CqG8cZrqMCkU3D3rJWUW5zX5YRIIAqBSkPt9sc6D932FUKbYxWC5z7Bu9ZX7?=
 =?us-ascii?Q?nRQs+nkrQgkiteL3xSv9uFRINTykHNO8TEEDBZbGfiR9gukCotWmrSPSrY+L?=
 =?us-ascii?Q?wYSPeB7Uu4B27KCQgaVVKpfdnqSNCs7BGlJvLuJdEwPbTDPFizCVlQ+Yx+0Z?=
 =?us-ascii?Q?aE/FCb9gDePwXFc0k9QZzwS+uAwlMD0HpZ4KUsEfRrRMKwekq2ibtRbiPYoU?=
 =?us-ascii?Q?3bG5SZtupRNJLmJrZzncQYJkMVnSHqL6q8ZJ8zKYdgpp+7nXI1YnZaf8wclS?=
 =?us-ascii?Q?mMKYaqFof9IxFTM1QS9EvrUhXAjjTAbd1MelkSF9sWY5zBS1XYtcAzoVikht?=
 =?us-ascii?Q?x3peLAJ9VUCkz2ciSx8D/cPXE9ERBCAJ4SVuGRBwGoKtviV3VXblYXZB2889?=
 =?us-ascii?Q?bOwWDrkZRq/e1bSBwjKCZhJQW7dpWeXIGQc2TPRPA5AQR8jk29W8VKKBKQwX?=
 =?us-ascii?Q?LrODR+PW++U1WRSAUy+Zh25C3oOPKHAsUXmOFIpBFNjwAV66KGFVDshKLMoT?=
 =?us-ascii?Q?43mNrAL6hGrkSPgI+c2Mnf2WvsRX/2KXDpVRPKtYfSbKTSVWik+JGQ3r3a2d?=
 =?us-ascii?Q?3n7Xul2IbOc+8ItODMszsqQrFbxFqnf3nfcziKLqPGbIFzYF30E35Ny5ma9G?=
 =?us-ascii?Q?OB1LKRoz8VlRZmak+NUxpzpPGiH0JVGFCTDTdJcNbSixwZo1rJVLav9IsYJL?=
 =?us-ascii?Q?wvk1wyTOmuEu/Xrr43xmhWSMKZ7qoDnOU0WnpIiDnJ9sbEF4ieSsYHN60j/Y?=
 =?us-ascii?Q?7rLvusBZEXO7FrkhqJXLhRD2kfbDdN4JZWaLmOf/GBueeAuaLwQEw42w1y9i?=
 =?us-ascii?Q?gWbETZvU3gXdxtvrdqY3+cEGGOOb32f4uT7XWY4MLybjFe8sythe1XR2dY+t?=
 =?us-ascii?Q?zwXhCi8nyvfjtH2/oBcfkC4f1XGssTjYnEjAtUSSPDSR7aP2F23S3fBc4rgC?=
 =?us-ascii?Q?Pp4+f0He8lZbbQ1XUzEZt+x+dKnFfex55V/S5v7O9/6VE9WiV7tiodK2gP2m?=
 =?us-ascii?Q?AbrxE24Geqy08OOYcxyyup8KHnTW8DaEUGd6kAViSK9YcvllkwIShsV6Aj/9?=
 =?us-ascii?Q?a43RK6NdCalVKB2KhvtJqlGLtFaBwLCjpwJ5o1oqF9b0ptpE8f7kUIXImT4l?=
 =?us-ascii?Q?oOWnTzbHo8T+VSRVKQRVFG4gijwVPfsPAPr+q12ViQcqHfMddvt+n0A06nFt?=
 =?us-ascii?Q?HoaTwZ0FnlZXNY85milUmjFkj/R3QRANmz1gaBklPcFb3gZBN2D2yMTRGZoC?=
 =?us-ascii?Q?EDJTJsWkCpOg3ovTpTACho9wng0/HMzfdsBOv0vViEMM9vD0gMJ6+z+KJPse?=
 =?us-ascii?Q?id8hLTAfAt1zkg+9BkM5zm2xHUNSrgRcxgrtSIGuOsYAJ71DhSr0D8r8c334?=
 =?us-ascii?Q?/uHc3h3vc6qpoR69ZcR8BNP2y7jK+ee8u5Zy+rL+PInldJfVL2XrTeavMsQn?=
 =?us-ascii?Q?wem829S+RBmXykxvdR+gelA82go2XU6UXXJqj3OqOASSrdgSdLJf4qBMW+t4?=
 =?us-ascii?Q?QZ8HLOmk3nzWi/qQ2oJmUCG54vcZn5xX6do/r2LGeLcvLMIJ7P7+lYJ+oR3O?=
 =?us-ascii?Q?TrEwBQznOtVYG1c8Vn/VuNFXmMo8a/PEn3e0ubYOu8YJkimnhzqEQebIAW9B?=
 =?us-ascii?Q?ZEdMP8LIpSaUhlqbPs0NhRP4GYluNPHZ2RAOu+KKwy2nhfOxUC3GI7Z4iaW5?=
 =?us-ascii?Q?AoM5aCrDGIz+p0Oz4mOcTdEfWT+AQ0Ziq6cCP1eivzuCWnuT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb6a9db-7015-4a42-ca2c-08de73a44451
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 12:57:29.4874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLUn/pRd9YhG6OKI6Y6qh2fBeujJwaDbgXwSjFaTO9KGXImBshBEvMGh+gbhE9aOlI6f8t9dF0AR+2SMonhlWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,resnulli.us,lunn.ch,I-love.SAKURA.ne.jp,gmail.com,nvidia.com];
	TAGGED_FROM(0.00)[bounces-260518-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.966];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: 1DE4D1874F2
X-Rspamd-Action: no action

Patch #1 fixes a reference count leak that was reported by syzkaller.
The leak happens when a net device that is member in a team is changing
netns. The fix is to align the team driver with the bond driver and have
it suppress NETDEV_CHANGEMTU events for a net device that is being
unregistered.

Without this change, the NETDEV_CHANGEMTU event causes inetdev_event()
to recreate an inet device for this net device in its original netns,
after it was previously destroyed upon NETDEV_UNREGISTER. Later on, when
inetdev_event() receives a NETDEV_REGISTER event for this net device in
the new nents, it simply leaks the reference:

case NETDEV_REGISTER:
        pr_debug("%s: bug\n", __func__);
        RCU_INIT_POINTER(dev->ip_ptr, NULL);
        break;

addrconf_notify() handles this differently and reuses the existing inet6
device if one exists when a NETDEV_REGISTER event is received. This
creates a different problem where it is possible for a net device to
reference an inet6 device that was created in a previous netns.

A more generic fix that we can try in net-next is to revert the changes
in the bond and team drivers and instead have IPv4 and IPv6 destroy and
recreate an inet device if one already exists upon NETDEV_REGISTER.

Patch #2 adds a selftest that passes with the fix and hangs without it.

v3:
  - Add a selftest.
v2: https://lore.kernel.org/netdev/4d69abe1-ca8d-4f0b-bcf8-13899b211e57@I-love.SAKURA.ne.jp/
  - Add Fixes tag.
  - Add MODULE_IMPORT_NS().
v1: https://lore.kernel.org/all/ece4365f-906c-44e2-80c9-ab73f91f7fb5@I-love.SAKURA.ne.jp/

Ido Schimmel (1):
  selftests: team: Add a reference count leak test

Tetsuo Handa (1):
  team: avoid NETDEV_CHANGEMTU event when unregistering slave

 drivers/net/team/team_core.c                  | 26 +++++++++++++++----
 .../selftests/drivers/net/team/Makefile       |  1 +
 .../selftests/drivers/net/team/refleak.sh     | 17 ++++++++++++
 3 files changed, 39 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/team/refleak.sh

-- 
2.53.0


