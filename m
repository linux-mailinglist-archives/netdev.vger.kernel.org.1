Return-Path: <netdev+bounces-167533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBD3A3AB5E
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 22:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEC867A3ECF
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 21:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484FE1D63EF;
	Tue, 18 Feb 2025 21:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CsrLK/3i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92B61D63C2
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 21:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739915515; cv=none; b=ovOYFE+NHOz0dyvAX+90xFpBZDHJMbCZng0SwSUvgwd7Npd9S1tNSrj1kUeWIdd+lRQXsaezqhwQWlDIiQ/HtFlWSly+Ha2IwOlikY2MFv41n+qDprZKsS71EbVutqYvJ2jFGlkKrZP7qiX9SCPK1VkuCvNX1DIvtfoKoL+OnIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739915515; c=relaxed/simple;
	bh=3CDUJavJ/w2Eyz6VWoYc/R+F8v/kR/eR9xKGteJ8Cfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oURj53IcJJlenD36+7HAQCXf1mA7euy6s5cKnDjcxAElIacucarNBbzDJ3/Snbe2fK/sNBHRR/pKv2RQZQiGA/ZTBduvv6UVD+owJyIzZLj67JnZ9Ktc3zIaxHWFoaL3mV1eeTTLrQ7Loy90kHhfOf09rYQEIiVz+2YqHsuDUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CsrLK/3i; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2212222d4cdso392425ad.0
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 13:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739915513; x=1740520313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UGIfcSBO6nPRNgzLOD4hhxNfN7xC9ou+BofcFQJ5rE=;
        b=CsrLK/3iEhGFvuDmuuJ1A4BIaZYF8IJ0OFgGNcqhstuojxzCZ7v6tsLxI1M6/WblhB
         GEZe5LBoTaltiKhQWnzskvWBha79hQt2bNsOMY1IuWb+obRjOkOZ11gTxHv6afjQz2pj
         NhzglQGrnAbF6tei+07+LJmp2ZaP91WVXL2HmyGXNrtCbdFLaN3iszPmKjsuHTAkqX1g
         uc1epeMQaylvUdPF1BO673GSx9CR107m6jGjxovPg4mOgAzhPXTvkB2u/1Y6/p8itgLq
         cSRjNk5l7lrd/QctFqQaH28SkJMquosLCobc58WaKdvuw4jEh+Yx9pCmkJru2E738wiI
         KC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739915513; x=1740520313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UGIfcSBO6nPRNgzLOD4hhxNfN7xC9ou+BofcFQJ5rE=;
        b=lFIbHWCXnyKf9kwlLvhNUs+Sh5BqOaGBiDt0jRuFptEC1qgBmdnwgK+L1DnJ2N/tBw
         nQwRRcKo3CfZbcyUADKh1CLyX36zmZIaNPHXyroITsW8LDyaQE6LCHK+QQCXv/qm6ugR
         YowkmakWCwWN+fjF2/sKBrVBSB8P7qgxYMupFANYR6aWjyMYIE/AdcWPq8H6qHRFtfxC
         gqaIozQUb7Tz1aqkVNwcOWCLFMaL+Q4IFmkYykHVMbn3EYiMpDnnf4R2BgI3seViHiNG
         aJ29Kany5l2ETr6bOiajl9cVIv8aiwclmQ+KGBegJTAj1xiggoOdV9iCu23g8suhqkUL
         MoUA==
X-Forwarded-Encrypted: i=1; AJvYcCW511y5Ld0fBc92yz29l2cw1XfI0gFcC3AuxDmRUBS2wgP9c14C94jztGzay+UkumrlBRsqNtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU5mek76cM6snF5pHtF0zmil8ct4JGIxYATmcfYkVZNxOguaSm
	i3oPwA7EKrAIT5ZmL3QPkVFIh+qZ93JWQFuAJoSuGpcFtw+pkeGiw2j40FCbEN/jWYDVtbUG1yp
	Fexk+H9GJ0pwQGYc4TdZntQbzE7BMsLlAWijT
X-Gm-Gg: ASbGncs4gWG9+p7vmgIc72ZuOslMGvzmhA+In8pnA+eCNogonMuRotfoFmC9074MVAa
	MmSg0B1qwknr5JPbaoq3XgHuS0k3nltdJU8Fo/A3Wjlr+NvkZsqtbOEKBJsUul2+/IFGMbiMz9x
	z/l+8mQ4zGXrm0Um2mrcx1iSjv7Ik=
