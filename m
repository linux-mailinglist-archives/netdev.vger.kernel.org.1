Return-Path: <netdev+bounces-274528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDhGHDxnzmlRngYAu9opvQ
	(envelope-from <netdev+bounces-274528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:55:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C34FF38947B
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33E353069016
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 12:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5E33E122B;
	Thu,  2 Apr 2026 12:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="xBMmrwB9"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020110.outbound.protection.outlook.com [52.101.69.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873FB3E122C;
	Thu,  2 Apr 2026 12:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775134148; cv=fail; b=UqquiLC9MiuevUAh63YfRIfZlW2IuVeAbljCLCEnO1dPfs7qYxNA6K7ASlNKV5HnvE7oaEbNyw1EaugIEeQMT1UYa9ouGr0rCcUB7Hkg5MKRbnJgey5rRUUn0QZYumzFolI9OBTRdY16BcXxi2josmK5YcsZ9WQelyZq+Po1d34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775134148; c=relaxed/simple;
	bh=dZpp+v+NvnMuoL+S2UBJnuwi/HN7XgVx/7B5md9nmpQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jrub+cs89UgEB/W79J6ZIoRP+zdr/yLYrrgUW1g4RKPtc5lR7B0df+sfSiPEufOGN3VX5iHtlIBScMBLGMlQIywuBEZi3fpbOC3dB/COiD4WghxXM2zpjhoD2OfMYiqn4rd3YEblZIMEN/v/fkGFPHRAOY1bQlSltAY/ilSBYu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=xBMmrwB9; arc=fail smtp.client-ip=52.101.69.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jtj9WCIO+IE5LTfI9V0UHyaarjQsvDCadh0DwR4Vh9Fw85LTEq517YSZT0y/1CgxXsZun+mqMvv3QRH6D+h7/sJ8ktqMUXlfLcU7djcvJ0kg4/t7vnCmbc2ge8Bwsvap76VRcX4ky7XA9KM/EyzoQBQj8MIqmZvuj4oPlLBr7U2169dLuyiox1SFBL4glRSz23fpr5Q2yWN0nF9GegWIJ0IRj5OK23VWCR3zFrdexvhpVev1+YD0r0CGUQIZ88V9ACiEtpaN1JlCVE7gMIwL0bjZAUDNyqSLnyW2oSfbzmSy5RGTh2yw/fncH337oVUoC3W8Ii+xt35Am0WKvOq7Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2o3SPqTmcn3l6LGb5sFGHUQTJur8pqydZw6gS9sDwHQ=;
 b=CNsUtxS3TyKUBprljsGuMjGrzZHEpXWeo0V2FbQJz1ep4T6ZoLujlxq/YVtPBn16ggvMVgBgw0I7a0FMh3nUa0dwxYWD7QUb4Jn7qKQ5DfMn0VxM2U6bShVJ5JKkYbjB5hP+4WN/YZbrBcvLZYitSrRzfs6rQOWSYp0cCka0608LsQLirOCNC8nsh1aUl0IOfu52tf+Q/Q6in4qKN4+bsOoSjIpBxlqQU1IKBe/no3Elyr7pJU27wcpqCgWZqIXbmSjba9FkT1Gmm3e1tT00IlUn/6cyuUTXGipzvzDB1wJvoVLpDA2yyeXJukuzsuRPo6tQVnRRivfH3k/dSYKvSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2o3SPqTmcn3l6LGb5sFGHUQTJur8pqydZw6gS9sDwHQ=;
 b=xBMmrwB9U9Xu8mOBivvENtUuICVj8z2r1gklgiJ+NgRL7e18Wgu/45PC0DBtwLIzL87MmS3Ai5O7saLAp/KkoauFueG8Esco3FxTeawHN88hOf8H9XvkJoBgZWevzAUpLObW+wK/yCAYJfEnGzouW8icdCWUvlSkX41Ai9xOcDsEGXoKy60mrsD8BDFaYbWqZ9ed9np68bqlp1s4VS4Y5k6rc8Qi+LW4XXdIXxZAhDutuiL9yjTX2oj6ALeI+IdlbEMsEmuo7AlOJ/DhCglehKwGhao2ckW3Bf0g9y3kWax3IThUfrE4jYmULRXVDVs7c2PP68hmorggBb2L1N/5qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PA6PR08MB10708.eurprd08.prod.outlook.com
 (2603:10a6:102:3c7::20) by VI0PR08MB10942.eurprd08.prod.outlook.com
 (2603:10a6:800:253::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 2 Apr
 2026 12:48:57 +0000
Received: from PA6PR08MB10708.eurprd08.prod.outlook.com
 ([fe80::1999:c6db:dc55:494a]) by PA6PR08MB10708.eurprd08.prod.outlook.com
 ([fe80::1999:c6db:dc55:494a%6]) with mapi id 15.20.9745.022; Thu, 2 Apr 2026
 12:48:57 +0000
Message-ID: <3fde6bbc-09bd-4543-bbd0-8df1f7eda6a2@virtuozzo.com>
Date: Thu, 2 Apr 2026 14:48:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] gcov: use -fprofile-update=atomic globally to fix
 concurrent access crashes on GCOV-enabled kernels
To: Jakub Kicinski <kuba@kernel.org>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>,
 Mikhail Zaslonko <zaslonko@linux.ibm.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Masahiro Yamada <masahiroy@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Vasileios Almpanis
 <vasileios.almpanis@virtuozzo.com>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Arnd Bergmann <arnd@arndb.de>
References: <20260401142020.1434243-1-khorenko@virtuozzo.com>
 <20260401184625.2641899d@kernel.org>
Content-Language: en-US, ru, sr
From: Konstantin Khorenko <khorenko@virtuozzo.com>
In-Reply-To: <20260401184625.2641899d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0024.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::16) To PA6PR08MB10708.eurprd08.prod.outlook.com
 (2603:10a6:102:3c7::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR08MB10708:EE_|VI0PR08MB10942:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a4290e-7f18-4bc5-81bf-08de90b634ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|13003099007|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WRzYTux+pHwS/6+SHmbqZV/X+h0eXFYRcjC7WpXemqKenxbi9Pr5UhBtC723v+F/FGdB/EdS3b78FJEpOBRJywtJcidRPPujhZsSfYj8+oQxlW4DkUcyDkV0SKF6H6Go/1ay0TI/R0XxYYq+Hd++u01hYU1aWD9xW5E9PghFf77oFfIbB37X5rhfc+Weg9pjmoJ/pYllChwdApFGfSPcDjfddQLiAOSrogOfAOmlUOyvHH80LLY8q9nBHt5KhLkw0cI/AUxjHLD/u2WBn8UEIbvVWD89s1fkDjtNWJNAQfXioZrh+8qFOgdgs7qMdpPnRQWUWYyBW5+Froo86VOOe4nMhnrW3uWPCWJR2qDEyJcG8tzL9NmWBFI8Dk6SU6QjzSwyUrZ14YanVxncQQLmrRn3eSe8iLwq9Xur6CgdbqctZijJDvD0zvsLGFnv7oVyHAAmZoVlwkqqZ+j6ojBbxOAVzotOnayZKLiU6mKmndHMMexTZz2wq57521XZZO+Vqg0BrI7aAa05RVG5lmybkgTdbnG/zN93XxbufmLK3SiTyADRFM6+OhOdZocPtBk984Idi/IzGtOjsOheBE/SARw+ywhyDHA4rgvfef4d33DSBrbGsoIG04mUmZ1N7/0sArxWN8nTBmmkrJ5J/YI9CQsb516JD/lML4ujuzw0G/0o7C8BTazrcysHOp/owsYR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR08MB10708.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(13003099007)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDZVUTlmUHV5bVd5VkhwY3MxQWpOSGxNNGJnZzQzTnRiejFBeGlocmo0bmdy?=
 =?utf-8?B?bHk1VjRTVzNFM1VmYURDdFBjTlFJRTA5Z0lhWUMrY3AzL0VSN3VITE4yUU5F?=
 =?utf-8?B?R2M4ck1MRUFkV0dacldON0hDNkhEYm5VUklRWEtSTnI4S2hqN1ZlYVM2M3Fh?=
 =?utf-8?B?ZEJ4K1VEYnhaSVN6dThKZFhJQ0p3SU1Ddlp5bmdKa2VRMWJpSmt0UFdyMHVu?=
 =?utf-8?B?YkJlWFFsYlZYM0NaeVdmVjM3WXdWQWNQRmkwaWF0Nmk5dEFqWG1Qd3NBTENj?=
 =?utf-8?B?TVhRUGxnUzltZzhxOE5RRmI1VVZUNDVzUCtuc0hUTEJjTzNDWTlTU0RISEZG?=
 =?utf-8?B?VjVYUGRPL0lvdHo3QmN2YW1yOE02dXZwTFM3MzZXT2hzZ0NzUWZ1ays4ZHYw?=
 =?utf-8?B?NHdmTEhPcGVqTHZWa21zemw4Sk9DVkhBSVFDYnEyRDZOdEd1eFBKVWFnaHRs?=
 =?utf-8?B?NG5MWGc1bHo4QlplaHdubHM4eEIvTjVScnAzS3lxK3c4SHJZNmdtMFJjVXZZ?=
 =?utf-8?B?NVF4WUcxQlFEdERpcnFFdGlKUmxUSTNjYThFNTd2UWVDY0dkRVBRUU4vSVVU?=
 =?utf-8?B?UW5YMTJmTjYxL1lnTXBPM3I4alFvR0Rwekc1dXgvS3hYK1NhR3FiQmVUMmV6?=
 =?utf-8?B?cXIzMW9mbzNLcGZaaW40NS92SEJ2RXRHS0NrTHhKNzZ3cVl3RnR0dTJyeEdM?=
 =?utf-8?B?QldHYU9tVVc2U3E4T3EzSnhJdnlwWUZyak5nK3hJZEZZQVQycjZwT1B2TFVi?=
 =?utf-8?B?UUhvUEhPbTBQUUZYWmh2dWR2bzlLYk5KRE14UFhpcHYwb1dlU1RTaXJmUmIz?=
 =?utf-8?B?V2hmZWM0WHFTeDA1dkFiRmxUSjFwSkZOWjdxOGU3cXZ2UmdUWDdOZ1ErR0tX?=
 =?utf-8?B?U0JkWnN0dTRjOENwVkgxSVBQeUd5RFBsbHA5L25VV0hCalBBWDRJdUhRbWkx?=
 =?utf-8?B?cnROZlZqZm94Z00xMXN3UkhMbGJEU0pZb1d0TEp2VFk5UlZEaHFDejBEZmhy?=
 =?utf-8?B?cEI5UjNhMUNmaS92aUhUaU5XcUp0UDdoRmNyZVB4YlVnOGgvOWw4T1lDVHY2?=
 =?utf-8?B?d0dqcExORlA3L1RlOFQ0ZFBqRS82K2IxT1pvRXdBMSt6N2RMa255dnVFbm1q?=
 =?utf-8?B?cDA0eEZ1Y1RXMG10a2gybmwxRlVVV1ZtTGlMckRuWEVidzJicHBjNGF2U2Rm?=
 =?utf-8?B?TzlGZk8vZi9kMnVaamlhVWl5UzRpVW9FOElMSnpQSDc4eGNteW5YVHRPbm45?=
 =?utf-8?B?YVJraWxVY2grOFFkNDZGek9NZVpmaTZGR0YrcGkyTnFTdDBpeUJLM1RSNTdQ?=
 =?utf-8?B?cGpjbytnYjFBcndCK3VQL2NoeTVYTUhUYnNQV1daVzd5MkcyNWZGMXFIM2F3?=
 =?utf-8?B?andhUmtuOStyejZramhvbDRMOEd1SHFWekRUQjNGQTZQZUZ4cmFKd0U2Y01u?=
 =?utf-8?B?MDBzVGgvRHV4cXdpNFhsSE12b3pRYk1oMWVuaGtaTTI4dzMwRFkvRUFqTnAx?=
 =?utf-8?B?a3NNVE93T1FDaEtvK0gzUU5KelNJbUhRVmFkdWJKNUt1cklrbkVaV3ZRUDVx?=
 =?utf-8?B?SHJzQ0w4K0FIZ1RTak1Nc1lWU1V3dlBaQXpoMWNLNnpWbUo3RTRKbk5PMHdr?=
 =?utf-8?B?RHMyUm9IQUdVYVVOczIvQkc2VUs1VTRhYWw5Qy9KSUYzTWFSSDRGU2h3TG5m?=
 =?utf-8?B?c3Mva1ZjMW55Z3RUbFJpTnJ4Y3NkalRnQjAzLzVmZkJsY285NU9UYTFBWHVa?=
 =?utf-8?B?ZWhhdjNOa2RrejdzbWZKQ3E4NlBCYzErRTJleTVUaG9OUzRCazlHQnp5cGx3?=
 =?utf-8?B?MlZHQkFESGp1QUxRZHY5N1pQMG1lQWUwVk1UcnBkbndjTWN6M2FHY2M1NHJs?=
 =?utf-8?B?VzdUN0c0dGlZYTZyVFdsdUg5R090Y2c1bHc4UEhHZ0szOCtjVkJYTkpjTGhL?=
 =?utf-8?B?QVhMYXBnbkdvS3pSTGh3RisrRjFWdlBYbkZ3bmJGU2tDTmd1SjRPT05HM1Fa?=
 =?utf-8?B?eitXenY4YU0xSGFpTnhxd2VWT05ZUXpRYXBvTkNDaUhYd21zMnZxVkdzNzdJ?=
 =?utf-8?B?MVRUa1YrRVhOVlRyTFlTbG9YV2tSNUl0bnNadWFVVXg1VzhyVkFVanJETWtm?=
 =?utf-8?B?WlJTb0tYV08zYzcrUmRNL05aczZPemY3NzBodFNHcWZFdDl1YVE2WHNyWFV6?=
 =?utf-8?B?VC9rLzVyRmVXZ1RkV3JUOGNYL2JCeXVoL1JMYlA0Q0pnejZSdVN5QU9ZaVJU?=
 =?utf-8?B?c2g4WnlVTUY5NE94RWk1TTRRdDVWL0laR3dBeGo4dGJQa0RyZFRHQjJ1QUlI?=
 =?utf-8?B?Z2FXQmxyUElzRE5pY2pHNldHZTJWUkJoVE9neGFEMVR2VHdsZm5Tdz09?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a4290e-7f18-4bc5-81bf-08de90b634ad
X-MS-Exchange-CrossTenant-AuthSource: PA6PR08MB10708.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 12:48:57.7040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RtvOWWiN4Ut42/0bwgGHeRIPLSYdUn4jVES1YiMzpXx5T739lOLq5V6AMwDnsznffPRW3jIx6p2YmC1GS9OfgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10942
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274528-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khorenko@virtuozzo.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,virtuozzo.com:dkim,virtuozzo.com:mid]
X-Rspamd-Queue-Id: C34FF38947B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/2/26 03:46, Jakub Kicinski wrote:
> On Wed,  1 Apr 2026 17:20:16 +0300 Konstantin Khorenko wrote:
>> 1. Build fix for CONFIG_GCOV_PROFILE_ALL=y - skb_ext_total_length()
>>     BUILD_BUG_ON failure:
>>     https://lore.kernel.org/lkml/20260331165125.959833-1-khorenko@virtuozzo.com/T/#t
>>
>> 2. Runtime crash fix for zlib inflate_fast() - GCOV counter merging
>>     with loop induction variables caused out-of-bounds writes on SMP:
>>     https://lore.kernel.org/lkml/20260330143256.306326-1-khorenko@virtuozzo.com/T/#t
> 
> Why are you merging these? The should go via different subsystems.
> How do you expect this series to be applied?

You are definitely right, Jakub.

i will create 3 different threads and note explicitly that the last commit should be applied only 
after first 2 series are merged.

Will do right now!

--
Konstantin Khorenko

