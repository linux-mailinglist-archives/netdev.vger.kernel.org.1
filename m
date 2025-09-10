Return-Path: <netdev+bounces-221789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A91B51DBF
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391073B3DD9
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 16:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDC61459F6;
	Wed, 10 Sep 2025 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CSgssAHt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E467286A9
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521820; cv=fail; b=CrVjN1bqmJhvG38KL2vwNonBB2a5PLGlO7IGbLWH49Ir/Kkb9Pil5NcglV0PnUZjv0ufG7zDSir+itOZ5GRdLWdubVOtdb/yMG1oa/C+1NXtLyhTErRqk0/7FA6qjnt81L3auc+gILbQhqNeFrQXYebKVa4sWP049W3dLJuemkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521820; c=relaxed/simple;
	bh=+VIfSy75sxOKqyNEI1SjGOpOHrGONLcmfS8HzJ8xM0Y=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=DsWIloow1MsfR1w5mBF5Idn6SOoVi1drFJIfdzaw5d/oyD/nbUGo+2YY9y3lScIqQRlp7MTlAVbbSRBQ8cNJTfjAX8HPxXEISg8y8jTIbuAO56j5m5xK7Vo9lBL+obVzaGGYD8MRFFu3wxUaZrD3aYBSlVVOvgNRYQ4X/A/ykak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CSgssAHt; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A8lRQP025033;
	Wed, 10 Sep 2025 16:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LIL+KJ
	73G3zcTevWdIEYlbYO3fafy7btyqPmKYOOsjg=; b=CSgssAHtgddoTOs7c9HWdH
	3ZHf0/P/zVZ/q32BnmA8BWbHE6AnBTN+4d0yij6GSYK5bde/qLGL+RDeu4I1zZ1L
	fvcPpbrMDHxU4h7QAUYIFm1IRQQWXwXcyhHUteDzkdC2z3lklzJXZRZjj08Kgr1+
	3fMfe0JF4xVtCY9VTu4UjDnp0mzmxaAy1kztzUOM8ObgtxInZZh/PVHWTiNOxGNj
	KxwW4NrN5cvnEq8HwBfXtyYKOuoTXinWilrIJthBanP7z4qNIxEig5vZgbOqIfGt
	wHpOtcrZIVWtWnPqyU3xUMIQ1utUndtscS8KZtRoMp9t9a3hBeWhIiKeGr4paOPA
	==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xyd4bfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 16:30:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhkFsayllIpgRnXJYg+pUxYdBCpEIVYAXS9jR83yBGFCuUB5Mh5v+swub/B9DxTRD3vmaNfc1eXOdRaxAR2txeQfvuCYBepVpNGAdO2K7lMIJlzjMg90PnuULZZhuTQ8RJPqXDFOk2LSq79bkNrEDq0NkVUbT/IV3iYINkEPpBTq+ORPIHhzN03bWdmuptcjSzBEDFOgG3+pCuVIvjqujsc9743B2Kwt9VMXlWHQJ7Vf2v2FEV2rr3T8RlZfO3cxycjwyp5cwJl2SmZO6ISahdklDYFPbx1ZyiTJ6SUa/4KM2UTgUSd/12imd0Bp63VbrExO2KZnIkdQUxGPTBDOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIL+KJ73G3zcTevWdIEYlbYO3fafy7btyqPmKYOOsjg=;
 b=C97C5olUsYpYB/6nYJXpqhIYJcMIQBARkEnfRyyoQ8l4YvVyzshyI1EWfrm1urzZTCSoepullUfskI7eV1unCE0vs0luhQ/f5Ikiu8lIQF8/agvlXHzZhLt/OpKBb3W7SKscECnl6IznSxp8tTXhBnXgEc4GhV/u39qxGj7oCCEtpf0kePiAlJ6GUrY8Ej9kt8sXuJeUaL4kkOezdnW+T6HM2gTl0bpqKKPN4O0I4Bz9QIMKBLGedVmsWOKdne/6at2muvYFC6aZHZhG653XxKnGveLN3CF694RKUq9usl8+npJxJcOitaSPXso7tzvNCw4/+BUETNrmXkrL4lxsiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3913.namprd15.prod.outlook.com (2603:10b6:303:42::22)
 by DS4PPF1BDD6D585.namprd15.prod.outlook.com (2603:10b6:f:fc00::987) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 16:30:07 +0000
Received: from MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490]) by MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490%7]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 16:30:07 +0000
From: David Wilder <wilder@us.ibm.com>
To: Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "jv@jvosburgh.net" <jv@jvosburgh.net>,
        "pradeeps@linux.vnet.ibm.com"
	<pradeeps@linux.vnet.ibm.com>,
        Pradeep Satyanarayana <pradeep@us.ibm.com>,
        "i.maximets@ovn.org" <i.maximets@ovn.org>,
        Adrian Moreno Zapata
	<amorenoz@redhat.com>,
        Hangbin Liu <haliu@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v5 1/7] bonding: Adding struct
 bond_arp_target
Thread-Index: AQHb9RJwtKR8ILTo4k6YOTSWcQayPrSLL0sAgAHFy5c=
Date: Wed, 10 Sep 2025 16:30:06 +0000
Message-ID:
 <MW3PR15MB3913542894107D1ADCFAF8EEFA0EA@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250714225533.1490032-1-wilder@us.ibm.com>
 <20250714225533.1490032-2-wilder@us.ibm.com>
 <dbc791a9-7b87-42a8-abba-fa63e5812008@redhat.com>
In-Reply-To: <dbc791a9-7b87-42a8-abba-fa63e5812008@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3913:EE_|DS4PPF1BDD6D585:EE_
x-ms-office365-filtering-correlation-id: 0c7f9510-52ce-4526-ee22-08ddf0874da9
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?/klufZehb6oHBZ3Anz24aRBRLMI14tSLGNdho73ZyUqpazYvb2tVAr1Tk4?=
 =?iso-8859-1?Q?XwQ2BZRTmP1VgnKQTCFPyv0N+EaRXzexedD5AcIceRrZ0qCwo5Xd772Wgb?=
 =?iso-8859-1?Q?9PkrCyDMPJOcmTp96wO6kmbn1PsH0W8x+N+jwKAzRSTrU9Wqi017U4/JBN?=
 =?iso-8859-1?Q?0VPbHmYFqq6a8UrGjqG6gC8Fhpafoh+fCZW4eow0SqU6h9X1whMeq49sRF?=
 =?iso-8859-1?Q?OZCz22XLAmzHsKih9XGwjNx+bhM90xd3JGOY3iFytx/M6uCm4HyRPk7ksf?=
 =?iso-8859-1?Q?VrW+4vvRzpcnnabXFvItRlZjUQdHnrhQWDfrJ9Fs1tUez1LFoNHPCIIlOU?=
 =?iso-8859-1?Q?uzEDXHUFQJVpxkx+wlsM68HWVcwI7hatImPU5bqU57oq5v41MEfr44g89f?=
 =?iso-8859-1?Q?+DNt1W+RMrGOrEt13VOMvvVljQFOURSL3sFQF6Di7fMf6wory44+6kzXuE?=
 =?iso-8859-1?Q?KkEl1xHhwJIy10NP45oveV3IpqqPcQLvfmzos+FKHyjF3dDKdKLXpP4FM3?=
 =?iso-8859-1?Q?O4JThuSiQS26LE/VCmg2lNqRfHKr44qm/DxaN8Kyd0uHDQkX1P4eHtIyid?=
 =?iso-8859-1?Q?CsmS8o1Xq6MVENiDDukyXJwgALwZJ6wKG4hZa8TGpkZA3tpugCzGD2TCFm?=
 =?iso-8859-1?Q?XIJwBQIh2BS3n+0vMUBtD8OJ0VeAMFS3uHfXBlAPe7dwDZOlnCdqZhNrxb?=
 =?iso-8859-1?Q?BVkYgm9mbOR9MzY+kPrKgo6fNwcL1vus0kWBYBHk6tnZ6gyFj+CWUMFWjY?=
 =?iso-8859-1?Q?IupEmTMUC+kGAGDgV3UWSZQSFLC9HvPALc4TWAe6NfNRD6ZgxutQ/ZdXP8?=
 =?iso-8859-1?Q?NBQzeUsxBN0dBmJmtf4vQrLDLvMygKwE77l0qqXN8X97M3YGAMO0hav+3g?=
 =?iso-8859-1?Q?QFGxGWNI6ruRBCRRx8wrMLA9bRbyfCN43vu1Y/t2rmpgFn7mEoFtpsOAvn?=
 =?iso-8859-1?Q?GPO0O+ddoLCzbQ5aYLyQJTL1XXX0hyoo8kR2zoN6XGlhM/l5r2Vn69EJyc?=
 =?iso-8859-1?Q?rzVNJeSD5AVBiFl2fchX6Ad4jCHiVMkFEhuvXSzTkF3G1CpQQS2X5Sl13x?=
 =?iso-8859-1?Q?BOzaPUVBfhGJ3r+x8aqF3RmFhyD0Im8C17XTG/D12fVcpiqruKhplLo6dv?=
 =?iso-8859-1?Q?Mx+MhLb16AZniHiWkIl1Ne79nfgZBSAiWdGI9J6wVEKNf8wmZvTejwSOZy?=
 =?iso-8859-1?Q?zSK+vigqZtl+56CAhJLQv+BOxJwjFMcBl9MOC3XYUMliG3BFqkQU/8o5LB?=
 =?iso-8859-1?Q?C7mjyHySVovFUIlUghQef6ldFXYPExc/N99MvVhkTjI4CFEboeIVlN/Fzr?=
 =?iso-8859-1?Q?MV+mmiFvHRL53ARBUk7mgDIKf5cJNJnXPQewNec7hRVoHyOh5s/YiRCx3B?=
 =?iso-8859-1?Q?bBNC/meunvG68tMszeTmoTu6kxQcYMR68F/RwyYw9Kac+PD7dia9ootBtB?=
 =?iso-8859-1?Q?syJXHJ2siVs287XvKAyxL+2xfWs/lnGOE6FeP1hHaWft2E1sIhqRxn5StC?=
 =?iso-8859-1?Q?ZOWe9t5bQM8Jq5E/7LvfCwlrVKCH4+MXfRzeIjBryN3bv4E5TPwGZg85JF?=
 =?iso-8859-1?Q?2eS/9xc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3913.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?R/qYdxDjugq2WTDFdTxNMYCsZ+sxQSKN8kvGDOJRgZ6yZl/IPCfzbWIBot?=
 =?iso-8859-1?Q?2P5Iit7O3smp1lKzlJ9zp85/H3sH6gVmr1TO2INRX4hsGv/g+ydUh9OHET?=
 =?iso-8859-1?Q?ME6iBd+Ge8Ynne3xGgOHaAorvr9z00ErnJVusPI62sHTEu5DKOp/v1F1qS?=
 =?iso-8859-1?Q?wU8r3xijbKYfdObm3XtDXHNozMKfhpO9biuPGEt4vLlkC7UErzRykfpt8l?=
 =?iso-8859-1?Q?W9TCwv2qFxnRPHjRdu454PU5p6+u2PanEewGVVuo5GvQv2jnpKaPFgDOw+?=
 =?iso-8859-1?Q?w2wbyTPoXuxuN99UP1Z5r8gpiIRgwn5X1w/9LbOieEhvUS0XlpLepT8f5+?=
 =?iso-8859-1?Q?kGnaLuSwEg0XDqj7iY/r7cEH68VjdogIH8G5IejIwiEIKR8tro8ZKQ2K4S?=
 =?iso-8859-1?Q?A0hv34/q98/1YvBI1zYCb9C5Nyve++Chsp5t4o0Gc+8H2ffHzaWxrDs2t6?=
 =?iso-8859-1?Q?oRIsQcdYX/7wOI/2KH9sCZGbqiKqigik36YpEyTRD8Q7L2/Gg3Upj4PTYV?=
 =?iso-8859-1?Q?w8QdWXweOiWzd+maH4+LA49NE0O6A8hQZkkXwAFieq1zp+p20al7WStM6M?=
 =?iso-8859-1?Q?yICYtGqtV5/+Pypt4VOyMQUmbyIoSJvhAc66pR9qJA6MrfjQDZO5fNt1rI?=
 =?iso-8859-1?Q?bBQwdivmT4aKvBmAAxpBp0WWOzWAQOaL3qYR68OfP7EpIxTcf5bhdEc2GJ?=
 =?iso-8859-1?Q?ikOi2UuAvv2syjAFjHztd4Q3W5ptl8zFR2cKFx8cuLn6x1v+jRxoiMj5h5?=
 =?iso-8859-1?Q?eaQPBRced9VQb6wmoKKg8A6EuCQgjgesDI/i2MDHxpEJBatggeJbXtZFBN?=
 =?iso-8859-1?Q?shfEuDnPHh/6VBQqsh/Xj2tOYqZyRJbLryeK9cgp09X2ErqQkB1xopd+IL?=
 =?iso-8859-1?Q?Mbziv6y62l8XeRMiCyaUzO/Makvnks86sgJ4EmYw04jgpbGWUPQ/9G9IfA?=
 =?iso-8859-1?Q?/Tw/N9WrC59HI/PT0SiC45X7fkoDYLlE4xS6rO2GTWWXpjUW0PB6nT/VpO?=
 =?iso-8859-1?Q?NOzpzqag+eDk4WZi2eR9ELsPh6jkLkwQO5d/EOOup3BA/ZMzhKqm8Qd/ku?=
 =?iso-8859-1?Q?kGUHUQf+rgZfgTAPWp/zz/64d6LWWV6mX1RFucXgXHjfx5dqsH8Jukf2Du?=
 =?iso-8859-1?Q?m/st3cwuqenRPkSK3zDLVA9kHN8zVGsSh7D1Y/AeKMN+CtWJ5NkGiKqpm3?=
 =?iso-8859-1?Q?PINcZsOJvL2YZ8a4tMXoutSkBki7vuOQW9nbBiipRXWJqzMng85c5hemvX?=
 =?iso-8859-1?Q?vyPtBrvS5zCPrmiD9+QTL1le0z2pXoCvCdB6H9iDNW4PlHi+BA3mA0TCPh?=
 =?iso-8859-1?Q?Ci7knHJLZj8I/RiPqCiciuY+A35HByQLUFy4H7IoHSrIesfu/iMY7Fla3B?=
 =?iso-8859-1?Q?d6zDDarq4BFuCEVRtYE9n9aa3cWS7Ec1BIxnO2NIUm3eO9M5988jjVx002?=
 =?iso-8859-1?Q?fW+3P42kB4CuGEp/6K3OcV8pALpumTnCFn27iJDQTxY9SU/di7TF7TAz/u?=
 =?iso-8859-1?Q?AaF1u8eSoKwPlALKFEPogtuSVLeRhRibsDr5x7ajN07fafIV9q7ivC18X8?=
 =?iso-8859-1?Q?KPkQCm+xSYzL1DxzTeXC0pEbVcP8/47drd2nHC99P+IPDtqpg4D8zZoPZH?=
 =?iso-8859-1?Q?+BkcjhFWMK5IievOWOHKfdwSul8tpRL3EpR7qswNdhk7Srl98kL29pVQ3g?=
 =?iso-8859-1?Q?AqZtWOeyXERkqw3QIDg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7f9510-52ce-4526-ee22-08ddf0874da9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 16:30:07.0024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NDXj+5kZBz2Y/riNg/fimbfBNyG2K4ga/Lt6Vw9bzStjfdvL8WE9cftxkB7p+FZoHSfjGxi3ppsnVabkAv7TXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF1BDD6D585
