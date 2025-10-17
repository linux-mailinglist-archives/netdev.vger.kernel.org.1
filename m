Return-Path: <netdev+bounces-230263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C42BE5DF2
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 02:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F294D4E563E
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 00:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E101E521A;
	Fri, 17 Oct 2025 00:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NFmC2m36"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F017D1DF247
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 00:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760660479; cv=fail; b=n6xsVsPOs4AwEnsDjDkz5F6LMSjEETPHpcO0xUYwD/5yfQonLSk/T/sOUjyvhsMA1tDUGjvp0odl6/azC7rS/OBYOGFZwCxv6B4xhi4xdwBykG6WIPNzvwxq41hSbU39Z0VoIfqesRg0kyI6WHM78Icc3F+xj5MUyoty8DDziF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760660479; c=relaxed/simple;
	bh=gOPbcZkUwyNeS84wn1cFPDFRcAsDnI3Ny2QcT9KbvDM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=WWhLhX59pS/RK0NoFrKf4jaXtRYDGR3CRkrPIMx+DnCL39nQ4DGOwvisw27xj13mjPqmyYqf0IVxOfbZ1x8z+7avGdS1vm9s8BIBtXwpYbj9bDmMlcc5c1IAbsfhdzXQtpgxeCC99OODrIro+CJe1z7HH9CHSp9Bu9WOWnF/ZwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NFmC2m36; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GHg22m021059;
	Fri, 17 Oct 2025 00:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gWRiAA
	G+3KWJu2VWXudBlMycBBLdd198A4k5w7Y/9n4=; b=NFmC2m36M8iVypJQkjM2QB
	0SFxvHIgIG4vwRKBxqzsxQ3MtzStoRLIDOTQKVvOhya924B0RsDONKQ73LkzlgSo
	mrVTwCCoZagyRmR/k8zSIW4yJxPROf8f2pMwX92i1BuOKFoi/0gnB73JgYdk9BlE
	ygpMW4jwnNAAE7vQZ1kc7fbkDy0K2knI6aHo/uqKcJbE1tzzdfeTmRhqVDNltu4+
	WOVOEhEDdC6xgc64clKPiM0nn3ftOX7TWJ7fv+10lhpSmnHSgxsR6GuGfp8l9nlZ
	nZA3wvVZmC+S4sjrtMT9WEhd/qJNh7bilW1sBzNNdFScVtd6WhZ44Z15x74Jf7AA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew0ckef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 00:21:06 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59H0L5l3023953;
	Fri, 17 Oct 2025 00:21:05 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013044.outbound.protection.outlook.com [40.93.196.44])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew0cked-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 00:21:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqa8RqT54x/oRHkvQp8rUcxe67p2NzjI7W4Eb6xwM8VqCARdt57U1ntnIfyORI2mFW/BvnjWwc6xv3Of+L9heHraIzZBtfQATeoM1RcWJqCrMPMXzrvsYHzAa+PkEWpXB7ySTBrDAbDh1EnhPAR71M+lzVW2gEnrOarAgdTknpuRhRgYXesZ0wNzZfcZbRAGyp8uwP3y4hSmO6IumSxiUDvm2r37w9HmhqrdqJQGHA28Fq2Puc3BWsSpDfTAUG1+vW6svusWMD7yKbyzis8SbHu5/B1PyyQWvrXckpKiQHnqVpaXYMUBEHGG4/U+DPYXFjzU/pmzuHcfUiKqfvn/6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWRiAAG+3KWJu2VWXudBlMycBBLdd198A4k5w7Y/9n4=;
 b=mzb3ALLiU4qPOnescnM8E7+MeZjVd7T97ceHqVD/uBdeg6eQpp3XDaM3tZRCohRsKOO4vs6dBpjt/OoTYevaEEqMNx08jbGhFEvGxI7XhUAd9+gLYCZxVt7hn9vzKM5TYhNHZN7dUpIlTLadVIYIv5TqAv6NZZWV5NKgaMnQ2e+17rFrnGpZT8MH2vEUupgfTgzOYhdAr6FDcgTnSjMNdY+ogt5NhXdn4zc0iG4dITMIQ6Xk7sEjRmSdFc+KQTW1YAnbWL8rx3KEZ1CgT4e8NUw/H4ghgL6cmIoTy5PeFy6GPD5aztj5qPWUtq80N2CkuMf1A5LP5cZ43lJzfkkIpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3913.namprd15.prod.outlook.com (2603:10b6:303:42::22)
 by PH0PR15MB5143.namprd15.prod.outlook.com (2603:10b6:510:128::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Fri, 17 Oct
 2025 00:21:02 +0000
Received: from MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490]) by MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490%4]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 00:21:02 +0000
From: David Wilder <wilder@us.ibm.com>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "jv@jvosburgh.net"
	<jv@jvosburgh.net>,
        Pradeep Satyanarayana <pradeep@us.ibm.com>,
        "i.maximets@ovn.org" <i.maximets@ovn.org>,
        Adrian Moreno Zapata
	<amorenoz@redhat.com>,
        Hangbin Liu <haliu@redhat.com>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "edumazet@google.com" <edumazet@google.com>,
        Nikolay Aleksandrov
	<razor@blackwall.org>
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v13 6/7] bonding: Update for
 extended arp_ip_target format.
