Return-Path: <netdev+bounces-65217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F745839ADD
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E60C4289478
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04089525B;
	Tue, 23 Jan 2024 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="L956hNUQ";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="L956hNUQ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05hn2211.outbound.protection.outlook.com [52.100.175.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920A04400
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.100.175.211
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706044212; cv=fail; b=pmLRQFn6hy2A8EuoDxF7rbQUibv8bD0Qt57dRe3R6033Iyias1y/Dmzd1/PzMZIMf+PFn4ijoA9Ij9nWiB45FmISgzrYZ+BUbyYn2ZvWHdctmQIWBiP5BRImLl7hVRsTIXuHZGErgYc76Wc7mBqGXGDXKLQTN4hfchqpEUkhYFY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706044212; c=relaxed/simple;
	bh=9brirROGCUkcW/mww89AnTwNBy7Qn+rdt0faRTQ8bcY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DEjZ748Xc9PGeY0XkHozzp8l4z9KK4UkYPHOIPWqgxez7oUetF4AkXl1Oiot5uBxeKfj3qhFj0sFpEmdZvneC4sLZ4PaX2pX7K34GwO8RoBPdTtw4yiSpwtQdz03+majEYhKR6FkL18DTxlJqavc+tttJf4ayV+pRnWtJ9tj9mo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=L956hNUQ; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=L956hNUQ; arc=fail smtp.client-ip=52.100.175.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=DRT5Iba9bSPC7ydQ00hCnJZ5Gn6zHayvkYjBaXo4ZEwjizBtyIlrSgs471mbkiOOgo0QJBElJpC3HjTA9enoPU7FwsHRtqLUISBeEErOAfNRpdXbuXFc6lqdTHvn3eGpPydDGBPhY/MPnqJLSej+sIpKB2dG+3BqW/C7l6FZ8uD1WzyHvKuxH+17PDcd+K7DeDLuHVl9g9qjztCsMyga1NTluHgt4F+F1RWy3Er5gZmVlL/zTUsAD4XUQ4vNt4Cl334kOh9sOxsOFxq+chtKcu10UbVqtinuDc0xIIiAkin3nOOW3WrMSSO6UVtwgXnUGyi0Bkao+JXwtUciKApA9g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zw4zm7HsapoUPiKYFzNZCAz/CcIk01SrONyl9hogGFM=;
 b=DO3C45J0AawJgQ/zWczdWwtYvwYsR8Y4yk/ww2N4jPij+MjZOQqi+PZ4PQwJSdbXvaZWK4NIPqJVFULuAL3QJPJJzBOHtvQwnstu6FQkV/jEd8MwSfHn5t9X++UqHRJK2fPPkdqKxBXBwdRgtK65iB0W+4f04SAfnxNowaS2UpjnC7+8vIq2eHy89DgrLxjSdS9LiPBSckQGfZEgEuQrIeqXJAG0IbRW+wrvqRQAkmG34z8+VSRrVxnBG090+5DFcrhHaGSRk/Ikg2Hy0hUpTrDIgCrEVYSe0tZ/LGAQHmgZnblhEcSdO3/ZPo5ziVWfg0gLjVhQ6+IjPzkISs5cow==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.84) smtp.rcpttodomain=arinc9.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zw4zm7HsapoUPiKYFzNZCAz/CcIk01SrONyl9hogGFM=;
 b=L956hNUQ63xgIS8PjHuYfUmBeawUN0b18UrIFgoYyGlMyObilkZ0HjfJ00itatMu0AQ7xvRfLBkEYe9DfkeUj1eRmeES5wzFD+8UY9/vFQV8jrN4u5V1z/4BSRKc9I16kITrlmZxpxgV64nzW1XM+OwPwkVLRGb/UzWoZjEmGhLzqo7QD1+ACQy0I/1GKKyUEMKZlLi7OyhiVMBqRCKR4guwHyPrw9Sc2p/hM7k3hLNBTsVmIWGHg5yQynEIyT+HkNYz0esFprMuVuN5lI6povkm+7amcKw2gAmIuMBY8GPUGVua8PDcCWFIPO8b0UO+9ZmgZuy2UaBY75GFsdC7LA==
