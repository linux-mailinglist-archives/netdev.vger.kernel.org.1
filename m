Return-Path: <netdev+bounces-104668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1860290DEBC
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 23:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69308B21124
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 21:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871201849F5;
	Tue, 18 Jun 2024 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o5/IoS0Q"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2052.outbound.protection.outlook.com [40.107.104.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CB518132A;
	Tue, 18 Jun 2024 21:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718747653; cv=fail; b=V68cZ9T46H5Rv4dX2YOoe6WyJip6hEWxsHsQ03UhiDSJblKUZug6s625n8Cx0XNDZO9OJvXPhV2Mccl70cuhIMNBr2aa8+1jXo2jINA4QRKAzV496GWc34qiVjqMeG/ct2srbeAj0O3bs/9ZjC9dGEP6lG3Di3XJuRkt9jd3vUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718747653; c=relaxed/simple;
	bh=abo+MUVwkKRR6dHBg2WgaO9RCXmChWxUJEuw6Ak7SNk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=A/8U3ne8uNIPIMmpml5VlBV/XD+Aho6fQ7f8CbL5aDlPW6zjIfc9wgim/GkpHcH2KNEBa3i+GvW5IVSEx3o14xuqr7sRx6pFH3zAkWWCaHZGOYrEc9TwKW78SasDteE0qGZ+hX2qtUKVR+c558iaYUfK9TO1JpuvjqDCULBfcBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=o5/IoS0Q; arc=fail smtp.client-ip=40.107.104.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moC/vmC2m8IOKefY/OeMMWI1T4Dn9JEXX939BRfFTO+ArN8ltvh+3DFK5UPOZbNmtC8uj5u2OJ1T12VqgERUXm95sDP9/2VfpgGQuGb1fM3oupL6goXvBIHLm9HHfqdwQqF6q5GIG4S8T18Q7R8WvMx3bbpJ2NdJdxhncADjksuTHoRjCmkjexWoGol6zlt2D1gA82sGMFoeeyib1BvXpbv7AxdpSlN0+Hs59Y2Xbb7qcSJlFFKtoOgbqHtXXKTuqvV+CB3BlqiAFdYPWrGx3REYjvlKJRfYPqDFt+SWGcT2/ywhtbkTq+W5fBNCuhfAKCOX6cE5MsswpGhyUqZNww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Et/p67L8qMIH4ON162KTMkq8a3LQ0DB2quHoS/kS0jU=;
 b=i1ayhip0UdXJIWD0HQMy0UJSbUp1RR+TZkVNcSOjGCf0JSbDiO9aG04cV21FdnpmMTcUqTIY7L9Hw0aecphzoOd1ucf7Zfc9IaB9pvIPUe2MsPvllogGzl6HpeiwRenLeaJi1zKqAx2dNNjOiMY4yAtVTVpDQb3G5aUNyCorc9QpDca6zsDrL4VBNKXx6STVrM3Br876XBppPfkgKkoPionl9zUq0lFXOTH31UJxYzEFXkuBz8QnpcGr4M4GsAMxEUMfhEbkPdoDlnALP2oFQ5JoDU52QaKJMJwvROzitD6yJzh46n7W4gV8w9QHKu+WYRSnd+pwyhgVu71wVcsyFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Et/p67L8qMIH4ON162KTMkq8a3LQ0DB2quHoS/kS0jU=;
 b=o5/IoS0QmIozbanxWoMUfmkqZyRpY63Z0E8YZVMizhA35h0U4eAHJRLpg5mwCMbBDeiVUeDTFih8dppqUr4HdWKyfuOL+rE5/wWuLJJVACgcr1IWeY6ilFybaTzn4bomJE1y1BvvoQ0Wlgtf90ZJDv376AMve4u5DP7m4iR/NmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB11008.eurprd04.prod.outlook.com (2603:10a6:10:58d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 21:54:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 21:54:07 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 18 Jun 2024 17:53:45 -0400
Subject: [PATCH v2 1/2] dt-bindings: ptp: Convert ptp-qoirq to yaml format
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-ls_fman-v2-1-f00a82623d8e@nxp.com>
References: <20240618-ls_fman-v2-0-f00a82623d8e@nxp.com>
In-Reply-To: <20240618-ls_fman-v2-0-f00a82623d8e@nxp.com>
To: Yangbo Lu <yangbo.lu@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Madalin Bucur <madalin.bucur@nxp.com>, 
 Sean Anderson <sean.anderson@seco.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718747639; l=11915;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=abo+MUVwkKRR6dHBg2WgaO9RCXmChWxUJEuw6Ak7SNk=;
 b=boQgyJ+zwULcykc7XkyHKUo4xymb+Mw/tVt6CDso629udYus8/ngfSej5g8jSNJU+Lk9VvrCq
 mhl/p5fUd8TA4aoUlAhqRpKbdklD8aPkYrhxL32O/OkS+zj1ehEnDXh
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0004.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB11008:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c5f9cc9-17bc-4764-63f9-08dc8fe12d44
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230037|366013|376011|52116011|1800799021|7416011|921017|38350700011;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZVFPSGRnNjMwNFpKWUplRVJWRGV2YWJPMUxJbDNLbUxFakRLV1dFbVV3SkZE?=
 =?utf-8?B?WmlCMWxNK1JZUmEvTUllR2tjLzZON2c5ci9MUkFYNlNDMDdlNWJKL1B2cjkr?=
 =?utf-8?B?OVduTng5bTBwYURod251bHJCd2ZkRnV1WEFqUE1WczBpc2ZBSXM4STZXclpD?=
 =?utf-8?B?dGVwVy9Cb0Rsdmh5V0xrOTQyUjh1MHo4cVpMSmw5RlZRa3k3NDZOZXFCZ0dN?=
 =?utf-8?B?TDNQbE1yNUFmWVkyQWZYTGlhQlVZeHBhNzFBbURZZUNTKytnYlRrdG9hZklS?=
 =?utf-8?B?a051Y1FobS9zZGcvRzZhcjlEOFpGNTVhRXRweUNnbS9PWHBQK3Z5SGkzcGxs?=
 =?utf-8?B?U1JDeGpDYWg3R1BUUnh5bDZ5WEhHcE1RYktkRXhPNEZJZk9HcUU2UWZlTGhF?=
 =?utf-8?B?b0ppb0o0cTdCZjB1NEpTQjI4YjAvVnRZaXNnQ3l5L0dvc0ppOE9OMndoTVl0?=
 =?utf-8?B?MmZLU2JNMlU1Y3BqczROZGxOOHRZdi9Tc2t6Z2lLbHlWdjgyMis0NUFRZXRZ?=
 =?utf-8?B?RDc4NTBXbTZ0blB1cmt6U0pIdy96MHhzM0VtSzIzZzFvMGVnR1ZWOXg0SzE1?=
 =?utf-8?B?RU1rRG1yZDNlOGhBUXkyQkhhQjJ5VkRlUFFJaFFjQ0RPZHIvRXJoTHQ0M1Rv?=
 =?utf-8?B?SDh5Y0lPQ1I0WUduL2tnRmZmYnZ1SUxqV2ZlM3c5QjVzSDdEcjhaeUFLQ3Fa?=
 =?utf-8?B?L0ltbEdla2JnbWRCaTc2RExRQUkxN2g5bjdtZi80YU1tRmFlbU5NVGI0RWhh?=
 =?utf-8?B?TnI2Wnpmcnc4Wm9YNzc3RW15N2RLVUNLeU81c2p0RmtRM215dnY4ZUpiMGMz?=
 =?utf-8?B?azNJWnlNM0tOZDhrbVJMQ09HMlBjcDZtbHNvM0xUK1pQdWxOOXRFcmZ5OTNu?=
 =?utf-8?B?OUppbnZpV3pQdG9NVkFzQnN2aWxOUkwxbDdHbGFVZzJqeFlwZTRoTmF3eFJa?=
 =?utf-8?B?cVV4SVRuTzBYSUpkWUtrS3NpbjJ2RHA1ekQ1THpybVNNUmtSSktSWnZITGl6?=
 =?utf-8?B?bjQxUHJCQjV4RHlLM0tmUklGeTJiekd2dE5LZzhzcWtZaUZsUlFRMm5Va1hB?=
 =?utf-8?B?VDNUYnY0SzM2WS9iRmYyOFA4VmVlREt1eFM3S1I5MDhwb1RMMDJMeS9uTXFX?=
 =?utf-8?B?TVZqNFZndGI2QkVFMXNJNUlmVHEzbHZCQ0IvWk40Rkh1a2E4elNGMDRXaFln?=
 =?utf-8?B?K1pKQlorTzV4d2ZQK0l3OWtReTErS015dUFscDVTdFZkTFZod21QUVFvNnQv?=
 =?utf-8?B?TVJqSDJqbVBySDdEenF4TXZ1MVl4OHhjWWFFTTE0QkFySmJkeHgzeXRYSXVk?=
 =?utf-8?B?Rm1CV0NRZHJ0WGsxdWlQQTE1MUorWTJxakYvVzVaandwbEticU84cDRVMmZU?=
 =?utf-8?B?cXo3Rktwa2FPUEdaOGtMc0R6bmVORzBZbmhvOHR1N3pwRWJGbEdlUU9BRFdB?=
 =?utf-8?B?cTRmdWpjNVE5YkkvNWx2ZGpkdStoUVUvbXpMeUJlWVZpTE51NXBIZUVIOEQz?=
 =?utf-8?B?M0FZRWF6VU1YdzFTMFVXQ2Q5aEM0a3NjN3ZxUktFaVJMSHhSU2ZjUitBVDhj?=
 =?utf-8?B?RU9UVnhTUjJwSmlJVnIzU2J3ckphaWZTakdrWUxJREVoNURnYTZDbDh0djhI?=
 =?utf-8?B?bUdOM0w4UURGczNBaFNtTDdjYmxIdTJvTWl4VUhLQVlBV29GTDBJZzdvM0Iv?=
 =?utf-8?B?OUxKYTV0MnpRRDFhMVlzbGY2SHFQWitPNUUvQjZDSjlxOHZ6VTc4UDVieDJy?=
 =?utf-8?Q?m2AKMV5+8aq2ud48Yqrwz5JwWXBseT4aWombTCI?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(52116011)(1800799021)(7416011)(921017)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NmZqWkYyYWUzOUw0SGxRcjBKb05sdU9Fc0tNVmloZlh5RWZwUkNjQWZ3VU9G?=
 =?utf-8?B?N3BhRVZ4UVBFVFFZN3RzVTdCL0M4NmNpTXJ4MVJtR28ySUNKWnY1N2R6RUZV?=
 =?utf-8?B?TWZvOUFoT05ud3kwcGlyQUhUQWt1Z3JsdWl1YTdOM2ttcHJyNnBvVlovY2Zy?=
 =?utf-8?B?b3VQd3RISmRRT2t2d2Zxb1NIYW1NSFFCUGV6bDkyQU5tOFhDR0JWNCtvYURS?=
 =?utf-8?B?QWtpdGVlLzJzYWpYMEU3S2NZSzI2RHVJYk00dWtBakpCZTJvL3N0NWZLcEk0?=
 =?utf-8?B?V1lGdENZUlpUdEphNDF4YWdTeGJqSXBTTDhOUDZTZnRjelhGWWdiUUNaVURj?=
 =?utf-8?B?SncvdjUzUXBZQ3JnL3hFSmp1R0Q1WW44VVY3cStRc0o2Nm5iUDJNQVllT09V?=
 =?utf-8?B?S2QrTXY4ZEZSRkJib0FoMGRiVThQczFud0U0RWlzYmVmUGlzM29wV0YvaEx1?=
 =?utf-8?B?MXUzSHBsUXRVMGFDNmx3SlZRTEI0YlhUa0FSRFkzQWI4ZW9qVWFmWjdleVgw?=
 =?utf-8?B?NGVzR0hEbHRTWXB1K1BQTzlsYnpjUjA3TzJ0QnRXa0hoMDhxd0RSTTI0K3dX?=
 =?utf-8?B?ZUFjdytibUFnZEpwbzhiaElTN2ZmdEYzYlduTW1lb2NmWCtRVExFM09NVVpy?=
 =?utf-8?B?bngreEdhTWN3MjU0THlkdzhhTGhULzgwTjZJc0h0REUvdjJhNi9yUUhMbGNN?=
 =?utf-8?B?V3BHRHhkNVhmRnZpZ0x2cG1MUThsT0RyY3l4N3kvaGJlYzRWcWpGS3h3cTlr?=
 =?utf-8?B?SmJKTWxQYzh0NzZPd1p2T0JYVGNJTkhHbm5NYlFVN0I3c0xldHl6SWRHakJC?=
 =?utf-8?B?TG5JWkhaV21UaDVFNkNER29MenpDdGVwajlOOEJybUxaQmhTWmFURVlQTDdt?=
 =?utf-8?B?emh1NzlVOHNhbDM3clFXYlpzNzEwYnNyT3E3d0ZJeCtKWHZkdk9lcFpPZERD?=
 =?utf-8?B?enFJcjJTdkQzWUhkajA2R2NheHhIUTkzd3lBT1lIcXU3blN4QVRsR3BvYXho?=
 =?utf-8?B?cG9icFRvUGVsRWw5VUJRNks0L1pEY0FjQWhLY1JiMTJQNDBxOE9nMDJoaUdD?=
 =?utf-8?B?bnBTZWFQc0hvK3pGcktMaU42RDA5MkpwVUhBbTFsWGRPTGJ6V0RTRmtTQWJh?=
 =?utf-8?B?Y3U2TGJNaTVhYkd5cHlIUEZRV00rV2VaTlFFTzcvQi9OMU1vN1YzQlQwSFZT?=
 =?utf-8?B?R0FtOWJ2Tnc2dGdyTCsxMlBZWUF6TEVjSGFib0tyMEdaTXpDZnkwc01uSSts?=
 =?utf-8?B?NUNTcjltN0Q0Q3B1K3ZiS2gwNmFFSzFGUUNLamxTYWJzV1lEVzB0QUk1dnEv?=
 =?utf-8?B?TldZeHdDYTZySGc1V3dSOTlIUW1aRHp4dGJucXduYXVpNHk2ZTlkREpHV1ls?=
 =?utf-8?B?WlBRUlZzZjFjOFR0aWFXY1VzMDN6L1NuTWZQRnBaTzJweWxiem1DTTNBNE1p?=
 =?utf-8?B?MFdpczd5VVA5bTl0eDgyenhEdmpacXdtbHRXMFJESmNyNTZQZml3UVoyU212?=
 =?utf-8?B?SmhzVWlRQXFaTE1XM2VzLzJ5TzJqWnJuc0RHTUVOK1pmbkJENGxHdUw3bGxI?=
 =?utf-8?B?WEI0cHMxYVoweS9tWDVxOUFxNkRFUktwSVhPN2ViTmN3U2RFMVFCR3J5b0NO?=
 =?utf-8?B?Z2VabXBqb1ZKemdrbHVEZXNjNTJuK0pieXorYTlMSlNFaXpCdW52ZGlEYnZ4?=
 =?utf-8?B?Z1BCMk85VFRYb2tNeVhaQmpwRzBmSklsRlJ6ODc5RmpNZnZNTnB3Zm5SVjBt?=
 =?utf-8?B?eHorMmswUHh1enBPc3VRMEs5ZUtUWXRWMkxmY0pGL2FHU0RaYTNZcWNMYlhI?=
 =?utf-8?B?dTZjdWYzZFdKRml0OXdGU1d4YjJmUStSUHdxUXV3dW43dFdLMmxobFVsNS9F?=
 =?utf-8?B?SWFYVVYrRFV0Q1RiVVAxdDFkd0RqbEtMWHQydHdHeWcyelRJSFVNM1FwTG15?=
 =?utf-8?B?RlNCMnloZHZtUFh0Y0hYMUlhL2NaL3JnOHlibEFhbUs1R3FGZ2tQcHd6WjRx?=
 =?utf-8?B?aGpqaWxrSGFFemNMTWNPYTU4dGgrMldCblBvUEdiY0V4S2lIWGJQZ05SemYy?=
 =?utf-8?B?TURZMkxrM3BLaWVxSHFnSUptY0NVaFd3eWVEcXlBOUllU25RZGovNUVldmMw?=
 =?utf-8?Q?EUNUD27/M3JVh0L8EtV64j6KJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5f9cc9-17bc-4764-63f9-08dc8fe12d44
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 21:54:07.1105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8KqMa6bV8M0pUwLC2IWWKA2uLm+I2JrkOvN4m+pRvapCGKoZYOeKEMHS/iZwsql29q5X3eiCIDL+zl70vYa/AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11008

Convert ptp-qoirq from txt to yaml format.

Additional change:
- Fixed example interrupts proptery. Need only 1 irq by check MPC8313 spec.
- Move Reference clock context under clk,sel.
- Interrupts is not required property.
- Use low case for hex value.
- Check reference manual of MPC8313, p1010 and so on, which dts use more
than 1 irqs. Only 1 irq for each ptp device. Check driver code
(drivers/ptp/ptp_qoriq.c) and only 1 irq used. So original description is
wrong.
- Remove comments for compatible string.

Signed-off-by: Frank Li <Frank.Li@nxp.com>

---
Change from v1 to v2:
- fix make refcheckdocs warning
- Use low case for hex value
- Remove comments for compatible string.
- Only 1 irq
---
 Documentation/devicetree/bindings/net/fsl-fman.txt |   2 +-
 .../devicetree/bindings/net/fsl-tsec-phy.txt       |   2 +-
 Documentation/devicetree/bindings/ptp/fsl,ptp.yaml | 144 +++++++++++++++++++++
 .../devicetree/bindings/ptp/ptp-qoriq.txt          |  87 -------------
 MAINTAINERS                                        |   2 +-
 5 files changed, 147 insertions(+), 90 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl-fman.txt b/Documentation/devicetree/bindings/net/fsl-fman.txt
index bda4b41af0748..5e02b4b286f67 100644
--- a/Documentation/devicetree/bindings/net/fsl-fman.txt
+++ b/Documentation/devicetree/bindings/net/fsl-fman.txt
@@ -237,7 +237,7 @@ Refer to Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml
 ============================================================================
 FMan IEEE 1588 Node
 
-Refer to Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
+Refer to Documentation/devicetree/bindings/ptp/fsl,ptp.yaml
 
 =============================================================================
 FMan MDIO Node
diff --git a/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt b/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
index 047bdf7bdd2fa..9c9668c1b6a24 100644
--- a/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
+++ b/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
@@ -86,4 +86,4 @@ Example:
 
 * Gianfar PTP clock nodes
 
-Refer to Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
+Refer to Documentation/devicetree/bindings/ptp/fsl,ptp.yaml
diff --git a/Documentation/devicetree/bindings/ptp/fsl,ptp.yaml b/Documentation/devicetree/bindings/ptp/fsl,ptp.yaml
new file mode 100644
index 0000000000000..3bb8615e3e919
--- /dev/null
+++ b/Documentation/devicetree/bindings/ptp/fsl,ptp.yaml
@@ -0,0 +1,144 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ptp/fsl,ptp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale QorIQ 1588 timer based PTP clock
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - fsl,etsec-ptp
+      - fsl,fman-ptp-timer
+      - fsl,dpaa2-ptp
+      - fsl,enetc-ptp
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  fsl,cksel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Timer reference clock source.
+
+      Reference clock source is determined by the value, which is holded
+      in CKSEL bits in TMR_CTRL register. "fsl,cksel" property keeps the
+      value, which will be directly written in those bits, that is why,
+      according to reference manual, the next clock sources can be used:
+
+      For eTSEC,
+      <0> - external high precision timer reference clock (TSEC_TMR_CLK
+            input is used for this purpose);
+      <1> - eTSEC system clock;
+      <2> - eTSEC1 transmit clock;
+      <3> - RTC clock input.
+
+      For DPAA FMan,
+      <0> - external high precision timer reference clock (TMR_1588_CLK)
+      <1> - MAC system clock (1/2 FMan clock)
+      <2> - reserved
+      <3> - RTC clock oscillator
+
+  fsl,tclk-period:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Timer reference clock period in nanoseconds.
+
+  fsl,tmr-prsc:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Prescaler, divides the output clock.
+
+  fsl,tmr-add:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Frequency compensation value.
+
+  fsl,tmr-fiper1:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Fixed interval period pulse generator.
+
+  fsl,tmr-fiper2:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Fixed interval period pulse generator.
+
+  fsl,tmr-fiper3:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Fixed interval period pulse generator.
+      Supported only on DPAA2 and ENETC hardware.
+
+  fsl,max-adj:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Maximum frequency adjustment in parts per billion.
+
+      These properties set the operational parameters for the PTP
+      clock. You must choose these carefully for the clock to work right.
+      Here is how to figure good values:
+
+      TimerOsc     = selected reference clock   MHz
+      tclk_period  = desired clock period       nanoseconds
+      NominalFreq  = 1000 / tclk_period         MHz
+      FreqDivRatio = TimerOsc / NominalFreq     (must be greater that 1.0)
+      tmr_add      = ceil(2^32 / FreqDivRatio)
+      OutputClock  = NominalFreq / tmr_prsc     MHz
+      PulseWidth   = 1 / OutputClock            microseconds
+      FiperFreq1   = desired frequency in Hz
+      FiperDiv1    = 1000000 * OutputClock / FiperFreq1
+      tmr_fiper1   = tmr_prsc * tclk_period * FiperDiv1 - tclk_period
+      max_adj      = 1000000000 * (FreqDivRatio - 1.0) - 1
+
+      The calculation for tmr_fiper2 is the same as for tmr_fiper1. The
+      driver expects that tmr_fiper1 will be correctly set to produce a 1
+      Pulse Per Second (PPS) signal, since this will be offered to the PPS
+      subsystem to synchronize the Linux clock.
+
+      When this attribute is not used, the IEEE 1588 timer reference clock
+      will use the eTSEC system clock (for Gianfar) or the MAC system
+      clock (for DPAA).
+
+  fsl,extts-fifo:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The presence of this property indicates hardware
+      support for the external trigger stamp FIFO
+
+  little-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The presence of this property indicates the 1588 timer
+      support for the external trigger stamp FIFO.
+      IP block is little-endian mode. The default endian mode
+      is big-endian.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    phc@24e00 {
+        compatible = "fsl,etsec-ptp";
+        reg = <0x24e00 0xb0>;
+        interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+        interrupt-parent = <&ipic>;
+        fsl,cksel       = <1>;
+        fsl,tclk-period = <10>;
+        fsl,tmr-prsc    = <100>;
+        fsl,tmr-add     = <0x999999a4>;
+        fsl,tmr-fiper1  = <0x3b9ac9f6>;
+        fsl,tmr-fiper2  = <0x00018696>;
+        fsl,max-adj     = <659999998>;
+    };
diff --git a/Documentation/devicetree/bindings/ptp/ptp-qoriq.txt b/Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
deleted file mode 100644
index 743eda754e65c..0000000000000
--- a/Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
+++ /dev/null
@@ -1,87 +0,0 @@
-* Freescale QorIQ 1588 timer based PTP clock
-
-General Properties:
-
-  - compatible   Should be "fsl,etsec-ptp" for eTSEC
-                 Should be "fsl,fman-ptp-timer" for DPAA FMan
-                 Should be "fsl,dpaa2-ptp" for DPAA2
-                 Should be "fsl,enetc-ptp" for ENETC
-  - reg          Offset and length of the register set for the device
-  - interrupts   There should be at least two interrupts. Some devices
-                 have as many as four PTP related interrupts.
-
-Clock Properties:
-
-  - fsl,cksel        Timer reference clock source.
-  - fsl,tclk-period  Timer reference clock period in nanoseconds.
-  - fsl,tmr-prsc     Prescaler, divides the output clock.
-  - fsl,tmr-add      Frequency compensation value.
-  - fsl,tmr-fiper1   Fixed interval period pulse generator.
-  - fsl,tmr-fiper2   Fixed interval period pulse generator.
-  - fsl,tmr-fiper3   Fixed interval period pulse generator.
-                     Supported only on DPAA2 and ENETC hardware.
-  - fsl,max-adj      Maximum frequency adjustment in parts per billion.
-  - fsl,extts-fifo   The presence of this property indicates hardware
-		     support for the external trigger stamp FIFO.
-  - little-endian    The presence of this property indicates the 1588 timer
-		     IP block is little-endian mode. The default endian mode
-		     is big-endian.
-
-  These properties set the operational parameters for the PTP
-  clock. You must choose these carefully for the clock to work right.
-  Here is how to figure good values:
-
-  TimerOsc     = selected reference clock   MHz
-  tclk_period  = desired clock period       nanoseconds
-  NominalFreq  = 1000 / tclk_period         MHz
-  FreqDivRatio = TimerOsc / NominalFreq     (must be greater that 1.0)
-  tmr_add      = ceil(2^32 / FreqDivRatio)
-  OutputClock  = NominalFreq / tmr_prsc     MHz
-  PulseWidth   = 1 / OutputClock            microseconds
-  FiperFreq1   = desired frequency in Hz
-  FiperDiv1    = 1000000 * OutputClock / FiperFreq1
-  tmr_fiper1   = tmr_prsc * tclk_period * FiperDiv1 - tclk_period
-  max_adj      = 1000000000 * (FreqDivRatio - 1.0) - 1
-
-  The calculation for tmr_fiper2 is the same as for tmr_fiper1. The
-  driver expects that tmr_fiper1 will be correctly set to produce a 1
-  Pulse Per Second (PPS) signal, since this will be offered to the PPS
-  subsystem to synchronize the Linux clock.
-
-  Reference clock source is determined by the value, which is holded
-  in CKSEL bits in TMR_CTRL register. "fsl,cksel" property keeps the
-  value, which will be directly written in those bits, that is why,
-  according to reference manual, the next clock sources can be used:
-
-  For eTSEC,
-  <0> - external high precision timer reference clock (TSEC_TMR_CLK
-        input is used for this purpose);
-  <1> - eTSEC system clock;
-  <2> - eTSEC1 transmit clock;
-  <3> - RTC clock input.
-
-  For DPAA FMan,
-  <0> - external high precision timer reference clock (TMR_1588_CLK)
-  <1> - MAC system clock (1/2 FMan clock)
-  <2> - reserved
-  <3> - RTC clock oscillator
-
-  When this attribute is not used, the IEEE 1588 timer reference clock
-  will use the eTSEC system clock (for Gianfar) or the MAC system
-  clock (for DPAA).
-
-Example:
-
-	ptp_clock@24e00 {
-		compatible = "fsl,etsec-ptp";
-		reg = <0x24E00 0xB0>;
-		interrupts = <12 0x8 13 0x8>;
-		interrupt-parent = < &ipic >;
-		fsl,cksel       = <1>;
-		fsl,tclk-period = <10>;
-		fsl,tmr-prsc    = <100>;
-		fsl,tmr-add     = <0x999999A4>;
-		fsl,tmr-fiper1  = <0x3B9AC9F6>;
-		fsl,tmr-fiper2  = <0x00018696>;
-		fsl,max-adj     = <659999998>;
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 4f09bdb5657ef..322e89b13c843 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8869,7 +8869,7 @@ FREESCALE QORIQ PTP CLOCK DRIVER
 M:	Yangbo Lu <yangbo.lu@nxp.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
+F:	Documentation/devicetree/bindings/ptp/fsl,ptp.yaml
 F:	drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp*
 F:	drivers/net/ethernet/freescale/dpaa2/dprtc*
 F:	drivers/net/ethernet/freescale/enetc/enetc_ptp.c

-- 
2.34.1