Thread-Index: AQHcPJyjleye9we4VUOHrCeB+8OXEbTErQUAgACFoACAAD2pHg==
Date: Fri, 17 Oct 2025 00:21:02 +0000
Message-ID:
 <MW3PR15MB3913E83123930C417DDD1AC8FAE9A@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20251013235328.1289410-1-wilder@us.ibm.com>
	<20251013235328.1289410-7-wilder@us.ibm.com>
	<ef443366-f841-4a84-9409-818fc31b2c0c@redhat.com>
 <20251016124908.759bbb63@kernel.org>
In-Reply-To: <20251016124908.759bbb63@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3913:EE_|PH0PR15MB5143:EE_
x-ms-office365-filtering-correlation-id: 2bc1efd3-8bc2-467d-c5af-08de0d130e2b
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?038WZb9KMBsuc/bJhNEyFcFNrs4MM+S8TVrNT9fc3KRI9VxwxhogiOlXW8?=
 =?iso-8859-1?Q?bom1U4SFWNVxbJrW+q/g4aBOG2NNfLE1CqkTNXPunjixY4X9ZRtKE762g0?=
 =?iso-8859-1?Q?wlmRV9QX51IEGalufw1glJxspmFO6o/uXntt7iBE5OgqiHmuBaMFs7oqKb?=
 =?iso-8859-1?Q?XB9fqRfXaSBoNjYt282Mg+QvLA2tKQHOZ6fQOCH7fcryqT2vasCbBINN+1?=
 =?iso-8859-1?Q?NuCmJZUKXyZ/aGK6OboJ6ypNjLT7YrKBhHtvu+bIRAs1rP1/ed+bEti0jD?=
 =?iso-8859-1?Q?zhUi8/4UEbya0sZ4ctJe8OyRpGI4KUfh4A3qdpku6gZQjyauVaVGIvLb0J?=
 =?iso-8859-1?Q?QcYgddsrgbYeA5k4sFChys3WgZp5n9AswB6518dgF5dfZf5U9RWyeAPj1B?=
 =?iso-8859-1?Q?Qy9VVbw6uwKwof8NDDtEdTnQIDg7Ab44yA+4ug9TV2d/fmo1FXpXjannAn?=
 =?iso-8859-1?Q?bzIYf22sXlQUsOrafd3ySmKJVhFahapGWlOghKILj1YMXl7OhZzR3FqUmY?=
 =?iso-8859-1?Q?4tz9xebbSIJw/2cZ1YYrv3Sh2q+2+LuEQluR4PwMRqONW5xoC7ezEBfWYK?=
 =?iso-8859-1?Q?5avDeBx+5vBCLTiX4fFVuHd4RBw0knZ+Lxb0K9YZMfmKzaOmvhZE0O7Afp?=
 =?iso-8859-1?Q?4xMJo6UIBPh+/fAfqvu25/ClQLogBZcTQEWShBBVRO46JkbXw3sBhGKY4L?=
 =?iso-8859-1?Q?UQdc9n6ZkkhCDxkMzQ+n+hSDHHtmwy4YSZl5VD+YHoN4ljfWSZv6AwTGap?=
 =?iso-8859-1?Q?kHA4O1R13W3POGpC/DKrKXIdcdJvWw6NBIRDu//0+jmxh+fNYXaH4hvidz?=
 =?iso-8859-1?Q?/tYSLBAN9yQyVC9sUgJWlPX6qhy/hChscDutq1VyWfhHJBmLxd0fsC/zj0?=
 =?iso-8859-1?Q?NYm7LBTYlIqjIz+hDNwtdLvGt9MT0jdwCS2SeEU9EQMFZRgmjZFU1bAzEJ?=
 =?iso-8859-1?Q?vGwoHX40+SzawJG+30osrZ9/NgWzDcXg2wo9fHQ2j9/HDMl6nJO7HS6faj?=
 =?iso-8859-1?Q?SUddf1892LKVpCOs5jTch+06Hs+CC5q3qhmGOFJf039OynoD69Y4v+uktO?=
 =?iso-8859-1?Q?7HlrkOjujpls/P9/rgQ4NXzsbIUgeA14iwxyHj35plfDOTztXpwpTOCkrp?=
 =?iso-8859-1?Q?Hm0oxV5BIs4HZ9pbntD/eAHYEUD3syURvEFv1hbeIo0d6N4SspIGkrdvRJ?=
 =?iso-8859-1?Q?s1hApEjXXWMSxhWUsflUbTH1G/7Yfto4N4zWSgB73ifzSHflHs6YZQEVrd?=
 =?iso-8859-1?Q?BDkJsWyY+irImyr9RvFksf1V4FEiJJ+Twmooso/egAjwBUWEuCgqMgIAIe?=
 =?iso-8859-1?Q?E5/kAxPWZfBzYQilBNiVYps4ptPhyL9D4WrkLteKogLwAjPM51DhFN1Smi?=
 =?iso-8859-1?Q?M7EDAblY8HGyzESuMUIwVS3w1jV8fyUlJZuJZWrQPYSyfofdvynFJX/n22?=
 =?iso-8859-1?Q?n4J4zjlpI7cWGzdfyazkMFcCGgUHfe/ZwOMcFwUOtQ6SCzN7F6OMR9I5iR?=
 =?iso-8859-1?Q?bCk+iNYJYW6GMoC5+7irJvdzWmY6Fg1ynMlOjU2flWTLTOkiL3wn0cc2qh?=
 =?iso-8859-1?Q?SjsOjgC6OmMOo5ZZolZIgJWc23jC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3913.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KeGjWK8cWiCsqmoGucOAKE9w7+5TadGcldcWGTWpZ5rIIuuFtPSsjGapl8?=
 =?iso-8859-1?Q?HDzfzMU8G4YQGOjkkj3aJd9wgh2lsiSm8KdHzOam0yvWpOtycWf5SAVD0b?=
 =?iso-8859-1?Q?/fIxia1qO3ah3okc+PY24YUI4lovlwMfNQb6RJeRRtHB0/Qi6AuEwmLYLP?=
 =?iso-8859-1?Q?xOnIgN+14iV/sUbpQPL6P8YLdFk5BSWQiQCUUy3zxlb82Q4SgaSwZWV4xz?=
 =?iso-8859-1?Q?5nH5OTuFT/pPBbynFuZDQb4z+TxdbLbrs0w2HctpCZaT+K44FfAQHqTonH?=
 =?iso-8859-1?Q?b5CVEDQbEQMbPvHQtxseg2OlLaq0xrCpVHRnrlJyTtHgTFp+m1ECR7rbUW?=
 =?iso-8859-1?Q?hWDSdMUUMdeqQ+A1BoI/GrP3osCFhBOoJJn6SF5jTmZaafz//SpgktOv9q?=
 =?iso-8859-1?Q?HGXjwmQk1kFw/H8ZJcZb6QYP6C8oN26fOn7Q8ykAB69uXRCrnLx+gHCBzE?=
 =?iso-8859-1?Q?46w8sS7w6KbU7rvJRYoUfYUv1JNWgbXJgy7iQWopE+rtXpMMLAd4/6IVld?=
 =?iso-8859-1?Q?C/RZUt4sfyVfeNqysdr1wuKd5IVkZb9cvedFh8k3aXwC21cpxQxGh1sJ3a?=
 =?iso-8859-1?Q?qASTlZ1wIqhvdjsce649H2QAGJksfTdQnEfLLyQyhbtgTJDqe/Spx+ErBJ?=
 =?iso-8859-1?Q?O9BIBxzBO9us9cNA4VP1pYn83f1mPI07g+pUPCz2efjGAGWeYwT4bW4VWm?=
 =?iso-8859-1?Q?hEefP/cgZiGSdJlkjrohdzYSLvsVExil1OdQbsSlVfzWkvHkfimgTK7Q/h?=
 =?iso-8859-1?Q?nT4qTZSWmWR0UJ//7KRBKFZjqOq7nducAsWuHTj7SDt93n1pohWj56Rjcu?=
 =?iso-8859-1?Q?x4WO6I12AMSsIfXzUtQWY3G5k5WK55V7hC2MgNvxn1WK6R0xpAho8FVuJZ?=
 =?iso-8859-1?Q?SugumcdqZNRD0++k/F4cE1T25dbVUSLyeDBy7ivX4bn6v/PGqvZBHpgHVw?=
 =?iso-8859-1?Q?1/shf3klLn+NWYpok0A/C3hpYIStQ2Ik9XwklFcj+mW0rwSEhZPgUpiNhP?=
 =?iso-8859-1?Q?gA2J1Lb7tZi4u1x4OBamviEX95NPCEdCxhU9P/biPcCD/8kNK1kduZqSYg?=
 =?iso-8859-1?Q?bJAbFwRu8bOyjHer0uvWgGC1RSwX7w+KNxA2Ji3hDPsYS3Z24kewhUKHKg?=
 =?iso-8859-1?Q?v2cte2segxtUt4HN48c3mBXzD+gqILAHUvSKnIJcRqd59QW4/vIP39lqqP?=
 =?iso-8859-1?Q?9tKX+Tti4XSrBke0i5vy7E3ANlCwV282yLKtaKXAXjEfPnFDvTjtnb/h74?=
 =?iso-8859-1?Q?wuBYC2U12nMNWiBQAmSvQjYGSsmjgqkFTxHfYFBdQ/NGCPe1FrXEYXWWqL?=
 =?iso-8859-1?Q?5+BFVX1OEbLz6PKBtvLrsgQ7HUkuUy6N4ras5iuT6wHm6RVPMGHLRlj0Hr?=
 =?iso-8859-1?Q?ZxqYncsEoHW75fRqfs2jksr8F4YJWKeFBsTjPTB4P7SrgLGDb5JYl4tkc8?=
 =?iso-8859-1?Q?PbrXTMv7G54vR2TENmp5E77OkRSx4XgUvGQXv+O3ekeUbMbi4fcJc/sC6m?=
 =?iso-8859-1?Q?pMsvyvWWPBA/LnUuERxmSt7Spu8f5o14xioE19Tt6c1dcpQw2tFRbPtApC?=
 =?iso-8859-1?Q?qAriN+WUPJRcMxIdAIbM87U783ALduLDtTy8rXKLmCSOxl8fTHg6x+J/FQ?=
 =?iso-8859-1?Q?wW5c3NdskweVU7OIOT3oHqWTuCB26FNt55+Mv6waYnBHyVJla2ZOQ7O8pp?=
 =?iso-8859-1?Q?OlMRdxk2oXodwKpELKA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: us.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR15MB3913.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc1efd3-8bc2-467d-c5af-08de0d130e2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 00:21:02.5920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZHg0AZbU9C5hjleijDWLCEMhU76XRXG6TGaK8ujmWbQf5/irpuZvvbSCQxkUrFwXxTKDLrwJS26QygQqS9ACQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5143
