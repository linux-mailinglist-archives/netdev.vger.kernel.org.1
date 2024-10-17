Return-Path: <netdev+bounces-136624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB59D9A269A
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 17:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E136B271B6
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 15:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD5C1DED6E;
	Thu, 17 Oct 2024 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CfJW1nHF"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2076.outbound.protection.outlook.com [40.107.103.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66041DED66;
	Thu, 17 Oct 2024 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179063; cv=fail; b=mlRJt7eiwr6g/11rxJs0YfGYUZY0U+gn1qDKQ4Mm4YnfFW4mnyRezDrQE/gEKH/pyHgFj3vNik04AN3m7TYJh0KK/L92lqkR6JsEl1OGDV3fLWr2Jfew2UyH7SdRJPLb89z+zU9ysTsWYo7uFa4aM10saUhM1Jrbk0B+muMEtk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179063; c=relaxed/simple;
	bh=TjIKm6CkVuE4+vfjM0Rf9+U0lt8uOBNf+V43GLIx7H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WszhaUEXrxlyNhTMPUSjNKQiRpuvgkbz8JbHSaHv/Ybj18iQLhW6gqEnjmn6OuYfnOBVdffxGKwq55FxxCwMTGdUhixNY3etxyoKqzUhEFTiEdIoGcvC54FPg+ao8BDTxk4QYfjtSQvYCbVhmRhI0/b+pEj7QOoFoVQ3fbVZZwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CfJW1nHF reason="signature verification failed"; arc=fail smtp.client-ip=40.107.103.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1CX6oMY8nalSr81fwhM7lFCz4yQ4AxKxBRVl8tbczfAVNmJS7ywcO8gbz0VTjR0otlDzd8ySmtMdhZ6035bF4ZJhNSJO6bouEwg/8+6em7LUAwUSANikA47IkAF/rwqxqir1J7ERI5Ch39v29ZLOaq2sIFOFu3ZlmsTo1T0IvVNWui6C8gUdtKGNlUsV/EA0igX+ZabVUDJIftwebgkK2U077FVfpIIWUN2uuyzVAaxQFxUj2VgtKAb+3HXbW1hVpPsWSC3hri44Q5vZa5hYsHonQ9vSPtvUG2NHuH/C554Qr/DKRQ2zS37ckdfvkNXoQBzHMb+LGPKULy/ukDnXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExHsg78zh+E+LxRt4EQ3qWotmGFTk5AToDGapi40q80=;
 b=jC33URxDdQ42uT14B41kOBp1ABx//+nVlVYG/J2kApdBpo8TUTeZbjUzDyXaQlRSAXq8QMesy95bZbgDwZHxY/fGa6VRQiv3FI+prTUPBfYdcctIMO2yGG8SnMQ6Qxesrx9kEhuqapTauC28mSyv+N9mJ2SF9/5DStElxB1XIzlXsHJVxqMaSoI+9CFD2GyM2qfId9ttiYgZjt6F2PUdKJSGCTlHZeX9JyH6ZziAvP+3s6lwshalOkAbuVO4wc/JulnVbeqZVeghX9RRHnxo9ZFut++3ml/z+jid4RVly5GDA10jywFKvOvUBoxw+cMR1aIDrqwsQ1607fDNb9OB4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExHsg78zh+E+LxRt4EQ3qWotmGFTk5AToDGapi40q80=;
 b=CfJW1nHFyOtQiJr+wG0zsDisRO6buidH6eZc15fj366JOpNtD2TLAcMLfg4WRx1sGGUfKbBjp5krhvxH1YGj05Mj6IWe7yB/R7+THVYyD7XqFjtyyBwjfNu70jOBvd415gGr/cGKHXGYTwJ6jqHgZRmM5flemQ2cFUUX2vkt26ehgDKoLMRfAi1XB5zuLPPfZ+kEEx0OGQBcMj9lYISqhq4H5SY7aPZdRVlYXkCvOowUMuppq4o3hkOm0Uaj/qmQEA9fxQLV5Z5OzOQLyi1Vwyzr1+by5CiGwuB5CS18u6Fnc9YYJhOPgR+d3vUHQHdzCq1AanjLDlI6C75FK1U89g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7098.eurprd04.prod.outlook.com (2603:10a6:10:fd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 15:30:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 15:30:54 +0000
Date: Thu, 17 Oct 2024 11:30:45 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: RE: RE: [PATCH net-next 07/13] net: fec: fec_probe(): update
 quirk: bring IRQs in correct order
Message-ID: <ZxEtpRWsi+QiYsFh@lizhi-Precision-Tower-5810>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-7-de783bd15e6a@pengutronix.de>
 <PAXPR04MB85103D3E433F3FBE5DDFA15C88472@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241017-affable-impartial-rhino-a422ec-mkl@pengutronix.de>
 <PAXPR04MB8510149D0E8AC39E048941F988472@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241017-manipulative-dove-of-renovation-88d00b-mkl@pengutronix.de>
 <ZxEZR2lmIbX6+xX2@lizhi-Precision-Tower-5810>
 <20241017-rainbow-nifty-gazelle-9acee4-mkl@pengutronix.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017-rainbow-nifty-gazelle-9acee4-mkl@pengutronix.de>
X-ClientProxiedBy: BY3PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:254::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: c97de649-bdd1-4cde-8483-08dceec0b06b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?9Y77YArO8Jivraz13lAFHmHFasRig+2Ujbdi+p6U50KQOacRMlLCh6wxPr?=
 =?iso-8859-1?Q?WTuTcLSEJ5QDwO/sofxZQ/kPvFrjwjEqwLblfGTbBOBFGniQWSpO6868aM?=
 =?iso-8859-1?Q?0cA5fKjpIH8wD1+1ILPwt6xSh7D5qSSP3JhA9Rqq3sbs2BksCvTypse4L+?=
 =?iso-8859-1?Q?sLpOMZO6KEa1xE67ZnVlvqd7NBBwFMrck1XNEgxDrrwwQSe3Rby2Czyxsw?=
 =?iso-8859-1?Q?6gRP8RGRqgWpcilYfC0r7bPDDSEo0AowOqevgBijegM6yv2ukzrzJTXUSR?=
 =?iso-8859-1?Q?QRKdh8dTYRQXtZ89YGoz5EmPdqOGGESewj7K99ABFAlZ16TzDA4ZFgGFj4?=
 =?iso-8859-1?Q?IcVEG+kq7tJUbk24XRyG8bmRh0ZYBCuLiBW9zhvv3rW54mbaF/5LcHJzVf?=
 =?iso-8859-1?Q?SEQy64u51ca4HTSZ9isiNJ63r1RNnAkIWwlmAvRFy0Dj8HmIfqHv3TJ3sZ?=
 =?iso-8859-1?Q?cCP3dGfvffzlkk+ft268npSyAX6pidI1wVwp3uFjZU3k3xG3t6pP+3s84V?=
 =?iso-8859-1?Q?7ygvH3OTVYFjGzvQDX1ES/EyKcf+BlYh9tXYxnkV2I4BFu3sOn+/7XIl5o?=
 =?iso-8859-1?Q?pcbbKG1ZrjHVFRj5pyPSQvzhzLEolQ3ls2AWvJYag6xoj50Mmsg9+tnBmc?=
 =?iso-8859-1?Q?frA4s+gBKeti19nOW+Pt59WhcbtpJ8DhC7KoVDVSeNSFg65jm+gkHlFhVb?=
 =?iso-8859-1?Q?hwIVuk3iOLyU3IdCod/oh09DuakeheJBJtq3a0kmmLF1MywXV76xXt8Vvo?=
 =?iso-8859-1?Q?iS+kCYlFruMhVew4zW4P8BfhJ8jF7iSI5k3RgtI96Z0rrPtexCqDo14q8s?=
 =?iso-8859-1?Q?xYF+hFG19XeNgn478HndcuwxWbeBaycTMl9YJ9GJdAL9WbTZUB5y1RHAP6?=
 =?iso-8859-1?Q?IWRLWQzgRNlnM3yQ4+xI9O2Z1f3NiOnToB4caPriJewO8vT99bFUQe76Yy?=
 =?iso-8859-1?Q?hOLhh9ZNz/lwfz6AsOf4XDiYg6x92qdpvuAeVJhxeNY3M+fx8zjyaJVLNk?=
 =?iso-8859-1?Q?x7RehlDFrMAYPY6WvtaYTmqWwWF4D280OcYmkExdLHsICpQ1FlyjGdZEV5?=
 =?iso-8859-1?Q?F2uVOyUUSQgfnPJStnia2T2Ji84tvfTG5VYDbFQEJXGAQpxSyPyTg+wEXG?=
 =?iso-8859-1?Q?PreCNaqkxQjyMODoyfFQx+EcXFLu4+ujuXjce9WjmkoQaAOktKY5YodiTB?=
 =?iso-8859-1?Q?QYimrqG1aoIL0gKXZOhatmDGMYNbe6wTj0ErobTcSvxmpmhmDXmXQOQkea?=
 =?iso-8859-1?Q?b4e3wWOLqKc/UJ3U9ljKQ+llnR76aZ6LP4grvyLrZBVOqebNWdsa+YW5nK?=
 =?iso-8859-1?Q?wkso9FbogD4vEKLZQ/XWWNPLIQioKqedCMwj+m/FFsYzqn4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?2ZOOc3H93l7Z+FG/h9O/HubI/BwS3T//c17MFgpPi0kCoP4auBpKtp3piD?=
 =?iso-8859-1?Q?OuXRV+w+txawm4f1l8SGAXdQVwj9v3K8rOdJ5BT57qg84yk910RAS+Y1N8?=
 =?iso-8859-1?Q?Grws9QtxhQdsJspjMeVOpmqyfw3BKWjq0LBQTQBjv1CRv42xiso42Q89H0?=
 =?iso-8859-1?Q?kMvyqUk8PTJl6olxlVAFrj8UjmxbEquK5oRsvdY8Usyh/edUcxNEO8PxFS?=
 =?iso-8859-1?Q?sAdPPIdt5jMOK/kEi5XYjN5vyzQFq1p4aPWqsqAOp1wTRzyVQ5qD3/4Rwo?=
 =?iso-8859-1?Q?7iXHAGZGnwb39ZFdubcjFu6wug0j/hPkTvaTOi1fh2wSdGgkoN/B6OtBci?=
 =?iso-8859-1?Q?X6iZJOX/fX4Y5ugjRD1xV8RWUUV5Bge8SkdDnI18jEu51N3hRU9VSI0fXl?=
 =?iso-8859-1?Q?KbJaSmNujSB1QO5pj8g81/bN/OlvynGt8AYTuEgVnvqr9RKqzto4fPsPt7?=
 =?iso-8859-1?Q?q25DbEcMRzVVvQVhCjOxsf0dJo3/orUnnd5508rfgn2ZMjjL04Bt/pFF4S?=
 =?iso-8859-1?Q?ie95098hNOSD9/G48sDe9lIxODjm3Z34IflCrTDaoCPRqLxsveVJwPA7DJ?=
 =?iso-8859-1?Q?UspS8YV8DFi9JXGu2IWTf0x1IE5jztoPSC9eJZpRLxnD4xJiop3jqgj+cI?=
 =?iso-8859-1?Q?xDhbKW7l/dG69jOVnaArFunvaEhmvThmZhTuVgE3MXNbDRbecUTI6toTK6?=
 =?iso-8859-1?Q?cqWXPkCk0oMQjyYUSa/V1j2dIRmFKKvl1wrSut4MiYL91VKdwiv2irPPwA?=
 =?iso-8859-1?Q?kaYRedvuF4V7qdTYVQjTAZdTSjY3wTFX9Q7Ea/9+8B/mxln/1llZHyjD7c?=
 =?iso-8859-1?Q?VG7vVgb+jOyMLoySBnyb0Rq3Cn0eayzT0CQ8h1nzcolYsKm88dfOqBLCBD?=
 =?iso-8859-1?Q?QjNkQ0ELUmJ9gCfdlIswMDOmIYwUVzb1U0tT2A9nfd5IsfTDMcZAYHhytf?=
 =?iso-8859-1?Q?DNogXc3qHuST2iMkeMCXuBzQ76+b7LM34qL/r+7fDzRuGMmRR5dC7iY0CQ?=
 =?iso-8859-1?Q?c8+MKlyycaMvaTo1YV10otvwhbqTg06ci/I5MiYOEsRPnc71b+hotQqEPG?=
 =?iso-8859-1?Q?pSDiBxQ6WSJKc14B45DI4bE5Eerpr9Hs9Ajsh/YY/WkjY+M2IGHNxgX65P?=
 =?iso-8859-1?Q?HPxHbmKJ/2Qq2U2KvNd3J4rG2T02CQXOP2QRTjBWYcF2Klz5zAH6CDPQBK?=
 =?iso-8859-1?Q?ekVsNjDRk1V9ZdKmXV879+WVY/78n4VSGjrioXMiHsp0WbxeLUji8IZnp9?=
 =?iso-8859-1?Q?mCYx37rm+gD0LcSwpUPnGxGt9+T6XKlEYfGaIlupQJcKl5GW1ngFd5WlAn?=
 =?iso-8859-1?Q?C7v6OpaufHEHn++UouEq5s+N6rRFOh11S7KpdvXmlqMAgneh0LZ40a9d+T?=
 =?iso-8859-1?Q?y1l4kQJM8RjU9ESxLFdeAuwbtOuOq2HsCwcqQ1O4/cvoJ77xEec/JgiCMG?=
 =?iso-8859-1?Q?LLjJASjatiyzk5ljHI2hxlt7DZip9ZQ3QWhoD/gdr51nsAnHjieSNmg3VK?=
 =?iso-8859-1?Q?63DmGdns/fKsJHWVS+9nDFKyDM/gdZWWFggt4LB7aGmI7lMj6FcYW6uLFg?=
 =?iso-8859-1?Q?LX2QMvByOIO9XZ487L9RlHgmXHvfwogxAuvJnn5IdYOsweyOf62pvBm9PS?=
 =?iso-8859-1?Q?9QxTjrabYH+OizuBDsrpc+tgM7fiD7Djyh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c97de649-bdd1-4cde-8483-08dceec0b06b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 15:30:54.2759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUEeKR4IfJwlbYeCwenG7mgWIzmRFP2+XKuGw9mGPlo06CsaYjAKfuU1Ro9ME4CQioLOZ+2IJNSo06IWmjW1gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7098

On Thu, Oct 17, 2024 at 04:21:33PM +0200, Marc Kleine-Budde wrote:
> On 17.10.2024 10:03:51, Frank Li wrote:
> > > > > Yes, that is IMHO the correct description of the IP core, but the
> > > > > i.MX8M/N/Q DTS have the wrong order of IRQs. And for compatibility
> > > > > reasons (fixed DTS with old driver) it's IMHO not possible to change the
> > > > > DTS.
> > > > >
> > > >
> > > > I don't think it is a correct behavior for old drivers to use new DTBs or new
> > > > drivers to use old DTBs. Maybe you are correct, Frank also asked the same
> > > > question, let's see how Frank responded.
> > >
> > > DTBs should be considered stable ABI.
> > >
> >
> > ABI defined at binding doc.
> >   interrupt-names:
> >     oneOf:
> >       - items:
> >           - const: int0
> >       - items:
> >           - const: int0
> >           - const: pps
> >       - items:
> >           - const: int0
> >           - const: int1
> >           - const: int2
> >       - items:
> >           - const: int0
> >           - const: int1
> >           - const: int2
> >           - const: pps
> >
> > DTB should align binding doc. There are not 'descriptions' at 'interrupt',
> > which should match 'interrupt-names'. So IMX8MP dts have not match ABI,
> > which defined by binding doc. So it is DTS implement wrong.
>
> I follow your conclusion. But keep in mind, fixing the DTB would break
> compatibility. The wrong DTS looks like this:
>
> - const: int1
> - const: int2
> - const: int0
> - const: pps
>
> Currently we have broken DTS on the i.MX8M* and the
> FEC_QUIRK_WAKEUP_FROM_INT2 that "fixes" this.
>
> This patch uses this quirk to correct the IRQ <-> queue assignment in
> the driver.

This current code

for (i = 0; i < irq_cnt; i++) {
                snprintf(irq_name, sizeof(irq_name), "int%d", i);
                irq = platform_get_irq_byname_optional(pdev, irq_name);
		      ^^^^^^^^^^^^^^^^^^^^^

You just need add interrupt-names at imx8mp dts and reorder it to pass
DTB check.

                if (irq < 0)
                        irq = platform_get_irq(pdev, i);
                if (irq < 0) {
                        ret = irq;
                        goto failed_irq;
                }
                ret = devm_request_irq(&pdev->dev, irq, fec_enet_interrupt,
                                       0, pdev->name, ndev);
                if (ret)
                        goto failed_irq;

                fep->irq[i] = irq;
        }

All irq handle by the same fec_enet_interrupt().  Change dts irq orders
doesn't broken compatiblity.

"pre-equeue" irq is new features. You can enable this feature only
when "interrupt-names" exist in future.

>
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |



