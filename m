Return-Path: <netdev+bounces-291316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IrlLaVDFGrVLQcAu9opvQ
	(envelope-from <netdev+bounces-291316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:42:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E945CA9ED
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A10B730075C5
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1AC381AE0;
	Mon, 25 May 2026 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMlqTuSM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VoKsHsT+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BEE481B1
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779712930; cv=none; b=s2qm9EH0rfYFh/IQ5iDaA1Jp8gyxhHFjEecHt4gDVxyf7HqFQMEDL4OFFTvoRYl+Ow4aUtSHEw6OJremcEDzOhcnAqbNpS4RbAAe9UzBPf1oVIrxDW7Aqi6oXwrXQwr/5XH7KpyvTGj1iRDQzyityhidOw8hbZHLEYNnVkShgwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779712930; c=relaxed/simple;
	bh=nBZFB/qKiQFEmkpum3LmDBV+XZABkX4tDlOB6EU6g/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asL6h1VwkBkzdA40ffPoktA8eSOg/+gmWypYyVHO24ts7WQlHsUG40UVMNuBWuocSbBT4szccsejhIz6QudtTyXnFCXi8Qimy6lk4z6Ruo4ufOti+jzkq44y/e04PGFxPgOiiKZ4VhtTWzHCDL2aJg235dcGhVLiTF1Sr5RoU8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BMlqTuSM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VoKsHsT+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779712928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C2mO9ihHPbnXM6c2+MtWPyD/ZxOr74sqrY+NK7spw+c=;
	b=BMlqTuSMfdRkGcdVve3VAHdwTWohlYbaaEkBRUg1fScrvyo42mnRWJSOzrVb2Kkp8zguOl
	JVfH/K78W4X9kzOqmm6vkXGllU93N4gbtvMnQIL+ZD8ta04REpiACC/cZj1kNZu7k9vowg
	eRdV3di52PrROBUico+LHZWvPB2anRU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-SKv1VgF0MwO3n0g84USM5Q-1; Mon, 25 May 2026 08:42:07 -0400
X-MC-Unique: SKv1VgF0MwO3n0g84USM5Q-1
X-Mimecast-MFC-AGG-ID: SKv1VgF0MwO3n0g84USM5Q_1779712926
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d7b7bacddso6576812f8f.0
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 05:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779712926; x=1780317726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C2mO9ihHPbnXM6c2+MtWPyD/ZxOr74sqrY+NK7spw+c=;
        b=VoKsHsT+E9v36NgANdIVDxnzvmPXBdCzjU182ePme/onYYVA+/QIX1cRo3OSvMcrQW
         Hayz8BQq8zdvo4QkHcpz589X3Lgjv57CqBO2YnEHh4u/kGKYltHLLXzgwXhmDKqh/8+v
         jO6v45NmFodBqyFBHAODgDWQomU4D4KW3ZzJ60tGZQz48rHML7i0n+nzRhquE3vOiSGA
         PWHv22G7hAifGs40ngnyx9YAPWd+0OsXktep1VnC+lqM4ixpMbjrvALcuXJ/3eGMWIZu
         GG+ovmkuSeESVggZECz4qsSQO8z/SzcXkN/uQDFBWxMsbDYuGtDrEgciI+wScgtxt/k6
         OwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779712926; x=1780317726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2mO9ihHPbnXM6c2+MtWPyD/ZxOr74sqrY+NK7spw+c=;
        b=ju92iy1yzgojiPqEBqpNOHjIFWj47itz6C0Yz6FxIGRO9Zl6Gd8IQLh5tG94lt//y5
         do76/AayS4je+wsihpb1QZRobyAS4ipvqngCgHGrqfQPgNlCrKjcnV6yRHWyB38tvQjI
         f0+Hr+qzkfG3QpOq2KlBzy4Wptkm7qzLbuiF2n5EGRV1T1b+utZQL+h1yK8aYx37c8zc
         q9cD1lUchfcE62GZ5DcZvu68L20HW7kqkNicNR9OOIX92RKB75aAYB+VeDes31umoOwr
         nul0aKCguvcF59oG9NDA6p0lSj+KvFktlEN13fn0ZzbQMTBWsrqL5YIaaLfHAHwYyhNP
         Kq/g==
X-Forwarded-Encrypted: i=1; AFNElJ/rLjknbZrM2cnbH6RHRQRoyQRLeMHglkB1f3csiLpa2ZD39lSZ/73+cTLPEKDLVW9XFWo3s50=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ5/K3XgzQqRJyn7wdf0jZwu3xJYVwVi4SxApM10R1uFPUe9Yj
	7kk6+3vEV2Pdzk3pENYhr4O+F7p/7NcSTLVL5qBIsjlM4cLGIy+t4kLTDpvorEgaAEGfYIFFUQK
	oVeKEiCdqSEgvegZGr0Fwq8WPGUBLqJncTIk/sp12RG5xcnu5py1ZQIlr6g==
X-Gm-Gg: Acq92OFzMAs+sOBRM/UJPZT+u1kZnMt/FKRxQi5jhq1z/uo40J8sFQgsnvto1dClNTC
	cbZxMTG3vyMeZ6wTCysbtdbVVPxc+6IYsz/mwJQ0ykafq/PrgaoAnAPpJZoacqNpOiW38ncSeWR
	vR0hKclZwM5/UHO47Wszk5bOeUZBfQSW948cI055E4AMBSLc2w3C4W+cFB/EyO9oPyP6gfZ+T/j
	/xbbOhFfceDPxl/x81hqKB6fD+0WHhbrVnQtMCv6Qh7rde8Pt5MULg9+1irZYySCowD8Q+ArvdB
	Hae5Gavv+O2ZW7FDpZ938KPuvmDzhHao/xzrqIPRLP/dxySU9VYEX9ZqJvU3X167TA1S8byyJAT
	sLCvGtRUA3FAcGMTd4C/QnGxNmapXdPan+bE6hsl7Zibfs5IchvEgig==
X-Received: by 2002:a05:6000:4605:b0:43d:7bc9:9b2c with SMTP id ffacd0b85a97d-45eb3687941mr23325981f8f.17.1779712925862;
        Mon, 25 May 2026 05:42:05 -0700 (PDT)
X-Received: by 2002:a05:6000:4605:b0:43d:7bc9:9b2c with SMTP id ffacd0b85a97d-45eb3687941mr23325918f8f.17.1779712925385;
        Mon, 25 May 2026 05:42:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d4850dsm25575281f8f.17.2026.05.25.05.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 05:42:04 -0700 (PDT)
Date: Mon, 25 May 2026 08:42:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org,
	xuanzhuo@linux.alibaba.com, horms@kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, kuba@kernel.org, eperezma@redhat.com,
	pabeni@redhat.com, davem@davemloft.net, jasowang@redhat.com,
	stefanha@redhat.com, edumazet@google.com, stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
Message-ID: <20260525083859-mutt-send-email-mst@kernel.org>
References: <20260521124732.125771-1-sgarzare@redhat.com>
 <177950282964.1445071.6600517211632117224.git-patchwork-notify@kernel.org>
 <20260523173557.5cc4f4f6@pumpkin>
 <ahQbVxvbBEJZ3TBU@sgarzare-redhat>
 <20260525115314.3cf310e6@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525115314.3cf310e6@pumpkin>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-291316-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,netdevbpf];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 16E945CA9ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 11:53:14AM +0100, David Laight wrote:
