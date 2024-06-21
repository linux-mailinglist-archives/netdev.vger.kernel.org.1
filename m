Return-Path: <netdev+bounces-105609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C420E911FDC
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 11:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 433B51F217A0
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 09:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256AD16F0C1;
	Fri, 21 Jun 2024 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNHS+Mpt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D22D16DED4
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960317; cv=none; b=YBwA+ejSFw7s6esk3CkDCZfmIwWUdwdhUmHqYqafvhTUHPDsCt1XuB0uR5ZU4Wbyc0bGIQOH7KiUIlso6HubQRq5nQ5dQHLgBVt16SemCwPk9rKusSbhsTv9dcrzsxZcgatIKL2vs7mdqTw2QpgMb+/4VRCKgCn6Q4iCk8w733g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960317; c=relaxed/simple;
	bh=AQ+ID0DA1jK4+ZCMX/FnKYe90YTkB/M3+du/l1LQjXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuVWU2ZtrmA1HKUxsyFGTHPdK/MDYe3wFIRQDNbYVENkpi39EoRb6RONFhvRBAaNXnGnOZJoG/n3dZx+wxdvt/9V9YDAl5R7jGlGO9P2cPa0WCTJj8jH7Ac3l/PSESNvabkKtTG7sW8wyTQFzBludGesp8zgSGFGDG0ufCoawwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LNHS+Mpt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718960314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vutxhf8uxFndqug4g0c9F/LG6YE94IcWu9Cp4ajFWgk=;
	b=LNHS+MpttPQ31TA3zIkYy4TBvwF40THWzC/4SxRQEfcurKKXqKLY+BG5uk7vt1qosym0hM
	aHQnNtXnssE7IBdbuhcqhljS4h7pmucDY5zjDAh2fViJkZ1AAtbSCbJACYyJHeHK42tqZd
	zciSkM11gNTb/eEbLzShsExXRuyh7WY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-xozMBqtyNriAyl1IRn720A-1; Fri, 21 Jun 2024 04:58:31 -0400
X-MC-Unique: xozMBqtyNriAyl1IRn720A-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b5093b20d9so22096096d6.2
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 01:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718960311; x=1719565111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vutxhf8uxFndqug4g0c9F/LG6YE94IcWu9Cp4ajFWgk=;
        b=orOgs782bqgbOQLX6XIrp5d9pAyHs0aCIBThZUrAjTaHr1sG//6R7d7L1g0sQSy0uX
         oI+gNlM4uj3YNKvrbipqAc75R8J1G7pLFeGi53/KQEFmLbfOuN0ziCdNTBkKRFxHpz8Z
         6tisfbTavw6zgZPmhw4n3GFbrjbg9cGPhxeFfExjcjvA0AcAg6IuNmdn79wXNiMUjFhU
         0P398AnSPMjEyrIG8Pfaw9xTKikzSR6GAnPNMWHeTkwRovuj6kCcHc3LonPirjwPJnJm
         slTpHMB3+8++Dewz4ws8n3Q1Z7n6TlS0y3FMpXwZt3Uzml2razm8UZCMexqLp4tQJ99n
         NJpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAV47GH5nln7ITzr1rsPyqcdsgSfmfgpVvJcnRguth07WZFZawgF0+ggruhv0uu9cIhn0PzUq4qWb/oS7lzHcHrhqQLRD7
X-Gm-Message-State: AOJu0YxGy48X6G/oQ1YtgPZMnAcKEGvv+uPg6h9ZdyaGBIjJYNx1elJx
	9ysALuc4K3+Vf4bIsMC9mECLKvf1ycwEwm6neHALVDlEImIt9kQLB5IkLocCuP1NaFp43NHfPaO
	UZluxnmXzE+xN9BUkkMipJ+cb0+PFQGj8nlhlVS4Z+ckaA1flA75xdA==
X-Received: by 2002:a0c:ab1b:0:b0:6b5:1f3f:90da with SMTP id 6a1803df08f44-6b51f3f9210mr13211166d6.44.1718960310824;
        Fri, 21 Jun 2024 01:58:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTOBW5XSMFiCt83nOBHrUcn1ad6WztAjAHMy3DXFKpVAAedgDu30BuOShI9qFs3dk2a9FNnQ==
X-Received: by 2002:a0c:ab1b:0:b0:6b5:1f3f:90da with SMTP id 6a1803df08f44-6b51f3f9210mr13210966d6.44.1718960310213;
        Fri, 21 Jun 2024 01:58:30 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ed7269asm6466596d6.62.2024.06.21.01.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 01:58:30 -0700 (PDT)
Date: Fri, 21 Jun 2024 10:58:26 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Luigi Leonardi <luigi.leonardi@outlook.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	kvm@vger.kernel.org, marco.pinn95@gmail.com, netdev@vger.kernel.org,
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next 2/2] vsock/virtio: avoid enqueue packets when
 work queue is empty
Message-ID: <ZnVAsjkK11cE2fTI@fedora>
References: <jjewa7jiltjnoauat3nnaeezhtcwi6k4xf5mkllykcqw4gyfgi@glwzqxp5r76q>
 <AS2P194MB2170E2A932679C37B87562539ACE2@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS2P194MB2170E2A932679C37B87562539ACE2@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>

On Tue, Jun 18, 2024 at 07:05:54PM +0200, Luigi Leonardi wrote:
> Hi Stefano and Matias,
> 
> @Stefano Thanks for your review(s)! I'll send a V2 by the end of the week.
> 
> @Matias
> 
> Thanks for your feedback!
> 
> > I think It would be interesting to know what exactly the test does
> 
> It's relatively easy: I used fio's pingpong mode. This mode is specifically
> for measuring the latency, the way it works is by sending packets,
> in my case, from the host to the guest. and waiting for the other side
> to send them back. The latency I wrote in the commit is the "completion
> latency". The total throughput on my system is around 16 Gb/sec.
> 

Thanks for the explanation!

> > if the test is triggering the improvement
> 
> Yes! I did some additional testing and I can confirm you that during this
> test, the worker queue is never used!
> 

Cool.

> > If I understand correctly, this patch focuses on the
> > case in which the worker queue is empty
> 
> Correct!
> 
> > I think the test can always send packets at a frequency so the worker queue
> > is always empty. but maybe, this is a corner case and most of the time the
> > worker queue is not empty in a non-testing environment.
> 
> I'm not sure about this, but IMHO this optimization is free, there is no
> penalty for using it, in the worst case the system will work as usual.
> In any case, I'm more than happy to do some additional testing, do you have
> anything in mind?
> 
Sure!, this is very a interesting improvement and I am in favor for
that! I was only thinking out loud ;) I asked previous questions
because, in my mind, I was thinking that this improvement would trigger
only for the first bunch of packets, i.e., when the worker queue is
empty so its effect would be seen "only at the beginning of the
transmission" until the worker-queue begins to fill. If I understand
correctly, the worker-queue starts to fill just after the virtqueue is
full, am I right?


Matias


