Return-Path: <netdev+bounces-159681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3169A16600
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 05:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A731169A32
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 04:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341E71494C2;
	Mon, 20 Jan 2025 04:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kbRcJV3T"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8708918EFDE
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 04:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737345758; cv=fail; b=qdDANZtSLS4+/FVytGhx7mVrdx1W9hJgvvgIOamaUZBHllmW/olhUpOns89owrY9efMHCBLPNAHM6CJhAnxk9cbKvtIESeWC6sr58QHI4w8fL81dE6+JdHvDjtIxqnwwpt4goB6gVz9BsU4YIM9YvG0CKQ12MkJlyOKZaSyRS5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737345758; c=relaxed/simple;
	bh=bBlp067GEhzFMhnQpbGQtBB2o0R/Fj6/BMCQ4oJd/fw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gRQjGRte7RadDkh+9zQFi8jxbB/W0rNHUesmXrooDt2jUeDqT3g2I++98FbxdG0NiCiUoVhnVY8wGCZo1rFHxmZQzE12CWpUA2BBdw+lGPXhOzmuN/SYL13bsyXEJ5wGq5+FhwzNbCVvtnx1EnzWcGyr4Gw4YAahRFbq81ofPBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kbRcJV3T; arc=fail smtp.client-ip=40.107.96.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2iiG3kR4i43VgBYlYIXghYV2kXdz8BnDuJT7efBX1jIPPXYBS9RNGZmR+LCGE5EWLKWvnTqjy+PwWpOSmFBxXvVFgTuDBClGCDKt4R4UxlAeIYkGB/w+rvuk9FHFdDJBayX2eFeRC9qubhA9wuW7gcD/A6ItorEGBAM1HCkGs74H5OvYwKYrcUPMlzGu2CMnkvVSvuRXSJn3wV5Kb7WbS6XYgUKXrGLbwB/GyGW9cTFjb6ErVRk3R7am6wYO7QgRXBb+OK14dOP28J9ojwXP8HiEV1sw4T1GjDm1mG4+DZNvjIDeI4ONzIrLGUZ4sE/uU1GDsbRKLWaXWKBOW7FIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8N665RbMrqkHOfp/eTPRR/Rz7DiUoNv/NbTMTNEEp5E=;
 b=wnHY45AoylIW5rnw87SznbfkDQ+1uWLTOhW82TIsug3iDMimICEh1KIw2I18lgq0fpLFYutAXaZvDeG0G0xWmw0yZLhhyY2YuF1VsqY//evAuHls9H9JO3/9HHJdiUMpye/vH/RQ2amegCayxnsuf4pp9fLNRaDTV04pHIsJpLUoBTtjsIR31c8hvYSx59j72luCEaR3lteezoX5A7R3OOgwwsH+odicu/Zvq+hnjMr5X7mT34eiL9//rvgrLMqeftJllAX2sRYI7lBP92eTM1w9yCw9yGgQoxZ9p/+di8HOAHQViW5YGZxANGI/vEpWdZFynoP1gtnwhqjlj8n9+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8N665RbMrqkHOfp/eTPRR/Rz7DiUoNv/NbTMTNEEp5E=;
 b=kbRcJV3T83Z6pKw9vV2KKn0TQJFGB4H1FKQJn/hUq2+ZLD9zl+d1iPuDMSnS0OX/oD/S2d4aoWjdKbwpt1LsS5I1CLRQasM9YzCPouc74MDe2D/Hd6Ouhztj3l/JLL8SmHf1pgwIWyyDkPa9GeqJnA8waFnKny1MrSz9IsdtbaJIcfoOJmZmRBKSz3zOOzc027lszHw19zNJWGvjx7tc5SBlqg5cc6cab/vqngFCNRpGp3HbY1daOuqE62EPEWWHlb6Fx1lQ2XKxNv2mXVb+yJduUxg54TZ+j+N8k4JLMENAbvswtzC8AQLfDAa2uEWvfTly6Pow45qz37Px0wTSzA==
Received: from BL4PR12MB9477.namprd12.prod.outlook.com (2603:10b6:208:58d::5)
 by PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 04:02:33 +0000
