Return-Path: <netdev+bounces-269799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gM99N3/vvGme4gIAu9opvQ
	(envelope-from <netdev+bounces-269799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 07:55:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 637212D65DE
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 07:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5C373010B71
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 06:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E903563D6;
	Fri, 20 Mar 2026 06:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cWhK9PIR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D743355F59;
	Fri, 20 Mar 2026 06:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773989757; cv=fail; b=QMj72Y0kspD4Duvc8aCFgcTAsjJfmHD2zbnAbDcxQA/BcEpy8KD5ueCFWjEjaqLqgHGigUeoB5MVCRIaZPVpvvcbro7OhpAANLXD015Kf7vFXebtv5OznW4ktXxUO1suXExJfJ+8KXw60TlyJzQkGOUyyKBKbmtbbcy196kqyuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773989757; c=relaxed/simple;
	bh=kncq2OGbppUMhbLyzojBW6TFbWXar0/SFFcEy0720Mo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R5UbwEX7vDGr3abXOjj70lIdEQDkLKDdvMBMb0iFWlyw6dfNZlpQpyuZrZ1Dx3zxseJX0mEACvb/07o47IzWsAKGX7ZieKKY1Q6MFAWGuC789i+z/jNkgZvVnqeDTCYL7d2uGjKZsjOqTeeoRKYxNnF0fK97zsrO330iwf1ZWwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cWhK9PIR; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773989755; x=1805525755;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kncq2OGbppUMhbLyzojBW6TFbWXar0/SFFcEy0720Mo=;
  b=cWhK9PIRXh0E3kohtzvk8iA9KWZIaJg9dFV4MZAf7yVJt6TdbbCA5oKk
   abizB14gyvg2g/goBjItTJE3aZW6BLFXRRAP10vL/fqItgkc7SQHis2Nb
   3MdVB9IuPOSe+CEUMiEQo60lEiklp5QzYQ5ZyhOb44zgCbFG7Th0FeH9a
   9Kt2PN8vOfoRGQn+T8zp20VeBKr3emB8FN0mGjvefE9K0xg17sQekHYct
   de1RmKm8hnw7zmVOlh2CoUSy+rZS/xoFTQGHDPvO49y83DTlNqHid4muf
   TMmQKa2F8EnEo7i+StJ61qpWbh8di6KFPM8HvA1rEaQfVH2dpFueyY4Io
   A==;
X-CSE-ConnectionGUID: 1Qbk/ngETiC/qcWF3UM/Fg==
X-CSE-MsgGUID: ZqmASpGcSbey64blk1ab5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85698214"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="85698214"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 23:55:54 -0700
X-CSE-ConnectionGUID: FSbYCO/aQCyiO6wl9k9IFg==
X-CSE-MsgGUID: uCgZVH4uSnCd6rWSdBfnvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="253701463"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 23:55:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 23:55:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 23:55:53 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.12) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 23:55:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZ2QLqXQwpGAQPpRdDH64wFtflUx+QEQich7j/F7kOrY0QF3mGcrLx1cAgXq3tIhql1MeMOsC8ul8KOvDDbWJTiA0Eb40vKt8lvoUps2vrwsLLNO31qx/604S27eUoiEQdgOzsxPwrUwLmTVurnD47k7TJ+IZiFQuVkhXRq6376i3Aqd98a5fL2qpvfr+9/JYam1zeBbpaTFF6EQqlzPVY9csKMETZ26GDU3rZfsRGHM/RdQZnXbRzGOvbpdbLPLOzn6n8Xu3qvwW+5Tiqziw3vlb5udTuQh58kCgOanwYS51FAnTXOoyH33906t2R1LmnSoPeksngvvso16NvNy3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1Q+5XucSBKWlxVjMNRtEw5dKhHsDxiDsgt+zWvtI4s=;
 b=MuuFA+k+Kv66aKs0783igugrIjr4D+5pDN6qB4L6Mdn0Qt0yNm5YHABxAaxSK1EEmczFvr70DKXJTjS1e9bj49lfTbXx667aK2ye9vslSBN1Bd3YxPgmo2JGzeuQHGmp0QNkgelIZ4JXN3dkVrKqUqwhyxQqMSHxaLRRUBYTLd2WJNICb0A92QWPREQpVJ1olAtHyfnZ9W+TccympH08LT9JW/NYEVMoFYQDHcSWTNGybC0/QSM5Bem9AHHnVXQM6NYCqRvyjM6zdOSMAFzw1Fb82fupgaHfIvALHzhN2NfYEU/uHwN83+kN+sAhTfe9jvtMlcTrNpGy4NOAKKrrjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS0PR11MB7409.namprd11.prod.outlook.com (2603:10b6:8:153::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 06:55:49 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Fri, 20 Mar 2026
 06:55:47 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Vecera, Ivan" <ivecera@redhat.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Eric Dumazet <edumazet@google.com>,
	"Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	Simon Horman <horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v4] ice: fix missing dpll
 notifications for SW pins
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v4] ice: fix missing dpll
 notifications for SW pins
