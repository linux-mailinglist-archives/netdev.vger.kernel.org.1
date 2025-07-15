Return-Path: <netdev+bounces-207245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6542BB065ED
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 20:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9836D1AA67C0
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 18:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D182877C9;
	Tue, 15 Jul 2025 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PPM2v5A7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99288633F
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752603771; cv=fail; b=IeU7gdmaVWASfv+FKfSbVchnconMU9BOi0Fd33bhYfGpMq8ZneEzCErY/nLRzaL2KyfTnHa/geMqPYH1RfhgBTHeW9OflODNCjtLLnnFit56aR12f6rkmLtqVLlbEkZs7MJmY4pkpoXg0OX8GDap3NwQ58w+R4NpniTA3aphW/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752603771; c=relaxed/simple;
	bh=mWEGCr542wvlxP8w9CcFQ/KB3RgPIKF8WAvOwR+n3jM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=PE/UmYaEjNTi0Oi8cEpTBP+11vgIWOoFV5wcjG9kYn8M1IWMijkNS6XAqHKMm6mOZD2qQPZBZb3TgQn5XRULEnG7liy9dhAOBdEzrbwvWRNtdedD296Jb43amwt0mh1bHsR/W4wQ3PSZ78AKFcHPGagK+/8LsZC7kvxS9xy699c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PPM2v5A7; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGOkns028477;
	Tue, 15 Jul 2025 18:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hvEPTS
	NwrZWT4iZzf4PUv9xsrvUInOQOSVwGq2554a8=; b=PPM2v5A7wyz9JlCfON3vaa
	HgK1kDmbBuBjnkh3/RuLcM79mOKvblOb6WRxvysrP++OzLn9++yfHwU6X4S3134N
	OO+mJevLTq2pyXbH/+fDbmG8oN6KMok4rIRJVXp1Ye5d9N/77KqGDx/0ZC7mk5jB
	yd9lqH5DgXeDe/PyFlHm7pboo0MsfaGs4IHwPN5WD06+27RouU1zY9F7g/DZtCFu
	pWLfecwjXkM/QwhIJVc8v+7yRP+yBJdh2uA3Yaw2IsSFwMLr4tTDt2OeSN+JCuvK
	5q6plI3r4r0qdDzlgE1Gbc5KGfaTKx4BTbDR8ry6gZXMDAG3dDCwYhubVtY2196g
	==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4u0tg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 18:22:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v19etDzkSl3t/q3dENutGGXf4Nf1pqVxX+d5LgxoLmWNl4tDR6LfW+GjNMlrAnskbiJF5cOZ9qtvy+FrPKLe/udinZjLZJX8gaQV/UTaNiRdeVIhiSkdwF/VMfPKXQLawZ6DWQxsMZB6W4QBpHL7vno0vIyNERDnZqmD9Gx9RW3bhWZ5SrWC07S7UXrxRMa3hRNAxHvQM9eQYg6qLAd9xWt6Np9lddQrTviiUgtRQePKZ9o2eK/ObWu5yPs6Ni2jOg0hnQWZMiEqerwMiVF+aLJaj3Q7LRGlQrxg3p/L3dZ27UQkxl8AlE08VsHD3zmjQdJnj/LIflUYQaEf3ui7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvEPTSNwrZWT4iZzf4PUv9xsrvUInOQOSVwGq2554a8=;
 b=IOpod8BWDJ58J5kfmXhvL2oxWrfAzNZ3fMSxDqqcGe1sGO42miZJvdEeHoiSI5Wq+Cg5iysk+4uL9CRtgUZivL+XMwu31tj/RTuwbVURVQVQxeYW/2N65NyTaGM5SVSDkEeJdPOZNK705PhKZxdo9GtNn2UN/my3+/2PUpt2FxGZ/HIx6RD9dl90ZH/cynB2ckeIwwhDo3QxmIvQzsJj+shaTkHJTP1N44XvVaLIB+S+KJl2AxNS7XM4hyj5dQEvXgJ/QKwjiWzpDQIFFqMuQipXIz+6ZBWSfc/0cDKhpKSz7gjEuXW/hmOPKcsNyFwsO5ICcEifa6dY9ahJDroFtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3913.namprd15.prod.outlook.com (2603:10b6:303:42::22)
 by PH3PPFA203A42EC.namprd15.prod.outlook.com (2603:10b6:518:1::4ba) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Tue, 15 Jul
 2025 18:22:37 +0000
