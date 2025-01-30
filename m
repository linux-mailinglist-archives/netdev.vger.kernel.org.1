Return-Path: <netdev+bounces-161603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE4FA229C6
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 09:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D920165998
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 08:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7330C1B21A7;
	Thu, 30 Jan 2025 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="XBQ8WHIQ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2119.outbound.protection.outlook.com [40.107.104.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154131B0F29
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738226623; cv=fail; b=Vk3zjfpQWPyxzuwIBjDFgnEfZ4QYGzRB2Qa9zlXhP1WPgYakzhuSN+V70ci1mEJL+QEG5XfiBfUxfFqtJ7Cki/Ei1t9Z6MNqSDnBg5mT6UFEDjgklTldUSFBM5T4Oz/SKw9YgalM+ZIHktJy7fh3ixusEt5Dh0one6Aciz16fPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738226623; c=relaxed/simple;
	bh=HWV/Y5/S6UjNjcUl0Z8of1s7PdVChqHPzBKttg+Lb9k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GO2lw1obugR40ijL6BJLPob4k6ylS9Qa8d440F8OXVDVf9RRIqudXugVPNdR4KN7k3Pf5Ny4D69f+zOKoF9rhZ784ASBnVffds8xhEyfUmx7be2ztOIjQrHVrrdP9sUl518gRZevBOLjoJXuRCjgZTExJE7NXb+zvlDbWHY5hz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=XBQ8WHIQ; arc=fail smtp.client-ip=40.107.104.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRL/D9HJXhR3fLeBYXH4K3cMA7FGIyzacLavWIAwPuLaUqFRrG6ztBmPivdWyhRf75Ep2GNodvey9pdUuk1Erk5zVxDThCZsSyhxlEdvYwhtWX2jPBTfb3oDZTKBmcgem58Og13pGsr0L/IcpiGUg1F5nFicS86anL/y8ci0CZgcGP8ml+B4Wsge/jftHd/d3Zk7/zsxxq7Kl8yAKRUYXiYjIbvAf1Z3G8cRn5lf0eeBNBU+Js3HKcK8Y/b0cH8lIjpKZ4X1Lb4iWS/c50f5wqv0bMECLYHB91YLZZzeehGP5a7AmMijPN1n3OlfGaQPbfVghSZ7kJxd1TXLM26VLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXczDSj1jFnsgyHEdLuaPWWuhWisbR7lovzeXNzbUUI=;
 b=Ylk6SaNTdEOr66t1x4IOA+Zd/i1jsrjNPKO+Tf3Sc/wHKN2VioojxWPZa0AtPfwsHWkUp21exST7DrK2xu4B0ktbm1Rjac+CH3B2++zxqQNK13zT3c/DQQXwACMcT4GkVJLdjaoBEVHKOifGKfPEZd4CqSkv0GsTv1Z89hoDI56g97W0vIZPeGQgdXcwR2vI7m8lRbcGoMCaBp2cQtTkJ9nOquv2GIu91fGVKQR/QJ5sL5ak+2C217dqjAe0rTiYuYA+dQaQCz2eDHrJ8nCuJGuyVsJeHZ/e2S3XU7dsIQKRhMv2ZLBKnelW+apv9EJAFpLNd/Nn1IrtbHZBzonekQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXczDSj1jFnsgyHEdLuaPWWuhWisbR7lovzeXNzbUUI=;
 b=XBQ8WHIQFleNbrkaZfA1LAnGGwP0hITDmGvIagAlpN1CtMe16yir1PvNpc9YS2gNuCAXXvXTodnPBT+Kcxn4aiuaDLerExB82bmqVGvcroufKQ21RUFbC2XMUvZ5L3NdmF2uDyY9KCgX2U2047sOAfFqLQzSsSJK0NCzOhTnvv0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU0PR10MB7095.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.5; Thu, 30 Jan
 2025 08:43:36 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.8398.017; Thu, 30 Jan 2025
 08:43:36 +0000
Message-ID: <1400a748-0de7-4093-a549-f07617e6ac51@kontron.de>
Date: Thu, 30 Jan 2025 09:43:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: KSZ9477 HSR Offloading
To: Woojung.Huh@microchip.com
Cc: andrew@lunn.ch, netdev@vger.kernel.org, lukma@denx.de,
 Tristram.Ha@microchip.com
