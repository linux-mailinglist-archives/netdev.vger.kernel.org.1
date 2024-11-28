Return-Path: <netdev+bounces-147713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D689DB578
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 11:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2926C281522
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 10:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210FF157A67;
	Thu, 28 Nov 2024 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vk4Kww8f"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEFB2CCC0
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732789213; cv=fail; b=hhZY+OZrecQEu4piPje1rMOy0Y/X//51t4Sgz7nBxvrSRLA7m1BQewiTQycDOAZJ9Vxh1o9JLNug9wJLaGKg+1Xt3NTchoJ+A8a3Sj2pgkMqyS6oFnTXx3JayV+nygcjqLGenRZaC/s1H+1RmYkh8KRVG0QZwOjH2K8vcpq2MSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732789213; c=relaxed/simple;
	bh=muyY22ovDS2+6wPx4oEWOISFr0ZZ7qr5YqqnitvP204=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pT8XUjrqKc9fEsy15W0HqAvqDD5bsPwEPBihdwFkKjvC4vnzcDaajcbCgjbl+5qXKCDQrd/FlknvHsKw5LIhyB52CGglWK8bJzdhj1bbO76f58rzUju9HQYGjAuVCqJRC87ne09Zb/b9GlgoJ/EbSaHZYgG9KMTofNEmW/uEJyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vk4Kww8f; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyXcKzvjNBrOgCRwAGzJgZRPz7FllUWhfKHE71/WfN+3Lg5EJ24F+UCEHXRnH9QzS+IEkIsd+HLt/Aak6x7nS/wAVh7Y72+Q5WsOGrlSUVEK8MEW5JSozXW8KOtkIVCvPujQgPGYTU9yqcXuvvgtg7sUA/P5SxCNkAnTwyOT9N/LKpwSOgMWH3nyiDEmttChZYc1CnQ2uphtTTc0nl14TOpKgFEDrRa6OReTJX6In92uFkKy+u2y4gh8wbW09d/5Ajq8aBZqlnW1Bc9Iiz55IYw+zy6bWUXJmSMj/eeEW0PnH5CO9lK1ConC0RgMjQnkEEjmCb1K4D91gNxjqFfChw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muyY22ovDS2+6wPx4oEWOISFr0ZZ7qr5YqqnitvP204=;
 b=lTB3sTNGc0UOBhv3KEf4Nebizq6Ob++DGWP5obf1Z+A7oiCRc1NLQ9O+GnryaoCTwH0+M1cr888AFZrt/c6tgANITtgS3ijbRtb+3TzlDNXg3CiD25GhsiKqsKySizdNtbln0UH95gyWIItvLltqAMvbU1THiWoeMb5AlMg33g22OiSUZrkn5+lv16IXIZV5NVY2CQ4w4SNByuDbqAE4fl6Nps+ljAJi9k/wpy1PONoJt5yrbjEeAMyW6Mv2qEQTr8xcD1KnRwQfS/ny0VaCqRnDLILpvv3B2yy1jMpWL5DWgrIqRKRNMR4WKbsnTzPAGI5YfY+4+hhsdcsGiSfg5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muyY22ovDS2+6wPx4oEWOISFr0ZZ7qr5YqqnitvP204=;
 b=Vk4Kww8fKF9dup/eSicCkOad6ml5SKAIFMHRrhGkdFkJhxrw4uoyza3p/MxY/lt4V9DOuhnxX3H5/ocx2kpD8+TXEoPuCofoRQ+48r2DcDUYgXkLafB4Mr9GKqDqMERiW1ZhN0rfzwZ5Qlj+ZyCJ6LW1tedzG1tHLOpNHIwZM37C5sFmHAnhDjkxzY2RaLJMEaakiqV7TRTIdoajyDkqCgt+pRNx9VDLR+VXETTZSwtn3DemaZhfqDBjw3Cn8NsF9hfhlrjISEpD0NPclN3Ubn/BRJbieQ9fOadvbWKFj+WeAvmzo177PovvLGKbnnKIyDCpFnBVg8XNh1mTUykR7w==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by MW6PR12MB8951.namprd12.prod.outlook.com (2603:10b6:303:244::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Thu, 28 Nov
 2024 10:20:07 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%2]) with mapi id 15.20.8207.014; Thu, 28 Nov 2024
 10:20:06 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>
