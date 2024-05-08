Return-Path: <netdev+bounces-94393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 394DF8BF532
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 06:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 990D9B211C4
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 04:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB5F156CF;
	Wed,  8 May 2024 04:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="jrq7v8wq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C126D11C94;
	Wed,  8 May 2024 04:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715141863; cv=fail; b=QanyuBrpguszGCLm62Mx8H5lAgxerQVH9FbZAEUyTW0YTXmiS60eP4rQ10KFM/gDD5721q8XnLX37b7JCE/XaRVtH13aYXSDJXmRflBlxB5FVc9LLecEHklynaLWu69JOT8n8JIzvBRi5zsatbhB4DUrwtDm2jApnU/cXy0sFas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715141863; c=relaxed/simple;
	bh=VI5w1QeAK4QZ2VVi8ixjebvGwff8ZQ09WeF3RQ8Fwmw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=StUL6a5rckfBb8F5FQW9f8M8Tixie9Y+08iMLnAA3MAHP2g1h4durgVW9W/oa9jN1ZkOw4Awdw77KWDgeKNviUiMjObx+SDgycYeWj8qoSBy3mYpqOfRbP2ZS1TKfrITERZud0v8lLuL81hnkU9vXUNec/hxGXmJqigqyEAo/sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=jrq7v8wq; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 448402d2028595;
	Tue, 7 May 2024 21:16:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=Ob8RHHchYDgTv/TRjM
	vEA5k5ev82B4JaVsJQ6G6bMtA=; b=jrq7v8wqu35hWE+vNoN42wtQtrxlFlsptL
	wjetPJNLxRhNrYUGFJJthlRmwZ9EoSs96G2v1rRPBRSnSjCeXlQoPCzqWlwLmqla
	Wktt07xMvZ6b9o/InXyqTpN1oMyGTm0JvAgQMDLXVypXQf01n0f35ozy0Ge1U1Y9
	epZaroBe63LjTdCJomeEIYmFqZxWuFgNp3xdbcZKFDx0v6X3A0Y/LVe6kWe4MgdM
	zYAjmAujbcGpqdGDi7Lc6w8vEOMFOsqhWxAdpybl1un8BxtIyfK7tmBRvUkAV8RS
	wroagjz3lLSXsut7xbCiyDSZfx1rIuwCj5PgXQY/dVS9/H0S51bA==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xyse1gdmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 21:16:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xo48KnvJj58ju3BL9koVm19CJjqcZ1A+NTWZjfTXxDLwvJUmz0g1S8dZCtHy/RJ3kSWfd69JYKo6h2v1BU651VF+iNTKzuSjUKfwV2uEv8d5MbBvGPp7qvGQ4QOAvGK03dRQpaZwsBH9Grrvg0QkUcNEEEupzIfg9A6P1aZkXxlutsEtJwgeq+pm8LbWEq4z8Z+nEHMJ9JNOOU+MqsS9GWRZtW0v18s3KeQZ04BGC51MI2ArulIbD8jTkFSo2UBszdq5I5hsOSo0I746yy9pEfeFTEMFX/QD6b/ouqpnM0zATi9w7GQXGVtTEregI9PTLDAZbbRUn2CITTciAFyAog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ob8RHHchYDgTv/TRjMvEA5k5ev82B4JaVsJQ6G6bMtA=;
 b=JGF0/YfCae4Ml/G2NisWpXyyXlRoMPz6ZFSpRWf9OO9Ii3vMf3Nt/vGOiWxpMwbpNDS2t4vI0lkoFvfNTo1Pt3UrxxNQwgxiQ3L5rrpqv1nqGfcOA9FOS83BESYazDhaDtKkyg7Oy2NcgSYjN5WhRsl9mLgpxM5ldHD2H78TE3OHFM/1r4BoesrFM6mvFGUQLneUlUvbPnM6Syf0FBaKMJiaejUl5TpvuhCAsRS3MR9QWGBGTup0KEgRNs9PliQxr5ASvqMkwinQ5myp9TV5O+qTDGqsMrtVlRy3VZYjr0/4rlUG9rdQFkAd1lc91FLZLJCPByqSgN9z/QyylqyVWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Wed, 8 May
 2024 04:16:30 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 04:16:30 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
        bartosz.golaszewski@linaro.org, horms@kernel.org, ahalaney@redhat.com,
        rohan.g.thomas@intel.com, j.zink@pengutronix.de,
        rmk+kernel@armlinux.org.uk, leong.ching.swee@intel.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: stmmac: move the lock to struct plat_stmmacenet_data
