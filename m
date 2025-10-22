Return-Path: <netdev+bounces-231785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C8EBFD60E
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66EE61881F32
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D784435B150;
	Wed, 22 Oct 2025 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="epZX5kgu"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D7435B13B;
	Wed, 22 Oct 2025 16:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151843; cv=fail; b=Ypt3pmvdUj05fe9n+QcVMlIc1VRNtfTujyoU1fBLKdjUty2qO74cQvGnpzfjG9HhbRZk4tBshdVG78SOkYd/zRwyUfiG51Zzxyz/ao23jByEqfHCdCQ9azNriVylRbbazhnXzw7dxdq5K8p7lW/WMRY8zYXv8JiYIMTdh8MgdcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151843; c=relaxed/simple;
	bh=HFafrg8Y3Kb+5m8ufu9J9laSV6MXi44zh/7UDCWmMHo=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=QZ+24ZgtM9oFOXdavJAm+nS7iWWdgf8dFjHSuz77tuAINWfZQs+IfpStGkzcKi6xPnyUk8UCyfi2uKe1zEGOzd02knwTzbpYhDKgqGaWj2IFe1QY2QCcWPCX0AeSAMD5nET2UWvcML7rnERx1UqEs2+lwA3S7pmNTEPhw8qHHYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=epZX5kgu; arc=fail smtp.client-ip=52.101.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKQP0bKZ5tV+TKoyg8VFtb6szDX357F4zgGMf9bg5o+50p1l6eY0Pbww9A3koH/P/zjt1HpToaxpjKY+/ZJU0wdl8HgJvJJuenMhqwH67lZg5Kcse5b44Y/R3+pIDlIhc/MhNo9zmstH/CpM46YAQ+4khohWObA6zOcZJMzA55IarWJm0P2/DXLJ/4lJAOemKtqvmSllsjFQNR5THWezOzd/SGfb5pFRv7RGi8UC33fjitgloZbSyMCULJv3hRD++wRxjTCO2E35FmyQtF415oeOChKypz+Qf2Lan0R9W7lFgrghp3oN2yC68y+iAgEgVSuF8Fmoc2RRs5zrndGpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMjHN++KkJxZ2pbgN32UkH437ADNUtUhkJsPOXHonDw=;
 b=DekReaGuWhPKXwYO1lTpYWhp7Zdl4ju/rH1d0zh7ESRvt84x6kvIiIO0b9dbGjGgC9bhlUPMb4exsd5+MYUW9DSyeVNfa3+yeymONE3QcrHyWAt3EWSnGbndawVhRGCP3uCwm3lgqiA4P7UGhG3IfWqfbMQ6oOXL6ie6D7RBrpHdUaYIfklMseHkGFGd4w5e+0u63JK68X5MUCmZAp5hjvswga162NCr4MQpPA6PvRwwENKQ5dglV/Ga/fOxfjLYj3XSE6O0tLfTerk7whNDsvPlGFwg7rGh4DlpNQXgwuzWVjUN4eLLrcMUzaBT6A3cCuW/VeFlZ9vDWKviMVt7BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMjHN++KkJxZ2pbgN32UkH437ADNUtUhkJsPOXHonDw=;
 b=epZX5kguCnwiGgH1CXrCuZFcoqVYqSqz4Ia+1Ih/jCxO3XuCmiZXYToVpLrJhtZ3w7+qkHpv3r335V+A/QrGD9dNMhjori+/EIhNIxXvrnshiZciWyaf+QBcdRwGNYTN/e5SFyKjT8WehXyNLLcNhVjxPGKhyrdOTMENVXZZcDVxLw5Zob+w+YprTX7TkT7hzEkLFAh0HSCSx1X4zMs+qDC5MiEgz0zSVVzUPEGK3OdWYONK8fg6YRQmdQsAh32uMoQEnjvMfM57WZVL+g+UmmWPu7z66Av+zqWra6M/V1nHEmAmPpdBmGY8bAu+yFiz5G21GVwESDE51OR7hrW1Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU4PR04MB10401.eurprd04.prod.outlook.com (2603:10a6:10:55e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Wed, 22 Oct
 2025 16:50:38 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 16:50:38 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/8] arm64: dts: imx8dxl related fix and minor update