Subject: RE: [RFC ethtool] ethtool: mock JSON output for --module-info
Thread-Topic: [RFC ethtool] ethtool: mock JSON output for --module-info
Thread-Index:
 AQHbHz7DQv+I+3IfGkOF2TEcLZxABLKPd+pQgAHPmYCACQ73QIAuaH6AgAJJKNCAAGFwgIABVcQg
Date: Thu, 28 Nov 2024 10:20:06 +0000
Message-ID:
 <DM6PR12MB45169CD5A409D9B133EF3658D8292@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <7d3b3d56-b3cf-49aa-9690-60d230903474@gmail.com>
 <DM6PR12MB451628E919440310BC5726E5D8422@DM6PR12MB4516.namprd12.prod.outlook.com>
 <f0d2811d-e69f-4ef4-bf0f-21ab9c5a8b36@gmail.com>
 <DM6PR12MB4516A5E32EB6C663F907C24BD8492@DM6PR12MB4516.namprd12.prod.outlook.com>
 <cd258b2f-d43f-4ae6-bd7c-ca22777d35e3@gmail.com>
 <MN2PR12MB45179CC5F6CC57611E5024E2D8282@MN2PR12MB4517.namprd12.prod.outlook.com>
 <f3272bbe-3b3d-496e-95c6-9a35d469b6e7@gmail.com>
