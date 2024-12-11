Return-Path: <netdev+bounces-151051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC709EC94A
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 10:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE94E161E80
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 09:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B82E1EC4E3;
	Wed, 11 Dec 2024 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4FnZTGYE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635C51E9B25;
	Wed, 11 Dec 2024 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733909897; cv=fail; b=sCDHzBcSNRV72WEYL9CrJLNJ+PcBfuK/QUmBNxwIolhQDbkIvvisGpvx83ebKFUjjUfWWB7YXJMSX+HUZH4tZsbo4Da2ZCqz09jDGHnrnECcRkmlmZbJmzjEUbKqUmVgDenGpDy7NPaV9BR6I3EdEvdONbfc66Cax3kMHKvwT1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733909897; c=relaxed/simple;
	bh=HSqehgXE3GAk1wCWwlA4jKRlpvcpUKyj6AA+K2iBSH4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gf38ty4pKEtuCcBlw5Yt0uXIB69RlsDS+MGoXn2lRjlSp+gm72dYZb2HjSMjFjNagppZGFZzNsANL6raV2VNiKpJpFfHAidcQg1pAiiA1t5w4Uw8VbGtykvNfj3rcWqNJDxPHRZ7uNowg1zEQLyZj6EagQCN2HPcVrio9Nv82u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4FnZTGYE; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/XS+4m/VTBnCQ5kTvjxxniVl2/ajQ/0+2mAbQIx5lqpmkJma762/NyFp8QUXfWdVrFMKCT1PoR1BckqY8pZ6hkANdcp5hM9RQde7pivBIStyPD3oFa4GxgeIdYodDtjcAnd2uspqDeGfOoSOKCBhQvpZi2Mr69+Iq40ysFaaVN5huO/0P6waaKQ948ZC3Oe34bTfKGzPi4Nj+LUKegPu5y8/tVM8bEPRts2q3lLxx+TM7WyrqqWwzIkTCd+cvv9JKFhZ2bupobed/GVPKuJ9rceXRnVo25cKSdexXMV0/5mkMqTexslzDQGtNkDN7q2cAcQsWup3YhzTOKZMVxAdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNtb45TE/HvYP2IabHTQfd20+fetgrKRfkpYECjpnYU=;
 b=B38ayt+b7RRYKwEIEXqHNxHbhZv+biBGzZS0wYWSQplDZTqr3KN5P3R4TvGcXFTlNMnfIaquVkTbLRyjQeRGxlQtBbyv+Y2GxM+/9gbuNy/DNbMYSx/XuInQs/9vfnuzX2Zn3aVf6or4MKHMXExeCTg+ppn5V0SoqMVn9QtXFhuSoKM1mZbytMnSFJODfqn2blvKdPgVtIqj2/LEI8GDauJlZjLQjQT6HPR/wCoj8WkI18q19dXzALcuhktN5yqu/uo8Ji/00r47CY11L0/e2tdtzPmrqG7ex90CKkEjjoijyCKOSTNnIBwXlv+I887UmChirGVUIxsbFoRf44olag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNtb45TE/HvYP2IabHTQfd20+fetgrKRfkpYECjpnYU=;
 b=4FnZTGYEAckDx4/KJixpC9viJOpco1t4lkg0BfNPgNL3Vxc/grlJ5PtyNZhixyZKi+HffgezwfsP9f+f4PNjTPmZJuerZUtdureSccBsD9upoQcllSfCVwXwVH1NYgBr2tE/Qu5ZEZZoGqPB0aRHREUnIaCCqlKifGgFSfeFN9g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MW4PR12MB7120.namprd12.prod.outlook.com (2603:10b6:303:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 09:38:10 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 09:38:10 +0000
Message-ID: <bffb1a61-bc47-cc60-6d1c-70f57e749e36@amd.com>
Date: Wed, 11 Dec 2024 09:38:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 28/28] sfc: support pio mapping based on cxl
Content-Language: en-US
To: Edward Cree <ecree.xilinx@gmail.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-29-alejandro.lucero-palau@amd.com>
 <0f2c6c09-f3cd-4a27-4d07-6f9b5c805724@gmail.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <0f2c6c09-f3cd-4a27-4d07-6f9b5c805724@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0090.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:18::30) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MW4PR12MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: e3efed0c-5143-4d30-d57b-08dd19c7866a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RndCQ1JpV0ZxaE13T0JmeStlbFBXMXlGNGtJT2x6RHFvb29hemxnRmJIcHRS?=
 =?utf-8?B?QWJ5T0kzM0FveUY3aXY2bzY4cCs0V1FyN1NPWHg4ZHZZMmVmRXpvcjdMRDha?=
 =?utf-8?B?ZGw5bHVUM2ZFSDNCQm5EZldEOWhOamp3Q0wzUWx5dWpncEdyWUFzeW5Ielhi?=
 =?utf-8?B?YkR4SkVJQnZ2K3hpZUVxS2M5Wjdhd054NmpGbDF4Y2tNYms4NmJkc0FkRVpH?=
 =?utf-8?B?MFU4Q1hINnVhSENwU2wzNXlUZjU1SVkxYk8wOEk3NVVtd2dUd0xqQjFFT2dx?=
 =?utf-8?B?enRzTzA4N3V1OUUwYnRqL3Y4RDd6eUJRTDFnVXc1ZDA3cmMvaVFNLzRxNExU?=
 =?utf-8?B?MmZ6STF0SmxHcTJmODNQS2VCWm9wekRXM1NQUElzRFBlMUtmS2hERjh3Q3Bt?=
 =?utf-8?B?MDh6bVI0ZHNmTkhOZlJoZHR6VUZJZVJoYzQ0dXV1aGI4YVRPS2NGUXdIc28z?=
 =?utf-8?B?TW5PL2ZsTTFkOWFvSi9RaHNKTnYzQTNFN2JTZDViWlg5cVh2WFlFNVVSTWJO?=
 =?utf-8?B?czVCKzZYa1M3anNOVU5oSFl0TGRFSFh6YWl3Mzdpdk5sL1E0SnZYYjdGWllG?=
 =?utf-8?B?dmRjWVdvS2FhZEpUbkgvZzFURTFHdnpiYnNyMDROdHdMSlJOYThLNEtaaWxX?=
 =?utf-8?B?YUw5OU9NMXhSb3p5QlNwMjNndytTSVNUMDZOMUtIZ2pZNWZJdWZDV3BrVEZ4?=
 =?utf-8?B?KzZHNStPZUh6QTZtcjRJNlN2UGNLZmgrZ3VITnozSXYrc1A4a1VLdENYY3ZF?=
 =?utf-8?B?V2tWUTAwVmNMbytoYy9wVEZhK3kwZWVoWUY4d2dBTXJMTlp3R2hBYkVVMkNK?=
 =?utf-8?B?MGpvdE9oQVFXa3JYNEdUVTMrWmlwU1ZFNGJvVkpUZkZVeFpqblVVY1ZLbVFR?=
 =?utf-8?B?d2dlelNsU3o1SFEwSWhkd2lMS2IzL0FLQ1hNWEg4cWx2Nno5TGJCcHVWNXdL?=
 =?utf-8?B?MWVrZ01DZldiMWwzYjNGd2NkL0h5dzRzcEF6ZVd5NHcyeGowQ2IyWkF6L0FI?=
 =?utf-8?B?WFNyQnprNndPbHJ2bGhyWmZyYlRUd1pCMjhaVkZuWTRqSE1oV0owemw1K2NP?=
 =?utf-8?B?YWhyaWFCN3lkNk93TkgzMHlwaUJwUlJrQjBRWjhTc1VuQllZeG9zditTdUd1?=
 =?utf-8?B?VmNJR0tZV0JENmtDRzB1K0QyZGFkSHFwWHpmRFdnVDJ4QTd3ZlVlUHdtRjh6?=
 =?utf-8?B?ZGhEbmZRdmx6eEM5cFg5Nktlam1xYVM0SlZnVnBEQ0dvbUNWSzlHWng2dHBo?=
 =?utf-8?B?VmNjNm5mc2dycE5qYzg5bDhOR3hLblRXbm9ySWt5Tm45MXMwV1lCQjBDcVNr?=
 =?utf-8?B?OVNReE1GYWVQTG9vU2RkMGx2cHgxb1pORGZYcis2MDlja1dXbmR0TkF3OXlY?=
 =?utf-8?B?VTUrVjE0d083U3UycjBDWmo3VWxhMnp6OGxCZ25KdVlnZkl3a3dyb3lYakw0?=
 =?utf-8?B?Q2RqR0ducXZTMmRkM0FwT2EzckFkYjNmNVI2eUJCU1lRejRyK0JjdVRUaDhp?=
 =?utf-8?B?Znl4OFJ0WFc4Mm40TUhMSEFnVjBJNjZBZ0ZVVFJuUHJpY2pwTVNqN05vUG1F?=
 =?utf-8?B?Z1RyblcyaGRWTHlQcXlxSEZneDZwSUVxQ3NIZU93WURaQzI2WFFxMngwaXBB?=
 =?utf-8?B?NEVaeFJMbVVQbTFidnlQdExaOWlnSmF5M2cxZXhnb3FxelFNVkJPZlBYSmF5?=
 =?utf-8?B?SmNMbWdtdW9aNEVSbERpUjBpYjVwTlFkSUtjOGhESm43RlpxY1lmbUJObkg5?=
 =?utf-8?B?K2sxN1ZMakVYQUp3WHVoeXZzekhIczN3QnY3YTZvT0V1SjdNeXREVkJyVDk1?=
 =?utf-8?B?cDFVbk02Sk40eURIQ01ib0d4QU5LZ0RUa29teG9FWk9IQnVZWHZPRUdBU2Q5?=
 =?utf-8?B?eVV5bmlXK2V0VDJVNHJOOWtlRXM5T05KQjE1MzgxMkQ4VVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFdDd04rWU11cUlrem9GcnZYUjFUcXlQemZNeXhNRkd2UFhyVkZzTm51NFNu?=
 =?utf-8?B?SUtwRUFrKzJqTTFJYWVDanJrdncvaUdzekl5Ni95YzJIQUIrRHF2dit6dHNG?=
 =?utf-8?B?V01SdXI5S0luSDAxUVJPd2o4QkxsQWRkQjArMUVOVVpqK1AyS0hjQ1hPNnFN?=
 =?utf-8?B?NGNGd3ZuSHNXS24rMkRWbWFWQ1YvcXdsMGRrdUtVdkNDeE4wRXFvanRJVXd6?=
 =?utf-8?B?aGJDdGx3VkczbkFyZStRWFJDcmlFRXNzMWpFRDViMkJqV0p2K2xXUGU5c2tX?=
 =?utf-8?B?TUUrSEZ2T3RZQTRORVhpb3VKMk0raDVmSk9OTHVRQkNtYlF2NWtRcCt4bzBS?=
 =?utf-8?B?YTZRc09Kdm5QWEFQZDVJWE9WczZKQ2lvYnV4a1ZBWVJXUkNrZUlOYkZoMVlO?=
 =?utf-8?B?NUY1YmMyYTYwTTZ4RldraGhmL0VVbStCUkJrUWRlVHkwcTlOdVdmRFl5bk9O?=
 =?utf-8?B?REUyL2MvSWRheHZvVTd0Q3RoSkk4ZDZRZEFjTnJPbWw0aHdNWkJUNTRpd0d2?=
 =?utf-8?B?Um9uWUk4WTNaYXh1WXRKYnNzdzJRa2dBOFhxZGlpMHd1MjVLdGdJdVhYL1U1?=
 =?utf-8?B?V1h2bXc0TTFNbEZNZkJ2cThENFhvZ1NuMHU3bG1VeG9UQWNZNUNZTUdBNzhi?=
 =?utf-8?B?VGRPTTR1RzMrSlM0YTBHWS9Td2pkU0ErZ0VHK2Z4a1pSYnZqYjJVazJ5RzNL?=
 =?utf-8?B?RTZyZnpueml0cXMvMUF6RXJQQ1VoM25hb1RpRndva05PMTIwUElXdTBGRWI1?=
 =?utf-8?B?ZWUrd2hBUGhoc2ExZnRQSzFaMUFxaTZlWjh3RHVlU3VQOXNncTQreTBOcTR0?=
 =?utf-8?B?RFRjSWtoNFA5M2NPTFNLeXpQNXZacU1EQ1YxeHphUEYvdnZSbFlNWlhYOXVL?=
 =?utf-8?B?Zjh4dHJva1oxYXEwNldWTXU3UWZpVW96VVo2eW15d043aE5mQ3lTbExlNUVQ?=
 =?utf-8?B?RC9DYmhpT0FaQ2tDYXlqN1ROTHQ1Zll2Z2F4VUx2dmQzOXoyUFowOCtZV2c4?=
 =?utf-8?B?MFF1RlQ3UGZPbEFKZUgwTXpjWVBuTDRybEVlNnNOc2RsR0FKYVZ6RFZWU3BU?=
 =?utf-8?B?azE1ejhicjUvY2pTdlg2Tk40M1RILzlFbjU5S0t2OWpUU2FVUDl1ZTFnZndQ?=
 =?utf-8?B?dmIvUS9rSHUxU01sQlVOL1IrWjZUOHJaa1VnY3duR1NJbUhiU29hR0xKWlh3?=
 =?utf-8?B?dVVkRXlhSStmQVp2eUljb29QQm4zclBEaWl6TU40YTJ3aFVKeksrLzdFcktO?=
 =?utf-8?B?eUlpc0RxalVXUDZGWXZCaUdFRkx6M2I2TGhQSE80elhReHlDZzFVYzRwcVhj?=
 =?utf-8?B?VGhENk4yanBWVjhVV0I2QVpsWU5hNnRFNkhKSDNGSVBYQ0NYa0ViZDFEMGdJ?=
 =?utf-8?B?S09JVnhsR2R2bUFGa2hlQUdlcXVqOVJ5RTluaTIwN2ZZcnBMVlI3YUEvbTQz?=
 =?utf-8?B?T0ozQ05NL01iQW93YUhGSzJmWHhVNC9PakJIVi9xOHp5TFJjTlBUSUJzUVlJ?=
 =?utf-8?B?Y2ZNSzI4OXVlZnFpUXpHNXFGdU9lQ05XRTQ4ZzNCeFc2a2x3dFFFYW1laUMw?=
 =?utf-8?B?UjdsbTFrSzh5MHBYS2hiYS8wNVVBS0NHb1RQVkRYdjZKcUJDTU4ySHJyN1hC?=
 =?utf-8?B?QTByUWNRZkxrMm8xdkpNd1ZVZjlDQ2NnRzY1VnZPeVU1VWZpOE5QSHp4M29n?=
 =?utf-8?B?NnovTnpvNHJLQytVWDNDV1JrZldsb0luQmhEYlN0QzE0MkE0akk0VU1DamtG?=
 =?utf-8?B?NW5vd2NQaVoycCtVbS9qZ1pOOUd3K3hIb1FybXVOMVJUTkZFWVBReWZBa3Av?=
 =?utf-8?B?Z2V2aGF3cW42YnE4VXA2azNEZTd1RkFSV25XOW1qRjVWNTIyaUgvaGJTdW5k?=
 =?utf-8?B?bHF5Y1JXU1VzdlhHNE5mdVhBL3loSlNYWTNKQkJlMGRaMmc3Nml3SHc3V0dw?=
 =?utf-8?B?bkI2TGhlSEJ4TVBNNXhQTDNoZk1BOFhLY3F0NGgvL2VYSzFja0hpMjBDVFVJ?=
 =?utf-8?B?a3JWSnJZTk95dUpPVDBzRGx0S0JYdk4vb1lEeTdhUHFzTGVib1lTaHRPdWJY?=
 =?utf-8?B?RGNzMHN0a1JZdjd5eWphcUh2U3RqRzJXQ2FUSnpodm1DQ29SeTRaQm5IOWJ0?=
 =?utf-8?Q?n2FgEBgK7YB3+o7oljWze2Uej?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3efed0c-5143-4d30-d57b-08dd19c7866a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 09:38:10.2901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MI/CC4xv0e7ynmc8GasUcMt9wc0ueEwpjUPZWencKU++if4zB93YC/QrZBLkk9IRR4hEuiFyawDSre5cVDqRIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7120


