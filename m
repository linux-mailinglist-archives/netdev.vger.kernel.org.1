Return-Path: <netdev+bounces-198570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FB2ADCAEE
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8E33A34E9
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 12:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507F22DE1EA;
	Tue, 17 Jun 2025 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fepkfZWl"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010011.outbound.protection.outlook.com [52.101.69.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D282DE1E2
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 12:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750162674; cv=fail; b=rLSEI1Q5s62l4G+/KXT3ko/uZ46JMI+3ne5fd+f5eaz40S75KgRROyrY01+Ux+FKyotJlyKf0ABG/hkG/A0xfl1wZGiFJ8pIskM8WguE7vz6IWn3uX/L9vWLAuRkBAX3U2OgrVnSIsp3R+EiRsMGiPWBiuNzm4jwCHMDmjqkjcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750162674; c=relaxed/simple;
	bh=DMG3HfBlaZNO+SqQbyQpi8CvpDYbGYW8chHXIxuhp7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J+05PHaX6hVuyumOEbH9LxkL0oBBaCgAdgPHllpOdoyutgHNjD0cQwGR0fuSsc0cxTjCHA80WGt0PWbvvHnLI1UWntO9gP0AXsCz2MWNzf6QyE7hgc5HrrGooIUJQvagPt+XKltz6+CPfvOQHiyFbVSllAwJpRUeQq6KoWuQO80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fepkfZWl; arc=fail smtp.client-ip=52.101.69.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jw3w0tOzlAJvl5EZ2U/ldQLZlEXKs4A5rC8PRWODA+Az34KOXYbQZOF/e8WLaA1qYFyjrfNwIoiFG1v+wGiuAZzM+KFtTE0eu0f5208w06aQYTrsEREuqRuZ2Ejok6Y8MrE7dAyTmmaHXksoUIzvzbnnxSJsc2R3Awk9dIvCiN3k7H6pf+TEi8sXOLXrOjGArN4g0XgE43HvBvQQUnWkFnocOzSbILddechhK4hWu3sUOOkMLByMSSr+iTxgc3eNnU5BIE05FlgnOhcwgPhz4o7sJzWGIOGsndq3bNQ7JUy3di2zAmcdhyVg5NK776/FMWsRkZH4zwd3rZCsK1CG+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCv2QbmAMbP9SL6saJJ7Dq1V0aLFdNMHoiQc5YMwPGE=;
 b=GgNZ65VvIjmyNqL6DfJUDFQvRedmeBdk87W82UP5H4ll8p/qz07oKYtMcDV66kg4FOtXmtr7jRyZLo0I85U3nPwSSOTwH8vJQHggl5G9nE3DF3vTsAhax0Smoh4/jk2qhGFy4lShLEewJuGgEAhb34EJ5/wxkkfzJnOCJA62VDwoG/nb3LZ1h22jZ1o7dU7uB796kvT2LxXM8vLW2HsMBwQc8vDGW/pALUkBwbai0xgMVUXRHCs4VT99iKXXiyz1gFQi8g/0dAkJ8Dfw10ChV3B7DhucQI4/Phn/kFENAYGi8QniiU17CYISObpM5/oRcDrMjlkJN1Ht+oRklDcXRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCv2QbmAMbP9SL6saJJ7Dq1V0aLFdNMHoiQc5YMwPGE=;
 b=fepkfZWlEoJ/08FmFEIThKzFhKxzCHHJ0mWxZC9fx4u5AzH9uyMcS+JeYVSZcu1JEVH4I3SVkcCr3o/cLkYZhHTRDFG4VDuwqchmJlyytSIRu0UYLpsOZbmb4XwmRaR+1sNWFMZel36Loby3Ad9BBzegu8p4ZZ416LTgwHoi0H1qUUeTDNu4r8CF1doap5Gab+aDcTpjbhBbjBJza77McZV8PhBdBgWi5qEON4OgjOqaOjd0iIcbodzQ00OBwpbQOw9+BFeVbfgaihGmpnFkyP0e0dFC5sNyFRlprjTUJwMbUwWnc2xo075R20oOCI8OI1/1LmurOjFxTbSCVuNvJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 12:17:45 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 12:17:45 +0000
