Return-Path: <netdev+bounces-104684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D58DF90E03D
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 01:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594A81F22C97
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 23:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A4C17A92C;
	Tue, 18 Jun 2024 23:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0rUfp4x"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533001741DB
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 23:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754896; cv=fail; b=gAQntSep37YINyYZxsp8XV+F4EfDsq0YBbUl1FVDudz6YJ55bcSQo8jAg/6SL9DuPJ53nqnBhQnLDZhrWpopqfmXHaUCdC0CzjVBydtx4hHcaixy2DG3KOh9SJVtXSjCYLrfCrq6VvsKzjMHYDMDc1m1K3x5RZ4imfjTk7SQZtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754896; c=relaxed/simple;
	bh=jST3ZPrfQKgiC9axKE4s0JlCQOM3Sf3kTJz1Wv1rYD0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZW8d3gZC5J3MsNnc+f8fj91q5aXzwk2M7VPqp2rBUKFfzjuwbRH5tQTdY9uUsSyjFdkflIX2Ss0uRSx5For0Jn7c6H5uEgTd4vVEVnzcxu15ZTljeY5MHG0oGfVb/o3tBsL/KWmf5CSEjfssxkBL+YgfPkNguSK/ZwggtF6U4j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0rUfp4x; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718754895; x=1750290895;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=jST3ZPrfQKgiC9axKE4s0JlCQOM3Sf3kTJz1Wv1rYD0=;
  b=d0rUfp4xiKi0KKQdglaBP8xpgYhiQCOERotrmXBo7G2/sVSxmCSxRfKO
   FKmicPZ1vuQM+ef3WXfV3J+khu2d9FPzGlBq5j6MqyyrlRXKuToUMUjSo
   2Z15p2nwq9UiiodntVx52HrXwfmJ7CzEt6YCCaJxCdt/EMhEgc1uV7P1i
   eOnO2qtdPMh/ErRTkU0ySmQMblfPtPhF0qJkvPMCCTl2uQfPSapqFe8nl
   x5DuWGtVFBgq7es0eOep67HFYpl4byyc+xk46ET/zguGy0/E5N8gkoDPX
   +XVlO3jbQw+pg+/MDNbccD3Dw9v+1GRqivWy9NmIWnllb48iryh3blEpe
   w==;