Received: from MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490]) by MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 18:22:37 +0000
From: David Wilder <wilder@us.ibm.com>
To: Simon Horman <horms@kernel.org>
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
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v5 6/7] bonding: Update for
 extended arp_ip_target format.
Thread-Index: AQHb9RJyofRiQjV/BUi5i6l1gkgKVLQzNueAgABHgxs=
Date: Tue, 15 Jul 2025 18:22:37 +0000
Message-ID:
 <MW3PR15MB391324648F78241D4AC721A6FA57A@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250714225533.1490032-1-wilder@us.ibm.com>
 <20250714225533.1490032-7-wilder@us.ibm.com>
 <20250715135821.GY721198@horms.kernel.org>
In-Reply-To: <20250715135821.GY721198@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3913:EE_|PH3PPFA203A42EC:EE_
x-ms-office365-filtering-correlation-id: 7e60ca16-d6c0-4b2b-4131-08ddc3cc93bc
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?/S9iuEKk8uYAc2y42VjT5gnQ3iCKVM5j3dBE3xo3/4fYAoPiN7w+b/fEvr?=
 =?iso-8859-1?Q?hkjbfVtVBDbtP4kAf4vzpfscaxbO5p6KYnpnU/5IlweoJxw52A+1t6iwGg?=
 =?iso-8859-1?Q?9MRqvr9XuSBNyYeDdE1zmq33ocelQ/e5IJnN87ZZQ/18J84o5ReDgbJnUZ?=
 =?iso-8859-1?Q?SR9rTG8r1ODLKUrc5V3pfB/qKO6kVSmohUS7J7mwIWHcsB7MeA3TOigmip?=
 =?iso-8859-1?Q?VGFNpuKKYI0J3qTu0NHCa5B+ErgBdBq/nSb3/64mBgjrfpw9f0JYnolS0T?=
 =?iso-8859-1?Q?PjF1DGY/GW2q/DfLFNyBc/MZ1iiGsUmq4jy1QCNVfYoob0v9S5WjCa1Ejy?=
 =?iso-8859-1?Q?hnFu4xzbx6b7JGI3gP/+xss61XLEhg/Wav1lZnG8kQ4VmSNF/TZNxDhji7?=
 =?iso-8859-1?Q?ocU/ezUBSsE/nFQi+tef66C0Xmirwf11Zug3olBKdpR9BufYnYs8gxCZjp?=
 =?iso-8859-1?Q?hzh6xmCXXxijsSe86tC6vGi48KCL2G5YgPuyHH1/L+330E5DcoCGA0d/3x?=
 =?iso-8859-1?Q?P5ak2BsVQ+uimdgvtbEOkGdhKl6mEFebObGMSLawiSHzxdrHssCt3qEnZH?=
 =?iso-8859-1?Q?JIKq0IPkJjtNAtDYvXx1dqnVjsn8Dx7ZMTDWso3KCHtoHYg8HLuC0O/8i/?=
 =?iso-8859-1?Q?4cqUjJ46Jpek3Nh0u2AkYAWAUXeRz6y2SlURoO55kIOgfqWdtoK6Taber5?=
 =?iso-8859-1?Q?+ZR/jeLi6HG2V8bJLBkF6HjWH+ZTHya8YHeIW4Q8PU0qk6OCRLWXhPc3a1?=
 =?iso-8859-1?Q?Ost5vqoSH36rynqrgTbf4WSrbiBpXJ6xfPJxP8YpcbrFdNfFXlrZpRBgOT?=
 =?iso-8859-1?Q?7tGHdxw711Q1W76IC8/p1pRyCt5g02ymwed9oU6poznuz7BUGCUXqSw1qc?=
 =?iso-8859-1?Q?ARIIuvn5EOcpyh4OT86KcqZWuYNMAoqLQZUC5aFi1ol0s4vRQCxWR0lcMc?=
 =?iso-8859-1?Q?kboeFnOaonfj3mQr+F/k4GoOQGIYS1sqczJeg/ND2/S5HD1EtSReIGTxtN?=
 =?iso-8859-1?Q?e2QzrMTSnkPWhJM/NWlCkjDNS+/cZuAs1vrhppX20PMGSdfanoAmydoN6y?=
 =?iso-8859-1?Q?NiZtvSuS/kfAqBdlsvXJ+qH2e8ZNF1DRzg6FoohpbnvNMRdMyDH5RZNjQx?=
 =?iso-8859-1?Q?NVO6mveSmwuZHj7kAYeUugcvd+v8GYditOxURN4005dJM3AlfQMhbZnXJA?=
 =?iso-8859-1?Q?rQSTers7/taOMYsU0goiilz2rkqb3S3ujk0lTanW0gfEHq6UFBCDQQa9zV?=
 =?iso-8859-1?Q?qlxOhzc87icLcFCl3Arh1bo20QPdvfdj7p+NDviMzGaaoyPA1K+eDxDt8S?=
 =?iso-8859-1?Q?C9q5RmymnLgyYDkPyT3+rXPdHfbfpgpx4tjAZZlTy8kSei3ei+iZChbUT8?=
 =?iso-8859-1?Q?mbUGC41cRAC4xgqTI1yRxzfsIowTUVVpFJ0U1hrYifyuVL+aqGs01jqsoK?=
 =?iso-8859-1?Q?MnicEwhyBgKvPNryj3bPmawv4NSV/hxSFGHXgue83Mtj703o2KcXx5TgPS?=
 =?iso-8859-1?Q?D7PMo3pp/+cCtRwZWRuTWxuX2eFAglM0o+luq2ToTgpQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3913.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?MOU0TU27QeKbS8t+7qmIdoUa/XjzhIGmi0/onQ8GN0fwHrxyUA5Yh2WC6t?=
 =?iso-8859-1?Q?dDjgackguo+xijwp1d9BpEAahVdLowxHY7NVhi9S4VRG/RKB+4+jrOp4bO?=
 =?iso-8859-1?Q?QdNJbwPZ/+bwIhr12YVcYckVuL5cUp/EwV4LDNyYCjWrpWTUhk+zPO5wPn?=
 =?iso-8859-1?Q?ClHX28+zVy+NRWvzffIrwTNAvQZN9EW3gcV4ZjtcuCnjQBw2iktHMf0gdp?=
 =?iso-8859-1?Q?Wf4gqtRqkRYdW7GBdCBwfWmgn1KtD8lD5r3HFRscFZXqPkMggRslB52w23?=
 =?iso-8859-1?Q?Z8iinelHVCa3lqvy4/cpMaJUeYz7/TXm/3bUPSYDStaoX7DEHXaRKzIs+U?=
 =?iso-8859-1?Q?MoQSWh+GdgPBMEz3wHrBV+IYLvkBwydvmzAJGZkks3+HypGGaL7XlTrl5w?=
 =?iso-8859-1?Q?R8uYRKIjjRUy9uWuIg9si49IcBAXcL6c/YklzedhcyqMmTyazqLO8sK8MX?=
 =?iso-8859-1?Q?qz4tgCt/aayDpANH+4O7BqXUcbaAN+wUT0AoMI8oHict04b0Stsij/gf0h?=
 =?iso-8859-1?Q?WTvBwxCITO25voB24OIk9wwSfB2Dtpw7U+SPrMDpAZbP/HaPvJcTMgoNoB?=
 =?iso-8859-1?Q?9mT0JQGGl/6g4Z3JYzogwpZKiDsGyWMsna5AhyhghcdUCUpGPOXahAEI4C?=
 =?iso-8859-1?Q?OYYbWldxTiVtHWkKOuWr9O9jGE+4Ib6KWHKlw2pu9/b0vOdoX5ujhaI0jz?=
 =?iso-8859-1?Q?XHBDwVm2dMWAJSOdUHldl8ycosqWswRALeuZ+NtTwNnO8urLNjp+8QEorc?=
 =?iso-8859-1?Q?cCY9sj1tNgz2B0F2ON49LmbHaaJS4uj8eD6qOK7ebR58sEhBJxb8oqbbH/?=
 =?iso-8859-1?Q?ggkAkwJUYSHIcdKghQ3GPU2V9syqtkvuJJojV7Oy9KLldw/H4hZ7o9C8+Y?=
 =?iso-8859-1?Q?tMCylx7qRknqB9/OPw+iCz6K7C+QVOFMgKjmLABI23RKICp49IaRfTHeOh?=
 =?iso-8859-1?Q?BK6T4FTjc9Swhie5K2zjU89bxhXqCpSTuqaMKRkmrKA1ioN5FkTbSpHsc9?=
 =?iso-8859-1?Q?YLrBNzxkWKviZKRCKf2Zstw5cyD2+NHLteQ/LwQ26Zw21x92fGlE+DVsGG?=
 =?iso-8859-1?Q?Zy1T7fE50SmeYRp63e3UDrFi8BKNn2wVJUtwmDTdOUc2pxFnj4b7hH1/Dc?=
 =?iso-8859-1?Q?NfXxI+hecJVswnVyQ6us5EeQfH3+7O8PmlfrE/dyX0DK3VjqsLJfE2liMh?=
 =?iso-8859-1?Q?d6T/mj2ADdkgag0bkHc8GhKMWpS2s6TXvzwzp+Pczl4r0jVIpzb8+ssnf+?=
 =?iso-8859-1?Q?tEENjzW3gGxBxKy+AyaRpJQFuM6wNoVXYcl8fcOaeWoRoJmDcPTX2q1DvY?=
 =?iso-8859-1?Q?K8Q1xrYi0GSgTEOPkzR3+FsrT0DpSmJjvIXJrDW+wDTDeoUGPo4ej4hPeu?=
 =?iso-8859-1?Q?tRH1+pgcTKymyHNndZOIXSHrBLvlef1SytO6zZYJHMv46UyCoXhmXjPTxL?=
 =?iso-8859-1?Q?fMqiPLs+ccQCx3KeOSVz2lmjZYY4/89W51J3/eqZfU6Vdp5zZkW5j9GCQd?=
 =?iso-8859-1?Q?GTjYzYkHSNhcT1cEJcpT3Yl2HcCscpS4SQlZ0dUNCl684JklQ8gNf8gLLH?=
 =?iso-8859-1?Q?wbr8qytZabfNR84UbM7+KYIR7P57t7i2csyWRm1pypZdqbC7BaI8hIrs65?=
 =?iso-8859-1?Q?8nB6G6vcSKZxs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e60ca16-d6c0-4b2b-4131-08ddc3cc93bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 18:22:37.5220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X/w5hGE4OBLXYYKThGVnRQYGyGRJXcDx6vvmmnZuhUKA+KbaSzwx7KEbaaKsFDFNuHVqs+uf21kima5f6j7a/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFA203A42EC
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=68769c71 cx=c_pps a=5RZAJXZTQAV0bSSsSFVBEw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=2OjVGFKQAAAA:8 a=VnNF1IyMAAAA:8 a=P8mRVJMrAAAA:8 a=L4WjUxmF0HaUZfMsbG8A:9 a=wPNLvfGTeEIA:10 a=IYbNqeBGBecwsX3Swn6O:22 a=Vc1QvrjMcIoGonisw6Ob:22
X-Proofpoint-GUID: qyP_JFJs62_njSb4y3pYU_NNHd18aLEq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE2MyBTYWx0ZWRfXzQUO1wlfa72c KM7BviZYVsenqlFKExjnXvNgwYeYD/q3hEfhu3/anj9F0zBmLhMad89KkSWg45kOO+B+wVygJiP eqcQ0LHQ0KSnlisVY+DzMbGeYqQgAga9OgDHYZx6ltY719dG+j33ZPHkuzHY7JssIzD8gM/i5GQ
 5PylsPSSYIbL7spQKTd5MdZV2UwSGD1WTcqX1X5gM6ILTKKeIrFL1AoPlclZdnoXn6VFgiWRQgM M7C497Aux/p1J1KbQFGTM0NiRdQqwc8r/DHcX4WY3cZe0h8+As7CugcKcdF6UwYf2yFi9SYSfSH T+Y500JMinc7KOGRwJVowrCFFJ0UbcdwmBbBd8szECA6UHifnU02JUee18MCd4KHY2ckn3MeuzH
 vYB90YC0K9p4w3aafDO/SYBnNQOQO4NQml3fBF+siPGa5zD8R6ZpPsYlcS32f8DAWDoLu0bU
