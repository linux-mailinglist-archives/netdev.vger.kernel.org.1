Return-Path: <netdev+bounces-97847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF438CD839
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 18:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16F51F210ED
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B951171C2;
	Thu, 23 May 2024 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iGVb3xqE";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="56LMTt5e"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E39111A8;
	Thu, 23 May 2024 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716481062; cv=fail; b=BlrL+EAUwYx1nXAgTzJtRJQ5QGDkwtav7rRLd0uBRLVttvyYz851xeBjelvR+0zujZOhiS8gbfU+Rpo9KdkhgohGc8TjEjFN5JwInUPnc/Fm/0jt0k7jxsZrK2FmlFAMdVe0Brrb/ghz2Ye3DkbkdBPZ3mmhzt9YXZqxQn1Uzs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716481062; c=relaxed/simple;
	bh=qcVTfOiO7UXdnsYNQ6WcqUa6aY8toLgzIjSV9QlXolI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hVwwx+NFG9s3WBn60WC+tZdRqUwdsZLPcHdSWnYACMEg3dcP83SwCHcmPcdkoyDRD3/nZ3kP441Hjmuoloa9QrgFUhzFCk0mCjo8n3n85ydDUmRlFJ5lzjxInXXDKTehejRb7EQnViJHxpTz06NB37HHhKXd7M+Eq/PHvhjh78g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iGVb3xqE; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=56LMTt5e; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716481059; x=1748017059;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qcVTfOiO7UXdnsYNQ6WcqUa6aY8toLgzIjSV9QlXolI=;
  b=iGVb3xqESkCB80feSIaL2UBuE/FfxmAE/NxsqduMuoXJ0yXeiAfDFKx3
   zb0Qm2QgXBIYPCjWwx6k3Ou/FP/E+uC63/7n8/3jdbR8CaqYlDdGSiMxx
   clZ/14o93wG2WqXwkkIvRtXBarP20f3lp0Nr4hOkY95Ia6afpmsucD+fz
   n4AvMTnVG6d/4DWfbvfLdDr1Im/EDzSL5qTpYDZVNEj1REeEZscASv2RZ
   QCCRLVIlpmUfFUzmHG2rytA1qFf3Uexh7tX4v000l2nEjm2RIr5lrhVmD
   qdZHQxJmGGpRNt6s/9jniBCPtihJASaMbSfJdNKIK0LPaXAsn++7lethr
   A==;
X-CSE-ConnectionGUID: n4zFRR1+QLe/eE7hrnwSQg==
X-CSE-MsgGUID: 124UYbr9RYWOfmsebyjklQ==
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="193318994"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 May 2024 09:17:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 23 May 2024 09:17:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 23 May 2024 09:17:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+p6R7ekRL3QBaMhX5RRSMShTGpbfFM6D9aE3dILFn/JSMJ6jUPyRSOGKfwi7WZkbVXG4jUV8NZHvBNEs5wdiONAz+z2r/oohZVJICMe+H/x2jtXS/VhvJt1TttntFS5AmshPA8UH7W2ruCnO675tsnZqHxXQLfJ+EE2R0aD1oIdfk8j6oit3Dy/EbgqgHBlyMALhCwym9TdhnypIS1u7iDBAYqVo9KKcY5uTEh+WUk+xSi4/1QW3bs5erfKvDhk3SyUP69KtIUeIIWj/aVyVrvNPc7RQx1zNobFfZnwXcWnEmtYFUfwNoqWg3ePSkEMSwS9S9j3eppmvECNS9t6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgySCrZnh0+W+urKx0OG8RqIFzzr3M0HhY1GlK6xRng=;
 b=MRscfAhQCiqmK5kgN7g3aPPFlyKtqAkDcBXh2V1O0b6/89mHO3PN3cuPi1NhX9pdQj+GZ0hvvL7NZfXo6Eq+gPNxsJR7jtMtmXdS0sri0C6TLdif4gIPRV0DGNfzh2jzhgwadkU2ASccvdovdOh3n09kFQWjHhaJST29nEEzUtp2QPOx3pNrwePb7ir580WvXT18gPBpB+xMV0zujeJA5L89dP/a8vu5sBaYmthTCuzViyeGJE+8QzXUMMobplXrrn5C/M1mEm2WXFp4YsupVtB0BOQKKSXD0ekbuzp7tI6LWpJ5HeKT9IQpskRIYANSUjmTPQpelYP5OtzL6SenjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgySCrZnh0+W+urKx0OG8RqIFzzr3M0HhY1GlK6xRng=;
 b=56LMTt5emZXd/BjyH25N/SgzbAyCZnjnTe4qy8C+ethrjDgAeqe1B3NgYnJxE9zGGymi+IOR3LD6UMTWCin9Z5wQFNOfnXCI0fYsyouhD0i13qZYHn++3mXVEF9fEx/zE8pk7+MZAnxN2HF+jJxZEEAa1cs81fYeev9lFzEtY7GL1zI1BZ6YfD6V6o6N3k8MQTZem+5EhVoKRiSozIhvN1I8aOasg3GuoiI0zpYygqda6tx5AHQD6p6Iq//M+C/rpOPMwvT1JmCBh2hqFbcm1rsSye349wnEhduS/Y52wimgZJHSCfXMo4CEHNNHrAMRDxjSvOiqV+NZ3MYz6Sm0ng==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by SJ0PR11MB6695.namprd11.prod.outlook.com (2603:10b6:a03:44e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Thu, 23 May
 2024 16:17:10 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%7]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 16:17:09 +0000
