Return-Path: <netdev+bounces-228074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E51EBC0D9F
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 11:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1345F3BDFB8
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 09:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4BB2D73A7;
	Tue,  7 Oct 2025 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoCW7V4b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A573E154BF5
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759829102; cv=none; b=Kk3HWroHNla0IcCG5pr4QwR3HhS6VHh+DGTdOo9BnypLUSX/9eSiwoRT66Mq2uuYIwYlglA2mYIJTA8fqYfxdY5G2V27zpLyVr86pwc7rGECjtQT+e527oxTr6tR5oZpwRC+cnNeDl0oTRsty9inHJTIE3d+HztXFvoubVPhtTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759829102; c=relaxed/simple;
	bh=XUinQ1L61nBOAHFeMuRDRMw/mgz6gA51sfVWDIjlO6Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Exe17WTGwg5YwNBxO8O09OTwKX/nR0obnxALal4N4ZlkPLOFQUr0QPgP+mPtMRt65NAps6YWOh8eJz6N6SsEtWkHvVkudN3aMgv8yEKkhxr9Tcm1q9tq0d1Le6Pgcj88hSnZ22RL+kaZ+Jh4iCU1t7vk46jhj0w5lOGePGJZXDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoCW7V4b; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso5338101a12.1
        for <netdev@vger.kernel.org>; Tue, 07 Oct 2025 02:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759829100; x=1760433900; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LXAk2vNpOi2a4GZEEdq+/3BrMz7MdeYNSazlKM1phvE=;
        b=CoCW7V4bbcDWEbVJ9+RpETuCuHhi+TSnr2qIiLw/LBn+Bg7BoDiVd9iZJRMo5Uf/ba
         wEOPEgtXthfXG8txesqUqrPQJm+oEFseJVJzxt3be6X4bIfZSOjhtUxDH+1S1qvLjVuB
         2JSaJ+cMVjZQda/xCLy2FNAcORrF585mVuJENNxO48BActdNNQmpPpetm1C5cuqz8qUL
         b87T7adscz2aKVyb3Rnsv08Ap+jMnEDuUzOOG8tg/Zt3RQSdQdvG53UDDZrs8OfrKpQ+
         GU1J4zEmJ+dUEMD3etbdg5nj9V1GLSPRUebBv+KMUectS0Ev5tokRUsHIDpxK/2Hiily
         kRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759829100; x=1760433900;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LXAk2vNpOi2a4GZEEdq+/3BrMz7MdeYNSazlKM1phvE=;
        b=r+jv57O8vGKPlXNZAf09mWjZIamrmycbza92XhZvY6WJTj1XyFoH+fjrpvqW+Q7WsI
         FCOmZGJQlnSUCrrC9P56C1JEvVyrcwVhsTtRGGzP6cZGwUE/8oLMTr14IcPpCgavuAWe
         C0KF+8+drd5kB1m1Cd0vONxoRQ7c3oJFCpeg7r5AxkHqCR2cSglkkinHeQgLvQXgfSxp
         14/hDpw93k+SHrc97KoizFQKqwA2AueoIFkZg2QvJ6G3PinA+zCJhF46kl9wwI/iYi2o
         4yje63BONxR6lQJmrk2FclfVJglvDd6KffBhMlGbaiRdAv8U1ArCwlzGp2IkmwhxmpiV
         5DHg==
X-Forwarded-Encrypted: i=1; AJvYcCWO/gS8k/pO95UBEDPkGJ2Gx3k+bxmxHSB2JM/6O9NKbBaSceyN8Uv2SkqIuM2Ha4krqH31lTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcxnZZoH3T5sHcaPhhMHbDlsGpb3K20UHEjwbYsI/cvxFqlv1N
	CNXGfUbuk1CHmDmjOw9WSWLs/ITsVLcVrAKmdn5s5jsRqnRSvZz4TW3H
X-Gm-Gg: ASbGncuGfNnkQIjf0gH+qw6TOsAku7MTwSP1RUUcSkf+hm0CecsSEF8UVuDRnv8pxvI
	drAvgXtjZtT36ZRG6CWvasG0KtsFhmuonA/HJlxc1N11FV+y9/Td7GxhwbtJF244dn7nQoB7wbR
	IFaXdskFu44TQZYUv665xRA9HNVepR1sjF1M6ybuuVgbt50iilSalQkAI5mO/jn+r8HaNGkXJvJ
	ohsuwCwy2q2vzu6sNeGUM4TZ0Stws8EIFzUp9u4N10zqlveGq7iTFR5H8R5nCzMq5CO6EL+azaG
	qwuW4pmisnrGhILe2gF0lCGWlBt/12ilVwiPxxXM2I4Yr4GJ1uS75VAXVaOCa9GMJkeoWtO8a53
	wix58P4x/OLWtcV+92lLGZ0wX3wY/hEn6dLP6puXJgKDUlgE4YvdA4sBlwva4Bovalj2iYn+K4m
	sc
