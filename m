Return-Path: <netdev+bounces-216309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25914B33066
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 16:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2BDA1B209F5
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 14:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E1F2DEA99;
	Sun, 24 Aug 2025 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BrWigfq9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619B42DE702;
	Sun, 24 Aug 2025 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756045704; cv=fail; b=p3tPCBq+fxcZzXXwt6O5NiOKxstr1wDrWbWlRLUbI9pbaddoVkqQPSslXBWHrkEYT6Hgd+Jr3ReVmvSWqeQgHoyl19Ra3QNkH77EjwEYTFGzv26C67f82T89He0np67+t7mqynHXb7L2B6whGsvYwRPeQmot+6++AecXNlbFdAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756045704; c=relaxed/simple;
	bh=JNaly+Ymy4fSFH3N8Dj01APlqJjVrc1PQFEI1RvAcU8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KtfnVdXSAnB9wd/joApz2RiDyZabVrnD+rT6vFNSQbxfzdXNvgHap8/1Nm+hrnGaXhA0PfdBfV5329548KjCPL7j+h1hujDvxAJSHuojH1FpySqR4Ou/2Tum1866kw/zH3YuMvK3EVoJzLUelXDov8+8iPn3qS88MFvyNK8Jcws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BrWigfq9; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwNSP9ns5M3bwzJg6aBQrpJD9WLq5DZJcOhLhYwIF93CUJIFdaR1yYydocIhbB/c4LkdmrUj1BpEgvbnLvZ6Sf3VtlWKB7nodA0AL0u6/C49gyn2tH9JWrCZPo/cdWeYuplrEYiQyd5lurvK9WaAVxu/UUfgctOLjAJWQWiYT8KqpzFmdH9N51lWiPoSRTFY8tnUt3ZAQ9WfZPnnsOjQCmxakQ+Zd5aZT97yWWg4vUx/ICLkAxvwDiLaGFqOjUDnx+Z6olNxkJuV5ooONrC8NUE1fBzEt2nHT18FGCBHkd0OtvoRnDmAdgi+QSOnRhulp/+Fo1q0q2I82MzBSpZU8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9m4gmmy5IoD7kbxmzbE8zOm6gqxfE+pTlUqSaK7nilM=;
 b=TGiMML1vu1cByiKJUL0Uv9ZFhvgO+ekTQ+RbsnS8bec43+IyeJmr0vwUmSHBmMqSCgPU2dFj8/vcc4o2WtGTmcX2nnAZ0WKG19L7rIrSPwO1ImhGe/M+Mly/yTM1RdO1V8Mtg5xyk9BDB0rEnke6GPsWikRgWmEHyvs15wtaBvSklQUhfCBwzVgK/YPMAyBb40pYgNgjDo+NRyazwdJTNPmutSicyZaFKBUTZglfTsvD0FJp6p9vuuRBWRXQ1egHNhDHzqPtxb8Mjwl3AnFph6brORyQkU5a5liXPV7BUyMY7YrimrRhR57iOfnQFRC0P2cO/O8O7iC6IvTlR2P+8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9m4gmmy5IoD7kbxmzbE8zOm6gqxfE+pTlUqSaK7nilM=;
 b=BrWigfq9Qpo3PfXA9pJ3g/Ax5+4+L7gZctd/7VciTr5T9DdcQCSkVjgjCojTONAKEpNjYrJbL0aO5OAFJPio1hAv/gIZzh/eAVssBoLyACsUr2pwfKcTe0yXvqGB8fS5bdM7YmFTbmDZr0bmfOWVIHKXjZMjqikUb9V2wXvh5ibhi5Yw4NoOoSMFLdIa0oGPcJP5fKI+65Fu2i0959xC1td6vj9A5lt1GH+GOVdQDutlT8JyyQqaHilzJhQxHjiT2ywZb773r1+M5QC7sH1pYEqjkBZNYRHNCmVNXu3ZZ4ld5wXo7HCqhmRwuRdSyWILNIVdTkOW19eYLICWFgxosQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MW4PR12MB7440.namprd12.prod.outlook.com (2603:10b6:303:223::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Sun, 24 Aug
 2025 14:28:19 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%2]) with mapi id 15.20.9052.019; Sun, 24 Aug 2025
 14:28:18 +0000
