Return-Path: <netdev+bounces-178706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FCBA7857E
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 02:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8513C1892D0C
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 00:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EB3802;
	Wed,  2 Apr 2025 00:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="OqdsO7vo";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="OqdsO7vo"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021089.outbound.protection.outlook.com [40.107.130.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B8E1DFF0;
	Wed,  2 Apr 2025 00:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.89
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743552896; cv=fail; b=sOMlDOVDMUPELYIojeQDm69aFgAmpS8r/2UWJAFnjsoXPDfP1zPcKm/IvWkcpZCHxPXLly9c+5MW+qqicYUl83zZlMO9Mq6oK9XVmDVjgypNeFnYS2zG7Y3/3/VOLxGcDlBWKUxXIRzHEWbhZ/YXQZW5vGIhLiBtuE5KTQR5AYQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743552896; c=relaxed/simple;
	bh=uvqAhcYYDoKWo1DGzqv5iDWIE9DIE/kbOQNrELsZlHk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MVBdLZZS7Wrw484FK+HP6YFWFdrHHrbArTRQ4LTzaL8n9g+Ya4GYT6N3qv3xmQhYCl/muQO/1e3LbVsZXlI9lbsZmmmCGBv73FlJuzAHD7IvobUM5yjQ0P2RKmr94Y9T84VuA7X+8gQvhlvhcPn6O4VTut78herGdRZEe4BngoY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=OqdsO7vo; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=OqdsO7vo; arc=fail smtp.client-ip=40.107.130.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=oXXaetSTy1VaQTStd8+iLk7FcSv7io8Fp17FhGmc5TzBSybRx4X21eDHx5+9CC3GunvjCpSFnx3Way2L2uivivMmO/2i+nXKV3QtyUiYUxBjvMYYfawP9KTogXI0Lyuh29+tepGiebmc20v9HwQ6kXa+qbo14k4TFOqd2XLjzlQuagwtYTQ09NhwyUuyoLCXuBZer8mO5HnVDgntRJYUnnL6Oo5Ma0o1TkdUP2ZCMn7zs2dj+C+ZLM49kdvK1Hp76cJ47iUUJRKBO6eDVzU7CzQ7T2VF8kb59/nelChJhkgM84Tj3bYJ2rC5PyqLg3ksxGr0MNpglgwn75D+rpmXEg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvqAhcYYDoKWo1DGzqv5iDWIE9DIE/kbOQNrELsZlHk=;
 b=qe9jBXPsDA8VB8Lf54xagZLmAWlvrQtT4MFb8NYIMhz9VyzIhn2r5VYGJZHv8ZRIrJxLg0DG66qbTZKxghSA0Rv0XV4qjufpLdGRQ+mCPWGtcdeSj7PvJDQNFuYsUsrPSZAxBN7IlydMW2tKjx3GDqBpRclK7l7JJIdEjOXJKPXLY156vv1+Kh0gySC+mmzYEyyaSL34LB63S/WW6oA54eq2+7zdzKhJfcVNWkGbKZvblh5WE6/UFzf0OLHbBWNNx8dFo2hr6NvkCfQRzxfiUyOyjYb7tTRcWaIQ5VdwDezt49LRBiye2OwgPkZJR/nuCuWtOS9xNjdfqx0BpAJpwA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.85) smtp.rcpttodomain=airoha.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvqAhcYYDoKWo1DGzqv5iDWIE9DIE/kbOQNrELsZlHk=;
 b=OqdsO7voftexkR2WjH1TKxTalNRiAGVSWbSxrGrupQYAb0xisRf2kiRrCdSxyxZ0sjDE5AynVrebfJvNu4y1vn4DnICuKv9sVRBAODkuEnc5htLj9tQldG7lLvk47PnXTwRm/IG/CYKRKmrTgOuqPWfHtRRpGMajwqg//G2nLxaHpJx2s70XLFJ9nN+u6uxraRP1ZAGCSYnkLo3e0RqCy2jXS/uPGkBA3O4XBPLwFW+SwhId1uUu8/pSuDM5NCPBbC1ZMzvCdLRTcoNizV3ENxkLIQJ5NBAsX0qNqolWXse69UjlPJ1IIiBRjDf+9K4YxpjAb8Mdl1iHKjv/fwTH8Q==
