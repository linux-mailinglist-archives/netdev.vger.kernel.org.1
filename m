Return-Path: <netdev+bounces-205472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F7CAFEDF0
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 17:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7DE4E1ABB
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E862E8E1C;
	Wed,  9 Jul 2025 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCrsZ/zO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99B528DB7B
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075721; cv=none; b=F0TCpBU13vk3VW9v9hUQ0eMztN8Hs8BJMs/AWlt4Es0kzZcL7Rogodw8Mk1eMMIuBtZFriaRWDgJ13B7Yskanhak+6C1a8teRM7fHJKtDCoyppqHOoqlbgQAW5AmWGThUla6m3WOlLH5F93/w9na/9QxxCt9IGQvnPL1xDVn/Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075721; c=relaxed/simple;
	bh=XShysqjVfJShNze3cNJCjWk2VTczMmDbx321Os6iHCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2ALSVSu8tfASauoKK6wnzRNA5I5sA4i8q8QSNQF1N5++UrX+A9UKlo2EjFCQBi0fKSApzd0dzfLt9rM7ylBPvtss0DzyB0lDLEfGV3Ckt2rSrFbQda+GPsFb9j4medC2/nQMl6R+LQFUfL+3L7x0dh0fbqrkNmEhbhCQpmHVDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CCrsZ/zO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752075718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XShysqjVfJShNze3cNJCjWk2VTczMmDbx321Os6iHCE=;
	b=CCrsZ/zOcr3ZqJ2oFfe+l2RNjYivD4Ah0CQQR5wtFLNWtlJQEPyDwqjaSa6ifPvOjaT+T5
	it3jWRZTqBwUJTuif4ZxiibF2FxeUg4abZaY/+IwT5kpe+uYGdels2LbZMkceEOclB0CMe
	LXriQanozKrQaVWxUoDbIBpSYR9N100=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-WMg8fF2AMW-x3tSHnrhhUQ-1; Wed, 09 Jul 2025 11:41:56 -0400
X-MC-Unique: WMg8fF2AMW-x3tSHnrhhUQ-1
X-Mimecast-MFC-AGG-ID: WMg8fF2AMW-x3tSHnrhhUQ_1752075716
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-70e4e62caa7so14883177b3.1
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 08:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752075715; x=1752680515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XShysqjVfJShNze3cNJCjWk2VTczMmDbx321Os6iHCE=;
        b=DPoY0FB8DhVwTqVAXgYAyfV5xvJ36F15tpFbPRvWPz3wDSJcPprm9Q5q8xsRgxZXvI
         NU8y4gZSqeB5lIpI439Ci9imhHa/ptnMQYRO8GYY3gHqrFsUkq4F6gNmMPsO6ggFjm08
         xpTJMvjcR0KzwZ4eNYc6qyskHmISTBEwzc+raW+DJimVp4QXmOPkKP4l0GKoSEbe5jcY
         rw6FZYmq0T+eithhHArPkoI7Krtibj4/4EWS8USCbV58BkRofG6v5TQmJBl34NnC+m4z
         c7CH3dJ2gmkvc7kVuVYGmW7cUfXWBN4Eex+osrmd0LwucTNO5QwJOJIZWRhdoetYCvPe
         mTUA==
X-Forwarded-Encrypted: i=1; AJvYcCUn0RBcKv+1b4W/8DVRyd6o2swD5VKlMyMjNcPDtcs/7H7EuLDXMfj2stb+CiVw8OAr89DwrbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAXG4pdgiiRTtYj/BLPld0pE389z84jNAY2pdfO5JC0soL4Cs9
	BYZCEY2+dNpHRsugyroST1fUWpmhEcHNGNVVh+ri7lUGmPLOwqeAHZv21ANn0RiNBJL1SVSBFg4
	W3tXo+4zZ/oMSEe+rVAKAAJDA3TqFNk+hxOQjvDLr8BJboq/BnDxW0atXqrD90BYYAgXeint1ep
	HTMprF8a8hBCpTw+XgLtg6pO8PKnUT5iTH
X-Gm-Gg: ASbGncsm3+D5HwByozSPtOKIzU/sRlhN7b0QP7XKFms8ZrTBzpOdKGosJTJy6dkBZZP
	kMEhCgQC0NYBwbhB0L4aCSz3Bz47G/TEQHNVGn5M9qeX2Im8Q4cVhoLDNNi8I4OtBCi7Uvoe74Y
	2Vnm+h
X-Received: by 2002:a05:690c:6409:b0:713:fe84:6f96 with SMTP id 00721157ae682-717a044be8amr108447547b3.14.1752075715503;
        Wed, 09 Jul 2025 08:41:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExFxKvhbTdzloCbFbyh1tiZpUMkvI+DBzINVmDyNWIx7ol4flKg78d/Go2l26/5A8S/OniJB3RHqWchsMadAI=
X-Received: by 2002:a05:690c:6409:b0:713:fe84:6f96 with SMTP id
 00721157ae682-717a044be8amr108447057b3.14.1752075715039; Wed, 09 Jul 2025
 08:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <472a5d43-4905-4fa4-8750-733bb848410d@linux.ibm.com> <CAGxU2F7bV7feiZs6FmdWkA7v9nxojuDbeSHyWoASS36fr1pSgw@mail.gmail.com>
In-Reply-To: <CAGxU2F7bV7feiZs6FmdWkA7v9nxojuDbeSHyWoASS36fr1pSgw@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 9 Jul 2025 17:41:43 +0200
X-Gm-Features: Ac12FXyROMf2rt0OlirwLyo137Qn7MCpqP2NG-8va_x4r6nW2FeYLXGlppWreyI
Message-ID: <CAGxU2F4GbeCJDYrs8Usd8JJcTrp99gyn3c_zXqpnz+UH2NNBGw@mail.gmail.com>
Subject: Re: [PATCH net-next v4] vsock/test: Add test for null ptr deref when
 transport changes
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: mhal@rbox.co, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, v4bel@theori.io, leonardi@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 17:26, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Wed, 9 Jul 2025 at 16:54, Konstantin Shkolnyy <kshk@linux.ibm.com> wrote:
> >
> > I'm seeing a problem on s390 with the new "SOCK_STREAM transport change
> > null-ptr-deref" test. Here is how it appears to happen:
> >
> > test_stream_transport_change_client() spins for 2s and sends 70K+
> > CONTROL_CONTINUE messages to the "control" socket.
> >
> > test_stream_transport_change_server() spins calling accept() because it
> > keeps receiving CONTROL_CONTINUE.
> >
> > When the client exits, the server has received just under 1K of those
> > 70K CONTROL_CONTINUE, so it calls accept() again but the client has
> > exited, so accept() never returns and the server never exits.

Just to be clear, I was seeing something a bit different.
The accept() in the server is no-blocking, since we set O_NONBLOCK on
the socket, so I see the server looping around a failing accept()
(errno == EAGAIN) while dequeueing the CONTROL_CONTINUE messages, so
after 10/15 seconds the server ends on my case.

It seems strange that in your case it blocks, since it should be a
no-blocking call.

Stefano

> >
>
> Yep, I saw exactly the same issue while testing a new test.
> I already sent a fix:
> https://lore.kernel.org/netdev/20250708111701.129585-1-sgarzare@redhat.com/
>
> Please, send a T-b/R-b on that if you can.
>
> Stefano