Message-ID: <db2de992-bd46-487e-a62a-8bce50e75a23@nvidia.com>
Date: Sun, 24 Aug 2025 17:28:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 09/11] net/mlx5e: Update and set Xon/Xoff upon MTU set
To: kernel test robot <lkp@intel.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Alexei Lazar <alazar@nvidia.com>
References: <20250824083944.523858-10-mbloch@nvidia.com>
 <202508242120.QljNCAgz-lkp@intel.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <202508242120.QljNCAgz-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0028.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::10) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|MW4PR12MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c2884c-08f9-40f8-5314-08dde31a785d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tkl3UEh1OG9NZEZMaFVLVmFReWhXaUhLR2FTRWY3czN2OEpKODE1NzYyaEpI?=
 =?utf-8?B?LzFNcjdCa1VTOVNXb3VpbTVkVnFJRUtuNjhZNllXVHpGOVB5ZkRlMVdiZitH?=
 =?utf-8?B?ZWI1OUhHbHpmdVptMFB6N3VmQVNITUExNC9HYzdCaUw5VjZwQmtCSXZ3ZlFp?=
 =?utf-8?B?blArS29HWElZNXFKaWdkU2JJV1NOK1QyVCtLcW45dzZIcldlL2ZLNlIwSyt1?=
 =?utf-8?B?MTNFaGFSc3Ewb2FoZVlxT2U1cFNuWG1ObFhGWU1UNUN6K1ZDeURnZlBjejFo?=
 =?utf-8?B?S2FwUGZjMFZmd3VuQSt0c1FGMFY3ZEFKamR1T0NxVzFoV2FSWnQ2Z0puYjNP?=
 =?utf-8?B?QkppWk8vOUErdzV1MnY2VmR4QmQ3NnYrc3Y0cHpMVUZxTURIK3NsVGhWYS9u?=
 =?utf-8?B?T01JaWhPc0M4b1FoZEkvRkpEMkFuQzBZcDAwbmRQLzRWeGJBUlZpdk9sdk9z?=
 =?utf-8?B?TzVjdXFsaDJlV2l0SGFCMXZjMlhoYWhFdWhsZCtxaVhTdnFac1lGcmV4L2RY?=
 =?utf-8?B?UmdaYVRTbnViRUNmQnloN0k4ZkUxay9wNFVtalNmd0Npamlxamhka1FCS1Zl?=
 =?utf-8?B?SVZhaFhjdG5SOXNlWEFHV0Y4ajFPZ3dNZlhtek4yZ0tBMUN5TDEvM2x0Q0V6?=
 =?utf-8?B?Y1lCc1VxN2d2ZzNWTEJGMDdZb2w1cms5VmFjRTlPN0VEWVM0TFczRGlXbGdv?=
 =?utf-8?B?ZDRCNDdSM3Jwbk5JSW11akt3bVNyNnhLNmlhMy9BaUdUdUNzbjJnc3pjNmh4?=
 =?utf-8?B?TXFHZHN3cWtqQm9vMDRaWERqejBYdTQ0YjNrRDBYTFVNazJRcnhuZzE4MEhN?=
 =?utf-8?B?clVyR0lLekJyYUtsVW03UExvZStobDMwOTVkMTRGeXhMZnZha255TzlPaTI1?=
 =?utf-8?B?bkcxQUdETEh6QnJVNHRudmhjcFdZNkRBaldadU1HUlRpU1c0eUdLcG5ZUGJn?=
 =?utf-8?B?bmpaUnNXTGtxZ3NGeCtsRHE0U1AxUHlkdXVmd3lkYjdabGU0bVprVm8xVEw2?=
 =?utf-8?B?NU55bTlnTFE4K1N5T2VqaXp6bGxVQ3lPZjN0VWwxVDdqTTUrU0ZUU1NpNVBH?=
 =?utf-8?B?ZFJSNXU5bmd6L0FEZHNZdld4T3R0eWQxK2lRQTFIWjdJVmhRUnBhTU5jTksw?=
 =?utf-8?B?aUlDaG9uZXkxTjhUSVZZeW9HU0VERHdCQjg0OFg1OVlRR05CSDVvK2pDY1lO?=
 =?utf-8?B?RmdOVG0yalBLMExvRWRhMll2SWlCM2laMWxtbUpRb0llZ2U3UGwwOW9tWjJy?=
 =?utf-8?B?ZG1GNGVacDFWa1A3RGhBNm1oOEZDRXIvWXEyV3ArTHBZQmdCcTFGRVFrRjdJ?=
 =?utf-8?B?WHV6c0w5SVJreExOZkV3d2JWVFRSY0NDdjBYU0ZHTkJEaDRjOXhhQnNoSC93?=
 =?utf-8?B?em9NZWFUUnRCUFlpQUh2NHFLRnVBdlM4aXhMMjkyeHN0eW5Pc3J3UEY5akVN?=
 =?utf-8?B?UVJKem05ZmhRWkc4djJSM0pDREFRYnl0T1N6eFRMcTdVdklaa3JpcTJKUFZ0?=
 =?utf-8?B?Y2hzbWlTRnBjL3FlSFN0Y0ZjK3VGaEhDVzVRaE9TMHRvM3Y3eUc1eEg2V2NS?=
 =?utf-8?B?cWFaREsrc0d4RlRRODV2VWhHRkR0OE9yVlJ1bDk5TUdCU2pjR2xrOWhHQnV2?=
 =?utf-8?B?U0Y0Y0R2YkVXSzZHaTlNNTMraFlJTEUxS3VnK2U1VURleER1UzhEYm9PTjNK?=
 =?utf-8?B?MU1TdWxnTGlCeXIrbHBsQk55TE1leGtYcEtUdVE3bnA5ZWY3U0VId3cwWU5T?=
 =?utf-8?B?UzdmV2E4Z0VibjNZQjU2RS95K3FWaEJBRDJCbEM2bjVsSDBNVkV3bU1CdGVO?=
 =?utf-8?B?Njk2MGUvaGFVbnVDdk13NjJ0bWJPY1NCSzM4V2Y1Q2ExQjRLTno0citFd2Rh?=
 =?utf-8?B?U3dNd0JlQ1hJUlNtdGhWSlNHSGs5S3JxSGVZa1R3YUtVNG1HSnJ4VG44WWtu?=
 =?utf-8?Q?RHneAfuH+IU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEo5eFRSQnF6ZHZpbHNoQUJHdkExWm5uN0g4c0FlUFFOZ2ZWSGZKSVFNaXpM?=
 =?utf-8?B?am1heVloaHRsSUJDNXdVM0o0M3lmc2o5M0NiUjZqd1piTHB5djRXSm4yUmdn?=
 =?utf-8?B?ZlRvS3ZYMjlETW80V2hHTHhJdjYvdXNqdDdRdThieG1BZGh5NzVGTDk1TEph?=
 =?utf-8?B?TDVIN2dkR3c1cW1JZVBQckxSVWx3OW1vNTRWVjhJRWYzYlJRVUlXQkFaUmFI?=
 =?utf-8?B?VExaRlNaM3dSMGJyUzUyQm9DOHNUZ1I2aTB1VFhZL3BKQlhGSU9VUnh0VmIx?=
 =?utf-8?B?TXZpWlZuWnA2WHd3cE00dUVXZjJQREpNN1pja0ErMm9McGczNUN1TWFidmxF?=
 =?utf-8?B?S25tTHNLZ3ZqMG9WZmJ1NEdvVlJCcVhWdXJ0Y3p4UGNiL0xPNU4vTGZ5M2xD?=
 =?utf-8?B?Zk16WGI1WlcyY0xwSEQyZE9iNWFwN3h3V0ZtUmtWdjlKVldyUmsxeWNwNVEr?=
 =?utf-8?B?cmY0c0xneGlGaWU3dUE1OUdjMVV1aDZ1NlpYa3FNNGFlbTFLRFBOVUdyWUFq?=
 =?utf-8?B?L0Y5KzUwWjJGZlI0WVlNQ2tMV1J1Qmd4MHZoZm9EcEROdHI0Z0tXeUNsWkc3?=
 =?utf-8?B?M3dHdEVSOWVZc2Y4VXo1WUkrVWJaQmlkNHB4V1cxWEtGMnBhZUJWSVEwTzE1?=
 =?utf-8?B?aHRGOEVxenBPWUlNdDlzaFh0a1JpSk9DMHZvZjFsdjByalNXRkRpL2NMcXA2?=
 =?utf-8?B?NmowQ0l2OTM3aXZBZHhoSFllZHFUZDh0UVFsS21tMTRiQmVBRUszcHJEN0Nq?=
 =?utf-8?B?Zkw5UkdaNnRTUi96V0VMd09MNDVUUjRYS3VEbUxFUmJ2WElGTE16SksvbXVD?=
 =?utf-8?B?VGQxTGxJVnlYd2dMaUsrTXRSb09Kc1RMdEFiSVB4bk1iOU94eXJXWGFtSFlE?=
 =?utf-8?B?MTJHUlBhaGZCd3BDTnZTRnBBbys5ZHpzVHBaWW9HV2o4UlA2OXdrKzFSTy9J?=
 =?utf-8?B?RmdhUHlFbWdQdjdTZnk4aUcwazZzWEtnZkZmZG5tdEdtb0FRRGtnczZDV0h0?=
 =?utf-8?B?L3JTdnhZZjd2eXFwNGl5Y1BJRGtNbFJ3N2VhNlg4WlZkM3hqVkJvc2JkY29w?=
 =?utf-8?B?SUNMbmV3VlVUZlJISFJVRVlSUjRHZ3hQMWhFcGc5cUlPSld6WVd6V2JRdjYx?=
 =?utf-8?B?Q1c1dVNadlZPL0N3QUh4QU1yWTVOVlI3Tm53QUVwbmtma0hNR2hIRldVaC9R?=
 =?utf-8?B?VTBLUndwa1BpdnQzWVZtNXl3OVV6ZGZFYi82eDh1dnNFQzkyTkR3Skc5dFJS?=
 =?utf-8?B?YlVxQTJtZkpQd0VSQlltRS9ldTNSbGZjblAwSXFDNVVqNTlJUDNNWmhSUFhH?=
 =?utf-8?B?Q2wyUGRCTXZyT0dOMFJtTVRQVk80ZEs1aHR5em4wM01QbysyMTMzUGlMUm5q?=
 =?utf-8?B?UzRvQVlCZUxyOFkrNE9EVWpyQkhoZkxnSEpxM3dMa0ZDeWE1T2o1TTJmdzVO?=
 =?utf-8?B?VjVDeTh6VzFYYkNKbjJGS0cvWHJ6QXZOTWpCTC9mZmhnQml2cFVOODhDN1FW?=
 =?utf-8?B?VXhCRTBSNWNyUDJRVUhpY1N4TTlseHZRMDJCcWs1NHB3U2wrekxwUzJLS2Fj?=
 =?utf-8?B?RVhaTnQ5UHVPNHJpZnp0dlFUb1VJVjhnM2ZYZ0taTGM2cjVIeHo3RE4vQW5K?=
 =?utf-8?B?QVpsR2wzVmQxOXV2S1hNU3UzV29WWnRZYUU2WGZ1T25yaHFwSWZZUitORlZ1?=
 =?utf-8?B?eVpmOFAxS0JJS3QvVTVrWXhNU1BsRkY1dDVJeXRxYVI3anh1MENUWmRaQ241?=
 =?utf-8?B?dXRKOGx1bnZnZzFFN0tlZkdGd29BUWo4ZG9lNXNhTnBIRGEyUE4vNnFRR1p0?=
 =?utf-8?B?WHJMa0NucXY0OTZGUzhUWXl1UHBYdTVwRjcvYnhZYm0rcFRJYTFIb2FPYVpN?=
 =?utf-8?B?Vy95SGpPZHpGRGVjcEQzVEtiR2ZtSTNEL0M5N04zdVplT3lIZXRFaGd0blpH?=
 =?utf-8?B?dWRLS25DVWI3ajBUbnl3WmhMcWFENENNRGp4V0NGTU5tZUtFWndXY1RlK0Zo?=
 =?utf-8?B?ekhMNCtGd3hkTmlTSkllTmV1KytzTWg3SEFHSEQwK2pWRUxzRW5BZGs4ODQ2?=
 =?utf-8?B?cG5mcVpSTEdmTlAvbjRzdTczdFZiUVlrSEhvdlhYaEZ2UHhmaTBzVmtJaE5k?=
 =?utf-8?Q?JvE3/5iKcQvoYbuMXjFeUr9tH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c2884c-08f9-40f8-5314-08dde31a785d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 14:28:18.7779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13R9u78kwyqFP03VcfYyQpc+YiFEtPP9StcPJUyIRoGM6Y6dJ9I5h7CHaiSSdEVL7FGb6H/z15H03ziESwcnXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7440



