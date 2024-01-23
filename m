Return-Path: <netdev+bounces-65212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CD9839A51
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9971C21F75
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 20:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BC41FC8;
	Tue, 23 Jan 2024 20:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="nqIEn9KI";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="nqIEn9KI"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-cy1gcc01bn2064.outbound.protection.outlook.com [52.100.19.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1901F1FB2
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 20:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.100.19.64
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706042054; cv=fail; b=r3tMhIeaUkJYEItq4GKEvaAkEh+/pnpmuGE7ng3WTeGRQIjU7/pYyPs7jaSGIuRPUu14FXA5X8ofLRobaGJxKPvPXPd6XO2Dwk0x/+sJ26KBwooHlz7iyE2w/Kv8f8n76s0JZXxLOVteUCIoCeg9QHbJf03zR5a6Gtbv7hrAa/4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706042054; c=relaxed/simple;
	bh=1I1eoy/HAdrOto4kk/VdeOQgzq4ZVN6tTIz4UtAYnMg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gsj8G3JBf/mGyBKxWPPLyetaYJjh0VzOSb7GntGDWATI7MjIcn1E74q0GKok3DiHxieAIA4uCcMDRr69rNyF4FftT4cn9/T8HnseMYj9AVsQBZm0NjjOWFyu3AFFq+ZU+aJsMbVaVDDM4GqQkihxz57/QJcE7MKGasHJrlmOiK0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=nqIEn9KI; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=nqIEn9KI; arc=fail smtp.client-ip=52.100.19.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=gbiX615xromF4lngM47rjomgLV38LxYgfZUVZWvKID5TnRDKvpTRCC4KO21F+8AGM5i9nxrmTYDOARLh1gH9goH58sY4kFcr5R3R9qtArYycf+ut3K7yMdQrUQVbY2eL4i2HLmE1LK9JlFe6g2T6zFC3EHVAkrApx21YUK0T+pPts4lQuw3qstPIuk2EnWo1Y83+US2g6dX+X48Vy/BBu6Z0rHie/9EVo2IPgX1+arEtKG34Wh5VFORktQxFilYfIbF/TzsRiV0hdujTTMsHQHnjj767xZKVmUdOTK8+AOVUv7OgWeC09USTQOoQo/lfPSEwAW80317vE3fQKx1wGg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgE/B/vrKFQdLqwpJfrrRv3zFR8n7DbGe7yItbWljXE=;
 b=OjrtXOZ9j4ZQaX+NAdD89DeBUWJZXPms3CUK58bGsHuIGpqyq5BWpmXSeWhJ1iuFMF7xkW3S65zK16tEDXjOXHjAFN55VBS+efyW9amaHUcYi4qHLqVFwq5b0MCVIuqY59P2/4WHzig7f6DAoThuBMStKgHM2M0BkH9UYvjxw7Q6itlTqeC0mNSpuA9gVXYclWlvQFszIzpCzKFl9PAxTxhp0k7a0jMFFij+kX39NzqnbR3o7+kMkharUejFf+9c1L34GolaoCgxqrrisf14RBB5lUfTkjquwKBq7SMe2fJaO4ojSAI5FmX0XsCOp7l0UPdiPTwQXd2nw8ylGxTJpA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.85) smtp.rcpttodomain=arinc9.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgE/B/vrKFQdLqwpJfrrRv3zFR8n7DbGe7yItbWljXE=;
 b=nqIEn9KISY/8te3+bRomEu/EPeVrTC7ds/0K7K5AQ493J8kSL+Tx9aNlk2T/4jfOQdtwiJrkbgSX8C3KaR6J6XUqE4gHopC0RIwOcgKZiY0wKD1kRqTEU7m0zwr51zhfhx1icQ4QqK/Cf0ELecqREzHfkxkbdsiQePERu/mNlmFdwKKb0+D66YKIo9WK2Ntu7CHYHMrcVyY3ufYj0eprT9KNhMZj0KvviH8sAjSEDNdjAZkRmQ4EwwicCRPVsoE/wPEbyywXa0dK7GF7iGG4kQ3Cc04vBG3h51UW51uJLWjew36g0X6U9HduQYSfs1EIZgsefUJPq6Tajte+tjBDUg==
