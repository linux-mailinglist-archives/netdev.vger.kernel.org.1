Return-Path: <netdev+bounces-303779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g6MBGE1KRWqb+AoAu9opvQ
	(envelope-from <netdev+bounces-303779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 19:11:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F9E6F0331
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 19:11:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=BZQxwqBB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303779-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303779-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F4D1300D90B
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 17:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D621386559;
	Wed,  1 Jul 2026 17:10:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940A4363C51
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 17:10:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925858; cv=fail; b=cP/o6s4cyX+HVRzf3pHlqbmruRC0ySmgX4K5ZYI1dwrkZomCaowGJhH5mwk07qKQXTMdGGAi1Q28kVzYS/ar31ieLVf1wnr4mIPiE6yGwwYHZa/w065FIfZsiG047QldJwgnRuhfWIK/GMFF7rA6fIyOetx0HorktVzDNrp4En0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925858; c=relaxed/simple;
	bh=hNyacgL/KJ21xcYk/hPbcrnUItjR+lqoXq/yfBM0VNs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iBWIu9B91H8m5i6Z9wvtUkn6qT/8WEChyxs5bUBPOTE3vUuJF0FxDN9MG4GAbKGYCp+IrOvL222rK+Pz7O92PHAUjd6UyAsVUMVDVGvna9puyAepBbieJLQohoGhTQOcYTWn92Kp3bNd3lA2numXpDQLBFKIq4VSDnSK7SszLfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BZQxwqBB; arc=fail smtp.client-ip=192.198.163.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782925856; x=1814461856;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hNyacgL/KJ21xcYk/hPbcrnUItjR+lqoXq/yfBM0VNs=;
  b=BZQxwqBBYn0HQYG3TinN26igvfx3+xjjURwJDVVmrBV1Fv9JSIzreU0x
   DLgERejIB+Ruw9ekmR7AMiyKjzoahVAPjwyyynrIUO9aHx7Da6FX1EAcb
   IZNYwXO6nHrL6V9n/SafCugH10JDXKaGs4/la5uUD9XxzhaGKQZv/lDRJ
   wZjuDsOfRih/W6aGTzUDuWwk90SUGWkTnDzIiQMmqljGqbrYgidmDLqGW
   BmnA5dbHejuYZFp7zJKJ17kpapRXEWzFpaUPkuWrI60hSPPH7zYuOKffl
   UUwvizORVhRFS2tUK52F50xBxp50cnCHGTg9N+LP5CGh2htqyn552Yz6H
   w==;
X-CSE-ConnectionGUID: 9Eg/I0CMQx2LEVmAvYO4cQ==
X-CSE-MsgGUID: PvKQhdWJQ7SvD5ol1VPoMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="94320474"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="94320474"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 10:10:56 -0700
X-CSE-ConnectionGUID: hIvXan+bSDSQNxQyUp+mRw==
X-CSE-MsgGUID: TTDKgbHHQHuhzqKNA95nvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="290737462"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 10:10:56 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 10:10:55 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 10:10:55 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.59) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 10:10:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfXr1MAa4qTgt+WAzkfMAZVoPP4jcgIHUylw5nYyEhPIuZh8Xue856gkF8aKHx+NBd+AzSExXgnp3b/Bm86ygRyDtrHhbMF5UunjDgIwfBgACaRzZWM+O39PzCH67KAgZGXlWKXQ1iVuA8ykCf5t1gphTuufYxbvcwr+6NwRVAu3Lxa24NcbIDuV86LvMZUuYvfG8dIXhOoUFJ9XphusF9cbEcMEdd9uvhoKBnqld3s3y1tzKUZwsy9SDhxGN0yYLtzpNxt2F4qcOWNQ0E32FrVD7gS8RAy823rx0M/u33EZKN93ESptHKgrKvivrOzA7XVR2jx0L9+jbJYt+lLjxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/tvfVMjEigzn7L9NvHeGo6n8qCsyxfT1vbBxwi4KFE=;
 b=oZigytDEMK+m8uglZOFwrc1jC7Duc5SrI8ltAg7zzvj9pkNKwlc9Eii6RstjWIXz2n9ZfJe4AaZ80jAOI9dYNMisivzW5uOX5FrpAowX861DdJ9b2aaUaS2GvqjoqfHtZsZ3PUW2y3Y/Iudw7yPVpNFpU4FSmLk7CbgU+X3A/QKizgxpTJcRKufCs6smPj/yhxgDIYcSevSa1N2HDW8pGtKSA5uwv6fayIBv6vzILmHNG5Sj6ZlN/lXfpeR6dZmhugIG8PLWG9XQZSLs1wHGEtxdE10JnXfcYGfvVxYaqZeCe8IGbksV7R406uM2FDm8ui5/asL4Yk0/D04yvqD+1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20)
 by DM3PR11MB8758.namprd11.prod.outlook.com (2603:10b6:0:47::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 17:10:43 +0000
Received: from SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde]) by SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde%2]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 17:10:43 +0000
From: "Das, Shubham" <shubham.das@intel.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Alexander Duyck <alexander.duyck@gmail.com>, Lee Trager <lee@trager.us>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "mkubecek@suse.cz" <mkubecek@suse.cz>, "D H,
 Siddaraju" <siddaraju.dh@intel.com>, "Chintalapalle, Balaji"
	<balaji.chintalapalle@intel.com>, "Lindberg, Magnus"
	<magnus.k.lindberg@ericsson.com>, "niklas.damberg@ericsson.com"
	<niklas.damberg@ericsson.com>, "Wirandi, Jonas" <jonas.wirandi@ericsson.com>,
	"Srinivasan, Vijay" <vijay.srinivasan@intel.com>
