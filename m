Return-Path: <netdev+bounces-153330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE979F7AEE
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432071658A6
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 12:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FD82236FD;
	Thu, 19 Dec 2024 12:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oZpnoqer"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362EB22145D;
	Thu, 19 Dec 2024 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734609972; cv=fail; b=DzbKzK7WiP5QWik5c34XB56jgwcJ+cnq2MdVYvPcDhkeCP1QksusuDnH5o7gTGdr76eCLSPnnP3coHp/ikis2CHi0cUBJIrdTAc/8aGFOLO/MasEC5zqhsJ71l3K2iup+1nf28N9mOfAe9syAZakRXPmJ4o8D8dVX0iTx1M+q9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734609972; c=relaxed/simple;
	bh=rdDzf9EK5abnq9YggibxuNJtm4ZguN+05WlGAwVF2lU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aFX+AXXbWArhbIqwZk/yQn5q/HSSzrIE+lodIuvS5mM8f9B9EDP7tsgfgSgexBSnBgnbw1kbHXmZI+09tu8+1UxbEnBHL8aR9/TRIdhCdJ9NDg9JeXvUhcRKupc9tfuLSCaDm9Eb3l6zH/hVpCBLtr1hdgr2F2VS5eR4SPpv1y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=oZpnoqer; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQZrTuNr5jNm5EYKQzrMqso8KAh2HxIkOGemWvPxyeeuB2biuK0V9DVMpUaWDt/ZP7g4gDifzhFxsSv7c32YAhOWp3cc+k4TSnX2UmZUSCUrv9El138E9c1pYndLx0eBCXl0bD+10DRUON6Vn1urfxIEFCvYgT/rpodf96Sp8p2CItQhkkvhtBFIBTUmN9B7b5riTScCJt8L9YUEzt0dB/N5rUsF6De0mCRyuQMz+2ZulaxDQZGP2Iwf+uqdTaZcSDEjFI1ZqJghJEFPN7o/CGUaWmKXvaUSUwt9RMMbu318L/UMYXTnMcx1d9XsFr+JB2T8HehP7UiFH/uGkC4jQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdDzf9EK5abnq9YggibxuNJtm4ZguN+05WlGAwVF2lU=;
 b=fKdGoR/ibwMk7bYfPPcCX5EOkFnYQnbyiCmD528O2M269dePi0rtZp1gVCEbHa7K5DMkoPh4HE4wc3yFBkBPeDd0Hg4LEivufxohvmvpJFuYURx+vdjdeia+5VdlYlgKU7dVVgOa3jE+uItcN1yT1NoU2fSEzpK+KIp3yh6xkjTyApMaxG8meZU1YE80GncKVh6Ri+PRIk6gM9nKng7BZMdAYkJAKFcOgd7aRnnWy/IWuDu/14HwOk/fXJ6ZaDMxduX0zfRuxrn/QM1cuftNVSg3hm67GAhRIA4dwOBTga8ATFNI2sQLPWmT1RdnP7Y6Ao3sQzOAFo+L5duV8yojsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdDzf9EK5abnq9YggibxuNJtm4ZguN+05WlGAwVF2lU=;
 b=oZpnoqerAcYky2lzQ2FW1qKHoF8JRvsMtrd6bsZi3HsEWtXn/pVJwFQoCFpwJdt6hUQHx5wDX77zgeBuJEuTR1j09chEt3dacDX+U1sl4j93gjrNZ11GvyHBImom5bJAAgSFqN2fZX7FjgBlfZPHi2E6Lh3hYAJTXcV6DQe5HkzfQXrGM0h1rGE+cDgTAxX6l84yMnsWn0bk57Mt1BmDHa443zABb0iYzAim7QtIKR2RlPtI1OxhUDOSRrf4lr79M68Gzlx7u4aCWtnn9Je+eVtnDwbwkYU72VLAawxiSRSqO+fIZkaDMUTjdFg/b1fi7BuCXpii6Ll1Hu0xpcdp9w==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by CO1PR11MB4867.namprd11.prod.outlook.com (2603:10b6:303:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 12:06:05 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%3]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 12:06:05 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <dheeraj.linuxdev@gmail.com>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: ethernet: oa_tc6: fix race condition on
 ongoing_tx_skb
Thread-Topic: [PATCH net-next] net: ethernet: oa_tc6: fix race condition on
 ongoing_tx_skb
