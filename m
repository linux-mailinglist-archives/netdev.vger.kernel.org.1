Return-Path: <netdev+bounces-141289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 255AD9BA5CD
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 14:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B959B20ADE
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 13:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA4016BE14;
	Sun,  3 Nov 2024 13:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMvyQR+9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1609C6F30C
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730642233; cv=none; b=EbC8MrjwxxpbNC+JRMsIr9UmF9H7azm09ghXpkxys4/7lRvf7/Pb1n3G0wWODNpe7i4Uc7juVrhoMbKWiBznoTF4X56rqxWnTUSGqSxdB5mkFK4bFQJnNd6yPxeUEPSmrmfg3nh3WWGTUmA5UNGARGqQMfMSE6exvPErRC1M3x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730642233; c=relaxed/simple;
	bh=Ke7Mn/axNJ/tQCjZ+ECm7kRH7hV1rMBdxizspW86Yqw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RWYMm6vAMHpfcFJAQ+chgF8xHU9U3r/uVRD2UczCkRfDk+sYWKV4Sz9CxqTmTHprVGMfi+q2xkFdTtiU8wYQeDIZr/1uHWu7uHSt0IxDYy2nbF1EhxgxX2cXwJpNhtoCANbbX1Ghw+LlYdruphijEJnmfpCvCncawYYJ5PKJhmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMvyQR+9; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b155da5b0cso284052785a.2
        for <netdev@vger.kernel.org>; Sun, 03 Nov 2024 05:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730642231; x=1731247031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpIenzEUgJVuXKuGym0zB9/nc9QqPe9oLO7RJf3KVoo=;
        b=YMvyQR+98tiUpOzEru18ogia3M5k5BWAq2CIQcs78evGkgfTqfy4rsLLfLn1zdosHB
         2qTgOELTECpLGNhyk5FkRofkn5rYD6XetHb6Kfh2LLdRo8HSITVVk7VjhXdX+013qUWM
         KHXfO8A5NTum2g2zDJG57Z8dzELjsMZRF4UoXy7WZzJLm+QY6WCCVdAYlZxCzctHD8A1
         MI8OV2mh+GkldmepaYHoJyhlCApN5tsyhay5iZfGSLKfakL3hWg/29yIX4CGaUo6p3Ho
         Dm6eygKQDMINhBgNebl6yujadhqBziPrlmiUcDmtzzN1mf40OM6t/HrH3KacPpsit2Aa
         WG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730642231; x=1731247031;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xpIenzEUgJVuXKuGym0zB9/nc9QqPe9oLO7RJf3KVoo=;
        b=V8S//UrvOjMHuFaLGg5jtpUsmXLMqh4qsCWu5oRxd7zgQ2c7PYn22HLHQtRXNGMT3T
         VaF+iR3RTx43RJMNA3rel861hxFb7wBjKAYks5D1o83hkZ7D7MBxdfQGxOvf6neSGOZh
         ilSFYP5+fKjtwOF0T1Ar35s1f5JiANOjD9iJPcJRQSqCtgnt7GFcGAeKM6HK9NE4I4KH
         QbtijH9P7MG3czNtYcfD20hH8HunhQ1q7Nsh7F//ZTVkW0b73OxZx/jIQ2M4vrAx+YnC
         WWrryoeq9q/vx2/WtJoQjj29C9uTInnAuYkZoZlaAlVO8lKkFum/KR+EwZWI56WxCWrN
         f3Sw==
X-Gm-Message-State: AOJu0YzEdJhxl5sPjBxNoQsp1OeV2Qoi8IXtbrn1Zehfe3Ub9HSqtrU1
	6MjQHRw5THpRBhiVh5HF532wZ2pw5JpLKljG2UAk/NPHg8V9/Byu
X-Google-Smtp-Source: AGHT+IHItMedHkvwdUiKSbTeUh1FXqmnzBE1+bZJl4x1kr/puAJM3fxZpPTT0Oj5UcuBsbEUTlty1A==
X-Received: by 2002:a05:620a:248a:b0:7b1:4cc0:5e1f with SMTP id af79cd13be357-7b1aed6dac1mr2522518085a.7.1730642230814;
        Sun, 03 Nov 2024 05:57:10 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39eb203sm342573985a.14.2024.11.03.05.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 05:57:10 -0800 (PST)
Date: Sun, 03 Nov 2024 08:57:09 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anna Nyiri <annaemesenyiri@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 fejes@inf.elte.hu, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Message-ID: <672781359b9d1_312cad29465@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAKm6_RtYXpa5HnTNe+b1xy9p4BsdD8JnG30F+_ktBYcd2QSyfQ@mail.gmail.com>
References: <20241102125136.5030-1-annaemesenyiri@gmail.com>
 <20241102125136.5030-3-annaemesenyiri@gmail.com>
 <6726d1954a48f_2980c729499@willemb.c.googlers.com.notmuch>
 <CAKm6_RtYXpa5HnTNe+b1xy9p4BsdD8JnG30F+_ktBYcd2QSyfQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] support SO_PRIORITY cmsg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anna Nyiri wrote:
> Willem de Bruijn <willemdebruijn.kernel@gmail.com> ezt =C3=ADrta (id=C5=
=91pont:
> 2024. nov. 3., V, 2:27):
> >
> > Anna Emese Nyiri wrote:
> > > The Linux socket API currently supports setting SO_PRIORITY at the
> > > socket level, which applies a uniform priority to all packets sent
> > > through that socket. The only exception is IP_TOS; if specified as
> > > ancillary data, the packet does not inherit the socket's priority.
> > > Instead, the priority value is computed when handling the ancillary=

> > > data (as implemented in commit <f02db315b8d88>
> >
> > nit: drop the brackets
> >
> > > ("ipv4: IP_TOS and IP_TTL can be specified as ancillary data")). If=

> > > the priority is set via IP_TOS, then skb->priority derives its valu=
e
> > > from the rt_tos2priority function, which calculates the priority
> > > based on the value of ipc->tos obtained from IP_TOS. However, if
> > > IP_TOS is not used and the priority has been set through a control
> > > message, skb->priority will take the value provided by that control=

> > > message.
> >
> > The above describes the new situation? There is no way to set
> > priority to a control message prior to this patch.
> >
> > > Therefore, when both options are available, the primary
> > > source for skb->priority is the value set via IP_TOS.
> > >
> > > Currently, there is no option to set the priority directly from
> > > userspace on a per-packet basis. The following changes allow
> > > SO_PRIORITY to be set through control messages (CMSG), giving
> > > userspace applications more granular control over packet priorities=
.
> > >
> > > This patch enables setting skb->priority using CMSG. If SO_PRIORITY=

> >
> > Duplicate statement. Overall, the explanation can perhaps be
> > condensed and made more clear.
> >
> > > is specified as ancillary data, the packet is sent with the priorit=
y
> > > value set through sockc->priority_cmsg_value, overriding the
> >
> > No longer matches the code.
> >
> > > socket-level values set via the traditional setsockopt() method. Th=
is
> > > is analogous to existing support for SO_MARK (as implemented in com=
mit
> > > <c6af0c227a22> ("ip: support SO_MARK cmsg")).
> > >
> > > Suggested-by: Ferenc Fejes <fejes@inf.elte.hu>
> > > Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> > > ---
> > >  include/net/inet_sock.h | 2 +-
> > >  include/net/ip.h        | 3 ++-
> > >  include/net/sock.h      | 4 +++-
> > >  net/can/raw.c           | 2 +-
> > >  net/core/sock.c         | 8 ++++++++
> > >  net/ipv4/ip_output.c    | 7 +++++--
> > >  net/ipv4/raw.c          | 2 +-
> > >  net/ipv6/ip6_output.c   | 3 ++-
> > >  net/ipv6/raw.c          | 2 +-
> > >  net/packet/af_packet.c  | 2 +-
> > >  10 files changed, 25 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> > > index 56d8bc5593d3..3ccbad881d74 100644
> > > --- a/include/net/inet_sock.h
> > > +++ b/include/net/inet_sock.h
> > > @@ -172,7 +172,7 @@ struct inet_cork {
> > >       u8                      tx_flags;
> > >       __u8                    ttl;
> > >       __s16                   tos;
> > > -     char                    priority;
> > > +     u32                     priority;
> >
> > Let's check with pahole how this affects struct size and holes.
> > It likely adds a hole, but unavoidably so.
> >
> > >       __u16                   gso_size;
> > >       u32                     ts_opt_id;
> > >       u64                     transmit_time;
> > > diff --git a/include/net/ip.h b/include/net/ip.h
> > > index 0e548c1f2a0e..e8f71a191277 100644
> > > --- a/include/net/ip.h
> > > +++ b/include/net/ip.h
> > > @@ -81,7 +81,7 @@ struct ipcm_cookie {
> > >       __u8                    protocol;
> > >       __u8                    ttl;
> > >       __s16                   tos;
> > > -     char                    priority;
> > > +     u32                     priority;
> >
> > No need for a field in ipcm_cookie, when also present in
> > sockcm_cookie. As SO_PRIORITY is not limited to IP, sockcm_cookie is
> > the right location.
> =

> I think there could be a problem if the priority is set by IP_TOS for
> some reason, and then also via cmsg. The latter value may overwrite
> it. In the ip_setup_cork() function, there is therefore a check for
> the value cork->tos !=3D -1 to give priority to the value set by IP_TOS=
.
> And that's why I thought that there should be a priority field in both
> ipcm_cookie and sockcm_cookie. The priority field already existed in
> ipcm_cookie, I didn't add it. I just changed the type.

The existing behavior that adds a branch in the hot path is actually
not needed.

The preferred pattern is that the cookie is initialized with the sk
field, and then optionally overwritten when parsing cmsgs.

The path is slightly complicated by the fact that ipcm_init_sk does
not call sockcm_init, but more or less open codes that.

The callers of ipcm_init_sk are datagram sockets that have more
opportunities to override per-socket options on a per-packet basis.

So I was wrong that the field only has to be initialized in
sockcm_init. It will have to be initialized by both initializers.

But still only a u32 single field is needed.

