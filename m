Return-Path: <netdev+bounces-110834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5341E92E7D0
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 14:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881821F2182C
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 12:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE32115B10A;
	Thu, 11 Jul 2024 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="W6w+n0ZC"
X-Original-To: netdev@vger.kernel.org
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11022077.outbound.protection.outlook.com [52.101.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6056143732;
	Thu, 11 Jul 2024 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720699215; cv=fail; b=bDpxi0QJwgVIVz5ZuRzcIthpqZF4L+HMMyPksp+jvW201Q2E9j1Qu2R3XSiLSze5lRgNh9kqj5eYx0BipPSXZDMftqO+jzfaT8BPsdIl5+1q43KN+1Jv+fbvaAzSC3R7855iG8ixeaZAkOPm8KFPrdCAwpuLng4wK9lE/hjCBdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720699215; c=relaxed/simple;
	bh=M1EJ7OL+ziNo3Tb0pHzNpGOXduuocReoQ1pHTu9CU6w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hzj1pgXKnXxQuVsb+fqePXXWh2+VJ7hpQ6XuhilRgZfsiAwdPunpcN1735OsPFHsRHVVgowB1KX7hanVwF5dylLBBfyRR9occo51jG6KbFj55T/Udw2Xp+fbpCoXhifGpkdzfKBjRSqzgfqLOjLfCdJw7XLkof8M3QAd0oV4IKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=W6w+n0ZC; arc=fail smtp.client-ip=52.101.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMtiJXs3XYttAA1jOu+AdKqj0NVdE033kLUpOhC7Ed91qKWfo4V+Vlm2jQ8Bbfs7zO9uEzFWLsjDq+EYh1w+iU45N3Fdz72KG2VrYMY5RqgDogwyF7ogBs3ja5AiUOmbRBWRRqdxkQuEYLwJTSGQ8EV7qOLaxiruKXioAw9nEYHVswlgArfNbkLLTQ4Rhfyu/l4mYVeCPLuOOZdO3wOQZ32BqVIg8uIyh0cVOyvkGm7e7MXCraaV8S5KNfvfSVgocGri7GMN5te+WaNOg7aEYEHG7ySeLqLJ9SMQlwA8Fg3vJb3Vw/POALUPvJe8PTYgwFsmMa5NHv5rRQJfr1OblA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aypCfUsKgdfsfq03OB+MC2A6mJS2vGuUlGPu7uW3IjE=;
 b=eo4DXhKnBohbWQ3hwXIHGazlO9myqLaweAZz8r/zZXPuzfvXP2Aj3WaaGj6bz8FThMCYiKN5v6zGWwcvG2xgKTZg+oMnnEVNUUsJXqpDgb19Bc7FkFcmHBCaoXX4mR9OEhUBxXYI4isNMfYuBCiFaAV6PdNgaEU4uZkyTsF1m5lWOr7MWc94YAYX+iBi0WztLjcmBZTiCFzKirLA36K46eBCUgPZfKVtFwlR92i3CSm6Wcw1B9qls6gy5Pb/c9BaMPZLIddstJq23NtTas7MKmi3m/0tUZSK2MpfoAcZ5tsq07cnxwKye4Q2WlQBJY18mqDtDm7UwQyn+4Ns9Crg2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aypCfUsKgdfsfq03OB+MC2A6mJS2vGuUlGPu7uW3IjE=;
 b=W6w+n0ZCKVEg0bYf71NlU9o5h0oNzZdLvALNx2S16P2KOqBJr/ke8zAayQHyDI0MoWbdtTbBEiGpEIdv2IeOVBbbYz/shut13lWg+a0MVD1n+2MqkXetQxHjQhxGlxH1A2ECnnhFh4/ldUuiqQtFA+3sIXmoxlwrLRtX3AteNeTyuTDj0WAXdFQBX62OvM44mSLe3ScfioTvqb5Qz01h/Ttn/Nif9ZXwUOxllzEwRYYYVpYpUC9Il7q3KGplBCH3ieiGiFs1AVttcTNPqX+FafU+ImcLOEHc0LUke7UVAGUxsT3p327hHHNJ071HAjyXketDJwXe3R897nIQOMnqbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by TYSPR03MB7692.apcprd03.prod.outlook.com (2603:1096:400:40e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 12:00:07 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%6]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 12:00:06 +0000
Message-ID: <f346944b-f42e-4d70-a766-cda234a34fd3@amlogic.com>
Date: Thu, 11 Jul 2024 19:59:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] Bluetooth: hci_uart: Add support for Amlogic HCI UART
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Ye He <ye.he@amlogic.com>
References: <20240705-btaml-v1-0-7f1538f98cef@amlogic.com>
 <20240705-btaml-v1-2-7f1538f98cef@amlogic.com>
 <CABBYNZJdLEgTTVJypCM9+hZwHO3mTbTodPh8K_MSvv__gyf2wg@mail.gmail.com>
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZJdLEgTTVJypCM9+hZwHO3mTbTodPh8K_MSvv__gyf2wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::33)
 To JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|TYSPR03MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: 1223929c-1820-49bf-71bb-08dca1a1018a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFhuNmJkTUNUOEI0a1RwcXpubFU2eldlSUpSUkliSWh5S1NJa2xpQ1lmbjg3?=
 =?utf-8?B?elhmTXQzSXVENFVCQ1lhanpYR0xNQm8wbFNXSHJtZEczL1FhVXFNV1BRMmlY?=
 =?utf-8?B?VS9vTlRtZEFYUngwVkU0aFlxSVNEbkZTRWNaQ0dMK1VwMUh6RllsVDBMZ3Fm?=
 =?utf-8?B?YU1US2t5VDd1VFIzYmlSSUg4eEZMbzFvZSs3SHlFUTBIK0cxdnJNa2FNc2c4?=
 =?utf-8?B?eFhoZGFJQUt5bHlqeGdtME5CTC9EdldSM3RiVHBBbVVFSmNVb3p0QXoxZ2hu?=
 =?utf-8?B?b2t6NTZUa0R0WjNYbGpQQ1M1OFpIRU9uNzNBTkYwbEZDR3JUb29Na081SXBz?=
 =?utf-8?B?S1RhcDRCMXp4cU1TQ0N1aVZBYkdXNVZmMjcrTkl3TEt1MGo5UDR6ZldRZGRC?=
 =?utf-8?B?dzNFY0ZYY2RjYzRydnpFT3ZZQ1pYTkEwVkYzcmVjVGpGR1hMalYwODVLSDBI?=
 =?utf-8?B?ZHI3OHBiZXJxeUd4cFRJL1c5Y0tmbVpaVTZ4eno1T1RmOGFETUJDckI4bVdN?=
 =?utf-8?B?ZWx5YnJsWk5OenJHOG1GUVhuK0lncHFRWnNuLzFqTW1XekJNMDNWdDVZV3hx?=
 =?utf-8?B?R3NuMHdtQnpjcXdQMzFqSHZxZ2k5ZStQanVaZjkrZXp2N2JkRDkrUWRoak9u?=
 =?utf-8?B?ZUQrTzY5cURscmVYaFdWdytUZzdCM0lGYmtOMWFRN2V3c2s5TThWNEJSL05Z?=
 =?utf-8?B?STAxTU9abFRWZkpnOG15UVlhTURGSloxc2R6ZndPVkZqdTVUZ2JWUldGd1Y5?=
 =?utf-8?B?MFF1M0lKSmJ2aW5Cc2ExZjRnNHZMa0lVZ1VyYXhUVldibVh5bVNUbTRsUVhE?=
 =?utf-8?B?UnJKdk5UNEFnRG9EclhzTEpFcjhVU241Qkt3Q242L01kNmVlQzM1aDFNTnFZ?=
 =?utf-8?B?UUxBZmlBbE40elcvK3Iyem5LeEpTa3ZBaW96T2JPQ2JmejJheXRVZ0JCbkRZ?=
 =?utf-8?B?T1NZTjlXd2dzZnJjNExjSENlVHFJeEhQY1JhZE5sS1pUenBlMnFUTFFzblp3?=
 =?utf-8?B?M2tSMEd1bXFITHBhc2pKdVJZaDJSeUI5Rkc0NmREWlhOdE5KVDd4bU1zMVFC?=
 =?utf-8?B?RTdnc2dkQlFDREVzM08zSDJvNEo4T1MxaFpHektnQ2RoNTAvWFVCZlNNMGht?=
 =?utf-8?B?dTBWOTZyQk9WcG93eklOY0VUc3l1UDFqMnoxb3gvYnNNdGZYdmhlYTlOU2gy?=
 =?utf-8?B?SXJpWXJBR1hmT3o2V2lqUVFuTG5OYXY4L3EyY2prYmc4TU00NlQ1L01jQStF?=
 =?utf-8?B?VjYwSG5HUmlPa1NjTi9LbFJDRXdzdWVZczNDOFlZTkVjUUc5dVcxeDVPZWlw?=
 =?utf-8?B?VnFUakpLcjc5cm1uRVUybHVkdksyWFl0T2RsQTZXR3lyK3luSjN1YUFFd1po?=
 =?utf-8?B?amNsaTBTZzdEZlhKOENCMEh2NDdpMWQweGJkaDFMOVN2ZXFHQjdORk1tQ2Yz?=
 =?utf-8?B?cThwM0Q0Y1hkdDVXbUE2RTlKNTNNbVYvWlNpSjVtanlwR2xqaDMwY2ZzSXZX?=
 =?utf-8?B?WmpMdXpnUXlabStYa3JqZ1JCbWVpc3Fsa3Rna0ZCWnBwRVFoS0dvT3Z1aktU?=
 =?utf-8?B?c3B5aG5YNXlpUmN0cUVwUjJBMkQzbnN3YXZqTWFXVzhmUms3NEdnVTJNc1hD?=
 =?utf-8?B?MXRtcTFuNDc4Ui9oR3NORzBHSXZIQUhHdTA1OW4zK1A1dERBS0RKQUwzempl?=
 =?utf-8?B?OG1TYjgxNXQ1ODdPS1BkdlI3OHdYelNiNXFPb0ZlamhNWjNFM3d1a29ubjhK?=
 =?utf-8?B?SUU3akhaME5KWGcxb1lIQU9ZS3ZxMFNPa2IvelNLelRBYWlRS1NFaWpJeUlX?=
 =?utf-8?B?SUdRMHk1T2ovZUFNd0I3UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXVNNGlBbVd4U0swYWJmaTgzQmNiWkR3Rkc2U0NrRDUzamYzOFNBWlo5V0ho?=
 =?utf-8?B?bjNrWG04TVY4UVpQMWw1aEpNL0RzRm1vRWNWbldjMCtnVGVBM2ZDYmIwV1Vs?=
 =?utf-8?B?VXFjWEVDTFFQeHMzYUluYWRrMWR5WlBIS2xNRDhROVpCanZRUDlETVQ4b0Vr?=
 =?utf-8?B?UmNielB6Q3VYK3JaeXRSOVBScC9FSFB1N1dFZnFPalZOVXp2MDVIV1Z2b2dq?=
 =?utf-8?B?K0lhTWNYTzNPSzJrYUNyT0pMcGJHL2d5OHpwS2RwN1pqcVkyOVQ3WUl3Q3pV?=
 =?utf-8?B?TXkrNkJiRUc2WmdvN09UWmZSMGp5Vmh3K2JpdU1ZNEdUN2dDK0VqcndlMmtj?=
 =?utf-8?B?VTlYUXNvaUhFdXp2TW5FMHJNTkpHa0FIRXhjUCt4ekJFMnhhMkpxK01tZ2Nn?=
 =?utf-8?B?QXVtdXZ0S1R3aEhKOWU5aERyWENrTkZNVFRqOVRjN0ZlRHgrVCtpaVlYNWJJ?=
 =?utf-8?B?Y0JlQ1Z2bGZxRTdkUEhCLzdrU0hiUkJ6dFdKaGVDYnd1MjVRQno4LzhqemtR?=
 =?utf-8?B?R2s1RWhSQURiNWYzbzBTZDd3bElFOFdiVDUzZngvUGZCQTJHUk5mZTBDOVZQ?=
 =?utf-8?B?UTg2VW1SYlZJZDBieWlOMGJrZ2xaQWMvZmhDUEU3ZG0xb09UNVluMWxmZXQ0?=
 =?utf-8?B?SjNsKzJGVjQrSS9sT1BSWnQ3ZHEwYmRGSk5xQWU1VVIzMGFscWFQNVBMWUto?=
 =?utf-8?B?MFZXWm8rK3lIUzBTNExrS2h1bEVUYmxXSHRPTEx6RzJhelBDOWh5SlhkU3Fj?=
 =?utf-8?B?K0lBNko5MUtFcTg0dFVZMXE4WGhTWVFYUWRPWlJKZ1FjUjBJWmNLa0s1WWtT?=
 =?utf-8?B?eXpPN1RsWlA3SGVvbE9tOGF6ZmxsVnZVRW02b0FRelNBaEZZamxaWHN6cm9y?=
 =?utf-8?B?cGpZeElXRHhOZXJENy9ObjhMYmtDYzE5Q3lFQml4WjJnb2xJWHZlTkRpRno0?=
 =?utf-8?B?ZEl1b2lhOU4wclpUeGN5VGowbEJNR0xaQW5jZTVLQ0FXeDhoTUtuRWc3clFz?=
 =?utf-8?B?MUlqdG5YcW01Z3BKci85aWJQQmwrTk5ta2MyQXdjemEyKzJGSzl3Q1lkdExY?=
 =?utf-8?B?Y1poRmlQZ0JpZ0k2R2ZzNkYzSGNFcFRqTVNidmRoSnM4cW1yNndWa280NFNH?=
 =?utf-8?B?NkdCWG80TFFRM2RwTDB5NnJ5RzhRcmJDVXlIVGw4VjAvb3RydGNiczRzYkkz?=
 =?utf-8?B?cnNvTk9ndHhNM2RjTW1SKzdzRituR1NxaHZ6bHgrblBnNnIvQU1wdVdTeXVQ?=
 =?utf-8?B?cmN6ZEh3d0VPdElGbGIveVpYNkVlNngxS0pLaEtuSWtvOGJxUmhsb09pblBz?=
 =?utf-8?B?YmJOK2Yyclc2TElkRkNTemY1dHd4MnF6QktaQy9mdktFdzMzV0FDTHZaMTlT?=
 =?utf-8?B?ZWZ1QW1QS2pWOXpQeHJVYUhDMGM4ZHIvbVVRdElRSHJJS29ZdDdQQytlSnZ1?=
 =?utf-8?B?SDZGSFR0ellUU1l6MjNOdjZEVS9lVGh0c2lJc2U0cldVWWJSeTIzMnpDWnUw?=
 =?utf-8?B?STBiNVptVFF5WGVjem5IYzgySTcwWWIxTU9NY0h0Tkg0VEJ4dE5qMG40UTFJ?=
 =?utf-8?B?dFNCSmFlb05RN0pnTk41NUQwZVhrL0NDcWtkK0VEQmFmUEVWUldGT0t0M0lT?=
 =?utf-8?B?M1AxTDVLdWlVZjNKY0dDZmRnQzFTbkE0MFF5NnVVbjhHUUN3M1JYb2xZYk5O?=
 =?utf-8?B?ZHZvMjFISElaaDRiYzFkQ25DbkRJa3pFSi9wK01xTitiREZRQVN3My9iQW85?=
 =?utf-8?B?Rnk1QXFwUXVpbmJRSDIvbE5KM2F1OGJjSXlhZFlQMXhha09EanNZYjhxc0Vl?=
 =?utf-8?B?QndrTnI3RmhqVk1kbDdQbDFXdkh5ZUNrSW1uekhDR29xWXJNSEZsNWExaG1E?=
 =?utf-8?B?SG14MDNudS8zb2tqbEo3ZTVZSFhpSnRzVm56cStXUWNLdFhxK3A4VGFXT3h5?=
 =?utf-8?B?am8zNklKc3RMcDF2VGFUbHBZbW5BWFlkVnAwVS9OWTY3UHpKWkttd1pCbm04?=
 =?utf-8?B?ZjBWcUM1Um9mdTIxWk40VnFKTWlhT1RmaXdkZFBldlNyd3VnSnh3U2pidlRn?=
 =?utf-8?B?WWp6bFN2Y0pLMUUxc3JncjZ6aFFNMTFLNFczaUo0c2lXZFM1RnNjdm11STda?=
 =?utf-8?Q?5iAA2GAiAD6UyeDtV6T3mHz8i?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1223929c-1820-49bf-71bb-08dca1a1018a
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 12:00:06.9025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BH/B8zW38RsOepMlYdcRyAo1E7oBfMdGBcVneeY1tAq3mbE19l97zAnOtWeDc0gECSG0TYbjkNaWGcW7AXHoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7692