Thread-Index: AQHbUeOYiYE5uGvI90eH3S9qxJnecLLtePkA
Date: Thu, 19 Dec 2024 12:06:05 +0000
Message-ID: <925aa1c5-f4a2-4042-92da-7cee6cb8b3d0@microchip.com>
References: <20241219065926.1051732-1-dheeraj.linuxdev@gmail.com>
In-Reply-To: <20241219065926.1051732-1-dheeraj.linuxdev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|CO1PR11MB4867:EE_
x-ms-office365-filtering-correlation-id: d5515349-15fc-4293-e972-08dd202583cb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S3MzYVRiUFdMT1BOZGRXWnB4Mk9iYnB4aE5Lc1R6d1pHWEhuL2NtZmxWalpq?=
 =?utf-8?B?VzB5OThDQUJGMkNGS2FXS0hsclJOK0h4dWRvcnJoZlFSUUprYkV3akNCL3VB?=
 =?utf-8?B?RjJPK09TcjhiVU5hbGdaTytSVGl5R2Q0b0d5b2hoaW9zdS9Hc1JoMHFWcGgv?=
 =?utf-8?B?TnZucUR6cWQ3am9BZ3VJOElsUFpwbmg0U0tVVTJtclZjTTJaODlmSjRCY2Zr?=
 =?utf-8?B?bFJFMUR6SERhaHJmcTE4aVkvdHdzYWY4a0htcXE0ZVhuWHJCRmpJbXlDUDM0?=
 =?utf-8?B?RGJXYkJNV0ZsaVkxTVFYYTZVRHhXL04xT3QxU01VVXJHWWlYMVpnbUVYWWJR?=
 =?utf-8?B?VHdncC9hQVRMWlI4SVUrc1lmOUNjV0Q3VTU5QW1aQWlxVTF1TWxwTnc4YU03?=
 =?utf-8?B?Ty9ISEFGRWYzL2RTVlRQSEJYLzNXa1BraVVBeGhveHRnbEtlV0VEZUttUmlQ?=
 =?utf-8?B?L3VvdlVCZ2pBUFVVdFNmaEp4WVhWeUVIY3YybGtsTFl0dXVDbzJHRkM1Q3RQ?=
 =?utf-8?B?NHlMaC9hWUY0K3E4NTljYWYxYXJrYkdGNGw1TERBMldlcGVnYjhUNzI3dnlj?=
 =?utf-8?B?akEwd3BtWVU0UFpWYTZjczZqRVJuNGxqM2J0MHV5b0R2NnRiRjE0OUN3akZ4?=
 =?utf-8?B?Zm5CTGtSZFJsWEdrTmYzR25XeXFabHFJUERxUEVHYWQyQ3dsQjU4QlA4N1Mz?=
 =?utf-8?B?ZXRCZ1d0dlN0dmg2TCtveDdhSlhTV29IMmpvMnEzUXhYcE9rc2hZQlNGZnNm?=
 =?utf-8?B?bVNhOEFvNHZVMXk5eUdaZytPMk5SL0JScEhGSGEwK1F5MVdkaDJTbWMwSU9G?=
 =?utf-8?B?eVV6eTVXNXk0NGdFZEVwbVE1cU1GTjNMeURoS3VsQ1JsTGFQeFVmbmVBL05m?=
 =?utf-8?B?NElYb01KbUUvRzJGcXhKZW8vZGtOMnVjVkxqNUxRZ0VTQ2JSaGlERlJIR2Ja?=
 =?utf-8?B?VHIvcnRYU0lpWUdGdVdsTGozNzBxOG14dVhUVTQveXlOcjM5QmxiSW8rLzMr?=
 =?utf-8?B?VGNtYVFIRUNWMVFaUEVYSThZZ0xYc0JJcDhxM1lIbENyTndZYzYrNE1KK2xD?=
 =?utf-8?B?UEkwMFphcndCd1ZUSm5McHdDTnFiMExWbzgrN2EyR0NDVm5PczhVZkIrdHlp?=
 =?utf-8?B?RXJDTWpsaHhQRTluNFg5VzdKRW9ScWlwVVkrUlgwUXJBUng5UjFBekQyYWJC?=
 =?utf-8?B?WWF0V1VWZDZjaVVGeDRvT2hoVmMyQU0xUHVxYVlIbTFGL3dsVS93V1d5a0sy?=
 =?utf-8?B?THhNdVd6bm1jbzgxRmcyUmx0bEdHWUpyaG5yT3N5N2NTK0dOT3h0bjBuampO?=
 =?utf-8?B?RXE2L0ZSWjZMN1F3ZTU5WGpTdTdhSUc5UkxCWWRXby83TFltUld5QmV5UGJI?=
 =?utf-8?B?bkJGM2xMVEpCaTlwQW5LZHR4cFpKZ05sSitRdTJkTFBBUXh0VTNNb2RZYmQ0?=
 =?utf-8?B?allOMW50c0NRTEZROC9QQ0RpZm55RkppL3IyTC9QbmpHUWxucThBclpVdjVU?=
 =?utf-8?B?U21MSnlpSS9VSGZncDQ4dFhvL0lJOGh0eVh2eUtZaHJBMXBXUVpENytXNVlL?=
 =?utf-8?B?ZmhKNFdhZGZidjZzcEhqOFJzYUd6all2SUtpclVJTDJwcnI0MHhrMGtEcHc0?=
 =?utf-8?B?c0lreFFsWDc4TmhXb1FGYXg4MmQxaTErYXpZaTl1aUcyc3Q5TVZJSXBOUWQ4?=
 =?utf-8?B?bXMxa2E2TytRTVVUcy9rTkp1QjljVHhDaERyWEl5YXNyNHdpTHIxVWs3Nkhs?=
 =?utf-8?B?NjI1Mk50LzQ4VlFpeU56TGo3UHNrelJ2NFVBNndSZnlhS01Zc2VidHRkSThZ?=
 =?utf-8?B?OEx6ZTQvdWF0OVgzL0k0aitKT1FmMzhzVnZHYkhwblgwT1E1TXlOdW5kVjc2?=
 =?utf-8?Q?FwvI/hek+VtFe?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L0RjWnR4Sy9TcWticTRSelUzclFTR0oxL1F5Y2xFZmdJR1VpVmhWNnowUkty?=
 =?utf-8?B?ejVmTjBlVVo2ZGxQSjRYb3Y5Z3lnZm1BY1lpKytlT25sRmZ2dmJhZ0NFeS8r?=
 =?utf-8?B?U1FaenRnOXd5em5NQllsUGp2UUM5a2NsbjVyYVlPeENGRWpZYnhacUhnaG9i?=
 =?utf-8?B?U1oxaDQ1ME1FZ0pUdFREd1hIbi9hOU1HL2l4cVpqRW1rWngrVFdKa2JwZzY3?=
 =?utf-8?B?QmVpa0M3d2JDRWlNekVLbzJsZGtKNm51dmhDczVSS0d1Mi9oaHJoWVUvK1gw?=
 =?utf-8?B?dk1ObmVBQW0wakR6VUZGVFdBRnBoQUtWMDlMVHUrUFlHYkw0WDlSejlHRmtD?=
 =?utf-8?B?cWgvc2lhSW9CR2tEdHRwVXp5WDFXeC80bDlnU25CdXlTbzY4K3RNcVhlMGFh?=
 =?utf-8?B?RW01T1JQTCt5U1NZVG1EbFd4TlBNRnFaci9iTldnNTA4SExvdHhMOHA5YVZG?=
 =?utf-8?B?Q2t4TFBtUExrY2xtdWs0ZFhQOHpvWnRzb21uelpEbytSMWgvZEljZjRBVjdW?=
 =?utf-8?B?YjNCZDRnWVBqb3lSWjM0UnJkRm9xK3ZPRVQ5UzIzNUtJNE45WGhacFJBQ0lQ?=
 =?utf-8?B?SGozTTRvY1dBSCtUR3ozTjR4WFdTUVdXNVFGWFA5VGM2RXZnc0FNaXFhUCts?=
 =?utf-8?B?MzhreE9ZQ3Q4VmhITlJScDgvdWJBS0JpZ2ZSNFhxOXFBVGs2TFI2NEZISTJR?=
 =?utf-8?B?RnlXTDZHbDVPUUJHem5zZ0Q5ZEdBM0RIZVl5UThubWRkUGhVcHNpakx2d0VW?=
 =?utf-8?B?bVkrZys3ampMblkyMTVsYy9DRTZONXlLWHRkZmtBQmliOXBLYzFoaWtNUWNE?=
 =?utf-8?B?V2FGRjlWNS9naXgyaUwySklGaFhocjZRZ1hudTJwelYvUG4yQnphSGl2UUhK?=
 =?utf-8?B?MjR3WFdZYUJBc3hrbFIvSGRhTzBLZGk2NGpWczhVblBxamRGYlNjamkxdzJH?=
 =?utf-8?B?KzhrdWJXbDAwZVFwY1ByV0RkaVZCMFJPZktIQzlrT1B6S0l6MGFQSk9LSVRK?=
 =?utf-8?B?Yk9yT3dpYU1WWnNGNGlueFVUZ2Fxc1VReGxSRFBHS0JyZ2N0L0pWVDVGcWY4?=
 =?utf-8?B?UitaN25iL3FaWGhQazZsbzNvazZpRXF2ZnhVbTdKTDU3Uk12eUQvT0NyVFN2?=
 =?utf-8?B?Y0JVSWhZVDVkVm5vNUlqbVNyUVNMSUlXWHF1VWFqbGFxZUlyN0YwdWNiRzRq?=
 =?utf-8?B?VWxVbS9zYnQ0WC9EVGgxSkE1YWRack10eko1OGNtcmFaTzBkZnB2RzY2YUd5?=
 =?utf-8?B?VWFPem5ucXdPbnJyaXAwd2VtdXZEbEY3blBnQXJuaGZVL3lwdGlQN2JwOHl1?=
 =?utf-8?B?VGl6Y3JxN0tuT293YU90bWNTRGxwZ0hlaCs3VmhuSnUzR3BSbjVCZlpCelcw?=
 =?utf-8?B?V3dRZU9WTGNwT3RkTGc5SWE2VWE2WFZsZ1h2eWgxendGazN3V2xvajVZOG5C?=
 =?utf-8?B?S1d0ODRpTjl2NS84V28zQ1JOemo2T3dXaUlOaUNUMFVHRitkS2dDMjNOYzBY?=
 =?utf-8?B?K2JyZjNDTks5aE1reWJ3eGRKcHdnN2cxa2VkVTY3ZFJ6ZEQ3NWdXZjhSODRw?=
 =?utf-8?B?d1FhTDdrdlk3aW9aZU9ESnozVCsya3Y5RkpzY2VmMDZqWE0yUG5PV2lOZGRZ?=
 =?utf-8?B?OHptYklKU1JBS2ViZ2xUVzFTRGhDTjY4RmVQMU5NdDVsNHQxVmkyU1htdG0x?=
 =?utf-8?B?NU1TOHJpdTNHVm5IbTA2TnlxSUdxR20rUDhRSmZ6SDVleUNmQjJKb2hVWHpB?=
 =?utf-8?B?aVYvbXVUSjg5SWV5aTYzQUI3VlVEdVV2bk5sQmtmdDJYbWJSSnJ0Vmk4K01o?=
 =?utf-8?B?dVhHUjI0QVAyTlpmSVVkdk1BeE41NkZKWExIaFpRa05ibCtQbnp5cjBLc2Rs?=
 =?utf-8?B?SW8yaXZZbVgvNjZSUFRhV2hPVUl1dWU3MGJkWkdKclVGN3lTOWZ3UTdGb25X?=
 =?utf-8?B?alI2RGpicFY0V1l2cWZNY0plMGFncUY0aE84aUltUGRhWHg5Mlp6RGdEN0Yr?=
 =?utf-8?B?NVl2bTJkWFVFc0FKWmY5c2pRSzlBNzMwN1VGK3FkRW8wNXNBTm5SN2dCTDN5?=
 =?utf-8?B?SktFbVlHcVdxMnUzTzAyMmttS1VBTkRUeWkvYnkxMXBVOGVkSDNsWjVxTFQy?=
 =?utf-8?B?bVBsUHpOS3dlaDZuTmxaMkQwc1dNYzk3b0gvQVpIOFVmZVFSSWhxcTVmWmkw?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86A19B065681464B81799EA445635D37@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5515349-15fc-4293-e972-08dd202583cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 12:06:05.3368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VD6/OBCqVFAFMfV26flBBJ5ziDN0hO1fkzX6bozDKwlrlk9ilcmR36q2KsSFrcIev2ZJdZjMcnTpWGFHzdCf4Rh3xoIvhJUt7nk6EqxuFP1Vscxj+9FggNVNzIZLT9LS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4867

