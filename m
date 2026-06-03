Return-Path: <netdev+bounces-294761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hjx6Mmw0IGpNygAAu9opvQ
	(envelope-from <netdev+bounces-294761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:04:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF936385FA
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:04:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=S5dx7nPp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294761-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294761-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 640EA3166311
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 13:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3219C34CFD6;
	Wed,  3 Jun 2026 13:55:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCA535DA75;
	Wed,  3 Jun 2026 13:55:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780494934; cv=fail; b=W/1CbHUuhJvPaIuuP999alUKplr0jOKF3nj/wAOiJE2ni49UIx1B1LZoQ4tGpbahZIQPpa0TtKepYpiY4Uv2caN6yzNq2K9+jyWogLyZcg/x+ezn7UVxP7O95o6sZjsAkeWzy5m4jjN5xkSh+lBDMy5JXheIPryUsF3I5+7klco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780494934; c=relaxed/simple;
	bh=RVrIfXaNcdQdyPdz1RKYEOfSYyiVlRwuSfAcFM0g5ug=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F46L+KQz9MidHYgDbBCHFeHb2ZVNtDy5g5eCAl7FgHpR8sZkm9wtgTzBxSKt9GJMe/69fxPQVwy+Q2upJOaJl2goAPRNnqqBjl5PnH0G4m87zEyPk+RnPYoqU4Oeixm3+iPZP7e2r6JrKGkJMHj6qx84w9y3+EwCtywqRYU+dD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S5dx7nPp; arc=fail smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780494931; x=1812030931;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RVrIfXaNcdQdyPdz1RKYEOfSYyiVlRwuSfAcFM0g5ug=;
  b=S5dx7nPpTr8tiJ/LHvuC/CDI13NsfTw+l+HlFGNY4tfKNdNlRCZUVlaa
   DIK95/FSdT4zawm7bcFOdz+jqUQ2zSr7pPw+yBGLm1Mjjvut//JBo7uIp
   EYT7w/YmSnrwDDu9m+pZix+yW1a0snTiIa1Df76aYCEQuCCNPgZYg6AJS
   xlptI+6Fodi5jaaNmaHZgojxi/xNARJJhZC/ch0jxYpVCu3TGDI8x+SP2
   Cxj+HJ6IoHRJUdsvjdTS97XYwLduYa6of+qg8WC0T2Dm1PD2a1qxYmC84
   5AOINluaJS9mPMVnuqyuWWghyJHbEtn7TflePerMzpG0MPv/WohKhZVnA
   A==;
X-CSE-ConnectionGUID: z1HDp8dxScestw3bLZQ0kw==
X-CSE-MsgGUID: H7iHa4X5RcufCYEdnMSSYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="85158938"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="85158938"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 06:55:30 -0700
X-CSE-ConnectionGUID: Z/PAYNCFTEyBHCeQPewASA==
X-CSE-MsgGUID: Kx9LQ8upRyCSODXV6Ufl8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="282354259"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 06:55:29 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 06:55:27 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 06:55:27 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.16) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 06:55:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xnol5/ppnTvIaH89lDiRo2KS9q8nz8bhtbNJoIk71olzZB/AN9/dt8SVJZQcewKMyQjz38sIlggcmytMPn5R1DSDC6S5dMnFQyeImC8tkonbgjdD1EUCfGf/1zBXei5uHq2zGuCO4S+GnELVguLf0KscE29fbyE7i5EQrfe1B142xKzVSB1HOAz2XP9yQhDeU7K8FykvoFDrweFQ9CQzsyBsbuk9ofpE3j6sWSXN2g7MaMrxj+tLz6lbBtrj7/qG8tJD3Vja2bkKY1J8FaMdZxRREnjXd8BGkyVoHvUX4GWvDN9N8K4frPQTPwtpC1m2UETMVPngdKDI9xkhV3A1bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNmS591waBlbppo119LFYBoab1xki2uqNo5ZfxE4onw=;
 b=AJA3umdhZpTe0PqmMTjh3m6cE9jLgqBkDXzaiASP70xsUC0daxE1xP9bNaSF/6gcQGsuNkotHL438PPbswoJM1o4gMvhPDu2EC7KjqmnXLkodouPj+3sJ4Q1nLqVRaxWRLMo7n7pZWag2VbEQo9PHTZCQOklNyIChdbw+BsXgpra9tYjPTe3mfo12DJLDZWUVufLulraCowRB834P9svCR5fmquBrJkA4oB3bgUODWxPgmHpFMPr1EGjvsGnwvorPJcKPXhvfJP9D/Obf690E3xZJw4Kj9CnRVsjepqcs043+WZafsZKs20Og6DXaqREXXe3GHqtCLHyY8dRFleqig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB4896.namprd11.prod.outlook.com (2603:10b6:a03:2dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 13:55:20 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 13:55:20 +0000
Message-ID: <e80deefc-8467-4ec2-b61e-6cb064802473@intel.com>
Date: Wed, 3 Jun 2026 15:55:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/4] net: mvpp2: fix XDP RX buffer handling
To: Til Kaiser <mail@tk154.de>
CC: Marcin Wojtas <marcin.s.wojtas@gmail.com>, Russell King
	<linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Matteo
 Croce <mcroce@redhat.com>, "Sven Auhagen" <sven.auhagen@voleatech.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260602164635.62517-1-mail@tk154.de>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260602164635.62517-1-mail@tk154.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0290.eurprd07.prod.outlook.com
 (2603:10a6:800:130::18) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB4896:EE_
