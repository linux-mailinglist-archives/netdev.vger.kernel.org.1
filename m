Return-Path: <netdev+bounces-281915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MODGl/V8GkSZQEAu9opvQ
	(envelope-from <netdev+bounces-281915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:42:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 499AF4881DA
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6D68328CB70
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98A7348463;
	Tue, 28 Apr 2026 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KXuMyqOE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C405175A72;
	Tue, 28 Apr 2026 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777385804; cv=fail; b=bPjaxQGtkByKiNS/nrAU1ZXR/V4pwIPlOOfxig4bPs53bj+FLnBedE05o/2X71w5V5XlUMiiS/GJdZ0ajYYB3Zz+5EnnJMFJwE2rrYC7HkUOM8bNWfTpfj4yH7KE4OpelT/CfXYZJqArgytCR8OOTT/pkYxFuDfPDA2MSZfLPr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777385804; c=relaxed/simple;
	bh=6yl6MSaZJuYhuArXC2NZp780T1Up/SpbXZ37zKn24mQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YVpdety39VJB2WJIA6sCDGdLONHIkUMxAvf6Z0KA+k8cwBgXKDaShmgNKGvFgSl1HPvfQXpl3GtaG+7DIfqpsHQCieSf6HjNfw3uk/nD6+1wWk1TEIqNdm3MZuly7DXeQ9v6pgz4XCN4J4WSuSgv6a/X1s/h0/qNe2/pjtb0k8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KXuMyqOE; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777385802; x=1808921802;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6yl6MSaZJuYhuArXC2NZp780T1Up/SpbXZ37zKn24mQ=;
  b=KXuMyqOEAYNne47WRG5cZNLrkBX2hw64vbjXMuHELqD8XJIn5VuSivys
   GoEqXqrbZ2kCklDpxnp1Ny/bRt2XFmsOp1jBgCitZlPbfV2d7LE0ba1mn
   fCmqnQkLRjQxMs7yri1IJLhC+d7akaUeIuWndM+LxEPq16c196m5Ml+V+
   wJXxdQ+/wGQw426avYx+XLsIhWf+RHEeHbWPjEGzuUhJmzYqmpAfw1lK0
   Z5T1lL72ViFzFjyzVwVVcLwaEqdGPKa7c8arq9WYrM9KRz2k3ci3Zy7aG
   3pRR4TBgni+CzN49Csz2NxFI+R6CDXHDX1OOlVZ+CFhODcYS46lJXHI/0
   Q==;
X-CSE-ConnectionGUID: YSQD/o02QVeeZYD/ZhFnlA==
X-CSE-MsgGUID: rgRXNS3DRNmOEbVbbhvOug==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="88993442"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="88993442"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 07:16:39 -0700
X-CSE-ConnectionGUID: 8Nr10qG2TOOR1d0hQnna5Q==
X-CSE-MsgGUID: lnDN0y+aTS2yYfsnLOTnqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="232946095"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 07:16:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 07:16:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 07:16:38 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.48) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 07:16:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIeTLnKDOEjDMmCKlyWmMkqpb8k/UkLJTicltwJEF+iQZZbiFAI2IEmQLTUvZ9oYyKJp/pQwUJJX8WAVUWrtJJzL1R77HDBqoqGDxapbQRi/n/qAr4JX6ohW040cz23e02FVU3ZylzadwpD/5d4Ce3BQtLaveHU3Oq6omIVtnfAQAt3P1PuWVNk95ld1KH6Iq3ecfokXuwHSQ5Bdl+EUr/e2Ztl/3F4Hw5R/S3KrGOEjVWht5WEkyce7xpUa1510Dm8uvPk+IZOPlBiNnJ3NckfKUj24WTEJLwo/DS6QqLpZQ0COZ3+SQVPoDW0ReO8Krc4Vu/3H6DSvEZeMzrbNMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbC/1kj9wLaj+H5oyAkyNTxLmIaPImh1ngF4/SND7O8=;
 b=PeFGS15I2BQLqbWtJnN0Zihq1P5mbbECs3aJw1jI3oFBSFr842M/+CR4t5wgAMNuZSlBxRU3M1bCrE4YSDI4rVK/E4Hz9OYhEdeHlHlN2dM8DevA+Ej5OHUmN9jFAejEfY/s0WtpoNsmuF9WEfr6NRwBhSN/GVtFwgAANtpWsZCSlf8HZ8yVMwKF6cNr0yPu4a9kaygaehFG3LTa6O5cKxSH65xT8wm+MDhuwonzFd/Q46XLtoMzJfvQix7nSBB+lBZX3qrGov9QT1QIB0jRrWKpT4SHe8ToO1BKrlPxCPMFKuSMYMeUBJpAp6wUu1DW7dwkJ6hFhT2ReleHBxpDKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH0PR11MB9775.namprd11.prod.outlook.com (2603:10b6:510:397::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Tue, 28 Apr
 2026 14:16:35 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::1289:ce98:2865:68db]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::1289:ce98:2865:68db%2]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 14:16:34 +0000
