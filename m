Return-Path: <netdev+bounces-237191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84575C46F39
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 14:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B34C4EBC92
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 13:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A0830F939;
	Mon, 10 Nov 2025 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Io8UFXzT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EA230E823;
	Mon, 10 Nov 2025 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781809; cv=fail; b=jV+vuxbDy8sN2pAqGlZb51zzFATHT1332yeYAULQxFO5aIYmZsi4HiGZaul+BG/n+BtBcz5cjFrv8SFfu8uZPugbW6m8UCrEHSj19AfGb19Fxv+1a5zSetB8ODrzjsj61WTYSr+XSwOqmdzKXmwGowGZKDkZMdbPPyFmwOvheaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781809; c=relaxed/simple;
	bh=tgblCaQ9nhtk0jpMwwUDm3rg8BNFf0WGAiSJYS68/BI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Crs/mZxapk7jT1xL7Ep66FEQk8LSK4sD2Y/wYoRdIPFVpKm/hDhAP9C94Vye2cZbCE6V92FHvfAJYwQEFf9MgBCMqApUaN8sCOfLX9687IhpDcBFpLuhWVJ2ojMXZILNghStJWNpwm0v6IVhEaOrfbc4TvoxZqh5lmy/g7ceGEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Io8UFXzT; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762781807; x=1794317807;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tgblCaQ9nhtk0jpMwwUDm3rg8BNFf0WGAiSJYS68/BI=;
  b=Io8UFXzTSiJDqjeCzyanz8BPTO/cIbFPJVZEKg/wXCtrnAcMR7XR42cc
   fXzrk3ECQ/9I3tUIWncBv8ryL9lRX6a/7PAWtHgqgNO43iP1sVJW/oPVL
   gPn9+5givfNb1BZwAGi0bcPNidCk0CviHcDBHfGHJtAU0OeGRlfptMRGV
   X5TvFCvDdnSQdTMgErrURfxWKeBWXcBZJBhgqDaBtwKibnduu9dwwrpVc
   N6C4cKmx0yySclLWZa7kglAqe1whpEF5uQpfl2P5avO428xgHabx/yuCy
   j8r8gl2XOfNUhVkzAOAkKQ1yQxAYVFllfmM9uix+1AR3xwcj6RbZIiJu1
   g==;
X-CSE-ConnectionGUID: f10+vhtQQFGNL3S6F/fpLQ==
X-CSE-MsgGUID: xm+kKgckSOeATMkJKHmIuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="76177413"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="76177413"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:36:46 -0800
X-CSE-ConnectionGUID: sMPNvXvISsOUH4PKC+45oQ==
X-CSE-MsgGUID: /PirdtSiTeuobu0+/laWbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192785280"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:36:46 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 05:36:45 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 05:36:45 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.65) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 05:36:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mipPFRLdH3RDrIMwQeYMpM2b2v5Xc79JbuB7mmVtnIvUd8KyqFhO26g+JilSdHcFcUEKxAtDiiO2OjKqaBOx5IRqtrYfl6Ypj1lEZ8Xam+4iZtOsmwUepBViT0//DgH39xZJZmELJtG91a1wXaLAFx2vwRLBrClAogvd3TzJ2WfYzIkWgc+30dUNx7tyKgdnQE+hd755G8Sw4gLUFo7F91H2rlBpdBVCFF2FwZBNPgaQysIcYOG4vEvgQ+pn0caA6K+TOYRS9CKznfiXG8Z/GyIk/zlbQLew5s2GUwxYGiO0DZx83azROTZJ8+ixdKbZs1J64T2KaZ0MuCzO6GxMHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgblCaQ9nhtk0jpMwwUDm3rg8BNFf0WGAiSJYS68/BI=;
 b=J3qaD4fWKoE3suk7T3Ggx8Zzz43AxzuTieerlAIyrUGrWKGFut1waXFNBMp2t0xLXYioTPZSgp4VzzUaeUXp5he31msJSgEEfaFYAhkK5MM0QDE+zFOWvaOi0J9cI7cB1KKD6vF90mm8q17BYXpL1i3xA7Q5yHlwgOlJpnJ0wOogUOzfaVBu86gny5sqIMeaSFb4s5aKCjTrTUoaH9qiK+dYouMFzXv4QVqfYlXEgr5dElw4r9Mets/ayqKeLTq+e3anC6B05W/spqUa0N03xYN2ofKlL7m+s8jFdq1FhRQQX/96icNDO3bbsdXTKwH1Qw3kLXgfd2rEwml9HJMWlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by DM4PR11MB5278.namprd11.prod.outlook.com (2603:10b6:5:389::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 13:36:38 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 13:36:38 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Birger Koblitz <mail@birger-koblitz.de>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Paul Menzel <pmenzel@molgen.mpg.de>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH net-next v4] ixgbe: Add 10G-BX support
