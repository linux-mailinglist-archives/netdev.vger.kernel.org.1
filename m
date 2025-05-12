Return-Path: <netdev+bounces-189912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CDFAB480E
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 01:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88C6F19E6375
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 23:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF0E2686A1;
	Mon, 12 May 2025 23:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GjubkOH+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDAC26868A
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 23:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747094076; cv=fail; b=tVaRqKPkj7U4c+ueeq/Sqd/uIoEsyU1MF/brvcuqasDYu/0Dis/e6EwgqH2UCa1inQB8bhecnr5XeSZN2Nb7vsP7fSWXFgQDwIFg9EkWpzcVfB4DOSwvFrM8Wp25mWeU037GJ7YoAEHfZiVkwahrW1zaU/GoY0HGcWGqgfuUMF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747094076; c=relaxed/simple;
	bh=OhPD/JVtWalxmz47D37CmGQ331vvf90ybiHqWRd0DK8=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=letYfbBGgX5hRPMU3Jwj9GGmun7fB8mNZlLjYXAN3FV8z+2u2/CCqmFgg9IOPFnk1eavh3AvsZNdGbBf2OvUO5bpV72Ce/RqghW7t4hJvPPS0lmioBNfoxsR1/5DFfxBqN4QdJUt5q5kjqR9pbkc8CrjMvcnDEDeiYX3X58eDs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GjubkOH+; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CLPL9p001298;
	Mon, 12 May 2025 23:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+hzLXq
	JL/kIXtqFe/Ydqy+ciBCtMBlt/Nn1oYtAh1dc=; b=GjubkOH+uMdxm1bS8YTeDh
	rKtoevGYmobuQM/e79BohaeoJ40hCIeK10gYXSpqhnLgyQL/Pl1EPW94nJlAAwOQ
	wa3oCjX6rSBWXXvA1gPBhBIh/WfZzYreCukf4oq+DLpG1kg341div+06eYkgBxQU
	l/9mG6WsiSv1c6n1z70KPt42knDzLYVk2P55a7JEBcpbxEJv+Vn7rU0gUXKTOS6u
	bnlLBvsXOphdFQTJLdfyuHCPkP3KSb0J9NlsxHG4x0/hIvwNGZwj/AhPhhryyHkF
	+2T7Tx+gHYz+3pqCkdyjV6xzN3mnsRtoZ85MGOtrX91HH3QHFv92tbzmPwurO0qA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46kj75ak1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 23:54:28 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54CNr6SZ030729;
	Mon, 12 May 2025 23:54:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46kj75ak1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 23:54:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdRJ+fYxCeZ0BCw8shG61mcvY646n75F0QJnD7FsGM5jTAZqLhFQFckfhV4RAKg6lNxY+D7vxlTGg68GSfbzgxHNpz1w/91fANQGhSCfZJ2owT79MdXTXNR0nq70Y3eRG3EfmJ+kDgNJPTfoMLc9PQRmb3vUW4S8CaL3Cx7GR2937OcfV+jVju676W2X2nL7+e2vSZAlttcUJKh89ObIDL8Q3kblxITfPkHreuQ5PUfv+M5mfsEafoclMSbbcjKuT1o3+hnHKsPon5XW4G5SoIu8DAkqict0ylFNaU7SjYC/jBXnTL/UEgEFtoPC9ghUEbgnkCssh9IHolQEIfNtdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hzLXqJL/kIXtqFe/Ydqy+ciBCtMBlt/Nn1oYtAh1dc=;
 b=t8Hz2DhXXrn/mcnWZKP2Pq2uca0/1yRNr3WhOnykLMsQHLO7KAoUaGF2+j+5Z/VdTNNyjoN3OC25ai6tPtpgcPI+jqcuumfs1WXums1DFti0oK/O08BXBjn3IXHCBrnrPXn1Uu4OpgnfW3h0VZygJcWu4mBk/PfBw99NGkvx0UYlatv9IQv6KXm59JoxzQX+8Lfp2ZQ0A2DKaNy3YBUaZD7YDqAqqCnpL7+2bEqnvsH1UTINphVGHbwo+t9Yfud0MUWkgXi3mCaAdcykjA8RK0lbSy8G/K81FtyHwx0ErmGvfPdr907rOnI4w48aG36C3p9NSlwWAufxbyvP2GKV2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3913.namprd15.prod.outlook.com (2603:10b6:303:42::22)
 by SA3PR15MB5752.namprd15.prod.outlook.com (2603:10b6:806:318::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Mon, 12 May
 2025 23:54:25 +0000
Received: from MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490]) by MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490%7]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 23:54:25 +0000
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
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v1 0/2] bonding: Extend
 arp_ip_target format to allow for a list of vlan tags.
