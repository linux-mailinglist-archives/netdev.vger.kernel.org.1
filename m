Return-Path: <netdev+bounces-176264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0FFA698B0
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 20:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481B93B6EC4
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 19:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDA61F4C97;
	Wed, 19 Mar 2025 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hGry/s/l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2801DF271
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 19:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742411322; cv=fail; b=FgdQsokfd9uB8lEty7el/DjXra68Ra+GIHlgCe0vcHSyYTZyOcgk9hulbDT0t3iZ30tV+jFaDH7aIMUcuOiP7+8KR4vybyNd8WpQB0bpNH4HBqEtVdFmhU1ymraCBOoJ+x0/FF7dGjwUrNm6mINUyIkncXWYCQ2AJvUVC0DFUrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742411322; c=relaxed/simple;
	bh=r4w7tu5uR2DDJIKvJb8G4Wr79YvpR/GQCnU94vqciI8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P3CyqJ0MCTtXPh1Wtt/M9xoXaqnJ4T0kjSPXB/2xAJOitCqMM7x2w0W9IVK8JuQAcmSaQqg6BaYIgLxzD9tJWLFAcCw9BMhPnjmkNNKFVjlx0wt1+5BzjwVnC/lS3J0W0jOXD4Wa4YoH252jF9J9Xd9YtFN6MNI5bwr2Tvic5h8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hGry/s/l; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742411321; x=1773947321;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r4w7tu5uR2DDJIKvJb8G4Wr79YvpR/GQCnU94vqciI8=;
  b=hGry/s/lYOBv8fOZGlcnVoY5T3hHF/9mASL4y8l04LvRKqFah/YMEzx3
   UoGPJwPzkzKf5YleRDFmntawiBKXEuqX+WIlISVTWB+nLgeQZxPiJ7BDJ
   +voLVbr7CbW+vli4dA3NhZPVwM1Q/ChBmFzfrT1b9ufIDRT7Ny4Mv8+z+
   P5/p0O+sAHix+2S6fE2GZWR091A7bvI1oLdPPU9dWx/hVghsB+/+3eamz
   x8F+F/O52c207PEMjOPHPO/CGRzAJRWoeFRmYEomQRLNZ6z7dfGv0qjoU
   b+RH48tQtPddc1n89O9hiscP1ZVClCZ376i4/EL69z1ToaY/bDvV5N+gO
   w==;
X-CSE-ConnectionGUID: bwQpvU3hSfK/BpGsEMphqQ==
X-CSE-MsgGUID: fuG5WSUGRSGwZshCGamc4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="54289036"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="54289036"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 12:08:40 -0700
X-CSE-ConnectionGUID: WXUDRrvtSpOP+Q6Q86M5Eg==
X-CSE-MsgGUID: 3rnnNP+zTuCsf+4EA3kTEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="127446626"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2025 12:08:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Mar 2025 12:08:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 12:08:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Mar 2025 12:08:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8jpxmqP/tLZrxudr8y+V6Mv8ti5D6BVIpuiolc1Am2xeOVNhbyZKLpvAWELipGWBJnjw6AW4Lq8cLUq08nv4Cdjcxe6qOS1trE/DCts6CkmbJffrgbtd7aTqUA1OYqgkeZ43xupf77jqgJ971zZvZRTLk95ml1DDgmvs1JSs11lnIOQhV5UVMfrlp7XNn4CEI/Z8iArkK5wT2JxpagJMulXGHGQTasz/tD4ap1oIjzeyZWSH16YsSKP6QxbREjzFcQ7/hoW4xs96wFFhKTVh5nXXGcgmI0ekZQkq2fLgNesphBiyp/GWsUx/B0sWsiuTnMBwwxJn3p+zogzPmmLeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4w7tu5uR2DDJIKvJb8G4Wr79YvpR/GQCnU94vqciI8=;
 b=icFkYT1pc4QOPtROLLIQ8M249r5SHS7FSesWQ/Hhwb7mT/MYkqM9HVh4EU3i6jySJTnuMoNsM9MG1m/RW2yjK0WClvh1icJh9XJkrwlQp/Y109tIqcbPDnEqAGXOFEU4z3lBYT89KchGHm/2fqtWwAB0iEgOZ8bdqDHy98IwNsWZCvMkHqYiJUchPWkqobsgjltwJ5UgyGeVrrlxVbfv2nOHMf4bHH71G0RoiKeXgwF//YUttl6WPGQifYrK/cOduv89a4BVdX05e+AjRJHFK8WrIHauejMhi8OKCRMyMqjXiJF8Ae2NBoELhyrEt/QRVNO4heY92BPjbquO9Jyo8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB5310.namprd11.prod.outlook.com (2603:10b6:5:391::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 19:08:30 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 19:08:30 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Alexander Duyck <alexander.duyck@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [net-next PATCH] net: phylink: Remove unused function pointer
 from phylink structure
