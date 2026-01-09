Return-Path: <netdev+bounces-248372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20566D07724
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 07:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 943AE300B80F
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 06:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A74E2E7BD6;
	Fri,  9 Jan 2026 06:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHIvue3i";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hNrLHS8B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853372417FB
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 06:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767941291; cv=none; b=sK2HkWU1/TXSvLQiatawTVhbk9i9cJUiDPWHPu5WZ7ZUIVFJpioOHBbRJSSjMPJOf5iuLlJnbLO8kZIqv8c2dqeQCIobsyNC4+NpXOK+33E6ofjfFs7eTcmMcvSorO9Jyp5ZQk+HXUHBkIQVCyhZhYVcEUCdLxHMHviGJy6+efw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767941291; c=relaxed/simple;
	bh=1t7HpXtfhndr//EM310eF9nsZ7x3boyagBYp2aL6CmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNpp7G3zVPLR/EPYjo/nwe5dQ9P9/yYVS3p2EzULfJ7yRH7O+o7Cm6/uD/v/IVzusjVCO1sIxftNV6ZmeSTqexX6adxILrw8+4xunBUquyz52a09LMvMzsL/+3ANMrJh46IFFDcUC1E1oo44JZxZYjnt1/KD3ZrRRAjaaMG1KPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KHIvue3i; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hNrLHS8B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767941285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/9K6fpSsNoEJIRz5SgfQXESe4sUZm/fKrYlDOxA0/w=;
	b=KHIvue3iDREjoahJArvBYcN3Ew+N3X2bPqVtqXUP2eVLqPfteITWjzr6cpKhccYrSm6rmC
	7Uai9xJI3M672mCDryduHL5+JRr+MoxPLCHVfCfmeDSEQQVii1FICwdyyORIB0qsHxvbI5
	5M7nZUBYhuTw9SPv10Vx6RJEZ6byDac=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-SWwio6dxMjq69K8BVBhdlA-1; Fri, 09 Jan 2026 01:48:03 -0500
X-MC-Unique: SWwio6dxMjq69K8BVBhdlA-1
X-Mimecast-MFC-AGG-ID: SWwio6dxMjq69K8BVBhdlA_1767941282
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47d3ba3a49cso34172025e9.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 22:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767941282; x=1768546082; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V/9K6fpSsNoEJIRz5SgfQXESe4sUZm/fKrYlDOxA0/w=;
        b=hNrLHS8Bbuz66rHhTSxrCNAH4Zit6MMh3RODkZR1hzQfuuKgvE3l9iDKSgDQEoMnF1
         0kjuYV5W3vBAesBNSsC72Suh0QvYvUBzmmLniLcg2K+zkpeSzMfpm3i0yFU/Kb+2i4pj
         F0973yJ+rbBMeBnDLvW7a1iPDfJBg7+lUgCHwnrW8pvK8Sgns1EfgMlirhRPUI7HGEn/
         6QJtcK1y0NymSJH5iJ3W2qvx7svKAtHgrY0pcd/9yOM2nr0P4oUPVdti6RqqJ3/xjW6q
         Gm1SJfDf7CCSrbd1v47LUYvxjkkkDieRsknyocUaiO9U0jIWhBaav7+ZQ/baBw6An32B
         Qs0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767941282; x=1768546082;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/9K6fpSsNoEJIRz5SgfQXESe4sUZm/fKrYlDOxA0/w=;
        b=IhaaX/kVuG2NJQXAoRTEb/LuZNgVYc8A/PhPkJkOoTKaKIhCY9hfMN+hv0EClXrE1z
         KaxJ0av/Jq8WOAcjIvQ8yeIpjxpUdC+HVl2l8mI9LOktc2wzBr+PiqhuYCS6zII6YH8g
         XaPflsHEJTVulpuuRo2wvkxboBl12Ui0+x2qDDLEYYeeqYEm2LEXFBDH36LJNjlNP3cq
         t7Qv2Qcw9uCca9rUQWNNQTexRTAEIosqUJsDVnLa+JhYxt1p7oYI2pxD049UfSkkLycf
         z6pssx1iN8lLD860gnhOdNIhw/5ci5jN3eNR3xL2gPUbU25Az/s1IlX8ZMc7NMfFPfDg
         de7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYSg3T1w9MhYQ6eIZRpkI31plwpfAQKoG8a0IU6jjrHByBpXhYQfl5qiJMq9TPX/wpg8VUqMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4YwP9HU8CiV94XvZna8PB2g0n1ZIO9b/Md0En6wJsSwImMZfu
	pEw01SqBIKCNmRgUbVT7p9AXtgvqNf/1g499zI9lmAzsiM38D9rxFmPhIOvNvsipRzecmnOjxhi
	3T7fnX1kiRLveYbaxCVzQRP8PKSh66xhtc6uBxqniqwOUgJnH4ckRj9UCUQ==