Date: Wed,  8 May 2024 12:15:57 +0800
Message-Id: <20240508041557.2394088-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0108.apcprd02.prod.outlook.com
 (2603:1096:4:92::24) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|PH7PR11MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: 0370b2ba-ab80-4185-fa24-08dc6f15a35a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|7416005|52116005|1800799015|366007|376005|38350700005|921011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ayRZCEtn44xY7VDYkKHVPL3lQvZDignv1ynQBsslkmEO9H21EjvMxmYLYHOF?=
 =?us-ascii?Q?596s7uVUFbK+Za4mo12G28zqQwA945aTuVo91r1pnAjRuxFO/10B6ao6Nbn7?=
 =?us-ascii?Q?3V68KoQ1CyZfj7roHVfch/6jwdqRpkM8v2tRZHzQu/gWN6KIrwmmqoyAGE9c?=
 =?us-ascii?Q?WdYD5y++g2bdB0I3358kM3IcOh1tIxHDE6xLSm91Z/WLkxyRZFgpON2LHghV?=
 =?us-ascii?Q?tarES0c+yZNYHClc0Wszw1pwohxjq00YblO21aG8oA65dUD48JsaUI0jmEZY?=
 =?us-ascii?Q?fFc6csOFL91b9W4z3vdbS3loYn6NwGUjv/EgzYkLHip1RY6ZjPI6RZXcYaMZ?=
 =?us-ascii?Q?xW8AJRoMXTCOQI/YPNjzaBAXks0E5DeoDRQOlobPzDbGpJCPie34Fqre+y2a?=
 =?us-ascii?Q?FQqdm9cZWGFuC4ctO6erwIDxhOuFoyYo7A1BNoZcGoz9X1v4Vo2CZJ/yHTUf?=
 =?us-ascii?Q?v/eUIsbGEoRubNtSjvN35QtsZw1T32BDexeiw4rjoZYDflrC2VpHPb6m1FTp?=
 =?us-ascii?Q?svTV9+C8267hz1mFuuJ0/kYCeNrUI9+29SU3hdt+X7egOWHNiT2VhFBokaS/?=
 =?us-ascii?Q?yT1p1j0SahhFC6W07LuxCYfHeBz6LI7jznslJhR5rHZScHIjsNI75d83ZKuH?=
 =?us-ascii?Q?JGw11OgmiOEQhsOonigIionGi8zrrRuRPT39Fux7H2ztivMnPzpta0IrgV8U?=
 =?us-ascii?Q?o3XgLJd7rmwz1u3iAg+B6b/mPgP9NHI4MQVh8jipNIb+eYz2hkU8r26dyrk3?=
 =?us-ascii?Q?6n6kZKIC5bxHahzdaEwRmbEqHzCdkS4wpRwVkjCJeQS0anjSK6/5Wkm1QsBe?=
 =?us-ascii?Q?iEINUUIPd5i+P/2RDRbkEa2JB76KJgLC2zDbV9MdUXrsJxbxr+Xi5vReY6+I?=
 =?us-ascii?Q?uah+A4fMVGzzUBOE+Si+ZsScW/PYGNpMm/Ot+pTWcPRG3F/zEowTgH2KH2zI?=
 =?us-ascii?Q?QT2AbQiLTHJC7ywBuJiw1vBSKJrNSHORF1S8jwrWY4pgDVzFrp5PhCF3mYjo?=
 =?us-ascii?Q?ElkmTJWio99JAU8iuefiiUbmbi/hZueHDkEI2+vQxH0D0u2wZELu+owc/Yp3?=
 =?us-ascii?Q?7TtTpcusSPFscc+lhPHH3zgL92KZNjhE2h5SnnG0Bcb+9poGex5Wdj1UuzQe?=
 =?us-ascii?Q?cUtkrx/h8XRz1cI4bYUm0bhVzGiDaKrrBl9N+bqSvSxAY9HIB7RQ6XOsbcI/?=
 =?us-ascii?Q?UeG3vhvgQI71r1Z/Jcy0zJoUL45BwdOiO0nwDrGniw5w39y5QOvIUgWPwlDi?=
 =?us-ascii?Q?yyFha4sCvDoPuzhw23+cwKjvRk270hW4I+eC0BwrKIS9azfMaFurDbURvP0b?=
 =?us-ascii?Q?+gzJrduuk8v0tn0bXS4pIRDSpwqwk7HN4T79nQ5ieAFiLqDJboktZn518SuB?=
 =?us-ascii?Q?3Pkgea0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(1800799015)(366007)(376005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tUG9eY24Cfq67VBli6F1fm8zbp/W4vGt9mb/02xKWJyk97q6mAxufjnei6uB?=
 =?us-ascii?Q?VszLdQ6GO+m6LLk3rFmajRrYsiXL7UQ4/bArN2MQ/KdGXDWwZcM2a/UmwtH5?=
 =?us-ascii?Q?AhBcDLmoD2mCS3dJB96xzi3TVym1ulm6ublWMANkOVeWtZNPXs+sw9xyF1fX?=
 =?us-ascii?Q?VIroNZ5YnvMzWmQKDY6WywIDGu9FibLuYvmbRWJwcOc5bZRPgchNDIJChymd?=
 =?us-ascii?Q?7T7d+InbQ3Lgjt6RJBBz5h/rNG4pyW8KOCEVR3EpHY9+zA3i/rP/pOD/PUFI?=
 =?us-ascii?Q?FgL8zeYOBFjfOrHHoLpsmdEqaNM6ooD39rRHhXvBpbfV/Ad6hOlJpne9odH/?=
 =?us-ascii?Q?w+lldAWt1HIwamMA4jaIQBj1CQrEBGY1lQweXACPC7V/Sp3J0kVqAkWAAvmj?=
 =?us-ascii?Q?5PKUNFR6OIQUcuXyYrlUFnrgcb9gAV7Swk+Mojguz8EmCkGMOeVbfgwsGYdW?=
 =?us-ascii?Q?mKzPg1g06z9PRCxEtCYwzzPQkGMZv/Lr5yWCguUejEqDV8qgoxAgbeombJf1?=
 =?us-ascii?Q?sDawJhGhKjQYRdmtth//qSREFzDJI5QL3xsbhpJc03Ktw2vcTyXidqSPboit?=
 =?us-ascii?Q?tLem/hGTcHggSZPw5zDZ7bFiMlZWpCD48quxwfGxp18W7X5HyqhNgztYq6TK?=
 =?us-ascii?Q?QUKTq000nT0Q2UIu1Fy+TvXsWtZsHNpWMUGXzYtvGS6Ei7aLcgOTeRB2qvX6?=
 =?us-ascii?Q?g/Gfq7MJxbi0jrqlrnOnvDU12JrKxJ0QosUARZuPGkGReQhsOaFT6GVGxGFS?=
 =?us-ascii?Q?cD31vGbFveCMPPYFKbyM6hCFj/cvulRvgU3Ig5q0aSNdICeNkqDn9+fHU0vH?=
 =?us-ascii?Q?0Lsn2UrSJclrQ88B+VjDzTa/G/VCPTABeSDZHWYcj9g7gXZnlBYHfXG4JBK7?=
 =?us-ascii?Q?rtnucsVFQVdht9uAt9pSqzT2iD0FWsfo0D59AiDUq/UoM0lb4NSOiQXI/hYq?=
 =?us-ascii?Q?LbqTV4adn454Tqk+/I6MejO6vzvnpLyhs8HAdga7fi/d+LmEADVQQUR6Tu8c?=
 =?us-ascii?Q?8ovtLQdW629Pb02cmDBtLmnU/JqtGP5ela1qs5wLDcxnVLTLCd6QTfyQOPY1?=
 =?us-ascii?Q?0t2+7g+RLqNhxVe2eCN/YLh14lP3SSu1eLffRSr1mufbY37EHrw7qlYnJ8eQ?=
 =?us-ascii?Q?C+wuseHJyeY6SbKFNlpk7mtqvYSlXXGoXcRafw1bV8KG0yLlMfS76/7IIsaK?=
 =?us-ascii?Q?Hja0d1H0Dg5J41Ifn38s99YufZOBVgwBl7ZqtgKjE30cfrV1YLdUUrfVfQr8?=
 =?us-ascii?Q?jmyK4lzBgLzDrzQH4AxsoieWZqK3/sS6WBUEEiVtMFKfs9uxQzO8yILoJFwX?=
 =?us-ascii?Q?LuVgjzrIrn1S7dyeta5wINm8cgN/fSkBRIqVO2Dklu7qlWwUp1rxdamB9kYx?=
 =?us-ascii?Q?atnUWcFxpPd4wopBzXrNwQjLBy8tHhcdOkab5muPaF7AA1H0usxeT8f7pZ41?=
 =?us-ascii?Q?ddrzF7OldeKmuz3F3NOd0rnjYtSI0jq9LRu0MWln/JAFFmZwSfRe/Cduewgo?=
 =?us-ascii?Q?TcgKSeLoVB7Opxo0Hc4Kf3jWCqj6xyIJEq73KkONWjyvFRHecEUb5StWPmTN?=
 =?us-ascii?Q?1L0xsCTO1pxklUZUpZPeqgqUX58u6yMuW3Sqr9RVIlMoEbo9tZwbYNPkorvN?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0370b2ba-ab80-4185-fa24-08dc6f15a35a
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 04:16:30.7165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NejyfG3LuIoutq+VNwY8PulwuU4Kt6weDoTog6XGBKoBD+3MmQlc+OYbxro1n9kF7EUQ2IXuxCIeK8JCU35wZtL5rU4cBSzlCrFbVqATQKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7964
X-Proofpoint-GUID: ZFXJez9CeipczyYwhK2H7tQ9SRrJUs7h
X-Proofpoint-ORIG-GUID: ZFXJez9CeipczyYwhK2H7tQ9SRrJUs7h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_01,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 clxscore=1011 lowpriorityscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405080030

Reinitialize the whole est structure would also reset the mutex lock
which is embedded in the est structure, and then trigger the following
warning. To address this, move the lock to struct plat_stmmacenet_data.
We also need to require the mutex lock when doing this initialization.

Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
v1 -> v2
 - move the lock to struct plat_stmmacenet_data

 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c |  8 ++++----
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c  | 16 ++++++++--------
 include/linux/stmmac.h                           |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index e04830a3a1fb..82b7577fea9e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -70,11 +70,11 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 	/* If EST is enabled, disabled it before adjust ptp time. */
 	if (priv->plat->est && priv->plat->est->enable) {
 		est_rst = true;
-		mutex_lock(&priv->plat->est->lock);
+		mutex_lock(&priv->plat->lock);
 		priv->plat->est->enable = false;
 		stmmac_est_configure(priv, priv, priv->plat->est,
 				     priv->plat->clk_ptp_rate);
-		mutex_unlock(&priv->plat->est->lock);
+		mutex_unlock(&priv->plat->lock);
 	}
 
 	write_lock_irqsave(&priv->ptp_lock, flags);
@@ -87,7 +87,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		ktime_t current_time_ns, basetime;
 		u64 cycle_time;
 
-		mutex_lock(&priv->plat->est->lock);
+		mutex_lock(&priv->plat->lock);
 		priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
 		current_time_ns = timespec64_to_ktime(current_time);
 		time.tv_nsec = priv->plat->est->btr_reserve[0];
@@ -104,7 +104,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		priv->plat->est->enable = true;
 		ret = stmmac_est_configure(priv, priv, priv->plat->est,
 					   priv->plat->clk_ptp_rate);
-		mutex_unlock(&priv->plat->est->lock);
+		mutex_unlock(&priv->plat->lock);
 		if (ret)
 			netdev_err(priv->dev, "failed to configure EST\n");
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index cce00719937d..f1e4d755a484 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1004,17 +1004,17 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		if (!plat->est)
 			return -ENOMEM;
 
-		mutex_init(&priv->plat->est->lock);
+		mutex_init(&priv->plat->lock);
 	} else {
 		memset(plat->est, 0, sizeof(*plat->est));
 	}
 
 	size = qopt->num_entries;
 
-	mutex_lock(&priv->plat->est->lock);
+	mutex_lock(&priv->plat->lock);
 	priv->plat->est->gcl_size = size;
 	priv->plat->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
-	mutex_unlock(&priv->plat->est->lock);
+	mutex_unlock(&priv->plat->lock);
 
 	for (i = 0; i < size; i++) {
 		s64 delta_ns = qopt->entries[i].interval;
@@ -1045,7 +1045,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		priv->plat->est->gcl[i] = delta_ns | (gates << wid);
 	}
 
-	mutex_lock(&priv->plat->est->lock);
+	mutex_lock(&priv->plat->lock);
 	/* Adjust for real system time */
 	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
 	current_time_ns = timespec64_to_ktime(current_time);
@@ -1068,7 +1068,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	tc_taprio_map_maxsdu_txq(priv, qopt);
 
 	if (fpe && !priv->dma_cap.fpesel) {
-		mutex_unlock(&priv->plat->est->lock);
+		mutex_unlock(&priv->plat->lock);
 		return -EOPNOTSUPP;
 	}
 
@@ -1079,7 +1079,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 
 	ret = stmmac_est_configure(priv, priv, priv->plat->est,
 				   priv->plat->clk_ptp_rate);
-	mutex_unlock(&priv->plat->est->lock);
+	mutex_unlock(&priv->plat->lock);
 	if (ret) {
 		netdev_err(priv->dev, "failed to configure EST\n");
 		goto disable;
@@ -1096,7 +1096,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 
 disable:
 	if (priv->plat->est) {
-		mutex_lock(&priv->plat->est->lock);
+		mutex_lock(&priv->plat->lock);
 		priv->plat->est->enable = false;
 		stmmac_est_configure(priv, priv, priv->plat->est,
 				     priv->plat->clk_ptp_rate);
@@ -1105,7 +1105,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 			priv->xstats.max_sdu_txq_drop[i] = 0;
 			priv->xstats.mtl_est_txq_hlbf[i] = 0;
 		}
-		mutex_unlock(&priv->plat->est->lock);
+		mutex_unlock(&priv->plat->lock);
 	}
 
 	priv->plat->fpe_cfg->enable = false;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index dfa1828cd756..316ff7eb8b33 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -117,7 +117,6 @@ struct stmmac_axi {
 
 #define EST_GCL		1024
 struct stmmac_est {
-	struct mutex lock;
 	int enable;
 	u32 btr_reserve[2];
 	u32 btr_offset[2];
@@ -246,6 +245,7 @@ struct plat_stmmacenet_data {
 	struct fwnode_handle *port_node;
 	struct device_node *mdio_node;
 	struct stmmac_dma_cfg *dma_cfg;
+	struct mutex lock;
 	struct stmmac_est *est;
 	struct stmmac_fpe_cfg *fpe_cfg;
 	struct stmmac_safety_feature_cfg *safety_feat_cfg;
-- 
2.25.1


