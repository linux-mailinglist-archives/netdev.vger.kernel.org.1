Return-Path: <netdev+bounces-284985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KA+YA3yB+2mEbwMAu9opvQ
	(envelope-from <netdev+bounces-284985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 19:59:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1BF4DF1AE
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 19:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E85BD301FB0A
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 17:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF86F4C6EEC;
	Wed,  6 May 2026 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T+bmfcLF"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013042.outbound.protection.outlook.com [40.107.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C7237F8D6
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 17:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778090038; cv=fail; b=owwNloxkvFR/2xboSbJA90V4IvsMeNHXEpj9BLlEoE4X4WfBNGpusFBF0eKROZYmMJrABIWqe1I+fRnyAo6iNuxaHkBX2/euUYAWggJy5W/xd1HHvN2gPaaVJOlN4T/1euI3YRURCJm27KyTR03J/gjrkpXOSTGthypYgnzLe4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778090038; c=relaxed/simple;
	bh=gYlNUI5nJEbEhdH0M0Yi/KJQl9xp8veb3NLHNgTv5wY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OEj/4uxR9IQe1A7RYbmjvLd7BGpyssgG+r/jLEsAVtiCSK0VMiW52EpxHv298PXFmfQTRPbwCIKBQAn6DPGqThhnjwbFPQjXjsq9uA8Y8ebS8f4ZYx/6FTPxYxVGtLoEXvR62KFeF+3mr/4npPv3tHz9UZPvaddYNvrYJJjMdbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T+bmfcLF; arc=fail smtp.client-ip=40.107.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNrJZMM3LyyaYF8eo4q2EIA84ml6j1vVGbz0iijudoikB8SJzd43qtH73AY8T004kbPMGat4jyx5l7SC1M3F/oQzYeQOStuVFmw7UHaEjW+Z5DFLdMtbFXTZRpWk2exkNVXbVqfD0DnMZEsa6DSeFc1VFqFkFROUm733pkARw8CPHVgZ1wsN9oj9HagiCHVZS8eO0b+NR+mNJ16iF0BDJMYqvOCQKvIY/0ADgNCeqLQ2iecZe2ImY6YEK1KpkiliDPe18di58nGSWbvxwgAni7VFL4gdeHV6y5eqyZfMon2CeXVKSoY1QBY348hDUaHeejyYtsRBfTEL4rxYhoE1mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYlNUI5nJEbEhdH0M0Yi/KJQl9xp8veb3NLHNgTv5wY=;
 b=BHEzWu7aVXv4CTJLiSFHfY9njM3rVL2hIyJN77iNhpD/5ll7nNL2YtP1OzNEUiapnKgepxD+AamU5VREKSAIU9s9Rn/v6alk+yPUb8IvRCItNq1SrFaXpBsW7lQN3ZRoY1IO+MM0pi0sS3bX6DMGFlZmW9vX/zOizC44n/GMuoqcLiru/QS4aLGBWwZMsZwLySgH1ioI5xeAta7JTaSwY4BPmiRB/V/oANiET+aSfVt5Bg3L1e3+vm6UWZpQBZyfTevS6rQ7D7Yvtsq2i6eBmEmMl30iV75Z8sXcID4uncN60GlH7MocFcSUkX+LmxP4OSLqJAItupWPxMQUutnuMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYlNUI5nJEbEhdH0M0Yi/KJQl9xp8veb3NLHNgTv5wY=;
 b=T+bmfcLFpwu2jB64GC7lLnEdVVBhguhAPjfE2epx69I6zsDLBdDSclwJ/wGjKOTv959uvZ79hNLl7+I5QKd3ioA6FYGc0qLAtf3m1KUIQFkllK+5brLiWOsLWV6sn5kwbh4gXD+Zgu6DMJhjrF9VGeqdlLw40Y3rXyyjSEKhPDaXYbIlQirPupDn33JvK/mUBzC97s+irK8ffrVu7BaNZPx4LTs+Rav/AWzREQfthI2eSN2ewiBiSCa9ZdB4CTXSopH68D+p5l/dSAiOWTw7UweC5jw8JdApIgAWg8ByKMt9P1PwOJ791ixb2cAqWK1N7rkA9PS4m7Nn5/9jgWTINw==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by DS0PR12MB8198.namprd12.prod.outlook.com
 (2603:10b6:8:f2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 17:53:47 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d512:9f9:1c70:e24e]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d512:9f9:1c70:e24e%6]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 17:53:47 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "dsahern@kernel.org" <dsahern@kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
CC: "horms@kernel.org" <horms@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net-next v2] ipv4: Flush the FIB once per dev nexthop
 removal
Thread-Topic: [PATCH net-next v2] ipv4: Flush the FIB once per dev nexthop
 removal
