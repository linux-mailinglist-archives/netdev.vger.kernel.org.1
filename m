Return-Path: <netdev+bounces-125794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE1A96E9AB
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 08:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C02284740
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 06:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA6E13B2AF;
	Fri,  6 Sep 2024 06:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="IWaOBwGe"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2138.outbound.protection.outlook.com [40.107.215.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC16131BDD;
	Fri,  6 Sep 2024 06:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725602783; cv=fail; b=dYkruilx3a9gwnpSefZ2EoX3vXINrIBu0lD7HHNpsVKhISwnfNp5wX7oKH4muXvvh4axXGY9VYeNLdW6+j9yWjrB+f+uxa2GM7IJlXE6HEingt0MHtaK9nU9buVGzd8Qsmp5RchBagrwmf5MrY8ikyzeH19q+xBmVSZG/kQQ5jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725602783; c=relaxed/simple;
	bh=dQTKWTrRuivCu1DXUtxbUmGjyuO3ZSHhYBMbanqEasQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uDlu8IDgWarM2eQyxYXZUvXGKrnZ95TezYkAV0B91shbOYAcz6tXoBmwTdv6URkcR7f4rpybnrysDElywMY/K/VgprgP3/KWd0Nqq7LnLfel4s0ZgyOKiar6e+TnXBflHEgB8aVZi/xNkfPpqm2RB2LTcZY604mBJkJ7wFFj0Kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=IWaOBwGe; arc=fail smtp.client-ip=40.107.215.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqlAVPtNvlpw13bTum1BqZBfg3cIGw/ruaQADisJQO0cZJAlcbIHdtPe20j/WigbWVG/GUp75UNks0WJKwZL67AXIpZG4egkb5gldrUTBxVSuf2Idk5eLG0cEoCwOLkHmpeOJfS8Z65jvIN2NT9x5yk96/HoUHwVyNeTQknQF8IfrSPMYOb2mWy/wq48C/SWybh9UMFFdIgFCSgP6EB5JBzWWeUniNIYBN7sDsiNJEloDDboyocihvYRQw9pXIqnKpRolkTJrFNPpOu2j1g//HGw/mMs5Dh9Rv0DgNHYrzx6YfCnqvet6QmpHDlT6S6byn6riUkC9d2D+4ebGL3hxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQTKWTrRuivCu1DXUtxbUmGjyuO3ZSHhYBMbanqEasQ=;
 b=LU33yjycegIioLCVSEXXuP9U/Bouxw1xrF95sRYaCeESt6pz+meOVMfuYGRlIkwaLZL9V1HiCNFtcllf31yvAeXLKAoWW9EI/YnDBcdfbB8DYVM0yIYKQqwUuJcvviD/O1SmCCAkDRhDr7NHVa50oVD2Dit7U0CQdfyIW2mKOiVe8LPUozAYqm7H0UT4KYy2CTcNAeXGHqQRPjMYESghw1WuWl+RPLxQCCKQzBJwzkBp/rpBnqUwPN5p0xFnnSGXp9IPHatAmBfZMKhhR34OAuuA91be02fItc4wrp3tVeTpXW5QWUDh6mzw9hbWuZASsCZhxLZ7xrveNaf2rWw+6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQTKWTrRuivCu1DXUtxbUmGjyuO3ZSHhYBMbanqEasQ=;
 b=IWaOBwGeyZ0KeOrwK4yf3rqmJ3seXHcmO1rJJQk2Ty9AUGzOON1oonjo+3+jI5MJ0udlVWwVV6qkqqbW8Ejd/dujv4mX7j8xoWu5Tr5L+Y1rdbrUVCrAzCmqgDZkj2Q5VkQrh+wFgR8o62BpHEp7ZCuHK0rd1h6OiHsULuu3mrtAUSdFfuky8P2weXmetx2mP7MqtSf2hNGaKhLlG+YszH5/afoU8zWtVAGCDMl5cO0bY7M+OcRKBpWADLv2vVes3jw7HpEy3H+UheuH17EeyLpHemYnNB7H+qCzoePfKTDgPSjd8MBHQDTQNcwaY/VOYLRzJyWLlm2Liu2BI1VgBw==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by KL1PR06MB6109.apcprd06.prod.outlook.com (2603:1096:820:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 06:06:14 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%3]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 06:06:14 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>, Jacob Keller <jacob.e.keller@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: [PATCH net-next] net: ftgmac100: Fix potential NULL dereference in
 error handling
Thread-Topic: [PATCH net-next] net: ftgmac100: Fix potential NULL dereference
 in error handling
Thread-Index: AQHa/1rfMsgzpIAVIUKgpr/yLMfBE7JKRNDw
Date: Fri, 6 Sep 2024 06:06:14 +0000
Message-ID:
 <SEYPR06MB51342F3EC5D457CC512937259D9E2@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <3f196da5-2c1a-4f94-9ced-35d302c1a2b9@stanley.mountain>
In-Reply-To: <3f196da5-2c1a-4f94-9ced-35d302c1a2b9@stanley.mountain>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|KL1PR06MB6109:EE_
x-ms-office365-filtering-correlation-id: 1737d17c-2d76-4376-7eb5-08dcce3a0372
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SGZaS01yWUdoNC9JMFUwYkh0MGh0ckFCR1cxckQza1JnSG1qZk5TbGsxVTZX?=
 =?utf-8?B?cFBvdTZQTDdLTFQwZE8wSEpUYzhNZ0RRNGlYdHVMVWcyVlAzTncyMldEZkRF?=
 =?utf-8?B?TWFYN2RxZ2lBalh3QytMNFRncGtZem1zSEFsV2l3cFNBU0NFRmR1ekFPeE5V?=
 =?utf-8?B?emlyOFU3UmdWTE1ia3pxMmFGM3oveGZCUWgyajAvSFUyYkpUZDdTUVQvelRT?=
 =?utf-8?B?YlYxd1VVcFIzemxHdW43REM5K0EveGw5ZjBUUW5mVFNheDBEZkRwNmV5cmcy?=
 =?utf-8?B?am1GMG5Yak1TQ25GT1o4d1dxdU40MzBOUXZGMGdCVzAwR3VXZUVQNHZKbHJu?=
 =?utf-8?B?ZTJZOGJGNktxMjl2c1VPNTc1ODNWSTVKQU5JMXZKd2pROEtPVU1xUGlmYXFQ?=
 =?utf-8?B?Sk5LdnlRVmRaWVlSREFVcTNmOVBDZ1lKWDJGWnM0VWtrb1dNUDRJczZoa2E1?=
 =?utf-8?B?cUJ2RzdMaU1EVlkrU3hoNS8yZEdhcldLTUt6RzlmeWFOSUUyYUxDaFYwSExX?=
 =?utf-8?B?TWFDb3MwSEY3eGFPU2k1VmZNVWdScGVZY2tDMjRBV2F4ak9yelRDM2RwalZO?=
 =?utf-8?B?Tm5DS0grcklFSHVsOU5yNmd6ZDFQWXJMNE1qT1pxSkJiMC9HQmlnQ0dIVEwr?=
 =?utf-8?B?M255YjIxZGJROGpwazNycURHL2dBVzMzQ2xFTjRJV3BHNTlwcGVNNitTQWFw?=
 =?utf-8?B?MTd3WkFSeTFFMktjRUN0VGxHTUxmcXh4Mk9Yb1BPalVhMjdMRmNJejBqOHJn?=
 =?utf-8?B?SWg4bWVwMktXYXRnUjB4TXVPcjBwYlVSSnBiSVUvRXRzbklJZmFjcUliOGwy?=
 =?utf-8?B?SnRPYVZaV1QzbkN5WXp6QTZUMFk1eTA0SVNCSHV0VUtVcnVwd1pOdlduTHVZ?=
 =?utf-8?B?c3BYUUNGTkpEQjlMaUdCYUFVOS9PeUppbURMenpOaSs0USs2VHd3ZUpJZEVJ?=
 =?utf-8?B?anVJa04yRjF6ay9oUUxSdXdUcXlLQnJWV1VGSmVneE12Ny9mRlEzUFk0L3Ji?=
 =?utf-8?B?aEtrUWV2UkRzM0M5ams1Mk1FRUp1Njd6Q2o2bHZlOGY2OU5ZNVZnd2NoNjd2?=
 =?utf-8?B?MlBXeWVTSnhZc3AwY1AwSzJFOU9SSVlOS1BwampoVkhCU0RtV1JjRlZBclk3?=
 =?utf-8?B?ZGU5MCtNSkw4UDB5TXF2Z0lHRXdXU3NFeTd6eEZ2Z3FJODB1R1RJWHJhdHlw?=
 =?utf-8?B?WUx1S1Jmc3JidEJ1bFVPNHNxZGJhWjd6NnZaQnFJUitwVFZneFNVRHJyQ2ZZ?=
 =?utf-8?B?Nys2RWlkdlBnUXVHVC9LNnhsai9rdU5od0Q4Q25DVThkL3M0RFpwS3lCcEFl?=
 =?utf-8?B?eVNsWjd6aFV2U0dVeXVDZ28reXBrUzcvRlEwaG1LR00xWWhKeVRvUCtXYVM3?=
 =?utf-8?B?NEhFY0JYZGFkNnd2bTAwZncvZGlkNjJYaGR4V1pSUDFjRUxuLzZDQlZRVXZo?=
 =?utf-8?B?emlRMmphQ1F5aWZYUFdUYk9FbVk5YTdXVUJ4dEdnTkE5cmJxcXR2cmE5NG9p?=
 =?utf-8?B?Vmk3VEpUQWZ3ZWFvdUZwekZOYlpJYkZmMTNSUkxmdXJZdGRTNlk1Mmc1M0xm?=
 =?utf-8?B?RGNVdStNN21sWkVyanE1NzZreUd3QTBvL09kWHQ0ZzVhdDNkZk9Tc25yOGxo?=
 =?utf-8?B?WHJVWkhZRkNSdXZZUkUvbVVyamVUY1h3a0ZVcU93b2FOaUs2amZYV2EvOW5o?=
 =?utf-8?B?MFcvZWlwZDZERlRiYVFtVW5PT1FIMmhmSDBnOExpb1hJdzVLR3dFQ21uRTRQ?=
 =?utf-8?B?L0t4ZjQ5SkQxcGROcUFNeTJPeSs4cnlwbkpFTEE2KzEvQlN5VFk4dnI3KzI0?=
 =?utf-8?B?MWYrTTk1cnhYbGZxWjVWRTU0UzB0TEc2aEdHLzRPb2owQlY2UXR2RjJKME9a?=
 =?utf-8?B?SHBySnp1T3NxbU9TY1BKMkI1ZHlNL2pNdFl4M2ZVd2pIR1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aThCekVSVnU5SlhMb3N0aG1ZZmdFUGtDcDlQRVpmSlRWMGZHdjROZThvN2pj?=
 =?utf-8?B?MWpLMm1DYk1xSUlMQmsyUkhNdFZzL1RZRnNzWjdDQU9vNmhDcWkwd3N2ZnpN?=
 =?utf-8?B?aUFEeVJaUDRBWDRMR3YzczE0dFBveHY2L0dTLzU2SkhRYkVTTElUWm52cGFH?=
 =?utf-8?B?bVpReGpvdnVKbjdza1dIMWZ4bFhaZ0JHNWxGVVowemlsSTBrS25yVFlZaDJm?=
 =?utf-8?B?Q21KeG1VZysrRUpyTDc3UlVoelN2bU1PY0JVdVJDSDVBaENwbjk4Z3lSbGlZ?=
 =?utf-8?B?RSt5WWJLUExGVjcrRDNqRjQ3TzNxbTNqQjZqcTdiMEtmZC9XWFdLbFlNcTY2?=
 =?utf-8?B?K3FvaEFvQktOTUpCQ2gvaWc4eFdnYWovaVNUdUFGVW1QMUFJN2hJbnhIWG5o?=
 =?utf-8?B?bjVaUkNvclU1aFJOSklacWFnR1M1VWJyMC85OEp1WnZRSVZRY0pOR1VXazhM?=
 =?utf-8?B?L1UwcjI3c213L0RkZUdBcTFBSTZlVkpKazY0Zmc0SVZUZGtFbTFTMkNTbW5P?=
 =?utf-8?B?ODI1dHdKaEJMTmhPZEhJNUdoNXE5dTJvQ3BkZDRBc2FZNFBMejJNL0d5bWJL?=
 =?utf-8?B?UHZQU2RabVpjLzJGOVBKckVmM0U0V29YQTBCOWZGSWlrQ0NPbjRndGswNjRQ?=
 =?utf-8?B?VHYxZkJ6c2NBbURJengwVVhNcFRtdzh4NTVMdzFkcFJVaE5qVlFBNWdlUWd1?=
 =?utf-8?B?QjBtYkNJQXFQWUluYkRiUzk0Nk0waHR6d2ZBcURDSnR3VmI3MEdiTzg2SitM?=
 =?utf-8?B?R0g3dk0rV2pjYytOM2EwRDNoZ2R6aHNjR2FSNVJYdXZrNGlHajBnUmo1TC9P?=
 =?utf-8?B?NWw3Z1QwWFd2TGt6UmtGeTBEOE40bWRDZlpsU1FvSCt0UmVSeTRCMXFHdUZG?=
 =?utf-8?B?cys3RnBZUmhwSEF0OEVpbTJ6aFUzdEV2M1hpUEMyK0hzSjVjVjMzZU5Ddktr?=
 =?utf-8?B?b1hhdng2U0xPVE55WDJ5MEVIVTVyalFCM1ZnVGVyRk9GdS9Dby95R1NvNjE4?=
 =?utf-8?B?bGpSK3ptWGgvRkpMemZKSDc4NWpaVzV4b1NUNzhNMHVRVFVjRCs2a2NSQ0Ja?=
 =?utf-8?B?TTVNbU1IQzN6cnE2Yk4vOWNaOUUrNGRmcjdoYnV4TzFyVEVOTE9iM3daN0pj?=
 =?utf-8?B?OGsvS2MrNjRSUERmZnRMOE9XN0xvOVFseDZTSXd2L09hRU55QUdNKzNYUkxL?=
 =?utf-8?B?MGs3bUUvelI0RnBubi9sZHhPOGZlNk1HT25DWTFVc2RUR0hRc3VOcXF6OFIv?=
 =?utf-8?B?clZJUHpwdjc3L0dsZTluOGR1dGdLdXpPSlNvb3FJL09JYW5VaEdSdGsxNmNp?=
 =?utf-8?B?clpqd2N5bXlIMTB5M2grZlU0bjAwVWtzZjdoM1BUUTBYNi9LRWV6aVcyMXJT?=
 =?utf-8?B?S1FUNUppeFBvTEF3OTMxUjBUa0ZvNWN6SDQrZSt2UGFCQmRIanpLUDU5dzI4?=
 =?utf-8?B?T0FsbnI5WFZFWXZLV3FmZm9LenlUbjBDMENIOGNiTWJyYng3cXMxRnNOdVFo?=
 =?utf-8?B?dElPais3UzNEVTBXUjVVWFMvY3dkdmhwM0R1UkUxZGJ4dFY2cm1OY203ekdN?=
 =?utf-8?B?QTFNV2tqNVhoWUdWeW0rbUtBSENXNFFhN2RWK2lORnBXeXllUWFwWDl0OTk1?=
 =?utf-8?B?V0wzYlF6UEZiYWQ0TTRKSU4xbzZWdmFWK1ZNZTRobWhTa21QazVjbmRFS2F0?=
 =?utf-8?B?Y3BHeDVxRTRSaDY0MkFlWkZSZGg4SXdpK0I2eGkxWmZRNzM5RkhmTGlPWmFT?=
 =?utf-8?B?N1FTUnJEM0IveDllK3kzZE1GcVhEOTF3Mk5TWXBVQXpKb0ZjUk5Ubi85R211?=
 =?utf-8?B?SDZzUVMzekFFTzlUUXdpaEZnUG9TbFhYUC9uSVliajd4MGZDRVk5amUwQnlO?=
 =?utf-8?B?Y0VMR0ZzdXVUaUdNVitjWi9aK2huNExMWlhheW1paEtheU9qNmlvNXlKREJJ?=
 =?utf-8?B?Mkp4eTBYY3VaMUJvclQ5RTRaeGkrWGtqdHY3TnF3Qk9NN2RTQlovY3RTaDFx?=
 =?utf-8?B?WDZJdW1jL1hKK3F4bFd6QitSQWMrc1pJMHBrL3U4cE1OK1lFUk5id0ppVVZR?=
 =?utf-8?B?cUtkU2pXRy8yQzBGUHppTG81RVZzdUJOdXRISFNEczkxa1FDRmszaHFBZldp?=
 =?utf-8?Q?eYdn/W1eynrQWY1djGgYyJ01G?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1737d17c-2d76-4376-7eb5-08dcce3a0372
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 06:06:14.0867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZhbvMyhke0ZF9DmicnGzVMKNozGxq0IPJqQODgwryVvUaMZUD+Qgr/E7cRbx/P5qEpILqoCWzmABerrQUcGE4wU21r/yWl2rrkQmKPv5f0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6109

SGVsbG8sDQoNCj4gDQo+IFdlIG1pZ2h0IG5vdCBoYXZlIGEgcGh5IHNvIHdlIG5lZWQgdG8gY2hl
Y2sgZm9yIE5VTEwgYmVmb3JlIGNhbGxpbmcNCj4gcGh5X3N0b3AobmV0ZGV2LT5waHlkZXYpIG9y
IGl0IGNvdWxkIGxlYWQgdG8gYW4gT29wcy4NCj4gDQo+IEZpeGVzOiBlMjRhNmM4NzQ2MDEgKCJu
ZXQ6IGZ0Z21hYzEwMDogR2V0IGxpbmsgc3BlZWQgYW5kIGR1cGxleCBmb3IgTkMtU0kiKQ0KPiBT
aWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQGxpbmFyby5vcmc+DQo+
IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvZmFyYWRheS9mdGdtYWMxMDAuYyB8IDMgKyst
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZmFyYWRheS9mdGdtYWMxMDAuYw0K
PiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZhcmFkYXkvZnRnbWFjMTAwLmMNCj4gaW5kZXggZjNj
YzE0Y2M3NTdkLi4wZTg3M2U2ZjYwZDYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2ZhcmFkYXkvZnRnbWFjMTAwLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZmFy
YWRheS9mdGdtYWMxMDAuYw0KPiBAQCAtMTU2NSw3ICsxNTY1LDggQEAgc3RhdGljIGludCBmdGdt
YWMxMDBfb3BlbihzdHJ1Y3QgbmV0X2RldmljZQ0KPiAqbmV0ZGV2KQ0KPiAgCXJldHVybiAwOw0K
PiANCj4gIGVycl9uY3NpOg0KPiAtCXBoeV9zdG9wKG5ldGRldi0+cGh5ZGV2KTsNCj4gKwlpZiAo
bmV0ZGV2LT5waHlkZXYpDQo+ICsJCXBoeV9zdG9wKG5ldGRldi0+cGh5ZGV2KTsNCldoZW4gdXNp
bmcgIiB1c2UtbmNzaSIgcHJvcGVydHksIHRoZSBkcml2ZXIgd2lsbCByZWdpc3RlciBhIGZpeGVk
LWxpbmsgcGh5IGRldmljZSBhbmQgDQpiaW5kIHRvIG5ldGRldiBhdCBwcm9iZSBzdGFnZS4NCg0K
aWYgKG5wICYmIG9mX2dldF9wcm9wZXJ0eShucCwgInVzZS1uY3NpIiwgTlVMTCkpIHsNCg0KCQku
Li4uLi4NCg0KCQlwaHlkZXYgPSBmaXhlZF9waHlfcmVnaXN0ZXIoUEhZX1BPTEwsICZuY3NpX3Bo
eV9zdGF0dXMsIE5VTEwpOw0KCQllcnIgPSBwaHlfY29ubmVjdF9kaXJlY3QobmV0ZGV2LCBwaHlk
ZXYsIGZ0Z21hYzEwMF9hZGp1c3RfbGluaywNCgkJCQkJIFBIWV9JTlRFUkZBQ0VfTU9ERV9NSUkp
Ow0KCQlpZiAoZXJyKSB7DQoJCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJDb25uZWN0aW5nIFBIWSBm
YWlsZWRcbiIpOw0KCQkJZ290byBlcnJfcGh5X2Nvbm5lY3Q7DQoJCX0NCn0gZWxzZSBpZiAobnAg
JiYgb2ZfcGh5X2lzX2ZpeGVkX2xpbmsobnApKSB7DQoNClRoZXJlZm9yZSwgaXQgZG9lcyBub3Qg
bmVlZCB0byBjaGVjayBpZiB0aGUgcG9pbnQgaXMgTlVMTCBpbiB0aGlzIGVycm9yIGhhbmRsaW5n
Lg0KVGhhbmtzLg0KDQo+ICAJbmFwaV9kaXNhYmxlKCZwcml2LT5uYXBpKTsNCj4gIAluZXRpZl9z
dG9wX3F1ZXVlKG5ldGRldik7DQo+ICBlcnJfYWxsb2M6DQo+IC0tDQo+IDIuNDUuMg0KDQo=

