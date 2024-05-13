Return-Path: <netdev+bounces-96106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838CA8C45CB
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 19:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E79D8B248C3
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C7D1CFA0;
	Mon, 13 May 2024 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VNp/vPjo"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2010.outbound.protection.outlook.com [40.92.59.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC9022EE9;
	Mon, 13 May 2024 17:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.59.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620393; cv=fail; b=WDeWLWS4W3cZCuzoSLK3ZEK8LtfEXHHEW/+SCy43Zb/gaDBeyKNOxUjBbVdPkXDNqXzLPuqqxjv5wm/t2eAtxFfYDCFNvUok++aUcYFB2RXt/he+Z0lvFa326+3wBxK6KfdL3byNnpaDEUGXo/GC7QBlkeG6QxFiTFSgXXK0hcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620393; c=relaxed/simple;
	bh=W2NbIWFFq8+93bRJCsvVQhRpRqEvjTNzWpKQRcs2SN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SI9mYxzvD7sFasN7wcwGyBGJLPbjv/IjYjEt0IskTI5V/SfWs8n8vVlA4LWuvtqp6/8OWSsXQvdEEuTSjhgZihGLYetJhmVFYu5Nd2ECMhxaf3H1lnLk39aiW13Uman03nl8WUGpk5C6xRMzpCp6Ld8fhVbif6w8kQx6DBBW2xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VNp/vPjo; arc=fail smtp.client-ip=40.92.59.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mk338koxFWtGUKF9RfJ8XlRiR8e8lxtJDxAad2J53MxQ81FNhmcZGUs6rR2QIzyF98yGMqVq/tnAi4IE1RiYJyZohakHkoJs09V6w2KMQE+PJfls3NWbJMAG4fTH3SwtCUCZTYqr/pU4gDqZwFTf7C0pKo9v3dctWRx1N2gPy4ZyvfKEiFpp4dX0o0ux+XQ1skVOtAbcA5NJCoKK0zp6VwPZKqKe9jXyC2Kx0b0gqT0QRD5L+Iyitntt6oZcJRQ8WdnTZp8Zs7hL61PJRfrK/rRT9tyQZac97mR1MwhwW4RpId8d2uaSn0+a1VPmnb5RW8EtIuUYPO4pQTEq1SeWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7F+s5aaIWjSuzspJg6pQcfY0ACaE1ATMRVyyzjvyng=;
 b=fCDIWIuF+q/P6C2nrDf3M+jcfBvr9ylMiY+GKH20n5Yu+/mfW/ZsoXh+02sZqUB334v6FLpGUTCoRkFZ2FsO7JG/hYu2Q7okcePeFLLEeDln+lOB0dBV5J++dsYo0USFS+ro65LWOjHjF9rhjQYtWgxGMcBpT7tNFyoLa2tjJvPiizJSIKKFddpb0XGiBofDQ7cbmvia818CFrxWns4icBhcG3hfN6uFQR3D1lF0Jh1l4+3mmXvtl+NmpZTHmmKJ2hEb+7j+OTLpQbhp1skC4DgBU+WAFY6aQ9yd1vWC22lh2umBfpN4kLkIZWhCiTMRvwI7lceb3ufBiQOp9Zl+yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7F+s5aaIWjSuzspJg6pQcfY0ACaE1ATMRVyyzjvyng=;
 b=VNp/vPjobzrQDmF6WBy84Nhucs69Pm5gfQRxoMCEr4H4yP8yaz0+XuIBldPTnPFhXh++bBBfs3GkETsmix1fFnPoj9P6B1rsT9kM+0hbzPECabNRTnnvC+4QkgvMchRGfDafA8a63J7Axs7+sRmrAgEZRFml78zpPDmlHeS4cgI2ia/Q4w2dMA/NY9AzSW4Ghf98RxJey3JD1OCMwYabMRL0aGywGEOhVEP5RHvTGuJVh38vInnXhIUFEkAL3ms4+6nwWHgoLvCjia3Q7GYqxKX510EhOGo8gNQcuALMFLFUlHfUxjAeMcyynaL7oyzmUlQWXs5LsCqLDcPH/xfFBA==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by DU0PR02MB9872.eurprd02.prod.outlook.com (2603:10a6:10:448::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 17:13:08 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 17:13:08 +0000
Date: Mon, 13 May 2024 19:12:57 +0200
From: Erick Archer <erick.archer@outlook.com>
To: Kees Cook <keescook@chromium.org>, Jiri Slaby <jirislaby@kernel.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Erick Archer <erick.archer@outlook.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S.  Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2] tty: rfcomm: prefer struct_size over open coded
 arithmetic
