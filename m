Return-Path: <netdev+bounces-188363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8FAAAC7A7
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 16:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40DC57ADD66
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 14:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95B3280327;
	Tue,  6 May 2025 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T8AGwEOt"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013006.outbound.protection.outlook.com [52.101.72.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C48253F26;
	Tue,  6 May 2025 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541037; cv=fail; b=IusiFoe57LxgTrftGcnvCY80Wdwg1l7z5L2MpuHQ06NO6ycaGVuL7dMk+c9g+R/0sqvr57IfMqRDWeWyhCbTVbMi62oP1bfe1shQkhymeaKDHxYuoS4FbO3xEOU/6paDr08fHqzCHNa9CTKCv1MldeZLlSE3De21J20SRZgouTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541037; c=relaxed/simple;
	bh=wAJRt56IJaEHcFJuwI69KFwn4tEdM2vRPi2yQnhG6XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AK4VhxoW0+UQIJT88uxBVmQ3biYdus6s2uLjJ8zZ2c/6WzorIx5lwv/GkZNVWVW4s2+rojJehumuD/3mu7nerOQxAu+8toCMFIVz02NSk85VYWZItvy+33zPaso9q02ye0NaNxCMJKm76/HwDydcOwS+xKrUXoFWF07do+9+QlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T8AGwEOt; arc=fail smtp.client-ip=52.101.72.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRbhM6CXni9prrM6daLqFm/B79kgKoqvDmSHJcFQBdeM8UtT961ezcFqU53ui7vFlUreaN01IXexnt6b2uEtlSsddB3yfPDuT8an5+xJ1830HlJF6u1qk/jAa82BNRqmRr35YJRS1b2yF4m38f6KNiHNaIrcISDWrHtXtKp1Uuoxwu9EoxYx/0ZWQ0ukdAkeBhFtzWx+oooqlDEvewN4/lYA+Vh3EQsBlXoGdlJsE1NRHyOMcA99HaJ8KxDKPuI1DAuvzLoUv1RVz7Sb5faloSxD1wkbUsErgTbqSy2fBTYUgrTcwfWBvkDY4uNLa/MhunuQ842cuvzC+IZ8Aw0+EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PgVnUvzyofbSEbfenjI53i+AJdWtMHJ+NGPNMhPQhU=;
 b=ATnCEdJhcOCJLU1m5Z7HE91PVz7KIkdRvvK5TX4fULx6aauwKWSKQHSTckIkz2Dt8BYsSbqOXNnw2ArANrc8AKWhql5yDnkTrbYdxFjNQxf2VgL1zgll25KMFTyUjXm/XWxICHSg4L1NgIQHLHO+qbORav2GO5exBTOxnq7cMvJAB+UwntbfhFA/fmWH2vb8VzlecUopsctWXAp5Wd9z4CLlyV2VMUYFe/rVaenxKaBVKkOCcBITG9Yw7Ab+BWyGhxZAr4Kzj0Z3ArAb32Vwn7vW9uDLd8acXPEpQ2xO3YsftyBfRETOc8yotLvQVkO3g6Ja2FqfRXMz27L6xL2UTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PgVnUvzyofbSEbfenjI53i+AJdWtMHJ+NGPNMhPQhU=;
 b=T8AGwEOtqERsIJsIqW6gGgrSfNKImaYqxwTnO6zVlL/x+mfUdvbESYpinXkJwbWXOnDSX2l0A5TcqAg9o4DqfLXfHCEewVykriZEoUjnKi5o4XphkfmVsEgJVcaX2OmE/FpKXSysjMbaGfIOXUueOPRQ9T+fZITHpTRGHqOd4zzHJjbVmk9kSf44jD+MRYkqNeu1Ca3geYEr4TGdXXD6Bi/TBED7aYWsZx9Dg8S1cQnGmG9VK2D84+KsOb7L52MlbLnq8fN6NVkaTnMXWUf8hr2Xp++8TIRCGKq33mDczY/1vV2lh/kdpLNYvZtSHahQWsoHptwWChjqf8S38NZjRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8278.eurprd04.prod.outlook.com (2603:10a6:20b:3ff::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 6 May
 2025 14:17:13 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 14:17:13 +0000
Date: Tue, 6 May 2025 17:17:09 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Meghana Malladi <m-malladi@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Simon Horman <horms@kernel.org>,
	Guillaume La Roque <glaroque@baylibre.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com,
	Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH net-next v10] net: ti: icssg-prueth: add TAPRIO offload
 support
