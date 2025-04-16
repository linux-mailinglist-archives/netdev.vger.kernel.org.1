Return-Path: <netdev+bounces-183461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A38B3A90BBE
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13DA419E003E
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65D3223703;
	Wed, 16 Apr 2025 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L+TTPO55"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F4929A5
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744829842; cv=fail; b=bKJAq1/SgA1jfeuynHDSdF1nk8eOmM+eCs3v3lfrL+8k5JGTqcXoWtIySs2fh5lWJlyq4dZ7G086+kep42JtQH2QLLQcmUOpiTv/HqF4uZsF288yNmOshVR9qSDMHLJxHQFpHfpUOP2kjV1mRX9lwJfUfuLLlJqBOmSSCo683/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744829842; c=relaxed/simple;
	bh=PA4xeWdwV+4s0XYhmhcuJdw+ObncmQiiu0Dw87lO1OU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=VKnFPT40YbBz2T20iGa4TnI883+GBTSoadNvWkq25WZxQperxRFZYlT9TX+gQVWmrbawHOm/31DBSBNozY0xOzPP1a2zx85eWUlvO8c+Jiik4FnWuLc0UA9CE1/+zAmFnCfwb+sLSRX18Y1rTkzSDenlnfy+Occ9lhRof3C3gL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L+TTPO55; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GA7Wah018854;
	Wed, 16 Apr 2025 18:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7cXXyL
	H2U6qEuKx3uFdWFJ3tLPo7myz0Hg/2Wyp5hoI=; b=L+TTPO55AFYzc+VZopf4ct
	63DJnkNAHfB0j5qx/gfy6Tlz9U+8wCJRgfFhdWgL4lruMYmHbdRYK2O3AD6cqZ7O
	8jrNr7aYfTN3DKvfTC7P5z6xJhlhkAaga8zNDBSxQieSUY32qbMhe3l/8G0a2956
	GlVdPgfuoTlDtUyQJ9FGLDgq4GNDTjSVtXK06kKeQ6EdFj5MFG90K/zwR5sbALLF
	gjup/9/15g3gpklnKQd5OpC8ax5yXi9gjXz33UHRRoMYWsmUjrRF6SWyLHztjLPe
	qTW2ita+0wt/FnDLehgrcSdGM6CO1mZald0PUVh3NRyvBSueo+mXNlAk+6Rp8+RA
	==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461y1gdspn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 18:57:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTOkIx22KDsISm7rZVXGMaVf7JKxxkTc7/HMRH9NtQbI1zxLtuynhh93huM9H4DXrqd9NGKNtH2xn8z1VcJ0l1iA1J5sG4vPgj0xGgNdVc15ubXmYxUVIy2yd9G+K0SeawTdlyZN/vOjWj5fawhNsPeYs01s6BZ/HbSIYiMoaNgd9fZtnGAvL32LTQi/T8xgKc73nnXxHiQDdfprL/RLEZBTetypk846F8PfksAqj5jeHuV2UzE7Gt5Oi336xzeGMCW06OTPMuOAXkPgxfcjE0cnY+QIxFO2/GaDpKlthqj4z/e4ZC3lWp9qhT/0Yudoc1y9AxeWCW4dhE8APoC2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cXXyLH2U6qEuKx3uFdWFJ3tLPo7myz0Hg/2Wyp5hoI=;
 b=v2dBVxwQ6003+OTi5KVvuQ6EmE8b0GlFLm8HWaCdBnAK6yIn0J8IM9Nf0j8YMILDyleTWf6tbMcAKy+UaAlU+Lih0NTVOer0vFvcuKi0bsP5EKZ2LbUzhu6mCHRHUoxOeUrFoJgmnmceaclUcVaFRvaVVizS4b84qMN16vQPwebG4u/u4ZIkox/idCHHF+pK5o5a5Tx5Auuq6Lf152hwva/8rTj7d9bPbdJBkaQ09s8YR07kXuR6IU7IrbFEIIJUMjDd4eklp4Jp/P2VWuXMJqaDd4cl+9ltIYKjflMZDTrYhcFwYWml6uhsYsxKKyOMKzz7YIiOfqVh5izA23wAzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3913.namprd15.prod.outlook.com (2603:10b6:303:42::22)
 by IA3PR15MB6581.namprd15.prod.outlook.com (2603:10b6:208:526::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Wed, 16 Apr
 2025 18:57:10 +0000
Received: from MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490]) by MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490%5]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 18:57:10 +0000
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
 AQHbqwoTrDjAZh6IzkG7iJ522lMXdLOfJPkAgAAI5oCAAbHmB4AETtyAgAAQYlmAAEPdgIABC58v
