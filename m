Return-Path: <netdev+bounces-228891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 438D2BD59D8
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 19:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC28E3E47C7
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339402C1788;
	Mon, 13 Oct 2025 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YwKkRIUQ"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010016.outbound.protection.outlook.com [40.93.198.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEDF2C0275
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760378244; cv=fail; b=gGfI1bNjCN0yMyBgWOVrYa5Mwyo6aHNW1CzBLW8dP8CzPMLdv1jhZHD+ljZRQZ+7Vr4t6YWeydYFWfrQ+FLoTeo+8d/GPNkM2PHzLJQSdRwQ2Noq/Kx7yir3z7SWsr2UdqBpSC3HMzo8ugRKWx8vSE3fP4Z5g+rvHU3pBs/Yc+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760378244; c=relaxed/simple;
	bh=J+WQk8h+UTdsF/3faCdv2VEkl1YA0m7QorB7YZeNi7g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uwv/fJ4L1RTWAphhJaw4z0HzHSw3Dy4wdInlnctfbiCs6+ryn+N/p/tbkxY6h+vlcC595el15fh5221aVWVDOoW2s96G+HdMJzVqi8ngdIxGtVkvrJMriPFRF2RK+vWOGSBdyA4l/Cqie7JryWzy0uJckMI4r8Y01cPz/sZeliQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YwKkRIUQ; arc=fail smtp.client-ip=40.93.198.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=weDfI7sCNNwGTjzTjHCAO7e5fmMl3ay3bdMZc1ze9BxTuTeq7mRy/eD5AVWTIB9bvGQrIEI527nrB9ZzlKUnOZcO3hzLJArSDPLUq/v4fkQyNu3vp+xIs/7YJ71QhskSNdOThVnGny4lfN+aBgIdZOeKnkTDfmEbOBmkMvScfJ7DmXjxoxzeJcmxnpqEqY0Cx++JJdq166tHJz9QapIxkBdGmdgsH0/+xYSiErhZoVSeqsrxKehcn1BdTZ2vJXSTjofO06f22nd6y3ijdqGHfFL+LWvs1YLWSR4uyXeohmMHGhvmPFTm5qD4XBEPxe9j/BNxv6FXBLCmcyFXipLcrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vc5cPITJAN53R638bsGwcQkOT4QkVIV0fyhKgRzt1Ss=;
 b=n38FqTtWp7+emsIXAFZ9bNEeVMB34WnyV4+CZ1q1zW+gdTryQqbce+48z15sPZzcKCdwwKb7ZftcjCKUJJ2Yluqcoa5L6yoPNlpS2wjKnKnhT+OtiTin9VBo3D2uN4u0ozUcbPivb2xFPEUkx7lL8Z5A6cY1dV6Cg9eblewC7V79xm1ciJf21n+sGwn3fN25cKNPdi1sYTJbZHu8ipZZbWaur57vTIx58luc/oxC/4LVGz21GyvbcQGlR7rVLkp800YXBr+8lbPOMZUbwbviUJkG6IWyPYuZRvzyD7gjtK8z3Ht2r0ctph330kb8A1QU5F9U4/CvFzluqxehpgrPPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vc5cPITJAN53R638bsGwcQkOT4QkVIV0fyhKgRzt1Ss=;
 b=YwKkRIUQAIv0i6unN6DdV4jULfCa5W4wLwHx1FsdW1cYthke4zRido28WqZ5NBlofCVOaNYqc+Frq33Q+7qEut2MLDn7GIKYWTDVxCGTtgYNy3FqR+19nbSHvAt5x358yt7t77LR+Ox4C9qehj899VBV2Z/rXsbyi9Bg+SX3TbRCX1W3FkaLE+pHPluVVjswVX0J64c/MLwx02KPmMZUJRNl4DlFywzNRace6Y4hwXyCua9koiP7rdKutTqbct2kk20zWsd41SaWpeq17ExQKdZwQ6Zt5be+waW0XjIy8479vEjeWwFGKZ2cx2GyN+N15RrsYYkLJdjJRommw7MJKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 17:57:07 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 17:57:07 +0000
Message-ID: <3530d46e-68c5-4966-923e-943da2f45fbd@nvidia.com>
Date: Mon, 13 Oct 2025 12:57:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH net-next v4 01/12] virtio_pci: Remove
 supported_cap size build assert
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, netdev@vger.kernel.org,
 mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com,
 pabeni@redhat.com
Cc: virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com,
 kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
