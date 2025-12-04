Return-Path: <netdev+bounces-243515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 479E3CA2E32
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 10:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48336301CDBC
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 09:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FC1330D32;
	Thu,  4 Dec 2025 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G2fhsCWY"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011061.outbound.protection.outlook.com [40.107.130.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA68B3254A0
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 09:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764838962; cv=fail; b=ndy4azLxCuapabydu7uJAWOJgOTN9mOc1nKCRiuYH+NklvSEB3mTeXMxYPeNJVCRvF9mwgTQWjJML3JHxwsVcSXW/m8aasbWnOhgGfUQHOjokgQIRK+/ubjNL1w/nsadgrJvpGXbFYxgDXYd/BJ5Ll3E3zxI6oNMN9wAxlxlOQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764838962; c=relaxed/simple;
	bh=7HBQsCC4jIf6w3m3p9pMNAkVaYo3ekYncyrbS46j4QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rLG3t8fxLAM1ezQn2SAFxZQGWIwNkyvHBH8cUWziBMfbp0hUXKrYRreVvOel1u3byeN4zILI6W0wvRUMMJUyT5KjQ+foFp3FjxJlA2Yo9etwht6bx+bRByWx86KwcCkS3jALIoncvCgc5z5GBy47TAL3pp7465+ylun34ve/UeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G2fhsCWY reason="signature verification failed"; arc=fail smtp.client-ip=40.107.130.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K29groWoBNYygH9v72oqKWE2jF92xPk4bfcJNxrae2YpK8NonZuJXXK0f3rjmjUy0ERakroMkQNwFUdX5su92bysCIsYC46E4c38dU4hshdU1YxicoQl3Ye7XqF43N/TEwVKkBpoGqgJNQRzVgaoS5V2bSuDN5DZvB/eUHEsrUZ9vqg0fjh5ChWIZbcBd6N7lSfcRn+hV7MzGrTxeEw9SHR79n+IxdETAAq2FNu5uOmI4rpoDz1EVmoheNQdlBTemW5IBhuLTyaU2gByIYHgCoITVon1kUSGKyd2MpAYOmDO013MQExFoJiy763dRyQ1j2syqpmz9C3mLQuzyAqZYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPP4quVmkPhH6cQjqyy9q49i4Qxm1ZtU7fNwnYHQUrU=;
 b=TQDGd997e+6dDlVOUg9k04Rjzlrro7UsJ29IuO2EhCJjeBGrxTG0UEX0iYI/WhqVYU4mBH+0M+8JAFyB9Jrujitns12rteMICq9Aqe3Oz/zXdtDCBVUGcp6uJJGKLuxCbdTn0+vbXAo/IdFtIWJ+DPBapfjx00FWpM0sAreiEtM8873FtJZCVa7nTUkC1jXpHdxAkC7PkFDL7NfanoyiULe8mlo7aMY+jz69QXYkTdhmFpuwzu0wcZLYjkqO+16RheaD0+Ias2NE1AOKkZ0Z7RhnT+6N1b+/1Kynk2nyFusn8qT4BwpPC7VmpKrdlUxS334C9BT+s8m4jC8nTEVZhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPP4quVmkPhH6cQjqyy9q49i4Qxm1ZtU7fNwnYHQUrU=;
 b=G2fhsCWYF+qbpXHrE50HHsojueSM2a/iW8d1bddBkS37w1HYiRVmL5+zDooowUzAoVg4248hg2vyokfAsdjS8HELmGufKGRcg7oAI2YYXtSY/Dc9431mHjUf2kPjX8m7Zxy3RD1vXzH0QLHiFu6Tjed20MLTJYheVhEs4srrw4p7NZC2dxiasgnRwn5+DFkcEC//okMrQ/imYKXZAEszUYf07e2zVE5d7Hi/bmxurh+0bmKqomLLW0aQn4qg1AB4NoglzVAMJaEFJJAwfTf6Ht/pM4tzNS/e/deBdr0LGhQLVO5XwVvFf5bQ89i+yrXniwb5Y06hwDfGYVPvSk0myg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB8151.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 09:02:36 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 09:02:36 +0000
