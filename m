Return-Path: <netdev+bounces-138639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209429AE6FF
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDC8D286035
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 13:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D821DD88B;
	Thu, 24 Oct 2024 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UcuNh8Sd"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011005.outbound.protection.outlook.com [52.101.70.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92CB1BBBEB;
	Thu, 24 Oct 2024 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729777751; cv=fail; b=RqcN9Fe/IKjfn+T4E+SySEDHz/DKG64u9VZNKWLOz8g0cAIg2hPjw0c66ddqwifZI29edtlKq6JPSn/V22QjL2ppGCDeJWLqBOmyQl4kklkY7gn5j7xuNNgnwCvqj/WBF9fj7TYzuahvR4mGn1uLmPxhGcvSQMdPzhTBtlDuSD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729777751; c=relaxed/simple;
	bh=fIM9twb9aB6IZmpAADmlLvr+Ykp2gUj9cdgyKfZvOB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BHvHpRhbnE+CX9r7Fltfm0rlW1d7X5dWCSqjfC9Vx72wM1IYqrkabf1DjbFnIR2XGpPEMP/p7ENfskUWmvRpfTHJnd3JsukIF67+sITZHhstHm/yYQFtNI6Dloj/yw/WUQ6RWZYU6MBB3dXI0SFqdCMcujcJqVGOo0RSlIjIRds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UcuNh8Sd; arc=fail smtp.client-ip=52.101.70.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAI19tQ6YzN/ey9FYI/mc7o9ugB4ksfWLEj9nask+PiL5X85U8j6fyKQSRl/XjIfV45ZKGRha9uxgfvlW/wlnjEN4vr2JJEZ68h15pL8lj9w95VGvfVUQ4r8vDL8RYjaqQc96yTTo6jqmgCAuNRQ7troirENi+QQaL/ITAPwXmm46LAtXxlHyeoOr1FnN1aYVxv07Wf4lGhhSl87G9kERT1qDd1eKnWk0yRsTuvEGe/LG02PSkxsSIDAO+v8JpWkRzCyb/Bv2arW2yqHVbNvK9aP+DG4tjfmcGaV3e2wH9PmsvsPEq0ay6Ws5RD0KHm5cEx4TA3FPutYJNyfIsTwHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Atn+54/XkYhE/dSRaFHNaQRan7HybTJ8JycnDE5f13w=;
 b=P2czBnv0BeCgNA9anM0A0djXelcE7MbFlbRy8HJ/Bxn9XLnOd4G4z8O9nT0KndrotfqygPWJU1LxxqWqQTUPZKc4yAcETtEtdEXej89FPZonAWRwFRRH2DujDcIOnUoHlnzJSf7X34cm1El712AdhotigoYfuBmOfbT3bk1foce6GE2ZSvqEyaCpzVU1Ff0oIqFj7KQHy/Lc9tDPONkyMtihSrAZUgjFL43ki27Jujd/hrtjnOTYcw7ueMFgflB5Ep10a6xYp+0aHBJTmxir4m+2/bONTwI2KrDQbep1lF6fGvwrC76GjoexUBBGMfrgAS6J4PunUKG62GQpzA5Xyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Atn+54/XkYhE/dSRaFHNaQRan7HybTJ8JycnDE5f13w=;
 b=UcuNh8SdDbbnt7NT52e9HWGNSouWxHG7UGzF4bTr++EhzYZxIDUjn2IPm4YfZgj4+fSAG8yVMcV+f5/5awrjH90rxs3YIGiCR3R+YD4MLK1u/tcqO6JcFszvvw1JQM13zPPkYB+F9t3DNTno8/lhWTYCDkCtuDqTAiVxzZUlFpTzIF5zhyzt4JLX/KFnScjKCt1mQ5ReVweTcJ+Pi+2UevF2gqoZtgIGk1e3ErvBDdm9XfWsNwDjsUdem4pZw/gTz0Vny3BSNtGJN1OJo0HYh0e0aS/NCAgHaSEdVgMwc9QaJ4UCaqnfCVGRPE8V9bmjB6LzTgKvdac3yBv37WJjtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PR3PR04MB7402.eurprd04.prod.outlook.com (2603:10a6:102:89::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 24 Oct
 2024 13:49:05 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 13:49:05 +0000
Date: Thu, 24 Oct 2024 16:49:02 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 3/8] lib: packing: add pack_fields() and
 unpack_fields()
