Return-Path: <netdev+bounces-165028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E49A301AF
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 03:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03D31888DFB
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 02:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8E61C3C1C;
	Tue, 11 Feb 2025 02:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="7Dtw1A8B"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE4E26BDB3
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 02:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739242360; cv=fail; b=FGUlPHJKg1IvJZcKPJwOCuvW5UcKvZYRLnHaehc9FKOpv9XKI+qVoceGt3CoOqTIkxFrRkT7OgPjNpowrm+X8oyHLygY3HDH8gtKXgJpoxnL9E2xnElyHYZmDHRq30aSfUERLTpLy1TH1ZESoDIXJ9zpelshUDMY4aPBbubF3Pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739242360; c=relaxed/simple;
	bh=/Bhuc3+iWfnVmEnymv6eSYT847xa3E5euiMxDWzNofc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f69+QrQRhak/vO56gsjvSfw8snIN5VK8vQ4NTozwlsKOhhbczgQWBHQblkOVXAkhG1RkTRqmAw9ffiK6ZZkG0zeHNN9BpnMP/wPSMoikYZEJ9Ji6EXX2XX1bpjDOgGxwq0lQ6Lnn8Ki+Zc9AIMfgEaICCaBEmslrva2pd8s68Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=7Dtw1A8B; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1739242358; x=1770778358;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=/Bhuc3+iWfnVmEnymv6eSYT847xa3E5euiMxDWzNofc=;
  b=7Dtw1A8BaoXICQttTqW+HUBS4qNstBaxf0oVcyQDFcgselXh0XeWxBjs
   QHut1G7bGL4r0/6Tt2SfBVXQ+k7kmKhtIJEFTl51BovM/v3x4dzSJCHUE
   //Y56v8UGX8UXnUnYSacOilHW+ch91yEm0t+QX9PTZbO517yO1QlPj1lE
   c=;
X-CSE-ConnectionGUID: 4e4LYYb8SFG6WeMYAa63Ow==
X-CSE-MsgGUID: 4LRmJtF9RFqHMP63sm/Rog==
X-Talos-CUID: 9a23:+kA5cm7c97bIqlvAxtssqENIPvEUeC3m4liOHEKdOE9gFuayVgrF
X-Talos-MUID: 9a23:jXGixwS4rG3dszJwRXSwoAtnFttGsp6AEWAoqctdoMzDDyt/bmI=
Received: from mail-canadacentralazlp17012027.outbound.protection.outlook.com (HELO YT6PR01CU002.outbound.protection.outlook.com) ([40.93.18.27])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 21:52:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f81JORM2fZWEt5p9VdW3M/UhCDp7gOAa2zr0pOBmgz8hIiBnMnCVF1dsc+cB/iBnDEpXvUXBdSvWrBZxudyTj/xFi3BLtsFwWSXLLwv2xFuE4y9zZmd133Jz1Aol214dj11aACC216sZ+3rntLEPDeU8O9T36Znp/lcETiRX7QlCVY5FZz06rk6CP/eJCkiQOi17rhsva48hR1keTfp8fxqMCuWwuGn5l1eiFGv5kCjbcfx/qqZsUCjuA4Z/aOi4xRKGgatS8vGw2I1oCOnR10jb/KGKNDx2BAvTBJdqsgk+4HR7n2Ni7WsZJ7nv7juqBLE5NWLWAwgHxuSFNPpV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzeexKB6IzMRfvLb5a6iWfddRkDUqaEjUyZfWtV+e0c=;
 b=DagZJon3ZubFvdBdP1PKrvukWYEulxYAXidLZpnBQtqPkoW8xzRB680ysmP0dAhPDTbau2V8HM/Ds+tb/2XNXi3gtYdK9L1syEBsb6aOEVx9hI34pDx+hfHjSWcukTOcNE0cXLlmYHSLzxdzbJ/fRz85Svar3aOtgTXL/NeU6Iz0C93v52tgyB3eGQR/HNaR2oQTnwgO3no/qnh5QuK/pzplC0A1h7SsgHrMBMqJtxB128n7zIg/XVlTpxCwKGLzh8Fcu5ez2fS6eR/FHlwnXR/T1CmID0CWB9Vbp0saAuTOQFvBVwDNJZWJSLrEhoFD0S72sKQcSyXLgzOr7cmYgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT2PR01MB10620.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:f5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 02:52:29 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%5]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 02:52:29 +0000
