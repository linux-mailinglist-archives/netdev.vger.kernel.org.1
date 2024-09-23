Return-Path: <netdev+bounces-129260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E769397E872
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 11:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FE0FB20B7C
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 09:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995C0194A40;
	Mon, 23 Sep 2024 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kDSjEQYZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57EB51C45
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727083201; cv=none; b=mxetL4DixLZmfDvl0osqLFknrRn2NqKbeO62gUKFj5Rp0vZjP3mQvJF5tsl+CUu11EGBjrFTOcfIgaK9aO0hbDOKEARSdBaby995d4GrrFf7jfpVkjTbzFmAdVWSXzAWBp1a2TjsPdc3wxhxjhRgwGBHDyWaoVNUK8DD9y6ZJ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727083201; c=relaxed/simple;
	bh=iPtRYB/LqCytKHM32+OQ8AdBPW3ClXy8CMzRFDtzSLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acHnyJ3cEFAc0eHaSmKXFFlMFDzRhvQkXtz1v+NU00xKwqoLsO4yGsl4E2AEt6URFzxO1DePg7fpvalFGqG6UrQDSqupVCnxDsLCyBZMeAUjess3IH8/tROYsdXJGDR2pqvXgG8WZZY61dSQOH4zJT/JvEcJ1+SESd1qOZhGnlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kDSjEQYZ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c43003a667so5858687a12.3
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 02:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727083198; x=1727687998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50QhRYJxF2LLsaiQzLXYgzKPJK6ZVc0edpL3DG4dqpE=;
        b=kDSjEQYZSdjnjoPSfhqYJNQRaowYwd4OwxXvyaKfOqVuf3D20FZft0S3kUb+blZcyr
         v9vr4Fbn4n/Usb5CbeM9Tlb1kgkue6eOiXFd/HK3ywafnYHuAeDBjbNMJTKS7L2vCFwX
         Vrw4cX1SYkacZc0cnfu1vAIf7i2vGmT4CiDfK836+fNV5eFM6ajg62B6iYhqIfuL8imw
         27AXfOncQBRenLMN2NHaNLl43lSTX+prKmvx2PGQ0itOZpHOBBwBkmTCNhY8h75yypFl
         ajprdRx8oh66EinebbPvnLdTxIAaOcWZGJy8v3tavbYhxBdJEINOeKpB90ZD2RHUM0IZ
         3tTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727083198; x=1727687998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50QhRYJxF2LLsaiQzLXYgzKPJK6ZVc0edpL3DG4dqpE=;
        b=LEvIzVoiJQ/oBdnyctE+jHdhRUCVUKBfdbt93JyURokVdKvNLiBIOlAwjR/RzCESdj
         9sWdW4tO9tyjsvcstiQG1BMKgTxjMXOHhRteNtrH4cmWhNqpizeMbYZqYzbGgrJ7ARnn
         L6CWKMz/v7NNxCu6+tZYtX0tAx4kjRxovAt9DDpOvf+JB/AT5PDD89OQJRm73r5KUH0u
         5uhO3liTDYh0J4gK3ncZNkX0ZlL8YOYCIKrVcm3sFBtcMrU6sga4HfgTMHt3DHVie7bK
         TuJrb2hVQLvG3Lz9Q72AZH8Dgd1c/pZa5I8yJa3ujuyRaABWC8vsCKg7AR7zRrJyjt9v
         tIFQ==
X-Gm-Message-State: AOJu0YxoqCIfjd1X5Dw+R9fKrYcy+CXh2pZL1rvZ4irfe5J6VdCG8U31
	8c73SpATCtPFcmMnk2QU0/PdXyg0j206QfL5jaVfk7UJZqQWOheIf/wezah3n992/DXVuMPCCVm
	cj3/jVe8BsOlXhjLPeSjDLtwyV5kmZUN5sCbVTI9vtcqKVUMAfyCE
X-Google-Smtp-Source: AGHT+IG2qjD29Fnuf5e1NFxZLuXvlLw5kg4gzXu/PNBg2FIN5a3SnyzvI9X8SCH4XeH1eVCY6R89nezYQNBmQbfFlxM=
X-Received: by 2002:a50:8d8c:0:b0:5c2:439e:d6cb with SMTP id
 4fb4d7f45d1cf-5c464a3e204mr7702080a12.12.1727083197837; Mon, 23 Sep 2024
 02:19:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913100941.8565-1-lulie@linux.alibaba.com>
 <CANn89iJuUFaM5whtsqA37vh6vUKUQJhgjV9Uqv6_ARpVGFjB2w@mail.gmail.com> <dd4ff273-2227-4e5a-ba11-2ca79035b811@linux.alibaba.com>
