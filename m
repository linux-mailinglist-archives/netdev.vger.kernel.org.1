Return-Path: <netdev+bounces-62441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE96827492
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 17:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9614B282FC1
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 16:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A57451C5B;
	Mon,  8 Jan 2024 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o7aTp9rq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE5051C37
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JE3ZF3h78uhK3gpGK7vTxSKf0coRe1y55vAY4nVn2pi+ByxdSHuOpcAd4oFRiRgTX1D00NE8xdjakLyEJM48EG0IUxIBo27cxYo83DLSRL1T0UpicLloOAHady9Tzj1w8CDHKO7dqTABB5Pu6HZ8re/k1uuhU5/PzAVJHFeQFu9Kelb0KmrEa2erwnm3LOTyZXFzm1J8LZ5eC/d9G1bx9S6pdE/Z5grzfyjyjRIXFT7P8ry8O9lVkKXf6Zi9drYbVLWMvXeIxhZWpLWIx4+eSDLJEW/ZHqipvGkZ7xvnTu9LDK9Nf1r+K4mqKsfSD360wrzDhSwTYpb2s9odv32gig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kQBuybUhlq7sd91owyje2s0AlltEhRX3MvZ3/yX3FI=;
 b=NbVKScMktOSGie11hStsWumAmoOhB9AHm//dVz4o0/KpCaLVubHZfKzURBqjfIXCpyiIO9p0SR7LaUgVmUKF0kKUKO5CitxV/Sjst5UoKW4ex9TU7qS3xvJteXGITSUtRHJrmBj9igVcm69sqxRSTxHIYfa5zbo9a7mpzvE2Ru2oBGDkp+UDfV8oWP7PFlX52wDZUf0QprHKGxlcxKQmog6apbTzm1iwyzTOTQWkdyaHTz6cFR736DzkWjCK9LHvaGIuKQrXph+l527toCp29judar4cxdcVFA4HVPCKTvivO5ZaAzcuQbLR8sfyYhkWNdoFx+jZi2dkg/X9X4k1TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kQBuybUhlq7sd91owyje2s0AlltEhRX3MvZ3/yX3FI=;
 b=o7aTp9rqMqdz3BNISmPNoSkgCh43EL5qi3W3nvX2b65/3XYcYTmV6dVEyKewkrGvyLO6MGP3r6A63tyqx0bHDSYXq+Voyf2OIW+IQdWhe2/pMvvx05l1t52FRmpzrdW8lOLyvVgB/C+tNgmnKuZM+e8OKFSFXdSDiq2udLlpbFaBWkPYqCN3csU15Gc2kop9f8fNdPxp/SHb4xprm+Lnhafbkc1mT14Xu+hatVhDGueSPKfTxjq1brKKTQANUhBuvHcPtm+ODE/3A3J59Yf9quWLN/94SNM0jnwT6NHg1B5knGoGmDtcmkYddQmJvIlGQs3Fp7o2z6ZwApmjReJogw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 16:00:18 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::1442:8457:183b:d231]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::1442:8457:183b:d231%5]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 16:00:17 +0000
Message-ID: <5bed75e9-84e5-4e58-bc9b-45130bb2ea26@nvidia.com>
Date: Mon, 8 Jan 2024 18:00:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 08/15] net/mlx5e: Create single netdev per SD group
To: Mark Brown <broonie@kernel.org>
Cc: Aishwarya TCV <aishwarya.tcv@arm.com>, Saeed Mahameed <saeed@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20231221005721.186607-1-saeed@kernel.org>
 <20231221005721.186607-9-saeed@kernel.org>
 <89d33974-81fa-4926-9796-31bcd6d6cdc4@arm.com>
 <daaff866-b5f6-4fa8-a35b-8172d9ab9929@nvidia.com>
 <083a9b9e-65ce-439f-8dfa-555da30ca607@sirena.org.uk>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <083a9b9e-65ce-439f-8dfa-555da30ca607@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0500.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::19) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|MN2PR12MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e1a3b2-6c11-4e00-20ce-08dc1062e89b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3R7dWPIVzFobQ8lEtNHIr31YHg77vINX6sE9zQh2/aS4fwoYr73k27DZNyJcmyni4UMXRhrHlUJYWCc7am2DbVerUfXlzgJbnJzXISgPlpa0jkKyoGbfPLUMriT46L/xZH992cwu4cWpx8CsLNSxAlwMsBtsq5mvZkG85grKz1r9tMdnomiVth5u7DHvId/XG6K8jsR4nBelVZ8E0Osq4ws6/zJEFfRX/k7yFDEhJ/KuBDeYEaPX9f/N3noGDRUzhKgGMPWr7/GAnibsv/yXOWJewPkh9JqH3mjw86YrSd8OlCffLs+6ETdT8FOiNPs9FCdEF/p4R+r3rpw14Hhm1CleBTd89oVAEawnOxsWpsivlrnMQGsf3dYUzIOPwlrIowasGFtTFicmDJKcIcR7zIFio4VWlgNlrbC5T9B8Te0VMOAZEbKee7yOz9i+sEqDLfr5cMw806g2Cqf/btitEgVdEoTXiWR29spcxLPq9SVOFYWw9gv6rGvSqs/1U5aRT/A3rdKUgN1jpFyTnp+anOPobW51W1obXm5vhm0iLPFm5/Ba21Hk6AU9YFkNNqIlTDFFqPE6ODRO4FgGrc4nWracG7SgUbticwh18NZ3rKudxaK5MQALpf0EQ98SBACuNgUEz2S2uOAxL4mn37BbJQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(396003)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6512007)(38100700002)(26005)(53546011)(2616005)(478600001)(6486002)(6666004)(6506007)(5660300002)(2906002)(4744005)(41300700001)(66556008)(4326008)(54906003)(66476007)(316002)(8676002)(8936002)(66946007)(6916009)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0tTTG1BU2N2aEF4RXVvMjREbUFQaE53dHhSemMxMWk0dEpiTHd0RVVpL2tK?=
 =?utf-8?B?Yy9pVTcxaGxNSkxhajVWVG10UjdzRG15Skg4ME9MK0NVSDM0a3FDRndnclZt?=
 =?utf-8?B?blNXUldMT0tEY0srYU1vMkhWUmJqeEV1UFJIbmJjckpNWE9DcDZOaU1hNHBY?=
 =?utf-8?B?ck5tSXBVMEtRYVN4L1hiVnk0UmgySFpqTW4rMGhkYTZqcTI2YS9raVYrZEdQ?=
 =?utf-8?B?R2RCMi9tTEdPcjVSREovZVZ0Kzl2dHhnZTY0ZVhtRzhuKzl3U1dDZHkyUndx?=
 =?utf-8?B?bkJ3WTU3WE1GdUtYcDJUdGk0Qmo4MGZhdkpTdHFxZXJ3TzdhcVQzT1NoYXV4?=
 =?utf-8?B?UzNVdlFWNmFCK1FqMDZLVkxoUHhjYVB2R0hEbU1tOTAyczRsMDBjK1hJVk8w?=
 =?utf-8?B?RFNxUGNZYTdyOVVDTzBKOWtrakRQZmM4VzJyclZzOWZNV2Z2aW0wdjlSQVhW?=
 =?utf-8?B?K01iSmI2bnJmV20zRnlySFFxSUlNVWt1clZaL0Y2YVhScThucWw4c3BCdmNJ?=
 =?utf-8?B?WWZGbERkdHpNSXh5aDhJUTN0RHBGZDdpcGt0WC9YWUxwRGpaODFNR1J2WUNa?=
 =?utf-8?B?OVdxSk1qZUZjc3dnbXA0K3dyOFFyd0RkeVZmZTFQbkZYV2QzazhlUitjbmV6?=
 =?utf-8?B?b3hGVnplUzUwMVg4THFyRjZMdVByR2lvSjA5TnZlbFJybjFyTHBLclcwZ0Mv?=
 =?utf-8?B?WlVnOHhJMG92R0tBTnZEeHdrdlNSTjNaeVdmT05OdXhKa1NHYmNmeTY0bnEr?=
 =?utf-8?B?WmtoUUJoSlpxbll6Z0hML2VkWUp5OWNER01OK0xjMFB0TXNhV0JQay8vUFV3?=
 =?utf-8?B?Y2hONHh1dUpnOEpodXpPbUVZTlpnK0k5N21HbnlReEtENXlJbEljVE40UE53?=
 =?utf-8?B?UVFTNXhrbkJHQ05UcWsxUjZnL0MyTHhkLzJmRHNqbmtENVFOK0lEK2pxbE9w?=
 =?utf-8?B?Q1BXUTRlQjM3c040Z09QNTNxS1FFMXRRQlc1cjNkYUlBMHlHUlpPZW84KzhU?=
 =?utf-8?B?UlFhYkJ2WlVZeXBWa252d0RiQThqRCt4TkFaWUM0Q0NSY2R5NUdvZ0FZYVdQ?=
 =?utf-8?B?NjFxa3ZJM1JGam5FUzYySEY2cjdWUGUwa2Z1NXdKZWxIYTVhcDFIZVFaRWVr?=
 =?utf-8?B?UlREMTQyYjBtVHNHZVlZZVpKQnhEYXRnZ2dmN1NjNDFuUENoWEE0YTF2OVAv?=
 =?utf-8?B?MjJLZ0YvVmhhbWw1Unl2cnFBTlBGUElQV1Z2eksycmc0Y2ZyMmg1dXlBcmdO?=
 =?utf-8?B?dWtrSjJqYzdOUDVEWkdiUjlCTDFTOTlNdUphVy9wNEFSRTlLeXVGc1o2Y000?=
 =?utf-8?B?NXJiNVk2NTV6UTN0M2FBb1QxcWVQTlpzUEtSTXdzQzN4NnFoVlYzWWxjU0lw?=
 =?utf-8?B?a0lJUEpkQVQ5eXBEdkU4ZFllL3ZNOUliTUJhaUFDSHNXdHBRd1pneCtyWnF5?=
 =?utf-8?B?cGZzZzc2RVZvYVNMNWsrb3BqVW1sWWNMVEN1V0tJSEM4QVNFV1FrQzhSdk5N?=
 =?utf-8?B?SnNaRXhiWkRNaG92N2c3RUJvWXNMSmVqOTFOU211R0xxYTBJVnBVNVFzZndu?=
 =?utf-8?B?WWNRWVJQUHp6YmhKanVESEFtUStvcnNjTytpeXhHcXkzeDdZbStvQ3hsMDFQ?=
 =?utf-8?B?OE44eWFsNU9IWDdWYk5MaEsvYUVsbnoyMVdOWmZ1WjBIQWtmOTJpZVBZVTdJ?=
 =?utf-8?B?Wk44UnU3SEJ4bjBFcnJvU3FiU3EzZDBjOTNLcm90aVA4WTNDbnRpbElpUVRE?=
 =?utf-8?B?MXdUREptNmdXRHBEcEJSMnhQVjJLRC9TWmZpNHkvcy9sZm50by9iUDFqU3pP?=
 =?utf-8?B?YlNUSXRZUEtKR2xMTFJnd3JZSnZOdnVoS0NuQjBlNmFVaHo1MFNhYjNacWo0?=
 =?utf-8?B?QnBMYmZuMnNuL0UvQ0VtWGE3d3puakRSVTFkRU11SWQ5dExMZTlWOVdPcUNU?=
 =?utf-8?B?bFVhSVhLVXB6ZGxXbi9JWnJXVTM2b0NRYURvRlpmbnlRL1VwOVlxSkNCOWRH?=
 =?utf-8?B?RThYY2h2WStGN2ZUOGNmbE5PZFV4d0l3blBpRGUxVVU2V3RwNXBkbWtLUDh6?=
 =?utf-8?B?OXZlSmN5RmdJSHBkeU05cFdkZzVwNVNzY3hRWU1abWltK1dqT0ZhRHRPUGhv?=
 =?utf-8?Q?GAPgcc71rGOUSC8A33CJBVRi+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e1a3b2-6c11-4e00-20ce-08dc1062e89b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 16:00:17.8822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVyBPogJtC3hYXk0YaI+XfKOv6hL+hPQFZDZEKP9g1kmqZz3xYAmBKj6U3B6CucP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205

On 08/01/2024 17:54, Mark Brown wrote:
> On Mon, Jan 08, 2024 at 03:50:09PM +0200, Gal Pressman wrote:
> 
>> We just stumbled upon this internally as well, I assume you are using a
>> (very) old firmware version?
>> If it's the same issue we should have a fix coming soon.
> 
> The firmware version announced on boot is 14.21.1000 - the rootfs the
> tests are using is based on Debian Bullseye, the firmware will be
> coming from either there or the UEFI image on the system.

Makes sense, you are using a fw version from 2017 :(.
Anyway, we should have a fix soon.