Date: Tue, 17 Jun 2025 15:17:42 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	faizal.abdul.rahim@intel.com, chwee.lin.choong@intel.com,
	horms@kernel.org, vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com, Mor Bar-Gabay <morx.bar.gabay@intel.com>,
	davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
	netdev@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH net-next 5/7] igc: add private flag to reverse TX queue
 priority in TSN mode
Message-ID: <20250617121742.64no35fvb2bbnppf@skbuf>
References: <20250611180314.2059166-1-anthony.l.nguyen@intel.com>
 <20250611180314.2059166-6-anthony.l.nguyen@intel.com>
 <26b0a6cd-9f2c-487a-bb7a-d648993b8725@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26b0a6cd-9f2c-487a-bb7a-d648993b8725@redhat.com>
X-ClientProxiedBy: AS4P189CA0041.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::15) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: 298ac96d-f090-47da-9795-08ddad98f745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RnsRROpjKG+Zm7SZD7fF8kdqkmyJml+qo+IaD8xdCpP0uwTwfyYPs8Y4pMI4?=
 =?us-ascii?Q?S/RzR6vgTg5WHRNC+A6pDCe/CIYfzKmfM6YqNM7BtCMQ+uvH9coFr/om0jqe?=
 =?us-ascii?Q?cfUGa/rsRonJ+GewE8B14yJz0j7EQoLKqD1AHnnPuRj/zwAeKS1FJ0a75bRr?=
 =?us-ascii?Q?ty4R1vB4X+kPl/6XqPNEyIvKxlcBgL/rA1e0tOa+JcxyKsN3y+WAy+FqNi5G?=
 =?us-ascii?Q?BaBNAOKodGBdJw16+D8Ud7/deH6DELSvc6GNVV7RqM84X/q4xLymNkCnZVIv?=
 =?us-ascii?Q?obo4vMpujtR4QscAT3w9seFf6eISdEq3WEs5a9KNq6VT3c6b8QN+CbOy0e6U?=
 =?us-ascii?Q?+u8/dHlwayWLL3Y4A3yXGsE8mRwK3hOLN0sVKloAIHV08xfFya90P3qSln4G?=
 =?us-ascii?Q?Xy4Jk0DqWzoM6eR4sZOz1RX/BN18zgPmZD6xFsl65Yjf0NOTtceABdeybEAd?=
 =?us-ascii?Q?wzYYIzXp7473tieapZZGBv8dtdQocPJyPUfl7PA8/0Xzo9MuCXt0uZBoqoTb?=
 =?us-ascii?Q?farwxatTmNyyjohbnnJ0L8yBruc94Q8/+vn0j6/+wFpQlA6urRMGioh5Vi4U?=
 =?us-ascii?Q?SkzPZ/1tHR1aoyHauF5cyowGC3rj1VPi/NNHH47qnOmADH2tkxWSPGRDdEt6?=
 =?us-ascii?Q?i31VeAmutexK7D7qI5vBu0mDyIbsW2/o8IjTXmkyvfneWclDOo0xtBsP93YM?=
 =?us-ascii?Q?Kjorq65RnITMc144S6EFleewSJcihUBMFcY6CC4JTQxlf8PTwbOjWptUphSg?=
 =?us-ascii?Q?YAVSHlwV66Dpfd1Wfd2scaWLfus9icxNbHlWKxLfETn+CC3nxwHmama/1MHG?=
 =?us-ascii?Q?UbV8uiQ05zguUYK3I+kFSIQlPuBR8mZOAZjgjqGAk1r1c2ozutXQwykIz/d7?=
 =?us-ascii?Q?HsAB1oJ+jiCK9HnTWrvkmzkGXPZ96GNGR0v/5UbAByIk+S9E3CeHIIY+LzFy?=
 =?us-ascii?Q?TiG/HI+OTOaOO/DpQD1hNkMVXyVgx+Zb2IXBbA46tpcJ7gDmcm37Qj6DQRJf?=
 =?us-ascii?Q?tqO7iZ4nO8nPoaffsQ8exGDwieZdoMq4VxWztlZar6OhgN4I/VOAZnWlYEuH?=
 =?us-ascii?Q?vLRvF8C9cGCZU/t2vbxKPZfWi3UVUEiBo+h7YOqOw7k3egwaiAqtBrreiuwE?=
 =?us-ascii?Q?Jc3JNR/vtJE9Q5XZ/uyySp9nnAGBqble4ISXriN9TofCcXoF2/KFiqckP4ZI?=
 =?us-ascii?Q?XTpS2R/xo8Ps8n5lFmx3etAL5LIHjDgvdWVO8ktzg58CIVsDA2TGub2i7SwP?=
 =?us-ascii?Q?yfSOnXoIrzm5arGJg6sqhjb1FVQplpEanCkLtw6XiufZ33nRJIreiNmHEq3i?=
 =?us-ascii?Q?l2a816ix9s4S/36i+FzOrOrmxaDjthWeg/v4mGAMK9Q4Jdel7vWee7U4UCv/?=
 =?us-ascii?Q?rOfpq2M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fpy3gY5y1OYLt9Y3kVJGwpONnlRH76o0irwTkBFUaTpB84YQkWC0r3W+VK6x?=
 =?us-ascii?Q?kjKqApfs2pARBh51ybooys98zSOpQ2MLKiIgRRkoIVExjjs5M8c3nj63hiTp?=
 =?us-ascii?Q?7sSFlk315GW+0hoAGNM63BuAcatmCFrLXwOqfICPeOk1Ak2/wTApFWoQYADK?=
 =?us-ascii?Q?zVEaxBMqnQ7b6bH2Zh8TErAbp6CrlRhwWmky1ksMeuL5/CUjigEOW4NVAawz?=
 =?us-ascii?Q?6sBUzyWzfa1EvrIl4yI0kQhX9PXTmXvFgNxAfl4orSJkI4cSk+SXbyGTyN1r?=
 =?us-ascii?Q?zGeEFWLVRcSxxept7rhjyp0NkDAGRJNPxUsc/TZv+EZcUjwLbQJEoMgUutV2?=
 =?us-ascii?Q?0bYaFAVoZHbFnN5SnZRdyUK6hVqEvOYA6M006ygSWsgAlIigQ3tpPMX3WqY7?=
 =?us-ascii?Q?H8KTT/oLJQxKxKZFLu0J6eTXnQyPvdmJwR+JgfP9Wk15rsv1sa2zNfbZvQ7T?=
 =?us-ascii?Q?EeT9OY/fr5eCdDHqUd7qyvtOiEyF0J7cAbrW21HEgmqqcsjiKRBTQ1eb+v5O?=
 =?us-ascii?Q?qw79GJD9Betkar6HiU2CXcGD32za4Pz9WyXqaVb+MTJRDgAgwztC5DJs0b8T?=
 =?us-ascii?Q?Z58doAfTB6OtZQuLtbcBtveIPRWFXPre86VWgVHffSfTZj8oCy54L2rNntsr?=
 =?us-ascii?Q?HTH6+J+mLbe5modYYaOCUFBB/TXAMEwHLCFIpUioyh8AW7BLlFRU0L/sZ6xL?=
 =?us-ascii?Q?yZpI1DcZzBwYHcZjW9J5S1jKyUDDr9jCjQEJ+eRYnzLU0mUhrq+OFhclFos7?=
 =?us-ascii?Q?hebkUrTlSuQOvy2Uzb6D0/Q8geqCsV+158Ee53NvMjmxeKWfdUCcwxGShZzD?=
 =?us-ascii?Q?vP9uOZK0kQr0V2CcsEmc8pbKXhucF5ptKnn2b3KgTxBJGLDyMdfgp+63yQ/N?=
 =?us-ascii?Q?qAZb5FKD4fN+0GgI1F5KgfbVkC4Qak6ziYIC99Kgh7cYOn9FR6HHBJza1Y2s?=
 =?us-ascii?Q?F8XWDUrDRNJ8yYULxol9cE2enKMgpZHJkfUOI1xE052W2WSSYA35GErr/0aS?=
 =?us-ascii?Q?dou+hac0+g/eWmlWlpti/mo+rjZ1V6mSrwGwVLMXzWnzTAVZ/ZeRupagd7Ul?=
 =?us-ascii?Q?ACIOADrgBmJu7XfcFzgZZLpu74XEszQ9vpth+EtFTbNOXWHmrYu7yky3utj/?=
 =?us-ascii?Q?HqF9Z5nB3ZwCvx8sZhP4i+ij41nQAxKomKYe0y/cgK533cD+AK7XKTChtYw8?=
 =?us-ascii?Q?39apgy9hoeJ6VLDbHyAdRIicx/VU0BuC/k+1GOt3qogX0ps9cukW4hKr57xe?=
 =?us-ascii?Q?yCQ96FlgIsWTi+BZfqNdSkjlWrrpeg8b2Wbb+N+ipGW4h2Rsp19M4ZxJVASi?=
 =?us-ascii?Q?LqUppkn2z6Q3ps5wzzBOlYvmMBc3odlE5lYRhddCrrQJFFypPcXxoRxoJR9N?=
 =?us-ascii?Q?y0DlRRxFgGu7stK615w/GbAsG3RQE448pb72BpIiVad66o6d0vTv+TrPFcHP?=
 =?us-ascii?Q?Sak1MrMsRBA6WACpgjz2upuj4CI4f4wEmsqmqzuGmluAkElimIDWiLAYU+Q5?=
 =?us-ascii?Q?9a3HSa6bYXo63FhROQLoSZoJJAvT8U9kcVCDzKgFYeAwTA5IquWzSJ3FaYmQ?=
 =?us-ascii?Q?oFM5EpZe/A2dNVhQtjTADYCWSqZcCDPJ/748E4fVIgMj69+cUfxTn8s38pGA?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 298ac96d-f090-47da-9795-08ddad98f745
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 12:17:45.4602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYYUk2/E8IT7btdKgYJBMMUqBUxLAnmaZYbDD6GVmvx3G/gDYfgC1Sn34/Ig1eN7mw5erDEWt+ALDtxphRWQeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8465