Thread-Index: AQHc3TqceY/zeIsbY0aD3ghVxE73DrYA9nOAgAA5JACAABh+AA==
Date: Wed, 6 May 2026 17:53:46 +0000
Message-ID: <3db4a02d61809143cc19a20cd6ff4086bb06b65b.camel@nvidia.com>
References: <20260506092704.150349-1-cratiu@nvidia.com>
	 <20260506130129.GA665477@shredder>
	 <8fea4084-c9ec-472a-b8ab-ecc87e537216@kernel.org>
In-Reply-To: <8fea4084-c9ec-472a-b8ab-ecc87e537216@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|DS0PR12MB8198:EE_
x-ms-office365-filtering-correlation-id: 8f53d25a-28f9-46e2-7a1c-08deab986c06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|38070700021|56012099003;
x-microsoft-antispam-message-info:
 nUOdp2XYWXA2LT8Sawv5dr2NfgiOyRoW1qvG9sAzJRzsW1U2s+D9g+bRavqXXvdWGYduvtGnmRWSgoFDeYPcSPi2vt2CRJEbRs5swN87Wn5rUhg3657jvM/S9oKJNmURgifBa8sHXjALsH+XEhvT/xAIT7siRmgwZ07JGnpt+KkeRuYVaoEHZMydrn7s2i/AXDeBm1ANH5rkWG+EKGjuYu2YX8KPeq0la3qJY6VE1tYhz0vyeR8JvcYF/KJIBbPlXhE6hvJCrtkSU36RM717XhDcZMCqiE/jOmVQIWqHpp8MHmGFcC1hfluGP7Rt/P1/EPZcKGcpOt0qvYlKKGNYlndi9h/4N5EnWGpBkHfrKrnJ1/YBaAmW2d7yneV0fZ45rQyO6qwkxAUr2Zu9WBrgqenM6DL/7uHw1vCam0OB/Blhc6WcK9KVrYrr8y9fnfv/cMv/0iCK/YkmGPVd5IG2vmoEc4qB1FsQCSIOAed4r/1qERNEEFBtFzUSLS6O4Szqn5DnFvqr2w9ps1CeABngTGb3cQ/qTZoocJJ+ZWj3OCOH9VYAW9eOhoNRd5XKDVRBE6NI1ESB0vuDiLZtc0I1tjK3+Z+75XyeO/+ro7sfqGqXZOhfj9HPGlt5l0W2rbjiHE0ZS+F/PSnQDn+HPzmJUqQOkLU8Y+xIhlYNay9i+N9bijD5XFBHNY/NamOSl5EbARbVyY8O06phplFIkgxjeNbiFq8SLVYv/0zJtiY5tMIHBTrOz2+/toAto/gra/s2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bnNKUnVjblNpTVVvbVVuUkhxVGRJckY0RnZFU0RJSDlEL29MS05LVnBuWXYr?=
 =?utf-8?B?am9jblJXM2pqZDdQbHUvYjV1WnJ6VFI3NWYxcG9uZTFZRWM1MDFjTW91akty?=
 =?utf-8?B?anp5bWVScmV0cHBJeTBTbzJDNTloaGZZVmJkanpxY1F0TFVPNDExK3pYeGM3?=
 =?utf-8?B?aXFIRWtNSU5tM1RYVUxkYWtTWFd2ZEVuMVhSTWgrOWQ0VzlsMFhzc1YxZm9G?=
 =?utf-8?B?RzdKSUdLb3NSdFBwNkJCd1c1bzhJcVVtQStEeGNteis1MCt6QitpRHhmTVVU?=
 =?utf-8?B?OHgrcUtHZFFPcG0xaCtjSGdRdThUTEVJOXBxRm5uc3h6cnVWUC9GOVJRVUVy?=
 =?utf-8?B?amxtcW5LS2ZiT2lPUlg4Rmx1RklOeTZvSWo4UUpNRDg0aWQ5VDZHeXFrMGFO?=
 =?utf-8?B?MXh0R2V5OTdlN3hDK2RXYnNuanBreHRwYzlobTA2RXpYUWlKdFVLUjliL25r?=
 =?utf-8?B?aGRIYmdUc3JpZ28zbi81ZW9kTGlHeTEyT3JncS8zNXRHNC8xOHUwaXBCRWxo?=
 =?utf-8?B?Smp2eHk3clBvYjVMaFNlNzJVYXc4ZkpmdEdrb2FRRkYzcSt2OXZxcHhoL2Ja?=
 =?utf-8?B?Q0RicDB6Rnk2d1ljcjBNTndob2Q2WHdkTWhsOEZ3cDJtY2kwZHVWb1BjT2tK?=
 =?utf-8?B?ZFYycWY3dVhFRFpLMlFac3V1UHZFUzJ4RTlyR2lDbFZieEFHTk9PclhtQW1E?=
 =?utf-8?B?ME9rZTI1OUZ3TlJCdkEwRzhIWFdvVkxXRDladEZaRHpEeVR0WEFldExPcU9h?=
 =?utf-8?B?SVcyZVpuK1pXbmtkaWhJT2s5eS9JQzlFanZPTGFmdWtVczN6UytmeUpZNHZC?=
 =?utf-8?B?WjBCQVVCY0xwMTRSS1NEc3VCajdRU1I0WjZLMVNFWG1xOXI3MFAxWlBaeG9S?=
 =?utf-8?B?Ymt6ZHo1K2QxclR4S042a1E5bGJ6TkhHU25GSi80SDhSSlRObXBXVW4vK1l0?=
 =?utf-8?B?KzdLSEJZTndJSy9QWmpMOGQ0UE9EWWhMR1J4d2Zxd1pYaGtLdXNZL3JsRVA4?=
 =?utf-8?B?V0NkRVhsbXg0SmtkTFlITjg3RUpWNWhZV0IvV0R1blE2NkgrVWJQNW9wYitw?=
 =?utf-8?B?bFgyV09nSGljQk1ESi9rUjZTWUlFak9vNEpzak1pb0JhMlJSOWpubEpGRXJ3?=
 =?utf-8?B?Y3pIcWpHS2hmd3Y4REx4YkppUTBsYlNrTXNCRjcrV1ZUUENHZ3dwdHlKNkNn?=
 =?utf-8?B?dEZDcFRxYjBBNzV5MCtMblBhRVBsWVV4ajQ3RVZOaWt1S1RyZlJIQXk0dlEz?=
 =?utf-8?B?aW0zVFVFeHlXeXQ2VDhzY0Y1VDZuaVYwZXA0ZEcya0RRSkpuc1o5MlNyTXhz?=
 =?utf-8?B?dy95eUwrVWR4eHlzOXJGQ1g4NmpDRktXRVRwd3VHL1BmU2RLSVFlanhsSTNw?=
 =?utf-8?B?NERqOWt4QXZGSXFvZ2xOamRQWUE5c0NYVWg0WXZGb2RObndNN09ZRTF1Vlk3?=
 =?utf-8?B?aGtzUWlsTkRSSCtId2R5dFEvYVpCYkJGMlRzcUs0T2lqTjB2cFViZGNVekN5?=
 =?utf-8?B?MzA0bzQ0M2JBd2c1Q2FpYVByWjZQMDIyRmZ4b1BMcGoxOVFTZXU4ekdINDh0?=
 =?utf-8?B?M0MrQkw4QlVtcUM4ZSttTVdmOGYxZFpQS3NGVi9iNGFUQnJ1eW5JMU5WVUJX?=
 =?utf-8?B?R1ZHM3JhVTJlY1daSlNEUnhwZ3l5S3hoUkZKa1htMERkTyttcUtFNlBoT2Nl?=
 =?utf-8?B?ZlVIV21DTnNQcW84ZHFhLzZHc05rcGFNZlRZVk9mVG40NGRxT3pac0tMMTkr?=
 =?utf-8?B?L2ZGNEpnc01Mclkzd3pPMDVGRkFBd1RlVDU0bXZLYi95YTlVU2kxRUFBb2ZJ?=
 =?utf-8?B?NnpIVXdPY1B3K0RTR1BCYk9wYjNhaStOOFcvWEszeUtFam5rTXFreHRUMUNP?=
 =?utf-8?B?ZFVXaUVwUUpOMHlLeUpyMzNtQ0FBalQyR0lnaVFLTmV4V0hscXVRTUdCclhl?=
 =?utf-8?B?QzlOQ0ZoVzA5SWgxQURCWUlTR1VQbEtzVFMyVWp1dEpTdi8rcURPVTh1eGxq?=
 =?utf-8?B?ZDluUEdMb1M2c0lDNzRvYjdaSTBMOWl4ai9TbDNPSkJyYnFzMzg0N3o2WUNP?=
 =?utf-8?B?NkJuNDh3Q0dzOGtLaGJPeFBNNHY2UDBrMDhuT1d2OUR6QmVSTGxxNTg3VXdi?=
 =?utf-8?B?VVhGcXRWZ0UvOHkzaC9senhWUHgrNjdBT3E1NFNGbU84c2p3T3lXdm1LbXdv?=
 =?utf-8?B?TjBKVUQ0M2VxWWtIQ2hmV0NPQlc2TTg2UUlySWFHczJPWTROd1poeHRTMWZM?=
 =?utf-8?B?WU0xZCtFZWEvdWZjRklkTWVmdy9FN1VqVEhHdmRZOVo3bEFFTWJzT3BuL21E?=
 =?utf-8?B?c1FQaG9aazRHOGN1MENtQmRyTlBZZTVsS2NpRURmTlBnRkJBbTU0UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF1BE885A74FB243A4ED1CE161F576B3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f53d25a-28f9-46e2-7a1c-08deab986c06
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 17:53:46.8373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T7voL3bg13IXJZPvqtzHuDU5XurUBPa+bzifdzXkmdIKi2/QkYspOn/ELsLZ+cXyaOIMD+tKGVpZELcqhr0cSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8198
X-Rspamd-Queue-Id: 1C1BF4DF1AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284985-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:replyto,nvidia.com:mid,Nvidia.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_EQ_FROM(0.00)[]

