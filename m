Return-Path: <netdev+bounces-186881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1386BAA3B77
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 00:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5700F7AC7D2
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D612749CA;
	Tue, 29 Apr 2025 22:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="KGXMAr0w"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020098.outbound.protection.outlook.com [52.101.193.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3132326B96E;
	Tue, 29 Apr 2025 22:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745965691; cv=fail; b=ijQPKnujsT1NDWy/Z8xObTpyZTGK7StHJnwcLrTdfmZvDrnWXdyJYCrSjE+fJsxDxogqtAxp0lLhLoi9M5rceJY1iJVaPx4xjdn7UQGLBCP06t05g+PW+074vkEsXQrRl1+YSBpwGpeZGb030CySWbilDa/QGX2Rvrvb07RoKrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745965691; c=relaxed/simple;
	bh=CzZGjD12dtlZF6dKLg6UGFjiN2JRbWsaXB5eK7KteZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pRw13X74xcn/uLtgbbhErI+0NHhWh8Aw5yp5Uss/3RymvXp0RtcL3OAJfuyJFYG9GeKfM3IIDaOQoRqR9zLFeOVvAW+BYlWRDVJ95AcVMe5HRMQjET87ma/HFC4woCPPwogFpKfR2oAbQ//e3drWThkSAkEMj+/xLwDwsNPJIyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=KGXMAr0w; arc=fail smtp.client-ip=52.101.193.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvtVTC0DTk4iunpnsyrmxvuQT/YiPWWM4HhqBowGpd+H0JWLSOtwj2ilpc9/agHycSJcSuhLwyrhJQK7CRgTMDWYokHCUpHzGxzhFPTkzOQtjmNMztVW2VZKUnNrXxUbKA0KUOScQ8dyLAe8PW5QSpTbDfg1MEwDyaj7HB+yLBWsiQVmxwf1rRqmXKsvnxdGkr+1Cw9TVqfYpFtteqzj3i91L7/0lpUh6HyKKJwJEAbk/eV/yh6JE0/E0Rbcmzrp2rRtGMfPTsnLYHw4rC/aKPKSxhp5QeS7Qa+TcqRru//HcUhK7L3b6bpnhwaKWwINWV+pcM5jJ9GaJtX2ofrKNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcakV7H3DUcH7Jk2gq4ShC1QJwbXwk4gT8Uf7XnjHgU=;
 b=af55+giPbklZpCWZEYEqqcH4aBgp45c7ys8sMe1Xw9MyYQ1xf5Eq5rvsW7qDdBnovzlrSc1WttwtlWlYDT804dDv6MuDQyqx/WajUS187FffC2nlcV/0FsV9Ia9XjlU7VqYApDOSDZPBnKrRJIKEwKqMCzJuI0NgwkuY/YTrHaqTc5R/d8aTxCC8qq5e1MdpHMFwwRF5TIPD/af1sIU1QpnEOya2tG6sHuRJ9rrqaQUKLWr77Ga+VGiIp3hMOuh1IJn4LN8/KoSE5R9xQ6RhR1SvPgLuzMSf3MD4ktw/k0h/GJAtTrO6kvOdc7FpdWsqPpOB0gODLH2ZyExkRwx9Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcakV7H3DUcH7Jk2gq4ShC1QJwbXwk4gT8Uf7XnjHgU=;
 b=KGXMAr0wIYygiztZBSCgCyPpGUKfQzSiQzkih53JuJ8v3ruNkmsn9nVK7kBtOuORGPSKy+84Ga0OBimzmUJl5lpiRwfmbb7jKvyb7bek3GE5+eybOsSakplqxHklRqRzr43PJ8XVpV9tgjBvlNNrbUdYyLYsAJoAUrTWAskTJis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SA3PR01MB8016.prod.exchangelabs.com (2603:10b6:806:318::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33; Tue, 29 Apr 2025 22:28:05 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 22:28:05 +0000
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
Subject: [PATCH net-next v21 0/1] MCTP Over PCC Transport
Date: Tue, 29 Apr 2025 18:27:57 -0400
Message-ID: <20250429222759.138627-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0062.namprd07.prod.outlook.com
 (2603:10b6:a03:60::39) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SA3PR01MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a52ad2-61fb-457a-1615-08dd876d1c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7mAuAyM8TDD5tNhmzLd40/jk8jVwcdaYcJRQNjEqB/hMchVrc06MdmbuBq4n?=
 =?us-ascii?Q?2E9tEY3i0z06oHZub9yTvN8B2a9u1lTkb3CQHCpz5W0YcGAhlRey7frCBCY8?=
 =?us-ascii?Q?BlfSggeg4+Fo8j8Xbf6U/awxbvJ+xxFgrAF5CMNpyPnt9TV36qNacuLeaChA?=
 =?us-ascii?Q?eVZWcQ0H5EVat4mge8MHwH2qvuKnznmQF0uPkJblyiJUraN2RVgDrzohv1zm?=
 =?us-ascii?Q?JrUPUSGX30Wgp2hZ9f+W9I9e69mDcgUaia01oCiN7R6FIZpDzLSCETx/535v?=
 =?us-ascii?Q?YW1p6oXBF5lwmcGv8onY88eaxk5G+IpTfJ+mFxsD+hTVIeKfftybEEQXnUpC?=
 =?us-ascii?Q?Nmnr0oO6eF15FRdhYQ40F67uefIRhLOG7EYOaL7H+1NhKZ8HxyvS7YQyo6wX?=
 =?us-ascii?Q?S/LHR8db9zI+121IzYuM+VxQXRYDnXnmkvm6PQuNRxxr0serX+X80VkV3dfd?=
 =?us-ascii?Q?Fm0Ia7LUSRe5O+hy8mct6BXjyNsC5yPERNjIvXJsbrMsTfHVknE2N2aFcc9+?=
 =?us-ascii?Q?q4MI/zJq06ABssscOv3Xwt3QkugoVS6MbEvjJMf77waywUMaaUoFb88U4Jv9?=
 =?us-ascii?Q?ZVE7xxKpDWyKgNB8Hj4lxDaoOYqWRG7iEKU7IoCP1k92oDXHvc2+ddj+er8U?=
 =?us-ascii?Q?YITJzx2RrNqVHpKRauagrx9oJxy9x9lxvCUNQSqpdevczyu0vrEvf4Oy0w3O?=
 =?us-ascii?Q?sHcB+nnCpZDH0Y1lWRpqmA4APOW0objXP4QOTnbcVX4x0rJhnyEyL7VNHsAE?=
 =?us-ascii?Q?m2jU/ynIH0qaotBb8L9s8UuRcInjJc3mT2caxDrtM3CThRLJTzmtc6cv6Mri?=
 =?us-ascii?Q?ieNfrqy17YDJFfzud/HTukp99CdvsZeXsa1bAQQpU37c4V0HCVxJ0x6OPC8Y?=
 =?us-ascii?Q?6kISNoZNlhZi3+A51UlK6IQzUhMP+qstUF35pyre7CxhV8prLHdgAfDIg+7u?=
 =?us-ascii?Q?IfRcCBJj63iPFh/bLk4aP4YtZbWDNZRjNjVL5FfU7uqK39NwrRyt/80i8JmT?=
 =?us-ascii?Q?M7fhb9HAYx6qKEcZoxLrlT+tuiJbRDN7e7MQ51Bhb6kq6gIVtWmH5Z7kD4P4?=
 =?us-ascii?Q?esJfD+IJzA2O1nUlB94NXKWYVIP/rD+VydmDjOtcVyS3JVQoeY9IoG3A/ZXo?=
 =?us-ascii?Q?6yti3cBjkFf1m2zzid/VOtvFCUccEB3mRYIvOOmyQgw983wgljWdLqv/n1nb?=
 =?us-ascii?Q?4VRx0xVMWcUw5V9Jog2OhOJQFzAVWh0c45KwUEAkCD8fMvU9oEzkTJOy90IC?=
 =?us-ascii?Q?C6q6Doco8HuJ5hWar20qmHVENcPRWjhICnj4O/IQ/a613MUcYS7EwxuP1HKO?=
 =?us-ascii?Q?6JSQO9m91K6VwBDLsEGTRuT0lHN1j2HJMyEaCXgL3sNkkusI6RWhC69lDCxK?=
 =?us-ascii?Q?z3g7bO0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NrIPF+jR+ZuDi1bdTgpebR253l+6dFYs1DsXRNe3dr0vJw9ol4OAE2jrcFwA?=
 =?us-ascii?Q?GsMy/Zq9MDNDw7ibwbmqFpOoWtrBm+dePn4si2uS6i1Y1ivxsG+tO6pKu3AK?=
 =?us-ascii?Q?VemvjrRBzgP2pmWEc5n8LRyj1+aTIRIkxBOepI6OQAtU0W3mc1QiRR89G81+?=
 =?us-ascii?Q?xhztb4bmov6geldCnFMbvXTwxq54yBQ/U9W2a8JhFqzHJk9yzu4tdokpiqya?=
 =?us-ascii?Q?Pl6BERnpMBaRlKr7hlLq1mOrzp9TeJUHozIVWGXJv41CODFF1jleqIVnePJ2?=
 =?us-ascii?Q?QLX1bOBtGCSrgB6FWEmLLoDke4OsJrKkzPE7TOM80nIot1W3kx+t1IUC4S1m?=
 =?us-ascii?Q?QmGGV0njxmjImDjAPgq0hy6BCvvlFqFNIJmTtEjVETxIqzdWmO8vpYZ8Hdl9?=
 =?us-ascii?Q?5Av4movbfjZMwo0lSk7DtXulvxWec+y33pCnasDuC1OCEtR+FYkbQ8UIEy/g?=
 =?us-ascii?Q?01XVXZ758Zm5pqvMAzLjsKvxqpzbT0+Gfp1SRVU0YBCQ7XDC48GWQLRCOfUO?=
 =?us-ascii?Q?78aewb/qThpufCWiCFgJNsMmAv295ucQ545cfa+zzIafn1vvtvL1pVXKKGtg?=
 =?us-ascii?Q?TS3f1w6n3EeUIrWCWxSAQcoTB3P//kgTkmuns5OHCh/yyucinTd0uEwjrxPK?=
 =?us-ascii?Q?rTlT59SF7ncU6VAV6ILbqZk5ek/Dz1BFCwLamjGnvh4mz5HGYusFrLY06XtY?=
 =?us-ascii?Q?CSlVar/hVJTzknA0ZLCAWXWaEOh1QxsCyy4KuoTHFiNWGhPgItlDENtwWKG4?=
 =?us-ascii?Q?YvE4VOhQeZ1/s4vRgCgi5ozeiJA3OBLuOiJ/H6LS+2uJd5yWQRmXS5Sw+nhT?=
 =?us-ascii?Q?t2lVnO5QsaNB9oljVgGgT2wWSPimsvohd6tgb9nzaUBGVOHEPa0KdbiUlWCX?=
 =?us-ascii?Q?irHxhKVohFZAxkFb2I5WkZ/HwATDjAQ1x5xxLQbThPRjqhXIomTFwDByWUtl?=
 =?us-ascii?Q?Zq08IrHeP0H5KMrdqgEfBntq792q2ru6PvL8SYp0j2uXyqEtiY+MjOFKPA1B?=
 =?us-ascii?Q?8hAlV4m2vzpm4BjfzDJeyUltyl5lutt1iYXU2pKUbCtnF9YTgulNNnAbKhEF?=
 =?us-ascii?Q?AjERW1IiXzMhqz+WJ3m8ArX81gJsuQ7ry6JRRwsd2g7KuJTcbf26O78ufdM/?=
 =?us-ascii?Q?Cf54hJtS6ueTMg31rZipF4qHZ/WsB6SwGBWlZSLZLahLfzTb+WCtx3CSN2Kc?=
 =?us-ascii?Q?k3FlRX+RooAjiBXWz5ezDb2oNl2svpBiv1gD0sCsgKFmgS6RK/UHjIoTU8cx?=
 =?us-ascii?Q?M0dt0kV3Ss04+q41L68C5Hk4B1QWP8h90cn388H/6lMj9mK04FF2B1K1rprA?=
 =?us-ascii?Q?Q4qFz/70wb3nz6DU5rXRilTtZVTEZKHRcq6bMOSpy/P1vc68OYPI6rkT5heQ?=
 =?us-ascii?Q?YK5HWM05p7g3J15UN/4/zHYt/pRg0HDWbRR+Ws1FArDdW6IEAsWIBdKYarYA?=
 =?us-ascii?Q?NobWl3Ub5OsfMeN1PL0BVGsq1eGAh24Q8YvdB1jSA2+EAszuLtmb0t54Aiz5?=
 =?us-ascii?Q?k7xHiDpFFJ+PgJOJ5JJzLkaqWt44exCRv7/F8XRoXBOED0+/tmeLjpTNalxC?=
 =?us-ascii?Q?o41MUYZhv3ibDAGopy0xAsUKcuZc21V7ziONYNN3ypB0SmkGlhdDtmDLJ0is?=
 =?us-ascii?Q?1IKKH5OtaAzS6fIdf+zol+wFgLXxSfgIcEgXLCRK/cj09WtaPGe/u19W8s29?=
 =?us-ascii?Q?Ouego8NbS11Uy9U6eFAvGMADvBg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a52ad2-61fb-457a-1615-08dd876d1c6b
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 22:28:05.7240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEYWKNRw5FuLumErJKIxzsmj+8nkcjhQSbUX9pODFrdeWLX5Y0qEZqIi7AAgxZhTzokOHodr5ZiCi/m/ssa85ydkA7a4LaBJnmVuHC6A3j1uJq+pos8no+jgW2o4rlvs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR01MB8016

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
https://lore.kernel.org/lkml/20250423220142.635223-1-admiyo@os.amperecomputing.com/

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
 drivers/net/mctp/mctp-pcc.c | 305 ++++++++++++++++++++++++++++++++++++
 4 files changed, 324 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0