Received: from BE1P281CA0240.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:8c::9) by
 GVXPR03MB10382.eurprd03.prod.outlook.com (2603:10a6:150:149::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Tue, 23 Jan
 2024 20:34:05 +0000
Received: from VI1EUR05FT046.eop-eur05.prod.protection.outlook.com
 (2603:10a6:b10:8c:cafe::38) by BE1P281CA0240.outlook.office365.com
 (2603:10a6:b10:8c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Tue, 23 Jan 2024 20:34:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.85)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.85; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.85) by
 VI1EUR05FT046.mail.protection.outlook.com (10.233.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.21 via Frontend Transport; Tue, 23 Jan 2024 20:34:04 +0000
Received: from outmta (unknown [192.168.82.140])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 32D1D2009538D;
	Tue, 23 Jan 2024 20:34:04 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown [104.47.18.104])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 4BA622008006E;
	Tue, 23 Jan 2024 20:34:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZHEbEtTf4gG5IfDeO9SRWwDuyjiJJxbxYUsjPxMrWZQ14E96HF4Z8ocdrIBXrGUakWKVdf3ZesC0y5P1ImlO0D7aJrIYjOeijYMrYJeONl8igVGWLNbhmbnWDyIJwmlDnMN+6zxqMNYp/hjroiTJm7JYj+JazUrqQlPjh0f08EAOkvF1iBqq/cGxb/VB0ooV6UcBlT7FcdMDZ7+h+7i8kW2ngovQs192sfGuG3DYBSIA5zsg1WHM2hA89U+0H1Y5LcMnK0kTEz6PoeIEpE5kqLbv8AyF3w9oM1HB+gVPhurxKVx7FyIRMya1QnHCqqPKcNFkFym0btcjwbOeZWzsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgE/B/vrKFQdLqwpJfrrRv3zFR8n7DbGe7yItbWljXE=;
 b=avhB3mK0rA4j4kNxuI4JAdW8ZYrmH1izee0bK9W27y2cuAyWpoxTCZzMYs4HKrPizjCyLBCqo+NTCe+skqiHaCfkZTcI4fYda1FW77+XN1yxAa26qA/QF2s8qWg7EVcpOBUN368z36G2zd/vy8eBUi7ZELSbLyEQj7/dDcohB9CLTkc6DZmB1E2/rvNkxDnzs1zmSk29PNT+cKCCIooLWAe21Nxu2WgfwYTSw7KFuI4ZHXbSkLNoLpUy0jPnXfnDPXPV4tRSX1aT0Hz8GvdlI3yEGJRNmFXcBYQnnZyUbZASmi6dgdsjdJMXFu3/ko9/6KuqzcNtby7NzkRfKjkzZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgE/B/vrKFQdLqwpJfrrRv3zFR8n7DbGe7yItbWljXE=;
 b=nqIEn9KISY/8te3+bRomEu/EPeVrTC7ds/0K7K5AQ493J8kSL+Tx9aNlk2T/4jfOQdtwiJrkbgSX8C3KaR6J6XUqE4gHopC0RIwOcgKZiY0wKD1kRqTEU7m0zwr51zhfhx1icQ4QqK/Cf0ELecqREzHfkxkbdsiQePERu/mNlmFdwKKb0+D66YKIo9WK2Ntu7CHYHMrcVyY3ufYj0eprT9KNhMZj0KvviH8sAjSEDNdjAZkRmQ4EwwicCRPVsoE/wPEbyywXa0dK7GF7iGG4kQ3Cc04vBG3h51UW51uJLWjew36g0X6U9HduQYSfs1EIZgsefUJPq6Tajte+tjBDUg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AM9PR03MB7251.eurprd03.prod.outlook.com (2603:10a6:20b:26e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Tue, 23 Jan
 2024 20:34:01 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84%7]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 20:34:01 +0000