In-Reply-To: <dd4ff273-2227-4e5a-ba11-2ca79035b811@linux.alibaba.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Sep 2024 11:19:44 +0200
Message-ID: <CANn89i+vszCZ9CBJJmatuoF+N9mPhQz8YtNTSdKH8bJRtQdKXw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net/udp: Add 4-tuple hash for connected socket
To: Philo Lu <lulie@linux.alibaba.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	antony.antony@secunet.com, steffen.klassert@secunet.com, 
	linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com, jakub@cloudflare.com, 
	fred.cc@alibaba-inc.com, yubing.qiuyubing@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 10:40=E2=80=AFAM Philo Lu <lulie@linux.alibaba.com>=
 wrote:
>
> Hi Eric, sorry for the late response.
>
> On 2024/9/13 19:49, Eric Dumazet wrote:
> > On Fri, Sep 13, 2024 at 12:09=E2=80=AFPM Philo Lu <lulie@linux.alibaba.=
com> wrote:
> >>
> >> This RFC patch introduces 4-tuple hash for connected udp sockets, to
> >> make udp lookup faster. It is a tentative proposal and any comment is
> >> welcome.
> >>
> >> Currently, the udp_table has two hash table, the port hash and portadd=
r
> >> hash. But for UDP server, all sockets have the same local port and add=
r,
> >> so they are all on the same hash slot within a reuseport group. And th=
e
> >> target sock is selected by scoring.
> >>
> >> In some applications, the UDP server uses connect() for each incoming
> >> client, and then the socket (fd) is used exclusively by the client. In
> >> such scenarios, current scoring method can be ineffcient with a large
> >> number of connections, resulting in high softirq overhead.
> >>
> >> To solve the problem, a 4-tuple hash list is added to udp_table, and i=
s
> >> updated when calling connect(). Then __udp4_lib_lookup() firstly
> >> searches the 4-tuple hash list, and return directly if success. A new
> >> sockopt UDP_HASH4 is added to enable it. So the usage is:
> >> 1. socket()
> >> 2. bind()
> >> 3. setsockopt(UDP_HASH4)
> >> 4. connect()
> >>
> >> AFAICT the patch (if useful) can be further improved by:
> >> (a) Support disable with sockopt UDP_HASH4. Now it cannot be disabled
> >> once turned on until the socket closed.
> >> (b) Better interact with hash2/reuseport. Now hash4 hardly affects oth=
er
> >> mechanisms, but maintaining sockets in both hash4 and hash2 lists seem=
s
> >> unnecessary.
> >> (c) Support early demux and ipv6.
> >>
> >> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> >
> > Adding a 4-tuple hash for UDP has been discussed in the past.
> >
> > Main issue is that this is adding one cache line miss per incoming pack=
et.
> >
>
> Thanks to Dust's idea, we can create a new field for hslot2 (or create a
> new struct for hslot2), indicating whether there are connected sockets
> in this hslot (i.e., local port and local address), and run hash4 lookup
> only when it's true. Then there would be no cache line miss.
>
> The detailed patch is attached below.
>
> > Most heavy duty UDP servers (DNS, QUIC), use non connected sockets,
> > because having one million UDP sockets has huge kernel memory cost,
> > not counting poor cache locality.
>
> Some of our applications do use connected UDP sockets (~10,000 conns),
> and will get significant benefits from hash4. We use connect() to
> separate receiving sockets and listening ones, and then it's easier to
> manage them (just like TCP), especially during live-upgrading, such as
> nginx reload. Besides, I believe hash4 is harmless to those servers
> without connected sockets.
>
> Suggestions are always welcome, and I'll keep improving this patch.
>
> Thanks.
>
> ---
>   include/net/udp.h |  3 +++
>   net/ipv4/udp.c    | 17 ++++++++++++-----
>   2 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/udp.h b/include/net/udp.h
> index a05d79d35fbba..bec04c0e753d0 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -54,11 +54,14 @@ struct udp_skb_cb {
>    *
>    *    @head:  head of list of sockets
>    *    @count: number of sockets in 'head' list
> + *     @hash4_cnt: number of sockets in 'hash4' table of the same (local
> port, local address),
> + *                 Only used by hash2.
>    *    @lock:  spinlock protecting changes to head/count
>    */
>   struct udp_hslot {
>         struct hlist_head       head;
>         int                     count;
> +       u32                     hash4_cnt;
>         spinlock_t              lock;
>   } __attribute__((aligned(2 * sizeof(long))));

This would double the size of this structure (from 16 to 32 bytes)

Perhaps add another 'struct udp_hslot_main' for the relevant hash table,
and keep the smaller 'struct udp_hslot' for the two others.

Current cumulative size of the hash tables is 2 MB.

Alternatively we could move the locks out of the structure, this is
not used in the fast path.

