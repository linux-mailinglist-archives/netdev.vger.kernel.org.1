Return-Path: <netdev+bounces-259058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFW8FLp+lGmnFAIAu9opvQ
	(envelope-from <netdev+bounces-259058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:44:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7373114D403
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA6FC30046A1
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274C233858F;
	Tue, 17 Feb 2026 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MLWbTQtw"
X-Original-To: netdev@vger.kernel.org
Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011024.outbound.protection.outlook.com [52.103.72.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44DF36B07A;
	Tue, 17 Feb 2026 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771339444; cv=fail; b=UdpQ12yriL1cAFE8U7rhk656k9TL9qdN3qPXaaMVPGBs4foZt2S37+5u4JgvC6h/blX0QMKRZe+56D9iL7KQN62r63WKllyCfq0IVz6q9FgeVMs1W3KkaWfJEsJS4JTl6H+ajGYBzmc5mcdOYTBWvANmHc5BBp7n5q83O1uZOeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771339444; c=relaxed/simple;
	bh=N3whYlmoVYXqLybFsdE5DrGoJCACnXDF5yGzCgQ9mFw=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=nlu6blObWNK9L9BIWgHk+6TTCvIDn4rhTBe7K+FZ3S0+bKrQrcG8kF/aG/FByGqOyIRJsXUvJ4bJ8AJD+AXfjavpltzvD9g66XURyXVK6g5caFKcFAHW+Ol8vqtLQERA8QOQ1Cp2lG5Ege5O/3qcMFZ38iH7D8pMgt7Ru+7xEQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MLWbTQtw; arc=fail smtp.client-ip=52.103.72.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbbtyF/CFaZtoXaIit+GikbTx6hfJGpuofzka/HQSbTF0JrkgSNJhyXAi3gGwR/dh3QiUzfxw10M1uS4C5zmEblP5U480Cifec7ttQ1rJNYcO71G5Exjo/sCVsNiFQOULqaMK3G/Zwo8q5Dp4/pRBvlwjsSDdiKKUXvEBQBpRr8SkZvAmTr6qj6uAzThR/VFohYG3gRpg8CJJPf4c0bJqJ6eiPCeWcxVZ3piL31WFigJ1aVjRNUXfSdohP2bE180gLWR2NfslT1YmbGPY+6lIzTQ0HuS/TYxfthGhqV6qWjKTzIPX1A57K1VE6YX9M5WC9EM4NNzw1NPRhZD4ng58g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myXi4yO7u09NcUsjgPPh7EJFjEQiDoFyv7NONBMUoA8=;
 b=uy3G7s4Pu5fGfmCdri007CCoWi0hsqJmXDuSlR3TYp6LogfGMDImoEjA1G1lAj4zpiwT8YFPl6h+WimNeKqf12jJCOKK0POEha3d1CPKDw0C5aHIuH0PZ/6ErZtJQDJ5C+7VNpoQ3+7Z5r4hq/6ENVrxx6xMxyfCCR/NkIpwCJuEG1n5ZwNI4fhpireeGYBOXOg43pC8MOazo4bN6S/s1QPjQAQnjZpwKSFG4JoqQl6oU5x3gD40hkzPrF0KfUfhvZmUQu7Ne2CinevEcdID4e7RN5GrbsFBGrF5dJjcFCsl429Tna0zKPOmqRsbXz38xOYe9SeUrFo+MC+8OKPD2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myXi4yO7u09NcUsjgPPh7EJFjEQiDoFyv7NONBMUoA8=;
 b=MLWbTQtwTIz6Af9JUU8MfQk4ivEKUCn6F6R0B5ujolkq0cvZj1OJfDR4js6qmXuhNCri6AFL0EQF5BFUvEpcTC6ouHOvS07O+mBO1hq75+vt8raFSdlq6F01BpmdfhVsALmYXuOOgeCkVvQi7QjBCig8xuHvTm159F4nMCvVguUs5cqWaNYCUygId01j6jzczbeOcUsxSWEWru4usEzbcGptIRADskGEg5eITHwSPheEgxS6D+n9l+AgpyOylc77tUQ4CzymZPDK41PzRkbAr29qZZV7z7Vw/vu2o39rFEvj96jH7jxWc/5b82xV9F8NjTiV4eXXIDn2kQnAjRsOdQ==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by MEWPR01MB9180.ausprd01.prod.outlook.com (2603:10c6:220:1f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 14:43:58 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 14:43:57 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Tue, 17 Feb 2026 22:42:40 +0800
Subject: [PATCH net] dpaa2-switch: validate num_ifs to prevent
 out-of-bounds write
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB788110DFE66BA1A5CE7E594FAF6DA@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDI0Nz3bTMitRiXWOjlDRTExPLJIPEJCWg2oKiVLAEUGm0Ul5qiVJsbS0
 AgZItAlwAAAA=
X-Change-ID: 20260217-fixes-32df5449b0ab
To: Ioana Ciornei <ioana.ciornei@nxp.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1597;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=N3whYlmoVYXqLybFsdE5DrGoJCACnXDF5yGzCgQ9mFw=;
 b=owGbwMvMwCVW+MIioLvvgwPjabUkhswpdYu/bW2wfqce9GndGSUJtxnTvjJf7dkcuc/syzvpi
 Tcuej/Z1VHKwiDGxSArpshyvODSNwvfLbpbfLYkw8xhZQIZwsDFKQATWVjD8Fec4aFCwNTHeVNi
 HOd/fnb+W6FNQT6z4Hf7w8seztpgIivByLDC5BlTTserzpcTm/r//l7DvKRXtzVPISguZ2pRoXp
 GBBsA
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260217-fixes-v1-1-1e4cc792070b@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|MEWPR01MB9180:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c10d1f4-a5f2-42ae-a811-08de6e32faa2
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwXZ5XHxNrJCjRnjimRBgM6S6xjVwrm50qLXnqStJqaPweXxnTyNkVwveqwheQuHTGsiIFc9DgbzdJTWF90/Yl2vuerwEvwVMR2iSA5pd6inaCuoKC3yRBOF28Y0gg1QzawwZG0pmnRm69SGg+vJh+x6iwlFlqvnQuZC4RS24DOOPnJIkcODCXGarwXVkCRgofPYxVyGYYLDLbaYF1dRZ5AQ8IMnn0dYqwodsMCOJKNUfFXe3Pz5weK6lP2XY1Q1sQmOXEN3RjVTImhflb+bcG2FWKwbfDSDV2NbtKatfGbPdz1iwp54dd58WfNCI0oPsmWjJPGXknSTB3FA5b0ud0Z7H+Hu6UfauTdBFbNXUGa8PkzHZVcuiOjPyFSgJvREGEfY90NtwCJAiPv3Hf2kmHtSKfAqqGqZ7VCfJP5BJV6AL6qf46dfOXfTAeqr5lILPsCZoe9/ZDLeth9MOzoHKuOXEn1o2k2N7C5p1lk7G2NiItKLaaKiQjhiw4Rflr1XBar5JDUeYSIfL0+vCF+4sKLuJIcQ8O6ABQrOJbuG9GG8SM69mU16XI9+kvWDRLU4v/boTOY6BIhxrsXInJ5mCag2mwlBENP+HOvltlWbrs1hJpukzyoZBWSACnX8hIxa/3tsbXvhJXQRTrPvUp2aKw4yN8HgKaNCHSM53QONASrWGJYID11DXRYZ6KtGRujapyV1dHf1Yym5y0DuRDvYoSqBSXrLrLfSVtF5QC2FAP9/fxajYh2GJ4JqARGR87hKD0w=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|23021999003|5062599005|15080799012|19110799012|6090799003|461199028|5072599009|12121999013|51005399006|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STZmNHljeTVxNWhJVlZvZmxWa3paV1BXczM4REZBQ2psci96Sk16L0FzMDQ5?=
 =?utf-8?B?aks3MWVWVHFLWU5jSFpVMXpEZ2lCMHBYSWF6VnlFR3ZSMU4vNHd1WkxmbzVu?=
 =?utf-8?B?R25XTHo1Zks1QlhzUStxYk5idk5LNE9TazhkM0lkbEtaRmVZVjB5Y09SQUZB?=
 =?utf-8?B?RHAwQkRpQnp4OWpqUW1YTE1vRFVKQ0ZoaFV3cWxzVGJ3eEx3Nml2Y3FiSXFF?=
 =?utf-8?B?QnJ4a2pTWjNQcVorN0dKOUJvY1lFMXRUdkZZSXJWekFRVFRQZzhTZWhXTGZk?=
 =?utf-8?B?VUhOWGNKb0Yra3pyemYxN2E5QkhNTzdYTzdXQk44eHROWnVPM0U3WjVWSjN1?=
 =?utf-8?B?OHd1dmtaYlp0Z2QyUDlEMUthUGdhZ0NaRDNhR1VRUFdxenEyTFRRSmZzRU43?=
 =?utf-8?B?N1pOQmNnQmhZd0U5YzVMNjY3YXQzV2RCdXkxQzNJRDJneUMrLzVYSmxsbHRy?=
 =?utf-8?B?M09oaWRVR2tIM0k1QXVMa2luTkNwMzZJOTJQd3FHNFJIMG9VWUVJMlFoUEVU?=
 =?utf-8?B?TkJIdGVIUnN6QWdjYW9mU0ZRY0VSV250VXgxQ3pnTkFZa1lWYy9zSlc4RG1w?=
 =?utf-8?B?VnZLZ0wzUytjSW11VVhFN0gxQ0p6YldWSW5FUFNuRjdXT2JZTWZJTVgrdU9t?=
 =?utf-8?B?cjdFWjh6eGJhRVI4eFFTeHJKWjd4bTlpN0dPWXlCWWw5c21PZFFQYjdVbnJq?=
 =?utf-8?B?amdJeEJad3NnREU4SlFQSmdHK3JFM3VpSER2VWZqdFhER2F0ajl3L05aQnYv?=
 =?utf-8?B?c09ZczYyRDJpMzFna1BEQU5zVExBaDB4VFZ5cG9NUElZU1oxZFBZRGU1Ym9E?=
 =?utf-8?B?V0N0aUwxNDl3U2lZcGVOcXFDTnBmYU8yM2FRTExhMG1QSEo5dGUvdjJGVUdI?=
 =?utf-8?B?M0RvcHlZeUtsM0lyYlFKMUNBcWVtNVhaek01ZFY0L3A4VDJyb3U2bDJKQ1dz?=
 =?utf-8?B?cWJLZ212ZExUeDFNbGErSUhETGJ1dEw2b2NBdVlZaUNDZFhuR1creTNXZ1cz?=
 =?utf-8?B?emFHV1FUUDY5VVlBWDRvdGx1cTJYM1Fja2tjSVhxOUxxOVk2SkZ0YW93V3NV?=
 =?utf-8?B?MWlERzZ2OGVBTmNPQkxyaU5oWW5FdmRLRURtRnVZT3ZacGhSbS9MbEtEQTJp?=
 =?utf-8?B?UDUxckpEa0ludlk2R2xZdGxhMTNzR0s0QzFuTmxHK3BCOWx4a3lubElhZllV?=
 =?utf-8?B?QThhd0xlNVd6bjlNVzJGZlpWZmdadnQ2L29PZVNCM3hVa0xjZFdQVnI2NHE5?=
 =?utf-8?B?dXFid2lSZjlZd1lHS0EyK0FxSmR4Ui9JcGNKRFBubW5ZYWo2Nkk1MUNnRFBu?=
 =?utf-8?B?a1lHM2toMThXQ1ZGcUM3U3dodnpKazN2cWtXZWxOSmRRbFhEeXNDOVROQXlp?=
 =?utf-8?B?NTI2Y3RhczlMeHhoaXhDanVuTHVGa0w4YlpTR1ArcGtoc3o1MnVrNlhGTUlw?=
 =?utf-8?B?aXBJUjExU0dVQk4yRk42NlNTeThyL0FKTEZFalNWVzNCZE9oZlF1bW5KRys5?=
 =?utf-8?B?QmQwalZ3c3BNK2xyZ3p4ZHZ2WXEwN2FLRklPRHg3Z0pkSUttZjhDUEs2UGF2?=
 =?utf-8?B?dmEzdmdMQng5OUVuNW5FYXFHQ0luL3A3V2ZMYkF3dWJFYnBBVElDOHV2aTda?=
 =?utf-8?B?Q1pWVWdla0J3azc1ZnB5RFVkd09PZlVzV1BSdVp4NHp2a2pWSHI4djh3MjRX?=
 =?utf-8?B?MitlSThXdHA0UXBzL2l6ZHRsNUdXVDRmVXZmQ2oxWTZYRitQNU8xOXRsNTlv?=
 =?utf-8?Q?gI/sbWjvFfKXLAp4Fw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnB6UFAxSmZSbzJsTjJFcjg3Y1V1QklyWG0wZkRQdWpodmRaQUhTMXZGTHhC?=
 =?utf-8?B?RnhMQW9iNVdxV2NmSk9BbFFWNTAxaUVhWUd2NDZoaTZKTnRVZG00TXArZjFJ?=
 =?utf-8?B?NHdvK3ErTE5kUHhMT1lHbEpGNEVjc29Oek1GaVBDZ3M0VlN4SUlObzVpUzd5?=
 =?utf-8?B?cEd1RXNwNFpyWjhTV3l5b0JoK2J6Rkg2SGVjYktYQ1NaUWV4ZnVFWEEwZEFn?=
 =?utf-8?B?UUZnd0hZYXdlNE5Ed1Q1bWRPWVVrZnpYR3VodGZwYUxZc0NMazIrSmIwVDdj?=
 =?utf-8?B?MFRMMlRxQ1VJbWVnSDRGaG9GUlVMSjBLU1B1RGFPSE9Lc0pYLzdzYitRcFFJ?=
 =?utf-8?B?K1QxMDhKTVJjNm40Vlc1ZmI4RG9vMm9aRVJLU1ZrYmFFOUx0aS9EbHBXUk9B?=
 =?utf-8?B?MVEwT2FvZElLc3p1bTZpMllHVzA5aHc0OEhXWVdmU0Z5d1hSbWE2dnk1Yjgy?=
 =?utf-8?B?Y1ZUajFTaVJqeUZDMG4yMjZ0MzJmWks2SVo1NmFvQ095WDQ4czRwdGRxY2RQ?=
 =?utf-8?B?eTNJaGFOK0xhcGVmYTI3ZlAxQjRzR0hHd0hEclpib2pWdWNTdllueldwczA5?=
 =?utf-8?B?dnhkRWFYZkpzZHVtb0tyaGR2VUpCV2NBLzFJTDNxekRBb09rNnUxWk1lUG5a?=
 =?utf-8?B?ZUxQS2FCRXpiRlVkcTFRWnE3cmhWYXc0SE8vMDdGRWgvT1NvZVFHbXBuSW50?=
 =?utf-8?B?cy9RUnhFSGV1TjFuOHV4SHpqR0pjMzFWZUlmRFQ2aHpCTVUyTFFJVDJ1Q1pS?=
 =?utf-8?B?NzQ5YzhmbVJYZUkrRG9nRXRVanc4MlNZUlpGeHpRdlN5Qzg3NXlTL2xaWlFq?=
 =?utf-8?B?UmxBSEpUT1VUNTNnUVJaOE5JdEd1VUtJWGFmY1ZmQ1B1dzI0WGlwb280elZH?=
 =?utf-8?B?dmkrK2lNN01rVnZWWDFtenpPcVJWb01wbjNFelVsNEsrOUxUQmlZZUJWeGlu?=
 =?utf-8?B?bHlUNUR1Ukd4UkdYNHZsNzJYM0FHcXdENWM0S1lUUHBRS2I5LzBMQjcyVjUv?=
 =?utf-8?B?dTRBbEJFUCtmYXc4NGxTK1p3VTk2eGNLaXhOUTFmS1EzTnNPTGNyTU5JSGdY?=
 =?utf-8?B?Q2s3OFgyZFIvOEVGdDJkWWxJMVgzRE5uRytEbzMvMzBnempUaC92RUcrc3VT?=
 =?utf-8?B?RDJnV0l4bkIxSExzWFA0elVmUEtnbGJoMitteG1kcCtFdEFGYUcrU0x4cDVV?=
 =?utf-8?B?QXJldTI5OWd5NTYvK2dFaG5reDhFUW16NmJkaFVDRjZmV3RMTnd5YkoyYUMx?=
 =?utf-8?B?dllJdisxU1VvZ20wbTZHWlU1N05HNlArTmE0SjgrZE1vU2l2UURkZXNmaXph?=
 =?utf-8?B?cGpFaEFRUEFTVFIxaFpFRUpmOXd1SnFkVjlXeDVmOHJBT2pQVy9kNlhBb1Mz?=
 =?utf-8?B?Y0FTUHllK2p3U1dHeFdKYzR3SWdpUEdEazUxN01wb1dZR1VoMFZ1ZEFGU1Ba?=
 =?utf-8?B?Y0l3cExtMXMwYldITGQwNDM5aDVxT3VZdCtiTlJnZTMwY0szNWF4eStoTGsz?=
 =?utf-8?B?cWgvNmlNaERFNmUzd1lNU1JVVFRpN08yaGI1eDVhWm9uNDZmY3ZJV3d3UnpJ?=
 =?utf-8?B?YmR5TWxvMEZCaW9nc01JRTZtN0V3amRBVjlSdDZHMlFyRzFoTFdWMnhzRzdo?=
 =?utf-8?B?VjFSVEVxWGx5bDBVOWdtdTZxdEFvODcva041aDg4Tm02amJDYTZtMnJVQXZE?=
 =?utf-8?B?SEFWTTZPQURDSU9PNEpwbGJKN2k1RTBYNm5nUEY5MTByRTFSTDlVeWVGSXYx?=
 =?utf-8?B?SThrWmZuRS85SHVXbUhiYmhWZlVmMkFkWVNCT25BbTArZWRPNVBpMVd2ejBJ?=
 =?utf-8?B?WnRyWTRQeTZkZ2JnSGdrQWpRZElYa0dqV1NPL1lVbnJUekJMeUlyV1MxdkVD?=
 =?utf-8?B?eW1uTHY5djJRVE40d0J4TDR1Z0UwU1k1YUd3U1Z1dG9wOWc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c10d1f4-a5f2-42ae-a811-08de6e32faa2
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 14:43:57.4914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEWPR01MB9180
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259058-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,outlook.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.com:email,outlook.com:dkim]
X-Rspamd-Queue-Id: 7373114D403
X-Rspamd-Action: no action

The driver obtains sw_attr.num_ifs from firmware via dpsw_get_attributes()
but never validates it against DPSW_MAX_IF (64). This value controls
iteration in dpaa2_switch_fdb_get_flood_cfg(), which writes port indices
into the fixed-size cfg->if_id[DPSW_MAX_IF] array. When firmware reports
num_ifs >= 64, the loop can write past the array bounds.

Add a bound check for num_ifs in dpaa2_switch_init().

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Reported-by: Junrui Luo <moonafterrain@outlook.com>
Fixes: f054e3e217e4 ("dpaa2-switch: refactor the egress flooding domain setup")
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 66240c340492..78e21b46a5ba 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -3034,6 +3034,13 @@ static int dpaa2_switch_init(struct fsl_mc_device *sw_dev)
 		goto err_close;
 	}
 
+	if (ethsw->sw_attr.num_ifs >= DPSW_MAX_IF) {
+		dev_err(dev, "DPSW num_ifs %u exceeds max %u\n",
+			ethsw->sw_attr.num_ifs, DPSW_MAX_IF);
+		err = -EINVAL;
+		goto err_close;
+	}
+
 	err = dpsw_get_api_version(ethsw->mc_io, 0,
 				   &ethsw->major,
 				   &ethsw->minor);

---
base-commit: 9702969978695d9a699a1f34771580cdbb153b33
change-id: 20260217-fixes-32df5449b0ab

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


