Return-Path: <netdev+bounces-185899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D967AA9C05E
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 10:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47FAD3BB38D
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 08:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4BB22E3E3;
	Fri, 25 Apr 2025 08:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PeaHL4sr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D1517736
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568421; cv=none; b=fN+yuQImCAnSDzzJLfZGyCDcC6GIbkpDs9ZbV324/HPjAUe8kR6uYhlEl+yRHRyMjvRe7kAmSqONxTMVfhkQlDLXiJmjoto1SIqNlxS82eljuqinFVx0Xptx7S7Grg4JEYcrYdbalmXTfbA5ztVXsxTJ/2p5jzkSnwRiovM98F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568421; c=relaxed/simple;
	bh=C0vEA9hITINUFq21qN7+MPFAG54LSqVcGMT6tYWPCMc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d7wu0j17RYuCVD5xSQ8iEQNBHIIdNBqENBdBhaT74H+dVpyNJFGNcN1iVcLYwujdST82xJs97vXGJ+AI25qWUudfXfCXCGx5JGdrklggSuatznvu5t+p1uDOscJVBYYC+43Luy4goN/1Aq9JhFQQ1DgJT+SxKar3yzo7VtG8UgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PeaHL4sr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745568419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C0vEA9hITINUFq21qN7+MPFAG54LSqVcGMT6tYWPCMc=;
	b=PeaHL4srgB26tCavSOBsRp7xB620Ugnc/IGy4BNog3xDzFk2hPbCfpxlDQBVOieiALlzcl
	+I2WcVhgbFIfJ2twlqtKS2a95f1HIkTz2wLN5NkBGjX/G4AASYVQJ6TGHO+ImkVW++vsfT
	UQmlrFYD9ONmgXtSsQs+jVj7wc9iweM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-cisHDwqANDmOiZJsIwrbfg-1; Fri, 25 Apr 2025 04:06:57 -0400
X-MC-Unique: cisHDwqANDmOiZJsIwrbfg-1
X-Mimecast-MFC-AGG-ID: cisHDwqANDmOiZJsIwrbfg_1745568416
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e82ed0f826so2341526a12.0
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 01:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745568416; x=1746173216;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0vEA9hITINUFq21qN7+MPFAG54LSqVcGMT6tYWPCMc=;
        b=HwTewSYz5OEU7nyj47JYKCSkadvCEV1E4FsuJLYP7fvZIpJS+76HY0EIoRkT9AGBjY
         HUEwR4ujvgX2qYqXuB0djdmImgLTQ4QJfemnMbRwCeNTn4RM/MAeKa7jfAolLGW72UTt
         RQm7ta01yKCpDAoFz5+C7gZ8ZcQ56+CPvqQSfpBrT392xYEuZCVOPF4SzNCPdfnNpwPJ
         X5NkppLLoPJ+zYZPinnIeRA+oodjF67YfpC7i9q2W+QrQM0ydPwaXO1AIEKY3NJvlNTa
         yTbg80WO7e6fhFTqI/h50E8LwT6QvrW5fZl99mFJqwIOihPYgIvBrdIXlBngwtaYsSz8
         RcCA==
X-Forwarded-Encrypted: i=1; AJvYcCVDezWQ4E0jo1oXUp5T1nygjLqac7+BmUw2Ei8x2mRXfFI5L0Zjsx3E4ZaEIXf6sf6XxjEXPpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUkrfJYqYpfhIGy5Za3GW9Jnvb970Y4oosfJSbNLhiC5PuW79c
	OwS/nzemVKtbYdfpYZiJPeWwehXcqVN2qr8W2b0pGmg/W9ptcy+DmeVuVTYYKuOyJv5uIEGC4bd
	8Wu2vCaHn7TCN4etX9wgHu5T+fGd+/Y1qa944li4jgSKhZ+3oPL0mGA==
X-Gm-Gg: ASbGncv7H21GuEJYUMim+inxONC+InCJdn4NoZfOWMFgewXx768d2MxgjwKGz92sqzO
	iSTAck3el8WCsUXPqQTfUAKZUZUCTyCvD7sVdANpbayAYGR6ibm95/aWRHZMh7qXlp6PQ57yTeQ
	1eN3OSA5WFcbApU5E+ihIAscJJI1i/xA99tJPwT9udHrjRYbdU3kYmjixCyV0CfHygFFjoHIcOV
	APDt9B6vtje0tKm7KwYcflWdRCsOFBpuPAetDXVNGqhXiHOUqqIXn+dU5q9wXOnpRz4ir0144NK
	wgwQqqcfijV3F0/DfUpdzz0MwiOI5brmDKNn