From: <Woojung.Huh@microchip.com>
To: <Parthiban.Veerasooran@microchip.com>, <steve.glendinning@shawell.net>,
	<UNGLinuxDriver@microchip.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Parthiban.Veerasooran@microchip.com>
Subject: RE: [PATCH] net: usb: smsc95xx: fix changing LED_SEL bit value
 updated from EEPROM
Thread-Topic: [PATCH] net: usb: smsc95xx: fix changing LED_SEL bit value
 updated from EEPROM
Thread-Index: AQHarO64heFno/z1gkqlQ83Rc4JXn7Gk/xpQ
Date: Thu, 23 May 2024 16:17:09 +0000
Message-ID: <BL0PR11MB2913CE81AFC08F2D619C3B6CE7F42@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20240523085314.167650-1-Parthiban.Veerasooran@microchip.com>
In-Reply-To: <20240523085314.167650-1-Parthiban.Veerasooran@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|SJ0PR11MB6695:EE_
x-ms-office365-filtering-correlation-id: 8c507c97-11d9-450f-a239-08dc7b43cbea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?SwbE5dbT7cMuypaFYK3UIkKQbg9HAuR2gdeHwqndFcOWaRnYyuG1QkhkovXD?=
 =?us-ascii?Q?L+TqsfXayTTZAiCCt4DHKyRVZRZK3GOJ6OxDluWkXoMA/R2iwKEuk2c/bPYS?=
 =?us-ascii?Q?aF7RXitmHzjap5VQ6HVN0rysLMP+TskcpMqB0tdAQpibGTLJGLK6BY/8ZRce?=
 =?us-ascii?Q?DtO62R4JU1kA2vFgFl6tkhDYCl/lu/9gpLNz1T2Uo530COqfNiasxAEMZLDI?=
 =?us-ascii?Q?Rl3ue26gv/1KLZZ7lOODRZEcQ3tOL2V/PWbSCwNhnzWNYcJQRJJzYCeB/5kH?=
 =?us-ascii?Q?obC9e6j2maZXtlxTvBUReGFi/Zp3YwcgPnP3B1qqSxUxQVPdGbgtGf/SOgV3?=
 =?us-ascii?Q?JtTfpfg0mlNQ3hy3zKSDKjg/kxxqIk8BrwwJI0zwKqEO1Q7S9q0VEr55DFPQ?=
 =?us-ascii?Q?uQbw/eOiW9kBgUQ82C9G5TVwJwkKO7ABxLhVV0ZDpq4Mlvxn2vUKI2UWSTIc?=
 =?us-ascii?Q?nkQvpbNzslIXxlSRJEpCp5miBoplkhaRozVxZa9cSHo3nTBJOGKN1PAonAip?=
 =?us-ascii?Q?JXlkZAhHvVGhtz0astuOz56g5Zetp2ELRb1hNgjivwh3tr+Fu6UASmAmm8KT?=
 =?us-ascii?Q?27woKrWYII5AmgyPc9r86UD/5/l59619WHbFU+iQcogZp0i7OoaB8GOvpfYx?=
 =?us-ascii?Q?dJoUvYbBMW0LpNETKB/ku1Hq61pgo9612mT54C86cE6u2Lw09Z6Ie9MFuemF?=
 =?us-ascii?Q?1lo5biQjYR0EZ3RCVRe0aZGKWLQvmToUuaHWkALz4EvV5nYG7/H/lnG4vSPJ?=
 =?us-ascii?Q?JmBjcIRHehBfZZ5aG69tsY5pblNZSo6lkFkDyWtkRDxToFuLe9lUzLpaFnTJ?=
 =?us-ascii?Q?cqR2hUMrOdHSdyw61VsHrthVy+WFyXI8EC8zlrloIU2pHqRTVVWpoPDiijXn?=
 =?us-ascii?Q?g7HZHuMljL3ZyFM+NNMcGlNvr5Gyxl+1AVxRunstPEmz5zalebfD0l019QCC?=
 =?us-ascii?Q?3SkkRPV49fqRJquMRpYTg+wHSJXo23MADGn/MsbBqRln6K3si7YeIpe+ISc/?=
 =?us-ascii?Q?w/O8AbeAkRbHpkhKLh9e+B+cMVE4Ds8yYBXwo3XeatRyoOdedj0Y1z1eNV5s?=
 =?us-ascii?Q?QgBuDU9V/a5l2fy2HQtthDlQLEoXjfE7PTvUxzsc6CW31MPgnfNeqLVl2eC9?=
 =?us-ascii?Q?q2AlEqNqidKZA8tZIyTJzDIS9/PdAb4EP499hZtL8bOgFEV0VMoeefTXVoza?=
 =?us-ascii?Q?aL3RtWuPVUdwqihW/geLbhNcCBoAOpPP5S3c9G34oUJjChgYYAYxZ9yfQzDH?=
 =?us-ascii?Q?5UcJ78TY1PLf2iGtnNhdq2oF6diPl9FIVCuT2D5dNj7W5wjsw57XzvbEOb9h?=
 =?us-ascii?Q?49ya4lOdagpNxpfEXgY/y76NELq9oA8cZwFOWJerLowNbw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yfZxOOKWwsyDHwED2CNylFHYBQj+JOXtzNBGYKgTplNa9Be4r9ejhyiTxSuc?=
 =?us-ascii?Q?xN9/Q5D2WjpA55uhiSg2GaJnLxOEbLkV0Ypdn2u42i9SgZidCxJRQn5xcGj9?=
 =?us-ascii?Q?Yewfz8fyEZUknFWqwrGsl2FhXHBto0NkSPIx3n4nJ3tsmh1q9XsILUuL2S3m?=
 =?us-ascii?Q?0r45gUZg7E0c4eLv16rZdeRk02vy7Rh0mLFBRgz4Y/dNxceYC61NY3cqmdVR?=
 =?us-ascii?Q?9nMJwLaUJIlMg3EIE+LNYCFQPqhwZpuST5tvd8nDFiFV2ajAeyEVG2WYDYM4?=
 =?us-ascii?Q?9WYvOpSVKjcD3/KQy/BjO/UPwpdCLkJMmZrm1VfBQvvB1fTrhyMCXMtGkPKd?=
 =?us-ascii?Q?3iyUJBgctztTbA137cBww0ySE2Jm+TTCatKOHnytB8tddbdJH3djQbDClId4?=
 =?us-ascii?Q?clNLQv1Vewymb4BuXMZ1IunTyng+G/mbv8R6rv50Db9GXtRoa1ZeBI0LVMRR?=
 =?us-ascii?Q?rZwumOhA5w6YwwIFQ1B4LEZRb0fwyGv1Nk76zlbi9/dohB/ecAxWuaIEHtZL?=
 =?us-ascii?Q?BtXUzwAoXGST/X2Eo5dpd1qPMja6D+hLMaZmgKq7+Dffm+l/JGmODYU9OLK7?=
 =?us-ascii?Q?pV2xanMRbW1baUuOVWBYxgc7YDvqjtW3UajNoipczXWdZwqeIUTYp6BOO09+?=
 =?us-ascii?Q?kBvsdCX6+dhrittyBUI2EO9id5/lWGa1nup8ZzMrs2Q93k5YmuEmxNCNHi9n?=
 =?us-ascii?Q?VIt75dRmwVdgUHk7rvKpv5duCo/21szuZI8UlFi/Hv9sZFkVEOgrECddTC+e?=
 =?us-ascii?Q?CD/LdWEfTS6e3zdPFJgpHDyuenF0gZY+593WBWDrXh7bDszdzFXAWvNrLgKc?=
 =?us-ascii?Q?8FkFY+/cMik9HEfr91HDenZeLHmXalP70vv3Vcax9MbevatsvjfwmgZep92p?=
 =?us-ascii?Q?qk5Pn4q57Ipa+9MWJxi0HMXViHJZ4GQk5ZMLmpDJ8AMGXGOD/akXttv7diQi?=
 =?us-ascii?Q?/sH193xe1KtSvWMvfuvmMT3Bm6shhPLSIOeUB2KP9PMjfb/Q4QhO9B5jJxs+?=
 =?us-ascii?Q?ANQuWLyIMoJ4dvzy8OkEVZeJEd+jgN5jqTZhNXNxVPW5gTP+wi9MXJpBOZge?=
 =?us-ascii?Q?t7Mq7DNbdga4DqxAisz+kLFGA98t3vwuPAk3O6BVq6tru8E5HJAv6ATxgf8F?=
 =?us-ascii?Q?Z/SZsHsBzppymYP5Plugk0gEJDcaiokp4g17cmqmlmjQA6r2+nT9vAoaOsAx?=
 =?us-ascii?Q?BjpApxCZ4zVf3/yEunaGAiQPWDF6xTh/gcPcu4Jzd6Omk7FU4qM7H3eR1/bo?=
 =?us-ascii?Q?Gi6Mm3Nkjh7CS7UeKTZ7UTKVZe6kLfkyHegvB2r71mytYl2UaHgTtx4ERyy0?=
 =?us-ascii?Q?fckFhN/prYHWZNAt+50vBEKR2RXb2SfpSmSdrEVxQV8FoRo7KFES2hfKjKVa?=
 =?us-ascii?Q?NtWr5HJS6+3EMG/ChorcZC5m5I5JiAcPWiYH5autMDv8135ouIgSzcB7seRA?=
 =?us-ascii?Q?2Q8Etph0dgnL026lPwO06lsiiYqMoNhTK8xta129W7NFltuKmqXDsNsFkPgi?=
 =?us-ascii?Q?lSl8Cgl5f+sR7Sl33jIxmGzNoh20AByIvd7NTElqjXoLPVnkkILAADGpVMsh?=
 =?us-ascii?Q?FWmvONqs+ozmkukj2Qdmo+tIbLglzTxO9jM/P4nb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c507c97-11d9-450f-a239-08dc7b43cbea
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 16:17:09.3772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BnkoZtEcmcHfrlVLUdu+vXP7TUBtAz7u0oAX/QKI6kKhoazjR0eahik11AMvxq9PEHlwa1RbyGgg/Z+nPjUBsKmTkwMLs0h8z9xZOC7fbpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6695

