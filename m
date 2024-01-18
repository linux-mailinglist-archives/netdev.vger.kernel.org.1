Return-Path: <netdev+bounces-64264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDA2831F3A
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 19:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4186A1C22B2B
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 18:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5090E2DF9E;
	Thu, 18 Jan 2024 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QsbClMbK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7E82DF9C
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705603605; cv=none; b=CIumwM2G3fO4YLXsCahCOGUb8D/eseV8S//zJJi+zl6DqVMt/BNU8rkKXWttH4TNl2baUDG5WGje58G55pwz9v5+R4WUz8cNLsbCbOMtYLjRNYozGr/OfzFRP/U2ThgNmN5L/IqVkBkzsjp7KzfujMkGWFLii6xYfdWGScYXv60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705603605; c=relaxed/simple;
	bh=K8Rv8AEhQKHxHCOIJtSUHXzZVYQKE3MH22eEln86bQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rlQn6AUkAcGcnMjUj5cwHsarB29HUxEKem0iyZSfO+/x42FjtCL3O6IYbAWPy43YPWJgiKmPLm0WNHPTK6XMcSJpBhzwork4UFZ1d32AQmEYs+1esC2Ydr8N/8cc3UMejducbTLP+ePRFaSDmJq1IilJgZohNw0lkWxZ3rP2DtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QsbClMbK; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso1544a12.0
        for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 10:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705603602; x=1706208402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSKXRDwQzNevWt0C+PHqoVzJfwcws22nw1WFmYuLIN8=;
        b=QsbClMbKOERvUEqPzAakEs5uhxe/rtZU4eAj5yfAFcJvPudWGBfiXqwzikcA/LFnlQ
         fkhvjiSZN6I8lquPIz3zuFYWgoAl5Whd/RpwJdvLyo9L1YlFweFM9ZAdWoiF8We99hXu
         gA83A9CIJbYRWRp+GqK9nGTADGq2n2xYsvt7ERLten086pyr0mK3g0AbWzoI6J3yNmh1
         gMpm2KXkQuj5DjuBYUijHfg+GIZ+qXIMDeByYufT36xbE5i14HVpceVt9ZZmH7s2LZgo
         HqoTHAkTatFHM0KMh8X2+WzZ4ZQL7XL6vZkApw3/SRVOvLHCFe0/1BInR5Trb/Fu9SQm
         ovPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705603602; x=1706208402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSKXRDwQzNevWt0C+PHqoVzJfwcws22nw1WFmYuLIN8=;
        b=WhS9PJ+VwXnY2+IDeUFWQioEK57fHieoXMeOTHuVzw4aiFtk6lXV5vMZGb1myYeNmF
         q4sSw0jkwt3EiNLycY60RRFdMTjzjSDL4DgXgEuyIXn6L0gJEjxJwpBUKyx9jaLB9YYi
         x5sY0nRZ8v0d3CN+OrwVRvX5/+I2tCKper6LoJVfgg5jdUwoYb9MR9PAjhLLwTnRd45S
         qvJQMz/rtpVIJYn0HwKaDJVwm3S5CsO2V7g7XnJ6joGQHKmJxA7WV7EG05mV+vDi/61J
         3QRqPhB1CO1nymqAVVfRWv5hwoshP3lanKzLTWKITaakpMyzoZtpqYw08tsH+o00Lb6a
         jj+g==
X-Gm-Message-State: AOJu0YyLpfVT0FTwtuCLLaryB6lUgVXx7b3A7sxvbJ0rKhiLuuYxT7Od
	W4OFHsakQvAeK5YA/HyOYX4CgsO5tFls7ycItzYJqhSPhoA4qFBiql7/58OqOoeNbIHLKLQJJFH
	vpcieCa5+CeEp9xmxb5uyU18CX96HQMme8Vbg
X-Google-Smtp-Source: AGHT+IGmrHniWK7G+YMmLwYW5/uLeXln3Ze8oK7CEFQHzK4eVBWBroCAfxCGzJxO6w+hjuXjvjlWCp9Q/yfSHNDO/vs=
X-Received: by 2002:a05:6402:d55:b0:55a:4e60:e9a3 with SMTP id
 ec21-20020a0564020d5500b0055a4e60e9a3mr6624edb.4.1705603601717; Thu, 18 Jan
 2024 10:46:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118182835.4004788-1-edumazet@google.com> <65a9713b2376e_1d399c294ab@willemb.c.googlers.com.notmuch>
In-Reply-To: <65a9713b2376e_1d399c294ab@willemb.c.googlers.com.notmuch>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Jan 2024 19:46:27 +0100
Message-ID: <CANn89iJWp25E0ej5M4_9WhZtGqzOkKeXQ8-cWTAE02EzTR9ydw@mail.gmail.com>
Subject: Re: [PATCH v2 net] udp: fix busy polling
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 7:43=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>

>
> Perhaps simpler without a variable?
>
>     if (!skb_queue_empty_lockless(&sk->sk_receive_queue))
>             return true;
>
>     if (sk_is_udp(sk) &&
>         !skb_queue_empty_lockless(&udp_sk(sk)->reader_queue))
>             return true;
>
>     return sk_busy_loop_timeout(sk, start_time);

Of course, for some reason my brain was stuck with the negations ;)

I will send a v3 later.

