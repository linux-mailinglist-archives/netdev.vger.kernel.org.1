Return-Path: <netdev+bounces-160347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4EFA1955D
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 16:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02CB316AEF9
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 15:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121ED2144DE;
	Wed, 22 Jan 2025 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Tqei5jvm"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023095.outbound.protection.outlook.com [40.107.201.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B192144D7;
	Wed, 22 Jan 2025 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560160; cv=fail; b=IrBStuqVLsrXuzRlmvRif6JMlpSfjGe3SobX9Kp19JNKoXpFC5LiO/N6WuxZttBi6jH127CVW3WUzKjSykbgDc8mzl2xJDKgGDN7Aax6hELM6rRZLsZUY+WwEf5fyHO2eFMKCsUv0FSF7S5todZM4rmUXKo2iLSVclHSXyJkn94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560160; c=relaxed/simple;
	bh=OmH+tkG/WoNs+P2TGdkbQ0GoFKV1J3FrSx1ur1ITSo8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IveTKcfjSskWfcLNjjxGACgD06TDlf5ghbDbNspyv7o2Sq5qqJWE7NlIEfmMjg/XtAc/yznTPAkJVODo85ld/3zim8Gja2WPPL/uVs+SGHC58jt4kh8DoVLN4rEtzWmQVT1eia/TUUvqXfV5fvXLBcIJukax8POaanpKjMO+MNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Tqei5jvm; arc=fail smtp.client-ip=40.107.201.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5Ophb7AoMnkENjJoCAT/THBIl55MJl+cozIArVua8EFW0OsxXedwT2IUkWqsSkwWigdneacpznV/WT8/NSLE/RYUfdSQ9/jhofvtS6l+xbb0DMeRMFaAKhzZSqVrsZD3aZZ3fnB5CC9I6fbhArdjZsXP2QGZpqwB+/X/4Pb8JdoklC/zmfE3S4HB/aTifOdnPu8dujpzGkt6iJTIDS5BrBt/rzgtBrnPsNJfhw6PJTtxzRKDUjdp4X+ZFH1MHO2tQLWo4otGTHdew4ir1RKfO0jzY9LlWozLI0DkCjqOZTIS7ZSAPGSmOYyCmvIBTQYJuFvROMksRu6tegxEO7MUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLXYwJ4roilMJ7OLk/majoaATVVNR7ML/zPDa6TFfoA=;
 b=uOozaEAaMaNUSHM9aXK5W2frepcBb0MEUX627q46csGPiHO2PT909c+6XN5nKv7Scsl9x8biffqJ2S/pLOXQ8oikR827u5BiVQBfrRU0V0+eb7czFdGz9wQ97fuCcB9yC3lqxYETrV5g+dAxvRI0VrJFpzzG2zW8nepnqrtBHVQI48p/QUXWRDco5DNXUd0l0VFOyZzmRc0lvM8TbjR5CovmYyZX+6FLwHsPIZbGjjyoVDfY5eq2goAxcHWWoZGAC27gRSJvCJDmLw9yiJAqeKjNzadpG0s4D4B4iKpBs0YbhFILAkltLe9lakm69zd3Hao+sfBFyt2y69rzrfHgsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLXYwJ4roilMJ7OLk/majoaATVVNR7ML/zPDa6TFfoA=;
 b=Tqei5jvmd5tb+UTI6ykGxbI/RLV7hKdRn2Nt68dchkuSaNEJHd/J1319gDWz1dCzEXrhK0p1jYR+jA+YjhV5LPwU//0rBH5xYC6ni5x6FrZHuwVY3avo/sTEox589Onjh0ehUrPglAX4gpGUArD/cSLkut09aSuojXg11hpjWYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SA1PR01MB8201.prod.exchangelabs.com (2603:10b6:806:38d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.14; Wed, 22 Jan 2025 15:35:55 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 15:35:54 +0000
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
Subject: [PATCH v16 0/1] MCTP Over PCC Transport
Date: Wed, 22 Jan 2025 10:35:47 -0500
Message-ID: <20250122153549.1234888-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR01CA0008.prod.exchangelabs.com (2603:10b6:208:71::21)
 To SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SA1PR01MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: ef6808af-285e-4ab6-9a08-08dd3afa75af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|7416014|52116014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QWin3gXq0MH+/bgeIyYICzsQQDBbFBJdmb74kHM7V6y/+eYowlsaP5LPwsY9?=
 =?us-ascii?Q?pZhY5aNPt6Am1IA1i/btRxFy6cz3AjPOuD7MNmfOT8rlDByOq3hf03FDU7kq?=
 =?us-ascii?Q?oldoo3jhGRK4dAcpZOdty6CsT0M+kTbox+NU0Om3wchpX5Ti0u2LyC4tSa4G?=
 =?us-ascii?Q?wOSonWz5ZzWrdtfHujZxZC1XbcjQhPQvjLtd/yONZJ85Y946TUr6MTmD3gVy?=
 =?us-ascii?Q?u7Kudw43vro96/1R7R76n0eVsrhPjFGwd7XU/xqayUqng54jl8yDl7onnZ4o?=
 =?us-ascii?Q?PZLEsWA4E/pL6PGQQGrJy1lgaiknnMSpkJN0baDJJ+cY1l+2ZZ3rxAjJuhzF?=
 =?us-ascii?Q?MMiCGAzq55peOfZKd6IY4yF2Jyn+h8hZIhtSmQDZba0gzwnsgaCrHuBNXnck?=
 =?us-ascii?Q?jEni13jUe1lwG8G9/ErI5ggVxWe4e4s1ck7IJ+lri0JunM+HBaSlg8AyFcdC?=
 =?us-ascii?Q?VT94z2abn5jmgjURhrqFC1r+/QxnSXczcwEJaM0RXz7f+2yePOo6BrAHryAH?=
 =?us-ascii?Q?8Ci51owW+/zsI44HfQqDj3ZMgKxT8dTnRbLxnzL3UMzsII8kEBTUSf70KhCm?=
 =?us-ascii?Q?vjvRWI9YMsEunlqKJWSDMKQ0/mgawecjWExUDjMXyMJAkKwRuYZhqRSUqjX5?=
 =?us-ascii?Q?mr+m2HOBqfWgX+FL8DUO7/XVecpzG4dImc2L6eYbJF4EGRx37ouTHIuCqZM9?=
 =?us-ascii?Q?uFgybk9rl8Zj7Z2sK95zixF9kaFBv0R57p2WnplIPTe8wobKfxA9/wYvm4sN?=
 =?us-ascii?Q?GU0U/QTriaZs3xpi6d50hnGNSW3/lj9o3u1PP79RViL3NW/oUZFgEH7S1awn?=
 =?us-ascii?Q?aUPUcYe1SOYxZ/Iz0rIO4TSiGs94lfR7d85T18LWh7S+QpSAWIURJyh4KiUp?=
 =?us-ascii?Q?POz0LEyzU0oX0Ch2K4/p+0juSFLLrvH9Ij8wajUPnqNR/fUG38v2JRp5GpTV?=
 =?us-ascii?Q?HYU5YP4uBLfTT4+UtQw+bhFcJTCjBP2kF3Cy0YmJns13OIkOtoRlzbWu3xr/?=
 =?us-ascii?Q?oT0+LHtS8lNNhaNBY8jgGe87oknkxFkhoITMrlcj3TK54FKRHa4nYM+iJ6Sj?=
 =?us-ascii?Q?ICm3YI/TCNN+lYCsPY/zOJWQ7KEkes038q9rQ8AOBnMJodZicWjre29d820V?=
 =?us-ascii?Q?Wuf8/ofyMON9qiR99SWqvZwQCa4oC6vhobEn0pK/DeWegj1QfoCZtD0GTCfv?=
 =?us-ascii?Q?j3TkW0OQqU7HcSu0302QZ0cZ2IzkaQjgfgtfzsxvzhmcW7ZmVLmRLpBFzR13?=
 =?us-ascii?Q?8F1P/F7/f8mWFzPCXC28ClS7snrddmcw7p4zqtNfwtx8b3RlDtEVhtj8mthz?=
 =?us-ascii?Q?fO+a2VZtTE22sh6k5Ppsye52eTwdTB8mnuqGCzCbAiNq3w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(7416014)(52116014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2UNRUNgNzaRKAWATBUnVwd+5vme6OEOUs4+vpCrT+cWSNTfrytQtcrdpe3d6?=
 =?us-ascii?Q?UOTDee5oxzGxDfGmf+4RQoObrUvr4RzqEGOu9KqBGLmxSqvPdp1N4aO4Drg1?=
 =?us-ascii?Q?g3AxwWNFRbchp77Rn6yZKmSnUWcDtZ1iV4unjdFhPi45NYsPGXv1t10SP5ar?=
 =?us-ascii?Q?3e6k7LjCOevjVlLB22QlthNx5930XMci7mlaxhdqWN7PnHHa4dE1henCDt0U?=
 =?us-ascii?Q?kMu5I0LB0nc4F4q+g3Bwhbztrt3K5C2nT1bJ0AGooMCa6c6oBkusRvxAQc/J?=
 =?us-ascii?Q?owSn9bkjUgY0cPZsm3IhI3bAcFn6Rhu2G4a4dBhoyaatyfnlmLs/r77zFPoT?=
 =?us-ascii?Q?Sp9X9mZTONDTvDaJQhm9ggd2H01k6lOntf3lLs4uwMUfdjA/F0PGNVRzM5y8?=
 =?us-ascii?Q?kyS5ulPLMRaZilxXfYrFIcL3bHyWp9Jn6zkUyb3OJd746Qoh5N5NamZTM8XG?=
 =?us-ascii?Q?Rqf0AKg7nni4WcEC2LMeapXlSKho9N3fO9RSSnYtygWcQY3xT19ar8EF/VZd?=
 =?us-ascii?Q?b9iuJys776ZdEyrDTqe91T5prQ8oFGV6nobMWlKmcZIAyhHsx/XKG0Lzv2NY?=
 =?us-ascii?Q?MoMTtoyruu3/UhEabo2uirQa6WZF+yCL1r17Y6QIpMev3hl9X5vG7IqQUsv2?=
 =?us-ascii?Q?QV9lLGuMJy7cSHxEZq5gXWe66n3GS+UgHhd0FB21sEEotNT96bPN/VEvJJZm?=
 =?us-ascii?Q?nbuPtkchFrt+Nl7faOAqDPdT0d1EtlqWqyq58zOREzs0jOzkHY0Nzr4usfie?=
 =?us-ascii?Q?X3m1D6to4Gi32qu0YbMiMnBQIinaz2eXq2E63ecn8GEYts38vFUiuGhhvTdS?=
 =?us-ascii?Q?knBKQVG70+KDlF6VtQZftB6oKqgBkg+r8T6rlJlEXNgr9JiubOeeBWPKi/+2?=
 =?us-ascii?Q?Jj9dGEINbpeyaYEi30GHhqnlBRvcjRO2QxwapegpYX2p6xmCUjZt3AwLnoGC?=
 =?us-ascii?Q?awcSUPs9EfpKQvGgzMPNJrz5qEpT3QvkkDqOYN1HB9zvdscssW58ohzE91or?=
 =?us-ascii?Q?2GHJ+mJ0jUlDvQFED3MuHN/WMu9nG6fr1HaZbtkLfeZHxL5lqbc66CnCiW5X?=
 =?us-ascii?Q?5Z35uAdkQhS4/xh9BibuXauJDp4Mk30o/BNZrap23RHdCQIO6fV2kHvF/e+k?=
 =?us-ascii?Q?9KVzDiBT+08xM6F0kDKgwbhqnaC3GgGPtq+3s7CfA05zzdYi9bzElR8iKsXi?=
 =?us-ascii?Q?X3y84d4a3MLqox7c0dcW0nYjvWv9IR4vhtbcxJo8o1cf555dFBnuQf7mJ76i?=
 =?us-ascii?Q?epNt8dRLL8C5WMc4MLpxqFTcICzeVBmEyXd1E8U2ix35Yv9hslsUVtKZb2ck?=
 =?us-ascii?Q?8pNpjX1Rya/YtYB8F0DKJFQECCE4/knNT6hSajAQP3fGa4gPcjn4DeM2zW9A?=
 =?us-ascii?Q?6ZKWE3VaxvQV3UdTLfZqjJ5NjmHWkmgNCX+Pxpua02+jjOPV2cX02Ia4USN0?=
 =?us-ascii?Q?YW9qTa3Qb41mOLA+/0gz/xSMUrT3XJNEFa8ZdVuI+ECd0Y9aQs71T4n2vZ5F?=
 =?us-ascii?Q?p0kANm+0SDZM3pwq3kBXLMgR74s+W0FRrperBm0VBE5qOGN37MUlsm9vNiDU?=
 =?us-ascii?Q?tuMerbbXkgn7GtqY/H0SMxRKzXQc/yhK1AxWehKQl6gReqpa6kRBMZvxROab?=
 =?us-ascii?Q?cMVF8CB2sEVh2fAHLHsrnInTcL969Fv6wsdsgnBHofGcgYKTvHl6i1TSqoGQ?=
 =?us-ascii?Q?mcBQgqdOCi1Fo4snomdZwX/jE2E=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6808af-285e-4ab6-9a08-08dd3afa75af
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 15:35:54.8860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0qrb4OQrqVEAtngNQt8plcJ2m0S0o+pdtQ5kdi291oyEP9ePPOtxL7B822GE/E+fv9zZf6JADxYjxEi3NeCCYcsvm/Ckb4h6t9sIzELOSLb1qLyWgBNDLVy1ld27grbk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8201

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
https://lore.kernel.org/lkml/20250115195217.729071-1-admiyo@os.amperecomputing.com/

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


