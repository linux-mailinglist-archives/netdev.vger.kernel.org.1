Return-Path: <netdev+bounces-93464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 999778BBFEE
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 11:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2131C20A4D
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 09:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78D37482;
	Sun,  5 May 2024 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Jy8kJ+R2"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2136.outbound.protection.outlook.com [40.107.247.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E5F6FBE;
	Sun,  5 May 2024 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714902772; cv=fail; b=LPBD42l5PTzWbFC4QTNPJQx/jIVb7+YARfYnFvWGf74uB8/INh6soTpD5/NACFrZbNOtnNRjTn7oTpob1r1PbonSUu7RtICzPAAGjm7H6jHuNtPrx1IwVhLBiGrhr6XShtcvU0lSbnmlcEO2LnSY47ErbIWMGcjwA1YFbtruRio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714902772; c=relaxed/simple;
	bh=dXfeRGDZ7cYp60tM9lZavUSCmaezb8UTb4S97ez1TVk=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=R1Zr4E9E2FzHehAMBLbOdx/lnyimzr9av9xJnATI7Q9G2ozy6IPYQaJCVnlBjIzPZ+o7nlE17qQxxQRsFMRCh0WunsKiw5ZKGScdzvsad2/gP4ld3e8GT4k4QG2lu1smY5iAKOJkzz+YmqmXQMh4nyJ/1PdGo2B0VOyZOL9LLj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Jy8kJ+R2; arc=fail smtp.client-ip=40.107.247.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDGqs8Yu81hLe9YKWqmn6YnvW40IG09yjibR0G7YAkI9en8NFf80McNg+jJ4mm2VMZWeDEmfWvDKFYVuXxsr94JordM9Wy1CBPzxxlbg8yyub0zbhM+bOGCPfr6yjmiDLDcd8tSpd2SlQW8ux6j3IYWilbKk5XoaurSmdf8jxPaAtBrZWLML0pNvUSobhpXo2yPoEEiKrW+5/LvQTAjsYVocSX9SdpcgqiHNJsolrPWmLEezVlefhU5PHyuzBgnc1Kubui8xCWrx7kmPZgymKWCKxDbuctEceTg5v7jbOCCzojoZoYogM46jq+JCTV7fqsv64aivLPGOBOthdeqtZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pOaZ/JQbzPRw8x370l57MX66OHOTKNKWpa/USo6moA=;
 b=LCVqiuMbdUcx6RdvLvdd9gk1jwkkH0bq37+FBDE5H02hCo3YxtaH2wveem2kaMU6hP10JtQ3kQ1rYSIamJIMDleX9sa++Bht2z5bLWyt3Hq3Igu7pkWsqYuOwQeHMKkTL856P+8a8TcpMLJ2RW9LpK8aC+B50ZcJVvxRuHJs5qee47ukLDUenrsSzWJRmJzbSM+AO7Y90IMmaGlMj0HflPoECPGRGj4L9KVynhg/hFoJGJwwls7Endrx56AdhZ3ipNtFOD1bWJAttj27Ex0qGT0NnVluMQXGwYWpSNBqx5BdqMNgfWMjDU0Oe+f9zLxJ/hhbPGtTTxhICOnBJrGrcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pOaZ/JQbzPRw8x370l57MX66OHOTKNKWpa/USo6moA=;
 b=Jy8kJ+R2a7Tr5lRG/LbWS0w0yl0lSCsCaoRXhWOrKxGRgy31Fmwzzu2Z8isSdWnbo/GlOu00Qvr1NcKv9Oh2NBtU5YgRgqcv7chkuHBfBew9icj3qSfCAe5EbaT9WhYsDbUTNI+MylS0o4UDhYaiBDuJzuTHeN9GYDDCpjpUC1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM8PR04MB7331.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Sun, 5 May
 2024 09:52:48 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7544.036; Sun, 5 May 2024
 09:52:48 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 05 May 2024 11:52:45 +0200