X-Gm-Gg: AY/fxX4Tybj0lU/SGp3b9N2Vchq3ynNeZ4Ft/8RxcYw5bzRiXGrYIMy89mqYBIC3YqM
	p1kEE8Z1TdvygQWowMfr+Ex58lm69xqF6spw+llIFYuCDxARV5uBuvg3/48vrct9caV6C+Aeq8+
	/GaJCJY/6JHfErkClaCEYGua/8hkhvqpupgHIERhV8Aoka8Dm9TcVHuhNsCemSAYzkK37xJeDJp
	UvCqZGCZn+VOClbeYvbOHPx7NdYuDr4iS0KJbbu4zE20IG2Y5seVseBs6X4bapQk/9em0OFkpl5
	IS5RjimCyxmQUaYCa5ke92HUYnvesjIB5kWQCZjzTXUn6cY2sy+0mdSOvB6M+bxbjw/grqEubMC
	oPKl7FsjSbWNcqKkgWLtKXx8DC6pxMxrnlg==
X-Received: by 2002:a05:600c:83c9:b0:45d:5c71:769a with SMTP id 5b1f17b1804b1-47d84b3b650mr97118315e9.26.1767941281931;
        Thu, 08 Jan 2026 22:48:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5mwMLnpPXtS3sSstkOI4XZ+lgxWp4YHE6MscmmctxPLldO2W4ddVXCOcgeyZ9c3lCcV9aiA==
X-Received: by 2002:a05:600c:83c9:b0:45d:5c71:769a with SMTP id 5b1f17b1804b1-47d84b3b650mr97117985e9.26.1767941281330;
        Thu, 08 Jan 2026 22:48:01 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f410c86sm194224835e9.3.2026.01.08.22.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 22:48:00 -0800 (PST)
Date: Fri, 9 Jan 2026 01:47:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>,
	willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, eperezma@redhat.com, leiyang@redhat.com,
	stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v7 2/9] ptr_ring: add helper to detect newly
 freed space on consume
Message-ID: <20260109014322-mutt-send-email-mst@kernel.org>
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <20260107210448.37851-3-simon.schippers@tu-dortmund.de>
 <CACGkMEsHxu_iyL+MjJG834hBGNy9tY9f3mAEeZfDn5MMwtuz8Q@mail.gmail.com>
 <ba3cffe3-b514-435d-88a8-f20c91be722a@tu-dortmund.de>
 <CACGkMEv2m5q-4kuT5iyu_Z=5h0SMz0YYeKRBu8EtrxC_E-2zWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEv2m5q-4kuT5iyu_Z=5h0SMz0YYeKRBu8EtrxC_E-2zWw@mail.gmail.com>

