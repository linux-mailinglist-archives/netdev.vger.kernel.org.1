Return-Path: <netdev+bounces-184216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7367FA93E2B
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 21:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE88E1B60001
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 19:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3675C215066;
	Fri, 18 Apr 2025 19:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bp7+ik0R"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0E913C9B3
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745004036; cv=fail; b=YemXHwedGRP8CaTbnkQnjD4TLLU9DXqzhCKkYFtwEf3fMLs57eR1BBrd2rUsCY/P3axgr8znqjzJ7sT997zUtfIniYdQSY9XLG5JcCGx0B7iL24XPtiHP6ji+ULViPpgGQRuQIXZzx8N0692n9O5gdOEooBC3gFZ5w3AezIb8pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745004036; c=relaxed/simple;
	bh=wddKVmrinLQX0LsScWTODBOQU+5VPYTM3xVOE8MudSM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=MfDHrU8HF5hLWbISBEv0GRFFEz8NYWdsC/XeYwiu7Viwsk7fi9ndrVMcY5EPj8+THRDUsJCLJNnsz3GhH+6gzVQR6/89WpgcqTRoT91B2zoFouSNxXF/m5mAeZkPDuVgcupCr21ItVRBc09cgAhxDUeGBRYYtR/kAhPJKYB0X+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bp7+ik0R; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ICAjKX026295;
	Fri, 18 Apr 2025 19:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Z8sdqq
	A5WxA3jDhFEaykFF/YRMkWv0A2TPbafXgct9Q=; b=bp7+ik0R6ZpUcNEeEgrIYY
	68Bhj0lAlar2+ykJCbA0WfTeVr6OVj/ZqyP6yKWiaD2+EKnguaPZeLRyEamhvljw
	7Ahu/V8vmjZWrndtiwLD9QlzicO8aoMtsv16bFAW1Eb688sh5hICMvpqEocxWRBD
	uw3wPQ7/LKi9/mNzMWG1Td7/Z+7IWITLlJmI2Uw8XIRuq5s4umN1Gwo2Po+ATA3R
	H01X7qY6o0EeoC3e2leWb1UnOKdW8GWCBbffHIVJ0lzPFZVyeexjVUxm3JVuQkO6
	vsQW2GqXqMD8XNUxxzijjUsQcbd/Ydmh52qtWMoTJ2joS3Ub4H5zoznRVOCVnTdQ
	==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4639sw4ju8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 19:20:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOqEE/7tGVPQsIz7rjvYk6snb+vKxs3pAqi2QclJDgrZbsMlBmoL3BY3o+jKW7SUcOleijYkDNk15LrLpsNUKuxzAyP6EnPvEsmuCpVWTXZfd4BjyZM1lOy4zAvT7cp5FVou6y+ZRLzqvIc1hDBSgkD+ywUijmrb/DSQbd6t5WQ5voneTpDOE0NmJR3vwC5+tSXHKDEhEt+Ktu2431SpYfZmsGyeYMtzocnpp1t202M33RfG0pP/iG+JB0Iqw0SfiS06J/z3A3FbBzA+VeeoHH1+ky1Tj3RKwXU23IGhq/bIklAncF2RU6cZxFWbosNLQYaJVzvUEepVzqJ+rXL2qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8sdqqA5WxA3jDhFEaykFF/YRMkWv0A2TPbafXgct9Q=;
 b=koWa35h5lhPKqLlKsnLcIOCGQ4oN+xKEQ9Om95MmefL4qpKcsiKoq8t4E+XCwTd/XQo6k6CeK9tlca/o9EPhOVH/bdism1tAsLEaEBDcddb1ZVq9E8I8rM9zrwbGPqk4rWLX3QwNTr6Pu1K0QUOUUnIfbM0lAHvl27/6SVlbyURG7GapNFScCxRlzWIYKkJi1R3NYNvEMk/85Z/eJ62nIaouPRyAlWuIHC27Ia/6dNX4/m2RFbQLLR/1BBPh6SRMKyfY2vV4rrnWKuPsPGdpo50P332XkwormVrc/wuTgDCNOu/EzrBWJT6HitgxVlKXVFxHbKlb1/ElCTr8tLhuTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3913.namprd15.prod.outlook.com (2603:10b6:303:42::22)
 by PH0PR15MB4974.namprd15.prod.outlook.com (2603:10b6:510:c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 19:20:20 +0000
Received: from MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490]) by MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490%5]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 19:20:20 +0000
From: David Wilder <wilder@us.ibm.com>
To: Jay Vosburgh <jv@jvosburgh.net>
CC: Ilya Maximets <i.maximets@ovn.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "pradeeps@linux.vnet.ibm.com"
	<pradeeps@linux.vnet.ibm.com>,
        Pradeep Satyanarayana <pradeep@us.ibm.com>,
        Adrian Moreno Zapata <amorenoz@redhat.com>,
        Hangbin Liu <haliu@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v1 1/1] bonding: Adding limmited
 support for ARP monitoring with ovs.
