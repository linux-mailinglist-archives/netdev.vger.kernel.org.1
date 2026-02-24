Return-Path: <netdev+bounces-260562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAh/FkDEnWnORwQAu9opvQ
	(envelope-from <netdev+bounces-260562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:31:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC24118905A
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C05C302260D
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5523A1E80;
	Tue, 24 Feb 2026 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="V6x3V+5o"
X-Original-To: netdev@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021102.outbound.protection.outlook.com [52.101.125.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1033436405F;
	Tue, 24 Feb 2026 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946896; cv=fail; b=EiLoWlpYFXl4ndrEMGxpkBcLk3mlA8x8RwrZQtpUbyJdb1LtCoZNvQeisZyCu4D6AZ/rnXrN24c8Hkr7JVQ/QzzsHzqhqKfV77y+PKx+cibadOiWzler1GeHxKuzsj9EfDSRvZxkpv/aXGNYuKe6F6+ulsOdUMfp3p51SjmvjNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946896; c=relaxed/simple;
	bh=wYkzjjGIyULVhJeHFh4az4uhsAObrseNmcYpGZ2QxjI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JBBGu0XlCx5EBhN48gNBGZGAepgCR/aphoM2N/jy1PoEmBmLCW3ADmusdHW6kWNtfcK9Lh2pPUTZeSizFpKIUSCxZSe8rjWRbwFeZ8tZny+f1bWzitkjzUttBf6lsyS76ekDE6Ta60xNA0t8+ZEC4EKAC+57G/HutEzbxbxxjUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=V6x3V+5o; arc=fail smtp.client-ip=52.101.125.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Na3qS0KnQTwAJfafs7FSLsWHx+qrOM3uOBFz6ijrwFrmlDP1UyMPvrnjCFZNS3cNXoNm1oyCSA4PPCMIZnNe70QAWY6jwIoKBZBHIMlf2xVA881FW9rHPuY3udZGq2kLGXtw7mtFmlYHay6w5mPCOrMw6/uZ+gkjO+9FhvAXH/bm9XOqXySm2mtcFHbR2t+lOGEkWsXphr0Jmb0wWIMiqNzx/+5gnNoIuL1GlmAqbRe438aSQFBgkr1ENG/WvRp4fcuGvHKdPoCW+ha+R1mcPoOXj9Is5eVTexwZXEyBT51A3xHZu7wJnB7Zf/NqKrDf+FK1GQ4YNhWIQFctsOtTjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJclkj0IlxVJlvk4RF/d0/huWUY+08ygBmcB7A2LKbE=;
 b=WiY0l8vUxvFl65fqlkP5HzRO8lzaYv6znvnhD/hRQQtCD3h3EqZ4C2Q1+62g9nBei8MZ1k09gDqTCjqvbALeJibm8UsFZxjf81ik0NElGx0ETZlBOZ4j7yIDXPBowQVRXryT1LGnqXK1W+OA72f45zEvvi6BDhVmcphWClqYpRomen9YDs+tpTTHjPJREnXa8zH4XxNRwGgZb7ZrFv1QUQtXm9/Xag3CTJ//h/oPx5uAilDrOIR/yEKLOah1Mu1pheZGiUyvgivwV991U0yYxJZBCb+a3I9jbTmYyfNscVW1zSjKRrH+iKl6KL0ASVgPtnleFyzWGYB5gRXvw/n+3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJclkj0IlxVJlvk4RF/d0/huWUY+08ygBmcB7A2LKbE=;
 b=V6x3V+5oZKNp+n4gP51I8e9daChou/Txj0eCy1uEwKdhRgLmvw9WkKoI92rU3uu64D+UsDAh+KHtSNLOb/sR8BAYYiO6DHjXHvB4v+VaGr3JhTdYOZk/bvta/pIPRQI/q6KRtrC8jM+qlbc+jPAIPGn6WNHepY7rx6bq5XQAgtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6904.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:418::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 15:28:12 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 15:28:11 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] net: ntb_netdev: Add Multi-queue support
Date: Wed, 25 Feb 2026 00:28:06 +0900
Message-ID: <20260224152809.1799199-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0030.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::20) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 3df5a0f8-5e57-4e06-d67b-08de73b951ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nYu7YdI2me3Uc0AWhr49XaxGxHgRFyuk0Q+jX7WOfCcnI9u9a8YShPlwi9Mr?=
 =?us-ascii?Q?lASAd31+vhRmpDZh3JM/IMoj8qgQ/mWsaH4iOSFf6H7DjjQATea8CgCjAHF9?=
 =?us-ascii?Q?x93HL32bOxVFpmspZSOadWIdqSblBr+SiWfqK31kxeMpLLunYjR/CrjywPUH?=
 =?us-ascii?Q?tBzgJ6lvNKlVwWILO6dB/5kBMucPy+lECK1WcotyBhK3NeUAIlw5C8Vf0snq?=
 =?us-ascii?Q?94ohvwVxdTo/uFdCjKhLcYhAefD8595cE8yDMPJvZjQJwRyFPxw80pTnfbkO?=
 =?us-ascii?Q?yEkPSSuDXRdvRHoohaelHmCEEjNmnPPAirBpZPvPJJ7LyNZTMnJKT9xWX0Gt?=
 =?us-ascii?Q?mSAbYBlcLFF9C/nmVClG9tEVbfgcg/cJLur84UAEMruCs+LcbyZNADO3R9XT?=
 =?us-ascii?Q?NxRe05a06Kw1o3LuXjb/nxZPeED+liAFF2R/wyp7y7poiAjV2V9LnlG24dP7?=
 =?us-ascii?Q?i+zezOg7TTBcYGSQkFfmQiW+0GU0P24yHweZPCpQmlMWpsWYaZwMZ+9iZp+L?=
 =?us-ascii?Q?SQD7vBfbyP7qrQKtehB9Pbd79V5Lm251arUGZ+aIMOIbK1xzzW0y34hRec6S?=
 =?us-ascii?Q?ETYCvaTE3GNX0J8D7WRsZPoUQYoIo8oQF2OBESsJUj83mQVtEmU3P3rTibif?=
 =?us-ascii?Q?nVKljaxtt8J1AGXcwYyqR6Y3+EUsuSNoLWnekwsVZdgsibyVG5550KmqCDWW?=
 =?us-ascii?Q?19PMk4ojAyU/BfieB8r61xv9Vcbi6h9b3bD3k6MaFGd8WK1WtUgIcf2fDG29?=
 =?us-ascii?Q?J5AyvBfSKD0DQ2PE8jU8IaW40/9DDGhB+nlgWLWcBHxSxA7rzBOOmHp9bJzi?=
 =?us-ascii?Q?wreca1+iVSn496BKumOwyps4h1CpA3nDfkMS0h5jNo1mxMPzP0RiS5R5FFwU?=
 =?us-ascii?Q?jGUI7nXBmDcDyCoGKitaPJZQkgP43FEY+C3DE0C0VmiPsQQYIgC77jl7ZSOf?=
 =?us-ascii?Q?DKwmx8o46SKguNSpW/mkKke7wtUuVssT8+BtaPCQir4cFiDSGUSrUDW0tCRu?=
 =?us-ascii?Q?YFi+2iScJSyelAlnbSS0Bjseo1zEh83FgdbfZjMGIFLsqV6//Qy8wtD6Twpu?=
 =?us-ascii?Q?SIYhN38tw2RXmWKQqyuReEgYJFyErzgLDd1TkEBTFeXA/pDLx/VJuSfrZa0a?=
 =?us-ascii?Q?ykzPKUivwayeMbzjMWG6Waw1AH/kZ6ffTqkraH5fIponWv4LKE+8nRlAFiQ3?=
 =?us-ascii?Q?Fh3wG4EVen5UzBt6yt++oPSrqsdbwMyFUjEGZoL5gcnRPTsgtUXxbd+6fjrN?=
 =?us-ascii?Q?Uhng6qKaU3V8rn4qaY4YRCg2+bxYlk94LtU/SxXoilRi7oY13JNgyg6TFV2G?=
 =?us-ascii?Q?vEMczWzN9omK0T51vVr+ulHvtoEDGjhUXzmfqZ71OosMgz2cBvGbxioCnSjx?=
 =?us-ascii?Q?Rj2HTe5akKN4QMnD7QW8L7Ps6UVOum8XObqPgNtHguVlNC+kvxMp1yTLVQsr?=
 =?us-ascii?Q?zguthPjyUpo/MIkofyOL3xltwvfEY6efhupKmpUgJAyj2ABzfGqxKK3nK6bs?=
 =?us-ascii?Q?lQFzKdcCoVPSuGyKPnpo/wT8RJuNLiKYo9rDQ3+LUn1URoWBWquAEYqjRHEs?=
 =?us-ascii?Q?76cm7QojzW0KBeU/jk4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FLN1tWvxz1XfRRWcPmhl0PfTcrzIO6xg/UCvPMpvrLDKW4MscNzcpdvd/sYJ?=
 =?us-ascii?Q?wEB1Ivz8fEEATa9qM9RfMxU2//9UhquC5s5O8Zxc1Xm/KQonxyv2ef/TpeMl?=
 =?us-ascii?Q?kHJlXD5E8UlUWav7CJRzyt3WbZKUU9taxThW7YYAVKtheFGaJgofUKPBoAdg?=
 =?us-ascii?Q?x56hiXmlmYHAm1ASEGLFDtcKjRhfdrMMwh3W6cZUNuTYjVww7dbA379evy7d?=
 =?us-ascii?Q?8gBSlCXp45+rxpzSkoDB1MMDr9hXLD/AvuAP5wqJ5nLJhLqHKnjElaSvyUWv?=
 =?us-ascii?Q?KUl7rwnJCteymLnv9hb5mttFh1kpUGmJl1NLh/QYWYKOTD36S6+FHEX4loK6?=
 =?us-ascii?Q?hAJvFkQD9G+iS2JiMwMxbqpskTSGV6H+aVnhIqeoOWKhXZY0hPursNE74E6v?=
 =?us-ascii?Q?YpUZyWgvehI5BTfibXe9XE3jswkWYbSaDsJ3pILQgmB8s+BU9A5PC+SLxsQR?=
 =?us-ascii?Q?gq2Bv3Bq5RfAsirHxhYGDX9DEf7QrUkwiqRTs7e3pZyZY1uZbPt7SjaN73B+?=
 =?us-ascii?Q?R9OOJssa+T3Q06I7PsRAH+sUNsCcusT1NBQTOmk3UeH7em8Q/u2QUTqBIlay?=
 =?us-ascii?Q?FFTCe4E0tZ/3lxQPZfZitud+Ws/9qYT1ETQDFZLI0OlInqI/F8R4K20MwYrQ?=
 =?us-ascii?Q?J+eVPl6i7gh4ZyrNQFb9Zi7pgZFzCiqcQ4L3dIiWDJP42bQGBRaUiECC6s4J?=
 =?us-ascii?Q?/zHBIed5vI3IuCvoVbVjIu4iGzjxNSQFOtTMKI3rC2jdityjRZ3Bqu/fmZAe?=
 =?us-ascii?Q?M8wwR6oYypv+nYi8aru5L9eGfiTikhc+Rt2XIs4VZLuwkDUqbxIoNxwamWgs?=
 =?us-ascii?Q?hH477MUiFJb/7PDWVN8tMuy9KBQwqr6V54vh9rZ8xNQCEzLh9Rd7+5uR0jzX?=
 =?us-ascii?Q?hlW7nSs4Y506Z7uY9VeCZ0/GSe72F2KYpe+YfH0+6PGFGL56TlE2FoIn5Cyd?=
 =?us-ascii?Q?S9Bo//MvboZtaTPITRZcIQn72hiz3kVzSSRGYwrtX69msA+KjDk1QrEeXDHs?=
 =?us-ascii?Q?mr1UZmWa/x6eSADn5cd4H5ksTTEhMAUCNavOLeV8WUPhl+fAGIoK4ewabRgy?=
 =?us-ascii?Q?A/mXTOJsqX9d1S7GTrTiIUhQG+xVHmFGxbLJM2F6vhb/SqPkJgkw7Ekersch?=
 =?us-ascii?Q?ICNCejy8ABGh5BGpL+qj1VQj7uHwrqDhHwoBunfLEq+rAcFFKvTT7SEj8QKg?=
 =?us-ascii?Q?xqk+o4ZyG8+IkRrEjywRdLwF84eJNis5ZVa4pJVTMmIviVSE1V0FFNbDmi56?=
 =?us-ascii?Q?TFJEmLSec7uhaUROYI5afL19OSsByG5cGXqDMD2X608X18z3BAYvYTgXWq5L?=
 =?us-ascii?Q?bLaLTexKkfmcC30Y10D0aECpd0Lonr0rmdWsR2AGVRvz2JOBtof42BnN8hjG?=
 =?us-ascii?Q?MtwEGOxbw/5fixI229fUewZ7OeOOl9aT3rl0tR0pNAIHtRN0tSn2erd65HxH?=
 =?us-ascii?Q?hHYUpqpYOdF0/jgmnvhT65CYhJT1Na9fBWLHNqLRtZTLuivpu1poAVkAOFPk?=
 =?us-ascii?Q?/UW9QhWMW+l5w9kjR/Hg29Vbn/At6rwcM3xWJ3I4j0GohVQzZeLk0WZwKjcw?=
 =?us-ascii?Q?YJ8E6JWBOHLcyKCEHDJOKt21V6mhEf5ZYpfM0wrMddFzxFw2kw4onSMXbqRD?=
 =?us-ascii?Q?34oF9Nrc/U88U5AAETzE4hjg7MeNB6+ZEk4MShZpkVgHx89xZHBk2GfLTj37?=
 =?us-ascii?Q?CoL6hO6o9pKJDcMNtaIlhLOavnxBGrsfa0coFPxme8/+L5E3GC2g0d8WgDaX?=
 =?us-ascii?Q?cUiFT0LMHDomNOdpRysELxz0nY61QtXTzjIybmwc3Gg1H4hkhWXZ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df5a0f8-5e57-4e06-d67b-08de73b951ac
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 15:28:11.0339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+fSuNRKAbZFM80IkCMDrnvDojDDl5Q9e8c4pqqdz63ZOuOC2Sx53XzuCnRTlv2vDnW9RjfhdUZEdBFRfFgNiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6904
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kudzu.us,intel.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-260562-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: BC24118905A
X-Rspamd-Action: no action

