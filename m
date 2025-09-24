Return-Path: <netdev+bounces-226048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ACEB9B29F
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 20:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 700767B1666
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 18:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11392FC02E;
	Wed, 24 Sep 2025 18:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Bhov2gMZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B59E1C8610
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737172; cv=fail; b=MhivD39GizhQMNtWSaDy0OkyP830Y5VSbzeSIBUpL9sO8y1O4QHDPzu7ndxx+Na8ewZnH75mO8GkbnBJtMOkSlD+MVnKe1ekT+t/h7ccXAcQIgeERhADRQPb68CPi/4/SuXfnOhQBoZxTlmP/t4PpsV5JziOWU8pJN2F/QmFOhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737172; c=relaxed/simple;
	bh=giJEbpZ6rRQnn+vkoERsqaENyXoEgUvZlnokGNoutAo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=STVwfLcqVRgel5CHpV/ouVbUdFHEhxBZX0rWzoPfTBZeGJR6gAyCmgkLlpq4FjSW94RZvRrvyBLmUyf9m5bLzCgPvU0gBJMOtVD405J7iPRiufA9FIapVTr0pJePp+eP24sNWNbtV51WzMyI2iimrHFv1YepF0c8iINJIaL9mZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Bhov2gMZ; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O9Wxvf023342;
	Wed, 24 Sep 2025 18:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=s6RR42
	VbBFdcrP5yBL2zUrKUMTVeg9VIGyEeAxs2hAM=; b=Bhov2gMZxBaTcYvSCqtn/e
	qVj8OzUbH5CPL1VFcX84To6T+fyw5RQwQLxJM6p9KSoVJ+nrx4g/Ud1viig7mAUk
	joDrD8PJogua+ZhQLdUZ603waHGxFVzgBvftUz8EaWgYQQ6BP/ex2CmWULjLXBHr
	3fka+bxo+rZ0QMMh3B8bMQqQTqSKtwo/IGCp4IttkhelkVTNbOcCPcLputFgcQ60
	2UmxJWfbp/zSSo450Z2iXTldmE/XPn+GNhCgQce64u7EZHUiSrSXBLXPmJ1Q91YF
	pZzVPRVMD3lCCrypFZME2EhKglbPQErT5aOgb5+A6uTXhIo+kWcBxYG689HiTLmQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499n0js2wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 18:06:00 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58OI60Cg005270;
	Wed, 24 Sep 2025 18:06:00 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499n0js2wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 18:06:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQ4k5jcVQYyFJUhjO8MDdkcOP9NKgBvnnSo3rZIqcKBdZjds6fc2+Bt4jEEaBWEGkJbCjhSW38MpP4MpWZn96MGLvzzestN7hbD6BPAmW/Tr50CMvnKIm/kf2yip4ZIUur3LewB0/R7cZS9K0o3ox/BPXj17f8a7Xm1JmEzmSUgmxxVnteUR7lOT7tR2BGUrmx+HztlgBr0DRQ8mZYJwyFVscVouSzX8IM++9pWxrijDrbSCe1Agy8nOqw1n/X51sbrnFtXLeOyPRUspeU+3tMGnzGzTjpBEWbfAckOiptGIsLj+OGS5cI6IawnGEMZU6XEW0JjHIJLSW4ci4M13Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6RR42VbBFdcrP5yBL2zUrKUMTVeg9VIGyEeAxs2hAM=;
 b=BbeCRbMUdLnkKtXhnOwstgqVkfUBHN5mqrY0t3uaq+7siwnRBbWr8LEfmN+oELs1oKuRe8YaFV0vd/UUFe6ChAqTpWxB3HgSEun7VZwRMv1P4eNnbkUrvdgNtjMR1l4LK0EhdFiewv9Q7SBl3Ub5Wug/kGFY4T07r1FuQG/4f/IZeKxzrqDWMKR/d5nl5IbWU1GzKC8EXCu9UF52TM+YtytSKz6NkBOZ4G+1v6J6Ob3JVtWxImghPeiW4lBeOnNS1xiZLX7c1wsnPRduIYFisg2qbAxESX8n8bL+T0I0jk+nONYClEAFyJypMwRW0+9WNggdQUIzxXvS3Du1Ejls4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3913.namprd15.prod.outlook.com (2603:10b6:303:42::22)
 by DM4PR15MB5408.namprd15.prod.outlook.com (2603:10b6:8:8e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 18:05:57 +0000
Received: from MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490]) by MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 18:05:56 +0000
From: David Wilder <wilder@us.ibm.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "jv@jvosburgh.net" <jv@jvosburgh.net>,
        Pradeep Satyanarayana
	<pradeep@us.ibm.com>,
        "i.maximets@ovn.org" <i.maximets@ovn.org>,
        Adrian
 Moreno Zapata <amorenoz@redhat.com>,
        Hangbin Liu <haliu@redhat.com>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>,
        "dsahern@gmail.com" <dsahern@gmail.com>
