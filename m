Return-Path: <netdev+bounces-254889-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENwBIVCre2kAHwIAu9opvQ
	(envelope-from <netdev+bounces-254889-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 19:47:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB75B3B2B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 19:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75A3D3014554
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D22302146;
	Thu, 29 Jan 2026 18:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X1y1xMwl"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6F02D77F1
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 18:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769712408; cv=fail; b=Wo7XPdmgaKGtT0oN2vX96KNptsSsrMPGIzeQSm1XKjOSs+da/IuZsag4PzoFZIvYXuHCekkyuAaxgvYgorQYO57EkWbWSDiyR7bGizXdGuxHPwvSA/hCHJ2RNCt2cL8S4GAQ6Xl428lqOTYpffHp6230YAABq6WhP9NvBpmYBAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769712408; c=relaxed/simple;
	bh=cCSnmOGNtwAyEqZNKgXjAqOgk56BDtxGMYs2hdaBBZA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IWo9Pe5nJATYu5j5Vws/RV54oBpsAanHPeD0zqu6jUeF1s35NHheXvnqGjwxC1iafPyuHPqFyyy+JeA2kqVGS4rDHJq2Q0kdsb7NOTcAVBWoCaWcTq249nrHdOxibKJJBtADlW5B4ZgiozU+9JfA54BDlIVBHX1qyNIKze/9E8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X1y1xMwl; arc=fail smtp.client-ip=52.101.46.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SycuShY9fLe8nHz3bZDDyy6ExDdH/MWp2s/spHdFEr+/Cs4tPnfxith0OJEBdByG5hgmGClQDUG6dd1oyDv3jnvrBRYjs+Kbn1sdYEcb7ricbK2gosxvU69qDF4LGcBqLte4qXJ+gEQr+1cM+1K58kPwGJIlnXUN9cBUkdEbNE4KyEWSfy/vKH864QaLkp5aGds0pPCAbXpROCbz5bvZbvJbYRMUGycSwwh98j/tCnScHhF6j8pC29LAHTjWcIH1tD7l64aS+QucJ44kms0bVFleTwL8dQxHSCVHSvJePiWvPMgr2S040qyjRx8brLxsudc4CDjEBpltxiCVkja1rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TMrSnokUOLA6abqd/Vth/eElDVDFSTrSd1LYUgxHWE=;
 b=jQ9v/rYqTQdLvfQIvu/Xfd7lDIhXcSzr6m4Cip3KPaJbIk10GnjLdIgb3BihZJKZpSoXnewZnLFz/YL311WT64B7NPJrPAK0BTxrF3eqijEo+QJinNj6yRQ9/zpkf6SscEZeUuxqWY/tFfNTGQ2VvnIIxn1ZkACSIrEkHgnn9XPhuv2yhkQ4DnVrGw9JqW3kAC89j9iV69yws3fPBWaRUZ+h4DFVqesSiqTXpD5Gc72kWQEHj9H1NowlEDsYuZNbFqowWZP+yTJup9XgjvGyh3ex1tF26wfVkXKKlnu1w3ARAhkQtBWfBgtddtcHvnKEPKlW7eLuJyG/qXmGyIoeZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TMrSnokUOLA6abqd/Vth/eElDVDFSTrSd1LYUgxHWE=;
 b=X1y1xMwlaSLxrUxK/luC5WqIWwUFa0iK70r3T8DVd001sGgAvww3XxKmsC3RYoiUyDg3QIIxi33qEZbFx+VkvUW840QBPoG5VibU5+9/y4k1VXKpjg5fHule+f4k94NS/KghrBMVq8ZkOeiWLCdoFtFsILf2DObYDMAmlcRRuMxWomp2JOr4EAybfgjHWAY+y1FewD8eMwPDP1+oaxPBSesfO8XFwn+sB3KZU6Tt9gtqor/mOPTQL10HKghrCyTTs92Jl9UrcTxwSxM0yU/RSHUprTJcQaCAVvZ+61klaseiGD71jERXZGbB1MFw8fI66GwqNK33d1qIaA4r1jhr9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5415.namprd12.prod.outlook.com (2603:10b6:8:25::5) by
 DM4PR12MB6398.namprd12.prod.outlook.com (2603:10b6:8:b5::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.7; Thu, 29 Jan 2026 18:46:40 +0000
Received: from DM8PR12MB5415.namprd12.prod.outlook.com
 ([fe80::e757:d15e:4293:e24b]) by DM8PR12MB5415.namprd12.prod.outlook.com
 ([fe80::e757:d15e:4293:e24b%4]) with mapi id 15.20.9564.008; Thu, 29 Jan 2026
 18:46:40 +0000
Message-ID: <7f972038-3e19-49ef-af55-91ce190ba829@nvidia.com>
Date: Thu, 29 Jan 2026 12:46:36 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v16 09/12] virtio_net: Implement IPv4 ethtool
 flow rules
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20260121220652.894364-1-danielj@nvidia.com>
 <20260121220652.894364-10-danielj@nvidia.com>
 <20260122115857-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20260122115857-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::12) To DM8PR12MB5415.namprd12.prod.outlook.com
 (2603:10b6:8:25::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5415:EE_|DM4PR12MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: 878aeed4-7502-4a0d-e155-08de5f66bd46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RndOMXFab0VjNlZHOU9kUmYrMVFWNGM5NUNTSXkxWStQNDViTzN1RDMrZHJM?=
 =?utf-8?B?WEY4SUQ5cFRMcHVhakxTeTFINVdpcDhWT3NjRnpuQkZINkZpRzRGZGhJdFpQ?=
 =?utf-8?B?TlVjVTdIaHFNUm04bGNVWEpKWUdUSnJmOE5jU3U4MkN6M2orRzVuTVNmVnRG?=
 =?utf-8?B?MFluMmx3T0pxVHN5SWRTcG9ZNWkzYkl0Y2tGK1FkSXZ2eTdHcGovR1JqcTF3?=
 =?utf-8?B?ejV2cWlhYXloY1NiV050V3dBT0JZb1dLdGZFSXhzTWdQWllXSXBQcU1iV1gr?=
 =?utf-8?B?Yjk2THU5b01vc3hrZFZIbEVnVHd0dUREM2FPSmtvelczMjdMZDZUWFcxd21Y?=
 =?utf-8?B?OW9ZS01yQXBqL0dzem9lTFFBcldxNVNYUEdtelhIUG9raVczSkZzaCs1K05V?=
 =?utf-8?B?VzVoN0NnT3BrWVoxSnVQdWVlMVJKeWg1Y1NSQndrZmFUZVMrMG00Y1B4SjZF?=
 =?utf-8?B?bmpZRmhOWFZPWTVZS3RoT2oyaWhFMlZGZ0FwSmdsQjZZcHFLcWJ1QTJhVU1U?=
 =?utf-8?B?UG5iYmZjWElxeU5tbDFYUUEwVUFEblVuSDNVU3hHQnpiSlBIdlJTUk0rL1dr?=
 =?utf-8?B?WFY5VnZjYk1Qd3lvem1HSDdmLzQrNHV2R0RZSXdXU09CalJDTEJSNm5CTk9H?=
 =?utf-8?B?SWZVZ280ejNZNWg1KzBpd1BSTy9odGRhZm16bXMrYlkyMEUzTWJnYzJWU0Jk?=
 =?utf-8?B?cmdjRzM0MjRaT3JXNlVhZmhQcTUwT0lhTnRSTWdkTDZDaXl6clh2QmhYRXRC?=
 =?utf-8?B?RFlUSUtPTGl6VWRjNjl0RVhKYWZHNmNjWmxOQVpJZXdnd0h0K2pLSnczNTJY?=
 =?utf-8?B?emtEeWRjTVJaUVQzanRwMXQ4WktzdGNQeXBOeldzTDB1eGxpSnBQTzZqYm95?=
 =?utf-8?B?VDBMNG9mQlhEYnNXOUFhdUVNcHBnTG1CK2dtTVFhRGl6OVRHbHpXQS9DWCtn?=
 =?utf-8?B?WTRZQ2RZaEo2cU5lcEFNZ3RuK25lZjZBZlY1dk1PYXpiSU5ibzU2V3o4WlRU?=
 =?utf-8?B?NlFMZmZ5RTRjdDlxQk14eThSbzlNckp6aVc2amdBdnNUNVhCRGhHMUJMS0lh?=
 =?utf-8?B?U09WQUc0Mm5hTzVaNENvTVFpak9LbG5Ob1Z6L2FmbUsvVFRIT2FHNE5VOEt2?=
 =?utf-8?B?RnJmOWlraTZCMVV3elFQZC9qbGc0NWhETkpmUjN3NE9MWWZpOTZ4SllST0JC?=
 =?utf-8?B?S2x4VE9aUnhySmJpcks4dkVEMlZHQnVmYjIrdzdhcTdWc0E4eEF4Z04yeTQ0?=
 =?utf-8?B?ZlA4ajBvRFRNWTZxY0FDODl3ZUZURlZMb0xGYy9yMHNMbVBVTE81b1p1V1FT?=
 =?utf-8?B?ZWFmOGpqdnBHSk5DNUtmR1A3RlJZMUtzTU9MVkQ5ams4UXIvcXQxNE5pVCtm?=
 =?utf-8?B?UnBuTzRXUVZMdjdVRTNkcTBweGk1cWhHWnlyb3JYWloyb0xsdzI4b0p5NWN6?=
 =?utf-8?B?eDAwaHBBRmdURkw1WEJORW02L3B4VElYVUkwMW45TVh5UElGN1IvSnU5ODV3?=
 =?utf-8?B?elRnem95MjhTUFNoajBDUm12YWJIeHRvR2xsellWVnh3cyswWjVmaCtMTDIw?=
 =?utf-8?B?clJiUVVjYjI4eEdaWkY5VWNueE1Tb2w3cUFtM1VzT2FVR2dFcUtSRTlhei9h?=
 =?utf-8?B?SkhDY2g4eTBJV253V0tnYzJzbnU3TXBETkpmNmdyM1NjTmpqK2s0SWdZdEdN?=
 =?utf-8?B?WjJ5ZGJqRXBwUlYvaVBrdkkxSWRqZWR4Qys0Y3NRbmw0Nk9FL1dvNTd4NEE0?=
 =?utf-8?B?WTZTK1Z2SWJNZ2VmcVMybzNHUHRtSFBjbnFkK05meFZsbkg1bHdHOWtIdWVG?=
 =?utf-8?B?TnQzL0JxQmwxQ3dUMGJOTEdlWEpMa1JWR0VlS2ZpWUFiVFNKM3pqQWNQVW5R?=
 =?utf-8?B?aEpJSUlWUWVSemhKQ3ZndEI0cUlKYkZhQU55N1hoQTlyNGRsSDFWdG9RNk5I?=
 =?utf-8?B?ZWJ5QUJxa1Q2dkRrSWhLekYyVkdEUDFzOE01b050MFFqSGdhVjR3bzRQeVQx?=
 =?utf-8?B?TklZOVVZWWhEUG5iOC9uVHhvMGM0a1Z4dkxONEh2UzVaVFFsMXRyYkkzaVpa?=
 =?utf-8?B?RndnVW15V0JNNThkLzgxUTRTSGpwSTBXK0tNS0kveDYwL1pmaVYvdU05aUhM?=
 =?utf-8?Q?oPBg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5415.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aW9KTCtTTTVkRHhRS1ptWXRYTUdLN2J1RzE0OWhBOXQ0dU4zVEVQQThKOEEr?=
 =?utf-8?B?RlFVVUlsNVVIVFJmcWpoTVhuc3JIVUtUS0dQWlZ4SkQxQTl6Z1plQ0hNUm9t?=
 =?utf-8?B?WXhoWW1wN1FPUklBVXk5SkVQS3pIUitqQlVNNUU4MzV2OW5yKzVLazNKSEQ0?=
 =?utf-8?B?Q0lOeEw4NEhRZlNoMkFGVWFyWVJ5RnpaaHNUdFhrVEdNTVFvTklKdkp4Y2l0?=
 =?utf-8?B?dTlQWHdGb1lVTmcxMnJYR3NhTTIrZGVidjZidmhVL01RMVptNDRnN0pFTjRy?=
 =?utf-8?B?eHRqNWZvWnhXUGVybUt0dmNZTVFLQ2tPTmcyNUU1UENDbENCOElUaERXKzl2?=
 =?utf-8?B?dkF1TGpVODJVejNaQUNiNllJZUMrTVk5RUo1MlRpQVIvaUtPWU9JWUtRWHVi?=
 =?utf-8?B?ZzF6M2M4WjVQMXFrc0xlTVZsZVJENkpWUURnQ1kwZFBTV2JTVFJ4Y21GMlJE?=
 =?utf-8?B?a1prUVJaRUpYcW5qblBjY0wrVDF0SWFNeVViYUZER1NGRUhGOVlaV1lVU0lT?=
 =?utf-8?B?bUNtVmVwcUFLTjdzeEE1WGZSZkRGMkJjRXBPYzlQZHlZOThWemtRaUp4Qjlj?=
 =?utf-8?B?SWpWY0RtSmVCRlM1WW4wOGhkaGVZRlBGd1hjMnhiZUtGeU43SWp1d01QdzhV?=
 =?utf-8?B?dTFiOXFoV0tuQ01wbGduRUo4cHpGVDBlR1g2MVZ0Sm1OQm9kbExPcHJ5bVQ0?=
 =?utf-8?B?RjFTUGlDOThqbGlmRUZjZkVsa1NIdG15SXZ0T2M0cDd2VmdTUjBJUFdGMFZ3?=
 =?utf-8?B?YVU2RmN3NFhoNkhkUFkydnNRdmprNy9PYU5WQVlIbDB1Y0J1VlY4RDM4eTBQ?=
 =?utf-8?B?LzBwWkhlelN2RnQzYkFzRi9QTVh2bm02ZjVYRWttMDdodjFOZGxLczFTZU5B?=
 =?utf-8?B?QWVpOUZtclhPZVR6UkN2UWNZY252bnZaSGpXSXFQNk1XRGlPM0NFYm8zaFlK?=
 =?utf-8?B?WTU5R0RROGIzVWo4dXJXNHczdUxEMHY3NWUyVkUxbzRoSk51YkduSGlCd3Va?=
 =?utf-8?B?RE5CVU0zeGE5Q216cjk1dlErYTV6dlZmNHMrYjdNajQ1UUNPd005enJWQ1Vs?=
 =?utf-8?B?QStReCtBS2l5TldzTTFNRjVoclNvNGozaWphZ1V1T0MvN1VVVXYzT3ZjVEpz?=
 =?utf-8?B?K1RkZVhIUWk1TjZYMlp1bkZkUElObUk5QXRKQk1FNXpUVHNHbytVV0lyM1Jl?=
 =?utf-8?B?eGtQdHplSjEwcU03cG14Y2ptOFgvRzNsRXRQYlZGQzdiYnc4cE90ZFppVEV4?=
 =?utf-8?B?bmt6eWplVDlQVFhKcExZQWdJclRaZ0pzek5YUHk4TVhWdmtLRGpmNTR6Yjc4?=
 =?utf-8?B?OEkrSWk0dUVVS0h1a2hSYzFnOEQzZmMxaFN4RDl0YUcrS3FIanVEMFRkY0Zi?=
 =?utf-8?B?bkw1U2Rha0R6UmE5ZmF5UU83MHpEbTVubG5TQUVYVHJUcGRyYzU4aVJYbE5J?=
 =?utf-8?B?REhwSWFDTkdkdTdjWEFFRnhWYUJQeEw5R3IxallhWThBdTMvQzNKMmRDQ3pQ?=
 =?utf-8?B?MDRvU2I1dlIwNEhkNk5yTFBvOE01QXc5VFRNdzBMTlhacjc1ZEk4NHhaZGlN?=
 =?utf-8?B?aHFLOGUzVlZ1N21kKzlQajVxSkJSVWN1SFk0b1BHcTBKSmxWZHpFUXlKOUFx?=
 =?utf-8?B?c21DWmUzN2Q1Q00xSUpFTmFTNUJOVll4dWtLZzZGa2RYUno2YzFiUVB1R2xW?=
 =?utf-8?B?SGZsZUhSb3dJRU5nZSs5SVR5OUE2WnppYnJzM3RubTZtaHR6MGV3ZHZCcU1R?=
 =?utf-8?B?NmdOVEY5SXo2U01IR051cGhEYkZ6cGs4WHVQRFd5QzE0NEYrcW9vRy9MRjJV?=
 =?utf-8?B?ZWxnQVQwMUpXSnJUQWQvSTMvRmVFQm5za3c3N1h4RlFlN3hMUnkrek0xcTh4?=
 =?utf-8?B?TExLQjRBQWp1SDduVjIzRHEwYVNpbFBRM1l5emNZMlYrV3hNblBCNkdiL0pk?=
 =?utf-8?B?SVBIVlVsakcxdm5VTWtXOGI5Z2dRTVFVN0FkcXFNSmZhRWFGZ3JJNmUxVGhG?=
 =?utf-8?B?bnJKOXJJMjQ4Y2hROUNoT25qTjc0WlRiWDlIUlFxemt5QzNucFE3N1NleDM0?=
 =?utf-8?B?SzQvWmF6bnF2SXRDY1JlMEwvdTVKT1gxc3k0M0szSktkN29rTTlxci9nUDhR?=
 =?utf-8?B?UnhkcTUrQVY0czBtUEsrSGgwaGlhR0dBSEZESkRJL016bVAvdGcyQW0vdjRK?=
 =?utf-8?B?Z29xQUx2aUpUcnR2WXI1cmhPaEY3K24vekJYeS9RSHYvRkpPNmlRcmJDNkNx?=
 =?utf-8?B?Z1g2emFNUThnVmt1eWNhTU1JK3ZXNExTUDlsdUduWjhyOVl4Y1pGSzRpcnpq?=
 =?utf-8?B?MTNpSk93eFE3QXNuZURIRzZ4eHg0M1h0Tmd2eG04L1ZuNUQ3amZOdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 878aeed4-7502-4a0d-e155-08de5f66bd46
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5415.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 18:46:40.1718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6SUMz+E2kYR8cPjQAoqF5Mwx6wy8P2rj0Zw7i4GUqVHAIiJy2FDEeznj6iUtAoKRpUp7Gjxzo0w5DAGfuL1ZQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-254889-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: DCB75B3B2B
X-Rspamd-Action: no action

On 1/22/26 11:21 AM, Michael S. Tsirkin wrote:
> On Wed, Jan 21, 2026 at 04:06:49PM -0600, Daniel Jurgens wrote:
>> Add support for IP_USER type rules from ethtool.
>>
>> Example:
>> $ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action -1
>> Added rule with ID 1
>>
>> The example rule will drop packets with the source IP specified.
>>
>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> ---
>> v4:
>>     - Fixed bug in protocol check of parse_ip4
>>     - (u8 *) to (void *) casting.
>>     - Alignment issues.
>>
>> v12
>>     - refactor calculate_flow_sizes to remove goto. MST
>>     - refactor build_and_insert to remove goto validate. MST
>>     - Move parse_ip4 l3_mask check to TCP/UDP patch. MST
>>     - Check saddr/daddr mask before copying in parse_ip4. MST
>>     - Remove tos check in setup_ip_key_mask.
>>     - check l4_4_bytes mask is 0 in setup_ip_key_mask. MST
>>     - changed return of setup_ip_key_mask to -EINVAL.
>>     - BUG_ON if key overflows u8 size in calculate_flow_sizes. MST
>>
>> v13:
>>     - Set tos field if applicable in parse_ip4. MST
>>     - Check tos in validate_ip4_mask. MST
>>     - check l3_mask before setting addr and mask in parse_ip4. MST
>>     - use has_ipv4 vs numhdrs for branching in build_and_insert. MST
>> ---
>> ---
>>  drivers/net/virtio_net.c | 129 +++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 123 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index ba231f10b803..7ce120baeb41 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -5818,6 +5818,39 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
>>  	return true;
>>  }
>>  
>> +static bool validate_ip4_mask(const struct virtnet_ff *ff,
>> +			      const struct virtio_net_ff_selector *sel,
>> +			      const struct virtio_net_ff_selector *sel_cap)
>> +{
>> +	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
>> +	struct iphdr *cap, *mask;
>> +
>> +	cap = (struct iphdr *)&sel_cap->mask;
>> +	mask = (struct iphdr *)&sel->mask;
> 
> 
> this cast is only portable if sel and sel_cap are properly aligned.
> 
> 
> 
> Because if not then at least saddr/daddr accesses below are
> not portable and need
> Documentation/core-api/unaligned-memory-access.rst
> 

I'll fix this here, and in the next 2 patches.

