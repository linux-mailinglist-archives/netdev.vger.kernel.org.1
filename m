Return-Path: <netdev+bounces-149758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7D79E7496
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 16:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A913E28317A
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 15:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D487205AA3;
	Fri,  6 Dec 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QAL5l/Ai"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D268198E86
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499694; cv=fail; b=TW7BjdS47Bj8EqOTuN+lde4Mz2Cf/oPBFMd0pyhVJWaq+HUJ0+haFkK0zCGG2xzF6B0weVaQG5bGp9vPvbScl2J2yVILUZG3yGLQ6h981LTEVFcJBUcSrjMKw+s8PMWYlF+lMXD/hMyIo5UiVUKA/mGacDTCwp7PIVsft3Sgdes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499694; c=relaxed/simple;
	bh=mQoeI3Dwu9Cu0BWzcrq0bdTZV41+cXkAOWFSjxsR2Ss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lqfrrU/qFgzLMpbyZXhiJPc03INlQvje3U5at+fJSGV2kziyzzpMYyjcyMP9XvC7QgwbtP3lDtjbrePNCIZ+S+3cC0MRyt6znuDZm5d8GFF/26LW0bmHVhqXIWTgQyy5Qg4w9HwrLyF4vkv8uNaUg70HnoDbbn14WSw77B/16AY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QAL5l/Ai; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733499693; x=1765035693;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mQoeI3Dwu9Cu0BWzcrq0bdTZV41+cXkAOWFSjxsR2Ss=;
  b=QAL5l/AidavBXd2i3EIF10+fz2Hs1leHPTbj1PfQWxuuZhgkOBtn67xr
   GZFjsffNiVyJPJm42YQ+FbLVZ61xts95b43OwXJFilDyT8vhSxlAfU45e
   bXUmDVAHWMEhbfPWyhc6YsXaqrx/49M/kg9MpZ5mXv0RTTXXeIHxJ1VuG
   xOF9icTzzhDlPMzogo/3FPc3/OxrYGXpQ58bqPO+xq1Sfnx3j7Vphg6EP
   I54vhyrCwsJDrhyuCp90bYfsiqVbb575Kp6WRw1+/4MFDk4BMewTpXqg3
   4mNLjCsXIJGETinppCBL5fhBKMo5wKV27IdoknyExHjSQp8bRzfQYGXgZ
   Q==;
X-CSE-ConnectionGUID: Q9Fb7rt2Rk2/+pf9QFT83Q==
X-CSE-MsgGUID: NXCNeUH/S6qGa2aXRr28TA==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="37533623"
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="37533623"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 07:40:56 -0800
X-CSE-ConnectionGUID: s1md13aJQIOprLCnHRSnzg==
X-CSE-MsgGUID: Vlk2IvXQSTSU/QsjyvNLjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="94532917"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2024 07:40:55 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Dec 2024 07:40:55 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 6 Dec 2024 07:40:55 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 07:40:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1/kHdWCDpJUrMqiVJsSxiFWILivXP9DmvSPNA/oc/AUSpkYCwAnU6M2wL3/TkcxxvQgwfjQ1w9M2tzMVWahM6duiIWZ43PGNo69n+mTVAwizDEQrnZtXS3zBknOMMNF/z5Ni7ZhQN3oCSq2lP9VmV9hTXQ6S+6nlHh4Sz90c7PQKC+abApswkviIheCEK6ODZAN1HE5H455FAiQQJD5zAWj+H+mG5nUWIUP/U5kUGFhnvH2Iz/SDm5yT6hU1q6ZWeOoByyXTbrFPkBLZqJyvG/7Y0+1ii6GPHZzt8h7szSoKIoxc5wp4yQpdRkWmH8DtWZzrOuH9yFIJkAuQLmlbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQoeI3Dwu9Cu0BWzcrq0bdTZV41+cXkAOWFSjxsR2Ss=;
 b=L0nGcDp1yjkwf85MRHzfFaHvMxiR0XxfE/kHl13b/4RPmSe0OJdMsbnjqW1JiwGQIXHbHNJT+ykstf+ML6FUTRfeqFTiTHXaH/icRneuQ0tPhUGygXUkq8/SAJajipe83UYztI/IZ92KwNC1elxSKzGFrfslkpRKbBU+uXznEqkLov1XDqjH4K8i7qpNJ5NZ4mK3DUFaHxwyYwGBp5/FhOWNQNPr7R9o8CyK3zvHt/fHMh1rxgGF/HJlYcZ4bwi84BbCzKto4CG0OHtz7cVrUTaa1B9EctecBKFt1ytdTKnf4XZZFTkCmb4kMcxDWTbukPSvR4xv7cvPwbDdTQu0yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13)
 by CY8PR11MB7082.namprd11.prod.outlook.com (2603:10b6:930:52::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 15:40:52 +0000
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5]) by SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5%5]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 15:40:52 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Sokolowski, Jan"
	<jan.sokolowski@intel.com>, "Connolly, Padraig J"
	<padraig.j.connolly@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5] i40e: add ability to reset
 VF for Tx and Rx MDD events
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5] i40e: add ability to reset
 VF for Tx and Rx MDD events
Thread-Index: AQHbN5aWUmuwoFdm2UiMYg97BZsb77LZevqL
Date: Fri, 6 Dec 2024 15:40:52 +0000
Message-ID: <SJ0PR11MB586584A7DD6C2BF831B358418F312@SJ0PR11MB5865.namprd11.prod.outlook.com>
References: <20241115194216.2718660-1-aleksandr.loktionov@intel.com>
In-Reply-To: <20241115194216.2718660-1-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5865:EE_|CY8PR11MB7082:EE_
x-ms-office365-filtering-correlation-id: c827e8bf-d3ef-4833-9f17-08dd160c5d92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?6SuhbRQhyjeSSHmSJ+6GfxRzeC3+XLcBHa3t8cCt8NwWIbWv2mwtirsxDO?=
 =?iso-8859-1?Q?xGvLuvQKVU4o5sgRWd0gJ/KVT32BNi6puor/u/mADC6sKg2tDAKY7QcFwn?=
 =?iso-8859-1?Q?vTE7O5KkHSFzQdpjHJv7yqVVs9GWCeopc5Dbi6O926A3x7vhEQaG3TuRLO?=
 =?iso-8859-1?Q?EyFkteuuUSZBxkGezg3S9tclbcz+r7Q41Nm4ak9JykNIuQYQxUvtyrdtz1?=
 =?iso-8859-1?Q?Ldn2IwpxtLQkETThPDOePXit3ZTwZ2lLiDWWld3dIx11cYTbSb/noB/JPE?=
 =?iso-8859-1?Q?189H2AjQkwN/jpH1vOx7Tz6CguHPSF3/JkPex6qvnMaf0ug6pi4haLJhJ5?=
 =?iso-8859-1?Q?aKIoU2jDALfGLqKhyGMLX6SjQq8TYgi85s/lgIrB+HmGRHsQUg3n52gFLt?=
 =?iso-8859-1?Q?ix9MUv9lv/jWNRFdbaeK93thL0FKyl86Y479xUiJe5OY65gdfhdDv3v5Aq?=
 =?iso-8859-1?Q?AyOd5cea3MH+vJ67VHfDJmYFM8sF7si6RGNIQzOB2rYZS7QX4R/Il/GASb?=
 =?iso-8859-1?Q?K1MGCiaNXFrh6/0AER84e8BWrT5xcJj/WMXXwEK9Y2TWrJ9U0+S5TjlEmV?=
 =?iso-8859-1?Q?apj6Z5pwP+5EU1XIHFaOEbY+4wBLbDxb3wEUzoj7NtzUBR5rih25TaaEP6?=
 =?iso-8859-1?Q?BRnL9yDGVNvXlSAQMJhCBzMt+MZS5cGiCgriYLi+E9AUoDlZfecgZWMX0q?=
 =?iso-8859-1?Q?pGpW+HEo4phGaVaElvDhJazzBOTnW0CtKmHjLFsTB9IjqVWYi5yav5pIjC?=
 =?iso-8859-1?Q?HDNNG2L+sIOc/B2AofWFiZiCY7cfiOTG7spbChurDZ/LLe6c8WHQe79obg?=
 =?iso-8859-1?Q?9HiD8aeQz13mBIwYKp91ztxgK1Y03R51GZ29RhoQ7RTvcPFs/H0RnYpT6y?=
 =?iso-8859-1?Q?lrM4I2SbcSKI+s8bNte+81h7Ko+P64dbsvpXS7mIEgDShiuOAZZWwmGZkF?=
 =?iso-8859-1?Q?4fCjB5OKaGmk6QKWiyFW2bc+IrSDBrzPr1CMCNv6TyAsnu7jb/pvIZBGdQ?=
 =?iso-8859-1?Q?ilMUs3eDSx/AgMfSw6Fs+cZ6yhC+w/CLAZRON0UtzcqciVQ5rwGwZXuBWt?=
 =?iso-8859-1?Q?EGsoPHWPSinIbgLpiaGBy6B2UMWMXuI03C2PMKBJHlkdfsL/fBC0w2UkIG?=
 =?iso-8859-1?Q?/TYjMXLbRShiiFTbKyRNlanXZPnPykpkLavRBiGdyfIwTP85c0mgGLqn/G?=
 =?iso-8859-1?Q?u/t30qnVc8aiTDzGXpVvOGla4AtfDn2Rv1hJXplu+EHneV7Tq6a99JbnqU?=
 =?iso-8859-1?Q?R00M9ljSlesGaffvvEglE7BDy4kwmQWZOYeVn8de2Z9+hTbSeRTyRels1w?=
 =?iso-8859-1?Q?LNBiNapDKtjkoXCMzJqCdXmEgAk31YSF7BHeTXBC5KoNGp/VCpKt4eE/iw?=
 =?iso-8859-1?Q?nhK0Rq2mBWSsgbMSgWVoA/Jh7kJtX4/ltNNJ6u2h/8Z3TV1zlJYGzFu/op?=
 =?iso-8859-1?Q?CD3eGyghS5yOHsf8nFA1YaNkH67LYBnU8azMXw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mX6ecN/yid6qbgY/REDcmFgJutwzyGmx1rc9Qz9oCsMVwPU03JxEW/3pKz?=
 =?iso-8859-1?Q?QL/uBIdpQNDjFclosvKjRn/LiUpCvXnFPnaglLAtM4JdpaEBsuOi0IKiMz?=
 =?iso-8859-1?Q?HQUTe5Mwy4Sja8n5379zzQWoV/mXmjCNKohaewidI/e/Ry/QSpduMC6b0+?=
 =?iso-8859-1?Q?J3P7A9EO8+RnfAhKD1JlzCQ2e16h8xilG/xSQll+ZcsLb/LbZyoy+vafcW?=
 =?iso-8859-1?Q?/iqtT1OBA5hNZ3B22eJ0DHfXWqiUcyanpTvpym3fFsWH/vIBWvQZdvCmCw?=
 =?iso-8859-1?Q?3o2gzyYmdGb6H5A6u1FCdtp7/NUT1d1qf7ljuMnGApE9AlqOXmIxenDL+q?=
 =?iso-8859-1?Q?rVJANICJ5NchtoUrTpKAlBe9Q6I2EUJ945XcWQgV7fsFCk1i8PgQoh1kjP?=
 =?iso-8859-1?Q?eq+GlA5mw8dXtp5JPm7cozfkCal1daVgVdNlIYv0VnpBxrgLA/3vCBcjzx?=
 =?iso-8859-1?Q?kkrIMddeqGFYC0StZN9FqC6/Ui9Mf4u8AEl3SdbvZLEJvVhOll8O0DjYqS?=
 =?iso-8859-1?Q?K1USGWwuBRni8mFRMmoTvJyrJUxRA1hSe7S6ssha29VE2qheVaAIicv8us?=
 =?iso-8859-1?Q?d/rudKSjlB1KWo3+r6dlyTO2njD3Lrc8HUQEw9B32PF7yGEIb9z3f5kEY9?=
 =?iso-8859-1?Q?B31MFtZwjiiGTUtUrCHVqqEqCD+0VNXKZLXOz2T2NvN32HwF9klDczGqLb?=
 =?iso-8859-1?Q?wbxpF1QjlE2cCjhKmnPW+MHXghN7bj7UD11IFwZx/WCmM8pW5aWiZVfsVw?=
 =?iso-8859-1?Q?FjGCwpaq2tZrrRPLL8kTWL+JBNv3nfUaDzwayxCcVRZppVhPWEZm/UTEGN?=
 =?iso-8859-1?Q?RmDL3frcshntWOM2qYO2opsGYTe5Z9IEs79Xd/+lTi4LzJfOVE7bfYcFJy?=
 =?iso-8859-1?Q?yx09JQfhYJi5Cqcy135YmTuVetR5vYHp0DmRdgHNj0hr3R/hYK1HhVMG7D?=
 =?iso-8859-1?Q?w8E3vjrx9lP2n/2dlxUZAsjdVkcqu8F6RFiYzaxd6O2hKEeqIJsRT9H+ux?=
 =?iso-8859-1?Q?CNvvQyJMXC4GHCKjjCdz10T6tcQmaTAv2npegudAoDhLrcJBVRA0ovh9ww?=
 =?iso-8859-1?Q?yl3GbDn3Yxlm24Dh78BmMvGHlTWxgzhfkKwwpsvSu37p1AB+Q1UOg6lQSr?=
 =?iso-8859-1?Q?YI9l7V6diQcUsU27Q9DT05lelGisKUm6oqxCvN2KAUp77e9j3Mfr820Kml?=
 =?iso-8859-1?Q?rCJ56JvChHgOcO1jPhrIOf8RVUWyMpsz5CESt2OBBlK2NoQJpZr1NxYUEd?=
 =?iso-8859-1?Q?aAGpjF9j+GBpwpS5y0fRml+Qh5P7jkmzE1avajOrGNO5Zs+WjEsrGBhDns?=
 =?iso-8859-1?Q?Np2JozgwOLd8iZrFKvnrx11FaTbSGQGzD/dHDKPL0mbrQ5dYJob9DAMQWR?=
 =?iso-8859-1?Q?0tpTCJ83/bEjFR4xL2fk/Pa/gz4vRy6Ptshef6/nxsPEZnMQE6Vn2sDirf?=
 =?iso-8859-1?Q?+q9v04iaHGDNq4jQnN21kKI73p37W8R7tDWrm8PpEjr7P2tTJ/Zfeuh+QA?=
 =?iso-8859-1?Q?VW2yGPogLguucAB+Ac1L2qD98B5WLvIhzE9PldMWHLube9H5vpyUUy5kUn?=
 =?iso-8859-1?Q?OzVqc+pxosS6lR+t4HCh1CNYdAWLM1wpHghC5dMA0j3mp+JBSzQFxiiJAz?=
 =?iso-8859-1?Q?lh2AsAK2YuOnco/I39poJ3rNhQ8Oe6obc8sM5Vw1vR+rzmJI6AImNgOA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c827e8bf-d3ef-4833-9f17-08dd160c5d92
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 15:40:52.1517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/mBAWYw/ZSQcfbOzWsEfKpJVtZMLV+AFa4g4fRLE+2tDTEQJ8I5fIbW5+1HFoSY2qJ1O5J7KRhKEMjDA2wUViv7hLQRqeNsr7VLObxH7jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7082
X-OriginatorOrg: intel.com

