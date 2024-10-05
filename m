Return-Path: <netdev+bounces-132411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647CB9918F3
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 19:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25257282156
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 17:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EAF1586F2;
	Sat,  5 Oct 2024 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wg40cB10"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06691547FF
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728150038; cv=none; b=biWLqtofi/EEED6h4rUUSB2tGj4XAEevBH9TmweKW8mwdSpMhBnP0846pvPVwwKRZwZpMVM/eHc5t0ZYZAxp88+0PcY+JSBstkH1xsjOHg2D79KKpp06JMPKZsWhIBK4gv9B4BmxdJ/WvZo0wPp6ST4/TC4mzvRa9cQLOQWtUPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728150038; c=relaxed/simple;
	bh=PGnTBDWbIyTGnMBJuIQhYv7ATyZ4prJcYMmQ7F0iJNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAETkDWAO3M60xMT3TAevFUc8bZTRg6NsHj4jvL/igXRNLUmyrDFM87N3EnO0VijhQu5hT3+8Z1qldIpUBDpeswSn8A7GWufThnM49cJxSqdv85KpdJo92m3yx5mLlYDVIwHRRrL1H8N27jDBJdl26x1ZGnfBcK0zJKkxaLRMj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wg40cB10; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-45b4e638a9aso148631cf.1
        for <netdev@vger.kernel.org>; Sat, 05 Oct 2024 10:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728150035; x=1728754835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48tLhLYG80n5mrSyoUAhafcN25jedGVvVkmtAVmsXB0=;
        b=wg40cB10s7vg2ShpY3V6V6Yk9X+TnPd50t/847QD2lptNvRO+NMGMXjka84r5QspZh
         czPCWIjz+vlsbX66hTUJ95TXHKHQeYKqFJTLyplc+Y9gRDS+63aiMlW9paLYo+BNG4mK
         I/qdf8zA9X1Lrj5dUjPjjjKKy2AHe+BdWrlInu35C0BLqCHlsTg6XIOA9MqgKQlVD/OO
         ckpVC+GmCFvZJX3bhh5J4yT0JW4Dms1WlTrRV0iNe/sFC9Rs+71K4srwv85kBi02Mfu2
         xvfNZE2BlJbL3EmvtXhtQnHHvg8X2P2Uggnu6OxyG04HMP/yc/71GswoadMjTjhIwaNa
         CJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728150035; x=1728754835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48tLhLYG80n5mrSyoUAhafcN25jedGVvVkmtAVmsXB0=;
        b=ox6yJFLvXcu+kAJ37ZRj2M5aPRE+sSwwSgGQuSNat7GHXu8sBvqDYLLYTBsilljvIE
         GQr04jztnDS+DIFv5pmJ5Jx/d3qSkO5agAv01PO9GoJl/SNipPnBLUFBkbLFUtPzzwc8
         PcRNZDuuEk9spxGAOZKsmrgfYHka59hxkhFoF/5TA2i9v1Gla4Eb3l65JHrok+UMeugq
         UQyT7up+1OUexU+KlfyKytFmc1hdv0JWJ9j9E0geGRfizhvU84ErIatF8d4o991Va1J9
         HpSnN31lFCK7oF070IcuMfOt8V2H07NHwhWWAZWSL1hHE3slyJCivtrzu3todJMDyQdH
         ydwA==
X-Forwarded-Encrypted: i=1; AJvYcCV0HD79AOFXjyArYYE8uR6pDavoKjQclgfcG4udIijugt2QhsY9ZBEBb1t6Hz/mDq8Rv/FUjvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaRspw+JHi7KmnCLhdWuM5K5yE0HC8RMfYQpWQyV3eDg1l4Z98
	1V0cABZnUuTsXi9HQukFA0kdaC9jsjIJWH1KMarHU3BbOql4unpN3PlZWMqOQiNxI4lgnu/8hNV
	XL0dy8P4Mz8l/5Am0CKvPCQspRqYXaByARDOg
X-Google-Smtp-Source: AGHT+IGu1s9u+qn6n58wrABZvtmcGprgtxxbss4TNy6cX4jcG8wwYVlcREq/FTVqTXuKNsG68l2SQJCd+Jz9ApAFbyU=
X-Received: by 2002:a05:622a:458d:b0:45c:9c02:2721 with SMTP id
 d75a77b69052e-45da986eb44mr1801131cf.19.1728150035350; Sat, 05 Oct 2024
 10:40:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1728143915-7777-1-git-send-email-guoxin0309@gmail.com>
In-Reply-To: <1728143915-7777-1-git-send-email-guoxin0309@gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sat, 5 Oct 2024 13:40:15 -0400
Message-ID: <CADVnQymUCp1nocPYUCXx1QmN4Y8ABJMd0urJeB5_J=TL8b7_Yg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tcp: remove unnecessary update for
 tp->write_seq in tcp_connect()
To: "xin.guo" <guoxin0309@gmail.com>
Cc: edumazet@google.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 11:58=E2=80=AFAM xin.guo <guoxin0309@gmail.com> wrot=
e:
>
> From: "xin.guo" <guoxin0309@gmail.com>
>
> Commit 783237e8daf13("net-tcp: Fast Open client - sending SYN-data")

To match Linux commit message style, please insert a space between the
SHA1 and the patch title, like so:

Commit 783237e8daf13 ("net-tcp: Fast Open client - sending SYN-data")

> introduces tcp_connect_queue_skb() and it would overwrite tcp->write_seq,
> so it is no need to update tp->write_seq before invoking
> tcp_connect_queue_skb()
>
> Signed-off-by: xin.guo <guoxin0309@gmail.com>
> ---
>  net/ipv4/tcp_output.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 4fd746b..ee8ab9a 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -4134,7 +4134,10 @@ int tcp_connect(struct sock *sk)
>         if (unlikely(!buff))
>                 return -ENOBUFS;
>
> -       tcp_init_nondata_skb(buff, tp->write_seq++, TCPHDR_SYN);
> +       /*SYN eats a sequence byte, write_seq updated by
> +        *tcp_connect_queue_skb().
> +        */
> +       tcp_init_nondata_skb(buff, tp->write_seq, TCPHDR_SYN);
>         tcp_mstamp_refresh(tp);
>         tp->retrans_stamp =3D tcp_time_stamp_ts(tp);
>         tcp_connect_queue_skb(sk, buff);
> --

As in the example provided by Eric, please use Linux kernel C comment
style, which places a space character between the * and the first
character of the comment text on each line. For example:

/* SYN eats a sequence byte, write_seq is updated by
 * tcp_connect_queue_skb().
 */

For more information, see:

https://www.kernel.org/doc/html/v6.11/process/coding-style.html#commenting

thanks,
neal

