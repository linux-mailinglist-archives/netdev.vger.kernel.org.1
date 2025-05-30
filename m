Return-Path: <netdev+bounces-194345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D69CEAC8CAD
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 13:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65671BC75C7
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 11:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF96D225A36;
	Fri, 30 May 2025 11:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gWViSAF8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB1419AD70;
	Fri, 30 May 2025 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748603615; cv=fail; b=M1uhOxrtd7imydv36doyQ6Pu/Kg4y52881eWWHb+HZqudlIw8TUAN+hZoiKUF6TRApATMkc8V24ubru+78NPfGlt+zn/1f1A0L5uzz5lqOrUw71OzN+f22HK9PAu0fbP/QB2/VFWAKLNVO54QJOsRFN1HuVAYyH8R2Ol6ALSyHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748603615; c=relaxed/simple;
	bh=aPOANjiSEDKfim/xCHM/+VMa3h11x5KsuCjN+Ags7xI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lOB1kNTLzZAM8mW7o1+2szG6wkkC4IeV40dH6/bUPUTHnGwgtBcgJkSKTeyaTPQHDlsQxjejxlEbktUmdMW0AGBBuHa9/ndQxSkh5KedyxFHdbhY97Gt6zALPvXkCC9as3hJbinhw0sW+H5t403k1aCRhrxc+VxwPf6vsEhMSJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gWViSAF8; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748603614; x=1780139614;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aPOANjiSEDKfim/xCHM/+VMa3h11x5KsuCjN+Ags7xI=;
  b=gWViSAF8ENBP9bnron7y3SgHESbx3k34fT1IMXV/e2yHBvfVues+L8C2
   wEINXvtU6IFuoO+BsRStA9swznZGm5+HiXGwUcCzLkC5iEoNY3zMapObW
   4pRX1b7bA61OrfTr8RMCUX76IeNkRCpCKp8CzQGDdYiHp32Ofidnf6DAE
   aSxY5+qSiOOQaPjMZfQNHtS8Jun3tAX7Vi0mpFfq8920ltZkKClxgypmG
   3B8j8mt0T7tfg0blTYiKEmTxS2zsaxu0OHNd1zUy2wLwL1dstBqtkaiP6
   mwpkX6oatfVHnNuZAwSDlfetWftzsgPQS9EAV1Es/1dkhLlwvfso0TfJc
   Q==;
