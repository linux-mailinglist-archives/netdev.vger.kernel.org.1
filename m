Return-Path: <netdev+bounces-97015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E338C8BD7
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 19:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B48E02855BA
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 17:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695E813E88E;
	Fri, 17 May 2024 17:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nc6ziw4C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B5713E40B
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 17:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715968151; cv=none; b=UgyiNmD8Y2nKBaLpGXchJVJ4Kai3pn+Wxj+Vse1TVKXN8OYh+8DDXw3EZH/SXsrhRdjRzoQki1q934bcRp6bTSFoh1Pf8mE5ekTXKDqqOAJn5Wvu9Bk4gRW3b6fcDiWAoR2sErlZHaaaY3pyCTN2TlnJfjijce8H79LIEDxmBhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715968151; c=relaxed/simple;
	bh=oedARmZ2xma3ASvFX+03MMuouZUfYCQI5v+von7aVJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=noNFnINfX0qGeebKFlRT2sGpCjkh5e/mgxbI0Mtou+1voKze1JztIvjExa60G5CeI1c9taqlaPeCInEELwfobtB9x5flfeLvbkNZdb5VhyjaBiqdeJvB6joSugQMbMpkrqI5HMPXWDvgA93wozc/QaGhNoAdSoWUDroyYJNDK0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nc6ziw4C; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59b58fe083so408266666b.0
        for <netdev@vger.kernel.org>; Fri, 17 May 2024 10:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715968148; x=1716572948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAECaHhCcwUCbRca57Zh6aOpDr3Abnk6pDVSRq+cI+c=;
        b=Nc6ziw4CYJhNMXzZtHfT34VhxKY9ypBmpwP1P18qXDXiwg99kPQ73Km517JTG61RTa
         DSXe1Hgz7ydQD1Q+Z3oYM1yBCMwhfJbjDiiU2ARx8X0WrE2+0UISnBlxJP+519ecEewI
         K9Nny7DLSL7bSyY6u09MEjtXQnncX9fzvhH2+rhzuTW4HEFe1MAKjWuKLlr5gou9DN2y
         H96YPLKZf2N3LjGCpLZhFWDk8x3SEk72seAu3bkjQPqK8cR3R7wwhkFPkkD1e2fvfqL1
         xKlFtQ+yP3yAJe2SkPnVzB2QFdo8AGNC3e99FT1gqnQuDW/AjjrflwhXLALRBDpXzwPK
         SMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715968148; x=1716572948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAECaHhCcwUCbRca57Zh6aOpDr3Abnk6pDVSRq+cI+c=;
        b=eU8JvoktqqhsJE1qfW9GqgpHY76kfDamkoES/SsoGu3yZqXppBXqdRioSS69t3U9av
         aKr3s8n4pKPqyJGPrA3xZICvyzR8ju4W4EnhIy5EBtPmwYpObmnWkYDXTMuf0qAOVOo7
         JeOURI9eHFKgcKwELy3DRJzuE0LJiE6BAlsnfIrQFMrRGLVZ/kaZylOJA2j92Sw6mMBU
         qfxm3UCsxPrIIGgBwv2hd7oPfiwOXjvtNRDUlYWWoHNLfb1WX2VxjcRuy+1tmHgcXDKS
         CgwKX837SU/DlNMK0cKHr9pUlF0+9sdyQXahbmPqRUvp1rEoEastd81w5mEBpE7LCEbH
         03fg==
X-Forwarded-Encrypted: i=1; AJvYcCX25rO7NvKD8b3u7XCmIuz1rW3ar7aguTgz9rhNT/mOWfaC1iGWAWCBT75PUaqPx+fAs4Bs0yu4TP31QTbS4R877eQ4fibk
X-Gm-Message-State: AOJu0YyaQy5KlLmDHn+7p4f7OLlvZutBwhR3B3+T2/jLAUVgVrezp+xG
	yTiq7s4qyIx+PMJM/x+z6L9VH7gc8dILboz5cLLNG3scBeMbdTxYqMsQx+1dU+iQDTRGXlrqzZy
	HinjuABuKlBnt2lO31qhBIZGwzqQ=
