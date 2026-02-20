Return-Path: <netdev+bounces-259648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIyrAsLrl2mX+AIAu9opvQ
	(envelope-from <netdev+bounces-259648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 06:06:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F057164BBC
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 06:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84FAE3012EB9
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 05:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0AE280335;
	Fri, 20 Feb 2026 05:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="aR5NNw3Q"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013034.outbound.protection.outlook.com [40.107.159.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C4523A99E
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 05:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771563965; cv=fail; b=uXuK32XOaOQrSrej6Ll2OgkV/ftGm8w28S29vzJO6uzrJWmG/8QFmu9Td7IVJ/mXCk1Lp5wgcQTF5D2A3z5m2jQGWoeHqfLps0BbU7T29/6vezcoj8W5NyCjcneFW7r9lnncMEiLyVQ2HliLReo+a5o/vy3ZA0NSZAHMczYmGeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771563965; c=relaxed/simple;
	bh=6zv5nJXWqqZ0ccH+L5qoXEzNs66fOtMQP8SrhtnqhKM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CCAUBbMuh2o3N2MXgqA4SYwtFpdHoBYNTpwtVDRl4lQzTehp1yTsKssDODCmC4fAmf0gjgcNG7N4O+1TOxMtSb+Jzh8B2BLEXxaf0bJcYWhJ3HWFX1nC4oPCm71n5hI3S2NSF/pVq0Hi+beTJ/2xuAuFWv8pj9O/oR+mRpTL9Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=aR5NNw3Q; arc=fail smtp.client-ip=40.107.159.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kwa+Zws4qwbbrXwia+JURKqBNWNsNqyjelvjd8qHE4as4y42FG2N+Ac3Q96Ccc6n6+mWssj3PDoLSWwGaDUPF/YLRjE5eD4p/6x3oBmeLZVmy9M0BGwX7v1z0zQlGcOR/4lVrH0lyj4lUfQ0FmtPWHN48aXgllnjW0bSZiYVTtp23kjW3Gpqy3nMwi8q097egpi3jbXezU5mlQrrhHnNhdALUXSYx3UggI1XOqf3qYZUWYdkXvVgop04Ga7VUeU0O7zdXyrBUIw1rZ9E76npNzyyLV1DT3inJ6+xU2uXSiu3KAouicGzxl4CsXyHY0GLanqx7VdmdeWmABDIU1yV4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jR6uOEeLhckA/MTxYV8ABzxnp7ZBOFYNpcCvRnGEKtM=;
 b=FQMJKpls6BpcAZ0QOIGo7Ej7I7NXYGgJ/Z3tueDkFHK301fVmu5u7k/CcuHmMNWzTL4UHm2+8ljaT+bNaeX17uHTqjAVmvSuOGGGKjq8hS5CLaez/Iik4wwTXqs1gCbLRftAzKwGnK9VlUVg/4GCErkWysZ+ZWTVtEyKvDNAUDhiXGmKiZ1qguGEGQ61k6wi6fYwXMKhC/zXH3uAMK/JtvbMH7RUNqcPYng3Tg4TSCHj9g7Dan1cLU1JORGrt1Y1eXFjyjZt512aYK1owQJAFLrlNbuCBab94qzC1FSc7GNrxj/GRFM/pAvptaX9JWwmNw7Z16n//Bzobx74RfhoeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jR6uOEeLhckA/MTxYV8ABzxnp7ZBOFYNpcCvRnGEKtM=;
 b=aR5NNw3QOimPnXzyksr6xar376/7W0ILO5Psm+ciCtckJAxXKz7cibCIRJS5A+GBF7bIFbMlc0I639MoEfMmWLQ41JnOsHIgkgeFW4O0WvCdmpss9TyUErd0DC0hPVCjxEXp4rMdOpuKtcbIUXU5tpasEz7WzBN1ft1ovC5z4UCyLoir0sR4C7K7iH42gl75SpZ+ch6CXvnDw2mqmJGnD7EhauQqPbLaXQmHYUWWji3nUMYGqcIdaOqpZPPh0kaaSNY6WIsuoGZ9ZBRoQPz5tEjiY8WWULatbKgsr8RH+66OEB+2ry2xZNVmFnaXJCa9xRKRXE4dBjVW0WpW4v+DZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 DU7PPFE8B517AAA.EURP189.PROD.OUTLOOK.COM (2603:10a6:18:3::ae8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.14; Fri, 20 Feb 2026 05:06:00 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 05:06:00 +0000
From: Tung Nguyen <tung.quang.nguyen@est.tech>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jmaloy@redhat.com,
	Tung Nguyen <tung.quang.nguyen@est.tech>
Subject: [PATCH net] tipc: fix duplicate publication key in tipc_service_insert_publ()
Date: Fri, 20 Feb 2026 05:05:41 +0000
Message-Id: <20260220050541.237962-1-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:150:63::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1P189MB1988:EE_|DU7PPFE8B517AAA:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b6a103-606c-47eb-87ee-08de703dbd31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MoRw+3OtJcMrVEiFDQxutgZzLV0BX6tIsWS25OCJIVx9PRG0uaHCuNeFjvTE?=
 =?us-ascii?Q?aG4a6thwLit69mnzJI1td6GqFmCaxUuv0Anw3gzAk5nN8m5Twpt6xmWbX/mF?=
 =?us-ascii?Q?AIzwB0rhuZVeS9yNktJMHznJ53WTVEFkX//crMkEnkoz/BF0MTqihYrmKffy?=
 =?us-ascii?Q?LCT5ZBZepiqLiOjXG1tJaRI6fz+rzYrLiimwwHSNSqjyVadwvICscmiZ7nj6?=
 =?us-ascii?Q?xy5TgflqjrFeCG+Gv7aPY7Wm3vC2lLMv0P0yYUfGmQHOTuMfA/YGR/d2uFZU?=
 =?us-ascii?Q?DxV0UVYPO+dnpWhS7LJc88jDxrWaHeWC9D8YC71w/jTJNRZhuszw6IPvrR2w?=
 =?us-ascii?Q?7f5DJryokhnK/g39VbtWURWrVNdbod/UrEu4bLk0HU4ftgYdg2zCX3EbxxNZ?=
 =?us-ascii?Q?nr8rIPuo98kc+rEdO4gR/P7TmTDInhfwyPU+mwfi4WYAUSg3sXhTNcotzSXz?=
 =?us-ascii?Q?53gkrFa3G7DeOV2sQ4i2kwzDINghKVvzsjgf8PcjYLkq8u1AzMXlLGE90CdV?=
 =?us-ascii?Q?7T1yY0oWX2kgqD5tptN3S7AUVCmFJ+QYHhtbhJSe5AevR/+A6pZCVoN/IJ8B?=
 =?us-ascii?Q?013ZB+NMdHAKPXoc2KNMg8XSp66xnOg3u27YAED5RGCoYM7BEz2Vq2xX6QDG?=
 =?us-ascii?Q?KkDwBcfOBJzboNiUnWnAGXO2eiSASXk2P8Z49JUQIzh5xefxsx7fuqjetFqW?=
 =?us-ascii?Q?C+bvO6U7zGxxzfjDqU9MH+WLunJ+xp5/be7835Ffpp7YOivzPmfvBgnGiQoG?=
 =?us-ascii?Q?guza/9uDaN07FsuuIOfgalvij0uF55Ta1R8GqZw5xNecB64BwykozgXZVTs5?=
 =?us-ascii?Q?y0RxmfSIILlPCLodBE1G+NJ7Ocu09klJ1Rie3TUxK8nj/jp89iFqDUagnhGu?=
 =?us-ascii?Q?ZQpShP1jmNZRpm5+5yf2QvEjb+z0tsHf5DAfBCiAE0OlGFCcByA93oqHHhvB?=
 =?us-ascii?Q?SW3PYF4O2i0BZkph3AklVUPzgQBEZSBWvIfhATLwjZ6VGbkeB3yZudtKOg/g?=
 =?us-ascii?Q?i5K/N9mET4xdAR3heU6IpfgFhMaICKw2eoxofmem/5DLabOUPl9GpfOjT7gz?=
 =?us-ascii?Q?L+YWPX2WVlL2BHFvNhS/TrdRCbj3hPFjrsjFKO944HkpqGwkEa8pOs21u0qO?=
 =?us-ascii?Q?sS8m8+N8uJ1IThdYliS4bK+J1LxEPX+iEqM1awINJxUzUeSdVa9vfIQqc0pL?=
 =?us-ascii?Q?ZHpdCB5doIdcFoYl3t5dJ/Bo0vl8eYf5+27uNZuTWIaHCJoIuqjYxXHqB9gp?=
 =?us-ascii?Q?7MjSbkkzlHl2rg4DekSUFcesxGetKFnmCUN9CzaSq8wxbrq9oq7xiIX7ZqZJ?=
 =?us-ascii?Q?zg22lH50BRt7OEkiKR5r+iUhHK61jssB1zaXmQPleDVZrqQni0+vmbo211zb?=
 =?us-ascii?Q?tehlYwJ7fPPg79syjYRud2pvwutoULNfu1dtvmIbCq5Y1QJs8wjhCvIWI4yX?=
 =?us-ascii?Q?XcN2BDjSOx1wUkPeoLmqWStI16ob2T9VAu/d9iBfpSfexG8OCsmsbBIgMqAE?=
 =?us-ascii?Q?iIDrmOVv2bVs6a4SGIDBHmoU+l+wIoOQjUNi9A2KcTmBLZ6+sGqP7xPuPrqM?=
 =?us-ascii?Q?MxHNXy/Z8BVh467A5OM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m3kV8l0BnK8PSE9f3jWTYTPk4r6HEC9BttsKOTQD8EBZQ1qg3Y8fZbvS7hZZ?=
 =?us-ascii?Q?DBhjabZC/jzZXEZ/H3Og8K46RwEi4IZuJ9uoyItavOXrPmmdkctjrWSG5jvz?=
 =?us-ascii?Q?jWhtPahR4Vu7vPMRz2C6NzTN9HWpI5rwJfjfl0VXCrWdwNNrFTbtSGkUdtW/?=
 =?us-ascii?Q?HJo1ZON7ivXA5wW5Gs3onGo8GH7PdqS2wRybjCCe28Ae6QA5qloQ1Cz1/ZN1?=
 =?us-ascii?Q?Bjfwj5sXhhhoZWdHCFrT2tdvCBlpoc4cfJACpa4mD7Rj8ycbOLYWKixQpkY8?=
 =?us-ascii?Q?D7mpwFLBvsmCN5gYrYNLUweX8b5R+i+cAD9sNwimbQwetfFyaf9nLM9mwmLi?=
 =?us-ascii?Q?Uh+3jcLZGPSDRnTik/YoMRD4WTCDc7CA+BWypDsaVUUgRBPuIs7xc3PyYHdM?=
 =?us-ascii?Q?AZM0NHvh1jfofYfq+Hff1P5xW75+eIMbqO1WLSMZwBsTNyGlzWxJ2BfttbsD?=
 =?us-ascii?Q?BIbDx6WlJGZUMRYkdxUVC02pZgrubaSEyOwvvtVytu9yx7naod5xD52hmIDR?=
 =?us-ascii?Q?ibuYp9Mp/GeV3gQLLJ7kkpaK5u+6KaZ1fjVS+VCe6gmdYPaUCrMjfXDc45Ei?=
 =?us-ascii?Q?3AqsJIy088TS7+fs/wh7DjFZHqwc7zchAfZLikiOsxFPAcVVm3+wZGLm/VFi?=
 =?us-ascii?Q?BVjKDyEOAgRQRJoAsuhVLdaN6aDXgQ/kUBn2iO4B69ylkumNx4lythm7K86m?=
 =?us-ascii?Q?oypGNWUotwYCXMTQGs6wKhZhcnshT2MJRKhjstI0D9j2L208BrrR0nTzfc8j?=
 =?us-ascii?Q?KV2guQXRaqc3ltfCNRFz/u2WzdPcRXch7o+GqASQI5E/Ujq+qbSqJSoeysFT?=
 =?us-ascii?Q?UZ3ogX0Rj6fp/L/r50+r6dFj700hlbkTYLiC5c6T2HgwTjP2LoMNgoiInV/1?=
 =?us-ascii?Q?3l2Dac6QanTQuZKDYdzKRD9PsmnCXOEjq0lvLuUmE9uOW3vzaUgJctbEXLRp?=
 =?us-ascii?Q?z98c2RRUncMIQsiKu661XKaZ8HNWjXGbMMmc2PTbYOiWYYujhpQnm1J8sEkI?=
 =?us-ascii?Q?QM3oge7Br9jASDMb2i/RqDYMz7hxLqImOKolsFksd2o+i+pYCLrMhjkMHPi5?=
 =?us-ascii?Q?pDyFUE2cNqkG6BmHPlMzWS83528BPYPyto3X4zQUhIlHlt3IKp/xQNPe5qy1?=
 =?us-ascii?Q?a+9tPGyNyTwe+8S2GbNw7v/Kr8UZIuzt5KnpTcVcgB4ytGThl1m+KyM2uy8S?=
 =?us-ascii?Q?NbJEeyddiNn2dpSn4kGeQiXYOlfE7QafHe8Nx6/9c5rr1rkPeCbB8YNyRnJI?=
 =?us-ascii?Q?bRR1s2fRzwGxqgr6ivBWsf/jKLEW1AIUep2gf4yCs2WflpGy4AL5lU656KrJ?=
 =?us-ascii?Q?2ftLoIwPPElbZLpKFTpsFtSKgQfE5dcem9wKc6uVl7lq7xebLyDipZGctdgv?=
 =?us-ascii?Q?uOmPn4tpS06kmNIUH++/0VtHm4jV3hUJ7JndZThlR0MhZruRxLy6Kv95OK8y?=
 =?us-ascii?Q?7BeJCxj+bk2W7HwqpOTs600KAzl3942jAE5ztWMj5du2TRQtjFZs177UpssB?=
 =?us-ascii?Q?c8L05M+8Uf05l362jqkjXPxvmuV1ZKZDNfdXU16CNUXk2mH5yY6Ml2LQe9Xk?=
 =?us-ascii?Q?0oF0RhSBL9hKVu54tl6A5xKXoOhoIiu1aBuUK2v4blEwu5OcMLLGfOvfi6Cd?=
 =?us-ascii?Q?v/JzZLPlyhRHSgpn3mYotLwkxlhH3xzOoGavZ+quulccaU+zPWmlzeunYnZp?=
 =?us-ascii?Q?ThzTNd9pnMUhKfFg6CAvNZML18/KSkccSeL5kL23mcX+7pyTS7iARGWS6Ezi?=
 =?us-ascii?Q?rNbeRJmt9obEwRknCBYnW92tCWhvBuY=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b6a103-606c-47eb-87ee-08de703dbd31
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 05:06:00.5135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9J5cLQbM6b1HRYkCyahlTR1Iw/9UVDY+1oIKUS4Ke0wsZREMWMRuaOUg3pJjtV3P61U8SjDnrX4Ogc27TUflHGgZBNcYa2NhWNA5jf7OOLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PPFE8B517AAA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[est.tech];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259648-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[est.tech:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F057164BBC
X-Rspamd-Action: no action

TIPC uses named table to store TIPC services represented by type and
instance. Each time an application calls TIPC API bind() to bind a
type/instance to a socket, an entry is created and inserted into the
named table. It looks like this:

named table:
key1, entry1 (type, instance ...)
key2, entry2 (type, instance ...)

In the above table, each entry represents a route for sending data
from one socket to the other. For all publications originated from
the same node, the key is UNIQUE to identify each entry.
It is calculated by this formula:
key = socket portid + number of bindings + 1 (1)

where:
 - socket portid: unique and calculated by using linux kernel function
                  get_random_u32_below(). So, the value is randomized.
 - number of bindings: the number of times a type/instance pair is bound
                       to a socket. This number is linearly increased,
                       starting from 0.

While the socket portid is unique and randomized by linux kernel, the
linear increment of "number of bindings" in formula (1) makes "key" not
unique anymore. For example:
- Socket 1 is created with its associated port number 20062001. Type 1000,
instance 1 is bound to socket 1:
key1: 20062001 + 0 + 1 = 20062002

Then, bind() is called a second time on Socket 1 to by the same type 1000,
instance 1:
key2: 20062001 + 1 + 1 = 20062003

Named table:
key1 (20062002), entry1 (1000, 1 ...)
key2 (20062003), entry2 (1000, 1 ...)

- Socket 2 is created with its associated port number 20062002. Type 1000,
instance 1 is bound to socket 2:
key3: 20062002 + 0 + 1 = 20062003

TIPC looks up the named table and finds out that key2 with the same value
already exists and rejects the insertion into the named table.
This leads to failure of bind() call from application on Socket 2 with error
message EINVAL "Invalid argument".

This commit fixes this issue by adding more port id checking to make sure
that the key is unique to publications originated from the same port id
and node.

Fixes: 218527fe27ad ("tipc: replace name table service range array with rb tree")
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
---
 net/tipc/name_table.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/tipc/name_table.c b/net/tipc/name_table.c
index e74940eab3a4..7f42fb6a8481 100644
--- a/net/tipc/name_table.c
+++ b/net/tipc/name_table.c
@@ -348,7 +348,8 @@ static bool tipc_service_insert_publ(struct net *net,
 
 	/* Return if the publication already exists */
 	list_for_each_entry(_p, &sr->all_publ, all_publ) {
-		if (_p->key == key && (!_p->sk.node || _p->sk.node == node)) {
+		if (_p->key == key && _p->sk.ref == p->sk.ref &&
+		    (!_p->sk.node || _p->sk.node == node)) {
 			pr_debug("Failed to bind duplicate %u,%u,%u/%u:%u/%u\n",
 				 p->sr.type, p->sr.lower, p->sr.upper,
 				 node, p->sk.ref, key);
@@ -388,7 +389,8 @@ static struct publication *tipc_service_remove_publ(struct service_range *r,
 	u32 node = sk->node;
 
 	list_for_each_entry(p, &r->all_publ, all_publ) {
-		if (p->key != key || (node && node != p->sk.node))
+		if (p->key != key || p->sk.ref != sk->ref ||
+		    (node && node != p->sk.node))
 			continue;
 		list_del(&p->all_publ);
 		list_del(&p->local_publ);
-- 
2.51.0


