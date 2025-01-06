Return-Path: <netdev+bounces-155625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A21DA032E4
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 23:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F971885E2F
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 22:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBF71E0DC3;
	Mon,  6 Jan 2025 22:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l/FjEgIy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A583F1E04B8
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736203627; cv=none; b=j+r+rsgM6nQJ+31GMWP4ANuZw+tM2Xam+aq3Jkjfa53iMdL3je3g+jd5XiyGDtkC7DYQAMgGIaVJwZqD/gtgpc8HUjFoehnLZ5ZoxyRon+EvY1TwukD8p9rhDaDhYollLUM/AjXfstyW200O02DxUf1pnJuul8BHMY6zb475NW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736203627; c=relaxed/simple;
	bh=4xMwGVLUCCgaQ/8O8Jujn9YPf2A3107E0DPsqCxXbsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lY9vREOF6As+zNZXs3QN1I6raoOHwfzsBMmjxW8l26KcSHdvVC2skKq3CuUaqQ6Z3Z7KPjDEQrgAS2y2R2D2vKMiMGyLuIOry4KuRBiP/9vIQ0nYzNOlSfjIvY7jZLIe8HAPpTmhDhTvkCO/NgflGxYmRkizDpd/PIXZ/nqxINI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l/FjEgIy; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4679b5c66d0so31861cf.1
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 14:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736203622; x=1736808422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xMwGVLUCCgaQ/8O8Jujn9YPf2A3107E0DPsqCxXbsI=;
        b=l/FjEgIyWNJlqBYUlV6MYTphKFhjYiXVfLtvZzGJ3iwo9nEAFig56dxXXZARI1/vHn
         m/+dLN9xh8DrG5tzzefkU6QiC07mbv9CXAN0arGmfzH1OhST1qDVckP8TvFdEnfbZzsX
         0Cj4ru5K+tDg7j4eXP9MONsdVUxe0JZIjJnZcSU6P1fxajcA0SW2vD0rj6QZLIfOE1rs
         QvH7cnmU0t46sy3ee6Sqyz3rg2I4n2NXhRbMIXNJTaMYv6hTHvnTUArPZogMzUVwCoN5
         ULVqY6zOmV/vEHk8bW05NfqnoyQYixJe64lyqdeTO38hnejWMb2nKTIURXtnnqoP5knJ
         5B1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736203622; x=1736808422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xMwGVLUCCgaQ/8O8Jujn9YPf2A3107E0DPsqCxXbsI=;
        b=SjgCSzGC3lIKpVsdItdvbQ2kWyLJ/Tl2j8/W0AzGNSd65dNkc1Vw5AKOM10GV4UHUG
         KSIsjffCg8bMGairfqXyERftJYpjFkGUalty8WMnwNZvrWrdD3ug83NCuGBvfemFtH3D
         KBmxJFhmzaJC0ecWyI9an0cqqkYXU+OS76aVk6yI8NG1A344DgjrA/KZqCgMCJ0jyUyq
         pTjUdgI4n0tkAyj6Eh2WnZmZ/zPiB3W2iyfW9PcqZ/0guOlx+zf8TTVtHYgcXAGcZ3f+
         NY8XdzQcRlP/r6m8eR3L/qkUggJBB7OdiTdh/bV2Xqu1QMyPJJe8oyz4br6KdfVUGE7k
         VEKg==
X-Forwarded-Encrypted: i=1; AJvYcCVuBeULQ/TzkLsI9j+rWt7kbtK9gOCl5wswiTDvSrk31Z6JeucazlDPDP0tU6F3aSDABfAGTkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZQh4z8aj0WAmKDpcGJ+dDaBVEUj97yvEadlTytQGCl5IJQaUW
	+qqZNz75bIDzRszkls4QBhrO9p5YBi11LdC9/LD2pA3jYkt7DGjKxMe8ix3DOD6Hieg+yENr1iV
	IJwjDdrZm934NROgq0F+SsAxvc0syTHCB86Pa
X-Gm-Gg: ASbGncvpkOFsHlFlW06yeegR+0Rkz+9Rscb6Pz8B3yO51DtgD8J4h33MHU5clshRWkL
	fPY1Rre6lJBwX/58JxAWsgupRLgH4G7LB57vpi1BS3Zlch7XVVy033Q92MvGxtX7YC6ZD
X-Google-Smtp-Source: AGHT+IEiZJt//myIdtbS9bCZwMtEKH90oeFzGFtaSVrgVBQbRk91zxkAsuD0V1cwR2OgMNHqd4aPW9zGP/ykZihj+oE=
X-Received: by 2002:a05:622a:180f:b0:466:a22a:6590 with SMTP id
 d75a77b69052e-46b3c814cbdmr266081cf.9.1736203621507; Mon, 06 Jan 2025
 14:47:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218003748.796939-1-dw@davidwei.uk> <20241218003748.796939-12-dw@davidwei.uk>
In-Reply-To: <20241218003748.796939-12-dw@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 6 Jan 2025 14:46:49 -0800
Message-ID: <CAHS8izNCfQjhmywd=UQgFpk2OQZinnWcz8beZTROzJ33XF55rA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 11/20] io_uring/zcrx: add io_zcrx_area
To: David Wei <dw@davidwei.uk>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>, 
	Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 4:38=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> Add io_zcrx_area that represents a region of userspace memory that is
> used for zero copy. During ifq registration, userspace passes in the
> uaddr and len of userspace memory, which is then pinned by the kernel.
> Each net_iov is mapped to one of these pages.
>
> The freelist is a spinlock protected list that keeps track of all the
> net_iovs/pages that aren't used.
>

FWIW we devmem uses genpool to manage the freelist and that lets us do
allocations/free without locks. Not saying you should migrate to that
but it's an option you have available.

--=20
Thanks,
Mina

