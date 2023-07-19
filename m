Return-Path: <netdev+bounces-19125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E7B759CE6
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84901C21098
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 17:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD095154B4;
	Wed, 19 Jul 2023 17:56:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E41D13FE7
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 17:56:22 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2106.outbound.protection.outlook.com [40.107.220.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEC62106
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 10:56:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aF+cmCiBtMepHGhUWKjj77f/OdSUhOY0sWRSdIn8dsAiY8qFolvjfsG4DVmflgavD48acbN1CBodYi98ZYmDX23DbYfm5qS714GZIYmBfv9d5YaI2JAghgGdLMhvA6e37qepdRTC8kR/JbJ9cXRG2t3FjCDxTCUSOo16dDEgwrHJ7K5GsoWR6L0nFfJK6joY72fs5KMcdYFklO7kBk2n12O56dME/6IPF9qUkKjh9PQy/fJyvCfPLk+X6dNMMTjvq5K95Nppyui2M7AUVLVKyilPLp1JkVMkXjlPG9ZMes9Q7CHAWmEOu/kgh5EFhvyUeHR+6Emtpv7L0UVHpM7Nxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZyEIHV04ULcZb82VWEyog5gnpsNMtpLl5thpIvH/T0=;
 b=IA4Cq9gpD2WsU1TxjyURRcIIZuKgUxL800F0s1ycBAUBqeopvYaCQ6FG1Gx5ogbsebZCRHPZzIjRC53SbMeH/hT2KIoDanssuxp7W1245SbQ2gfcY2txxz/6bq5qxg0K7QNu4WcfjyY4MmENH9DB1udiqnSh727jyKfS74/kzsbIYjr2v75W3dnBalgPXcPZtzz2v04iWLhVc/3CmOndZnfxQJey7A++AtUJTYSaAdks8mlK+bpSoqU/X8pWe+5mI6xnIqaNxKhOZtNAhVtYusZ4aqeRtwUi73HpZ9iaODEVZE4lTkT4Sk+ucL0hQXnHDuyBS69AdThbom4efwyfgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZyEIHV04ULcZb82VWEyog5gnpsNMtpLl5thpIvH/T0=;
 b=Ixr34ecMhzb73c1+5+AH1Gijm46I/I3EUDlayq8lVavIiSO149dnleAFOXSaM+K1YpJovZBhX3YfbL6QPfXT/wHtK4JfTldsy++ViKoJlTia7Ac08pi/vk89d5nmEKAQJtZWsScW9VHd5ymlyueE8wSTokBt7OGMTqkuAC4OQsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW5PR13MB5487.namprd13.prod.outlook.com (2603:10b6:303:196::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 17:56:09 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 17:56:09 +0000
Date: Wed, 19 Jul 2023 18:56:03 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	idosch@idosch.org, brett.creeley@amd.com, drivers@pensando.io
Subject: Re: [PATCH v3  net-next 3/4] ionic: pull out common bits from fw_up
Message-ID: <ZLgjs6a2KJ3xEh2s@corigine.com>
References: <20230717170001.30539-1-shannon.nelson@amd.com>
 <20230717170001.30539-4-shannon.nelson@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717170001.30539-4-shannon.nelson@amd.com>
X-ClientProxiedBy: LO2P265CA0210.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::30) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW5PR13MB5487:EE_
X-MS-Office365-Filtering-Correlation-Id: 1811e168-76bf-4724-daae-08db88816edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dbbcP9LGGY/N/EFpJePE1nNMgPvtyHBKElQAh3JpkLaAlFc0AczXPALVzyqqYck60HqH6uPhvvdO3HI5gG+i5eVbZoMW9O+tGhQzOYQg/hexkdVcJKcbjTCxeqpb6f4CjynEBUzaqCBpih/yy0Zb7AVK/nMMyBmaM+05MAgv0MIFCDkuSTIyWQeU2xtD9ShO4nd7HAEKOyZg/XrTsJJY7pDbBj7LLXN+IdnRA8O8PBpLEQKCKDe6hLrLWPRJ4kdgjkWvIA4cG6fq5nOanFewIIf0LSh6uK8U1/aysAWl6w++eStP2G/3heCq+MZCtEusvnNIpuUBiEYWSyCHQ6VwZC6DY9Yh3lO8o75B4Cj6JuIAoUa7CYDqVuxuOximyDAIMlTvWHHWCqja+wMMzif76YGueJhfTQHk6ecEm8qpq2YRwMTP8BrgETuG8jU4SthhP83NrI3qp58EchDqK+cXID7g16wfi1v3PVqWqVLQJ2wpQ+Ko4Pb+U5dpEzBlMTUGujpKHpCjnjl5C5+yqNAPgMVU3XI2/ws5Wf1i9n3fUBuSjiXklrY2JKMpG/3FTtMf0SpHIiwLJlKiS3HgVUrPu20FX571JV9p4qji4SOxgEU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(376002)(39840400004)(451199021)(66556008)(478600001)(6486002)(6666004)(55236004)(186003)(36756003)(316002)(6512007)(2616005)(2906002)(6506007)(66476007)(5660300002)(66946007)(38100700002)(44832011)(8676002)(4326008)(8936002)(41300700001)(6916009)(26005)(83380400001)(4744005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T3+ywdP7n6xNQ+y8izMVkVabnK0qz0a6VNuIcTDvmOJAL4fitAkbeZUnduNB?=
 =?us-ascii?Q?owDHgc0AAhp/eW6Mg7cZUOV98djiXSy2iPOcmSQS4v2fSnlMsHSMzD8qdngM?=
 =?us-ascii?Q?53Ak49nl6EnSeSJlspqQwtx7KWEf0/cTG23i4slaBYXYMqg+mDdqfC7RXm3I?=
 =?us-ascii?Q?L6cP3TaBmxxAk8GZr4q14R+G4U15GxJjBKE01KxIsI4UUX+VM6ZfI86jmqVH?=
 =?us-ascii?Q?0W3xzaWtNJ9mGrsltULOM5VyixPFKNqcXeb3mMyA7zlEpZPJoYrSuXT+5hAA?=
 =?us-ascii?Q?8lfHI+w3lLFNGxyD5C1uiUCj1WKMawrJqrCCmP2vNYxUKtumzCJtjTboB2bO?=
 =?us-ascii?Q?pfVQGjnbOwVYDok6m35irB97oTSMDql8Kz7YUeXJ6nA1cRKL6P7m00HXKYu6?=
 =?us-ascii?Q?FEs/oExC8eMcFeFCEyO3Jn2E25p6/wx2fqp428gmdLn2/on87R/N8pPZ8Gnu?=
 =?us-ascii?Q?KMD9XUWtXaVCsor6DCld+p6Y39t1vxSVuSH7kOvHFQBBeSiEJrfBzoSOSCx7?=
 =?us-ascii?Q?/Q+az38zmcqelDCxHZeaqM3+ujO46cp9Q2kkiNad82ORTVss3YwXbUB8Gxaz?=
 =?us-ascii?Q?ne0fNl9QWiIHdiyI4aKQ/18rH7hTxunCIXLiiQvptAQRLC2koq8Cs+GcnsGk?=
 =?us-ascii?Q?Vz/9kGYZKjE1nV3JB+DsUJTkglaT/Qv03VG9CiUDGwcdfzqSCV4jJEraXaeM?=
 =?us-ascii?Q?GD7G1Muz2h0j031itK7Q1nfHTpfzYk10C/X5yTNVYNVwkgvc2sdpucpUMdP2?=
 =?us-ascii?Q?aT1tJIywJeNMij0BmoHAi4TwY6yUrCoTcnXGLrdGdOe3kHrS7BOZtvth5YVg?=
 =?us-ascii?Q?z22+7QuOqmAOoLo1DXhwKsDxTPkRacu04JZffcUtbeI+JJ8hnSbqjiZRNfrY?=
 =?us-ascii?Q?tsjokh4PPU9ZLRsrz+PIg/kQwu9rjQdfzhniKVz+cw0RaofVavMAisp12GCr?=
 =?us-ascii?Q?Fu9P/ePj+A/RLmeNHyAHdYJ49sbDsWdTouINi/A6wx+DLALqTDGP/ydq1rX/?=
 =?us-ascii?Q?NaTvySLznLtSrZlRR77Lcf97QYFiRS+NrypMfIlE4ih6HqkPg7FFrD1Lb9sw?=
 =?us-ascii?Q?DklLlCHfV1pIcmu7rf7X/Q7/IiwOTZ0Qw+hbEdwUxy6aJmiEj3tjXj8gegls?=
 =?us-ascii?Q?c7dWBlkjERU0WpuETEuWkApliX//g84iG+yPPc4r3zO+b7D4WetsxSWAzURE?=
 =?us-ascii?Q?or3fUdgU9yfm51NeBbqRnUct+yDEkvR5u8kmomxQ/zDA0gsGNnugLGouo7Rz?=
 =?us-ascii?Q?reh0hFswF+0MBe3YVsRk9hk9GAsQ6kG1rcqScEa9qCIhVABMc/G55tva1Hyz?=
 =?us-ascii?Q?eYq2uhC6OqWv4dRxbcxHA4x9kpsi8O42wWRba2F2R++TajyHt3MXAt49i4Cq?=
 =?us-ascii?Q?zauC39QNel9iZrsnx6GjDFrJnu/qnUDVtHAclYR3MtUc7yK6FvFB2xj0lTz/?=
 =?us-ascii?Q?IW49KDo5B2F7+ID9V/aoFeE0Pum1IsdYa7J3M15z+sOxutXZwIMcGENNfk5+?=
 =?us-ascii?Q?uTkI0nrAHEP+yf4Ym/eKH2UmJmY2E01N087Aka9qKC3cB6XSkwYvoWU964jx?=
 =?us-ascii?Q?FkPddySJOr5Q+KRvDQik0R4CLq9vfKGZ5GK15pW3Ex7FijnxpPVRYUTOs7hx?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1811e168-76bf-4724-daae-08db88816edb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 17:56:09.6836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /taXKpYqbvT6hsFR4fEM1mOpiLG3tPUWWuG9mflO4yam7UBg+MniuUKkpLznTykzn5kkKY34Xhborz/Uor3GFQVU8mPHYo/2VGxB3Lx6wPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5487
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 10:00:00AM -0700, Shannon Nelson wrote:
> Pull out some code from ionic_lif_handle_fw_up() that can be
> used in the coming FLR recovery patch.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

...

> @@ -3317,17 +3301,13 @@ static void ionic_lif_handle_fw_up(struct ionic_lif *lif)
>  			goto err_txrx_free;
>  	}
>  
> +	clear_bit(IONIC_LIF_F_FW_RESET, lif->state);
>  	mutex_unlock(&lif->queue_lock);
>  
> -	clear_bit(IONIC_LIF_F_FW_RESET, lif->state);

Hi Shannon,

Moving clear_bit() inside the critical section seems
unrelated to the patch description.

>  	ionic_link_status_check_request(lif, CAN_SLEEP);
>  	netif_device_attach(lif->netdev);
> -	dev_info(ionic->dev, "FW Up: LIFs restarted\n");
>  
> -	/* restore the hardware timestamping queues */
> -	ionic_lif_hwstamp_replay(lif);
> -
> -	return;
> +	return 0;
>  
>  err_txrx_free:
>  	ionic_txrx_free(lif);

...

