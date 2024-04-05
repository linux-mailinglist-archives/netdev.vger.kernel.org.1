Return-Path: <netdev+bounces-85053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4FF899282
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 02:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD6E1C21664
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 00:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457D4393;
	Fri,  5 Apr 2024 00:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7EJLlwX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDF1185E;
	Fri,  5 Apr 2024 00:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712276016; cv=none; b=RY/uOZsAzGlwLlIEKhB+y4HD5EbN82pegGDEPEcumkg3mJnsTlTnBOcke2Cixq6c3G9UZuWi0xJq5BAX6nS61+cU9/gikxZ5NxrtOmIxLzhPjf1mIHZJvZHRn2pLy1HgViak4x8eBQyIRaGNozzJfAtYpRW1FqECp+sTWULPHOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712276016; c=relaxed/simple;
	bh=aYcNk1K/ICwidZexakaP0dA9+tVqluQB/biKSaxzonQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItzwG/5uKaJM3zSNW+KMtDZXVtPuaKHBQO171iUz5Bp0RY3BqoqF2zHAadX569RbZR+44OeNf6PJWQGnG5ziac62pnWqt60PExscFTegvwoXZcx8T6XvlLremJ5RQ+cDJl1IIliLK3vw0+56sWtmlBXBM+EY+cvPyPKY2ISuGpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7EJLlwX; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56b0af675deso1821628a12.1;
        Thu, 04 Apr 2024 17:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712276013; x=1712880813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDQ0AI+9sTgw7Asa/hXBXLhuxdgG1OjxAuphEolhA+Q=;
        b=C7EJLlwXyNDFH1IHQ1gJq79T5LKXowQIZehc/P5v4nlfDDGE36w/F6UMv3FoTAB59C
         3FlTEzoEgo9n2VQi51TQiYPty8zwiZe95krrZqn87Ggrwbr4JUxwxnmE/fieqzLMUWBO
         ZoQWgVE2JQ/L0T/dPWf8lSdRWNx9vhXFubkAqv8jXAX80HVa6l4zY+slHtADWGm0/s5k
         jjcoruvdq4VZ3LHWtG6DwBUcrEmlHzDfrKqNkHk00Qb8S6X8zuBElEhfkBgFVgu/SCsl
         YqSrgFRFpImv0MCc1j7fPFB3Xx5KS8OgT2LMWTBDuMq4S40tLtcIVBuqXt1/w/YKlt3u
         2HeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712276013; x=1712880813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDQ0AI+9sTgw7Asa/hXBXLhuxdgG1OjxAuphEolhA+Q=;
        b=Y0l2tJfXJChKWsnUkR4vZJckj5zKE6lP84Zz32NzYxIMQJQSuua9gP34wB/O+GRUHf
         I2P3EjtQ7E24FH00TmUgX8NkmNbJL953bG0B6N41Ghm7iAo19gCvppyJVb5FBULpgSzo
         Y3pJfYorZv+n0OA7VKUZqIuAJoY5dO8GKwlbA4WLCj+XD+xOG17+9tHu8Dwu521ycDHp
         smqEljGF8AjwCOYP6peDIPy2+Nztov6tkByyz6LbHbUoQozQNNnGRf8g/i46U1KvuPjE
         yLnMCQcjm2NEv/Jp/kozibqJCUU5A6S5nBCJt/8lDaipCX5f3mI6qhFb4FAuZaynlX1+
         W1hA==
X-Forwarded-Encrypted: i=1; AJvYcCU5IsZnNTl67+n2vNSNKaFvOvI3Gy9ewWCxDXDgqYQ5OhPaO6rHkHOtPl69L0f3rL7VECkZB6ETZ+TyyOg53SmuQU/H6zIV7H0DfZvCf0a1NyRmN2FKAwDh++v9DDLrMUx/pSdti75i2Z61
X-Gm-Message-State: AOJu0YwalcOeu1kcbTqcwj/qqPEN0dfcdbqAPM3NfHlLXwtYveSInCsg
	xt0lDNaqh2AcYwsnpeRx6+xgh3EU9aiedK20mwqHAekAw3HGyrNA1xx4FRZriWRSWbagZlA7C11
	X7zztRoOfktGvcyRCteno1cCBzGk=
X-Google-Smtp-Source: AGHT+IH6Q81Un2FH3uF8VE7T4Unxxqeh2qFkaxrnOGFKzV+Z878Eu+hE3fshL8FUJXx6nwSAhwbmRHlSvUGQ+Z7jBEc=
X-Received: by 2002:a17:907:6d0a:b0:a4e:676f:c34b with SMTP id
 sa10-20020a1709076d0a00b00a4e676fc34bmr929711ejc.61.1712276012643; Thu, 04
 Apr 2024 17:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404072047.11490-1-kerneljasonxing@gmail.com>
 <20240404072047.11490-6-kerneljasonxing@gmail.com> <d8fe5d37-e317-59a5-9a01-d7c6ae43be7b@kernel.org>