Subject: Re: [PATCH iproute2-next v6 0/1] iproute2-next: Extending bonding's
 arp_ip_target to include a list of vlan tags.
Thread-Topic: [PATCH iproute2-next v6 0/1] iproute2-next: Extending bonding's
 arp_ip_target to include a list of vlan tags.
Thread-Index: AQHcLBFqg8EAKenGOEGaGmgCTfuScrSin6Yd
Date: Wed, 24 Sep 2025 18:05:56 +0000
Message-ID:
 <MW3PR15MB391381C671346B5BA6802624FA1CA@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250922223640.2170084-1-wilder@us.ibm.com>
In-Reply-To: <20250922223640.2170084-1-wilder@us.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3913:EE_|DM4PR15MB5408:EE_
x-ms-office365-filtering-correlation-id: 77520154-ef2e-4f97-44d7-08ddfb950284
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?phJ/7ITIH1GF1WomZOeYj5F/czt5R2atuoPxVT+6P3ICWJ+CcR9rTAKxB5?=
 =?iso-8859-1?Q?V/lpC2k0L9+Yi4E/mKXIRqJVkD39cNTYwK0zYQGEgUGK1jZHACVoIe/Oon?=
 =?iso-8859-1?Q?p2LabBtKcHVPRiK4HDZG2wOWGSEmvCoFVxcVwqa0jUQRP+7Eqbft/d+25B?=
 =?iso-8859-1?Q?1VY7N+maXDqMNgMfn0c+11Vha5T8QeCaqGHqCX3MVvmyRajgMThwKv2OLy?=
 =?iso-8859-1?Q?gKPvfG9+aFbZiXYNC3bixXTSoheUGKCf07BEymkDY8OnaNIrg0h0YnDdzi?=
 =?iso-8859-1?Q?ez2Lx4yAhnmykiY18lpd2j4QCNAG6oKftegp7lTpmj7r1+skjMWOhS1aGi?=
 =?iso-8859-1?Q?TudxkJaTCZ+LYuhrLqjJjnqmAAWFwWfwr2Cx3MPtjB7tCckbBI1rcpyrOe?=
 =?iso-8859-1?Q?ZSJGl4xDw06FWfXYAk5mhRWnzC4hk0w3P/oCPrDUybLmZfvSeLMoskOO6d?=
 =?iso-8859-1?Q?i9Gie14d9k6zw4J+E9AJEkDXvHH/qG6hy2s0bniyz5vlQcfuR5db7qobcG?=
 =?iso-8859-1?Q?xxXmK4hbpgrib6CpQSz0GUHoXUH+5nHULObjmpkFxow29twnJZbooAtx2f?=
 =?iso-8859-1?Q?Uci3pT6OlYJlvz7YDN8FfwxYR4o5Yd7QEUjtPJ6+anUctxt9OmxBR5AaGZ?=
 =?iso-8859-1?Q?xSslbKXB2ApYGf8v+purf/YSzwfHZ4t66acC263fEZsHRKlIFoXiUbtTZ0?=
 =?iso-8859-1?Q?TcuwT5FsMkVCgQbiq8W4rl6OMrGTzVBuwrMAl7GtTgLOmuceb6I4gCKjSK?=
 =?iso-8859-1?Q?ahouuNp79ppoK54tSmz8X2up+7gbINdOMDwPQ9BL6oRpGtVPrp5mU/0Siq?=
 =?iso-8859-1?Q?CHlFUHFG85vN7HXlzSWNAeL7ZrrWkgahuo7o9JHg9jt1g6TpBa10K4EPbb?=
 =?iso-8859-1?Q?fmHIkUkCfKncjULwt4TlVzMTJv25mXqI/yHQFJlKJM/1KAvS+cw1rPgN6j?=
 =?iso-8859-1?Q?MCmIIwJvqZM1yzGxSzHuwP6TUw4mzIRs609l36pmobGbi4TV7HlIC5hoyI?=
 =?iso-8859-1?Q?RUiNhCiviMSl4KOmds0xBTLtxrRyJfFqBjbEU88uKaoQPpihImTEQxRb4g?=
 =?iso-8859-1?Q?jb4wvke4O3woteh+y69RSmhRnGuTUkKrc4+SLApj6NI8PkbcLgRZ8Romi1?=
 =?iso-8859-1?Q?KOqh0a6xMkbTTkK94XyxQS7JT1f2BsSJjLwZUdDGbq2+y0iQAaKgIDO8z+?=
 =?iso-8859-1?Q?BtMw4g1+cmYHF/6oP9OOgxyix+x6APg1D3gjJo8+7SaTt7wSNNCB2Na1rn?=
 =?iso-8859-1?Q?PuhaJDYxnxDBBM3U54nh7rEG2//XlVY9ZSxnS4cBa2N1aelcbrcJXVk7Ap?=
 =?iso-8859-1?Q?4bPcYt/jEVCfavqIZ8Fzc5zKovxu6nh91eLJV4fBmi88RvnuqNCbC2HY5Q?=
 =?iso-8859-1?Q?HsVMzd60pgnQ3U4HEWu3X5PfhBXt3TvApKl2xX9/5fxaubsISGjiubmQWd?=
 =?iso-8859-1?Q?6bdahTG50pmmxOH4HA4VRqtxYxkk0jSjh7hVj6oV8voih+zV2y5akHV/ab?=
 =?iso-8859-1?Q?t2DDpA+ulwBSJGtJtQ9nXicu78HG9+0RopeTig7zjRmqXi5VF0zn7chRnz?=
 =?iso-8859-1?Q?xZy0QTg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3913.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?BfKSJpgHqNEKi53kzozSI7BTRV1P5Yzy6FYyWtvTT74/2wx45utV09YHkI?=
 =?iso-8859-1?Q?/Q1e1F3fK3eepZEL97/CcdHlhdFAQQVZj7gsCGqm/3lNQUbCBmhgW2bb4s?=
 =?iso-8859-1?Q?ZAJLVbmPuNRopeMfOt3PsWWMeh1mipXGZ/mHYijbhq63D1NiPxw1rOtafc?=
 =?iso-8859-1?Q?3YUZRungFXjY9fV2hct+I3P/D+232hXMomzH/0UruPYJyPKCma8tA9Xhtr?=
 =?iso-8859-1?Q?DVkjjl5xDyqPi8tG3rXN8QY1ZDzw4NPyGNwA4P4ECWmcbe9qXqOvy8NoIw?=
 =?iso-8859-1?Q?+vbPvFp2+/w06VdQj3YVq5dF0qYYf+N9PS3TV8muHSzNoUR6JHrLGR9XsI?=
 =?iso-8859-1?Q?Rokw4WBcAshEl8NYbvAN64GvIWV0MS261lDxBRgeejE3E04H2naAXht1ux?=
 =?iso-8859-1?Q?FuJlUyOmnbuG2BJTPtL4PA2hahoEdKzPGNZhebjpxhK57igWZnctt0nD3y?=
 =?iso-8859-1?Q?F2gMCIcvjTVCRmwHzESCADTmu/kSdJU3QWeHYu04jO+RUYZ2eApyvYm1FE?=
 =?iso-8859-1?Q?oOgKZFSkIF4/xTGQCMmhy3jcaJQTu8Vd+PlzP5QsO+nKgUkY9l5FdapO3p?=
 =?iso-8859-1?Q?5gFNvs9GdZwCzy7NgHxU2qoUu2jEx5SedMwVtcP2cPiXJ+Z5ifcnM0ul0Q?=
 =?iso-8859-1?Q?Dvzvqx8bjBndeQntG344IateMTGQHIy6hymt/hiz6dQGZcfXj/2lXA0kwu?=
 =?iso-8859-1?Q?gQq1A0de9sF4+Qj73RXkzyhaJi0iHUpmRLmmWsXj0XVUMIgi+1VhkG+/Yt?=
 =?iso-8859-1?Q?9KtChWj5OYQkK3Vzzy77lSyw8jP+ef2r2qmAJCCREMbpd4qP2oIxxOrkV6?=
 =?iso-8859-1?Q?pPeG5L35ex4uBgTBOPBD/Ij8yX3NSIcVl9CsAy4Z0+FpX+wMFRcXm7GyKn?=
 =?iso-8859-1?Q?iD+Ep9g21wM5wrI5gLpoLsat2DqZmrbupx6DPWGvzzImWAyVxYqicx1c+S?=
 =?iso-8859-1?Q?p84+1/719r/AAFWekze5N/8N8sxvaB+s8VvYMvPYHzQ8v7ssyBgrT/7cY2?=
 =?iso-8859-1?Q?XbpSh1G7VyvGWln/TJ0iuoAQu4V3mBvJ7uttdt/wsEFmqutopWdC885peN?=
 =?iso-8859-1?Q?7iEKXicKLqcJjXL/oW9MJrarCsLLshYEsfFbdIzZBOYkFpqwDyyfmMqx94?=
 =?iso-8859-1?Q?AvRYKFps2xVGd2oTrgKv/s/Y4o3kAtYy4/Wv5Gzwcrv0A4vsXqbHJcgMuY?=
 =?iso-8859-1?Q?JO0rhrFnr4UMwwt1pXtoux3zZuhvXqiWgni8mCR1IYYtQxGvq+ZmyZwzKI?=
 =?iso-8859-1?Q?rQ7jIckiJ736hw7LQowiES2/oPAL0hmJ7mPsxIzq3Alfv9jpQ81z07nbyq?=
 =?iso-8859-1?Q?J9nuryj9uiUwsCesTLI/4nSbDbaf/CVoYkekX2vTQ9S4LPQfVhVjWmWKDu?=
 =?iso-8859-1?Q?bATnvN5rmsOQcLY3Rw6q5vletqwAHwJCyVHCXX729dwkboWOMek5sjSHw0?=
 =?iso-8859-1?Q?XRj/ydlE2F3IW00PvSJdAeAVgQpVDNKDGV79Wpu6z4G4YkRTvRs18NmtOJ?=
 =?iso-8859-1?Q?4gBBqHMgpb64K0xrrsmKmQjB4Hlukq7N6dwfFHAIsCNFh6rZoztk/597nk?=
 =?iso-8859-1?Q?mqJzGTofVzmWgQ6XBN/rOArhJ0chQVQHwFZVRZEBWSrYvIcKo4Lv7CAbm3?=
 =?iso-8859-1?Q?R3jxKZOw+hqtNMkqO/jUfvhPrmOJh47nW60DWskkVUhzYCPySnTUTGgZS2?=
 =?iso-8859-1?Q?nhybMMc8UQW61+9lnwE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 77520154-ef2e-4f97-44d7-08ddfb950284
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 18:05:56.7271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WJWlxplhfMsbE+nKn+GYqKL2an02sDEjod3kvZlLyEvnz5Zi5ELz+BQHclkYPc+EHMqyWOMoiwlkB3f4BXJluw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5408
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX/CV4EAqvYuBq
 wJVS+vh3nz00HGdAe/mE478gn3c4wD87BUQTly14wcexRf8QHO2fxI62XvAUierb6PdxXuuGyYg
 wQPmAMTIjhGCxXSQrs+5quWLOmLer0/KqyPI7d5EWTe3Fe10On8Yq91dQHDepITU4nfEJ4IEMCB
 U6OHA+8K9c5GbYgsT24ae3T1VM0N3+lJHU+pH5cg+ZCyBKsEUXOKCDBfWsBnudL87lbrc+zXUBS
 ZeTZU0zNJhd7J9Gi7jjjwA+6L8rk5ZmC9Xhmwm8bcURp7AoIeCoS7n1rTYB5s/yo6VxjFSaRbPY
 mpKBLgB9kh1FZ4e1uSPt6cnvyl0qRLC+pp0QALbdeViLWluS0yt5DuhEQ7IDai505gSYUXN9/u7
 IOkS/Ubq
