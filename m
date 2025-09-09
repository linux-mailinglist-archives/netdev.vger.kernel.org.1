Return-Path: <netdev+bounces-221360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B56CB504C2
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 19:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8D73BFB30
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0E635AACA;
	Tue,  9 Sep 2025 17:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dMVe8vlY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DC5258ECC
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757440545; cv=fail; b=XMlxScHrmwAyHHiZYLUMCM/uYX5b9vcD62ow7su9Or4XM36kJ24/lB2DevzHFNFm25NrMH8psd/4zlhggNVqggv1nR5ySFowhKCv/hqzFj8N7XnRsCni2/wnyYEy9/tQEdM+gQ9Rxaz971xc1jLltxO+Kv/i+etpBkMbL46ZJe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757440545; c=relaxed/simple;
	bh=FcRKlDEpNS9/0wnsXlPGrU2RfNgGf+JA251CY5A5RAU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=cYjNFvUfkY6W0D2WuU4VXp7MdtoYU5AZFIwnvNHb8YVQbyrJfOLdY8EP8bGG7zVL349pAxk0WyOVygoKx2NY9s9Nc2ocQqwnXvlN70zxf57QALuCJAAYikpL6BDh3LIGJbIZqVEobMUVWL11/m47r0yxgE03vZz/4G0PMLu64q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dMVe8vlY; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5898gWKs029522;
	Tue, 9 Sep 2025 17:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=T/09yW
	Wk6dE3B+eapsSOA1n2TeI9NFQyYXJjQXCOuoQ=; b=dMVe8vlYVwr4kwggXLLoTg
	DK60jmY/gUCIRIB4NjZ9r5/yqt69cx397aYO/x3GGcgB3BCwGtef8iD8t6bYMUfP
	Aloy4U8xeRy1C1c/iPNLcovz1lElKAoUE4dVNiOH+4JQIM7psCnxxbdZ6QB+rf2D
	yNGiYTIb4Nz5NCz+DACGkTd75BjeCVSmHeoHDGldlDJMe27pCNKrfCvrK/irHjfv
	NuImV2pd1GH5rT8GMpKEf/I5FOZ/Pwlp65vxE7IvsZ+LTvce1o1xafarP0u6F2Mn
	toTRk2uB/5mmI/G2ZIsQnE/DUI6XGMBOSJxuzQtIj8jKmSy4eYfnk7iIqX3xVuSg
	==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490ukeempb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 17:55:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDoaJuKDkGqAnWYxprbRSY9MiSqN2tqgaRi+Dzyi1BNM9jAHdwGQ42xqkJun8o0tpJY7GtG5JITPslqMHR40lOg43qzG/pov0U53/k7NUboEEC93gunrrM2TzgOe1yb2T8Y6+NK8CdeSCPnBWEXo37kAvtB3Ie+J8hb3htI5QWh1DkSAx5D22XX6h5BbNMZ51Btrq/plEfQAN0jA+IaOwgi+XgUQOLn34eDp/Cg8Mg55W+GtdSvLIFgidIxu5sTep2iCA5CV/PxJO3iLHrzAphxQXF9+nX204VqtXAwcsBuY26cE5fTBrCTOaGCXcyooFeYCatGzKJpyMHxeO8P1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/09yWWk6dE3B+eapsSOA1n2TeI9NFQyYXJjQXCOuoQ=;
 b=A18ZXe4P7clNFScdpUb+s8yYlyOuptJs5Gu432M/0gdDaq2R7XtC+qH9pbmUqjDRlfz0fn7tjpx551kBdM+87B3F74vdfCRYfXGdnM7i4foHRuj6freH5MrfiLtE10iQcC/xK+wKSUYQHofVld6EXYnnO0zowqVXaOIk4CfG3h4xIPMbxvqQBRXMwbSRx0z4RNbeBNfKfperrITvnCMV94k6uD53apGKDQEZ0NIALfNFJ4Q8GYpNWQJqqIexMgDmKKDhJDq5Wtf2qoR1BPnjQKX2IudoBDCdIyeNDkwYCn7tXZdZVsawBGc0vmItqg7q6o4t67kisiMCsxk327Dm2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3913.namprd15.prod.outlook.com (2603:10b6:303:42::22)
 by MW3PR15MB3963.namprd15.prod.outlook.com (2603:10b6:303:50::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 17:55:25 +0000
Received: from MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490]) by MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 17:55:25 +0000
From: David Wilder <wilder@us.ibm.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "jv@jvosburgh.net" <jv@jvosburgh.net>,
        "pradeeps@linux.vnet.ibm.com"
	<pradeeps@linux.vnet.ibm.com>,
        Pradeep Satyanarayana <pradeep@us.ibm.com>,
        "i.maximets@ovn.org" <i.maximets@ovn.org>,
        Adrian Moreno Zapata
	<amorenoz@redhat.com>,
        Hangbin Liu <haliu@redhat.com>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>,
        "horms@kernel.org"
	<horms@kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v10 0/7] bonding: Extend
 arp_ip_target format to allow for a list of vlan tags.
