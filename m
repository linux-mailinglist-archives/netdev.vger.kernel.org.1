Return-Path: <netdev+bounces-241309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA94BC82A42
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 23:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 693A83ADD49
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 22:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DC6231836;
	Mon, 24 Nov 2025 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OoLCSfYT"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012022.outbound.protection.outlook.com [40.93.195.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D0838D
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 22:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023089; cv=fail; b=Q8OmsgKqlT/7XMe+iWe+cwdFMOFhtn7D+U/k+vAx6Njdnio7qSvJmrFIvuKHCcaQhX/7krYhV35aGhLLZgKCZXTMj7CzLtKd+m+zJx5sAeGGNgqlkPZSaxmWGpb9FrKwNEgBgigWq+ksaUIrMm30rLfEcu/fR1Mpmysdqa0Fxo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023089; c=relaxed/simple;
	bh=SeJJBCxeykossz/UlykD+7ER8TUTspKBM6HlIo8CvjM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GlC3bRiiEnwE+/H7sABLZIxK5CiVMH1TKt+4cOB6TijKXdGv4+tyTLbSanctlxvwLbAbxfFEm/3sAuacnlLpGTYCv1+PDRWLOk0qUvHkxXuTFmXYz/w9TRFPp08uskUgj0YIAZiqqqpmdEWBmuPYl9T8xgwALT4MbpdLwg+4FU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OoLCSfYT; arc=fail smtp.client-ip=40.93.195.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXxpAb3LVlROiB1BQPrliwHoVZfZLAbRs7lOyal9208Dkq3DcPSkt0hbnlinMQogWXs9OBeH8DqO4aE8whAi9hbvB0Kyvddq2d/Rsl2nHz7T2UC99GMexyPDAC39NNOHEsk7Q1eod70TwZEwcDv1QzOPrSayuEaCCuzo7tZMY4lT/5K/hZlX95kgUcLKQnXdbsyk7+RH5S2+saOSz6OhbCvhIbkQbIzt6jGqM+hS7uM4zLxSQvCncz/Mm45mhiPtLaQYDSFMM0O0KisgTRxegA/N9VSEX1topahtcFY2QAGCGgsSq5qTXFUg89JfJJZ8pomq5WBgIMibU9l96/4FfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73JPi5l5s93Tq1RysteCxMcFcr+DW9vLDWyhP66bhms=;
 b=RRu2HZbCfLBur7irRNHWxgE+momX72rcq14Z2269dscvfWKtPrY4Pw1SdfepFbCGsuusxI8cdhMKMAfsY7K2/S15ukb02tt0/hpFAj78mEG4KliW9osdG8qDnOqLHxugk1Bi4mefyF4L1FZC3M8A7R8XgB7vzxaAV8ohr36WMdlpUR/2bVhz7TXzLvx7HsAhfjmaDzSC73icUpo9uaX3h+bCUAYU3EXAjFd+s17PjjUEdftwFzOapYCKoF/q0Aevvz6n5EqeAmOvRli9B/MVkbczPKbQOsFIcgsG43LLLm2+9ywGdbiO4DXlEqkyVUBuXABy6ryq00Emhcaz7tpIKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73JPi5l5s93Tq1RysteCxMcFcr+DW9vLDWyhP66bhms=;
 b=OoLCSfYTeqD2t166CvJ8YUbfhNciDcLbNee+34JxouG6QrTMY1LUha3xBpwLp/pd8FibbCwTZD5o9TdQ/uFCVevT8MVE86gV5GYROOBh4YGRL3W+XmzidyePzkLOPIOsCTsGXXalW9eeNt5TfbR3Ahnb+PXCb8nwmB/2NScgdBKRxmOdeAsyzTSTDMbicsfOqE28xkQNrtJUCjsP1MoKpGC0DKA7JdZf0Iqy5LH2+Krnvi3tgQyfFcdVBdw9RZGzGfAmGV4pvjiVmy+OKS5ycWCbyFZNRIacqRSOOwOzV9dvIeamr67qBZF1j8znAbTT/PuvAbI/NHYJz/VgIhazUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by DS4PR12MB9681.namprd12.prod.outlook.com (2603:10b6:8:281::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Mon, 24 Nov
 2025 22:24:40 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 22:24:40 +0000
Message-ID: <29fa4996-38e3-4146-81d3-f8b188e047e9@nvidia.com>
Date: Mon, 24 Nov 2025 16:24:37 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 03/12] virtio: Expose generic device
 capability operations
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-4-danielj@nvidia.com>
 <20251124152548-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251124152548-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0195.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::20) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|DS4PR12MB9681:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ac0794-d540-494e-6740-08de2ba84248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3hCMS9JVHlXRUpvK2JienlHV2ZGSW5jWWRUY3VLMlR6dGp4MllRRHc3ZGRC?=
 =?utf-8?B?UVpGK3psUE1vUDZSMzRTKzhOR0JFUEJVS2FDb3NKWnlaUFVncHZXYk4zbGNS?=
 =?utf-8?B?WTE1Sk1lN0dpOWhuV1BUR05ORE5sZjZLWk5wVFl4a2dUd1RMWTQvTFl0dVBW?=
 =?utf-8?B?ZEE5WlJMc1JmL2RaZlFKWXRpMndiOUlaSU5qa0Rac1c2VW9LTFBNZmRvaG8w?=
 =?utf-8?B?QndwbXZDYzdGdHI5MlEweVhYb0R6TEJXY1lrUktwc3BTSW1rODFLNUxNODEz?=
 =?utf-8?B?MHB6NEdUTmFqckd4MnQrRUswOEFxNk1GK040ME14WW9iQjVKaWt0RmNaZFln?=
 =?utf-8?B?WXlmL21ZUmZsdXBWR3l1cGtNRHZiMGFJY3RucHB0OXcwR0tQVDVRMDVjclBF?=
 =?utf-8?B?aFJvZ0xRMjRleUZPQVB2S1FhYStMV1dYNUE3THhwUFRiRVp3ME5SUi9tbGtk?=
 =?utf-8?B?Z1p6YmdYWHQ2WUVsNVlPUVFISjV0RTZiVjZVcFRDMWZQQzRqNFYzRkVuRGlU?=
 =?utf-8?B?MXA0RmJQNHVPMVVJVnN5ajNkRlFzc0JMTjlJdHhIcE9DZUVTRTRYdldhMldz?=
 =?utf-8?B?Z3YyM2trRTZlTTU1cUdOamMyeWdibmFwMytuUTl0NHkvK1o4eVRoZ1pYOUxM?=
 =?utf-8?B?aTA4bGlBdnpTZjB3WTYwNU45NG1zc2YwZnBGQ3lDMFJQeklXaGh4WkFlWHBq?=
 =?utf-8?B?OHBGdWxvMkE5RGloY0VvVVVDOWkwOW04cHRaYkM3R1VzeXJ0SGRabjB6b2JF?=
 =?utf-8?B?ZTJiMWM3Q0Z1UXAweW1BZnhUeEhKMnNzR2F6RVZnQlNveVp6QWhQTjZJUXJo?=
 =?utf-8?B?V2JiRExZSkFML09XNHQ5VHd5Smpkc1I4TzQvdngyRGwyQTlWaHQyQlJ0bTJY?=
 =?utf-8?B?dlV5SGcrRW9qWDlMVS9XL1pNK0hlUUJiUDJsWHJhR0xWRXNNOGVtY3puMm0z?=
 =?utf-8?B?by9rS1dIU0R3Z1RFZnpYTU9sa0ptSm5DeVZjRGIvYm1kK0dYQnQ0c1BXUEVs?=
 =?utf-8?B?YW9OOVVZRk5GaGp4aEVHZWxEeVJhSGdDcUpEaWlDNmNOdWM2Um1IY1BFT2Jz?=
 =?utf-8?B?QTBSY0FaOGFhQXpzME9ydXVNV2FmQ0RERkxPeG1QTDROWkh1WVhuTE42UFRH?=
 =?utf-8?B?K2lGZVMxSFdDektiZ3FjckE3dGs5N2U2QkNmSzhLTmVGUFlJTGRaNXNmSXYz?=
 =?utf-8?B?V1JzM3lIYzk4QlBqaHpHUVZRY3p2WTVJWXhMVk1DMEp5RjRQMzNVVEFpakEr?=
 =?utf-8?B?emx1Y0doTzBRNVVKR3FQQWVZM05OQm04MU85OG80aDNRL1g2cVNXUEMzd2xS?=
 =?utf-8?B?R3dsWWFTV25jQ3RKcjJrbzVTVkU5VnNVTytuY0s3MzN1cS9WdllVTGVLSW92?=
 =?utf-8?B?TVBqSGtnVzdteG1ZY1laRWgzRHVoNGdkT0dtWk51Uy90RjBEcjFmZndZY2dr?=
 =?utf-8?B?Qjlscy9SZGlZNGNvcmRFRko0dExlU1RkUVRJSkNQeE00TVRBaDhsYjZjNXRj?=
 =?utf-8?B?TlplQS9WMzVVZi92UW5CMHNnSzNwanp2alBHNDlKYWZmZkRNY3czU2RMTVF0?=
 =?utf-8?B?UnlMVkhTU2VjcVNxMWJqa2RmeFpieDlOTlIrMWQ3QVcrWjFITDNJeWJCenZZ?=
 =?utf-8?B?NERkQjNpR25kK0NXd2JtUDFsMW5NWjUyV3ZoNHdvLzdxZWtyQjg0cnNjSzFk?=
 =?utf-8?B?UktUNFRqTjdBYitUanI3MlBQc2F0bVE0L0Fjd0l0Z2hUQ09JSnpDenc4cGpy?=
 =?utf-8?B?UkZ3UU5jb0xMb3BpOHFvRzFEWFczY1FoMWdlYStackI5RFJ2RUdpbEd5OCtw?=
 =?utf-8?B?MDV6QWM0bVFBemhDNWpwb2taUk5hRmt1NlZFY2k1d3kyeFFyUHlWaTRwaVhr?=
 =?utf-8?B?SGNYRTdHbWh2SWU0UUliWm5QWDEvbjdjU004ajFKMHZSSGNpWklUVHhaRGhp?=
 =?utf-8?Q?YGOAZbrHux9TlerlVpwmipHnhwNPEcdU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3lQZWFXWEpsWjFqcWM1cytUdjVSOGh2VmJiRjgzTDdlQWZnTnNJTVNQL0Jh?=
 =?utf-8?B?cHhjRjZHOUtBUENpRW9KbTVxM3YxYUxsS1R6dUpZK0UyRk5maVhjcGNobjRU?=
 =?utf-8?B?YUVVUUxkY1AvTjNiZzlkWW96OFpvbFI5eGxFbmRMUXAzeGRndk5wcFJuOTRV?=
 =?utf-8?B?RGNham1oaldGclY0UWVZZjdEb0dGVWxwUGVHV2pTc1lJZDlSa0hLUjZ4WHdp?=
 =?utf-8?B?eGdsS3VwMnBNVEJFaGU5TmoydDFIcTZ6ekpMWlRWbzBxQklkaVp4WmZXdWU3?=
 =?utf-8?B?Y1lzVVQyYWZLd2JSSlpqZXdTVkt3eXlnaUVOTmlxVWtpVDR2MEFMblIvQTdn?=
 =?utf-8?B?emhaa0ZjcFRtMVFubVc0Qzd3MEU4QjU5bWZvcWplekJEd1doK3J5SWFRbjlY?=
 =?utf-8?B?eno0ZFNTOFB2aTZJcFlrNkxhdUEwMFJIbXdTVkRFVWdIV3k3cVNQdnVBWHlY?=
 =?utf-8?B?SW0vTElVbG5qdDZobHp1Y3hJamltZ1pGZE9DWFg5bjRvaThUTUVSY1BLenRE?=
 =?utf-8?B?cEZpb0JVV0hrbktweUxnQzJLVG1ZTDlDSU1Ob2NNOUxsTko5YmQxc1JGa29y?=
 =?utf-8?B?VER3eHpxaEpZVDFLZDhOTTRHMnpCMXpCaDJoSFdBeTlhSGFROE1lRGs2Q0RL?=
 =?utf-8?B?NWpZYlJHOXdlK1d0UTg1YTB3QlJrbkJtQkRUTWhtV2R4Z1VWVmtWc09lc085?=
 =?utf-8?B?RmZQOWdCUVhKUm9Qd3o0QVc1T2tPbVBUZ2dWMlZMTFlQVTdhaXNoNHM4WEM2?=
 =?utf-8?B?TVJUZVpON2FyWDRqc1JIUUFiRTRHK05SVG9GUXluSitvbDhJeGdxUmFBS2px?=
 =?utf-8?B?NE9uU3BLL0NVZUFHSGg0NHhOV2ZCL1RDNUMzV2hUZ0tEZVJTQWtoeUFTb3lV?=
 =?utf-8?B?azUyY1BhTE1PVXFobUFPRm11YWRDd1NkSDJBak9RdE42Umk0cmt4ZnlvRFhn?=
 =?utf-8?B?bEFGU3IrUCtHZC9PY3pVcFhVdzRKd3A1UGJ1bE5WbWI3Q05yNXZBRmZxSWtF?=
 =?utf-8?B?Smh1V3NCQVdIU2d5MDRmczF2MlM0bHd5cVZINDU5NmhxNTVQa3FDM0c0RWRh?=
 =?utf-8?B?TzdJZ2xFbE5Ub2FPMlZNUFJneGlPNHBQaGd0b3M4dkIvUWU1OFpESHV6cFN1?=
 =?utf-8?B?aS9KVC9BZlBRMzY1SjhmZFRTdnQvNFNKUUlZSVd1RGU3R3BvVWZaclhaVVlH?=
 =?utf-8?B?RlRGQjdxZmhIY2dDVDBuY0tURXNMM0U0NlBINlJNY0pOUitmSVlhdTRhMzgr?=
 =?utf-8?B?WDEvZjFyVkg3empqUG9ldmhISVBVQlZQL1RZbTJyNnpWTFk0cEZ4NU1XOTd1?=
 =?utf-8?B?V1cxcThKaTVEMzNQdGVvMCtZa2tjUXpmU2FKL3pHNnliNWFDM3kyUERtaXJC?=
 =?utf-8?B?QXZhUExCa291T1NCdG1JWnVCWHdvTWR0R1ErNThXUml3ajYrenlLcTNGMmpt?=
 =?utf-8?B?dU1OYXpTN0xPMkREczlBK3ZvRE9hYnQ1WmYxb1Y5NDdQOHFob1laWXFob3VN?=
 =?utf-8?B?NGkwZEJPVjh5cFl4ZnoyZVh5WTBVK3o4KzdPOXRPOVAvTFk0M1gzaHBIVUp4?=
 =?utf-8?B?QlNpbEVoY0grNXUwT3lzQnRXM1RxSEw4SGFXZEF2M242ZUszT0xUc1FJcGJG?=
 =?utf-8?B?UGZmOXd0SUpHeXMra3BjWWNoeUxqUDhkS05hWTV1RGdFdEhlaURFYU1xS1hW?=
 =?utf-8?B?SGY3RnVuZUNxSnppcmo5SjI2eXpxczRKYVJSYVVSMERNVDdjdmtuQ2ljbjY3?=
 =?utf-8?B?QjIxeXhub21Gemlnbk5DT3JKMXdiSVR2UjhQdUtTeHdsaGJDK04wN0diN0xR?=
 =?utf-8?B?RXlJUVFTNFlZbXBWcWs1OGFGSmx1VXNqNmlXcW9IcnYvaVVlQ2dzUUcxckhY?=
 =?utf-8?B?bk83VFFnVU43L2V2OTlsaVdwc3dlM0NQbjNoU0s3TFpJYU9jZjRsa1NEWEhK?=
 =?utf-8?B?VTB5L3JmOGNmRlpnMHlwbWJEWjVuUjBmSzZCNEJueGdUS0VaVmhqTUoyUUtC?=
 =?utf-8?B?a0VVVWtnUURJVEZNZFM5VGNObE4xYzZWQ2JHUXB6bWFrd2ZvMnYxVnNPS3Jh?=
 =?utf-8?B?NzFTVTY3TkV4eEpPY0dFMVUzbCthbVdRbVErd0dYSk5aNlAreDRIT3FZZk03?=
 =?utf-8?Q?CvZDpD2FsdLh2T5K0VZT07p45?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ac0794-d540-494e-6740-08de2ba84248
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 22:24:40.1543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Bv39sJjouv3aSSDAPkqT7wOOHySkhIA5u269SJNSMprbAkTCpRp997t07vQbvIw3Hx7cSSPQZFIZU0hKTRJqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9681

On 11/24/25 2:30 PM, Michael S. Tsirkin wrote:
> On Wed, Nov 19, 2025 at 01:15:14PM -0600, Daniel Jurgens wrote:
>> Currently querying and setting capabilities is restricted to a single
>> capability and contained within the virtio PCI driver. However, each
>> device type has generic and device specific capabilities, that may be
>> queried and set. In subsequent patches virtio_net will query and set
>> flow filter capabilities.
>>
>> This changes the size of virtio_admin_cmd_query_cap_id_result. It's safe
>> to do because this data is written by DMA, so a newer controller can't
>> overrun the size on an older kernel.
>>
>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>
>> ---
>> v4: Moved this logic from virtio_pci_modern to new file
>>     virtio_admin_commands.
>>
>> v12:
>>   - Removed uapi virtio_pci include in virtio_admin.h. MST
>>   - Added virtio_pci uapi include to virtio_admin_commands.c
>>   - Put () around cap in macro. MST
>>   - Removed nonsense comment above VIRTIO_ADMIN_MAX_CAP. MST
>>   - +1 VIRTIO_ADMIN_MAX_CAP when calculating array size. MST
>>   - Updated commit message
>> ---
>>  drivers/virtio/Makefile                |  2 +-
>>  drivers/virtio/virtio_admin_commands.c | 91 ++++++++++++++++++++++++++
>>  include/linux/virtio_admin.h           | 80 ++++++++++++++++++++++
>>  include/uapi/linux/virtio_pci.h        |  6 +-
>>  4 files changed, 176 insertions(+), 3 deletions(-)
>>  create mode 100644 drivers/virtio/virtio_admin_commands.c
>>  create mode 100644 include/linux/virtio_admin.h
>>
>> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
>> index eefcfe90d6b8..2b4a204dde33 100644
>> --- a/drivers/virtio/Makefile
>> +++ b/drivers/virtio/Makefile
>> @@ -1,5 +1,5 @@
>>  # SPDX-License-Identifier: GPL-2.0
>> -obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o
>> +obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o virtio_admin_commands.o
>>  obj-$(CONFIG_VIRTIO_ANCHOR) += virtio_anchor.o
>>  obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
>>  obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
>> diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
>> new file mode 100644
>> index 000000000000..a2254e71e8dc
>> --- /dev/null
>> +++ b/drivers/virtio/virtio_admin_commands.c
>> @@ -0,0 +1,91 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +#include <linux/virtio.h>
>> +#include <linux/virtio_config.h>
>> +#include <linux/virtio_admin.h>
>> +#include <uapi/linux/virtio_pci.h>
>> +
>> +int virtio_admin_cap_id_list_query(struct virtio_device *vdev,
>> +				   struct virtio_admin_cmd_query_cap_id_result *data)
>> +{
>> +	struct virtio_admin_cmd cmd = {};
>> +	struct scatterlist result_sg;
>> +
>> +	if (!vdev->config->admin_cmd_exec)
>> +		return -EOPNOTSUPP;
>> +
>> +	sg_init_one(&result_sg, data, sizeof(*data));
>> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_CAP_ID_LIST_QUERY);
>> +	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
>> +	cmd.result_sg = &result_sg;
>> +
>> +	return vdev->config->admin_cmd_exec(vdev, &cmd);
>> +}
>> +EXPORT_SYMBOL_GPL(virtio_admin_cap_id_list_query);
>> +
>> +int virtio_admin_cap_get(struct virtio_device *vdev,
>> +			 u16 id,
>> +			 void *caps,
>> +			 size_t cap_size)
> 
> 
> I still don't get why cap_size needs to be as large as size_t.
> 
> if you don't care what's it size is, just say "unsigned".
> or u8 as a hint to users it's a small value.

The size is small for net flow filters, but this is supposed to be a
generic interface for future uses as well. Why limit it?

> 
>> +{
>> +	struct virtio_admin_cmd_cap_get_data *data;
>> +	struct virtio_admin_cmd cmd = {};
>> +	struct scatterlist result_sg;
>> +	struct scatterlist data_sg;
>> +	int err;
>> +
>> +	if (!vdev->config->admin_cmd_exec)
>> +		return -EOPNOTSUPP;
>> +
>> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> 
> uses kzalloc without including linux/slab.h
> 
> 
> 
>> +	if (!data)
>> +		return -ENOMEM;
>> +

