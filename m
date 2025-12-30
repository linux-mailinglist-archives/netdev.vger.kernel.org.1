Return-Path: <netdev+bounces-246359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B92CE9C1E
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 14:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19CAF3004ED5
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 13:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230A7221271;
	Tue, 30 Dec 2025 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BcNeAe5G";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EntBm+Mc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7320A222597
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767100378; cv=none; b=MmcHI3ej+yh8NJ77VB3j04WWj7jSVuGlEB1WSbkepQ32Fh8B4HEgFTLkQhjJ45nTqv32aw/MIKqnRcoD2ECSo5HZQCF8dmQgs9eMH8uv7CIFIr6Aa9Vc9ZYKDKCwvYrAeapyl4xTf3X2CdyoL7HyqBUf5dGFR8wu8/vhK5uIH1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767100378; c=relaxed/simple;
	bh=yshyoaf7aBfz+NMN2fw0sj4I02giqCATUhq7XTqk+IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeFAFm8p2v2Rr6yyTH+u+U7szAXGqihg00wxgyBieVHj5eN1fFbnPHNUlpNemJ3Tm6F8quiNcPBtAB1z+6TVXo4zVmv/n9hiKjv3lTPg4qQJtRdKkNXAOdIzO1MUr8+csmIUchU2AkoDFvh799OmrNNTSYZTsmpGJBiySYR727s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BcNeAe5G; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EntBm+Mc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767100375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q4qKNRGg/6WWGMgB9lM5TR4Ah2AajR+atlTUoRuUE38=;
	b=BcNeAe5G2UhymTofdqzxNJ7FHP37OnYIlihB2RAMImcFGcQC8qGPxoKkPq9s4RSix5RW7/
	PETQXiCsLsaD+Y7RI3SrJD04adQDFHB6IygIMfofMVriqgVpEDFEEbY8hXsFKpIlqJE9qt
	DnxTBQrSWQ27dt2CQsWcvwa+ORrkk5Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-TV3o0lUuOFaJPr_BFzYF8A-1; Tue, 30 Dec 2025 08:12:52 -0500
X-MC-Unique: TV3o0lUuOFaJPr_BFzYF8A-1
X-Mimecast-MFC-AGG-ID: TV3o0lUuOFaJPr_BFzYF8A_1767100371
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430fcfe4494so9597359f8f.2
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 05:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767100371; x=1767705171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q4qKNRGg/6WWGMgB9lM5TR4Ah2AajR+atlTUoRuUE38=;
        b=EntBm+McV7HllHm+mFVyEC9OdBlQTd9qDClzOeN1Ko0SHk8AzxPEhnAH8v7fcdFigP
         356Y5XAcoMkgrX71IqOftJT1Bv/7smE4gQ7FU1nNOAX8XccCgDuZ6d7QquSPbRXPJYm2
         KCmttkYerhh3qyPYrkmKYq0kPFVEekquFEan9CRDxBpORKANjmDnAEK91ocK28IPrdwY
         HcURfEmCIW7iL9VVugkDqV7FS7Ca/XLwS61fyihu9HgNgrucTuNE2q5TgouJ2sfjH25e
         sKprYyXvjCixz7hNKnlfycIC1b99WiuknF1AkhQ+fdUAba2Mx4b7h/2M44NsSXeeNXXj
         v7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767100371; x=1767705171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4qKNRGg/6WWGMgB9lM5TR4Ah2AajR+atlTUoRuUE38=;
        b=dNP7zHH2ohaBW1sPAIui0IoNz9QfjWSN1XXB9rp+QnM1pirR6VE4wnBI5syCXkoOX7
         mJ0hy+yFRr9zeR4Z6PrsSgS+ngBqrNx/pZwx9Kdyrg2qHrr0LxLmI8qPZ5Qd+6CGi+6d
         L94oPHA2zUnu8QMHmIuT44zDNNGShUIy1UIr1bst/hK39Sft1xyR0bcH2x1LuuqCZqmj
         T4YYUuABjpv2lc7kRFM5QmwdMQUQ7Be83jDAWvVfA3dVX5IP2tHXFbOTj9WZk5wNzfLX
         huoVB1SwAE+CIiWPIvTHRib2tRhMhz5yf7s9boWXsJ/32qWYwPwg/tSnUCdzQQQbZPTP
         q9sA==
