Return-Path: <netdev+bounces-255931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBT6JLnQgGlBBwMAu9opvQ
	(envelope-from <netdev+bounces-255931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 17:28:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFCBCEF91
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 17:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 342463002928
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 16:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4E33783AE;
	Mon,  2 Feb 2026 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGBLghHE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C979A37475A
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049716; cv=fail; b=hpj+Hly3y9OMCzehKksl4R6nbKWtA3MGc3xitxmvDuChkukW1KbAqzRD1+Z8B1JfyHYSUgxvBElVH14RWlAGVMPbJGF8n7GLrlDGFa+lW8oHsYRFInKvp2586887DVl/H7dTmsmqWW55ykmPgP4o1t+sEeOYIVo6LPulpoGOCJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049716; c=relaxed/simple;
	bh=E8EXxJkFdUks2GMbXS8MeLyrjNOVSZ5JBZ1rjmUe/Ac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fABSxSOODg5MbssttXyoBlLM0iLzAWZsWOUrYBPm7JEsOm+Q2bVXxCuosBghP5duxSPK9g2D1ZCZPWYZUzLTcT1N4ZIW/U4kHKPo9Euj/Ag/ThCb15H9LiEd0GqmsUCmZ1MsZa6fTgCB4sOpp3eGdGu5k61ZKhmM8s8BQ/Zl420=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGBLghHE; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770049714; x=1801585714;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E8EXxJkFdUks2GMbXS8MeLyrjNOVSZ5JBZ1rjmUe/Ac=;
  b=NGBLghHEgsy8RXAtJcaTf2gIjTTy5XuQm8hmIg9foVaZElAOFRr0KE8S
   VF2aLg+3tdqGwwEx9QwEnAkEBJUjMKyt83M+xWSvuHNh/TeVpAsCQwGFl
   bUan4ZqHgSLvl6+4p8iF8x/yFdcnj8EB1q93LrZ3phsCUQsuxuVutsVPR
   Wx0hibl+brqmd4qBexeqOXBsgxoiraCMM6/Yr7ntJSZCJRuyvzbN2kQPO
   VIl4R2Ldt3O2vyf/eR/hEuj2TCoMA1pMngpGBMmw6qehuS+WfIcjCKfcp
   AeQ32O5hesomSkqyCuvOdonyrQNaQq/Y8cJfsw1Dm7b09/md+bqzwYO6E
   g==;
X-CSE-ConnectionGUID: DBKYpAXgTD2g0qD9zzxsjA==
X-CSE-MsgGUID: nOsQtfFcQ4yrNJe41Xjieg==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="70412235"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="70412235"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 08:28:33 -0800
X-CSE-ConnectionGUID: 9iMSMYlCR7yOQCOfAneZTg==
X-CSE-MsgGUID: 3TEtsQMfRfmKfCmv4uQn8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="209055950"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 08:28:33 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 08:28:32 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 2 Feb 2026 08:28:32 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.63) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 08:28:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RyUm6VdR7b5Pl5uyA6duW9y8VQ8JUh/mEpmwZH01CjNnPipVsN8jb+GYCD7LXrtBL7Uoc11tLASMezaKf85DVZI9621AhIluvw2YNpSGqpM+UBfki0H+cAn8V8WUpegAzriVorCzKxW1G5ysUBOwYM3TUejWPptP7Ifr/v1Uk46ZwyE0hN92m+qQJO843837lWY7HyXoG6t5l3NwuV+BbYTeU1T+cyW/l/43byguR3O8Vn98wl3e2SPyEKWAmx0Vkop5ZEPAdSzEm9KGqBmQSeRhbRsZp7jdcxwplqJ+nMjRTLXkpbj3+enSag0uf6AQOK/DH0QFgLC/3JXnU/ncfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hd5CAMtr4BAOnxynVTla9X5dQy/ODg9+uF6BGxFs4Wk=;
 b=QSMLii+TBBKl4YeKMNiDm6FOuKYsvfbIRm15rCOgJFhS/cRDQnlyEUL9YGOMEPG43Lgj+Hgi4L1HgQVnyD/4M0ILE0vPjI/7viydH0Yp93hUxZfH8Br628p7z4QidQn/gml3Ai/rSP1FWwp3y9oqazcbJlW+UkDamBRDbc6EQqUXqXKS9O1Faa0Ohy+TLskcjZMO63SeFzNYfuSN/mJ3tvKF2qCnP+IBwkExfcrueIO6OlAw2yZyTVAXd5wGv0HhyOfYHeZPlIGlp1muv532MOgHy7kiIvTLnj2SGRAEXcutK2Oh5C5PhzF2rQMtT7HOMxztlLXyB1/mj3b1PfIHxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV8PR11MB8745.namprd11.prod.outlook.com (2603:10b6:408:204::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 16:28:28 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9564.014; Mon, 2 Feb 2026
 16:28:28 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Kohei Enju <kohei@enjuk.jp>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Keller, Jacob
 E" <jacob.e.keller@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "kohei.enju@gmail.com" <kohei.enju@gmail.com>
Subject: RE: [PATCH v1 iwl-next] ice: fix NULL pointer dereference when
 changing RX queue length
Thread-Topic: [PATCH v1 iwl-next] ice: fix NULL pointer dereference when
 changing RX queue length
Thread-Index: AQHclF+kUmDobZSm3Ey2MTcTK+PacLVvmRoQ
Date: Mon, 2 Feb 2026 16:28:28 +0000
Message-ID: <IA3PR11MB8986C1D164448943AC89DB69E59AA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260202161826.114393-1-kohei@enjuk.jp>
In-Reply-To: <20260202161826.114393-1-kohei@enjuk.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV8PR11MB8745:EE_
x-ms-office365-filtering-correlation-id: 683cbae8-cfa1-4636-303e-08de627818f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7142099003|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?lxhETAcxJTvIQDm46Rosn6eTMoMjsKcc8T678OaiXdlhHgMClezMNqrjqJ2b?=
 =?us-ascii?Q?YZh2psIGslVn+1OvGzlVPJaVF1hC6os4HMMuBeI+dHGBLIP231mRQvESjZW4?=
 =?us-ascii?Q?zoUamdw24CZL0zzsdFq3fjJcQyvHFaZq2Axjdyv7qRmnFQKZQSzMv5OGYtWq?=
 =?us-ascii?Q?z6hTV5zEhneJecAon4LFaKBJBxWUANNNHnw8PCUkviiHkNDPkETgNGqFFKzy?=
 =?us-ascii?Q?U90/8Vei4lLr42pl0FsrdutXTK3hqxTMnOpmw3kTsQTLP2MogYjsqWOzXQV5?=
 =?us-ascii?Q?QCz0tzU9kbW8e6fRjZxEaWSPsNihOBK3qSAXGX0dXmbN/HFD9951qjB2ITIB?=
 =?us-ascii?Q?pjm371pErxu28LIYdR1k5Bu0NzTe/1ccPJ6bgJcEj1FcVBIZ0zWjyWdUhoCM?=
 =?us-ascii?Q?iD23biDJyQcdo71bvHfqb59XuRwUdy6TsW32yz28Tq0V1wHa2wcmOE5y2xbv?=
 =?us-ascii?Q?DTZyK/MVjuYH9ssirnguS+b3wBHZLWUGIChpvTXq0bHkl0ytZJ5naQgI5xgm?=
 =?us-ascii?Q?sdq+ogo1/dk89nBW4eied3xdmo00fKt5Frqel4d5QLm1Zi71QEsvFxShQ6aT?=
 =?us-ascii?Q?scAM9aQeei1TLABPSDiEgdnALFV43pCbayFjVgPAjEJRN6tcPeDVfC8x3o1f?=
 =?us-ascii?Q?2w/xdsTH1I1qHG5+hMNv1TAvb5RYV7wnP07Y4KlXfLqIiETRE16SVMJUhuUO?=
 =?us-ascii?Q?VGTgQF4GmxV4pELLhV7lN3nnimCyx+aega9GpAx3UqEOoTl9zq6erSS6cReW?=
 =?us-ascii?Q?8ICGbAYynLERPA5aiXbYUyo9KkZF5rgGqyxhng3VEwzVHn1VrJcAR4N0+IJA?=
 =?us-ascii?Q?f7dAwp3NPwWl86u6cNTD7ebUlUQ/L+C8KBTIdrP73sFVoiq1FvxDCej6FpJW?=
 =?us-ascii?Q?lSntalbm8mZDRk3m5V1YWH/DynAgeadbVMZTo+hOl61HLoUZaEtMIl08f2qw?=
 =?us-ascii?Q?VIhGCNECHG7NqMHV1/QF3QiXc6+29vEOuIpu184K9J55SIVHTyAaGkFpyShO?=
 =?us-ascii?Q?F9XozRMvj3zk27p+uKzSU2sxiNGDlkLi9KU6qAbTilKxK8eEJkeHd6Oitcdp?=
 =?us-ascii?Q?PrZyAGCLD1kVhMY3TBLg/f5CeeKXdAPM3vrh3vYWpOaoPmbymrCZw569Qf+i?=
 =?us-ascii?Q?Up5gYprHywZVaVW3jECbNoTLqitrk9D+qSQP26/Ri5+vOC9EhbE0HhtdJ4y7?=
 =?us-ascii?Q?YlSTF6VEVLz3wxtZncb6Lijp8ZlUp9A0T/FJZrlwWK6AbR3534v9g2VsbgFO?=
 =?us-ascii?Q?E46OSW9UI82NsQlZxLlPTxWog4oFo+Bge5uIy8ZJgn1LoncQbW2pqLZrYBys?=
 =?us-ascii?Q?anuYccAcHF6sp+L4DwNamqOYGkhQD7ktboZXolHDhYWUGbc8CuHOGoquw7OH?=
 =?us-ascii?Q?ain9p1fBUMe4ytJM79U3JjhulXbVsavMvgpOCpcCsH/crxATIgoo1bcB131a?=
 =?us-ascii?Q?NINTBgABN4JzpwL9VeZsMjEge5oQkQX8M7kQxwRtC7moDhaelwIKQh4zMcWd?=
 =?us-ascii?Q?4U0XLj0CxeHBJ4eX3qc29M+KMQtsZAQSgxElP3Z94RfSRTJfoYvoaxRWEtPp?=
 =?us-ascii?Q?1YTREnTW7eIsDQM3McndxYiXwxIFkMNvKIbRvCXtHEn+/+/F5+kYvLdcYwNh?=
 =?us-ascii?Q?4cmJEEjCcaj6j/l2v8/Sxws=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7142099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oFJMcdaavdK+LAbGdKbIPiwO62vfsbp03xIXMT4b2mAIejNHUN9povRGUu8k?=
 =?us-ascii?Q?z0wchYIC/kVeyEZdZk1J22W1oxKFDgoZh7nwjHB8CRHanbFCL3+g7tf1mRmb?=
 =?us-ascii?Q?rDwsOCP4Ijl3qNu9coBbLYvgmIAKln8kNhAnz4jwYYJBr8ndLg4Qc7Jj+7SG?=
 =?us-ascii?Q?SuiHUzKEGMoKX3BiTKeGqEgrUGmTwFv+dWZmtjJZAdX55b/W9hnQREV2TZbr?=
 =?us-ascii?Q?YTPEgmpC/d42YtkrEQIfUa1D7SILgd8fHwwQ5hOJ1KK503FvCmTG1qtnR5q9?=
 =?us-ascii?Q?6CQsiWEuOItYIxBHcVaPugirFA+w0YcLczaO41I+pxj/U+dOSN5Rocv37f4v?=
 =?us-ascii?Q?v6reM6D6DBFqLCPMxImi/h2LQSpOePNe2pCpBGN2w82dUQ2vHpJSNyQOlPz5?=
 =?us-ascii?Q?qKSRcUtKpl9R1vNLf64ky1biMm7RuWFjv29GcSACBxT8HI+6Cv3EzEj8DB1K?=
 =?us-ascii?Q?77aFwZv0jqT979INhXe7/lWnVQ8c8U9REyvWKO4QT9HAMoBOZVKJ2KyPrt/n?=
 =?us-ascii?Q?M+N8BakHbqFw3MWFwamktS8DVBA96O4fqO3+n7dmP3x7aK3XibneZ71DSBOx?=
 =?us-ascii?Q?apuWb9XfnpFVJ85O/rfbOnp9RZOolaQQ5seQ/5KtT7X2ed/iSOTJBwPLGOzI?=
 =?us-ascii?Q?7BKQ17tK0c8K5RJn2CNv/ht7N+TT4vGpQi0Zi/j4qXE4ODpF8/rKSt5k6uH1?=
 =?us-ascii?Q?VAdiqtThD9/Z9hw8exJh/qjRnusMJZ1/Bb7W3xcP3sRTfzVxVG5a1WaFxx9X?=
 =?us-ascii?Q?11Oj4KKzukOrmtT/DkjCnlNmqzDva7ru2FGufWFV5eB5I8jEsHL/t1f3XrRO?=
 =?us-ascii?Q?m5oMfP8pCk3Sp7+p/UFjyQOqKd0cPwe16TDeYY601kNi+Hw7laKRO9Pe1XV2?=
 =?us-ascii?Q?gxrIxnX6axC0cLrBvaRrNdhyTJMqk3rhBiCtJo5SNGBhqtLXujAbBzbJdHYi?=
 =?us-ascii?Q?i8FmAy3AyOg2OSrSHbkna4dvFLgOOL6N3njgCqBGrBNy6JF3SJpPWl5wy/jl?=
 =?us-ascii?Q?Aoz+5f29p9DSG0HH0SgH6vzMecrCl6u4zVWXLNsyoK6JEhU9pE04999IV24v?=
 =?us-ascii?Q?ekOtd8NQIhD00o2V6zIpuOm8EfYgQQH8iAhu5m+RvJH6rRBQNlRyAAGYav0E?=
 =?us-ascii?Q?Wml39PL7ieU8d1fPqVFkwV+u/Jyp34U+Xvk3vTPelWDLIJaRnUeNp9O6bQ36?=
 =?us-ascii?Q?0oI+DRWgdIBRPMMtFIKGJCHw1k22OCcV78T0tbHibV1jOqfeieYl8iYKd1uQ?=
 =?us-ascii?Q?h6Dhworb9uWjXXD0X9b0MuWFvjwA6OeXaY1KMyWOk4baLmMyseWO6UzqW5rF?=
 =?us-ascii?Q?Lh9NGVWgKua9LSysSWoVTbSUzD2uj6Is7ED2w0uUKDNduzU5655uj69HdV9i?=
 =?us-ascii?Q?SbFbHzXFf7/4PJx7TxP4/tI3xXn0Otec5qs/2Uy6i5SJP3RtO1GUqHFggCJC?=
 =?us-ascii?Q?msB9hDhocgSzy1smvP7yU52ZZiyiXyD/8byNJ8vMd6sxxVSyT59o77MIFz9x?=
 =?us-ascii?Q?b0IXytMkuYpJyoU57J7A2PtuhWUBeftOdcxs/EIXerTGduDD+mQl0cEue2sr?=
 =?us-ascii?Q?zapsR1PU2OPImCewOGCpMxyRG4FNmhdaSMY8NfgYkYmhgkvPOJ/Tpx23ayBu?=
 =?us-ascii?Q?4pN/w9/FSuuwGtvnhoro0Hf0r5ja0iL6UZhggGsSVNYl78Ul9ei1AUnqxCHq?=
 =?us-ascii?Q?2F7INSwoadCL1L3Ogun6zAk8HtuhBnOjPPJMNEEgjd81iBHNyJQI+8G7youo?=
 =?us-ascii?Q?erxH+uzKaT7V/DlKmCFIeVy7VPw8jNg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683cbae8-cfa1-4636-303e-08de627818f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 16:28:28.7197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x7wLrwbte4rTz0y3ii8h33VnQ94S5UoKKVdoXTgWCgX1TP5BwXEKGQtG9tlhsMc5nichyGyj2l9As4Df6cZcYBVvDSGqYJZJAHxAE0dZJOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8745
X-OriginatorOrg: intel.com
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255931-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,intel.com:email,intel.com:dkim,enjuk.jp:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,osuosl.org:email];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 9AFCBCEF91
X-Rspamd-Action: no action



