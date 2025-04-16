Return-Path: <netdev+bounces-183141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E5EA8B1FA
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 09:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7B53B9D5C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 07:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A6D1A8F9E;
	Wed, 16 Apr 2025 07:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b="lLDYpBx9"
X-Original-To: netdev@vger.kernel.org
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1121.securemx.jp [210.130.202.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA79E1DE3C4
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 07:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.130.202.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744788234; cv=fail; b=AB8oki+ddGmh5HhhmlfteJXDU0j7ZkcNJsmXuz+owchSv0Zi5nmfJTpzg2cjsNXnW1un6gdEUBW8mR58yO0LdCwEMEM0MYewB3/kvsED61SUdtvvhhayEV6S4sr93SxgaIq4UGv25V75vrEZDKyNcaVbpMAUz7bILxabiLogKQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744788234; c=relaxed/simple;
	bh=1iFcN16saaUoHcCPEzzMrPLTtu6oaeDZCB/8KLiNxzw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t8qBTcFSAN5Ht5PHLY5nVKnkzO+6jiCYDOs2Z6aRShh4cGqCXwOZ1KF9LH06PI9ImFmgMfgpHBdbKh2yYCf4XY+dGeS/tsfIcLQ9syShpv9WbZ+J/VUInk7R2I0QwDmATzKcWk3qCVn+uNJ5hPtV+LXKFZIUhkA86D6p7Mchu+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b=lLDYpBx9; arc=fail smtp.client-ip=210.130.202.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1121) id 53G4wVOE037776; Wed, 16 Apr 2025 13:58:31 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1744779432;x=1745989032;bh=1iFcN16saaUoHcCPEzzMrPLTtu6oaeDZCB/8KLi
	Nxzw=;b=lLDYpBx9LMrW2mPJp1IuaaXYGcB1ztrG+NBu+U7sa4wMBg8NxhvoncB/7vy+l2dyTH5IF
	t63/qUNeGyd4XnJuR/WfAQAanilcmgfRkOgHb2VNSUcCeeD/kzs6RV8T/uboUYUFiXvJrhbxiyj3R
	ALVkr5/fPlHKtVVeKyt6V8DouBnbXKzwIql+qT2BbKpt6EyCVElAHHy3mRr6mj7kFRaBfFD0grEo4
	MpinscYyi2URslREr+Pq57D3LkEC0Vx+1s8Gxc4tw2Bmb1DCklSwSCDD3JVK6fpoJXyGBxnGIu5QD
	MjX+8S5B+KQiUC6nWL4NywkFMO8d8hcHfw7wTMiDYA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 53G4vAMp2685397; Wed, 16 Apr 2025 13:57:10 +0900
X-Iguazu-Qid: 2rWh5b6vGP9uTwTgaF
X-Iguazu-QSIG: v=2; s=0; t=1744779429; q=2rWh5b6vGP9uTwTgaF; m=8flXb1S9rmKCtzdwEZ+QPuqrsoJCX1U0VrYijPltcEQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 53G4v69r439112
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 13:57:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3F9TSTL5LrehGw1ISKLa58nPu3TRNRb6UOCIltYTEudzE17K33g5zKMB6RKFb8u0VhGgA7JMV+J/m9hvnb9yYE1JPKdjTM8F0/C7SiDRGlrgPXJYIw6ywLkFRJK7gGZBaGuafMyETrHUT7naZUeVH3BolQdy/SpVfrOCXZV927dUKVvwwDjegNWHLZ4JOowVbnW+JSMjIDaY2KGCyb0DMFJBCWCoUv8+9IMTV6JC3mWz6Unw2CytfmStL2MiAfkDv7IxdxfDMfuzs2lLLylUQyqzqeIf+GA9TdwwmoG6Vj07FkTDdm0Vg98TtsMPLKEPxZPkWfVOnIfWL0oLw9nBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iFcN16saaUoHcCPEzzMrPLTtu6oaeDZCB/8KLiNxzw=;
 b=mXiaLJDoisyXuQMxYBaCWScH288U48sxocmLiRGdY+8U79940uMuPlbCJJJBQsd8hhCLS0D5I9w4rL6eedTM3t8rXHxhjwOYx2+tZ+qPmwiG1b0/sFkhuF0Cw8k7MI6E4LrUC8RQNxL44655RjWTIwo4ZyQgg91dsfsqjijo8bfSMVjo0YVqrcZEJYkYL0t79w7vgFY578DE/EGCNCscskk+8vDxWvl0+AVABGo3G8kIRbr28pdfxz0q6BMSfcb6NXwEw4xtmBOhZikQrKel6Z3Yb4wFvQFkfIgzRcv2fxz147rEKke+L2Nimsodnxgw5XH1/10Xxk1MScbzs4W37A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <rmk+kernel@armlinux.org.uk>, <andrew@lunn.ch>, <hkallweit1@gmail.com>
