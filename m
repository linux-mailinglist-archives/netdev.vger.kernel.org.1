Return-Path: <netdev+bounces-206414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A14EB030C2
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 13:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0302F3AB8A6
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 11:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBE61CCEE0;
	Sun, 13 Jul 2025 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fjo5F6UG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5BF748D
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752404801; cv=fail; b=DzOZayNpOESFlsmcNdZBd8CtOeZ+gJIJsj35Fuhcz8XUiXtWbTHyBFbSNH6m3RdlUP/kmVnw9aHs1cxg0P4NHWmqAqFQFffGYBDlscv5Acvrb6nrED42TCTSGtww8ilOnHwoj35F0x2fLMmqEjIVrfUIOQ+oE3l449I4wmdTqW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752404801; c=relaxed/simple;
	bh=U8TLwvDe70BPcKPiecLBdg57jD2N/BTeOYf8cmXwVu0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ij/U2H6H9qaK4YpN2oFx0j60d/FI1NvkIgepn/oJ4UeNHt16kN5PSlUV0FR6YDZqFCN6KmQgPYg4mNb4Z3yYsNxx6k7Xw7xUw+q67GmwxQybk0/WncH9dKrkBBftft50jN8GyBLFTItX6yAt0P5OaQD0bA1rIex6q9zI+TJEqBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fjo5F6UG; arc=fail smtp.client-ip=40.107.96.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZtKo8mQclgen59TvH/uCZOuSskhUQVWdi4gCdhGQ3WdqSgqtGBgs4RD2PHpsvjPmc8FUShRsasKO6Bfv94rmxOE3lc4AFh2kLZ54ZJA8d/qtZsiYdVbOUvgDadJ0Wtez9m+Tn322LTm3VyQwcWBeZam6RyJdNXe6dGm5AJBn065QpU3qYTslkeKfd5nFj1iBW39cJLUqeR4jk8fbH8EyMNJ/tNyTJjfukWbFuKCDY0tNZTnj6SfUNvXYdq0gNMv6Q1gqpGeT4RT2MeUXsz/RnN9g+jQRMxYxobqqwbjPB6py4mw+4CRTjla4Ed4NWAwzcovns91ZfiGxrt6Xi7qTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8TLwvDe70BPcKPiecLBdg57jD2N/BTeOYf8cmXwVu0=;
 b=mlMxKHXkWLGahgBjtvYQsNPQE5wgpGVGnXCCkaxywfymnXEyT6unZg7NGrCSak7HuDAlrNsCEht/xkDpvOtuQ9XhQdwAzdxzlkollH/f7f5xxkmWri11Ih20aftJrjhUKrn71nOdFlCO9in4gofyqlV2b6bnzipd/51hdIYk3EPDMSv3efOoCRGPM2Vup1tHzJZoJF96EW/Wiw1pWPsEkMwP+Ig9YvOtJNbRY4pX1HEuqQkkd4VNo4xbwJInLIsWr5ATQtLhwNksSVdJBb0h202Zl6oR93Py2WaalTvF7aipMEEYi4MLSkrXrC7fZqQPIbgrgJVq8+vIm2WTEUfT2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8TLwvDe70BPcKPiecLBdg57jD2N/BTeOYf8cmXwVu0=;
 b=Fjo5F6UGE0+ZxzC/jajuEPzbZ8rzCOc4TWv7uUNYkWCUXS3H8162si0fjIA/qqs+5WOCywiePjR8NS/62XergMwkOo+CdZv1fXrIi+iJcSAR4XEbUJlrPRj6iZ1p+mSQ08SXhCxLgN1GzGVH6/lXKvDN0hy1Sq/1BWXd94M7zaDq8S0b8Y94Y+5yg4iEPTouODRuVDwzgr6rbWMseBQtk5vtnQqWwWqn6DLFKAHpmiReE6x6ISYceHc9vxUTUhjLF22LzEw/mCZNnmJHu8JY43M/fQ0EhJYEQ5SyqqA+Dtx08eyNTf1+lYyJQbP/AzAbj4Bk9G2en6xTgsAl44ieKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by IA0PR12MB7602.namprd12.prod.outlook.com (2603:10b6:208:43a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Sun, 13 Jul
 2025 11:06:37 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8922.023; Sun, 13 Jul 2025
 11:06:31 +0000
Message-ID: <24aa8c69-89bb-440c-8d63-79d630800c88@nvidia.com>
Date: Sun, 13 Jul 2025 14:06:25 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/11] ethtool: rss: support RSS_SET via Netlink
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 shuah@kernel.org, kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
 sdf@fomichev.me, ecree.xilinx@gmail.com
References: <20250711015303.3688717-1-kuba@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250711015303.3688717-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0019.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::14) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|IA0PR12MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 57eca72f-5eba-43f0-ecbf-08ddc1fd5285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHU5djFQcGliN21mOG9OVmpieXhCa1AzVDR2VE42RFkrMkxzeHpuSnBUREZj?=
 =?utf-8?B?S3ZpdVJZaEp6UGhIeXRQK01ubllqYkw1akV5WXBEaXZJSkZNaFJaTGRhMXFJ?=
 =?utf-8?B?Mm8rOFlRR09YQkFVd2x1bTYydXpic1p0UHZjNEh4TDN0NklBeXdveXZIdnV5?=
 =?utf-8?B?RHhCcEtDR1JvTzU3akpYdzY0VTlPTGUwRTNnWlVrd0Z2dXdZWkludWo5eGlJ?=
 =?utf-8?B?RDc4NTdyV2tUZm9kYk12L1R6Ry9ES201NHlXK0pmazhkUEhGVlFLQTB0SVp0?=
 =?utf-8?B?bWF1bXVsMGk5TGduNUdmWC80b0FuM1JoQmhBM0c2RVFsenhOUWJ5NTVpWVBX?=
 =?utf-8?B?UWpobkZoTlJVdVhyYlhmOUZIU0wyMXYyU0RoK3ArNGlQU3ZCcTBTcHN2MW0v?=
 =?utf-8?B?akk4NndmL0xIdk1JMXdUcnlDR2FGcS9lbnp5dTBYd1UrNUdmbWJxMkRNWjJI?=
 =?utf-8?B?WUtmeFVoa2h1azVFMmpsZWdjOURkNzJnamN3MXZ1MzJhK0REREhqU055dTAr?=
 =?utf-8?B?cHo0UGxrS1RTc3huRXNRRVRLT2lkTllyYlYzL1psOTdtTzloUlBpRHdvSnRS?=
 =?utf-8?B?MlphVTJkVlNWc3laNVRJOGhvNXdkejZMc2JCT0NaeUFscmw5RFJpTHJPKzhs?=
 =?utf-8?B?eVhENEp6eHArZExDT0RsQ0xsMkJyS3VrVk5vbGExeGxJOUYyd0tvK3RQT0pp?=
 =?utf-8?B?U05yenJSemNoU2ZLTE1kdFc3RVlOekZaSWpJU29pNXBrWjZtQkVUc0d5SXVw?=
 =?utf-8?B?bTlxdTM3dHFZRENUczhoeWdJWkk3cnRHWXF1R2RXY3M0UDczbW1NcUxndFZr?=
 =?utf-8?B?UEUybDM3TFovTjNKY1lDM0R6cVdwU1JvSXFVNkpqQmV5dDVlbVdsVDFKcWhI?=
 =?utf-8?B?ZE9ncks2d1FCS29SRXA3d0lJQ3p5bnEvOXdueFR6MVlJb2E2dHYrZFVGOG4y?=
 =?utf-8?B?cFZXbTI1ODlnV0s3ejlmT3B4eGpDcEgrL0RYanB6cjhCanRIUmRXTy8waDFC?=
 =?utf-8?B?Q2lDQTZYelZrRG51dnRIZkxWT1pWZkZwUDJVOTM2YTFOV2ppZnVUbVptQkF6?=
 =?utf-8?B?dzAxSkVjbzhHT3RDL0RCU1pSU25EQjdQTS9zK1FqRlZHYU5kQkhzL2EzeWZF?=
 =?utf-8?B?emwwcDl0ZXVJS0p0WjcvZG9MbVhzcy9SdFZTV3M2blcxdmFBenBYdVUwRUdk?=
 =?utf-8?B?TjNvRUUvMDhBSHRaUFNad1RpampxTDRZdWpFaXUzaGVSQW4valpDc1h0bTBE?=
 =?utf-8?B?RGVzS1VHMDJWZ3VlWFJ0OUphV1pnY0M5QVZOWnZkRmVFYkdyZ3ljSEVSdm5O?=
 =?utf-8?B?UzUzWW1DMTdsVWxwR0VKTkVRWnZ3NGNIZGppL3p3ekFXeUVPWjN3WERVZklq?=
 =?utf-8?B?SnRPQmE5UzRpbUhITDV4YkdTK2RUT2pwWDR5WFlycThuaGNlSTlmKy9TRkR3?=
 =?utf-8?B?SG55bUFMUjdmSk00VGo0SDcrQnlnYkVmSSs5d2V5UVBhSXJxUkpiOUhRQmlr?=
 =?utf-8?B?S3FJaUUwOG5TL0lvUkJZSjBUTkxuM1hyMFRLSU9YdXo2ZXBDNVdmbm42bjdV?=
 =?utf-8?B?dmJZbzFUWndESnlha2JJRmc0WTJ2a21nNko1Ym9xQkhwWjJCcXE0dEk1cUd4?=
 =?utf-8?B?YVNnZUVncVhWbUExZWhLcldNOUhUMExOZDhTRFhSYW1jejhwTU9VTExGdmxu?=
 =?utf-8?B?RGp0c2hnWHhQdVlrSnNpRkJ2WFpqU28vNVhLaGxnemxGdVFNWUd5bTUrWUs5?=
 =?utf-8?B?L1pFKzU2VUpWbTdzOFZkWk5GUlE0aGZ1K0lnRnVmQS8wQU9mblh3M2lmN3Uy?=
 =?utf-8?B?bm1NRFdCMlBkK2ZrdGZwM0gySEszdzRaYlZEenBiZ2lRdCs5QjBhNzQvNi9n?=
 =?utf-8?B?Znd0a3BkUFlXL3pXeEF0dFB0K25taEMwNXV1ZHJFQlFSSXo0T3pLV0VvYkw3?=
 =?utf-8?Q?43ohO2gxoH8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXd6OTUvSUFLSTNtTUE0cm1OUUo5R1hQT3htUENyYUVkak5CaDZHUmFCdXUz?=
 =?utf-8?B?cm14Q0tyVjFTcktGVC9uOWZhSndCOG15V2pCNlNyUGNFSE5oaGhMdFA0bHRw?=
 =?utf-8?B?S0dodXVyLzl4aWc2anRVc1FMbERoMHVRdVpBK1hKWEYrRDR6eTZ6dkxlbGtM?=
 =?utf-8?B?aTJnOC9iNXJFeUZVZXZOSEdGdlBzUVd5L3p2WE04eWNITnF0ZStHdlRxRjUr?=
 =?utf-8?B?L2Vhd0pLbjlTeTd0Uk1IUnlUazdxRFhWRDNxU0d5eWlMaGovam5vTkNxanoz?=
 =?utf-8?B?Z0sreTF1ZzM5MTNadm1yR25OYTEwYTFqZTk3QWdndTZIZFVnUTFzVXlRNWZr?=
 =?utf-8?B?Nk51K2xCcW1iYnhIQ0Nmd3B2MjVtNytESlBZd3psWHV0c0xYN2s2dWxvQ05i?=
 =?utf-8?B?NU1qUVpTTzU2YWhkbmJENVZuVUgwOUx2NnJUZVBOOGJIcjNEZ2p1VGRlNnpY?=
 =?utf-8?B?ekRkaVJFekxpd3ltTlBzVnpRUzF3YitaVWJJNjQ5dVFDeTVjWVh2MlVsOE01?=
 =?utf-8?B?d1dlMlFCMXhDcjBBVGpNbzFQNU1UNFkxQkhzanlkS1ZKcGQ3NU1kNThqQjd4?=
 =?utf-8?B?YUVKclJGTEZtWlJMNHlRZXd5bysvOEZqaFFXMFZKUjRUSGhMTmFlNkozL2Zt?=
 =?utf-8?B?bzBvcHJiUGtDQTFmOHlUaitMRlNIb1VrSkxtRE1yWnhrNXFEdnFwWG9LaXJo?=
 =?utf-8?B?MFJwUkJsMm5NK1hwdnFpV3BRMWM0MmdJYXVqanVPZk4rZzJkNnZ4TU5sVGxm?=
 =?utf-8?B?eGFiOGxWNEdHS2hLbkl5Q3MvU3RLQkcvWjBtUHk3TVFTY3Fid25lNW1BWms4?=
 =?utf-8?B?cjZjeTNDTmpURDdVYVNNVDR5NmRsMHhheHlQWmRjTDh4YnJNT1V3Q1Y3bVpU?=
 =?utf-8?B?L0dFZzQzWlUvOVBSZ0RScE1wVzBGdHdra1ZCRnFWRTV1c0FvTHQxODdRSHhw?=
 =?utf-8?B?eWVoZlg3ZEVjVzZ5OXdtUnVtMkFyT3diMDNoMWRwN2puTXlXY056Z3FDZ25L?=
 =?utf-8?B?NFJ5ZnNldE80N0dZR21MVEV2TnZmeE9uVmdORlJOeFJXek1zYlcwS3Irb3JP?=
 =?utf-8?B?VlFrSkRMQ0dSbUxTOXdoT1pmTytDazJSUHVxd1hUaklBeFI5R2ZTdVdUWXJp?=
 =?utf-8?B?bDlrbnBRR3llWjBySEJ0eHNGVGR2MEF1dTVFaXU3RUQxaHM4WDVSN09xdTUr?=
 =?utf-8?B?SFgwSkZxMERoRlkwUlZZS1FEVzgrT0tlcDJaY0J3aWN6T2xUbEhMOHZsQ1FS?=
 =?utf-8?B?Y3pzVWNHbVpNbmx2MlpHc25NczdnUW05Zm16YUs1WktXbXJtbUtjcGhSUkFT?=
 =?utf-8?B?T01QSHNnVDlobFlLVFZEMHhxc2ZiWVZJUlRjZGt4T3JleE5zZHBxU3k3Z0xU?=
 =?utf-8?B?OHBmKzlnZGcwRm5sQnluck1LT3NqREM3MzE3UFlHVVl5dTN3Um1RZkxlYUJZ?=
 =?utf-8?B?RGdvekNRSElsRldVNHJmVlRSKzcxNjNIWUNJa29oRVBmTHQ2M2x0RGlFVVNp?=
 =?utf-8?B?VWFMRUlyTmxtV3Vjd1pRRzVJbFFNcjVkWjZqRngvWUhjTHU5SzNlWUZmUDRE?=
 =?utf-8?B?Qm50VWJydXN1NTd2Y2RGeTVHTFRpdVFBTm03V3JlcGlseEdVU0M1TG13QmtU?=
 =?utf-8?B?d0NtamxEQVZGbysyaFhrUXJRSXZUaS9yK3hoWExSdTRaakRiN3BiTzJWTlFu?=
 =?utf-8?B?SFV0eEx0YXlkQnJLay9ZNTJzRmRCUU9UR0FQM0pGSFVCTXU4RGx2WUhmbWFE?=
 =?utf-8?B?TVU3LzJmQVhlUkU1SVdaT0JuUEg4WVZsaVBncDQvbmdlajBLTHFTeVYrUjhV?=
 =?utf-8?B?YlNBREJicmZKdDJyLzZKRTIwYlhyRTQyZHdRaXFRYVpYOFRCVDZEVE5DMTNR?=
 =?utf-8?B?UWtzdGRNOVlRWUxQbmVmMVYzVzdIR0xrREx3YkkvQzVBeGhZMGtpT3FzVWJ4?=
 =?utf-8?B?ZVZrNW1FNTJDZkZzOFhrWG5CYTdremdyL1VaeWRMWU5MUXo4UGlrb1NiazRY?=
 =?utf-8?B?NjQxYnVES2VsS2cxRkFrdFl4eHU2Y2FydExpUGpLNDdtS1VYM1B3S0V4Vm92?=
 =?utf-8?B?VGYzdXBwcUVjZzJMUm9vdW9VRmJETlhxWnNEVmJDd25rM1V0eHdXZ21pRjh6?=
 =?utf-8?Q?rPjFJdGAHw4+KtSzP1LDFNdCg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57eca72f-5eba-43f0-ecbf-08ddc1fd5285
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 11:06:31.5195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcRR1dEsbfgcG0fAEZkYDK9J1wrfXlY4liM71MgkKPC6a1GY6BUx3NpQcvyL6sL/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7602

On 11/07/2025 4:52, Jakub Kicinski wrote:
> Support configuring RSS settings via Netlink.
> Creating and removing contexts remains for the following series.

I was also working on this, but admittedly your version looks better.

Given the fact that this is not "feature complete" compared to the ioctl
interface, isn't it considered a degradation from the user's perspective?

New userspace ethtool will choose the netlink path and some of the
functionality will be lost. I assume rss_ctx.py fails?