On 24/08/2025 16:54, kernel test robot wrote:
> Hi Mark,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on ec79003c5f9d2c7f9576fc69b8dbda80305cbe3a]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Mark-Bloch/net-mlx5-HWS-Fix-memory-leak-in-hws_pool_buddy_init-error-path/20250824-164938
> base:   ec79003c5f9d2c7f9576fc69b8dbda80305cbe3a
> patch link:    https://lore.kernel.org/r/20250824083944.523858-10-mbloch%40nvidia.com
> patch subject: [PATCH net 09/11] net/mlx5e: Update and set Xon/Xoff upon MTU set
> config: um-randconfig-002-20250824 (https://download.01.org/0day-ci/archive/20250824/202508242120.QljNCAgz-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d26ea02060b1c9db751d188b2edb0059a9eb273d)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250824/202508242120.QljNCAgz-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508242120.QljNCAgz-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from drivers/net/ethernet/mellanox/mlx5/core/en_main.c:34:
>    In file included from include/net/tc_act/tc_gact.h:5:
>    In file included from include/net/act_api.h:10:
>    In file included from include/net/flow_offload.h:6:
>    In file included from include/linux/netlink.h:7:
>    In file included from include/linux/skbuff.h:17:
>    In file included from include/linux/bvec.h:10:
>    In file included from include/linux/highmem.h:12:
>    In file included from include/linux/hardirq.h:11:
>    In file included from arch/um/include/asm/hardirq.h:5:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:12:
>    In file included from arch/um/include/asm/io.h:24:
>    include/asm-generic/io.h:1175:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>     1175 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
>          |                                                   ~~~~~~~~~~ ^
>    In file included from drivers/net/ethernet/mellanox/mlx5/core/en_main.c:52:
>>> drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h:79:12: warning: declaration of 'struct ieee_pfc' will not be visible outside of this function [-Wvisibility]
>       79 |                                 struct ieee_pfc *pfc,
>          |                                        ^
>    2 warnings generated.

It seems net/dcbnl.h is only included (via linux/netdevice.h)
if CONFIG_DCB is set. We've tested only by not setting
CONFIG_MLX5_CORE_EN_DCB but left CONFIG_DCB set so it was missed.
Will fix.

Mark

> 
> 
> vim +79 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h
> 
>     68	
>     69	#ifdef CONFIG_MLX5_CORE_EN_DCB
>     70	int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
>     71					    u32 change, unsigned int mtu,
>     72					    struct ieee_pfc *pfc,
>     73					    u32 *buffer_size,
>     74					    u8 *prio2buffer);
>     75	#else
>     76	static inline int
>     77	mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
>     78					u32 change, unsigned int mtu,
>   > 79					struct ieee_pfc *pfc,
>     80					u32 *buffer_size,
>     81					u8 *prio2buffer)
>     82	{
>     83		return 0;
>     84	}
>     85	#endif
>     86	
> 


