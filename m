Return-Path: <netdev+bounces-142916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9289C0B1B
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918DA284C0B
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE39216E02;
	Thu,  7 Nov 2024 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="vLHiF9Ep"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F4B216DE2
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996023; cv=fail; b=RTvK82KZqL/63dXiJtJIB/HyKTb3/r9e+IYEB63qdP/lKGHv24awWG8UDQHq+AAz+ZL5Zx4e6C54Gh/xQy+LR8NW10Vt7ly8krvAQssxHcQmMeBy6Yqj4KuZIc1Cbk30OLLj4dEL77MZo/CHzBiISu20rrF8TVVZT2Bw2cNO9bM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996023; c=relaxed/simple;
	bh=0oAChpgW3vII042RClJKSMgE3sQxD6d6Qps0a4cUpWA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pYzKutE/6iNRQON/yI097i1JRpoMqXPlL9AblhJvdAhsU4lrCpjjBhXsiZ+4AJLHd59cjUy4t5vYfE8WsAx9xVgC0ua9vhzlsci882g77j5l4P5qQEFefTJzr+csHKjEv1ljXhbZeoz/WslTrTuT6/2+ge2wXwqr9428dqglMOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=vLHiF9Ep; arc=fail smtp.client-ip=185.183.29.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 4C3AA48005B;
	Thu,  7 Nov 2024 16:13:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2wRjlsjWDeybJSU60NHjUqIzdShFQbbSXHrvjbpGvMJHlGfpUjfhENK9lo9WepBppxmk0fXiAqsSvDmnvs1qWtAxD9tSz8vW6lXMJepltioEW92kPNKSeHNscL8TScUottOqBwqeLadWXbjddQkV3NGnu4QEtGelMgF/lSOhhkLJ2rpZwTqz6zLs8OWJPtw0U53CuSuhY9ibfG2F3fOaTEzEb8+r8CQKu+0d75x+v2BLjU4qmungibIr1ZNJAY/mtBbpRvGUS+jMFdOa4Ou+5JhdnUeQWwmQHbuZlLCm0S7cFqjRnFp4jKt0ns68gKuBYXeS5mFe4Zmq0cOG1Zhnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toH1Mvv9tuuqHXzOk2X9rBhvLeIMsZyBURmEVJ6gsHI=;
 b=BwMtETdJMXoibjhuT0DIVriCCWaku3ahAVmgnkH0RG4fqfltoc5vO3qvtMCBK8VSmp/k0H+EPK0G3VdNziS3KDt1U3NN76Pf5PvyQbIUG0Hd6KOVDtAahNb9ZWvQ0RW+ryzE+r08+k7uLbJHd0nvGlI5KhcSZOBh0Rs6m+Qjts5I12hPnhRUMCIGilanC/uCd3IXtvfllqZelEE/P4lWfkokWFsI4GIij3eXtj6eT6fYdccOlVzqCocJ8AtzopJU/RIQmDHbQHAkncEoO9N15ll16B295ZaRMvfegyNo0lI1yOqoWiRhubdYiqhDZTTv/81Wuj/PQMpqEKNlLqrWvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toH1Mvv9tuuqHXzOk2X9rBhvLeIMsZyBURmEVJ6gsHI=;
 b=vLHiF9Ep7oLy1qbqZEjk6v6t/it0YO7QIapVNFHOnI/vUbow4g0aOfr5fn505xNrcAKAPJkVpzLa+4huZqQH3Os5K3/Vt0gvutAiDMreH86Jdya0hMQ7v3RkE68CDdc/uGKbQEKZDydz385pXl/d1rr/b8mN7m8qoQO1uCvgwuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AM7PR08MB5493.eurprd08.prod.outlook.com (2603:10a6:20b:102::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 16:13:36 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%6]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 16:13:36 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: Gilad Naaman <gnaaman@drivenets.com>
