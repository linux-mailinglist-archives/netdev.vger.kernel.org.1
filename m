Return-Path: <netdev+bounces-253741-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHvbBadseGlSpwEAu9opvQ
	(envelope-from <netdev+bounces-253741-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:43:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C9B90CDB
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2167303FBE2
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EED73314D7;
	Tue, 27 Jan 2026 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iV8TnsdK"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC94330B3C
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769499788; cv=fail; b=lRYprV5idxUNAJc0KFPm0qzvvqvEAIqW9I8lCck0ceG38kQkZ4+9svacfmS6GanKcNnRcbFwfPNBp+5c65Fe7GFMyRnh0/kaOIuDAHGkTl1Nm7QAWvvnR50o+RBmbZ4GCjEwHr2P/ZPNRpDhSzqzQfRVYeoXR/+DgtMQFPpF9gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769499788; c=relaxed/simple;
	bh=Lr5OQQvooVDnhLwh6Bg6NNemnS0LMUK9ERAY7SrC2qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hkRBP9IyWuc/2zRBopaG/coegPNV2sXwzSsxM1P6p/gEG7lb8zjZBnneBkqjpLMh0/ncX7hZWzBge21aAnG3TpijpRj5XRohKIkOJSYWsTWsCUvjyUYr0IdS0K3uPtEhlWhmay/q3qoQx8Mhj9oLMfeeXAWmyt47sMXXDyfL1cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iV8TnsdK; arc=fail smtp.client-ip=40.107.209.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4gLgkgwC4iaVdDw3Zt1cp/R2457gp0tl77nktzS/1XQ7hwTCywZ3uga9470vrsKN3avV5NstsywfcBYCGmw3c3WmT7TsYePtjGMXv2bNsxF4pPe4rKpWyNM1ZWxV080TKTEeL6sQswpGD68RtOe4wzR8wpn8blZUXaE1cWUZhLRq9wtMXL9dEl+4GlBL0odVKaS4OmMMstVv21s+RjHoPCm1GvLR9ciaEwKMTAl2FrsQLis9hH5Y1ez/3wzgcUlctnrKfQFaJ9NKMus2Hjp43ivl8UeqgOt6/eIENmPadnlcw/Zq+da4svdsHzMrjdVQcFkOUH6BAQILofmgsC0zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lr5OQQvooVDnhLwh6Bg6NNemnS0LMUK9ERAY7SrC2qk=;
 b=TcmgPC2qon5xhlkKUMhRFXikJtnjz9kbYsjKj5k3ZZrMvRrAuaUDxiLYuyXs1jLhZAqvflXkUCyc4XSWbv6QwtKvzp75XNZ66fGA//81pNNLm4I+AySiJzeiz6/nJTUXk/s7KcuOYJzIz4lr9J5l+CAjZkVPJv7qSpjl9uRT8noOQiAQCKfNk1Ot81suS2AS4u0Hi/C2/+tr3m4Pgh5pkk6O4p4++d/WW/hoLRu7v/DFVNkfJKna+e3PFvwxcHPrYdsELzGu86dqpx6xb6fhzgd3EhJ9TSe6Zlmm9DDLRRtfI/Udr8p5qe3GXaW4HqX0f0JmydJ24jj5n6eCvUE6dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lr5OQQvooVDnhLwh6Bg6NNemnS0LMUK9ERAY7SrC2qk=;
 b=iV8TnsdKZs15uq2jTBY61DLdoGitwJbdYYi7mWHUFFgg+Vgoik6jLImbUljpddRB3+Zg+XbdJbc/vgies4OcMfg/cGpaiGaF8oIi54tFfJ+JcPQ/lCNFQgH+ZMPNidCUrEEIOIGZFSMJZaxuaqWoojHN4bM3mEo55uKWN3dDbRuGQtowJYF3Hauf5VOP7in3Tp/g0H0jFQGQOwixCm8PqfHGjJ0gW5XqXquGFGaABTJ8gp5H54Sov3fVo6x3zZqfaBU8l9T2W285xlOMXiTjA7lZaekSfQBCT084aRTdi/1TRoEhqZAcYu3Hwkl5dlEXn5bzm0Sxpf4jv7VnLDBD7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA3PR12MB9089.namprd12.prod.outlook.com (2603:10b6:806:39f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 07:43:03 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 07:43:03 +0000
Date: Tue, 27 Jan 2026 09:42:53 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jiri Pirko <jiri@resnulli.us>, Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH] team: avoid NETDEV_CHANGEMTU event when unregistering
 slave
Message-ID: <20260127074253.GA244149@shredder>
References: <7fe2645c-680d-4fbe-981b-67a041f0d9c9@I-love.SAKURA.ne.jp>
 <20260125085835.GA54633@shredder>
 <29ffd5ac-07b1-4424-ad3f-8304a28d2946@I-love.SAKURA.ne.jp>
 <20260125121551.GA83275@shredder>
 <ece4365f-906c-44e2-80c9-ab73f91f7fb5@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ece4365f-906c-44e2-80c9-ab73f91f7fb5@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: TL2P290CA0028.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA3PR12MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: 59c1d76d-5b8b-498d-0aee-08de5d77b3bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lSNkD0Cnn0JHQWubZBB575JWjr1KTIoIrck8kskcB5dXfBFaOyJqkKkjUZf6?=
 =?us-ascii?Q?FcEU3f8LRMABGhS6nkNXY+JcxK1PxUTWe9E3pT/KSumtf7XLIaZ1bn7CJ0zz?=
 =?us-ascii?Q?txa0PznYq085QRqkCJ5ux/v0NgldtEjO0xkPGS8xIHwmwJnVLJadE0n3jrZ7?=
 =?us-ascii?Q?Ljs048bKUI9DWct+EZZv9mvYcyOirGt2rkvV2pUzazQu1TVLv0L2yZDVrxrP?=
 =?us-ascii?Q?IIkIB8v81LFtfzYrhKcVePG9SKVuORhfh/adEfLd2JZAJTkvEu6E02kedR+Z?=
 =?us-ascii?Q?DGyZ3NHh4bTK8gd2jr5HD+yUMhTf++eMGbbgejD5d947/uzR4D3EHozQ5cWr?=
 =?us-ascii?Q?9e2IAtxYp8GdIkQmmLAyPeCtIBfdhE290jmSLddgCCpaXhTmxgU9J3Aul08a?=
 =?us-ascii?Q?x4wXdCtwnSuHqkpLop+15Qv9JklfgBeT9mJqvQwJMWL/ag1z2v+3nj1DuRWu?=
 =?us-ascii?Q?9PYJee9uLX9wkgVCq73PJIsCAUKr1zBXXHL3Pu8UMoSfXsxRtK87ysID+74e?=
 =?us-ascii?Q?gI8JHqkkd3MbCBnK5miM+uCA9nbc/lvIRhtVedDR2DO6DghNo5hA7cpS7ghR?=
 =?us-ascii?Q?Bz3kpjIKGJUbQ+3sFhj7rRnVKHgPCLYJEMtHtfgxfwhf7ImIhQgRlAPgxVgn?=
 =?us-ascii?Q?EWCqV/z947xJ1u57H9+xuXHZduhcsT9DSegRcAkb9azBKymhkVlL+UGcE4dZ?=
 =?us-ascii?Q?8acAcDwMluCvxIrjufJ5ezP2QfeTU9GagqAyp2tIb+tNFepSdRJvLFvnrNKB?=
 =?us-ascii?Q?hjRZTVwdbqYGEBz4Mq+HUP5KKotp+fjo3qJXH2uphw1zaNNJcfY/JA+m+CrV?=
 =?us-ascii?Q?99kR2TENpS4iDL+IdS6UBhMCnsYj8vmlHjmaH+GNDR/ys4H6axUCA00ctW63?=
 =?us-ascii?Q?zeqOzuc0YbX6q2lijL+IF7mG2Aqp+S17ryeRPCO9oYq4/4eYyneh9gDgay4x?=
 =?us-ascii?Q?S1jq8qcuYFliFCNPSDnxCAOpo3S/IUOPdtYQ8IgWxu3dNlEDZ/MVUUi7ShaA?=
 =?us-ascii?Q?VCmq1iVRnXdwxql0+0SkpWaOkRl+lSaoAlgbHzpOuHvwX/cHlY+RRW+b5n2M?=
 =?us-ascii?Q?3DcRg10EZorh9G8kLJizz9KjVlV9WVYqKst2cYosUK4TMsmwzR52A79+VFNG?=
 =?us-ascii?Q?M5vj6pknX/TafvFNFOb6UQFtbY/nLq7U4ppv2vkw2/ccj0w8NAIQr77ur9/E?=
 =?us-ascii?Q?oaiD8BPQ8zjyGIaKZky+tMUjus25DfWLc+YcZs/ITSP2E2znGVAqQjkL5V+T?=
 =?us-ascii?Q?mbMTeym5YX1NhX1sDQb04jqeoVJ0x0k5YRCs211++PB/j2vFxjnzhZNVtsnQ?=
 =?us-ascii?Q?2DkHTpL0TeJr4zrpRRui9VNwOgPBcOVgHLJgtury5/eiRXuOQUwPe7OY2DC4?=
 =?us-ascii?Q?hdllL3UWgEr/6rT0u3JoVeLU0R7PyYf/Qfr10r980WrS8SVHRgDFhUuIukiu?=
 =?us-ascii?Q?BS5J8oELLyN1BeIAIZHIpblDuPWwZDZTlRPBxM5+LIROVGbYduROaAc+vJqm?=
 =?us-ascii?Q?UkCeW3GbJWkiUpfJxdHjZJuAI/msMbaTb5YaV98mpcit9y2oj217typoteJJ?=
 =?us-ascii?Q?S/ms212WAsqzEAqFri8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eKogKPhdLnQOCoQRuLH4V5nt44OiV2z4Mt9LItHJTTKgc9ccpqJwAwETUnOy?=
 =?us-ascii?Q?p57t4qw7yg82qzgkVSQhXbK8FzQZ+XRjYUxrOrjeOMEF4Sc0cJ8Pmoj2ERqO?=
 =?us-ascii?Q?/utTH0Lz8UrdmaisQKSAn/HpqTLVpbU7nH+lYdb97fAfuEiMgvXbHpWur3C4?=
 =?us-ascii?Q?pysDaT6oGvrnqkII0ZKZbRJz/BDbKxEdRmep7Cxj+MOaeySuCjyYQ37ZtrET?=
 =?us-ascii?Q?pVengU3cEbgigEXD38PuRJ48FWMUJ3lFZiiLvPy5eKmGRfTfpLn6MyPXdJ6z?=
 =?us-ascii?Q?nhY4jSFfZDecAI93I4DS9dnGuDq9XyExlhO969yEzfSfiy2jAybk22PLu/sF?=
 =?us-ascii?Q?qn9aY7jD0p2dZ9oIkBIn4Bd115dVhxqq8Zex8GW272GZy92w2T6bjxLqDgXJ?=
 =?us-ascii?Q?+AymDBukcmTNa+0+IWhDep7vTO2P9D6jd0kLRHFIAPMa2wi8HT2apGXkHUcY?=
 =?us-ascii?Q?fV+IUNofGL9MDaFYdRwbaMT1OISYdkRnPLJCKkNFujQqoi2njqVzRORgMTM4?=
 =?us-ascii?Q?O+ZxXjstu0ITpAY7V/11C4TrsTW02VWVa9MPbhwaF0R/qSt/5C/munzNXu8m?=
 =?us-ascii?Q?BMYDhypzF5W9uCa7I+keERiKNXgB27vnjo/E0xuue7Os+Q1i3+/5iiN7/hd8?=
 =?us-ascii?Q?GDjRRYU+Jpi/krSS1nX0jGUlPmWHHmrYdFZ8m6eYOKmJqecNO/YhxZtpp1GK?=
 =?us-ascii?Q?kEfjP3+bTyK2ORTbaf1iDKG97Q0P6VdqWm2sWnfwuTEhqyutFBhGgN6QSnCM?=
 =?us-ascii?Q?1xOhOoR72e7pT2Fu5SEynZDSk8GY4lQy3iE8SHmVDZ7JaZpQY+jb6QoELDx+?=
 =?us-ascii?Q?lAAoXqjUVwOQZCAIhpSgoaZoFxJP8UqeWY7w1kHmfM/Yd5yBSAcaXpYuBOd8?=
 =?us-ascii?Q?kKAj2m/VyIkKUkEyITrPGQqYqZRv21SnLH1hwkRQ3fJtir+PTDHNlphHTV+g?=
 =?us-ascii?Q?L/q1/KqNuTc+wWnLgUa5tBY8ffv1hehof4Lbwivfmz1toSDUjwdT7kDJa2gy?=
 =?us-ascii?Q?PRkyPcJu4y0Eevg0nLWnWf8g6Jx4uDdiZBj9acHMy9de7k4IO6kxgdNxld4B?=
 =?us-ascii?Q?Tl2k9SnGcIUdWeCbwNXM7BbmcgegAX74r4NUM7L6arGegOyjqU6UQddi2prx?=
 =?us-ascii?Q?i0nHUEFdyPzsx026nnk7ieW4I2sm9WfwqIYJRH5QFbkA+5WgQm4EXg2js8/P?=
 =?us-ascii?Q?XNH06M/FG8lOttunZtuel9qSA2tc9Q+50+VgYAMzyCr3+dCgXT1by7mTepzl?=
 =?us-ascii?Q?FbdFU8cF30hOzoDhCBbn6oHPhzVBonsHZzqNvRy/D5ivL2tDzILakz+2WTB7?=
 =?us-ascii?Q?MrPdBqe91nCqezXI2nxoojkWEr6U38h0tsR1eYZv4NTvunAk1xo7WjOE2MIe?=
 =?us-ascii?Q?eqZ7JZstlBcWRUCloa0E3/YRG5N+N4QXkdYU+jlJO0j1hMXe2JMoZ/1upmPj?=
 =?us-ascii?Q?TkoqkmhY4cOQwi327hZCkCjsOWsVodSZSj7k+bPIVZQYcIw2xNKijDh3kRzF?=
 =?us-ascii?Q?ZIunvM/cu87qv6BOWxNli4Ixe2myPpEvFLzWR9Is/ykzMtYuhB7Bh0Kl8mX3?=
 =?us-ascii?Q?vaNG+PO9GTHIYKA+rlhwyp2tBHNXzAinUzIPziCWIpSVlVZyl85H3Y6blPpe?=
 =?us-ascii?Q?MS6sDbk+jXhe7yvvWnBGNzIFA9cy1IQ3zVDRI+jyzdEPHE/T7wd+kYAfJxjs?=
 =?us-ascii?Q?1n1Sh5OObiKtSt4T+8WDPLIbCsk3+6LkfKP26kuJh+CAyjpi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c1d76d-5b8b-498d-0aee-08de5d77b3bc
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 07:43:03.2050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wARP6li+YQW7dAbuvWPX67HNQfAL3IdBluMdZ8j8R5DYWoRYSwyeuK0DuiTcKW528zeQ45ikcVqDq2s97HE/iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9089
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253741-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url,Nvidia.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: 82C9B90CDB
X-Rspamd-Action: no action

Patch prefix should be "[PATCH net]". See:

https://docs.kernel.org/process/maintainer-netdev.html

On Sun, Jan 25, 2026 at 11:35:28PM +0900, Tetsuo Handa wrote:

[...]

Needs a Fixes tag. AFAICT, issue was present since the beginning, so:

Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")

> Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Doesn't build for me with CONFIG_NET_TEAM=m:

ERROR: modpost: module team uses symbol __netif_set_mtu from namespace NETDEV_INTERNAL, but does not import it.
make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
make[1]: *** [/images/share/idosch/virtme-build/Makefile:2004: modpost] Error 2
make: *** [Makefile:248: __sub-make] Error 2

Needs:

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 0af2e5aa84fb..a0fe998cc055 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -3014,3 +3014,4 @@ MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Jiri Pirko <jpirko@redhat.com>");
 MODULE_DESCRIPTION("Ethernet team device driver");
 MODULE_ALIAS_RTNL_LINK(DRV_NAME);
+MODULE_IMPORT_NS("NETDEV_INTERNAL");