Message-ID: <e3647618-b896-47a2-b9b9-c75b56813293@seco.com>
Date: Tue, 23 Jan 2024 15:33:57 -0500
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
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <ZbAch9ZlbDrZqzpw@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR11CA0025.namprd11.prod.outlook.com
 (2603:10b6:208:23b::30) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|AM9PR03MB7251:EE_|VI1EUR05FT046:EE_|GVXPR03MB10382:EE_
X-MS-Office365-Filtering-Correlation-Id: 4206483d-920f-47f8-8b67-08dc1c52a424
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 ipgRB1nUDTNtORMGvbYh5m+BBOyXLZwWI1h4ItM8Nn/bJNRGZD/td2e+gSt/0tZb4gXHL4/93MPMbbPl5T37daHP27PaudPgPvnHc0ri5cJ30E+pZkAL/nh/l0AKCQUGvl5CZtSbnk4I9HYQvWl3zGPr6QWgYswFud35g4KVwVqvSrIQm49wSOlMmbXf9i32eikDRjeP7AJKDXrF2nVOZvBBMUCvRIpJBOAHo/nr2UOmTLRMlW6RpZVvOke4O0Zhb4Fsvq3n5kAPqpYBqc4afZqj+kyLCT5h4/RDF1Cm/P544QExJUUBtMQeg4HCg39cexsaOGNL7mvD0G6qys5JDCKbX/dQfA282vOwlvDygu2mP9YomtCt0sVVNeoVRFGskoBQ2KcSIq4tTERczkz8WrPRBXIkiTDeY+tXPswGiajNJh853SbvXfTCpi7pWztJo/y7WUhK6sKU+sD59k8bYUh9AGSjAgs8f/GEZoFQ73c7I105JmBqhSIXGjID2JpqX+qe/z+KT/K401KKl5C0AYZFlaZpccaWyT0sgvv9J4T/EyA4I3CuHjFkbzx+tE2Bwlzy1+6GVZLc5oW3W9qstLCNlQkp2sE2CDto47gQ2DZBvqZNoyHoIybE4Z+IvuJseeKxWOY9yaZlHgnbh1mvXF1k+/4Yq8BG9OCuRnVJmwV83N4w6TFzxemPzzGVCKHy
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39850400004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(36756003)(38350700005)(15650500001)(38100700002)(2906002)(41300700001)(478600001)(6486002)(52116002)(53546011)(6506007)(6666004)(86362001)(31696002)(6916009)(66476007)(66556008)(66946007)(6512007)(316002)(31686004)(83380400001)(2616005)(26005)(7416002)(5660300002)(44832011)(8936002)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7251
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 VI1EUR05FT046.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e6eb6628-0886-43ad-69e2-08dc1c52a1f5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gU7myuqVWe2XgXYzLQSupeJJQ0HdtZxXGaldAbB3fLXV1L7NpzsruO9kMscudYOOUWokX57JhqvdItYqka95dfp9B2o1vZiI3OuZDAT5pnAaEjm3u/r8CSociE8Z2XBe64EMmydsvQ5G2/oPHB6ZX7QXEzTPG19SGdvLDaribVYGO6x/Uo0NpoeFrofbf9dZVzt8CdwX8QfsuAL3BMk7ewyWKVRKMXLMR5wgaiHZGxKFkPANPUHiATextIbwKM+wCHPc/rtbvBhHJpBqxpgH7lOlkINwcd6E9eTmM61qA1MudnyMaXKZwXpYC2Nk/6p71aRQnNjUDzUUMLXZ4XWwSHdWuXSr75KY0Aawz44lG9zBDtRjst3Y8FnChCcZAaZ4TUyDsuUMuNEFxd6Pveubu0VJT7W3FkmBN1tiWNrlKa1ljZa2nB3bF6VMPMTw8V7e9ChJfUvxmepiV05VtElbwcwIz/dRol2Q27HUE5nisHWOKF7VDhw24j2EBOjZ883A4lzHPWLXGfYsvGecITeIy8zQyPyiQlIHjmyRc1woC6y1hSY4SxCEBPsXYABsSZwAjSZ8blgtU+1iQojEN3aubikT13FIW/dlq8lojxU1D8FwSX7t0BB1pHHz6T9KSZzSsciTOK3K8bgt5n7kc0SWukvGHgymgSRXRkYsrbBlhM4jgYLz0E3VhPFBuD05Tf7vlIwijxN+SlVNCmpU8mG0dIneANY3859TbS94ADbXEGQMVad6Et4JrX5+jzOd5brMjMEwwxeJTLxcaWMVVDqAt56xlyLvNgTXNYVGLlUl0NRfH8pirdmrq9Uxwq0r35O6RAOhUV1kI+pYf9rad3G3Ng==
X-Forefront-Antispam-Report:
	CIP:20.160.56.85;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39850400004)(376002)(230922051799003)(64100799003)(82310400011)(186009)(5400799018)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(26005)(36756003)(31696002)(40480700001)(86362001)(7596003)(356005)(7636003)(40460700003)(31686004)(47076005)(2616005)(36860700001)(34070700002)(82740400003)(83380400001)(4326008)(6512007)(478600001)(6666004)(53546011)(6916009)(6506007)(8676002)(8936002)(316002)(70206006)(6486002)(70586007)(7416002)(2906002)(15650500001)(44832011)(5660300002)(41300700001)(336012)(43740500002)(12100799054);DIR:OUT;SFP:1501;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 20:34:04.5740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4206483d-920f-47f8-8b67-08dc1c52a424
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.85];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VI1EUR05FT046.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB10382

