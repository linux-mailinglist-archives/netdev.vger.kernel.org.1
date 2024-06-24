Return-Path: <netdev+bounces-106144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0C2914F6D
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A67DEB21B69
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 14:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CC9142640;
	Mon, 24 Jun 2024 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="elhInHLE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380FE142635
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719237588; cv=fail; b=Hy518qBG4fUnNhRmYY3O+zAXky4dzqrnCxR/4tEZ/Gk3L2N/XWaeMrfTGvkxLHO5h2v5cuyWQVEi3OKJC26WP/3PIqD+trrhPAFMCu0+G93YkmQaamdhcUtJ/8WCtJ3YSAO2bL2JHMymexDOLQWJpfZ/efXNLkCDEYSDC9K765c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719237588; c=relaxed/simple;
	bh=QBITEZbZQNLT8zC5uUJ8fJhJwNuTAZIJap/b2Cdyvdk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZStyKaiHxwT9LueMHvAxJCrF0chuLTpvxFWKGpM1VsDiTR9xrQauRRiCPt3l6ldzE9sOAbgk+0IxSWskZAW8YUDk9ylAnFR50Ewr3L8zAFq3utS+wrVBf1Az/U+pQ1gH5vdYjKDaI7joCLhN22aXc916SKLJy74sdZrQLhiicTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=elhInHLE; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719237587; x=1750773587;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QBITEZbZQNLT8zC5uUJ8fJhJwNuTAZIJap/b2Cdyvdk=;
  b=elhInHLEpU0nspEBIxFcvvMhZkV/dNoJFjq1QIC8T7JXLpYoWgMZMO6k
   1npuwzBg0Nx4zfmhJgNJF9JxXMjyrK3/vHZgswmgSQd2TA+YcLarRb9fz
   GMAwptiy1jNspK3kfBSbWV002KGbS9SAJfP9L2QRZc1/WwLN+ewvKxZsp
   cBLlqanE9TcJlhIQ0h2YyYtc3no21B/ThEH4o1G21S+ZR3UvxhTg27rKs
   8GfYmcGd+mw+HC4sksZJXMLfN8WNEhMPngwGminQxZkLy7i+YcsLgdX08
   crJg2U0vCRVNRyYofyKnMDkpwgFNSM86l+N7l9leGCCV5H1Tqvg0B1crv
   w==;
X-CSE-ConnectionGUID: 0Ukc2S0eTpaSGfu8f5nehg==
X-CSE-MsgGUID: SX6TpwdhTMKPBfNbg07l9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="15897545"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="15897545"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 06:59:47 -0700
X-CSE-ConnectionGUID: 4Dymxz8+REO8Y9ryoiE/Mw==
X-CSE-MsgGUID: QlLAl7YkSDKuwm4sh+ea2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="43742924"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 06:59:46 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 06:59:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 06:59:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 06:59:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 06:59:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoJazqqec2vLAeBgd2m3UV+D64Mg8j9U1/x6M5b3txN7XHflPBo5Jn7MnX/MB46sdeSAgPu9UhyPDfWC04YipEt2+sB0Rzy9s242Ojx5l8gYNcOf2DPvv7Q5XFibBV9NFt6IOKCIZyp8fFHGwYQ8T7y9CrNVO/cxNN4uQklne+aGJK4vnGt0zsslgv/XNHQ8N1g88RRD29m7F+hObX2GmDl2BQNkDuH20NEuuOK3yseH6Xq/2tkzeo4H4QGm0HF1Xxio/tlZgYjqNYngn4YRxa4qnc/EDzmAPcruF/JHKX8QcH2LAJIOElZS330K7Q/r2IwV0J6ikx0ICT5KiYrhMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0bvo4nebv9VTGT/WG606J7drFbwM7ARhxTtPmpHaTE=;
 b=JiDIsqBe7w8YmxqVD9kD77esEMNlrx9ZxZ6iksb9/Hug+onnlFA2WQRjjzgqwVgMc3hA0g51d7VNYYsYUSibM9nEwZWSUA/h3L4xgMqtyr9WeAyo36rE6xbNUhRZYTlY+I/qNLW/5QOErb/0HI6rwJrlbSNGpgLSvkCnNaP82oji5zNGiexERcTkDRyYgc4H1MEugpcyu56PcUSL1Qzgd+apHp4JZwpoiOSuwwj04RJY28Y/t9zC12OezbmzhK3YuxOvsHx223cv2qSnCjm7ePF5y3UoAEuj8WQDuiqE/NLRZzPaN4WQSv4n6BptQk39dUF8EZDgi5AJfTnw6uty1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH0PR11MB5046.namprd11.prod.outlook.com (2603:10b6:510:3b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 13:59:43 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7698.017; Mon, 24 Jun 2024
 13:59:42 +0000
Message-ID: <68b64819-b0e4-4541-893d-0e721366e46b@intel.com>
Date: Mon, 24 Jun 2024 15:59:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] selftests: drv-net: try to check if port is
 in use
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<willemdebruijn.kernel@gmail.com>, <ecree.xilinx@gmail.com>
References: <20240620232902.1343834-1-kuba@kernel.org>
 <20240620232902.1343834-2-kuba@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240620232902.1343834-2-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0040.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::17) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH0PR11MB5046:EE_
X-MS-Office365-Filtering-Correlation-Id: 31cb6674-6631-433a-f525-08dc9455e5c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnRFa2JrZVFzTElqeVNDQVlqTWF6K0xyMXUydi9CZEhEbzUrMUx4dU8xQ1Nh?=
 =?utf-8?B?QThzY2pEbkNIRC9DbHJaakJuSEp0bW16aUdaWjFVZE5QeGc0S2FsejVVbG5k?=
 =?utf-8?B?RFR6Z1JzbCs3QTBJWmpsSFRRVGZ5bmJFbXJoZkJmdDRTOUE2NlU4c3BoaFFI?=
 =?utf-8?B?OXlzVWlHdlM1Tk9DUVhxeGkwR2NIMkdXbXR6V0k5TkZPbXNCd3FRQUJSbGE5?=
 =?utf-8?B?cXJuakZ0czNMU1pxd3pBKzJMSXdLMUZlYnZGOXhVNkthRkUyYkJBREEvRElR?=
 =?utf-8?B?RTNHblR5d3B4ME03cHFSM1JpL3F3eVM2elE1bnp4b0V3c1d0ek9NZjI3ZzlH?=
 =?utf-8?B?UUR6SkxwT0pkWDkwSHV5dG1TeGIxU1R6akw3Rnc4WEtKMDUvdEYvWm9SZEk2?=
 =?utf-8?B?Q1ZRZmpRblJyOG1uRGkwTDdrU0dmbDkvVzZzaEZIclJXWE9NMlAxcTRlK2do?=
 =?utf-8?B?NGR0L2c0RVFuaUdsWHNQWktWcHBrNlBNNjNkZnlBMmh2RGZVRHdoMDhLOUlM?=
 =?utf-8?B?M2NBNS9MY3VpYmczQWlVUkFmSS8xdEFTblByaVgwV3VXQXFNSmNzYm1LdU91?=
 =?utf-8?B?ZjM4ZGk5ZGFDWGVNaFp0MFYxR3o0bWxDT2NXYml5OFNCNUpOa2NRUy91Z1dW?=
 =?utf-8?B?ZS9HWDgzQ2dYR2Y4eVp3Q0ZjSVlOUWdZeFB1Y1BaYVV6dDhHSmdKSXRIdmRY?=
 =?utf-8?B?cFZRaGJrTVNsaC83Q3g1aVB4L1kzMjJ6Rk5QWXZxQ29CWm9Cczd3QTdKbDJD?=
 =?utf-8?B?UnJiOGtFSHo5bWNYeEQwTTdKMllzc3lrZ3VtWmg4T0FOUlBuU1VoRWVkbjRX?=
 =?utf-8?B?RnVyaEs5NmtabUluNEFBSk5aMHd0d01BUEdwNHIwY0IrVW1UV0tubFpZRzlN?=
 =?utf-8?B?U2N4V01EbnBKd0lwNjZzWnVXUTZHcVpHaUtrbjFYblZvckpTUmVkMkZRcExY?=
 =?utf-8?B?RHZkRnE3MWZkRzlIK05NTms4cm1PSGJIWnhFbWNadnBpd0hRZWU3NHJURmNj?=
 =?utf-8?B?aTEyaDBFcjlBOXE4ZXlMM29ZT0Q4WVE3MFkxM2NUSWJnaDhHNk9EWXdIOFhZ?=
 =?utf-8?B?OERvV3huY2RzWXZEUGREZVp2SXV5NGQ1WDd0UUthRFR4S3RXSFZnb2g3eXdU?=
 =?utf-8?B?ZVRaWUJSekhDOXd3TVFMY1Nxc3ZUVjdZNVJMaGxpNFFsSmRXcUxibzhFUkxD?=
 =?utf-8?B?K2QybURlaXdWbDcwWDJFRDF4YWdjdnNwM3NoTDI0T1lLVW9GclZUbEpWUWg2?=
 =?utf-8?B?ZFlZTktZODZ6Zk9oOXlmcWlNbjFyQ096eWpjQTdXT1YySU9wVXBqUTRqWlpy?=
 =?utf-8?B?b0VJM25XcDFFSGxxMXU3NVVsM2lOSDM4bXJlK1hvNm1TTy9Va2NTTEplS053?=
 =?utf-8?B?UVVVTkNIUU5EaHh3KzNMQ1F4STZnWWtuMk0xUVdIdm9qd2JWVVlRYWFzN0Zr?=
 =?utf-8?B?MmZIVHpxK3BYVEY2U0t2eUw4VXNVeVRhYXFTSTN2RnJ0RDlrQVVTV3QybEFT?=
 =?utf-8?B?bjdxcXd6VXdMbWxjZ1V4dTU4L1FwTDFXY0hXd2ZFSlVqR2ZYSFlHSU8wUGtF?=
 =?utf-8?B?YmhwQWVIYkk3S3FaeWlFNWdUeE04VEFmcFUvQzg1Q1hHVTN1NFhQcFJuQ0xS?=
 =?utf-8?B?cTdvRCtLeXhsM2cyWnpUZk1XUTJ0TFV6aTE2Z3N2MlU0QjhWU2xTdzJYQXd0?=
 =?utf-8?B?N2xPZ0pQNmptMHJDWWY5OGw2SEd5MGFRK3pVNlRqdUxzNlpDdEJ6a2VsSnRt?=
 =?utf-8?Q?swbImfOnjtl81id1YBQveK3jZVbEeRCDT2v+HRr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWIxSzZqK2RCSi9qR0o1VTZqRmVVMU8raWpteW1Wak5NbGZMbGR5dEdYYXdo?=
 =?utf-8?B?TzViYjZmV21mV3E5WExSQXVNMW04WmtadGNFQUtBb3dlOTA4K2RaWEVabjRo?=
 =?utf-8?B?NGFwcDJjZTFqQVc4WVN1M2xhc21SZHlISHBnSHpCeDFnTUttVEFFOFB2eGFu?=
 =?utf-8?B?d0ZSSDVDajFTZFB1YnNqQUJCWTN4V0s5Rzh5QXNGeVU3ODVwTG1hMnJHRjFU?=
 =?utf-8?B?STRsQmg4bU16Y1ZvVzAvVHV6ZStreFplZkM0a01ZMnNJVHdGN2orZjVvMFpn?=
 =?utf-8?B?NHlLRHNFZXV3ei9KR3RtV1pMc0p5VDNqanIzYjNvN25qMHFUUHZYYVJlMU0w?=
 =?utf-8?B?a09kY0w4eWRXdUNTaW9INWo2TENVOEcxbWxzWkZyR3dlRUZlNVFnVis1RmVl?=
 =?utf-8?B?aHUvZHBEYXp3dTR2dFB5VStHNThiSFVhbkUxVWdUY2thWHBRaDg4RTdFdlhu?=
 =?utf-8?B?ZS9nWElzRDlWL01JMFk5d2x1cUZPK2RRelBldE9QcUN1Si9rbmh4ZXEzTndl?=
 =?utf-8?B?RjM5bUxaSDZvdkpxL051Z0tCbC9rM1o0SnRNaDNFVzA1dFZLa0ZDU0wvRnRj?=
 =?utf-8?B?QXlqcnBsNWhTbW4vQnZkTmh0K0lmdHhoaDdhTjMwZkFVWXJEaWtyQXFtUXp1?=
 =?utf-8?B?NEF2R0JVY0dYcTZxOUdMVmZza1NGeUh5RmROOWVPTEJyTTNWM0JkM0ZhdFZx?=
 =?utf-8?B?a3dMVnphcEFGZUtQOWF5enRTS1ZEd0NZaHpqbGNEQ0VuRms3ZmJ2bEFOSjI2?=
 =?utf-8?B?TXllMytZdzl3TC9NVytMZkNxNHhsZXZ4NU8ySDdHQTBsamp5bk9yV1BzaDNv?=
 =?utf-8?B?ZXZYQnRkYXNJTG8xUHpXWExWMy9ucVNvWUVpcGMreUcrbkZvalBoakVud2hw?=
 =?utf-8?B?N1loTkExY2xlWExFcW56c2tVY1BxL3FHSVN5RmJwSzNtTHZTZnFuU21BUloy?=
 =?utf-8?B?UEM1S1hFSVpKS2R6bk9oWG5yeXJyV3F2bUJSaFBEcFAvOFVXQmtraTViai9k?=
 =?utf-8?B?cHJiVmxsNmprNEdvMUE3ZzgxRDkxeXJrbzlxa3dYdDB5SThiQ3ZheHRSd3dY?=
 =?utf-8?B?dzZLTEdtUTJrUmxBVlhlaWlGaTBsL2w3TnI4NWlXZkxWNkptWUp1UnZvcGpG?=
 =?utf-8?B?cGt6aTdQQVUxQWhZQ1pYc2F5cWhnOFU3Y0Q3bmQvbjNxQm1zcWtRSnVwZ21R?=
 =?utf-8?B?SHZJU2JJUTNZSzRNNUdQUVdJNDFyWXI3eWtZclI5VW5SZzU2UWlMS0FpQmZR?=
 =?utf-8?B?WUFuU3NMMDRrTHNUWDNTMXdsSWdHQkNzSWdBc015N0J1ZS92SWx1dWhHaEUr?=
 =?utf-8?B?cnR1MXplR2s4VnlwR3JSYzZRd2huQWttcEtnYS9Lamx3OU16d1RISXpyN016?=
 =?utf-8?B?WC9yODhsNE4zemFDZ2JJU01XRGNPb1VjOXdRVGxabENHZ1Z3RmRmWEJhMkgv?=
 =?utf-8?B?clFGdWwyQkI1QzVveTVFT2VQenB6OGMxTm9pa1ZSTG1uL1B1d2VoMGV5RnZY?=
 =?utf-8?B?cFJ1MnltcFF4NUhSWGp5NlBNSHhjVThwa0E4ZEF4SVFQd215OFNLZmkrTmlu?=
 =?utf-8?B?alR0VmNhYlJwenJMSml2YjJaNUZkK3d6MVNlZFYvZUlaazFPdVJlMVR0RHg4?=
 =?utf-8?B?bVdFSjBsNy9aL1ZSZkN1K1Y3eVZiQkh1SFdaeWdJRDBqcTBaemw3a2Mvb0FU?=
 =?utf-8?B?VWhqVzBNNWFjWnVVdVpITytyYXBtNy9PUlVJaFJHT3RYRFlWZ2FuWk9xNXRs?=
 =?utf-8?B?WHpLeW1tUmpFSnYrRTF1M242cjJGU3pDUU43aFBSZGttd0JxMW9FUk1Ydmxa?=
 =?utf-8?B?REdXTzRMQUh6SGhRcnBUaFV6RXVZN0lhcjFOKzByQ0dqaUpEOVlkQllaWXR5?=
 =?utf-8?B?eEtDV0pkL2J5ZU5wR1FZNU1QYVZxNitwbDNOUGwyV1AxVHl6dHlkVU13MGo3?=
 =?utf-8?B?MEFJZ204TzJFeFBBSUdDd1MwT1VBaEIwMGhEY1M3QjBQSGdWRzJhYmczQ2lx?=
 =?utf-8?B?WU4xbTd0Umt2ME9sU0pyYzJFMTFlbkF3RTlkTEhRV0lpRzFsOUFvVnl4c0o3?=
 =?utf-8?B?WjRxa2lkcmg2S2ROelkyNDFIOTVseno2Z2tDWFB3a05DY1E3eFlTVE1FOVBv?=
 =?utf-8?B?Z2J5eTNHRjlWOHpoQVdMR0JNcmFyaEtkeFllMFJWV0V4RGVvRDhyaVMvM1Jx?=
 =?utf-8?Q?kJatvYtvg+MXSBV/0/kSgFQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31cb6674-6631-433a-f525-08dc9455e5c5
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 13:59:42.8517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0FLh8p7oO4Ovbw9NHqNnOwj1XI2WXqYFWK6nymk04sJ56m1Mq6+BAoFgX3zaLP+IO6GyDaxZQr/2GMMS9tfzhJ9Kc+3pkVWPaEltP2Ie7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5046
X-OriginatorOrg: intel.com

On 6/21/24 01:28, Jakub Kicinski wrote:
> We use random ports for communication. As Willem predicted
> this leads to occasional failures. Try to check if port is
> already in use by opening a socket and binding to that port.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   tools/testing/selftests/net/lib/py/utils.py | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
> index 0540ea24921d..9fa9ec720c89 100644
> --- a/tools/testing/selftests/net/lib/py/utils.py
> +++ b/tools/testing/selftests/net/lib/py/utils.py
> @@ -3,6 +3,7 @@
>   import json as _json
>   import random
>   import re
> +import socket
>   import subprocess
>   import time
>   
> @@ -81,7 +82,17 @@ import time
>       """
>       Get unprivileged port, for now just random, one day we may decide to check if used.
>       """

nit: this comment could be now updated

> -    return random.randint(10000, 65535)
> +    while True:

nit: perhaps you could limit the loop to some finite number of steps
for the case that all ports are in use :P

> +        port = random.randint(10000, 65535)
> +        try:
> +            with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
> +                s.bind(("", port))
> +            with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
> +                s.bind(("", port))
> +            return port
> +        except OSError as e:
> +            if e.errno != 98:  # already in use
> +                raise
>   
>   
>   def wait_port_listen(port, proto="tcp", ns=None, host=None, sleep=0.005, deadline=5):


