Return-Path: <netdev+bounces-202201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D0FAECA60
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 23:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FBF53BC071
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 21:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236E426560D;
	Sat, 28 Jun 2025 21:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="f1CaOY3l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA4C1D5154
	for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751146033; cv=none; b=txZInwr+p2/xG7dazi2ijZ+Ytih5bqL1rur/R9nGS2pHt4QzuuwzgndNd7fKH4Rz7ynLWkLoRqJ6ZJGtYLXG3dCiDUSC/oekbGet8FdaqCV8LDy6NAz4p8carnM+FIJGkbHgpE2wWA8Rrcae0YynbxY2QSgpq7XEAQeCiiZZKZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751146033; c=relaxed/simple;
	bh=K/9woK+3OKPZ5PJQuqxlpUZo120MIGwhjZzob4Ko8LM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4OLEnencULElRmM/nYZa2ymWi64URxHkfE4YvpvYKQEVLqM5TsTs55MByaQePPa0u0qWpUArWUOkZ3LGSuAamrhFS68mkhw+ENSLHZjEJpr8WqSUZH/UqnNJtGDuCNVPL7bLuRg2GR9oszc6w70hTHxnOGOxGNHshLapPT5xE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=f1CaOY3l; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so3357071b3a.1
        for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 14:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751146031; x=1751750831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRLlVts1Vo6GJ9j4jfNZitZx8cD9XywBMJ7P1rIiQlU=;
        b=f1CaOY3lTM2s+OviWBX5Qw9kYLZshgPChY5mbbIu2T2C9Z+JuJJa4JCJLt4Dr3mVua
         55kRuWmn2DMkkarCW/ZaLtXUCX6PXZaa22uyYBgy8jOnfDabtGjs5fQgcYL+i3yI7Z0R
         mipLoKnEMA5WXEoaDXKU5s0+pCD7CQML7aiIKknLYbHW9VIIq1zwT2IheODC+bYmz44N
         pR+3q5EVxpnxXzyLCFj//DTRr5ONF92cFjhwRs8TqNdzDyV4CfuKCezgvD/IPmEW5jJa
         8SmShIEBqD7imlCGzo9aZfkJyc/gAArp9jR7b3+vG/SAXGIkfyD2fbnqocRF2GPUaB27
         zPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751146031; x=1751750831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRLlVts1Vo6GJ9j4jfNZitZx8cD9XywBMJ7P1rIiQlU=;
        b=JWZ92gR441iAMECJWx7vCWnKUPIUiTYYMBckmwTZRbycEiPlpdmgzE2p5FZAKii1xJ
         D94JLTAEWUNezITKZJ5dZlAANGKE0tuzdI3QDfx6jnp/ilENfhQ2E1yKgXmX9lh/8sJ4
         AyWmB2HggB1J7o2lp/y25ikBzDBaqkezPMZtri2GwDilZJPcg5spLehouG6TsK2VwTlH
         Q/Q7w51sCur+t8Atua7mObuyhuEKKkN8AD734y4W30TyocvkJUoCyGUCZnqt1qIY1cyr
         G0X0IIxZ83rXCXW+0Hm+GPvW7CNre/xfx0mjBMRWa7wtz1Ap7ffaoi9/jKmjNxwDDVwt
         j1BA==
X-Forwarded-Encrypted: i=1; AJvYcCW7IXc+1KtDMZgjiYWKUqjv5P8hLv7UNIAgQkkhMKixaAnnSbm5Cp/HnweFimF1bc5bNgVdo1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY0RpiCpm9bFt7lX9F1XRL/ECVqh15SIMzqo9wDZhq9PqAUIFV
	BBzLjtQbrQHD0nTGtt8Uz5im50Mag/QM28NHRSKr3vtdyz1xCTIGx3jf/I5tJOAd46A464JzIrj
	lnMrTmqLqEqInn+LfNY/SXRG2he27IC+HK8UXRwx4iLqal8nvKk7eRA==
