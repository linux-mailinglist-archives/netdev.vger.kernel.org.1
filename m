Return-Path: <netdev+bounces-244181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09373CB1BE9
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 03:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E06E301841A
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 02:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403FF221FCB;
	Wed, 10 Dec 2025 02:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VtsuoY8/"
X-Original-To: netdev@vger.kernel.org
Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012069.outbound.protection.outlook.com [52.103.72.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7B31DF247;
	Wed, 10 Dec 2025 02:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765334921; cv=fail; b=se4JIkxirYXaKUt543MI9OCmI7IzFQefK0Dx9FOYR75yFZrbOng0gyQ6saTLoUMu7YkSH6dxRMBbDSP9gJpgiv0arsMJEN3oqrF/KqA+EgJRMRONbRV08GvmpdOmcb0UmfOhAvgAk2YgTRkwEutsQd5YTUTBPyy2+haXY8cUkgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765334921; c=relaxed/simple;
	bh=OvK3AVc0AYAGtk8ahU69HodHhFY9CEeoZPGpC7pu/aw=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=D/5pzKrUMn0MOUSDwjVMnyfN7Qgu/WPfXDBSVzFUEgn7rPhd9IykuYYFdr9DCBARegj6dOlkoDZVIG2qinagxJ01KivW74aFGgu9X24sJV0WaA9cM0/D0TuMrFwtoFzPO+D6WMX0KbtrjP+R8wK1jorDNroypO4zLeb2g0JY/vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VtsuoY8/; arc=fail smtp.client-ip=52.103.72.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWrOCSx2BM8etissJUIc8Aix1zrNkcdKFPQyfsYKn+K711URA1n6iz3kQcyTu6MRjCM7b7zfh1pI22LnLA0o2vDBYdngp0klXKoCJNIoToYdKiqunIFtIfQZCThy2JxEDkOCYWO8nCuLrJktNQBpCC8es2FlR1ojSrXQpPvXHUkXyfMicvDyobYIqjTgncxiFMq//uD/JYzkNrSF8AKc6zAdB/xgsdT0fk7X8Rcg/sEujVCq8sn9zZmARvhVCmswoIE82OqFuBzULdBCo/I7gkSgKRO4oUjvT6YAS2Nw/p/459Z9h4YwafIsYuPWspH0SbWR0+srFcyM2Pdrsxffqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02PhGHBUtFhRZkH+7pShKT18NYmbbv7rgZ2xQtlF3Bo=;
 b=Y9G9MFAC81UVQhO9uk+X6a2RGgXvMWTyNiUzC0FsKvseqnhL6A4vrK/reRfP7YnKNq4EGe9+vWF/RwPOd2YLdDk9HRmdeY0+TdzVdmVrrrIiNZhYpl9iaS4KAMo4/aC6al8Y1FgkvuBumvHpSVB/We7oZLprDYw5/dpR2rW3GOskYRAFzpRHuwn9UKRdWpLl2Ko8MTfYMt1459bM02tlbDfjV6+lvKDwwkMCiEOsU6yR1yvr/FWSsnACmnEoq5GD9zi6XnHQfNrklLcaCqQJ4SrlqL/INqsfgOMvBMtytpQaBaGFIA05KTHsM95OTy+PvZRR1YkaiMTL1RwgIQLBRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02PhGHBUtFhRZkH+7pShKT18NYmbbv7rgZ2xQtlF3Bo=;
 b=VtsuoY8/87DSwwrl5sJUnPOaNZJFUyJc1xVUWwv4us6kgTUzp+9C8mi2feJMow0FM10DnQ4zCX4DyJk/mzBsSV2aV79lQvc51sKmrqsWgWL4U0GrKrzzv9lvE7Z8269X2wQTyQcrIC15x5Y4D1C8N0n9YC7huR7NgLSHPYdXRyNWi3UcPRbKX0nsrXLZOStj792i/9YTXpG8afngToNxveL9MSoNG0MGzogqpP+0/tL9k+CyoE+Jt2SjcRK5DTxGpvfse0X+J9uIFyhR25vTtKtgK+0yjL8FeZGAIB0RiL2ZaAyxM9aMPhIA2zr5Gb530BG7SDnn8Hg/gEFqObJIUA==
Received: from MEYPR01MB7886.ausprd01.prod.outlook.com (2603:10c6:220:17e::8)
 by SYBPR01MB6810.ausprd01.prod.outlook.com (2603:10c6:10:129::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 02:48:34 +0000
Received: from MEYPR01MB7886.ausprd01.prod.outlook.com
 ([fe80::d6da:97a:52e1:2ee4]) by MEYPR01MB7886.ausprd01.prod.outlook.com
 ([fe80::d6da:97a:52e1:2ee4%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 02:48:34 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Wed, 10 Dec 2025 10:47:33 +0800
Subject: [PATCH net] skb_checksum_help: fix out-of-bounds access
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <MEYPR01MB7886119A494C646719A3F77CAFA0A@MEYPR01MB7886.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAETfOGkC/x3KQQqAIBBA0avIrBMcocCuEi3ExpqNhRMRiHdva
 Pn4v4FQZRKYTYNKDwufRYGDgXTEspPlTQ3e+RE9Opv5JbGUQ46YAgacQN+r0h90XaDQDWvvH4K
 BeGZcAAAA
X-Change-ID: 20251210-fixes-ef9fa1c91916
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=OvK3AVc0AYAGtk8ahU69HodHhFY9CEeoZPGpC7pu/aw=;
 b=owGbwMvMwCVW+MIioLvvgwPjabUkhkyL+9X1j3p8p4a33JoeMCdP8mPBozI2Lhf/QOlDu1K87
 BOjPuh2lLIwiHExyIopshwvuPTNwneL7hafLckwc1iZQIYwcHEKwEQu/GRkmPy5aEqDQaOz2qsV
 5c+/zheeJtF+IkzlM69r4BPGvTJ+Xxn+Z9Yf9Iv6mvJmseSyg5w3urr3KE75fe+w7LOFuWpNayr
 8uAA=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: SJ0PR03CA0271.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::6) To MEYPR01MB7886.ausprd01.prod.outlook.com
 (2603:10c6:220:17e::8)
X-Microsoft-Original-Message-ID:
 <20251210-fixes-v1-1-16bfa2f8a16f@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYPR01MB7886:EE_|SYBPR01MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e28493d-e275-45f9-b2a8-08de37969c60
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|19110799012|5072599009|23021999003|51005399006|461199028|5062599005|6090799003|15080799012|40105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3BZMHZKaWNXM1R5dkRBQ1BTVC9WRDFyRGd6eW9Wc2VYSS9rSnpKTlErYUlk?=
 =?utf-8?B?VENwUUg2bTlRc1RwNzZ3ZjNENGdvNHRnWFNFMUhhNVR6a2xSejBaN1MzSGhW?=
 =?utf-8?B?emsvUkdjbG1hdERDWkZyVlFnUFNnZ2w2Undlam9tdE9DeWhyVlcrTWsrUnI4?=
 =?utf-8?B?a2ZFYlM3cjVmL2dhWENaWk96RUphYklWSzYveFFZMkR5bzAxWS9OS1M2eVZp?=
 =?utf-8?B?MWc4dWkxNURqQmJDM3ByVFRyVm8wUUhGQ1YyeXBwa1JkbXNpaFdLY0kxYk9C?=
 =?utf-8?B?ZVppbGJpdE8wd2x0eC9oSk1tblJyR0gvZzBEQjhOd256eFB0UlJTUGg5SWlp?=
 =?utf-8?B?RGNXQi9UVHBwRHYyR2gzdTdwaDRGdE15RUE2bUdkcGI4VzNsa05IU2xpaFBz?=
 =?utf-8?B?TEkzL2dPRHJ2bHhiMVFDSW83QmtyRUFicXZUa1RYcDMzNlRjcloxMlhMVVM4?=
 =?utf-8?B?VUdmVGxHSUV0WFl1aW1JYjBCMEpMWG9pOXduZ3Q5ankxUUtCRFBLMVZWTE5a?=
 =?utf-8?B?d21yeGp6TWkyenpWNXdrcjgwNXAySEE3MlR2b2RzaStRbWVMU3VRWXF6OFRI?=
 =?utf-8?B?ME9ObnQyMkpCUDVYTzVHSnAxMW9qRU5Rb2dMWUgzdkVQQU1ZVWpteENTNFlG?=
 =?utf-8?B?TTNpZG9kRGRxYVhQNEpXV3FzbVZ5VWgrQlRMZVZFWFk2RExGOU5IL2RtSVl6?=
 =?utf-8?B?dlRjTXFzNEtpNWtLNTR5ZURaUUg1OW5ybXFsbWh5N2FMeVRmUDY5dnJQZy9G?=
 =?utf-8?B?RnV2V242cFRuZUMwZTd3K3lHUlFPTzNFQ1VRL1VRbGJGK3kxQUJubXhGamtV?=
 =?utf-8?B?NHl6Y2wwSmtlamZJT1pFRmVMT3lHeHZRSVNnRjhEMDFEL0h2MmhxbjIzY1h2?=
 =?utf-8?B?Q2JJa1BhNUhFaURBMVp3bTducVBvTlBuQlN1TkNBdzRJeUZtOVdxNFNwSzdl?=
 =?utf-8?B?QU9jVm16amEvS3p4K2w2T3lIUkpxbk0zZjJFNDJ6MmxxZGRtbmtnQ3c1azZY?=
 =?utf-8?B?TVZWS1ZpcjdiU3VUSlA2aUhldXYvZ2F5VzhIUUJhNkNSck1vWG5OTE5XUWtv?=
 =?utf-8?B?VlMyQmtjZ0gzaXJ0U3dTTXRGMkRzVWZGNEhYWU5WS1RiY3RPbjhlYld3U1Y3?=
 =?utf-8?B?VEZIdzFKaXY1TTM1WGdoa0d2NUVmWVVFSVRDNXNDWjBRSHh4NElKSUlPbnp5?=
 =?utf-8?B?OUFxNXMwSFRuUmpwalNwcnQrTFYvWFZKb3F3OHhhL1FSc2xmVE9YcE1xeThN?=
 =?utf-8?B?Tzl6cU94WDNESUE1d0JIUEFVLzZZckpnVW1wUDhTSGpib2FMTktLT1I4RGh2?=
 =?utf-8?B?OENUQmYrY3dkd3hpUjc3SThiRW9nVXlIazhFcXo3cjdCdmdYWGQxM0FPaGcy?=
 =?utf-8?B?aTdkUmYvSmh4YzVEc0ZFLzB1YTJPeExpUkQwYzkvVE9PR2d0TEdCZ01HZUVP?=
 =?utf-8?B?TTRlaDV5ci9qSHZPMFg2SFpaN1NCYk9oN0tZT0hYSzZicCtyQzRobnB3ZjJs?=
 =?utf-8?B?K0hQWVpyWEJjNmt1a244eGh5REhXWUZYaDcyTytNY0hGN3ljVFk0OGZ2VFFN?=
 =?utf-8?B?RWowdVNUc2I4TVIzbjlUNDA5NjN5U3FYVlFodWV1Ulo5dWt1a1Q2QThyNnJk?=
 =?utf-8?B?SStDL1huVWR0VU1KUVV0VjNKNmNEVldOK0IrWjc4ZWNKekhYK29abTlmQ1Ux?=
 =?utf-8?B?amxrdDNib3BaMUxObTNrZzBxaEpQRUtscWNtVXA2OWNsanVOcy9FbWNnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3RxQlpGaU5KaitOM2ZDdER5N3VHM3I3QUNjUk9qSWdXODhOaEJIczh6NmVs?=
 =?utf-8?B?QytvKzZLd3c3V2w5OU5iMDdCVUNyTmEvc3lUV3pMbTcxTENvME03NzN0TG5u?=
 =?utf-8?B?Zk5CT0N4NC92UWlEL0tPY0ZlMzhIS3VmbVFSczdPUGVNRnByZnNBTERZSFNW?=
 =?utf-8?B?SzZMQ0prd3BoZnlPem5vSlE1Uk9iT3FiM2dmTUlZaTk3YXJVU0lTeTZEYkFL?=
 =?utf-8?B?ckp1TzgzMElkRFQ1NEFNd3owdGZQUUJBWFliL3R3RS8ycmsrSkRjcDZWTlBr?=
 =?utf-8?B?REtWS3R2SGlWL1hheTVKUEQxQThydG1vWjdMZFhwTGpwejJhTEt3NXd5MGh1?=
 =?utf-8?B?U0tvNVB3UEFWL3NTcE4ydmNYT3IyZEMwYWVSQzdlMm41VmhUZGVQYXN0alQ1?=
 =?utf-8?B?UTY0eDFtaVA5NWdBUmZ1VVpSZGZobjRpZGRwSzViVnRQVDVZSDdqcmhLei84?=
 =?utf-8?B?N3J4UElwNldjdUUrdWJIeTZhL3lpTTRnU2sxUXZVczBMQnFtbDlrR0hWN3ZV?=
 =?utf-8?B?NkRnSGVjQnluempEbWM3WDdjeGVqSlZJUVNBak1PYVdlbUlSQ2trV0pYUG9t?=
 =?utf-8?B?NkM4WTFRT3RVWTd0d2duUjJYc1oyaGNScXpxSmJ6Z0czUURXeGtJWmZhQ0tx?=
 =?utf-8?B?ZGs0QVh6Y3dIOWp3NWxEQ09FT1JyQkdudmNUellrWUMxMVlOTy9JRS91SnhI?=
 =?utf-8?B?bFJsY25Ic04yOXhHMXorL1Z5SEJXa0NhMDlqUkc2YjVRcXh6dG5xcHh4REVi?=
 =?utf-8?B?c003NzZWYjFRaE8vMmF0bVJqcDg4cy9BRE8xT0NoM01aVGwzOVJ6NzFFcS9J?=
 =?utf-8?B?OGFiTlIxQjFCVWg4K0N6ZlJDK1hHaHNPcXpaZjcrbk93alNZV1Y1SHNWL0Zz?=
 =?utf-8?B?ZFdyT3dnZ1ZGTFU0dWFTQ0xPR2xkelpJNnl0dXVHNkxjWmtmVXRWWmhTekxj?=
 =?utf-8?B?TjNzYVFLN3REckxXT2QrTlAreGg0Q3kzTC9CcmIvd1o2QnVIbUhkdGdlSE5a?=
 =?utf-8?B?amEyU0RhK24zMUIxVXh5a2NNUzE4bk1ScmdKbTFZK2N4dDE4WE4zU2d2Wmk3?=
 =?utf-8?B?VXk3SkVvbCtXQlMvZkhHUklWVXhORkhUdHIyYXUvaDhiOFphL1lJbW9PWE1D?=
 =?utf-8?B?aUJ6MTcwWi9IYW9sY0lsYlAxeDdwL2RxTlJqUTBnWElUdTVncmF1eXROdmRl?=
 =?utf-8?B?WnFWUUQrb3cyVVVQczEwdGdvSTVocCtZeHp4UStHZ0lCbmxMRzJGb3J0L08y?=
 =?utf-8?B?dUw1WjdZZmcrQWUyRXJFS3ArNHVPS3J2cHN3VDRXbTE2anF1ejE2YkQ0S1Vo?=
 =?utf-8?B?K290YUNLYTNBdWJXaDZRQkJhc1BSQUtZRG4vaUpDc0tOd0NFZWFkUFltUDBV?=
 =?utf-8?B?amN1YlNFUUdEaGF5SDRkL3dvS2Z3YlpkbVloajJ3b2tDaHFhUUI4TndjWmgv?=
 =?utf-8?B?UzRYRjBCditHOFR4eXVlaUxlTXNWVG5MZXcwMnFMZnUvMjI2UWt0R2JqMk1P?=
 =?utf-8?B?ZExudVMxbmY4S0JSUmVwdGRueW8rV1dFemt1YzM5ZFlua0F3RnNlRlFPU3VO?=
 =?utf-8?B?YkR0RFk5VVd2TkxuempHeE9tc3ZEUXFNaURGOHl6dVhieTV0K0tQNVhEOTRn?=
 =?utf-8?B?VHdqc01IcGFXM0I3Ly9IN2NXM1NYcTVvTlJFWDIrUlZQK1dXY201N0VLaHo3?=
 =?utf-8?Q?a4lWhefrw8OExOnThs77?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e28493d-e275-45f9-b2a8-08de37969c60
X-MS-Exchange-CrossTenant-AuthSource: MEYPR01MB7886.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 02:48:34.7272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB6810

The skb_checksum_help() function does not validate negative offset
values returned by skb_checksum_start_offset(). This can occur when
__skb_pull() is called on a packet, increasing the headroom while
leaving csum_start unchanged.

A negative offset causes out-of-bounds memory access:
- skb_checksum() reads before skb->data when computing the checksum
- skb_checksum_help() writes before skb->data

Add validation to detect and reject negative offsets.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Reported-by: Junrui Luo <moonafterrain@outlook.com>
Fixes: 663ead3bb8d5 ("[NET]: Use csum_start offset instead of skb_transport_header")
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 net/core/dev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 9094c0fb8c68..30161b9240a2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3574,6 +3574,11 @@ int skb_checksum_help(struct sk_buff *skb)
 
 	offset = skb_checksum_start_offset(skb);
 	ret = -EINVAL;
+	if (unlikely(offset < 0)) {
+		DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
+		WARN_ONCE(true, "offset (%d) < 0\n", offset);
+		goto out;
+	}
 	if (unlikely(offset >= skb_headlen(skb))) {
 		DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
 		WARN_ONCE(true, "offset (%d) >= skb_headlen() (%u)\n",

---
base-commit: cfd4039213e7b5a828c5b78e1b5235cac91af53d
change-id: 20251210-fixes-ef9fa1c91916

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


