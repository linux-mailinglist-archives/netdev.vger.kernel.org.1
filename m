Return-Path: <netdev+bounces-195078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C32ACDD63
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 14:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8754C3A5C07
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 12:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139E721C177;
	Wed,  4 Jun 2025 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gqki9vYH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F21A5BBD;
	Wed,  4 Jun 2025 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749038529; cv=fail; b=APNMzsQWNGlbtpkjVWzVYFBE4oeBpD0XUstpujwT26ply3KUIYDoK2QwngqqvJ3QyuZ2myywcw2BDSJq/JH+mSMrkyZl9ZI5AsmAQCpRM98YOkUJaQStESYYXQjvRBcXbO4XlaNXHD0PBrru3bZqLzgvh/6Fd+bRPN+2Q/is3jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749038529; c=relaxed/simple;
	bh=a/wtQmHCm8JmgkhE3122nA+VORXNAZ4rdR8FxzFAdss=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FZx8HDc0bT9Y+hGI7umY/wEh95qPzOWGyhfJEnsc17zYtUDbWPOtzEY3PUn47bwCpi5m5Jmgiy2V/pqCFzo6ZoIwixCO2e1rPuOV6BcdBvHllbKnIa5nklpqvqKpG/ht4WwA+tgNZgxga45nMhRDrZJGf5z9RkztxUna3qYXjRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gqki9vYH; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749038527; x=1780574527;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=a/wtQmHCm8JmgkhE3122nA+VORXNAZ4rdR8FxzFAdss=;
  b=gqki9vYHnrRe+CcPtcaRAwed4hvcCftCbUruaTfOeXGS56prQfeH5aNY
   CppKJcIf8ald0ezlUsSBp6Y9R3v74n5SJa+XNC3B8NuP8IbLH84YbUEnP
   iSqPLDvP8wrRjNIIqKA+66b43Anlfl/iKNXZV6PvqgT5KTnbfJbbfxheh
   8CXOdqP7N6iPffh+LORlPtMEsnkqiNrEvetPRN7oVyzb86ia7w/3e9+Jg
   oRlWczNENRD//VSx4AEB3QYTuV1xUtZ/+s5k8BvOd+Q1WlPBn8epeGfUv
   qswYbPpLlkHmoFMj8SICawmk46/C7swGP1v+sZ9ve2bwfeQBSAn58ObL1
   A==;
X-CSE-ConnectionGUID: fYqW1tMYQGWue8E79RBE/Q==
X-CSE-MsgGUID: A3wZDjCBSMaRX24gvlQdRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51261980"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="51261980"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 05:02:06 -0700
X-CSE-ConnectionGUID: cmJD8+aFT2e1UA25TfubRA==
X-CSE-MsgGUID: RP9Seig5QkiTBbXAe22kCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="145655622"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 05:02:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 05:02:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 05:02:05 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 05:02:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xG0qq12wFdc8TXFC3oloh/2Mhjztqn1THukO+/s2bQIMClv9O+6lqCHtT2ykkatSDosJXZeuRuTEDUj+qej7BZeOdBaEr1WAMc+VDoo/SUXxHD6e/h+9psdMSkn2u6g0Xv7pKjWjmBmZhJh8BNLGns31c+U0D58AOWbMWV7XbwLI+QafaxAK7xa4xGisihZ9/kzBDW2r8BJhsxmjrwr8RcWQQ6AHKUK1R69psP3/pyJaaBxfiTUy1fYM0VSCCtQgjrKw2vWmnji3Ov7tAt+OyYbZaZofGtqCE+iX9LcnT2sBRuxW+YNsk47IS9xAXNLqOjZmF6bbQ/Z2KJKISHdfUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwrf+PC3mHzI4j/PGMEmtWWA/7yqhNJhEOsmUV4MrAA=;
 b=lCNH+4mY/uHsTo0t/KamhLbPYKRGrRGBEPX9VeQPuJGGDYtCiMj2JvV9g+fd2hSWaYPlOA/bbryYIcGLPsUbklrs6L4xNKSQk/hCJAWSilhsWb8VL6KoL4W5HV6Qmp69LCIixJOh6gdmZsR7L1pXJ/ceoqVF7t2c6LMday50Xwrv96dCTnuQWrD7O6UXCE30upIk0765GVSNRa29S8JdBi1U9YOKMgPIQJVEF8xNv70MF9GGEThx3Ch8QY79yWLmTMUkHelQfi+uy7z/C7MD0TlLcH4punPTW82ucdsdQez2RGjZXU7S5/4ofYNrp/rgskFLTQX6JBjfYjrFYXu3sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by IA4PR11MB9012.namprd11.prod.outlook.com (2603:10b6:208:56d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.19; Wed, 4 Jun
 2025 12:01:30 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%6]) with mapi id 15.20.8792.033; Wed, 4 Jun 2025
 12:01:29 +0000
