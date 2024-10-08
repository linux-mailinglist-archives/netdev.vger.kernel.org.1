Return-Path: <netdev+bounces-133206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6114A9954CA
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A6428143E
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A751136327;
	Tue,  8 Oct 2024 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DTeIL8gx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9881B1DF96D
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728406003; cv=fail; b=S6LVEIFBwpgG66hrEspdWZ6aQ3FTJkmGuGmKTZ+J7QqN4Ycml4iXTTA7XpAIamg919qy2TVAIOi9jpAZDKiFYtMQN6Up7uCrgFtWaKzs145R3UFGZhFu1Q1P0M6mfYijJaV4aLoUz9iug14v3UJEqnyezxA7Bh+tuGQ7j0AHrOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728406003; c=relaxed/simple;
	bh=Z9uxvunl6e8RpkJqs3QY3OSTwzs1JQPgSLGA81Ovb70=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mXN8ofUEho0/OPwO8MjLAqFRLWFDAUoxQ1jrHnBOWrRctp/2nRUO4YAHb0RA17SQr61ujphz6GAeuN09MZByjEuaZWLKiuvwPckMeUKMyupFgIzg5BE/840PEmORIhdATuG5dJ7DWq6UQ7dkJylVQFQk0jskUo7GLuMAdf6Ak9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DTeIL8gx; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728406002; x=1759942002;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z9uxvunl6e8RpkJqs3QY3OSTwzs1JQPgSLGA81Ovb70=;
  b=DTeIL8gxn3XFf95t9pVPdNjKzevDzVLDj2SOgcYVcyyFWZC2felCsURt
   NSBGZxFrWqfcq8cqO8OUazVd2GRp63GRrKYnTBlFLJ53nwxwFFbtkwBdu
   ubNacl/oVGw1PkAj0JLEX4ch8YjTJVCJCFBPr3M6ICct504pgSGzpICw2
   hNhGnSBPNlUK3RSJgWWCz2KB63gSIRwFVs5swN/0wg8IEYSPKv8jZ+lLg
   LBgCPmFEJ+AOqNlglePyYvz2DjH9hGXr6+bx29+YLxHBvGGKMs5N63xiW
   SMNXv7Q18EM/GvrVVYG6tuBfCD5CzCezbHSFbPffIQDLQS9WSP7hdlDHR
   w==;