Subject: [PATCH net-next v3] net: dsa: mv88e6xxx: control mdio bus-id
 truncation for long paths
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240505-mv88e6xxx-truncate-busid-v3-1-e70d6ec2f3db@solid-run.com>
X-B4-Tracking: v=1; b=H4sIAOxWN2YC/4XNSw7CIBAG4Ks0sxZDodLWlfcwLgodLIkFA5Rgm
 t5d0o0LE82s/nl8s0JAbzDAuVrBYzLBOFsCP1SgpsHekZixZGCUNZQzSubUdShyziT6xaohIpF
 LMCPhzVCPrBW9lBrK+dOjNnmnr2AxEos5wq1MJhOi86/9Z6r3+X8+1aQmSg8KT1Qy1PIS3KP0y
 9ZRuXmHE/tgpX5grGCiFx3XoqW0+8K2bXsDAzyItRsBAAA=
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>, Mor Nagli <mor.nagli@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR4P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::11) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AM8PR04MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c133e7-5732-4f1d-4599-08dc6ce91eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|366007|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S01zS0R5RFlpR2xncStRZWRZdFhGdGYrU3J0dHVoeWczU0U5RmhpR01NaFVu?=
 =?utf-8?B?T0hubXlXbDd1OE9BR0k0bmJ4SXhkS3ZmbUQ4K3dZci83blhYTVJjR1pySmxN?=
 =?utf-8?B?WFVzNG80YU9FTVUxNXI0amY4K1BkNzFpSG1ETkxzczhDSEc1WDZoZzJWZDFK?=
 =?utf-8?B?eEJjeGJZY2luOVZ0RFc5RCtwM285VWdOdGpUUHlLdkZmTk1vZFAxZG52bjlW?=
 =?utf-8?B?ZDVzdWljVmxuUEUvT1Vra2RkQytoMk9rVk5RV3JlcTdvQ0c5Rno4YXZLMjBH?=
 =?utf-8?B?NXlqMi82NkN5aEZMN2JmeFY1UW5iZytUSEMzQmQwK2xIL0pMdHNycHU4OXRm?=
 =?utf-8?B?TjNQZERNK3hiUTY2SlQzVlIwUkJuTEFMZmlqZGYwNDQ5U0FpTWE2Y0pNZzV1?=
 =?utf-8?B?UXRXcm9Jdm1lQlkrK0kyV05SRXBZcnRyM0I1VVRjZ3d5QUYvWDM4NGNlZkpF?=
 =?utf-8?B?LzJzYy9KUFBxMURWT1BTcytFWmFwT0o0Zks3QS9PRDEwV3BJTnNrTHEwb2tw?=
 =?utf-8?B?ZzN5b2R6N0s4WHNyVDM0TXBocWExUlRadGRCVEY2cklOU1U2djdEbUl0cnVZ?=
 =?utf-8?B?Nm5kekVtM3lmTzNkN2lNSGw3VHdEMG5yYXlqa1p1M0dTb25nZkdEMHVYVkla?=
 =?utf-8?B?blhNTmR0U0d5aFhhbTB4K3ZYZFIxRzdqVmpaSkJDMURPazRCbFdlMjZMeWJw?=
 =?utf-8?B?OWxpb2IxTldnNEhXNXE0dzk0Z3JycUxjSTRFbHY1d01oQlh6RTFZeXJ6QlpC?=
 =?utf-8?B?NkR2cWp5ZS95bk00UURSRHJEUllKUE1kRk51bFBBR1Z1ZTJLSENvQUtCMzh4?=
 =?utf-8?B?UGV2VEp2NmZJR3F6NGpSVDE5dEZZTVQ4ZVNsQ0dTRFdwNWM2N0I2ZHZXK1Nw?=
 =?utf-8?B?ZE80Y0ZNc3VJWGRCdVJMVWU0NVF1eHpubVdEdkQ3OHdmVExKMnk2L1VsTGZo?=
 =?utf-8?B?UGZnR3kzQkJsanpJYjhRM2x0WENicWFxQ2d5ajFHZExGcUdiQzlzd09BSnNJ?=
 =?utf-8?B?QUprWjNUbndVaFpXeFc2NE5pRzcrODNtMXVSMXkzU25RR1pnUnhqejFyQ2dY?=
 =?utf-8?B?MDFMejhqdEFaYS9XV2FJMW9HaHkrSnA5Z3JLRGVQaEZMS01MRlA0bEtrdDlm?=
 =?utf-8?B?cStjb3llVFptVXR5UDVHQ2F0WitMS3o4MkJjcDUrOWo1a1U1UXlsNW1NeVhl?=
 =?utf-8?B?NEZLRjI3aXVYSVEvUjhpNlExd01EenZsNWY1QzNQdkVESVJwaHdVMUtyR3Nv?=
 =?utf-8?B?dVpEYVdhNFBCOHJHRGdUMVFWTkJ1Y1VXWU1mTm5EbWVxUW1vWkxXcFQyYThF?=
 =?utf-8?B?d0FONE0rMkVDRnB1dldqSHJhb0k5SWtYR1BlUjJqTG84VDFmUWo5VlBuSWlM?=
 =?utf-8?B?eGc0VlhxR2dnQWFLallrTnJUbnBGWUU4OGFVUUNvUDJMVFU5MXkxUC8zNkJM?=
 =?utf-8?B?YmM0TnVRV1FzTjBSdnJtUkcyTVgzMnRTbkZQVEtya3F1dE9yMkRGRVJKNWVP?=
 =?utf-8?B?c1BTc1V1SGVxbXgvcC9ib3BWc044U0FUM3Yvc0NGdS83aGdiZkZwWTF2Z1hR?=
 =?utf-8?B?b1AwMnh1VEl1bXpvWm43WTlkTDl5WThpREwxTERrTkZlRUhDZ3phSkpMVVBS?=
 =?utf-8?B?R05SQmNjZnVSOFU2em4wTzFMNXdYekZZWHdyMW1kc3NTQW9GUy95NGtRdXNH?=
 =?utf-8?B?dzBHZXNFNytaMGxTYmhzeVBaR1Vmd29sK0UvNnRyVTN4L1hKYmFiaW5nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(366007)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHJGV2tVdlBpZGRUaU1xUnZma3ZZMmpsMEVadlVnRHBNbSt5d0xPc0xmQ2M0?=
 =?utf-8?B?VlJ4NTFwN3JOeXhPaWtiNXNMUW1ZWmVkYS9nSE5rN2d5OUY4NFRjUWRMNjUw?=
 =?utf-8?B?b0YyV0hINENuTXhETVhUWlNCbGlnTFVVR1ZxcFJIdjRTMldDSjRCUnlZWkJY?=
 =?utf-8?B?dE85eWxoSEF6cUxheDNxTUhOamdmU1ltMGw2STZzMStRY1pneGtqWXpUbXE5?=
 =?utf-8?B?NzZla2VSN21TVFFiMElCc1paWkhKVk5QOG5lOHZLOWFUVlU4R3MwdlZNOWdp?=
 =?utf-8?B?MXg1YWovSXNJQ3JWNlh4dkorNytIdk13R3VrRXY4VTlLS3FKUlgzcC94ZHB6?=
 =?utf-8?B?bXRJQnZqbUVXWFphR0xqa1NhbGtsQUZSOW95b0liOUlaVUxiVnNsa1kvQXh5?=
 =?utf-8?B?ZTlkdDJQQjVRS2VOM25JejlQTzVRWDB3bU1lS3lHMkRDc0tVTGxDdGp6ckdO?=
 =?utf-8?B?bzlONjFzWTNWN2p1d2FkMTlXZTdhanhUMktRaDRnQ2JhRytNdC95UGp6OXlB?=
 =?utf-8?B?OUszVXQ4ZGRCV1dPKzI1Z1VuUm50Q3g5VlNJNjR4d3pIOXZZTkJJUlRGakJ1?=
 =?utf-8?B?Nzk4Tk1scGZHejBZOXZlWkttQ0poQkZWOERwTjlnWDN0N0JIVmoyd2FNS2pV?=
 =?utf-8?B?akk0bXg1TzBkazYwYkowK2RQWjlNdWR0WEdtUEcybWY3YjVpeTlUT0tTMGlu?=
 =?utf-8?B?cXFsQzFETVFNbFQ4S2NueURZMjRkTDBIRmpmdGd2ZDVOSWV1ei9yVkJxZUxl?=
 =?utf-8?B?cG9jSmw5bVgzeVV1VnBUTXZxenZxOEo5SmlFT0RTSjVVUFZHRVYySXgzV3Jl?=
 =?utf-8?B?TU94UCtxYStURm9jWnROQkJBU1JoZTMyUHppQjAxbHFYODJuMEcwbnAvc1Yv?=
 =?utf-8?B?M3c5Mi85MXJpdThSZFRMRmR0NmR2V2dKZHlWQWFCVGtVMnVIMTU5WnhQbUNt?=
 =?utf-8?B?UHRBQndRTzlLZkd6VmE2NDY3UGlBT3RiRzVuTEd0VkxETDNVOCtxN2JyZDFD?=
 =?utf-8?B?MWdjWmY1M0o0MjJaNlpwK2pSbnRmU3psdzVsZnBYZEhpS1NHQWp1UTYxcm91?=
 =?utf-8?B?Q0E3bmdEOStxRTFuUzlYVHBLbERFVGZqUkk5T1lrOERJSW1pTXYyRjFoZWJP?=
 =?utf-8?B?SW04b0Z3Q3Z1N3VIZ3JaakZEeENIb2NKL01hbk11bXhVelpTN21QVWlxTGlP?=
 =?utf-8?B?MU1PS0cvS0JqUzI2ZFBXNXJZUXVCR3ZhQXV6V21QalBSYzlnRGxRd3dqN3lo?=
 =?utf-8?B?RTQxU1BOR1QzYjNXd1R3a1Y5MEYzYXJMcWxBMG9TUThEemR5a3dTcGxDQ2JH?=
 =?utf-8?B?K01NRmVPVlpGaGFGNE1IM3dhRThjbU9KRUJYSmdtUkViN21DL1BJbk40b0Na?=
 =?utf-8?B?WXVieU56K2l4eWt6Y1FXZG5KSzc0OGN1SEJDWFZrRWRvRmFkMDZOQy85T3h1?=
 =?utf-8?B?c25IRWxxOHRjdThSLzJNVjhsR0pDcXlKRTV4Ulg3VE9GeG4rYTNmMEtrTW9E?=
 =?utf-8?B?SWNBaDZDc09CbjlHeWdxWjI0SG9vWldTVUd2Z2Fac21Jb3VlME9PWnZhemFl?=
 =?utf-8?B?RjhnSHluU1BsUGVybnovKzR0bmdrNmpXMkRjdWRMVHdGQ2RzT2tGUTgvSVpZ?=
 =?utf-8?B?bFoyWU1iVGVNM2Y0OW11KytvQ0ZnTm5XOEorTlRGcjZQOUFkdVd2VWlwaGJF?=
 =?utf-8?B?QU9Gck80dHVVb1h4QW11WTEzaTJNdU5XQ1JLU1VLdTZLUGF5RGVwRGlEM2FR?=
 =?utf-8?B?ZHViR1pOdDdCWXR4d0o5cktsNUIwTFNlNzY0WUtlTTZHQ0s2SFFRVTZ1VWQ4?=
 =?utf-8?B?NmpLYzVFeFkyTTZEUjZhaVpITkFGaGE2c3VKek82VFowSFRFSzg2OUxNd292?=
 =?utf-8?B?ZVNBS1dhOVBoR1hHK2JrSkJnVTN3b1U1YnRHbXpiZnB4dUk2NHVoRHVNZnVI?=
 =?utf-8?B?R0Q5VThEQlM5TDZhc0lLdWcrTkduNU1vTmFSY3hSU0Y4SW82SkxCM1Qrcm93?=
 =?utf-8?B?bDJJRjZZcTZzMjRhK2JUbHVCSFNjRWdCcnVlK1BXdVdYaUpQVFljb0t1NmZ6?=
 =?utf-8?B?VnpSRUlUQTBzSXR4MXE0TllsdEpEZFJoL1RHMm1mSk5aamdmdEFGdmJTQTZV?=
 =?utf-8?Q?BA1BXEl168R704sc2VKkkZJ3A?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c133e7-5732-4f1d-4599-08dc6ce91eb3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 09:52:47.9357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsHANZfP45pWRDC2KjSlPjci8RTuihxYfbqRkkmoKCnH/uejFCZgkXwJyuBcYPWOkSJ5VzlfUSayrp9sPk2oXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7331