Thread-Index: AQHcHeoPH1Q144a86UCJxHHFQQrjFLSK5pmAgAA/xeU=
Date: Tue, 9 Sep 2025 17:55:25 +0000
Message-ID:
 <MW3PR15MB39136CC2656428F35D2CFD6BFA0FA@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250904221956.779098-1-wilder@us.ibm.com>
 <9a0ed3dd-d190-4d89-9756-9b36976665c8@blackwall.org>
In-Reply-To: <9a0ed3dd-d190-4d89-9756-9b36976665c8@blackwall.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3913:EE_|MW3PR15MB3963:EE_
x-ms-office365-filtering-correlation-id: 09fb0668-4355-42df-ed11-08ddefca0de8
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?6KSvkXw5ibf4L4SnpZxNvWX45Poel66E/OofJItMuF0uPMJjKgess0vW5S?=
 =?iso-8859-1?Q?k22eL2tQdlzvqbXPVR/jyBBwXCukFqoG6D+WSn3pYH4E9mLgFB9qQQafgO?=
 =?iso-8859-1?Q?c5jYJN4BU7Fwva4yVt7JcwmOcsAW3lwiaprPTYnueuN40WH0lbEjJaVxbw?=
 =?iso-8859-1?Q?PsxT0+q6xEOqRi+e5+N9H7IRP65dXb62MIJPTzS4PYHPCYw+McVOjvhDir?=
 =?iso-8859-1?Q?V1MF1+7sG1RFKhjQjO/zvNmkNc4fDBrwZ7aGc+RRHnxYI3qmwkn/ldgnys?=
 =?iso-8859-1?Q?XZzbCC+IDOOSsqxsVR5yI/E0XPc1lt3SL/qB8MrUeNX1vOuweRwW3har+B?=
 =?iso-8859-1?Q?b8iPsyk4RJNsCHHc/MAI2cC6vfojhOsZNGgGPN9N4enORcj5iC/aV5h1tw?=
 =?iso-8859-1?Q?ymRT8nQ3LTZLEVB1x91cB7WcqutvbSTUNMNAU2MgGPTziIG65Llbb8OTcY?=
 =?iso-8859-1?Q?uADRvrdMz2Qw9tbtYVDxRNCsxuSKmsQPHdOjWBe8h/VpeJ69adP/fqcl75?=
 =?iso-8859-1?Q?iBQ+4Khv7VvcxbVpLkNcBJVqjHoa4pXhPkQO7PyxckYmDG9AQETbWOOSW8?=
 =?iso-8859-1?Q?oB++lFePs/0NbN8SwK13Z3KL+LjYDuEocmpHOFFunYp29h3Q/jRR/GAsry?=
 =?iso-8859-1?Q?uwYgvDWhwwbdZHWq7Mtxx+V0egmr4Rk1HPp2Reg+7gAAjvxXGJrSy50ZxH?=
 =?iso-8859-1?Q?XBwJnlQ24FDVX5sYfdIaRIywqWqUJpE4QxUfvTYOTRAnwYEa7Au0ZyREmh?=
 =?iso-8859-1?Q?OCijPm2ZB4UxpJtyP5QYQJeYo3lyYluiF8StToadKUdY5Z//c4gL6vsHgR?=
 =?iso-8859-1?Q?Q5SyO8x/lI/Rgx5IvvXDgwl9GJC1zptfqz3SfbwhGKPMbmQYNzUipsaMkJ?=
 =?iso-8859-1?Q?p4Ux+AAD8QAry6QjyHE0rg91RWyeE4fToSOpM4j6aZpzt5eVzFhhtFMbt7?=
 =?iso-8859-1?Q?EwVN/W+n6y4aYTNY8ivzAE2HLAF+ib/siQyRWOxa4slXoVDujFac87QZxs?=
 =?iso-8859-1?Q?XllJWab9rGIHaclOt/REm/P2Xvsx9jyts8dFqp6d1fJNAtAtzhVl37MPQv?=
 =?iso-8859-1?Q?wmUOkHKlvBr4N4G5csnou4QTqD0TY8Ap0KF+ThPIZ5X22zuZL8iMKV1i3G?=
 =?iso-8859-1?Q?reWh6RpA/cJ2e1t9ZrdWHd09dpqnczOBVrsDx0uxvEN2sLgNEHwKy2Av3S?=
 =?iso-8859-1?Q?qyNC1LVoft7DQb/JqAfpWoBrYMI32rUHOOexJGwGsh1PHsJ0+79f920avn?=
 =?iso-8859-1?Q?qemq2r3c0SW8Jy4218iWHq1a7zRJHaCV6iFYqApwq6rwO/Z+QDXYAg5Onl?=
 =?iso-8859-1?Q?hHMnhciWZiVS/U0jeDGBK1ZI2OTNZQ35Mb2aq4kPBBm+q+bW66TGJ7kMS1?=
 =?iso-8859-1?Q?dyQ0eFd4p9ZA2jz++dhhGXFf+Fqx5gfwc4a5RHgeckQqex07/ZIFhamTbV?=
 =?iso-8859-1?Q?O895f9ZJNrmAUBqrFHRT92jpgMD1CtDXQmh8UCOZqZDfkqj66UVG6KVmhf?=
 =?iso-8859-1?Q?LO4Tmspbkgt1btSgjrVS9Gl8yPy9+cKlmzIu3jWnJt+hJdlW1J12M7kSMY?=
 =?iso-8859-1?Q?j3GcL98=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3913.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?HrZrQrG7/aJYyhPVnjqMrvDiTGTj6nBO+BBJKS01DTZmaCt6QZ8OKU75Fq?=
 =?iso-8859-1?Q?sIuhocwfphJ6ZdwAJ8j3Qb5y5VBW4WokHtytXKZ+drWIdBUrzT9YHbzG4V?=
 =?iso-8859-1?Q?iLOw/bnrfN/Mh8nVrVfU8yMwju7GwrooLvbvlONzVOgTPvLc9/5bdlEvEP?=
 =?iso-8859-1?Q?Wsb4kFALdeINxyqWmmF1EMfqbao5nzn3OglU0Rjs9OeDvqx+haJ5QDgiWC?=
 =?iso-8859-1?Q?unkhJpTq7/Od7SIbDcRHoHGzOzbSe2ydbM0NNdWtaflNwhno1fgBE6I22b?=
 =?iso-8859-1?Q?1PgmIbat9otp5gWYVq1FvAdshBb8WNzgCSqrpZ45v+Dbf7aFrVV1NJKQN6?=
 =?iso-8859-1?Q?dpkSp7zexB1Z+YrAAW4BoMOr4rzvnMwPgtDxYk5SMlTzogt3HjhGs7lZE9?=
 =?iso-8859-1?Q?6NlkBeC5VNsEXG0r8NPTe932Af4T2HuFesvCO5h6YkQauIil5wY+vVzX6c?=
 =?iso-8859-1?Q?/Tqq8KuOT6ZkEsSs9LITA7tzJEYBFSW1SjfwcADa01JPURg3DxxE8UJuPf?=
 =?iso-8859-1?Q?PEEmwMFRrbmcjcEZsSohilqg/6mW4aEiz4khcwAvj75AGDfkHto/gl62Yz?=
 =?iso-8859-1?Q?EVkr7sgS+Vstjwk/e+/f7jWOMPSXL5c41yr8KpMX3EZvwSfVsxi3Xcb7pX?=
 =?iso-8859-1?Q?UJnLN0wgI/7hOAjCqQalfpurBcBO8gzYL+rQUra3MGHAxEdUtImCIr/bhf?=
 =?iso-8859-1?Q?vnthUX78hstaAMYgjaDHU27q3u+Fh1XrzEcLLILyKO6uWxGXGwf1tWIPVx?=
 =?iso-8859-1?Q?ObhAPj7fY9oPL3z5gQpgbEURH+TR32xJGFjA+6uHsd1GBy8PiqfWRQ3uTQ?=
 =?iso-8859-1?Q?0L9ZZeiK8xU1WXle7F8rgpQu6kYKodatubaMU+aUzbrQ+AeHghlC8sP0zn?=
 =?iso-8859-1?Q?AX9OU3KJi1kYMlWr3iI+xW9emB2wXN0JaUQDCVkeDrrAyvJme3iIJG/i/y?=
 =?iso-8859-1?Q?EPWmIXYXvqZjVjYTh5uewyBhsP33yPHZKO+Kwv+4hiiIylANv5uHQ6YjgI?=
 =?iso-8859-1?Q?mlb3Sd+GEQauvKQElG8lI8XS48jZlcAWmM7Bkmtmcc3I8A37h0m4hCsYdp?=
 =?iso-8859-1?Q?Zt28rBUWK8h3REvOKn6AK+fYXdlInSsr2XtRAeAXr8Qnf464GajkkpJ5ol?=
 =?iso-8859-1?Q?RcVFDGWStOpJKhnAYh2qedO7B/cudzmAf8EEhhQsneVBrVDcJchJp6yUKr?=
 =?iso-8859-1?Q?zgJ5BA+NeY6goiaqHnJ0wYunx48ecKWrIkYMVH9Lj5HWC0DbpLwZaO5Bp6?=
 =?iso-8859-1?Q?9IFlpujnlNoRMt0lhAaNko49y+Oped6dkpmFbTnrVUgJfkyHPQnDUIhTVB?=
 =?iso-8859-1?Q?DGcHQCXLbb3s2bRfAfhW/U8FsqFH0T8E398bXfanRFsjvuFU2/KQPAxDZe?=
 =?iso-8859-1?Q?I8HbGMwmsT0E4d40PkobsvZi9MdEscB2u9ee7DeY97FypelJihccR8DggG?=
 =?iso-8859-1?Q?wV2OdJT8Od/HQWCL6aqKAwzoMfOJ9g9LFArRuJw85Ye1udolq+BC3+R1at?=
 =?iso-8859-1?Q?+KtW46RMhIOVFJcggUKZtjVD1aR4nm3v5P5TQP6cmrf1RMiQZIe5VRI+zO?=
 =?iso-8859-1?Q?BdVrlV42yJ5kfcFAJ9hm0kVm/zQ/xyfv3pB+TPOXwxlRW246wSd5G7NMxp?=
 =?iso-8859-1?Q?QFKL4EV25j5qsQM+kFVndNYHyogINP07irMHcLwDOS7yUwrPImKIKq7eAu?=
 =?iso-8859-1?Q?cM5iglpRm6qXqh8oqrg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 09fb0668-4355-42df-ed11-08ddefca0de8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 17:55:25.2060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xoD9kZCaLvPqHAoJlGAOZGK2E2hc321Au0RYL6oX17eOPuyzOI/+htmqTP5ZnsiTzhWeofPWJtGHcwfQYjJuPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3963
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDE5NSBTYWx0ZWRfXxg5ZvW6IH5Vg
 i35M9q5J5os9eftPGBqfhCp61yV0PUl+ehYM2BDRzSOSj0ZDeSEip4jXJ4QAnaheKJPoLjfWRrT
 2ub+G895rnTc3KgRfV+N6HeZlzdOt8zA9OdCUozgpzB2ggYOni9Zm3R1tyGsj9Ogor69dz5Y//n
 rJzRbAh2lueJtgSUqznhkAHE2Pxa8chDPWTW0eJkZwe7FfiGTu7S7vHGrsIK4epfkcSrie0rtGc
 2IxL4nCTh7FwFVAXQa+Pmf9/lo8SvbMqmN4pruvttRp5I0pO1sUpxE0yek8Quz/GBOr4DHr6OQa
 lDCXwxF5YOdCppcBdoKuCXF/Udkt5Vp6Xq0HoPbMOc92MSuAaIt22SSy2Rhkc1rf03U6w2+Zrrs
 +kGyEPf5