Date: Wed, 16 Apr 2025 18:57:10 +0000
Message-ID:
 <MW3PR15MB39131B4CAE5E3D06084D2A7DFABD2@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250411174906.21022-1-wilder@us.ibm.com>
 <20250411174906.21022-2-wilder@us.ibm.com> <3885709.1744415868@famine>
 <d3f39ab2-8cc2-4e72-9f32-3c8de1825218@ovn.org>
 <MW3PR15MB39135B6B84163690576F95FDFAB02@MW3PR15MB3913.namprd15.prod.outlook.com>
 <4164872.1744747795@famine>
 <MW3PR15MB39138C432D2CD843C20C0C10FAB22@MW3PR15MB3913.namprd15.prod.outlook.com>
 <4177847.1744765887@famine>
In-Reply-To: <4177847.1744765887@famine>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3913:EE_|IA3PR15MB6581:EE_
x-ms-office365-filtering-correlation-id: 56c4529a-de7b-4978-f7dc-08dd7d187ddb
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?bh8seHi1Mwki+8UG8iHyxylGSkX5Go2K8v5gPgSTKMtVVn5HzBONyt9H92?=
 =?iso-8859-1?Q?CODhcep5o1P5+ofNgWsS3UQsrmpyOxSPCma/NLiQE/23bJIWFORz9DsgUR?=
 =?iso-8859-1?Q?t0iZISIAu+i1GxKxyRxuywt1y6PcjnQmMEKNwMUnk2GV2+ITLwh/Pvymx6?=
 =?iso-8859-1?Q?kdLiusoQffb9Oa2SmNoJv0fFF1dF28elxwPj2B9HHFmryIHTNZhGOZ/NSj?=
 =?iso-8859-1?Q?LXmX/mZKlJjQtZQ2d/5JPEkAETEXJQscZEpiHM8vKz1zec+DQNYpewcYiv?=
 =?iso-8859-1?Q?Y0tRSKJFyUCirTac1+Z7WDBLfsBqQ/nnuM8pR0v8YFW1DTF1luKaBb7rD+?=
 =?iso-8859-1?Q?YLtra3YLxr0lyvJo7qPuXp2M5am8oDUz+YTfy6b8VFbYQzTitfNpm02pkj?=
 =?iso-8859-1?Q?x2faOz1GzYRPZwe8Z4gAg0W6LoEbig7ZN2Y42P2x4icnwDo4/7VrHGleYG?=
 =?iso-8859-1?Q?M97Uayi3pbobDs5CK3W4pb263o7XOeNHaoX1dYSZD5OAaiZU561rYA46eU?=
 =?iso-8859-1?Q?Yk4/9OE1S8oAEQveY5cMcfNwrXTOTumxDsbqjuTIMTWag9QAxPa+hih+p+?=
 =?iso-8859-1?Q?Emj8E3N6wwjcmlIJ4mkJLstNlSiqloIFyVoI9lv2HeDC2e0GtB9AdfKhRf?=
 =?iso-8859-1?Q?/pKJkWqxQHqUoxG/LmAK0C6lfDUUbQ+e4CODeGwYJjOpZ7DtarutAH47tB?=
 =?iso-8859-1?Q?hxVUeC1yHkLG9wJI8sxWX1ymAJyaNQq1W6twWq5vBPXEOvkwxgx1uVDwso?=
 =?iso-8859-1?Q?68sW1F+//2QFz88jPuUbyt6zlRPMmlwvG6sCjUsu2fDMNr7nqBVtW04R1W?=
 =?iso-8859-1?Q?MLu048BXc5PoaPJxgdetWdG4V5owcx2sfh7AGeP9mAZ8rbPx1jGSD4U7oN?=
 =?iso-8859-1?Q?zFm0nTVnKjUjc1skKlpQJHezXXh+Bfu5Qg3fBaRTyLoa+cYhJGppCMvrLX?=
 =?iso-8859-1?Q?DBJU59u69EDVP42P0tBeB8ajytGtaJ14pwAwSpNNwPM3HjiR7wOlv1491j?=
 =?iso-8859-1?Q?ZtRvfqA7ZJTPNi7VnkqJSggo/UmIZQfgR6/Ul1doKf4L20TuavyJ7M7Bfg?=
 =?iso-8859-1?Q?qHTNzp8RxVjI41LqI2sPptvCYwdJPafsDAC40vEZNOIN8Ra5hKb5oCvLCR?=
 =?iso-8859-1?Q?9TVUV9lwX2aBsAHcjKgc5s81i/hNwxeQhmr7rS1qB2bTOV0TY+HNAGL2r5?=
 =?iso-8859-1?Q?G4GNKTJdxYfnhTxTxCddDOi8CWfGJmxIWwduwe7RIWb3ZaTDo8vP012xkl?=
 =?iso-8859-1?Q?VDw7BgR6YbZWh3AEhSCI8WXMVbFokyWBnUFnZWzc8FMY92ft2vkufB6R25?=
 =?iso-8859-1?Q?MKEdqF1Lr1e/+esvOU1TsqliRlaVPVPY6coefATfWVwvq79NNIKzBeqecM?=
 =?iso-8859-1?Q?3bYxLasnppROZJcsfLvuYdU6nRlphQdCWTwxk+Zx/5mVOR15Ff2qfsfIej?=
 =?iso-8859-1?Q?mvPcPVmVNpTMZAQKFFr7ZHDjxuNM7TABdy1dFirJJFqxFMWiUim6Oosehz?=
 =?iso-8859-1?Q?nfM04Yj07l6v9hvnoY8MTuF7LBZGmODgmFI7CkAXTUew=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3913.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7/5vUyw0lbl7PdxlWI44f5S2RqJUL2Ef9sG7u6d7Q4Ty9OOmwnCA9CdrI7?=
 =?iso-8859-1?Q?OQNh8yIkkcXNdjv3lU52dNtE8+070H17Lap3PEkAcRQlKD/DMnPy6fveGA?=
 =?iso-8859-1?Q?KIpFPxtJlZtwhwOX7+DYJXqnCNf6pr/52qM9YRtQsHMV4qb9J0rjM+18xl?=
 =?iso-8859-1?Q?vQVKOCADXrYaH1qtcf47puTE0CqvySEwP+iNL4mmZ6I8rmWnMAr6sKEkdW?=
 =?iso-8859-1?Q?qhN1SQoCISvjXRgupOqjeHsqgd8b+j612mirdoHPh2YeOSs7ra+yLW7iPW?=
 =?iso-8859-1?Q?CwQfa3IOZCiVbsUu4t+bN8XYRBz4RPZH7D3v7QAdrDXkR/gTjMB/CpvFdr?=
 =?iso-8859-1?Q?wDgTa6S2MNvljTcNu1gaIHtumo6Q3heCPSTji1ZVkd4J9F87RgG3M/Yn+i?=
 =?iso-8859-1?Q?7QPRwCgm9zn2DBBXAA6Wh0jVqrE1husfUA8vftD8gxvazplCUmn1yo/rQO?=
 =?iso-8859-1?Q?m1YumBIXiXb24bJt7mntM8uvSB/YsmX+OzAs+iyJAtws1XnDYMr7f6HpIC?=
 =?iso-8859-1?Q?5AUiz2j2f+wfIJdYI8F/QTdjBpEPvw0o7JVmZEQnmhZ2RTnkgoTt3EqAfN?=
 =?iso-8859-1?Q?ZIMCfEbelaRnk7ECpXdmos0S2oZLj9P9Dckz2rbBHPHC7ZhOyb8DchuGZ7?=
 =?iso-8859-1?Q?8Ho65V5tA6MMPQmhtWJB5IVVyEuR9wC+H5OYF/p4DAZF0ybBOLbUVJ4YGJ?=
 =?iso-8859-1?Q?vDhUdXmtvSN+Dvb3LTQnA7QflYdn0/zLWc2t7lhoxWi7aL5GFJ0zY5xIw7?=
 =?iso-8859-1?Q?ENxYsjvA/0l5FrIa+feIayRj6VISg0C2BDHNFv2TeWN3GtAH5WUCi05x2r?=
 =?iso-8859-1?Q?ByoRtsJEsDkjx5aelmgE4pEQ/+s+95CgWXipntsvjt4g3pr10wafwWs6Fk?=
 =?iso-8859-1?Q?BET1oJdzG1BL+Inf2k6bnS32EMmpdRDe35fGlOOyCOAxtcC5V524p+zj7/?=
 =?iso-8859-1?Q?U4HteFOMgO63ufPXRQne+oVKA6UoR+2r/XU8KSKzirjuYGir2R50JYBpeQ?=
 =?iso-8859-1?Q?zKSL7UFcFotFttX3/mUn/4uCO4jO15ZGm3cqKX4t+mNA1DAk/DRSK8dr+f?=
 =?iso-8859-1?Q?TxAuLEt0+dT41K8J/XfnEX8C8DaXuwnEVg0W2J3EA5t4bqZa7u0JcRsXBa?=
 =?iso-8859-1?Q?bsyS81jJBMH5vfBSm0oPVLMRbXGrlQkGWUyvtLS+XTstGjKzFDF5xcwfxY?=
 =?iso-8859-1?Q?dpbj6yAe3ReNVPcxEWp8lbFw3V5fYFVm/IhTn1T9OD2ldjTb4AXVtE2D1m?=
 =?iso-8859-1?Q?D3tnEELZNoBMPsje/UynHu49eoTAAQlBoMkUkHV/peIjEjIxryKwQVxSHa?=
 =?iso-8859-1?Q?Aazh0WOjej5Hx66tG+hg2azSUufjNx8yE3BvYbjz71MdM6h0QvnbrJMl5P?=
 =?iso-8859-1?Q?cPG1frFD9QQYhomcWM++Ow6M3Fv8fQ2b10njHMVEmpyma1XW4nA6R335v3?=
 =?iso-8859-1?Q?z73e8/9kenjmHv8og3lvl4N8N2RHPOsy+l1+DKWG1knQ3KgfluBmk50Zk3?=
 =?iso-8859-1?Q?VUx2ZF04ycvFW2SYdeUQslLuLpXjIBEBTf9LxKGrCKEKzbbPOtXMc45xPY?=
 =?iso-8859-1?Q?Ty41li7smfSoqbT+oFDRAZn+OP7JpwnJfdSDNLj7g3t42P/OGHys3V/aDl?=
 =?iso-8859-1?Q?nzQpPfF56AqhM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c4529a-de7b-4978-f7dc-08dd7d187ddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 18:57:10.0330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BLLR4aCehBlw/E/c9UweKp2fkqfgVHa1WM1so/NjTUw6DWWMQNutv8+BcEtztu4QD53K/O+KIz82b3JU0fwcGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR15MB6581