X-Google-Smtp-Source: AGHT+IGJr+8ljv+WfLGa0sVe4f1kBV5JHvduFYnrh7rlCmD3bZp84O44Sifocfjm51y6B6MfY9sybLOX00qfECP+wQE=
X-Received: by 2002:a17:906:ce34:b0:a59:ef75:5382 with SMTP id
 a640c23a62f3a-a5a2d5cb829mr1423576566b.43.1715968147807; Fri, 17 May 2024
 10:49:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517085031.18896-1-kerneljasonxing@gmail.com>
 <CADVnQymvBSUFcc307N_geXgosJgnrx4nziFcpnX-=jU7PronwA@mail.gmail.com> <CAL+tcoDbB2if_=h7XSRU9_i2G=xT+fqmxCU-Mhe438PYcqxj-w@mail.gmail.com>
In-Reply-To: <CAL+tcoDbB2if_=h7XSRU9_i2G=xT+fqmxCU-Mhe438PYcqxj-w@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 18 May 2024 01:48:31 +0800
Message-ID: <CAL+tcoAQSh9ScCduvhKNW9q8A7dhzA3OPuBde6t2=rsxg8=5Jg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] tcp: break the limitation of initial receive window
To: Neal Cardwell <ncardwell@google.com>
Cc: edumazet@google.com, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, davem@davemloft.net, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2024 at 1:41=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Fri, May 17, 2024 at 10:42=E2=80=AFPM Neal Cardwell <ncardwell@google.=
com> wrote:
> >
> > On Fri, May 17, 2024 at 4:50=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Since in 2018 one commit a337531b942b ("tcp: up initial rmem to 128KB=
 and
> > > SYN rwin to around 64KB") limited received window within 65535, most =
CDN
> > > team would not benefit from this change because they cannot have a la=
rge
> > > window to receive a big packet one time especially in long RTT.
> > >
> > > According to RFC 7323, it says:
> > >   "The maximum receive window, and therefore the scale factor, is
> > >    determined by the maximum receive buffer space."
> > >
> > > So we can get rid of this 64k limitation and let the window be tunabl=
e if
> > > the user wants to do it within the control of buffer space. Then many
> > > companies, I believe, can have the same behaviour as old days. Beside=
s,
> > > there are many papers conducting various interesting experiments whic=
h
> > > have something to do with this window and show good outputs in some c=
ases.
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  net/ipv4/tcp_output.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > > index 95caf8aaa8be..95618d0e78e4 100644
> > > --- a/net/ipv4/tcp_output.c
> > > +++ b/net/ipv4/tcp_output.c
> > > @@ -232,7 +232,7 @@ void tcp_select_initial_window(const struct sock =
*sk, int __space, __u32 mss,
> > >         if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_workaround_signed=
_windows))
> > >                 (*rcv_wnd) =3D min(space, MAX_TCP_WINDOW);
> > >         else
> > > -               (*rcv_wnd) =3D min_t(u32, space, U16_MAX);
> > > +               (*rcv_wnd) =3D space;
> >
> > Hmm, has this patch been tested? This doesn't look like it would work.
>
> Hello Neal,
>
> Thanks for the comment.
>
> Sure, I provided such a patch a few months ago which has been tested
> in production for the customers.
>
> One example of using a much bigger initial receive window:
> client   ---window=3D65535---> server
> client   <---window=3D14600----  server
> client   ---window=3D175616---> server
>
> Then the client could send more data than before in fewer rtt.
>
> Above is the output of tcpdump.
>
> Oh, I just found a similar case:
> https://lore.kernel.org/all/20220213040545.365600-1-tilan7663@gmail.com/
>
> Before this, I always believed I'm not the only one who had such an issue=
.
>
> >
> > Please note that RFC 7323 says in
> > https://datatracker.ietf.org/doc/html/rfc7323#section-2.2 :
> >
> >    The window field in a segment where the SYN bit is set (i.e., a <SYN=
>
> >    or <SYN,ACK>) MUST NOT be scaled.
> >
> > Since the receive window field in a SYN is unscaled, that means the
> > TCP wire protocol has no way to convey a receive window in the SYN
> > that is bigger than 64KBytes.
> >
> > That is why this code places a limit of U16_MAX on the value here.
> >
> > If you want to advertise a bigger receive window in the SYN, you'll
>
> No. It's not my original intention.
>
> For SYN packet itself is limited in the __tcp_transmit_skb() as below:
>
>     th->window      =3D htons(min(tp->rcv_wnd, 65535U));

With this limitation/protection of the window in SYN packet, It would
not break RFC with this patch applied. I try to advertise a bigger
initRwnd of ACK in a 3-way shakehand process.

Thanks,
Jason

