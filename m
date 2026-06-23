Return-Path: <netdev+bounces-301481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BtQcBD7uOmq6LwgAu9opvQ
	(envelope-from <netdev+bounces-301481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:36:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E146BA0D1
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:36:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=UBpCpzx8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301481-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301481-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 28B793006801
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F4F3A6B9C;
	Tue, 23 Jun 2026 20:36:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F733A6417
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 20:36:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246967; cv=none; b=V0JMQ9dt2x9zFIydXPbqcmVPv69yQFraLHODGCErkZFf0DQ8kKXDSx8IrVHlPVZdSLTr3vBKxYjVQQv6t4ZmKojYydRrKS+JVuGrE59HNqIYWITBysjzHG35GyWdJb2bQaOTKIEgyWmAq7MKD47AFBqyt+o7d8BR2WRI0SbB604=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246967; c=relaxed/simple;
	bh=/GRGD1MLD4X5/6xzuqcyhlzMs7a2/Xib0LBHx4kotfU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S2jswhI9JlbvTaYNFUjlo5qVm61ttrLh9ZYBi/e+9V7nACecmN80JZCQXNjveMuYl3xMDYo1s85qby078VHVS+XEnbDev9wolv/+yttWPZmne8zYWFqmTnuyo0726+XgHvLTSuvw8SbckKkawQSgclyPKZTGztV5iPcJNwpPovs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UBpCpzx8; arc=none smtp.client-ip=209.85.208.54
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6974a6e54dbso427793a12.2
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 13:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782246964; x=1782851764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpP2TgAWS6LY05FhT2gkiNjZjpsX/XmOaS8W6L/6Guw=;
        b=UBpCpzx82ReHPrbiYxd+lsYYyboAMrBhFygsPg3LAmBQRpmS6OO4CWf5qIrzHyxaBo
         2c8Z1MviLoEkDxi5t/hyuz1ZgFozfMO4gFLSqngf6Kykg6AGHAzr4EV3IXVnLoAJyYM+
         zFEv0nCnHFvsR9MMdLtZUdEDxaX0yOsQeNA3PodV7qx46PnC47HicKsLgaKsQ1moN1bJ
         mqoxjrPDPQ3g0nZVGYIav5WWjThsFMQWFthEfJCa4B5virf5i7NMA+Q9l5qkmtjp6H77
         vilRyiCpFwp/4JDYmfI0UZpj5bnNQ2rSzZJAu2K4oaaGRAbmDOcAxgqWRtt3XwliYI5S
         mu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782246964; x=1782851764;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zpP2TgAWS6LY05FhT2gkiNjZjpsX/XmOaS8W6L/6Guw=;
        b=Ho7mvM1p2+nrluyQktOBUtXaHJHlp1E4vyYP7qUpz+WMVdL+heaXDcj4pij9QhBiGj
         5m9fNmvYfne8m3QG3cSQGJjzs5BkqxdTscMPskosWV3zqeDH6uYC3aoTGjJVGkS7nKQW
         BV3vtX0XT8pDBX6BgtOH8Me4F9m0IxU6aIFIdPGa2s2/azOWf/ztsSOIam4aZXdaVl13
         rB4W0SFdOuw/TXOY8yOoy+dzYPE3h7KEf+EEg1CILv1Nk2fD023xG1w7dbcyfedLc77f
         J5dWC7M7KcUwfNE9F7uAEa0WCCEUghpkZNTRlk1Oolbgw4kjCfcqDJUX8sFlxv9t8VmV
         RCyw==
X-Forwarded-Encrypted: i=1; AFNElJ+dCd77C4JVOj7RNdCz8fZMz4bS/iTuacvo5qGoQLbmXXOqQL30FROVBLkA5vAC1IdWFxRzsPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkFpxKvoiFEwsTwz7Mw4COERBQ2Jn+6hAgXUVO8aB/0eYwbRol
	tsk6C4GktojmRwbI5DpTr+C85g6euvsd01nVtp1e585QEmacCiMVfMyyHerpgBqx0eE=
X-Gm-Gg: AfdE7cnDtyslaaxK7cC0BQQWY86db015xSyXZOJEa5eLEWANpgE+YaUSS9M3Q3sxnlr
	ULjL4CtrJ7jf7gAoADPUyiea0xlj/PdPk51MeIe/oCyQS+y8AP1c73nvaUFiEvoJAR9uAccPO36
	xyM2+T8qBVfRyexnUFptsLe7T0jc8c8jX9Et5PHq5m12Q3xeeXcn3/FtneTGOMjyAxWNsZ9OjPe
	Q0pkoTX/pMd9b/2WboYpKZ++w/IRGV3cZ/BzkwmbH3rvBBV8/jao588FZoSCEWRnjUantbQ6og4
	dSIPX+7lUMLweRT2GMM/Z5Art/iKue5wqaJjw/FM6aeThXgyhabHwhXFtMXu0fM+RkYH6qYxwDR
	Bxg3IHOPnX2Le4XleMou8Yn5rbGtF7mHSbRHUinYx20SpX1aa+F+ynDqHYcn2Mm4qT9bK4VoGdM
	EwKQsQG0XD281E8o/upKTYVH5IjA==
X-Received: by 2002:a05:6402:538c:b0:697:8341:9e40 with SMTP id 4fb4d7f45d1cf-697f376fe8cmr98020a12.5.1782246964455;
        Tue, 23 Jun 2026 13:36:04 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bc8016sm16312a12.25.2026.06.23.13.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 13:36:04 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,  Kuniyuki Iwashima
 <kuniyu@google.com>,  bpf <bpf@vger.kernel.org>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Jiayuan Chen <jiayuan.chen@linux.dev>,  John Fastabend
 <john.fastabend@gmail.com>,  Network Development <netdev@vger.kernel.org>,
  kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code
 behind CONFIG_NET_SOCK_MSG
In-Reply-To: <CAMB2axMVhJJpP5HZtDFyQLLbKoRxhW08rj1zGRtWtgDkfYaVNA@mail.gmail.com>
	(Amery Hung's message of "Tue, 23 Jun 2026 13:22:38 -0700")
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
	<CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
	<87v7b9ysep.fsf@cloudflare.com>
	<CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
	<CAADnVQL2pfQ0BoN-vWcuCpbOBBKq_rM7Bp7P4XdLMFER5LGSDg@mail.gmail.com>
	<87mrwlyqg4.fsf@cloudflare.com>
	<CAMB2axMVhJJpP5HZtDFyQLLbKoRxhW08rj1zGRtWtgDkfYaVNA@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Tue, 23 Jun 2026 22:36:02 +0200
Message-ID: <878q85yoy5.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,cloudflare.com];
	TAGGED_FROM(0.00)[bounces-301481-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ameryhung@gmail.com,m:alexei.starovoitov@gmail.com,m:kuniyu@google.com,m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:kuba@kernel.org,m:jiayuan.chen@linux.dev,m:john.fastabend@gmail.com,m:netdev@vger.kernel.org,m:kernel-team@cloudflare.com,m:alexeistarovoitov@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:from_smtp,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid,cloudflare.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04E146BA0D1

On Tue, Jun 23, 2026 at 01:22 PM -07, Amery Hung wrote:
> On Tue, Jun 23, 2026 at 1:04=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.=
com> wrote:
>>
>> On Tue, Jun 23, 2026 at 12:33 PM -07, Alexei Starovoitov wrote:
>> > On Tue, Jun 23, 2026 at 12:31=E2=80=AFPM Kuniyuki Iwashima <kuniyu@goo=
gle.com> wrote:
>> >>
>> >> On Tue, Jun 23, 2026 at 12:21=E2=80=AFPM Jakub Sitnicki <jakub@cloudf=
lare.com> wrote:
>> >> >
>> >> > On Tue, Jun 23, 2026 at 09:08 AM -07, Kuniyuki Iwashima wrote:
>> >> > > On Tue, Jun 23, 2026 at 4:20=E2=80=AFAM Jakub Sitnicki <jakub@clo=
udflare.com> wrote:
>> >> > >>
>> >> > >> Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MSG.=
 When
>> >> > >> completed all code paths related to sockmap-based redirects shou=
ld be
>> >> > >> guarded by BPF_SYSCALL && NET_SOCK_MSG to allow users to opt out=
 by
>> >> > >> disabling NET_SOCK_MSG. The implementation of sockmap as a conta=
iner for
>> >> > >> socket references would remain under BPF_SYSCALL.
>> >> > >>
>> >> > >> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> >> > >> ---
>> >> > >> Changes in v2:
>> >> > >> - Handle prot->recvmsg being NULL (Sashiko)
>> >> > >> - Elaborate on the end goal in description
>> >> > >> - Link to v1: https://patch.msgid.link/20260622-bpf-sk_msg-split=
-unix-v1-1-d7e0cb7bb03b@cloudflare.com
>> >> > >> ---
>> >> > >>  net/unix/af_unix.c  | 4 ++--
>> >> > >>  net/unix/unix_bpf.c | 6 ++++++
>> >> > >>  2 files changed, 8 insertions(+), 2 deletions(-)
>> >> > >>
>> >> > >> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>> >> > >> index f7a9d55eee8a..84c11c60c75f 100644
>> >> > >> --- a/net/unix/af_unix.c
>> >> > >> +++ b/net/unix/af_unix.c
>> >> > >> @@ -2675,7 +2675,7 @@ static int unix_dgram_recvmsg(struct socke=
t *sock, struct msghdr *msg, size_t si
>> >> > >>  #ifdef CONFIG_BPF_SYSCALL
>> >> > >>         const struct proto *prot =3D READ_ONCE(sk->sk_prot);
>> >> > >>
>> >> > >> -       if (prot !=3D &unix_dgram_proto)
>> >> > >> +       if (prot->recvmsg)
>> >> > >
>> >> > > There is no reason to have this dead branch when
>> >> > > CONFIG_BPF_SYSCALL && !NET_SOCK_MSG.
>> >> > >
>> >> > > Let's compile out all sockmap code when both configs
>> >> > > are not enabled.
>> >> > >
>> >> > > Since AF_UNIX differs from TCP/UDP, it can take the
>> >> > > simpler approach.
>> >> >
>> >> > Okay, will put the whole file behind hidden config option like so:
>> >> >
>> >> > --- a/net/unix/Kconfig
>> >> > +++ b/net/unix/Kconfig
>> >> > @@ -30,3 +30,8 @@ config UNIX_DIAG
>> >> >         help
>> >> >           Support for UNIX socket monitoring interface used by the =
ss tool.
>> >> >           If unsure, say Y.
>> >> > +
>> >> > +config UNIX_BPF
>> >>
>> >> Maybe UNIX_BPF_SOCKMAP or something.
>> >> bpf_iter is supported without this config.
>> >
>> > I don't like where it's going.
>> > I strongly dislike new config knobs.
>> > I'd rather remove existing knobs.
>> > What is the motivation?
>>
>> The goal is to compile out sockmap bits that use sk_msg.
>> NET_SOCK_MSG is natural, exisiting candidate.
>> New knob wasn't my idea.
>
> I'm also missing the big picture here.
>
> sockmap already holds socket references today. You can store and look
> up sockets without attaching any verdict/parser program, and no
> redirect happens. So if the goal is to use sockmap purely as a socket
> container without the sk_msg fast-path overhead, what does a
> compile-time NET_SOCK_MSG knob add over the runtime checks?

Sure, let me clarify. It's about the maintenance overhead.

sockmap-based redirects are a rather niche feature with few users, for
which we've been getting quite a few bug reports since AI came along.

We're not using it internally at Cloudflare, so I don't really have a
good reason to justify time spent on these bug reports.

Hence the move to put sockmap-based redirect behind a config option,
which you can enable at your own risk. Or which we can deprecate, but
that's not really my call.

> I am also not sure if NET_SOCK_MSG is right. It is broader than
> "sockmap redirect". It is selected by TLS and {INET,INET6}_ESPINTCP.
> Because those select it, it can't be toggled independently.

Once the sockmap redirect bits are behind _some_ config option, it will
be easy to replace it with a more granular one that depends on
NET_SOCK_MSG. But we're not there yet. One step at a time.

> Could you share the concrete use case you have in mind, and whether
> this came out of an earlier discussion or thread upstream?

This is a follow up from discussions at BPF summit with Alexei & John.

