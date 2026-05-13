Return-Path: <netdev+bounces-287725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAYcK97jBGoNQQIAu9opvQ
	(envelope-from <netdev+bounces-287725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 22:49:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFD253AABD
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 22:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A94AF300B59A
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35F437F014;
	Wed, 13 May 2026 20:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDqtsTh9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0152E379C5F
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 20:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778705372; cv=none; b=SuIU32pU37gEMMxLanOv30FwgIMMChwkYKYCHpoy/71+1sQA6gPKxFQj/SbVHKMX5cm6OcguPYnclBA9R9rNAKY0k/vcNiG7s5A81id6EAcsIU/f0MlXVWeOWMGbtPqY80gEdCu7pmrPUSJSgyzqfjC2OrmJ1IZn5RLcuzMyxKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778705372; c=relaxed/simple;
	bh=vWDazQqAcKBnFf1dXtRdFaGVZplM0TcqpZ8RHyVdXCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGzaWmKwcjhc+xZJwKChMkOf5aQtRUl0oQ89j8NAgGVlTfdCMObC3dxZTNrDUcyHtXO/sjZEmBnZ9D9tH+9hRtLl3H3F4Yn0lekmSmE2xK/OLVm3CzmRJGt1gDo9GCaHmg79KHQ5Uj/ilOGr5nBEnLcErUpWORwe6RAnUVgm3ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qDqtsTh9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488ba840146so66096775e9.1
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 13:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778705369; x=1779310169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EFeUCJZ+e7oYft3CAl+mqM5ysnAj3IowuzFODN/+G8=;
        b=qDqtsTh9b1blEETpVYLVgKyc3Q62sFFEhZqbvn+7IuNGy6YaUIOm1+xxPMcO6OhrPW
         O280hNEt/4DzDfQn4BzNWHwwchQ4Xl16JYK1jj1G8BDYIbpG+hK6CkxENFXD4q+HKQo8
         KSx6x1gosj3+C6GzWkKI7sHBss1xAuYgoSH+vFt5oGj1mcba5SCHVx+MOQCMYsSsm2VX
         nfZ0+FwKRBIvhjoUQ6F5iNru1RRszSKcXYjakxwfz2GneFbF4meA+bJYWHMWvy2xe0ui
         nDsiE9pSUL9f9KWJj7eikZaW3UioZTiMRTrV7qVYPsD+yAxpmH8oi+QkCg04/wETruP6
         Kt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778705369; x=1779310169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/EFeUCJZ+e7oYft3CAl+mqM5ysnAj3IowuzFODN/+G8=;
        b=boNau7/psEjwCAzwHOoH1vLNMDT2IDkbBcUxwayofGXNB3PVAAgbljCKjuE3cB3nyZ
         nCvv2of+X3jBbRKZlpNZ/X+cCv0EX3guHcbTGixhgFswaylybThT495OCjV416BV8pzY
         CDScVVBIYeTOsHsvv6rXjfoFYb4xMr0HHGTbDnkC7O5BxKi2a70MtVZMJvQtvC8qgJIT
         ToRsuNf6GUnFCPAw7by11won4NQe/eRTTiqHeaMhwd23vOoAK26w9TPegnvvUKm0R2ag
         SyvqJ4bdJORzzmDBVCXbe4m8aP1RDt3MyC0uj9KYZmYW9UKBa0JqrC0mYEmPJaUO94rX
         BpFA==
X-Forwarded-Encrypted: i=1; AFNElJ8ONKcvP4glhCs9t0HWcFH+LbOE/UNeTI53lmC9K0PxNh1EGz5ap7fbj3CEUH9YzjjVwpc7+4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl0/P5XfJdxEJf4oMwjp2jzZBKt0f/K6Y2fQ2OeuGYPqG89+em
	4znt0qnHgF2qAAQi+o1NWOjNVi937uDV7Vn3hiIyxjLRU3QRawNiHFQ3
X-Gm-Gg: Acq92OGHHRhD8VkRfaccIVe0RH2lDQg0X/nQD/nd1/DKVS7919MdwGRHMpkjcT9ictV
	D5pAtMOHExtU1JL3tJjt9Lu1Mbaockk3vPt0VO2zD/4ZYsxR8FyVfwUWGPHF//HqB3w82rW4AES
	wYCEg/vvWTBHKw0m36KqBTa05yL4fC6WmJmETjZ1EkflpKhTxrHrodXXDOg58r7yvBb0uT8sXnE
	qiDCMW6PRwwvtzsJKj2lo+ZPglSYP9Q/v+pr6RQlRor7+Y8Kwhq2tNbZqTdLyzrWTmvcg9IE45g
	EzLALy1E6LMF4cCFGtHrYrS4gIWCIFeoFRH5Fja2eUSYJOCdrQPgcbyvV/UsurOz7v3K4EKxbRG
	TSHNFs1+6gV7ikik5icJQ4tkgZcvKzjebe28SJgFtq+Knkhxiuu5RvLT25ObyiA1J6FYIHCbcdR
	XN58qZZ8avOnjj3mL650N1S1PgECX9Cdap0ethZRCtEsQAb5mpF8/nBNBbaD0VyUN+t40fAwE=
X-Received: by 2002:a05:600c:3328:b0:48f:da34:ec4e with SMTP id 5b1f17b1804b1-48fda34edb0mr3327735e9.19.1778705369088;
        Wed, 13 May 2026 13:49:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2f738sm1476103f8f.16.2026.05.13.13.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 13:49:28 -0700 (PDT)
Date: Wed, 13 May 2026 21:49:27 +0100
From: David Laight <david.laight.linux@gmail.com>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: stable@vger.kernel.org, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com,
 netdev@vger.kernel.org, jacob.e.keller@intel.com
Subject: Re: [PATCH net v3] ice: fix packet corruption due to extraneous
 page flip
Message-ID: <20260513214927.17a8dd45@pumpkin>
In-Reply-To: <CAGXJAmzK+56DHnitD1g263mPSgWg9jZyq2z6R+vd8bV_c4ZbuQ@mail.gmail.com>
References: <20260512181953.1689-1-ouster@cs.stanford.edu>
	<20260513100732.499e3f49@pumpkin>
	<CAGXJAmzK+56DHnitD1g263mPSgWg9jZyq2z6R+vd8bV_c4ZbuQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4CFD253AABD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287725-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, 13 May 2026 09:28:40 -0700
John Ousterhout <ouster@cs.stanford.edu> wrote:

> On Wed, May 13, 2026 at 2:07=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Tue, 12 May 2026 11:19:53 -0700
> > John Ousterhout <ouster@cs.stanford.edu> wrote:
> > =20
> > > Consider the following sequence of events:
> > > * The bottom half of a buffer page is filled with data from
> > >   packet A. The page has a net reference count (reference count
> > >   - bias) of 1. The page is returned to the NIC, flipped to
> > >   use the top half.
> > > * Before the reference on the page is released, the NIC returns
> > >   the page with no data in it ('size' is zero in ice_clean_rx_irq).
> > >   In this case the bias does not get decremented. The page still
> > >   has a net reference count of 1, so it gets returned to the NIC.
> > >   However, ice_put_rx_mbuf flipped the page so that the bottom
> > >   half is active.
> > > * If the NIC stores another packet in the page before packet A
> > >   has released its reference, the data in packet A will be
> > >   overwritten with data from the new packet.
> > > * Unfortunately zero-length buffers occur frequently: they seem
> > >   to occur whenever a packet uses every available byte in a
> > >   buffer, ending precisely at the end of the buffer. When this
> > >   happens the NIC seems to generate an extra zero-length
> > >   buffer.
> > > The fix is for ice_put_rx_mbuf not to flip pages that have a
> > > size of 0. =20
> >
> > How is this different from packet B (in the top half) being
> > freed before packet A (in the bottom half)? =20
>=20
> I'm not sure exactly what you're referring to here. Are you asking
> about a situation where both halves of the page get filled with packet
> data and then the second half to be filled is the first to be freed? I
> believe that the ICE driver abandons a page if both halves are ever
> occupied simultaneously; the page will be returned to the system once
> both halves have dropped their references. Thus it doesn't matter
> which half is freed first.

That is what I was thinking, seems like the logic is over complicated.

If you need to put 4k pages into some kind of iommu rather than 2k buffers
(to contain 1536 byte ethernet packets) then I'd have thought you'd
initially put both halves into adjacent tx ring entries.
If a rx buffer is discarded (eg a zero length fragment or a CRC error,
or even 'copy break' for short packets) then, as an optimisation,
you could reuse the buffer for another receive.
The same could be done if the page is freed by an application.

However it sounds like it doesn't use the 2nd half until the first
completes - otherwise you'd never 'flip' to make the other half
active.

Thinks...
By only putting half of each 4k 'page' into the rx ring the code
will usually save (expensive) iommu setup in the (probably) normal
case where the buffers are freed 'reasonably quickly'.
But that really requires a 'free/with_nic/busy' state for each half
rather then trying to guess from a reference count.

But if the low-level code is recycling the rx buffer (for any reason)
it wants to use the same buffer.

The ethernet driver I wrote (a long time ago, early 90s) allocated
64k as 128 512byte buffers and did an aligned word-sized copy of
every receive frame - most frames were in contiguous memory.
The simplicity of it made up for the cost of the copy, especially
since that was an iommu system.=20

-- David