Date: Tue, 28 Apr 2026 16:16:22 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Hay, Joshua A" <joshua.a.hay@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Shanmugam, Jayaprakash"
	<jayaprakash.shanmugam@intel.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Richard Cochran
	<richardcochran@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Salin,
 Samuel" <samuel.salin@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v7 07/14] idpf: refactor idpf
 to use libie_pci APIs
Message-ID: <afDBNrBwVI5ZmDmp@soc-5CG4396X81.clients.intel.com>
References: <20260428082654.44364-1-larysa.zaremba@intel.com>
 <20260428082654.44364-8-larysa.zaremba@intel.com>
 <IA3PR11MB89866811B05E0CF99A6BA98CE5372@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA3PR11MB89866811B05E0CF99A6BA98CE5372@IA3PR11MB8986.namprd11.prod.outlook.com>
X-ClientProxiedBy: VI1P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::23) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH0PR11MB9775:EE_
X-MS-Office365-Filtering-Correlation-Id: 586bb2b1-789d-4fa0-9aba-08dea530c08b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: qxUKWcfhQSYaR4+GLCgsQkdpDfZ1uBZycQyEpllwlYwl60CFpuxshhAcup5tzrKSb17isSYAMC1xKEtPFI23+G68XS0t+Q6kjZNFRCWt0bTgHfsVAm98M3sSNbnXm9+KWHx3ZhYDyiU+VJd7zAn3Deb2deYs34A8Q4XXLbU8y29vAmSXZzeAI45pgoy/BuTVUI+rwlPQcZCECaL6LX04yD75k8Ilzp9cKE/JSwzOgXdlU7Gw4ZaSfiqypdQnhJxGgWn+3yYDNi+FOKof7goKWrtvMVWUHJxwhhyJafca40p0IhMEM4D1uOK3IA1BQZT6l+QrL3zXIRIrmYQEKxUlK58j+39UdC3dxvZP23EhLRbvGTJDzX3djumFsLmsNx3L5c67hslyEHjARV2VUaZrl5ic/VrJ1r6L+Ut9C5nJ6alsKDIugp+iaS2Q67dsC0m6iVhRKzesZrJdo0QK2Ra+4hNQOeVy2z+Q3rnQaDaIdIF4WNEuZeYFb8NyRHKoWGlBsPSfxxAy7U8ycmsSNrF/Ap+rOl5onTl8KjaN4GcLAIIAXVo+2Buojt1cXz63W6vT6H7bRuTkQQnnTb1dR/4+JiP3W9a2PGDFn4BNV4CoOtvnjcI4TMSHgnRlVTmY5jISPKX44IPgZx5j1GRHquHwrvJC4T+OQj4ti1WT5T7RH2/gYmfML+sD9okbcpDOxeJ0bju8f6vHdljbTXsl49n2xXzUHUF4N90ZN6wAvhmoJf8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C0iU7dsGomqCXOpttMFlZ6vUw9P2LjOIfau6n+JO74ENbNXaH1XamgiipQzJ?=
 =?us-ascii?Q?Ib+wzwooHknAooUENpRkx4ZCowFvXl8VKDjoHlsSvHX1Y/MRlE88wkAI0h2C?=
 =?us-ascii?Q?RILio1GQ93i7SRLaJW5OuVKMhKB5PBfL8wU4CjkySlFGTbvfVqoNzPh8yZor?=
 =?us-ascii?Q?R/w0pZWNwS0yEggKtECHjYgk/4wFe/+QUePejpFIp16OdXu+bUB3pMyGo4R3?=
 =?us-ascii?Q?kTzUsKH/l+ewgTWkn98x+HfxShbjFw95IoUFh1VY5B4aMHHCTDIph5YQrzsj?=
 =?us-ascii?Q?3RCMFzXk/6MtmIU8zMhVdQIlbZphTDnXSL314Ekk/osqnlD68USx2N3M9tgl?=
 =?us-ascii?Q?HzRm1Kz/2ZJen+HeHYJ69KCNGfA8si3cRavsk6texCzcplGQLSI/1s0cEPeu?=
 =?us-ascii?Q?GrSm24Qt86NBnHSI+RUXq+1HMSkc5X3JUkWILQSh0NPEA6gZstENrQsgzaCq?=
 =?us-ascii?Q?a/rbaPzFXlKCZgLDYqZpJbCJbPNq93iGZ8QotrXGj+HVTc+cNF1dLgvCjAca?=
 =?us-ascii?Q?k39OFq1VxypYtrHziO4oTlJR+8D+/7uapoQcTDpsS2jGdE4JNQ0/Ytoxx3i1?=
 =?us-ascii?Q?+K0BFwEjq7plnIVOPxiSAAe/1s9R+AqVrsP5pMuaeaZ6LCKvmT6yFblTlbKB?=
 =?us-ascii?Q?V0KWCvLaD/LdOCuHC1Yvcea1Me6Hoc/H2RwrODlDnq8+0vFEDTGg6USGJlWJ?=
 =?us-ascii?Q?ZVfAe8EhYcsdd5Koe44p1RyOvhPZbSwKRjFy7Dr2kHcMfSev41+7b8ntzTPF?=
 =?us-ascii?Q?GyW9sTeYtADhOXnkLAhVfUYS+dPaatmtKFHPt4HkxBcZSJL4/DEaF4zsbzRn?=
 =?us-ascii?Q?+weJJec7PD272dIeXoa2Ako5MPyUolHD8r7xsTR/11imHTG2T39zR/DKvwUO?=
 =?us-ascii?Q?XkVhxNQfNeBp4UBNCO+l9qBKDD+2u1P6UXLx0H1fQ26e+nsJFq8373fKpTDI?=
 =?us-ascii?Q?hKsWzDbpcZ4qgb7MJudrok/gjG0Qj/1dZIt7i5YexOmRYcQQ2Qd0Z5EtHKSB?=
 =?us-ascii?Q?YYrKA3e85tWlgDnVVur1sQNV+k/6tBlEcpcf5Vc1BGy8EuO7SEbixScfr4ce?=
 =?us-ascii?Q?9rJm9iLTOvCD6TKr6ygeD/NjUEC+HLvZabEjBAh+7oN/Ryx/ULO10fqVnXMI?=
 =?us-ascii?Q?JGFPGoFQbHmKZbaB59/z0L/VN4maxDs/MyzBehM0zstv23Wjm8qbFrLeFsqE?=
 =?us-ascii?Q?vDYUl3mwzatISctVIOy9lK42VVNVxkYkBj25uAyp9ziRsjEFnLqxBbEiaVxy?=
 =?us-ascii?Q?1YacNd9/UPN1JyH+9k1IWbiakjn2JlOzONpU1VyGySC/tyGu1bAKWb1JhYH+?=
 =?us-ascii?Q?o+0fE71usWpb2i50+jv9wLR+POvfKTkaTLbS95FojsDFaKTliR6ph1BfoA3O?=
 =?us-ascii?Q?d51nrBUEsfW9hRBsiDF5WG/GB65UVA/lM1WhaUoz6Fw4CxLXtk1lQyr20B04?=
 =?us-ascii?Q?153faUSv7X3lWC0klF1Q00pD8Gng1LRoB58JuLFg717uCzmjShO22O72wR4s?=
 =?us-ascii?Q?74zzDJBxjlA6JUPEZR4MfeRWwikKOC7Qd6R8id1zr4K0YB3PgIRi8o5EpFMe?=
 =?us-ascii?Q?SwdWdEzB0szya0irZ9KacObR0yW2lLgvnaD/68hZKEYpb/pfWAr8iLmQ5IfA?=
 =?us-ascii?Q?ey9zGxz2+dmt0zwrVMnNPx7o7tK20RFsrhzjmqxXsa7WexiYh1rbOWqqO7tv?=
 =?us-ascii?Q?Euebc7Le9P5YuKVCVAEQpMApzpT4F9o3aPMekko7f29Tzn7jP/iTMXQQiRWb?=
 =?us-ascii?Q?9VazPLQ6ZuBMUDBARRLPhCjnsdAl1UBZmpFS88Gvd7J6CPfyTqihrq6I5mVK?=
