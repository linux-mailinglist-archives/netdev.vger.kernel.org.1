Return-Path: <netdev+bounces-94399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6278BF55D
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 06:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66041F247A3
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 04:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710F012E7C;
	Wed,  8 May 2024 04:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="V6fubQfN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5216A10A1B;
	Wed,  8 May 2024 04:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715144053; cv=fail; b=U/BosAU/kpHznU1FwlapmEkMBwiKu/c5fEFlMr6+nXO0LCw4MLqQL5E4MRxMASZc5PxaH62rYC3qDn78/Q4rJFf+xk82VF5zBHlb9Uv9/roPAQInxrB2db49r5We1Mo9ItEGh0PZEv1bnldYmhxF06KRuqOIZL65Y7XT3n/we1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715144053; c=relaxed/simple;
	bh=LzQWCtzROssnczURXxm6oxwlvBr3zymwAgcsmGmfmlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=s2Oznhk+M4zGAr+1MsL0YfIj2BZ7xn3llxsTx7JTwZthLsC8E2RUMxordXVze1Hrb9e62Nr26QEt+MMaD2K6zc0pS5qSVEJ739lX8bqZbzHQxepP1oTx3TIfOzLDSb9K3PX6owlT3+y7GeVMZgicvOiMhm4AZGQPIupfg5b24zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=V6fubQfN; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4484LqQS014996;
	Wed, 8 May 2024 04:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=O497/cvBuJgZWKGzbA
	Awyuxg6obn7rtJENLNPqoCgl8=; b=V6fubQfNG4ClWr7boEiOyHjHPsNgFfxstZ
	/BGDknS6+E8TWtuh3Fr90mz3V/pZ66oSz7rvxlROYC9fTb/P0kDj1ad9Js8bJ/xA
	60YvDhr6mQEjV9aHxM7IQFYtp8K9CfbNlzXcvDeQV5TV+6czZElFSzexWVePfWI2
	grZ+ArnoSHTqWBCagzHkIqcGdJcl0bC1XTkU58uQ/sj+wPDIMubma2ICMnDPjNTW
	I5ADPZmqcQcoBJ6io4s0sXaSL6hajDKSG9xKhmgOkSgU3epQfFHJRjF/SOSGYXcN
	xuh4rC1iKkYn28NsVgqbchT+JVplGDnnV6ABd/v56LnmhSCU59Ow==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xysn50dua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 04:53:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4Lp203upYDXgjpnkRUxEIp5J/g6kee3J3mbXjySIEQWZcrGD5+6si5CNZWJIxrPhi0PJlOZ78phBlZfTkIPi1++aN4dwtGdj8zChYoEOscVc0goCtWOXEjUuQWR53Ae8zrJGZLsncRVp+IG1Syz9yF8zS3tJGicdoiFaI55P8LAfA/OHf8cuw9F10ds92aYRfH8WQ86Rks9yinlxTPS5k1tQ8CfjKFoaXJ9H3R6eE0jYolRUY/m2nMJqzHc0MNXiXhdgHq0E+xwIHkHSVjOPE7IV23LuKgv7lur7uGAr4OZ66sw34Wwl9cOMnwBqlayHGAjonkUMjpB/oz6Jwz5Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O497/cvBuJgZWKGzbAAwyuxg6obn7rtJENLNPqoCgl8=;
 b=VNGXGb2tG0PhKaotkZD5Ic3w2K95tE2C6G54reH4yRgLEDMh1BJTH2v0tL9gS8igM4fuv2yfPCSCrYAUA8MbSd2Xx62iO3enYzpwN4df/Zqzp3xE0IfdpKOuILPpGtZ26n3gK1rIaHcJdBpZeVgWJya77RqUMgdHORQEcI3nWGO60SZngdIXW1eMSdwjh1iZ+5GIolIwbXmAw8XDZj4ggzErHdyZDqDohhAeL7Myl1SsvKbAe4uGgU8rdGAKk3VPw6nsUmvPtX/qX0hUwzJhew7i102F3yD/XDWzTpKiogpyQQepBFXdWoCjh2rPt44xzyIQkdgDikfwLvVVw45qCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by DS0PR11MB7829.namprd11.prod.outlook.com (2603:10b6:8:f1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 04:53:16 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 04:53:16 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
        bartosz.golaszewski@linaro.org, horms@kernel.org, ahalaney@redhat.com,
        rohan.g.thomas@intel.com, j.zink@pengutronix.de,
        rmk+kernel@armlinux.org.uk, leong.ching.swee@intel.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] net: stmmac: move the lock to struct plat_stmmacenet_data
