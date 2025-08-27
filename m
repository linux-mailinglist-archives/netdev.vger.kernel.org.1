Return-Path: <netdev+bounces-217151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10993B37945
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE501B63970
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 04:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D032C0F9C;
	Wed, 27 Aug 2025 04:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="sqvIPPEZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2096.outbound.protection.outlook.com [40.107.94.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0421E19CCEC;
	Wed, 27 Aug 2025 04:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756270102; cv=fail; b=Txf0CdPSsd2PxWxMR/oESVjddaHMU7N3gD0qmVybknDUuyzY0quD+402s/u1CY0tol1Jg23fy1BIfSoQcY4sLsoN2gq7Aq+nKzQLLxbuBSNK0mCpteX3/Y7MAYGxt+dQmfUT5EuiclV9P7cWrBgdIqoiEGe2oetfMPpn81EA9k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756270102; c=relaxed/simple;
	bh=VGHmlsZvHpQi+ZjRbQlNTS3bUjDAHOowNSQTYuHlTZA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UDYlg3/jSUXO5HxpdXE9pbwuLV0eDTAzB8NnnH+gt1j6lFg3iF2i8VLCS5vB+Ht8J8Sdj8WTz8Jjcsijj8fCz4pVa3xRji1sLc0R+9ws5GnKeuMliA6UYCdHSSnfFNfXRwjFTr6VtTabDCbzx+GKIS2ftQsm5ngpY5XKogpAbIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=sqvIPPEZ; arc=fail smtp.client-ip=40.107.94.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i47gbU2BmdpvFgeS1mZAuSAZ3YUIr6LvV+JFC/4kwfWCiM/LXIAG/dY2d2sh5AVTbJgousIdQ46DU3Oul8Q90G1V87OzXoumGFzxTXy6C3tzg/k0AOtbpGs+WVPjOeoucTTmIc+vbMpZsUZW1UTtMbuQk84ddDImgdXGNAeCan/bddba4Ry32ck/ADVfk550e4/VYBBNSqurZFbDmsceMOKjKXqe07J4B4aVV6ob5+9PsGweqI3rCiBRSfGirNuATGHLBDsAUAgh8hpheTFWU8dbmnryhzQ07GymnS7ZFK+D7hxhoHQAVcREB1p0QyGrw806LgKgbMcvvP1T6Z2Uew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFLHZhEwwTqO7YRin5Ok++6llmqDlYsGTPZR3spcwXI=;
 b=IpD+tveBm6diYNLobq/Z3VVZrP5NZ1Up9tYZEueGhdZmEwqSmuVSirm+2Z+IWY8GoV6ONx+lVqP/814crbV1YjzqXQcEaIAP1digeAn1VEiD1Xhmg1ZLDA6uGmWll4HSv0bD03zxQsUY9ockV6sKBAkoVkqbRtBiuDMZC2H3Oja9V5CSRN6r4DMl38oxBBlygiGGADVb+kp5XJAgJKL4lfzUKkGMntHnYAvPGXqzm1CWzXwomeiMm59J6g24LwZH0hY2ciWp3x8guGqd7PGdAdJioZefuZdS9C/VJi6KDqSqj2n7YqG8FxpAKl8L9dNG9tx9rlqSx8aiPBEEu1XTgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFLHZhEwwTqO7YRin5Ok++6llmqDlYsGTPZR3spcwXI=;
 b=sqvIPPEZo/cUvu3jGWvCA87Y+g45Jq0cgnVYMlbJTJnzv+EjrJd6N0fED3wI1PvS+f8EGqKHwVbQBANFECOCouST6MesOXhzflr4SCuTALQaKuqtaDpCWKxJCbxx410aXI8VtyDtDsOHSsY3fl4nijHedLABoFw/jBctIepqi6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 BL4PR01MB9150.prod.exchangelabs.com (2603:10b6:208:591::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.15; Wed, 27 Aug 2025 04:48:16 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 04:48:16 +0000
From: admiyo@os.amperecomputing.com
To:
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH net-next v25 0/1] MCTP Over PCC Transport
Date: Wed, 27 Aug 2025 00:48:07 -0400
Message-ID: <20250827044810.152775-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:a03:255::19) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|BL4PR01MB9150:EE_
X-MS-Office365-Filtering-Correlation-Id: bdccd3ca-9f32-41a0-e60b-08dde524efbe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6H/H1TdouCzWifLYelqt+3FQ0HgcXlHZi7GuRJX6iWKWoeY+tu7O6q6DePNS?=
 =?us-ascii?Q?01nvvoDT32D9XUPoP5yS+FRfXR76afeubs0qU2Y460NgGb3e8s3c/5+8JxpZ?=
 =?us-ascii?Q?gyseYfkwCDSFWY8zCCg6HUFfQxcHnj38glB/vJLWwwC80oOAJltmOAPpZ6dw?=
 =?us-ascii?Q?l3BzskuYdZuobFeKJ6i0sXRR94cXP4pW7oSad45qPVepbexQdtyNNt0puE2q?=
 =?us-ascii?Q?g4HG4Psl6owyoYNrEUSgDpzei4gWLOxcsFXhioPS+jlqUvAzjBK4eAAaDbgt?=
 =?us-ascii?Q?wl432JJrxDFd6CbfmssazQBG7ZNl5cjT/bB/ZiGNyAQiduAEZ0vZWNOvlNHM?=
 =?us-ascii?Q?7Ju4SXGLVPuD3edVJqvN6QvnnAwCF7IGZdeUUjfpkfbFt2u8W0Nf0M7cW0iU?=
 =?us-ascii?Q?pVBrSXENEiqmctO31GEj+6B6oIwiF4iN9Sxwtj9h5wzDEMKWcvJytrDV9hGi?=
 =?us-ascii?Q?InQou/Ll4bbiNFLe+5dZIWofpct7AV0gzJJfX9erRAjq2vABCex6Z+4BmVsh?=
 =?us-ascii?Q?+5usLxtfWkaPNmx/UYVJjZOIwl//Y8EUoKwIvRb/XY3tg+9+9sz6txpIMZW4?=
 =?us-ascii?Q?opCSf5eNLTyum3+zXm8rRQg38lOnyVmamMY1qB0PDESWCCmxr1uMARr/nS4f?=
 =?us-ascii?Q?QTVUHSOsCW3fSX0siaXzpouJZMWYcFHLfoBYHb/E/o35vEY05lgNd7DlsHCy?=
 =?us-ascii?Q?KTMq8l9pKQpNnCNiJNeCicpEfmKtlqi/1nAtyasJzBO8114QJ1svxJhamsB2?=
 =?us-ascii?Q?yruEauIrH8o8cAcx3Dyg2+qQL2RW3FpuHGEN2coOAAGBkA8Uq0rdPOEeEkdb?=
 =?us-ascii?Q?ar4LRRVsG3qYTOJyCH1mS32SC/VklJzBiJYFQGG/W5LXTfnk1K2Wb1tTvwrf?=
 =?us-ascii?Q?B3x6DfkaIKFiFXSV5B2cOmG8H6OxzKn5x7qLE4uUqeIabqDwqRSXOx1ufkfL?=
 =?us-ascii?Q?txphaTR7Pii/ShMeNa24AJuYeApSCGijyeuAOt2HJrnNRw/LkNwD/QTZekPj?=
 =?us-ascii?Q?1EGyKieFeUQ1kYvzmaqm8Qg68YwfdNCY7RamF0dnI0/wfcUdcXHsZZ0nhQKj?=
 =?us-ascii?Q?Fge16mpouXAyFh8Mr2rhuL96/cFAhAJ3rcN9QmM/bY8yVQKaKozqcaqYePCP?=
 =?us-ascii?Q?La2lHBpOOjDhEPH21ft6X4aqJGg0zWIBgrzWuXXInMXbJbvB7lKOAPFZdWQ4?=
 =?us-ascii?Q?mcQlhg7NdWH3SOe3/W2vkTvC2K03YguDAWmmhIZ0xSWrn6O1wrWB/zsURfWr?=
 =?us-ascii?Q?GIzDA0l50dBjXnRpbHWI6ngedxQO42U3WEP9/YpL8JEgqr51pIIpPG6VOMlQ?=
 =?us-ascii?Q?ocMkzgD5pYiC6IzxuhrkRVGhKFdJ66foeL8TENdTiNs5bXdC8zPp9Vqknrlt?=
 =?us-ascii?Q?8/5oMCBS4/RmeiylHzQCSAVB8Ii9H8SoCtA1K90rPAUYcRIxSt211fJTPcIv?=
 =?us-ascii?Q?RIqjcms0Q/w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IcHQVl/tlzRKfs1qOV3sByMBIrrZNK/h4hPB0HRU5S2kwVtEh1yVAnBVhfoq?=
 =?us-ascii?Q?xgCmEx8xswFJSVZKcH453VSug+A3eKq1Vu1ifgmwinTu9BcmDUzYBJ2BLoHa?=
 =?us-ascii?Q?GEIil+OL/kPMyWUMYclNP5hVesvv+cEg9dA8IHmUxI7SmSTftQrnmdBGoTVW?=
 =?us-ascii?Q?/jHhg9Hb5w2lHs7m8mQVn0cHqCaHqYkJvLencOHvzGiV3b9W+wUULy8hjIws?=
 =?us-ascii?Q?m6nLlswGGBB7IWtJDnbxeSt2pIldvem2kNeFa4WVPS/fH5l8mSPs3ljOCYx2?=
 =?us-ascii?Q?g5U1PJ3poCfxmyezx9FnWZ4Ni0y447H253HuTtNWrCkcTQl1iFz+fZxA+Y/u?=
 =?us-ascii?Q?lvjq1FLhuOebAM3w58L7ohsBO27ZlWUnALQXUEzouTlrq0k2bVXKRzvkFh9X?=
 =?us-ascii?Q?fOiMqEv1rPhEHCldzq26JiMO3XZiReE4YjIJ6BXBONjicjaNTSSbRQSLdhNU?=
 =?us-ascii?Q?klI15hKPlb6JBNV1PlwbcoTjzydz1eVAnQNf8Ve652KxZsQYf0W8i1l9kfe1?=
 =?us-ascii?Q?gXNx0M86xUlDRw1gqTzNxpOTJe7pOoRba16ltvG5/pb7700raM2oKtHBr0ea?=
 =?us-ascii?Q?qFxQXC/tE7Gq5i53KiaIXgu62XYRitTK7B9ocxdsY3PwrYAVhJ0lglS3IO6m?=
 =?us-ascii?Q?NuaT3YJjGhwl78grF5Cg1ngFunvmHVtJkWVDAwJt4Cmy7suWmuspTZ9EYWJ1?=
 =?us-ascii?Q?xJ6vH3GGGFLpVqoKKczvIxRwiBuGd7J7zY27pU9zKeu4qU6hWg7UIep+u/CB?=
 =?us-ascii?Q?4at0ndzdy4MY4CrEJs6o+mphABEAKBJ20OJ3inc9HHNG6H7BdY6aLirK6OU9?=
 =?us-ascii?Q?XU4agbHQxHodSCVeWQBgV2INzmjgMnQ6y4G1qcAz+wKu6MqvfcxYwvINPGxS?=
 =?us-ascii?Q?lChr6i5NsjO2bzrQfLTaxWjOtU09kWZ8BB6RJzaWS+n9CTbWOMz4QlwY7wYd?=
 =?us-ascii?Q?5xpQpEIbLyPTh8ULHjdcIBg4KD/PSrqGHajGTl9cTUlTSkvpbW3FLPOlyeIK?=
 =?us-ascii?Q?s5aArZPzlxsd1dXSz/yXD7djBNAC0a2s/X5YiN2vt6X0FT6VoANApzuiS1nh?=
 =?us-ascii?Q?njIBKwuy9lvL9iXUPX4JS1b/BbX/XTdpsJM5orVRBmnrxYBZbzVob9hQIYBj?=
 =?us-ascii?Q?nH7DdfZopiQpEoocftaxuQ4P5mztg/e34M79RqEoJEAnz4ijVxjOWaOYubiG?=
 =?us-ascii?Q?NysgYEu80/YcdiJiZcAhgb8DqpKxZdkiTmv3PvsEgc7TDR7oSDiaPTmc62Qz?=
 =?us-ascii?Q?J9XSzSrou6CagCEFywDMnveSJf1pUiJWJZXYgLVk5ysWuP4+RYjdm1zYHesQ?=
 =?us-ascii?Q?PYwLOJvvhfis5NJrFNNCVGtt0kb565nMK/09NnSQIbeFhN1cXFrfg+x1FFOn?=
 =?us-ascii?Q?UmGia/P2BXJG7BkZVNReei36qUmgA5XFhmoQ9CD6G8ULKklEH8WQteu7nqdt?=
 =?us-ascii?Q?rfWWTLYkN8R7WqTG1kkx565gC0FrmYPrIJ3dLYgUC84y0vXJ/6QbOyKknRPU?=
 =?us-ascii?Q?h8mB8r1/Biif9adp7yEAcWTysXggHxLCm9KQhJM21XkOO0KaqrUmBnAfhJz4?=
 =?us-ascii?Q?u3v1L3qmn2a+UUDpX7oMqPK0nwh+B40doApMtfvv8PVgJWLNbutSIRJr9aQ/?=
 =?us-ascii?Q?rxt1eWOfllgnIlrgnAvFBhVhr4eb/nxolnml+hiXwa/HsVP/q8tHcicEv257?=
 =?us-ascii?Q?kaeUUMmXQs/myc+UHFAz0y6tT/w=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdccd3ca-9f32-41a0-e60b-08dde524efbe
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 04:48:16.2993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfHX2GNmoIT0SizSmlmt+DoBaiZnUlOI3vpfSSr9TkIihs7fKZUfbc34Qt0aMAgt/5NINu6y7dMVRrwNEnW1A4YN/8bG7aivn7pxzDxS7vgGJ/xZGCHZ6sVVkGJowvfC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR01MB9150

