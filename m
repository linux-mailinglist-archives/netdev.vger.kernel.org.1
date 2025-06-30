Return-Path: <netdev+bounces-202557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBD5AEE424
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7363C7A3969
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BB129009A;
	Mon, 30 Jun 2025 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QlGUkH5p"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D9528642A
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300376; cv=fail; b=M042lJqeuE7mS8EZYy1vMjE50qdQgkm5ftoEaux40Qn7a7ypQOGIOaM1YgNcGvfGQwG1jQmRrBfVerXgEs4ue4vGqn8ej9ZQihQz9fNTwsdEmh6uwTsoN5Wh8k5s8+yBjgsyZy5FF/PcIIWOjMIuQsC0yK+05dCK+jyQgAsQiyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300376; c=relaxed/simple;
	bh=kOI66rtCI1QoADZLLfi7pO0AIFd2kLnWrsGEUvqj0xs=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=GFBS6MAC8ROjtqfzxUPjgaWPYqRxyHvcaeQWNlaZALpnD9/Qt/v7knt1pGLHUbXlb9X5PzlvmAgxsMuMS2dnGj+bStKG1X+dLLd0u8MmkrILFy6neaY+fg8HaN7vic5kYSPtzgB4SP+tUsSImcmSod9FHEfupQQLfJnMkRL964E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QlGUkH5p; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UCGUVs029587;
	Mon, 30 Jun 2025 16:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6/5Rpg
	i1D9b9e1luqSeTzFsFJAucj53d9srAgoDR6Jk=; b=QlGUkH5p2ZCm8k/kHeX5UM
	mYBZjSkESOo8BSqs28tC0KoaJXRjX2IJ8TxD+2QEh8YRdydnYeJ6RJiHepfjocoT
	mf6DHZOKaBuAe9ocMAiNi9auDWE0RXy+nHjKsttya8mUcYjWAQwtRO7SIAlb/dmT
	OiZyXQfHvBNgUNJRxF+qjJ3UIWmSX7UwLnNGqK/oCBLih3Ngq0HGdfMKgZZ36hzc
	hvC6t2Ah07P226LPni9M81j7y4m3dm0u6I6zHEhls5nbOzFnZNnSXmZ4prCmTL6Y
	AfRwKlhRGPorcBkez6I7f7Nc676Qq020VTsEED2jPe90c8tu4p8QXNO6G57+FMiw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j830jenb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 16:19:26 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55UGCsu9020286;
	Mon, 30 Jun 2025 16:19:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j830jen8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 16:19:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpW1cnCWRWMxMqu9srUSi5sxaCtM8SzNuQlkyKVLPlMQiXsuU+0hl9FxseI2xEYQFMn8x5jxGpDvHU7XGGUOVbX8r/Q1INooNbRK2yFxzlxxbhCbLXNmflpSIlREGBaNn8YO70bwErKqD/EFgJEkfJg8IssUnMrkNcXVEuB6NcXnJwbcexwtPW1jbx95RmrnfvZUu33Mjxxux/HDinnpfP4Ij6bC+qhm/lOpN3+fHACg8hWghhjIC7bvYtK3ApatRF648ukNTZyBm/zGiUeDE/BlXD72dMqmHjtd1TAUKTQSrYCaSv4nMyZ5LFaUXEWYJcmH5qV1ktrrmAES7wHNhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/5Rpgi1D9b9e1luqSeTzFsFJAucj53d9srAgoDR6Jk=;
 b=xXVLnUoQ6CHVVU9BCxBhcFuw2PELo9oj4yzJ18HSCGQ10E1jqzXWqMCymU3rIz9RFRYt04Pqi7n90qPNs7s7jM5BCRcP+Qv7+YHuJu6rwOIFmXGdeMQ/B5rMWdjT0g2AbHgaFfTZiuaa7uD2GbLtX2uc0E9dB6pMjW6DrBpNN24nYSZneiQW6sUbc9ohbstmPpw/SQ1d9IHUy2Lx7e80q0GbUtAx2jFrz43gOIot/kPdbmUa8HxQ3+7Q7Jz7OqG84giMQqLQHbHGojPtTqs8S++2H3IwSgm8PQAMks673Z6tuwAoYPjrtx9YLo7US3oeiI7wT3kHWdcPEpOdyNv6OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3913.namprd15.prod.outlook.com (2603:10b6:303:42::22)
 by SA1PR15MB6419.namprd15.prod.outlook.com (2603:10b6:806:3a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.28; Mon, 30 Jun
 2025 16:19:23 +0000
Received: from MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490]) by MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490%4]) with mapi id 15.20.8880.015; Mon, 30 Jun 2025
 16:19:22 +0000
