Return-Path: <netdev+bounces-101279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D5C8FDF45
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 09:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1987F1C22A19
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 07:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E15139D11;
	Thu,  6 Jun 2024 07:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dvwsSoA+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC2B33F7;
	Thu,  6 Jun 2024 07:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717657478; cv=fail; b=oVSW9b0en+J9qBfb5ye4XhX8DHbHQVPCHm90l5ZjFjLI3jxsqqaK7tEbnqnzOWhEugYxS1KVprLjgSkBW1NP/bu1rFWjgXI+qgtko9vTYLuAmP1VIKBeYRiDdL8DFidiyWlu/YhkZ3ZFQjxeq4p+H9eLYcMmqkZ5ZrP/BPiZWuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717657478; c=relaxed/simple;
	bh=4an/GqTeT5x0rqENbgql1Jyprpo+5avEKZJ5ZOErSWw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X6et+D3UcmeTbEjLinGjUTtJeDgc3u7cZTVD5gm7AnIKBQGSOdBAsFl5gGdnYmw86GZvDk/kqYN0jC/m7qoguPdrWAqKN6bxIGfiET/FRYrilkRhoQa6xIUlMOdW7TGi5E8FSj/vFtzzXUXZEG01uQXWfAzNsT3F4j3sQrZYleU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dvwsSoA+; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHHUCorfHBYynoeBBH9NZ8Hk4k8hVO3yOfHTEDFFHWMTs0gAhyTl7rt8OyTzeu84fRmIHqL5Tba+OSWziZGiUjGyrjRj68DU/1NSqq36MjxlU6RyJNj2qDfEZ9OQ8hWTWSu9Xij4G6QfLgB8cWHjRqlg98SwedCXywpyxdJf/lCruVxbQwnTqCgiSGmo7Jq09mLTyLdhoID793Pue64MqAGrvHJ2G137gNB2zgf0NLiHbC3aQXN04jf+zkvsZCDO/V/hbvsN+bTID2dord4wag+iT04JbYjqOZiYGkuyr2B5h4xsyfTpJ/qDEIjIM3LOv+6KjEeosDmZJDB6JytVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kH6Nnzm+ZjfseN+APfI+LerxRrUY5URLgQxxuqALvaM=;
 b=mYp2zNwhOcXxtkDcjlJld5RA7YEt30V82MDxgbqDUlCoWxVIYC6yQFmk6UplOkJlmgbNGi/MVdpS0ETjXtV5oI5ibqQOkCHdMhMDFlphn1atJS2KqQVba80WATKH52YMPhnT9J5FOdd8d5uf61DKsyXAXMOWO65ycRPTpg7mIlU87nWpt3QdVngMs6Rodw5hPyHiZHjy1f3HftP2LSH+XtQBdGmypIh8pcrOLOu5FSUrvEHE6r/zWtNFvCXDZjErcIEeKCQpfKMY7DEXTe5ihKE4+/i9ijmQzm4hK+4Tls7vncrRAKgBwOxtBSsVU7OUb3dG9OuC9G5ynsrU0CAEMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kH6Nnzm+ZjfseN+APfI+LerxRrUY5URLgQxxuqALvaM=;
 b=dvwsSoA+TFSp0kz6n8cGDS2lC80KieS/WZXLRKsX+TcKAnu4wwMK+Uu7pR9lGy4XA8vRAYJXfVYihwVwSBsF/bCvoKdfPvr2f/jqMA/Wbdy6F3lAaj8jGfrZWEEr8vPag+7OJBktsN/JmBRL4ebyMsFL2M2tWZ7TJRQf91pxDTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by LV2PR12MB6015.namprd12.prod.outlook.com (2603:10b6:408:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 6 Jun
 2024 07:04:33 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527%5]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 07:04:33 +0000
Message-ID: <33403007-c14e-4cd5-95a3-e78f88488840@amd.com>
Date: Thu, 6 Jun 2024 12:34:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/4] dt-bindings: net: cdns,macb: Deprecate
 magic-packet property
