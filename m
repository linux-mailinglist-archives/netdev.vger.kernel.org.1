Return-Path: <netdev+bounces-143798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 409A89C4360
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 18:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42AA1F21AE4
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 17:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490F91A3A8F;
	Mon, 11 Nov 2024 17:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="l5sF9qg9"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F9A1A2860
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345403; cv=fail; b=Q18NNfFv4N71BSY/HCW5TdCqCXqHlVuJhpnjOaisRAQqarVR5Apnwu3gVqgLi84YtAk4I3FUtsiSThuFR8N064Mm8WLx2MB2Fhx/faoDJyp7TUbxfmig+NM+YAFlxG+ksNVxjR08vmA7PKzFNOVBxNduJJV5q2Nrj6tFdlWotz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345403; c=relaxed/simple;
	bh=pL+u6JQ5bqiz8srNQC9bFpohibUcr1+/8H/m/Ud+5T0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OENcRwSJ0RXgaWc/cD6enl7118BfGp8oM+EtzRVOedwVSyzmxJhJlhHpTZkZhk/jsaTjwe4d4TaFxK9ulwCfONcIzaB8ma89YcQGVlGK1tEhLc7TlRWIlGut0TCDeerzrrr1UPaWhzjlNLQFn3g6EmxGobDPEvqz7rgYNwqF6bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=l5sF9qg9; arc=fail smtp.client-ip=185.183.29.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 79D0B1C005B;
	Mon, 11 Nov 2024 17:16:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2OjyGYYiVfBdfdtJ9HHI6TpWkld3Kc+hrzBkLzPWf6U78kRMTSZnZmuQ4KycJT6PO65hY3pkXmQbSzC+v2FYXnZtVHl6teAFa3bZMgvuJhnWcjn6jLmFLqo9r/X8M+MMQgSvvaCMd3PIItbNVW225qhYQDDAcGFPOzTWv7Vdhl++wjeEQkg8fVuQ3S3fL+/RH9KV3fezYps2HX1F6YnSZMUHaIBChjoSdwLORdFGc8Whp6CiU9B2x86notIKCzIRT3z4Fp0PN1EwgiphdWD2axm9U4BQtUEW6JdK7xJRRZ+GS9tAve+G2Ew+GzcgqdAJmGRMyG4lOlDKID3Gm+wOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpCX2UKW3vtQgJK5QdDMVn+vqpAXX5bePRpUtp/ZGZA=;
 b=CjAc6C7SS6YB9AWSs0kJ//+xYAvC/8mf8f98jLTooei9BW8GRgxZGc3ZUQ0w/nQ4w9OpjRB9YxdawOdrF0n3ebiJO88sCRpiuK3MeNFqzgAyLiMwl00K6m/KwlKNdiOB6of2AtkcmPBP2BaZsyC4rwY6zc47d7wSHOwhGcgJAqlXywAwgG1GFsM4Z6iFxjJPgR/VoDjBkiGIt8lmeLx7DU7S1QUnK957CmsNcuezBfgQio8xc9A+8r5F4VDIhRzjalKj/OoM2/TGMNGGKTV7/tEQE/CdQOI0+zlyAK51StmHmw2rpIjXoWl9/SejXGyu5rWSCVUprLqlIdHlZDOVjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpCX2UKW3vtQgJK5QdDMVn+vqpAXX5bePRpUtp/ZGZA=;
 b=l5sF9qg90sF1nYbwVRXVnYWa0oxkcutXaaVXru/FNZpD9k+8lqQ2VcWv58dK6b03fj7yxFY13BlxdiVC0KSDRNtoqLw7aT2Itn+nqP6qwLlXGi/2eswbO8M4NbPIdVKqaS2m+JahzHiP3NDyF5fpFhM5mumXl8TSmUw2AUx2HnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AS2PR08MB8720.eurprd08.prod.outlook.com (2603:10a6:20b:544::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 17:16:30 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%6]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 17:16:28 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: Gilad Naaman <gnaaman@drivenets.com>
