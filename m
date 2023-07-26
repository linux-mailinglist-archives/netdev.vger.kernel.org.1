Return-Path: <netdev+bounces-21362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1197635F8
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4163281013
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 12:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6DCC131;
	Wed, 26 Jul 2023 12:14:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612F9CA41
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:14:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2134.outbound.protection.outlook.com [40.107.244.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B44E1996
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 05:14:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izP5Paj///BnkUj1pXhk2pI4PYYfhZi4wKtjAKU/XJ80aB+AB+ZsxAt+tYZK0mmeQzwtw5lFmI6ooub69RrJeuMLHFQPKOax1cyqtKbx+zN2eaP6jGwtcvVL+ZkQfadBOnNT8KX47jaaREZ2S9jfmQInnDqXbKaX1ccOAJUBFdhpNBlMT+JccXdFEebzNcsAJ7GxQqvMTOZxbIGMYJhNSoAmLnNlOtd42vrTXh+UgT11jTfHiz4WaIrYv1SW7XHZDKMS+MiIB60ukVysTNKNp8Q9V/bPU5kyla0Kr523bRlkRJjiVsEZmPBb6m4GL+hZVBSKajVQFMY/Ok1nJMgidA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q29Y4cZzWRu5B0V46t4XmIdqX/EdAoLzZCrSjcCctEA=;
 b=l2HWMx5t0MuxPLErAOPxT2DkVFdkp4wWe0xsaUIiDLupa8fwjuRT9o4W0jmDYqcfinDPdJptTo//uPhr03vIszSCj3r2wLz1HD+TgwoLMKtxvFoK1u1CnoyCgY966pqK4LucspkOCUm0gTdufS5I8YKYXaLMgQ4vNPrBUw/GRn0Ri95ZsmKmzcRyxTVUKSkHGpr60qCzBnRg6M2cKMWxqC7pgAJOFKYfX0L/s5O0H+Cn0rIckElxYCOA2Yphl/SiaAAgER2+D542A0jMMK1ImA0FZDcKpxOjbbe44lEORNlWDffZpniVf3QMHDa1Pp/alB1H8+ztjW/349Vtosaamg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q29Y4cZzWRu5B0V46t4XmIdqX/EdAoLzZCrSjcCctEA=;
 b=ppXWiE+uJD23CMhq91joo5nb2laM5TtJFG+QkjwJw97DaHOS2PfbfeQMtrUVXqv3QTttWJ58EK2jfmsHwsdv5Gn25ViViWRby379jOvcLVWeInjWVg0N5XDU2SeT3Xms9BZX7ClsFsDOw7xivpiY+5gik6yHQM/sGb1eOJpl7rQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SN4PR13MB5710.namprd13.prod.outlook.com (2603:10b6:806:1ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 12:14:21 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 12:14:21 +0000
Date: Wed, 26 Jul 2023 14:14:15 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, Jose.Abreu@synopsys.com,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 4/7] net: pcs: xpcs: adapt Wangxun NICs for
 SGMII mode
Message-ID: <ZMEOFzJgFG5oamuQ@corigine.com>
References: <20230724102341.10401-1-jiawenwu@trustnetic.com>
 <20230724102341.10401-5-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724102341.10401-5-jiawenwu@trustnetic.com>
X-ClientProxiedBy: AS4PR09CA0015.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::20) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SN4PR13MB5710:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e6cd142-86bd-4ab8-31b8-08db8dd1d7ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BrcFZYjIoAArFALDCXnKb81kisBGrAgEE2EfLicDZCZzgDh5HbTc4u1JjEJPzST2BvH1EjpTIPYiX50B1QRb88/tiyS6VD9YP1yqO8IcCEsYP7NamZeLEHbaEbfeXNtV5V3h+8p8Y/qcyRNa6CUmXbzlyIlXSXemGOqMIsyxQEaExW5EikOhpk6lJ9Kk6QxUzQVCOEzm1Ez0/jBYhe/J8qGfvG3SQZPv7BSvHQXdA5cF55slv681wcsum6Tghn8ViHSMl4albp/h+1tz8zEk2FF+aNqaXHpzXg3VSvwEInOJu9dEvkolSxSL6kdTLl+2r1X7A0xosAUTVaged97PEJb+5Rw0176BhL0gm/N46VgKbuJ7sWn8uh3u69QSCltaFyqrj0D1al7KVTo5Dr4TvlbzvzaJfDNVj0rB7/4gsDCzi/1qrlSOXbQSbiVxb55GGzAamiYspymQIBqduhj8cFAtsYPJD7k1saVuzHzgjth44nyQ/p8Z/m/RBSu+7S10NJd7441v0CrMry/U3VGMGGD06zsGrerFbjb6PKLYP/K1oVnC2z6IMjECa1J5LxzGMbQS1ntOyrhpArfBZkgabVjccEUpnwBZLys7WO8L4mE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39850400004)(136003)(376002)(366004)(396003)(451199021)(8676002)(8936002)(44832011)(5660300002)(2906002)(38100700002)(478600001)(2616005)(36756003)(6666004)(558084003)(6486002)(6506007)(6512007)(186003)(316002)(86362001)(41300700001)(66946007)(4326008)(66556008)(66476007)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yBlawzn5pMsnixe9/65v7VVX9UGB9Y2J4vqc/0u60R9xcvVmQMDHr8QBKUhL?=
 =?us-ascii?Q?bemYiND87wVnjRmGV9prBlaEpbP3ugMZeAMRXdA3lO+t/S5xWLvlzA2pocCo?=
 =?us-ascii?Q?jNJGoasvtmGQ81KR5Rek26I4D+wE5aLIcnv2AHARPHBXXQ9S9zOr7Cjcen89?=
 =?us-ascii?Q?omFNNqG2ExooBbBu2LCshK2jyWDCjbYJi0f/TPcNvrIuYYKXnwwLbSrbPPF+?=
 =?us-ascii?Q?iF49cf9qyAeQDbNxp2GFPoaHl/t7AvejNMAfmk6hx1LncmJBUq/JbokbBluF?=
 =?us-ascii?Q?DTI8/zMTeyrh/tbTX7OmaHeg3IOnh8cV55WXTNARaP/nBJFlszuaineo+w5t?=
 =?us-ascii?Q?9oz3R5k8/OrOAztkkECOYCIqatij0jtT1g7+4OF7itmuOJuWTuRoeMSeFpuW?=
 =?us-ascii?Q?q8Gc3UUXrGD4QujlEkDm5Kg23O0an6OnaZ/GVxhfSYoucTGzU4pkNuI0VBMm?=
 =?us-ascii?Q?S8DMwA3SW90GyvhNmJd4d49BX8bbm0/oKIvv+YG/xvzAMRCI0F3g7ZkflO/h?=
 =?us-ascii?Q?w5Jn/bIffc26Dm2xNj5mpTTdr1vsj3VwMI2dwUcP5k+JfmxLeAg4jzyG/C7n?=
 =?us-ascii?Q?rFbjAgYC/Rz1EUYOAtaF4dNZBY78lNK3j8K3b+mZuRzbBuD2e9rq24AWT2nj?=
 =?us-ascii?Q?6HGEjpxpbF/YwycpcGivkn8ARAoT3abUqxhtob6GQ6jUlUWa8rwL613SySVR?=
 =?us-ascii?Q?j2JS6coewfTtXVKz7UcM8C2leX+8laQb/QRiDlT5jVf/IQn4MdFwtmbFT0/+?=
 =?us-ascii?Q?WNP322SfpdV45uJ7jbUflfuq/628JFyZmMdfwsaPlDQZddrh3DzXP70BFOJU?=
 =?us-ascii?Q?DNquojeX+PxonvTv/yXmjIyICsEF/Soqzzal1kLr5CVeGfZjfNMOczxm1RZc?=
 =?us-ascii?Q?Sofz136gqCvkS468S5ooUTzy14MfZrHPNdkRiRG+HcRiH8dQV4K+fxxVgtFJ?=
 =?us-ascii?Q?HaaG/ZdZmGCfxGGV+yCrzqryio8/byoyuoviv77JUUuGnXzVKFCeQYVA4t9x?=
 =?us-ascii?Q?JmXxKmvqCAN5uVf6DV31z+YTncFtoZTeG7M0Cn64rw92stn+x/UHo5Gj5jF2?=
 =?us-ascii?Q?eGrE0hQzSxhNbveYxdUV5Ga1awsbAjSLj/5mhV9hBbXdyJNFYHoOJs5pXyDD?=
 =?us-ascii?Q?HrhOhRjcYI4fsLcjy5dHB52Z8+1p8qYPYE4jnSCIi9DczxbHKvsq9i7IHOFu?=
 =?us-ascii?Q?Hj0rwN2H1Lw9u90dRa3/uhI+V9tjIPNUJYrNA6i6glHdD6U/Vjt3wSF9DU81?=
 =?us-ascii?Q?LNw1E+JW/+Pq8AhtGVQKoFbmcoS0qelAl/bav/ZzzTPPjYuRxFcTaoRi7bAs?=
 =?us-ascii?Q?AP9G3V4bvj9fBeER1t8ZooQ8zG9Qi2fgCEjbi8Yixg1Fk5eYL7po/BSpBjbY?=
 =?us-ascii?Q?JFQwAuL9jb0sypzvXmH+o6/71X3FX4YOaLggEfeSGH30Xm3/jTFdA/lzMeV5?=
 =?us-ascii?Q?GIF7fZ0iUnxpe1OrEfVmXEpmoRje7YK80cFPW8Un/yzQkdBwoPQExgAtHdtw?=
 =?us-ascii?Q?aeOp7CMB7XRH6MHO3uUVjOaId8XL9OFNp0meL5B7rzC++CfCY97obr8DDd6B?=
 =?us-ascii?Q?9KYAIm2tbnRwREOrUmQOg1e0Ilpo3zGFK8adHkXANzqcnBnQgCXbFucbiC8+?=
 =?us-ascii?Q?3tIhycNLtPYBg8T9jPL8bZpLj4vqfnRT5E+GHcNWAkHfHmImnwhr4psXecov?=
 =?us-ascii?Q?Vx3YGw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6cd142-86bd-4ab8-31b8-08db8dd1d7ed
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 12:14:21.5047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYzZ35hmH1AOn1d4H0ornbFxpu5mZiaY7IEqtSvpvqTdHUP4PI6ZIdbLcbu068tyDsZ0i/mOMBCyppoDiO8clBgRlx2fmnmO6FSbn8Y7MeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5710
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 06:23:38PM +0800, Jiawen Wu wrote:
> Wangxun NICs support the connection with SFP to RJ45 module. In this case,
> PCS need to be configured in SGMII mode.
> 
> Accroding to chapter 6.11.1 "SGMII Auto-Negitiation" of DesignWare Cores

nit: Accroding -> According

...

