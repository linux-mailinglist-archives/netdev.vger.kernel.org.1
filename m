Return-Path: <netdev+bounces-153490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0FE9F83E2
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 20:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9CFB1684AE
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 19:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CF11AA1FD;
	Thu, 19 Dec 2024 19:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="n2E7ka5P"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023112.outbound.protection.outlook.com [52.101.44.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF9E1A9B25;
	Thu, 19 Dec 2024 19:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734635781; cv=fail; b=s+tGdtnX4oCL5l/hFYmxFIvsUKO1cd11XYIWopri9+N/8/u2cs9nmdDTz6Q0lsSPX+7T5Kr2XSm8992nFQCpcjG2skNmzcnQElhnN8uLw5mcvVcl7okMLNBHZd385/SCaN1FAsTAKdIvGVAOL283bKNLJIKnkWGxthlHcYaC9+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734635781; c=relaxed/simple;
	bh=wYBCvlXXqJalf8X4Gw2o8PVKn2rm13x0Vg6LBPSOUTU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XwCcyv+Eu8/vnGsHD+piTk/1MinKciRYIUQCjluQWNvXk98ckEidMi6jKzC03nxKZIKpZlxKfRlCw6xVO5wJpqDwB/rMD6O7WNZanooovmy7F2XAhR9z1EcZ8BaWogpvvigzbe4HPzV41yeB0/jI96yx0yF5dUKGmoSntOKwEwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=n2E7ka5P; arc=fail smtp.client-ip=52.101.44.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jtPrVBqF/NoL/FALhID1yEejYDfsSUoqwxQLEeNgTpaM+oVN8t/VfMtXbJESoHX6b7dQ+OlDokjQC6eVDOrge/nYjKFpthcR4oPwqJjvFfuxecb35yshoOmmL1OVRgmbbEutjhlz4misrRCaXA9Y0UYMN95KIGhbKBFhoOaIYlSNSC79ck0On3GViIK3B7NI4jp1P0cDkx4GNwq5fgFt68irgSlWUh8UC+qSpZJoFfemsd7AOoh9cuvpzvokwKiYc7keprHb0wjbhF1HiAIoFL1VGQyDTvBhOAx0lm9nNZlA8z810Ky1U5VDIVDUoE1nLD887D/1gE4vmZ1nOGXSpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcp87+Keqns051kAtkqt2xUEvhSdDkVZDfxa9UEEnJ4=;
 b=GNY2if1/8ZaSsmxyTHEp3w9KstBIlzFwdRYpRSVaAru9tXkuvteVdn0AaLqDRFNElbCszKm5OkyIs3gNWbXNu3hfKKQbAtHCp55A3K0LCozHfYPITk8JQNJJgOlpcYAMmevJGybVyrBcqyKNB05UoVeQKbvE0xq/+nWcwPV18oGHqdUIhLk8v8XnREi4y91FqLNcNLQZ9E9ZPSmIwzFKx0Tqf25v39Ti6O7QQ+h3y16o99ActEqQIzr6cq/qgE1UMwh9/R/WXtLHUphuiI6iRok8BCVoWOMuGGBSNQQHaCuFoDGp/8i/pTpvn2esaXDuxnQrBTs3fppsMbnG2qZsZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcp87+Keqns051kAtkqt2xUEvhSdDkVZDfxa9UEEnJ4=;
 b=n2E7ka5PAVzX98ayY/JmuZ4+KaaYnb2vKvFNnN44sEinMFqNxknBaGiG9rh9bGg5WIKyQGqRbg9MdJYlJL3serjeZsPEPA8To6I6zbhTzFjZLjGxB4rt1XdWonDd6BKa+uiP9Qb6iqHS0+Mcmy+9MIGWAl0cNSyZGH1kBE6Xl7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SJ0PR01MB7527.prod.exchangelabs.com (2603:10b6:a03:3da::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.13; Thu, 19 Dec 2024 19:16:15 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.8293.000; Thu, 19 Dec 2024
 19:16:15 +0000
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
Subject: [PATCH v10 0/1] MCTP Over PCC Transport
Date: Thu, 19 Dec 2024 14:16:09 -0500
Message-ID: <20241219191610.257649-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:208:256::8) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SJ0PR01MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 8adf1d45-ba7c-4c0a-2435-08dd20619b93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?udleFn7LDrQbWneILJEFE9uQ4OY0FM4xifJv7FLDMEu6OUqb4G/QNFp1gL8X?=
 =?us-ascii?Q?GiWLWYmr8vbm8dJKlL3bsc3sa9Sm9oVaElvjgpSMmJ7hZTrHT7xR5IxnOZUp?=
 =?us-ascii?Q?Z5N3K/JVYNFciRvZnj/N0fsllKMIgDlbK+/jQxFgE7L3DaOX3BkjFVWSO90C?=
 =?us-ascii?Q?67ZnOUWpubKdLTnmflO6tyAI2TGHFNpWacPW31j3mM5+4pFAmFAu/fiu2tUr?=
 =?us-ascii?Q?NMZyMxjlbGB3u7zGnm/0hLuftENMQARovJNdIX7h0MuffJw3Sr8rXnrcsfOx?=
 =?us-ascii?Q?YQQVRdg4MDxll8sBEiYGEIUyPDyL1wVqbx38snAC0qS22C2FSAUnpi4S7sEf?=
 =?us-ascii?Q?oDNDHmBN+AJteIoyNFzIvtdt3vfBDCWdTNNLKFav4RAcSqirCIrtbuCnarBG?=
 =?us-ascii?Q?715jqQJPW7fw477d4IK9MUagMBIMC2bv6uQH3m9XppPnn2gGFDnB4KYeB3rs?=
 =?us-ascii?Q?/XJy+NWY6DIZhPov2/LnSy0UyHDby855UFlBUjuSuyf+R0MWWQj6cZQ2EmGP?=
 =?us-ascii?Q?lm33W1zvBfUKrHdO8DcTO8xkNOyRoLDH4fbnv8cin8BZa/k+GeOuzYYFCp0q?=
 =?us-ascii?Q?6pQE6xlqwkh0OUVQcV0PXmwmtiHqa+p7mbs0iEAENPa5rW+zlv0skr29eclU?=
 =?us-ascii?Q?hi5MT+Z+E+BkbKhfOpGnCEqCMAP1rJ2YKcvUXhHuMsVXpRZ4SqjTabLZge9X?=
 =?us-ascii?Q?5rpGLRbgv+gGbMMt7jh77xINocnG0EpL5Y0K0DsfEa25m0KE1cuxuLkJFSfK?=
 =?us-ascii?Q?rY+Gj7nfU0tBQBWW4NmWK4jU8VRDEFGwgNKeFXe8ckIyyGvI11ahr7jCsU8R?=
 =?us-ascii?Q?gAKWEuMT40zBS1uCjyJSDAIgvcNmpnWQr5A3S1NargIRu3zyU+wpIJNqwqG3?=
 =?us-ascii?Q?YKnIA0JbRNkgyhAnowIHWcrVEHcHWD+DFegRDBaNGzjyqMlDBW5aDXgu/nhU?=
 =?us-ascii?Q?VViEmAuAcxk1S8JSVOe8FZDGkHd4QM9r82PkBfhJaqoESEixi6+G9yrGk0Cw?=
 =?us-ascii?Q?u76h6Ny7C1G7A6/pq/dPMp9JsVqtBgQWpK7ZMHfQV6ra2Uf8I/7FnJF5nH5x?=
 =?us-ascii?Q?qzvGJZsqwkOvIDcnCFL7lGLtGICuJg/oj34lpXcF35U/s2wi2sYQXoe2xgHZ?=
 =?us-ascii?Q?IdCO8XdjrcGj0KQ7pYY71coSidhDTy/uSHxH+XYDJU9XG8xddTvYZpMGMajM?=
 =?us-ascii?Q?1EM2RxKI9dYNHI3YjXuwlqdQBSl0OfJ5QvZHrHVX4/lRZ+2vmUT2ipxOXHTA?=
 =?us-ascii?Q?Nlb/tLNv39KiVImYRYrhIHbt+ucb0417ZWHOi1ulTHB9O+2dHd5heCwQGv6g?=
 =?us-ascii?Q?BVhDo2IO+/3wZ4cf8N73GhtbQ9WojMpid3zC1ITyzjBc6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GwfwxR6HeB0dfgMdkGXDZETUv48Nzrj1BQXt4W7ULYNU8Yrd1g/r9g9rElE6?=
 =?us-ascii?Q?W6mqSeFTbG28cWOOvKgp7d0CRJcDJX7pZ7qX+NxZbnHiIw+aW55PQCGf98nQ?=
 =?us-ascii?Q?w66MrrZcL/Tiw1rvorUEuEzJkzCwxGSbyM1oz+bMP9QmsZV3eQroovAGCI9e?=
 =?us-ascii?Q?0S1QyGZ1np5yUtqjvHU79NVJcNaECZ0E3YyFyCPdLD7w0G0Cw81GA3xpzKJn?=
 =?us-ascii?Q?FPo+vrx63wGL+NAGum1dL3qpZJF7PaIJkBuH3tMlrWdoZrFu7qoIOXt226XO?=
 =?us-ascii?Q?bjLWHFlwuOwMjo1QWzYZ54TeQpsoZpK/no2Y2GqWwUYRt59HYsCPWtKdAkoV?=
 =?us-ascii?Q?zdxgP3azvKUaPNpL8EXTlJylAGQwfbfNahi57Fl7SAzdbSs4BqNQnwomYYhI?=
 =?us-ascii?Q?PP9hGI7pvOdWWGWkNROFwT6gM6MCdqcBde+KhaBTRR98Oro/veQ6N0DW6dUQ?=
 =?us-ascii?Q?Xmt6E/A8HWVdcN/jFvYiwLbD2JQqushrX8aRXNeRqOBav8GDLZid9Q2If/rA?=
 =?us-ascii?Q?850J7iO5A5J/3y4wOjt/PyBpTd8Gt34jsIK4SZ4W97VdYZ7vGncyINUoLEoZ?=
 =?us-ascii?Q?5laqyG5z4TBCIegt92XfP/ictvozmbviSwMt6ckUT7On2Gwu6Z/9zGwvSc8d?=
 =?us-ascii?Q?e2+1oF/hlvyiOJyXqYjS4frXmZbRKAvRA4SqZk91+dizhk50gyonF3roHneJ?=
 =?us-ascii?Q?UGS7JMD/3PKxBAsgENpL33CoQD8vOs2d2S7GKmcMMHELSG6bzcwcNhSTsAoj?=
 =?us-ascii?Q?iWNYkuCCj8dHAPlfAWZ5RHwDnjV+nt01NPevzX3uNWUne77Ws3nPQbUgFl+G?=
 =?us-ascii?Q?Sqyd1e9Ssfjs3Vk4Cl29vojXeaaWZMwQaSqdhEsA9wzV5Zlz/5FXAi/Ou/KZ?=
 =?us-ascii?Q?FyNNELmL/OAT58U0pTo1TxY/wX1k6VH666NzM8xcfaxqXfCXu+tDo1P+PGut?=
 =?us-ascii?Q?r7HndJsoQu5yqngqCk0rRNe+l+q3EQm3wa/wHSjlBJOq5mUOpj3NIouXqxQY?=
 =?us-ascii?Q?c52YGLnDWIVoed2cMQccgnTLV0naVGn33/Ci1qbKJ2Q7shf3TSWxib99IMUm?=
 =?us-ascii?Q?3TUUxcwfMx7FgOylBPHoqKwyv3fgfcQg+TalFt3D9FxcuV70F2TMp6G6xvsf?=
 =?us-ascii?Q?c7hb5XNf7K3JdzdVnxyUnivPk6Qtl0Njc1SfVur40o9XlcZVFOp+/GAiZkh8?=
 =?us-ascii?Q?OYcpL/7ZRLEYtDlWvkFsgX4azMDXpPJ+pxds5k9ns1GfjiT8oQsjsFQ0BmDq?=
 =?us-ascii?Q?3bm/JgfXdFhiRW99jXlqdcwPiBVC88zcx20QVF+QNQzuH/FSpadZJ1oKsz4t?=
 =?us-ascii?Q?NKsaZ3ymkA7f3S8CNQMKPq2V+revOmocYzW2s4TlftEa3wRMztqH981qBMnc?=
 =?us-ascii?Q?w7Yse2mEs6qKnpfO1K61hBgXsKpahSz72dA5HZDUW/dJei0DAyp3C9vcXFPb?=
 =?us-ascii?Q?a9EnEp+z7UX78Wdpsd3q0v1x3B5ioY9LppAKWgE3KzPgp01XraKk7puHsBIL?=
 =?us-ascii?Q?t0OYEGDwxfJmZSPyIlwypLtpKSfBEL5ReUE8cy7Jq2AfIhqPjKPjYbez+fGK?=
 =?us-ascii?Q?8kgvq0pAJSnmW0Eo/BL9a4GSuYptlaXXeQKC96jiy/QItMz6AKTy1wWZXnN6?=
 =?us-ascii?Q?v5SF2nLKytxN0nKoHU70F4aeskL6LBARo9DKdVI6otX46jOS66T9CTg4+Vqf?=
 =?us-ascii?Q?fu+xYUR97t09Xf7TAYsHMq/sN/8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adf1d45-ba7c-4c0a-2435-08dd20619b93
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 19:16:15.2055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GXKySNnjPI7epXEKKvCOnkvvKXBm+c46PQo+qWVpdupygrhAo2wm60hhQPX22XXiKEvxrrZ2iyrV1op/kwIHg38ktfMetsb8A4uyO0NKa9BWSHTZhasDf+BM8fi8/aol
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7527

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
https://lore.kernel.org/all/20241217182528.108062-1-admiyo@os.amperecomputing.com/

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

 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 307 ++++++++++++++++++++++++++++++++++++
 3 files changed, 321 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0