Thread-Index:
 AQHbqwoTrDjAZh6IzkG7iJ522lMXdLOfJPkAgAAI5oCAAbHmB4AETtyAgAAQYlmAAEPdgIABC58vgAJH9wCAAPZE1w==
Date: Fri, 18 Apr 2025 19:20:20 +0000
Message-ID:
 <MW3PR15MB3913966CE6D332CFDC1982A8FABF2@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250411174906.21022-1-wilder@us.ibm.com>
 <20250411174906.21022-2-wilder@us.ibm.com> <3885709.1744415868@famine>
 <d3f39ab2-8cc2-4e72-9f32-3c8de1825218@ovn.org>
 <MW3PR15MB39135B6B84163690576F95FDFAB02@MW3PR15MB3913.namprd15.prod.outlook.com>
 <4164872.1744747795@famine>
 <MW3PR15MB39138C432D2CD843C20C0C10FAB22@MW3PR15MB3913.namprd15.prod.outlook.com>
 <4177847.1744765887@famine>
 <MW3PR15MB39131B4CAE5E3D06084D2A7DFABD2@MW3PR15MB3913.namprd15.prod.outlook.com>
 <154692.1744948764@famine>
In-Reply-To: <154692.1744948764@famine>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3913:EE_|PH0PR15MB4974:EE_
x-ms-office365-filtering-correlation-id: 63877c8c-d8e8-46e9-9843-08dd7eae0fa6
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?b5BA7sm9nXE0btsTgzeoQpN0VgoMobrvz26SVL3DwhbYn8W/xtgtoMt9uB?=
 =?iso-8859-1?Q?ivq6/gOgkgfpvbQVEV2FJe0SwhfU+RHyvXwNDZMwzmFA8jtEcuGvetPva8?=
 =?iso-8859-1?Q?Q0jqMeZeZ+zmNJWQuIz4Ri8cOxJtGZ6Uu07dbQqQbaFsJi5bH9rV1RDlIX?=
 =?iso-8859-1?Q?yWnnQUbuflhnoVedI/FCMJHZkxp34nNkDPua9tXJSA1rLRuUp5CBn3U+X9?=
 =?iso-8859-1?Q?NSXgNuLi8jiNssPBNNDC19xAWlpvmElXCtEz8jTW4kssGXvKi6aO/OdJrC?=
 =?iso-8859-1?Q?2Jmdq6SCoTMzfFpmCV581So+FX5NyCXpAtJjOmFRgcruBfJXHMg70dBYKH?=
 =?iso-8859-1?Q?5/VvsR4EQtM2xDRxjRStl7A4eac5QB69npq5/5asN539NiJlayN6XGuB/p?=
 =?iso-8859-1?Q?sWhuGeoU5fHwwhn0tLsvr0YFewXvkD/gXIVt4Dzj2XRFCAx/W84HAzejKg?=
 =?iso-8859-1?Q?Xlc9H/v5favh0H6djzAXF3pTHNdrPjqrzC+KvKJ6sGoBvmBeRjJp9HanPv?=
 =?iso-8859-1?Q?LLZvxhfn8uQegm0R3qydNUFe5viKlgyMiAVL/2seHEa/38PDAtJ3nvuove?=
 =?iso-8859-1?Q?SFedGgadWETB8eVUK39VP4l7lEADZfCFYLBHpOcZul2uXdgjn7Jd+eRKzI?=
 =?iso-8859-1?Q?/fA4X8nVBPr6nh60EdHMBlYUcd4vFyegDrpoVfAUPPrsUK83AFElcYYuwg?=
 =?iso-8859-1?Q?cONFu+oYZvyRBaShivcwbMqSvcGKoMMz1t8FL6AI2Sa48BYsnj5eV81wf4?=
 =?iso-8859-1?Q?yKgUjot9I+E5EyJRxR5pq4gL0pwJnzXuBe2Nz4X5dBsNOE+7i6E9K4MOMU?=
 =?iso-8859-1?Q?StlpOX0eczh8a/olQ00LPZEqTmCNK8VyDvZJqR1vAaGPIH9SCB16ESSoLj?=
 =?iso-8859-1?Q?F5tvUmI4EzsoUyDACx8gPpXjmQQ0yBgRmR4FG/U16TxFYLpKxMIEroeMrI?=
 =?iso-8859-1?Q?T9CdZ8fNPuL2RAqXPHOpfXacvDlDPlNeS4RILCg+u5rDmnIyySUWF17R5n?=
 =?iso-8859-1?Q?UJnIq6A3PefX6d5h+0N4QjHlm8eYnt5xRHQjTUnOoFte5vDCztfbMsNBdy?=
 =?iso-8859-1?Q?/3r/+8jUJs7VPi191dnwYdG+DuF7Vb+cfPfnLfllhikxkuulprRxl6fG6I?=
 =?iso-8859-1?Q?AySijBIqIw3qKRK/QPLyBJ1nWuTUzwWoQW9VmO4sJg3iNnOxl8ta25HtZo?=
 =?iso-8859-1?Q?nNkZJgA61MsEh4hreVWY5BZojvMw/8/xpo3bVlIj5ctO69pMLaze7SNqny?=
 =?iso-8859-1?Q?v/BXTZlIe48w3aM0+vR2IMjaiPOYCfO5e7xZZPEF/2w0hpCJfiH0W7JDU5?=
 =?iso-8859-1?Q?2sothksYD2uiuOctW67eNX05eullC9v6t7w8Modb085ia+XjwKbFnLZ+s3?=
 =?iso-8859-1?Q?sDCgffc9ls5SreGGkC+FSFmhCRKEgzFNpsBkKLkuVLgrAilZQbso91Rcub?=
 =?iso-8859-1?Q?dg80wN1LSliJkOgFryO50SDvhgYQZZs5tplQIPw6xMfkWUvxI/hKTUtV+J?=
 =?iso-8859-1?Q?ds4+Dw2eqRLxr5bJwXF9+1QBb608aHgG5FeilUeVYQ5XtgWD5MbE4TzLhq?=
 =?iso-8859-1?Q?7yDINkY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3913.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?bCqCKNw0r5jDqNpSiUdLwTJXCSH9pYgc0bfNKlxiqB+eoPD6pDiO0X50VB?=
 =?iso-8859-1?Q?Vbi7X7WqVXkEcb0Wc2/KOE0J0kTbB/bP4Bx1ZNZesvBlZchzybAjuTJ7ep?=
 =?iso-8859-1?Q?ty1i6jNWDr6URZpGptz5MLjVMAv8hxGAnbQnAKfSPqvHElxHMetVcgLrgX?=
 =?iso-8859-1?Q?uHbJPZyOTbCTahbE/wPHKPSlJB9sHJNRu7u4jlgKAo4BWYGa8krEfrxdJw?=
 =?iso-8859-1?Q?epLhDADxSYhjq0/uPDjCef1d1j5ahYYfSn+QWMl0cgIO44+Jqf06d7T+7H?=
 =?iso-8859-1?Q?Jc/xNSmK5e89EFCdGUfvt+kjhIiWQhrYmJ5WI85n9N81kqnBzRN9jHKtaQ?=
 =?iso-8859-1?Q?IST2MXvbZi8M8l14hmdQQMllpDU/XnZEoSx2+tBHQilbnm8DnTeYHTWd1O?=
 =?iso-8859-1?Q?Uab0KLoKegQ9jnPFyjYlcwUl0KycHnveDBEMGmPdhlddtHqGXJlGvgJbtL?=
 =?iso-8859-1?Q?0hxfTYaUrDXPgGK0Xi3aXcctcPzBDqhQ8vlVVVH8mc9jvH64vv/+tlGhRQ?=
 =?iso-8859-1?Q?cTb1srREQpMELWsGh/8F7h25i8Zo7Z6Q8cMfY1Dx++LoVCca6+4wIdOReJ?=
 =?iso-8859-1?Q?L21EClW5J/QCI1Xcn+NIs3B8+s0ATnZxM6YBE4Q3OSEvDs0vgFCW2CrIWX?=
 =?iso-8859-1?Q?hoCb1Exjm4Oj0hyETFoYkTcHgiqjq4D19z+VvR2c5mIqgF8ISbAgAw3FQN?=
 =?iso-8859-1?Q?1pXs5Zh9IKEcZTRafV2OkfayDILdz52DkN484Ox2yc9RoR+kkuJ2fv8unz?=
 =?iso-8859-1?Q?1ruqEIURVt1LSVyC7xbNKoh2T9SJ++ssd3lFZEaNcWpUNqaqiwxdVBTJex?=
 =?iso-8859-1?Q?FdycVwBxJ9kk3R097pgojkl2kJDRKRf9l24tihYxjU0pvVt1DrwN4KxxIt?=
 =?iso-8859-1?Q?TmNgBSwo+GHyXUoPZj4dJlvX2q+OdsDIwZRR8mRRbhHDzfPLGhrLM9ABPs?=
 =?iso-8859-1?Q?nru4GQ43g92g1D7gMVJXKgGFs0zOablsOf7lXEljYrTaRQwod+fN0yMz9w?=
 =?iso-8859-1?Q?sYk8soPz4lTld3f/XpjdbT7zV4Q5C+uszwi1vvYDV93CsJ106UoSe/crOp?=
 =?iso-8859-1?Q?A+cP1E8iCCjCeTpr6DguFgY//nuxPcMj0jJ0YI1kFj7KGAvnzjUcfddGtA?=
 =?iso-8859-1?Q?L/5cv0QZK/XB63qTsl7u2s+GwNWR2TvK1U6VEc4Y0eJZae2VZ0XxAK22Ww?=
 =?iso-8859-1?Q?2nwV6hIjpKxRmqmYCs+8ZAaMfYcxRYN9Oi1u7Pcl/uc2XqnBw+929vGElq?=
 =?iso-8859-1?Q?VCCMig99a8e/d8B83Se+N6p6FSw6f/2v9UxLJSh+1vVJ3P4LTEN+NDL5VI?=
 =?iso-8859-1?Q?C2RpEEA51kgT0PDw6ol+w9T/Kc9VeRrg5v0GgO5bMfey3par7Gb/yQniY/?=
 =?iso-8859-1?Q?SUTnGMGVMxwSa7BjL+VVMfcVHF9oyNP0/k13mvf8LG22ABir3a8X54DxF9?=
 =?iso-8859-1?Q?7gqutftdQABk+C+3opP4rMHkqNhZCgyFw6uzSPvSYQEiKW6zOXYLxNAPb7?=
 =?iso-8859-1?Q?wSqxV+IMiIyd+j3x5ERvjukD3Epct/H5gry56E7oEk+BJYph6+0oWAYU7x?=
 =?iso-8859-1?Q?f4x8MmiTwX3okG7IkeWQbSYt+yuENKfrNpDU9mRz8FhcV2WOOSrsAW4H2h?=
 =?iso-8859-1?Q?0l+lPZr5a5pxg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 63877c8c-d8e8-46e9-9843-08dd7eae0fa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 19:20:20.8001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tVn6oP0sAZsyKyCNhwXP6pLpCspMbBpxZR++ozdY7blmortZ1jUlrMr2Cu7lPZokPvHW9qiBsvamETWt3F+qUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4974
