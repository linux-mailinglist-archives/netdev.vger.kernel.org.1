Return-Path: <netdev+bounces-140003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A86349B4FD7
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 17:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25DC1C20E0D
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 16:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD8819D072;
	Tue, 29 Oct 2024 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="a83kt/7B"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2126.outbound.protection.outlook.com [40.107.93.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEA419A298;
	Tue, 29 Oct 2024 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730220868; cv=fail; b=Pys0yTh3WfPtetHKEwsWnhm4EjvTk2Q5au3kxSk73wIJ9kyPxGNpa2Ftrcnj1byXUZqZoyCt6UaqKSt7hhNsLWA4/Ptn9DbyTbBzgLzT5mzS4iIIR6+U1nhbv3iRQ7QPwYZkAPmWt13BzeFGNRVrjoSlbnUgnQWu/GEQC9cZH9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730220868; c=relaxed/simple;
	bh=lMAtT9JB7dBB5w6ceNlmqPk0+mQZrST9dmDpQg+rEY0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=e+Pk/nNkY6AmZOmXZVYp/+6NO/t9nTFmk5P74zgqET3HpdHZy98BZLDBoenzMEfb4OE+NsLsCWo7H/vMOYpVbfwmLvzhUw1OY3Q9HHhNoRalXjQTa1ME+HRYfIpU4AUQPJge2lxDVXfq2EcQNQpRiAOH+VO2A3hXk/lu6sZ+6z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=a83kt/7B; arc=fail smtp.client-ip=40.107.93.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0Rw0LM5thjwtw4lVE5wkBfslAKSnaCLjYYvXGtAobbKlIT8y8f9ujRso6r46UmbEsADh2kpY05ZhWX1AjLcegSh3vyuuLSm5fJfs80Xz02lG77OnX4wMKTpBEh5YhF6Ahn/tyjuAg4W5fuKAdCfxHdvBrBq/qbJMS/JqjczngxzRtDZ5qQ9Dw/3ClAzdg9iAsbukojL9L/bJ+kKZbg5//vuLUr0YW31Wa8pEjwcEKEovWlCugK1EC1Df5rQnwRffdvHj+JAp0j+lv5diP/4OuDdOY8hikvxaFc+3SdTbu1B9/6fQbbJqHmqdtZ9ODwf3s9ROVGZYyVwoHTu9CFlbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwvpFUcHX7vArfqBS89pfwPcpVUd1TTkpeIg5vuR8es=;
 b=HIB5/XeDZPpskggzI7tDrMgkyA79t0+tAzoIxKoUiMk71wmKw3s4ZSnQpkD4rqnHSjrKzNz+ephebBnhIKXThhM6pstdFoW2ClSf9ySZRS7me2Ncp6w2g/FdtbKk1LsyBdSbD7dsZm6zfqgZjo7r/gFRczrQxFt07Amme+bPY4kRxzam3AOK5rdCLBoFty1p4lEz2538j7wd8Qe2n0a6JAwTok8Wj3H4WQ/AguBWq5ByaTo0Dio8IEYPA/oMQO9iUhhM/uIQ2JtA6bPAUUdzzeCa5ROXi1mlQ+CrgDSEtahOFB8sxvKejCP/y/jEhkjgLh2WPv7Etzn3VBz4AuG++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwvpFUcHX7vArfqBS89pfwPcpVUd1TTkpeIg5vuR8es=;
 b=a83kt/7BlBO4r0AJaH8hSv+6OVdJ0NBwWy1HfzNmwgD7TmuUaHs5m3tdQgjxkr1yZnbf6qh9zqm5lHnnGR+8d/MKAdQBvZTKgK3aPerMpT4ym9zBt/0MP2zko/hKVgr+ZM+RlgB3dgGI04av78CsxFwNDfcr4fzuiXr2K1IYZtw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SJ2PR01MB8372.prod.exchangelabs.com (2603:10b6:a03:542::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.15; Tue, 29 Oct 2024 16:54:20 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 16:54:20 +0000
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
Subject: [PATCH v6 0/2] MCTP Over PCC Transport
Date: Tue, 29 Oct 2024 12:54:12 -0400
Message-Id: <20241029165414.58746-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0046.namprd15.prod.outlook.com
 (2603:10b6:208:237::15) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SJ2PR01MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a63712-87f0-4e8b-208b-08dcf83a554f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G9ZQFValI3BwshmtMITvjGCxL0izQL68FD9P02qVB/h2nYurviyG6BB12D3m?=
 =?us-ascii?Q?Yms1hn3nw016yi5NAZL8EXQm6kg3gFUQt4mjuQZwVFTYUz0jixg1vNXGfvyM?=
 =?us-ascii?Q?0/VGZLivTHtwTiKTLvHfRwpAgc8c1MbCgFcJcdsMjhgYEr74Q9gFxkmieCHB?=
 =?us-ascii?Q?iNfYXI/ipI8x3a+OCQIBopqK8UhDjGvRZhNdICxAiUo3SqQS8ylzbAf9Ym0t?=
 =?us-ascii?Q?uXe48gjUe/GQ2x1CSBprKgk3B2ARVKYIJcNunU/9cZK4BPv6ajD88VaXbwSY?=
 =?us-ascii?Q?lv2To+Q3R74qRp6Qvo4R5qO9FrA/kgijtIJCOQO/DL+5/oAYsh62eEiqotam?=
 =?us-ascii?Q?VJFEAav/paXgCekpHxVlr2VkpET8j8SMICgpGe4tHN3IN+7+6rTrrpog7jdr?=
 =?us-ascii?Q?wkumYgDXuUUVcMRg0rrT2xzElN4prrlPiYo2U6Ij78x7u54tsEafv7ytZr/v?=
 =?us-ascii?Q?OGtf9VMLq0+9lvWP9yC7JEfF8EZTTucPStzTKW8X6T0ayaK+XbYHY8MhXoot?=
 =?us-ascii?Q?CNbQWw0/IjniHobFkb7qgInC6MOorS1ocYtNDibey82u59mBDRrkHRLSbnFJ?=
 =?us-ascii?Q?2/A/4ps/9ZoOM7sH/UiOkY00OgBxNp50HlA6gywiaMhUySQFnPgSDZZt1QMZ?=
 =?us-ascii?Q?3A4J66pnrCSzmKdKpYwds9NgVjd/m/ORuVIQYGke37AOnCTv6NMdt21JZC7A?=
 =?us-ascii?Q?jkzdodm7y2/tN+rvyl7eBeOKQNgcpxqpSN0ENnVG3Pl+93Ua6AbItZNdYOtx?=
 =?us-ascii?Q?l/BwZUYgfhcw2C/6rhwgji5HusjiiUDJZS8+wHLFgWCgqMvJk/M5h6WEJUi9?=
 =?us-ascii?Q?YCkbhy+1Qwlm6l3Px+zkOhp4GJem4p7aHeOUdcylFzqDDTSttRifN3w+WHqJ?=
 =?us-ascii?Q?58xFVefeIXV4QM6fKZdAqppnQ3ZIwFY2132MAcJAFMjSbvw438u2z3P8PtKg?=
 =?us-ascii?Q?beq5M7gXDUAQ79w/Dubeb+URZijBuS1Zg9sOzc9N4l7gwHUP8PgL9BGB4Pl0?=
 =?us-ascii?Q?e4PeyENignm1bHAikQBKz6fEi21VUjuPp6u09wQwlZB8IF8osN5S3W3D7g0Z?=
 =?us-ascii?Q?hxpoozEsyqq/e/ggdxS9w1kTHzx1bXHzJx9x/blJTmjeXj9kdY+kRTopm4zz?=
 =?us-ascii?Q?LvahnNLO75CeTLsfqsRaFk/cwa8dl9FRkoHZDIpW+TzKPTFZebe8wthYrYw+?=
 =?us-ascii?Q?5wKNvdRLryQPV2Sx+tUKdPGmUNZ93fYMALlZEkpISILzaEubHGKU/gOWbQUd?=
 =?us-ascii?Q?qQfPb0IZpDkzNbwtUEGX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lMZQnAdpvLCIBieqgdX2/mM0nBdGYF+r/tZTaHGdrMESTjuXzzxmNvfFuqMr?=
 =?us-ascii?Q?qyYkTYVW3+3cqlvqlalhQNgG+YroKTHtYEL02AoL7deUIHeJwJYUUc4aaDQs?=
 =?us-ascii?Q?WaJF59B9ojnPCpB5f+PFeSJMfkiRCTKN1ft19O+DT31DtNGkXZXvb/Fn1I7T?=
 =?us-ascii?Q?d93c4uk2IFEzSG3+gzV7Kt2roMZFe2Qm+VsrHeHNJrSS31nbQ856lv/Bv0Ue?=
 =?us-ascii?Q?t9AeUXqJR5hwtsj07n+7g0siHlVwUqqa6miZkECu0EmwobXjT56f+8Elqhdy?=
 =?us-ascii?Q?mBX2bbs6d3+hufy9hcxCGdNUTuUfLL6BrUUXyfLXR73wVh7RZMkkD52BW7Cp?=
 =?us-ascii?Q?gESBOTNVPfvuYJyVUUaSf/5svssekHhd2Kts0f6gTTTBT3pLfTF0grPno9oY?=
 =?us-ascii?Q?PmGKWOtCjvPa1jMyLzrndOBktQVYN1o7kl1zw1ODe/DM1NTdASV6lQH/omlA?=
 =?us-ascii?Q?1MHkKRNvUTszkN4qyboiImnEkh1T7RyYHjlSDulA1thULSlktjx8IUrB5+AY?=
 =?us-ascii?Q?JP+xcGZ4Eh4AIJbTW6xRpyBdACKIUVvGoZXBV2SN/KQqoy5TKGI46EaHh+zV?=
 =?us-ascii?Q?et5Plzu9W6FMc2upLOTqnkR8cEfCSdcAmFodWQ6DmoF1A3679eO3iVllBioK?=
 =?us-ascii?Q?H/Xy1w0KK4bXgsR+nY3AiWDltwqouARlgwUEWeVNH8cLtOb7wmKweumpz3Ls?=
 =?us-ascii?Q?VwTnmQZf2VdtqAEGfCmZTFr426UZDxBtR/DIjHYchFL24cHoSt/nx5f5yXj+?=
 =?us-ascii?Q?vVi4zo0hJ4brOzRIouNTKvO1x5fmwG6KGYV7+5hoe8dhoz2vJl2zlF1M1cWG?=
 =?us-ascii?Q?Q2suy7EA0v0eQDQYu4ZgXGThBJlHVoeidwmfqmsdL7gqCft4fMuZL0QjYaHv?=
 =?us-ascii?Q?XlVg7nEGnFJsqLLmYxfio3j9PaTzhkpkkRa4TYbs/WH9BGK4px9TP/qg2/74?=
 =?us-ascii?Q?yO6QsecDLPQM+Ek/A+pj0IFxSEJR3xLqPy3Pajv+V2ehRsMnrKnriO67ELXu?=
 =?us-ascii?Q?hNLCvW7WG0SL0cBabWVdiTvkhXVedhdw5Zt2eFeW0b5g4xvy10+vdY/nvoma?=
 =?us-ascii?Q?N5H+WhzqUmV6HQllmDEDXqfEatnBParQ8KFliioZhJufsUcnVyVSngjWpu3+?=
 =?us-ascii?Q?CEWHxNihB6sziiBj1iCBoFrN0XwjhKquihHPBDdn75gxFkidRTOQeExyvWz6?=
 =?us-ascii?Q?jLYfVWJey8jwv78HgVL5vHhfh65u3nrMt4Sq5Hi8YWdKs5MCuCRHqmk+C4Du?=
 =?us-ascii?Q?vrMnZJQF8dM4KXUG47EPrY7q7pgXzP9qCdey88tOJeksMmZogXM6odkKQRvG?=
 =?us-ascii?Q?dg3/L+ZhlqagezMfO0SZL5t8vRvg7Srwi6jAjh5aCBzuLRfI12JX4y3Y7T1q?=
 =?us-ascii?Q?3boXJTa/goVFR3vXAxi1jC4Xbw06SbFzYW9lTDTYqVtabHACQ4pX5T3CYD2x?=
 =?us-ascii?Q?WrnNBhQY42KgZ9u75G6ONhb+ilinDWYEOHTWpTaXExq3+8RDj772J51RecqH?=
 =?us-ascii?Q?MU5IuVLgY6SDmCB2Swl6piYES2PD0ATCbsyJQgTsh2Bc4qLuK3RwWnjjQGHK?=
 =?us-ascii?Q?7C3m2fcihN9h6pxONeFHOcCWMzvqJpyF388SSS9O86w0SoR5oQ6+7fs/CJCu?=
 =?us-ascii?Q?Hdxi9x9FTB19Ww3twuWn8I9v4QvnhQkB/UBKFW9XdKWOVeyHWur25fQ0o/JU?=
 =?us-ascii?Q?I/FzGDP0et0cyOeox2UtbKxZ1KA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a63712-87f0-4e8b-208b-08dcf83a554f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:54:20.5423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4w0oH2rGSe36DeUojJ4Up0yLxgRokPLEmf2MgS41AxeGVA64lTzrtW8NRC1Now0eBM5fXeis7AT9SzASgos93y43/tPkDZIbGoTWxbehoSJLKeo6reZYPFwj/VVwgXes
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8372

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
https://lore.kernel.org/all/20240712023626.1010559-1-admiyo@os.amperecomputing.com/

Changes in V6:
- Removed patch for ACPICA code that has merged
- Includes the hardware address in the network device
- Converted all device resources to devm resources
- Removed mctp_pcc_driver_remove function
- uses acpi_driver_module for initialization
- created helper stucture for in and out mailboxes
- Consolidated code for initializing mailboxes in the add_device function
- Added specification references
- Removed duplicate constant PCC_ACK_FLAG_MASK
- Use the MCTP_SIGNATURE_LENGTH define
- made naming of header structs consistent
- use sizeof local variables for offset calculations
- prefix structure name to avoid potential clash
- removed unneccessary null initialization from acpi_device_id

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

Adam Young (2):
  mctp pcc: Check before sending MCTP PCC response ACK
  mctp pcc: Implement MCTP over PCC Transport

 drivers/mailbox/pcc.c       |  35 +++-
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 332 ++++++++++++++++++++++++++++++++++++
 include/acpi/pcc.h          |   8 +
 5 files changed, 381 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.34.1