Message-ID:
 <AS8PR02MB72379B760CF7B6A26A69C5558BE22@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <AS8PR02MB7237262C62B054FABD7229168BE12@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <d11dacfa-5925-4040-b60b-02ab731d5f1a@kernel.org>
 <CABBYNZ+4CcoBvkj8ze7mZ4vVfWfm_tyBxdFspvreVASi0VR=6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZ+4CcoBvkj8ze7mZ4vVfWfm_tyBxdFspvreVASi0VR=6A@mail.gmail.com>
X-TMN: [wRf/Hs5bFdZs1n2BHOQ43jNMyJfg48E7]
X-ClientProxiedBy: MA3P292CA0007.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2c::13) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID: <20240513171257.GA7952@titan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|DU0PR02MB9872:EE_
X-MS-Office365-Filtering-Correlation-Id: 8530ca10-098c-497e-a42b-08dc736ff5d7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	7NmEyfAJOah5olbWzrIJ+fGweCA0YV7ruthuncJx9CV7qsYUaj41a0xlBDKOsk7ss6BN3MbmOmtEuKYzg0IrIDUoRahRmMq8nc1WoYgxk1TM71uyIwdDkOIkSp+/bwcNvYhh4MR7nFU9D/8VCug3q+EHVejO9truQMA6wkYLODIQx3eypSxynVm7wqRB/o/dCMzACBo8IbFd6O9OXUihZTC6TtQetDSIOCsKoqlrCcam7tUd3H9/1S0A0tIzpghLioBIaROYXMdoX332dP39oU48fYf4WNLQdZlhvEqSeUQpMTILiaw2Rh3iPA8aMjzpjBnM/eiWPVYjqfkf0lBwamgY05Ua5wwN9GWU6uOnbK4Ok7tqnEQYB61tIgj3L07QzNniECHGdcqrXlLajAXvdLryWnW7Y+Zanq5ul8c2E1TjuqItlt39469JS8bMu5O6a5mT8AtoOPLMsfft2KIIeM8LeQlu5RMa93cOc0IfegjFEEbtoXaE5BNXInk3M0qu1DcOWCiub7iyycWLlqxAwF5ghxTlebbqMvnpMrGpJM6JatuqCUkwRLlrKmJANbJ+jP8VKVWSWAbM3g5hRzT+0poycEiDZe9QCADuAOGycd+mU9T43myjldwm6W2Qp5gG
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1ZObEh4eHM1OWdtVGVVWW9oRUJJQ0J0dCtTSXRPS05PYllscVljSGYxZGt4?=
 =?utf-8?B?U2ptVUYzMDNLeWtUb3JRZmxpTldLZjV1amdkc1ZmQnhIdXRiM1IxKzI0ajBh?=
 =?utf-8?B?OHJHT3hqS0ZtdVlnWXdzTFpmRjM5Vlg5ODZBZDB6RzV2Uzd4NUpVYWVueklr?=
 =?utf-8?B?ZXF6UmttTFdydGkyUncvUnI5RExwZFNwSmlrdmJ5bGRXRURnTGE4cEpranBZ?=
 =?utf-8?B?SUhUcEZFaEpHM21PZndpRGthdm92ZzJUZjRyOHhWNXVtTng2UFlER1UvUGxP?=
 =?utf-8?B?LytITDBiYXg1QTY5UUpEenJmNmY5aVVJRmhuMytNYkVpcUI3dk5EUjVYL2hC?=
 =?utf-8?B?MzBxbm40Z25udGhFcUsyQzZ1Y3Y1Q0tjNThhbUdZZW5iM2RTcnNwY2RwVmhh?=
 =?utf-8?B?NGxSVkRHWGJ2L0V5MS9DUUszelkyQUJHN24rdjhSeFk5UWwvc0FGYitWUWNP?=
 =?utf-8?B?WnNWYndTSnZHS1doWWJOQzNpQ1J4S0lMekgwQ2wvWG9KbExrQnU4MENTNjlk?=
 =?utf-8?B?eVBRaFVtR2pPZDN3bGQwQTRicUEwamhOUjV5WUNFWU1QYWVuQ0lpcy9MTkNB?=
 =?utf-8?B?WW9NWUx2SGJuN0RQUS94bFp5ZlUrV1p5a2JqSG1NeFR3djMrd0h4QTlwVTda?=
 =?utf-8?B?ZjVIRXhDYUFvbXlhMjdReVJ4UnJzYk83ejIrQnc5RnRlUFNSL0ZpM1dNU1FZ?=
 =?utf-8?B?SEVpcGwyQmZ3MHk2MU0vVy9nV0FnSVJ0VTNpMGNmWFQ2SnRsWVk4anJlOFhY?=
 =?utf-8?B?Yy9GdE0zaE9nNTNDT1Voa1pYWWdhU1lhcHVHQ095eTB3M3ArV1JWUW1VNFZM?=
 =?utf-8?B?bVZ6alQveDR5S1YyQ01XYTQ4VWZ0QlBrREROTmNkdGpTdG83TEN1aUZNN2Jv?=
 =?utf-8?B?NkkrUUlkUTdaY0pnKzhONEUzNzJiZ2dKYWFSZnRuVEx4SkFvSG9RNzVBbTFr?=
 =?utf-8?B?ZGxkKzFxeU90UERNcndqUEN0cGhLKzA4L2Z4V2x5YUdCd21ndmU5c2hwUkpK?=
 =?utf-8?B?NlZQRUpUTjBRaVdwclI2Yk9lbk40bm1ZQVcxMnJaTzNnTFF2OGU1YUQycmoz?=
 =?utf-8?B?bHVEem0xMlJGb1luemxzZUNibC83WjQxK3R3LzBSWi9JdnRENkVhU2F0SXhk?=
 =?utf-8?B?UUVVcDk1U0lOZTh3ZzVlMlBTRjdGK1hGNEk5b2UyeXUxWDQ5QUNTay9va2FV?=
 =?utf-8?B?L0w1MzRjWThyM0d0bDI3WUIxTXhFQURYa2NrTGcrb0UxeXFHL1lOUnZoUlVU?=
 =?utf-8?B?eG5JNnAyc0lTUnpPVVJiSzhRUUNLNkd6bjlPbHU5dnJlQVZ3SE1GWEV6T3dN?=
 =?utf-8?B?Mnd4NFcwWndFTThvNWV6MC9sRk1SN0JFZjIrR0hZRGRCQVQ2bS90NTlqMzg3?=
 =?utf-8?B?Z2lHL3EwYzE1d0RrVktLaTJXWGdBWlpwMTdRWklwMHJNcTU3aS9EYzFuWWha?=
 =?utf-8?B?ODJJc21hNnI5bWJPQmtrRWJCQitGWk9tbVVXdFpQaUJoYXVrM3Q1OG0zY0NQ?=
 =?utf-8?B?OGxJbzZObFVYeDNqM0hnWHVLVVZ5TytZNmxiZXByNnRjeFBER0x4eXdNK3p4?=
 =?utf-8?B?cW55bExhbjVOMjNqMzRSNElFeVF2cThWWE8zWXZGR21wL2s0Z2E2Yzhvb21X?=
 =?utf-8?B?eU9WWEx5REozQmE1M0ZyNWZ0ZE9lNzdZVllQMStMQTR5Y3Rvd3lsUG1HanFa?=
 =?utf-8?Q?YfQdsbfW7aJC5khD7YD2?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8530ca10-098c-497e-a42b-08dc736ff5d7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 17:13:08.4833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9872