T24gV2VkLCAyMDI2LTA1LTA2IGF0IDEwOjI2IC0wNjAwLCBEYXZpZCBBaGVybiB3cm90ZToNCj4g
T24gNS82LzI2IDc6MDEgQU0sIElkbyBTY2hpbW1lbCB3cm90ZToNCj4gPiAuLi4gaXQgd291bGQg
aGF2ZSBiZWVuIGVhc2llciB0byByZXZpZXcgaWYgc3BsaXQgaW50bw0KPiA+IG11bHRpcGxlIHBh
dGNoZXMgKG5vdCBzYXlpbmcgeW91IHNob3VsZCBkbyBpdCkuIFNvbWV0aGluZyBsaWtlOg0KPiA+
IA0KPiA+IDEuIENoYW5nZSB0aGUgdmFyaW91cyBuZXh0aG9wIHJlbW92ZSBmdW5jdGlvbnMgdG8g
cmV0dXJuIGFuDQo+ID4gaW5kaWNhdGlvbiBpZg0KPiA+IGZsdXNoaW5nIGlzIHJlcXVpcmVkLCBi
dXQga2VlcCBkb2luZyB0aGUgZmx1c2hpbmcgaW4NCj4gPiBfX3JlbW92ZV9uZXh0aG9wX2ZpYigp
LiBSZWZlcnJpbmcgdG8gdGhlc2UgZnVuY3Rpb25zOg0KPiA+IA0KPiA+IHJlbW92ZV9uZXh0aG9w
KCkNCj4gPiBfX3JlbW92ZV9uZXh0aG9wKCkNCj4gPiBfX3JlbW92ZV9uZXh0aG9wX2ZpYigpDQo+
ID4gcmVtb3ZlX25leHRob3BfZnJvbV9ncm91cHMoKQ0KPiA+IHJlbW92ZV9uaF9ncnBfZW50cnko
KQ0KPiA+IA0KPiA+IDIuIEFjdCB1cG9uIHRoZSBmbHVzaGluZyBpbmRpY2F0aW9uIGluIHRoZSB2
YXJpb3VzIGNhbGxlcnMgb2YNCj4gPiByZW1vdmVfbmV4dGhvcCgpIGFuZCByZW1vdmUgdGhlIGZs
dXNoaW5nIGZyb20NCj4gPiBfX3JlbW92ZV9uZXh0aG9wX2ZpYigpLg0KPiA+IA0KPiA+IDMuIEFk
ZCBfX211c3RfY2hlY2sgYW5ub3RhdGlvbnMuDQo+ID4gDQo+IA0KPiArMS4gQWx3YXlzIHNlbmQg
dGhlIHNtYWxsZXN0IHBhdGNoZXMgcG9zc2libGUgdG8gZXZvbHZlIHRoZSBjb2RlLg0KPiBNYWtl
DQo+IGl0IGVhc3kgZm9yIHJldmlld2VycyAtIGFuZCB5b3Vyc2VsZiBzaG91bGQgeW91IGludHJv
ZHVjZSBhbiBpbnRlbmRlZA0KPiBzaWRlIGVmZmVjdC4NCg0KSSBkaWRuJ3Qgc3BsaXQgaXQgYXMg
dGhlIHdob2xlIHRoaW5nIGlzIHRpZ2h0bHkgY291cGxlZCBhY3Jvc3MgbXVsdGlwbGUNCmZ1bmN0
aW9ucywgYnV0IEkgd2lsbCBzZW5kIFYzIHRvbW9ycm93IHNwbGl0IGFsb25nIHRoZSBsaW5lcyBJ
ZG8NCnN1Z2dlc3RlZC4NCg0KVGhhbmsgeW91IGZvciB0YWtpbmcgYSBsb29rIQ0KDQpDb3NtaW4u
DQo=

