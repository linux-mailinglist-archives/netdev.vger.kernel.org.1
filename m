Return-Path: <netdev+bounces-98750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD078D2482
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 21:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE781F29AC0
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 19:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642C561FFC;
	Tue, 28 May 2024 19:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="JiQ80y/o"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2091.outbound.protection.outlook.com [40.107.223.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513A438384;
	Tue, 28 May 2024 19:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923915; cv=fail; b=nNoUwFVrvJ6IHkUi43DHL4fxLDOnqOj8E5qSSl++NfPvm8QtPofY7mAT4bNqatTGo4Q++fRRZ+dKWM6SCy6joyz8dRVoxhffSosv3RqJhgK4q0Vf0HU4fS0bCMYBB3hlWnDUu968QfCimEwZQAkXMrbbtmQAx/c+rXcalxVgCdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923915; c=relaxed/simple;
	bh=tU2RRQvtQf0rLNDuEOsOxY+9c/nMthbETSiYloNoAL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HHxnNRj5kP/QSsoYBrwslrw9RLBmzPkU/5nw/D8iyiMEW6YLZd/SlHiLRXKrXmFNloKzPIoDaJSHa0kzwU+g0UUtoqXHCwoCpuqKL81T0SkMjphERADvwH/GW4WURQ8dYeKs4Ffj3LDtpl1KSvZ9kk/pRqEVF70yuKOqqkhrEB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=JiQ80y/o; arc=fail smtp.client-ip=40.107.223.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1d6jEvBdyss+dfF4K58OK0m0UO9ieTBIBQ2nxMU/PV+tGCRLxiuSjqyGy1JTcdJcXSnO3tWbJGyPUmmbssOi1aznjYTA1C3trP7qjwx5pJFFh5e8CO/ga31Fr/TyYWjNJ0MEgd5op4nud55gnAHbhIOZUYOF241DUZIdUt+fVeZyKoQSHMgZOiLC1hwuzxXvUXgiiEfpwI31gFa2ytMlMEZclTYm4ASa9/tWfSUGhmoPTQTQm1zhxYpW1loHk+kOFzIygzk+cau7hRj0Lcuqa3iCGA8KExK7RBkmMeG4l++4XWeCU6FeRELuqnKczRUcvVgD87A7LQuseSFCIbe1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9jJu1349RdDQ7YL7q0ZNWLfyOZs8ta4aMA8BIkdbnQ=;
 b=mGELjRjEaJv4iJSokhOXYa1dEhpHb4lx25G6XvSMhzUs7hsi0jsV8uPs6emu1j3jHRKqpusjBMGL9yYIWApPUxHYKWG9Uu3MUbSdbF34AAYbIXhIquyhcYPpEgbgVrGb9GUQojySa1aV0VTfnNc52IgJqvlU2VCdtUL2rZ1hD668zoLA2h7o2BR54WZGaacq2ilxavuSjGGIukrpmP6XPhw8iJumLBG3Ig1Po3NJSsFfC+knCMx5XuG5TcJRFaW7gRbp4+ygv7eSpv6FuAZRjNreIkpBcubA1ORZqH867nhePTtY8jwuj6rc7GfuZEXNGiT4t6z7+9FsoOF0592ssA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9jJu1349RdDQ7YL7q0ZNWLfyOZs8ta4aMA8BIkdbnQ=;
 b=JiQ80y/oGpXkhmxdPAr3IDcepgOXWATvMcGyJwjxIGc+QyG2rK+FIhgqOo9r/t8u/k/hz/sgwy+VQEIohtNOvNME8+8//c8KK4rNjaCfmWpg4a8qxVv5+c72Ts5nGKyKt7Q6NgyPRwFTVJbrAT2eQSJ+tNULxdw/nIk3fIAjPUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SJ2PR01MB8403.prod.exchangelabs.com (2603:10b6:a03:547::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.29; Tue, 28 May 2024 19:18:29 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%4]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 19:18:29 +0000
From: admiyo@os.amperecomputing.com
To:
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] MCTP over PCC
Date: Tue, 28 May 2024 15:18:20 -0400
Message-Id: <20240528191823.17775-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::27) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SJ2PR01MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: e57fc712-878b-4dfa-99ff-08dc7f4af4f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|52116005|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UJ4B7bfJdRGN8zVkGBugSEpSuwFEnYl3iBzxGzS3giiIsek6c+a1gtdD2EI+?=
 =?us-ascii?Q?PWNjPBnsjMWa36O1NKJpsQk26QvKSSwyhmFxMnUQWEmI7tHeSfdpHJL52ON8?=
 =?us-ascii?Q?wdoj6PZ1+Q0OVclFOu/lh7jGLh2S2bLsaL6XAQUsRzMrTH4RI5Ur+O7x7yw1?=
 =?us-ascii?Q?pp57WfZZEOxvRM1sbkfGK3gjUzoJwRInSLCwD2ZC292HndHcOmGncVPeWZTR?=
 =?us-ascii?Q?rMxkfvDHScmqB7Ryv4wV+LyFNvNcBmkErLL7gD+Qc0JPpPn6eqofblkn+mMD?=
 =?us-ascii?Q?EH/YgwSO5zZtlLrLp/Y2BgUEZ5M5DQzwx2XcP/V13uvjoHdzp0YCrdHdKr2K?=
 =?us-ascii?Q?ifz003E4aXLZkF1+yp7rqbI9xiZWYqTw+JeuT8vp01EuWiiFLIeXlz19BCQd?=
 =?us-ascii?Q?Mu8Uajb1yLUybuUus9uGr32s5QrNCvRr/anWadqeMmHmzpXguzcmjKYGKpEL?=
 =?us-ascii?Q?2mKcofSuZtM/G/TxiYF3saQb1czpi50qogChUiSpa2EJqLQ1Chs10+422EGS?=
 =?us-ascii?Q?k0zbSXm9u0gbTiG27Rg508m2ohxLj2NnAiGssOqqXEqseBYTMe1uEp1TyzqF?=
 =?us-ascii?Q?V45niND75MQpFfk27DNWmwZGE2ONSLBT6LkpqTHNgvlcEPKcq5/EYWKMRDjZ?=
 =?us-ascii?Q?z7YNY5ESQThpTiHPoHssE6PPGem1IFIirzkLPcRcv5hy8oJcqfhcXbjH7Pl4?=
 =?us-ascii?Q?trNrA7W/y/ZtfJZQ95N8SXiwTCpoo5c5e70SdZhgw0nZgIRyITsjarQ7N2xh?=
 =?us-ascii?Q?mk1zytuzloMwLnor68obrYM+qAeItofCsAmLJwdOlN4cVLe1be245LB/mkvl?=
 =?us-ascii?Q?aEprlUAdJBKTSzM+qwLlEfhM4Zdp27hMzeBSOCGcNIqIBkFD0j5U0N+vMjJl?=
 =?us-ascii?Q?f6SAkBjhJ3YB+Draznox3u/aVjgQtxF2Uz17Nvt9RFWrn5b5SGQrJhvXHhbF?=
 =?us-ascii?Q?uMjbAXiys/hHO7CYC7uKu71cEOVl6dUIOe5rJHdBtG4lQOmG+Y5q/DO8DUcV?=
 =?us-ascii?Q?ZriaNoTkbkluf5wyaDcJgZHxdkjcr9x4FxqKfuonf4boMTMcy++fdTnyRs04?=
 =?us-ascii?Q?Ey6m5wfywIBAEvvFr7p6/nPtOwU7AmqcsTOC6rEGc2oFLp3bWzyAhJTMvuz3?=
 =?us-ascii?Q?GfuetHE0tB1L+ikhoZ7Dn/RxBO8ClguQpVBr40sHvjTeY3WUhrJuzN93qaZs?=
 =?us-ascii?Q?St0HpRK0Ebr8uxRaSmTM5Z5rDnrF43LnKYKIchzYSAcasdfitoI/4UPjgF9O?=
 =?us-ascii?Q?siHWQmIm14UMXTox99VEFe97qBP/31CZt4+RhwOj0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m0I40fY1q4IEO5Mvhuh3bW2XCYcUJi6BG8tc/CTHxqLdo1SZGrPu9DmNHtSR?=
 =?us-ascii?Q?q6lPqNMTTldpfst7PNH/XgMiDg3pLzagYSM2m/i4qz1zMAfW0z3+FSoRz8uD?=
 =?us-ascii?Q?0qlxY3xMoXmBpCrbD02ZBdGW/WbIIjfWls+kd2hp4PyYTLn/BXig/LCL3i4S?=
 =?us-ascii?Q?aHKBwEI91iLO3ey1TmeMW3RBqEfN0czBc/rK7CApAPFwM5eDu1/R6XVlnZlQ?=
 =?us-ascii?Q?NKHrbb162Ks5GKB3UTlTtpZmP4VZzHbYwLOqqHb0TGjzfYAa3w+Cw5BbVFNU?=
 =?us-ascii?Q?odT7zTe5fcg9lKjh/RF+MJS5jFKtUnmwHXo0QBqcQj0ibF5lgDJU4DxRTgr5?=
 =?us-ascii?Q?HAyg0obwi3sWYPYEx+LoMjn+GYMum3dUm20weaxyocwu0Ncolotth2CAszGs?=
 =?us-ascii?Q?RJ3Ce7yFeNByG5tSSiOE3nNjMdQMeUg9oX1XiBt05K6EIKtmFX7y6sBmWk1n?=
 =?us-ascii?Q?HBQUGNYrdClPCtJze4m8kmDaUz0BK6R6EE5bEfq5I3bMFhZz9amH9P3IPRKv?=
 =?us-ascii?Q?wVpEBW7bbOick4y16l6/Au4aYYePyt9LFFjqw9t1Hh5E67vw77s+va8SMKTO?=
 =?us-ascii?Q?Y/ZDCFJc1QK9vw+iWLZEdkYyx0Kw5bq6na3wql2bm27wKYZgqxNdrEsskeUb?=
 =?us-ascii?Q?t+s/nQvZhoZrDlBk33Xg1itRS1RtBxaaKSv4O5AATd6UT0ApyNW4OIo9BoBh?=
 =?us-ascii?Q?BCp/5Xef0YJs78+OR6QZnjaZkkSTw71mPm/D27tK6ic5aEGyFUTh2it2t4M6?=
 =?us-ascii?Q?XYgPVReqNO+lIZ7cH7vfJz8JhEBZzXPUN7SPw64kTfbITe9L99LpVYfucyMp?=
 =?us-ascii?Q?Kg7uVn83aa2SkLCfEYuHeKg8W2PmlhYNA73sylW1o/PsnnIUwyuvKxWVUNj9?=
 =?us-ascii?Q?Ji4V58eS+NTC/MW6hDY6udJT1o3DAXfeHTGK/maC1htXvIabxXi7teNGqZS0?=
 =?us-ascii?Q?L+SZoo0GCaVlU0uthuRfEQnipu1pxvHcG4MYVg68YA8knUFN/k2BA8lsH/Bq?=
 =?us-ascii?Q?N+UrvuCA9TRq00wzJsFktYchdA88Yl5IBcoRjzrAxrWVGi9GAb28ITs40rCF?=
 =?us-ascii?Q?xc/AMXd6UuUKf5BlClMduRT4yrciBB+/wPjh3xbah56q8DkycJ4lvCMRyY4P?=
 =?us-ascii?Q?ajwn+w7rVMgtQJzPpCGF3oYu2Pkr+nT3Ji7R4Rz+flkurv/w8lJB7Hjtgd5K?=
 =?us-ascii?Q?tn3V28Rr2guqEIPkt2k1SpGiH91fvFzWdry/Rx0IkWDp+kBF1JxtMxnf82pJ?=
 =?us-ascii?Q?UVCCgznnq7QLI6cdrhwHnO0Dm7WQXAQPhpdFRwLuT4VT2sZ0GXThz6TZGbyf?=
 =?us-ascii?Q?o7x9/700JyCt/KFYoZqgGLcJfIwa5pNcz4RRWmKbFQY6pvcatyia5QtaUbn5?=
 =?us-ascii?Q?hKP/upXIthhF3Xm1XR07pEp/RyBlHB+u6UywS6gBCp2aZj08U8f6HAENR3JJ?=
 =?us-ascii?Q?eN0pxFsyXvj6ro8kuqtzVKAVQwsQKoljz2lv1Bkz6TEu8ZFcT8QY5ClcOn6q?=
 =?us-ascii?Q?UW5woYbH/PfN+Uv7Iymhl7ygJBgs4Vy523wt22Al6jH7ksL1hFZsnA/3IViG?=
 =?us-ascii?Q?cLAI0EiTjs+iVWgWy1wNG46ysZAGXAvlRebKBTgGOU5/VTaVrkR7vskfW1b1?=
 =?us-ascii?Q?WQFGKdCDBsPqCAc3q5w3/UHSUZMBqdxhqCidDW3RliJrsPOI3lJi+dSG6CxC?=
 =?us-ascii?Q?xNZjA6HzHkaZv36Skd+flsI3MYA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57fc712-878b-4dfa-99ff-08dc7f4af4f1
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 19:18:29.4404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jo+dqYFNEabaaW9Yp5yimxvMb8k0rP7t44HssV8vXiJ4Qo0Ty5oEw/JIU8YlFaHUkUO/I6wy+ozZ4mHjFy6mgtqr1Eny4ZjrfVTyM+thzaVgS9cC3Q3HTkjv+4Zjv2D0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8403

