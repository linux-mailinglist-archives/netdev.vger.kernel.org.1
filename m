Return-Path: <netdev+bounces-145030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643DD9C929C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 20:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E47B2830D4
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 19:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228AB1A265B;
	Thu, 14 Nov 2024 19:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Te9Fs21R"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0962B9B7;
	Thu, 14 Nov 2024 19:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731613615; cv=fail; b=i9VWN2YIciS6d2My9I9/sbgkTtjhV8wpS5C5qmphi5ac+W1u51vbcIgxlkEjVX/jRKzfQaN2YyBgLyWsavmTxhlTBskfShGPPYbiYVVKkUnCIdI5jr8GxNwNSUCPEHvdWlrOkqYHsokHSu62WiHI/0XQ0ySAnCtItJIl9o9rkaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731613615; c=relaxed/simple;
	bh=Gcoj4pbfLv2RfOjcwYsuVVZV04qoj9UudHJj3Slwygw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jEDOe0cRT2XUfuzKSxcMLmBEfW/xHTyeX8uLWFjZzBnDwpNHz+lOl1dnNceOXqzg+8GMPVAgUFqWkAZnun01n+yFz2US10UpPSoxEHKvbQc4PoUCoAWZLGH2xulQXpHdgmN+J+UO7G6TKRMQJvnxaVeMQq4cvxB8SBKZpKmjfEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=Te9Fs21R; arc=fail smtp.client-ip=173.37.142.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1024; q=dns/txt; s=iport;
  t=1731613612; x=1732823212;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Gcoj4pbfLv2RfOjcwYsuVVZV04qoj9UudHJj3Slwygw=;
  b=Te9Fs21RihM0U0vJiiTszu+cjuRAmqyb2jVxF5bq7F67JTxRL+Scjjbf
   VppbR1NpLLQE/eoKYkhrUMIF3NkjO1UcPylHQLYjI8yzrvVWAC0eKFTFx
   RWUUajFuZ6P95SKcFFQHdbwGnZn+XZa2ytKhEZom7s/q2ed/Oby3dNvm2
   4=;
X-CSE-ConnectionGUID: m5Zcm9BOQR2vyh9V1HMO0w==
X-CSE-MsgGUID: H/tmGNn9SZOr78el6wvvag==
X-IPAS-Result: =?us-ascii?q?A0AsAACmUjZn/4r/Ja1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEaBwEBCwGBcVIHdIEeSIRVg0wDhE5fhlGCJJ4WgSUDVg8BAQENAkQEAQGFB?=
 =?us-ascii?q?wIWijICJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4Th?=
 =?us-ascii?q?giGWgEBAQECARIREUUFCwIBCBgCAiYCAgIvFRACBA4FIoJfgkIjAwGlEgGBQ?=
 =?us-ascii?q?AKKK3qBMoEB4CCBGi4BiEsBgWyDfYR3JxuBSUSBPBuCaD6EQhiDRDqCLwSCQ?=
 =?us-ascii?q?YUTJU2IM5kxCT8KZRYcA1khEQFVEw0KCwcFY0YhLAOCSQV6K4ELgRc6AYF9g?=
 =?us-ascii?q?RNKgzGBXgU3Cj+CSmlLOgINAjaCJH2CT4ElBAWDaoELg2GEYYMfHUADCxgNS?=
 =?us-ascii?q?BEsNRQbBj0BbgeeWEaHAAGWckmaHpNcgTMKhBqhXQQvqk4eEJhJpEKEOwIEA?=
 =?us-ascii?q?gQFAg8BAQaBZzyBWXAVZQGCPD8TGQ+OWchaeDsCBwEKAQEDCZMaAQE?=
IronPort-PHdr: A9a23:t+SB1xEBh67K0sFgG8J9c51GfhMY04WdBeZdwpMjj7QLdbys4NG4e
 kfe/v5qylTOWNaT5/FFjr/Ourv7ESwb4JmHuWwfapEESRIfiMsXkgBhSM6IAEH2NrjrOgQxH
 d9JUxlu+HTTDA==
