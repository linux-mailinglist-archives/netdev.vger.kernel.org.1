Return-Path: <netdev+bounces-112190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E146F937579
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 11:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110661C20C78
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 09:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC29B7E0E9;
	Fri, 19 Jul 2024 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="t8W6qRza"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2135.outbound.protection.outlook.com [40.107.117.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D88F5CB8;
	Fri, 19 Jul 2024 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721379972; cv=fail; b=XHhGzL+G/nHksicTWlpXrMI0LsCo9hkQPnStzfufScjnyfe836I0u5VDohvy/+mj7PXPgn6irq1PI/NtR9JdG06+FjLg3HU9N9J89WfFC6NjZp0GLEE5OhHEaFiSdkpdU4xzazLj/zibOJtjnzAnopp/KZ9A+63ogUpoBPesjtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721379972; c=relaxed/simple;
	bh=qu28dQAwiUjHRH5tSwGp1Knl/bh1Pv1MsY4UXeQe7Bc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c+0mv3os4Y5SGKL93Evxlu4a7Xxbb0yWRp/e8T5VCXDNLyTPz6zP4diQGgzo2mjKI4eF0knkWosf5Xrj+suyVWdFHcNIwCFAYErFO4raMzo2lRF/Fcb73lCgHxAsfh00MwX1rQWhKYCVaVZo7DEoPNYRWnLFPv+9H3G7AKKfjXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=t8W6qRza; arc=fail smtp.client-ip=40.107.117.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYHuY9FsbyMgqCcgfojk5Jby3iPbQfR+8/WnOYtbyHXA80orSdkZrP7nZYxexNQnaCWcKgAvL4r5YUlxx+wY97c5aUXj1Be+g0oNhxGlvroiKT42Q5tuUwuqezFnHfElBLqDTN3gZ/TiJRFKgjJEdJuFSn+WdnPEIQEcXw4FrfStEbHoLnMaEZ+/XndtKIqf0pBQVog/C5SQrSqLF9ILl95P+Ee/YhPeS0FgnLphsTmWy5B7NGNF8oSRlcrdac/VGn+FaobxC4ttDjB4JRj1fRhHqvSFh0d7mQ2yGw2O2gAcDoR7BUu7e9YIfxMz+4/qOfZ+EJv04T2m5QOEYgJK+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yrd+LVDb1EOZMrWe26QbZ+CMRVozclKY/X4zFCtrPvo=;
 b=kdxGTLIySVqG6TJ3WMMDRLaQBw3Too6B6XMDg5EUZluwkO2aossLuUyBZk7BnugYz7vaOpXqXIamcAn5ruPuLrsRH4cclR6tbtG4lmfSTw/mNdvunOO5XA5/HwS+0JvS+SCKRoFVxvWFCKusLQRIZ5lfsibQzjieD3Bb0XujOYIKNSP2qhfPoOBTbAIo0oukGbEZvdE5E/Msl8BBmEUtTXcfwrU5Iex47nmk1UjXxdXGalnqFziDeOWmhatUPUSlXKx1DjbVqRmHNn28lEbA5nHsiYv23LYEdecrc4Nup3Oj4mJFfca4AqS/lNvheTQ43sjNYuLKJgQcjfXcsS+Klw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yrd+LVDb1EOZMrWe26QbZ+CMRVozclKY/X4zFCtrPvo=;
 b=t8W6qRza+HmXa1XwHxo2228OKvPOp6/ZvD3tShknncOXkGwQVv8LE5MY4y1+9YLBoY/5DtT7hkIbon/kX7sUoPvcawTgXHylikpwey4EuBm0ZIFNfrjxnIoAsEpkUUdRWCBpAR2bkjWn6ZhL7Vn2GIMoqh+qVGovF4TTjUri0K9NznlewUmIo578ltNhl3x/uSOZa6aTAnMUT2vsJf1uh8+sVRQPCfxFOF4spaYoDhhSgjqOIYylVCio2nUQY1syay88UhhJMqtAB3iEC8uiM8MjIV88hScnQkglMCLbExTR+h5CEhEKdi2L9+/fejqrcXNK8KETLzU5POlaGIx36w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by KL1PR03MB6924.apcprd03.prod.outlook.com (2603:1096:820:b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Fri, 19 Jul
 2024 09:06:07 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%5]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 09:06:06 +0000
Message-ID: <7cdb7cef-db8a-4a21-af1c-2b29898a5814@amlogic.com>
Date: Fri, 19 Jul 2024 17:05:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] Bluetooth: hci_uart: Add support for Amlogic HCI
 UART
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Sai Krishna Gajula <saikrishnag@marvell.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Ye He <ye.he@amlogic.com>
References: <20240718-btaml-v2-0-1392b2e21183@amlogic.com>
 <20240718-btaml-v2-2-1392b2e21183@amlogic.com>
 <BY3PR18MB47078CCD43FD8B1DB6D9AE78A0AC2@BY3PR18MB4707.namprd18.prod.outlook.com>
 <CABBYNZKO_02eBmDDKN2ReviM+SpEzozYPbohjBPjYtf1MqAzuQ@mail.gmail.com>
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZKO_02eBmDDKN2ReviM+SpEzozYPbohjBPjYtf1MqAzuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::20)
 To JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|KL1PR03MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a92eab-1768-43c1-d7eb-08dca7d20614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWRuc1d5S1U4QkNEdkM3ZEtLVEdFd3g3Q0ZKVkFORWNvU2x2K1FFbFJRVTlS?=
 =?utf-8?B?OTZOWEFwbTU0OEVqNm5sNHY0dHUvcWNSRU1MMDd2ZmhIMHpUejF4WGRadTNU?=
 =?utf-8?B?em1NTXhrYmR6bW5SSDJ2eW91SVRvcnJ3THhuQWVUcjF3andHaTNBTlVjSWVU?=
 =?utf-8?B?TE8ycFlVVDFzVjBwc0F5MllOKzNXQWJWb1JMYi9MUjI4ZDQ0NCtGOURmRnlu?=
 =?utf-8?B?MXJZT2dobEdOa1BBRytDdCszYVRSNnJCRDhrVVdxOGpWdExRNVVhcVlNQzZM?=
 =?utf-8?B?KzNPVlFUblJoYlJNbkk1NWQ2Sm90cTdQWnRIaFBXWjJGcHZpUUtNQ2JHWnZ1?=
 =?utf-8?B?Z2o2czNEdXdrZVZuQ0pCbHdsRmZJK0RSOWJKbkc5dmlzK1Jva0tobjZZdHBw?=
 =?utf-8?B?U1dIOXcveWZ3Rk5yN1E2N1Z3cUdRU3FxMFhrVDdodDB2ZDRHcUtjT3FlbkNK?=
 =?utf-8?B?UndDYXZVT2hiU250VmowdTVWS0p6ellkVXdYWDN0WTVLeEptK2hyMnEzYzNx?=
 =?utf-8?B?L05jVkxQcitCZ1JQazVDUnV5SEV5eVBIWjZIMUQzSkE0QXdoNEdVVVhGaC9E?=
 =?utf-8?B?bmRaVCsvd2piSlZMeFNQNUg4TEdZVk1rYWxNem81Q21kQVlwZDNkd25COVhw?=
 =?utf-8?B?VHNMVUJKQitxTTZzSXNQaFJsdmQxR0M1V0ViaXZKY1VWaHdFQmMyYkQrM3B0?=
 =?utf-8?B?MDNHTWF6TUFYSUlsbjJmZWt6TFRjUzZjeGMvUHNnenpzTFJ0c1R4TTdUS0Zk?=
 =?utf-8?B?ZnJBOTFoWWdLTXFLaXMrWnpEQjZ0TWdZUGl1VmZQMk1oOHlKc0ExaWJXQ2U3?=
 =?utf-8?B?YjNNZVh2bCtyWElLYTd0VDlRbG1ic05Sbjl0aGFzQkZQRFN2QUlDK0Q3a2JZ?=
 =?utf-8?B?dVcwV3dMTUJTNjlTRnVFWFhKUDFUMEN3SFNLZW9zVVNjNW1MR3pZaU1ZZG9S?=
 =?utf-8?B?anVDMDljT3MyWFBleUw2ZlM1VUJjSE9KRWUzN1J1a09YS1ZsYVNWYitEWVRX?=
 =?utf-8?B?cWs1OURSV1RVQ0x1clVDMGR6bHJCNXVXSDZxOXcvcmxaMlNMQm1mSStad2FS?=
 =?utf-8?B?d2wwZDZ1QTM2T3BSWlNONUQ2L3pLV3VhQi9FY1MxYmtPSDJ6NTlFazdHTWtP?=
 =?utf-8?B?TnJzR1k2OFIxdVFnS1NHRTdDRmtGWGV4RTd5V2RvK0xqZS9sSlpYVHgySXhR?=
 =?utf-8?B?ZzE0Z09wT3lGaTd4VXAxL1E5QU8zRW8venJaUWxvZldBQWRLT2ppZkVleTRP?=
 =?utf-8?B?M0gra2dwZ2hWMXptcEJzUnQvRXZLcXZUWXdvZFFoaTIzRjFPU1pHVTIyd2hN?=
 =?utf-8?B?QmI1V01JMGx2WmM0M05UZTRoNWtvRW04a3dzU00zOWZQbXE2QXpCK0srSVBD?=
 =?utf-8?B?SEozOHNHb1FCaGNzVWV6SGprM1pURjg2NEpka3RVUHRZLzNFVG1kR1hiV1hp?=
 =?utf-8?B?SHpUNWhpaTVxVHhWMGhnUG5IaUpRVGt5ekFGeXpQQnhxN1ZLcXd0a0F1ZWZo?=
 =?utf-8?B?bmlLZDFwaFg2bnJhRnk3QXoyc1hvb1Avd0RCeEt2VVpCWEZzc0cvQU16WkZr?=
 =?utf-8?B?cGpIeHhwV282NTNUYm5RTWFNUDNCUkc4MFZORlUzbzBLMUhxU0pLeGlubUZU?=
 =?utf-8?B?SytrN2p3bUNGTktiVnovak16MWZzdytiekF4aW82Vlo1QTdHMGt1cW41a2wr?=
 =?utf-8?B?dVFraE04b2VVZWRVK1dQZU0rYUVMdSt2RVJJQ2NCZ0svdzl5RGhXTnBxdGZm?=
 =?utf-8?B?WUY1U2JDRmxnWlN1OWo4MG1DS0p6OGhLeUZKOTFWbjB0dDNIZm0rVjM4blRT?=
 =?utf-8?B?WXBKenRBL1hEVHZTWXpVUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3MvQWlKb3RUOGZiUGplRnRvbXJhdEEzU0FuYWlYM2p4QkJXMURENXRLaGpF?=
 =?utf-8?B?YnFSVWNNNHB6U096Y3BKNlM4WWtNZzhTUjdtY1JiY3lRbnZXaDlrUGZnaVYz?=
 =?utf-8?B?MzhzaEtUYWtTWUtJa0VsOHVTMjNSTXlzWFdVZERqTGJ0UG1sYUo5RnBpMUtx?=
 =?utf-8?B?dktHTDF0NUhDbG00bWFmdmk3U01RUU1ZN3pBV04yNzIzWmtXeFBPRlZ2YU9S?=
 =?utf-8?B?WDB5MXIxQ3o5b3ZvbGExdFZ2bWdOSVdLeHZCMGxuOElyU1I4cHRLMklTKzJi?=
 =?utf-8?B?N2NjaVlLZTI3MkxYYW1qRVQxZEVYU1E0TkkvVlVhUjZhT1dGRi93TU9WSTVl?=
 =?utf-8?B?ZWhqcGJqWEFEU1U2SUtRM3Fxb1pGcE9wb1JWTEE0NXdBU1NFNmRXK25UT0x4?=
 =?utf-8?B?T0d2YTlSOXZIV1ZQVC82SUtTWUY0VVhkdnhDVXlHUFFYVFZDaVZxOVhEc200?=
 =?utf-8?B?RzZISnFtZG9hd3E4UDdZa245ZnhZNGdYaWYyeVZTUjNtNVJISi9hWGVNeWJs?=
 =?utf-8?B?bzFZQlcwMGpCMEc3RHplVDhXVVowNFFpdGxkMGNPNmtoUHNOMGoyeXBhVFVN?=
 =?utf-8?B?M3BoNFU5dVJBOHBGQnY2MFdvdThQMnFsWEJjbS9vdWtGeFdSdW9aOWFnTnpH?=
 =?utf-8?B?dWpTZnZFSStXQzA1b1hMK21yZnF1bTVON2hERjZYQmRxUm5uQ2g4UnNjeUdT?=
 =?utf-8?B?TDFtdlNEc2Mxckp0YWMwSVBnRjJQQ08xeFFmRDMzN2NORHVCdUV5bEtwZ1F4?=
 =?utf-8?B?QnE3VzFqOENVdjF3c1hpQjlMUjVRVVpWVTVwcFB6NWJYR05mN2p5V29HRnpY?=
 =?utf-8?B?cUVoOVltNmNEcjZ6VnVRcXY5L3hJQ2l2NGY2N3prOEJkMEk3bngvZ3lvN3RT?=
 =?utf-8?B?ZlQyR2V6SklrMm1WbHN6bzVjUXcrT0ZvQXVxTzJMSG5GMDJ5UnZEdjk3NVpv?=
 =?utf-8?B?S2ZVN3VDZVhxVTRsc2pWUzdsY0F5c0NIc1gybGVFUW0wa0VmV0V0ZjBMQzJr?=
 =?utf-8?B?MGx6NXNKQVJ4MXVkTmdRYldkem5OeEl4bVFOSzhzOHZIQ1RXeXNvQlBBaFVC?=
 =?utf-8?B?aDRrdU9MQlVTeEtVOEF3OENvckdmVEg2N3dBZGk1ZnVsV3A1dHpQc3NZWi9m?=
 =?utf-8?B?TWwxOWN1RWZFNkJvRklMeUpDMkNPOTlZOEsyZWhNV0dRdTVrMDRVWjBCV1dL?=
 =?utf-8?B?c00wTTlDbHVoMUwxbVhkTU9NK29aRHFZRDRXSE1RQUlWL2NaL2ZMbHVaa2hv?=
 =?utf-8?B?ekVha0hDdnJ5eHpRSnNwY1FyU0d1dUpveHpHTGpGYTZjcVRUNjQ0bHA1TFdn?=
 =?utf-8?B?SGFtenJBQ1NtMEducEU3QzNnSy9BMC9wangrcVA5NDVjTW1XekwycTVCSVlX?=
 =?utf-8?B?b1lOaGs1aVE1VXBJQW02dHNzcFNVS0tqMk9NZzJRQkp0NTl0czY5eGZSSG11?=
 =?utf-8?B?UE9oMURVVzV5WTkvTmFYc3BWaXRyWEZzRnFBdDNWQnJHYThlQlE0TEhrbDA4?=
 =?utf-8?B?bmoyMmJNZG83aVF6R08rT3RiYXAvYkJ6REZUcEh5Y05ncUNLK2J6WS83U1Vo?=
 =?utf-8?B?a3lpRE10V1pvVUNWMVdLai8wZGgzWFd2YzFqOUw3RTR6U2p1cHpwbzI1SWRG?=
 =?utf-8?B?aWVTMS9rN0lyVndUakRnSkNLaGhqRGJKWFpMWUJJaFNDYkVsbjl0RUk0Snpm?=
 =?utf-8?B?WUl2ak5SMHQ3czV0Z09uRmhtYiswcTh0TGxMTFBLSGQrWHozdVBpOXJjbkNq?=
 =?utf-8?B?R3VVK0tCYWwzTndBb1d6cWlIZmY2WUlRNnZ0KzY5WU1weXQ0NlFHTllvTUlx?=
 =?utf-8?B?bkNWZDlYRWRVRDNndzF6YXUwWmxOV0E3dDdBMyt4VUFIWWJwMWdEN3U3OU0r?=
 =?utf-8?B?dmtsYStRcFJVYTc0WTF4RDlHUGRNSCtNT3NGWnpYWldOY3JZVnA0THVidlJY?=
 =?utf-8?B?cUZlV1dUU2JhbU04YXd5ZWZyeUVkVU84REp0cFdnTFpKS2UxbVBVWklKVE9P?=
 =?utf-8?B?RzFVRmVJRUhpTVRKMVNmbFpDcXJOSTFUY3FPMlk5YW45QXlUVWxidzQ5ZlNQ?=
 =?utf-8?B?ekhWZjEvT2dVMFpIL01OdHpuTE8vS2hvNjNLZzd4Z2JlMURGQUJnOHBJdVpZ?=
 =?utf-8?Q?8c9xQBUeXaqW+vVDG9yGVGQgZ?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a92eab-1768-43c1-d7eb-08dca7d20614
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 09:06:06.7816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRcS/ljWEESlHKERAj1P61TzmJZNKDKOpd+zQkcnmFHUCj1QcBDENGyXUEpSnuwtaKancn6sYce+W/8TF1I6Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6924

Dear Sai and Luiz

Thanks for the review.

On 2024/7/19 3:01, Luiz Augusto von Dentz wrote:
> Hi Sai,
>
> On Thu, Jul 18, 2024 at 2:43 PM Sai Krishna Gajula
> <saikrishnag@marvell.com> wrote:
>>
>>> -----Original Message-----
>>> From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
>>> Sent: Thursday, July 18, 2024 1:12 PM
>>> To: Marcel Holtmann <marcel@holtmann.org>; Luiz Augusto von Dentz
>>> <luiz.dentz@gmail.com>; David S. Miller <davem@davemloft.net>; Eric
>>> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
>>> Abeni <pabeni@redhat.com>; Rob Herring <robh@kernel.org>; Krzysztof
>>> Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>;
>>> Catalin Marinas <catalin.marinas@arm.com>; Will Deacon <will@kernel.org>
>>> Cc: linux-bluetooth@vger.kernel.org; netdev@vger.kernel.org;
>>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
>>> kernel@lists.infradead.org; Yang Li <yang.li@amlogic.com>; Ye He
>>> <ye.he@amlogic.com>
>>> Subject: [PATCH v2 2/3] Bluetooth: hci_uart: Add support for
>>> Amlogic HCI UART
>>>
>>> From: Yang Li <yang. li@ amlogic. com> This patch introduces support for
>>> Amlogic Bluetooth controller over UART. In order to send the final firmware at
>>> full speed. It is a pretty straight forward H4 driver with exception of actually
>>> having
>>> From: Yang Li <yang.li@amlogic.com>
>>>
>>> This patch introduces support for Amlogic Bluetooth controller over UART. In
>>> order to send the final firmware at full speed. It is a pretty straight forward H4
>>> driver with exception of actually having it's own setup address configuration.
>>>
>>> Co-developed-by: Ye He <ye.he@amlogic.com>
>>> Signed-off-by: Ye He <ye.he@amlogic.com>
>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>>> ---
>>>   drivers/bluetooth/Kconfig     |  12 +
>>>   drivers/bluetooth/Makefile    |   1 +
>>>   drivers/bluetooth/hci_aml.c   | 772
>>> ++++++++++++++++++++++++++++++++++++++++++
>>>   drivers/bluetooth/hci_ldisc.c |   8 +-
>>>   drivers/bluetooth/hci_uart.h  |   8 +-
>>>   5 files changed, 798 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig index
>>> 90a94a111e67..d9ff7a64d032 100644
>>> --- a/drivers/bluetooth/Kconfig
>>> +++ b/drivers/bluetooth/Kconfig
>>> @@ -274,6 +274,18 @@ config BT_HCIUART_MRVL
>>>
>>>          Say Y here to compile support for HCI MRVL protocol.
>>>
>>> +config BT_HCIUART_AML
>>> +     bool "Amlogic protocol support"
>>> +     depends on BT_HCIUART
>>> +     depends on BT_HCIUART_SERDEV
>>> +     select BT_HCIUART_H4
>>> +     select FW_LOADER
>>> +     help
>>> +       The Amlogic protocol support enables Bluetooth HCI over serial
>>> +       port interface for Amlogic Bluetooth controllers.
>>> +
>>> +       Say Y here to compile support for HCI AML protocol.
>>> +
>>>   config BT_HCIBCM203X
>>>        tristate "HCI BCM203x USB driver"
>>>        depends on USB
>>> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile index
>>> 0730d6684d1a..81856512ddd0 100644
>>> --- a/drivers/bluetooth/Makefile
>>> +++ b/drivers/bluetooth/Makefile
>>> @@ -51,4 +51,5 @@ hci_uart-$(CONFIG_BT_HCIUART_BCM)   += hci_bcm.o
>>>   hci_uart-$(CONFIG_BT_HCIUART_QCA)    += hci_qca.o
>>>   hci_uart-$(CONFIG_BT_HCIUART_AG6XX)  += hci_ag6xx.o
>>>   hci_uart-$(CONFIG_BT_HCIUART_MRVL)   += hci_mrvl.o
>>> +hci_uart-$(CONFIG_BT_HCIUART_AML)    += hci_aml.o
>>>   hci_uart-objs                                := $(hci_uart-y)
>>> diff --git a/drivers/bluetooth/hci_aml.c b/drivers/bluetooth/hci_aml.c new file
>>> mode 100644 index 000000000000..575b6361dad6
>>> --- /dev/null
>>> +++ b/drivers/bluetooth/hci_aml.c
>>> @@ -0,0 +1,772 @@
>>> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
>>> +/*
>>> + * Copyright (C) 2024 Amlogic, Inc. All rights reserved  */
>>> +
>>> +#include <linux/kernel.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/device.h>
>>> +#include <linux/property.h>
>> ......
>>
>>> + * op_code |      op_len           | op_addr | parameter   |
>>> + * --------|-----------------------|---------|-------------|
>>> + *   2B    | 1B len(addr+param)    |    4B   |  len(param) |
>>> + */
>>> +static int aml_send_tci_cmd(struct hci_dev *hdev, u16 op_code, u32
>>> op_addr,
>>> +                         u32 *param, u32 param_len)
>>> +{
>>> +     struct sk_buff *skb = NULL;
>>> +     struct aml_tci_rsp *rsp = NULL;
>>> +     u8 *buf = NULL;
>>> +     u32 buf_len = 0;
>>> +     int err = 0;
>> Please consider using reverse xmas tree order - longest line to shortest - for local variable declarations in Networking code.
> First time I'm hearing about this, is that just for the sake of readability?
well, for the sake of readability.
>
>>> +
>>> +     buf_len = sizeof(op_addr) + param_len;
>>> +     buf = kmalloc(buf_len, GFP_KERNEL);
>>> +     if (!buf) {
>>> +             err = -ENOMEM;
>>> +             goto exit;
>>> +     }
>>> +
>>> +     memcpy(buf, &op_addr, sizeof(op_addr));
>>> +     if (param && param_len > 0)
>>> +             memcpy(buf + sizeof(op_addr), param, param_len);
>>> +
>>> +     skb = __hci_cmd_sync_ev(hdev, op_code, buf_len, buf,
>>> +                             HCI_EV_CMD_COMPLETE,
>>> HCI_INIT_TIMEOUT);
>>> +     if (IS_ERR(skb)) {
>>> +             err = PTR_ERR(skb);
>>> +             skb = NULL;
>> Better to capture the error before nullifying skb, like below
>>          err = PTR_ERR(skb);
>>          skb = NULL;  // Nullify after capturing the error
> That is exactly what he is doing, and actually it seems to only be
> doing that because it later calls kfree_skb.

Yes, it is right, but there is another issue that it setting skb to NULL 
before kfree_skb(skb)

causes memory leaks, and I will delete "skb = NULL;"

>>> +             bt_dev_err(hdev, "Failed to send TCI cmd:(%d)", err);
>>> +             goto exit;
>>> +     }
>>> +
>>> +     rsp = (struct aml_tci_rsp *)(skb->data);
> This code is not safe, you need to check if skb->len because trying to
> access skb->data, anyway you are probably much better off using
> skb_pull_data instead.
well, I got it.
>
>>> +     if (rsp->opcode != op_code || rsp->status != 0x00) {
>>> +             bt_dev_err(hdev, "send TCI cmd(0x%04X),
>>> response(0x%04X):(%d)",
>>> +                    op_code, rsp->opcode, rsp->status);
>>> +             err = -EINVAL;
>>> +             goto exit;
>>> +     }
>>> +
>>> +exit:
>>> +     kfree(buf);
>>> +     kfree_skb(skb);
>>> +     return err;
>>> +}
>>> +
>>> +static int aml_update_chip_baudrate(struct hci_dev *hdev, u32 baud) {
>>> +     u32 value;
>>> +
>>> +     value = ((AML_UART_CLK_SOURCE / baud) - 1) & 0x0FFF;
>>> +     value |= AML_UART_XMIT_EN | AML_UART_RECV_EN |
>>> +AML_UART_TIMEOUT_INT_EN;
>>> +
>>> +     return aml_send_tci_cmd(hdev, AML_TCI_CMD_UPDATE_BAUDRATE,
>>> +                               AML_OP_UART_MODE, &value,
>>> sizeof(value)); }
>>> +
>>> +static int aml_start_chip(struct hci_dev *hdev) {
>>> +     u32 value = 0;
>>> +     int ret;
>>> +
>>> +     value = AML_MM_CTR_HARD_TRAS_EN;
>>> +     ret = aml_send_tci_cmd(hdev, AML_TCI_CMD_WRITE,
>>> +                            AML_OP_MEM_HARD_TRANS_EN,
>>> +                            &value, sizeof(value));
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     /* controller hardware reset. */
>>> +     value = AML_CTR_CPU_RESET | AML_CTR_MAC_RESET |
>>> AML_CTR_PHY_RESET;
>>> +     ret = aml_send_tci_cmd(hdev, AML_TCI_CMD_HARDWARE_RESET,
>>> +                            AML_OP_HARDWARE_RST,
>>> +                            &value, sizeof(value));
>>> +     return ret;
>>> +}
>>> +
>>> +static int aml_send_firmware_segment(struct hci_dev *hdev,
>>> +                                  u8 fw_type,
>>> +                                  u8 *seg,
>>> +                                  u32 seg_size,
>>> +                                  u32 offset)
>>> +{
>>> +     u32 op_addr = 0;
>>> +
>>> +     if (fw_type == FW_ICCM)
>>> +             op_addr = AML_OP_ICCM_RAM_BASE  + offset;
>>> +     else if (fw_type == FW_DCCM)
>>> +             op_addr = AML_OP_DCCM_RAM_BASE + offset;
>>> +
>>> +     return aml_send_tci_cmd(hdev, AML_TCI_CMD_DOWNLOAD_BT_FW,
>>> +                          op_addr, (u32 *)seg, seg_size); }
>>> +
>>> +static int aml_send_firmware(struct hci_dev *hdev, u8 fw_type,
>>> +                          u8 *fw, u32 fw_size, u32 offset) {
>>> +     u32 seg_size = 0;
>>> +     u32 seg_off = 0;
>>> +
>>> +     if (fw_size > AML_FIRMWARE_MAX_SIZE) {
>>> +             bt_dev_err(hdev, "fw_size error, fw_size:%d, max_size: 512K",
>>> +                    fw_size);
>>> +             return -EINVAL;
>>> +     }
>>> +     while (fw_size > 0) {
>>> +             seg_size = (fw_size > AML_FIRMWARE_OPERATION_SIZE) ?
>>> +                        AML_FIRMWARE_OPERATION_SIZE : fw_size;
>>> +             if (aml_send_firmware_segment(hdev, fw_type, (fw +
>>> seg_off),
>>> +                                           seg_size, offset)) {
>>> +                     bt_dev_err(hdev, "Failed send firmware, type:%d,
>>> offset:0x%x",
>>> +                            fw_type, offset);
>>> +                     return -EINVAL;
>>> +             }
>>> +             seg_off += seg_size;
>>> +             fw_size -= seg_size;
>>> +             offset += seg_size;
>>> +     }
>>> +     return 0;
>>> +}
>>> +
>>> +static int aml_download_firmware(struct hci_dev *hdev, const char
>>> +*fw_name) {
>>> +     struct hci_uart *hu = hci_get_drvdata(hdev);
>>> +     struct aml_serdev *amldev = serdev_device_get_drvdata(hu-
>>>> serdev);
>>> +     const struct firmware *firmware = NULL;
>>> +     struct aml_fw_len *fw_len = NULL;
>>> +     u8 *iccm_start = NULL, *dccm_start = NULL;
>>> +     u32 iccm_len, dccm_len;
>>> +     u32 value = 0;
>>> +     int ret = 0;
>>> +
>> Please consider using reverse xmas tree order - longest line to shortest - for local variable declarations in Networking code.
Okay, I will do.
>>
>>> +     /* Enable firmware download event. */
>>> +     value = AML_EVT_EN;
>>> +     ret = aml_send_tci_cmd(hdev, AML_TCI_CMD_WRITE,
>>> +                            AML_OP_EVT_ENABLE,
>>> +                            &value, sizeof(value));
>>> +     if (ret)
>>> +             goto exit;
>>> +
>>> +     /* RAM power on */
>>> +     value = AML_RAM_POWER_ON;
>>> +     ret = aml_send_tci_cmd(hdev, AML_TCI_CMD_WRITE,
>>> +                            AML_OP_RAM_POWER_CTR,
>>> +                            &value, sizeof(value));
>>> +     if (ret)
>>> +             goto exit;
>>> +
>>> +     /* Check RAM power status */
>>> +     ret = aml_send_tci_cmd(hdev, AML_TCI_CMD_READ,
>>> +                            AML_OP_RAM_POWER_CTR, NULL, 0);
>>> +     if (ret)
>>> +             goto exit;
>>> +
>>> +     ret = request_firmware(&firmware, fw_name, &hdev->dev);
>>> +     if (ret < 0) {
>>> +             bt_dev_err(hdev, "Failed to load <%s>:(%d)", fw_name, ret);
>>> +             goto exit;
>>> +     }
>>> +
>>> +     fw_len = (struct aml_fw_len *)firmware->data;
>>> +
>>> +     /* Download ICCM */
>>> +     iccm_start = (u8 *)(firmware->data) + sizeof(struct aml_fw_len)
>>> +                     + amldev->aml_dev_data->iccm_offset;
>>> +     iccm_len = fw_len->iccm_len - amldev->aml_dev_data->iccm_offset;
>>> +     ret = aml_send_firmware(hdev, FW_ICCM, iccm_start, iccm_len,
>>> +                             amldev->aml_dev_data->iccm_offset);
>>> +     if (ret) {
>>> +             bt_dev_err(hdev, "Failed to send FW_ICCM (%d)", ret);
>>> +             goto exit;
>>> +     }
>>> +
>>> +     /* Download DCCM */
>>> +     dccm_start = (u8 *)(firmware->data) + sizeof(struct aml_fw_len) +
>>> fw_len->iccm_len;
>>> +     dccm_len = fw_len->dccm_len;
>>> +     ret = aml_send_firmware(hdev, FW_DCCM, dccm_start, dccm_len,
>>> +                             amldev->aml_dev_data->dccm_offset);
>>> +     if (ret) {
>>> +             bt_dev_err(hdev, "Failed to send FW_DCCM (%d)", ret);
>>> +             goto exit;
>>> +     }
>>> +
>>> +     /* Disable firmware download event. */
>>> +     value = 0;
>>> +     ret = aml_send_tci_cmd(hdev, AML_TCI_CMD_WRITE,
>>> +                            AML_OP_EVT_ENABLE,
>>> +                            &value, sizeof(value));
>>> +     if (ret)
>>> +             goto exit;
>>> +
>>> +exit:
>>> +     if (firmware)
>>> +             release_firmware(firmware);
>>> +     return ret;
>>> +}
>>> +
>>> +static int aml_send_reset(struct hci_dev *hdev) {
>>> +     struct sk_buff *skb;
>>> +     int err;
>>> +
>>> +     skb = __hci_cmd_sync_ev(hdev, HCI_OP_RESET, 0, NULL,
>>> +                             HCI_EV_CMD_COMPLETE,
>>> HCI_INIT_TIMEOUT);
>>> +     if (IS_ERR(skb)) {
>>> +             err = PTR_ERR(skb);
>>> +             bt_dev_err(hdev, "Failed to send hci reset cmd(%d)", err);
>>> +             return err;
>>> +     }
>>> +
>>> +     kfree_skb(skb);
>>> +     return 0;
>>> +}
>>> +
>>> +static int aml_dump_fw_version(struct hci_dev *hdev) {
>>> +     struct sk_buff *skb;
>>> +     struct aml_tci_rsp *rsp = NULL;
>>> +     u8 value[6] = {0};
>>> +     u8 *fw_ver = NULL;
>>> +     int err = 0;
>>> +
>> Please consider using reverse xmas tree order - longest line to shortest - for local variable declarations in Networking code.
Okay, I will do.
>>> +     skb = __hci_cmd_sync_ev(hdev, AML_BT_HCI_VENDOR_CMD,
>>> sizeof(value), value,
>>> +                             HCI_EV_CMD_COMPLETE,
>>> HCI_INIT_TIMEOUT);
>>> +     if (IS_ERR(skb)) {
>>> +             skb = NULL;
>>> +             err = PTR_ERR(skb);
>>> +             bt_dev_err(hdev, "Failed get fw version:(%d)", err);
>>> +             goto exit;
>>> +     }
>>> +
>>> +     rsp = (struct aml_tci_rsp *)(skb->data);
>>> +     if (rsp->opcode != AML_BT_HCI_VENDOR_CMD || rsp->status !=
>>> 0x00) {
>>> +             bt_dev_err(hdev, "dump version, error response
>>> (0x%04X):(%d)",
>>> +                    rsp->opcode, rsp->status);
>>> +             err = -EINVAL;
>>> +             goto exit;
>>> +     }
>>> +
>>> +     fw_ver = skb->data + AML_EVT_HEAD_SIZE;
>>> +     bt_dev_info(hdev, "fw_version: date = %02x.%02x, number =
>>> 0x%02x%02x",
>>> +             *(fw_ver + 1), *fw_ver, *(fw_ver + 3), *(fw_ver + 2));
>>> +
>>> +exit:
>>> +     kfree_skb(skb);
>>> +     return err;
>>> +}
>>> +
>>> +static int aml_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
>>> +{
>>> +     struct sk_buff *skb;
>>> +     struct aml_tci_rsp *rsp = NULL;
>>> +     int err = 0;
>>> +
>> Please consider using reverse xmas tree order - longest line to shortest - for local variable declarations in Networking code.
Okay, I will do.
>>> +     bt_dev_info(hdev, "set bdaddr (%pM)", bdaddr);
>>> +     skb = __hci_cmd_sync_ev(hdev, AML_BT_HCI_VENDOR_CMD,
>>> +                             sizeof(bdaddr_t), bdaddr,
>>> +                             HCI_EV_CMD_COMPLETE,
>>> HCI_INIT_TIMEOUT);
>>> +     if (IS_ERR(skb)) {
>>> +             skb = NULL;
>>> +             err = PTR_ERR(skb);
>> Same here to capture error before making skb null.
> Ok, this is really the wrong order and will overwrite the error, that
> said replacing goto exit with return PTR_ERR(skb) would be enough here
> since there is nothing else that needs to be cleanup.
Well, I got it.
>
>>> +             bt_dev_err(hdev, "Failed to set bdaddr:(%d)", err);
>>> +             goto exit;
>>> +     }
>>> +
>>> +     rsp = (struct aml_tci_rsp *)(skb->data);
>>> +     if (rsp->opcode != AML_BT_HCI_VENDOR_CMD || rsp->status !=
>>> 0x00) {
>>> +             bt_dev_err(hdev, "error response (0x%x):(%d)", rsp->opcode,
>>> rsp->status);
>>> +             err = -EINVAL;
>>> +             goto exit;
>>> +     }
>>> +
>>> +exit:
>>> +     kfree_skb(skb);
>>> +     return err;
>>> +}
>>> +
>>> +static int aml_check_bdaddr(struct hci_dev *hdev) {
>> .......
>>
>>> +
>>> +static int aml_close(struct hci_uart *hu) {
>>> +     struct aml_data *aml_data = hu->priv;
>>> +     struct aml_serdev *amldev = serdev_device_get_drvdata(hu-
>>>> serdev);
>> Please consider using reverse xmas tree order - longest line to shortest - for local variable declarations in Networking code.
Okay, I got it.
>>
>>> +
>>> +     if (hu->serdev)
>>> +             serdev_device_close(hu->serdev);
>>> +
>>> +     skb_queue_purge(&aml_data->txq);
>>> +     kfree_skb(aml_data->rx_skb);
>>> +     kfree(aml_data);
>>> +
>>> +     hu->priv = NULL;
>>> +
>>> +     return aml_power_off(amldev);
>>> +}
>> .......
>>
>
> --
> Luiz Augusto von Dentz

