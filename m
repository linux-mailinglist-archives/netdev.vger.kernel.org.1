Return-Path: <netdev+bounces-145364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B44B19CF431
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 19:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB25283CAC
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 18:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B77D1D5AC8;
	Fri, 15 Nov 2024 18:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GPH8zr1f"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1421D54C7
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 18:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731696248; cv=fail; b=M9B4wdhumlUH7uqpUaMg5tMAL0iERjdMqFmqelu5n4QNPgEoGGqEOCR/gDk9Pi2qxtdvUWzBWAe/bGLLNpnX+0y4GcFHP7hhqnAtjiNMQiX9jGsveMiN83aFOSA3Uj1+ahYF4IfjCGmsPQeBIVVKAhU4gO31APo0OBabwlC+Fpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731696248; c=relaxed/simple;
	bh=zgw7EK1jhtTTxbfpj53P2X/icSsWbLowTJUIYXYV62Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ED9RNaeFApgaOi5lG915dzdJ+SYDy3ZyyIGxt1fU33kguIMeGquu9f29E3Zv52FLS3kYOGm2kxfB8pwb5O67YTQy95DFFElEHRibmL87oMjKU1I3ZEtQ8RNGm5LZ8bT5IYUfnQYRW5CLAfW5yXaPJ4MbrNeIMT6m+YqiT1A64mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GPH8zr1f; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYnueUt8nBEwjYzexO0f7bb57SD0ak9VFYXpGRTEVXMHhSjL2hDOjZglRicBfysdZDPzNtNhW6/Rao9kX0rmx8WlKVXqiCAlm3l3nWcf9rCvzReQLMLn0ZrVzKQOiNmnl1kr5rR6uAou5ZbXSU2Hhmlp11RoPnzMrsRWrLT3dIU6Iquy/6bNFXXpMOtQd53z+0dxJK/JdyLWBd3NuiBljTuAlCBXYrg6CoePWT8nOjMqTC+rhciQNDZcMsTsPX9OqU6beqApHs0kp0LSuvkh3wFTbCBHX3DbT7KDjDY9zzAENtDIY5qcYLn9pN5xXdEb5iE04jYuaFrv0NP80NofrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyBr6NfHPe3CGZOIVwIh3KFl9AawuoMAgnO1b4ENM4A=;
 b=dYOmNdOYMVypcbH9+8fC9XZ+KlOW4TFCXLyoF7HnLWHdO40cB8zQFULtyQCPLaOjpll+zLWJPnpXkI1dQXdhSHk0aBQuBdrftYk40RpnMaNoWMN2R5vIt3stCMv8dO+dJrt/M2cZI2D9hiEDCE/xFLLtiqgz1GjXWO/ZX2AxCHxAE1Zlp+eSVDQ0bwNQ96ZreG5LTSMf++0uaDHpQkTqVZHsFV9MvSPT3zHunbLTYyX/KnDwVSmDkLA7A+anYSql2QW4A2Zc6g6cEQ2lR4+924z2NzINoU5DKwZtP7lyTqzEsrFdRvk8rCjQesVXKfNx+m0oEJgCCVi06MIGPR7Rkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyBr6NfHPe3CGZOIVwIh3KFl9AawuoMAgnO1b4ENM4A=;
 b=GPH8zr1f9UW/CN8EiSxshoZXjTbwrlN52FV8IoTQtZcZnqaVjqPQl2yuC6O4VCh9JNqcFHJaNqnHmyIHWARTzckgkXV2J7l7JRRpq3Oo7VcYP0rlHZvvn6OfHmEXr9hFUlXTF/Mj0hRmgxpweW1CZvirj+9RlEo9jl4uLZUg2181WDbs7EcQCJD/u2P8FGpmkeG5N7clxAL4jNg+rF14ZkS1w3QCNua1DmkEuKJSknBsvnfDGj5xA6B0pFoLhT5WWawzJPM8od3TcF/Eh4QSI3aZMNR49ZZzbQq4b50KxYntwG6NdgNznmClJwuXtb2vPLgZQeW7RNNp4clJNqqnYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7665.namprd12.prod.outlook.com (2603:10b6:610:14a::12)
 by BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 18:44:03 +0000
Received: from CH3PR12MB7665.namprd12.prod.outlook.com
 ([fe80::c0d6:1a89:ac1:9cd1]) by CH3PR12MB7665.namprd12.prod.outlook.com
 ([fe80::c0d6:1a89:ac1:9cd1%7]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 18:44:02 +0000
Date: Fri, 15 Nov 2024 10:44:01 -0800
From: Saeed Mahameed <saeedm@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Saeed Mahameed <saeed@kernel.org>, David Ahern <dsahern@gmail.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] bash-completion: devlink: fix port param
 name show completion
Message-ID: <ZzeWcUnoUGpIgNbk@x130>
References: <20241115055848.2979328-1-saeed@kernel.org>
 <ZzdFZ1C1te_eEQ5P@nanopsycho.orion>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZzdFZ1C1te_eEQ5P@nanopsycho.orion>
X-ClientProxiedBy: BYAPR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::35) To CH3PR12MB7665.namprd12.prod.outlook.com
 (2603:10b6:610:14a::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7665:EE_|BL3PR12MB6380:EE_
X-MS-Office365-Filtering-Correlation-Id: 69cec37b-5ba2-4bed-73ce-08dd05a579c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HBKNt2GoFkf3SLRx3IHGygss+u9ybyeUw4fouwuVd4oncny8I6+Np9aj+jMq?=
 =?us-ascii?Q?ySp502TbSQ30lJs7eYEqQ10BSOPbaQGYnfGlraCeaKCHZtVhDHSrGbXYby2X?=
 =?us-ascii?Q?7yrrsdKk6V6sFCNqP1hdUwyB+4xv961+KBH3iuwArSScI+XMK1gryKfSQ0IP?=
 =?us-ascii?Q?GvqM9C5quhvT3qVMIRE78APhouYLDFVq79TM22gGTNGnjbeimryHKUoxTfvS?=
 =?us-ascii?Q?0kA7f8jUNRXPxZHtw5zgmYdCe1iUozXyzhegyDsKxmapMpVMyqpKXZhGNDHD?=
 =?us-ascii?Q?uMEekR11EHq2dSc9I6i9dkDrowQoJu9DwgQWFAyM99BQAAGVVhGz4+CwDyYu?=
 =?us-ascii?Q?MAf9cdSbPgprgUh47dKZxyaxoPhKDTOO/7FM4rhWfniw0aDPBx7TXm5XWfNU?=
 =?us-ascii?Q?fG1BAfHlE6wVUU8kaWswZDrKEgRFburAIHHsYYTtoEToDtF9yXExl/senF5a?=
 =?us-ascii?Q?VTJuxpkhC9oXORGHh1TLhFOKzUSoSTTu829/ki1f9zK1BSSA99edpC1w75gq?=
 =?us-ascii?Q?BLtIj73XXwDuODoVKKwJygC3yvmY7uA/h4wGO6hcKqjAgixfjtNGOKwt9ljM?=
 =?us-ascii?Q?hsNW28f3EZd5ZpzvCVW63BQI2z6QVnEMSxlYqtDqdzJ9hvgNrTCSIS3ClNnW?=
 =?us-ascii?Q?psW46QFw+WuPzFKUwY1iaMVRqLN2sNj8Df1AKZT6FSvqXQ7tEO4Mjsgcs493?=
 =?us-ascii?Q?ipAMldkJZIDoCKMG58rAk15khPQ545hh1HBY3nnZI5esn8sStH8NTGASVoqN?=
 =?us-ascii?Q?HSgTlZJjueCPlHHbz3UdkPS0ZyFeveZkLjEbXOdceIdWC5SgVD60sTCifxuS?=
 =?us-ascii?Q?uWn1XnISPYc6pclbM2xK53kpy5Qi8jmApDQdVblMguLIU5ZMtQe5w1Zilv9+?=
 =?us-ascii?Q?0eZVK+Swx6griGr3dwuU+1wONJt5Ha0g+IkYAR7p5KJTBE7axhyiE1JASSKL?=
 =?us-ascii?Q?GyC4decYRpg76IlrhjzgZKptZQnYuc/NenYscgvCwPJ0iIdZfLOvMHIjwXYz?=
 =?us-ascii?Q?Em02W9ygFjHKFIBkKcffOh2gx7eI8j2mD966WJ8MEzfynWuBGnzV/XfRNiDt?=
 =?us-ascii?Q?K0/7elfD1K2otziF1LMPox+PTjcT6E6Ryxu/TaHlta85xZ0MWgBuGPx+5vYv?=
 =?us-ascii?Q?3xq1IachsR4TZkk1prJvmF09X9tprUTz3S6KzZQUhNvob1ZHgYhbx/1T7OlI?=
 =?us-ascii?Q?YM0bWIySYmSVFmjjnocw/gf1CaElQFzjJKHIFv9XS6aM/7h8g7QHmlyudMRw?=
 =?us-ascii?Q?DwpFBlUmrl2gM6dTYbuTkBa6pMtAJ5sU3ExI/EikzzCk0o+S2BcZ7/jpYsfF?=
 =?us-ascii?Q?fzkhWxXbgvat+EAV7FBdX+h0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7665.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2eVEyHxYHMX93ZRBfnQMTUMynrfDgoJQglSHwfebfjrSnX527BPORPi9FPQk?=
 =?us-ascii?Q?5Ct+tXdZlOGqDu6LVmu8VzEztlC1KIurZfLTj4e7d+21K0k4dTdIcaeYIKDp?=
 =?us-ascii?Q?X1OPa6C7TZ4X+juZRC7wR0orC6LPr7I3V6N0Dsw3VcW9jHHS8qqPcRZR9C/e?=
 =?us-ascii?Q?vQkB2GGP1XaY0Lh5pgjn43eK6rMlNa5+aDuS9Z4YkK/iunWXAADczaX5IFOI?=
 =?us-ascii?Q?EdWQkezeHeHKhrmmehkhUymSwdNYdTSEZdAfXrFVNqsaeVEKjJqPLug4n83a?=
 =?us-ascii?Q?UaR5k4bKIqTOJ+7tna8sOrsKpvJcf8lhh4dann++6i1esmaT96v/ZMi3Do+8?=
 =?us-ascii?Q?WYllLbDpQNoNoRxKEna7Bfy1ptPola5CDPrjbVFFS5DP8SQwtSUzN7bIpQut?=
 =?us-ascii?Q?UAv3x8V3dDm+HFG8EtKabY90f/0ljAAufrD2RoO/wmYvb+eATiylUAd7bmrr?=
 =?us-ascii?Q?LRVqWQQc1GSdw9c9Du7fvYOchZa/qsXvepH83nVLhAuTvtdZ+dOd8i/GYOuj?=
 =?us-ascii?Q?RGKqMpgRvlq6cDrX7S2Rc/PLV/y0FdmSOrolNHkwOZqdieDV8d+NIBWab8ni?=
 =?us-ascii?Q?Ns7Vzx3on07GNqIs7rtzZ0dQhePyLyM3oUyOA9tJlSJ4BeaAivjsliz2Eokl?=
 =?us-ascii?Q?aIQB/Cv723wADpYM8LnKEAa86zuFQLYJiUbpgUUqcvPupWOTbu+kD9kDlRf4?=
 =?us-ascii?Q?3kRPRbj8jGsy3ymqmVsZJjVFbsX8kokB6X/hdGP5+DZ2c+0uGN/+OzrhRpfw?=
 =?us-ascii?Q?in8wNgwmla2nS2RxtL07UdmN99Jwxq9/EuvK+Pt2P0g8luzrk0Ps5e4fKDHf?=
 =?us-ascii?Q?U/kDDysTI0QxDEfUUVgASrOMm2zgwDmixNacDGfI9e8vwVN4OYyj9vx+4L1v?=
 =?us-ascii?Q?pz8/z+6NinLpinhgF7pvnxTSY3t8Rv8pi+ltf2MsTNkvbyjZBQQMpLK+OHMl?=
 =?us-ascii?Q?Ck8KchHTHyAyJf/fNwb2XnNXmPhfrJmMaGh3L8nBW9hcBjEnElP+I1MS/0j+?=
 =?us-ascii?Q?dXgKsIijqF/cVTXw5twgPPxB+5mP4H/clN9mJa1NxfvwQj9LtHB/W5MYGzSb?=
 =?us-ascii?Q?ZTxzniZKg4zRH9GDEMU4mgb5cOFlYHgItioSHbisMYMmXdqNcgZkh6TTgj3C?=
 =?us-ascii?Q?RK5TwmBXVu8q4h5YL/ZPa/VLO/1qaJZgoW5M+huTO7ttezsf6u7p73ZWHt3E?=
 =?us-ascii?Q?NFk/fM7i0HS275vZWSIoZpsf+OrVPMdYPgrgpSXZ+Rz/f/Y3V0NvaioZIqp4?=
 =?us-ascii?Q?kw3IC2WdwLx5dUAjZSVdaZmnxGm48kf6c5sWgU4OHRxeZ+7iWHZ8Pr9TbU7K?=
 =?us-ascii?Q?AEUEROO3FTN3hXiZhxMdd1zOG2/jdX864oXQckk/5GY91qWOGBCejn21eEGd?=
 =?us-ascii?Q?a7maqagUxYmQS44ZY/fDFgaoz7bLM/pyfF8dvOUYPnw8YMsJIAhVOWtL1qhS?=
 =?us-ascii?Q?jxUfUcPTS2stUJj65xYqULXEjrRq3UQ+WdDBwDIYK+zp06SgkGOqOuqEe+3J?=
 =?us-ascii?Q?g0WZD5DZ/0ONOL6CLbtpQNdv8VDmAsL1k4apokku5FFExYf6YIOw7r4czTIF?=
 =?us-ascii?Q?5+Fi1FlxhfyYHmoPtYCUDLX3XcgtXSmJhj6+1Rdf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69cec37b-5ba2-4bed-73ce-08dd05a579c5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7665.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 18:44:02.9018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRvQ/74HkuEx1+3Ps5MdGfp/C7EOvuAJiTK9hzfmwJ5VoUFkB1QMeYmvEWmeV+FD86oOvSGJcKAHx0F5TgFKtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6380

On 15 Nov 13:58, Jiri Pirko wrote:
>Fri, Nov 15, 2024 at 06:58:48AM CET, saeed@kernel.org wrote:
>>From: Saeed Mahameed <saeedm@nvidia.com>
>>
>>Port param names are found with "devlink port param show", and not
>>"devlink param show", fix that.
>>
>>Port dev name can be a netdev, so find the actual port dev before
>>querying "devlink port params show | jq '... [$dev] ...'",
>>since "devlink port params show" doesn't return the netdev name,
>>but the actual port dev name.
>>
>>Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>>---
>> bash-completion/devlink | 11 ++++++++++-
>> 1 file changed, 10 insertions(+), 1 deletion(-)
>>
>>diff --git a/bash-completion/devlink b/bash-completion/devlink
>>index 52dc82b3..ac5ea62c 100644
>>--- a/bash-completion/devlink
>>+++ b/bash-completion/devlink
>>@@ -43,6 +43,15 @@ _devlink_direct_complete()
>>             value=$(devlink -j dev param show 2>/dev/null \
>>                     | jq ".param[\"$dev\"][].name")
>>             ;;
>>+        port_param_name)
>>+            dev=${words[4]}
>>+            # dev could be a port or a netdev so find the port
>>+            portdev=$(devlink -j port show dev $dev 2>/dev/null \
>>+                    | jq '.port as $ports | $ports | keys[] as $keys | keys[0] ')
>>+
>>+            value=$(devlink -j port param show 2>/dev/null \
>
>As you only care about params for specific port, you should pass it as
>cmdline option here. And you can pass netdev directly, devlink knows how
>to handle that. If I'm not missing anything in the code, should work
>right now.
>

Nope doesn't work:

$ devlink -j port param show mlx5_1
Parameter name expected.

$ devlink -j port param show auxiliary/mlx5_core.eth.0/65535
Parameter name expected.

>
>>+                    | jq ".param[$portdev][].name")
>>+            ;;
>>         port)
>>             value=$(devlink -j port show 2>/dev/null \
>>                     | jq '.port as $ports | $ports | keys[] as $key
>>@@ -401,7 +410,7 @@ _devlink_port_param()
>>             return
>>             ;;
>>         6)
>>-            _devlink_direct_complete "param_name"
>>+            _devlink_direct_complete "port_param_name"
>>             return
>>             ;;
>>     esac
>>--
>>2.47.0
>>

