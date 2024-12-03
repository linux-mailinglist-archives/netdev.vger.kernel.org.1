Return-Path: <netdev+bounces-148500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441EF9E1DC9
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0473C28101D
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 13:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768841E32CB;
	Tue,  3 Dec 2024 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TTgAURU+"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD241EF0A6
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233175; cv=fail; b=PpalLahX4klAkG5wCiFyYZ78G0OS2F74v0QN+62RYJbhCtVFb3jia2Z+ivqAJPUJ8j3ABrTgFDQw2xh2lcOU91/QLeSltfW/6lwEdW55I3FlAk+NK846Tx5aTCLVx1JmsicXs17DOLI1WaW/q24Fg9AgAfxAIZ8hgpHHwAMBLiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233175; c=relaxed/simple;
	bh=fIuzTp7UYG8fblH+/Q0zDdpca3ZQjoYFU/diaRKxqbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kJvQodakM4012W24gGuJpx/AM8lxtdaaDvuHDTBw01tvLwliqp3raucX0e/CXuP51ikglaezoslQsVMJhfDhEIN9KXHPqjQCP2bNmftBGSAQnoq4MRMFJfXk6asVH1M78867m3CSN5UtnMIJ4O3vlatq9cJbJuK/VfdXYug0XRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TTgAURU+; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMzqRFxCY7b1VrZTlZ6ofrxF6JHT6BFWanOqR/MqwrRp4HYCSTzKrmNrMe5U9HipH55cd2XSbPHljUUcENpjbrqQB+ymtNRDoenTUkf5WlLbcgd/Hs5oCiVW4a1T8OZB5rN4mNaBZWQ19YB77c1N/1aUw4VKMddZEHDo7nlxM6CPjH/VTFbVkjX9QPlc0XnZ1njUHVeJWjJzYmM7zCVK0/2ExUmq6x1lshvzLbPslJV/QjcIGCvfBL5W4BMxRB2k9BIRBKyHThGzewHJiX9HCqV6owEE3lgbFCy53qIIRGjz1Ma8Y4Twp5rJeJEJsVrDp4rTWL/PCDleqIyQAI4zZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIuzTp7UYG8fblH+/Q0zDdpca3ZQjoYFU/diaRKxqbI=;
 b=U/0gzh3hIS+PRNuqGmqXJc7q74cv7SZBOUTMqo6Zakm6rKbEDH9Cf2uPJAoJ6iPG73n0HIzRoDGotyLgw+cZn+6s89LeYuMOxTb2IufQhyjEJh2wy6ADUKxfAiqlbm3FEk6A72vKG1wIITIQCNGRKR1GOZMz3kPwJjylJt7fBvQHH4mRcA+4Va7X+ZExivzk4l+TQipRLEPbRrdaWwABdnDOH2iZKs27fLtfewyrb2/I9M5EM9WngfXA1RpEzjjLQluVT80ZXGbSUj1cp7gXWQHRu/t9SxPZF9QiQt3/YK7YF/pajiQpOHRPdnCodVonkWTQvKROabojxhdkktr6tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIuzTp7UYG8fblH+/Q0zDdpca3ZQjoYFU/diaRKxqbI=;
 b=TTgAURU+dOnlnwncG1Sorr7JDFJ6E9Jej1KoiIeKFYT0/vun72FSrOUOiBSow8qPV6ZdyA1JvBhhQIO9wCF81+j59PocMB3g4MrwMKe02IuqR8aLafS3RSqzrVFQzjnLnnGQSEj7U1Z5T/KSOx1TEgab2KO6OeAu49EV/I72PzexCO0r62hE7etH1PEvp6yEXlbfG+hXeNxR44r6lrqha4G0rXyjhDOdO70SnGlAQ1QOdBsUV3W0gTNypeZiK8+ZfxttzmpHy3PwUU4QNU+HHpnOdiCLIo6SC7PJT/7GpnD8XeOd5x3ASLfvRqBNe7nGIX2X74gTlsJSUqVz1dfE+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBAPR04MB7270.eurprd04.prod.outlook.com (2603:10a6:10:1af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 13:39:30 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 13:39:30 +0000
Date: Tue, 3 Dec 2024 15:39:27 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v7 3/9] lib: packing: add pack_fields() and
 unpack_fields()
Message-ID: <20241203133927.g6ngln5tjuwrqiu7@skbuf>
References: <20241202-packing-pack-fields-and-ice-implementation-v7-0-ed22e38e6c65@intel.com>
 <20241202-packing-pack-fields-and-ice-implementation-v7-3-ed22e38e6c65@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202-packing-pack-fields-and-ice-implementation-v7-3-ed22e38e6c65@intel.com>
