Return-Path: <netdev+bounces-168938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00065A4196B
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 10:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8213A55E7
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 09:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2F424501D;
	Mon, 24 Feb 2025 09:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stackit.cloud header.i=@stackit.cloud header.b="dCzXDQEq";
	dkim=pass (2048-bit key) header.d=stackit.cloud header.i=@stackit.cloud header.b="dCzXDQEq"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012006.outbound.protection.outlook.com [52.101.71.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B89E802;
	Mon, 24 Feb 2025 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.6
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740390281; cv=fail; b=DLn5OodXxz8s63fKfY1GC9yWP0DATdwrGw266vAQ7Qb1tQxk1y7enXx2jG1A53gZiCNlQZQX3FyQ+h6P6Bm4WiKP4IqYFNJa5SVF0Bx1gNkU9pHiU3otjv/rok4ZBltA07B24kIRlBRjOxxrwT41lwGjDAnqvyOSWUi9mFB3jfo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740390281; c=relaxed/simple;
	bh=3uWoRh3CePrHsFepIFzqIVp7vCnP24C4nncemBZwujE=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=qMdB7sOg+sIWIbC/FjWRFKseX8sQSrbBu7B2229r4hPpPwNumhgBrhdFCn190BTAkrWhYgSxUS92wu8srZQUXVFj6N48JpPok6dQ6vIEhiCgsR7d6cqC2+LNvg2hyUFQUtoLi4I/ELhZY47a2xc+bVsrmcDrIZSCi6+jgmzVWVY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=stackit.cloud; spf=pass smtp.mailfrom=stackit.cloud; dkim=pass (2048-bit key) header.d=stackit.cloud header.i=@stackit.cloud header.b=dCzXDQEq; dkim=pass (2048-bit key) header.d=stackit.cloud header.i=@stackit.cloud header.b=dCzXDQEq; arc=fail smtp.client-ip=52.101.71.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=stackit.cloud
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stackit.cloud
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=SWg5FOC06YlMf/iDAijB5YDix9tTDZJUMeH3S4vvOMOoQxw6V7kt/MJutmED5LrL4MHetsPrj16eRUGZuuQnHfY17eEU826WX077bGSfAK2sucbRgQ1U/j6WPCZJAl8o7WZoDnr8rSdjhUKHnuLw9VwDd1CnNbdGdKTUTA3/x1TI8QvzrzbykD4AUz4Z7kidYmm84eCxs4dvm51qKGWu3IfAQRhGNWNyWkYe3rQ+78CKfpHvy9Bx79gFh2Q7a5KwJX+LSbTC4dfiCaz0PrAM4js9n8PMuUyLxjF1wy1cBcea50+wjFkSg+eoQBiwo5HLBfzJcLxDNdctZo1DaWCjUQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdC3avYE+xGFp1C75fcu606aqHB6pIGXPhWWpt4kRc4=;
 b=DWzcZky9GyXxXNR8Gp51ZYR7x2ywPTlVtxLTpzMNl5sR7PRbKVK/eFqfeNdgm5/58Jl564cH05HxGoxw+WyZT/RKmperUQJ6a3sFWVYIcdlcx+6nDXvmITnR9BjKb9s25Xvn0+e9xht6vr5ZzQXyprnnZGXJHKCLqo3w++0ifhtCv+EubsHEneDs0Jgoo6+vgJ5X0fiAsnwOZ6uMLVRo2ebemiL0SECOidkwjKIK1bIktzFONLxSUvKmgf0yZihzjC9WKaBtCxXmrpXGU09IfMAbuLC/IUvKyOqdCy0USsoncI4akX6zN3jO1F0QcaR0bfhwQi090QRVqpG2dgfWrg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 52.169.0.179) smtp.rcpttodomain=davemloft.net smtp.mailfrom=stackit.cloud;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=stackit.cloud;
 dkim=pass (signature was verified) header.d=stackit.cloud; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=stackit.cloud]
 dkim=[1,1,header.d=stackit.cloud] dmarc=[1,1,header.from=stackit.cloud])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stackit.cloud;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdC3avYE+xGFp1C75fcu606aqHB6pIGXPhWWpt4kRc4=;
 b=dCzXDQEqS8R5FBndkulHDeWuPvDMfKExk6Zs2sIOzetDW4p6XLDaOPkMYuYi8v/RNTT6nNDSOvDM1RMLNR+9SkJtEKGpjVKckWdBesbRXO2GE3u0muikWM0kCzdzBA4WJBlIDIYYOXAoqbAzgmbXAT7rIvd2lVqYEkwkSoQzbE1tUU14VFbTUC/3Y8OjGwseNwB5WBknhUMincNnSZQoHghulxFmAGA97e+4PCmI9I5/pttM4qODOm7xVJdvL+z0Vy5j65lq9YcMnNvUEuvX8m8KdHvu3oU06GPsPrMkyjsvS4CE2hmBUAwA16TIg8vbLSDhNZYlAK0YVipbGzPLiQ==