X-Gm-Message-State: AOJu0YyR5XIJZTSfnPUCNMxfKKLLsnXIBfh/DLF39hvaMlY/2OvDjfuh
	7E6MjwA4XFS3f8E6ZZRsomspCdMEg7rjDpQ3LdULq+ukiMaVRwvmpFnVA2L/AzdXdObqqNAHOht
	NdLBj1aE0V+aYFXPI2QD+xsM3KvUZyAvc43X2gD5uyBcBaAb/51t04q+KbA==
X-Gm-Gg: AY/fxX5FMWlS1uVk8NMk8MhlCO10upR8HAqdMN+e1ZNx9rF+0n9/Mti/YvakW2NqU4I
	LUNWWndCNscpLBmNt9vlHlyjo8M4gEkW2AwnvBb5EOkKaeVfmM8lfH21F8XLCiRwimDTuYdHT3K
	5dSgyezcFG/WOFdYSQOatd9m9yqvvPJ588AyZgRgE8Ehv1TNkHHpncxoe0fkiUyZbBOT/VWEh3q
	is+7OF9gVa6VT1svx4inkyV1K8gbnUOFAqc6ilUccWsgMAZ8GuXGYSAJovHK3gxl7MoHQEPxeGV
	+htle/tFB5LTFNvNgBBK7YJDfaCGJK/Sau5mNNrNP0Y+9bGpexJRSrEeV9Vf5InDoz4863tWS1f
	C7nCqobDze2t3KRE/0U+jQJW5J1sYPFhp/w==
X-Received: by 2002:a05:6000:250a:b0:431:369:e7b with SMTP id ffacd0b85a97d-4324e4cd1eemr36325951f8f.18.1767100370795;
        Tue, 30 Dec 2025 05:12:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuV3/ZjKqoSSHFRBYNJUPg47idnrIgoJm7eIDekNLmSLi3bfRdDLg5urxUISPXXKwMDGaCjQ==
X-Received: by 2002:a05:6000:250a:b0:431:369:e7b with SMTP id ffacd0b85a97d-4324e4cd1eemr36325923f8f.18.1767100370365;
        Tue, 30 Dec 2025 05:12:50 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b1bdsm67844200f8f.8.2025.12.30.05.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 05:12:49 -0800 (PST)
Date: Tue, 30 Dec 2025 08:12:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, Cong Wang <cwang@multikernel.io>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [Patch net] vsock: fix DMA cacheline overlap warning using
 coherent memory
Message-ID: <20251230081220-mutt-send-email-mst@kernel.org>
References: <20251228015451.1253271-1-xiyou.wangcong@gmail.com>
 <20251228104521-mutt-send-email-mst@kernel.org>
 <aVGz39EoF5ScJfIP@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVGz39EoF5ScJfIP@pop-os.localdomain>

On Sun, Dec 28, 2025 at 02:49:03PM -0800, Cong Wang wrote:
> On Sun, Dec 28, 2025 at 02:31:36PM -0500, Michael S. Tsirkin wrote:
> > On Sat, Dec 27, 2025 at 05:54:51PM -0800, Cong Wang wrote:
> > > From: Cong Wang <cwang@multikernel.io>
> > > 
> > > The virtio-vsock driver triggers a DMA debug warning during probe:
> > > 
> [...]
> > > This occurs because event_list[8] contains 8 struct virtio_vsock_event
> > > entries, each only 4 bytes (__le32 id). When virtio_vsock_event_fill()
> > > creates DMA mappings for all 8 events via virtqueue_add_inbuf(), these
> > > 32 bytes all fit within a single 64-byte cacheline.
> > > 
> > > The DMA debug subsystem warns about this because multiple DMA_FROM_DEVICE
> > > mappings within the same cacheline can cause data corruption: if the CPU
> > > writes to one event while the device is writing another event in the same
> > > cacheline, the CPU cache writeback could overwrite device data.
> > 
> > But the CPU never writes into one of these, or did I miss anything?
> > 
> > The real issue is other data in the same cache line?
> 
> You are right, it is misleading.
> 
> The CPU never writes to the event buffers themselves, it only reads them
> after the device writes. The problem is other struct fields in the same
> cacheline.
> 
> I will update the commit message.
> 
> > 
> > You want virtqueue_map_alloc_coherent/virtqueue_map_free_coherent
> > methinks.
> > 
> > Then you can use normal inbuf/outbut and not muck around with premapped.
> > 
> > 
> > I prefer keeping fancy premapped APIs for perf sensitive code,
> > let virtio manage DMA API otherwise.
> 
> Yes, I was not aware of these API's, they are indeed better than using
> DMA API's directly.
> 
> Thanks!
> Cong

BTW I sent an RFC fixing these bugs in all drivers. Review/testing would
be appreciated.