Thread-Index: AQHbwEdPJ+YWP6wmEkaXTcEN0mpIirPOac4AgAFGH+0=
Date: Mon, 12 May 2025 23:54:24 +0000
Message-ID:
 <MW3PR15MB3913C0A57D113A650B9C5B59FA97A@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250508183014.2554525-1-wilder@us.ibm.com>
 <aCF3CBlFg3G7LDGK@fedora>
In-Reply-To: <aCF3CBlFg3G7LDGK@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3913:EE_|SA3PR15MB5752:EE_
x-ms-office365-filtering-correlation-id: bc58b358-1d3e-4d72-b2c9-08dd91b05306
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?yXZwYrmvJcwd3H6bez0oXFWrPxtLVdva/BKwKU/V0OJXVBPbAcXBpUVt1Y?=
 =?iso-8859-1?Q?nqL0jeRU95Hj+t033iSgZzOGbcZUZdzPA9VTYWmv8dA87j5dPAV/pPVnCM?=
 =?iso-8859-1?Q?NB3jzAu1QJtVB9ETIe8BA9dOVTsLFAa7FYkS+7dRZnvhPI+QqpFujVntHs?=
 =?iso-8859-1?Q?0WU/PMN6mR8/qyiKT/6PJml4wNo5Ko2o2embCyAnYIAYgKGg21mhcrrUx2?=
 =?iso-8859-1?Q?xBSrP8OhLan1E1OwrfDn7TT6AK3vpv/iuazDKRfG4qIAf+lDO9SIa5wwMy?=
 =?iso-8859-1?Q?WITVHy71MmujpOangKXEcMnQmkPHxLU21maMmLDVPevftlgUUAqeid5LHf?=
 =?iso-8859-1?Q?8smCJj7G9GegokiwGt8W6EBc3lKb1MXa49//r/rAvurH/75PgelHh64nRg?=
 =?iso-8859-1?Q?uS+ZXuIYA1JpShJmfBimd0mfGkte44shkBn04x8sBOgu6XlQJvWD0CcCHX?=
 =?iso-8859-1?Q?UGpH0q4QpiRXkS7BgBAZ6owBMEoBTqwxPVslPh9iodTIr3+Dor4EiTPFfz?=
 =?iso-8859-1?Q?BXSpjRX+kGUlIqY3p2QgjAcbTOmyFEpPMxXaK7v4DXstbpcdwzPD0qT8Ab?=
 =?iso-8859-1?Q?7Mm7yCYLIprM0F/x85XfAh3tyPCFjUOStf4MzFeFIZ4unLxw3OpVEAn2WE?=
 =?iso-8859-1?Q?NnAo28/98lMqIvzpjT5KgGiIjcGNCmFWj/wA1TkZZYa8FYhrWULGEa4HnZ?=
 =?iso-8859-1?Q?rV2rlGz+cX9avOHG5FaVr53z3v9ItxmM2Q+0+T7kCHbZz0qNmG2eXcZE3f?=
 =?iso-8859-1?Q?66sC4opo2V7PZIHom4TnoDrIs3Vcy6IHr+zgyYWczMnjTSCDJGxchp0FE8?=
 =?iso-8859-1?Q?dhXf5hIDQrGEJlyjStqN46Dtsc/45vDsEbWo671Oyb4vhF6dBB75ilgD9A?=
 =?iso-8859-1?Q?5eWx9khrg6oncTr2BaKK5F43dCYInN3gxVXsjiQA7NEyJKaRtIjTbFoPHR?=
 =?iso-8859-1?Q?1wpf4R5KVzDSLvzINSZO5Ag0emv3PTfBfqUFNSGO9WWfNeKSDgu5ot2CyH?=
 =?iso-8859-1?Q?/PI2TeSSh7424JRKLCAhZvhr/C2vacMI3xEkgkZjrfGCE1PdCJdd1i8mHG?=
 =?iso-8859-1?Q?PwVVeIhGownpjlVkaPi8DV5fr4v6We8uhrphaARmWZP4oBEJ9YdqOo5eT7?=
 =?iso-8859-1?Q?9HtsgJdchBFhgcMU34KrszjYqTN45mrCQWDh5jqElkQvZdYcQPRWFBSkha?=
 =?iso-8859-1?Q?6zMPOUjhXw+itH+FNQuiiSfPUTLD8A0SLM5owDldCCDaB6Byk6OJhUxj0V?=
 =?iso-8859-1?Q?nUfeTxmlLrOtcm+mxD1nxQ/XxpA5aw6xsio3zByiNRHqtitK6/D1/ky4yy?=
 =?iso-8859-1?Q?8P3j3ErphSO4y2bQEgSePrRu7K8LUg/IaBQ/W+RRSlTKNuLd2nLXcO8eBP?=
 =?iso-8859-1?Q?6yg+5+7sxwuGH7YAEIV5x4hbz8MiGX3RQ8IH1jIde4ntZaTr0cILoTI9oL?=
 =?iso-8859-1?Q?8nV7Nqwe0IQYtOKa5Ji3F/QSnheK6ugFOC3qk0NVA0MOzPDnfC4Vr66OmE?=
 =?iso-8859-1?Q?3OwqFIc5wPcIUWDUYHQcbR3wWz9C5GOLcnw2CDxJHs3uXNP8QKbW5ee86L?=
 =?iso-8859-1?Q?k0B3EVU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3913.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ptu4uMPLuNQFEI590AWeK5ujoM0c2jXKWRddR6V917bZodgw4APXwGbSYn?=
 =?iso-8859-1?Q?AbyrHmMu+qtykAdtx/PeBGAMZDqfkrtz4uhCXGLfGnFWRGeSl5atiMYpyR?=
 =?iso-8859-1?Q?IJcL4aKnqN8xZ7v/8aqm+6h8GSSJN9zR1GuKwkH4ftV8vnkhUVKokZaSya?=
 =?iso-8859-1?Q?QDeonkbTX362jLmAt656q27Xnid9IncRx2bZvXYgPDViSuaJBt7MTJoDw8?=
 =?iso-8859-1?Q?ya4yz91Et0Ip6DGtgxEeszI4+MtY7bSMK2e1nzJXoiq2KDo6sOPumJ815H?=
 =?iso-8859-1?Q?m7bMYs0YO9QPOqQ56xMmYVU2shFy5O04nBvRgzOnTbkL81Cczao0A7MwEW?=
 =?iso-8859-1?Q?+cVcGEtd1SlJf2eM98WHXsEpVFf7zo6/f6bugvLmNfZp8WNoYTDDvwMlMw?=
 =?iso-8859-1?Q?McnMxwmaCb8GALYMRIM6abNDlaussYWhfL2IMq+u6rMGEzglw81n8/754F?=
 =?iso-8859-1?Q?yHDHTA2tViG/qdC0/pCC9f5Pu1plkP+GHDbS9QJvOHjPVAOoFKhDXG4xVZ?=
 =?iso-8859-1?Q?kB19XYrbCpHhgBuVI65ewtkPHd0il6tv0lfhKnKPw5F8jGvPtavjxBTOP3?=
 =?iso-8859-1?Q?UlZUxj/Q0e6KHlec3Muix5dwDYzz/dtKUb56Skuohwbxjix5qAgY/1NipE?=
 =?iso-8859-1?Q?k/USBq9N6w/Br7fUXPTvnfA0jTT43wLUvYY/aYPCZ/SQskyIMdk1EasUJx?=
 =?iso-8859-1?Q?5/Wd6VUcHeYdDwdjhp9s6u9oGfbQ5xRV3kNIY7cQMifFWpZlMfr28RXm15?=
 =?iso-8859-1?Q?9GJUwjjG7iE5ukQKb7M1mz2O/jekCQPMIh+ItvuZ3WEEXir01/W+khcsY8?=
 =?iso-8859-1?Q?WS2YSk3/O5dVVifL7huubdqC9/8vAv5zPYXjJQan+29wv5U539KCW2a6Th?=
 =?iso-8859-1?Q?MJ6rLvNnuh6dVcTC1SpTqy/gndwob3Fqg9vpBzyDjkLKFoq2ekxz5x+CCU?=
 =?iso-8859-1?Q?fDv+fiBu/mC6LU3qbqUleEktUCRvFlBSmGQ3UQ+FhgpGVpRn+zGPyHFNe2?=
 =?iso-8859-1?Q?TY2YVMkPLun9Q3FDOhjvX35HMMEMwc+v0WXRukMaacC8LKrRJ/ScSWdQR/?=
 =?iso-8859-1?Q?PDBi43YEpQ9PDrwUf0RSHJ+xoORClScIaiqIHeH0Jqqt5GVMCJeBmgKToo?=
 =?iso-8859-1?Q?0oXav8ksu9SSJEaEyCus7DBUI6pzsMJpZt8MHWDahBj/+WGbmfsCcKnJc4?=
 =?iso-8859-1?Q?zLxRJaK3rQBkH+ouSRoVdeVqcdLIF/LzF2UjJEgf7+9hyYw6857jraqbVg?=
 =?iso-8859-1?Q?4ebD+krbvw2YQUsWUhZ0dtIo4z1g2eS8lFK+5NdhKqu1dyNl2ZnxbdfP5r?=
 =?iso-8859-1?Q?FeGrr4ZK/EHsN2PWr/18GIj+0zMxHTz78GL+cubRUA9Q4nCWe0AswkjEg1?=
 =?iso-8859-1?Q?FS1MVa9YOvaH9WTRzGj0d1JOaOrKMjc4ymVxAJKFuQ0DiHqjiMoziFigOu?=
 =?iso-8859-1?Q?oHRjP0dGhf9wYKXGxmnnPcIp+fXV6Orfalx+miyZkBd+yJ1+UlnUuiUqr+?=
 =?iso-8859-1?Q?t1XFJCN8LDMQKPI9y5k6IaTu+NFRlIzD7PVaxPeWyjCeYvELB/pnirVC+X?=
 =?iso-8859-1?Q?fx6Nk1yUa9eK9hD7QpGvFN3X6nuz+o4KEjBEfxAfKfyOmKPtS+zN44mPi4?=
 =?iso-8859-1?Q?ThlEYbiXBS2CA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bc58b358-1d3e-4d72-b2c9-08dd91b05306
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 23:54:24.9202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aJ9hPhDj1QgNg9AMIoDbpqYcO6ecVYD4Z3UwyUIHKyyOKsfzijcRFCy4r6c1cdTJTxvPzjODsMbaGbajLgVUWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB5752
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDI0NCBTYWx0ZWRfXwWGR2c5fSILb PP2Y6GA+dycRtewRbvtiWXRyuAP/xLtnDEG8FzwaUrLSEKXHiihsxOiR6KBFtgiJNWw+gAkB0Nr zJSAuGW0ZfF3G2Dk5Ngxf20TFV0p+C1hG2MrtK/3tb9mDyXfX2ZD+/l4lTv4wCGwht9tNRsdDVj
 2qKCxGBwvgZsypsM47Pu7bgfodi4PdufLlbEpJfE1dQo6MHob4TJJ3bYCMpMfHF+hF80Z3d6THZ yTE95Qs1Ytd1Yi8X3xes6Dn+p/+tv2pMVBhwwea4axSf8APREYCCZtFShCAgpF2kAmjsP2quxUh NFWDhRsNuVhB3dDUxFWuOgCNh6MvPYtweZbwPsaL2PrORlblvFo+Js1LfE7oREaSPPa6xBKaSe+
 gKgPFFxb2AQNeLcnTR/Ml7DZG+OOpYSiWIAJGcXfL9I9fO6n2q+O5m+QoF+9M9G/mPgYuRwR
