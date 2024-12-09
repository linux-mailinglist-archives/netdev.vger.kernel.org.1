Return-Path: <netdev+bounces-150098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7619E8E60
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 10:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E919161F75
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 09:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078B11C1F31;
	Mon,  9 Dec 2024 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zve197ZG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC1A14A4DD;
	Mon,  9 Dec 2024 09:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733735267; cv=fail; b=XY5fkK6Xl7eCT91ij42hzxM0mAM3JYeyOdX4vEz2Kr4+YvPfqpTt4ehC+KO137HWN9sMH+/5P4sQiHr+gJ1QczCtoJIpVcJYgDwZ4KYA7tLIaJ5/1muEexeYOA4mw6tEfYSKGwJ+Pp/yO11WAr2+DArJ2HH6OW1HlyHi8dIHBFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733735267; c=relaxed/simple;
	bh=fROXCXD40ZCpxDUT2h/BGRdhJk5PpaSaLa2tlkmSfEE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hyg3SS2llZkwrKmcwoBgdPj/yD1FQ0MdKiRO+aORrhKMigrjLr8wMVhpaqNAwdqxiXVKeG2yL1LOyI6+T/jtoOKPPhdvxE1qoYlNXa6s/HdAM8z1RsR8A28nCrcqu7gCBjOfWqsGoxur5NNMAav/0qoXe0clnWO8W8l/T4O4kuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zve197ZG; arc=fail smtp.client-ip=40.107.96.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNA+4Z1h+YEE7SU/uaXbLIAh3qk22cp+98Di4j8Enffg7jgjYKttIIaVxs8yv139HKfCOyLscDt59FjhBQ2Cq6pY3XDSvZz/M1sCdjwqBLmssb1mWCp6dpCM8QKEm3OFQb4Xcp10MMP0udWpGq+2+W2DKGO05dHFEgxzdIqpt4T3V+UMWPBGGKT9KZKoE0tAYvaPWK8z8+YB8O982bL95BlntUtkv+2QTo6EefpzWRWH553byeK+rIbRiTWl7N3PxiovI34VAEQXr9ChLZP6Ms+HD6M9vXqONuhpN3CLk/+OIfAM1HN2LIi3W1jtgjyivyH+2m+W2cwPpJasDR2g/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBotfjL3B+kCpcZSCHxeQDcc5Jas9+GqlCHspGnXFyQ=;
 b=ZfOK2QB6LN+PkQnp1qEScfs7wtiLCz9ue5x7O3g4ajaTMdvcptfanNb+H6vLX0yKJu5AVcCUdz/S7B1gukIbOOS8RuHlQE5XMsVtb40VVwp6tvajaKgXS1Wdlw0yQgKMDEher4Q3+Syr1gsS/sled+nupy37l7PHLUjS+M92nImm24NRCft0NsLBv/SjO1QWa2wvcpCo9Eu6Hstif4nyg65KBLudj54xHytZL9bab3A0AKaGY/5sgJsomuax3a9/usVp2C3cngGynBbg31EK1jpxb9Y7nroMEhrfAt7/cdME7SfU9LM/Gar5xrd7dST0fblh+krF4WT2n1/VgTz3nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBotfjL3B+kCpcZSCHxeQDcc5Jas9+GqlCHspGnXFyQ=;
 b=zve197ZGvhOx8/gq1sJRf9nN1uKTbBz0bj6se//JHdDQXwb0Zj+5I+5RiA9scCcCZReO4y3vwN2WYQmKKHJXjOeGwulC9NrLXcR54bM+jNSbPT8E1CLH4cyVeqLOhfH6QHBNH47Z6y+wMEsuOz5yQPS5TAlIB/W4oeuCgXBdil4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB8235.namprd12.prod.outlook.com (2603:10b6:610:120::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 09:07:43 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 09:07:43 +0000
Message-ID: <a7782f8b-30a1-97cf-8bf3-707d5b4f0984@amd.com>
Date: Mon, 9 Dec 2024 09:07:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 08/28] cxl: add functions for resource request/release
 by a driver
Content-Language: en-US
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-9-alejandro.lucero-palau@amd.com>
 <CAH-L+nNxO2NHG07JOqUnmWLNhVYRKJOHsAN7uiEnAibBTmaATQ@mail.gmail.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <CAH-L+nNxO2NHG07JOqUnmWLNhVYRKJOHsAN7uiEnAibBTmaATQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P189CA0046.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::21) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB8235:EE_
X-MS-Office365-Filtering-Correlation-Id: 4103c001-7480-43f0-b0fe-08dd1830f079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yzh5VDVySTh3OEpvdnFpazFzeU1aTWpsSW4xUUpzVHNTanY3MmFURFZaeUlY?=
 =?utf-8?B?ODExdktuUzJlbUw0RFg4dDgwRzZvK20rRC9aTHg4cW9NS0xyUTRjeVJxK3k5?=
 =?utf-8?B?M0t5b0tocXBjdFUzQmhhczJERGlWNDRLTmNDT3psODV3THltaWxPcTlMRnI4?=
 =?utf-8?B?V1FLSEEyVm5oWGhBN05NSXNZUzRRZExLY3pzYTk2WXd6QStxWFEzN2lvMTds?=
 =?utf-8?B?OXF0V21CbWNQK1hKT1JvVUhIajd6bTJ0U2xKZlZnc1p1TlIwQVFIcnZmSk1T?=
 =?utf-8?B?d0JjRjZpNXFPdzM4cWhFYnB6NmlzUlJJT0RQUFpVbEtrK3hTSFVKV1VVdnBW?=
 =?utf-8?B?SWxsb2pjY1BIYW9pRndocUtiSDdIYytaRXJjR3lqbkJPTGxQZlFJRUVTWVoy?=
 =?utf-8?B?WDIveUgvOG5BUGJOWHhnNXJ6dC9oZkprb3lvRVJtVTlJbFFXYkNRcmNzRktX?=
 =?utf-8?B?UzVkRkZpcHlpa2xBS2xsSU5pVktzZEJXWUpPYjlDWEJFVi9Ma2gycFdabk1R?=
 =?utf-8?B?MkVXNDhodXNuVnpVMXNUa2dvVGNWOWRCdVFGazA2Slc4RmZtdjVUWFZFSStQ?=
 =?utf-8?B?Z1NZTWc0eXAxMTZ1UWxKbFFIN1Nlb2M4TGhiakZNcnNKekQrUjBmNjZjMU4x?=
 =?utf-8?B?UXdsWEpvK01UZmhTZ3V6eWlTdC84UzRsOEJxS0VHRnpqbUhxVEEzZjB3aHo2?=
 =?utf-8?B?WmI2T0dNY1d3Z2RCUFdFMXNDUVpGbUpRSCtrUmYxMGpJSlBWdks0STFmeHlG?=
 =?utf-8?B?RDdHZ0pxWFhjT2RZVkhSbTZsbkx4UDM0R0JESTBWY3gxOVFlSm1INEpjSE83?=
 =?utf-8?B?dTZES3VqUUZMc0FsMXFyTjZSZTY3UjNEUkxwb2ZVY2FuZFhJSHB3dkJLUlVT?=
 =?utf-8?B?TFNLSVdwdVBYNGc0VzZFVUNBblVPeWsxdFN4K0VlYTd0ems1WWhWOTZrKzVp?=
 =?utf-8?B?aWtvZ0NpQXlEdmpzK2wyTXAzZnpFOUU4UWhwVDBJd0F2NVVkNjBVRC9sK3FI?=
 =?utf-8?B?U3ZwVHNTdUU4cTBpcTR1ZXZyVUNBSHgvelArTFBad2pvL1psejNZRzRPK1By?=
 =?utf-8?B?K0hGQklxZDdGMVJyUzVrbFNpR2JyS1ZLYXdpMnhpVmQvMno5KzR2bEZiMll4?=
 =?utf-8?B?Smw2YTVZTmlSWHE2Z1VCcTBkUi94enNWY2NUR280Tm9ibWxlaGo3V2lKdGVV?=
 =?utf-8?B?dEpReHdyS2JTcEpmei85MHE5MzQzbFZieUpLa1BtOXpYWlAxQW8xOVNUWEpD?=
 =?utf-8?B?MmZqV0RDbjU0UzhJbHp6ekJuSmVWblVPc0dNeDdpNTExNXMxaTkzMFdTam5B?=
 =?utf-8?B?YmhwMCt5dW5kMWJSb1Z3U3lpSkRiZnA1YVVNSnB5Y0VRMFl1S3YwVkJIV09Y?=
 =?utf-8?B?bHl0YzRpb3kva0E1V2d6ZktkOUozOFQ0YWZPTERDQ1YyQ3BmelUzTzEvSDF3?=
 =?utf-8?B?RUtNN0VQRTR2MnJJVHZEcGhJVVU0Nm55Q24wVmpMS3hJWFYrTEdyNjg3eGFJ?=
 =?utf-8?B?UzAvQ09XTDdJcEVobkoxaldVeUw5azhCemhwM05zQVhNM2ordnI0WjZ1K1FB?=
 =?utf-8?B?RXJnYW9POW92eERnbkwzaldwcS9sYkppV2cxaWtKSjdaSC9BaGV4K3Z6Y05M?=
 =?utf-8?B?KzhMc3R4bzRxYTh4ejhEUnNsWlU5Vmk2R01aL3k0QVlKR2hJcjRqVFAwUzda?=
 =?utf-8?B?dURlTWR0b2gwUEtOeWM2U1JIL2RCZDdUemIxeDZ4T29vR3luZndiZytxUHJ3?=
 =?utf-8?B?Q0RGR3ZzS2ZnTG83MlhHSGpZb2lYcFpRL1FpT3gxUm85OHRydm9Jbk9QemY5?=
 =?utf-8?B?eEF3SUZ4ak9xNkNVVmlRUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTROWjRDbWl6clk3eGE4YU54YWpQOTR0ZVNMamxpV0Z4ZUllVXgzTWp2KzRp?=
 =?utf-8?B?ZDVNRmJGMytNR0dDZ3NoOHZvNHR5L3Rsc2JjeUk4N3E5WU5kS3pQRjhxNXVD?=
 =?utf-8?B?MU1iQWVSY2FpWkJWZDZLdy94VXRWUGRUN3J2TGloSTRGV3IyUzBtTklNTitl?=
 =?utf-8?B?bmdGOHhPa2E1SHVqL0dCczlkbGYxR1M3S0VYdE9iWWgvc1o2MDlMK2tGSWpi?=
 =?utf-8?B?ODhDc2R4ekNGZWU1dUplNXpETHpJa0Mwd3pJcyswYlpJM094MGs3Mk9TMWFu?=
 =?utf-8?B?dmNYUVdWbUI4TFdCK1VlaURiWFVlM3lMWGRUT1hBczkvK3BuQW5ITDYrVU9G?=
 =?utf-8?B?V054anBXaUJQbUNLaDRmTy9Lb0JDckc1T0I1RlY0UU9LZjkzUWdzZGZJdXpn?=
 =?utf-8?B?NmJEeEZwQU1oWUIrUlZxZ0Q2ZWxoOWt6MzZHNFVDZzBiUTREcHZmKzdma1VZ?=
 =?utf-8?B?UWk4VmN2NXl4V2NZcTdVVzJBd3JzUzhoTzlsS2dhZ29pV3N1ZWJjbGoxcXFS?=
 =?utf-8?B?WnE1aFdSdzRGVUFIOHYzQ2ZiTHVsQXkwbzZGN0FmQWI5bUtzS2tPU1VoaWcz?=
 =?utf-8?B?cHhqWUNFSjRqY0FObTNJUEhYZ2l1eDZpVkZrSm1ZWHFMQ2FLUU9VSFgwbFda?=
 =?utf-8?B?QitaZ1RLYzZaM1puZG5ENHlvektXVlF6YlJoaFVUNlh6bkFPVnEvclBBQ0xT?=
 =?utf-8?B?WndZZzlqaEFZYldoMFh3eGpOWFBpdGFYblhTdVkrdWR3VjdFRUJNVU1Xam92?=
 =?utf-8?B?QStWRGVzV2VXK09Odmw3U1psSzBZSk5LV1AwanhGSklpU0NNQW90aUpyRG1u?=
 =?utf-8?B?dFFCdGkvL0x3cXNXVVpwbkQzT3lYTmRTcXpPZTVvRkxBYVM2cjdEaEVtMlBU?=
 =?utf-8?B?ZFJzWG9vakwyOWlNTVhWSzE3cmQyTlk1QVAxV296V3FHY3pGRGIybmllOVFa?=
 =?utf-8?B?SDExVUpoNXptcnN1ajVDVHU2QlJSVkd5bWlyREl1bEFaOUMrQk9WNGxLdTBz?=
 =?utf-8?B?M09ja2lVdXhSZHNvaVUzZCs0Z0VxQWt5S01YejRWQ1VPWVJtZHlGNjVGa29I?=
 =?utf-8?B?RSttbXM0aXNseHhCM0EzNFRCMC93NkRLTzJoYzRJazcrdi9PU0EzZUlvbWpl?=
 =?utf-8?B?R0Y2eGJHL1dBL0ozSUhYbm1qdlNPQXpFWTFZQkhyV1JrVXRzY25INXorS2V4?=
 =?utf-8?B?cGhOZEV0WmRGbm1pbFp1dTVCbksyYXpPVEJRM3F4d2wyNW5SaGxjK21kWWZR?=
 =?utf-8?B?blZGSHkyZXQrakhYc3dTMFZSLzNTeW1ySVFsN0RwaWh1dUl4SlVaRUJyanVq?=
 =?utf-8?B?T2dvZCsza0VPdGVtSUpVdWo2Q2xpSS9uRVFjbjF1cVZUcTdMQTIzRmNTQVN3?=
 =?utf-8?B?OS9ZV0xHMW5lV2M3cVJBcTRkczJhSXc1akR2VndlQ1FFOGsrQ1FiZ2JGMjlm?=
 =?utf-8?B?dnZEMGQ4aHpUYmlVOGh4WDFmKy8vMkpva3M2aWx1bTlBRzM2RXNWblp2eWRB?=
 =?utf-8?B?RjJrYUFWRVZ5REFJVkN2WDBidEthNHk1NkIycEtNc0VTNWpMMytPOUdCWmlr?=
 =?utf-8?B?SVVtZlZFdmd3L0dsU3ZBbm9yS1UvUEx4REN4SGNVWFhLdzdLVW80RkZJTE1L?=
 =?utf-8?B?ZWtlaWRVbnZtNy9VcGVoRkpvZE8vbHI2K0RLeFpSSC9uOEJjcGR0L2NYMmE2?=
 =?utf-8?B?NVQyTjhHSnNmOUowWWV6YmZCS0k2T0EycnR2cDJFUmVsSk5Ta2FBR0MxUWdq?=
 =?utf-8?B?cEQ4NGhXYW0rdjJsYldDOHBaSWN2a29zM255NUt1NHlMUnNEd2Vhc2cyMGd0?=
 =?utf-8?B?MDQ2cW9DdkxSei9MWG1GcXNTblg0UkUra0QzZ1c2R1hOVjhEcDFnZDNrZkF0?=
 =?utf-8?B?ejlyNkFxWFNRV1ZGeVVvM3JFTWE0VTFTYkt4VUdJSWZhMmZBUzlERHUxWU9p?=
 =?utf-8?B?RVFFaHhISWZTZzBHZEZET01BdU5iWGROdnU0YjJSdkwveGpaUXM5WmFTNUU0?=
 =?utf-8?B?NTNYTXdwSlo5WXp0bGEwL2FLQXlabGYvMkdjZ2s2V1A4cGhCY0NweS96Q2Qr?=
 =?utf-8?B?ZFMwbEJKcG10T1FlRVo0V04zcVQwMVdIbnZXUFRtTXI0VTZsaVd2eWIyVFZV?=
 =?utf-8?Q?rzpZlESGu8veeQor326HCcHva?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4103c001-7480-43f0-b0fe-08dd1830f079
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 09:07:43.1159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2cZ56iFYJtW0UNbbxDzGqXkkd1oA87+fVf2Qlnhi882HYnjs55x4R/np5mKRObONzs+GSNCmO712t1u4AkqIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8235