Received: from AS8PR04CA0117.eurprd04.prod.outlook.com (2603:10a6:20b:31e::32)
 by AS8PR03MB8808.eurprd03.prod.outlook.com (2603:10a6:20b:537::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 21:10:04 +0000
Received: from VI1EUR05FT012.eop-eur05.prod.protection.outlook.com
 (2603:10a6:20b:31e:cafe::69) by AS8PR04CA0117.outlook.office365.com
 (2603:10a6:20b:31e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37 via Frontend
 Transport; Tue, 23 Jan 2024 21:10:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.84)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.84 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.84; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.84) by
 VI1EUR05FT012.mail.protection.outlook.com (10.233.243.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.22 via Frontend Transport; Tue, 23 Jan 2024 21:10:03 +0000
Received: from outmta (unknown [192.168.82.133])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id EE2EE2009538F;
	Tue, 23 Jan 2024 21:10:02 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (unknown [104.47.51.232])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id A94622008006F;
	Tue, 23 Jan 2024 21:09:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8ZvmOrEgCUKwroZqdqMlpLxIFsGvI1ORCaxpAEs4HdrvYC9+5CSGFXj1n5Vd0O96eiUEtz4C4RoQP82YNdp0Xg6DxlhFe3b3TZ70SzDwomlllzgi186EhWszsKSlNYUJLgB/J+2dhi0fejPYhV0DsJfAMrgeWbOgd8Z2DNbb117Pcc9Dejw9j6kCZVZRALAMZrZcz5J0Ewbdxd2hJQf1QVPz11F53fGIdEK/QuaYrT3S7ckA8okO3MfSFs9M8kOlNWmnz97Ztw2jpZhNeoxAGF1y2HswLAlh+dW62tErz9I9wsXecerWZoOfZhyLInVAm+NkupNkSLrv9fCa1kvqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zw4zm7HsapoUPiKYFzNZCAz/CcIk01SrONyl9hogGFM=;
 b=CwwcfgVPupSmT8wiXh2rc7D2OaolDZcRAUkwVLsUK46BsXFIDEwpmP3W558Npy4UgMr+tlTmnkw1sFRGI1ut0hjdvROQusYMdzZ2mkLCOnfmOrkn0zlDs6G+tA929f4MiB7mg7LRyN873QxgP2/ZClpDWM7a6zRkufP/NiUnQwq4eZ+qw0UZel8AiQXB2tQBb0DmCBdOJZt/FjmfmHRI5d3PWzXl5fAQoND90j2RfTj0iU76uVq0YtfNEk1A7hlMcDOaHiIidTf9qmroWIk7ScDMOUE1Y6qPC/m6kmOsPY+5v5K2N4c5w2lBYraTmERvbGXTGriZtkW6ErtxcCazPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zw4zm7HsapoUPiKYFzNZCAz/CcIk01SrONyl9hogGFM=;
 b=L956hNUQ63xgIS8PjHuYfUmBeawUN0b18UrIFgoYyGlMyObilkZ0HjfJ00itatMu0AQ7xvRfLBkEYe9DfkeUj1eRmeES5wzFD+8UY9/vFQV8jrN4u5V1z/4BSRKc9I16kITrlmZxpxgV64nzW1XM+OwPwkVLRGb/UzWoZjEmGhLzqo7QD1+ACQy0I/1GKKyUEMKZlLi7OyhiVMBqRCKR4guwHyPrw9Sc2p/hM7k3hLNBTsVmIWGHg5yQynEIyT+HkNYz0esFprMuVuN5lI6povkm+7amcKw2gAmIuMBY8GPUGVua8PDcCWFIPO8b0UO+9ZmgZuy2UaBY75GFsdC7LA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DB9PR03MB9829.eurprd03.prod.outlook.com (2603:10a6:10:456::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 21:09:57 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84%7]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 21:09:57 +0000
Message-ID: <fbd00642-ab9c-4573-95dc-abba064b0068@seco.com>
Date: Tue, 23 Jan 2024 16:09:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 03/14] net: phylink: add support for PCS link
 change notifications
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Landen.Chao@mediatek.com, UNGLinuxDriver@microchip.com,
 alexandre.belloni@bootlin.com, andrew@lunn.ch,
 angelogioacchino.delregno@collabora.com, arinc.unal@arinc9.com,
 claudiu.manoil@nxp.com, daniel@makrotopia.org, davem@davemloft.net,
 dqfext@gmail.com, edumazet@google.com, f.fainelli@gmail.com,
 hkallweit1@gmail.com, kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 netdev@vger.kernel.org, olteanv@gmail.com, pabeni@redhat.com,
 sean.wang@mediatek.com
References: <E1qChay-00Fmrf-9Y@rmk-PC.armlinux.org.uk>
 <75773076-39a2-49dd-9eb2-15a10955a60d@seco.com>
 <ZbAch9ZlbDrZqzpw@shell.armlinux.org.uk>
 <e3647618-b896-47a2-b9b9-c75b56813293@seco.com>
 <ZbAqK+RbuJZ6d4tK@shell.armlinux.org.uk>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <ZbAqK+RbuJZ6d4tK@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0066.prod.exchangelabs.com
 (2603:10b6:208:25::43) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|DB9PR03MB9829:EE_|VI1EUR05FT012:EE_|AS8PR03MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6449e1-5b2d-469f-f54c-08dc1c57aae9
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 V7mWAGsatjIDi7l32WsigcWRZutvmFj5Dig2zO98uj6mX/0fjQ01Y/Gsji18OlccoX08n2pwSC9VcPKSHnmMj6CbO5vSiiZ4XT+HfYnUS/w5a6vdZIcNQCFLqZ1fdqIJYbzDHEiq1MUzZRbf9WfL/wC7WsWcpZ4U2ZMgoK7h7xyyBxeB+EjTLMp9gFiAM18ulRyWL6sr3hZBax93oZ7l/0gqQR6GjI+jXNJrimsvJ2zTQ9dcJUuu50RbZOzrQ4WOFFa3XvM3ohdw02bobnQ89JM400INQBWc1U1Ckkpr/t6YGNhOQoE7gsSgtBDqpOI3nhaqZz7s/YOS3bKp8ghP/j+XQ39RXyILXYbzMwq4c2xEIrok2qB2BrgdTDYQGcPpV0NE2pCZVEHEwDTWQO+38B5YahGHtt6U/Cq78Y+4opUvub17ZccL8DblZ+fNIbha6Az90P6NuEHAge/Yv95QQuWO5q1AcDHS8VeksxOQOv+Ny9efPFTgKwjcJq6sBGPS380m2zm96AJPzB8qY9YH4osA8gDpsU+tiVtwM0ie50R01rtIqtO80tcIgVDmgBOU4awLjoCkgVR8+BgqiZ75BQh2COKZuvS1WjTpgQ7QOBH1z5LRLh22nONj5DT7+JN1FI5mAODOIg2U1ADodp7Usd9fFcEcxkigQ1VwYFvveHvlsN01didUQT/hfrVbkIni
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39850400004)(396003)(136003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(31686004)(83380400001)(478600001)(2616005)(4326008)(7416002)(15650500001)(5660300002)(66476007)(316002)(8676002)(6506007)(66946007)(8936002)(6666004)(6512007)(6486002)(44832011)(66556008)(26005)(6916009)(52116002)(38100700002)(38350700005)(53546011)(2906002)(36756003)(31696002)(86362001)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB9829
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 VI1EUR05FT012.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a726a26e-f377-4a54-bb5d-08dc1c57a749
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K1LHZtUmol0ga2EcH4Ssage3KyTFQXz8ATUDWckJSf73wRQD3wWgFqE5TAKRe2VwaA8SeYPhb8+3uldxAX8PT5OP+DQLTnLII8cquHg/+AlgjonWmIaXDwbw4lnTi/yohPX1bpLbndbcsXA5RVaUotZLGZSfFfVgVhcuQyZ4LzsiQMZ/7NeUMHHNWxSJeJUu6E/LDGTW5syjOruEhss0GVkzIu1mOzkoiWkoqZQ0+N0HfpT4lQC3FgP68UpoxoR2t2JIarg6dSGJbaQl16gVTgGVxefIt1LBhHeigNuoAKY8mDknT8jsbE4PtJn/whSMwYEtYLvbJzcvchvv2DfSwEQu5FK0x+eLwbJoHz3FHQPLqKr0ua10SGgYa7pLzzcA+tR65c5P9R7UjFV9xH752+ByRU3PPPz/hv1rrrTutn0upDn/JMFswiThUJXBcdqTIo0nxAeAeclXfabnMl44nnJNdql9O+DXXQ98TrrHmDFG2Mza0lwFwP1yZ6cJ1wrcNYQPR6rW2X4SZ8bNRpg9Iqq1wAAOPdBN4mSbjeKKOR0gAqYhF0SPWy+Wpf/HrlxKx8CVDx25e8gb6yLTngS075mJUj99Ex69qK9v9rIJS9OqinUcM9E5jKgFe1aJycpk4eesrOWPMt+dAR52yiRC90bfaD6kQ9JT8V1W+W7tGIy6rXrBt/xsLDrMA2vAvAB3Bojt2lUQoO4zBQ4gBJRzqyVTE9YRG8/pgP/x4Cro3JkXrioJJKeEOVm+Fz9tttEqddsfNjn9dNfAAY5Ag4DqprY13MQ6pbCa4ZyPvXX4UwPhxUS+QHPwO+4slqFw0bF+4BPZdPeyd5WXehZqkgmQtg==
X-Forefront-Antispam-Report:
	CIP:20.160.56.84;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(39850400004)(376002)(136003)(346002)(396003)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799012)(5400799018)(36840700001)(40470700004)(46966006)(31686004)(40480700001)(40460700003)(36756003)(86362001)(31696002)(41300700001)(34070700002)(478600001)(6512007)(82740400003)(47076005)(2906002)(36860700001)(83380400001)(53546011)(6506007)(336012)(2616005)(26005)(5660300002)(70206006)(6916009)(70586007)(7596003)(316002)(6666004)(356005)(7636003)(6486002)(8676002)(44832011)(15650500001)(4326008)(7416002)(8936002)(43740500002)(12100799054);DIR:OUT;SFP:1501;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 21:10:03.4022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6449e1-5b2d-469f-f54c-08dc1c57aae9
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.84];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VI1EUR05FT012.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8808

On 1/23/24 16:05, Russell King (Oracle) wrote:
> On Tue, Jan 23, 2024 at 03:33:57PM -0500, Sean Anderson wrote:
>> On 1/23/24 15:07, Russell King (Oracle) wrote:
>>> On Tue, Jan 23, 2024 at 02:46:15PM -0500, Sean Anderson wrote:
>>>> Hi Russell,
>>>> 
>>>> Does there need to be any locking when calling
>>>> phylink_pcs_change? I noticed that you call it from threaded
>>>> IRQ context in [1]. Can that race with phylink_major_config?
>>> 
>>> What kind of scenario are you thinking may require locking?
>> 
>> Can't we at least get a spurious bounce? E.g.
>> 
>> pcs_major_config() pcs_disable(old_pcs) /* masks IRQ */ 
>> old_pcs->phylink = NULL; new_pcs->phylink = pl; ... 
>> pcs_enable(new_pcs) /* unmasks IRQ */ ...
>> 
>> pcs_handle_irq(new_pcs) /* Link up IRQ */ 
>> phylink_pcs_change(new_pcs, true) phylink_run_resolve(pl)
>> 
>> phylink_resolve(pl) /* Link up */
> 
> By this time, old_pcs->phylink has been set to NULL as you mentioned 
> above.
> 
>> pcs_handle_irq(old_pcs) /* Link down IRQ (pending from before
>> pcs_disable) */ phylink_pcs_change(old_pcs, false) 
>> phylink_run_resolve(pl) /* Doesn't see the NULL */
> 
> So here, phylink_pcs_change(old_pcs, ...) will read old_pcs->phylink
> and find that it's NULL, and do nothing.

This can happen on another CPU. There are no memory barriers on the read
side (until queue_work), so there's no guarantee that other CPUs will
see the write.

--Sean

>>> I guess the possibility would be if pcs->phylink changes and the 
>>> compiler reads it multiple times - READ_ONCE() should solve
>>> that.
>>> 
>>> However, in terms of the mechanics, there's no race.
>>> 
>>> During the initial bringup, the resolve worker isn't started
>>> until after phylink_major_config() has completed (it's started
>>> at phylink_enable_and_run_resolve().) So, if
>>> phylink_pcs_change() gets called while in phylink_major_config()
>>> there, it'll see that pl->phylink_disable_state is non-zero, and
>>> won't queue the work.
>>> 
>>> The next one is within the worker itself - and there can only be
>>> one instance of the worker running in totality. So, if 
>>> phylink_pcs_change() gets called while phylink_major_config() is 
>>> running from this path, the only thing it'll do is re-schedule 
>>> the resolve worker to run another iteration which is harmless 
>>> (whether or not the PCS is still current.)
>>> 
>>> The last case is phylink_ethtool_ksettings_set(). This runs
>>> under the state_mutex, which locks out the resolve worker (since
>>> it also takes that mutex).
>>> 
>>> So calling phylink_pcs_change() should be pretty harmless
>>> _unless_ the compiler re-reads pcs->phylink multiple times
>>> inside phylink_pcs_change(), which I suppose with modern
>>> compilers is possible. Hence my suggestion above about
>>> READ_ONCE() for that.
>>> 
>>> Have you encountered an OOPS because pcs->phylink has become
>>> NULL? Or have you spotted another issue?
>> 
>> I was looking at extending this code, and I was wondering if I
>> needed to e.g. take RTNL first. Thanks for the quick response.
> 
> Note that phylink_mac_change() gets called in irq context, so this 
> stuff can't take any mutexes or the rtnl. It is also intended that 
> phylink_pcs_change() is similarly callable in irq context.
> 