Message-ID: <20241024134902.xe7kd4t7yoy2i4xj@skbuf>
References: <20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com>
 <20241011-packing-pack-fields-and-ice-implementation-v1-3-d9b1f7500740@intel.com>
 <601668d5-2ed2-4471-9c4f-c16912dd59a5@intel.com>
 <20241016134030.mzglrc245gh257mg@skbuf>
 <CO1PR11MB5089220BBAF882B14F4B70DBD6462@CO1PR11MB5089.namprd11.prod.outlook.com>
 <e961b5f2-74fe-497b-9472-f1cdda232f3b@intel.com>
 <20241019122018.rvlqgf2ri6q4znlr@skbuf>
 <7492148c-6edd-4400-8fa8-e30209cca168@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7492148c-6edd-4400-8fa8-e30209cca168@intel.com>
X-ClientProxiedBy: BE1P281CA0281.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:84::14) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PR3PR04MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: 844e2de4-e776-44eb-0766-08dcf432a00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pSGSUkZn5pKqQ69pLSAf+2D+otBpQCRy7cYbVy58kyEoeSAKkCI2xyghqV5G?=
 =?us-ascii?Q?9vV75u4TjeZx7wNC/FpJEGT/8PE82iJr8W7cT2qSl0FbTNVCS8ra4oZEOx3i?=
 =?us-ascii?Q?0v3xVn1PEjH0Y7W4d3Li2FIqAA1kzGWWU/Z5IM5fyUKgfcB4K+yKcVVBG+Eo?=
 =?us-ascii?Q?9Ojx3FUmbjzqSbD8HtcJNArUwdvieqYrbAKmDkEXPTq1MMCmaZOkcTG69vq/?=
 =?us-ascii?Q?hWpWWHo5H8vXI/NSYbILMujxeKhM1JzNdQHyKg55mtAfAEFSSmuj/1ww3cy7?=
 =?us-ascii?Q?BkNIy2KfQ/dlbh7BFLtmjvqfzZmM2dmuMmqfE7mocRVTjBtVxf2izVdARu4w?=
 =?us-ascii?Q?fK9mb4d1ymMJTpAHCAafbPMjoYdI52y9UqyHz8cTLhSErcaCBHr8YmeNeHpy?=
 =?us-ascii?Q?W+tsHQNCeeYC60LEK+vIl5kCXUY7SAnMLJN4yTENRxnoEOYFD7Z4kjQyIRAh?=
 =?us-ascii?Q?fql6L1qGf7caQDD/GnBA7+9F710biIvjTCV9mPv87NOnLcMX4NtwSS/wi6rs?=
 =?us-ascii?Q?9YayXaCNDYKYONQ901sWjGy/q4kev8WHT4t1BTW9Vk+AOnzPV0ovBRoRNIb4?=
 =?us-ascii?Q?Z3En2dVTI5QwQaZ0ei6JEr4YpJAqjh2VmTpQDbwg4owKJ57qUam46A++kNIV?=
 =?us-ascii?Q?/kbkiAxMtlUDAHKByOqv42ffN/2qI+TUFMd/jQhLdVpFT2r3twab644lBjkO?=
 =?us-ascii?Q?h+5jhOdQ/tdc1NE/0uep4prnfevc/gyBZfMWGEYmE73pqt2mHyR+IBfDCZ4t?=
 =?us-ascii?Q?KOjvxukTO3g0q1ymJBIgX86K/ZlVmmcnIdYnn3ynJbaXD67U9r8F3caI0cj/?=
 =?us-ascii?Q?5OI3K5+T1+ZJZmQtzGZavCkD8wW3/Q2UNSzj6ar3baRveolt9KHGSFDWNkgT?=
 =?us-ascii?Q?5ViTPscX6ARZdZ7xa4eMd+W2KgtPXA4PrBCygUANQxZO31iQttcwb/tWkQsv?=
 =?us-ascii?Q?uGwAC3V6UBxuMAW/NeV3gHSCRqw7VcXnz78A6POZLgPsm8oaeVwJgdsx0z4x?=
 =?us-ascii?Q?cjYlje+MDkWHxs407CuhRc5ra4WrMe0DUPqiUu253JKVdC/PtdtM8VKj3MjM?=
 =?us-ascii?Q?zBtMbrWogypFcKOlLoiJOqEGzQt7X5ov5rPBXssNeU9EWQSfvTW4pDL3ONdX?=
 =?us-ascii?Q?3Uq4HPyS47VP3zMQxLLEauq9DCbwKxDsRijCnJ/v0KGSVAxLuh5VvHs/ln4I?=
 =?us-ascii?Q?L4I0xyjyuyQQP6YOGZG1Em+IKRbWXsGXqBQ2yjwV7164gM18R+gcgsaktZiw?=
 =?us-ascii?Q?+zEGKlfDzXL92PQ/dWC4VphtGNzhLZ8RXY3mFsRlGx934dNThpNlDvrGfwBk?=
 =?us-ascii?Q?+cQSe5TzHm/fz+1C6lZGcpwX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fgkA05HkNddntEF3b6lkGBpfDbUyP+TrLqIJ7/NBUZbwrQsrO86aGNZsq8Nx?=
 =?us-ascii?Q?Xjt7PpsKGzrElLBxW8xQ992OFRKIGgQBIJeNbzNti7QDn9LtXCLqsl4Ah6Xz?=
 =?us-ascii?Q?SVhzWPME9eNblvbO4nY9cM83JIepy7RuPMls3O4LXVjs8KpmyiEGsSFwx4rO?=
 =?us-ascii?Q?Ygqe+nNxl0NvOImfncObiKSJ55tVNwoqdOHa7rAtBJ7dUujQH1ian8/RIn6O?=
 =?us-ascii?Q?sGPbA9sMIAcYDXhrO9QhJ3Bii5PJc1o2ljNOX71yhlXqFPehbmzmEdlKLzjo?=
 =?us-ascii?Q?H6KDQpgG0871m57MuNIFi3cjbKXCqKwTOdXwfVwAx40ltBQFmzC4oZ7guy18?=
 =?us-ascii?Q?U7ESF0TU/UgEY1a2i5muxOk2w+ZXUtmnD25UlHlX9HWREV5va1NimhaCjjAn?=
 =?us-ascii?Q?hWjKVugWRKTBKiAIIffo/C82WN6SHCk3IJlXtMPbEy4wU/iHTqKGZDpMDq9X?=
 =?us-ascii?Q?ucYv6dGUcKZHXxvk9OjxPS3bSYVNkXCHmrkq/jaGp53d9XVgzfdJGd+W4l9Z?=
 =?us-ascii?Q?27HHQmETx6B/YEjbfcNkp1SUaY7ftQSmmmIXIkev/nORUbnJX+91Qv3NP4ah?=
 =?us-ascii?Q?Wqo9objUF1RAYnzv3FDZZiwXbJJyiLaV/x4SM8M14M4PQdWxJ/YfCimfd1N0?=
 =?us-ascii?Q?tIkpNDFje9UjMcXabM6SPA81lktC1ZM28n6XlGzby95E798h7LNxK22yfsab?=
 =?us-ascii?Q?O445spPNpmsNUHdhaVHVBWIAYO918TmSczti0YaPgw5rLmv3UcCMbq/mEqRD?=
 =?us-ascii?Q?DB2INpeM4lHAFsDPwJiQ9dEf26ebmPuoCxLNCWKFfNzrJ1tpF68za1itNkS4?=
 =?us-ascii?Q?Fq4nyZClZdiv/oBZW1cxW+sV7s32p1RuwTkglLGFBQdszUWxTp+usqIDiLqa?=
 =?us-ascii?Q?8DyU5IEaWy7tLGGc1/3yA4B8gRc1Pn9x5zfnyMHtFs7xjtrMqMN40+SeeRpQ?=
 =?us-ascii?Q?u/jfm6TEudVnejfA9HDTHgW9OgdGpi6FmOv6BwklM2g6nn6EQjJMhfdLrZoO?=
 =?us-ascii?Q?2Hy41pw5hbvMfu0zQ3oM5tDTOPyYVCUgV5R+3tAWRtpI4MyT1UUcDb6XTL2/?=
 =?us-ascii?Q?InlLVSo+6hK3sOcFy0NxoNiytMWBIeDCXmo8CA/jlG7bL348mn5bB5fg8ybH?=
 =?us-ascii?Q?S/amzhg2Nmf4DQ+BZwd5l7aL2VBiFAnHxaaZQ5fCGZnYXtBu9Pohzv9dsrpE?=
 =?us-ascii?Q?H5Hw8mdSVXfGy7ZH6x53irk5oorguFFNaVbMFmkiGc+1tDiIrpjPnSwThHCK?=
 =?us-ascii?Q?5W1zkcUxPBkKjalhtiOejmYtf+sXYqo7+7opJNMpye6Uqu2pvij1xCdzRDO+?=
 =?us-ascii?Q?C8Ufkox5HsxPFgIanqhOa00AJrlohne3RPs+xKLyOzj06NTvalJTwAcUtYd3?=
 =?us-ascii?Q?Bhy4dteNQD1RgMTjy7EBqvWju3VeywymO5stPaBiVpuq+gUVT53kWLjSMTps?=
 =?us-ascii?Q?TTsi5DNEesHvgCVrBMlLw+VnvsiHDfgPaJGYR6U0mKqyd3HiiqCYHZcMlhFt?=
 =?us-ascii?Q?0sVcMZNIdJh6rGVLdFUuofOoUJ8yU2x/uC0qvmLiteQa7hHdExEoC/obojMh?=
 =?us-ascii?Q?R3VNckkZa39dyVpsf70X2sNshkbwYheqs5AGhcuWEORXh62xGblMmFLqS6v4?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 844e2de4-e776-44eb-0766-08dcf432a00d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 13:49:05.2159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: no3CqFIjpo0ltFJWDw2MdOawXRM1AXVJoWnhtGGBBfrm5CRhcI1RkTDVRJBCDcPr1J5RYWoB9gZSHIj4HzXBig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7402

On Tue, Oct 22, 2024 at 12:11:36PM -0700, Jacob Keller wrote:
> On 10/19/2024 5:20 AM, Vladimir Oltean wrote:
> > On Fri, Oct 18, 2024 at 02:50:52PM -0700, Jacob Keller wrote:
> >> Przemek, Vladimir,
> >>
> >> What are your thoughts on the next steps here. Do we need to go back to
> >> the drawing board for how to handle these static checks?
> >>
> >> Do we try to reduce the size somewhat, or try to come up with a
> >> completely different approach to handling this? Do we revert back to
> >> run-time checks? Investigate some alternative for static checking that
> >> doesn't have this limitation requiring thousands of lines of macro?
> >>
> >> I'd like to figure out what to do next.
> > 
> > Please see the attached patch for an idea on how to reduce the size
> > of <include/generated/packing-checks.h>, in a way that should be
> > satisfactory for both ice and sja1105, as well as future users.
> 
> This trades off generating the macros for an increase in the config
> complexity. I suppose that is slightly better than generating thousands
> of lines of macro... The unused macros sit on disk in the include file,
> but i don't think they would impact the deployed code...

Sorry, conflicting requirements. There will be a trade-off somewhere between
performance (having sanity checks at compile time rather than run time),
size (offer a library-level mechanism for consumer drivers to perform their
compile-time sanity checks), complexity (only generate those sanity
checks which are requested by drivers) and flexibility (support whichever
order the consumer driver desires for the arrays of packed fields).
I believe performance should not be the one which has to suffer, because
packet processing is one of the potential use cases, and I wouldn't want
to lose that through design choices. The rest.. I'm more flexible on,
but still, they have to be satisfiable in a way that I can see.

> I'm still wondering if there is a different approach we can take to
> validate these structures.

I just want to say that I don't have any alternative proposals, nor will I
explore your sparse suggestion. I don't know enough about sparse to judge
whether something as 'custom' as the packing API is in scope for its
check_call_instruction() infrastructure, how well will that solution
deal with internal kernel API changes down the line, and I don't have
the time to learn enough to prototype something to find the maintainers'
answer to these questions, either. I strongly prefer to have the static
checks inside the kernel, together with the packing() API itself, so it
can be more easily altered.

Obviously you're still free to wait for more opinions and suggestions,
or to experiment with the sparse idea yourself.

Honestly, my opinion is that if we can avoid messing too much with the
top-level Kbuild file, this pretty much enters "no one really cares"
territory, as long as the code is generated only for the pack_fields()
users. This is, in fact, one of the reasons why the patch I attached
earlier compiles and runs the code-gen only when PACKING_CHECK_FIELDS
is defined.

