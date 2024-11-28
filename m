Return-Path: <netdev+bounces-147765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D2C9DBACA
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 16:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1014B1612D2
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 15:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF0A1BD039;
	Thu, 28 Nov 2024 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scioteq.com header.i=@scioteq.com header.b="vAmwj6Y1";
	dkim=pass (2048-bit key) header.d=mail-dkim-us-east-2.prod.hydra.sophos.com header.i=@mail-dkim-us-east-2.prod.hydra.sophos.com header.b="DlGtQFCc"
X-Original-To: netdev@vger.kernel.org
Received: from rd-use2.prod.hydra.sophos.com (rd-use2.prod.hydra.sophos.com [18.216.23.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D3A1BD004
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.216.23.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732808551; cv=fail; b=IUextHYleHOd8E/d3zEXYfIcpLRNf2Z97cBLBSYAImbQMNB5wtfvaTDNPhjOuQNNfPfHsXX/3IE3DYIhEYzx6PKCAPT7MvJSyqGw8HkVaOBoprb1siCPFzdLi9Rbcep4YfP05PAjTWH17Z/RIUx+ZgZzk7rK9BAGD3M7ulZMrus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732808551; c=relaxed/simple;
	bh=VdCmmodzQosyy+hwfXikJB9NAvDVOsRG3DFaLgr6I3I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qvBBG+JGBDCFUTv+KuJj9vwLL6SQz0H+2VayYc+iCXIsO/2huglizLEp7sskYpd3FIJH7uF7WeqsqnjlInzN+59hKvdLLUN98Y4LWVJzocIIfb1tJhQs+oLsoPAYLejSt7OZ2sFaM/PCSzhJiisXsDjdGMvIxAcsjMP4zaBwEK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scioteq.com; spf=pass smtp.mailfrom=scioteq.com; dkim=pass (2048-bit key) header.d=scioteq.com header.i=@scioteq.com header.b=vAmwj6Y1; dkim=pass (2048-bit key) header.d=mail-dkim-us-east-2.prod.hydra.sophos.com header.i=@mail-dkim-us-east-2.prod.hydra.sophos.com header.b=DlGtQFCc; arc=fail smtp.client-ip=18.216.23.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scioteq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scioteq.com
Received: from ip-172-21-0-76.us-east-2.compute.internal (ip-172-21-0-76.us-east-2.compute.internal [127.0.0.1])
	by rd-use2.prod.hydra.sophos.com (Postfix) with ESMTP id 4XzgYJ4bYSz5vMF
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 15:42:28 +0000 (UTC)
X-Sophos-Product-Type: Gateway
X-Sophos-Email-ID: 1ab640990bc947ea8f695d895a8862c2
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011027.outbound.protection.outlook.com
 [40.93.76.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by relay-us-east-2.prod.hydra.sophos.com (Postfix) with ESMTPS id
 4XzgYH22xPzKm5D; Thu, 28 Nov 2024 15:42:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frnjA7ck+cgrZIJhomFSh86yi5IGEzBmecvqXQeuC3hGdnYh3znNa4OZKbI89e8ZmluIbzu6Z06een3ktbhLXUQjkDibgJ2/KYbH4TfITHYD/wLiqjyJwUMvomjxPFPoDJJHv6tAu+txK6+GT6SKURj5wWJ5wZ5lplrufrTufn5ocaYzhRQJjw10G2kgFSrRjyWxG8U6hki4LDE1YKNxFGb+a12tdZ/ETNQ7eKTd+fcFN8mhOpCfx+ojU/U5bs3Ra0fwLfd4CCwnjn8K7oLad5Cltx1pbVur29YZ26wGYocfXuj7nPoX+m9cv3uyOHA3fkRdWpZcNpVRuvBo/AKovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdCmmodzQosyy+hwfXikJB9NAvDVOsRG3DFaLgr6I3I=;
 b=CZb5IC4OohwjlRal92MzRCSqgJvk32q0ie5ZRccLIYRT41m4+a4AOOlLM/fFjxQ6uYKJZ4CLtPC1pgq+0ovq6ugVLU4e6x+Bjfy4ZWZlHat2XmXbTbgNrpnsAV3TC/mb6YOwN9wsob9aaJEjzbKaW9+ePRBrpRUWwFDZFxEXT3Nq94g01uOS/RVe20V7CiocMqGa5CrcauLtrA9/MgHZV01Ozd36YOlwVpJIEnbWJj4BrVvWMoeSYyjZtlq+xt1wNaST9ar2kG4bHPygMOBmsX3J6F//5JR51R2nZGE1JpJakZ6LR+Cnkj4nE7Nd4R/BNvWsHBYp9Mrks+vVLpPSYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=scioteq.com; dmarc=pass action=none header.from=scioteq.com;
 dkim=pass header.d=scioteq.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732808538; 
 s=sophose3b6b7cefe1d4c498861675e62b33ff6; d=scioteq.com;
 h=Content-Type:Date:Subject:CC:To:From;
 bh=VdCmmodzQosyy+hwfXikJB9NAvDVOsRG3DFaLgr6I3I=;
 b=vAmwj6Y1/6JB/xH5lBsbvqMIH6XfjyCBihU0k556yMXYCA9DpknHuFMuwMR6tGkL
 KW9UNBDantG2QwPJmagiDRDo3V3nriOQJOtey96jLH3Fdcp+hSp5ojVkM7hQrP418Zd
 fFR2ROAuIw1zuehgjVSPhiabtqE0RlfeGYylb3iiy0u2HTcqd3mbnBBAGEGi6yG5nN7
 2dUnGt1jN9mcKEU3Mb6eE88y2F0moxRorrwAdccmTNnj+ZhuVMdWr7/RZ+B79mctLbm
 lzP1Lu+z0MsW5HZra26xNWe1nz8U0CeHYZiSPYYqtHW93YOTv1on4BxI0cuinbf/RYk
 /yPE5KYCYg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732808538; 
 s=v1; d=mail-dkim-us-east-2.prod.hydra.sophos.com;
 h=Content-Type:Date:Subject:CC:To:From;
 bh=VdCmmodzQosyy+hwfXikJB9NAvDVOsRG3DFaLgr6I3I=;
 b=DlGtQFCcvv//2EU7B8j2BUkabwja2cWpxVu9NDAm3NeAOgIPqKGbfX/AvGDlb5d+
 m4wSDoGJtHrY2TQqq5mmJ21CxbubgA6SJedSXAKGVIMpp9fbLYRy34qkoC7WIoODkti
 ouGWVujyTLS4subOUwIIBRy+7ue7gGnxAvbmljY8aRmioy5SrB+JU9l/0oKTbO4QsS+
 mjHDxxfc0eXK2OrWHjt7PNX1C26p3fuyPhHp8bvzPi+liZ7durV58kGyouu7WB2QHX7
 /EfKYF6DBnFQbo0c75f3v2SP5p8izc9TLSxddp1qMaQGfZXMaldQhPTY01uTamEx2uY
 ZkHYoIhyaw==
Received: from PASP264MB5297.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:43b::20)
 by PASP264MB5648.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:498::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 28 Nov
 2024 15:42:20 +0000
Received: from PASP264MB5297.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3de1:b804:8780:f3cd]) by PASP264MB5297.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3de1:b804:8780:f3cd%5]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 15:42:19 +0000
From: Jesse Van Gavere <jesse.vangavere@scioteq.com>
To: Vladimir Oltean <olteanv@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "woojung.huh@microchip.com" <woojung.huh@microchip.com>,
 "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
 "andrew@lunn.ch" <andrew@lunn.ch>
Subject: RE: DSA to switchdev (TI CPSW) ethernet ports
Thread-Topic: DSA to switchdev (TI CPSW) ethernet ports
Thread-Index: AdtBngHEzdd5mOmhTK2G5m4PFETOTgAApzRNAAHnp7A=
Date: Thu, 28 Nov 2024 15:42:18 +0000
Message-ID: <PASP264MB52979414E483480C8FD26218FC292@PASP264MB5297.FRAP264.PROD.OUTLOOK.COM>
References: <PASP264MB5297F50F5E2118BBFEA191CAFC292@PASP264MB5297.FRAP264.PROD.OUTLOOK.COM>
 <PASP264MB5297F50F5E2118BBFEA191CAFC292@PASP264MB5297.FRAP264.PROD.OUTLOOK.COM>
 <20241128141948.orylugaetrga2bdb@skbuf>
In-Reply-To: <20241128141948.orylugaetrga2bdb@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=scioteq.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PASP264MB5297:EE_|PASP264MB5648:EE_
x-ms-office365-filtering-correlation-id: c31d815b-7d63-48b9-e0d1-08dd0fc33ddd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?mCEVmKSYYP25wbZqka2g5N58DyeW8gRPQ8yEJS3t7cbYbc0yPmf0DKJlbFV/?=
 =?us-ascii?Q?Hw4HhqM53JpGf0JtkwaX89Rk8im2i+P0hEz6yMeZW9wqNfTrI2ezIBLr0KKz?=
 =?us-ascii?Q?DyauhnIXlvvBYhh3ri9UxHuLswxTFpYdH2UlenI5QjunIoijFqK8bRdCh+V6?=
 =?us-ascii?Q?SVFPp6TUiL9qBDfXd4TYaecITlPq66lywnVfQNV7YoA8iUPSSKQbk2y/2hqN?=
 =?us-ascii?Q?TgO9/D41TnkFS5Zh0lAcS0sHMBU2FoVjSMw9nGWAPFoGwHxjWz1Iq82PVADk?=
 =?us-ascii?Q?Ok9VxndjEMz+3zy7ndYa+5dTIVUrkY8PWGS5m/wFfX3Lx/nAX3p1fllHuxJi?=
 =?us-ascii?Q?qf6LVSlUFnzpEevFwHcjCWq1MhPmKUgD7n3NGvgFixn9Bzwum43A0NW+FHLI?=
 =?us-ascii?Q?oFX1hhwkF8p48lJJJuvYHMqEHW+BXDj9Xhd00J1eMgA3R8vHBfD2iRGY9Qdr?=
 =?us-ascii?Q?boLwxzyiGQ3SQA9kth+vS2YDFHmSBd0cwnBc2q03TXgPaqZnFuqXKVdepSyJ?=
 =?us-ascii?Q?dKpx8TpakOTLECYzPdtG6AP6kstCpDcGF6J4m35qPtZyzyn8ZihPiVBqeUGa?=
 =?us-ascii?Q?mavekQWzXX9M3LTZ4kM5qlrNEOv0C7WAmDrUoA2osGODbB7T/rcIAH0hpI5y?=
 =?us-ascii?Q?AsMEJgNJlA0CTT8NbEXB25Juic12r0UBfEL2pafsv1zTrWrwncqN7+30eT0/?=
 =?us-ascii?Q?n2uA2bvQ0HzYTZw8JoFY4i9I+0OiFGFD3ZJdV3dozo0EIo9oi1K+Plzdd09y?=
 =?us-ascii?Q?QxwcbFhLSTVbObHpZRnmTiT4/OzbNrxzd7+ubY+T7XX4K4ykLIwUXCZf43mH?=
 =?us-ascii?Q?7QuPM5b4TaStWRmkcs1I9SMSEhp0hi9iy8X4tKCUlFIjvokIKT6CgB5o96iT?=
 =?us-ascii?Q?W9fXqLBvBUxtdLv3eFti+xXqQdJfyO5G99ygXaRxEAotp5dBjVZoRKPM0PoB?=
 =?us-ascii?Q?/j1wfOB3tb3HzDjChqi7ckOA//Vnn2rSMlWw2uVK3jF52PDQUD998xOTcltj?=
 =?us-ascii?Q?Kxt8A5TCw/q3YbGPcEjBHHouFiYkSsrtY9OjBV8TTRNlrwpnAZlU5fd2luzK?=
 =?us-ascii?Q?1EI2UNUk7z3yoJ5TM42Gr/8olUrIIXNyRVJFG+t9dbh09k3KKwKLHMPXqVRb?=
 =?us-ascii?Q?7zeu3qTuSmBIh0DgTRG38Qbo4jXowgwPEsIvkBYXu1AryQ6PpQsNgba6Pa5Q?=
 =?us-ascii?Q?vf/riASJP3Ej5U6GcyO+UHFq9wbZicfQa3CI6qGXpq7wspEvC0sLvjJQ5pkh?=
 =?us-ascii?Q?8UcO+lTTdYBwyV3sh9Emx+VYYmPXKK+pwn40goQSmx9Qc1WqQRb/N3UUoG4U?=
 =?us-ascii?Q?xcNvE/4i2X39TnhoOA5abEYBsy/uxZezoNvzKem7QroP3GKlhliUsSsutHwU?=
 =?us-ascii?Q?VX0GvrsJiAkkBx+Fcl5eux1Tv132N3gWt1lvoRf0377Utj22sg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PASP264MB5297.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Avip70RoRy1jmgkcdAVzXiU/CpTWCF6/3jIhExNmiHDVorlRjgM5wh96+fiO?=
 =?us-ascii?Q?fYZLrhmFtbf0GsrD3hGvMMEBYqZPMH/qqgvp/QfD0mUNkc4l7f5GrOO8hfJE?=
 =?us-ascii?Q?h1nBXSACjpBfI8pxm/dQv4ddAlGqOM6xDgUtPo7guVmqyArwNEg1L6rqgVN4?=
 =?us-ascii?Q?qlTjBulNdz4316aW5G0PFzEd5RDIFx4wnT4Z3W6dfO+SrQkKCdLci7Q5yKII?=
 =?us-ascii?Q?lVJZc3PgOr+lM/x7KZzomJOeavmyQiPB4nt94Dk95yIeRaEXKXX0Ob6FHnsA?=
 =?us-ascii?Q?06jLpyJt1MA9uMKjLw4gYZ7COlCeD0Zlzdh8Fhm8CVg4t7wFZ+PuLbJgsxIB?=
 =?us-ascii?Q?o4u8DeKTZzPtgYCcCrnxv3b1SwyZT3gt4n9dVxzoXU2vhQAgOhEasBlXSEbY?=
 =?us-ascii?Q?DNGjrSXRmu4x51Ul7dxCbvysABWFfyhcKD+ZWOtxSziDtRgKajk8t23lGKDb?=
 =?us-ascii?Q?1OQThZ53U46NjcfZLGk7xHWNkE+UuXzQ8g/aEFvK18M4SIOx/qodPyz5Sv4x?=
 =?us-ascii?Q?0t/W75CDQCeLbYenqOorrGLnacjOj1eY3cqU0Qe3bVZshFQb643jryTun548?=
 =?us-ascii?Q?/v5n2NvWuL2fsCPFzn22kdzz+KdQTHpQPpIu7KEjJX4kXdsNCqivKV9pyvey?=
 =?us-ascii?Q?vg1Bsi/ApzQ92qc/kXCayzC7aRiZqjoOMw752pCWKQPfPooFmIyxaXQL7n/c?=
 =?us-ascii?Q?OlBMkFXI13crjxb76zMEODNGeqxKKkZqRaehTEqFTllQcckfVEalxC1xQCP9?=
 =?us-ascii?Q?ouFXjWaWPSY+sBRJRURYCJkR4KGeM3aFniriOegzhAGi/OboEqUVtGS8EoYX?=
 =?us-ascii?Q?ZkVQEFfmGHa1IRrcKz91iQ6vGtU6GRAE+wMBVMBI7NixGRr8RlgLd6pxJ6jG?=
 =?us-ascii?Q?0mjvqwSuI2x1aXsFwvXadm0lChEd+AMiFEM+1fHxTgho/Ud7u39R771yWrPN?=
 =?us-ascii?Q?ulFqSzZBS75OggJT2jODwMZNV1y7y7YRZGtcHhZeWHxHhwAn3JN/zbuCH6Gu?=
 =?us-ascii?Q?bLva+t1WLSSAS+/bJv2rr2I45l8bpTlzlsx2RFXb39iLjCLWAYhLXro6jsCL?=
 =?us-ascii?Q?wWI2jdu8ZLOkN/CwGQaKPkJz9CwB8sxtxATnblYO/nDKBSUJLkpJAN2O35P5?=
 =?us-ascii?Q?MBlrZ8gpXiax4OOZv+F7cWr60jP7iPB+x1c8XwTW8qBvTOKP+eCDG+a27wGp?=
 =?us-ascii?Q?id30SqJXhJufxmNf/fIJs2aPyJhBIkJ6ZyixapQzlwR8v8REdLRZf6XbN1Z6?=
 =?us-ascii?Q?aPYvtNDuOtzUobrdqHdKppHkLRVWRekKhM0B1xRQ9M8T6dzRml+l5XD/w2wX?=
 =?us-ascii?Q?mwjqYwCB0EN5g6Hgv2xlW0fb/GBvmnq8ZvU5tU/bujlNiTP09tItomDh/Rrt?=
 =?us-ascii?Q?x2fdxEhxJClQBGtwZGCt4CMRN3k2O9zPBzq6kaYOHBeVb7v9PCsyxvyyCzqU?=
 =?us-ascii?Q?y/HeeTUxegCDqZwI87pYiuNucQg8+oilK0RPtg3aCtApNEZFWq9D70Z+O65V?=
 =?us-ascii?Q?YjLF4qhUAk60xvO1JBIYyNBIBLku0+6lgu5V4jq53Y5UIZb4p4E/ZGk2oxct?=
 =?us-ascii?Q?WN7212akQBCNDZE+OoJCuUK3SRbkkFW5nfDaR0r5FHMlXU3JBcAudetF7v5q?=
 =?us-ascii?Q?Tg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Pwg5AWQfJJN0H49lcP0AsKLBtYaCgZeeJ/Eq70CpXVHRcoWZQfpDN9U49a08BOVaZRYdn2H+7IxUzv1sQCBk0dvG7uDKyvobA/ZmYVVXEH5cKVjqTd11aXGqNpRWOO4suYCL9H6Zv96Ea/5zwMbRP6evV6G3C8miI+46IH0FBe0TxutKJnIhPYuzHuXeHmjn6StvoJxD+mN2hBwcAGx17WhxvicCCH1zW2msOk4myPWunlr6Mp5E8yxx9qdX8DDhh2t6FH+iAZKg+Gzzc7B6R/KU13bFdD9ISZ6TclPlGK4fiDS2lkERq+TeTfaNd0+YxJ/dXBMPwUZZGJRtUiq7i+CWG11KfYpcEdYuKE8xrCOoN0Ue8L3Lblwas351d/Dy7EsyQ7IsUmFRA+s1g4W7WCGyOVmvfE1m4+4ekzO1VlqeZc97TwBO16c6B+5eecI6pc7bBqRkAbNW0syTrM4FBYCQ/nvCojusXHXCTBdSzByH0rtgQ7IO7X+iEJh8Okh0MrO2+w8LTL13pXyyWOm+t3RT7sTO3Pi9aZATbf4hTmAOS738ef7KOkJcfN9UcLZMYiWp+LL4FRE8rJNH3LVOYOyI9ExqQSsnh313SwZ1OPbsHsfAFfyJJfBA7DXzGUnjGWEvHbmMMsHliH+RrN6rsqq9YblNXSFB5uToJOjR2vs=