Date: Wed, 4 Jun 2025 14:01:08 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jinjian Song <jinjian.song@fibocom.com>
CC: <andrew+netdev@lunn.ch>, <angelogioacchino.delregno@collabora.com>,
	<chandrashekar.devegowda@intel.com>, <chiranjeevi.rapolu@linux.intel.com>,
	<corbet@lwn.net>, <danielwinkler@google.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <haijun.liu@mediatek.com>, <helgaas@kernel.org>,
	<horms@kernel.org>, <ilpo.jarvinen@linux.intel.com>,
	<johannes@sipsolutions.net>, <kuba@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<loic.poulain@linaro.org>, <m.chetan.kumar@linux.intel.com>,
	<matthias.bgg@gmail.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<ricardo.martinez@linux.intel.com>, <ryazanov.s.a@gmail.com>,
	<sreehari.kancharla@linux.intel.com>
Subject: Re: [net v3] net: wwan: t7xx: Fix napi rx poll issue
Message-ID: <aEA1hBEltWuIE-Yy@soc-5CG4396X81.clients.intel.com>
References: <20250530031648.5592-1-jinjian.song@fibocom.com>
 <aD7BsIXPxYtZYBH_@soc-5CG4396X81.clients.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aD7BsIXPxYtZYBH_@soc-5CG4396X81.clients.intel.com>
