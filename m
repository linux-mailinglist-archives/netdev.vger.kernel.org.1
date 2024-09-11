Return-Path: <netdev+bounces-127464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B179757EF
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 18:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0CE21F21EC8
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A8518661D;
	Wed, 11 Sep 2024 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c84glqJm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE73224CC;
	Wed, 11 Sep 2024 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070775; cv=fail; b=SRmKEJdiozJj9jA4WhmFCOMR2gS0H+UvoRmnj3n5TBOKV3879zFtXaiaN1jl6Zlu87XrgrBhI5GuJ0+6IVyAfnj42z2JrD2qLp2/yc2if/LRAE1TPJ8NtAMy7QCA+6KOeJLQFmp0ONRSoGJZzkyCAhZL12el5zfFPc6d00WUznA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070775; c=relaxed/simple;
	bh=LDxlILe9OHlmWdOH4I/PN8yKgYPEmMp8WzibXjNcjMk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zt4Pqz1TRrbn07wFLprtsAlPong4+9P68Gt50KePhwF1dNjnJBC++dZhSnQQunKSo1Nzs4t99OiRCATrnkANUkxr6d++ObftvzdDf7vmfsN1+FUePdmYwYeLMB/mRYx4g1SKLx2FepPNSIAD7UdSRL1YvvSpERigAhrHEWKqU5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c84glqJm; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrgb+aafVWIIkWgeNEp4nVh1QfERZ0QlqI3vHVIx5A0HVyIKAc5wGGmizSiR1CXFN830Cp1XcsY+WOR+5XI+hifYtTT8+f7SMwVkURZAjri5EijmufZdjeHF4JRP/ibBGze7wnkYSFKogZXEvPmhoAXWVhM8KrhQYbdWMx1HKZtmmLgWyLI47O+PVUMBVkOlJGK4Z1qW5O3KkkXcJ25AOAvGAuJKhC/3NKLvDPsQAEcsD8vlwVFSMwemzTGXMt3G862ocex6Ci8i303KV2mvqv4o9tjFy2GkefW9rwfcJ6FuzGBCWARdiTZ4AeGRAHVsQ6eRSxGOsR0VXhzPAXnaxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZMHUs24v6G7zaE7vqpfvtAxtKjp8Pn35bejT5vLpNI=;
 b=cgtNK4twXndwjeCebXA4emLJT0jG1LVHIfdUM7yKt6b23LO7lZclnJU9ScyiJ9iwJy2bD2Mu/IrcQrdONpUJq2yh5uuTmEQ4PRcyRgs26UCAAipo0PRI4Nvkkm/kjkcWNC4r4RIJcMTIEN8HtbfNAduBQ9KEN9OrArkrIfgvyLshCwQociBdR1WNXDCspBx3XW4UJlerhqZdi+gl6Wmi83+pJcn22nfcWeZkl2o1IMfgPprBq2kSDFiPZ+ngZY0imxBgSvfSAfPS0gdpFtkvSm/A9Hi+SqwufgppyF73P3w4PqyeOT0n73uFwEAAdgb7f1gJkv6uLqyr38Gpcc1VvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZMHUs24v6G7zaE7vqpfvtAxtKjp8Pn35bejT5vLpNI=;
 b=c84glqJmNKjx7g1+APOkXXX08LTQXCyxcEb/8TiwKHmb2kdvLBzwmel/DfwYvZ14ADFzEmmFTlxKpBi1tLGkmxsJht+OzvHL4j+wz46DB8d7s4+wyYoYjKadTD0/7b4samXS3XgN1nC44AuFGT6qVn8vYU+j1JlHW5xqQvT4Sqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by CH0PR12MB8578.namprd12.prod.outlook.com (2603:10b6:610:18e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Wed, 11 Sep
 2024 16:06:09 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%3]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 16:06:09 +0000
Message-ID: <cf1881d6-9234-42ae-aa50-31ce45f427c8@amd.com>
Date: Wed, 11 Sep 2024 09:06:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/4] ethtool: Add support for configuring
 tcp-data-split-thresh
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, corbet@lwn.net, michael.chan@broadcom.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, andrew@lunn.ch, hkallweit1@gmail.com,
 kory.maincent@bootlin.com, ahmed.zaki@intel.com, paul.greenwalt@intel.com,
 rrameshbabu@nvidia.com, idosch@nvidia.com, maxime.chevallier@bootlin.com,
 danieller@nvidia.com, aleksander.lobakin@intel.com
