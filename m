Return-Path: <netdev+bounces-213279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3E4B2456C
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 11:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64DFF7BB0C9
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B392F0C68;
	Wed, 13 Aug 2025 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I1ORG19q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DF32BEC25;
	Wed, 13 Aug 2025 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077168; cv=fail; b=FdQQT8oPfHDIBSP7Go+HRvKWPsoNtLf9KtDmlzQHuU3a16QT5u8SAeVIfSSqyOJUi4XG1fnBdURySyF7eeYK1DNpjS5PFRJE8SteHISi6YOWxk4DMmWikM+Ywi5dPny4/FhR9S0jeWrPqBnxK/jXAbzxViAFPpObHTyU0rlviKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077168; c=relaxed/simple;
	bh=jE6cFGNZbwnWgQbmyXTXLnbb6DU/3ZHskVyCpsXlfgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=upsg7df7mxlBT8SFqNvsHLoC0+4Syu3+HUu36/eSB7CBtKV7rEsXshTqLAAkAho0vnlZ4o8A5liek3mwaiIhH579A5BtzmyErZOTXSpuzgtv4phQVFRO2T5Z3bOB019oQ8qPeAXnVhTmTYgq+nDk6VaRT8o0r2byVkvtych217Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I1ORG19q; arc=fail smtp.client-ip=40.107.212.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfhCT3f0PpLeZ08BOln6Yn1ql+FwmYqYk48c0I1vuawMaLjtPnjhMnBAQpGpVz/U1fbIyjqZj5LjTJdyYdKnR5kupkUTxq7k9ke23yIVagfn8WBvanN+Gzsc5pO265AJY3ipD1kLaNjteW4qCHnhB35jH2uK5lfiqc5a8eEfYsSHGPlyEpAiCoGli+wTchh89a/xgic7mxcuxHbB80vQcugcPB6M9/FWFmi9aPRJVOVJo69Gm0S4vPfFQigWNmkYfREb8TwVIvOCaySfZ67O9mb1FwzB/8J2oDe38+ozBlzn0FZKXyP/hxmVUd/PMe0d5mkEp/9qa17mEq2d8xtTkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJ7zpYahKyLgf/4EgE8FQ0xzxsWerxKEkMPrm2oiWq4=;
 b=ezHh4XQbIFKbP8YC4jaJt5wwecWakKTSZxuwJuKoPXUiU7skiewfcJchdJ/gwDS1WqveMm4RYpKCDdsoVAknsEjkCUsFB6FAbXolM9I+3EYzQ9u8mtHXjyxTT7t2DhVxANeVAoHz0u7JQzmN/yomxv1dM7CqGB/uOEpVlI+BJfXF0PpewfAFOcEJfcf4OTyL16KzqMpDaMIWJU5aoXWUtSb71y6v21j+JByxN0OxZGaRpFbTQg/k2zDdfuNZ29e2J/zuJJU1BHRvlyjPZX9K6b+C4fW6XTooqQw92BItM/G7b/pA1b0EgFa59hUyCMBKJuPiAoa4hRyH0q7gRAz/Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJ7zpYahKyLgf/4EgE8FQ0xzxsWerxKEkMPrm2oiWq4=;
 b=I1ORG19qB43q9AdY+Y7utrnK2NoF0zFGPWKqDawu7+lCUx2y9hotE6t5ODRZiJ/lq2dagYz03kgq5JUKG50jzRVor8yOA+6O88lXu1lxqIeTuMRjkW4Hzx4hB0o4qA8Hn+ijvQSgv7jkbH4AQXootXYs6sEW9uIY2d3oiA8WpYb6g7ToevOON5wBgNGwvTqV26+sw5LcazBSjw61lt4xc8/PiEu9/3bdXMBOjbnQnN2fUxqXBjCo8LeYQl73dWjJv4HCRVIFf1bQqaAQlXmapkoimVemmaqOFArEwxtnJPkF9QlRNe0oRP1JxwSVJzKJt2T2NTngVJe98oV9Zk8VvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 09:26:03 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 09:26:03 +0000
Date: Wed, 13 Aug 2025 12:25:53 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	donald.hunter@gmail.com, andrew+netdev@lunn.ch, dsahern@kernel.org,
	shuah@kernel.org, daniel@iogearbox.net, jacob.e.keller@intel.com,
	razor@blackwall.org, petrm@nvidia.com, menglong8.dong@gmail.com,
	martin.lau@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/5] net: udp: add freebind option to
 udp_sock_create
Message-ID: <aJxaIeUT8wWZRw22@shredder>
References: <20250812125155.3808-1-richardbgobert@gmail.com>
 <20250812125155.3808-2-richardbgobert@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812125155.3808-2-richardbgobert@gmail.com>
