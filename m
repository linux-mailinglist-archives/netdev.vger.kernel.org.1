Return-Path: <netdev+bounces-147754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650959DB946
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 15:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC86163A5B
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 14:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6AE1AA1FE;
	Thu, 28 Nov 2024 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scioteq.com header.i=@scioteq.com header.b="IQyStKtB";
	dkim=pass (2048-bit key) header.d=mail-dkim-us-east-2.prod.hydra.sophos.com header.i=@mail-dkim-us-east-2.prod.hydra.sophos.com header.b="ttEgs6XW"
X-Original-To: netdev@vger.kernel.org
Received: from rx-use2.prod.hydra.sophos.com (rx-use2.prod.hydra.sophos.com [18.216.23.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11828145A0F
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.216.23.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732803041; cv=fail; b=d2be1vOyOJUohLAnvWK5d2FSU0RE+3o+1e/IH1RTxEo+GhUqriOcGY+9Tw4op+wi9CXfqQd/ccG7POem6DS424lwIsNxf0qpfCvG7pJyq2IfU5VynevArgfWO4FE0wT+ANe6ohLjWlwTZUnTHayvRkbyGTLEHsXekoJG/fq6Xz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732803041; c=relaxed/simple;
	bh=oZiaw7u9Bt9x4pwLyiynpSUEUbeXgplVvZas+aunhN4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aoPv8Skf97Fbe5br5uiZ7TQG4m6ggy0CrEgaUvsAJXcEVo/LRiIVDTRiF6/vchFHbY0Tq42VoB7o2EELKdAjAvtqxudR+XOlfhOS0OrhPMnu0EpsDY/RXxmcBJry/pocIBKecD37X1ofVdGKxsM+s+hCxByroo8pyHXyv6At2lA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scioteq.com; spf=pass smtp.mailfrom=scioteq.com; dkim=pass (2048-bit key) header.d=scioteq.com header.i=@scioteq.com header.b=IQyStKtB; dkim=pass (2048-bit key) header.d=mail-dkim-us-east-2.prod.hydra.sophos.com header.i=@mail-dkim-us-east-2.prod.hydra.sophos.com header.b=ttEgs6XW; arc=fail smtp.client-ip=18.216.23.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scioteq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scioteq.com
Received: from rd-use2.prod.hydra.sophos.com (ip-172-21-0-252.us-east-2.compute.internal [172.21.0.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rx-use2.prod.hydra.sophos.com (Postfix) with ESMTPS id 4XzdJw3dgxzkC
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 14:01:36 +0000 (UTC)
Received: from ip-172-21-0-76.us-east-2.compute.internal (ip-172-21-0-76.us-east-2.compute.internal [127.0.0.1])
	by rd-use2.prod.hydra.sophos.com (Postfix) with ESMTP id 4XzdJp0Hncz5vMF
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 14:01:30 +0000 (UTC)
X-Sophos-Product-Type: Gateway
X-Sophos-Email-ID: 0e86113ab92f4e3ebb350cc9f946a701
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012048.outbound.protection.outlook.com
 [40.93.76.48])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by relay-us-east-2.prod.hydra.sophos.com (Postfix) with ESMTPS id
 4XzdJm6548zHnHT; Thu, 28 Nov 2024 14:01:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ps+3PkGRFGs2UIpEoLKaeSwUGo5yGGjep+xGVLklqYR00HxjaG3S17PvJwEWJ66Qv3l9hXcgLRk6+olpuFX636Jk+/TQoQeyX2+U9yjoXZrWTz9DzvYGYI1Yv+6OM9pwVkJu9ai1l/apY87lWWqUuIT9c6L/1byxSWYSTUvapC+P25BUNNfS3OXkDQdAVCabUtDJu+r0wXh6UxAeFzY/ACS2qn1CpdWyoJhwBbhry5w0nTPhuoh/rtISP4w/3UBZryCFfww3Xb2+0wIa44yk2bJQAM+5A5YUC/kgd0Q1aSnH0aoVAss5QWgo9UyyO/dVr+q2qMASqcBzBMBNvS5Wxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZiaw7u9Bt9x4pwLyiynpSUEUbeXgplVvZas+aunhN4=;
 b=hH6marvaJQU2aaiQzuEMMFE6Dnz9Hh9qfJ9B57eLm2PXo0Vlx65FjMRTezZWPVoyIePUo+1+SQ2e6IlumDPnG4GLFjy2828aZ0kQFFzlcMcodbKhlbcRMwj0duwagMLzpCOK1It5IfU1qit0llvBinqr0v9uYo1K7zf/uXD4wjRGc6j7qQTEgPX/Np2TihVW2z7BpP22WJFvH8BGEQcMwxhyIVg71gClSj84jlYKyXIO1FoxJip5vANEXpKjf1zXyuCgromMIRFNcnYfwu0AOKLlywINZF7qvd1Zs2nCiW7WYjGJhclMwI4TtAHXcwN5lvPYlQt2UDEF6t+I5MzWCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=scioteq.com; dmarc=pass action=none header.from=scioteq.com;
 dkim=pass header.d=scioteq.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732802483; 
 s=sophose3b6b7cefe1d4c498861675e62b33ff6; d=scioteq.com;
 h=Content-Type:Date:Subject:CC:To:From;
 bh=oZiaw7u9Bt9x4pwLyiynpSUEUbeXgplVvZas+aunhN4=;
 b=IQyStKtBM2wl9xTJ7v86kuIDEuwd1e6GefuVqmIxYpMTCfRz1u3HuyBLWYf7HJ2i
 PKcXEi0GSH69/1TVara1al9NU2zuEcK5zVfnXVlxwOvxlL2gBkfE9eYzPY8ZMwUicgI
 akZBtfLT2BEb0MPGr41LjgQ3Q54I1SYTMd4pNeElf+EWC1z0PXnKBuM45lnbQjQjByn
 C9J9JStKiUUedImiTn+PKMFS1BGsjd0ADEfOrqapHE0/7euFgKcf6t4JpaKfU2gl5zx
 Qq8tYIUoO2tygWRVut3PxfD7gE7HQSGlWfRhhpC3JJ9KIFkST1FUIqFwJSqii6AeG0Z
 2wE8l0k4Tw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732802483; 
 s=v1; d=mail-dkim-us-east-2.prod.hydra.sophos.com;
 h=Content-Type:Date:Subject:CC:To:From;
 bh=oZiaw7u9Bt9x4pwLyiynpSUEUbeXgplVvZas+aunhN4=;
 b=ttEgs6XW+ZrFIPQcqrK1Q0bHZeTgJq0tObKjNSLOEOemBGrqwSABQ5yvYypT8Ep4
 jeM4I/QiDsfIqC0vzmYEbCTRfUr7uC/JnfvxPJw9ddBZY9N3xgx4oXwB+FVAaNdncdh
 J6wwgSQLLh9heW6L2at5nkzSXHHXea/wOvSqN1lVwSjPp6AsZJb+Pd5B6Putzk1vBOw
 a+BOpw2shGQ/lyDF8Ju6uYRyGa4CTgG21ry/Eg8qD4Mc8mfNkHujUI5oJuwSDQdJTDe
 Khz1hZY3EFmAELQuQxWUAUCxgFL1iaHNL3uUkEwXUOpEe4SIBHNDozAleD/ej30EF5U
 Mhf14+cbeA==
Received: from PASP264MB5297.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:43b::20)
 by PARP264MB5231.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3ee::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Thu, 28 Nov
 2024 14:01:25 +0000
Received: from PASP264MB5297.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3de1:b804:8780:f3cd]) by PASP264MB5297.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3de1:b804:8780:f3cd%5]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 14:01:24 +0000
From: Jesse Van Gavere <jesse.vangavere@scioteq.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "woojung.huh@microchip.com" <woojung.huh@microchip.com>,
 "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com" <olteanv@gmail.com>
