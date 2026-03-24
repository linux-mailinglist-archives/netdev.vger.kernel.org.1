Return-Path: <netdev+bounces-271305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD4fAlj+wmlXngQAu9opvQ
	(envelope-from <netdev+bounces-271305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:12:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A7C31CB7C
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10797301FB4E
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CD5359A70;
	Tue, 24 Mar 2026 21:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="XqTBUg1A"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020113.outbound.protection.outlook.com [52.101.193.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344363033F7;
	Tue, 24 Mar 2026 21:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774386770; cv=fail; b=JJ6dQQHOfqMt/MKKNuoF5Grp82iA0PcB1UyNO7xRjux9srdS2U0MbTPg06dInuo8OsOn3CUFWw2TmAq7xoYzzbt7A2kor4Wv1fBqIG2qYZLjDZf7+A+DLFewgISas0iByC3nxXKFBHX3wb7DhCoaE343fzTkcZ+uzod9EpnyyzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774386770; c=relaxed/simple;
	bh=FlDQsutxyI+hQLjWORcb9zDTn0Huf8E8f/ce0J533w0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=G0TwfT4PkMqMwr/T1FT4rZY+2GbU3q/bHoXVYEw4WnAkEj7LxcLcepaLMSsBurMHCQMD9ZJCqltxqRQ4JnkYS70ON+HsAoESfwumcxXwL9KUpGc/6S5PCTgKLiR5VzRU+98EGg0xpk/tG6tWIJTG6Z2b4wWkpBEQ0Vpc0kDHWA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=XqTBUg1A; arc=fail smtp.client-ip=52.101.193.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrTzD50vQWemRvWd4OgbBfz0yEMT9f9adRdP5CtnklP9DpFkirhGyQX8s2FxBop11zVHmCCdI/3Jg/5Dt4UBzR2KUF8OV96qsvmqL+y1eOMAGHe9a23/j6A3QBHyWqW5C8bJkOm9YPmXKQqR9o2kU7QWoSClgI+6JImUBz9O5ZUcVowiaxFr/dWUrDPp2SoGexIgEDZs7mA3NNVphap9Fptsw/ckUTYXx3J7n9EfJNyvW4ZK9TvJ/Am8YfQQ3eZeH8YPctufzAX+3BmL+J5dLReehFxybh7eGTIdR/NGFbTigPT0AD3MwaapM2Cb+rT3SYE1ao22vO/PkPengQkjcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTzw2Ayxtn5mFMTOt9L3b7dNg25BNHiPzgDOfJDBOEw=;
 b=C6DJv8250E/RlkFxZwzn3rL6He33VPMVxetaNdGBJAm141sgc7ss1BUxauB8cbCMTaveZoIZPB142CIcAnbK99z9/czQ1uZnR51yGzgJMFyGVgsyBzpz4UH9eFGgN10nYiDTxPSS+OScn0BGfR0ZFGmQ7dfMUsP7VS8Ja9OgG04EhEXx/FkfMUS6RwcepT5pOVj0rN/iPUJOlImC/yZVpnl0y2eQb0/+djIGijcg5wFltXXBCRpQ3AaZLvtdz2HOVyENQMvKtxr46O1o6PpYAkb/ErsHAhD0i3HE/nhhqXkKkmQecYFSPv59sCYa/eXxDHbpQsh4vcjVm98i3YrdUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTzw2Ayxtn5mFMTOt9L3b7dNg25BNHiPzgDOfJDBOEw=;
 b=XqTBUg1AC6cH6x/kGg2ZKoatBLHZPS+vsBKpxaIwf2F9InTyb1AACpBmEibxAjm9tLW8LbDKMGYLRESMByzpO6S5nndtVF3ET9HdMg0fCYWUlDKki4AN+IhotLnKXIlmfshm0I7LXl1oN7pcbzwRwJEHDWtvLy/Oq+L5RXemaTA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CH3PR01MB8470.prod.exchangelabs.com (2603:10b6:610:1a4::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Tue, 24 Mar 2026 21:12:41 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 21:12:36 +0000
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
Subject: [net-next v35 0/1] MCTP Over PCC Transport
Date: Tue, 24 Mar 2026 17:12:33 -0400
Message-ID: <20260324211235.938599-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5P221CA0146.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:6a::19) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CH3PR01MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e429a89-40cb-4fca-b264-08de89ea12e4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024|55112099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Y7IUhdNbKKzgCQPwJag6ReLWPDA6FUVZTunosS90za5TdGUVuDoIMY7XBquaispwzblX2Wm/ZuIJyXq9yKxGtqfDt4i7dyC/s1aNqIJE1xXCKZpaIVx5KAbxqfNeP/f4JqpYSLmNEVZgRouYypa7FqND38kfm0anKpQCaN1MTNyUpmYDKW4g/9EyfwTWCsBsdF1yw/Mfvz/Fy475afbqDlQGM9lgPzjxbaIYT4FQFE9vH0/UmBB5jXzNAtaufY9Pj2J8WPTl8XghBSV+C4Xb6t6QytythcHn3TXbrV1s2WEMm6kn1DuZAstKcqETCtPVuIU39ju6MqQVaZZteLlZrJ7qvqgvAE2Bbvqbw7xJxqF/o1SHI6+pBDA6gTNaszgFF3fNYGSjGgq1p2sZSHg0Z8jFvboCshbXW0Vb7sqvWsJUTi5nFZTw3OEw+m1o580NZH+g9aSihvnt4yeTqstkCdGlOcHdaF0F+GYvEmroaHQjEug0rmta7XRbkR+F1DxPI3NzCR4Nf5xNzrazKAaHXe+GjlfmjBjAIG3F9hvYAaYTHO0plVKUseEP6Hko+FCsEJvmuADIE5Peto1EIgkTSspW+li08R3A9wLXUNksljuA2UywG5Kf/AjoqG0AdNZ1kYYkiTCB52XWMhtdU6F8Xr+kG40wjE7athUtsbL9TYbJ5+qvx/w7BelNeh6jw1dP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(55112099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tf2gJbeMVRVdFYIxwCoFbHdezhSemdceWMu9qJr5q9RWq/3Pep9fSl3Z0cGx?=
 =?us-ascii?Q?3fZEuotxp9mvRmzTVvql1SXnqo6+P8BmM4DtDv8y9uygIKfiBrXV7pRrKppC?=
 =?us-ascii?Q?vmWc8zvbcHxtTDNZgblZF6RqfTcr8RJjKJAABJCigoiXDxc1kpxvgyU2gB5C?=
 =?us-ascii?Q?jAaABa9Qix1FY1cEn9NuMymS5iW1SdX3XAYgCkP76986VRhUCTQlXlppgJav?=
 =?us-ascii?Q?dRVsrCGj3OaOCXqBwZfd6ZlpWcu74M8MYVWut8iKPwqUBMCNej2G2PSK7YKr?=
 =?us-ascii?Q?9E2Xq/E7k2jMOaY/3v//vLIC+68hGtwpUxTNx0mugiSPaGz89mwDalP3nCIn?=
 =?us-ascii?Q?+QhRIEVMpkRd+JAw/dD8ey0EcEW5lq6GgmC9tVrTMiTgZyUT64lAuGuFhfeb?=
 =?us-ascii?Q?NJL7e4Kuw79bjKE7JxwqAf6Ey+352fSiFe10jKO4H0NmoC0fsWStzQNNgeO8?=
 =?us-ascii?Q?bBQRpCvVY6f6uAE+PuwX/ZL9cYv7Ym1tqC003A/UbXsPl3aXD3OHcvFo1vgx?=
 =?us-ascii?Q?yqwKlIQY9hcGps8gTkGENh9wVnxHc96P4SwYouTejnAwy9pwXjfhaEHpTkOZ?=
 =?us-ascii?Q?wqHQoK/87rrLL0HD0zDlY3pN2xAYZ5gNw0uorH9Jv1/msSrf0YmgM1SHdGJX?=
 =?us-ascii?Q?NZ73/BFeUWyUlhlbYIrU8pMtocI1AzavjAg6jtG3/jWz5jElf2NYKP3ekmOa?=
 =?us-ascii?Q?LUYKroJmGz7cL9JOfnQX5CPdXjObDYRnX67ty8K9OZknlDw9azICmmb15GmQ?=
 =?us-ascii?Q?MKBGHO1p5aSSvL3Yu9aVK2yfMjDGfgAgKTokrn/w8rN90Ng90jR5rvcNP8f+?=
 =?us-ascii?Q?WQ+/ncommWo5M+L1PstMFHzf0GGZdBfgKwfMEzo09ogCd+48bTj6xFpRAiu1?=
 =?us-ascii?Q?sOWcn8Y2Q0HNd2mzJyGwwrrtiNml+Z3vYps4xW0SbAJ6KQlMzY/9tXYNPNpG?=
 =?us-ascii?Q?UNJf5O4MDFplhatsT+EzvoWpf3RVxhjIKVONGJ9SSOx46kJszwZO2O4VankT?=
 =?us-ascii?Q?wJCUISCRG7pjBcqt5n87MEm0NYy1LZepeB4JDLYz8bhPhpUTMS6dvRKFL1Tg?=
 =?us-ascii?Q?94YpZNkOZfGRO5JXn77LK2tuXiXVHJ/U0P+bhiv3hyi//KLIithACt8LxiT3?=
 =?us-ascii?Q?BXa1qFFPMLd3cs9YuXVUVz4GdfvB7GMWHkkgvLzukLRx0hqRPPlU8mfXYWtT?=
 =?us-ascii?Q?Bw13qVERVWup6cOMvX7JCpopafcBl5okVJjuOayaVZn/abJfl+h5P84lRH7o?=
 =?us-ascii?Q?QByIdCOLF8QErog9VoL0tEvj6AzmhqWZlN1IhwkRQ+AXJu+1mmmoNEFnPv4l?=
 =?us-ascii?Q?bnTt8xjEWWJNhlc0QSj9GjwgL2S0zplP5t8DJAea0ZxRwurI32+H4bFOJ8g5?=
 =?us-ascii?Q?qF1kJm4TtCV9/wL024YvWVRHL9nSIgaEx9qDiAp7YkJLipJIN+E/PDvLus7C?=
 =?us-ascii?Q?8Q0w+C5K0bpAmAO8Mja5v2L7+oaBuiH06UQo21TP7GT+GEAhZVw4jbhcTDLW?=
 =?us-ascii?Q?fTFL1nXZjVgLFXWcCm9AmA9uSuYCh/wWs4oAmfW3vHWI4l85hs6GFU73+qoo?=
 =?us-ascii?Q?pvGmgUebhOaedlFSSm8XEzsgp6L+rFCs6/ZK4yw0DAvSaQwKbT9qLdqtdY6O?=
 =?us-ascii?Q?b9vvufzLz1V33yfa8hlAhJe64Gs0yulTbObCxWf++5rvgkUVnE/5DG4uJjyQ?=
 =?us-ascii?Q?prhNaqfoa1lZ1gfWayUYCD+iSlRnX7kArZNlw7EPHrEsX0PSlj6ERa16T2Ni?=
 =?us-ascii?Q?8ddIF6oK4CZZUT7agpgM4oT0lqVL7jR05hf36E3psmz+0+VBSkuy1h4oORAO?=
X-MS-Exchange-AntiSpam-MessageData-1:
	IvT598f98gjPjv8D7u15F6pjFfN49N+rwhGHYAwwCHIcouB+EZmYx9gp
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e429a89-40cb-4fca-b264-08de89ea12e4
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:12:36.7627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7a7ACFvg/bOpHaV8CHR5Cz5YUYRp88mwAFtKiHzLtldWQ0q09DUOe8UpoQ3pJOycWg2BeepByf7WBVJfsfeCgO96qo3CRh0mHnkBO+iLTGG8IFlCELw78/K5nOEyTM3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR01MB8470
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271305-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@os.amperecomputing.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,os.amperecomputing.com:dkim,os.amperecomputing.com:mid]
X-Rspamd-Queue-Id: 05A7C31CB7C
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
https://lore.kernel.org/lkml/20260317224309.645480-1-admiyo@os.amperecomputing.com/

Changes in V35:
- Removed spurious lines from commit
- Added context to commit message that was only in cover pages

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