X-Gm-Gg: ASbGncuct4zQxFZoPvndaJGwW6PtQZOztBf+Ho/QpwaKDS+4+gOrgSBUWxjIiOmu56J
	KtQfruOz/BIQyKL5wLnr6YB0dDcbPcp7OOKqwBuQ8Rh+ix4JtpCbJuNAle/WiVuPuoB/UjWofRr
	H2aKe+aTORAmYRE+FLXJJVOSs3ttr9fUQgTgFXTDN2kA==
X-Google-Smtp-Source: AGHT+IFOTjXZ6Bmw82mBiul5HkvYQwk60Te4+lljpdW+4etQrPZtIb3mM72WBrb0lcBigqxeOtnW+m3F5qgkCvA+O8w=
X-Received: by 2002:a05:6a00:944c:b0:748:e289:6bc with SMTP id
 d2e1a72fcca58-74af78a2523mr9537778b3a.1.1751146030636; Sat, 28 Jun 2025
 14:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE1YQVoTz5REkvZWzq_X5f31Sr6NzutVCxxmLfWtmVZkjiingA@mail.gmail.com>
 <CAM_iQpV8NpK_L2_697NccDPfb9SPYhQ7BT1Ssueh7nT-rRKJRA@mail.gmail.com>
 <CAM_iQpXVaxTVALH9_Lki+O=1cMaVx4uQhcRvi4VcS2rEdYkj5Q@mail.gmail.com>
 <CAM_iQpVi0V7DNQFiNWWMr+crM-1EFbnvWV5_L-aOkFsKaA3JBQ@mail.gmail.com>
 <CAM0EoMm4D+q1eLzfKw3gKbQF43GzpBcDFY3w2k2OmtohJn=aJw@mail.gmail.com>
 <CAM0EoMkFzD0gKfJM2-Dtgv6qQ8mjGRFmWF7+oe=qGgBEkVSimg@mail.gmail.com> <CAE1YQVq=FmrGw56keHQ2gEGtrdg3H5Nf_OcPb8_Rn5NVQ4AoHg@mail.gmail.com>
In-Reply-To: <CAE1YQVq=FmrGw56keHQ2gEGtrdg3H5Nf_OcPb8_Rn5NVQ4AoHg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 28 Jun 2025 17:26:59 -0400
X-Gm-Features: Ac12FXzkvBOUitOXLbxnnBrhI_88xH3aJRADIACWUT0a2g92a3PxgqDUEqS3CE8
Message-ID: <CAM0EoMnv6YAUJVEFx2mGrP75G8wzRiN+Z=hSfRAz8ia0Fe4vBw@mail.gmail.com>
Subject: Re: Use-after-free in Linux tc subsystem (v6.15)
To: Mingi Cho <mgcho.minic@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, security@kernel.org, 
	Jiri Pirko <jiri@resnulli.us>, Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 1:11=E2=80=AFAM Mingi Cho <mgcho.minic@gmail.com> w=