Subject: RE: Ethtool : PRBS feature
Thread-Topic: Ethtool : PRBS feature
Thread-Index: Adz5hWg21MQs/VUaTJGfYpUI2lYKsQAM6bGAAOssNkAAEWE/gACW3a0AAAT6GYAAKCJlgAAB15QAAGW4BSAAJtcogAAPdBwAABO0owAAG26fAAD6e9ZgAAPKZQAAFsd4YA==
Date: Wed, 1 Jul 2026 17:10:43 +0000
Message-ID: <SN7PR11MB81098D82A7B377E0AC439979FFF62@SN7PR11MB8109.namprd11.prod.outlook.com>
References: <SN7PR11MB8109C173933D08F994FBB084FFE22@SN7PR11MB8109.namprd11.prod.outlook.com>
 <26971635-b13a-4ed3-b2cb-ce35da9b63d3@lunn.ch>
 <SN7PR11MB81096CF160930DB8FA278B3CFFE12@SN7PR11MB8109.namprd11.prod.outlook.com>
 <be5c474b-c969-49af-8235-825580ee945c@bootlin.com>
 <SN7PR11MB8109149608172808784CDCBEFFEF2@SN7PR11MB8109.namprd11.prod.outlook.com>
 <5f22c491-b816-421e-a531-bf87a07fea70@lunn.ch>
 <08f1b0c2-2b09-4c30-b95a-02959d409a03@trager.us>
 <38359a70-ebc7-49c5-bae5-0d3d7bf82fac@lunn.ch>
 <CAKgT0Ufpp+AVrW4raMw=_PEWQdu+dkp+9xhrt1se2G7=CS83iA@mail.gmail.com>
 <SN7PR11MB810921E7DA70DB3F6FD1C41DFFE82@SN7PR11MB8109.namprd11.prod.outlook.com>
 <6e905826-779a-456d-a37d-7602a37ab6d7@lunn.ch>