X-Proofpoint-ORIG-GUID: G_HrwYQry0gmigHRs1q6lRhN5vFl-yXv
X-Proofpoint-GUID: G_HrwYQry0gmigHRs1q6lRhN5vFl-yXv
X-Authority-Analysis: v=2.4 cv=SMlCVPvH c=1 sm=1 tr=0 ts=6802a5f7 cx=c_pps a=ybfeQeV9t1qutTZukg5VSg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=2OjVGFKQAAAA:8 a=4oQ7KK8Il0juR1CoqJEA:9 a=wPNLvfGTeEIA:10 a=IYbNqeBGBecwsX3Swn6O:22
Subject: RE: [PATCH net-next v1 1/1] bonding: Adding limmited support for ARP
 monitoring with ovs.
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180144

>>>>>>>>> Adding limited support for the ARP Monitoring feature when ovs is=
=0A=
>>>>>>>>> configured above the bond. When no vlan tags are used in the conf=
iguration=0A=
>>>>>>>>> or when the tag is added between the bond interface and the ovs b=
ridge arp=0A=
>>>>>>>>> monitoring will function correctly. The use of tags between the o=
vs bridge=0A=
>>>>>>>>> and the routed interface are not supported.=0A=
>>>>>>>>=0A=
>>>>>>>>       Looking at the patch, it isn't really "adding support," but=
=0A=
>>>>>>>> rather is disabling the "is this IP address configured above the b=
ond"=0A=
>>>>>>>> checks if the bond is a member of an OVS bridge.  It also seems li=
ke it=0A=
>>>>>>>> would permit any ARP IP target, as long as the address is configur=
ed=0A=
>>>>>>>> somewhere on the system.=0A=
>>>>>>>>=0A=
>>>>>>>>       Stated another way, the route lookup in bond_arp_send_all() =
for=0A=
>>>>>>>> the target IP address must return a device, but the logic to match=
 that=0A=