Date: Wed,  8 May 2024 12:52:57 +0800
Message-Id: <20240508045257.2470698-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:4:91::21) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|DS0PR11MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b51b0f9-ed31-4bad-8684-08dc6f1ac639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|1800799015|366007|52116005|7416005|376005|921011|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?xsBAUK1tZ6KdzuDnqxWPkOAJEnzSHYRopUgqfYO8d4WJM08WjezO6nzi2dyn?=
 =?us-ascii?Q?aBOvj4S92zhywYKvZ8avn0kIXyriHl6ovx/8msArGfsG+ohesNNUoT5iTzne?=
 =?us-ascii?Q?Ke1HdtL/DFfbaFn1/KOIYjwqrxR3km/0lJA4vWbDIOnNV2D0PftbjPmKnMlJ?=
 =?us-ascii?Q?VpHhFnp0hQ1Bl18i17xa44X6/9kCFp4v/FKvCOoQbNADbwQfHKE2R/qaWLKC?=
 =?us-ascii?Q?81zaXOsNYWyaWNbqeZyO586G/0NOs3GlCZJR9W1XVgZjIQErESFgQ3TxaKiZ?=
 =?us-ascii?Q?wF5i/JyZuIdGJLfIqFKoNMA28Pw5tfTeAXaRwnAZtwDOPZPsPqT3yw+LtXMM?=
 =?us-ascii?Q?+wITa4QsOyg8gbeYs18SZQ0MTfmFDoyhw03ogd7hKrgWm3yZkLV3CY4DmY1G?=
 =?us-ascii?Q?wmjKJyvj8D5QBtsK8gfRA6eLVUgMPFG996gzZh5foaXWIrABdK33fiK6WHMt?=
 =?us-ascii?Q?WKX21LSwJTWMx4mIVcolVaM1xsxCejuLIhf2pGuwVobSdQckXQvMyIUsc8Xz?=
 =?us-ascii?Q?egXB0RiWAwgGkVFa9wHvKFJdc9Df719bxCdWphkNFJA4vEXK6HpmAxUVQ41c?=
 =?us-ascii?Q?3mOP29/kXqxwiQ/TkcE/zEoxD0ZC8hHr+ISVyntxAsNXhbPOSFlhHkXoZMqF?=
 =?us-ascii?Q?itXKPw2HNWKFoeuuwU/+fgx/Q8jPX4tTY2yq0N/nQGoAeTwX+4Hc6BGOtVLx?=
 =?us-ascii?Q?I5P+s7MCMZWnYFMyUxOzUeOMiYwlwDL5/Wc9VPk6f+AwBaukDDSSJ10OT2d6?=
 =?us-ascii?Q?YdTXiy7Wfzd1X/vvF1BolaoqdYlYaB2UZ1w2j2J1VtgsrjFADe7J4j1fOK7f?=
 =?us-ascii?Q?PKHEyvTACj/jmChhEMuCKehKOFqnZr0Zcm/6PLa9OTq3t5Eb2GY5xTob26Gl?=
 =?us-ascii?Q?Gleu7HcImCnRKsxBPzdFavZau9ZCxKhbGe9nF7YwgeRbv+6ZHTb9MsHgFLJC?=
 =?us-ascii?Q?YlBtBdNy6Bgx3fCO/70RFi/IZ5aM0cqv989SIYRi+PZGJYHKw1xALOYZqP2H?=
 =?us-ascii?Q?RCclha2i28SuiVlqI3e9sEgc5OErGzdTk6arXTDlrIB/Mk4WBzAKQvJleabR?=
 =?us-ascii?Q?SUidCsz85bwF/6OF2aL59WKr2YHX5rmaZTmEfjzM0yg/WKKs4yWkOOKP77R8?=
 =?us-ascii?Q?1ZXIskC2iPETqqNs4oa8MLMTJ4Ij8wbtEEJcqDWihodMXuc9cPdzXcqt7m02?=
 =?us-ascii?Q?2aAb3lYZ0qs8nD/0+ROILeV1JADru7OD8t7EyI3NkIbW4qK4UIkjoSkohp4a?=
 =?us-ascii?Q?QAkUWptvPXQMGtq2s9QTJ7TU05SbqhcsLFzNwc2MwnxcRZyh92z3iyM/cRwr?=
 =?us-ascii?Q?dKFCzvbVgaztU1b4XUYRB8PN+RpvK3W9aKlQ7MfCdsQfsxjn/kqEn7oky+gc?=
 =?us-ascii?Q?SgwReUI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(52116005)(7416005)(376005)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/6R2a/2jEeWtIN8RpN9x8OVfc5O7BFNBv7px1LXzbXUsgAfhiwyFGtrDVQjI?=
 =?us-ascii?Q?TWx4xUb/gBPXJhZE6u7Npnkd/oqQ/RjzDhwGgEbRc/VkX3d+9A1opNZKFsv9?=
 =?us-ascii?Q?90ypNDlvrOROTb1WuR9u2PW6oMmrOoCGLd/tcowBKyt4ldyxJgyqp2hnw075?=
 =?us-ascii?Q?EwfL8/3JhEPXeTaICY/mpgSxV80ulIM44iqOuwcT62HEsa8wMCzE9guqay1H?=
 =?us-ascii?Q?nzThvtEHw8eXNnjXYdFg9iGG9Qa5FbG+0Qjfu7TeDf/B6oPmT2bkSHwqjOsi?=
 =?us-ascii?Q?OwGfePLjpV9vxvI5mMXqqBa4jawZDCs94G7JuzSJHv1Tjl7bMbSE/tspjPPC?=
 =?us-ascii?Q?mSQ4xxhsPTsuQoyVj26Dlsf2JezFacTh4w2K9PTru0MVhrvG6L6auha79haY?=
 =?us-ascii?Q?0ffa/bxYY08TF2k9aUxGIjOOfhRDHbovAeUPzkulgiGVLe+sKHQq0tKpupUV?=
 =?us-ascii?Q?pxXMlCJmeQMpCiP8qrvYeWhR1HCEe3FjNqHYM4TuCB02AgFG6YfP4j40CXEi?=
 =?us-ascii?Q?Z+I4u7AJTKxtSxGofxAfJKpS2eg9BTLkYpFgvBcWdLIiJEX4QYhR+WJKAOo6?=
 =?us-ascii?Q?AdarfWuhf9KTxQeBga9EdCFk838J/h9WDqxKKelsZfPaMLVVq9JKuAyZgl7P?=
 =?us-ascii?Q?RvHAhEk1lTJFddz79tMolKaw6iJfUwJvloCYRRUKbf3Dml+StJE2huLtmN6x?=
 =?us-ascii?Q?YXsSTwwACZdlSDulIXiNlh9Q1XoGAZySmSIDIj6cV8URc+0TmlIwpfUf6kZ+?=
 =?us-ascii?Q?lC43zddSXedq7ALPxEDaiqzBKEjJgO+ryjzrJBzzsiOf5++evwh+7ZccphL+?=
 =?us-ascii?Q?AUDtq2OGchqMlgOKPb2f8iXxbXBMardFhiZv7BS6sKaAZN3x0nXKkW5EvKUG?=
 =?us-ascii?Q?qqOqwzm2INqSD6FaGGKAcGN6d3noxOh+xwFZDvEFD24RLuSTV/KpUmhmNzbq?=
 =?us-ascii?Q?Yz2QiPHMo1YJCrXxl2Jq/N42Ssj9xKnoPToT2pEpfKot/RTBD8vuJjscUQJE?=
 =?us-ascii?Q?ZC6f8EyxdCvW3UR0IIb2vsnh9bhP7axzwOGlxc143kNgdN0ro+8Hs49W8bTF?=
 =?us-ascii?Q?zyhRsCISUC16pftN8hWXYVC+D79pQG65rAAtRLpl8ySh4EuBA8zM6kDrcSY0?=
 =?us-ascii?Q?2h+WuSOK4fq2KF5PRLJfzsWmRsPGGjcqkh/pkphEEC3E2GV53Oj3K4OLeB4j?=
 =?us-ascii?Q?TTyUncu21ZCXmN4HE9yxxY2BlWrMkzUyKrr6hGq9zLf2X/ZbnSmLzUyjgSeq?=
 =?us-ascii?Q?PvLS7tjylwottzG31NaTmWb8rWuC3AmZwyX+rE+fP/4STsPuv2fJePkzwtlt?=
 =?us-ascii?Q?CjctT1n5Tae4oyN2gQcHX7uTOC18OcQEuEjdIZcAnN/vKeM9Ng8sgBkfJkhc?=
 =?us-ascii?Q?7kE09E4rJltv7AjKdYPCQ33s+PCfccbu+RRYP5nvELB0n8MgCoQbS1Q9ri0v?=
 =?us-ascii?Q?Sdd6j914wbAy116KuSkqR6l3vJMK4gdhW+OTJn2ilxLxJ09A4gO8EruGuQIv?=
 =?us-ascii?Q?3IG40Tp8pwPoNo26IHpPvY3lgwwacce7Fgvw5lcVwyD3PqBF5MmZnFw5kLZe?=
 =?us-ascii?Q?0+umXOK3qK6I7x1hHX9Q0fRMCrVQHiVk1BaFNl2qVgCPTmS6kxwZZSwCDn9W?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b51b0f9-ed31-4bad-8684-08dc6f1ac639
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 04:53:16.6974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9P/+xJPgYfb7t5fBKnMusQcoAtaxsAVqLmv20IFTFFlAdKlGgKHtr2Mbs5V8orIxsb8bdR2BklMaqEhXJyvS28+rPHzEWKzI4Y2o41e8Myw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7829
X-Proofpoint-ORIG-GUID: 8emv-XHsOq-YecytePY84ygNUAIOc_pR
X-Proofpoint-GUID: 8emv-XHsOq-YecytePY84ygNUAIOc_pR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_01,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405080034

Reinitialize the whole est structure would also reset the mutex lock
which is embedded in the est structure, and then trigger the following
warning. To address this, move the lock to struct plat_stmmacenet_data.
We also need to require the mutex lock when doing this initialization.

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

 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c   |  8 ++++----
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c    | 18 ++++++++++--------
 include/linux/stmmac.h                         |  2 +-
 3 files changed, 15 insertions(+), 13 deletions(-)

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
index cce00719937d..c0b720f08d77 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1004,17 +1004,19 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		if (!plat->est)
 			return -ENOMEM;
 
-		mutex_init(&priv->plat->est->lock);
+		mutex_init(&priv->plat->lock);
 	} else {
+		mutex_lock(&priv->plat->lock);
 		memset(plat->est, 0, sizeof(*plat->est));
+		mutex_unlock(&priv->plat->lock);
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
@@ -1045,7 +1047,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		priv->plat->est->gcl[i] = delta_ns | (gates << wid);
 	}
 
-	mutex_lock(&priv->plat->est->lock);
+	mutex_lock(&priv->plat->lock);
 	/* Adjust for real system time */
 	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
 	current_time_ns = timespec64_to_ktime(current_time);
@@ -1068,7 +1070,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	tc_taprio_map_maxsdu_txq(priv, qopt);
 
 	if (fpe && !priv->dma_cap.fpesel) {
-		mutex_unlock(&priv->plat->est->lock);
+		mutex_unlock(&priv->plat->lock);
 		return -EOPNOTSUPP;
 	}
 
@@ -1079,7 +1081,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 
 	ret = stmmac_est_configure(priv, priv, priv->plat->est,
 				   priv->plat->clk_ptp_rate);
-	mutex_unlock(&priv->plat->est->lock);
+	mutex_unlock(&priv->plat->lock);
 	if (ret) {
 		netdev_err(priv->dev, "failed to configure EST\n");
 		goto disable;
@@ -1096,7 +1098,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 
 disable:
 	if (priv->plat->est) {
-		mutex_lock(&priv->plat->est->lock);
+		mutex_lock(&priv->plat->lock);
 		priv->plat->est->enable = false;
 		stmmac_est_configure(priv, priv, priv->plat->est,
 				     priv->plat->clk_ptp_rate);
@@ -1105,7 +1107,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
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