Subject: [PATCH net-next] Avoid traversing addrconf hash on ifdown
Date: Thu,  7 Nov 2024 16:13:23 +0000
Message-Id: <20241107161323.2921985-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0133.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::8) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AM7PR08MB5493:EE_
X-MS-Office365-Filtering-Correlation-Id: 20647d52-7ce5-47df-14e2-08dcff47228b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IAWyBVG4NVD4n/xIH1X4+CjYgPeTiF49W3wyzP7asMRXNfPX6CZdi0vUj7UY?=
 =?us-ascii?Q?tsMk3+TQsxGuURzbegjC/nk6dBeCFYP46QVzPd8ufgnij3mqci0gcdwUm6Ka?=
 =?us-ascii?Q?MFbN1pKvnSW9eRPV57gsxodKoJzP1w0HVvcknNfrny0aoVkD85lM2JzhdqxA?=
 =?us-ascii?Q?hNc6ZshhVADyC+4WILuDWgYaJ9YcWy8clYiNdDKvqmSdrSQFG4kvArKvhm47?=
 =?us-ascii?Q?KMWIO3cFA5cTNCDEIQ96bK/z59ZJLRnp7z5qyhvMOJhDQX8cmRatpfaGN0wx?=
 =?us-ascii?Q?h/QaDv14LIrGnu9Skmfgep1dK3H0BaPZPQbvgRzzwXIBlMYeJTFBzqImQWBW?=
 =?us-ascii?Q?XWcmBwWyVb4srpXXfeXyANZco2xKBJeQt8qIK14EO44ESvVjelxh7cWUX8YL?=
 =?us-ascii?Q?OHuHKuMWcwJQjRytzqgly4g3TGt38ze8yJxFnW3/nboahZDTd2EXuSLTU7Uc?=
 =?us-ascii?Q?xpzsW2EOxegQKGhYdemPotG/cmIdvbdAPmTyBJpye32v2/pDMzLe9zURCObQ?=
 =?us-ascii?Q?OgcZ2oFdwPpFAxYZYNeuxxVkhiSeRdPdgid/wohfu+s2R6Eqy7torHdtdP4v?=
 =?us-ascii?Q?YszZSIXYuslYoVgv4UZoxfe8NuP+jmzLItoN5KUZs6LNmRrFAZYlmWVhBBxH?=
 =?us-ascii?Q?7PUz82Ixtl59vuNnP6jI4oyTbZlyUADMGQtT3WGBqx7Dfdk1InMklE5gG+XT?=
 =?us-ascii?Q?j8T0nhfnUQvyweNei5ZJ3KbmLkRo9e+IUcUwfac5STswES+Wjf4YV8WhBlZ1?=
 =?us-ascii?Q?JhXd8LAXYGNelaIuRiOshadaT5pC8+0zfF3leMGpdgCPybZdI9j9YYHKjc9E?=
 =?us-ascii?Q?693uFGuLpBQ/3993mwojbjWfslAfGzc5E5oQ2ufvvjvPybcwr3t/f7iN1XUp?=
 =?us-ascii?Q?ANowAbhBXjTomFk13XimEWyJrnSfUyUVKETI5eZfO4Cj3ICA/O1EWpBnqdsw?=
 =?us-ascii?Q?dqLMYNeQSiX8FRieXK8+CDxSxbnZ9sbQPGIQgITIvYZuKBkXO8TtS4gUGB2P?=
 =?us-ascii?Q?4afax7UckgbPSpR9A1MFjLKwz6pOaVM1gxO152z2hJce5q1HDS4+Av3EHUDR?=
 =?us-ascii?Q?bEGYkl1zpg0PmIZZPoHBxWsSlobNavlMWmvO+sF7YquthTa+C3Vxvsb5SJ9v?=
 =?us-ascii?Q?zYuNplBNrP721u9y0zFM5HwdflqpJStkB2KqQf2mZgpdcujZo8IJSL/7A8u8?=
 =?us-ascii?Q?Q5qeoK7nsh4pkq6wGRUG9AFYLu2tN3cHeTAJEoJuH1qFHosH0uO9sRu8EEbA?=
 =?us-ascii?Q?Im+4aG9P/JoaGQtIwpk0d2cpAGL8tEIbdcLRCbi6Uiesk57NcRGzcGUMC6mN?=
 =?us-ascii?Q?v4a7Ynvwg8/IJMXdaN1FA9yzu4MLJls/5G8XEbbEi29BwzI4T3UuOfY0wzUa?=
 =?us-ascii?Q?6+hLi+c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8bh8Qr+H63btgT6j2aXiPYGRqBXK+7K8YGlFKaIJzhNsKiKGYwvRTnrky1WG?=
 =?us-ascii?Q?kEqtBm0iU9k/nNQ1iQUIOP3tjYZe8TSG5pigPgw7hcX7SK5o3PlvLKwoJIsQ?=
 =?us-ascii?Q?N40mVOrK8S6u2GW58SvIRIdN1ynZoKP1qug7SNJxGDcObvPUz0sNslovdB5Y?=
 =?us-ascii?Q?PhL2zosknZkF/dAoBLmXLe4+Oxj1IGlOTWJbMfS181e9+aehZoFYC6K1gezg?=
 =?us-ascii?Q?+W8Vjxhta9Ogv8NEb6FfzVl6nI3teZC0w8w+9fzP8Os1GA8EgPvfubaeDyGK?=
 =?us-ascii?Q?q8dNkVqo1HCLa0KlcBT3SfcVEtKXaZEuJLilA/OwG4uQJ/8DuXxlJ9MRUr7H?=
 =?us-ascii?Q?ub2X58I9URh3TgDK0OnoaU5tOMnqxW6eHk/gmDbaZM6isbgfT5ObTUhl4hpw?=
 =?us-ascii?Q?aFk5G+E/IcGTcrsnTlkwhQnqqtEYYHAvfmvwncHCxyzU+/8NL+54Yd1L1yLn?=
 =?us-ascii?Q?3AAJUefL6+wVEood3M/qfIp9S91kO4BW4/boeHqFDFmzQhJPEaDxaGdjinJl?=
 =?us-ascii?Q?OQWUetVWsCg2HT4VIU9Ie+ifoMR6HrmcDnFYLhN16ySfR5ab6CCWtgjmxFKX?=
 =?us-ascii?Q?SLZaKxWQqVaOxciigBfEhcXsBkGYnOUfDJl8xM52GnJIK2Djb4Em8HXmJ9oi?=
 =?us-ascii?Q?+baN1VxHqL52KSgOdF+lAQ4EU8V2TZdl+XD04eyh3K65jBy42rWw53/Z/3Sq?=
 =?us-ascii?Q?zulrAs24RW1UA0F6irTYzp9Q3QpZutBHj9juF7AuUrA2rPvtQLvTrMZDzot5?=
 =?us-ascii?Q?zF8jg7E7ZNMiG2zu6WBbFAaJcgRYhA6WpRxky40ojOo5a2WAXWDp0RbCDwHg?=
 =?us-ascii?Q?3HPcrLPhrkRe5Ibd2j9GgwPHkjXBrmzAEdsP9DbThRNzhNb4x7F5qE4FSDrd?=
 =?us-ascii?Q?gOWSW6NJi0JTDulJBp/Xi5EV0qfHHXmJ1FjoopafrGC56XLk8KIJs9tIJ426?=
 =?us-ascii?Q?crZtO6bbE0iidE00SfkV3izfPRreEFuBtoHHLh+weu45803rQ6YvExPuYh0v?=
 =?us-ascii?Q?m2WmCKZ/H5yqY+QmRoNjGZbOTdVy86v/OxooueiFodFyFDVTxLjhZCgwYAqN?=
 =?us-ascii?Q?93hgp9jNG2xegrP6UWiWafonGCjxk5BkCXt4kxIqq952eAoDHKlJhAl0EAJO?=
 =?us-ascii?Q?c5ONSOQvBfbwp/ITIc9PaS7JlafZt5yQWS9Yt+cTWVaiYpMuxXwUjoQF0tfA?=
 =?us-ascii?Q?pMejh0XtpK0RPctRK8QiA2Ud4ERbJzDQ20+LnxzhoJuJXwprI+TyC4AEa2SK?=
 =?us-ascii?Q?eEeCcLPdre+C2IYg2XH78m7IDfeYkpflzGWaemYvZTBAdGVn5NSIpKjxpgY4?=
 =?us-ascii?Q?XH/Y9O7kP3TD/gS3Jb3ExS/P+HvLHolzeWroqHLklI+zhsgJ7IEHkzkJ8erH?=
 =?us-ascii?Q?C2MI3OcvMNozI+9wx8KenbjlCM8DHRlBq6NxklWbMQB7B09r+DnEj03Zw7ug?=
 =?us-ascii?Q?WWHrDNzmEoIHrLvZlm2ISm5SV2CKPGgSJV9Zg/yw+QuhieOQQsG+DbM3e8QL?=
 =?us-ascii?Q?oqUSxVDCRQqDodTm/6luK7jNWD5lINbcVsGxzoSeUclFT1BxiUI6YcoCJcG6?=
 =?us-ascii?Q?SXeZgvNqos663XOWC/2IgRxohA9peFXrf/yQMd26?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vDY5QstahgalSXGWXJE7KTZ3nC0YVFl8Q2zZcux9tuhxh4oPYQSkjWUtaX1wvTBZ3/X6dopedHMsWhDjdCIfFjlGtBBPeJX0zr780Wq9/mkdyM6I5K/+NUxOQe0zV6UV7idG/oSSCxSpyhH94M1a9AeXAI3ljo9zrPgq2DDTcqOIxiGZZyw3Jdty6SiSv7/E7pcJTQZPhQAIiKfYMIEq83LbN0JCdVn5VWI6ZsJztjGBN97QywzZDkKWbVRYZ7Ouo/WzbxpctauQxBfTaYdlttop4Iku+BygaZY5RePwAmHv9CFrNww9rArl7Cg06L5EwkTFCzg2LbtyYJyTQHRSDdXXluFdvs4U/+HyV/F9GLbKRLfwc/vXI8zsZbnvMvUu8wa3zE8mmA2vVPjxncRbx+TSWs2XpStHIV6pGgBWWtsUp8L6mkx+MG0gZRMrgU3Zjg3qBfqj+wIdCP+HKKYmRNSR/zJc9nFl9iukluKMur0huKwzELSKLlaaYsw6wiMhYChgVb5FW5nDcdIilrAX80pesvFYiaGWE5c3PC01SHOmEjsVCdaltfuN8MuXHX3ohLmoZrYS+dVrXgmdar5e9hLZL/CWdZ8VUKM+lvmAvqfLlIiHXf+DkSIZhGYTRuzN
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20647d52-7ce5-47df-14e2-08dcff47228b
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 16:13:36.8510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdYa+o8TN4rxC1OvZfvaR/nDdS9bKfNixfozCD7bcsTvGdRi8aZWj0ayXGqBCnYOM4vYxWPq27VEMEsI0or3ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5493
X-MDID: 1730996020-DdzqHK001h8h
X-MDID-O:
 eu1;ams;1730996020;DdzqHK001h8h;<gnaaman@drivenets.com>;489d0494e21146abff88c0d96984588f