From: Adam Young <admiyo@os.amperecomputing.com>

This series adds support for the Management Control Transport Protocol (MCTP)
over the Platform Communication Channel (PCC) mechanism.

MCTP defines a communication model intended to
facilitate communication between Management controllers
and other management controllers, and between Management
controllers and management devices

PCC is a mechanism for communication between components within
the  Platform.  It is a composed of shared memory regions,
interrupt registers, and status registers.

The MCTP over PCC driver makes use of two PCC channels. For
sending messages, it uses a Type 3 channel, and for receiving
messages it uses the paired Type 4 channel.  The device
and corresponding channels are specified via ACPI.

Changes in V2

- All Variable Declarations are in reverse Xmass Tree Format
- All Checkpatch Warnings Are Fixed
- Removed Dead code
- Added packet tx/rx stats
- Removed network physical address.  This is still in
  disucssion in the spec, and will be added once there
  is consensus. The protocol can be used with out it.
  This also lead to the removal of the Big Endian
  conversions.
- Avoided using non volatile pointers in copy to and from io space
- Reorderd the patches to put the ACK check for the PCC Mailbox
  as a pre-requisite.  The corresponding change for the MCTP
  driver has been inlined in the main patch.
- Replaced magic numbers with constants, fixed typos, and other
  minor changes from code review.

Code Review Change not made

- Did not change the module init unload function to use the
  ACPI equivalent as they do not remove all devices prior
  to unload, leading to dangling references and seg faults.

Adam Young (3):
  mctp pcc: Check before sending MCTP PCC response ACK
  mctp pcc: Allow PCC Data Type in MCTP resource.
  mctp pcc: Implement MCTP over PCC Transport

 drivers/acpi/acpica/rsaddr.c |   2 +-
 drivers/mailbox/pcc.c        |   5 +-
 drivers/net/mctp/Kconfig     |  13 ++
 drivers/net/mctp/Makefile    |   1 +
 drivers/net/mctp/mctp-pcc.c  | 361 +++++++++++++++++++++++++++++++++++
 include/acpi/pcc.h           |   1 +
 6 files changed, 381 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.34.1


