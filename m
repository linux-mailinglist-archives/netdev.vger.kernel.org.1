Return-Path: <netdev+bounces-80748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2003F880EA9
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 10:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 948EDB21093
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 09:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FD13A8C1;
	Wed, 20 Mar 2024 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2xZeWhj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CD7171C2
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927229; cv=none; b=cHA9vvlTZYPaQSstKa/CLRQZmvVULb+LIGPpHSN1Anc6oFxnssrk5owTnNzIo9IQ5J1ZWNd+Yl13BlwEN6PjA+WnnVse0XMKJxKu8yVrqhBAZfe7dcPDAgav70mCtPa0WR1rvTZEQvnkqCphAAzRX8MMdqk8Jp2trPG5Ku/vAQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927229; c=relaxed/simple;
	bh=rIvSI2QztdyNfnCwDgEYDf6HC5lzN4Ss9otJr05cGgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dfve/swDtrU0FsAUStlYB8JWdidDjZGi7Rl0Qq3O9C0sNf15PvjY19KCyzV3+y4io7V0bpuewMPDJKfifiAvFcO47HxAUoo4Y63PLTa8TzasnnJziblXmSnOYaqwZBFJaryzigJjmUTJepEtfw0ibg1QRQvu/gOhGCOJDD0u8QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2xZeWhj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710927227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t0kBDUeIU2tU7V7hAw2d2cR8ZW6aMG/rZwr9VASxfRY=;
	b=M2xZeWhj6HWRB15zdZdXYddNB7/tfzWyr1AWRlYfpcFDeTJ5Pzzjfhv0zsu7p1hr0qa2TJ
	+JcCFCdtSSu9jKp86fxicgN+6s+BRUTRmjrV+9NUz1Jj3pC5MmAsMLURWcxcMMODx9AL/w
	SgvwSRD3uHKlCWsF363U/dky7g+sZig=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-E9wxhZ09NrK7C7OP0ImGIQ-1; Wed, 20 Mar 2024 05:33:45 -0400
X-MC-Unique: E9wxhZ09NrK7C7OP0ImGIQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29b8f702cbfso5041667a91.1
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 02:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710927224; x=1711532024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0kBDUeIU2tU7V7hAw2d2cR8ZW6aMG/rZwr9VASxfRY=;
        b=sZsVFFG27zxarMXy2M+Un/+iygChOE52dE8wk1LymjAYEJrzs6Hd/blbEhUxhQeMOd
         9Imcqc9dl6EJsN3lWkvpj4CQMej+VVorfaYXzqDFGxYIw24tNGgZpVz+/GFgfesa2lW8
         3tB6f0p+I5SVPXR5hNWSFxKk2p/0k+7RtSiYd+UU0QTMrrbgpGIU7VUfVYTq90jor1Rb
         +LN5TRlOSdBQ1Ant3GVu6qptDzEvBVH6WNVZ5u9MPRV8vgHheD40dOWK9yXgL5dl42FU
         pZdfAVMHAafryJUNQkjT8q3dGSzfreL//TMnhnUVVjyt1OWmy/WUClVpvcXLQvw9T12C
         Qx1w==
X-Forwarded-Encrypted: i=1; AJvYcCWJ0vpapvZVV67mgWBbrc+Z32meKDpm5mpstMoQRxu9nozbzQZGmPh0KrBM5jXBXhictsUmWy9pxrZVbuVuYKrKu+waeG6q
X-Gm-Message-State: AOJu0YxiGbsbSuTv1Ma/nYWC01JuJC2Z/skbSD/Yr+Z/z7+UoSvF/tiJ
	TXNTzfXSC0CfRLkkEYaRia1mnabR8jg5AoOPUZipDCdqv/TYs92pTlwLqZwO4XzoqVrqgaBx4HX
	odQFdQOjTnhV65jzfMjdnPkFtgQJTUSXcyG4Zgc2ohTW3rB1NNh+Q8o9h3TO6oVzfBbXzuvfl9T
	5ztu6TSURvtbVZrZNIp0OtcJFtEZYr
X-Received: by 2002:a17:90a:8c94:b0:29b:22d2:9dd5 with SMTP id b20-20020a17090a8c9400b0029b22d29dd5mr1349908pjo.38.1710927224739;
        Wed, 20 Mar 2024 02:33:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIZm4NI4PcqMeB2pAm+rJi2GQMkk6TxHsP6dGGnFR/lCMDpHSQWV3a2utJ8oOtHZLuA9Xc8El1pKEXKRCf56I=
X-Received: by 2002:a17:90a:8c94:b0:29b:22d2:9dd5 with SMTP id
 b20-20020a17090a8c9400b0029b22d29dd5mr1349896pjo.38.1710927224416; Wed, 20
 Mar 2024 02:33:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+9S74hbTMxckB=HgRiqL6b8ChZMQfJ6-K9y_GQ0ZDiWkev_vA@mail.gmail.com>
 <20240319131207.GB1096131@fedora> <CA+9S74jMBbgrxaH2Nit50uDQsHES+e+VHnOXkxnq2TrUFtAQRA@mail.gmail.com>
In-Reply-To: <CA+9S74jMBbgrxaH2Nit50uDQsHES+e+VHnOXkxnq2TrUFtAQRA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Mar 2024 17:33:33 +0800
Message-ID: <CACGkMEvX2R+wKcH5V45Yd6CkgGhADVbpvfmWsHducN2zCS=OKw@mail.gmail.com>
Subject: Re: REGRESSION: RIP: 0010:skb_release_data+0xb8/0x1e0 in vhost/tun
To: Igor Raits <igor@gooddata.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	Stefano Garzarella <sgarzare@redhat.com>, Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 9:15=E2=80=AFPM Igor Raits <igor@gooddata.com> wrot=
e:
>
> Hello Stefan,
>
> On Tue, Mar 19, 2024 at 2:12=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
> >
> > On Tue, Mar 19, 2024 at 10:00:08AM +0100, Igor Raits wrote:
> > > Hello,
> > >
> > > We have started to observe kernel crashes on 6.7.y kernels (atm we
> > > have hit the issue 5 times on 6.7.5 and 6.7.10). On 6.6.9 where we
> > > have nodes of cluster it looks stable. Please see stacktrace below. I=
f
> > > you need more information please let me know.
> > >
> > > We do not have a consistent reproducer but when we put some bigger
> > > network load on a VM, the hypervisor's kernel crashes.
> > >
> > > Help is much appreciated! We are happy to test any patches.
> >
> > CCing Michael Tsirkin and Jason Wang for vhost_net.
> >
> > >
> > > [62254.167584] stack segment: 0000 [#1] PREEMPT SMP NOPTI
> > > [62254.173450] CPU: 63 PID: 11939 Comm: vhost-11890 Tainted: G
> > >    E      6.7.10-1.gdc.el9.x86_64 #1
> >
> > Are there any patches in this kernel?
>
> Only one, unrelated to this part. Removal of pr_err("EEVDF scheduling
> fail, picking leftmost\n"); line (reported somewhere few months ago
> and it was suggested workaround until proper solution comes).

Btw, a bisection would help as well.

Thanks