From: Adam Young <admiyo@os.amperecomputing.com>

This series adds support for the Management Control Transport Protocol (MCTP)
over the Platform Communication Channel (PCC) mechanism.

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf

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

The first patch in the series implements a mechanism to allow the driver
to indicate whether an ACK should be sent back to the caller
after processing the interrupt.  This is an optional feature in
the PCC code, but has been made explicitly required in another driver.
The implementation here maintains the backwards compatibility of that
driver.

MCTP is a general purpose  protocol so  it would  be impossible to enumerate
all the use cases, but some of the ones that are most topical are attestation
and RAS support.  There are a handful of protocols built on top of MCTP, to
include PLDM and SPDM, both specified by the DMTF.

https://www.dmtf.org/sites/default/files/standards/documents/DSP0240_1.0.0.pdf
https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.3.0.pd

SPDM entails various usages, including device identity collection, device
authentication, measurement collection, and device secure session establishment.

PLDM is more likely to be used  for hardware support: temperature, voltage, or
fan sensor control.

At least two companies have devices that can make use of the mechanism. One is
Ampere Computing, my employer.

The mechanism it uses is called Platform Communication Channels is part of the
ACPI spec: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html

Since it is a socket interface, the system administrator also has  the ability
to ignore an MCTP link that they do not want to enable.  This link would be visible
to the end user, but would not be usable.

