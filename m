Return-Path: <netdev+bounces-65529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EB283AEEA
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 17:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF681F21F2C
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 16:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA1E7E764;
	Wed, 24 Jan 2024 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="M/ZCTD4Q"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2187.outbound.protection.outlook.com [40.92.62.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9947E57D
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.187
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115432; cv=fail; b=BghHJfdfAlL08BFSueLJC0pbax1N0kTUniDmGxK4olc9IlJhhkM2rs+PV+VG4vpShlSdl22H7DsljQgI7EOCkZkRaCrdAudpfOHruh/3ax3WYvdHzyq389reqO0HW/cQXvJA6CF8xK0nmOnABW2oPltoAR8BBlBzG/tXvp8gQgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115432; c=relaxed/simple;
	bh=HOFhXOFC68gFUBQ2hOCGSYOfYU1E1+j8a0ilH4+90d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=leI1JVtnAASKtEfUNEKLN1KBCm/NzKXYgP3sU/R54nuzZjGdlJv57TkuXFiA+8ovtLLXDmfEE6jbgQzOAqTVvOnPmydklXkV8vAUL2Af+ImT7sk8YJsYqMn8fVbyr0PpwTCF85LjOCaUk7WYsQrwmaC4bUKjJ03MMvNXdMMeMe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=M/ZCTD4Q; arc=fail smtp.client-ip=40.92.62.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuaF16BYK3XKu4JJ8sQhxOZPvo5ws7NCmaLpAuiXRyqwvZGvaV17g2khOwyf74oZhMlVuoUwFl5nPahAwJNzd7UyJ4NRuWJ82tffFnUnqICw53Pko8sHN9FDwhzZAzajlC86xwaQhPBHSiQzVmhfGBa9XJRYEbMbXQyWovd7bx03oalVX9sxi5/I74rQBDZ3+R24OhPlURZbeflTHkBKc1zloEyK+2gwGo+eY5xdcU1Jz9ufbA9Z5iiPNQ9hHPlT9M6Nd6owItubhewlMqoWRYAoMHU3dsVMfvO4fF3n5VhwkPiKXwqhLXz6fu4EspshKBynyKWEz3At32PWs9VGzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GCebTouepzqAHKdUzEa5tGN6KbySjsxxd9WM/aS3Dw=;
 b=cthPlxjzOBiXsNW1dhyiO39rGBwYcgw6J3Pu7spZ+DKmz6uH3B1KbOKGrKNjkYgr+n4Rb/Xcb88UMzu96GQdNxvnIDRXF134wJuq5kD4iVloOIX9cNbZ4NTHgJydI8AI9RQlCgy+iFFZb4m0pMHEC5GaAzjCLxqK3tJpl1HIP+TV0VQ98cl4stDsNzUORfidQsMtnQXyTrrE3omO7Jc87oslWf+Tiabbu3fsKkmIQtxrepwa4KDTgPGqwR4XGTP4xG07w/XCEUbnXSJ3KFaokuGZiDlYG5Yk+FSL6aE9qTJljOQBlEei3d4mU4T3iSufv/qZ8QjU3yzV6X2/sfjwlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GCebTouepzqAHKdUzEa5tGN6KbySjsxxd9WM/aS3Dw=;
 b=M/ZCTD4Qz5ryqJt3ecKGFJPitPNQhh453YZ7de9pXpD+y4NNZYYlEnHU236lQXq4zi9ioTRoDEYvo+oqtp7rQ537Qw3+/NcQ/oQy9vDPo3cNxXhoPOuKes4LRM2ujyMovgO2jdz73jBVCbpVn1YLlYROK0KFZuwU4qVpk6695uE78zopIZ1CO5J9U7GE9IARh6+3nb1OpvMjld39QKsnL3vdwiVlfsh8MX8BhfarMLLx7Uc4TzadUQm2IDHAYLknaSmleFFWvUaSSWsLNT0waUag7pANaU2WBZLLEM9dT6ObtH6sACSAFgaYPx17Fdl/EdBTYQxJ3QT5ksE5zNoztw==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY5P282MB4936.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Wed, 24 Jan
 2024 16:57:03 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%3]) with mapi id 15.20.7202.031; Wed, 24 Jan 2024
 16:57:03 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: pabeni@redhat.com,
	Jinjian Song <songjinjian@hotmail.com>,
	netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	danielwinkler@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	felix.yan@fibocom.com,
	haijun.liu@mediatek.com,
	jinjian.song@fibocom.com,
	joey.zhao@fibocom.com,
	johannes@sipsolutions.net,
	kuba@kernel.org,
	linux-kernel@vger.kernel.com,
	liuqf@fibocom.com,
	loic.poulain@linaro.org,
	m.chetan.kumar@linux.intel.com,
	nmarupaka@google.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com,
	vsankar@lenovo.com