Received: from AM0PR08CA0027.eurprd08.prod.outlook.com (2603:10a6:208:d2::40)
 by PA4PR03MB7279.eurprd03.prod.outlook.com (2603:10a6:102:109::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 00:14:48 +0000
Received: from AM1PEPF000252DD.eurprd07.prod.outlook.com
 (2603:10a6:208:d2:cafe::8f) by AM0PR08CA0027.outlook.office365.com
 (2603:10a6:208:d2::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Wed,
 2 Apr 2025 00:14:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.85)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.85; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.85) by
 AM1PEPF000252DD.mail.protection.outlook.com (10.167.16.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22
 via Frontend Transport; Wed, 2 Apr 2025 00:14:46 +0000
Received: from outmta (unknown [192.168.82.134])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 846B320080F88;
	Wed,  2 Apr 2025 00:14:46 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (unknown [40.93.64.8])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id D9F2F2008006E;
	Wed,  2 Apr 2025 00:14:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODGwDzXzPYexsLNl78XgLMGyTLU7q67yYs6Lwiad+dhEKRjZIIwFL5gUC3kSb+0+8RpR/aK6wXC8sSSE8d1sB7sm2ZdkC9WK2TKiop0oof9wo5tU8QmvK4nsRWbhHWQgTOyQ6J+6SrGsyGp01EtqpL25sFNjr14x1Q+5HUKpQ1L76ZAOUKbu814zL+j/Ks5S9SsBboHJzXoijMnbvuxRco8SoabELuLgR/g9ce3cbWAzMtjm5IoL332oks5scPLMkko5prsvw5MeTKp18lipKstf+jzkaRgpwEjb4eLlk17IIdGU4NI+oCUXfsqfSl6O8yIv3oSCbH7pkCChLLNA/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvqAhcYYDoKWo1DGzqv5iDWIE9DIE/kbOQNrELsZlHk=;
 b=TPeu5QDSYpkq9HVyVm7P5D4Nop+RZJeecw6NWJCz2wzlE75cpkghM1ex1haZ5i8WTvUcrMN08MeUnYDCROWv0nb1SjUhcSQzKZi0Hl7WJD4iHvtb5nEGqhzhLT3XBqwnp7yvxkgkOcbLe2On1Bt4e/wm/wqXP4IRH7+JgdS5Rfyte09Kj+KU4mZcJNVw2l8zQxzAC4qg2v9kNLbVHpfeKVXHr9yfo4FtofPId8YnTVCyszLsabWu82tgththEo58wy6UXbx/gF0fKLrSDXccqPL78d38NtebjoSGYKuqAToAujO14ldAeW5PKz2iQao2ySNy5OCBL3yOj113Cs90kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvqAhcYYDoKWo1DGzqv5iDWIE9DIE/kbOQNrELsZlHk=;
 b=OqdsO7voftexkR2WjH1TKxTalNRiAGVSWbSxrGrupQYAb0xisRf2kiRrCdSxyxZ0sjDE5AynVrebfJvNu4y1vn4DnICuKv9sVRBAODkuEnc5htLj9tQldG7lLvk47PnXTwRm/IG/CYKRKmrTgOuqPWfHtRRpGMajwqg//G2nLxaHpJx2s70XLFJ9nN+u6uxraRP1ZAGCSYnkLo3e0RqCy2jXS/uPGkBA3O4XBPLwFW+SwhId1uUu8/pSuDM5NCPBbC1ZMzvCdLRTcoNizV3ENxkLIQJ5NBAsX0qNqolWXse69UjlPJ1IIiBRjDf+9K4YxpjAb8Mdl1iHKjv/fwTH8Q==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by AM9PR03MB7559.eurprd03.prod.outlook.com (2603:10a6:20b:416::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 00:14:41 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%3]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 00:14:41 +0000
Message-ID: <ac525337-7d5d-4899-8c9a-90b831545d88@seco.com>
Date: Tue, 1 Apr 2025 20:14:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 0/6] net: pcs: Introduce support for PCS OF
To: Christian Marangi <ansuelsmth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Philipp Zabel
 <p.zabel@pengutronix.de>, Daniel Golle <daniel@makrotopia.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, upstream@airoha.com