X-Authority-Analysis: v=2.4 cv=J4mq7BnS c=1 sm=1 tr=0 ts=68228a34 cx=c_pps a=o9WQ8H7iXVZ6wSn1fOU0uA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=wTSae9ZTrx7r8reO:21 a=xqWC_Br6kY4A:10
 a=8nJEP1OIZ-IA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=wsPfTLw4UDHXJBSGKtAA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: DZyoAZnjxYW9bt0KgYFAaboB5WEv301j
X-Proofpoint-GUID: gFqECHrb5Ic3ga3s7gD-L7c6UcZTcVp_
Subject: RE: [PATCH net-next v1 0/2] bonding: Extend arp_ip_target format to allow
 for a list of vlan tags.
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 mlxscore=0 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120244

>Hi David,=0A=
>> The current implementation of the arp monitor builds a list of vlan-tags=
 by=0A=
>> following the chain of net_devices above the bond. See: bond_verify_devi=
ce_path().=0A=
>> Unfortunately with some configurations this is not possible. One example=
 is=0A=
>> when an ovs switch is configured above the bond.=0A=
>>=0A=
>> This change extends the "arp_ip_target" parameter format to allow for a =
list of=0A=
>> vlan tags to be included for each arp target. This new list of tags is o=
ptional=0A=
>> and may be omitted to preserve the current format and process of gatheri=
ng tags.=0A=
>> When provided the list of tags circumvents the process of gathering tags=
 by=0A=
