Return-Path: <netdev+bounces-274672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJYbOCPBzmmqpwYAu9opvQ
	(envelope-from <netdev+bounces-274672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 21:18:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E76738D9A9
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 21:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 168753019469
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 19:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68263054C7;
	Thu,  2 Apr 2026 19:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkwsewIT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A741684B0
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 19:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775157535; cv=none; b=HXJPwFmVH4phDokOARe0jC1QYW/MJQOTj9Q/Idn5gNo90SLQ8ANKhBiPtqxwWe0qJ8EGPgTqmrDOPcoho5bjp8xieQHPCfu1Wf0dctl4qkIMIli/2LDdqwMouR+kew3UVI0s54N/GknLSGCypoqsiOe0jiD9oWQmCApXD8nhF18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775157535; c=relaxed/simple;
	bh=YL/jBhQEytgmpHJ5sh3Mfwp8SpExDCxj8HHZUzG482Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=j4bfq7bQfBRm4NNB/3w8tXmMILk02KImp7VjcrYBe5aut/kn0FP46BKJwiSHCLod84APjJn+ql27CU3itljrJfyGITPgqHKUbjguAts6iqkT60vDrpmSrPexO0fKRpVngmdR3RHmzDVAkEJfPb5GA6IUyBejQ17IEvEfG8UlnxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkwsewIT; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79a46ebe2beso12615247b3.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 12:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775157533; x=1775762333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrikcRpm5PQSE5s8od2DvUspQxDntawwaqBx+pPWqLo=;
        b=YkwsewITkLFK9ctM1fHBs+dHErJSx47UHm+xmebBOMAEsZZR4FT7Z+x+ghoETuTOFa
         q8F1jAwamDW07GZFgCXnOJxxppkWAzfvohs6N9mxyiYSpq/nllUlYbpTlIfVXNhcn912
         CjE++k50EycgbMpzy39PmpsFRKriVjG9k/em/k0ZwbzXh0L21O+2e7quFmXP+RO+yCWv
         eXzWETTZA56EsQBXNswzgt3f2z18xfGa4yDUsli5mCTB1oxOk8GZtIIBqsSrivPlce9g
         wuNali6lMTXATUXRL7XAMX8zG2a3AzI2I4omwYIUvR60aYtVaPnXLXoYQhS8TmlbQnkN
         GfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775157533; x=1775762333;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HrikcRpm5PQSE5s8od2DvUspQxDntawwaqBx+pPWqLo=;
        b=C+Z9tUaODSjU+ii8LF7Hmf9M71xorp/CqlglEyVlkTZfdk7x6OP4PbbDZ1oplb+yVN
         uZHnlemK9sfUdBUuOICagcPBAS8zi4r20NKgpjdCDwWSDNPNRKJTRJRgXLVKvH2WIVik
         ebKVC1TPS5uERG6fKblaHd+/dQ8sNaE0HAfwd+4d3qAz+IRHo+srFrissIhP6Smr5oy4
         04ep9LiMvKp1mlpsdu7043yhUxBjzvx12id7b3r+dA95yOeExO+M6ySttg711MzQjEPv
         Dgz+P19E0bqBw+VIH1YYjrY7I8V0QLNoXkyAu+gZWd56+naVyGoDFs/wpg9uYnHJOiIl
         Otrg==
X-Forwarded-Encrypted: i=1; AJvYcCXjs6sgt3Pmku0X+3lqSF0oXxxqFzELx1ZYFk5JSkN0HK/HdsK3osrOUdDcD25veu1IpGcz23o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaOW72eHlRK2thcQMkYTvpeznw/MAUAtLwzyHxEApMSsOoMQCL
	PVcNrZX14E3l150XZuTvoAsBiFmSofcld7bpjaxm/4/C1rb+hgBeGcOh
X-Gm-Gg: AeBDieucARhp/zPly8HXNbAUdJSG+lzD5ZieoC6ZViN6pYhnlU8XmsCPLeRnu1r+22d
	rV2CUF4WQ+CCTCafn5EeVMldlhrfD0sZWkGeqapA2/7UT1xie+gEBYYM+0lu6gL3zScLSOzKFEc
	ztz5xh5GxC0SxDYrNAt02CNIjRVLO8nVTHhfxgoTIEIf3Ac/67HU3ZywCKzLad0Peq7A7W61Xh4
	RyACheYA7uQ6WMV8NYeRqbC+GpwbjlMHo/1Y9j/cxWexIU/IXcsSqok4EhfBTXhT5VxU6xLHMSl
	FaEI0Bp1DL+x2mU5mwSuVZPmJE2V+bCXqv3fcDPCdyR2ETxpDVCqYGSYR/WueZJEitxR4nTGFtg
	X7304eIodcMcPQ89LkvfyIBCwQ9rCh9MQPHjFA5PrsX9xuPbIiK5/L9DRsTHgVmOEtrf0Ms/InV
	Qf6ZIN5BZqvtmC+ffhXz2Wy1IXGCfkU8HUMejEjqqX10Ga24o8nbZpIQXkzPBflqf+dSn2jJzT2
	cBl
X-Received: by 2002:a05:690c:d91:b0:79d:7525:a241 with SMTP id 00721157ae682-7a4d3ad1d5bmr6372797b3.15.1775157533338;
        Thu, 02 Apr 2026 12:18:53 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e832ef8sm13918997b3.13.2026.04.02.12.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 12:18:52 -0700 (PDT)
Date: Thu, 02 Apr 2026 15:18:52 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 willemb@google.com, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>, 
 Yushan Zhou <katrinzhou@tencent.com>
Message-ID: <willemdebruijn.kernel.672c36ae4e6f@gmail.com>
In-Reply-To: <CAL+tcoBB+d-PwNzx1ugjDwZZBaQf8vxb3XooM3ARw9CtbiFeqw@mail.gmail.com>
References: <20260402085831.36983-1-kerneljasonxing@gmail.com>
 <CANn89iK-e1=yQhN0t48Cm7ru9cYwKwBw1_DDRcVffX91s4wWNA@mail.gmail.com>
 <CAL+tcoDiyptBUch5LZuRKn5BbJK_6TcgSi91D31axRtjqpSzzw@mail.gmail.com>
 <CANn89i+J=OBqHFh3jWNVXm7QWhSDJ=PHtmMtzyBrTpOoNtmu5w@mail.gmail.com>
 <CAL+tcoBB+d-PwNzx1ugjDwZZBaQf8vxb3XooM3ARw9CtbiFeqw@mail.gmail.com>
Subject: Re: [PATCH net-next] net-timestamp: take track of the skb when
 wait_for_space occurs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-274672-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Queue-Id: 5E76738D9A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jason Xing wrote:
> On Thu, Apr 2, 2026 at 11:40=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> >
> > On Thu, Apr 2, 2026 at 8:03=E2=80=AFAM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > >
> > > On Thu, Apr 2, 2026 at 10:24=E2=80=AFPM Eric Dumazet <edumazet@goog=
le.com> wrote:
> > > >
> > > > On Thu, Apr 2, 2026 at 1:58=E2=80=AFAM Jason Xing <kerneljasonxin=
g@gmail.com> wrote:
> > > > >
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > Tag the skb in tcp_sendmsg_locked() when wait_for_space occurs =
even
> > > > > though it might not carry the last byte of the sendmsg.
> > > > >
> > > > > If we don't do so, we might be faced with no single timestamp t=
hat
> > > > > can be received by application from the error queue. The follow=
ing steps
> > > > > reproduce this:
> > > > > 1) skb A is the current last skb before entering wait_for_space=
 process
