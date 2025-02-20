Return-Path: <netdev+bounces-168248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E15A3E3FC
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 19:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EA967A1FDF
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E08B214214;
	Thu, 20 Feb 2025 18:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="D9KR6Q5Z"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020110.outbound.protection.outlook.com [52.101.56.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4213C1F1906;
	Thu, 20 Feb 2025 18:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740076461; cv=fail; b=kDwTHA4OP3CsiDg2VK10QskE//yVN/rzWKH+ZlliBFl1T3+Huu46zsKKxrYToHf5B3VChijCwHl4GI6lS6kmiQHdum0iCZ4Yom5+B67zNVcqxH91oV3qjvTW+eyPxuTpIvRJ6/rpWZeHe0bKy/ebrWA0wTDu+tR2O6LVMxc7wBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740076461; c=relaxed/simple;
	bh=K1cqUEZm5vDXwAmf88/Q2onqRGgHY7vEsZH658jGYmk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qCb/hZkr7DwjwKLyfsfoafM+ZmLc1Kiln+NRLLZVcuF/Sz3K3Z9PvpcYmCHKyM2CgAVddb7k6EBluM4EDT4Pk1yrsFRhqF5ZLCDUc8T/uRkd0bZm5+g0vMWLYNbroFWMIHY++Q+aThYorctW7em3NyBXK8EM/qogeruzhvDjJYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=D9KR6Q5Z; arc=fail smtp.client-ip=52.101.56.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXB9aaiGGaoUkAcndFmGsJWolOCqSXdciZ0ytdahYwSxlJ1+wYIpntNyL/KVcvj5+pF4UnQZGyBvRy55vSEGzC9K9TcvCx7eAMdEM+0Sk1Ek/RuZ0Dvq/FvmJC7KU6wmZw4Mks/sb2cvqD9JrGyHjfUkBifZQRb53hU7iqENFQNjYdFe8zqCgwTa+s2cCQKqMgc0MVv2s4j3aJyBqoXYR/B5HjLIKg3NqJzuaDvU5IjJf3oJmjkdzw8Hk38i/Nqa/75mrkvFIECY0XoHdaZX4a9z4PR4KWB4AUli6YxTBihKxSrm892XZjZMEmc4WpXTbJmLiIuF5iEeTOtQTq2d6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24n+1lV1Q9C8P+askK5LlN6Vs5I4g5KvJWcdIGUynZ8=;
 b=B47bd3h2u7VZpeU4kk0a0BmYQjX2hcE3IF3/hI4dvmZfRqHWA5KIHd965jj3Jw0oK7EhQPity3fWideMIz8DkQk+WsCMYmdfmlLzWb1WptJP99yDR5T8MJMUm01bokid0q+4vtcEZhukRvxfsrNZ2c+0LHb6XQujeq2aqHZDDn1O/WCAR0be1FlpA/U6QTvEszO7Q3iEQOQLWdeD+Lgsday08+k15Lct2gsxap8okVub+fgLeqGChQAqU7AFgKJAS8d1WQ5BBupOBcMFhztOr7siCphkt3wXOfvKiL5fZRjeUxZcpnXWJ5TmGI57am4n0Xvh/CK01fI7gdGHS+qRzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24n+1lV1Q9C8P+askK5LlN6Vs5I4g5KvJWcdIGUynZ8=;
 b=D9KR6Q5ZDjercyCDk52H3DjiGRiNwUnmTCFeSxWVxtmrMdgHaomz6rJaMlsv7lF4ISWy4ClRKtG4+QnW2MivovRJHnN1JsoR0RD96hCmBmRkismB82yqNeSecV/pd1akbJGAEVK+hTcdfj5xaZ6AqxIo88IMO6b+Ba+LQlbskDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 MW4PR01MB6433.prod.exchangelabs.com (2603:10b6:303:66::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.15; Thu, 20 Feb 2025 18:34:16 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%4]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 18:34:16 +0000
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
Subject: [PATCH net-next v18 0/1] MCTP Over PCC Transport
Date: Thu, 20 Feb 2025 13:34:09 -0500
Message-ID: <20250220183411.269407-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0129.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::14) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|MW4PR01MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: a072a1d7-40e5-42a4-0231-08dd51dd2e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fWWsVps71ApeElZdtRGpar9pu0iYRAl++M7TMOt+VuPFl6XliRz3EqFWDaAz?=
 =?us-ascii?Q?DQQCJ3/mzRlnuC5xVHbWUVoA6BiJL7ZiFqs7OqSh+z5GQFOoLA8d9QNV3aR7?=
 =?us-ascii?Q?fgcE4KgmjCD+DS+X/JeOOCje8S1ukV+8zUlQGGCr4vEpw7mGpCoHWJqi4Lm5?=
 =?us-ascii?Q?MU2K1G6hboKFrotAWddJgF6DPbeBEwH4i+Bt0bfkF3df3GawH4S1a+7P6VI7?=
 =?us-ascii?Q?DV7lIi6NodS/FYAGGtaOPNxtUSn6hn7o3x9b2fjrACyzeBWokdD+K0k9YXFU?=
 =?us-ascii?Q?rgRdUIU+WCwgAtk71nK5Dx3u72TBoBh0WzYVgFNcASnp8WEJsgIvSXedlIXp?=
 =?us-ascii?Q?E1U+ARFVxA15TaI3R2cNcEulV1AS9s/tlgVLXMd5vYW+NKJDxdx09ZOtqKXY?=
 =?us-ascii?Q?3hb2KxW8+ckv4TmZbeGcWF6IlYR2uu/m0M1N9jbzyw+LNu6Vi9fBlpedaFVG?=
 =?us-ascii?Q?dTagtZRtqBV4NHSRfhn7Mym/GoyZjQMgXUFKaL4xNdJLmvolcvHWXFc2moeN?=
 =?us-ascii?Q?6xpGLLbI2lQowjgnvPiHdw3ZRTZQvDhKiH6lBjkKjefrT4shSLI2nR4Xtw0h?=
 =?us-ascii?Q?PDx+jqPejOZmPvlMqhL+Po4ARGsvMB06RPDNsmUy4s7SGnZGET6RyALZi1kc?=
 =?us-ascii?Q?bcPkJDwQAndVJSJAJGgkvmSUbWQuREtI6+niV/9hpTftwZsbUNkls773YCVW?=
 =?us-ascii?Q?tFJZ6p+4HPhq0f96fBNCeZuYnru6rJydfdiauYUmzGattEAWr9rdYAFD4KRC?=
 =?us-ascii?Q?JPLWg0yBseA7lyFvd93ZnPl/w/5rOCGMXW/u0BROHg5XKAuzRcKtCDU9G4xg?=
 =?us-ascii?Q?TBeERbOFQv33XRN2L655RLP/7nTvCuvFWrOczMfpCNRtPSk/Cin9J0Rp+HTe?=
 =?us-ascii?Q?5u57Xz6N4HD9quK/kfkA5hhtaUyVIk4RMna0LutFU++GRWFoTA2g/yhuMzlu?=
 =?us-ascii?Q?3TtdU8IZsoYRzPUIXSOz0m4axzyek1hEkIOJbYfBuB/nQiSK0ygryWKUdLID?=
 =?us-ascii?Q?93DPi1Nuea6hfN3yiLAJJPZ8m6YX/qrp3GwC0muKdd8aNpaprPpxjo/Cmec9?=
 =?us-ascii?Q?C0oMKoGFh0LZM8HT1pqvvuF0ZJIqVFBZ54uXTedIDjRwxb3DH03minfOPDbj?=
 =?us-ascii?Q?fPOf6HcK8AhaqIuLLjNoBM1DvYG78uPDbSytuqU8i7iSTTG2JAkxn9lrkQuv?=
 =?us-ascii?Q?CdxoRfKnyGiP33mpBxJYF3Om3Fb2PVqIoOwhK6xMt2StiZ0js1xmw3fLb0B+?=
 =?us-ascii?Q?qpk8mURNLyEEc3GoPPv+EvqM/8s+zaGvH2nUsmUOlmWMR13C2/mtNIynwgJv?=
 =?us-ascii?Q?Xj1QHE+qjugY+UTfZ9G0W99Gn1jmHkmlP/npiXI29GdsCA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BTDr5xG8B8hWHNUQfZGgfshklO3LmLh6jm7rd+XuCbjx5c1JyyjqY874WUI1?=
 =?us-ascii?Q?ETp5ciYWNBloQidDao+chbaxjr5AWya6OVzsD5fpnGGjJNNOF6dcJcRMkB/F?=
 =?us-ascii?Q?I0/+h9oN0g0QHcuLDuCH91E+7WbmDdtXFA97yDuesf3Fb+Jfzy6k1vewCGQv?=
 =?us-ascii?Q?SqC/1R+t7CkQn0aPxIBciZUpydR/z5/7dUuQ3VDwV4X1rcRfbJQ9Qg+45r4p?=
 =?us-ascii?Q?rUEK5YnhxTURZuKJaysJC8nGmrWQMWLoCwYewu454VMrNFpICrw+ZhRP6JCM?=
 =?us-ascii?Q?tHcuaXJCuYCNRbRYWKiAUwQ7Xr7A5HNOCdHdW3KSvtsXKBngHCHjDOnAdf9q?=
 =?us-ascii?Q?rKxPXGRw7zktfZuToE9cKJKhiDRynOyIqWXLemG6fClN1HAEiROAid1ItqWc?=
 =?us-ascii?Q?fvpNsYJZSBf92kGwxngxMTbMtDjpuAh3iNIV5qNt+kOJxeayCynUj9HGWeAK?=
 =?us-ascii?Q?//0gJNrbDF1/ty/3QfHsX3OX37zwmjFLCGelbnuoU+E9O1FzRyM9HLpe3UaA?=
 =?us-ascii?Q?BbNP/Np+h54vV/Cb+/b7xEPQCVoIkv3dCQTWraF9Er+AeGHIM97YSdTMbKJt?=
 =?us-ascii?Q?ditSCct2i0W7mfCh6/N5M0iCT+5Dj7hh3USqudHuBV7dXxVtrPdJgGrq83Xw?=
 =?us-ascii?Q?HVlBXZYvSFJ0dBTLi5L4qzfqHN5L1K3GTCCdj701NtLhrdwdKROmOVIz1Oe+?=
 =?us-ascii?Q?EzioClXHbWn7scOePGhGmFOPMkRWPfkAf1nKh514UbLwKe6G39rd6WtpEkG0?=
 =?us-ascii?Q?J3tW7XkQ6DPHsJzJY0S5iRgA/hS6I5iMul9gFvmMKvigTzuJfNHWqX3tgkro?=
 =?us-ascii?Q?gwxEWiQioAULZ1jJY40hh5u1xc1e70Uo1Qsotd4nRowE/pZw01u0Oq+Ntct0?=
 =?us-ascii?Q?YAl3XOHSMQc5d5aVPDGn5ME08TlWle8S3o0qxVciq483R9y5bCQo3AFOlN7Y?=
 =?us-ascii?Q?zevPoPxC2UfVCDj3sy+DDFt/Lxd3e1Tg6sc8O6Ci/WmkEeuAOWkQmBrYXOEs?=
 =?us-ascii?Q?y4yUu5b6t4QfFdPs8nlkjai3cVOGbacARLb5ziBFbV0qbZAoSz/7TewOda/E?=
 =?us-ascii?Q?eZ32urmYyYSmCkPDSc3kFIDUrEZ6KUjxSc+pI+62ZdJc62XHK9JYXmSEEZVI?=
 =?us-ascii?Q?pbNm4wvfB7yjvtzCeT1sJA97lNSG/PfmVJE5PsDyrd7wdmDYPTnst2YQ/LxH?=
 =?us-ascii?Q?56u/AWfVsAMAlcwtQEOeInzevsZSDhqCBDbsEay9WarShQpXPGMBiv5ozuvY?=
 =?us-ascii?Q?HMageCRNxPxmDqLLmV6SlbzspZtoL7LEFBKmlXzO/EZkC61khph9CraA0etN?=
 =?us-ascii?Q?eMCiPSNlvO44xCG+dlMM10rGswhg168YfiZEtOJ/xdUBfPzjamqi/jJKdA3f?=
 =?us-ascii?Q?TTFTvEb/y7g0bUQuzd+EtOmM2MfYLqPg+LmVsDGpTSWKa6NvVLY//F4JGPCv?=
 =?us-ascii?Q?AcCfy5vem8ucEWavi3Ddp7jpns3jc31BW18JS6ErJHTCUFF6+cHmsp+pZBO5?=
 =?us-ascii?Q?dMYzHpP/5xaWPollDQhA/NRWJzM5ne+e7ROQgmzQujzkuq3nVlBBxm1BduO3?=
 =?us-ascii?Q?No4/Us8wOBqO3EdP/oquQl+UouR1mzddhJBAiCIW5gqSXkU3LJfGeIRQiSfK?=
 =?us-ascii?Q?zXsPW4ewIDyQB125uv0wkkEvmfJuFvdxHxT5Hcu15/S3Gjv7CzPLwzERV1Kb?=
 =?us-ascii?Q?Do7gk8++cyrJ0IHKNsypyCHf6/Q=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a072a1d7-40e5-42a4-0231-08dd51dd2e09
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 18:34:15.9770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VIQj/UX6TTSsnkByu2pRO5GGbsDU5c+FJ7IcdG9F7QTofoURe+u/ZV7sYBquBfXkHgTF10m+6/fkVLgAVRU4znTz6RQ+Ky3VXZOBcp+2CFnCALDGpfbqWbm9msufQ01a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6433

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
https://lore.kernel.org/lkml/20250205183244.340197-1-admiyo@os.amperecomputing.com/

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

 MAINTAINERS                 |   6 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 312 ++++++++++++++++++++++++++++++++++++
 4 files changed, 332 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0


