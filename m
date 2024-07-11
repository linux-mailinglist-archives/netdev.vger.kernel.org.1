Return-Path: <netdev+bounces-110831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2A592E732
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 13:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5458D281049
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 11:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C86C154BFE;
	Thu, 11 Jul 2024 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="hndExWGK"
X-Original-To: netdev@vger.kernel.org
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11022091.outbound.protection.outlook.com [52.101.135.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE2A37169;
	Thu, 11 Jul 2024 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.135.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720698039; cv=fail; b=dg5IdQSbzFfkRo4hiOVFVbJ/zxN3WX0/8TtZyGvJJMRObJaEnXGU6pom4nLs9THCPAPgbHfRYwPSyc8rhua9Y8/C93PEUVN8zJXIDxldEFo4BBOYtC/Dunn5DgR/TBm3DdFLHACsQWpD2BWVAXy20SoJZR5lkPoBukBwM4vsE6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720698039; c=relaxed/simple;
	bh=C2RzEcy5vg+iswvZopKpv37e+l2SY/dqBmaru9nSqok=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q0BwZ+tpd7ruuqSzqZyKxom710JguUQYMM/oZZstKZRE4Tjb9KQFJiQ5Rax2jCkZqraMEbaHlWeGSdUHtzuTTLhLLPPbvpHw6QqbWFCx0Fzwg8HDZUw8qi33Q+yAhtw+oAvyMZ5u3OYlA3NUXGLbTE9s+xkfohyyeECeDF+f3ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=hndExWGK; arc=fail smtp.client-ip=52.101.135.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywgkIBtarw/JggBrOs6SN+PW6JO6P6BbFTK4U/5RbgaiYdrT3Pyh+o8OaKWeDm6/2YkJT6tSnFnCQoKOHq0D62uIGiQe9vkKQMDdNb4bCFm67Y6FD5amp9SgKMAh7dvN44d0OGhSlZtde0tDLGetxJKW+8hxeIlCD9b+Pqx6AS2G9Gl0ZG6s/xx0ogK8EG9ArnsP0dfK+c12HDdvuEOh4DzUB5IZRTiWLfx83bR1y7EPkuhvR65rILCz4JKL26g3OWMepOyiCdWvD+QadmbdPFjDxdfQAukipXuexyDxS9JfJos9Mm990EFaZ0WSssJF0m0xoHhrhYkpIejP4uTG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqYnndM7qik/spht1PWAnlkEvaV0bPSknx79RdPXN3w=;
 b=E9AYjUT2qrvnF8Kqn9EYrfdLbszSuOEgwv2qYeZSqtlGz9gAQFv/XpOoePAAiNEDHbOfbx32v+UhhEA5puLJtB7wVca09r9IfDKlqVTe31TkDMvZswPa4leQg9tTwnJomiHREVDizlQUZ8UmyX0UW6njNCAbQtTP46rum9lJJeR15cJLMsXLY1NV1V84DFWTv9WM9Isz+jkwczGehQ/0bY9MTU4FUI3HnDTnRspqZ8ZQQxGVIbxKiOcV+McunVCi6+zakeNWQUsMfIjc2J2Z5QDQlYdKDbvqzakw7US0tmbQu9V+M9KRy8ECM8d36kbKEtiBqpC9Me9b5hoEi/QC8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqYnndM7qik/spht1PWAnlkEvaV0bPSknx79RdPXN3w=;
 b=hndExWGK7i7aGypRl4MjyumolRkDSamwYFhP3+jIu16YKlvozn7/7umPEpBZYLioYcXkENrgXWmmWehj+bq+JABC73XB0vG5qw/od1K8XfWUiK+a97rQ4z7PEge1HFvwBmIo9QBY5FYC3dDcGPv6Ks96o8dCJs76COoL85NYFiQt0Zfw1XFJ9dUFECf3o403DyQzR79t6ZyDK2Mi9e0S33/AQN6/JvVxa27f+2K5wVxAZRYmyUno1ihxulVG/H6YFU5kRJMZyaxXDMvLX7pDQUcZKBan/movnvowps1RhzKFaNz5CxfUaQACphjs2ukjxxam02l6HdvbnBk8EKvDFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by KL1PR03MB8516.apcprd03.prod.outlook.com (2603:1096:820:13c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Thu, 11 Jul
 2024 11:40:34 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%6]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 11:40:33 +0000
Message-ID: <5b59045f-feba-443d-b90e-5b070e14e154@amlogic.com>
Date: Thu, 11 Jul 2024 19:40:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: defconfig: Enable hci_uart for Amlogic
 Bluetooth
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240705-btaml-v1-0-7f1538f98cef@amlogic.com>
 <20240705-btaml-v1-3-7f1538f98cef@amlogic.com>
 <98f3e5d2-f0bc-46b8-8560-e732dcbe8532@kernel.org>
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <98f3e5d2-f0bc-46b8-8560-e732dcbe8532@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0235.apcprd06.prod.outlook.com
 (2603:1096:4:ac::19) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|KL1PR03MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c94d70-5289-4504-d669-08dca19e45f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzBQSzZrbDVqK0haMVArNW1pTjZNanYyVGd0SUNTdkE4YVI3Tm4vdW5MdlZJ?=
 =?utf-8?B?SWVoVDBNZVZ3VXE2ZGRnZ1lIV0grUlBMWjlqVW00OTlpVTk5akU5QlRRNXVB?=
 =?utf-8?B?OGVUajFxWFZUa3Z0UDVZUjEvanA3OUdoamhvcnBXcjc1RHphYVBObG4wbXpG?=
 =?utf-8?B?UUJRZUF2QU1XS2NmQ0N0ZmlISTN3VHd3S05zekNpblhOYllIWFRrM28rc2NR?=
 =?utf-8?B?Y1RWMUx1REhRQ1d0NXBNaXpoOG15VHU5aEhTdUJvbnA2R1lxR0s1T0NidFJB?=
 =?utf-8?B?a0U5KzJEVm9LNzltOU9ja29DMXg4QUdscmxBNUFhOEJQMkV2aXlzQ3ZIdTU4?=
 =?utf-8?B?YUgxKzNmRi9aNExidUxVWWF4dEY0ZEpkMEg1cDEzWGFrU09HQTNWaldRN21j?=
 =?utf-8?B?NTN1ZzZXZDhYZ2g2NktZN1dxZlgyUG9VNzdNa0dhdk9ueEhLYWtSNFIzbFZI?=
 =?utf-8?B?Nzh5ZGwxR2RrV1lIakkrY3d0V04xVTF3blFzV3pJQ1ZMSzF0aGIwVktGdzFH?=
 =?utf-8?B?QzhWaEVzaW12V3FpMG03ZlFWRGJtNk5zbm9Ydk9FN3pXdjdRaFFNbHZlOGlT?=
 =?utf-8?B?OU1kY0haY2gwZ2NNdkExY1B0RVdlbVFEWTBmSWx0SjNkSUkyOElvemNNL1hC?=
 =?utf-8?B?TlpiS0dGWDVOMVd4S1hnbGU4WmpRbzdEY3RuRjhBRUo3QkI4NnlKSUVtelVu?=
 =?utf-8?B?RGcwaEs3Q3NudVdGUjZPM0EzbXZpVWMzUlBOY2JOTDRjSDJtU1JDamhhKzVH?=
 =?utf-8?B?bDAxTkNjZVRPalNKc2ZoT3k2aHlEaEttSDUrRVpkUjJ4Z2tCWUtGTm9TSTU0?=
 =?utf-8?B?ZHN1NXVSNmRJUEJUa2tYQUJDekNVMDhrdUFUVG5PL212Rk9meXBESHdWOGk0?=
 =?utf-8?B?Z3ZqemxkZXNGa0l1bVcxTm5NNjNxTHZweTMyNGpLc3V5TGJoRWdHWkpzSS9U?=
 =?utf-8?B?dkJOL3dBd3dVTGxaTTBlWDBodkUwQ1EzckxyTlVvblgvVVFPUzBzYWVadU1E?=
 =?utf-8?B?VXliRUdiMkNobFN3NnJ6N0ppWjVNN0VPd1pIMGtOUzA4R2JkbzArTUlMYU4r?=
 =?utf-8?B?WXdJeG4xZDd2eGlodXFwUWoyL0k0TUdzTUZkcTY4SmhsYkdJWDl6dy9iQ2ZG?=
 =?utf-8?B?RTVMZlBhSWkwZFJpaitHdGg5RUw3NTRLQjBjeFNwdlhSR3BTdlZPRHU0RDZY?=
 =?utf-8?B?RzRZSmczODVEQXdNd3prNkhTZDRsSEIrUWtaazVZTWgvY2lBdGhYT2wyYmJ4?=
 =?utf-8?B?eTVDWEE5bVc0WElNK21SMFNNUjVxMi9XanJnWkJDSE1NL2hSa0Q2TjlMMFQz?=
 =?utf-8?B?QXZPbXpyaFRhRk01eTZlaXhsV0xjOGtDZWpUODdXTC80Q3NKMjNJaVZxdWNk?=
 =?utf-8?B?aWt4dXNyNFhaYXRSWEdxUENOVnVLTkRJYWlsU083RzhuRzkrQUh5aWswT3hy?=
 =?utf-8?B?REl0KytacGFuTkpXNnRTaXZ6ZG5tamYyZUFPNzNZbkZzSTBxUFJmVjh5Uldn?=
 =?utf-8?B?WlhmV2hOTGlqSU04c3Q0ZWpoQmJ6a0ZHTmxhcjZLS2lTelRWNE9UUEtjcGMx?=
 =?utf-8?B?a09Lb3dCekQydTFhYkk1czZ0ZTM5SVE2VUx3ZkxkU25JTWVWQ1VjOWtUbEgz?=
 =?utf-8?B?WlM0Yjk4UUtOdnBYSnpaT3lWd3hmczFCVUg4MDJqUnNaeWtsOE02WGpzZmlE?=
 =?utf-8?B?UjRLZllKQy9DT0lQSWs0Y2QzTksrbmtLdjk4TWl6NktKZW94YmlBUUxFVXlW?=
 =?utf-8?B?RHk2bVFaTzJ3TXVkRzZtRkgzUXlTc1lISGVFRytsNFMwUWR0MWdRenl6QmlX?=
 =?utf-8?B?L3BnTEdoWDJHZnhVRmwxZ0tBcUt5V3h5UWxFUU0ycWtLdVlnNW4rSDlWczlz?=
 =?utf-8?Q?3tAtszwa+F+OK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZU95TEtaaDNQcFo3UkEzMXF5eTRIRERGaUZnWUQyWDEzakFCMEJoOVRZbUlC?=
 =?utf-8?B?T0RvckV5ZjNMaWI4Q0Q1U0xvcDRuaUpzNkk2VjdVNy9ZMmswRjV1MjBkeVNh?=
 =?utf-8?B?eW9VMGh3RFI0RXFvc0dTcitJV2NqcVdxMmNWeEM3N3FVN0xtQW5GbU15cVNt?=
 =?utf-8?B?V3BGd0NtV2lYU1VnU2I3QkxMRFpxVklqYlFzZ2pNNjhlTUZoVjF5bnY0cXRu?=
 =?utf-8?B?OVdVbyt4UmI0TllNellmZklsWWp4VDZtSk1LZlFMREZsd2JKcGd3TUc2cnl6?=
 =?utf-8?B?a2xFYXZvRmZnMUdDRkhySkk5N0g1ZlZVWlI0TkZYN3g0SVF0S1RWNDE5SHlF?=
 =?utf-8?B?TXFNUmd3dnZRclhCZ1JhRzZjaFpzZTRDM2VvK053T2s1UzJGTTE0SHdGZkE4?=
 =?utf-8?B?RzJLYWlwYkJhWmZDVG9hNlNyczhyMUxneVhJNXUvVUw1Y2hxUVN6cmdFWG5P?=
 =?utf-8?B?WFhBa2VoTlp0cUdUd1lwT1k2akdpY0JhYkZtKzI2N1R4ckk4cVpqMFBzNDdp?=
 =?utf-8?B?NWtyZW5YTGNrNzg3UXJrMzJ2ZjM0VmhRTnJsQ3JDdk16Vk9qVEkrOWRyYlAr?=
 =?utf-8?B?emZhZ1E5U2ZEMnBNYVdMby9aMDlFNFZFTm1LaVJYTFJJVTVIaDZTbTJ5RlUr?=
 =?utf-8?B?bWF6VWpQL2czQ3RxS0QyeGxiR1Y2Y01VWGIwZlZsei9WNUVrM1R2d2Nsdytl?=
 =?utf-8?B?czk3T01WeldjV3ZoUnNVekk1c2VoSm9iQVlOd0d0dTdHR01Bd2JCVm5DTTZr?=
 =?utf-8?B?ZmhxT1dyelNrMkpTbTR6WlBwbGhHYkkxczlIeDlKbFFUUkNZL3NpTHg0dGxz?=
 =?utf-8?B?Sk1BMk13RGIxT2Qxb1BwaG0zZkZwRVYvR2hZb2d6L1lOS1hCZUZMdlh2azg5?=
 =?utf-8?B?RWhCVEEvMFJPRzBqYkx6Qko1ME5DQVZjbWJ1b2Q1OTBMN2ptY2RVV0R2WTBN?=
 =?utf-8?B?RlZZeHAwbjdhU1FUMVl5ckkzTUkyQmlpazYzbCt5YzdJQisrNXFtQkJzMFk3?=
 =?utf-8?B?eElRZWU5VS81bEt3cTNNalZiQUhYVkJWVHJGaG5qZmFpSDdTUEZrOHNYdlIv?=
 =?utf-8?B?ZGQzWm0zd09vU21HdGdURk1VSDZ5WllObDhNTHhzaTM5OVBvczYzM0ZtVmhY?=
 =?utf-8?B?ME5aUFoxYVNCSTd4UWxxZTRzRllaQ2hkakl5MzR4R2YwNHdkQW5mTnh5czFS?=
 =?utf-8?B?NlowZzQzcmZaVjlQVkdmMVg3WTkzM3RBTnpjdmxib3FXZmVVVCtCeU5sakZJ?=
 =?utf-8?B?bkpKRExYYjhPd1duY0tVTW9BTXlzcnBlTXhTN2djcUdQT09PTnRmQlgyOS94?=
 =?utf-8?B?ajZBS3JvYUwxb003SjUrWHk0eG9GZUdTZ0ZQeHhHYnBRUzNrckM3YmV3T2RG?=
 =?utf-8?B?bG1pUnFJb29saHMxWVg2dC9jdllZTVlVcGJNVURNNWpoMEo3QnlFUi9xQy9y?=
 =?utf-8?B?RStiRFJ1dW9XZGwwVzhCSlNSUzE3SkowMUdHVjQwM0Q2NW5WN1ZNVjVBMyt0?=
 =?utf-8?B?NE5BTUdnRy9JTjFCREVseVRCRVBYaCtiMmE1UlowYlkwRXJ3ZzJaSTYxSTFk?=
 =?utf-8?B?YkZxZS9oS0FsQndTVC9iWGcyb1pqT04xWlFvR1kyVVAyYkpnMXJZWjN6VURw?=
 =?utf-8?B?Q09sdUdoeXFWbUpYSGlCMWVDN09IM0c1N1o2UEt0Q0h1dUdDRFRUMjFFMHlx?=
 =?utf-8?B?SzFaOVVkcWNsUmdIS1pQeThkZFBrOXpVUG1KOUNTdFJxY2ozckpFRUtiS3NR?=
 =?utf-8?B?MUhiTkJLZW9CZVREdmRWdEcwZnBPZmhScHR3S28wVFhqcXNHMjZRT2pTcUtI?=
 =?utf-8?B?Z3dDbWtyZkRRRVFkREg2Y0lXVlVSV3NIeGVIc0xXSVYxeGxVeHBpcWdJejNS?=
 =?utf-8?B?enRLZU9vbWsrb291bkpJRWhrRzhZYUxKSjdlMTkwNzBZT0tzVXZjRkRZYW0r?=
 =?utf-8?B?b0c0U0hXZjZsVEl3Z2dhRXBhaVBqSzE0T29XVld1akdXVzNlVnJTS2xQUGFu?=
 =?utf-8?B?dmlIcDA0RTN6d3VVQm9yVEw1d0k3VWhkN0pvdnRvZ21nNVlBRDR6Z2hWNXBI?=
 =?utf-8?B?cXNkMGFjaVd6Q0hRVk10eU9IZS9LRG9lSVhKVUNiY2tuMnVCN29OV1RpaDlo?=
 =?utf-8?Q?jb943EFyuXXB1Z31mjba1V21+?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c94d70-5289-4504-d669-08dca19e45f6
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 11:40:33.3271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZ2VLXZSlep1fW8x7/n9PwPAzlNLrhAYUGVLKfkfRBRVRD+yTJCJ51kwvf3XlgaynYAn9DuzrF1dfTq5Ur/VQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8516


On 2024/7/7 21:08, Krzysztof Kozlowski wrote:
> On 05/07/2024 13:20, Yang Li via B4 Relay wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> Enable the HCI protocol of Amlogitc Bluetooth.
> Why? Commit msg MUST answer this.
>
> Also, this is supposed to be module.

Yes, "hci_uart" is already set to module by "CONFIG_BT_HCIUART". 
"CONFIG_BT_HCIUART_AML" is the Bluetooth driver that specifically 
enables Amlogic support.


I will change the commit msg to:

     arm64: defconfig: enable Amlogic bluetooth relevant drivers as modules

     CONFIG_BT_HCIUART_AML is the Bluetooth driver that enables support 
for Amlogic chips, including W155S2, W265S1, W265P1, and W265S2.

>
> Best regards,
> Krzysztof
>

