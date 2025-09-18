Return-Path: <netdev+bounces-224430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D86DB84A8A
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A01D7BA704
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 12:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179F83002C7;
	Thu, 18 Sep 2025 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RVDKnsVr"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010007.outbound.protection.outlook.com [52.101.69.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CF0246BB9;
	Thu, 18 Sep 2025 12:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199716; cv=fail; b=K2eN/VVELjiRYKUVdNZjj8Mwfb+ti+g8UGjs2NIL4cTKU/8/dVuxgYbgKbBh85TCUKSglpxJT6afWWavUSsvoyYivAy9vf7SmhVVPvc+K+1CkdMH6hpjuv3FU2GCf/mBlMF3++Vs4VeMHY0LBIAPAgJh6YYNlujSOFhuMiV+U2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199716; c=relaxed/simple;
	bh=cfuUR2DOPF7Gw6V65gs6f1DXnzvPqgFcL2u6kxFBVtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oQtI+6EG92x0N8ikfiwRP2bsdZUj1szT9MUVQYLukZS5v9yTWpXXaCC1BgTiJBbRrupsuYeR3dd/Q911+7aiu6nzXffmTUny3cukXyq9hbYTtDnD39EHzEC6z076MnxO1QG3OvgfJUEMGIxucYC2QvwXj2zJrjMlY/kRDY0u8fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RVDKnsVr reason="signature verification failed"; arc=fail smtp.client-ip=52.101.69.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qe3UjtrS448zvE/hDPcQWSaxFhqRZ4MzmLBNaX0ejU8CAcn7YXxGtv4xiZVtAy8425HK2665/0I15NRX+DD6dR+YG5znqEKgoWVIP9pXy35zgFin8jpoJhT2vXyC4eb54oGaa5SgAOECqLpY/jc4ebfXvnYJeSf4+ZhRSuHGpYnyFTLgVCHEzLtgkZmPE+bjixf3RqYL2Ii0Z/+sdfxAzMgFJG5FWA3WSwYkwLTIkl/odxB7xDBm7cqsJ3nHnGz5LVaHYZGxK1b0Ldk2zZfSPhBcOJ+gAQ2+yggq3UUGk9pcKkwhTzy0KdCFqUI9lYlXNnqOaTlP6cRGqxlBdVZFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUNMoVhXXYxVE5GVmodSiENsjFKBcXf/jjD7AGlVk2U=;
 b=RYWEvmVjFud2rDvTeTfAq9Z40heJZDlTF/6j/V9/x+SHF0pXNBqz+xjsn/zPx6diHvyVS922/UV1++nfn+nSHQTnzg82j7TdfW7X1zWRtHg15Klbx+9zIMQeXVHRpEajU7OmCROCJYlGPPEoz2YLVgWhrgbn3/P0FwXKF4ZfVvM+xj/yuQY1RKlL/uJxcRHbVTuk4vLI+T0RLAIEWNcsn2uw2Ovmh+UejhJ/sSf3celrNOo4r2NRCNv9YtjDV9R9U9S6etj4fqRslbsuicqJbMby0I9+eQ4EBiW+dLlsuz+osfHUU4aAek6X3hPh53GYB5IZ00uHoU/6KRpao3yHaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUNMoVhXXYxVE5GVmodSiENsjFKBcXf/jjD7AGlVk2U=;
 b=RVDKnsVrNRMRYcqmMk7q/6/w/xcdX/x0XgIB2kZ+IN05kbo2oRLA9MsXFj1Mf2iOJ24Mrl2h8FE7gNfmPvr69smQ9i+3CLEqXHm1q4wKnVmQud/zgu7G4h8VgE1U6PD3IpvOr+DABlEFsXcTdH1VWpzD2X7pfCkHY2ExN6yYi+HgvtO0KVhNgA6usfIOlm7zRMLX7gWeOn+MgFY4khOQQ5YX0JQkpLslPePZPjbf5lei45gp2Rs1ncSp3vfZWc/xVs+1vamoKkMXVgrD5uPGr+4N4NYu7PJK8KDcdFVigVq9AV0E3nkey0MW2KXny8ZsZoGJF5iFTCkKlvWkemD1QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GVXPR04MB9994.eurprd04.prod.outlook.com (2603:10a6:150:11a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 12:48:26 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 12:48:26 +0000
Date: Thu, 18 Sep 2025 15:48:23 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>,
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, yangbo.lu@nxp.com,
	richardcochran@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Frank.Li@nxp.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: enetc: use generic interfaces to get
 phc_index for ENETC v1
Message-ID: <20250918124823.t3xlzn7w2glzkhnx@skbuf>
References: <20250918074454.1742328-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250918074454.1742328-1-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR07CA0312.eurprd07.prod.outlook.com
 (2603:10a6:800:130::40) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GVXPR04MB9994:EE_
X-MS-Office365-Filtering-Correlation-Id: a318d45c-4286-4d1d-d26c-08ddf6b1a921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?BzyNnckqInVZ6TmLAmisTloNF8bRDD7H9I+b5jFBdI/jtPgNWCPiCfz2Xq?=
 =?iso-8859-1?Q?Di3cjv1Y/nQH7o+IkU/IsMugPj7hn5D4WmCygK7HcI46bXct0wgPh1wwpc?=
 =?iso-8859-1?Q?80UsA9TmehF9N/Y2D3VbHw8cb/Wq8PLipQldjAHibEt2qjvJBN8VHnLNL3?=
 =?iso-8859-1?Q?z8u0uZsHSWb6SR2k1a9SGoZz8MviUDzRBiAyetxSFQAMHAj69ogmEdqZs8?=
 =?iso-8859-1?Q?WOeqRLc6Ewwg4Zw97p0kSTBUrw/UxesahP1EzMoeAkt1LsIvxbno7QCPWr?=
 =?iso-8859-1?Q?3fNK4iE+lkRrAwbz1E626WN7Zftok/a3iBYnJruub0fcCQ5s4duvAqS0IE?=
 =?iso-8859-1?Q?TM+c7fUryBiJy639zVSNSsuE9Hx3NZBszNz5D91DwDLmJZyJXvUDq6HrNC?=
 =?iso-8859-1?Q?5YT0fYwDmqwgBbQx9NAOlWswrDju5VQpx18S/fuYjSy6tBrTWFEJUkOioC?=
 =?iso-8859-1?Q?BJZlg2mFxxwFOnktOdPkTHyQkn7ZuA1p0tmSR+5b1lHnD9OwgPjN+6YAmT?=
 =?iso-8859-1?Q?/HX773TCctbCy4pzOKfCUuLlBfMuIBX7HpngUjnMRQhIoxdh8eS+8JK1IT?=
 =?iso-8859-1?Q?LWHjPT9i4SxbqMnO8SjMd04Mv+/O9NkblsshZvO6khwzfb5EP6uRVDgKHB?=
 =?iso-8859-1?Q?DKU162hodoJu3qony3/t08MttKcrmBE9bhQwc/GwTDaZ0sTeqBtLXqlG59?=
 =?iso-8859-1?Q?57FAoVWGDcwkM3otLC2FGoNoGHM493UdpTkjHgVmBxUSqQ4dLN36p6Toaw?=
 =?iso-8859-1?Q?6TLlfgSn8tPGgE0ffCVQExgdQ3tI1iVprqmx5FTWMYjX+JUHGyw6wr4u9P?=
 =?iso-8859-1?Q?526qWe7YSI/zlRuedEH6fqukJ0yFaWra+j/6rsQTqUxHBZyRxWaRLpKZUF?=
 =?iso-8859-1?Q?gLS6dT5unYusBJ2FvmADn/RdYUqZTtkt0JUSit+t43lqONCvqzwjfiTDhH?=
 =?iso-8859-1?Q?e9HXqO6flWcT9+TIXTHItv+zpwQAYel8zFCx7lKSx23L9T7yy3kzw6fqyy?=
 =?iso-8859-1?Q?8EN8hpi5cqh8MxLua5nQUOPqQjO2Ljn+gEUw63dUzgfL00gqgQxjmKCLpo?=
 =?iso-8859-1?Q?qS+luZkMPC83ZYhJ0+QJE0aWr5mmCl4tWkooZV9bYg5HFziY5N3U14pyM8?=
 =?iso-8859-1?Q?sbjxr1og5hDl7P+snsoZoOSMNxNqgUP7WKomqThA5X0A6i3j+y6l9V5aSu?=
 =?iso-8859-1?Q?UPMs8kWlelONe7gxxea1NywMTJ/Cnngr4vJrIXBFO6CH3YSBk5zVJEBqzd?=
 =?iso-8859-1?Q?25P/ujzLakSFP0dk1NtBDyBOtOP3KfNRcCcQKHAjytX0U/9sKmbJSu7IXV?=
 =?iso-8859-1?Q?P3SPrQ0QLCNW/7I2wJ06HD+ZuqhcaouCw2nVBYmPf0fkXyd3olKYeQk2O2?=
 =?iso-8859-1?Q?7pCQw34Yfl1OW9BIaO8aRtMM1uALtcVzrMAQH5mzmMHi4q2lA/y8Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?CC8y9XM/+NnA2goz0V9Mqv6WnQS8sEkHuDXerqbL0JIP2ryke+Z78Rsc8k?=
 =?iso-8859-1?Q?DeWk0aMZi9NkUnqcDtCsfcgp6rx7mL9M3ZbM3EStsNzLTCVlR+P3yipE2n?=
 =?iso-8859-1?Q?8a/nshlUMLcNLMcf+Q9ylkfIyfdesBBfVYhvay+qOC5YuvIDSmOuct8Xaa?=
 =?iso-8859-1?Q?cWK2R5NwHuRNKXgcMEsz4dQ1St2HsgRlXarKIki1bnBi4H/MhfMaG9lqVF?=
 =?iso-8859-1?Q?4DF9StliOs9xpMkaLx7bwpiHroLz95iTSCzl4b0UI5PJY73iYihjzFfQfP?=
 =?iso-8859-1?Q?7vOHloWTCXKVaTcSEtpDUU1RDQ4JztfrfCfnKWrh1gu8V28Rs5JYpMVUXt?=
 =?iso-8859-1?Q?ZByznP5oSQenZ1C+iH3fGSokXoBoQuWTFfBx1aI5CNfzWGNskfRyV29WVJ?=
 =?iso-8859-1?Q?H6IuiZTf5QRlAC3nh2oTudkx8on1+1V/eBvVEU1nr+6t5b4wsBHS1UHe2e?=
 =?iso-8859-1?Q?PjVwYXy86wNf3n93Xtjt3ZtcfjGVRegXazV8hLl1CPXaUAdbrFjcp1Juyq?=
 =?iso-8859-1?Q?VB0uMHlPZZSDABvw9CvUk5G3Vv+/m0fvrNm5VSOi3mg2rFhJN7OVkFmUlI?=
 =?iso-8859-1?Q?MAYFs5ipqiW/wx5lr/lGiWF3O0EXaJ037/bizppX7K/G0mI0bav3CGNlIv?=
 =?iso-8859-1?Q?4ZmofB2Vhq2cFlUVVLNeblgVpiUZanYogu+EGiiEkhdDvP+eQsXKjn+QKG?=
 =?iso-8859-1?Q?GAHAsTqlXP2SLA3xh3ZzTHlBvOzzsBvK1BokJXbaYu8658T75veiMFidPn?=
 =?iso-8859-1?Q?cpz7vpJ7E5MTiCzJwKXt0gpyq3jBHur/BiVf81RjOEnnZ2dcWyO9xWqQBF?=
 =?iso-8859-1?Q?xkVd4ct4iGj36TTEHapYgEZBWbx5hnBmCi7metBkL3uBB/ShWfTBL4bR2w?=
 =?iso-8859-1?Q?AvcJTqIC5EbR2qw8pnIjX5+ggX9m3klYWsbe7E9WWydyu0gUXH0o+j8j/6?=
 =?iso-8859-1?Q?mn1WXY7uN+GWlh5oJFa1GLceCyumQ4/RGJxWjMHGHumHftySWlCzkitqQL?=
 =?iso-8859-1?Q?1kYYThue1BOMiMN3wYYeJ1HobHi5gyn8oNw9nm2JLb0kDZNJsSO4KSFDE/?=
 =?iso-8859-1?Q?zOdrSwC/ly2R4dozvoYlET66BXSpzgEFBdrX1cAGTM1kS2B5n0StP7N/Z+?=
 =?iso-8859-1?Q?4MrB4QIAgx0zwU5lZgnRjrI1UcN/9LqWHM4pvxVqTgn7JrywShfQfEYLlH?=
 =?iso-8859-1?Q?veMB6hQJg9b02VgJOpDHEUzpig8+jNloBjdmJuI/GLe0DZzme1xzZLg0ah?=
 =?iso-8859-1?Q?SEuHBTyIl6ygGlma9s53hDKhcV4H5PdgxOCNfLAgOPm9yEHSITpyqriEQh?=
 =?iso-8859-1?Q?fqmBlqvEwmvw4wdydt7Rtrg68wx+4GtC6ij1l+adpxc9MWA3M/TeJR+MWw?=
 =?iso-8859-1?Q?YSmze84ll94N2H2VoysN4e1TS6oi564lZrX4KmUf82AEetGp0v2lxh5U6R?=
 =?iso-8859-1?Q?KOnbSYGEe0wFOktCQ9doxYG2nX7bx4UplpRaBbK0TYIDWKMUSFZHKV0Va/?=
 =?iso-8859-1?Q?8usgcfL6LmXpDDUY7j+qDtrKEVKc9v23wVeMAcvt2OvZKjhusnWT+iSKZ4?=
 =?iso-8859-1?Q?q6Kcc8lbBa8vWF5gHz2/2URBRO3YZrKUY+xEAgYHggy9FkpEZROOs6Mgo9?=
 =?iso-8859-1?Q?KfU1Wd2vbWu1jGxvT+Y7l0xG3L7tlQgANFhWaTnBRYURCa6lx9S+jTj1OR?=
 =?iso-8859-1?Q?ODbSR+XioMVRXPRyZD1CTVwXBBpAvnwmEpVPC1xrV8YbJwnTSKPZtdlzJo?=
 =?iso-8859-1?Q?Dtkg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a318d45c-4286-4d1d-d26c-08ddf6b1a921
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 12:48:26.5356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCQ/iLB662RwGEYjj/Gn2tMoZrKqrXF9++dxksWJjInM+3Owq1B26ZWD/MbhNg4WtVuhMuv8F5Co1++CIH7Wng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9994

On Thu, Sep 18, 2025 at 03:44:54PM +0800, Wei Fang wrote:
> @@ -954,17 +957,9 @@ static int enetc_get_ts_info(struct net_device *ndev,
>  	if (!enetc_ptp_clock_is_enabled(si))
>  		goto timestamp_tx_sw;
>  
> -	if (is_enetc_rev1(si)) {
> -		phc_idx = symbol_get(enetc_phc_index);
> -		if (phc_idx) {
> -			info->phc_index = *phc_idx;

phc_idx remains unused in enetc_get_ts_info() after this change, and it
produces a build warning.

> -			symbol_put(enetc_phc_index);
> -		}
> -	} else {
> -		info->phc_index = enetc4_get_phc_index(si);
> -		if (info->phc_index < 0)
> -			goto timestamp_tx_sw;
> -	}
> +	info->phc_index = enetc_get_phc_index(si);
> +	if (info->phc_index < 0)
> +		goto timestamp_tx_sw;
>  
>  	enetc_get_ts_generic_info(ndev, info);
>  

Also, testing reveals:

root@fii:~# ethtool -T eno2
[   43.374227] BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1536
[   43.383268] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 460, name: ethtool
[   43.392076] preempt_count: 0, expected: 0
[   43.396454] RCU nest depth: 1, expected: 0
[   43.400908] 3 locks held by ethtool/460:
[   43.405206]  #0: ffffcb976c5fb608 (cb_lock){++++}-{4:4}, at: genl_rcv+0x30/0x60
[   43.412886]  #1: ffffcb976c5e9f88 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x28/0x40
[   43.420931]  #2: ffffcb976c0b32d0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48
[   43.429785] CPU: 1 UID: 0 PID: 460 Comm: ethtool Not tainted 6.17.0-rc5+ #2920 PREEMPT
[   43.429796] Call trace:
[   43.429799]  show_stack+0x24/0x38 (C)
[   43.429814]  dump_stack_lvl+0x40/0xa0
[   43.429822]  dump_stack+0x18/0x24
[   43.429828]  __might_resched+0x200/0x218
[   43.429837]  __might_sleep+0x54/0x90
[   43.429844]  down_read+0x3c/0x1f0
[   43.429852]  pci_get_slot+0x30/0x88
[   43.429860]  enetc_get_ts_info+0x108/0x1a0
[   43.429867]  __ethtool_get_ts_info+0x140/0x218
[   43.429875]  tsinfo_prepare_data+0x9c/0xc8
[   43.429881]  ethnl_default_doit+0x1cc/0x410
[   43.429888]  genl_rcv_msg+0x2d8/0x358
[   43.429896]  netlink_rcv_skb+0x124/0x148
[   43.429903]  genl_rcv+0x40/0x60
[   43.429910]  netlink_unicast+0x198/0x358
[   43.429916]  netlink_sendmsg+0x22c/0x348
[   43.429923]  __sys_sendto+0x138/0x1d8
[   43.429928]  __arm64_sys_sendto+0x34/0x50
[   43.429933]  invoke_syscall+0x4c/0x110
[   43.429940]  el0_svc_common+0xb8/0xf0
[   43.429946]  do_el0_svc+0x28/0x40
[   43.429953]  el0_svc+0x4c/0xe0
[   43.429960]  el0t_64_sync_handler+0x78/0x130
[   43.429967]  el0t_64_sync+0x198/0x1a0
[   43.429974]
[   43.537263] =============================
[   43.541282] [ BUG: Invalid wait context ]
[   43.545301] 6.17.0-rc5+ #2920 Tainted: G        W
[   43.550891] -----------------------------
[   43.554909] ethtool/460 is trying to lock:
[   43.559016] ffffcb976c26ab80 (pci_bus_sem){++++}-{4:4}, at: pci_get_slot+0x30/0x88
[   43.566628] other info that might help us debug this:
[   43.571694] context-{5:5}
[   43.574317] 3 locks held by ethtool/460:
[   43.578251]  #0: ffffcb976c5fb608 (cb_lock){++++}-{4:4}, at: genl_rcv+0x30/0x60
[   43.585603]  #1: ffffcb976c5e9f88 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x28/0x40
[   43.593301]  #2: ffffcb976c0b32d0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48
[   43.601786] stack backtrace:
[   43.604672] CPU: 1 UID: 0 PID: 460 Comm: ethtool Tainted: G        W           6.17.0-rc5+ #2920 PREEMPT
[   43.604679] Tainted: [W]=WARN
[   43.604683] Call trace:
[   43.604685]  show_stack+0x24/0x38 (C)
[   43.604692]  dump_stack_lvl+0x40/0xa0
[   43.604699]  dump_stack+0x18/0x24
[   43.604706]  __lock_acquire+0xab4/0x31f8
[   43.604713]  lock_acquire+0x11c/0x278
[   43.604720]  down_read+0x6c/0x1f0
[   43.604726]  pci_get_slot+0x30/0x88
[   43.604732]  enetc_get_ts_info+0x108/0x1a0
[   43.604738]  __ethtool_get_ts_info+0x140/0x218
[   43.604745]  tsinfo_prepare_data+0x9c/0xc8
[   43.604750]  ethnl_default_doit+0x1cc/0x410
[   43.604757]  genl_rcv_msg+0x2d8/0x358
[   43.604765]  netlink_rcv_skb+0x124/0x148
[   43.604771]  genl_rcv+0x40/0x60
[   43.604778]  netlink_unicast+0x198/0x358
[   43.604784]  netlink_sendmsg+0x22c/0x348
[   43.604790]  __sys_sendto+0x138/0x1d8
[   43.604795]  __arm64_sys_sendto+0x34/0x50
[   43.604799]  invoke_syscall+0x4c/0x110
[   43.604806]  el0_svc_common+0xb8/0xf0
[   43.604812]  do_el0_svc+0x28/0x40
[   43.604818]  el0_svc+0x4c/0xe0
[   43.604825]  el0t_64_sync_handler+0x78/0x130
[   43.604832]  el0t_64_sync+0x198/0x1a0
Time stamping parameters for eno2:
Capabilities:
        hardware-transmit
        software-transmit
        hardware-receive
        software-receive
        software-system-clock
        hardware-raw-clock
PTP Hardware Clock: 0
Hardware Transmit Timestamp Modes:
        off
        on
        onestep-sync
Hardware Receive Filter Modes:
        none
        all

It looks like we have a problem and can't call pci_get_slot(), which
sleeps on down_read(&pci_bus_sem), from ethtool_ops :: get_ts_info(),
which can't sleep, as of commit 4c61d809cf60 ("net: ethtool: Fix
suspicious rcu_dereference usage").

Köry, do you have any comments or suggestions? Patch is here:
https://lore.kernel.org/netdev/20250918074454.1742328-1-wei.fang@nxp.com/

pw-bot: cr