X-Proofpoint-ORIG-GUID: FBSyAIYYs_hPLrLgTxvddaiK3dCFGcNI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIzNSBTYWx0ZWRfX4SP82Ckp5L9M
 yBX0C8SWwCdIgvH5ew5+i6ItHAA/WZmrCfbWDmBabhO7IvWRzzRHA68LwC5W1WuFEWJ4dLu4id6
 lizDqLbzsRHsAnk1FZ6tkc9iLv5vwJ+BK2fTfSiZUByuS6n4AEBH3j0ohwYAKATfyoC8ZuDbzwY
 masyem9uUtWWPVm1pqAwbDbWSaboQhktFw1fbr+tCQOVW/t7NVpMklaoYHic5QiMIEk7fuyMGZm
 kOMFrARL8JNrs/MXCFjWPI467QZy0kbyQrpu2EOuePpIC4mViBn3pQkFB8iSWZtjj9udigX6ZWN
 p34e6LO/bW3pp1mqrVig26HjEVaC5+AHj1XZLKVSIKTbQRlgV7EUFqWrA4Z6E6N9lPEE1qcBNx5
 PCd+wAFc
X-Proofpoint-GUID: FBSyAIYYs_hPLrLgTxvddaiK3dCFGcNI
X-Authority-Analysis: v=2.4 cv=F59XdrhN c=1 sm=1 tr=0 ts=68c1a792 cx=c_pps
 a=h5SDh9cSBbECyHHhnXKavQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=2OjVGFKQAAAA:8
 a=VnNF1IyMAAAA:8 a=P8mRVJMrAAAA:8 a=mqTVBXkCnqhpE5SqMtEA:9 a=wPNLvfGTeEIA:10
 a=IYbNqeBGBecwsX3Swn6O:22 a=Vc1QvrjMcIoGonisw6Ob:22
