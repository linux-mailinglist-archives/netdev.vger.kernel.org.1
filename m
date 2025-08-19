Return-Path: <netdev+bounces-215046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AA5B2CE50
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 22:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAB05A0AF1
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 20:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61133431F4;
	Tue, 19 Aug 2025 20:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="u/bqaEmO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2090.outbound.protection.outlook.com [40.107.94.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2483342C9C;
	Tue, 19 Aug 2025 20:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755636729; cv=fail; b=IlrGkt8TCrcF8KeQ1kzPGvo5wboaGXCvYG5rV7YRF+B5BKWPrl2DY4EPkJSRiR+8eC4SMV0klBvGREtVCjqkPS/j4Etcw9yEMoXyh34z9GIBWdPYuGS3A3aRb3v0qz3bVC5bMoMDyaA6zElpYYHV600h3EuFQQMKVNa86FgY16M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755636729; c=relaxed/simple;
	bh=waVKKaNSXXhQrj+I6fOCvw/bj/ine5qsQZA8BgWXQzs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=J4fCR+KaclZMHJx7sK244D7oNzrFdKtMnX6A0HOptx2y/8g0p7bLMNpwkJlP+s65pBs1MZGY0alusCQ7LYxNarFqEQAksp2pGy37G5J/fYjNKGJ3hLFJSeI3jM8I1QZdjDpWzW2mdMzSWAOnnBmbZOvhxgPk09uN4XD5la+yhTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=u/bqaEmO; arc=fail smtp.client-ip=40.107.94.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKsherCxsC0Zs2YXtcUAZV7BfmmoBHD5sw+aOEEhpkIm8Z91zsBiKT1iXI+6eKyefPnRzZ5C8dEsbO475JKonsWQ9dZAk9dOJox0h3VsbKd1OCVCKTmD181Zt8hQ6uCjUPCS8jz76By4cv/fR99ONAcpmf10gWYPoys9N9OttC1MfcSDNlQJ/Vrj9PAwlS936hJF4ZvDLVID421pNfS70XaQ6deDy3cZS6KsdzEfVjkB0/+hy8iMC+lTD1GhYQCXJfR+gbJ/EmAE5OXLQqU2LvpRdOrUN8usH4QRs00/8ObpCJF6X7eklL02D8gBqPNE9Ds9DASV/g56oq/D7bXsLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiR/0qvFceUHmyKF871Z1/W5qp1l750ehPxaUTtXYJA=;
 b=DoKD5ufWSkIt/oIqpogw3F6eR76AMV0Ztns1/iLs5/6va8wXP0RWblFflWSZY2Wned4Jg71YuGdd7TmafzT54udAwhkOJUjkri7DFfslTxmbUabaUFnFRMc6Rjppcb/6xqqydkkDTcY93HjVNh3L8CZnQNNsTs3xIxWkKd4LhkD7o32O8bwl4/aE+7RVz5RwMbxv7R5voP2+VrSFKklryzrhDMimlMt6w+ZSzYp2fwWnXIFhIIl3fo7ooc/bEI+FMot0iE1895KnPy/pwgzVCIkCy/QOUd69sUfL4kKr/gEGeicC1/YgRrw9LkdZBtUcqdM3rGBg0yv4UGuSzNHfwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiR/0qvFceUHmyKF871Z1/W5qp1l750ehPxaUTtXYJA=;
 b=u/bqaEmOj2dEiI6kBXqPfozDHjN6CUNNGQv9YyXCZOhh+txmzuteBNF2tyg47URNHN3BUj/IPIs/enB7mhsT6y1ZOeCXYlGM/vgbGyuFByrEBQYwU1Q0pV2yEGxo0zYwZ4t+ZieFrKpU3UrohRn/zjkGY1mEAUINeyJ0v8w2bT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CH0PR01MB7051.prod.exchangelabs.com (2603:10b6:610:10c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Tue, 19 Aug 2025 20:52:04 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 20:52:03 +0000
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
Date: Tue, 19 Aug 2025 16:51:55 -0400
Message-ID: <20250819205159.347561-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYZPR12CA0017.namprd12.prod.outlook.com
 (2603:10b6:930:8b::14) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CH0PR01MB7051:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed06fde-9051-4dc5-eba3-08dddf624052
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sVzOOSTex6tVVvvy74rh2Li1AjjnyMM+e9MIQOig7lvslW1UuxqdgdkxKtGC?=
 =?us-ascii?Q?ydmN3YFEmWWA/XfyTNeBiVdGG625Wu3lsR3NXCsB1fR3jlwnYpJSbTmdDCgV?=
 =?us-ascii?Q?Bp39Dh9423Q+svAhVQHFptdaflt9TFUs665xc2ME55ISgSo5fBqzEeV6YzAH?=
 =?us-ascii?Q?82zg4xY5Qr23IzCbbJ2g7Fk2YZlghdrLERAyMX1t7SAZhijU4gxKLoRnSJtO?=
 =?us-ascii?Q?HvQ8MK1CRfZfyjrhgufWfE2ngzXYKZ+1BNVq7OMiQ9qxjWeZIxg3KyPX9RlK?=
 =?us-ascii?Q?GO5PqCZI0ZRbNRMRwrpHWZQJvlgzWhthfWCdngrdSqQvVuPzx6p7pWt3FfRR?=
 =?us-ascii?Q?+w5lJNf5opS/TrLExGfmXN0HU7/znWy5wCzLYjPpYzBVCkDFueuquYFwsXM7?=
 =?us-ascii?Q?PGfJei6JpvNpY9R4WYR9ryJGWPgMR387iqGLS+eleGif5Jw9AfXK93v+HnFm?=
 =?us-ascii?Q?waMDqwW4MOMH8RBv2t4UZtbg442g8ZaKBydxqTPinnBCyJxjvnrWxBld6vF5?=
 =?us-ascii?Q?a63cHLWHndZJLVHYWI7VyWZgK1wgiRbFOSidmdgCSq9cxE9a1aCb8MdF5lbC?=
 =?us-ascii?Q?3tCjBJjW0qp0MSbqjKDuFdjSJ2AYzq1qBBA9G6zeCGVMlPKYjIIp9/kdQxMf?=
 =?us-ascii?Q?kMlRvBX5Vx81mt3kCKzdvSkAEJkAkxeA3o1BOFNZZKws7PzsY9yINWFE/zHC?=
 =?us-ascii?Q?1RKAUz390nEODXiaLEtV212mxbgFG6N+TYlOwgu8bk83vB6Vz+AOqgw7W8VK?=
 =?us-ascii?Q?GVm7ax6eDHEYUL5d/q9W45qhQe2diiYlzuKdTVpUAfI943eYKj8nse4Am9ri?=
 =?us-ascii?Q?HdtdPGNowp/B7SVyiryFMIxMK6I4W09gLJeH4WMHbwMVYsofn+O8jSz0g+fR?=
 =?us-ascii?Q?/RsgS/PG5/W8jA+uRgA0/4EtAr3tcvQstL5rutiZgYvpOoLxNOIeBGt3rdFl?=
 =?us-ascii?Q?uY4x9Mqb3oA3arrwhQsualchUrorWaz7plVCrekINIOKHx3McB52EZLsKKgx?=
 =?us-ascii?Q?FDcL4EWk7m1ldiI5E9vEFxJDKUO8GMTNlgbXJ4TVCTBpsTILf9qAz68c9o6p?=
 =?us-ascii?Q?GI/UaT0xhYnw/Dq8R9W7Jv0FXthqHNT4w3GRnr0TUs1jDzVIBbs+ptr51GC/?=
 =?us-ascii?Q?TfEXAxXiqJ0ZRnHCZqLOZllX953OF+Q+m4NsAKzFSwhooppmG+W4afLNAbp5?=
 =?us-ascii?Q?g47RHel2FzoFakSWVVGHMojDVax6jF4LQixcefJq4X3+UpsRYokRUIqnw+hF?=
 =?us-ascii?Q?CKSxz0/D5VuE8MuKbgHbtJT4NExqAaSBmrR63onecgLDUEoIJ1fHsaOBDcVB?=
 =?us-ascii?Q?9l7A3pW2E540QKcKb50lwmUqzO75J0IXZDqaQZAxU3+A6DLT3pVQ/x9dqDsj?=
 =?us-ascii?Q?be2WBAE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xk8XNNfSxziFkK3Y4JAfqvWhLtn+QdZ1j0V3ro8rxof3a+JfjlcWKND+o5ft?=
 =?us-ascii?Q?CbFC2donoTbaaendramH9SSiwXwyJYAK/7/W7q0n7tUtxL6Ahxgi1RNO0Msa?=
 =?us-ascii?Q?yqhHMcstO4yM6y03a/bhTL8ptzD1N4knUBIB3IytLcxurEKUSLY8oWSpSmof?=
 =?us-ascii?Q?UkdMMJxWMuwgAjsZjO4pShD91p01ZyOzOizn3VQ4RoJOPYX/FX5+yrFOb1Jx?=
 =?us-ascii?Q?X8ofzkqE+l6Vr98MHJjoTujcqtbF+0q9ZNyOVmlGNthtCICJxEiP1GjcyuYa?=
 =?us-ascii?Q?+R4L98jSIXSU+Ap39pTt76h39+jzZldNVswKsCvwNL6lvsAmyE+t9RouRYgG?=
 =?us-ascii?Q?VUBGAES9Ojufzsz6VNk/ewFi1Y1VrERujpypz8Eu4Dq32BJQLrKOFSOmstRM?=
 =?us-ascii?Q?mqx4mCi0gb+4vjPV8Bi/JMEYIWbX5yQT2q69N8RAnimP7vwXIwjcCeHUGmlg?=
 =?us-ascii?Q?sVbeDrTYL3Ihi03yaOBYWRNUkSkHwhuJBVbuu7x9WxkZ/7GE6rc+Mukv/9fG?=
 =?us-ascii?Q?ZW6M8YwuHbw/73ekvzZxYJAgP8CXiBilGrkXjyiW9U4o2vAvoWGu9Vs6dxdq?=
 =?us-ascii?Q?zCaUOqShGNcIV0fg10zDn4lNoDmj1uYdvWPk0i/a5t/84uum4E3a6QByIbv8?=
 =?us-ascii?Q?hL8lybEFpJNEw59y9kS7VPMC+ydxz9R6VuOSlAMtlB2UsKuINcbTRF3vZizj?=
 =?us-ascii?Q?YOnhpr/aVrA0r8lSEfMnql9EtyU+OH4XUiji9mjfRv2TdZ0uFKEeCbP8Kc1p?=
 =?us-ascii?Q?Nmro2z4Ek1ggoo6X1Kajc8RN3wlD2SZ9nDDIRigiPBEf8hM1KEItykBdUAzb?=
 =?us-ascii?Q?knxqGT4QuKH2rHgAQI22VohAV8RgXOCQ2cQEAJwmLb8kB7NZI3g0Fjls/fPE?=
 =?us-ascii?Q?ybD2LgR1SNheoagW3fCY8jiXLVC+4IJ8fLsx4WK+0OplROB5URrrtGyrUt4E?=
 =?us-ascii?Q?jG2DAKL5akyWP5eOyQI32tRoucG5VbZzf98PfGt/PK2FXqpvz9z7yT0ngl+H?=
 =?us-ascii?Q?BSx9KjJEksXndUGs1ZmroIv8Wtqz0B450kHyKDDyvS/HCqHrcqX4Rb5T5xCC?=
 =?us-ascii?Q?H2tg8tu+KsR+PwiCXrfp8sYLphPNQ13/rbudL+yLFY/SqzBeTu7AKUd7hb9N?=
 =?us-ascii?Q?+Lz6dPCuUel/ww8v+elxR/nVR6YQSU5ZcQyLEyFDs42fBvL0a4c8pMiZkumC?=
 =?us-ascii?Q?0Qt+fXC8cT7DJWV44Cz+9NLOefB39aWvpHoGeLVYqaJ5zpNEbqjQ35aXsQdp?=
 =?us-ascii?Q?T7uThR6UPnkK3ycYOBkGWpbTkI4FuXyMvikXgad0P6mTYcKAy8Z88e3WWP+X?=
 =?us-ascii?Q?vrym+lpKMk+JAjvlgxhHnkY4qZnscHxxAuYpM0aZQY8TaTjfC0tMrZgSQtsK?=
 =?us-ascii?Q?WS00kWKn/pKB9Xlbbelm4L3iLtp4rQ3Y08or0P6+fmHPEh211Gi3o3JHLQMa?=
 =?us-ascii?Q?o6NSUp6AkwMTafLB9Bj4t1S8G8exMwtrJeDwe9A1KeG169l3OEXgZPXLCHtN?=
 =?us-ascii?Q?xBoEsyLbIqpJLHbIDmCeZLWv82vOiS/ZbjAbBqMEEePVKvGpV2nm1mb+kvdP?=
 =?us-ascii?Q?UPZx3yQytLDQ/ct/zkbcYdvp7aNrw1gOnulNasSnwljQf2R0RZzn36xl6q8E?=
 =?us-ascii?Q?1qlSHBovarA6ZuWqPJX59+1fo3iRjMWOwz4K14WQddx+Qa9KEjo5NZS6yL6F?=
 =?us-ascii?Q?tALvhU6uYg0Jt3b8nVlT8uzlhK8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed06fde-9051-4dc5-eba3-08dddf624052
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 20:52:03.9368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0bsIxDDd57wmGEw1UVRzWfaAHyYuMgxIyn1sxVUCPhAzc2Ib7c2NO7n8OhQhnhQLZEbHuXB2vgWTrqOS1rRiaj9P1jCYGIHmybeEzuR/rC8lTvqrC7Bey9x/TQGWo4D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7051

From: Linux Bot <linuxbot@amperecomputing.com>

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
code and missed stpes of the PCC protocol. The first patch in this series makes
it possible for mailbox/pcc to manage the writing of the buffer prior to sending
messages.  It also fixes the notification of message transmission completion.

Previous Version:
https://lore.kernel.org/lkml/20250811153804.96850-1-admiyo@os.amperecomputing.com/

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
 drivers/net/mctp/mctp-pcc.c | 379 ++++++++++++++++++++++++++++++++++++
 4 files changed, 398 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0