CC: <alexandre.torgue@foss.st.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>
Subject: RE: [PATCH net-next] net: stmmac: visconti: convert to
 set_clk_tx_rate() method
Thread-Topic: [PATCH net-next] net: stmmac: visconti: convert to
 set_clk_tx_rate() method
Thread-Index: AQHbrib2M0uaUqMRpk+uPlXUORCOyLOltZ2A
Date: Wed, 16 Apr 2025 04:56:58 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148186C2CDCC2FC8694547BF192BD2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <E1u4jWi-000rJi-Rg@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1u4jWi-000rJi-Rg@rmk-PC.armlinux.org.uk>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYYPR01MB14294:EE_
x-ms-office365-filtering-correlation-id: d170aec7-f173-482b-324d-08dd7ca31e81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?SXgyWkxWNnZ1QmxXdHF0MWNlbDNxVUk5b2ZhM0RCdFNraDkxNEtlYlYyTTJ5?=
 =?utf-8?B?bEdlN2NVRHo3Z1NTMzd0RkpobXluSUJoaTNPNDl4NVgxOHNZUUpuUXQ1OVVx?=
 =?utf-8?B?dXdlOXNPSlVUT2Q1UVdPZXA0TStwRzExd0hUQ0ZLMWxEQ2Vrbngra2JPZVRW?=
 =?utf-8?B?QkZwbGlVQWg4eXFySHpNcVF0RGQ5WHVldFlpRUYxUzRXSzBiTWJCam5acUNk?=
 =?utf-8?B?NzFyNTFrSWZpQ0QyWHFER0NnbUhFQkZzVW1oUVZaV3VJSHVpRm51RUwrOGp1?=
 =?utf-8?B?MnFkRlhMQXhjcGRJVHFHbEdiU3hVK2EvQno5ZDd3TTdqQTNQQmU2Vldubzg4?=
 =?utf-8?B?M1NLb1BMbUJ4YTdQSy9Rc04rdjJ5NVVieGR4clBuWTAvbGVLWG16RkxBa3Qv?=
 =?utf-8?B?OEpaVlVHNVkvZVllY3ZQNVhsMUxlY1BhRFRyQldUTnBIa0cwNU51QVBaR2RW?=
 =?utf-8?B?bjJkMzB1UWNmM2V0Y2ZqZkRaT3V4ZGxFd0tjRTdqb0pzbzJvODI4enYxR25Z?=
 =?utf-8?B?c002Y2Z6d2FuOEozR1NOZU9BQW5WS0dGZFh0OTRNRlF2R0xoQWlnV2ZDQS9i?=
 =?utf-8?B?ejRqeDhkU0VORmhjWTE4b202d1M5OTZHQitZN3NIMnVHcTlkMWw4Smt1b2RJ?=
 =?utf-8?B?V3drZ25HU2RuZTczVFNqUVE0WUh0QVFvOG03czRHcmxhZEVTRTl4YzhtMDR1?=
 =?utf-8?B?Z3RVMFJTeUltclJEakJDZTgxSk1oWXYvaDhKakNqbnRkS0xVK0I3Z3Z0OVRM?=
 =?utf-8?B?VDcxVC9RUG5pTnRFWjVEYmVyTkdISGRPZ0FiTldpWTBWT3BXcGVVODFyS1R5?=
 =?utf-8?B?bFhJYndVRmhTeFN5cEZQSUN3VzRvb3RsWWdtN3hGaFJNRFBwMW00ZW9pL1Vp?=
 =?utf-8?B?WmZqSXZabm5ocVFOOCtVNjFaTjBFaXNFaTNlZ0x6Z1RtVmVEb0tiL3lPUzla?=
 =?utf-8?B?clNNUE56N2hFQW1wbHpzb2dzQmV1OHBOR2pNQzl6a1NxSlpOZmhaZ2xsQkR1?=
 =?utf-8?B?VkxFK2lLVGloNDJONWtPa0I5Q0Vuc3d0VVRoT3ErcVJHRCs2SVprQnhnZnlI?=
 =?utf-8?B?YUNJdStrQ0N2bDFoRk5kM2hMVC94YWdqQW1jNCt0bU4zVHhERDJLSjBJRitx?=
 =?utf-8?B?cGF1VzJrUzQ1Wm5rTWFsa2ZEbmdmVVBZVWtnOHVHOHBaV0IwNmZDQzVBSnNU?=
 =?utf-8?B?NnMyVyt0ZGt1WEpnMXVQamt2eElJeEwwdjBib2lnZE9YWTdDRjJwb0paWVMr?=
 =?utf-8?B?anhIR3hxZVYwenhMbGdiNDhaN05ZTTEwWTFzM1dzU1dOT0pweFBZTEJucEc2?=
 =?utf-8?B?VXFWN3p0ZDhTb0l5OGlCb1NsdGVqam5BZjZublAzQ1A5RE52Q0V5bjZMKzNV?=
 =?utf-8?B?SzhWZERnMXJ5aWk4N0kxWjVBRFR6TkdiS3ZWL1p3TVhVemY3dHA3Y0VUd0py?=
 =?utf-8?B?bVZleGFJVDQ2clF6d3lWOGtubUQ4ZkZrZmI1NmVWT0JYU2FJcytaL2g2WXBW?=
 =?utf-8?B?d0w0YVpXMnQraHZsdXhzZllMT1BSd3VrdFdHcXZSM1RlNThHMXNEaXNGeHI0?=
 =?utf-8?B?TUt6UTVTemdXbG80cDMwemhKNVh4ZndYQlRlRS9lNHFuOGlVNmNBK0VaMHF6?=
 =?utf-8?B?K05Gbmw5S0cxbktVQnNYRmJZL1NPdmkrbDd5L0hPVU1tUXdwNVFVL3FZdGQ1?=
 =?utf-8?B?VndneDdualowb05NUzgwaDNDT2NhTCt1bjYrMThoY1VtaDgvRmJvNnhla1lP?=
 =?utf-8?B?bGxEZVh4N05IdHg4ajNobXI3eUpxYytXSk1TNEtkMGlzOWFRVDNJSXJoMU9X?=
 =?utf-8?B?Z3E2eWF2ZVhYS0pibCtiMXNkdjc2K1hwb05SMUdJaGdBRUtTSUM0bDJ5T0Iv?=
 =?utf-8?B?aVBqRG5tdnNPdUhROWlnK04yMUtEVUVxUmVqdU5qVzR4NlFOS2hNd1FEcEVK?=
 =?utf-8?B?VVFraHJ3Q0I0Q05mUzgrOGUzQTNRVDZOdkZzaXplOWd4WERod0pyNjZQRmNM?=
 =?utf-8?B?WS9DdkpyeEFRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?V24xMTNqR3hNN1dyNmkvanBqd0s3cUtGSDNiVno0bC9uYlM5T0Q5Z3RGTTBi?=
 =?utf-8?B?NDJJNnZ2S2pGcGx1UzBCTjlDRmh4VTZFTHBZV2ZNQzUrbUZtZUpYMS9Yc243?=
 =?utf-8?B?VWluSDk2c2h1WmpEWjdDZGZsOFlDRFB3TnBseGxwU2M3Z25zK2FSVms1NEti?=
 =?utf-8?B?RFRtZVF3V2M2eU1FSnZNaXlZR3ZSa2ltVWhMVkh1WVdhdVF3R1paU2JSVnVT?=
 =?utf-8?B?RUVqZitmaGtGenRMT2licVRudVUrc0h0UTgzV2czZGliQjJ0Q00zTFloWXZE?=
 =?utf-8?B?L3JzblZnWnhncTYzTlV0bEVIeDdsQnZmVUx6YUVSRkZFZFJ2eWlsTkpGclpQ?=
 =?utf-8?B?clpRRzhDNFNjQml0a2RaU1dkcEN3VjN0QWxwa3V0cFkrc1ZwajVsTzh4SDJs?=
 =?utf-8?B?Vjg5VldpbVAzV3NSbDJmL3g0NFdRSUc2ZjdibkQzcE5aUUxoTzM1U2hiY2Jx?=
 =?utf-8?B?OUtRczc2eWtOYW1GUFhtMHBla1hlZC81ZllnUXVpRHcxWmJINU10U3BFaE5X?=
 =?utf-8?B?cVFObFdxVGt0cE5yUENQUnN2eitOSmxqdkxRS2M3am1QRVdSWFhudFFtajhX?=
 =?utf-8?B?N2dza1JyMGtyS2xzQzVGOHJDRnhDa0s1S3p2N1pZbllUWWdobFhmbXpyTnVT?=
 =?utf-8?B?N0M0STVkTVFuZmtVRjdzWDFQWmdON2ltZ21nbmNTZTZFVWlock5QTmtxa1U0?=
 =?utf-8?B?VGVuYXUzVjlNNmV0enB1anVqemprSHl2OTRPZ0diY1liaFlObzExenNqeUhR?=
 =?utf-8?B?Y2pjSkNzQ3F0L3A5d3h4K3phOVQydUtTbFAwNWdvYVc1QlY0UEErM04vcFhx?=
 =?utf-8?B?RStOQVVwWkJUS1ZXdnJxalpIM3hsVDUyR2R3NWFRR2EyVTlzSE1PbWMxVUgx?=
 =?utf-8?B?dFpjWXBtNXhQZ3MxcWkzNzZoTVBrdUxyZis3SUxrd0twc2hrU2ozRithS2hk?=
 =?utf-8?B?L0VGbk1hZUNlQ3hzMW5wUGNkMVdrZ2hsdWk1Y3UyTkEveEk5enlteXBnVUlz?=
 =?utf-8?B?dXBNK3RUdVZWU1BPUWRxRlM4cFBOcldJdXBZK1V2VEd0Q1VzdDdyOU9qc1h6?=
 =?utf-8?B?ZGk5MjdvdEU4WS9sMmg3MkVXeHdSRGFickZTNHdDMHhhS2VyS0hPYmorTXd1?=
 =?utf-8?B?eTdNbkI1WkNlVjMyQTVLUXdQSGpQNFZNK3pjTWtoMStnaW9rM09BQjF1OFBY?=
 =?utf-8?B?TGhYRTZONzZBM0JJVis1QmQ4VGdsT0svcjRKbnVVenBSaWJEeWF3enRQVWdw?=
 =?utf-8?B?L1BYcWQ1ZnozK2p5bGNleSszdWdoamRuRTNwTmlQVVdUS3o4WGpueTNYdUJt?=
 =?utf-8?B?S001SytubmNRNzhZakJYNkFZNFo4WFhGcmhCcWVTdTdsZjg2SzR3VTU5dzZR?=
 =?utf-8?B?M3B1TkxpMktaM0NXcmY4TzJzbklFUE4rNGxHV04yaHhyTVFXSVYzSDNKZkZH?=
 =?utf-8?B?WnI1TFJ1Z3ByL2xlV3NEeHRlT25FSm9xUi9rbW04bElrNW9CZUhxVmpNZEdF?=
 =?utf-8?B?WGlEYStPdU5MRFRTNXAyQzlZeWo4OENhbWhZUU9uYzFuWUVBRGdoNVdFR0ZO?=
 =?utf-8?B?VTQ2R2Rrek9xKzhXZm1wZThwSzRwamZidjhCMGJKRkd0YXREVDl1eVdyOXIx?=
 =?utf-8?B?Y3psdTNQQnl2b096TDI3NWt3cGZBWk13K2g2cEJsZ3U5bzJhazg4UjdhajNH?=
 =?utf-8?B?MldtdnVoVjhyT1NDVEtJL1ZURzZXVHE0RFpCdndWUFNSUitnTVBPNHZkUnN2?=
 =?utf-8?B?UUsvSFA5TlIyM0NSclBQdEkySlJCNEhzTDNjd29ENVhiVm50c0F5TUdpUzJE?=
 =?utf-8?B?blBVOTNqNFdxbEdrM0x0OEEwMGVoUm9PVG1ieGVrWm5ZcDdiNkRZc0VYVDc5?=
 =?utf-8?B?NjFUZ25oblA1R29oUjhIRWRyREVQY0F2cG0vVEpzdEZ5L3hLdVluSm5VT3lt?=
 =?utf-8?B?cjhEbjQraStWS1NKcHVTR0lPbUpaaTRQQmF0OGw2UHJVYlZDM0lCUVJGUXQ1?=
 =?utf-8?B?MGQ4YU9iRlRZZWlTbUV2bVZBZTJPclhIVXV0eHZGb0RHb0FMdFdXZXhBanN0?=
 =?utf-8?B?a0U5eVBKd2JxMjlJZ0p0MGFvRmUwSWhNVDZDUlo4Y3Z3Ynp3WGJSRmMvUUtO?=
 =?utf-8?B?MWhXRFJEQ3hQeU9ReXEzdVNqVFlmM3ZYdC95RkxtaE8xKy9Gd3VNSTNpc2xC?=
 =?utf-8?B?eHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d170aec7-f173-482b-324d-08dd7ca31e81
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 04:56:58.9601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j4nOmZLUqIwTvpP/fcbbvcXo9oPegwE2VCZ1nDouFp6EdytQ+N15YfsS2I+YQAA4Qc9OzZ/co8Hv7IKJ60XN+C6rpVOxSGRTQk656bHHmC+S3sY+UX6SJv2GV5j8tm5d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB14294