X-Received: by 2002:a05:6402:34c2:b0:5ec:cd52:27c9 with SMTP id 4fb4d7f45d1cf-5f723a14ffdmr958913a12.31.1745568415840;
        Fri, 25 Apr 2025 01:06:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHICv/JNk8k7fYInMalFni/XTF4Yka/+A4hIJuXaq1ow5LsmSgtSTJXUqpu3AXRwYa4aMT2jA==
X-Received: by 2002:a05:6402:34c2:b0:5ec:cd52:27c9 with SMTP id 4fb4d7f45d1cf-5f723a14ffdmr958886a12.31.1745568415400;
        Fri, 25 Apr 2025 01:06:55 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7038340f5sm879917a12.78.2025.04.25.01.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 01:06:54 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id AD6661A037D9; Fri, 25 Apr 2025 10:06:52 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, Stanislav Fomichev
 <stfomichev@gmail.com>
Cc: Arthur Fabre <arthur@arthurfabre.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, hawk@kernel.org, yan@cloudflare.com,
 jbrandeburg@cloudflare.com, lbiancon@redhat.com, ast@kernel.org,
 kuba@kernel.org, edumazet@google.com, kernel-team@cloudflare.com
Subject: Re: [PATCH RFC bpf-next v2 10/17] bnxt: Propagate trait presence to
 skb
In-Reply-To: <87msc5e68a.fsf@cloudflare.com>
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
 <20250422-afabre-traits-010-rfc2-v2-10-92bcc6b146c9@arthurfabre.com>
 <aAkW--LAm5L2oNNn@mini-arch> <D9EBFOPVB4WH.1MCWD4B4VGXGO@arthurfabre.com>
 <aAl7lz88_8QohyxK@mini-arch> <87tt6d7utp.fsf@toke.dk>
 <aApbI4utFB3riv4i@mini-arch> <87msc5e68a.fsf@cloudflare.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 25 Apr 2025 10:06:52 +0200
Message-ID: <87cyd07jhf.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Sitnicki <jakub@cloudflare.com> writes:

> On Thu, Apr 24, 2025 at 08:39 AM -07, Stanislav Fomichev wrote:
>> On 04/24, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>
> [...]
>
>>> Being able to change the placement (and format) of the data store is the
>>> reason why we should absolutely *not* expose the internal trait storage
>>> to AF_XDP. Once we do that, we effectively make the whole thing UAPI.
>>> The trait get/set API very deliberately does not expose any details
>>> about the underlying storage for exactly this reason :)
>>
>> I was under the impression that we want to eventually expose trait
>> blobs to the userspace via getsockopt (or some other similar means),
>> is it not the case? How is userspace supposed to consume it?
>
> Yes, we definitely want to consume and produce traits from userspace.
>
> Before last Netdev [1], our plan was for the socket glue layer to
> convert between the in-kernel format and a TLV-based stable format for
> uAPI.
>
> But then Alexei suggested something that did not occur to us. The traits
> format can be something that BPF and userspace agree on. The kernel just
> passes it back and forth without needing to understand the content. This
> naturally simplifies changes in the socket glue layer.
>
> As Eric pointed out, this is similar to exposing raw TCP SYN headers via
> getsockopt(TCP_SAVED_SYN). BPF can set a custom TCP option, and
> userspace can consume it.
>
> The trade-off is that then the traits can only be used in parts of the
> network stack where a BPF hook exist.

It also means that we can't change the format later because it becomes
an API consumed by userspace. Regardless of whether we deem it "UAPI"
and not, it is bound to ossify. TCP headers are actually an excellent
example of this; they are ostensibly modifiable, but it's all but
impossible to do so in practice, because implementations make
assumptions on the expected format and break if it changes.

Also, making the format "agreed upon between BPF and userspace", means
that the kernel won't be able to use the data stored in traits itself
(since it does not know the format). We do want fields stored in traits
to be consumable by the kernel as well, so for this reason it is not a
good idea to leave it up to BPF to define the format either.

> Is that an acceptable limitation? That's what we're hoping to hear your
> thoughts on.

I absolutely don't think this is acceptable, see above.

> One concern that comes to mind, since the network stack is unaware of
> traits contents, we will be limited to simple merge strategies (like
> "drop all" or "keep first") in the GRO layer.

Yeah, this is another limitation of the kernel not understanding the
format, but not the only one.

-Toke


