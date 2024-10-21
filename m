Return-Path: <netdev+bounces-137658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF4B9A930F
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 00:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B95C282FEF
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 22:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC58E1FE114;
	Mon, 21 Oct 2024 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ajKYMQ+G"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344321FCC51
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 22:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729548788; cv=fail; b=krH7Bqvv8TOMstcBcB1+rKl0bq2iYvqlO/6AOT7sFxSm+MFd7uR1T1otALYe6hkhLJBkFKnUVudIa+TRyhPTiMVXVhr7p84R+5B768ry//Dcly6npTsQtBPd94zGnbMbzyBNjpD7dgQVeiNJVzWOmpxBMDEop8BO0wvEnzfvKfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729548788; c=relaxed/simple;
	bh=aZjN81eADJIBgRhuX5rsuhXLNtRYmYr1xuuRktbxNFs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lT1RzroOJmIKaXsyurtB677pvdJFz7BYKN/gL5MW2QVjy6UjACuGk3bd/7LfRzDtNFszCSmRjz1CHaogRbd6s2wL1RWlcOSjvoWIWmV26TkIXkWx72/7tV33Nvp5M7fnJ0bqER7Xcw3Rwqn44IzgEJ0yqo5LzON5JTJ2+qgf4i4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ajKYMQ+G; arc=fail smtp.client-ip=40.107.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofyll2YhfO6/tLgfvE1ST6TXdrTwF2Z53iyeodVg9kFgYFlwoWsgCCysIiMg5OSntC57Th3ftypum9LRoeilaXLT+BjHgnFnmeObRl5wnADhw9K26LvKphFBQg42eKLzdQuZ/4gjQdRlDgKPGYApf8QXoPo897B1gBmAAgqMGYEspETpkBS9s3J+eg+G2ttvYPKSL4MjAKwucDTe/Kw9wINRtMZFz77WplT/k9hdiJcw3qyccBPqlqvNDowHhqZ8ZTGrivWlUhqd4j0Pxb0tAR15naMPILvjamwT3ke0o3jhnLQ3w3gOVWxA5+fSWozDUXyudu1eGfuv4jJrvzBdRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KdYxG2dN7mQ1qrpP5WN5zc4cZu3oW4eCDkVxJsU9Wg=;
 b=gxj2eLdLDYYhckbB0xtu9863dSceREh6Gv4vTS5FG2mAaM4rh6/JEjUt4OVSrXPCFzeyDzO3OssI8PAy23Fuz4q0qoTqeLntqJS9wNERx+qx9EeoaUT6HgS4SKUTuBG1CZ+7fa8Ir8vGWlFV2L1DOYnqf00RsjSQBzq8MjNklBgVP/7/YFqn23DdQ83M/ESfr+PejXQsFYd1tZtPMrtS+iJ7Guow3ljviC4fpuqL9B5f3v57AOOiuOTqV6es3QDr0LItZcZwhTTdo3+4W+OsFLAu6h6tjTMM1fvA+CtK9auDK3bI5Y6uK9H/wkWBLDvorV8sr00kXEwFLOqLxqC6XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KdYxG2dN7mQ1qrpP5WN5zc4cZu3oW4eCDkVxJsU9Wg=;
 b=ajKYMQ+Gk/Hhq+IAEb/SBCgcH4OUuFrOTClpKvCkFHoUT7BSObQe96MpL8u2XDQL1PdNtFshks1XSQHVOLbdSw7B1JBOGf3H5cpmjwmWS19T0IrIYk0G1xCxYMwuvr87dB8DSxUfAhdANJC13q7BCcjk7AeQM/RMO1sg2riu8ZCnmzcaWfDcclj7n0TayjF3gJdmb5P53Vkua4bmIHHX93LdcxAwF19yCqz4cs/1i2LepW3iM78mPd3l6WyUtXEAzTrT0cUvaHwMbNEtfnHQI75nFwDO9T/xHIGZSIIn9GTDpFPIDhcclwu4Bfe+EFDoIMevFL+7YNtNpqv/fyDW+Q==
