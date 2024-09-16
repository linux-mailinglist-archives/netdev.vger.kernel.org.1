Return-Path: <netdev+bounces-128544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399B097A41A
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 16:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C77282E20
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 14:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DF9155316;
	Mon, 16 Sep 2024 14:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MJ9Ox2JH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9564C156256;
	Mon, 16 Sep 2024 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726496836; cv=fail; b=Zv/ab5Tb3fvavpBPMoNVVB459ni6BkAPMqLAh33xYmKgWDVbyCzBnAuVmTqiIlkmyy2CfZFH+WTFJqWOGISB/OzUboDUdguk8VNjiK8km0IqBaOU7R5obsYWruze4QKLYdYo8k+eb7VF3bh6LAZ04bVa/26SBNCFMjVlV8mb8tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726496836; c=relaxed/simple;
	bh=5J99kZ0x4xlClFnQtX3Aszv2Xqcywuy6xfVjz+0BNFg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I21OAcCVw4a4a+pTyF8tyG+MugAXwa6jglf7E1sg2P4LMOQbgMKg0clW1QAwJiHDgyFdAgTwmuu/Fgr/TBh1/BNOSMMZXtzJS62TLZRD7WHFQqzyJ2WBo6u0qQAfcS70RhI9brzu3457fzjAjXbhJGL4TS8GdFaDWldsarlwQus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MJ9Ox2JH; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2gFgZj7mjC0Z535ZksiUtwDSRwhp7/uAmwGJMNKuSAlfMM2OvHHKf/bJZAVD9BwGRWN0YugyVasZRfBPoZhM1QICG55CfHK1WqMxOIojg5ZJeWnA6CxX8PVA2FS5e4Nk3i4l+Hm1xpgXNgxIM9211bS3V5qaq33B9oSdMMxMwJFzHZbYKH6Wa7bRVq0EPvgxcFu5mgTP96vSMxXzzDlOafqkoFRN7N22AChuoJgTOs5O0JUfDKag3tkcMGCvRfPth7/HeH6z4nE48Dz+QXqg0abvGurS/UQswzfoe5U4bigLDwdW+ukTqV4ARXEr3PcwuKDv7BtO2k/neNLYh6c4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+PnW7zkj5mzBk9eOssyJM1O34DR67xKXQ8Su9zb+Pw=;
 b=SyKV/wRe6LxfIludn5+dUdpiG9iqFV/xmc7tdoDerDGa24IwbqBEG3ZHdCM82ji7zYbzUwQIIZ3GGbo8FlqxmCqeOEGtIT9stsbh22ld0UUKjUwqxM1MnUje2vcjVMK71/oymvdfN42tLvWjvsA7DSE7/STAPm/bTzB3P6khVNrqs0ApVtLeUGRXQ6aDKX7R9r654hGXG4lvCZNEDNrTGs3z6ECieyu78QBR8gOUmnqF2BBoosHPr0JVXD6qSl25Z7E28/U9LiAN3ScB1VOb1U5kPCMMbvlpTMRvyXXwH7UeSPTQ7IlWH/2kk3/Ez8zQPQ2hdvsiplT8B8cdKQVf3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+PnW7zkj5mzBk9eOssyJM1O34DR67xKXQ8Su9zb+Pw=;
 b=MJ9Ox2JHjmP9M3gts/xlJCR3AT56DBc38m8iiksutEQCgjApO3TSJkdTkXzUrD9FZNGiXSByZyTFPREk6d8F4TnoBeJrhHW4Cp0BFhpgBOcd9tbcYncOxvypq/t8idLpmJKu3vtWvTL/KAubDRsE2Rci7ze6y///gJooNBGrkcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CYYPR12MB8964.namprd12.prod.outlook.com (2603:10b6:930:bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 14:27:12 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 14:27:12 +0000