From:=A0Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> on behalf of A=
leksandr Loktionov <aleksandr.loktionov@intel.com>=0A=
Sent:=A0Friday, November 15, 2024 8:42 PM=0A=
To:=A0intel-wired-lan@lists.osuosl.org <intel-wired-lan@lists.osuosl.org>; =
Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Loktionov, Aleksandr <aleks=
andr.loktionov@intel.com>=0A=
Cc:=A0netdev@vger.kernel.org <netdev@vger.kernel.org>; Sokolowski, Jan <jan=
.sokolowski@intel.com>; Connolly, Padraig J <padraig.j.connolly@intel.com>=
=0A=
Subject:=A0[Intel-wired-lan] [PATCH iwl-next v5] i40e: add ability to reset=
 VF for Tx and Rx MDD events=0A=
=A0=0A=
Implement "mdd-auto-reset-vf" priv-flag to handle Tx and Rx MDD events for =
VFs.=0A=
This flag is also used in other network adapters like ICE.=0A=
=0A=
Usage:=0A=
- "on"=A0 - The problematic VF will be automatically reset=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 if a malformed descriptor is detected.=0A=
- "off" - The problematic VF will be disabled.=0A=
=0A=
In cases where a VF sends malformed packets classified as malicious, it can=
=0A=
cause the Tx queue to freeze, rendering it unusable for several minutes. Wh=
en=0A=
an MDD event occurs, this new implementation allows for a graceful VF reset=
 to=0A=