From: David Wilder <wilder@us.ibm.com>
To: Hangbin Liu <liuhangbin@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "jv@jvosburgh.net"
	<jv@jvosburgh.net>,
        "pradeeps@linux.vnet.ibm.com"
	<pradeeps@linux.vnet.ibm.com>,
        Pradeep Satyanarayana <pradeep@us.ibm.com>,
        "i.maximets@ovn.org" <i.maximets@ovn.org>,
        Adrian Moreno Zapata
	<amorenoz@redhat.com>,
        Hangbin Liu <haliu@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v4 0/7] bonding: Extend
 arp_ip_target format to allow for a list of vlan tags.
Thread-Index: AQHb56DNA1oUWT6TH0auSxBsTshb3LQbgW4AgABZC8k=
Date: Mon, 30 Jun 2025 16:19:22 +0000
Message-ID:
 <MW3PR15MB391317D5FD3E0DCE1E592EE0FA46A@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250627201914.1791186-1-wilder@us.ibm.com>
 <aGJkftXFL4Ggin_E@fedora>
In-Reply-To: <aGJkftXFL4Ggin_E@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3913:EE_|SA1PR15MB6419:EE_
x-ms-office365-filtering-correlation-id: b3fff4f8-5e47-4f63-ec2d-08ddb7f1dfdb
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?RzK8CWrqWjP1EgThwpPNRJCtcN+DlOXyb9sMOUUICpxQ1Xl6GhsZEqtrBp?=
 =?iso-8859-1?Q?+BFVTaMr2WWtc7LqDNu25rhDmX1mH6LeC2blxMWLZzLLPQeplA1lnHJcb9?=
 =?iso-8859-1?Q?H0rZjs3A04SXs0j36OoGRIQ/urDXjt2ktsT8LuH06+nyZ3C99B3xlZQQnU?=
 =?iso-8859-1?Q?Jr7QJe8NRXetxJB5xAL5N042uPj8lfmc8FLmSGVRBQIIrzX/AFgaHUyx/R?=
 =?iso-8859-1?Q?zW21WBvJQx+JtH7XHMl1gN/Q9LA7KuqQZJrW7Alu+8etP8feU1GDLMHyPc?=
 =?iso-8859-1?Q?yoQbxrtpzypCcGAcJf3GpcwIcrB3+9ly+k66Aju25p0c8C1L0ZLlRs23dV?=
 =?iso-8859-1?Q?6oLLaoMPWgIf35fzmT+2bm0wENug6U+xIh26XMQvBVWjC0JC++zy8RoTpj?=
 =?iso-8859-1?Q?TdQU+VUWE1B1wR2zMU+BoDJc4vvb3ESPUEQOB8DeD0ALTnmYXw1am4W82P?=
 =?iso-8859-1?Q?Z4PKsdOe0lRWhf7iVtMXrP+P2ltDmhdesTPpjG059D1OPq1fPWsbbbRc/t?=
 =?iso-8859-1?Q?ZvjkO4yOhE8Tp69n6ITTdalxhokmN/N8FQeaGTX+b2XSoO+1BP8to67GIL?=
 =?iso-8859-1?Q?LhrgQv4ZPkX/6i5RAofZAa0g5ZHQNQSHqj7MtlB2iJIXINcSUdfzW3fBmV?=
 =?iso-8859-1?Q?m1Px9RodquUoZHrqbJptQgNzYCM+PrrsysUHQ74xqvQDFKKTGfbO58Svpp?=
 =?iso-8859-1?Q?BM5+POve1Q+z96Afs5Uil5p1AAu0SM6jkFMjjuw/KCDBUBreR0j4h2JvHj?=
 =?iso-8859-1?Q?9S16hgqgSUDZgE4msgcAD4RQhVXHB6FOxUU6YoNbJxQyTWkTWwPP6ooIw5?=
 =?iso-8859-1?Q?fDgLoE4ZtZMW4eGnPmC4cT/y89B/Ez/MpUu1XCs5lo/F5TyUoUZ96LJDz8?=
 =?iso-8859-1?Q?CL/wqOtPj1vbYeIgHDsgfSvirhCRCMQ7cgtvCjghnGId+WNyCF4RfiJvKs?=
 =?iso-8859-1?Q?6k6O0HPvkFWlcPseZBaYQVA/Sv5UMd/VVwOItd71rSZUDiYets7Bye2xuM?=
 =?iso-8859-1?Q?FxK5vaKU+rTW7K6Q/UHigT7E5FE/trDH1CyqnLQHHYmNY557kLlMgJYi5O?=
 =?iso-8859-1?Q?GlCsQmWBDvrAS3iV4HG8BhjIx6a+GbhvcjRyAAspbzhCZg0dD5janY3My2?=
 =?iso-8859-1?Q?0EZbcLWwSE7y6+Y/K6sPK8XCTYBnPD/76UgqlaXDNunnDxHRraIPEBSOoX?=
 =?iso-8859-1?Q?S5WkTZoeCXdQfNe/0URKo6p1/B85lPB/4W6f/ecse81YNB/l3GfXJNVwCs?=
 =?iso-8859-1?Q?xc0iEAxVU7NMFEE0EDgIO6NkK1l97Ky2pnTYO7NSDhXhjlFzVYmOE2TQv4?=
 =?iso-8859-1?Q?bwo7GaFxGhY/9tWQlkoYxhH600ls5lOt41obGCSWC01Ie6uOIVjORVOPxr?=
 =?iso-8859-1?Q?6dELM0y/0Duf1xafri/eJnxwG6CwlvYQBx2zYULa++NkhlEFY4gJZdrLRQ?=
 =?iso-8859-1?Q?K2w1Fy2H/B5ft7OJMniuXipHzdBhkx5AwftkrmPZuqG6UvK0V9qdvmIcuM?=
 =?iso-8859-1?Q?emY1QzEqBM/jay1RTangW2TGJN8JhFKmG0zKi7/NDKLw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3913.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?fMEVhNMMCyFrf6US+6Nz4qVAg6NibVXMvMIUJMyMtc+topj/aSMGW5hVXG?=
 =?iso-8859-1?Q?LnozPmxfH/DAo0lCgnruMRSjyd54j1P05/Z4CNW2liSqkzyNuEOl1ybZbg?=
 =?iso-8859-1?Q?eK+OSkZxOe9tHgFg8EpRxaR0CYveyGtUeCF5BvKhJCFXCWA/IZXytQejjt?=
 =?iso-8859-1?Q?pY+S3qaePtQXb2O1OGk6aqBp6UJN++n7+gyXNqMyCAQpvaU+Tig361Mub7?=
 =?iso-8859-1?Q?I0kepgC7+E1OASrxGvETsCWh7zGbph+TQ5kw/VJrEUerkFAELCZ7TKlcYE?=
 =?iso-8859-1?Q?MetAC32iwLXq3sJkuA9QjnYFH4Zxyo81HFBLMNAnW916eQfoN0A1JAcOLw?=
 =?iso-8859-1?Q?sRunVBAVsSEcFyXY30KIwwZNKvEKYnGwJiB+Vq5c7peG02weeNYl9IxIiB?=
 =?iso-8859-1?Q?phIUS6Dby9hqodTFWjR64bI3WsqL9PlW4uOT2zlBn9OddnN2OELfxuaGXW?=
 =?iso-8859-1?Q?LiGevu5Yq3aFwtkXxmZPHQKfU+QZDwrUGFVBvNNCygu0WThyRm2q+CzwbQ?=
 =?iso-8859-1?Q?G4kjiSCUGctOQnVtHhWDwFk0gWYFiTC7azidRVNdvBgK1DrrU9fBAC1/l8?=
 =?iso-8859-1?Q?vzT0Sn9KZmYO5nGDLpXacvNDAS3oT2ZdpGKpouxFYPhljfb5XOH1wzi6WB?=
 =?iso-8859-1?Q?aBSYBqyxnOCyw6AINqP3Vl668xwPgqsMhCCrD4RASlWxxRbUGq0fACkpOx?=
 =?iso-8859-1?Q?8+YAbUQ9MhH+Ne9J9fqmJu9TWppnk8tdZllsf/VNn3zfsmAZxLHSEtIKat?=
 =?iso-8859-1?Q?EUEIJYlNcr/2MYXmxsJwwXAb+ttiyxnUjpyyzwHhFNUAT2dApFtOgb75yU?=
 =?iso-8859-1?Q?SX9kPjWzttTxWwovKpeV4b1aMa5vSDeSNRdPihvjWsrwqCWCwsqi5NJoNr?=
 =?iso-8859-1?Q?e+yMDU0rQxHD+lS5mr32AcDFSktGykDKjvVp/Dqpmkqe1/1pt6hYZFxxCR?=
 =?iso-8859-1?Q?fEsm4bRKFfzc7JXldl5Y9PBaEm/xpnCVhwOjJeny+/eFXsAt1LeyQncsph?=
 =?iso-8859-1?Q?CkpKq/jMwn1mqrDXNzQRYmIEC0AxeLfHTOkuvx+Z62l/6vs5gypFgHoON9?=
 =?iso-8859-1?Q?IJB/7TjOCtxChkba2k7z3QfOsFwem7EYbVAiWpNLtDHyA6xC0o7oJ92pDo?=
 =?iso-8859-1?Q?ix6LEN7n9OjstvNfkAUsaVU+veJStF+/QCyHhNz+axKZ9H9xSbJmcJjH+p?=
 =?iso-8859-1?Q?738LYR0QFsyaUL7UQ4pZBirtdeVecaKld+bxwh1zfXZ2yVIm8JJ5yE9G44?=
 =?iso-8859-1?Q?ffq3TbNtwaFvlz17WVdgtAcCmo2HRcP6bF1Rq1Cqh7jYqX5UwDINZZez47?=
 =?iso-8859-1?Q?MZcc1ZgX1z6IgDDz9Pajt5wdEANAQ2WnyG3JYt3EtZeDwSOIdMcLdJL9Jn?=
 =?iso-8859-1?Q?vXn4Fza3adzc2UxIacLUKMef0WXiM8UnEtHRNWeosoGUJaSVLv1teky+C/?=
 =?iso-8859-1?Q?Szc0zwQWwg5DcSLcSJBhNhxZyIAu5QhH1QAOuGHatkW2lTXDsYVz89giVi?=
 =?iso-8859-1?Q?aKqEHr6lioLlMJitt6erUe6uZ1PaWJGPRbqRYvtsq9dgOkLBqxb8/cMb9g?=
 =?iso-8859-1?Q?ybHelQgT+gRGmhbWS+Yi4xxPIs7I3KN/WY4ontlZmC/FS7hPybLYMB/h/2?=
 =?iso-8859-1?Q?og7yXnzewZ3uw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fff4f8-5e47-4f63-ec2d-08ddb7f1dfdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 16:19:22.7012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5aQXJ5Y82cC2/5cWTVsmReIn2QX48C1Rs84PAn/V3+CgZ5vhn0rnFC1fmaeeHLKQlYONcVb8zP7N9amiInFDZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB6419
