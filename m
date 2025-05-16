Return-Path: <netdev+bounces-190927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C51AB94FE
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 05:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B39B49E6D6B
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 03:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4C91581F9;
	Fri, 16 May 2025 03:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="V2pjyBOu"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022140.outbound.protection.outlook.com [40.107.75.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63D514012;
	Fri, 16 May 2025 03:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747367239; cv=fail; b=DEoGpCpmr6kPzdq8epxSLobiS3HfDgSXWPLml1Oe+dyOWs0dG5sLWKvaAhNelr3J2Bhz+WbHRfAk8NF3snj6nG9svoU8ADDZOvpQmMcJplaB8BE39fagQOOwCCOqXraS47aE4wYeNhKtl6qXPeMVDOVA715uW3kXM4K+jwZMwkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747367239; c=relaxed/simple;
	bh=jILqAkWGmDmby9cV5czGMaDBcxr/oSoSNTo8E7SFv/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RMpO8A3PItevpzPY4L4kRZLOWLD2W5wU3JIwPuQxGcjvkKXCmCfm02zDDmiukHRmpu88kIRYMEmU+wVPswuEm/eS7Rva9WfSI7xb23hmF99lFX7mWyDZgoPW8NBEhv8tvibaHC8CsLzROyghxPiHSobLAY8FtI2atfq891LjOhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=V2pjyBOu; arc=fail smtp.client-ip=40.107.75.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrV8LKUXuDUFawgZyT3PiymONXNyODbUoBvLr7WMKVLOd7FwrY7871xEmTQE1YlhMOXVkHIEx5wT7dTO8zZNogEmvOjfBmL1gU1OdZE2zmDLDDHM1t144k/mlD5mn+jxoDSYKjbOSQQhSg8bG6WiX+JhvsD8+q1VH0+UqmRSsK24qt/kQKgBmxoHesTKFrepbsRfctz+1T7vCaccUNcyHZSF85PsDRFxQS1RmbYwE6JR7we03zPZN0xr9jtcR4DBdO8CLK9HDLndR1h8DultU8H4B+ZFLL/XVGUc+Lh4VZyMG0u9kcq89DbAjw5xZmzmJvEoAUiFO7gOU8sUwoSSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPLW2rCkMv+4Czj7vrAp4oQPC0FEEUM1fN39vPF0NQg=;
 b=J4XXWIsSYXTI7wy1FX7x8PwKumP0etuoNfWgdkUh7UdA+NGDawQyf9ujdWuTIxr9eWLaDiX4R3hwPSNMsRNocmU9yCseN/YAMYeScywPkt4zLTFcM4cf/tWiDgh6w127wHdKFIf7ELi3oTaeTjwBmZ4qYz/iMOabrd+fm1Dm+2zEb7c+EwOtrvl6+DhC1xAFzn4ZMyMiwOWFL0EcstpzZkurDEIwC2bUUyBOVftFCeIilAOFhx61Vl0gXMmN8oKJaufmq52pyYDwD4Sz4XgPkjtkZi3dHqXrobJyY7IXyDv7EpvLHIr06JV2PjnTA1Zcv21GO0HRMKFfrywKllj8KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPLW2rCkMv+4Czj7vrAp4oQPC0FEEUM1fN39vPF0NQg=;
 b=V2pjyBOu8/4gfNl1HCjqyJhrey7+tIIymJX5nKsG8TwAU7BxN2vIAIm0pTqP7I1NoSctXMJcpUXmEbjx4Rsr7YZFambtOQiZVXqixf2ZOUKzvzOD2YFL+tzQhgN0GzpbPGnPV4PKIVnXcpcWHUDtqrN8bhQjG7hyLcMX61a5xGg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by JH0PR02MB7277.apcprd02.prod.outlook.com (2603:1096:990:6a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Fri, 16 May
 2025 03:47:09 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%4]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 03:47:09 +0000
From: Jinjian Song <jinjian.song@fibocom.com>
To: kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	corbet@lwn.net,
	danielwinkler@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	haijun.liu@mediatek.com,
	helgaas@kernel.org,
	horms@kernel.org,
	jinjian.song@fibocom.com,
	johannes@sipsolutions.net,
	korneld@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	loic.poulain@linaro.org,
	m.chetan.kumar@linux.intel.com,
	matthias.bgg@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	rafael.wang@fibocom.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com
Subject: Re: [net-next v1] net: wwan: t7xx: Parameterize data plane RX BAT and FAG count
Date: Fri, 16 May 2025 11:46:57 +0800
Message-Id: <20250515180858.2568d930@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250515180858.2568d930@kernel.org>
References: <20250514104728.10869-1-jinjian.song@fibocom.com>
Precedence: bulk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0127.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::9) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|JH0PR02MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a03202c-543c-4deb-36ed-08dd942c5570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|4022899009|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m3dUZeK/Vkfcn5W0b+npzoPy+WWCeJWJJbK9m9NGHAtyTwU7tzoKIvPzKdD7?=
 =?us-ascii?Q?2uxQdnkl8cAT9e2RC9+N443p/b06Yh3o9od1exkTwj+Q3Huk7mRxQyUYqvgy?=
 =?us-ascii?Q?9UNVExDeekWVgIgvIJsvqfTCoGJjh9oxw/qu7gHoD8JHBwC+n/9uW2kf2noy?=
 =?us-ascii?Q?pzR0M6MYhBTqZQy1FUuEcoe2d8Qm21m4B7hGbgVc8AHFBxDO2jjUBM2/HbM6?=
 =?us-ascii?Q?cdi7LeqdREejLKc3RuJ9xrQmZEwO8gOrduj3uzdWVaeo7nwT1uRZ94NLbQIw?=
 =?us-ascii?Q?bW7Np3uPwAgHVK/HeeBkw57xSwLW5Wq0hSONySYx+3alwBvAu5dFK+nAlvfW?=
 =?us-ascii?Q?vePlq+4HjwRJbzcUL/IHPHg03dYnwyEZLZbqPqR+n4WLbhg038Gt9N9ZiGY2?=
 =?us-ascii?Q?oCN0u4zgokQuzWVrZw70Bj5GTB3/EcQIxJagFHQuux5jggHuCPfggaJLqymM?=
 =?us-ascii?Q?fsWMzWMX0jwkWzeTbAZiygwyX2V3XsAA0/rxk5Yf0tlom2bIhNjqE1VZTF9s?=
 =?us-ascii?Q?68EtcOo2OWzVoMXtPGh+eqU8gTs5US1bPsc40l7mGd1ava/rvzLtV+CyWHjE?=
 =?us-ascii?Q?nYdjv6rdxB4GEavPuys3nn4TJLqGs+MILQU5LVc5Rcmkn3xF3GMkkACbt51J?=
 =?us-ascii?Q?PclUoPw3fOU5WWXiRbnIEunednEUzSAlTe9gc6u29ti16Hc5qRVD34K08HSK?=
 =?us-ascii?Q?1gKTRw7r7sH3ND3dul8uZxUZGogdzVkE0mamLlF+w4xIR6BFF1NKRkTYatpL?=
 =?us-ascii?Q?xoIhei6TiTebuDiPPt1hUp9u4CJOkPiBXXXpOex792xPQePSfzZCTdU4wOnD?=
 =?us-ascii?Q?ryQ29y95OR+kLuYV1QNdiGRaXDM+JLZ/pepj83d7YyQlcHU1a4AXwB5tLB19?=
 =?us-ascii?Q?UZq9MgUx4Pylifc8n8ENNKZUO3A+iz6aHjTDKZgiWAkWYuGO8DJ1hsMBe22q?=
 =?us-ascii?Q?nUpIWLTFyWeX3gC33kM00eEu3q8iZHvb84YiweN3iv+hnhCI1qbRIZVGMLXZ?=
 =?us-ascii?Q?L0B4ylSzrAmMdGH3p1NDMd5nLC9f1K/mmjPuyY1ZQB+nfo6qloh8N1ty7tPN?=
 =?us-ascii?Q?zVKufK2p1TcJd7KAzQDprsFoR5E1Jzqut6qc/mfE8nPuSSEpo9fUBojPDtfF?=
 =?us-ascii?Q?qCxYyIt9bMB0rAyoZSfn6l/fMgwmGh14IJiJUNEGl5d17yat9PsRaFEFdq2O?=
 =?us-ascii?Q?5M/lMm0VPRsduiRSdiU0sxOFk/YPtdUECHvO8CgENO0QSdYpXExdIXwhzYqz?=
 =?us-ascii?Q?xIk5HlX8mCL9Wb/VTlnyD7sxpJFkxcWYZr6u2/tKL20CtAhtbgEEyILbqvAo?=
 =?us-ascii?Q?pbDnQgdfHuJDc3GIW7vdkpOd2MbgM7b1IUjT6I5AHcuTW3bCTIZE+doGuiCK?=
 =?us-ascii?Q?thpixw8YZpCMyqWkHG3ZJg+R6nrmMnDhMO9rj/OaXZh6Jroa2E97oqBkzn5k?=
 =?us-ascii?Q?yewuZY3MGhhvMMtmDDxTEFNlT505nQ6WhofFc9ilqkU1zn4W3Wgoeg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(4022899009)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AYwLGVHfAn9XSWIcYVUCQQYsSSn/al2C2c2ArEcf5cN1zC9e9E5+Lu6aNqJk?=
 =?us-ascii?Q?HiuWRy6kpVuqHrkU3sLm4Be6xYvDQoZTRRJoPJel3rrijvKbPHWto8eYV9Zs?=
 =?us-ascii?Q?pta6Zt8XCQQY/1gP4vbSg/Gp7+OTV1g3DP8/prGjQK9ARMMNrIGBHtO4zc3m?=
 =?us-ascii?Q?fD61LV0EY58vV+as+raee/bquauvJsVQRfUVRgiY4tq1DnSeJynPVkiE9u6y?=
 =?us-ascii?Q?3lom438JBnrQC69Gh3bZkrOYHGTHAzkg7UlF+oPMouWi95MtZ1a917D/SZ9E?=
 =?us-ascii?Q?TG1XzfYvKICCk1T2jTywe70wLyUAAP4Jkuc1KPQbYOsaUsHFjQv+ToP4zS8t?=
 =?us-ascii?Q?pksfGG19qOrckuQqVAtd+tugBL+7wv1lS6nt9fxabqZhrzoZl4Zkzx7aVZDg?=
 =?us-ascii?Q?SkK/mZnQ4JrVLdv9t2NaSc311cu63uCvlSgOOjFrlwEDuyhC7N4NxgzrISf3?=
 =?us-ascii?Q?tv+XgB8kAiNk/zR2ihduHs+8WmZ+48t3VSetxVP2b8p+P65aO6GDalnGitMi?=
 =?us-ascii?Q?EBzgQpvjQFviDnzCLtExpQMPooDVeHYO8nSL+lv8jRLSslFB2CedECyozNH2?=
 =?us-ascii?Q?EcYwYJl92WJOWdg3hd6w8YNy4mAq1JgmZ5wVsJMnljVHs5LoMButIxfFaJg6?=
 =?us-ascii?Q?shegdMDovDOC+oWGJR4XA7gON4ykOiItRakyQz0AcPu/K1mHtYvEjZRY6+3u?=
 =?us-ascii?Q?4HT+VuRfzkTSjnopJYF4/olI+jDpCCKayK5lhbI0u3RgiCRLnx7S32nVkVrh?=
 =?us-ascii?Q?AK9x+X75VcmJhPErVlOCivmAgen3an09fvzRDhA29JQHAGQ2fsOyZPJv6+Hy?=
 =?us-ascii?Q?ry5usCWPUwJfWK1XTWk+mX7gEo91SVESwDxrVM6jMcYlA3dAsKgOIzZooXvD?=
 =?us-ascii?Q?tQNhOyR9OIG9+p/0Wu2pnefYNFZyW8Omzf+tujRqc+gyny9ReXieTtivaRcE?=
 =?us-ascii?Q?kAZ/js7QdS32liuoroCHnYOt/t4se6E/a5xTZBJxr7ygr6uzP4lIAhG8Bz9t?=
 =?us-ascii?Q?2VCC6MDUEytk2l40X6kLLBuhCSPbYfpfF16K1lMCy+t40UmMaQogLXRzhbBM?=
 =?us-ascii?Q?wYf27BQJfbx/r7y5HU5X9iVPBSXPgiUWXudQGeG4i+wffo1eargtwiFzeniJ?=
 =?us-ascii?Q?xmATFTakDxxafjedmbnGZOTSvj3GLJUl1hyj82HTVqespiuBazCPbgU0rHEA?=
 =?us-ascii?Q?nfDFs4siggD9ow0ohNhMN8DglJJprlKVlFLd4nqAcX/RzYjiQwzSQpm1+1MZ?=
 =?us-ascii?Q?hK+OJqwXhTa0zQPqskuuuero+9vFyDmXd44qK0ebUX0yfWNWc/T5pz/JM945?=
 =?us-ascii?Q?Q8w0HAUpYZCDUpzqzi8n6qWZ3U0W0eVMoNgKJw+GnLjjd9fv1qywcHnQ/6v3?=
 =?us-ascii?Q?PfvNsEPJBF5DPfC8BLB+4OBvKEqNoylcWbBLfNMWmAQz5Mw4v94GSlD7d8YA?=
 =?us-ascii?Q?Vrjs3NdFOgH6VwYmzbIMN2AbpUtcGJepvNneKrX8bsRc3PzFdj3yVrmtTku1?=
 =?us-ascii?Q?2HKeckDtaZH/YVx5vTpU9OAk99cpbl4EIA5Jowi1Zcwp5YwZw2IYrIAhDM84?=
 =?us-ascii?Q?utZeOWbZ6nqhef9nedIvs1uAWCCLenL0ln2/yBPjl8/ld7XDAYOAf4K52E5l?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a03202c-543c-4deb-36ed-08dd942c5570
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 03:47:09.2159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmTt5+WeWwFAMMMaP15Gz+vFOH8sUzE8tHkCugPAe+YYRYPfdJTJ9dRnmeKACA9kLFK46hsfr4PS6jb9lkZLHx4lZndGZFXcILT6oCLuejE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB7277

>On Wed, 14 May 2025 18:47:28 +0800 Jinjian Song wrote:
>> The DMA buffer for data plane RX is currently fixed, being parameterized
>> to allow configuration.
>
>Module parameters are discouraged, they are pretty poor as an API since
>they apply to all devices in the system. Can you describe what "frg"
>and "bat" are ? One of the existing APIs likely covers them.
>Please also describe the scope (are they per netdev or some sort of
>device level params)?

MTK t7xx data plane hardware use BAT (Buffer Address Table) and FRG (Fragment) BAT
to describle and manager RX buffer, these buffers will apply for a fixed size after
the driver probe, and accompany the life cycle of the driver.

On some platforms, especially those that use swiotlb to manager buffers, without
changing the buffer pool provided by swiotlb, it's needed to adjust the buffers
used by the driver to meet the requirements.
So parameterize these buffers applicable to the MTK t7xx driver to facilitate
different platforms to work with different configurations. 

These prameters are only used for MTK t7xx driver.

Jinjian,
Best Regards.


