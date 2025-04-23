Return-Path: <netdev+bounces-185291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F01F8A99B29
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 00:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE891B82C84
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 22:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9454038382;
	Wed, 23 Apr 2025 22:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="AvDpjFzk"
X-Original-To: netdev@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020112.outbound.protection.outlook.com [40.93.198.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585CE2701DC;
	Wed, 23 Apr 2025 22:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745445714; cv=fail; b=TGJ0MbwN1/h7KJ182NG+4a3iDf9hNurjxWwT6wzz0Aw6KKf1mE6PkHa825QsX+6859W+pBpDHtP/9uAvpdI9adfJ+3ayonvapVdX5PleXq2ozGFpYxuifANIoCqJ0H7jX4Yn9bHPDal5uOhgOnZYdAHk48dHP6aIKWcsK7zA+1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745445714; c=relaxed/simple;
	bh=h0MEBCIsI5xifwjR75sdQzgeikVgd29XtSiVSf8Xs08=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QROxLxqixxzsk2eU/rpbtipoOsUryeKKmvgZzemVCQp5kadQUb4Uua8hFpJ1XZVWKQhglgPvREqmlzWPSA1CNplrpG0JtmrGf7NJupP9El4DIaIybbJw+qyNFrkpefkNEkQjjkbAdq7iyGfgJEqLFT86P1BQ5aUXzV1csNtBmlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=AvDpjFzk; arc=fail smtp.client-ip=40.93.198.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZG8ZLHppYI3e7oKlyzZlm3vncb5X3+B44+sG6edMqa285M0UrfydeZidDKS+E1q2cm1fSc2gbNhfXhDsKFxBQL/LZj7h2HnEg+U8lcof/BuRVCQsJIJ2TPiDxn4LEd7nsOxzWa/F2assT++Scau30qDtTTa/089ssGqTTXuQbhrwmBnQ0ERO9uKkyx7wO4KXNDA4mIENdL7l0zzeooLIe9Kx6IYgrvd/sngOuIi/nOF6ErD4eO2d00HoaaznTaxGFjdNgK86FtgiDx0mUPihe0WKM2z7P8HMUymyuKEc8yNPnRU+OybnxbjK1H9bGztp+iolIYuzPmIz73nq9TLWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpVU/igFpU5xw8ErEo3H+2UfihRX5ytsvU2Qr9vCLcs=;
 b=rBJVnz5epnyZTRgwyae+WzDA2lEt8C3CQlrl5/dXWIrcmWDWB2pbA+ERM9s/P/igSg9nZZ1GREzYOQ83mxrvLDZMBXLXsWZR4F38j39OQYew6HB9v0W7PSr+wYyGwi7UvKLDbuf0WLuREguD4XOIxmvgweJVAi148cg0ClmDx0rd4uRs1rdY/cQ9er3Ph8ko/IYUeIppa2KxaX1TWm+wBhHdCmr98oqBC5Csj4hTtQeP/uUcx0CIOkRn9ngrYRrvwA8nUGg/xipuwFLCcOjjvUZ+xelhNLG2+YvKzgwv01M5bcJmdiYt0IWPNVTUQwVwBjmKdCejtij9lsiTdF+RXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpVU/igFpU5xw8ErEo3H+2UfihRX5ytsvU2Qr9vCLcs=;
 b=AvDpjFzkP9JZELS7pbMV2N9oODKj8hWJ52k9qGpsN+f1M+Zzg76hvLV1H+eIn+Z/9psbpaKQCTrctT593EzSgkQqTBrLnq3LFvMoI4IWCeZivD73+hVy0OZElIki2OhcIdA6o7ps7MQyCwcmt27f5Bs1KdUT+iuP+dQPMuDDZ+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SN4PR01MB7406.prod.exchangelabs.com (2603:10b6:806:1e9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.32; Wed, 23 Apr 2025 22:01:48 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%5]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 22:01:48 +0000
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
Subject: [PATCH net-next v20 0/1] MCTP Over PCC Transport
Date: Wed, 23 Apr 2025 18:01:41 -0400
Message-ID: <20250423220142.635223-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:46::12) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SN4PR01MB7406:EE_
X-MS-Office365-Filtering-Correlation-Id: 57392434-d939-45b0-b790-08dd82b271cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9aJXb0wOBfpE9oW9RuLEvfHfgUrLCvCCIL7fiJrRFYTpAB3H/vX1HopSCydV?=
 =?us-ascii?Q?vpaE2jOrU8sYIi1FeMdXd1bFWtB5alSpc5Ee+gEtJwS71flr3MlZQRfwqITK?=
 =?us-ascii?Q?gLsGh6L7aWYobqGIaokKoUgKRtcaWGV0xW+DNYhfnf1C4+suM5IjIOKV/ord?=
 =?us-ascii?Q?jbeLhZcJXazyHDxrBagvoVe3FqUWmLbma/5QMsyZrJind5Gm/u48FBjuMntE?=
 =?us-ascii?Q?Q//o411PYmXCfFCXsHMGxqcR7hhWNE133awRwk77uAVQnm+lA3xPZG6Ehdvc?=
 =?us-ascii?Q?/TfR3w47+4Nzp+rcDOCMDQ5XHpW2Z2cU4t0sFA1KdcM5Q0uNxhgb4+e6kr1z?=
 =?us-ascii?Q?x2p2eSAjiabEXlwJZukCQ7ngqzpmII6FWGAFcbve+WxX6aVI/MOWouIeTetX?=
 =?us-ascii?Q?gyT43IFvuQxPVb8Fvmsix/ZcjdnwlWLyBamxkdTHdGdFFXNFhwuLenR2m5Cs?=
 =?us-ascii?Q?6rLsCMtdd9adZapp/Wt3Wfob/NpkZiSFotQc5C8nLM3l28ah+KdhZjL5tzF9?=
 =?us-ascii?Q?RWDoxTpqpLOe2w5k00gJCRnzg8Bn5EiUDEi6xStxe66HFP+EhkKcNVlp4k9h?=
 =?us-ascii?Q?Z7ocCzSTBp3jh2U4Nmk2czvz+nPR7Xw4UMF/Lnm9t0juFD/ix8/OMw7VONb+?=
 =?us-ascii?Q?BLutYnvjXo9jl9EVziuI/NwpfthKLbgubLPRulj62l3MVX+zBKXaxEcbBGNS?=
 =?us-ascii?Q?r6xzXHVcdxYIpenMfJ7RuVbp8U4QqwmnGiZW8D3stw1ijTpoJ/qtNDKIbi8N?=
 =?us-ascii?Q?eaTak17OpieoW8qxuxH8pzaPPbScA/ZJIKWFRIso8owK8iE/ImdmKjhZNIBh?=
 =?us-ascii?Q?71pbsrEnhf3XGstRFGySuRSbNIgFDoMeNgf4FTC97nOqW5m4eEt49yRhF78Z?=
 =?us-ascii?Q?CjdAn2mwColTX/G3fs7/jgEJyoa5AvfPoTj2R6QLzfuT20rf+rcprTsusoqJ?=
 =?us-ascii?Q?+0UDgDyNErHn4dhIuPGnH2easmooQRYW+r/336oDk4WUxZNjNOV2ejGHBGPB?=
 =?us-ascii?Q?pZejH6HPn2JhRzUs0iP22P9VZIEwbnFW/4YawMyYrDbUe60xZuo4djvDAxM/?=
 =?us-ascii?Q?EnJrSqdSV4kgAbROJ1aZ2WJKz/fTKq3VPs+L97uTgPyoBNoyVL0U/p4Poy4M?=
 =?us-ascii?Q?MPNwLGjlqpWRH6NYkIW3aFRrl5DRZdzwfkhGLjd1EdSnJ9oSgJ8wjqPDhdzu?=
 =?us-ascii?Q?UQQ3r8nNdc7HieheYkIbKCqzumaTaurzYEcfv6YKrxjCaR5r/tBCZkRwxCAc?=
 =?us-ascii?Q?qEt7OeGIIbQS0Hcm05u1PBWELktxcZ93BN1wLJBdL9/omHBgPhAuflZiHter?=
 =?us-ascii?Q?w8asEbR8dch3UfugwvAIu/OKH+k7muMDpGgPHMSqFhLCPQ8p/TVfZER4q2gy?=
 =?us-ascii?Q?qAZuW8U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zAd0Mgfy63Qzo33kdYT49QQWa9uKOgi/WqRToqZ1J9ZyMrQaEQtekYMYl/dx?=
 =?us-ascii?Q?dmPb/1QISsnWvf3ZXOWoQ+BY8iM2rnTCBRhu4hY7PjdP33kU+s7hBr+P7tPn?=
 =?us-ascii?Q?d6zGNlJKTWMIFynk1GzMGtBJn8a+B8TWqqREbCQDOvLH8C2rtSkJ8dnYTV2y?=
 =?us-ascii?Q?3v2vcaDR0kKg13JvF3iaymcclnaxT8NDCwrVkNjZBJDNukC6JaAo0qWTkBB2?=
 =?us-ascii?Q?Vb8ms+Z5ta0t3Mblj3FdUdiKAZxW1IaB9rZIZLY5dN/VNstNsBLMx7TE4h8t?=
 =?us-ascii?Q?lkH7IJQpZ5Sr0ZDroXe3odKItl/qlufXcLn03qLw3d5GJhJOKUDM5y9V13AW?=
 =?us-ascii?Q?u18YX9fb7xKHPHJHuFXTovQZB3aukKaaHstHSpqxvkm8mhQVrKjjQQb5rwSN?=
 =?us-ascii?Q?tLFSynzczJOq6bBabrz3j+jpf1sskmP8BHFgonbipG5ihWo0GY6NWguFAZ7m?=
 =?us-ascii?Q?/RbyibUYGv+5HWt6ftk6H9ksGn0K4t5LPfKQ11QiDAhf9JyYblV769/DDxLe?=
 =?us-ascii?Q?fzQ49YD4ztryls8gM+/2wgyhhqAb0sgJz7RnfnEqOPi3jxJV06Nclk2BIikI?=
 =?us-ascii?Q?kYu7nDZNp0MzW5H1Rg5eGeaArRi/EYm1Qp6rWD70cQpuAmdI8ux7YvECz5jj?=
 =?us-ascii?Q?HmVlIe6pbOSRYO98wT/ZwWKjZ/1zTbvg+69sxAu93uaN6ZK2c0ukSzs35OeE?=
 =?us-ascii?Q?3EOziFWTK8pz5CMHYyFWirgjxOY+EF921HRaiZqhUuJE2sdeVRKBR/6tNN8J?=
 =?us-ascii?Q?wKqDHId5lIEa0saEo6kGceecXK+HAgF+HgkO60xe62N6NYns3hYkvp4Isho1?=
 =?us-ascii?Q?Bf0q8lfitEfuc3bzsfphOo1+AohKV+QNGA9fcX/UDuRZovSDFjqaF6J5OslI?=
 =?us-ascii?Q?KgsIGTzCVY4fC9srZBZRUwqKEeKHwYfeTWWU+yV6EVIMHfOgbDc7d7dhEcRw?=
 =?us-ascii?Q?8hphYLb2Jqu7km+ins24JCDVjPYx6e3Zmxo300MfLZ1QShItr7Gm65lsgGlJ?=
 =?us-ascii?Q?s7ySwjdsc3m657WBI5rDzNtHq8IeNrHAW4QMdF9l/b4y78u1J4A/MLvcvn/q?=
 =?us-ascii?Q?6biRHP3AMaAa1/9u+3tymZlk6+1wghWbqqjbyVIOdxlkGaSQ9LwbyTozjzB1?=
 =?us-ascii?Q?0YFG/DioqHODimRx0aR0V5ZxcHisepq8z28tfh6DYP+n2x86xQICVrM/Mxml?=
 =?us-ascii?Q?RDZRGvfiSiOY6l4on49DdavLIBCkGfUnvt9+8/I7Srb7HQHRXfMJoAXU7Y0P?=
 =?us-ascii?Q?exWXexsFW2+5W9KSQcbUJZqS0KkqqsCsljSNUZbbpm5mxZJS4f8BHpFMy0pX?=
 =?us-ascii?Q?pupyQ3grGLRaBpcUTSHorZIYGyZVGmbdfCoH6KKujlFOOTpzYdnyXVZDuTFV?=
 =?us-ascii?Q?fzSnQ180bKoXlJMxL78jhCwhO1j/o5EBLqKbzqQ9lRm3zk/M8RHCYdeFOuZO?=
 =?us-ascii?Q?GSeNsRNEKsI5THknYcxltHYEjB98FOfo7BQ3g1VoLstzDMKzLdHeGvjXsW3+?=
 =?us-ascii?Q?Xzv1BzFMgSFySsmInGdWw+KxVzjDhvC97WPBD7r6GH3dqnBf/All1RxCYN9+?=
 =?us-ascii?Q?VIJpRKobdg0/C/Z/Ne/Wmx2BBd6stIwAvDnrOIaPt4MaGENJNJewVLqwvmcI?=
 =?us-ascii?Q?RR6Kmyzl/IOGqnsp16AW6nieGcUgKBlGqmyA/09qLfoxM5gM9zlSfDy2RK9L?=
 =?us-ascii?Q?kD8gedsTamFkNkPWMqLXoFnMz8E=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57392434-d939-45b0-b790-08dd82b271cd
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 22:01:48.3333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrn10mBhWtE/EaIHw6m+kDgALZ03RkMyLHiGAtsRTVkl5qX25zvPoHLfQrBGvFrFP0DA27G0cLJUAsmuReV+Pm/E4/6sm+barNl87MrorVwjGGUz0eL+8JdQFqK4sdiS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR01MB7406

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

Previous Version:
https://lore.kernel.org/lkml/20250418221438.368203-4-admiyo@os.amperecomputing.com/

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
 drivers/net/mctp/mctp-pcc.c | 317 ++++++++++++++++++++++++++++++++++++
 4 files changed, 336 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0