References: <20240911145555.318605-1-ap420073@gmail.com>
 <20240911145555.318605-4-ap420073@gmail.com>
 <1eec50e5-6a6d-4ad8-a3ad-b0bbb8e72724@amd.com>
 <CAMArcTXh9+s_JUEh4AgLuYVnWSnqzr7zzQq3m+Hc2dc4Nd2jQQ@mail.gmail.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <CAMArcTXh9+s_JUEh4AgLuYVnWSnqzr7zzQq3m+Hc2dc4Nd2jQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::30) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|CH0PR12MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b819695-cf88-446e-f24a-08dcd27ba65d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDdIaVNGeXU2K1c3ejdDNFZKZi84UzJscWxWY1NXWGZmTndmUjRLSnAvc211?=
 =?utf-8?B?ZUxuMm5sd3JKVFdKZCt3L0RhTE5vTjlWK0g5d2JBRENVR1hmb0ttN0FNR1Z2?=
 =?utf-8?B?UjRJWDc2N1VtR2JBcEtqZ1A5RUxveTVDdTJyTTRCVnA5N2d1bTEwclM3TWl5?=
 =?utf-8?B?Qm9HaW1CcFVHMVowL2Z0bEhZV3hKR21COXBMbE1DWnZ2YzZMemJ1NzZDRDlI?=
 =?utf-8?B?K0Roa0dQMzJqZlRzV3lGdzdKQmZsWlpYaGt2RHpHdUZPNnBMWXF5SGM2NUtB?=
 =?utf-8?B?ZDhzeEk4c0l0UmlzaUhvWWtiaktwSzZCV1FPSkN2a2tqdFc5bGtLWTNOaUxs?=
 =?utf-8?B?Nms2bnlud0lBRGJNWGw1aS9VQWh2SDMvZk5MSEZrbkRYTXpWYTRCazZlNHMw?=
 =?utf-8?B?bE5vdWUraHRqN0tmaVZYOSt2NmNBMDA1OXRQNU1Md09qVXc0SkMwTCtyWFZx?=
 =?utf-8?B?d0JKSWNMUWlRMHdYdVhONjViR3hZaHVXa1p2N240akZWK3dyUUJQQ3lBbzdJ?=
 =?utf-8?B?WjNJUTZ4WE4yQzZyK0Vla3JicVFHcXNVdjFsSjlXTlVHUzY2S2FUQ2ROZGZi?=
 =?utf-8?B?K2NkL29xQW5uSUo2MGJFNEZmRHBaYzl2Nnp2MDZCaFZYVEUyZ0x3MUdSZHNk?=
 =?utf-8?B?eWNYUS9RditnWVZmMDdRT3YxbkIyNURSMDZ5QWJ0dkxuRlJwUnc1WTJ0anhJ?=
 =?utf-8?B?dDl1ZzN5a1ZPMWtDenM5N3RKVC9PSUxGd3E4cnZFQ3BndG5rNjQ1VXdPWTNP?=
 =?utf-8?B?U2RIMSt1ci9JUkpYVUtIZHlQa2pkMHdqNE0yRjBlMFR4NEJDZkREV3k4TW01?=
 =?utf-8?B?Q0traVVFRXBsQWJlYVVxaHNrWUFvalRXRExKUnoxeU53WDRNQWhiNDlSNjJC?=
 =?utf-8?B?bCtSYTZOVmw3ajFZaVJSem8vNTVBV3dqM2FKbUJyanZaVnV0ajIybWY5UHNz?=
 =?utf-8?B?ems3Nk1ETTh6bXdHWVYwREJESGlkY1FYYUY2L2RWK2thY3pKZW4wdlQyZ3FI?=
 =?utf-8?B?Q1BnUGdLeEFmU0l1c1FhYndJeDhoYmNWS3ZHMzMyU2V3cmxzY0FnSEZTN3RR?=
 =?utf-8?B?d2RZbzJmVnkyR3U0a3g2eHY5MjJQUTlOd3FYVFRHcTBZVGdISUhpcWRmN3Ja?=
 =?utf-8?B?eWNEcDgrMXMwQ2JpWlY1S05weG4xL2U2QXJCTU5BaENHRElVdHAxcnpSY1Fi?=
 =?utf-8?B?SzBtWmlUcHZxb0RobTBlSXZvazl3YTRCcmVyc2U2YVZmS0xsalBuS0lQbXdq?=
 =?utf-8?B?RTVvWTYwZTNBUnQ0QUhmblMvNHFHVWE5U2huTWlUbHNFWVEyMFBFNVVjQmNY?=
 =?utf-8?B?S2pHUGN3S2JzQ0RtZnhRdmNjZ3FTemlMeUNQTDhISjdXZWtWUHhLRXBwb1FD?=
 =?utf-8?B?VndHQ0lvM3VBbmNzZ3AzcjhwY0QveUk5ODBEcVluUUQvOFFxZTVVK1FFdkdk?=
 =?utf-8?B?cmc1N0VsTDZGK0pEMW0xbnphUEdmMi9FY290bzcwS2hhMS94VktBb3hkc0tn?=
 =?utf-8?B?OStTU3dIbmJ4a20vMjNKNjZqK2NVWlI0L01xVTR0UFEvSlVkbkVxcWozWHJ1?=
 =?utf-8?B?YTIyS1djSjNCeU1XNnUrZWE1enoreUg0cHVuNE1YVGhWck1QcHY5L2V0WFF6?=
 =?utf-8?B?akdSejBtS3hiYkI1UVFERm1PZFZOeXBoZTczQ2pkQ3JXTUFXYW85czF4UnRp?=
 =?utf-8?B?UXdjRWVuS2hzMThpcUNMNU5xd1dGMitlc1B2b1prYWZUOFBhdmxjSUFYSmVI?=
 =?utf-8?B?b2JNNFhjWWx3TTVqeXNTeEp1eTFnZnc1OXlwMjl6QmN2b2tVSHBvTjdNdTZu?=
 =?utf-8?B?ZUpCUkpFL3hyRTJsVnRWUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTdIVzBRQjNMemNVNnNDeWNkQjZ1UVRVZUVwQlRnNDQrcTYxblljZkloS2tI?=
 =?utf-8?B?MVA2R3g1ZXJWcnRkZVQ2bkFqVUUvZjVpbkFtWTFXS0tOeEx0aXhOYlR3Wnky?=
 =?utf-8?B?WGpzK1NOVlk5MWxQd1RBbjd2ZDdwSWEvTDNoNzdBdlZYaVRraHFmWkdubk8v?=
 =?utf-8?B?MkRvcHloRkRZUW5MS2ZPb2ZoREI2U2t2RmFXYmc0eE0zeS9sSGxWcUlKcHpI?=
 =?utf-8?B?UTFpeVVDZ3A4Q0lEVG1jcTlaRXg3NmVDT0U3TGhZaEhDWlJIOWhFR1ZmRG9t?=
 =?utf-8?B?SkNMZ2dMQWlhV2NUblkrWWU1VWQvZTkvblc0SndzNkNpUGJJWC9BQXZKbDRI?=
 =?utf-8?B?MGpGUHorbW9WQ1pYU0hTbUFibFRUREdWWjJtUWR0eUpyQXdiRXFhZ1NucXRn?=
 =?utf-8?B?dGE4N1NvdDViYjlGcVd4ZmxBbHUrWExYUG4wRzY3UFBjNE03NVV1SDJyQzBy?=
 =?utf-8?B?MDhSVzdicEhQWEJlRXQwU2Y4NnBlOGlBUGxRRENvNzBuOEtvZ2FPZkVtWEpv?=
 =?utf-8?B?YWxvN3ZxNEFZV2JmR3d4eVRZQVNrVVNrSkQyZXJwRjM0ZVBISy9hWTdyU01T?=
 =?utf-8?B?Y0RITzI4ZnRHL0dkV2F2MzRnUUwwclMrYjNkeWtKUGVIOStzaHBJNDZtQkQx?=
 =?utf-8?B?V2o4TDFVOTlJemZaTXR0Zk5NZkY4cCtXMm9LN1pRWjFzM29UZDBucVE5dHA0?=
 =?utf-8?B?cmlZRzdKNHdPdEVNdXVYclZUMURkNEVZR0JHdDRGR1EzQlVLME9KOEZoTGhh?=
 =?utf-8?B?eWEzK25OYXk3QnN2OC95WDVJbXpJN3QrSThsMlpJRGkvNWtQRnF2T0tQMUl0?=
 =?utf-8?B?ZGY4T25HUnFVV2YwZjVBMjZwYTdHVDh5SFh1aFNzeWtQWDNsZnJxMmY1VU0x?=
 =?utf-8?B?enphWUdmSms3N3puYVZ6MTZvanNRdWpQc0Zhb0NPdStLMWtFMkE2ZzRUWHdk?=
 =?utf-8?B?Q3MvU2hiZW1TWkZNWVNFVHZhcnNhRG9nbHljUE1mTWo5RUhkOUg2UDhFelFL?=
 =?utf-8?B?QnYyMmM0eWcrRkpTb3hWRjRtZld4TWEybmRrU0lmWE15ODJXMWtrdlJ6Ynh5?=
 =?utf-8?B?ejBtOFVva2Q2NGtXSGN4Ty96YVd4QldEOFhZOEpqb0NvWGVLeUhnTTZGQmFI?=
 =?utf-8?B?WXlzRlJxNWE5Sm95OVN3YnZSM2YvTEljcndPenZHMmZDQXgyeGIyUnlIM1Bx?=
 =?utf-8?B?ZkJrQ00xVzl3V3dYdVpOUjI4S0tNL2Z0Sys4YTVLSlJBcUdCb3pmUVR5RmNu?=
 =?utf-8?B?cjVNeFdVSmd6Smswb2ZtakZWcTFkSGdnSm9OUGM4cE5OZFFEQW5nL3hGTXhs?=
 =?utf-8?B?ZHU3SkROOFRJaitEQWNhYUhHQ0s4R0I2QXU3N0VjQklsNDloaUJZOHo5S3Nj?=
 =?utf-8?B?a3ozTWRpVllhUUdkT2VtdGt5TnBCcXUrRmFiclYxUGQ5eVN4MFljb095UEx4?=
 =?utf-8?B?WklFR3BHeE1nNWpkTkZ1NGM5ZTZnZy9QNFVZVEFtUGZTQUNVbEdGMHJNUDB6?=
 =?utf-8?B?Nnd4Y005aXZRRGZVVWJHZUt2emFWWHYwdHVOaWJjMzFYL0tOM25Ma2RCWGxH?=
 =?utf-8?B?VTFHS2p3MGFFS3NPR1ZKbDZuY08wYU55SCt2aE9rNWMrTUJCUWk2cENibUFE?=
 =?utf-8?B?SWhGZU9zTkVCZjQ0NVluVDR5MmJqUmVnZ3oxbEJEYm1FUnJtR0NncHhhNmVk?=
 =?utf-8?B?R2RqQUppbkJkVFh6enVpK1JILzA3RXNtZVhZNFFZMjl5eE43WWhrQUNNelVK?=
 =?utf-8?B?MzREV3JVSlVrTm8yajk0VTAxdWMrSHR4dHUwQ0MxSHFRUStMbUg0R3B4S2Vv?=
 =?utf-8?B?QkdGZ3JUN3NNNmhvbG1rdVE0MGpDWG5nTFp3T1NOY0dxNEU4Y3pKUWc1L3Zl?=
 =?utf-8?B?ZGR6cEpjNkp6LzBJQXo3eHlNa3ZWdEhBWXY5OThJMHhMa241b0xWVGplWFJB?=
 =?utf-8?B?dXNuMjJnNWtQRlhxalJSNmw3TVduNVN0NkRMTUVjMjJTb2YvQitSMG9JNjQ5?=
 =?utf-8?B?bEd5Wkk2SC85bDRNV3B5SldlN2d1SFJZRlkyVlN6ZmxIcmRSazREa0xJb3hi?=
 =?utf-8?B?NkwxVlRjNnZEcktVcWtIOUVta3pwY3dVR2NQRFJZY2J4bzFQTDkrd2FzR0pG?=
 =?utf-8?Q?WucOjXWG4i3Z7fWdLxOBWP5zc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b819695-cf88-446e-f24a-08dcd27ba65d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:06:09.5806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFv7hO5zwbu3c3DdKOwqmE7ejANPKXKZ8PnXuBwYgnlKrBaz/l8aObzSDlSGFgPcqmYEz1VoHsNF3eQnm0thiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8578



