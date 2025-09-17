Return-Path: <netdev+bounces-224216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF6DB8253D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 01:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6CF5813F7
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 23:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C7F29A326;
	Wed, 17 Sep 2025 23:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGgUr0jW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF002877D8
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 23:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758153351; cv=none; b=qlYcjuvb7wzuGa9ONNGECys+Z40Po01I8q4b6tyvvX/PKOvnSCCoQ78lQdN4NW08+1+2ZF1juPgdIj6jIlxUOndtwvKAAzErmnm3aJifQC5UWd1nQI5Is7unLwPQNJw9P7BnWkhXRGHa219BDUFdx9KA8lM4kTDOy142SNyoN70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758153351; c=relaxed/simple;
	bh=s3kx4Yc+B/QQMXBOgQOpaOW3sMuakNxguXeeY6yqNeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxJiWeiJK7CaYIidpqFW8bFESOpl4zKUGdDHWydODrIuClaRGBS2Vl4Ee+3D+eJ2g4lGP+VcfbVGtMA0P+qnb4WKh6W9s9G2TEV3X3iTErpTu1bseubnShR1zHbD3ZOxUg7jh+Mb5fLTXzKKBTU9FrsVawHKLmCSye+C6eRgDhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HGgUr0jW; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-572e153494eso1757e87.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 16:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758153348; x=1758758148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2BqbA+mdt4TSxAifBWwgyG/76v4E1bDgqDxwYgdDNY=;
        b=HGgUr0jWdlWBtEfv/9You9L4DZ8VNxIvnv9mtumi9UpOk9tnnwr2inzAoKbirIP/cR
         2NcRDbEdUqzxEsy5XwxP3+NdtiSWWkdUuItzPOhOVqXYJnZk3mB9u6PyO+IbS3mACy2r
         1cJ87drey8X8DM8gkr5HTXdV8UOfAmBNSbu89USaHr5WVlIL8U3VXGcpm7XBhudwjusb
         6l39C2NkXtQ3YmpKOXTQZL9elWCj7ehRW/eaQNaGNww/50jZ4ivjkLf/hCMArj8q2wd1
         9mvzlSVn6vCXztokFpftcHgFFYk16CIYZPiJtkh2wR8ygqd5zGUDvT87wlGfmagG0taW
         iaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758153348; x=1758758148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2BqbA+mdt4TSxAifBWwgyG/76v4E1bDgqDxwYgdDNY=;
        b=dCZkUlKb5ALh947jh4DZOipm6JPUuZ7vd2vlhpfzohNyUiqF7RviuPWvL3j94xinnt
         Qik+cWho2ktW/C+660qe1Zg+f0Z2q/Inz/uyt25HhKzKDAACCHiRwhGTQvthEeo8g4b1
         VhpQtaQTGJhutDv7hIhFUXpj/YG8Ukn4us/wBifu1WNcLuKtGe8lkq1FSC/BOf93C9EB
         z79D7+yLt6woCoPPkZUJXP8TSNFPilc4X0wxG49LbvxuqkDC/jBt8CFJGc2dOIVjaTV3
         eMw6dZDNVwCGuZzXPZ4qiCCNopHbWAKXAiEzGM8PSUi6t+V5xephBflPXDKW/7XddeXj
         rO5A==
X-Forwarded-Encrypted: i=1; AJvYcCUy/6h6402sKxa5sDZnwR3jerZe2Ht+9zM3ZjpJDwrnrGbm+SxUG66jAMWEZx+krsT5kNrb6Hc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/fuw6aQTfQLQFL6BIiTQlB6f2LvDKXDA4vLATqp3mJPBEn8Jq
	vH3u9gZu3jQGLuisQL/301G85Prc/baCj6zIRhx/XAIIb9Aqz77suvrMqImuJtaFuV67b/6QldV
	5TlDztunZotpSswyimQuUumfT0B3d79qcXdPlqvsM
X-Gm-Gg: ASbGnctMc4MV03foqp3KkAZIIlX3GpFr9rHmLarM290FEJfK9Z+JoDRiJaD6j2bhCMG
	sGMsPsbjjRRvZGIUXuNA9Nv8Z72ie6OoQawVcKerrayR7sa1O9YVdjiEaJletShysMd60BL0izt
	J/itxgPaj3EIV3i0gjx30mbAV/O0sujsqU/SpuwvTslewclyX72Bb5TEvL5NDyHv2LSvIwwaIMo
	+BBlItFmK+2k4VSd5Glp4h59xP/Yswvm4NJ+L1kzCp1pDALTNsV01nq+izidcc=
X-Google-Smtp-Source: AGHT+IGAuAFB/cjvpY7Y4AZju/AFSMn3Ds5rHS2LUoc+dpzjwn1K7OXUpwxzSZfe8tpiqg4YPaRsvQ/ih9HrDwCBidg=
X-Received: by 2002:a05:6512:3ba6:b0:542:6b39:1d57 with SMTP id
 2adb3069b0e04-57778c48d17mr515140e87.3.1758153347419; Wed, 17 Sep 2025
 16:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-0-c80d735bd453@meta.com>
 <20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-2-c80d735bd453@meta.com>
