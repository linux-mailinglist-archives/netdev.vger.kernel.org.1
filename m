Return-Path: <netdev+bounces-235488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A520C31628
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 15:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0A1C4EC6E4
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 14:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A96232B9A7;
	Tue,  4 Nov 2025 14:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xi873wuU"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013054.outbound.protection.outlook.com [40.107.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8038D32C949;
	Tue,  4 Nov 2025 14:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265114; cv=fail; b=U5dwz7ixZ834AZDxCEamUtsMCGVeiwLXHVAH8Mubp9n30YKxRaxRfv5Kj/JWOpJUNsrlBlt5tWZnRe0qUGvXBJX2jdBLUtl2cu5XgMdTFa8Z7k5459cuI3aCsyhdRLuUf6V1Mo6jdkLwHiOD0X++5Y2Ci1KsYlH6esdbK69mj3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265114; c=relaxed/simple;
	bh=a32vJoGObDF8wfpltt+HdbmMVgLs/ZSSJ9OztUxRkuc=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=hKNMrhgDsGERILeHY1Uo8VuIWexvUXnRbqint8m1+ZPCqiJ0+s4j/2KxGkdWNYHmq6CDXCptxHCW1+59TfaW1Ssv6U59OyQhFnE8tTwBvifIbsYoZybr3EnFOqqC2dy5ATWOpI/eeCrZPwrCONYC7Kk92uDpQ5RbSXIiscYFpas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xi873wuU; arc=fail smtp.client-ip=40.107.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xsr9ndEUoKsxwlezDJPBQyzR29LSf3Ywa6Z3i6ybNNaQhQb20eCcj6/eY6fsk9h8zaafzvoAj1KEG4pwGQpoGGF+qioHSOfy34ZOm0pfPcP2uXx2Skp/3CL2UqOmKlSi6uquoFsluyg4PmOBKvNEZBLCtFx9GMklVCd5wc6Mlj6VpKVHWPJ7OCZdscUeMWQz5jtF7X4o2DAbk2qpX0TVqOo89LEfQPxP2/MJSoDEv4RlXQItv5je7JgXDl72k5ZMuWmMgoepelx0Ros22M7MSICJh7Jd2tAuOKCB98vVjXZJvyqLPxOEV0QZms22xPw7GlpfVPtidqrSSaiFFk1U0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUt+W6etxZ3XN2UCTpLlJlo5Iod+pNvUGfZlGkSoONk=;
 b=wigQJ8+F6zjKVWANbwcmYUXB7bZTt176eOz4x8AjVnywltLa6J6ZunZT10+VtmCfRzBnu1u99T25oxJ58Beue5PC6MS9kk7NImWL+JqFhYnIZnmfsc1zn7FXtTwm3Hj+8KCcpoi9dFiKwU/MP/UGJYlHKkgKM+KoI00Hb48VY2Q00zdqlM9NaOMsll4aapjAJM4WRw6RqDicCYED9ZCkpi7QDaPHW5+J/L+5zapzCVUnu5e1vGOkxMXbXqnFIqX5vmF5kUe27eOro33aUqKIHfSF5kQ77ZtUorgbqXdjSR8KabixTQ4UAgimz5wq+NA42k9Qb+8+pef/7OmyLkJj2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUt+W6etxZ3XN2UCTpLlJlo5Iod+pNvUGfZlGkSoONk=;
 b=Xi873wuUBxg4CyFckWfDb+XcGZWNjdcH698y6jePHHdriBAITYPekULaBVydah9hAH+1xcxzQKRYVDbQ7/ttv3rl+nEATpqDV8NN+RTLE4Q+fkRWbYCFqOIbz3NR39HjBKNeZE+XE2TIOrpsdzFh52F73Ie75xjtmXDNQipJwKDgpxsxFfZVy8pmffC4+2hJ7/F38cRV5FHsqfThEtYjCa7RnoAWtT2GPuZ9AugdQDpztfdr/z73lbqZDQAdoR2yE+t9+ap6Zgd2XTi8/h+JSfD4oBOsjxdvY2pXOIYTIEyFKsyyPspfnBxvo66clw+d7+Kfdnrp2xf/I+r+wnhnug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LV3PR12MB9355.namprd12.prod.outlook.com (2603:10b6:408:216::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 14:05:08 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 14:05:07 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 04 Nov 2025 23:04:49 +0900
Subject: [PATCH] firmware_loader: make RUST_FW_LOADER_ABSTRACTIONS select
 FW_LOADER
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-b4-select-rust-fw-v1-1-afea175dba22@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAICmkC/x3M3QpAQBCG4VvRHJuyWopbkQO7PkwJ7fgruXebw
 +fgfR9SBIFSnTwUcIrKukSYNCE/dcsIlj6a8iwvjMksO8uKGX7ncOjOw8UdnIEtnQcqit0WMMj
 9P5v2fT8Mq2hUYwAAAA==
X-Change-ID: 20251104-b4-select-rust-fw-aeb1e46bcee9
To: Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TY4P286CA0077.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LV3PR12MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 12401274-ca69-46e0-6214-08de1bab28f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c29jaFlJWkJiaVNJcERDaUVndDRjLzNmZm1UalZjajZRS2dBYnNxem1LaHpG?=
 =?utf-8?B?aVdPbi9wU3p1MGRGdzhmT1NpYk1DYUZYbXlmSXZNWjlvNmtKYy9PVExIdkFW?=
 =?utf-8?B?SEUxNXdFUXFRV1VOUmlocllFeWFBNXowME9CbU9McnQyWjQwSUNRV0cxTkNU?=
 =?utf-8?B?N2J2S3V1MDdvUVVCeXplRzZxTHpWSVhOYU9ocGFRaHlUSHVjVXFsN2dHM2Vo?=
 =?utf-8?B?SEl2ZGVMZ3ZyL3JOYzFnNURxbDh5NjJDVTYwMDBTVGxEaXVFWGpTMFRSaEZB?=
 =?utf-8?B?YjZTOGRORC9qZzYxWmpkMHRQMEY0QjZvRVcvMVF4Y29DVTk5NUcyald3NVI1?=
 =?utf-8?B?Y3FVMjJlbDFtWUIxdERXMTRBVTlDZUx6bjBOV0k3TnVyQ3FiWXpHMVlYdmMy?=
 =?utf-8?B?OHNFVGRwZVJyK3ZZaEE1UkwvUTB5ci9PcXNJRGc0TDlJeGhCaW5FU0d5T2FW?=
 =?utf-8?B?aHlFVXFOM054aHFhNFpmWHpoTmtmNVhGRUF0N3YyV0xXZFFCRVByWVFlMEhI?=
 =?utf-8?B?RTNxdlJjVWlMa1p2K29mL0hGL2YrbE5sRmVpVWtpOFdLTk1OR3dPMFUrcVJN?=
 =?utf-8?B?Z2JXSWNQRVhYdkN6UXlkczdMOHpibmx2aDZXTnBnS2tXdEJxeEJsM0VoMmhm?=
 =?utf-8?B?bmMzTXhGbnpMSENJOUMwSHpxUit1R2VtSEhQTVpaUzRVT1g2WU55TFlIbGFI?=
 =?utf-8?B?VkxGcFRHSmh4UkZyb1AwQnhYMjBUejFmQmExTWVMdE1nOXRYRmJzNFBwNS9u?=
 =?utf-8?B?dWRhWmorMGpycVlnUmRIU1VpakpsenBVR1c0SXoxYTROeTF1T2tScXRmLytz?=
 =?utf-8?B?a2NVRjI0Q29ncW9iRHVuRHRnaDgvK3N3ZU1jd2V4V2VRYlNtTFRFQjhWNExI?=
 =?utf-8?B?NGhNY0ZHaXpJcVVHK1p4RnZaV3ZZMVJtV0RZbUNLOURkb0Y2U05XeTZtRE9t?=
 =?utf-8?B?dXFhRUc5b3JCQWxLc0hKenhuQUxwdjNZRTVuZzlqNXB6RDdYcmZoN1YramNs?=
 =?utf-8?B?WGppWnFqWUtLaHVQcEZ5WVBWYmY1QlBTaXExR3dhVlcxRXJCZ3g4RjNzckxw?=
 =?utf-8?B?c3BwbUhVZFJoMFNOQUgyS1VHbDRwOFpzUzN1Z3pwbTVHQnhseWpNeFcxMGs1?=
 =?utf-8?B?WjdMS01ZekNaSk5ZNVh3SWZqMXBsYmprSjZrQ2ExMHI0R010VmpQWDZsekRy?=
 =?utf-8?B?dzExVWJGdUlZRExxcTl5R21rK3Yzb0FaS2FRMFBIM0dtNWpSMGM1em1VRGw1?=
 =?utf-8?B?TVdCZi81OG8rOWNmWEc0UGlSWkdKcWgyeGErT0ZEbkU4QVVlVHFTUks0QUhE?=
 =?utf-8?B?K0pCYy9tS0NNcnpzcnNtclBOcDE5V0x5M2RhZGVPVE5WakhVT1RUdXNXN0Fx?=
 =?utf-8?B?bHhpY1Z0WEMzL0NwQUFPaUNVeWhKc3VET2cwQkNRcWFrd21nQjU5NEZMTStv?=
 =?utf-8?B?L05kcjJpVmQvQlBYSnhpYmpKVUFmK01EeTA3VEdhNW9JUHprRWM2V1pjQnhE?=
 =?utf-8?B?aGpMbVVrSU0xdXJ4eER0UW8ySU44UWJmRDBuWFRFRTFsVjI4VVZIb1E1VUNa?=
 =?utf-8?B?aVpIeXdrbmsySVAyRWxQWFJqbUR2ZHBnWlNXKzlDZHQyZldxMGNJYW1JMXJq?=
 =?utf-8?B?YVpuZ1JQQXF1UWMvSU4vaWE4Rk9ZSnRyV1pJTnd0MXB4Ump6UTRSNFdhNC9B?=
 =?utf-8?B?anZ3cWxFNDFqcVVoazB2U3pBREovcFJRcjN5bUhTczlJQU1TaDVqUm5iQjBN?=
 =?utf-8?B?VEZvb0E4SUtvTXg3OExIUDdhc2JKdmhlWlZLQTZwWWlYREFVVUtpYUZmMnpm?=
 =?utf-8?B?eUh2ZXdHRW5qa28yazdnRVFwYXQvL2kvQzhqUG9pRVBoQi9sQkZiSmprOExz?=
 =?utf-8?B?OGVocTBVZE1Jb0hqNWl2RGVIQXlralEya3ZSWmtzcE5ZenNoVittdzhBMVA5?=
 =?utf-8?B?N0p5aG1HckJSamdnSi9qaE93M2pUUmZyUHV4ZW82eXhSUUxXcDFVWGJxK0Fu?=
 =?utf-8?Q?2WgWLCYAnAZ8a2Sb77JQB42l90Xc/4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2ZBa2tkc2lzSW1KN1FqUzdSQmtZempzV01aVlNkdktJdmZJVHExdDZzbWtR?=
 =?utf-8?B?ODdhU1lobFZvb2NsZXJmbFIwSWZBQWJ0akU2alQrOWlpMExyTGd5cEordzVV?=
 =?utf-8?B?d3JhTGlDdjJrcCtzeTlOTjBLak9rT2wwR0tsQ2RqYk0zNm43ZnhQMVl2WVhq?=
 =?utf-8?B?Y25wdGllL29mSkRnY2YvbVFwM3N4alZrVmt4TXFIZmhZUVZzSlY5M2MzQXNq?=
 =?utf-8?B?cnpEREFjaHZNWTl1WTRiTkZPOUc1YmdocWU3U09nQmJ1d0U3TDVQTGcwb3Ir?=
 =?utf-8?B?eXRPU0tPRjhWcnBoZ3ZsR0tyOW9ac3pONG5RY2h4K3hnMVFwV002SWYyQnpS?=
 =?utf-8?B?M0xkaFBSc0J6Z1VnalphWENqeC9CMDkvMTVKdE9CNUlzMVRQQWhhSmh3Y3Rr?=
 =?utf-8?B?ZHRKV05QQ2pDZlRKL0hFTFhybjRYdlRkQXVhMG10T0FOa2ZUKzFPNW9BdWZM?=
 =?utf-8?B?VFRZTi9RUUhWdG80bno0cFJranlwaHJJajkyZnp3VVluZ0V1ZHR3SHlpdldJ?=
 =?utf-8?B?UW5ZNkw3MEZVSXByZEFNM3k2OHl2WHFtVlRXdlkxTE0raExEb05MdVoxVmR5?=
 =?utf-8?B?dHdOcFU4UGZ4QzhkbFBTWVNxdkNUMTd5RjQ5N25wUXVuOVdjdklVZ011TmJI?=
 =?utf-8?B?NUpUR3RXZXJETytaVWhzY3BFRGplQ20yU3hkQ1VTUGYzODdXNVZDalFpdld4?=
 =?utf-8?B?b0M1VXlJenhZdWxuYWRoc3hjMmtQTERXVGRMZ2ZST3ZWTWdhYzczZ0xqdFp3?=
 =?utf-8?B?aG1SMTcxbzhGZld5MEpQdFZtR08zMmhYOU1hMWgxUW04bE42NlhrNTJRSjNC?=
 =?utf-8?B?RCtoZ2tGZlpGYlByVTcxWktLOExBOHFIY1BzQzd3R3EzVFMydVFEOUtnWHFB?=
 =?utf-8?B?cFpPbFU0MDFsTWRVRlJxODk4L3J0ZVRuQjVtRlh5UjJJMEZLUWNZeTBNM3pD?=
 =?utf-8?B?cUZ3T0dPbUcvNThYSlRVcXVEdVdPL1BMMmw1RzRlbHltMG0yd2RTa3FCOGdp?=
 =?utf-8?B?YnNLbWZLVGVtNStuRENjOXlBZjI1WWxUTnVwSyt4Z04yMUMwaXZSZzZTOG5R?=
 =?utf-8?B?alFDN29LSU9ieDU3cU81YnIrTzQrRG9aejNPbXh5V0c0ekVERlJ3V3lWTzlM?=
 =?utf-8?B?SUxaQ1BjMFBkTmpRK1ZWNjVNMnB1SGJUYWhMbjFqTzR3VVQ0Vk9HRU94YnFL?=
 =?utf-8?B?WnVUTktqUHN6OVIwampmUklRdzc3RDR6dlEraW1EYmN5bGFOQzNsd0NtcHlz?=
 =?utf-8?B?Ry9OSFEvRnp4YXRMMUw0RVQ2cFVFRFpOR2xGRVhKQ29wQ3FaV0c4eFR6SHpK?=
 =?utf-8?B?Q1hIR1Bud2FhNlc2ZUs2OU9iMGtuMDRkVXo5WmsvSmVuSVdTYjdJQnlLRmZs?=
 =?utf-8?B?eXhHQmJQVnNmQnd6WkdCR3o4a0dYcUdUREc3L1VEZVZYVUxwczk1ZWQxdnRo?=
 =?utf-8?B?QWsxemtIMy9MQUY2UDUzSmpLUG1ZakdoUWhOZndkMzJ1TzJueWgvcDlKUzA3?=
 =?utf-8?B?N2NJd0lqM09RSWREa29uVGFseUIxZG84VDFhZFpmSDZJM0hoR3pvbVdPbWU5?=
 =?utf-8?B?YWcwcmwveXN6QllTa2xFSEJPbGRRakJpb1N0R3VYNmVyekZTcXhLUkhmQ0lG?=
 =?utf-8?B?clgvVUE5Tmd4T1ovWXZNb090eUxBS0tPMzNJVGVLVW9tcHVWZFJST2xYTVM1?=
 =?utf-8?B?S25YRFVpWHFOU0pqWmQwd0l1SGlKaUNiUUhFTEFBT1hSZlBrQVlMRUFDZ2Yz?=
 =?utf-8?B?S3pNcVJKclpDbXVuWVhrMW9EMjdWRUdOQjRtY2I4bmVmNjE3Mm1seGsxeHFu?=
 =?utf-8?B?MkY4TndSenk4VVZTYkNRZXZydVFSZ3I0ZGMzaEl4U3ErVGR3UDNIVFc5Vjhr?=
 =?utf-8?B?Y2JzakxvalRGNk9QUy9IcWNXSi8wR1I1ZnZGMHAycEx5NlA3dXNXTlZCWGhq?=
 =?utf-8?B?aGdKZWU5bDFKbFg5VTZTMkdaNFZrc1RBSHE4cmkvcVdUQ0F4TEVOd3FFeS83?=
 =?utf-8?B?VE56VkZXcDNGQ2hzaS9RM2MzSDU5Y05kM2FCUVZOc1FyYU9tSGQ1VlpPYmxB?=
 =?utf-8?B?YUxMZ0Z6V0gyOEpZcDAydDVIQnVLTC84dHkwNVNndXdsNnI0S2VaYUlQT29l?=
 =?utf-8?B?WDNyRGVQWUYwcUNHd202YmpsWEdKZWFISmdMb1hzbzJqUTBhN3NRbERDRzhK?=
 =?utf-8?Q?zXHn/mXQgMU+8wWQeAxLqmx4fOwfujY4Hx1WtKoqeFac?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12401274-ca69-46e0-6214-08de1bab28f9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:05:07.5363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CjQx4ldxU8kE1zj1Y/MonbfotxrAHkAZsI08+rIpbqqO5g2/jPtKFA0PHjvWbNM4x/dGWUic5OKAr9MtuND2TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9355

I have noticed that build will fail when doing the following:

- Start with the x86 defconfig,
- Using nconfig, enable `CONFIG_RUST` and `CONFIG_DRM_NOVA`,
- Start building.

The problem is that `CONFIG_RUST_FW_LOADER_ABSTRACTIONS` remains
unselected, despite it being a dependency of `CONFIG_NOVA_CORE`. This
seems to happen because `CONFIG_DRM_NOVA` selects `CONFIG_NOVA_CORE`.

Fix this by making `CONFIG_RUST_FW_LOADER_ABSTRACTIONS` select
`CONFIG_FW_LOADER`, and by transition make all users of
`CONFIG_RUST_FW_LOADER_ABSTRACTIONS` (so far, nova-core and net/phy)
select it as well.

`CONFIG_FW_LOADER` is more often selected than depended on, so this
seems to make sense generally speaking.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
I am not 100% percent confident that this is the proper fix, but the
problem is undeniable. :) I guess the alternative would be to make nova-drm
depend on nova-core instead of selecting it, but I suspect that the
`select` behavior is correct in this case - after all, firmware loading
does not make sense without any user.
---
 drivers/base/firmware_loader/Kconfig | 2 +-
 drivers/gpu/nova-core/Kconfig        | 2 +-
 drivers/net/phy/Kconfig              | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