X-Authority-Analysis: v=2.4 cv=TOlFS0la c=1 sm=1 tr=0 ts=68d43308 cx=c_pps
 a=fLgsFiGMcCN2bMhaTK1NuA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=2OjVGFKQAAAA:8
 a=P8mRVJMrAAAA:8 a=jZVsG21pAAAA:8 a=pGLkceISAAAA:8 a=7yW8dvDIZ0mmvBN6QAEA:9
 a=wPNLvfGTeEIA:10 a=IYbNqeBGBecwsX3Swn6O:22 a=Vc1QvrjMcIoGonisw6Ob:22
 a=3Sh2lD0sZASs_lUdrUhf:22
X-Proofpoint-ORIG-GUID: lkrEo5lNiso_1eUHUQ1-nN34FX5y5Onq
X-Proofpoint-GUID: _2u2VQrxBh-ARfA6NfgeKU4jwO8WSY8S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033

=0A=
=0A=
=0A=
________________________________________=0A=
From: David Wilder <wilder@us.ibm.com>=0A=
Sent: Monday, September 22, 2025 3:35 PM=0A=
To: netdev@vger.kernel.org=0A=
Cc: jv@jvosburgh.net; David Wilder; Pradeep Satyanarayana; i.maximets@ovn.o=
rg; Adrian Moreno Zapata; Hangbin Liu; stephen@networkplumber.org; dsahern@=
gmail.com=0A=
Subject: [PATCH iproute2-next v6 0/1] iproute2-next: Extending bonding's ar=
p_ip_target to include a list of vlan tags.=0A=
=0A=
>This change extends the "arp_ip_target" option format to allow for a list =
of=0A=
>vlan tags to be included for each arp target. This new list of tags is opt=
ional=0A=
>and may be omitted to preserve the current format and process of discoveri=
ng=0A=
>vlans.  The new logic preserves both forward and backward compatibility wi=
th=0A=
>the kernel and iproute2 versions.=0A=
>=0A=
>Changes since V5=0A=
>Thanks to Stephen Hemminger for help on these changes:=0A=
>- Use array for vlans=0A=
>- Removed use of packed and Capitalization=0A=
>- fix incorrect use of color=0A=
>- Removed temporary string buffer.=0A=
>- make vlan print a function for likely future IPv6 usage.=0A=
>=0A=
>Output for "ip -d --json <bond-name>" has been updated. Example:=0A=
>"arp_ip_target":["addr":"10.0.0.1","vlan":[4080,4081,4082,4083,4084]],=0A=
=0A=
I did not get this right.  arp_ip_target should be a json array as well.=0A=
Example:=0A=
      "arp_ip_target":[=0A=
                        {=0A=
                                "addr": "10.0.0.1",=0A=
                                "vlan_id":[100,200]=0A=
                        },=0A=
                        {=0A=
                                "addr": "10.1.0.1",=0A=
                                "vlan_id":[4080,4081,4082,4083,4084]=0A=
                        }=0A=
        ],=0A=
=0A=
This look correct?=