In-Reply-To: <20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-2-c80d735bd453@meta.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 17 Sep 2025 16:55:34 -0700
X-Gm-Features: AS18NWDDuUAXlqLMWoiuJyipblvfnn6oVju_1frRroYSHlxNGTk3xhMxeaVEObI
Message-ID: <CAHS8izPNC65OUr4j1AjWFwRi-kNFobQ=cS4UtwNSVJsZrw19nQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] net: devmem: use niov array for token management
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 10:28=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmai=
l.com> wrote:
>
> From: Bobby Eshleman <bobbyeshleman@meta.com>
>
> Improve CPU performance of devmem token management by using page offsets
> as dmabuf tokens and using them for direct array access lookups instead
> of xarray lookups. Consequently, the xarray can be removed. The result
> is an average 5% reduction in CPU cycles spent by devmem RX user
> threads.
>
> This patch changes the meaning of tokens. Tokens previously referred to
> unique fragments of pages. In this patch tokens instead represent
> references to pages, not fragments.  Because of this, multiple tokens
> may refer to the same page and so have identical value (e.g., two small
> fragments may coexist on the same page). The token and offset pair that
> the user receives uniquely identifies fragments if needed.  This assumes
> that the user is not attempting to sort / uniq the token list using
> tokens alone.
>
> A new restriction is added to the implementation: devmem RX sockets
> cannot switch dmabuf bindings. In practice, this is a symptom of invalid
> configuration as a flow would have to be steered to a different queue or
> device where there is a different binding, which is generally bad for
> TCP flows. This restriction is necessary because the 32-bit dmabuf token
> does not have enough bits to represent both the pages in a large dmabuf
> and also a binding or dmabuf ID. For example, a system with 8 NICs and
> 32 queues requires 8 bits for a binding / queue ID (8 NICs * 32 queues
> =3D=3D 256 queues total =3D=3D 2^8), which leaves only 24 bits for dmabuf=
 pages
> (2^24 * 4096 / (1<<30) =3D=3D 64GB). This is insufficient for the device =
and
> queue numbers on many current systems or systems that may need larger
> GPU dmabufs (as for hard limits, my current H100 has 80GB GPU memory per
> device).
>
> Using kperf[1] with 4 flows and workers, this patch improves receive
> worker CPU util by ~4.9% with slightly better throughput.
>
> Before, mean cpu util for rx workers ~83.6%:
>
> Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal =
 %guest  %gnice   %idle
> Average:       4    2.30    0.00   79.43    0.00    0.65    0.21    0.00 =
   0.00    0.00   17.41
> Average:       5    2.27    0.00   80.40    0.00    0.45    0.21    0.00 =
   0.00    0.00   16.67
> Average:       6    2.28    0.00   80.47    0.00    0.46    0.25    0.00 =
   0.00    0.00   16.54
> Average:       7    2.42    0.00   82.05    0.00    0.46    0.21    0.00 =
   0.00    0.00   14.86
>
> After, mean cpu util % for rx workers ~78.7%:
>
> Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal =
 %guest  %gnice   %idle
> Average:       4    2.61    0.00   73.31    0.00    0.76    0.11    0.00 =
   0.00    0.00   23.20
> Average:       5    2.95    0.00   74.24    0.00    0.66    0.22    0.00 =
   0.00    0.00   21.94
> Average:       6    2.81    0.00   73.38    0.00    0.97    0.11    0.00 =
   0.00    0.00   22.73
> Average:       7    3.05    0.00   78.76    0.00    0.76    0.11    0.00 =
   0.00    0.00   17.32
>
> Mean throughput improves, but falls within a standard deviation (~45GB/s
> for 4 flows on a 50GB/s NIC, one hop).
>
> This patch adds an array of atomics for counting the tokens returned to
> the user for a given page. There is a 4-byte atomic per page in the
> dmabuf per socket. Given a 2GB dmabuf, this array is 2MB.
>

I think this may be an issue. A typical devmem application doing real
work will probably use a dmabuf around this size and will have
thousands of connections. For algorithms like all-to-all I believe
every node needs a number of connections to each other node, and it's
common to see 10K devmem connections while a training is happening or
what not.

Having (2MB * 10K) =3D 20GB extra memory now being required just for
this book-keeping is a bit hard to swallow. Do you know what's the
existing memory footprint of the xarrays? Were they large anyway
(we're not actually adding more memory), or is the 2MB entirely new?

If it's entirely new, I think we may need to resolve that somehow. One
option is implement a resizeable array... IDK if that would be more
efficient, especially since we need to lock it in the
tcp_recvmsg_dmabuf and in the setsockopt.

Another option is to track the userrefs per-binding, not per socket.
If we do that, we can't free user refs the user leaves behind when
they close the socket (or crash). We can only clear refs on dmabuf
unbind. We have to trust the user to do the right thing. I'm finding
it hard to verify that our current userspace is careful about not
leaving refs behind. We'd have to run thorough tests and stuff against
your series.

--
Thanks,
Mina