Message-ID: <76860e75-d0b4-d47f-9051-43ba84d43bf1@amd.com>
Date: Mon, 16 Sep 2024 15:26:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 13/20] cxl: define a driver interface for DPA
 allocation
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-14-alejandro.lucero-palau@amd.com>
 <20240913185906.000008a2@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240913185906.000008a2@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::30) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CYYPR12MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: 61606f3a-2a76-4da6-a220-08dcd65ba74e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXk2ZGwvbzA4RkM2TGZJaUFPbnk2WFoxdFovTmRvRmt4SCtiaUNCUHROUnBG?=
 =?utf-8?B?cUVFOWgzM1lEUWJQM3hpbHU1bmY5L3pOL0lNTlRIbUx2Q1dxT21DYlJxMFhS?=
 =?utf-8?B?UVZlV3pib2tScVdmWjVaeFRtaGVMK1hKYkhjQ0lMSnlreEtwVlR5dWFrV1JJ?=
 =?utf-8?B?MHNNS094OXVPVWdaQlFxazNpZXhobElmYVg0cGlzcUdZMkVUOWdVYTBSOEFl?=
 =?utf-8?B?TmtYUFRSRytPME4wSWhCZFluUnlUc2ZYb2gydWllbXdWTmdEUTdIeUJpeVBX?=
 =?utf-8?B?d0dXM0drQThtcFBOUDlNbGhQVXVDU0l0YnVmaXZKKzc3NC9LMDIyY2w3NzEz?=
 =?utf-8?B?ekk0VW1hbXpVcStBYmNsTzhPYWVMeGJ6RlVYVmNKajBqbCtBYm1leDNVOFkr?=
 =?utf-8?B?SXV1a0FKZU9ocTNOT3YzamFuakZvc3NmWFNEbVZGVkM2MUwxUWxpM2FuUFNt?=
 =?utf-8?B?Ym9UYWF2VGlXcVdHeWdxd1NPUVkyREVzd2l6TUxvdGMzMDBVMG4zWmoyR21t?=
 =?utf-8?B?eDNSQ1ZPMlpqc3NPSFlNZzcvYkxUT0NoSUhOWjZjZFpmMFhoMEhGdFJaUnNY?=
 =?utf-8?B?czVHdWZKMXNxQzZ0QnI4bEcwWmduNEREZ1pjUE1TOXFvbTgzTTFRMjB4dk9U?=
 =?utf-8?B?UllWcDNLb2l3MmtxTjdSVUhPa09xMVJiYlFET2NrQ21EY2pVMWtyNEVrZ0x4?=
 =?utf-8?B?SlFadUF3aFVwSFUwSEp2TTN5ZXF5NEtuS3h3ZjI3bGo5cHZnbHpta2FkbnFj?=
 =?utf-8?B?Sm1yNTFNcFNIWGQ1emduUGgxUzM2UjBEK2lVRkIwOW82UHFUU2lueUZ5WFY5?=
 =?utf-8?B?QzhYMUZGUVJ3Q2NsTDBSbzVQaFlFc3pDK0RRUGJSZ1dzMmlmY29yakFnRUMx?=
 =?utf-8?B?M3QvVmtUc0dvcjhXSWdqenJHQUpvRlJKRGJ4OTFuY2F4cVl6RlpOSitqNC9F?=
 =?utf-8?B?QU4wZTFWUjJHWXhhd3hvem1xbTRUMVpLeTlCNUtERzJyUElCVVYxSm1iVmdH?=
 =?utf-8?B?RUMveVdRM0NVdWpaWEJUVHhoZGhjMmR2NzdsTTBWU3RJTGpzWFhQb2RKZ3Np?=
 =?utf-8?B?WHJXQmpTNFpzRE9nNDl0VVNyeEdIeXpUMW9BeUM5S3NpY2g5c3lhZE5CcVJn?=
 =?utf-8?B?VFdrMk1IQWhac3VFT3FaSys0S0NBVFVGelhVUjZZak5SeEZiOGZhSzhRaEg4?=
 =?utf-8?B?bkpNKzdWN1VtUm50WCtuRzVIMHBCeWNjaDMyemE2Rm9HYURlZHpDWFBXYkcv?=
 =?utf-8?B?YUxJNlNsQS8rUzJWMllkV3V2Q3dteExsbTNBUzI2eDR0K25vb0lKRGRNeTU4?=
 =?utf-8?B?NW0vMnRqY0FHNklwTndYN211cFpoRGF6c1pZK2RHTkdMYmZzMmQxVHFEZHNB?=
 =?utf-8?B?YU5WcVpGOWY0QjFONTJTSTRzOGlrNmZtdndPNTkrczRVajB2Q2E2OU1YNWox?=
 =?utf-8?B?UFhSeDVZZElmc2dHcGRybVpWSmwxQkJhRXJPUVdIc2FoRlZLMEhLRnlCcWlt?=
 =?utf-8?B?Ui9rUEdEejgzck9ueTc0bnluWjZUekJEWFZhQ01BNWZiMDlkY0pqWmw0MDgy?=
 =?utf-8?B?ZS9hMnVmQjhGSW9LamlPYUVDMTRwd25ZNEdCYUMrdndlL1ZlTjV2YVFtQW8y?=
 =?utf-8?B?TzJ5YUhNTjRGOHYrc0ZsbWVrWGQ1YzBtcm8vQ0J5cWZJMGJvZ29HMlhLbEEr?=
 =?utf-8?B?VkVXYWkyNjhmaE81eVBieWlLOVVTSWhwRngxeFRXc0poUS9DQ1cyTGN0TUJm?=
 =?utf-8?B?b0cxR1VTczRzSXU0NjNOWkJJYzh1Rm04UDEvUWxFVTdwZzZjSVY4M2Ryakwx?=
 =?utf-8?Q?S6eebGvXRe0QA8FYxgWZgdid5xfE7+eDi/PCQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUlTUHNJU1ZBNGJGdCtGMUJQL0RBdzJzVTNDaGxhSEJNRUdkeFV3b3dlSzJl?=
 =?utf-8?B?MUh0M2dNazVZMWpCZXF4dVhkNVYyMHNLSUEwdlI5SnRVci80Mm54S21EVkZ1?=
 =?utf-8?B?Q2tEdnF1cFc2SjErSGs3T0xSUzhGVGdYUWJ2bVRzd0EvK3paWDBxU0ZkOHpr?=
 =?utf-8?B?SmNJeTNQT1BkcHdaVyt1KzBzbWR5TEpzWDlQalJSZFB3QjNmMnNGbUhUdEp0?=
 =?utf-8?B?eTRkcTUzdGQ0OThhQjcxNEt4NnJRWjhhNFJBQjYzRVE0SnY2UjB1Rk1QQVRs?=
 =?utf-8?B?bEtxSHlKNGdpb084RGFXVVJDR2czRC9WZWtZZWZ3TU1TdldNTDdmSnVWVmtU?=
 =?utf-8?B?YnZDc294Z1c0S0xseGlkSVk5UkVvQ2NZcmlYWFVMNjdXMTFGNUZaK2Njenpv?=
 =?utf-8?B?NjMwMC9na3pyYjI0cmpwdFFVQjZ6b29xclRSb29kVDltdXlzMWRZcFRsUlU4?=
 =?utf-8?B?bktld2FtK0k0cXBha1hwbDcvRUNjSU5BTFcwU1phSnhUQzZGNTlZTml5N0RG?=
 =?utf-8?B?RW0yN3lMWmplWjJETTlhZFpFWHZBbW0zaWdiZ1pFZHB1djlWNTdIOUFvdGl3?=
 =?utf-8?B?WVJ5TXdnRG5ka1ZPR0YvT3ZJVWIrY0RHWGdLVmZVYUxGMGNRcHlxWGlHYnl6?=
 =?utf-8?B?bC9zekNzSG5QWVBMYTdYUGYrQ1NoQk1lODFWWXhNWkhxc0VzVXJBZUd2UE1z?=
 =?utf-8?B?bVJheWd6SlkvVFZPUHFLeVJYWnM5MlBGRDhiMzhKRE5xOGtZamJ4VndyT2sz?=
 =?utf-8?B?YjZuWmFJMng5aG10YlNMTTVuam5mTTRaNFhFcnN3TGhEZXllZFpsMWpmRUZN?=
 =?utf-8?B?UDNidkx1NXl1VEdWNXFUTG9iNXJLQmVvNnZEMzl6UXRJS0VyRTFEdkFCQi8y?=
 =?utf-8?B?azFjd2JhRzZFam94R1JkWGMxQzZEZ1BwSGRTZGk2NytUT2x3b2lxazY2UU5H?=
 =?utf-8?B?Z2NBVW90SnViZEwvMXdHR1pEK1BCSDhIOWJ6TnFpdk9qdHBUdGxWVnR2YTF0?=
 =?utf-8?B?VVZWaG14eHpBUTdxMlFkTEYzaDhiK3lCRGJOUSticnNTeUwweFNaZGhCRU9k?=
 =?utf-8?B?MW4rYUJDTmxNcFZyUTVNKzdhQ003VlEyRHlpbnlPcEFpVGdrTCsvQWUyaStQ?=
 =?utf-8?B?WEVxcmJwZ2JDUHBRdEFxZ0dqYm1mR2crR05BSW1tTFlXTjBOdHZ6NkVFSC9z?=
 =?utf-8?B?bVVvSEtKNHNKNW41WHU3eU1NalBKZUtqS1VjNGhpU0txSUNxTytOaUp5MmNr?=
 =?utf-8?B?SDgvQWJLRGI1MjMyR2dHSUVsWU0zZlQ3dGc4N1ZWMm04L3ExNnhpdFhtUUVj?=
 =?utf-8?B?akJMdncwU3ZlVm5VUUU5R0dlU3Fqa0pMSFlNRjRQeFpMY1hTaTdFbXJzRzdX?=
 =?utf-8?B?dmFUbG1lVVowR2ZWZXhJbjliTlpjWUttcHpQNDJDMExuelR2aDFhZUdiSi9M?=
 =?utf-8?B?dFc0RVFlRnR0NkZadzl4d244VlNxMlBiUWlvT29HWWVVdmpNNFk3SlRySWRI?=
 =?utf-8?B?UzFzaHZWQk1Id2ZlNCt2bHNNUHg1NXAyZlo2d3JLbi9VczZQZjM4NGRxSW1m?=
 =?utf-8?B?VzBoN0YvUGNWK0Vpcnk0dUl5YlhOVTJ2Q0lDL0E5ZWFwUGJpRFNGVk9NSVFr?=
 =?utf-8?B?NzU4UERrQlc4ejhUcmhMcGloWVBXV3hoZUxWSmlwTDUvZUNQZjBuMUxaMmNz?=
 =?utf-8?B?T244UTFwblpDZVNPMThCaURaZmlvUGRJVVl3SUZyOWVWa1ZqUTFsaGwva1dw?=
 =?utf-8?B?V2t5NWozZDBGZG1BYXJPYUlCNEkvYUduN1ZxcDlGeHZBekhnaGpWNmRmWi9C?=
 =?utf-8?B?Y29HWW5WcWY2eTNaMmo4ei9nSXUyL2lvTTNWU2J5VnlGRUJGOWlGaGJUdGE3?=
 =?utf-8?B?eEx2QjRqd0hLTEZ0TUxmZmJaRE85OTJsR3U1cjNNb2VrMmlWajBYN2JUd0hB?=
 =?utf-8?B?c3YyTkxmNGJ3WW5QdFdvYkpHdkE0SkVIalVIekQyWmg2a3AvOXh3cktMUTR2?=
 =?utf-8?B?K1NwODFQQmZZM2Y5TkI5M1ExSTBDWndTUW9CeFhjeVBJWmFLaHhWSUlMUCtX?=
 =?utf-8?B?bHRWbFJIb0pIbHoxc2xvbUczajRmaVNQajlBNmV1Q2V4L0hNcjJETUNnaXdU?=
 =?utf-8?Q?ZRHI4zOPGhpzYAuOoAj0Qlmj2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61606f3a-2a76-4da6-a220-08dcd65ba74e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 14:27:11.9419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ho/2SVsOqnzWuKW6VsPY8SnAt0xlRCzesUlOos0A7i4hVasrD5QbEyX8BDdOdciRyTNU2IyuNdjL8L4UmNoi2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8964


On 9/13/24 18:59, Jonathan Cameron wrote:
> On Sat, 7 Sep 2024 09:18:29 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Region creation involves finding available DPA (device-physical-address)
>> capacity to map into HPA (host-physical-address) space. Given the HPA
>> capacity constraint, define an API, cxl_request_dpa(), that has the
>> flexibility to  map the minimum amount of memory the driver needs to
>> operate vs the total possible that can be mapped given HPA availability.
>>
>> Factor out the core of cxl_dpa_alloc, that does free space scanning,
>> into a cxl_dpa_freespace() helper, and use that to balance the capacity
>> available to map vs the @min and @max arguments to cxl_request_dpa.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Trivial comment below.
>
>
>> +
>> +/**
>> + * cxl_request_dpa - search and reserve DPA given input constraints
>> + * @endpoint: an endpoint port with available decoders
>> + * @is_ram: DPA operation mode (ram vs pmem)
>> + * @min: the minimum amount of capacity the call needs
>> + * @max: extra capacity to allocate after min is satisfied
>> + *
>> + * Given that a region needs to allocate from limited HPA capacity it
>> + * may be the case that a device has more mappable DPA capacity than
>> + * available HPA. So, the expectation is that @min is a driver known
>> + * value for how much capacity is needed, and @max is based the limit of
>> + * how much HPA space is available for a new region.
>> + *
>> + * Returns a pinned cxl_decoder with at least @min bytes of capacity
>> + * reserved, or an error pointer. The caller is also expected to own the
>> + * lifetime of the memdev registration associated with the endpoint to
>> + * pin the decoder registered as well.
>> + */
>> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_port *endpoint,
>> +					     bool is_ram,
>> +					     resource_size_t min,
>> +					     resource_size_t max)
>> +{
>> +	struct cxl_endpoint_decoder *cxled;
>> +	enum cxl_decoder_mode mode;
>> +	struct device *cxled_dev;
>> +	resource_size_t alloc;
>> +	int rc;
>> +
>> +	if (!IS_ALIGNED(min | max, SZ_256M))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	down_read(&cxl_dpa_rwsem);
>> +
>> +	cxled_dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
>> +	if (!cxled_dev)
>> +		cxled = ERR_PTR(-ENXIO);
>> +	else
>> +		cxled = to_cxl_endpoint_decoder(cxled_dev);
> Does this need to be under the rwsem?  If not cleaner to just
> check cxled_dev outside the lock and return the error directly.


We got a get_device inside device_find_child, so it should be safe to 
use to_cxl_endpoint_decoder without the sem.

I'll follow your suggestion.


> Also, in theory this could return NULL - in practice not but
> checking it for IS_ERR() is perhaps going to lead to a bug
> in the distant future.
>

Right. I'll fix it.

Thanks


>> +
>> +	up_read(&cxl_dpa_rwsem);
>> +
>> +	if (IS_ERR(cxled))
>> +		return cxled;
>> +
>> +	if (is_ram)
>> +		mode = CXL_DECODER_RAM;
>> +	else
>> +		mode = CXL_DECODER_PMEM;
>> +
>> +	rc = cxl_dpa_set_mode(cxled, mode);
>> +	if (rc)
>> +		goto err;
>> +
>> +	down_read(&cxl_dpa_rwsem);
>> +	alloc = cxl_dpa_freespace(cxled, NULL, NULL);
>> +	up_read(&cxl_dpa_rwsem);
>> +
>> +	if (max)
>> +		alloc = min(max, alloc);
>> +	if (alloc < min) {
>> +		rc = -ENOMEM;
>> +		goto err;
>> +	}
>> +
>> +	rc = cxl_dpa_alloc(cxled, alloc);
>> +	if (rc)
>> +		goto err;
>> +
>> +	return cxled;
>> +err:
>> +	put_device(cxled_dev);
>> +	return ERR_PTR(rc);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, CXL);

