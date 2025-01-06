Return-Path: <netdev+bounces-155579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B990EA03082
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 20:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256741884E76
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 19:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2633156238;
	Mon,  6 Jan 2025 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="u+3cxf73"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022122.outbound.protection.outlook.com [40.93.200.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B61118CBFC;
	Mon,  6 Jan 2025 19:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736191509; cv=fail; b=l3IU3qx/WYldYbztYMYZ/fR25JW/sy60jaZnVPYXa/yM13oxUaxjnld3m5if2nwE100w+rF5EZdkDVqxV1yEDd0N8ynIieEWKqYpcFK02mNt8TjOohIvDWE+jEHJFV8oH2dfaDAhus6cASZko0r4/HKAjSYmpHQ8HLHx/Wz3r/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736191509; c=relaxed/simple;
	bh=v0cBSAcy/k7VRA1RsV07YN9ZZn7OmnIeewr2bcmIpH8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ml5egOBQ4FpnSx4Esohs1Nw0M5S0StMAHs4ulgn7QOBvgiQ04eZS+Qw8PSqMQbTT3G17kJcRD+BgdDKBef25HKYb+YnYbAnR7EomM1zcojKhKybx14xnDS96kIa/v5fcki2C4bVVNH8li4DUS9J7u9syUnB2JhVUdbkQL2ki9j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=u+3cxf73; arc=fail smtp.client-ip=40.93.200.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=di6F2RIP4Eky41S0sfSSC+uZG06eAyvwiiA5EULwE/x/g9lHoTywZ73GyCEm3QWHL21bk/jlfnRQTNpanLjt6qOWct3nokhfKhZw+K1MlxCSyYGAM7GeyBgIvlehhTPCFfibdg9k68fGvqPpsMFtcbXYZD7JxqJDNOdpKaZ3h/UMr1rYRX+XUmbN0JPZTDeEWH7XcaCmY3paEkz6eBA9fRY2GhNnYaozYfXW+wFz2HIVihR4hXc5BMkezfQCxBJ2YKiD3Z3xILHBpsZqWaeCzdTl5e3pF0mQqOPTptq7cNFQTwENmouRBKz8FTfoKGOBkO4p+iWw0O/6mJMJzh/h4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlGo63V9GcZEdTrqJpCwSlZ4tNwQs001Uxo329e9FHk=;
 b=Uj5OJ+oLtzo/DvRjc8ZmY5Hf8DNbnw0/2uX9x2M4Rvmu/xEN048JfFfaVlNBUpwLOxDYJdv6tltAEsUvUSzAQXJgJfoO0fIVZcozqFwKmRBUd1Nq88sbdVlPfRYz6Y07jrZYfr9kdi3kxG2NADGaRvCpHcP1mt2MntoWBMyQy1ITb87FSAcxKwV24HHc9F/ERfwIRKEZI4jIAkGTHa7lJX9TGYplM5ON9TEkH6PIepl7Wt/XqTlJ1+WslNIGjIRgRK/aQmfd5jgCZn70RkBmYNL7dBSy068fyiW7UFHoFM4sP5a9dR2YppKLryY3+92xTdUrKiZKNN99Am79nca2yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlGo63V9GcZEdTrqJpCwSlZ4tNwQs001Uxo329e9FHk=;
 b=u+3cxf73f+Ct2S58G8pvwMWJ4KMHDhnxtM8vysUkV2h/dcqjtaxJf+ECATYkh35bWho0fQLRDIF7dL92gRyxAGAPqp/udgMs76gfaO3tH2k+0+TzGFwYNnnfNIhAoXgZ7nnTJL7NpMxcmYfw2dqxg6LhG7qKLpf7r3S194Vt2Os=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 LV2PR01MB7622.prod.exchangelabs.com (2603:10b6:408:17a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.9; Mon, 6 Jan 2025 19:25:03 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.8335.007; Mon, 6 Jan 2025
 19:25:03 +0000
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
Subject: [PATCH v12 0/1] MCTP Over PCC Transport
Date: Mon,  6 Jan 2025 14:24:56 -0500
Message-ID: <20250106192458.42174-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR13CA0067.namprd13.prod.outlook.com
 (2603:10b6:930:a::25) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|LV2PR01MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: f85f0e6e-23a4-4012-7b16-08dd2e87d1e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|52116014|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/WeiQETPekkZlAY8fC7CdT8JndxSupPEDWni5rrhVdFbzXO7Q8LBzRbaOaWm?=
 =?us-ascii?Q?shWBfaY+HhOoHZkENUqRxaJrfIAb00lEEKskvpxauXOWM0nBCoctdrEoX34m?=
 =?us-ascii?Q?4/UfYdNXZWFRatVRbD8s+YyEdhqJO/r9z942EqF+q0TFcD6T23ELrXj9f5zx?=
 =?us-ascii?Q?eb0jRWJySDJ9aas4VoOWAmuP0c9M+0pDuDiGzsT260ccXViEmG3coQSbxAT4?=
 =?us-ascii?Q?e68uaeQVR4L0pYDfK8ccmN+3m8N1V33wG/fAI7mWsKqjf8XygrF1u3XXQS5c?=
 =?us-ascii?Q?xtsFVIbn8B/+pJ7pNwHCncylv7H+NZIr4/dFNdfqnN2j9bsH/UWe8cdjBVHj?=
 =?us-ascii?Q?e893MMP15z1NsrYDWoHIg1gfJKXxv99figC5mz+Xe2VQZDtcIjn2ZpnLN2B6?=
 =?us-ascii?Q?CzN8foOIQ8D6Hjbp3KofHi0N5stZNBJ0ZwCy5Z6X3nggBHfDZnTIaRKQcZXa?=
 =?us-ascii?Q?HRD2Z19/2+z5qBVCbPiZiuCPwIdNqOY0HjO94lV0aHgDpQu6ki6JZSpHGZtR?=
 =?us-ascii?Q?0AlLzMZk3skqfdEhIWR0IVU6s/mb0LyLniMsILsynVnFLXbDnhoVNOwnBsjs?=
 =?us-ascii?Q?ijmQP+drdUrlfxtmGPGAUj+qNpJ50E0mlIvBkQjaqFWBJPFY0zy9kuIBS7ja?=
 =?us-ascii?Q?Rm5FV5bZnPIll6Gchk9e8rytLd99pTWb377R8iBoY23GzFj+Y1ij558fYpBu?=
 =?us-ascii?Q?5XcbtzGD16lc1llEJyc+ZWgtxr9ZlI4btayPPSVQMFMoBV2qTzRVL5RdHTvS?=
 =?us-ascii?Q?aFVFM205Rdxv6g0G6B9NlfizCo6KENaYiqJc/L6Dg/V5lsi8zzduN2tHuKCy?=
 =?us-ascii?Q?RmFz1b1JhwLZdzBAA/o9dfcaxjycX7BPMCzT+T8MJKshbHIjBzzsZ68AsMe6?=
 =?us-ascii?Q?lSmlVLsyggd76WUIovjrJJ6XCZs/BWIJLBx9QRliimJehZTRVg8Wjq1xMlhN?=
 =?us-ascii?Q?OMUpFU4lZwDPCjcSZj2nShq6Y199/ng8Ala+kQZji8iQQO2wOppkEm0gcVsH?=
 =?us-ascii?Q?xhhUXM6qx4CLYZy36N2tkRGg91OpbF5sVyrGAriIl5zsHzTq6EwYWxFpgm8m?=
 =?us-ascii?Q?k+CcaFsF+svpvliYkaOJEYpE9MBaFDlIB4rEVxw1CN2sQgP1NKbBcVZIVYCg?=
 =?us-ascii?Q?u7SCwZNRftPVQ5fnNcfOuEnABfatGUTr+NnrPi8cYH6xH4rDh8zNO2gGrIbp?=
 =?us-ascii?Q?III0jmZUvYnUjzDcJ342gmMty3pgnwsmGoGu9PuDboA7z4FtTgJ0t4HRmz/R?=
 =?us-ascii?Q?q0eMtKEwNZ4SIP15g/lEMDMdfM/aF65XhgElG6s+eOdMbGYSkq+WesFMjzK7?=
 =?us-ascii?Q?OiBhA5gfaJVz+Z2QPdw6sALY8QahLT4JHItUVkcvWbfgYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(52116014)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?411zEfsnCvbDwCfOIJ+rBsas6O28YgtRs5Vk8aAJaRcO3oovTcfinkUF4deH?=
 =?us-ascii?Q?p0lLORCxbstoMz4aK3NIzFk86ngWa8RECTwZqCe16DZd9CJH0ANMqC6HdXQa?=
 =?us-ascii?Q?LwK5lPoE+pVfk4/0dTs+UInqYmBw8lnXqKTllTv3yb/SD0DQy71k4wWVxGEd?=
 =?us-ascii?Q?HjlrBPRHroCbZFvQGfDylPctUJgAjDtIhXLcG8IddPyZK6PeEr1t3s5t2muJ?=
 =?us-ascii?Q?SHj1RaxKPHoJRD+6oG/oshbsqk4MMC7WYA5s6kgsOj3NOIpvgn5b8+knDN81?=
 =?us-ascii?Q?vhzdF2En4pLMU9pF6DKRgIRPL1+6n11VheRdmXdBbFN2Z1XJ18dPgPVFqYaV?=
 =?us-ascii?Q?oF/hW1UWDBtxBsoUCIJgkRyvMQIbk2OUsJCnyuLrD1u9YoP+LnI8+UMe/Sod?=
 =?us-ascii?Q?iUWhpkauD3L8Gfj1oaR4aIt9TpmT6gPMWGzAoEa45wrE/NRIYLdiB3blt6hf?=
 =?us-ascii?Q?hKDKMebRknfsyc0wagS5oz4gH4yMwHFBdPWk/7alxtfHHfuEy/xHDeZG7oaV?=
 =?us-ascii?Q?Mj2v1tT2eNo7jDd7Iyw/TAYFKVjB7R/H9AFOMItjZDP8/cP/fl/eE/oCCWX9?=
 =?us-ascii?Q?+YbFXIC+QgTAt6jSoSZJMGbXX7mTNKGoJ4fKzeLEvoLoTnGx1oowQCzF5gbd?=
 =?us-ascii?Q?48t4VhC9e2O1Q8KIcVqvRadEVlFZCVzSoseed+zxSCrerQ4WcKG2G4sW8sgk?=
 =?us-ascii?Q?rNZGlJ7Vb9DsS3wGW/eW7zPvuJhhISIaNM/OvislPek0I67DOvbfG114kmp7?=
 =?us-ascii?Q?KTWqJdCGYR1T19fvFZbaW8Yb5/4Vu9E+rACyYTNHTwqXy/SUoijE1q8rim7/?=
 =?us-ascii?Q?den0q1RbJN9TT4R1ITt0uVy7dyum7k0U0qo1fdRaQALrTOBABYVrQwaDAmhS?=
 =?us-ascii?Q?Gqhu5m1gBvtvRqQsv2GHHn+jooWGvxrqHcfBXaGdQ7zYxQu+XS9GfZLPG8UZ?=
 =?us-ascii?Q?2KdIrHfVOgJIggyPtGnz/FMOTjPWozL2xRf0v4umw+SvAHGCrIpm1TWTeDx5?=
 =?us-ascii?Q?4RMBWqwk1xk8higdYU+aGsdf5c8JLDg8GgMT2G+ao+GtfVsGMn8dTPL8DEsy?=
 =?us-ascii?Q?46tIll3pa7JOZ+t5zT3maKkPFu0jCN9WmrPrXV4i4KwrDmlJFlVYCErHk8UG?=
 =?us-ascii?Q?USssdDc3QYhH3934891Zdz0Er8exz8TmCB7/PRrVcatGyqIDEK1+TCgt9j2d?=
 =?us-ascii?Q?ebHovoKH+vOCgFz4roT5uJCXiMg3LGtgP8xayQenflt0Yin6xsJ4c2w7zUX+?=
 =?us-ascii?Q?xVCVnT2zF/OIw6gjFCN67Tvpiuf6mBfXJmbpVxeBaNZ5aVsfUjBQBiry/Eff?=
 =?us-ascii?Q?qkphrJPfubSSKfP6FTSPE3gYNQPloYZBcgk70VAYS5/lZan8WpGZZgawHLfs?=
 =?us-ascii?Q?Glke80/q17v+L7jitA2v1fUMxHeyBnowrowG8YWU7z4SYahfH5firCiLIDZZ?=
 =?us-ascii?Q?eHYFNDqU/U0rVpcHb4RyOZGWvqA3GjLpA9EbkJemSnHiTlPrNKhkfctEcGlB?=
 =?us-ascii?Q?5GqFq0NvPb6X8Tg++Eprn0P61h2rc5xrrOZOeo/Edu604khKW4FW0mWgBiHo?=
 =?us-ascii?Q?wL5hVvmhrfdyk0uKSoc9+sR24E79L8agZfB+vIpMr/y4YNyRRQRPOEmzWiiH?=
 =?us-ascii?Q?D1rtqWe2a2VL5TGqnr2RokgArSpj9ODWrqAOeA7I5k5t9hGa891INP4lVV2O?=
 =?us-ascii?Q?7qodB1vkpUDWAKN520j9Gv4NTL0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85f0e6e-23a4-4012-7b16-08dd2e87d1e0
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 19:25:03.4685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIINVBV+oOKCSmhOpSq7sGRSaM8H7YH7yakdTR0HhkJ824O7qZXSgnzTJOaYBCsyNhVAewuVr+cuVrqaX7UjwF+O9Om8/E79XMxdbdIcBiNZRQS8KxOF6geAHyS/ysCc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7622

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
https://lore.kernel.org/all/20250104035430.625147-1-admiyo@os.amperecomputing.com/

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

 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 311 ++++++++++++++++++++++++++++++++++++
 3 files changed, 325 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0