>>>>>>>> device to the interface stack above the bond will always succeed i=
f the=0A=
>>>>>>>> bond is a member of any OVS bridge.=0A=
>>>>>>>>=0A=
>>>>>>>>       For example, given:=0A=
>>>>>>>>=0A=
>>>>>>>> [ eth0, eth1 ] -> bond0 -> ovs-br -> ovs-port IP=3D10.0.0.1=0A=
>>>>>>>> eth2 IP=3D20.0.0.2=0A=
>>>>>>>>=0A=
>>>>>>>>       Configuring arp_ip_target=3D20.0.0.2 on bond0 would apparent=
ly=0A=
>>>>>>>> succeed after this patch is applied, and the bond would send ARPs =
for=0A=
>>>>>>>> 20.0.0.2.=0A=
>>>>>>>>=0A=
>>>>>>>>> For example:=0A=
>>>>>>>>> 1) bond0 -> ovs-br -> ovs-port (x.x.x.x) is supported=0A=
>>>>>>>>> 2) bond0 -> bond0.100 -> ovs-br -> ovs-port (x.x.x.x) is supporte=
d.=0A=
>>>>>>>>> 3) bond0 -> ovs-br -> ovs-port -> ovs-port.100 (x.x.x.x) is not s=
upported.=0A=
>>>>>>>>>=0A=
>>>>>>>>> Configurations #1 and #2 were tested and verified to function cor=
ectly.=0A=
>>>>>>>>> In the second configuration the correct vlan tags were seen in th=
e arp.=0A=
>>>>>>>>=0A=
>>>>>>>>       Assuming that I'm understanding the behavior correctly, I'm =
not=0A=
>>>>>>>> sure that "if OVS then do whatever" is the right way to go, partic=
ularly=0A=
>>>>>>>> since this would still exhibit mysterious failures if a VLAN is=0A=
>>>>>>>> configured within OVS itself (case 3, above).=0A=
>>>>>>>=0A=
>>>>>>> Note: vlan can also be pushed or removed by the OpenFlow pipeline w=
ithin=0A=
>>>>>>> openvswitch between the ovs-port and the bond0.  So, there is actua=
lly no=0A=
>>>>>>> reliable way to detect the correct set of vlan tags that should be =
used.=0A=
>>>>>>> And also, even if the IP is assigned to the ovs-port that is part o=
f the=0A=
>>>>>>> same OVS bridge, there is no guarantee that packets routed to that =
IP can=0A=
>>>>>>> actually egress from the bond0, as the forwarding rules inside the =
OVS=0A=
>>>>>>>datapath can be arbitrarily complex.=0A=
>>>>>>>=0A=
>>>>>>> And all that is not limited to OVS even, as the cover letter mentio=
ns, TC=0A=
>>>>>>> or nftables in the linux bridge or even eBPF or XDP programs are no=
t that=0A=
>>>>>>> different complexity-wise and can do most of the same things breaki=
ng the=0A=
>>>>>>> assumptions bonding code makes.=0A=
>>>>>>>=0A=
>>>>>>>>=0A=
>>>>>>>>       I understand that the architecture of OVS limits the ability=
 to=0A=