Hi,

ntb_netdev currently hard-codes a single NTB transport queue pair, which
means the datapath effectively runs as a single-queue netdev regardless
of available CPUs / parallel flows.

The longer-term motivation here is throughput scale-out: allow
ntb_netdev to grow beyond the single-QP bottleneck and make it possible
to spread TX/RX work across multiple queue pairs as link speeds and core
counts keep increasing.

Multi-queue also unlocks the standard networking knobs on top of it. In
particular, once the device exposes multiple TX queues, qdisc/tc can
steer flows/traffic classes into different queues (via
skb->queue_mapping), enabling per-flow/per-class scheduling and QoS in a
familiar way.

This series is a small plumbing step towards that direction:

  1) Introduce a per-queue context object (struct ntb_netdev_queue) and
     move queue-pair state out of struct ntb_netdev. Probe creates queue
     pairs in a loop and configures the netdev queue counts to match the
     number that was successfully created.

  2) Expose ntb_num_queues as a module parameter to request multiple
     queue pairs at probe time. The value is clamped to 1..64 and kept
     read-only for now (no runtime reconfiguration).

  3) Report the active queue-pair count via ethtool -l (get_channels),
     so users can confirm the device configuration from user space.

Compatibility:
  - Default remains ntb_num_queues=1, so behaviour is unchanged unless
    the user explicitly requests more queues.