X-Proofpoint-ORIG-GUID: ZHyZADlssVe_nsi2yCfHH0JBYrXEada-
X-Proofpoint-GUID: ZHyZADlssVe_nsi2yCfHH0JBYrXEada-
Subject: RE: [PATCH net-next v1 1/1] bonding: Adding limmited support for ARP
 monitoring with ovs.
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_07,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504160151

>>>>>>> Adding limited support for the ARP Monitoring feature when ovs is=
=0A=
>>>>>>> configured above the bond. When no vlan tags are used in the config=
uration=0A=
>>>>>>> or when the tag is added between the bond interface and the ovs bri=
dge arp=0A=
>>>>>>> monitoring will function correctly. The use of tags between the ovs=
 bridge=0A=
>>>>>>> and the routed interface are not supported.=0A=
>>>>>>=0A=
>>>>>>       Looking at the patch, it isn't really "adding support," but=0A=
>>>>>> rather is disabling the "is this IP address configured above the bon=
d"=0A=
>>>>>> checks if the bond is a member of an OVS bridge.  It also seems like=
 it=0A=
>>>>>> would permit any ARP IP target, as long as the address is configured=
=0A=
>>>>>> somewhere on the system.=0A=
>>>>>>=0A=
>>>>>>       Stated another way, the route lookup in bond_arp_send_all() fo=
r=0A=
>>>>>> the target IP address must return a device, but the logic to match t=
hat=0A=
>>>>>> device to the interface stack above the bond will always succeed if =
the=0A=
>>>>>> bond is a member of any OVS bridge.=0A=
>>>>>>=0A=
>>>>>>       For example, given:=0A=
>>>>>>=0A=
>>>>>> [ eth0, eth1 ] -> bond0 -> ovs-br -> ovs-port IP=3D10.0.0.1=0A=
>>>>>> eth2 IP=3D20.0.0.2=0A=
>>>>>>=0A=
>>>>>>       Configuring arp_ip_target=3D20.0.0.2 on bond0 would apparently=
=0A=
>>>>>> succeed after this patch is applied, and the bond would send ARPs fo=
r=0A=
>>>>>> 20.0.0.2.=0A=
>>>>>>=0A=
>>>>>>> For example:=0A=
>>>>>>> 1) bond0 -> ovs-br -> ovs-port (x.x.x.x) is supported=0A=
>>>>>>> 2) bond0 -> bond0.100 -> ovs-br -> ovs-port (x.x.x.x) is supported.=
=0A=
>>>>>>> 3) bond0 -> ovs-br -> ovs-port -> ovs-port.100 (x.x.x.x) is not sup=
ported.=0A=
>>>>>>>=0A=
>>>>>>> Configurations #1 and #2 were tested and verified to function corec=
tly.=0A=
>>>>>>> In the second configuration the correct vlan tags were seen in the =
arp.=0A=
>>>>>>=0A=
>>>>>>       Assuming that I'm understanding the behavior correctly, I'm no=
t=0A=
>>>>>> sure that "if OVS then do whatever" is the right way to go, particul=
arly=0A=
>>>>>> since this would still exhibit mysterious failures if a VLAN is=0A=
>>>>>> configured within OVS itself (case 3, above).=0A=
>>>>>=0A=
>>>>> Note: vlan can also be pushed or removed by the OpenFlow pipeline wit=
hin=0A=
>>>>> openvswitch between the ovs-port and the bond0.  So, there is actuall=
y no=0A=
>>>>> reliable way to detect the correct set of vlan tags that should be us=
ed.=0A=
>>>>> And also, even if the IP is assigned to the ovs-port that is part of =
the=0A=
>>>>> same OVS bridge, there is no guarantee that packets routed to that IP=
 can=0A=