If MCTP support is disabled in the Kernel, this driver would also be disabled.

PCC is based on a shared buffer and a set of I/O mapped memory locations that the
Spec calls registers.  This mechanism exists regardless of the existence of the
driver. Thus, if the user has the ability to map these  physical location to
virtual locations, they have the ability to drive the hardware.  Thus, there
is a security aspect to this mechanism that extends beyond the responsibilities
of the operating system.

If the hardware does not expose the PCC in the ACPI table, this device will never
be enabled.  Thus it is only an issue on hard that does support PCC.  In that case,
it is up to the remote controller to sanitize communication; MCTP will be exposed
as a socket interface, and userland can send any crafted packet it wants.  It would
thus also be incumbent on the hardware manufacturer to allow the end user to disable
MCTP over PCC communication if they did not want to expose it.

Previous implementations of the pcc version of the mailbox protocol assumed the
driver was directly managing the shared memory region.  This lead to duplicated
code and missed steps of the PCC protocol. The first patch in this series makes
it possible for mailbox/pcc to manage the writing of the buffer prior to sending
messages.  It also fixes the notification of message transmission completion.

Previous Version:
https://lore.kernel.org/lkml/20250819205159.347561-1-admiyo@os.amperecomputing.com/

Changes in V26:
-  Remove the addition net-device spinlock and use the spinlock already present in skb lists
-  Use temporary variables to check for success finding the skb in the lists
-  Remove comment that is no longer relevant