quickly restore operational state.=0A=
=0A=
Currently, VF queues are disabled if an MDD event occurs. This patch adds t=
he=0A=
ability to reset the VF if a Tx or Rx MDD event occurs. It also includes MD=
D=0A=
event logging throttling to avoid dmesg pollution and unifies the format of=
=0A=
Tx and Rx MDD messages.=0A=
=0A=
Note: Standard message rate limiting functions like dev_info_ratelimited()=
=0A=
do not meet our requirements. Custom rate limiting is implemented,=0A=
please see the code for details.=0A=
=0A=
Co-developed-by: Jan Sokolowski <jan.sokolowski@intel.com>=0A=
Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>=0A=
Co-developed-by: Padraig J Connolly <padraig.j.connolly@intel.com>=0A=
Signed-off-by: Padraig J Connolly <padraig.j.connolly@intel.com>=0A=
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>=0A=
---=0A=
v4->v5 + documentation - 2nd clear_bit(__I40E_MDD_EVENT_PENDING) * rate lim=
it=0A=
v3->v4 refactor two helper functions into one=0A=
v2->v3 fix compilation issue=0A=
v1->v2 fix compilation issue=0A=
---=0A=
=A0.../device_drivers/ethernet/intel/i40e.rst=A0=A0=A0 |=A0 12 ++=0A=
=A0drivers/net/ethernet/intel/i40e/i40e.h=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 4 +-=
=0A=
=A0.../net/ethernet/intel/i40e/i40e_debugfs.c=A0=A0=A0 |=A0=A0 2 +-=0A=
=A0.../net/ethernet/intel/i40e/i40e_ethtool.c=A0=A0=A0 |=A0=A0 2 +=0A=
=A0drivers/net/ethernet/intel/i40e/i40e_main.c=A0=A0 | 107 +++++++++++++++-=
--=0A=
=A0.../ethernet/intel/i40e/i40e_virtchnl_pf.c=A0=A0=A0 |=A0=A0 2 +-=0A=
=A0.../ethernet/intel/i40e/i40e_virtchnl_pf.h=A0=A0=A0 |=A0 11 +-=0A=
=A07 files changed, 123 insertions(+), 17 deletions(-)=0A=
=0A=
diff --git a/Documentation/networking/device_drivers/ethernet/intel/i40e.rs=
t b/Documentation/networking/device_drivers/ethernet/intel/i40e.rst=0A=
index 4fbaa1a..53d9d58 100644=0A=
--- a/Documentation/networking/device_drivers/ethernet/intel/i40e.rst=0A=
+++ b/Documentation/networking/device_drivers/ethernet/intel/i40e.rst=0A=
@@ -299,6 +299,18 @@ Use ethtool to view and set link-down-on-close, as fol=
lows::=0A=
=0A=
=0A=
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>=0A=