X-Google-Smtp-Source: AGHT+IFxN+I6Pcm4D/MWcGGzuqiVfnA3lm6uCP2yMFXY/srLZuNcuFLVdARwU8ZoZScSvTimcKvb5jsOUISnTbTNl60=
X-Received: by 2002:a17:902:ec84:b0:21f:2ded:bfc5 with SMTP id
 d9443c01a7336-2217429ec2cmr646285ad.28.1739915512661; Tue, 18 Feb 2025
 13:51:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218194056.380647-1-sdf@fomichev.me> <CAHS8izP7fGd+6jvT7q1dRxfmRGbVSQwhwW=pFMpc21YtGqQm4A@mail.gmail.com>
 <Z7T48iNrBvnc8TZq@mini-arch>
In-Reply-To: <Z7T48iNrBvnc8TZq@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 18 Feb 2025 13:51:40 -0800
X-Gm-Features: AWEUYZmi1pNM_ix_ad_TMYM6qsRS6rUyvQfajg5wC41TxsXXmNmKoHWvga_pJgo
Message-ID: <CAHS8izOu33xLNQUJZgKq971f+rfzqaj0f5CG8sQ7U3pKth_QBA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: devmem: properly export MSG_CTRUNC to userspace
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, ncardwell@google.com, kuniyu@amazon.com, 
	dsahern@kernel.org, horms@kernel.org, willemb@google.com, kaiyuanz@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 1:17=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 02/18, Mina Almasry wrote:
> > On Tue, Feb 18, 2025 at 11:40=E2=80=AFAM Stanislav Fomichev <sdf@fomich=
ev.me> wrote:
> > >
> > > Currently, we report -ETOOSMALL (err) only on the first iteration
> > > (!sent). When we get put_cmsg error after a bunch of successful
> > > put_cmsg calls, we don't signal the error at all. This might be
> > > confusing on the userspace side which will see truncated CMSGs
> > > but no MSG_CTRUNC signal.
> > >
> > > Consider the following case:
> > > - sizeof(struct cmsghdr) =3D 16
> > > - sizeof(struct dmabuf_cmsg) =3D 24
> > > - total cmsg size (CMSG_LEN) =3D 40 (16+24)
> > >
> > > When calling recvmsg with msg_controllen=3D60, the userspace
> > > will receive two(!) dmabuf_cmsg(s), the first one will
> >
> > The intended API in this scenario is that the user will receive *one*
> > dmabuf_cmgs. The kernel will consider that data in that frag to be
> > delivered to userspace, and subsequent recvmsg() calls will not
> > re-deliver that data. The next recvmsg() call will deliver the data
> > that we failed to put_cmsg() in the current call.
> >
> > If you receive two dmabuf_cmsgs in this scenario, that is indeed a
> > bug. Exposing CMSG_CTRUNC could be a good fix. It may indicate to the
> > user "ignore the last cmsg we put, because it got truncated, and
> > you'll receive the full cmsg on the next recvmsg call". We do need to
> > update the docs for this I think.
> >
> > However, I think a much much better fix is to modify put_cmsg() so
> > that we only get one dmabuf_cmsgs in this scenario, if possible. We
> > could add a strict flag to put_cmsg(). If (strict =3D=3D true &&
> > msg->controlllen < cmlen), we return an error instead of putting a
> > truncated cmsg, so that the user only sees one dmabuf_cmsg in this
> > scenario.
> >
> > Is this doable?
>
> Instead of modifying put_cmsg(), I can have an extra check before
> calling it to make sure the full entry fits. Something like:
>

Yes, that sounds perfect. I would add a new helper, maybe
put_dmabuf_cmsg, that checks that we have enough space before calling
the generic put_cmsg().

> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2498,6 +2498,11 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, con=
st struct sk_buff *skb,
>                                 offset +=3D copy;
>                                 remaining_len -=3D copy;
>
> +                               if (msg.msg_controllen < CMSG_LEN(sizeof(=
dmabuf_cmsg))) {
> +                                       err =3D -ETOOSMALL;
> +                                       goto out;
> +                               }
> +
>                                 err =3D put_cmsg(msg, SOL_SOCKET,
>                                                SO_DEVMEM_DMABUF,
>                                                sizeof(dmabuf_cmsg),
>
> WDYT? I'll still probably remove '~MSG_CTRUNC' parts as well to avoid
> confusion.

Yes, since we check there is enough space before calling put_cmsg(),
it should now become impossible for put_cmsg() to set MSG_CTRUNC
anyway, so the check in tcp_recvmsg_dmabuf() becomes an unnecessary
defensive check that should be removed.

Thanks for catching this!

--=20
Thanks,
Mina

