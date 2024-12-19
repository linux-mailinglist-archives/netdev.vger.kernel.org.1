Return-Path: <netdev+bounces-153489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D3A9F8399
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 19:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DF39188C30E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 18:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AF31A0AFE;
	Thu, 19 Dec 2024 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="ulqvp+ih"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A121A08A3
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734634680; cv=none; b=LeE91GS2bCrSbR5jsTk9ABG/OmDyubR88xJyeFIVu1jxkIKlTX6JIiWeGy2pmJZ51e04goiqUXD4BI8b/rtg4WdPp8kqNPe4fMk5z5NepMfTOSW8SMawgUst+0Se2ioBuw+SIISKhjewYdFiKwjE4ozpXgNYaqJCZ7WfypngKHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734634680; c=relaxed/simple;
	bh=Cu3spGZCQ72U+XRFdeGMW8VB9ztzslTSWk1iur4BCzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZtf2Fk3tg5x0A5i+nTb7HID8OGXgi3X2WJDEjw/97h1fzMjZ7L8v6gDlUub+Oe9kq8iN8nzjOKmzLX/6CVJaocrahvX1FrRlOFsQERT0sER5YiX40tsjtU1FS//Syolehj6ySby6epNafPyDw1lj+AgWZ0KpBtjhSwBAEth13w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=ulqvp+ih; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AzGEIu0zFE7WiR6/nCXO042kOHUfhZAtU19UEHR7SOc=; t=1734634679; x=1735498679; 
	b=ulqvp+ihX3PbEyaR7xyOosw/9Sj2kGu3p1PAVHYB3TBJ770+SaOqD5Qpymxhfit4cWlDlL8jp4F
	4kfeE72JRRK8FlLsFXCyogp9PxrCg8z/u805CbZqw7I8Osa9YDb+Nr77vGU33d+frzv4tTtJ8dsHN
	vHCc9vZcEcYOpzHEw6HDoK6N0xgGGMU29D9v8aM8KCjFPguFhZX7M+9pB3HN4rMpVhjw4Wn1jgK37
	EuxcCxekSVl90Pj/0h8hJl9fKVKuG5Vp6YbFuNsRwSkhAcVacXpWJjhFV2tNWz455Q/MWlZLm5S19
	KT+R3vUuyuH+z/6sUrAQ+CwV/3qGh8KE2VWA==;
Received: from mail-oa1-f54.google.com ([209.85.160.54]:44261)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tOLif-0000Lm-Nl
	for netdev@vger.kernel.org; Thu, 19 Dec 2024 10:57:58 -0800
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2a0206590a7so555957fac.0
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 10:57:57 -0800 (PST)
X-Gm-Message-State: AOJu0YyHpEHTAxUSG9US9fP57jjVEUHZICmUEzJbOrzqH6qCA06VbKKH
	swB+hdgZq04Tskmm5hfubvZ6BVQShqwPdQDw4tdwb5wEdbDAu2YdhpDM9r2EZe5ZwaND1J8pHhv
	hCGpXAXwA4q0lpJVWw4hhrJFdtXY=
X-Google-Smtp-Source: AGHT+IEi+hIA9HF6RCU7p9TNdp46If0xHVi8W6C1qG2NEbTUhzJDX6SGwmoXmSTP7UJkKyCV1h/Y3vjGXq8l4OS511Q=
X-Received: by 2002:a05:6870:7d85:b0:29e:5522:8eea with SMTP id
 586e51a60fabf-2a7fb553df2mr19908fac.38.1734634677127; Thu, 19 Dec 2024
 10:57:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217000626.2958-1-ouster@cs.stanford.edu> <20241217000626.2958-2-ouster@cs.stanford.edu>
 <20241218174345.453907db@kernel.org>
In-Reply-To: <20241218174345.453907db@kernel.org>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Thu, 19 Dec 2024 10:57:22 -0800
X-Gmail-Original-Message-ID: <CAGXJAmyGqMC=RC-X7T9U4DZ89K=VMpLc0=9MVX6ohs5doViZjg@mail.gmail.com>
Message-ID: <CAGXJAmyGqMC=RC-X7T9U4DZ89K=VMpLc0=9MVX6ohs5doViZjg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 01/12] inet: homa: define user-visible API for Homa
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: ae8206b624f71ff41c2281f68712021f