References: <20250318235850.6411-1-ansuelsmth@gmail.com>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20250318235850.6411-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0006.namprd17.prod.outlook.com
 (2603:10b6:610:53::16) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR03MB9020:EE_|AM9PR03MB7559:EE_|AM1PEPF000252DD:EE_|PA4PR03MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c72182e-1330-4930-3ac6-08dd717b606c
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?THl4TUZLZ3N0SHZSM0pYVjg0SVVXMnNFQ0ZlT2luVy9oN25hQTVzYllxUmlO?=
 =?utf-8?B?QkxEaVF6cUgrcVNLQVlyZFV4Wnk3NGZOSUh0NUUzYjV3WVJEcitqQm1FeW9W?=
 =?utf-8?B?VENhZGxuclFQV0VqWmtySnV0cXluOHQ3cHZTMk1RK2x4dXRWOVZEMkYyQ2I0?=
 =?utf-8?B?ZkIrdnpkKzBBZ0JlNkxDRy93OFdzMmhUMDhmOTRFSkREM3I5NTFnRGdHbXlZ?=
 =?utf-8?B?akdqWkFMS2NNNlMzNnpUcFZKYXNDM09aWCtWL3V6T1JaZHVwSFN5TC95U0hO?=
 =?utf-8?B?cVM4VmpxZTJLQk1nenZoaGVSVnV4d1NDVmtqTEdNd0RYMlZEYThGWWNyTGNo?=
 =?utf-8?B?Tlc2OUl4NGlvZk1jVGhGMFZJNHdkNURpcUliWmJxbkY1MTlCYmdxNmlWbnQ4?=
 =?utf-8?B?VXNFYVR4dGRtNU5yZ1p1dHBvTkdPOWg2RUZvZm1aM2d5M256QUhoOHpTQUFj?=
 =?utf-8?B?SmtUMXNUVk9TUVAvek5ySGtRUFZnQnVENlFyd29QMDRzbWI2VkN4ZU9TSGZj?=
 =?utf-8?B?UXYwN0c0SUY1TUJLK1ZnblVTV25vQ0dIS2VVNzBTRHNkWFRTMEcvdEFRb09u?=
 =?utf-8?B?OGVpamZHZFF5MUFuc285RDM3by9OSGx0Z2hOa3hBSnJWWTVkbkVmQUJXeXNv?=
 =?utf-8?B?V29wYitnZ1JlMjYyYURiL1Zhd3UyOVNGZjQ1OEc0QUpOdG1tRlg3YXpFLzQy?=
 =?utf-8?B?SU5uR21ESlZ4czlMckxvRjF2eG5vMlkzT01YVXAwQ2xBUGJ3aWtXS3lFNGRL?=
 =?utf-8?B?anhaUWxRcy9CckpHeHQzd05CTkc5bkFXbTRjOVlNcTAzUDZjTVZYZWkzdk9w?=
 =?utf-8?B?QVV1eVBrS2w4RnV0QjRBbEJXREhsZG1UdU0wK0U4MElUeUdabk4zcy9jZDd0?=
 =?utf-8?B?cUVwN1pRUDZwaTBYUnpheTdHMm1sbjFnYVUrVFdnNnppSTIvT3dqSmRYN3My?=
 =?utf-8?B?R2o0cjhyQkdkcXBScmFtVVFhbndzWGpyUERkdGVHVVNCSnJhUENIK2tPVjd4?=
 =?utf-8?B?dy9mbVVGY2d1SUljc0w3RzBPVXFBcm9OMHRLQlRrUW84ekJDZ05SRmoyYW5h?=
 =?utf-8?B?VHlUTHFxZkNVYmh5ekRlcFkxL2UwZk51WmVISU9Va3BxSzMvMEJ2VkN4Ni95?=
 =?utf-8?B?THB3YXFTcmJjS2ZEQ3hXcEZoSktzV2VSc0hQTEVldkF5dEpGYUtWVDZISGZY?=
 =?utf-8?B?TFB5LzhnMUVhVnFGMUNET2N1aG9KM2pJMklsUEtDSk5hM3hrQmJzbzZVUkt0?=
 =?utf-8?B?alJmQjM5YVR2V2k4WVZzOW1NRzE3dnIxcGVpdVVuV0RSeTdrVUUvVU52UHll?=
 =?utf-8?B?WktGQVBHU1FZNUpGMk5TQjRoSDUvOTB0djRLKzJNMUpsL3kxUklxZGpHQVBW?=
 =?utf-8?B?c1ArWWRSS0c2dTRLTGJ1bEJZMGVwU1hTRlFnSFRRTkZjNlY4TjFGVExEYkJ1?=
 =?utf-8?B?ekFqNmEwZ0NIMkVCWkpsTlRlSm1TSnZUZFVrTmcrd1hVQkI0ai9PRnhtVWRX?=
 =?utf-8?B?UU9XMlJha0VzVGNMMzBINjROOVQ5YjI2dWRtRGpHMWdVc2lkWVduOEJkMkpi?=
 =?utf-8?B?RldOeklDbFFoYWc1SU82ZndIM2RJVjN6NlgyWGRpOFJyTkdTbjdlK1JkRnVZ?=
 =?utf-8?B?TllFNklLSzd2aUt3NkpDdWdaUHozRjJhdjJwZEJ0bW9ZUVJERDlLQ3hrY01C?=
 =?utf-8?B?cXUza09peGxBR01LZ3Y0VmtmcGF4bHNvN2hobVFkVWZQQVdXbGt6YmJ4UTBT?=
 =?utf-8?B?cXhrMUE0NUF5ZTZQQ0JLL01NYWkyT0FDU1pDTFZUcWdWMjZ1a08rTzdJZjZR?=
 =?utf-8?B?SjVMRDNpTU9sUVJiL3lVYzhQSFNzSW1ZTHlJYXlORCtsdjhqSVNic3Fid3hp?=
 =?utf-8?B?UVlzMlh4dDJva2hmT2FJTjVwYWNNMUhCN3pLVlh4dnJ3UXVuT1dJa3MwTVNV?=
 =?utf-8?Q?b4HL5CezVv8=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB9020.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7559
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252DD.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	cf99cc8c-8746-46ac-ae41-08dd717b5cf6
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|35042699022|14060799003|1800799024|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXZwaklHZlZGVTRVZ1ZkaUt6UGlXcG1DMnBrblY1S2xxT050bFRkc1JlaFB6?=
 =?utf-8?B?S3VqYS9veU84VUtWNkVsNlpXQm9GNm9NM01ndzI4SnBrMEtBNWhBeUlCY1Y0?=
 =?utf-8?B?UU1Ld0wzWVpuQjNmdUgwOUJGV1M2WTIrMENvYzFmRWI1RnNSWE9lVUZTWHQz?=
 =?utf-8?B?bTllbGlGb1EyR2h6a0xtYmxjQzJSM1lnaEhWV1BZZjdmYzlveUZ1cldPU1lN?=
 =?utf-8?B?RmlLL2VLZ0Z3N1ZBMUpxQWV0NXUwZWxuL1ZoT0x5eit1Q1JuVjljVndhWnVW?=
 =?utf-8?B?cThMbDhjU1FKU2tpMjJvNVpMK0tUc0p5RHowSHluSmFrbHZBNkJCK1Awa0tl?=
 =?utf-8?B?eEx2ejZLN1c1ZzRnVzhlQmxhbVFpbldKMjh0TDluT3crSjUvdk5NRlBJTEZG?=
 =?utf-8?B?dXZZVDFnMXk0NU8vdU90R25ZdU80SWl6VlZqcjVXakNSRWhqaWs4am05dC94?=
 =?utf-8?B?blc2ZnR4b0FrZXFCRGJxS3JGK2o2NDdIc2Y2MG9UK2QxSTFTT0x3WW4wK0Zr?=
 =?utf-8?B?cDN5NzNLTzc2a1MwcGc2Q0VBMHo2TVl5bURUZFlSN084TEphYVdMUUVwRWxs?=
 =?utf-8?B?cDJhNEtxN0FoT3hhOHNvdmRmcDJqWFNwOVV0cDJrdGdiNy9uc2F1bUdDd2Ez?=
 =?utf-8?B?UDZXaDNhODJjVGpid0JkeENrMXYwQjdhQWpFazVJd0dxUWJ3UnA1ckZnZFIv?=
 =?utf-8?B?SmNBTk5nV0ZYSEVncnFUZnB0M3ZBNjMyZE9vbTVOZmxmL3NOWmRvK3NueTJJ?=
 =?utf-8?B?ZFo1Nm4rNFEwN2lPbkZqYm5JSGpzYjM1WGQ5RFdHdjJzMU1jbk0zOUpSMjBR?=
 =?utf-8?B?YllKSjM3QnN5N2ljS1pwMmE0MWdyajFsMGpOTlh2WG9oMGVUa2NUNlo4dGJx?=
 =?utf-8?B?WGM5M3VLOFN1R0dKWkI1Z084LzdHMGFwMGZPaDFUdFViY3FHM2s0N3VQcU1S?=
 =?utf-8?B?bVkrNnNPdVJtRDBoS3JkdFlhYThHekFnd1hQbGM5bHhWekxFd2hJR0pTbWYz?=
 =?utf-8?B?UTBTSFJuUVl4OGVvamhQai9FL002NlUzaFRxejJXUE1rV0k5YmJNK0U5bWFu?=
 =?utf-8?B?VW9hVm9Dbm5VcldZdEFQQ1JiT1JOZGw3Y2kwQy9PRlVIL3dSaWxwRWc5Qzk5?=
 =?utf-8?B?a3UyTUJJTDFEOVRiR2V4ellDcTlzT3hHa2J6bjNNQVFyOENkRTUyTVV1cWxN?=
 =?utf-8?B?Qzg1ejVLak1xSEpEcEdjcDdaR3lrcExiRG44WVloMFBGYjJxY1hWQ01saVN6?=
 =?utf-8?B?M1c2Y3d0dHZYTWRBa3g3TENrUUF1L3ZySTh6cXJBY2NIeW9CNFhNRDY3eFBL?=
 =?utf-8?B?TDk1aU9CMUZtUlY3d2lRMTFVVFB6eEtEZ3JCY2lpaElsU3BGNnU3U1dncTFK?=
 =?utf-8?B?L1BIS1ZmYnRhT2w5YUxhcTA2Uk41cnFTUG5EVU1iaEppSFRPWnFJNFpXMGxt?=
 =?utf-8?B?bzI0ZStaRnFhdFFtTXhybjBGVGNibnZrZHBqdTdsK0J5RDV3eXlKMVBKUEp0?=
 =?utf-8?B?N3NRb1ppOGpkUWFZYnRsdTQxSXRJQ0NnMjFjRVExVjBFNlkrbFdOb1VSSUVz?=
 =?utf-8?B?TElwSUx0ekNwOTNDYlFsUE53WEtaOXpHblBrZFJXemswMXNlTnJ6TFQ0NUIv?=
 =?utf-8?B?ZSs2eDRnczM2MlJQYjd0aGZYU2hkU1BpVEZiR09yR2trK1ZxTG9kYWhlNmpr?=
 =?utf-8?B?dVZtREJ5SW5JK1dCRmVIaCtyT2lobmRLcFhWblVBdXRUYmJOTGVXQ3BWdFFl?=
 =?utf-8?B?YlhYS295NnZtL01ZUUxyZmNOZW9xbTZnV21jSmJ5UW5SOHV4MHRkUE9MZ3Vl?=
 =?utf-8?B?aTZaMkpaYktDM0NDTDlSYmVnMlFKem8xdFY1c1pCODRjdlAvUVhDcE4rZE9Q?=
 =?utf-8?B?ak9VS1FYQTRSL1RYOHd0a1dVdjZQM3VaNFc2WWxoY2pKamdJNmJzVzlFZ2Q0?=
 =?utf-8?B?cFIyVFNzK28yYXJ3NUVWSkVzbXFHbUpLbk5SSGdRRmxnRXNCWm53WjQ2clNH?=
 =?utf-8?B?UmJTMi9UZmNCNEJFTTRJanFGdCtsdlQ5YTFqQTJrSWdDNDYrTXlNZTR3SEJL?=
 =?utf-8?Q?NKAuk4?=
X-Forefront-Antispam-Report:
	CIP:20.160.56.85;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230040)(36860700013)(35042699022)(14060799003)(1800799024)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 00:14:46.8631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c72182e-1330-4930-3ac6-08dd717b606c
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.85];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DD.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7279

Hi Christian,

On 3/18/25 19:58, Christian Marangi wrote:
> This series introduce a most awaited feature that is correctly
> provide PCS with OF without having to use specific export symbol.

I've actually been working on the same problem on and off over the past
several years [1,2]. I saw your patch series and it inspired me to clean
it up a bit [3]. The merge window is closed, so I can't post it (and I
still need to test the lynx conversion a bit more), but please feel free
to have a look.

--Sean

[1] https://lore.kernel.org/netdev/20211004191527.1610759-1-sean.anderson@seco.com/
[2] https://lore.kernel.org/netdev/20221103210650.2325784-1-sean.anderson@seco.com/
[3] https://github.com/sean-anderson-seco/linux/tree/pcs