IronPort-Data: A9a23:U3DyEaslAYtVelX/GKhagGJd+efnVDlfMUV32f8akzHdYApBsoF/q
 tZmKWzUOK2DN2qkL4okOt+yoRkP7J/Xyd4xG1FtrHo2FiwRgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrav656yEhjclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuGYjdJ5xYuajhIsvva9Es11BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIw/7tFCmQf3
 9shEmoTfxDSubuW5ZXjVbw57igjBJGD0II3oHpsy3TdSP0hW52GG/yM7t5D1zB2jcdLdRrcT
 5NGMnw0M1KaPkAJYwxHYH49tL/Aan3XdTBVs1mSr6Mf6GnIxws327/oWDbQUofbHp8MxxvE/
 Qoq+UzZRQ0fG/qZmAG31Wjz1uLLwzzlRosdQejQGvlCxQf7KnYoIBkXU0ar5Pq0kEizX/pBJ
 EEOvCkjt64/8AqsVNaVdxu1vHKJoDYCVNdKVe438geAzuzT+QnxO4QfZiRKZNpjsIo9QiYnk
 wfQ2djoHjdo9raSTBpx64upkN97AgBMRUcqbi4fRgxD6N7myLzfRDqWJjq/OMZZVuHIJAw=
IronPort-HdrOrdr: A9a23:YL0iLq54OYMLzjUQCAPXwbWCI+orL9Y04lQ7vn2ZFiYlEfBwxv
 rPoB1E737JYW4qKQ8dcLC7VJVpQRvnhPhICRF4B8btYOCUghrYEGgE1/qi/9SAIVywygcz79
 YbT0ETMqyVMbE+t7eE3ODaKadh/DDkytHUuQ629R4EJm8aCdAE0+46MHfmLqQcfng+OXNNLu
 vm2iMxnUvZRZ14VLXdOlA1G8L4i5ngkpXgbRQaBxghxjWvoFqTgoLSIlyz5DtbdylA74sD3A
 H+/jAR4J/Nj9iLjjvnk0PD5ZVfn9XsjvFZAtaXt8QTIjLwzi61eYVIQdS5zXIIidDqzGxvvM
 jHoh8mMcg2wWjWZHuJrRzk3BSl+Coy6kXl1USTjRLY0InErXMBeo58bLBiA13kAnkbzYhBOW
 VwrjqkXq9sfFT9deLGloP1vl9R5xCJSDEZ4J4uZjRkIPgjgflq3M8iFIc/KuZdIMo8g7pXTd
 VGHYXS4u1bfkidaG2ctm5zwMa0VnB2BRueRFMe0/blmQS/DBhCvjklLeEk7z89HagGOtJ5zv
 WBNr4tmKBFT8cQY644DOAdQdGvAmiIRR7XKmqdLVnuCalCYhv22tLKyaRw4PvvdI0DzZM0lp
 iEWFREtXQqc0arDcGVxpVE/h3EXW34VzXwzcNV4YR/p9THNffWGDzGTEprn9qrov0ZDMGeU/
 GvOIhOC/umNmfqEZYh5Xy2Z3CTEwhpbCQ4gKdNZ7vVmLO/FmTDjJ2uTMru
X-Talos-CUID: 9a23:L0Y9S2OmfT2P++5DXXRV/0tFMOccSCfD3XeBHRaYLEExV+jA
X-Talos-MUID: 9a23:/iyenAQQI0OUJMS1RXTMwy1nG+Fusp+cL1pSwZgC5daaKyV/bmI=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-01.cisco.com ([173.37.255.138])
  by alln-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 14 Nov 2024 19:46:51 +0000