SGksDQoNCk9uIDE5LzEyLzI0IDEyOjI5IHBtLCBEaGVlcmFqIFJlZGR5IEpvbm5hbGFnYWRkYSB3
cm90ZToNCj4gW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBkaGVlcmFqLmxpbnV4ZGV2
QGdtYWlsLmNvbS4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1z
L0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEEgcmFjZSBjb25kaXRpb24gZXhpc3RzIGluIGZ1bmN0
aW9uIG9hX3RjNl9wcmVwYXJlX3NwaV90eF9idWZfZm9yX3R4X3NrYnMNCj4gZHVlIHRvIGFuIHVu
c3luY2hyb25pemVkIGFjY2VzcyB0byBzaGFyZWQgdmFyaWFibGUgdGM2LT5vbmdvaW5nX3R4X3Nr
Yi4NCj4gDQo+IFRoZSBpc3N1ZSBhcmlzZXMgYmVjYXVzZSB0aGUgY29uZGl0aW9uICghdGM2LT5v
bmdvaW5nX3R4X3NrYikgaXMgY2hlY2tlZA0KPiBvdXRzaWRlIHRoZSBjcml0aWNhbCBzZWN0aW9u
LiBUd28gb3IgbW9yZSB0aHJlYWRzIGNhbiBzaW11bHRhbmVvdXNseQ0KPiBldmFsdWF0ZSB0aGlz
IGNvbmRpdGlvbiBhcyB0cnVlIGJlZm9yZSBhY3F1aXJpbmcgdGhlIGxvY2suIFRoaXMgcmVzdWx0
cw0KPiBpbiBib3RoIHRocmVhZHMgZW50ZXJpbmcgdGhlIGNyaXRpY2FsIHNlY3Rpb24gYW5kIG1v
ZGlmeWluZw0KPiB0YzYtPm9uZ29pbmdfdHhfc2tiLCBjYXVzaW5nIGluY29uc2lzdGVudCBzdGF0
ZSB1cGRhdGVzIG9yIG92ZXJ3cml0aW5nDQo+IGVhY2ggb3RoZXIncyBjaGFuZ2VzLg0KPiANCj4g
Q29uc2lkZXIgdGhlIGZvbGxvd2luZyBzY2VuYXJpby4gQSByYWNlIHdpbmRvdyBleGlzdHMgaW4g
dGhlIHNlcXVlbmNlOg0KPiANCj4gICAgIFRocmVhZDEgICAgICAgICAgICAgICAgICAgICAgIFRo
cmVhZDINCj4gICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSAgICAgIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiAgICAgLSBpZiBvbmdvaW5nX3R4X3NrYiBpcyBOVUxMDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0gaWYgb25nb2luZ190eF9za2IgaXMgTlVMTA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtIHNwaW5fbG9ja19iaCgpDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0gb25nb2luZ190eF9za2IgPSB3
YWl0aW5nX3R4X3NrYg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtIHdh
aXRpbmdfdHhfc2tiID0gTlVMTA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAtIHNwaW5fdW5sb2NrX2JoKCkNCj4gICAgIC0gc3Bpbl9sb2NrX2JoKCkNCj4gICAgIC0gb25n
b2luZ190eF9za2IgPSB3YWl0aW5nX3R4X3NrYg0KPiAgICAgLSB3YWl0aW5nX3R4X3NrYiA9IE5V
TEwNCj4gICAgIC0gc3Bpbl91bmxvY2tfYmgoKQ0KSSBkb24ndCB0aGluayB0aGlzIHNjZW5hcmlv
L3NlcXVlbmNlIGV4aXN0cyBhcyB0aGUgb25nb2luZ190eF9za2IgaXMgbm90IA0Kc2hhcmVkIGJl
dHdlZW4gdHdvIHRocmVhZHMuIHdhaXRpbmdfdHhfc2tiIGFsb25lIGlzIHNoYXJlZCBiZXR3ZWVu
IA0Kb2FfdGM2X3N0YXJ0X3htaXQoKSBhbmQgb2FfdGM2X3NwaV90aHJlYWRfaGFuZGxlcigpLiBv
bmdvaW5nX3R4X3NrYiBpcyANCnVzZWQgb25seSBpbiB0aGUgb2FfdGM2X3NwaV90aHJlYWRfaGFu
ZGxlcigpIHRocmVhZCBhbmQgaXQgaXMgDQpzZXF1ZW50aWFsLiBTbyBpbiBteSBvcGluaW9uLCBh
cyBkb25lIGJlZm9yZSwgcHJvdGVjdGluZyB3YWl0aW5nX3R4X3NrYiANCmFsb25lIGlzIGVub3Vn
aCBhbmQgbm8gbmVlZCB0byBwcm90ZWN0IG9uZ29pbmdfdHhfc2tiLg0KDQpCZXN0IHJlZ2FyZHMs
DQpQYXJ0aGliYW4gVg0KPiANCj4gVGhpcyBsZWFkcyB0byBsb3N0IHVwZGF0ZXMgYmV0d2VlbiBv
bmdvaW5nX3R4X3NrYiBhbmQgd2FpdGluZ190eF9za2INCj4gZmllbGRzLiBNb3ZpbmcgdGhlIE5V
TEwgY2hlY2sgaW5zaWRlIHRoZSBjcml0aWNhbCBzZWN0aW9uIGVuc3VyZXMgYm90aA0KPiB0aGUg
TlVMTCBjaGVjayBhbmQgdGhlIGFzc2lnbm1lbnQgYXJlIHByb3RlY3RlZCBieSB0aGUgc2FtZSBs
b2NrLA0KPiBtYWludGFpbmluZyBhdG9taWMgY2hlY2stYW5kLXNldCBvcGVyYXRpb25zLg0KPiAN
Cj4gRml4ZXM6IGU1OTJiNTExMGIzZSAoIm5ldDogZXRoZXJuZXQ6IG9hX3RjNjogZml4IHR4IHNr
YiByYWNlIGNvbmRpdGlvbiBiZXR3ZWVuIHJlZmVyZW5jZSBwb2ludGVycyIpDQo+IENsb3Nlczog
aHR0cHM6Ly9zY2FuNy5zY2FuLmNvdmVyaXR5LmNvbS8jL3Byb2plY3Qtdmlldy81MjMzNy8xMTM1
ND9zZWxlY3RlZElzc3VlPTE2MDI2MTENCj4gU2lnbmVkLW9mZi1ieTogRGhlZXJhaiBSZWRkeSBK
b25uYWxhZ2FkZGEgPGRoZWVyYWoubGludXhkZXZAZ21haWwuY29tPg0KPiAtLS0NCj4gICBkcml2
ZXJzL25ldC9ldGhlcm5ldC9vYV90YzYuYyB8IDQgKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvb2FfdGM2LmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9vYV90YzYuYw0K
PiBpbmRleCBkYjIwMGU0ZWMyODQuLjY2ZDU1ZWM5YmM4OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvb2FfdGM2LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvb2Ff
dGM2LmMNCj4gQEAgLTEwMDQsMTIgKzEwMDQsMTIgQEAgc3RhdGljIHUxNiBvYV90YzZfcHJlcGFy
ZV9zcGlfdHhfYnVmX2Zvcl90eF9za2JzKHN0cnVjdCBvYV90YzYgKnRjNikNCj4gICAgICAgICAg
ICovDQo+ICAgICAgICAgIGZvciAodXNlZF90eF9jcmVkaXRzID0gMDsgdXNlZF90eF9jcmVkaXRz
IDwgdGM2LT50eF9jcmVkaXRzOw0KPiAgICAgICAgICAgICAgIHVzZWRfdHhfY3JlZGl0cysrKSB7
DQo+ICsgICAgICAgICAgICAgICBzcGluX2xvY2tfYmgoJnRjNi0+dHhfc2tiX2xvY2spOw0KPiAg
ICAgICAgICAgICAgICAgIGlmICghdGM2LT5vbmdvaW5nX3R4X3NrYikgew0KPiAtICAgICAgICAg
ICAgICAgICAgICAgICBzcGluX2xvY2tfYmgoJnRjNi0+dHhfc2tiX2xvY2spOw0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgdGM2LT5vbmdvaW5nX3R4X3NrYiA9IHRjNi0+d2FpdGluZ190eF9z
a2I7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICB0YzYtPndhaXRpbmdfdHhfc2tiID0gTlVM
TDsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgc3Bpbl91bmxvY2tfYmgoJnRjNi0+dHhfc2ti
X2xvY2spOw0KPiAgICAgICAgICAgICAgICAgIH0NCj4gKyAgICAgICAgICAgICAgIHNwaW5fdW5s
b2NrX2JoKCZ0YzYtPnR4X3NrYl9sb2NrKTsNCj4gICAgICAgICAgICAgICAgICBpZiAoIXRjNi0+
b25nb2luZ190eF9za2IpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gICAg
ICAgICAgICAgICAgICBvYV90YzZfYWRkX3R4X3NrYl90b19zcGlfYnVmKHRjNik7DQo+IC0tDQo+
IDIuMzQuMQ0KPiANCg0K