Thread-Topic: [Intel-wired-lan] [PATCH net-next v4] ixgbe: Add 10G-BX support
Thread-Index: AQHcPrzED8PtbQveKE602+iR2hRwpbTr3L6w
Date: Mon, 10 Nov 2025 13:36:38 +0000
Message-ID: <IA1PR11MB6241D933EBBFA8611AD554378BCEA@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20251016-10gbx-v4-1-0ac202bf56ac@birger-koblitz.de>
In-Reply-To: <20251016-10gbx-v4-1-0ac202bf56ac@birger-koblitz.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|DM4PR11MB5278:EE_
x-ms-office365-filtering-correlation-id: ad8251e4-40a0-45a8-de69-08de205e2cdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|921020;
x-microsoft-antispam-message-info: =?utf-8?B?TC9sbVR3N0R5WWkwbmRVdTNCdWM3TW5JY1FUQXNnL1lKaWYyU09Zekk3enpF?=
 =?utf-8?B?b2ljY0ZvZXhTUkhFMi9zQWI5UkFFeUxLaVdwVTZMeTQxNEpIN1U5OExZK3dS?=
 =?utf-8?B?c0NxWFErNkhEc0ovT3RPb3o0eWNrRnZMSTU1LzJRL3dodWlvMHU2V29kUXgx?=
 =?utf-8?B?R3paWDJ6TVRabUZsRVBHYzBsRTVEUllxMWFldGdCSk1IUnBRNUl5V0JCWkRh?=
 =?utf-8?B?VW05dVdTczlkTUM2Wkh6OFdTdUIvYVZpejFKTGVVd0RPVHdoclRBd004OEtJ?=
 =?utf-8?B?U2JLcVg4RjR4WnFrMTJGb28xdzBTRGxWY1Jxci9qMTFJVHozNHUwWnJqU3dv?=
 =?utf-8?B?ekFINUM4WTV1SVlyMjBYbGMvMVlsZDdIY1A5QmZOeDZiMXkvWGViaHdzM2xJ?=
 =?utf-8?B?bCtGZzI2bjVMNFpVYTZsK2hMN2lUamJRWC9rTU9zYWNaUEowSnA2dkF2dUdK?=
 =?utf-8?B?VkJZSFkvL2E0bS96ekZRVkJBVDgwSFBLenlqWVpzSmNnZUE5aWtGYXhPdlBh?=
 =?utf-8?B?L28xdzZTR0U2L2J1VFd2S3U1SzZUdld3eGk5ejJhbWFPUllNYm5LN1dGeVM2?=
 =?utf-8?B?T2RnUlFjMWtzd2JGSmNuV0VibzFjeHJOUW9qakZ4TmxaRmRObGhDM1RZVi9n?=
 =?utf-8?B?bmpSZzBjbVdHRGFjNFRuYXJSSTBkeFgxRHFuRVlJb2RSUGZNanRTckYyNUJo?=
 =?utf-8?B?eE51NEtVQlVDNTZabHJFUStpZGFBc1NsUElyaTJHem1NYmtkUDdrckJxQ090?=
 =?utf-8?B?ZWtIclFCNURKVVVqemU4bFVuNXhsUzRVd254azFxMlByZjNTVlQrS3NMTndZ?=
 =?utf-8?B?YmxYbEY1ZjF5ejVBSmw0RjhGL3hLL3JLckhpcHBvOWdPTTh1Ulk4OUhhb3ha?=
 =?utf-8?B?YUtsenVZeGpOT2doYTVxc3F2eGpzb2IzTERoL0UzNkxGTjFOM1Jkdjl5dHhj?=
 =?utf-8?B?YjJENlAvWGZaenp3N0prblk3NXdCQU4rekxwbE5aZFF4MEllOUN6VEorNmpl?=
 =?utf-8?B?MHFkNlVaNHRJZi9kdTVhaVUxdEx5ZHZTaXlqWnFEeVlLQUNkL3FiS3RJSVQ1?=
 =?utf-8?B?QkdaZHJUTDhSTWNQZ2RhQW9peHVscjhDclRMTmtXaFhVRU5yZkpiZzBHRWdt?=
 =?utf-8?B?RWF6SGtpSTQyb0hmTk1uNXhPeE5heVYycWozZjdFS2kvMDF6cGoyMTRYN1gv?=
 =?utf-8?B?QlFrb1lpQnlLTnNZVWFPbWZKRkR6eDdqY1Bib1N6MUNIMVJrREFlMDVzY3VI?=
 =?utf-8?B?Y2tvSlp3UW5XR2MrY2JKVnI3eDExd2tYL0t2WUs3S0t4MEN4WWRYbWplelhq?=
 =?utf-8?B?b0t2WnFxQXBBOFB3RnRVTmI1Ui9Pd3BmcDZxeldzMzAwRGtXOXVRZ1VHNDJa?=
 =?utf-8?B?UFd2dCtjUE8yOEp4OGUwbjZtQ3IrRmhzT1VXKzhPT2RyZVhON1g5Mjk3U0ww?=
 =?utf-8?B?T2VqaEEvUXNHM3RRMFlyQld0Sk40TjJpZWtCYjlGL1c3RHhhcis5RDQyaHpm?=
 =?utf-8?B?OThtcUY4NUZyNEM2NVpUeGFMRjduMlQzVFV0TTdxaTQrQnpyOHFNU3p1KzVR?=
 =?utf-8?B?dlNwVks0NUVneDVYNGJwdC9KRjNrNlVsK29aUE9yMHRSRDZ4cWYzNHAxWU5D?=
 =?utf-8?B?SEgzbXlYMjNSbmV3TlRHUjdocExCMG1pWHorYkttWlQ3OEdjYWpxNWV5eDRM?=
 =?utf-8?B?TWZoUmpDR3E3TG9XV3RzbmZlV2syUUpsU2tIOGZYMkJnVE1DMjBEUnhxSTNC?=
 =?utf-8?B?clRRT1MvU3FZZmlLTytFNjg5ZytUa2hFVUlDa3RQODZGTUNkY0xlNms3c0d1?=
 =?utf-8?B?UGFndnFtcU96NzZ2Ri9NUTQ4SDVWVHMxZnl3Y0FuTkpVQ0VEVDhqQWtnTlND?=
 =?utf-8?B?UEhzSmNVMVdMZ1pPWGZ5UUFsemJhVms0R1FMQ25WUmZCMjFjQTY2REo0dVBz?=
 =?utf-8?B?V3BCNkM3NHdqblN6azhGQ0RGSGRRNmkzQ1NuQTJnWERmLzdqQ2YzdnI3Vkdz?=
 =?utf-8?B?VnF4b2VmMC9ab1pzNVpJZzRxNGlmemdSSVZFS3NZM0NqelBjQmQvNnlvUlpP?=
 =?utf-8?B?TkllbDM4MnhFd3lQQ3NyYzBGNk5nVkhTSmp6OW1TYjQ4VDFMZEZWcGlGZG1a?=
 =?utf-8?Q?15Rg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2c0T1ZkM0FvZUlNR0dzQjgvaHVkaU40b3UvTnpBcW4rbXp0VVZjSkxES2lI?=
 =?utf-8?B?S0VMVGZSY3EwV3NGZHhFYi95V2d1ejBBTVhpanhwYW45S2lLeUpiN1M1dXB3?=
 =?utf-8?B?S1Q3WExSWkpBajFQcTRGTnJKek1sU0crRE5PdVpSd04xL3pPSzQ5VHlBSStz?=
 =?utf-8?B?RktHRU80MFdYTTUwNEZTVURnRGk1VllFdS90WmhWMTN4OC9xSVFlYXl6UE8x?=
 =?utf-8?B?Uk9mMVMwK1g2b0g5VTM3Lzcra3ZPaVFqb0NJcVRwd3dMcWZvbGx5TFhpcEdM?=
 =?utf-8?B?djdyL1pBREd4WnU2MWY3bHNNb2ZjZWQxQUE0TVlBazVrTk85ZXhPUHA2RVBy?=
 =?utf-8?B?NGNST2J6Tk52ckp1TUY5NkVqRnpOQmk4L3lTc0NKSVR6SmQ4T21uOGJiRW9U?=
 =?utf-8?B?UWlJdnJ5aThpWkc3WmFGWHRSZ3pXcVJZTkk4VTNqRUtyb0IybmRZc2lyclh6?=
 =?utf-8?B?RElmWlZDTnU0ejB6R3ZyYWtCNFNUdUhIZDZucWFjamZRRStnQmd2d1YvQUhF?=
 =?utf-8?B?b2VicnhVSUNycmtoWkVWUE5iS3JEZkNGQndQcGxXbk96TVAxYituQWZsdEox?=
 =?utf-8?B?QUh4RkNSVGlJQ01YQkhyaENva3NDTEhmWG5Vakx6R0tZYW9TeFd1byt5STJl?=
 =?utf-8?B?bGtaa3licEY5T29NOWZsMTRNK241TFRWbmh2c3FSVE1QNE5QYUxITmkwVzln?=
 =?utf-8?B?V2JWMWhpU3FWU1Q1LzBrdXdhNkJpU0g2U3lMRkVPVEJ4M0g0aStUVVR0TUw4?=
 =?utf-8?B?WWdoalJxZmJiK2ZoTVF0ZXJmU0xjWjNIZlVMbldJSEF6SmsySHAwQUpJcHpw?=
 =?utf-8?B?STdidzVWTmowaHBTejFQS1BuUjU1b045WkljdU15azJrVXN3bXdXd3FZMlpk?=
 =?utf-8?B?a0FXdngzUFJzYXFDNndyZXVDb1ZRYUphaTJ5ZGZtSzVNeUExb0MyTVF5eXhQ?=
 =?utf-8?B?L05ldXZHM2ZybWQ2RXdOTk90SGVJQldpd1daZFpXcFd0TVRPMGtWWGVaM1Bw?=
 =?utf-8?B?eTdyN0tyZ0NQUTY1L1hid05PcDJvSkxxTDZobExaaWErN2FxUm1PcmJkQ3JC?=
 =?utf-8?B?QWcxeGdFdTQrQ29BR296TWZ0V0U2WjlFa2Y2czFiM0d6NWNra3lxajlkcDlq?=
 =?utf-8?B?aHhMdytkOFFvZEF1WThtVXYyRHErSGRxeGwrNlR5dmxwSHhxTWZ6Sm43blFp?=
 =?utf-8?B?NmRQL24zZjhqZXV0Y3c3RkRFT1dqK0ZXM3dxVitTTFBCL0FHU2lVeEEzZVpT?=
 =?utf-8?B?TGNBSHpLcTNkcEt4amZiV3BMTUN6NkFtZStkVXV2eUpTcVp5UnlhTWVRNlRh?=
 =?utf-8?B?c3BhSkFKKzlCZE5ialhDRXpMSEV5eE5UL3AxVm81c3o5YXRUdXV5UW1Va3d4?=
 =?utf-8?B?dkdqcXNRTnFBUjYrWHYxUURnL3c5K0Q1R0pWYis1NEd0RWJTUnpCcksrTGh4?=
 =?utf-8?B?OCtiaG5NT3BhRFdNTkRZbTVycHdqUU1Cd1huTkdZR1d6QVlreHVwZ1FIK1c4?=
 =?utf-8?B?RHdTd283YzVDZC8xZUs2cTFxZzJrVGhqSkhxOUtKUDYvdSs1UFBJbDF1TW5i?=
 =?utf-8?B?MndiM2hHT3c0bXRDQ1I3QW5XUVBMYngzV1pQV2pGbVBkZXdsWXloSVdXS0xx?=
 =?utf-8?B?MGdNS2Z3anBONHdlK2pyZXlscWtBY05HNHNzSTF1VUZ3d3VxemFSelVML290?=
 =?utf-8?B?TVpoYS9mNUxQNGk0Qi9JQ0pzOFI4TlpjbnFSTHRaR3JsVS9jcDlVdTRNanpo?=
 =?utf-8?B?SEoyOVRJTlgwSnByNDNnRzBNb0doVGg0cGhodUxGenlwVkdvaEhaR0xhVHVO?=
 =?utf-8?B?Q3FjeU1rL20rYTRzM3FvV21GWlczWjhRWVcvSnY2ZXRESEZ2cFZEcUVERjVi?=
 =?utf-8?B?OVQzWkNkMzRxVmdNRVVHR1Z5dExkRGp5NUprUEJHWmVHcXQwZGtVSUx4TFpU?=
 =?utf-8?B?SjVaakJhK0pQVHdBMmRtaklJOXpITDRzcUlFbUlBRjFDMEV2SXVSamF5eGFr?=
 =?utf-8?B?QThhc0tGWVRpaDlDTHlPMW5Hb2ZUc0pGRVo2UHpIVEZTYVJWWnk3UGdpRUtF?=
 =?utf-8?B?YXFBUEZnM2hCL0QrK2FsejlleHpmak5tVXlYM1gxYllBSHBaTzFsckVpOENr?=
 =?utf-8?Q?TVaDbSQ4e/9YDmAOb8ObT2uj8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8251e4-40a0-45a8-de69-08de205e2cdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 13:36:38.4622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1+x6TXlc/fJ85PPmrCcqmX7a+Igwwsmzqs8jEvW9kqwfGZWFB5CXgD7xcOB+OJF/cd0N2KrX8yA+NEHgnOQqdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5278
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBCaXJnZXIgS29i
bGl0eg0KPiBTZW50OiAxNiBPY3RvYmVyIDIwMjUgMjI6MTgNCj4gVG86IE5ndXllbiwgQW50aG9u
eSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IEtpdHN6ZWwsIFByemVteXNsYXcgPHBy
emVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+OyBBbmRyZXcgTHVubiA8YW5kcmV3K25ldGRldkBs
dW5uLmNoPjsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1h
emV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9y
Zz47IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT4NCj4gQ2M6IGludGVsLXdpcmVkLWxh
bkBsaXN0cy5vc3Vvc2wub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBCaXJnZXIgS29ibGl0eiA8bWFpbEBiaXJnZXIta29ibGl0ei5kZT47
IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD47IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdl
bi5tcGcuZGU+OyBMb2t0aW9ub3YsIEFsZWtzYW5kciA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRl
bC5jb20+DQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBuZXQtbmV4dCB2NF0g
aXhnYmU6IEFkZCAxMEctQlggc3VwcG9ydA0KPg0KPiBBZGQgc3VwcG9ydCBmb3IgMTBHLUJYIG1v
ZHVsZXMsIGkuZS4gMTBHQml0IEV0aGVybmV0IG92ZXIgYSBzaW5nbGUgc3RyYW5kIFNpbmdsZS1N
b2RlIGZpYmVyLg0KPiBUaGUgaW5pdGlhbGl6YXRpb24gb2YgYSAxMEctQlggU0ZQKyBpcyB0aGUg
c2FtZSBhcyBmb3IgYSAxMEcgU1gvTFggbW9kdWxlLCBhbmQgaXMgaWRlbnRpZmllZCBhY2NvcmRp
bmcgdG8gU0ZGLTg0NzIgdGFibGUgNS0zLCBmb290bm90ZSAzIGJ5IHRoZSAxMEcgRXRoZXJuZXQg
Q29tcGxpYW5jZSBDb2RlcyBmaWVsZCBiZWluZyBlbXB0eSwgdGhlIE5vbWluYWwgQml0IFJhdGUg
YmVpbmcgY29tcGF0aWJsZSB3aXRoIDEyLjVHQml0LCBhbmQgdGhlIG1vZHVsZSBiZWluZyBhIGZp
YmVyIG1vZHVsZSB3aXRoIGEgU2luZ2xlIE1vZGUgZmliZXIgbGluayBsZW5ndGguDQo+DQo+IFRo
aXMgd2FzIHRlc3RlZCB1c2luZyBhIExpZ2h0cm9uIFdTUFhHLUhTM0xDLUlFQSAxMjcwLzEzMzBu
bSAxMGttDQo+IHRyYW5zY2VpdmVyOg0KPiAkIHN1ZG8gZXRodG9vbCAtbSBlbnAxczBmMQ0KPiAg
IElkZW50aWZpZXIgICAgICAgICAgICAgICAgICAgICAgICAgIDogMHgwMyAoU0ZQKQ0KPiAgIEV4
dGVuZGVkIGlkZW50aWZpZXIgICAgICAgICAgICAgICAgIDogMHgwNCAoR0JJQy9TRlAgZGVmaW5l
ZCBieSAyLXdpcmUgaW50ZXJmYWNlIElEKQ0KPiAgIENvbm5lY3RvciAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDogMHgwNyAoTEMpDQo+ICAgVHJhbnNjZWl2ZXIgY29kZXMgICAgICAgICAgICAg
ICAgICAgOiAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMA0KPiAg
IEVuY29kaW5nICAgICAgICAgICAgICAgICAgICAgICAgICAgIDogMHgwMSAoOEIvMTBCKQ0KPiAg
IEJSIE5vbWluYWwgICAgICAgICAgICAgICAgICAgICAgICAgIDogMTAzMDBNQmQNCj4gICBSYXRl
IGlkZW50aWZpZXIgICAgICAgICAgICAgICAgICAgICA6IDB4MDAgKHVuc3BlY2lmaWVkKQ0KPiAg
IExlbmd0aCAoU01GKSAgICAgICAgICAgICAgICAgICAgICAgIDogMTBrbQ0KPiAgIExlbmd0aCAo
T00yKSAgICAgICAgICAgICAgICAgICAgICAgIDogMG0NCj4gICBMZW5ndGggKE9NMSkgICAgICAg
ICAgICAgICAgICAgICAgICA6IDBtDQo+ICAgTGVuZ3RoIChDb3BwZXIgb3IgQWN0aXZlIGNhYmxl
KSAgICAgOiAwbQ0KPiAgIExlbmd0aCAoT00zKSAgICAgICAgICAgICAgICAgICAgICAgIDogMG0N
Cj4gICBMYXNlciB3YXZlbGVuZ3RoICAgICAgICAgICAgICAgICAgICA6IDEzMzBubQ0KPiAgIFZl
bmRvciBuYW1lICAgICAgICAgICAgICAgICAgICAgICAgIDogTGlnaHRyb24gSW5jLg0KPiAgIFZl
bmRvciBPVUkgICAgICAgICAgICAgICAgICAgICAgICAgIDogMDA6MTM6YzUNCj4gICBWZW5kb3Ig
UE4gICAgICAgICAgICAgICAgICAgICAgICAgICA6IFdTUFhHLUhTM0xDLUlFQQ0KPiAgIFZlbmRv
ciByZXYgICAgICAgICAgICAgICAgICAgICAgICAgIDogMDAwMA0KPiAgIE9wdGlvbiB2YWx1ZXMg
ICAgICAgICAgICAgICAgICAgICAgIDogMHgwMCAweDFhDQo+ICAgT3B0aW9uICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgOiBUWF9ESVNBQkxFIGltcGxlbWVudGVkDQo+ICAgQlIgbWFyZ2lu
IG1heCAgICAgICAgICAgICAgICAgICAgICAgOiAwJQ0KPiAgIEJSIG1hcmdpbiBtaW4gICAgICAg
ICAgICAgICAgICAgICAgIDogMCUNCj4gICBWZW5kb3IgU04gICAgICAgICAgICAgICAgICAgICAg
ICAgICA6IFMxNDIyMjg2MTcNCj4gICBEYXRlIGNvZGUgICAgICAgICAgICAgICAgICAgICAgICAg
ICA6IDE0MDYxMQ0KPiAgIE9wdGljYWwgZGlhZ25vc3RpY3Mgc3VwcG9ydCAgICAgICAgIDogWWVz
DQoNCj4gU2lnbmVkLW9mZi1ieTogQmlyZ2VyIEtvYmxpdHogPG1haWxAYmlyZ2VyLWtvYmxpdHou
ZGU+DQo+IFJldmlld2VkLWJ5OiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+IFJldmll
d2VkLWJ5OiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPg0KPiBSZXZpZXdlZC1i
eTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo+
IC0tLQ0KPiBDaGFuZ2VzIGluIHY0Og0KPiAgQWRkZWQgIlJldmlld2VkLWJ5cyIuDQo+ICBTbGln
aHQgcmV3b3JkaW5nIG9mIGNvbW1pdCBtZXNzYWdlLg0KPiAtIExpbmsgdG8gdjM6IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL3IvMjAyNTEwMTQtMTBnYngtdjMtMS01MGNkYTg2MjcxOThAYmlyZ2Vy
LWtvYmxpdHouZGUNCj4NCj4gQ2hhbmdlcyBpbiB2MzoNCj4gIEFkZGVkICJSZXZpZXdlZC1ieSIu
IFRoZXJlIGFsc28gd2FzIGEgcG9zc2libGUgbWFpbHNlcnZlciBES0lNIG1pc2NvbmZpZ3VyYXRp
b24NCj4gIHRoYXQgbWF5IGhhdmUgcHJldmVudGVkIHJlY2lwaWVudHMgdG8gcmVjaWV2ZSB0aGUg
cHJldmlvdXMgbWFpbHMNCj4gLSBMaW5rIHRvIHYyOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9y
LzIwMjUxMDE0LTEwZ2J4LXYyLTEtOTgwYzUyNDExMWU3QGJpcmdlci1rb2JsaXR6LmRlDQo+DQo+
IENoYW5nZXMgaW4gdjI6DQo+ICBBbGxvdyBhbHNvIG1vZHVsZXMgd2l0aCBvbmx5IEJ5dGUgMTUg
KDEwMG0gU00gbGluayBsZW5ndGgpIHNldCB0bw0KPiAgYmUgaWRlbnRpZmllZCBhcyBCWA0KPiAt
LS0NCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaXhnYmUvaXhnYmVfODI1OTkuYyAgIHwg
IDcgKysrKw0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9peGdiZS9peGdiZV9ldGh0b29s
LmMgfCAgMiArKw0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9peGdiZS9peGdiZV9waHku
YyAgICAgfCA0MyArKysrKysrKysrKysrKysrKysrKystLS0NCj4gZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaW50ZWwvaXhnYmUvaXhnYmVfcGh5LmggICAgIHwgIDIgKysNCj4gZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvaXhnYmUvaXhnYmVfdHlwZS5oICAgIHwgIDIgKysNCj4gNSBmaWxlcyBjaGFu
Z2VkLCA1MSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpUZXN0ZWQtYnk6IFJpbml0
aGEgUyA8c3gucmluaXRoYUBpbnRlbC5jb20+IChBIENvbnRpbmdlbnQgd29ya2VyIGF0IEludGVs
KQ0KDQo=

