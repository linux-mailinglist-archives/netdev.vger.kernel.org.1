Return-Path: <netdev+bounces-182447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D95A8A88C85
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F771899B87
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 19:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EAA1C8616;
	Mon, 14 Apr 2025 19:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1PtKlgeV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A10B1AB6C8;
	Mon, 14 Apr 2025 19:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744660547; cv=fail; b=aVa4+yf6T95tmTepUhqqo84H+0wSANOY+Ovn+PEzBdWh5X/kw4oIOB9+p3VcuSRGzmHLD0amoKqqtUnCQeFLw/cvUl9M9M4OS5IzUMyku/8D6F0RFUZ2DNuWicUeJrUQxkOMyI47R+vCPBq19WwCgjoS2ENfUfdGmo5UWPK91jQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744660547; c=relaxed/simple;
	bh=3dLdqkAYllIvsThZNTX9aNon5mqcFxNEJ8ST4aeC/iI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kS3EOUdPrElFUF/2o9mwCE0LX+CKUXZD6bttLkr0SNmrcmqVJ4S1q1hcEWBawX+F33wTRJwZ9riZr6efmQ8fBYFh2TRVVGsTfKCRZH05W1PqyPVd6Rlb2/a4x+i8B9LaZYM0L7dMD7UGPckNWVTGrfYf2m2LkCDU0dESXpPfgIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1PtKlgeV; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkiH1ce48nROZci2jLFMXImA10cgIVIXwHFouYKb9Ur9fFpShbYWEQlNPRS2yuP6pQoGO2T+9IW2HM+Qi9WqPVm0dJvBJOjyMzp9So/XeysPoPyqlJkzKeY5nbxXFGkPAKEl6LE1MjOdJN8xVq2Ti0O96AP9Vy00tBk6jqI4wGshowpPYaLg9ugzJFMPlV+Ia+uh10jT1o47VS5Htt+owBt2jBdRxATpoJOpTtBNheo0XWJIiVTK8YwVYDeupWxCoLPlwHRbiuZnhX6oaYkn0xDRSN+nyyTKGsjTpbe0B+02rQDAUOpxwdhtGlUPOTsWkdfxbu3UW52BMFUlgVReXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8YXBpFd5dP+BaO21mCj98MVrI4xpGJK/msOvp/93Qg=;
 b=pLPUMzx57HXFDPYTvdgrUCRkcbFxHKGsMhAOFkLwzBPnYwsV/2zpULmuJYjGHXTzD5EkMMwmxRzl/xv1vQY86n306eZZ31vIn0E7kIXjp+wPFIR5+cdbCRFMXSmnI2KmoEQZd5fgKSN/zq3yf+DcaBkx7dXL16fRB3CmQdLfCHhFCM14FCW6Z7ya1Dzd7BQoTBHW0Nnc+QVCR4HkwucRWqaY5uvPM2nIfXUZ7wLBC+q9nfRaqEqB1UA8/qZH2ZvCqbzFkJ/WdjD8suZRHf/oI8FX/Cjvczs1APV97Vdo5JF6XnBXfb5tYfJuHMTOg3e1oL2FhePusiaF0OFbGOt2XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8YXBpFd5dP+BaO21mCj98MVrI4xpGJK/msOvp/93Qg=;
 b=1PtKlgeVufyxefqzAVpcrXqf8wTsRjxsco86pUJROUAGFn/l4cXILBySM2Xrzuw6EiXKX1xyUWJB2utNxxqsov3R00mFIY17ESRXcnbEy46kPY/GcsfZX6HfKEJUbLnar040WI4n9HmqlwnqCoP23/7ij4D25vGcXRZq4gh4qCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.32; Mon, 14 Apr 2025 19:55:42 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8632.035; Mon, 14 Apr 2025
 19:55:41 +0000
