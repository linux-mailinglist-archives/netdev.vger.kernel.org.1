Return-Path: <netdev+bounces-109073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D4F926CC8
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 02:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C649B22525
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 00:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C665033C0;
	Thu,  4 Jul 2024 00:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="ImQG5HLJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBF223DE
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 00:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720053782; cv=fail; b=AVGll5rRMOh3Us8RiuNG7iAvNlOgjGyf7iCOFUP+u1Rn9ztjidmXXMG4Fyoq3FkeHNquIVj0iJGDU8L4+wnDb54S9tQOkY+DogoGeYUpcjrddmP8pgd7KaQtqWnGcxZMPS75puhasv/qraK0BaXjzxKPWydXEIgzJNNo5+W7omk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720053782; c=relaxed/simple;
	bh=qmOurWu9PztR1fXREZsqBZ+PnMdn6OJ2bifm06ehqPM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DPjWQc5eFbCpN5WD2thnHuFhrDNr+I7HpFAmixbjTgplY4G91PBf+rcsMuVwIP5wIGhPhpOnxWq7a9uIMxTJJUnHpncbMcFGnnAOc7X8M9PPGj1/nah9BMcO9LFDor5Yq22kiAknoMqFDHomGf4iO2VvWKurrD1gpLl7PewgdPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=ImQG5HLJ; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 463M3DN0012477
	for <netdev@vger.kernel.org>; Thu, 4 Jul 2024 00:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from
	:to:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=pps0720; bh=qmOurWu9P
	ztR1fXREZsqBZ+PnMdn6OJ2bifm06ehqPM=; b=ImQG5HLJnhk1aTOX5qAg67M2w
	3tOJK3VHROrOAJN84jtdaZ8jNl5JDSF2cBf4GLlO70wRynGXV4SfwNK8ZX0lCFyL
	l0lXfaRMTURYQbLuJuV87mTp/P5Ioatx3E+HuYytlSrY+DuxsEMzd7ppqXWQA9yD
	yglhFoLzeV37TTST1ngDmeug8XDDkSnvPl3qv64EOkQu+4DYdZQw3iJMqHbjrfYo
	2+XYyN29ojhh7fyscr/9rVSQjDbvgT/v6BQbY0I09bAjvqzR7m8rU3+8/aJrJxbS
	OFHOJk5csyNaX1c5EyTG2nTIa/MJNQkrgSvUVYvq0WgWxEBpjS5WiPft7mlVQ==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 405dathhpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 04 Jul 2024 00:42:53 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id D9BDF147BF
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 00:42:28 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 3 Jul 2024 12:42:25 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Wed, 3 Jul 2024 12:42:25 -1200
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 3 Jul 2024 12:42:26 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnFIY4g0bJLQXdhzS0v5/Zxp43gsmakAbOjxT5po26qLh2FUn8IgLB1fhwEh/Ckedn6xDF/Xj/XL6jHoYAs3HheLjbgBJCoHmY7/+dd7CkAu72aALs/eeBr5Rf3oVlLoM7LOZpMO4wfeSxkEUMe9eWJqVxXwqjkZ7ijAIAXkXw+P063TyA/ndbvbNuKyUsdkE6YN+G3049U7woA8O122bPWGz9BgfmygOifHIH8SbzC8AB5F2fTioeTOp8jJySodDqrK0x0CzoZvU3DC/oHy01eQLUxwNrpfDxAKNuvzh3CBU9TyGVZsm9PFNAy/gwCcg+cwejqFLMxJWR4E2jJDaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmOurWu9PztR1fXREZsqBZ+PnMdn6OJ2bifm06ehqPM=;
 b=R/NXVyvRjB6JVoydGKYDoedZCApndjPQfXYuy3oo6D3Xp9hr7z3BirNzURABudODFZuhACQq8jsRgqlnPOanKVJGbifGQLyN4IALwEXY03qvmz8Z/nDXGaznpOlZAaNOJcQMCkCef/m95TTkLlLAGxklmDX3G7OQ7sJg1pgvagqUW9wkYIJSBkAncKyTCr5EwGMCZnY0xxwsf5tfSBE4MDBA9B2cBXsw1+uv+BRcKHkiRGW09PXRtvOx6I4zFa7HpHZOesKUBpJVMNmy2zEGvBY/xQQFHXx9Yi4vkVvRAFOPg3HjuxGJUV8cAJHdqSA0zCDJgNEhDWIm/V5Afio5+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:437::8)
 by DM4PR84MB1734.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:49::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 00:42:24 +0000
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d]) by SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d%5]) with mapi id 15.20.7741.025; Thu, 4 Jul 2024
 00:42:24 +0000