Message-ID: <20250506141709.rnhvtoghn2tc47rw@skbuf>
References: <20250502104235.492896-1-danishanwar@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502104235.492896-1-danishanwar@ti.com>
X-ClientProxiedBy: VI1PR08CA0221.eurprd08.prod.outlook.com
 (2603:10a6:802:15::30) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: 25a42e94-455e-4171-c7d1-08dd8ca8b218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gd/mW4N6/wWG2mSk3gnpqBAX4V7k3obm8zqJLTCL1dXWRwzXGbnlCQNl1J/x?=
 =?us-ascii?Q?Kn+e8dbQ6Rc/+plwcoZHhq9PQKSCJvoTNhv9loQzZ8lPDQ3Dx4iJDRfkT+nF?=
 =?us-ascii?Q?AdNEr54OuvzpwAf54ZBKe1BQRnpLaV6JAwFYnMsxQ6wJ6dgSGJHT+NASdX/C?=
 =?us-ascii?Q?JRltAsIbBqyu6J5Fyl9ckNNj5WTjICerih7gdtEGXfzlRYpS1gQLgeHLHoSr?=
 =?us-ascii?Q?kY4SpxThteBFnnvQ2/tzKoiS45VnNY4Bw8YkPP3Xz7FW/xafyJJgMrTAW3X7?=
 =?us-ascii?Q?BOMlLWnBfJVkv5NQdmLxNpWpA6GmRywuqAyrrLslfhMGUCbbDYZB/jN+2T1v?=
 =?us-ascii?Q?Me48+GnWtljjb8I90CF2ZOU1QNIfqfXiJcyGLROFpy1e3mhO5xC95UirLr01?=
 =?us-ascii?Q?wkpvJLQpcpOhUYctyyygnQEn3kMar99tR7h5t3Q9gAtGzvhTsV6nd42dy5Rt?=
 =?us-ascii?Q?8swrSc2N9/HgeV00GjF8GF84rXev0+/61IZZ2r+Gk3FsKyKYq/E02VEcvfTK?=
 =?us-ascii?Q?NFqYkQBhGxBFoIjFW3Lxr+epBSPgONgPhDZas+XOeIfYRFITEssmShRrT81S?=
 =?us-ascii?Q?9aVVBYVq0mViGZQ2KEHQoQSdn1xsDdZi6LAK0pi4hr1vufVXHmptZc0pEka+?=
 =?us-ascii?Q?b06ATof6F6uGazKSlpQ3qfkSX24rgYu9FS2LquYurwgVvNBYGdJ6+31Q0AeO?=
 =?us-ascii?Q?5hkkDsOepDjFbKCHSRZx+CKhBrqlXz/cW4WM0+2hlB8bmlH7WlLm8lczpKU2?=
 =?us-ascii?Q?WF5rVd4h6ei4dtg5yhkB/h4+e1zboGGpbPRLGuuDxcr1qo5ntzVFt5gkctWk?=
 =?us-ascii?Q?uq75giyN1/evSb1S+OTkHf0R1A9hkn25Xsbc+3lDxBElZMD260/u12+FOhf8?=
 =?us-ascii?Q?IQTH/HI6l/tQ+AiFISm2hqxstZCHRBqALzTTse9SqD2BuwrtvgRRNvJL9MLg?=
 =?us-ascii?Q?TtrDaDrqS2TuF6sW4U3PuMIx9pFoWb/XcDw3jYnkIdbAIiKxZpXEYcgEufWd?=
 =?us-ascii?Q?qxqT7rQK11RQU5dxyMoPuFpw9jyGcTgJ8Ch9FPSqlhxg8YtIEV1HTdqhW9Hd?=
 =?us-ascii?Q?VW17HBMGjzVnaIOzbeZQq48CGGwUbuD7kVwQ1mXxl9ccTbfNniSRiZXMjGF/?=
 =?us-ascii?Q?XaY3051nypcfLsV8DP9i6tNGrLVWMDU336MzN8exQnsQhRjyjjD1FYG/0Fh9?=
 =?us-ascii?Q?JV7yLBkS8UNE1FUoGnA4DC/V8+QsbzRx0ZcOZil8vSoBZN+zroLVEC3FqSpS?=
 =?us-ascii?Q?L7174+MsETZMHxcKivLJMG8CMozbtYDT7lNwSkzXHfirmwe7uQ/UMtA8RdcZ?=
 =?us-ascii?Q?ez4FF5zoKGPKarSj7TDpqigbk8mSEuc6n+pOsCT6LriSERQkmYq71Kfhlw7u?=
 =?us-ascii?Q?mOiHb9+1cWR1uV+tgjfQv4Kofl36rUhm1hwwehgX/uupa/mKhTtMRM3g9hX9?=
 =?us-ascii?Q?d1FS1lsMYEM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M5qKY37xYB18RBPaSVHLqDxSCwxHwFPuZBBikdKRPLtJteUe+3oodWMcbxW5?=
 =?us-ascii?Q?A4YQDXXJ17b5X1fa3opcJfdH//uRvihVHpJSkAtnjWi+BEUqdnB6DDYpEqHO?=
 =?us-ascii?Q?DtP8QUZdn+A/v6X/7g1XK3gN2SSC+sUODlltFpfl86aGYV1TfXLmTD+fpf5h?=
 =?us-ascii?Q?T50xLEfWzRe1QI4VBsfKRIp1rPlz2Ppn2c24rsL7tZ7kaOd/aO6bZkjgC23r?=
 =?us-ascii?Q?3k9taSfS0os0VHZ+ClfG3/7GKk69OAlyodYoPabe2Ooke6WLN3nHQ4jMP5OL?=
 =?us-ascii?Q?VIWBM1A1K975F94BYt89gO+kQtKgS7s/8yoAOAsLVYjyUbJRbuoSaWiEcJVb?=
 =?us-ascii?Q?rxm03ticJDwUk3OMAsFt6ahqrJfrSZyQAjCcSHn7qLqPvQFGOHdOAXtlytFo?=
 =?us-ascii?Q?gJ4Xsx2+IpN285zxGZmQ3V6PUzf87HvnkjFUNnfH4s13yJVTRuyGhwY64eYr?=
 =?us-ascii?Q?lpXHc+e2nEK7ZZwbXWaUO3a9Wf8i0Qib3d8rL4XggYX1yVTFLSp6dk8ftJmE?=
 =?us-ascii?Q?cv86rShIEBbl2WACjZtOAwUXPQGzAqBzFGwV1jiLjiKugEsuFSI4HRWgoNeF?=
 =?us-ascii?Q?bEvBQwBY5zrl+OD2F9tjbgGBJjYsN78vthxt1U0JU/O1+SvSdS8mVdNb5w+/?=
 =?us-ascii?Q?f2e6vW4tyQM0D0PLM60Tm6RP9fjtddOoTFb0YMHtiQRSejnpopZQ9vx19His?=
 =?us-ascii?Q?6qc9V+BRXfTYMspTliW4NjSWoAOO8buEDEEKZxcSneL72GBnkfARSpqH7f5h?=
 =?us-ascii?Q?8Brp0/lseWPfKVdTWeAcsZ8uZeUppCF38TO+FZVmTwnCldewdOvflpSHcGYZ?=
 =?us-ascii?Q?ivMP0HVTF5Xmu0iQVr/2g9TV21Gtf/SslqIVudCy62wirfP1kgFUkEgEcSsY?=
 =?us-ascii?Q?3fpZshUpuwB2pltS++CcveQZdPSW1rFt+ELieL74WekO4GB6LgLoVh+GK8wX?=
 =?us-ascii?Q?pMAR7f0MEI/WrHm2smWThgMZzzqOrbPEEt0R0/txAVXxM24om+8XgAlk3cVE?=
 =?us-ascii?Q?mK5BLPqsUx3kxJybazW39nCNAttf8B61BKjzTl4RRnjLynMkLdriE/m6fTSg?=
 =?us-ascii?Q?niLM9xiNTRQmcj87IQM1GgZA9mQlzAm9ZvQMOfCkaOZiseMrE9H4IqoE/mZV?=
 =?us-ascii?Q?8iRPlVaDvsiB6kvZrqV57ildTT3i7MfUQ3et11hCWMOT6CaGQB612wd/rJZD?=
 =?us-ascii?Q?UbdliwWn8H84IbKgujhmPDuQJusJNVzGY3O4/eiJ6BhaO1mJPOOAe2P0haOl?=
 =?us-ascii?Q?M2/clMa43rgJQp2JXGChdMwckG1rX3/JiX0yxySrJVqDzKfxv8/3IxtMWhrs?=
 =?us-ascii?Q?H5HjN5QkG6bkENqqvnQXOGee968DqPQuf0QdABi9psPs/d9F43p/sxoQSQ/2?=
 =?us-ascii?Q?Yf1nPk2OF8hVuqxvYPlWzg3Gr19pjPyZFDKhm5Wkgp88cbnZSuWIgXvumU6F?=
 =?us-ascii?Q?53G335lVwRKhm7JD3bWBn7VwIXQXd0GUcXz7SdmP3lQ6/iEsshI6PqB7/1KC?=
 =?us-ascii?Q?iqJ7s0P9HPk6XruH90ZCB+8pTFk1N0fGEEdzftqHq0Kv9D7EHYbL6Vpde2Je?=
 =?us-ascii?Q?r7U5nFa+17/2uo3iTKVDHe7fVhM9/6SDyOzCzyn2+W4wm9UKQ1/wRys7PFgX?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a42e94-455e-4171-c7d1-08dd8ca8b218
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:17:12.9728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LwASeia/h68hcqapefn5V1VzQq1Isa4D7gjYZ1twB/wsj35I9yNPnBIHU/9KYAh/vHgqMY1bWWkCwE7krDJ6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8278

