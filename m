Return-Path: <netdev+bounces-221872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4495DB52364
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 23:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262F51C20340
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 21:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8813C30F81F;
	Wed, 10 Sep 2025 21:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WeL7XTiH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CC5285050
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 21:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757539185; cv=fail; b=B4OiOlCcNY5pByWd59s4U483eHtvk4eBX1H0uxKoMUTGKAvyBSWP3pYkZ4hTrhvIFvyW6F0bCVY7Sl7gGzfwDutqCskNgjwFBjlB5qLlqWYE5ieS3t/DoOt8E6IeCftXUzIWFu7B0z2gLNeTPc20SbuqqGPQRwAQiw9dqT2PHbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757539185; c=relaxed/simple;
	bh=4VXSjP1aZbr+zM3MI+Q7s2BgsWWaAdu+gw3shySqQLg=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=pfmPcxVxwXwKl8vLMFXqhXdU4NkAnAnjd2bADT17/adYTnVofvDSG3A67SzPXzZHzITGDBVU+9MEfHRivjkfaNXLBMEHEcsnCyl4Z6wYyuXQVmBSovLwZ+AgGV5pC4fdjl7lwAYAIpZHa31EiOg5G138GffHd82hYw+AWWC3By4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WeL7XTiH; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AEUhBf028014;
	Wed, 10 Sep 2025 21:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6Hdf4h
	QR7SfhISO78CJPCk1hI2SRL9YXn0RPTo0fRDQ=; b=WeL7XTiHRFQSm6KCWL/ZjP
	hLPta9ybg1Pp+xIkw64SAmhPILqf7PSd6kHuekrKoP6DfdyUW2D4F/aaPkIxQG2X
	CLaxGFXLdykIngCMRjG44DGrIpLi4kAra9LmqdAR6RwKjsJRoCZHSWFkZPKbxA/F
	sY1f/fxTyr5oUAUszs+cFf8S2zPgSkUe2IDhYMvIVV+gq216PyPDdXXhImoOAA7s
	B74Zaxr0ctrnS38JNLWP0AezjAKmc3HTgmCz/BAAZk1if8FOZjQ9d2jMhZIpxabi
	t7+sFnuN1zHiA583yk7NVdNdjB8Y9BeX+/xZc4N/zPuxJuAY5AVXC9SO/ppCFm6A
	==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acr8e9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 21:19:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQIvUrPkUcPlufJj+kcP9rbwAf06uDWnA4bBxZHl5O2RXS3vU3LQpVye2RFW1R+bQvJFr+ipUa06hM9GzTNdPg5HHXstFqAQLyENVPPrZV1VEwUvLL4vxKowbN6fQnNZZZwjvsckH1fxFuJdVlEaG4iRgYzG0uw182UtIVq7Hgzkx/q0U+9cdQqAjBFAhZWdMHZTZv/JBgtPkPIg9i4MZPAD3CQ5Wa9ApNw2mXEZdVpe3UD+FjB4PJ+kbiEEzKK0g4o81lqTK263vH1pLOpx7bar6JQmsRQMr/xI0OISt1kbVLc6uH/ETe9U0lAMFrKosMTepNqBP3MnIqgmZY/ztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Hdf4hQR7SfhISO78CJPCk1hI2SRL9YXn0RPTo0fRDQ=;
 b=Ytgaa8HeBsLUAun7ZuvoQxs5ScrZI5k94Q7k9YDEC4uAUzDaJeqjq6WPuw/9RccKQFaXSrCFe7Z1NA7tYjY+RXjVhgbD3TMhO7+2V8pA7HSlOzCpJvaQSrCBFVN2+kztDC0mtBhKGDM+UFST9dURnI3xQeZsj3lWPg7mWFk421JApsq27NeUoPwpTsT58ccjLYmbD1zk1emdVjR6uGp0J//uwOawjjD88RYv6Y8I5Hhb5fXi3LTcm4SSrhglG9xxs7EUC30xtSlesxajr4yw/VGU7kBwqRBUkchQixwPSuk/5lDT2JcluIehWibSKwdf9hoZMmRUxeNP4nNwQ7+WJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3913.namprd15.prod.outlook.com (2603:10b6:303:42::22)
 by SJ4PPF5F7A20E3C.namprd15.prod.outlook.com (2603:10b6:a0f:fc02::89d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 21:19:30 +0000
Received: from MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490]) by MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490%7]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 21:19:30 +0000
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
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v10 4/7] bonding: Processing
 extended arp_ip_target from user space.