>> using the supplied list. An empty list can be provided to simply skip th=
e the=0A=
>> process of gathering tags.=0A=
>>=0A=
>> The purposed new format for arp_ip_target is:=0A=
>> arp_ip_target=3Dipv4-address[vlan-tag\...],...=0A=
>>=0A=
>> Examples:=0A=
>> arp_ip_target=3D10.0.0.1,10.0.0.2 (Determine tags automatically for both=
 targets)=0A=
>> arp_ip_target=3D10.0.0.1[]        (Don't add any tags, don't gather tags=
)=0A=
>> arp_ip_target=3D10.0.0.1[100/200] (Don't gather tags, use supplied list =
of tags)=0A=
>> arp_ip_target=3D10.0.0.1,10.0.0.2[100] (add vlan 100 tag for 10.0.0.2.=
=0A=
>>                                       Gather tags for 10.0.0.1.)=0A=
>=0A=
>Thanks for the update. What about the IPv6 NS targets? Will you support it=
=0A=
>or only the arp targets?=0A=
=0A=
Thank you for the input.=0A=
=0A=
My initial plan is to support IPv4, but I will ensure that it won't adverse=
ly impact IPv6.=0A=
=0A=
>=0A=
>BTW, when add or update the parameter, please also update the bond documen=
ts=0A=
>and iproute2 cmd.=0A=
=0A=
Will do.=0A=
=0A=
>=0A=
>Thanks=0A=
>Hangbin=0A=
=0A=
David Wilder (wilder@us.ibm.com)=0A=
=0A=