Subject: RE: [PATCH net-next v5 1/7] bonding: Adding struct bond_arp_target
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060235

=0A=
=0A=
=0A=
________________________________________=0A=
From: Paolo Abeni <pabeni@redhat.com>=0A=
Sent: Tuesday, September 9, 2025 6:21 AM=0A=
To: David Wilder; netdev@vger.kernel.org=0A=
Cc: jv@jvosburgh.net; pradeeps@linux.vnet.ibm.com; Pradeep Satyanarayana; i=
.maximets@ovn.org; Adrian Moreno Zapata; Hangbin Liu=0A=
Subject: [EXTERNAL] Re: [PATCH net-next v5 1/7] bonding: Adding struct bond=
_arp_target=0A=
=0A=
> On 7/15/25 12:54 AM, David Wilder wrote:=0A=
> > Replacing the definition of bond_params.arp_targets (__be32 arp_targets=
[])=0A=
> > with:=0A=
> >=0A=
> > struct bond_arp_target {=0A=
> >       __be32                  target_ip;=0A=
> >       struct bond_vlan_tag    *tags;=0A=
> >       u32                     flags;=0A=
> > };=0A=
>=0A=
> The above struct is going to be allocated on the stack and has 2 holes 4=
=0A=
> bytes each.=0A=
>=0A=
> If you change the layout as follow:=0A=
>=0A=
> struct bond_arp_target {=0A=
>         __be32                  target_ip;=0A=
>         u32                     flags;=0A=
>         struct bond_vlan_tag    *tags;=0A=
> };=0A=
=0A=
> the struct size will be 8 bytes less.=0A=
>=0A=
> /P=0A=
=0A=
Cool. Thank you for the suggestion Paolo.=0A=
I will make the change.=0A=
=0A=