Date: Thu, 4 Dec 2025 11:02:32 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Cc: netdev@vger.kernel.org, "Lucien.Jheng" <lucienzx159@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: [RFC] net: phy: air_en8811h: add Airoha AN8811HB support
Message-ID: <20251204090232.gbezd4zzppd2qp2a@skbuf>
References: <20251202102222.1681522-1-bjorn@mork.no>
 <20251202102222.1681522-1-bjorn@mork.no>
 <20251203232402.oy4pbphj4vsqp5lb@skbuf>
 <87sedq4pyk.fsf@miraculix.mork.no>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sedq4pyk.fsf@miraculix.mork.no>
X-ClientProxiedBy: VI1PR07CA0238.eurprd07.prod.outlook.com
 (2603:10a6:802:58::41) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e5229f0-db3c-4926-ca09-08de3313de0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?fcpYxNHbIyxx3Lf2uMejed/2Z+v8G75206HSQttopoG8HVZ5+B7vxCkA1B?=
 =?iso-8859-1?Q?pP/qrojbEubL37Hn3+WnU9K1jFlp+sYfl7Ws7Rvp6tEEdGB9sMQpnQYMz5?=
 =?iso-8859-1?Q?q1VCkHtMWDnSFF0kp0enPDJQMkBv2BjVVnk4sVaqVNsUGzXlUqEg74q1ff?=
 =?iso-8859-1?Q?CcA3PayRRn1vH4O3duiDiu73twU7R8C3nxDfuBvUIH1TOEW2geZXz/oLaf?=
 =?iso-8859-1?Q?kGNK5lJVGYvYOZ3RrYJy6xq58v18qHNT4W9ttHaYNZ6wsBbMJlBQb3ziiw?=
 =?iso-8859-1?Q?f4PWDsDwPNgXb8dCj359F1TMiVqlRLA1k6j0WOjELVQYlqYjSyi9EM8C+i?=
 =?iso-8859-1?Q?bqUI7p+I6AOFcGcryWdQrbssOuScQ5/9HlXaqNAoLrGtUj1Ogahimh+0dZ?=
 =?iso-8859-1?Q?69Ftuc1kcIc4UElyF8vfxbm06tEYbT5A1qfKlsCn4zavcDUrSG/LkHPDNB?=
 =?iso-8859-1?Q?xpfpVFEvKUBN8l7IThDpwMImcAlbjF0CB9Zx2p+BSZjNMAlDihwi8/q7YY?=
 =?iso-8859-1?Q?GCl26q4VzE4S/SAy7bKwiOOrdyeCmnXQDxi9pNtFh/E0E/3queMHPR1/LU?=
 =?iso-8859-1?Q?FJOA8soH+ais0a3CveLvn5U3Nrpp0L8JyS/Udt2ueRlkfJsswFKrjBq3Ce?=
 =?iso-8859-1?Q?tmOALDd+1nm/QrTpH51GFgHtWM67sEk/gRdPfl9KAq7BdjCAoIfUBjAst0?=
 =?iso-8859-1?Q?tnp7Q6psv3bLa04Z1FAukO5XuLhNsxlLqSFBEuWt8NtdZrncgdpCWW1Ao+?=
 =?iso-8859-1?Q?567MefidO3ovWyWOFONc7OPQJ9L3WBzi2iDcLz2rd4fEtv4HGZKv/H9ePm?=
 =?iso-8859-1?Q?BHndrV370gcnnA4q1mlu7AkLwWTlyFKZ3+jj09YbdF4dugiSOxr6LuFaFO?=
 =?iso-8859-1?Q?Pj0ZYh5rr5I1cbtiX/azkXfMhqn3OJaqYjVwY/ivmjgYCHyKNOwKN0M5TP?=
 =?iso-8859-1?Q?iTVHjtx+7KEfxrL+BQX9i5M7NvDhJ30P2+d/Xar6SWkpnoLhEUiSAn/jye?=
 =?iso-8859-1?Q?WOrihAd4SxRVuSDrF0caz0jWvzbePOJtpR1HH0r5pEdhhJa0y8ZnumCC6T?=
 =?iso-8859-1?Q?XQDd0nQvEK42ty6GcBdr52zj8dzu7S0KExcFl1Fr8xvmNslAA+qXZjgLVP?=
 =?iso-8859-1?Q?dEtIsi1PrH16yKfogK+dziGyfKlJzAULeU5hcmO/Y59Me0duqcPaauBTlZ?=
 =?iso-8859-1?Q?8/MUMnFRTr9icJWsBf+Njb3W6Qta71A26MbkWtOrB5Nuba1EXt6KQsyLOE?=
 =?iso-8859-1?Q?jC+NQAfEgFjsqmiGg/5DlWgqeGlD28AWD0tB+HBG7QF7amRaVIh2VpCZ+a?=
 =?iso-8859-1?Q?RaMUHhM9xI4i858mlgFN+pO+PRgbo/KzXIKIBC8hSM89eMlgmHCgHVGdvw?=
 =?iso-8859-1?Q?0Mamz2LJAHmIY8foiadRZBj4oh5oCt6NkbdDQlvzBRXMvkTN6/03aGz4Ku?=
 =?iso-8859-1?Q?r5RL/2goynYdroVP9vIMeBz6QbpRsZGdUf8/VEyqtikORPzeui6kR96uWI?=
 =?iso-8859-1?Q?M6v6BZJZASQDnNpLp/rVeW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?wAWpR52bICR0HPuk2PoG3sDw5UES5Rc3xAGXY+FtP2Pn5YzmbisYjNStVz?=
 =?iso-8859-1?Q?E7XsDcPuETuVeVm52ED9djd2EjVkHDAr+w6tYLDWMrdCZ21ADAhh1BTlFu?=
 =?iso-8859-1?Q?stsv5X0EiFazlkDU2K7eIIkMKj6XsnH54RwWt4soIBul9KDnmfC3GhTQsI?=
 =?iso-8859-1?Q?JIRRtThwGEn8bErLh55ki9Jl+JWYiftiebfzQwDnA5XpRDdR88EZNcs1dK?=
 =?iso-8859-1?Q?1bDFVDUfgaB/5qvGSTA5/e2WMTBNyLR+sFEvJ7RgYwaK9CAlpOn850vQyy?=
 =?iso-8859-1?Q?wxB/y+RBCWTxAR5VOXDSNElLEAFFmN/teX9hqbK/yOSmDkSOV1A5WO/3Og?=
 =?iso-8859-1?Q?IYQzLhueQTsFGMZLUh3HETTuT3z4hGW8ehwA7xqIuBKizURid1Tm9f+ruK?=
 =?iso-8859-1?Q?CKANe9OYxlTsNXCRpHgC1QmvtLkzC9sRRL/YgPUnAjq/dwWyEBLIMUQBE9?=
 =?iso-8859-1?Q?1tkX2Q1FOjyqRHhNHh/k26HJsGFU0W30xYw8rl914bMqapxZnPRnwlLQZg?=
 =?iso-8859-1?Q?OXahMjqh+p/zA7OpdQn2NN0lKIxJ2Tspm4QfbfKbpVDzR15QICKFylN/aa?=
 =?iso-8859-1?Q?TPH2YsvlEyySixYpB7yt9UqqyWgJdwIXSpvduVYsDmLi/L5UjWf92O8ZLz?=
 =?iso-8859-1?Q?irLyIDh51y55GU6A2RUmJ/trHKp9DIFgrM0O4Ax06VlPXWrlP74+4QkN8d?=
 =?iso-8859-1?Q?+ld0ZuTyhrE8cnmskl5o3YnziCevwKi1C4fcSXFWxUOaSYQA7CLY7dc3jN?=
 =?iso-8859-1?Q?fk1YnjBjSkvAY2tNvLdP472z2/79hz5FjI8t6SH9dRMpU7bmKiJgly4Eoj?=
 =?iso-8859-1?Q?V0oxMeoHuHXwcp4mdBjMknkUxqww6D7I7nDpqwGmzw7Me3bz9Mc4H338pr?=
 =?iso-8859-1?Q?JpNBm+loocHR0qECTtDLfnbkyMJsLr9dBVZLFl++6M4Ma2tbYsGpGwbXnh?=
 =?iso-8859-1?Q?7Le2H6rKnPXB3fW3m+VNBzjkikKUZEhM+nPhpv+6m6hiyJVS/1EBow6vzs?=
 =?iso-8859-1?Q?xBNdI5YyhFKrU+HQjrtANLYDBB3K4yLpsLO9YobvvsK3HbefSkHb3Uc91o?=
 =?iso-8859-1?Q?TvBifm36rTWw2DB8sXzGMdlYWOFADQOVMY6S7PgX7Z0+fUf+wVc7X2E1jC?=
 =?iso-8859-1?Q?g5fp2rm6EhBybLQ+cUUsDYXgo9YlPfa6AiYi7BaNNraB6rkBZfSigks/jt?=
 =?iso-8859-1?Q?4s8krhn5LkyGVVqSwCE9Ct93R72KD4tTf5LAlqaukgOGL6vo3itRlOQ4P8?=
 =?iso-8859-1?Q?kDZYIsjavJgBkacCkGO4UUzMFl/9Aj8yO5MNs0bCgFntq1dhJcWUP/Kg0P?=
 =?iso-8859-1?Q?65uO12vh9XaSI9nLvLsFRP1dxlDAGOtI6tWFwAlqLQFkh+NGlsY9nU/1vM?=
 =?iso-8859-1?Q?N2H0nW9av/5I3n2lep1TKZK7NscOn3Ichef5sPVfE//pOKLOF3/Cl8snW3?=
 =?iso-8859-1?Q?0+4qUy/QSrikFB4vSIdMvzC6m6ZGQYVjbWxAySVWgQ9ICkPjJTRe9cmyPx?=
 =?iso-8859-1?Q?Ss1WVeSNpGYRhKv4HlJhTk6o9MbMlLnZTbFv0gEo2BUJy6lsJq0IjiV2vv?=
 =?iso-8859-1?Q?Knhm4GkKKzJ/QnZXuptrF/UwsC7FW3ly6adRCQxJy4c/dfKD4/cvVmdgIq?=
 =?iso-8859-1?Q?Zi6Y2jHpSZDImLO7UXuzirP2wG4DSAdc7mFX2e8Lw2t/p0EnuIwWgIx5Gb?=
 =?iso-8859-1?Q?yUVb55D+iS+3GifJHoOit5qxzr2TyM73sdnlfK9HfFqOTcpCMyAhU5dUa4?=
 =?iso-8859-1?Q?24TA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5229f0-db3c-4926-ca09-08de3313de0e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 09:02:36.1198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qf4pDkodY+cJDaPYy8wBJF6Z+kPjyVXBvcMoJTP6eIeHh6huC7PofRSibPy1m+b7HRRyBlkqUfjiIxAxz4VWRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8151

On Thu, Dec 04, 2025 at 09:21:39AM +0100, Bjørn Mork wrote:
> True. Much, much better to return an error from driver probe than having
> to debug arbitrary polarity mismatches..

Note that config_init() isn't PHY driver probe though. It's called
through phy_init_hw() from places such as phy_attach_direct(), so it
will fail the probing or ndo_open() of the Ethernet controller driver,
depending on where it has implemented its PHY attach logic.