> -----Original Message-----
> From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> Sent: Thursday, May 23, 2024 4:53 AM
> To: steve.glendinning@shawell.net; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com
> Cc: netdev@vger.kernel.org; linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org; Parthiban Veerasooran - I17164
> <Parthiban.Veerasooran@microchip.com>
> Subject: [PATCH] net: usb: smsc95xx: fix changing LED_SEL bit value updat=
ed
> from EEPROM
>=20
> LED Select (LED_SEL) bit in the LED General Purpose IO Configuration
> register is used to determine the functionality of external LED pins
> (Speed Indicator, Link and Activity Indicator, Full Duplex Link
> Indicator). The default value for this bit is 0 when no EEPROM is
> present. If a EEPROM is present, the default value is the value of the
> LED Select bit in the Configuration Flags of the EEPROM. A USB Reset or
> Lite Reset (LRST) will cause this bit to be restored to the image value
> last loaded from EEPROM, or to be set to 0 if no EEPROM is present.
>=20
> While configuring the dual purpose GPIO/LED pins to LED outputs in the
> LED General Purpose IO Configuration register, the LED_SEL bit is changed
> as 0 and resulting the configured value from the EEPROM is cleared. The
> issue is fixed by using read-modify-write approach.
>=20
> Fixes: f293501c61c5 ("smsc95xx: configure LED outputs")
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com=
>
> ---
>  drivers/net/usb/smsc95xx.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Woojung Huh <woojung.huh@microchip.com>