On 12/11/24 02:39, Edward Cree wrote:
> On 09/12/2024 18:54, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> With a device supporting CXL and successfully initialised, use the cxl
>> region to map the memory range and use this mapping for PIO buffers.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>
>> @@ -1263,8 +1281,25 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
>>   	iounmap(efx->membase);
>>   	efx->membase = membase;
>>   
>> -	/* Set up the WC mapping if needed */
>> -	if (wc_mem_map_size) {
>> +	if (!wc_mem_map_size)
>> +		goto out;
> Maybe this label ought to be called something else; it's not really an
>   'early exit', it's a 'skip over mapping and linking PIO', which just
>   _happens_ to be almost the last thing in the function.


I do not know if I follow your point here. This was added following 
Martin's previous review for keeping the debugging when PIO is not needed.

It is formally skipping now because the change what I think is good for 
keeping indentation simpler with the additional conditional added.

Anyway, I can change the label to something like "out_through_debug 
"which adds, IMO, unnecessary name complexity. Just using "debug" could 
give the wrong idea ...

Any naming suggestion?


>> @@ -24,9 +24,10 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
>>   	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>>   	struct pci_dev *pci_dev;
>> +	resource_size_t max;
>>   	struct efx_cxl *cxl;
>>   	struct resource res;
>> -	resource_size_t max;
> Why does 'max' have to move?  Weird churn.


A previous version (not sure if an official one) had two resource_size_t 
variables defined, and I moved it there for preserving the reverse 
christmas tree, and when removed one it did not look bad.

I will remove the move.

Thanks!




