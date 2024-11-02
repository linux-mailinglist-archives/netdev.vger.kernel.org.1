Return-Path: <netdev+bounces-141222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A58C9BA13C
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 16:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED319282288
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 15:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BCB189F5A;
	Sat,  2 Nov 2024 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="HtlQtZL4"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023126.outbound.protection.outlook.com [40.107.201.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E80456446;
	Sat,  2 Nov 2024 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730561709; cv=fail; b=bpFmAx/IvYYh+H+1wrAdKvtIhBNUzgxJvp6uYIDr3c7/10sN3bisalslO0EjfMBYI3x7DnrcNiQHajqsTOw6hIPziihXpXfwXGjaJq2mKhPXwCIEiNtR7cLixhok2T1XjKt0RkIe5149DLi0kFKdri9w0NAMEbitZCO8jVG5BxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730561709; c=relaxed/simple;
	bh=ebIYdG/XR17C0BaRtcqg3ADR0hFtWtnFDGit0tqO7/8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JMB0dHVKJCOA9if8AIszjmWlgD+0mDh5UhAc9VGgpwJVcYLY0oZaCTGxvaiVMOxS5a448Ca90bNKHa3S82eC4siaRVLdJOd/Xi5KiIOn0eaEECi2EHmJ2gKrDxTCmwGh6oe9yA47wf1smuTmEMx48n4qTKs1qfacJtmvyZs9bmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=HtlQtZL4 reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.201.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WlKp3QXHbNlTPASzKhFwxS+J5QFZkHtEwReJuoTNkZfEnFTa8QCfE2MR4oD6fH10/c8OATiv095IBwhrQByCmxTZyLbF4xPeNAkLgtKrPLPVC4QVaedCSY1bzZwH7nmiNL231i1Cg2QlXv3pBFRJ1JXo+ghymxmpIJkDTXxrIB4B833mk2S4GNqewqIHvNUNAhZnbETxrasiGw1xMPJHn7ywDNGRCt7tTLKIpDavA66unUTP6bJU+R8XyDHiVUmCv/XApqBkaKNqMjZjtMhY2N+kbMB512R+xxN46Q/Y49lJh0K8mKjSKPxb0zCa8xu93MbZB9omZefsFgvmt/DEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XdFkKt2eNmY1F7TB+3ALTgZTKK8cgAeTdW+IYyGC5Q=;
 b=oixRfwp6dvRJthS3V1O5F6keyrGW26xqMOGOeCiwAJIbsO+FGeJ6GP/gZ55ut7FpUjao7nNezaFup5KW642r5pSj+aU9cPci/XcdUuEcKeQ+hCaU65JorWjxgrz1icRoF/fzAwHRlmCphGkVw33XdbVKilRI5Dor2WSCATtYBANsZn2n50hFU0er+39cbOxEXy0Tm6pnKfL22QNzc4NxKeNSyTQwBRIEw8FhDRCyzAQJj6DL8vHLDsJox5WibNRUiRtEkmdT5m4YZ/EooR+m6mbAsFxUDkdr5m0lgtQO6jzz5M5zShe55kKzwM4zPRku/MhqwMVvPwkNx38nB93vEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XdFkKt2eNmY1F7TB+3ALTgZTKK8cgAeTdW+IYyGC5Q=;
 b=HtlQtZL4BFMuduVkBWktmTzaNgPNrUiBgz8Y67n38ScQU4TmDItakTHhfdYiPB3ahhG8CfxD16UsoeRy3QXskFI2sXPTJD3MXrGQf8yCx7+bN56HUOo5IbwB/cM9RLbH7K6uoJIIjAOXYsBIzocf/H7S/24Szt0u4yyEMWlnLzk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 BL3PR01MB6820.prod.exchangelabs.com (2603:10b6:208:33f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.15; Sat, 2 Nov 2024 15:35:03 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.8137.011; Sat, 2 Nov 2024
 15:35:03 +0000
Message-ID: <d9969244-8f4c-4f66-9ab1-064be665495d@amperemail.onmicrosoft.com>
Date: Sat, 2 Nov 2024 11:34:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] mctp pcc: Check before sending MCTP PCC response
 ACK
To: "lihuisong (C)" <lihuisong@huawei.com>, admiyo@os.amperecomputing.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Len Brown <lenb@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Robert Moore <robert.moore@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>
References: <20241029165414.58746-1-admiyo@os.amperecomputing.com>
 <20241029165414.58746-2-admiyo@os.amperecomputing.com>
 <a05fd200-c1ea-dff6-8cfa-43077c6b4a99@huawei.com>
 <38fab0d5-8a31-41be-8426-6f180e6d4203@amperemail.onmicrosoft.com>
 <f44f9b12-5cb1-af1d-5e2f-9a06ad648347@huawei.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <f44f9b12-5cb1-af1d-5e2f-9a06ad648347@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR18CA0007.namprd18.prod.outlook.com
 (2603:10b6:930:5::31) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|BL3PR01MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f14622-a801-412e-21ec-08dcfb53eb5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkZyY0ZSUHBYdkRxdlFZZ3FJd3k4THNqdTRTYzhhdUdBVHNMSFRMbkN5NWll?=
 =?utf-8?B?anRpN2szTFNIeE10eEkvZ0o2bkZ0UDQxazIySG9nWncxdUxpb3o5Z0pTWGtG?=
 =?utf-8?B?MU5pN1JrdHZHWld3TmRZcHVZaUJMemRxdGdxV285M01xSnJMMTI3RjhnZ1Fz?=
 =?utf-8?B?eCthcVNqblR1NFhpejluMFVMN0lFQk1kRFRYTVhqU1V1cFZhODhIWDVXdTFq?=
 =?utf-8?B?SjY1RElJYWRkanJQTUFVdnZrbk1nZWdrdm4yU1hneGYwaUxOMWcyb3U2UEFF?=
 =?utf-8?B?ZlRjak5JV1B6aC9rOXkrcW9sY3RvTlRWN3Q5bmdacm5xNUptZ1lyS2NEOGZG?=
 =?utf-8?B?STRmOWMydzlnUUFnL3JwYjA3NlhIVTRjaTNqbTlJRDU5ZjI2VlZNNnRsTHVK?=
 =?utf-8?B?NTVyQUJzL0JYUXpsbFBZNkJabTJTL0ZZQmF4OWVwOGZRbE9XR1htenBTUlNL?=
 =?utf-8?B?Mkd2cUlQSGcvU3Q1dDJMemNtVjNQc0JLV1hwbzRvWG9tWVc1UDVHSHBadnJx?=
 =?utf-8?B?bjVHa0xvYUZLVnNIR2M0czRRSHRydkNHRjN2OElldmt1enp5cTBaSURPRzgw?=
 =?utf-8?B?QWhXcGNKUW5IUml3WU1zWmloVityTDg0bUNqZDNZYVYwdzBrWGRSZHZ0azlS?=
 =?utf-8?B?Vzd3Q2JlSDM4WXpzQ09sdmgrT2loNkIwRnBMT0pyZU54Nkw4VlViVEtMVFFj?=
 =?utf-8?B?REYzeklGSjFuSmx5cDNSdTI2ZmsxTFZiVlVpTW9lMTM3c29CV0xkdW4vQUZP?=
 =?utf-8?B?UllRQ0lnZ21yNGVUMC9aNWc1WHE3NEMzUVp1Ni9PdHIzOFFJRGNPRURuSWc1?=
 =?utf-8?B?TUdOaGkyM0pGbU10eGhJLy8wWVJoejVCLzZhNGViK0xaeFNucnVhTnhncTlT?=
 =?utf-8?B?SHVGV25HKzBRSElObkpzTjRYa3NzVHdnQW12QVZpQlk1OTg3bGtPdE5NbFk0?=
 =?utf-8?B?RWFiekdkaVZnbTREb0Rlcm4wMy9xWU51Z1UwZng0Wlc5VDdkd0JOSHMrdU94?=
 =?utf-8?B?YWxaQ1JsUzlYVzFnMVZ5MEROR3ZUc2dQT1B0dm5PeGliY0pzb3VpRjYyb1pJ?=
 =?utf-8?B?SFJVQ1ZHRkFxWDVSVXZyT2x6cDVlelZzVTJaZGkwMmRtSjV0cDJxTG1kbC85?=
 =?utf-8?B?aWFVR2hJVU9GNWZ6OGFwKzdxemJmRHM0d3doZ0RuTG1WQ2ltRUpiQ0lORmpJ?=
 =?utf-8?B?cFM3N3ZsY2dtYk1xSXczMk9kNW0zM0ZDMWp5U09sRFYydGJpazVuR0V5SVRK?=
 =?utf-8?B?YlJKZWFTRnpORDl2UjFPVE9NcytMeXg3VHZVVFZuTTFLQ05kamJTWldRYWhT?=
 =?utf-8?B?OFl3eXJtemdMUTlyMU1iTEg5dlJwZUZ4NE9pTUFaN3k3MmR6NVhia2tTMFV4?=
 =?utf-8?B?UTZaZW85VGVjV2dGL3ZuMkNCeVN2Q3FVSjFIa0FZcFQzdVpreUNqYlY5UDMx?=
 =?utf-8?B?YWhIbVd5SzZBaXpuZGVWbXlXTmdva0FqUmlKWmtKYUJaWlpqZUg3R2M1TGtt?=
 =?utf-8?B?YzBYOEl3TEZQMTI0RnNzWlh3Y1JZTytzcDBPNzNZUjN6aHYzcUNBdktZTTd0?=
 =?utf-8?B?U0hIbFdnMnVFMUMwY2ZjcXl4SUU1MW4vdXV5RFp3YnJ6Sy9DcXBGY09GK1Fw?=
 =?utf-8?B?Qkx6b1pOZGZGSlRMeVl1SitBZGw4T1hWYjMxb1k2VEl4OXg4SHRMWjhIZ3gy?=
 =?utf-8?B?Nk4yUzBaNkZnVlM1ano3VXVpR2xJZEZFOXlFM0k1S2RRMGZuMGlrZGxCTnEr?=
 =?utf-8?Q?Xr9KUtKXkqiqaAR7HOWry+pj2LK8ok0nVHcWjm0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K05adUtSelFVaUNGWnE4dW5tSVZXTzFXQkYxeVV6ME9mUENUU2Q1SHB0K1dO?=
 =?utf-8?B?eWdvN2Nia2JOOGVvWEhqK0ROTW9Gc1JlK2xYOHc4SjlpRnhIdGc2ai9XTjZi?=
 =?utf-8?B?eFM3RFVRRVh0cGpneWxqQlljc0VUY0pUWjU4QmkzNmk4M284MGlRR2QzYVg3?=
 =?utf-8?B?N0hFbXljbWtPamNQc0RZSkxnY3BndFNTQUpGcmFnYnJjTm9wNDNveUp6NWpm?=
 =?utf-8?B?MWl0TkNieUNJa0N2NmVuSDFjRXhZeFVkMWl6b2lCdE9xc0xDZFBYNXZTY200?=
 =?utf-8?B?Q3hRM1E3U2FkbytCSU9wa1ZGbitaSVhtVWs5Mlh0cUxJZUtQZVNnMlJpamhl?=
 =?utf-8?B?NUlMeUt1V0VEVGVjazV3S0xTcG9lbnNleEREc1R1TWhiTStZQnJIeTd1dm9I?=
 =?utf-8?B?SjdVVlV2UlFDYkhiRERCQVNjaEF6OWt3amZjK3p2cmhBbGJvT0o1UXh1WkZ4?=
 =?utf-8?B?UUxyYTZ6UE8wc3NVRHRxaUdhSS9MODlveUNwaTcxOWJpTFpwQzBpelZoakN2?=
 =?utf-8?B?OVhqNnhPQlJLQ2tZUEJ2S0xCdlZ6ZjN1QytsaUJaV1lMdE5YTE9ielp5WEh2?=
 =?utf-8?B?UWRBcW9nOG1Qd05HbEVGdGx0Z2hNdUVBaUFuUkF2UkpocUJUdnkvUGluRXJv?=
 =?utf-8?B?ZWFIcHFRNWJOVURKSFNUN1BlQVlaakdtUkorYm9JQ0JuUXlQRnE1blp4QTNz?=
 =?utf-8?B?T2VqdEhEL2dtREpPTDc2bDEwQUJPM2NBZkNGbUZmWVcvK0VyNmUxMHhVRlg4?=
 =?utf-8?B?Y0tNemwxdDdXSGQ0a0ZYMk1vQ0ExNjExeTd6L29sOEd1OEdkSVJxaHhHYVkw?=
 =?utf-8?B?V1VNSWNlRHdBa0lFWUFVczhSTjdDWEZieGFLT2NLNG1QSDNRZDUzaWY1VlJY?=
 =?utf-8?B?cmV0R0llM1FmQUNhNGlwUjFqUDVibDNLSTVSTFU3d3VHNzZqWjh1cytVdWVz?=
 =?utf-8?B?MUU5Y0htVmM5K3BLYlFkbitIOWY4S1R4N1dhVGl4WitPL1NjcEU4bG1QUzZm?=
 =?utf-8?B?VkJuS2RETytlanlsQnE2VnpJb1dScG5ESmt5WFpSTTVlaUpUdEVpWkpNNStJ?=
 =?utf-8?B?TXJKK3B3SmE1aURMOTRreGVhQVQ1ZUJsTmxVWjNjMkRCRkcxQnhCR3BJdUh1?=
 =?utf-8?B?eDVWZFNPOU1abmJsam9mVzgxSlBBbGxudkJHRUVsUUJFM2IxZG5HMFVrU0Vt?=
 =?utf-8?B?a0ptN1Y2OXFKdW93bDlKbDlNTTNJS1V2THB2NXU3aTcxbkxBMXgxc0ZxemR2?=
 =?utf-8?B?L0RYMXBnalRRQ2JvZ2k1WUtHUUpobTMyZkFNdkNDNWR0S0h1a254Skp3M25R?=
 =?utf-8?B?ZHBVamZKc3BDOEtQYVJ1UitwV2FTam0wQmZtbG52eVNlakFVMkMwMjVpYnJO?=
 =?utf-8?B?ZEpHM0RjUDlUWnIxYU5aT1lieG80bDZpQko1SmUzM2FMT216VUI2ZFdIc3ZM?=
 =?utf-8?B?dFVjMVJTdUcwcVRVd2Y2ZlVlelZpL1lFTlI3Vy9PTXovODU1di9ZWk9Bejdp?=
 =?utf-8?B?R1ZTNHpJNzRrOWpLdzJNNndScTk1akdxR3pTZUgvWFFoVlhtc29aZjVXZER5?=
 =?utf-8?B?OGwzRlZmREQ4MUpuTkNHMmpLR3F4aGxENjdtOSsvU2UvU0dIcS9vNUtHV3ov?=
 =?utf-8?B?MnZyTW9tczVlZWdUa2dUazQydUFudFBxaEFkb1h0SUNJeWJ2UFRXV2RnaXVk?=
 =?utf-8?B?NHltclVnT1M5TkVXVFBkb2VPS05QWGVKVlJmTE5HZ2F1UlFHaWtlLy81Titq?=
 =?utf-8?B?Ymo3aGpTZkhFZktKb2tpcnhjeGNjOS81SFdDdkxQaHplV3RHTlMvN1JnbExo?=
 =?utf-8?B?c3NLaUFOaHQ1NFl5Sm9DNE9RZGxtVGI5TlFnT0FkOGVBRXpiWVpwQ1hUQ1pR?=
 =?utf-8?B?TkhpVjlKRWpyVGZwd3lLYmN1OWs0bWdRUFU0WEFkWnNGVnF3VVU3OExQbG5L?=
 =?utf-8?B?YXgvMnFYY3paOXZ0T2wxS0VRek0zMWtYOVdJR2ZldHZFTWJkSmF3VWF1NTQ1?=
 =?utf-8?B?WGx0bGtaNzdYVUlxWlNnd3RDQnRKTVdCVlcwZ0FHR05tU3Zwd1ZORHpQN2hu?=
 =?utf-8?B?V216OFFMNmp6Ym9qaEtveURNMmZtTlF5L25iSEpGdmdUbEI5OHo3ajRRMTJw?=
 =?utf-8?B?WklWdXRIN0hKcDNCSVI4eHp3OEViUjNDM1lqS09zWGJLMDhnRTlTM0R3OXRI?=
 =?utf-8?B?VVlQN2VzUkR1VkF4WmsyOXk1MFNHMjZxM2U0cUw1ck1TRFBZSE1zNm1WM3p6?=
 =?utf-8?Q?yC8DYl4OQjamPisjBuGxoyV5XwLPa9oBB63FjkgYGQ=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f14622-a801-412e-21ec-08dcfb53eb5a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2024 15:35:03.0105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nCNYnzFRK25rfETiGXdWD/cNJr8TsWofZA8nL1NgVwjNnUU57pit8xvip5LigEf+lpjouU9hxhwirHXIGQyqXZ65SiMG8I6jEi0FANy+xWmMDDRrV29XV3Shp2qCF7f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB6820


On 10/31/24 21:30, lihuisong (C) wrote:
>>
>> On 10/30/24 05:45, lihuisong (C) wrote:
>>>> + check_and_ack(pchan, chan);
>>>>       pchan->chan_in_use = false;
>>>>         return IRQ_HANDLED;
>>>> @@ -352,6 +368,9 @@ pcc_mbox_request_channel(struct mbox_client 
>>>> *cl, int subspace_id)
>>>>       if (rc)
>>>>           return ERR_PTR(rc);
>>>>   +    pchan->shmem_base_addr = devm_ioremap(chan->mbox->dev,
>>>> +                          pchan->chan.shmem_base_addr,
>>>> +                          pchan->chan.shmem_size);
>>> Currently, the PCC mbox client does ioremap after requesting PCC 
>>> channel.
>>> Thus all current clients will ioremap twice. This is not good to me.
>>> How about add a new interface and give the type4 client the right to 
>>> decide whether to reply in rx_callback?
>>
>>
>> I do agree that is a cleaner implementation, but I don't have a way 
>> of testing the other drivers, and did not want to break them. I think 
>> your driver is the only that makes use of it, so we can certainly 
>> come up with a common approach.
> I understand what you are concerned about.
> But this duplicate ioremap also works for all PCC clients no matter 
> which type they used. It has very wide influence.
> My driver just uses type3 instead of type4. What's more, AFAICS, it 
> doesn't seem there is type4 client driver in linux.
> Therefore, determining whether type4 client driver needs to reply to 
> platform has the minimum or even no impact in their rx_callback. 

  I can move the place where we hold on to the shmem from struct 
pcc_chan_info in pcc.c, where it is local to the file, to struct 
pcc_mbox_chan in  include/acpi/pcc.h where it will be visible from both 
files.  With that change, we only need ioremap once for the segment.

I don't like adding the callback decision in the driver:  it is part of 
the protocol, and should be enforced  by the pcc layer. If we do it in 
the driver, the logic will be duplicated by each driver.

I could make a further  change and allow the driver to request the 
remapped memory segment from the pcc layer, and couple  to the 
memory-remap to the client/channel.  It seems like that code, too, 
should be in the common layer.  However most drivers would not know to 
use  this function yet, so the mechanism would have to be optional, and 
only clean up if called this way.






