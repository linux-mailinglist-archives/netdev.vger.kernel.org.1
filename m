Return-Path: <netdev+bounces-260463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEhSGoyHnWnBQQQAu9opvQ
	(envelope-from <netdev+bounces-260463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:12:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FEE185EF2
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1727304203F
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C913C37B3EC;
	Tue, 24 Feb 2026 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1bI8cwJi"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012056.outbound.protection.outlook.com [40.107.200.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCB7156F45;
	Tue, 24 Feb 2026 11:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931527; cv=fail; b=tOwgAQiin+sbpLknWS/clSL+VphcdmaHTaYWzwVzaObAJ4Uq7CAG9kCuVaoAE0pt01UBL4hDTfxrmWxO9mAMLCeovr61wQpdOWm2NhRWHT4OxNZDk5gLh8qMa52fqTNSkHnp2FiquErccK/YXSG+4zCkZv6/UGI6RCIzXxgAwdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931527; c=relaxed/simple;
	bh=z40VCWytyrL40akbOS4wSTgSmBs4IQfvxM6iNtv9SSU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZgmuZVeGb1Qpbg/2JL2TTg/YUR5+XrLdqhpiFbqNJdjehX1LW+8jWzuku3zFIFbLbGnN8WL45HQZtqIQLrkqBpPcdMz7ewZZ8HG6llpzLGhSoDaeJCeJT3exNVH2DqshZyHAV/7JJh5Wom/iofqbyCXQO11RKGKd7FUl+nN92dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1bI8cwJi; arc=fail smtp.client-ip=40.107.200.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v649tHjnWjqcvsdFSbA3FH9gxApoQrlBdS/YDjiMf0h4DbuWjyikFYcY+mA98tBM4BdfAGbJaOT4he+KAiFYLYcpnBUFuMI0blPIe8S7MjHL6cURYmVRZLR5yZe6ZfHF3dJHmbtK+LXArKbsZtoqmxOxI83XPazi/yfBk1tUP/dtUFn1axdiEzZdbppvYHxLxMIniTXLHZD50xzwjUH2MrAsrMZk07mITIXUS+nUmNM2TCKH6rV5/xBUUsd4iIe0bLh8wzk1Um3AYAwaufV50J8KNqI2wrVPbBRnoY1uP75GLsEQB2e2AzkYUWeCtJDgVPt8ex52EIPDQ8ujLLHvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHqZaUqZ8XzVaWdYY3qNIz6PlKUhEu/flJB6dBs33eE=;
 b=kwhKQfXSwRyjpECoMrcg/s36eLv8e83pgVxrKlornDV6tdjCWgiqeHyOxS0zIhqTcGulfT8ABaTwQaGCDG9eDAGc/aWNfR0gJFEHpz4XlVImgYLIWwI8sDnMfcJujMs5PuDemQgseLrN6gCsWGWBf2OJc2neBlKva0tUolWX8/ZQbst1e6+We+lFTLmatYVUyFkAGel2zpAKjiNmsEtNF6zLU//ljt6mTOqW5OVtCzbJm7cr0WSLGBypdAhneZif+974dQCVaINW6351EMiAPb5Gjd1nN5iKrQHMoJWyBx7VbcxWddNC34XbthU8fQGbnmdeM/AVgEmWEaVHYXsuDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHqZaUqZ8XzVaWdYY3qNIz6PlKUhEu/flJB6dBs33eE=;
 b=1bI8cwJiMnkm8Yw0ndIwWS3K8MZVOYoiexC6vTr74eZt43a5RdcTqckUxXyZKLnaEqHfEPou58fldPGX4zH0/7U0OrofXZdOqZZUTltRKBq3l65hdh+v5rcQzXsN4zD5J4ZG+vdZS7vFt4mpFAbf540gOoqJvRI9/n6IbEv+NQ4=
Received: from SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 by SJ2PR12MB9087.namprd12.prod.outlook.com (2603:10b6:a03:562::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 11:11:59 +0000
Received: from SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2]) by SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2%3]) with mapi id 15.20.9632.010; Tue, 24 Feb 2026
 11:11:59 +0000
From: "Neeli, Srinivas" <srinivas.neeli@amd.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Simek, Michal" <michal.simek@amd.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "richardcochran@gmail.com" <richardcochran@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [RFC PATCH 4/8] xilinx: tsn: Add Ethernet MAC (EMAC) and MDIO
 support to the TSN driver