Hi Kees, Jiri and Luiz,
First of all, thanks for the reviews.

On Mon, May 13, 2024 at 12:29:04PM -0400, Luiz Augusto von Dentz wrote:
> Hi Jiri, Eric,
> 
> On Mon, May 13, 2024 at 1:07 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> >
> > On 12. 05. 24, 13:17, Erick Archer wrote:
> > > This is an effort to get rid of all multiplications from allocation
> > > functions in order to prevent integer overflows [1][2].
> > >
> > > As the "dl" variable is a pointer to "struct rfcomm_dev_list_req" and
> > > this structure ends in a flexible array:
> > ...
> > > --- a/include/net/bluetooth/rfcomm.h
> > > +++ b/include/net/bluetooth/rfcomm.h
> > ...
> > > @@ -528,12 +527,12 @@ static int rfcomm_get_dev_list(void __user *arg)
> > >       list_for_each_entry(dev, &rfcomm_dev_list, list) {
> > >               if (!tty_port_get(&dev->port))
> > >                       continue;
> > > -             (di + n)->id      = dev->id;
> > > -             (di + n)->flags   = dev->flags;
> > > -             (di + n)->state   = dev->dlc->state;
> > > -             (di + n)->channel = dev->channel;
> > > -             bacpy(&(di + n)->src, &dev->src);
> > > -             bacpy(&(di + n)->dst, &dev->dst);
> > > +             di[n].id      = dev->id;
> > > +             di[n].flags   = dev->flags;
> > > +             di[n].state   = dev->dlc->state;
> > > +             di[n].channel = dev->channel;
> > > +             bacpy(&di[n].src, &dev->src);
> > > +             bacpy(&di[n].dst, &dev->dst);
> >
> > This does not relate much to "prefer struct_size over open coded
> > arithmetic". It should have been in a separate patch.
> 
> +1, please split these changes into its own patch so we can apply it separately.

Ok, no problem. Also, I will simplify the "bacpy" lines with direct
assignments as Kees suggested:

   di[n].src = dev->src;
   di[n].dst = dev->dst;

instead of:

   bacpy(&di[n].src, &dev->src);
   bacpy(&di[n].dst, &dev->dst);

Regards,
Erick

> > Other than that, LGTM.
> >
> > thanks,
> > --
> > js
> > suse labs
> >
> 
> 
> -- 
> Luiz Augusto von Dentz

