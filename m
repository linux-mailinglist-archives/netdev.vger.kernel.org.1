Return-Path: <netdev+bounces-258874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KvpOGAck2mM1gEAu9opvQ
	(envelope-from <netdev+bounces-258874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 14:32:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADF1143D20
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 14:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D1AE3025C66
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 13:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAD4286D53;
	Mon, 16 Feb 2026 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=luminex.be header.i=@luminex.be header.b="v2VGQcz8"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023105.outbound.protection.outlook.com [52.101.72.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DA82C0260;
	Mon, 16 Feb 2026 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248703; cv=fail; b=JA8pGKpfDHiF0A5ZTk19+xRkV42+3fEbiPabiQxqSvlkSXiWB7pG5wPu8+VB7a04r8EmKDj6WxdHLmLKTgtlmSgQT296XFSW3WvEutrh5BDPPwwfp3CzjlriU5mUS6m/OniJLb8tOsaFO0vP8mG+wj7kMrsW8RpFyxC9ztBRWu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248703; c=relaxed/simple;
	bh=qDN0tt1ew2ReJyZIAWCV0xg9iL998gLE8CTwfUJfq9s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ANoofp77a0lzlXDCPs3GIAF6sv9CTVQxyrCmq5UQ/UsIYA8d6a5O/Tl4JTilRyMECL5P9BTULqZBaa55Hu3t5swHSvV86AHJqd0p436XEmzFEkaJS6+gRNcjlU1qTAcCkJxQ8N29Rc49JiVNtSaG29Co7OLPcKyd64keTpy11sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luminex.be; spf=pass smtp.mailfrom=luminex.be; dkim=pass (1024-bit key) header.d=luminex.be header.i=@luminex.be header.b=v2VGQcz8; arc=fail smtp.client-ip=52.101.72.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luminex.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luminex.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVHQHGvzv2usqkgAwBG75PnvZwjpcoVns+3nyUwwduv+R8GrYLKnp7sluPgmFtlsLLtM9BW+TNvCMYHoqzMjzTVB5MqKCsdOlb82O4kk2iWXdcqseaG1IMQgtLriwphxqBKysQmfGvujC6bpyKRrVhJcIuf6YeYp2G4C+YOLPIZZSynxok9YIeLc0x8oVUqZTz6K1PKApdVjoWsTp2UcghzU12jRT5UrYuyWsg9EsXQSfBR83+S+jkeczQsSJBs1B4o5Y8Ve36LoFzDSuIsXMsbTFY9A4nAcHPyQHpLATQI02q/xMPDgMyWrkkuMdkSCijXKHZhgp6jR/C+W5WhEYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cP1Kj1zC/BCkMZCx0St4dU77ueL/aT7zl70qz1NLSy8=;
 b=e0QRLDYBcp7iJ6zQRIYFgAyfjDpl/6yAh12/ZUkf36PsjDrhXX0uDWPih7jWys/u8EmF3DEbYBX67+QnTi+X4fWDljRt/4YazXWcRK4tiyMooBbhlsAQs+nyC8za5LRUfpk/u7NW29IZwdraTEntpNS+VCpb+i6bQ9G29+DZgBReI8+SmSjTFgjNHofHHGuAVW3T2p2PbU/4XJdZX6J5uEXHRGviYaQ47AVAEAWWwH2zaxT6iTsaYt7aAv5wxwb+bVRFWacVhR8fn0qP6r6+obZCFMXi2SeE1WhZAmDze0Bwm5aZmQhRSgRs9JD3i1rW4Nuc846d7MlZVpI60s7shA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=luminex.be; dmarc=pass action=none header.from=luminex.be;
 dkim=pass header.d=luminex.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=luminex.be;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cP1Kj1zC/BCkMZCx0St4dU77ueL/aT7zl70qz1NLSy8=;
 b=v2VGQcz8kzC/dGHDwaTg7UP56uOiT5ikQvJl2kcjkDIoRTLKRsW3/jG6nx5XCbjmusphaxJDIG/+KsC9ixWn6Aq9vyu4DTbebC2UYtGofhhxezsYx0QzG52O+Sh7LjDm81A8u4to8djxgvJJBsxxW2+iw0o3ygTsblJZLxTS0ok=
Received: from PR3P194MB1505.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:14c::14)
 by DU2P194MB1696.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:278::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Mon, 16 Feb
 2026 13:31:37 +0000
Received: from PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
 ([fe80::b6ba:9288:de68:5c5]) by PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
 ([fe80::b6ba:9288:de68:5c5%5]) with mapi id 15.20.9632.010; Mon, 16 Feb 2026
 13:31:37 +0000
From: Cedric Jehasse <cedric.jehasse@luminex.be>
To: Andrew Lunn <andrew@lunn.ch>
CC: Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Russell King
	<linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: Add partial support for
 TCAM entries
Thread-Topic: [PATCH net-next] net: dsa: mv88e6xxx: Add partial support for
 TCAM entries
Thread-Index: AQHcnOcKItkW6DRmz0WEcytv9y/A6rWEn70AgAC29wM=
Date: Mon, 16 Feb 2026 13:31:37 +0000
Message-ID:
 <PR3P194MB15057C0D7A6A99A912B18783EA6CA@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
References: <20260213-net-next-mv88e6xxx-tcam-v1-1-051e552e2afc@luminex.be>
 <179960d4-7963-41b6-8c1d-a09376fb0d60@lunn.ch>
In-Reply-To: <179960d4-7963-41b6-8c1d-a09376fb0d60@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-codetwoprocessed: true
x-codetwo-clientsignature-inserted: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=luminex.be;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3P194MB1505:EE_|DU2P194MB1696:EE_
x-ms-office365-filtering-correlation-id: a4f138fd-2d8c-476d-0c13-08de6d5fb60a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Vm/EMsB11lRXUF88XbIXUY9AHV+hjdXm+Myh02QUUo1+6uI9PQyX+5Izy0?=
 =?iso-8859-1?Q?7sdt9GNtZkixZe6CakhTyqbGEZsWDEYKcHDTRaOlwD0WG9NmqTlpCUrzi3?=
 =?iso-8859-1?Q?hm1oL4xDeOuUfcHvplyQ3VXNC3ezICuNnDje+A9hw9GfwFRZe9Zuy91L0l?=
 =?iso-8859-1?Q?4FKT30+/7Aw2hfyqPLuS9gOU0TZYlTb75/2OJbJ/slp0OGSF3Lfs/1CzIb?=
 =?iso-8859-1?Q?k0YpiLb+sTzZapLcAACJUDS/l8XgBg2D41KVNjXHjSu06P8wMDgq5lD3KU?=
 =?iso-8859-1?Q?tRMOjkHdC87yUVO5hBYUVvewZBB9b163uiIIawdQMUY/sTtoFO0o4/H8Tv?=
 =?iso-8859-1?Q?HHmgrXu/YFvbha3URtaEqGBFrwYkwBSVwGeWYH9A0K+R+1CJf1xEN0DDm1?=
 =?iso-8859-1?Q?Bk7BNMtC+IR6hKuYB87FslN5z8VPlS27kMv0zmvnmR4xLQdShnF7WT77O2?=
 =?iso-8859-1?Q?a4efeohWUb/BCpSDCZUhvwZBRtq4QasE+w6nQdIkhO39zTXAISeEz6wY5K?=
 =?iso-8859-1?Q?lDtbB9QZxezbvGKom4Gzcyr1zD6B5dsts7nhnGxVq+VlQPGRcOVRBFtCZ8?=
 =?iso-8859-1?Q?Xtj09fsjeDlfEAMxryD9w9/qoStG+tH5Rd5pVuej3J0LlPVcYfCacNOjWa?=
 =?iso-8859-1?Q?TgikHxcuEnPAz5yGjP1zBt4GOOEAqbORGzP0gv6zKzL8f2SJqf7wbpqE4e?=
 =?iso-8859-1?Q?ECZv/i1tLQWETcT1+hHIh9eShYTIImwbaWUFfSqYwFaWko5invHiG+9T77?=
 =?iso-8859-1?Q?k3pzEjT3T+nTZeSyOFkynSTCJHrErgh+aIAD/ROewUie2m8TVhSrrxi6BF?=
 =?iso-8859-1?Q?YbHpHmbJVAGIsLPMeyoQPAKECy0KB0xIxcO1zUk4AUoauqjBG+N+6GwEWk?=
 =?iso-8859-1?Q?C1UwPzEH40YHyRMKz392yxQ77MJHd9giAggN8lIw1o7mxjErIlfgUdr610?=
 =?iso-8859-1?Q?oReHcarL+1hqfw6TgMLTpfu3/0Kejif0oRzJmBTA1U0Qeaa6GAwauSDbDW?=
 =?iso-8859-1?Q?lgdMONViVUuoPO2sfj7Hd4jYAvw0xjoouDKfLpPdaedA13kmgBe+Cxhm6n?=
 =?iso-8859-1?Q?CYUmdezC3ak/UfE12T/NJkWexieZmYMT6GdT5gC+IztfAov5/qeb15MJgP?=
 =?iso-8859-1?Q?6ywHZFgZJSp533hCrP8JrXYYNm6QXNPNKa4mbRFuIBYW9GuuAUOl1+M9Kw?=
 =?iso-8859-1?Q?Q/VXx4WtVyrjUsTezPEgt1XeqI4V5lOxZCQb9T0yzKQrNuun4zPDTBQigw?=
 =?iso-8859-1?Q?OrXT3wp0rf4V4NJupgsUh/WN3SxeuoLdeFT5vCR6D0aXs3nlqmKbsEgdU/?=
 =?iso-8859-1?Q?zFpqGTUrZ5aIznlhluurWq3IQaU7eVyIvUM77w7dUuoEx0Me/jH7SfUKOF?=
 =?iso-8859-1?Q?492NS5dsLZWrdEWRNnQfGz7jtZQpiBc5uRKIc1IUoq2ulgH51jmzrofmRy?=
 =?iso-8859-1?Q?rFffAradvDoDkMndlzZCIVaRuKzRfO05wpChNSuJrLQlvlhEG22oePfHJo?=
 =?iso-8859-1?Q?LKl+Ata/2vFdf+bMx3x5yWmeMdc5Wt4biA1+OitY138r32qWmGCQGqydeU?=
 =?iso-8859-1?Q?LBZhJsshviHlCeiCY8AD/y2WAI8BLmBBpS4hh6qy1cLslN0avoJiduooG8?=
 =?iso-8859-1?Q?5ll/ZY7H4aaVm1Ec5bVCuBM5CPLZDH6dH7AuLm3A3eQtOaY7l8IitxKIF0?=
 =?iso-8859-1?Q?GIBV8AJ8GrcDgaaFcTo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P194MB1505.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?v7NzDDHQaOYrFxvnAPlavLyGAw0lwIhC4VKydIkVaMHT2TCZMMmaBHHaCS?=
 =?iso-8859-1?Q?pEThFOsvcqkPJHhTgyj5MY0j9YfP9eL2RZYuWyc5RmMfLdfbKz62WxA6Fh?=
 =?iso-8859-1?Q?EPMG9wiEwowdFxzTy2JgoyBDXal8vrQthhXWfoVn4geGlgW8fy4ikPUqXD?=
 =?iso-8859-1?Q?n6aNOWaeJVYgUG1T42k1Dg8ANkaiXI2eBZhhv7RCiYRXhvzVLYquqtFpw+?=
 =?iso-8859-1?Q?rAzxBPzSXAWnguPteb2kB1sTuKOB1vIHtoaxuMA/jRKYa419ZOwjg/mqBz?=
 =?iso-8859-1?Q?DLfpvYc8TUemGSpHQ9Nbxo98U/hpdiDnEM4etBKPIwRj1K42Ilkp1Yk26b?=
 =?iso-8859-1?Q?gbfWfJi02dDT+DqwfkzgPoLfo80Jfgv2KlcgUPH+0lBkk1BdZlIf21c9Ol?=
 =?iso-8859-1?Q?mm0Yz3Y9XSLCXAGO+bjBrzQzl6d+BWrguY1G43V8A9AGbMNFzxkKtDM23P?=
 =?iso-8859-1?Q?7QhOPReMzNHCeEQSm/O2q4e7Zb2j4FnILnPM5KxIvR4PoUETW1WANOkv/5?=
 =?iso-8859-1?Q?b5/ab6vnT7UMuVKhr14rKeExD8lVrIi/AWSexZ9Ix/5QasqfEYaXze2LOE?=
 =?iso-8859-1?Q?EWuFaZLE1uPxHk2IA4Vnc1+sEYGec9xC3ZUvJCIPtOjRrpI/0Cq3JB2/pt?=
 =?iso-8859-1?Q?UjKHQRgafgHmMJ9iOBAz5m+KCsET2Vn6ReX48YtAqlX525fN1jxYiIZrw3?=
 =?iso-8859-1?Q?leR8BU9tTHhP1l2I+rhi29UaL+Ya2+C1Fc+DEIPtrKbGU5f1pCa8VRC75x?=
 =?iso-8859-1?Q?sHAqPgd8JHE63csq7yZ5yWQpfru8HCbroOlLBU6ZCviWFP6Blqm4BX7B1n?=
 =?iso-8859-1?Q?hCTYzKYRqs1NfrOQECSDrmiNIpQtz9XX+zQ9kvmCGDuSlgRnrRJq3q5G9w?=
 =?iso-8859-1?Q?7+3ZX+flGedcIU0W6ubdx/jFGbr7me52KmM6NN8zAV615NxV+NwQDSiYko?=
 =?iso-8859-1?Q?qJcqVGNAS+ygw+0RVezO6gM2tNtvZtbALJIofjJL5Exi85ZQNjg6kJqRcK?=
 =?iso-8859-1?Q?3CNwCJDkOZcTXrR8pIsGAxRFOUDCcM1ZE6aM4NvQSjAHpxh+YQo8LMFgwd?=
 =?iso-8859-1?Q?kcFPCLxuO/krIFv8NuMgyGLUcgxkIXNicLVoiWAHBFTV+NOhx4+5fGgD0O?=
 =?iso-8859-1?Q?M+/70LzAxsW6Rqwd1TmutIW35U9tDmIc7+p4DyOgMWDJknJCxzyZDewxlO?=
 =?iso-8859-1?Q?mmmLjYEBNZ/YQg4IEn4Gr84ZpM3dE+rLCiU9Boh3Yob27uROF05CeDFs56?=
 =?iso-8859-1?Q?2aXpTG/iE8iuz/VWJwKVd38RFfppmJrt7vAjq/3sCVFBWaeupazgkUSnIf?=
 =?iso-8859-1?Q?uOOPMJDJqh2qOd8lnn0NpJaN2EkIJwF8rTdILwhiKyEAn1HITaA9LLMklR?=
 =?iso-8859-1?Q?MXS6YPN5Ib4g+kxG2GnxGgvaZNClz/53+CMw2WfY6bobC9ofT3gxlXXL/y?=
 =?iso-8859-1?Q?IqGK1kk7HPHG5QHJKJQOldf5SSENokrFpetFxS4KbqreNXxZVwMvCC68v9?=
 =?iso-8859-1?Q?23q49FRlcTxLFBMgHHa3tKNsCS2Fc0eL2G4ohQOuwr7h3FP0H/ohzUkMgY?=
 =?iso-8859-1?Q?GU3yrwK6Eow6g7UYMU/qD4ARGjlJs0tBjVYTu2zp1euyaBoxbocS+HHtuK?=
 =?iso-8859-1?Q?A/h1Op7iu9HGqX+4Yw3R6JF6OeeG8vL2oJ7owMc39gGsQAadTdipBuOSay?=
 =?iso-8859-1?Q?ThQD4p9jL6RL0HkB6Ih3GC/S6ehKNUqWFtM9TBQ8N7nYq8Y3W9Ne+Q4tG2?=
 =?iso-8859-1?Q?eiRpPC7scusfjtgsxGf7T5oCiasdK6td9J/2AfIJJFPxkD3xXc6mGXzknh?=
 =?iso-8859-1?Q?hVKVASGddw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: luminex.be
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f138fd-2d8c-476d-0c13-08de6d5fb60a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2026 13:31:37.6422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ca3018c-58f1-4333-afa9-a8744cbe7fc2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9PyAm1rYDfIFzYg26PlhxnJcLjl2Wj3FMC78hHYVi3FfNymqF5olqraKRq9W54IMcGgrsJSMUoVaRq5dK4dYe6uZg9HksrykkNndHpI8Ln0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P194MB1696
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[luminex.be,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[luminex.be:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258874-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedric.jehasse@luminex.be,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[luminex.be:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[luminex.be:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5ADF1143D20
X-Rspamd-Action: no action

> Have you looked at other generations of switches? The TCAM has been=0A=
> around a while. We need a clear understanding of what is generic, and=0A=
> what is specific to the mv88e6390 and mv88e6393. You can then pick the=0A=
> appropriate function names. Anything which is specific to these two=0A=
> devices needs to use the prefix mv88e6390 and mv88e6393. Anything=0A=
> which is generic to all switches with a TCAN can use the prefix=0A=
> mv88e6xxx. The 6320, 6341, 6352 families have a TCAM, so we need the=0A=
> naming to reflect if there is anything specific to a family, so=0A=
> somebody can later add TCAM support for the other families without=0A=
> having to rename things.=0A=
=0A=
I've looked at the TCAM documentation for the other families.=0A=
=0A=
The 6320 and 6352 use device address 0x1d for the TCAM registers, =0A=
while the 6341, 6390, and 6393 use device address 0x1f.=0A=
=0A=
The match registers (pages 0 and 1) are almost identical across all of thes=
e=0A=
families.=0A=
The only difference is the register at page 0 offset 0x01 is used on the 63=
93=0A=
and is reserved on all the others.=0A=
=0A=
The action registers differ between families:=0A=
* The devices with address 0x1d (6320 and 6352) share the same ingress acti=
on=0A=
  registers (page 2).=0A=
* The devices with address 0x1f (6341, 6390, and 6393) share a common base =
=0A=
  set of action registers. And the families with more features have =0A=
  additional registers=0A=
* The 6341 has the base set of action registers and is a subset of the 6390=
=0A=
* The 6390 registers are a subset of the 6393 registers=0A=
=0A=
I think:=0A=
* Writing the match part of the TCAM entry can be generic=0A=
* Writing the action part of the TCAM entry is family-specific,=0A=
  but can be shared between some families as long as only the base set =0A=
  of actions is implemented. The implementation in this patch could be used=
=0A=
  for the 6341, 6390 and 6393=0A=
=0A=
Cedric=0A=

