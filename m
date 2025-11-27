Return-Path: <netdev+bounces-242265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C713C8E327
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E0D834C275
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE40D32ED28;
	Thu, 27 Nov 2025 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SS0e0bi6"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011004.outbound.protection.outlook.com [40.107.130.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AE832E6BC
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764245385; cv=fail; b=ESRBFnvj8acJtEMJcr0ScEQO1TDyKlMUcz87aJwn3bFdtqVaffXBF20XEDfuLGzGUwLK4LMuxKllV1g3llj4ruAD4/iFNIWoZg91iWFP+Mxk0K/QgEPi0R3B1MhBuHf9t+1cXWOUocF78US5ifSsbcKPq+lTBMNV7xK5ddlSduc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764245385; c=relaxed/simple;
	bh=qYPEDydZ+cMamTBVcPNhJEc5a/RXEH9bEvA0Zl+KNwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VLSqhlRfkpD2ZU73VADodXu+0EIQteX+2STLcL0DJ+HjsZmuc+QMYwSo78KaulumXhaWUqkYX6kkDPCl4c6OzN53Fhmkh4ypRacPI0k+F0oX+sI36Gu6Aiy2VztI8vNglnm0QIMN77HTa8VIpqUOob3H0T7CE/T2042MokOifUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SS0e0bi6; arc=fail smtp.client-ip=40.107.130.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVLnqC8VGJnz5f8Hl0bAg06U9p1tLM8uhJJtdTRH0wJGkuJwkgqt7aWa3CcsDFp/j6gAFBs1MNKpdQPyULaLvcsQM0j8QN1txMbNTytBqe5twT5pICuzIPijogLZtaKm7yVlhkRojBe0N23l7eCqUC3KtKFjhXMG6z9/3L7CUC/XohHXTZr8bF5gA1ET6sXRV3uht91A6JptyZ2TaoX/tviz4g1e4L09kU0Ms39dbNMLp2J44oyAtjxHRkIiFAJf/TmJYdY4UEw1u7G1/ycalSrpHYsQUaN8bR8os0o2jdY1RwrqDTnMKJHidOh8XFKHJ62kUeR720UEEeAUtjR4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nonvd0raRvQ1lmZhUqFsiSHj5C0/Mka1oqBC5TpPrrw=;
 b=QRZCtZ4/edhDT52zroMlJkxkQAQJL72kI4fKbhdST4q3Q5PkQC/+VQd5Stnl7CLWOTE20YA59rtNGX10qqxseKMS5wlgYO/LbkdchV+nX1ZHV1VJB/aHCz8gsk3QudEXOQKiJjnh0YHWJJ/jr/Pl0qQ//UzLZBvD8ycFrKhFHsbPHHNjwbrJ3Atv7Eq4fFT3CwC20c/FPNPNeJ6bRCWeoUmCeP7ffnd7YvLdsqalrNRjhXorUgVGQTy0FLRfEg/pVUGMoDgCkM2u0HUKuBBDGHg8QJVrOk2o2Qo++EaMIGNYZZURXrYiMg6/pLgklGzpbgn2wG2Lzn7lBaDy1CGzAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nonvd0raRvQ1lmZhUqFsiSHj5C0/Mka1oqBC5TpPrrw=;
 b=SS0e0bi6JKYgeGrjI2S+ENtiKZ7K81goAjwF0C7nXq1lrgkrGVMXuz/YAGjCDuUjdFG99wzxuuxfl1ZNLo67yS6Iqb2iSvTZq7R0BGVOFatmoznSOsItWgMJC3bHFYnKT3ySwum1h8099YaB9v3CS6/e22fvmgYkvKszds56h9kc336e/3UGHNnIkQHBOlRJVr0LQjMMTWrY17Q/vqhR8Ytxf3MlQB1TFyRrxsxaTdyhoc3beiAseYnq0KpGSgWGMqpmwtU7ptpIBqSZOBkDHFpw19XRRfehhZG3TdSX1jYJkNnvQHuCqcgm/vOMa4BrXcID2Q9QZgXEsHprzoT7Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI0PR04MB11844.eurprd04.prod.outlook.com (2603:10a6:800:2eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 12:09:31 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 12:09:31 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Subject: [PATCH net-next 11/15] net: dsa: tag_rtl8_4: use the dsa_xmit_port_mask() helper
Date: Thu, 27 Nov 2025 14:08:58 +0200
Message-ID: <20251127120902.292555-12-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251127120902.292555-1-vladimir.oltean@nxp.com>
References: <20251127120902.292555-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0056.eurprd03.prod.outlook.com
 (2603:10a6:803:118::45) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI0PR04MB11844:EE_
X-MS-Office365-Filtering-Correlation-Id: 020778ae-3031-44c7-83c4-08de2dadd145
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|10070799003|19092799006|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVlZYjUzNWczYVVpaCtrK1VxRWZmUVZEa3hkejZ2ZGR3bmhFdG9qSDhZSzNt?=
 =?utf-8?B?WmhPSWp3YThUSml2eXRQVHh5Y3dkOUk1cXMvNmZGVDA3U0V3Q2JQYlZqK2Rz?=
 =?utf-8?B?THh0UkdxVklRemxuaEtWUDY2RWtwQzlXLzE4R2pWTDlPRHVFN0xpN1FxcUtK?=
 =?utf-8?B?SzZDNDE4NGFmeXljRWhQblBONmEyOUl4dFVkV3lwZSswN2RVQnJadzRrOFlL?=
 =?utf-8?B?WDZXZS9wc2RueFp1VkZmM2NnUUhXcmM5VXhPdkM4czlsV3FoSU0rSk1wZWNw?=
 =?utf-8?B?VXV4M2xYbWh1OE9OeSs3Q3AyZU9JYmIweU9iSXEvTGtKcGhIa3dJMWhMUVVJ?=
 =?utf-8?B?NzdaUHNyeVliQnRaTmJPYVhvWEduZW1BMmtKaGtvMzIrcUw5U2ZYVHdQOWVN?=
 =?utf-8?B?OXMycVEwendTMHAwQ1hzenYvb2NLTDE3dEtjV3E5cktJaExadENSdGJnUGRW?=
 =?utf-8?B?UUlmVG5NUk9jQ3l5d3pMRFZ2RERoUUIwS2IrdmduUDlaeENyUzF4MUpvOS96?=
 =?utf-8?B?azNuZEZNVlRVcllDeTRQbkVXc1VERTNiZXdMMytvdnQwbHhiS3VTb0lIQjBi?=
 =?utf-8?B?SU5RNGxuNW9kQmtOamZYR2J3b2NJUmhjRGxoSEwvR1VDdEFYdVk0elNKV3hr?=
 =?utf-8?B?L2hHWDBYWmJhSkpKeEdMTkRNdHVMb0JmK21ZUFNabXFSbjM1ZGtVanpIM3Fs?=
 =?utf-8?B?Q3NuUkhzM2FIdk5tZzBqY0lTUytWU1A4c3Rha01IUHpVV3NtMVo0aDU2eTVP?=
 =?utf-8?B?Mmo4WCsveDVCcHhYU0k0eElua2d0eWhEV2lSZWh3K2Y4eHJsMW1zWkVtcjd5?=
 =?utf-8?B?TXlRNWloQ2NEbWdVejBmZkZoTFV0L28yVXZvTHpGbmx5NG9TVlFYNVdEdW5o?=
 =?utf-8?B?YWs3NjY0dk9oTWhqTlZ1eWMxVWNuMDVEN0VQQ0szOG1oUG5UMm9oUXgyNEs0?=
 =?utf-8?B?eW0xQjR2bVplZUtWaG5kR1Rmbk5WcXY2RjdQVXlsOXhtQ1lLdWxLMWV6dzlG?=
 =?utf-8?B?ZXdxc29ncGlOdnY1UHUxUUlmbndnWldHekVwakcxQVVTcG94UnJtS1gwUjZz?=
 =?utf-8?B?RDlDMGZxaXF6Q2JpUkdKYWlzNkFnNnNyOGFCZ3d1ZFZrdWZNU1ZwTU9ZWXU5?=
 =?utf-8?B?NTcrSTNwdWlaWkloVTdScHVYRnB4L2QzaHdhWWx5eTNtTnArelZDQlhKUEhW?=
 =?utf-8?B?SVBBNkFGTTRJcVZEeVZWMnc5UUsySktIM0RoVWVWNkNyaDZMRmtSS3ZuRVV4?=
 =?utf-8?B?VHpCQjRuM1V3ZXlOYVhiV3EyRGNwaGFSSk9PbmNCR20yMXdPeFU5Zno3bGxU?=
 =?utf-8?B?OHllRzVMekxUcnhJWUNwa0RBQjFwa1czdzBjbEpzMzJTUC9ialhScFY3cXVq?=
 =?utf-8?B?Y1hsUHo3RmpuakhaR2x3bkRUZ1hTbnhTajdKb2NydThtTWw0YlF4Rno3dUJY?=
 =?utf-8?B?QXJlK2crcm54UTBxUDM5ZFp6eWFtQUtHSlg1U3Qydk9WaFl1ZTlTa2FwUWZQ?=
 =?utf-8?B?YUJOcW42N1dZSDBDMml3Wm0vYnI5L25wV2dvcHdJRUdrdVRYVnJZTFJOa2lk?=
 =?utf-8?B?Q3d0L2owaUIzNUZHMDVvV2lrRk9iYk52Tk9wR1k3QmNzM0poNFZjTksxQzA2?=
 =?utf-8?B?bjVOc0xPQ2pGU3JxcG5ZT3JOZ20raW01K0JkOTFHanFBamJYOWtlVFFHSWxO?=
 =?utf-8?B?RUFiZ1FjMmd4S2RDMzdldGpTUVhqQkNlWllkaCtBaWppSVgrZVo5UUdrcy94?=
 =?utf-8?B?T2I1dWN3QU4vTXljdFpST2s2aUdMTHlHSkxoQkdNQXJpaURhSzJsb2Q1cDR2?=
 =?utf-8?B?QVR5WStWdkVzWEJ1TFJVekdRbHBlTW9RbFhIaHQ4T3hiSzE0Wjl6M09Bbk8y?=
 =?utf-8?B?VzR4VEdPc0NwNWJOMTlwMXBrakE3UzhtVWJza1MrZ2kxa0JHK1QwQmZvenRo?=
 =?utf-8?Q?QSFQRPcbwgIpK+1cSkr9G+ex/RYyMPik?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(10070799003)(19092799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXc4dXNLeHJRbEtsWGdlQU5RR1lVM3RIaGp0bmpaUGhMTTQ3S1IxaEl2NEd2?=
 =?utf-8?B?bVZqN1Q3TkVVRys1ZSs4TGdLSzIxWTZrZlJ1NDR1MG1LdHNybW9QVUxVREha?=
 =?utf-8?B?Z3ZEUmxxcmR5UC9iZWdFaEJVdm02aW82N3hQOGMwWHNNNThGRnNWYXpNSktj?=
 =?utf-8?B?QkdMM0owNkJkek1YZnRUQmNmbjZaTDN5ZER3Q1RTZmRuT3VGRFFxZ01kc1g2?=
 =?utf-8?B?dVRVN3ZSNU1zQktWUjI3ZGliOEVIUW42NDdkU1UzZEE5aStvZGptdXJGOVJX?=
 =?utf-8?B?YmVjbFVTemlLRFZoN3dYamo3NU5Oa1FHS3FDdXNKeXJTWkNIekpYSmJ2RWJO?=
 =?utf-8?B?QkRFcDBlQ2VSM0RCb0ZmRXZvUlNyYVpBK0Q5ZG8xd2MyVFptN3JqRk5uMm91?=
 =?utf-8?B?V0J5NXZuNGY1NlprbnpKYW1qdmhvUGcvQ0hsNitYaElBNGtDUUFOc2cxeHdG?=
 =?utf-8?B?QW5MWS9GdThobnd5MTlQVjNxVE1jRGRkdkNZZlFaVVVveUx1Q1ZFeFpVbjVO?=
 =?utf-8?B?T216TFRRbzlNODRFeXY0cmlyYnkvZVV0WktOdGJUN1V5Ykt5NHhBeWpyYVNw?=
 =?utf-8?B?YVRFdGRnOHZBZFMxR0oyMStEVkRKUFVwS2dVT09iVFRJSXJqdnpqU01uZlNH?=
 =?utf-8?B?dVU3cE9ncDNhN1NHVzhaTkJnMkNQVWxnWFJJTEJCTWk5a2ppZE9LdjRDMWtR?=
 =?utf-8?B?d1IzL1ZsTXRqZHA0czZFVlVJbzVHQXE4OFh6YlY1Y3lNYUdyL2tTb2MweHJL?=
 =?utf-8?B?R3JucE9kSzhjN0VSWFFUQlpkOXhFRHFzaUtvY3Z6eDk3ZmFGcGxMcFZkMkc2?=
 =?utf-8?B?aFRzbHE3NEFyZFo3cDV6V3FPMUIyQ0dyR2JEL2FUYkNpZDRKVE5tYUl1dGVL?=
 =?utf-8?B?ODRnVmlzcDB0Z1RBb3JFMFdwUVUrL0lkd0kyQm51dHJ5SzZtVE11NG9RcDRM?=
 =?utf-8?B?LysxRVd1Y3ZKZkFYMHpUYzd5aGM4Q2dyNGFEYXI4ZzlwdHVQcHczWEpoWHJp?=
 =?utf-8?B?eEc3Q3BOamlBcXQvVk0rK2pWVW8xbURKaTVMbXlXNXNsY2ZjN2JCc3dIOFNj?=
 =?utf-8?B?WllRMWY4dWF0UjU1YThZcTR3U2hIOFZUUjBQdS8wVk1OSFNUNVRWdE16dEtq?=
 =?utf-8?B?M2hETVNZUW1hSHpNeDNjU3ZpUWd5WWZjY1ZrYSszWEpJQjNyZFY4anFtbEx0?=
 =?utf-8?B?a1o1dFBVTmVJRGxyOERSenZpNnhDbW43Y0IxWHJQQlVjbkxGZXVYM2JFekZR?=
 =?utf-8?B?cmt3bmFNVTBrMTJBaTQwSFMwZ2h6ZS9PNERLUk05MGY0N0xkQWp3M0pDV1dE?=
 =?utf-8?B?bExGdUE1VFpNcWo3WSt0VGYva21PYVlBb25UZG15SCtZa2FXMGNJQllMeUlz?=
 =?utf-8?B?c1FFQXcyZTZ3em5xRi9KS2tIck9mLzEwVy9LMng1V0d0S2RYMjMzV3Z0RUow?=
 =?utf-8?B?MXpzRC9ubkxVbzBOM3NBSUFsbWZ0ZXBjWnVJeU1hSnloQlQvLy9aNVpFcEtZ?=
 =?utf-8?B?VzJNQlJqWnJIT25jUitXZ0VjSGI2Y2VWYkZQc01nei9sUmxiSjZpZmoxVHVN?=
 =?utf-8?B?S2Q0Q2g2TXRYQ29BbUc4cUMzV0RWeHFrVzFPSkZPNUVpK1Q0OVQ0NXYxc0ZO?=
 =?utf-8?B?bkU3YmlheDhTZlNQU3krTVdQZjVpVWphOUt2bkRrdHpuM1VrY0dvZ0xOR3Jk?=
 =?utf-8?B?WWNDa0o3TTJLNkZiQkUvSUxXRVpjVlpVcVZUVWt3eVFLK3RITHA0d2J0RkJv?=
 =?utf-8?B?THIrWkR5L0x6VE43TzRacnRlczZzdno2aUpyMmJnMGlubnUyakovMGkyQUor?=
 =?utf-8?B?M0ZxWVFjanduRHc5Uzh6Q2J6VGRVQ1dkZTFQUVZZR2tScnNmZHhwQzEzd3RY?=
 =?utf-8?B?UzVLdXdjRGJhZDgvRlQ0WFpNd0tQaWVoRmVkeXdrY1RzbGxzeUV5SURDbDM2?=
 =?utf-8?B?NjhLZi9HTERhYXhRK2RWZHZmVFlJeTQvTUtnSEI5Nld6bVZrT25kU3J0Zk93?=
 =?utf-8?B?RmpPVWVheW1lOTdWSFAvdDhCbHlSenFadkRKaTY5T1JUWjRsdisrVGJHc0ph?=
 =?utf-8?B?SzF1cTQ1a0x2dlduVVIyYTlmblBpQjUrSWlqYUhGazNTcmQ0Qno4Tk1zSGxy?=
 =?utf-8?B?bCtNU1BpYlJkci92M0crRE9xTnlVTlVpcll1VHJ2eVJRcmk5NGZ4ekVUU1JE?=
 =?utf-8?B?dFQwd2FNYTlsTzFUNCtqVXpuYWZhNTBENkp5MjdsRHhQVXlKMFhtd2RLSzhm?=
 =?utf-8?B?T0tvaFpUanRMdHA1Mmt4MHlyV1BnPT0=?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020778ae-3031-44c7-83c4-08de2dadd145
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 12:09:29.8334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3qogZHdGUw6Kqek8wvOd8gXlmcXixpHk6C5p6SFsCen+JCXMKIyLQIl3WCktG6TdcEMWtmdhAHXU9Qz2Dn4Aug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11844

The "rtl8_4" and "rtl8_4t" tagging protocols populate a bit mask for the
TX ports, so we can use dsa_xmit_port_mask() to centralize the decision
of how to set that field.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: "Alvin Šipraga" <alsi@bang-olufsen.dk>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/tag_rtl8_4.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/dsa/tag_rtl8_4.c b/net/dsa/tag_rtl8_4.c
index 15c2bae2b429..2464545da4d2 100644
--- a/net/dsa/tag_rtl8_4.c
+++ b/net/dsa/tag_rtl8_4.c
@@ -103,7 +103,6 @@
 static void rtl8_4_write_tag(struct sk_buff *skb, struct net_device *dev,
 			     void *tag)
 {
-	struct dsa_port *dp = dsa_user_to_port(dev);
 	__be16 tag16[RTL8_4_TAG_LEN / 2];
 
 	/* Set Realtek EtherType */
@@ -116,7 +115,7 @@ static void rtl8_4_write_tag(struct sk_buff *skb, struct net_device *dev,
 	tag16[2] = htons(FIELD_PREP(RTL8_4_LEARN_DIS, 1));
 
 	/* Zero ALLOW; set RX (CPU->switch) forwarding port mask */
-	tag16[3] = htons(FIELD_PREP(RTL8_4_RX, BIT(dp->index)));
+	tag16[3] = htons(FIELD_PREP(RTL8_4_RX, dsa_xmit_port_mask(skb, dev)));
 
 	memcpy(tag, tag16, RTL8_4_TAG_LEN);
 }
-- 
2.43.0


