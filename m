Return-Path: <netdev+bounces-188445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DE6AACD89
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 20:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19503980DEF
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 18:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA89B2868A9;
	Tue,  6 May 2025 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IyYHPjy/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46C3280038
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 18:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746557561; cv=fail; b=YKQExiCfMfWTmdmnbdNPFDPbppkTXL6CpemGqadJMm1ZFMXvwYq8QbIHMGDKXBO0Xu6zkNe/XyjCykT7jrUeqp8dq4I+tjOxGcPAnQL0k/sAlQDcxFSpPG95bGJiBWRk6ZD5rxZnAmdTmXb4Ete5ehbSdaSKkUXmyDMA/j0p7xI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746557561; c=relaxed/simple;
	bh=rHW+n/IVAOiNFP35lTcEkKlMgr0GOd/ld/U7utoaaIE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EDocDUpUlPFpoKMPYIbLKOqcbkUSaiaaTsZfbwYYMEs6DlChzxjVz+yijFFDVpEEdqO34CBwNcF4T4sKekfC5+Mywf2lc3Z738ZziDaCuMx+MlpvKKZN02mWPb4jHNw/9EBhw1XLiimPhKMRA8JCnCy/YTFdmsB9RKLZfmHkzZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IyYHPjy/; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746557560; x=1778093560;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rHW+n/IVAOiNFP35lTcEkKlMgr0GOd/ld/U7utoaaIE=;
  b=IyYHPjy/z5gz09qe3MgK0qI4+pv+NnY54GJhLy3lTigaSKql6xrlGiv8
   gq+WWAeKmyR8JV8FQ5PKwwZzf7iD2+itSCARq3I9+CwrTMXcm9xmLsaBH
   Tcj3YceUKsAXH+qMdoeQOzXQf3cQ0X85SpPR8+Aafsnv2ORp4+yG2cRAo
   xZVn1se9XmFT8RX+xSwp6ZTRc+VFErYK3Mmb+SFaDJq2W4nLxl9fBWE2U
   fup6lx5CozvHaEh3O1CchUNWLU+GPy5NjiQ9zPvg6b5auqRxw8pGzhL3N
   o+B0ezjHyBln6aNLIAuK1ltLxFQL2EJBjLl53Nhg/Z1LgwHe1t92B0JyC
   Q==;
X-CSE-ConnectionGUID: Mh+W4SamT1KcWN3osOkEOg==
X-CSE-MsgGUID: u6QuvhgZQJCJgNzOFwNKbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="52067632"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="52067632"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:52:39 -0700
X-CSE-ConnectionGUID: luslFiouSsWGgX1TwP5ukA==
X-CSE-MsgGUID: H5JW9nFqR5a6FdkyZrPyYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="159004816"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:52:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 11:52:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 11:52:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 11:52:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOe4qXIWevRCal0sHrBgN2SQyGUAU73Nbe5KotV4dTsuYoJkxo7QUruwOUF0CzEpjknyjajl2fiBcTFp7OYsZHMASXGWXwCu1SgDX9vs6hFgVh0HZTxjCbi+VgoXntRraEVdtYtK6EZ9lVSJiOPz42ZFNvPEbD57GJoD7CONFtNhpqPHmoibkKTVZtau+q8GB3cZWsI6nmeOdO17168NNhTHtGoyQWXLX12txW1PPdMHV8fbHL24T/a+hNWpRnr+0bAtD/jeeBcCxKKqq4ja8ZGAIJUbopY0QeO4fDoGwGF8kyjKJ7CfrKNo2ayZq/1f+l6wwzLt+zbyXukXnTjpjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmK2tAB+HC9vBl7S+W0BYXi2dG6O14GWwOTUw/n/YS0=;
 b=EWYzoKCtEg2O5YZg6FO3WnmPdeYR8NUzlOpwFd7bv2Hciow1wnOIf5KwBL6Y7BDaEqsVjqyTiYIobqXMkGPoIrZzAdWUfyqj9WPjrbaywkW9W672hFKlHVTCb6ldj3uW4/SjeS7QnHgEo0y6TqQMgpG5EYdcXW6xne5FwlzK5rSqXbZfJ9F/DTePqKh022HjX3wiWupSB6N9sVht3lRX51gm0TYIzYCOOTmyGcUUBMJr3nvVwlyXHofgwPfLfoHFCJYQX06Ia28kt5R8YYgg8gnUp9jMmn8BhbC/T1v18LgNde9pitfysfq1l0W0dIRT3YXjddRu/9nvnCJcq9uRTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Tue, 6 May
 2025 18:52:30 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 18:52:30 +0000
Message-ID: <b85c0c94-6c31-4c27-b90a-0e8c540d8751@intel.com>
Date: Tue, 6 May 2025 11:52:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH v2 4/8] fbnic: Actually flush_tx instead of stalling
 out
To: Alexander Duyck <alexander.duyck@gmail.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>
References: <174654659243.499179.11194817277075480209.stgit@ahduyck-xeon-server.home.arpa>
 <174654719929.499179.16406653096197423749.stgit@ahduyck-xeon-server.home.arpa>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <174654719929.499179.16406653096197423749.stgit@ahduyck-xeon-server.home.arpa>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::14) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: e0123539-7f2d-4c15-4975-08dd8ccf2779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGtMdzA5enZ4MEpHS2VvZDNwZXpFeG9WSVdwNUlJWnIvSm95VnJ4TzJucDZT?=
 =?utf-8?B?MERPUElMbkdieDhZaS9CN3VEZ2diZjdzQzI2U2czNnhIREJsUkJSV3B3ejNE?=
 =?utf-8?B?T3F2Qm8xQXFIUTAzWVZqY1hvQnN5QWdRMWp1dW93SGJwRWQxMjJOWUMxcE1K?=
 =?utf-8?B?VlNqU3NKa1VoUVZReTZFaFo5RXNzRmhMWDVsS3dseXh2VGcwWTlwTkNxcTdG?=
 =?utf-8?B?U2tVRjY3K1dmV1Z5N1hxTW9sdzFsemtaRDBTUFZQVGcwanFhYkpBbEFHckl6?=
 =?utf-8?B?NXByMk0zNGNBa2IyZ1d3QlYzTkdoekJ3eG1ZU2lXZU1FVVFEQTRqeDlRNHZV?=
 =?utf-8?B?WHN6VlhDQmZYZjlhVUVaZzY1djJvVW04bDRyeks4bEl1dzYrdlRyaFNwOXM5?=
 =?utf-8?B?bUhoSTEzT0FLTTZBdUpON2cvVHZKV3pQZlRVTGczL1pQT1ZoSnlUZS9XWngy?=
 =?utf-8?B?OGUvMkdMU01oV2I2ZjZjaGxoc2NrcHh3OEw2OTA3Sk5uRGdMOW5kcHFCaDhN?=
 =?utf-8?B?UDR3ME5qblRUTndvSHZqbktKNjNnZlJhaGZGTTBZT0Y2WTgyVGRCWWNWV29Y?=
 =?utf-8?B?Sjc3VGV4eEZvZWtxUStjVlBJNlM3WEt5d1I3bWZzR2pZOEhXYjFOZm5VU09R?=
 =?utf-8?B?MS8vVUhwRTZzUjZkRTdLNUJwLytIdERta3ZyVFQ2QklNb2gyY0JadGJjdkRS?=
 =?utf-8?B?N3orWmFYREF5SjR6anRVT1JPMmt1Q0NxWm5yZUVmRGx4UUxJbG0wUDdSNGc0?=
 =?utf-8?B?NXlRUjBLNk03VkxaWFd1allTaUJ5U3FHWWNFYm91d1R0ajN5c1dRVFIzV2Vs?=
 =?utf-8?B?S0U2WitGbmp1U0J0MzRWVWh2bEd3UjBid2Y2WVFNdHdZUkdVM0U4NGR4OG5r?=
 =?utf-8?B?RHpQV0luSVVOaC9tT1k5a1NLM1FBYjRGOVJDZlNYL1VuWW8zUjBWWlZwczZN?=
 =?utf-8?B?a3pyWjVrdlA1ci9BUGUyNXpXVmZIOEVBQ3FEREdyY1VicEdSdVM5WDlybDYw?=
 =?utf-8?B?amw3d0MwOUo2d1kyT3N3ekwxNkFjYXlqck1UeENrcXdCZHB5VENNdmN1dWpG?=
 =?utf-8?B?NVduRHVvRnJDRXppNmNKb0dDdnpRWi9TblVpKzdxcW9talJTeGV3dnkxQVU3?=
 =?utf-8?B?TVIrQ09DK1BTWjkydmduejdvenEwYW8xSnNZcDNPQlRIQURNLytoK2dOSGNz?=
 =?utf-8?B?NkNGSHQ4TUJNT2xVaUY3VGJyT1RpMnluaWJiazE4cFhkNE42STNabzd2NjBs?=
 =?utf-8?B?U3VLcFBFNlN5MTR3N0tYN1JRVG5EdU9rNWdiRmpaSW03TlhBSVd3VlBFZHVV?=
 =?utf-8?B?RjlReDRGR3ArWkdLc1hFZVVhQWxVcnFFcmlidlhmSThrbkc5TVdReUllVFM0?=
 =?utf-8?B?YU1seGc3OEhYZ0tsOXo5cW9WZkk5MTlUZTNPMGNNbmpEdlViMFdqOGJEbm5z?=
 =?utf-8?B?eVFkS2dZaDhjTkYxbDNVYk5XZG9IK0kyMDlqRTlPekw0T2hzTG41QndjM2ow?=
 =?utf-8?B?Vi9WTCtnc002dkk1bEJaVUhxaWJOdGRUalAyMFllMFBNVXZOcHBpeVBPcGtJ?=
 =?utf-8?B?bXMwbUJJOXR4bVd6SjFFK1pIbktsZityYXM3b0c2VWFQMzZiQ0xObzZrc0J3?=
 =?utf-8?B?clJTTVEvMHBTSDM0SnV3eGpTckxNcEJtV1hSVE5iUEl5em5TNUV3UFovalFB?=
 =?utf-8?B?OGl5OXhVVUw4NHhrRVJlMWNFNHNPYXBoSU9KNENTVnBTQkxzOHQwTXd3RHQ3?=
 =?utf-8?B?Sk1aRExPNWJlZVBZc0pNTkVvWFZjckhrSXhTV2lxWStwdUdYYUJSNTN3bEJJ?=
 =?utf-8?B?ZS9yd3o4ZUltMGdqRE14bVFsa04rNjNrWklOOFZCSmhYWGZCQkxEeE5Nak1B?=
 =?utf-8?B?SzNDN0lBMXFpVkJyYkNOMSt3ZGpCdU5hNjVUR0xvdHVRcHBwKzRSL1hyVlAr?=
 =?utf-8?Q?GML2jnCA0PA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGlGeU5mZERSZTNaenZ6WUU0VE8xNDNDVTFJbDlvKzRYcTNFTlI5cXRtV2NB?=
 =?utf-8?B?bFNSclh3TU5xZ1cvOGYzMVJ3VERjaklKamMwc2svRk9zVVBadDRMVk5XTnY5?=
 =?utf-8?B?SDhYMjBzampsRXluSWFxaFhVWGlIb3E3bUJoOUdZVU54RHBBVGdxSncwMlpR?=
 =?utf-8?B?NFRGTUdFZmJYYU1VSUJRL2hUUUhEZkVGRnNtaVE5TzhkWU1YVG1yY2lIRnI5?=
 =?utf-8?B?RCtIM3BGcDhkMzVGZzBXWlI5RTA0dy9MM1dKRHZRRGFDTlkxK2dLc2NlOHU1?=
 =?utf-8?B?THBxRWxSaUJ4Q0FsZ0VSa0lJS29HYnQ5ZEZTMmFoOVJQeWlBMjYzY05PdnZM?=
 =?utf-8?B?a0R5ZnhZUnJxeFhvaURPNXZJa2JKdG9rdjZicytlcHAvQVA2QVNXRk8zOEJs?=
 =?utf-8?B?SmdXZlNVcVNMdkkwZHJhTVVOQ0JqZmYxZmZRQXRRcnc0RHlxNStQa2tHMndO?=
 =?utf-8?B?ZFJJb0Q0Uy81S1prQ21Ycm5QbmlpNURZN0IvVlZ3RTdnUjNaeVJiL3kxRXNB?=
 =?utf-8?B?YVZnald2OWRXcWZVVFhyWWRZZklpNy9GcHNEOXNVZDQwd0lsczZtKzNnY2Jt?=
 =?utf-8?B?SWs1ZmtEa0ZnS0NBMzdqRzVaV2hkd3lDSm9KNkNPYlNCWXdnNHh1blo3Qjk2?=
 =?utf-8?B?bmcrZVBjZkFOZ2FWSHZIZWFLN0ZwWVhvcm9ZUjkvbS9qVXNQT3FRZVRWSzkr?=
 =?utf-8?B?c3lrOFpGa3lrQ0tZcWNyM1JXaW5lc0lYbitIMlBaNmZXMm8rNTFKaFBwV0Er?=
 =?utf-8?B?RVJheFprakF2Y2dOeTFsaDI2UkFqREdQa1NqUW1YMFZDUS8wMGNKKzlhc1or?=
 =?utf-8?B?cWF3ZzhTNUJTaVU3eWtsU2JiL1VaQXZFL0lUbWQ2dGRNTnBuYkFaNkhITE1P?=
 =?utf-8?B?a2xrc0dEVEN1NzBsNjVNamVLWVYvVlU3U0tvUFVGVTRCdG1yOWNyaFVaSmpw?=
 =?utf-8?B?MGhzcW9Ec0FadXFZTmRhRkxKVlQzZDZMZjZ1aVhFSjQ0QnFpNWpVM0xHa1BY?=
 =?utf-8?B?VjlmNEc0b1hUbUE1RUdrMFR3NXBOTHRsY2ZWN1p6VVY5V1lpZ1ZycDZDVy9H?=
 =?utf-8?B?QWJ5Y1pyc21HQmErK0pJdjJkS1BISzFiVmYwU2t6VzFrbVhlQ3FrT25jekEr?=
 =?utf-8?B?eDAvTzJFcldCdW8zbTJnM2RuM3RETVVCTmYyQy9nTm1ZT0RLYUJ3ZTFxKzhw?=
 =?utf-8?B?eHplTWpDaHBYbk5iTkNpdm9XTzZRNTN0MW5uSWZYS2VpN0QvcjBpRExxc2FR?=
 =?utf-8?B?OE04d1B2SWtIRm1KaEJ4dnFyWGU2ZkVmSGk4UmRsN0REaEpxMWc4dEJhT1dF?=
 =?utf-8?B?andqTmJCUi9rT3pDYmdNdE9YVVQyYmc1SVBxTUtVMURUb0d6Q2gxRmhGZi9Q?=
 =?utf-8?B?MUp4VmxlSjJyYWdWd2srV0lzSUgybXlwYWRkM3pnRHRHVzlsOVpyeXJnRnlO?=
 =?utf-8?B?Vzc1cGlhaG5zTnZsbm44b0gyV1RLUUFmMjZnT2hTbVg2aVphSlVEeG80V1oy?=
 =?utf-8?B?dk9zc0FpeDRYWFBEVGE0NGtGUjVmTnEyUG9TNFAwVC84MkNoNWJVZXZtSmE3?=
 =?utf-8?B?cEs1Zmx0Zks0UWx0UU9wNXM0V1RMbmxTNjV3c2FBdVMwL0pVQUdqOXR5c213?=
 =?utf-8?B?T2krZkZmclk0NHEweWtjQ3M5OVU5bzRJRlJ6djUwNFBHOVkveHB4QndQSUc0?=
 =?utf-8?B?cURGbmhBaXhGWXZWbDkwMkNHc2tBT3hrY3VyRnNjcEFHbW5DNVJmR3gvcHVW?=
 =?utf-8?B?U3g2UFhIZHdNOG8wc3loSXp6eFAyaDZnMW9PRmF3cDdtVW4xbWlDUTFlOVhQ?=
 =?utf-8?B?bFAydk8xSTBCWmM3cHdJcDc5d3J3NnlLUVJ6eFVVQ0VoZHNWdzhOa1c5VWdK?=
 =?utf-8?B?cTVlNEhuUTNsc2NMeUZoWnNjZ3BTN0wxZHJ0MmI4V0RUa3d1ekZJZnBwdUpu?=
 =?utf-8?B?WTJJaU91NDF1TUFsR3NvTENWSlNwZEh4dnQ0L3VBNnYzTk9NdXlrajcwZjNp?=
 =?utf-8?B?Y1JOV29EVlpya0xZQzF2V0JBVU1nTk82azA5cXZnaTlQSGhLcXJqSkRXbmJn?=
 =?utf-8?B?U3JEcWJGcFVPd2F0Sk9hc0dhcHVob2FJd2dOa25lVW9Qa01nWjdSTXc3RVFv?=
 =?utf-8?B?ZG1EUER3NWdHZXg2b3kxYThnV25TbXViVUsyZjc3dEUyUnVsUnpxWnVzSDRR?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0123539-7f2d-4c15-4975-08dd8ccf2779
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 18:52:30.5792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUEGZO8JGC/4pVc/0uuUq5UT5Ai+J5scsiM0TD8VTOVRZKUlGAk6r/VD5Ua55tKQ8kB+0tsXCY9ubxxDX5NhBUEg6yMSTagGc5joohUBKmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5772
X-OriginatorOrg: intel.com



On 5/6/2025 8:59 AM, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> The fbnic_mbx_flush_tx function had a number of issues.
> 
> First, we were waiting 200ms for the firmware to process the packets. We
> can drop this to 20ms and in almost all cases this should be more than
> enough time. So by changing this we can significantly reduce shutdown time.
> 
> Second, we were not making sure that the Tx path was actually shut off. As
> such we could still have packets added while we were flushing the mailbox.
> To prevent that we can now clear the ready flag for the Tx side and it
> should stay down since the interrupt is disabled.
> 
> Third, we kept re-reading the tail due to the second issue. The tail should
> not move after we have started the flush so we can just read it once while
> we are holding the mailbox Tx lock. By doing that we are guaranteed that
> the value should be consistent.
> 
> Fourth, we were keeping a count of descriptors cleaned due to the second
> and third issues called out. That count is not a valid reason to be exiting
> the cleanup, and with the tail only being read once we shouldn't see any
> cases where the tail moves after the disable so the tracking of count can
> be dropped.
> 
> Fifth, we were using attempts * sleep time to determine how long we would
> wait in our polling loop to flush out the Tx. This can be very imprecise.
> In order to tighten up the timing we are shifting over to using a jiffies
> value of jiffies + 10 * HZ + 1 to determine the jiffies value we should
> stop polling at as this should be accurate within once sleep cycle for the
> total amount of time spent polling.
> 
> Fixes: da3cde08209e ("eth: fbnic: Add FW communication mechanism")
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  
>  	/* Give firmware time to process packet,
> -	 * we will wait up to 10 seconds which is 50 waits of 200ms.
> +	 * we will wait up to 10 seconds which is 500 waits of 20ms.
>  	 */
>  	do {
>  		u8 head = tx_mbx->head;
>  
> -		if (head == tx_mbx->tail)
> +		/* Tx ring is empty once head == tail */
> +		if (head == tail)
>  			break;
>  
> -		msleep(200);
> +		msleep(20);
>  		fbnic_mbx_process_tx_msgs(fbd);
> -
> -		count += (tx_mbx->head - head) % FBNIC_IPC_MBX_DESC_LEN;
> -	} while (count < FBNIC_IPC_MBX_DESC_LEN && --attempts);
> +	} while (time_is_after_jiffies(timeout));
>  }


This block makes me think of read_poll_timeout... but I guess that
doesn't quite fit for this implementation since you aren't just doing a
simple register read...

Thanks,
Jake