In-Reply-To: <f3272bbe-3b3d-496e-95c6-9a35d469b6e7@gmail.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|MW6PR12MB8951:EE_
x-ms-office365-filtering-correlation-id: d02964be-ba8e-408f-8331-08dd0f963b2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z3BtY1hydHMwK1g1N3Y4Ujk3ZHRCSWQwazU2QTVJUWYxcnlRbFdUWXMrMWVV?=
 =?utf-8?B?ZUdNYzN1QVZjWk50c254ZUczNnZyNmhyaGQvRmJXRWd4SWl4OG5UNTVRWWpi?=
 =?utf-8?B?RFJtRUR4cjJYbHdlMGZaVkFleDJrZUw0NmNieXZwVW4zdkcxYmcydXJyR2xC?=
 =?utf-8?B?TXBwSnhvVjl3Mit3OWpYTktPRW5haGlpZnNVZFFudmw3QkE5VDdsWVZWb2R2?=
 =?utf-8?B?R3hYWU9kcHRoTzRFazJDU3JmOGtNeU5ldE10elBHbW5wdThwQnYzaUZIMDdT?=
 =?utf-8?B?NitrVVFWZE5jZzZMZDNsWjlYZW51NWJXVXFNRDZoL3Y3Mnl0N0pGUEFyYmtI?=
 =?utf-8?B?YmRUOXc5T2ZqQVNWakUwKzI0b3FZRmZLMjE5M3ZyU1JVOUg2Ulpna2xJNFox?=
 =?utf-8?B?UFhFNDJMZFA4QzByd3p2S3RtOTdEa0pwMWhkZlBzUll1dnFVNFh2YUNzR2Ju?=
 =?utf-8?B?QkN1anVYYUV6dzdEUC9PR2p0MHlNSEdBdnU5TGYyUHc1NnJLSDNmRUF0SmJB?=
 =?utf-8?B?RitQVDJCYi8rOFpzVkw3Rmp4TlNVNUUwazdPclVnanVoY0FaTEw1NTdCc1do?=
 =?utf-8?B?R0haNzdLZHV5WnRVczZmRG9nbzZxWGo2TlpsWmRjUVN5NjlTTTRNVkhKUDlj?=
 =?utf-8?B?R0FsajNmcmhDeWdldjZ5TCtnZDYreVNiQ3Q0VTVPV09oSjgxc3NEMnVYd2pD?=
 =?utf-8?B?Ylo2aGpMcGhTTFN4VzJicHgzY2h5SnpqUW1ZVGpveUoraFVaenNULzE3MFNT?=
 =?utf-8?B?WWJNWlhLK3ltd1FlZi84QzNONUJ4SEZoVmxSeEtiY1Q2a1VqNXVITzJvMmtZ?=
 =?utf-8?B?aGdlb0xqM0VqbU84RjJ3ekl1NFI4bkxJZXoxT0gzUE1YekV0b2ZZTWhVQkpu?=
 =?utf-8?B?cFNrdWlDcFU0WlpUUUhWUDhhL2NZNUtvUFZSbUYraXNXYkhIcU1CR0dDZUxX?=
 =?utf-8?B?VUNlVXVNWTBLb201T2xmOWpHU1F1Wk40TkRpTlZKSWdtV2t3YmNVY3F3Vmpu?=
 =?utf-8?B?RzZoWE5RZVhKT3hWczhlSjlHWWJ1TFI5c1QxcUJJSXNUOTdJdUdXVGVBM3hO?=
 =?utf-8?B?WElxekdMcGxJU09pTkNNN0YwNUFhbGdkZUR6OWZpL3h1MTZFaUdGN0xNUkZh?=
 =?utf-8?B?ZTJnNTdJMkc0RFdTTGVuNkRpRUJvRVhLTHpIeWxYRy83WHVQYUVTWThjYTN0?=
 =?utf-8?B?Q2g5b2dkRXA3Z2Zxb2hWS2ladW9FRjZOSERBdk96ZFE4SnNWOStOMzBnWWJV?=
 =?utf-8?B?MXhoRVIrd3djanJQanJlVVJkcWU5Mzk4TTI0cG9UaHZOeklQKzhGblAxRFh3?=
 =?utf-8?B?Vkx5T1hzTjViN0lwQjhDUnRMa0VUSlhReWVUdElHV2dhNUJGWDlEN3AvTFRS?=
 =?utf-8?B?MHhnYjUrU2U5alpmc1V0VlpWK2h0RHphY2RmYVdYTWNxbUw4ajFVb2pYRjVN?=
 =?utf-8?B?QzFzcDNGVWRsazhZZ05qOEl5U3oxQ2dGREJZZ080NUlWRmluU0JnblhEWkd3?=
 =?utf-8?B?M3NmU3ZTVTQ5aFBoakVnRWg0QkRnckpMbTVEdnV0NUR0UWk0ZTYxQVNaa3I5?=
 =?utf-8?B?SmhZcGhGcWltZnpRY3dsWjZIUkdGc1dxd3BQSHcwOWJ3NkY1eFdHdkVEd0tv?=
 =?utf-8?B?NUpBRFE3ZGZlTThuNk9CaThUSk9HY2w0OXJYazRjdGpLRWVUSUxzTjFUMEEx?=
 =?utf-8?B?QndzNWJqVklMcXUyKzZqUzVBdVZCYUIwemh1c3pTYjMyQUUybFdubWNYdWsw?=
 =?utf-8?B?WGVCQSt3REhwNVEzWlRySW5ZK0Q3RlMwck1RR2p2eHc3UWNDVFBySjhsampH?=
 =?utf-8?B?bnZwcS9Xc3NxSEM2U3NwQXVjUlZMNU82VjVRUWNpTmpWT1FHUUxreXZYbHpk?=
 =?utf-8?B?ck9lMGdGcFJvYy9BWHlLZlFNWjFnQWtFQkR3UTZ3cmh5a1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RmNmSmRTWG5heTFsVFJQOVoxZVlZeXd0a2RtUGNZbml4djI4TE4wVUR3R1I2?=
 =?utf-8?B?M250bTF4NG1keTJ4RGRldzRvVkp1T2NFZ2tKSGxSbzRaNGV6VkZoK293emtj?=
 =?utf-8?B?YXl6WGwzRjFsMWQ0Z3NuTzliamlPUy9VbTl1bWNvY25BVWdSajdyK0cyWHEx?=
 =?utf-8?B?L0ZYbllLbE1aWWd5c0NrM3d3S0g0QzNLaENETGZxcEEwYWZoWHNORUJKRkVF?=
 =?utf-8?B?Mm41aTdWSHJ4VVF1YVN2VHZTMnQ5RlUxZldXdE5rSTZPSHQ0WlNNekRNUzNF?=
 =?utf-8?B?cWR3TlBjKzArMFlNdFlyb3NwclVWLzIxODl1eWViWUJFWmZHbHJhVHY4YXJy?=
 =?utf-8?B?U0VFT25BMDU1Z1plM3pQM244WHcwY21vYkRXMXkxVlZQeXQwdWZYNGpoZHNX?=
 =?utf-8?B?TEEwcm5SWlRJOWs2YkJndnJQNXNnR1dFM2cydlQ5UXdtbG9IbkFzM2pOMkNs?=
 =?utf-8?B?S29vK2hvdDU4c1hySzJvZWhCVzZId01HYkNvL21nd1lDL09McUhBc1dNMWRo?=
 =?utf-8?B?enBrMkpFemZNMkN3WmNFbG1QcEc1YlBac0hpWi9JMEpVK0V6bEg1VkExQ1Ex?=
 =?utf-8?B?cFh2RUpQSHp1RU40aVZ2UUh5K2MrbWM2Z0FmK2cxVUtJeVp4ZmZ3RnlHbFUr?=
 =?utf-8?B?VkorbHpsdDIyU3NKUjJiMmZZNWVUcEJIZmFPb0lTcDJyMzhBU2ZQWkxjSEJM?=
 =?utf-8?B?YWhKaFpHVzk4enpsZjAxQWR1SXZVemlSWjh2YU5nR2VDZHZJd1lwcHo2WnhT?=
 =?utf-8?B?eGF0Z1A0ZnFXQ2VCWGRCb3VtUVViS2hURStrTHcvZUVZUjFZUEtjVFRsNExl?=
 =?utf-8?B?bUZPb3lYVmZvamhET0tJUmk4QmhIYzdtYUVtMTJydjdpNm1TSTNGYWJENlNM?=
 =?utf-8?B?anpMQzJGR1hodEJ0TytRdVRrd3V5TkFRQXNzNnpkTHJybU5wRlBvdG1JR2Qy?=
 =?utf-8?B?VzMvbE9hMWpiRXloOEZHTkhIc3JSc3dMYnpGL29kdzNYR3UweisyM1VqdkFj?=
 =?utf-8?B?U1hOT3l2Yk1POUY0YXRyRkYxUE13aDZRVWlqVmt6RU9wZWI1Mk5oaWpZM2N2?=
 =?utf-8?B?OUMycGthRHVQbTNrWkF5b0ozQTRXdW5sYWxuUVlESG5wSVVEbFVtWjduall3?=
 =?utf-8?B?RG85c3hVUE04Qm80R1JTQVZ3RjhMOVpFVnlLc0RZSVhhMGJhbUZGUTc1QmF6?=
 =?utf-8?B?SjFDK0pMQlVNalJ6Q05MY1k5dm0razUrMVBDbWhBdkd4TkZiZDgzaUk3VlV5?=
 =?utf-8?B?b2lrUXd4ZXg4Mml3WlIzdzBhTzFlZU5XK0hXOE1RdzltK29sY2VSRnNNSlVR?=
 =?utf-8?B?eFJnN1RMdmNwMWY2Q01rV2gvM2NXZ3Q2ZE83QUlmZGozN1JKcHFUd05wRmdw?=
 =?utf-8?B?bEgyNi9rWlk0NDJuR0k0d1d1bHIya3RvT2dQaU8wVnc0SE04L2NaZ1dxeVZE?=
 =?utf-8?B?NjhFWkJyNFZURWdpVzlFQWMrM1dmbVdHZnpJQ3lTQUcwdFhSUURsMWViZ2Ju?=
 =?utf-8?B?ZXdDMkFhQkZnMlgvSGptQVZ5VXdzV084NkNZdVAwb1JkQ3JmV3B5V05nQUpi?=
 =?utf-8?B?RENVdGJqRUVMdkpUaXlqWHlicG1UM1N3SmV1SGt0ZWt0amdiRHYyeTE4MlJt?=
 =?utf-8?B?UzAxbTlwUWp5ZktWWWRUcnFtVDlGR1JtNG4yMktEajVKeWVGWnJ5Wk9Id0FW?=
 =?utf-8?B?bG9vTHNjV1lZSDZsdENKNElPeTRDdlVjakg2ME5oaVhCUjNGTW1nWUdnQ3pZ?=
 =?utf-8?B?SlZTS2ljWUtHcUFkOUJxSGYxL2xJZEFoYlJVcytYWUhFRU1xaTAwbUNOOVNF?=
 =?utf-8?B?OS9IRlB0ZGxZNzg2QVp2Q2tmR2tud3FMRUtlN29lc21mcmdYTUpIVkhVT0Ey?=
 =?utf-8?B?WDlJMzhuTTgvdm5nTkpESVhxN0lmMUtzbElueUhhQUZNcWhxalIrYVJxRUdS?=
 =?utf-8?B?elkxREE4RXhyOTlKenRzcXIzQUhzUXIvZDlJY2QrNUFpZFl3eWVzMlB6eVZw?=
 =?utf-8?B?MFFWZHBRSElPUDFoUzJWS2VrNXNySkx5VmQ5Q0N5bUZ6ZFZHMDFVUTN5SUlG?=
 =?utf-8?B?eXVwdExNWDcvSWloUUJEZTU2cHVja3ZpdnRCWmNBdkRHV3ZIQ211OTZnc29R?=
 =?utf-8?Q?aNJAqQHW9Nms+IFfwMioI6tJk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d02964be-ba8e-408f-8331-08dd0f963b2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 10:20:06.8388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o50NzyNRF799dFgMpxN20NVauhzS+xVsl/pfwI/pgMX8poV16l1FR3/Mgrznhmeg/Wp5iti4YfvSvaZ61ZVh2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8951