Changes in V25:
- Use spin lock to control access to queues of sk_buffs
- removed unused constants
- added ndo_open and ndo_stop functions.  These two functions do
  channel creation and cleanup, to remove packets from the mailbox.
  They do queue cleanup as well.
- No longer cleans up the channel from the device.

Changes in V24:
- Removed endianess for PCC header values
- Kept Column width to under 80 chars
- Typo in commit message
- Prereqisite patch for PCC buffer management was merged late in 6.17.
  See "mailbox/pcc: support mailbox management of the shared buffer"

Changes in V23:
- Trigger for direct management of shared buffer based on flag in pcc channel
- Only initialize rx_alloc for inbox, not outbox.
- Read value for requested IRQ flag out of channel's current_req
- unqueue an sk_buff that failed to send
- Move error handling for skb resize error inline instead of goto

Changes in V22:
- Direct management of the shared buffer in the mailbox layer.
- Proper checking of command complete flag prior to writing to the buffer.

Changes in V21:
- Use existing constants PCC_SIGNATURE and PCC_CMD_COMPLETION_NOTIFY
- Check return code on call to send_data and drop packet if failed
- use sizeof(*mctp_pcc_header) etc,  instead of structs for resizing buffers
- simplify check for ares->type != PCC_DWORD_TYPE
- simply return result devm_add_action_or_reset
- reduce initializer for  mctp_pcc_lookup_context context = {};
- move initialization of mbox dev into mctp_pcc_initialize_mailbox
- minor spacing changes