Thread-Topic: [net-next PATCH] net: phylink: Remove unused function pointer
 from phylink structure
Thread-Index: AQHbmPbnUWpLfrKWhUKDVAMo+j36CLN60puA
Date: Wed, 19 Mar 2025 19:08:30 +0000
Message-ID: <CO1PR11MB50898DAAAFB98B401BBBB7D5D6D92@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <174240634772.1745174.5690351737682751849.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: <174240634772.1745174.5690351737682751849.stgit@ahduyck-xeon-server.home.arpa>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|DM4PR11MB5310:EE_
x-ms-office365-filtering-correlation-id: 513ab20c-fd85-46c1-0a80-08dd67196fe6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cm9RYnkvR1BOSnlhdkhacEtJeVplRm5taEo0SHFBTWp6by9DMUtoVDBYV0gv?=
 =?utf-8?B?S25JT09EZDNrMTdXS2JIcURDWjBrVkZ4MFJFK2tDOVp1SWVZVTBZdUdCM3lx?=
 =?utf-8?B?K1ZXeUl3enZmSForV1I3U08vS3QxSVJaM1Y4QS9DYzQrVlRoNTcrVGcvSGdn?=
 =?utf-8?B?SkxSbUNPTHRkc0w5YlF6OXp1OG5QZXVNK2xNSVpVa3M2a01Vdmtya0lPMVV4?=
 =?utf-8?B?L1FXZ3hYWFRZaUFkYXFhZEt1UlJJWnFENkNYZ2tnS1g4SjV4Q3dKYjYxSHk0?=
 =?utf-8?B?YWN6OHgzekFTK2hwUFJVV2ZhQXE2eGJ4NnRteFd5ZEFoaVZNTnEvTStiQjNR?=
 =?utf-8?B?cVJQVGg3WGMwQXdidFVCR3YxZ2R0NTI2MGZwZzdEWjlRODM4NW9YK0FsY0h6?=
 =?utf-8?B?dTU1alhRNEcxY0dHUGFuUHJKV3hsWENFWDNVcmdzYnBxaW5KTGUxMUNJa1NQ?=
 =?utf-8?B?Zk1CalozWVJPOHBiSlMzUlkwUzA0dG1xY3YyL1hFOGxHRVJxaTJiaWlRc0N2?=
 =?utf-8?B?SkgwSS82SUFrR1NxcFVoNmwvS0pMWGJlYitXTEtMc09KM25KVlZvemFUSnNi?=
 =?utf-8?B?YkRqNzdMTisyb2tqdlQyZGdZdk9QQnZqN3dEWXYyWWYvb00vZlhFNnN6ODlZ?=
 =?utf-8?B?a3N1dTVyNk93Ym1Va0JoTWYxc3B3M2JlMGZhZmxoenhrRUt0NG5tOHN1RFJu?=
 =?utf-8?B?U3RxY2dBMVJQa0R0YUt2KythU1BidXVGblptdllwNkp5STJOS01ZcU1jM2pS?=
 =?utf-8?B?ZGVwSXEzeTYxWFRwT05pMGpvWkNjUm11dEVNand0ZzAzVjIrSzY3MDIrMHNU?=
 =?utf-8?B?cGVvYjV4MnBUNU1OUVg2bU5IMEIvWTg5b3RyWkRKRWtoaHNxSCtOTmQyeEgv?=
 =?utf-8?B?dzIxcGdqZ3FGejhlNTAwVnRkdEpzaGwxd2YzOWN3L1N1Mkc0UVN4WHVXc0Jh?=
 =?utf-8?B?Z1pvUkFUdmVvTHlteFp0bE5yb1JLOGhYMWRORTFSMnVyMG1CTnJoVCs1R0sx?=
 =?utf-8?B?b3VoM0ZZSEtPSTZWN0I0V3NCR3RKNVU0cnpickhxeXBITUpLRllDNENCZGFS?=
 =?utf-8?B?NFYrY0JDVTEvT0xjUHd2SlVYQllURmFDaSthV2lKblBPSHMyWkJjWms5T2Jk?=
 =?utf-8?B?V2IyWXVPTnlhSm1mRHhKN3ErcTErUUhTQXlCbk5TNmkyb0xVWko3NHlGc21Y?=
 =?utf-8?B?V2hOS0tGcDlldTVtRk4rZ0RoLzJxR2phaHRSc1hVNENCMzlDOGEvMVl1OFJz?=
 =?utf-8?B?Ymo0TFNvdk93RElLZ2tqWnJId2hwTU5GcVJtL29xNHk1ZjhoRTBBR3BHQTVw?=
 =?utf-8?B?Vk8yamhWME1ZMVIzbmw3UTZ0Mkt4RG5GMjN1eXEwK1BzeUw1cU50dHB0dTV6?=
 =?utf-8?B?QStGMW9NOHQya2gvREVvUUlKMkhwV3RPZTlqVWpGTFh5WEtLbnRQdDl0RnFM?=
 =?utf-8?B?WTNTV0tZRVkxeDZ1TFRkUUQwZ1o2ejY5QTdjUGZCem14K3lqc09McU5LVExy?=
 =?utf-8?B?TUNZc0oxU2hOQitlZFFMMHJuS2cvcmxqWGhSb1UxcGpuUXpUZlJ0Z1NxNnpt?=
 =?utf-8?B?QVVUdVp6QVNiU3B0TUxGV3N1Ti9IOUkrcGlBYTIyT3lydERSWkxjODNrRmli?=
 =?utf-8?B?VGVaMW9WRUNrbnE3eGJ1QS8xd0E2YzE5QnRKQ1phd2xBTEZVVHpMQXpaemkr?=
 =?utf-8?B?RlJnQjUvMFdYQ29mOXR0Tmx2WEhnYzFrTG9CdGpHYnErSzFqUWNhbWVtSDZl?=
 =?utf-8?B?cm9VNStkWXlzbXFVUDExNXBEMlNtcC9QU1JiNkNNQlRRRFpOMG0vUm1KU2Y0?=
 =?utf-8?B?cEJlTVh0YUgyZmEvUG50RjV4dTlUbnd4QVpRelpiYllPWGNFcjB1VGVFOGxW?=
 =?utf-8?B?NGZybTRPZy81SS9LNE8wUnFUMDMxeTdNejBFa21qUVBHemovREwxZFVvVUJ4?=
 =?utf-8?Q?xHlZeywRjRu6hkhVnPYCoj87m6lKtC9D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFhaQXJqTjZzaHhpVUFYT1F0WWxlQk9DV0RWRDBnclhFYzZBTkZncFB4WVpC?=
 =?utf-8?B?eTBxUDR0eTJsRk81VjBFRmF2MTVFeHdMdkFhOEZjMWhpT2hzMm9KWnhiL0tS?=
 =?utf-8?B?amFqdE5xaEYrR3JLSnl6ZjhmQ3BETkJiNUVNNFRmUXluMENaREpORDNBK1lI?=
 =?utf-8?B?SGt2alZmTmhpUEV4WjliSWhPdTNmMDVVWTJRbS9heFV0cEFsTmxNa0NnREFT?=
 =?utf-8?B?YnZqRDZPa1U2dDh6UWUwLzZWaW5acEVUckFMbjgzeUZCeHdTbUhtUkFWZEMr?=
 =?utf-8?B?WjFjZm4yL3BBRzBEUng3RTQzMnk2SkdwVlYwdmxmMHAvc2VUdGgvRXZEUjlv?=
 =?utf-8?B?RDZYUitTOWZzdHMxcmJoWEtmSExUQWMrZ3FnSHZqN0JjYS9LUk8xbllYWDIr?=
 =?utf-8?B?bUV3L3lUbUMwM3FWS1IyUk1UMG50MkhvWjlMa1dnOHlHUzdYQVZOWVZnamQv?=
 =?utf-8?B?RDlVZElpejRBakg5eEphaVRiZEo0cFFjaGIxeHdkK290S1ZtS1NwNFlzYUZ6?=
 =?utf-8?B?UGJ4Y3NZR3pHUTlEelhsTmlsUWZsTlZJdXhST01kektud3Y0aUg4Sll0Szdm?=
 =?utf-8?B?Y043d2pIaEw3YUxCMFAza3NTNWZrbjBoQjlMS2dCTHlqWFpGMXV2REtGdThS?=
 =?utf-8?B?Rzg4NnVWZmZ0VnVZWUFTc3VneTlTVitZRTVjVW1BU1A5TElJdk9VUjRUdVcr?=
 =?utf-8?B?MnNveVNhOHh3S3M5TkxqWVlGcGZVR25FY3lBS3RsSXpGMDhCdU1FSHViSkdr?=
 =?utf-8?B?QkhMMERya1dpVnVQbHE4MTdCMlhLbm4vZGdwY1VmbUJEUVBpeko5SlVMZHBG?=
 =?utf-8?B?c1dTL1VFZzg5SkxHbThNMGxhRmZaTlY5NTFNYmNQTkFrM2plTWpTV01vdHdn?=
 =?utf-8?B?MC91SGlkdzhNSW1rOVhJcFhPNDhWTXBQQWpNWkNqc1Qrc3NTYUJVMHFSaVJH?=
 =?utf-8?B?ZmVoQ1hLWVZFL1haYVpRa3J3dnpxejZXM0ZkZDA1ZnIweWxjeHJrK0pnZTh4?=
 =?utf-8?B?STREYWJlb3d0bzlxdWRmZ01kaWxlUHRkUm45dldVamQ1OHZFWkh0WUd6VUU3?=
 =?utf-8?B?U3VLRFJKVEoxQmJuT1NUbEt3TG5BbXlKTUFQS21XODBDVGFiUktaYk5YZmwx?=
 =?utf-8?B?UFcyZXROOTQ2a1Myb093aytYM21PN01vd0R5ZXlpUmFVWUpCaWdUS0xnaTJV?=
 =?utf-8?B?S3lDMW44N2hpdDUrRlRXaEc5TlZHWVNnNFd3d3hiZEM1VWJhSUhuK1o3ZHN1?=
 =?utf-8?B?R2JpNEpFYjA0SzlTQ1FiUmxJNEtvejRSTzErbTNWaEx4UlV4aEZhYUU3Y2Zt?=
 =?utf-8?B?czQ1RmxWMjhMM3FId1BMTWxwbDRmdnNoaWp3M3FTMEtmdGVLSW8xTGViOXRx?=
 =?utf-8?B?blk1MDlLUEI5WXk3SGcvSC9QMmNDVzhjaTRMUitQREV2emNRaUVMdkx5VXlj?=
 =?utf-8?B?ZEZvcG96S1h0a2lqMmJJVStFL09yRXo0Vzk0YUNGVW1CTWhuY3dxcDgzdHZ0?=
 =?utf-8?B?VXlUdDZEV2didEJYd0dYa0F1UEtxRnQ2VFRsNzg3M0NZVmJnRm9ySDFFU050?=
 =?utf-8?B?Ry9BbTdZYjBhRUdHQ1pYOFh4SmZiOUdZa0J1aitwejRJMkp5dC9rWVZ3bXJY?=
 =?utf-8?B?QjNoMit5UVJKWGtUazA2eXBrZXdnMS9wV1BPNklYdTNjM3huV3RyNUp5MHAx?=
 =?utf-8?B?T290UnJ4VVBkcDhpT3hKTVFKelN2bFlUV3NIWjFPZHBaYTdjMERoRWdDMkZj?=
 =?utf-8?B?bVg4OW9Zczkzb0dUMWxjZjNEUFUzQno1L0NFODdrQ25QbHhUNFlvcUJ5Z1FO?=
 =?utf-8?B?WnM1MHFDc0R6ekpFeFB2a3NnVVZadjBKYW1scjlYSnh3Z2tkckFzNGpkL1pN?=
 =?utf-8?B?MVpTYWZTay9vS0xLay9yRHdYRkpHaTl0d3VBYURNemQ5UTZ4aXk2WGphc00x?=
 =?utf-8?B?MWx6ZTRVbmVFWE9ubkE5OFdDV1F6d255akNvZVpsalJJb0FjbkZWOVZzNFdJ?=
 =?utf-8?B?S3hsKzB2WVhycllOVFN4UEdrd0R4VlJwNVZOM2JQWXNjRHBzQlFtWVExV245?=
 =?utf-8?B?T0ZYUHV5QktUQ3Bkd3hWV3Jma2ZUNEY1MnNHNjBWcFRqSkdscGVocW9IRWJx?=
 =?utf-8?Q?IQkKOdsHJLfAtxYgGNrOcwfWJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 513ab20c-fd85-46c1-0a80-08dd67196fe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 19:08:30.5459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zs/Hi8vdENQ2nhmiKyR0bvVtVIX0+e0B4pnC5Rgr/Ef1iEL/n+MnuDLQ6e+bThY2FvpTtfAWX2/GqOIEaXXEeePxCC/Hisfq9ysO8eiPUgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5310
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleGFuZGVyIER1eWNr
IDxhbGV4YW5kZXIuZHV5Y2tAZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDE5
LCAyMDI1IDEwOjQ2IEFNDQo+IFRvOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51
eEBhcm1saW51eC5vcmcudWs7IGFuZHJld0BsdW5uLmNoOyBoa2FsbHdlaXQxQGdtYWlsLmNvbTsN
Cj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNv
bQ0KPiBTdWJqZWN0OiBbbmV0LW5leHQgUEFUQ0hdIG5ldDogcGh5bGluazogUmVtb3ZlIHVudXNl
ZCBmdW5jdGlvbiBwb2ludGVyIGZyb20NCj4gcGh5bGluayBzdHJ1Y3R1cmUNCj4gDQo+IEZyb206
IEFsZXhhbmRlciBEdXljayA8YWxleGFuZGVyZHV5Y2tAZmIuY29tPg0KPiANCj4gRnJvbSB3aGF0
IEkgY2FuIHRlbGwgdGhlIGdldF9maXhlZF9zdGF0ZSBwb2ludGVyIGluIHRoZSBwaHlsaW5rIHN0
cnVjdHVyZQ0KPiBoYXNuJ3QgYmVlbiB1c2VkIHNpbmNlIGNvbW1pdCA8NWMwNWMxZGJiMTc3PiAo
Im5ldDogcGh5bGluaywgZHNhOiBlbGltaW5hdGUNCj4gcGh5bGlua19maXhlZF9zdGF0ZV9jYigp
IikgLiBTaW5jZSBJIGNhbid0IGZpbmQgYW55IHVzZXJzIGZvciBpdCB3ZSBtaWdodA0KPiBhcyB3
ZWxsIGp1c3QgZHJvcCB0aGUgcG9pbnRlci4NCj4gDQo+IEZpeGVzOiA1YzA1YzFkYmIxNzcgKCJu
ZXQ6IHBoeWxpbmssIGRzYTogZWxpbWluYXRlIHBoeWxpbmtfZml4ZWRfc3RhdGVfY2IoKSIpDQo+
IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBEdXljayA8YWxleGFuZGVyZHV5Y2tAZmIuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvbmV0L3BoeS9waHlsaW5rLmMgfCAgICAyIC0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMiBkZWxldGlvbnMoLSkNCj4gDQoNClJldmlld2VkLWJ5OiBKYWNvYiBLZWxsZXIg
PGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
cGh5L3BoeWxpbmsuYyBiL2RyaXZlcnMvbmV0L3BoeS9waHlsaW5rLmMNCj4gaW5kZXggMGY3MGE3
ZjNkZmNjLi4xNmExZjMxZjAwOTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3BoeS9waHls
aW5rLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvcGh5L3BoeWxpbmsuYw0KPiBAQCAtNzIsOCArNzIs
NiBAQCBzdHJ1Y3QgcGh5bGluayB7DQo+ICAJc3RydWN0IGdwaW9fZGVzYyAqbGlua19ncGlvOw0K
PiAgCXVuc2lnbmVkIGludCBsaW5rX2lycTsNCj4gIAlzdHJ1Y3QgdGltZXJfbGlzdCBsaW5rX3Bv
bGw7DQo+IC0Jdm9pZCAoKmdldF9maXhlZF9zdGF0ZSkoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwN
Cj4gLQkJCQlzdHJ1Y3QgcGh5bGlua19saW5rX3N0YXRlICpzKTsNCj4gDQo+ICAJc3RydWN0IG11
dGV4IHN0YXRlX211dGV4Ow0KPiAgCXN0cnVjdCBwaHlsaW5rX2xpbmtfc3RhdGUgcGh5X3N0YXRl
Ow0KPiANCj4gDQoNCg==

