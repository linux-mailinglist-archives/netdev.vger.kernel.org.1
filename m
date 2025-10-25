Return-Path: <netdev+bounces-232789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFD8C08E40
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 11:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 211B74E1CFE
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 09:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B482D738F;
	Sat, 25 Oct 2025 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUyzPYDS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E394726E6E6
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761383431; cv=none; b=jm96VDuCIRctRXdgeu/kI/E7aU24ZlTPCk+LKv4UZnuG+Xxjkv2lUVPiOyB9l7hpREOrC/IBYflu3Narw0xLvJYHEYW+AZ2dz2hlq/ZO8bLGw+rm7p4/60WGFU0D66POspqA+IwBcTU+Q+1DqseGDvud6AWmqe+xwrXOu9GpGUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761383431; c=relaxed/simple;
	bh=+dh9ZID6S13botEdBx33Bjjmhjr8VcnrKxwvkT33DLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7yToOJR1/d5y7M+wSCNWcCjA59Pn4eASS7h8/oo8FXiv+9OSwmLPo/q3ujUpGCvHJOYi9Cm3snSnMD9OmCgK43wWmy6xvjad/YtxYf6XMppNqYPCaEOXeObDjAaMjyNzXqmRNLBbCIfvFY9yF9gHVJl+NNInyZs9Fhqsy7NMq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUyzPYDS; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-93e8834d80aso118445439f.1
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 02:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761383429; x=1761988229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fzgs/MggFO7bRdso2leVmefczP9Yg5GRKMMwO23N2o8=;
        b=iUyzPYDS8jptawWTDjRBwbbSb+L/z+3+RIVTRCOsPcslOrS2bKu2oQw4C8KcWm+gYG
         hrbhQxmop/Jukjku6EG2wQugPuHNriCRyiYqHZlBVgMTYPbVV1rtOJUnTijeG2gGGtbj
         BEDLo2Vx2Ps2JBASz0lRUBtiKogien84VLOIHyhWCgrkN4NSLS0nM+EIRPc/5dQizAhB
         /5pXkuioGkI666/4oFFZmgN8XoQrEs+uQPPkNhv/FLSFjVVR1eebYX7ocqREjrubr5p5
         Y3bpwPtG+hHt5/SG7zHmm9N713urWwMzxCFlCMZ3Fwnh60Ws/KUzQebeGBOZS/03Nvt1
         iucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761383429; x=1761988229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fzgs/MggFO7bRdso2leVmefczP9Yg5GRKMMwO23N2o8=;
        b=HJ9vIflkF57Vhuml8+/+7XDFvSFQyYDmA2/ayvOdREytcJ5m5a80fBKMiski5o1L5x
         K5vtILjFl1HgHykk6gp8+cjw4Qm90I/mGeySqMYPQJRa5b81Oav13yM3Dgx94txAF2tn
         Xhe2aDRKEfwWfyDiZMc3voerPfWBxtZslqhKjoa3g5/wA/PWoZ0FhgxNhCJi6slUI5wS
         xXbyrD9S7+wN1IixfcubudkWzkxZ7VhWB4ViSqdqOObSKTcW2FKUqZ1+TvnwfTLbBx+m
         /uM7Wt/Kx5EoDY8DvMyS2wh7M8GVTTyCfOPiAEv3ObfC2eCmrF1ng+rVUUy23Foh2cZr
         AanQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMAR0GbS1HUFu77D/2Qnltfv4Yg8ZUlI3UAQ0D1eU+gakbfbLqzAvzGk5NR7vGIRvnswKkQ7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZlxm8d8/fW2gB5AX4PD4dbXuEp2AZrnms+rg1ePwj89b5kPWL
	hjQjBIKsFce7HywUhPu1hCO9NTOTGK8vKMmFxNI0bnNYu9I6wplLadH3i7ScNCqzLl9ai+2BF9K
	MzHK4iPdLUqywSmFaRj1EKr3Donl3FBE=
X-Gm-Gg: ASbGncs9iuWpfHSvp66e48viZSZUyd+jxJGrhibJCK5Z6Ixw3eCbQrZvxy5FdeYk6NI
	OZkIYdoGQ+r3H8u63IBO4wnvvY5lJvvXBUbYaBrvneNZAdut8aI2XgYySBiDa7Rmk2lFlT4hdZD
	zeth4O0Wp0vsVU0m8Zihl1uIc77Okpu95vy0lQHGkvZJmQyESInY19aQ37d8675emAHA88C39or
	XHU3lhprshY2HUOn0EgiT9wbzS/0KdMR5N3i0nIWwU60PJbA46EjTM71tI=
X-Google-Smtp-Source: AGHT+IGsL0psFClfGN7YpBYlsl7QR+D7+uODL2Xdw5QnAJZf9Y12m2LGYkBe4CSwXs8Ylwl/u9ejOn0rg1jEnFeybuY=
X-Received: by 2002:a92:cdaa:0:b0:42e:72ee:4164 with SMTP id
 e9e14a558f8ab-431ebed7bbdmr58753815ab.23.1761383428986; Sat, 25 Oct 2025
 02:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021131209.41491-1-kerneljasonxing@gmail.com>
 <20251021131209.41491-8-kerneljasonxing@gmail.com> <aPt__0JeH9lW-1yd@horms.kernel.org>
In-Reply-To: <aPt__0JeH9lW-1yd@horms.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 25 Oct 2025 17:09:52 +0800
X-Gm-Features: AWmQ_bluboBvA6zF7nGajp1q5XP5f-rJTlMzH49P0tu6VMvaQBDSoF8Vera7RVE
Message-ID: <CAL+tcoBj7ot1_aWOwet+cK=mj0+G9MahfRM4=U4w-7ycEiD=rA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 7/9] xsk: support batch xmit main logic
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 9:32=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Tue, Oct 21, 2025 at 09:12:07PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > This function __xsk_generic_xmit_batch() is the core function in batche=
s
> > xmit, implement a batch version of __xsk_generic_xmit().
> >
> > The whole logic is divided into sections:
> > 1. check if we have enough available slots in tx ring and completion
> >    ring.
> > 2. read descriptors from tx ring into pool->tx_descs in batches
> > 3. reserve enough slots in completion ring to avoid backpressure
> > 4. allocate and build skbs in batches
> > 5. send all the possible packets in batches at one time
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
>
> Hi Jason,
>
> __xsk_generic_xmit_batch is defined in this patch, but not used
> until the next one. Which results in a transient warning when
> building with W=3D1.
>
> Perhaps it's just as well to squash this patch into the following patch?

Sure, I will do it as long as reviewers will not complain that patch
is too long :P

Thanks,
Jason

