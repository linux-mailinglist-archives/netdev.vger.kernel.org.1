Return-Path: <netdev+bounces-198712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BBDADD2FC
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 17:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53FB17B656
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373A22EE60E;
	Tue, 17 Jun 2025 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ydx5IyQj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A12D2ECE98
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175170; cv=fail; b=LQhQvaoWcw9JVj3soTMvVuz+D5nMNoen/+njZiWEb9Ei+DR070Sh3ai9Hjju14lUtXZHjHAb5Jf0PCjHdiJ6mxUYSaphC86fQQmqmzqo4H7sLmWZw/co7VNSnxbe4H0PrN4PtAZ2cdPtS2icrYou7NkD+E30h4a+vo9DcC/X3ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175170; c=relaxed/simple;
	bh=Gc/wdRksykAgLLNhAunGTX7zCM+WX3KDBA61zdWFNBM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=oCyQzOJy7TWPAMy14gbXZ/3owwJfjCT8Mhp+p7V5XvlhIWx5J0zIc9EuP1FKnWTuvMFvltqkcOQTi0at5WCjflIDJSO+ETU8gWygT56zzgD+Gft7iO8dA3+89+oNrOQMXfWEQF1kkeBFmrNJrHX3rTf80EoJ3Ah1KHDVQ0SJFaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ydx5IyQj; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H9LGIR010036;
	Tue, 17 Jun 2025 15:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9lBcdH
	vO9qosXRoB8xUl9r5EREXVAbGnDCizMPPgkHY=; b=Ydx5IyQjETYqjitxzOtU2p
	cZV+AW6F7y8E+EphovWfcfJbIvvc2v2WG04wtLuyCso40+9M5Yumb+1z7e6l3i3P
	ba47CTemLmdFMQ0rO6n3KKtMwh71FqMQzqOhw4L4UWac3ZafF3PEiPC2t/9of4p8
	lOBT1nNHpK4wysIy8LpaP5K1kP9XIzkF7D+oKJJVAd7mePnT3wW64ZhLNtjFiN1F
	7eMshZJbLzAqYA4MYo0TCc3KYKxIcjfgb3cKePEPm/n1XE2dagmikjGADGEl7GFQ
	fvXERXpTknfEFBwqMv4Q54CXvDQP+IeQVwg0Q9MDzlnjSZ4pfbppnpfk5rrrISFA
	==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790r20xqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 15:46:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFDWQnNXkEP49Fdd+daQgu0hZSqGZodxIImuJWPbj1/kQ4pAyAK+kPNG4OY5XEGfDt4yFKV14i54OX9foOXIea0drHckQb7XcnYeyORp/mnFT2UAADaPr4zr5OySIRQ1XNZinuguyMZxVRYomAKu4jrSQNkK+IuUEpp2nVcEUGMIs7I0QCsIzB+UET1A8ZdCEMXK+/uEzGs2g6WHIcVHGuaif63e8rmw23tZjnqnSqetCaGO6zBzsIi7C6p1udnp10etF3i2zCsZlW0y6+8ZAcETf2fNGrT0dYHYLtm4qlX/FgvrBGzzgxjp/NOg0Ks+q6Z3EeHWsTj059hvaqls7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lBcdHvO9qosXRoB8xUl9r5EREXVAbGnDCizMPPgkHY=;
 b=sWzXS/eFA8MXQ3ZPlPnYG4Eh3fyS9AqO6rIN+yrLSU+Syn1L/5z7hZ4M2xjNCmIWEDq5uWUnc4wcn7fXa8C9bQb+CfP8Gp9q+P1HLy9XovpMf8M4GN41DrVful8Wgp+VjfLjUsquIuXo/3HUFCrr1NtuqgbWkskY7gH5dC26JFWwnhT7APC1dUV8/OmxSKhqSQf2lJD4lVYOFFJNbi+pdwuDFh/Wxu99dcH88I3ya5/D73+20s2bCd3jijH6ekJj+7Tydk3g2k7KfDhT2Kn4Qo/eg8l3d7BCP6BfPD0SIZIw4zLTxpgOtGObEVhGzP+oxciAUR2GMBGysmKyeZwAqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3913.namprd15.prod.outlook.com (2603:10b6:303:42::22)
 by DS4PPF189326653.namprd15.prod.outlook.com (2603:10b6:f:fc00::985) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 15:45:57 +0000