X-Proofpoint-ORIG-GUID: StZo990KIrBvJPGgCRawiCrcZMF_8wSd
X-Proofpoint-GUID: StZo990KIrBvJPGgCRawiCrcZMF_8wSd
X-Authority-Analysis: v=2.4 cv=StCQ6OO0 c=1 sm=1 tr=0 ts=68c06a11 cx=c_pps
 a=JdlQBdRp28aqpLEMyktm7A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=wTSae9ZTrx7r8reO:21 a=xqWC_Br6kY4A:10
 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=vr0dFHqqAAAA:8 a=VwQbUJbxAAAA:8
 a=2OjVGFKQAAAA:8 a=VnNF1IyMAAAA:8 a=P8mRVJMrAAAA:8 a=jZVsG21pAAAA:8
 a=fL1SwWbhcFL3hplKBRwA:9 a=wPNLvfGTeEIA:10 a=P4ufCv4SAa-DfooDzxyN:22
 a=IYbNqeBGBecwsX3Swn6O:22 a=Vc1QvrjMcIoGonisw6Ob:22 a=3Sh2lD0sZASs_lUdrUhf:22
Subject: RE: [PATCH net-next v10 0/7] bonding: Extend arp_ip_target format to
 allow for a list of vlan tags.
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1011 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060195