Date: Wed, 22 Oct 2025 12:50:20 -0400
Message-Id: <20251022-dxl_dts-v1-0-8159dfdef8c5@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEwL+WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyMj3ZSKnPiUkmLdlDTDtDQjA8NUM8tEJaDqgqLUtMwKsEnRsbW1AL9
 HLKlZAAAA
X-Change-ID: 20251022-dxl_dts-df1ff201e69a
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761151835; l=1149;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HFafrg8Y3Kb+5m8ufu9J9laSV6MXi44zh/7UDCWmMHo=;
 b=ScNoNGu+8TUbDbcFKxko+ScEe9KE6DCwpQ9U+C9bRRDYrFK3GVzApVImaS0R7K1bgq8fs9RY4
 VCNpNdgKxEJBuSGGuoXZ51ULqQ/5hKQzRvVd8NCXceQVJhJ0sqANbco
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: CH2PR14CA0037.namprd14.prod.outlook.com
 (2603:10b6:610:56::17) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DU4PR04MB10401:EE_
X-MS-Office365-Filtering-Correlation-Id: a38bb87d-fb57-45c2-56b3-08de118b20e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0ZuTjVOYWtqd0IyeCs1OGlGUWI0R0JHbG45dHJiZ2ZnNm1HNkJGZ3NQcC9k?=
 =?utf-8?B?RXdkN3NIK05yUUtTaEFLQjlTd0NmcmdDVUdTOXVyNmMxblNySzI2MStYUzNi?=
 =?utf-8?B?K3Rzank3ZE5pSHFKa1UzQS9temE2ejdjdWs4dHA4NWNaWk41S1lJTElQaERR?=
 =?utf-8?B?VldjenMyRHg3b0tnNGlNaDRiQ1FjVzFjakxYM2hxcnJlVFRCbnA0dUxWNVFu?=
 =?utf-8?B?UVR0UXdVNDNiOTEza2VqcTFkaityaE5va0VRWnJDY09lNGt0b2tkWXpYYUxq?=
 =?utf-8?B?NUJWcnZ2MUVYelBCclZhSXRrSElrVXFyN2xYWExrYXJKWmt3aGNtOXpsa0Jr?=
 =?utf-8?B?YVFYSllLRlBnNDYyeGV3VTdJRlBPblNZc1I3WTg2blgwaWVmRHl5eXNtUmlL?=
 =?utf-8?B?ckhJQzhNU0JxOEpTd0JEbmxtMy9GeVZ1LzY5SUx6R29KazBGdUo3bzVpcHdx?=
 =?utf-8?B?MGlXR0tPdWR4Mnp1dDZWN1A3NHg3ekg3VGZBZVUzRHlCT2tXYXdnayt0VEhl?=
 =?utf-8?B?djhXaUNGL1FQblBJNlllU29PMlByZzN1UkpzZDJlMUxLWkt0U0gyRUZuSHhz?=
 =?utf-8?B?bWhwRkxpUnNKTE8veUhZYk4rT01qOHZYM3BndTlLc0RSdzY0bytxMEg5TUZz?=
 =?utf-8?B?K2g1YnI2YU9qdW1wNXVCcHpYMTNJQ1BJcFF2VG12aEd0TFdZbGpoMHUraysw?=
 =?utf-8?B?dmdTV2laQW1JS01lT1RrcDVSb0RlUEdzeVB1K1JENE1JeUJYRDl0L2pZZG8x?=
 =?utf-8?B?MUZPSWd3WDVNNCs1aWRPUkMwdzBZbnB6ZnliM0xjRXF2b1FRM0paMGhHQ29j?=
 =?utf-8?B?UDB0S3Uza2ZOY0RnN21zbnlNMUpUd3hUVno4N1pDdGF3Tmd4ZmZoMVppTzlO?=
 =?utf-8?B?NFNrT2NDN1YzNVA0RGNWTWJYNEllTG15VGlGMkNoMC9ZMWhvLzNjQ2dQaHNo?=
 =?utf-8?B?STJMK2FLS1ROckd4OFZOclI2VlN5aG00bUFYNFR4TFZsaXF3SXZJRHh2eklH?=
 =?utf-8?B?ZWxFNzZhaURyOC9PZG5lSmwyWURNNlVIeGJncURZZUV2MitlT1dBVU1DeTJy?=
 =?utf-8?B?YVlyZDJHUU1HRmMyUXAwV25zelkwWmJndW5XQnB1SVd2amxjbjU3MmZBUzJZ?=
 =?utf-8?B?UnFFSVdjMjRIK0hoYVcxOXhwSm5BYm9RdUVRZkJ5RC9ueHFkRHh2Z0xnLzcz?=
 =?utf-8?B?VWJKeThYYVI2N0FORkphQW04QlRWdEIrVXRHZy8vOE13NEE4OEpmeHFUVnZO?=
 =?utf-8?B?dTlkektXOUpQaC9TWXU1VkcrenpSamFzSEFrQUcwdmhidWxtbGROSXlBYmpm?=
 =?utf-8?B?RHBPSHo1TlNjRXF6Mzhtd3MzbTFtS3VPdHRXbWQrRjVOblRheitCRDNOZGZr?=
 =?utf-8?B?V0dlOVpVaWxqS05qYmhzclFkQm8rQXhTVFlGQkpWQXVCNklVZWIweE8za3Z0?=
 =?utf-8?B?eEc5NVdsdXZLVmZSVjJPakU2VzBKakVHWHdnVGVHUkRhbDlDSHNlRmJPK2JD?=
 =?utf-8?B?Q0pLWHlPTXd5UVluampBeFlCaW5JdlIyQk52SFJESGdKeU40bWw3VFFjc05r?=
 =?utf-8?B?VUp2Um9TVjFIRk4xbDV6NEpUemVjSkJWY1BjV1dsVXY2eUphNDZyaGYrekVX?=
 =?utf-8?B?Wlcxa2hZTEVIdnBvNEpveFd4MGdLN3lhK1IrQ2tTVVNWR3lQUmM0emtmM1Qr?=
 =?utf-8?B?R0t0NnRQSWo4UEw2MXMyUkQ1d0FXTC9IdFYwRzlvNitUUm1rQnBQcUVzRkNF?=
 =?utf-8?B?TUdQVFNjM1NVd1VzMVBIakVJS0ExTDh5TmdaRFVvU1hZMW9Ic0IxeXNyWW1l?=
 =?utf-8?B?clZjZFM2RFNiTnhJM21QdzJyVmJVTUorcUR4OFlvbFh2bEpkZi9GSHhnbnRi?=
 =?utf-8?B?eTAvbTBTaTdEVGE4MDBFcHMwU1lKWEdhZGwxSTBNOFhsS0djK3l2c0ZHQTNs?=
 =?utf-8?B?UjE3bE8vQUZ3MXhmZERhcUdsY0pwbUVVOTFKYU5TcXc2L2RyY0E3bkdkRDNk?=
 =?utf-8?B?T0l2QUszaThSK3lBU0FKSzFERjBoY05wZVdkeUJsTE9vS3prM0hzSWVCeVRy?=
 =?utf-8?Q?GZdQ1E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REhjSURsb0xDY3hhbE1LeXVWaVBuQUNnQ1I2Z0JkNXF0VHgxb2RjWGg4elBW?=
 =?utf-8?B?aGVqZnVYaS9LMjdCSXNGdDZPeWUvQ3llNmNnalhSeWhjTXoyZnJxa1RKQ3hH?=
 =?utf-8?B?Q3JkRkJHWVNTeHNHaS9TS2loY1VUeXJwT0ZPNHkxcXJEZkpvZVdVRW4xdXd4?=
 =?utf-8?B?RXgyYzh6R1FBdTJuWVJGd0Zidk1WVGFmNWI5bjJKaUY4WTBWNVI4eXRtbEJw?=
 =?utf-8?B?TjVHeVpla0RKZE9DekgxeGVUZlFiakJJTTd3cE1pMklHRURGa2tjWTNLM2VJ?=
 =?utf-8?B?b1Y4aGVJYyt4cTFtRmw5T2lzWHkySlp2NHdOanljaThPNEU4WTFkN1lHQ3lt?=
 =?utf-8?B?aGcvRENZandTSXVaY0xuRThnTkVJeTNwb2NCdFVUZkZXT0tvQkpDRnAyK3ph?=
 =?utf-8?B?U28zNEtjT1llVVpyZnowUnZIZG9aSzlocW1zbng3NmtwWXpiN1F6M0s5ZjlM?=
 =?utf-8?B?alBjWmtYRWE3WG1MUHVBdTdQencySk1LdzhOK25HMUhmRG4xVGIvVjE5UnNN?=
 =?utf-8?B?aVJDWk41ZzU4dEFzZWZNbmpkOVFtbzlRMTN2UkZYS2tFeDA0ZVZadWU4Zmhl?=
 =?utf-8?B?RlFXU0lMNUZyKzFZaDJmM1JOMWhIYTl0dFVhM2dSWHpaRmNhQXA5N2ZFeEdi?=
 =?utf-8?B?QjhFYkpsMXRPeE55L0lIbGdkcnBWTS9FanZPdWlta29KbU1HQnRSYWlFeUZV?=
 =?utf-8?B?L054eWt0UHlMNXJROEVDeVB5Nkl2U2NpYVYwYVU4NWFMU1B3clFRSHdrbGtj?=
 =?utf-8?B?czUxZ2lEQkZhNEFVU05SQThFNzk2Y3M3MDg2ZHcxUzNiWFhCQnd3bzRWZ2ZS?=
 =?utf-8?B?UXlETlgwZTJvYUNJcUxjT2lRcWdYRVlRUUkyc1V5WHBlaUx2czBRbFQ3T1Ni?=
 =?utf-8?B?TzNwYWxxaFhCdi9TdEVKUXBJV3lSY3lmQUpLQ0ZEZlQ4NVFMNlRvaFZhcEtp?=
 =?utf-8?B?bVJURWprQ2hXbnZBalhUaEoydXBHYVlnNTdOOGU3MysrZ0VuUG1MYmFzQUFh?=
 =?utf-8?B?a0kwZEgyUGpzbVZMNkUxSU13N2xHRWRQWUVjMGhUdk5FRTNGUDR3VjhpYTEy?=
 =?utf-8?B?aVRNdEhVN1hZbzROTXE4NUhDSjVSVURQN0IzY3o5TkpjSFdPT0k3cGE1aG9v?=
 =?utf-8?B?MHRmdU5sUSt5OHVKVnUxekRkYTF5Yk56N3JCU0lmUE81a3RxVGFDY2JoaXVN?=
 =?utf-8?B?cG5PM0RFZ0c1RjFsUDFkZkVlYUQwdWhzQmJ3ZDIyajBFeFZ1VVl3YStjemdZ?=
 =?utf-8?B?NzhEOUJJaXJtd1piR01oclhPZ29QUWdpQ0tlSFRRUW9wTDhpWDFOOCtEQXYz?=
 =?utf-8?B?bDdySDExRXlBVzlJbTE3MWk5V1YxS2VSSExkd2U2VXkvUVplK2haeDFFTG84?=
 =?utf-8?B?SXBwNjdjVHdjT0k0V2pxTGp2c2xIZVJwT3hqRmdTMFBRMVk4T3JjQm16a3Jh?=
 =?utf-8?B?TXZZQjB4TEZBQXU4Rml1cjhrL1VYRDBXZHJnTWZvTzU5bzlDRHplZkszTUJF?=
 =?utf-8?B?Zk1vT1RTK2pkQkEwWURiOElaZ3FVZjNYU0hvN3BrUjF5YkJhZGl5Q0N5SFM2?=
 =?utf-8?B?LzJJYlVmWTc4cW1iVnpzcFliRDBNK0xPMC9DcTRpS3UxUXkvZVZ4Ujk1ZElQ?=
 =?utf-8?B?WFRYV2Q4TkZ5bERxRHZ2V0IxMlVwNnM0V1gzRjZwTWN2dHcyV2xqeGtDNmhR?=
 =?utf-8?B?akNWY1NLSDRablhsejV6MFF4UmYyZEJVWUgvdmR5OGZmakJYU09BTHU4NmV6?=
 =?utf-8?B?TnZNNlNqSUlvSzBXNGswVlRqTHErS0lHY2xJb0FDVTVBQzZ1WXRsRjlGNk81?=
 =?utf-8?B?RzFCeE9NamEydTBkd05pUkVOcXZHSDZrUk9LNEdxQ0NFai9DZ3hZdXJuQ3dh?=
 =?utf-8?B?YkZFWGdzUi9RSThrSmxHZDEvd0dIZ2xRMDJjNGwzVlRjM2Y4d095cWp6Nk9R?=
 =?utf-8?B?cFV3akdxMThwUUNLZ2IrR0ZzM1prQVp4ZG5DL1FQYThuYkgwcVU3dmVEWkZ1?=
 =?utf-8?B?aHhuREt3KzhRNUF3N2x1S0J4RGxILzhwUkpvMFhwL3lSREdNREpQd3pkYTlX?=
 =?utf-8?B?K0N2SzlsWWVRMzdlK1Jvd3dMZWpmUGFUa1pKZ3N2cngvQUVCTTFiZWVwVTN5?=
 =?utf-8?Q?wb9lIlaT4KTYR89fKoY3VCckD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38bb87d-fb57-45c2-56b3-08de118b20e5
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 16:50:38.7147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/TEFFm07tHYp6ifMhBY77kZ4bgSdMiL9PhPmsWCpAynW6GRcJs4vOd98O0vawCa+R4kWhwfdw+w8L3HvundJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10401

imx8dxl dts some fixes and minor update.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (7):
      arm64: dts: imx8dxl: Correct pcie-ep interrupt number
      arm64: dts: imx8dxl-ss-conn: swap interrupts number of eqos
      arm64: dts: imx8dxl-evk: add bt information for lpuart1
      arm64: dts: imx8dxl-evk: add state_100mhz and state_200mhz for usdhc
      arm64: dts: imx8-ss-conn: add fsl,tuning-step for usdhc1 and usdhc2
      arm64: dts: imx8-ss-conn: add missed clock enet_2x_txclk for fec[1,2]
      arm64: dts: imx8dxl-ss-conn: delete usb3_lpcg node

Shenwei Wang (1):
      arm64: dts: imx8: add default clock rate for usdhc

 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi    | 20 ++++++++++++++++----
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts      | 13 +++++++++++--
 arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi |  5 +++--
 arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi |  5 +++++
 4 files changed, 35 insertions(+), 8 deletions(-)
---
base-commit: 0d10adc5de0077ec21554769f55fd5b40a00b8d7
change-id: 20251022-dxl_dts-df1ff201e69a

Best regards,
--
Frank Li <Frank.Li@nxp.com>