>>>>>>>> do these sorts of checks, but I'm unconvinced that implementing th=
is=0A=
>>>>>>>> support halfway is going to create more issues than it solves.=0A=
>>>>>=0A=
>>>>>    Re-reading my comment, I clearly meant "isn't going to create=0A=
>>>>>    more issues" here.=0A=
>>>>>=0A=
>>>>>>>>       Lastly, thinking out loud here, I'm generally loathe to add =
more=0A=
>>>>>>>> options to bonding, but I'm debating whether this would be worth a=
n=0A=
>>>>>>>> "ovs-is-a-black-box" option somewhere, so that users would have to=
=0A=
>>>>>>>> opt-in to the OVS alternate realm.=0A=
>>>>>>=0A=
>>>>>>> I agree that adding options is almost never a great solution.  But =
I had a=0A=
>>>>>>> similar thought.  I don't think this option should be limited to OV=
S though,=0A=
>>>>>>>as OVS is only one of the cases where the current verification logic=
 is not=0A=
>>>>>>>sufficient.=0A=
>>>>>=0A=
>>>>>        Agreed; I wasn't really thinking about the not-OVS cases when =
I=0A=
>>>>>wrote that, but whatever is changed, if anything, should be generic.=
=0A=
>>>>=0A=
>>>>>>What if we build on the arp_ip_target setting.  Allow for a list of v=
lan tags=0A=
>>>>>> to be appended to each target. Something like: arp_ip_target=3Dx.x.x=
.x[vlan,vlan,...].=0A=
>>>>>> If a list of tags is omitted it works as before, if a list is suppli=
ed assume we know what were doing=0A=
>>>>>> and use that instead of calling bond_verify_device_path(). An empty =
list would be valid.=0A=
>>>>=0A=
>>>>>        Hmm, that's ... not too bad; I was thinking more along the lin=
es=0A=
>>>>>of a "skip the checks" option, but this may be a much cleaner way to d=
o=0A=
>>>>>it.=0A=
>>>>=0A=
>>>>>        That said, are you thinking that bonding would add the VLAN=0A=
>>>>>tags, or that some third party would add them?  I.e., are you trying t=
o=0A=
>>>>>accomodate the case wherein OVS, tc, or whatever, is adding a tag?=0A=
>>>>=0A=
>>>>It would be up to the administrator to add the list of tags to the=0A=
>>>>arp_target list.  I am unsure how a third party could know what tags=0A=
>>>>might be added by other components.  Knowing what tags to add to the=0A=
>>>>list may be hard to figure out in a complicated configuration.  The=0A=
>>>>upside is it should be possible to configure for any list of tags even=
=0A=
>>>>if difficult.=0A=
>>>=0A=
>>>  I suspect I wasn't clear in my question; what I'm asking is what=0A=
>>>you envision for the implementation within bonding for the "[vlan,vlan]"=
=0A=
>>>part, and by "third party," I mean "not bonding," so OVS, tc, etc.=0A=
>>>=0A=
>>>  Would bonding need to add the tags in the list, or expect one of=0A=
>>>the thiry parties to do it, or some kind of mix?=0A=
>>=0A=
>>Bonding needs to add all the tags. I am just optionally replacing=0A=
>>the collection of tags by bond_verify_device_path() with a list of tags=
=0A=
>>supplied in the arp_target list. (Optional Per target).=0A=
>>=0A=
>>To be clear, if you chose to supply tags manually, you need to supply=0A=
>>all the tags needed for that target,  not just the tags bonding could not=
=0A=
>>figure out on its own. An empty list [] would be valid and would just cau=
se=0A=
>>bonding to skip tag collection.=0A=
>>=0A=
>>If OVS adds a tag it would be up to the user to know that and update=0A=
>>the bonding configuration to include all tags for the target.=0A=
>=0A=
> If OVS adds a tag, and the ARP traverses through OVS, why would=0A=
>bonding need to add that tag?  Wouldn't OVS add the tag again?=0A=
>=0A=
=0A=
I though the arp probes are sent directly out from bonding, so it wont=0A=
pass through OVS, therefore bonding needs to add all the tags to the probes=
.=0A=
=0A=
>>>   Does bonding need to know what tags any third party adds?  I.e.,=0A=
>>>for your case 3, above, wherein OVS adds a tag, why does that fail to=0A=
>>>work?=0A=
>>=0A=
>>Today it fails since bond_verify_device_path() cant see the tags=0A=
>>added by or above OVS.  Adding a list of tags [vlan vlan] or [] would eff=
ectively=0A=
>>do the the same as the "skip the checks" option.  But allows a way to mak=
e=0A=
>>case 3 work.=0A=
>>=0A=
>>>=0A=
>>>>A "skip the checks" option would be easier to code. If we skip the=0A=
>>>>process of gathering tags would that eliminate any configurations with=
=0A=
>>>>any vlan tags?.=0A=
>>>=0A=
>>>  So, yes, it would be easier to implement, and, no, I think a=0A=
>>>simple "skip the checks" switch could be implemented such that it still=
=0A=
>>>runs the device path and gathers the tags, but doesn't care if the end=
=0A=
>>>of the device path matches.=0A=
>>>=0A=
>>>  That said, such an implementation is effectively the same as=0A=
>>>your original patch, except with an option instead of an OVS-ness check,=
=0A=
>>>and I'm still undecided on whether that's better than something that=0A=
>>>requires more specific configuration.=0A=
>>=0A=
>>Ah,  ok I get it.=0A=
>>=0A=
>>The "skip the checks" option has the advantage in simplicity and will=0A=
>>fix the problem I started out solving.  The downside is it wont solve mor=
e=0A=
>>complex configurations Ilya is concerned with (see case 3). I am all for =
starting=0A=
>>with the "kiss" approach, we can always pivot to something more complex l=
ater if we have=0A=
>>the demand.=0A=
>=0A=
>   Modulo some of the implementation details from above, I'm more=0A=
>inclined at the moment towards the "specify the tags" solution (specify=0A=
>all the tags), rather than the "skip the checks" option.=0A=
>=0A=
>   The reason is that, once we add an option, it generally cannot=0A=
>ever be removed, and so there isn't really a "pivot" in the sense that=0A=
>an existing option would ever go away.  In that case, the only way=0A=
>forward would be to add another option (the "specify the tags" one), and=
=0A=
>now we've got two different options for the same thing that work=0A=
>differently.  I'd like to avoid that.=0A=
=0A=
Good point,  Agreed, "specify the tags" is the way to go.=0A=
=0A=
As a starting point I am thinking:=0A=
=0A=
+struct arp_target {=0A=
+       __be32 target_ip;=0A=
+       struct bond_vlan_tag *tags;=0A=
+};=0A=
+=0A=
 struct bond_params {=0A=
        int mode;=0A=
        int xmit_policy;=0A=
dd@@ -135,7 +140,7 @@ struct bond_params {=0A=
        int ad_select;=0A=
        char primary[IFNAMSIZ];=0A=
        int primary_reselect;=0A=
-       __be32 arp_targets[BOND_MAX_ARP_TARGETS];=0A=
+       struct arp_target arp_targets[BOND_MAX_ARP_TARGETS];=0A=
        int tx_queues;=0A=
        int all_slaves_active;=0A=
        int resend_igmp;=0A=
=0A=
Parse the list of address and tags into the array of struct arp_target.=0A=
Then bond_verify_device_path() will return arp_targets[i]->tags if it exist=
s=0A=
or build its own list of tags as it always did.=0A=
=0A=
>=0A=
>-J=0A=
>=0A=
>>>=0A=
>>>-J=0A=
>>=0A=
>>=0A=
>>>>>>>>> Signed-off-by: David J Wilder <wilder@us.ibm.com>=0A=
>>>>>>>>> Signed-off-by: Pradeep Satyanarayana <pradeeps@linux.vnet.ibm.com=
>=0A=
>>>>>>>>> ---=0A=
>>>>>>>>> drivers/net/bonding/bond_main.c | 8 +++++++-=0A=
>>>>>>>>> 1 file changed, 7 insertions(+), 1 deletion(-)=0A=
>>>>>>>>>=0A=
>>>>>>>>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bondin=
g/bond_main.c=0A=
>>>>>>>>> index 950d8e4d86f8..6f71a567ba37 100644=0A=
>>>>>>>>> --- a/drivers/net/bonding/bond_main.c=0A=
>>>>>>>>> +++ b/drivers/net/bonding/bond_main.c=0A=
>>>>>>>>> @@ -3105,7 +3105,13 @@ struct bond_vlan_tag *bond_verify_device_p=
ath(struct net_device *start_dev,=0A=
>>>>>>>>>      struct net_device *upper;=0A=
>>>>>>>>>      struct list_head  *iter;=0A=
>>>>>>>>>=0A=
>>>>>>>>> -    if (start_dev =3D=3D end_dev) {=0A=
>>>>>>>>> +    /* If start_dev is an OVS port then we have encountered an o=
penVswitch=0A=
>>>>>>>=0A=
>>>>>>> nit: Strange choice to capitalize 'V'.  It should be all lowercase =
or a full=0A=
>>>>>>> 'Open vSwitch' instead.=0A=
>>>>>>=0A=
>>>>>>>>> +     * bridge and can't go any further. The programming of the s=
witch table=0A=
>>>>>>>>> +     * will determine what packets will be sent to the bond. We =
can make no=0A=
>>>>>>>>> +     * further assumptions about the network above the bond.=0A=
>>>>>>>>> +     */=0A=
>>>>>>>>> +=0A=
>>>>>>>>> +    if (start_dev =3D=3D end_dev || netif_is_ovs_port(start_dev)=
) {=0A=
>>>>>>>>>              tags =3D kcalloc(level + 1, sizeof(*tags), GFP_ATOMI=
C);=0A=
>>>>>>>>>              if (!tags)=0A=
>>>>>>>>>                      return ERR_PTR(-ENOMEM);=0A=
>>>>>>>>=0A=
>>>>>>>> ---=0A=
>>>>>>>>       -Jay Vosburgh, jv@jvosburgh.net=0A=
>>>>>>>=0A=
>>>>>>> Best regards, Ilya Maximets.=0A=
>>>>>>=0A=
>>>>>>David Wilder (wilder@us.ibm.com)=0A=
>>>>>=0A=
>>>>>---=0A=
>>>>>        -Jay Vosburgh, jv@jvosburgh.net=0A=
>>>>=0A=
>>>>David Wilder (wilder@us.ibm.com)=0A=
>>>=0A=
>>>---=0A=
>>>  -Jay Vosburgh, jv@jvosburgh.net=0A=
>>=0A=
>=0A=
>---=0A=
>	-Jay Vosburgh, jv@jvosburgh.net=0A=
    David Wilder (wilder@us.ibm.com)=0A=
=0A=