rote:
>
> On Fri, Jun 20, 2025 at 8:24=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Wed, Jun 18, 2025 at 4:17=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > On Mon, Jun 16, 2025 at 9:03=E2=80=AFPM Cong Wang <xiyou.wangcong@gma=
il.com> wrote:
> > > >
> > > > On Sun, Jun 15, 2025 at 10:02=E2=80=AFPM Cong Wang <xiyou.wangcong@=
gmail.com> wrote:
> > > > >
> > > > > On Thu, Jun 12, 2025 at 2:18=E2=80=AFPM Cong Wang <xiyou.wangcong=
@gmail.com> wrote:
> > > > > >
> > > > > > Hi Mingi,
> > > > > >
> > > > > > Thanks for your report!
> > > > > >
> > > > > > I won't have time to look into this until this Sunday, if you o=
r
> > > > > > anyone else have
> > > > > > time before that, please feel free to work on a patch. Otherwis=
e, I will take a
> > > > > > look this Sunday.
> > > > >
> > > > > I am testing the attached patch, I will take a deeper look tomorr=
ow.
> > > >
> > > > It is more complicated than I thought. I think we need to rollback =
all
> > > > the previous enqueue operations, but it does not look pretty either=
.
> > > >
> > > > Jamal, do you like the attached fix? I don't have any better ideas
> > > > so far. :-/
> > > >
> > >
> > > I just got back - let me look at it tomorrow. Immediate reaction is i
> > > would suspect netem
> >
> > Spent time yesterday and there are two potential approaches
> > (attached), both of which fix the issue but i am not satisfied with
> > either.
> >
> > The root cause being exploited here is there are some qdisc's whose
> > peek() drops packets - but given peek() doesnt return a code, the
> > parent is unaware of what happened.
> >
> > drr_fix.diff
> > avoids making a class active  by detecting whether drr_qlen_notify was
> > called between after enqueue (even though that enqueue succeeded), in
> > that case, returns a NET_XMIT_SUCCESS | __NET_XMIT_BYPASS which ensure
> > we don't add the class to drr.
> >
> > This fixes the UAF but it would require an analogous fix for other
> > qdiscs with similar behavior (ets, hfsc, ...)
> >
> > qfq_netem_child_fix.diff
> > piggy backs on your tbf patch and detects whether
> > qdisc_tree_reduce_backlog was called after qfq's peeked its child
> > (netem in this repro) in enqueue.
> > This would also require fixing other qdiscs.
> >
> > TBH, while both approaches fix the UAF, IMO they are short term hacks
> > and i am sure Mingi and co will find yet another way to send netlink
> > messages to config a _nonsensical hierarchy of qdiscs_ (as was this
> > one!) to create yet another UAF.
> >
> > My suggestion is we go back to a proposal i made a few moons back:
> > create a mechanism to disallow certain hierarchies of qdiscs, ex in
> > this case disallow qfq from being the ancestor of "qdiscs that may
> > drop during peek" (such as netem). Then we can just keep adding more
> > "disallowed configs" that will be rejected via netlink.
> > And TBH, i feel like obsoleting qfq altogether - the author doesnt
> > even respond to emails.
> >
> > cheers,
> > jamal
>
> Hello,
>
> I think the testcase I reported earlier actually contains two
> different bugs. The first is returning SUCCESS with an empty TBF qdisc
> in tbf_segment, and the second is returning SUCCESS with an empty QFQ
> qdisc in qfq_enqueue.
>

Please join the list where a more general solution is being discussed here:
https://lore.kernel.org/netdev/aF847kk6H+kr5kIV@pop-os.localdomain/

