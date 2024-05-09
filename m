Return-Path: <netdev+bounces-94908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A758C0FB0
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 14:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BC10B213EC
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 12:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A6C131740;
	Thu,  9 May 2024 12:38:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7F586AE5;
	Thu,  9 May 2024 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715258313; cv=fail; b=u8M49jIY36jGtOhiHFr/QZ5loaxK8NYCU6vVnks90AT3e/3HVriDg21fKNWzHZ6OmnYtTsH9t0dT8UgPUue7EIA9uAcFQKz+scd8pK6NuP/PXpYY6V0f43sUysomdLRqKMnazU2jqkZ4UXa6xgYxXZ6u+rGxH/zGZ6TORBh/LTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715258313; c=relaxed/simple;
	bh=acSBgNuMnzaTywu5wUlSVZkLCDuhtCHefxQMRiZeq50=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LuYCg0yJW0+TeChWJQoU2tqP0Xpy7Npr4y0vpUALXjvhGOXhIj9gHfALyKhpHRY2j4OjUMTNxpmXgV4sROneseMYCQkGfeTQf8ia6n6rsmTyOifU9dDsVhVUxAfUpWl0MAavPPvAYLYaucnTZZ2pGynxL54td5kp5H/v/VRL0tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4491sjAo012099;
	Thu, 9 May 2024 05:37:44 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xyse19s6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 05:37:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGVYCPzTxacdWR+YP418Vg2nQUQBsyyIMZ/x19jZ3+cVbwxdp/sK8XgESfdbAhr6A9p9+RGvZi2/UuYDD1ZhR1wYsZmazimhGl0rF6RaZmGzJBOGK43mzsNsiyHYs+pPiQP8oo/Ujflusg8NcLeDlH1feYCyygMV4M/4BIj/hu8oRQBsyEa/UoJoZd6IKQoDbNdp2RuxkQxRzdAAVygfJ2PLNqYxYQzgy4rXWS6OOfDUe3j3ut3eObAO10Yvyjt9FrJFlB55W3FBvzm1L9ardqb6D7Yu46B1QAUqwNJ2tVVT4e4osvHnIyh5MJXL2Xqkut/QH4BMzgXfZ3S4sglQ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rsc4fOYopYzUquYTH9FNGvLCUX+nTF6I1rCa4WR0qek=;
 b=LIQzeAZxDALsu+h32crVqtg99d+97oHTvBnViK4AThb6/DstqRusArtQoK8uqCHt1maBhq4vJK4Kuqz1vKizt+hcUX60kLR2WErv6xuKtz3ERZlWY4aU+wUQCyKELaLUAJ8X188i7T1Vfe/7SViu2Py7/mKb0Y0e4JpDP3MiSeGPEngbUEiFO6qOSUzFZwjT6cGKoXQ+RGE1hyOHgJE9MkKWen2XdXZu6PAji44u5tU2XzpVvuUkBaU2fPE68R+jtqIMwrJXgyduE4/5gd/RMjFb8JIqsEsoYtXDWwEL+eBbXCWftMNojq6b1MvD95rkD/vnlRiZ9UafHYVZYvfvTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by PH8PR11MB6753.namprd11.prod.outlook.com (2603:10b6:510:1c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Thu, 9 May
 2024 12:37:38 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 12:37:38 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
        bartosz.golaszewski@linaro.org, horms@kernel.org, ahalaney@redhat.com,
        rohan.g.thomas@intel.com, rmk+kernel@armlinux.org.uk,
        fancer.lancer@gmail.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [net PATCH v4] net: stmmac: move the EST and EST lock to struct stmmac_priv
Date: Thu,  9 May 2024 20:37:18 +0800
Message-Id: <20240509123718.1521924-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:4:91::19) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|PH8PR11MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: 94fbf0c1-9d8f-4a4b-f77a-08dc7024cf14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|52116005|376005|1800799015|7416005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?QpifwYwt9TjmcYP3Ei11cf1LFs8kyo+aW5dOu49TtNGe/RS275LZvMASzfcb?=
 =?us-ascii?Q?bg+y3tVRYaOc47FUBbsXU702I+S8m6qQltO4Upd/wwABGTRA7Dl4GiPR7ooJ?=
 =?us-ascii?Q?KpI7w9p9n9ujJ2B4Y0Kl4CYIjCQPUYjz63l+TSuAt2oSrktohlD2A8CZ9/if?=
 =?us-ascii?Q?CEQ3cA0B6q0UkSDT6No/m4mQ6+4fIvoF5OMO5WZosZ5ZUMoeDBtxOlTeMfLy?=
 =?us-ascii?Q?Jqx6k1O74fTbGa3TM9x+I7WMx910HZHljkkuhcS6pod0pZc1H8qqxYyl0SR1?=
 =?us-ascii?Q?MHUqvD+/lv5iNkeygUmyA6bHy7ilvIc76dNL4cYMokZ7jKCErbsncIojVKBy?=
 =?us-ascii?Q?ZTRoQILWIQ1TLTFiWcFMn/E3BHy41mcckDBPV8pJttrlc2J/ug3PpetcFcxr?=
 =?us-ascii?Q?6jBT8KpBvuSLnfosbrZhxR4ZG6pfck8L5wTLYckcZXNF+3Nl7vqWO6iCnAp5?=
 =?us-ascii?Q?UuH2PJ1ReuENzG6YKSYycxgLatzt10c/1+CVjeH6n9BG343ggEKA2TdYiD3o?=
 =?us-ascii?Q?n8wALA1COy8hUYCSCGzySJSj5gpBjP/1nyiFJV1OWW3Zy50m3i1InrA0+6vp?=
 =?us-ascii?Q?M2dWTLr9B4ntNGK/D6DWSEyw9Ly5lc4n7XIaSP+BYHTh6XxZ3EHUIXKKtOnt?=
 =?us-ascii?Q?kLzNfGF7f7rmSR2glTULseCPjy6S3k90xe5yuqi0AO9BbY03oA7+u+MLKPVL?=
 =?us-ascii?Q?jHVVVrYrKH9GXzxFvcaiewhZ0RXvNK1L21WRUl2OnJparfzQyTHeOpH0gctn?=
 =?us-ascii?Q?hfLaeZSd88JFRLqd1y4e/TLkY/3BG3/IytsokHpERWoSd+fS19mlpDu8KGBy?=
 =?us-ascii?Q?b+8mJOml/TUg5rWaSjpDkeHiv25qSLTVbsz1Nuo/4keMUBKxtNE+AordkadT?=
 =?us-ascii?Q?egnxifALobuPK/CaMWn6eMPHOGd0rZ6zDQJsywdfigBVv+pZVykBMRBzC9Dc?=
 =?us-ascii?Q?YRz55PFcHI8wp71kEkrIPZsxuTQe3DWwXUgDknTSa4TO3YNNOwamfBdBxk4P?=
 =?us-ascii?Q?Eo2cdsEMN5ny61Zv80EZpC9wOFPVdrgLy3+OQbdgxI5SVh1B4xqGj/EydSlb?=
 =?us-ascii?Q?wMeiq8X7kghyN27i1X1eDxYqu1keXlAlIJ/MHAeu5J2ymwKYLq0u6Ip56os7?=
 =?us-ascii?Q?8iy+qWGimGq25UfC2BHFETYPOgkKviQS5sqTUZ3TBLr+SuVghmbWFKyjlw4y?=
 =?us-ascii?Q?AfEJs5sq1XZoOVIwYDfNkRmdLZ2DKNpvCM47ac0VbKqXPRi2A96j1FQAXNTT?=
 =?us-ascii?Q?6nnr+pwO94kf2X6mciT3S9JyZGQ6xoL7ysENyH7GuLGA13PBrNe7EvnetRM5?=
 =?us-ascii?Q?55dahfKY4QLgiCSX2O7HJYD+4vk8woShhTu7DtaOSAabVne23aSixcZjsKw9?=
 =?us-ascii?Q?1yfWWnY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8Z+kFZHOA4w6l/1zcchEih/c29KHojR6wMGBEk2FTWrC+8VBEnutTLcEgEzN?=
 =?us-ascii?Q?IHxyAALVfQaQ6CMwxKgiAxKEyICUqz7HyCV1vGkae8eJZr65hUqS1idVbv5S?=
 =?us-ascii?Q?gUfbB0JsJLFEAMfeh98QUh34xEQMkWn/+0pLWUKt9ThgoybZVbTKeuoC5nzy?=
 =?us-ascii?Q?tdPWlhqMMKhhMOHdhVVPNY+In7OnTKRqNy0ukVN8J3cMCcfSuJBiwz00t0M/?=
 =?us-ascii?Q?3d9AJsgdI+7kD7mfamSBzvHYAI51IqM42xGgVqmOznOeqx2SX658MQmvgayx?=
 =?us-ascii?Q?/4X/ixB3rIsEhuqY0TMU3upU87qnh/YFko8pbaXiZcIJQokoqlBny0hNLbjb?=
 =?us-ascii?Q?ZAcuCJrVDA/oymFfCiPXJx2LUlNCzx8GsKOPcsQR/L5PlKye8lcZZwYxKWaC?=
 =?us-ascii?Q?NMgl0TOf9GypXP9DXDIjqO6m9eckVhgxOwoZI+3DZve5UO3IY/Iw0nkNL1gE?=
 =?us-ascii?Q?84WWrF7VG4vko5/T+rsfHd9fz0aFF39lmR8JeVIwLWDWvvsE+Xoo7xGTV4kZ?=
 =?us-ascii?Q?mihgoJQPh08ljjRVYf91AX4btUeD7P4yxo2md4JACviV0kcbCk+2QxgXHWG2?=
 =?us-ascii?Q?csyi9eM8vnNJI97PwoyBZXpSZbUa5LlLBT03ov/+Vx8qNGYouazGpH/gOD/r?=
 =?us-ascii?Q?mMivrsfqa39Xm38er3Qhl8np0kk1w/eOGkyMcAcKY6YHSU0qlA+tfYm506PT?=
 =?us-ascii?Q?BiugaHN8XIkFOpSbvnw40NJ0Iu+UaDhR8HxcGf8wcgxAIt4wFgSkjwiKy6jW?=
 =?us-ascii?Q?2yyJJ1VgmjKy8e37xvSg2WMvrVlzHmI3mqhU6JVZzU6/l0hhZGdU3AggUFRV?=
 =?us-ascii?Q?0sUliYZzs9zLsSV9YrR3rPix9s6sbgKKkDsEycbCPuEYOV9xuzcrYI1QXe1I?=
 =?us-ascii?Q?w91mr5c/Xc8Y2judWMUObywO1DtEE+Cq6wh7MvF2tLdOncqa0tk5hsckf/BQ?=
 =?us-ascii?Q?IjrnkxZvmLl7hVGhmup7lD1WL5LVvRgn59PyhZzQKexwl/l46IrilSb8bw2B?=
 =?us-ascii?Q?Hnbc068sBYtDHMWF8uWpT0o4DcAp1t5TZz8czV7fShlweSR373Ddx4s8qmi9?=
 =?us-ascii?Q?aUrpBrhmxv1UmfTGMPYB9NH4Wuk8oJegW1D8wXoL2hMzC5P/mn0tAB+2IVw0?=
 =?us-ascii?Q?MBTPyT7LdSB8M1tWIz7XGlQzch+Bv7OYkIvOrcZq9nJIjh43dYr5RJwoW/J8?=
 =?us-ascii?Q?TEDX/7uaY0Xhqm1baKg1klaEWKTGBbYtFGE24T4AhhmlHBXtPnT+EgcQoQT5?=
 =?us-ascii?Q?J94G1bL8gdNF2kexgHZ0leNs2+83bj6K8gCgpaEIwrDKKpLZZB2mm+8zTHom?=
 =?us-ascii?Q?YrUZ8GuSpI0hPv5MyKQ/5yjiTEA1wX2NO1uNZtK1Yo4E/Ry1v+caQvv9mA+w?=
 =?us-ascii?Q?rZR0jLwzPOjuXvxVlpDndwRELLgtOnRg3XQsrEoH1Yq/hd81wpsm2fjvtt2c?=
 =?us-ascii?Q?Hq5J7eoPH8wSz6/B7sVOHYAKWvT9RFkqvwzbLmfqP67/UdWS3SM2ZTO7UFKv?=
 =?us-ascii?Q?hKyw/oFOvMnzjzuJWV4Y+SZJk1Nxr/SFFdOiBd+XRGZxv5xxKiRUM3g7/pU1?=
 =?us-ascii?Q?at0a5GqikEZLCHm8zekcqNAHysNDXcAjdN0xr56lns/UH6qWyImSHm4zE/To?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fbf0c1-9d8f-4a4b-f77a-08dc7024cf14
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 12:37:37.7659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naDFZC1fqCY4XBL4xCYaGH/16b3DZ2h06u0gROWj6daOmGD18Kl3AC21IB2+SaGBNZJqEVGw/Hoc0AtPYl1UZ9S1apAL382AGpC6XCDdxnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6753
X-Proofpoint-GUID: iJmWH1gH07o4DWMHrGE6sV3VO-79kKPN
X-Proofpoint-ORIG-GUID: iJmWH1gH07o4DWMHrGE6sV3VO-79kKPN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_06,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405090084

