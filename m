Return-Path: <netdev+bounces-302027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eJWQMEdSPWow1QgAu9opvQ
	(envelope-from <netdev+bounces-302027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:07:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC776C751B
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:07:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LMvqr0q5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302027-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302027-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7710302B760
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF76D3E8357;
	Thu, 25 Jun 2026 16:05:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0353E6396
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 16:05:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403550; cv=none; b=RGxJlQ8PA8GYkyTdJxgKth9AUE99pIgSJHeai289tbxzeZODkSq5fcI4XcJp5FMwZEiUs41K6YfhWhkZlyM0YvfRnKWuS18ZQaOf0L4ZMtDSMMwARYj5/M+RqOY/dOHp5vv1LAaM9OUwFZ9FcHU/k+Yb7CvMlmueFo4C5lVwI48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403550; c=relaxed/simple;
	bh=HqA2syi3fWc1e8sLEbaM7wYJoTGSZDfwgwmK26oflkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfioCwdsrLj08IFG8T367w5ONIBsZtw4z6Ogb55yWSrczecTGfw949Gt0IF+QsZQdb5qxzHvl66GnKdmz7mh6uw+vjBb882p68r2vOQU2ONaA8NfDlV8m1OSO/Aq8mhMl4et1HEj4h3tDJjzrGplxmFa8BERTC+mwNlRL+ssoTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMvqr0q5; arc=none smtp.client-ip=209.85.214.196
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2c6c101aeafso708485ad.0
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 09:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782403546; x=1783008346; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tXmRvL9EL1hwxlK3wjXlOdCXiCuQDXgSKjUEyrxUuTg=;
        b=LMvqr0q5GLgwhOom972umnLDit2Og7KGeRKAm2Ekh4KUssb3Txstp/3vzv8CZ3PcOA
         0cW/YS9UsQ3Q2Ut/sHKxbObUbyJKnyaoy8UWV/L1MGnNnri5pIkUJ9GH21RDWg1dVX2z
         fCXVRwgsh66KxvpKwi+hnvWdWsNbLUKeVAuroAq3bNO7g+iF78kTCbQm11nWU2bBQAOH
         qRLgWpoTW6N6qrBzTCgEHy26q2/GjDsE+gnHTBycbmB4NIC+ccGRAtfLV00RfCr3YtOH
         ZzZFkKnBVVbcrSngGw12Hvy4M29GPXyAG+a6qG9DGgz6hpbi1Ruxrsix6c4A7lkcXBPn
         2PDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782403546; x=1783008346;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tXmRvL9EL1hwxlK3wjXlOdCXiCuQDXgSKjUEyrxUuTg=;
        b=AAQaKwDp8YYulJEPy8fA91KJqD6JCujHEEjylPI2ruqe252TpepH0umW9mHKSGGSZd
         ev4ai+cEiwvkygx2mUA6kLRiDpLUd2j7Sk6Xl588pzLWPQ5YLAbPJUi92SYSlLlFUJ7r
         AH1YF6rnmjvNCyAY8aWNvMRHv67Xs+02zwipvmhy/C/rDRaodQljVtJiobMSkbszHovR
         jEdHuctsAbYr0JuNXZeAx8Uwl/jnUcQ4KpPFRppKq03Sr+iN3l2XgEcXPf62uknrNq3V
         YEdAczLKfAh8B2FZ42dguBI26E7okJJOJJKHKiIx3t51pb108gR4NU8fyXLNiAH0YIGG
         MiPw==
X-Forwarded-Encrypted: i=1; AHgh+RqDDZfD/tJ3fW4X/L2M4cmn5vysjOwb1M1UGOGx2M6PALY9XhJw+1+ZTw3ADv5aPJT8zOFQGSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YySLicYHyiKaoajWTkSUb+vypiyivnFgWW22yuyyHD8HEKIiieb
	c+GjQtiRFhD107HVvGV8y8pFjA6FaVKxLwpMf+V2UR8AoV1PkA4WBRcY
X-Gm-Gg: AfdE7cm45FXZEE2A+mcXmJadLkLyh6G/wVjFtvc58ti3iv5u2wlEhVNu8D0fITN7Ls6
	TE4aBwT4Rr2ZOU6tW8wE1ZvVnGfHgJWVKzBLbDOppc51Qiqy3RoIXSbyv2g9lNnVaRliriAl/SJ
	LFUW1VRioH5usXZBxtaK2SH2eTQGAVuLbt1ecfO3mnVMiZ3efU07ISs+JLxC00Q2wKrKjNjOuPS
	A7sa0TfNGzuHwNbl6U5hfa3mav6h7LNtqEJ3ZzZf/2uV7w2vb9Xz6RhnBJ0Qd9L7br8wK2Y2zoU
	omlmb4zXqOZn0LaR1v4xawq3XCY1KWzj0yAtYTE/uGjdjS6GJPIfXfnIVfaOVJTXBACms79MzH6
	/4SwepS1rYtyayNzc4uHvS8+4r9JCgwomI7mlpwhAkI2Tk4eypy6psW/baLbZqVE/V/U+nHKOug
	vWmp44/A==
X-Received: by 2002:a17:902:f68c:b0:2c6:bb31:4564 with SMTP id d9443c01a7336-2c7fc88dfdcmr31945275ad.34.1782403545537;
        Thu, 25 Jun 2026 09:05:45 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f64dcc30sm22787485ad.66.2026.06.25.09.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 09:05:44 -0700 (PDT)
Date: Thu, 25 Jun 2026 09:05:28 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	bjorn@kernel.org
Subject: Re: [PATCH net 0/7] xsk: fix AF_XDP multi-buffer Tx descriptor
 reclaim
Message-ID: <aj1O4vKzCuodwgYL@devvm7509.cco0.facebook.com>
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
 <ajv23_r4M3FGrFNN@devvm7509.cco0.facebook.com>
 <ajwHuCp82SazSwKv@boxer>
 <CAL+tcoC789GrOXvvYVOfxhL4iLCdFEAZQ+WCENsMjbLrJnfiYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoC789GrOXvvYVOfxhL4iLCdFEAZQ+WCENsMjbLrJnfiYw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302027-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,gmail.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kerneljasonxing@gmail.com,m:maciej.fijalkowski@intel.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bjorn@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDC776C751B

On 06/25, Jason Xing wrote:
> On Thu, Jun 25, 2026 at 12:37 AM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Wed, Jun 24, 2026 at 08:38:20AM -0700, Stanislav Fomichev wrote:
> > > On 06/23, Maciej Fijalkowski wrote:
> > > > Hi,
> > > >
> > > > This series fixes several AF_XDP multi-buffer Tx paths where descriptors
> > > > consumed from the Tx ring are not consistently returned to userspace
> > > > through the completion ring when the packet is later dropped as invalid.
> > > >
> > > > The affected cases are invalid or oversized multi-buffer Tx packets in
> > > > both the generic and zero-copy paths. In these cases, the kernel can
> > > > consume one or more Tx descriptors while building or validating a
> > > > multi-buffer packet, then drop the packet before it reaches the device.
> > > > Userspace still owns the UMEM buffers only after the corresponding
> > > > addresses are returned through the CQ. Missing completions therefore
> > > > make userspace lose track of those buffers.
> > > >
> > > > The generic path fixes cover three related cases:
> > > > * partially built multi-buffer skbs dropped by xsk_drop_skb();
> > > >   continuation descriptors left in the Tx ring after xsk_build_skb()
> > > >   reports overflow;
> > > > * invalid descriptors encountered in the middle of a multi-buffer
> > > >   packet, including the offending invalid descriptor itself.
> > > >
> > > > The zero-copy path is handled separately. The batched Tx parser now
> > > > distinguishes descriptors that can be passed to the driver from
> > > > descriptors that are consumed only because they belong to an invalid
> > > > multi-buffer packet. Reclaim-only descriptors are written to the CQ
> > > > address area and published in completion order, after any earlier
> > > > driver-visible Tx descriptors.
> > > >
> > > > The ZC batching path can also retain drain state when userspace has not
> > > > yet provided the end of an invalid multi-buffer packet. To keep this
> > > > state local to the singular batched path, the series prevents a second
> > > > Tx socket from joining the same pool while such drain state exists.
> > > > During the singular-to-shared transition, Tx batching is gated,
> > > > pre-existing readers are waited out, and bind fails with -EAGAIN if the
> > > > existing socket still has pending drain state. This avoids adding
> > > > multi-buffer drain handling to the shared-UMEM fallback path.
> > > >
> > > > The last two patches update xskxceiver so the tests account invalid
> > > > multi-buffer Tx packets as descriptors that must be reclaimed, while
> > > > still not expecting those invalid packets on the Rx side.
> > > >
> > > > This is a follow-up to Jason's changes [0] which were addressing generic
> > > > xmit only and this set allows me to pass full xskxceiver test suite run
> > > > against ice driver.
> > >
> > > There is a fair amount of feedback from sashiko already :-( So the meta
> > > question from me is: is it time to scrap our current approach where
> > > we parse descriptor by descriptor? (and maintain half-baked skb and
> > > half-consumed descriptor queues)
> > >
> > > Should we:
> > >
> > > 1. do desc[MAX_SKB_FRAGS] and xskq_cons_peek_desc until we exhaust
> > > PKT_CONT (if the last packet has PKT_CONT, return EOVERFLOW to userspace
> > > and do a full stop here)
> > > 2. now that we really know the number of valid descriptors -> reserve
> > > the cq space (if not -> EAGAIN)
> > > 3. pre-allocate everything here (if at any point we have ENOMEM -> cleanup
> > > locally, don't ever create semi-initialized skb)
> > > 4. construct the skb
> > > 5. xmit
> >
> > Yeah generic xmit became utterly horrible, haven't gone through sashiko
> > reviews yet, but bare in mind this set also aligns zc side to what was
> > previously being addressed by Jason.
> >
> > I believe planned logistics were to get these fixes onto net and then
> > Jason had an implementation of batching on generic xmit, directed towards
> > -next and that's where we could address current flow.
> 
> Agreed. That's what I'm hoping for. There would be much more
> discussion on how to do batch xmit in an elegant way, I believe.

This doesn't have to depend on the batch rewrite, we should be able to rewrite
this non-zc in net, this is still technically fixes, not feature work..

There was already a couple of revisions with this drain_cont approach
and every time I look at it feels like the cure is worse than the
decease :-( Obviously not gonna stop you from going with the current approach,
but these fixes feel a bit of a wasted effort to me (since the bugs keep
coming and we are piling more complexity).