Hi Paolo,

On Tue, Jun 17, 2025 at 12:06:14PM +0200, Paolo Abeni wrote:
> On 6/11/25 8:03 PM, Tony Nguyen wrote:
> > To harmonize TX queue priority behavior between taprio and mqprio, and
> > to fix these issues without breaking long-standing taprio use cases,
> > this patch adds a new private flag, called reverse-tsn-txq-prio, to
> > reverse the TX queue priority. It makes queue 3 the highest and queue 0
> > the lowest, reusing the TX arbitration logic already used by mqprio.
> Isn't the above quite the opposite of what Vladimir asked in
> https://lore.kernel.org/all/20250214113815.37ttoor3isrt34dg@skbuf/ ?
> 
> """
> I would expect that for uniform behavior, you would force the users a
> little bit to adopt the new TX scheduling mode in taprio, otherwise any
> configuration with preemptible traffic classes would be rejected by the
> driver.
> """
> 
> I don't see him commenting on later version, @Vladimir: does this fits you?

Indeed, sorry for disappearing from the patch review process.

I don't see the discrepancy between what Faizal implemented and what we
discussed. Specifically on the bit you quoted - patch "igc: add
preemptible queue support in taprio" refuses taprio schedules with
preemptible TCs if the user hasn't explicitly opted into
IGC_FLAG_TSN_REVERSE_TXQ_PRIO. If that private flag isn't set,
everything works as currently documented, just the new features are
gated.

The name of the private flag is debatable IMHO, because it's taprio
specific and the name doesn't reflect that (mqprio uses the "reverse"
priority assignment to TX queues by default, and this flag doesn't
change that). Also, "reverse" compared to what? Both operating modes can
equally be named "reverse". Maybe "taprio-standard-txq-priority" would
have been clearer regarding what the flag really does. Anyway, I don't
want to stir up a huge debate around naming if functionality-wise it's
the same thing, they have to maintain it, I don't.

Is there something I'm missing? It feels like it.

