Return-Path: <netdev+bounces-106628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FF6917098
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 20:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96FF71F222FA
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 18:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F37A1487C4;
	Tue, 25 Jun 2024 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Ul9RtZ8Z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2111.outbound.protection.outlook.com [40.107.93.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DF81369B6;
	Tue, 25 Jun 2024 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341627; cv=fail; b=sKEeMWsHHHsSz5Oy+cDF61AMxe1vOxH1PbSyVNdKqTzW31dN5a6/Cn4fKUF8TrX5rXwnk1M3geT4au5zJWReIRtUOgoivNargliiW/zcOncTWqHA6suHiRCBDEZIbQ3zPynhjzpDtIfsW4P215LrWv+hvMBn/JPetLkarZh7Dqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341627; c=relaxed/simple;
	bh=E61rF2DHsYdZ8Cm3LQN+6hmd1qUjlWw1mAKxJwPp/Fk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZsWetAyNguX58B6QnsHnKP3M+rf44MyLwkBbGF/9hiGQ5b61157E0Cs6W6UUPFTo4KYq4k1S5r0sNj43BxRKMQTJxGSjye5S5piSnUURkL/lu353b3AhlZLmg3Pn+AYDZF49DSfBNVRRovM/M1C5K5ByDicVme1kpkoDplbVJ0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Ul9RtZ8Z; arc=fail smtp.client-ip=40.107.93.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlMrlh91F173AjBPd2d52IU3HhuQNyFavDFUlud9tz6e1ojVh9aLFT9TiqiEz7Wi2wkrOWmOhnprHNUHrlXai9NQW4gJtdlqbP/KW4bMy+XRyfQf+Sl0PxFymnUYUKpxoMm/qhVkBl6U4WgVIbzVwu5woeqwBJSEIimkmNoWJagRdFnEjEWjpzhF5fCsCRw7RxL7lthsMDGS6hjwYI77OwNK3JtZUEFGphiGaAOfSdxGp8KR4JWG5AVEfAzdrj7m4qix7HJCYOAolz1987wUrfSHu24kkQjy1Crj1/CKUeihAEc4NTdjLlNz5HbY7y1XDFAiziRPUgkZ7YSpdomkXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0TyFhP4oQOjkMaqQccmVS+P7J+h1bXacPZCSPNA1bM=;
 b=mYB/iEKxEKaJzY8pLx86+MZvq7f5xnZkl4QqTHmsxYBFZcRbeVQR4zxvo5hsX4JBg4RyVhp7yeAYc31C7WxdY5OvT+6P80txhVtnOjTBO6vA2x8x3VyH8lF3+PRi3JHdw8D/EX1J6PVQKRl7PhXW2tnvB1G6TYzXfLinhQreB95kp0bK2TjqzqFKk1q6bOASIVWOHVuo2tcD9ettdOg4R4q30PN6tQ5yfmRAbbt5VqwB1foXFXH3EldGsUd+sQDu25R41p5/BI8k3V1UYSkWuLkN9YC7Qn15eMvkQFSlcqnJxZlLtvL9x7eTz2F5xUlb08ZC4UfVQw28aJJWXWIevA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0TyFhP4oQOjkMaqQccmVS+P7J+h1bXacPZCSPNA1bM=;
 b=Ul9RtZ8Z4jNOFtbPwQMSCA1w4EuC0PQI99CUD+ZDXdqwK32hAR9MEetsy5nCmukpTB9PwHnYxbhTFHnPr1pL0R83ayxhtG+nG0+HbkUQbBOt2hhOkK4FkiTTAlN/TsTp+KsHOUI9ekmQCbHpqtuZ3vg75eANYUgpg/Pvx5HTsvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 PH0PR01MB8070.prod.exchangelabs.com (2603:10b6:510:295::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.29; Tue, 25 Jun 2024 18:53:40 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 18:53:40 +0000
From: admiyo@os.amperecomputing.com
To:
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v3 0/3] MCTP over PCC
Date: Tue, 25 Jun 2024 14:53:30 -0400
Message-Id: <20240625185333.23211-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::13) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|PH0PR01MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b548d25-48d5-46f3-5f12-08dc954820c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|52116012|376012|1800799022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cIfqOT5yiNok+r1Wd4c6ff2F1Rr7+OPuR7HXaEUYbAG2kKMd2JYQCcCQc63S?=
 =?us-ascii?Q?JHnABugkVq0t5Ej90yNSuXhSP3PENolnhMHPSvyTCkGd5sn17Qk0ZXo8u2Xj?=
 =?us-ascii?Q?65yj9d5/NF+QOUYurM9LqseNeCX9RLr3qr2IRuhoMpn0EI4xextNLEnwpc91?=
 =?us-ascii?Q?8d2n/KuS+ItD6HzoZkz76uVd5J1O0omf1PK6JgsxEDQxos+jmDTyJ9yEw0Ei?=
 =?us-ascii?Q?pOXiWbCVS4Mx2S+/zC9hJtPisBQRnrEqximT/X14nMWg0cq/2dhlT16GrEBk?=
 =?us-ascii?Q?TfEJXxCfcZxUp6E6gPqtRHO1e/HWDPtRwRB/5Jv2XQvy0pP9QnuFocw1xoxc?=
 =?us-ascii?Q?zekVm4Y1BmrgN8UsmOchJ85pd6VISoXEaTln0HNeNlLK6Xq4c2MzVBpmQNBb?=
 =?us-ascii?Q?0OCpLrwHY6I3P7RK8Z4hJ8owjMsg2E5/2t5Azn3X2OdxhtniJI+AEpt8diVn?=
 =?us-ascii?Q?fjeseJ4Dcis8zh27POve1GD6xLlAEAAOD8e/mIDTQptuWL5UNqjque67QdQX?=
 =?us-ascii?Q?z3c3i+PP6CGDo5Bges4pBZmt05d4G0wmAbHoq4rxXT5y5fMXBNExnTd9Pyrn?=
 =?us-ascii?Q?SWVVev+lZpdEek/G1mNSnNxc8lK+dWkvbTU5eqhOpgqXy/YUIJ3XFXP0cGQ6?=
 =?us-ascii?Q?WK4neIyPO/isMwUZdNE+VKNiMQWvHMV7D75XKuSn0wkTtMZZ0TAnEP66h4Dp?=
 =?us-ascii?Q?+UI2oPEgT+l8qDYWvQ8g8C4hha6nN45Afq7Lqrmc5ZewKABNE5RfHccDfJki?=
 =?us-ascii?Q?n4JIspHKdkRVRHccFC3T0Ge6/pbFJ5lDI/RPyMOZs6YaYD6457eg2IxIOdBv?=
 =?us-ascii?Q?7su7jYb2WUTMaRy911EI48YcrKGwMwO1CDBiaXgroD4cXHPR71D6EYzjeIYb?=
 =?us-ascii?Q?z/VMwepLD9lf7vn8TAjYptYISMgBiSm8rlO4nV3NFatUxpG1mm6WRrRhwizR?=
 =?us-ascii?Q?iKBfNGDaoFQEVhMiEQo8EYE//+jA9rEEAc4GCFDu1cEgx9EvJ6bZ6cVwDoWs?=
 =?us-ascii?Q?9a5mjFbi77z6Rmp0eDM3J8YOJJg+L+MipGQgfuRKPqk9W1uNnFNN6bzBjvrJ?=
 =?us-ascii?Q?EJcxVP7FRvoApBnrVpZKNCkb2Weq4/h2rjEg73OD9M+GMoL6/37MgCw7s3oR?=
 =?us-ascii?Q?By4a+3Q7/WAwHN8zg+gRJ3yONO37YdBlfB7n17DfQdaG82UxpHq7TYW3QtTz?=
 =?us-ascii?Q?9h2tqblGzuU3LfKxELJ5eNmUZD7bkGg50c84GQ2jneF8FdvUO0qBzFeASOVD?=
 =?us-ascii?Q?WK7REPnXoVAwxzcEiMlr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(1800799022);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0iwwBTZAAkvKmohkUEMsSsT0UawwrkZBSvowaZtWo2ioBK2TUOpnpxNvnbui?=
 =?us-ascii?Q?D1Ox0xwk3JFb/ZY49aWU6GeGcIjaZlKl52iy95V85CKAD5C3xZd6P2laEx9k?=
 =?us-ascii?Q?y/rrvvGk/ujIyiT0E3TUFxE/IIaRIOfm303H9jJucIpsvG4Gia8ZxpdkOLpl?=
 =?us-ascii?Q?zizasUNV9kl5qziL5R/AB1anIqBqNwl2aHwjMm18R8nJSsk7mW5jFOimarjG?=
 =?us-ascii?Q?f8xv7WOu8WkrXLkuTCtgEqh6SDAb1CqTrOHMh0Spp9lvIju3Vm6JuXjxuYcx?=
 =?us-ascii?Q?0Zn04yfGzQTI6LZHW0aLAEO8P300AU49OQgrjIeF0lTVY/NBzSKm/XS0ciBu?=
 =?us-ascii?Q?Y4EopzgD7QrIbZ2ccgZ62iZWZUbKQJab7XkbpEytihGgjxXzCCe8GUzX5sJC?=
 =?us-ascii?Q?frJDe2y7ER7gXX2tF1jqUgPokNpC0ULVGmJbmpJYosSGus+LFDNIAZrdhLXd?=
 =?us-ascii?Q?bzINNvvilS1z0AMMPGPckgtiSmoc+ThqHIxAAqwjYN/5ENJgYaPfRSI3hASu?=
 =?us-ascii?Q?0yTMq1uD2G+bXJPiaoOmHBvaj7C6Y0HEGzAx+NUGdtGGCuS59uP81Kg5bRLp?=
 =?us-ascii?Q?SWS/YBHLFOzp96CW6PCcrVVVmBCBWohAMfnofcl7BJbJcNwOS8LDWo24lyDC?=
 =?us-ascii?Q?14J6gPp4OXqf5/D7Q/WQ7FCwrxtYiM4mguewrb6fLNlXAdT5A0MNTnmm6ogK?=
 =?us-ascii?Q?9WsK1BJ84v/nxsPB15bioIXm7qc/SsAsEiS0bN/1XhM/4nkPh3pMymSDD97m?=
 =?us-ascii?Q?9Y3LFceMGHNO+fYYMNvkIvf6cVPsahwsTn/wfopu6ml0J8H0AjcbB3jEPhFW?=
 =?us-ascii?Q?eOCgoWvPx7dChaZvBbRJ8TAnCA63pQfnpbu01vnJRrqAtRpCNnI50sLEtn9s?=
 =?us-ascii?Q?rVvKLV5KD/7Lwz4SoO/Zzxh+x4was4B2Cy5yU+boLUuvauADTbshgpU2gW+J?=
 =?us-ascii?Q?f0yVe/MU1lNkCDCflyY5/KOKT/jI4nIxQPhB73LEFB7idpqMie4dVU21SY3u?=
 =?us-ascii?Q?TaWJLnazJgQmpgVwFXlKUA8QoigzmlBiUW883MJJkrWESa3cpaYI8NP5vOEJ?=
 =?us-ascii?Q?/BY61hQIWx7+HIrOot5ZpEZktLVZElXf2bHqmwuPkTDKm9gacwGk/3lPuIyj?=
 =?us-ascii?Q?vTc+cMYFRnLSs1zp5McT/BSW8yFMxUW5GaQ2stYdsMNI9yqTAwYPTvZtCK6T?=
 =?us-ascii?Q?W5L2fikEs4rfaBGD91EZ+/D0N/rQmY4moqKF/lEXqBymJ9MbxDsie4qAVmQx?=
 =?us-ascii?Q?YI7dITMFqp8+fhGY5T/GCymi0Nmgc7TV7KvaB3iUk1T87s1j6qEIq1CQ5rbH?=
 =?us-ascii?Q?IaM0DTe3KzLx84VKFcP1YTZZ5kQYbHLr5WtkR7dhMGS2oOxMjJGNEkdxETW0?=
 =?us-ascii?Q?XnUZfFQe0T4nNGr/5udwFwiqQ8Nt0jCtRwG5GnbaYcanXtwboVMPMPyz3Ww+?=
 =?us-ascii?Q?dd5pkv1hwwYIpQKSsdCdPxUgKUxYCMlc5MoT0ivGoTZTZOcNwJokSvHOGcSI?=
 =?us-ascii?Q?EcHy7RkLgJRSBmJU8tV5HM0jc3pIVrE4TfaApTlQS4QgI19J3gVUxZIO/zOu?=
 =?us-ascii?Q?6bqyLe4qp+GIVOIIkxbiESOFMfREMqNcKGkju0kw9L6jXHhtodxef89vTmlq?=
 =?us-ascii?Q?mCnPX0Qb5LedNahNWOcKp08QnRc6H0BljtOGjk/NgroOLNxSX5LC1yMds42D?=
 =?us-ascii?Q?BjTaqQV0lDePTDwbKHqAdTnBEjc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b548d25-48d5-46f3-5f12-08dc954820c2
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 18:53:40.1545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TOVGVc8LAeQ7R6QjrvqFfsJabFA2knVyoYYNtNIjLnAyxzgtoKSVe5QT90iYzZIHUC34TNUdIGXMLHB2guBXR2lVRQWaWV0zBpEH+0x9OyWc9s8e+xxoKt20f+kyTYw7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB8070

