Return-Path: <netdev+bounces-115992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF457948B5E
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 10:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE951C23386
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 08:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66821BB696;
	Tue,  6 Aug 2024 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="vYDNmQqm"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2120.outbound.protection.outlook.com [40.107.255.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB739163AA7;
	Tue,  6 Aug 2024 08:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722933233; cv=fail; b=VM9sqqyKTv07XmgVwT1SDvXKN2vdhQR9geWKXH5m6rVDGS0j/n1d4/79cmEIKHvz7R1SV5FfBbVqwCvYhy1vaSilfX96Q7bCavwSJle8ILFIPm9ngJF2CqVpdf9Vvgpvfly5lUSfhxSX4lnhPuihrhDXIl86//KZxyQ2GihhR3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722933233; c=relaxed/simple;
	bh=DHu3mHBzewe731bby0uRJDrXcgTRugrRPhfWP0FZrpk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KJyz+m9/QtsvUcK/k2KpIn7tIo+bacNxBI7P9+nO3+/2Scot/qywEBSPPcWyQvOzJiKIEImGiqDCVy9TZUSoabbPqk8sS5DsuaQUnmlEhTLJps9o5byjNPgvwYeR8E+7yx4Dyc/pg4ISkca9WpOm1HusDn/9FRaaVDdNWUxuYHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=vYDNmQqm; arc=fail smtp.client-ip=40.107.255.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ey3nTjIkjm08piTHsxIk93RHD8JXJxoH44ANdGSh19UTiQtTv5JsvDt5Oicgo9MLa+wAPyKIwAEiUKjcXlkj9NJyGQ2G0tzSCEKuopmFNCN8OEq0kYt4tcrFoCetlRAt6WNNgxf5AkjaJjc3Ip1Vws4E0dfkYT2u708DV4LTw+PswgPmeFHTnyNoemzHntT59XJ9cPA03BuwZMEEwrTLi12JIln9pP7P/HAVXAOYrMmcHYh5ObyZ38jRl+KGjaOxwOMbNILE1PT33nXApNS+nkeLCD/Oj9I39bQou0BrknuezXqNBOyN9X7XUr3rKxXIDFIXnaoT7mF3qVOOnYNuew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1+UxGpWAudwn4K48K1UqSCh+qZNFlxcxC7DtNorVPE=;
 b=NacraYIa2ryt6hhFgRahkrfISeSmOvaLf78mo9cMvN0LZbUWrXT06Ve2lD5Iy89e1QSCQkVX7E+sVVAMNH/QP6JbDCuXh2qGOW6VLnGo0iuiq6x+7v9rWto7UlsjA2Fg9CTcn/3U9ElihrhNDNl44Gyvc1yc/zO1i3WVixjqK35wlQEWsGc2xkc6XdRfx+HOA3Eq3qXlITTHYSfE/Y73NNI1Qi8RdVamNRt2Y3gMpleZSHMeCgYVGvsfJnjgTzlr3lVoPzC2ghxdIQVQsLK3av7HEkEC1qvPxBcJ5dOPiBp3JTxf/ajgQJdJuVQ2GTjr4EqlC1YUa/qrJ8gXfhtTIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1+UxGpWAudwn4K48K1UqSCh+qZNFlxcxC7DtNorVPE=;
 b=vYDNmQqmLdLxZQmIdRcHXPhEcJULW1mSlj+meGbpoaAWWCyfveC6CdWpn3J3vaJtnmVjvNFXCp0UMqi8oQ+m0QcYjX5fWEnQP3KiW4mMG7v+g/C77I+SIVqhpzvv/a2DoRT4ToBNuxuM2av4p43asVA4T/7/8oF7u0+WPVj+R5cSHfouu3OX0jEuX1AUYElmgjSWny8QZFOt7ljtodyxFbmite7rjNThcILwEN0EwuwxBTN4+ntG2akuWzhN3MTPyqa4U3RZrf0gHKqrAdum7ZqdvM0OFq4C2qmQQEZwkD4RhMKg/GDeIfP2dgofC0TkLEwNzm6JtuPaGOg6nDoZUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SEZPR03MB7472.apcprd03.prod.outlook.com (2603:1096:101:12b::12)
 by SEZPR03MB6572.apcprd03.prod.outlook.com (2603:1096:101:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 08:33:47 +0000
Received: from SEZPR03MB7472.apcprd03.prod.outlook.com
 ([fe80::914c:d8f6:2700:2749]) by SEZPR03MB7472.apcprd03.prod.outlook.com
 ([fe80::914c:d8f6:2700:2749%3]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 08:33:44 +0000
Message-ID: <dc41f009-6d05-4d8b-90e4-5e389f564a51@amlogic.com>
Date: Tue, 6 Aug 2024 16:33:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] Bluetooth: hci_uart: Add support for Amlogic HCI
 UART
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
 linux-arm-kernel@lists.infradead.org, Ye He <ye.he@amlogic.com>
References: <20240802-btaml-v3-0-d8110bf9963f@amlogic.com>
 <20240802-btaml-v3-2-d8110bf9963f@amlogic.com>
 <2dee0055-49fe-4920-93d7-5462e88b8096@kernel.org>
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <2dee0055-49fe-4920-93d7-5462e88b8096@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To SEZPR03MB7472.apcprd03.prod.outlook.com (2603:1096:101:12b::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR03MB7472:EE_|SEZPR03MB6572:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf6aea0-6e97-4fba-9421-08dcb5f27ba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1R6bjZ4Y2RIQ25OS0ZlY3JNaXd6eGl2ZDhHTENOVGpqb1J6SVJuRmpyU3dj?=
 =?utf-8?B?QlAyeDZReDJxZWlqNUx5bENlNnJiM0RoeFdDVkdUbmNTY1hOMlgvRkwyKzJ1?=
 =?utf-8?B?Ykk1VHMwaWJxUmk2V1dXSDErdkttMmg5UmRvTjB2emhKby9WSUNVNVFwam1I?=
 =?utf-8?B?YzVzeWVUeWdnNlRjMTQ4V0RnS0VFdEs0cVlPc3NsZ3d6OWdIcGRzeVFDOVJX?=
 =?utf-8?B?YkhDVzQ2eW5tUlVEVEFqMWoxTkdBdWpaMTJFSUFTNkI1b3VhY1ZKZ2FkZisx?=
 =?utf-8?B?MnQvMXBrL1c0QmxUQ0tTbGRJbkJmYmZYWG9ubC9CRXpiTVA2NGswYXBmenlY?=
 =?utf-8?B?S1p5VUluSGIwSUZSVGJVcmp5SlFqaTdUcktaNmlSMmZpa1lnZnhucGk0dEo5?=
 =?utf-8?B?enNQUUoxa1lCZ1UwQkpYWW1DbVd0MEduNnUyL2JOZEZoaUhnUE05T1pub05F?=
 =?utf-8?B?M3VoK21nc0ZvRmd4UEV6Q0Q3aFlvZFlYdnk2TFp0MVJmcjRZL2dlVU9NdUNn?=
 =?utf-8?B?TW1WTEtGbU5abWpqWThTd2Rsd1lZbE5qa2ZISWdwWVZvWVZCb0NZMENoN2JD?=
 =?utf-8?B?MTZZaDJyeUx0dWFmbUE0NFQrZThKZlpNOXFKcFpZaVk1eUNCUUZJeW9JbFNp?=
 =?utf-8?B?NXNmMFFRallSMll1ZjF4aHJoVm1tbTlIUjlWMkN1L0RNL25NSkhpbzQ4dm9n?=
 =?utf-8?B?MlB4SDRGeGxQMUNYY3REaHM4alpzcW41RERwTTJWeEx0dlJrWWJ5NFh2ejZi?=
 =?utf-8?B?WFkzSFcrK29UcEE1YTN0MWJxeXRVRlFwQ3BwY1owT1ZucmZwZ0pkMlNqODFi?=
 =?utf-8?B?VjY2ZnNsQ09BTWgyOTRJTnNoNm5uT1RuYWFKZHVQK0E1bW9LWHBXc3hTcjcv?=
 =?utf-8?B?QkJSWGwwck9Fc2dFS1NsV3FsZ1I1UGN0b0dzSDdYaVFJc0NEVGt0cllrNmpX?=
 =?utf-8?B?MjJWNk05RGk5bVkxWExtaFRMZDVWTHcwTDRNUUhvQnUvRElOQ1dPZmxLSkN3?=
 =?utf-8?B?czVzZzlYVVFKTGh5bFRMaHZuOHJTc2xlWjFIQVJ2RDBlWllSQitXQ3V0UWxX?=
 =?utf-8?B?VkVETUMwTHZlcFpNZDhpS1ovUHdQKy9vdlJHeURtVkc0YVBzSmFCQlA4OGN4?=
 =?utf-8?B?NFBxV2pIRDg5UXJQc3V5VTdETzJ0WUVUNmtRdXFzdTdENkNtWlRuMGpSRkVw?=
 =?utf-8?B?RHRpeXdUTFN5YTlwNXhUOTNUTHozTzVxNkxZcnZDRWJLSDIxeVYxQWJiRkhU?=
 =?utf-8?B?MS84ckYwVGhlMTNSVlQ0Mll6MUdaNTV4dlE0d2pDbkhqVEs2WFJMK0QyNlVP?=
 =?utf-8?B?UENwTWhZOTNzVXZBQndrbC9JZHY0NklpZVNzYzZkbnFDUG01Tnp2RVVBZ25R?=
 =?utf-8?B?VzVia013SHlmekRpWnkwUHkxb0tZaWdDSzhOU2hqQ3hnYmUvVWQxanNnR3BJ?=
 =?utf-8?B?SytwOGVlNXIwd0hveDdhOU9kbTk0N09NRW9iUG5XVjJheXR5bHBmN0VsVFN0?=
 =?utf-8?B?cGlJd1ZBUWFuNllGSGo0YlpDSUxWTm5WcGh3L3IyQS9WZE1RMlFVNlZpTkM1?=
 =?utf-8?B?bWRtL1VhUHkrMTNQRXBXOWhNa0ZUUXNKNjdsaTdWcmY3QWZaQWNuWmhpb09z?=
 =?utf-8?B?clgweStJWmQ0UVUxcEJkcHVzQitKbkpydUYwSGgxTjZzTURRS2xMTElSeXZu?=
 =?utf-8?B?Qno3SlFGL3JMUmt6SzJnMU1VYnNZYXZHMnljeEFQOUhWQTlqMGt2NW1xN1g3?=
 =?utf-8?B?b2o1TCtLZE5xcmMrMW5oekZGZlZsZ05pYU1rRWZoTkkwWHJ2bzJ2NmNxajg1?=
 =?utf-8?B?QW9WVVI5NjFRMUpiZ2E1cFl5bHpvOStMWlNWSEE0bWlZY2hlWHludWt2R1Np?=
 =?utf-8?Q?iZsFSlqN0yWbe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7472.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0x0b3RYQUFsandsN2JJaDA3Q2tiZS8xRVdEeTU3dWFXTFRsbWl1VU1ieW44?=
 =?utf-8?B?OG4xblJuMGkremllYktWS3RMRFRqWkpKbnZheTZhVExIdDlPZ3NWR3E4eS9T?=
 =?utf-8?B?ajRUUDdtNUpKWFZ0V25JZFJ0emp1NTN2cnpiZHZrOFJ5Y1JPVEFUdEZjK01N?=
 =?utf-8?B?bDhyeHdEZ1ZYRzlpTklrWW9YYTg2T3NHRExLVTN4N0lnc1pHVTlLZFVIaUNL?=
 =?utf-8?B?a2xrYmtEMVQ5YjRiZjdaUTlGS0JEYUlEeER5Vm5sN2tZMnhqcDlGTzVLT0RJ?=
 =?utf-8?B?YlpwbFd2NEtFNDRCbXRyaTRINXdKMWRUNmF6bzU4U0Y5VnRzanNwQVdRRGNs?=
 =?utf-8?B?MktxQ3hpZ2RpaHRMd29tdU9HbEhZT1c2bWRRSUZZaTNqeFNZellsQ2t0RjJR?=
 =?utf-8?B?OEJaUDRvZGFaclU2dzBtMzJTZmFpNjJkblJ1WStyNy9XSVAyNUsyYUNCbEo4?=
 =?utf-8?B?UHFWTmZHSTVKckdraDFRS0xBUExrdUhjZ2dkNlZ4Rk1WdjA3MDZMMzFvcU5U?=
 =?utf-8?B?L2xsVzQ4K0VoNFhtRVVRakFDSjczZVo3ZWN3eTNiNFptUlovNTF2ZGdRVlYz?=
 =?utf-8?B?YTlNWWFiSHNFN2hEZjliRGtEa25TK29TV2gyNlh6NDJlODRPYWZxM3FYU00v?=
 =?utf-8?B?SjhzdnMyTFJybjBCMzFURWZVOEI0MWdUQjlvR09nUHNPNHRRaFZUeGRaYUNs?=
 =?utf-8?B?MGZxRDArdkVOcEhBTTVTRytKc1VTeFVDZHdFaGM4cVc5eE9xd0NrVDJRSnlZ?=
 =?utf-8?B?NVlNK1BNYW43SlRtZlVoTDl0ejVYV21YdjhyOS9IQXByd1lUMWJGc0YyaVRy?=
 =?utf-8?B?WkY4NDVBa1hJQlFBdE5DMWxIT1pCcFBOTmdlc0svVTJyNkxkTW1NV0s0NEpU?=
 =?utf-8?B?ODhGcThNbW5jTVFoWW94TEF6WjkwczZleWtWM2hiYTY0UG5tWVN5a1Z3Q0Rn?=
 =?utf-8?B?ekR4VVpDdUxkZHRzR2t0aEEzdXNlbjRrZk1TVmVpU1hFTHJQM3ZXaDlxbzVm?=
 =?utf-8?B?Vmp6bGRBb3k0ZGZtVVdoSVhLL2J4U3dJL1dCMzQ3cmxlNldGZTVyb0NWOGcy?=
 =?utf-8?B?WFJIMy83Y2g2b1NqMElLRmd5MGVsRHFkNHFZdUR2TFFYSmh2Vk9BYkpFMWc1?=
 =?utf-8?B?Y2FVeE5iNXZBNk94V2lBQml3VTlQUEJMb2ZORUYwbENQL2FHOVRjS1VlaXpK?=
 =?utf-8?B?N1NCZXZTUzlmVFRLR1I0dHc5eDU1dmdla1A5Mkk2TVRCaTVvTjY2TlAwN04w?=
 =?utf-8?B?UHE2VjZHYzVDUFBBM2JOTW90eFBYOEhtU0NDVTlHa3FHSGdMV3p5cVpMNk5Q?=
 =?utf-8?B?QTJjeTdmQ2E0SjFWa2tQQlBVM1Y3ODBUL1VqUEc1ZWVobG1BZmd0TGQyZHFn?=
 =?utf-8?B?QnFTNUJxcXVmMnQ0RVhObm92VGttektIRDRTVkpQdUpuS05XR1NSakYzTlkv?=
 =?utf-8?B?NGZoMEh0WktVbHNPSFpZR0xVREMvbmwvMU8wOGRCWFd5ZThDTDJVQ3ltWEY0?=
 =?utf-8?B?cklIVGxTOXlETkFOM3VLbng2ZnRkbVM1ekY0QWVnaHE1ZHFleHk1NFZoaFJW?=
 =?utf-8?B?ZjBOL2RCcDJUOHpyaFZZaEUvVmp6cVJlakV5VS9udjhOaTdwSWNSd0VIOWxE?=
 =?utf-8?B?eG9zazVYQWQ1cTFsb3BQbU81eEZ0WUZqOVZKeDJBUmRuQzRUV3c2QnB2Lyt3?=
 =?utf-8?B?amo2ejV4UTBlMDd6eWt5NXRRWFRtbS9DUzc4NUlCckdFOUpkYUdsT3R0SzZs?=
 =?utf-8?B?U3U1R0ZYblFlaTR6bnM5UmpXNGdMYlFwWVlLaTI4d1VzWi9FTkFDN05Wdng2?=
 =?utf-8?B?Qi9OTnRHQklRWFlEMDdIYUJINUsrVFovQVF6L3BFMS9OZEg2dGJkekhVbkcx?=
 =?utf-8?B?dndCZVJTWTlndWM0WWlFRDVWK1hwN3RuOXRTTkMxYzNTWXRJZ3M4RkZsT1J5?=
 =?utf-8?B?SWQ2YkdPbDZiYURTYTc0ZTlBSkF0M3RlQmFFYVE5b3hJMW5nRXNTL0VCMGYz?=
 =?utf-8?B?L0toZnNoK3ZjQ3BWSnJ6aGEzTEwvcUc4WEUrNXN6enhDcFRoYUZYNWxhVUdl?=
 =?utf-8?B?b3RYL2JRZDNUWHprTGZDZFducU1vR2p0T1FiSDB0UmhKd0RWWUFSYzRQNWd4?=
 =?utf-8?Q?/QyqwkOxKROwYl6gC+hQcBKCT?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf6aea0-6e97-4fba-9421-08dcb5f27ba8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7472.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 08:33:44.3417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PsrR5WO4NNubj7xaa9mMSqhwWbH3C23/lPU6Y1339sWyjiOaN+Yi1Or1Cq9tRjcw4o+/oL8CXMXxATJP+Ovgig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6572


On 2024/8/6 1:29, Krzysztof Kozlowski wrote:
> On 02/08/2024 11:39, Yang Li via B4 Relay wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
> ...
>
>> +
>> +static const struct aml_device_data data_w155s2 = {
>> +     .iccm_offset = 256 * 1024,
>> +};
>> +
>> +static const struct aml_device_data data_w265s2 = {
>> +     .iccm_offset = 384 * 1024,
>> +};
>> +
>> +static const struct of_device_id aml_bluetooth_of_match[] = {
>> +     { .compatible = "amlogic,w155s2-bt", .data = &data_w155s2 },
>> +     { .compatible = "amlogic,w265s2-bt", .data = &data_w265s2 },
> Your binding says these devices are compatible, but above suggests it is
> not. Confusing.

Yes, the DT binding is incorrect. I will refer to 
broadcom-bluetooth.yaml to make the modifications as follows:

properties:
   compatible:
     oneOf:
       - items:
           - enum:
               - amlogic,w265s1-bt
               - amlogic,w265p1-bt
           - const: amlogic,w155s2-bt
       - enum:
           - amlogic,w155s2-bt
           - amlogic,w265s2-bt

Please let me know if these changes are acceptable or if there are any 
further adjustments needed.

>
> Best regards,
> Krzysztof
>

