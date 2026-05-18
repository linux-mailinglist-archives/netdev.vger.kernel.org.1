Return-Path: <netdev+bounces-289132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFQNCzhGC2rgFAUAu9opvQ
	(envelope-from <netdev+bounces-289132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 19:02:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E6A571608
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 19:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36D9E3051D45
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B259D494A15;
	Mon, 18 May 2026 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bJB9hD5b"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1F7492531;
	Mon, 18 May 2026 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123429; cv=fail; b=YIeE6/87fpfcIZSzfV/HicBThZy7khh6mmUyUlwaHYDijbiw5Q/PJDXSfdGIIOe52cSKXfHfNskB9MvAjxcf0BWbN3mePpfyoLjqUfVO/B0rswgKD7CwCYeWIBtMA1XVkUf8HidCBTLAqphhjx3zrKWYL221VI6LEuiPYos7eFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123429; c=relaxed/simple;
	bh=2Y4rJvmSQmw8yEaMPDEzlkz9NUOfh4+IdMRBfrID2ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Eqpw3pvWn4SUTOAhXn9tgXSJbTkTHtYgk4mzkItWdJArEnuOR3V4ia6fI87fL5AWsRBdBp8YHsI+AGQlkw772wr6lcwvmSp+v2OUpR8+mqkwakjqEhgiyjjo1RNUkWWps1yscKXPpOf7k/hme18U0jDqrXoQ9dBDM6eLqiNS2U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bJB9hD5b; arc=fail smtp.client-ip=52.101.46.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6y/xd8bPeU4Wzzjq1eWZktOOFO30RFxEafBIeQXy6yc3N/GnzCmUt2muYJtInKPHJnxj7xP/WH8LK9BR5KGjtm2+sRo7Poi6yptckrqPO6Fz1PsiuhZBwE8ZCXKzwUzyA1fFUdg4IcixsjZd4KamIFStb6hyOZ4/ynGUyFiM4Ws/zEijJyABqt4MN0ugXjqYfvZqQK+rRvU9vqxUAbhMILp2KBU8Wn+xqrvQqK5rKPRUdEGaz2UAeMADoYaKNufkSlQUP7DD3as95ZmWIdwyCWmJ/okVqfOYSWw+3w6pHyYw/RpB0N4TSt1F6qx4RcPSU9DmIIndphPL0s1OVGU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpAz+56ujJr1nkH75lH6xuGFfjdzgVAMGhqzMIDdAi0=;
 b=VU2DKdy6kgB9WCkYW6ueRAYrt01SnTG9bkPYRVcq/QSuJHgV6OnqTYCFuo6ZGkt7ihQEPc/tIc3X5xZ33N0enZN59m3+Ci2n5SOWTiL11GMBmbSU1Fhf6iv3fiXsCwkbYu+GslBbVEenE9mzhkCVJd5l5unmPWHphBndLKtE+PonmtwI0R/OiNniybjqJarFolofPikFmEduHmqLEel+GNqy7yqO7HadX2UmkuR8dy5PDA9niG3QUxtRuLRljBXXHaevbxYDsNTzqla6pM4ptpe6cVlJZkDozt7CFTi3/IH6y+CvB+I7PM+9F+s01kHLuCS5rm+VwoyIWp8ymoIOeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpAz+56ujJr1nkH75lH6xuGFfjdzgVAMGhqzMIDdAi0=;
 b=bJB9hD5bsQT432Z3T2jwyBftzKKmSPA2m3ilLZpV8K6ENILFdKtLUVs470p3hl2PO45qqdXImX2J+FD2NmX6LVYM6k2rGgbMFE0jpjpvZw2nKU2/II0VRmGYno0l10lWLLUrYaUvh2DYnoFEZa3GdIGKWC/w2hLt2f2MZSbpiG1wfMrZZ7tCmY/vBRbuS0SDC0GGwQj6eGBxG3Zflj1Wjq2Wu+FseSIyGoYvBm3b2L64CfGcwX6OwIWaodzz3U3PxctUyTX8SzRmd0Kb2klnI7DqICpS67JwrFyFgfPysRiOHWw/iFZm5A5qCc8M+4mWFKCxCiOcJfIKWdfD5gce1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.23; Mon, 18 May 2026 16:57:05 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 16:57:05 +0000
From: Andy Roulin <aroulin@nvidia.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Roopa Prabhu <roopa@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Chirag Shah <chirag@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] vxlan: vnifilter: send notification on VNI add
Date: Mon, 18 May 2026 09:56:58 -0700
Message-ID: <20260518165700.1975478-2-aroulin@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518165700.1975478-1-aroulin@nvidia.com>
References: <20260518165700.1975478-1-aroulin@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:806:f2::25) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: ceb7fe17-d466-4c58-2b50-08deb4fe7d47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	qu+4xvtUC5tZ0GW7TRA056x8KkgjIcU9NihEYsiDj0PleqRzwd62ljDpREEGaZ3m2fU6vMIwNeJ/WNBvIKIDj42xqEgY+hIZI8adH4FFPgADHQF01w93Pg4kAQPnLEOMTdxHrk0Oc8mBGZEAd5I/oRMky8c60FQnC9/rvf+1jFMYNHowkg6knl/EE8EAio42+VsPkhm5VTDpwHI5x4DCpSxygZnpD3PIk4t1pINTPQm4wHOOn6xOIuPtBlr/tLz3qVqBKz/0Ev5zb6M+WZ0YlRQ0hT3M2cXzQAtPfZ8mBYFKS0A1rU19qxEujseuxls/5qwFQosDgO1396ko9/RBvRuFOFSfkovP2lZg8ikAQwRW50WEuYYRgWhboFMT+IGBoD3GhOjnNwwiT96U8FmwJxgFnV3ajYrk5JhE8UEc73VHuIkCXWOqB0jlfoAsvf2OykolJQQbrOZSoz01Qz1Rp/xQKICvM9LVqKJDcDj6u9Dh1xnhpZYOUCwdN0R6Nz/aByWQRaSJiIb8+lU1HLi6deB4dXhpDxQUCEw/kaaJgTuyNYqYI8fDpcehZyyCUcgWEucQhO/Vkr+Frl2iHfgAUJ3vwUbhHURehTXUGpk3yn1bcSLnTgz8UklVXQSzt6KKeAZp5LR0c60Ns+BJAlhPj3q3ZpBwCgkGDs7JwHQ89LhLVBpip05+CuRtBgsC7bVF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oEykc2pfgne7q41LsqR3CkYfFitjuon3BexgIQmSPwwGX9wkTwHLDxg2uIYs?=
 =?us-ascii?Q?IGskeB6M/VpaEuQpNL2Qc95gWvXuRN6trF2uC2gwnp4RheLR5xWtcP9Jrn6l?=
 =?us-ascii?Q?v3Xt14Ix/nSBw9nqfr8qehH5POPEU5Lcb1uOvDewxNSLlHr+qzojnwZX4Nqv?=
 =?us-ascii?Q?zA1rQLQPaZoVWoyOP8HR6tlKt++zDm3mMCWK29zfhqFfhnghGSYye6eKhxE+?=
 =?us-ascii?Q?Htiab/yun2Lg9gOdzN8Vx+eNIgy1qiCkeDmjX+7HXv9xZcfkOnb5AGVgzQu0?=
 =?us-ascii?Q?dwK9hpgb7g6fSsVL+/PFit1+ZCTiCOBHbrwAtHIChwFlNyL8jeyLNpsuGNo/?=
 =?us-ascii?Q?IWtRenhRbeKLhblejNHXEtrE0Uji+/I4lJH1s9FebD7DHBEdCZ98Vu8j/dvC?=
 =?us-ascii?Q?wjgMTa8YDjnH2mx3LLME+zfmRQ/a8yO+maxZSToHftbM03IejMxEWlkpwIM2?=
 =?us-ascii?Q?2V3s+14Hk+WNYEmu0e5rMfHofwO2oZwlaCdgyUik3SlnQHV1krMU8CZmduzw?=
 =?us-ascii?Q?TonZ7GjeVnc8mpN3yhK4djYjsKz3cY9n7JCB5klBqOeNwGw4IfT+LXTUn1dS?=
 =?us-ascii?Q?EEPtwHpvBIHaWR7f4jpDolj5pjqb9Njp0NCbSTpBfVHSUF8fPNqsunkVF+jx?=
 =?us-ascii?Q?impm0dVfSt2Y2fSHUISyOOWCbqLpBtHJiXstRVCOYtFkBC3HcuqewSY1v/9D?=
 =?us-ascii?Q?3yZp4MLOj6ehHrEd6v6vS5eL/A0MVRWLakCcw42ndt9luKZAucW5O5qoqtyQ?=
 =?us-ascii?Q?s6xRB34P5Eqy5ZmUCSvr79IjLdBucRIIKlyn7Y2Y0h/Vfvz4hTo7JSHHuOUM?=
 =?us-ascii?Q?iA/3YAs3WjClLm0V2Q4kTOBZK00LKdAa3tfxUEsadwQ2+RCKTp3fz25EJSMz?=
 =?us-ascii?Q?QZZqlncXxkBjlSze6br5aLsUQniywu74+UOkdaTHXORkQ/f2XvUwYT15ICry?=
 =?us-ascii?Q?tGp3sivktzdIuSdqDp5uTPHolc6SZFjZSkvviHV5ofqAelsPXUnbyoXF0XIf?=
 =?us-ascii?Q?vT1vEi3+MmktOk3lFycJA9vAYnXRbdSfK5C85GxMeFcEpD5Uko1fcBirP8oA?=
 =?us-ascii?Q?sgfvSKkoa85FcqdVpYZq+3iWgAoH93hdnP3oWcp7MFQoFE+PIcSWX2JHYvgt?=
 =?us-ascii?Q?wBKlNb7gk+GoylKKHqkvADFf5X1YytO0+cr0wUnsfqo2ZtDb5/8jSlSlYgFq?=
 =?us-ascii?Q?myrrNyZWJggZNYDefXq2FVE3nGQTjhLWuC/wHvM5sklJbClTMK4M4bXQ3Smt?=
 =?us-ascii?Q?bnaIeku0FBwScbxXSxLSCR4Xf0ndPDzuel0q7n5x4C5n9PGaPMFcb3iMTEfm?=
 =?us-ascii?Q?iWZ6GsUWsM2mYmHZcKsWBKWzSM1uo5+lJzds/h7GT3EwzLRCCobQx373VDck?=
 =?us-ascii?Q?HB6/QVauXNWArCkhrqQioTwhcjIXuZIEuKDJUuWTE8C8aLJCSK0XadOM2kRw?=
 =?us-ascii?Q?OIw0a92CO2dr6+BPwgraC4AqSVGe/tnzSrP04ADZ7PUolRghm78vyBgh8Pv6?=
 =?us-ascii?Q?64h0HhU7jsYJihJPz9YNwh5328EFvjBloA65xT/6QKuyYAxlaR2LvTfLjQv8?=
 =?us-ascii?Q?1GFMAAKJ6dkElG1xq3diMei+ug6g6FVBeVloMgFhBi6KRYqQDRdkEJ4R7uAj?=
 =?us-ascii?Q?aCE/mbpMlz84D/e41XU6Rc3bSOniRYv4oRsGcFVt7X5M0dSxrUpEvQRM4D6z?=
 =?us-ascii?Q?9BSL8Thm73c6+RX2vv7bzjEszaSjEi35KCJYD0ugq1MBTnL7PKGI8g27ZFfi?=
 =?us-ascii?Q?T4kU0nJYNA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb7fe17-d466-4c58-2b50-08deb4fe7d47
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 16:57:05.1593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxQPQmVOoUojBVhl3iFX9QG8xFDzwbbsB091WzZr1CccSPmkqU3yv5vDPkh1eSv9e1OZQuW5iV3S1r+UhNgPGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289132-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A5E6A571608
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a new VNI is added to a vxlan device with vnifilter enabled,
no RTM_NEWTUNNEL notification is sent to userspace. This means
'bridge monitor vni' never shows VNI add events, even though
VNI delete events are reported correctly.