On 1/23/24 15:07, Russell King (Oracle) wrote:
> On Tue, Jan 23, 2024 at 02:46:15PM -0500, Sean Anderson wrote:
>> Hi Russell,
>> 
>> Does there need to be any locking when calling phylink_pcs_change? I
>> noticed that you call it from threaded IRQ context in [1]. Can that race
>> with phylink_major_config?
> 
> What kind of scenario are you thinking may require locking?

Can't we at least get a spurious bounce? E.g.

pcs_major_config()
  pcs_disable(old_pcs) /* masks IRQ */
  old_pcs->phylink = NULL;
  new_pcs->phylink = pl;
  ...
  pcs_enable(new_pcs) /* unmasks IRQ */
  ...

pcs_handle_irq(new_pcs) /* Link up IRQ */
  phylink_pcs_change(new_pcs, true)
    phylink_run_resolve(pl)

phylink_resolve(pl)
  /* Link up */

pcs_handle_irq(old_pcs) /* Link down IRQ (pending from before pcs_disable) */
  phylink_pcs_change(old_pcs, false)
    phylink_run_resolve(pl) /* Doesn't see the NULL */

phylink_resolve(pl)
  /* Link down; retrigger */
phylink_resolve(pl)
  /* Link up */

And mac_link_dropped probably needs WRITE_ONCE in order to take
advantage of the ordering provided by queue_work.

> I guess the possibility would be if pcs->phylink changes and the
> compiler reads it multiple times - READ_ONCE() should solve that.
> 
> However, in terms of the mechanics, there's no race.
> 
> During the initial bringup, the resolve worker isn't started until
> after phylink_major_config() has completed (it's started at
> phylink_enable_and_run_resolve().) So, if phylink_pcs_change()
> gets called while in phylink_major_config() there, it'll see
> that pl->phylink_disable_state is non-zero, and won't queue the
> work.
> 
> The next one is within the worker itself - and there can only
> be one instance of the worker running in totality. So, if
> phylink_pcs_change() gets called while phylink_major_config() is
> running from this path, the only thing it'll do is re-schedule
> the resolve worker to run another iteration which is harmless
> (whether or not the PCS is still current.)
> 
> The last case is phylink_ethtool_ksettings_set(). This runs under
> the state_mutex, which locks out the resolve worker (since it also
> takes that mutex).
> 
> So calling phylink_pcs_change() should be pretty harmless _unless_
> the compiler re-reads pcs->phylink multiple times inside
> phylink_pcs_change(), which I suppose with modern compilers is
> possible. Hence my suggestion above about READ_ONCE() for that.
> 
> Have you encountered an OOPS because pcs->phylink has become NULL?
> Or have you spotted another issue?

I was looking at extending this code, and I was wondering if I needed
to e.g. take RTNL first. Thanks for the quick response.

--Sean