Thread-Index: AQHct+J9q7VbhUtxL0iV5L9l2IZ1BLW2/S0g
Date: Fri, 20 Mar 2026 06:55:47 +0000
Message-ID: <IA3PR11MB8986D0C49183B725E245C9FBE54CA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260319205256.998876-1-poros@redhat.com>
In-Reply-To: <20260319205256.998876-1-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS0PR11MB7409:EE_
x-ms-office365-filtering-correlation-id: 155bb553-5572-4f74-1572-08de864db6df
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 11b1NBk8tiQatzwVsfL/WlORVEtXegr0r9oeLCgfQeGUMxF9zZoE9vNFP7LDB2Obr5HTgJ8iUiQ+AYfOnKlk5Dr/dI7ZQj7XP9BnkC/gn4PtCueTNOuAHuR/CZXFgNndolp5lzpz08551zFhUYXpL+J42i28kF3nU013BqPCSujSRyYvuDySOAl8C7gk9wBcyxBXK7lklS/6unNYrXkuK5yP1lrtnZ39NZ2knE2lt75W8az3kl3BgO8w2xkxx1Djc5GPdIEtvRkftqqfPqQzbAsEKL5NDwbAyryAMpLBMLOLuDAh1Tv4QWRnb4f2E1KEY9C8iR3ggUEYfFB3fBU+1Bou9/P0qH6nEUebY4xMiin401tPJyVJL9EwclLmTgLKcPmNA0ckGHxgc+uL6t0aX8RyqZ0wuUFtqrOO11KS/TpZlyQ6/6gD6FmJKGoN7n3x/80FcDh+4L4tpxowfChxgB1ytqrlVqR+KDgc/BettUdjSM92y5iQXg/bu+rfd6mrSP/KG99HRxFp+3mb28Hz/PnpWzgQ2Ydyama4cPN+Ixjfk1hn8i+J7KFF78c/uMl7o6r1ajvWZHb2y+ayP2pm6CWNasQ9wSCtk8JkMjXE37m7+dBo6M74vt6BYo8JoVbyrJz2FmO61GBbiHxtjps8idBRsf1VGFMzxzKZXFqVm47YdUAEnztz8aX0J/5Qezb0wvMiam3HJ9BvgvVu9aBMMJUQTtgHQX13C5wByVr4rtkb6OsxCHum+5jKPOkVm5Wp5Nc86BCt0slaxEGp5PraXst/EV5JJIsyiURDApMy2K8sdeJnt3MBMbM+WZ/BUrJP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zYvZElVL9flEZsX0LuuqCGZVZge4BnspFwCrzutPOU78xgz20ms4XrbFRRqH?=
 =?us-ascii?Q?xZgETbvzGMkC8bzVcjnf13t+RNUg6v8t1/ukT+ORQSgb2enHiV2uVJt/sF0J?=
 =?us-ascii?Q?u5DfHbprm7fS7J/fhGxdLiz1kPRsK+NYJnaVzEkE4Qz3Pc3DdEDizepY6dKt?=
 =?us-ascii?Q?MkhHpwltCkPJpS/1Ucd1g//Uoj/wHHAvaqabVgB+b2z+GzoFnH/inbdZfMfG?=
 =?us-ascii?Q?H/NdPUs0HmdS7POvEdfrFtI7GEi8zNOYWMTzXbz0Z8tMDk8kEbylQkbW3BBV?=
 =?us-ascii?Q?IfpZDOwoJ0v3fVL/pPZB3TNsS2Xq+EhEEzHrHp4frNqUI0Ww65or2v32EC2E?=
 =?us-ascii?Q?KBG3/WVBmZclH/Krn2Tkuf36nCUGDNOGlbnkJH3nfhLZN0i2zxFpNE9QnYsh?=
 =?us-ascii?Q?ViFa8u96ZLeHDpcJmH1TwvBlKLATWylMvQ+8BmKGQST4ftN3eJ96jyxz24ei?=
 =?us-ascii?Q?XLrR4ES52Fw+67odzICoaNae2N6F74my9PRS0Oh6JSMLtCeUoQnE2uPtyCot?=
 =?us-ascii?Q?1ST4nKiQd1s5a47DBhCotTH8H/C4F4EmWbsv4Pgog0AgxrbwT/LkgflZ7eSB?=
 =?us-ascii?Q?ykdeH0bEfx1kEOUIPunl2mKMrNxIRS76TYgyEw5sniJaCkMR5sn8jexIuJdO?=
 =?us-ascii?Q?zZS1YbTWBmFHk0HKlXQOQWlErafA1bTiOszswf+f85XPqAQlRRuLxu2ejvuj?=
 =?us-ascii?Q?kEHgJJHBgpqE9rIjDMxVh5g8tjZbPFXwC6/FNSk3AL9CD56vjIJIdgKP8pE5?=
 =?us-ascii?Q?ZeD25OCTIYuFFtaN57ZHHBUTehy4s1APNnLFG+ddQ2JsPKsWl14UYbQLuOe2?=
 =?us-ascii?Q?b/NRUs9Ra9QrprNqaq1oM7163Ntb6LomPnKFb8ec3QpN11owgU6giVOKtqJx?=
 =?us-ascii?Q?9GOHa4CHWxQ0SWHjWWlT0fye3xW+5VpvDH3hTCXtZCWiZ0NXYDed+6X5ESIz?=
 =?us-ascii?Q?T1imYIDyH4tXSQzAjVdHOffASQg/yiyEU7dKdXNIyR1SxSCGtRbmWNMVarsb?=
 =?us-ascii?Q?u2xhUzP1evHSzJxwcOGTAITiD0gYRL6X2amWQepNp35zATkgkAwJU9jfL5qu?=
 =?us-ascii?Q?XoK95exh+yBJnXeafKH6e/x6QbWif2yk6PhVkwuJAAC2rGj7Ew3QOSoLmwO3?=
 =?us-ascii?Q?oIBnHc6j+YtROwq0CkKsNNoJvNPw2ZEzEwKkZIZ79sT7JrWS9nKG/DzxPB3u?=
 =?us-ascii?Q?lav/SoIMAmMapbSXFsOmA9HzquBc0lUK6d7dHi8jiigH3N9ATZwnNCXf3hdj?=
 =?us-ascii?Q?/OlXqA3Ur/P/rb0Xdt6Oy7k5lvlz3ousvlrkU0xhlt696UuGkzmmTTmPXEbr?=
 =?us-ascii?Q?3vLxt6o64FaxJxsxJbOP6z9a0f2dCwpeA2XevZZ1+lQk2ZgqOPkOujm8sqvK?=
 =?us-ascii?Q?4zJBUWl5qRqIb/5KKpIqGOiDD6uDFJfSmYsp6p1cDdBql+3RhpLJvgPYrCvT?=
 =?us-ascii?Q?5VZ9qGH2fSOZaF4kwU2N6mi7475mP+cyqqcRSQZ6Uf6hgdDQMwLXIokNXpzv?=
 =?us-ascii?Q?th36SsFKDJ3x0qsP/J3dd90tt0qZlZvjQM3M+R+2WqX3qw22HURj44MpgAle?=
 =?us-ascii?Q?TSr4UMcotMEaGqXENU4Af2LUhLgSdNA5gFzpbnBa8UXxCyw5X8JAqhaEfs+8?=
 =?us-ascii?Q?+aABhBml4pHr71bdjnvXEm82hCKU1feaIZ6CQ2gXy+zMIrn17j2SVS/w/raO?=
 =?us-ascii?Q?UgkWG6ZwF7B5QAn0jVncUXoHUe1kpFsU4gNXmQZaBMBLQa3AYJTuY/unet3p?=
 =?us-ascii?Q?sFsb03zi1D0No52853ABiSspQmbuNR4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VNWz5DFivAj55pTMMCoE/FecPgzRTYDXa7Hx5WfjHmzYf0Ct110PsAzgpj9QZKoXshjeLns2AXcBm6Z81CUzElpjCtproYz82zFUjtQtz+mJHqguc7qMHib+IRaV76zZUMQqqZYrsx3HZur5S3SInf4udl/MXhyTsxYg2h+bAdJBJMW9FjVIwymB8qPwiPw6ndmWaTpZpLANw6v+QAXE+bbLk4rJJeaZkyaurxBHTWnU/rMkyasfFVczCU4sk+3JTUlXYMihiZMkkJrCILVJJzXsz5WfQymUIPYxiaIcE/nRGDrZFG+oz2DWNJjDHSaZGom26EGilZfVrTS5xLLCVQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 155bb553-5572-4f74-1572-08de864db6df
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 06:55:47.1456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r0QMI+3kMBCWzHwBOJ8dsQVYlvl4zuZtgNQAyrLwdpnn8UJX0IQjIxY86Aohcb/k+U27qF7PdNWAC255SP2/0PzvsaK64UL1F6weArqIQQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7409
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269799-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.963];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 637212D65DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Petr Oros
> Sent: Thursday, March 19, 2026 9:53 PM
> To: netdev@vger.kernel.org
> Cc: Vecera, Ivan <ivecera@redhat.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Eric Dumazet <edumazet@google.com>;
> Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Simon Horman <horms@kernel.org>; intel-
> wired-lan@lists.osuosl.org; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>;
> linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-net v4] ice: fix missing dpll
> notifications for SW pins
>=20
> The SMA/U.FL pin redesign (commit 2dd5d03c77e2 ("ice: redesign dpll
> sma/u.fl pins control")) introduced software-controlled pins that wrap
> backing CGU input/output pins, but never updated the notification and
> data paths to propagate pin events to these SW wrappers.
>=20
> There are three problems:
>=20
> 1) ice_dpll_notify_changes() sends dpll_pin_change_ntf() only for the
>    direct CGU input pin stored in d->active_input.  When the active
>    input changes, SW pins (SMA/U.FL) that wrap the old or new active
>    input never receive a change notification.  As a result, userspace
>    consumers such as synce4l that monitor SMA pins via dpll netlink
>    never learn when the pin state transitions (e.g. from SELECTABLE to
>    CONNECTED).
>=20
> 2) ice_dpll_phase_offset_get() returns p->phase_offset for non-active
>    SW pins, but this field is never updated for SW pins.  The PPS
> phase
>    offset monitor updates the backing CGU input's phase_offset
>    (p->input->phase_offset), not the SW pin's own field.  As a result
>    non-active SW pins always report zero phase offset even when the
>    backing CGU input has valid PPS measurements.
>=20
> 3) ice_dpll_pins_notify_mask() does not propagate phase offset change
>    notifications to SW pins either.  When a HW CGU pin gets a phase
>    offset change notification, the SMA/U.FL pin wrapping it is never
>    notified, so userspace consumers (ts2phc, synce4l) monitoring SW
>    pins via dpll netlink never receive phase offset updates.
>=20
> Fix all three by:
>=20
>  - In ice_dpll_phase_offset_get(), return the backing CGU input's
>    phase_offset for input-direction SW pins instead of the SW pin's
> own
>    (always zero) field.
>=20
>  - Introduce ice_dpll_pin_ntf(), a thin wrapper around
>    dpll_pin_change_ntf() that also sends notifications to any
>    registered SMA/U.FL pin whose backing CGU input matches.  Replace
>    all direct dpll_pin_change_ntf() calls in the periodic notification
>    paths with ice_dpll_pin_ntf(), so SW pins are automatically
> notified
>    whenever their backing HW pin is.
>=20
> Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
> v4:
>  - expanded scope to also fix phase offset reporting and phase offset
>    notifications for SW pins (problems 2 and 3 above)
>  - replaced ice_dpll_sw_pin_needs_notify() with ice_dpll_pin_ntf(),
>    a unified wrapper that covers all notification paths
>  - squashed into a single patch
> v3: https://lore.kernel.org/all/20260220140700.2910174-1-
> poros@redhat.com/
>  - added kdoc for ice_dpll_sw_pin_needs_notify() helper
> v2: https://lore.kernel.org/all/20260219131500.2271897-1-
> poros@redhat.com/
>  - extracted ice_dpll_sw_pin_needs_notify() helper for readability
>  - moved loop variable into for() scope
> v1: https://lore.kernel.org/all/20260218211414.1411163-1-
> poros@redhat.com/
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 47 +++++++++++++++++-----
> -
>  1 file changed, 36 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c
> b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 62f75701d65205..5cfa19da099bfc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -1915,7 +1915,10 @@ ice_dpll_phase_offset_get(const struct dpll_pin
> *pin, void *pin_priv,
>  				       d->active_input =3D=3D p->input->pin))
>  		*phase_offset =3D d->phase_offset *
> ICE_DPLL_PHASE_OFFSET_FACTOR;
>  	else if (d->phase_offset_monitor_period)

...

>=20
>  resched:
> --
> 2.52.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

