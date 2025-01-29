Return-Path: <netdev+bounces-161551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BA4A22458
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 19:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B079718862FD
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 18:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FEA1E0E0B;
	Wed, 29 Jan 2025 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Lqti/c+/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0849A1E0DE3
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738177059; cv=fail; b=GnBMbajtvVGivxAxsLJ6WQLB4Hb0VgjGE39D/Y/affoSTihlW+031iu2aA+bb4JZ66T8PS3RI3TNhm9/gB5KTLrr/m5/q6N32DjFTwj4lE8XsRHyhgs1ehmW1SLOaXbQpG2qKEbJaTsBKoZFK6PTF/O4qiKhDMjM9GgVLNO4ZwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738177059; c=relaxed/simple;
	bh=ct4ortY7AlyAEK9HLWyl3ouL74pnVutqj5KkvfXrv2U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GAVb8hPbw3+qwLyHE8oxRScAN9Vx6M4UQcuh7qkFUPQACwqfKfUqoBy1kIjW8OugYesgMlYiGBo/ytXczUvqjti0f9V4E6BenvMX9AAvU2hkUz6YDuW0NLNKPSgZbo2dlWT3+hpcStH05OdWcpa4TXbXrNNxlXgKEaUSJ1ZRODU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Lqti/c+/; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCnSAJpfTshGAFPZx8JGzP5O3CX1RLNP4LYwxbInvuQyzStZX+oQatKG11YUaUtLuMgvQAVjSVJUfuP8q1otVLv4SAXQW2+R54Go91lpqQATGFp9ZfRMKbb8/Xd7XsAIvHE1OpAg5uK9aw8be3/tiVFAtx65jKbMJRN5b9F4YMFY9mFOH391mk5dILrZhD6YDzrqFBkjN/OqqRTvAkx4UpmPpOiSOz8c1Zpcb6TVsgzihob+OtB7SZlQz3qkRmjnebSNHpNvM+NecAkbw+fU1c39Lqnq4cmoiAffTuiP18IHA/4/L6zCJMfRb6QwlFV38UsF6YYbmBHWakK/OjIldA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ct4ortY7AlyAEK9HLWyl3ouL74pnVutqj5KkvfXrv2U=;
 b=Y5rTiJvjFZtsXM3DC0Lf8Jx/s19s91xIQW25wpG9m2fmJRizjxL0fUjgzy5ONwokW6MHIo0RTMLWPJ0CpLqa5xcSV9jxp7Vc+C48nSLCdPp07kCGLpA+jcpMI8ohlJgHV6dzlUAWx8+ZItpyUb8wCgYTu7fGEk7hRAkW4jUvbVdiptS7UmzByDhnIjuAZv6ouUPluE02wzEjT9Ylf8b2hnMbDfT5h+dp/9ovRikwNNwvUKWq9JVuUZuwSKuQEDA4CSdpWxo1TUZn0EdCg/PZJkq/nblYxPZS5ihL4nsvmMG7dinXJy/gfwe6bIrzKU/RJMU7ltDuv9f4IRgMXIafpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ct4ortY7AlyAEK9HLWyl3ouL74pnVutqj5KkvfXrv2U=;
 b=Lqti/c+/xfG/X6sDFE+5UruGGlw0y9kqIZDJB8eGBVv2lX5gNvXDhMMWAUEaRv/5nKKQtFi5aJQSfBaXnqRJ/QHNpx/gOC6s9eV9gNbV3dPeefnOkrLNjW6+pv/b3ik/LdlvcQsLh5DSPhO0e+zkcGw5ry160b22SjQu2Lkg/qcUDtf9upIQPgAZIu5HbZEmJza2fjtXl3J+dPgYrl4blbw6+JpgFaMWQGapfAqDxtu+hNhZGyShw5rWXKderhUejaWDHRqdzZb8BDUvWetPqx4AXqoygFwzBCNwaAb5zysI3TfdGPtUJbSmoi8OBVFWTGiturcWXJNYuYRA+Y0hsA==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by PH7PR11MB6473.namprd11.prod.outlook.com (2603:10b6:510:1f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 18:57:34 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%3]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 18:57:33 +0000
From: <Woojung.Huh@microchip.com>
To: <frieder.schrempf@kontron.de>
CC: <andrew@lunn.ch>, <netdev@vger.kernel.org>, <lukma@denx.de>,
	<Tristram.Ha@microchip.com>
Subject: RE: KSZ9477 HSR Offloading
Thread-Topic: KSZ9477 HSR Offloading
Thread-Index:
 AQHbcZ/V7BrTHsAdqUafWk3/ZoT41LMsd0oAgADjJgCAAArSgIAANkeAgAAFAwCAACgGgIAANNSAgAAc85A=
Date: Wed, 29 Jan 2025 18:57:33 +0000
Message-ID:
 <BL0PR11MB2913C7E1AE86A3A0EB12D0D7E7EE2@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <05a6e63e-96c1-4d78-91b9-b00deed044b5@kontron.de>
 <6d0e1f47-874e-42bf-9bc7-34856c1168d1@lunn.ch>
 <1c140c92-3be6-4917-b600-fa5d1ef96404@kontron.de>
 <6400e73a-b165-41a8-9fc9-e2226060a68c@kontron.de>
 <20250129121733.1e99f29c@wsk>
 <0383e3d9-b229-4218-a931-73185d393177@kontron.de>
 <20250129145845.3988cf04@wsk>
 <42a2f96f-34cd-4d95-99d5-3b4c4af226af@kontron.de>
