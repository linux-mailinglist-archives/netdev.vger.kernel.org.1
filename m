Return-Path: <netdev+bounces-212154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B75B1E768
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 13:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD48F1893DCE
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 11:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980B623C51D;
	Fri,  8 Aug 2025 11:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cIWuI4lL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3F8259CBE
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 11:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652902; cv=fail; b=mdcWik3WEHHF+K3LHeYwiEx5zM/1xb9QjuBV3qZTkqJAqamy9L3n7p21WRgwG5FSleKjIrD2W3kw8vkVchLcBe+Ow5PAbgAwJaXrRMORjstNWKbUgEB6ujlZ9MR+8fg5j6seucXAFeeSMAjkug5YQFfXhAQaphw5wu+bKzlq4DE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652902; c=relaxed/simple;
	bh=kZywrlA4ISe//eZ6ZQOVTuR+jdIy3XqSTa7GRfFpNVw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ugt27vIDR/AahpWpir7xktnOMvNPxqWG4BREjXOIkKlcKwyQqBZ9NA8q7GVMzPD+gMPbtgsv/EvSZKP5zWY1qwGKB01r2XFKl8+tFDvViwHvkbx9pJGWuV/Gs8EkIw5JRJ6cvEw+cwTKRqLBPYwY4gUsPNipMFtKMasbQaY20+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cIWuI4lL; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754652901; x=1786188901;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kZywrlA4ISe//eZ6ZQOVTuR+jdIy3XqSTa7GRfFpNVw=;
  b=cIWuI4lL7pti4Qcha5cXdx3d12FnoIzzk/CUQijFt1mgdnfVT+6mnuB0
   sNeJX0yXdzr+xJzEERMqdPo5A8TMsm+yOifyvLApbSy+wPvVKTVTUrsEo
   P1Cwsf4ZMWn2oENyExgaDp6tcBlVrwBSmhGmSybCeX3JYhKWB8Y9kCl9u
   SLGGBFstCpQeU4b9eIKRtHVefGnkQI3v3AEMxsIcDN3WX+m5sAQ/Nz4G6
   FbhR8wqvEcxvGgm8bmG3enDySLFXThiFgrbfEt4LFoABFK2WWyhA4Ixb5
   xKTlKn77KCk1+GsglvVhhTMsLdWZG0RfRd/gNPlEuargL1NTDWTWx7eqR
   w==;
X-CSE-ConnectionGUID: K66GlQ9sTT+BtPxcZFMXMg==
X-CSE-MsgGUID: C+omIt03QQSzI6ZURTp/uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57080964"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="57080964"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 04:35:00 -0700
X-CSE-ConnectionGUID: eYDSaOJ3QtuUKFxyseONwg==
X-CSE-MsgGUID: FpXU+7ZERPS+ZzEK6pICBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="170687392"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 04:34:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 04:34:58 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 8 Aug 2025 04:34:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.60)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 8 Aug 2025 04:34:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGVvCFzedXqhSBwbs6FDAvKVMrTCpHwESDISHqxdPusfFVOIYl7pdqQ5cCJV2q9MJdDWl1QqEuIRhNaw/ySCDQ3EdAP834C82LM1EcBQHv7tZVWSqeQL72tGIjq4n0L9ii+2/0d0AqNwnALQOFHfInzV7EPhbVyRaAs/FbLISQwXgNtEP7ZVksQlkUq6oLw7pa+qXSM/tJAl1xK+ZIH/mzLxsmMFw4JigHqzQkaMd7PGcaAuc10JyHKoVCkPOBRN7g8vpINOu3AuuB2kC70Blj7Wm66tDbXFSARhssu0RkOlDxgHda3K5Xor2s6w7ZXBJ0C7L5XmdnKjqjX7fvexog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZywrlA4ISe//eZ6ZQOVTuR+jdIy3XqSTa7GRfFpNVw=;
 b=MVDVEZjPHIagXiKnptWY53oTy+MB7CtRTvTMP2D6PsdLu75GExXadvGEoYwwLfsNqM42g3B5ud/VwrRQsbuha60NNXjgeV0ZEpOvuV8RV6AwYCLEzGVPdvnpNlIHpQ1mTVA/njQJ5EwsfJb2z+xvLyb8Kf19opgtsyliJUYWRHvBjhcrZ3kPxJSvCOfezLgbY2mNqkq/i+3gnh21qX4jAB3S9wz+kYKAhUVENHKhoNvTV27cuugA3seKEwoZE0z/IFaRWuZ68cenjzqZ+QENL3JZjZm05T03nRTU90L8id5B+B1H83glVSD08wzm38jNstbc2nWcuDaNKiZ4y2yVew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by IA1PR11MB6442.namprd11.prod.outlook.com (2603:10b6:208:3a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Fri, 8 Aug
 2025 11:34:56 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 11:34:56 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Jacek Kowalski <jacek@jacekk.info>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v3 3/5] igb: drop unnecessary
 constant casts to u16
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v3 3/5] igb: drop unnecessary
 constant casts to u16