Content-Language: en-GB
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux@armlinux.org.uk, vadim.fedorenko@linux.dev, andrew@lunn.ch,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20240605102457.4050539-1-vineeth.karumanchi@amd.com>
 <20240605102457.4050539-5-vineeth.karumanchi@amd.com>
 <20240605154112.GA3197137-robh@kernel.org>
 <241cb8ec-14c9-4d7c-9331-2df0b8bf21b2@amd.com>
 <979b8f74-321d-4b83-bd3b-01643b3cbc35@linaro.org>
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
In-Reply-To: <979b8f74-321d-4b83-bd3b-01643b3cbc35@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|LV2PR12MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f75ddaa-450f-4676-0ea4-08dc85f6eb3b
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3JlNU4wemRzb0lPODdPYXRaZE5TckhuWHBHU2d6T1pGOGhPeGFjRE9iODk3?=
 =?utf-8?B?ZHF4RGhESi9vUmRYVXhxOVNlTzR1NGs4djRUYXVUaFNaT3p2cVczbEtEOWxW?=
 =?utf-8?B?cjVYYkwxcmFwR2diMVBUWE1wUzhXbEhaWGpJZUFDdW9lMzd3dW5MM2Z4bnBV?=
 =?utf-8?B?WHB2b0t4bEtPSkhDN0loZnNQM1dxNGdEVzU4YTFHak8rY3NVcEJvQ2QyQXFE?=
 =?utf-8?B?RTJGbzc0RkI3d3o4a2dFOWgvRnBQU1VlNi9CRlZBR1k2cjF1amVTbUxoNFhm?=
 =?utf-8?B?bTdDR0lHUWlKSVVvVEtaT3dzYW45M1VMYThzZWY2dkV2UnNKanlxYzZsanhm?=
 =?utf-8?B?dFpHVUxHK3hzeGU5WDZwQjRDTDVFYzIrWmFRUDZtWTFyZGhLdTBEM3hnRS8y?=
 =?utf-8?B?NkViTDNBUm5UcDhJdnByVGQraVVyRk9ZK1dLelBqVFVLaDFoZUJ1NGlXdndH?=
 =?utf-8?B?UHY1Ky9EZTVEWTNxV0JNckcwK0lLQTdpWlU4SVdDZzJKaFBhTzB1dzVuUFM1?=
 =?utf-8?B?c1RXZWxROSswdVMxbW84a2psNHdwMUlXeURBNlVIQncyTnoyZS9iaVpRUldj?=
 =?utf-8?B?cmFYN25MeVgzaWVtWjFnSW5SYzhNV2hJNUoyOXJNMk5CT2wxY2NRWjZwN2lG?=
 =?utf-8?B?aDFaU3c0TmQzVXZjcTJWK1NKWVVrKzlCY1ZYYjYwMHpHa0tmbitqWEJleEdO?=
 =?utf-8?B?cGlDYjdVSDdyQkJyRFNnNDZBdDZSSENrZ1pYYnBHS0dFMHdydlpDZ0ZSTVFS?=
 =?utf-8?B?VDNsaUxLUDVJamZHRDNqeW1DUDR5RVNoZDV2d2ROSmRTUUxIbjZVMXpXbElL?=
 =?utf-8?B?Uy92b2l4UEdsWHc5cG5oWUd1ZWtPeE0yM09MRDMwVkE1RE8xZENlbkZXejNH?=
 =?utf-8?B?MjBqNzZpYUFCSDhRK0Q5Yjh1Z1VmdWJwZDV1WjI0aTFma1FrY3BEeHhHZ2Yw?=
 =?utf-8?B?SnJZUWRkVVpUV0JoY0pwcXZ4clVTOWxnU2lIaXhYYUVDbGYrVXBkQzBYSEg2?=
 =?utf-8?B?WStnVEtib08rWTNIZXhLOGVkUEZNS1VxL0FnMG5pUnFOY0Ixd0Y4bjNxa0Vh?=
 =?utf-8?B?RTJmMkh0b2ljdW5mU2xQeTFucWlBb204bjdJNHJXZmpvNTUrU0IvTHAzTUc5?=
 =?utf-8?B?bSs3dkZrR2U3ektXdlVta2I5aDVoUDBmTS9ZR0c4Ry9hQjQrUHhRNzJRMDla?=
 =?utf-8?B?Sm5wNk1JbHNyaDVoK25DZ2ZZSmYzdHVwenFsMFZ5MVQ2S3RkZW9SY1dMWTlE?=
 =?utf-8?B?SEpsZkxySjgxVUpXK2YyUWZyN01SVjJLeHROamRWYS8xVHFYek5vQktHRHJZ?=
 =?utf-8?B?ZExmdGJCTmZlYmRCdE9yV2RZQituaTA0c21CWGdPdnUzYWpWL2dIWHhnOGwz?=
 =?utf-8?B?NFJpUXVzalBMT0tQM2h1WVlEMWF3RzM2bERTL0xzUVRaeHh1dWs1SWVMcStK?=
 =?utf-8?B?ZHJxTnZvZ1Z0ZnRPdXdLVDN6R1B6S2poY3l2Nm1kc1pQV2ZPdittUHJmQTlZ?=
 =?utf-8?B?Y2h3VG9EbHNKNnlKWDZnUS8wTDBySSthTEhBdzBYWmtlODBWZ0hMdzRLVFV4?=
 =?utf-8?B?UXdkdEVlcks5eWRRdW1xOGlRSzF0L3Jkd0h2Y2hXRUt1KzBiRTcvS2JBSHVR?=
 =?utf-8?B?NzVjUitMQmg1MDl2R2FSTlpyalhYcjZOUnNuU29iMi9GOWJuZUppYzVjclZv?=
 =?utf-8?B?Y0htcyttMVF2NXpMdlI5VE9RSXgrYUVOaEpBREVuZnBYYlZ2VU9JMktOWUhn?=
 =?utf-8?Q?uFRF21zhy+HYOjgzGSsPZ0KlQiQ8YDuS46J6dKs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clFWVldPQjlYN2pmM2FTZEtxZjczZGl1eG1xU1dMV1dSbndsWW9xM1IvZVlY?=
 =?utf-8?B?UUJ2VHpFb1Z4MGtsYjJIUkxWV1lBellza2ZmUnE2eGo2NW04UE55VzNqaHVQ?=
 =?utf-8?B?WlpnbmVGMWtkL2xzVmlsVnRreVdCZmp4VDdMcWJrT0preitaM1lrbEZ1QVVZ?=
 =?utf-8?B?bkQ2ZTRsVC9NODc0R2VMNThjSjQ3cXgyU210TkFxNnM2akdpWDA3WDk0QWlN?=
 =?utf-8?B?UlhmSzEreTJGTm42WmhKV3dZellRN0dhczBBelp6U3BPMHN4VzNQV0lWcDEv?=
 =?utf-8?B?L0UxODhMOU1NV3ZKRXJmblM5ZDg2Ly9IZzAyRmlLakowVjJNM2VkU1ZleGF1?=
 =?utf-8?B?ZlBETWtxT3RER2dJUVN0eEhtL3QrTXFHdFEvQmsxdFExRmFMOEc0cjg5MzhO?=
 =?utf-8?B?OG4zT2xwbHgwUWtvek01ejdORE5xekxJbms1S1JMUk5ycmRGOEYwNy9qcC9N?=
 =?utf-8?B?UFQxcVdhQ2RCZHptbGhkYmxWVkxKTVBkaTZIMFFlWHhFdDhoY1B6cmRqWHFO?=
 =?utf-8?B?NU1Jam56aEhKWFlNenNoT0tSYzgrWUdkSm9lc3QzdncrbGswSjRMOHFCKzk0?=
 =?utf-8?B?Q3JVL0NUaU01ckJzM2h0OHRZTEZ0TjBBU2lXYW9pZnNaRjAyMit2WWlTSHlD?=
 =?utf-8?B?dWtFNWNyRkpRdVBLREpsQjBKbE1PMzllUGlncEdtckN6cFBGMUZZam9tKys2?=
 =?utf-8?B?a1FmU09DNi9DZVZkWHZ5OHk4dWpNSTV1MGxmZmJtVnZCMWZYUmI0VmttQkMz?=
 =?utf-8?B?Y3NWaGtaMFNJSjlLL2lHaVFZc1NEQkp4amRCT09qTW9uRUdEYXRONnpLWWVv?=
 =?utf-8?B?WWZQYTkyaFJtNlI1VmFQTWpiSDJYMVJSWWtqZmJnSk1JaDhOUThSOVJCc3JS?=
 =?utf-8?B?WGRVNVArM083YXExV29tTmhVQytYUlpOUWNBSTNSaFpyb2JCamgzWXF2MDl5?=
 =?utf-8?B?aUV5aVFORUdnb25GaGJKQ3hZMW9PQVliQXhZSk1sVGo4RXpuN2dIc1BIYnhJ?=
 =?utf-8?B?TzBMaFpjRkQwRFdROXNLWTVJRDlvcnIzU0JXeGdzVkI1dWdpQVJkMDJmQWRO?=
 =?utf-8?B?QjNwK2cvdjlwSEZ2UCtnZHBTSmZmZ29TcE9JZ3dhOWNZZ1F6bm85azA5N0Jt?=
 =?utf-8?B?Y0p2ZklKQXhycnpzQzFEWlgxRGpkS0RGNE9zQ1U4TkVZTEV3YlB0SnZlSWpo?=
 =?utf-8?B?aEJzWVhhY003ZXBzTXJFMGJqWXdhUjhEQWcxa1VuOSt5S2xnUU80WGF1NkZ6?=
 =?utf-8?B?aGZ6eG9ZQkxiZEM0ZTNTWm5xRmZZNDZ2bnRmSjdweEFoeiszdk5QRi9VWk9m?=
 =?utf-8?B?b0lzNU1BNzBSRVF2N2p5alNFUklEbHNKR2hsK2NzbkQxUEhsak1JV3l6ajFj?=
 =?utf-8?B?dVdWdUZ3RWlsdVVadFZjajZkajBSemRyTS9IblBqemZWM3ByT0JxZWxIelE4?=
 =?utf-8?B?OENvRTdCc0R2Q0ozYzM0Z01wVlkvT1FYc21QblFSeFZVUm9aQ1B0TVhiZ1Ir?=
 =?utf-8?B?aVN6cFBEZmcrYkE1Smw4UW5Ma3NjZ1RhckJvQ0R3V0JWT1hOSGJMcUV6Nkpr?=
 =?utf-8?B?aHVFZFRKdmZ5RitqNXZHbzVjdE9zRE83VVIxRXFvQmhGTFR0TWlJTzl5QUtR?=
 =?utf-8?B?Q0RiQ0hVOE93NEJINldNZ1BEeWQzVURWZThIcTlKbThMZW9sUVVrRFg4cmsz?=
 =?utf-8?B?SlRVYzJpZVlJckxxeGtBZDNIV3dETUdtaUZUKzA2KzRQZ0lrQm05T2EwZXZh?=
 =?utf-8?B?cmRsYy84MllETDlPUmdIR29GNEJzbkljVmVJRFVGbWh6Uzg5eEZSR01DL255?=
 =?utf-8?B?MmdPNS85cW1xbHVrdkZwVkJZU05pYVhOa0p2K0ZhVkh1Wnkxck16RERPR09B?=
 =?utf-8?B?K1VOcFN0QndmL3R6OEdRREZzaktxb0xJQnd3STl6VmJSS2lmMVFzYzJKbWFY?=
 =?utf-8?B?VFhLY0cwUjRmc0NYckg3dzVENm5lZkJoWXZORGFmaFBNV2thWGFHQXZLUjJU?=
 =?utf-8?B?WE85UzVibmRHRkZsbmFXSDdrYlBIczVDajJLVkZXZHZ1YmJld2F5ZVlYcElk?=
 =?utf-8?B?ZUwyLzAyZ1JMRkZuZ2tiaEZjbzJ3QVV5MVpKTDhTYU5yeFJrL1hXOGE5V2o0?=
 =?utf-8?Q?JfGVXY7tou7rJgQ2XTROr3jxR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f75ddaa-450f-4676-0ea4-08dc85f6eb3b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 07:04:33.8006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EObeFUfElPeAn3zbedT43LFr/Lfmhw4276HaGZIucQnhZ5LzbfC23RMNMwfAWMP3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015


On 06/06/24 11:47 am, Krzysztof Kozlowski wrote:
> On 06/06/2024 07:13, Vineeth Karumanchi wrote:
>> Hi Rob,
>>
>>
>> On 05/06/24 9:11 pm, Rob Herring wrote:
>>> On Wed, Jun 05, 2024 at 03:54:57PM +0530, Vineeth Karumanchi wrote:
>>>> WOL modes such as magic-packet should be an OS policy.
>>>> By default, advertise supported modes and use ethtool to activate
>>>> the required mode.
>>>>
>>>> Suggested-by: Andrew Lunn <andrew@lunn.ch>
>>>> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/net/cdns,macb.yaml | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>
>>> You forgot Krzysztof's ack.
>>>
>>
>> There is a change in the commit message from earlier version,
>> as we are not using caps any more, I thought of not including the ack.
>>
>> I will add his ack in next version.
> 
> And where is it mentioned that you drop someone's ack on purpose?
> 

sorry, mybad, I missed it mentioning in version history.
I will make a note of it.

🙏 vineeth

> Best regards,
> Krzysztof
> 