>>>>> actually egress from the bond0, as the forwarding rules inside the OV=
S=0A=
>>>>>datapath can be arbitrarily complex.=0A=
>>>>>=0A=
>>>>> And all that is not limited to OVS even, as the cover letter mentions=
, TC=0A=
>>>>> or nftables in the linux bridge or even eBPF or XDP programs are not =
that=0A=
>>>>> different complexity-wise and can do most of the same things breaking=
 the=0A=
>>>>> assumptions bonding code makes.=0A=
>>>>>=0A=
>>>>>>=0A=
>>>>>>       I understand that the architecture of OVS limits the ability t=
o=0A=
>>>>>> do these sorts of checks, but I'm unconvinced that implementing this=
=0A=
>>>>>> support halfway is going to create more issues than it solves.=0A=
>>>=0A=
>>>    Re-reading my comment, I clearly meant "isn't going to create=0A=
>>>    more issues" here.=0A=
>>>=0A=
>>>>>>       Lastly, thinking out loud here, I'm generally loathe to add mo=
re=0A=
>>>>>> options to bonding, but I'm debating whether this would be worth an=
=0A=
>>>>>> "ovs-is-a-black-box" option somewhere, so that users would have to=
=0A=
>>>>>> opt-in to the OVS alternate realm.=0A=
>>>>=0A=
>>>>> I agree that adding options is almost never a great solution.  But I =
had a=0A=
>>>>> similar thought.  I don't think this option should be limited to OVS =
though,=0A=
>>>>>as OVS is only one of the cases where the current verification logic i=
s not=0A=
>>>>>sufficient.=0A=
>>>=0A=
>>>        Agreed; I wasn't really thinking about the not-OVS cases when I=
=0A=
>>>wrote that, but whatever is changed, if anything, should be generic.=0A=
>>=0A=
>>>>What if we build on the arp_ip_target setting.  Allow for a list of vla=
n tags=0A=
>>>> to be appended to each target. Something like: arp_ip_target=3Dx.x.x.x=
[vlan,vlan,...].=0A=
>>>> If a list of tags is omitted it works as before, if a list is supplied=
 assume we know what were doing=0A=