In-Reply-To: <d8fe5d37-e317-59a5-9a01-d7c6ae43be7b@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 5 Apr 2024 08:12:55 +0800
Message-ID: <CAL+tcoCDTEov0YkeZD7B0v=TQEsfs9LtGiOge71UxUaPzWA9kQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/6] mptcp: support rstreason for passive reset
To: Mat Martineau <martineau@kernel.org>
Cc: edumazet@google.com, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	rostedt@goodmis.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	matttbe@kernel.org, geliang@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Mat,

On Fri, Apr 5, 2024 at 4:33=E2=80=AFAM Mat Martineau <martineau@kernel.org>=
 wrote:
>
> On Thu, 4 Apr 2024, Jason Xing wrote:
>
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > It relys on what reset options in MPTCP does as rfc8684 says. Reusing
> > this logic can save us much energy. This patch replaces all the prior
> > NOT_SPECIFIED reasons.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> > net/mptcp/subflow.c | 26 ++++++++++++++++++++------
> > 1 file changed, 20 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index a68d5d0f3e2a..24668d3020aa 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -304,7 +304,10 @@ static struct dst_entry *subflow_v4_route_req(cons=
t struct sock *sk,
> >
> >       dst_release(dst);
> >       if (!req->syncookie)
> > -             tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NO=
T_SPECIFIED);
> > +             /* According to RFC 8684, 3.2. Starting a New Subflow,
> > +              * we should use an "MPTCP specific error" reason code.
> > +              */
> > +             tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_MP=
TCP_RST_EMPTCP);
>
> Hi Jason -
>
> In this case, the MPTCP reset reason is set in subflow_check_req(). Looks
> like it uses EMPTCP but that isn't guaranteed to stay the same. I think i=
t
> would be better to extract the reset reason from the skb extension or the
> subflow context "reset_reason" field.

Good suggestions :)

>
>
> >       return NULL;
> > }
> >
> > @@ -371,7 +374,10 @@ static struct dst_entry *subflow_v6_route_req(cons=
t struct sock *sk,
> >
> >       dst_release(dst);
> >       if (!req->syncookie)
> > -             tcp6_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_N=
OT_SPECIFIED);
> > +             /* According to RFC 8684, 3.2. Starting a New Subflow,
> > +              * we should use an "MPTCP specific error" reason code.
> > +              */
> > +             tcp6_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_M=
PTCP_RST_EMPTCP);
>
> Same issue here.

Got it.

>
> >       return NULL;
> > }
> > #endif
> > @@ -778,6 +784,7 @@ static struct sock *subflow_syn_recv_sock(const str=
uct sock *sk,
> >       bool fallback, fallback_is_fatal;
> >       struct mptcp_sock *owner;
> >       struct sock *child;
> > +     int reason;
> >
> >       pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, lis=
tener->conn);
> >
> > @@ -833,7 +840,8 @@ static struct sock *subflow_syn_recv_sock(const str=
uct sock *sk,
> >                */
> >               if (!ctx || fallback) {
> >                       if (fallback_is_fatal) {
> > -                             subflow_add_reset_reason(skb, MPTCP_RST_E=
MPTCP);
> > +                             reason =3D MPTCP_RST_EMPTCP;
> > +                             subflow_add_reset_reason(skb, reason);
> >                               goto dispose_child;
> >                       }
> >                       goto fallback;
> > @@ -861,7 +869,8 @@ static struct sock *subflow_syn_recv_sock(const str=
uct sock *sk,
> >               } else if (ctx->mp_join) {
> >                       owner =3D subflow_req->msk;
> >                       if (!owner) {
> > -                             subflow_add_reset_reason(skb, MPTCP_RST_E=
PROHIBIT);
> > +                             reason =3D MPTCP_RST_EPROHIBIT;
> > +                             subflow_add_reset_reason(skb, reason);
> >                               goto dispose_child;
> >                       }
> >
> > @@ -875,13 +884,18 @@ static struct sock *subflow_syn_recv_sock(const s=
truct sock *sk,
> >                                        ntohs(inet_sk((struct sock *)own=
er)->inet_sport));
> >                               if (!mptcp_pm_sport_in_anno_list(owner, s=
k)) {
> >                                       SUBFLOW_REQ_INC_STATS(req, MPTCP_=
MIB_MISMATCHPORTACKRX);
> > +                                     reason =3D MPTCP_RST_EUNSPEC;
>
> I think the MPTCP code here should have been using MPTCP_RST_EPROHIBIT.

I'll update in the V2 of the patch.

Thanks,
Jason

