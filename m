Return-Path: <netdev+bounces-268761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFfKORLZuWlHOgIAu9opvQ
	(envelope-from <netdev+bounces-268761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:43:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 518ED2B3292
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3A283069AD2
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 22:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831AB3E5ED6;
	Tue, 17 Mar 2026 22:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="jc56QDjI"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022109.outbound.protection.outlook.com [40.107.209.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925F43E51F7;
	Tue, 17 Mar 2026 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773787402; cv=fail; b=VNvpD7BFONglr6Va5dBuMe3CFazf39dSqh3/VBro0Yv+x1xwokiuN3OiumUeATqKXpiXyKictQrevk0vojKll6zXDF0+PwXKtILqN82zYiSh0wbQrr57fub6rh4Rzi0RCMivM22l+xIXU9Wn86dZIxHMyNbMNwm3pTbobcYD34A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773787402; c=relaxed/simple;
	bh=FEjZ/bAtueniuOYAd6Hw4BcsEXJOWE1M9Sopo85luFM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rihA36426V85uD5hnJn7wbhXll1RChdsbhqSLR1LfOGA32RkvloSceIkUujZOso7wV8As0acKhQbhuDniAbaGsmkvrbKglK9BseY5iPsx0x2FTz512X8XHeXHqXdAnQgtg4pzCXKsr/FtIADADYXet/JaK+E0DqZyuqzGyoWxTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=jc56QDjI; arc=fail smtp.client-ip=40.107.209.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4Bmpu58zN0iRRZV7HRlhxEwMCw/3n5mY+H5N+NBMp6UC36HpjVaswQpuw9IkDsFzs93CXIGf3yq37YfasQfBaUowPtnNBG9FqMZ/8FOcOqKYOrLgZlu8bHmuOpUT/FktgExdzfKbK/aOtNw8wlrjD+SENGCd2/dIIuB5kmaULYzwPU0yMZ//bu0tIa4gjlIt51OQjepe5s7fwgRl2ZWPVCKi228qTXFDQLCrMEzb0SdUD4JC93o3+rYPP/GS9jXRL6i+jYvTpKjN/9yNEwB/6BgIzRkuSixRUkCQL2c+130hqUtVICadRQFiE7A/Srz3sPkDFSa+xxN31URpXki4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrRvzMSVHZC6NE6DJSnae8mRuSrO48w0Q3hdcxk/U24=;
 b=I3M5+NtI7J8X9Cu9cJFJLJ++JmENsdIkqHJlOAKs1MITd6oZSzx55mWpg1plJePk0Pq6d+KNRdEAomk7QPkH5pNB48FytQkwYYlgx+xpfVnKb8YdhF8q5iLSAjkeLNzcnmi0P+Pbtqq28Y1SbmeXoEV+n2Z/bdasT0CTMkKm05BNVw+hoKLUHw8OSgEVUEg+07pDWuRSSSc6tU7pKdWtHBipi4+Kk2sHqhZreNa28Swi8+fONroyzwQWZTK0uuy1WfubkMghlKQBLBMoZ4TE9M1zCa3M+5Ph8zA+r5VjGKAMzj18h2YjY+3vShip82ThhpndceyEmjNT3MIou0Gqkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrRvzMSVHZC6NE6DJSnae8mRuSrO48w0Q3hdcxk/U24=;
 b=jc56QDjIfuXK/h/SBcLm0VaJVI011Y4f1zY0VM1NeBG0m1CJP3qv80o57oNWdVLae7ZPZvt5SQL6j9pGRv4FSiAgpdwTHsF6RXbAnIBpVov6xc7NZYXQpgvYyGGydGEbrClAUtyIP3DkrO8MmHrus82VFyY/5V/f7EGrfIbAb78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 BL3PR01MB7193.prod.exchangelabs.com (2603:10b6:208:344::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Tue, 17 Mar 2026 22:43:17 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 22:43:16 +0000
From: Adam Young <admiyo@os.amperecomputing.com>
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
Subject: [net-next v34 0/1] MCTP Over PCC Transport
Date: Tue, 17 Mar 2026 18:43:07 -0400
Message-ID: <20260317224309.645480-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0040.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::17) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|BL3PR01MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: b10731f9-2fa3-4982-f764-08de847693d6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|10070799003|1800799024|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	eHVCazXl5+Dxwrnk2OCupljzCMzfhtBLAWR1YWiHdrqAJo4Uvaft6holgOHh2fb8KMM+jivB0nhKiLBN66dSMjWIUeBfonq9N+PXDjhtO3Eaw9a8lGXbfzqZb839PDmUos5E4Z+A/pFz78cGDFfF2WpKclWax8vRVD8HCbye1xl6TflEsJh11n+j5beEFLmAD0lY+Ass8zceRySG7saVnLttG4iUq0sCTbOzF19wbZml/4V+kSQWADRoY/2ZdDnBKh3qa9yLRZwbsTCF/QpOmCDVuMGT8hCQS9QfHcnIqDd1rbhOAi16CUqGatboedGcSVrLR8SUHV49HkEjNitWH9ZQ7B6fN6s0Kco/kmBBFmEw51GIuEY6Hb3BvGfgQBA1GTd8b/zi+xLvRZ8jEkl24mZVUIr6iOd54nCHNwoNvUbpkiVsmREPtuSD7AwBxgUhMOfO/BdVwTelMqHFd2I4Y4eSyeuqDenEr5LW0i/BgmfCRhPE6RGLTyMi4Ef9ZcAQ/GJRTps7u5SUqJpNzZ108rXwX+foNAPJeWiXiESrBTZgjfGqaPDA7DaM3UIho6ISyO+F0J2grm9fx+B7ydC6JTEJB920udprvO5PxTOb/iSVtd6jKnY0HawRbEossIu9wiURvybXYV8lDvS2XSAXTN7YIyBuYz7X0UzL+310OUAQoX98AlUvkLoDWXYEgJZ2tgK7PaRWJSw6+XZjuWukqBVYiGKrUVEhi3iJGL/OJco=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(10070799003)(1800799024)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SgdmRFr44SDjMzcrfvAtoy+faO0PcCGDl/b0QzMZ3iHZ39dCZtyjeXUtcDpD?=
 =?us-ascii?Q?dJCdI5BoYQxA44kVIoS9zFtdd4FwL5zdqfgYJar7xsERTcyhz6DvB3atnPsH?=
 =?us-ascii?Q?4y2k4WhEW+RoVskW3jDgjDpFX5bAqUkQ288shb88IiN9n+5188/Hd6lhAbr0?=
 =?us-ascii?Q?JT0BYEZo5BFoWVe/cm3Rv4n+FTgD9n0TBhcqB7dAxuv3UaJ6LNH+UP4cDmcV?=
 =?us-ascii?Q?BDYRcWQL/7z8BBTWGreQOQIXEIOJ1miQz54aM44CVROkZ5xyinFVfWX4BExm?=
 =?us-ascii?Q?eqhrBZdbGdlGPgGImi24jNgZXZKA6bh/dVQRT0+E4yrS5dUlzPvLKG6EllSB?=
 =?us-ascii?Q?/TIphKPshBNf7Ol/DQtnCz9dB27KsxLOqAyY8PbJxaIZhpCoyH6SyarSNgey?=
 =?us-ascii?Q?aHHo6/xZOijG/Eks1BH/wOJ7SjSycvRpVLCfW1kajs9GAySD9t95kLOFfBzf?=
 =?us-ascii?Q?IsjBX9Cbk1hVDYqbxjeNv3IhxNVq+hDnkZuUlnpOkj/sCX5vKvEffzBECtws?=
 =?us-ascii?Q?QmKHEQV7PVT2g3xRt/PZLhRlzZjo3eC7ce6KLDVYyzvB/Uk5pqRoSh4qhCO0?=
 =?us-ascii?Q?g6zAbsMFqZvIc7SVuqwMGKbjv6NBbfVpsuTBpQMXFlpHmNWfYmW7wypN+VFb?=
 =?us-ascii?Q?n4BNTqiaBZgsL68i7f1WDyjBVihvIl7vZIqUo/ZVKPgWdbePjt3vTmUFLWRz?=
 =?us-ascii?Q?NpfEtn5KY4v1UX4WlBjAShhKzbYhSVL1SbWQPGOTD4dGfA9WkcpgFgRwAbjf?=
 =?us-ascii?Q?x4Vrtb7H0zOc1NUBFzD8cZp0dA/VEa27MAB9mXgfAR5A1Gir5rqa+mWiz3qM?=
 =?us-ascii?Q?W6Tf79bIfs8YOU55S6lE+Oev4hhX09nEyM4Lld7PUuLzD7j5fGWRCxETjQBl?=
 =?us-ascii?Q?unEcYRZwRpv1Gp0eaf+MWIK8iMlxLeLfBBjOjOdZqMxAXrt0sSyoBJG2kwDw?=
 =?us-ascii?Q?ifbClv/dUu5Rf2VoF85lgAQWYwAyyMy2pcikoDrYpFSAznzqTC1gpDG5AI5y?=
 =?us-ascii?Q?LGxtQACpqzX0MKcGNZfcCFnGYMpkoA6SnJJaid3NNDSFmshODpaZn5CJOnZj?=
 =?us-ascii?Q?SyYRoUpLD6i2koiOz1prEK5gVKXmeqahAbCidh3NKBAQdzrpSS6MyxBQ5omB?=
 =?us-ascii?Q?GuNE63HJB4TAzMoh2GkaIJw7+uTy+SvZjEVJpJJn75AWi5EDDxq0Ddlx2qQH?=
 =?us-ascii?Q?vnbQC1ZX8JdAUTFxMrqBJIStKkxHQz00FB1bdADmKGpKDjI6c2xV4y0tnh9S?=
 =?us-ascii?Q?B2QKJVBdw/Ws5x3pmXdHs1xYPLcrbggDO6lOsNqvcr8DNjXupdQOUMlcCczw?=
 =?us-ascii?Q?t81d0oK+SFkUa7Er4Okllthu1FVQTmWNSZeQVP8y7iYzn/YQMun3DWxICiNa?=
 =?us-ascii?Q?M+oSe5btcPfbm4TwXIYRAQP07CUJqQVJ3tEMRapVdoKkOWTF/LO25zx72loi?=
 =?us-ascii?Q?/vvvZudadY014bg9zMtWceBHKN78U2BwP5r7GqnGMECWI+qZvXTOvFGLpGIr?=
 =?us-ascii?Q?6i42kbXpK23PFMZJ088GNdV2nRyqwBG55cy5yhmHDyB61hqJ3mLaE5XqMEVZ?=
 =?us-ascii?Q?8IoqUEW06sgsVSHNtAe0thLWIpHJQGbD9tdlwBu4dqkKRbN8bkXPfYZEscNR?=
 =?us-ascii?Q?D5GR1rT5qk5UUWHi43naKRNAyb4pH5nJGgccP5JLu7CjXostyssnlGeBRM7V?=
 =?us-ascii?Q?dBJ/DM8GjMSuaPW7rXit4grXZ8/DDKR6HqVjvIGd89nKuz57yibenHX2+JWU?=
 =?us-ascii?Q?XimSy7bzilxu7OfuPxpOkSHBg5W+8/KaUstMnJbr1nsdL0llF/lJDXRo0yP6?=
X-MS-Exchange-AntiSpam-MessageData-1:
	/P7tWzk9e83jrdeaimnKab1nqgJXrskJ3UiWWAaKI+C3WVjpaDK+JBET
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10731f9-2fa3-4982-f764-08de847693d6
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 22:43:15.7119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVmpRREXDOggs6YsLkwJ+I+WZYndABHqcu4HAnFdSPahWI3KJ9AgrokatX2W/0DjeQNiohlOz7r527GTJAq1A02C4LIQrRQtKydQ5zwX6aegUTfVVgqOWogHcw+UTd3Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7193
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268761-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@os.amperecomputing.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uefi.org:url]
X-Rspamd-Queue-Id: 518ED2B3292
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch adds support for the
Management Component Transport Protocol (MCTP)
over the Platform Communication Channel (PCC) mechanism.

I have included a cover letter to maintain continuity with the
previous set of patches that were submitted in series.

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/\
DSP0292_1.0.0WIP50.pdf

MCTP defines a communication model intended to facilitate communication
between Management controllers and other management controllers, and
between Management controllers and management devices.

PCC is a mechanism for communication between components within the
Platform. It is a composed of shared memory regions, interrupt registers,
and status registers.

The MCTP over PCC driver makes use of two PCC channels. For sending
messages, it uses a Type 3 channel, and for receiving messages it uses
the paired Type 4 channel.  The device and corresponding channels are
specified via ACPI.

MCTP is a general purpose  protocol so it would  be impossible to
enumerate all the use cases, but some of the ones that are most topical
are attestation and RAS support.  There are a handful of protocols built
on top of MCTP, to include PLDM and SPDM, both specified by the DMTF.

https://www.dmtf.org/sites/default/files/standards/documents/DSP0240_1.0.0.pdf
https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.3.0.pd

SPDM entails various usages, including device identity collection, device
authentication, measurement collection, and device secure session
establishment.

PLDM is more likely to be used for hardware support: temperature, voltage,
or fan sensor control.

At least two companies have devices that can make use of the mechanism.
One is Ampere Computing, my employer.

The mechanism it uses is called Platform Communication Channels is part of
the ACPI spec:
https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html

Since it is a socket interface, the system administrator also has the
ability to ignore an MCTP link that they do not want to enable. This link
would be visible to the end user, but would not be usable.

If MCTP support is disabled in the Kernel, this driver would also be disabled.

PCC is based on a shared buffer and a set of I/O mapped memory locations
that the Spec calls registers.  This mechanism exists regardless of the
existence of the driver. Thus, if the user has the ability to map these
physical location to virtual locations, they have the ability to drive the
hardware.  Thus, there is a security aspect to this mechanism that extends
beyond the responsibilities of the operating system.

If the hardware does not expose the PCC in the ACPI table, this device
will never be enabled. Thus it is only an issue on hard that does support
PCC. In that case, it is up to the remote controller to sanitize
communication; MCTP will be exposed as a socket interface, and userland
can send any crafted packet it wants. It would thus also be incumbent on
the hardware manufacturer to allow the end user to disable MCTP over PCC
communication if they did not want to expose it.

A Previous version of this patch series had a pre-requisite patch that
allows the PCC Mailbox to managed the PCC shared buffer.  That patch has
been reverted. Instead, the functionality was moved to helper functions
which are explicitly called by the MCTP driver.

Testing of the patch without hardware support can be done using a patched Qemu
and helper program.  The Qemu code can be pulled from
https://github.com/AmpereComputing/qemu-ampere-staging/tree/pcc
And the support code from
https://github.com/AmpereComputing/pccd

THe virtual machine can be run on ARM64 Hardware with the following command line:

../qemu/build/qemu-system-aarch64 \
        -machine virt \
        -enable-kvm \
        #additional parameters as you need for your machine

A running virtual machine with a Kernel with the applied patch can then be tested
using the mctp-client command line utility found here:
https://github.com/CodeConstruct/mctp/blob/main/src/mctp-client.c

To test run the following script:

EID=50
LINKID=2

modprobe -q mctp-pcc

PREFIX=mctppcc

LINK_STATUS=`mctp link | awk '/mctppcc/ {print $11}'`

if [ $LINK_STATUS = "down" ]
then
        mctp route add 50 via $PREFIX$LINKID
        mctp address add 15 dev $PREFIX$LINKID
        mctp link set $PREFIX$LINKID up
fi

test_mctp(){
	REQ_TYPE=$2
	REQ_DATA=$3
	TEST_NAME=$1
	EXPECTED_RESPONSE=$4

        # unccoment to debug
	echo mctp-client eid $EID type spdm data $REQ_DATA
	RESPONSE=$( mctp-client eid $EID type spdm data $REQ_DATA | tail -1 )

	if [ "$RESPONSE" = "$EXPECTED_RESPONSE" ]
	then
		echo -n ok
	else
		echo not ok
		echo EXPECT=:$EXPECTED_RESPONSE:
		echo ACTUAL=:$RESPONSE:
	fi
	echo  " - " $TEST_NAME
}

test_mctp "SPDM GET Version" "05" "0x10 0x84 0x00 0x00" "10 04 00 00 00 01 00 12"
test_mctp "SPDM GET CAPABILITES" "05" "0x12 0xe1 0x00 0x00 0x00 0x00 0x00 0x00 0xc6 0xf7 0x02 0x08 0x00 0x12 0x00 0x00 0x00 0x12 0x00 0x00"  "12 61 00 00 00 16 00 00 16 00 0E 00 C8 00 00 00 00 12 00 00"

Previous Version:
https://lore.kernel.org/lkml/20260316035626.363698-1-admiyo@os.amperecomputing.com/

Changes in V34:
- when checking size of the rx message, make sure it is not negative
- add size of the PCC header to skb bytes

Changes in V33:
-  Removed Helper functions in mailbox/pcc.c.
-  Used static helper function for writing to buffer
-  Inlined code to read from buffer
-  Corrected Copyright date
-  Moved networks stats to the end of prepare_tx
-  pull PCC header in MCTP sk_buff on error so not duplicated

Changed in V32:
- removed unused outbox variable in mctp_pcc_tx_done
- formatted mailbox/pcc.c kernel-docs IAW script

Changed in V31:
- Use predefined Header structure for pcc Extended buffers
- Rebased on top of changes for PCC to handle ACK interrupt and tx_complete
- Fixed formatting in mctp_pcc
- use netdev specific log function
- removed condition around dev_consume_skb_any(skb);
- initialized ndev->hard_header_len with sizeof PCC header
- removed spurious mctp_pcc_ndev = netdev_priv(ndev);
- Rebased on 6.19

Changed in V30:
- rebased on revert of mailbox/pcc.c code
- Explicit patch for dealing with PCC Type 3 ACK Interrupts
- PCC buffer management moved to helper functions
- PCC helper functions are explicitly called from Network Driver
- Removal of sk_buff queues
-

Changed in V29:
- Added a callback function for the mailbox API to allocate the rx_buffer
- The PCC mailbox to uses the Mailbox API callback instead of the PCC specific one
- The MCTP-PCC driver uses the Mailbox API callback instead of the PCC specific one
- Code review fixes for language in comments
- Removed PCC specific callback

Changes in V28:
- ndo open and ndo start create and free channels
- Max MTU is set in create
- Reverse XMass tree rules complied with
- Driver no longer has any auto-cleanup on registration functions
- Tested with KASAN

Changes in V27:
- Stop and restart packet Queues to deal with a full ring buffer
- drop the 'i' from the middle of the link name
- restore the allocation and freeing of the channel to the driver add/remove functions
  leaving only the queue draining in the ndo stop function

Changes in V26:
-  Remove the addition net-device spinlock and use the spinlock already present in skb lists
-  Use temporary variables to check for success finding the skb in the lists
-  Remove comment that is no longer relevant

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
 drivers/net/mctp/mctp-pcc.c | 366 ++++++++++++++++++++++++++++++++++++
 4 files changed, 385 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0


