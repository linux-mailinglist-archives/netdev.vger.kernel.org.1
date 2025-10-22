Return-Path: <netdev+bounces-231519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC154BF9DC3
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 05:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914363BFF84
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 03:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD20C2D1F7E;
	Wed, 22 Oct 2025 03:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNB9+QYw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67142D1907
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 03:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761104531; cv=none; b=n1sDgAANeFxUjkeukXNpX/8hHZHwZLSVDzqWAMGim5xuxZRMUXMXjvY7Ln9CTlHsbpL+5ZA00hlK0GcbIcH/MzYMwmfRvJAzHm5qf6I4nde+IGwBKdVcXHieNBopIx8lnwEanqmgCXY4r5YdWTOytZxfkkjwEjU2uv64prow/hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761104531; c=relaxed/simple;
	bh=HMZaRHd3QBC0oWYyy9CqpnKYlqU3jX1Jp7DLd0mUWxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJ+riZgFmukxI4SUDBMuRdOiEUCqRx8dI6MR9IrAfZUuI0KTvs4B69EgMaUoqY89y/FFdRoSRUxoGsz5LA0rQAEOMR42xTipj34hw8QVExYuHZFKFndPWhfvwY7ZdxDG7Eerrqxb2d2KwnRh/INlEbPkoqHDIy65APmJHc/fk48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HNB9+QYw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761104527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HMZaRHd3QBC0oWYyy9CqpnKYlqU3jX1Jp7DLd0mUWxo=;
	b=HNB9+QYwU/hlwidmnzylFJwkl3Hbs8qwdnHmEbjOoKJ8jm//jgjEmuZ950FdD0S0EGnrIo
	ikwOO6M2180DUg0r/7k01YNIfO3FKCSKXPyDoDZB+wbusqrGSRPSeoO0ef1Z0mvWXxEEjP
	IGLwYzq4DxYHVb5ukQOeBXLut/+3c9I=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-dzt7DJ-2P0CLvvFTZmALeQ-1; Tue, 21 Oct 2025 23:42:06 -0400
X-MC-Unique: dzt7DJ-2P0CLvvFTZmALeQ-1
X-Mimecast-MFC-AGG-ID: dzt7DJ-2P0CLvvFTZmALeQ_1761104525
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33bcb7796d4so5758312a91.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 20:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761104525; x=1761709325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMZaRHd3QBC0oWYyy9CqpnKYlqU3jX1Jp7DLd0mUWxo=;
        b=j+Sx3rsJv8LKd5GqxVz+h+Y6LHLoinVbF6fnTt6U8jYRv4cFsjDmyTJ23uMrVZGMB3
         +WANj4ntTNfFhe6++53vJYwN9aDWnwu7viaaCY7CCqm4d75VKIlCf/NxMio5LoahA0qr
         9LOKCo6rTX+eE9XkvDO/2wB3YgPJdKZAEXnZJD9AtuE1hjmqCr+IBExLfG/FVWN2I7f2
         EKLR8KyLuPOGEKdy1qEoIL66gM9fX/qe8IVsbWRg4E3YjLffBJ3BY2WUtjUUGI4yopwG
         EfIWkMgzf0G+e4NMH7tjGhQD1pvZqsJM0XMVh/cIqqtD6ka79iWp9+zg2K/YGwfctNeL
         J76w==
X-Forwarded-Encrypted: i=1; AJvYcCX33ImVRG89Vifryl1nQeSoXoAnLtAKXTYNADwtjNdqE3yR8UlJjxHfwrQs3v8sSikhKBsYXK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtaWE4moEqvkEs+evISfZzgNks7E43KXLbRr6EZK7gBEdrwRHK
	TVgoogsEZP41lwHhI1NSrbza3pwIm/B+apan74jtDNG8N1TJWYf3kriCf7jf/kXL4OqnK1m8RKd
	UyPUqsEYjWwGN4IRfNocTdgvkCb/96SYKRIsRx2ABpUhvwo5wnp9PMUoPEwB7ovgL4DdAE1P/2f
	rVo7Cck1X6CZYcmSsuAescCdLLB7fk7Ail
X-Gm-Gg: ASbGnctoHrRAHhzDvSpbgD5CiaDlSwG/E93Gp4I/MnkaqjEK1eIcqDO7ONIzdwz6jrO
	vCNVLGBQFC0zXgRyL6UDo21U2D+jdt4Yreik/De/7JbaXCdk9r5cI3+O2Z32p4yIkpM1EZv85uK
	wiamRS2gcBrsadIPIw1xP9+lGUJs9YcMR+Md3TNUcUqDk2X61ULJf3
X-Received: by 2002:a17:90b:4b:b0:334:cb89:bde6 with SMTP id 98e67ed59e1d1-33bcf8628ebmr27742377a91.4.1761104525161;
        Tue, 21 Oct 2025 20:42:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfFJjBBe9gj2JxeQntVU5I+I/K52WZIsvD7m3axHWRDtjxyFzVKU1vVPQFwjwwB3wSt/W9MIela5+BXvbcA7U=
X-Received: by 2002:a17:90b:4b:b0:334:cb89:bde6 with SMTP id
 98e67ed59e1d1-33bcf8628ebmr27742351a91.4.1761104524805; Tue, 21 Oct 2025
 20:42:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021040155.47707-1-jasowang@redhat.com> <20251021042820-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251021042820-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 Oct 2025 11:41:50 +0800
X-Gm-Features: AS18NWAAJdWZmZZaokLYDDF4FQaIYsA-DM4Fq2y-aLHj75kmJUbkmf7MCRS75P0
Message-ID: <CACGkMEtUjP2UN4s2ZRF8UGV6Bb3-6oPkU50oJ0ek8qfYwxjv1w@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: zero unused hash fields
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pabeni@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 4:28=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Oct 21, 2025 at 12:01:55PM +0800, Jason Wang wrote:
> > When GSO tunnel is negotiated virtio_net_hdr_tnl_from_skb() tries to
> > initialize the tunnel metadata but forget to zero unused rxhash
> > fields. This may leak information to another side. Fixing this by
> > zeroing the unused hash fields.
> >
> > Fixes: a2fb4bc4e2a6a ("net: implement virtio helpers to handle UDP GSO =
tunneling")x

I just spotted this has an unnecessary trailing 'x'. Will post V2.

> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks


