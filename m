Return-Path: <netdev+bounces-89654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2D38AB0F5
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 16:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E38BB22EBC
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 14:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E5812F368;
	Fri, 19 Apr 2024 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bbc.co.uk header.i=@bbc.co.uk header.b="Q3YSik+X"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4213B7D07F
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.158.142.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713537970; cv=fail; b=IH3DPdAULm/b3VxIIjRVuwu6F509pwWT1hpIcQ6jId45JJzRS3pcHQtqTW5GJWNHZJc8Kct/4/fyO7x1AbYHWuHnShuae+1N122jWyX0kU4KBtP4FnR+/IExVSXDegevXdxXkq4TztBiTbO6MLdzRbO8pfk8FiKoM14QTVwJUXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713537970; c=relaxed/simple;
	bh=0Abl9NB/A/26Y0ln9gn6qPGANFsGthG390T/S+6ntmM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jZp4wl0MPOJe/ajCaI0y8ebX1Zr8ol8aD3CLXxJJDJFc/bziBZJUW5q2YQ9ejynyf3nn61EUqh6DisXLb4Mi2NoIU2eJtU6HL/eALrD1XNjNI3LWKwEg8l8CAugd8VfLBtZ9IHUxnbc86+ou2j/siaaGYNNRNg86sKAIWMi1giM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bbc.co.uk; spf=pass smtp.mailfrom=bbc.co.uk; dkim=pass (2048-bit key) header.d=bbc.co.uk header.i=@bbc.co.uk header.b=Q3YSik+X; arc=fail smtp.client-ip=85.158.142.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bbc.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bbc.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bbc.co.uk;
	s=msglbs2022062900l; t=1713537966; i=@bbc.co.uk;
	bh=wmSfs5dfQE6x6IFeodYRRCs/GTTEDCb1za0gATHCQHE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	b=Q3YSik+XSfCX7BqbBfmVLxUNf/socYZM5eJNNI2D+3+rg7CUcbtKhZ/U8JAYOSGdj
	 nu5A4w6Ggih6zPDTJICAdSdJVZ2cTKtZbGViYT5QB1zMFGS9PJ/Ug2Ky+02crqejY8
	 ZSHXBgBzjbgOPgERRka0dG+lduAY5DdrVXSLm441vv1hQwS8S7eaq5rNFncMaYRW71
	 UT7pg8k3EHZfoz4RY1QqdEAxHcO5P234Ip55dwuPmlGUZIw9Tqydb1SRFLmH539EEI
	 pHHTfLYvl5i6KNH/bsc1QJul8ieadCWAe6ac4MaeXVA/z4svIABAfB40INen2ybqwL
	 ghA326nDSIt+g==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRWlGSWpSXmKPExsXSsnPBFt21zUp
  pBg+nKFg8PfaI3eLYAjGLjW872B2YPRZsKvV4sXkmo8fnTXIBzFGsmXlJ+RUJrBk/GyayFBxU
  q+j9voipgfGVQhcjJ4eQwE1Gid3vjSHsFiaJpxecIOxGJoljd4u6GLmA7KVMEpfe7WaDcFYyS
  Wyb3Q3lvGSUmHL/ABtIC5uAuUTL98WsILaIgL7EvK+rWEBsZoEqiedTHzKB2MICLhI/1n4Gqu
  EAqvGU6D/vBFGuJ9F+8zDYGBYBVYn1b46C2bwCiRLTFl8Ha2UUkJX40riaGWKkuETTl5VgqyQ
  EBCSW7DnPDGGLSrx8/I8VopdHYs7ibkaI3mKJvtbNLBA1shKX5kPEJQTsJfYvmQ3V6ysxa/NF
  JghbTmJV70OoenmJaYves0PYMhIPbmwH+11C4DGrxJPrM1khnIeMEh97frFBVBlIzPt2BKpqu
  aDEp44ONogzljJLXHmVDJJgFFjEKtE3dzLzBEbLWUhegrD1JG5MncIGYWtLLFv4mnkW2EuCEi
  dnPmFZwMiyitG8OLWoLLVI19BAL6koMz2jJDcxM0cvsUo3US+1VDcvv6gkQ9dQL7G8WC+1uFi
  vuDI3OSdFLy+1ZBMjMAGlFKe272Ccvr9R/xCjJAeTkiivq5RimhBfUn5KZUZicUZ8UWlOavEh
  RhkODiUJ3owypTQhwaLU9NSKtMwcYDKESUtw8CiJ8IrkAaV5iwsSc4sz0yFSpxiNOa5s27uXm
  aP77eqDzEIsefl5qVLivNPqgEoFQEozSvPgBsGS9CVGWSlhXkYGBgYhnoLUotzMElT5V4ziHI
  xKwrx/GoGm8GTmlcDtewV0ChPQKRye8iCnlCQipKQamBwX82059W/hnJkXFa7+WimpXP04/q9
  /bJPeSpZlqTfqH7Qcyf9bn5OhlmO1jvPFpFLZzn1rZI7MWT/R7KyhbXPcN9/27wrlZc8/8Tpo
  qMq+NDII+FPMcllmT6HS+35vsepJOry3gm6oPDz7oqTw6YH27hWVXcUZfSfmsAQEu9vMbTZx1
  MnYuyekLk6UyySx1ua2o614duPnd+euhxjsnW2yNvGn4uIn6oE/znAeFoirmhkkt2vOZYa/nn
  sDRJ2yHwQYbmX/khM2+QeTdj7Dr/CkZx6rHvTeXlfq0unkuEggfF5ytKcUV8JPhsJltuX5Tfz
  SSWEBJj/LeZ+f8nwnyfjZpKch8MKtlSFzrMSUWIozEg21mIuKEwFu7G/uTQQAAA==
X-Env-Sender: jonathan.heathcote@bbc.co.uk
X-Msg-Ref: server-13.tower-731.messagelabs.com!1713537965!23601!1
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received:
X-StarScan-Version: 9.112.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15972 invoked from network); 19 Apr 2024 14:46:05 -0000
Received: from mailout1.cwwtf.bbc.co.uk (HELO mailout1.cwwtf.bbc.co.uk) (132.185.160.180)
  by server-13.tower-731.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 19 Apr 2024 14:46:05 -0000
Received: from BGBGWXM1001.national.core.bbc.co.uk (BGBGWXM1001.national.core.bbc.co.uk [10.84.142.12])
	by mailout1.cwwtf.bbc.co.uk (8.15.2/8.15.2) with ESMTP id 43JEk4GS029505;
	Fri, 19 Apr 2024 15:46:04 +0100 (BST)
Received: from BGBSAXH1002.national.core.bbc.co.uk (10.94.65.18) by
 BGBGWXM1001.national.core.bbc.co.uk (10.84.142.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2507.23; Fri, 19 Apr 2024 15:46:03 +0100
Received: from BGB01XH1005.national.core.bbc.co.uk (10.118.80.6) by
 BGBSAXH1002.national.core.bbc.co.uk (10.94.65.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_DHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.16;
 Fri, 19 Apr 2024 15:46:03 +0100
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (104.47.1.50) by
 BGB01XH1005.national.core.bbc.co.uk (172.22.64.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2507.16 via Frontend Transport; Fri, 19 Apr 2024 15:46:03 +0100
Received: from VI1PR01MB4240.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:6e::24) by AS8PR01MB8859.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:40f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 14:46:02 +0000
Received: from VI1PR01MB4240.eurprd01.prod.exchangelabs.com
 ([fe80::db34:6f62:13ae:7b0b]) by VI1PR01MB4240.eurprd01.prod.exchangelabs.com
 ([fe80::db34:6f62:13ae:7b0b%4]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 14:46:01 +0000
From: Jonathan Heathcote <jonathan.heathcote@bbc.co.uk>
To: "edumazet@google.com" <edumazet@google.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: [REGRESSION] sk_memory_allocated counter leaking on aarch64
Thread-Topic: [REGRESSION] sk_memory_allocated counter leaking on aarch64
Thread-Index: AQHakmgs+R/QtSKHSEuSGtrlweYJCA==
Date: Fri, 19 Apr 2024 14:46:01 +0000
Message-ID: <VI1PR01MB42407D7947B2EA448F1E04EFD10D2@VI1PR01MB4240.eurprd01.prod.exchangelabs.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR01MB4240:EE_|AS8PR01MB8859:EE_
x-ms-office365-filtering-correlation-id: 1ae17a26-fd2b-4327-5bd5-08dc607f6ee1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JL9mRnRrYcwb/vgZvm/HZmi8UfP4qDSIf0PTJdLQvMDRJXATZTJpFzcmLk64Vt78l2ThppupWRVnVKC0OJs9eh+b979pojTXa6iN6tqNawFJmxEmQfgB9EKEr7hGqwAz3rd1RcyQ2lHIMI2rzSfKwnECnXchWp7UP0BXzOSncSmxPSM5U+MSwyfp52Aac7IcJosbtp36JrB6n3WcbsF7eP8WLqvIjipcRhL/JFD02La7gKhcwgDB4EnYtGnTOwf849OuQAAWHzhrOK5/lH1Aao510u4Vl8Fd2pBkLw0IE5hODEMAw1cn9N9HMlo1HYAk/0SKzhTCxQp/aETBfjBqKtjgUnMmRETf5FZBD7xUpD/3efXMloOfYZU8kqG1yKcXf0V9bDcMhxQ0ECrZSVGCFbtqCnxZRQIHrs8W7TgkQAwPaeUdzCQz6xPGbYUeUatqi/leVl//m6uz1JQQGVV7WYKCYJdMG1/2nqimUUXM0/sFhNnYGLUFdsi3uR0SGqRnYfoR8XyNDVONKkjYzlKqZmab523gJksXbJpm5MDRd/cn5M0OTsdHgU9l/VqQgrG921bPn5ck9RgAXigOELKLR/i0PQcyHhAn0Ay0ZJcB3CTxpe5rhtmYQMV1umObDorzxPgNbeCwc/U/ioJnoTRNgRtFAO44a+eiIjczjxxiJPPHJYI8oWN793pmhT5ZCVqd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR01MB4240.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4BVBlXNRbXwG8iJJvSMFaCG5nCvmNrDKm/ZSVzpi1/i+jym0LBantk2RMW?=
 =?iso-8859-1?Q?4oeBOzlIGvyEJe80WgjfFCFtEV6F021be+CECAJ5SkVS6UE48pFeXniwLX?=
 =?iso-8859-1?Q?tHM9IejRFdMGdwKaOlJWJ4cXSIDpMkYtJQZuo4ErX7f6GIFUmOYzkhcyex?=
 =?iso-8859-1?Q?NtPuYMs96FEG0OU9+DUVrTGx65nLTCsmZw08Wk/D8D4tkRR3TCteM6MYn/?=
 =?iso-8859-1?Q?rGNkf5gIPsbauT+94U6pLmKCq0ZtbDPZYrpd6tBtpuwwUD9geoK79aOD3u?=
 =?iso-8859-1?Q?4FTx/eiivI/M2QJ4yQ6ps2YbkruJjIjtDiIIGSFGDjlGKYXkuVAOCGOdNn?=
 =?iso-8859-1?Q?oU0q76Ma5INFqm8lYjmhd3iaQCxSmJ1rFrhKXMBsPVX5xjHiUolP5ULg31?=
 =?iso-8859-1?Q?q2f2BW19dJzySz6Z6XSeM7cr3z0p2KXsmF4AgckaEIS3SzSGJyw3hdtgHW?=
 =?iso-8859-1?Q?0p9GatTSw++YBaFyqsxNbQhain82W3LZ3YVmUp8u3jm7paC0z7LbAMbkMc?=
 =?iso-8859-1?Q?68leLpbZ8ogHU+clTgTbtCdMray7VT1Oy/g0VgUTE4EwsPdMYqxgZwAk6Y?=
 =?iso-8859-1?Q?1njDNBSrwu2eLdPAYsEmrgeI0ad355Cq7kNaD1WiTZi8bfhpGlq87RizlK?=
 =?iso-8859-1?Q?bML3oSoI22rcappznG8qILUe4Oa0fu7xbA/2uQAT0MsOT4RIKIFhfHggC/?=
 =?iso-8859-1?Q?GgxLnsqRLvFcHOM2i0JScZHHdkVkw9B0oUCYzSja1SxvY5VXEGT3yA5XLB?=
 =?iso-8859-1?Q?W89PejuoM15SJ/pZGGMXR3HVEunNibcQUW4y8tD6ETDEdPNy90qVkv3VDn?=
 =?iso-8859-1?Q?UdH473ifsrhj4TWU4Bg1r20CCnJ5c4oUuduI4I3dfR/fmvxG/pLXTDy3bu?=
 =?iso-8859-1?Q?xECzFDS/n2oJsfuA+LpUcy3iY2kSHz3e3GX9QuIKDH5Z2/c5+U5OY53zB0?=
 =?iso-8859-1?Q?MaiKMVSA+syS+7Bf+bN5X3xdSeEdqJgU3XUh7k3SS80QqmJOj0Bm8bJ+Ba?=
 =?iso-8859-1?Q?0etWs58t+1LmEW4hT7RgkqGiBCDux5SkyS3ofF+xWD4bw99RNCt0ATjENf?=
 =?iso-8859-1?Q?TiBdyS0U/GxSf7I/KhQrrtSF+V13nuImZ3kFLmRDBNMoECtH4GxkMJrhCt?=
 =?iso-8859-1?Q?GCr6OHaxD7us3zjbaJOtIX3KME0+iZOgIEG5m+OE0TR1fDW+856I3nXSqz?=
 =?iso-8859-1?Q?ZMcalQPQbXP/LO3Ryxq1/Zgg12Gi6SlQ8b90IfPrCeT1AtReE5zytUvcpo?=
 =?iso-8859-1?Q?aGeeHBej6nIAQ6uaXby6+Tpdn1ZFiPpTt4GspcBVI7qsctm1zwSbjeLJ4j?=
 =?iso-8859-1?Q?c44+JbPyUBGEyKp1QKB2T0TMMSWJVKslW9Wlcc/L5sqZ8t11QZRpAWp4me?=
 =?iso-8859-1?Q?yDOmQuAuM4gfYY+CdefvL9608s6I4J4fmz/CxrNTKBWEmCw3+0UuKhMG1x?=
 =?iso-8859-1?Q?/vwShN9vxy6u/m7U9zsxPVX96Hk4awhc2XzmTGRt6KSFcK5SH1OsMq96Zg?=
 =?iso-8859-1?Q?btEuvNZc0ySzy9INUs27LFdLjYzu19RcCJAWSaIfbIlG8ajiDWXFizKFej?=
 =?iso-8859-1?Q?YLKOD1SuRMGOHX7PWx8SuFO/BUHyEavMGaqWMGan9FpSms/K1b5t4Qp+dE?=
 =?iso-8859-1?Q?2ir5rp0dGBXmOT+92llIF+chG1DrmwSyno//IsKOQoNMVhYL4bnK5C9w?=
 =?iso-8859-1?Q?=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4RzopqBJjP2MhpbXVdxWHk8MkTqGCc+TEK40F0PvJfPOumWl+RwLXFEgnAh3mDpXOK9IPsX6s6CkDYDjJZBhzLCLrQG297iOy5eg0MG4c+LA78yKQNGhBFpiL6rs7/gK3yTid1MLsCZLE2l4tmWIeWJUIE6msfvpYVk4NTlGt8zgIelRzwQRxKHOGzC9QZE7o89Xmqvy/IkdfXv31lIKJ5SXtDyvK03Zcc/5Ctk7Te0EHZYnSDutgBbrIqKwgxC5N2z7dRTvbm5Hcz1UZvvtOGveT7jQ3H04dZX9/8VCHsIYMr4x+HoMpQLBefosTJHPaAYSZYnFJxrZJFqP/l5gA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxlmKSqVRYAsmY8FhL+tls/C5AY6Ky3Tu6a5kPxS1Bs=;
 b=h1Sb2dk64SboZj3ziUAdPyRvZr8K5WTKfqhCAg/oJgbVyMlLZ2fwwwdIpqDUQGWAaTCnsI6VhV0MDmeCq++SsYFttQYqDBhbOyKFzzobfZkUEzWjcyKnYCdi/RDdNve7jYQVBdYMnnuS4WnBTLq/6ubMF8Zo7MKFI1U9b+D9jktKZCuJdnP3V76HchngUSN9vqP9zCzQHpQV5FgwY5UP6fcewOG5SEUgYWjGAeA3epCd9pVBAc6MuBZOx4raI2HhBEM9CGfCk2mKE8sHv4bnh7AaeLJcyCMBFU2wkupGtSZd53p1FMDj+vFoLv0RktZbTNvd41d+YBCnaEGAEVCY9g==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bbc.co.uk; dmarc=pass action=none header.from=bbc.co.uk;
 dkim=pass header.d=bbc.co.uk; arc=none
x-ms-exchange-antispam-externalhop-messagedata-chunkcount: 1
x-ms-exchange-antispam-externalhop-messagedata-0: e6sLJ58Kbx7ctbqgkbzqocB01BfGY/MzUiqxOVqBomzb0JWAmI81r8W0Z2o+fZAw8Z/S9IcEA1HW8+eJDIatZmlxNW6uIUmk38pUNTXmtap77Dk4GPvuMc3gtKpNbMDw81fVKyel8tdOlyLZj46W9lYC9nwtASfajAEc4IHdr5L1fQG/MVoHcgUHXY0/nr/bnZ9t/R4GSgjIVxGrASwxRmY41yjwDTGb8a9VjJwBKoely1GCge79WE6CAiOrPZJLHTlpMUefDNTlVGlWVFUg/aFzWhqZGvl3Zpk4R9CfLSNlltA7WbpCClHMHzR8+pPl3X7ykRvA7XsjPnqTiV8/cqLNpzlXB2oiejS2fff5PgRZ5E9AjlIW3GsXP/9rpIbpvAynu8vhuZZEhkiqDD/XuI4Y8C4VYLQJc2YNVgA1Tq2YvXIxwowbQm72aEjR0ZP5gxVYYkrtHbWqH+U+HLNd/XYHNACHg3hejVl202c3sykV1HbIf5QV/GYOmubPzuMIU2rDPgehrNCqEjRo1IqSzbB5i4fANpVmq+G1ncxWz8zplAyvnBkXMxG8fr+vWKBkw25JIZ4Mz0j2U2+mMi/bJ5QOsGkxdEY2IRbN7/TXbW4K/ieL0m7+C08WX1ZLJRC5rQYFqFbMduuoXppIMm3PPOfQWZaoBBXCSnT8W4W3xOQ=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: VI1PR01MB4240.eurprd01.prod.exchangelabs.com
x-ms-exchange-crosstenant-network-message-id: 1ae17a26-fd2b-4327-5bd5-08dc607f6ee1
x-ms-exchange-crosstenant-originalarrivaltime: 19 Apr 2024 14:46:01.7084 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 0e587133-568e-44d6-801d-2266bc52e5cf
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: mV94UEF7N05C94m7YWjNFUHBl9+ZD5tE2JWHvYtHkxMrxPSTIbPX1ow/BLSby/4AG0WcbLcPrKyXvEdM/pGpASrdMAakDudFtcfYcqqagaM=
x-ms-exchange-transport-crosstenantheadersstamped: AS8PR01MB8859
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bbc.co.uk
X-EXCLAIMER-MD-CONFIG: c91d45b2-6e10-4209-9543-d9970fac71b7
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-28330.005
X-TM-AS-Result: No-10--38.407000-8.000000
X-TMASE-MatchedRID: r2JV+8YtsaLVlZMf+t5q3WDtiwcUzMIg0U0UWSZVhArd5HexqBUAVEFY
	UJLQupgq9+ttu9H2qWe3PHfIkvax4eqfrw8HF/nIvR08UROkEAcTq1/DvsUNDuCbuVI7hVbLPUB
	7phxYIL2QrDMYz76xxwntvZHId+TCNtwF1IC9LrUUnHnr/GbaTzVOaZVuQCanJYvGOWtLLy+6JF
	QXmX2Car5wpZVCbFHLKq78KK9SLoQnwfvzjhYcjtwYDj426s65Ynjb54Q6bnCtBiS9hFeaTD1uZ
	lSSRLdY/G26v9h/FJu3Qx8wmJrodPeZvsXLeVOjOIQ9GP2P2u9N8rmPQRlvK5m3OIVSf4P5skzU
	NSR/4b1YTFbvS7ndGpwwoGcg9EWOlSdamdquMnzX3j/lf1V8LDY4A/mHOU8eLsu54LyRHDS1HW8
	KlWEvwHyMyYlEetFvzbPoUo0CxxC1TiWqZWCojzzHAJTgtKqwyeUl7aCTy8hOmq2IYpeEBgp1/G
	95iiiw5ZHdquAwKoH+WCU6vRxKf+yjk2XnzA5wKG9WORFy4qFlH44U2Ru12j+B/tp8itBTdcsjo
	3n3EUXw5F5kM5EoBkErC9qTusGdC0FfEB3vJNOOtWfhyZ77DhwOcB9/9tcRmyiLZetSf8nkA/7K
	qi9JmYv4ihlXSKxevECLuM+h4RB+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--38.407000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-28330.005
X-TM-SNTS-SMTP:
	3C9BFBC5AE2335C8606743C6A6E000F654616EFC8C3C7E1958E394F74266FFCD2000:9

Since Linux 6.0.0-rc1 (including v6.8.7), there appears to be a leak in
the counter used to monitor TCP memory consumption which leads to
spurious memory pressure and, eventually, unrecoverable OOM behaviour on
aarch64.

I am running an nginx web server on aarch64 which is running a media CDN
style workload at ~350 GBit/s over ~100k HTTPS sessions. Over the course
of a few hours, the memory reported as consumed by TCP in
/proc/net/sockstat grows steadily until eventually hitting the hard
limit configured in /proc/sys/net/ipv4/tcp_mem (see plot [0] -- the
slight knee at about 18:25 coincides with the memory pressure threshold
being reached).

[0] https://www.dropbox.com/scl/fi/xsh8a2of9pluj5hspc41p/oom.png?rlkey=3D7d=
zfx36z5tnkf5wlqulzqufdl&st=3Dyk887z0e&dl=3D1

If the load is removed (all connections cleanly closed and nginx shut
down) the reported memory consumption does not reduce. Plot [1] shows a
test where all connections are closed and nginx terminated around 10:22
without memory reducing to levels seen before the test. A reboot appears
necessary to bring the counter back to zero.

[1] https://www.dropbox.com/scl/fi/36ainpx7mbwe5q3o2zfry/nrz.png?rlkey=3D01=
a2bw2lyj9dih9fwws81tchi&st=3D83aqxzwj&dl=3D1

(NB: All plots show the reported memory in bytes rather than pages.
Initial peaks coincide with the initial opening of tens of thousands
of connections.)

Prior to Linux v6.0.0-rc1, this issue does not occur. Plot [2] shows a
similar test running on v5.19.17. No unbounded growth in memory
consumption is observed and usage drops back to zero when all
connections are closed at 15:10.

[2] https://www.dropbox.com/scl/fi/dz2nqs8p6ogl7yqwn8cmw/expected.png?rlkey=
=3Dco77565mr4tq4pvvimtju1xnx&st=3Dzu9j2id7&dl=3D1

After some investigation, I noticed that the memory reported as consumed
did not match system memory usage. Following the implementation of
/proc/net/sockstat to the underlying counter, sk_memory_allocated, I put
together a crude bpftrace [3] script to monitor the places where this
counter is updated in the TCP implementation and implement my own count.
The bpftrace based counts can be seen to diverge from the value reported
by /proc/net/sockstat in plot [4] suggesting that the 'leak' might be an
intermittent failure to update the counter.

[3] https://www.dropbox.com/scl/fi/17cgytnte3odh3ovo9psw/counts.bt?rlkey=3D=
ry90zdyk0qwrhdf4xnzhkfevq&st=3Dbj9jmovt&dl=3D1
[4] https://www.dropbox.com/scl/fi/ynlvbooqvz9e38emsd9n7/bpftrace.png?rlkey=
=3Ddae6s68lekct1605z9vq7h7an&st=3Dykmeb4du&dl=3D1

After a bit of manual looking around, I've come to suspect suspect that
commit 3cd3399 (which introduces the use of per-CPU counters with
intermittent updating of the system counter) might be at least some way
relevant to this regression. Manually reverting this change in 6.x
kernels appears to fix the issue in any case.

Unfortunately whilst I have binary-searched the kernel releases to find
the regressing release, I have not had the time to bisect between 5.19
and 6.0. As such, I cannot confirm that the commit above was
definitively the source of the regression, only that undoing it appears
to fix it! My apologies if this proves a red-herring!

For completeness, a more thorough description of the system under test
is given below:

* CPU: Ampere Altra Max M128-30 (128 64 bit ARM cores)
* Distribution: Rocky Linux 9
* Linux kernel: (compiled from kernel.org sources)
  * Exhibits bug:
    * 6.8.7 (latest release at time of writing)
    * ... and a few others tested inbetween ...
    * 6.0.0-rc1 (first release containing bug)
  * Does not exhibit bug:
    * 5.19.17 (latest version not to exhibit bug)
    * ... and a few others back to 5.14.0 ...
* Linux kernel config consists of the config from Rocky Linux 9
  configured to use 64kb pages. Specifically, I'm using the config from
  the kernel-64k package version 5.14.0-284.30.1.el9_2.aarch64+64k,
  updated as necessary for building newer kernels using `make
  olddefconfig`. The resulting configuration used for v6.8.7 can be
  found here: [5].
* Workload: nginx 1.20.1 serving an in-RAM dataset to ~100k synthetic
  HTTPS clients at ~350 GBit/s. (Non-hardware accelerated) kTLS is used.

[5] https://www.dropbox.com/scl/fi/x0t2jufmnlcul9vbvn48p/config-6.8.7?rlkey=
=3Dhwu0al2p6k7f92o1ks40deci9&st=3D9ol3cc45&dl=3D1

I have also spotted an Ubuntu/AWS bug report [6] in which another person
seems to be running into (what might be) this bug in a different
environment and distribution. The symptoms there are very similar:
aarch64, high connection count server workload, memory not reclaimed on
connections closing, fixed by migrating from a 6.x kernel to a 5.x
kernel. I'm mentioning here in case that report adds any useful
information.

[6] https://bugs.launchpad.net/ubuntu/+source/linux-signed-aws-6.2/+bug/204=
5560

Thanks very much for your help!

Jonathan Heathcote

#regzbot introduced: v5.19.17..v6.0.0-rc1

