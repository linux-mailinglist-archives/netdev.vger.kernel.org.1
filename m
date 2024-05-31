Return-Path: <netdev+bounces-99826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E432E8D699D
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 21:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E981C25816
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 19:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EEC156F5D;
	Fri, 31 May 2024 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ffxUwYbu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5D717B51D
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 19:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717183019; cv=none; b=Sla9+vwzefppdIwrvNYqpw4T6Uf+CFiNpOGxPLHl8WhndpGvfppCkmF1hItbcmFDrr4+8bhUt5vQ0atdm7ueN2tPgJWSn1zWG2MqG3n9alFSOEH+ZX0rqDA4hq23AcESqW31DbgE6okZ2UPNMrJ0+AlaGmz+2mNs3mEuqmSioSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717183019; c=relaxed/simple;
	bh=2TN1+yUFYmFNZ90rtkyuDL+QOaavawjDVTSZRbDBu1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6YPbkwhwDmhALnv3UvkBGUVlb51Z/LuIOSOokCbctoxMY8fhZPhkkpPlMzVWGUZTIiPPUzbvJtQ+W3JvWLXC2R9eqeiepfLIJWWcmwIcW1+NSEZAjlF2W90k1DBQ3fIc6e8F6HS9X+rBfhi4eUKfQYF3mQNVMVV5H9Hd9ymO1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ffxUwYbu; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso4029a12.0
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 12:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717183016; x=1717787816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TN1+yUFYmFNZ90rtkyuDL+QOaavawjDVTSZRbDBu1E=;
        b=ffxUwYbu6MGJqbjNm6vdyr10PWvkhCwgX+RlIWGJghrzc0SO9gZ98XjXEKKt+lWK+2
         UOWGP9l3ddXbRvF1UYsiSqaS1DNWgQV4N7Z1O9IbHrQCALHHr0fhaYZxe0Jr2w54zNwe
         RWjQZACpPnivOdtvqZf6JU9xPNLunqsPrG2tt5lzaxRWuDk1im6dWfuPoMEkKr9Def3/
         mJU+CxBj80nQyqhlxgGjKt1ofqH6EpSo7ncFs6Ia5genyCfr1drWcopNnI3Cp1z0hy4b
         1WrSx1t/DyYX2j9wzm9EaIodLHSBOK9Mhw6EgbY5ZWtn++IZJRidzXua4o0UChxKuvdM
         u+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717183016; x=1717787816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2TN1+yUFYmFNZ90rtkyuDL+QOaavawjDVTSZRbDBu1E=;
        b=aVd9UJTuJLVelc2Ju57XN9lcp4aKDyRI8KMmnKXGGyykeLI7s4pwnbjPYw1UgJKTYO
         25EdqfA/dt8KfEDYIFPoT9gfwLGKgbtqaRv5HiDwVhM7WmE2w7R6cRyATaH9H3coCGro
         ZtDalXR51M7xQ5cd+kAH88BHa6k/HzK635dL3ZAvS+srZsk0m3xGD3HOMUIzPfWZTyZ6
         9UPwnAER4s6xeCGa/g2rsIZGBqk101tdOjHrVG55u0J5Z5mHXPJgO/RTVrsN7VZ35hBU
         f8pmv7kq+WTNeCD2y1vGOfMONzSUVKF8P5CVZa2/lYJkk9AAVxvdzBPOnjuz4bG3+jLU
         M2cw==
X-Gm-Message-State: AOJu0Yxc4eEwZb39FDKB0isluASfy5uG2ZT9kOO1DLu0dDonCBk3DhfM
	RbOG2RF50B1qWPYSEW+KEiVZMqcku3VFGR4p0puFQnWcSi+rvEAFlHWtqz6Z1gHUoXwiu4fhYyW
	M8N1PY901jV19INP53Tcjdi+r1rnIVysc4oob
X-Google-Smtp-Source: AGHT+IHh/ooU8c2Toxh7cOMgiwd8L54fyK0d/tqwFQvwxmfHQhfUtt+SzgIAVhpsHannXCfVs6nAPGDb+xXyz9YZn4c=
X-Received: by 2002:a05:6402:31f3:b0:576:b1a9:2960 with SMTP id
 4fb4d7f45d1cf-57a46790f45mr19873a12.5.1717183015872; Fri, 31 May 2024
 12:16:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717105215.git.yan@cloudflare.com> <9be3733eee16bb81a7e8e2e57ebcc008f95cae08.1717105215.git.yan@cloudflare.com>
 <CANn89iLo6A__U5HqeA65NuBnrg36jpt9EOUC7T0fLdNEpa6eRQ@mail.gmail.com>
 <CAO3-PboQ68+xFe4Z10L-s-k3NCgciGXNWM00-3wgqbPmGaBB9A@mail.gmail.com>
 <CANn89iJ_rd_vUH1LPbby5vV=s=jWdpzvDKnm6H1YK=wRPWBiyw@mail.gmail.com> <CAO3-PbqaiqWvc1vgHzj2-DEQUPCxTByp4r+zTBWyo-XP4u1G4A@mail.gmail.com>
In-Reply-To: <CAO3-PbqaiqWvc1vgHzj2-DEQUPCxTByp4r+zTBWyo-XP4u1G4A@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 May 2024 21:16:41 +0200
Message-ID: <CANn89iLrKwA7zQW4zMMDtAQy16vJGhX+wzfpFeQgTdyzVWhc8g@mail.gmail.com>
Subject: Re: [RFC net-next 1/6] net: add kfree_skb_for_sk function
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Abhishek Chauhan <quic_abchauha@quicinc.com>, 
	Mina Almasry <almasrymina@google.com>, Florian Westphal <fw@strlen.de>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, David Howells <dhowells@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 9:05=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrote=
:
>

> I don't quite follow it. I think this specific commit using skb->cb is
> unnecessary so I am going to re-work it. As you initially mentioned,
> maybe I should just extend kfree_skb tracepoint. I saw a similar
> change dd1b527831a3("net: add location to trace_consume_skb()"), is it
> something I might follow, or do you specifically mean changes like
> this can annoy stable teams?
>

I do not think trace points arguments are put in stone.

If they were, I would nack the addition of new tracepoints, to prevent
ossification.