Received: from BL4PR12MB9477.namprd12.prod.outlook.com
 ([fe80::ff8:848f:e557:e7b5]) by BL4PR12MB9477.namprd12.prod.outlook.com
 ([fe80::ff8:848f:e557:e7b5%6]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 04:02:33 +0000
From: Narayana Reddy P <narayanr@nvidia.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: Clarification on TC8 Test Failures in Linux Kernel 6.1
Thread-Topic: Clarification on TC8 Test Failures in Linux Kernel 6.1
Thread-Index: AdtnMYDHzQaMSm8HRq2voYtFeojHLgDvgkzQ
Date: Mon, 20 Jan 2025 04:02:33 +0000
Message-ID:
 <BL4PR12MB94770BCAA854026C406F186CB0E72@BL4PR12MB9477.namprd12.prod.outlook.com>
References:
 <BL4PR12MB9477612CCED2AE0CA37D9312B0192@BL4PR12MB9477.namprd12.prod.outlook.com>
In-Reply-To:
 <BL4PR12MB9477612CCED2AE0CA37D9312B0192@BL4PR12MB9477.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR12MB9477:EE_|PH7PR12MB6611:EE_
x-ms-office365-filtering-correlation-id: d455ae75-ec1d-45d6-c898-08dd3907446a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?itXZyTK3y581ixA8zsLNMpu+akBMqtl35kPhe+mTF1hER2KgoyqsG/HbKFyl?=
 =?us-ascii?Q?WvLL/cLmkTY+16Z/z/rmso3iH7n4hHLHPEnHOFQQ1ZWGhz1UXHwa2CVIhXoS?=
 =?us-ascii?Q?NHT5dxbPDemmPguxzyT14C0mVYuB2wWcQ8ipAv1gxF9DO3EP0v0a5vH27bhy?=
 =?us-ascii?Q?oANtLi2IMpuh+9UD7rVZZgUXxmGyzZy1gphG4gtqjWCNKb2Ys1vVMSW8rSBZ?=
 =?us-ascii?Q?nnf7W0q66qGF/yZlnZ54oDDrL9jj1afhEgFIXFtlN8YBYPo6x1f9CHTFy397?=
 =?us-ascii?Q?Gr3yqFUFuw5DCQyEgCAic0kaGQaDyy0mX00eTtYKjrnAod+/RJgEDGmKw5MA?=
 =?us-ascii?Q?/9/3ZIY4tl035+EPaPo9GT0Hw8RMLv3C+NPkU8eM90/gUYyANAOPFZApbFtn?=
 =?us-ascii?Q?D4eCxwGp3lJ1Za4jiqgpcB1JxYyUBjmR9ZV6lB717uPxKMD040wknYIqCqD5?=
 =?us-ascii?Q?emJjBgeFUcoBQ2ear1kCIT+GAP4M/H1YgHS9fYySFL/r+1uO5AXg5odv/v/7?=
 =?us-ascii?Q?C92Y8mwa6st+FgZi7N6Q/Rt5Z0M1QwB7UDGGGpmUySbYLXB1xxgO0QNZwbPP?=
 =?us-ascii?Q?dLioLnH4G6/mcIZm5t1itNB5v1gczKyTsn2kVnIQbM6rTTIncEgElKa4gdek?=
 =?us-ascii?Q?puwcFDNygE5rrStp08uEa+/XxMOxWqQDe9d0hi8+PV9vq4QVdQX0fyDejU/w?=
 =?us-ascii?Q?+H3jfUjRv66lXjmFVeScSWQgpgERSzC7nsX7rJv8nC3/Hx5f247bSbAMIS90?=
 =?us-ascii?Q?Wv+GxIVEursCIU2Q402BNPBuE4vzk0QRrx1YOhdfnWOtkmtC7+og45tZIqmQ?=
 =?us-ascii?Q?U9A+V6UXTFHqXCobXXqmPFhpdm+vtoGcb71n8pxg91wATUiPAZQH6VM99lfy?=
 =?us-ascii?Q?lTVL+QLl6ajfbQu4di7DJlg/oPsqvaDrI972Hr9lAUOY/pt03s1hnluXGkwL?=
 =?us-ascii?Q?3NU3AccglxE7kBQ4zUl9O/xkfGw9Vcdulxz/j/9wg2oySTnBerudPPVAPkv5?=
 =?us-ascii?Q?BpY4CHXvds8QXxBebnYzrebBAMRY5H5icuzY7dIQuKMh+RghV1PIRzO1sMKw?=
 =?us-ascii?Q?Oe9gzBkbLqh1sYMS4OrfD45I30/g1aT/riyrkVQcE8DLxoPyQF4LYhlCqP9O?=
 =?us-ascii?Q?8fgUspzfRjoau/5rzLnJ1eZmGc0zWUBM62ay7wfAzKo2DSMSoVkt+YEgCTy/?=
 =?us-ascii?Q?xjJJH4dSA+LRHdQe7hNnKvfyBgfuy3MFhtEXX34Y+EgH4B/7WHM2mtBidGQ1?=
 =?us-ascii?Q?cw+/jHln70CCYc9jGmGKtVG+/W9rEuqx9K8tzr6s0h85XnT3a0zGpQG/+wgZ?=
 =?us-ascii?Q?zdi66ShM6DD6D5n1YnLZd5lvYPE73JvkgSPReLnavL5iVAfnH+99XQ59tCDW?=
 =?us-ascii?Q?Zf0RPhHWLSvN103bpWugyBiNTPv5q94j4pO/OZGV1Yzh4uC/dCv6sdf5nE5l?=
 =?us-ascii?Q?eBvYA/82eBw+KDd0PlIu4VSpseKApwf5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9477.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lZY+QSiWqZy1QygT4qrOROchSP8Sr17GBrOVh9Hw+Pay1Z6+f05CiIVTW68y?=
 =?us-ascii?Q?8N5u7hKpzXRawps7Ud93tS66rZvaL+TfkvPbBrxzV9wgMblKZ6UhZBCf8HPv?=
 =?us-ascii?Q?L92ZQRri4x6bXFwFDlwOl9kJWV0BXph7ePqrEhW3grLdxE444hqT0u8SSNFZ?=
 =?us-ascii?Q?bkf5wgXFH/kyTvhjrJPJlEKw/WST5Dv5YKkVcuTw/GDNXnV8rsJTy1OQflDk?=
 =?us-ascii?Q?FWP7eqk9K0SOQ/EmGC565qm8Qbmft7WRaVqGKt4CGU1bJmR4wZhUFq9rNfDd?=
 =?us-ascii?Q?6b/V98bKlFxKAGVL28FaYIYmB4MJsy1fyfXdz5heLTy3odL/kuyLKY26mPmN?=
 =?us-ascii?Q?HYEkRzxIKjqXMO+jv1jgzVuqv3dAwLc3fCX9wAuA/8WMryel/kfY26iLoC4g?=
 =?us-ascii?Q?Cf9Xgbos2BWszYf3BqG0mL6bVMzyueLISwEdXqWzJl+fF2wrUvAj+WCk42tn?=
 =?us-ascii?Q?IHfsksP3lc8PZOCPmb0waEjLBUEqNk9SCBZPsN77D1o/Dq+UNHui6h4bhm5r?=
 =?us-ascii?Q?rq43MGSi4HX/koXW6HwAxVVngB0vvja//MnROQJNMGi7YNnG5sXKkQAUneEp?=
 =?us-ascii?Q?1Pc3DjnUnbmZA1amidZGRtbaR5MqPo6zOOqWXGb/JuPvnud6zNGzFI89m9Zn?=
 =?us-ascii?Q?A59vbPvrkW6Xdz9YUCjmpIGBKOt3nDoOCkci5sePjvOTvPuvFyl35zbUXJWZ?=
 =?us-ascii?Q?J/BoOGOeDxNywLopAdb9B2ZkqHse5sYwBxINt9WtKEIY2FQgkjP4YINoK9X/?=
 =?us-ascii?Q?NLhuYFcI4TgEwwCAxqIYTuk5gn67m6j5Ba8aCReg+RODcqeguIM0XSq+mK8q?=
 =?us-ascii?Q?QqCRdy40Uo1tvuzEY/SicNFJNI6Rm46uiSOS+TZorv2UWQLntWx/5r3ijjo4?=
 =?us-ascii?Q?6Vo+/I6o3mitZY9N5uCfk0Mgs+CfiHf/MK5vOGj/qOQqxAuZ59qznKTPVvH2?=
 =?us-ascii?Q?5Auqr1PwKo9ruhM6rvdhWb/nKmKybwjZQ5XA2flB7gTcoyQmTJLfCbYjzD+t?=
 =?us-ascii?Q?7XsmkSkLNCD24XtDxCQFVPegYhIWc7nSJ4YlpGSqOKH/QEXJFm0DFzbur1rO?=
 =?us-ascii?Q?RIg9yqYGECkg5QU+nNakgi5WZo7FQL5SRLac5chns+nmMF4kqmVudZZ8nRlN?=
 =?us-ascii?Q?NjcKadux/3zqDrys00EHCTmeNumR8Kzv42o52HStHIMOeFH4LrLMjq7ZKuCl?=
 =?us-ascii?Q?2w22/SDtf9ccG8aw13ZYqemqSaBpMpoVG9AlFDwxa5Gf/rRH5ofH5PKUYunS?=
 =?us-ascii?Q?WyTm0JGHIqZpEqcNtSPUaiqdrDX3Gk9hL7G1uI3cdLvZbHAKtMyudCXhbphd?=
 =?us-ascii?Q?oV20OyZiatjPAoAqkdT7YqTOyIvZhUnas9xJM0ydVJVRSMvi4XvLdbtWCgrN?=
 =?us-ascii?Q?PaIaK8egBMaDVW4dpjM4K9O96LislPgGs6O90iV/iRaT6Wat/c0VtCJSET3q?=
 =?us-ascii?Q?fUeNjEiDK2ZcEi53BUNQP1cZymgJZg02UEqMFQSCaaEE5UEQxp54ddHFVfR8?=
 =?us-ascii?Q?aDb+YQH751XkaX19tLxZIAFSMfFKso6aYbfOUpWwBHGC4R+wZrR6zd6HS/LL?=
 =?us-ascii?Q?279+3ynstYLDlVJ/GMCt/QTIBmD7Lresb3587TTT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9477.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d455ae75-ec1d-45d6-c898-08dd3907446a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 04:02:33.1507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vRf8Cbw+m9WdPF9Cx5B65pf3AdRR0pj7kLKfnQsO7M2mhCswKqCzfrlgReazOPH6pfzc3+H/4tF3p7ISdLmLAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6611

Hi Open Source Team,
This is a gentle reminder regarding the query mentioned below. I would appr=
eciate your input at your earliest convenience.

Thank you!
-Thanks
Narayan Reddy

-----Original Message-----
From: Narayana Reddy P=20
Sent: 15 January 2025 15:12
To: netdev@vger.kernel.org
Subject: Clarification on TC8 Test Failures in Linux Kernel 6.1

Hi Open Source Team,
As part of the TC8 testing (test cases can be referred from this https://op=
ensig.org/wp-content/uploads/2024/09/OA_Automotive_Ethernet_ECU_TestSpecifi=
cation_Layer_3-7_v3.0-_final.pdf), we are validating the test cases. Howeve=
r, the following tests are failing, and I would like to know if these failu=
res are related to any known issues or expected changes in Kernel 6.1 due t=
o any of the recent enhancements for corresponding RFCs:

1. IPv4_REASSEMBLY_13: IP Fragments overlap check
	Based on my analysis, duplicate fragments are being dropped in the kernel.=
 I attempted reverting the change mentioned in https://lore.kernel.org/lkml=
/20181213112748.GF21324, but it did not resolve the issue.
2. TCP_NAGLE_03: Buffer all user data until a full-sized segment 3. IPv4_AU=
TOCONF_CONFLICT_10: Receiving a conflicting ARP packet
	Test case IPv4_AUTOCONF_CONFLICT_09 passes, as the device modifies the tar=
get address when two conflicts are observed.
	However, with a single conflict packet, the device does not respond, leadi=
ng to the failure.
4. IPv4_AUTOCONF_CONFLICT_11: ARP packets containing (Link-Local 'sender IP=
 address') rule - I
	As per the test case, the ARP response should use a broadcast (BC) address=
, but the device is responding with a unicast (UC) address, causing the fai=
lure.

Additional Information:
All the above tests are failing on both Kernel 5.15 and Kernel 6.1.

Observation:
TCP_UNACCEPTABLE_04: [established] out-of-window SEQ/unacceptable ACK -> em=
pty message with SEQ [established] This test case also failed on Kernel 6.1=
. However, after reverting the change introduced in https://patchwork.kerne=
l.org/project/netdevbpf/patch/20231205161841.2702925-1-edumazet@google.com/=
#25623591, the test passed successfully.

Could you please confirm if the failures for the four tests mentioned above=
 are expected deviations for Linux Kernel 6.1?
Looking forward to your insights.

Best regards,
Narayan Reddy