>>>> and use that instead of calling bond_verify_device_path(). An empty li=
st would be valid.=0A=
>>=0A=
>>>        Hmm, that's ... not too bad; I was thinking more along the lines=
=0A=
>>>of a "skip the checks" option, but this may be a much cleaner way to do=
=0A=
>>>it.=0A=
>>=0A=
>>>        That said, are you thinking that bonding would add the VLAN=0A=
>>>tags, or that some third party would add them?  I.e., are you trying to=
=0A=
>>>accomodate the case wherein OVS, tc, or whatever, is adding a tag?=0A=
>>=0A=
>>It would be up to the administrator to add the list of tags to the=0A=
>>arp_target list.  I am unsure how a third party could know what tags=0A=
>>might be added by other components.  Knowing what tags to add to the=0A=
>>list may be hard to figure out in a complicated configuration.  The=0A=
>>upside is it should be possible to configure for any list of tags even=0A=
>>if difficult.=0A=
>=0A=
>  I suspect I wasn't clear in my question; what I'm asking is what=0A=
>you envision for the implementation within bonding for the "[vlan,vlan]"=
=0A=
>part, and by "third party," I mean "not bonding," so OVS, tc, etc.=0A=
>=0A=
>  Would bonding need to add the tags in the list, or expect one of=0A=
>the thiry parties to do it, or some kind of mix?=0A=
=0A=
Bonding needs to add all the tags. I am just optionally replacing=0A=
the collection of tags by bond_verify_device_path() with a list of tags=0A=
supplied in the arp_target list. (Optional Per target).=0A=
=0A=
To be clear, if you chose to supply tags manually, you need to supply=0A=
all the tags needed for that target,  not just the tags bonding could not=
=0A=
figure out on its own. An empty list [] would be valid and would just cause=
=0A=
bonding to skip tag collection.=0A=
=0A=
If OVS adds a tag it would be up to the user to know that and update=0A=
the bonding configuration to include all tags for the target.  =0A=
=0A=
>=0A=
>   Does bonding need to know what tags any third party adds?  I.e.,=0A=
>for your case 3, above, wherein OVS adds a tag, why does that fail to=0A=
>work?=0A=
=0A=
Today it fails since bond_verify_device_path() cant see the tags=0A=
added by or above OVS.  Adding a list of tags [vlan vlan] or [] would effec=
tively =0A=
do the the same as the "skip the checks" option.  But allows a way to make=
=0A=
case 3 work.=0A=
=0A=
>=0A=
>>A "skip the checks" option would be easier to code. If we skip the=0A=
>>process of gathering tags would that eliminate any configurations with=0A=
>>any vlan tags?.=0A=
>=0A=
>  So, yes, it would be easier to implement, and, no, I think a=0A=
>simple "skip the checks" switch could be implemented such that it still=0A=
>runs the device path and gathers the tags, but doesn't care if the end=0A=
>of the device path matches.=0A=
>=0A=
>  That said, such an implementation is effectively the same as=0A=
>your original patch, except with an option instead of an OVS-ness check,=
=0A=
>and I'm still undecided on whether that's better than something that=0A=
>requires more specific configuration.=0A=
=0A=
Ah,  ok I get it.  =0A=
=0A=
The "skip the checks" option has the advantage in simplicity and will=0A=
fix the problem I started out solving.  The downside is it wont solve more=
=0A=
complex configurations Ilya is concerned with (see case 3). I am all for st=
arting=0A=
with the "kiss" approach, we can always pivot to something more complex lat=
er if we have=0A=
the demand.=0A=
=0A=
>=0A=
>-J=0A=
=0A=
=0A=
>>>>>>> Signed-off-by: David J Wilder <wilder@us.ibm.com>=0A=
>>>>>>> Signed-off-by: Pradeep Satyanarayana <pradeeps@linux.vnet.ibm.com>=
=0A=
>>>>>>> ---=0A=
>>>>>>> drivers/net/bonding/bond_main.c | 8 +++++++-=0A=
>>>>>>> 1 file changed, 7 insertions(+), 1 deletion(-)=0A=
>>>>>>>=0A=
>>>>>>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/=
bond_main.c=0A=
>>>>>>> index 950d8e4d86f8..6f71a567ba37 100644=0A=
>>>>>>> --- a/drivers/net/bonding/bond_main.c=0A=
>>>>>>> +++ b/drivers/net/bonding/bond_main.c=0A=
>>>>>>> @@ -3105,7 +3105,13 @@ struct bond_vlan_tag *bond_verify_device_pat=
h(struct net_device *start_dev,=0A=
>>>>>>>      struct net_device *upper;=0A=
>>>>>>>      struct list_head  *iter;=0A=
>>>>>>>=0A=
>>>>>>> -    if (start_dev =3D=3D end_dev) {=0A=
>>>>>>> +    /* If start_dev is an OVS port then we have encountered an ope=
nVswitch=0A=
>>>>>=0A=
>>>>> nit: Strange choice to capitalize 'V'.  It should be all lowercase or=
 a full=0A=
>>>>> 'Open vSwitch' instead.=0A=
>>>>=0A=
>>>>>>> +     * bridge and can't go any further. The programming of the swi=
tch table=0A=
>>>>>>> +     * will determine what packets will be sent to the bond. We ca=
n make no=0A=
>>>>>>> +     * further assumptions about the network above the bond.=0A=
>>>>>>> +     */=0A=
>>>>>>> +=0A=
>>>>>>> +    if (start_dev =3D=3D end_dev || netif_is_ovs_port(start_dev)) =
{=0A=
>>>>>>>              tags =3D kcalloc(level + 1, sizeof(*tags), GFP_ATOMIC)=
;=0A=
>>>>>>>              if (!tags)=0A=
>>>>>>>                      return ERR_PTR(-ENOMEM);=0A=
>>>>>>=0A=
>>>>>> ---=0A=
>>>>>>       -Jay Vosburgh, jv@jvosburgh.net=0A=
>>>>>=0A=
>>>>> Best regards, Ilya Maximets.=0A=
>>>>=0A=
>>>>David Wilder (wilder@us.ibm.com)=0A=
>>>=0A=
>>>---=0A=
>>>        -Jay Vosburgh, jv@jvosburgh.net=0A=
>>=0A=
>>David Wilder (wilder@us.ibm.com)=0A=
>=0A=
>---=0A=
>  -Jay Vosburgh, jv@jvosburgh.net=0A=
=0A=

