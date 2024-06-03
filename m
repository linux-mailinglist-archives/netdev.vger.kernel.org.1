Return-Path: <netdev+bounces-100270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7328D85B9
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 17:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97ED41C21A6B
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 15:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DC91DA5E;
	Mon,  3 Jun 2024 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C45klLqK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66378391
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717427133; cv=none; b=a+RHeEFiIX6cL3PQ39x2td+K59BEP2yWQJYEtcy3E63GDNO6eTlhrPvE/X7MsSxaV6U392Cs6GalFk5Y/+YMBhWvpqLkkJaTJ+u9HdgIt4oGzD+gp9utX6aems+X/9rboNY6w8TSSBJia7nic2/Ul6MKVLbxgbLghCrySOzyApc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717427133; c=relaxed/simple;
	bh=FxMQkPWYiU3Qctd0yp52JxmWJ77zyZmAQd/lA5vIazg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIphVdftS9rAAhs7ucjfiBa+yyLaEmqBwxVVH+dDwch+oUqYVIbDuh0hChS7GFCHhAAX0b80PBlkRk6MjZjpOZp9Q3a6SN67+IzAoRSgOeiHEx5hlN8f7OXJJ0HNP3RzqcNLIKcpFUAQEzWmeLg5b8dbL9HJp+AhwCHiFllj5SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C45klLqK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a68b41ef3f6so4713866b.1
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 08:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717427131; x=1718031931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KarSyaGJNitul7/bvq/KlC0uYBjYgORXo+gGjOouVw=;
        b=C45klLqKRRm6rFZuvtyEzx2BFRawUNdoKGXaO6EypX53SsanfdUPAGDwTu+xgixIRV
         LFiqgjAyWkUlTo/l37zk8SFPdPhq7T227rsSeEg2f5WQpvfEh3FVO7YqPmCpuTrsLSRp
         KcjyXquNBTKHqAiC2/e25+rkqELiSGtsyc16rzqyS4FycMPTSkI3EzFOZ2PA5Q/nCB9r
         8tb6Nd+TyNd6El/vYpqOj9hTMabhgfNiwcuZnCU9eS6j57IjVaKieUMS1kvwlgbz8wYe
         62P4tH8eORyTpm5zzyqmOdrm/IKJTQ+HFJbIyLCKHaGBVFcBG1E8NhQSOri9nry2HBog
         /xXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717427131; x=1718031931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KarSyaGJNitul7/bvq/KlC0uYBjYgORXo+gGjOouVw=;
        b=MZPu/E5zqD/slZA9+Y/ElN/WFA6SoLX4tbCZJHh5zbujgcfBrLa9BxB7qzpV25mgoy
         vWFnc4HAsO5zmbqOhHD5J42KRXeFQ2RFd1aXIRvHONMlUvGFvQo7NzSeneVIxplIz42Y
         Se3wg8ow014UJjl84XFkDnzaj623OPiG+oAf8v0//78ina2vktBfkdu9W8NJBZ7fq3y8
         UquJf+iQnRk7jW3JNuDMZliJSm6+0me80ltmSW5fknMHsV6dIhXCVXJ2f/DIRFVGp8qR
         lQrAu8pA00J2BVmFeJk1fFU+mFawKPMWVaXDiaUlwfh7DwbVyMoZlp/4nY7H/8BVmK3B
         3i2w==
X-Forwarded-Encrypted: i=1; AJvYcCWcXM0vWMKsIHwF7mwvnyRNKDugJFTOd+233lKXWPLGQKIFv7hzQ0y1o3uV9V07qtEUG4ZIAKYaiYcBFkC7tSG1NKK3prnI
X-Gm-Message-State: AOJu0YzRZFUTY6E9gG+0RqO3VgKnIzf35m4wqk1tIPste3zREJeumrSX
	XSR/6K6TVjrtVN1kX64Yfe/rYm3uwwPrpdZgTKsNRY5ynK0r2iNGnxop8zZ/PBSv7K5yWF9bB4A
	edMauZf8m13yLqhNUQUCnPI9T7QM=
X-Google-Smtp-Source: AGHT+IFnTF0oAFItA5uz6g29Qz/dhqqwFCBQ5Sr13fTuSVNvSnSXA1b/ADsy9a1dv2fanzo4+lDDBBRX8I/kFZBPgcQ=
X-Received: by 2002:a17:906:36cc:b0:a68:b557:76f5 with SMTP id
 a640c23a62f3a-a68b55779c1mr366928266b.69.1717427130508; Mon, 03 Jun 2024
 08:05:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531091753.75930-1-kerneljasonxing@gmail.com>
 <20240531091753.75930-3-kerneljasonxing@gmail.com> <df99fb97-74ca-4b5c-9d5f-86466025a531@kernel.org>
 <CAL+tcoAa+8pEcW5C3jjU4cieHBm8PUWMKUR=hP8sqQbh1gmVug@mail.gmail.com> <80acd903-3cde-4232-8a78-ce20a3e746fa@kernel.org>
