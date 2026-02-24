Return-Path: <netdev+bounces-260605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WB0iHY/dnWmuSQQAu9opvQ
	(envelope-from <netdev+bounces-260605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:19:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7A218A748
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 731C6307750D
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108773AA1A9;
	Tue, 24 Feb 2026 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXxSlkcf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA22636B052;
	Tue, 24 Feb 2026 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771953466; cv=fail; b=Wlq+RpDlD+y/z6fz7N/rxcTL1Y2AJMlZLvc4ECUNlVXbacPk7WpCiHNYPk6qrTBqNcq2Ye6U1HdczX8WzBbxVwdaGoZwMuE/3tEKaIJiLCQpDBwJV3vIG/zxt52yPHUsQOEdlgYZtC+rsl53lk+8ALLFAsCPY4W6lwoEX4Zj55o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771953466; c=relaxed/simple;
	bh=Pb5GAH5St7HoxX/xXpIeM3luWr92EWsjXoqzRF1TasE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t4gxhPonmvbyRO0eV5P17jvQnSo3oxp4UQSq0xFPOHb7V1Qw8/aLMdApE2i4J+QdlYrd7qHB7AOoZebWVom/a7q03mtJcqneYA6wGGsMYDYrnDziUnCGUcC+PDi9I2zLZ2YFB4hicgZtKJ08AhVf7b2AXb5mD2rwnDNwytU7eB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXxSlkcf; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771953465; x=1803489465;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pb5GAH5St7HoxX/xXpIeM3luWr92EWsjXoqzRF1TasE=;
  b=PXxSlkcfpHGNIAJQJlnReVOMwuzi1oj/wtu4nf865x7pJYnreWhpIOZ9
   unBRlxuf63/rM6b6YOO1BYdQL0VjCfy05ZAOXTXo8hglLjw4OCqIXy/L6
   28i5nwLM0lYtKEnf9WALf546X5hWfiOWG6LAGkV758aiX9KY4o83GCqEP
   RvpBYTZFXdbE/K53joN3MT6pBSiAOXDpqWbRm0MGrP1Ji+TEK5UMfeJXA
   4txCFBjWE2wwQHHUZKQL7z/vhqhGAvCep3qNuzZEnPYmr3tEcXRRrYb68
   cC+X168saXfTryt1zOKtLRlS8oHUme2n7e8y6sqvDAY3MXAEJxKJBrzBQ
   Q==;
X-CSE-ConnectionGUID: pmP7gVftT6WqN4AbBZRSdA==
X-CSE-MsgGUID: 0Vqk02gHQBuoOY4i2eLDfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="90555742"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="90555742"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 09:17:43 -0800
X-CSE-ConnectionGUID: l2sC9EBJToGGTJ7TETM0uw==
X-CSE-MsgGUID: tDp4/NbHQqCSxIhLUm40oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="246535389"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 09:17:44 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 09:17:43 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 24 Feb 2026 09:17:43 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 09:17:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlGQWHnqvJi6bnlT/xIdMCYtLYXq/6GcgmMci0dHWdUqAW8EJUspYtlVATEAWs4jle7VI17q9ICDuJm3O85rI+FBaRGIBG7Ym4+te26Q3OCz9CSJRstQh7anA0vAQCJQKeowDDJQ2FJk9qiaifRcbYFUJgkPQLnmw9l2CNNzaD76t1IBysv7RuMZiJU17EFdk/ApWBvR+ZnC5B3HztYl+2KaIglY1Cg2bZKcCK4RhZHoDtWv5OBrd5oT9ZuT6kJ/2Y8U4I0Kx7JaKHT3S5ldNn/qRJENNlzVyOSSmIDQGYnznwXV4QttZHcFmG0NGe+UgGdiLwcnvUhb0T41H75D/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQUejH5OGh2V9JVZRm511etJtZD0x3V9PJvhVuK10MI=;
 b=qO4SUznE20P64F1UO1cDL1vRXsG9To8xxK9HmUYL/Ne0rUSjp0Cdo5UsmbN8IpBl6+szHk+nJXUg9OgzD2vLBW/CQfQiGLqJzGRqLrmpLnf48or64cJyvrpZn53rSiEVvpX88zJLLeoymzg7RWk4MOiU8x/lNj/mhEQNzxO6jdvXu9fFejRQM3P8reFErof8NNUNgF9PoufNdJgwN672AXSLrHckfcuPeim5A5XPsTB27Vo9DE/k5lloXZ1WQ0+Ahk3gmCt1MOlpdk4hytWftoo2aCcjQtCLqKY7S+rwfHfJRlPJLP4+W/4EEQBemc46waMW9FU7f5479z+K/tL5YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by DM3PPFE9E88246B.namprd11.prod.outlook.com (2603:10b6:f:fc00::f5b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 24 Feb
 2026 17:17:38 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 17:17:38 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "R, Bharath" <bharath.r@intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "Singhai, Anjali" <anjali.singhai@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Hay, Joshua A" <joshua.a.hay@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Shanmugam, Jayaprakash"
	<jayaprakash.shanmugam@intel.com>, "Wochtman, Natalia"
	<natalia.wochtman@intel.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Richard Cochran
	<richardcochran@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Burra, Phani
 R" <phani.r.burra@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 06/15] libie: add
 bookkeeping support for control queue messages
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 06/15] libie: add
 bookkeeping support for control queue messages
Thread-Index: AQHcV8kVxe1j9rNXekuyGLCyIzaX6LWSClSAgACohJA=
Date: Tue, 24 Feb 2026 17:17:38 +0000
Message-ID: <SJ1PR11MB62971BA136E6A239FEB4B2379B74A@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20251117134912.18566-1-larysa.zaremba@intel.com>
 <20251117134912.18566-7-larysa.zaremba@intel.com>
 <PH8PR11MB796529491E8E14C116704BDFF774A@PH8PR11MB7965.namprd11.prod.outlook.com>
In-Reply-To: <PH8PR11MB796529491E8E14C116704BDFF774A@PH8PR11MB7965.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|DM3PPFE9E88246B:EE_
x-ms-office365-filtering-correlation-id: 071ca27f-f0e5-42f3-3ef4-08de73c89c69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?vdEURhp0qsnVyMNo4PQY2nflfG5k52e0LEuCZ+XTgw2rK+N5F5JcgGSliTGg?=
 =?us-ascii?Q?ZwTTpa59hyKRWnNuphCeEksMYYRTrZb2igzA6s/vXupR6xOxFe/orZUgXvES?=
 =?us-ascii?Q?RyDO3okgwnz8/ubqiZhI0OCOmBw1hmhOBYDnP7YPc+kuW1cUBtT/5Aq99WOh?=
 =?us-ascii?Q?omROY69ICHdiRCMgqI9SKAW81Oo833lbuAinwFeIkC7lgmVQAiXl0AmM9ViL?=
 =?us-ascii?Q?Uo0fPxrx/OfH8SejA4ALLbXwILKiJ0ScK1vzlKKtnqz1J/NzWUUt0DbHqzfm?=
 =?us-ascii?Q?m/VqdZOyqmv9x3aHIcdj6aFszlAqW96eXHKogN9lobZyBmq6h1DoIzSKfaOk?=
 =?us-ascii?Q?Z1haOBcOar1m1EVoWNtepxNXJrERnUnAonb+x6S12kFG6AkxROr0wkfxkwhJ?=
 =?us-ascii?Q?KJAnpsyC0K3Ue0gCjLI+ybrQxBZNifrsdnWU5EKP8zoTtC7iL98OQDDmebOl?=
 =?us-ascii?Q?FIhVGbM3sYN0DXvzMdVtRkhT5c99NcOmUbEp+0dbT0a323y0MQyyoYT5c8O/?=
 =?us-ascii?Q?X9cw9zwXpxFtAAoibPRWrXPn3r947GpF/17KIv50G0Pc3e/rpCcQK151gmND?=
 =?us-ascii?Q?5gpeSzWYLKclly4N52r537psY18br/2G9x47cgoPT/jgvdNSrmL+g40cvZM6?=
 =?us-ascii?Q?yGw2+aDi5ZshAuRhx5C2+1R7ecEFu0htE+PV28FIZ2MR3Orp8niN8/gKHYkL?=
 =?us-ascii?Q?6qXTBIsUtVCLqO5wyD1LAKaIMKSC7FmSFo5N6ZY4VlU+3dLRnNFhytJ8PrTM?=
 =?us-ascii?Q?9eWmSMoiacoBcdueUUwwWbc5tY2kpIuG0fFgjXr3Dp2nObUJKX+tYhkkirMb?=
 =?us-ascii?Q?S5vX7rZ/VYgDoOyl4U2pUWL74BdQW56NaI8lH422W4xs3tLRWqhi/WoDf6Ov?=
 =?us-ascii?Q?t229uUxPrEO6lhDWWUsQaNld3u1zvr6y8LwxB0sevsLk5mb5bTK7w8d99pU7?=
 =?us-ascii?Q?W3iAaIcCtdiJE2RsQtPkxB96pBzVLU/1QSr0AtH/U25Vwgnl8cewwRZuW1ca?=
 =?us-ascii?Q?/EI2wd/Fg7Vu5cG9j0ALNBG4CaAPMHKJOCqCPHO9UGrs+4QRQDpmUZnJ4/AD?=
 =?us-ascii?Q?v58Vy4V/pH3qYNLoeity66HGsa2SarmIoLDUfgpqpYrja/PrfGWjFB1p25SE?=
 =?us-ascii?Q?Ijp6o3T04QNHxRoWY6WQYefTnVtGcPqJDm36WO5Xw6I6f9w6hudBpUFqpKnS?=
 =?us-ascii?Q?/qXYyxIy0COtxWJPATk2QS4nci0Q6fkfJNmg1eneQk2oS+5s8U0yaINvwiJ4?=
 =?us-ascii?Q?d1o/X4tMz7Kk9+3Agr19uIzDefvtpoLzSJTLTnwOTGk0Ao5zLnjMG6N6Hkry?=
 =?us-ascii?Q?7gxAJOP0qo7+QLfKkQ1m5EDwpheMNGFDTHsoV8z8NBB4vwtwkutpzbb2F8HG?=
 =?us-ascii?Q?LxG+Af0U+20A/D1BKV5lHiWsPGW/fRTKoT6Ac+sXOxikyFtOHUxteXgSpXtH?=
 =?us-ascii?Q?vDuACV/y1lnbXH4dF/YyxDC7SNjJcNd3K789HcBijaqfUXFrrsAjtcFU9O3N?=
 =?us-ascii?Q?LIU5aEsj+FsP0nUY7NSR4KFyDSj4JiQcIlEeTpRGN/j5y8LjYaBn3EJIxWfQ?=
 =?us-ascii?Q?rN26OwQ0gFF5262ymEuANUzQhEFo4TEzFmmtl0lbuoXk5nEv5lDqr5LxjXhG?=
 =?us-ascii?Q?PRAVjBFBklLkfP+h+6BL+Ro=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sD2czsyJreidor4W31WzT9fKt6JgVXJiSA7rdHjGBN3E4cxxfLcNCjmzFUD2?=
 =?us-ascii?Q?g55uGyDMOsRHN7nZyPqpzhOekL/nHcPyoiJgflT/lwMMbBiQF976HxaMImXH?=
 =?us-ascii?Q?HOYTC183itSnudHsOlDBsegNLOsjKT0BdWCWXr2FJvD0aQe59wuAgv4BLthA?=
 =?us-ascii?Q?sBBkqH1L8+QdvUsIM6PPvnWRb85/sQFhNd23560pWN9f6eDZUwnMC9ohM8B1?=
 =?us-ascii?Q?KLcwTk766ULfJXuOdITManhgojxwOp6W0EY3GVTMQg8Elvm3Kde0c2aDi8Vh?=
 =?us-ascii?Q?ZrsGgQJe6/6q4VEpG5HD58Y8zOyBO3/9fAB8CJ/2mhIFJG4kLbYw8DCIdTeD?=
 =?us-ascii?Q?C8XE6ZZHzRGDRrTPXzz3lJAC6VQBWsF9lSus+kFvUU08aE/Pj+izVETDix1p?=
 =?us-ascii?Q?LOZFIcqcrOgSCt7rtrbQdHfJLSJ2iojiaSMG0UVcdY3x45mz8KVz/qV9iChg?=
 =?us-ascii?Q?xWP8pO+6l4rznQWxuo5dMoPbxzpBBP3IDSpIOx3XVU5yb0oeURffOA5EwHHN?=
 =?us-ascii?Q?nvB547twGiMWGoNVIC7JvvyxvNWIWjIR1Nc/qJQ8BcYQVCbcAnzsXtOzQdsG?=
 =?us-ascii?Q?pAc50rLXlU6h2m0dpIBD9Z8EkLvVOAEp8TMoWYOKk7fV6NCoQV8PQkzPK1gC?=
 =?us-ascii?Q?9Xmo8muU3VaApmsamIABYQJw2aOBwZg/zTaW9nMXjmqdF+0kFqh1FypcaKcA?=
 =?us-ascii?Q?IhYlkXSgG74nN+TPpo9yOIDAjC3uQtzW3WKXEL8IeqfcyngCRHs77FsLqiii?=
 =?us-ascii?Q?Kdf7x9ahV+QDsbFx+MopJ6PXvIhBXe5k+3yznOZTuZjkFepMPhNI9aL66q+J?=
 =?us-ascii?Q?bbu2EqiOOkdm3Qay7vqF8xSmZH888v2zP1Nr/KUNO2bJ6FiUZ4mcfBiqGJrH?=
 =?us-ascii?Q?9Q5z6EsCu4vSc33iKRhCMYEeRvnhuO1vEpTVmIRlD7O2+iaFb6xMXGjS/mG5?=
 =?us-ascii?Q?w0PW3Aop8fvTnK6urkvGogtYF0YnsfVnpzkWwrCCnWIAXMkEoKhvisqyTkZR?=
 =?us-ascii?Q?q3OIb5OHwvji2Ub+d0jtSQr2s3X2OKoQeGcLBfrorV7YKVQo4O4xbjPfo1ob?=
 =?us-ascii?Q?CeIQvPLkSBXTGAk7Tke3xyWnKKPFBcmTevlh3gZ5htc6CDp/+xBuLFFTBxzF?=
 =?us-ascii?Q?zxSPdrew2o8ZYP9a9ASAUq8w3DM1qdzsgo1TbMaYJaBQBN5Fhkz1C9XgcdWc?=
 =?us-ascii?Q?VUjZvo6700aQTdO5SCgUEabS34Drg5EdEZPI4bewQXWN1n+Myxls4qwj87Dh?=
 =?us-ascii?Q?cwRWuA3WiIRTv0WwISD3jZBH/E74Uu4+2+HRXK74PNXyj8HnAUTu0fIjSRvt?=
 =?us-ascii?Q?0P+aKkJ4o2m0f6F9DZ/6gAhOH+w34/ZFEM0UEXwqLYuFfxaSDQNDFB/PGyOc?=
 =?us-ascii?Q?3qQMRUvqlesTXoFYm5t8BdYKspEo6JVq5K7HIVaxGlsHoKQgVo/FjuXECwvn?=
 =?us-ascii?Q?jrT3R41DIuEKzHgGa1j6jR5gj7zmx9q1TCCY4J+kRfjat84Cqc0uXgALq8Vz?=
 =?us-ascii?Q?mEPkhLFDQMzqoGnEe7K46YCd7rYlHOsF8FxHd3NI2lR3KWNeNKF5Py/8tfLS?=
 =?us-ascii?Q?pvAoC0414W235ZS6/EiLXKdgoWbEvlrbE1uWPxFyAFvK1HlbGUfcaDPDKB8o?=
 =?us-ascii?Q?DY8SJD8ltFI3YFzSP3mAeWdzepjG5bJMgY9HBDFbXBKPeXw9+Z8PSm++dCh2?=
 =?us-ascii?Q?69doBRaVzfxxLvCVac+lAxO6EqrsXhQzCmAgZSEtm+bD5mB5zN0pnvQCbfka?=
 =?us-ascii?Q?AWWA9iz3Qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071ca27f-f0e5-42f3-3ef4-08de73c89c69
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 17:17:38.1819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M9LKjTZCFUqakCbD0za7hehfs6/+/J3WQ5sjMfZVKVIAmU7kbqs3tNywT/L3S5lXDXpYPe+tPLTs35vwQWaF4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFE9E88246B
X-OriginatorOrg: intel.com
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
	RCPT_COUNT_TWELVE(0.00)[30];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260605-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[samuel.salin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: DD7A218A748
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of R=
,
> Bharath
> Sent: Monday, February 23, 2026 11:13 PM
> To: Zaremba, Larysa <larysa.zaremba@intel.com>; intel-wired-
> lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Samudrala, Sridha=
r
> <sridhar.samudrala@intel.com>; Singhai, Anjali <anjali.singhai@intel.com>=
;
> Michal Swiatkowski <michal.swiatkowski@linux.intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Tantilov, Emil S <emil.s.tantilov@intel.c=
om>;
> Chittim, Madhu <madhu.chittim@intel.com>; Hay, Joshua A
> <joshua.a.hay@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
> Shanmugam, Jayaprakash <jayaprakash.shanmugam@intel.com>;
> Wochtman, Natalia <natalia.wochtman@intel.com>; Jiri Pirko
> <jiri@resnulli.us>; David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan
> Corbet <corbet@lwn.net>; Richard Cochran <richardcochran@gmail.com>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; netdev@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; Burra, Phani R
> <phani.r.burra@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 06/15] libie: add
> bookkeeping support for control queue messages
>=20
>=20
>=20
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Larysa Zaremba
> > Sent: 17 November 2025 19:19
> > To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>
> > Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Samudrala,
> > Sridhar <sridhar.samudrala@intel.com>; Singhai, Anjali
> > <anjali.singhai@intel.com>; Michal Swiatkowski
> > <michal.swiatkowski@linux.intel.com>; Zaremba, Larysa
> > <larysa.zaremba@intel.com>; Fijalkowski, Maciej
> > <maciej.fijalkowski@intel.com>; Tantilov, Emil S
> > <emil.s.tantilov@intel.com>; Chittim, Madhu <madhu.chittim@intel.com>;
> > Hay, Joshua A <joshua.a.hay@intel.com>; Keller, Jacob E
> > <jacob.e.keller@intel.com>; Shanmugam, Jayaprakash
> > <jayaprakash.shanmugam@intel.com>;
> > Wochtman, Natalia <natalia.wochtman@intel.com>; Jiri Pirko
> > <jiri@resnulli.us>; David S. Miller <davem@davemloft.net>; Eric
> > Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
> Paolo
> > Abeni <pabeni@redhat.com>; Simon Horman <horms@kernel.org>;
> Jonathan
> > Corbet <corbet@lwn.net>; Richard Cochran <richardcochran@gmail.com>;
> > Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> > <andrew+netdev@lunn.ch>; netdev@vger.kernel.org; linux-
> > doc@vger.kernel.org; linux-kernel@vger.kernel.org; Burra, Phani R
> > <phani.r.burra@intel.com>
> > Subject: [Intel-wired-lan] [PATCH iwl-next v5 06/15] libie: add
> > bookkeeping support for control queue messages
> >
> > From: Phani R Burra <phani.r.burra@intel.com>
> >
> > All send control queue messages are allocated/freed in libie itself
> > and tracked with the unique transaction (Xn) ids until they receive res=
ponse
> or time out.
> > Responses can be received out of order, therefore transactions are
> > stored in an array and tracked though a bitmap.
> >
> > Pre-allocated DMA memory is used where possible. It reduces the driver
> > overhead in handling memory allocation/free and message timeouts.
> >
> > Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > Signed-off-by: Phani R Burra <phani.r.burra@intel.com>
> > Co-developed-by: Victor Raj <victor.raj@intel.com>
> > Signed-off-by: Victor Raj <victor.raj@intel.com>
> > Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> > Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> > Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  drivers/net/ethernet/intel/libie/controlq.c | 579 ++++++++++++++++++++
> >  include/linux/intel/libie/controlq.h        | 172 ++++++
> >  2 files changed, 751 insertions(+)
> >
>=20
> Tested-by: Bharath R <Bharath.r@intel.com>

Tested-by: Samuel Salin <Samuel.salin@intel.com>

