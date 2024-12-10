Return-Path: <netdev+bounces-150617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174EA9EAEEC
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 12:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3331607E3
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 11:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B94E2080FC;
	Tue, 10 Dec 2024 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JeiIdOMO"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2042.outbound.protection.outlook.com [40.107.103.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6DD23DE8F
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 10:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733828401; cv=fail; b=UfzeAS8nTb9rbV+k/P5eBEO5xPgxM6VmTJfUTxHqPqtSG+0Ud8ztbYQqzwQc3XyyR5NvdB1JVwIvC87g7TZ6R8rvVc3S92d1wac6ZFP7AT6s6UqJBsVsPvL4qdz0I+tbgPBFMcmCNUxpH1y9xQFaTgz5Q0jgIZzyTh7DECEZOMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733828401; c=relaxed/simple;
	bh=8los0tOTyG0Dn/qcrCb1JshphCWg1/gQcyEa53/aCdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fMOGSxCXRLZ4QiwvWIc+yDCtdUwFcUrp4YbOl/+ZfSTw1G6cdrQhM5gEDa9zkLam2JODCszkhX+DqWkSvudOMZXt2qUfSTmPWWIe30DfELvPCJfa5RIaS5ljUYaQkU7FStebBd9XP9h2kAsMR2N33YtlHISBFBDPltPEy8ZroUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JeiIdOMO; arc=fail smtp.client-ip=40.107.103.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BsU3m0KlVikahXYdcIvMuVso89vqksiRUxkfJSwtH3tonjXkOgXjUvqsXGcqZFfqFgtcjdMJUJp+CYg9FP8+N0+RkZUmXDJovz9w0hCMEIin8ox6ZWGSMDmxa7wjSUGpXdMWUm7vHgg1OHH0sm/pFrnmYrPAhKBY1XK2fIuKvctkefoReI5xSszuwz40sCqPh3on3lmEEN2hdCf9Pf/fHjbK2E4yIWOQaR9xRQ4oldNBB46i9dju/fa7LGJ751CxSnb8zu04O6OrUL44LG5Y+EBZ+/bnRJssyZFWOC4OJkPnna56OobfgYgH+nGpaYSsrCmWPYfIadsYhwLxbejsPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyryBjfQ4gmnb9ckQtyd7LfK7QcH8TsluReEBBZm/TQ=;
 b=gYCvYCEyrPW+dzEh41bnejNL/rBxgNNwQtLZm58DQRX2CUNJCQbkzeCjJ5+Cikj/3Mqg+e8IPmXEKBnmN9xHILzI1grbObVnaq7LZX72dmXxhJABMuIEjmIndtqfbB4u+iu/XUlsUw2mU1RtH20zecC/d6v5pxj49gGiZ9Je7o02g4fW946S5C4NoXkGRtHBqLAYVVOfh/dQjTvEUYBJX3O+gk3dKhiUNQLdqcUkadQSLVKyLCoY7Yp+oSpvwGHSNJZOWCJukVunLeHblrJuu077+hYs6eI5EgcWQ5Vzy0FkrDoWG7qSNnf1fwPj5qvx0zGD5yBo/D8Bbd5svInirw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyryBjfQ4gmnb9ckQtyd7LfK7QcH8TsluReEBBZm/TQ=;
 b=JeiIdOMOFEC7L0NOAxRJv0Pn+X0asfdMkdehZ6nY4lTw3LHCDr+3vbUqHzns0dHTYK5SqsFkVQfFn9IFx72AdirL/3znv6WWfzB/pEEV9DKmWknAx3/znk5j0jcdImimQvrbPuUVwpq3mLCGmqhHtoxEoZzG2jv7KfYITwasWUbfnpmIATHGCkbDScSVLLPHfpLYgCelQrddmEO1ofBVIrOXjQKhUNyvsUKUkDIGyFb7WB9xtLkzXP/T++APayUjWJt8HurmdUTATBKSqGtr/RFaBRw1KotwwfOpZ1G8pNFYGCIsKIKMgcWOgg4p0sW9pbwwsmpj6FDxlQHGfrhbYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI0PR04MB10095.eurprd04.prod.outlook.com (2603:10a6:800:246::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Tue, 10 Dec
 2024 10:59:55 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 10:59:55 +0000
Date: Tue, 10 Dec 2024 12:59:52 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v9 03/10] lib: packing: add pack_fields() and
 unpack_fields()
Message-ID: <20241210105952.xbh7gnoaxseni66q@skbuf>
References: <20241204-packing-pack-fields-and-ice-implementation-v9-0-81c8f2bd7323@intel.com>
 <20241204-packing-pack-fields-and-ice-implementation-v9-3-81c8f2bd7323@intel.com>
 <20241209141838.5470c4a4@kernel.org>
 <89f34386-1d18-423f-a105-228eb3d9c345@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89f34386-1d18-423f-a105-228eb3d9c345@intel.com>
X-ClientProxiedBy: VI1PR08CA0242.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::15) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI0PR04MB10095:EE_
X-MS-Office365-Filtering-Correlation-Id: 71911a89-eac4-4f6c-7e33-08dd1909c7c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AFAl8eHsqZcEtXFccKyTCQi4frTiZENp6iJFg2OGL+S+w6jKTrrD7qhKiFfQ?=
 =?us-ascii?Q?pUKmed6UgxMYvNZFpL+6hutYn3s/24lUzHZRx7wBsmPC9mw2bnIW2KRkJ3PN?=
 =?us-ascii?Q?NP4qXYNydn9OE1LaXWtfbDp8pZ0JRJ356n/MTEcXatXzwfD/Rew71OrjDF0F?=
 =?us-ascii?Q?DOcHr/5Bg6AtmI5BrhLtD1p2hAxdGoMm7X7OMkONvYJxW4y4quEL8wweTIbr?=
 =?us-ascii?Q?cR72MbZ7Y0G2oOQEsokZowhe8Dn2oO59K4Kta8G0B7PvCimPrJMIPZM1FQ0i?=
 =?us-ascii?Q?+fk3JUY45MivdCpZ6qdg5o/gRmnmnEQauKktFK8ceMjKjRAgXAjyNp/S4D84?=
 =?us-ascii?Q?E49reFoQHXfTtwMhgxZeOSWa6EmW+8sTgne9PZcAvUUP7LgZUTVqj7Lij6hq?=
 =?us-ascii?Q?1GTODuUuWREaEi0CZUvjVEGKfmlk0h4FA+RAsGJfmLKIBYVbslzZKQByrptU?=
 =?us-ascii?Q?NFtoz/iFKJ7g52FsX1OiHhUyhA4YjGpZlBlHyCmzpb9eUVzZbbusm2TMox5t?=
 =?us-ascii?Q?Y7QfVdCCDo5yqqCnZMOwgFJewUngWAZjemR9lCE2Qf5u7uugcfaABEvQpvDS?=
 =?us-ascii?Q?/huc1YjeVs63Dnt0F9u6TRl6Ii6C+GkURRCDtSH4BU1sfUgDeVMkUXQHIkjq?=
 =?us-ascii?Q?LPATKrAoCVIoPN1aHjOV7q5glFAfR0hY22EDBx5V2lAYJwo27HAu04H2weaU?=
 =?us-ascii?Q?H+pu0NeK+HbA3isOPBsVEuxwuUHEVPe+gU6G6njsaB8yFmtyAycQ6hFuEH6+?=
 =?us-ascii?Q?hWlcSIJuSD02cMvuDI4N63Pf1/+36X3tqVsL7PhXM2QlVntq0eM6FoFa34vJ?=
 =?us-ascii?Q?n2HLxJN+sgCF5HHHRL4WiSCMQEE0Kmtc1QvDOh9S0iP7NgFWAYziyiYIp652?=
 =?us-ascii?Q?uzSyxhDUf6rUJOS4NB0rz9CMvLrC36hWYKHnKVH7M3gZhNMekmFdc0V7T1/O?=
 =?us-ascii?Q?oBvB1ivVzKkaK+8Y3A/4bWQpgpalAUuzcro5jm0eWfw7J53v6BbwXsFUZVEE?=
 =?us-ascii?Q?uhtOVPMaBohmcPssdaG6vX6lJ9csrH2GUKiMxtJfphuWJo/GOB7VfydOXAwe?=
 =?us-ascii?Q?fovGXJ12OOIi3xhL6i44AzVBOCY81iH2H2pzqsR4ttac5HDALf6JBgxloo9M?=
 =?us-ascii?Q?7NyglOxZT5ekbqvdmxMgzan516J2ytbWmm+UOWaeHaDzVkH0OrmRweFZeUWx?=
 =?us-ascii?Q?cCaMbPBx5PptOC/6Nh0oJcCx0aq/sQ4tGRVkmzLpie9TJa8UbQqHPq0TqA3x?=
 =?us-ascii?Q?36oHlWXZcW19FMkoTPTVbT+NzNQm3lZVJthQWkBSvLkk7OWZie/t2qtcrWV8?=
 =?us-ascii?Q?0LJ4EuMBi8A5PJfKJzaK6ZEiW8ECqV2HVQe8xYQeDI95HA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4q4TY8gdULLeE8WYh/CcA+HMFtNOGf+pkcceTnhxBtZWiGZAlDgxmpIFMWhc?=
 =?us-ascii?Q?5w+k9CmHbFIPT34wqfSmdI6nP7RzmdLNfGqRF+utZMXykmAiQe5C01x8jW0h?=
 =?us-ascii?Q?+EoHROEEef6YcP7leBWiiXKBaRX13MQFl82pWTjYWuBezep1i/6Ufo7bSuT4?=
 =?us-ascii?Q?emJsjD5N+w0h+HiMkRCje2lygUcbusivCwTTccHF+slk0VJcJXsLKeMIO6TB?=
 =?us-ascii?Q?vbvVc0Yxt/CQnJtfOGlXtNvPzAoYFcJpZKrBmmUWL+S4WFkCiO5KvZpeRYv0?=
 =?us-ascii?Q?9t8KnodRR538kS/vqsek55tApRnwQdm2CO5K2IvGhmymKOvuII9rGvtqaThq?=
 =?us-ascii?Q?dO8cHR1TeDqzrSqJYw0icfgqHBKHcnq5D5lJCKKa6QN4oquV5kAYk57BkzvP?=
 =?us-ascii?Q?pTspjyRYU03d7z5aoHhRNS1nE20FzNAYpFXq1GHyW4GFkZlRLoi17tyeqBn0?=
 =?us-ascii?Q?NkLEVQUW9ammFFywMPAGIpSuh2ySHK4C5tA8tDlHlyUGtBZLc9IoE5wfnLeh?=
 =?us-ascii?Q?JozJfRVfSgqEDSBmOMKb6IPdhWZvA9c8xwGaOa0a0Okvp4zIBvnAgy2qv/Rd?=
 =?us-ascii?Q?CYaqmIA2MtlQIII4/HaSztPGejIzjPLfTW+f1KfFtYlCmAOZNwrhfdVIqD0e?=
 =?us-ascii?Q?A0ckBRgfZ69rhzwK8wYHwHO976Wv293VQhfEvdS62+U+1Dq+92n7pEfkhEYh?=
 =?us-ascii?Q?hFwS2224UmCAnGT8Y3LOMmZ4zrpGUsRewoAOw8ga4FZ784u00S94jOd9jHCN?=
 =?us-ascii?Q?nJ0zcSVrkzZX1EkEN3/NvvaPzJNCZym9NdbULqfgBZx30kMtQrDbMeugOKAN?=
 =?us-ascii?Q?/FczC+VWvZ0GU5kNZI8Q8ZY4Oa6c3VMt5+kGjZKeaGxDADXYRsUnGbwZPJcF?=
 =?us-ascii?Q?nU8+ZmgiY7Euw4XfGnw4bSZLItAHqZG84aDDVpAp4Vllq8Wgsllf/BdXWi3b?=
 =?us-ascii?Q?80w7PiVuVSQ/TsfzMtHDftDnYGoUTrnxYcZtZrZRHj0NULfg7+qMWuGDMWt+?=
 =?us-ascii?Q?ykFV9Sv5pHwQXwZqEmzyj8+u5K8/IW5IhYyMfYSi9wvkOX/lNzl71Vx1Q10j?=
 =?us-ascii?Q?sCLZ00f2miyenMR5WjP+2kFeQTZegsew8yj7P4SA8/JgLD2Isk+sEsB2YyID?=
 =?us-ascii?Q?NWGOuH6q9G/7/Z5YcmeHhrSitTkRDJ1kCf6oThm5SWWQN867uqiM1y8ODjVJ?=
 =?us-ascii?Q?2efHe+lHcnQ1jlPHs9AsdQOxx+Xq3ZyUcfd4ChiT3FUk71R1Iio1pMvxhHNE?=
 =?us-ascii?Q?yelwUXHRdKPyj2N62oZvj7jfG8m8Xvjhjf12zGxYqJotbXfhIKAfvNicCYyQ?=
 =?us-ascii?Q?94rdjOFi7cJUBbkwVMccOVuTaAv3tVLX6bdPCN/4Hff8r76vKP0sJ0shGImt?=
 =?us-ascii?Q?+WqZfMpI+iunzTTdwaPZa6cIo2LpBK9mgpieGEO3cv3L0fpFFHitUHsV9dAy?=
 =?us-ascii?Q?I4g/SQn90PQAU1trgxaN6KUSIAGYe8YzqXWEq+2GBT5oWva+vC6YW9KgIsqD?=
 =?us-ascii?Q?qrQfnJ/HTv8vLp6sZnKfHGwwSNczUT3xPglsDlISzvbmFmir19kTEjpb1aH2?=
 =?us-ascii?Q?QltPeWNrDg53hIuAQQUh3UA/A+CYbQ5q7vKj5UEjNEpigKjooZb75fNSART4?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71911a89-eac4-4f6c-7e33-08dd1909c7c0
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 10:59:55.4781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JhDWyK6Wz65rF8TKZoZ3qAXGIvUeM2VBTfF5EawkOUM7tAztgRkDGgiIa0dUCAYfPCpoTJO/cuu6k3di8Z8lCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10095