In-Reply-To: <42a2f96f-34cd-4d95-99d5-3b4c4af226af@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|PH7PR11MB6473:EE_
x-ms-office365-filtering-correlation-id: de3bf5e4-d149-4e0b-904b-08dd4096ca2f
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZUxQL1J6Nkt1UExuRmVzNWdCaWQ4bjJtWDlFdkgwWlVTUWhVQnhCTlVvL3dy?=
 =?utf-8?B?MnpkbTlmZ0pKQkdkTnlKdDA1S1UreXB6ZkpNYkV2ektMQnB0TTdTNEZ1TWtU?=
 =?utf-8?B?STFPVm5IYTdxU1NWOE1yVVZlVjhIMnAvMzZXaGs0RDViRU1TeEVTL2NNWWNB?=
 =?utf-8?B?TWxmcUdUeDZ3SmR4M0NBMElRbjY5dldpdUR1WXlsQnV3L0JGRExOWE5LSTdY?=
 =?utf-8?B?NTVaOXJnRWhXQ1EzQnhMNktmUWlSb0REQlFOQU05eVVCemhrQ0FUdk1OTjhO?=
 =?utf-8?B?L0JYajJGbFVaaDlTUFU5RGdEUERNelF6anlyVjMvODl4dzhZenhRcSt4T2tY?=
 =?utf-8?B?bFhaWXJSOTk5c0I3Y1R6SXU3QVI2MThhTkk1NHNJWStSU1NyRyt0Q0Y5SUdG?=
 =?utf-8?B?b1RCNzRmMnNZMU50cmNOaCtvUytvS2pFZXdxNDhNdndkSGdiek1QR3Q1Nm9r?=
 =?utf-8?B?QlI4bEE4QUtWT2pZcktiYytNRExxYzRPS0VQdHFuSWp3UlJoS3hyQThQaXpL?=
 =?utf-8?B?cktyQXFPT3FLNnRiblBwYXQ3a0U2L2FPd2xlRmV6ZUlyWG1ZYlZXRUZhWVRo?=
 =?utf-8?B?d1MvZm1KYjlCaDVjN3BJTGw2bnJ3OEZwRUFBUXdXa3hKWVZBTUdJS2cveFpa?=
 =?utf-8?B?cUR3VGRZV09KZU91TzgrSXNRREJwUmNYL01VQmhOcTJicElDVHBjaHZjcm1j?=
 =?utf-8?B?SC9QTzZ4MSsvY0Nocmg4cFcxOUYyRXlrK1JGeEc4SEh5QW04cFl1ZkN3NXJH?=
 =?utf-8?B?TlQ2K0tENTlmbVBvWTQ4MjFXQWVzUUt6Wk1IdXpVcHBOQkZIdEROcmtiTTVn?=
 =?utf-8?B?MmxnNGw5YS9aWjdHM05xNzBBbHRJaVNsMCtOQS9icm5hdVhyeXoyQXEwclpu?=
 =?utf-8?B?SGo4ejJmVEhYdmxOUlJBK3VNTTg2Tis5T3lNa0hxb1lVQmFUa1gxU2RpNkps?=
 =?utf-8?B?SmNkaExBN1p5UWoxK2JldUxxWXFqTEdNa2lZcWN3VGMzTkxUb3lWUjZuNVYx?=
 =?utf-8?B?ZWVVNGIxdythVkd3OXlGUSs2dzI4WjAyUlVHcURCdHVKZExBSkZEUC9oQ3B4?=
 =?utf-8?B?TTVOQVNYYXZMNEJEVlVwWUM5M1NhYmN5Q1EyM1BKV3pTV3BTNWViS2NESzla?=
 =?utf-8?B?SlNCejRsVXA4SHhyaGdRNmNKRVFoSnJzQk5kUXUxNGtQVGl1aTVLWTJYYXND?=
 =?utf-8?B?K2pWTDFxR3g2QWhkcFFnRnRvRUh0Qjc2QWxSOFViWGU5SzBMOTUrMG84WWZk?=
 =?utf-8?B?Y01vcnB1K1FPbkp1VFkwRDQyNXZ0TkkxZElEUTk2K3Nvbis1NDNSQmJTRmZD?=
 =?utf-8?B?VWFTL2dGc21wVzJ4OTAxd3JPQTlXay9weVNFc3dFdFBVMDRRRVhrVjNrRHFk?=
 =?utf-8?B?QkdPR0lnV2RVeXhJbnRoU3BSclB4Y1gwak5zVnBzZENVRng5Z21kQjR0cTdF?=
 =?utf-8?B?c2YvU0t3T0lZTi9JdWtHWW84NXN3NEIwYzM3cEtHY2tvRFJ0eW4wbkl4Vy9G?=
 =?utf-8?B?cWJJT1NjT1E4RWV2NDFTQ2JhY2p5dzJVZVowYzJRZU1ZOGNtS2x0TXp4RExG?=
 =?utf-8?B?c25hR1ZCYUJ5VkVhRitOdDRWQVdRL3N4TUhrd2NDWUtTa0JzbVpCQ0xmWjMx?=
 =?utf-8?B?Tk5FUDJ4cWZZZEkzWEx4ZlhiSXJxZlRRdHA4bEhqNXZYbnJ0ZWlmeFJNUjhJ?=
 =?utf-8?B?c1Vjd01kR0FjRGN6Um83UEowWHpmY25EL290TTQvMHMzVk9iK01ZMms4dGlp?=
 =?utf-8?B?MXg5ZmFyRU5aRXVCMkM5d05LZGNkUzJHZU1GWDUxZmxaaXNJVldFVU9NOXlw?=
 =?utf-8?B?U1RNZFlwbEN3N3RTeHByZXJCWkpyRERpQUM5OEZVcGV6YUtvWm9QVjdXWE8z?=
 =?utf-8?B?Uy9kaW9kSHV3dmxRNEwyb3o0UC9RQUc5VVZ1MU9aRitOYlE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cTRGbG1UbHhTc1BRdEoyaktsK1U5WWhuNFJyWG9TYmIvVE1UeCs2VlQwdzUz?=
 =?utf-8?B?TmNsWDB2ZDlWYU5xRmsyL1RFQWFwK2VueU5kem9ONEtMWUxwc2tEM2grc2lv?=
 =?utf-8?B?TGdsZ0JHSGpjc1FzTGVLbng3RXlTRUxua1NDaDRUdkdpbmtLNEtJcmZLUEJ6?=
 =?utf-8?B?V1l2WCtNSDZTSDNjWkpLN2VKeGNTLzhxU0xGUUM2Yjc1VDRaUXpZeTUxamtH?=
 =?utf-8?B?VnVMVjA0ckVRRHkwTFhTS0lmVFpnRmg4V1JpWGlNVmNNUG5YQ1l2WG9KQmRL?=
 =?utf-8?B?UkRPNzR3bE54MzlmTFl1ZTh3ZEhETHU1YUUrTkJZeFdaUFNkbDRSVzZQL0Fu?=
 =?utf-8?B?TlIvd3hDcXhlYlA2T1BWeWNtSVRtQWZtd1VOVUlabGZtSzM5L0lxY3dkb3VP?=
 =?utf-8?B?TE5kS0JuVEtlWldSK2Z4ZzhNdHNWMXloMlZmZU43aW95OWhvR3FiM2E5bEhv?=
 =?utf-8?B?dlJhWWV3YUdHam9mdlpEM0kvMjlLZ0RaN3Jqdkw3SlZNM3BJWjQ1N1FzamxH?=
 =?utf-8?B?dkkzbHI4ZUlNUk8yMTZwQi9FK2RyRUt0b25GQ1hVaDUyeVp2NzRnd0JDV2Zj?=
 =?utf-8?B?WW5RTGg2enRQdkJ3Um5EZnBXMlh3UXVNaFhCdlJjdXlsSFQ3bzNFSXVIa2FH?=
 =?utf-8?B?OXFRbGxGTndUUjZUWWNCN1k3VnVUN001VDV2OHFSMHJXM1J1Tk9zM3diRENq?=
 =?utf-8?B?QWtaVVlsaW5QQzdKSFdLcHQ4eXZVTk44M0xyVUFoL1c5ZGtIQlVVYjFWN09X?=
 =?utf-8?B?TlJBeDl0RlpBUmxuMlBSbiswbytLaGtybUJtSEREdUlKZ09JWTB3MlkwaGdt?=
 =?utf-8?B?STFhamI3VlcyNkFaNGZSR1JBekExYWI2dCtKR2VhSENUOFEza1FEckM3YW9O?=
 =?utf-8?B?REVCV1B3VlhvVXJJaXQxaW1tOHZaSTFBT0k0SUJJbzBUcElON0JGRzAySFlp?=
 =?utf-8?B?R3lpbmZ2TUV4bnlCZi9OSFdUL3NYVHoxUVdDK3FQbkRIRm81YUkvTjR6ejF1?=
 =?utf-8?B?WHo2bEYyYkEvUzZGT2Z6NW1SUDNMN0VtNlFJVklkay9uek5kbmZrTDFQajg2?=
 =?utf-8?B?amsvc0NqNjRDYXJQRmwrUjFYd2hHeXBLREQ3TzFnZkdQS3lwZVRCT1JuR1Zx?=
 =?utf-8?B?eVZwS0pTdlJZQ21kdEE2Wmo4TDhkYmFQMXNjakJ5TkpCR0x0a2hXbFIwVE5W?=
 =?utf-8?B?OHNzOE5qa1dYY21tN1lkSFhQQ2pCNVFUV2RyRnlrRExXV0Ztd1h1RS9QWnU4?=
 =?utf-8?B?NjE4c3BNR2R4Vm1ZK1BzVUo3YXdYV3pCMXNrWGZxZ1cwWS9kZTUxZXlTQ3VY?=
 =?utf-8?B?bEFVNWZpeG9lS3ZGYnJsdmFHZVJMWkVtcU1MUWlvbkI3L2JVaTl3SmJhZDh0?=
 =?utf-8?B?QlFMWllEaEp5a2ZiaW5Yek55TitBWFNYNWpWRjh0bmM0RE4xUng0V2w4Ukxy?=
 =?utf-8?B?eElwSVNjOTN3U1h5QUFwbmVRblRvYSs3RTN5UFNlMzdVekJuSFVZazZEdHUv?=
 =?utf-8?B?N2dZeXlycWxhdVVTczJPMDU3VVltSzNrUGNQL0VIUWRGc1VHa3l5d0JybmdP?=
 =?utf-8?B?dkV4dmRaY1J5dkw1ZkFTT3NSK0QreXJOWWhvaDJ5S2FDOHpUS0s5blRrYy9D?=
 =?utf-8?B?YldkOHRNbGp3Vm1BMnpKSjJNcGFyRERCd1pLSm0rWmo3K28rcy9hR2VxMW9Q?=
 =?utf-8?B?YUg1ZWZqaUVkbFdrQlZZRkRUYkRPOWEzWVhZM0xQUEdjNTZwOUd1ZDBVYzgr?=
 =?utf-8?B?bmJJZnJaOHBkQWRJNjJySkx1Um9mWkpFOHZ1bENTN2pyckQzeUE3bXVoRmo5?=
 =?utf-8?B?RFhyOG8yNkxVQk1tWWl1MytKeFB6WU1rVS9hcWE1TGY5WVp3RTZKMkIyUm1u?=
 =?utf-8?B?WEdKRmYzeVBTRTNuSUJQQmtoTCtMR1dReUJqOEFzUG9PemZGNUpSc3NlaS9V?=
 =?utf-8?B?S0VieGU5QVFSTkluUUdGdkl2YWcrYTUxQWE2NzdBS05lVU90NmN6c0hYRmht?=
 =?utf-8?B?dXRPZkZwc0h2S1h5VmJlbjROemQ2bk5FWlhrc2l1Z0hzNkVsUGdYamp0SnFj?=
 =?utf-8?B?WmZOMDAyc1pZclRKL0tvSGtNM1Jsd1JBYklHN2M5SStXZDE1bG1mOXNkbi9K?=
 =?utf-8?Q?AYSQ8p0j0vJZp9yMduH7/1hsC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de3bf5e4-d149-4e0b-904b-08dd4096ca2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2025 18:57:33.7708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1/aIT3npxhiva6x5iGt1i/Exv/Ch9kHxG7xnc7SwXreyTC1bxjXS3JjA8fqHuLPHTcG9vG/BhG30OUe9uENefxDM3c6jilyVWPRPFttFV1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6473

