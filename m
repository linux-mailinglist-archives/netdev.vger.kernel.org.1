Return-Path: <netdev+bounces-281778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAC7NteI8GloUgEAu9opvQ
	(envelope-from <netdev+bounces-281778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:15:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94230482697
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7925D307D590
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE1A3E6DCA;
	Tue, 28 Apr 2026 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+DhVBqy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6186B3E5595;
	Tue, 28 Apr 2026 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777371134; cv=fail; b=mLpdsf1RxHCudOkoWNY7PYWJtVKMZ6PO49faLc/sHY1PSPN6ypKxEKrEz1pFveGr8xxSZGzYvBFFelaatOSLEGj3FHsw4Spa0n4cr3HaWuR/eHDbPNZRVhc7+Eto9jCAsBSm+NpBLhUfITCFgx//UXFKJJ/a6LmUhGE9Ijckje0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777371134; c=relaxed/simple;
	bh=1B2nesTaO1xrU9WvN3JCdFxXGMYzMYMGw/jW9YcBXwY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L6wZi0qUfj7zbl83zdvliShJK24QKjcUUmnC61lxZmnIhltIsPUMdaFJsImBdRA4ta2x2DrmkRhmNeLd8gkdIdUr7e0poh3BW6keIk0etVlKOQVeTz1U6jlQd/TxD9hXewmRIEz49o6OizX4m8yfrCK102zJZDBV5P1WfsaauaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P+DhVBqy; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777371129; x=1808907129;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1B2nesTaO1xrU9WvN3JCdFxXGMYzMYMGw/jW9YcBXwY=;
  b=P+DhVBqyEjOTFyyMqg9Me+OHHu7Ln2VjDUUz2j603taDMeJH+fmx/I8n
   HDqHOta+bGQ102VUYPeD9OiEtpR8iyBBvQyjz/aOzgMLJdiE9pQiatCTs
   EnjYf9W2SAPB7UBWc+GV9kZoPsb2by6Y9Ii9VJ8wK1y5Akv7Z2pNSJEjX
   4Q7EGDex70gaMJUk0+uO0aUpaxn8pqQIiQQ8udoHI3mUZ4HIzbQaC+Khz
   M8MOsUDau02P1pd5Fd7ctM7wQxI3bcT5et4IKaciqiwlS8VynY2G1e+GA
   TzLild9itX27MCLK3QbcsWmiHt4kwwlQY1LMjuLqD8L6VadYcUqG/8QPZ
   w==;
X-CSE-ConnectionGUID: FIejzSBNT9WpM4Tk765ANw==
X-CSE-MsgGUID: W+uZ4NcSQ6yB+GzDwS3TFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="82127578"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="82127578"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 03:12:03 -0700
X-CSE-ConnectionGUID: nO6MBwgeRgakDvmw+T/xTg==
X-CSE-MsgGUID: QPNK1FdaSumm8CsHf+b5WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="238253724"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 03:12:02 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 03:12:01 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 03:12:01 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.24)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 03:12:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJpOXS9rHmYSe6t1mWP1SA7qkdSDbPGDhJY05Dmys8070cHlDiUY41LMEG6WJ1be2ydI8Wdgx2E/JyLLQwNC3AeVtuaLvrTZnZ+w6WFnxWaugur4sg9klj/x6eBkMeMwts7dU2lXxMgOuwjHo32f9KnDnM0xeDfDnZyQYz9CWry7RwhudSYJJV5NbfmzluTZbnBCFeYS0Y3V5r0lNjgDKfIqGggj3x13azhMayP7t/y89T5zwok3w7mCM7vGgNw7D9gFjQzqrrGQyGy9ZvgshJFuoXKaK87eb4eSxwD6kMEDAUVmn5OVHvVHZRYqn5eodUNC8+LtSEXQHGExuCkyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCjF35fTvCr0+ngDqnLGJp0mHqNIv+2jq3/1MwOHp0E=;
 b=hHB6TFHxS91A8/Vi4/L/28Fny9bq1OqZ8PJw4dfavHMLtJociqVriKrgawgbfkOyku94hLGh5r7JRW5x/kNrzWcAhKhqx4J6tuGCuPqH45Zp8HndP2rIUrRv+P8ngXaIm361+Tm8Brb8ulBCNfPy5taaMAqn7b1JiaXISFdq4oVPkyvl4d+FHO4sjI3SHNMDkdxqWqztff6gp8M37fGfs68uGGNh0Bk22LGeRQARa0KHrZmddbjSBSaI9kYent6sYllRLfl64S6pS85UZMJlupc97tXuLgrUaz9EB4zNdM3/bGgrMrr/C7/UKTkwfVSYRmP6TqW53lhlk6oeWRJyzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MW3PR11MB4716.namprd11.prod.outlook.com (2603:10b6:303:53::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Tue, 28 Apr
 2026 10:11:54 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 10:11:53 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "Fijalkowski, Maciej"
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
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "R, Bharath"
	<bharath.r@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v7 11/14] ixd: add basic driver
 framework for Intel(R) Control Plane Function
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v7 11/14] ixd: add basic
 driver framework for Intel(R) Control Plane Function
