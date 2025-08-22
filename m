Return-Path: <netdev+bounces-216014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91353B31854
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 14:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06A11BA2783
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 12:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B5C2FC894;
	Fri, 22 Aug 2025 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="adS1WEBo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38DC2FC895;
	Fri, 22 Aug 2025 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866956; cv=fail; b=JZZbyuEa6ZYp1MpnayIda80pWxDzoy+ii9SqsrGFqcbGWI7HeNfW7PzaD4ZOF24P6PiWT/EH+d18XNbL4WyDlcrHLASzP6SMCOf2x/qKORi+C/O3I4VMNbfjPIZkQaIKk0CkefPph8e9l3sRA5jXYg03HMtCCGs/1uFxDDsID10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866956; c=relaxed/simple;
	bh=7nJHtsXvFzwyh8OaqWikdR7p1Yf4+yd/zYfBZ6stzYs=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K8CzEj0D0up+ofi1SzJB4sF64DYAUP0WeUaZo30ep0KRRM4HQuJ7KpOoM+aAFHHg/33sdFsM2iL/yJz3XyopFWzpiGtb+XidjzTBQRVqhqfvMM0khHiujn/b9sEhSQ0phezx8HO6B84R9t6+49Ag8oWGv2Gc9lt8N+C/IF2C4/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=adS1WEBo; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDGtklFqNVGKr9dM2Do9oaNAs34zJvKqX2KmcnMFOpOU7W/89fc2tTuHLSjsCCXC9uTlRy0HD3hEBs6K4ZFQlfRP48TkXwfTrvYJsh+X46Gb6x5n8FIOog8S47w9dCcBpKB+Q1RswE7Z7sDVjyozc6NaiRh4heG2U7OPEUwB2JQE6zrvWt9QFZbWlf0bC8/OYy5J9zfvvoKpuYwJd/IAJgKtRZPJj7xUoYpeFzOuRiog9Zxt85HlQ6p8ZYmVKsarJtAJlq9V9q/mjwkJmUZniv8Xa8zQpM0/ZcDxuziJ88aCXPWvLouuUua9MsiDjZ+/59KJwvf/RBOjNcg3tUnXOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nJHtsXvFzwyh8OaqWikdR7p1Yf4+yd/zYfBZ6stzYs=;
 b=gNtAym5oxU+mVTfYruH/8WgL1fqO7Qgao9CufDRENV3PeXPoPmXqwSCy4Dt/eH/o62vS9WMc/U1JTpCmw4aW8IUu6HRhITIWqBwwzWZvk28cxYHfQlaUJtJv0G1a9zzKGbV1tdcgY6h+WJOO1YZTYy5TnhRH0Z3G+K4PSteDXog+c+VUOMJUApx1cIV5vvzisY18HrFZmsRMeETxnkD5xWMxmb4KK7YW4zRutc7UB4P1CuRjj2vw/kJuhC0Z7Dg8mfqtn6rVt/9jUqvOGv4BOoFhKI0KBtI/CmymZXDtxYi7Lq/1M0iesqFgrAPfduAHoFeDXleCXqg2i5ovNA1iZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nJHtsXvFzwyh8OaqWikdR7p1Yf4+yd/zYfBZ6stzYs=;
 b=adS1WEBoWixyXWVLtLQOlvcDnPFk03Xb6uw/WmodQch4Umsi8u0fJSGmLYcPegPfd1ZZ+i77EP85ScLnHdl9FIqBVEUaITpACY38M6ASWf0KeQCLd6oSTPNjR9+IRgf9YrKYiGjzn8xCKeaqS07uGYEZnpUXtTgLc5Ve9pC/iCnKvaYvZ/57kPXGuXEhkwORSgbthfz8MM9taXxc6Im6ZO4Oa22cKSySmD/Tl9wM+lzk8G41AtAD7Lewv4WTWyO8y5tM3XdLYU2BsnKjZ3VRPlHyOirokyeOpl0IJ7UFILoGwqMUuc7UXx7uVBYv0266xIUnqIMAmagqrO5pwAP40Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by BY5PR03MB5156.namprd03.prod.outlook.com (2603:10b6:a03:224::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 12:49:11 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 12:49:11 +0000
Message-ID: <0f391b0a-6e9d-4581-9f3a-48e67ea90b31@altera.com>
Date: Fri, 22 Aug 2025 18:19:01 +0530
User-Agent: Mozilla Thunderbird
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
Subject: Re: [PATCH net-next v2 3/3] net: stmmac: Set CIC bit only for TX
 queues with COE
To: Jakub Kicinski <kuba@kernel.org>
Cc: Rohan G Thomas via B4 Relay
 <devnull+rohan.g.thomas.altera.com@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Serge Semin <fancer.lancer@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>,
 Ong Boon Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20250816-xgmac-minor-fixes-v2-0-699552cf8a7f@altera.com>
 <20250816-xgmac-minor-fixes-v2-3-699552cf8a7f@altera.com>
 <20250819182207.5d7b2faa@kernel.org>
 <22947f6b-03f3-4ee5-974b-aa4912ea37a3@altera.com>
 <20250820085446.61c50069@kernel.org> <20250820085652.5e4aa8cf@kernel.org>
 <feb15456-2a16-4323-9d69-16aa842603f2@altera.com>
 <20250821071739.2e05316a@kernel.org>
Content-Language: en-US
In-Reply-To: <20250821071739.2e05316a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::13) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|BY5PR03MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: be3e2bc0-4d15-44cc-c7ff-08dde17a4ab8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWtkQ1Yyazd0bkdVT3lJWXNLcDI0ZG5rWkhzK1I0ekNSQVA5bS9Ud29kWWgz?=
 =?utf-8?B?b0JBTzZsUGFZUU5MNkJDeDRNcEFRUURrcjVMMFd2cWdON3Jab3ZZeWVGQjRQ?=
 =?utf-8?B?WEdPN3N6OHZJNzdkL29mcHc2SXpyYStObkdBZFY3OEYvTHpDOHZRU0tPV3k3?=
 =?utf-8?B?bTZ6KzhoR3lFM1hiZjFJRFZOMndpTnFWNmlCcklkek5yVExDYVJodmR5b3Jp?=
 =?utf-8?B?b2R6SkZaeHE2ZXFtWlh5ZWJwWlU3QU5MeVF5U0xKNGJhUmFDNEN6VnlBU2Rr?=
 =?utf-8?B?QjN5Zk1SK21ZdWJ0UG16UGZlMUZINEd5Q1hEa25HbE9BcGtuTTBlLzlQOXBv?=
 =?utf-8?B?b1FOL0R2eWkzQmFGSHpHMUZtalhvVHFJR0JLTkJQUU9mQnRtejB0N3Q0RzVa?=
 =?utf-8?B?YTVjWXh5empWYzRuK3Fta2I2MkxUOW5NTEpjMlM3NS9Ldlp6YmZQdGJiVVpZ?=
 =?utf-8?B?VkgrOVlkV3JjUGxlemtRNERIQlc5U0RzZyt1bHg1QnRHcGFVOUsrZTF4K1lj?=
 =?utf-8?B?WFVRYUJRRVJhb1UzdGpndmlCS3lYZ3NJUzVKVTI1UVJENk1xa1BKTHowbmNF?=
 =?utf-8?B?VkhiZys5Vmx3c1BuRjhoSXVTZWNHVXFYNzNqOSs5VTkrMHoveUZXQ254Y3V5?=
 =?utf-8?B?ajBHZVExaDJMelViU0JMOTRhNWMxZkVPamt4MWdaak5wVjJPQmxZSk1zaW9y?=
 =?utf-8?B?V1h4Qm1nU2pkd3JKb1B1MkEzZnVYbUd2S2wvTHpSTWJOVmJSNHdwZ2U1YWxC?=
 =?utf-8?B?Q0FBNTdXc2JpOXdzNlU2OEFmWHhEUzZ1VENPRFZ1WWYyR2xhSWR2bXUxUWNz?=
 =?utf-8?B?bS9yS3ArcTBKZTAzbVlZSzRTUHlGdy9GWHRacU5Ic3d4YmhqRFFIS3k0cVpM?=
 =?utf-8?B?S082b29kT2VTa012RWlYMGJuZ2E5aElJRmRtdmpyZE1ETFpJajIyMFhrRzJh?=
 =?utf-8?B?T1ZWRG4yZ1k0bG5DM0x1ZFRCM1ErU1ZKRmlJWG5TSTJhWU01U2VoYi8rMW5S?=
 =?utf-8?B?bHFuQjVaVUFJWkoyS3c2T2hKNURKTFVTN3N0Mm9ZdW9YVFJ6VEhab0V2MTVX?=
 =?utf-8?B?aHZodXdTLzAxc2dRR0pYaEJ0RS9ScDFDUHdqakJzZ0MwYXNxeVk2a1JhNlIr?=
 =?utf-8?B?ZkxXUmd4NGxXbmJQZzNna0s2MUpXVjNFTDJBQmJ5aXhuSTFoRkgvUnRFY1lH?=
 =?utf-8?B?cUo0V0F3TytyckhiZ1BtblJFRDdHVEttQnRJMi9hYm5BcEJBZlJPOGNrN1BG?=
 =?utf-8?B?cFZKcVY2Vm44NUZEZS9QQWg2Q0FKcGdYM2VQa0l0MTN2MytQN1hHamRUZUo3?=
 =?utf-8?B?eFNVVmhJdjVPa0FzUnltWkRiV3IwOGJtS2VGR0h5eHRLVklKSGxQMHhRb2tv?=
 =?utf-8?B?dkFBMDJuM0lKemdMS3diaWJUNjduZjdZV0lRNnFtRk9TWHdmRXNyeDNpbFV1?=
 =?utf-8?B?WXMwbUVOU0lYNTRIbWJsY0ZtaUUxRjlzWXRCMGVyTGNnU2dzNEVOckRoNUdS?=
 =?utf-8?B?K21rbHlKWUZWSG13elVZM01qNE9hMUNqU3BSdXpDMFVRTnhBTEJwUFZVb2Zr?=
 =?utf-8?B?MyswWTVBNUV0SUMwYWdiUjlDUEI3VWVTY05CWmpVQWtTWW5lTGNqaGJGYm9H?=
 =?utf-8?B?NmJERWtQLzMzMmhOZ3hpaFh0ajdRN213cmwzU1BUblgvUUkyWG9uUVVUNWdQ?=
 =?utf-8?B?dVFSc04wOGM4czUyYm9PenB1eDFmNHNPL0FSUUV1RFJmcVVodjc0bW8wZnNo?=
 =?utf-8?B?a3hqMzh3V2xZZHJNRlI1cEFRTTAzMSttKy9GSGI5MzZpaDRTemZ4NHd3bisv?=
 =?utf-8?B?UExKOHQ5RnRuZEt0N1VSSVA2c1A5L2J3cU1uRzRYNG9MOUF2ZWtheU5pckE4?=
 =?utf-8?B?blQ4WmwvOXlSbEl3MUNjUi80c3R1VzBCR0pTQXRuSlZvYWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUNRNXZuN0UvbWVEbVFGWWo1aXVRVXlTc0ljZnpGTXVadktzbmJ2MjJYNElD?=
 =?utf-8?B?ODR6c2VycldrVTZtellQc2NURE1jRCtZN0dSRUZZeGd4RENWQzk0WVduV2Yx?=
 =?utf-8?B?NDZSaWRPWUdUQ3dmZXgxS1plNVR6STlMazAyMC9qVmM5NWZiTDlwRzQ0UUQw?=
 =?utf-8?B?bTB0VndDTThUaEtVOHFsbGs0K0hmVTZ0azVPbzM1L1E2dTdZeWs1K2xJTlpH?=
 =?utf-8?B?RU9nSWpPdnZOenNhaUpYTEpmWHAwb0UyRTZPUEZnVVltZlN6K1YrcVVxUHhp?=
 =?utf-8?B?M0JvOTFSeE44L3pORjZHQXlFTC9QSTFPSGVTM0ovcHNFcjVDUDB4Q3RPQVVN?=
 =?utf-8?B?MjJWM2tnbW5FRWR0aVBaZXFpTHYzeGs1WFdGN281ZDFRazB1cFZ1Q01CbVBX?=
 =?utf-8?B?cncyaHhJVDFaMDl0Y0ZTeklwUVphbS80SVhRQWx5djRhdTJqNjVHRnN6dEtx?=
 =?utf-8?B?RzJZa09pMHI3aWFwNWloL21iTVRUdHpMNlJ1UTNJNzlZZktndHZnVFA3aUFY?=
 =?utf-8?B?Vkk2ZEJtOU55TXo4b2QxclZHNzZZOWJvVjgyWUY3aXByTnFVbjJLWk1lMG85?=
 =?utf-8?B?OW9RaHJJeGZuUk1zU2NMOERwdUZTdCt4dkpXUk1vSHNiYnByWUZjQVc3T0c2?=
 =?utf-8?B?Y3ZUVGhULzlZSkdJcGkvaGRGeWs0Uk95YUNqZGkzQ3QvNlZsUURhT1pncWZP?=
 =?utf-8?B?Y2hobUFxYWI0MTI1d25uOUx6ZFNOSlhXQXJOSjhKRnhDZFpJZVNqU1dFRjNs?=
 =?utf-8?B?aEpaKzdoWDFvdVlGNHozbXF1UVVqZTEyMk1BM0ZOSG9DcUhweFVBWkNad1dC?=
 =?utf-8?B?dHk2Z0FYY0JvY21mVEM2NDBma3k2RzQ3ZFR6L1FIbnVOaHNyVXRBUnR2eU9O?=
 =?utf-8?B?QmtFbkR2OVJxc0I1UkFMSkFtN2VKeGY5R2luMllaUjJ4VnZzenV5OXRNM1JC?=
 =?utf-8?B?Qm1lSXF5aEFjQVErY1VaTWZPYS83ZktkOVVkRTdVREVwY1pIQjQxZHkyZ3JL?=
 =?utf-8?B?ZFNROElwZDB1bTNwbldFWFNreWdMdHJFakFwM012ZDJNTE1GQ0FBc24rOE0z?=
 =?utf-8?B?bThmT2V5MnpuQTYrb1FuVmZVNFhKbmhWTmVsam15RzFuWjgzdUdpNzR3RjZt?=
 =?utf-8?B?TlBwQW9wZXAzQmpGWitySVVNZWxYMnliYUJ1eFhOdnBUaThGdHFVWXh5R1VI?=
 =?utf-8?B?ZXBVSE96cVhzQ0JDemdDWko4QU1rMitsdmZNbFFDd1FoUUpUVzdlQ0FGblo5?=
 =?utf-8?B?SHZiSitwRmJRQ0VXS24xQWJQMnNkQmJVQlhjR2lwWVhzdnd3aEt3Wld2c1o3?=
 =?utf-8?B?WW5lYnlCRWJvcWh0VHRMY1lLdmhaT3RmWkFPdDBYZXE0OFZRRWhGTmtKZEZ2?=
 =?utf-8?B?dVprdmF5OHRudFRFWjMyR3ZxT2oraDFzaHFFbjhJNS84bWhIdnJkWFpNd0N2?=
 =?utf-8?B?clIwODVsdkU3VDBCZnZ6RjRvb1NTYjBWTk9RbHFDd1J2eVFCbWc2Mk85bVV2?=
 =?utf-8?B?ejVnNVZwSjNWMjB0R3NKeE0wY0I4cmZXSlI5MHcrem0vdFJydm1WVjZLU2ZG?=
 =?utf-8?B?TUhuNHFsNE1NWjZlNlFhcHJzSk10MTE3b1RtTnRyNDNNVkRIaDRxY1VrNzdy?=
 =?utf-8?B?cWRGY3lPbFVkOGcyVW53SnBTZm1aSC9TZ0Z5dEJrUnRGMTE2Y1dERCtTc1V4?=
 =?utf-8?B?N1ZuM2gyQXc2Z3J0TldObXFOSEZhR3Nid3FPUnZ4a0lnTldrY2dpRVpCQk00?=
 =?utf-8?B?OW10Q3huOEUwL0N6NE05RHUyUVVvYjhYQjJHVktWTHExZXNaQ2ZjUFpqMmdy?=
 =?utf-8?B?a0ljaXdhTURUbDZReTdyNnozamJCUGpBclRSL2NDTHpyWjJrcHU1M1pBT1NT?=
 =?utf-8?B?RkdnR3Z5OVJ6VGRSU2pWeDRURUR6dHowc1VQdndsTk03aTZURVBOcE5meld4?=
 =?utf-8?B?OFBxQXpUdWNKaHJaSTVVeXR6VEZaZUpZejM4YWpyck9tejdNWXUxM1FlYnI3?=
 =?utf-8?B?YWRJaCtyNXhWbjZLNTVDT1djT2FuZVQyRWt3anF0YVBKeE14M1VVMmRodENj?=
 =?utf-8?B?Q2laRFNXczk5ay8yOFliUS92UWdES3R3OThCVGgzNFAyOFpoRm54NzNlVTVk?=
 =?utf-8?B?SVBkaVNTMVpBcHdkTXJ1UmlWbStqelk5T3RvRk05emFBTGpPbG1aV0xqZmlF?=
 =?utf-8?B?anc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3e2bc0-4d15-44cc-c7ff-08dde17a4ab8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:49:11.6529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ft3xtZ0YkUa2e71Hivs7Bna0ia3/8FXnq+Io2YnijMq4hKWft2CGEJmN91HlVUBMSp+fEaHwEm5vL1mOWoG5wSb6Hx10ySUDVO5EMmXYOUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5156

Hi Jakub,

On 8/21/2025 7:47 PM, Jakub Kicinski wrote:
>> Currently, in the stmmac driver, even though tmo_request_checksum is not
>> implemented, checksum offloading is still effectively enabled for AF_XDP
>> frames, as CIC bit for tx desc are set, which implies checksum
>> calculation and insertion by hardware for IP packets. So, I'm thinking
>> it is better to keep it as false only for queues that do not support
>> COE.
> Oh, so the device parses the packet and inserts the checksum whether
> user asked for it or not? Damn, I guess it may indeed be too late
> to fix, but that certainly_not_ how AF_XDP is supposed to work.
> The frame should not be modified without user asking for it..

Yes, I also agreed. But since not sure, currently any XDP applications
are benefiting from hw checksum, I think it's more reasonable to keep
csum flag as false only for queues that do not support COE, while
maintaining current behavior for queues that do support it. Please let
me know if you think otherwise.

Best Regards,
Rohan