References: <20251013152742.619423-1-danielj@nvidia.com>
 <20251013152742.619423-2-danielj@nvidia.com>
 <d1720c75-3d56-4040-b7ac-97c399302257@oracle.com>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <d1720c75-3d56-4040-b7ac-97c399302257@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0048.namprd07.prod.outlook.com
 (2603:10b6:a03:60::25) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|CY5PR12MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: c3ff60ee-f3a2-4429-b45b-08de0a81ec79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STBsSUFwcFBDdExEcWF5azJsREpYWE1TaHRzcnRITXJlZElVcGwyMGVsQ2xw?=
 =?utf-8?B?d3FyVllsU3Biby8wQWlFUzR4Ym5HWmxudUQ2Tnd3V0NaM0NtNFRhUm80VWtM?=
 =?utf-8?B?bldRRGJNc3VHb0djdEFDbnJ4UkJpY2FGK3BnS3BxSnE2aHdFTFFKNjBVQ09B?=
 =?utf-8?B?SHFXTkNLZlAzOXV1VUZubkhXUnIrWitybTRhaTdvS0prVnJjeUJNSHJ3WlRa?=
 =?utf-8?B?eWNRa09oeXc0T0pZaytqQ0dlUFVlejhHVEUxb3RCT0N6WmxIR1NVUUF4S0ls?=
 =?utf-8?B?NEUrM1dnbjRvVXFFTTdob3pkbFQyY09jeXVtbTg5bTlNSlh5eE9oc2NiY2VP?=
 =?utf-8?B?bm1Cajl2VVBzZm1ORTRTZnQ2WDdsNzVpemhOZk80WDVpSVNHZDAvWCtQQWpi?=
 =?utf-8?B?TE42MUJJYzRLTHUrQ3gxZS9BZzlmd2t2MWVSTHM1MDIrRWlPZ0xpQXFXY2NL?=
 =?utf-8?B?OVp1OTk5Y0MxVzE1VFpNeGJEd00yKzRSeEo4cU1FVi95MVhkNFI3N2MxNUlZ?=
 =?utf-8?B?S3NlaU81djlxby95VnR1blhHTTdYWklydk1XeHpKSjEwbDZaTTFLUEZMTE83?=
 =?utf-8?B?aVpIZWFsWU1WTEhDOElJc0Z2NWxXd2NDUzNHNGtYZzgzQVdyOVRsZzVyWCtw?=
 =?utf-8?B?ZVp3TDdqL3VDSEQvZTNXcE0rRDFNT3I3UWVnUHh1Z1ExdDR4Ny9jTFdEZ3Iy?=
 =?utf-8?B?Z254b2ZmTTgzNkFJWHY5N0p5WXB0NUhuaDBwUHRON3BmdE54bUdpZGpjcGk1?=
 =?utf-8?B?aFRSTzdBOENGbEUxQmt6aXFxNjNYRGhqSkJkVHpNck1icFJqdGFmSEFkWmNQ?=
 =?utf-8?B?bDJteGMxZlF4S0NET3BQN0RwN3VVUS96ZVZvZnZxWjFTcUJKMjR1U05Na3Ns?=
 =?utf-8?B?WFdoZHR6NTVmb1F2VEhCZmcrbjFmMjJWelVHdnU5Vnh0b3VrOVlEWG1EakF4?=
 =?utf-8?B?cktWeUduQzJkRm5nK21NWGFpNWZpODYxN0xna0N1akhuNDFyclpXTnhsUElR?=
 =?utf-8?B?RUhkNGJSaVRqRUdIN2RkcTZETUdMNGg1S2NzOTMzaGxmaWpndnlsaDE0THRJ?=
 =?utf-8?B?QWJscm5NdzRNVEgzUUNpdTlLODNPRHplbUVTNkxEWXBVWjduUlc3d2ZxMTVy?=
 =?utf-8?B?TUs2MG5yNjBpR0tyTStzdGFmVlJyTExxM2RDQnpJb2ZxNjd6WW1DKzFuZStS?=
 =?utf-8?B?elNoUGJNai9VU0dTVmxOZWp0WVJrT0dhZVNzalFtV1k0TVFTcjlQazNiK0x5?=
 =?utf-8?B?WS9Ia2NmZGJsaUtqdENuK041dGtPL2E2RWhPSnhybnhzUEt3a1g5am1HaFFU?=
 =?utf-8?B?M3VZMEtpbTZEYWV1M3dycCttS0FLZGdkMWJvdzFJdHZYblVVVzJmM290RlVM?=
 =?utf-8?B?cVFSQWdNbng5SVdqM3kwSnQvOXFvb2w1MGVTZ0FucXBjY2oxdGlDSnFWUkty?=
 =?utf-8?B?THZ0NktOUFl5S0hnMEpUZlFYUnVhT2VYQVJDNDBidENYY1dEWWw2Uk1oZTJP?=
 =?utf-8?B?ZEQ2T1gyYUdjVUxxUWt2dzZ2Vmo4Ti9BeVV2TE4yODcvc0Y5a3IyTjU3TFZB?=
 =?utf-8?B?ZmVKbWRjVkljZUJwNlBRRG1KbFQ2eFI2aGJSeWM1Wnl0U1BWM1VQYlFac05Y?=
 =?utf-8?B?Wko2S3QvN1VrZHRqSEp0RmFNcGFQMUs4V0puU0Z5MTRDVlFrdkhUVXo2RHh6?=
 =?utf-8?B?SGZsbDVDVEluaUZJcTlpaWMxcTFuL3BuRWxqRGZVS2hOTG52cVZROVA1eXlS?=
 =?utf-8?B?M2xSNTc4SnBXcGRKR083cHVQNWlrRDhFUjgvNHFqTzQ0N3VWMXY5M2ZlVDkr?=
 =?utf-8?B?YXE1VHJtd2VUZlhjUzBNTDMyZlIvWkxqZ2tKalczYUhDZWI1b1lHMkhmM2RP?=
 =?utf-8?B?QlVvY3JJLzAvZi8rR0xsS0xrbzNiUVVaY1l2OUl6eUxlampVc1dvb29FMXJk?=
 =?utf-8?Q?Xike0lyi7LsPdYGD1GTM+rX+oFjMijE2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkJBY0RPYjhqRkF0ZmpTY1N5dkpPRm5yOHdmOUYxVTY2TUFKeHV0ZUtNakpW?=
 =?utf-8?B?R2RwZldaRHBuQnkvSUdDQTlqMnBUOXQvQVNOYXFBQlFiTkd0NE5saWxZck9z?=
 =?utf-8?B?Y1NYV0ZzbGk2ZjVUZEhwOW9WeG82UGNnbFVJUFNtaTA3NllTQ0R1MUd4VVJ5?=
 =?utf-8?B?UFkyenRPdnB6b0wrNFpCbkZDaWpVdHNwbDE3MmxUSkpmRjc5L1haN1dYMjlq?=
 =?utf-8?B?S0JWdllESDNPcUEwTGo1aDFkQ2hueHNnV0VSaktSMEQwTCtjUGkxQktFV0hV?=
 =?utf-8?B?dWNBTjRJWUNLSlJYcjR2S3ljdkJxUzkxZXlmMXNHdHRHeGJXRjJIWkNSVkhK?=
 =?utf-8?B?NC90YWxrUWlqNkt2dVh6cFJPajJXVG9jU0ZKLzYwR1dLU2RhWklmdkhQVHdC?=
 =?utf-8?B?eVJvditUNjUxdkZRbHkraHNVeWNvenZwSmVLTnlVeHhaMUFicXVsYjhaSVk5?=
 =?utf-8?B?amdGeldxT0s5ZU9PbWUvUVUwYjFwMkRoWnRwY2IwakNnMHJTQnlnSlR3Ukp5?=
 =?utf-8?B?VDZXMTgrL203VlBrWGtoU2RjN2V0dDFXRm9JbkRQcjJZRVRZdU5aWEIvNTlD?=
 =?utf-8?B?K3FsQzQ4MkNnL2JTczZMVzlQS055b1BEMk4xN1d3dWpDS1pWRElOUzFKSThi?=
 =?utf-8?B?QXVrQVZVN0VyWnFnY3lZT0N4aFdnQmlUUURiT0dQTXJRNnV3bzA5OG1lS0Zu?=
 =?utf-8?B?aWNCU29nOGxRVlduK0ZmdHZxVXVvemFIaW5rQkI0d1l5MnBxbHdjdFMyUWxl?=
 =?utf-8?B?S0xSaUQvekJRd1ljVytOdzdHTU1ldlFXVXlrdjJIQnh6bCtHVTJIVEozaG5Y?=
 =?utf-8?B?UVJIT1Fjd2JiQzdJMTQ1NU5vdzZoeDY2SER5VmtqTjJjOGV2VHVrMGJHd3A0?=
 =?utf-8?B?SllkOUxJNytsWGthK3ZoNzVObFJ2MU9uNE9mdGNETUJFcytPa1E0MXRJOE9Y?=
 =?utf-8?B?cEpTY3d4eXZ3TTlLQlBsZTJtODAxL3BMbktRVENONXlwMVFkVFRpWC9pZjV2?=
 =?utf-8?B?ZXBuS2pGRGlpWmwxdjhCZFhjYndBUXAvOUo5T3lyN3BieXV1MEc4ejQrSFJl?=
 =?utf-8?B?dTQyV25GVFlUZDhvemhnZ0huMHFDbGtpSlRuSjFUZzhpWkpjQ3E2THFoSXFL?=
 =?utf-8?B?eFk2TVRHcjY3THB3NjlOcUFyNTUzN1ZLemdpOFlBTE9hVlY3dTdCVXpRNTRG?=
 =?utf-8?B?ZStyck5VTmlQOVIxQWdmd3Z1S2M0dFMzUVAvbzZ1YTEySDRzRVUzZUxmck9O?=
 =?utf-8?B?VHl1VkdkWHg0Ky95aE40Umw2dHRhL2lQbTBwTmhQSmMwWElrWkJZQzUrVDNN?=
 =?utf-8?B?RElSVjJUTXhxK2Z1Z1djWDFyV2R3dkozTC9ZK0NWNHJOcy91QVBZaFdGTzJv?=
 =?utf-8?B?MFN6dEN4a1hyS2xnSUtpdG5QK2x5UURFOXVHTXgyRmxyWEhsRXFtK1J3cFFB?=
 =?utf-8?B?TmNLTUczN2FSbkdpWHI4MUtrblVXZWZNU2YyVmJiSThJdGNHdDR6dUpHZ1JG?=
 =?utf-8?B?aXNGcERzb0tyYTloZUx2dmJybkRVZjV2MXBUMjdkY0YzcXBudHFqRXJqdGJU?=
 =?utf-8?B?MloyTm9nMVNKKzJ6MkI4KzJDRTN0TXBHU1l0TWRUdG5LalFuRUcwa0Y1Tjlh?=
 =?utf-8?B?WXBjQlA5SXZ0RkVBeG40ZVQwbCtJTGg0Qkh0NG5sVXlvcHlyYnl5NSsxK1RL?=
 =?utf-8?B?QWhDU1BRVmFEdXNLcDhVSHRuRkhqUnA1VW9QUDQxYmR2eFlyMUpzdU5LM0Z2?=
 =?utf-8?B?cWFtNmg2NVpYWW81U1pZTHczK0dLeDhKMm9TbkZqcHFLeWlmQ3VBNFoyK3NR?=
 =?utf-8?B?NnZ6OVlMdUMwK3dLZE96b2lQK0lXUktqclNJTlZuelBLL0NDQmYvVEhBa3FZ?=
 =?utf-8?B?aFZzQnI4czA1RGNXRURhTXJ0SkZES3YwaE55UmZiNk9iQTlqVFhvMWxSbW84?=
 =?utf-8?B?ak9aOUpBS3ozT21ZMW9BQzZSY3BTRXlDQW5sV0NVSkZDMWx4UnJtY2RXampi?=
 =?utf-8?B?MUt1TDBzMlNlNEZxVnJnSFpUVkdlRUtHV0pndm5GVTRTd1pSQzZBSFRHM0Jh?=
 =?utf-8?B?K2xmQmswamg2RHc5RVZ5MlgyZ1Y2VS9wYm11L3BGYnZvSXVadWN1cTFTYTd6?=
 =?utf-8?Q?6KYd9HhBhWoXKl9bIsdffhdVc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ff60ee-f3a2-4429-b45b-08de0a81ec79
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:57:07.0051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jpdq+xFB/ETVP0iD7+KdPugjI32YkvmmoHprX/XxEepgGurOGFv3mVq0+/JbU6ksVwBj5zDuNSVagPCEMvR1Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6179

On 10/13/25 11:38 AM, ALOK TIWARI wrote:
> 
> 
> On 10/13/2025 8:57 PM, Daniel Jurgens wrote:
>> The cap ID list can be more than 64 bits. Remove the build assert. Also
>> remove caching of the supported caps, it wasn't used.
>> -    if (!(vp_dev->admin_vq.supported_caps & (1 <<
>> VIRTIO_DEV_PARTS_CAP)))
>> +    if (!(le64_to_cpu(data->support_caps[0]) & (1 <<
>> VIRTIO_DEV_PARTS_CAP)))
> 
> typo support_caps -> supported_caps ?
> 

Thanks Alok, I dropped a patch before submitting that fixed this
problem, not that it could have been left this way anyway.

I've added this, and the comments on 0004 for v5.