X-CSE-ConnectionGUID: sOc/j7qmQBCSHT1T5lmCcg==
X-CSE-MsgGUID: gIr5qFNrT3q0RqEbfMsd9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="26300765"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="26300765"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 16:54:54 -0700
X-CSE-ConnectionGUID: mq0EzJG6TK6GBkCzVRjF5w==
X-CSE-MsgGUID: 0Vl21vxYR4i4/icDnVaPJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46282019"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jun 2024 16:54:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 16:54:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 18 Jun 2024 16:54:54 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 16:54:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoH8Cqltx3Rle2FpKSZk4P++hFQtk1+pqnoKSSDIsDTpn5rPQJAJ+e4HWLT/bzFrdcxRzBRIjybhKcEQ6LHvF38AZ0UgJUvUDzSBo0kelx1B9YiCgm9WK5s4PK0AIViuTV2APTgcmJRmBezUM+DyD9bgqWLD9kSGtA3qyws0ThQy0XOO1M9dRBlIblricshvqwBasai5I/sMuXm8ozS+girploqvxeItca1M8SZdKuX8DT2x95Icxi894ZH6OsRHyVrpQynb9cIW5/4ts87OUG98gvIaLGei6QGxJxQL0OpGtR11VgNvPe5rfAkw2d102HwNJYNesgW09P0UveW1yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnz/DOVGu5sDwQb3yvtSyqADwcyKwc6BEORb+b6xtpA=;
 b=PbDTZQsRYfUr3DBpN5j29aNEHEfF04WAtaQfxYy1y03xaHo12FHkcWDld8hOFOm/yog3jMZIADywInvqhcBlwxyNFYetsCdbcw6ndn5qHtSxJULhIjWZlrhXWOIbdJpYV+IDbHlIRbvpIrNMk22JYnf7u/X8KujgTlG75K/JMKoOroA/ANZ3JNeIEsF/pUHr0+pOKedbZNxAWL2INpkFGcknxKj0zYPtNtpWr1jP6HXTl2F9jjUEqLGKvLqchWnWzRZD+okQf96Ff755kaP66vLBfVds3BVMQ2LStbynShx7tBlmZ8ofcj71uIm5idy1nmaStO9IG0pMksBmjfqnXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4993.namprd11.prod.outlook.com (2603:10b6:303:6c::23)
 by CY8PR11MB6915.namprd11.prod.outlook.com (2603:10b6:930:59::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.18; Tue, 18 Jun
 2024 23:54:52 +0000
Received: from CO1PR11MB4993.namprd11.prod.outlook.com
 ([fe80::92:1a96:2225:77be]) by CO1PR11MB4993.namprd11.prod.outlook.com
 ([fe80::92:1a96:2225:77be%6]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 23:54:52 +0000
From: "Singhai, Anjali" <anjali.singhai@intel.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>, Boris Pismenny <borisp@nvidia.com>,
	"gal@nvidia.com" <gal@nvidia.com>, "cratiu@nvidia.com" <cratiu@nvidia.com>,
	"rrameshbabu@nvidia.com" <rrameshbabu@nvidia.com>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Acharya, Arun Kumar"
	<arun.kumar.acharya@intel.com>
Subject: [RFC net-next 00/15] add basic PSP encryption for TCP connections
Thread-Topic: [RFC net-next 00/15] add basic PSP encryption for TCP
 connections
Thread-Index: AdrB1/ByhY5vhdaNSxq8hQ6vCeqC9Q==
Date: Tue, 18 Jun 2024 23:54:52 +0000
Message-ID: <CO1PR11MB49939CBC31BC13472404094793CE2@CO1PR11MB4993.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4993:EE_|CY8PR11MB6915:EE_
x-ms-office365-filtering-correlation-id: b17dca1c-4774-4059-5319-08dc8ff20bb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|7416011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?HYZRgbaKxomjp2qPxURI6gUkSfOkerHEgzBbUeuG/6O7oFHoAx1k3vzsmz?=
 =?iso-8859-1?Q?QCFrPi5kLzmii3g1AqsNI8Nwe4PFkIJR22VYQZYyZo9BPs8lMw/wN/4gns?=
 =?iso-8859-1?Q?hJcKKlMDgGfLEbBpEfmrzizGae6rD2UF/FH+B18hOYPJ7PvxnnJ3SLKoF+?=
 =?iso-8859-1?Q?j74iRizdm+W5oE3VOJRDD6crz75ITfnWugf+QE96SDqAgmPkR23GzFOSJk?=
 =?iso-8859-1?Q?jRL7QL+5aWLMvkzhHaZ2xiY/iXHB8VOIBpZTVWVNilZcQvO95s6I2L46eP?=
 =?iso-8859-1?Q?JpJoyhfbSpYlFkL9692zpPvcDZX8/PY1JyKhiz99Gz4sNow4Kj5GD4Jsp9?=
 =?iso-8859-1?Q?v36n6XFlFqdrCCWaWPtgA3giNtzvwprtTqQ6s93gLtLgn6Y4Muh2m+VqEM?=
 =?iso-8859-1?Q?YZUn6+9Aafn/I5tweOq5fnOPl8qf2NPofBKWbU3Rwkq0qT/1kUoWKECH34?=
 =?iso-8859-1?Q?DLmN8dZbpJLJyz4oqvaXqMgwe4vvUwEUocjTHEVvRSBNhPYKc/rE/7a/L5?=
 =?iso-8859-1?Q?8N6ddu+fRMq5YOiH162CQWnDC+fSJy+IbNt3k9uEqFmZSv3+GOjPwr2H7m?=
 =?iso-8859-1?Q?RvVdzkzKhBB3eUJkS5q//LZ/rKppoVnUTO3pelm16U+IqI8laFia/4FIza?=
 =?iso-8859-1?Q?yvJYAawtZGDoANO++7k7fSOrE2DYDOvYnQQStZUSGBJctkK68oB5oIy40w?=
 =?iso-8859-1?Q?U57uYVIag6p7revAdliwP0r09o9kt53LuHvfFsBqxy/QJoiTJknIkArMwf?=
 =?iso-8859-1?Q?NgIP+SY9hdoQhssRLuFTEq9r2zwvJHRU9Q77M4e+QFMwLTTi4xWvIUTj/L?=
 =?iso-8859-1?Q?gEadFuSrTFZFdXL1AOrj+Cy7GnEqOq7LZzXcUYF2t5SdNeseebmlwmc4RM?=
 =?iso-8859-1?Q?X3M0wNQrvNSvzKxQ6bJCe2prVZP0UlFSZ1BDiPRiUGg0HZtUOKT/gCgoHO?=
 =?iso-8859-1?Q?KEtLlX/zUDSYOR8NkKossUcEmOkxyz4wywcO6MF7fbrOWvKwE2vREa85aE?=
 =?iso-8859-1?Q?WF83bnaSzN/ZM3lUxl7wWNkymb+grSfcZITenMbksDMiOSTEtDp4oSNks+?=
 =?iso-8859-1?Q?MOwbqmycfWoLdWp5BRZrXzy8uymM3KJ/t6JJ++7adTydTEnw/uys2lbsAs?=
 =?iso-8859-1?Q?/XoA7bVt07CcCSbIpM+PliWFixWaCyokTTuQRAiWQyQ4BLY7DF9vDq9zyq?=
 =?iso-8859-1?Q?UiGRuCjEBs8+qQkiUQY0Lhg9uP6ywcXreAY4Gb3MbyPAyLDqF/9JwOgI1x?=
 =?iso-8859-1?Q?B/qUEZrdlKaR7LkDqmUUKjDugR65vgaMO85cS+VhgU9gAbyXzuM7lNpDY2?=
 =?iso-8859-1?Q?H/KpEZ3yEV6hzWoXYAtfK5Jlw9i2/0XffpsH/VADmpk4aS8Z15jiOCEeH/?=
 =?iso-8859-1?Q?kdID+1XOTb?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4993.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PG1pdmlzFJd0PZ0ZtPilqKLDWAbtZWZkMu0aHcPAtTUn/r2pn7KB/ePQC5?=
 =?iso-8859-1?Q?KqHwemc7Vu9H9uJW1Y6VsbT5aEtJEg5tVbvMxXIB4zxwnlttjkF9vVQl0o?=
 =?iso-8859-1?Q?kspxcWZAUdjdQI1pg+Bct4y/uNPWyeUyYbexQmvdahUXZInzTdYNKDV0qr?=
 =?iso-8859-1?Q?0pfvTSNKpyij4x5LQhWLAtaG+Z43jP/8q8bet+efZek92/vf8yDLRj76mf?=
 =?iso-8859-1?Q?iTERjMdnN0lvym7sDOO427IjhvC7eWilrZa1Erj8HKL2baU7FfeYYaetQw?=
 =?iso-8859-1?Q?W2DMUl6omGT5t1edPPetKGbSzqVmhdtVUSVR5K5gYZktJRPmazlyI2Zy0e?=
 =?iso-8859-1?Q?0wIixJfvubYNROxaODmr0vmEMmB/hRrEnTCJVDQVNJNNG9AUnzU/2AP6Lu?=
 =?iso-8859-1?Q?OctT3qMtPPCa1W3d8cBxvPfbPboLoUXYONLMhT6AMXJ1HnqYe2j3vgoB9C?=
 =?iso-8859-1?Q?RP8sGaMOW34HCbr/CwBmixXY7LV7PMI+LLGbEqq9YlFIdVZRaZpM0kK9xj?=
 =?iso-8859-1?Q?B5kJi/go+Exs3L3k9wNOeFDDy5+c5nvW5sNyvpCsRwSFGyVJCTTnLlhyHw?=
 =?iso-8859-1?Q?T0bTGbEffz+Zc7DSTuAx3ia/jfnh/9q7kqUZudSUPtPFsNRWl4FkQM/HiX?=
 =?iso-8859-1?Q?6PCQkHQTPU+VgZZGCd6FaUFGGbSmrQo4CoTcBhJAFC2cnTycxlhJTDqYOj?=
 =?iso-8859-1?Q?fUUjNyMMOg2n1Kuxg0EwvSqIn4uyCrKQB8kt5cB7k2UJApiW6O2tVvsLmc?=
 =?iso-8859-1?Q?fmVNONWReWr8J/NPs5oGzwTT01ftiBUjrCjMtcgmrh0Yw9lK+NdGiIIvZZ?=
 =?iso-8859-1?Q?oYmFf23PZbtRSwsPgqE+O41JrBbQA72TJjs0N4vTeGUHhr9PiNfR5C/tJ1?=
 =?iso-8859-1?Q?MFm4LIwFE8L/RDLBHNN4h2VaIev+lvWNiy9zMxQ5LNCr+ZWGkcpwp5HM5p?=
 =?iso-8859-1?Q?I5QhbEKV9r+HM7f2a64ojnsVrVmT1JFs0hgLvwDasRDOJtzvM3hJsKmiHk?=
 =?iso-8859-1?Q?Bb5VWvmDa4FZmwbYooOA8SxZ2FNmPuBRo7Byh/rqGgDYBFZ2/5nqkejIZt?=
 =?iso-8859-1?Q?4IxtPWuzMu7kfmgGOqv56mkNJRp4xvfQSsZvKkuCOXTee1vVR4n7RCU03v?=
 =?iso-8859-1?Q?nO4jeuHsVCuDAkScrZdfU/P2M51IqWbRib/5r69i0cBIlPE4ojWvgdftY3?=
 =?iso-8859-1?Q?jAqYfKvkcX9H2dhBdtuD9MnOqHPDSc5qFr9TKjGp+xYimzPb1eoQA5a5Lc?=
 =?iso-8859-1?Q?TML5qBZmZPhp+gap83CR52LWEhFTyC7i08lx+NQxUDRhXuryCpRMLzdOH2?=
 =?iso-8859-1?Q?LI0nEaux3nPwNZJ25ZpngzhW4HJaIf2xQb9bErI7Sdn0edTEuTRzA+twwO?=
 =?iso-8859-1?Q?l2RQXTM6zPrfdZl34OWLlS2O3h4ncg4OJVS52AlN9l+1vgzXQcQd/NQ9Tq?=
 =?iso-8859-1?Q?I9slllhF4f0cplhBCXK0MBhOG7PcZa9dWKOiBWvUgkqIZzMxvoTDTAzhud?=
 =?iso-8859-1?Q?/ttp4juNyx1e+NyDEUt19spSmhjkI/Tq+JLKwbUeCkzUXA4CpHkNj4mb01?=
 =?iso-8859-1?Q?9Qf5AfSZzGr7IexL324NyZXnhRxQfK5aEwKSUa33B63mcbY8ZOX5Q1AYim?=
 =?iso-8859-1?Q?rxkoCx6eaTELr3cJoMwYPiVvUQAEP9JkV3?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b17dca1c-4774-4059-5319-08dc8ff20bb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 23:54:52.0383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7TqFUta5nGOZeO5YApqQ/jPAC3AL8g1e54rKGFcqN2595BQ9lvoD5HMaV8v4j0HMUwlMqQRYQSBQ1nOb4O5uKLNXnPtuvECEfHFdJzU9nS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6915
X-OriginatorOrg: intel.com


In reference to this patch series
https://lore.kernel.org/netdev/20240510030435.120935-1-kuba@kernel.org/#t

Thanks a lot  for the PSP crypto enabling patches in the kernel.
Some points that we noticed that could use some enhancements/fixes

1. Why do we need =A0ndo_op set_config() at device level which is setting o=
nly one version, instead the description above the psp_dev struct which had=
 a mask for enabled versions at a=A0 device level is better and device lets=
 the stack know at psp_dev create time what all versions it is capable of. =
 Later on, version is negotiated with the peer and set per session.
Even the Mellanox driver does not implement this set_config ndo_op.=20
=A0
2. Where is the association_index/handle returned to the stack to be used w=
ith the packet on TX by the driver and device? ( if an SADB is in use on Tx=
 side in the device), what we understand from Mellanox driver is, its not d=
oing an SADB in TX in HW, but passing the key directly into the Tx descript=
or? Is that right, but other devices may not support this and will have an =
SADB on TX and this allowed as per PSP protocol. Of course on RX there is n=
o SADB for any device.
In our device we have 2 options,=20
             1. Using SADB on TX and just passing SA_Index in the descripto=
r (trade off between performance and memory.=20
              As  passing key in descriptor makes for a much larger TX desc=
riptor which will have perf penalty.)
             2. Passing key in the descriptor.
=A0             For us we need both these options, so please allow for enha=
ncements.

3. About the PSP and UDP header addition, why is the driver doing it? I gue=
ss it's because the SW equivalent for PSP support in the kernel does not ex=
ist and just an offload for the device. Again in this case the assumption i=
s either the driver does it or the device will do it.
Hope that is irrelevant for the stack. In our case most likely it will be t=
he device doing it.

4. Why is the driver adding the PSP trailer? Hoping this is between the dri=
ver and the device, in our case it's the device that will add the trailer.
=A0
5. Five way handshake, can this be optimized to 3 way?
Here is what we think is happening right now at the IKE level interaction f=
or the two ends of the session, as PSP protocol does not define it but base=
d on the implementation this is what we gathered.
  Looks like its 5 way handshake that is happening with the session partner=
.
   For example two sides are called Tx session partner and RX session partn=
er, just because TX initiates the session creation, of course it's a full d=
uplex session.
             1. TX session partner sends over sideband tls channel to the R=
x session partner what all versions the TX can do based on caps learnt from=
 the device driver.
             2. The Rx session partner replies with what common versions it=
 can do back to TX session partner based on dev caps it learnt from the dev=
ice.
             3. Tx session partner tells the driver to generate a spi an se=
ssion key for the rx side by specifying the version it wants to use for thi=
s session. And then sends to Rx session partner the spi and session key and=
 version selected etc.
             4. The Rx session partner at its end then talks to its driver =
to generate a spi an session key for the rx side by specifying the version =
sent from TX session partner. And then sends to Tx session partner the spi =
and session key and version selected etc. The RX session partner also progr=
ams the session key and spi it received from TX session partner in HW in it=
s Tx SADB (psp_assoc_add)
            5. Tx session partner programs the received SPI and session key=
 in its HW in its Tx SADB (psp_assoc_add). When done it sends an ACK back t=
o Rx session partner that the session is ready.
=20
Should this be optimized to a  3 way handshake to allow for faster session =
setup? 1 and 3 and 2 and 4 could be combined in an intelligent way. Again m=
ay be there is already an optimized way to do 3 way handshake here and the =
kernel-driver flow still looks the same.

Thanks
Anjali