cheers,
jamal
> The first bug is present in TBF qdisc, so the UAF is also triggered
> when using a qdisc other than QFQ. Below is a POC that shows how the
> TBF qdisc can be made empty by using a CHOKE qdisc instead of a QFQ.
>
> #define _GNU_SOURCE
>
> #include <arpa/inet.h>
> #include <fcntl.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <linux/udp.h>
>
> #ifndef SOL_UDP
> #define SOL_UDP 17 // UDP protocol value for setsockopt
> #endif
>
> void loopback_send (uint64_t size) {
>     struct sockaddr iaddr =3D { AF_INET };
>     char data[0x1000] =3D {0,};
>
>     int inet_sock_fd =3D socket(PF_INET, SOCK_DGRAM, 0);
>
>     int gso_size =3D 1300;
>
>     setsockopt(inet_sock_fd, SOL_UDP, UDP_SEGMENT, &gso_size, sizeof(gso_=
size));
>
>     connect(inet_sock_fd, &iaddr, sizeof(iaddr));
>
>     write(inet_sock_fd, data, size);
>
>     close(inet_sock_fd);
> }
>
> int main(int argc, char **argv) {
>     system("ip link set dev lo up");
>     system("ip link set dev lo mtu 1500");
>
>     system("tc qdisc add dev lo root handle 1: drr");
>     system("tc filter add dev lo parent 1: basic classid 1:1");
>     system("tc class add dev lo parent 1: classid 1:1 drr");
>     system("tc class add dev lo parent 1: classid 1:2 drr");
>
>     system("tc qdisc add dev lo parent 1:1 handle 2: tbf rate 1Mbit
> burst 1514 latency 50ms");
>
>     system("tc qdisc add dev lo parent 2:1 handle 3: choke limit 2
> bandwidth 1kbit min 1 max 2 burst 1");
>
>     loopback_send(2000);
>
>     system("tc class del dev lo classid 1:1");
>
>     system("timeout 0.1 ping -c 1 -W0.01 localhost > /dev/null");
> }
>
> My opinion is that creating separate patches for each bug would be an
> easier way to approach the problem.
>
> I tested the suggested patch and found some possible issues.
>
> diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> index bf1282cb22eb..6d85da21c4b8 100644
> --- a/net/sched/sch_qfq.c
> +++ b/net/sched/sch_qfq.c
> @@ -1258,7 +1258,17 @@ static int qfq_enqueue(struct sk_buff *skb,
> struct Qdisc *sch,
>     agg =3D cl->agg;
>     /* if the class is active, then done here */
>     if (cl_is_active(cl)) {
> -       if (unlikely(skb =3D=3D cl->qdisc->ops->peek(cl->qdisc)) &&
> +       const u32 pre_peek_backlog =3D sch->qstats.backlog;
> +
> +       skb =3D cl->qdisc->ops->peek(cl->qdisc);
> +       /* Address corner case where a child qdisc dropped the packet
> +        * in peek after enqueue returned success.
> +        * Qdiscs like netem may exhibit this behaviour.
> +        */
> +       if (unlikely(sch->qstats.backlog < pre_peek_backlog))
> +           return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> +
> +       if (unlikely(skb) &&
>             list_first_entry(&agg->active, struct qfq_class, alist)
>             =3D=3D cl && cl->deficit < len)
>             list_move_tail(&cl->alist, &agg->active);
>
> First, in the proposed patch, the peek function of qfq_enqueue checks
> qstats.backlog to know if a packet has been dropped. However, since
> qstats.backlog decreases during the normal peek process, it would be
> better to use the q.qlen.
>
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index c5e3673aadbe..10fb72fef98e 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -814,6 +814,11 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch,
> int n, int len)
>             WARN_ON_ONCE(parentid !=3D TC_H_ROOT);
>             break;
>         }
> +
> +       if (unlikely((!sch->q.qlen && n) ||
> +                (!sch->qstats.backlog && len)))
> +           continue;
> +
>         cops =3D sch->ops->cl_ops;
>         if (notify && cops->qlen_notify) {
>             cl =3D cops->find(sch, parentid);
>
> Also, if the qdisc_tree_reduce_backlog function excludes cases where
> qlen is 0, as in the above patch, the normal tbf qdisc features may
> not work.
>
> static int tbf_segment(struct sk_buff *skb, struct Qdisc *sch,
>                struct sk_buff **to_free)
> ...
>     sch->q.qlen +=3D nb;
>     sch->qstats.backlog +=3D len;
>     if (nb > 0) {
>         qdisc_tree_reduce_backlog(sch, 1 - nb, prev_len - len);
>         consume_skb(skb);
>         return NET_XMIT_SUCCESS;
>     }
>
> For example, qlen can be 0 when calling qdisc_tree_reduce_backlog on
> tbf_segment in the code above.
>
> Additionally, I believe that using the peek function in the enqueue
> function can increase the complexity of qdisc and can lead to a number
> of issues. Therefore, I believe that avoiding the use of peek in the
> enqueue function will reduce the chance of introducing bugs.
>
> Thanks,
> Mingi