X-ClientProxiedBy: VI1PR02CA0051.eurprd02.prod.outlook.com
 (2603:10a6:802:14::22) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|IA4PR11MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b513cce-b637-4992-e64e-08dda35f8a2f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cDrM/pS+lJc8vut+19bP5Gdy6kxSn2BkRcPxKy7HmPXb30x1YRTYDgLVWQRe?=
 =?us-ascii?Q?6Mcg/pFP7nqvmOKxNlI8+Dok8RkFGG17li3ep8cvrNbYXhVGvkVuAnE75j99?=
 =?us-ascii?Q?/6pjV1If6uocLpM0evhhc9eAg+0D4/ynL3fJBLGU2Hj/9S+CGMgf1Pax2urY?=
 =?us-ascii?Q?LVV70GMGSYyMVD1hEF2NRBdi+8oGBh4433H6gUIKmiBaXx+JwqevguYbt8QY?=
 =?us-ascii?Q?Jx07rAZ1hPd9ymng6/JfQf219v2rQKUKWX24QUMqiDi/RSLhKn+gv+W8c4So?=
 =?us-ascii?Q?G04GOwQhZsyokAXstBTk7spHHS1Bb5YMLUyz2lbOWDLMsr7uAGTTYnqxR7GA?=
 =?us-ascii?Q?dwekiwW7VQ2i+03vrGHDMk/K4w9QKu7Q6oPcxhxrv0xyVVundEiTDhQCFdmw?=
 =?us-ascii?Q?vpM1y0MlGRypALQLJgafsgjoHGs4CPkNVrYMkhwucQ963CRn/zmoE6uSgJbA?=
 =?us-ascii?Q?iZYAFP8DLkgUfOIhLUWuu4sMz3BhYoIg9oBdi3a5iMbydBjlr0ywaGpHP1y5?=
 =?us-ascii?Q?GfuTUt0LqXkA00OqZH6VGJAvOJMMORBKS9Dowss72lzMtGuIzTxvPT5OYK6u?=
 =?us-ascii?Q?cAX6/fo7LII8Om6F3SUxVZaHr6vhcL3ezuFmJsg4LiNlraZxyL5bec3Su5Xm?=
 =?us-ascii?Q?XGmicUu91phxHxUj4PYIiwfdT0Ga1GkFW05GPiJkqwxQNnlJgk/9xxld5CkE?=
 =?us-ascii?Q?nsG6WuWKMqQ5i8s+p5ENIG6xrBTbyylLj9ICi9Ba3XypRW6YdXuPVP1KLq/f?=
 =?us-ascii?Q?IdbTxjpLMamrEVtLS+FxnTVqnTDkVzSKiT8fD0HN5bYw9oFDQOmY1R1fT9Qf?=
 =?us-ascii?Q?pcoH6DnLSUny+Lm2MKdWLz40IfF8KMmgYrbkloJhINA/r6D1RH29LIKsa80O?=
 =?us-ascii?Q?LoRKRgzXwj33bUXSqXvuFw0ZvFzr7gvUo4M+e7Us8WiBrKrZZc3mAHmfS7UR?=
 =?us-ascii?Q?NYN72umQGaNK9PrG6tJHIjThJfkW5bUrbeYzMnRun1TBs1+gU2BiPkpkS0VC?=
 =?us-ascii?Q?1iLkdgtlfBG49opOZFYcf8n5giGy6FhIAx9+1Mgi94va0hAXN4HFieNJinm8?=
 =?us-ascii?Q?P6LQ68lM3O2s0dxn2spykgXgrepjjEPfep0BjYAbNcsmR7Pc1wXIBf9XE6iO?=
 =?us-ascii?Q?FD4SDUNsNIWwIYXZxc7n+0J/AaebDYo7noZEYItYAUF14LHtDyBBk7rhqjZS?=
 =?us-ascii?Q?EbVmtOzEnH8YCGARODh3lnoMaUut4aUwEoI/DmICvmImcv9wfBcVKrZb76wg?=
 =?us-ascii?Q?2ALmxBZ9ZqvUubIhjQXM71J+urgwJCHkc6d2bBfmeblwG5dGyu0VSrvZwCZr?=
 =?us-ascii?Q?Rrh7f6tq37fN1OWjdig3I1Kx2dIBc3xaDSGgsqunQLHItyEMqdL2FhZKRhQ/?=
 =?us-ascii?Q?vlf2fuL9wF9GC8BbTm/XK6bV474S6j2LaQZPom67vr6e8JRoa2LLjtlyfPHz?=
 =?us-ascii?Q?taar/2axgbk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y4ksMCmH8Kz4rLVUOjqKvACJWVyZMYL4SGu8BcYQTJVSnFfwZic5IlOAdpj/?=
 =?us-ascii?Q?N4+Ze/SJpAgWyzw3omg4MA3oCpEBXh3P8ufBBUgtpIoAr6wE63nXe7NAds87?=
 =?us-ascii?Q?wJ5QfKMdX5mCq2X++zvvNzxybGS3Oj8iPS/4HXrMvShz1NuRXEBqH+1iupZC?=
 =?us-ascii?Q?MANBsMalF9sXNjav0h53kYAa7hlhFqfuoX2oG428BHZKeym7f1vfPZAUNDFF?=
 =?us-ascii?Q?nnROwntDdHifdosRQ3NQ1u7F3E2Z7vc+nXuQXEt6XTblpRS/UZ+RlrX7PVwr?=
 =?us-ascii?Q?45vJGhYPzaWyGVVlACvtwAhf1v7gD9sXgrwwCj0IxFMg5DYGweLKHEfDmAsG?=
 =?us-ascii?Q?bn4t9krm/MIShCzLom7H04SDeehzZQN+cNaTY9DWFF9sE2kEsepXAaJ0j0Rh?=
 =?us-ascii?Q?xFl0sP6dvGdqG0nxMblJVewUvOzIElbsmjyTfSLGEXdiQRTNOa5mZCfdAVzG?=
 =?us-ascii?Q?VLvugfXP2bVDJFtBFPqPvsbu84FTRk5b4oMm6UN0AwiPYhXTf/c/APwFZjMA?=
 =?us-ascii?Q?ptKBKehYyWqQxO0X44s/ixupHA43p6NqrqFgGHOdvr6iAkmEeUwksIT+oIdA?=
 =?us-ascii?Q?+ShQ4NCOwC2FZ74fNNw6YCJLwenP9k0Q8rrAXNBRFuhkqx+2cJts2rm9OuV+?=
 =?us-ascii?Q?JRM2nHIhgVsNDZCFhQTLHWHflDbzeqDNF2wmr5PvbSw9iFJABTy9KcIOXIIA?=
 =?us-ascii?Q?BBBZAsno9IwwTdU+59a6Aik4rCw8BMDaHEo+mqt75zsNSLLP6ciedWoWaUfL?=
 =?us-ascii?Q?P9HZkI7xuAS4Jm8y6S2zN/7LHfjMq+MfPA+veAsoCuJin4pDWnYVqesVH24B?=
 =?us-ascii?Q?l2vMICKk8NxBelVT8pqfbA6cyXs4nnQ0WAccrv4RyslhKpXzgCL11lJPXX41?=
 =?us-ascii?Q?DZOxgYOboNQTmWoTjqG6MyRqG93RepbxtDkvz5Ju4PX2a8kugeLu45UetF+M?=
 =?us-ascii?Q?LHl91OolfmnnnGUvZoOptHb6aFaFwN4NXmQXt/zB0vX/lb5ATIVwCudyipEz?=
 =?us-ascii?Q?4AToidVADTqDbfA+IF9pmdzY1HxTtblTcAp2M0tGbXVHF482Uie4ZdSfulAz?=
 =?us-ascii?Q?9WaaTT+gDWbhtbTzi1FEaBxKaSxu/S60di1FrnHRbl1tPvby0oPPOxR/C9yO?=
 =?us-ascii?Q?KsFz1+VcZVQyrYm0hSbcoJmn5nNw7DuKQX4heboOoXjQpFbkAUdbRYb/L/hI?=
 =?us-ascii?Q?V7DZ/PkUQbZpVx2JXd4LD/wJR+k/VNNcsppUuDSaizSyPzdxBcFz3cz57hcC?=
 =?us-ascii?Q?2IAfymYvsNn198n4Z8cFVx8DLBnHi3pV9Z0Z14NZl6glTdVHdsR1/pxoOj0j?=
 =?us-ascii?Q?VKQZb8oDjBKZCMCFONbIDlh7b2Cj66wHg6uPWgFIHEGhMNEj2Rh5exO4twBC?=
 =?us-ascii?Q?NQbHY0X1p6gQBUA3yttR2rWGUMwJm+XGbcd0foxcedDNba3RqLa3QbMB9wgz?=
 =?us-ascii?Q?Kp7rkqzZ3n4n14SAXrCQSxMgeUhSpdBlQ8HSiNyufE5u2HKjAJ1UbCXZabUi?=
 =?us-ascii?Q?1WHblc59esi4iR4uDKNFmp6Br2xHuEfXPllzWv0IjRRNEst/c+XOM39BrXIl?=
 =?us-ascii?Q?SN9A4WwcQmyAxtazs5Vp/4ykzEgpSEgxUsTy8EdzMkpuQJBdjG72DQay/KQi?=
 =?us-ascii?Q?b036JMCOIhauFQmAxUSxoR+H+e9tten+U3j/Aay5sB4eHeZDSLdQ79o144tl?=
 =?us-ascii?Q?eHdfKA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b513cce-b637-4992-e64e-08dda35f8a2f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 12:01:29.4400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3ssfX/3lNv3oY5Rbxc/k2w6EQ1B2O3PVSu9maPM4spZYLLnpiQL9JPVNJQ+uMc/A50pFcjLCPiICgzxQJXiuKQ/rLEo6Lckl62eN4vZzOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9012