X-Proofpoint-ORIG-GUID: JWTUTv7cotEMeD0a41EZxdE4RkTtEH4p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDEzNCBTYWx0ZWRfX/6TM8AwS4dt/ CtmUNc53Oe9z9KjYt3/ZeiUg3hSe9/KfZr0ARr/gtu1M9NafX9FKxbeRcZccurIXhZE1PSEY6Ha pJCMoulopl+8voZHfBcvca24RLXUVSL1v4sYiF9L+X3dkiitrFXSTOeCj6JUf/mM7gUjtJC+di6
 78+/678ms4YCvCPA95coUH7yo+as/Ad5pRQXBXeuDzVKMxboUq64lzlFU4BgYGv5zmw54LMkjKI os8sxdRanRuDQLOX8eTYbdWIuHvWBsj/JWcQ5WLRG/ZAMq1M2GxK6PXL2rw4UGXzlS7jM/cjwHg dM5J1xUaRvlJJGbwd+/LmoWUzmVR3gUJgMC76+M5g1VzxIh+3N+m6/iE7VRgXw3W6qWdfzHmj86
 IDiRToBv+sxjnuAKMn2aZWq6zG9TBxv6aCHHI9pb9EA8zo/I5cvnLJezz5xlfRjccgGLp3NY
X-Authority-Analysis: v=2.4 cv=MOlgmNZl c=1 sm=1 tr=0 ts=6862b90e cx=c_pps a=YTCy/NNc/GbGYbKR6UHGQw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=wTSae9ZTrx7r8reO:21 a=xqWC_Br6kY4A:10
 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=2OjVGFKQAAAA:8 a=VnNF1IyMAAAA:8 a=P8mRVJMrAAAA:8 a=W13_91y_TjZyQkbl1R0A:9 a=wPNLvfGTeEIA:10 a=IYbNqeBGBecwsX3Swn6O:22 a=Vc1QvrjMcIoGonisw6Ob:22