=0A=
=0A=
=0A=
________________________________________=0A=
From: Nikolay Aleksandrov <razor@blackwall.org>=0A=
Sent: Tuesday, September 9, 2025 6:54 AM=0A=
To: David Wilder; netdev@vger.kernel.org=0A=
Cc: jv@jvosburgh.net; pradeeps@linux.vnet.ibm.com; Pradeep Satyanarayana; i=
.maximets@ovn.org; Adrian Moreno Zapata; Hangbin Liu; stephen@networkplumbe=
r.org; horms@kernel.org=0A=
Subject: [EXTERNAL] Re: [PATCH net-next v10 0/7] bonding: Extend arp_ip_tar=
get format to allow for a list of vlan tags.=0A=
=0A=
> On 9/5/25 01:18, David Wilder wrote:=0A=
> > Changes since V4:=0A=
> > 1)Dropped changes to proc and sysfs APIs to bonding.  These APIs=0A=
> > do not need to be updated to support new functionality.  Netlink=0A=
> > and iproute2 have been updated to do the right thing, but the=0A=
> > other APIs are more or less frozen in the past.=0A=
> >=0A=
>=0A=
> I'm sorry I'm late (v10) to the party, but I keep wondering:=0A=
> Why keep extending sysfs support? It is supposed to be deprecated and mos=
t=0A=
> of this set adds changes around bond sysfs option handling to parse a new=
 format.=0A=
>=0A=
> IMHO this new extension should be available through netlink only, that is=
 much=0A=
> simpler, less error-prone and doesn't require string parsing. At worst sy=
sfs=0A=
> should only show the values properly.=0A=
>=0A=
> Cheers,=0A=
> Nik=0A=
=0A=
Hi Nic=0A=
Thanks for the reviewing my patches..=0A=
I did originally extend the sysfs to support the extension, but dropped tha=
t support.=0A=
The only remaining change related to sysfs  keeps the original support work=
ing with out =0A=
the new extension.=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=