X-OriginatorOrg: intel.com

On Wed, Jun 04, 2025 at 06:19:53PM +0800, Jinjian Song wrote:
> From: Larysa Zaremba <larysa.zaremba@intel.com>
> 
> >> Fixes: 5545b7b9f294 ("net: wwan: t7xx: Add NAPI support")
> >> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
> >> ---
> >> v3:
> >>  * Only Use READ_ONCE/WRITE_ONCE when the lock protecting ctlb->ccmni_inst
> >>    is not held.
> >
> >What do you mean by "lock protecting ctlb->ccmni_inst"? Please specify.
> 
> Hi Larysa,
> 
> This description might have been a bit simplified. This process is as follow:
> 
> In patch v1, I directly set ctlb->ccmni_inst. This may be not safe, as the NAPI
> processing and the driver's internal interface might not be synchronized. Therefoe,
> following Jakub's suggestion, I add READ_ONCE/WRITE_ONCE in all places where this
> pointer is accessed.
> 
> In patch v2, Paolo suggested using READ_ONCE in places that are not protected by locks.
> Some interfaces are protected by synchronization mechanisms, so it's unnecesssary to add them there.
> Therefore, I removed READ_ONCE from the interfaces.
>

I have seen the discussion for previous version, I am asking you for the symbol 
name/names for the locks that make READ_ONCE in the removed places not needed.