Changes in V20:
- corrected typo in RFC version
- removed spurious space
- tx spin lock only controls access to shared memory buffer
- tx spin lock not eheld on error condition
- tx returns OK if skb can't be expanded

Changes in V19:
- Rebased on changes to PCC mailbox handling
- checks for cloned SKB prior to transmission
- converted doulbe slash comments to C comments

Changes in V18:
- Added Acked-By
- Fix minor spacing issue

Changes in V17:
- No new changes. Rebased on net-next post 6.13 release.

Changes in V16:
- do not duplicate cleanup after devm_add_action_or_reset calls

Changes in V15:
- corrected indentation formatting error
- Corrected TABS issue in MAINTAINER entry

Changes in V14:
- Do not attempt to unregister a netdev that is never registered
- Added MAINTAINER entry

Changes in V13:
- Explicitly Convert PCC header from little endian to machine native

Changes in V12:
- Explicitly use little endian conversion for PCC header signature
- Builds clean with make C=1

Changes in V11:
- Explicitly use little endian types for PCC header

Changes in V11:
- Switch Big Endian data types to machine local for PCC header
- use mctp specific function for registering netdev

Changes in V10:
- sync with net-next branch
- use dstats helper functions
- remove duplicate drop stat
- remove more double spaces

Changes in V9:
- Prerequisite patch for PCC mailbox has been merged
- Stats collection now use helper functions
- many double spaces reduced to single

Changes in V8:
- change 0 to NULL for pointer check of shmem
- add semi for static version of pcc_mbox_ioremap
- convert pcc_mbox_ioremap function to static inline when client code is not being built
- remove shmem comment from struct pcc_chan_info descriptor
- copy rx_dropped in mctp_pcc_net_stats
- removed trailing newline on error message
- removed double space in dev_dbg string
- use big endian for header members
- Fix use full spec ID in description
- Fix typo in file description
- Form the complete outbound message in the sk_buff

Changes in V7:
- Removed the Hardware address as specification is not published.
- Map the shared buffer in the mailbox and share the mapped region with the driver
- Use the sk_buff memory to prepare the message before copying to shared region

Changes in V6:
- Removed patch for ACPICA code that has merged
- Includes the hardware address in the network device
- Converted all device resources to devm resources
- Removed mctp_pcc_driver_remove function
- uses acpi_driver_module for initialization
- created helper structure for in and out mailboxes
- Consolidated code for initializing mailboxes in the add_device function
- Added specification references
- Removed duplicate constant PCC_ACK_FLAG_MASK
- Use the MCTP_SIGNATURE_LENGTH define
- made naming of header structs consistent
- use sizeof local variables for offset calculations
- prefix structure name to avoid potential clash
- removed unnecessary null initialization from acpi_device_id

Changes in V5
- Removed Owner field from ACPI module declaration
- removed unused next field from struct mctp_pcc_ndev
- Corrected logic reading  RX ACK flag.
- Added comment for struct pcc_chan_info field shmem_base_addr
- check against current mtu instead of max mtu for packet length\
- removed unnecessary lookups of pnd->mdev.dev

Changes in V4
- Read flags out of shared buffer to trigger ACK for Type 4 RX
- Remove list of netdevs and cleanup from devices only
- tag PCCT protocol headers as little endian
- Remove unused constants

Changes in V3
- removed unused header
- removed spurious space
- removed spurious semis after functiomns
- removed null assignment for init
- remove redundant set of device on skb
- tabify constant declarations
- added  rtnl_link_stats64 function
- set MTU to minimum to start
- clean up logic on driver removal
- remove cast on void * assignment
- call cleanup function directly
- check received length before allocating skb
- introduce symbolic constatn for ACK FLAG MASK
- symbolic constant for PCC header flag.
- Add namespace ID to PCC magic
- replaced readls with copy from io of PCC header
- replaced custom modules init and cleanup with ACPI version

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

Adam Young (1):
  mctp pcc: Implement MCTP over PCC Transport

 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 367 ++++++++++++++++++++++++++++++++++++
 4 files changed, 386 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0