X-MS-Office365-Filtering-Correlation-Id: e5f5a19f-3d9a-4fc9-3bd0-08dec177c002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: D5vdVflx9yRsvfjVRViR8eRVov4HZ5fMgv18lC7oa3Fpw8+PKWdHJT+eKyctPw/Ck9dDHwIi6pGOHo84VpK3fzBs4lmw4ReW1HuZS96ciwe7aIYW9+gZgTjhOpf9EgmEbUDZDc98ayUvCZreVIOO09M7HWiXyjtIFibsDc8pSfPywYeYr1L/bsgxr6UNa3NokRAT4FtTaa5uWB6HNQIocussKDVtYjJ1PT4giiMy5BtMVDqWi79lahizdwpwz2GXt7NTh3xaSzYvoq2SYVvs4Is8hwhExGiN/EV3O2v9gMVAg8lCSOszJCADblRn9zwqoc8qSXqPkbgipPKn23EALojqPfXYwQte9s2nRBGEWLjDQ4w/LNCa5ELcNPJnIWv9OnYM7ML/PVAACc84R4GrOb6h0hQSmMCysabg0oGbVJd7LNZ0jTySgJ4S9PGM/wLgGYd/L95Cxa11/D4uhACLIih0cSvJL+fEOMC6Tt8G1w9V5E42fjjxRREznFMvfqH2nEHns79ImaUMBQKWfdxhHGvxJ72XJI8V8cMFJ4m9HSXJN+1+gHwZWofIecvHVOxYy76KE8eEcjcmGKDPhSom+u3I+u3Swcs70Z+lr0JLqcbsVNYgEZbStWEm3oLZ5hzgIEe1+SQx7XV5iCRCDnd5wfxLDtIL48h+oc+JmEbo5NcrVb7EAA9m+4REZSlg8NKAdbwWt4DUANLIcPH+qzH9NA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDZJbnZzM0c2UURpK096d0Fxa0hZRHhxZXZ4NlB4aDZzSjVxb3k4VEk0RklZ?=
 =?utf-8?B?ZHlKTnRoaFNtbXU3bjhzcjdIQ243VHE5aVR6UUdDK2swTmQ5dUdiUTBDR1lJ?=
 =?utf-8?B?b2lSdDFrQmpGUWZ4YlZoNHo2R3laSjh0N3F0V0VhbS96Ry9adjB3NlpaSlpP?=
 =?utf-8?B?TmVoZjR1elgwSzhtOWdzT2RLTGJSSWsyWS9RaW9WanZiVkI3L2k4QWRjNlpX?=
 =?utf-8?B?ZXl5T2dMZlUyQTJKeE5HTmwrdmF4ZnBKaWlyK29uK2ZjL3VXZmlTSHFweXFE?=
 =?utf-8?B?UWQ2ajlaQWgzbHh2eG1QclI1VjdPWHlVV3JjSXpKR0w5YlBaUmVUckpla0V5?=
 =?utf-8?B?enF0MjhPUTNYVU9xaVR1Y01KWSt3U0xMTUVlUUpLTFIwdTdxR042NGVFelNT?=
 =?utf-8?B?b3NiN2ZIMFV4NzB6MDVqdk5tN1d1U2d1YU9QaWpicUUxU1hwUlpoemNRNEM0?=
 =?utf-8?B?UVg3dDQrV1BWQ1BSRElGaTV3RmpYUmhSS2ZtSTZxMmlCeVU2T0EyUGJ1MHV2?=
 =?utf-8?B?UXc2bHFrcVB0c2VjNnBLNGZXSUluOG8wU1JoS015TWpMRVFHV0lFQnZFM1hp?=
 =?utf-8?B?RnFiS0RVWmRWRDlJQWlvOXpWTFhva2RpUmJ3TFY2SHcxUkdSQWMybnVrT3FZ?=
 =?utf-8?B?aVA2YzkwRXhOV1UzNXpQN2EvK0tSa2R1MUJldDlwQnJHT3lHUnNxcWJCcVZw?=
 =?utf-8?B?clBlRFlPQSs0aWtMS1JDckZlVk8yL0ZVWGhteDZCRWhMTTlFMEVQbTVEY0xY?=
 =?utf-8?B?ZGFjSEk4VTJzWEp5SnRKaUJyZFZpY1hmTWZ4T2JFQWVtTjJJdFZTSzhrckpk?=
 =?utf-8?B?bTFyOXZPeWhXMThoem82RllCaUFFTWhBRmgzVjg2aE4xRDc3MDBVVU9DdzJq?=
 =?utf-8?B?bHFIZS8vL01sNi9qZk82blBiU2s2a2VQV2NlbVhrRTRmY2hWS0dEMGlVYWFa?=
 =?utf-8?B?WEVmcFhONEpTZzJVUEtGd2pPYVlDSkhjUnFqSENCdjdoWkI2dHJUQXRrUUl2?=
 =?utf-8?B?M3pqdnQzdjlpZ3dua2YyZzgxWE9JWExHVExnRXR1bS9TNEtWdExpVjdZbDJq?=
 =?utf-8?B?VUJ3SElmb1VOZlBhTVZNenZKN2hqWFVFaWFKUmdSa2VmYktkMzhnQnVaL1h6?=
 =?utf-8?B?K2dleGpFNjQ5Vnh1bU05MHg2N3hNM0labUxSOXA0c2lROTE5cGErZnJlNU9Y?=
 =?utf-8?B?NkM3NmpzYWZMa1VHUmFBZkRCWnMxY0p0a0J4Nm53WVhaVnh0cEJ2VWxFc2VX?=
 =?utf-8?B?anRUU0dtUnQzK3lya1F2M2w0Q1RNSFhWYkZIS0Q3VDJKRHpzY24rNUpQRXhu?=
 =?utf-8?B?MzlGZ09YRk1Jc0Z5ZjNDTUd0MXJwQzFmeFM2aHN5d3E0QnYyYjVMcVBTSTcy?=
 =?utf-8?B?QWdOL3I1OFNCUmVQZmM3SlFacndQeWxnZmc2aXFvSHI1cHFmdkFZKzkxL0RU?=
 =?utf-8?B?Um5uOTlxTVo0blpQZHVWK251akw5T1M1R084VXI2Y05BZ1M3RGUvSTdGVUVT?=
 =?utf-8?B?QkhMR2tYcFBlc3JtNVdIL0VSUmxWSFBtbmViUzBHR1BLRmJrV3NkZ0xRMElD?=
 =?utf-8?B?MlUzdDdxRXJ5ZmU3bTlDNEhhMktXSHpKdEcwcmp4UDY3dmdBNzg0aytyUmNj?=
 =?utf-8?B?V01GVG9XeVpObHBVYVFVY204bUVjdWNlK053b1ZJZzYvOHpLZVR3Tm9qenQz?=
 =?utf-8?B?MEpDNnVuTlV6TjNGMEpOdGdUelJ3c1FabEdTTHF6YS9TSlZrZ0ZCZ2JvSHQz?=
 =?utf-8?B?Uk1YTENrSlJIeVF2UUNsTlpsY3RkZW84ZzZQVGxNV0h6UllRN2VDUU5EM2dP?=
 =?utf-8?B?OVJFNDRCNTFLc3IybkJrNUFBbmFDS1k5QXFwK2cxL1lvMCtpZGxRaUVRbTlY?=
 =?utf-8?B?WUR0RWVCVEcrU2ZyV2dHWFIrMThUWUFyK2dKTm8zbnJyQXJlSzRyRWhwN0Vp?=
 =?utf-8?B?emFvcHdaWllVZTBZQVB2RjVWaVFzYnJ6dS9pQWJSUTNWQnFLZlB6V3M3aEVK?=
 =?utf-8?B?TzVadkE2bkN5TU1zTzROdzA5QlhXNXFOd3REMytsVVNleVBXZ3FUWmtoRkRH?=
 =?utf-8?B?WlhoMkp2amFPM2YwNnVIU21GMjJRdE94SFhXaDh0bTE0Z1UvTDd5cisrbEJi?=
 =?utf-8?B?UlRpS05zcTRlUHo5TkVhNHd2c3FZMnNhY1dHRDlJYjV5V2ZCd1QyRUtWU0Ur?=
 =?utf-8?B?aVVSMjkwZUVpNkl1aTVKWnQzalNzU1VIMVo0cnNuTURQdW1hOFNhaGhOZHBz?=
 =?utf-8?B?TGNBNk5LMjNSaU1JdGY4OUJJajhmOWFlYTBJNWpyNFNLZzYzV3E0RnpIZmh4?=
 =?utf-8?B?T3Qrd0diR092QTZocEVVRDY1L1JodjF3M3VHUU5VODNaZ1JtR3YrRHlDaFdV?=
 =?utf-8?Q?5ysLblOGR4pghxN0=3D?=