From: "Muggeridge, Matt" <matt.muggeridge2@hpe.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Kernel creates 2nd default route, why can't iproute2?
Thread-Topic: Kernel creates 2nd default route, why can't iproute2?
Thread-Index: AdrNqthzvNLdXwUxTEuMZ1Br7qk89w==
Date: Thu, 4 Jul 2024 00:42:24 +0000
Message-ID: <SJ0PR84MB2088C0CC554432A482DBDE98D8DE2@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2088:EE_|DM4PR84MB1734:EE_
x-ms-office365-filtering-correlation-id: 63e00612-ee83-4860-daef-08dc9bc22bda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?kqDcraqGZnRZ6BOg0O1X357Jw+Gv7XI/Z2iKcO8eqzpmnRDtO0BKIS6VXd+T?=
 =?us-ascii?Q?mi8ZmCCFggN37uvyckkEWcRPZYm326eRI47j3GuUrt8tDBSb5NzIaQpWcAXl?=
 =?us-ascii?Q?4Sfym7j4GypoJ4qUCd4BAkmgW7YNwCVjcTo6AFmqdHi8szFgI0m6bJS/vfff?=
 =?us-ascii?Q?elbeNbJm7PkL0DRtT4jHLt/uphZnoMVdoiOnhK+x9cr2rPfK0D/vcuzd4Yxi?=
 =?us-ascii?Q?INA+E9/Ytfs8FvQ4KYd4tXey2LNaOC6KR8JUMJ8kTjfWFU9Gt0CKQSHlKsWv?=
 =?us-ascii?Q?RU1g1R+n1BNq9x4QKmORL9DazCqa6NgUN6NKpUEuJF9O1DUO6jIq1+wCI9Vb?=
 =?us-ascii?Q?QFvSiqLsyrBRxddv3xFLfbP+eai0Z2Y7IKbyPFk1inVLqmk5B2vRTxHKlCgw?=
 =?us-ascii?Q?+NVwLUl26sA1E7E1bYWgRJddJFh5l4bXgFO91NzFufmKqxEC5WVWNY6X+lRr?=
 =?us-ascii?Q?B3vIhf4NWdalQ4qkQD0n2b/my4Y0PDL92aJctY28jYfKZj8o3v/YYekqkdwa?=
 =?us-ascii?Q?sRWqDm2Ly8l6bQNuwR048wtu/eLJn+g1RMau2XCawhavGC6mBoSixw8wxckR?=
 =?us-ascii?Q?IS5AMdNxEL3ozZcCYhIr2IWrvQCYokiHY4FlxPnURc6EYbW7MBMX8slzCVjT?=
 =?us-ascii?Q?E3M6g3IpALqFHa/ostuNp6N+suMB5CSMoQjlgSs7RKcsdhqzzB1HfGhEEVOm?=
 =?us-ascii?Q?f2Zycag5UxaBn020hzYgnrNGSB5cgQ3/0eUzKPDBWkL5nUYYPNZyZF01Mv05?=
 =?us-ascii?Q?q4dGGwu1CC7LFNpUP8Miv7/QpG5UVzbv4Z65LzNcZMAJx7UvaW8VZN/+b2J3?=
 =?us-ascii?Q?xq0mzJwADL5m8d8uWX996qZc3B0EUylM5jeN8lfaklpGUaVNMnM7ud6rmEPE?=
 =?us-ascii?Q?sTdXKA15FhOnjeV7d7k3hV/M2brXNzvglUS9nLr5IpX3Il7ij4i+shUAH+fn?=
 =?us-ascii?Q?KCTkAP4SO/yzjm5GeJpB5iogmLTc7BI8hJpKrODiZHHc8HPq5/M7uYZwy0YO?=
 =?us-ascii?Q?PBynq8KcEgP6WPFp3D/rHE4seq6ntGIfltgrvNca5wGKKOMhOJMGdLPQ4sPD?=
 =?us-ascii?Q?kDmRcmqx/XlJD9tWVvxx54JUyNGGK94IHg0TkzCwnT2td7RCm4cS/Q1JQWTX?=
 =?us-ascii?Q?BfZa1mXzxoEG61y7q5rsy+6zN/QFG3+ZNAiuYiGwK7NqP2glW2SZQWsA5vh1?=
 =?us-ascii?Q?1Py8BjdpEvDpZVZhhkR70Y6JxAKao/mkoAA8XA6Wnbu5lG6QU9QpDklD0bCG?=
 =?us-ascii?Q?BmHOhPrkPYmjRT3OIgw8aqF6WrWslr8KVK+yR+kDpCjQ0e15GfF7pkTM28mR?=
 =?us-ascii?Q?RjoS2xndypLALc+a2qTYK/5y9zth8nUBQUmRe1NcQRLWhB5+ygTC+4FTxlAu?=
 =?us-ascii?Q?CwYdGYtofJ/WWPAOP55a2IycFmT4Ni4Llk8MSHdqk/LNeHcVnQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M2GqwPKlNg2QLIQbt5SzX1SXZ5alsSn2YJJ9Lj5HHow58J4kku7iSeKBEfF6?=
 =?us-ascii?Q?qfk1SkkhsnjikLwDRThG0+4IqNkZujNBGsS4SWsJKQNJbDonKcXLOrKGcMDG?=
 =?us-ascii?Q?9etJvilBEx5t6HSrol2eskPkC2ghgBFBeBenHxk7s/TkYobd+DNomWp2MtYd?=
 =?us-ascii?Q?HUJSQsKS9biTVdf0MKs3QTQownXpVJ9iAqLronYzNeJ3+hssqp7m49ozKPiz?=
 =?us-ascii?Q?k6NRxYA4Y++TZBC6FuAKIRUZJp+UftyNB25iHqqZnXT9NQaLhGGJxnm8eErt?=
 =?us-ascii?Q?8XrDp9zQa7PdC7fYHGF4O6Sucwra8bBqgi2YxfKkdqkVIJ6oM8IPTO4pd216?=
 =?us-ascii?Q?H7KXEQuBJ5b8BT6vZbUZWjqWRw20e9EePDIgF0dHr317R8c2oqOXNVdh9Qf6?=
 =?us-ascii?Q?OirN//BiPoflLPbphP30REyQY0ONGeOmJuAs5A4OfbAAikjEeA7t01trBCAm?=
 =?us-ascii?Q?H05OfPi6QVlyjwmVAtSsuxZTqPjfpsd9837eICqMA1shgcF2o8l8wYqezqeM?=
 =?us-ascii?Q?NJ+jh2jl1BjU/+xxz6+lmZEUd3wq4X+VJocCTaIocuvJ4NQCcGHUl2R4nntM?=
 =?us-ascii?Q?AMSb2ca3Jb31t/kyJKO9bIGc59iOEG+ZqyFZBsGRx3hULP9LHGaiYRFf5YMg?=
 =?us-ascii?Q?+cJLn6LTYZWev4NF6O/k6rHcCL+kztiNC6nY1H/Ji2d46Qe2lMSdugo6m+Py?=
 =?us-ascii?Q?fPjF8us57etYIAPOf/SACVw4KXfEUe1QzVl9wZZsYFZ8lzWbux0QbPCXO69w?=
 =?us-ascii?Q?JG4YEBwm2plupqNoM8gWunl8MUMCwQ57FVw5AFt8amVTBK0P2SmcNL2oquoj?=
 =?us-ascii?Q?pwbJlbl8g4LEWGlyvj6RUKRPHo+Ui8BSLeBHabza1N9hQDGqXU7iVbg0/Nmi?=
 =?us-ascii?Q?IdEqLsTl4yBOxcERCWpmFsSucUIqAQpt6rfQZ7BlzI9R6o7kkLCOJgSfCblA?=
 =?us-ascii?Q?83bRYDi+T9YwNueoyI6AO0x8n5cnpw/smPx6woWpNDn6GvUg/K84C91C4p+W?=
 =?us-ascii?Q?EQUNilKzm/Qicsu4mllTaua47fUlqC75VvtSrRNgVLIOf8LzaejwxsdH723T?=
 =?us-ascii?Q?rMFFFzPXzd2uzgbJB9fSK7sNHICh8MXPU4Sf3YBcHhJT7uVYDC+Z4vPECOgt?=
 =?us-ascii?Q?Co0U5RDkc4jiB1bEnXMCOUA+j5O0w+qT1L3NTRm8hP810UaGXTvjobrBj/AH?=
 =?us-ascii?Q?1CXDJ5kFPTnCWEKYHt1EKc0Rzkqy9K51cWVzlQQr+e1ADnyV4ZGaqbcqtLqg?=
 =?us-ascii?Q?lyecilKjdSEiECCmc9b4oj7XkgiciEHUS6zFRicuSkLnhNCx9bXvJ7mf+/xt?=
 =?us-ascii?Q?kpYMpmYAuA9b9w/GZTnAjLnJyKBzXpBDC1LtkaJ/p+yFyO6Od+iaqXMRxXb4?=
 =?us-ascii?Q?JG07fs1iPOTu6MeutqcvQrznzeoG79qYVBszhdqT84lAsgBXhi0hWG7ijilR?=
 =?us-ascii?Q?fGauJwB3sR3p6ZErYDbV3tnL8eFnGxIORc1nqB7TVngH3GjI+TmL9KCYO/np?=
 =?us-ascii?Q?mivt5H2SqdySwkYWXd+onO/S0TK/lD7nAwaoGhFnSNcCp76q5cganu0QJ0dn?=
 =?us-ascii?Q?P9shAzkOiZfpe9B3z7+jijhHRgMExpNv117zZK+CTsNT8qWjLGtS8qqGSEyv?=
 =?us-ascii?Q?kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e00612-ee83-4860-daef-08dc9bc22bda
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 00:42:24.1288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EXsbwS4TBg3Kny/OnkTcX7+PVKNDXiKpuUp0g4hrhS2maaKz411ekoJmUUB9SEMlkgE9AHTu1D2SELQ2qaf/neyKFzKUuT48mxyoWn1G4HE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1734
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: Ok62A4e2i7LncwMaDTSFL6bG3KWw8CC_
X-Proofpoint-GUID: Ok62A4e2i7LncwMaDTSFL6bG3KWw8CC_
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_18,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=875 phishscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040004

When the kernel receives two RAs, each from a different router, it creates =
two default routes, like so:

$ ip -6 r
<snip>
default via fe80::200:10ff:fe10:1060 dev enp0s9 proto ra metric 1024 expire=
s 594sec hoplimit 64 pref medium
default via fe80::200:10ff:fe10:1061 dev enp0s9 proto ra metric 1024 expire=
s 599sec hoplimit 64 pref medium

Why can't I manually create the same default routes?

E.g., I tried the following sequence, but the 2nd default route returns an =
error: File Exists.

$ ip -6 r
<no routes>

$ ip -6 r add default via fe80::200:10ff:fe10:1060 dev enp0s9 proto ra metr=
ic 1024 expires 600 hoplimit 64 pref medium

$ ip -6 r
<snip>
default via fe80::200:10ff:fe10:1060 dev enp0s9 proto ra metric 1024 expire=
s 594sec hoplimit 64 pref medium

$ ip -6 r add default via fe80::200:10ff:fe10:1061 dev enp0s9 proto ra metr=
ic 1024 expires 600 hoplimit 64 pref medium
RTNETLINK answers: File exists

Thanks,
Matt.


