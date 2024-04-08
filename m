Return-Path: <netdev+bounces-85824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8471B89C71C
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 16:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62611C20DCA
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 14:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F7B13CF9B;
	Mon,  8 Apr 2024 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="plPb9GIx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723D413CF87
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712586697; cv=none; b=QglFN6oR/kLEU4pVL3RoCHQOFxWcxRdD4/mOolWJhQ72cY+pxM5kxFlRqkJitF4HdryQyf4SnKpin197jS74aK+M8DS5nKvNeOE8faSp1WJkot0L4yPM9SBaih5YHLNzpSCr1WVjLcxtouCKj66azlOd6piBafvmhLfKgXMKfPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712586697; c=relaxed/simple;
	bh=vbe5GQOErf04KBmliWjBSM5ByBwv3XHMu6X6ihkMSbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVHf+ZKpHhU6dmkDMZtHxKPDu8Vret/vEgiICF4scgytm8fcH/Mut+7AI8mtw30Ual6w8SPv7mRnDt8NVhv/bu8jB3PT10kanaBcGo+btg8ZFte3Oc1+mVq07urjHT1KxZ5bAvkhcMaEL8SG/p5yjrgXzpoc0DMhP6dMEd/LzNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=plPb9GIx; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36a0c8c5f18so421115ab.0
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 07:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712586694; x=1713191494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PB9gTCzlXo9WJyRC/H2Bq1YOYuPmzEg9Ug/kUY1UxsE=;
        b=plPb9GIxowhMYel7CyKs8xXp/gTQJDlkYxXDcOQMwgV9ROm14y2PqSsKfKsu76Qldh
         tUsk1H8ZsGo/iu9NP3EIxda2chV1aaNL9vnFgXjBH42RKTA9XdYhkthlcfhBVsmOA8R+
         MVF59fY8d+fFSVLHjbJtPS84A1jgBQbLnCKtc1JOa+MGhyL02O+g9312zgIo04Z98H0N
         0HEH7on/+t2ZvHDg52Wa2+7JeuMzHMTOkdNgoYeZjOofQNhYvXwvZMUMh3mKSkGs/unk
         PcPfxO1hYDeW4Qtwnds+XfKlDMTLapI4RI7JWOXbN78DPnPDm29fawW5c9eFEGonBL6G
         FCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712586694; x=1713191494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PB9gTCzlXo9WJyRC/H2Bq1YOYuPmzEg9Ug/kUY1UxsE=;
        b=m9+Bip4UMopbAAb3rAVhtkNnf3YQb0yIAw6glUCIYPsR6WBb2E4BRSFQd3buk2N0+g
         EVgA6xM0PAxii+bT/9YiXogGH8qftMJc47VltzVg42bXWw9GM/vJru5kftlO1/KIWkpg
         p0GRBKYO0TrngObVGca7Af5DBmYmbbxf+93m7CBXvABDe7hV2m7UyMzhTPRDooMyAKaB
         IU5OMpK3rI8PgNUzmDIS5Hg5I2F9JpBHuURyyIFz+vRErEHdpHOa8rrEHyivP3+8fVJ7
         56hxD24ww8wOL6P0W/E08u5plKsuuthXIbu6bS3NBrx33BNFBqTrZdW2vbcr3XjiaxB3
         bk3A==
X-Gm-Message-State: AOJu0YyQ5ILHPxXLbn7379KUHPaZslbmbgWklne3LowlHm2YBjKX4/Uf
	qlaYVcobFNDqZATovkBHUIs9UkHrV92k1WOU+066KONB0hKCM2d6ejRfc5Yh5621N+xWO+Jc5SN
	IPSFDkBdfG0lrfoN8r0xGpLePmv0VEEml7DSj
X-Google-Smtp-Source: AGHT+IHCH0CMG1diDdOAN2JniFwv3P7ZpjbNavmT1JauFxR1LtdTOONAS6hwBXpzqL9dZ+E1qkUoAeJwy9A5MdYnURs=
X-Received: by 2002:a05:6e02:eef:b0:368:9542:4c56 with SMTP id
 j15-20020a056e020eef00b0036895424c56mr331513ilk.23.1712586694249; Mon, 08 Apr
 2024 07:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0e2077519aafb2a47b6a6f25532bfd43c8b931aa.1712581881.git.asml.silence@gmail.com>
In-Reply-To: <0e2077519aafb2a47b6a6f25532bfd43c8b931aa.1712581881.git.asml.silence@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Apr 2024 16:31:18 +0200
Message-ID: <CANn89iJoZ6P=BPWNwuxGeJ+eTpAc27y=KgEoO==6LKOw7QB9YQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: enable SOCK_NOSPACE for UDP
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	pabeni@redhat.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 4:16=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
>
> wake_up_poll() and variants can be expensive even if they don't actually
> wake anything up as it involves disabling irqs, taking a spinlock and
> walking through the poll list, which is fraught with cache bounces.
> That might happen when someone waits for POLLOUT or even POLLIN as the
> waitqueue is shared, even though we should be able to skip these
> false positive calls when the tx queue is not full.
>
> Add support for SOCK_NOSPACE for UDP sockets. The udp_poll() change is
> straightforward and repeats after tcp_poll() and others. In sock_wfree()
> it's done as an optional feature because it requires support from the
> poll handlers, however there are users of sock_wfree() that might be
> unprepared to that.
>
> Note, it optimises the sock_wfree() path but not sock_def_write_space().
> That's fine because it leads to more false positive wake ups, which is
> tolerable and not performance critical.
>
> It wins +5% to throughput testing with a CPU bound tx only io_uring
> based benchmark and showed 0.5-3% in more realistic workloads.
>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>
> v3: fix a race in udp_poll() (Eric)
>     clear SOCK_NOSPACE in sock_wfree()
>
> v2: implement it in sock_wfree instead of adding a UDP specific
>     free callback.
>
>  include/net/sock.h |  1 +
>  net/core/sock.c    |  9 +++++++++
>  net/ipv4/udp.c     | 15 ++++++++++++++-
>  3 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 2253eefe2848..027a398471c4 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -944,6 +944,7 @@ enum sock_flags {
>         SOCK_XDP, /* XDP is attached */
>         SOCK_TSTAMP_NEW, /* Indicates 64 bit timestamps always */
>         SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet */
> +       SOCK_NOSPACE_SUPPORTED, /* socket supports the SOCK_NOSPACE flag =
*/
>  };
>
>  #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMES=
TAMPING_RX_SOFTWARE))
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 5ed411231fc7..ae7446570726 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3393,6 +3393,15 @@ static void sock_def_write_space_wfree(struct sock=
 *sk)
>
>                 /* rely on refcount_sub from sock_wfree() */
>                 smp_mb__after_atomic();
> +
> +               if (sock_flag(sk, SOCK_NOSPACE_SUPPORTED)) {
> +                       struct socket *sock =3D sk->sk_socket;

It seems sk->sk_socket could be NULL, according to similar helpers
like sk_stream_write_space()

udp_lib_close() -> sk_common_release() -> sock_orphan() ...