Received: from alln-opgw-2.cisco.com (alln-opgw-2.cisco.com [173.37.147.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-01.cisco.com (Postfix) with ESMTPS id A5B4518000292;
	Thu, 14 Nov 2024 19:46:51 +0000 (GMT)
X-CSE-ConnectionGUID: nHKD8ez6RC6e3HTkCYJ2zw==
X-CSE-MsgGUID: +kzsYXXYREqnmNDJ8GO8VA==
Authentication-Results: alln-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.12,154,1728950400"; 
   d="scan'208";a="15211082"
Received: from mail-dm6nam10lp2047.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.47])
  by alln-opgw-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 14 Nov 2024 19:46:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjgERwTZ/GZVMyn/vCHgcnRI+6xT8wlwgj+zwQXhDz3u+KX/l6SC6dyPl+zxEzitl1x/1YVbN/lfDCop9ACmsHKY/9dU27qDwX7NBzhVdiLQwBTHGYE6mHEU6W/qV0LZPRxNLoVCa0FyJR0Wt6W5eXoZ8nsPK30pXEr5HL98SzjOl+C32rX2avrsjaBPwX51CF0Cosnn2aG5Yik3mTxa45bmbHOhHE8AIK1Od7Rr6zX1ejWIr5knbKXkb809ZmX2ZhmR0c2vfix8QKovmGCy8XM+TwC2Nxpel1hshO5tX/hq9YhXFsJ563H2EDDk4cZvLFy1rxNDqbvKv3UidY2zng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gcoj4pbfLv2RfOjcwYsuVVZV04qoj9UudHJj3Slwygw=;
 b=xOclhNZZbA8dIRH8jHsqtYY7A7aQXyR+epgMRPtalFS7Yh5Ts+eD2hs913gQBs67WNgQL/8QhKUyoBIXrbj3H0BRz3jEQbawftsF0lFHfO5EF0UKG/JIv+tOqZGOo/eC6s7zAzf4JiX0fZDm1gzl5MESfh6g6ANbj56mODzScVd2tbL5GB4gfDFW0MrzoOuNwTq0fy1a7vcVje5oKdgod5MhtSe8/fe0IAmiOpImHmtWbCTR7UfGg3L6eo94f33ljuyNHY2f35TJAkrGXj+18+g1e3naUNmpYLhKY8friV+ot1FBQlRxg/nLceZnlrsDCgNZT0cS4uS+B3QUPLRVWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from BYAPR11MB3030.namprd11.prod.outlook.com (2603:10b6:a03:87::27)
 by DM6PR11MB4674.namprd11.prod.outlook.com (2603:10b6:5:2a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 19:46:49 +0000
Received: from BYAPR11MB3030.namprd11.prod.outlook.com
 ([fe80::83f3:554b:f590:e3d6]) by BYAPR11MB3030.namprd11.prod.outlook.com
 ([fe80::83f3:554b:f590:e3d6%6]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 19:46:49 +0000
From: "Nelson Escobar (neescoba)" <neescoba@cisco.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
CC: "John Daley (johndale)" <johndale@cisco.com>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Christian Benvenuti <benve@cisco.com>, "Satish Kharat
 (satishkh)" <satishkh@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v4 1/7] enic: Create enic_wq/rq structures to
 bundle per wq/rq data
Thread-Topic: [PATCH net-next v4 1/7] enic: Create enic_wq/rq structures to
 bundle per wq/rq data
Thread-Index: AQHbNifDPEKGbE1UikOZXkRvHq8vc7K29HmAgAA56YA=
Date: Thu, 14 Nov 2024 19:46:49 +0000
Message-ID: <0D929765-332A-4D08-AB8C-DE0776D3C213@cisco.com>
References: <20241113-remove_vic_resource_limits-v4-0-a34cf8570c67@cisco.com>
 <20241113-remove_vic_resource_limits-v4-1-a34cf8570c67@cisco.com>
 <94ef681a-a96f-41a4-bd08-398931d47987@linux.dev>
In-Reply-To: <94ef681a-a96f-41a4-bd08-398931d47987@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3030:EE_|DM6PR11MB4674:EE_
x-ms-office365-filtering-correlation-id: 2a7f5b20-7389-4aec-2d87-08dd04e51496
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RTMwZmVkalI5RnZEbU5BSmIrTUdHbTF4TE01Z3gxaE5PMnRoc2JpRlhMeXhk?=
 =?utf-8?B?VnBiN08zL0tKc0pYQW5jays2Ylk0OXQvQlpRcHBZZXNDN25IejNVbTZQMmhs?=
 =?utf-8?B?S3VZNmZBR3FNam9VRmhnbkZyd01GVUJpaFRrTGM5M1FpclcyTzUwU2lPRU82?=
 =?utf-8?B?QXEzRWFhbUM0L0hwMERNZDBVanZCYVlHKy96ZE54RHJpZjV3REREbmZDc1VH?=
 =?utf-8?B?ajJtT2lnTzJucmYzNmRNbEpIYmRheEtsbzJJZ2FJbHJ3dDdhc0FndVJkTEdY?=
 =?utf-8?B?U0E2OXFYK0NHTTVMcmdDSzh3RzNneWRnQ0dKUGpwUllxYTFnMEl1YTlIOThX?=
 =?utf-8?B?NkZkZk11VHJRdDVNRDBPems5cndLODRmeURZblNaWFRUajEzR3F5bkRyRC9M?=
 =?utf-8?B?REdFbW5zUDZZREhOM2FrK1QyMTc2aE5GZFM1WS8zK1FrN251UDM2T1RIUldo?=
 =?utf-8?B?cm8wVlo2MnNIdHRMUnpERUhtbk5SbFpkSWx0aFNkOXBaUnhGOThsdjlQSWUr?=
 =?utf-8?B?bFgrcXlHa08vU09xdzN2azhpMFJmcEtFaTRBY2dUeG15TDkweGpZUjhKYmVL?=
 =?utf-8?B?TFE3ZElNYVN1VXdwWGJCN3JTQmN0R1BNamQxZVMzcW43ZTZGUDBYazJ1cExG?=
 =?utf-8?B?cE4rdWVtK2w1NFVrNFNZQ1QwcU5uSDVpU1RYeUt0blhsMkhQMUpzaWxOUkk2?=
 =?utf-8?B?NEhsZWZqMFdxVko2eDR1RnV4aUxZTG0wZENacDlKVWt5aXZ0c25XS3hGWUE3?=
 =?utf-8?B?RGtSYk84d0Z3aVQ2eFhUTDhmWWhienZpSTJGSkgwVlFBUzhKelFNVGRMRjlr?=
 =?utf-8?B?WjZ1K1AzOWVIRTkvSW5XMmZ3Tm1qbjJ4SEdRUlhIRnpCWFN5cjdnMGREVUJn?=
 =?utf-8?B?UHp6Wm1RaWx6c1owQzFsNUdRWlFZeWJndVNOTE81KzVFY05JcG9NZnNocGpR?=
 =?utf-8?B?bk5acUpxRStqUDRZanhLWStmUzZaTlpmUk1iYkVvbC9JVlZibG50NFpFaFVY?=
 =?utf-8?B?ZUVMU24wRkExZEJ3bWpLY3JFeUwxdkd4djVyODcrejQwZ0RnVUd4SEZSUUVl?=
 =?utf-8?B?OEF3WGhvVkREaWMzTU5ZMDZHOEtHMThaR0pjWVlGTStFWDU0c1BlS29PejBC?=
 =?utf-8?B?WU9jY1E5QTBGdlhFWDIyUkticmFjTUZNQjY2TE1WOVJncjVBQXIrSDdHRTFh?=
 =?utf-8?B?RTFrTlZIa1lXUWxSOGhjTlVGTUdQWGR6bHJpMnJldXJ4MHR0anVFcW43V2J5?=
 =?utf-8?B?Uy9nZHV1cmx4SUJMTHJOM3hPMmRmNUphRVhKTVoxOHNReUkySEJKYTF2blFn?=
 =?utf-8?B?citIQno1eHRUck0yZEdmbTlnaXIxdHIra0tCOTgvN2w2YTJsdjN5dnNaTkpk?=
 =?utf-8?B?a0J2TWs2UmRpeHBvc2poZjNUaWF3aFh1T3Brc0x5TGd1dUl1d2dKQzhwaFpv?=
 =?utf-8?B?a1RRZjlGK2dXK0luSk1sKzBSMEhjQUhTd0JuMXFSVlNxRW0xMG5ucEpzWWFp?=
 =?utf-8?B?bXYvWmVIMHdUV2orNUgwSlRUSUtpRFpqSXUvRE85MWUxeWZvdkVFUEZxT0Np?=
 =?utf-8?B?Wk4ybEIvb2Q3ZGlOU1Q0NTl0dUNjdFpPRllpSHB1NGw0bVVGSlozWitMKzZT?=
 =?utf-8?B?bDhQR25PMHVBbklzcGVmOVNUa0doTnpRSzZLYlNzcGYyMXBCdE8zM1FCSWN1?=
 =?utf-8?B?UE8zUThTeHlieDd5RG56M3pnRDY2dkJSTXJmdFBValhVMEF4UTcyNTZXTEd5?=
 =?utf-8?B?ajU2aWJVSGRtazdxdWpsbEprUkNCL1lrWU5DVmFEalRnRjdHZzlUQmc3eVA0?=
 =?utf-8?Q?x7XuSXLJmIC9amXeALoHQ6133OHlEDEqJW8qI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OVJOSHdDMWI3dnRGREFVbWZyZjNkR08vTzNNS2RSeVZ1V0tOQnllTkZjQ3Bi?=
 =?utf-8?B?bHYwSSttK3Y5c0tKSHdSUGRXeDB4Y1RYYTIyMkY0RWJRQW0wY2x5T1FYUlpC?=
 =?utf-8?B?bUdOOHU1azdxaTRGaDhLOWxESGlDOGEzdElwaG1kZ0J1ZTlZaGpTUzlNNHNo?=
 =?utf-8?B?a1ZIYkprTDczM0ZRUHNHalFac0dNVnMvMDdTalo2QlJuNVJqSnJ3ekVYV1ZB?=
 =?utf-8?B?Y3lYUkJ0dURod1pRWWlCenc0TWVDeVJ6cWExUXYvWCthSG0vVVc0YitmM3NK?=
 =?utf-8?B?cmIyUkl2OERYRDVhbmZkelFnM2VJYUI1UDFCaEFXcXVVSHB0UDlXckRXS2p1?=
 =?utf-8?B?cGFMUnNxcDFvQ2dkNmxwWTlMS2JWblRXdzVUZkVXdEpYelJpSlF6aXBZbWhM?=
 =?utf-8?B?TnJxcElJRUNPMlhlWUZjaFM3R1FxcWU4YzI5OW1ZS1FDK0tQUXFJdldKRGhl?=
 =?utf-8?B?WjVGSlpFMWkvZjN6MDc1bHpPa0Q4RGxScWxsMnNOUzVNdUpWL1V5L2VUVUZS?=
 =?utf-8?B?eGVLMlR0REwyL0N6VmV1UmpTTmJqRWZiNlJSUUtUQ3FBOTU1MGVRRUlJRG56?=
 =?utf-8?B?cEhjS1QvSVliWklsLzR4Kzh3ZzZweUhac044RW5OSjVKaDF3K3pENlVyNVB1?=
 =?utf-8?B?MEpUV2J1TkRkb0F4Q3FWMDNsdFNlajVXVXhxQ0lnZExNbUNxeUdPMDZwdHFK?=
 =?utf-8?B?dlVIWjN4U0ZTdHc0R25ZMlQ1T1hVRGRYRmQzZncxUWxFNGpKK0lseXBTZ1RT?=
 =?utf-8?B?dTY2ZDQ2RDhRNlNJR2VOYVBDK2xzb0xPcndSalVEVkFJVW5rRUdZWGovRllN?=
 =?utf-8?B?ZERxTGlyTkVUWFB5UGdrSXdzcC9YdHZPMVZCMTlsc1hVaGNCanFPQkJSaEs5?=
 =?utf-8?B?Z0tGcDhRU0tkZjJiUnpVc2VDTWZYWDVVSVN6d0pTbW1TYWZCUVE2MmxSVFZF?=
 =?utf-8?B?SkFtUTh2b3ZHb2lFQndta1dhUytFOVN3bWlvY3lwOUFVb2diL2VzalRsTWMv?=
 =?utf-8?B?QWcxY3hxRDdHa0FMaEl4bnQxbDhKd0lQUkxwbm1RT1BrUFk4UkEzYmF6Y1Vs?=
 =?utf-8?B?TWZHR3l4UE1MbEVQeEtDZHRLeU5ZYjltbHpOdEd6THkrRWxFcDdCcDdVMExC?=
 =?utf-8?B?R1FiN09wZ3ZtN2ZYd2s2djd6MXhKa0FObEM5bUQ2b1gyd0JHNzZ0ZWhXdks5?=
 =?utf-8?B?Q3FZWmp6Y0xRa2FiK1ZwM0VFOHJDZXdoRkF6V0xlNndQcG5wMklUZkJoaE15?=
 =?utf-8?B?YVBQYjFhQWVpMzhsZVg0bk5CeVpjSW0wRktpWXdtZkxseUZXUlBZTFNJcEtF?=
 =?utf-8?B?T2Z3R1BNUWM2YS9PTVZZSzZVTmh3a3A5VzFsSlpzb2lmZHJLYWV2akdHZDRa?=
 =?utf-8?B?R0hYUURabVRnZmIxQlRRYVlPQlBUNFdIaDdFbUFKK2Z6d1RVNzBoa3Vya3My?=
 =?utf-8?B?TzBhVlBRRElCMVNNd2VLaGVMUWdMb3RBUUJhcFRLQkdoWTlJK0dMdzRMWGxY?=
 =?utf-8?B?VFY5M0xIVURJRVUydjZFSHhxeHMxUkUxUGJMQzFpaWdzdmJpOGNiN29NLy9R?=
 =?utf-8?B?T25lRE5KeDZsYytvbldkOVFrZHJDQXdvVzVveTFYQk5WMzh1bDMyVkw4ZVI0?=
 =?utf-8?B?VDRSUlppSTM2L1RIaGc3WUhvaVJzT3hUdlJNMnpHTHpCZXpSeG5QM29tMXI5?=
 =?utf-8?B?WGUrR29DdDcwRFkxSm9uaHQ2cWlPcCt5MDFGVml5TVIrWm11NERXZmZKekUw?=
 =?utf-8?B?RGJCOHgwR0NCL3F2US9RUUd6WEVtNDJLRDVOc1ZJcjBBL0pnSmt6ZkZFOEVl?=
 =?utf-8?B?RVA5cVdHRWE5bnNKbmJRdmJQV1Z1dDY3TCtaZkhCZ01nZUdjbUVPOGNwemlI?=
 =?utf-8?B?OGx5S21lWmN2elU4T05pZGdGZDFKVFVyaU5zU3F4K0NxWW9qTVpYbURiNEYw?=
 =?utf-8?B?WHdGMVNCelpRSWtUVk5qRXVEQzBQejh3V3hObDlYUzRPWG0rdGtJVDJadzFv?=
 =?utf-8?B?YVh6VFgwVGhUaXFXckswaTZlWWRrTXROdkFzdDhKU24rTG5hM1VoY2ltUi94?=
 =?utf-8?B?amtmc1B1cGxpZHFPeThZMHJ3Z0t5dkI5M2VwVEFoSlE0R051dWJCNlc4UnNS?=
 =?utf-8?B?ZVZUT0tXNHloUFArd2EvOXh4NERYRGpvWHlHaG5lc3BmTjNRZXpTQXpGL1lj?=
 =?utf-8?Q?sbwqIixl33edHEXvsyikZTXZ155ackh1lXXvhuOAx9pt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2422A9F5BCD794EA8B9C5E2DDB59E80@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3030.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7f5b20-7389-4aec-2d87-08dd04e51496
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 19:46:49.5543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ZIekwM91Gt43yBJ7G1KFu8AuHued6/RptGrqf1u7KQe9/kPP4jxMzk0btJQ2pAdLAxtPH7seLwrIBv0ZFtD+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4674
X-Outbound-SMTP-Client: 173.37.147.250, alln-opgw-2.cisco.com
X-Outbound-Node: rcdn-l-core-01.cisco.com

DQoNCj4gT24gTm92IDE0LCAyMDI0LCBhdCA4OjE14oCvQU0sIFZhZGltIEZlZG9yZW5rbyA8dmFk
aW0uZmVkb3JlbmtvQGxpbnV4LmRldj4gd3JvdGU6DQo+IA0KPiBPbiAxMy8xMS8yMDI0IDIzOjU2
LCBOZWxzb24gRXNjb2JhciB3cm90ZToNCj4+IEJ1bmRsaW5nIHRoZSB3cS9ycSBzcGVjaWZpYyBk
YXRhIGludG8gZGVkaWNhdGVkIGVuaWNfd3EvcnEgc3RydWN0dXJlcw0KPj4gY2xlYW5zIHVwIHRo
ZSBlbmljIHN0cnVjdHVyZSBhbmQgc2ltcGxpZmllcyBmdXR1cmUgY2hhbmdlcyByZWxhdGVkIHRv
DQo+PiB3cS9ycS4NCj4+IENvLWRldmVsb3BlZC1ieTogSm9obiBEYWxleSA8am9obmRhbGVAY2lz
Y28uY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogSm9obiBEYWxleSA8am9obmRhbGVAY2lzY28uY29t
Pg0KPj4gQ28tZGV2ZWxvcGVkLWJ5OiBTYXRpc2ggS2hhcmF0IDxzYXRpc2hraEBjaXNjby5jb20+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBTYXRpc2ggS2hhcmF0IDxzYXRpc2hraEBjaXNjby5jb20+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBOZWxzb24gRXNjb2JhciA8bmVlc2NvYmFAY2lzY28uY29tPg0KPj4g
UmV2aWV3ZWQtYnk6IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz4NCj4gDQo+IFJldmll
d2VkLWJ5OiBWYWRpbSBGZWRvcmVua28gPHZhZGltLmZlZG9yZW5rb0BsaW51eC5kZXY+DQo+IA0K
DQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3IGFuZCB5b3VyIHByZXZpb3VzIGZlZWRiYWNrLg0KDQpO
ZWxzb24u