X-Proofpoint-GUID: 3vjxrEpZ_Rr_JujxBtYTkxoWfzPQxQcW
Subject: RE: [PATCH net-next v4 0/7] bonding: Extend arp_ip_target format to allow
 for a list of vlan tags.
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_04,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300134

=0A=
=0A=
=0A=
________________________________________=0A=
From: Hangbin Liu <liuhangbin@gmail.com>=0A=
Sent: Monday, June 30, 2025 3:18 AM=0A=
To: David Wilder=0A=
Cc: netdev@vger.kernel.org; jv@jvosburgh.net; pradeeps@linux.vnet.ibm.com; =
Pradeep Satyanarayana; i.maximets@ovn.org; Adrian Moreno Zapata; Hangbin Li=
u=0A=
Subject: [EXTERNAL] Re: [PATCH net-next v4 0/7] bonding: Extend arp_ip_targ=
et format to allow for a list of vlan tags.=0A=
=0A=
> On Fri, Jun 27, 2025 at 01:17:13PM -0700, David Wilder wrote:=0A=
> I have run into issues with the ns_ip6_target feature.  I am unable to ge=
t=0A=
> the existing code to function with vlans. Therefor I am unable to support=
=0A=
> A this change for ns_ip6_target.=0A=
=0A=
> Any reason why this is incompatible with ns_ip6_target?=0A=
=0A=
Hi Hangbin=0A=
=0A=
I am unable to get the existing ns_ip6_target code to function when the tar=
get=0A=
is in a vlan. If the existing code is not working with vlans it makes no=0A=
sense to specify the vlan tags.=0A=
=0A=
This is what I think is happening:=0A=
=0A=
In ns_send_all() we have this bit of code:=0A=
=0A=
dst =3D ip6_route_output(dev_net(bond->dev), NULL, &fl6);=0A=
if (dst->error) {=0A=
        dst_release(dst);=0A=
        /* there's no route to target - try to send arp=0A=
         * probe to generate any traffic (arp_validate=3D0)=0A=
         */=0A=
        if (bond->params.arp_validate)=0A=
               bond_ns_send(slave, &targets[i], &in6addr_any, tags);=0A=
               <.......>=0A=
               continue;=0A=
}=0A=
=0A=
ip6_route_output() is returning an error as there is no neighbor entry for=
=0A=
the target. A ns is then sent with no vlan header. I found that the=0A=
multicast ns (with no vlan header) is not passed to the vlan siblings=0A=
with the target address so no reply is sent.=0A=
=0A=
The ipv4 code is simmiler but the arp is sent as a brodcast. The broadcast =
arp=0A=
will be propagated to the vlan sibling (in the linux vlan code).=0A=
=0A=
This could be a testing issue,  I am unsure.  Can you help with=0A=
a test case with the target in a vlan?=0A=
=0A=
Thanks=0A=
  David Wilder=0A=