X-OriginatorOrg: scioteq.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PASP264MB5297.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c31d815b-7d63-48b9-e0d1-08dd0fc33ddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 15:42:18.6874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f3e5b271-16f7-46b9-bdb3-4271ac933ef0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G+b1OZLn4hlyPTgQNrlyrWXRSMXSsdgOZ1cuaJ3tYOJ1lZGt/b/JWEsSzAxSJdXylXyQSJ+CSCCqN9Ttn2Cr6U9xePcaCIP5N49RFS0mT8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5648
X_Sophos_TLS_Connection: OPP_TLS_1_3
X_Sophos_TLS_Delivery: true
X-Sophos-Email: [us-east-2] Antispam-Engine: 6.0.0,
 AntispamData: 2024.11.28.151546
X-LASED-From-ReplyTo-Diff: From:<scioteq.com>:0
X-LASED-SpamProbability: 0.085099
X-LASED-Hits: ARCAUTH_PASSED 0.000000, BODYTEXTP_SIZE_3000_LESS 0.000000,
 BODY_SIZE_1900_1999 0.000000, BODY_SIZE_2000_LESS 0.000000,
 BODY_SIZE_5000_LESS 0.000000, BODY_SIZE_7000_LESS 0.000000,
 CTE_QUOTED_PRINTABLE 0.000000, DKIM_ALIGNS 0.000000, DKIM_SIGNATURE 0.000000,
 FROM_NAME_PHRASE 0.000000, HTML_00_01 0.050000, HTML_00_10 0.050000,
 IMP_FROM_NOTSELF 0.000000, IN_REP_TO 0.000000, LEGITIMATE_SIGNS 0.000000,
 MSG_THREAD 0.000000, MULTIPLE_RCPTS 0.100000, MULTIPLE_REAL_RCPTS 0.000000,
 NO_CTA_FOUND 0.000000, NO_CTA_URI_FOUND 0.000000, NO_FUR_HEADER 0.000000,
 NO_URI_FOUND 0.000000, NO_URI_HTTPS 0.000000, OUTBOUND 0.000000,
 OUTBOUND_SOPHOS 0.000000, REFERENCES 0.000000, SUPERLONG_LINE 0.050000,
 SUSP_DH_NEG 0.000000, __ARCAUTH_DKIM_PASSED 0.000000,
 __ARCAUTH_DMARC_PASSED 0.000000, __ARCAUTH_PASSED 0.000000,
 __ARC_SEAL_MICROSOFT 0.000000, __ARC_SIGNATURE_MICROSOFT 0.000000,
 __BODY_NO_MAILTO 0.000000, __BOUNCE_CHALLENGE_SUBJ 0.000000,
 __BOUNCE_NDR_SUBJ_EXEMPT 0.000000, __BULK_NEGATE 0.000000, __CC_NAME 0.000000,
 __CT 0.000000, __CTE 0.000000, __CTYPE_CHARSET_QUOTED 0.000000,
 __CT_TEXT_PLAIN 0.000000, __DKIM_ALIGNS_1 0.000000, __DKIM_ALIGNS_2 0.000000,
 __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000,
 __FORWARDED_MSG 0.000000, __FRAUD_URGENCY 0.000000,
 __FROM_DOMAIN_NOT_IN_BODY 0.000000, __FUR_RDNS_SOPHOS 0.000000,
 __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000, __HAS_MSGID 0.000000,
 __HAS_REFERENCES 0.000000, __HAS_X_FF_ASR 0.000000,
 __HAS_X_FF_ASR_CAT 0.000000, __HAS_X_FF_ASR_SFV 0.000000,
 __IMP_FROM_MY_ORG 0.000000, __IMP_FROM_NOTSELF_MULTI 0.000000,
 __IN_REP_TO 0.000000, __JSON_HAS_SCHEMA_VERSION 0.000000,
 __JSON_HAS_TENANT_DOMAINS 0.000000, __JSON_HAS_TENANT_ID 0.000000,
 __JSON_HAS_TENANT_SCHEMA_VERSION 0.000000, __JSON_HAS_TENANT_VIPS 0.000000,
 __JSON_HAS_TRACKING_ID 0.000000, __MAIL_CHAIN 0.000000,
 __MIME_BOUND_CHARSET 0.000000, __MIME_TEXT_ONLY 0.000000,
 __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000, __MIME_VERSION 0.000000,
 __MSGID_32_64_CAPS 0.000000, __MULTIPLE_RCPTS_CC_X2 0.000000,
 __NO_HTML_TAG_RAW 0.000000, __OUTBOUND_SOPHOS 0.000000,
 __OUTBOUND_SOPHOS_FUR 0.000000, __OUTBOUND_SOPHOS_FUR_IP 0.000000,
 __OUTBOUND_SOPHOS_FUR_RDNS 0.000000, __REFERENCES 0.000000,
 __SANE_MSGID 0.000000, __SCAN_D_NEG 0.000000, __SCAN_D_NEG2 0.000000,
 __SCAN_D_NEG_HEUR 0.000000, __SCAN_D_NEG_HEUR2 0.000000,
 __SUBJ_ALPHA_END 0.000000, __SUBJ_ALPHA_NEGATE 0.000000, __SUBJ_REPLY 0.000000,
 __TO_GMAIL 0.000000, __TO_MALFORMED_2 0.000000, __TO_NAME 0.000000,
 __TO_NAME_DIFF_FROM_ACC 0.000000, __TO_REAL_NAMES 0.000000,
 __URI_NO_MAILTO 0.000000, __X_FF_ASR_SCL_NSP 0.000000,
 __X_FF_ASR_SFV_NSPM 0.000000
X-Sophos-Email-Transport-Route: opps_tls_13:
X-LASED-Impersonation: False
X-LASED-Spam: NonSpam
X-Sophos-MH-Mail-Info-Key: NFh6Z1lKNGJZU3o1dk1GLTE3Mi4yMS4wLjc2

Hello Vladimir,

>Caution! This message was sent from outside your organization.
>
>On Thu, Nov 28, 2024 at 02:01:23PM +0000, Jesse Van Gavere wrote:
>> Hello,
>>=20
>> I have a question in regards to connecting switchdev ports (TI AM62 CPSW=
 in my case) to a switch configured in the DSA framework.
>> My setup is two KSZ9896Cs connected, one to each port of the AM62x.
>> Using something like cpsw_port1/2 as the ethernet for the conduit port f=
ails I presume in of_find_net_device_by_node(ethernet) as both eth seem to =
be under cpsw3g which is the actual ethernet.
>>=20
>> So when changing the ethernet for the conduit port to cpsw3g I can actua=
lly get switch working, and I see it registers under eth0 of the ethernet, =
however when the second switch tries to come up it fails because it tries t=
o register a dsa folder under eth0 again.
>>=20
>> I'm kind of at a loss what the correct solution here would be, or if thi=
s is currently even supported to connect e.g. a cpsw port to a conduit port=
, if that would not be the case, what is the suggested work I'd best be doi=
ng to actually get this working?
>>=20
>> Kind regards,
>> Jesse Van Gavere
>
>Having ethernet =3D <&cpsw_port1> or ethernet =3D <&cpsw_port2> is what sh=
ould have worked. What is the actual failure?
>
>What do you mean "cpsw3g (...) is the actual ethernet"? How many netdevs d=
oes cpsw3g register? 2 (for the ports) or 3?
>
>Your setup should not be a problem in general, the switchdev model is comp=
atible with usage as a DSA conduit. Could you print with %pOF what is the n=
dev->dev.of_node of the 2 cpsw ports?

Thank you very much for this information.
It immediately pointed me in the right direction and I could see this was A=
ddressed by Jacub Kicinski in commit 29c71bf2a05a11f0d139590d37d92547477d5e=
b2
The netdev of_node simply wasn't being populated yet in the branch I'm work=
ing on, everything is working as expected now!

Thanks a lot!

Best regards,
Jesse