Message-ID: <b683298c-2110-410f-a073-4bfd60d49d02@uwaterloo.ca>
Date: Mon, 10 Feb 2025 21:52:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/4] Add support to do threaded napi busy poll
To: Samiullah Khawaja <skhawaja@google.com>, Joe Damato <jdamato@fastly.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, netdev@vger.kernel.org
References: <20250205001052.2590140-1-skhawaja@google.com>
 <Z6LYjHJxx0pI45WU@LQ3V64L9R2> <Z6UnSe1CGdeNSv2q@LQ3V64L9R2>
 <CAAywjhQAb+ExOuPo33ahT68592M4FDNuWx0ieVqevBfNR-Q5TQ@mail.gmail.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <CAAywjhQAb+ExOuPo33ahT68592M4FDNuWx0ieVqevBfNR-Q5TQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::13) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT2PR01MB10620:EE_
X-MS-Office365-Filtering-Correlation-Id: 894f0340-a79b-42b6-e8a7-08dd4a471fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlMrckl4UWxvc1JKTGV5N2hFZ1lxRWZ5YlRiTGYwK2pTR2E1Z1NSVWo4Yy8v?=
 =?utf-8?B?c01YaWRxdHdKVmwwSWxVWUU1SHNiaGRPMDhFQXdSS0laVTZleEFXSm5IenBQ?=
 =?utf-8?B?U0Z3cFdiMjdSK3cyQkJCVXRIQ1BTaWg0Y3ZjNWRuK1VnYmhoc0cvbWs1c24x?=
 =?utf-8?B?aXJlbU1RdW10VnZLdXNHTUFzVHRtRk1QSkRFTDUrL2dvK1R6cWJGTjF5cXFZ?=
 =?utf-8?B?QWloUjNYZXNKRkVTdUVkUDkyK0IwUVA5TGQ4WWdUMFM0UzlHUHVkWGFjUmp3?=
 =?utf-8?B?eUdORHZtdUhoTFA0Q1RlcS93WVNTOFNXZ01adWV5VmdHdWtYbUN3UGFuOWRq?=
 =?utf-8?B?UTd5NUJsdno1cTAwN29acTZDT0R1S25ieXVOdXA1ZmpEeEl4WjBLWGpPWTJV?=
 =?utf-8?B?L2lkbkVuQ25adDlxQ0E5V1hqWlJXdENWNkV5Yk9CTzZ4RktnYk8yUDJId2Zj?=
 =?utf-8?B?NlpwTGVLcXl6c2Y3RzJOb1c5aXJsa0VYbTg1Q1ZqVTM4Q3I5U3FPaTZ6SUpN?=
 =?utf-8?B?dGZQUm5nL1hvS0VYNEFSbVU0L1Z0d212MGNqVCtpRzRQeS9MVE1CbkU2Szk4?=
 =?utf-8?B?Q3VJZStJa1pnZndnbHlGT2Q0b2U2bWlFOTdVWUZwQVNTSmI3UmQ1UWpKRXJq?=
 =?utf-8?B?NTZia0ZEMlVRSVRZTVhyREFETDVUOTY0MUVyUEpCOUU3N1FRODQvUjd3TG1r?=
 =?utf-8?B?R1JHOEV6eDNRSnBIcG1rLzFuWUdZa21CekZhV2I1VmR3OThZZ0UwRWVVS1Zv?=
 =?utf-8?B?eFhkUUc0NVcxb0NBVE00T2FFek9yOWlqdjVoRGF0eXg5ektXM253Mk0vdk9x?=
 =?utf-8?B?eUNUbm9LUzN0ODY2eGpIKzNZS1hMSjFBVjFKWnhDcVBVdy9hZzl0V2svN0N5?=
 =?utf-8?B?OFpVbDU4WEhWc2tiOG4zckFLeFFmdkR4QWVRckJPa1pHUTFtZXZIcVZIVGlK?=
 =?utf-8?B?YldJTXFFRTg2MDF3QnNpaFUzZGVYNXpuckJyVU9zNmxETU9vREpKTXY1UGk4?=
 =?utf-8?B?N3JjZlR2T25LaTVmSGVmR3pmTlg2MGlqU1laYmxXVUlXV09CNVpTc2dKaENp?=
 =?utf-8?B?Wk5PTFdsOTA0b2ZWK2lLM2thOUJ1dWgyREQ3OUZtOVY3eldWcG5ia2NqYmpw?=
 =?utf-8?B?cHJ5M1k0QkJDZWRjb3h3MFh6ZWZXakRlL3FUYkgyYlBCOWg4Qkt2dnBteVps?=
 =?utf-8?B?SVBGRThNU0hUZTMzNDFYai84L055WHVRR1c1MVRyQkJ3b0FNT3p6RFAxWmxr?=
 =?utf-8?B?OU82N3V0VC9ZbEQ1Uks4MXpzUzVHK0U4Y3ovTjNBbTFvZWthVmsvSnpicnFr?=
 =?utf-8?B?UGp4Nk93WGhKZkRiTVZLcTdEL2x3cC9HbE40bDRlYWhLYi9CT2VQSmVKY2Rp?=
 =?utf-8?B?b2hlV2VpN3l6c2NMOGxackVicWV1TUc0NXVOa2x4bjYvYk9qL3c2TnFEcnV6?=
 =?utf-8?B?VEJEdGY3QkJYZEZkcStYK3hCaHZybmNzY1ZBcjV5LzZvZVZsaU1Qbmk3SHhZ?=
 =?utf-8?B?SHNROHNCbXRTb080cE9SbHNhbjdCSUxHQ09yNlQ0QitPMDlMVVpCMjlnVmZP?=
 =?utf-8?B?VTBqV1VJeVNtSk52ckhGSnVaaTJpQzlCMXplNlBTaUxHWGwzQXlzSjFaMHht?=
 =?utf-8?B?aFIzNjFGeEVEZ1dreUF3bkovRnFhTmU4akZoRUN0YkJ0UVFzWTF4cHVUejRW?=
 =?utf-8?B?bUhXdjk1a3BUVVh0cW82eFJjbk4veFNidmxRM0pZeGNSdGg2ODFuSG5ZOGFZ?=
 =?utf-8?B?eWp6dHZ2SU80WGZ6b1Vyak8rK1IxY2UyeDZXM3RNNmlOWDdJMld6VVpoWjJP?=
 =?utf-8?B?aTU5K01ZV3ZBVTY3ckVwc3lFS1cxUE56Y3JYUXNIZUxRVkQ3RHZ1RlpkblBQ?=
 =?utf-8?Q?4ZoS42S6wK8YX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0dnVXVYSFYyVWNveE1RQU1xTWxTR1FYOW1COE9hVDFScFFVbENoMDhqMERh?=
 =?utf-8?B?NVovVWUzUVBuUklxK0FxMytYOUZMTW0yVExSQ3lvT1BrUHhmYnNYOVp1RHU0?=
 =?utf-8?B?dEZkcW54dnB6cEg1VklUaTRPa01LeUJ2SmFyN3BiRHdVQnhZNklkaWRBTk10?=
 =?utf-8?B?WlhReUxsZzVab2w3bktNVEMzTkoyYWtmY0ZHMUJOQWdDNVQrY2N0a1h5LzFU?=
 =?utf-8?B?UVhvdEJyaWdxcmY3RjhKdCtYSkJSb3hOMDlMczMrUm14R3MvcTZUUWovQzJJ?=
 =?utf-8?B?VEFUc2czZkNuYmFCWGc5ejh1cjhIWTE1cTh5R2k3VkpMUzZPSEt6SEJaUVMx?=
 =?utf-8?B?YlFrL1BzV3h2M0hzbENBQ3F3dFp1MHNVdXQwMjBvc1FIUitzUjZwWFJMS3l0?=
 =?utf-8?B?U0F1dTJGS1pXNU1NNi94WG0zK3BxWXZNUDNCb0hSSVJEQTN2VHE1cWNLbXBt?=
 =?utf-8?B?dk5QNkJRY01CY3o4VDBYM3JUYW5kYVZvaG45MFVuVjVORGJKOTRrd29wNkxL?=
 =?utf-8?B?WC9hNnZzUENVYXJLZ2haY21FZklOTWdWY2dkdnhTRHhVUXYrTFhHdkNXMXpq?=
 =?utf-8?B?YXU0UzV0anVpdlhxSlU2MTlKQm8zNXhwZ2VHUHdSQVFKL1pNTWkwQU5jOEZ5?=
 =?utf-8?B?dkl3aEV0TksvN1RTaGhSRFI1MkZqQm9CUHRYeSs0ZTIzQzlmdTNEOTVralJX?=
 =?utf-8?B?WTdYZGZRcE9QRTRqUzZiTHM3d0M0Wm4yQ2tvSGcxMHVhNXM3T2IvTEZNcG1T?=
 =?utf-8?B?MXMrWXdVSzZaNTlzUmVkd3BFWWJ1QkpPeFJrdjU2UitreXZtQTFRR2RicHB1?=
 =?utf-8?B?L0tGTzhDUGxyaTV0V09IWDEvdlNqa3A3VXJ3WWlOYlhJVjByQURJUXFFTXlL?=
 =?utf-8?B?ZnZPOFhibklXNGQ4UUZiZ0FSdDI2bmMxWTdKZTI4U3FCbHZEMTlra2VRbzky?=
 =?utf-8?B?dFNGd3h4TTZya3BYZGYrV2VnMmNCWmpkL2p4WFU1UXZDUWpuWUVuc1BVQ2Qr?=
 =?utf-8?B?QzY5Q2dnK09ScHc4dmJFbUtwdEJEQVRPSHp4bndxM1ovQTFPZGpnV0F5RTcw?=
 =?utf-8?B?aVdiOTF5R2wxSVluTGwzbzFzUW9rSjYyUjU1SkVnVmMrT1RqVngyaDJCd0Zu?=
 =?utf-8?B?M0J5eVNwWHVzK3NOb2tHMUk5RFpxeHBJdlYvbTA2OVl6dndZdStUNTUzT0c5?=
 =?utf-8?B?WDJkQUczN0lUUHUzRUJqYnlJdjlCYUJNcEpPNXU3c0R1eUZrZ0xWM3lLL0VL?=
 =?utf-8?B?cWlFMkFKdnhpZUYrK3dHVC9QUmk3eGluRis0OSt0Tk12OUNINnJvK2NuUFB5?=
 =?utf-8?B?MkxMNCsxc2pZMThJZFBHMS9qSlQ1dUJscTY2b0dYRlc2eTA1aHBYQ3VDN0Ns?=
 =?utf-8?B?cmt0QitPZlJYMGZ0dkJzTVF1MUNldk0xaFRpa3pBZGZRNmZOd01zYkc3dnA4?=
 =?utf-8?B?T3Q1cWI3WTZoMit1eDVOU01KVVNlQ2Q0MDJEWFNwK1dhZFdoSTV0dzUrL2Q5?=
 =?utf-8?B?cEZsd05jV3VJaExNVEhsQkNZK1dNd2JnUlZsMHY1TitCUHVvTXNvVU5yL3pw?=
 =?utf-8?B?cUJzUWdXM0ZOdnFGdHlDejMrSGNmN1JPdWRlSlAzVWlqSktPS3MwS2FNRnZI?=
 =?utf-8?B?eHBOaEVKVzg1WTdTeVZrWkhOMGNWMXVldENDM1RZNW5pSjR3ZTErUHRpUVVy?=
 =?utf-8?B?RUlSOFdCakc2L3ZhdjBmbCtMaStJUEM5NjV5aXh4YjROYWlhVjZMZ011eWlJ?=
 =?utf-8?B?ZlpMME9URkVoUHJucFZVQmpSbGNYbkxydnphczNMWkFjL1JuYWVHNjJyeFE5?=
 =?utf-8?B?d1Z5N3pKQ1pUOUFyc2c0d3UwMU1yUEFZNUo0U29KaUZzRDNaMjM3YWpDdXdv?=
 =?utf-8?B?c0lqWnQ4V2Y3QnZZd29kQjdpMWMzR09xQ1hBbFRPV1pLbExFSi8wdndBQTZG?=
 =?utf-8?B?NkNZdCtXNk1zV0lGYzk3WXBFNTFXbFVDQ0w5QzZaajg4T0VHQVlXVlZBQWVK?=
 =?utf-8?B?bEpzQ2pCckNzZzliMktITzJSdVVZTERtTEZ4ZUNWUnNQaEVONGMzVk1Dek9y?=
 =?utf-8?B?alpReGNNaHpsYy9OYUpoT0puTFN6cmt4eHNTVHU5b2pjOCthVTl6KzJJTXlC?=
 =?utf-8?Q?OKeN32enzc/uCkFa7xgM2Vclr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z7jXokmKrUPV/RiAaQpno1HK5+3qROKDz45ib/wGt0UdI9B022vWwym2cDVDeUyHnhJ4MecEicCvW8YA1gyJOowxS0EJrbJobuApBuHbPuNUr8VAS4ViwSO1/6SWDQa1//J6vesiHkoltW4C/2+yzao8REACi/nPvHCJiZSNdtZ+xhuOzuzQBJhgpT7Ax1GeC11iShPZpUkB5wECtNRcCLkK2f55KBK51bIBjse1qtFm8Tg+AooUaI8cHmQ/PWFzVkDDyBZRqnueRNtFel6T5C/JX5nH58XtHoVWlHHA6jdtgZAyXnAiqRp3rKXN4DMl3j8laRsDb84VUz4cKPcJXwNAMfZUBW0tBxqt95nhMOtZgCOn2OoD7ovZ/LFVbWnC3rgngV/LiKw2RfeNUui0b0vqxJEu3bHJsUHSgeu5DWAUT7m2lGunMIc/23+XaCGdtyF7MqnaRXw9jQkk1cFZ6KGD9yYd638/1PEps6pzVs732Py9Jmp1pR1jS+wobHHSH1fVgGhOp3A1Wyr8oiSXNYPIjBbBp0voZFXVfGrJtpfmq5yIKJRcNxv64QbYrDtxotfkSP1bfCcN2v13cgECceZJpWVQFXgsZwRUKaOBpys9V824H27gb9F6PtapJo08
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 894f0340-a79b-42b6-e8a7-08dd4a471fe3
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 02:52:29.5758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGx1i1xyUp5zEKp0JE8g/h+e/gtwJEr6SPuKfI3quCAdQq5rmwJdnhyzr2O8GB7Ayuy6oO32DHtkv+u1KqvT+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10620