index 752b9a9bea03..15eff8a4b505 100644
--- a/drivers/base/firmware_loader/Kconfig
+++ b/drivers/base/firmware_loader/Kconfig
@@ -38,7 +38,7 @@ config FW_LOADER_DEBUG
 config RUST_FW_LOADER_ABSTRACTIONS
 	bool "Rust Firmware Loader abstractions"
 	depends on RUST
-	depends on FW_LOADER=y
+	select FW_LOADER
 	help
 	  This enables the Rust abstractions for the firmware loader API.
 
diff --git a/drivers/gpu/nova-core/Kconfig b/drivers/gpu/nova-core/Kconfig
index 20d3e6d0d796..527920f9c4d3 100644
--- a/drivers/gpu/nova-core/Kconfig
+++ b/drivers/gpu/nova-core/Kconfig
@@ -3,7 +3,7 @@ config NOVA_CORE
 	depends on 64BIT
 	depends on PCI
 	depends on RUST
-	depends on RUST_FW_LOADER_ABSTRACTIONS
+	select RUST_FW_LOADER_ABSTRACTIONS
 	select AUXILIARY_BUS
 	default n
 	help
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 98700d069191..d4987fc6b26c 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -132,7 +132,7 @@ config ADIN1100_PHY
 config AMCC_QT2025_PHY
 	tristate "AMCC QT2025 PHY"
 	depends on RUST_PHYLIB_ABSTRACTIONS
-	depends on RUST_FW_LOADER_ABSTRACTIONS
+	select RUST_FW_LOADER_ABSTRACTIONS
 	help
 	  Adds support for the Applied Micro Circuits Corporation QT2025 PHY.
 

---
base-commit: 6553a8f168fb7941ae73d39eccac64f3a2b9b399
change-id: 20251104-b4-select-rust-fw-aeb1e46bcee9

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>