Thread-Index: AQHc1ujrk6dTeeltFUKKiUuQrWXf47X0QPfQ
Date: Tue, 28 Apr 2026 10:11:53 +0000
Message-ID: <IA3PR11MB8986276B7D0D349D406EBF11E5372@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260428082654.44364-1-larysa.zaremba@intel.com>
 <20260428082654.44364-12-larysa.zaremba@intel.com>
In-Reply-To: <20260428082654.44364-12-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MW3PR11MB4716:EE_
x-ms-office365-filtering-correlation-id: a8b587e7-b17e-44ee-b765-08dea50e9271
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|38070700021|56012099003;
x-microsoft-antispam-message-info: i4nPewB6YD/F1e5X3AujuZQ4MQD+FCa/ZlSWVHq9W18QCYzZ7Dw58SoThhoD6q/Md88Fl71U95z9OBaTiZLESrzY30EnA4m0QwwwMfC29KlUd6saTG379BxvUKrj1i8mB0HsdSuYUJXwcpgSiQpL+DwGEN7habQjcNEsZ3VhiTzMHw0yPQZMwYLvn1FOkLD3h2qLFPITDBI+dilF1bm/tKujfEm5aJbEVJOyg1dE0BKQif/nGicWvQLHjdVhFIaPOBmM4CMD05qdv0J7zdu6Vdua23FOx5zgOkEtBYLmwHuWek59YKkcv3ScvsWfj/qlVN+AYQhT7Ums0DwzRfdpMuWG1gAOuOwC2QBuUiX46mmzhPXIW8clQir8TRnruuUJiLTfVDm4zy/TfCI39jiHUu+FAn9oUo/ZVBU/JHtkpI+FcxYR63ch1CNOMZtbFAyil25KtgTQbQMtqxUTqMFjZ5L74Vw3h7RpuyZ/7Jfx2kAUTNAmYsrSuLuj1MLHcLWjEjn1IduAdRa5TuAz8l+T0cptbv/9aH23ez2O3snOxZ9FqbQTsOHRldboUJ4yUdGpm4yuXCRUr7V44fTTQXvNvDzPyzr9AtSX55sGpdWaEdOWCyGg7+D0zwUxQTtGjOrzV47hyvi05Yimw7l9ZtDmjmhV1/9x65mqD1or1UOxvrAShe8y6LP4P5aFUCEA+dLVgCxZwp8VNqN7oZlgJJ2YFmXHH+q0qLCok+B9GpNxSnL/SbjRWPsoICaygAZ+4FtiSZCYE8n0P82r4PnqfwjWJetl3tToIU7Dq2cWMThCHcY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e3qrQt02o8zGw5LxYwHl9odkzz3nEXQiR7MPbcbrtro9smrP+bRsVNKLMdaM?=
 =?us-ascii?Q?dx9UvBv6QgsW4BALR9o3h3gUvhEkokktPR7mAx4eKlJ1VuvfkZaj0qWnABRV?=
 =?us-ascii?Q?LXcBmWsW5hita0y/6Rc/ZIjXYHhb50QKJe1TqO81KXBoOkZXspIn906D+J61?=
 =?us-ascii?Q?YlhzNr4d7QZx5TYp3JMSHekyma20e1mgVXJvrKuauKaCwS/1hU3WjZvxlkd5?=
 =?us-ascii?Q?VEh+7arHZsr7KgMEqLSymYVMh3VnIKRFViZ0WYNJCK8noN9in1CbegY7Z6fl?=
 =?us-ascii?Q?Dcb5vWEjx4/34XlB5IJ62Ihkeh+UeVSjCUJgks0AfhMaBzIYWmXsXa9nccey?=
 =?us-ascii?Q?ZKDq4vQ4QQfwAYDi1ofu90K+4zd/sRNR6ydZ4JgTJm53H6NNc8+BdJoj5jie?=
 =?us-ascii?Q?QuIKjRH18+HoQKEyt8Zb4jJXHxnT5hhua5CnIajHsnIy8WtuV6wK8YVTNH8g?=
 =?us-ascii?Q?Xe+GZGqiJ1W1n4LJ4dRnxKpkbVZ+VjGJA/1B8VXmc2Jf5jh+8XjUc0tiju84?=
 =?us-ascii?Q?Yjy2Zll2tJHH+0Ct+iSUq77yRyq8LLBtfrCXrdF5uxQDs19BFxwxfB9j0fId?=
 =?us-ascii?Q?/u8STfmV3Onj7OH49ZCGP3kKVxbfbKfPs5NxtXe9LMU6IxPMQOmtXTBqdGNb?=
 =?us-ascii?Q?J87KuCmuuDo0YUY8S9VcYEmrdk/nYuBK0iU3Oaz+SQVkO/0cA3hMFYDlYdWp?=
 =?us-ascii?Q?rPdKfoi+LS7nBgwQHLHms9naJ65mlwezS6Ko4ahA/BnTyy8xN9NoMxbk81ch?=
 =?us-ascii?Q?KobZQPMgftf6AbPZ+FXgD7hjarBH2s6yHdwP70B5TmhRILAT67yHjZ9pZxBf?=
 =?us-ascii?Q?l2RfbZK16AqzbdN5NelcLbYhTz8+7h1iY1Nn995nrXF/uufOfntuBbHJrf6X?=
 =?us-ascii?Q?Zoljep754OyC27f3VKachpEXpjdqp/BVpk/e8zIR/JH1eH235YZZEYKL/MkS?=
 =?us-ascii?Q?RILTf9+uRcez/+BgQ2gUoAmKbFDP7FZ9sFvT2vxCK5CKRvB+gocGlWF5IV3r?=
 =?us-ascii?Q?yDfwSwY6TQXaxJgew4TuoVtydPH1ScKnvW77ZcOv0haMPrtcjs4kVRMtkpyX?=
 =?us-ascii?Q?nSmTNj3DwMiLhuA/rHMZxGi32reQ3IbSu1L3embwkzlIcTOcyWknC8zDZueT?=
 =?us-ascii?Q?OP7MAGwZZJmjJknvzWrJ7c/LzfSYg3VYiYG2QoFGU8CIAe+nSe+OJlfSsCzx?=
 =?us-ascii?Q?txDL1Zx5ZJ9VSX5SggbWfqO9ob9k3EPf/nbEYEiUnmIImWFpjfD9zeJ3lubp?=
 =?us-ascii?Q?GNRF6sjJnFICmlqzzoeVCN5jfzyGyljS8e0Rop0h/VpNDtt7EziuHnENcy1z?=
 =?us-ascii?Q?/DQ7pG/mP+e4ya76OkPml1vPgN2Tql/G1Hz7s4dy1aLTRKULq0llREKZVB3n?=
 =?us-ascii?Q?OWZssZYtcaTGFnd7w9XIzLq4FaVZWCajHU0Y/9CqkFu3Gq5CnzCbi2CDRU7+?=
 =?us-ascii?Q?Q7lfhWXu66GPTPohT80xSWjZYdIneZfIM3xR5rOQZTBR2xmsMLBOj0TggKcy?=
 =?us-ascii?Q?v5j4wx0Jh9SAzdZZfyeukm8SwF3dRSUxOcs183KwPZRMbK3SvlMwS2morD2c?=
 =?us-ascii?Q?Lb9ygWph++C5OcogAAsyfwHq9o6QASkTW1rF5KY1JrEWqNMT08tPHiX56l8G?=
 =?us-ascii?Q?GqRPfkGtR44aw21k1c2buOek0KdzuotRGUrObNsL/F3NIH0yppVSeg9muOVi?=
 =?us-ascii?Q?73RCkLtWuTA1kPXO9z/X6D53ANNn7R0CaZWthJPWBkl4SC8/IEGpszT26FZ2?=
 =?us-ascii?Q?JFP0NFvURIOiai+kSQ4XYPLbYGhG84s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: i2QPujTAEpqxN0IIbFO+j1sOQmsLuej7J+k1RnXuzqYYjkzEWRSwk8ocAFWEZGi3vudphZWYYa/KBX5Wl6GG3IuuQ98GVDcKWvNAa/zaPLo6hMWceXKVEQNnaMm+QWT5+BzBW+7f1tbHiBZ0gbr49uLyC4eVGnh9cU2xpC5AcuQHwp1ZZ2MeZdfgGrYtpE7b7akTbMxlM9NG7dR64GMbf5KQiM4s9qIYpkvPM3lFWEFGm0GxcFlIX4MruXk8k+gPax5m+6L3IphJHk+DtA2w9mwlGvy8g6aaHEk40QLovMK6zA6TSQvIbDOpdHhAro20EsO4TfiexMFzDwUq+v+6RQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b587e7-b17e-44ee-b765-08dea50e9271
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 10:11:53.8210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FrBlHBOPOi6X4ocVnmYBB8ZVpjfoM956Bul+8oR4N8CNVdEnO3lVQgbzF0mUNvQoM3w6E4c0idJzHKQ7j4YugYX8l8dxmnmkdJNkTSiiwNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4716
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 94230482697
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281778-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Larysa Zaremba
> Sent: Tuesday, April 28, 2026 10:27 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Samudrala,
> Sridhar <sridhar.samudrala@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Tantilov, Emil S
> <emil.s.tantilov@intel.com>; Chittim, Madhu <madhu.chittim@intel.com>;
> Hay, Joshua A <joshua.a.hay@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Shanmugam, Jayaprakash
> <jayaprakash.shanmugam@intel.com>; Jiri Pirko <jiri@resnulli.us>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan Corbet
> <corbet@lwn.net>; Richard Cochran <richardcochran@gmail.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; netdev@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; R, Bharath
> <bharath.r@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v7 11/14] ixd: add basic
> driver framework for Intel(R) Control Plane Function
>=20
> Add module register and probe functionality. Add the required support
> to register IXD PCI driver, as well as probe and remove call backs.
> Enable the PCI device and request the kernel to reserve the memory
> resources that will be used by the driver. Finally map the BAR0
> address space.
>=20
> For now, use devm_alloc() to allocate adapter, as it requires the
> least amount of code. In a later commit, it will be replaced with a
> devlink alternative.
>=20
> Co-developed-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Tested-by: Bharath R <Bharath.r@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../device_drivers/ethernet/index.rst         |   1 +
>  .../device_drivers/ethernet/intel/ixd.rst     |  39 ++++++
>  drivers/net/ethernet/intel/Kconfig            |   2 +
>  drivers/net/ethernet/intel/Makefile           |   1 +
>  drivers/net/ethernet/intel/ixd/Kconfig        |  13 ++
>  drivers/net/ethernet/intel/ixd/Makefile       |   8 ++
>  drivers/net/ethernet/intel/ixd/ixd.h          |  28 +++++
>  drivers/net/ethernet/intel/ixd/ixd_lan_regs.h |  28 +++++
>  drivers/net/ethernet/intel/ixd/ixd_main.c     | 112
> ++++++++++++++++++
>  9 files changed, 232 insertions(+)
>  create mode 100644
> Documentation/networking/device_drivers/ethernet/intel/ixd.rst
>  create mode 100644 drivers/net/ethernet/intel/ixd/Kconfig
>  create mode 100644 drivers/net/ethernet/intel/ixd/Makefile
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd.h
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_main.c
>=20
> diff --git
> a/Documentation/networking/device_drivers/ethernet/index.rst
> b/Documentation/networking/device_drivers/ethernet/index.rst
> index 5f3f06111911..5b6846f387f8 100644
> --- a/Documentation/networking/device_drivers/ethernet/index.rst
> +++ b/Documentation/networking/device_drivers/ethernet/index.rst
> @@ -38,6 +38,7 @@ Contents:
>     intel/igbvf
>     intel/ixgbe
>     intel/ixgbevf

...

> +module_pci_driver(ixd_driver);
> --
> 2.47.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