X-ClientProxiedBy: VI1PR09CA0175.eurprd09.prod.outlook.com
 (2603:10a6:800:120::29) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBAPR04MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 117d907f-d049-435e-7e18-08dd139fea1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6YfxeGXmthVI7sX6RvhRj1NDzjEOYE/6EMyto3o53xBbr3jTznq3AENH6xDq?=
 =?us-ascii?Q?uhRGGEuflKyA8PDDqztMluybfniSuPNIEzjT1iPP30RV8hIBG917aWzmw+zW?=
 =?us-ascii?Q?SGO9NLGAacPDkC887BPf9rFEM1AukxaMejDILBKVJV7nlQ6NniR2k0TuWXG6?=
 =?us-ascii?Q?QQFYcPG3J5jObiHk1iSVuwtCxyFinmcRfn8BqnKYxAqIvvBk3+kIPBpcnNod?=
 =?us-ascii?Q?qXtidkwv8y4VakaMKuj0gIIeVck89EoDXLrB2JxZxgkpJho7805UteF8whjR?=
 =?us-ascii?Q?jpcwo/rKvnHbAhrwcsQZy0Y5/rNgYBPvz4Q4Mw1jSnT/J7S2WQtYxk9lkizN?=
 =?us-ascii?Q?pXlSenLz6+xzGaERjrGIvyf3sbiFTK4zIdxBHvym/JZtgtdxAdg5mfCNDgvg?=
 =?us-ascii?Q?cY1LidtA5R4VbCW9lnXwfyZmfl5rtwN6sJN7rld3Q4K7EvKskiFl9n679uL+?=
 =?us-ascii?Q?iru5Ueb7JtVaLwkW6E1TmyWx/ZUigW8RAtJA8YKw1qVg54pFOfj9hzSYpJ+H?=
 =?us-ascii?Q?bDDfLamc1L2S7cENQfhGZjpUx664EdXIihqcEab59jpxhm19XoU93vMmPdLR?=
 =?us-ascii?Q?vLJ73Fh76rHZw6s7aArEHvVDzeitFSyOqBQxfBTOfSXdKSV7952xA4DClCXM?=
 =?us-ascii?Q?42WPBaWGMSgbSJWCMGVkqTI4y23JlN0NJWf78q/Wsgj2A9dY5CJkk+dgrZ4K?=
 =?us-ascii?Q?/GXxxXXUl4rnLSFhlt+ur5XF0+R+8mWFISVR4jKhlSR+KpiB/3HmFwTUd6oT?=
 =?us-ascii?Q?fpaIT+SXsV/RqcFFgNkdlDgE2EPiAa54pmGVEWHHAzio7mx7NrGmynKSXjLe?=
 =?us-ascii?Q?umNSgpRJA9w531ewImTiYU/Qkaey+4h0oTCYzT5WBMPx5Lt6wujtstSoivWp?=
 =?us-ascii?Q?vxQpFZrXFtnt+J2TGT6idfGF+ypjL/UWjO4ZJFU2/6TQsO9QJpg49ZD6TssR?=
 =?us-ascii?Q?Yg0y7Vo2hiCU4ry3jE/yBv6ZWk1jb1RNNMiGeu+ZMKAma9Nz3uMQKc8M3o1g?=
 =?us-ascii?Q?6df9rfFzOsrXG2xbqoML3hDB/PkSe4xLlutfCEcTVdeBu65hke4VVSVrb1g+?=
 =?us-ascii?Q?pnQot7byv0aFchlDzmm//gzlTFwHpiqafeiEmVTBnFpALthtWQ+G9BZS3VjA?=
 =?us-ascii?Q?yaUoGFW/AslWjplrIOuYhgK+Z40+v3VqzuqXZfyIdaBcXZfoCyWPJba8eeuj?=
 =?us-ascii?Q?xw32zd2U1UuY8qH/RxIOEJRGD5dscGYx1DA4oeI2m/AQMGx971vNQ8IkBE65?=
 =?us-ascii?Q?35sbLk6Kmp+Z/yDMeVHqMp8+lHX9sbsBd057MoXcvDHMjToZnthP3kaohRqk?=
 =?us-ascii?Q?oHzaSkrfzzdGREWBGIq9oGoqEL7qKeOtkp4q/YHK0oQJNA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JGrBawjlUa+3x19VyM2LaZv8/bRqaME2X8hy6Hol7sUfr8c31GcNfUGeSsyO?=
 =?us-ascii?Q?rgCER5A9EcEKx15PJ49sMsZF0RCx6n0N06Wn+xSpp9pzQSI5sKKRrmOfN+xI?=
 =?us-ascii?Q?tfAufIPDqUvV9EaTDsePYRw13HcgHqamICfj9AGLZ96cukl7zNwRFeKO+9YX?=
 =?us-ascii?Q?cW368uj0Ck8a1QG0PgL3p0k1kIKePsP8cYiQyHtd7DOa+0dXQIfw+0z6p19m?=
 =?us-ascii?Q?qXpO3ZwiWYdIsSO5kr8tZN5hLzlBbj0+F1tbxU4btpA3843KVzlxz71JDbiJ?=
 =?us-ascii?Q?h/nb6bX7f9Y6SAm8AdrtE+YKNHDyVBaLw0aIxk7dlsaUl9anYRRWUrDCGLNJ?=
 =?us-ascii?Q?KMM/+L1to1IkDJkjA8UX1pmFSZ1bj09qH2bUbmkKLhk598PfFimOaaImUqu9?=
 =?us-ascii?Q?HktynunHW87RpdgtLXxKjLssmoH0Y++ye8NV37lwNnoHjZz5qfMaTTNDZj5g?=
 =?us-ascii?Q?jgMpy+OFsTY59eJyc2DvaLzx701huhSwJJg0hFs9+QSxo5r4zW+VWt//z3NE?=
 =?us-ascii?Q?hUOpyEMdKg+2O2VnlMqj61h6hFu0zxGV0I6F0COxLLifhFSZlcKQD7b00ZbY?=
 =?us-ascii?Q?0xUJsqvfyr4FQATxEH7IM1QNSBDE8U4NQEs+8pecShHiH3fnLK/89XrexO+g?=
 =?us-ascii?Q?h5m5qEjBKPpZkZoNUMoa9lMmj2NcNhQsq4AW6sOrkGPGqo8YmQVdZ8mqRgFA?=
 =?us-ascii?Q?jdFVp14Zv/WfiV94UCT6avmzNRqz+NvDqlYt2SkwOctqS3RkcFRvQ98hjYvV?=
 =?us-ascii?Q?nJOVeZHV3iMHyheVBkN+b7kfq45zPepq0VyWIOeik27qdgi6xt0NkssD0QXr?=
 =?us-ascii?Q?l5VOqfbkP0wvR3DQKnLGJIlHHmOTiloVf/59EVI3MY9HxG/JT02koCb4uh0V?=
 =?us-ascii?Q?LAHvvKmZPOwaEGJc2l4n3aTu54nO1pemM6zg1fE1q9XH/1E3FBmwa0SjItr3?=
 =?us-ascii?Q?k/TWWY8fGJeCpHintaObRYFQXym+fF0DH3fJY4F1xgMyGzmTC/NRfsEmR+eJ?=
 =?us-ascii?Q?lNENMulskmTe5/KFJBfNh6atByk52VbxC8lTW1XtVgw61CllND4mVHJ7gROJ?=
 =?us-ascii?Q?Bgd0YTUlbidlNfLjiBFCldrxMjfG6jdbeF5tUdhW5Nw164MAfYC4EfeyPeNW?=
 =?us-ascii?Q?/+xmSZfizQNNTh9O32tx4oLDWqd7bnwz0RWzQ3Byz+TXn7i+tvlOUtidGYnj?=
 =?us-ascii?Q?5OgrLudKwby1vnmobjNanWKEBV5ptmvA/gNulgQdPN+1eC0q/bJVzrC/FM7Z?=
 =?us-ascii?Q?XUN2BQ+lq0iMdfljIHvPhqN0PkNUqcnXJ1vwLnISjIB0l0MOqa/EaMRKBJxp?=
 =?us-ascii?Q?wS+1du+08ZBcwJu33yHpaeQby1xdw+2ZXXTz2z0eF4P0NQQ6N3DsxWCZ8zR2?=
 =?us-ascii?Q?+v8z4R+9yvDE23IBAI/tG6H1dMLUsx55+FPoqwLX8zY22HCqialIkDRVkG2D?=
 =?us-ascii?Q?jvQqQVjW5fbXGSBpv0zcvvnRmrYrcnvtLjv1VNAHJGBkoNokDKo63SzteQvC?=
 =?us-ascii?Q?qtbBYdb6AAhLWFCJHW1oH1vM68Kx5/YwlnZfGQgyGWdo1qgLVyWnUDa2GI73?=
 =?us-ascii?Q?WwR7dauFiJIvrEOfJwo1lGjR0bKi+aqtEvG7eXasiNhLiQE0TVZqPSSHGe9F?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 117d907f-d049-435e-7e18-08dd139fea1f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 13:39:30.6700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDBqB3//bOQPSOFZycKCK+urX1/OhHkxdcngf/StzgtQ5/PHo2ql86pA+IffZuZ+Dc79v5GWkJ6umaP0Lq7mrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7270

On Mon, Dec 02, 2024 at 04:26:26PM -0800, Jacob Keller wrote:
> +++ b/include/linux/packing_types.h
> @@ -0,0 +1,2831 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright (c) 2024, Intel Corporation
> + * Copyright (c) 2024, Vladimir Oltean <olteanv@gmail.com>

Not sure how, yet again, I managed to forget to say this.

Please use "Copyright 2024 NXP". I used company time for this.