On 9/11/2024 9:03 AM, Taehee Yoo wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Thu, Sep 12, 2024 at 12:47 AM Brett Creeley <bcreeley@amd.com> wrote:
> 
> Hi Brett,
> Thanks a lot for your review!
> 
>>
>>
>>
>> On 9/11/2024 7:55 AM, Taehee Yoo wrote:
>>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> The tcp-data-split-thresh option configures the threshold value of
>>> the tcp-data-split.
>>> If a received packet size is larger than this threshold value, a packet
>>> will be split into header and payload.
>>> The header indicates TCP header, but it depends on driver spec.
>>> The bnxt_en driver supports HDS(Header-Data-Split) configuration at
>>> FW level, affecting TCP and UDP too.
>>> So, like the tcp-data-split option, If tcp-data-split-thresh is set,
>>> it affects UDP and TCP packets.
>>>
>>> The tcp-data-split-thresh has a dependency, that is tcp-data-split
>>> option. This threshold value can be get/set only when tcp-data-split
>>> option is enabled.
>>>
>>> Example:
>>>      # ethtool -G <interface name> tcp-data-split-thresh <value>
>>>
>>>      # ethtool -G enp14s0f0np0 tcp-data-split on tcp-data-split-thresh 256
>>>      # ethtool -g enp14s0f0np0
>>>      Ring parameters for enp14s0f0np0:
>>>      Pre-set maximums:
>>>      ...
>>>      Current hardware settings:
>>>      ...
>>>      TCP data split:         on
>>>      TCP data split thresh:  256
>>>
>>> The tcp-data-split is not enabled, the tcp-data-split-thresh will
>>> not be used and can't be configured.
>>>
>>>      # ethtool -G enp14s0f0np0 tcp-data-split off
>>>      # ethtool -g enp14s0f0np0
>>>      Ring parameters for enp14s0f0np0:
>>>      Pre-set maximums:
>>>      ...
>>>      Current hardware settings:
>>>      ...
>>>      TCP data split:         off
>>>      TCP data split thresh:  n/a
>>>
>>> The default/min/max values are not defined in the ethtool so the drivers
>>> should define themself.
>>> The 0 value means that all TCP and UDP packets' header and payload
>>> will be split.
>>> Users should consider the overhead due to this feature.
>>>
>>> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
>>> ---
>>>
>>> v2:
>>>    - Patch added.
>>>
>>>    Documentation/networking/ethtool-netlink.rst | 31 +++++++++++--------
>>>    include/linux/ethtool.h                      |  2 ++
>>>    include/uapi/linux/ethtool_netlink.h         |  1 +
>>>    net/ethtool/netlink.h                        |  2 +-
>>>    net/ethtool/rings.c                          | 32 +++++++++++++++++---
>>>    5 files changed, 51 insertions(+), 17 deletions(-)
>>>
>>
>> <snip>
>>
>>> diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
>>> index b7865a14fdf8..0b68ea316815 100644
>>> --- a/net/ethtool/rings.c
>>> +++ b/net/ethtool/rings.c
>>> @@ -61,7 +61,8 @@ static int rings_reply_size(const struct ethnl_req_info *req_base,
>>>                  nla_total_size(sizeof(u8))  +    /* _RINGS_TX_PUSH */
>>>                  nla_total_size(sizeof(u8))) +    /* _RINGS_RX_PUSH */
>>>                  nla_total_size(sizeof(u32)) +    /* _RINGS_TX_PUSH_BUF_LEN */
>>> -              nla_total_size(sizeof(u32));     /* _RINGS_TX_PUSH_BUF_LEN_MAX */
>>> +              nla_total_size(sizeof(u32)) +    /* _RINGS_TX_PUSH_BUF_LEN_MAX */
>>> +              nla_total_size(sizeof(u32));     /* _RINGS_TCP_DATA_SPLIT_THRESH */
>>>    }
>>>
>>>    static int rings_fill_reply(struct sk_buff *skb,
>>> @@ -108,7 +109,10 @@ static int rings_fill_reply(struct sk_buff *skb,
>>>                (nla_put_u32(skb, ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX,
>>>                             kr->tx_push_buf_max_len) ||
>>>                 nla_put_u32(skb, ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN,
>>> -                         kr->tx_push_buf_len))))
>>> +                         kr->tx_push_buf_len))) ||
>>> +           (kr->tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
>>> +            (nla_put_u32(skb, ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH,
>>> +                        kr->tcp_data_split_thresh))))
>>>                   return -EMSGSIZE;
>>>
>>>           return 0;
>>> @@ -130,6 +134,7 @@ const struct nla_policy ethnl_rings_set_policy[] = {
>>>           [ETHTOOL_A_RINGS_TX_PUSH]               = NLA_POLICY_MAX(NLA_U8, 1),
>>>           [ETHTOOL_A_RINGS_RX_PUSH]               = NLA_POLICY_MAX(NLA_U8, 1),
>>>           [ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN]       = { .type = NLA_U32 },
>>> +       [ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH] = { .type = NLA_U32 },
>>>    };
>>>
>>>    static int
>>> @@ -155,6 +160,14 @@ ethnl_set_rings_validate(struct ethnl_req_info *req_info,
>>>                   return -EOPNOTSUPP;
>>>           }
>>>
>>> +       if (tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH] &&
>>> +           !(ops->supported_ring_params & ETHTOOL_RING_USE_TCP_DATA_SPLIT)) {
>>> +               NL_SET_ERR_MSG_ATTR(info->extack,
>>> +                                   tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH],
>>> +                                   "setting TDS threshold is not supported");
>>
>> Small nit.
>>
>> Here you use "TDS threshold", but based on the TCP data split extack
>> message, it seems like it should be the following for consistency:
>>
>> "setting TCP data split threshold is not supported"
>>
>>> +               return -EOPNOTSUPP;
>>> +       }
>>> +
>>>           if (tb[ETHTOOL_A_RINGS_CQE_SIZE] &&
>>>               !(ops->supported_ring_params & ETHTOOL_RING_USE_CQE_SIZE)) {
>>>                   NL_SET_ERR_MSG_ATTR(info->extack,
>>> @@ -196,9 +209,9 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
>>>           struct kernel_ethtool_ringparam kernel_ringparam = {};
>>>           struct ethtool_ringparam ringparam = {};
>>>           struct net_device *dev = req_info->dev;
>>> +       bool mod = false, thresh_mod = false;
>>>           struct nlattr **tb = info->attrs;
>>>           const struct nlattr *err_attr;
>>> -       bool mod = false;
>>>           int ret;
>>>
>>>           dev->ethtool_ops->get_ringparam(dev, &ringparam,
>>> @@ -222,9 +235,20 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
>>>                           tb[ETHTOOL_A_RINGS_RX_PUSH], &mod);
>>>           ethnl_update_u32(&kernel_ringparam.tx_push_buf_len,
>>>                            tb[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN], &mod);
>>> -       if (!mod)
>>> +       ethnl_update_u32(&kernel_ringparam.tcp_data_split_thresh,
>>> +                        tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH],
>>> +                        &thresh_mod);
>>> +       if (!mod && !thresh_mod)
>>>                   return 0;
>>>
>>> +       if (kernel_ringparam.tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED &&
>>> +           thresh_mod) {
>>> +               NL_SET_ERR_MSG_ATTR(info->extack,
>>> +                                   tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH],
>>> +                                   "tcp-data-split-thresh can not be updated while tcp-data-split is disabled");
>>> +               return -EINVAL;
>>
>> I think using the userspace command line argument names makes sense for
>> this extack message.
> 
> I agree, that using "TDS" is not good for users.
> I will use "tcp-data-split-threshold" instead of "TDS threshold".

Sorry, just to clarify, I think the way you have it in this message is 
okay IMO. It's the other message where there's a slight inconsistency 
compared with the pre-existing extack message.

Thanks,

Brett

> 
>>
>> Thanks,
>>
>> Brett
>>
>>> +       }
>>> +
>>>           /* ensure new ring parameters are within limits */
>>>           if (ringparam.rx_pending > ringparam.rx_max_pending)
>>>                   err_attr = tb[ETHTOOL_A_RINGS_RX];
>>> --
>>> 2.34.1
>>>
>>>
> 
> Thanks a lot!
> Taehee Yoo