In-Reply-To: <6e905826-779a-456d-a37d-7602a37ab6d7@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB8109:EE_|DM3PR11MB8758:EE_
x-ms-office365-filtering-correlation-id: 7851ef8d-342d-4abc-0c52-08ded793af29
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|23010399003|22082099003|38070700021|4143699003|5023799004|11063799006|56012099006|3023799007|18002099003;
x-microsoft-antispam-message-info: mt3qw/Ix89dB7QYK6/E6FfAlw5BWwF/01EUYBfJjnRmWU0bXk6k1QPiiOEmFrJ/XGwDrAWNnV3dpmpotxspK+oDVMIFLVx4j4GoUene2NnePM5iVE+xx4tnZUpNQ+CGPRP48727fv685jpJCgA+YTl43lDKnEtZP9bmx0cmlZSPtg9MXww3vaNffdq4I9HcUkabmbjs0LUOaxuarc807S4nnJO960KZ/XKa6gida1lUYNWUDmwQk5WpjuXtNXo3DlfbzEIhcnkReEI6XxQG6FZTCdsWNepYGesqg7TpU/Va5QE/aSIxv0PP+8H5UOQ5PncfPi2yR4l+QnHegt8GNPpkye6/vOT/MJyZD7/v7DHPRtAbK0NwftL7aoSgwwfJAJhutBVVapz9BCL1DM1aX1llK+TJyG4HY3TJj33aK6pUxQqZw2QlgRYhf62LAKeV6HaN/69hnOTZxZqwF2GNRn4wLOGZwGpV7zQ/fa4yIA+aDO5I7HVl/Rj65HIHVxazN6Ffy4EORomAj23vYH1yUvaE1c2qp6ZyAfEqDE4HhB/xZHgNLnTyME2iJMvz2aIQe43ZraF5uUFiGdHTaJmzUPCb8UGMmMSTeaRjC76/ETu6+T8YZf+QDE5nsfNcuCfIMa+OB0zleYEX6+SHai9bNO2MSAGhUe88oPc1xsUWwVmbAcf+MO9/JWQQ83/JGOJZeCOtlEzCf6fo/nEY6NeZWNUqA6Rmqh0lvJ5OEBaP3zas=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8109.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(23010399003)(22082099003)(38070700021)(4143699003)(5023799004)(11063799006)(56012099006)(3023799007)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ohRh2RfP5+JO3dKSUbK9csEMY78xBsoNzjLllt5p9Z1QeycoFuts1h6B894U?=
 =?us-ascii?Q?oFoSiDpAamcoA+MZG+kaS10BkUEr+XDsfo/PCoG6CAlCsCfNl9aP+/hC3rX2?=
 =?us-ascii?Q?QoqjWvUD78Kkcp+1S3EHiWeK0gpsk59McVKda8SLAYx9KEmygWnKfdSRHlHn?=
 =?us-ascii?Q?OWjTPS0HtsfYAG2XKR1KAz+hVedKgi3w9cSbNOe1rK1E7mIPV4DHbwRCizvs?=
 =?us-ascii?Q?wP5d9hgRMcWZ0oURryxDh5z0NTefr+NJxPk5Z5I1ryT0Hx6jsP6g47p1kdAj?=
 =?us-ascii?Q?EEj4QUqDTK+Vx8+kOPLJ4HjC1rgo5cPlT13EFq5nRAmxMXqajjvMd0CqDEaE?=
 =?us-ascii?Q?G+zoWeyU43gvqvAtvHf+94s+vQc8LSUIN+EAJmMXxqKOXhFJsk2xbTj5JpRd?=
 =?us-ascii?Q?AZl8UCc8oJTKrlIgLWLZ+h6zDz/hLUGo4ehpJ72+7D1ADMDnQzW3IazFO6sa?=
 =?us-ascii?Q?o1EuXdrinvIgfx3NOzXWvY5qrz8U2V+Uz6V23zBZEkgcb+NQFiQrLuGxrwaD?=
 =?us-ascii?Q?zgAsdUb4s+HgxwZASJ5H+l9D7dTn+hINS7AXkHZP346dBXxjEAmZr1KgD6A0?=
 =?us-ascii?Q?rim1szAigMsPjdatEoKP0NzVLPFo4i4QeMcAtoC6LiiJOxm4md1yN5H+mmeb?=
 =?us-ascii?Q?iiANolqMOJaDbzS5rp+Gi81AOEfHILhjZGzu0Ju/+R8pIe92PJB8TyPGlwWW?=
 =?us-ascii?Q?bMJxaCymldmtcQ9xsBpiirOY9pTakL1fStNC0mtjKm3EQIki1vagYhbz/4jP?=
 =?us-ascii?Q?+uB/WHFnOgc+WJEMOn/w7LDIbo742GC3GWXWTEvE7KrxSMCVdv2IWwm1o5FE?=
 =?us-ascii?Q?wFDa5doSJUr344HHNrnzfqV49VCFK89AzicavRZntbYrj4OhLoPEpv8iPx46?=
 =?us-ascii?Q?WQc0H0BDkmzgwNu/iSP9xv+vRGeXxxGu/iXwAr/REejJ4zTh6wOzTJyVbf0Z?=
 =?us-ascii?Q?nqyt5n48/XfbHn6VYHrZTtHnB7z5N0WkRd0AX6AUZyEtTMrKQAr2KqTEH0YP?=
 =?us-ascii?Q?CMSTzg6ByQ+5Py0woUtDoworZnYv4x1TsxTWyviTuCiVnjkdF6aUgr2HMktK?=
 =?us-ascii?Q?BscfvI/xuATSTgd8d/saMl4K3LnHwf0KtXk9AYN4QijdrHASyCeUPQjJF4wO?=
 =?us-ascii?Q?RkXxiDI8r/18gZ06oMMe1bZ7VtSUlAl2vZa6pVYkIofg6SAO9AgLku0HvYls?=
 =?us-ascii?Q?1+B79Ex6pStFRsLcHEtlBV8nimHF/p3zc14FkQIuCj9sAv9UZfTuYKIOtaPX?=
 =?us-ascii?Q?zqs+5fvlsx8qcp4RNgxbyHml1s+oKQl9AuQ/KW9S8riPuBUWBARkPUc0WhMB?=
 =?us-ascii?Q?t5aOzDkKAgSlMqsLHswow4Z8cMfk6VJyEmbs9KJT9Y9bfCjFad5g+Tvsksv6?=
 =?us-ascii?Q?NEf5GVUO7j9AwAEpM+JN24lhEDWoRtOna0Q8SWwC/1Ee5nZEgr1fZSAB2c1y?=
 =?us-ascii?Q?+jniGE2Uj9Qh4eftAA+xmWmXoMObm6SLAwCuU4VhdkTm8hBDVRg2JuTEBuN5?=
 =?us-ascii?Q?VbJ+PR4merZMRB+jQwC0BZZuV1UaYfo5Uq7Uda139JSSBlNSaM17jE0rIrpv?=
 =?us-ascii?Q?24tTR6b8w/NrmVMUzp4RsBA3zDKvMY2C7YXBuZy21vXA76etHAQU3DuZacpf?=
 =?us-ascii?Q?NLB3M3eCuukLwHVzIAEoKk9eMtVLzlBaY1Xi9gHxauGQMLBfqA5Z1cqU1L+d?=
 =?us-ascii?Q?0l0dsrGLo+GIW9mpgqxlh20PDxFv090ajXKNE7USJCeI0/TFC46uhiLKm+bb?=
 =?us-ascii?Q?UApXhRVbQJyAd6I8zjqOCFjqJQ/B+2M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: msfBRrGdMl/rfX/SV8Eq/sQrXqNY2U3Z7FsiYcG62rOt3elhkg6DXpArGnNEULCjmOQhTew/IqlhYL0qm/X+f3WOXyLO/nunbneKtR4olm5ImR58VeLUNKotvSxWGzzzuHApP3pTEswB4gk5m5QbfYMrYkIS1U+43noLzeIMuuipl8P2+/y4OcUcqfrjguyolr66b6Q6jecOb1VXMM65mQ4ydOLOI6lZKX7C0/FHCD14HpSJ23LrObbAAbQKk8jFRRjbpY39GR/zgJK4Jy/x/sdWj+mbu6pJrJ84po4DQKC/1cHoIOoqozW5tvzoDRfYwV0HbvLfhIE560UabsUcLQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8109.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7851ef8d-342d-4abc-0c52-08ded793af29
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 17:10:43.1803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z1V2ylS0OD5NmR9YZ7rHw593Jqnqx7inAtVsO6InJbLupeCRRnZDf+nFd3r3aZU0qPN3SC2E+aqLnm8VNHQdiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8758
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303779-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[shubham.das@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:alexander.duyck@gmail.com,m:lee@trager.us,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:mkubecek@suse.cz,m:siddaraju.dh@intel.com,m:balaji.chintalapalle@intel.com,m:magnus.k.lindberg@ericsson.com,m:niklas.damberg@ericsson.com,m:jonas.wirandi@ericsson.com,m:vijay.srinivasan@intel.com,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shubham.das@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,trager.us,bootlin.com,vger.kernel.org,suse.cz,intel.com,ericsson.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57F9E6F0331

> Sorry, but i could not implement that, in a sensible way, given its curre=
nt
> specification.
>=20
> I suppose i could simply flip the first `inject-error-count` bits, and ma=
ke the rest of
> the stream perfect? I could also wait until the stop command is received,=
 and
> then flip that many bits before i stop the stream? But none of these seem
> sensible.
>=20
> Please make this specification have sufficient details, or references to =
802.3, that
> you could give it to another engineer and get back a reasonable implement=
ation,
> without having to answer any questions.

Andrew,

IEEE has clear documentation of the PRBS Receiver block and the BER counter=
 as an output.
Before performing the actual BER validation, it is a usual industry practic=
e to introduce errors
to guarantee that the checker is functional and accurately identifying them=
.

Similarly, in DATA mode, error injection is used to verify the FEC block
by ensuring that injected errors are detected and corrected as expected.

Updated description.

+        name: inject-error-count
+        type: u32
+        doc: |
+          Request the PHY to inject exactly this many bit errors into the
+          currently active test data stream.
+
+          This is a diagnostic tool used to validate that the far-end PRBS
+          checker or FEC decoder is functioning correctly. For example,
+          after enabling a PRBS pattern and confirming ber-lock-status is
+          locked, injecting N errors should cause ber-error-count to
+          increment by exactly N on the receiving port, confirming the
+          checker is actively detecting bit errors. Similarly, in normal
+          data mode with FEC enabled, injecting errors verifies that the
+          FEC block detects errors as expected.

> > +      name: phy-test-act
> > +      doc: |
> > +        Configure PHY test parameters. Each attribute is optional and =
only
> > +        specified attributes are applied. TX/RX patterns are set on th=
e
> > +        local port. BERT and error injection operate on the receiver p=
ort.
>=20
> Error injection operates on the receive port? That is not what i expected=
. I should
> go read 802.3, and understand how this is used.

Thanks for the correction, it is in transmit direction, Updated description=
.

+      name: phy-test-act
+      doc: |
+        Configure PHY test parameters. Each attribute is optional and only
+        specified attributes are applied. TX/RX patterns are set on the
+        local port. BERT operates on the receiver port, while errors
+        are injected through the PRBS/DATA transmission port.=20
+        When bert-action is stats, a reply with BERT counters is returned.
+        Typical workflow:
+          ethtool --phy-test eth1 tx-pattern prbs7  (TX side)
+          ethtool --phy-test eth2 rx-pattern prbs7  (RX side)
+          ethtool --phy-test eth2 bert start        (start BERT on RX)
+          ethtool --phy-test eth2 bert stats        (read counters)
+          ethtool --phy-test eth2 bert stop         (stop BERT)

- Shubham D


> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: 29 June 2026 22:27
> To: Das, Shubham <shubham.das@intel.com>
> Cc: Alexander Duyck <alexander.duyck@gmail.com>; Lee Trager <lee@trager.u=
s>;
> Maxime Chevallier <maxime.chevallier@bootlin.com>; netdev@vger.kernel.org=
;
> mkubecek@suse.cz; D H, Siddaraju <siddaraju.dh@intel.com>; Chintalapalle,
> Balaji <balaji.chintalapalle@intel.com>; Lindberg, Magnus
> <magnus.k.lindberg@ericsson.com>; niklas.damberg@ericsson.com
> Subject: Re: Ethtool : PRBS feature
>=20
> > +        name: inject-error-count
> > +        type: u32
> > +        doc: |
> > +          Number of errors to inject. Each invocation injects the spec=
ified
> > +          number of bit errors into the data stream.
>=20
> Sorry, but i could not implement that, in a sensible way, given its curre=
nt
> specification.
>=20
> I suppose i could simply flip the first `inject-error-count` bits, and ma=
ke the rest of
> the stream perfect? I could also wait until the stop command is received,=
 and
> then flip that many bits before i stop the stream? But none of these seem
> sensible.
>=20
> Please make this specification have sufficient details, or references to =
802.3, that
> you could give it to another engineer and get back a reasonable implement=
ation,
> without having to answer any questions.
>=20
> > +      name: phy-test-act
> > +      doc: |
> > +        Configure PHY test parameters. Each attribute is optional and =
only
> > +        specified attributes are applied. TX/RX patterns are set on th=
e
> > +        local port. BERT and error injection operate on the receiver p=
ort.
>=20
> Error injection operates on the receive port? That is not what i expected=
. I should
> go read 802.3, and understand how this is used.
>=20
> 	Andrew