mv88e6xxx supports multiple mdio buses as children, e.g. to model both
internal and external phys. If the child buses mdio ids are truncated,
they might collide with each other leading to an obscure error from
kobject_add.

The maximum length of bus id is currently defined as 61
(MII_BUS_ID_SIZE). Truncation can occur on platforms with long node
names and multiple levels before the parent bus on which the dsa switch
itself sits, e.g. CN9130 [1].

Compare the return value of snprintf against maximum bus-id length to
detect truncation. In that case write an incrementing marker to the end
to avoid name collisions.
This changes the problematic bus-ids mdio and mdio-external from [1]
to [2].

Truncation at the beginning was considered as a workaround, however that
is still subject to name collisions in sysfs where only the first
characters differ.

[1]
[    8.324631] mv88e6085 f212a200.mdio-mii:04: switch 0x1760 detected: Marvell 88E6176, revision 1
[    8.389516] mv88e6085 f212a200.mdio-mii:04: Truncated bus-id may collide.
[    8.592367] mv88e6085 f212a200.mdio-mii:04: Truncated bus-id may collide.
[    8.623593] sysfs: cannot create duplicate filename '/devices/platform/cp0/cp0:config-space@f2000000/f212a200.mdio/mdio_bus/f212a200.mdio-mii/f212a200.mdio-mii:04/mdio_bus/!cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdi'
[    8.785480] kobject: kobject_add_internal failed for !cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdi with -EEXIST, don't try to register things with the same name in the same directory.
[    8.936514] libphy: mii_bus /cp0/config-space@f2000000/mdio@12a200/ethernet-switch@4/mdi failed to register
[    8.946300] mdio_bus !cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdi: __mdiobus_register: -22
[    8.956003] mv88e6085 f212a200.mdio-mii:04: Cannot register MDIO bus (-22)
[    8.965329] mv88e6085: probe of f212a200.mdio-mii:04 failed with error -22