X-CSE-ConnectionGUID: FMCmV63xSTiGlYDL47c4Ug==
X-CSE-MsgGUID: 8506GcLvQuinQIGbDCHszQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="50389857"
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="50389857"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 04:13:33 -0700
X-CSE-ConnectionGUID: 8ZplpbzZRE2vqlLigZB7qw==
X-CSE-MsgGUID: 2mveFpXMSsKAor09KKW+AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="143682523"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 04:13:33 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 30 May 2025 04:13:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 30 May 2025 04:13:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.57)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 30 May 2025 04:13:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kinDY/8hyilJADIuzz25y3/x10s5iZORJkriX8rYnv1ojLjJ/t9edelYteFR4qpeCZqvJh7raHbwlO+FJQWmWAeNy++RkLwhFshbGPm9GdsEiHVl0vTeJDfGybDnvC7dgIgQMaAKbHVMA4CCSUTS9vJHzB2CyNsaxbwLfruOUJ2rSGcLW3j+VSW93miaLQNQjqx3FdmPsprqCYbBtD+0CsNRCwktKZC1RtDetXbM6eOkBSaoN21XvpOPG0tVfC5h4qfp7a88zkATxuDW00sb9ESynMdsCApCUMd3LNRYpEn5ZJ6GX4KB69EaVXXZETTWr+PhTaWrS44A7B7OGM3Qaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6uquJaztQoW5jUBU/ZiGGarw9tnPqENRdhpbNTsyvQ=;
 b=xHQFas6Sc3Gq+hpzQrXPn/vGcrY70C4t4ZdDZkibEmiyaOIM6vYDn+XLgBSudbl611eJqVCjBrlUd/9bhjwutvrK0H38c2owzAcIBqiBX0qTIq+Yey+X631oXx0OsDoj83jb2auIgaPuTRGSeabd4ajlKkNL0iSuqQH3ELkrOT3XHVUFWmS34rgfLiFONDPTjbwBjqav+TtWBXnOu1b+W6nDJGwO98+YWF54iyWszP/LvSJniNw6onByRPHRHZt1xXmBqN8RLOXynz8JMa7oYHvLSREHnJG8whWnL47Ijw54lrqZVNtly5wdtlPdnGMVpR6qfL0ftuwwzy13jmL3vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5057.namprd11.prod.outlook.com (2603:10b6:303:6c::15)
 by DM3PPF83579A393.namprd11.prod.outlook.com (2603:10b6:f:fc00::f35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Fri, 30 May
 2025 11:13:18 +0000
Received: from CO1PR11MB5057.namprd11.prod.outlook.com
 ([fe80::4610:6d6c:9af6:2548]) by CO1PR11MB5057.namprd11.prod.outlook.com
 ([fe80::4610:6d6c:9af6:2548%5]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 11:13:18 +0000
Date: Fri, 30 May 2025 11:13:08 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Jani
 Nikula" <jani.nikula@linux.intel.com>, Joonas Lahtinen
	<joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Qasim Ijaz <qasdev00@gmail.com>, Nathan Chancellor <nathan@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<intel-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v12 04/10] ref_tracker: have callers pass output function
 to pr_ostream()
Message-ID: <vzuwl22qfx5pkcgliy3n76mqx4od2dtbduga4wl4tlvtae63e3@vnzosrktvg5m>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20250529-reftrack-dbgfs-v12-0-11b93c0c0b6e@kernel.org>
 <20250529-reftrack-dbgfs-v12-4-11b93c0c0b6e@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250529-reftrack-dbgfs-v12-4-11b93c0c0b6e@kernel.org>
X-ClientProxiedBy: ZR2P278CA0078.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::13) To CO1PR11MB5057.namprd11.prod.outlook.com
 (2603:10b6:303:6c::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5057:EE_|DM3PPF83579A393:EE_
X-MS-Office365-Filtering-Correlation-Id: 7969c0ae-6f68-40ee-bc9a-08dd9f6afadc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LzNtdlJ0Rk9lMGVQcXhKZmJTMkp1bUdSajlPS05Wb2pyVEQzM0p4c0dQTE5z?=
 =?utf-8?B?Z0pDZm84ZVlDT01JTHMwNlNPWFFHZUwwOEkrM2pVTk9pK0VSVmp6QmFVcFV2?=
 =?utf-8?B?Z1ZnVjQrZ2Z4Mm5xd3J1QmxZTVBkM0cyME5MODJ4em1uZHNkRjA2bEJxZUN4?=
 =?utf-8?B?WERHc1h1VGlmcWZzMnJBYzJrUUhXL1EwQ0JFeDBtbXNEUW0vU1QvcVNpZUUw?=
 =?utf-8?B?QzZOd0EyUjJCbkdYbHBDT1kxVXo1RXpzenVTcENsY0FXb1J5WERvZHBkWWF2?=
 =?utf-8?B?MzZBZWJVQ2MwTHpKOWlTUXFxWFV6aVlQMGtyc3FWOUlLWFpqL3QyU0MzUHBF?=
 =?utf-8?B?Wm1tYmhzQnQwN3FBNXdDVGJvWk5NUlZEVjAvZlFRaHFJUW05eC9YZmxOL1dr?=
 =?utf-8?B?OUZKSDZTZ1k1ZDNVbklZR2dyMjd1UFJUY09jR2FwREhWREdSSVFaZFBvSXlB?=
 =?utf-8?B?NXpzWE5Rdk9QbUxUcjNEZTJrVmIycVZWaVZ5aUNzNGRoTlVoWUZHV0JqZDR3?=
 =?utf-8?B?OEthNzJ4OSt1WFgzY01TODcyT21SZTA4MWorNkpTYU4yclNpWllEazFITmdN?=
 =?utf-8?B?NHlDd214dTgvYkU1QnpxZ1hDeitQU1RkanZydFJZdzlKRm1sanFzRG0xUUY0?=
 =?utf-8?B?OURoWkl2WjhvSG9HajBEMTl2TkI5Tkx5TDVsaGZjTnoySmFJL3dTS3pIMHRX?=
 =?utf-8?B?WFAvUHFOVCtGYzQ3dVl3RnY5VUhud1ErMWJrVnZQSDNtc21KWXg3QjV0RGdj?=
 =?utf-8?B?NnZiNC91ZjVnbkRmbnRJU2dkT1FCYXdZV3FpMlNKOUVuMU9hMk1XVDFnTXh2?=
 =?utf-8?B?REpRd2lRN2QyT0xRNDAxR1cxNDhzajhnb3NNMUhLQ3ZTMWhiYUtTdzBtamoz?=
 =?utf-8?B?dTlRb2htMUh2bkZxbFVyOGxuRENkU0llUHRHSFBWUnV6Mk1DaytTYTBXbWtJ?=
 =?utf-8?B?endvRFpvZC9Fa3RQSWVsOXhiSjhYR2pOV3JreFFYaWp1SGlQQXpxTnFBOFJx?=
 =?utf-8?B?L1R2eERFcGdTRGhnYUoxS1ZOVDAwWkRycXJvT3N1ZFJTR01jQUJOUnlhL25o?=
 =?utf-8?B?QjE5cUhSeFV6RjVGRVpzZGZNRXBxeFU5RFdEZnp2SGVQeXVEUlhmeENEOGJs?=
 =?utf-8?B?Sm1qRHpQaW9NNzdJemZoQ1l5TGdxQU5FZGRVcytibVFrSWtwWXZSWGNtK1lV?=
 =?utf-8?B?MUMvbTZGTlRPYlVjdGI2Q2dKT0xyK3NSTHpGSGtLbHlMSDB5KzdISmxVbFh4?=
 =?utf-8?B?bU1rSmUraE1wUzk5bzlXS0ZQV3NQN1ZDbVhETGRhV3VMVlMrUEY3Tmw3YmYr?=
 =?utf-8?B?dDFQRUtVWmhmYTY2aEJsZVpJVFNlbndTWmYzZyt4TWhEdnFnb3ZYcVVyT1FM?=
 =?utf-8?B?MThObmY5OVRsZWFjZWVncENKQThaMVNDSStOTEwvVVdQcFlBbUhwbWxLMDQx?=
 =?utf-8?B?MUV3THNLZG9RckF2SE9MYkJ0cVJDUVNOVFkwMCtWOWU4WXR3VS9kcVpkSm1W?=
 =?utf-8?B?dXZCYjJuUnQxbGxmMTlOdmpkSUV4aEVyRWNVSEhvenV5REY0T3pZUlJwekFR?=
 =?utf-8?B?c3JRVE5QZEpBb0xBY0xmWXhPSDZyZ1VSWlVRYk1wTTcrd2k0Zk1JUXlvbkh5?=
 =?utf-8?B?TmQzZjhUOEZ3UWJpYi9walFiUGZsdHk5RVhrL3RpVHlBaW9OY2tva3BZRmZt?=
 =?utf-8?B?UXFCOTN0SUFOTS9lYWtmRmxRYzlJSWJpTnJBSms5aDNZUXQxWkduTUxSTTk5?=
 =?utf-8?B?dlVvems0bUZ2ZVlISjhqRi8xYU80WkZqOHNRWWVJZEJpYzRJNFFMR2RSMlZW?=
 =?utf-8?B?QjVtRW5MeXp6VUdLdTZITW9Velo5a1llNVRVY256Mk5JN1k0dXR0L2hHVERZ?=
 =?utf-8?B?NkNVNmxXTXBtTmF0c3V3enNuTlpXelp4alVDK2YwbmZobjNPTG5FdDNrQnYx?=
 =?utf-8?Q?ShFJArtW4BU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5057.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFhCaWo2Mm93NUtENGZ4WU05RTg5S2FTWStDRXZ2OHAwWXpBdkE1QTZHeU5L?=
 =?utf-8?B?NWJpajVjc1cvRHdBdW82Z2pBQ0tiSGJBZWU3c28raURQYnRmNnhwdE9TMlRn?=
 =?utf-8?B?RDZiTzd2WTd6alpTc3R2cEtWYXFrUlVlU3diR2o2eE80cEF3YlhkTDYrNXFN?=
 =?utf-8?B?WEtEdzlZUmJ0dmd0bXBhUFhwT0RFZ0w2YW5ReTkvZEFzL09VR29pZG1tNTNX?=
 =?utf-8?B?Mzh1dUZaMXoySUhvZ28xMjYwUjlwZm1EbU95SG9DbDNPZi9iSWJaRmJ2akp5?=
 =?utf-8?B?Rk1DYnhySlhmTm54eUYzY0Z0VXErZm5SQ0ZYNUwvL1hCRGZMZzJHS0RhUHla?=
 =?utf-8?B?L0FSQjBHZks4YUQ4NFhDQ1ZQWlpmOG1JbmtMaFB1dmhjYmxCNFg0NlBVNzNh?=
 =?utf-8?B?QlFNRlIwY3M2cmIxc256ZWJVUkNSeGlibndXVlNHaWhYZG1STmErK09JQ21x?=
 =?utf-8?B?bERzdDQ5YXkrR2NFRVVGY1g4MEZYcmN4cEthVi9kM24wUWIwMTF2Qy9Ob1F6?=
 =?utf-8?B?RDNUbDk1d0E2Y3hKMGR0UjMwckhJbWZ0d0FCMWljRFVwdnZ3cnBUd2RUWHJN?=
 =?utf-8?B?TnFCeWlrbExxbjYwb0k4QWY5SUhMRFBqUk1sbkhQZFFXa3FMdWMvREFmMGxR?=
 =?utf-8?B?Qi9zNE0wWUcxQzlUbGQ0QjBLcndiS0FEVFUxeVdpSm82aG5DMWtMWHMvL1I0?=
 =?utf-8?B?dUJWU1hXbmkwRkRaMEJNM2xjWUI4UWM1bS9lTzBHTFNDK1RNWkJ0VFpkUVdT?=
 =?utf-8?B?MnNKRk5FT1F4S1JITkNNdDI4ajJEWDZ3VDFqZjF5UzJROWs3azliMWRSblky?=
 =?utf-8?B?RHRXbTMvK2xDdnh5ZElEL1hMclc5aE9EVW9DMlpxSEhmWDdySDNvVmtJY0pm?=
 =?utf-8?B?WWVkb1RNYjIzYytwUGgxRDlHUWxLY2NvM2ZGaGh4Zk93OGFCVGNYWk04Z3lX?=
 =?utf-8?B?M2NkcmxVd3lQSEN6cW9oelVaY1UrcThmUnBJRTY0WC9Tb0ZDNnIyZjdQdzR5?=
 =?utf-8?B?VENyRnhodU1aWDQ4anJYOS85dWhaYkg3YTR2T1d6WFVCa2U3bERpa1ZOeVl2?=
 =?utf-8?B?dHhpeE5ZRHZQSVdIWm5mOHQzNktnSXNGWStYclhUYnAxUGRRQjBYUU96Qkl1?=
 =?utf-8?B?QzZxOThIT1hCVG1TT1l0MHpZUnhta0NQTUZ4TktoOHhCM2pyRXkycHNkMk9C?=
 =?utf-8?B?NlhITGFKTTFtbDFSNmE3U1lVUjBXNzdybDA0Qll1b24wcmNjcitMQjFCdy84?=
 =?utf-8?B?dVk1cjZtSCtJRFVTY1FyM0ZjUHVaQVpjZS80OHdYR25UYnFCaTVnNEdsY3Bh?=
 =?utf-8?B?K05TcHgwSGhaZUVvZDZVdU56bXllUVJBenlxUXBBYjY1d2FNS0pGVHFwWVJz?=
 =?utf-8?B?OVBRYmhzcWovQVA3Y3hqeWtkckxkZExFbHkwcFZIa21WanpvM1ZKQ2p1aTYz?=
 =?utf-8?B?SFJDZjhjT2laRmVRNEorTlRKTWlTMXc1VXBnMC9oOFJFbW9ScCtBWXRPMGhz?=
 =?utf-8?B?YVZhTDM5UnlRVzRLL2pQTmhqL2w4cVFWNWsrRUhRR3lPSEtEQ3VySGxNMTRs?=
 =?utf-8?B?YktVMUc3UWpxdWJ6TktzSWlsSEcyaUNRRCtlZU1mOXptSk9GenVMYzRLTHBE?=
 =?utf-8?B?d08zWEN4TFN3dE0yOXFrVnNnR3AyZnU3cmJKTTN0cG1hWVc1UFN0ZWliMXRk?=
 =?utf-8?B?VjdHWERESFVoQndBWi9lNmgzNjhrWDlnRVhyeHd1aDdhNHE4YzhOajg1UE5t?=
 =?utf-8?B?U3ZDVWd6T01NOXNnaGluSUY0eldvMVRhMW4xbkNTdTZ3N0FxUFN0aVp5bjJi?=
 =?utf-8?B?T1FOTFQ3THNrY0VMMWc5WlRuQUc4SzM4bG95TFFQY0NOVXkwSG9qVElqMEF0?=
 =?utf-8?B?RFY2MHRkL3RycXRRdm4vMDQ3TFkwR1ltRiszTmhCQWtHaXVCMXhLdk1vWUcz?=
 =?utf-8?B?eXdCOWZFQ3dBOHZtWmx6NndNcE5xWTRvU0F2clo4clZINCs2QmdaaEpZZ1du?=
 =?utf-8?B?U1U5MmphdlBQdER3ZkkzVjRjQWljN3BDc1JBbzZ3L1VKMFNhVWJKZVgyOEMw?=
 =?utf-8?B?U0RqendmZVQvZUlMb1hBd3oydkpidklkaWpiL0JQVkR6eDNidlRzZWFMMjV2?=
 =?utf-8?B?SlZLcmcvNzh2VDFZV0o1SDlTQmdvb3VxTmhHait0YUVsb2QzNDVLQ0pucXBD?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7969c0ae-6f68-40ee-bc9a-08dd9f6afadc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5057.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 11:13:18.1668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbfurR3C1MUHQJU+Cn/1Ho7JdSOtZeCpjuwupdkMUT6Y6HSDz9EXwg4wnU5Smac6T1Vnq/0otXSKkCGvRRzRX06kGFCDi8ybkyM421kA5Rc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF83579A393
X-OriginatorOrg: intel.com

Hi Jeff,

[...]
> +static void __ostream_printf pr_ostream_buf(struct ostream *stream, char *fmt, ...)
> +{
> +	int ret, len = stream->size - stream->used;
> +	va_list args;
> +
> +	va_start(args, fmt);
> +	ret = vsnprintf(stream->buf + stream->used, len, fmt, args);
vsnprintf() technically may return a negative error code.
In that case, we'd be adding some unwanted values to the
stream->used. When we encounter an error we could skip
modifying that field.

> +	va_end(args);
> +	stream->used += min(ret, len);
> +}
> +
[...]

Best Regardsm
Krzysztof

