Return-Path: <netdev+bounces-231334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2731DBF78EC
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 18:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE811886EE1
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 16:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8E22EE60F;
	Tue, 21 Oct 2025 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="syoXdmjm"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6C933C52E
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062438; cv=fail; b=M8sM5gHQPKU7isGiqGJSOFrTnjETQ6BYUBejeNOk2AuSVPmIBoc5R95UvEJRYKObQKWumjuZYQY7bD94LKdmGTpugODcmtV5zWhZc8esZDMrKPZyBBUN8kBkjjIMGyPJY7pGq6+IlcoK5MgWz+s/knEp9ECgV0XEXs0iyRr/jWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062438; c=relaxed/simple;
	bh=fEo29uis9HzKDvVxAe+JM/0JxbWFUrP6wldAIt1iREU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=WQrDbEa/gACUaEDReEqT4C4rRch0L5p3M94HHh1Vq604B8Uz0xmDZ9XYlUu9pYRXGI7HCLLYQEUvuHOyDjyZoBqi8s/RfRS+/d/QMo+hEbNbLOkG9WlSVvPOkskFJT1xrlWCjKGCbmYnPUlLfq4gxCq6he3dR+Eh2xNl1FNRErM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=syoXdmjm; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LBHPIT020537;
	Tue, 21 Oct 2025 16:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+Rrp+6
	sUPjK3nY/sSg3/8eXNoNAzKA3Izv4KhKugfo4=; b=syoXdmjmm4fhH0ZienzGGz
	ecxIzIL6hJ/QRSAwi7XL+kfo8G/iyxJPuO+oiqZBWL783rwAXYVs+zq0+FQl03x8
	Bz37LYIbXDzCGgucCIOUdoCDfO+xJcB+24SeRcvQujDbMUE2zU2uUIE9br15zzxM
	FqTKNKo9DLGNbDb2xXagBthh/128US2mCCRF+jnXPYcciPWaR83ju0wLBgDTSpnF
	9qwBAgOFTUWsCbLCpXnbxzBNyNIHpptFzyxELftOwS5vRUI9OGPq+C5MZQvOeEOa
	rDPDzr/GfFCECWXUpvIMovX1wsumRC3fdlIqafwnawLeSz3RTB8f1HX8Up2aYhFA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31s00j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 16:00:19 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59LG0IlH028577;
	Tue, 21 Oct 2025 16:00:18 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010055.outbound.protection.outlook.com [52.101.46.55])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31s00j1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 16:00:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjwRq3TRMZMitdEZsXOpa4lSXcR+ejqKkXHQFzrk5JikRCgxmTVS50AE8OpCkYms+bP0jl1Stn56dfUkr3TCFq0WnIkntcvmnmVVBL5eZa/ugT+ejp0gfsqv6cdDhTU6qWcj5CKgy5Kg043p3F/GN7QBXsh5oP5QXQUZhmT9XDtECxllkJMnvubiL80wAMWFMQZ8VmgejrbAapA7/p1p4FzDRYBkhlzgQhwJ3w0pThaI04Ckp6sDsL8QjEeE03sji+vmjrtbaBQHOj29a5Sg4am1RgtQI4WB9qjno6Jvs5BMMwadY9uiOWFjZKxHheCdcP/5MQjl7U8s8Ja1PXMitA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Rrp+6sUPjK3nY/sSg3/8eXNoNAzKA3Izv4KhKugfo4=;
 b=xYtR6mZfFl4uLH37x+vPfIFjFZNzNrC59yLZmzPSor5jSXNRSleVnYGJ0bERCPxJhPm/yVE/StzG/7CbPqiR0ghRLcNEf5s4lXPCy/bVDQdfwaG1L6UPnSMpWymwIXiZlRQ4whGfZdTwF7XVTs6+cvVXPUpAtSwt4bIeygSocuDE1/YM4bhz1zVa6HCdyWK5QFGk03ZIz8RuSERfCJ52p0MHySAtqtcZw9gsFzafBp6y5EPKGXC3DfNVPtlj638vmYZEMec1O67CIRYx7ULk/cA+QTnNOsdoqsC0QR1oaxxUrWYn0kYxsC4zQiEYMk7rhkMueJPNXBKa92TWQ014iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3913.namprd15.prod.outlook.com (2603:10b6:303:42::22)
 by DS0PR15MB5904.namprd15.prod.outlook.com (2603:10b6:8:f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 16:00:15 +0000
Received: from MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490]) by MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490%4]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 16:00:15 +0000
From: David Wilder <wilder@us.ibm.com>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "jv@jvosburgh.net"
	<jv@jvosburgh.net>,
        Pradeep Satyanarayana <pradeep@us.ibm.com>,
        "i.maximets@ovn.org" <i.maximets@ovn.org>,
        Adrian Moreno Zapata
	<amorenoz@redhat.com>,
        Hangbin Liu <haliu@redhat.com>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "edumazet@google.com" <edumazet@google.com>,
        Nikolay Aleksandrov
	<razor@blackwall.org>
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v13 6/7] bonding: Update for
 extended arp_ip_target format.