Reinitialize the whole EST structure would also reset the mutex lock
which is embedded in the EST structure, and then trigger the following
warning. To address this, move the lock to struct stmmac_priv,
and move EST to struct stmmac_priv, because the EST configs don't look
as the platform config, but EST is enabled in runtime with the settings
retrieved for the TC TAPRIO feature also in runtime. So it's better to
have the EST-data preserved in the driver private date instead of the
platform data storage. We also need to require the mutex lock when doing
this initialization.

DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 3 PID: 505 at kernel/locking/mutex.c:587 __mutex_lock+0xd84/0x1068
 Modules linked in:
 CPU: 3 PID: 505 Comm: tc Not tainted 6.9.0-rc6-00053-g0106679839f7-dirty #29
 Hardware name: NXP i.MX8MPlus EVK board (DT)
 pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : __mutex_lock+0xd84/0x1068
 lr : __mutex_lock+0xd84/0x1068
 sp : ffffffc0864e3570
 x29: ffffffc0864e3570 x28: ffffffc0817bdc78 x27: 0000000000000003
 x26: ffffff80c54f1808 x25: ffffff80c9164080 x24: ffffffc080d723ac
 x23: 0000000000000000 x22: 0000000000000002 x21: 0000000000000000
 x20: 0000000000000000 x19: ffffffc083bc3000 x18: ffffffffffffffff
 x17: ffffffc08117b080 x16: 0000000000000002 x15: ffffff80d2d40000
 x14: 00000000000002da x13: ffffff80d2d404b8 x12: ffffffc082b5a5c8
 x11: ffffffc082bca680 x10: ffffffc082bb2640 x9 : ffffffc082bb2698
 x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000000001
 x5 : ffffff8178fe0d48 x4 : 0000000000000000 x3 : 0000000000000027
 x2 : ffffff8178fe0d50 x1 : 0000000000000000 x0 : 0000000000000000
 Call trace:
  __mutex_lock+0xd84/0x1068
  mutex_lock_nested+0x28/0x34
  tc_setup_taprio+0x118/0x68c
  stmmac_setup_tc+0x50/0xf0
  taprio_change+0x868/0xc9c

Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
v1 -> v2:
 - move the lock to struct plat_stmmacenet_data