On 2025-02-06 17:06, Samiullah Khawaja wrote:
> On Thu, Feb 6, 2025 at 1:19 PM Joe Damato <jdamato@fastly.com> wrote:
>>
>> On Tue, Feb 04, 2025 at 07:18:36PM -0800, Joe Damato wrote:
>>> On Wed, Feb 05, 2025 at 12:10:48AM +0000, Samiullah Khawaja wrote:
>>>> Extend the already existing support of threaded napi poll to do continuous
>>>> busy polling.
>>>
>>> [...]
>>>
>>> Overall, +1 to everything Martin said in his response. I think I'd
>>> like to try to reproduce this myself to better understand the stated
>>> numbers below.
>>>
>>> IMHO: the cover letter needs more details.
>>>
>>>>
>>>> Setup:
>>>>
>>>> - Running on Google C3 VMs with idpf driver with following configurations.
>>>> - IRQ affinity and coalascing is common for both experiments.
>>>
>>> As Martin suggested, a lot more detail here would be helpful.
>>
>> Just to give you a sense of the questions I ran into while trying to
>> reproduce this just now:
>>
>> - What is the base SHA? You should use --base when using git
>>    format-patch. I assumed the latest net-next SHA and applied the
>>    patches to that.
> Yes that is true. I will use --base when I do it next. Thanks for the
> suggestion.

Sorry for replying to an older message. In trying to reproduce your 
setup it seems that onload from the github repo does not compile since 
the update to the kernel build system in kernel commit 13b2548. I am not 
that familiar with the details of either build system, so have filed an 
issue with onload. I was just wondering whether you had a workaround and 
could share it please?

Thanks,
Martin


