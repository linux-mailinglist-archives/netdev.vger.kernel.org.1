Return-Path: <netdev+bounces-178898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DE3A79763
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 23:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 939477A3950
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 21:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888F11F1936;
	Wed,  2 Apr 2025 21:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HaTzSYPa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863BF42A87
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 21:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743628457; cv=none; b=q8j68CNyzDJJdSvBrl5bc+LPraVMUksx691el62MxCvqIW+PBjcv6+OynIMlhtbHG7JVP0PIGXPZa8WZM0w6DSCF8XUItxxSbybGNzucKmiSep+l8lB+kdxo4kDAW4Xzdlpq7gIjoGxkwYDa6VBxAcR/WT/Isq6JKJngLMXCWWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743628457; c=relaxed/simple;
	bh=yMtg/5bd9WuFFPh1QUVVbVzPyQ8PxgEFM//QPDYEqaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+PTqtf1aOEIgDCqMLDL7CAS/PwBCl1UZ7u7WeXGx2pnMW5C0gJoES7lmEepFWvaLYbyOahs4oBA0h8GQ5w86TBliBOQL0uwhLowK40/rryeh6PCAeGp+twBNS7ggINwjHkcL0q9+Oh9q0Hc7VHbLw0kdLrV9EBMFK2bM0md0Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HaTzSYPa; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2963dc379so31844866b.2
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 14:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743628453; x=1744233253; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6vOkaWbZeGW9ejcyKHqKRgGRaPzQmhuks1cZQp6R9ag=;
        b=HaTzSYPa/qn4SX1R0GofrrDKXtf3B1DrkTE+VBY9lR3DXPU5E/LbPTUGtno7OZPA/T
         FrUe+nZSXnZm/YHNNFTJnRfbpKGD5myrFKghl6mN9VpYCPLAWIxnxKGzr2if5bM9HaVa
         lPNulv3v2ZchfRUnKMVc8a1HNZY1rQ7JrFRLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743628453; x=1744233253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vOkaWbZeGW9ejcyKHqKRgGRaPzQmhuks1cZQp6R9ag=;
        b=d3fcDCnS019HqUnPMxH17MBqc3lxo/NahDCJngQvX6alKGhm8Dq39O3ulJiiKPrcpH
         3pgJrJrO2oQeU/AZpHlqnAGwY4KLtP83Ym3aynKg2tB6+eUQ6Xtn+wH9fwSpTx5Le+LQ
         LCwP7JrwRBjbzeVF7hDgcg9qo1MRqpQv1uS+1KgcTAQavJ8G/YX6KsZPUvkrhNFlj6AA
         RGqAx2Lyhk/555PvpBmOvJlx7OGbgF0Yz3x3cRjbjcaQurr8tQu9Ycgf3UZo/+aDJwnx
         nsQgLQIXga6JDCDdiUn+Pmls/pMr2dK1c7zsY84ednSK0YBS7wIcdsMy2IbTn0mbXFnH
         /rtw==
X-Forwarded-Encrypted: i=1; AJvYcCVEVMrhe3/gqv9CaTUIPPp9Uo/E4YAWShsRBwPeBsvO+VOa7XHQQnLjZ0kYnO1vSSEGWLLgO40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAXjGxh2kXCkrHl8qwcq3P90cKuscKO4ppclE8oqk/rVH1mmHq
	zXINdaY+5w3xAJm2VBlL0vYb4tWk9xJSFtJxMJ0Mh8cW4pB/ClKFEhzsYhVtN43Bm4vlD8z0Qux
	oA3Ae9Q==
X-Gm-Gg: ASbGncvb2HoZE1ybftxmhEs2FacRCMMsnNleAouRBih2OUnhBYZmDhlQRtVgorJ4uwX
	1lY46q4Gu1ZqccB4YzovJ/oaCJKNkQmaV9fE44EvSodS6UHwbFuQSqX7QX4uDxkvDaBq79IX32Q
	KgUwwlp6rGMJytQ7Sw8y6kqq2nl4/uU+bv/X6xQYYgLpPboxDOAX0cWCuw9QtW2lTKm6029Yg5t
	KxC/zSVsWrlA5ZA3EaeUuImyFXfDQjKw54W6OxuntyXVzV3kyXXiep4pTL45S4oJ3L7KumYzuRw
	BbHARODAtdUOtzj+TfxAydzc8d8o3OlXrKIr4CVV5eVBHd8rCJBE4DVNIMOJ6STBfDr5x9lUpGs
	/flCNHfo5p9JCuYbNC1k=
