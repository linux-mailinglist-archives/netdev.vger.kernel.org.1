Return-Path: <netdev+bounces-254373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DRWIhZGemn34wEAu9opvQ
	(envelope-from <netdev+bounces-254373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:23:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D34EA6C81
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F886306F3E8
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 16:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DACC311597;
	Wed, 28 Jan 2026 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="q09cJdot"
X-Original-To: netdev@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010004.outbound.protection.outlook.com [52.103.73.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54ED30AD13;
	Wed, 28 Jan 2026 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619491; cv=fail; b=FU8nmicCCWvrMyYZer71/5sVhUN49JeTj9GR3GpU1fjEzEbo3M/kEOuC7AyiYiGOATMRceR/6nfYFlrPnr69PZ8jlEp8lRhvkflg4t16zAgRVVdB0fayjo02AtXdLFHmPaR2oEyR2XelOW1PTXnLl/zTOrLrBytW5U1niUqJuMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619491; c=relaxed/simple;
	bh=fskCuK+pQI9HpnDvMMsQAp2/qZT942DO2dKoPRY8ATw=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=Njc82N3fZM0mA116l1yhKbq/q3W/FTc8tdogJKBdTfLSuQnEriI3BMxsGYLL4UKvuVGuolgIBP9gwpTuoNTWQQ1PhJB1ICIeZ9ehPpcKBr3WjXEPxUuMLekws++2zfprhINug7Ti+fT2GJGcsvmSwVh+q+YS6+GY4IRjfjz8qoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=q09cJdot; arc=fail smtp.client-ip=52.103.73.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcXtKl48W9rN4GTs8DaZY0n5lVKvfuio+HhuLoMJwgJeD/TQvR5tM53Rsjv/fuMlbqkvQIng4w7b74JgTnWt2dxDTcQdqJISZ2mhNzTc0TY5fMkpqyww/x7rYV/AKOpuYiDZTR9S7M0oKf2+wZGUn2sr3aJNGmHufOoibF/meUzVtPj2A7w7ol4TIZ5O+OZ6HCqA99BU47/IiQDy8D+dTgEwX6VeeRecWwmdPFqs3YtIhbW99vz3wJmdVNI1z4s4/lX7OvZO1QE00dfVoPOjZ+VD5p+X97LSWu/mCMexYuD8xXUGKOvDss1ra728ZEaeIoALFDgwqoKHOBuUJXhbHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hB3zyzEdA5PjFOzyCyN4F5NyxrH1wAOrzV6gqBNC0b4=;
 b=eJyRegmjCA8uDoehh3JmdG2+J1yVc0urHLQIJWymY3zsYBnyQlsYn3zoIrBKTYAiW2Yy/46BinAiHU07STRANQDAczwxQyBClKXtqHyX/8XmgMPAqqWEJx9+IU0Kgv8QUtxnQlijzC1/IBzqaaJR8OMErJ+vLh5+FRoVNCJtwHooUdVVUpmKYPqdGlCod9meCJVlD2mnTk4IUJH07Y0Bx3qpCdy2LOcFbahvlI2SUrOUeRv40c0+naNGVaaokCDDeD1nmOXrnOwTcMgX65ac6xO+jLew6tLQT7BzqYT2Uziuv6MraE7QO4YYEooRgzDQivhBcIhe0bkR3OGCTVK0gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hB3zyzEdA5PjFOzyCyN4F5NyxrH1wAOrzV6gqBNC0b4=;
 b=q09cJdot6q0NHgUO2/A2eCgexwT5hN3tgKlaTECrdbi2mprN20Cz6YwO5fkFLc1qDaqGFRapfa3K15/jnjX/VzWuqeyRDIJQaeKgn5+zVws4QTZnPAraO6bwYxcps2tPeQYWsoVpw3Rh2OJxkqHO/Enm2WmBtv2lJ4UZMMyDUvgUDY2WNjLJsg14EVNBCnPiPlxhbkKRKAuQhpS0be2L6LEw7xPrnsJzqjDTMC3u0Wj6ki3yXvfSl7EM+Bh0K4OE9UtcQHfqc+uSam/eGiZEroOLVNT2gCWV6gDYrRAcp1xr599wbW4YA04+SoNNoHkSWuMlK9MbMUMOMs5gWw442Q==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY5PR01MB10703.ausprd01.prod.outlook.com (2603:10c6:10:328::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 16:58:04 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 16:58:04 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Thu, 29 Jan 2026 00:55:13 +0800
Subject: [PATCH net] dpaa2-switch: add bounds check for if_id in IRQ
 handler
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB7881D420AB43FF1A227B84AFAF91A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3KTQqAIBBA4avIrBNGF/50lWghNdZsLJyIILx70
 vLjvReEKpPAqF6odLPwUTrMoGDZU9lI89oNFq1DY6PO/JDoGBJm79CnEKC/Z6U/9HWCQhfMrX3
 z8AarXAAAAA==
X-Change-ID: 20260129-fixes-98a0f7607a88
To: Ioana Ciornei <ioana.ciornei@nxp.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=fskCuK+pQI9HpnDvMMsQAp2/qZT942DO2dKoPRY8ATw=;
 b=owGbwMvMwCVW+MIioLvvgwPjabUkhswqB3abq+b7X3jbrlhW/sa1q4b577MsNgWfBCu1dObNM
 0r+HRXvKGVhEONikBVTZDlecOmbhe8W3S0+W5Jh5rAygQxh4OIUgIk82szIcKKS/1avW82EvfHK
 IRanm19yXmWeWNBTVHVd4faK3p9zNzEyvA7huWVVvvBp+5K3+ZecQozXJ18K/LbZJLprVXrp5ra
 rjAA=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: AS4P251CA0002.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::8) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260129-fixes-v1-1-511f7e07cdb6@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY5PR01MB10703:EE_
X-MS-Office365-Filtering-Correlation-Id: b5253a19-600b-46e6-7e40-08de5e8e66c4
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwXZ5XHxNrJCjRnjimRBgM6SMwlGM9717wmNP4lNaEVQBuNBdFF84AtyQHBbS3wohufEidGyERNj6tulCHHNe8A7NdOIkyy9ulen9yJfp635QmsNXu82WWG2bL8dqG/qfEj8bpWHzwW6eR9U0XO+FmDp8gnXepeE6nGHVht30rdNLGsWvRn/GnVmxDcd3y5Mf6j+JwsWRnzrPpqvjYHR04iAAE3n07R+ProwKG77hJw3/a7fgJVJQ/68kZn6ozwbSgZ3/d9Mh3zNBMdAUr6SBqFC5+qfZGDXC6DMdJP2SkH8s9Ov2jafhYbi9ngpqhsd3gzGZzDurq6nDTfjxinjXUCyLy2Wyk7tFB0JvEfjq11e6JrsWH3JZPXBRKxMYszrPb0NoVglJw+TM5iCJ4pV4jnd0lqn9WSdvL0igh4yo+QQ26bxtVyxqjAsXyJl62IDDqAG58BmVdhgu83yiWERIfjGCI7fsnYg+j/Ap9E9OXE8PquOgp0cNDCyzNTvoMd0+vdkGQfe+v4HHxEWIPEc507ZLZmbIrcvTPxP4wP7irOpBka+XUjFnIDjXqfrE80m/qUIURA6bOiTddjIN+osIWV+wkeKXOOkBm+1lnbW2Y14JsYtg9FlXDjjWTEONn448UOi6yVFzIQCqFWF+Fc/1bFy39JVt5iQN7fTLfy5MUBeV7PvuCCEual50g+UpbcbXkHUfTB7N4SNREs0jnVtmKRWuvjshTzwewrAozGothQ/8igX29HZXatRZE5YgCXDOK4=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|5062599005|6090799003|8060799015|51005399006|19110799012|12121999013|15080799012|23021999003|461199028|40105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1RDR0U5MkIybENIK3NtZTVETWI2QXNYWWJiUE1IRVptcWEyZ2VFT3E1SVNY?=
 =?utf-8?B?YW9PQjlXK0RacVJ6V3dvVXdrc0thNmt5K1dmUWR1amZGeEl1QkJFa0YxSmxj?=
 =?utf-8?B?NUFCZkJ0SmNrNHJSb1Ntc2t4dXhZcTJERXVrZlVackoyMjc2VjByRnBUMzVN?=
 =?utf-8?B?SWVJUkQ2b0g5TWwybHE2R1Q5N0MyS1VZNllFTkVtbVZ3OFVlTU5sQ1llOVo4?=
 =?utf-8?B?cUZwY3Z5d2pXWTVBYjlxeEEzRnlRVFdNcXd2Z2ptRTFUMjhDRFF5VHAxZ1pI?=
 =?utf-8?B?dytRQyt3eDdpZVVBT0kvWEF2TVFZS05VTEdvbWNtbXJzajJ1U1pZRU96SXI5?=
 =?utf-8?B?clRlTEF3RjNIMWFKMHA3S0R5bE1QNG4wZnVtWW1qWU5vZzBvWTd4emwwMTQv?=
 =?utf-8?B?dmZobWVqa21BSUZDcEU1NnZnY3FHNTNFMnRhWEFhMG5sKzdvbmhpS2s0cTIx?=
 =?utf-8?B?SG42MkxkT3M1SWF4T0x6MzdMMWV4Tm81ZmMrMjJ0MEtHNDFmUE0xNHZNeVpq?=
 =?utf-8?B?ZTZoZzgyVDJjalJYdnVQR2wzdEZnTzY2TUtjdFFQYktxMy9rRHl0YldSNEE2?=
 =?utf-8?B?UHorNEx1S2JpcldhWHhtMDRSOHRSeEpUTUZKY2lINFlTKzAzUzNUZzBybWc3?=
 =?utf-8?B?OUQwOXJkampwL3dvY0lmeTUxenBSYzdHQUlpWk1JenNCdGVTaURONEsrY0tX?=
 =?utf-8?B?YnpuYUF1OGs1ZDhydlpaenhVT1E4WmgvUzl2MU5wcWJEU3hXVkE0SUR2bG5n?=
 =?utf-8?B?anoyc2VNUUZUN2xmenlUVnVIMDlqVGkxamRjeXZTNjNaS1FKOUhDb1pLUGFL?=
 =?utf-8?B?cStVTUhYZ0M4bGJmODdpbVMyRjgyRDg1M2lVU1VpZWxnbFNpL1RSc0l6YURO?=
 =?utf-8?B?WERWNFB5T0tycWVqb1d4Mm5CTDRaUzhPOFpLTW9oOE5XWGdKbktpaFVXbFVR?=
 =?utf-8?B?eDI4WEJDYWl2S2Y5UkhLTE8vbHlDZU5xam9DMk0wODZsYnVuWUJSR2g3NUw1?=
 =?utf-8?B?WkppOUxQQllaM2w2VGEyaWJQSlgzRmdUU1pKWWYwTnRNbWJ4M1BSMGxQQllv?=
 =?utf-8?B?WmVaMEV6WVY4ajhWcUJNRW5IQVI2azRRckhJZmNqbDZxZ0JoSTdacXRjKzNS?=
 =?utf-8?B?OHZmOUNKL1UxeHJiRndseVAxWTM2cStQdCs3SHlzVFpRVUM4am1idUw0di9i?=
 =?utf-8?B?V2pGWTZuNmRTRU9iWVlwOGpETS9rQzdGS2pkSXdqMy9obFIwb29iNlR1U0ps?=
 =?utf-8?B?V0R2UEE3eUU2aTFTbUVBTGgrdFBQVG9GbGhwVDBWTzFXOTRjT3NKenJZWlZm?=
 =?utf-8?B?dXFOZWNkN2kvQWZRQjBEWVdPM01VWjZUbzdKUDJ2Q2NxZmJwcWRSSFhBbkM4?=
 =?utf-8?B?c1pqbzBKekVlbnlZcTZkNEZoczJXNVNab3A5VnVPOG9GZEJUOFozSjZiKzRQ?=
 =?utf-8?B?OFNxZE1TcHFDY1dIeXUvaEdxdzVrVENRVE9vNjhWYkxOSGNhUCtKVnFMYUxE?=
 =?utf-8?B?L1MxVHVpK3VreXJPNlNNcWdtcnd6ZmN3aGRsL29HdzdnMVU0dldLOVZwVTNN?=
 =?utf-8?B?dGcyWDlUcERQalpnU1Z1d0VtZHdGSGxlNmpTY2ZaZk9VQ3NHd2hXUElqcVhn?=
 =?utf-8?B?V1lRZ05JNlBUTWlNR3dqQ1VuN3dxU0J6eXdtZ2NhbVl3dWJ1K2lXcHRla0RL?=
 =?utf-8?B?UWxLQ3ZDN2JVREhsTDdMSVY1bjZOcnBmQjZPQWk0UE9jdFk2MkFsUGRHWnhC?=
 =?utf-8?Q?k+Cwf+tYCJHMHY4+ak=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2oyN296OUJMZ0lSMHcyNFhZOFZ6WDQxZkdXajdRbjFKYjNGb1o4UCtVR2Jx?=
 =?utf-8?B?a2VMVWZqWFQ5UU50L21Jb2t3MEVxWnl5THRYTExYdHlKUlYxSnJYcC9oakRJ?=
 =?utf-8?B?cVZhNjl1d013UC92V2w2V0xlZ09ib1BDZW9UTS9keHpwSktHYk9TTy9lak9U?=
 =?utf-8?B?Rm1OTzZiVkMyMjZUdnhDbUtiM1lRR0t2dHFNTVlaNkJaM0F3eXR3ZG9rRXli?=
 =?utf-8?B?Nlpialc4bnRwdTlJR3dXSzcyaUo2enBJaERNSmVQMXdwUWg4Um4xOHQxa2dE?=
 =?utf-8?B?RTNSdDhqMGZDam5aWWZYM29EVkFZYTloQno2aThPTXQyMWozTzM4Z2N4YUpR?=
 =?utf-8?B?WW9zTzRPQjFyVDJpZjlaQ3AxK3EycUIxdDRKYVY0VFk5cDZGRXcyRkJJMVpk?=
 =?utf-8?B?YnF4dmtHYmNaMHFJQVNyOHpYOU1xVmRtNFZMM3dqWjZqT1VINE1CQUowcVlE?=
 =?utf-8?B?MEtJcWF0NWErT2hJN2FrMlpvL01IMGk2ZjliQWtaWTJaK2MzdEZ2LzQwWVdE?=
 =?utf-8?B?aWRBbm44V3J6T01TYjc1bXRXT2U1RmFSMGwyTUVkL3lVVk5pMDVRTC9VamdX?=
 =?utf-8?B?N0J4N0xiM21tQmNaY2ZPNis0ejFRTy9GTHZCYzhIWGxhWk96MVVhS1JoamJy?=
 =?utf-8?B?TVZ1RXV6YkNLMm0xM0JtL3dvTEhRc1VjTW80SUxzRHlPNDZYV21jU2g1SzJp?=
 =?utf-8?B?RzlGaWlTc2pjT0RWSGxiZFZNeGJoeE5XQ2l3SHY5ZEVkOFpRTmpDNmYvK0li?=
 =?utf-8?B?bC9NbkJlcko2S2RmZFpoNW93TEljbDJRY2pLTGhxcWM1cExCRC8xZEcvRUYr?=
 =?utf-8?B?anhTQkVHNE4yOGpDVW5FbzRZL3Rvd0RMTHJkc1dsS1p6d2xKalA1VCtkeG82?=
 =?utf-8?B?ZkNlRHNHYlQvREFCT0k3ZTdMcXVXd2k3cjZnK1ZMVzBxMlZEM1UydXlONGNO?=
 =?utf-8?B?ekJjV1ZDdWh2eUQ0WGR6YWtmVVpTTkoya3ZNZjVSS1dHZ053ejFsM0NUaXhK?=
 =?utf-8?B?dnJTdUNHOVBwN01CaUVGZGZ1N3pEcVFGMm9MMXNOanlxMnowOEMydXo1N0g3?=
 =?utf-8?B?a3FWTlJXM3JxZWhhNE56SDBkdUFYQUd5L1R5ZHp1aGtuNVp3OWlGWlVyYWFm?=
 =?utf-8?B?TjFmeE1ibFZ0V2pNR1dEWElaT1E5MVlNWXB0cFJvTTNjTndLM1hjd1Y5cUpD?=
 =?utf-8?B?N0I0d2FkWjhvbHNIc3V0d3B4ZVhSbU5wWmFPYXlHK252ck43T2gwc0NGTzRr?=
 =?utf-8?B?VWoyOXVNZFBWM05qUHk0UEJnZlRsSzBrRXFvMDBhNnBOejZ0eEExeWVjdWM2?=
 =?utf-8?B?RFVkN1l6Zmw2ODNoN1c4ZVIwMTY5bG5BL2JXMFhuNFl1V05DR0xXVkpmV2FT?=
 =?utf-8?B?V1hHeWZVM3JQNEthQ1RrS0JIV0p4aFEyVk1oVWFvQVk2byt1TkUxcjRBdUU5?=
 =?utf-8?B?bHF0Ylg5dnczYURZYU5pU3hUUzVkeUNBbkg5QjFqZ0pqZUhxVWNrTy9Yem9V?=
 =?utf-8?B?MDVZaWxmeGhqQ2pvdnJzR0JPemVLKzVNSDZEWlY0UW5JZ3hiUjl0OHVaeHA1?=
 =?utf-8?B?SE5jU0xqbENpV1Jxai84OTlPTWdaNUorMDdTNXZsemVIYmkzMVhCcHdBWlUy?=
 =?utf-8?B?b2d5V25TOGpNdW5tcm9yTHpFVDJEejY5RHI4U3VYVFIwUnhEZ0RJaURHc1h4?=
 =?utf-8?B?a3lIUUtNUmFETklwSE9VNGkvVnRRZ2pWam9uVHVDTUFXZDFCUWtjN09KREx3?=
 =?utf-8?B?bTJKT1FSbTkrZXU4WDdUbkJVcHQrQ2hINlp2bU9jTWtvS1kzOHExRWpXQitW?=
 =?utf-8?B?djBMam9VWURjc0pDeElWekNXdVZKc3NJOHFabWlYdk1BRTJlU1FLeGRhcnla?=
 =?utf-8?B?bHRMWC83UENpWWdiNzFqT2NHNlhYb1lrVXlVd2RyWGhsb3c9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5253a19-600b-46e6-7e40-08de5e8e66c4
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 16:58:04.0302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY5PR01MB10703
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254373-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,outlook.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SYBPR01MB7881.ausprd01.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,outlook.com:dkim]
X-Rspamd-Queue-Id: 0D34EA6C81
X-Rspamd-Action: no action

The IRQ handler extracts if_id from the upper 16 bits of the hardware
status register and uses it to index into ethsw->ports[] without
validation. Since if_id can be any 16-bit value (0-65535) but the ports
array is only allocated with sw_attr.num_ifs elements, this can lead to
an out-of-bounds read potentially.

Add a bounds check before accessing the array, consistent with the
existing validation in dpaa2_switch_rx().

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Reported-by: Junrui Luo <moonafterrain@outlook.com>
Fixes: 24ab724f8a46 ("dpaa2-switch: use the port index in the IRQ handler")
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index b1e1ad9e4b48..33f0842b5dc9 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1531,6 +1531,10 @@ static irqreturn_t dpaa2_switch_irq0_handler_thread(int irq_num, void *arg)
 	}
 
 	if_id = (status & 0xFFFF0000) >> 16;
+	if (if_id >= ethsw->sw_attr.num_ifs) {
+		dev_err(dev, "Invalid if_id %d in IRQ status\n", if_id);
+		goto out;
+	}
 	port_priv = ethsw->ports[if_id];
 
 	if (status & DPSW_IRQ_EVENT_LINK_CHANGED)

---
base-commit: a040afa3bca415019d96a586b96b5f17b1f55a90
change-id: 20260129-fixes-98a0f7607a88

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


