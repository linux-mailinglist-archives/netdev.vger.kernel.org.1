Return-Path: <netdev+bounces-184250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBE5A93FCE
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 00:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7DB3BE357
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 22:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E33253F0D;
	Fri, 18 Apr 2025 22:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="gMCHtCWB"
X-Original-To: netdev@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11021127.outbound.protection.outlook.com [40.93.199.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E7E253357;
	Fri, 18 Apr 2025 22:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745014500; cv=fail; b=pbLz9qUp5zqNxPLkw9SpompRW31g0b6fowHZsOmeIpWruEKE4epnRLAzvjz+Jj/eeJYhqW76Z4rlXNVccArFKnVOKCCRHcN7x0R0O2iQ246AX/bxs/sEG7ujEASc1ITW4Wk+hqYmsXpanwC8JTuMBWJgUeMuR8leOBW9pKqfKMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745014500; c=relaxed/simple;
	bh=IRtq+hMcQ1Snp0q2Cw+8V3AaPMtfjd8XzWbiYffdjcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=buTk0IcyWWlcc2gVTn97YkIF0R2dETU1YuQ1ukqnDQWCloLNezEr5vSTC9L9JgqyJUZblf6xzqYLn7n9tstWwNEKJSo7lIagdZdOE6Ag4e66QBaMZ/+t5UHDo7lorVG8a4MyiFWFcqmMHu3alil+VZdTLYGqhPY0OMZi+eIhHxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=gMCHtCWB; arc=fail smtp.client-ip=40.93.199.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrURuFWTVH+VCFg1fDxR2ujkzst2R2fDJtzQaHLwBJUKQmsmp7IRH3TCLs6+wQQ28i7ffP4Adz+6aMVglwL7r/bLItlMM+Yi3jaB3D+CWCLvWfCikog+N1qUR+CU5v2m0XNIaV//sgulotTMfuV2XyiARY2YIcN+sWVTqEINEyrmTDQnBIjj9K5cM2IQjVF+jCvbFre4bkaTqcmx1IAsQVJe0Pr6sBGLCs1xPw8i5rQmB0e9eUb+AYBj0paF9pbEKiViqZpYQEh9x0h+1nF0cFdmUdpHJT7mHZKuK42dYzGIy8pV/nidcc49O4r4hEFO8ysfZzsUhgpFw1Y0ZhjuQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rij3D1p+BT0G5ZM2q1/2GGqZVE2Mip4why/IX+ZotcA=;
 b=J80oM+XFK6xP1cYAbnyUtfRxHsFJ7FW8C4CGQsWKDu2s1x15IAb6lTo8/aqj8X+wY39+PCSxMGAOCNDnBLPSpCwiEbrsu60mD+hqa1rBsCuzfLKTQ1HiVAhhPL1rydKvpEp7eGVTU6N5uMIGjC19YjgjSe/vF1ePtPcFibQj+xglrdD5UK4/yEGiSxPn+ppPUQzJGDCGvrpnAlhOA4gKG4jAaWpNzf82Mm95iDnJrfaPrRn0I/nIPhevphoWW4nJYXWsfnR1rGZmEkAaevzib5+vtmXGx4fxMPtALr7LQEIkIIeHnAOxRwAzrCCRqdqdEqYQvR8ZpqxdOIztj2x/yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rij3D1p+BT0G5ZM2q1/2GGqZVE2Mip4why/IX+ZotcA=;
 b=gMCHtCWB7IdnKjUk0a5jgaCmkTsoyMZJRXdkZlrk6ZQ+IXYlW7XWT1OKPaM2z9z8zMRoesWQyVQI49pHSolCKAs/kSCQgEr4wwbkQCleHWsrsnkUhQB0/WP2cpdf9wtyCNDka1S4OB9wQwdugjPoK0QMkYUnDGk7CGCnz593Cdw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 DS2PR01MB9277.prod.exchangelabs.com (2603:10b6:8:27d::17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.22; Fri, 18 Apr 2025 22:14:52 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%5]) with mapi id 15.20.8655.025; Fri, 18 Apr 2025
 22:14:52 +0000
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
Subject: [PATCH net-next v19 0/1] MCTP Over PCC Transport
Date: Fri, 18 Apr 2025 18:14:34 -0400
Message-ID: <20250418221438.368203-4-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418221438.368203-1-admiyo@os.amperecomputing.com>
References: <20250418221438.368203-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0112.namprd12.prod.outlook.com
 (2603:10b6:802:21::47) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|DS2PR01MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dd02574-9d4d-43e5-230b-08dd7ec670f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KXZreOI7bSAQvj0wIw8mchdG8OBXLMIj+ZSsGXUfJJnRUzDFRVIaiSuGiXPq?=
 =?us-ascii?Q?ZvJByaGnnrS417BCGxzhdecesuIwBpldQHo3uWtNuBUQgvAmIW5Z2ATqo5Ed?=
 =?us-ascii?Q?FLDRh78DgmN8sW2kVhV1/YCbss9i/c8R98+vitMkZDZSUC4PFQJhNNN/MkRH?=
 =?us-ascii?Q?nAs07IEjdpT3oEaRpp8oM3lbSS9eiiRgonUI6UfJ4LKdKSTjqZjdONXIsSyL?=
 =?us-ascii?Q?3alV0pAm/x5NVTYlXn86ahvZPS73BEhErT8aDhqAGiwv4GTkkje6I1+dDGLF?=
 =?us-ascii?Q?o41x14mzIGAcgGN8BC2Jl2r/iNOULv+tYamhKoo6qM9OYtdPKpeKkbLwZzfN?=
 =?us-ascii?Q?gMm53UHUw+Av4EGHuGCzVI0PZ+YdXLpQ4Fi76fIuswx50hloUyjA8uVO9FN2?=
 =?us-ascii?Q?AcNrgpBdYIQzOPIQOy2+kJKAOcERde1kFLoRPNe1MW7uEJYB6T23Mf+8HPUp?=
 =?us-ascii?Q?YXTuJdQ6qhigegmWW68By8BPwHafeX/sm0plFSVVBtBuWHvoV/v5zYLdSD47?=
 =?us-ascii?Q?pgofm+QkQhomiFybd56soHt0Opyt8C5XBXe1YwfvCfrDMgNjDUdbF7oUCY+L?=
 =?us-ascii?Q?meK/CCpVFhhfgPmcFVUrKgpVVFfJbJXJhcLcH5t4N4bT9yY7snX1Qpze3cQ4?=
 =?us-ascii?Q?UG53tALu0jjNqWeSAtpg//rzir+lTTyXLLYDrr7DqSUgkaeAm+jSNyxzL16e?=
 =?us-ascii?Q?kNRVl33X2DLhKe5OaOY0e0CONXaJi4TE6f2+4IIH5bInvaxjRxq4reYWcQkp?=
 =?us-ascii?Q?7U4R14LLoEhi31Sw9iPSY3RRb5X83Ki8kjeBj65cv//UgaZfRuuqAI5gsRKb?=
 =?us-ascii?Q?1nPIT+vMNNq6oc7KiqG/NJNvkHnnw3G6/9zIMxJFVEJig+omq2AbxitkEpXU?=
 =?us-ascii?Q?OuQDRjYOGtpFRhr20zNWXUv2/5TG2byRMQ+dk2xi8fmnUloC9ja1skhxjuHE?=
 =?us-ascii?Q?09Jxwv5XwhEH4EUWJOM00cXAF1rkVpC/RWuv2ee3aXpLZ9q08eBDjvsL5HFk?=
 =?us-ascii?Q?EVh21dlTJez2MQhsHUf8nqgjLnDnMCM3UaAtyjd7o60NzpluvGIJOXCUiwnS?=
 =?us-ascii?Q?zMb1sPAJb0S//ekVN4AivHnHKWg+hIyNGL2dfj/+VZDSoo3JkTdw+/1jP8Yg?=
 =?us-ascii?Q?8o7lMDkS+zbxqt821W2T/8ZwJittjlxZep5Y+6ZmscGeFr7Bb16a3gtkqMIM?=
 =?us-ascii?Q?/djOBqvH5I/cHUeyT3QI3flP87BfibVO/1siuQI80YgekzAz6CLHccWdeiho?=
 =?us-ascii?Q?oVdgMxI9ZAZqE+hnOl8dDQRLeQOqdL+2wl+vqMM92FejE0W74c6RZJ2cdpCN?=
 =?us-ascii?Q?fyG6oj611WnaAYxQBoQ7NvtT5Izj165FqCEgWuWIUmZrcJuKVXi7T/0pVDGr?=
 =?us-ascii?Q?dQzBgrM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1qDjvh+m4iDVDAFXHiE1iMckY7xbRenFVNKSDHMowukKlcdvnPznMBJpGc3t?=
 =?us-ascii?Q?uumDJFi9RvnohqUaWWQyGNQKrOpLlKq0InM0WFDazZLEyI/LHSz1lyxpmGjh?=
 =?us-ascii?Q?NI1jxh6+vO+AZ+Ebu/gR9lcCN8feTerbmnk+pmyBKZJ95QsIsZNXtCFcccNa?=
 =?us-ascii?Q?upXyaJCx93Jut2AdPxku/U0YkvHnF5kJkRNPITKDh9UKygbutEyU5UpBcYzA?=
 =?us-ascii?Q?7o6MQL9zz6orAvOkDj/YtJkk5Qve124QPxauKe863/OspGHieGsuwj83pY3R?=
 =?us-ascii?Q?f41g3aEVDLJA0JWHUJoGR5Tnmb5Yf08xwdxN/PbWumT7YVZoApdvEj8LwUbN?=
 =?us-ascii?Q?fxWCm/t9BdiJetZnZftvEeWaDynS4nWx/rnJUlN1t4kfxK1eD9MeI0FmsRvR?=
 =?us-ascii?Q?UIWFGCr+MyzfINH0lry1QLNy29FJYJfhzXPvo02j8UJ9sDdtNQUNr8AA5yrv?=
 =?us-ascii?Q?ypX8Qd5duAn2gzMuPxW6vh4TRU2/cf6dpF/Hx8cdYnCbrRW4cPRO2qw+phXD?=
 =?us-ascii?Q?ecLaa6lxB46D3nCM6/c/n/RuAJ05zztrPUDCYrG54TAgYcYy7ahglFORknwA?=
 =?us-ascii?Q?+rvJJXKyi7maVI8D1l42sURLn0dx3ZmCrAX6mn7gj+gH/ty32oikIUP64vs+?=
 =?us-ascii?Q?4Yts7dPfyIy9dfkIHwkra3SOGJ/Vxjj3nATR7W02R2dK0fu4o/mYUQLV36/a?=
 =?us-ascii?Q?7c5HW/jUv0zr4OYrZw4eUWRHP7AybrWcdIM1qudr1KZoqCOxTON2hqSojvf3?=
 =?us-ascii?Q?BsFBmYExtO2Bbod84rYlQg7/0HpgN5kRvm5QSUdcuczbiJWqtLnm8QjuuZ3O?=
 =?us-ascii?Q?XVfnfMr/MXlxxQLEx6OOGUhU/SelBt8TYaUGbybMSnyKP7VIkeSFLOti69XY?=
 =?us-ascii?Q?b7Gya8JXlzrj+FMhP9f0/OV+FR4uQyEtWiKof7oU1MotlVfu9SoOGo88mm0H?=
 =?us-ascii?Q?NFpP5dr/TQKrXofa/v5gQbn+842LH3JEPLN5y5qWCVMkGvU7XypY9/a3f7GR?=
 =?us-ascii?Q?NFGcLi2hbycKwHY85jegGl6Y1JGSD6aYxHu5frskklMkc5H3lJAthGLvZzAZ?=
 =?us-ascii?Q?CJLG28Q/sf2AU8Wrp4TNxj0iqapaXL2iVFJCXWr5/qc6T3kPqVkzOIQrjLPN?=
 =?us-ascii?Q?tGgsXr+51FaMUzgZet/+9N6R4rbmSN4Ntv+SGhCBu4YRXOloGcCxhXMyMRNK?=
 =?us-ascii?Q?qXCmPZxFU972VkpKdAz1LZpxO5n/T5IYKco/nlqguluFygvK7l4bEidzrkvI?=
 =?us-ascii?Q?B5ozs9d68mCiRmXGLbTHAFtblBnYNH5ouYAHnVrQ+SRjlIZOi2NhjbEB29VS?=
 =?us-ascii?Q?ATzbqD+1SjIF9BnjdU397Zop9UlxO2PvbrwpVRfJTrAY1nXNoYcmAck5EhB8?=
 =?us-ascii?Q?+rY2O8N45duI/6R7kGux8qXJ0SSXrbwGye1tWQg7+ZF6GuQrxcael0Bie7M8?=
 =?us-ascii?Q?CTfWuhP/zkY42M2MSFNTf8udSnj9lpuKW6fFUZ7QeyiKvEzGt2EvbUcaaXG4?=
 =?us-ascii?Q?hwIsz75vsEhSH4AtcgPzjKiwNbChlmuhgvUQy7M6sHorH7R6l/cHdGXTIqZ7?=
 =?us-ascii?Q?SB0VSiXEPV8R9C9lxDzO+/ynPqafCJ+cZqpjYJxxHxA1RyJCwrTw5XcIv/Kz?=
 =?us-ascii?Q?jE6TKbDqKrmo8YLSfYMTq9zRo0/j88bS1Zk0GH9z4f+ijjOhsu0Iy/5XqjA+?=
 =?us-ascii?Q?dhTAqUFzsEp5enapdBt0G8tgVgs=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd02574-9d4d-43e5-230b-08dd7ec670f8
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 22:14:52.2141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FAf82JTU5GPAarJyEu3zkfTNC83CkYUwamvsVsfJ3/ZWbT5Avp/kkxuYDmqaC8TpI1qlx+g9akGsQ5Q2stPdbN8C9N8PJUw0obA0EYhqxAoubA9pFelDH3jdnlo07PS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR01MB9277

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
https://lore.kernel.org/lkml/20250220183411.269407-1-admiyo@os.amperecomputing.com/

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
 drivers/net/mctp/mctp-pcc.c | 314 ++++++++++++++++++++++++++++++++++++
 4 files changed, 333 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0


