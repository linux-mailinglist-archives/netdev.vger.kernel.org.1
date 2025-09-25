Return-Path: <netdev+bounces-226527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3ADBA1786
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 23:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20821171038
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 21:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDF02777F2;
	Thu, 25 Sep 2025 21:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E+dcCqu5"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64CB277026
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 21:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758834831; cv=fail; b=kz86how6+U9nt9vw7GLt5XnMuHE8cKFBNlRgYnuL7KQP42fSRNnEyO8UUnyEsy7vPVNq21FOGXgo2MY/kZVU/0aYvk/HdG7r20Y6H4vj+nPkECbxKKt2foEdNrp6hiWYAJUFo7aj2ZSpCe+0AAHRCZ8kcK86c39OoFAjkkYwSeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758834831; c=relaxed/simple;
	bh=DmL4fMcXgaaMfw2RLo45gyUL4Fm5UAFI0I68MsX1eE8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aZedYQlFjzlLX2pLtX+jgGHOM5/0hZmaUfiOLa1Yqbm0+U/iUaMcSDxpL+B9zfZpJbULZek7Qfv2n0UYWPhZRZtT2If+hOXBIk94YF/6XDa5o45zUrbqlepzpkccCd6dMB47eWaXPiNoHErnJ+IvJ5ePzojpU5wNMt8p7czu6kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E+dcCqu5; arc=fail smtp.client-ip=52.101.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wb9lS4Yd3GmsdBd+DWAOEgPqlPWEfWkNvGCkDrBsL/WjS8K3VChjrKIZhTpjyASFphz0ifVcHpUBT89AHvKKdSgjsRHYgA5O4lUzW//T3ReY6xg6b0g857nbmzVGfa4qtOw28GemibgS1U2OZg2UpnacUNCLwMTQql/rA3Z5lZdpx8K4B77HL99K8c0gpb3n4IW9s5HLWm1wo+3CnSzRd2JlyZR9YZttaY6o9J8N2zZMZeucy8IDlVyaNqOtexa9pfJoFK7hFY7V0YzncdvYdhZLnxwBVGXUPxv+2dwghvIov+q4a+mhET0Ua5ljNxrw5O/lAO7YMf5t3uYPhzqoAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwZ15nHPRM8RmIIS7jpY//cDH61ddHsPvywtdTwJrJk=;
 b=j5pdI+VxXfECNGb1ledpbiXEg10lHmpIYKwdyJyDLzDKa89Qibqow+ZTiA6VeC0+XNewttDoy5hdjugeY+HSe7eFTr4DOpO73Qwf0mHB629kCX+vJ6upte6T1h/vsdMYb/NGWlX2K1jRB4KqndgG9OQMQbkwiFTTYwcrc4Yrcmng803ZqUKbTX5R1Zw9zYeHyQblRWDxMEtFablEW0nrdglTwLLv6N7lG4kl1F1b1AqluDi4KtV+gpkyBPyXhY5lN/7yxOgaY/qj72NS+vOm7UEZxu4eYQEVd9hrO1s5KrlLRRp5PpHvhgaC/NcWpBrjo0CJI2Pey9KuOaneWCKdNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwZ15nHPRM8RmIIS7jpY//cDH61ddHsPvywtdTwJrJk=;
 b=E+dcCqu5GmxZSrLLEZ43KQxAPfZlqJqHGfGWhZwHizZutytqJHQuxJFX4Uexb5UHvPhonw5xDKXgnTYzVYIs70AiBHvL86OgMNORmT9Lde+LKudQJ5M8hsALkpIjt1z2GQgE/wX/4Pj5HI5KjyCIu8XIcYhVX6/1r1iNnkRrk2PCnQ3K4rr0t7z2Q8Iu7enQ0b6l0vBGWbQgTxqPaOUOhkan28qaiITMWgyN03QZi1V3x7ncsUI69WP0FE0HEBoEJ9Iusj9CrFAXMckW2N1LEsykrEMqh/uctyKY4qS7pJulyGI4rsxahMw1ggYFsrxtfyQp/5SMvazMoj8h9L0OaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by SA0PR12MB7075.namprd12.prod.outlook.com (2603:10b6:806:2d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 21:13:45 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 21:13:45 +0000
Message-ID: <5518ba7f-80b4-43f1-a5c1-eb8298170e9a@nvidia.com>
Date: Thu, 25 Sep 2025 16:13:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 08/11] virtio_net: Implement IPv4 ethtool flow
 rules
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca,
 kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-9-danielj@nvidia.com>
 <20250925164807-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20250925164807-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0198.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::22) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|SA0PR12MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: f5cac327-c0e8-4e3d-87b8-08ddfc786925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajJpMVBSUUs1Z1I2cG5DOU5POEMxNmgrY0swU3hOd0FMY1JZWjAwYXgyVGJa?=
 =?utf-8?B?L0FFVS9FMFRhVGxlUXMwRklNd2lBclkzWXRFREdHTE4valdhc05SZTVBOEE3?=
 =?utf-8?B?ZHVwdXMwUTJjc1NhdmRkdWRwdmMvVXFMMGJUVFFRQnBIMTg5YXpra3JHVnpm?=
 =?utf-8?B?UmpDWC9qQmNIRVdlZDVJcGxvVmZkQzdheTBKUjB4bDdiNS91RERXZ1FLblRX?=
 =?utf-8?B?WE80UDRoL1FOZ0tWdjBUUWRhYnp6T0dYb2o0UVU2UHBwcHpSYkxSRWVIN1A4?=
 =?utf-8?B?QWR3cVdObGRzU0J3aFBCOHlTcUtwTWhkRE9nVFV2QmlEWExVb1pJZnBXSVZ3?=
 =?utf-8?B?YzJqL25FOFZ3Z0pEbXlyYm8rNVdyc1dEVll0WGRLclVidFlHei9jS1ZGQVpX?=
 =?utf-8?B?b1QrbDJ0Rk8yeld6bWhwNnp4bDBaQ1Qwd0RmSGdFcmRodUZyYTNkcmlza0dL?=
 =?utf-8?B?V2NmUUkxOWJsQktHMnc5Uy9yR3V6UnpUS0IrRUdRQ1B6S1hwUlc4WnJDRnl0?=
 =?utf-8?B?aFNLRnhXWlViUXA2Z0szYTVsZzZRcWZxM25rRGVOOXVSQ3FPSnhUOEZxU0tL?=
 =?utf-8?B?ZENxbllUSGQzeDB0ZDBoUjV0REsvN2JIRnRqTmZzMmFlbXhTd2Y5eEExWkVW?=
 =?utf-8?B?ckhGdmxtTmR0NnVBL2lreHMzcjBTd0FQVENya2pwbkdid3pTdEJFM053MytD?=
 =?utf-8?B?R1BlUzJCcW9raC9DSHEyNlVQRG84TTNYYWRTbUx3V2lLQjNJU01XcUFhRW4v?=
 =?utf-8?B?b2RqR21IKzRGTGdGejdFZVBtdEpUdnE4WENwbzJlV09yVGRxWUNSbEhnaERO?=
 =?utf-8?B?UjMyaFE5clhGcExuRW1VOXJHWC82bHJpYW95Y2MxK0VaZ1diVjM5TzdpdWtV?=
 =?utf-8?B?emtYajJVdml3RWNMdXdtZ1FyNGlmUnFEM3JBUzg4RFRkY25ZK3RFZUYxZStC?=
 =?utf-8?B?eEkrWFRIVWhvdmVzc2RtYXZSVnlxZ0dVQXRwV3VTODZsMHl4MWJxSzVrbFF4?=
 =?utf-8?B?T3ZIV0ovQzZkK2FJOGg4SkdKdnJvV0UwV1JMSGxkWXZwUVJiUnErbnByN1R6?=
 =?utf-8?B?dVArWXcxYzFJYXZObGNxcSs5dTY5Njc5ZFpSanVXLzdyZ1hQM2w4Q2ZWZjU4?=
 =?utf-8?B?M0htUFNPVnQ5QzF1UlpZUnZnbFNWK3dZU3g2K0tUVyttT3hoWFFzMXYrcEM4?=
 =?utf-8?B?QjNIVE5nR0NQZXdKdE5Ja1pPdmtvRE1LaVJMNXpzdUZOS3lGTVZyV05GWmlZ?=
 =?utf-8?B?QUtYYXA2ZUphMDNZalJhU0p6a3pTYjlZVm9UTUkyK3pxVXlGeHIrSWl1STkr?=
 =?utf-8?B?RjljVWpOZGJsd0Z0NDlyRE1pL0RPR3ZkMmZtYjhteHFuRkQraEV6eGU2VGN1?=
 =?utf-8?B?MFNtNXBwc1h2T213RFZ1OFVkWVZZTkhmNFlGWG1pY3VBaTRDTi9HeEQ0TzBw?=
 =?utf-8?B?Uk1CYkpOaEtFQXZhZVJ0TEowM0pYNWRKT3Z5ZHJ4RzNOVE9QWlJMUjgvcU9n?=
 =?utf-8?B?cGdoZEhZWWt1SDZWUVpmSE01WENOaHJ0aExGV3lpZjJlS3JmbWRpZWJVcVpa?=
 =?utf-8?B?VlkxU2RIRHoybGdSRytqTjl6VEdiUmJuQ2FQaHoyOThHcSs3b1JqU3lFaDQ4?=
 =?utf-8?B?dHZJc1lTTmlORHlnMXFxM0syWE5Ic1p1UTI3UWpoTGU2a1lsNktYVXR3MkFo?=
 =?utf-8?B?Njh1VlQvOUlGRmtIRGt5MWtsQ2tPaW44dkQ2MzhDWlluUXNCTWs5aEd0SnBK?=
 =?utf-8?B?L1FmZ0JpaW5LZjNBL3hRenZmRS9QOHV3ZTl3UjRtdzUyeEZ2RTRSWjZtaVc0?=
 =?utf-8?B?d0krS3hjQWc3dVFzb3cvdDh5UHdndUJmMy9iaWRycWgrWW5jQjI2YlhUajBo?=
 =?utf-8?B?bTFCdnJnVXh4UG1qRWtpQnM5V21KVWF2WmI2N2xwREM4TkVQYlBkTTlzZ2Qz?=
 =?utf-8?Q?zoh5UIvwtU8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S09qejNGZG56bWJXT2RoSWN5S1h4OG1NUFpKMjY0eFh1ZE9nSW9JMmdqSmVr?=
 =?utf-8?B?YlpuSy9qUDdMMnFwOUhtam4yZUFBK1hndGV6eFlQQnBiTmlqSXJGUkpOK2gw?=
 =?utf-8?B?cnZvcmd2ZzJKNDlqN0xJcDIyTjg3dDEySzBpczZ2K1M4K2JNeGNNcjQ5WVhP?=
 =?utf-8?B?OWFXeUxadWN1QTd4YytBd3ZMZWNMVFc1bC9BbERORWx5VkYxd0xsbkR1aU95?=
 =?utf-8?B?dVhCbHVuVThlTnFtVUdvVjdXSjRzNDJETkJsMXlGZjBqb1U2bnBZYVMwcERs?=
 =?utf-8?B?WEllUUNhaDhxRVdrU1V4QURHUENsMmdDQzh5clNQOUxKNTBDOTVyUGNUdWNm?=
 =?utf-8?B?Z3hKUjVuSEV2Zk80SkIwQzJBV0V0a1JpeSt1MEZZRm5RUVJzb1h5ODNTZlAw?=
 =?utf-8?B?WDkxemRHQmxUSTNZNGQwekt6Tkx0QUtOUFB3M01ZZG1nZWZrUGszejUxZmxa?=
 =?utf-8?B?aW93UzJWMUNYc0IySUxYZkxGVm9SZ0dMbWE5ejNjS05OUTFtZG9iNElzU0tD?=
 =?utf-8?B?aUVZY3NpZ2ozMGxWUzdYTjRkTktvT0VTUE9BM0owZU44WnRoYmhvN2xlQXNZ?=
 =?utf-8?B?SlNRb2hZbnR2SWZxdHdUWHBSMjJSUlZKV2VHQnBJeTFMS2I2ZHdDYng0cE4w?=
 =?utf-8?B?Z296R0t5eWI3bStjYmJYWEpZMlEwcERaMFZxY0dhTGxEQ09Wa2lURnJ5dW1u?=
 =?utf-8?B?WnhLWWVPdDRJQ3prMFJRZ2psVk5WOEovQWt0dEl6ZHI2VmFnMGV4dDJZMXY0?=
 =?utf-8?B?emIzTU11cEQyWlJHUHJ5VTViQzU5bkxva3dMQUh3YXVseFNncXVMN1FFRlZo?=
 =?utf-8?B?Z0EzWlN0NnVoZ0dKUitEd3R2UFpPbmVQRTByRURCNFdvc3lKZE1qbVR5U250?=
 =?utf-8?B?RkNzYko2TENMNW03dzlOaUFnVllNRHR1ZlhGZmI2L2czTW14TldXWlhiaGxz?=
 =?utf-8?B?S1lTTXd1LzI2eUdBTFV6aGxKYXBZTURtQkdPajVNblZkeUM1WXJWVEg1MUlp?=
 =?utf-8?B?a0sxSm01QlRabHJrSVlTOGg4RFlTNWp4QUFvcXNydGNnSXgrb2Nxc1VPZVlC?=
 =?utf-8?B?WDZoM0xZQTlpak0yRWI1RUloZjk3bzM3OVpGN0JYMW0xcm5Cd3ZNZTA4cTdY?=
 =?utf-8?B?QmpEbnFlWUYvQytTR2V6WVNRWUM4bkRDS3MrcDQxSFVIL3BVNG94WHdrWGox?=
 =?utf-8?B?MUprVkE2M0RrK3dGaEtBUFAyWExiREw4R1FxZE5oZDBOZFhYZ1Rjbk9qMW4w?=
 =?utf-8?B?RVYzU0UvSEFCR2ZKd0RKQ0F5MG0rSDNERVpEeHhOYThsNWhJV2ZTcyt5dU1Y?=
 =?utf-8?B?NkpmMDlkOUtZZE51amlSTm8yQWtqcnVVZmIxRTVWUCsvZEpmSGs1aVVTSFJD?=
 =?utf-8?B?VEFpcC91bUsvTitIajlXY2xYUlA4cnNickdrTE4waTBjcWZGM2MvUXFZWElq?=
 =?utf-8?B?U25DZlFKYUI5Umw0R1ZTcE1QdlRISXlEVGhpS3MvaGVJVHNrT25nNVRielU0?=
 =?utf-8?B?cTZLSmVtcFFRcHYrT3R2UjZMMldSM2xBQlJIUXJMYjJHRDhRY3NPOFBCSGRS?=
 =?utf-8?B?eDlYTEtlZDlnMEZGb0VtLzlRdmgzQmplNGw3SGMyVWlhZlpkUU01TWs5WDQ3?=
 =?utf-8?B?N2hvU1Y2cS9UcGw0d1MzTjdzd0NmTEhmcVJnbk1GYXBocWFKZTFGUnpPVUli?=
 =?utf-8?B?a1cvL1BBV0pmczVnSEgxdks4Ung2THMvZ1k0Uk5FNCtZdG04U2ZaZU0zRnVt?=
 =?utf-8?B?WlhoWUMybGVrVGxvTnZ1TEhRaXZIeGdRdXJxbEk4YmJnR1JNbTh0TnM5b29P?=
 =?utf-8?B?Qk42MHhZRHQyQUY3V2FBVVVWQjlLeUtNN2xmZEl5M1dnQzQxSXcrS0llUGZX?=
 =?utf-8?B?ZUlYaHpYNGw1MWZ1bUJ2MkszeGJDeUE2TjJqTDNINkR3eEJvVVFhc2NPY3NI?=
 =?utf-8?B?cGdiVGZiUW1DY2E2d1JkT2NTRjlpelI5MGt1eVlQbEhHYzVUUDBRZElSM0R0?=
 =?utf-8?B?blJrMjRmWmt2bGlNZGZsaGRqV096eGVOOHE4cTVCOUkwa1FaMzY2Um1XWmlD?=
 =?utf-8?B?d2RieW43RHkxbUgvd0Y1OEVHdDAzanZRMVJHejZoTGxHaXhuNmJXNUJMRFFL?=
 =?utf-8?Q?ayfNpG+vjDrY9CVI1waILD71d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5cac327-c0e8-4e3d-87b8-08ddfc786925
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 21:13:44.8511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGTGLHuyFR8QboHMuv4YrSKE/YRcBp94DqwrPK/Q5MfOVuZl+cJ/MaU0gXI40ImIqUONRAECbD6vQqvdi0pVoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7075

On 9/25/25 3:53 PM, Michael S. Tsirkin wrote:
> On Tue, Sep 23, 2025 at 09:19:17AM -0500, Daniel Jurgens wrote:
>> Add support for IP_USER type rules from ethtool.
>>
>> +static
>> +struct virtio_net_ff_selector *next_selector(struct virtio_net_ff_selector *sel)
>> +{
>> +	void *nextsel;
>> +
>> +	nextsel = (u8 *)sel + sizeof(struct virtio_net_ff_selector) +
>> +		  sel->length;
> 
> you do not need this variable. and cast to void* looks cleaner imho.

It's cast to u8* so we do pointer arithmetic in bytes, which is not
standard C on void*. GCC doesn't mind, but I thing Clang does.

I saw you had a similar comment on a subsequent too.>
>> +
>> +	return nextsel;
>> +}
>> +



