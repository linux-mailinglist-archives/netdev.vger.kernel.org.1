Return-Path: <netdev+bounces-223233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F40B58774
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 00:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F74B207F98
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 22:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19D32C15BA;
	Mon, 15 Sep 2025 22:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvBQtdJf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151DD2C15AB
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 22:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757975030; cv=none; b=C+2lsxDANC+W0xjs/xHBQasyrkoBRNA2DNdvaHPvSnTGrNbtgscVJcmbjAmz4reF1LX7mnAU0b3ww5Q9S0PI8KuQLSqDG3315qmvkRI1BhR8Qd6SzN8V1SLmNFxeycTL1g3ivBffgD7M1VLFe2spLV5JbaPCJzRfxluT2yhCWP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757975030; c=relaxed/simple;
	bh=Deus/OWdVLZ2R3WKItEKOGVXH14LkytRL6v3j0WjP48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UytmYlMC8CNK4GUJ1KK/BGDzzYjtDmjd2by5Oxw3oaHOQgXzrojDDnxq0T2MINt6D3znd38Ell++Uj7DVQgP7yFknQS5L+mQL64IlHdSeqEIabYntuOH78OYLLfhmn+23a3T5QSUrknbragbBWY0iLQ1tiLmuaOVk1nOR1XSBPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dvBQtdJf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757975028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGRejJG0eDtlNIu2fdRBanuS2WqJ6w4xAk6USL54XjI=;
	b=dvBQtdJf2aivbPbT+2FpORK7WEPeJaeuVjISv6NLaeMLYZEhsj6stRvdjq37KYkVasBu9G
	wD6gZz/tYzwnMZC0CHP9To4KtXKiTsN5IX+7XYh3DqnedsqsLpNSAYDHww0bXc/bfJ5cZQ
	0n0FqCwWFNMhizulMIMIsEmxP4Vlb8U=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-Si9fuEDLNFKx0jaN4QPD6g-1; Mon, 15 Sep 2025 18:23:46 -0400
X-MC-Unique: Si9fuEDLNFKx0jaN4QPD6g-1
X-Mimecast-MFC-AGG-ID: Si9fuEDLNFKx0jaN4QPD6g_1757975025
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b044a42959dso349444666b.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 15:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757975025; x=1758579825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGRejJG0eDtlNIu2fdRBanuS2WqJ6w4xAk6USL54XjI=;
        b=cFXzp2+nL0tsAkMCGAUUUpn8eyzIumspoozPVWCosJvC9IktAe9D9yio/KhpId5Lzj
         +XqfqeZsHB8XFR5AbUyWmZxZiGzZ+b4rzs5L/QHclZOOeOQ4FMNAZjdveBGXjrd+cAez
         EolrcrgSeiLRvmY4rEeX5a+ogWshrRxXbKBWPtf8zbWfTvOFvZM7RPa4qny1VHK9U7NU
         SIOQ5d9obceDg2evjTyfxMxUi4/x9i9f8FbJq4aaqQXrpk7xn+z0lg5ZPm30g/sBlPYg
         SMBLmcg2gt6To4LtBa4Z5QAy2D0sgch+Qp1s8BQHxnFxHlRrtFxLqVo8NYhHwbhVnl/K
         lgXA==
X-Forwarded-Encrypted: i=1; AJvYcCUM09S1DCB+PW3aXWsYu/TXFRQQiT/XbqyAVS0NIJtrfAhCLNfpqQiA193jdtxwvKLKh9ODLmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIjyJ8mPH0bwHSdTBgJb1NnHnV4/EOhlmZEleAf/X9XfQj1uOP
	l5vh44qMi/LfE5fNoXxJmf73hPmqlxJANgH/aFTUxKJpdo+p3tQkmJgypzrB6NrLuTuFtYqHgm3
	cR6p+Tr0kZCpI/LzX+LAgpYxf6YomhwiNCjZT+cT++Iq9ziIyfuXARCNvpQ==
X-Gm-Gg: ASbGncvByMnDwimXcYvig41hfq0MH//AaGUrMejPFCWydwswmv+c/KSryKuan4Gm6xT
	9OZfsA3J34UKZLF94CuUjEcJpD4onML3AXn3ehXiOsJc7SnwA/dR/BaFrhyxV/G7ssdLRnZsNet
	T3oNqzWQzAP8CxkIxOj6IXq9xQ4GaAaYcoQNF8RwLropCyoVNS3wX81f1i7o3F0CXiMxTbK4M/D
	MEUpAvqcEUzmELhNG6vbiWEQGvFgWmGbs1g+cFhISy/DDnrfRQglMo3ayHqv8ISBGWMUS1cz6OQ
	zxGwKRyZy20RlJqYEvKd+LqHZ2wH
X-Received: by 2002:a17:907:3c84:b0:afe:7909:f42a with SMTP id a640c23a62f3a-b07c383f22bmr1387709366b.51.1757975025363;
        Mon, 15 Sep 2025 15:23:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+pGzLsoXLRChFyMRuXFtC2HnABVGjt1L9MQILzU2f9q6UKgKHj6iY8Hiri9BM8h4OsvMUXA==
X-Received: by 2002:a17:907:3c84:b0:afe:7909:f42a with SMTP id a640c23a62f3a-b07c383f22bmr1387708066b.51.1757975025017;
        Mon, 15 Sep 2025 15:23:45 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62edbc829b3sm8379978a12.28.2025.09.15.15.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:23:44 -0700 (PDT)
Date: Mon, 15 Sep 2025 18:23:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited
 task
Message-ID: <20250915182232-mutt-send-email-mst@kernel.org>
References: <20250827194107.4142164-1-seanjc@google.com>
 <20250827201059.EmmdDFB_@linutronix.de>
 <aK-f45qszH2VEzV7@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aK-f45qszH2VEzV7@google.com>

On Wed, Aug 27, 2025 at 05:16:35PM -0700, Sean Christopherson wrote:
> On Wed, Aug 27, 2025, Sebastian Andrzej Siewior wrote:
> > On 2025-08-27 12:41:04 [-0700], Sean Christopherson wrote:
> > > Michael,
> > 
> > Sean,
> > 
> > would the bellow work by chance? It is a quick shot but it looks
> > symmetrical…
> 
> Gah, sorry, I flagged your earlier mail and then forgot to circle back to it
> (for whatever reason, I didn't entirely grok what you were suggesting).
> 
> > diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> > index bc738fa90c1d6..27107dcc1cbfe 100644
> > --- a/kernel/vhost_task.c
> > +++ b/kernel/vhost_task.c
> > @@ -100,6 +100,7 @@ void vhost_task_stop(struct vhost_task *vtsk)
> >  	 * freeing it below.
> >  	 */
> >  	wait_for_completion(&vtsk->exited);
> > +	put_task_struct(vtsk->task);
> >  	kfree(vtsk);
> >  }
> >  EXPORT_SYMBOL_GPL(vhost_task_stop);
> > @@ -148,7 +149,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void *),
> >  		return ERR_CAST(tsk);
> >  	}
> >  
> > -	vtsk->task = tsk;
> > +	vtsk->task = get_task_struct(tsk);
> >  	return vtsk;
> >  }
> >  EXPORT_SYMBOL_GPL(vhost_task_create);
> 
> Nice!  This fixes things too.  Either solution works for me.  Or maybe do both?
> Attempting to wake a task that vhost_task knows has exited (is exiting?) is a
> bit gross, but even with that hardening, guarding against UAF is very nice to
> have too.
> 
> Tested-by: Sean Christopherson <seanjc@google.com>

Sure let's do both.

-- 
MST