Received: from MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490]) by MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490%4]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 15:45:57 +0000
From: David Wilder <wilder@us.ibm.com>
To: Jay Vosburgh <jv@jvosburgh.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "pradeeps@linux.vnet.ibm.com" <pradeeps@linux.vnet.ibm.com>,
        Pradeep
 Satyanarayana <pradeep@us.ibm.com>,
        "i.maximets@ovn.org"
	<i.maximets@ovn.org>,
        Adrian Moreno Zapata <amorenoz@redhat.com>,
        Hangbin Liu
	<haliu@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v3 2/4] bonding: Extend
 arp_ip_target format to allow for a list of vlan tags.
Thread-Index: AQHb3M6LxG1Rgx8M5kWlawP8WoHqT7QGb54AgAEPlrE=
Date: Tue, 17 Jun 2025 15:45:57 +0000
Message-ID:
 <MW3PR15MB3913A782BBBCFEC112E1A662FA73A@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250614014900.226472-1-wilder@us.ibm.com>
 <20250614014900.226472-3-wilder@us.ibm.com> <1928187.1750115758@famine>
In-Reply-To: <1928187.1750115758@famine>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3913:EE_|DS4PPF189326653:EE_
x-ms-office365-filtering-correlation-id: 93c09e32-7af6-4523-a99c-08ddadb60d80
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?CtDX1FYYYsnggrlIWlVz8QT2Z48oPsdGhQaC2dDZWVnn/P7ear07Vo0eu+?=
 =?iso-8859-1?Q?14E/cKiUjkGSjE2/UTaCyqxYWlXA2oozs1mvM4ydOXy2QAReG23u735+fE?=
 =?iso-8859-1?Q?aLwU9BaySO0Xw9VQ/3jCsWGiY07/sjiWIVCDuqA+S6dF+hfxRG2lRNAev+?=
 =?iso-8859-1?Q?oEhX7y29dGoPTeGPuDOJgzQksZJssRydRpt7AtFUpcGvctjl4zcf8ppiOU?=
 =?iso-8859-1?Q?dCda5KXCybnRqOxDNnimwCqOVOyydGtBkL6GY5Oub6kqm2kL1y88CDIHRz?=
 =?iso-8859-1?Q?ROHCR/ILZdUlOWomORlbpo8ZYRSTrNDKJSMa7DJs3JhnSogKZsU3eqyYMk?=
 =?iso-8859-1?Q?jsC7p7Gu9IYdHs4fbfS7+xfc96WaeRr2J8byRqt/r2rUgk1fHFnbKmdUX4?=
 =?iso-8859-1?Q?C3SGPMfDY/YQst/pdgxE9bxQ6dHFF2J0k/R3SUUF7x0k3uAoqwXU8KFjPX?=
 =?iso-8859-1?Q?jkUBcx89QbYR7v0Uq+/SjtxYERi9oioOyNFULeCck5QsOgqzmRKxag3pJt?=
 =?iso-8859-1?Q?gj55/xsfuLIhAUXc2zXSFaflM8mMSiuXAvCjU7Rse6VmaGN2jCWZ2QmUY+?=
 =?iso-8859-1?Q?tHLJnUT3RF/DNyZ7JHjQxpQ2MdbhSX8kGYO2r2M+SJ7edgeyYYxc7P1h9r?=
 =?iso-8859-1?Q?jjBa+s0vcjn4W1ot0xp8vtQci2nV3Tn8w7IkwEr1ATtenwIzYOhAcMP2Rb?=
 =?iso-8859-1?Q?QmTgfFxGOd4wrTpGGw7XFnhuCowVKuJfYVafDSvMyROvZjmI0rEr2pVzub?=
 =?iso-8859-1?Q?02N55nOtUeol1a43a6XBCloU5CSZl7IxzG55QBgMnw3Okr0R26LJqNRXde?=
 =?iso-8859-1?Q?Rrc5tpngmG9x33wCwzsINsibG6ATBur892Ya4DEdg5t1BWAZxLzbKbwFsu?=
 =?iso-8859-1?Q?uMcRdPgbgBVgq8AHqFIy+X6zIWezaItWNHu/jE26S8IMrp/swkjxW/oIhF?=
 =?iso-8859-1?Q?5jf6ijpLXUh/0QFxQfWStppOuEAA4bXTk2DeUUCz8K5TwQ87PiZDa5vzXY?=
 =?iso-8859-1?Q?kSjv33kdb4D+CDYBdlaWBcrZiYsL9HE3IFDAKZsfBsNLEe1oV3xuez36VU?=
 =?iso-8859-1?Q?KU9rO1Wibce41pbMOn+1+bQMcDBu+ppfrBnnD7fRwBwoLP1as+Mrb47/nQ?=
 =?iso-8859-1?Q?O/HIWIzdwZdDAFhG9UBDzj9xYU/wNcgqBRQUY8a7TQfrU3fGh0ch0lXRK9?=
 =?iso-8859-1?Q?XdQzrCg+k4z95AzsW1tuT71izcWT9qRQmqixK0vqfRxL/xOj+W+gA7/sQh?=
 =?iso-8859-1?Q?vviVy1pXSp61jhkzkHhSZRH6ytDgZ4wd0JPDSUxyPmhxfd+ftWxm3tBW1p?=
 =?iso-8859-1?Q?4iY9UvlXgJnPNJHD7mGd9UDePLyAFFAKKIvYM0OZZYsxt5i7uonPT3gJV0?=
 =?iso-8859-1?Q?K3Bp2psy1F2xe7sVQ4tolVkohH2Ej4PKgoDYOWgiz574Us6FjUPeHWJwcn?=
 =?iso-8859-1?Q?Umx7ig6HeS1CBqHpx3zchewXLqhmCf2jjIKNP/hvC0Hjfsan/TR1qplhPP?=
 =?iso-8859-1?Q?f8A2MCQgAB00cqn1f1VpMkbJT559hC4AI2l7UR93u0YQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3913.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?8lOwtNUWnXJBHSX9OS8dsK1ffPLGFR4H9c555VEfnV+1nrKBSFIZUsv3wQ?=
 =?iso-8859-1?Q?C7SgixgDwpHqkh6xK4COuzyMKGztbU8jDzdJ2rRcNqMh41JkkK6HY9ew7x?=
 =?iso-8859-1?Q?fJBvhI0Gty3xEUo7u1cjBDBOpbWPpx2LYFUSEV2PyaUlfqxuJ0kVJiEA2A?=
 =?iso-8859-1?Q?S7OlVFzdztQOOkFWGCWstc3s+lTYyOsGbYnQYI2vB+ATRYwX89l4Iq7B1I?=
 =?iso-8859-1?Q?Sm9Q1guC/pWnYWfu0wpTPbR+Gu85FJ++6VEoLELYOth4/GQKRnDWHFLcA/?=
 =?iso-8859-1?Q?fa8FO6CXS3VGDWulr3H711UN30XgTIROo1oK55ApW1A6xe70WitVckVROF?=
 =?iso-8859-1?Q?Ix1MWG8yr/X/txloIVBDnyu8rwDoVzfRcRZC8KrKjtHfyxlQdXMleU7t+J?=
 =?iso-8859-1?Q?MGxTDTG7rZzhTRaKe0swZK4jHi2Yme/hVHFABA47SGGiOzruNr92oY4zVq?=
 =?iso-8859-1?Q?Kua0R+cLqVKmJINClJ/Mx9ZChprlnDWcA+FgutImr3x9IjOAV+8gP3NHkW?=
 =?iso-8859-1?Q?FhzfW3DUzPgMGkNrkuS55YRkLv2awf/eaqPwvTx8KDX7yiH/JgMczncSlQ?=
 =?iso-8859-1?Q?WCxaHO/BvtTx9hyxcGYF3prlQSqs+j6U7cvzyH+4khbN2BmS0gVdpy+21t?=
 =?iso-8859-1?Q?ls+uY7i4PtIKrZzZ/IdKM1MPftkGF4vYIH/Wa/bKGPqAfFN2eAGlaJ8yfa?=
 =?iso-8859-1?Q?LFa3QElk1BMhZcisxzDrOVTh5Ku5bdMtMonoJzTdkfzqLIcWQ5z7AzM0le?=
 =?iso-8859-1?Q?JjjytqpO7VAttvlQxXVDBXLoPULRlqHeZEufjEsK66EPmt4SKaLVWNoOkZ?=
 =?iso-8859-1?Q?bj/ys+WzfGFLRJbz281nrGfI19wU0RWePuemUmWvNINP2FL44SKjupMKAa?=
 =?iso-8859-1?Q?iSQIB3poBBkj9qMmS7uP6xhUW8mGqsXsG1Prv9zDoxShtgI0w+ym978ouQ?=
 =?iso-8859-1?Q?1SjcB+hhajnlTzYl0daKmgW/PSm5Bc3kmybOIUFYmrEMGCk2Jtoj11G0ap?=
 =?iso-8859-1?Q?ux5X9va4GipqEAjJBxnppbsAmaV+egLNsPxFAFi+BSUVUBEk/vdGdLjQFD?=
 =?iso-8859-1?Q?w4RtkKyEwOSbayZf9f/e0pDOvvxEoqED/bgqqNDPDFyHCeR45nN+1+9A4F?=
 =?iso-8859-1?Q?zWxKYmSRMbX0A3moOmsnxND1bviMP+4loIyw2u9F8zIjuW+2GFs4tXd7H4?=
 =?iso-8859-1?Q?wdaTJpxOYF3Xf/L2dBV9I+SR6Ej8PaPZqYffunK6KNXC6pcoS5ZxLm3IKd?=
 =?iso-8859-1?Q?1cL1ANNDOWnxnrFbXZFa3jWNyHb7q3sb3mL3Wk9pX13FCCKHoCiacSVXyZ?=
 =?iso-8859-1?Q?Zr1me2ILMTSaDsY6y/vHBlu81lzURScyL/+ILuORhpZ+nUoWHj+ZMcCKXA?=
 =?iso-8859-1?Q?mbbgr9a+oP7eSSwE74ics0Gr+AIK5co/q1f7/l1PYVuN8aFLrA7GqX7yAk?=
 =?iso-8859-1?Q?zCwTj0M/RBNdQKkMjWEek6J6lbOGnPJ32W6mrGCZyzMW7EOyz0eTN84GO1?=
 =?iso-8859-1?Q?PjhW6OzsxzQ1kbsn0QFE7vSCl18oGc3MrLEpaf77rcwJZcNXqbxzIXlEJZ?=
 =?iso-8859-1?Q?bHhW2AxCv6VYcl2Kt1/3QxeLIi0WfFBz+TkMvno+uKfIGrq9Vz8lBOPbMl?=
 =?iso-8859-1?Q?C1m1U3Givhl4w=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c09e32-7af6-4523-a99c-08ddadb60d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 15:45:57.5792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9YI9kz4njxplqhruS/A20pNpMg1OycI91TyeZYWoxwt2IjVcdiYlHpCt13Rf4vHv/tQA8Z6LlgVNxUD5FRARGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF189326653
