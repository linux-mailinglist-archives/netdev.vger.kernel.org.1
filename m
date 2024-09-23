Return-Path: <netdev+bounces-129241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B163297E6CE
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 09:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6FE71C20DA8
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 07:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A6A28689;
	Mon, 23 Sep 2024 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="NMa6weXQ"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B89328EB
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 07:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727077626; cv=fail; b=kFfFMY9xqt/sCYJ5BiVGCMQFynOyvLPlJKNjcHOg6TXRpb5hge33S4KWYC7sQUUOFmwLxd/CgIU7t9wpZ65Awa54ksHmCTB8tvcmr7UHsZXWNSH2o4dINtvvcb3RuPCMpydb5gC8CNW7F10wYbFt+qPcqqLULQHnvAewuIUtXrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727077626; c=relaxed/simple;
	bh=JG5IqPU+3wxNmCXZ5U2eI7Urzg0LRgeA63rUTwo5zoc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=si99z6wh8B4OE3Wz396lHckc3amX+o3krETsQmUA6VBqZ2zhMs6SsSXMtzsisC3aJWTgpS69+I7wx0eaEglFDV31n1PbrLjx29r9YKQBhb9+OXsss/WqGQ6QlWnKeIQA0Q3O5KY3QEOWlB5WMHykp48SsCsSG/8liKM8MbE05AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=NMa6weXQ; arc=fail smtp.client-ip=185.132.181.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