On Fri, Jan 09, 2026 at 02:01:54PM +0800, Jason Wang wrote:
> On Thu, Jan 8, 2026 at 3:21 PM Simon Schippers
> <simon.schippers@tu-dortmund.de> wrote:
> >
> > On 1/8/26 04:23, Jason Wang wrote:
> > > On Thu, Jan 8, 2026 at 5:06 AM Simon Schippers
> > > <simon.schippers@tu-dortmund.de> wrote:
> > >>
> > >> This proposed function checks whether __ptr_ring_zero_tail() was invoked
> > >> within the last n calls to __ptr_ring_consume(), which indicates that new
> > >> free space was created. Since __ptr_ring_zero_tail() moves the tail to
> > >> the head - and no other function modifies either the head or the tail,
> > >> aside from the wrap-around case described below - detecting such a
> > >> movement is sufficient to detect the invocation of
> > >> __ptr_ring_zero_tail().
> > >>
> > >> The implementation detects this movement by checking whether the tail is
> > >> at most n positions behind the head. If this condition holds, the shift
> > >> of the tail to its current position must have occurred within the last n
> > >> calls to __ptr_ring_consume(), indicating that __ptr_ring_zero_tail() was
> > >> invoked and that new free space was created.
> > >>
> > >> This logic also correctly handles the wrap-around case in which
> > >> __ptr_ring_zero_tail() is invoked and the head and the tail are reset
> > >> to 0. Since this reset likewise moves the tail to the head, the same
> > >> detection logic applies.
> > >>
> > >> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > >> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > >> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> > >> ---
> > >>  include/linux/ptr_ring.h | 13 +++++++++++++
> > >>  1 file changed, 13 insertions(+)
> > >>
> > >> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> > >> index a5a3fa4916d3..7cdae6d1d400 100644
> > >> --- a/include/linux/ptr_ring.h
> > >> +++ b/include/linux/ptr_ring.h
> > >> @@ -438,6 +438,19 @@ static inline int ptr_ring_consume_batched_bh(struct ptr_ring *r,
> > >>         return ret;
> > >>  }
> > >>
> > >> +/* Returns true if the consume of the last n elements has created space
> > >> + * in the ring buffer (i.e., a new element can be produced).
> > >> + *
> > >> + * Note: Because of batching, a successful call to __ptr_ring_consume() /
> > >> + * __ptr_ring_consume_batched() does not guarantee that the next call to
> > >> + * __ptr_ring_produce() will succeed.
> > >
> > > This sounds like a bug that needs to be fixed, as it requires the user
> > > to know the implementation details. For example, even if
> > > __ptr_ring_consume_created_space() returns true, __ptr_ring_produce()
> > > may still fail?
> >
> > No, it should not fail in that case.
> > If you only call consume and after that try to produce, *then* it is
> > likely to fail because __ptr_ring_zero_tail() is only invoked once per
> > batch.
> 
> Well, this makes the helper very hard for users.
> 
> So I think at least the documentation should specify the meaning of
> 'n' here.

Right. Documenting parameters is good.

> For example, is it the value returned by
> ptr_ring_consume_batched()(), and is it required to be called
> immediately after ptr_ring_consume_batched()? If it is, the API is
> kind of tricky to be used, we should consider to merge two helpers
> into a new single helper to ease the user.

I think you are right partially it's more a question of documentation and naming.
It's not that it's hard to use: follow up patches use it
without issues - it's that neither documentatin nor
naming explain how.

let's try to document, first of all: if it does not guarantee that
produce will succeed, then what *is* the guarantee this API gives?

> 
> What's more, there would be false positives. Considering there's not
> many entries in the ring, just after the first zeroing,
> __ptr_ring_consume_created_space() will return true, this will lead to
> unnecessary wakeups.

well optimizations are judged on their performance not on theoretical
analysis. in this instance, this should be rare enough.

> 
> And last, the function will always succeed if n is greater than the batch.
> 
> >
> > >
> > > Maybe revert fb9de9704775d?
> >
> > I disagree, as I consider this to be one of the key features of ptr_ring.
> 
> Nope, it's just an optimization and actually it changes the behaviour
> that might be noticed by the user.
> 
> Before the patch, ptr_ring_produce() is guaranteed to succeed after a
> ptr_ring_consume(). After that patch, it's not. We don't see complaint
> because the implication is not obvious (e.g more packet dropping).
> 
> >
> > That said, there are several other implementation details that users need
> > to be aware of.
> >
> > For example, __ptr_ring_empty() must only be called by the consumer. This
> > was for example the issue in dc82a33297fc ("veth: apply qdisc
> > backpressure on full ptr_ring to reduce TX drops") and the reason why
> > 5442a9da6978 ("veth: more robust handing of race to avoid txq getting
> > stuck") exists.
> 
> At least the behaviour is documented. This is not the case for the
> implications of fb9de9704775d.
> 
> Thanks
> 
> 
> >
> > >
> > >> + */
> > >> +static inline bool __ptr_ring_consume_created_space(struct ptr_ring *r,
> > >> +                                                   int n)
> > >> +{
> > >> +       return r->consumer_head - r->consumer_tail < n;
> > >> +}
> > >> +
> > >>  /* Cast to structure type and call a function without discarding from FIFO.
> > >>   * Function must return a value.
> > >>   * Callers must take consumer_lock.
> > >> --
> > >> 2.43.0
> > >>
> > >
> > > Thanks
> > >
> >