> -----Original Message-----
> From: Kohei Enju <kohei@enjuk.jp>
> Sent: Monday, February 2, 2026 5:17 PM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; kohei.enju@gmail.com; Kohei Enju
> <kohei@enjuk.jp>
> Subject: [PATCH v1 iwl-next] ice: fix NULL pointer dereference when
> changing RX queue length
>=20
> When changing RX queue length via 'ethtool -G $DEV rx $NUM', a WARNING
> indicates the driver missed unregistering xdp_rxq_info [1], and then
> NULL pointer dereference panics the kernel. [2]
>=20
> The following sequence in ice_set_ringparam() triggers this bug.
> 1. Allocate new rx_rings
> 2. rx_rings[i] =3D *vsi->rx_rings[i];
> 3. ice_down() unregisters vsi->rx_rings[i]->xdp_rxq 4. ice_up()
> registers rx_ring[i]->xdp_rxq
>    a. __xdp_rxq_info_reg() sees the copied state REG_STATE_REGISTERED
>       and calls xdp_rxq_info_unreg() to fix it [1]
>    b. xdp_unreg_mem_model() looks up the stale mem.id in rhashtable,
>       which was already removed in step 3, causing NULL dereference
> [2]
>=20
> The root cause is that struct copying includes xdp_rxq_info which
> contains registration state that should not be duplicated.
>=20
> Fix by clearing xdp_rxq_info after copying the ring so it starts with
> REG_STATE_NEW instead of the stale REG_STATE_REGISTERED.
>=20
> [1]
>  Missing unregister, handled but fix driver
>  WARNING: net/core/xdp.c:182 at __xdp_rxq_info_reg+0x89/0x150, CPU#4:
> ethtool/1105  [...]
>  RIP: 0010:__xdp_rxq_info_reg+0x89/0x150
>  [...]
>  Call Trace:
>   <TASK>
>   ice_queue_mem_alloc+0x159/0x240
>   ice_vsi_cfg_rxq+0xc3/0x160
>   ice_vsi_cfg_rxqs+0x4f/0x70
>   ice_up+0xd/0x20
>   ice_set_ringparam+0x34f/0x4e0
>=20
> [2]
>  BUG: kernel NULL pointer dereference, address: 0000000000000008
> [...]
>  RIP: 0010:xdp_unreg_mem_model+0x113/0x340
>  [...]
>  Call Trace:
>   <TASK>
>   __xdp_rxq_info_reg+0xfd/0x150
>   ice_queue_mem_alloc+0x159/0x240
>   ice_vsi_cfg_rxq+0xc3/0x160
>   ice_vsi_cfg_rxqs+0x4f/0x70
>   ice_up+0xd/0x20
>   ice_set_ringparam+0x34f/0x4e0
>=20
> Fixes: 111a8e2be488 ("ice: implement Rx queue management ops")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
> I see the Fixes: commit exists in only tnguy/next-queue.git, so I'm
> sending this patch to iwl-next, not iwl-net.
>=20
> Also IIUC dev-queue in tnguy/next-queue.git is rebased continuously,
> so the commit hash will be stale soon, and I don't know how to handle
> this.
>=20
> I'd appreciate it if iwl-folks know the way to handle it. Thanks!
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index ddd252fb1124..e4c286a22ff5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -3338,6 +3338,7 @@ ice_set_ringparam(struct net_device *netdev,
> struct ethtool_ringparam *ring,
>  		rx_rings[i].cached_phctime =3D pf->ptp.cached_phc_time;
>  		rx_rings[i].desc =3D NULL;
>  		rx_rings[i].xdp_buf =3D NULL;
> +		memset(&rx_rings[i].xdp_rxq, 0,
> sizeof(rx_rings[i].xdp_rxq));
>=20
>  		/* this is to allow wr32 to have something to write to
>  		 * during early allocation of Rx buffers
> --
> 2.51.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

