Return-Path: <netdev+bounces-19798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CEC75C5D7
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 13:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50ABC1C21642
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 11:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E711D2F4;
	Fri, 21 Jul 2023 11:27:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB44714F87
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:27:10 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20718.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::718])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4360A199D
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 04:27:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezybcsY5PMStWU7lPk80lN8oI+LdxaaHsWYpK9hcU21HFaZ3qxT+UkTMm1ctu5w4ToDR25rYiYaa4eTCKRmaOf7C25gaHrVytniRUPM7iDxzHBhDmb9/ZzNKu3KqUNtaDHeB1FGMcQ+1CDgZGOKd4ihkWSyIE7M1SHNY89YznJaWPR06/mwQIC5bGwzocCYi1bX1hmnxOt+JRBE0jWuP6O84VaXyXC/5X13ddHYLQOpqsPLf09p/JZcKH3h6ZeCp1ER0FyH+YlWITXdSDV7b7eftBBx5wGOF3oe5srNd7MLKSNQRHkBS7zfX2DAvkc5+8oWSgvHl+XuAQoRZgmdS8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRfYL9eEBl0bfBi8OZdrSDm3mwTn7UEj1xoKCCN1W78=;
 b=jy6S2NktXcE/T/QmBfZEoz8FCXi5ux1imsT739ZAWD5xbZLLoMW2pmh9bf7XgkaF9HpqnWcINCoD06juGZs42jAUlHrIL/2P+x1LHyol0pX536JCDYYBHYvy+fEOn66qBFJCTlnPzGKelZHqvjMOJmdp0jGvGnv1fH7ZryNiUf1Wgi7NAOEUsl2V9d/A9d+KjkDCO7CHbz1dBOqsJyHTSyzfVm1P4axYG2S+xn9KJRbvzHNFo183XQ73FE3oj3lH8RCuwvBGepglaYz59j8NlhqGhCt0bvfSuUa2TI66xiHK06KU4afsQYlm/uVfz+YaHy7NdClQSv3L8R16Q9W7pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRfYL9eEBl0bfBi8OZdrSDm3mwTn7UEj1xoKCCN1W78=;
 b=ejWkO/UHLpGUJ52ADPnDlrdZhM1zmIoUmkKL18Sb0ykKB0p8GRBEDC9jmGjCH5cJZ3aw1KFqVHm6mmQ7Q3zG/cHB6bJcldRtNjJemSARNLcCNf6jTWpfYOB25IPSxjmiNT2Oemi8ufwgOOzptR/MGaaCpPdi9GpsBgC51HYFucY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA0PR13MB3934.namprd13.prod.outlook.com (2603:10b6:806:92::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 11:27:04 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 11:27:04 +0000
Date: Fri, 21 Jul 2023 12:26:56 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: netdev@vger.kernel.org, yisen.zhuang@huawei.com, salil.mehta@huawei.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, lanhao@huawei.com, chenhao418@huawei.com,
	wangjie125@huawei.com, shenjian15@huawei.com
Subject: Re: [PATCH net 0/4] There are some bugfix for the HNS3 ethernet
 driver
Message-ID: <ZLprgMjesA9KQ667@corigine.com>
References: <20230720020510.2223815-1-shaojijie@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720020510.2223815-1-shaojijie@huawei.com>
X-ClientProxiedBy: LO4P123CA0611.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::10) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA0PR13MB3934:EE_
X-MS-Office365-Filtering-Correlation-Id: e32c5676-e8e4-489b-d6cb-08db89dd68c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lquK8FU4jvvrEFD/jvjuz2HPMV4MVa/eSOIVtYDvwF6iHGxzg1UaoA/yiw9Xc1hj++d0xbKuRhV/Bg6Ek82nAlWWGtzjjjitoqjSCQfTvvW76wyYSJm5+Z1tjDkyNpGLQQLpgzHVPaHRQYWSCunv4a3OAh96mSMvsUchS8Z31p7CrqAXo5KN1XwasAD0BNrD94TJo3Q7V7fN/iQcJ9BG7mtNEncduX61778UimtXEJ0ZbsX1Ynnh+h9D1RC2j3Ne0vOXcuOMgpfcICrbqUIKK9tgnigcODJ4n60mpv0XT10ZMzZzvG5C7i8twTqhgaxCygp9pe7sGRJ5ZYcSuEyNvcK4qZZOwPIcok/2XIzinz6d0QCSw3KNGMq/pFAm8oPI3x2ZGDw2dNGOx5t1dAttBq4Nudtzp9nu2550sLY454Bfdj92tBTFSFtbRUHU+vCMdJ+Nf0dQrm0aDDF7Eep/1+uin/2rs/UZorGcmMtKkpYJPGqfZXrUaYgmFdSCS5mu1i2BL1nCZf/Ima5kDS3WyeDl0QJDjGj31+SB6dl62D27+h4l1OAXh1hbIwY5pplJFM8uEhmWaV+DLWr0vV/gbuNHdEd82FV2EbpQkh0egXg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39840400004)(376002)(366004)(136003)(451199021)(6512007)(6486002)(6666004)(186003)(83380400001)(36756003)(2616005)(86362001)(38100700002)(55236004)(6506007)(26005)(4326008)(2906002)(66476007)(6916009)(66946007)(66556008)(41300700001)(4744005)(316002)(5660300002)(44832011)(7416002)(8936002)(8676002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jjoz5W+t5zjVGLCNq8NdGl34ah9imFNpcK64qMKket8Kz38VpT8aMUVBkk+G?=
 =?us-ascii?Q?iSeHjcurIyFHMm6z1AHAUdtmE2+CYqpsAwfiM/kxBKuOb1mec2wmusIGNUbR?=
 =?us-ascii?Q?CRTVgG9LDpz/V6yaM8ESwcFUPOlR3yaGkcMPRTjH5cYySn2yUXynSulY+KUH?=
 =?us-ascii?Q?8by4DFwA39h8dsS72v+h3yAT69iMqWgEtTnczcUjCTBUA9g0Z8n8jADQvXZD?=
 =?us-ascii?Q?5HrBjnIDkn1zhVulgcfkgtwIj53fnH5EjjtkgUNDfY9rwBU67fpUDvnW1krW?=
 =?us-ascii?Q?hlYLvynYa19FHI99mo2T56LVXS9l2J6uP+skrVdrtfpvvBBljWbR2ptoFlcP?=
 =?us-ascii?Q?NQmuVS7WfBR8WHoySqBxdApcAW5/HS9HEjLsY6GH+6rwSe8UtTWE1EG9u/GA?=
 =?us-ascii?Q?Vqe7BoGAAD6W6DDYVPKU1Xo5Jik5TTHnO7nIm4xxCXypR2FDSSYEy5gJUvsq?=
 =?us-ascii?Q?R9pFUVyqDTk2NjdK4Hdo25WeEvS0QhitCf1fo944ceXt4w+C8j/CeZtdTnva?=
 =?us-ascii?Q?TSAOFctOmVf62JEMIJmyTSo3p/68V9HPxFGETvmRC7pQbw/LOH3dcnNUPTar?=
 =?us-ascii?Q?F8RfHDbd6zhtci3i7gUg+5LEQ219Y7aw0Fu8Zp51AcltGEIAdnS9vH+Xxkvj?=
 =?us-ascii?Q?iYbNWPbUYlrxBQyBKQhrobpV2R+f2LxLQH6p/iAqbQglqQzuzg+ac5SLPtVD?=
 =?us-ascii?Q?/ZKcHOeDX0LbrKpqVY5xL+h2XCvh/KjVOLVsUMy1r4A5n4QHPk9YmN+zkfZc?=
 =?us-ascii?Q?C5z2v+qmpjKgF7ZFwW5AWanIKjA/4uALje5y8aAnT5aQCHnAjTttNvFapgeT?=
 =?us-ascii?Q?T7fyouoAkmoMQYrT4djbI7rplD3PQOKPECl2o07R9z3Fs8lLTIHEGhxctT2y?=
 =?us-ascii?Q?FfPfsBMX/FX+eWv3Aw+Rj+hcubUi2L453n4iKm6h2//YEyOu/2GNP9zquOnM?=
 =?us-ascii?Q?VtlnSyLaVZp97BBRGc9+L5kZlOCMIN3IqoJQZ98Nh14rYraKKDZVders/FHU?=
 =?us-ascii?Q?8UswOf1kJrogBHXwICRlkeLY/Npd+XBCt0Iu67fGwWTtaxvA7ikNL7+l+n82?=
 =?us-ascii?Q?6dypxW2qUgTz8ut7R7H8OQDJPpJCbYhrJ0WbjfMzlvIgHPfG6fX6pKUdsKRl?=
 =?us-ascii?Q?PiPwoLez0dN1CP+KoyBENtPu/PKxfK4jXBrgDOK94iw6yXgpS5zlEBwxTl85?=
 =?us-ascii?Q?gCnMgiJPp99MMCpw4QouSbhsTGFexQRIgf9YCj5wUZM8pahYtMqeNLiheyys?=
 =?us-ascii?Q?1MnLZaN1MqmCOzJNb4z/XSvbjsVm0HrjhMStD2ECrPQsSJtmMbL4ncByrWV+?=
 =?us-ascii?Q?wpSwY4n5mhzhRkSDKavBWNKv30PwtRwzYASnhgWxsvTjjC3wqW0M0CxDOc47?=
 =?us-ascii?Q?0c3MPZ/nPnAI/4W+mXYtLCdU3VbbKTLLog71qmm/lcTu1yso9tupHEuuODyL?=
 =?us-ascii?Q?0k++fhQUeNpJFp025+2UU0/YUGpsb/ZW6I3cpbdhhCPA48McsFxyicvXvPo/?=
 =?us-ascii?Q?KJvX+xcUduCBJXW2Wad+ozaKYubkB9IU5PLgZa38shdCA6HAk29pxdNw2Gqf?=
 =?us-ascii?Q?oazh/rIwnXqxR81E484aCNHJiH1pP/dWNtszxKq+P8QcJgEkff5SRffLQ9Gf?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e32c5676-e8e4-489b-d6cb-08db89dd68c1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 11:27:04.3049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdNNkSwqu3PUz28P+RP3tc8zFcICS9eGQP5W+uyEHtpROnpp/njDNpnTJrXvwnNjo1pSl5mdvi0WsEk+GPac6bzw5vufCYV9m+0y5SYDJns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB3934
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 10:05:06AM +0800, Jijie Shao wrote:
> There are some bugfix for the HNS3 ethernet driver
> 
> Hao Lan (2):
>   net: hns3: fix the imp capability bit cannot exceed 32 bits issue
>   net: hns3: add tm flush when setting tm
> 
> Jijie Shao (2):
>   net: hns3: fix wrong tc bandwidth weight data issue
>   net: hns3: fix wrong bw weight of disabled tc issue

Reviewed-by: Simon Horman <simon.horman@corigine.com>