X-Exchange-RoutingPolicyChecked: BoU1X9U4ogg406DVfUDW1R+F9Y065yWl63s3nhppUOz9roWULefiH4oxITKuc/GxmZespkxswFi27L9vzfmg4YqqUKpX8nunHEnXeuZVZ+rpU1uQXo6UJkD0hl8cVnnZCqK6WCywKToeOBZfBUBVG7acxQqu1BiueHXXUJaX/xUfihD2nj04w06bPl10lX8RAYY2dzwjWWWJrjR6u43+KglWMMYafC58TVzdeSuZFP7aiQBqVBREZ8C1MwOZdsa8Rr3cNwyGn7DJyY8Gs0QzX14yjVvGz5sOMFDRlkwgYqy0QJfldMOQ0F/qVBEGDw6uQkPoy3agRkFZrGTPCMr45Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f5a19f-3d9a-4fc9-3bd0-08dec177c002
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 13:55:20.3446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23vIOY3R2yfzv9TNMShMePrRomgkl04VHmq4ztSZH6QSDPsMCzkApU7mLmIWTFVf957wPqubspY/BGX1MYlmEbiCxzFfRKVnUaRg51bCgbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4896
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294761-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tk154.de:email,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:mail@tk154.de,m:marcin.s.wojtas@gmail.com,m:linux@armlinux.org.uk,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:mcroce@redhat.com,m:sven.auhagen@voleatech.de,m:lorenzo@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marcinswojtas@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,fomichev.me,voleatech.de,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3EF936385FA

From: Til Kaiser <mail@tk154.de>
Date: Tue,  2 Jun 2026 18:46:31 +0200

> This is v2 of the earlier XDP_PASS fix. The XDP_PASS change is retained,
> and the series now also fixes related RX/XDP buffer handling issues found
> during review.
> 
> ---
> v1: https://lore.kernel.org/all/20260524122334.1730451-1-mail@tk154.de/
> 
> Changes in v2:
> - Fixed RX DMA sync range to account for RX headroom.
> - Limited XDP frame size to the actual RX buffer size.
> - Fixed refill error paths so retired buffers are not returned to BM.
> 
> Til Kaiser (4):
>   net: mvpp2: sync RX data at the hardware packet offset
>   net: mvpp2: limit XDP frame size to the RX buffer
>   net: mvpp2: do not return retired RX buffers to BM
>   net: mvpp2: build skb from XDP-adjusted data on XDP_PASS
> 
>  .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 38 ++++++++++++-------
>  1 file changed, 25 insertions(+), 13 deletions(-)

Series:

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek

