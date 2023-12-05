Return-Path: <netdev+bounces-54059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45B7805D40
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 19:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67AD6281F18
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 18:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D32968B9A;
	Tue,  5 Dec 2023 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQE3KB+x"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5B0122
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 10:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701800628; x=1733336628;
  h=message-id:date:from:subject:to:cc:
   content-transfer-encoding:mime-version;
  bh=m8EHwZWJDl30OmwEXQcjtunz6St21CLY7Dg4Ys1IObM=;
  b=eQE3KB+xj2/2c2CTF+oOMQjE94N28OXMNW3zKIKj2wBUqqPYDRU69Teo
   CZwMlUwmqFCS9N8Dx69BubGkcVmsfjRlG8fkZbr4UsRAygsmxrn345Du1
   gaspBB7ucB/7D4nZUONws7bL4NoUimqB/+bQtZwqWbS0bMyoYPJTAoKQZ
   oBecbkL6/B2u+cOGMO2cGimhu6QsTmynpGxz+FcVGVXhs0tlXlsHcpcmV
   lwwXiK6pZWuA7EAwFHLs82blblJctoLP435LHzX97pz7uXc4bcH3kUEgb
   UFqJ1UMSUdysoQqSvn/cWiiZDzLp2sp0o/EFn4EZMI4/Ck5wRFE7wqmIs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="374124237"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="374124237"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 10:23:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="774718044"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="774718044"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 10:23:47 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 10:23:46 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 10:23:46 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Dec 2023 10:23:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUrSuoyr0ZUt424yJ5XUpkviordWx6rmlOoOTv/7N1tE99GkwLm24UqKaLEDdFKlwsFsx1Z583pVX7kX3silEkTy6E11N3BDzm9jbj7slIbRMAfsmw8z/CDxIAsTDFZOhNd45BlSfWojfLXMMj6mCJ2IsNbR+0LXIAhsUDE52LK5zVcONKPrmPuOXsZeq6pZnr/mmNa8lbzoT0i8ZAF6FGInqIQNTnlzkXRWY1V06J264bFJUxdVKcSQQvndGBtyXf35ZmTSU/sN0Q1IEnPhMmSHVneo4+n5vU7mGSUBJxTZDlt9voZOLdCXogYByISIteXKTZqV0LK/EdaRZz1u2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Re7IhPCL+Sd+vVxIzhIm0PrJ9cn/aoj1SwnT12vy1DA=;
 b=DepCj1ALwyp63wVhrEnYfrbOaIlkURp8fIhLjnw19mdCNJH66afYpMY2gFtmtGuPxzbYzBC+TbLjZduXZoMjkSmKhjBFYdJ4oCZDw4aeMoH61ap48MmvhR+AJjXYvU5nn7XqtcvaMOxuJN3vRY5C5+JBNZdq7nv7TjDQVTsU7ekzY599Hy+LNhXRbhP1aPKwJu/3MsNC6ZtaHxvXuDlxb7HR3kITOYOAHl+t+beXVD1D0S7SX13ha8RbABiuyiqD3hzMTHVDLb8LUHmGGFq4jCwX/zLgY653z4/mPtcIF7Tq8Sh6TnkMmG7Y72R4i4SZU7oB0xMxyr0nTZFc39yvJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by MW4PR11MB5936.namprd11.prod.outlook.com (2603:10b6:303:16b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Tue, 5 Dec
 2023 18:23:43 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b73b:45a5:d8d8:65d8]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b73b:45a5:d8d8:65d8%7]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 18:23:43 +0000
Message-ID: <459ef75b-69dc-4baa-b7e4-6393b0b358ce@intel.com>
Date: Tue, 5 Dec 2023 11:23:34 -0700
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [RFC] ethtool: raw packet filtering
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <pabeni@redhat.com>, <mkubecek@suse.cz>, "Chittim, Madhu"
	<madhu.chittim@intel.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR05CA0028.eurprd05.prod.outlook.com
 (2603:10a6:10:36::41) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|MW4PR11MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c38372-73f7-48a5-cb5d-08dbf5bf4fb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D6KiPBo1oN34qLUVb4KFADtvxs0F1tNGYdOKyy8SJTR16h3abm8Kvq1HzDgoVZL4MTI0bQL75u90UV+zkIEOuJg53tN+vIHj7ArEWDrgwawlX4UMnrmjE2kplP0KkG2XN4YJGs13gP1bDv50Mp7iy02io6gyDuI8i/jKMgcqjjD+qpOGd090CfMmuHD+3PwdBGMpQzqOYjxG3j3T4RG26ch4bDa5HhajLI1lCg+YmsnYYc6luBrm43snui/UAzqYek6WF63BH6uQQv1smxG9I/EtKm+pz+yEq8J7fxLlubZMmHwVJMx1MuCOjMmE/5Y5l9U7rreB44lUtrjY1M4hawadWRMx/+EMimkK9W7Lbt81n7xU2yB+2Zphe9uSO3czVBSsb8F4g1R9BHLgiQwfDHGgph5p7uvnE0dvEZCIeCM/ZJ2wit8i/iQ9m1uNXEpr8UN8C2YsHMk8Tr+uAqlU88DNQ5gbbRvUTu1yRD+aVOdfcgpSSFZWUWEDNpd+ivaAz8R9gaT4Up2HmS5DctwD3gz8G4utpHC6KUJIiTUcmB5p90q+uMGmCNryJvUATfCSt+vBebsffWLwcl6qWL68ZNJfL11ubPiemo37PRTuXeiuk5ND0BnUSKXhUMcytptV6QioWhrZAUxSqJgl572Fxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(5660300002)(54906003)(478600001)(8936002)(316002)(66556008)(66946007)(8676002)(4326008)(44832011)(6486002)(6916009)(66476007)(31696002)(6666004)(2906002)(41300700001)(86362001)(4744005)(36756003)(26005)(107886003)(82960400001)(6512007)(6506007)(38100700002)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVRpTW1xR0wrQXNLZUxkaWs3dVY3Q0VFcCt0MXc2UnZuOGtvcWsvSWNWNW1m?=
 =?utf-8?B?M0t6WHJQNGtvdmJMRTBFWk4rbUJXY3BsNUpicjlUNnJ2Y2x1bTFabzBuMkcr?=
 =?utf-8?B?dkhVWDVrSElIT0w0WWV2cVRqeWFoWWlmMDIxYzBNTEpWK1hkVmRnQkhZbkV6?=
 =?utf-8?B?QytUV3RPUHhPa2daWHRLMkFuaDluL09TdkRBK2IxVGlPemxzWGRLOGlybnow?=
 =?utf-8?B?N1FqZlBPRTBKUXo3R1NKTUx4WEdtbW11YUg4OXFkeGJhSVkvNlVTWWlOYSth?=
 =?utf-8?B?MlhrbnFmNGhnOHhuSUh2eXQ5RlNWWXZTUmVrOEt1aUQyRzJXaE5jMnJlTXFX?=
 =?utf-8?B?b3hlNU1lTWRqRGIrek9nOElabVcxeTlVd28yemV5Vnc1bkxhSTlNZHVPdkNM?=
 =?utf-8?B?bHI5dTBkMnRGSXEyN2ZUVFdJWUlwdU1ycllkVXJVd0JBR0JCenBTS0dBc3Vv?=
 =?utf-8?B?bjYvaFhTWDBUUUl2OGZYWENsUG82RmFSQTVFVTFudDgxTzQ2V1c0YmhWQ00r?=
 =?utf-8?B?cFNNMlJpeE5Vc2ZSOXppL2cyVENnbHBQMGVmdnBFL2NmY3loc0xJc0hWb0VK?=
 =?utf-8?B?ejhVQjdabiszczlDdlJUTWMvVlI3eTNGdThvWVdic1Y5d3pxNFZMTWRDYmFY?=
 =?utf-8?B?cFdjQXZlQzlGZ1NNelpYQWttRmtTSlFnN2hEUmkwVGE1bjhXMnJlRnIrampK?=
 =?utf-8?B?bUR2clU1VmRmeWYvUTJmazVKdEFrTFdvZ3dkZWcyUk54TUZCQ3pSdzV0YmR0?=
 =?utf-8?B?bFNoTHdNYzJ3NzJLcWRRcU1iak50R3hMZ3Q5Ty9FMXpod2tQemFrR3lMclB2?=
 =?utf-8?B?UU9YVFJObHJXUTU3bWc2NTRrMnh6bVhXc0ZsZWY5V1BqeG4zcDEwdjkrU2xw?=
 =?utf-8?B?Q1YrTEdkaWlyeWFqeHNxYkNKSlFidS9ld25WRlZEQXpKYlpQODN0S203SHV2?=
 =?utf-8?B?Ty93ME5WS2xrckF0K2wyVnBOZTF3K0lTelVVTk1zcE1VVXhZSEIzT2orWVBz?=
 =?utf-8?B?SjAyN3MrQWtETzFqTVBoN3Fwc0xMYjllazVpRHhPeUdQZHlhS1pCTHNSWDZo?=
 =?utf-8?B?d1RKRVlWTkhyZHkyMmkvNW1aK1NucWp6RUMyUWtVSC9iMzF2NnNmdm53L2h1?=
 =?utf-8?B?WHZzbG50aVpqVlJiSmVtODRXZUZPaVdoWmdRNWViK3pUKy9yOFU3eUxhZUVZ?=
 =?utf-8?B?TWpYV2JtSWNydW5QYmh6d0U4bUFUeElNVWI0SWJxVld5STEvblhHak81NkRP?=
 =?utf-8?B?N3QzVkh4S3VLa0hrZXJuUW9aVi9iNzZqNFhNcDBiZkhoZXZXZXdEMmltdVVN?=
 =?utf-8?B?d2VYcE1xSWtQejFaNEY2NUxvdlFGenNmclplM1ljeHVlNHZ5cWwzdkpGSkUy?=
 =?utf-8?B?azE5VHNWdlhEVXdzb0FyTmxabjhEZ3ptSTVTZEQ2TzJLcGdnNTdHYUUwOWZS?=
 =?utf-8?B?YnZqdEtqc0JpTTlwVDZNOWtFYXdSdlJxMlZJUm5RbVlRbGJtREMxMFRqZDhW?=
 =?utf-8?B?TGUyMnpRT0xnRWlPODdGK2tObjBvam80cExNN0ZQdjJ3cWI2dE1BRVk2NDlI?=
 =?utf-8?B?QlFUdGY2QXVBZkxxOUhFMjd4OUhQaTZtUmpSTUJzRk5sby9VQ1JYTHF1cWlD?=
 =?utf-8?B?Z2J5NDFsT1dIYzI1Q3p6NFVMN05ZRlBwN0VHSUFPRFMrQkhqeHlFaUxtcTB5?=
 =?utf-8?B?VFNCVTNwZHFZOE9LU3BzWlR4SU1GSWZyekpManM1Q0gxTlRBOTk5TnRzanVx?=
 =?utf-8?B?NDV5cHhPZFlNQkNGMDlXc0JjWnFqWGg3T3pPK3A4U2hKeDJvbHFjdUtoTFRB?=
 =?utf-8?B?T0FNWHdpMkZycnpKbXJTMVhDOVZObkpsbDc5T0tvMjFEQ0ZiSmo4d084VDU0?=
 =?utf-8?B?TzdEV2Fjc1kxakZBRC9qekd1T3lNN3VFRlZ1UU9VaFpBbmVtbUZLRXJBbzJD?=
 =?utf-8?B?ZllkdnJ0WVJOZWZjbG13NzcwZFJwaThyTmRyOFpTbmE0YVhWRlB2bXJocGNY?=
 =?utf-8?B?L25rNXRZaFNGbE1uUFF5d3UzRzhqS0dzZHoxdHBQRkFxZThYdE1QOVZaSEpn?=
 =?utf-8?B?Z05XVzZUK00rSC84eFRCOHVBV1hjV1NnTTZuZm4rbSt1NG92S1pkOXIveXVn?=
 =?utf-8?B?STFyY0graTdIVmJBUEtrazlsQ25iUzJiOUNNb2JFb2xBTjRBSmxGbWdRL1Zm?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c38372-73f7-48a5-cb5d-08dbf5bf4fb0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 18:23:43.0308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8fnj8qIhqwFTCFBDbpF26TYiMlRn1xYdox+/fNHEM5SWkFzHQ2qmf0nqvd1VH7BMr8ufTnB35dpXdUNwOiuGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5936
X-OriginatorOrg: intel.com

Hello,

We are planning to send a patch series that enables raw packet filtering 
for ice and iavf. However, ethtool currently allows raw filtering on 
only 8 bytes via "user-def":

   # ethtool -N eth0 flow-type user-def N [m N] action N


We are seeking the community's opinion on how to extend the ntuple 
interface to allow for up to 512 bytes of raw packet filtering. The 
direct approach is:

   # ethtool -N eth0 flow-type raw-fltr N [m N] action N

where N would be allowed to be 512 bytes. Would that be acceptable? Any 
concerns regarding netlink or other user-space/kernel comm?

Thank you.