X-ClientProxiedBy: TL2P290CA0030.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA3PR12MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: b5fcc0b0-1b2c-4cf0-39e1-08ddda4b6c80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZA7s3lDLzvWVSpArL6KOKLyeeY5Ngy/QvCV70Ve0oy0KZ/UkQb9rQySfYEtm?=
 =?us-ascii?Q?toauSDgLCaunnJOK5bAYa6ZB/EhM4V7n1RyG7H/HMXok3utd1sWe6Zh1s02g?=
 =?us-ascii?Q?ZJpsSVUv+KF+wNOnsk36RAtLTwSAghzWw+habJIwkf6e8kTzRFWIElygYCcY?=
 =?us-ascii?Q?v4+2kT3AZfoNHM1arNUBEseG0Q5+mgKiZf/qyWtv0n1lGUhoAvR6hcp4vnul?=
 =?us-ascii?Q?VjddyBmNyJnZOKhcIKqAxrovMSjefMs8hrkToXRHioJbxgw5JGoyVrLLFFGV?=
 =?us-ascii?Q?5zy3Mqn5HYkMSIMk/Uqw1a97zhRB8uGwNlrbPOpH2uhd0A2ZNuReis4GrqSy?=
 =?us-ascii?Q?cblq3vp02wxsZmggkfoBwM/ucoh3aTplRrlQtStLWGbZC7aC942dQZyTokZb?=
 =?us-ascii?Q?aph2c/BkA9C2YiNQjqKIKRyqBw/qWfFKwLnsLCpC9PSyOfXn2t+Hlm5ys5VW?=
 =?us-ascii?Q?fnHp1590IIZx+WtVm3bjBWNJzTWcBG50gmG5NA2V0yjjHyY3RGgbgEF03ydg?=
 =?us-ascii?Q?PQ1IHQUk4jQK1dK9iuGAMyun9iK82v+/x2znHB9DTVWMXVf9Q1X36EXlA23r?=
 =?us-ascii?Q?3HFGCnVynixDhRD1iSTpN0w8x0EJUIkDkh/ffdQIXDErNVGaa1tEoey61TW8?=
 =?us-ascii?Q?5lCi4o1Rwp3gBtCWN7XG8lwx8vIBmHp2/9JhFt40N+1ducSxkcR5LMMZNGr+?=
 =?us-ascii?Q?gIMMSWTkZnjEP3Cxy+ENg48MF03MILxIg2dUSJcJQa7LWC+DptG4rOvBkHuL?=
 =?us-ascii?Q?2URLJPC0O++NiafnxVTdVPE0RUOvEmUnFzSEfZLNoBR3yV4qBG7POv7N3Cnf?=
 =?us-ascii?Q?Qix1qVdS8vsst0ZalYMjmivE61NfHbZcHH3nIimQ8hCMEwonpuecGxdW0Twm?=
 =?us-ascii?Q?5xZGvi05qK9DsNg9dc6uaW6bhlMyWzX86wb0nmUvO0Co2elDd8DcSOyQgo7s?=
 =?us-ascii?Q?N065c5Z+OWUtvRzBPJ0tiNTvJ7LRhQWrsje+MgKiJnJLNaFaSi6ArZc9na8C?=
 =?us-ascii?Q?J2TY6HRrj7Y5xesiUFByGWrJA/HquQQKZf8IOqPndLHVgcKuFjlx4e1SaXEW?=
 =?us-ascii?Q?ofxuloVJ+pjKO8d4ERSMtoHL6fT5Uow6U6mnhfvn/XBuiLY1r/uJr5CUFN4/?=
 =?us-ascii?Q?XIaOppW+ZzRx4mYcJ8LDPV0i1O+xktSCxqFMKRjJofY+obeSGQIx9YRvn4Vn?=
 =?us-ascii?Q?wFx3UCHgskVGoFnI67sOoBhe9IiPOLnBPwognW4ZWDsLU+npJh/oasVb0z4v?=
 =?us-ascii?Q?W30vGV3NYAL/ehUZeU6e/Plx+QAZIa/bGTHbu1wW+t1LenZ4VLmPAqbI2FQW?=
 =?us-ascii?Q?XQ3nZ7O5Jh2y8mz8g2tsuIDJmOR4tCW9Jrf52xxK6DbYMLIfc4SmYDSOthMj?=
 =?us-ascii?Q?s+/swM4NXeScvsATmBgHue/25E/mrtv4i25rXLAfiqSW5hl6+sWNbt+CP3D9?=
 =?us-ascii?Q?qU837Qv2njI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eE0NKFLPP4C0+cIk/fY43nK+S0gRzayW9bhkTMq0mlx19PBiIEHfvop5oQtj?=
 =?us-ascii?Q?T5ohHP1IR1y1I75dlWy9IWVzIMre0M/PIYgwBejgESigHzPFz7k0k5PamRMo?=
 =?us-ascii?Q?T2AjFxI2K2reLGB7BMOOflewWMNWiFILnnqzCywH/aI6gAR/kXJute1F9E/o?=
 =?us-ascii?Q?8Y//zZXTewN128nVR5/QlAPCl2zDJ9lY7txuRgvIfELfxrFDb4Het/S1cxXP?=
 =?us-ascii?Q?7zM55mxQX2y3hXhxp4E1dyCRJFYnmR3RY9IWUWQ/bUd24rFIir98/9zyCroN?=
 =?us-ascii?Q?xv4QJ6idslkjQgIwVHlMrLnkTkXw78SCp4giEc7OwoWqykchP1xTSHo8f+bt?=
 =?us-ascii?Q?ItMC8BXmK+GxreascYVL7iDmVYlkrXohq/MHgvQnmwLdyKSBbzCUCQvGjU+6?=
 =?us-ascii?Q?wpIY/LJZ0h37o4+xc4jGGpsHOAvt6B3EODnyo+CdBSCaxv+I8qO7nbUZTR6O?=
 =?us-ascii?Q?VtTiekC96SG1CIYZ9QF3oV/IkPem05sqQP8uskBkOrwGvH1ViuQmhOgcHSiN?=
 =?us-ascii?Q?8sV/jJdOcgaqae7d2P7yTZxhe666IM3lKyEsA7L9MDXyrqG8R+4wIwXPuwIj?=
 =?us-ascii?Q?TUamA424TtsqekxhtLQt8cAsfiR4QFy4e+3EbrpHJ1I2bsXj1vL/YPr7+Fq0?=
 =?us-ascii?Q?k4tx/yf3CNpwROdf8GbSjFVut15glQJi1zXqt4DFjQNMZyzIhpXCNl5TeJWY?=
 =?us-ascii?Q?/kyPWy3tB96vuxeS0BGPE1frzsT7m7S53c+38tGE/9IhQjGaQpwS6Wo0XfzB?=
 =?us-ascii?Q?7iAV4y8Xfk/AFb+FtKEYA2CwJBaAZtTg7fqVnJZ1uaxC+b/ThjN1RytLBNhS?=
 =?us-ascii?Q?w+jjvmLqlRQsPBIpm5JcRUpumdrwmzrNn7j1yj/sXWqY+PXvUNf8h/BuqE9R?=
 =?us-ascii?Q?o9xT9EqBmTQjxlp/PhRRFo+LT16mPjybpwkiGeKwjldw5W8L8ptkq6xc7b/N?=
 =?us-ascii?Q?a/rSIOevuC0rHwyQC1J8k9I+mO8D7KEA3yPvYWgC3Y8P2jCS3YQB2zHkkh6v?=
 =?us-ascii?Q?boCCddVUl3zz5O2VwoZf37y15Q4ix3wYCk6QqdU+Rzo3vV1M+K43feNf6Mm6?=
 =?us-ascii?Q?DSVZ4lrtPdIshzMYH3LzVJ2Gafg6YMRpCBskiaJMvVD03+SckR6hCNO+dY7E?=
 =?us-ascii?Q?dCyosYS5D8x5JxrdiWAkXNHHyDKreslC9gbAXafiki0wLbgdrH7vTeLqpzWl?=
 =?us-ascii?Q?nwdOWVEUwToJ2f2h4duYKNST+1sbsfWCYlHIJwWdtKPRaoqpfKfL54f99tCt?=
 =?us-ascii?Q?jEK386T1BTsr2+qL/U1zETDg3fMeToZrJT5dpmfkpZs1zKoe5m3qc56wQYF7?=
 =?us-ascii?Q?VZJHKBpilR1Q2zGKOnPQyrVzQbBe3zdxeCpO7GupUzk1mgOWaUu9LtmQbAqM?=
 =?us-ascii?Q?DHKWPxHgK458SKPNd2JHH8FvRk/TWtNDj7Q59ppwfb5bqlk6xtgbLAMjxkIb?=
 =?us-ascii?Q?80tRjh97Bg3x/NgnV0UGx3dN5vVstAq2jFzLDUoP159Dvcfn0qnntRQqL+AF?=
 =?us-ascii?Q?1WYlD6uh6znzvqcUuVMUel+sZyI/rynZ4k0nA/+rbj1WbhKu74UbRBANYyMn?=
 =?us-ascii?Q?5EiuEP/eKWDqghcQxz6k3h8UGo1zdpavoS4QWuEm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fcc0b0-1b2c-4cf0-39e1-08ddda4b6c80
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 09:26:03.5030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBY/D+EYfypWrmEQFVUE0Egeyk7iNpXeYMbASW1qeq66riKaI0bCCDD62t78V6iFTatqkC57QcAHzHhRKpIC5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860

On Tue, Aug 12, 2025 at 02:51:51PM +0200, Richard Gobert wrote:
> udp_sock_create creates a UDP socket and binds it according to
> udp_port_cfg.
> 
> Add a freebind option to udp_port_cfg that allows a socket to be bound
> as though IP_FREEBIND is set.
> 
> This change is required for binding vxlan sockets to their local address
> when the outgoing interface is down.

It's not necessarily the outgoing interface, but rather the interface to
which the address is assigned.

Anyway, I'm not sure this change is actually necessary. It was only
added in v4 because back then the default behavior was changed to bind
the VXLAN socket to the local address and existing selftests do not
necessarily configure the address before putting the VXLAN device up.

Given that in this version binding the VXLAN socket to the local address
is opt-in, it seems legitimate to prevent user space from putting the
VXLAN device up if the new option is enabled and the local address is
not present. It can also be documented in the man page so that users are
not surprised.