In-Reply-To: <80acd903-3cde-4232-8a78-ce20a3e746fa@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 3 Jun 2024 23:04:53 +0800
Message-ID: <CAL+tcoD_JfOMvwGCN=6pNMyBGfUJiVio1RDEuoSQhSjLnPeJxQ@mail.gmail.com>
Subject: Re: [PATCH net v4 2/2] mptcp: count CLOSE-WAIT sockets for MPTCP_MIB_CURRESTAB
To: Matthieu Baerts <matttbe@kernel.org>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, dsahern@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthieu,

On Mon, Jun 3, 2024 at 9:57=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> Hi Jason,
>
> On 03/06/2024 15:26, Jason Xing wrote:
> > Hello Matthieu,
> >
> > On Mon, Jun 3, 2024 at 8:47=E2=80=AFPM Matthieu Baerts <matttbe@kernel.=
org> wrote:
> >>
> >> Hi Jason,
> >>
> >> On 31/05/2024 11:17, Jason Xing wrote:
> >>> From: Jason Xing <kernelxing@tencent.com>
> >>>
> >>> Like previous patch does in TCP, we need to adhere to RFC 1213:
> >>>
> >>>   "tcpCurrEstab OBJECT-TYPE
> >>>    ...
> >>>    The number of TCP connections for which the current state
> >>>    is either ESTABLISHED or CLOSE- WAIT."
> >>>
> >>> So let's consider CLOSE-WAIT sockets.
> >>>
> >>> The logic of counting
> >>> When we increment the counter?
> >>> a) Only if we change the state to ESTABLISHED.
> >>>
> >>> When we decrement the counter?
> >>> a) if the socket leaves ESTABLISHED and will never go into CLOSE-WAIT=
,
> >>> say, on the client side, changing from ESTABLISHED to FIN-WAIT-1.
> >>> b) if the socket leaves CLOSE-WAIT, say, on the server side, changing
> >>> from CLOSE-WAIT to LAST-ACK.
> >>
> >> Thank you for this modification, and for having updated the Fixes tag.
> >>
> >>> Fixes: d9cd27b8cd19 ("mptcp: add CurrEstab MIB counter support")
> >>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> >>> ---
> >>>  net/mptcp/protocol.c | 5 +++--
> >>>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> >>> index 7d44196ec5b6..6d59c1c4baba 100644
> >>> --- a/net/mptcp/protocol.c
> >>> +++ b/net/mptcp/protocol.c
> >>> @@ -2916,9 +2916,10 @@ void mptcp_set_state(struct sock *sk, int stat=
e)
> >>>               if (oldstate !=3D TCP_ESTABLISHED)
> >>>                       MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_CURREST=
AB);
> >>>               break;
> >>> -
> >>> +     case TCP_CLOSE_WAIT:
> >>> +             break;
> >>
> >> The modification is correct: currently, and compared to TCP, the MPTCP
> >> "accepted" socket will not go through the TCP_SYN_RECV state because i=
t
> >> will be created later on.
> >>
> >> Still, I wonder if it would not be clearer to explicitly mention this
> >> here, and (or) in the commit message, to be able to understand why the
> >> logic is different here, compared to TCP. I don't think the SYN_RECV
> >> state will be used in the future with MPTCP sockets, but just in case,
> >> it might help to mention TCP_SYN_RECV state here. Could add a small
> >> comment here above please?
> >
> > Sure, but what comments do you suggest?
> > For example, the comment above the case statement is:
> > "Unlike TCP, MPTCP would not have TCP_SYN_RECV state, so we can skip
> > it directly"
> > ?
> Yes, thank you, it looks good to me. But while at it, you can also add
> the reason:
>
>   case TCP_CLOSE_WAIT:
>           /* Unlike TCP, MPTCP sk would not have the TCP_SYN_RECV state:
>            * MPTCP "accepted" sockets will be created later on. So no
>            * transition from TCP_SYN_RECV to TCP_CLOSE_WAIT.
>            */
>
> WDYT?

So great. Thank you. I will update it soon.

Thanks,
Jason

>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>