Message-ID: <a32f6b8a-860b-4452-87f0-04e0d289d473@amd.com>
Date: Mon, 14 Apr 2025 12:55:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] ionic: support ethtool
 get_module_eeprom_by_page
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, brett.creeley@amd.com
References: <20250411182140.63158-1-shannon.nelson@amd.com>
 <20250411182140.63158-3-shannon.nelson@amd.com>
 <ed497741-9fcc-44fc-850d-5c018f2ef90e@lunn.ch>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <ed497741-9fcc-44fc-850d-5c018f2ef90e@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:a03:505::25) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|BL3PR12MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 283d1448-3070-4c10-5120-08dd7b8e558e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnhDL0ZCUHE5bmQ1amZ0Z1JwY3FJMUdXUXVJN0JLRmNqTFR5SEgwZUFVMDg4?=
 =?utf-8?B?bitaZFQ4YS9PcDZwem83R3FqU21QMERaWnQ5dWxCMjE1MDNvVkVRNEZ1eEY3?=
 =?utf-8?B?clNZdUdKSXFwb3R3NVFxRUNsbk15ajlWeUpTRUJjRjdIK095ZWorcTBKcHZV?=
 =?utf-8?B?UVYzbXV2S1RvS0Y1K3p4TWlWb0Y3THhVbUEwV0Q0QjluenJpY1ZKN0lwSUJa?=
 =?utf-8?B?c0VsdFlEeUhBR3IvR3pnei9Tc0w2bmJSMGZ6UGxuZjMyc0RXNlREL0RuK3BB?=
 =?utf-8?B?OGJCUTVtU053c3FNbExxZVpleThHbWdYVXNUNzNILzlYbSt1MVZzWHRmUGVC?=
 =?utf-8?B?MVp0Nm9GWWRSSzZic05QNFJsZm9BeU1FbVBvYmFEMWNiWDBCNS8rS3pVNEt3?=
 =?utf-8?B?MlBsUXZBRkU3a3dzV0FqTW9jbXBkbC91enZrT0ZPT2FQQStIa05MTlVwVHoy?=
 =?utf-8?B?ZytsK2J2SGZWa0R0K2hsNUlTcWxvRzVKQU5aU1QvR3FlSVhuc01BNFVUTklz?=
 =?utf-8?B?SmR6ZHVYL2xjZDU1RERYcXJuNkt0UzdiVXBHalRkSzRwcWRLSld2dFkrNHV0?=
 =?utf-8?B?eUUxaWtrTi9aV0huK04yY2gzc3hXMGZ5azdUMDNibklZOVo0Qk1aeFVob0tQ?=
 =?utf-8?B?QzhvYnE4emtkUnp3eWw0TkI4UUFwMEpxSG9jckRhOGpOdkd4c0xmdmFPaWNu?=
 =?utf-8?B?cGU4Zm9zMFVZYW5TY0VNTVpoei9sTVBBMnVGS1gwVDVzRHJtdnBCZ28vNi9Q?=
 =?utf-8?B?a3orZnhEMUtuUXVMdktrek9ibmVHcldrWlEyeCtYanoyRnZLcE5uN2JlL3Fm?=
 =?utf-8?B?N0ZNNG55eEV2MzhlSHhPMFF4VWt3Z2xQVWtodzV5aFZzbFBrVGgrQnEzVnJF?=
 =?utf-8?B?UmdEVHRYd3dtZEVHc21TQ1dKNktZVmRLY3ltUS93Q0wxSmtYdjB3UWNKejA2?=
 =?utf-8?B?TzBKQlhVbklHckxuWlQvaGozbmdCRXdGN0JPREVDUW9Dc040VU9yMVZTaTVH?=
 =?utf-8?B?eTZFWnA3OWZBdW8rSE5Ga3VBNWNTNUx2MFNLWHhBQkQrMldLczJjYm8zTjVv?=
 =?utf-8?B?WVJBSlJieDlkMnFzdE85OUpjVFhuMUwyOU04d0N0eTFVYThrUlkyb25WcDh3?=
 =?utf-8?B?elZuaFl5OFRVMHJIbWI0ZGc3L2xLV0tSdlRxUGdVYmkxYitCdHBCeXFoZHFo?=
 =?utf-8?B?TlRqcUYvNHpNdmFRbUx4dFpka29nL1Q5OTNWZzRBYzVpN2c3Z0tLNnMwK2lv?=
 =?utf-8?B?YjJLRllQVDFWZ2R6dC94S3FyNDYvWXUwZ2E1UmdXOU8wQ1FtdTQzYm9kb3R2?=
 =?utf-8?B?cmdDMlZWdEo2NHJPVU00QjN6U2ROU0FJMERxTjZZTkUydnFUNFY0a0NPV28y?=
 =?utf-8?B?dlh2YWpJU3RXTXJ6d2wvUmE0NUp0NnI3ZXpzb1lhYTQ2SDFaTjNMV0RESmJ4?=
 =?utf-8?B?enUweDV1d2xvQW80VHlTUFVWUGJsUlNYOGF0dVhyckRqU2VFMUYwdkw0TFFE?=
 =?utf-8?B?dmVlcHg0RFNWZUc1SzFPYzdvTVdnR2tHVmVmQXAyb01KZ2VGSUJ1NjJEMTRD?=
 =?utf-8?B?ckxVM1J6ZHkxUmxVZkl6eVpBNlUrWVBMenE3QmtWQmpzVmF5N3JCTnFSNG9G?=
 =?utf-8?B?YzJKMlZwME5zcWtnV1VFNThqbTRuWHlyMS80c0VFYnhuKzFjbm12dkhVeVcy?=
 =?utf-8?B?V2dPazl6ZDRWT01PdTJYTzlDT3pia3ZPc1JUTkN3NjVLYWlqYVhPUzJNeGM4?=
 =?utf-8?B?YWkzZE5kbklWSDlyTWVCcVZaNHNvWTd4bEFkTWxVN3IrVXBQZW5JamhZV0pH?=
 =?utf-8?B?eUR5TFhaKzBiODhxd1gxYzAxMitQZlJFWGV3VmMyM2c5a3MwTlZlb2cxdkxl?=
 =?utf-8?B?MkpyazBlcXdETVd6R1hXanVrZXJXUktUQ3RjdGFtTDdISTZlQ3BLZ1l1eXNB?=
 =?utf-8?Q?66XAyKoXon8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjZDMGdWM3NFcDhxeHQ2ODdZanE0M3M4eFN2a3Qwb2ZqQWUvN1lPOVB3V3hF?=
 =?utf-8?B?UW5TYnBLR1c1TGwzS2l4ZDIwYVd3SmREWG9EaWNhR2pSY3IzMXF3MDQxdkFF?=
 =?utf-8?B?T2VjZWk3V3l5U0htQnlscENOOGZ6am02UXVCeHpYZjlzWXJzam53Qnd5ZlBN?=
 =?utf-8?B?eGxvb3FzN3BGSnZXVFIxNDNYZGZjT0c4b2VNRVRkbVc5OU1JWWwyNnF0RXNi?=
 =?utf-8?B?MkJtcGU1bEtFSWs5VEliUFk5eGx0QUNLdkpBc2c0UXhrS2pUcE93eHpnSEkw?=
 =?utf-8?B?ME1YU1p0d1FqVVFkenIzQlM4QURFeWRSZStjcmpUanZwNTZ4enB4NVhLdEFM?=
 =?utf-8?B?aXZZK0EwT0s5Y3RWNnlNUGJJNTVGMy8zUUVCcFhjN0dBVlJBdVhCL1RVRUY5?=
 =?utf-8?B?MWhKcFJtRG9pSFlORmZZNFFzZEtzdXUyR1dMeXc2RUdHUVBMUjdJa2dwbElE?=
 =?utf-8?B?aVJreU1mTzFGeXlIWGxOSk94Z1lGT2kxdnhLY3pIZ3VhYUxDbzFLSjc0TDV1?=
 =?utf-8?B?SmY5K3cra21MZ0NhRGgwVi8zM01vNk1NeXJiSGNsZ3hOTG96dTRtSEJncTJY?=
 =?utf-8?B?eXQwWG1RNGdvbWhjL0dGSWtkUmpmWElIWU1ERW1FZFFvTitoNHd4d2poOElC?=
 =?utf-8?B?M0JRQS9iVGtBKzdnSkxGdkJ1OU9MVVo0WUlxWWVXWDJPT3Z2TEtrTXYwMVNi?=
 =?utf-8?B?R01tek94QkVrbi9XaXM0Mm4wZU4rNldSTXA1Uy8zQWxidCtPSkxLWWhUQW1T?=
 =?utf-8?B?Z0pqMFhnanBQTHRnb3kwU3R1Mm9NaWxELzRjOC8wYnEwVEk3V3cvYUFBcmM2?=
 =?utf-8?B?VHRwQ3d4KzJRRk52aENGRm52VlR1WmtSWGFzMjJXZlVJN1Vtb1FkVTNFUnpU?=
 =?utf-8?B?c1hHUlp5UGxEcS9HMkQ1SEZ6bHhqbERmdXh2NCtVSDJWaVpCRVlwYzJzbyty?=
 =?utf-8?B?dkgwQ2xhT0txTWk2WFRoQlRHMlliQXZnTktSUG0vV25jdmx6TGh4N3Fnc2Nu?=
 =?utf-8?B?eDR1a2VBQk9oT1lVRGhlcWF4RS9nTFROam9BT1B0aTdrNmNGRHFkSXoxcXk2?=
 =?utf-8?B?MEJNdXNCbGZJZnBBMElybjBrSnd0b3BkbXZYb0ZjMEk3TGlYN2NvbmFTZFVS?=
 =?utf-8?B?OEtNTngrQzJBOEFSZ3QzMmkvOXo5UmNwZ09oNnNSeXRaUldaNEs0UDZDcW9B?=
 =?utf-8?B?SHYzTkJBeFlwQnR2emZnUDFKSkk1cUI3aDhoajY4dWsxTE5WMkpldXVSRGUv?=
 =?utf-8?B?b2JPL2hSSzQzM2tNd1pURkRESUxtd0hyalVSeGJNdVIxSGYwd3RYTDhPTTg1?=
 =?utf-8?B?YmRUVVZ0bXJKMkJKMXFoSjJoVDRHR3locThXNWZNRUVrL2FFL0dIanhEVndy?=
 =?utf-8?B?WGJEZXQ4ZWszME9NRWlYRThGVTdVVGJxUGF5anZleXpNNGxGbWFmWDNzRDBl?=
 =?utf-8?B?ZFVaSXNWdnQ5QndoQUQ0dmUvV3p0SVBScHlUTTc1OU1GZGswWE56cm1XSUdv?=
 =?utf-8?B?RW1VSG9iTjd3ODFKcG9rVExTU1lkRmRUaEN3QStnZnJzbE5xUEdGdzRINzVT?=
 =?utf-8?B?T3FYaXRHNERjbFpQb1psUVQxKytrWElUVmVXSWpQam1EMDF1ZkxSU0NtRFhn?=
 =?utf-8?B?T3NmZHVQZWo3NXZZckEwUE1sSGQwNlR2SStKZXFrWlhXZVpMdGk5eFJIMHJW?=
 =?utf-8?B?U2x1dTU1MWMzdDlteHlpZkFVM2FheG54T2NzemQ3SXRpOXZLWDQwS0YxMkpy?=
 =?utf-8?B?REY2S1ZjdkpqN0pRSWxhTXhiOWdISnpILythaGo5TTFBMXU1cmlyN3pjZEh4?=
 =?utf-8?B?c0QralM0SjBOWnMwWExpS1Q4TnRkT1h5enNMZVlrbU5aQmNuVGlFYUJNYnZX?=
 =?utf-8?B?NEtCOW14Wk1vbk5qYW5oWkF6K1ltcjRSQnBrZ3VtQUlvbGhWL1hQcUE4TFhj?=
 =?utf-8?B?ak4vVE9rRHRTMWdvSUJxcy9zTFIwMEVkOGlkR1ZUSFJ3VDhKUzk0TFNRWnhX?=
 =?utf-8?B?dTdvWW9UaHRacUZuNmRkYnhmUUhqQlFWQWwxRUY5VGxRVXhwZHoyUWVJK2ZT?=
 =?utf-8?B?dldGRTdmTDBJdHdXdEl2Sy9WZnducEhiSU9MUzE1am1oZWJTTVc4L0JLZk9Z?=
 =?utf-8?Q?qWdmvdTq2zdYe/ITOGoW72B4v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 283d1448-3070-4c10-5120-08dd7b8e558e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 19:55:40.9258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1bGdoSp3lfuOFEL79biImM7Y9h7Uatri9jG6TI/wn9vUKLIRDisbP2c2u436w7u89phMJv0bBTsm0NQqi26n0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547