SGkgRnJpZWRlciwNCg0KQ2FuIHlvdSBwbGVhc2UgY3JlYXRlIGEgdGlja2V0IGF0IE1pY3JvY2hp
cCdzIHNpdGUgYW5kIHNoYXJlIGl0IHdpdGggbWU/DQpodHRwczovL21pY3JvY2hpcHN1cHBvcnQu
Zm9yY2UuY29tL3Mvc3VwcG9ydHNlcnZpY2UNCg0KQmVzdCByZWdhcmRzLA0KV29vanVuZw0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZyaWVkZXIgU2NocmVtcGYgPGZy
aWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDI5
LCAyMDI1IDEyOjA4IFBNDQo+IFRvOiBMdWthc3ogTWFqZXdza2kgPGx1a21hQGRlbnguZGU+DQo+
IENjOiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+OyBuZXRkZXZAdmdlci5rZXJuZWwub3Jn
DQo+IFN1YmplY3Q6IFJlOiBLU1o5NDc3IEhTUiBPZmZsb2FkaW5nDQo+IA0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZQ0KPiBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDI5LjAxLjI1IDI6NTggUE0sIEx1
a2FzeiBNYWpld3NraSB3cm90ZToNCj4gPiBIaSBGcmllZGVyLA0KPiA+DQo+ID4+IEhpIEx1a2Fz
eiwNCj4gPj4NCj4gPj4gT24gMjkuMDEuMjUgMTI6MTcgUE0sIEx1a2FzeiBNYWpld3NraSB3cm90
ZToNCj4gPj4+IEhpIEZyaWVkZXIsDQo+ID4+Pg0KPiA+Pj4+IE9uIDI5LjAxLjI1IDg6MjQgQU0s
IEZyaWVkZXIgU2NocmVtcGYgd3JvdGU6DQo+ID4+Pj4+IEhpIEFuZHJldywNCj4gPj4+Pj4NCj4g
Pj4+Pj4gT24gMjguMDEuMjUgNjo1MSBQTSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+ID4+Pj4+PiBP
biBUdWUsIEphbiAyOCwgMjAyNSBhdCAwNToxNDo0NlBNICswMTAwLCBGcmllZGVyIFNjaHJlbXBm
DQo+ID4+Pj4+PiB3cm90ZToNCj4gPj4+Pj4+PiBIaSwNCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IEkn
bSB0cnlpbmcgb3V0IEhTUiBzdXBwb3J0IG9uIEtTWjk0Nzcgd2l0aCB2Ni4xMi4gTXkgc2V0dXAg
bG9va3MNCj4gPj4+Pj4+PiBsaWtlIHRoaXM6DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiArLS0tLS0t
LS0tLS0tLSsgICAgICAgICArLS0tLS0tLS0tLS0tLSsNCj4gPj4+Pj4+PiB8ICAgICAgICAgICAg
IHwgICAgICAgICB8ICAgICAgICAgICAgIHwNCj4gPj4+Pj4+PiB8ICAgTm9kZSBBICAgIHwgICAg
ICAgICB8ICAgTm9kZSBEICAgIHwNCj4gPj4+Pj4+PiB8ICAgICAgICAgICAgIHwgICAgICAgICB8
ICAgICAgICAgICAgIHwNCj4gPj4+Pj4+PiB8ICAgICAgICAgICAgIHwgICAgICAgICB8ICAgICAg
ICAgICAgIHwNCj4gPj4+Pj4+PiB8IExBTjEgICBMQU4yIHwgICAgICAgICB8IExBTjEgICBMQU4y
IHwNCj4gPj4+Pj4+PiArLS0rLS0tLS0tLSstLSsgICAgICAgICArLS0rLS0tLS0tKy0tLSsNCj4g
Pj4+Pj4+PiAgICB8ICAgICAgIHwgICAgICAgICAgICAgICB8ICAgICAgfA0KPiA+Pj4+Pj4+ICAg
IHwgICAgICAgKy0tLS0tLS0tLS0tLS0tLSsgICAgICB8DQo+ID4+Pj4+Pj4gICAgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPj4+Pj4+PiAgICB8ICAgICAgICstLS0tLS0tLS0t
LS0tLS0rICAgICAgfA0KPiA+Pj4+Pj4+ICAgIHwgICAgICAgfCAgICAgICAgICAgICAgIHwgICAg
ICB8DQo+ID4+Pj4+Pj4gKy0tKy0tLS0tLS0rLS0rICAgICAgICAgKy0tKy0tLS0tLSstLS0rDQo+
ID4+Pj4+Pj4gfCBMQU4xICAgTEFOMiB8ICAgICAgICAgfCBMQU4xICAgTEFOMiB8DQo+ID4+Pj4+
Pj4gfCAgICAgICAgICAgICB8ICAgICAgICAgfCAgICAgICAgICAgICB8DQo+ID4+Pj4+Pj4gfCAg
ICAgICAgICAgICB8ICAgICAgICAgfCAgICAgICAgICAgICB8DQo+ID4+Pj4+Pj4gfCAgIE5vZGUg
QiAgICB8ICAgICAgICAgfCAgIE5vZGUgQyAgICB8DQo+ID4+Pj4+Pj4gfCAgICAgICAgICAgICB8
ICAgICAgICAgfCAgICAgICAgICAgICB8DQo+ID4+Pj4+Pj4gKy0tLS0tLS0tLS0tLS0rICAgICAg
ICAgKy0tLS0tLS0tLS0tLS0rDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBPbiBlYWNoIGRldmljZSB0
aGUgTEFOMSBhbmQgTEFOMiBhcmUgYWRkZWQgYXMgSFNSIHNsYXZlcy4gVGhlbiBJDQo+ID4+Pj4+
Pj4gdHJ5IHRvIGRvIHBpbmcgdGVzdHMgYmV0d2VlbiBlYWNoIG9mIHRoZSBIU1IgaW50ZXJmYWNl
cy4NCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IFRoZSByZXN1bHQgaXMgdGhhdCBJIGNhbiByZWFjaCB0
aGUgbmVpZ2hib3Jpbmcgbm9kZXMganVzdCBmaW5lLA0KPiA+Pj4+Pj4+IGJ1dCBJIGNhbid0IHJl
YWNoIHRoZSByZW1vdGUgbm9kZSB0aGF0IG5lZWRzIHBhY2thZ2VzIHRvIGJlDQo+ID4+Pj4+Pj4g
Zm9yd2FyZGVkIHRocm91Z2ggdGhlIG90aGVyIG5vZGVzLiBGb3IgZXhhbXBsZSBJIGNhbid0IHBp
bmcgZnJvbQ0KPiA+Pj4+Pj4+IG5vZGUgQSB0byBDLg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gSSd2
ZSB0cmllZCB0byBkaXNhYmxlIEhXIG9mZmxvYWRpbmcgaW4gdGhlIGRyaXZlciBhbmQgdGhlbg0K
PiA+Pj4+Pj4+IGV2ZXJ5dGhpbmcgc3RhcnRzIHdvcmtpbmcuDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+
PiBJcyB0aGlzIGEgcHJvYmxlbSB3aXRoIEhXIG9mZmxvYWRpbmcgaW4gdGhlIEtTWiBkcml2ZXIs
IG9yIGFtIEkNCj4gPj4+Pj4+PiBtaXNzaW5nIHNvbWV0aGluZyBlc3NlbnRpYWw/DQo+ID4+Pg0K
PiA+Pj4gVGhhbmtzIGZvciBsb29raW5nIGFuZCB0ZXN0aW5nIHN1Y2ggbGFyZ2Ugc2NhbGUgc2V0
dXAuDQo+ID4+Pg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IEhvdyBhcmUgSVAgYWRkcmVzc2VzIGNvbmZp
Z3VyZWQ/IEkgYXNzdW1lIHlvdSBoYXZlIGEgYnJpZGdlLCBMQU4xDQo+ID4+Pj4+PiBhbmQgTEFO
MiBhcmUgbWVtYmVycyBvZiB0aGUgYnJpZGdlLCBhbmQgdGhlIElQIGFkZHJlc3MgaXMgb24gdGhl
DQo+ID4+Pj4+PiBicmlkZ2UgaW50ZXJmYWNlPw0KPiA+Pj4+Pg0KPiA+Pj4+PiBJIGhhdmUgYSBI
U1IgaW50ZXJmYWNlIG9uIGVhY2ggbm9kZSB0aGF0IGNvdmVycyBMQU4xIGFuZCBMQU4yIGFzDQo+
ID4+Pj4+IHNsYXZlcyBhbmQgdGhlIElQIGFkZHJlc3NlcyBhcmUgb24gdGhvc2UgSFNSIGludGVy
ZmFjZXMuIEZvciBub2RlDQo+ID4+Pj4+IEE6DQo+ID4+Pj4+DQo+ID4+Pj4+IGlwIGxpbmsgYWRk
IG5hbWUgaHNyIHR5cGUgaHNyIHNsYXZlMSBsYW4xIHNsYXZlMiBsYW4yIHN1cGVydmlzaW9uDQo+
ID4+Pj4+IDQ1IHZlcnNpb24gMQ0KPiA+Pj4+PiBpcCBhZGRyIGFkZCAxNzIuMjAuMS4xLzI0IGRl
diBoc3INCj4gPj4+Pj4NCj4gPj4+Pj4gVGhlIG90aGVyIG5vZGVzIGhhdmUgdGhlIGFkZHJlc3Nl
cyAxNzIuMjAuMS4yLzI0LCAxNzIuMjAuMS4zLzI0DQo+ID4+Pj4+IGFuZCAxNzIuMjAuMS40LzI0
IHJlc3BlY3RpdmVseS4NCj4gPj4+Pj4NCj4gPj4+Pj4gVGhlbiBvbiBub2RlIEEsIEknbSBkb2lu
ZzoNCj4gPj4+Pj4NCj4gPj4+Pj4gcGluZyAxNzIuMjAuMS4yICMgbmVpZ2hib3Jpbmcgbm9kZSBC
IHdvcmtzDQo+ID4+Pj4+IHBpbmcgMTcyLjIwLjEuNCAjIG5laWdoYm9yaW5nIG5vZGUgRCB3b3Jr
cw0KPiA+Pj4+PiBwaW5nIDE3Mi4yMC4xLjMgIyByZW1vdGUgbm9kZSBDIHdvcmtzIG9ubHkgaWYg
SSBkaXNhYmxlDQo+ID4+Pj4+IG9mZmxvYWRpbmcNCj4gPj4+Pg0KPiA+Pj4+IEJUVywgaXQncyBl
bm91Z2ggdG8gZGlzYWJsZSB0aGUgb2ZmbG9hZGluZyBvZiB0aGUgZm9yd2FyZGluZyBmb3INCj4g
Pj4+PiBIU1IgZnJhbWVzIHRvIG1ha2UgaXQgd29yay4NCj4gPj4+Pg0KPiA+Pj4+IC0tLSBhL2Ry
aXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6OTQ3Ny5jDQo+ID4+Pj4gKysrIGIvZHJpdmVycy9u
ZXQvZHNhL21pY3JvY2hpcC9rc3o5NDc3LmMNCj4gPj4+PiBAQCAtMTI2Nyw3ICsxMjY3LDcgQEAg
aW50IGtzejk0NzdfdGNfY2JzX3NldF9jaW5jKHN0cnVjdCBrc3pfZGV2aWNlDQo+ID4+Pj4gKmRl
diwgaW50IHBvcnQsIHUzMiB2YWwpDQo+ID4+Pj4gICAqIE1vcmVvdmVyLCB0aGUgTkVUSUZfRl9I
V19IU1JfRldEIGZlYXR1cmUgaXMgYWxzbyBlbmFibGVkLCBhcw0KPiA+Pj4+IEhTUiBmcmFtZXMN
Cj4gPj4+PiAgICogY2FuIGJlIGZvcndhcmRlZCBpbiB0aGUgc3dpdGNoIGZhYnJpYyBiZXR3ZWVu
IEhTUiBwb3J0cy4NCj4gPj4+PiAgICovDQo+ID4+Pj4gLSNkZWZpbmUgS1NaOTQ3N19TVVBQT1JU
RURfSFNSX0ZFQVRVUkVTIChORVRJRl9GX0hXX0hTUl9EVVAgfA0KPiA+Pj4+IE5FVElGX0ZfSFdf
SFNSX0ZXRCkNCj4gPj4+PiArI2RlZmluZSBLU1o5NDc3X1NVUFBPUlRFRF9IU1JfRkVBVFVSRVMg
KE5FVElGX0ZfSFdfSFNSX0RVUCkNCj4gPj4+Pg0KPiA+Pj4+ICB2b2lkIGtzejk0NzdfaHNyX2pv
aW4oc3RydWN0IGRzYV9zd2l0Y2ggKmRzLCBpbnQgcG9ydCwgc3RydWN0DQo+ID4+Pj4gbmV0X2Rl
dmljZSAqaHNyKQ0KPiA+Pj4+ICB7DQo+ID4+Pj4gQEAgLTEyNzksMTYgKzEyNzksNiBAQCB2b2lk
IGtzejk0NzdfaHNyX2pvaW4oc3RydWN0IGRzYV9zd2l0Y2ggKmRzLA0KPiA+Pj4+IGludCBwb3J0
LCBzdHJ1Y3QgbmV0X2RldmljZSAqaHNyKQ0KPiA+Pj4+ICAgICAgICAgLyogUHJvZ3JhbSB3aGlj
aCBwb3J0KHMpIHNoYWxsIHN1cHBvcnQgSFNSICovDQo+ID4+Pj4gICAgICAgICBrc3pfcm13MzIo
ZGV2LCBSRUdfSFNSX1BPUlRfTUFQX180LCBCSVQocG9ydCksIEJJVChwb3J0KSk7DQo+ID4+Pj4N
Cj4gPj4+PiAtICAgICAgIC8qIEZvcndhcmQgZnJhbWVzIGJldHdlZW4gSFNSIHBvcnRzIChpLmUu
IGJyaWRnZSB0b2dldGhlcg0KPiA+Pj4+IEhTUiBwb3J0cykgKi8NCj4gPj4+PiAtICAgICAgIGlm
IChkZXYtPmhzcl9wb3J0cykgew0KPiA+Pj4+IC0gICAgICAgICAgICAgICBkc2FfaHNyX2ZvcmVh
Y2hfcG9ydChoc3JfZHAsIGRzLCBoc3IpDQo+ID4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAg
aHNyX3BvcnRzIHw9IEJJVChoc3JfZHAtPmluZGV4KTsNCj4gPj4+PiAtDQo+ID4+Pj4gLSAgICAg
ICAgICAgICAgIGhzcl9wb3J0cyB8PSBCSVQoZHNhX3Vwc3RyZWFtX3BvcnQoZHMsIHBvcnQpKTsN
Cj4gPj4+PiAtICAgICAgICAgICAgICAgZHNhX2hzcl9mb3JlYWNoX3BvcnQoaHNyX2RwLCBkcywg
aHNyKQ0KPiA+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgIGtzejk0NzdfY2ZnX3BvcnRfbWVt
YmVyKGRldiwgaHNyX2RwLT5pbmRleCwNCj4gPj4+PiBoc3JfcG9ydHMpOw0KPiA+Pj4+IC0gICAg
ICAgfQ0KPiA+Pj4+IC0NCj4gPj4+PiAgICAgICAgIGlmICghZGV2LT5oc3JfcG9ydHMpIHsNCj4g
Pj4+PiAgICAgICAgICAgICAgICAgLyogRW5hYmxlIGRpc2NhcmRpbmcgb2YgcmVjZWl2ZWQgSFNS
IGZyYW1lcyAqLw0KPiA+Pj4+ICAgICAgICAgICAgICAgICBrc3pfcmVhZDgoZGV2LCBSRUdfSFNS
X0FMVV9DVFJMXzBfXzEsICZkYXRhKTsNCj4gPj4+DQo+ID4+PiBUaGlzIG1lYW5zIHRoYXQgS1Na
OTQ3NyBmb3J3YXJkaW5nIGlzIGRyb3BwaW5nIGZyYW1lcyB3aGVuIEhXDQo+ID4+PiBhY2NlbGVy
YXRpb24gaXMgdXNlZCAoZm9yIG5vbiAibmVpZ2hib3VyIiBub2RlcykuDQo+ID4+Pg0KPiA+Pj4g
T24gbXkgc2V0dXAgSSBvbmx5IGhhZCAyIEtTWjk0NzcgZGV2ZWwgYm9hcmRzLg0KPiA+Pj4NCj4g
Pj4+IEFuZCBhcyB5b3Ugd3JvdGUgLSB0aGUgU1cgYmFzZWQgb25lIHdvcmtzLCBzbyBleHRlbmRp
bmcNCj4gPj4+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjEyLQ0KPiByYzIv
c291cmNlL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9oc3INCj4gPj4+DQo+ID4+PiB3b3Vs
ZCBub3QgaGVscCBpbiB0aGlzIGNhc2UuDQo+ID4+DQo+ID4+IEkgc2VlLiBXaXRoIHR3byBib2Fy
ZHMgeW91IGNhbid0IHRlc3QgdGhlIGFjY2VsZXJhdGVkIGZvcndhcmRpbmcuIFNvDQo+ID4+IGhv
dyBkaWQgeW91IHRlc3QgdGhlIGZvcndhcmRpbmcgYXQgYWxsPyBPciBhcmUgeW91IHRlbGxpbmcg
bWUsIHRoYXQNCj4gPj4gdGhpcyB3YXMgYWRkZWQgdG8gdGhlIGRyaXZlciB3aXRob3V0IHByaW9y
IHRlc3RpbmcgKHdoaWNoIHNlZW1zIGEgYml0DQo+ID4+IGJvbGQgYW5kIHVudXN1YWwpPw0KPiA+
DQo+ID4gVGhlIHBhY2tldCBmb3J3YXJkaW5nIGlzIGZvciBnZW5lcmF0aW5nIHR3byBmcmFtZXMg
Y29waWVzIG9uIHR3byBIU1INCj4gPiBjb3VwbGVkIHBvcnRzIG9uIGEgc2luZ2xlIEtTWjk0Nzc6
DQo+IA0KPiBJc24ndCB0aGF0IHdoYXQgZHVwbGljYXRpb24gYWthIE5FVElGX0ZfSFdfSFNSX0RV
UCBpcyBmb3I/DQo+IA0KPiA+DQo+ID4NCj4gaHR0cHM6Ly93dzEubWljcm9jaGlwLmNvbS9kb3du
bG9hZHMvYWVtRG9jdW1lbnRzL2RvY3VtZW50cy9VTkcvQXBwbGljYXRpb25Obw0KPiB0ZXMvQXBw
bGljYXRpb25Ob3Rlcy9BTjM0NzQtS1NaOTQ3Ny1IaWdoLUF2YWlsYWJpbGl0eS1TZWFtbGVzcy1S
ZWR1bmRhbmN5LQ0KPiBBcHBsaWNhdGlvbi1Ob3RlLTAwMDAzNDc0QS5wZGYNCj4gPg0KPiA+IFRo
ZSBLU1o5NDc3IGNoaXAgYWxzbyBzdXBwb3J0cyBSWCBwYWNrZXQgZHVwbGljYXRpb24gcmVtb3Zh
bCwgYnV0DQo+ID4gY2Fubm90IGd1YXJhbnRlZSAxMDAlIHN1Y2Nlc3MgKHNvIGFzIGEgZmFsbGJh
Y2sgaXQgaXMgZG9uZSBpbiBTVykuDQo+ID4NCj4gPiBUaGUgaW5mcmFzdHJ1Y3R1cmUgZnJvbToN
Cj4gPg0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni4xMy9zb3VyY2UvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L2hzDQo+IHIvaHNyX3JlZGJveC5zaCNMNTANCj4gPg0K
PiA+IGlzIGVub3VnaCB0byB0ZXN0IEhXIGFjY2VsZXJhdGVkIGZvcndhcmRpbmcgKG9mIEtTWjk0
NzcpIGZyb20gTlMxIGFuZA0KPiA+IE5TMi4NCj4gDQo+IEknbSBub3QgcmVhbGx5IHN1cmUgaWYg
SSBnZXQgaXQuIEluIHRoaXMgc2V0dXAgTlMxIGFuZCBOUzIgYXJlIGNvbm5lY3RlZA0KPiB2aWEg
SFNSIGxpbmsgKHR3byBwaHlzaWNhbCBsaW5rcykuIE9uIG9uZSBzaWRlIHBhY2tldHMgYXJlIHNl
bnQNCj4gZHVwbGljYXRlZCBvbiBib3RoIHBoeXNpY2FsIHBvcnRzLiBPbiB0aGUgcmVjZWl2aW5n
IHNpZGUgdGhlIGR1cGxpY2F0aW9uDQo+IGlzIHJlbW92ZWQgYW5kIG9uZSBwYWNrZXQgaXMgZm9y
d2FyZGVkIHRvIHRoZSBDUFUuDQo+IA0KPiBXaGVyZSBpcyBmb3J3YXJkaW5nIGludm9sdmVkIGhl
cmU/IElzbid0IGZvcndhcmRpbmcgb25seSBmb3IgY2FzZXMgd2l0aA0KPiBvbmUgaW50ZXJtZWRp
YXRlIG5vZGUgYmV0d2VlbiB0aGUgc2VuZGluZyBhbmQgcmVjZWl2aW5nIG5vZGU/DQo+IA0KPiA+
DQo+ID4+DQo+ID4+IEFueXdheSwgZG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zIGZvciBkZWJ1
Z2dpbmcgdGhpcz8gVW5mb3J0dW5hdGVseQ0KPiA+PiBJIGtub3cgYWxtb3N0IG5vdGhpbmcgYWJv
dXQgdGhpcyB0b3BpYy4gQnV0IEkgY2FuIG9mZmVyIHRvIHRlc3Qgb24gbXkNCj4gPj4gc2V0dXAs
IGF0IGxlYXN0IGZvciBub3cuIEkgZG9uJ3Qga25vdyBob3cgbG9uZyBJIHdpbGwgc3RpbGwgaGF2
ZQ0KPiA+PiBhY2Nlc3MgdG8gdGhlIGhhcmR3YXJlLg0KPiA+DQo+ID4gRm9yIHNvbWUgcmVhc29u
IG9ubHkgZnJhbWVzIHRvIG5laWdoYm91cnMgYXJlIGRlbGl2ZXJlZC4NCj4gPg0KPiA+IFNvIHRo
b3NlIGFyZSByZW1vdmVkIGF0IHNvbWUgcG9pbnQgKGVpdGhlciBpbiBLU1o5NDc3IEhXIG9yIGlu
IEhTUg0KPiA+IGRyaXZlciBpdHNlbGYpLg0KPiA+DQo+ID4gRG8geW91IGhhdmUgc29tZSBkdW1w
cyBmcm9tIHRzaGFyay93aXJlc2hhcmsgdG8gc2hhcmU/DQo+ID4NCj4gPj4NCj4gPj4gSWYgd2Ug
Y2FuJ3QgZmluZCBhIHByb3BlciBzb2x1dGlvbiBpbiB0aGUgbG9uZyBydW4sIEkgd2lsbCBwcm9i
YWJseQ0KPiA+PiBzZW5kIGEgcGF0Y2ggdG8gZGlzYWJsZSB0aGUgYWNjZWxlcmF0ZWQgZm9yd2Fy
ZGluZyB0byBhdCBsZWFzdCBtYWtlDQo+ID4+IEhTUiB3b3JrIGJ5IGRlZmF1bHQuDQo+ID4NCj4g
PiBBcyBJJ3ZlIG5vdGVkIGFib3ZlIC0gdGhlIEhXIGFjY2VsZXJhdGVkIGZvcndhcmRpbmcgaXMg
aW4gdGhlIEtTWjk0NzcNCj4gPiBjaGlwLg0KPiANCj4gWWVhaCwgYnV0IGlmIHRoZSBIVyBhY2Nl
bGVyYXRlZCBmb3J3YXJkaW5nIGRvZXNuJ3Qgd29yayBpdCB3b3VsZCBiZQ0KPiBiZXR0ZXIgdG8g
dXNlIG5vIGFjY2VsZXJhdGlvbiBhbmQgaGF2ZSBpdCB3b3JrIGluIFNXIGF0IGxlYXN0IGJ5DQo+
IGRlZmF1bHQsIHJpZ2h0Pw0KPiANCj4gPg0KPiA+IFRoZSBjb2RlIHdoaWNoIHlvdSB1bmNvbW1l
bnQsIGlzIGZvbGxvd2luZyB3aGF0IEkndmUgdW5kZXJzdG9vZCBmcm9tDQo+ID4gdGhlIHN0YW5k
YXJkIChhbmQgbWF5YmUgdGhlIGJ1ZyBpcyBzb21ld2hlcmUgdGhlcmUpLg0KPiANCj4gT2ssIHRo
YW5rcyBmb3IgZXhwbGFpbmluZy4gSSB3aWxsIHNlZSBpZiBJIGNhbiBmaW5kIHNvbWUgdGltZSB0
byBnYXRoZXINCj4gc29tZSBtb3JlIGluZm9ybWF0aW9uIG9uIHRoZSBwcm9ibGVtLg0KDQo=