Thread-Index: AQHcPJyjleye9we4VUOHrCeB+8OXEbTErQUAgACFoACAAD2pHoAHVm95
Date: Tue, 21 Oct 2025 16:00:15 +0000
Message-ID:
 <MW3PR15MB3913D2F92582A3FB369D5FA2FAF2A@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20251013235328.1289410-1-wilder@us.ibm.com>
	<20251013235328.1289410-7-wilder@us.ibm.com>
	<ef443366-f841-4a84-9409-818fc31b2c0c@redhat.com>
 <20251016124908.759bbb63@kernel.org>
 <MW3PR15MB3913E83123930C417DDD1AC8FAE9A@MW3PR15MB3913.namprd15.prod.outlook.com>
In-Reply-To:
 <MW3PR15MB3913E83123930C417DDD1AC8FAE9A@MW3PR15MB3913.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3913:EE_|DS0PR15MB5904:EE_
x-ms-office365-filtering-correlation-id: 6043c035-0740-4b47-f32e-08de10baec9c
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?d+Dll5GvztTDN7KBYrX6NSCAxvWLWRf4Y1P8YcG1YfGk1aW/GQKfQR+Ikv?=
 =?iso-8859-1?Q?MDHOERgkBazj5xh17sLtqvTejkpXX2O2h/UNMnrojZc1UA0zWK7WsIubv8?=
 =?iso-8859-1?Q?Va7mEGiffhsQje8YCHqwSrXu0ZssxlZW4P9nLy5BbX0gDN04N4l2EE/QA1?=
 =?iso-8859-1?Q?Oibz73V8+7Wi+hkBQFzvMvS3l6RDQ6+qUIm4b37riUh/ekjbJex+ehkMjY?=
 =?iso-8859-1?Q?RU8IWG1ZvAy4KJsjse+lpm2tfR5ICt5yUiQBQnBG+ssq8YGGqNt6E4GWI7?=
 =?iso-8859-1?Q?RkwPUJ55/e8Bt7hDf8lxqJ1CKR5cGO86iCrJ5+e1hdUOx6EfBKXSW4BJ6R?=
 =?iso-8859-1?Q?aTezHtV/HLCoRlr2B4/fG2rlufN/YXhuiwfnYLGY1BhQP9pN9ujIEq6R+O?=
 =?iso-8859-1?Q?7Ud1Kz3KuWHbNeLCVR/ZFg34ajjJQlm3QuSk1A2OKeinlG9o1BJmDbJYGm?=
 =?iso-8859-1?Q?sGg5awhB00QSXH4vj1AnYkncDdRQf9DEaCjmXBfWEUmdwso9213ByQyWnq?=
 =?iso-8859-1?Q?7jIwjLay72MrVVf0nRp7Ee87iG6sYvpdv3RxUrr3HwALzUtwwRArJkmRQ5?=
 =?iso-8859-1?Q?5wFNQMiaAmOsgL8EBplkaUmuVjcC38Z9hngGCC2mT3N9OsnR4r09C6fsZV?=
 =?iso-8859-1?Q?BkKdCB+EIczIDSkK+WHxSkVDQB28ujjPBLZ2tKABphePGwQFL8hk7HpG2w?=
 =?iso-8859-1?Q?Q0T4Z+BLAm8cil0Vuk1wk5dXdk/PEolOvsKIxcoPIOvAvG751PvO7k57Qf?=
 =?iso-8859-1?Q?e7+K1ovP1RQk9i7+sDv8kqqBrb3Rvq9IbAnn2u+JY1PT6aXXbfHYRoDBMr?=
 =?iso-8859-1?Q?65nWNAEpKyKmm5HkVs7YIZrO4XiRSGqhVGymbY6yg7Bw3HnY8GrtA95Tl4?=
 =?iso-8859-1?Q?bgJ3VT6+Da7p3xbGxrodXWfLgJqYvAdnRthN0lwCJJuOmRQywIdZLkRoKN?=
 =?iso-8859-1?Q?CI3xdyLqjpm7pUfO+xFXvBxh6EADKxxcOCRLOocr9V5RM6nLtAOXmWd4eJ?=
 =?iso-8859-1?Q?3cGvQXi+ZzaqSTKKgYTaaB+LFvYRk3lr/Nctf5TO9d+YrMgbrD/5iFJTV6?=
 =?iso-8859-1?Q?Irb0SZh+9QXfWSwY5Er0uhBoudlZwM+7mFGM3ZwiTARJxlMn1AJFEZmLfr?=
 =?iso-8859-1?Q?VdJkAgByKLLQJ7sZ/xpoXGRNt/vmg0jOdmOCARKSRGmHVEmViLTTzfsmym?=
 =?iso-8859-1?Q?gpHkobVGZQRQoKCEz/nIw6KoFmGGjIVJa/pL13VM949jn6oNSlaZ7zFz4V?=
 =?iso-8859-1?Q?QuZgdBB7k99XVhcyZhm+uyCiB0Jh0CJGQ+4b57bdpbdjwJbAYo8VRalBKG?=
 =?iso-8859-1?Q?OW2NCB4BEdokQJXATlbelYViNaZw+iaQd02tgVthU2Ld865/ULanSn68a1?=
 =?iso-8859-1?Q?9CdlGpLEx5w8awvxTvN8tZqWRKru3LSltG2jwTSC3OtB9gfMxP4Ou2wW1x?=
 =?iso-8859-1?Q?FbgKS1wmvFMqByGHbIiIIuNUvoJNmKIbfj+R82C+XsUwFUXjhcrhNXLf05?=
 =?iso-8859-1?Q?AdCyL6zHeThFwRiSRAiqgCElps5DYejz3VV5KMFpKYl7g849ymBhq9x7fW?=
 =?iso-8859-1?Q?sezDlJ9d2/rrQhlUetGmeGWsel/9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3913.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?8D87JiBznchRLCblOwP7JW/t2vMe6gCqLH+C5/NHYP36yicqqrxXorp+Ix?=
 =?iso-8859-1?Q?CXMjCjZaTQakZUnyVutNLHielVYYj4WcXkT21tRjSKzC3u9vjUYi+Nrjoe?=
 =?iso-8859-1?Q?1OZariboXJJmTR/Sjr+sAWRfDOBpxPr56L3rz5Qzdwc66OM6f3CJ94OX7H?=
 =?iso-8859-1?Q?nVDW3pHAo9PktY1CS5s1yGnoD7Q6Tl/zNZhNpwHqLlNvCR6Bn5i+Wb9bsl?=
 =?iso-8859-1?Q?1/qpsOv0p4qAmzz6PJhgzkNrH0jAzzbe5JNdyhd7+67bfc7W1QKqIywOzn?=
 =?iso-8859-1?Q?vYxLlG9XgL2ajJypc9qt79x1w+J77aT76RTKX8hEBRtws7vcwrGME0ifOb?=
 =?iso-8859-1?Q?jNe8/uiXyMPOo4qJE3iTDtSGY1mbcqZJnBcDQcGSPE3DVlsDUHghDXR3rR?=
 =?iso-8859-1?Q?m3ZCbkH7SIA18V8joOVNI4RO02HHvhqn+Dv49dRMNI2Q6CPxI41643wJ1C?=
 =?iso-8859-1?Q?KQjmR3xyiXBbYOBKEWWCb2PyLgKfEeJGg7TgMvAOxQyatSXyE1NgLFfQ3f?=
 =?iso-8859-1?Q?Amvj2vYuqjmEyCWgDTFp2bEWiYINKSz3kLRHmi34lJoHi9WmBdiM1k9vkw?=
 =?iso-8859-1?Q?xmFZkBuR/RxRMqhPVPsgAc98aD3FvIpj8zdQQwVUguVJNQjXm1oytRUL3i?=
 =?iso-8859-1?Q?NLg72qzbaYVW78x/k3Dj5Qne3L7LbcwT7O8/zbQ2bzeFi/gLzt5R6Py1Z8?=
 =?iso-8859-1?Q?+KMZSzqN3Uweb2XHMpUTwFqp44bK+OFYheTWLQ5UvoTOtkHmDxy4/3BHiQ?=
 =?iso-8859-1?Q?UuonqbsrnxXNh0BECRMXYeYHr4MloMZTxilbJcfZJGtfkfnI6f+l13ZHka?=
 =?iso-8859-1?Q?gluN7Ie+ejLz13lb2VIdLCD6F2uA0Ct/VmFQ8c26tbW10L/5F+ZU2zpdv+?=
 =?iso-8859-1?Q?IJCnO7uR1Q5H/aRZ8ob+8+kFJx2vw+hPiky++PvzEV44BzIK1EOj9w1bco?=
 =?iso-8859-1?Q?Khuw3YyiShgdv0e0dLNIBsXord+RYCEl/uFYDFIdHJaZzcl4QlRU1RP9W+?=
 =?iso-8859-1?Q?iRb+tuolyOJ2F9JyVfi2ROjPCppMyYznhr4gZRQJIT1uT6940bWHQzJnyH?=
 =?iso-8859-1?Q?Yrevi7WPWGIsl2R2kWjvd81MwERWBSNqdJ6diBayxpZkSS7EOqHisxX1X5?=
 =?iso-8859-1?Q?S1s3JA/dpQBs30NRreabO1KjgbfUcHGTqE7T1ktzJhJAcLd75Wq41Wg1OJ?=
 =?iso-8859-1?Q?a3TMckI63g8WCrr9m4h4RxRKIuo4GGTGs+IDEh9o9kX9iSzX83wnOL0J3G?=
 =?iso-8859-1?Q?feTVgiIVUiHiguzzbcelyiIxSYMbaOapntYIxVnhgxIQCVuB+MlVCLUPl8?=
 =?iso-8859-1?Q?bHCHJwIJ+HUL0l5BCdP5mNfSv+F1akMX9Z9I21KTuXvfQQuA9fxPuFHW1u?=
 =?iso-8859-1?Q?dp+XkWUBK2JP+oicxeY5VDijHq0xkC/bO8/OKrVXTAiwVCluO28x2nebaY?=
 =?iso-8859-1?Q?KKNJOPk3AhzA+ctQ2OifSdvF9D/a2j90o8fh3WCUV+whflX8JR7fBk2SDA?=
 =?iso-8859-1?Q?WRY4InBJZV4K1gEwm48pp1i5m4i/8tS8uwTj5ECGafaH73ZgOwfFAQpyCa?=
 =?iso-8859-1?Q?WOn6m/54sRtzVV5MaKXcaSa5PWcILTSGYLPN+Ur3Kd+2TAy18uoSEULyK4?=
 =?iso-8859-1?Q?dOKvOqTz1/HpJMjvQgGzOb8qlPhZT9H8glNNAWQDTvz5vihRWZbTIyPhmn?=
 =?iso-8859-1?Q?3CtddEWFQXMjNyfcIvM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6043c035-0740-4b47-f32e-08de10baec9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 16:00:15.2535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x5TdobbQzbm5nsrGHCXpyQT62wUn8mKgR5W8cjrXhRdu2+iei1f1lQurNPiD6+WHHrlsntEKq38sESi2q0SOgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5904
X-Proofpoint-ORIG-GUID: h2ZYu3D61LqL4ticewN-9JpXP87ple6y
X-Proofpoint-GUID: 23wxYPN9yrItR3CAuVWU1qGXaOM14Y3G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX+UZkkrmg8GfL
 /FsRK5VamaGlKkDoqNS8LJyzLqqj5QBLZvDEFer2TYtjwdMEnQhXFN3ahTGyhdXwrTv6Dznjs4V
 K0K7vT/G0TIUrCe4zBmQlYsQ9eTBHn3CVsSOxLS+h8aRE3aZuxW5HVyIFFUUA47tPA23M2TL9zI
 QF4jlO0AOUv8BdfClmkwpV4cL7slFnBDjzflyAnoFPLnDgkIDiPj4jUYXE1aJpzfGvrfxL4tJtz
 clZvNheY3DJPON3AcO4oZLFu2mtwenmK35F76J6cQQYdXN+Z43I/98lTQTz3HCtKXjdys4GUWOt
 l4SAyvTWLPvDtymHfftGk41Bfth233wScm7joq8RWkrxHie0SE026y8qBhgf0YzOgVIgYBIqLzi
 JGZYHyfW8b9FXGmnQzU3bskt+/o6tw==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f7ae13 cx=c_pps
 a=gGLfFga2G+uCUFnDxO+Iyw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=2OjVGFKQAAAA:8 a=P8mRVJMrAAAA:8 a=jZVsG21pAAAA:8 a=1XWaLZrsAAAA:8
 a=jFq_gwtVQDHxNXWrUSMA:9 a=wPNLvfGTeEIA:10 a=IYbNqeBGBecwsX3Swn6O:22
 a=Vc1QvrjMcIoGonisw6Ob:22 a=3Sh2lD0sZASs_lUdrUhf:22 a=cPQSjfK2_nFv0Q5t_7PE:22
Subject: RE: [PATCH net-next v13 6/7] bonding: Update for extended
 arp_ip_target format.
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

=0A=
=0A=
=0A=
________________________________________=0A=
From: David Wilder <wilder@us.ibm.com>=0A=
Sent: Thursday, October 16, 2025 5:21 PM=0A=
To: Jakub Kicinski; Paolo Abeni=0A=
Cc: netdev@vger.kernel.org; jv@jvosburgh.net; Pradeep Satyanarayana; i.maxi=
mets@ovn.org; Adrian Moreno Zapata; Hangbin Liu; stephen@networkplumber.org=
; horms@kernel.org; andrew+netdev@lunn.ch; edumazet@google.com; Nikolay Ale=
ksandrov=0A=
Subject: Re: [EXTERNAL] Re: [PATCH net-next v13 6/7] bonding: Update for ex=
tended arp_ip_target format.=0A=
=0A=
=0A=
=0A=
>> On Thu, 16 Oct 2025 13:50:52 +0200 Paolo Abeni wrote:=0A=
>> > > +           if (nla_put(skb, i, size, &data))=0A=
>> > > +                   goto nla_put_failure;=0A=
>> > >     }=0A=
>> > >=0A=
>> > >     if (targets_added)=0A=
>> >=0A=
>> > I guess you should update bond_get_size() accordingly???=0A=
>> >=0A=
>> > Also changing the binary layout of an existing NL type does not feel=
=0A=
>> > safe. @Jakub: is that something we can safely allow?=0A=
>>=0A=
>> In general extending attributes is fine, but going from a scalar=0A=
>> to a struct is questionable. YNL for example will not allow it.=0A=
=0A=
> I am not sure I understand your concern. I have change the=0A=
> netlink socket payload from a fixed 4 bytes to a variable number of bytes=
.=0A=
> 4 bytes for ipv4 address followed by some number of bytes with the=0A=
> list of vlans, could be zero. Netlink sockets just need to be told the=0A=
> payload size.  Or have I missed the point?=0A=
=0A=
Is the concern here the variable size of the payload?=0A=
=0A=
I have updated bond_get_size() to use the maximum size of the payload so th=
e payload allocation should correct :=0A=
=0A=
+struct bond_arp_ip_target_payload {=0A=
+       __be32 addr;=0A=
+       struct bond_vlan_tag vlans[BOND_MAX_VLAN_TAGS + 1];=0A=
+} __packed;=0A=
+=0A=
                                                /* IFLA_BOND_ARP_IP_TARGET =
*/=0A=
                nla_total_size(sizeof(struct nlattr)) +=0A=