Received: from dispatch1-eu1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 75EA4240CA1
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 07:47:03 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03lp2111.outbound.protection.outlook.com [104.47.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 5092B6C006C
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 07:46:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZE8Zif1mQe+3qY7QGZeaBI2DzRsPtMe8sSaPD4Yth7tYw1sBwAHH4kWXkj8VYK/X3zkI1ap4GsHmENw18Zpk+qRFlP3h0IrXGJDUAnmm0DD8WJx1uBJpD3HmaKtIYO+2YNtAdyuY/H4lPMdalIGhtHZYE559SNmEYEqGIPZWJ3OGVXL31itbvM9iWNEFC1RMTXkH2MSJu2DPlGwU1Hgypuce+QBrbdzvzxj5l3BYKSmHkJkNjh+wxED1MVuNpuZ2koJ28vONqb2eek4Q7L3Wh8IJsclqvABqndKvNRpsvBKAG2haZzYIJ8VptdS01oomTOqAnhVN14YvuGNSjnVJxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JG5IqPU+3wxNmCXZ5U2eI7Urzg0LRgeA63rUTwo5zoc=;
 b=AehCeIKI2C62UfwDJk5/mblRAOI2n8KTl/de2FR47DjjtVFF6Sw35mtDG21mH4dzMilLSqIMDEyXdf4+vwlYKJbbA3UuCizIHwxlPkSxnRr9O8Fs/1PBsynBiYsV4OjXcXRC/lxsRP0Y7EQ22oGxcOZNQZBrX+gaH57qJLBCrV1dNVG9avPsFHGJTL4iFI3VFlQIxAUX+aM0r1VAPuQOBDi3nQyaL7FUcxgP5va5UkbCgj6xESHoJ8I7Vh/Y1laa0r2++Ghu0CQ21AMDvsLv5Id68zGw2i9mgh1TAMyl/5pj4uSw+/YzcszZRBXB0MA6CTUWMUg01ehkG2oPXSJjXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JG5IqPU+3wxNmCXZ5U2eI7Urzg0LRgeA63rUTwo5zoc=;
 b=NMa6weXQDQnu9zpfV9J7z2R8xUM+xdVSGE52Fl7DrJSz2cLr75adkAhrTvI+ONwEYYUtcpbWnpvhiJlzSxsQVgURkuas6R6DPCXMrPdhjObMHU8OrlwSWE3RVzE0XnhQnWJrkGG/vAxOz76xXaW3cW7RwQYnU8vwJFyEpIzwB8s=
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by DU0PR08MB7544.eurprd08.prod.outlook.com (2603:10a6:10:316::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Mon, 23 Sep
 2024 07:46:48 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8005.010; Mon, 23 Sep 2024
 07:46:48 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Adding net_device->neighbours pointers 
Thread-Topic: Adding net_device->neighbours pointers 
Thread-Index: AQHbDYy+fkm5LjBug0uguv5xHq9K5w==
Date: Mon, 23 Sep 2024 07:46:48 +0000
Message-ID: <4122BAE8-E48F-4C3B-9505-D0E033342416@drivenets.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR08MB5388:EE_|DU0PR08MB7544:EE_
x-ms-office365-filtering-correlation-id: 49507bbc-e56f-4f2c-0e12-08dcdba3e0fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tzewgNOckTTOTL5g9/0l8dv320k5XikhCvFg619N6u3CLbRZRD3WJltEV+ri?=
 =?us-ascii?Q?CzXcUcv5v1HRFOQzQIH1hv6c7ARBFLa7SBq/JfTjwQ34Gq+TX0+FWBBwfvRD?=
 =?us-ascii?Q?t5GmEYVI8dgb4fIuHFag5xZcfVDvMU8PFlqjuLJ1TwRpgdXDbI0n/51l8ndv?=
 =?us-ascii?Q?R5Hy30orupFhcipgYu3SIIBjxlbf3DN/hQjV7zL1ztLgB3pScXfPmdvlI6HP?=
 =?us-ascii?Q?Dwg65ARdeHhjhJa5xZUyx7AmV0LHPtrFeY6RU4nXrkwOiR7h7PGQh/5LJzlB?=
 =?us-ascii?Q?omYdM/47JuFVwOCQc4Ukp2GzKFrMtD6ltw4f82sRvbK8uEpX2irgnfjPIOWQ?=
 =?us-ascii?Q?Yx7C+2orINrU47eEYNRLxXYC578Z59gQWWc72RlCYdAmampSRlTB6n27PJVF?=
 =?us-ascii?Q?1wbUNK9JV1f/0EG9QQME+J7Qv82qOZsBEcSXQv9FgwkjtH5WbvvN+BH0OFZh?=
 =?us-ascii?Q?33UorvHPTuPA+E1aVypR1LkA0uP2VkrWTRPupHpbKx/spZ3Wd1KqMD/69Psv?=
 =?us-ascii?Q?VZDAoJJMeb4sBMj3RzmAb0Qq1ubZhIRGZa29b0x3r2bvclHWCx0F/kFNszI6?=
 =?us-ascii?Q?/nndPbbqhdNjUYUr5mie/gBB6JCMlcMiILq1Q7VztK74ltynwL3zvnf2Gbzk?=
 =?us-ascii?Q?00V6SOdINu4eCbxA74KBcTVwxCHVXwHcO+Lub6GF06xo6CmDAOm7kfjdLMFx?=
 =?us-ascii?Q?0GfdO77WT0MpX+q4Ok399tSqFq/mPu10uOo3P9foKwb9DH/PgNacY4V4o3GQ?=
 =?us-ascii?Q?NvBuJLCkeSWyvftNKAq2EfB3n4f68Jj4CNXyQR3xqTPBOH8PVe0BL1E6cM3a?=
 =?us-ascii?Q?ouslO6QE+B1Dhp7HKKHG6GEMFCT+FYkoVrPSRWAUs2LKPr6VIZIj2PRL1OBi?=
 =?us-ascii?Q?gvxZ/iK1aHKOtjniXkY9dCv6+el9ztE+SM0K+72MGeMymAfj5PLjb9bjiFdu?=
 =?us-ascii?Q?e8ICyasUdiZCiXKcYzvN6Ft9utWsWfZ5j534daM56gICLMDPjVk5iJlN+EH1?=
 =?us-ascii?Q?mVioSuZwmaDAmKJeDGWPbRHxrZZ12sDDtmT3la3rwtuFOXzs1lnD9vuN5mxp?=
 =?us-ascii?Q?yGB1LkI4nCWblgANMDdAsBpskh/paq5VW1n4IOIaWi9dtpnPEtg5ALbU8u4N?=
 =?us-ascii?Q?5MauvBABIlxuJHptuJgbV5pIa10L+eTFThh5q7vTLHFRmrw8+IfxOJpFT54N?=
 =?us-ascii?Q?Rpf7q/Ow+V53HMcIE+/77R7JPJId+gh8bnOhf0bRZk3DE869cU5J7ej2YLF4?=
 =?us-ascii?Q?VrG0kCfYrrolDaRWsMXD6WoZIN8LyR9JKnQD1nSzQ8daWsgu/DF0bwtd/97N?=
 =?us-ascii?Q?NfY+8dMioelFWfOs55EA+KfCMETbDVceGEqwVuua+WNSV9PJYn+062XKLlu3?=
 =?us-ascii?Q?64ody+hOHa9/daQdUsGM6R/sUD3algLkarTrZUksqoa4wItUVg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uVF3LhHuQLF0z+njxn+c9CCRTpGWmuGU76psMLH7qAlcnVNN8ol4XxzlFXg2?=
 =?us-ascii?Q?mPJVEEzWO8gLTBEs/sYV8GBm9rtBW/w+Blwidvfzmhwy3MSu+DOR32GJcaIk?=
 =?us-ascii?Q?U+zTG17No3wtTYLUETX63NUbyVG6Ha978dq4l5lnnA/vyHb183m3qUaAVVu4?=
 =?us-ascii?Q?0bLIFEvlDUcrsU9CLi1zv3TEeNvrDNW2XKzkm2DFwYaK+a6LrZ7hrYiR93Ju?=
 =?us-ascii?Q?ABs8uWOV6pSALo1E2CEWR92WYY/tTa0jDOkvh4iVii2HDAqgEpFc40eFtbXa?=
 =?us-ascii?Q?AYYwICBVVynJo2/+Jn+197CXe3EM3VH63dDSGNBA+DCAV+hmdIslTa2spD2t?=
 =?us-ascii?Q?G/EcvHghCddO5Cgm+lGLJTqxaau0I2ZsvDKBnYhO3KqRnhQM4Gt0OvhPjXw6?=
 =?us-ascii?Q?zNztUBsdTn5FbRgmMyv8dpfDtpvhGMHaUc/D7yCCcoiyE+E6K1hVch7AoUKz?=
 =?us-ascii?Q?cmcj2w7jAVkaKqGclKrC/KHjmz/UU5WemUVNpnFUwb420BOXATqwb+zovg/d?=
 =?us-ascii?Q?rVlrVm4bm2NF691Ipxsrz8KZd4pkptvxg9uuGEwnqeERXSk36srQ5KKP0jqJ?=
 =?us-ascii?Q?w0jTf6k6E1Tiy/Of1JT/m6cuD/sCZHcZdvaXQQhQGAgvMRlSz0tY6gtHtjEO?=
 =?us-ascii?Q?IdARAVGwAkydEs61OgFpx3XC3qXznz97QbivSwQ8noVYcXoi4lbtqpfKd3Yl?=
 =?us-ascii?Q?wRlN6Bk5Vn6f26wUzLfUJPREXyBEe70euRxjRSWa0KeCb8UTmqAC4DstxDF/?=
 =?us-ascii?Q?QXvB8735LvucT0NPITBtkAkHk+pNsHxg13YXPUzkU30cujw2A5wg9JWMK0yG?=
 =?us-ascii?Q?01jV6eyFsyZw1aQAdHTOTMba2m53mRMF4Nu6s/lHjOfCPkgb6VOOqJuIHkAV?=
 =?us-ascii?Q?5uNHW5T19Hh64IUvlAw53cpr0fh7mLVdSCdLnWx/tBiS9SzhA3YSeoENYEzr?=
 =?us-ascii?Q?Q2+6p73kfOqQKefSm+7isnG+Uj5X5EKfGyfE4AXAW095atULiKVIpauBN6rh?=
 =?us-ascii?Q?eqTil0EICT1o0CkCP1IyCrxnmnfnePM3husLmM212rPtv9DfaojQ8ODuMrhO?=
 =?us-ascii?Q?ASwcvc7LuMZR6U+ttDkendQ7jHc/s6Hkkpa5WXwBge5Vl3xqdGK2XwQis9Sd?=
 =?us-ascii?Q?ivrUyP/eWvVHEXDDNn8DnsANK/j+N6lwuZr0QDoncP4QCj8PKSodsJHiGxQZ?=
 =?us-ascii?Q?ANui+Ml+dQ7yd3djisOVoFF807IwvKnClfYW0xwI69ORbp8tJJfCi+H7S+WG?=
 =?us-ascii?Q?yMUAzTZKtEx19feUaHWGGUt1bg9K4RwWVFuve+hE8R/SLhQBJhg0dlaB1iUF?=
 =?us-ascii?Q?lkeC2P1VpUJhKHKgbmmbHmXw5N6cq97ekgHeNs1N8DLOw7TvmRCQRrY7dwh4?=
 =?us-ascii?Q?IHq5ZlnpcVLlhKq01IhXwcko4GIh3Yhxgxva+9hP4j+f42fAww9aMbKtAdCV?=
 =?us-ascii?Q?wefSCs6V2RrJS8ROSs6+yNXm2/lXkVxJdXz2qeuLTkh6wL9ppKBl8CinLPlY?=
 =?us-ascii?Q?Vl6EfAEKA9lCur67CuL7Pur5zJ2GG7ch9u6idIe//3slI4jqK7C1ThxpsJ2D?=
 =?us-ascii?Q?0gTfCG3aLeGaxJoiJuN8WJb3d4ZHzsNJdFctBIyWzdIcA8iKKUuQDxgPGcDR?=
 =?us-ascii?Q?FA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <66C33078EB9E5C4F839A4B885C9F183C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fY1LiVamZ5CRQLJt0/nRrVy+3UoT2UJUxYAQ+Q0z7fAEs79AJhlZUK6xvwuhxhgo3n9ONKa7jVanuM4c549d3XNSzGAtExv2o+43IbaBUMULDglWiAb3afYUVQ6OlaFPdzy/pO7vt862niR0KhyMXQ7IWxBBMvilY3BraJuwdGn0+y24ypOir+Wo/NRYGLgwA/hyI+eLz4l2kE/6h80XN8Z/sWr8QjtOHfvNErMLl8Y6/Uil9SMEPbZAXvYKkP3Q1wPTJ03+bYpUFBOEnZsNdL/+UgEvbe7Q9xr9pQjZr3hUnn4n4CBD98hU3Q+IL8WOjcwTElq+uxBjfNYTkK8nSMAVq75wuEBtj8N679z5Pu80KFTf0pVrt2ca4lrSgyyEboBhfRUa0HHkZiOawAHYT8EfzCrP+5AHbvGQAnATHl07e9v/+n5amlQVbXJOIpOqBKYbxLeDmP8boBQ7bs+wT+67cFi5SNuKHrV6lbmuEq8YITAIPKijYwzuNRhPe1BvqglCIaiqgeytk4DJwAmMrs2z7roU1iBO+mWqbFSUqaC+vXO7ZD5X4a7M2BZn+rnyluM7LV3t6DbPhXVeP+jeYmTJw57HzDe0vR5LIeekxtzkzGZR8hiubZqgksocuBO8
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49507bbc-e56f-4f2c-0e12-08dcdba3e0fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 07:46:48.0478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AHL3wseW4xYOsiC+g7Mdy5gZRFR7Y46JYpcs4uZ0997YkpGoGjTO3ZGR+qfPbNJw91NQbdN+VNPWKvJCWnWlSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7544
X-MDID: 1727077615-CyPd08cu7j11
X-MDID-O:
 eu1;fra;1727077615;CyPd08cu7j11;<gnaaman@drivenets.com>;0590461a9946a11a9d6965a08c2b2857

Hello,

We're required to support a massive amount of VLANs over a single link.
In one of the flows we tested, we set the carrier-link down, which took
10s of seconds. (with the rtnl_lock being held for the entire time)

While profiling I realized that a significant amount of time is spent itera=
ting
the neighbour tables in order to flush the neighbours of the VLANs. [0]
(~50% of 40s, for 4000 VLANs and 50K neighbours of each of IPv4/IPv6)

We managed to mostly eliminate this time being spent by throwing a few more
pointers to the mix:

struct neighbour {
- struct neighbour __rcu *next;
+ struct hlist_node __rcu list;
+ struct hlist_node __rcu dev_list;


struct net_device {
+ struct hlist_head neighbours[NEIGH_NR_TABLES];


The cost is that every neighbour is now 3 pointers larger,
and that every net_device is either 3 pointers larger,
or, if decnet is removed in the future, 2 pointers larger.

In return, we are able to iterate the neighbours owned by the device,
if they exist, instead of the entire table.

I can say that we're willing to pay this price in memory,
but I'm uncertain if this trade-off is right for the mainstream kernel user=
.

I would love to find a way to see this patch being upstreamed in some form
or another, and would love some advice.

Thank you,
Gilad

[0] perf-Flamegraph: https://gist.github.com/gnaaman-dn/eff753141e65b31a34c=
d14d14b942747