Thread-Index: AQHcHeoRTZ0akp1WPUa01uDbOF2PjbSLNywAgAG83mI=
Date: Wed, 10 Sep 2025 21:19:30 +0000
Message-ID:
 <MW3PR15MB3913CB95AB53A926E253DF28FA0EA@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250904221956.779098-1-wilder@us.ibm.com>
 <20250904221956.779098-5-wilder@us.ibm.com>
 <aa19f9b7-7eb4-4cf2-b400-1370ef95c66e@blackwall.org>
In-Reply-To: <aa19f9b7-7eb4-4cf2-b400-1370ef95c66e@blackwall.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3913:EE_|SJ4PPF5F7A20E3C:EE_
x-ms-office365-filtering-correlation-id: ccfa8bbd-4c6d-4c88-b711-08ddf0afbb1c
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?61BBI7CxxAo9tC2aLfKIRhGesQPR+jFDUCWmJhq9xgCF2qNjr3Cx7ObKpz?=
 =?iso-8859-1?Q?ZVlvMYFBE28pe0Srw8FwwCWOq73M+CRGRh4cv6W9oGZHxDAQIcanl4coSL?=
 =?iso-8859-1?Q?y2r7GU8aEHcOIg0BptvAbQqWBBNlJ+iug9EjU/iPM7tU5Dyq/9sCqusUuA?=
 =?iso-8859-1?Q?92eIRrNFLp5xBYn3gkiwQZ+97a2qO5Bp1CcVfgWkKBJeQqMKSo1Fc64lF+?=
 =?iso-8859-1?Q?FNjim91+WFIU/xR0vd33jqs8rjf9bIyhvr8OWKpgoYQCETZ42g1kRYzZnH?=
 =?iso-8859-1?Q?z2JEHRP/N6/nk0xL2jYF+L2vO8iBW1DGVb6QmPcDWZsKcnMr3izfL4FPem?=
 =?iso-8859-1?Q?D7rkUMGk2yeLVMOcqy78suXfv85bDzBDjytUNbB3sMcgo4CCCttuvyKfkx?=
 =?iso-8859-1?Q?++o66M5JsWbGvzL5uQ/2GcsTT935k18iEtCN+h/o4ZYu7tSpC4VWrLqWkV?=
 =?iso-8859-1?Q?kGfMJzXnz+zHEx4mK6jxqeNKGvhA9nDMWqd11QC7euW4KhZ4vGjK5Jyd2r?=
 =?iso-8859-1?Q?24fVxohgk3cQBA34wDyaR39Oqm/pW26ODu6Tz09lqGBnTNH9afDJpdwNhA?=
 =?iso-8859-1?Q?OE+bOrSumVoHiOFw7LXBOf1D/r8IqepSu0h6O1bpPhy/EL3Uv+PDfEFIiq?=
 =?iso-8859-1?Q?/3ym9XnTJxS1hXOvt/YfltcMHw9v3taEK4F+9caOuNdSm/G5JHafNac14Z?=
 =?iso-8859-1?Q?4d66OpFXA8CPn1rV6kZ76C0TBJsPJUfZTDaj5QMlEC3IdkzVI/Gv7Crz+p?=
 =?iso-8859-1?Q?YgAkZiBjtio2jymW0o+CRL7KZDJvudzWTHc7El4ZK3RmCR5I94W3rIn59G?=
 =?iso-8859-1?Q?Pd+iQH7iKU8brfd6i9MmLERvtRvMA/29VG5F/FuPA5ifPbeiXl9L2AVCBr?=
 =?iso-8859-1?Q?xt73fWs0XryNpZwCvkr9dRKRwaPH6IY0N4nNnRdc82gLQ5JLw09qFtTC2V?=
 =?iso-8859-1?Q?CAKsTxJ57wCTwTei8ktU4Txzn9vMQPSMvKC/3HNOeQCpDEDE26/C0FEyy9?=
 =?iso-8859-1?Q?M5bSiRWYND3+diK6c1HAcpc8e4jl0Wo5HLqDGgXGRfDvJsAeX8BzmK3Gem?=
 =?iso-8859-1?Q?9TpUAsfhD8oVtde7jsYOG+OOrxSQyeTWRnXvIeY+DcTNEHAeVTIxrBdY/f?=
 =?iso-8859-1?Q?7Fv/3GtrZt3NYU/fd5SM5hhhs0AB/sdXmHqwsSY37K/sFRCbh4HgXD7e6g?=
 =?iso-8859-1?Q?W8m6QFWakTkC/hcXA8IdOZVfntNcYeWJ8D7GiYN8ZMTuk7fT9SEl/cMQRq?=
 =?iso-8859-1?Q?sydEZslbFPL8VoGeU2yskb4DWIdNgTKDWY6DjgL8l1aSXDtgOMUk9cSEf3?=
 =?iso-8859-1?Q?Vx774AHrfLt4MlDLt3vVsq+BRcBXlTJhVIxT4jhVRR4v+C4c4dQ4zOppIt?=
 =?iso-8859-1?Q?vwrGCFesBCHv90grdAzLrCBP7z13x6NyOaMWtVqKMkDknGf61WtKXaThqW?=
 =?iso-8859-1?Q?THJxO15gsnchGO9GhIhEqLeliYxjBL5qUi9gQNlmAYerJm2MDDRHTrR29K?=
 =?iso-8859-1?Q?miAs8jvYLrNPGq2TmbaU3cMB4DUE6XGUhd9R5y6shL/w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3913.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?TF/d230VfQ1XKSAtwQT76TM9T7xYQKJJFz63ZgZrkuJjBiqRdVmPqXvVXv?=
 =?iso-8859-1?Q?pN7MUv1zd/MpPrEPdU8ixzbVhjf9AcYW2lUmgqEE2jo198Pn6a1CQuxHwD?=
 =?iso-8859-1?Q?PvnLlGRTRQErwKlZQkpsPvAMcwPfi8B7d6yHrj/TQC1lLGyz3+blQJHXZm?=
 =?iso-8859-1?Q?ohwEnn/Ljf1SP0avOdo9g4mPtrQRikvYAV1dsmCpebAt9rNdnGxOdRNnmw?=
 =?iso-8859-1?Q?vrfogmGz7A9KWmafVMOgUHT2Hao0tbfwbeeesFroYGWE5e15EqvsdibD+P?=
 =?iso-8859-1?Q?7iNllTGpGpda07G9VBeV7kEjDof+L0rayZsvAe3JN+whULJPwJH6+c25Ay?=
 =?iso-8859-1?Q?VEzCUjcPaMUJfHSIr7/2hA1Yqn7qwSts6rgAOh6sOb/D3KhyIvDi4kspC2?=
 =?iso-8859-1?Q?Lg+NR4HXfK7XMu6BmYowYAftkbadCjrdswAGh3KPr/4J5vy7wcqlcuWeN/?=
 =?iso-8859-1?Q?kSb1kRrn0TJQR9DuDbHa0fDsPV8iOoaha6CKlQIXL2G/JGTcdUAjeyUVe4?=
 =?iso-8859-1?Q?Z6U37KrXfYGWpF43mYH3ta++L1reanvkaDattB1OF4uJ/gGJnPJD1QlHry?=
 =?iso-8859-1?Q?yajKTuOKgiBtzLFQvZJXgr6OmJ81iZKzv8fB0E1vUfL5EXHLmKDPBFXrSU?=
 =?iso-8859-1?Q?3CMr0RlY/poHO/c5BFK94kncWJfF94KoAjm42s2qc5MztReuvxdzzegxPt?=
 =?iso-8859-1?Q?8Gs5QHge7g/+L5vnVelsPRcV+4lar9j8WIJcuTBfgcIqur7SkxZuqfxVdd?=
 =?iso-8859-1?Q?Wn19MKDVMQe1Kl48M2tp0uyXyH0uCH3Fz9rnxQawFXtyo+CkYz3/na/T6E?=
 =?iso-8859-1?Q?7PYZuaHzraSgX6dhHy+LJoYcKI0N1vcPA25ymuwZnx7mDqoc8Rby8noQjz?=
 =?iso-8859-1?Q?BDjp80BxKmzMF8gLQh8jbyIrG8Aia0KT3V40qnfI/jJnM0ayU21Lt0S+t9?=
 =?iso-8859-1?Q?ZiKGxZo7w2A8vKoGv2Ce2zczjc4ZzcmZkG9zxddb9eu2YqnKVE9A4Dxh1a?=
 =?iso-8859-1?Q?wvsh3KEw7BCIYI5+OvXqua8By6EZ7tvttBNGM9O0tDCnTyskEfQSl41V2D?=
 =?iso-8859-1?Q?AZr187DQQ8R81Xc66Ck2aNSdoRLRzBd0M8UPn+UMOo3iYwC3V06j7ZDdvG?=
 =?iso-8859-1?Q?w6nzIlGrlvwZ/EzeBxZ/4mxA8PTR5sLGjm+2xW2ocUkwXNy5pcsU6qCy8J?=
 =?iso-8859-1?Q?6GOM2knOE1Cy/dVLNSaZhlVGXb0CX2TPIV9+jULN4W6dhV6/7GqcdjWM+E?=
 =?iso-8859-1?Q?JUSqk2Q0oBTFSdh3NnUBBS7J7ux3k/hnmj78WaiErdeRkfsVyGopLt+bY/?=
 =?iso-8859-1?Q?yhvUaPMRyuQynkqLuMZxbHsQJEHZsjnLhswBBsN7+KE9PCUAoFt6N2PdrU?=
 =?iso-8859-1?Q?/yw4HoCuse8XXnqcNfJ/Zk4niMnGivrhUKW5bhqrjcCC28FLZzJQV7XsAO?=
 =?iso-8859-1?Q?HDq9sSaMwMw2yY2t+WmVQw++nxF6ms4rcEszAMFCqiHZvmsTMbQo/y11VW?=
 =?iso-8859-1?Q?7/WFlzc9t3TAEcLH8UxSSskS8+6Z7g6eDh3/a8l4nDWe0uPxtjwT4NzyQl?=
 =?iso-8859-1?Q?55Bn/vS/GX+YIgioo096FzEOYZsxnuaoPlfPX5KFmRgnZodN5vIv9fSUYa?=
 =?iso-8859-1?Q?Q0Uw9NOULT1ImuIutWzG4EMcAkhlerYOpaMF69MoUX73MCK5kFGHGdfD7j?=
 =?iso-8859-1?Q?zi2zeHQnskoVnarBnt4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfa8bbd-4c6d-4c88-b711-08ddf0afbb1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 21:19:30.5468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7b1NXlpHNgaT+B0144lvjPVcpbSGWNigIR2Qlk9nFX1a17J1eFUaBRt2riQLP+o90KfaWxKMqb+xDiZr3ErayA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPF5F7A20E3C
X-Proofpoint-GUID: SLyHuybVcENwfh_db3FNbFNISFgbAi9j
X-Authority-Analysis: v=2.4 cv=Mp1S63ae c=1 sm=1 tr=0 ts=68c1eb65 cx=c_pps
 a=EDI2sMUdhBp/6Fwy26P2Vw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=vr0dFHqqAAAA:8 a=VwQbUJbxAAAA:8 a=2OjVGFKQAAAA:8
 a=VnNF1IyMAAAA:8 a=P8mRVJMrAAAA:8 a=jZVsG21pAAAA:8 a=WC40qfQR5lXlS0sBuq8A:9
 a=wPNLvfGTeEIA:10 a=P4ufCv4SAa-DfooDzxyN:22 a=IYbNqeBGBecwsX3Swn6O:22
 a=Vc1QvrjMcIoGonisw6Ob:22 a=3Sh2lD0sZASs_lUdrUhf:22
X-Proofpoint-ORIG-GUID: SLyHuybVcENwfh_db3FNbFNISFgbAi9j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfXxsDgukqEXsaD
 Yrl2BboCePj0szn+CUTd687G3oWrFclxiV3VWzLQf2J74tQ956EDQmWFvg6vHKqbazoo+Eh1QVs
 OINrb6dwnfIN74t+cOcJq/YHG7/gTjEKDkZGxfvzKv6EolX5OAoaRxtPyqFmRoXYUfC10WM7OfY
 lySWJXa5GXza+Nu57Yzg50KNlSWv9qfdbhG6M0CwqFXvj/WDhyOjUsfYmGVV5NYNffnfF8qTH4D
 ci15Pc2e+lXsF1Z8x3+fXa/kma8fIUaO7r2Ya5Eg32rqhxk+Zm2VpNvLqC9zdxmc9jooF5PEkea
 EstWRjNYsvQBzh9L71V7bxzsAQt+Ibcv6svuOz/lS57560YmDRzUajxOw9zGDDult9+WNn9A4/V
 +8VxOXVk
