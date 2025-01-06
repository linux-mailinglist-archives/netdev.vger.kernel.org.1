Return-Path: <netdev+bounces-155583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3989CA0318C
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 21:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A2E37A15E3
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 20:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3530A1DF996;
	Mon,  6 Jan 2025 20:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QxhvQEui"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DCE1D89F8
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 20:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736196347; cv=none; b=lGbwKkB1NRpYZ1H5LSb+uI1mQhXZf1q9RTYcjlUyiKGaDc8Ht9q2qnTLYjC+dkRaQu1Yn9g+fOJ+IgWRwhjJI1rUTJJpCf2EJGeRVCWv+v458qif80/DPOJX7PcONaykJlvXHfzgxTVmKm3Gj/aEdAb3HkeykJ0CqeIhS1eD+ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736196347; c=relaxed/simple;
	bh=FAxg+SkOU83c6OaYj6SB3q3Ukat4X+m/uYn/jmu00wY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDDEaajzSlRJg99/71BK+rWuRHoxOoqNqF2YWSQnMPKcAgX1SawPb1HoBCKXvwEjbqk9+H67AdhP0lgIWEz2pmu8lA2Xg+GFV63BG9dq4bMeHjpd4YBgF4EHyXVt8zmCvoofklFCt8o/YXb7AwuRFfCg9zZlt9ECa+mooHOkt8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QxhvQEui; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-467896541e1so56381cf.0
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 12:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736196343; x=1736801143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAxg+SkOU83c6OaYj6SB3q3Ukat4X+m/uYn/jmu00wY=;
        b=QxhvQEuicN3/bLG2ZyoZvIzfPHyIqSaCZVashhWlwS4lv+i/kZNYTQeXXzLx8Nrj6s
         G6A5GBic0QXdOUb6DcHBhg/ut90yxfVlgd/PJ5CXPbQ5KQibBTG6ZP6VfZ45nQFOYp0x
         bnRR6UWukA/fD4VyDcllCI0uU5TOqF76MnO/vYhm6J36OOrn2Jc//zbigB+cJ09yG3DT
         1RoNZwhqKHpj+4lciFyf5edAgnJk+gUgvCNhbONmjJfkcNDwJzFl9338B4EzqK5Twn0x
         j9nksNPIdxndEds4M/o6s0XHU3kJjwAvaF4kH4vj0ckRvO6z7X8yqFH6cvjYftlv87ky
         J9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736196343; x=1736801143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAxg+SkOU83c6OaYj6SB3q3Ukat4X+m/uYn/jmu00wY=;
        b=cZTacpMVrOJd3GO+wkwUHwpQpQ+/1aeILUnvJJtbYyLd1KYU0wOHgSR6USlJxhziAe
         GkmEr//0jW96sqsNrxVwu4cr2IpNpRjMoBwbFTaramiCFH/EOlSb/0Uky/GXBRY0+Ncd
         Sv59YbqfBrXXbEhQCX6UIxfXoG8t8AgtW7syQYxcPhk3rz0BNHuGi1YhfwVF24fgrE55
         xZW/hNkkyZ9X2ZSbVnssl0NvA/B76b12hxL8OwAsepPPlZg69B8VmGwOIGkdX28BSolj
         Vg/TnqUKhe5SKTUnWNi2JJd29qeAdvtp8YYcLusywL6KX+wv2hCUY2WGbSRG4P+ZI9Qd
         DMiw==
X-Forwarded-Encrypted: i=1; AJvYcCXVeDOWmJtu7p5EiYN8V5LGNXgZ2tOhjgJuwSTT6l04yzd4PFNkSU60ayVC8/fMg2os+GXmciU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKUN1VlDCVEpBhdCOaZpSPUvk4FKQMESyJvYHqAx9YuVIfSMpF
	vzMe3smAjsmcDYeRrWb4sHAgUng03UtZ7u/LajzBXIPjEkzmE3nB2Gh8inuhTV5pufpA7sXzfZR
	CgrkADd0gR0pjdfuaTiln1nOq4VSP0Qz5WonW
X-Gm-Gg: ASbGncvC704q6pNiLNcsOJxI5NsJkO8aodJtV4uvBsc31JC9IiaxCmxAK7nKyVJFIMc
	n9Tp3hNGnK4AgP6smEIaoNA/TmpoVHT7rokWsnUTsWVn5Gt7PgTmUg1b17Da/XAdw+pGl
X-Google-Smtp-Source: AGHT+IGtTpH+G0YJrloWbIQEvhPngqSmxsGSqBlWsCji6r0Gk02n1TRnD4QGY79JM8qFRdYpkknRQBlJ2Lwh/ytKxIg=
X-Received: by 2002:ac8:5a48:0:b0:465:18f3:79cc with SMTP id
 d75a77b69052e-46b3ba239b7mr400181cf.11.1736196343404; Mon, 06 Jan 2025
 12:45:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218003748.796939-1-dw@davidwei.uk> <20241218003748.796939-2-dw@davidwei.uk>
In-Reply-To: <20241218003748.796939-2-dw@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 6 Jan 2025 12:45:31 -0800
Message-ID: <CAHS8izNS0FRj79jjwfxBPam4-vR3gX54xyXxjjGpE5NJzaerpw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 01/20] net: page_pool: don't cast mp param to devmem
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

On Tue, Dec 17, 2024 at 4:37=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> From: Pavel Begunkov <asml.silence@gmail.com>
>
> page_pool_check_memory_provider() is a generic path and shouldn't assume
> anything about the actual type of the memory provider argument. It's
> fine while devmem is the only provider, but cast away the devmem
> specific binding types to avoid confusion.
>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: David Wei <dw@davidwei.uk>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