X-Proofpoint-ORIG-GUID: ihFxMaczagqP6SJya6RY-Avq5a_F-8HY
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68f18bf2 cx=c_pps
 a=Ji2ygefkweamrNJ/4LFw0Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=2OjVGFKQAAAA:8
 a=P8mRVJMrAAAA:8 a=jZVsG21pAAAA:8 a=1XWaLZrsAAAA:8 a=_LbzDLI1FjSnaRFkkbYA:9
 a=wPNLvfGTeEIA:10 a=IYbNqeBGBecwsX3Swn6O:22 a=Vc1QvrjMcIoGonisw6Ob:22
 a=3Sh2lD0sZASs_lUdrUhf:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX1Z+jYKfv6fR1
 cTothFMRt5IvbYhPhP7YW4+QRdagkC2HvOevgRrn93Y+t6bz+nhSU3q+38a3jv/FZjQPl9Mczor
 scfGC4y3jnx/obQPoiMTlOIOVWqKJj0Gjn1DhnreM415nu40sDSHk0GaSs+CN5/w4+mC3uCyKMA
 pPIIvKfZsWloI4dXvqO+m1R7kYg/244SEE30ez6qu/cqaE0imxZ856JFjjooh71T9x16SFcLoTc
 RQ9VuLw8Hkno6lN2k4IPHqFkHb8XAtFJTEg8+fdKQfdJP79Q+1JmiWxiJeWyvOFSIUsBCTrbdGG
 00SwCAkbZmw5ySHWvpkq7JZTaxlia6HcTAsw6B8TzhmLlaVdyq6tG+o9IuSryXJeBNKI5nJJs7C
 XoGk2ma/jm9SxdwFmstB61VV56sPew==