PiBGcm9tOiBEYW5pZWwgWmFoa2EgPGRhbmllbC56YWhrYUBnbWFpbC5jb20+DQo+IFNlbnQ6IFdl
ZG5lc2RheSwgMjcgTm92ZW1iZXIgMjAyNCAxNTo1Ng0KPiBUbzogRGFuaWVsbGUgUmF0c29uIDxk
YW5pZWxsZXJAbnZpZGlhLmNvbT4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IEpha3Vi
IEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBJZG8gU2NoaW1tZWwNCj4gPGlkb3NjaEBudmlk
aWEuY29tPjsgbWt1YmVjZWtAc3VzZS5jeg0KPiBTdWJqZWN0OiBSZTogW1JGQyBldGh0b29sXSBl
dGh0b29sOiBtb2NrIEpTT04gb3V0cHV0IGZvciAtLW1vZHVsZS1pbmZvDQo+IA0KPiANCj4gT24g
MTEvMjcvMjQgMzoxMSBBTSwgRGFuaWVsbGUgUmF0c29uIHdyb3RlOg0KPiA+IEhpLA0KPiA+DQo+
ID4gSSBhbSBhdHRhY2hpbmcgdGhlIGR1bXAgSSBhbHJlYWR5IGhhdmUgaW1wbGVtZW50ZWQgZm9y
IGJvdGggQ01JUyBhbmQgU0ZGDQo+IG1vZHVsZXM6DQo+ID4NCj4gPiAkIHN1ZG8gZXRodG9vbCAt
LWpzb24gLW0gc3dwMjMNCj4gPiBbIHsNCj4gPiAgICAgICAgICAiaWRlbnRpZmllciI6IDI0LA0K
PiA+ICAgICAgICAgICJpZGVudGlmaWVyX2Rlc2NyaXB0aW9uIjogIlFTRlAtREQgRG91YmxlIERl
bnNpdHkgOFggUGx1Z2dhYmxlDQo+IFRyYW5zY2VpdmVyIChJTkYtODYyOCkiLA0KPiA+ICAgICAg
ICAgICJwb3dlcl9jbGFzcyI6IDUsDQo+ID4gICAgICAgICAgIm1heF9wb3dlciI6IDEwLjAwLA0K
PiA+ICAgICAgICAgICJtYXhfcG93ZXJfdW5pdHMiOiAiVyIsDQo+ID4gICAgICAgICAgImNvbm5l
Y3RvciI6IDQwLA0KPiA+ICAgICAgICAgICJjb25uZWN0b3JfZGVzY3JpcHRpb24iOiAiTVBPIDF4
MTYiLA0KPiA+ICAgICAgICAgICJjYWJsZV9hc3NlbWJseV9sZW5ndGgiOiAwLjAwLA0KPiA+ICAg
ICAgICAgICJjYWJsZV9hc3NlbWJseV9sZW5ndGhfdW5pdHMiOiAibSIsDQo+ID4gICAgICAgICAg
InR4X2Nkcl9ieXBhc3NfY29udHJvbCI6IGZhbHNlLA0KPiA+ICAgICAgICAgICJyeF9jZHJfYnlw
YXNzX2NvbnRyb2wiOiBmYWxzZSwNCj4gPiAgICAgICAgICAidHhfY2RyIjogdHJ1ZSwNCj4gPiAg
ICAgICAgICAicnhfY2RyIjogdHJ1ZSwNCj4gPiAgICAgICAgICAidHJhbnNtaXR0ZXJfdGVjaG5v
bG9neSI6IDAsDQo+ID4gICAgICAgICAgInRyYW5zbWl0dGVyX3RlY2hub2xvZ3lfZGVzY3JpcHRp
b24iOiAiODUwIG5tIFZDU0VMIiwNCj4gPiAgICAgICAgICAibGVuZ3RoXyhzbWYpIjogMC4wMCwN
Cj4gPiAgICAgICAgICAibGVuZ3RoXyhzbWYpX3VuaXRzIjogImttIiwNCj4gPiAgICAgICAgICAi
bGVuZ3RoXyhvbTUpIjogMCwNCj4gPiAgICAgICAgICAibGVuZ3RoXyhvbTUpX3VuaXRzIjogIm0i
LA0KPiA+ICAgICAgICAgICJsZW5ndGhfKG9tNCkiOiAxMDAsDQo+ID4gICAgICAgICAgImxlbmd0
aF8ob200KV91bml0cyI6ICJtIiwNCj4gPiAgICAgICAgICAibGVuZ3RoXyhvbTNfNTAvMTI1dW0p
IjogNzAsDQo+ID4gICAgICAgICAgImxlbmd0aF8ob20zXzUwLzEyNXVtKV91bml0cyI6ICJtIiwN
Cj4gPiAgICAgICAgICAibGVuZ3RoXyhvbTJfNTAvMTI1dW0pIjogMCwNCj4gPiAgICAgICAgICAi
bGVuZ3RoXyhvbTJfNTAvMTI1dW0pX3VuaXRzIjogIm0iLA0KPiA+ICAgICAgICAgICJyZXZpc2lv
bl9jb21wbGlhbmNlIjogWw0KPiA+ICAgICAgICAgICAgICAibWFqb3IiOiA0LA0KPiA+ICAgICAg
ICAgICAgICAibWlub3IiOiAwIF0sDQo+ID4gICAgICAgICAgInJ4X2xvc3Nfb2Zfc2lnbmFsIjog
WyAiWWVzIiwiWWVzIiwiWWVzIiwiWWVzIiwiWWVzIiwiWWVzIiwiWWVzIiwiWWVzIiBdLA0KPiA+
ICAgICAgICAgICJ0eF9sb3NzX29mX3NpZ25hbCI6ICJOb25lIiwNCj4gPiAgICAgICAgICAicnhf
bG9zc19vZl9sb2NrIjogIk5vbmUiLA0KPiA+ICAgICAgICAgICJ0eF9sb3NzX29mX2xvY2siOiAi
Tm9uZSIsDQo+ID4gICAgICAgICAgInR4X2ZhdWx0IjogIk5vbmUiLA0KPiA+ICAgICAgICAgICJt
b2R1bGVfc3RhdGUiOiAzLA0KPiA+ICAgICAgICAgICJtb2R1bGVfc3RhdGVfZGVzY3JpcHRpb24i
OiAiTW9kdWxlUmVhZHkiLA0KPiA+ICAgICAgICAgICJsb3dfcHdyX2FsbG93X3JlcXVlc3RfaHci
OiBmYWxzZSwNCj4gPiAgICAgICAgICAibG93X3B3cl9yZXF1ZXN0X3N3IjogZmFsc2UsDQo+ID4g
ICAgICAgICAgIm1vZHVsZV90ZW1wZXJhdHVyZSI6IDM2LjAwLA0KPiA+ICAgICAgICAgICJtb2R1
bGVfdGVtcGVyYXR1cmVfdW5pdHMiOiAiZGVncmVlcyBDIiwNCj4gPiAgICAgICAgICAibW9kdWxl
X3ZvbHRhZ2UiOiAzLjAwLA0KPiA+ICAgICAgICAgICJtb2R1bGVfdm9sdGFnZV91bml0cyI6ICJW
IiwNCj4gPiAgICAgICAgICAibW9kdWxlX3RlbXBlcmF0dXJlX2hpZ2hfYWxhcm0iOiBmYWxzZSwN
Cj4gPiAgICAgICAgICAibW9kdWxlX3RlbXBlcmF0dXJlX2xvd19hbGFybSI6IGZhbHNlLA0KPiA+
ICAgICAgICAgICJtb2R1bGVfdGVtcGVyYXR1cmVfaGlnaF93YXJuaW5nIjogZmFsc2UsDQo+ID4g
ICAgICAgICAgIm1vZHVsZV90ZW1wZXJhdHVyZV9sb3dfd2FybmluZyI6IGZhbHNlLA0KPiA+ICAg
ICAgICAgICJtb2R1bGVfdm9sdGFnZV9oaWdoX2FsYXJtIjogZmFsc2UsDQo+ID4gICAgICAgICAg
Im1vZHVsZV92b2x0YWdlX2xvd19hbGFybSI6IGZhbHNlLA0KPiA+ICAgICAgICAgICJtb2R1bGVf
dm9sdGFnZV9oaWdoX3dhcm5pbmciOiBmYWxzZSwNCj4gPiAgICAgICAgICAibW9kdWxlX3ZvbHRh
Z2VfbG93X3dhcm5pbmciOiBmYWxzZSwNCj4gPiAgICAgICAgICAiY2RiX2luc3RhbmNlcyI6IDEs
DQo+ID4gICAgICAgICAgImNkYl9iYWNrZ3JvdW5kX21vZGUiOiAiU3VwcG9ydGVkIiwNCj4gPiAg
ICAgICAgICAiY2RiX2VwbF9wYWdlcyI6IDAsDQo+ID4gICAgICAgICAgImNkYl9tYXhpbXVtX2Vw
bF9yd19sZW5ndGgiOiAxMjgsDQo+ID4gICAgICAgICAgImNkYl9tYXhpbXVtX2xwbF9yd19sZW5n
dGgiOiAxMjgsDQo+ID4gICAgICAgICAgImNkYl90cmlnZ2VyX21ldGhvZCI6ICJTaW5nbGUgd3Jp
dGUiDQo+ID4gICAgICB9IF0NCj4gPg0KPiA+ICQgc3VkbyBldGh0b29sIC0tanNvbiAtbSBzd3Ax
DQo+ID4gWyB7DQo+ID4gICAgICAgICAgImlkZW50aWZpZXIiOiAyNCwNCj4gPiAgICAgICAgICAi
aWRlbnRpZmllcl9kZXNjcmlwdGlvbiI6ICJRU0ZQLUREIERvdWJsZSBEZW5zaXR5IDhYIFBsdWdn
YWJsZQ0KPiBUcmFuc2NlaXZlciAoSU5GLTg2MjgpIiwNCj4gPiAgICAgICAgICAicG93ZXJfY2xh
c3MiOiAxLA0KPiA+ICAgICAgICAgICJtYXhfcG93ZXIiOiAwLjI1LA0KPiA+ICAgICAgICAgICJt
YXhfcG93ZXJfdW5pdHMiOiAiVyIsDQo+ID4gICAgICAgICAgImNvbm5lY3RvciI6IDM1LA0KPiA+
ICAgICAgICAgICJjb25uZWN0b3JfZGVzY3JpcHRpb24iOiAiTm8gc2VwYXJhYmxlIGNvbm5lY3Rv
ciIsDQo+ID4gICAgICAgICAgImNhYmxlX2Fzc2VtYmx5X2xlbmd0aCI6IDAuNTAsDQo+ID4gICAg
ICAgICAgImNhYmxlX2Fzc2VtYmx5X2xlbmd0aF91bml0cyI6ICJtIiwNCj4gPiAgICAgICAgICAi
dHJhbnNtaXR0ZXJfdGVjaG5vbG9neSI6IDEwLA0KPiA+ICAgICAgICAgICJ0cmFuc21pdHRlcl90
ZWNobm9sb2d5X2Rlc2NyaXB0aW9uIjogIkNvcHBlciBjYWJsZSwgdW5lcXVhbGl6ZWQiLA0KPiA+
ICAgICAgICAgICJhdHRlbnVhdGlvbl9hdF81Z2h6IjogMywNCj4gPiAgICAgICAgICAiYXR0ZW51
YXRpb25fYXRfNWdoel91bml0cyI6ICJkYiIsDQo+ID4gICAgICAgICAgImF0dGVudWF0aW9uX2F0
XzdnaHoiOiA0LA0KPiA+ICAgICAgICAgICJhdHRlbnVhdGlvbl9hdF83Z2h6X3VuaXRzIjogImRi
IiwNCj4gPiAgICAgICAgICAiYXR0ZW51YXRpb25fYXRfMTIuOWdoeiI6IDYsDQo+ID4gICAgICAg
ICAgImF0dGVudWF0aW9uX2F0XzEyLjlnaHpfdW5pdHMiOiAiZGIiLA0KPiA+ICAgICAgICAgICJh
dHRlbnVhdGlvbl9hdF8yNS44Z2h6IjogMTYsDQo+ID4gICAgICAgICAgImF0dGVudWF0aW9uX2F0
XzI1LjhnaHpfdW5pdHMiOiAiZGIiLA0KPiA+ICAgICAgICAgICJyZXZpc2lvbl9jb21wbGlhbmNl
IjogWw0KPiA+ICAgICAgICAgICAgICAibWFqb3IiOiA0LA0KPiA+ICAgICAgICAgICAgICAibWlu
b3IiOiAwIF0sDQo+ID4gICAgICAgICAgIm1vZHVsZV9zdGF0ZSI6IDMsDQo+ID4gICAgICAgICAg
Im1vZHVsZV9zdGF0ZV9kZXNjcmlwdGlvbiI6ICJNb2R1bGVSZWFkeSIsDQo+ID4gICAgICAgICAg
Imxvd19wd3JfYWxsb3dfcmVxdWVzdF9odyI6IGZhbHNlLA0KPiA+ICAgICAgICAgICJsb3dfcHdy
X3JlcXVlc3Rfc3ciOiBmYWxzZQ0KPiA+ICAgICAgfSBdDQo+ID4NCj4gPiBQbGVhc2UgbGV0IG1l
IGtub3cgd2hhdCBkbyB5b3UgdGhpbmsuDQo+IA0KPiANCj4gVGhlIGZvcm1hdHRpbmcgTEdUTS4g
SXQgc2VlbXMgbGlrZSBzb21lIG9mIHRoZSBmaWVsZHMgZnJvbSB1cHBlciBwYWdlIDAwaCBhcmUN
Cj4gbWlzc2luZzogdmVuZG9yIG5hbWUsIHZlbmRvciBwbiwgZXRjLiBBcmUgdGhvc2UgZWxpZGVk
IGJlY2F1c2UgdGhleSBhcmUgbnVsbD8NCj4gDQoNCk5vLCBpdCBpcyBiZWNhdXNlIGl0IGlzIG5v
dCBpbXBsZW1lbnRlZCB5ZXQuIFNlbnQgeW91IG9ubHkgd2hhdCB0aGF0IGlzIHJlYWR5Lg0KDQo+
ID4NCj4gPiBJIGJlbGlldmUgSSB3aWxsIHNlbmQgYSB2ZXJzaW9uIGFib3V0IHR3byB3ZWVrcyBm
cm9tIG5vdy4NCj4gDQo+IA0KPiBTb3VuZHMgZ29vZC4gVGhhbmtzIGZvciB0aGUgdXBkYXRlLg0K
DQpUaGFuayB5b3UuDQoNCg==