The bug is in vxlan_vni_add(), where the notification is guarded by
'if (changed)'. The 'changed' flag is set by vxlan_vni_update_group()
only when the multicast group or remote IP is modified, but for a
new VNI added without a group (e.g. in L3 VxLAN interface scenarios),
the function returns early without setting changed=true. Since this
is a new VNI, the notification should be sent unconditionally.

The notification is not guarded by the return value of
vxlan_vni_update_group() because, at this point, the VNI has already
been inserted into the hash table and list with no rollback on error.
The VNI will be visible in 'bridge vni show' regardless, so userspace
should be informed. This is consistent with vxlan_vni_del() which also
notifies unconditionally.

The 'if (changed)' guard remains correct in vxlan_vni_update(), which
handles the case where a VNI already exists and is being re-added --
there, we only want to notify if the group/remote actually changed.

Reproducer:

 # ip link add vxlan100 type vxlan dstport 4789 local 10.0.0.1 \
      nolearning external vnifilter
 # ip link set vxlan100 up
 # bridge monitor vni &
 # bridge vni add vni 1000 dev vxlan100    # no notification
 # bridge vni delete vni 1000 dev vxlan100 # notification received

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Reported-by: Chirag Shah <chirag@nvidia.com>
Signed-off-by: Andy Roulin <aroulin@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Assisted-by: Claude:claude-opus-4-6
---
 drivers/net/vxlan/vxlan_vnifilter.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 2042369379ffc..f2a202d468928 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -759,8 +759,7 @@ static int vxlan_vni_add(struct vxlan_dev *vxlan,
 	err = vxlan_vni_update_group(vxlan, vninode, group, true, &changed,
 				     extack);
 
-	if (changed)
-		vxlan_vnifilter_notify(vxlan, vninode, RTM_NEWTUNNEL);
+	vxlan_vnifilter_notify(vxlan, vninode, RTM_NEWTUNNEL);
 
 	return err;
 }
-- 
2.43.0