X-Proofpoint-GUID: Nq6YScG0NhgKNpnjX-qHAikNMrxrf6-b
Subject: RE: [PATCH net-next v13 6/7] bonding: Update for extended
 arp_ip_target format.
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014

=0A=
=0A=
=0A=
________________________________________=0A=
From: Jakub Kicinski <kuba@kernel.org>=0A=
Sent: Thursday, October 16, 2025 12:49 PM=0A=
To: Paolo Abeni=0A=
Cc: David Wilder; netdev@vger.kernel.org; jv@jvosburgh.net; Pradeep Satyana=
rayana; i.maximets@ovn.org; Adrian Moreno Zapata; Hangbin Liu; stephen@netw=
orkplumber.org; horms@kernel.org; andrew+netdev@lunn.ch; edumazet@google.co=
m=0A=
Subject: [EXTERNAL] Re: [PATCH net-next v13 6/7] bonding: Update for extend=
ed arp_ip_target format.=0A=
=0A=
> On Thu, 16 Oct 2025 13:50:52 +0200 Paolo Abeni wrote:=0A=
> > > +           if (nla_put(skb, i, size, &data))=0A=
> > > +                   goto nla_put_failure;=0A=
> > >     }=0A=
> > >=0A=
> > >     if (targets_added)=0A=
> >=0A=
> > I guess you should update bond_get_size() accordingly???=0A=
> >=0A=
> > Also changing the binary layout of an existing NL type does not feel=0A=
> > safe. @Jakub: is that something we can safely allow?=0A=
>=0A=
> In general extending attributes is fine, but going from a scalar=0A=
> to a struct is questionable. YNL for example will not allow it.=0A=
=0A=
I am not sure I understand your concern. I have change the=0A=
netlink socket payload from a fixed 4 bytes to a variable number of bytes.=
=0A=
4 bytes for ipv4 address followed by some number of bytes with the=0A=
list of vlans, could be zero. Netlink sockets just need to be told the=0A=
payload size.  Or have I missed the point?=0A=
=0A=
>=0A=
> I haven't looked at the series more closely until now.=0A=
>=0A=
> Why are there multiple vlan tags per target?=0A=
=0A=
You can have a vlan inside a vlan, the original arp_ip_target=0A=
option code supported this.=0A=
=0A=
>=0A=
> Is this configuration really something we should support in the kernel?=
=0A=
> IDK how much we should push "OvS-compatibility" into other parts of the=
=0A=
> stack. If user knows that they have to apply this funny configuration=0A=
> on the bond maybe they should just arp from user space?=0A=
=0A=
This change is not just for compatibility with OVS. Ilya Maximets pointed o=
ut:=0A=
"..this is true not only for OVS.  You can add various TC qdiscs onto the=
=0A=
interface that will break all those assumptions as well, for example.  Load=
ed=0A=
BPF/XDP programs will too."=0A=
=0A=
When using the arp_ip_target option the bond driver must discover what=0A=
vlans are in the path to the target. These special arps must be generated b=
y=0A=
the bonding driver to know what bonded slave the packets is to sent and=0A=
received on and at what frequency.=0A=
=0A=
When the the arp_ip_target feature was first introduced discovering vlans i=
n the=0A=
path to the target was easy by following the linked net_devices. As our=0A=
networking code has evolved this is no longer possible with all configurati=
ons=0A=
as Ilya pointed out.  What I have done is provide alternate way to provide =
the=0A=
list of vlans so this desirable feature can continue to function.=0A=
=0A=
Regards=0A=
  David Wilder=0A=