v2 -> v3:
 - Add require the mutex lock for reinitialization
v3 -> v4
 - Move est and est lock to stmmac_priv as suggested by Serge

 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  3 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 18 +++---
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 30 +++++-----
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 58 +++++++++----------
 include/linux/stmmac.h                        |  2 -
 5 files changed, 56 insertions(+), 55 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index dddcaa9220cc..e05a775b463e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -261,6 +261,9 @@ struct stmmac_priv {
 	struct stmmac_extra_stats xstats ____cacheline_aligned_in_smp;
 	struct stmmac_safety_stats sstats;
 	struct plat_stmmacenet_data *plat;
+	/* Protect est parameters */
+	struct mutex est_lock;
+	struct stmmac_est *est;
 	struct dma_features dma_cap;
 	struct stmmac_counters mmc;
 	int hw_cap_support;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7c6fb14b5555..0eafd609bf53 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2491,9 +2491,9 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		if (!xsk_tx_peek_desc(pool, &xdp_desc))
 			break;
 
-		if (priv->plat->est && priv->plat->est->enable &&
-		    priv->plat->est->max_sdu[queue] &&
-		    xdp_desc.len > priv->plat->est->max_sdu[queue]) {
+		if (priv->est && priv->est->enable &&
+		    priv->est->max_sdu[queue] &&
+		    xdp_desc.len > priv->est->max_sdu[queue]) {
 			priv->xstats.max_sdu_txq_drop[queue]++;
 			continue;
 		}
@@ -4528,9 +4528,9 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 			return stmmac_tso_xmit(skb, dev);
 	}
 
-	if (priv->plat->est && priv->plat->est->enable &&
-	    priv->plat->est->max_sdu[queue] &&
-	    skb->len > priv->plat->est->max_sdu[queue]){
+	if (priv->est && priv->est->enable &&
+	    priv->est->max_sdu[queue] &&
+	    skb->len > priv->est->max_sdu[queue]){
 		priv->xstats.max_sdu_txq_drop[queue]++;
 		goto max_sdu_err;
 	}
@@ -4909,9 +4909,9 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 	if (stmmac_tx_avail(priv, queue) < STMMAC_TX_THRESH(priv))
 		return STMMAC_XDP_CONSUMED;
 
-	if (priv->plat->est && priv->plat->est->enable &&
-	    priv->plat->est->max_sdu[queue] &&
-	    xdpf->len > priv->plat->est->max_sdu[queue]) {
+	if (priv->est && priv->est->enable &&
+	    priv->est->max_sdu[queue] &&
+	    xdpf->len > priv->est->max_sdu[queue]) {
 		priv->xstats.max_sdu_txq_drop[queue]++;
 		return STMMAC_XDP_CONSUMED;
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index e04830a3a1fb..a6b1de9a251d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -68,13 +68,13 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 	nsec = reminder;
 
 	/* If EST is enabled, disabled it before adjust ptp time. */
-	if (priv->plat->est && priv->plat->est->enable) {
+	if (priv->est && priv->est->enable) {
 		est_rst = true;
-		mutex_lock(&priv->plat->est->lock);
-		priv->plat->est->enable = false;
-		stmmac_est_configure(priv, priv, priv->plat->est,
+		mutex_lock(&priv->est_lock);
+		priv->est->enable = false;
+		stmmac_est_configure(priv, priv, priv->est,
 				     priv->plat->clk_ptp_rate);
-		mutex_unlock(&priv->plat->est->lock);
+		mutex_unlock(&priv->est_lock);
 	}
 
 	write_lock_irqsave(&priv->ptp_lock, flags);
@@ -87,24 +87,24 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		ktime_t current_time_ns, basetime;
 		u64 cycle_time;
 
-		mutex_lock(&priv->plat->est->lock);
+		mutex_lock(&priv->est_lock);
 		priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
 		current_time_ns = timespec64_to_ktime(current_time);
-		time.tv_nsec = priv->plat->est->btr_reserve[0];
-		time.tv_sec = priv->plat->est->btr_reserve[1];
+		time.tv_nsec = priv->est->btr_reserve[0];
+		time.tv_sec = priv->est->btr_reserve[1];
 		basetime = timespec64_to_ktime(time);
-		cycle_time = (u64)priv->plat->est->ctr[1] * NSEC_PER_SEC +
-			     priv->plat->est->ctr[0];
+		cycle_time = (u64)priv->est->ctr[1] * NSEC_PER_SEC +
+			     priv->est->ctr[0];
 		time = stmmac_calc_tas_basetime(basetime,
 						current_time_ns,
 						cycle_time);
 
-		priv->plat->est->btr[0] = (u32)time.tv_nsec;
-		priv->plat->est->btr[1] = (u32)time.tv_sec;
-		priv->plat->est->enable = true;
-		ret = stmmac_est_configure(priv, priv, priv->plat->est,
+		priv->est->btr[0] = (u32)time.tv_nsec;
+		priv->est->btr[1] = (u32)time.tv_sec;
+		priv->est->enable = true;
+		ret = stmmac_est_configure(priv, priv, priv->est,
 					   priv->plat->clk_ptp_rate);
-		mutex_unlock(&priv->plat->est->lock);
+		mutex_unlock(&priv->est_lock);
 		if (ret)
 			netdev_err(priv->dev, "failed to configure EST\n");
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index cce00719937d..222540b55480 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -918,7 +918,6 @@ struct timespec64 stmmac_calc_tas_basetime(ktime_t old_base_time,
 static void tc_taprio_map_maxsdu_txq(struct stmmac_priv *priv,
 				     struct tc_taprio_qopt_offload *qopt)
 {
-	struct plat_stmmacenet_data *plat = priv->plat;
 	u32 num_tc = qopt->mqprio.qopt.num_tc;
 	u32 offset, count, i, j;
 
@@ -933,7 +932,7 @@ static void tc_taprio_map_maxsdu_txq(struct stmmac_priv *priv,
 		count = qopt->mqprio.qopt.count[i];
 
 		for (j = offset; j < offset + count; j++)
-			plat->est->max_sdu[j] = qopt->max_sdu[i] + ETH_HLEN - ETH_TLEN;
+			priv->est->max_sdu[j] = qopt->max_sdu[i] + ETH_HLEN - ETH_TLEN;
 	}
 }
 
@@ -941,7 +940,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 			       struct tc_taprio_qopt_offload *qopt)
 {
 	u32 size, wid = priv->dma_cap.estwid, dep = priv->dma_cap.estdep;
-	struct plat_stmmacenet_data *plat = priv->plat;
 	struct timespec64 time, current_time, qopt_time;
 	ktime_t current_time_ns;
 	bool fpe = false;
@@ -998,23 +996,25 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	if (qopt->cycle_time_extension >= BIT(wid + 7))
 		return -ERANGE;
 
-	if (!plat->est) {
-		plat->est = devm_kzalloc(priv->device, sizeof(*plat->est),
+	if (!priv->est) {
+		priv->est = devm_kzalloc(priv->device, sizeof(*priv->est),
 					 GFP_KERNEL);
-		if (!plat->est)
+		if (!priv->est)
 			return -ENOMEM;
 
-		mutex_init(&priv->plat->est->lock);
+		mutex_init(&priv->est_lock);
 	} else {
-		memset(plat->est, 0, sizeof(*plat->est));
+		mutex_lock(&priv->est_lock);
+		memset(priv->est, 0, sizeof(*priv->est));
+		mutex_unlock(&priv->est_lock);
 	}
 
 	size = qopt->num_entries;
 
-	mutex_lock(&priv->plat->est->lock);
-	priv->plat->est->gcl_size = size;
-	priv->plat->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
-	mutex_unlock(&priv->plat->est->lock);
+	mutex_lock(&priv->est_lock);
+	priv->est->gcl_size = size;
+	priv->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
+	mutex_unlock(&priv->est_lock);
 
 	for (i = 0; i < size; i++) {
 		s64 delta_ns = qopt->entries[i].interval;
@@ -1042,33 +1042,33 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 			return -EOPNOTSUPP;
 		}
 
-		priv->plat->est->gcl[i] = delta_ns | (gates << wid);
+		priv->est->gcl[i] = delta_ns | (gates << wid);
 	}
 
-	mutex_lock(&priv->plat->est->lock);
+	mutex_lock(&priv->est_lock);
 	/* Adjust for real system time */
 	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
 	current_time_ns = timespec64_to_ktime(current_time);
 	time = stmmac_calc_tas_basetime(qopt->base_time, current_time_ns,
 					qopt->cycle_time);
 
-	priv->plat->est->btr[0] = (u32)time.tv_nsec;
-	priv->plat->est->btr[1] = (u32)time.tv_sec;
+	priv->est->btr[0] = (u32)time.tv_nsec;
+	priv->est->btr[1] = (u32)time.tv_sec;
 
 	qopt_time = ktime_to_timespec64(qopt->base_time);
-	priv->plat->est->btr_reserve[0] = (u32)qopt_time.tv_nsec;
-	priv->plat->est->btr_reserve[1] = (u32)qopt_time.tv_sec;
+	priv->est->btr_reserve[0] = (u32)qopt_time.tv_nsec;
+	priv->est->btr_reserve[1] = (u32)qopt_time.tv_sec;
 
 	ctr = qopt->cycle_time;
-	priv->plat->est->ctr[0] = do_div(ctr, NSEC_PER_SEC);
-	priv->plat->est->ctr[1] = (u32)ctr;
+	priv->est->ctr[0] = do_div(ctr, NSEC_PER_SEC);
+	priv->est->ctr[1] = (u32)ctr;
 
-	priv->plat->est->ter = qopt->cycle_time_extension;
+	priv->est->ter = qopt->cycle_time_extension;
 
 	tc_taprio_map_maxsdu_txq(priv, qopt);
 
 	if (fpe && !priv->dma_cap.fpesel) {
-		mutex_unlock(&priv->plat->est->lock);
+		mutex_unlock(&priv->est_lock);
 		return -EOPNOTSUPP;
 	}
 
@@ -1077,9 +1077,9 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	 */
 	priv->plat->fpe_cfg->enable = fpe;
 
-	ret = stmmac_est_configure(priv, priv, priv->plat->est,
+	ret = stmmac_est_configure(priv, priv, priv->est,
 				   priv->plat->clk_ptp_rate);
-	mutex_unlock(&priv->plat->est->lock);
+	mutex_unlock(&priv->est_lock);
 	if (ret) {
 		netdev_err(priv->dev, "failed to configure EST\n");
 		goto disable;
@@ -1095,17 +1095,17 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	return 0;
 
 disable:
-	if (priv->plat->est) {
-		mutex_lock(&priv->plat->est->lock);
-		priv->plat->est->enable = false;
-		stmmac_est_configure(priv, priv, priv->plat->est,
+	if (priv->est) {
+		mutex_lock(&priv->est_lock);
+		priv->est->enable = false;
+		stmmac_est_configure(priv, priv, priv->est,
 				     priv->plat->clk_ptp_rate);
 		/* Reset taprio status */
 		for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
 			priv->xstats.max_sdu_txq_drop[i] = 0;
 			priv->xstats.mtl_est_txq_hlbf[i] = 0;
 		}
-		mutex_unlock(&priv->plat->est->lock);
+		mutex_unlock(&priv->est_lock);
 	}
 
 	priv->plat->fpe_cfg->enable = false;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index dfa1828cd756..8aa255485a35 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -117,7 +117,6 @@ struct stmmac_axi {
 
 #define EST_GCL		1024
 struct stmmac_est {
-	struct mutex lock;
 	int enable;
 	u32 btr_reserve[2];
 	u32 btr_offset[2];
@@ -246,7 +245,6 @@ struct plat_stmmacenet_data {
 	struct fwnode_handle *port_node;
 	struct device_node *mdio_node;
 	struct stmmac_dma_cfg *dma_cfg;
-	struct stmmac_est *est;
 	struct stmmac_fpe_cfg *fpe_cfg;
 	struct stmmac_safety_feature_cfg *safety_feat_cfg;
 	int clk_csr;
-- 
2.25.1