[2]
/devices/platform/cp0/cp0:config-space@f2000000/f212a200.mdio/mdio_bus/f212a200.mdio-mii/f212a200.mdio-mii:04/mdio_bus/!cp0!config-space@f2000000!mdio@12a200!ethernet-switch...!-0
/devices/platform/cp0/cp0:config-space@f2000000/f212a200.mdio/mdio_bus/f212a200.mdio-mii/f212a200.mdio-mii:04/mdio_bus/!cp0!config-space@f2000000!mdio@12a200!ethernet-switch...!-1

Signed-off-by: Josua Mayer <josua@solid-run.com>
---


Bcc: Mor Nagli <mor.nagli@solid-run.com>
---
Changes in v3:
- Added better named variable "len" for snprintf return value to improve
  readability
  (Reported-by: Andrew Lunn <andrew@lunn.ch>)
- Added short explanation why there are two calls of snprintf in comment
- Link to v2: https://lore.kernel.org/r/20240404-mv88e6xxx-truncate-busid-v2-1-69683f67008b@solid-run.com

Changes in v2:
- fixed typo in commit message
  (Reportby: Jiri Pirko <jiri@resnulli.us>)
- replaced warning message with controlled truncation
- Link to v1: https://lore.kernel.org/r/20240320-mv88e6xxx-truncate-busid-v1-1-cface50b2efb@solid-run.com
---
 drivers/net/dsa/mv88e6xxx/chip.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 964c7b847fd3..9c996be00362 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3774,10 +3774,10 @@ static int mv88e6xxx_mdio_register(struct mv88e6xxx_chip *chip,
 				   struct device_node *np,
 				   bool external)
 {
-	static int index;
+	static int index, trunc;
 	struct mv88e6xxx_mdio_bus *mdio_bus;
 	struct mii_bus *bus;
-	int err;
+	int err, len;
 
 	if (external) {
 		mv88e6xxx_reg_lock(chip);
@@ -3803,10 +3803,28 @@ static int mv88e6xxx_mdio_register(struct mv88e6xxx_chip *chip,
 
 	if (np) {
 		bus->name = np->full_name;
-		snprintf(bus->id, MII_BUS_ID_SIZE, "%pOF", np);
+		len = snprintf(bus->id, MII_BUS_ID_SIZE, "%pOF", np);
 	} else {
 		bus->name = "mv88e6xxx SMI";
-		snprintf(bus->id, MII_BUS_ID_SIZE, "mv88e6xxx-%d", index++);
+		len = snprintf(bus->id, MII_BUS_ID_SIZE, "mv88e6xxx-%d", index++);
+	}
+	if (len < 0) {
+		return len;
+	} else if (len >= MII_BUS_ID_SIZE) {
+		/* If generated bus id is truncated, names in sysfs
+		 * may collide.
+		 * Generate a special numeric suffix. If it fits
+		 * within MII_BUS_ID_SIZE, insert at the end to mark
+		 * truncation and avoid name collisions.
+		 */
+		len = snprintf(NULL, 0, "...!-%d", trunc);
+		if (len < 0)
+			return err;
+		else if (len >= MII_BUS_ID_SIZE)
+			return -ENOBUFS;
+
+		snprintf(bus->id + MII_BUS_ID_SIZE - err - 1,
+			 MII_BUS_ID_SIZE - err, "...!-%d", trunc++);
 	}
 
 	bus->read = mv88e6xxx_mdio_read;

---
base-commit: 173e7622ccb3f46834bd4176ed363f435e142942
change-id: 20240320-mv88e6xxx-truncate-busid-34a1d2769bbf

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