> On Mon, 25 May 2026 11:57:45 +0200
> Stefano Garzarella <sgarzare@redhat.com> wrote:
> 
> > On Sat, May 23, 2026 at 05:35:57PM +0100, David Laight wrote:
> > >On Sat, 23 May 2026 02:20:29 +0000
> > >patchwork-bot+netdevbpf@kernel.org wrote:
> > >  
> > >> Hello:
> > >>
> > >> This patch was applied to netdev/net.git (main)
> > >> by Jakub Kicinski <kuba@kernel.org>:  
> > >
> > >Did anyone else notice that is isn't a bug?
> > >
> > >There is no way that a 'count of bytes of kernel memory' can overflow
> > >the size of 'long'.  
> > 
> > It's more of an estimate than an actual calculation of memory usage if 
> > we queue the incoming packet. In theory, an overflow could occur if the 
> > user sets `buf_alloc` to 4GB. In practice, though, I think you're right: 
> > the memory should run out before we get to that check.
> 
> The calculation is:
> 
> 	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0); 
> 
> skb_queue_len() will be the number of items on the queue.
> SKB_TRUESIZE(0) is the memory taken up by a zero length skb (basically sizeof(skb)).
> 
> Unless you either corrupt the queue length or manage to allocate skb that use
> less than the minimum about of memory that product can't overflow 'unsigned long'.
> 
> The later calculations might wrap - but the multiply can't.
> 
> -- David


Indeed, I wasn't thinking. For this to even get close to overflowing
we'd have to have almost all of 4G available to the 32 bit kernel taken
up by this single queue.

Revert, I'd say.

> > 
> > Thanks,
> > Stefano
> > 
> > >
> > >-- David
> > >  
> > >>
> > >> On Thu, 21 May 2026 14:47:32 +0200 you wrote:  
> > >> > From: Stefano Garzarella <sgarzare@redhat.com>
> > >> >
> > >> > On 32-bit architectures, both skb_queue_len() and SKB_TRUESIZE(0) evaluate
> > >> > to 32-bit values. The multiplication can overflow before being assigned to
> > >> > the u64 skb_overhead variable, making the skb overhead check ineffective.
> > >> >
> > >> > Cast skb_queue_len() to u64 so the multiplication is always performed in
> > >> > 64-bit arithmetic.
> > >> >
> > >> > [...]  
> > >>
> > >> Here is the summary with links:
> > >>   - [net] vsock/virtio: fix skb overhead overflow on 32-bit builds
> > >>     https://git.kernel.org/netdev/net/c/4157501b9a8f
> > >>
> > >> You are awesome, thank you!  
> > >  
> > 


