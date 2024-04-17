Return-Path: <netdev+bounces-88545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DE98A7A26
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 03:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924471F216D8
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 01:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89E8184F;
	Wed, 17 Apr 2024 01:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p/fvlS3+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E440184D
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 01:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713317233; cv=fail; b=B7llCghROW2H2MrRmfG32KqwedUDIYSC8eYaAmYVwzQBbT3+MwNB0lg4rraQ2vd+bJ1aG3aY9gh7BlcX62vfBVnc/K2N3RTSXNAbl1qsR7gRP3ct5uKKOh7MmO8KX7Q+VXH6tSo+aX3ha220di7SVzbAYN0vzk9gdkFCVgxdQo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713317233; c=relaxed/simple;
	bh=YiPUjo6QH6pfK6rq7ahdVb2j083iseKsj3loeDS7IRE=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=fH5GCIHGBJ0ECNWaqPZZNF6FDXHgvVukzqlo7eaZKrz05ObMNsghPK9Judj318007pw+gqOXxrjurO41a0G5W0cnmaRa7eQI6HItI8nGgSMV6uXfe+9G+jrfwuhWa9+8PpWWOJk/h3JWU2DWodoGUEmSIGkCxyDrU0JKlKW4k40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p/fvlS3+; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLu6hJYtLAqPm+lRKYZwfEq8p4PsUtgxtc7xVhpX+HOT4X8RK++VfzFzvBJ9Tg3YkEH0WrC/0iylmQRmgd76R07KOY8CgKM+WNaz512b3DmGqYRlobJpgNxyhDlYtL0kgsRQQIKjL/TBE6GYQ0VPOxAlkzVbzH7Yya/YSfSrJ/KgScv0JqLiEjHls3rTf/NMMXKeegS9Y4kAnTmg3BA+KI2eEnT+ZvFa3vUEdO1+0o9N1dhLB41heuMvjB1jLYe5oMOhFbpdUDWuz3g1n/I4RIxhvp3rQqssTQj4xSkDBwOiU0GO7B7xMsEpQMIPNSeWsAigqiU+XBq+B7qneS95ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZ146mcZ3kpVn8q0pik/7+nTc+EvDh9aDiTyjth0Fwk=;
 b=CEIoU09PBbEscT//PtJbiKgO1oxUCRFIZwP6mrvKK+0NK88b549rDi+UjOJwVYrASLKWtnaDDAuGFCTl6T6OFcWCAhmHQN0wkA7ECNlVTIWdgLuZ1Hn0ZHM9q16wcTYsyAVPdqEQv8+8Y5E/9v7crB60628o0ESSBQTpmKoV2N1DeHqShpCK0Yldm5qGgVd/s2qmhGX/jnIPF09jaP1jG5gHbg3QqDVnv5kZmwGFRfAfJWUaDmMYET/ng/VuQgvuLk1FfCi/2ci/SiJGXOKGMSvQ7hfcE3V1eG12ug7OWVCe5FN1FM4DZbvj46rO+KruaZwOiV4Lhu+6douio1F5Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZ146mcZ3kpVn8q0pik/7+nTc+EvDh9aDiTyjth0Fwk=;
 b=p/fvlS3+AyPHKnjd9gz84kVYCjFMallMgaLWvh0VwWZoefyi0c9creJMNvGnRaXd2/srHlkaXIYBOdrpnX93vCDllnEppVIYvqnggjHOQygfaahYjJfFgDBun/LBzStYzL3uUdj35H1muTgW1lS4PZiS29EOwZ++J/wvcKDkwoUNkPlJqOmDfYc1n9TmvNFt3Mw3xSREGP2OeEqmDMjWPGGvZkt0MrRdStpPUAXF+cJZqIwGsqRks6eXYLpHHHAbdIyhPUVswOx3OBwLeTJCbpWTD/bDMvk8O6cU2RHkWCDEyHuiZ2FpYemE6E2I47YVRG26mpgvTHl3W7TLl7HEnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by MW4PR12MB6707.namprd12.prod.outlook.com (2603:10b6:303:1ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 01:27:08 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 01:27:07 +0000
References: <20240416203723.104062-1-rrameshbabu@nvidia.com>
 <20240416203723.104062-3-rrameshbabu@nvidia.com>
 <20240416170742.4ebbb130@kernel.org>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Jacob Keller <jacob.e.keller@intel.com>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Gal Pressman <gal@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Carolina Jubran
 <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Michal Kubecek
 <mkubecek@suse.cz>
Subject: Re: [PATCH ethtool-next 2/2] netlink: tsinfo: add statistics support
Date: Tue, 16 Apr 2024 18:25:24 -0700
In-reply-to: <20240416170742.4ebbb130@kernel.org>
Message-ID: <87edb4vkwm.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0066.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::11) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|MW4PR12MB6707:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d491f14-c004-4d60-b22b-08dc5e7d7f1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xrYYopJn7c7GvZ/Z9MeayPIeZ9Ek2MDslaOXjiAXVabYixwKlaMcElmiptjQMReBE0im/zd6Xzg82VxVJ+vjUupZ5TI3Zxdd36poJYliSsOpzYtkD59jo8pLyILZ+IIjvLNnA5uBSNhZ76yHW86VnLBG0eJaxtyv/V5/8mR4Gq7uVC6piZuyRZcXvyRR7MLVnwQ9QZlc1xItAXGC38wbOrPxFIdYqFqyNX6vGBJ4IF08b2WJu60hA40L4A7S7vU4NeDNGRJjp8lOF+LGBtXRIdsMr3ijmA+F2ojqzL6fR4vVVS0kk94XO2ZJMXTORniIPvGxTKY96YTaeVHplN8dKDe4Q78jJzkEewQ8FzgmRW6Kt9zhazDhnTPoPUac+452F8SUtNWcxKLTv8VY44GMHiB6Tf5J/Pau9HeGdwIUvEKohm7IItbzYWlAXob9rnzXS/521TojalloseKEfBPMK0zIOtPXL87N8/BVOwkKnqa5C3+rADvYCX1YlVlIx66b28HijWlukf/dFMuh0tFDcP5++VGe416QiGS7qWDT1T11dN2pmFEF2/42NYqGsH0uWpAqK+v+0yAoiJ0Y38Rddtg46swSbmQiw1i9XP4SOUSo1/dT/HxMX84Go4qswFTFeC7rCKxhH32rJVL8qYBD0DEkCwThfohnGvef+1gdUXk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lxFN4lEQ7kv76qmCFkT3DQ+PxR6EJFL3HugIQ41aABOpKGqdBhNL//AD9VQR?=
 =?us-ascii?Q?nYLe1ZA2IUvsQVyR6/onypgZQHv+7QJN4YswhuEl9oTpvnelQUV7yjMkq13B?=
 =?us-ascii?Q?wGgDlKC3liPMaR2lxdAFqEpUAu4D54+fCFqOSAt6KeX5mwnVBJrGKgcvId9i?=
 =?us-ascii?Q?4zFvcxyVANtRMnoB7OrIQVkHkuori+ZsErH1+g4TXTJT/j/DU3gjEFb1v+1x?=
 =?us-ascii?Q?Q6LdX2XUdbthcY70wfRzk67XDYd1c3/h09vnRefyn5oDnCUbW364eCxba5W2?=
 =?us-ascii?Q?JJJa6rJuloHp868Q3L+JWmnM6DvvJvTNwsvM8sB4gpEDwz185FJPm8AfRtHL?=
 =?us-ascii?Q?LYgb2PReDSgOw9uWwvo7sgfzh0MDTp6sWB7+sPl81Vtc6nXIW37An0/nJdzi?=
 =?us-ascii?Q?BRarc0K0Pi3Xo13G6INN2+mfQ6mP7eZGPFNeDoFjvmdVPk8MuJZlkcyRJMUz?=
 =?us-ascii?Q?VGba76RA0VWDZowd2bdHYusMUDNuHhHJXdCheNW7cY/kYqiS8CxozEMEPatn?=
 =?us-ascii?Q?oBM2I35CbzF40+EuBO1YjMU4rQ0G4x/oT5h+AHGR+qn1ORRXUYsYRfktGVQ8?=
 =?us-ascii?Q?G5nwRT1c/4QtwfIOJjH6HRJcRh957c9KYhwXFj00gxnHeSEBKv1xZfbbg/vk?=
 =?us-ascii?Q?aFI2lSSLKljCVK4TQ1zORnKACTvVRS1Rs8OFUlmnEnHJV/dcf611Zws8JJ+u?=
 =?us-ascii?Q?J6lrnWAYfyuvZOUtGDGDzxVRoOJbUNpCp4P0InISdrSBGhSPbkNoXFImeH8a?=
 =?us-ascii?Q?ozg+3MHTWNQpfvlPMgRuMCPQBSvk8Im80ZtFPQAgvV77HdaI7avNitrhyIOx?=
 =?us-ascii?Q?U/ZRmE9K6AgW7B/iZ3KGIDyPObJ97Y8iD2h3bi8bw7wD3nQ0oHnCJZOFN2ta?=
 =?us-ascii?Q?/UALNizKXZ2Fc6aP0ywoztqNixM31si7Q3x/2a+spCQhNj0wE8WoNXLdjJrG?=
 =?us-ascii?Q?7IxE6ozY0qsIrILPXZhBlmq498voufd7HzIHDJDmub0AokpIgGQXwoTIbDWe?=
 =?us-ascii?Q?W4iCla/9/gGAm3HhwnLceLIhyFBQFbzBnYU/Zoqmdel9BOy47Voz8wXvcd2s?=
 =?us-ascii?Q?trYRJtSDXixRpMMCDZ0OD+sZ/YGj4DUuvoo3vDW0PvHQs0O/HRRzSTr/96dh?=
 =?us-ascii?Q?OIBh7yzqafNTzVxzf/95lnjkHUSRXhRKs18y/snsanM7EJYSBKG/I5TO2B2Y?=
 =?us-ascii?Q?uofwy4nZpFFZPkSh9fncP+qxKM97ic5s+OJMvs++M+qIKptEIU067tcKON7G?=
 =?us-ascii?Q?NrmwDxcWh+71CY2SI2yHPZ1d4UT3YXX6UrGuWStKdhLgsfBPlTPuIkSO95BY?=
 =?us-ascii?Q?scXQoXJlCM6RQ1mX3taFE838AqwPQr1vbeCZCA/bn3nGwFtlT5kVy9j80dUl?=
 =?us-ascii?Q?BHEtSf5UGXKImPE5yYcpHoqoJsPp9bzPjo/K3/ahCKrEIBDnX3uamuWw8IdW?=
 =?us-ascii?Q?fwrl8eAvVn6W58wk7vBBSbXm4w/6Yn9ct0ieGuq0r/wOQM/i+qL2QM5JwelN?=
 =?us-ascii?Q?oZuQiljLJjjPGYpuq1ooG9XJ4DYBgZvYWplB4cVvyK2p+EUejpZDXPU/03ep?=
 =?us-ascii?Q?OS9oqmwT2b849+3H2+BYBMaRhv5QXOXEcfsUA67D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d491f14-c004-4d60-b22b-08dc5e7d7f1c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 01:27:07.7519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFfPawFQY0rCqrMhFF93jA3hQIW7n/n8OypSi7JJwcLOa7XmqVvXWqjWbAnHcB/SnQr4RCFV1Ol0NwnNlv1TKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6707

On Tue, 16 Apr, 2024 17:07:42 -0700 Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 16 Apr 2024 13:37:17 -0700 Rahul Rameshbabu wrote:
>> +		if (mnl_attr_validate(tb[stats[i].attr], MNL_TYPE_U32)) {
>> +			is_u64 = true;
>> +			if (mnl_attr_validate(tb[stats[i].attr], MNL_TYPE_U64)) {
>> +				fprintf(stderr, "malformed netlink message (statistic)\n");
>> +				goto err_close_stats;
>> +			}
>> +		}
>
> possibly cleaner:
>
> 	__u64 val;
>
> 	if (!mnl_attr_validate(tb[stats[i].attr], MNL_TYPE_U32)) {
> 		val = mnl_attr_get_u32(tb[stats[i].attr]);
> 	} else if (!mnl_attr_validate(tb[stats[i].attr], MNL_TYPE_U64)) {
> 		val = mnl_attr_get_u64(tb[stats[i].attr]);
> 	} else {
> 		fprintf(stderr, "malformed netlink message (statistic)\n");
> 		goto err_close_stats;
> 	}

I think this refactor is nice as well. Will wait 24 hours before
reposting but will send out a v2.

--
Thanks,

Rahul Rameshbabu

