Return-Path: <netdev+bounces-98678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A44BC8D20C2
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 17:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F211F231AB
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66215171650;
	Tue, 28 May 2024 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLtapMxT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D161816F274
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716911390; cv=none; b=Kq58GK0jvQYGRaVXkf6uALuIPZFBrrqPE3lmJEHcd7uLXLqYVL+evAbt5D4Oky79vMmhnI10C8lIZL+enz8AUL0hg0SNze2zhkZ0TcmOTDewD6+yBGlGsRR9Rs/XbPjf4l1/mAiuziNvhLGdy8+ms7hrKQK8nlf6bbIvxawizLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716911390; c=relaxed/simple;
	bh=c4hNFaaUxcqmTZpAMo2fGJsEC6Pif7b1WYuVmqit/UI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWwXpLjZ//cF0xL57XUxhdxLOPAtqWOv7jB/drlLsddTXJk+FAd7QhvQd451CFC3NmpUPVbeWJjoXoE9N0F3aOrtr6Fd4JWWjbXXQRdTEtQLYxecgqlW7qDRAZ0ph1RNE8K5bT7h+1MasbPjvfyy4soxMy0PRbsOwg17HljDWCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JLtapMxT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716911387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4hNFaaUxcqmTZpAMo2fGJsEC6Pif7b1WYuVmqit/UI=;
	b=JLtapMxTQqrkDYerqMLrQ/zypPYRFsPoqK1zJlzsNtzpT2nqa5ytdXx2ji7dNj3+qr4/P6
	J7ECDXfgJrVMfxC6QMGmxQYIEdtDhTtWmpch39CcGoDKyBcLi0CUMz3LC08qWMqM80dPH3
	gC9K79JM60qfKBaaEW3q/edqhkcC00U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-Qpdem8onMfy8-0fUiwQuEQ-1; Tue, 28 May 2024 11:49:46 -0400
X-MC-Unique: Qpdem8onMfy8-0fUiwQuEQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-35507e4c41dso1978686f8f.1
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 08:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716911384; x=1717516184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4hNFaaUxcqmTZpAMo2fGJsEC6Pif7b1WYuVmqit/UI=;
        b=ELLBVYvOUcle4VjIJJd+O7KoPkCMu006NY2XPlvzTvs+8xL/D7vLgfWkkTe9QWR2FB
         k2RUmNzU8Ixx2G1wB3+0AZBmze/sd2nH3yYcHzLZSOeFCvjdEelXSKNzxPuNjLQLO12D
         CsMY1WccbQOXpA7ae85j7PEojQ0eFBlBJX6NHNswp2wtTBi7cTq+UV+ux4qMc4VuWUOz
         ZgY2QCx29aeaedZnmtXxlzhDTk7snzz3Pa/LoirzdNVAaEsZkV54dU+NGXsxoMswJOdR
         38HEwXrUIBx8rMne+9DfWJnEV/O8/6jx6NJvOTVGWjJdyh+Tek03OudNqI0BKyvfs/PC
         cAFg==
X-Forwarded-Encrypted: i=1; AJvYcCU1fiwAxDyXYLqnYd4Zd4Y4R/e1Ca/p/Ls3ybBhCaxOQxfZH66S/DTwBy1eYe8ccDsxbzotLaM72W9I2yIDOKVDk5hQ1Ssn
X-Gm-Message-State: AOJu0Yy0RG0hCbbeC2ar90eqYEdDuUHxaed+Y4ihkZWC7VJWy5NQ9X6f
	cP2EBTLPYAAJIdF8zhw82EZ0KQZFCJo3ZF0SfMp9QGJljGBBcXjPsa+MDsO2S7UP5vduhCZ99w9
	vQw6P5EepHtFeDfzD6qQzu4eb0J1HYE4CHl5GgpmesXHJerTMSwIrmWsHX3yJuaPoSwNZNx580Y
	MnT9fCu1Tgtt6Z01eLEb+rBDWwzFnU
X-Received: by 2002:adf:f1ca:0:b0:351:dd2d:f691 with SMTP id ffacd0b85a97d-35506d37f73mr11742414f8f.7.1716911384263;
        Tue, 28 May 2024 08:49:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC6uavvPg89C5v1Y+wUvxKmHotTQ1vuBM058XRtM3p7GiYb/OQ33hLG2GVUL5ot4l7CgfZAW4f3N3gghhlS1E=
X-Received: by 2002:adf:f1ca:0:b0:351:dd2d:f691 with SMTP id
 ffacd0b85a97d-35506d37f73mr11742391f8f.7.1716911383859; Tue, 28 May 2024
 08:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFfO_h7xsn7Gsy7tFZU2UKcg_LCHY3M26iTuSyhFG-k-24h6_g@mail.gmail.com>
 <4i525r6irzjgibqqtrs3qzofqfifws2k3fmzotg37pyurs5wkd@js54ugamyyin>
 <CAFfO_h7iNYc3jrDvnAxTyaGWMxM9YK29DAGYux9s1ve32tuEBw@mail.gmail.com>
 <3a62a9d1-5864-4f00-bcf0-2c64552ee90c@csgraf.de> <6wn6ikteeanqmds2i7ar4wvhgj42pxpo2ejwbzz5t2i5cw3kov@omiadvu6dv6n>
 <5b3b1b08-1dc2-4110-98d4-c3bb5f090437@amazon.com> <554ae947-f06e-4b69-b274-47e8a78ae962@amazon.com>
 <14e68dd8-b2fa-496f-8dfc-a883ad8434f5@redhat.com> <c5wziphzhyoqb2mwzd2rstpotjqr3zky6hrgysohwsum4wvgi7@qmboatooyddd>
In-Reply-To: <c5wziphzhyoqb2mwzd2rstpotjqr3zky6hrgysohwsum4wvgi7@qmboatooyddd>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 28 May 2024 17:49:32 +0200
Message-ID: <CABgObfasyA7U5Fg5r0gGoFAw73nwGJnWBYmG8vqf0hC2E8SPFw@mail.gmail.com>
Subject: Re: How to implement message forwarding from one CID to another in
 vhost driver
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Alexander Graf <agraf@csgraf.de>, 
	Dorjoy Chowdhury <dorjoychy111@gmail.com>, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, netdev@vger.kernel.org, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 5:41=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
> >I think it's either that or implementing virtio-vsock in userspace
> >(https://lore.kernel.org/qemu-devel/30baeb56-64d2-4ea3-8e53-6a5c50999979=
@redhat.com/,
> >search for "To connect host<->guest").
>
> For in this case AF_VSOCK can't be used in the host, right?
> So it's similar to vhost-user-vsock.

Not sure if I understand but in this case QEMU knows which CIDs are
forwarded to the host (either listen on vsock and connect to the host,
or vice versa), so there is no kernel and no VMADDR_FLAG_TO_HOST
involved.

Paolo