X-Google-Smtp-Source: AGHT+IH8IaODEbFJZ73jU5YNNWrbKeRhGSBDhqmPEMfJXu/w4VpklqvjWqqlypiPmg3Qz+KDVUviRw==
X-Received: by 2002:a17:902:ce01:b0:24c:e6fa:2a38 with SMTP id d9443c01a7336-28e9a606f2amr222264685ad.25.1759829099825;
        Tue, 07 Oct 2025 02:24:59 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28ec57a2dd6sm33737055ad.67.2025.10.07.02.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 02:24:59 -0700 (PDT)
Message-ID: <339cbb66fbcd78d639d0d8463a3a67daf089f40d.camel@gmail.com>
Subject: Re: [PATCH] nvme/tcp: handle tls partially sent records in
 write_space()
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, John Fastabend
 <john.fastabend@gmail.com>,  Jakub Kicinski	 <kuba@kernel.org>, Sabrina
 Dubroca <sd@queasysnail.net>, "David S . Miller"	 <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni	 <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>
Date: Tue, 07 Oct 2025 19:24:53 +1000
In-Reply-To: <0bf649d5-112f-42a8-bc8d-6ef2199ed19d@suse.de>
References: <20251007004634.38716-2-wilfred.opensource@gmail.com>
	 <0bf649d5-112f-42a8-bc8d-6ef2199ed19d@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-07 at 07:19 +0200, Hannes Reinecke wrote:
> On 10/7/25 02:46, Wilfred Mallawa wrote:
> > From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> >=20
>=20
[...]
> I wonder: Do we really need to check for a partially assembled
> record,
> or wouldn't it be easier to call queue->write_space() every time
> here?
> We sure would end up with executing the callback more often, but if
> no
> data is present it shouldn't do any harm.
>=20
> IE just use
>=20
> if (nvme_tcp_queue_tls(queue)
> =C2=A0=C2=A0=C2=A0=C2=A0 queue->write_space(sk);

Hey Hannes,

This was my initial approach, but I figured using
tls_is_partially_sent_record() might be slightly more efficient. But if
we think that's negligible, happy to go with this approach (omitting
the partial record check).

Wilfred

>=20
> > @@ -1306,6 +1313,7 @@ static int nvme_tcp_try_send_ddgst(struct
> > nvme_tcp_request *req)
> > =C2=A0 static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
> > =C2=A0 {
> > =C2=A0=C2=A0	struct nvme_tcp_request *req;
> > +	struct tls_context *ctx =3D tls_get_ctx(queue->sock->sk);
> > =C2=A0=C2=A0	unsigned int noreclaim_flag;
> > =C2=A0=C2=A0	int ret =3D 1;
> > =C2=A0 And we need this why?
>=20
> > diff --git a/include/net/tls.h b/include/net/tls.h
> > index 857340338b69..9c61a2de44bf 100644
> > --- a/include/net/tls.h
> > +++ b/include/net/tls.h
> > @@ -373,6 +373,11 @@ static inline struct tls_context
> > *tls_get_ctx(const struct sock *sk)
> > =C2=A0=C2=A0	return (__force void *)icsk->icsk_ulp_data;
> > =C2=A0 }
> > =C2=A0=20
> > +static inline bool tls_is_partially_sent_record(struct tls_context
> > *ctx)
> > +{
> > +	return !!ctx->partially_sent_record;
> > +}
> > +
> > =C2=A0 static inline struct tls_sw_context_rx *tls_sw_ctx_rx(
> > =C2=A0=C2=A0		const struct tls_context *tls_ctx)
> > =C2=A0 {
> > diff --git a/net/tls/tls.h b/net/tls/tls.h
> > index 2f86baeb71fc..7839a2effe31 100644
> > --- a/net/tls/tls.h
> > +++ b/net/tls/tls.h
> > @@ -271,11 +271,6 @@ int tls_push_partial_record(struct sock *sk,
> > struct tls_context *ctx,
> > =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0 int flags);
> > =C2=A0 void tls_free_partial_record(struct sock *sk, struct tls_context
> > *ctx);
> > =C2=A0=20
> > -static inline bool tls_is_partially_sent_record(struct tls_context
> > *ctx)
> > -{
> > -	return !!ctx->partially_sent_record;
> > -}
> > -
> > =C2=A0 static inline bool tls_is_pending_open_record(struct tls_context
> > *tls_ctx)
> > =C2=A0 {
> > =C2=A0=C2=A0	return tls_ctx->pending_open_record_frags;
> See above. If we were calling ->write_space unconditionally we=20
> wouldn'teven need this export.Cheers,Hannes