On Fri, May 02, 2025 at 04:12:35PM +0530, MD Danish Anwar wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> The Time-Aware Shaper (TAS) is a key feature of the Enhanced Scheduled
> Traffic (EST) mechanism defined in IEEE 802.1Q-2018. This patch adds TAS
> support for the ICSSG driver by interacting with the ICSSG firmware to
> manage gate control lists, cycle times, and other TAS parameters.
> 
> The firmware maintains active and shadow lists. The driver updates the
> operating list using API `tas_update_oper_list()` which,
> - Updates firmware list pointers via `tas_update_fw_list_pointers`.
> - Writes gate masks, window end times, and clears unused entries in the
>   shadow list.
> - Updates gate close times and Max SDU values for each queue.
> - Triggers list changes using `tas_set_trigger_list_change`, which
>   - Computes cycle count (base-time % cycle-time) and extend (base-time %
>     cycle-time)
>   - Writes cycle time, cycle count, and extend values to firmware memory.
>   - base-time being in past or base-time not being a multiple of
>     cycle-time is taken care by the firmware. Driver just writes these
>     variable for firmware and firmware takes care of the scheduling.
>   - If base-time is not a multiple of cycle-time, the value of extend
>     (base-time % cycle-time) is used by the firmware to extend the last
>     cycle.
>   - Sets `config_change` and `config_pending` flags to notify firmware of
>     the new shadow list and its readiness for activation.
>   - Sends the `ICSSG_EMAC_PORT_TAS_TRIGGER` r30 command to ask firmware to
>     swap active and shadow lists.
> - Waits for the firmware to clear the `config_change` flag before
>   completing the update and returning successfully.
> 
> This implementation ensures seamless TAS functionality by offloading
> scheduling complexities to the firmware.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---

This is not a review comment - just wanted to mention that a week ago,
I've added a selftest for this feature at
tools/testing/selftests/net/forwarding/tc_taprio.sh, and I'm wondering
whether you have the necessary setup to give that a run. That would give
maintainers a bit more confidence when merging, that things work as
expected.