X-Google-Smtp-Source: AGHT+IFEMb5oHzjtrdmRvNakbOKoh16N+byn+5LpcHA3l1XHRtiKeP1AUsYmcY8Bj5sjTEiyOK15gQ==
X-Received: by 2002:a17:906:c10c:b0:ac1:f19a:c0a0 with SMTP id a640c23a62f3a-ac7bc0b29f5mr24053666b.20.1743628452778;
        Wed, 02 Apr 2025 14:14:12 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7192e7d6dsm959052966b.74.2025.04.02.14.14.12
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 14:14:12 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2bfcd2a70so29893866b.0
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 14:14:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYmDaoUNkvcirpN4zo5ATiyk62H6JNm6j/vXr02IClHoIchhllAAeHUjh75vvTtTWUx8bpiAU=@vger.kernel.org
X-Received: by 2002:a17:907:9409:b0:ac7:970b:8ee5 with SMTP id
 a640c23a62f3a-ac7bc126208mr19593966b.27.1743628091735; Wed, 02 Apr 2025
 14:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z-sDc-0qyfPZz9lv@mini-arch> <39515c76-310d-41af-a8b4-a814841449e3@samba.org>
 <407c1a05-24a7-430b-958c-0ca78c467c07@samba.org> <ed2038b1-0331-43d6-ac15-fd7e004ab27e@samba.org>
 <Z+wH1oYOr1dlKeyN@gmail.com> <Z-wKI1rQGSgrsjbl@mini-arch> <0f0f9cfd-77be-4988-8043-0d1bd0d157e7@samba.org>
 <Z-xi7TH83upf-E3q@mini-arch> <4b7ac4e9-6856-4e54-a2ba-15465e9622ac@samba.org>
 <20250402132906.0ceb8985@pumpkin> <Z-1Hgv4ImjWOW8X2@mini-arch> <20250402214638.0b5eed55@pumpkin>
In-Reply-To: <20250402214638.0b5eed55@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Apr 2025 14:07:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7p9bKgZt1E1BWE-NjwSRDBQs=Coviiz0ZTQy9OhHvPg@mail.gmail.com>
X-Gm-Features: AQ5f1JpKVAIlc4pALP5yKNCr8F3ijIqVBIOCCdqoIfNZomenel-ajZbKWJ5EdvE
Message-ID: <CAHk-=wi7p9bKgZt1E1BWE-NjwSRDBQs=Coviiz0ZTQy9OhHvPg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] net/io_uring: pass a kernel pointer via optlen_t
 to proto[_ops].getsockopt()
To: David Laight <david.laight.linux@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Stefan Metzmacher <metze@samba.org>, 
	Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Karsten Keil <isdn@linux-pingi.de>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Neal Cardwell <ncardwell@google.com>, Joerg Reuter <jreuter@yaina.de>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Alexandra Winter <wintera@linux.ibm.com>, 
	Thorsten Winkler <twinkler@linux.ibm.com>, James Chapman <jchapman@katalix.com>, 
	Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Remi Denis-Courmont <courmisch@gmail.com>, Allison Henderson <allison.henderson@oracle.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Jon Maloy <jmaloy@redhat.com>, 
	Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Martin Schiller <ms@dev.tdt.de>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, linux-hams@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
	dccp@vger.kernel.org, linux-wpan@vger.kernel.org, linux-s390@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-afs@lists.infradead.org, tipc-discussion@lists.sourceforge.net, 
	virtualization@lists.linux.dev, linux-x25@vger.kernel.org, 
	bpf@vger.kernel.org, isdn4linux@listserv.isdn4linux.de, 
	io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Apr 2025 at 13:46, David Laight <david.laight.linux@gmail.com> wrote:
>
> The problem is that the generic code has to deal with all the 'wild stuff'.
> It is also common to do non-sequential accesses - so iov_iter doesn't match
> at all.
> There also isn't a requirement for scatter-gather.

Note that the generic code has special cases for the simple stuff,
which is all that the sockopt code would need.

Now, that's _particularly_ true for the "single user address range"
thing, where there's a special ITER_UBUF thing.

We don't actually have a "single kernel range" version of that, but
ITER_KVEC is simple to use, and the sockopt code could say "I only
ever look at the first buffer".

It's ok to just not handle all the cases, and you don't *have* to use
the generic "copy_from_iter()" routines if you don't want to.

In fact, I would expect that something like sockopt generally wouldn't
want to use the normal iter copying routines, since those are
basically all geared towards "copy and update the iter".

           Linus