X-MS-Exchange-AntiSpam-MessageData-1: d0Cy5rUp4XZWd65zZ7yyfoYsEtXSO2k0L6Q=
X-Exchange-RoutingPolicyChecked: mMFnj7BEtF+RwsAFnBGdFAthzALowmnO2f6V/j9XNYFYz6dOIuAvEExyiNBPQ+Jbvk55YGYSdwF9e4DMJsG6ZDvXPusTqJTdePEJdje0FFJNiUV9qZJHGahOvvIpinW3mQyie/oRA1TJOoh/mIjmy9KDkZx2Mya/Ou5IC9qUDjaYq5rE9CMO45UdLMbKvy4vWXu0FHFkuZESACbdFg8dPNdli79dduMpImGtGrETsZz28948s7xLuxFN+8Kk/4z7N3qM5cm4HBVYV/NuuvMcbwcclUlcT0UWor8Pj7rv3PDjYoBq2bI1wuyUdE+er0atF/xz87HTLpgUgmYFAAj5jQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 586bb2b1-789d-4fa0-9aba-08dea530c08b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 14:16:34.8010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHgRrsjID6Ftu5E0c8J0LprJWmjCcXyiibN/LAhs4swZRRh+jixSWGt191z1bomOgFIP5WmF19ywdkdMRgOOBzw31+RccUy1nuLLJDikGsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9775
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 499AF4881DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.osuosl.org,intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-281915-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]

