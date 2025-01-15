Return-Path: <netdev+bounces-158446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919ACA11E57
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C573A82B1
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B201FDA73;
	Wed, 15 Jan 2025 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZVrdIkbD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593BF22FAFD
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934144; cv=fail; b=SjrYKBRNIzG64Z3pp0HYSkbuVWQsbQo0DN+LoxqxOYwCqjMMgmeOvwSu4BEMgrqS4cT/cgk0iIcscA1O5/seNQU9zSKZysKv7s9l16+gx5YkrvMRrsRjxFXOm1XXNISHO1f/C5X+KoG3Gqc0pwoxdWkVm7gydiH2SSLiQQyHB24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934144; c=relaxed/simple;
	bh=+h4JZDPSdJDPbjXQE88ArGNnRtSb/1Mv5fXfx1nU+DA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oSluLuJZ/ZzFnEw3dbBar1ZwObdiptjiyPVvLqvhE7d2bggofzw3fHdLSMQgr5QkpK74iXcg1EUEs8ZEugzA/HyGAlfoyMEhk8OUI7RPcrn/qwRxaLIBodqXlmxmeJb9yIiSwDSyw0IvnZaJ6V4L8FhUCJ5goLeTVh2uA8JWQAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZVrdIkbD; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRkstT+/ffJHThM5pOOS7S2mG0PlIz2AD22fp1CHyZonVMDyzZ14c7YDWJwn5sgmLGarxw1LJTlXC3tEuc5v4LPEyABMJepC6CbA6VlyKhCUyi4zY2Y2VVn4OqNIGUCgJ9Ag7gljRMEqBdqJK6BFuVynW+tjBWLNqeTFN2ZHAdWfhgIcceKmZ+KrsmxZwSLYTA1uiHqxQiNVK+l83wLwxTEiA7vPWocA5uqi+5KbXqETG9IOynrJ5FL2N+nWPYhCfzbz1Q+1db1MexMuVuQAHp89G3XTn0Uoa5chQVxOmaYThQtXnYF+Xau4bTjyJnaXrWSG185o7IPy7RU+0FIGvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwLKsItLuG8OmjSuuZR9LXSs3rKITDVzmgxoWnUqIv4=;
 b=CvWLsdDxDIX17LCxvJaYpl+GQ8ji1k0g8tXtxhdXIaMQA06bc6UvKJlVG2vI4U/HUbNz7Or67gTgAgAqzC+uLNXtocGbIvWCFKSvGwxiCDtxOavNl71bUMak2fBDto1ODo6j2549NVU9+JE8RJVkksxwU4c1OI1iAzuznPydZTzEtg2ijKNCWQ1A7X+dwUeSYRIfsJw29YxmEPjj1jXlAYUn9QdewG+56MFj9rwvDAg0f81vhvJwSpi/GEwnqA70LMIc+IVKzhFKlajXNWnhW7KhmxogOoRzFbbhLniCaAShI/2pOfjOJfZRigxxuTAJL+WoTJsWEF/k06EnLP5bgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwLKsItLuG8OmjSuuZR9LXSs3rKITDVzmgxoWnUqIv4=;
 b=ZVrdIkbDSYHfsl6Ce6hvJqXzeQXvZosm3zFpxORf3wn0G8pTdQCK69e9oTrmBJtUPM+6vU250U5QgehX3xPkD59JMsJvmCkdiHPCtxzajnUdQelq8gIPx7rIobF7R26w5W89hGvF+5fCVEL/U6XNjYReIGbe7z8YQbX81B7BQVKcNVQnTHVR6rX7n2R6em1NVgZ+IgriM6ZhwkbSm4mj7eXIFIn9g6rBZ4r8xpPpXOGi9kgil0iYkyMX8GIoV+W3Yo64eqOeLsjLKpAKiJU0tbRLWfNaVnUqp4vVMs+Ub9n5z5hX7By6cGfI+TAhCab4yhPrdktaPo6b7jaVhqF6jQ==