Kernel base:
  - ntb-next latest:
    commit 7b3302c687ca ("ntb_hw_amd: Fix incorrect debug message in link
                          disable path")

Usage (example):
  - modprobe ntb_netdev ntb_num_queues=<N> # Patch 2 takes care of it
  - ethtool -l <ifname> # Patch 3 takes care of it

Patch summary:
  1/3 net: ntb_netdev: Introduce per-queue context
  2/3 net: ntb_netdev: Make queue pair count configurable
  3/3 net: ntb_netdev: Expose queue pair count via ethtool -l

Testing / results:
  Environment / command line:
    - 2x R-Car S4 Spider boards
      "Kernel base" (see above) + this series
    - For TCP load:
      [RC] $ sudo iperf3 -s
      [EP] $ sudo iperf3 -Z -c ${SERVER_IP} -l 65480 -w 512M -P 4
    - For UDP load:
      [RC] $ sudo iperf3 -s
      [EP] $ sudo iperf3 -ub0 -c ${SERVER_IP} -l 65480 -w 512M -P 4

  Before (without this series):
      TCP / UDP : 602 Mbps / 598 Mbps

  Before (ntb_num_queues=1):
      TCP / UDP : 588 Mbps / 605 Mbps

  After (ntb_num_queues=2):
      TCP / UDP : 602 Mbps / 598 Mbps

  Notes:
    In my current test environment, enabling multiple queue pairs does
    not improve throughput. The receive-side memcpy in ntb_transport is
    the dominant cost and limits scaling at present.

    Still, this series lays the groundwork for future scaling, for
    example once a transport backend is introduced that avoids memcpy
    to/from PCI memory space on both ends (see the superseded RFC
    series:
    https://lore.kernel.org/all/20251217151609.3162665-1-den@valinux.co.jp/).


Best regards,
Koichiro

Koichiro Den (3):
  net: ntb_netdev: Introduce per-queue context
  net: ntb_netdev: Make queue pair count configurable
  net: ntb_netdev: Expose queue pair count via ethtool -l

 drivers/net/ntb_netdev.c | 326 +++++++++++++++++++++++++++------------
 1 file changed, 228 insertions(+), 98 deletions(-)

-- 
2.51.0