X-Proofpoint-GUID: GPj1nDU1fEYDqEN1Hnmum59OIUPw0n0k
X-Proofpoint-ORIG-GUID: GPj1nDU1fEYDqEN1Hnmum59OIUPw0n0k
X-Authority-Analysis: v=2.4 cv=AqTu3P9P c=1 sm=1 tr=0 ts=68518dba cx=c_pps a=cuGhpuBU/Rulez8h1ZIujw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=wTSae9ZTrx7r8reO:21 a=xqWC_Br6kY4A:10
 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=1KF55PQ11cI6YNXyjtoA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDEyMCBTYWx0ZWRfXzDWRvETTcz+r G5w0dyRPK6Izw7jXt9etmBBUJyM/fowCsWYQewXT9eNkFyLPlqlA0zldLs4A8qXlsNB3EB6VWEg Tfn7fnrdhZm1cBeYJ3uhKtVz8SBgCOKtyQ+S+zM/uznoO3uRdt02mXn339j0C3gtXj9g1ADRTDa
 EQt1K4jnS/NrYPx3n6pK78mLbQAgcTfvNFvDEFgKnP2SojelTX5fg9wh7fdHvuqhSQ6xm1exm+p WZRbfn4pUchG8fITryS+ccvWGud6B1ik6VizbAWwo1ysiYdbQ+sb8p/gBtpsqaLFs3Yx4RUdZ9I XJ2LX3e6LFwEgCMsZGefsK8VyaFbAmAskmlU3/iamwZTb6UMpgNNtSKj8Z4CUJTOp0r8xnhmVE6
 +cUu5J6fuXbn+qz6doZKsaNE+Obz+JV965Im2B8AYlHPX6yslBdHiS3Ra9swwLhbdQseNuB+
Subject: RE: [PATCH net-next v3 2/4] bonding: Extend arp_ip_target format to allow
 for a list of vlan tags.
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=885 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170120

=0A=
=0A=
>        Here, and further down in bond_arp_ip_target_opt_parse(),=0A=
>there's a lot of string handling that seems out place.  Why isn't the=0A=
>string parsing done in user space (iproute, et al), and the tags passed=0A=
>to the kernel in IFLA_BOND_ARP_IP_TARGET as an optional nested=0A=
>attribute?=0A=
=0A=
>>+              }=0A=
=0A=
>        There is no expectation that sysfs should support new bonding=0A=
>API elements; only netlink / iproute2 support matters.  If sysfs is the=0A=
>reason to do the string parsing in the kernel, then I imagine this could=
=0A=
>all move into userspace.=0A=
>=0A=
>     -J=0A=
=0A=
Module parameter support also requires string parsing in the kernel. Can th=
at be dropped as well?=0A=
=0A=
David Wilder wilder@us.ibm.com=0A=