Received: from DB8PR06CA0018.eurprd06.prod.outlook.com (2603:10a6:10:100::31)
 by AM7PR10MB3827.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 09:44:35 +0000
Received: from DB1PEPF000509F6.eurprd02.prod.outlook.com
 (2603:10a6:10:100:cafe::d1) by DB8PR06CA0018.outlook.office365.com
 (2603:10a6:10:100::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Mon,
 24 Feb 2025 09:44:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.169.0.179)
 smtp.mailfrom=stackit.cloud; dkim=pass (signature was verified)
 header.d=stackit.cloud;dmarc=pass action=none header.from=stackit.cloud;
Received-SPF: Fail (protection.outlook.com: domain of stackit.cloud does not
 designate 52.169.0.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.169.0.179; helo=eu2.smtp.exclaimer.net;
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 DB1PEPF000509F6.mail.protection.outlook.com (10.167.242.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 09:44:33 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (104.47.51.173)
	 by eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
	 ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
	 tlscipher=TLS_DIFFIEHELLMAN_WITH_AES256_NONE); Mon, 24 Feb 2025 09:44:34
	 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 10398113
X-ExclaimerImprintLatency: 4240893
X-ExclaimerImprintAction: fd54158017e14b95ba7304132a56f35a
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXu/9ctn43o8F3zakW+AtVYofcUy23n/FDi3+Qfvw4pdHqQY0XzheRsILpnALkj95Pp6+Rza1aEcN2QAJHWF++V9x0OtzICo7XxQ5B9tyRYYsFR/Yp5IGMNTAC+gipl/PjJx7GiZ84nBQNGeaDscg1GiwJjvcLnvH+RAQPrfxlYauTdeSyNNND+7rgB0odHnN5ZJrwBAHicBhiI8eJCM8yyiexf79wlkFphaXj7oOak8eX8Il+7Dw8ZYsVWx4JARO4sgahgfSxLhXBshqzLS6emHCSc1N788pPN+AXWPJDCIxA+NSIUhU+rQ3b2gcjIF1BAQZnB21m6CAKacbfJvnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdC3avYE+xGFp1C75fcu606aqHB6pIGXPhWWpt4kRc4=;
 b=xJ2bwvyyU2nPRp8txZL8CvPIIOTixxBkX9adbKNZnHxyEs9gFlzeLfgAWtWJHNGdoCFn5vpl6elzlIERF2tlbqQMPQd9mv1TgqkPrzEubhsYX/Jo7NS8t+ikpS30BgwOVzyy8sy3sbC+iatzkO7qpksA/EH1OT3UnZ/szVqnqpDZRDxfOxgdsvt5Kw/h6W5yoobfRgj0kk8RRgmLQfna7v96x+LHfd0Qg1OIcRgZbq/p9hxhugjdUnW2mcZ6MyhHUD7XMomzop1HpsSodC95f7F0lTt+/rUj3v2ZufG1pPhpDK0OL5lfCH8sCcKY3xpCqZubMck93vyHpv3mX6g3Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=stackit.cloud; dmarc=pass action=none
 header.from=stackit.cloud; dkim=pass header.d=stackit.cloud; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stackit.cloud;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdC3avYE+xGFp1C75fcu606aqHB6pIGXPhWWpt4kRc4=;
 b=dCzXDQEqS8R5FBndkulHDeWuPvDMfKExk6Zs2sIOzetDW4p6XLDaOPkMYuYi8v/RNTT6nNDSOvDM1RMLNR+9SkJtEKGpjVKckWdBesbRXO2GE3u0muikWM0kCzdzBA4WJBlIDIYYOXAoqbAzgmbXAT7rIvd2lVqYEkwkSoQzbE1tUU14VFbTUC/3Y8OjGwseNwB5WBknhUMincNnSZQoHghulxFmAGA97e+4PCmI9I5/pttM4qODOm7xVJdvL+z0Vy5j65lq9YcMnNvUEuvX8m8KdHvu3oU06GPsPrMkyjsvS4CE2hmBUAwA16TIg8vbLSDhNZYlAK0YVipbGzPLiQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=stackit.cloud;
Received: from DB4PR10MB6917.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ff::16)
 by GVXPR10MB8727.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Mon, 24 Feb
 2025 09:44:29 +0000