Thread-Topic: [RFC PATCH 4/8] xilinx: tsn: Add Ethernet MAC (EMAC) and MDIO
 support to the TSN driver
Thread-Index: AQHcoWOqzDdhe8lnEUOy9LAm/yTeMbWKQTOAgAFOnMCAACFwAIAGCHlw
Date: Tue, 24 Feb 2026 11:11:59 +0000
Message-ID:
 <SN7PR12MB81475A1A8993D163DC4EC5DC9374A@SN7PR12MB8147.namprd12.prod.outlook.com>
References: <20260219054911.2017362-1-srinivas.neeli@amd.com>
 <20260219054911.2017362-5-srinivas.neeli@amd.com>
 <b408cad2-90de-44df-85a6-64a028216290@lunn.ch>
 <SN7PR12MB8147BA0300639B61306EDC949368A@SN7PR12MB8147.namprd12.prod.outlook.com>
 <dd65446d-0c40-4b90-8699-122fffd546f3@lunn.ch>
In-Reply-To: <dd65446d-0c40-4b90-8699-122fffd546f3@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-02-24T11:11:04.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8147:EE_|SJ2PR12MB9087:EE_
x-ms-office365-filtering-correlation-id: 3fccd2cd-2482-4cef-c986-08de73958788
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BoK+LUIbJmK5K8W717ZQIFjWWwZZZTPNY+emEtsgXCdri+tJRZkwdkgs/15X?=
 =?us-ascii?Q?DS4hFSbh/1kJMf/bBxbn7rpr8y/jwl9bIBhf2E9i+fQLwy3aBkUhVJtBQy/1?=
 =?us-ascii?Q?Bn5oHhmo5uRHnIiQebo/Zm88wY8/EQhSW2uAxGi/t5LdwwM6r6TnzWaarw4O?=
 =?us-ascii?Q?UcxdSjaNnsVt2C28PemaOutKafXGwBWh7fH4+3aom6e4MacOWXzvK9RGaCLp?=
 =?us-ascii?Q?5cyXfMVuCd/ARclDodCM1JOB13PzagGQuti63eqt+TahZHDM28x6LMBMxb7D?=
 =?us-ascii?Q?fDZfFhO1JdAejMhtxpq3RcBXW6TGwPT/Ike61cHnUTFcKElkZyDouhL6zINv?=
 =?us-ascii?Q?PXQ3w93cSBBWh8UKQfr89lStZGo143Oqm5Wm5e6nQAzZ2rJIGyN7ETgNE/GR?=
 =?us-ascii?Q?WFHC2hX4qSwQMyCWCnlDa4L8OB+I8jEaEu/tpB5D4uKUa58dxOM1C9FS6ZVJ?=
 =?us-ascii?Q?1GWzHKP37rTDNJH6FOjaYM4ZfriFqCFCw0d/GuZL4MS2GWQJ72bb/9zdFq2n?=
 =?us-ascii?Q?NWSW/TL68FpDB8M/EW/WXA7y4dakyl21WOal1yXs9U/3efhLc4joN82RkFtT?=
 =?us-ascii?Q?O84xffq8VJ5aVx7Yf7zFBE6EmtfBlJeEE9ZNhIlsBzsh0Val5qVi7EqjKpuh?=
 =?us-ascii?Q?tEIk1yC35k5ELtTeO6rCL6zF/D426GefgSx3JDXKqNuinQW5yHCuwh2EoqMe?=
 =?us-ascii?Q?hmk6HjxnbF9gkpt3qH5ETtWc2zVjUpXevH6EzRvQIL8fmS8XstiMOaQEDXll?=
 =?us-ascii?Q?Q+55lAxIafADmg1QZqYvKkdvMlWnQq2+xiuf6Hc7ZNOLJssva/P2F2YxKmCq?=
 =?us-ascii?Q?WcV0QwhSqq2w4zfOt22dNopnHlEes9mfGu+fmnq8LIFnksArJ82kW7TGIt6s?=
 =?us-ascii?Q?y36Hv9Is/gnK9gODB/3T7n4O/vFt5OCw64iS/uUdHSl0Jqj3QQwEBpj6cTvk?=
 =?us-ascii?Q?l07l+oZW7WtqSRv3VUTHqKL3jXd2Qe5wf7Q+2y+Fn9sAID/b5pZ9H5xRJBjF?=
 =?us-ascii?Q?/lN2ozuwcJ68AeqKjCXih5DHIJB+5S+81U4uCMp75RJisKgmACeMx8Whfvxi?=
 =?us-ascii?Q?1ZHxVVEMUA6R96th5y31OA+MHK8RZOixD2GlBt8Yb7KqVPvEST5POMle+9zH?=
 =?us-ascii?Q?8eLYN4AHRJMMDt4wCZddRxQAFlAusqYIpM5r7SOyceweiVfyVwHJ5va8aHXv?=
 =?us-ascii?Q?caiIQT3/ALZg8blW8Zz+0XghHQ6LmmTMmiIZQA6p7t6Z2RZDCcn/y1uwI0nT?=
 =?us-ascii?Q?HCn89c2f1QRqkZNYQgjkVz24nr/WGEBXF7+/FvE2il4rxPblLVWP3ESqAdwg?=
 =?us-ascii?Q?mxYD609ckzQGWpOd2Pc6PWpvI+UiKAtwSy/jRZYlvEVuAcia6N+XU2s/pJLi?=
 =?us-ascii?Q?y9mWw0Pvv22OzaH2xdaBBuAUDgbNBwD9krYKqWgP/MSmUA0g6LnA+OqoL+O5?=
 =?us-ascii?Q?9zcowcDivw8OBwYWcs9Z6c0XJSqSQGnfOj8o+N2O656Q7l8glww2XVU3094/?=
 =?us-ascii?Q?7qc0Cyjh9V8C9zGNir21dt4JY9FYr7k5D1HnEqs8bvT3N0I6eh3ztvOb0dIO?=
 =?us-ascii?Q?AXYqoSGCxn11AAKfs1FC+JV2qvAjgagt6LlouUbAWKpDIxwfb6gdJkkPoEiI?=
 =?us-ascii?Q?wqAP+9KAVD8kGXiYhtf1GOs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MDxJ20yZsrYVJJv7bHhcuyUX019oHnHn40ASAcO5K6I0nQiBaMa50iNKZY6T?=
 =?us-ascii?Q?EaXNJDMhgXqCdTER/vLrz9E21FrRhrds84sOZirHmMve/97HQDdKZR0Q9ZUA?=
 =?us-ascii?Q?C0PyLRKKgHN223uO4SmJPfaxe+zNKtfoMZqEatowOv99DrcPhXaPcLACTRsl?=
 =?us-ascii?Q?kGAd3FKINQNUxhFhxu+XNgknyU6S4eKoWjcpbKFXyhvZeOFHJjkgY6xVX1Dq?=
 =?us-ascii?Q?lDNzpkZmZpwyXBoR0SormBn6qP2goO2E4nH21K5ssszzeGSQMU8OaMBSc4ps?=
 =?us-ascii?Q?/9+XuMhOU5r5lO/m7dWAVEbr5c91DL1pXxkr8eHQdFGqXYM4Z5G21IyL8JOy?=
 =?us-ascii?Q?KrbL4BdJiFKp4RUrWVUjGv559r46f8Es4f5/hMekGzngQcLzeP7qfAXU2Lzr?=
 =?us-ascii?Q?dWjxgNCUTGCCBD9DGxL1hTVt4mZVa7fIKnsK8AyHskJBgKTRYskFU24dTHNY?=
 =?us-ascii?Q?KTADJ5eehdqUbi1C2RYx1VEiIgdvVyG9B9HPHybiSkW8hQt6d6kNCnhcYFHs?=
 =?us-ascii?Q?0OlhmKGhpZ7pXKeVwDA17HFxt6FT7PWq8K0t5HcinQvR1MbIyvfon/Wuaq2Z?=
 =?us-ascii?Q?qM9EjXV4pzTV4U7hz+J59tCbSvDuOyI0f5N+oJ+uZVtsbcn3nGffioxPzxed?=
 =?us-ascii?Q?o7wYGZkXywhdsfNdxurGWshYLqdLWpbirMqQ6eIS6V1c77a48Gz2Ml/EF2Nm?=
 =?us-ascii?Q?zjeWyFf6xBeJWyVrNlR4J+q0Zb7Aw1F9sdak94qT+4qlkJaRSD+Pm/TKgcma?=
 =?us-ascii?Q?lgq+MQdQZ/aDE1onBLVvw8AM+SLoMV8YI7J1Q+f+jtpn8peyNexkhGhg3UKV?=
 =?us-ascii?Q?KLKNAaclxBjnWQPWwZpWs5drE4TB4jPQtRijrPBZuOk68BYnel5nKbC8NPEq?=
 =?us-ascii?Q?V2wMuYwS5WOTtthR+115Sr+ZkZzg9bC7d8pZrY5ziqOyxKcy8U/+gXdIyGxF?=
 =?us-ascii?Q?53dZVMj/+RWPNXH2TVd3U3hmsPgOlhbYAiW+1q+5vmpW0s+WAORRNDIdDLW9?=
 =?us-ascii?Q?JuqzdboDCBoJ4EH7mJtNjOsQdCb28IgGt+gZ73rx54YgRu8f7k1kdpp7oKqR?=
 =?us-ascii?Q?fAmEjb8J/NIkTisQnYbk56/ZIchohhuCIEqms4CzP5qkYL/OUjdzAXEI9SLV?=
 =?us-ascii?Q?HjMeU7Fn6oPSqdMmyfroUZqUs8F1IMVyRDcNaqaO3kHBvHHHUXkB+gHoAp4l?=
 =?us-ascii?Q?X1kGydBSxWlJACAuuOgW3y14fEl4b/VV16tx3Fl7OgLpHL/PKkrq6HnFXzMp?=
 =?us-ascii?Q?Cge8WAlG0qDEAyQiQZf89BTkwJnOVCHQrXiLT1GStLosPiLY4mMX/W2pzGw1?=
 =?us-ascii?Q?bQZ5lO2hK0V2qrBgF10+os5rdCy7gIeuSFz31O1D/pF2sWQiXzW4yFuTsNun?=
 =?us-ascii?Q?7mggP21+M/Z6uWOemYkBbTx3xPIlf6ZAtUFNg4x/zYqveFkEYYY5rr19kf+K?=
 =?us-ascii?Q?HJeG9baRb1VE8O3MJOaHkfneBKluT8cePCPCJZg4lt8TTIVNM/E/5eEGMyFf?=
 =?us-ascii?Q?tGW3uOOpwE8qka26Xl/xbS4ZGgJoN85d8mOU71sFtxMLwiWePfzcwBwl5qrQ?=
 =?us-ascii?Q?xaGIVD6zQaYNJFC+Gc5SijvxJFBjdVnVjajbLe7tcKXljnYisC+qaiAUB/eJ?=
 =?us-ascii?Q?UO2SldGZjNTKOfJEiIguNbCdT417TORd8QVqaZlosgV2H21SdAAJzEwNCgdX?=
 =?us-ascii?Q?yoxZoRhFQ1HbbTfQtkJY+11H3LIP2Y4/p/EXEkArcBjxxX0s?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fccd2cd-2482-4cef-c986-08de73958788
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 11:11:59.4179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W7v9dnkiC1QroNp5vOr55wBnzRSpBpsQPvzlTtOsCI4beMRJgfBx2S0rhBSpIYaJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9087
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260463-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amd.com,gmail.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.neeli@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.995];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:email,amd.com:email,amd.com:dkim,davemloft.net:email]
X-Rspamd-Queue-Id: 08FEE185EF2
X-Rspamd-Action: no action

