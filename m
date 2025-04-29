Return-Path: <netdev+bounces-186766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDB7AA0F9E
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 16:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05B8A4A2D07
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 14:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB332192E5;
	Tue, 29 Apr 2025 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="l3UNLC7F"
X-Original-To: netdev@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010006.outbound.protection.outlook.com [52.103.72.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32E521930B;
	Tue, 29 Apr 2025 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938281; cv=fail; b=E9kUVlVBToKB2xGtYFh1GAYoU/Pl0xrHKno9Kn0qCHImIQq+2RaTh+I3cauu9D6/M7RN4OLbaPsTe2FdqQ6LMg5GIewXPv21PfENirRaLSGgYccNdq/P5wdORrlfbcpwbcER8P8ucgKN1dM9VQbtCy4HhdSaMMTtJE0KE/YujCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938281; c=relaxed/simple;
	bh=vELgHdl1W5JcahlZk50QVvtDwGLgATLbv1XFkleGooA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A8LQqpwLv6ASXi7fy2piPkXXukYkq2ZAugNfAgzz2om+Vwxj+7G1dhbfJ1juTM7CTp82sI9Oczso2A2aLs1ud3Q8nnV5c/KiMnrwVvi2E+DJ0mdFQv+V4byuaRJOz0oMccv7JZQO2YxXQFZVBn06kLUdjdsrdP6Cir9LYGC6j40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=l3UNLC7F; arc=fail smtp.client-ip=52.103.72.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3syIemaPBJjgXHmzXeGYbmdbOYewyDk3Ne2SQ7VN77YcAYjzA4xgy8cFIoRo9A9vwint9sh3f13m1u7n7qhA17UpPQR+eNYw2RqZlHBWmbjIBbt8z1+BU7zefJuPDeLXaVuEknvmibJQ1QM8Sz29yYwUj4PoDVcK5Ua+fREGNABBUeIkc4xt5d9fAcAwd8XYLkJEMxwvhJSCfIlEfuSHzE7SCwAyVYYyD8psYG4zlb+Zu7mBwXd/4xVc0C+dVaKI/Yln6Q4PK6tB0hKq/pn94YFRtMcgyZn4f7Q5BNCqt0s3bVYvrEg5G+Q8qx19GlfnVuj8HDLHJvOpLqJTnykUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7l2Exl8QwoNE2gVlUJGTk/Sqwtj6jJMreCn9ULd3mM=;
 b=aWZzh6aNXzKeRR4pJ0833w4L+HrmLn6ZamHG+b15QGe+NEoQhHmxAB4c734ptfoyHJk6EfCIXiOKGTdHvL7Sc/PbjsH1fd9XiD6P7MIi+zjiQM0wVsMN0ShYU8+xEJ415AdoN09No1aKbfWkfUfD3nagqwHOr1/pIqGOCW08LE2ezbmlKryWNCiz5gRK+NDhR5Mx55ngOWRiXDqp2/X5J77cJBlHng5Sm7XZrEO5qSu4bkrLNSkdynasVpY8cR0fqJZvBqZ3y9GJ9c/7B3FvQRIep+3LdAZps1GhC6bPZ6TS0wGkKnL6grj/qgnN28mEH/EdowV3d/zoJ/Oy8cvpKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7l2Exl8QwoNE2gVlUJGTk/Sqwtj6jJMreCn9ULd3mM=;
 b=l3UNLC7F1PMi3EzTp4ZmoRlgFxPlX4hTSTgF0/7dL1TBqa7GpuIqLn7gF6RzMyuLC1P5dNWMS8t/N+1PfdN7aRHI3+nrdJZoN3eLVN7Jd0NBm9EakKjKLdnSS+Z3lqmUq+A+Uvbi61uKDGIjWbhHj5sqdAoBZGEmXQ78QGS7w9BSs+vriu3lWUs7/14MsQLjsgvlDuYpBw420c80kqo1q9RL4Yy3WpQeMzGLtQHqI71H+1/X1ny35PciDZAkjSx8qkSmOmETrdJfLGB3F7L60OLLrfhZR5D/6yjvYYj92te2hPIUkpcL+KOz0RKzphMGzt80GacsyBkYKvAZlr3miw==
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:ff::9) by
 SY7P282MB3772.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1e3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.34; Tue, 29 Apr 2025 14:51:13 +0000
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165]) by MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165%5]) with mapi id 15.20.8678.033; Tue, 29 Apr 2025
 14:51:13 +0000
Message-ID:
 <MEYP282MB23127E549CA5B6DB023C62FEC6802@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
Date: Tue, 29 Apr 2025 22:51:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] docs: tproxy: fix code block style
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250427-tproxy-docs-fix-v1-1-988e94844ccb@outlook.com>
 <aA9kfiqQpbONuv6W@archie.me>
Content-Language: en-US
From: Levi Zim <rsworktech@outlook.com>
In-Reply-To: <aA9kfiqQpbONuv6W@archie.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:ff::9)
X-Microsoft-Original-Message-ID:
 <0956e716-cee4-44ff-91dc-1fefd3567650@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2312:EE_|SY7P282MB3772:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a9879ff-3879-41fc-748c-08dd872d4966
X-MS-Exchange-SLBlob-MailProps:
	bHQ38DpbEWCos0A2Q6z4vr+EGiiqRFMXe3i8cGIomhERgyADVfm6+o2aaA6IJe9GILEFWPzUCEnyAJuKM/jOel8n8h9ZZgUl2exoW6hqktgPr4HvH2IY5vO1M5YTndDS6T/8fiDsoQlfmAsj66w1FMrfbuvx0BNnOiK5sdgvRHXyV8jGQChzH6TwDbA4muxtCYUJ5aOzaYb4Rj7jNr20uxUlalwp4Yqxp9w8DgpysDXq9I36o6fgdKyktbwnUa6MvXPMBT7C15jSMJ785oWxAgvkAUelSNrAJNNtb5AJOAGh9jJaQjnIQdIhcFJJCrPL7OSZKUyEqKBhSvnTt8lQ7D33WlpUbINf0Jl4KrztVf8LhJBwUDvYnYgt0pNpqomQDXRJXQMe7r6rgsvmdYkqFNQxAfzReGllgJxPtZcHqhnfRXVkuS7yrQv65yMgCpTv63IzsDCS4lWAUZ4J3R4qDpg41FZ4UBaZ7GA6xboOOoU4Yi6qOlblahEFrVszJa7007Vs7ZSAV93Hmo6tRxswLXqVUjOVsu7byl0SFIBVGsbcs7Rt/LqwF0hNG/DZtq0PGRqHTJTK+nOdQofASbFlZQkwdQvH1fwEXPfVOJZi3WlTxGcoWIoKf2aiA+rmMCvdvltcb3KAW0idAjAh1g/JHEZah6b8SGadYhCX9F9JGPdSx2DcY5gCnQ==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|6090799003|461199028|5072599009|15080799006|7092599003|19110799003|3412199025|440099028|19111999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXNQWkU5L3lxY2pjNzhLaEVaSmp6ZFc0ZVpVYzdkT3dxTHNZU1FSMHVBaXE4?=
 =?utf-8?B?NklzZHl6aktlc2p2bTI2SllEWkM2TEpha0oxdDR3MXViQllzMTNKaGlVQUhk?=
 =?utf-8?B?Ny90V0RrV29TQTNJenY1cEg1QWdpcXRZL2JBMzNxTDd4c252S1R6L3l6TVR1?=
 =?utf-8?B?T0crWWROMXJGQ2tsYVY2Z2pqR1ZycTg2d3JlYlhld2dYakZqa1ZGMVRyS2or?=
 =?utf-8?B?OGRWV1Uzb2paWGEwaXlHeWVkUkRDdGZHajBzWlJqMTVyWGVKOFFjeFNPeXBP?=
 =?utf-8?B?UmJFUGxXeTkwT0Q1NXgzZlNmQjhuNEkra24wR01sNUJSVGxIMk1xWFZNTmFk?=
 =?utf-8?B?bVpaVU9mSFh1cUJNMmtaeTJpYlBzSzVTdVBOclRYNmRzM3dFcFdSU0pJZnRW?=
 =?utf-8?B?Z3pKaXBNalFUVkJLSWtqdDQ4RitPVWZHSFRZWjE0bElJdWlwckd1cUNGcW1z?=
 =?utf-8?B?amlGMi9ZcjZUbkREc1dPZWdWb0E1Wk9DWmtPZ21KdlM1M0FkaUhmQ0lJY3NW?=
 =?utf-8?B?anBBWUlMMkJNbEEyd3FlK0xCbDhvR1h4TE5DazlpRVZnMDYxSmlSRS9qRkVK?=
 =?utf-8?B?YzhhTGlwVXFPbXN0Mm1hejJiblVFVE8wVzVZbXIrVXpIT2ZQanRYa2dXS2Vy?=
 =?utf-8?B?WTNiMEc3b1pqdXVJODJzb2hQakRtdldWTEhOZkszMnRoY2wzcytqSEZtTUlT?=
 =?utf-8?B?dk9RNzNwaWlRMXVKd2J0Sk1pN1NsNmwyS1dhNENIcmVwSExpNFQ3OFl1Um1v?=
 =?utf-8?B?YnRrUFdiMjkwaFlOS1BKM2YxQkZ3MFB0MEIveWxldlNiOWhITHNhY2FkU1BS?=
 =?utf-8?B?MUlNLzg3dmw5cVlJK0xFVnZZSklTZzQ0bmJGTEFjVHZ0YVB2bmROU29yTzNS?=
 =?utf-8?B?Y0NsUXB6MG5aQldtQzZZay8rNXlaemRSVkRQWmRGdlBYMFJ5ZlFpSjdveWZq?=
 =?utf-8?B?TjhDSjJZV3hlN1ZnRTA5c1VZRjhvSnlFZStrVzBlK2Qwd081NnNHR2FNMzlw?=
 =?utf-8?B?cnNZR2x4ak1SeS9tWURBTWpLN0FsTUFwQW1CeisweWd1aWtIdTVackgwQkZQ?=
 =?utf-8?B?MkpFK0ZGYUNYVFIyaFdRMnBrOGR2NmIwd1hFcUNpYmEwdDhkMEZVRGZtOVFG?=
 =?utf-8?B?UUErOUIrejVPbWRnQTlaU0VqN25sMnZKUGVnNGZQNzAxRmZkaHloRW95bjh2?=
 =?utf-8?B?cmpyZ3ZyZUNDcWxjaVltYjRzVmptcldSaURlSTBtYmtxUHBveElPbmNWbkEv?=
 =?utf-8?B?L0srTk1BeFAxWUJQZWxZVnlSbERZemZtYmNYTk5kUGxDNzEyQTh6R2ZNQ0Vw?=
 =?utf-8?B?aGZla0gySlpTUjcwdUpyZGNhWi9nVTU4R1YzRW1sVVBLa2g2OTB3Q3Zybkg4?=
 =?utf-8?B?YXludnc1Zm16M0lwNGtXcDFZTE9rdm93eVRsS3pDNXN5c1Q2QTAxMW9mMjFS?=
 =?utf-8?B?aUF3Ui9WQ2E5MG1SVzJZem9xdG1vMUJvcEI1TEROTjdkSTAvemdjU3lLUVhJ?=
 =?utf-8?B?emZGRGJVZENOUi9tYml6NmRTZGtpeEd5OTNIUjdGZUJhSUVSeWtLRHQ1K0E3?=
 =?utf-8?Q?erULf7n4FlnwuedaIa9rqBJqM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmZUTU96Z1JERWdPSzZ6bGJEY0VyRTlhbkZoZytGK3loQ0MvaWUxQUl3ZEtm?=
 =?utf-8?B?eFQvMElJbHV2VDVFODdrZHcvbnVJU3BoK0VxRlBvU0llb2lEajEzTnpZQkhQ?=
 =?utf-8?B?RExYQ05mWTcyUFpNNUNaSjg2c1ovMUdWRGRwMkZKRVNDOW9CMG5SVHVsaGxE?=
 =?utf-8?B?Y2RHZ3ZQN1FYS09KSGhPNEE4cmhGL1JrYTZpSVBxVkZGTi8ybk45L3FTeWNp?=
 =?utf-8?B?Q291dG1ML2c3WVpzSmpuYzEwcVh0L1FkbThhOGZkaURuRjVJc1g1MkJ5Qklw?=
 =?utf-8?B?MEtBUGh5eXF5Y2FHamhhSmVDanlEQ0lsRnZmblBXcTRhVjBPc2kvaVN0R29U?=
 =?utf-8?B?ZEhldmhCMEhKa01YT2MwcEY2NUtsbzEyc1lybzBpUzhmbmFkZys1STVtWlpU?=
 =?utf-8?B?SElPUElWaTFZY2dEd2gwTlZGdU91WGhvSVlKVHhyWE1IK1Z0Z292Z0lvem50?=
 =?utf-8?B?aTFwb08yM2VRVzluS0o3aWEyQjF0SHRxM1A2QW5zSHk0MDJYVlhFMFdRUWpK?=
 =?utf-8?B?cFBQUll2Z0tzQ24rNnVMVU96aloxajlZbU5MZ1ZhSThIc2IwTjc0QlFQY2tr?=
 =?utf-8?B?dkxIb01KQWIzNFdjNHNMZmE1T2Q1eWNpZ2Z2cy82SDQ0blM0bi9JYVFleGh1?=
 =?utf-8?B?NWpiRzJLZkFUQ3gvVkdwdVFpRHNUVHcwOHFzUW10SW1qM3FCdVJJUU9HcXcy?=
 =?utf-8?B?TlhwZ1JYV0JVTSszclFJdVJXZTZqUm1FUFdQbGhTUDVRWHdKY1FhTnZkSlk5?=
 =?utf-8?B?YysvL3J1bWQyNXFqd3FBSWtVTVNSSUtyZXhodk93cXdsMmRFMDUrUmROMkYr?=
 =?utf-8?B?dUtzUDRBSS94VmFCaDV0aUE4MDFDcDdSNGhNQlNJWHRISEZvRThQc0pSeDYw?=
 =?utf-8?B?dzN0a1VwYWU4aEhHcGwrbkJDR2J5dW1uTDYwWVNRUEJ2V2lTYUd2UTZxdUJQ?=
 =?utf-8?B?OWtYTlBRZmZKWjROWmlkVkF5QXd3RzBWbFpSNFZEdEswUkQ2SVIycUwvbUdu?=
 =?utf-8?B?OWMvTEE5Ly9sQ3FSUk1NbmZmYmhZNmttdnJuQTFJSWV1L0xYZ2xVWWxnWjBm?=
 =?utf-8?B?b09vSnJFYXRQTHNzOER4T1RkTzRORFBOdEpGY01iZVNNUXJTM0Q3ZVRMeHNz?=
 =?utf-8?B?a3ZzRFgzQnlFdTJoeTNjSDJjYkd6REU5RSs3cUd5K0J3NXJ2S2ZZNHRuVjlZ?=
 =?utf-8?B?K2xuWEhqNU5vdGp4dkpkeVgzbTczMUxrbHlxWlpWU2s1UWNKWHIvZTMzanh3?=
 =?utf-8?B?WnhmNGE1amxnQ1JLcTQ5WE1oMWUwT1oyVStEMis0dW5UY2Z0Rk80SGFMZUEz?=
 =?utf-8?B?M2JKS3gzZGhMdm9YUUxTaXZqR2xRS0h0c1Vrd0lFRWFiRE1OR0JBY0N4Sml1?=
 =?utf-8?B?eHVGby80cDkzZmJhdlFKUjA3ZlduaWMzSmJjYmJPZXBDZm1KWjh4UnBSeDNH?=
 =?utf-8?B?ekRjN2NRcXlYYzY2aTZJYldZUk95VFY0VE1URk5OMjlmck1ZaGR2UjRUSmxB?=
 =?utf-8?B?L2krWWM5V1BIR05tMWo4cmk4UXFmc0ZmaU1DeElSNVhyWC9iR3MyOWVTUWRv?=
 =?utf-8?B?MG8zMEFIZU4xN1p2R282ZmttOWorVnZtRnBYTUV3Z1RhTTVrdC8rOUdKZGVu?=
 =?utf-8?B?SWhWWk5tMHB6Y2xaaUtJaGEyN0xmWFFEdUZZNWZmRkdIbjRpbWxvdU1xWFVq?=
 =?utf-8?B?L2VLcHRjdUxVN25ZRENHYVA5bG9jdm52aG9uSWgzVjhhR2RhSlB4aTRZemxH?=
 =?utf-8?Q?bUv6tewH/G2z19F9Dc=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9879ff-3879-41fc-748c-08dd872d4966
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 14:51:13.4679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB3772

On 2025-04-28 19:20, Bagas Sanjaya wrote:
> On Sun, Apr 27, 2025 at 10:36:59PM +0800, Levi Zim via B4 Relay wrote:
>>   Or the following rule to nft:
>>   
>> -# nft add rule filter divert tcp dport 80 tproxy to :50080 meta mark set 1 accept
>> +    # nft add rule filter divert tcp dport 80 tproxy to :50080 meta mark set 1 accept
> Use double-colon syntax instead to wrap the rule above in literal code block
> like in other rules.

Nice catch! I forgot to add that. Fixed in v2.

>
> Thanks.
>