X-CSE-ConnectionGUID: mAWchwYRTMGbhtIF8xH5pw==
X-CSE-MsgGUID: KytHpg2nSu2BHYgZ8Tqh3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27755385"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="27755385"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 09:46:41 -0700
X-CSE-ConnectionGUID: HchxxgUtQQ6L7zW45lDVZA==
X-CSE-MsgGUID: 6f7jINopRm6eTvrBq6Hjdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="76006162"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2024 09:46:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 09:46:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 09:46:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 8 Oct 2024 09:46:34 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Oct 2024 09:46:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMqqLZ8pCAcmIF8xKbvPB3tZbjF++ZiuFr8eD+vifbW7YJ6gz0BDNv2Rp9UxZVa0X9zu1FKNGb+VPxta6ZefOyihBoaNIyU3EIucISstqnjEIaGQmKNssCoyUL5W6D3CwzgBKfptAUc68WRVRlczi9BEsh0pMzYO6LSWOnKPP1GBvpZs3CbCSJ8V1IjSh+PCFBh1bgTCUEaPBAocpBqOub9Y8qtCudFN/Rapuokmmj/Q4YOBnpdakY7BwfZChbdyadbKDRprgxVLERaj4gz2osxmIFeV9sH+7sWhy3P0AhAEP878mIpwcnmgbtUp+e8fmIQQYRi9NV2xAZB+grKzrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbsqzfpZsle5O+KT+e+cH6KbM6LoWE0mKpseCEpR5tg=;
 b=HaQiurG0/goKqKQF6F9KjuvkV9slGsuaWyiKbIoVexW7x22Zr7SP8YJ6gIwhhXrFg3T+BlcniXv019yS+7qoqRCtYI+7DP4gFCG6Qp08RxQlklcKxx5en9tdBU4Ert7qw9F7Rsc7Cenzx+1np2twWG6k4ppEM77V7OxRAqiBreR9ejVib3zK+vJRzRaun5c+N55rbonJNLh1GoIf93HXjvUpU/Rh5XEyWzy8+6T6PMnuZCjIYClN8Zw70osbXb/r1sGOdRqBhBxSjX2x5Iwa3M68W7DN7qJp0yTJPai5qkPd9gMH4WuT/8QJJiipLiB0oDvyTKmqomt6j2kFOKdrIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB7150.namprd11.prod.outlook.com (2603:10b6:303:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 16:46:31 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8048.013; Tue, 8 Oct 2024
 16:46:28 +0000
Message-ID: <265323f0-816c-4ef8-aadb-e54c802fde14@intel.com>
Date: Tue, 8 Oct 2024 09:46:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: airoha: Fix EGRESS_RATE_METER_EN_MASK
 definition
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, Mark Lee
	<Mark-MC.Lee@mediatek.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<netdev@vger.kernel.org>
References: <20241004-airoha-fixes-v1-1-2b7a01efc727@kernel.org>
 <e4574a97-8e34-49be-9ec6-bb787104e6db@intel.com> <ZwET7MzCGVoDjIqt@lore-desk>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <ZwET7MzCGVoDjIqt@lore-desk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0180.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW4PR11MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: a64da91f-d85c-4ce2-16ed-08dce7b8c109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzdhcnNzYWozVDRqK0k1WTk4UkJJRGVoMlhjY214OEJ4QklPMUFDaDI4aVdD?=
 =?utf-8?B?SUd6Yk0zOEl3YjFqUXF6T1BWUWlhRHJhV3JrbU5UMjlNdTBLV3Z2aTlMelVG?=
 =?utf-8?B?Zk9nazZwNUlNdXBKZGR4ZFlidGFLMkFqU1NPeUU5VGZYMHA1dFlVSTIrRW1s?=
 =?utf-8?B?azl0Q0M4eURocGJ0WWJwZHpkMm0wYWptWUFYWktraVdZdEo3d2p2cWQ4WTRP?=
 =?utf-8?B?TlhKOHFoRXdEbzRtQWx0Vk9UTlM0RTJUZkdkV0dWeTNTZlZWMlNEa2k2b0Vl?=
 =?utf-8?B?UkU5M0tRNTU2T2k0NEJ0TWRBNWVuTTdXbC9TaEQxWE5DWVV1d2RLbk5wQ0ZJ?=
 =?utf-8?B?aXZPK1NSSnc1NmFMSDhwK2ZpNVpUeDdKb1E4OUdsK29xTXNGN256ZWNTUVpU?=
 =?utf-8?B?SGNoWWM3WExZSEVWckdSN1Rxajd1THpyNHpVMWVHR2tKQWZMMU5UZzQvdEdM?=
 =?utf-8?B?U3E0Z0V2TFgxSlk4aXhOWGVZYTZFSzIvYWpBeDNMd0JTOWdzL0JGNW1CYkdz?=
 =?utf-8?B?R0FaMjZyU1VFbUFUa1RUZzdENGppWkhBRVV6NkNuWTNQVjE3Ylc3cTYxSTJp?=
 =?utf-8?B?N3BEZXhDZXVpdUc0OTcxRFZyREpHSWtiQmRzRExhcFhjY2NSbjhldXdlN2d2?=
 =?utf-8?B?Yy9ZaTZlVnVveVFNRmlwekZEUTIzdnlma3hIdFUvMGZncm90eVpnOU4rMjVF?=
 =?utf-8?B?QlkxMnhOQ3VJUWRteGI4RXZaTG9tU3dkYzZTdWpjMHJJM3ZnUzIzY0xYbk1q?=
 =?utf-8?B?ZFpGYlJTQkpNWTE2YzU0Ukl2ZkJ2cUJ3ZXkrUDVqQXJkdmk3MjVNbjNEZGEv?=
 =?utf-8?B?elRDbXdnOXIvamZLYVhhVnM5OTN4dEZ1aXcwNzBWMjk3Q25rUDNrdmxCUVNT?=
 =?utf-8?B?U1JReEFyZW5LWWJUQ1BGTnpIVHh4YlY2dU1WTFVpakZoL0ZDN2xzbjdPS1Y5?=
 =?utf-8?B?aHhVRzBkVGtHOVkyd2ZaKzBTdTVRS2p4b1kzYjdCNXBVWUZia3o5MCtrRVAr?=
 =?utf-8?B?N0t6L3dFMzNwVW9iMWRIREhZUDRONUxwRUdtUHp4ZHk5bVppbkJFejYwUHFT?=
 =?utf-8?B?USszWUNiLzRzQzNpdUNpYlZDbFVSWUhwejMwYW9iMEFsNStQNkJhYWkvSFlm?=
 =?utf-8?B?bzJpRFBNQVgwUGV4cjcrMmFkV0FIdDM0OHEvSDZwWW5QektrWkRGWUN6cnNj?=
 =?utf-8?B?Vm14V3E4Y1hrTHAwbmJjYUZ1eFJBZVNIWlJudU52WWgyRi9kUFg3NTUxUW42?=
 =?utf-8?B?WkpSeW4wVXBuRGhVVVNvWm1EQ3VPNXBVczZqUkVaVXR6enU4UmJtSUprS0M5?=
 =?utf-8?B?bThhSDZmUWdZWTNPYkcreENuTW85YlBlQVRYamxTaktuSEo2TXAxMEI0cjlt?=
 =?utf-8?B?NEk3VkRLdFIwbFh6RWRVUFpFS05zaktIK2JtSzJNR1JwS29ZT1JBSENWZERx?=
 =?utf-8?B?eStyanoydGxPVzN6NE05alhabzFidDd3czNqWFNFS25VWlVYT3JiajBLbjVP?=
 =?utf-8?B?VjhMU2c2M095YXNSbk1iZU5WNks2b3A0VGdrajJPMEc3UXNYR0hUcUN0L254?=
 =?utf-8?B?ZzJ0Y0FleUZTaTkrVkM4RXo5aDJOMDcvbWNlTnh3TU8yNTZtL3RvYUJ0YzFI?=
 =?utf-8?B?cFdBK2dWQWk3UjIyM01QSjdjSk8xU21zRzkvc2l3QnlZVE1GS1k3RGJYbm4x?=
 =?utf-8?B?YmQrcTcrTENJSUVuaVRrL3JJb3ZSb0xmam1RbWpNeXZIZ3QzZm9oMkNBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?US9sZmYrVWdKQ291QXlMN1RFWmdVOSsrVmtzTXFiRW12SkVmRVdzaHlKV09T?=
 =?utf-8?B?bVJXcUdpY3FxQWY1azUwR1N5eFZ3M0hKUllScWsrajRoMnliQkk0YVRZa05S?=
 =?utf-8?B?U0haQ2N2d280NW5VU0kwM2VoQnBKb0p2Vkc2Ui9ZTGhNM04yL2xGeEdpSDdB?=
 =?utf-8?B?b3VmODB1cVhvdHMzNlFNbzFveFUzNFdOdGxRbzJQTnlZZUdHbEhGYm4rRkpu?=
 =?utf-8?B?SFRMdXRFVzBuNkxGUXZVZlptR3hCb3dpYnZsUS9uQjNwVjlkYm5uaE03NjRw?=
 =?utf-8?B?aHRuTEZyeXZ5WWFPNEM4NW0xS3prQjlvYjEySllLb2g4RFVVOXJJa1FxRW1G?=
 =?utf-8?B?WFBHMTNINmpIdzd2bktHM2k4SmZSM3RkYnJnR3AxS2pxWlU3TXlyODRmWlVQ?=
 =?utf-8?B?amZrdkJzS0FHTU1MZHhVZGRkd2VSaTlqMXAyRU5lMHk1dktuVzBZWGlrTXdZ?=
 =?utf-8?B?RWhQb0R0THBhY0FKRHlLbjhaZTdSa0kybGtzaE51Q3FSK2Y3aGo2QWkxbzZD?=
 =?utf-8?B?MWpRc3lXQ1NVSVpaZm94czc2ejZ5SjcyS0MxclFPQ09kSzZBSEZ2RTdaRW1F?=
 =?utf-8?B?bUFpaGpvUGJSWkRhVnErcHNJUDZTa1lMUnIzaFM4aEt6clNqalJiRFBieGJK?=
 =?utf-8?B?RnBLL2o4RnoyRkZncW5IRVd2OHZYWnlrM2N0aXZreWJNQy9DaVZGQ2hpaCtp?=
 =?utf-8?B?QzdyZWh1SWtwbXdrNUhEZFJodmFHODBnV2o2S0xYakpHbDF6VHM3T0VNNnZp?=
 =?utf-8?B?cFp1NmdqaW9qc3o5RlcwTEsvYWxOblJ1eUQwb2w3NlRSRHlIYzd2NHpIdytN?=
 =?utf-8?B?aEk5bXBSTE9FQmJLd1phRDFWV0plWUZGVnU2Qmw0eEJlZkk0SWRRL1g2QVNh?=
 =?utf-8?B?bDQrQzY1L0gyZ3dxTzFTbHNNRHhUemVyaU9lYk81T0xQTGlsbWtqTGNNTTVj?=
 =?utf-8?B?bjNsRFkzVVdPYjhFQy82Mm1CeTc1cE1nVXpmbUZoLzE2VWFEejRQOWxCdHBT?=
 =?utf-8?B?VGNQdlhLeUJVVitSN1JtdVI3Sk15MXBnSnhlcE0zTWhNMVVnYlcrRHNaWGVs?=
 =?utf-8?B?VFdNM0FoaTkxN0k2RlY2WHVHS2xycmt4dHhVcTJrNUcvTExHOEtZcGtpQlBQ?=
 =?utf-8?B?a1FYdWdkZHpDTjQzMXpMdkl0SXFqT2RoME5QdVRDOUVqV1ZQcFYreHk1Q1BX?=
 =?utf-8?B?MEJuZTlVSUJIV0xDYWUydTUxeWtQdVVWc2pHMTQ4NktRN2VoSitROElOSjdj?=
 =?utf-8?B?RTBleUphdjk0cmZSTTQwVXBrUERaaDd5Skl6VUZkS3VoWmxuY2NOODVBVDBv?=
 =?utf-8?B?QmI5YUxlQkV3dkFQNW9PRllqdTRKVlRNeHVJNFRnbkFkckxzRUNhcXFTc2Jt?=
 =?utf-8?B?dEE0cC8wMkhnNzRXS1g2TEVxSHpBNGtIVG53REN5YURBa1BOVmcwRkpISnVo?=
 =?utf-8?B?UGo5S3lYWTFYUHhMNHlYbVBaSEU2NGJkRkVHaVl1dVp0cmtsSW0zMk1rZ0lR?=
 =?utf-8?B?cStMREpweHZXU01qYjN5SVVUeUU3YzMyYTNvZWZxNUp4dDN3R0tDUU5RekZI?=
 =?utf-8?B?VnJUeks0UlRMS0xpMjNVeWdxMHRpT0NwQklCNGxSZWIyTElvSkdEeWNldG1W?=
 =?utf-8?B?MUFVWTZ1L01Ic0xKU1VKQmVPTXNXL1RSRkZJNkIzQkI3VHhKcFA0YUJJNEd2?=
 =?utf-8?B?cVRCc3lUVkZ0Y0dDdVcxQ1hTUWhEOXhUejIyby9MS2VBa1g2U3lud1VVK00x?=
 =?utf-8?B?T29sbVpLUUdEQXpvdVRsYW1FU1FZdnJxV3RvaE51QXJnQjhzaVMydmhEYUk1?=
 =?utf-8?B?WDRvdUFKdWxtYk8zcnk3UWZYYTRiUTFza3U5YS85VEtiYmxBZWFSL3FrM0Jh?=
 =?utf-8?B?bThSOXJEVjAwajhiNHI2OTk5T0JlOERZVDB4MisxMUR3MThpNmFGOTRueFp1?=
 =?utf-8?B?eHRPRHBUTGJXdDhacnl0M09iN0kvVStMMVFmZ3gvNmhpM1VtM0g3TUpDQ2VE?=
 =?utf-8?B?RGhnaDhVOUpjejBsbExVV0lLQS9vbFJIeHR1OGkvNXpzM0E5bGloZTFxY1pw?=
 =?utf-8?B?OFczZ0dUWVdjdllLSlZoZEdTUXFNay82czlIUXpVZGdDbVJpOWJ5MDVkTDBV?=
 =?utf-8?B?eDJmS2sxNnNCOGxLZFVtUXhmQWJNMC94N3p4M1dOQnVzaUtnTjhiR3NHYWRq?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a64da91f-d85c-4ce2-16ed-08dce7b8c109
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 16:46:27.9351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8FnCV6UjSM8vrKJnaRCd9U3PlbuqC6F+qp6w6lzUl+dr5YFpGhfu1C3a7wfFOHO3PnTSQ6FdoMfTyyhIgcB7BzoXuUgBgkK9hHBjiPm6MoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7150
X-OriginatorOrg: intel.com



On 10/5/2024 3:24 AM, Lorenzo Bianconi wrote:
>>
>>
>> On 10/4/2024 2:51 PM, Lorenzo Bianconi wrote:
>>> Fix typo in EGRESS_RATE_METER_EN_MASK mask definition. This bus was not
>>> introducing any user visible problem.
>>>
>>
>> I'm not sure I follow. This bit is used by airoha_qdma_init_qos which
>> sets the REG_EGRESS_RATE_METER_CFG register?
>>
>> How does this not provide any user visible issues? It seems like an
>> incorrect enable bit likely means that QOS is not enabled? I'm guessing
>> bit 29 is reserved?
> 
> Hi Jacob,
> 
> even if we are setting EGRESS_RATE_METER_EN_MASK bit (with a wrong value) in
> REG_EGRESS_RATE_METER_CFG register, egress QoS metering will not be supported
> yet since we are missing some other configuration (token bucket rate, token
> bucket size. Airoha folks please correct me if I am wrong). This is why I do
> not think it is important to backport this patch and I did not added any Fixes
> tag.
> QoS hw ingress/egress metering is in my ToDo list. Here I have ported the basic
> qos configuration I found in the vendor sdk. I will add more info in the commit
> log in v2. Sorry for the confusion.
> 
> Regards,
> Lorenzo


Thanks for explaining.