Received: from DB4PR10MB6917.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b865:87a6:68fa:764e]) by DB4PR10MB6917.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b865:87a6:68fa:764e%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 09:44:29 +0000
Date: Mon, 24 Feb 2025 10:44:27 +0100
From: Felix Huettner <felix.huettner@stackit.cloud>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonas Gottlieb <jonas.gottlieb@stackit.cloud>
Subject: [PATCH net-next] Add OVN to `rtnetlink.h`
Message-ID: <Z7w_e7cfA3xmHDa6@SIT-SDELAP4051.int.lidl.net>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonas Gottlieb <jonas.gottlieb@stackit.cloud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-please-dont-add-a-signature: thanks
X-ClientProxiedBy: FR3P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::14) To DB4PR10MB6917.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:3ff::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB4PR10MB6917:EE_|GVXPR10MB8727:EE_|DB1PEPF000509F6:EE_|AM7PR10MB3827:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d9bd34a-10a3-44ed-8d0f-08dd54b7d863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?48fET16fus++7Rg9gzVJteTo0n1mqvmLJj9+H66vKa/oBlC5UmcmaRVNZLCy?=
 =?us-ascii?Q?p8qnmJ74/knm6axyMvpoKDo8GMi4xH5VH/RO1JkQFb2UIDHtu6HnhBn6FAQE?=
 =?us-ascii?Q?M+ojEH4W9vCtpPD2j0MSctfh7XlC81VMhrosWjcKqXN0FNKaVM6H/wQAgqxs?=
 =?us-ascii?Q?yfKNcgugs4Uzoo5cAcK5EE9zRQVnI1cANkSNOi0yzpCmt9R0M2Fksw+k0sb9?=
 =?us-ascii?Q?84aHLIPs0PiFerk9af8mJqDP0/AjOX71OcqJHU2bscsEgIwQR9XK4V56f7jh?=
 =?us-ascii?Q?senbSKdBFBSIQWK5s7dmQvbKsdRtvX9x8f8gFCNsK2k1J38EqAdjG5ITC6yr?=
 =?us-ascii?Q?x2KE3MJDybepvQqJjzPe55Q8S5R/8dfybzFFL/P7IRo0G3VOudLAweWpP+yy?=
 =?us-ascii?Q?hzks14JGxK9mkakZJludQO8DsOFkq6noPJJGd7esP5hmaEq5SaHqtlwVniV+?=
 =?us-ascii?Q?ECXGdoEC/vmgc70sYsxO65lBJQn4uyfOyd9I/UJE1h1dC3Ajzpbaf4J7vvO3?=
 =?us-ascii?Q?rDuw3JjVymvwyUSHEm5KlDWrQSkWXIvnQ3N8z3IIfbisFbl/QZXSDNcmA64s?=
 =?us-ascii?Q?zCEHIZApWINkz4zF+dFW3fQx/48EDcJlk1YsqW5kBM9DkQ7QYkMTkNTZmqL5?=
 =?us-ascii?Q?r4tesZZ34WeGvbHIyDyFTC0d2D/9W3ArJmQe4hNMY21cycj62IC0ulsCweUS?=
 =?us-ascii?Q?HRt79krgEC4lgOc9MFoWrn3bwplQkm3R/rw5/SD6B91oE6kJSSgkpKBV9N02?=
 =?us-ascii?Q?powUWwSv/0goyh6dCcddOyv0bwF6WB13sG31+Uhc2SAMXEBa5XbJDy8a11BF?=
 =?us-ascii?Q?zsl7Biz6U8iZ1b7VOfOC3Cf1ICeVyneEC4adm6wGvbd++Uwj9ewqk5TbJUfs?=
 =?us-ascii?Q?JlpP9x/N+i8q16adFENt72YV/UZ20jt16p3tJzTRMCJJPVp2rpa8YDdVee66?=
 =?us-ascii?Q?mUyH3QiqhJRmY1Ta4YkQ/YbkFENEqdfVIidsMe9qjK3ruKChkG3CPMoTbqaW?=
 =?us-ascii?Q?g4oWxiGVEuazRtu7ATwN4VxNZcxVXRcPU7FZ5l0RBgzwUp2EPONOJwVrbE73?=
 =?us-ascii?Q?U3KpZ0xEIIkRIkdiL3je6v6ebEZsikOnjC8Ld8LPISJEnAbN4b0PqlsOae4F?=
 =?us-ascii?Q?M50Hub2yz+Nrd9SWTAWQG0+/wO/70FIympWFyGLyUOrqx515zkx8lVL/bR34?=
 =?us-ascii?Q?Z0wpoyJs6fqrfZ5+/PQZqVAokWgjsenkeiHLZejSRY26PjAZk6ONJ/CBSHeh?=
 =?us-ascii?Q?OOHiM7M4anQNKI67iCKzYAErm/6lf0NXS8yyVXsN2UPMFQhtLOUXXDbZE49U?=
 =?us-ascii?Q?ZfgB5FGEXrPbDxBhYMOx3YnUVyDrplQZgvGli56cEVACStsL8MaPnIsHDZX3?=
 =?us-ascii?Q?VpdtMty0zRNASJEXFfnwYd0xDT3q?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR10MB6917.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8727
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F6.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ccb6272e-b3c4-4ffb-a57c-08dd54b7d59a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|14060799003|36860700013|35042699022|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n71+mlWtzbk64fnkacEJC3EFoC4Ta66CLES2/s2oOrMO93fV2P/8+pY8Fq7j?=
 =?us-ascii?Q?+OkJfjxKG11Lb8nK0wGntlL+j4z362u1b8DQzH3Khatog5ydizS0aXlhrRDX?=
 =?us-ascii?Q?1+oRD8rRsBtjxNhy1FXlz+ez/vCO+VxcW8FfyWZBVk8QuVcA72FXZ6WTDP7y?=
 =?us-ascii?Q?J89TL3cyfhW+7iMIXy+gb08Qv/Fg94ZfpCbBgNEaQTr7o253Sq8e70dSoO4y?=
 =?us-ascii?Q?DK0RRtyWJcmzSsdjvZaMrMlRe7FxxDPyXJc2s0uTyudi1RUV9lrmBvkIl2yr?=
 =?us-ascii?Q?iuw/1/e5VPZ+SrlOxqw5lDowwcvo0WAYdIbVchcMKFCyDvAj13qSx4IR9e7y?=
 =?us-ascii?Q?exJsjOhWLCAQL2Ci1Hc8y6eMtFq4+CIkD6CvUhdSwUGrUPw5Q8R5gYpjzLbU?=
 =?us-ascii?Q?DXkMXAH3vBNTVFZi+dpY04rq3I77v4EJfEAL9pxYGsIVVdhl1RXCoqhS/Bpn?=
 =?us-ascii?Q?VKAT7djTvCHq/YXMxlj8+keYTlOhXhzfZdXq5z9VzHKH3pGlO2Q3AzaOzOh/?=
 =?us-ascii?Q?fw1zrmkAOHB7UeAo8xPywNy1xWBfKlZeGVU5p3zq+HwzNRCfu40j1y52rXp1?=
 =?us-ascii?Q?wsdNoYGgM4C7t6d84JUnHJNQ/wo6B/fr0SWDTGVeXRQXnkEc1RtMrSzKEe0E?=
 =?us-ascii?Q?07DBSCi/nCGIGpgCglActmPrc9KCERP+yz5oL8Il5Veqkp0JZmgW7v7A8ioy?=
 =?us-ascii?Q?39TK7FE0yo8SeJY7rj8qzPZlDvY08HPEMSjwmZuI6DPGoMI2Uc2n19GXdwkv?=
 =?us-ascii?Q?BmfA4yluQWKjQJ7HjJ8QOivCSnnXahbGgdCH8oOt9qaq0WEGLwl8ew8dCUX0?=
 =?us-ascii?Q?id4lrVKv/CX9LpKmUFuXzsb21uqSciGmU1IX2v6bpQnjGbJsQ+kBUDKf7/F1?=
 =?us-ascii?Q?jqCXeD8c63N/8r479Ahe9A9PrVf3rbMw1HWUGkRfpigezB4TEVxc5zXbmo4N?=
 =?us-ascii?Q?MWj+0+IZT8DokxnhZQv2iQqgte5Dt8uVtOvPzNgK0U2yCCU7+nImZiBTwl7n?=
 =?us-ascii?Q?xvLU6NCnhDr4JhnBafzwT2kHBKTlX/CF7mM6kaClmS8F0jeIpw24+qtndGKM?=
 =?us-ascii?Q?s95S8LwahoDOHXm4LdxChZGbQ85yWRk5GsgGiuD9rXevZs9eNXQ6HbMRJPDw?=
 =?us-ascii?Q?4xim670fs7XP+mDfYBMK3kJe44wNJh3MyoC58BBqz7JK1RdElJSYtKrZ01Pt?=
 =?us-ascii?Q?kF2jU/zVLxRusD5fTsCttPe8+vUGPgvRqdFBd6eEmlfHQKqBmqwqjZXil0UO?=
 =?us-ascii?Q?ddQY51/4EIMO4GC8rJWeORlQXBTuBjZzJHWQZAKrulCwgewP0wKNpt+qqrsB?=
 =?us-ascii?Q?+0DqtiKyu7lTbs0C+MrP9/L2WtQxEuUpUBaBsD2A9t85Ztxxnw25fuluhK06?=
 =?us-ascii?Q?GZT9gixLarzlnZbSjIU7b7owbjH2L7/E5Lz5LvCWGHFjLjjiSy7VAaeUtbGH?=
 =?us-ascii?Q?+JgL9zt4Hpu9iAyuB603ZfX0Q3IyPmo15wziC4Ik2ewVdfff+pqyvjgzM9zX?=
 =?us-ascii?Q?P8IomWfGGDNHPCw=3D?=
X-Forefront-Antispam-Report:
	CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(14060799003)(36860700013)(35042699022)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: stackit.cloud
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 09:44:33.3723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9bd34a-10a3-44ed-8d0f-08dd54b7d863
X-MS-Exchange-CrossTenant-Id: d04f4717-5a6e-4b98-b3f9-6918e0385f4c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d04f4717-5a6e-4b98-b3f9-6918e0385f4c;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F6.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3827

From: Jonas Gottlieb <jonas.gottlieb@stackit.cloud>

- The Open Virtual Network (OVN) routing netlink handler uses ID 84
- Will also add to `/etc/iproute2/rt_protos` once this is accepted
- For more information: https://github.com/ovn-org/ovn

Signed-off-by: Jonas Gottlieb <jonas.gottlieb@stackit.cloud>
---
 include/uapi/linux/rtnetlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index 66c3903d29cf..dab9493c791b 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -307,6 +307,7 @@ enum {
 #define RTPROT_MROUTED		17	/* Multicast daemon */
 #define RTPROT_KEEPALIVED	18	/* Keepalived daemon */
 #define RTPROT_BABEL		42	/* Babel daemon */
+#define RTPROT_OVN		84	/* OVN daemon */
 #define RTPROT_OPENR		99	/* Open Routing (Open/R) Routes */
 #define RTPROT_BGP		186	/* BGP Routes */
 #define RTPROT_ISIS		187	/* ISIS Routes */

base-commit: e13b6da7045f997e1a5a5efd61d40e63c4fc20e8
-- 
2.48.1