Received: from BL4PR12MB9477.namprd12.prod.outlook.com (2603:10b6:208:58d::5)
 by CH3PR12MB9432.namprd12.prod.outlook.com (2603:10b6:610:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.21; Wed, 15 Jan
 2025 09:42:20 +0000
Received: from BL4PR12MB9477.namprd12.prod.outlook.com
 ([fe80::ff8:848f:e557:e7b5]) by BL4PR12MB9477.namprd12.prod.outlook.com
 ([fe80::ff8:848f:e557:e7b5%6]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 09:42:20 +0000
From: Narayana Reddy P <narayanr@nvidia.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Clarification on TC8 Test Failures in Linux Kernel 6.1
Thread-Topic: Clarification on TC8 Test Failures in Linux Kernel 6.1
Thread-Index: AdtnMYDHzQaMSm8HRq2voYtFeojHLg==
Date: Wed, 15 Jan 2025 09:42:19 +0000
Message-ID:
 <BL4PR12MB9477612CCED2AE0CA37D9312B0192@BL4PR12MB9477.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR12MB9477:EE_|CH3PR12MB9432:EE_
x-ms-office365-filtering-correlation-id: b4ba9ea8-21c9-4fe6-0144-08dd3548e7d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AV6LbGeCtaGCrRFnnncPdCl77Y6nS59TrXPZ8Y+X0Gk5i7t0gW5BMDBKSZ/T?=
 =?us-ascii?Q?u6U3OOf/Q3xuvnpzydDg/H+yRpTwxRzafwsSMfRSborztDFCG/6i9HSGnT2f?=
 =?us-ascii?Q?N2dR8lpc4Jpi+f2bpsk9o7KhqFhHdbKfggmvLT/cX90QyLPanTK1fmB2mvXX?=
 =?us-ascii?Q?MjPsF8MG024DNLFAUXC/bUIwMa2KwgWB55zW9nFIRIuBTjL0ojO6D9YvL51P?=
 =?us-ascii?Q?lXzo3HM7uibR/byu9RZtzXd/ZyGEd7J385hpB/gHZD+Hwt83SIdxWGDkgshQ?=
 =?us-ascii?Q?/IVs0Vu8o93GbQ/3YTvElCILtaT7pPa0069aEg7Gb1SVjFjoeRTEvmhYLRc8?=
 =?us-ascii?Q?s7/Fonu5N2vIUU2t30TUhbL/PwzO4FK00vUnxEjF4yQxR2Ppt9uFGOF4NU2l?=
 =?us-ascii?Q?W57xY+xc6jxbh38l361mjGe34XmrmbU1bVeVGsKFOKyE63xSE6JLRCZw9zYC?=
 =?us-ascii?Q?kK9f7ptJemDCcZTF7ynXczGf5QIfa+o12QRCxEt1zPWwbNYhznvCf+7q1qoZ?=
 =?us-ascii?Q?KVhazsu2BgO/eSh9BBLK77Ehxe1eiogEO/28blw2aUZmvABi0+fEQsjUBfZ1?=
 =?us-ascii?Q?2+/6uUDzQKkrykVD677nbe02WFIFKglKtTUmM3KxuIjVDW9LeTrmJIodlMHK?=
 =?us-ascii?Q?WU62qQHeimcNTumNTe9W4LJziYdp4sI2Rh1R2EHNgaKAQ7FeMw9e3LsWjFvf?=
 =?us-ascii?Q?xLIBHenmAB9qTTFyg7ZYdNeytcx7gV3wxrsbko1KpiG/i4ZHaX0p758OEV1g?=
 =?us-ascii?Q?p16feHZ+8X53IyNFxaFw42lbTZvudyxpr3YFDJ0TqG72iENGb6G+3z217wY4?=
 =?us-ascii?Q?D14yinZDszEQCMYbZWcXAt2wDqQFCnQFHkXgBNWh1Ee/MmLk7V6l0v+6IaWw?=
 =?us-ascii?Q?rJKyocSy0muNTjGpSsSk8pafc/EawBzgYThcVtAokEcQiQ5z7rxeGRYCFrZB?=
 =?us-ascii?Q?U9OHyM0yvHGOGQjacFUoB8ZCmM8XSwtin/XkdAQDnHMnDO6zWWNOI8e18WYF?=
 =?us-ascii?Q?5L/310DRnZimpf+aH92P0ZGsXnj5G+B6vI4EcM3tR14NnzTi2wmmRuvqduJs?=
 =?us-ascii?Q?z4XJn4mohXECRVtbkENNIQuNTO3tj2DPDXgm9rFsCmD7YdcPK813rAEZd60O?=
 =?us-ascii?Q?jCWxjIfedFJqElcsVYz9APu+ZJp0TvQLdSwmUzQ1hWx1mNcvSSq0aAdyPAJd?=
 =?us-ascii?Q?clReg0rqQALRnJej9ocCwOSb9lEbVD7VHMNu3//tK9ydbu5WNNL/n7hWz3r7?=
 =?us-ascii?Q?khHd2MLxH+eAhpvORAHEOrw4vZta8UtSp8P9+bdL1S9YBm8fcmfodwCmZwfq?=
 =?us-ascii?Q?kAPBRBFp1Kt+42xu+c2k1u1Uo5K2nJsAsGAv0ooQWlut9XvbBZyCLR1ieCOD?=
 =?us-ascii?Q?GPBsXqcYxRGfYC6JnVV/Bj6S6054QHJ51DC7e8kHEdejt3/ccSnFP2NDFHe+?=
 =?us-ascii?Q?aouw03BekXQUYRKcXzggZ8Eq+26SUFhW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9477.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KG/15Yb+fV/Ci8JGYkgHCba0y4MnrF6Qw2OucBuUCggfbbi+sWx7X7UKQRJ6?=
 =?us-ascii?Q?T/fl74gTO1S8BNdR2m32EekVPdQK5REH066b2n7EMm6xcv8EnxIk5Y4DnyUq?=
 =?us-ascii?Q?I4UYjEZubdrSETT8NJwMsws8eiz6cw/JDWJOB4mjPp4agAVdtzh5CzUTb3BW?=
 =?us-ascii?Q?jOs9Gn9GGBz+4kO9WAmSFh5lk3tLcOfeX102BXrUN9y9iGLL/+CxJVVLQYL+?=
 =?us-ascii?Q?IMEHalxspXI2qLXeKUidvHRE58wTdxhMR1Sj9i+hFfR83NQRdFydeilD8B2q?=
 =?us-ascii?Q?/A72Y0H9eQStTCROQz3hkpAEuIHHFOt1HjP0Q6BrG3ddhR5s72m5N/lq3FHb?=
 =?us-ascii?Q?9UeeeJr3riaI/+qzLTxfsl24PyF57iOLwkf0N+XFzCShG/j4PugNzowbtm1b?=
 =?us-ascii?Q?ZkZ7hxzgRz9PvSRO3D/1XaHvRgTzzfmyb5x+4qmouLG3UI8mrJD99pJBP9N6?=
 =?us-ascii?Q?Nx//8icN7REljxXsWZIAbVosoCxByeQ0Y9JXbi1+HiQ/kq6vaSsoa8Ww3iUf?=
 =?us-ascii?Q?NZkcUOgk89yv/lsYdKECMMxVrbEZ2wwW5sUnZAHn8SKdmBmRU+QxrjaSqxtW?=
 =?us-ascii?Q?JzDqn8cFjNgAeRFI3D1etjoNwm8ri0+gIR1Cq1MrRxR0mh9u5tviVuW0ZEUO?=
 =?us-ascii?Q?GHtMOO1713bDXCj4P319c26GnPVgeSRLnPF/Z2nD+T+HdO9COL86rpKHHVKv?=
 =?us-ascii?Q?M5NCTBTFhjS7KL6uLEBpwSJUXjsVsUe79tt9a78SIMf9g19kB9He+hWsyEzp?=
 =?us-ascii?Q?Ct49VxqO9wOyqClsx3cfnq1bwg1EtSaBpRn+tgVWspJsOebH516tWkUE+QBv?=
 =?us-ascii?Q?/3ESBJZmsWRZXgfrAXYU6AXHN4U+8mazzSHsPCAUlWDOuU7zKK5+dFDjTzrh?=
 =?us-ascii?Q?sTs4npe/kDNycbcV1vQQshtIiogYFDK0987aZC/DkFc8zBFBQWmHp/iLlmyM?=
 =?us-ascii?Q?yN8/bDfHpGzbWeKZnLW2TzOrSw/4wcLO2tHdMJTgsBFMgBXHj5YHI8ktOGH6?=
 =?us-ascii?Q?YBD2DvceUPtmJ8Kx+IameFJ/71oQWN3m4QOfteFkR6jODWGOuZxXcNO1qALK?=
 =?us-ascii?Q?9IFIjqDGWaCOQBD55KG4s3pFHPZkXVDp6ofAPL1F9ErUq0zvdgWzDfIAdYRS?=
 =?us-ascii?Q?4qhBEd2f7xbzmtfZa2z1ArdaCRF1n+Kqq0VbJcN/FaT0reqhTehd5Ip/UL5A?=
 =?us-ascii?Q?1625qsgrY1nRTDWxgpNBoSluQdMArmYo/eFd1bIGWMupB3vMWYRBv8a0f4VP?=
 =?us-ascii?Q?X6qUGm0wtR0QnRFiUQSgamJhURAsH2rhJtwcGjXnLnMYizC4TlU0brjdhtT9?=
 =?us-ascii?Q?FTP3phLyLc5aQPxEVST1ruJase66aneLXq/hSsTHwyufDFXOo9UyGIXxx5D7?=
 =?us-ascii?Q?lKdyLVsqDhBbcc0y190K5KNFJM8u3lGsVVgGP/lb78qraYjgXxPeVM00qqjf?=
 =?us-ascii?Q?aOVF3IS/ddvh/NHucZXgS+fATrhJ86SrhSdzZeYUxHojDAXBJd+u3BjyL7UO?=
 =?us-ascii?Q?VD6mtGxexcAPcJ5nENSVFnuhvhSu8+BU6NfKEBl2yrDROI4+f+o1DEAkbBV6?=
 =?us-ascii?Q?+L+uXu44fpRjwPn4WJeauajnQa4lVPgwXsRUByV2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ba9ea8-21c9-4fe6-0144-08dd3548e7d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 09:42:19.9923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kyrtOj4+ZMej19KLS/0f1EREM5+ICSs3SEhmupVGALDPlTYUNaJbD8YlNLBJnQ4FUT/yVBZoGe/c5yuesPugVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9432

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
2. TCP_NAGLE_03: Buffer all user data until a full-sized segment
3. IPv4_AUTOCONF_CONFLICT_10: Receiving a conflicting ARP packet
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
pty message with SEQ [established]
This test case also failed on Kernel 6.1. However, after reverting the chan=
ge introduced in https://patchwork.kernel.org/project/netdevbpf/patch/20231=
205161841.2702925-1-edumazet@google.com/#25623591, the test passed successf=
ully.

Could you please confirm if the failures for the four tests mentioned above=
 are expected deviations for Linux Kernel 6.1?
Looking forward to your insights.

Best regards,
Narayan Reddy

