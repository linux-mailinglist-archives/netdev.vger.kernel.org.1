Return-Path: <netdev+bounces-236868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E959EC41038
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 18:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEAD24E158A
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 17:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CFC3328FE;
	Fri,  7 Nov 2025 17:21:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A49C2D7394
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 17:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762536073; cv=none; b=dArW5oY7h0dLMwLt2u4M2WaftVSmy2JRfwW7v4fgGMvRBrotvQc/Dk+LuoGhKA0KymVMiEaf5KlVyrpU3NnTgEUB3izDo5VsPFcSACmUhMR8IFHIuSTGZJQTxB6K+ZQRYMTADKcv8iqDRRb5vI4/verZSFMsRcul2G9SSTCfX7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762536073; c=relaxed/simple;
	bh=fFWfkU2N0MtbVRDZW3rgHczBuC4CXEjWqVqt4iMrysA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1uFQ2qFc7axe975qSVXefMAN7vsyII/BpST5YweMs8chK02gKiQlm4WHQ3Z2wPWbYLBBbbd5JWgNo4YWFSXs1EXBeLGiQlGTqOh5tH09dJ7gppSW+KjYH9cDSDk6Itv+vlrpp4F4cVbLBRK5LserlIS/fJJNUcBAfwineFs7Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diac24.net
Received: from equinox by eidolon.nox.tf with local (Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1vHQ8v-00000003FSB-3tsp;
	Fri, 07 Nov 2025 18:20:58 +0100
Date: Fri, 7 Nov 2025 18:20:57 +0100
From: David 'equinox' Lamparter <equinox@diac24.net>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	horms@kernel.org, dsahern@kernel.org, petrm@nvidia.com,
	willemb@google.com, daniel@iogearbox.net, fw@strlen.de,
	ishaangandhi@gmail.com, rbonica@juniper.net, tom@herbertland.com,
	Justin Iurman <justin.iurman@uliege.be>
Subject: Re: [PATCH net-next v2 0/3] icmp: Add RFC 5837 support
Message-ID: <aQ4qefp51ucf8CAR@eidolon.nox.tf>
References: <20251027082232.232571-1-idosch@nvidia.com>
 <20251028180432.7f73ef56@kernel.org>
 <aQHkY6TsBcNL79rO@shredder>
 <20251029183143.09afd245@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029183143.09afd245@kernel.org>

On Wed, Oct 29, 2025 at 06:31:43PM -0700, Jakub Kicinski wrote:
> On Wed, 29 Oct 2025 11:54:43 +0200 Ido Schimmel wrote:
> > > Is there supposed to be any relation between the ICMP message attrs 
> > > and what's provided via IOAM? For interface ID in IOAM we have
> > > the ioam6_id attr instead of ifindex.  
> > 
> > RFC 5837 precedes IOAM and I don't see any references from IOAM to RFC
> > 5837. RFC 5837 is pretty clear about the interface index that should be
> > provided:
> > 
> > "The ifIndex of the interface of interest MAY be included. This is the
> > 32-bit ifIndex assigned to the interface by the device as specified by
> > the Interfaces Group MIB [RFC2863]".
> 
> Makes sense, thanks. And we have another 4 weeks to change our mind, 
> in case someone from IETF pipes up..

The IETF is in fact doing draft-ietf-intarea-extended-icmp-nodeid, which
is past last call.  The good news is that it's extremely similar,
different class value but same C-Type bitmask, the main distinction is
that 5837 had forbidden the use of "cross-address-family" addresses.

Note that for unnumbered networks, 5837 is wrong - it's
interface/nexthop information.  But the interface has no address, the
node does.  draft-ietf-intarea-extended-icmp-nodeid is about node
information and the correct thing to use for that case.

The good news is that the draft is past last call, IANA values have been
assigned, there's a bunch of text bashing going on but it's well into
the publishing process.


-David