-               nla_total_size(sizeof(u32)) * BOND_MAX_ARP_TARGETS +=0A=
+               nla_total_size(sizeof(struct bond_arp_ip_target_payload)) *=
 (BOND_MAX_ARP_TARGETS + 1) +=0A=
=0A=
>>=0A=
>> I haven't looked at the series more closely until now.=0A=
>>=0A=
>> Why are there multiple vlan tags per target?=0A=
>=0A=
> You can have a vlan inside a vlan, the original arp_ip_target=0A=
> option code supported this.=0A=
>=0A=
>>=0A=
>> Is this configuration really something we should support in the kernel?=
=0A=
>> IDK how much we should push "OvS-compatibility" into other parts of the=
=0A=
>> stack. If user knows that they have to apply this funny configuration=0A=
>> on the bond maybe they should just arp from user space?=0A=
=0A=
> This change is not just for compatibility with OVS. Ilya Maximets pointed=
 out:=0A=
> "..this is true not only for OVS.  You can add various TC qdiscs onto the=
=0A=
> interface that will break all those assumptions as well, for example.  Lo=
aded=0A=
> BPF/XDP programs will too."=0A=
=0A=
> When using the arp_ip_target option the bond driver must discover what=0A=
> vlans are in the path to the target. These special arps must be generated=
 by=0A=
> the bonding driver to know what bonded slave the packets is to sent and=
=0A=
> received on and at what frequency.=0A=
>=0A=
> When the the arp_ip_target feature was first introduced discovering vlans=
 in the=0A=
> path to the target was easy by following the linked net_devices. As our=
=0A=
> networking code has evolved this is no longer possible with all configura=
tions=0A=
> as Ilya pointed out.  What I have done is provide alternate way to provid=
e the=0A=
> list of vlans so this desirable feature can continue to function.=0A=
=0A=
Regards=0A=
  David Wilder=0A=