On 4/13/2025 1:58 PM, Andrew Lunn wrote:
> 
> On Fri, Apr 11, 2025 at 11:21:39AM -0700, Shannon Nelson wrote:
>> Add support for the newer get_module_eeprom_by_page interface.
>> Only the upper half of the 256 byte page is available for
>> reading, and the firmware puts the two sections into the
>> extended sprom buffer, so a union is used over the extended
>> sprom buffer to make clear which page is to be accessed.
>>
>> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>> ---
>>   .../ethernet/pensando/ionic/ionic_ethtool.c   | 50 +++++++++++++++++++
>>   .../net/ethernet/pensando/ionic/ionic_if.h    | 12 ++++-
>>   2 files changed, 60 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
>> index 66f172e28f8b..25dca4b36bcf 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
>> @@ -1052,6 +1052,55 @@ static int ionic_get_module_eeprom(struct net_device *netdev,
>>        return err;
>>   }
>>
>> +static int ionic_get_module_eeprom_by_page(struct net_device *netdev,
>> +                                        const struct ethtool_module_eeprom *page_data,
>> +                                        struct netlink_ext_ack *extack)
>> +{
>> +     struct ionic_lif *lif = netdev_priv(netdev);
>> +     struct ionic_dev *idev = &lif->ionic->idev;
>> +     u32 err = -EINVAL;
>> +     u8 *src;
>> +
>> +     if (!page_data->length)
>> +             return -EINVAL;
>> +
>> +     if (page_data->bank != 0) {
>> +             NL_SET_ERR_MSG_MOD(extack, "Only bank 0 is supported");
>> +             return -EINVAL;
>> +     }
>> +
>> +     if (page_data->offset < 128 && page_data->page != 0) {
>> +             NL_SET_ERR_MSG_MOD(extack, "High side only for pages other than 0");
>> +             return -EINVAL;
>> +     }
> 
> This is in the core already.

Will remove

> 
> 
>> +
>> +     if ((page_data->length + page_data->offset) > 256) {
>> +             NL_SET_ERR_MSG_MOD(extack, "Read past the end of the page");
>> +             return -EINVAL;
>> +     }
> 
> Also in the core.

Will remove

> 
>> +
>> +     switch (page_data->page) {
>> +     case 0:
>> +             src = &idev->port_info->status.xcvr.sprom[page_data->offset];
>> +             break;
>> +     case 1:
>> +             src = &idev->port_info->sprom_page1[page_data->offset - 128];
>> +             break;
>> +     case 2:
>> +             src = &idev->port_info->sprom_page2[page_data->offset - 128];
>> +             break;
>> +     default:
>> +             return -EINVAL;
> 
> It is a valid page, your firmware just does not support it. EOPNOSUPP.

I can see the argument for this, but EINVAL seems to me to match the 
out-of-bounds case from ionic_get_module_eprom(), as well as what other 
drivers are reporting for an unsupported address.  It seems to me that 
passing EOPNOSUPP back to the user is telling them that they can't get 
eeprom data at all, not that they asked for the wrong page.


> 
> 
>> +     }
>> +
>> +     memset(page_data->data, 0, page_data->length);
>> +     err = ionic_do_module_copy(page_data->data, src, page_data->length);
>> +     if (err)
>> +             return err;
>> +
>> +     return page_data->length;
>> +}
>> +
>>   static int ionic_get_ts_info(struct net_device *netdev,
>>                             struct kernel_ethtool_ts_info *info)
>>   {
>> @@ -1199,6 +1248,7 @@ static const struct ethtool_ops ionic_ethtool_ops = {
>>        .set_tunable            = ionic_set_tunable,
>>        .get_module_info        = ionic_get_module_info,
>>        .get_module_eeprom      = ionic_get_module_eeprom,
>> +     .get_module_eeprom_by_page      = ionic_get_module_eeprom_by_page,
> 
> If i remember correctly, implementing .get_module_eeprom_by_page make
> .get_module_info and .get_module_eeprom pointless, they will never be
> used, so you can delete them.

If .get_module_eeprom_by_page() returns EOPNOSUPP then the 
eeprom_prepare_data() code tries the fallback, which is to use these if 
they are available.

Following the mlx and bnxt examples I left them in, but I can see how 
this is essentially duplicated and unnecessary code.

Thanks,
sln



> 
>          Andrew