On Tue, Apr 28, 2026 at 11:00:22AM +0200, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Larysa Zaremba
> > Sent: Tuesday, April 28, 2026 10:27 AM
> > To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>
> > Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Samudrala,
> > Sridhar <sridhar.samudrala@intel.com>; Michal Swiatkowski
> > <michal.swiatkowski@linux.intel.com>; Zaremba, Larysa
> > <larysa.zaremba@intel.com>; Fijalkowski, Maciej
> > <maciej.fijalkowski@intel.com>; Tantilov, Emil S
> > <emil.s.tantilov@intel.com>; Chittim, Madhu <madhu.chittim@intel.com>;
> > Hay, Joshua A <joshua.a.hay@intel.com>; Keller, Jacob E
> > <jacob.e.keller@intel.com>; Shanmugam, Jayaprakash
> > <jayaprakash.shanmugam@intel.com>; Jiri Pirko <jiri@resnulli.us>;
> > David S. Miller <davem@davemloft.net>; Eric Dumazet
> > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan Corbet
> > <corbet@lwn.net>; Richard Cochran <richardcochran@gmail.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> > <andrew+netdev@lunn.ch>; netdev@vger.kernel.org; linux-
> > doc@vger.kernel.org; linux-kernel@vger.kernel.org; Salin, Samuel
> > <samuel.salin@intel.com>
> > Subject: [Intel-wired-lan] [PATCH iwl-next v7 07/14] idpf: refactor
> > idpf to use libie_pci APIs
> > 
> > From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> > 
> > Use libie_pci init and MMIO APIs where possible, struct idpf_hw cannot
> > be deleted for now as it also houses control queues that will be
> > refactored later. Use libie_cp header for libie_ctlq_ctx that contains
> > mmio info from the start in order to not increase the diff later.
> > 
> > Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> > Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> > Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > Tested-by: Samuel Salin <Samuel.salin@intel.com>
> > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > ---
> >  drivers/net/ethernet/intel/idpf/Kconfig       |   1 +
> >  drivers/net/ethernet/intel/idpf/idpf.h        |  70 +-------
> >  .../net/ethernet/intel/idpf/idpf_controlq.c   |  26 ++-
> >  .../net/ethernet/intel/idpf/idpf_controlq.h   |   2 -
> >  drivers/net/ethernet/intel/idpf/idpf_dev.c    |  61 ++++---
> >  drivers/net/ethernet/intel/idpf/idpf_idc.c    |  38 ++--
> >  drivers/net/ethernet/intel/idpf/idpf_lib.c    |   7 +-
> >  drivers/net/ethernet/intel/idpf/idpf_main.c   | 114 ++++++------
> >  drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  57 +++---
> >  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 169 +++++++++--------
> > -
> >  .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  58 +++---
> >  11 files changed, 288 insertions(+), 315 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/idpf/Kconfig
> > b/drivers/net/ethernet/intel/idpf/Kconfig
> > index adab2154125b..586df3a4afe9 100644
> > --- a/drivers/net/ethernet/intel/idpf/Kconfig
> > +++ b/drivers/net/ethernet/intel/idpf/Kconfig
> > @@ -6,6 +6,7 @@ config IDPF
> >  	depends on PCI_MSI
> >  	depends on PTP_1588_CLOCK_OPTIONAL
> >  	select DIMLIB
> 
> ...
> 
> > >dev_ops.static_reg_info;
> > +		bool is_static = false;
> > +
> > +		for (uint j = 0; j < IDPF_MMIO_REG_NUM_STATIC; j++)
> I think you need to use here unsigned int, didn't checkpach.pl complain about it?

No, it did not, and this is consistent with the similar regions loop in 
drivers/net/ethernet/intel/idpf/idpf_idc.c.

> 
> 
> > +			if (mr->offset == static_regs[j].start)
> > +				is_static = true;
> 
> ...
> 
> > 
> >  	return 0;
> >  }
> > --
> > 2.47.0
> 