Thread-Index: AQHb+6+O8Ijek6aL7Eqj1lteQkWSb7RYctHw
Date: Fri, 8 Aug 2025 11:34:56 +0000
Message-ID: <IA1PR11MB6241EB1D3EBE28F652DF349A8B2FA@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <2f87d6e9-9eb6-4532-8a1d-c88e91aac563@jacekk.info>
 <e16d5318-3e5c-4a4a-a629-ba221a5f04c5@jacekk.info>
In-Reply-To: <e16d5318-3e5c-4a4a-a629-ba221a5f04c5@jacekk.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|IA1PR11MB6442:EE_
x-ms-office365-filtering-correlation-id: 67384da0-1de7-40f6-bcdd-08ddd66f999d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?aFZETDVxclYwVEg0MGUrOWNkcFo2WWRVeUtIRjlsd0ZjV2s4NEpxbTBld2tx?=
 =?utf-8?B?RHhOVU9PcTgwTnc0d0ZsaGwzSElKM1VDRzBOWUpFV2JrSzljTW5PVEY0aUQ0?=
 =?utf-8?B?SXE3WFJ0dnMvZGhIdjNuNkxNMHVzUE9qdUxXR0xEQ0FSSmgvRDFkNEhDUjlq?=
 =?utf-8?B?RVh1UFRmTEV1NGVZYyt2TTUyNkVscHRxekc2alQ2NWE0UlFmQkJsTmdvVk40?=
 =?utf-8?B?dEl0enR5NEFuTlVqcFdoZmdOUFJ3VzNWQ0YyQWdmT2J3eEMzTGx5V2lHL1Ex?=
 =?utf-8?B?M0xtckE3YzdYUmZSYUxTeEJFaVl2L1lqQTFPV3BHUlhXVDRKZDFFSVNYZmRa?=
 =?utf-8?B?OTdxMGhMWHJnTEd6dndUMHhpcmtndmxKVldlc0NpbXZOUFNoSWRzcnVhZVdQ?=
 =?utf-8?B?VTQvRjBaRi9FbFhKL1A4RjFLaEd2cWg3eDBqVll6QjNsMlBtYVRIdXhtQTMz?=
 =?utf-8?B?enRUK0Vtb3pQSWNucXk5eXhNY1pTVkVVWHFRbktwQ2VpRHhhTG9VWkljakhZ?=
 =?utf-8?B?dCttQ3lrb3JhZUQ5TlNrMUdkM1ZVYVVwY2V3N2RWUGFWcjl4Mm1VYi9lZUNW?=
 =?utf-8?B?NmxFMDJPclNZelhibWwxMSt0clM3dDUzK1BNanlpUkhXZHBoRTdycjcwbEVq?=
 =?utf-8?B?MUVsR0k3WUJxNVI3VkdiZWxvMFdmNk1KQXZpZlNXRzhudlFZMkFySDVSVElS?=
 =?utf-8?B?S3VEOTIvTG1SLytwWHk3dElDK2xLNGFLYWVmMUswczJDRitQaEplMmNCSm5h?=
 =?utf-8?B?UHhOT2pQNHdLanBJWXh5RWVmelhTM1RhUjRqUCtKU1gzUGZEUzhpQlIzaXpK?=
 =?utf-8?B?NlM0ZlpMNW5VK3ZLTHpBYWdHK3ZWS3dRNmJzcnJUSjdPMzVNVzRpUG41eVc4?=
 =?utf-8?B?ZXUvaTY3cE9rS1B5dGNWRThwaFV1Mkl0Y29KVlJxNkFRbHpOdDFleGpwZmNE?=
 =?utf-8?B?dVZOQWI3eWNyUkFwbGJTRUNOQW9lbEJOajdVZjBZdVZVQitWdy9aT0V2Skpq?=
 =?utf-8?B?TDh6dnVXSGVrL0Y5T3BEM0dFRm5aL2ZRTXNJRm1hTEY5K1Jmc0JFRGwrRStI?=
 =?utf-8?B?N0xMWExrVjJmRnVvR0Z2VmwvWjYxNmFyNTdHUDhlL1k0czdSKzVDTHZXUTRR?=
 =?utf-8?B?NFhDYnA4UWtzOWFrSlRXckpvK0RWTXJiakhQUmJqNmF4cEMvZEczeS9oeUlr?=
 =?utf-8?B?akE3RmdMbG53NytaS0F1ZWJBK1pBSGMrdC9RaERRRHdNaU82amJGdEE2YUpx?=
 =?utf-8?B?ZWtMVzU5ZVdKTVo3WnpaR3ZWdHp0MURITjlveWxzS05mcTBaVUptSXBReWxr?=
 =?utf-8?B?SDZaaGg5VEREMWpFelZPaXpPbWJoRnhVc0dBZ3BqYUpZRnRsRVNRMkhjd0R3?=
 =?utf-8?B?b2NiNXFPQlpsR3djaTFSK2lTRy9CeVgxdEMweGJxNmhLbk1BRVlrQ3p0NXEy?=
 =?utf-8?B?OUpQNjl2ZklyQmZTWnV3TGVJZEZHOTZJc2N3bG9zdjFZelRLdjRUNFFrSmZE?=
 =?utf-8?B?aDdiVWVjWkEvQ1E1NWlkeEdraXptTDRua0xDUjZHOHBNNGl4SWdieU1lUXh4?=
 =?utf-8?B?VkNOaklzVkx5SFJFSHJabDUxeFV0UTh5YXNWYjNlbFp5T09PU3ZUalpNeDk1?=
 =?utf-8?B?RmNTR2I5ZVRSZXlXV1h5ZVpNWUpwSC9kZG1uUXJJK0Y0Uldkb3JMVmJLc1lm?=
 =?utf-8?B?czE0KzdaUUtBTHBSYzd5N0syZTNXL0x0eXhNa3hVVXE3TjhMQWFadUp3b05k?=
 =?utf-8?B?alZmNnc2bnRKNklTeld4QnZGTkRNTnpjWUtabnVQWjdSVnZkQjlzNVV0WmJi?=
 =?utf-8?B?bys4V1dYdzdoWUI3RVJYQ0lHMVg1TUZCdkxBVlZtbWgyaUl6N0ZHT2QrYXR1?=
 =?utf-8?B?V0NSY0pVZTRIeE9ObkZpWFdjNDlOdmhTc05WZTRxY29uWG8yeFBqTVRmSkVT?=
 =?utf-8?B?ZWVkNFJJWnl5cXIwdzR0bWp5OVcwVjE1ejgwNXdWcGRVc2VYRm54OVhNMmlT?=
 =?utf-8?Q?PgVf9E6YMkxVk/VEF0NApxo533rjj0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHYzTkoxYXIxSmx6Z1c2R0xIa3gyVldOL000cFg0bDVjRU9kZmt6M2kyNndG?=
 =?utf-8?B?UUVSZFBTcSs3aHRmb2NoN3crVWlYei9JRncxUFFnT1lDU0ZJTVhCaFFCQlVX?=
 =?utf-8?B?V2NOVVdMTlZUMjZVMmNDSzFwOFQvMWNsajlDaEZSNDRKZ1MvcHVtWmN3ZGtK?=
 =?utf-8?B?Z0ZSQnVUOFZhTVhLNFZIcjZtbnVyOE5hVmI1SlZkcEJQUHVocFJXeWZLYlFv?=
 =?utf-8?B?YmxaemM4QnBGdHd0UzZ5RnQ2RHh2Mk1WYzRCRzJzWFduWGUvK2NYRTJNU2F6?=
 =?utf-8?B?MDh1ZVd2aHp2alRBc2hlOG05VmgzL0VhNGJEbzFVSElRMHVCbTB2T2ZIdk15?=
 =?utf-8?B?a2NzT0pwR0xUWXU4U0Q0QW1kcGlvY2ZWdmJsZ3Z5SjZERTRUMThaZjc4ME1Z?=
 =?utf-8?B?akNwMnk1NHgvUWxjcHZESllqWmFHZFcrWjNRa3Y4TzVKeUlQNmlaTGpzaFAy?=
 =?utf-8?B?aTljZG13Z3grbGgrRDU5OExJRW0rend3ck5pN0hVemdUdHJhWDVVK01HV3VO?=
 =?utf-8?B?MjBodll0enUwdDR1cEMyUWNsOUdvaFRtVUY5aHFjK2N0VHdiakFDZjI4dmxI?=
 =?utf-8?B?MTR6SUJCMHdheGZTRjlJQUkwMDNYWTFxeFJUZFhOZzczVXpQa0ZZMTJqaytT?=
 =?utf-8?B?bE12UkpPMCtuM0FQRGR6eGowNFU0cXpPK3ZTZW5seElMRE5Jb3dPZndhbEZ0?=
 =?utf-8?B?cEZyUGlvK253OXVuRUhQc2hRbXFvN01OZ09vL01QWUdYSXNzVGwvb2Exa3dC?=
 =?utf-8?B?RE9EU2huOUNpRHdnc2p2dWM2WW5mTDNyVWpaa3MxR3NKM24yWFlpbmlhcVJU?=
 =?utf-8?B?NTRkalY3K0JNcUE1aHVmN2p6YmNobGhXWEdqbHRsSVFFY25ZNDAxdHlteUV1?=
 =?utf-8?B?ZFNsaW5tSVVQeFJGZzYrTmVaRnJkZXhEbDNxSm5JS29QeGNuNkxvRlRmY0hr?=
 =?utf-8?B?aHZrWWV5SUs4QnU0a0dkS1psMUQwdENsMUdPRFhybitpSUt2R3R1NDBsbVRh?=
 =?utf-8?B?MUk2VmVkSXdaSDBOUjJQcExSNHBoUCtDdi9uVHJqam16aTZJQ0pLL0JRVlVZ?=
 =?utf-8?B?ZGZiUkVNUjcvWnRNK1pYaWJIOENmK3MwbjJEcWZOdFdLc2FtcG9rVWJCN3Ex?=
 =?utf-8?B?eDdlWkM0MUpHc3RsR1BaL1JFdndOZEp3bjBmRmM5cmFFNDdsM3JnU1h2SVNB?=
 =?utf-8?B?SmRSQVBKSjZmazBlZmRpTEcwbTg3ajVqakJVTHRFTzlGcHBjYlo0NXVlQ0NI?=
 =?utf-8?B?dytBSkI4QkIrRStzMmY3bjZlc01GcURIREJBYU1VYkRCc3ZoNWViSmFxTDAw?=
 =?utf-8?B?cUxscU5WU05oeW52cjVjM3lDV0F1SUVaTjEzb0xHVTIwcHV5UU5hRnZSMytD?=
 =?utf-8?B?eElYNEJkQ1d2TUpUR0QxSFVhQ080bFBnKytUS3JhY2JKTXlSMWxDN2FuRUJJ?=
 =?utf-8?B?N1Qvd1hJOTR5azdEY2VxUytzOWFrQktDK3U5bExkeEY5bXZNUjBHbWZ3cXVu?=
 =?utf-8?B?dThVTEdsYklJb3lzMFRkSEsrV0pra0o5cWJudzd4RFBDY21CMmNaOUhZZ1ZZ?=
 =?utf-8?B?bFVGZDFGeHR6WlUyajJmeTRadkJ4QzBKVWFFd3hkYUpvMFJKb3pBd21GSnFC?=
 =?utf-8?B?dHhBVzRTKzluZFlHK2s4b3YzaTlYMXhqZlBQd2ZLRzBxOURjYUdQNnpYMFl3?=
 =?utf-8?B?amptN3d5MDlqWEJCc2IvT1Z6a056V0FBUUVjbFJLZ2Z2R0Zid0NIekxTV3p6?=
 =?utf-8?B?QWxWbzdPMkcwTjFINmY1Z3R5V3gwUDFPekdwSk03VmtaNDl4WW9xQUttdm0x?=
 =?utf-8?B?NVRjU2w2TjMvekcyOFpURGZJNmlnRGp3aUxPUFBySHZ5WnJ1blpvUVRNaThh?=
 =?utf-8?B?aGU2eStXVnFqM0F2UDNaZmJmVGpUVit0WHB2RWk4bmlaODArSDkvUzRaS3dI?=
 =?utf-8?B?RlZwZGlTK1grTWhTQTZOVjYwQzl5Y0FMVzdrTUZ1Q0R6cTZiUjZOazQ2bEtO?=
 =?utf-8?B?UXNVelhwQ21NakM3WjlCUGd5RnRxTkZvdEhMQ2dRdFdtRWN3V2crM0VqQ2ZL?=
 =?utf-8?B?SHNFTmhKMUpxejdZUDdIdUZpZyt3eEtRQVlBcitVQWE0cVVEeFRreXpjL1FM?=
 =?utf-8?Q?dZsQqe5QseETUGP/RmDc9gBFG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67384da0-1de7-40f6-bcdd-08ddd66f999d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2025 11:34:56.3349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zcn0Wc0Bp6sklpVjhG2k7nwofaTbETXoRjnWFuSWZP52U7/qE2KwmWOhy1Z0vcsCHSSJCZCLnE85ze1vW0NQWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6442
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBKYWNlayBLb3dh
bHNraQ0KPiBTZW50OiAyMyBKdWx5IDIwMjUgMTQ6MjUNCj4gVG86IE5ndXllbiwgQW50aG9ueSBM
IDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IEtpdHN6ZWwsIFByemVteXNsYXcgPHByemVt
eXNsYXcua2l0c3plbEBpbnRlbC5jb20+OyBBbmRyZXcgTHVubiA8YW5kcmV3K25ldGRldkBsdW5u
LmNoPjsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0
IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47
IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2Vy
bmVsLm9yZz4NCj4gQ2M6IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnOyBuZXRkZXZA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBpd2wt
bmV4dCB2MyAzLzVdIGlnYjogZHJvcCB1bm5lY2Vzc2FyeSBjb25zdGFudCBjYXN0cyB0byB1MTYN
Cj4NCj4gUmVtb3ZlIHVubmVjZXNzYXJ5IGNhc3RzIG9mIGNvbnN0YW50IHZhbHVlcyB0byB1MTYu
DQo+IEMncyBpbnRlZ2VyIHByb21vdGlvbiBydWxlcyBtYWtlIHRoZW0gaW50cyBubyBtYXR0ZXIg
d2hhdC4NCj4NCj4gQWRkaXRpb25hbGx5IHJlcGxhY2UgSUdCX01OR19WTEFOX05PTkUgd2l0aCBy
ZXN1bHRpbmcgdmFsdWUgcmF0aGVyIHRoYW4gY2FzdGluZyAtMSB0byB1MTYuDQo+DQo+IFNpZ25l
ZC1vZmYtYnk6IEphY2VrIEtvd2Fsc2tpIDxqYWNla0BqYWNla2suaW5mbz4NCj4gU3VnZ2VzdGVk
LWJ5OiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiBkcml2ZXJzL25l
dC9ldGhlcm5ldC9pbnRlbC9pZ2IvZTEwMDBfODI1NzUuYyB8IDQgKystLSAgZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaW50ZWwvaWdiL2UxMDAwX2kyMTAuYyAgfCAyICstDQo+IGRyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2lnYi9lMTAwMF9udm0uYyAgIHwgNCArKy0tDQo+IGRyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2lnYi9pZ2IuaCAgICAgICAgIHwgMiArLQ0KPiBkcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pZ2IvaWdiX21haW4uYyAgICB8IDMgKy0tDQo+IDUgZmlsZXMgY2hhbmdlZCwg
NyBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPg0KDQpUZXN0ZWQtYnk6IFJpbml0aGEg
UyA8c3gucmluaXRoYUBpbnRlbC5jb20+IChBIENvbnRpbmdlbnQgd29ya2VyIGF0IEludGVsKQ0K