Received: from AS4P191CA0005.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d5::15)
 by AM9PR07MB7155.eurprd07.prod.outlook.com (2603:10a6:20b:2d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 22:13:03 +0000
Received: from AM3PEPF0000A795.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d5:cafe::dc) by AS4P191CA0005.outlook.office365.com
 (2603:10a6:20b:5d5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Mon, 21 Oct 2024 22:13:03 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.100) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM3PEPF0000A795.mail.protection.outlook.com (10.167.16.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 22:13:01 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49LMCo4p023764;
	Mon, 21 Oct 2024 22:12:51 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, stephen@networkplumber.org,
        jhs@mojatatu.com, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v4 net-next 0/1] DualPI2 patch
Date: Tue, 22 Oct 2024 00:12:47 +0200
Message-Id: <20241021221248.60378-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A795:EE_|AM9PR07MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: dfacd35d-606e-4b5f-2722-08dcf21d8773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ay9LMVhqSDVnMmtXazlienZNYUxOdGZNV011S1cyK0Z6TEtqUk9lNHBLT0Nz?=
 =?utf-8?B?eWtwdzhrL2RGZFY1WWlwYm9RMCtCY1J0RjJpaE9WUFhJbUR4NEF5N2JjV0t6?=
 =?utf-8?B?bWdJYkRxTjNJR3pxbStCdFlVdE1TTzhyVnkzcFhXL21MR1lnTlI3TWZNYnF3?=
 =?utf-8?B?L1JWWDhjdGtXc21kRlZDU3hmSkFuSCtCNlpKc2VEU25YRWpFclV0S2FqZ20w?=
 =?utf-8?B?OHhwSXUvL09HSEZ1cjlzb1diSS9DMzZidm1uQmh0YzNrdGx0cS83VzBERXln?=
 =?utf-8?B?K3FoVm9IQ3ZHOTJHWnZOam5sQWVCOTZDSTZIelQrRnZQMW9HMGo4dDZuVXE5?=
 =?utf-8?B?SFBpQlJvckxEY3NMR0I5Y3poODJ2anB1Mml6cVZ3dW9JR1ZUZDBCTkkwK1pK?=
 =?utf-8?B?MjBkNUFQT0RweW1BcEdFK2hrMXFnVG9NT01hMUQzSnpaNFRkNllVM1BIRURZ?=
 =?utf-8?B?SkJIUm9TL1ArQm9saDRRUlJlRU02QitIOHB4b2NwOCt0ZmhEOU54OW5kODBM?=
 =?utf-8?B?alFpeitwRUpJYmV2a2NZUlJNUG4vdSsxcGR4ZnNCZGJmcTMveHVrSTg4bHAr?=
 =?utf-8?B?MTl4LzU2WEdxb211YzdYM3lZTFRkUGxnQU81aWdKc2tDN3RUUEd4REhpZldx?=
 =?utf-8?B?cGVKR29oNzBjeEZJOXByWXFvNUs4RGl3ajZRRFF5QSs1SHpobnpiLzQ0OFZz?=
 =?utf-8?B?ZkNWcVRpU1ZUUC9pUFlnOUJiT0JtMExLNWFaMXNHcFJUODUzazZuVWZqbDlz?=
 =?utf-8?B?MmtnQUlwUHpqZXpRZXBUL2xUT0M4cUN3MVdYNkpBYllTaS9tbTRxdFdqMnFF?=
 =?utf-8?B?ZlNsbm1CZndhRXp3aS9oTkhvelBwZEZIVktGeFZybHNWSEFhVVpWZ09WZlB0?=
 =?utf-8?B?bTl6YzRMNURTM1VrU284U3I4dWVzakNvR3NaR05MSDhHSk1vZjNRdnBQV1RU?=
 =?utf-8?B?eTlMOVJORVNkWmRVOExaMzZXcStOTzlBSEduT2lteUFoSlYzazR0N3BaZEpR?=
 =?utf-8?B?UjRCeGNURmdnZ3gveEg4VjAyWVJsWm10bklwZm9na0dXMG9LcDIwU29yQkNj?=
 =?utf-8?B?TzZLd0RPVjU5eFI3SExmaUx3STJLMGZtYk1BeVVyNGoyS2dyZzIyVzY1aHdq?=
 =?utf-8?B?cTdkYWVSaUZGY0RRZGlZUE9zK3RneURXT2FsclUyNTkxaHB5RC9aMHM4MUFQ?=
 =?utf-8?B?WnlUdThsOHhGMHZkNUUwQWdxby9VTnhlVVExWjljZ3dEUUNBK09BS2ROZ1Vm?=
 =?utf-8?B?NmJGR3BjOEorRFVIUlJNc1MvY2l6OUExaFVKMDl1TXVFNW55bzVPeXNnRGF6?=
 =?utf-8?B?c1J0Ry9Eb3FCVE4zYnhNVmh4TGs2Q2tRSDZCZWs1cVZrUGoyRDNnck84VGF2?=
 =?utf-8?B?WFJwYnhqRFNIVDRVckV0MWNJVTRTdFR4a1lJNGRBbDUyckFlRVJ3TXorK0ZI?=
 =?utf-8?B?OSttNGRzb2tHRFM4WW1saVlDTjBEYk40WFhtdlhTVU9UMVB0SGlFM0cwbmx4?=
 =?utf-8?B?Z0RnRktsZkdyNksxR3RRQkVxOWZ1MDRVdXlPMm43bm5hTis3ZUplRjhrOS94?=
 =?utf-8?B?aHNnQzZlNUhMaGZSREM0WnJaSXQ0cWNOa0Z3WDMxWDc0VlBsSDB0NTBoQ3oz?=
 =?utf-8?B?RWUvR0ZmbzY0OFdHVi9EM0RNNW5DTkkycFdlWHlkOFpYRUxqSC9RdmZBQWli?=
 =?utf-8?B?Wm5vVDVEd2FDVWdCMFZwRTR1M2xldFFUcHRHclJhYUtjRExTd3hSZzVsOEkr?=
 =?utf-8?B?Sml3MEFsNlRZSWZhZDBmUkFtS0IwOHZMTnR3Q3VRbG1BYjBXL0hMWnBCM1ht?=
 =?utf-8?B?VHBHUlZuMWVnRlBTUmhiWkgvbVFlcE1aOVl2TnBnY004N0NNMU5iOFdwUGdY?=
 =?utf-8?B?OCsyRTJ4aEdVdFIvTFFJSmRKbTFBM0dQZXFxOXZSQVBuQUhDc2xsT2o5cDZX?=
 =?utf-8?Q?MoLpk7ffjRs=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 22:13:01.8805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfacd35d-606e-4b5f-2722-08dcf21d8773
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7155

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Specific changes in this version
- Make succinct stateent in Kconfig for DualPI2
- Put a blank line after each #define
- Fix line length warning

Please find the updated patch for DualPI2
(IETF RFC9332 https://datatracker.ietf.org/doc/html/rfc9332).

--
Chia-Yu

Koen De Schepper (1):
  sched: Add dualpi2 qdisc

 Documentation/netlink/specs/tc.yaml |  124 ++++
 include/linux/netdevice.h           |    1 +
 include/uapi/linux/pkt_sched.h      |   34 +
 net/sched/Kconfig                   |   12 +
 net/sched/Makefile                  |    1 +
 net/sched/sch_dualpi2.c             | 1052 +++++++++++++++++++++++++++
 6 files changed, 1224 insertions(+)
 create mode 100644 net/sched/sch_dualpi2.c

-- 
2.34.1