X-Proofpoint-ORIG-GUID: qyP_JFJs62_njSb4y3pYU_NNHd18aLEq
Subject: RE: [PATCH net-next v5 6/7] bonding: Update for extended arp_ip_target
 format.
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150163

=0A=
=0A=
=0A=
________________________________________=0A=
From: Simon Horman <horms@kernel.org>=0A=
Sent: Tuesday, July 15, 2025 6:58 AM=0A=
To: David Wilder=0A=
Cc: netdev@vger.kernel.org; jv@jvosburgh.net; pradeeps@linux.vnet.ibm.com; =
Pradeep Satyanarayana; i.maximets@ovn.org; Adrian Moreno Zapata; Hangbin Li=
u=0A=
Subject: [EXTERNAL] Re: [PATCH net-next v5 6/7] bonding: Update for extende=
d arp_ip_target format.=0A=
=0A=
>On Mon, Jul 14, 2025 at 03:54:51PM -0700, David Wilder wrote:=0A=
>> Updated bond_fill_info() to support extended arp_ip_target format.=0A=
>>=0A=
>> Forward and backward compatibility between the kernel and iprout2 is=0A=
>> preserved.=0A=
>>=0A=
>> Signed-off-by: David Wilder <wilder@us.ibm.com>=0A=
>> ---=0A=
>>  drivers/net/bonding/bond_netlink.c | 28 ++++++++++++++++++++++++++--=0A=
>>  include/net/bonding.h              |  1 +=0A=
>>  2 files changed, 27 insertions(+), 2 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bo=
nd_netlink.c=0A=
>> index 5486ef40907e..6e8aebe5629f 100644=0A=
>> --- a/drivers/net/bonding/bond_netlink.c=0A=
>> +++ b/drivers/net/bonding/bond_netlink.c=0A=
>> @@ -701,8 +701,32 @@ static int bond_fill_info(struct sk_buff *skb,=0A=
>>=0A=
>>       targets_added =3D 0;=0A=
>>       for (i =3D 0; i < BOND_MAX_ARP_TARGETS; i++) {=0A=
>> -             if (bond->params.arp_targets[i].target_ip) {=0A=
>> -                     if (nla_put_be32(skb, i, bond->params.arp_targets[=
i].target_ip))=0A=
>> +             struct bond_arp_target *target =3D &bond->params.arp_targe=
ts[i];=0A=
>> +             struct Data {=0A=
>> +                     __u32 addr;=0A=
>> +                     struct bond_vlan_tag vlans[BOND_MAX_VLAN_TAGS + 1]=
;=0A=
>> +             } data;=0A=
>> +             int size =3D 0;=0A=
>> +=0A=
>> +             if (target->target_ip) {=0A=
>> +                     data.addr =3D target->target_ip;=0A=
>=0A=
>Hi David,=0A=
>=0A=
>There appears to be an endian mismatch here. Sparse says:=0A=
>=0A=
  >.../bond_netlink.c:712:35: warning: incorrect type in assignment (differ=
ent base types)=0A=
  >.../bond_netlink.c:712:35:    expected unsigned int [usertype] addr=0A=
  >.../bond_netlink.c:712:35:    got restricted __be32 [usertype] target_ip=
=0A=
>=0A=
>> +                     size =3D sizeof(target->target_ip);=0A=
>> +             }=0A=
>=0A=
>It seems that data.addr may be used uninitialised below=0A=
>if the if condition above is not met.=0A=
=0A=
>Flagged by Smatch.=0A=
=0A=
Hi Simon=0A=
=0A=
Thanks for catching this,  I will make the following change in the next ver=
sion.=0A=
=0A=
@@ -703,15 +703,14 @@ static int bond_fill_info(struct sk_buff *skb,=0A=
        for (i =3D 0; i < BOND_MAX_ARP_TARGETS; i++) {=0A=
                struct bond_arp_target *target =3D &bond->params.arp_target=
s[i];=0A=
                struct Data {=0A=
-                       __u32 addr;=0A=
+                       __be32 addr;=0A=
                        struct bond_vlan_tag vlans[BOND_MAX_VLAN_TAGS + 1];=
=0A=
                } data;=0A=
                int size =3D 0;=0A=
=0A=
-               if (target->target_ip) {=0A=
-                       data.addr =3D target->target_ip;=0A=
-                       size =3D sizeof(target->target_ip);=0A=
-               }=0A=
+               BUG_ON(!target->target_ip);=0A=
+               data.addr =3D target->target_ip;=0A=
+               size =3D sizeof(target->target_ip);=0A=
=0A=
                for (int level =3D 0; target->flags & BOND_TARGET_USERTAGS =
&& target->tags; level++) {=0A=
                        if (level > BOND_MAX_VLAN_TAGS)=0A=
=0A=
David Wilder=