Subject: RE: [PATCH net-next v10 4/7] bonding: Processing extended
 arp_ip_target from user space.
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060000

=0A=
=0A=
=0A=
________________________________________=0A=
From: Nikolay Aleksandrov <razor@blackwall.org>=0A=
Sent: Tuesday, September 9, 2025 11:42 AM=0A=
To: David Wilder; netdev@vger.kernel.org=0A=
Cc: jv@jvosburgh.net; pradeeps@linux.vnet.ibm.com; Pradeep Satyanarayana; i=
.maximets@ovn.org; Adrian Moreno Zapata; Hangbin Liu; stephen@networkplumbe=
r.org; horms@kernel.org=0A=
Subject: [EXTERNAL] Re: [PATCH net-next v10 4/7] bonding: Processing extend=
ed arp_ip_target from user space.=0A=
=0A=
Thank you Nikolay for you review and comments.=0A=
Responses inline.=0A=
=0A=
> On 9/5/25 01:18, David Wilder wrote:=0A=
> > Changes to bond_netlink and bond_options to process extended=0A=
> > format arp_ip_target option sent from user space via the ip=0A=
> > command.=0A=
> >=0A=
> > The extended format adds a list of vlan tags to the ip target address.=
=0A=
> >=0A=
> > Signed-off-by: David Wilder <wilder@us.ibm.com>=0A=
> > ---=0A=
> >   drivers/net/bonding/bond_netlink.c |   5 +-=0A=
> >   drivers/net/bonding/bond_options.c | 121 +++++++++++++++++++++++-----=
-=0A=
> >   2 files changed, 99 insertions(+), 27 deletions(-)=0A=
> >=0A=
> > diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/b=
ond_netlink.c=0A=
> > index a5887254ff23..28ee50ddf4e2 100644=0A=
> > --- a/drivers/net/bonding/bond_netlink.c=0A=
> > +++ b/drivers/net/bonding/bond_netlink.c=0A=
> > @@ -291,9 +291,10 @@ static int bond_changelink(struct net_device *bond=
_dev, struct nlattr *tb[],=0A=
> >                       if (nla_len(attr) < sizeof(target))=0A=
> >                               return -EINVAL;=0A=
> >=0A=
> > -                     target =3D nla_get_be32(attr);=0A=
> > +                     bond_opt_initextra(&newval,=0A=
> > +                                        (__force void *)nla_data(attr)=
,=0A=
> > +                                        nla_len(attr));=0A=
> >=0A=
> > -                     bond_opt_initval(&newval, (__force u64)target);=
=0A=
> >                       err =3D __bond_opt_set(bond, BOND_OPT_ARP_TARGETS=
,=0A=
> >                                            &newval,=0A=
> >                                            data[IFLA_BOND_ARP_IP_TARGET=
],=0A=
> > diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/b=
ond_options.c=0A=
> > index cf4cb301a738..61334633403d 100644=0A=
> > --- a/drivers/net/bonding/bond_options.c=0A=
> > +++ b/drivers/net/bonding/bond_options.c=0A=
> > @@ -31,8 +31,8 @@ static int bond_option_use_carrier_set(struct bonding=
 *bond,=0A=
> >                                      const struct bond_opt_value *newva=
l);=0A=
> >   static int bond_option_arp_interval_set(struct bonding *bond,=0A=
> >                                       const struct bond_opt_value *newv=
al);=0A=
> > -static int bond_option_arp_ip_target_add(struct bonding *bond, __be32 =
target);=0A=
> > -static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 =
target);=0A=
> > +static int bond_option_arp_ip_target_add(struct bonding *bond, struct =
bond_arp_target target);=0A=
> > +static int bond_option_arp_ip_target_rem(struct bonding *bond, struct =
bond_arp_target target);=0A=
> >   static int bond_option_arp_ip_targets_set(struct bonding *bond,=0A=
> >                                         const struct bond_opt_value *ne=
wval);=0A=
> >   static int bond_option_ns_ip6_targets_set(struct bonding *bond,=0A=
> > @@ -1133,7 +1133,7 @@ static int bond_option_arp_interval_set(struct bo=
nding *bond,=0A=
> >   }=0A=
> >=0A=
> >   static void _bond_options_arp_ip_target_set(struct bonding *bond, int=
 slot,=0A=
> > -                                         __be32 target,=0A=
> > +                                         struct bond_arp_target target=
,=0A=
> >                                           unsigned long last_rx)=0A=
> >   {=0A=
> >       struct bond_arp_target *targets =3D bond->params.arp_targets;=0A=
> > @@ -1143,24 +1143,25 @@ static void _bond_options_arp_ip_target_set(str=
uct bonding *bond, int slot,=0A=
> >       if (slot >=3D 0 && slot < BOND_MAX_ARP_TARGETS) {=0A=
> >               bond_for_each_slave(bond, slave, iter)=0A=
> >                       slave->target_last_arp_rx[slot] =3D last_rx;=0A=
> > -             targets[slot].target_ip =3D target;=0A=
> > +             memcpy(&targets[slot], &target, sizeof(target));=0A=
> >       }=0A=
> >   }=0A=
> >=0A=
> > -static int _bond_option_arp_ip_target_add(struct bonding *bond, __be32=
 target)=0A=
> > +static int _bond_option_arp_ip_target_add(struct bonding *bond, struct=
 bond_arp_target target)=0A=
> >   {=0A=
> >       struct bond_arp_target *targets =3D bond->params.arp_targets;=0A=
> > +     char pbuf[BOND_OPTION_STRING_MAX_SIZE];=0A=
> >       int ind;=0A=
> >=0A=
> > -     if (!bond_is_ip_target_ok(target)) {=0A=
> > +     if (!bond_is_ip_target_ok(target.target_ip)) {=0A=
> >               netdev_err(bond->dev, "invalid ARP target %pI4 specified =
for addition\n",=0A=
> > -                        &target);=0A=
> > +                        &target.target_ip);=0A=
> >               return -EINVAL;=0A=
> >       }=0A=
> >=0A=
> > -     if (bond_get_targets_ip(targets, target) !=3D -1) { /* dup */=0A=
> > +     if (bond_get_targets_ip(targets, target.target_ip) !=3D -1) { /* =
dup */=0A=
> >               netdev_err(bond->dev, "ARP target %pI4 is already present=
\n",=0A=
> > -                        &target);=0A=
> > +                        &target.target_ip);=0A=
> >               return -EINVAL;=0A=
> >       }=0A=
> >=0A=
> > @@ -1170,43 +1171,44 @@ static int _bond_option_arp_ip_target_add(struc=
t bonding *bond, __be32 target)=0A=
> >               return -EINVAL;=0A=
> >       }=0A=
> >=0A=
> > @@ -1170,43 +1171,44 @@ static int _bond_option_arp_ip_target_add(struc=
t bonding *bond, __be32 target)=0A=
> >               return -EINVAL;=0A=
> >       }=0A=
> >=0A=
> > -     netdev_dbg(bond->dev, "Adding ARP target %pI4\n", &target);=0A=
> > +     netdev_dbg(bond->dev, "Adding ARP target %s\n",=0A=
> > +                bond_arp_target_to_string(&target, pbuf, sizeof(pbuf))=
);=0A=
> >=0A=
> >       _bond_options_arp_ip_target_set(bond, ind, target, jiffies);=0A=
> >=0A=
> >       return 0;=0A=
> >   }=0A=
> >=0A=
> > -static int bond_option_arp_ip_target_add(struct bonding *bond, __be32 =
target)=0A=
> > +static int bond_option_arp_ip_target_add(struct bonding *bond, struct =
bond_arp_target target)=0A=
> >   {=0A=
> >       return _bond_option_arp_ip_target_add(bond, target);=0A=
> >   }=0A=
> >=0A=
> > -static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 =
target)=0A=
> > +static int bond_option_arp_ip_target_rem(struct bonding *bond, struct =
bond_arp_target target)=0A=
> >   {=0A=
> >       struct bond_arp_target *targets =3D bond->params.arp_targets;=0A=
> > +     unsigned long *targets_rx;=0A=
> >       struct list_head *iter;=0A=
> >       struct slave *slave;=0A=
> > -     unsigned long *targets_rx;=0A=
> >       int ind, i;=0A=
> >=0A=
> > -     if (!bond_is_ip_target_ok(target)) {=0A=
> > +     if (!bond_is_ip_target_ok(target.target_ip)) {=0A=
> >               netdev_err(bond->dev, "invalid ARP target %pI4 specified =
for removal\n",=0A=
> > -                        &target);=0A=
> > +                        &target.target_ip);=0A=
> >               return -EINVAL;=0A=
> >       }=0A=
> >=0A=
> > -     ind =3D bond_get_targets_ip(targets, target);=0A=
> > +     ind =3D bond_get_targets_ip(targets, target.target_ip);=0A=
> >       if (ind =3D=3D -1) {=0A=
> >               netdev_err(bond->dev, "unable to remove nonexistent ARP t=
arget %pI4\n",=0A=
> > -                        &target);=0A=
> > +                        &target.target_ip);=0A=
> >               return -EINVAL;=0A=
> >       }=0A=
> >=0A=
> >       if (ind =3D=3D 0 && !targets[1].target_ip && bond->params.arp_int=
erval)=0A=
> >               netdev_warn(bond->dev, "Removing last arp target with arp=
_interval on\n");=0A=
> >=0A=
> > -     netdev_dbg(bond->dev, "Removing ARP target %pI4\n", &target);=0A=
> > +     netdev_dbg(bond->dev, "Removing ARP target %pI4\n", &target.targe=
t_ip);=0A=
> >=0A=
> >       bond_for_each_slave(bond, slave, iter) {=0A=
> >               targets_rx =3D slave->target_last_arp_rx;=0A=
> > @@ -1214,30 +1216,77 @@ static int bond_option_arp_ip_target_rem(struct=
 bonding *bond, __be32 target)=0A=
> >                       targets_rx[i] =3D targets_rx[i+1];=0A=
> >               targets_rx[i] =3D 0;=0A=
> >       }=0A=
> > -     for (i =3D ind; (i < BOND_MAX_ARP_TARGETS - 1) && targets[i + 1].=
target_ip; i++)=0A=
> > -             targets[i] =3D targets[i+1];=0A=
> > +=0A=
> > +     bond_free_vlan_tag(&targets[ind]);=0A=
> > +=0A=
> > +     for (i =3D ind; (i < BOND_MAX_ARP_TARGETS - 1) && targets[i + 1].=
target_ip; i++) {=0A=
> > +             targets[i].target_ip =3D targets[i + 1].target_ip;=0A=
> > +             targets[i].tags =3D targets[i + 1].tags;=0A=
> > +             targets[i].flags =3D targets[i + 1].flags;=0A=
> > +     }=0A=
> >       targets[i].target_ip =3D 0;=0A=
> > +     targets[i].flags =3D 0;=0A=
> > +     targets[i].tags =3D NULL;=0A=
>=0A=
> This looks wrong, bond_free_vlan_tag() is kfree(tags) and then it is set =
to NULL but=0A=
> these tags can be used with only RCU held (change is in patch 05) in a fe=
w places, there is=0A=
> no synchronization and nothing to keep that code from either a use-after-=
free or a null=0A=
> ptr dereference.=0A=
>=0A=
> Check bond_loadbalance_arp_mon -> bond_send_validate.=0A=
>=0A=
  I understand your concern, see the discussion about patch 5.=0A=
  If the setting of user supplied tags is performed during=0A=
  the creation of the bond with the RTNL held then this should not=0A=
  be an issue.  I need to think about what happens if the user attempts to=
=0A=
  create or change or delete an arp_ip_taget on an existing bond. The exist=
ing code=0A=
  had no special handling of that case.=0A=
=0A=
> >=0A=
> >       return 0;=0A=
> >   }=0A=
> >=0A=
> >   void bond_option_arp_ip_targets_clear(struct bonding *bond)=0A=
> >   {=0A=
> > +     struct bond_arp_target empty_target;=0A=
>=0A=
> empty_target =3D {} ...=0A=
>=0A=
> >       int i;=0A=
> >=0A=
> > +     empty_target.target_ip =3D 0;=0A=
> > +     empty_target.flags =3D 0;=0A=
> > +     empty_target.tags =3D NULL;=0A=
>=0A=
> ... and you can drop these lines=0A=
=0A=
Thanks,  I will make that change.=0A=
=0A=
>=0A=
> > +=0A=
> >       for (i =3D 0; i < BOND_MAX_ARP_TARGETS; i++)=0A=
> > -             _bond_options_arp_ip_target_set(bond, i, 0, 0);=0A=
> > +             _bond_options_arp_ip_target_set(bond, i, empty_target, 0)=
;=0A=
> > +}=0A=
> > +=0A=
> > +/**=0A=
> > + * bond_validate_tags - validate an array of bond_vlan_tag.=0A=
> > + * @tags: the array to validate=0A=
> > + * @len: the length in bytes of @tags=0A=
> > + *=0A=
> > + * Validate that @tags points to a valid array of struct bond_vlan_tag=
.=0A=
> > + * Returns: the length of the validated bytes in the array or -1 if no=
=0A=
> > + * valid list is found.=0A=
> > + */=0A=
> > +static int bond_validate_tags(struct bond_vlan_tag *tags, size_t len)=
=0A=
> > +{=0A=
> > +     size_t i, ntags =3D 0;=0A=
> > +=0A=
> > +     if (len =3D=3D 0 || !tags)=0A=
> > +             return 0;=0A=
> > +=0A=
> > +     for (i =3D 0; i <=3D len; i =3D i + sizeof(struct bond_vlan_tag))=
 {=0A=
> > +             if (ntags > BOND_MAX_VLAN_TAGS)=0A=
> > +                     break;=0A=
> > +=0A=
> > +             if (tags->vlan_proto =3D=3D BOND_VLAN_PROTO_NONE)=0A=
> > +                     return i + sizeof(struct bond_vlan_tag);=0A=
>=0A=
> You suppose that there is at least sizeof(struct bond_vlan_tag) in tags=
=0A=
> but there shouldn't be, it could be target_ip + 1 byte and here you will=
=0A=
> be out of bounds.=0A=
=0A=
I will add a check for len < sizeof(struct bond_vlan_tag) .=0A=
=0A=
>=0A=
> > +> +          if (tags->vlan_id > 4094)=0A=
>=0A=
> vlan tag 0 is invalid as well, and this should be using the vlan definiti=
ons=0A=
> e.g. !tags->vlan_id || tags->vlan_id >=3D VLAN_VID_MASK=0A=
=0A=
I will make that change as well.=0A=
=0A=
>=0A=
> > +                     break;=0A=
> > +             tags++;=0A=
> > +             ntags++;=0A=
> > +     }=0A=
> > +     return -1;=0A=
> >   }=0A=
> >=0A=
> >   static int bond_option_arp_ip_targets_set(struct bonding *bond,=0A=
> >                                         const struct bond_opt_value *ne=
wval)=0A=
> >   {=0A=
> > -     int ret =3D -EPERM;=0A=
> > -     __be32 target;=0A=
> > +     size_t len =3D (size_t)newval->extra_len;=0A=
> > +     char *extra =3D (char *)newval->extra;=0A=
> > +     struct bond_arp_target target;=0A=
> > +     int size, ret =3D -EPERM;=0A=
> >=0A=
> >       if (newval->string) {=0A=
> > +             /* Adding or removing arp_ip_target from sysfs */=0A=
> >               if (strlen(newval->string) < 1 ||=0A=
> > -                 !in4_pton(newval->string + 1, -1, (u8 *)&target, -1, =
NULL)) {=0A=
> > +                 !in4_pton(newval->string + 1, -1, (u8 *)&target.targe=
t_ip, -1, NULL)) {=0A=
> >                       netdev_err(bond->dev, "invalid ARP target specifi=
ed\n");=0A=
> >                       return ret;=0A=
> >               }=0A=
> > @@ -1248,7 +1297,29 @@ static int bond_option_arp_ip_targets_set(struct=
 bonding *bond,=0A=
> >               else=0A=
> >                       netdev_err(bond->dev, "no command found in arp_ip=
_targets file - use +<addr> or -<addr>\n");=0A=
> >       } else {=0A=
> > -             target =3D newval->value;=0A=
> > +             /* Adding arp_ip_target from netlink. aka: ip command */=
=0A=
> > +             if (len < sizeof(target.target_ip)) {=0A=
>=0A=
> this check is redundant, we already validate it has at least sizeof(__be3=
2) in bond_changelink()=0A=
=0A=
Check removed.=0A=
=0A=
>=0A=
> > +                     netdev_err(bond->dev, "invalid ARP target specifi=
ed\n");=0A=
> > +                     return ret;=0A=
> > +             }=0A=
> > +             memcpy(&target.target_ip, newval->extra, sizeof(__be32));=
=0A=
> > +             len =3D len - sizeof(target.target_ip);=0A=
> > +             extra =3D extra + sizeof(target.target_ip);=0A=
>=0A=
> len could be < sizeof(struct bond_vlan_tag), e.g. it could be 1=0A=
> (see above my comment about tags len)=0A=
>=0A=
=0A=
 The new check in bond_validate_tags() should do it.=0A=
=0A=
> > +=0A=
> > +             size =3D bond_validate_tags((struct bond_vlan_tag *)extra=
, len);=0A=
> > +=0A=
> > +             if (size > 0) {=0A=
> > +                     target.tags =3D kmalloc((size_t)size, GFP_ATOMIC)=
;=0A=
> > +                     if (!target.tags)=0A=
> > +                             return -ENOMEM;=0A=
> > +                     memcpy(target.tags, extra, size);=0A=
> > +                     target.flags |=3D BOND_TARGET_USERTAGS;=0A=
> > +             }=0A=
>=0A=
> else if (size =3D=3D -1)=0A=
>=0A=
> > +=0A=
> > +             if (size =3D=3D -1)=0A=
> > +                     netdev_warn(bond->dev, "Invalid list of vlans pro=
vided with %pI4\n",=0A=
> > +                                 &target.target_ip);=0A=
> > +=0A=
> >               ret =3D bond_option_arp_ip_target_add(bond, target);=0A=
>=0A=
>=0A=
> I don't see target.tags freed if bond_option_arp_ip_target_add() results =
in an error.=0A=
=0A=
Adding the kfree if (ret).=0A=