[Public]

Hi,

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Friday, February 20, 2026 8:33 PM
> To: Neeli, Srinivas <srinivas.neeli@amd.com>
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Simek,
> Michal <michal.simek@amd.com>; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; richardcochran@gmail.com; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; git (AMD-Xilinx) <git@amd.com>
> Subject: Re: [RFC PATCH 4/8] xilinx: tsn: Add Ethernet MAC (EMAC) and MDI=
O
> support to the TSN driver
>
> > > > +           tsn_mdio_mdc_enable(emac);
> > >
> > > It is unusual to stop MDC. I suspect some PHYs will not like this.
> > > What is your reason for doing this.
> > >
> > The intention is to reduce power consumption by gating  the clock when =
it is
> not required.
>
> There is only one other MDIO bus driver that i know of which disables the
> clock between transactions. And it does it because the board has ageing
> problems, and if the clock it left ticking all the time, the magic smoke =
eventually
> escapes.
>
> How many different PHYs have you tested this with? How good a feeling do
> you have this is not going to cause problems? How much power do you
> actually save?
>
>        Andrew
>
This change was expected to provide some power savings when the clock is di=
sabled.
Since I have not validated this through practical measurements and have tes=
ted it with only one PHY, I have decided to drop the change.
Thanks for the guidance.

Thanks
Neeli Srinivas