References: <05a6e63e-96c1-4d78-91b9-b00deed044b5@kontron.de>
 <6d0e1f47-874e-42bf-9bc7-34856c1168d1@lunn.ch>
 <1c140c92-3be6-4917-b600-fa5d1ef96404@kontron.de>
 <6400e73a-b165-41a8-9fc9-e2226060a68c@kontron.de>
 <20250129121733.1e99f29c@wsk>
 <0383e3d9-b229-4218-a931-73185d393177@kontron.de>
 <20250129145845.3988cf04@wsk>
 <42a2f96f-34cd-4d95-99d5-3b4c4af226af@kontron.de>
 <BL0PR11MB2913C7E1AE86A3A0EB12D0D7E7EE2@BL0PR11MB2913.namprd11.prod.outlook.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <BL0PR11MB2913C7E1AE86A3A0EB12D0D7E7EE2@BL0PR11MB2913.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0257.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::11) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU0PR10MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c83846-8f09-4756-cfd7-08dd410a2fb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1hkcFZqTnkvVGNUTkR3V0pqOHdtYWo5U0FiM2ptRW5pQmdFSzZ4ektuZzZt?=
 =?utf-8?B?OE1kUktOL3lFeWxGTzMxT1kxRDNMMWhxc1haaVZrY1FDWXJsN3ZKT1ZqdjlO?=
 =?utf-8?B?V2Q2bHRQU1RQRm9CRWF5RWZwMm8vajROQkZLSjZINE1tWmJSSFFKZVBtSzJ4?=
 =?utf-8?B?VTlJcmdYYnRlZkRQU21sU0ZzcGxyNWpQOWNqMmxOOG5Zc2YvNnFMWHYzazRZ?=
 =?utf-8?B?U2tzR2N3bG9qUXJVYTZvRXZBQzgxZ0RGeS9TS21BUVExYVRyM0JPdzlnTlVR?=
 =?utf-8?B?SmJnVUF4cFNnMkdyQnZGaC9PaVBILzUySkJRbS9jVDhlbFRRb1dhTjdaWGRB?=
 =?utf-8?B?RXdmT0Y2Y1hSd09xSG53amdIOTdkTTk2MHgvQnRINVJKVys2a1hlSWRHRm95?=
 =?utf-8?B?L3hQZURJRTFxdFZlcThJa0Rxamptdmd2U1VrWlBWYUlON2hWOWYrV1RMVGJT?=
 =?utf-8?B?QitiK0FMQXJ5OUw0SE1JYytRb2hVVDREdDBrc3FXSElJWFdiVHp3eVlxcFU3?=
 =?utf-8?B?VXJpQ01HRUJpS000R1dYWGNIT1Bha1dET1drdDZONlc3ckhLeWR6cnM5RFJo?=
 =?utf-8?B?YUxnNVN2bGptbUt4aDh6dkQ2WnNJc3hjbXRpSE51cGJQdzZJRWFBM0NnL1JM?=
 =?utf-8?B?TEkwNE95VjFOQXU4ZVROc2hkKzZlV0VFYjF0MXpjK2J3OWNuQXRYU0hoLy80?=
 =?utf-8?B?QXJHb3hwbXkwS2lzTFcvekc5aXRPL2J0Qys4MFNDZy9PWDUvdlJ2eTUrL3pX?=
 =?utf-8?B?SHNxRnpac2NWZlBpeHB6YTBGdWZpZ0R1ZXovQVNEMUl3N3kvbUsweEdrOXFS?=
 =?utf-8?B?cjJQVG1NWkg1cDh2SlpZZ0lzR0FpSGVrbjljaUxmM0M3MGZaekEyc3RIMXNE?=
 =?utf-8?B?enlxZ3RzcEJPdHRNN3dWeVRmZkt5dGw0L3RKbDBPRzJBMGMySjVjWDJoSEIv?=
 =?utf-8?B?b1FiVG55N3hFaTRtOUorSzJyT2xPVHorZVNGcklZK3Mxd05zMzZJc29GMU9h?=
 =?utf-8?B?NDdIN1hjVnBLOGRyZ1dOYkk5azY5a25QandxUlkza096VE5LSUdXTHh3VXRT?=
 =?utf-8?B?WjNIWVh5dlhGK2cvUXRtVEN3aDNqMXc2NDJzSmpBUWJuK3ZxTWVVZWZSZkZM?=
 =?utf-8?B?a2xOL1JzM09vOXhiTy9pYkE4TXk4VlVIZ25iSzA5T0d0alZHc2hsNDVFRGI0?=
 =?utf-8?B?KzJ1a2EyRmxiaXo3eFBtdDJjdnBPSm5uYzMweE13OXpUdnpVRXl5aStjc3dU?=
 =?utf-8?B?aHB2QXl0YURkZ1kvR1JaSTdNYWZmNVVlckJic3V3NzZVYmZHT0g4a0lWUWdw?=
 =?utf-8?B?RjRrdEQ3dVM0MUk5UlJBbm1MY05pakxBOW11SVo2L0FMT1JqN1JHN1FndlZh?=
 =?utf-8?B?L3RYWDRWUFZGZkxUVHhEMU5kU295ZXBiVHlxeXplU1dHdnJyanF1SXB0Qk5N?=
 =?utf-8?B?VWRhNzhWYVNaS1J6TWpSRWVlUDZYOXRFcjdkTUtxT0Y1ZDB4R3pXbGRzTmx3?=
 =?utf-8?B?WjdobHpGNGg0OE4vcG1Ea3FrRU9WM1hNMnUwaVFiOHRWQnZNbi9ubXozUWpy?=
 =?utf-8?B?dHcxdEdDd0dhQlU0UE1oRzV5NEhsam9VL1pCTlpLYUwxT3hlRFo2TUhOZ2VB?=
 =?utf-8?B?dEtDbzNFSTBBNExEWUVJL2o0dHp6Nm4wNC95U09aYkNqQ3NKWjNZdlUxSWZT?=
 =?utf-8?B?NFVnaDBpZTExMnB6S2VLNWpJWkxjRG1pM1pzVzN6RmM4OVFFenFaY1JDaUtW?=
 =?utf-8?B?cFRGTlIwdnlNcGM3VE1CalNMdzVMOXM3QWRCMURUdlRucHhiMTdKY0svSG5r?=
 =?utf-8?B?Ukt1bG15SWN3RkZzaFpadz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1NTOWFzQlBROXlnZUVpTmh4aEIyM0dqMm5RMHVVeHc1MC9TVmFlbFRWMHJ4?=
 =?utf-8?B?V3dBcWNGdVJHQkRycEVsbHozWTNpOGZqV0UzQUhnbHN6MW1sR2g5SVRHbE9x?=
 =?utf-8?B?enh1V05UdFN1dHQvamw5akxlR3lPMDdlZFlvT3p1ZS9id0VZOURMdUZIQUxD?=
 =?utf-8?B?amNLa3ZCTVU0NDJWdFdGZkFheERnWTlkcDdrclFoeVg4VU9TS2w4bUZ3L1F0?=
 =?utf-8?B?aTlPenpqcm5ZL2pjSFNtM0tpZXptTlhqK2tyZCszajA3cTUzSGFnVGwvOEZp?=
 =?utf-8?B?RjVsM3ROR2kzYjNqTG9jQmZ5bzJ0bVcrMy9pR3Njc3hNczI1QldyQk5EWXEw?=
 =?utf-8?B?MmtxUThZN2VYWS9oRVgvZzkwajhnTEFmeUhYdDZMcXg5b1owVFdCSU1BcjhE?=
 =?utf-8?B?ZjYwN09FZ013OUdKdzg5dzdkUDJ6ejJ6eHhtTzRjaWlrWTJHVGRDc2lpY085?=
 =?utf-8?B?MTBRb0FoVUhaSjZuMEhMaVNtVktubi9IVWFlQzBYVTlMcldGQklVNitMM2Js?=
 =?utf-8?B?dW83eFFDdUtNZno1RG1HdUErK2ZuZTB5M2puU3FoUGhWZmlKL0dCN0FQL3d3?=
 =?utf-8?B?M0E3Z3FweXRXWjZpRHJrODQ3Q3BRRW9hbmhSUThiUE1XK1ZaWVhGUjdxeWNa?=
 =?utf-8?B?aG1UQWQ0TE8wRG96MjFGY2NlR1JNUEFOZzdiQXpkTVBFRmNjajdhUitDdmw4?=
 =?utf-8?B?aGxrZnNRcmNnSmlCNlZQK3lYYnNMRENEY2FMaHZsNVBiakppb2UxeFV4Yzk2?=
 =?utf-8?B?VWJrOVRQSW9INHZjVmp5U0YvYmpzcTBQZ3hmZTFUQTVFV0lrTVcwVE93ZGVh?=
 =?utf-8?B?TDJDZGdOQlg3KzRoZ3V4WlIwUDNkSlVIa1kwdFdVRFZML2ZVNEc2Njd1Q3po?=
 =?utf-8?B?WU5SdFY1T2pYb0RpL3R5c3FUa3NTM2lrTWdQY3dVMGtXcHpkYXEyVC8zZjNj?=
 =?utf-8?B?c3diWVJycklxblc2UUY3aGFZQlZuOHh0c3F3c3cyNTJEL0RXeHd5bGtMdkYz?=
 =?utf-8?B?WSs4T3pFT0Y1OTBWeGdiUVJsMnRsYTNQem80K0R2R2l6dUdjeGl5aGNZeDZ6?=
 =?utf-8?B?RmVaRDhUY3Y4MXMxVy93amljN3FDK0JDU0xKK3R3ZVBkemExdU9ZWkNBV2pm?=
 =?utf-8?B?dFg5TnpTVVRMSWN5VEk1RWJqQ3IwMi9ndFR1Q2JEbVZmMkt3ZkRhVm9aZXBo?=
 =?utf-8?B?VmNOSDV6bkxWdGNUaFVNMTJyR2xDRUYzbHhIbVlCdmZ0cWx6dGdEM1k0T1Jz?=
 =?utf-8?B?Mmw5c1NPUDFRdlVJaHpjY0NRVGxleFJVOG1hR3lQVGdJeko2K2YzeHVkVFhp?=
 =?utf-8?B?a2dKRkZEL1FWcG9UVDRuS1dpUGpub2hDUnJWcGduSWdGN1VjZ3QvTzRvcTY1?=
 =?utf-8?B?N2VuaXo3T21IY3JFY1lBNG9wa3ZSTS90eEZWcU5kUmtyWUNmUWlNVmtCWWZh?=
 =?utf-8?B?WTdkcEswS0dWR2ZSS29HaWdLNlFJZXZqZlM2OFAxTXBvL2pDN1RFeHI2b3RQ?=
 =?utf-8?B?ajRRRThMWitEeXpJZEhybUlwSmx1S0hrT3VVR3kwM2QyTG1GU0xmY2xBTVFV?=
 =?utf-8?B?dnh0RkJURW1YSk9nZFhQN2drUmM4SXNoNE1jOWt6ald1ZXVmRUJvbU5JRUZX?=
 =?utf-8?B?R0RHUCs5U3BUTmUzeDhMZ1ZteE5zR1o1TFh4ZGpsc1JxdXUrUlhCYmpzeWZG?=
 =?utf-8?B?VXZQbU9jRXRDRkRMT3NDNU1kZE5SSlowU0JpaWVxUjg4RkNrSWUyWi9DaDZU?=
 =?utf-8?B?Q0RuL0M5dGU1SVBUa2NMcHpYMHMwMDRSRW9lWkRZT1gwYndTTW95YUsraDdr?=
 =?utf-8?B?Z3dtS2JkZXFxazhaWkFyaDRqb0M5RG0wSkh0WCtwdzVjeDJaMlBBYzZWOTZN?=
 =?utf-8?B?TVZoWGpwSU5nZEJSRkpSaGxiVEFvR0l6cVlOMHcrTkxXdkJ5NUJQYnZDdkhB?=
 =?utf-8?B?dmVCNVB5WnJrRnJ4Qy8vSEFxQ1I0RmlxTE9QeFFORmVOWS9YUTdlMjBZK1hE?=
 =?utf-8?B?b0N4Rks4Z2pRMHYyMkY1VzhXZUhPaE1tQnBRQzFEM2NWYXFScUZnUjBGNS8v?=
 =?utf-8?B?L3hhL3l0SDRRck5Ed3lTWTlRbEpCMHk1L24zR2VkQ3d5UU92QklraWpoRk9I?=
 =?utf-8?B?dTBHZjAveXZqOHpDaDgwY3lnU2Q2d3hDM2dpM1g2QW1CUDNJM1NuU1NWV05o?=
 =?utf-8?B?RVE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c83846-8f09-4756-cfd7-08dd410a2fb4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 08:43:36.4157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTg4YhYCOn+PSpun7tztSs4sDh1pXbAiEv9iMksIX/bfIu+1pz7TAeNKY5QkaA0aQoQ5GSCJNgJi+hIG54PmBEtxhMCQD0bY3GBRoBVyeG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7095

Hi Woojung,

On 29.01.25 7:57 PM, Woojung.Huh@microchip.com wrote:
> [Sie erhalten nicht häufig E-Mails von woojung.huh@microchip.com. Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi Frieder,
> 
> Can you please create a ticket at Microchip's site and share it with me?

Sure, here is the link:
https://microchip.my.site.com/s/case/500V400000KQi1tIAD/

Thanks
Frieder