Hi, Luiz

Thanks.

On 2024/7/9 22:41, Luiz Augusto von Dentz wrote:
> Hi,
>
> On Fri, Jul 5, 2024 at 7:21 AM Yang Li via B4 Relay
> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> This patch introduces support for Amlogic Bluetooth controller over
>> UART. In order to send the final firmware at full speed. It is a pretty
>> straight forward H4 driver with exception of actually having it's own
>> setup address configuration.
>>
>> Co-developed-by: Ye He <ye.he@amlogic.com>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>>   drivers/bluetooth/Kconfig     |  13 +
>>   drivers/bluetooth/Makefile    |   1 +
>>   drivers/bluetooth/hci_aml.c   | 749 ++++++++++++++++++++++++++++++++++++++++++
>>   drivers/bluetooth/hci_ldisc.c |   8 +-
>>   drivers/bluetooth/hci_uart.h  |   8 +-
>>   5 files changed, 776 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
>> index 87484f5de8e3..634479e10cb7 100644
>> --- a/drivers/bluetooth/Kconfig
>> +++ b/drivers/bluetooth/Kconfig
>> @@ -273,6 +273,19 @@ config BT_HCIUART_MRVL
>>
>>            Say Y here to compile support for HCI MRVL protocol.
>>
>> +config BT_HCIUART_AML
>> +       bool "Amlogic protocol support"
>> +       depends on BT_HCIUART
>> +       depends on BT_HCIUART_SERDEV
>> +       select BT_HCIUART_H4
>> +       select FW_LOADER
>> +       select POWER_SEQUENCING_AML_WCN
>> +       help
>> +         The Amlogic protocol support enables Bluetooth HCI over serial
>> +         port interface for Amlogic Bluetooth controllers.
>> +
>> +         Say Y here to compile support for HCI AML protocol.
>> +
>>   config BT_HCIBCM203X
>>          tristate "HCI BCM203x USB driver"
>>          depends on USB
>> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
>> index 0730d6684d1a..81856512ddd0 100644
>> --- a/drivers/bluetooth/Makefile
>> +++ b/drivers/bluetooth/Makefile
>> @@ -51,4 +51,5 @@ hci_uart-$(CONFIG_BT_HCIUART_BCM)     += hci_bcm.o
>>   hci_uart-$(CONFIG_BT_HCIUART_QCA)      += hci_qca.o
>>   hci_uart-$(CONFIG_BT_HCIUART_AG6XX)    += hci_ag6xx.o
>>   hci_uart-$(CONFIG_BT_HCIUART_MRVL)     += hci_mrvl.o
>> +hci_uart-$(CONFIG_BT_HCIUART_AML)      += hci_aml.o
>>   hci_uart-objs                          := $(hci_uart-y)
>> diff --git a/drivers/bluetooth/hci_aml.c b/drivers/bluetooth/hci_aml.c
>> new file mode 100644
>> index 000000000000..33a27a555343
>> --- /dev/null
>> +++ b/drivers/bluetooth/hci_aml.c
>> @@ -0,0 +1,749 @@
>> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
>> +/*
>> + * Copyright (C) 2024 Amlogic, Inc. All rights reserved
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/module.h>
>> +#include <linux/gpio.h>
>> +#include <linux/of_gpio.h>
>> +#include <linux/of.h>
>> +#include <linux/serdev.h>
>> +#include <linux/pwm.h>
>> +#include <linux/clk.h>
>> +#include <linux/mutex.h>
>> +#include <asm/unaligned.h>
>> +#include <linux/firmware.h>
>> +#include <linux/vmalloc.h>
>> +#include <linux/pwrseq/consumer.h>
>> +#include <net/bluetooth/bluetooth.h>
>> +#include <net/bluetooth/hci_core.h>
>> +#include <net/bluetooth/hci.h>
>> +
>> +#include "hci_uart.h"
>> +
>> +#define AML_EVT_HEAD_SIZE              4
>> +#define AML_BDADDR_DEFAULT (&(bdaddr_t) {{ 0x00, 0xff, 0x00, 0x22, 0x2d, 0xae }})
>> +
>> +#define AML_FIRMWARE_OPERATION_SIZE            (248)
>> +#define AML_FIRMWARE_MAX_SIZE                  (512 * 1024)
>> +
>> +/* waiting time (ms) */
>> +#define AML_WAIT_CHIP_START_UP                 (350)
>> +
>> +/* TCI command */
>> +#define AML_TCI_CMD_READ                       0xFEF0
>> +#define AML_TCI_CMD_WRITE                      0xFEF1
>> +#define AML_TCI_CMD_UPDATE_BAUDRATE            0xFEF2
>> +#define AML_TCI_CMD_HARDWARE_RESET             0xFEF2
>> +#define AML_TCI_CMD_DOWNLOAD_BT_FW             0xFEF3
>> +#define AML_BT_HCI_VENDOR_CMD                  0xFC1A
>> +
>> +/* TCI operation parameter in controller chip */
>> +#define AML_OP_UART_MODE                       0x00A30128
>> +#define AML_OP_EVT_ENABLE                      0x00A70014
>> +#define AML_OP_MEM_HARD_TRANS_EN               0x00A7000C
>> +#define AML_OP_RF_CFG                          0x00F03040
>> +#define AML_OP_RAM_POWER_CTR                   0x00F03050
>> +#define AML_OP_HARDWARE_RST                    0x00F03058
>> +#define AML_OP_ICCM_RAM_BASE                   0x00000000
>> +#define AML_OP_DCCM_RAM_BASE                   0x00D00000
>> +
>> +/* uart configuration */
>> +#define AML_UART_XMIT_EN                       BIT(12)
>> +#define AML_UART_RECV_EN                       BIT(13)
>> +#define AML_UART_TIMEOUT_INT_EN                        BIT(14)
>> +#define AML_UART_CLK_SOURCE                    40000000
>> +
>> +/* controller event enable/disable */
>> +#define AML_EVT_EN                             BIT(24)
>> +
>> +/* RAM power down control */
>> +#define AML_RAM_POWER_ON                       (0)
>> +#define AML_RAM_POWER_OFF                      (1)
>> +
>> +/* RF configuration */
>> +#define AML_RF_A2DP_SINK_EN                    BIT(25)
>> +#define AML_RF_ANT_SINGLE                      BIT(28)
>> +#define AML_RF_ANT_DOUBLE                      BIT(29)
>> +#define AML_RF_ANT_BASE                                (28)
>> +#define AML_BT_CTR_SET_ANT(ant_num)            (BIT(((ant_num) - 1)) << AML_RF_ANT_BASE)
>> +
>> +/* memory control hard transaction */
>> +#define AML_MM_CTR_HARD_TRAS_EN                        BIT(27)
>> +
>> +/* controller hardware reset */
>> +#define AML_CTR_CPU_RESET                      BIT(8)
>> +#define AML_CTR_MAC_RESET                      BIT(9)
>> +#define AML_CTR_PHY_RESET                      BIT(10)
>> +
>> +enum {
>> +       FW_ICCM,
>> +       FW_DCCM
>> +};
>> +
>> +struct aml_fw_len {
>> +       u32 iccm_len;
>> +       u32 dccm_len;
>> +};
>> +
>> +struct aml_tci_rsp {
>> +       u8 num_cmd_packet;
>> +       u16 opcode;
>> +       u8 status;
>> +} __packed;
>> +
>> +struct aml_rf_cfg {
>> +       u32 ant_number;
>> +       u32 a2dp_sink_en;
>> +};
>> +
>> +struct aml_serdev {
>> +       struct hci_uart serdev_hu;
>> +       struct device *dev;
>> +       struct aml_rf_cfg rf_cfg;
>> +       struct pwrseq_desc *pwrseq;
>> +       const char *firmware_name;
>> +       int iccm_offset;
>> +       int dccm_offset;
>> +};
>> +
>> +struct aml_data {
>> +       struct sk_buff *rx_skb;
>> +       struct sk_buff_head txq;
>> +};
>> +
>> +struct aml_device_data {
>> +       int iccm_offset;
>> +       int dccm_offset;
>> +};
>> +
>> +static const struct h4_recv_pkt aml_recv_pkts[] = {
>> +       {H4_RECV_ACL, .recv = hci_recv_frame},
>> +       {H4_RECV_SCO, .recv = hci_recv_frame},
>> +       {H4_RECV_EVENT, .recv = hci_recv_frame},
>> +       {H4_RECV_ISO, .recv = hci_recv_frame},
>> +};
>> +
>> +/* The TCI command is private of Amlogic, it is used to configure before BT chip
>> + * startup, contains update baudrate, update firmware, set public addr ...
>> + * op_code |      op_len           | op_addr | parameter   |
>> + * --------|-----------------------|---------|-------------|
>> + *   2B    | 1B len(addr+param)    |    4B   |  len(param) |
>> + */
>> +static int aml_send_tci_cmd(struct hci_dev *hdev, u16 op_code, u32 op_addr,
>> +                           u32 *param, u32 param_len)
>> +{
>> +       struct sk_buff *skb = NULL;
>> +       struct aml_tci_rsp *rsp = NULL;
>> +       u8 *buf = NULL;
>> +       u32 buf_len = 0;
>> +       int err = 0;
>> +
>> +       buf_len = sizeof(op_addr) + param_len;
>> +       buf = vmalloc(buf_len);
>> +       if (!buf) {
>> +               BT_ERR("Failed to alloc memory.");
>> +               err = -ENOMEM;
>> +               goto exit;
>> +       }
>> +
>> +       memcpy(buf, &op_addr, sizeof(op_addr));
>> +       if (param && param_len > 0)
>> +               memcpy(buf + sizeof(op_addr), param, param_len);
>> +
>> +       skb = __hci_cmd_sync_ev(hdev, op_code, buf_len, buf,
>> +                               HCI_EV_CMD_COMPLETE, HCI_INIT_TIMEOUT);
>> +       if (IS_ERR(skb)) {
>> +               err = PTR_ERR(skb);
>> +               skb = NULL;
>> +               BT_ERR("Failed to send TCI cmd:(%d)", err);
>> +               goto exit;
>> +       }
>> +
>> +       rsp = (struct aml_tci_rsp *)(skb->data);
>> +       if (rsp->opcode != op_code || rsp->status != 0x00) {
>> +               BT_ERR("send TCI cmd(0x%04X), response(0x%04X):(%d)",
>> +                      op_code, rsp->opcode, rsp->status);
>> +               err = -EINVAL;
>> +               goto exit;
>> +       }
>> +
>> +exit:
>> +       if (buf)
>> +               vfree(buf);
>> +       if (skb)
>> +               kfree_skb(skb);
>> +       return err;
>> +}
>> +
>> +static int aml_update_chip_baudrate(struct hci_dev *hdev, u32 baud)
>> +{
>> +       u32 value;
>> +
>> +       value = ((AML_UART_CLK_SOURCE / baud) - 1) & 0x0FFF;
>> +       value |= AML_UART_XMIT_EN | AML_UART_RECV_EN | AML_UART_TIMEOUT_INT_EN;
>> +
>> +       return aml_send_tci_cmd(hdev, AML_TCI_CMD_UPDATE_BAUDRATE,
>> +                                 AML_OP_UART_MODE, &value, sizeof(value));
>> +}
>> +
>> +static int aml_start_chip(struct hci_dev *hdev)
>> +{
>> +       u32 value = 0;
>> +       int ret;
>> +
>> +       value = AML_MM_CTR_HARD_TRAS_EN;
>> +       ret = aml_send_tci_cmd(hdev, AML_TCI_CMD_WRITE,
>> +                              AML_OP_MEM_HARD_TRANS_EN,
>> +                              &value, sizeof(value));
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* controller hardware reset. */
>> +       value = AML_CTR_CPU_RESET | AML_CTR_MAC_RESET | AML_CTR_PHY_RESET;
>> +       ret = aml_send_tci_cmd(hdev, AML_TCI_CMD_HARDWARE_RESET,
>> +                              AML_OP_HARDWARE_RST,
>> +                              &value, sizeof(value));
>> +       return ret;
>> +}
>> +
>> +static int aml_send_firmware_segment(struct hci_dev *hdev,
>> +                                    u8 fw_type,
>> +                                    u8 *seg,
>> +                                    u32 seg_size,
>> +                                    u32 offset)
>> +{
>> +       u32 op_addr = 0;
>> +
>> +       if (fw_type == FW_ICCM)
>> +               op_addr = AML_OP_ICCM_RAM_BASE  + offset;
>> +       else if (fw_type == FW_DCCM)
>> +               op_addr = AML_OP_DCCM_RAM_BASE + offset;
>> +
>> +       return aml_send_tci_cmd(hdev, AML_TCI_CMD_DOWNLOAD_BT_FW,
>> +                            op_addr, (u32 *)seg, seg_size);
>> +}
>> +
>> +static int aml_send_firmware(struct hci_dev *hdev, u8 fw_type,
>> +                            u8 *fw, u32 fw_size, u32 offset)
>> +{
>> +       u32 seg_size = 0;
>> +       u32 seg_off = 0;
>> +
>> +       if (fw_size > AML_FIRMWARE_MAX_SIZE) {
>> +               BT_ERR("fw_size error, fw_size:%d, max_size: %d",
>> +                      fw_size, AML_FIRMWARE_MAX_SIZE);
>> +               return -EINVAL;
>> +       }
>> +       while (fw_size > 0) {
>> +               seg_size = (fw_size > AML_FIRMWARE_OPERATION_SIZE) ?
>> +                          AML_FIRMWARE_OPERATION_SIZE : fw_size;
>> +               if (aml_send_firmware_segment(hdev, fw_type, (fw + seg_off),
>> +                                             seg_size, offset)) {
>> +                       BT_ERR("Failed send firmware, type:%d, offset:0x%x",
>> +                              fw_type, offset);
>> +                       return -EINVAL;
>> +               }
>> +               seg_off += seg_size;
>> +               fw_size -= seg_size;
>> +               offset += seg_size;
>> +       }
>> +       return 0;
>> +}
>> +
>> +static int aml_download_firmware(struct hci_dev *hdev, const char *fw_name)
>> +{
>> +       struct hci_uart *hu = hci_get_drvdata(hdev);
>> +       struct aml_serdev *amldev = serdev_device_get_drvdata(hu->serdev);
>> +       const struct firmware *firmware = NULL;
>> +       struct aml_fw_len *fw_len = NULL;
>> +       u8 *iccm_start = NULL, *dccm_start = NULL;
>> +       u32 iccm_len, dccm_len;
>> +       u32 value = 0;
>> +       int ret = 0;
>> +
>> +       /* enable firmware download event. */
>> +       value = AML_EVT_EN;
>> +       ret = aml_send_tci_cmd(hdev, AML_TCI_CMD_WRITE,
>> +                              AML_OP_EVT_ENABLE,
>> +                              &value, sizeof(value));
>> +       if (ret)
>> +               goto exit;
>> +
>> +       /* RAM power on */
>> +       value = AML_RAM_POWER_ON;
>> +       ret = aml_send_tci_cmd(hdev, AML_TCI_CMD_WRITE,
>> +                              AML_OP_RAM_POWER_CTR,
>> +                              &value, sizeof(value));
>> +       if (ret)
>> +               goto exit;
>> +
>> +       /* check RAM power status */
>> +       ret = aml_send_tci_cmd(hdev, AML_TCI_CMD_READ,
>> +                              AML_OP_RAM_POWER_CTR, NULL, 0);
>> +       if (ret)
>> +               goto exit;
>> +
>> +       ret = request_firmware(&firmware, fw_name, &hdev->dev);
>> +       if (ret < 0) {
>> +               BT_ERR("Failed to load <%s>:(%d)", fw_name, ret);
>> +               goto exit;
>> +       }
>> +
>> +       fw_len = (struct aml_fw_len *)firmware->data;
>> +
>> +       /* download ICCM. */
>> +       iccm_start = (u8 *)(firmware->data) + sizeof(struct aml_fw_len) + amldev->iccm_offset;
>> +       iccm_len = fw_len->iccm_len - amldev->iccm_offset;
>> +       ret = aml_send_firmware(hdev, FW_ICCM, iccm_start, iccm_len, amldev->iccm_offset);
>> +       if (ret) {
>> +               BT_ERR("Failed to send FW_ICCM");
>> +               goto exit;
>> +       }
>> +
>> +       /* download DCCM. */
>> +       dccm_start = (u8 *)(firmware->data) + sizeof(struct aml_fw_len) + fw_len->iccm_len;
>> +       dccm_len = fw_len->dccm_len;
>> +       ret = aml_send_firmware(hdev, FW_DCCM, dccm_start, dccm_len, amldev->dccm_offset);
>> +       if (ret) {
>> +               BT_ERR("Failed to send FW_DCCM");
>> +               goto exit;
>> +       }
>> +
>> +       /* disable firmware download event. */
>> +       value = 0;
>> +       ret = aml_send_tci_cmd(hdev, AML_TCI_CMD_WRITE,
>> +                              AML_OP_EVT_ENABLE,
>> +                              &value, sizeof(value));
>> +       if (ret)
>> +               goto exit;
>> +
>> +exit:
>> +       if (firmware)
>> +               release_firmware(firmware);
>> +       return ret;
>> +}
>> +
>> +static int aml_send_reset(struct hci_dev *hdev)
>> +{
>> +       struct sk_buff *skb;
>> +       int err;
>> +
>> +       skb = __hci_cmd_sync_ev(hdev, HCI_OP_RESET, 0, NULL,
>> +                               HCI_EV_CMD_COMPLETE, HCI_INIT_TIMEOUT);
>> +       if (IS_ERR(skb)) {
>> +               err = PTR_ERR(skb);
>> +               BT_ERR("Failed to send hci reset cmd(%d)", err);
>> +               return err;
>> +       }
>> +       kfree_skb(skb);
>> +       return 0;
>> +}
>> +
>> +static int aml_dump_fw_version(struct hci_dev *hdev)
>> +{
>> +       struct sk_buff *skb;
>> +       struct aml_tci_rsp *rsp = NULL;
>> +       u8 value[6] = {0};
>> +       u8 *fw_ver = NULL;
>> +       int err = 0;
>> +
>> +       skb = __hci_cmd_sync_ev(hdev, AML_BT_HCI_VENDOR_CMD, sizeof(value), value,
>> +                               HCI_EV_CMD_COMPLETE, HCI_INIT_TIMEOUT);
>> +       if (IS_ERR(skb)) {
>> +               skb = NULL;
>> +               err = PTR_ERR(skb);
>> +               BT_ERR("Failed get fw version:(%d)", err);
>> +               goto exit;
>> +       }
>> +
>> +       rsp = (struct aml_tci_rsp *)(skb->data);
>> +       if (rsp->opcode != AML_BT_HCI_VENDOR_CMD || rsp->status != 0x00) {
>> +               BT_ERR("dump version, error response (0x%04X):(%d)",
>> +                      rsp->opcode, rsp->status);
>> +               err = -EINVAL;
>> +               goto exit;
>> +       }
>> +
>> +       fw_ver = skb->data + AML_EVT_HEAD_SIZE;
>> +       BT_INFO("fw_version: date = %02x.%02x, number = 0x%02x%02x",
>> +               *(fw_ver + 1), *fw_ver, *(fw_ver + 3), *(fw_ver + 2));
>> +
>> +exit:
>> +       if (skb)
>> +               kfree_skb(skb);
>> +       return err;
>> +}
>> +
>> +static int aml_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
>> +{
>> +       struct sk_buff *skb;
>> +       struct aml_tci_rsp *rsp = NULL;
>> +       int err = 0;
>> +
>> +       BT_INFO("set bdaddr (%pM)", bdaddr);
>> +       skb = __hci_cmd_sync_ev(hdev, AML_BT_HCI_VENDOR_CMD,
>> +                               sizeof(bdaddr_t), bdaddr,
>> +                               HCI_EV_CMD_COMPLETE, HCI_INIT_TIMEOUT);
>> +       if (IS_ERR(skb)) {
>> +               skb = NULL;
>> +               err = PTR_ERR(skb);
>> +               BT_ERR("Failed to set bdaddr:(%d)", err);
>> +               goto exit;
>> +       }
>> +
>> +       rsp = (struct aml_tci_rsp *)(skb->data);
>> +       if (rsp->opcode != AML_BT_HCI_VENDOR_CMD || rsp->status != 0x00) {
>> +               BT_ERR("error response (0x%x):(%d)", rsp->opcode, rsp->status);
>> +               err = -EINVAL;
>> +               goto exit;
>> +       }
>> +
>> +exit:
>> +       if (skb)
>> +               kfree_skb(skb);
>> +       return err;
>> +}
>> +
>> +static int aml_check_bdaddr(struct hci_dev *hdev)
>> +{
>> +       struct hci_rp_read_bd_addr *paddr;
>> +       struct sk_buff *skb;
>> +       int err;
>> +
>> +       if (bacmp(&hdev->public_addr, BDADDR_ANY))
>> +               return 0;
>> +
>> +       skb = __hci_cmd_sync(hdev, HCI_OP_READ_BD_ADDR, 0, NULL,
>> +                            HCI_INIT_TIMEOUT);
>> +       if (IS_ERR(skb)) {
>> +               err = PTR_ERR(skb);
>> +               BT_ERR("Failed to read bdaddr:(%d)", err);
>> +               return err;
>> +       }
>> +
>> +       if (skb->len != sizeof(*paddr)) {
>> +               BT_ERR("Device address length mismatch");
>> +               kfree_skb(skb);
>> +               return -EIO;
>> +       }
>> +
>> +       paddr = (struct hci_rp_read_bd_addr *)skb->data;
>> +       if (!bacmp(&paddr->bdaddr, AML_BDADDR_DEFAULT)) {
>> +               BT_INFO("amlbt using default bdaddr (%pM)", &paddr->bdaddr);
>> +               set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
>> +       }
>> +
>> +       kfree_skb(skb);
>> +
>> +       return 0;
>> +}
>> +
>> +static int aml_config_rf(struct hci_dev *hdev, struct aml_rf_cfg *cfg)
>> +{
>> +       u32 value = 0;
>> +
>> +       if (cfg->a2dp_sink_en)
>> +               value |= AML_RF_A2DP_SINK_EN;
>> +
>> +       if (cfg->ant_number > 0)
>> +               value |= AML_BT_CTR_SET_ANT(cfg->ant_number);
>> +
>> +       return aml_send_tci_cmd(hdev, AML_TCI_CMD_WRITE,
>> +                               AML_OP_RF_CFG,
>> +                               &value, sizeof(value));
>> +}
>> +
>> +static int aml_parse_resource(struct aml_serdev *amldev)
>> +{
>> +       struct device *pdev = amldev->dev;
>> +
>> +       /* get firmware path*/
>> +       if (of_property_read_string(pdev->of_node, "amlogic,firmware",
>> +                                   &amldev->firmware_name)) {
>> +               dev_err(pdev, "Failed to read firmware path");
>> +               return -ENODEV;
>> +       }
>> +       BT_DBG("firmware path:%s", amldev->firmware_name);
> Please replace uses of BT_DBG with bt_dev_dbg.
Well, I got it.
>
>> +       /* get controller config parameter */
>> +       if (of_property_read_u32(pdev->of_node, "amlogic,antenna-number",
>> +                                &amldev->rf_cfg.ant_number)) {
>> +               dev_info(pdev, "No antenna-number, using default value");
>> +               amldev->rf_cfg.ant_number = 1;
>> +       }
>> +
>> +       if (of_property_read_u32(pdev->of_node, "amlogic,a2dp-sink-enable",
>> +                                &amldev->rf_cfg.a2dp_sink_en)) {
>> +               dev_info(pdev, "No a2dp-sink-enable, using default value");
>> +               amldev->rf_cfg.a2dp_sink_en = 0;
>> +       }
>> +       BT_DBG("rf_config ant_num:%d, a2dp_sink_en:%d",
>> +               amldev->rf_cfg.ant_number, amldev->rf_cfg.a2dp_sink_en);
>> +       return 0;
>> +}
>> +
>> +static int aml_set_baudrate(struct hci_uart *hu, unsigned int speed)
>> +{
>> +       struct aml_serdev *amldev = serdev_device_get_drvdata(hu->serdev);
>> +       struct hci_dev *hdev = amldev->serdev_hu.hdev;
>> +
>> +       /* update controller baudrate*/
>> +       if (aml_update_chip_baudrate(hdev, speed) != 0) {
>> +               BT_ERR("Failed to update baud rate");
> Replace instances of BT_ERR with bt_dev_err.
Well, I got it.
>
>> +               return -EINVAL;
>> +       }
>> +
>> +       /* update local baudrate*/
>> +       serdev_device_set_baudrate(hu->serdev, speed);
>> +
>> +       return 0;
>> +}
>> +
>> +/* Initialize protocol */
>> +static int aml_open(struct hci_uart *hu)
>> +{
>> +       struct aml_data *aml_data;
>> +       struct aml_serdev *amldev = serdev_device_get_drvdata(hu->serdev);
>> +
>> +       if (aml_parse_resource(amldev)) {
>> +               BT_ERR("Failed to parse resource");
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (pwrseq_power_on(amldev->pwrseq)) {
>> +               BT_ERR("Failed to power on chipset");
>> +               return -EPERM;
>> +       }
>> +
>> +       if (!hci_uart_has_flow_control(hu)) {
>> +               BT_ERR("no flow control");
>> +               return -EOPNOTSUPP;
>> +       }
>> +
>> +       aml_data = kzalloc(sizeof(*aml_data), GFP_KERNEL);
>> +       if (!aml_data) {
>> +               BT_ERR("Failed to kzalloc with aml_data");
>> +               return -ENOMEM;
>> +       }
>> +
>> +       skb_queue_head_init(&aml_data->txq);
>> +
>> +       hu->priv = aml_data;
>> +
>> +       return 0;
>> +}
>> +
>> +/* Close protocol */
>> +static int aml_close(struct hci_uart *hu)
>> +{
>> +       struct aml_data *aml_data = hu->priv;
>> +       struct aml_serdev *amldev = serdev_device_get_drvdata(hu->serdev);
>> +
>> +       if (hu->serdev)
>> +               serdev_device_close(hu->serdev);
>> +
>> +       skb_queue_purge(&aml_data->txq);
>> +       kfree_skb(aml_data->rx_skb);
>> +       kfree(aml_data);
>> +
>> +       hu->priv = NULL;
>> +
>> +       return pwrseq_power_off(amldev->pwrseq);
>> +}
>> +
>> +static int aml_flush(struct hci_uart *hu)
>> +{
>> +       struct aml_data *aml_data = hu->priv;
>> +
>> +       skb_queue_purge(&aml_data->txq);
>> +
>> +       return 0;
>> +}
>> +
>> +static int aml_setup(struct hci_uart *hu)
>> +{
>> +       struct aml_serdev *amldev = serdev_device_get_drvdata(hu->serdev);
>> +       struct hci_dev *hdev = amldev->serdev_hu.hdev;
>> +       int err;
>> +
>> +       /* Setup bdaddr */
>> +       hdev->set_bdaddr = aml_set_bdaddr;
>> +
>> +       err = aml_set_baudrate(hu, amldev->serdev_hu.proto->oper_speed);
>> +       if (err)
>> +               return err;
>> +
>> +       err = aml_download_firmware(hdev, amldev->firmware_name);
>> +       if (err)
>> +               return err;
>> +
>> +       err = aml_config_rf(hdev, &amldev->rf_cfg);
>> +       if (err)
>> +               return err;
>> +
>> +       err = aml_start_chip(hdev);
>> +       if (err)
>> +               return err;
>> +
>> +       /* wait 350ms for controller start up*/
>> +       msleep(AML_WAIT_CHIP_START_UP);
>> +
>> +       err = aml_dump_fw_version(hdev);
>> +       if (err)
>> +               return err;
>> +
>> +       err = aml_send_reset(hdev);
>> +       if (err)
>> +               return err;
>> +
>> +       err = aml_check_bdaddr(hdev);
>> +       if (err)
>> +               return err;
>> +
>> +       return 0;
>> +}
>> +
>> +static int aml_enqueue(struct hci_uart *hu, struct sk_buff *skb)
>> +{
>> +       struct aml_data *aml_data = hu->priv;
>> +
>> +       skb_queue_tail(&aml_data->txq, skb);
>> +
>> +       return 0;
>> +}
>> +
>> +static struct sk_buff *aml_dequeue(struct hci_uart *hu)
>> +{
>> +       struct aml_data *aml_data = hu->priv;
>> +       struct sk_buff *skb;
>> +
>> +       skb = skb_dequeue(&aml_data->txq);
>> +
>> +       /* Prepend skb with frame type */
>> +       if (skb)
>> +               memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
>> +
>> +       return skb;
>> +}
>> +
>> +static int aml_recv(struct hci_uart *hu, const void *data, int count)
>> +{
>> +       struct aml_data *aml_data = hu->priv;
>> +       int err;
>> +
>> +       aml_data->rx_skb = h4_recv_buf(hu->hdev, aml_data->rx_skb, data, count,
>> +                                      aml_recv_pkts,
>> +                                      ARRAY_SIZE(aml_recv_pkts));
>> +       if (IS_ERR(aml_data->rx_skb)) {
>> +               err = PTR_ERR(aml_data->rx_skb);
>> +               bt_dev_err(hu->hdev, "Frame reassembly failed (%d)", err);
>> +               aml_data->rx_skb = NULL;
>> +               return err;
>> +       }
>> +
>> +       return count;
>> +}
>> +
>> +static const struct hci_uart_proto aml_hci_proto = {
>> +       .id             = HCI_UART_AML,
>> +       .name           = "AML",
>> +       .manufacturer   = 50,
>> +       .init_speed     = 115200,
>> +       .oper_speed     = 4000000,
>> +       .open           = aml_open,
>> +       .close          = aml_close,
>> +       .setup          = aml_setup,
>> +       .flush          = aml_flush,
>> +       .recv           = aml_recv,
>> +       .enqueue        = aml_enqueue,
>> +       .dequeue        = aml_dequeue,
>> +};
>> +
>> +static void aml_device_driver_shutdown(struct device *dev)
>> +{
>> +       struct aml_serdev *amldev = dev_get_drvdata(dev);
>> +
>> +       pwrseq_power_off(amldev->pwrseq);
>> +}
>> +
>> +static int aml_serdev_probe(struct serdev_device *serdev)
>> +{
>> +       struct aml_serdev *amldev;
>> +       const struct aml_device_data *data;
>> +       int err;
>> +
>> +       amldev = devm_kzalloc(&serdev->dev, sizeof(*amldev), GFP_KERNEL);
>> +       if (!amldev)
>> +               return -ENOMEM;
>> +
>> +       amldev->serdev_hu.serdev = serdev;
>> +       amldev->dev = &serdev->dev;
>> +       serdev_device_set_drvdata(serdev, amldev);
>> +
>> +       amldev->pwrseq = devm_pwrseq_get(&serdev->dev, "bluetooth");
>> +       if (IS_ERR(amldev->pwrseq))
>> +               return dev_err_probe(amldev->dev, PTR_ERR(amldev->pwrseq),
>> +                             "Failed to get pwrseq target");
>> +
>> +       err = hci_uart_register_device(&amldev->serdev_hu, &aml_hci_proto);
>> +       if (err)
>> +               return dev_err_probe(amldev->dev, err,
>> +                             "Failed to register hci uart device");
>> +
>> +       data = device_get_match_data(&serdev->dev);
>> +       if (data) {
>> +               amldev->iccm_offset = data->iccm_offset;
>> +               amldev->dccm_offset = data->dccm_offset;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static void aml_serdev_remove(struct serdev_device *serdev)
>> +{
>> +       struct aml_serdev *amldev = serdev_device_get_drvdata(serdev);
>> +
>> +       hci_uart_unregister_device(&amldev->serdev_hu);
>> +}
>> +
>> +static const struct aml_device_data data_w155s2 __maybe_unused = {
>> +       .iccm_offset = 256 * 1024,
>> +};
>> +
>> +static const struct aml_device_data data_w265s2 __maybe_unused = {
>> +       .iccm_offset = 384 * 1024,
>> +};
>> +
>> +static const struct of_device_id aml_bluetooth_of_match[] = {
>> +       { .compatible = "amlogic,w155s2-bt", .data = &data_w155s2 },
>> +       { .compatible = "amlogic,w265s2-bt", .data = &data_w265s2 },
>> +       { /* sentinel */ },
>> +};
>> +
>> +static struct serdev_device_driver aml_serdev_driver = {
>> +       .probe = aml_serdev_probe,
>> +       .remove = aml_serdev_remove,
>> +       .driver = {
>> +               .name = "hci_uart_aml",
>> +               .of_match_table = of_match_ptr(aml_bluetooth_of_match),
>> +               .shutdown = aml_device_driver_shutdown,
>> +       },
>> +};
>> +
>> +int __init aml_init(void)
>> +{
>> +       serdev_device_driver_register(&aml_serdev_driver);
>> +
>> +       return hci_uart_register_proto(&aml_hci_proto);
>> +}
>> +
>> +int __exit aml_deinit(void)
>> +{
>> +       serdev_device_driver_unregister(&aml_serdev_driver);
>> +
>> +       return hci_uart_unregister_proto(&aml_hci_proto);
>> +}
>> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
>> index 30192bb08354..d307c41a5470 100644
>> --- a/drivers/bluetooth/hci_ldisc.c
>> +++ b/drivers/bluetooth/hci_ldisc.c
>> @@ -870,7 +870,9 @@ static int __init hci_uart_init(void)
>>   #ifdef CONFIG_BT_HCIUART_MRVL
>>          mrvl_init();
>>   #endif
>> -
>> +#ifdef CONFIG_BT_HCIUART_AML
>> +       aml_init();
>> +#endif
>>          return 0;
>>   }
>>
>> @@ -906,7 +908,9 @@ static void __exit hci_uart_exit(void)
>>   #ifdef CONFIG_BT_HCIUART_MRVL
>>          mrvl_deinit();
>>   #endif
>> -
>> +#ifdef CONFIG_BT_HCIUART_AML
>> +       aml_deinit();
>> +#endif
>>          tty_unregister_ldisc(&hci_uart_ldisc);
>>   }
>>
>> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
>> index 00bf7ae82c5b..fbf3079b92a5 100644
>> --- a/drivers/bluetooth/hci_uart.h
>> +++ b/drivers/bluetooth/hci_uart.h
>> @@ -20,7 +20,7 @@
>>   #define HCIUARTGETFLAGS                _IOR('U', 204, int)
>>
>>   /* UART protocols */
>> -#define HCI_UART_MAX_PROTO     12
>> +#define HCI_UART_MAX_PROTO     13
>>
>>   #define HCI_UART_H4    0
>>   #define HCI_UART_BCSP  1
>> @@ -34,6 +34,7 @@
>>   #define HCI_UART_AG6XX 9
>>   #define HCI_UART_NOKIA 10
>>   #define HCI_UART_MRVL  11
>> +#define HCI_UART_AML   12
>>
>>   #define HCI_UART_RAW_DEVICE    0
>>   #define HCI_UART_RESET_ON_INIT 1
>> @@ -209,3 +210,8 @@ int ag6xx_deinit(void);
>>   int mrvl_init(void);
>>   int mrvl_deinit(void);
>>   #endif
>> +
>> +#ifdef CONFIG_BT_HCIUART_AML
>> +int aml_init(void);
>> +int aml_deinit(void);
>> +#endif
>>
>> --
>> 2.42.0
>>
>>
>
> --
> Luiz Augusto von Dentz