> > > > > 2) tcp_push() pushes A without any tag
> > > > > 3) A is transmitted from TCP to driver without putting any skb =
carring
> > > > >    timestamps in the error queue, like SCHED, DRV/HARDWARE.
> > > > > 4) sk_stream_wait_memory() sleeps for a while and then returns =
with an
> > > > >    error code. Note that the socket lock is released.
> > > > > 5) skb A finally gets acked and removed from the rtx queue.
> > > > > 6) continue with the rest of tcp_sendmsg_locked(): it will jump=
 to(goto)
> > > > >    'do_error' label and then 'out' label.
> > > > > 7) at this moment, skb A turns out to be the last one in this s=
end
> > > > >    syscall, and miss the following tcp_tx_timestamp() opportuni=
ty before
> > > > >    the final tcp_push
> > > > > 8) application receives no timestamps this time
> > > > >
> > > > > The original commit ad02c4f54782 ("tcp: provide timestamps for =
partial writes")
> > > > > says it is best effort. Now it's time to cover the only potenti=
al point
> > > > > to avoid missing record.
> > > > >
> > > > > The side effect is obvious that we might record more than one t=
ime for a
> > > > > single send syscall since the skb that we keep track of in this=
 scenario
> > > > > might not be the last one. But tracing more than one skb is not=
 a bad
> > > > > thing since there is an emerging/promissing trend to do a detai=
led
> > > > > packet granularity monitor.
> > > >
> > > > This is rather weak/lazy, especially if you do not know how long =
the
> > > > thread is put to sleep?
> > >
> > > Thanks for the review!
> > >
> > > I actually thought about how to recognize which one should be the l=
ast
> > > skb in each send syscall. But it turns out that much more complicat=
ed
> > > work needs to be done which hurts the stack and common structures l=
ike
> > > tcp_sock. That's why I gave up and instead chose a much simpler way=
 to
> > > minimize the impact.
> > >
> > > >
> > > > >
> > > > > Thanks to the great ID, namely, tskey, application that is resp=
onsible
> > > > > for the collect/sort of timestamps leverages it to put that rec=
ord in
> > > > > between two consecutive send syscalls correctly.
> > > > >
> > > > > Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > ---
> > > > >  net/ipv4/tcp.c | 4 +++-
> > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > > index 516087c622ad..2db80d75cfa4 100644
> > > > > --- a/net/ipv4/tcp.c
> > > > > +++ b/net/ipv4/tcp.c
> > > > > @@ -1411,9 +1411,11 @@ int tcp_sendmsg_locked(struct sock *sk, =
struct msghdr *msg, size_t size)
> > > > >  wait_for_space:
> > > > >                 set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> > > > >                 tcp_remove_empty_skb(sk);
> > > > > -               if (copied)
> > > > > +               if (copied) {
> > > > > +                       tcp_tx_timestamp(sk, &sockc);
> > > > >                         tcp_push(sk, flags & ~MSG_MORE, mss_now=
,
> > > > >                                  TCP_NAGLE_PUSH, size_goal);
> > > > > +               }
> > > > >
> > > > >                 err =3D sk_stream_wait_memory(sk, &timeo);
> > > > >                 if (err !=3D 0)
> > > >
> > > > I think non blocking model should be used by modern applications,=

> > > > especially ones caring about timestamps.
> > >
> > > Please note that BPF timestamping has already been merged. It's a
> > > standalone script that monitors all kinds of flows and discovers th=
ose
> > > strange/unexpected behaviors. So we normally don't take a look at t=
he
> > > implementation of each application before spotting any exceptions.
> > >
> > > Besides, sometimes monitoring the latency of the host doesn't have
> > > much to do with the mode of application. People might want to obser=
ve
> > > more deeper into the underlying layer. Right now, without the patch=
,
> > > the monitor possibly ends up missing the record of this send syscal=
l,
> > > which has been reliably reproduced by Yushan.
> > >
> > > >
> > > > This patch has performance implications.
> > > >
> > > >  tcp_tx_timestamp() is quite big and was inlined because it had a=
 single caller.
> > > >
> > > > After this patch, it is no longer inlined.
> > > >
> > > > scripts/bloat-o-meter -t vmlinux.before vmlinux.after
> > > > add/remove: 2/0 grow/shrink: 0/1 up/down: 239/-192 (47)
> > > > Function                                     old     new   delta
> > > > tcp_tx_timestamp                               -     223    +223
> > > > __pfx_tcp_tx_timestamp                         -      16     +16
> > > > tcp_sendmsg_locked                          4560    4368    -192
> > > > Total: Before=3D29652698, After=3D29652745, chg +0.00%
> > >
> > > That's right and I really appreciate your recent great effort tryin=
g
> > > to mitigate the impact of function calls.
> > >
> > > My take is that it is a trade off. Adding one more track of the skb=

> > > (which adds a function call) actually doesn't hurt much especially =
for
> > > this scenario and the last skb scenario. This path basically is not=

> > > that hot. There are some left things to be done to improve the
> > > socket/BPF timestamping feature. And I plan to push more patches
> > > (sure, very carefully) to enhance the ability of BPF timestamping t=
o
> > > observe TCP which is inevitable to add some extra functions and if
> > > statements.
> > >
> > > I'm wondering if the above makes sense to you.
> >
> > If you mostly care about BPF, I would suggest:
> =

> For me, yes, I've been internally working on this stuff for a long
> while and still struggling with what part is worth upstreaming. I'm
> not sure how Willem thinks of the socket timestamping feature.

I think it's fine to move forward with BPF only features. We can make
that call on a case-by-case basis.=