> >> @@ -441,7 +442,7 @@ static void t7xx_ccmni_recv_skb(struct t7xx_ccmni_ctrl *ccmni_ctlb, struct sk_bu
> >>  
> >>  static void t7xx_ccmni_queue_tx_irq_notify(struct t7xx_ccmni_ctrl *ctlb, int qno)
> >>  {
> >> -	struct t7xx_ccmni *ccmni = ctlb->ccmni_inst[0];
> >> +	struct t7xx_ccmni *ccmni = READ_ONCE(ctlb->ccmni_inst[0]);
> >>  	struct netdev_queue *net_queue;
> >> 
> >
> >You do not seem to check if ccmni is NULL here, so given ctlb->ccmni_inst[0] is 
> >not being hot-swapped, I guess that there are some guarantees of it not being 
> >NULL at this moment, so I would drop READ_ONCE here.
> 
> This ctlb->ccmni_inst[0] is checked in the upper-level interface:
> static void t7xx_ccmni_queue_state_notify([...]) {
> 	[...]
> 	if (!READ_ONCE(ctlb->ccmni_inst[0])) {
> 		return;
> 	}
> 
> 	if (state == DMPAIF_TXQ_STATE_IRQ)
> 		t7xx_ccmni_queue_tx_irq_notify(ctlb, qno);
> 	else if (state == DMPAIF_TXQ_STATE_FULL)
> 		t7xx_ccmni_queue_tx_full_notify(ctlb, qno);
> }
> 
> Since this is part of the driver's internal logic for handing queue events, would it be
> safer to add READ_ONCE here as well?
>

Well, I am not 100% sure.  What would make the code easier to reason about in 
terms of READ_ONCE/WRITE_ONCE is if you replaced struct t7xx_ccmni_ctrl *ctlb 
argument in t7xx_ccmni_queue_tx_irq_notify() and 
t7xx_ccmni_queue_tx_full_notify() with ctlb->ccmni_inst[0], the code would look 
like this:

	struct t7xx_ccmni *ccmni = 
		READ_ONCE(t7xx_dev->ccmni_ctlb->ccmni_inst[0]);

	if (!ccmni) {
		dev_warn(&t7xx_dev->pdev->dev, "No netdev registered yet\n");
		return;
	}

	if (state == DMPAIF_TXQ_STATE_IRQ)
		t7xx_ccmni_queue_tx_irq_notify(ccmni, qno);
	else if (state == DMPAIF_TXQ_STATE_FULL)
		t7xx_ccmni_queue_tx_full_notify(ccmni, qno);

This way atomic reads in notifiers would be dependent on a single READ_ONCE, 
which should prevent nasty reordering, as far as I am concerned.

The above holds if you think you do not need to check for NULL in the notifiers, 
but is such case I would rather consider proper locking or RCU.

> >> @@ -453,7 +454,7 @@ static void t7xx_ccmni_queue_tx_irq_notify(struct t7xx_ccmni_ctrl *ctlb, int qno
> >>  
> >>  static void t7xx_ccmni_queue_tx_full_notify(struct t7xx_ccmni_ctrl *ctlb, int qno)
> >>  {
> >> -	struct t7xx_ccmni *ccmni = ctlb->ccmni_inst[0];
> >> +	struct t7xx_ccmni *ccmni = READ_ONCE(ctlb->ccmni_inst[0]);
> >>  	struct netdev_queue *net_queue;
> >>
> >
> >Same as above, either READ_ONCE is not needed or NULL check is required.
> 
> Yes, This function in the same upper-level interface.
> 
> >  	if (atomic_read(&ccmni->usage) > 0) {
> > @@ -471,7 +472,7 @@ static void t7xx_ccmni_queue_state_notify(struct t7xx_pci_dev *t7xx_dev,
> >  	if (ctlb->md_sta != MD_STATE_READY)
> >  		return;
> >  
> > -	if (!ctlb->ccmni_inst[0]) {
> > +	if (!READ_ONCE(ctlb->ccmni_inst[0])) {
> >  		dev_warn(&t7xx_dev->pdev->dev, "No netdev registered yet\n");
> >  		return;
> >  	}
> > -- 
> > 2.34.1
> > 
> > 
> 
> Thanks.
> 
> Jinjian,
> Best Regards.

