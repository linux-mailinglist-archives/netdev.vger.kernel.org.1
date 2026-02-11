Return-Path: <netdev+bounces-258218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDUaCyo+jGm7jwAAu9opvQ
	(envelope-from <netdev+bounces-258218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:30:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1D81223E7
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7093530082B4
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 08:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFD2271A7C;
	Wed, 11 Feb 2026 08:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bjOZcs23"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027D36BFCE;
	Wed, 11 Feb 2026 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770798630; cv=fail; b=TUl84fiBjAjMdCbJiwt0N9BbfkGbRsWWT6bsxNGk9ehtDu5QT58R3HtM0zZDbwRZTFuDcocD1HBoXl5CXAlVhcIRuTsY3t4cziza+IpXabMwVjTv6er1wkuE+RcmPpnPW1Nv+5TWcRzjRk1wH43f4f8uzr32Uxzhbn4Sa7euJhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770798630; c=relaxed/simple;
	bh=zDoIvnfbUvZBJBDIRy/pd2tNdjkwziLOHQhc1Yd8yxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RnhFQKCAr1oTAmL+2GvWZ7bMqN8eLfM+QTdtjIdURA3xXCYbP1XePB2GOtR4bP4GHOZyR/F8lqIlee9GMsu5EjqXnwnQrQvIbuat68lt50Iz3weDV28y4cPt99K1s4UJCxqJkIpD0NWFqnOQFFJhLa/b18LpEZLf0q4f7Ier0VQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bjOZcs23; arc=fail smtp.client-ip=52.101.48.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILZ8a0sxF7Nhk9dX/2fW+KwM1SbDEPaGj1UtAApy814pTC+9O9QtLLQhRaZ721j+oxYuT3hyBx7AYD+lZaQGK15JvH46BJ3n2p8QcnAUbK1n72b3/r8Gput6bKRIqn+sggahwjl/YjWhyo4zm4rB7mug4DM/mFhsbYuLSOoikfGk14iqOMjCAkYuDkSE+W+hDlwCE6UQyevs7TIvgIZ7G1ChYdCQlLfNVrjAG0C+Ee40shORedeThfVyHz3hRv9a27WogE4hvVuSRgLXUuQFTWOXRHrHcwir6/PhaWhuVNnHsOlPipo+yjaYLkodlx7UO2ZpZVKWYBMtKILQ2w2nHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhZbI1ppXovNN7J0AKRIVVn4vf2CYgUNGLkvMJGqmfo=;
 b=IUP4HHoKcAcvmBmJttTd2y55rspPnf6OFll2ZOoOmSn4aEAMlskjmzK6uZ6YkbVx8A19xuAfZsl79d9NcpZBLsEC0EqjU9rWAbankdmWnamL7B4yRW7495XJe/h9pHBWF6jYWZf/Bn8lt2z355FCbjIFwAGXEaobMbYcIRGyQbWOYyQ8+B3wZEo7Ze/afGpXSNMnXY84Uxp6WmRc9spmUIjAxO0NqMzN9Ix3viUR2YEbiPVtTZUJEvZXaaxsQb160YWF31WyUuxyl1FxLsTMx5j8nMKcV/3C8wgSj7K5vSy9Mw7UZCxyytjTqfRQVq96XZcikntOtAmFiZ3C0Dn2rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhZbI1ppXovNN7J0AKRIVVn4vf2CYgUNGLkvMJGqmfo=;
 b=bjOZcs23374rH34LTbDjNalKNnngxNuV5xFJGoqHVyPYFm2ludN9tby4ShD/BZktyPUfULFMjJ/dWj1fIm3PI7avq3UaEWbbis3F5eDy3DrQx5ac5CXBqgtQDMfIyQexi0dnIdMdlUKlGxxKuEASnv0ZO3a+oDpDYIEkXElYq6vlssw2Zqu9pClK5Lgf2eP7O6TRpgNm2Q/9TAXbQlv2rTGMHe1OWsnyvgOCMnnyGR+jVf041BLszS27En9qASMRuvAIYddwTmtBlhpOL+kcJeDaMcMnJgMLF343xTbjoNQZEb1PEEr37XQuRrGjXNsnLbdsOI1+3qTZunAq6apaqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB7236.namprd12.prod.outlook.com (2603:10b6:510:207::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Wed, 11 Feb
 2026 08:30:20 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9587.016; Wed, 11 Feb 2026
 08:30:20 +0000
Date: Wed, 11 Feb 2026 10:29:50 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests: forwarding: vxlan_bridge_1d: fix test
 failure with br_netfilter enabled
Message-ID: <20260211082950.GA481121@shredder>
References: <20260210185129.480015-1-aleksey.oladko@virtuozzo.com>
 <20260210185129.480015-2-aleksey.oladko@virtuozzo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210185129.480015-2-aleksey.oladko@virtuozzo.com>
X-ClientProxiedBy: FR0P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: b6db4122-a49e-443a-241b-08de6947cb31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?67Taa5lfswBd1ob45x7fT2fkJ9f2ubwzaD9jmAUKy1ksmvD5VujQzU6gQj6a?=
 =?us-ascii?Q?8roGkg4Ebqe5+BneTBZKkGlbcWxXzsxiLBo/2DdO8M4iSv17UCVxvTnqeHdw?=
 =?us-ascii?Q?WGnlGYeazYlzOUpzGdMIUHGQJ1smCs9CKbYUtOPodmAOlMc4MAtcx4vX9AA2?=
 =?us-ascii?Q?C4z3/Aq6QOexUeNzSam/0H+Ryen5RuGOYXJCmQ/4HnmpG91Iwhb79zdGCkRL?=
 =?us-ascii?Q?vrfUpBCGV/prH9irQlzohuxAqoR12AGEsSHBSw+EWM9IV3N59Ps9yjwdOTN3?=
 =?us-ascii?Q?17WLc+xVheUIs68wR1GQc8Jlkr+jjTaTjmv5Pin5i+FbP7v/BT2s3YME93dv?=
 =?us-ascii?Q?IrfaX56YocbZ3cuBDX6LMtyhTFhis5sybBKs1ywraXzmXjz6J21lG76nj/Ll?=
 =?us-ascii?Q?ztRQ+0ZEdPnTEsaDIDsDADgjXPsPxBreBcyzpiILkJ7xWnLTYtShy5HWA/5D?=
 =?us-ascii?Q?xccqa5PeYw3QkcxGO0GYueNVjU3YyVXUwbS7p1mLXXHwGtBGgGx9FFysdhDX?=
 =?us-ascii?Q?ahH0OpKkztkr3Y4y2UTzuWWeTyjhir8LSUYEb6pqiSFNkb7E4feyvm9xUhMp?=
 =?us-ascii?Q?8To5LCGthHzdWsHAWwPhQSDxrzebAs4U81zfx5scrURg3UIhIYNT67Tsf0Wg?=
 =?us-ascii?Q?LVnXPXLdUVClzU+QUZ66O8d+pS5ksiupDZj5/pQralSgkqfTawZwvXwbKqUq?=
 =?us-ascii?Q?Dq9gOf6otthclP5u/lyYg4tth/+E4HUjw7ARXPoMshKSUUINY0yd/poqr8bk?=
 =?us-ascii?Q?c/bayvThQ8TwLp328YcAhIUwE6J8EbJBd+Q+pGCLXXswaRe18ltLwYZxA32t?=
 =?us-ascii?Q?93F8UzYKf9OShgWvTKDaKSzWn62oW8gI4YVrCy9iyLVcO1nbSy8Ib8uu4w0I?=
 =?us-ascii?Q?GUzPvVJ/Agg9LwWMsW+DBCKr2RcRhL0RQMs0I5+5Cr5vg80rpGaxWHulRN7L?=
 =?us-ascii?Q?/ebF2nbJGaFN1U0wZovC7ku9JtNq1dHCoNTlNWyFurlV+wGD+rHjFt/vbppQ?=
 =?us-ascii?Q?xGaHDe9hDOFe8pFhP3Y/ArRXEMMpvNnyJaWdLfdhhPWdvwlQzZLwxdNplsrx?=
 =?us-ascii?Q?BFpHUsz+E3wMGxrhcg49UG68FSTELE7arq/SL+Mq8PbAXCpwfT5TtYd/hJ0U?=
 =?us-ascii?Q?RGPx41GUA0W7h8OStn/4eYm9e8Axw9C3z/t2CdmnO5JGhzZH27cZTSQ8mpMd?=
 =?us-ascii?Q?O3WxOOb0AIMBamCkczR8dj+bFg2kLgaE1fofHlm+pzo0V6STDFXw3RS7WLUD?=
 =?us-ascii?Q?nNfD7xDW2LI4iBkydyG04MDlAJHKSxDMDbO8f9v/nZ38pVwpN+VKITjM/7Ao?=
 =?us-ascii?Q?kCqX6Ms35GZaoy949MJgaHXU1osFGh9klIvkYMyUOeOeSxUUdJs1YrcSVma9?=
 =?us-ascii?Q?3Bzxi3RUvow7lKGjXakmvzbPL8NddI7cCzfxaidwg7pSen/m+R7RCwh8U82/?=
 =?us-ascii?Q?TnWdNw0zQ7orq7wl5/ATqCey+DkY0RJmtF/uYj+zCYWoz2meYCKwH3xB2Z8n?=
 =?us-ascii?Q?7jKDPYNCmt+qR33XaewgLZIrqhYe91CNvCE8ijEkb8J3W5udCl240XOwjBNu?=
 =?us-ascii?Q?4w/gnE4PXReydi4g9j4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?abUVkxVkwqW3CYvWGu/ho5FnSCl+5yc5iSr753hJuD1+D3/enTbDFIJLPL5y?=
 =?us-ascii?Q?T6JV14MoNMlrtQM4fRcQ8MlHdHg8Mtg+i2dcRhJF7jT0BP/+nqhosflHIcbu?=
 =?us-ascii?Q?X3fDsp9jnIQoTyzp6iJ8PUeIBqfdcwii7hHiv8Ha2W/+lQ8vYnjsHPhKJLzt?=
 =?us-ascii?Q?QCg+UnE1XKmvS9WMxBj8MBdNCsW3zk5gW3MLeek+Ah22YKOIX7JZqR782e0P?=
 =?us-ascii?Q?tLmiTOxSkrkbbk9NNm76v8MwzzEgySWq9WMT0tJocml5EgiKqIUFuBZEnRPN?=
 =?us-ascii?Q?HR5/qxU1nnAMIPBFulv4AZ/5kX7LzmNXwltb2bRX7el9xNJxn7NU/z2yXNXy?=
 =?us-ascii?Q?6Cw9txLvgUKg/gVhpo+A5nnybRH1KICWOeKpX6YJT3t40t1D3XhVBw3ZMEcX?=
 =?us-ascii?Q?kp/jPCRLX0mjcleXFgsPj4ymWO/ozYIOqICsyiG/swq3zvJI5MNrMU07f2sa?=
 =?us-ascii?Q?SLLeiwTDbgMYkBDBsokpFtfvNCMWQEKkZxpPdDilMfvOjr1j1FtH4vGjRkVz?=
 =?us-ascii?Q?NT2RtIbRAXlosp2r/KSQSDGQu8RH3SkzWPafgQxw7otlbON+1hm+v+ZFPw3H?=
 =?us-ascii?Q?Uxy29M/r2oXQpLQVFjOSF8wmjRxLc9B/L+C9wfKkt7y8rmEsC4eUkby2vRxs?=
 =?us-ascii?Q?j1Oo+IVTvuyGLshGx2HOVvlucNspNdTk091bdHZDr3yPFgPm5RjacMsX+dV3?=
 =?us-ascii?Q?jYuq6BobOuY29yopwcHuW8N3oe4VdI/YLorYi043RE4T2ZuofVWfVlvQolRR?=
 =?us-ascii?Q?er3gPgyBQCxmXBb+VNt0B3TvI9D7eAUZ7PH3hoLEexUqdgH5dj/mYIYldcsF?=
 =?us-ascii?Q?qr4Da4Qu7Yk76ANwwI7Cf1aJhlLZ85ZU72ou2ZGs4YgQgempLKc/CDHV4EAC?=
 =?us-ascii?Q?0dMD+pZ6oxF5idewFLPGAHH+DGUUNoAkn+b+T6gVJQNQw8xHUKdm5a17u87+?=
 =?us-ascii?Q?cB9XPSAJStVQjzI2iA45eksuiT7zVaxcqxtaX+aOK/q8qJmKFgTS1aXOYv5c?=
 =?us-ascii?Q?yPRGqX6wRan+8vhy5npkcJEQgrulLD+RGf1tFXqA2ru95qg1iomeOJYtafFj?=
 =?us-ascii?Q?zQNkF/M+NoI63oK5R8Wp72JG4CFQFfKEF1KUCz8ItAXxjWMD69vlP/BjozkD?=
 =?us-ascii?Q?JstY+xxuA3Q1Hm8z3zjh+9a+d52ktgtZ1yK/PP+q0q1FVq05s9wowkBPoFAX?=
 =?us-ascii?Q?1itG8NUIwJ9ju8kS1kWdCwdgDt8X8gIiRMpjSe+DjxgV6fTW7Cxt2kG3uvYM?=
 =?us-ascii?Q?hKRYxZFDrxX0XYKhuyCoGARdT5sYNlthO7oprlWmAmhhp4aRSK0gpBMM4TCA?=
 =?us-ascii?Q?b5rLe4+5smyel57cdMpPRBtaQRcR92+f0k36m3uXyI2fmqBp746gnQ6RiE8T?=
 =?us-ascii?Q?kowR156UL69YjUmnAyfuhkrgPPvRhnRu6sjcGXTTPuIo7RQJpqaM8ZAcqFpF?=
 =?us-ascii?Q?BCg/sO5n3RhAHmzX+eW1Eid5XghIQm68FOksDkx24pxppt1VSt+K6XHlWier?=
 =?us-ascii?Q?zbPwAPdhdO4tWe+LN50knxV17HCwZcgR5ufqUCi47LIQU7Z6PCfVTGgwqheK?=
 =?us-ascii?Q?ZrvNXE8sULGuTptSQxlKFXsjd4cJ2lLmxUpC460goIj2sCGLVmvdDbF0viZa?=
 =?us-ascii?Q?NR9/yLqCAmo/T7qtOgLaJZYHCIkasdnqFVmt7UYAnzDU208uZQmGbq8tKibh?=
 =?us-ascii?Q?fwasD+DBE8Gda3DFEV09509KMMXHMkMnzaMWTLjEy1lKbXse?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6db4122-a49e-443a-241b-08de6947cb31
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 08:30:20.7678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NC50tnu1BGoCqv5ZR9tZXoORA8trvixA1vkFJqnQsI4hTORwRkOArLD8WLMKNaMR6VclFMdbRYwUHDWp57k6Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7236
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258218-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,virtuozzo.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B1D81223E7
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 06:51:27PM +0000, Aleksei Oladko wrote:
> The test generates VXLAN traffic using mausezahn, where the encapsulated
> inner IPv4 packet contains a zero IP header checksum. After VXLAN
> decapsulation, such packets do not pass sanity checks in br_netfilter
> and are dropped, which causes the test to fail.
> 
> Fix this by calculating and setting a valid IPv4 header checksum for the
> encapsulated packet generated by mausezahn, so that the packet is accepted
> by br_netfilter.
> 
> Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>

If you are targeting this as a fix, then:

1. Use "[PATCH net]" as subject prefix. See [1].

2. Add a Fixes tag.

3. Please mention in the commit message that this is fixed by using the
payload_template_calc_checksum() / payload_template_expand_checksum()
helpers that are only available in v6.3 and newer kernels.

Patch looks good otherwise (I also tested it).

[1] https://docs.kernel.org/process/maintainer-netdev.html