Subject: DSA to switchdev (TI CPSW) ethernet ports
Thread-Topic: DSA to switchdev (TI CPSW) ethernet ports
Thread-Index: AdtBngHEzdd5mOmhTK2G5m4PFETOTg==
Date: Thu, 28 Nov 2024 14:01:23 +0000
Message-ID: <PASP264MB5297F50F5E2118BBFEA191CAFC292@PASP264MB5297.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=scioteq.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PASP264MB5297:EE_|PARP264MB5231:EE_
x-ms-office365-filtering-correlation-id: 03252b0c-7f1f-404a-78f5-08dd0fb524d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?dvvS6b+9uwBGiVwC6mxiSsTDeCV89cAro0bL4TxGX9672C96yNCJv5455Z1/?=
 =?us-ascii?Q?qMtCKsrot0dt9FCxAcre0mQsbg1z93oXDaihe2kbVchs40tLaCL3qRleR0OA?=
 =?us-ascii?Q?nGBDmF0DnWRBvQ5TVR6/udP0ULaJetIpOi9ZWVH1rCXzl0SsM85mxri7KdYV?=
 =?us-ascii?Q?51O5pdtbdwCt8Q7NBMYvVPeeR796PFjwqPyyZ9JFDXvjgaPoxfCNRjaoay4I?=
 =?us-ascii?Q?Qrvx7PRsWGVKu1x7ciJZi5t55nTadhIJSI7DEhRgRh6z2eJsCeV3zMu+228a?=
 =?us-ascii?Q?OHNwVdESibe6LW8doxv8Mp1Kt7fq/bpe/o0af53DfmdUpWSpDQpb6MYr/c/8?=
 =?us-ascii?Q?HqwDd/q7tcYuo7kMS5pzmufjiFsA1IL77btNMVmKHFwZTaHFmc+7MCknxvJn?=
 =?us-ascii?Q?cMhMb+BhWSWwiFrQDzPT9wI1RcTU+OqYiynLYZwoRzQhr+YphT7xVzdEjHOh?=
 =?us-ascii?Q?FMMTfn+yRyjUvW8o7pTKpsmJC7a4cJjkEjIOESB3RvVY9xLoXLXfSVXWC3a/?=
 =?us-ascii?Q?nz5UQuPrwoZN4P3ri1fMk4fObxA0Za3c29c5RMTDFJbSRo3vfl1nT7Tl1ejv?=
 =?us-ascii?Q?3nhJZ/shlH5tFl+EOJlrETqw8TcBiJUpV5tQCpdgd2dx65AKvbl37hdHlD10?=
 =?us-ascii?Q?gUEwA+g5/Dczd7JIEM0GGsWHpv7sWTi16nZ/tQX82gaVJ2gXIB+XC6/MNW90?=
 =?us-ascii?Q?669pXYmqmiLN/hyA7mUeLjP9lXfpLn1jD5S5YsFP83K08ZozihZvCMZpmEbV?=
 =?us-ascii?Q?zwzCUwXQk/f/o6INNwimTVJ7n0OWYBv/lqLYxWsBRhwqgDBdftxVAlEN4ZFj?=
 =?us-ascii?Q?6ed7OJI6V6XCqiqVDUcWbwEp0diW5X5zCvvUsCJhRl9yXrP1xcKqBB5wfIRG?=
 =?us-ascii?Q?BJWbacXPLQUq1IuWo6/LK7SyWrP6vNleUWUprFbDd3Wc5M+jRDXco9mpLwkF?=
 =?us-ascii?Q?gOoDssaFUJKwzOsPGFARlHsXweGRzRH2AbAi6dSwD9kyf4VqlyAlxw8AK9EO?=
 =?us-ascii?Q?Ym2xGF5zz5prMirquWfQHMEkFV1OfnVQs69ckta653UpZcwDCarMSnnqCeCN?=
 =?us-ascii?Q?GE74PPtUIhuuoM3CTfAqmaAaXjUNTt3Dsd5g25GNpUvJTk2pa//ruoDJ8XbM?=
 =?us-ascii?Q?lzihfTbab5+Rvyh32/z6Y4mmFek4PGJJS2gIxUt2x2jvGRmYjY0QdjbHPy5c?=
 =?us-ascii?Q?6Xlka7q1KqY4TPm4fAtRqlo0wHIt8NPGaXJAmwbeqGb7gFk9J/+XESzltGA0?=
 =?us-ascii?Q?VNEuD9eeaCUqO5liuyC+RUbzQzCBKoo4C+6r3Q7qH300t8GalupAY9SpBRIt?=
 =?us-ascii?Q?plUcPVhX4FQ4jdtHcLMjH45oHJSpuL3Ha5wHDIMNFZhKn8zcZR2xjmsgIrPK?=
 =?us-ascii?Q?nrMjCMUhhT/stPFsfFFXNt4hFgtG41HPVxC/u97Jnkd4mlJQVQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PASP264MB5297.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BVhywdbhs+b1yZsz8TqITXMl1i2d69wkABHFgLWW/C7B6OhiaX7OnLUb4ZCd?=
 =?us-ascii?Q?Z4uhczdFJvDmTYpMUetNuHcy3WxZqI9HAORuXyevGYRNM4MaiJ2T/kWlIV8J?=
 =?us-ascii?Q?AKdrX6kWerHvqfv23kw5sNErRMfeGQZnu0UJYqCu3hLwsYG0BneYQntWmdEU?=
 =?us-ascii?Q?5SOyxZZgb8RwyVUyf/aLgVlEGOq2vANXtZ5TWagB0ClKRklHE2TJV19sFcsF?=
 =?us-ascii?Q?woBZb7uBTg+nrWpKIu5Zwfwf4uEejzvBKDuwWhFw05mfnmBE4630HYdTKJGI?=
 =?us-ascii?Q?inf+Ryh7gBJwFG9wtZV9hXoN9tyLLJzIq48GIBx/rrqET6xeX+w+HnE3D9vR?=
 =?us-ascii?Q?0vs/AJgPbRlAsBrhe9B7Le/OVdr/UfCX23P2nbUaaGql7t89wG0hVwm1WmyR?=
 =?us-ascii?Q?UKeCiiQqStUTlJg/zgZ2z/akmA9FNA2KNl9SG3+YJ8owXTpZDqHur5vgCtPx?=
 =?us-ascii?Q?uQPYQ3azqsHSGwpS6TfyvzbUFHYvaZSLYPFh7cVsy9i/44D8d/GViuGLlPpl?=
 =?us-ascii?Q?zMUQEzS+0irfWAaTlJ/Z2BGHdsZBL322KFYJLcZlLwBqDj1By8FZhgXsGeo6?=
 =?us-ascii?Q?aLcAXn3MjMK/iifyprFecDtoHVdlPAWY+HEYGl4Ct4QEW7Hjy4BTrLEgCdda?=
 =?us-ascii?Q?ey639TN7y1ZI3AhuoKuIMjFiBOtD6JzVhEd8MArMRINXiq+ivBTAGQX0Cb38?=
 =?us-ascii?Q?0wNBuA+rRozDNmr8gd0PBCM4/RwlXghmQ7LMd8SpycUBzakbCcYNp8CSkGye?=
 =?us-ascii?Q?oVPgvOa0LZufMWMhPzSG8oScsHfS84A+AxwEDlCTCurEoFkFQRJ7n/S6mF53?=
 =?us-ascii?Q?c3gvqLcQIl8/+x5o7rjFwIgfvunSXoEF4VEpDuEvQ2EiTyIujUdhgwyk/Dpl?=
 =?us-ascii?Q?Ljb7HHDV2jf9552a7P1Nu34c4Q/V4NQTum1rIuy9WjiD45odUhPHR5VG0DJc?=
 =?us-ascii?Q?Q+mOLPsUMigW4aVGKiePLbEErdyycoML7BVUJbipSgBJMQ0jq0MQLg4u2WYd?=
 =?us-ascii?Q?qrVEcJNGM7jF5ZiW+AqCFTER+hiFqreupQRPzZoh/9ILFdqQBjPR+s/djSBl?=
 =?us-ascii?Q?CcjRe8Frab3fv0KEaY8uQ9EzmxNPYvRUQjFKmSAW5QjK8ufjXQgJa7GcCv2T?=
 =?us-ascii?Q?vOOOcxhjcKk2U5HFFwL7Q8XAmmCq6H2AJYu3ubKprjv/HPZvBWEN/sPg4Ilk?=
 =?us-ascii?Q?TryNax/Ooc8lMjT2Bpuqm1R3WElHV7FZ/uxRJ4kLMRM2pdeLUVUh3v+T8E96?=
 =?us-ascii?Q?PW7KHiOwFhU6WMTymSr4IpDWoXHhMc6WA4v+vFsTwnMCftUKQ+UBn2tdGg+D?=
 =?us-ascii?Q?9viR/ALNhek58IF3IT/2Z9t5JmhqxTGm6+ute3eDf4DAb9lGadQRvydHg7Gh?=
 =?us-ascii?Q?sBiFxfRmWyi0WVAyn7c9Dm8bohtR4Xlgck87iJ5tu+tEemffOI5DeV0DiDeA?=
 =?us-ascii?Q?H9YQ2/01R6yaWg8/TiP3VzkC0CpXH6DOML7Peumo5FcFrCPeKyqDjjMg/Zj4?=
 =?us-ascii?Q?gmuAcO9tWRDJe67FFhWQdXoFiaeSOFJBUASMBvqUBgeK6Fat1Kf7qz+JlP6K?=
 =?us-ascii?Q?pCvgdC+7OAQk/bocs5cbjOqDbhLVNmKx1og4Pyd/llyjGb/dVXBhTNQ5LQUu?=
 =?us-ascii?Q?GQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J8QKS3d15WlS7HNyGFwMvT2LEvcezTenklnqjKWABUPdEecoufxtuu8QF13WkMC/nMCdUHHmSwLXNsZT0pp8rGUnA8ZNvxy4Iw2OuCbBhpptXfBmtOkyOeW0XqGfejeR53W6atmDG//Dt5e359iGPazhIeXK/+Jg4/8AvKUFclTVyGV3zvfpczR+4NIujDStgOp8QoqZPxieWT+ssWIgfu6aAH49r4sKFu6ippSzzNeRA1nAMPdEy3wojw1ASg1RZX1VEq23KGy0rqP+nAfjox5JxhgqPJ7U9G9f6zW0tp4k2EFCmI+/OIhjiVvcY4glhISzqEJyHPYyy8hljCqHXw5nxpuyswbDzglyhYz810onz0Ki+g8fABKfaFWD8kqCB2NHnibOsYAHpzqz1bOCU+g+eP0rHA+TeFvv4hDOJujv1pt1hSBrSb2Rbq+RozUflIe4MXD3kNQxh8nYJacN26em+9EZ/wTKYvC8NeQ/HqYnlkcNcPXfpPmgNVxjldlvRpUs1BFd50OyM/EMVwMGNkWwRFDnSMohgwwVaG9OR8omwLuvnr1b/8b0V8u79LB38dYOJJi3D20VkSmnKH7qmPBPXTD8botVfbRsCsYLtdJ0K2d62IyHl2oBoutksVDnZiTMaX4mfPbXfvWZrFfC91nWG/T9lKl3JpdyAQOuqQI=
X-OriginatorOrg: scioteq.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PASP264MB5297.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 03252b0c-7f1f-404a-78f5-08dd0fb524d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 14:01:23.7499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f3e5b271-16f7-46b9-bdb3-4271ac933ef0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8KYTqr5m5W4NL6ciRF3RviMrHEChRrcTz6VFEm3LBIqi6bX+i7ljnlrDrNrGlByJsVdclB1p90cB56XinZroOh7mhQOnFDN1nIIKQJz+K4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB5231
X_Sophos_TLS_Connection: OPP_TLS_1_3
X_Sophos_TLS_Delivery: true
X-Sophos-Email: [us-east-2] Antispam-Engine: 6.0.0,
 AntispamData: 2024.11.28.131546
X-LASED-From-ReplyTo-Diff: From:<scioteq.com>:0
X-LASED-SpamProbability: 0.085099
X-LASED-Hits: ARCAUTH_PASSED 0.000000, BODYTEXTP_SIZE_3000_LESS 0.000000,
 BODY_SIZE_1000_LESS 0.000000, BODY_SIZE_2000_LESS 0.000000,
 BODY_SIZE_5000_LESS 0.000000, BODY_SIZE_7000_LESS 0.000000,
 BODY_SIZE_900_999 0.000000, CTE_QUOTED_PRINTABLE 0.000000,
 DKIM_ALIGNS 0.000000, DKIM_SIGNATURE 0.000000, FROM_NAME_PHRASE 0.000000,
 HTML_00_01 0.050000, HTML_00_10 0.050000, IMP_FROM_NOTSELF 0.000000,
 MULTIPLE_RCPTS 0.100000, NO_CTA_FOUND 0.000000, NO_CTA_URI_FOUND 0.000000,
 NO_FUR_HEADER 0.000000, NO_URI_FOUND 0.000000, NO_URI_HTTPS 0.000000,
 OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000, SUPERLONG_LINE 0.050000,
 TO_NAME_IS_ADDY 0.000000, __ARCAUTH_DKIM_PASSED 0.000000,
 __ARCAUTH_DMARC_PASSED 0.000000, __ARCAUTH_PASSED 0.000000,
 __ARC_SEAL_MICROSOFT 0.000000, __ARC_SIGNATURE_MICROSOFT 0.000000,
 __BODY_NO_MAILTO 0.000000, __BULK_NEGATE 0.000000, __CC_NAME 0.000000,
 __CT 0.000000, __CTE 0.000000, __CTYPE_CHARSET_QUOTED 0.000000,
 __CT_TEXT_PLAIN 0.000000, __DKIM_ALIGNS_1 0.000000, __DKIM_ALIGNS_2 0.000000,
 __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000,
 __FROM_DOMAIN_NOT_IN_BODY 0.000000, __FUR_RDNS_SOPHOS 0.000000,
 __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000, __HAS_MSGID 0.000000,
 __HAS_X_FF_ASR 0.000000, __HAS_X_FF_ASR_CAT 0.000000,
 __HAS_X_FF_ASR_SFV 0.000000, __IMP_FROM_MY_ORG 0.000000,
 __IMP_FROM_NOTSELF_MULTI 0.000000, __JSON_HAS_SCHEMA_VERSION 0.000000,
 __JSON_HAS_TENANT_DOMAINS 0.000000, __JSON_HAS_TENANT_ID 0.000000,
 __JSON_HAS_TENANT_SCHEMA_VERSION 0.000000, __JSON_HAS_TENANT_VIPS 0.000000,
 __JSON_HAS_TRACKING_ID 0.000000, __MIME_BOUND_CHARSET 0.000000,
 __MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000,
 __MIME_VERSION 0.000000, __MSGID_32_64_CAPS 0.000000,
 __MULTIPLE_RCPTS_CC_X2 0.000000, __MULTIPLE_RCPTS_TO_X2 0.000000,
 __MULTIPLE_RCPTS_TO_X5 0.000000, __NO_HTML_TAG_RAW 0.000000,
 __OUTBOUND_SOPHOS 0.000000, __OUTBOUND_SOPHOS_FUR 0.000000,
 __OUTBOUND_SOPHOS_FUR_IP 0.000000, __OUTBOUND_SOPHOS_FUR_RDNS 0.000000,
 __SANE_MSGID 0.000000, __SCAN_D_NEG2 0.000000, __SCAN_D_NEG_HEUR2 0.000000,
 __SUBJ_ALPHA_END 0.000000, __TO_MALFORMED_2 0.000000, __TO_NAME 0.000000,
 __TO_NO_NAME 0.000000, __URI_NO_MAILTO 0.000000, __X_FF_ASR_SCL_NSP 0.000000,
 __X_FF_ASR_SFV_NSPM 0.000000
X-Sophos-Email-Transport-Route: opps_tls_13:
X-LASED-Impersonation: False
X-LASED-Spam: NonSpam
X-Sophos-MH-Mail-Info-Key: NFh6ZEp3M2RneHprQy0xNzIuMjEuMS4xNjA=

Hello,

I have a question in regards to connecting switchdev ports (TI AM62 CPSW in=
 my case) to a switch configured in the DSA framework.
My setup is two KSZ9896Cs connected, one to each port of the AM62x.
Using something like cpsw_port1/2 as the ethernet for the conduit port fail=
s I presume in of_find_net_device_by_node(ethernet) as both eth seem to be =
under cpsw3g which is the actual ethernet.

So when changing the ethernet for the conduit port to cpsw3g I can actually=
 get switch working, and I see it registers under eth0 of the ethernet, how=
ever when the second switch tries to come up it fails because it tries to r=
egister a dsa folder under eth0 again.

I'm kind of at a loss what the correct solution here would be, or if this i=
s currently even supported to connect e.g. a cpsw port to a conduit port, i=
f that would not be the case, what is the suggested work I'd best be doing =
to actually get this working?

Kind regards,
Jesse Van Gavere

