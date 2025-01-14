Return-Path: <netdev+bounces-158213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DADA11135
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 20:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86354188A6B3
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 19:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4B71ADC72;
	Tue, 14 Jan 2025 19:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="RggOcK1N"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020132.outbound.protection.outlook.com [52.101.61.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11508232434;
	Tue, 14 Jan 2025 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736883084; cv=fail; b=pu3jQ6aqdznDpmtxQsJQTGMDSF6YIX7znCEjqf6j+JIeOWJcIwHH79UUKWyiHzhHHdmhrmhr78pm9yX92hOfxfb0z3BSVqh+InRi/SyWVPNw0FjCIZhWvU7on+rckCzCFcNbyvm/dM/WBciuzxq91Aqe9q31SdZVqcDEH7zFtTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736883084; c=relaxed/simple;
	bh=pNkASLfyFZrNUFXRDydd/fUOV1LV0hxya/ncjF7INQU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ltursCIOJF3P2CewLfmFD61hJVq6DL5oAT4ryVkMb6GaQq+yWr/27Ah4iQPQYZeY+uDFC7l1lAkXJ4AsW0ZbNNrI0CcBLBxUZ9REpheLTEi1i3AKdB8rrQMjxheECEHlkZX3N3cg3T+MfXwmGI4as0kSusJhDuTwxPflaocUUTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=RggOcK1N; arc=fail smtp.client-ip=52.101.61.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGTSZ0Bgr3hb8WCv/V9xDTJmtHS8kk5dNg8NafDcKMjuV89xTF4ZC4zjgSE3IhZbkcEd02JkjMHz0mjLy2yOhWHoA0MY9AmSR8HLyNALfv3Nh+en0raZM6C5g/ozsnMszIEze1+aXy5k/9nOagOzRB3EnvW/rQRhsmGFW+nSV8zLVgFEtjqh6iC5uqCLkD3esE5aYWcZ80wgTHxEI9WsvVdUkuezG5iGSA6Tg7oQYAOZlHyXyUfTjw54ksi4Jt7xZMJWSWXM9Yc+QVPSf4hBEDQwV3r1dAOdz59wCg0DaJha4DTk6H8F7cx14AGSO3c1QWVsscl+OLaDs/cZ6MM6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bl6t4T8OhIuszhIqZoX7LhOpIAuFb2MW1ayzr/YCoQ=;
 b=RB5d4tp9vFdAwlTBbjGMOnWMZVbqzzWSn+4Hq/gnzYxe1t3apKx0rTq4UEVGU6zaN1IQEIACMA2cFJoRto/hmp75L1/TxqXL2JHKsBAkkJsAlDbYWVh37Ra+nkJVmAVTGzpL7YMrqMqk1NeOlvHQCGFPQv/1Nm289/r7x+wR8YbKonBCku9MY0ay/99S5XyAGF+hNHhdvAKsUCZ3auDT+3Wvt+I8zD/Pkeyxp2sM01ScgdAkepXHi+XC8tWAgl8VO3eNcTvSwezpVIF251sfbocu9lV4200dIJ83CUUUlH1ZHoOpbT1x4Z7rjR8muvk/twX7TxotTOv0qu9iBj14gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bl6t4T8OhIuszhIqZoX7LhOpIAuFb2MW1ayzr/YCoQ=;
 b=RggOcK1NJziDGl1vlYGDfH0ihPh4PNcQxQfiCE33bqV1IaXnyRy1azh04tUHhR/SS681KEoDUoZAmEzoVx/UjT/UIrs+PaR6SO942oZbZChwqkSFXIBcWcoRUn8a5nm+JkNKCPv2S92zJVClIHn0Va992AiNeuf/+HNzLrh/VUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 DM4PR01MB7763.prod.exchangelabs.com (2603:10b6:8:6a::13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11; Tue, 14 Jan 2025 19:31:17 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.8356.010; Tue, 14 Jan 2025
 19:31:17 +0000
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
Subject: [PATCH v14 0/1] MCTP Over PCC Transport
Date: Tue, 14 Jan 2025 14:31:10 -0500
Message-ID: <20250114193112.656007-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0107.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::48) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|DM4PR01MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f70f605-94e5-4759-1742-08dd34d20409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u9/O9kJ3RaQVt55BfMDysi4t9cg3/fSBVUTAeEziCHxJMd2itEGvSgz3nLOq?=
 =?us-ascii?Q?7D0V/vBNI/emP1FMnF4IWnIFv6NmbOSDAzeLk9Slbnro6G7NFii9APVGD4L1?=
 =?us-ascii?Q?P8r0swWT9PumTulhPEDw4jDohGgLdiLTIrGqRWTQ3UyC0dRvKpX19eIUANDQ?=
 =?us-ascii?Q?tyFwJd52UZ97/L/4Y4iV6SvAQ05iNowIpQbqDXnqiBCqeDT3wYao1eaVbZ4s?=
 =?us-ascii?Q?B0UmcG2SxMWFPmnH817Y9/W/mGUB/u8QniLHbKF5pHSvo6ovrIJPMi4Wssm1?=
 =?us-ascii?Q?cS2WOE8UoMvOSGRK4pCOWMswUF+KhPjYlNESn/XDokbsdx//LqctLA052U6X?=
 =?us-ascii?Q?ZDeC1Nt7/xSnJ42HOWdosQQV05oWSvlw7++RdTXdlXNY18c5CnT2ucm4oMsB?=
 =?us-ascii?Q?NuUhCiMfuidOCg8sSHiI6jazCsFFilS9RXRJJnS/iTCul3/OLCx5vyE7TTXy?=
 =?us-ascii?Q?gHqJGSPTDiPoBDWiLUbxAizRgegkHRta1ZFjEikZcONN5Pk+HE9wNwRHWEa+?=
 =?us-ascii?Q?3ZdJpJ6P58uUEV53nRJwVpMBbKX0VxE+MYjP8XEKau329OiFB4qlkHwPavaI?=
 =?us-ascii?Q?DCG1ard5ktX4vKnrbVporG+HccKF91xH5ILXVw/SxVjTn8gWToe6mBxTjRla?=
 =?us-ascii?Q?KE6mdIBBc1LCBzeUHsVDma92D+bXcVIMf3Jpp9Hrbjvwx4Sn2AtQUi/W+lhy?=
 =?us-ascii?Q?2nGk39GQlUyIV1Dy+NcdrAfuO8Ka+T8lCgfUU4giUV3KcBjAvabiSxiDK6yP?=
 =?us-ascii?Q?Ts/aEQWKxPY7OVtin5gY0UuJMyfe0jNKNWWbZ9EQYUredE31yP/BhIY5CbIX?=
 =?us-ascii?Q?Rfwt0ZSCdN7Y6JOIX40ahXO519eLdHUI3HhNOqv+mErFjtazcHcng/q/b1jP?=
 =?us-ascii?Q?2ZQRNfSobA5a8seUp/JzcopFrE31CafvVz+Etp3RUGtjqwfKothvcf+lF3EB?=
 =?us-ascii?Q?fIGIiMLtcNU4nGlkB/lhfSeghUqDKpdEv6ZCJb5pipEm/Plj88QTPd1dFkxH?=
 =?us-ascii?Q?KX30unCXq2OQFsF6AObLJvHwXZJE0Y3lrbceTyb2T89gAXUlOE7+Whp5F5OA?=
 =?us-ascii?Q?afpBQrtsJLC4DFMEXAdF+3Pm8e7RsOTeFK5r1pEektKMP35YlTeF0D+YlORX?=
 =?us-ascii?Q?c9Lgk5gSL/347M0n/x/UP3Nkd9OxeRqv1E31uC2YLnWWtu4r7oyLPr6DX3Hc?=
 =?us-ascii?Q?uj4453Tr/ZJticujpeWLY5gfpm7BVjsK2fVHLEN1pr/mwdkcyjXD62GljjhO?=
 =?us-ascii?Q?N6C6gMkjeVKbXIwqXUwhgeLWzidlr2RDrshqxl7rdSfPNPeC4daL4ZmkpmFK?=
 =?us-ascii?Q?7CiQ6WhRVhD4A2lcWUHX6o8c/o6KcGdIMHXGEciFirOFlQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bO6bumsBZ7Ra7n+Najxzh+oloRTasSU4TC42jGhHn7Ss0WehVYSgB4sdvCUE?=
 =?us-ascii?Q?psZcjqW0bjsQYDL454uv9+1IlMjXoUAPekVw3ylkrFb8RLwtzxtbsdSnQx/a?=
 =?us-ascii?Q?CCn3ysEHR3Et6EhPqJfDUQKN4hZfoQatX/XE/daCFtB8uhUawJNykL1/OwTg?=
 =?us-ascii?Q?8ZejqjpoOaemODKKg1GUxaB8Sdfoli3qT9bJVZsQBVuJXVVb+3grP1m8ZOyQ?=
 =?us-ascii?Q?3mxUION8hV/UvtHkMhw9EooTubLvmhsQT1O3IA+8QaQDd1vuCix7JJxRmevy?=
 =?us-ascii?Q?FRipr7ST2Id5yfPQL+tetq/KTkyKIeKVpaq6zDCdGZFz10Y1iYa7N69mXtLO?=
 =?us-ascii?Q?Opg3qRWXKvokqsdE9SLynfipZlC6vHmDnIbvOM16t6MeThVgBPoDsOLBDMLf?=
 =?us-ascii?Q?nME0n2u9QSOaJdualJxlq0OZX1b2hCsW2InC3WBC+4p72T7KulEmQkbaR1xj?=
 =?us-ascii?Q?eQgYY1Rv0lmecxOaOv4LAMYlIYw4ydCRopVGHtBoxaQUlSKZMf58lW61OSry?=
 =?us-ascii?Q?wz5/Sm/6gYQf+Gv7i7JEp9ZU2EuuCh5rQx392nhcNxpGfrYDM2dDdVq3qtld?=
 =?us-ascii?Q?LoF3Bh+YPLZHEqbsNFhS+6YNvjLBWhrxghiYluG7puXsdnKi+1Y4Or/2vPhP?=
 =?us-ascii?Q?2C4ejDgFe+suplTaPiCL3ddT058sKz3otqaRcVMdNB1dNQsCBLmxHZhgkrzt?=
 =?us-ascii?Q?CCgSaO/t1YlCibCKeW4TN0smfPniLPaMO/btYSfRNzhtwccJqLpCidE09rHO?=
 =?us-ascii?Q?3C+4DImaNuke2OJ9sxYEjCxvo6M0NYGEEf88IWEEVnmE1vUmqs1zxiPxCggU?=
 =?us-ascii?Q?ciJNWDXayLq/HKhixGZnCxRf5jeSvl3KOOqzVtDOSPNlQhtGPXOaSHxcmM0I?=
 =?us-ascii?Q?P6dClKOOo5EwbVWOKbbxZKUaFvSLsB4R2y3RKzxJf7colfBhN7ZTuMtHkc3K?=
 =?us-ascii?Q?lRukFytkj2T3V5XCI4USPTi1Qd6oDK1vCEfBtMqbPjT4+N/ssSS7r6XKkWSR?=
 =?us-ascii?Q?d434GmU5rYCOSs8cZ5flVg7+tTZ+QZyGlDMgTpbwhV37UBRTuNpS8xxL6Hsc?=
 =?us-ascii?Q?oCN8i+8y74mdxkqu7Q/0PxsOVwBlZn8qFFgLErqw58RiDFChn7nwrLUNgORn?=
 =?us-ascii?Q?BvjPENofktmVsTj7U2Xip2i+rA9nS1QQZnEdsGiJpR1e1isaqIJVNp8CjvWa?=
 =?us-ascii?Q?vGvZW3M2EsMmIyD6GY3gF3gaLLgs2CPrxP3sGgWc9is24iuxWel+yZLXplB/?=
 =?us-ascii?Q?SPo411JdTFVPkN6UPXk7Q8Jkdk5tRQDqdzPxdL1nGiRZhGWD3l1vsJrPkWKi?=
 =?us-ascii?Q?h0sMp9tT3lUPpHweo6+UM/KeuV9hRgg6mSm25hBKi9ipVSqhqaJbU5AErf8h?=
 =?us-ascii?Q?g2S6e8113FgCuWUf1f0GjyTI3xHWFOy91DVFVoi5mLxRK0boyvR83HF0Ot1I?=
 =?us-ascii?Q?V6Yv1p04x8toq/T7/blw5O36soqANFWWGBrW3qx0/VCT3/Aquy4Bp1muuu4e?=
 =?us-ascii?Q?dhGmSYA6Q5dGlTU3T0foAJJklrrKeC1pvueKY6gbD9tUTcyCami+T2D4gWXi?=
 =?us-ascii?Q?wa8W2wJU/nQe8Hs1V7BrzwPHDhqKxbD1wvLG9Iy4g+ixX5wW7A/CRl54dawM?=
 =?us-ascii?Q?6z8VXz6cAZgDrTmeUSc18rvVmVOnLymkoJGb8Sx8Et1tS9mjGhtLK0KRWW8P?=
 =?us-ascii?Q?eBUsdoueJG91/J90qKhYfaVkck4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f70f605-94e5-4759-1742-08dd34d20409
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 19:31:17.4836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfNOW1D/AtVCIKRZIl31Y+okQamcwMAgOd54dmHCQ7M6EBFnmMvTwV696Kmev1ZmiMBs8vNU9mx0MycTh6ploitxQ/OIYDKoCnmX35fX4Iwrcs17L0cuHX77/NJ4nnCE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7763

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
https://lore.kernel.org/lkml/20250107172733.131901-1-admiyo@os.amperecomputing.com/

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

 MAINTAINERS                 |   6 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 313 ++++++++++++++++++++++++++++++++++++
 4 files changed, 333 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0