From: Adam Young <admiyo@os.amperecomputing.com>

This series adds support for the Management Control Transport Protocol (MCTP)
over the Platform Communication Channel (PCC) mechanism.

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

The second patch in the series is the required change from ACPICA
code that will be imported into the Linux kernel when synchronized
with the ACPICA repository. It ahs already merged there and will
be merged in as is.  It is included here so that the patch series
can run and be tested prior to that merge.

Previous Version:
https://lore.kernel.org/20240619200552.119080-1-admiyo@os.amperecomputing.com/

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

Code Review Change not made

- Did not change the module init unload function to use the
  ACPI equivalent as they do not remove all devices prior
  to unload, leading to dangling references and seg faults.

Adam Young (3):
  mctp pcc: Check before sending MCTP PCC response ACK
  mctp pcc: Allow PCC Data Type in MCTP resource.
  mctp pcc: Implement MCTP over PCC Transport

 drivers/acpi/acpica/rsaddr.c |   2 +-
 drivers/mailbox/pcc.c        |   6 +-
 drivers/net/mctp/Kconfig     |  13 ++
 drivers/net/mctp/Makefile    |   1 +
 drivers/net/mctp/mctp-pcc.c  | 343 +++++++++++++++++++++++++++++++++++
 include/acpi/pcc.h           |   1 +
 6 files changed, 364 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.34.1


