Return-Path: <netdev+bounces-209980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAD0B11AB1
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 11:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B5A1897595
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 09:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191B92D0298;
	Fri, 25 Jul 2025 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="vEf5CKA9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4C92C375F;
	Fri, 25 Jul 2025 09:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753435097; cv=fail; b=saix+fSK70sa5gHcCX2dhXlu1Yhii2gDZe/PmET0xqxM23pWm3tFzz25n066IEhJ0ZrPEOHwenj+WgESUL2to4AvBapD/VU2DuJxlkdlso8EVXB0/yzwU6/5euCMyX1l7gdFtkWB29peiMjL0LJ1oQvDpXVG2gjAjH87su4EzhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753435097; c=relaxed/simple;
	bh=ZZpy14l+z6gRxP9bqgid4rgQaqdEYrvjQ7ARveyxyzw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O6BPmSot4V/gbv0++dyk4hgO267Wlr83+wkQ8NVciNSZEMcMtNubTBhp2DFzcKhnlr57yaLFpMm1Y/aUX/ZPU6NV/QVf7YVFWou5w1cBfH2SxoSczOylrI5cy3sFRoGMFxwf7Y5IwakN75TIr5a8zhWIlg2x2+/26DELLq5W+6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=vEf5CKA9; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpR7IQp9w/0Yb+HLU0O50fmwGZ01+bjRTauWJdYGdXpLw2kmjVjsL99RzeQB8llCjSd7U+vQSWC7Y9w2nb9QSLia+I92yHzGL7uGeF+wWD7Rnw+57dSAwfuDKJdfBAEWd/RkbmvWy+0zPoBctX44NSTLBF5dqq78Nj9ZyT7rZ9l1D4oKSThUcMzaNAuy39LPUs03kflmpxtAS6aBLYpOw0RKnpRRtGZIUuYZf0jcmZOwFnHcmCDEY3rtlT1C6QjlsCB9FZseN35G4b/P8lda9RrpouuNRuWxDYLAcFmgfI6mGijgotvkBKmpQ3+Mk2IsiZ7pwS2D37KazYJheHyZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDtuLjL467Rx9/UTD6X8khWbbGNkd0nrmARwnuPajqQ=;
 b=xYmovTncxhmQ+vhHdrbJjetNdzwhM9iN3OSOdRomrdvI02fL3WVTyZ6PPPgI3uQr4C7qFaEMUG8wYJdZuzwVRcysoazi+1LIyJySSU+8IoeiMtv2xPdW+V+XKUOWcmhiXHnRGYLyus9YRpXwQDLe3321/eDGY5r5hX92u5y0ihxcUG4RhOOswsK8aOX1BlzbJfWEpBK3qG80bX7sKgZzcbYXWdTuW5R7d8VbslqweBE+pY8rvs0isG+F6TMgN1Pl9i683vGbKgoU2wGXsCf8n5u+4wafZaL8b7xYa4EY/wF+a5xF+S9bhMMhIrIXe/566BRogX8upvEaspgiNEwJ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDtuLjL467Rx9/UTD6X8khWbbGNkd0nrmARwnuPajqQ=;
 b=vEf5CKA9cEk2i9wm49Hf+zUA4ZQkMDOZ2NLvLWeY+bgMvc1JBl/GlHYPXcNaZN/3QSUjjLs/hFhJVfu8bRJtk6ZD9pHzzLRmapE0aleMLQZlwNFH+3UM4ELH9FYumY0u0twsjtkMMCk393hthOyLy/l4cfQMvwB0/d4Gsec+cB3ufpnRnyFNhwgEV9ldHNkzvP9s28+X5ga0694xeox0oeEibcQGBIAX6QE2LWEpAWOR/aS46s6EqEFsapC3/QrK1dxYsoktBVHAMFyZ7KgRve7BCMvgwEqGwOdHmpyYXfwMPQYwNyC90w+vAbNhsnOlmrLyJQTSJGYdzm1Ckn+TGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by DM4PR03MB6911.namprd03.prod.outlook.com (2603:10b6:8:46::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 25 Jul
 2025 09:18:13 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%3]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 09:18:12 +0000
Message-ID: <a71897db-5337-4ee9-a957-3e68dee03afb@altera.com>
Date: Fri, 25 Jul 2025 14:48:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: stmmac: xgmac: Correct supported speed
 modes
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Romain Gantois <romain.gantois@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20250714-xgmac-minor-fixes-v1-0-c34092a88a72@altera.com>
 <20250714-xgmac-minor-fixes-v1-2-c34092a88a72@altera.com>
 <b192c96a-2989-4bdf-ba4f-8b7bcfd09cfa@lunn.ch>
 <e903cb0f-3970-4ad2-a0a2-ee58551779dc@altera.com>
 <6fsqayppkyubkucghk5i6m7jjgytajtzm4wxhtdkh7i2v3znk5@vwqbzz5uffyy>
 <4df7133e-5dcd-4d3d-9a58-d09ad5fd7ec3@altera.com>
 <tcebsuesjejtk3vmzx77yuo7zil2xciucnnrakubrslwvnndas@utvi4r7ob3xa>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <tcebsuesjejtk3vmzx77yuo7zil2xciucnnrakubrslwvnndas@utvi4r7ob3xa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::7) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|DM4PR03MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c1e6315-1c00-4753-63ce-08ddcb5c2d8c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFRkZEVSUHJIVWtacnh4WStMQnFKWW1FcHE1VGZnNW5NcVBVazhoUzY0SS8z?=
 =?utf-8?B?cEhNbjUxczZ6c1pRSmRvb2xwdU9DT0djWUM3YUVOK0docSszM3Vjbm52bk43?=
 =?utf-8?B?c2c1dHBidXZWWFh5Y3RwUGhGQlBoSy9YRzFRTFgyQTZuWU9wOXhsb1d2N1BH?=
 =?utf-8?B?V2xONjFxdWlOSXhEYkhweFRjV1h3SGZwWFZRQzZMbDU0UGU5cU5HcWpQYzUv?=
 =?utf-8?B?aHJlNHl2ajdYZTduTGFsUnlZdzlpWUYrTmxzb2dqNFJGNW1YTVN4S2FxRlh6?=
 =?utf-8?B?Z3VleU9rQ0tNeHQ0QlZCMFFVVllSdkovalV3aUpEbzBmdWlUTDNzbFdRUXFV?=
 =?utf-8?B?OUxQK05pa3VKU2E2Qnp2RFExbjh3NkxlOXZsM3UxcU51eUhwTCtNbHVMVmtI?=
 =?utf-8?B?NFh5S0VzaDhNUTNaL3FMaStienQwNHQzWjRtRGZoMDB2eE5xVnU4NERtbzNs?=
 =?utf-8?B?OVNmcDBMUXpYWVREcjdWZXh0amZpd2k0SFFzcDdlNnl3QUxDNXVaandFazg3?=
 =?utf-8?B?cm5tWHpNZnNtRmNrQlZtbEx1VDJxNXdBWXhNSlUrRjV2SlcwTVVEMzVCYWox?=
 =?utf-8?B?RXBrTEthMWRwV2ViZno2QWxFUnNUakdwMktVVkgwK0FNNEM5Mk9Ga0drZXBz?=
 =?utf-8?B?bVZQRlRGR3NsWHA1K1pyM1hnSUx4Sy9meXVOYXJQZmNsT2sxS3FXV3hiclY5?=
 =?utf-8?B?NEZ5cUtNUHk5cmIvVWhnTjkvODNoZmtGSlZlNFNpMW02TURJbkFjS2N6T2R5?=
 =?utf-8?B?cWV5S015OG9ybTlxWVN6bXNoVWtlOEw4ZVU0NjJ1MGFqRDI0UU9YdWRxT1BF?=
 =?utf-8?B?YU5mT2ZzTmllVW5Ka0NibGhhM0txWGtjQVBudmp0K1ZXT3E4d1Zodkp3bSs5?=
 =?utf-8?B?aEdLakdwMUNzZGlFb2tpekNZMEZ1c2pibHdCeElFd01qUnB1My9PbGtmdFI0?=
 =?utf-8?B?V3VPSzNxREd3ZVZyNGF5UUU2T3BXeGhNQUpmL1YzOUtkdWp4SHdCYkFoL0Rk?=
 =?utf-8?B?WGdNV2hodXNmOVVDTUxnU1pNcDBienQvbHZBNW9PVGg2SFg3ZCtNUGpIeXVG?=
 =?utf-8?B?eU90ZW9oeXpNNTdoQkpOZkFMNmVEVlV2VEZPTFBTMjBZUTNoTVRiTE5RL2ZF?=
 =?utf-8?B?aGZ3ZVRuZGlWTkMzSjZMNmRtdndnd0FBeUFzWG9Jb1JJYTlxYVJsU21icSta?=
 =?utf-8?B?OTQyclUvd1F1azBwMVlTaWh6Qm11TmZ2azhSTitYNVVlNGVsVjhUYSttbFlz?=
 =?utf-8?B?M3lraTBoRWlYaEh5N2h6OXJnRHBpR2VkMTRtaTZJUUpRRlhOSG01Q0svNkt1?=
 =?utf-8?B?b1BleStVeUJaaWJleHQramdlODNvYlBzMmZJL1dNb0wxdzgyRWpsWjA4N2g3?=
 =?utf-8?B?WDR0L0FmZkpuWTAzeHRNWVpwMmRWc0RxV1NDbmM3a1c2c2J5eDA1RWtzRlFS?=
 =?utf-8?B?QmZwOUM5L29YbGlRcmo1aGFpRVRwRFRpdDduVVNpRE0vVjBnd0g1T1dDcW0y?=
 =?utf-8?B?OVgrTFZxNGwwVkhlZC9uOVlnVURVaTlqLzk4c3MzQTVwS0Q1OFU3ZmJQY2p6?=
 =?utf-8?B?TzJTMG9vdzRkVThRaUFFQkwxS2tMVkkvcXZIZk9GTzQ3NDdSdFlVTFY5QkNx?=
 =?utf-8?B?dE9xUnVjRkozMTRTU2lHYW56eUNCSGdHVEZrLzNsWks5THJmU3hqR0JiZmsz?=
 =?utf-8?B?d2FEYnRNRHFpa0c2Ri9ObzZ5anc5WW9rNlc0L2hNSmJyQ1oycUFHOVRESkcw?=
 =?utf-8?B?Q0dIRVU4QlFjV09lK2tEUERlNEsyRGFlM2RIZm5kQ3BXM3paWkl2S04yYkow?=
 =?utf-8?B?VjczUGlFVXpJM0t6YXYvUVpBSXgrY2U2dXE1NklnbDdjRnU0SWpVc1gzeUlv?=
 =?utf-8?B?cXBGZ1YxRld5M09BUmNZVEtXTi9NcEE4RldRclRYVDhzc2JuOTd3V25HMURx?=
 =?utf-8?Q?rpAYVZgPsmA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTJwYTZxVFlrZWJaTHpOeS9QTHp1dlYwK3hkVDR3RE1Ua0Y4Vi9aZnhDSmtB?=
 =?utf-8?B?RUFmNmFnNG9QTEdiS0gvRWx2eGFzQkgybDlKaXZIZzlVdHNIdUFMRlJzWm8x?=
 =?utf-8?B?NE1nVjhoZXRVUlNPOUhVRDNyM0RzKzJScWRpb1RuYWJWenZtTW5NeHh6Rm1x?=
 =?utf-8?B?V1VwTjhBQWtsZzUvQWRpTjRPU1hpd0NEU3ZJZGFJN3MwNTl5ekw4THZMSzVE?=
 =?utf-8?B?dEdkK2lzUzRSUjc4Z2Q4dUxKRzEzaTFLUDdiWXpxczRmejA4dU5BYTZPMVEr?=
 =?utf-8?B?U1NyQ1R6UUlWenZ4d3NGZ0F3bFIxQTJBM1FXWm5ZSENqbU9PY25FVW5XZmRO?=
 =?utf-8?B?d2V1ZUQzQnBzcnJhSHVxVlgrSXlSU3llaHo0aXVUUnhrTUcvRVdSd2wvSlRr?=
 =?utf-8?B?ZGFVQkdkUVdpYmlKMHB1K2VLTXBRM3oyZXlmdGZac3JaR2NqK0owMnRwVUNL?=
 =?utf-8?B?azYvY2UzYWFaMFhnbzMxVFJERDZUSFdTWVR1QUZQMEJSRVNPaGJhZ0ZQbVVv?=
 =?utf-8?B?b0NLVEFybFRROE1PbEFOT2paVU1ud0laQkxiY1BsdGpQa2U3bHRyVU9NamZ0?=
 =?utf-8?B?eXgrTjhqTjJlWm1UVGFGUUloazE5YmpyaVhXK2k3bVJXekkyWUx1Z3gwcTR5?=
 =?utf-8?B?NmpOUEhEZ2ZERFVrT3A4UTIxVk1LZit0T0NIOGpJR3prNCtuTFlHSTlZRUVn?=
 =?utf-8?B?Vm45ZXQ1bXFNSGhPdzBiSUVBTXVSdFVBd2N4V3hmVk1xMDI2Vm10Z1QycUJo?=
 =?utf-8?B?eHpvZGprMHlaa3pqUnVyUFJpVkhxcGpRRDFpNHFNVFlCdzlLRWprUG12eFVV?=
 =?utf-8?B?T0Vsek44Y3M0NlhUNWdaeGwzK1YzT1dCNjRYNVM2Qmt2TVFxdnp2SDVsRzA0?=
 =?utf-8?B?VDR4UzBNMTlkNGVrZjJxWXNCdUMvUDZFRk1zb2ZlZE9lL2NxUnBOUXZwcERQ?=
 =?utf-8?B?ZmtJZXg3bE9iWEt6d3lGNUxFU0dTQ3ZYY24rMVRXdmxuT3VLRnZGWndkREJJ?=
 =?utf-8?B?UzR0Ukx1SmFrN3lkSDRhdTdxU0dTM0tuZy9waW5MVFpNckhLWi96K04rc0pG?=
 =?utf-8?B?R21yeVlKRDNVdkRiQkdyeThvYTBYVHZjV3NWODJKN0M5TGFXdnlwNlVUckU2?=
 =?utf-8?B?alFWVG1vUlVMQ0FRN2Y5OG5KZDc5KzR1NkpEVzdUM3l4cFhQM1J5OHc3OWsv?=
 =?utf-8?B?eldoUDdib1I0RHEvT2FaNFgxVXFVL0oreGx6RVBFMnRSS2I3NFUzdzhDVTZi?=
 =?utf-8?B?MDNZMjcwbVZqN0RQZ3piSUtnWDNpVExvQjZlWm9Ca3pTYmN4OGlCY3IveVFP?=
 =?utf-8?B?NmJ1SHYwejh0WTY1RENCcmxTOUhKTEltRC9CeXk0aWFlNjlPWjR3ZDdDelJt?=
 =?utf-8?B?OEZLeG9lTzlSSTJsT1hRNisvZ2xFeFU3dG90ckRiVm9zVXpsejZ1VzdBWnNZ?=
 =?utf-8?B?MjJvRmNaalN4WHVvVHZuRThRZGI0M3NZU29UMkNrRE9CNkRibjRyM3RUZG9T?=
 =?utf-8?B?NGpxNVdKTjMrZkgxZ1M2UVNxblRTR2htSHZWRXZiMXNteXNSbzV4ODhQMUYv?=
 =?utf-8?B?T0EyUFQ0OWtKWG5IYURBd3dmV1VqZEN3NmFyYnd4S0NqUEdJTE52U1dWb21s?=
 =?utf-8?B?OWpFQUZpSDRvR1lvRGU5OWZOYTBpZGpGeklZSzZZY1R3V0pZaGtLV1Yrb3RV?=
 =?utf-8?B?K1pubHZ1TVBNQUtJWXF6UXlYNG1nK1haL2RaUGJvR2ZjV01NdXA5eEsrUjFy?=
 =?utf-8?B?Nm05NGt1SGlGdDZkcndkdERLUkVqZDNuMlFPcXVBcXM5YTdTOGx5dXN5bVN5?=
 =?utf-8?B?K1B2dFR3WGh3UktwU1VsbWpUVXQzemI1dGliYk1RZ09pa2RTazlBQ1VMa1pl?=
 =?utf-8?B?ZDFoTURUR0JSQjg1d3NzTXVaSDBJWmkrMzIwdXJaM2NhcXUvdVNTUjNkcFNS?=
 =?utf-8?B?Q2tCcXJmRWRFVGVmT3gxUCsvY2s1M0JwM3JiOU5aQnR2QnlscTJtMFdKRDJt?=
 =?utf-8?B?L2VzOHRNVjRPMCsxOFl6NWJLazcvemFXRWd1UWZjNXoxTjZ1UmFlWGZOdllr?=
 =?utf-8?B?QnludFBOYk8rZG04aHExdjRUaU5xWU9Xc2tSRFRzaEJ0ZTg0bGhTaDJtTU9a?=
 =?utf-8?B?RUJaUGZzNjErSDBEejdpN2E0NGd0TFFoZjJrSkJmV21YMFlBSG5FREtoOGFE?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1e6315-1c00-4753-63ce-08ddcb5c2d8c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 09:18:12.6816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RCydkH8rcZjN1+jw4iRbkRIeh873Gmjazcegzj+9NOVOx+8UMSszL20F4Y9nLl6DnKprFmLXMesh81qnbhvJnjmTMxiW82UCl6Fnzhu7mg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6911

On 7/24/2025 11:26 PM, Serge Semin wrote:
>>> DW XGMAC IP-core of v2.x and older don't support 10/100Mbps modes
>>> neither in the XGMII nor in the GMII interfaces. That's why I dropped
>>> the 10/100Mbps link capabilities retaining 1G, 2.5G and 10G speeds
>>> only (the only speeds supported for DW XGMAC 1.20a/2.11a Tx in the
>>> MAC_Tx_Configuration.SS register field). Although I should have
>>> dropped the MAC_5000FD too since it has been supported since v3.0
>>> IP-core version. My bad.(
>>>
>>> Starting from DW XGMAC v3.00a IP-core the list of the supported speeds
>>> has been extended to: 10/100Mbps (MII), 1G/2.5G (GMII), 2.5G/5G/10G
>>> (XGMII). Thus the more appropriate fix here should take into account
>>> the IP-core version. Like this:
>>> 	if (dma_cap->mbps_1000 && MAC_Version.SNPSVER >= 0x30)
>>> 		dma_cap->mbps_10_100 = 1;
>>>
>>> Then you can use the mbps_1000 and mbps_10_100 flags to set the proper
>>> MAC-capabilities to hw->link.caps in the dwxgmac2_setup() method. I
>>> would have added the XGMII 2.5G/5G MAC-capabilities setting up to the
>>> dwxgmac2_setup() method too for the v3.x IP-cores and newer.
>>
Hi Serge,

Apologies for the multiple emails. I wanted to check specifically on the
support for 2.5G/5G over XGMII and GMII interfaces. I’ve reviewed the
v3.10a databook, but it doesn’t mention when support for these speeds
was first introduced. Could you please confirm on this?

Best Regards,
Rohan