Subject: Re: [net-next v5 2/4] net: wwan: t7xx: Add sysfs attribute for device state machine
Date: Thu, 25 Jan 2024 00:56:38 +0800
Message-ID:
 <MEYP282MB26973EE72246EB515506EAD6BB7B2@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <MEYP282MB2697D7CFB233DDAE83F74988BB752@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
References: <20240122090940.10108-1-songjinjian@hotmail.com> <MEYP282MB2697D7CFB233DDAE83F74988BB752@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
Content-Transfer-Encoding: 8bit
X-TMN: [baBHOJTjzV+19p0tj8rdJR6Evyl2TET0]
X-ClientProxiedBy: TYCP286CA0203.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::16) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240124165638.19292-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY5P282MB4936:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb0e875-3deb-456d-50bb-08dc1cfd7d22
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d5m7nYKWQTRyKfi7MdAsdfXyNJpUbik7XVd9aISojHrUvrssTTMlKV4xJ/XUfo0xzErLmylAB6ANz5Y7mm7on/ToErT2CgMvixAl00zs3aMmZgc1aPO0vHiR4IudVQ9d55WpF/Kix771JJmkFSY7V8n4ZXxJE7PNXQ2Su6lF5SH8hk9poBKh4IMjd0bzx0kRXVOG+D7Smm38lXBh6uwk1KOE3Q/tpHYNjcgy6/p6izS6xWvnx/STBAYAqiXsdanJOo7YXcLzlQBZyzo5H1DAfMuya26ZIxM9mbtRhTt4JCWZ1kG8mE2XgF93/NKYa5c7e//pR2S/KpZDKATKKTxCLR70+n81xwTWZCSIhmtrR+YgN3QT+k2c0jNY5AtH1E7mK3imBUp0UByz7b/rhAxkjFosuS1bVELt7+MFITM8SuognYgrvCt10OwtqRdNNFuaU4V0rlQvnb5AGUfdgMreOBv/Xt+M88286ddrvChb2PRHuF9qPsbAVyjaJaZVAyRvWTK4KyI2kaY45LaUYPRhNi8RA43r7A8iRV1DUox77SwRvEcFCpuOdXiFvyiG2vUfBoA/auPAG3ydCaIXTWGdRHz7Bh/WBywLhjAL62482iE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHlvZGczL0RCbTR0MmkyYjlDL1BGNXhidDYwL2ZkTzdSdXB2MlgzWG9FUTYx?=
 =?utf-8?B?VjVDN09TK3NkZ2xHQ0NGVndBVktmR0xxV2l4ajFHczFickhqUmZ6RFhxY1dL?=
 =?utf-8?B?YXdHZzNkb1NUU2h0U1A0KzczR0RESzRISk1YN05NUkdkYitySjh3Uy9zMmF5?=
 =?utf-8?B?Q0ZJQ1EvNXJ4a1NsUU1Sb3VPd01JdzRiVmpyQlpYWGoxeCt1MUNmQzRmWHlr?=
 =?utf-8?B?b1dSTWFtbmpnbGtERUI4U0txQW1ZelVNRnZyVlpuODVyMzVMY3NpaHJsUWtC?=
 =?utf-8?B?MjVBbklrK0pyRGcyUHpZeDF3WWEwa2dvYnRkQTdhY3l2dXd4WWhid2ZhZHNK?=
 =?utf-8?B?V2FERWlTeGIrUkFBbi9nQlFVWWxtYk1pbGhKTzd4U25JdHJlWTBWUEhjVTBo?=
 =?utf-8?B?UHhIZW9XVGJzSjJ2QkJwV2hqTFI1aU9NeTk4NDNpV24xOHZxNHU5K1J1MlZK?=
 =?utf-8?B?N1BMM3dEZ0tEbFJUd29PaEF3a2dNNmw0djc2a2ViR2pJTk5FcVFWYlNDdkNR?=
 =?utf-8?B?U1ZWc2ZsL0o0YWhBUGo5cnVyU2NNdGZvdXJycmR2eXVHTk9zSXR2WGw0K1NM?=
 =?utf-8?B?bnpuNkU0Uk9sNURpNDUrYkVVbWlLSityblRqdHBJUVRvK2cxWDZwZzgyS0Ev?=
 =?utf-8?B?eGxjOXdqMnhHOXFBV2czcllyRzkrZnlqOVpscXA2S1l0dTZBTCswWWt4Vk91?=
 =?utf-8?B?UWpobVFiNkQwSDMzVmJhSG9LNkdLaFZqRVoyaEdlMnRVUFNUUitBdFBwNUtY?=
 =?utf-8?B?N2FYUDNMaFg1UlFJd3lnNDJMdVJidkd6c28yMTNid0FuM3gxbjcxYlI0RnFJ?=
 =?utf-8?B?K3dJWUJUM1M5djU3UWJvWG5QRlk1Y21IZTAyd0p4cy9kTE5tUS9OUk0zcUZL?=
 =?utf-8?B?UnRDanY0RnV0emNUQ296Y1Y5b3FRVjRVc0FIbWtKV1BPSmhCZmw2bktvVmZU?=
 =?utf-8?B?M2Y2MDFFNWxwUkxKajY0aVExNmtYWmJRaTZvclpmNnpNU2dGTTYwc0hMdU5V?=
 =?utf-8?B?VVNqMEpYS1NIeHRTSllpTjB2SzJ2YmxBRlR0U3JiK280RTRyTHRqS0gweG1D?=
 =?utf-8?B?K0JvTXNDTXRJS1I2emd4QnVMWWk0NGNYaGxHM3NNS3hOWmdrcFNXTXNyb05m?=
 =?utf-8?B?dU8zQm16bGFMcGFqSXhZT3BKdUZwMjRCQi9xQUNZR2pvek5rZEZwTks0SDZL?=
 =?utf-8?B?ekFFYzJZVGVlNDc5SWhhQTRmcmNXUmttVjMrVFZ2M29RQmZWZHBzZ3FNOXNO?=
 =?utf-8?B?UHM2anRkMU5kekhLWVg1MlgwY2JXZUh4YlhQYVFUYjJtSHFDRUkxWEd3NmZr?=
 =?utf-8?B?NWJTUjRVZllnZ0VHRTdiMFJ4WUVZSXhqSTdHbk5KY1FTdmJvUXJLZ3NIK0h1?=
 =?utf-8?B?TG02MDZ0MlF0TkU3bFduUFM3NTlGcTV4cXFTREUrQWtIUEZSWDZzWDhWM2d5?=
 =?utf-8?B?ZWNCR0tCREpJbGFjK3F1TUdyTXFhNVBYYldPVjg2TmVLZks0bEtWYy9Mbi9V?=
 =?utf-8?B?cGM0QWJZY0hJSFY5V0loMHMyY2dKMGhJNUZ6Q1lOZ3pGbWRLaDRkbFBWY2ho?=
 =?utf-8?B?YTYzdThpTDlPRkxRTktvM0pybXB3SkRBb1VmNW9BZ0NtaU9PK1kwbmUwQzRi?=
 =?utf-8?Q?aOslJO/98WmYkwFdOwcDHGSwU+GkbFltZW+UhlRBxE5Y=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb0e875-3deb-456d-50bb-08dc1cfd7d22
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 16:57:03.5604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY5P282MB4936

From: Paolo Abeni <pabeni@redhat.com>

>On Mon, 2024-01-22 at 17:09 +0800, Jinjian Song wrote:
>[...]
>> +static ssize_t t7xx_mode_store(struct device *dev,
>> +			       struct device_attribute *attr,
>> +			       const char *buf, size_t count)
>> +{
>> +	int index = 0;
>> +	struct pci_dev *pdev;
>> +	struct t7xx_pci_dev *t7xx_dev;
>
>Minor nit: please respect the reverse x-mas tree, here and in more
>places below.

Please let me change the as that.

Best Regards,
Jinjian