On Wed, Dec 18, 2024 at 5:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 16 Dec 2024 16:06:14 -0800 John Ousterhout wrote:
> > +#ifdef __cplusplus
> > +extern "C"
> > +{
> > +#endif
>
> I'm not aware of any networking header wrapped in extern "C"
> Let's not make this precedent?

Without this I don't seem to be able to use this header in C++ files:
I end up getting linker errors such as 'undefined reference to
`homa_replyv(int, iovec const*, int, sockaddr const*, unsigned int,
unsigned long)'.

Any suggestions on how to make the header file work with C++ files
without the #ifdef __cplusplus?

> > +/**
> > + * define HOMA_MIN_DEFAULT_PORT - The 16-bit port space is divided int=
o
> > + * two nonoverlapping regions. Ports 1-32767 are reserved exclusively
> > + * for well-defined server ports. The remaining ports are used for cli=
ent
> > + * ports; these are allocated automatically by Homa. Port 0 is reserve=
d.
> > + */
> > +#define HOMA_MIN_DEFAULT_PORT 0x8000
>
> Not sure why but ./scripts/kernel-doc does not like this:
>
> include/uapi/linux/homa.h:51: warning: expecting prototype for HOMA_MIN_D=
EFAULT_PORT - The 16(). Prototype was for HOMA_MIN_DEFAULT_PORT() instead

I saw this warning from kernel-doc before I posted the patch, but I
couldn't figure out why it is happening. After staring at the error
message some more I figured it out: kernel-doc is getting confused by
the "-" in "16-bit" (it seems to use the last "-" on the line rather
than the first). I've modified the comment to replace "16-bit" with
"16 bit" and filed a bug report for kernel-doc.

> > +/**
> > + * struct homa_sendmsg_args - Provides information needed by Homa's
> > + * sendmsg; passed to sendmsg using the msg_control field.
> > + */
> > +struct homa_sendmsg_args {
> > +     /**
> > +      * @id: (in/out) An initial value of 0 means a new request is
> > +      * being sent; nonzero means the message is a reply to the given
> > +      * id. If the message is a request, then the value is modified to
> > +      * hold the id of the new RPC.
> > +      */
> > +     uint64_t id;
>
> Please use Linux uapi types, __u64

Done. In the process I discovered that the underlying type for __u64
is not the same as that for uint64_t; this results in awkwardness in
programs that use both...

> > +/** define SO_HOMA_RCVBUF - setsockopt option for specifying buffer re=
gion. */
> > +#define SO_HOMA_RCVBUF 10
> > +
> > +/** struct homa_rcvbuf_args - setsockopt argument for SO_HOMA_RCVBUF. =
*/
> > +struct homa_rcvbuf_args {
> > +     /** @start: First byte of buffer region. */
> > +     void *start;
>
> I'm not sure if pointers are legal in uAPI.
> I *think* we are supposed to use __aligned_u64, because pointers
> will be different size for 32b binaries running in compat mode
> on 64b kernels, or some such.

I see that "void *" is used in the declaration for struct msghdr
(along with some other pointer types as well) and struct msghdr is
part of several uAPI interfaces, no?

> > +/**
> > + * define HOMA_FLAG_DONT_THROTTLE - disable the output throttling mech=
anism:
> > + * always send all packets immediately.
> > + */
>
> Also makes kernel-doc unhappy:
>
> include/uapi/linux/homa.h:159: warning: expecting prototype for HOMA_FLAG=
_DONT_THROTTLE - disable the output throttling mechanism(). Prototype was f=
or HOMA_FLAG_DONT_THROTTLE() instead

It seems that the ":" also confuses kernel-doc. I've worked around this as =
well.

> Note that next patch adds more kernel-doc warnings, you probably want
> to TAL at those as well. Use
>
>   ./scripts/kernel-doc -none -Wall $file

Hmm, I did run kernel-doc before posting the patch, but maybe I missed
some stuff. I'll take another look. There are a few things kernel-doc
complained about where the requested documentation would add no useful
information; it would just end up repeating what is already obvious
from the code. Is any discretion allowed for cases like this? If the
expectation is that there will be zero kernel-doc complaints, then
I'll go ahead and add the useless documentation.

> > +#ifdef __cplusplus
> > +}
> > +#endif
> --
> pw-bot: cr

I'm not sure what "pw-bot: cr" means; I assume this is related to the
"#ifdef __cplusplus" discussion above?

Thanks for the comments.

-John-

