Return-Path: <netdev+bounces-78680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 489CB8761EE
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 11:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB87B1F210CE
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 10:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFD553E06;
	Fri,  8 Mar 2024 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mYZnfgf4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA06D29E
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893470; cv=fail; b=oWWXvyWMxeU9UX+3IRQQ5GT21EB9Oq9pjj9tHiV5lfhZSspWC03pfw+Mo9WgfqEjAFBDHAEW9r1+cCsHNLoVru2fy0MhFFIgxU9+K4HcKgJsDEw9Lymt3yo9LfHXlWZPw4kBkYcigGTdYHiYManRkvxUTFEgu+lDNE48y8trnpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893470; c=relaxed/simple;
	bh=krYcJCWay0pWjppKJ7ALQkq+E+r61qCED8iA+fKUjWA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p23Ju+1n9FN3yjJNjsmxPoOa2M2jc5rS5jMK5oIxHa5b7lJFLMErNuRMUUehHaoDmRfsK153pue2MNVnqH0vEYONmzDJcD0EqbR/zmMGDCLSr+G6xDQEKneszf8sLzuPyB8CLLq01A4tL+6/C8DXMD7/1R571UDPbEFzlldAabk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mYZnfgf4; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4281c37P021785;
	Fri, 8 Mar 2024 10:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	qcppdkim1; bh=PyNMVrO6+D1+G1j5Hme0D4dlvp8iKA3O1XbScdR5uJ0=; b=mY
	Znfgf4gKxfUAjhis4IKHrrTBvmvyRVL28JzgOAcrHf9p+lcLW7ze9AkgaDVYszGs
	0ZaeqvXSEYUnV3dau3jvPmCtePR6ln9R4Q7c63rzSQ+rOsTjZkayqlx7JXvkqp3P
	wrafJM5aRiFE4ojbh39PjSUhFuRyx3/xvimnPmarmqIL47QyV9KwCng+uDAlRrSl
	Nzd/ELpeCBS8LKJzPljFVQ6uMS+SNpogeb+7LCRNewVy/Yn9pnEaeqIVkiBgxcz2
	Rx1dCO/XRZCq4BCO3u6BpizyeEWdr3Q7YtTZ0lkXaurS9jaex9SjU0ennTz0uSoR
	tGDzEGExXX4ThT39tmEQ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wqn8m1fr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 10:24:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6aMHgmacS8Ltm3Z5lGxdKhUM6m6xn8fgR8CuX01n14UmXtUoCUEZm8Ub++AcgX7mp7dq+RoaBPWR6gtoA7wM/J7jxYmjArlDzArMKI08Ep8eqbFST0Mqb4nKNkgT5+mxMZaW6rciLZe+/QRyyrqBXVzGg9FcHXrjOC5exdZTxFcrcs7cRKzTfoO0FU9+3E9ByjoqwS/G0r0mJhFlZ6HWGcLqiofxv2Tl4sl3+mOxXSsHg3o/8AeBZIQ9XQLAWjpT90z6BBe53+mg/nhc9w91SoqoLXaUYJLDlJCtb3UOpK54XLriXPfDLla4A1XTFjABgkTh4rrINhsjP/mqzKQyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyNMVrO6+D1+G1j5Hme0D4dlvp8iKA3O1XbScdR5uJ0=;
 b=g/GtMYnVcIqKTnxmfPxa0IpKzCN+0OpZtvSIiI9TndDQxD1QThbbmcFG84+WXrb2k3mF4gbxJHGRhpTRVN6G6sRK9ocmWdCwFq64iC4eij1WYoHbtR5rzjK/UXxvoMcAgQ2UHiqVE/fIgN9wV7QNorkf0s5eS3YJ45XAJVSP42VDW4cri0yOurcHry3ZU0jprAHQ8gsMhpXOpVTh6gzkwx8fKASE2AMwOEI/8qEuMMozuQp4S45hI9Cw3JZvrnhjqXZFIN1wOTE2ASL6NzRdYZXrKPMBmesxVeivgHP+lI4n1xRyVKfWDvXmGd6/Lt8LtmFrUEQ4v6OdMBNYR938PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CY8PR02MB9567.namprd02.prod.outlook.com (2603:10b6:930:77::15)
 by BY5PR02MB6866.namprd02.prod.outlook.com (2603:10b6:a03:237::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 10:24:19 +0000
Received: from CY8PR02MB9567.namprd02.prod.outlook.com
 ([fe80::7a26:6c6d:8ed0:e100]) by CY8PR02MB9567.namprd02.prod.outlook.com
 ([fe80::7a26:6c6d:8ed0:e100%4]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 10:24:19 +0000
From: "Sagar Dhoot (QUIC)" <quic_sdhoot@quicinc.com>
To: Michal Kubecek <mkubecek@suse.cz>
CC: Andrew Lunn <andrew@lunn.ch>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "Nagarjuna Chaganti (QUIC)"
	<quic_nchagant@quicinc.com>,
        "Priya Tripathi (QUIC)"
	<quic_ppriyatr@quicinc.com>
Subject: RE: Ethtool query: Reset advertised speed modes if speed value is not
 passed in "set_link_ksettings"
Thread-Topic: Ethtool query: Reset advertised speed modes if speed value is
 not passed in "set_link_ksettings"
Thread-Index: Adpwd4LZ0sghOKL6QDSCL099ROM8fAAl41KAAAQKzNAAAkz7AAAGld6g
Date: Fri, 8 Mar 2024 10:24:19 +0000
Message-ID: 
 <CY8PR02MB95670AA1F50BE4724098747DF9272@CY8PR02MB9567.namprd02.prod.outlook.com>
References: 
 <CY8PR02MB95678EBD09E287FBE73076B9F9202@CY8PR02MB9567.namprd02.prod.outlook.com>
 <945530a2-c8e9-49fd-95ce-b39388bd9a95@lunn.ch>
 <CY8PR02MB956757D131ED149C97F7D0DBF9272@CY8PR02MB9567.namprd02.prod.outlook.com>
 <20240308071544.dnh47hijov3aqbzu@lion.mk-sys.cz>
In-Reply-To: <20240308071544.dnh47hijov3aqbzu@lion.mk-sys.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9567:EE_|BY5PR02MB6866:EE_
x-ms-office365-filtering-correlation-id: 9c7be4be-bb86-4b14-9056-08dc3f59ea53
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 9g5bUXcRZRNgo/sGlG9uYEvlVcnP6nhya1EiDGDO/iK1dstnIs89YA7ktPM5GNZnc5nzV0Z1RsIqGZfQL2MZshCxyzci1vNMxYoaDgca+fF8kKQoHVLFL83BbvTvKlNOdP7lYcyqJSZwW61qesDxwJPSi7/6r17FNJFmoLASynMdA6YozHTanTVUxGrcWPZlahEoJQ+NpRjHJQJ3PG9xT2+T2oXQL09QSlk+skJa4a+mnQXIelZn0Ll0zyJ9ib6b196dG7vfujuwiz4b2qYTnx/i3ul54UmmsmqTHu0rpkbuitbkI/6hJUfg7o8W/3wTVj/24xjIqeEOumYpz//tBlENoDv7we/WFgdy9a9HguyMiQYimHU4bsmgQczLL392UFauBZEJZHY4otx8U7UF/D/vryZsBZO51ouU3HAq+eDe1ZVlTpxQL15UA5xvNKzw9jpgKDNsDu1N3KZbjU3LJjFJaEmNPzFf52hmccEgj7fjuXNAc0qJhGB3tgpSX2tjpP65brj3Fqhc1TuFOBYZNjmMiXEd2wrfV0BBFoEEf7sT9nuBFkj6I0O/Aqv3qWZBB0URoDVjjlVBNyC7lmTOkroGhsYZ/Ls10HRdOdmJhVKtceLYQ0yEq5Mfj5AF8CA9coLOQN27BOM6Yb0N3Ydjqj4BDkay/hyqL5D8Axf9p4020ngi7nxHgP1K0gFitF00RCqMFMharqxnPdrRvyZfigw3pN3rtNrU+zW7Xmv4YVM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9567.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?jmuIPB/koN32QYwTMH+ijIz/hs78VElhKhRZAxO2wkiyFyG3kRU6bL2GORZt?=
 =?us-ascii?Q?SrpSlhRDdeVC3jxuV0e/0cx+zZ9Hevd+M2cWO3OmVTzocTMIGful6cKZx1r4?=
 =?us-ascii?Q?Nmouz9UoJQjssiplnPEQQZMeBv0OUWTuuj+09FJRS0+ToJBKTtdNwhCYO78g?=
 =?us-ascii?Q?FWRmZXTNiwxak0DNoUxfcRCC4qtqu5oIiel49NIoDFzlaW3WZpjkSDmM/gek?=
 =?us-ascii?Q?HIYWLuLMslBcYMLpxM099U6t510RCFQSmkGnCSByneZqD1eMKVZj7KMznFJ0?=
 =?us-ascii?Q?yzn8SowiQutf+YFAwo4kpT3evEDX1+SHWx1ngNEUokXJnVV1MEDLjE7O66vP?=
 =?us-ascii?Q?sKmdwkEnpOPtWlGXXNjhAA4SjwdFxbf+iDQk/HAWhHaE4v6ELjfRQlI9Avi7?=
 =?us-ascii?Q?v1OlfnE19k4+7doZFN6swBtqgCrhXSWEtm71E7SSYWWAlK/PMZSuDjSua3ER?=
 =?us-ascii?Q?QJjnjchb3Sgv1A0qM5NvxPruQep0m2oe9zA+Yv9gQJR31QJRbyNRKiApvPoL?=
 =?us-ascii?Q?JAMT6PkEHR4l+nmz7HtX8+aHQjnfCmzFGzqzQAZs13YHqoqllPmxyuvM1qtT?=
 =?us-ascii?Q?vVsLtIodos4Tk3eWAngIBPxjssGtM4wJlQsotxzIg2TnW1auzTQLPR1XxfcN?=
 =?us-ascii?Q?TOokIpE6l0XGNSV0AcW/d5xd1zkAJJ1c8/Tr1q8yJ428avWAD+suDjdGaSXI?=
 =?us-ascii?Q?d+uW0CrbMfrjVyVJlXihKv+Wvg7QM4+rd6J4D+1lMq1vfg+GJaV/fMm75DFY?=
 =?us-ascii?Q?yO8Oxp2mfdAu29OoHKiWLTaiH6awbYiBVlwMAQHlenaUfz03jD2meCxXMmuG?=
 =?us-ascii?Q?j6DTJ1dGZW/knUJYx9rf4SWlzmHxCWq85BT0y81812byf/1K1E/I4rKNZGA+?=
 =?us-ascii?Q?9ArVUNqkavCT2iwJrA+bWVn4s1MjtkwuU8s28h6cVLv00DIUfNLIxK+WGAFA?=
 =?us-ascii?Q?a4Tk9AJm/aoMYtyqE0/8plO/OkOLxPCrzgVaKdrhmX9oCgs/xjPBuoDNUUYa?=
 =?us-ascii?Q?qOZxrXbB/vWY+Pow5ylu2aM8KOGgeMIJJqK1MBAGvZpmG7+Iv4XmIs2cFgwo?=
 =?us-ascii?Q?naJNqTDdo9Dq0PdoKUpKeXA2Hy7hgqDfBdHz3FT6LWRaXz4SqejfiACVK9O0?=
 =?us-ascii?Q?aUrxQ7YhOd4IR9en2NuCQ74x5BFbrW+YNk8yBWzHOvB4kOCsJGIn8qSvv0IP?=
 =?us-ascii?Q?b/9bEMpzW1FZ1sNi32x9aeEyprlKrIBE4igbWl8f4ZBQAgCkNx7MlsVatjyA?=
 =?us-ascii?Q?zMJmAE3Fabuda2jr5ZAxN4IRtzYnlxPdlnALAs74jvVV7m52ScC/zJKKCeNg?=
 =?us-ascii?Q?H+cAAd602pzLTrmtTNb8rtUU33XHguwQ42f2AIqBTahv3Llh2fnJw1POTtxj?=
 =?us-ascii?Q?317BicmPQXgeeKHFgQ0n96uy9iUOdSjAD7YqSt3b5ZmTm3E4MSKsBqyUDkvq?=
 =?us-ascii?Q?quDjibqfa3bO9WL8KZYK1v2jUM10h6u/35p1GwRPdcJO3BosxFtO13xNb7Lc?=
 =?us-ascii?Q?4gNRa0IYpm4V3hFHp8NFrOALzol6sxDQzmNUGnKO6YPIySGAauzxOE76TR8l?=
 =?us-ascii?Q?SE7SISEhqcuabf4eaVk5MqDr6NTzSPs/q0DnNGg5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0NRYKrS/SoOTkSVB+AafIYU6znVLlPyrrVVpJKpjj86KajBc2L8IsedyIAHMZhy0rK0FffQ+ydR9ni89fvlQYTYQW+k0kpa6aQCkZL/kdqiuidMH1RanTmTmzoYDjthLzv2AwLrZlaTt756lmMkt40Si1jAnp7AjsXJAzyCaSAUTobMuEvkVzK0laoDL7aiXH+FWokQI9mSQKk4yFSI1f64pw5tffUQhVQB2GGpOSOfLtxKm68WeIKs3pSRZggL7Ot7jR4ynLHFdRMtWgkrWwRk4BMTMCcnfSbCS+rvzwUT6PVAgLLzUZSNFHfDbi+MEzumVUO+nlp8xKmg6kAXfnQCoKCMN22k8eaFfCYp26Mr3C020VAakJ5FiPeTH6pYHeIq0o9Gk8/4TTmw+hYtASf0oV/cagpReeCQgSWRPcXG4IPw/X8IgzTmC0nEJcpLvmuOzD54Sxe5lmp5Z+LsWb4Kz8Ow0/HbX5Vx/akukDcDfnIa+SWq4gEiWVOTvfdEzblwDehk8rhIcYA39hhY6Y7fYrYnf5qD0/7X4HZzmuG/VT70rzrQgs0nMk8T0zLHplmt/866+l+z5h8vzff5fDJReHeQeGMQSzbtrQhJBdXYBMKiycY6u3yxEuEcqKAj8
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9567.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7be4be-bb86-4b14-9056-08dc3f59ea53
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 10:24:19.5140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 771WLrH4W66HsWcTY4/PXw30NJyQqDMXJsh+sB3+nt1Zx99NWHqxkydcgCQHsioI4nkWxs5uoYjLSfzBXTeGBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6866
X-Proofpoint-GUID: WH8CGRY7Fl5qhJBqUKBfyV0JLZFkmRpP
X-Proofpoint-ORIG-GUID: WH8CGRY7Fl5qhJBqUKBfyV0JLZFkmRpP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_07,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=526 impostorscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403080082

Hi Michal,

Thanks for your response.

Given that we don't have a straightforward way to do such
differentiation in the current framework, we will try to=20
manage this internally.

Thanks,
Sagar

-----Original Message-----
From: Michal Kubecek <mkubecek@suse.cz>=20
Sent: Friday, March 8, 2024 12:46 PM
To: Sagar Dhoot (QUIC) <quic_sdhoot@quicinc.com>
Cc: Andrew Lunn <andrew@lunn.ch>; netdev@vger.kernel.org; Nagarjuna Chagant=
i (QUIC) <quic_nchagant@quicinc.com>; Priya Tripathi (QUIC) <quic_ppriyatr@=
quicinc.com>
Subject: Re: Ethtool query: Reset advertised speed modes if speed value is =
not passed in "set_link_ksettings"

On Fri, Mar 08, 2024 at 06:33:00AM +0000, Sagar Dhoot (QUIC) wrote:
> Hi Andrew,
>=20
> Thanks for the quick response. Maybe I have put up a confusing scenario.
>=20
> Let me rephrase with autoneg on.
>=20
> 1. "ethtool eth_interface"
> 2. "ethtool -s eth_interface speed 25000 autoneg on"
> 3. "ethtool -s eth_interface autoneg on"
>=20
> Once the link is up at step 2, "get_link_ksettings" will return the=20
> speed as 25G. And if "set_link_ksettings" is invoked at step 3, it=20
> will still pass the speed value as 25G retrieved with=20
> "get_link_ksettings", even though the speed was not explicitly=20
> specified in the ethtool command. So, after step2, if I must go back=20
> to the default state i.e., advertise all the supported speed modes, is=20
> there any way to do so?

IIRC this is backward compatible with how the ioctl interface behaves.
The logic is that if a parameter is omitted, it is supposed to be preserved=
; thus the third command simply means "enable the autonegotiation" and don'=
t do anything else (which is a no-op in this case).

But I agree that it would be convenient to have a shortcut for "enable the =
autonegotiation with all supported modes". On the command line it could be =
e.g. something like

  ethtool -s $iface autoneg on advertise all

or

  ethtool -s $iface autoneg on advertise supported

On the implementation level, the problem is that IIRC we have no easy way t=
o express such request in current netlink API. It could be emulated by quer=
ying the modes first (which returns both advertised and supported
modes) and requesting supported modes to be advertised but that's not very =
practical. So probably the best solution would be introducing a new flag an=
d using the complicated way as a fallback if the kernel does not support it=
.

Michal

