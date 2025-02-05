Return-Path: <netdev+bounces-163201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC258A2992B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8446118808B3
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703D81FCCE1;
	Wed,  5 Feb 2025 18:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="v4Bttv6F"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022082.outbound.protection.outlook.com [52.101.43.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645ABFC0A;
	Wed,  5 Feb 2025 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738780377; cv=fail; b=DqYEexQ3imkURfk77O3SYwtOdwaru7NwGoac2GKorXL9iv0ZCWhLaiQdsy1iT2Hk75Z62sGIIQowNyJhbW8j8o1P/S8el892ouFiURVW9bk17y4ugK3odhVP63xWZJG2omrgCqhrYaw3Za2RjM7+/BbbRwM/FSPqshnLt8zKwLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738780377; c=relaxed/simple;
	bh=Hjt2SYCT9MpYEeE6/zEwBhZCzcwsWHWxOcJ0zg9RGXI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pbdNwzFvPaQE6XRnWSuY2yLy4Y75VKo+2wvSpJE4+DuM9rsuJf9KTWj0w9UtDcXItKdkXbS+DwdGjtl6KoP1spsvRPR2KyLICM8FUw+9NAO+b5Z+40uV0fWz2JnLya8m2bw+2Q617Qu7R2SKG0WAjEW/65EPuBOt655gk7vdRbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=v4Bttv6F; arc=fail smtp.client-ip=52.101.43.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmyCZZeHZGxxqVMELntzQbkJNr0G4nVp6Id3f/54Pcx5QEKBja4Z9sjFappLzbMsPE8xbI3vkXuKEuemTOt0E/JbCjAnygQ9Bf5aGQWc+9hK6u6uMgFc3bbWlpnssvUzlcPUSXav8FWTZ1W6YjEC5D9kl3C84GFJHSg6H6s+R4eSTzgoPN74l7SUYvApexyscjAOPgjH8IdcGGRdnEFEoH8vopf+RsZVZDwAw8YvSJG2JaCJu8y1SgYucRPt2H4Ds2bSR18MeLKFQWBKVGmaCgrKmNJfDrNcdVAxkZ4B32v6xbpGMscROxSn+mTyfkF2pNHir39NFiF3o3oOqJcajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOnT8C5fmg7rolU66Y6UuyuVXFVwJrvc8AbZPT1COMg=;
 b=dfp5dSIW348WJF8viI5Ow+wLcF1nNe58ihOnrMXGGIy/svjukwieRRmOV2hfoPUjyswn5BjIVx6/21aNNmldWvtCIqfoOC+QNdL8N6EoOaYY1cv3TkTP0Gndzy+rIWkVm4q9nAmmU7UKJHkDy02YvOOdr1YaJir3zK/vPVoU5uzYjL2RyfoiB2FL9CtYrHs3GMbUQbwbJGrN5S8vE+oXH3DfGZzuObg7zygkVfrhBvuISDAYNUVTWL+wr7oNdDQbfA03oeUIndatlNOVX9wnoiLzwj3nB85ppMs603J7yyKTT450zlZW3g9jvgpUCJw4BSz0i+OQ6f/nMpsIlcEsog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOnT8C5fmg7rolU66Y6UuyuVXFVwJrvc8AbZPT1COMg=;
 b=v4Bttv6FvSeIZOmXvlNWZuFSe9I7hKnflDtDh1Q6lI+SsaOtffUeiMxG67MLBoYPsj+qvklJaGMGQZsCKtu9Po2GS8DlSIZxMF4i+Jgza5/z3x7RXifrbHPdDB6LUQLBg2lMnhXMoKgIPrJFEJ9EE+rHUHPVX1mEInGklq8pL90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 PH0PR01MB8139.prod.exchangelabs.com (2603:10b6:510:29f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.11; Wed, 5 Feb 2025 18:32:49 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.8422.009; Wed, 5 Feb 2025
 18:32:49 +0000
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
Subject: [PATCH v17 0/1] MCTP Over PCC Transport
Date: Wed,  5 Feb 2025 13:32:42 -0500
Message-ID: <20250205183244.340197-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::16) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|PH0PR01MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: 98bba328-39fa-43a8-0382-08dd46137e33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1EnhCPCJh602/tMrpyUS84Dgb3lYXEq9HSo8g08CGpcO1UcEIA3TWa9brvgm?=
 =?us-ascii?Q?UGkk4/4uW9RPIXgjYl2eSp7BD3rwvbLQE30huUadHnV4fyp9oMiLmMmaQs2m?=
 =?us-ascii?Q?AyN+Q1o9YZuN5XKX6+zJHqA1yr23kv8PKo3uPuWn9TH4hPsWK0S8e2MRSX0f?=
 =?us-ascii?Q?ND+bkF0z8GkgcsA3WLvq/75D9dn+5Z2/SRy4HaSoNe5A4kj0YqdLi+C5J1l+?=
 =?us-ascii?Q?okEtX4i8jjCkr3vG+3MBEif4ZDfz3FQYmVS12GUU+hrQKKzQtXmsVGbsyhev?=
 =?us-ascii?Q?SgzusOXVxZMwJ2pHo7U2V6PAkPNgTCIv6oJ+IG9OTjeVRam2dFqLxTuWTqxK?=
 =?us-ascii?Q?2tsl6MUtEoSXrDKlN5L6zZ1Vh6KZkQFL4Zz1D3APiyy/b+for+efdcahu0ba?=
 =?us-ascii?Q?0p1GzHB1AMnJsQgshEwFDqxw7AUXn2bMyAtruS/+j1iMyxhLDoKRHR2TuLDs?=
 =?us-ascii?Q?fLPxQbdMj0r9RZ6Oo8NOyr5Z4G9SxG1F+cMEuyjTkNdWzdC1SfTrjOJ7Ieep?=
 =?us-ascii?Q?1zZema75rwOVbwzahWN6SLPfkovi8YvJBQXY+IzQ0nVDLu11na3rNI3eBkqV?=
 =?us-ascii?Q?z0tm+t0AHO9iaDer6QD4gNtXDIX/zAXJtkUFfuzeKnQaKrB933MZ+U8vKGQM?=
 =?us-ascii?Q?AWaTYrES62D5Zrr+DZiAIRmOjuRfWxxf4KM+sFwVG17q/xBzcFuOTwZs3mKV?=
 =?us-ascii?Q?orgAUtZ9FawY84+65cjknmTQASN8eTydHfVsro+QdG1GpXhddOeNfGTqLsS4?=
 =?us-ascii?Q?aKEN2VA0BlRLhUkoNn+ZiWr5tu3ddWpJ7duqomJp6aeviN9Qxqj+oudwnq67?=
 =?us-ascii?Q?h/k7n9+OWafWlkufsUj4O5090Ad34Z0OeuYp7IV5WadmmtPf0akZe7d3duqh?=
 =?us-ascii?Q?/ZP8n1ygceyDOCaXPO9WdzHnIyjMDSvPxSwC9ZBWR0dSsBPMn9c8YPD6XpTt?=
 =?us-ascii?Q?uicwKRCoXF5WwRgoJPXzLLp7cb08QSXHX6l4te28L8DgJ55wS1lExzgG9Iqp?=
 =?us-ascii?Q?XwbJA2rfu+j6Cgp5kaGlb7HH03TvzqqttT+XTXLpYEk3VINHVEsFYodtfdXa?=
 =?us-ascii?Q?uR3+lQrapF8JULGGj75c91SZcvUi7A4ABEoKEIihoF7+dCfknkYCV3mRU3VD?=
 =?us-ascii?Q?q03nM2hQtvuJSujiWAyztkeahmzjSQjAp3Rons5DrzD58z1LtUFhbipe7rnE?=
 =?us-ascii?Q?ISu7lXUYJ1vTadEnojx197/AWMmwxDknitMrrVtnlBdXaUgIN7riFBs/u3rS?=
 =?us-ascii?Q?H2Qq9rC07DfC7vleNGlJ5n/5D1ZrkVHvyje/+8ZbEL8IrkVpXL9zPLiFihhk?=
 =?us-ascii?Q?FMDMdVL7xSDJ6lakHJU6l3W8Rzdj1qKqgMLBYw5fjtU0Kg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F4VqXLE4KEEGluFCi6VmIIcJvw38op6dg1cLZndVdDFjAKlfyhFPEXlfW9q3?=
 =?us-ascii?Q?OZ8EaRlZVurL4ceNvgInSBUR6daiiKeKiA6rHSRJ716ji26Dwyids6UXKKOb?=
 =?us-ascii?Q?xaBj/3yjGkL7ICYvOtblueoARL3+BdubJqOh03HezFREp3m8ddiKQkrD/6Re?=
 =?us-ascii?Q?BQipp/u0X2pSKm2BlMzkIK4fUY0oZgJPTcuPpQV4MUYffyh3ksOKaCeMvTHb?=
 =?us-ascii?Q?g8bfC9xRamtSC7z4ep1y8F21iU/4hnRhsaRIWeHhCAn2b8aQrNY7ZyoVL5Yz?=
 =?us-ascii?Q?mSCnUZPjOJg7+MGHrHIoMpVZgTyJgJ7LAFIss/LCLd5IHiamBu39bwRtVrX2?=
 =?us-ascii?Q?d/hGst7Ijyl8JTgad/w/r+DDW5vfCaK1ykrwuYWXM2oIE6skKY5U56BzMUOf?=
 =?us-ascii?Q?U07XnT9+dAg2BVc2l7/QBSugPEoSSwZjG68JbRUHElaHIAw/se09mGpvXI9k?=
 =?us-ascii?Q?HTM3gJGJEA9jb00JjC3o5zkwdLETa1+Rot+gRVxfx2UWywENX6tIOh+5SmmR?=
 =?us-ascii?Q?KW9GR17zg3ewGGl9v+tRxr70rU3i2wrkYf4ONhrYi0gmliRjqSaxLOJjI/8l?=
 =?us-ascii?Q?z3Pwge5ydqDkp7+HZNbACMOcBXoq76HJlHQ1LEVwGEn0SdaJEi1c4FQlweyv?=
 =?us-ascii?Q?twk7xIedf4CynejWOxekMXfaaYfXLtjVXa4HwK2ZSyayVy5e19KLRUyay4ow?=
 =?us-ascii?Q?01/R4T1fVo6OxBOGmrDrlFkJO4Z3Yk30eCM5j/SAmfwveYjOhijDveTWs4yf?=
 =?us-ascii?Q?hxR+mKm3STfSEpggZ1UU89Gl0skJaQymk/wKoT01/ZyYLzY0Vft6D2cpS4RL?=
 =?us-ascii?Q?u+oG4VLaELBl/DOy30d6ClbNDrHpxChm2cAzUnK8myE+dHSa78WPxLfqXxpB?=
 =?us-ascii?Q?1F3rABS/AA4514q0l3VGT5InObB+QKA3Erw1X9v6ZdwJEdR4taWiJpkLDiZh?=
 =?us-ascii?Q?pYSq7WcFSkUjisUiPy9em7MtzKLHuHw+CdXGqwY7vqKc69jfkc/EBwBVygem?=
 =?us-ascii?Q?CZdF4BJMvFrlTQxK9L7tfr0AVaZaJNLSNTvbHIqgnoUK0WWnnyJ5VF8IARJe?=
 =?us-ascii?Q?B5ISapao5udvmx2y+rWRMH+ZAjD/g2QCBuZc+PoyfpDtacoLBbAhaZh/j+2l?=
 =?us-ascii?Q?0voSsFLFue5l76KV2gDgE8oNmrb/s8b5xDwcbqQHVdbHFxAHAIPgtSr5Gkce?=
 =?us-ascii?Q?1Jb4YR/HQMdATI9uTWto6p0z0mRd2Z51mIa9k7cVbHNsnl6T6VBxMgSlc1ki?=
 =?us-ascii?Q?U90RGJ9r3e5MoEq+KSS/uGsqk6PcgmDF9g62nDu5m4gXSmqwvwxkqdtBXutT?=
 =?us-ascii?Q?3kOI5E2kRXkAqYdEMiglTIvclzcqWZTqL5BwnwISoOYAZUNSULj9iVORw3Q1?=
 =?us-ascii?Q?CnT+9q9VZwDieY2qGIENw+nb0iCtUenwm4SV1K/82KBQn4YzlRq9pKV8Ewlu?=
 =?us-ascii?Q?iAa+jY+YoqtjvSgoTFBRZAVz2xW3ZoNjcvce5mE0IkQ/8QR62WwGQp5oHaeH?=
 =?us-ascii?Q?f0BMG/7GphdMeh0F3qyailMeoqcnH7B1b29jEWclW7vA3KrywnqgNYC4sUWn?=
 =?us-ascii?Q?0FWsVGMOksrfIr2SHEyotJt9K7+XXPc+pokXIBSrtf+IrH5Rm3SE27KzO2rT?=
 =?us-ascii?Q?TGNb8aSm5x3d4S2p/F9Zd/8dJwm8ECtt11P75YS7I0xWtDfR+OgHvxxkda9r?=
 =?us-ascii?Q?/LQJ1epd8GQhGjwNuU+4GpNNHvs=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98bba328-39fa-43a8-0382-08dd46137e33
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 18:32:49.4185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xRiKUOp7h+aGJxIO3UhWKhUpZjm0gTqSKB5CmJ0/1E+1tieYFigCboVjg7QI7Q9A4X+ycvBz4bOOKtSM72jekFVmnTmwlkbRD6yu+rU33BKeBU4GvZnLfLAENYDOTM6w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB8139

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
https://lore.kernel.org/lkml/20250122153549.1234888-1-admiyo@os.amperecomputing.com/

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


