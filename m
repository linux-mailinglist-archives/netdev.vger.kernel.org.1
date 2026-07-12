Return-Path: <netdev+bounces-306930-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /dmlB9g8U2q4ZAMAu9opvQ
	(envelope-from <netdev+bounces-306930-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 09:06:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B13DC74408E
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 09:05:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=esjznWmf;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306930-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306930-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2426F3005A80
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 07:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC6937186A;
	Sun, 12 Jul 2026 07:05:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C523D2FBE1F
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 07:05:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783839958; cv=fail; b=ZFXGOa4tYk/KVtyA6/s+ykVvmey3Dl+RCJO3e9/KJP2II63W5WbWEIRUGxsrSYE5xgbazfvTfGWAUFPX7lQGGsU5s1noTrf9OaDgcZtnYIgpPoP1AJZLn6ks3LgfaL34C+7/wdualSQHkiKpXKDu1d5VB4BOW35AOBO6GWFnQyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783839958; c=relaxed/simple;
	bh=XmKag3QUXSq195VTuEN68rFSNcr1cB/kLJPRsPJykAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f6iryohjCnIyOReb6z8lBG3RZ6JAKPfrilSVH0rJneMi6eVu+hFQqRqT6qa80mbQZFegjvoeeA2FVoQyE0gPlM8C1sS7p974vstqtGlVN5Br33gYXQ4R21s2KXHcOnaMgYTTUH2Apn5s+yCdiYJO9ow/70K/Yhih7KZwrUUNk/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=esjznWmf; arc=fail smtp.client-ip=40.107.208.46
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlQOgJRNJsfzbou43yNRnsi8WQcXMksOXTqOTfeqZcvcEfg/+EdLExvZtk5aelKiPTTfHp1QRzhKb9L6E6YXtenRv27i+yXNx3Qm9kcNFViu0kd27cWL1GJTGbnFymWvcIaPkogYOFCGh25UdobWsTe/xrYVZ9NFy/ebYwylzO8cTRF4cBTiB5LZfX46WQ7YnjrKM3XrzSa54CTTHTIOew7tF+fliMQnSpk+ovidfVPVId6gXu/HUeXpniqo7fR/esZFIsJprtzn8CWjJ+8fQiC2a+NXxu1ZqiyysOr2EGqhvZCt32INzQQVyqvQm2APmV0KaULt+kE6Bg9eyQTUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmKag3QUXSq195VTuEN68rFSNcr1cB/kLJPRsPJykAs=;
 b=mhvea50yoawH/8YeD0Um3+xpDT/U1w+trTQRrXDWWV9GEY0N64gggfr49fecPieSzBFYstZ1PkoflTyKsm6VmT2+eFKD9Bb9vSu5Xwy4/uUu1nNE0uGtP5aGrSmCab91I5hl8kq/SoPsrc/oy2xhnnijlffdAs/2ZCGZ5qu+EnQr8HKxB3XuXrS97JwNGolpEByhvPXU6zQhl9y8wxj3wz31Q3gdcY+OvJVMNEV4i9gGdie4HNwSbexyhGJpiG+P1WpsuzYlowKA7jw6wx8SQPwp2v0vyPp2nhrnkJT3Db26mfPmrN9jv87qA0qZ0Ya000f6w2/RsD09OkXRJnkBHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmKag3QUXSq195VTuEN68rFSNcr1cB/kLJPRsPJykAs=;
 b=esjznWmfR7ALBk7gzLXAGENZap7hH/bgDNAn29bDntaaH0QoCic+RtZ38qp4NDv40moFiRwJM/d+D+5U74G4mK4TfFejjiDCOLCNdpeQvrOgdXMYQ5f6MQa92zxgguA2An5gojT21zHfe+hTJEdJZyIZYBABfMNc4B/BE2AfbfWHiT6yA+WSXaxo7o2zL7kVNKKwTw6r7IBsT17krUeKoZQfM0/o7d3Um4+DjnVQ31eaWtxmwJYbNEc/g8rgxjKl++4mhfTkpIASdtW4a9X5K56Al5Zb6wLRF0XyIhbGd1N+uffVHj715vMhSyNamxw/JEj6/hk6fEitUejqBovlgQ==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Sun, 12 Jul
 2026 07:05:53 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.019; Sun, 12 Jul 2026
 07:05:52 +0000
Date: Sun, 12 Jul 2026 10:05:43 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jack Ma <jack4it@hotmail.com>
Cc: David Ahern <dsahern@kernel.org>, Roopa Prabhu <roopa@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: VXLAN FDB nexthop groups: per-nexthop UDP dst port / VNI
 feasibility
Message-ID: <20260712070543.GA126372@shredder>
References: <BL3PR17MB6067BF1D5802A6B1822452EEE5FD2@BL3PR17MB6067.namprd17.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL3PR17MB6067BF1D5802A6B1822452EEE5FD2@BL3PR17MB6067.namprd17.prod.outlook.com>
X-ClientProxiedBy: FR2P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::22) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: 496f1a66-db07-4e57-2e52-08dedfe402bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	gl/zjeRIsC6c6xUsnFfYdFaV2QOPCZFz2/Ivh00X962EMgRvzhy6WcKu+3U2weAvJv7gGtM/HSu1autLurde9IJqTRlOxyZNLHE5w7SeRx1O2AD2E9xqcM2SybQZcl49rA1H2Tz2srYm/W3NTsCs4fsUcUtdb34N3cYqVaK6eNyyFiQAKEEEuH3/LH3QTH5X3O+rIzLCHca4e53prdWsDmpQ5NkZkIGA8fF4gF58lw1u6TX2A7+kl37/qC2zf6w004ASt5035iGrf7clrnNWUmMHuWdRABVYU78aXz2HTVAXlCXBObtl5r1bwodnZaCXwtqaC17mA0FB6ndBQktell1Bs1sOBEepJTltSkkOE6zK0n7BIfditHZsVEZN7hRPZMcJOI5jvFksBX1oVAnzUbA/tP90vetfOYGy4N/nPn/GPm8UELRmbvu2HGFLGQIwWZdfhLZnpnvJAR7IP97+JsOCvzbdwn/9jyEMfVJ0Ed/xHcptNV0YIJ+PaWrFrEhWutNiTS4jeGfVuX6MIIdRvE9tgXoDSsBV5MqG0DaqQnGW7nodCFLAH0kzVJ6OL5CqMoL3GtUVNTy3bpdI8DFXyjrYzP/AgLsSWZqOWcmnwX5KyL7myHA5QaH4czJy47KaX5k0YlhXV/WwB1YrhiNvFMexX5MvPQVb8LmgvX3aUb0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UFE9TSc3YeTap33WYyM3R3BfUrGP/qilAuoau8RhjmXc2rHfPxO5PRAvU/D/?=
 =?us-ascii?Q?PwW64Fkqe7Nd+GcdJ5GFaiLDg3GhqZIyCD5sQ8p8e+b+krLrOPAR3pU5FMmx?=
 =?us-ascii?Q?/uCXBnZLzSN3kgNrK8jgX1JiCFimEZymvV61tIgZ4FT6i0weZtOM+eUv3Ak/?=
 =?us-ascii?Q?4SLFMTL4Va7rYCC+llPNr6bJS4YQOi2bv2ft9SP1rp/3g040H+GoHbX42cTi?=
 =?us-ascii?Q?xr5/hxE04tN/lD6/df0QQdLWL4EaxLoYYVLQ4FIDqdmsMP+sMFb46W3B/80/?=
 =?us-ascii?Q?zKEAfurUTqzjJsAS3+/VK06MNqq2mvA40cPBLf7d97zqeyq935ERbhiAQADZ?=
 =?us-ascii?Q?J535U/ehUJZULZ6wey+ezhUkQNzS3ns0rEI5QqxYUTeXBRkqcn5G99oldGZM?=
 =?us-ascii?Q?8WbY4YJXkXcwrReCUFXysCQsmvMtXf860Bmj8xFeiOtYxCGpisiWprjkhJnt?=
 =?us-ascii?Q?tz34tVNWQMGQ+ylhkclt5ch3+i2+wQTU+9w0Ri0gMQqQBhS7eGsnElmeV1i8?=
 =?us-ascii?Q?xTb45eXvksqz9VGrdniQ0TbFGJrhWJMspw0u/hmOxFQ1psa4wv8hsc8gtBpV?=
 =?us-ascii?Q?1yeNjquBQpa73qlbkj6mqRKGiVwbTvmy0LBkYMXBaNxu7RYCdfm4lAOPmS0J?=
 =?us-ascii?Q?8wXuiSlujLSUJKAk8SfbYl/waFx0eabNXV+LXjXFuBOY2rPsXodW+0GvJHd3?=
 =?us-ascii?Q?/3drEqj+PqQ25W2qUVaAq9RufRyUmydi/JBQtHFcjAsfhFHSKJ7WqecRcSHa?=
 =?us-ascii?Q?BISixBr84xnxo6LGz2V93qOz0Ju7Y3zFyOrhwl/EJmO5dSAqRyno33T1veZK?=
 =?us-ascii?Q?XwJNrpu0r8zsnfCib2t0q+9opfHc2OgRIJm+ZjB/Mkdsa5yvr1LKEuHxDxBe?=
 =?us-ascii?Q?JaTgOfvOVY1PKx0VUoCSSmrz/adgAlMKkUfmh7muzuc/8ij/WXZurxQ+sHBI?=
 =?us-ascii?Q?bXfj7EO6PnbRyfEJ3A+DYilEAaj1Z97tl9O6t8U8I8SqqoKtZ15K3EXL/ZxV?=
 =?us-ascii?Q?CXE+AXLNEn2AxuzJHWg+smuWNeIkZf3jSyjY6T50QRPBS3xioGx6KnIU0Bqq?=
 =?us-ascii?Q?/yNzztAhhX6QIrkbInfnbSSmOEErxgpQzOiWlSJ6s7NoA2odF3in+WaDi8XW?=
 =?us-ascii?Q?rVaegP5H0y8OfhctlyNQ81xUeMkx8UedD7fV2JzLCkBtmjuL/NcZHfL9R4ae?=
 =?us-ascii?Q?8n+iFVbtmIHMuW6tFJ5FciXmteX+sDDYjbwrACDa2IUO9GHhAE5i7dpRRH8i?=
 =?us-ascii?Q?HpOL1BjEL0rNBStBB7ZioQfxVD1X/Xv/7iA22F6vdP5hRU1EII+SiLkPnGsI?=
 =?us-ascii?Q?VY3708SSL4Fk3WFixXjVn3ecSS/3q2SWMTuKss0/4xihX+Q+Oa2Uof/GfuWZ?=
 =?us-ascii?Q?YparFDiUu0CD3GTMIjl9jpHEZ9sfP+Y8bTZuHeu0t45UoL7PfHfKpf0oaFlD?=
 =?us-ascii?Q?+BWO7p39sNFQavGXFpE1RhjSRfKSodPLajuzTlVLqO8Zy4vjCkE52VfeMmKY?=
 =?us-ascii?Q?gMybjCj5Bvd19wygXZm3umE4J9ug1LwT0NGAuy+WB847ndCKGGDz3cvE++EY?=
 =?us-ascii?Q?8ySxOFNghUL2PUr9jzjnLNZFG92YeIKckECFcMAQJW6OJgFoFtH/KjwTbGGw?=
 =?us-ascii?Q?2075qfCODXul2JyAPjB6q4HtcZ+azu7WBHorok0J4Js3U8zxVDLAz8fRN5Xa?=
 =?us-ascii?Q?lg13kHv1cTqPEA1toMHMCqvWDXNha0T0rVWnWRrGZt3f/qLC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 496f1a66-db07-4e57-2e52-08dedfe402bb
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2026 07:05:52.6177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBN9by1tIsB0tilbk7MXWXeIGnIIDwbvpSLEOyy755QPt1BI60GuNqq5AH7CIKRa/lvrED4g5MAcihlqFyitvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jack4it@hotmail.com,m:dsahern@kernel.org,m:roopa@nvidia.com,m:netdev@vger.kernel.org,m:razor@blackwall.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[hotmail.com];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-306930-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shredder:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B13DC74408E

On Fri, Jul 10, 2026 at 05:30:40AM +0000, Jack Ma wrote:
> Thanks very much for any pointers.

I already commented here:

https://lore.kernel.org/netdev/20260709102247.GA1536940@shredder/