On 12/6/24 04:00, Kalesh Anakkur Purayil wrote:
> On Tue, Dec 3, 2024 at 12:11 AM <alejandro.lucero-palau@amd.com> wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Create accessors for an accel driver requesting and releasing a resource.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> ---
>>   drivers/cxl/core/memdev.c | 51 +++++++++++++++++++++++++++++++++++++++
>>   include/cxl/cxl.h         |  2 ++
>>   2 files changed, 53 insertions(+)
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 8257993562b6..1d43fa60525b 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -744,6 +744,57 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
>>
>> +int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
>> +{
>> +       int rc;
>> +
>> +       switch (type) {
>> +       case CXL_RES_RAM:
>> +               if (!resource_size(&cxlds->ram_res)) {
>> +                       dev_err(cxlds->dev,
>> +                               "resource request for ram with size 0\n");
> This can fit in one line?


I do not think so. I goes beyond 80 chars.


>> +                       return -EINVAL;
>> +               }
>> +
>> +               rc = request_resource(&cxlds->dpa_res, &cxlds->ram_res);
>> +               break;
>> +       case CXL_RES_PMEM:
>> +               if (!resource_size(&cxlds->pmem_res)) {
>> +                       dev_err(cxlds->dev,
>> +                               "resource request for pmem with size 0\n");
> This can fit in one line?o


Same here.


>> +                       return -EINVAL;
>> +               }
>> +               rc = request_resource(&cxlds->dpa_res, &cxlds->pmem_res);
> As an optimization, you can return directly from here and thereby
> avoid the need of local variable "rc". In the default case, you are
> returning directly anyway.


Right. Cleaner code.

I'll do so.

Thanks!


>> +               break;
>> +       default:
>> +               dev_err(cxlds->dev, "unsupported resource type (%u)\n", type);
>> +               return -EINVAL;
>> +       }
>> +
>> +       return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_request_resource, CXL);
>> +
>> +int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
>> +{
>> +       int rc;
>> +
>> +       switch (type) {
>> +       case CXL_RES_RAM:
>> +               rc = release_resource(&cxlds->ram_res);
>> +               break;
>> +       case CXL_RES_PMEM:
>> +               rc = release_resource(&cxlds->pmem_res);
>> +               break;
>> +       default:
>> +               dev_err(cxlds->dev, "unknown resource type (%u)\n", type);
>> +               return -EINVAL;
>> +       }
>> +
>> +       return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_release_resource, CXL);
>> +
>>   static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>>   {
>>          struct cxl_memdev *cxlmd =
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 18fb01adcf19..44664c9928a4 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -42,4 +42,6 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
>>                          unsigned long *expected_caps,
>>                          unsigned long *current_caps);
>>   int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>> +int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>> +int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>   #endif
>> --
>> 2.17.1
>>
>>
>

