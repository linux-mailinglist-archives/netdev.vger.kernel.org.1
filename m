Return-Path: <netdev+bounces-289143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANtfMxpZC2oCGAUAu9opvQ
	(envelope-from <netdev+bounces-289143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:23:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E52A7572318
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AD03306E2C2
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1C638C410;
	Mon, 18 May 2026 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="GEHlapHu"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.135.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7BB385506;
	Mon, 18 May 2026 18:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.135.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779128043; cv=fail; b=BMpToaYzT6x3L/2KW3570Xgsntj/UJ8dafCk/rg3u9Lh4JUp5DRKIHTuzCbVTYJeS2F8RoBDf2/rGIV6VvE4BZM0yULQgcDbcxsiQuCEmvqFl4fkVzv2+b6rba4EBE1EssQo27soGdhexaXwWg71zl3mHKF77oDAgR1oSu6PDE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779128043; c=relaxed/simple;
	bh=BbRHg3KyWn+dGU6fMrufnwJcutFEh33NpQuKbgVRFsM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fx3E3xz0ZMHXrr8AWRoX7/s8A0mXxzWSa6+U+nCDm22G/c5nMfzlKmTqS0yZi3+EWhfDS/tX9IY9LDC+2o6W4EBeWCVzILDZRF+IpfnGjstgfx5hGTT6naffxVaq+3Dji6OAApYmAxZwGmo0IYYbnosFfaIBBhZer8Coa2Pe8vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=GEHlapHu; arc=fail smtp.client-ip=216.71.135.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=ces1;
  t=1779128042; x=1810664042;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=BbRHg3KyWn+dGU6fMrufnwJcutFEh33NpQuKbgVRFsM=;
  b=GEHlapHujTxsKF6pR47paSOTr49oO06HlffAiS1Sc9RrlMiG/2z8V/Kh
   0Ecv3luVZTTQAG7ume25+Z9qYLQ+Z12x9d+yFLq242FOVEM6VwYB4wHz0
   p1mOVRbZLy8KjSLr8v4dVWVKzoqtuoWxA2K2M8JjGG4ARs8g4D0039cM+
   A=;
X-CSE-ConnectionGUID: ngh4GVcQRJefVjhzFEUZ1w==
X-CSE-MsgGUID: 2rk4hqdmTv2WzNzZNtKyqg==
X-Talos-CUID: 9a23:53xzmGGYgmAT1tjxqmJh+05INf4uS0f/wXnuIU+qJ0tUeuSKHAo=
X-Talos-MUID: 9a23:wByWYAsMiXHyWwS+U82n3ithaMdx76GSFhoyg7MUie+YFj1pNGLI
Received: from mail-canadaeastazon11020092.outbound.protection.outlook.com (HELO YQZPR01CU011.outbound.protection.outlook.com) ([52.101.191.92])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 14:13:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGILTCa+kezdHyi1/p33dZ3VwyEMAFz+lLtC4ufxepW3mTlvrRDfEM4HZ96bT2+DFeeTAjbt+Ya+R/oGWtGqf1+Sv/cu8x+ZPz9DDQRqOOkXwxtBiKM6aLEosxTmATf2H11F9jpFFnQlrc0rSvVGIdVMXWMrzX459OCBXkF2rsxgvEGHQy03ZCWQ+ANiG8l9/evyR2Rzh5xny4GerMLxmZ4ixvjdg4kFXOJwWDMSYbSykFpGb56ReETKWpf6b0Kgz3bXR0oK5Ml/pDpOxRDbZNFa9AvTHQQ7/PYnZXvSKLehhJYErx8Tq6TftqB31XT4xzz3HzNAoq7o6gIb/8Hzsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4MncORYi7+Age1iwh5b1gxt+RAxLOXRiLSvFGvzJMI=;
 b=LAityz0gtJBrcLF8eVNlWh+KSobxYP1XZ4M0XPHNbEak49Jyy4cU4IqzbFYqK6ddgaVwKMbX1Iohcd67NyVeg/jq43S3X8hfcmUMxSPJpVpEUT+lUro4ZUzdU6/5NKTyeE0BjdEoJkCSGZaGqY/vo9Onhn/cz9XkpZMUGJOHDn0Eq9Qgbb8Aqt4NB0asJlfUJqpiO7HyoPW6vf3lPFmv4D8GScVE3VoYNk9pb6y8NCq1NdZ1vyZvDHwms9ubYoVBx3CjI8npJhGFTnINea51oKt8f9nwJlc71XiAjjcbA/HhlL2zMSTh7i2JECX4eB4UV8e+YxyP30OVrfadR8wXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by QB1PPF4A6194682.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c08::238) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.11; Mon, 18 May
 2026 18:13:49 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ec62:77d8:42d1:10fa]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ec62:77d8:42d1:10fa%6]) with mapi id 15.21.0048.013; Mon, 18 May 2026
 18:13:49 +0000
