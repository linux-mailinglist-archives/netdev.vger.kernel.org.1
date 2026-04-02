Return-Path: <netdev+bounces-274560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOplCUp2zmk6nwYAu9opvQ
	(envelope-from <netdev+bounces-274560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:59:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9C638A247
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C3F63046E61
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 13:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0D83254A3;
	Thu,  2 Apr 2026 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LOjS/zXo"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EFF1F8755;
	Thu,  2 Apr 2026 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775137563; cv=fail; b=MUvIYAXFU+89psrYOttvR2N71H92Q3/jITFhK5fTmLDuXgm23okVx3y71AjNNIf9zkANf6Tz3d8p0aI3YWwMui+VMjOES9VIAzVw+xhjxsuEKNd9GWe8gbf9pbGYWaap6d/4cNZ0RFOgqhIQCl2vczGRln6L7utVOJDvqVJ5FKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775137563; c=relaxed/simple;
	bh=7l++4blJz+pD+Kc2bDzfz8sR88zTMURO0oorUooyUrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cz0VBiNHisIDBKTxnEMlDO1tR03f4oUxetuMRBVb9W6V/NGm7Hre5J/nmhrjJww+KSNIITEFOFVEdXNp+r+d7Ayl/1VW5YeWUWt75PK5flLfWd1JM1R13FisvfAssvxtZxYxfVdQI37kfWLMaM/b3ClyYFDEWj1RxE6kY/PojBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LOjS/zXo; arc=fail smtp.client-ip=52.101.201.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uicWDVreQ3sZngdNwXAm2/A5vIeAPptDIQSZc5VCthXP6N9Ul15Ap6dVtHBXYz16LRm4kU5HBmtrp6dbeEEG6+JbYQOQaxoCxj/5g3b+tEe8dMIW+Di4moCs4j9LDx1SSI3cpDFBvtbPNAP1mHPzWSyTzOW68wkKJyzzO9tMfqHu1sUgQCW5Aq/YORmPXOM/N4G1I8MqVucia+3EwjrkXEzp+4V9/MJYKX+ggFz9ntw6CgO6cmh9WZJwqUG3+WKK9h8+0pKE3BlD0zPiAjzgbqkhz68Qjb3fC/3H4s68lnn+Vu3N5hjL99WwJJP7rILWn4d2LVtUZ2Hr3abPqKqiBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwZlLnVmbHfUKFAob5Pn8V4VEcKhGvjOuclgLy9kXnk=;
 b=ysLeGJENO32L+U9S33QnrHxuR73PUfwyPNUQ+hvsLWr2fm4kPaAwve8i5aF+cOB2W6qlJqROUlh/6IhbRCnz6zwvVf5oGUsNNPqJWZvVf6E9oIBAdiufh7BDuuPwgKlTIfeJFLKB85o4nWQGPWfc2mF6VojX+hXvbrDLTrchFc1itap2jUH1XWeyuFlOLwA09R+uZWAHp06vC54mB4QRaGaN5t3O0r/fekSm9tCHm4sRGbwoEV7MpGf0Q49iSVM4IRkR2Ga3bwFuHM76f5TiOcVBx6646F1gZO/85yqiC8lGMfdC8a6e6+F0vEmjgc3Uw/tvbO79LHgljoKRyQQ/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwZlLnVmbHfUKFAob5Pn8V4VEcKhGvjOuclgLy9kXnk=;
 b=LOjS/zXoDWZQfREvf+o0+LO9rG7xL/cArz7R9P/SR9u1AtNDFpgkm1UkPsLjOq/CkmCqA8PhHWQiewthx6gWAIgXvvgfmEx3e5uwofQLp2sitMLqfPIC0deIcs3LM2c/Hvi1oLN9y3IjvV+tz+YVlf9DX8ZCqH1OCdENnNVFEs/dJGeXmhv4RPshbtUSQ8IFuH7PPcpeh8VonrnUmn6y4yMHjAHIvGivZS2L/+QfciNskiaRoCIhq4ByzzGi/cmhrD81aPd0+FP3sQ6T4rCVFDiT/XvQbAwbL2QYp+qTpOKXGsyRV7h1q727Cjnf2kQQLu/e+uyR+ENN0WBdPaWbXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20)
 by CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 13:45:56 +0000