Subject: [PATCH net-next] ipv6: Avoid invoking addrconf_verify_rtnl unnecessarily
Date: Mon, 11 Nov 2024 17:16:07 +0000
Message-Id: <20241111171607.127691-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0384.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::11) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AS2PR08MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b948a6d-6e6b-4a92-df5c-08dd02749407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nav/5qRTRKFymsaho80FXfkLaBwRIZctP/95rUxo5eofOhPqhGn9ZRr84mhP?=
 =?us-ascii?Q?w11Q7ntTt7PW5E7311cPNBUh+fiG+X7e1dMMCmVxkHeyLYTWZHP9sc2zza1f?=
 =?us-ascii?Q?SniNqqNME9fg+jiVTlWm+dhn9iYASlcFZosLBsKG8Ue1jCu5qsicLv1e80My?=
 =?us-ascii?Q?xsZdzLXCWHGmFQQ6O9cJA16HcZ+gQyZDGoVsZp6B1AsCznJhVvFZzUPfFPMi?=
 =?us-ascii?Q?dRmwuszz/WY5pmqAswSXf/5kG0A+k2/GoKwLTH5HhlU+udS3b0m9CDIQ4RYh?=
 =?us-ascii?Q?CHyPiu5q7UhtR6FnZvGSBvtWInfj5S/lvw+OoHYYsStU/lcuBYh41ioF0NWA?=
 =?us-ascii?Q?Ky6AxLbb8fgntSylee01RJT0xfHB/pJbXmliB1KW8n/bc+6uPiKkAGsAT0gA?=
 =?us-ascii?Q?WxR15K7zr/oFJnApkafKsRz8kxgya+9fs1sn+OsHkwFssgdftyvgAsuoupDN?=
 =?us-ascii?Q?k31jTArDJ0LqumJRjZ8gArnDjwiv0faz9TVU6OVurMgAMTYgu1rxwbWGFx9X?=
 =?us-ascii?Q?78MiU/SUzNgl8ipBHZDlYr6diUwxGDFUialZ857J8PA21n1EVaXqh5s2pGXT?=
 =?us-ascii?Q?hMFa+qOHDzVLcFYZBaPHmG8cAhXmdH4+WhT4dXw+0uJMTGeTljZb4Xmq3m7g?=
 =?us-ascii?Q?tPJsMzrIrbTC9vca6wLkQ6nTsfBCUc/MZSwB3dPg4F5X7LbAMNMwtWYenIoi?=
 =?us-ascii?Q?8r4dUWZ4/stJpHrRLomnWGAx+wvBoUXwm07Od+yzgzhpWXem9dR7JORUeo9I?=
 =?us-ascii?Q?pwhbSn1OJY8fRew8zoXjEuI28+xNCowGsihhTAkJxVxkTs5VJ8kYvgAWf4sx?=
 =?us-ascii?Q?Hb9xicCsv3URWaPlCfyfMehs20eEbp8i6+HRBo18TYWu03ZtfYZ2Pcn7/zBB?=
 =?us-ascii?Q?Hlhju4SKDhyi0K+l8rI4wsz7pL5beEzn+5G28iIukwCmMUEtclwGnZdz3sS2?=
 =?us-ascii?Q?lo6REXMpGewZkJ8/EAUcwvgX57Y/KEq0VRCKDGm0Q4mOwUzurJ1lk5jnJm1M?=
 =?us-ascii?Q?Fx2E04sFnTBFLYNUz9DQDSnK/KuKXHdvnw7qWI+1kA+ntEhqgAukMOYmg4LE?=
 =?us-ascii?Q?zAMT8xYsLBpEV+Eq2NyUjcMQ3LpXEjpyk+nSxCodQhlm8nenPHgju/rAQzIA?=
 =?us-ascii?Q?vV6wDwk+hMfJezCkwQw/gq3W0k1TIhSMHnC2wLImI2kl6OH5AznjSIQjBGaj?=
 =?us-ascii?Q?4TnnOyE357SfLJyiB+C2zcQvJFSBqEg5a7+2NkfYCE/ln4UiwK3MoyF9gU/B?=
 =?us-ascii?Q?bDy+5ZLN1IVVCGGKXv8W4GfrDEsCf6zP1k2GasOKHalgktpWgnjKTXkzHmEy?=
 =?us-ascii?Q?qdTonOpYuu6jy7/UDMRJUv1wiKGpU7zyXTKYpiWEJfvMOZXM8Wdsq7ITqVB1?=
 =?us-ascii?Q?oXtzrtI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ojy3PC3NIaR1ICNanZdwkE5KrzSe6c/fWS5aymOMDLB49r/btbrJ+JndIHpu?=
 =?us-ascii?Q?2jS4JH41+sbGqoqLS0JaJkvBr/1Gk0jMcOibVCbPbygimGaXzgQGcDMxIJTy?=
 =?us-ascii?Q?Npf4G6iD9AaWcTxTZfGIWkBMTnKmpQpLrvqnnYrMf8xmeiImcYBNVX8e0vXT?=
 =?us-ascii?Q?XfluUhyY+LS6Gc7dN8yV9JVXVD3ndMo8jf1pOxEzUEnRQsVHTBs7bMAXKSw6?=
 =?us-ascii?Q?i/0IieIi+6zmWqRQ2JIttaBJCVtwCh2svXUeIcMEWCeGOHeYlnoEo/NrjEa7?=
 =?us-ascii?Q?+hVrnJ2/trzKlgk5yMErF/9NXBgSC369FVzbYZTThEISMWLoOu9VW23GuDXs?=
 =?us-ascii?Q?rmWkAORrDBAS7a4e8mqCByhYkG7v7NgPu5fpK0x82Y0OoNh2KPtV+tb7tH6k?=
 =?us-ascii?Q?gGLKGIMMhOs4RFmLOq6YSvK11eCpGhnkEDpKT22r1R9dYpJr39IjHfAtCluk?=
 =?us-ascii?Q?jtnFn/H3mUmwvnoUKqPND1gb50CbN9wCHbgiiYDwoOkl1QRmJdcC1ZrvcQ63?=
 =?us-ascii?Q?XYxAcofD/z7Iur1Zkmgrs/t3+R36Drv3eSRU+JCmkvi06BQ5HVY8rei3zm2E?=
 =?us-ascii?Q?9qWHd72IeT4AToinFwSti5zH5oGLRfYKsKk9rqurarLdopYWK40ExnBPD086?=
 =?us-ascii?Q?q1o7x19mb/5ZodFo9I6eBVzlPaM1CnU17U1R/vf0zj7aznkTmfC5BQb10DGh?=
 =?us-ascii?Q?HESl34d8z0zHKsu2TwSQgmHX1VzzEi8MUM5NuaxBaCzBj7xc2QadD2Si0095?=
 =?us-ascii?Q?VhQP5g/yXBZ91rCmzDciuViZvXen0ia4DNq5jMZppUIzrymfuLNze5X44Cf4?=
 =?us-ascii?Q?yuX8S+y92tYLmvZu+aj5XSdxG8wQqfmht/opmOgB/5Gv+K2Vf5ucE9JeI+K/?=
 =?us-ascii?Q?3oO7pHVQ5r0GfZ349ms4F7rbo8/P8muGqZMAjb3iiOe2xQFy6aWTBRZ10kbc?=
 =?us-ascii?Q?4QXcgKWdpGA1Cg4W6GZpQCMmK8byfSPf1BLG5F/tqwBWJkd+jPctNXbmkglN?=
 =?us-ascii?Q?BeoRQxPYu9j2GCZTIIAF3e4om++16m+0s5zHhpjPh3AHJqP5Tz0SxxiZojuZ?=
 =?us-ascii?Q?7ZgJTZpPKJ4Pha4G6/WdJiF8Fu+4Tol3br9rwEkKSoOdZknpXVy1KyXfB6LJ?=
 =?us-ascii?Q?e6zfKG+6vPfCWI7pXFVyOBUH2/edwglOCKaCqd77Glq0z5CcPxeQz+e7I3LD?=
 =?us-ascii?Q?Ma4JpC3x6VtQzanTf9yHzHAFJmFNuDIk3IzpZbNoJsoabCZYpfUfCq0BkVFh?=
 =?us-ascii?Q?b/h6QU9RsyfBlbd3kyXwTUsZVab6IVG/cdBZNVYIknA5Pcj841JAIm6t6A5x?=
 =?us-ascii?Q?Kk0za2ILqU5EPmAlx8LVfH8Tfap4br/l29QhivOApNVbZc7exEgA4bKbnJBm?=
 =?us-ascii?Q?OYtBRldljuHOvCAKk8JNSEPNqHARNEMQ0XykhuuAvufZGz05NoXRVVP2UHC2?=
 =?us-ascii?Q?GuuGlvpKYyX+xMoDwoa8wMSGJrcT5+sUXEZWtavzd3tzLGZiBHv7hqATw7an?=
 =?us-ascii?Q?hB38I2IdunQMZj9jxqmYDOq31wS8NKWBseYkdJ28qFWGRch5WWX6nn5YLpE9?=
 =?us-ascii?Q?L4Bp69UITuq7NdJjyHaICRt2yVXJXB94Tg+E/TgxCvHTJQXgQBcgd+O4j/07?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N5CfCeBExMSun/ZWQoNHTXixWMpEcCT6FyqhhCmnJSagOcE50LFbQtWtAoTYjUwlUINZ7FOkwCqwFkBhlafYZQXH0cEzupS7PtGf9jx09l6FaNrST1ieYbNVnVCR+zP8bFV2G+d6bH82qtwaFy6inubZfSe8pRLob0iUIZ4npGa8V0wE8U+Jaw/oqHa8AVCGg5O/c1GQpDy4UGl5GWD89W3K4tQUqbnoaQBQNBBEYpfkNxB6/IdJ2XCc3CjWmgyYpdudqE9TvFgCMvX9MU7SHihwUPFgArH74Ot5efgp7zJtQLzZ8D77VIUtjUWXxafU9Tc4ILiPTq6C3K7RsyK4DxMwJhaGL+nfB6Yab4/PKHtKUpaoAnmpVkcG5DHuY9uC8VlaEtHrR8gtn9m/s9D2/Hm9aQ+zR/+XYpeHRBCmgqA+E8l/a7jXTeAFU1nTlqK3CPTnMFUK5OasLpRtn+fVowmzaAbhRH2zu2uwpuPfLSeRecplCGrFU90Ed8rkOPA2bGf28YC3Q1Idb7SrpVF1vgH6wqMUJ6YaWuOktKqNQZ7Ll5eLnDLNwlFQXLzmoRfrNWQb0T7EeoGOfgRPhsaDZK2uhYXh+aekoFQQg7ZzeJfvx0FnoV2wtLqIXI/4WqMY
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b948a6d-6e6b-4a92-df5c-08dd02749407
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 17:16:28.3028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDCZH3kRiAg2V3svKCIRovoRm5TKAoEHKG991vwSIb6TtWXKtrBfdbkhXdmZusG2G5Pls0BNbmWcHdAV1JqHPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8720
X-MDID: 1731345394-RTYbwBxtfkJo
X-MDID-O:
 eu1;ams;1731345394;RTYbwBxtfkJo;<gnaaman@drivenets.com>;489d0494e21146abff88c0d96984588f
X-PPE-TRUSTED: V=1;DIR=OUT;

Do not invoke costly `addrconf_verify_rtnl` if the added address
wouldn't need it, or affect the delayed_work timer.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
addrconf_verify_rtnl() deals with either management/temporary (Security)
addresses, or with addresses that have some kind of lifetime.

This patches makes it so that ops on addresses that are permanent would
not trigger this function.

This does wonders in our use-case of modifying a lot of (~24K) static
addresses, since it turns the addition or deletion of addresses to an
amortized O(1), instead of O(N).

Modification of management addresses or "non-permanent" (not sure what
is the correct jargon) addresses are still slow.

We can improve those in the future, depending on the case:

If the function is called only to handle cases where the scheduled work should
be called earlier, I think this would be better served by saving the next
expiration and equating to it, since it would save iteration of the
table.

If some upkeep *is* needed (e.g. creating a temporary address)
I Think it is possible in theory make these modifications faster as
well, if we only iterate `idev->if_addrs` as a response for a
modification, since it doesn't seem to me like there are any
cross-device effects.

I opted to keep this patch simple and not solve this, on the assumption
that there aren't many users that need this scale.
---
 net/ipv6/addrconf.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index d0a99710d65d..12fdabb1deba 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3072,8 +3072,7 @@ static int inet6_addr_add(struct net *net, int ifindex,
 		 */
 		if (!(ifp->flags & (IFA_F_OPTIMISTIC | IFA_F_NODAD)))
 			ipv6_ifa_notify(0, ifp);
-		/*
-		 * Note that section 3.1 of RFC 4429 indicates
+		/* Note that section 3.1 of RFC 4429 indicates
 		 * that the Optimistic flag should not be set for
 		 * manually configured addresses
 		 */
@@ -3082,7 +3081,15 @@ static int inet6_addr_add(struct net *net, int ifindex,
 			manage_tempaddrs(idev, ifp, cfg->valid_lft,
 					 cfg->preferred_lft, true, jiffies);
 		in6_ifa_put(ifp);
-		addrconf_verify_rtnl(net);
+
+		/* Verify only if this address is perishable or has temporary
+		 * offshoots, as this function is too expansive.
+		 */
+		if ((cfg->ifa_flags & IFA_F_MANAGETEMPADDR) ||
+		    !(cfg->ifa_flags & IFA_F_PERMANENT) ||
+		    cfg->preferred_lft != INFINITY_LIFE_TIME)
+			addrconf_verify_rtnl(net);
+
 		return 0;
 	} else if (cfg->ifa_flags & IFA_F_MCAUTOJOIN) {
 		ipv6_mc_config(net->ipv6.mc_autojoin_sk, false,
@@ -3099,6 +3106,7 @@ static int inet6_addr_del(struct net *net, int ifindex, u32 ifa_flags,
 	struct inet6_ifaddr *ifp;
 	struct inet6_dev *idev;
 	struct net_device *dev;
+	int is_mgmt_tmp;
 
 	if (plen > 128) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid prefix length");
@@ -3124,12 +3132,17 @@ static int inet6_addr_del(struct net *net, int ifindex, u32 ifa_flags,
 			in6_ifa_hold(ifp);
 			read_unlock_bh(&idev->lock);
 
-			if (!(ifp->flags & IFA_F_TEMPORARY) &&
-			    (ifa_flags & IFA_F_MANAGETEMPADDR))
+			is_mgmt_tmp = (!(ifp->flags & IFA_F_TEMPORARY) &&
+				       (ifa_flags & IFA_F_MANAGETEMPADDR));
+
+			if (is_mgmt_tmp)
 				manage_tempaddrs(idev, ifp, 0, 0, false,
 						 jiffies);
 			ipv6_del_addr(ifp);
-			addrconf_verify_rtnl(net);
+
+			if (is_mgmt_tmp)
+				addrconf_verify_rtnl(net);
+
 			if (ipv6_addr_is_multicast(pfx)) {
 				ipv6_mc_config(net->ipv6.mc_autojoin_sk,
 					       false, pfx, dev->ifindex);
@@ -4962,7 +4975,10 @@ static int inet6_addr_modify(struct net *net, struct inet6_ifaddr *ifp,
 				 jiffies);
 	}
 
-	addrconf_verify_rtnl(net);
+	if (was_managetempaddr ||
+	    !(cfg->ifa_flags & IFA_F_PERMANENT) ||
+	    cfg->preferred_lft != INFINITY_LIFE_TIME)
+		addrconf_verify_rtnl(net);
 
 	return 0;
 }
-- 
2.34.1