X-PPE-TRUSTED: V=1;DIR=OUT;

struct inet6_dev already has a list of addresses owned by the device,
enabling us to traverse this much shorter list, instead of scanning
the entire hash-table.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 net/ipv6/addrconf.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index d0a99710d65d..9c57c993e1ec 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3846,12 +3846,12 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
 {
 	unsigned long event = unregister ? NETDEV_UNREGISTER : NETDEV_DOWN;
 	struct net *net = dev_net(dev);
-	struct inet6_dev *idev;
 	struct inet6_ifaddr *ifa;
 	LIST_HEAD(tmp_addr_list);
+	struct inet6_dev *idev;
 	bool keep_addr = false;
 	bool was_ready;
-	int state, i;
+	int state;
 
 	ASSERT_RTNL();
 
@@ -3890,28 +3890,24 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
 	}
 
 	/* Step 2: clear hash table */
-	for (i = 0; i < IN6_ADDR_HSIZE; i++) {
-		struct hlist_head *h = &net->ipv6.inet6_addr_lst[i];
+	read_lock_bh(&idev->lock);
+	spin_lock_bh(&net->ipv6.addrconf_hash_lock);
 
-		spin_lock_bh(&net->ipv6.addrconf_hash_lock);
-restart:
-		hlist_for_each_entry_rcu(ifa, h, addr_lst) {
-			if (ifa->idev == idev) {
-				addrconf_del_dad_work(ifa);
-				/* combined flag + permanent flag decide if
-				 * address is retained on a down event
-				 */
-				if (!keep_addr ||
-				    !(ifa->flags & IFA_F_PERMANENT) ||
-				    addr_is_local(&ifa->addr)) {
-					hlist_del_init_rcu(&ifa->addr_lst);
-					goto restart;
-				}
-			}
+	list_for_each_entry(ifa, &idev->addr_list, if_list) {
+		addrconf_del_dad_work(ifa);
+		/* combined flag + permanent flag decide if
+		 * address is retained on a down event
+		 */
+		if (!keep_addr ||
+		    !(ifa->flags & IFA_F_PERMANENT) ||
+		    addr_is_local(&ifa->addr)) {
+			hlist_del_init_rcu(&ifa->addr_lst);
 		}
-		spin_unlock_bh(&net->ipv6.addrconf_hash_lock);
 	}
 
+	spin_unlock_bh(&net->ipv6.addrconf_hash_lock);
+	read_unlock_bh(&idev->lock);
+
 	write_lock_bh(&idev->lock);
 
 	addrconf_del_rs_timer(idev);
-- 
2.34.1