Received: from CY8PR12MB7171.namprd12.prod.outlook.com
 ([fe80::4487:395f:3abf:ad9]) by CY8PR12MB7171.namprd12.prod.outlook.com
 ([fe80::4487:395f:3abf:ad9%4]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 13:45:56 +0000
Date: Thu, 2 Apr 2026 09:45:53 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 04/10] bitfield.h: add FIELD_WIDTH()
Message-ID: <ac5zEc2azCplcva3@yury>
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
 <20260331-realtek_forward-v1-4-44fb63033b7e@gmail.com>
 <acx_1dOF3EjvGt4B@yury>
 <CAJq09z7+cA9_1fWzkrJebutJD0b1BGhrC1sUyoqqb=ddKCAXcw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z7+cA9_1fWzkrJebutJD0b1BGhrC1sUyoqqb=ddKCAXcw@mail.gmail.com>
X-ClientProxiedBy: BN9PR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:408:fc::29) To CY8PR12MB7171.namprd12.prod.outlook.com
 (2603:10b6:930:5c::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7171:EE_|CH2PR12MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b6d5986-5ad8-4536-dc20-08de90be2a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+V4KpjMBSmgf3E56DroMaMJvDn2P523UFTQgMkZ5WjisJyLirrN3NbgolSuLrnU3ou3KZlc1OQr3xHmUsc6oEgweV3kT3zviu76JkB0/ghwprRbJF3yIVgieSDBZLvd/ww6Gw81Av10nnJn7C0PN2sAmtpPeIeC1mct0WeU5uv/S65sfkpb1RRAgJH7Pka0vUVgMRbQiIXWtMbC5UmZ6WbNqoLAWKurpQSFNCBb1sTt5Bpnb4W7vXlAOr3CB36I4KH59otTMCprh4Ss6cB382ti2OMG1yqjv/oStH3Tle1v8sAWbyqWohQQlS9kYscXZ2ms8/uwrjEfBcAQ5qbf2VTnFFtETqfRM4uurQXhMQgISCjdtXPlnlHYBbHm2zypAwn3SZBRm3L/7wU6+zs+3XKpv35+17ZXHudPCKTOnBuFR7pf4Nfl1DIlJ+YhhVPFafEPHezhVeWwWW8a1nEeh9qpY74D4og6B4G3NbfEFPKO2mOD+Zj70sU9SpBiX7NxajhyHlgKyU11Wmu3ewn+hE/afMVX5Env7VHyrE+jQ2dDTgaUjUYG3BK5087+i/9qMUzwbZOP8EnLso23Z1lrClobJJwqWPmmzcUrN9kko9gAy7tXMUC2KSjdVvGBjGPUTRRS7CeUIb1OWZitNxYOb5wjSs/kGk7V1Oi9DitlQ2Ipwhu7X3HHSQDmySzj9FcbQdvEOF/w+oYo73keaJwDPgPlJ4zH3AA05v4QZvYFpSds=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ayKvRQ1rJLNMmWfah2yqIufsil6UEfCedVCZ3qc4pDflmbJqCAtVmNFOjoZH?=
 =?us-ascii?Q?pik7gQVvWJ1cgbobtAzVouaGhl9GxJ24/tTFyxGmIBcWIHtBLI/t0G45PhBI?=
 =?us-ascii?Q?67ASp83SoErX/VIX1aQTWkKBXHx3oMEZN3t0f3Ld2CeydNUNu6r6JHDZ8AQY?=
 =?us-ascii?Q?9iaOl4qZV2N27MbBnFHPStiARRCweYIF7dq+etmAbqLO5Or7pn1vLZsbETuX?=
 =?us-ascii?Q?9ixPkcA2jveywFnb1ytEwlDfqOfJwTX+rT+vPNMwJLC5TLi9jX1KnhmguuVC?=
 =?us-ascii?Q?Fb/gQUc71eLp6/bwU+IU4Rj4wAdVGwkYme8pt+TGGvMGdulDeHPVzE2MUllq?=
 =?us-ascii?Q?m3EDo0SmQroKDaC1JxGTH+EJmO0jmNkXE3kWUSY2jbOXruzcwkwXav1JDJvL?=
 =?us-ascii?Q?7hLrP6hxmV4uFeWQTlaaa92LkTuAy9PeeG5glyfUE/XlELkJdOFgbG9mJDDf?=
 =?us-ascii?Q?JQzwTqptD06QIJnyC5wfeIHe3S4Jr0U0sAmJKbdahH3rb5jpeLqNNYXG1DGC?=
 =?us-ascii?Q?Xs0ii/kOVCQeoE2lutvyOLu2lZmLx6ZAKqoIXRUP5apjF4UGi9jlYJkgyC6S?=
 =?us-ascii?Q?GzTtNfHwzvO0w0NxqUc9Ifxwqi+PoVAdFefpi6aIWgSpmyPlojimsUvHUJo/?=
 =?us-ascii?Q?N4VLwuNTuC/rc7hNoTUOP6IacrhwUz8mmSYekKqJCIJOYDZ3hzGPtoSrSn7t?=
 =?us-ascii?Q?gtlXLhoGaRqitYaV8zBNXV76wHWEKfEnKjrtbE2pR4HA+fbTgXQZmbxuxnGh?=
 =?us-ascii?Q?d4Wy1vePAI6Y2fNh2wuhdyTMevTRHp1HP59lC5Cbji7KOjyh3pi4/KZKa5qL?=
 =?us-ascii?Q?QfE8sAnMwEsTGonV3BqOeIXExDUf8RiUnMKCzBnsIdl4Dh+K6Hq77xeIj+gf?=
 =?us-ascii?Q?PuxOWIM1R0PLPZzgduVFpRa1b2svJM27BeF6n5R2/zpxBOEKIgqOv7h97Mw7?=
 =?us-ascii?Q?32hIPJT2nemjB89f1oiUBMEJCvlDoOMJQ2/H3s9Y5gluhSq51/xS9WApp054?=
 =?us-ascii?Q?dav4pYmRnKL3L3dzXGOUbA5ElULe1dMUhj+fHqKOAnHg7iEKb/hTqnFqIWSQ?=
 =?us-ascii?Q?usOuVWzueWOGYEEv7YvV8MbmFmYube2NiF7g2Ks8HD2H1DFVAy2ks+lK2fQh?=
 =?us-ascii?Q?YpbJHcZFc9hu+wMVTN4vLv2/Ds/laak7UTBAUVBkVzbzxDkHZVKEh5Bak+BB?=
 =?us-ascii?Q?KC4GMxHsXhEpeBuTRWg8TR7XC0w4lT0sggCTqkO7y6/dFa7Ioo1FAGIfEx6v?=
 =?us-ascii?Q?G51i5xZFmmFQGfACQ8f2pKKJhadx42DUG3XCh2xBbuYGENHay5yFrvgImxDp?=
 =?us-ascii?Q?aJuAVfA77q+6nnOFYN1umih0BMjgtQo6yvXmS7nFtUrcW5BN+fPMjGQUiw4l?=
 =?us-ascii?Q?bKKk3tysMJNQv2RSxLM7zB2HcJEl2MG0xPpfYXe8qyi+XCDFe1AiBCME7pC0?=
 =?us-ascii?Q?/pVMuuLbbEu/TaIt+oWDj6fdgaAqLSRWpq8M+IAB1qSIJGziGUQLaurHhlpv?=
 =?us-ascii?Q?DBSuzH6rLDNweeHpOLoScwcakc/6b52qOqeD2Gon7596F2ZwDDuWyjmZjxFg?=
 =?us-ascii?Q?/YU/f9AlUzKM4o+1RsDzRfonpuBo4uQZ3ABjyLGALv1bFj7JEyM4nSlJYcEt?=
 =?us-ascii?Q?IfqTo7Rx6ySpnBFpzAI3z7GMr75yli+G0sik2dVwPvYI83StymuQ4myOQVU0?=
 =?us-ascii?Q?6yu9B0NcR0l5hLbu6rvURxJdkGdYBC4wvihq5hSF9EZp4cbNC07ofuhjCPRW?=
 =?us-ascii?Q?A/ENgpjDYAuQi0RJ5nRSOc6iy2IkWsJlkG/rpWxE+WBCEeMJRWpl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6d5986-5ad8-4536-dc20-08de90be2a27
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 13:45:56.0708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Km3fY1kmn9dcmre17iWm4FxKBJEXxum+ISIIjPPkG9y5JtVm9NpcWoE4A7ix7wBoHUKJFfS5/6sGNKKMddc/hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274560-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C9C638A247
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 01:00:20AM -0300, Luiz Angelo Daros de Luca wrote:
> > > +/**
> > > + * FIELD_WIDTH() - return the width of a bitfield
> > > + * @_mask: shifted mask defining the field's length and position
> > > + *
> > > + * Returns the number of contiguous bits covered by @_mask.
> > > + * This corresponds to the bit width of FIELD_MAX(@_mask).
> > > + */
> > > +#define FIELD_WIDTH(_mask)                                           \
> >
> > Please no underscored names unless necessary.
> 
> I used _mask to maintain consistency with the existing public macros
> in this file, such as FIELD_GET, FIELD_PREP, FIELD_MAX, and FIELD_FIT.
> All of them use the underscore prefix for parameters. Should I diverge
> from them?

There's no consistency, but if you look at the recently added code,
you'll find it doesn't add those underscored prefixes. If you want
them, it's OK. Just explain what the hell do they mean?
 
> > > +     ({                                                              \
> > > +             __BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_WIDTH: ");   \
> > > +             __bf_shf(~FIELD_MAX(_mask));                            \
> > > +     })
> >
> > I believe, this should be:
> >
> >   #define FIELD_WIDTH(mask) ({                                  \
> >         __BF_FIELD_CHECK_MASK(mask, 0ULL, "FIELD_WIDTH: ");     \
> >         HWEIGHT(mask);                                          \
> >   })
> 
> HWEIGHT() is indeed much cleaner. However, to keep bitfield.h
> self-contained and avoid adding more includes, I'll try
> __builtin_popcountll() in a similar way __builtin_ffsll is already
> used.
> 
> I also noticed the suggestion to use __BF_FIELD_CHECK_MASK instead of
> __BF_FIELD_CHECK. Both FIELD_MAX and FIELD_FIT currently use the full
> __BF_FIELD_CHECK with 0ULL as a dummy register to ensure the mask fits
> within the header's supported limits. If __BF_FIELD_CHECK_MASK is
> preferred for FIELD_WIDTH, I can certainly use it, but should we also
> update FIELD_MAX and FIELD_FIT for consistency?
> 
> I intend to send a v2 with the following implementation:
> 
> #define __bf_shf(x) (__builtin_ffsll(x) - 1)
> +#define __bf_hweight(x) __builtin_popcountll(x)

So, we've got only 2 __bf_xxx() functions here:

 #define __bf_shf(x) (__builtin_ffsll(x) - 1)
 #define __bf_cast_unsigned(type, x)     ((__unsigned_scalar_typeof(type))(x))

They both do something with the builtins. Your __bf_hweight() is a
pure redefinition. What for do you need it? Why not just use that
compiler-provided popcount() that everybody knows?


> #define __scalar_type_to_unsigned_cases(type)                          \
>                unsigned type:  (unsigned type)0,                       \
> @@ -111,6 +112,19 @@
>                (typeof(_mask))((_mask) >> __bf_shf(_mask));            \
>        })
> 
> +/**
> + * FIELD_WIDTH() - return the width of a bitfield
> + * @_mask: shifted mask defining the field's length and position
> + *
> + * Returns the number of contiguous bits covered by @_mask.
> + * This corresponds to the bit width of FIELD_MAX(@_mask).
> + */
> +#define FIELD_WIDTH(_mask)                                             \
> +       ({                                                              \
> +               __BF_FIELD_CHECK_MASK(_mask, 0ULL, "FIELD_WIDTH: ");   \
> +               (typeof(_mask))__bf_hweight(_mask);                     \

No need to typecast the result.

> +       })
> +
> 
> Regards,
> 
> Luiz