From: Martin Karsten <mkarsten@uwaterloo.ca>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Joe Damato <joe@dama.to>,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	=?UTF-8?q?Bj=F6rn=20T=F6pel?= <bjorn@kernel.org>,
	Frederik Deweerdt <fdeweerdt@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] net: napi: Skip last poll when arming gro timer in busy poll
Date: Mon, 18 May 2026 14:13:32 -0400
Message-ID: <20260518181337.886459-1-mkarsten@uwaterloo.ca>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::28) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|QB1PPF4A6194682:EE_
X-MS-Office365-Filtering-Correlation-Id: f37c9b5e-8a1e-4881-371d-08deb509356f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|786006|1800799024|11063799003|56012099003|3023799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	b+6kENbBQFadmH19I/SpBh7koN6bH5KYWWl5a+cIQL9RJ3EVo0yy30LOevSt0PtMwxuAtcmf60H+CAo6EL+Y/cmvgg2DxbY7nN+8o9QBMUDNJvLXndM42YzFlspU8Yejq2Acb0WNiRkD8rTLsVLQNzE0+ECEs3J2LhGXpMVUpU4M01fYaKCuwUw5fh4S48z3gXqH9doqLpJhCSa0CORB0UYvUYYC2A6+Kim0qFpyyJSjHtn0gGfhRvrsOXpWNRi4rcUe0sqQpu5iDh9e6JH2RqFvWG7eC3p5rwDSPZXTIxtFEy4FR32CWJSWy4V+kTQdjyneyI4Ygz9xTQ0wM2X8qcr8qpq0oeGuR1to60/RRqiWPI1HYUrYYrBYXgtFyQDxJqgxm7tivb5Xi/ic6uxmki6V1Owuyg7XuES09uGM0FsyhMPnDhU2IC0VmabqUniEEeHy15PrTSAwyjsdYxhwYBhWpUfH7hSO4Ht7VNo4AWkkD+y0/XgYhQjEvr8KaX3oDOiKGFZTg7JHRs13mrtgjxFmioqNqstjtIHDbRcwxQ7rSpPHOh9nblT2l0wqDDTFlYwypN66uCwubSdgUCU3hnVxcLO/JQtRLMZZc7302FcBpdbyQyfUcmcK9H0+xUAPQ9JgvnjODhTYgbeZoZ5QpRrsQgQm5ySpUQT/eM/cAcoGS0kOz6P/XqGWfXZYGxKfEyKSr5H77g6BFDugSrShew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(786006)(1800799024)(11063799003)(56012099003)(3023799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f/MhwJwwNsJ9daXI3iEqW77y80zHrp70gRbXWvYVg3rbKZE/Bjv9KEPkPDK6?=
 =?us-ascii?Q?ZyA+AKfQdmPHMnKnlS14bu5m36RbFqCQaUk1ygyfFVu/SRtc+umDL541lBhv?=
 =?us-ascii?Q?TEQi/ChVvEYoj5rdVU2fKaTI2DGlBZCigGWlU+m5+MQyPKMlHO/5KnyTH73l?=
 =?us-ascii?Q?5rda3ObILK3X+VyXnTUsyCFnKtA6zPX/AkbzNmynNf5O5bAKx7+LggdR53TJ?=
 =?us-ascii?Q?dE81oXMfXT4LBqAwFAK71MbyzFOT+wqlSSm/ibgZ3M4DptkbMtAlEV1gKrhg?=
 =?us-ascii?Q?WgQyE2Th2Au5rRrRtQ7hpLMVajvQDWc0K9ESyk7sgrcuX93pt/6wDoI5HRWb?=
 =?us-ascii?Q?ToeA4RKKTZ/8SczltO6NcxZ5VptdF5t44/D2hqFepuiJoWCuT7YVjZ/9iu/k?=
 =?us-ascii?Q?mjqmXsCMEKMNy/I/usxYE8kSR1xwhAznAer1skgiCmMFywtrOR+7Vc3WiOAK?=
 =?us-ascii?Q?2Wf8CuuncWGf+B9ufBiiGS5zp94GRBsPsW42WeaJvJCh2SjISZ+XFtvdLwE0?=
 =?us-ascii?Q?amUUlhxqjjMm04TohdejbZTcijtOsy2FQJ+dRpRjx/ZU7593M8EocrvR/2LO?=
 =?us-ascii?Q?1FK3+sJS3R2SZYZfBrvwm7dD01LIT8KkV2mTWjGLqup1lNNO8aXAXtGeQxzh?=
 =?us-ascii?Q?gbqaptFIZmmpXtFhATQSv4zKeFd6UMUng8o3a5T0wQ8+HwiLFapmecxWNz8Y?=
 =?us-ascii?Q?CzVlfLG6u+LkEKVTKdEYapuEfQd+Oqiq09ObSf7ns1MKrV8VZ4QiFO9Sz5N4?=
 =?us-ascii?Q?qJj4q2dT2I6Peu/ihzWrO1kY8yWhAjmJZQBRu87S8GWyno+Xy6RY6u1MyHv2?=
 =?us-ascii?Q?H4IN7GDKHGeziuOV8VzxF8o/bY+1GXo5MLQ/QFQfWA4NbeculTn+TR0cfr2k?=
 =?us-ascii?Q?2J9PSnq8buNPYXMS9pYUo284lv8dUJdMMgIHVRdRHnPIYURPqJPUHE7hqm5V?=
 =?us-ascii?Q?5rUg6RlF+JMhqmcY7cN5I3xjC7huKCOcsXDER5M0wJXlf2FaQOjWLrUta0p4?=
 =?us-ascii?Q?ZmdlcM1oJwMkCz3LlrkyBAsUuLhkpKPSaYt+LAYJulPoBPffoRByCaTTVHO/?=
 =?us-ascii?Q?+O7YgYZlJ9u+Lsa2AT7qDpwdAnxaUHyNVew+uy6RGfdxSJjK5xpOlWGu1BZK?=
 =?us-ascii?Q?dOA4pHq9ESqBphXhIZUe7n3ZPFFcVtvZgi8qpoa8PopkhKiGVyORzYvBb0Va?=
 =?us-ascii?Q?0N01iyEi8qoW96e7X8c/YdxMLN2priBv8jVQN04TXFQGKJ0u+YhRKRkK/X8w?=
 =?us-ascii?Q?DTK5HHZVJYPZwkjQPoVXEwcqWAYvgkD+o02VHuYLWNSuGFnKxqdlyb6VTmX8?=
 =?us-ascii?Q?cdedmkNJhH6Y0QmHOB2jTqNIr89we701MWb6Sif49fqWGC0z2+GvlN1Xe1Y8?=
 =?us-ascii?Q?4Jwkf5FB05tIx0qqrZ3wbm3HtTZjw6m09U3ozMr0PiP5Wqho3UBqs/FtY2/z?=
 =?us-ascii?Q?fW+/2gkxgOPIGEYzHOZCXJnp1/8BWSL9uGdHDogdghO0MY/5fH+m33Tg3RBn?=
 =?us-ascii?Q?ML0rougCP45Jhz67e7HukkqgAx8MW9TahPvtFVrLJ1cKo70pfR6cD6Hrk/28?=
 =?us-ascii?Q?gZgww3s9Nlg9lgQCW95Kwzsg5xk/P/5fbM25kNT4zd3wZW5wrs1XxhqBOiXB?=
 =?us-ascii?Q?U8rx8J2Wc49LinibpEQX44iyzR3StTNpU7PJZDlQQo5IO8cio1M1rVdsUXyN?=
 =?us-ascii?Q?AcBZsBV03797S7Ch8EICUnwUYMi0JQlS62zjdTs71YW+scE1ixG2gAkPHyYA?=
 =?us-ascii?Q?O/kHkVmnZg=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	hQHFSNpdFvtQ7rWlrxqcBMXDD0v+asMVtf9AFJdo4OzyWowgpcIGDpWSz5d94K1d/Nu4j+CQNWnC0onXnYDGOJLNnZiFI/Q+w31vjyNzq2xacfCVpworH5php6GzvfK4ogOh8oV3wtnRKhYnBUmqVobFAWc2CxOXmc8+yLV1J+lizg7aANgpNYYJvy2ZAJYuEQ94yhb3Xn2jB3KwV48H6Zqx564i6zefcN4B/a3cTmg+/uY8YTNX79ufuk8IGIRRT+XgFmjnwu2vcbQ9QTZ3qyHB7mvJxhZGJVxnbM0MJiKcqH9/+YDcOvXg/3N5wfjbe2p/Cu0vzHkxPKGr3ujXVA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eyMfPSOBbg3jQ9+ETlT8T8B/oKRyRID5ekc+ozj2dXw+tnIds+lDivQBFCYyQhyLtRsczVOGm5zkKI11vNQmzEW7VINbM33PA7OBHjhR4o0QA/TvwCKs9hVrCUVDS/gN4DyUQxMGDi9DQ+w1R9R/mk37B1ZG+PcyXsb3alOWFX80fLEjN27aYqdtFC6vNfmhXUNmQskbds8eFd/fb14TuuOL2ywA2VRr8KvX9Cw+j2eTAxG+yEFrow9qTCVRpTVElA4FwN1Jqy4sRjscXBmd7xLUhesWAM1H/8zL/sLaWP/t3QyEzb2T1mXgoZHRPQix8jezu+LY4jReCLgH0EyQly0u6uBljunfi/pk5iriSR3UzbI2rhm2pKWRlDCxHVgA5wlYXyRPlmTg05yFALBbyTPADfpsChRy27YUoGfCRPiPZyMFCN3nRs0uEqpm5LDQelL1QfLIu3GUcdY4QAjtzG+B2oWCYLPHQCFsz1TpECT7bWlwiWCUGVGwKGmnjswJ0LxiK+X51VjlhBi88EHmN1WlLn4zXGq/cJRYfRg9ahfbOzQZ2/Y3SmQ/fGLVrZHUTDUfUXbcYqLQmxEbVXNKHPUnAMffzQtIAvyKEBJrsyMgIKKx/UlgtEVKzkytYGJ+
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: f37c9b5e-8a1e-4881-371d-08deb509356f
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:13:49.0550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1i0ip2l1hxI3P1VF6UHcxIkLIejzUgdADo+8CSpTg0SZVaBzOXOxXdIRMe4btk+eSfFbcl/YwJO7FMCLlwS/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PPF4A6194682
X-Spamd-Result: default: False [2.54 / 15.00];
	CC_EXCESS_QP(1.20)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uwaterloo.ca,none];
	R_DKIM_ALLOW(-0.20)[uwaterloo.ca:s=ces1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-289143-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkarsten@uwaterloo.ca,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uwaterloo.ca:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: E52A7572318
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Skip the extra call to napi->poll(), if the gro timer is armed at the
end of busy polling. This removes the need for having a separate
__busy_poll_stop() routine and its code is moved directly into the
relevant places in busy_poll_stop(). Remove obsolete comment about
ndo_busy_poll_stop().

This is a follow-up to commit 58e2330bd455 ("net: napi: Avoid gro timer
misfiring at end of busypoll"), which has deferred arming the gro timer
to the end of __busy_poll_stop() to eliminate a race condition between
a short timer and long poll that could leave the queue stuck with
interrupts disabled and no timer armed.

Co-developed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
Changes since v2 [1]:
- Fix patch formatting problems.
- Leave STATE_PREFER_BUSY_POLL bit set when timer is armed.
  Don't want interrupts anyway until timer clears STATE_PREFER_BUSY_POLL.

Changes since RFC [2]:
- Sending only the cleanup/improvement patch to net-next.
- Expand commit message to summarize original issue.
- Streamline control flow.
- Improve comments.

[1] https://lore.kernel.org/all/f0ecdde3-de16-47ba-b795-fe0042114e96@uwaterloo.c/
[2] https://lore.kernel.org/all/20260428175134.1197036-4-dtatulea@nvidia.com/
---
 net/core/dev.c | 63 ++++++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 35 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 267cf3854395..a7b8f9a3588a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6862,22 +6862,6 @@ static void skb_defer_free_flush(void)
 
 #if defined(CONFIG_NET_RX_BUSY_POLL)
 
-static void __busy_poll_stop(struct napi_struct *napi, unsigned long timeout)
-{
-	if (!timeout) {
-		gro_normal_list(&napi->gro);
-		__napi_schedule(napi);
-		return;
-	}
-
-	/* Flush too old packets. If HZ < 1000, flush all packets */
-	gro_flush_normal(&napi->gro, HZ >= 1000);
-
-	clear_bit(NAPI_STATE_SCHED, &napi->state);
-	hrtimer_start(&napi->timer, ns_to_ktime(timeout),
-		      HRTIMER_MODE_REL_PINNED);
-}
-
 enum {
 	NAPI_F_PREFER_BUSY_POLL	= 1,
 	NAPI_F_END_ON_RESCHED	= 2,
@@ -6893,8 +6877,8 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 	/* Busy polling means there is a high chance device driver hard irq
 	 * could not grab NAPI_STATE_SCHED, and that NAPI_STATE_MISSED was
 	 * set in napi_schedule_prep().
-	 * Since we are about to call napi->poll() once more, we can safely
-	 * clear NAPI_STATE_MISSED.
+	 * Since we either call napi->poll() once more or start the timer,
+	 * we can safely clear NAPI_STATE_MISSED.
 	 *
 	 * Note: x86 could use a single "lock and ..." instruction
 	 * to perform these two clear_bit()
@@ -6907,27 +6891,36 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 
 	if (flags & NAPI_F_PREFER_BUSY_POLL) {
 		napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
-		if (napi->defer_hard_irqs_count) {
-			/* A short enough gro flush timeout and long enough
-			 * poll can result in timer firing too early.
-			 * Timer will be armed later if necessary.
-			 */
+		if (napi->defer_hard_irqs_count)
 			timeout = napi_get_gro_flush_timeout(napi);
+	}
+	if (timeout) {
+		netpoll_poll_unlock(have_poll_lock);
+
+		/* Drain aged GRO packets before clearing SCHED since the NAPI
+		 * won't run again until after the timer fires. When HZ < 1000,
+		 * GRO age comparison is too coarse, so flush everything.
+		 */
+		gro_flush_normal(&napi->gro, HZ >= 1000);
+
+		clear_bit(NAPI_STATE_SCHED, &napi->state);
+		hrtimer_start(&napi->timer, ns_to_ktime(timeout),
+			      HRTIMER_MODE_REL_PINNED);
+	} else {
+		/* All we really want here is to re-enable device interrupts. */
+		rc = napi->poll(napi, budget);
+		/* We can't gro_normal_list() here, because napi->poll() might
+		 * have rearmed the napi (napi_complete_done()) in which case
+		 * it could already be running on another CPU.
+		 */
+		trace_napi_poll(napi, rc, budget);
+		netpoll_poll_unlock(have_poll_lock);
+		if (rc == budget) {
+			gro_normal_list(&napi->gro);
+			__napi_schedule(napi);
 		}
 	}
 
-	/* All we really want here is to re-enable device interrupts.
-	 * Ideally, a new ndo_busy_poll_stop() could avoid another round.
-	 */
-	rc = napi->poll(napi, budget);
-	/* We can't gro_normal_list() here, because napi->poll() might have
-	 * rearmed the napi (napi_complete_done()) in which case it could
-	 * already be running on another CPU.
-	 */
-	trace_napi_poll(napi, rc, budget);
-	netpoll_poll_unlock(have_poll_lock);
-	if (rc == budget)
-		__busy_poll_stop(napi, timeout);
 	bpf_net_ctx_clear(bpf_net_ctx);
 	local_bh_enable();
 }

base-commit: 627ac78f2741e2ebd2225e2e953b6964a8a9182f
-- 
2.54.0