On Mon, Dec 09, 2024 at 03:05:54PM -0800, Jacob Keller wrote:
> On 12/9/2024 2:18 PM, Jakub Kicinski wrote:
> > On Wed, 04 Dec 2024 17:22:49 -0800 Jacob Keller wrote:
> >> +/* Small packed field. Use with bit offsets < 256, buffers < 32B and
> >> + * unpacked structures < 256B.
> >> + */
> >> +struct packed_field_s {
> >> +	GEN_PACKED_FIELD_MEMBERS(u8);
> >> +};
> >> +
> >> +/* Medium packed field. Use with bit offsets < 65536, buffers < 8KB and
> >> + * unpacked structures < 64KB.
> >> + */
> >> +struct packed_field_m {
> >> +	GEN_PACKED_FIELD_MEMBERS(u16);
> >> +};
> > 
> > Random thought - would it be more intuitive to use the same size
> > suffixes as readX() / writeX()? b = byte, w = u16, l = u32, q = 64? 
> > If you're immediate reaction isn't "of course!" -- ignore me.
> 
> Its fine with me, but Vladimir was the one to change them from numbers
> (packed_field_8 to packed_field_s and packed_field_16 to packed_field_m).

That was to avoid confusion with the numbers in CHECK_PACKED_FIELDS_8(),
which meant something completely different (array length).

> @Vladimir, thoughts on using the byte/word suffixes over "small/medium"?
> 
> I'll work on preparing v10 with the git ignore fix, but will wait a bit
> before sending to get feedback here.

If you both think it is more intuitive to have struct packed_field_b,
packed_field_w etc, then so be it, it's just a name. I'm not too
attached to the current scheme either, and I do agree that "small" and
"medium" have burger connotations :(