SGkgUnVzc2VsbCwNCg0KVGhhbmtzIGZvciB5b3VyIHVwZGF0ZSENCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSdXNzZWxsIEtpbmcgPHJta0Bhcm1saW51eC5vcmcudWs+
IE9uIEJlaGFsZiBPZiBSdXNzZWxsIEtpbmcgKE9yYWNsZSkNCj4gU2VudDogV2VkbmVzZGF5LCBB
cHJpbCAxNiwgMjAyNSAxOjUzIEFNDQo+IFRvOiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+
OyBIZWluZXIgS2FsbHdlaXQNCj4gPGhrYWxsd2VpdDFAZ21haWwuY29tPg0KPiBDYzogQWxleGFu
ZHJlIFRvcmd1ZSA8YWxleGFuZHJlLnRvcmd1ZUBmb3NzLnN0LmNvbT47IEFuZHJldyBMdW5uDQo+
IDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+OyBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9m
dC5uZXQ+OyBFcmljDQo+IER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNp
bnNraSA8a3ViYUBrZXJuZWwub3JnPjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOw0KPiBsaW51eC1zdG0zMkBzdC1tZC1tYWlsbWFuLnN0b3JtcmVwbHkuY29tOyBNYXhp
bWUgQ29xdWVsaW4NCj4gPG1jb3F1ZWxpbi5zdG0zMkBnbWFpbC5jb20+OyBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnOyBpd2FtYXRzdQ0KPiBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8pO+8qe+8
tO+8o+KXi++8o++8sO+8tCkNCj4gPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsg
UGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggbmV0LW5l
eHRdIG5ldDogc3RtbWFjOiB2aXNjb250aTogY29udmVydCB0byBzZXRfY2xrX3R4X3JhdGUoKQ0K
PiBtZXRob2QNCj4gDQo+IENvbnZlcnQgdmlzY29udGkgdG8gdXNlIHRoZSBzZXRfY2xrX3R4X3Jh
dGUoKSBtZXRob2QuIEJ5IGRvaW5nIHNvLCB0aGUgR01BQw0KPiBjb250cm9sIHJlZ2lzdGVyIHdp
bGwgYWxyZWFkeSBoYXZlIGJlZW4gdXBkYXRlZCAodW5saWtlIHdpdGggdGhlDQo+IGZpeF9tYWNf
c3BlZWQoKSBtZXRob2QpIHNvIHRoaXMgY29kZSBjYW4gYmUgcmVtb3ZlZCB3aGlsZSBwb3J0aW5n
IHRvIHRoZQ0KPiBzZXRfY2xrX3R4X3JhdGUoKSBtZXRob2QuDQo+IA0KPiBUaGVyZSBpcyBhbHNv
IG5vIG5lZWQgZm9yIHRoZSBzcGlubG9jaywgYW5kIGhhcyBuZXZlciBiZWVuIC0gbmVpdGhlcg0K
PiBmaXhfbWFjX3NwZWVkKCkgbm9yIHNldF9jbGtfdHhfcmF0ZSgpIGNhbiBiZSBjYWxsZWQgYnkg
bW9yZSB0aGFuIG9uZSB0aHJlYWQgYXQNCj4gYSB0aW1lLCBzbyB0aGUgbG9jayBkb2VzIG5vdGhp
bmcgdXNlZnVsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUnVzc2VsbCBLaW5nIChPcmFjbGUpIDxy
bWsra2VybmVsQGFybWxpbnV4Lm9yZy51az4NCj4gLS0tDQo+ICAuLi4vZXRoZXJuZXQvc3RtaWNy
by9zdG1tYWMvZHdtYWMtdmlzY29udGkuYyAgIHwgMTggKysrKy0tLS0tLS0tLS0tLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9kd21hYy12aXNj
b250aS5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvZHdtYWMtdmlz
Y29udGkuYw0KPiBpbmRleCBlMWRlNDcxYjIxNWMuLjIyMTVhZWYzZWY0MiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvZHdtYWMtdmlzY29udGkuYw0K
PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9kd21hYy12aXNjb250
aS5jDQo+IEBAIC01MSwyMiArNTEsMTYgQEAgc3RydWN0IHZpc2NvbnRpX2V0aCB7DQo+ICAJdTMy
IHBoeV9pbnRmX3NlbDsNCj4gIAlzdHJ1Y3QgY2xrICpwaHlfcmVmX2NsazsNCj4gIAlzdHJ1Y3Qg
ZGV2aWNlICpkZXY7DQo+IC0Jc3BpbmxvY2tfdCBsb2NrOyAvKiBsb2NrIHRvIHByb3RlY3QgcmVn
aXN0ZXIgdXBkYXRlICovDQo+ICB9Ow0KPiANCj4gLXN0YXRpYyB2b2lkIHZpc2NvbnRpX2V0aF9m
aXhfbWFjX3NwZWVkKHZvaWQgKnByaXYsIGludCBzcGVlZCwgdW5zaWduZWQgaW50DQo+IG1vZGUp
DQo+ICtzdGF0aWMgaW50IHZpc2NvbnRpX2V0aF9zZXRfY2xrX3R4X3JhdGUodm9pZCAqYnNwX3By
aXYsIHN0cnVjdCBjbGsgKmNsa190eF9pLA0KPiArCQkJCQlwaHlfaW50ZXJmYWNlX3QgaW50ZXJm
YWNlLCBpbnQgc3BlZWQpDQo+ICB7DQo+ICAJc3RydWN0IHZpc2NvbnRpX2V0aCAqZHdtYWMgPSBw
cml2Ow0KPiAgCXN0cnVjdCBuZXRfZGV2aWNlICpuZXRkZXYgPSBkZXZfZ2V0X2RydmRhdGEoZHdt
YWMtPmRldik7DQo+ICAJdW5zaWduZWQgaW50IHZhbCwgY2xrX3NlbF92YWwgPSAwOw0KPiAgCXVu
c2lnbmVkIGxvbmcgZmxhZ3M7DQo+IA0KPiAtCXNwaW5fbG9ja19pcnFzYXZlKCZkd21hYy0+bG9j
aywgZmxhZ3MpOw0KPiAtDQo+IC0JLyogYWRqdXN0IGxpbmsgKi8NCj4gLQl2YWwgPSByZWFkbChk
d21hYy0+cmVnICsgTUFDX0NUUkxfUkVHKTsNCj4gLQl2YWwgJj0gfihHTUFDX0NPTkZJR19QUyB8
IEdNQUNfQ09ORklHX0ZFUyk7DQo+IC0NCj4gIAlzd2l0Y2ggKHNwZWVkKSB7DQo+ICAJY2FzZSBT
UEVFRF8xMDAwOg0KPiAgCQlpZiAoZHdtYWMtPnBoeV9pbnRmX3NlbCA9PSBFVEhFUl9DT05GSUdf
SU5URl9SR01JSSkNCj4gQEAgLTg5LDEyICs4Myw5IEBAIHN0YXRpYyB2b2lkIHZpc2NvbnRpX2V0
aF9maXhfbWFjX3NwZWVkKHZvaWQgKnByaXYsIGludA0KPiBzcGVlZCwgdW5zaWduZWQgaW50IG1v
ZGUpDQo+ICAJZGVmYXVsdDoNCj4gIAkJLyogTm8gYml0IGNvbnRyb2wgKi8NCj4gIAkJbmV0ZGV2
X2VycihuZXRkZXYsICJVbnN1cHBvcnRlZCBzcGVlZCByZXF1ZXN0ICglZCkiLA0KPiBzcGVlZCk7
DQo+IC0JCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmR3bWFjLT5sb2NrLCBmbGFncyk7DQo+ICAJ
CXJldHVybjsNCg0KV2UgbmVlZCB0byBzZXQgdGhlIHJldHVybiBjb2RlICgtRUlOVkFMKS4gDQoN
Cg0KQmVzdCByZWdhcmRzLA0KIE5vYnVoaXJvDQo=


